Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747897F0266
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:31:12 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2015.outbound.protection.outlook.com [40.92.103.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5712B;
        Sat, 18 Nov 2023 11:31:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYHGFtbgA2I8CwkAWyrud3qWjIIHiGIzG6AJNNKa2xwkiI6ZQxRFaumPxBQaMM5mfGDAv28WQIaQgXHfh4DDh6NHNhHFsjm76/3E5Ps63M4uBuko3ysMaUmE3AugsJopyh67ACtbBC7MBlN94i2JV6eN0hlEhF0gt1YyKDaFJ3W5z8y6HYP7w6mWm7H2bKZ0uz3o2T8C4ckZeZc12Z7Rot9hsy4cjPikW0AgjF5C7LbGzYkf+4lC9excfjj4greUFdReBqu137v7jp3AcWh8byFCI1a1OE3qQiKwpadfc6fnwC09eq4IEjyKo7Wafs6T/b+EnHUuynD6nrz/vMkyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/uaUJsHZJ6QDHmTCzow9+T1z4pQfDdLSN/bnHMrbq0=;
 b=KPfOTZEdn5+Gm2LRbPhf1d/e0Jsrf9JMLRxqMFqWgVfQCopfRsFuLFWxpSN3qtwMVBbMR3JPTa0zTSQl/JL9/YOmOUf2jUtLv9vs6VLRtFWvttbjxEGZuFhuysvbldyj2ihxH8Cj82FEghpt9t+HJ/7zV69eW5M9pgyQ55jMW+tgXZt5HEqL+D2Mu/bEeoG6TcGiZCrfZRhP3xrnijGLn+rjSSE/R9lKZdCJwucJqAaXMa/oouUApFJt4ZjyULLSw9J1DgIaSqE5yHvch7fWOIXgFrd3qDFGlgCvQARh4zBGSvdWwRVerH7oxbgknTpx7ZrVKDhkpXeibH9vYZUEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/uaUJsHZJ6QDHmTCzow9+T1z4pQfDdLSN/bnHMrbq0=;
 b=PSc6hZVM7keaRMUTXr3L90KcUWQqSvOWevmKoovsC+9++iJQQ0N0zuks3x3b+wDYKOAgr9xJo5JExevg1sV/1rw1KZci8OdwpM4uPAm87R8IncBiFAN/NgxgEBHuhGzNyP6Mm7CAwYgwtQ26woEsE4Nq6YJ4HzpGdigu3O5IarZhGjuXoie9uNGhF2+GIXjhaBG9nu1csqpqHjGtuavX/La7yPu7XPJ+26t9H4FkavS6Bp6hREVxMAICmj2052ZXitwKHKO7Ikjom8zhXB4nUMV0XvA27Po7e/uJt7wpL1CgQU2QwNrD45WmnAicWp5kfTthgmEIMHB4ZORHq0EvXw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB1801.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.25; Sat, 18 Nov 2023 19:31:01 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%7]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 19:31:01 +0000
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
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQceAAAopgIAAEGgAgAASIACAAAuGgIAG7NMA
Date:   Sat, 18 Nov 2023 19:31:00 +0000
Message-ID: <0900292C-5E74-471A-B789-A1D35D1BBBF7@live.com>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
 <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
 <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
In-Reply-To: <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [llvpse+Vem3z3GK2b86kCQMKyKxCZu4o4mF9Q6dm3to4dP4BtZ4HyIxnOEGniG3j]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB1801:EE_
x-ms-office365-filtering-correlation-id: 07df2145-7dad-4b50-7bc4-08dbe86ce53f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IPWQaHnSHFHXHvvzcpiZsCo4bkrbdnbybuG/bRx1tz/iv/ETSrJB9ALbWfJ38N4xAg/I3ixSB9Ft1XoZn8yqTJy3lUK1dvwlbIFeiBP1nwpK0pDB74Id+0dAnsT/uviw3NDSF+cHZ6tfus+Uc5zi8/V0XmGvea6ezHth6qfBCFr6T5+dCjwchEA3jdbE/sbIP/nYbcxNmmncB1wbg+nXKQ8Ug87xokH6CRyWte4fAA/Y1I9J7mtqVZ4TYsAz/MrJE1uFaN8rfzgDMFkiRfiPleHj0iCpwxc9hfkPxgaPlfjH4Ha6eM2uM7/BpdaZ/7AL86pAZeUQt1yV/8R57F7AqGK3Sc25ikNTFVhMBcqtbjLk99nGvhoqJAfS9za6jPvkSNU2tfe5ImeemjCor/Y++TGx4JiNgvwMJMbM4YOZKgf8NoF06vmJukmxx4MGBhf8dLgcDzKFzGL1EKLfyPhRw7xV96IaWVJ+wKG2ZJDpxn8nWWy0bnkQKADaJWDYHBKSJolPv/TuPZacL6/5tajvYdpgVLloZx8bSDmK9iNZ2IkW7F3qqANdo7CbBYfsp53ifGFutHxob1jYr7LRpRyAvE/jbn3zLNPGWLqQPJXYQ5oG3MY8KHB5j4lZrjn3Wh6v6sNDgMRGzixxQuWxTxscw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lpeDJYZ1ZNMEYyckQxT0t5YjAvNkJiZUpWdHUxNU1yT1dCL0xDa3V3Ykxw?=
 =?utf-8?B?VzNRYXpFck9yK25OajRWaWxja2o5akdtdmtPMXFHWUNKL0g5Ym5meitNU1lp?=
 =?utf-8?B?SjBIYzJvVXphS2YrTzhYTGtKZDRFaEI1ZHR1MDhFL1BpSmg0ZnVRSVNZclhk?=
 =?utf-8?B?OXNrSWFlWWhJOGxZaUNmbHJJbENqSUJBcEFtcEM0UkIvSHd3TENwRFRSek9X?=
 =?utf-8?B?dStlSW5qVlVpWlpsTVNGU1VlSzFISGl2dFZuQUVnTDNWQmF5cFFqbEthN0dC?=
 =?utf-8?B?ME1jNzUySVdldWZaWG1vWFloWkZpOU1aWXBrWWZxZ2lhVzVIaWFCNnVpbzNj?=
 =?utf-8?B?emdYRGppTk9BUHpFYjlkakhRUWx6QWlnL2M3L0JWU0VpU0VNQTE4UXlDNWdQ?=
 =?utf-8?B?czcxRWlOK2xNbm9nRENzckxTV0ZIRjQ3cEtkRHpJOVV3ZWpRQVQ2WjJ3ZXJn?=
 =?utf-8?B?dFl3UmJobGovK1crUFY3YmwraytVYzZUQzdGa1NwKzZNS1hCYjM2c1ovZElk?=
 =?utf-8?B?WGhJdC90ZGZyckJ1VURNdndGU0pvdUhLNnR0enEvVzZpWGxKUmlXSmxvM010?=
 =?utf-8?B?RFEya0I2TG8zaHFuU29tZnhGV0w5NURYR292Y1VOUHdrVSt0YURQcGkzV2Y3?=
 =?utf-8?B?bmhJYkpxdEVWcjduWUJmWnd5STlUbHpXUVNmM2NyQ0VpZitPcjNxNlhFVG5G?=
 =?utf-8?B?SG1GWG1DUTE5Z3NFVUg0V3cwWm5XVVFiRi94Nm9ZMWVsbTRJbnJrUkR6bVBL?=
 =?utf-8?B?ZUNKVGoxbXZHTXZ0bU1OY01GVnBtVlFUVVpEV09xbDQ4ZUd1Wmt5dmN0YlI0?=
 =?utf-8?B?TCsvdGw3N2pYMGNXaTJ4Z1NDL1VEeXIvdG1oTnZKaTVIbms0Szh0TXZrNXor?=
 =?utf-8?B?SU02MnZPNHNUVDNkR0NiUnhmcmhld2pvVGdaNmtSUGFIbURDT1h4MmxuQStO?=
 =?utf-8?B?REpVemtLTHJjRzd6bk42RG5UNWM0WmdwT0lrYVJkcFl6a0wxWUw2TElMcGcy?=
 =?utf-8?B?cWdFblZWbkpSdHFSRXJSSUE2VWl1TDBYTy9DekJ6TGFYMmV0MXFQeUFtam5G?=
 =?utf-8?B?NlNhcVlxbjNza2xZNDBTK0RDS3hjYmZMWWlaT0xabDMwNkZKNHlUa0xOaEpY?=
 =?utf-8?B?ajlWaEFtdDVKTTR2QzZDYzBZN2F6ODlDYndvOTlpV3N1SjNvSURNaGFqY2Z4?=
 =?utf-8?B?b3U2Y0UvU3dmZXJ2bThaRVZwaTBFWUpTSG1JOW45NHVGblpya2FCVjZNVE9a?=
 =?utf-8?B?KzN0RjhrVi91UXp6MWRHZlQrWHRJL0QrbnZSdEIzMDNOZHBKRGs3VkZCNWhw?=
 =?utf-8?B?MjgrNGkxWnVGTmNkbUsrV0h2ZEp4d1lwU1F6cnRKWXVMRE94NmpCMDdlMW8v?=
 =?utf-8?B?N081YnZ2TWpwQm92aDhETXlKYkpIbjZ0N0Z2bmZXU0dOTE5xbVZHYklGelB2?=
 =?utf-8?B?VVRVc0kxblhMQkJkTlNCWTUyZXk1RFVDRnVOVUQ3L294ekp4TlZ6QU82eExC?=
 =?utf-8?B?LzFETndTcDNPb1pkWTd0ajVMTFNMWHIzUnVzcjZDeWlNdTJLYzZYK1BOVGtP?=
 =?utf-8?B?a1cxa0lKNllZcFp1N3lsbktkZFZ0enUyY21XbVd5TngxVFJFYkp6R3VkeVpI?=
 =?utf-8?B?VVY1VTE3WGViSGlJRUg1ZC8rUERubUdmVTgyUktkUlp0bnJ5MGNSbExnbjZ1?=
 =?utf-8?B?WWoySW9MSGt4RHFVK2pDT0tMSmVYeUV4U25RbTVUVTdnbmliOFIyTjgxY1FJ?=
 =?utf-8?Q?wBSyIWeXs1Oy65lfRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <651515DD0CFE134D9804AD3F639320B1@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07df2145-7dad-4b50-7bc4-08dbe86ce53f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 19:31:00.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1801
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTQtTm92LTIwMjMsIGF0IDM6MTTigK9QTSwgSGVjdG9yIE1hcnRpbiA8bWFyY2Fu
QG1hcmNhbi5zdD4gd3JvdGU6DQo+IA0KPiBPbiAxNC8xMS8yMDIzIDE4LjAzLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMTQtTm92LTIwMjMsIGF0IDE6MjjigK9QTSwgSGVj
dG9yIE1hcnRpbiA8bWFyY2FuQG1hcmNhbi5zdD4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMTQvMTEv
MjAyMyAxNS41OSwgSGVjdG9yIE1hcnRpbiB3cm90ZToNCj4+Pj4gT24gMTQvMTEvMjAyMyAxNS4y
MywgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIDE0LU5vdi0y
MDIzLCBhdCA1OjAx4oCvQU0sIEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPiB3
cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiDvu79PbiBNb24sIE5vdiAxMywgMjAyMyBhdCAwODo1Nzoz
NVBNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+Pj4gU3RhcnRpbmcgZnJvbSBrZXJu
ZWwgNi41LCBhIHJlZ3Jlc3Npb24gaW4gdGhlIGtlcm5lbCBpcyBjYXVzaW5nIEJsdWV0b290aCB0
byBub3Qgd29yayBvbiBUMiBNYWNzIHdpdGggQkNNNDM3NyBjaGlwLg0KPj4+Pj4+PiANCj4+Pj4+
Pj4gSm91cm5hbGN0bCBvZiBrZXJuZWwgNi40Ljggd2hpY2ggaGFzIEJsdWV0b290aCB3b3JraW5n
IGlzIGdpdmVuIGhlcmU6IGh0dHBzOi8vcGFzdGViaW4uY29tL3U5VTNrYkZKDQo+Pj4+Pj4+IA0K
Pj4+Pj4+PiBKb3VybmFsY3RsIG9mIGtlcm5lbCA2LjUuMiwgd2hpY2ggaGFzIEJsdWV0b290aCBi
cm9rZW4gaXMgZ2l2ZW4gaGVyZTogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vYVZITkZNUnMNCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IEFsc28sIHRoZSBidWcgaGFzbuKAmXQgYmVlbiBmaXhlZCBldmVuIGluIDYu
Ni4xLCBhcyByZXBvcnRlZCBieSB1c2Vycy4NCj4+Pj4+PiANCj4+Pj4+PiBDYW4geW91IGJpc2Vj
dCB0aGlzIHJlZ3Jlc3Npb24gcGxlYXNlPw0KPj4+Pj4gDQo+Pj4+PiBTaW5jZSBJIGRvbid0IGhh
dmUgYWNjZXNzIHRvIHRoaXMgaGFyZHdhcmUsIGl0J3Mgbm90IHBvc3NpYmxlIGZvciBtZSB0byBi
aXNlY3QgdGhpcyByZWdyZXNzaW9uLiBMZXQncyBob3BlIHNvbWVvbmUgaXMgYWJsZSB0byBkbyBz
byB0aG91Z2guDQo+Pj4+IA0KPj4+PiBJdCdzIG5vdCBhIHJlZ3Jlc3Npb24sIGl0IHdhcyBhbHdh
eXMgYnJva2VuLiBJJ20gc2VuZGluZyBhIHBhdGNoLg0KPj4+PiANCj4+Pj4gLSBIZWN0b3INCj4+
PiANCj4+PiBZb3UgYXJlIHF1aXRlIGxpa2VseSBjb25mbGF0aW5nIHR3byBwcm9ibGVtcy4gVGhl
IHVic2FuIGlzc3VlIHlvdSBxdW90ZWQNCj4+PiB3YXMgYWx3YXlzIHRoZXJlIGFuZCB0aGUgcGF0
Y2ggSSBqdXN0IHNlbnQgZml4ZXMgaXQsIGJ1dCBpdCBhbG1vc3QNCj4+PiBjZXJ0YWlubHkgYWx3
YXlzIHdvcmtlZCBmaW5lIGluIHByYWN0aWNlIHdpdGhvdXQgdWJzYW4uDQo+Pj4gDQo+Pj4gVGhl
IEJsdWV0b290aCBwcm9ibGVtIHlvdSBhcmUgcmVmZXJyaW5nIHRvIGlzIGxpa2VseSAqc3BlY2lm
aWMgdG8NCj4+PiBCbHVldG9vdGggTEUgZGV2aWNlcyogYW5kIHRoZSByZWdyZXNzaW9uIHdhcyBp
bnRyb2R1Y2VkIGJ5IDI4OGM5MDIyNGUNCj4+PiBhbmQgZml4ZWQgYnkgNDFlOWNkZWE5Yywgd2hp
Y2ggaXMgYWxzbyBpbiA2LjUuMTEgYW5kIDYuNi4xLg0KPj4+IA0KPj4+IElmIEJsdWV0b290aCBp
cyBicm9rZW4gaW4gKnNvbWUgb3RoZXIgd2F5KiBpbiA2LjYuMSB0aGVuIHdlIG5lZWQgYQ0KPj4+
IHByb3BlciByZXBvcnQgb3IgYSBiaXNlY3QuIFlvdXIgbG9ncyBkb24ndCBzaG93IGFueSBpc3N1
ZXMgb3RoZXIgdGhhbg0KPj4+IHRoZSB1YnNhbiBub2lzZSwgd2hpY2ggaXMgbm90IGEgcmVncmVz
c2lvbi4NCj4+PiANCj4+PiAtIEhlY3Rvcg0KPj4+IA0KPj4gDQo+PiBVQlNBTiBub2lzZSBzZWVt
cyB0byBiZSBmaXhlZCwgQmx1ZXRvb3RoIG5vdCB3b3JraW5nIHRob3VnaA0KPj4gDQo+PiBodHRw
czovL3Bhc3RlYmluLmNvbS9IZVZ2TVZrNA0KPj4gDQo+PiBJbGwgdHJ5IHNldHRpbmcgLmJyb2tl
bl9sZV9jb2RlZCA9IHRydWUsDQo+IA0KPiBOb3cgeW91IGhhdmUgYSBwcm9iZSB0aW1lb3V0LCB3
aGljaCB5b3UgZGlkbid0IGhhdmUgYmVmb3JlLiBUaGF0J3MgYQ0KPiBkaWZmZXJlbnQgcHJvYmxl
bS4NCj4gDQo+IFBsZWFzZSB0cnkgdGhpcyBjb21taXQgYW5kIHNlZSBpZiBpdCBoZWxwczoNCj4g
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc2FoaUxpbnV4L2xpbnV4L2NvbW1pdC84ZWM3NzBiNGY3
OGZjMTQ2Mjk3MDUyMDZlMmRiNTRkOWQ2NDM5Njg2DQo+IA0KPiBJZiBpdCdzIHRoaXMgdGhlbiBp
dCdzIHN0aWxsIG5vdCBhIHJlZ3Jlc3Npb24sIGl0J3MgcHJvYmFibHkganVzdCByYW5kb20NCj4g
Y2hhbmNlIHNpbmNlIEkgdGhpbmsgdGhlIG9sZCB0aW1lb3V0IHZhbHVlIHdhcyBib3JkZXJsaW5l
IGZvciB0aGUgb2xkZXINCj4gY2hpcHMuDQo+IA0KPiAtIEhlY3Rvcg0KPiANCg0KDQpIaQ0KDQpJ
IHJlY2VudGx5IGdvdCBhIGtlcm5lbCB0ZXN0ZWQgd2l0aCB0aGlzIHBhdGNoIGFzIHdlbGwgYXMg
d2l0aCAuYnJva2VuX2xlX2NvZGVkID0gdHJ1ZSwNCkhlcmUgYXJlIHRoZSBsb2dzOiBodHRwczov
L3Bhc3RlYmluLmNvbS9CcGZKdUpLWQ0KDQpBbHNvLCB3aXRob3V0IC5icm9rZW5fbGVfY29kZWQg
PSB0cnVlLCB0aGUgYmx1ZXRvb3RoIGRvZXNuJ3Qgd29yaywgYXMgc3BlY2lmaWVkIGluIG15IHBy
ZXZpb3VzIGVtYWlsLg==
