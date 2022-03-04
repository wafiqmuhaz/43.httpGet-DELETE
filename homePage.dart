import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  static const root = "/One";

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String dataS = "belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HTTP - DELETE"),
        actions: <IconButton>[
          IconButton(
            onPressed: () async {
              var dataO = await https.get(
                Uri.parse(
                  "https://reqres.in/api/users/1",
                ),
              );
              Map<String, dynamic> isi =
                  json.decode(dataO.body) as Map<String, dynamic>;
              setState(() {
                dataS =
                    "${isi['data']["first_name"]} ${isi['data']["last_name"]}";
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Nama :\n$dataS",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                var dataO = await https.delete(
                  Uri.parse(
                    "https://reqres.in/api/users/1",
                  ),
                );
                if (dataO.statusCode == 204) {
                  setState(() {
                    dataS =
                        "Berhasil Menghapus Data";
                  });
                }
                // Map<String, dynamic> isi =
                //     json.decode(dataO.body) as Map<String, dynamic>;
              },
              child: Text("HAPUS DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
