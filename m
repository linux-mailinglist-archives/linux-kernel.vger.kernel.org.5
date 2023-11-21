Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F17F2BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKULmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjKULmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:42:40 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2043.outbound.protection.outlook.com [40.92.103.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F12210F;
        Tue, 21 Nov 2023 03:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkcnXOLpsPhGBhykTitTVf25wfg7Bqig8KwrGo+D0CWUnzRWEOWfRF8QhkIPfRw8pidV2GPYTAMmRpreQXHf5DVFx8OefI8AfBtzTzlnE3Nf0DOq9TuJJUFGjQ/y/wZ2GU65pOw5DTonGXslNZQbrPdzW3dYxKM1yYqf90/nttFxzpEnc6CmbY8KK3SzBy1j/nAsHuUETzM/9FOTuMwtqGad2VyKwhw7aeVpSPMq2yRljFYfVdD+rgmxf88SNBkeVqbL0MSSPHRbtWyRJQ8WDlIpR5pfcrDlPSfCKZDGv63Ais2fd62fy/jOegaG7UFVlmuuSxIJ8fN6kZrqIeoNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x65t/hR8xMT0zQVWfJP/d42g6NhSxft2wD9Dia/uIPA=;
 b=NATb9eN+mcZymiAZgKPMSkGMhxW17HcIzu1BJUwVQI92QPar+0yXhTx1HI5n+DUV/DM9fATho931meFqltblTGNyNVcf1UP5B74rcdInWsM5DVWqDHO3DNHVbXZU5VLGx2eF/gz9B6UbwfzIl6UEmxUT7lmTn8M3YoCXDLTvOE2mLtgPV8Fmex0rnwAtlsSHZupLCwSkBM6yAtDfFYQPcgTYfEj/FxDzOAc4c6FyKZoCGZloIB0JHmpimx8bZHKct6HrWdk3Rw09DQoBvuZkWRqU1yZD0Z/idED8PyiGmBhxBf6D+2PxvPtNZIR7uLirAfxbooH7/egnSyqij76MFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x65t/hR8xMT0zQVWfJP/d42g6NhSxft2wD9Dia/uIPA=;
 b=i/gNvPG0D7IJb5499M3MVGMPnWI/FU0OdEnYaSlfvL12jgsT3CaICmcE8uJ3OCQDKUX8KJe/wKPG7AQ8kzqxqYdZ4N6JPDfkfig+FW/GtzGG+UcmjylIlZNEDiU07UHwkQJEUtYr3UCN5zwQReoJUnLwByo6Aerl/jTaOdVscwVFKa4cpB04SnN2NN8esM10WUeoGV1oGZ0Vvq9ndaNmNdXNlDBBedM8h1gTYaqaNzSwK6IBG8iGykfJuS0kPrHr2oB2/I71egGnunTxv3Z6Iv2OXK2CuXvyz+/lQwgsmSFSNy6N6NMpUPHPbK351dIgNuGzvzhw57PSGc/fIrdcxQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB2602.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:208::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Tue, 21 Nov 2023 11:42:28 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 11:42:28 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Asahi Linux Mailing List <asahi@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        "j@jannau.net" <j@jannau.net>
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Topic: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQceAAAopgIAAEGgAgAASIACAAAuGgIAG7NMAgAKYTgCAAZwXcA==
Date:   Tue, 21 Nov 2023 11:42:28 +0000
Message-ID: <MA0P287MB0217A68FDF5E0DC22F19D3DCB8BBA@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
 <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
 <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
 <0900292C-5E74-471A-B789-A1D35D1BBBF7@live.com>
 <3b5aedb4-da00-4ae2-a60f-685dba949223@marcan.st>
In-Reply-To: <3b5aedb4-da00-4ae2-a60f-685dba949223@marcan.st>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FGnppMLrGUF5NuS5MLrxleb5FXofJ1JAVOETHhkRljQPHOsbubsy+44OrGezZQsi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB2602:EE_
x-ms-office365-filtering-correlation-id: cc7f28cc-7791-4380-ccf0-08dbea86f0a6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOY7BJr7SpYRZEXkDkJ+dqAD3GUAL3hpAckXLnY4aotWiWnd/rH33SbE65LHcQmls1bPbge0y3LlD5GnWUmefjh9cJw2Hk5+7FGg8d2X1tvw+M0tO99qCc0PRFAZk9s5sB9jAel8FQ/aMp7g4MO/ziesA8UiLhtFDicL1zKYyZck0afCup4CWsQm8ma+FuaWh+lKeorshdRd/3ATSvZdR2Dz08MUMv0KUi5o3cHRK4uLtAhcMgzNJlUjzRg/v3wncqFynGSbvH3wXIliZXZfPAGps0R++nru8NKZKdrPDmzhu1o8Cd+YBHoDu06fL9S+4dG7yHVmD0ApLT/LsGh6e/1twspvdc2HZb6wCjgysVW8r6ebguIoybpdtZvQhIKxfB7iKA7JVGpFBmFC3YNy6l5S2jZzLe972iG7/7V8vT2b0RWfYrQ1ULKPFEgoVdsmYFTwNqmNc3VTq9aEfWttCYjkAyB8Zn6EkE3PLCZ5j7qxjaFv3pr7ZJ08M5roN7iiPN6uhxj2GDmANaVBiQ9cgIQTXZwpY01AJI7a143ITlnnpjv661pNUEG2IaTvmAlteTzjtDthtS4nhLcH91BXRfxkmi3FO8+iVADCqZHjvNbBkQgg2jhHxB1w1xFuZM+cGjtDKfVNzVdVPnMaGNqE+Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2crdGl3QnQxV0w0bi95RzRDRmhBTDZyb2pqYmhCZlR3R1RPMFRleGZBZnJV?=
 =?utf-8?B?WUdDUkNtRHQrckFLQUdzQkhNNDJKV3lhSEpqRU41R0tuRk1idnppM1Rtdk5R?=
 =?utf-8?B?K0Z2ckY1SGpxRXVOczJpQkhWb3BSTjJUZWMxaG5kckJtMnIxSHBlUiswQ1FU?=
 =?utf-8?B?bjZmNStaVk0raW15dk55bTRyTHNyaUpyMFZrZXFlMzVabmVaSDVQZmk0SWdW?=
 =?utf-8?B?V1lRc2VGQU4vSUdSamJXa2xoUEdwem8zTVVEZDU1TUZzdEdyOW41bFdFOG9F?=
 =?utf-8?B?TWxobzlaMUlqTllOVU5qWm9oT21SQ0Z4ZGlBbWNWYmZ4ZFgxVkw1bGJiS2dk?=
 =?utf-8?B?NXUvWUpBWlpUZDh2S3FacEdMS2UwR0NabDdNRVBPWUZiRUE4VGpCT1MvanZN?=
 =?utf-8?B?MDFZUE8zK011VDVWL0pXWXNUMDZWTDNWWWpGallUTStQUThTUWtMQlg3ckp5?=
 =?utf-8?B?cVIwd3l0VTg5Qy83VmxMTzBCb01hQzdJMkl6endFaVFSZy93VHZUelZlZXRY?=
 =?utf-8?B?ZXpORGZyYTdNQTJkemhmNUpZWkhwUDY4N3JwOFpZVXVadVI0TmY3Uzd5TU51?=
 =?utf-8?B?WnBqZnMxQ0RXSXZuTGI0bjVOUWlUQjNGREFmSTh4MGNCOGJZVzg1RkNrcThu?=
 =?utf-8?B?S2dYdEgxYXVJOGF2a3ZHQUZBRVppcmtpN1ByN2lnWkFkbytsUm4vWjRuMEYv?=
 =?utf-8?B?Wmg5MU4vaVQrZjhQbVpHYndDekphTEV6TjZVVU5PMWYvQjIzZlVWdDRMNjB0?=
 =?utf-8?B?V2lvS3Y5Zm5GWWIyWEZaK0JQb3gvSTNSR1o0azQ3bEVNNlZnNjVLVG1sTFZX?=
 =?utf-8?B?WFNRYUxoWmxNdFJ3RmZRUitZMmRicUVSR0Y0ZnFvRmw0ZU1IMUU3UWlrMmVX?=
 =?utf-8?B?VG1PSlAyTVd1K3pwYWtidjZrdXBGbWFzNFd5bkJQWS9CUHZyQlNwTUQxMTBE?=
 =?utf-8?B?djVZeFMrR0lvSEhTQ1BCdFVqeEVsUDgrdjR5Q09NTk1la2NqZ2dvS2ZvSVR5?=
 =?utf-8?B?a0hjREVkV2Y1N2tTZk5walRtRWhrdVlxd2FFSUw5ZG5YRkF4V1o1d1hYUVFt?=
 =?utf-8?B?UE42cVFQdjIyQWF4MTBXSHRoTEYzam94RG0wOGx5TUErak9USWU4M2JST0I4?=
 =?utf-8?B?MjREZ3h6bjFGUzViQVpwT1pad3A4RytvRk5JOVNNOVlxeWZLMlNoVHcyUWth?=
 =?utf-8?B?MnljNVRpQWZOem1NaExMZVNIVFhuMVQwV3g2YThmdnpJdVNUeEZkcUhIaTkv?=
 =?utf-8?B?YWUyTVVoZDNJektMZm1WVzB6ZEFlUGhJV3ZDbkVXbERPL2oxYlFHYUFqbG5m?=
 =?utf-8?B?dXJxbGt1L3lSd3VhWktZUzRaeVl1dE1RUVZOQVIxc2VNZ0NPKzRkenNsKzQz?=
 =?utf-8?B?VjU0NDc3YlovMUhBTnErcm9uOHpNVllyVmNhSVJkcVZKYXJXR2lVRFpJMUlO?=
 =?utf-8?B?UVJBaUZhNnpldDRFQkN3Z21vSUtidVN0Rk1jc3ZpNU1iQmRVZ1lQa1NVK3Vs?=
 =?utf-8?B?NGRIZkpBa3FMOEZSREZJSDR6aEYyang1bFR4eDFYVzV4c2szRGlsSHZNZGlD?=
 =?utf-8?B?M0tCbFIrVERGSzBBK3NMT2NKYzh4WW0ya2V1ckVBNlkra3lsTTNvWWhtUENn?=
 =?utf-8?B?NHZ5ck9YS2h1c2R0TjJIdHVFTUcxRklMUElzRk9rVnlCU0Z2ZUpsNWFkR2F0?=
 =?utf-8?B?ZlBSeHNlaXFMdUQyUTQ5cVdpMjR3cFdhaHVSNTJRS3pNbmhueUhYeEFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7f28cc-7791-4380-ccf0-08dbea86f0a6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 11:42:28.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMjAtTm92LTIwMjMsIGF0IDQ6MzfigK9QTSwgSGVjdG9yIE1hcnRpbiA8bWFyY2Fu
QG1hcmNhbi5zdD4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+PiBPbiAyMDIzLzExLzE5IDQ6MzEs
IEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gMTQtTm92LTIwMjMsIGF0IDM6
MTTigK9QTSwgSGVjdG9yIE1hcnRpbiA8bWFyY2FuQG1hcmNhbi5zdD4gd3JvdGU6DQo+Pj4gDQo+
Pj4gT24gMTQvMTEvMjAyMyAxOC4wMywgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+IA0KPj4+PiAN
Cj4+Pj4+IE9uIDE0LU5vdi0yMDIzLCBhdCAxOjI44oCvUE0sIEhlY3RvciBNYXJ0aW4gPG1hcmNh
bkBtYXJjYW4uc3Q+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiAxNC8xMS8yMDIzIDE1LjU5LCBI
ZWN0b3IgTWFydGluIHdyb3RlOg0KPj4+Pj4+IE9uIDE0LzExLzIwMjMgMTUuMjMsIEFkaXR5YSBH
YXJnIHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiAxNC1Ob3YtMjAyMywg
YXQgNTowMeKAr0FNLCBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IO+7v09uIE1vbiwgTm92IDEzLCAyMDIzIGF0IDA4OjU3OjM1
UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4+Pj4+IFN0YXJ0aW5nIGZyb20ga2Vy
bmVsIDYuNSwgYSByZWdyZXNzaW9uIGluIHRoZSBrZXJuZWwgaXMgY2F1c2luZyBCbHVldG9vdGgg
dG8gbm90IHdvcmsgb24gVDIgTWFjcyB3aXRoIEJDTTQzNzcgY2hpcC4NCj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+PiBKb3VybmFsY3RsIG9mIGtlcm5lbCA2LjQuOCB3aGljaCBoYXMgQmx1ZXRvb3RoIHdv
cmtpbmcgaXMgZ2l2ZW4gaGVyZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vdTlVM2tiRkoNCj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+PiBKb3VybmFsY3RsIG9mIGtlcm5lbCA2LjUuMiwgd2hpY2ggaGFzIEJs
dWV0b290aCBicm9rZW4gaXMgZ2l2ZW4gaGVyZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vYVZITkZN
UnMNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBBbHNvLCB0aGUgYnVnIGhhc27igJl0IGJlZW4gZml4
ZWQgZXZlbiBpbiA2LjYuMSwgYXMgcmVwb3J0ZWQgYnkgdXNlcnMuDQo+Pj4+Pj4+PiANCj4+Pj4+
Pj4+IENhbiB5b3UgYmlzZWN0IHRoaXMgcmVncmVzc2lvbiBwbGVhc2U/DQo+Pj4+Pj4+IA0KPj4+
Pj4+PiBTaW5jZSBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIHRoaXMgaGFyZHdhcmUsIGl0J3Mgbm90
IHBvc3NpYmxlIGZvciBtZSB0byBiaXNlY3QgdGhpcyByZWdyZXNzaW9uLiBMZXQncyBob3BlIHNv
bWVvbmUgaXMgYWJsZSB0byBkbyBzbyB0aG91Z2guDQo+Pj4+Pj4gDQo+Pj4+Pj4gSXQncyBub3Qg
YSByZWdyZXNzaW9uLCBpdCB3YXMgYWx3YXlzIGJyb2tlbi4gSSdtIHNlbmRpbmcgYSBwYXRjaC4N
Cj4+Pj4+PiANCj4+Pj4+PiAtIEhlY3Rvcg0KPj4+Pj4gDQo+Pj4+PiBZb3UgYXJlIHF1aXRlIGxp
a2VseSBjb25mbGF0aW5nIHR3byBwcm9ibGVtcy4gVGhlIHVic2FuIGlzc3VlIHlvdSBxdW90ZWQN
Cj4+Pj4+IHdhcyBhbHdheXMgdGhlcmUgYW5kIHRoZSBwYXRjaCBJIGp1c3Qgc2VudCBmaXhlcyBp
dCwgYnV0IGl0IGFsbW9zdA0KPj4+Pj4gY2VydGFpbmx5IGFsd2F5cyB3b3JrZWQgZmluZSBpbiBw
cmFjdGljZSB3aXRob3V0IHVic2FuLg0KPj4+Pj4gDQo+Pj4+PiBUaGUgQmx1ZXRvb3RoIHByb2Js
ZW0geW91IGFyZSByZWZlcnJpbmcgdG8gaXMgbGlrZWx5ICpzcGVjaWZpYyB0bw0KPj4+Pj4gQmx1
ZXRvb3RoIExFIGRldmljZXMqIGFuZCB0aGUgcmVncmVzc2lvbiB3YXMgaW50cm9kdWNlZCBieSAy
ODhjOTAyMjRlDQo+Pj4+PiBhbmQgZml4ZWQgYnkgNDFlOWNkZWE5Yywgd2hpY2ggaXMgYWxzbyBp
biA2LjUuMTEgYW5kIDYuNi4xLg0KPj4+Pj4gDQo+Pj4+PiBJZiBCbHVldG9vdGggaXMgYnJva2Vu
IGluICpzb21lIG90aGVyIHdheSogaW4gNi42LjEgdGhlbiB3ZSBuZWVkIGENCj4+Pj4+IHByb3Bl
ciByZXBvcnQgb3IgYSBiaXNlY3QuIFlvdXIgbG9ncyBkb24ndCBzaG93IGFueSBpc3N1ZXMgb3Ro
ZXIgdGhhbg0KPj4+Pj4gdGhlIHVic2FuIG5vaXNlLCB3aGljaCBpcyBub3QgYSByZWdyZXNzaW9u
Lg0KPj4+Pj4gDQo+Pj4+PiAtIEhlY3Rvcg0KPj4+Pj4gDQo+Pj4+IA0KPj4+PiBVQlNBTiBub2lz
ZSBzZWVtcyB0byBiZSBmaXhlZCwgQmx1ZXRvb3RoIG5vdCB3b3JraW5nIHRob3VnaA0KPj4+PiAN
Cj4+Pj4gaHR0cHM6Ly9wYXN0ZWJpbi5jb20vSGVWdk1WazQNCj4+Pj4gDQo+Pj4+IElsbCB0cnkg
c2V0dGluZyAuYnJva2VuX2xlX2NvZGVkID0gdHJ1ZSwNCj4+PiANCj4+PiBOb3cgeW91IGhhdmUg
YSBwcm9iZSB0aW1lb3V0LCB3aGljaCB5b3UgZGlkbid0IGhhdmUgYmVmb3JlLiBUaGF0J3MgYQ0K
Pj4+IGRpZmZlcmVudCBwcm9ibGVtLg0KPj4+IA0KPj4+IFBsZWFzZSB0cnkgdGhpcyBjb21taXQg
YW5kIHNlZSBpZiBpdCBoZWxwczoNCj4+PiANCj4+PiBodHRwczovL2dpdGh1Yi5jb20vQXNhaGlM
aW51eC9saW51eC9jb21taXQvOGVjNzcwYjRmNzhmYzE0NjI5NzA1MjA2ZTJkYjU0ZDlkNjQzOTY4
Ng0KPj4+IA0KPj4+IElmIGl0J3MgdGhpcyB0aGVuIGl0J3Mgc3RpbGwgbm90IGEgcmVncmVzc2lv
biwgaXQncyBwcm9iYWJseSBqdXN0IHJhbmRvbQ0KPj4+IGNoYW5jZSBzaW5jZSBJIHRoaW5rIHRo
ZSBvbGQgdGltZW91dCB2YWx1ZSB3YXMgYm9yZGVybGluZSBmb3IgdGhlIG9sZGVyDQo+Pj4gY2hp
cHMuDQo+Pj4gDQo+Pj4gLSBIZWN0b3INCj4+PiANCj4+IA0KPj4gDQo+PiBIaQ0KPj4gDQo+PiBJ
IHJlY2VudGx5IGdvdCBhIGtlcm5lbCB0ZXN0ZWQgd2l0aCB0aGlzIHBhdGNoIGFzIHdlbGwgYXMg
d2l0aCAuYnJva2VuX2xlX2NvZGVkID0gdHJ1ZSwNCj4+IEhlcmUgYXJlIHRoZSBsb2dzOiBodHRw
czovL3Bhc3RlYmluLmNvbS9CcGZKdUpLWQ0KPj4gDQo+PiBBbHNvLCB3aXRob3V0IC5icm9rZW5f
bGVfY29kZWQgPSB0cnVlLCB0aGUgYmx1ZXRvb3RoIGRvZXNuJ3Qgd29yaywgYXMgc3BlY2lmaWVk
IGluIG15IHByZXZpb3VzIGVtYWlsLg0KPiANCj4gU28gYXJlIHlvdSBzYXlpbmcgZXZlcnl0aGlu
ZyB3b3JrcyBub3c/IElmIG5vdCwgd2hhdCBkb2Vzbid0IHdvcms/DQo+ICJCbHVldG9vdGggZG9l
c24ndCB3b3JrIiBpc24ndCB1c2VmdWwgaW5mb3JtYXRpb24sIGVzcGVjaWFsbHkgaW4gdGhlDQo+
IGFic2VuY2Ugb2YgYW55IHVzZWZ1bCBlcnJvciBtZXNzYWdlcy4gWW91IGNhbid0IGp1c3QgZHVt
cCBkbWVzZyBsb2dzIGF0DQo+IHVzLCB5b3UgaGF2ZSB0byAqZGVzY3JpYmUqIHdoYXQgdGhlIHBy
b2JsZW0gaXMuDQo+IA0KTXkgYmFkIGZvciBub3Qgc3BlY2lmeWluZyB0aGF0LiBUaGUgdXNlciBy
ZXBvcnRzIHRoYXQgdGhlIEJsdWV0b290aCBkZXZpY2UgaXMgbm90IHJlY29nbmlzZWQgYXQgYWxs
Lg0KDQpBbHNvLCBicm9rZW5fbGVfY29kZWQgPSB0cnVlIGRpZCBub3QgImZpeCIgaXQuDQoNClRh
bGtpbmcgYWJvdXQgZG1lc2csIHdlbGwgbm90IGdldHRpbmcgYW55IGxvZ3MgcmVnYXJkaW5nIHRo
aXMgbWVzc2FnZSBpbmRlZWQgaXMgYSBmcnVzdHJhdGluZyB0aGluZyBmb3IgbWUsIGFuZCBiaXNl
Y3Rpbmcgc2VlbXMgdG8gYmUgdGhlIG9ubHkgb3B0aW9uIGluIG15IG1pbmQgcm4uDQoNCj4gSWYg
YnJva2VuX2xlX2NvZGVkID0gdHJ1ZSAiZml4ZWQiIGl0IHRoZW4gImJsdWV0b290aCBkb2Vzbid0
IHdvcmsiIHdhcyBhDQo+IHRlcnJpYmxlIGJ1ZyByZXBvcnQuIFdoYXQgdGhhdCBxdWlyayBkb2Vz
IGlzIG1ha2UgKmNvbm5lY3RpbmcvcGFpcmluZyB0bw0KPiBCbHVldG9vdGggTEUgZGV2aWNlcyog
d29yay4gTm9uLUJMRSBkZXZpY2VzIGFscmVhZHkgd29ya2VkLCB0aGUNCj4gY29udHJvbGxlciB3
b3JrZWQsIHNjYW5uaW5nIHdvcmtlZCwgZXRjLiBBbGwgdGhhdCBpcyB1c2VmdWwgaW5mb3JtYXRp
b24NCj4gaWYgeW91IHdhbnQgdG8gZ2V0IHN1cHBvcnQgZm9yIGlzc3Vlcy4gV2UgY2FuJ3QgbWFn
aWNhbGx5IGRpdmluZSB3aGF0J3MNCj4gd3JvbmcgaWYgeW91IGp1c3Qgc2VuZCB1cyBhIGRtZXNn
IGFuZCBzYXkgIml0J3MgYnJva2VuIi4gV2UgbmVlZA0KPiBkZXRhaWxlZCBpbmZvcm1hdGlvbiBh
Ym91dCBleGFjdGx5IHdoYXQgd29ya3MgYW5kIHdoYXQgZG9lc24ndCAoZS5nLiB0aGUNCj4gY29u
dHJvbGxlciBub3Qgc2hvd2luZyB1cCBhdCBhbGwgaXMgVkVSWSBkaWZmZXJlbnQgZnJvbSBpdCBz
aG93aW5nIHVwDQo+IGJ1dCBub3QgZmluZGluZyB5b3VyIGRldmljZSkuIFRoZSBvbmx5IHJlYXNv
biB3ZSBndWVzc2VkIHRoaXMgaGVyZSBpcw0KPiB0aGF0IHRoaXMgd2FzIGEga25vd24gaXNzdWUg
dGhhdCBhZmZlY3RlZCBvdGhlciBjaGlwcy4gSWYgd2UgZXZlciBydW4NCj4gaW50byBhIDQzNzct
c3BlY2lmaWMgaXNzdWUgdGhhdCBvbmx5IHlvdSBjYW4gcmVwcm9kdWNlLCAiYmx1ZXRvb3RoDQo+
IGRvZXNuJ3Qgd29yayIgYW5kIG5vIGVycm9yIGxvZ3MgcmVhbGx5IGlzbid0IGdvaW5nIHRvIGdl
dCBpdCBmaXhlZC4NCj4gDQo+IC0gSGVjdG9yDQo=
