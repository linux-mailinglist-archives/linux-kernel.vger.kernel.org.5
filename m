Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C07EAC68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjKNJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:03:52 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2051.outbound.protection.outlook.com [40.92.103.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CDBA;
        Tue, 14 Nov 2023 01:03:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnf9a5o3biAZZdORBTGk1DJv6CeNsB3vUSDnCXgFo2VhZc4wpqGmOxa0fEcQWv3f8XViY3tOxULbtTAovfkZZyTbhHsExZLytMK48VFIFOIBuJ+inj/IlbS+NCuiXPLDez4tScVUeitQlJecUS2dSYHKZXuEU69PUEdpbmCB65pE0TVFh5T9KAGiNjUi6lvTBGCA8KnYBVPy5isomJZE+nL1JJoKjtnjilYh+kytOLV5lfLn5DYDg0lnITOva5orl1Sa+JL0zroVb3dteIC0/JhFewuLiy3wvcLXcdCi3YaI9CZFzx02WRzu6Peexp5Su/Pr6jKN+aLbO+bTt431Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Uqku7G+6FI0rNh12+oEOg3/0nrCaQrnzaWBiSPjtY=;
 b=MKkJ65bcrvTh7riz0MpEEsm2GQr+GAQ2YmSyxVaGxfzqvEbqFaJDhNcE/Yhw6qEt0Qj1Jp0gX7a6x/n2NZs0Ex2cUd6Ahr3p3yK0yLp5xxcxjPIAe4L/XfmpNzp1/D4amGUi7Co9ufJIUpOBJkcRDn49QfDgAlzdrYNSK7dq6KE/c09a0srILgTkpii5OqrksWJJq0xsIgdjQRGbFcriAe09MPs8WXXuZ8b1d1fPZ59AjfIGMoBO2lIF68kxJw3EcKGgxYQB73SToXsOkbEe7qrxCvm+/k4CrdsRGQbQ61cl5CBG8lOMRHSTrAeSyMmsuqHvauMuYrVTsL24OJ4pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Uqku7G+6FI0rNh12+oEOg3/0nrCaQrnzaWBiSPjtY=;
 b=r2bf6XdLcZV0EYZs/mqtFBE7sco3iiRHgnRvUauvIQL4jN+czI5hmiDOjAAJCMFts+IxOzqj/n0knG1sbraC1Vf4bm5ULfvsYehJnaFSVenoPls8La8lJulv0qAGuJ9NTD8LN02jtcP+CtXccOJicXzG7V/U/N76f1J95IBrI+SXSeNO2OizBNvIxGBIdAkLPSw4B5WPPTcpcbFeYHvoF6HsIZbFleqKSZMv6IGZ4udlAaaRBLMez9zRPXuCao1xWExR9J8DXzJ4xmqjGQzJximJmplHxcS8JbzQ8cB9eo2gAsgDxqN6FKNnHEFiZJAFCZTMC9vbCAynV9jax6pMYQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0784.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 09:03:40 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 09:03:40 +0000
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
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQceAAAopgIAAEGgAgAASIAA=
Date:   Tue, 14 Nov 2023 09:03:40 +0000
Message-ID: <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
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
x-tmn:  [f5Rzf/eYZEh+oE/BNhkUiCiYADXym4izx7uyVBOJWgq+mfA2BhIzDR0kkGAJvRNHy4/+6KXbRyM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0784:EE_
x-ms-office365-filtering-correlation-id: 69d4eb77-c117-40c8-68e1-08dbe4f098ab
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJ+ZHKpZmnT86MzIZFUduu3U8JOn6zzslO7EselhQkJb/xt7DSsvG4PFPBFkjwmLfnt6uKaSUehrmhFaWBeGYYAhNMomfFUlvkV1OYO4ockXbb//JEWcHGyxTYgABpugRLyeULNYE3wj0DcIHB0CdMC7ht8Ssb42obmPHH+yOUosOqoD7yXMNqu/p2F7O+9vz0ZH4I7RhwGSA4EdZrvOSOk3q5pG38OB2ZbOE78Ncgcknxy2p4cy1dIepuDx3GTusZuYN5mTOVrE7iMUY0LjpesXAQvCzD3bs3fKShwvHQh/qV+tlVxF5atoZT3AKmHy0GIKB7UCnjGVqnRL94MEhpCcC+o/XmBbtTBM5my8eOsqeB0ESYKlxNY84X/+o/4FrMYmI8mTrI/mDVVJzgGMY3s0LrNUNbaFDYsn9ydEUNuYro2IgDrFz96ohvLi5gsNnOVwnRb05p37yGya0CahGlq3Ux6aoPQi5Auvq+XdLsuLHWMwBkGKGZWwe/1cEP8TJqqaowk8ltqHTZEj6MW39xpYA/uoWILJbkbYhGgtkXsGcNyyft4Rr+wso7wUT2Hga7ezvCNFTJ00KJH3uKMXYpjcDa26eyyNyXrhB2vTFKU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FXalpWSWNDVzVwbWZaU2Q2ZnRmN1RPUnFXWExSN21BVHRjVG5RZ0R3S1NH?=
 =?utf-8?B?Q0hXSVdyMndSUHZkSFA4em1TSDluaW1LWC9YUEdPbmdzSlQwOHZDUmpORHdz?=
 =?utf-8?B?dXpSYnBzczlDNjZMS0ZhdWZGWkQ4aHdTbXdya2Z6V0RwVXVhN2o0N3VDaTQ2?=
 =?utf-8?B?NlJ3bXdENllHN0VFQXlrNDB3aStOMGpZK2pUSU10WVNGdFlzamlQYWl1SVk5?=
 =?utf-8?B?b2FvU0Izb2pxSkpVeTdGdEl4a3pqS2R6R1J1WG5jNDJVVG5wYjRCYmRjajlq?=
 =?utf-8?B?bS81cFdmYmgrVndIVW8zZ3YrVVRqd1YwbVU4c1JOSU80NzBGbjFPaHNQRllV?=
 =?utf-8?B?akFqNlVSUUtMZk9kczdHN3JrTHBDcjNYVjltR2ZPOHhNQzY4VXBwSldiNzRs?=
 =?utf-8?B?UmF0ZlNlTit5RUVIRzFKelJER25xQ3FwUUk5QXRETmJrL1V2eDN3c29OV0hy?=
 =?utf-8?B?dmxOYStaUTJicFl0c3BwRGVzMkI0WnIydlpkMDNqY2JlMXEzQ2FZcnJwb09S?=
 =?utf-8?B?SGZSNlREaWJkMGRvQ2lTWTNtR0ZrUUJVZzF0eDBHSkxTYVg1S3E2aUE1YTNP?=
 =?utf-8?B?TkNITTBydHY5a0JOaWMzUnR2SnE1VGc4QUczUFN3ZTdndXozMVpzWnVFUlJh?=
 =?utf-8?B?K1JaUU4yMjR3aERYUEJmUTBFVVh5VVZMNG5QdHZOMXd0SWhEQUpQdXpEaWM3?=
 =?utf-8?B?R3kxS2FQQ203T3lNSzF6bDViTmtabkdhQWp5MlM5ODRqNmdXVSthMHRXYXhE?=
 =?utf-8?B?cGswS080aXNlQ3Z6UXdDNnVPNlNyWnpzUFpTcVRCMDJPZzRLdEVkaEJ4Qkxw?=
 =?utf-8?B?eFhCUkxSY01vTVcwRFdNczk0TUdiRHFZMG5YbHBvRDRxZXlZLzAyaERKRHdV?=
 =?utf-8?B?bXV4NGl5MW1HRnpUZk1qb0NoYVpxVC9aMDNpMWVHTDFXQm9EMm1iemt3NGhk?=
 =?utf-8?B?eU42UDFrMmtaV2psUzhKNS9SVWIrVHpNMEUzb2c5NUIwZHc0QkE2cEN5M0RP?=
 =?utf-8?B?cUpRRk9ITEZQY3hacHlLR0l6ZkpET3lxMHlzYlc1d3U3RjZPVEVPamZEQWxM?=
 =?utf-8?B?MmxJaG1EeWdFaG1sK3crKzhUVWxzNVp6akZ1c1NUQnhtY0pHQnJXeUtBVk9n?=
 =?utf-8?B?c1RXUFA4N2NIeVlSNG50WHVpY0dNYWxxUHFqZWR6azYrNkFDeXJRM1pSTkp5?=
 =?utf-8?B?ditEN1hMVmJ6WElZMXpBaXQrcndNYUxhM0ltM3g2TG1SZ1Y5T2NGYkhRZVBa?=
 =?utf-8?B?YS9qQTh2Tm9PcVJmSVVodTJiaDBXNVpZK0tHdWYreE1YT1NHN2s1MXdtWmJS?=
 =?utf-8?B?Z2dJdUtBL2RzdVhnaFhwL3dFTEZpWG8vNlJoenRUb0ZzdXdSQit0eGpYS2VO?=
 =?utf-8?B?OVZyR0FYeDdleXlLVlhWekpsazRoUGZHQ2QrT2NHZHFTRElKSjNlUVhPK291?=
 =?utf-8?B?TUhxbXRwQnM0cUNWYkpub3g5TXZsSG9HOHJZWXh0V0FEVFBTc2ZaS3ZTd0g2?=
 =?utf-8?B?emtTenJXN29QenN0cnI1M2k5TjQzRElFUzlVa3MyMmlmSElwTFJGLzYzeDdI?=
 =?utf-8?B?cmFwamdjZnJJUjlDSExLYm1KT0NVRm9IQnRxMU9OUGQ1ZVI2L2pad1E3cWg4?=
 =?utf-8?B?VTN1YVVDNWREY2kreG9GY3FtVDBwSGlRNlpuTm9GQWpxck9yWi9aZVNIUFps?=
 =?utf-8?B?amNpd1ZWbDRzSVA2SWVlY3VkZUpCTWhyektYWno2ai8vUjVkM1MrQnhwbHcz?=
 =?utf-8?Q?aOelolr/sExFIwmWns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7395B77984F11E47A4F367364B8580BD@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d4eb77-c117-40c8-68e1-08dbe4f098ab
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 09:03:40.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0784
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
aXNlLCB3aGljaCBpcyBub3QgYSByZWdyZXNzaW9uLg0KPiANCj4gLSBIZWN0b3INCj4gDQoNClVC
U0FOIG5vaXNlIHNlZW1zIHRvIGJlIGZpeGVkLCBCbHVldG9vdGggbm90IHdvcmtpbmcgdGhvdWdo
DQoNCmh0dHBzOi8vcGFzdGViaW4uY29tL0hlVnZNVms0DQoNCklsbCB0cnkgc2V0dGluZyAuYnJv
a2VuX2xlX2NvZGVkID0gdHJ1ZSwNCg0K
