Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A37EAB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKNIS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjKNISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:18:24 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2048.outbound.protection.outlook.com [40.92.103.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F471A5;
        Tue, 14 Nov 2023 00:18:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhxWTWrkx+ohBgeHwg2vli6yDTyeN8ao8d37ASgAEuVeoxrMMYEXbkgOu1ITI0vp8L2Kl4i1bEiOnfGs45ERLOPFzNAkghpzd2K9/hE1D6essSgtvdgB/eO/XtkRBmUKJUfcFlSRbGwu1tQHmvpTBGDrLMnuOTqNCK4s04znQtbt8nafmN2xSvCwHm9sNw4GmCvC5a9Z7J8BDMJV3NElE2+119Fuw2LSvSePupXH9IRyt8yb0CTfmwgWQ+D6PGs3WBqZ5sTDfON/IENlSAMyhNHBYTX15yjzsYGWlmyj1Zq5B256QEoTPzMTVzKl240prArHP8XM6nqQUYj2seUnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uBIaZ0mI/O9rDDG8oLYq3CPNN3QET1/W8nf8oIp3fI=;
 b=lisLnuSk7aQIhd0okKu8AkAuqQ4fD0foqAYLAmwKxJAjITFLVjjDS0/2OWH0UJHvXWwVDSnPQyLMs8OWllql3Eb4vjIuHLOTPmO8833j2lA+AAYJp7hvLknu5PXzd3mXm71wGp/xuF1/t3qVeG2rM/MS4MB6u7uwFJRERZzackRUrDYFmGe3aQBt9i/rk8OQbpUQqviWvqlLFb1rmFEFB3eixoMulXFveh/kkS6xpFzqO/4DASKhsRlw+4h/CYJL0JCbeqG75iXeoHe21cLj5WO7NZ/2kokfDXqE1Bk8pFsOb6eCHo/tLHqHlpmGK2K3jK+r68wFpESXxCIcMWdTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uBIaZ0mI/O9rDDG8oLYq3CPNN3QET1/W8nf8oIp3fI=;
 b=VwTwcT6el2Li0/2/yliY9Yu87qMaTPdxVHlKCxAAfxMuUCNbYBgercIz4hVn1JNtQhm2jlvMiQcTULMvnxy6OgIygoE/JUtLnQoUkjJeUDVE0TuAUR7IP11rynpmg6X5ZSSkgw0/2OBU2JJBB+5cOpc6GGBBITmk2Y3d1Odi/f9i3j/9wY/A0jxVSyPqngNhSjAmJZSub7uym51yEwMpcAVrwhlA9iQwJ5T7HkfR2si5of9NuQ4vwqflp5tCCSn81grMXzL5ZGbAuazVPK/FDibYn5SYK34KFMwmfXMaf9NFASci/Oo7nlbCOcWRiTHw0pyMhduhPbZ4DJJSf/ZnMA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB1536.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 08:18:14 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 08:18:14 +0000
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
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Topic: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQceAAAopgIAAEGgAgAAFaQA=
Date:   Tue, 14 Nov 2023 08:18:14 +0000
Message-ID: <D8FD787C-BCBB-4C52-9666-8312E05531E1@live.com>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
In-Reply-To: <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gNzHA6UOuve+84RxIKXE+YI9gUCsuwQx9sKmhehWCgdE+tbPbaxlSUlkwOuTpQiBRFICCxr43RA=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB1536:EE_
x-ms-office365-filtering-correlation-id: f440ca3a-e289-4051-4b04-08dbe4ea3f9e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2w3I/vZS+fg8oVTJrOhz6fFETFEeGRaq/ldArFeWMNLUhljBbdsb5M9rfRsz7IcITuwt3MgBtzFAnFJavx92zlMqujZWgrrAChuG23c/R1i5VYaZlvpMBxBZkXcchUMMfttohRASWT398oksI9RQZkRyJx+1jxyymvMdroc2wUfUD5t29NIppGsitXZAmeYNi7j+MbtWQDY90ww9/GkKyaSrXPcDrSqHaxK9Zm1+cheXthAoRzBqVp3yQtO6HDABzYJWsn2/ySWsDAFVf4p34fAQtZ8jsmxzoHCwSR8iPNf3UwuGHXiRsJpyYKF3mEvM2a79G8BeO44xEuJwyYj50LRI3fA6O5491OP3vSKV+7amEoqXqr7TZKmzbhIuEui0epXz4lGbs3pdRQLFKowD96mLa/3ohzDBl7567nR2AeILz288xXdHMHHnMahlfivKXMOaQRov91oB0xxvmNA8Hxn8eHW+r7vrGCVg2rrsLnCANdqNAVTl6UZbwu5014lo8OA2sHsdP70+lH+IwseQpNHdUiX76+aXBXo15jA148iX+ax/cHP2Y9B6oLJ3KFuHOnXFUQrlJySE/dPAoGPiDubKe4H36agbcGveSUtpA40=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZSSi85SFlJWXRMYmNVS29BRDd0aWc0YmM1T1dRb2V4aytNOFZkU1pkOFlv?=
 =?utf-8?B?ZEJReVphQXphUGxzYmt4Nk80b2JydjBkRVlqMzBVUEZMaUlvVm4xZ3Y3YU5I?=
 =?utf-8?B?cXMrZWx4alpzSXFIeGpqYkxseU5KTVUyUmxJVHB6S3RTSEJxNUNqdm5ZRGtQ?=
 =?utf-8?B?cldoVWxLWnV2Z2ZPdEdFOXF3bncva3haSnNLUlYwVVZwdUVZMnlZd0FIbmJp?=
 =?utf-8?B?RXZnV1loK1RVcmt0Ty95MDBuWVhJdzNDb0VyVm9OeTI5WmQ4TVZDTDFzU0lN?=
 =?utf-8?B?dmtTcUJJMWRxM3MxTzQ2SUc5ZE9hWTFCYzlGbTI1cEVNSkhENlNhRXVhb2pE?=
 =?utf-8?B?bGwrcjB4ZDE5SmJkK0FPUWU2ZnJ2YXBiRHlZSDF5RDNIZTU5d1Izc3RHcUdU?=
 =?utf-8?B?cXBKR1VMM0RqL0l0UlBGUlBsWWkvOEtwOVJyUGNWWGtVYTRxVTRpMVZveTFQ?=
 =?utf-8?B?VjJQMGN4dGwrV2pMUk1WSWtWNXM0a0RUbFRjeC9wcnI4dXp0R3BVaVBoZG12?=
 =?utf-8?B?T3pkcVBKM0FFWVF2UExDVytFMU40d0hTL1llb0NadW9nWW5GUzJ2aDQyV3Iz?=
 =?utf-8?B?cFpiQ0c5eExPTGNCVVQycDB5Vi9uT240WmtraFR2VE96N3FxZFFHY2ZNVnNI?=
 =?utf-8?B?dUdINi9vdDI1K1RPa3hKRk9ReXhaUnc0LzU1aUJzMVBrcEdRUHdPM0t4THV5?=
 =?utf-8?B?dmFhc1ZacXJyTmk1bjZaRUx3a0NzSDN4U0dEYitLd0JlUzRLRTYxMHRpVlRU?=
 =?utf-8?B?MVFORXJzK2VNL3A1MElmOGduTnhvYmVXNHBxZU1jNGZrWmdJdEZESDRlck1H?=
 =?utf-8?B?dmQ4Q0ZpeXFmT0NxbmkrUkp4cW5IODIySlJHT1lHZVRQd1A3T0F0bW5HeDZE?=
 =?utf-8?B?dkVuN3VuOUxsNDlObTBNVW9VM0grQ3EwUUZZV1RaaUpLcjN6bjd1clczcExn?=
 =?utf-8?B?NlJZSXFBR0dyT3gxRndOaEtQdUp0WnlDeG95dWF4Q0J4aWpwbjJwdXpOSGdY?=
 =?utf-8?B?eFZLVnpxUjFkQWVaVHlWcVB0Q25iLzQ4WVN5N2RuWmNWK1lYVHdrTjF3MHdN?=
 =?utf-8?B?d0JiWTdld09TTjVPTkM0bnliKzFkY0s0aGM1a3prRU16aE1Cb1N2VDVyNDZj?=
 =?utf-8?B?L0s4NVdsVzN1TEZsMFFoYnNMOUhzTE81Q01qVHpiMHQrbVVmSG5LTWFraGxt?=
 =?utf-8?B?NWNoVmE5MUpqZHB0Ynp4RW9UYnJzQmpTSHllMVVyRjg4RUlGQnZPUjB0TThB?=
 =?utf-8?B?emtmOUNraVdsSnRMRVhlU3VXYWh3Rkx6SVVreTFOYjJYb2pjZFNLVFlzV2lO?=
 =?utf-8?B?KzllczNpUndwU3owa0ZXYmd4T1FpSDh1b1licmtNS0JteWhFWG9ZWXdieWxJ?=
 =?utf-8?B?cFBNWW1BYWNzSkNjRzJOUnpycks4bGRpdFduK2RHdmhKajNUcUdqTjBsSktw?=
 =?utf-8?B?QlY5QUhOMWxGWWJ6Y0RCNHhiYmlhV2ROMXRQV0l6dlRzVnRhc0wzckFNWmRU?=
 =?utf-8?B?Q2U5OVJaZVRVajBaK3JRQlA1OGx6V3VKL1NIWkduQ0o0MS9MdWlXTTVOT3ZU?=
 =?utf-8?B?NVZMb3ZYVGRhU1FndGF3RFBmSlE1YjZUbzdHUWxRTVY4WVJtQ1Y4QVhhRW9K?=
 =?utf-8?B?V3JuMWQxU1ZSYTJGTXY5Q2ZvOGdhSS9xNVhyc3dnZTFSaDJJZy9iTzVCU1g4?=
 =?utf-8?B?Ymloa3RKSnBRL3lEUkwvM1RoT3FOYTF4RnNrdkJXRjFjWXd2VUZ4MmFqb1RS?=
 =?utf-8?Q?MavIvjbQCAGoUHQL4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DA11935FFB6D84693A62AFF5198C1D6@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f440ca3a-e289-4051-4b04-08dbe4ea3f9e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 08:18:14.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1536
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

DQoNCj4gT24gMTQtTm92LTIwMjMsIGF0IDE6MjjigK9QTSwgSGVjdG9yIE1hcnRpbiA8bWFyY2Fu
QG1hcmNhbi5zdD4gd3JvdGU6DQo+IA0KPiBPbiAxNC8xMS8yMDIzIDE1LjU5LCBIZWN0b3IgTWFy
dGluIHdyb3RlOg0KPj4gT24gMTQvMTEvMjAyMyAxNS4yMywgQWRpdHlhIEdhcmcgd3JvdGU6DQo+
Pj4gDQo+Pj4gDQo+Pj4+IE9uIDE0LU5vdi0yMDIzLCBhdCA1OjAx4oCvQU0sIEJhZ2FzIFNhbmph
eWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IO+7v09uIE1vbiwg
Tm92IDEzLCAyMDIzIGF0IDA4OjU3OjM1UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+
Pj4gU3RhcnRpbmcgZnJvbSBrZXJuZWwgNi41LCBhIHJlZ3Jlc3Npb24gaW4gdGhlIGtlcm5lbCBp
cyBjYXVzaW5nIEJsdWV0b290aCB0byBub3Qgd29yayBvbiBUMiBNYWNzIHdpdGggQkNNNDM3NyBj
aGlwLg0KPj4+Pj4gDQo+Pj4+PiBKb3VybmFsY3RsIG9mIGtlcm5lbCA2LjQuOCB3aGljaCBoYXMg
Qmx1ZXRvb3RoIHdvcmtpbmcgaXMgZ2l2ZW4gaGVyZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vdTlV
M2tiRkoNCj4+Pj4+IA0KPj4+Pj4gSm91cm5hbGN0bCBvZiBrZXJuZWwgNi41LjIsIHdoaWNoIGhh
cyBCbHVldG9vdGggYnJva2VuIGlzIGdpdmVuIGhlcmU6IGh0dHBzOi8vcGFzdGViaW4uY29tL2FW
SE5GTVJzDQo+Pj4+PiANCj4+Pj4+IEFsc28sIHRoZSBidWcgaGFzbuKAmXQgYmVlbiBmaXhlZCBl
dmVuIGluIDYuNi4xLCBhcyByZXBvcnRlZCBieSB1c2Vycy4NCj4+Pj4gDQo+Pj4+IENhbiB5b3Ug
YmlzZWN0IHRoaXMgcmVncmVzc2lvbiBwbGVhc2U/DQo+Pj4gDQo+Pj4gU2luY2UgSSBkb24ndCBo
YXZlIGFjY2VzcyB0byB0aGlzIGhhcmR3YXJlLCBpdCdzIG5vdCBwb3NzaWJsZSBmb3IgbWUgdG8g
YmlzZWN0IHRoaXMgcmVncmVzc2lvbi4gTGV0J3MgaG9wZSBzb21lb25lIGlzIGFibGUgdG8gZG8g
c28gdGhvdWdoLg0KPj4gDQo+PiBJdCdzIG5vdCBhIHJlZ3Jlc3Npb24sIGl0IHdhcyBhbHdheXMg
YnJva2VuLiBJJ20gc2VuZGluZyBhIHBhdGNoLg0KPj4gDQo+PiAtIEhlY3Rvcg0KPiANCj4gWW91
IGFyZSBxdWl0ZSBsaWtlbHkgY29uZmxhdGluZyB0d28gcHJvYmxlbXMuIFRoZSB1YnNhbiBpc3N1
ZSB5b3UgcXVvdGVkDQo+IHdhcyBhbHdheXMgdGhlcmUgYW5kIHRoZSBwYXRjaCBJIGp1c3Qgc2Vu
dCBmaXhlcyBpdCwgYnV0IGl0IGFsbW9zdA0KPiBjZXJ0YWlubHkgYWx3YXlzIHdvcmtlZCBmaW5l
IGluIHByYWN0aWNlIHdpdGhvdXQgdWJzYW4uDQo+IA0KPiBUaGUgQmx1ZXRvb3RoIHByb2JsZW0g
eW91IGFyZSByZWZlcnJpbmcgdG8gaXMgbGlrZWx5ICpzcGVjaWZpYyB0bw0KPiBCbHVldG9vdGgg
TEUgZGV2aWNlcyogYW5kIHRoZSByZWdyZXNzaW9uIHdhcyBpbnRyb2R1Y2VkIGJ5IDI4OGM5MDIy
NGUNCj4gYW5kIGZpeGVkIGJ5IDQxZTljZGVhOWMsIHdoaWNoIGlzIGFsc28gaW4gNi41LjExIGFu
ZCA2LjYuMS4NCj4gDQo+IElmIEJsdWV0b290aCBpcyBicm9rZW4gaW4gKnNvbWUgb3RoZXIgd2F5
KiBpbiA2LjYuMSB0aGVuIHdlIG5lZWQgYQ0KPiBwcm9wZXIgcmVwb3J0IG9yIGEgYmlzZWN0LiBZ
b3VyIGxvZ3MgZG9uJ3Qgc2hvdyBhbnkgaXNzdWVzIG90aGVyIHRoYW4NCj4gdGhlIHVic2FuIG5v
aXNlLCB3aGljaCBpcyBub3QgYSByZWdyZXNzaW9uLg0KPiANCj4gLSBIZWN0b3INCknigJlsbCBy
ZXF1ZXN0IHVzZXJzIHdpdGggdGhlIGhhcmR3YXJlIHRvIHRlc3QgdGhlIHBhdGNoIHlvdSBzZW50
LiBUYWxraW5nIGFib3V0DQpMRSBkZXZpY2VzLCBJIGd1ZXNzIEkgY2FuIGdvIGFoZWFkIHRlc3Rp
bmcgd2l0aCB0aGUgcXVpcmsgaWYgeW91ciBwYXRjaCBkb2Vzbid0DQpXb3JrLg0KPiANCg0K
