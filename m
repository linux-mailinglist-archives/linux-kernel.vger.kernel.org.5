Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8A80BEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjLKCGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:06:07 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2147.outbound.protection.outlook.com [40.92.62.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5173AF1;
        Sun, 10 Dec 2023 18:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoL3Zc/AnPGgh/2VAihGhSSIik+XMNFzl7Q5mKOuOqa172scJpi5IkVgIsOIqGq//n+tXbVbWPLMhqiRPuhOzGey1gW7ObdFEIy6gm4Itg9gzxloRxsYNfqLEfc+f8aAknr334bJlYvOOs6zl9T0y4ghNNoLmdUfIiNuFwW+OoDAJlSdYHNz0CSHVG4MRz/X24G2k0UyP0VBGzXR75vyXxibEYKaZn3CqNdwmVC/8vXq2FJIt+PKxh8FeRiFohclF1LRXciVV2JBqVrFNZBac/Bp1emdFcIE+8b6dBLYKMOrYsDrvMbNVVltBTnhmb3GrMihfDZIEYpWLL53QriI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLrXma0iKtQ4YANLG7k3EgzdKc0/jyhXNRGR6q4yxqU=;
 b=Q7Yj4KTED1y/98a3+gGRDYXWGLEAFVFQZJO9z+r+rvTkQ/r6gEPlQ4VwB1j4mAW8bzWgt1xYAmB8mMFXFVlOz/9Ndad4tZGSGTVL4NXNTOyKA56eSS9GYfLM095qfpjMVj4CTglOGwdSlj2I0bFCXHmitEB7mH6NhaZ09Yfj5f69iPEv/8ZQ9mlov4U8eC8xh+RFlQRoNb/FQzk6GJfHcfIlHlll68VZomBiRyl6oJy7MyB2HCivpmedLxKKln/8h6sY7LamGksdjO2IgcUERFQoYo4A/QNcdcyUPO8JEwMqCS64XstANPmIXX8K9tJA5544Ig26YOPrsbi+K2LrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLrXma0iKtQ4YANLG7k3EgzdKc0/jyhXNRGR6q4yxqU=;
 b=ClwwgEREqAfk7Hd0/eitJcUzVG6HtHR2xbLPNNZzid7nvq6xMwwd3pChl2xQ2DuzWZZpXEAfadZq4PuSae9lupZfwLqLpT3rxXScIJY1sA4Ygd7YnYmsgb9DAWJJgCi4vrFWeDxKyUvRsF6cyR8iR4rm2v1euUZZ+KIH2xOAKiGN9Ezt06DEUn7pgPCo12KELqEC9HgtpMypcEigWyR3q8yTsKx6M4T1E75cCty9mmKwP8+8OCjvWQdymjeOTdP57I5T4Hr6im93essKIiLWvtyKzHryBgQbL0PO+JtKATvxAfv0NGn/1GHwTQn+nfziQcdTM38T7SFJBtka+R6hRA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4446.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:06:05 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6867:103:3120:36a9%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 02:06:04 +0000
From:   Jinjian Song <SongJinJian@hotmail.com>
To:     "loic.poulain@linaro.org" <loic.poulain@linaro.org>
CC:     "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        Joey Zhao <joey.zhao@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Thread-Topic: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump
 support
Thread-Index: Ador1V1ORwze2T3nQnyN9/5dZeY+dA==
Date:   Mon, 11 Dec 2023 02:06:03 +0000
Message-ID: <MEYP282MB2697C6AC993637C6E866E492BB8FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [h2rsSBDy30DQo5U77b5MX4UKCkm3ZhlQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SY5P282MB4446:EE_
x-ms-office365-filtering-correlation-id: ca265cac-2ed9-4dbd-89d0-08dbf9edbadd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkoAQk/W1UXnrxuSQAcoJm2gttl/WHmhBrdEWscSlwiEj2xubk8F1Xrnk/Af9e6L7GoRk3yNUiX3uYiHHv3p2nv76QCTA9OOYClFYkKPaQcKzrIjQ801tchEJlMN2pObLfgOcZfUf7DTE6QWqmtwp7n3lrZq4weuMcdqRJA/kX0OhD/nM+1HcQBdPtv3npLgW5UG7z9BD3DE4edRIQOrH8no8+c657WrutmAVDNwnlmg1cKMth59Q+VtC7/fQuyS+FiiidIRzVVnBhjJNyG0gEXbEcOupsx3tbZ2TwBUgyY7ITOB1xl0CJqMOquGRR2PWuALwsnEo3ii30Conhy2m+Y7Ho4R2lV2LdMvbiSW4SNWjavs7lxKT2uUB6a2dVkYlKqybDkuKYi3EWENyGSHT2lJ0MwfcUHhGwWjoV9spsXrDk28ZJOO+XRZo6LSgHEppgQPt4IKgeM2sbrkT561xJdPLrNa/NvKQxSbb31zdAHjFj6I4Q62MfF1Wt4vf4R7ZFsiRuZTNCW5lMV5Uh8oLPurc+6VUr6Z00sjrNaz4wut4HIm11Hal1ru9l9lTGQgPCVTUbEcLnDiSVO79v4Ku4Ah+8uUdgvDLAikshGPMaY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdITFBTYmwybmIzV08rbkd1T2gwUG8xcXRmVzVBSVZKUVgrKzJNUzlNYmNJ?=
 =?utf-8?B?NVc5a2VVa0RGNCt4WWNKdUJYdURUM0tmbmxoZzFIK2gzVzlvRlBMS3Q5ME94?=
 =?utf-8?B?VlNqd014L2ZqMTZTZXRyWlJSUU5VTE1wMWlkazZaekMvdmZ2V0RTcDlDZ0w2?=
 =?utf-8?B?bThxdnZNVlRqMDNIcmNiNFA2YTdPcEZ5dzVKN1QydWdycDV5N2hHQUpSd1NB?=
 =?utf-8?B?SHpSbUV2UmlRdkFVYnZieU9nUXNjQ2ZrbEpnK2tRckZJMkY5Z0d0Q0ttbnhP?=
 =?utf-8?B?WXcvRWNBQzNKL1JvNVA1dXVVbjc1YlRzeXhlQ08zTXVyV0V4alZOM1E2a0Rx?=
 =?utf-8?B?TlFEaytZUnMvUnpNci9QWWVHeHBEMUhnRVpQQ2ZGdTBZWU1DTVFnQmJvaGZK?=
 =?utf-8?B?WFV0QlVMa0k3bDBFUEVTTGdnaUpQRTJKenJPOFZVbHZDaXR2WXFRRHBYcTZG?=
 =?utf-8?B?RlQ3RVVqMUNZRTBxWGxid3BXVWR3WnplUWJHeW9SRmpQVGYzbG9ycHFQZFNh?=
 =?utf-8?B?d3FrMDdDb1BQNnhPNUdORmZIZDBVMTlNZS9pTnJBalo4UWxORWZGOWY5Y2R5?=
 =?utf-8?B?eTNvR1NTR3B3NXNtSFRibzY4ZGYzd0JpM2pMeGFyV1Jrd3ZPWTNRdXQ3R215?=
 =?utf-8?B?L1BYaU9Db0NqUG5LLzFNUG1TYmNLUXl0N2FrUVRscHducE9JZmR3UHBNZzAx?=
 =?utf-8?B?VjhsOHhGeTlVNFlXQ1dmUmFQL2hwVm9IaWFkWFhQblN2TkZ4S3ErTkxnZE9V?=
 =?utf-8?B?azRnZlhYMXlZdFhEVk9yTWxyNGNQNE1oYzJqd1dnOGNSZHd6UWZGbkNGYW8y?=
 =?utf-8?B?OHRUY2xyOWRFTnd5MktPUXR5eVR0dE0vTGFYVGlZcWw4am1ZcWJRY3E3aDlo?=
 =?utf-8?B?VWhVbDcwNlFhZ2tFUXBpWFZCVmtBWmlSNkkrSkIvMjV2enJ2eHlVbzNqRXVB?=
 =?utf-8?B?a3IrRzF5Mzk2UmFBYzZ5aVdyTTlaaHZNczNWdUI2M2N2ZHFGb3F4dGt2Wmtw?=
 =?utf-8?B?aWd4N1RQVjFkZi9iNXprU2dtWlRwcyt0ZkdVUVIzNVkrNVFIcHQ0b1VyWk9v?=
 =?utf-8?B?WXk0R29ueGtmbDhoTG1pTzc4bld3RDRJNEp4S29sYmdaSDIrODUwYlBaS09s?=
 =?utf-8?B?dlhPSmg1bmxLUGRwVC9vNXV1SDY4SXRlbmMxcmFDTEo4K0ZXVTJZUVNFWVpX?=
 =?utf-8?B?Mzhpdk5kRjlkSGpjczNGbGlxUWcwUFpOV2tQUmUwNzJtUDU3SHF3LzFhSm9U?=
 =?utf-8?B?Y2l2OG5mMGhrQ2F5T09aMVBnZFBQUStoTlU3QjcraUY2YTBPczJ2dXRibUxy?=
 =?utf-8?B?S0tGcUtPcWVaOVJjYkRJL1UzbGRTekxVMFNNTC9FS2dTUTloVFlmNXJMTER1?=
 =?utf-8?B?YTFYVXpoNy83eWVUNXI1cE1mYUg5YXRVeDNZNzN5ZTdsTTBPNTVZemR1NXBS?=
 =?utf-8?B?T2pFdDZmVm00TUswUEJkY3VtWENmem95eXVwM09oZHFLaHNQWGI4ZDJhTGRX?=
 =?utf-8?B?ZlJBUHVadnlOQ1BFcEtFLzVPZUhIYitLRzdkeDlKYXhib1EvbE9FQm9ET1dQ?=
 =?utf-8?B?ZFF0R1dpLzF4d2o5QWUrblJwYklkZVdwVk9SaGdNSDdrUkNwVFpnMjF4VTBW?=
 =?utf-8?B?TG5sWHU1UGZqNmppbXBISXhJODlUbFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ca265cac-2ed9-4dbd-89d0-08dbf9edbadd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 02:06:04.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG9pYywNCg0KVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KPiBPbiBGcmksIDMgTm92IDIwMjMg
YXQgMTE6NDEsIEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+IE1vbiwgU2VwIDE4LCAyMDIzIGF0IDA4OjU2OjI2QU0gQ0VTVCwgU29uZ0ppbkppYW5AaG90
bWFpbC5jb20gd3JvdGU6DQo+ID4gPlR1ZSwgU2VwIDEyLCAyMDIzIGF0IDExOjQ4OjQwQU0gQ0VT
VCwgc29uZ2ppbmppYW5AaG90bWFpbC5jb20gd3JvdGU6DQo+ID4gPj4+QWRkcyBzdXBwb3J0IGZv
ciB0N3h4IHd3YW4gZGV2aWNlIGZpcm13YXJlIGZsYXNoaW5nICYgY29yZWR1bXAgDQo+ID4gPj4+
Y29sbGVjdGlvbiB1c2luZyBkZXZsaW5rLg0KPiA+ID4NCj4gPiA+PkkgZG9uJ3QgYmVsaWV2ZSB0
aGF0IHVzZSBvZiBkZXZsaW5rIGlzIGNvcnJlY3QgaGVyZS4gSXQgc2VlbXMgbGlrZSBhIG1pc2Zp
dC4gSUlVQywgd2hhdCB5b3UgbmVlZCBpcyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBtb2RlbS4g
QmFzaWNhbGx5IGEgY29tbXVuaWNhdGlvbiBjaGFubmVsIHRvIG1vZGVtLiBUaGUgb3RoZXIgd3dh
biBkcml2ZXJzIGltcGxlbWVudCB0aGVzZSBjaGFubmVscyBpbiBfY3RybC5jIGZpbGVzLCB1c2lu
ZyBtdWx0aXBsZSBwcm90b2NvbHMuIFdoeSBjYW4ndCB5b3UgZG8gc29tZXRoaW5nIHNpbWlsYXIg
YW5kIGxldCBkZXZsaW5rIG91dCBvZiB0aGlzIHBsZWFzZT8NCj4gPiA+DQo+ID4gPj5VbnRpbCB5
b3UgcHV0IGluIGFyZ3VtZW50cyB3aHkgeW91IHJlYWxseSBuZWVkIGRldmxpbmsgYW5kIHdoeSBp
cyBpdCBhIGdvb2QgZml0LCBJJ20gYWdhaW5zdCB0aGlzLiBQbGVhc2UgZG9uJ3Qgc2VuZCBhbnkg
b3RoZXIgdmVyc2lvbnMgb2YgdGhpcyBwYXRjaHNldCB0aGF0IHVzZSBkZXZsaW5rLg0KPiA+ID4N
Cj4gPiA+IFllcywgdDd4eCBkcml2ZXIgbmVlZCBjb21tdW5pY2F0ZSB3aXRoIG1vZGVtIHdpdGgg
YSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgdG8gbW9kZW0uDQo+ID4gPiBJIHRvb2sgYSBsb29rIGF0
IHRoZSBfY3RybC5jIGZpbGVzIHVuZGVyIHd3YW4gZGlyZWN0b3J5LCBpdCBzZWVtZWQgdGhlIGlt
cGxlbWVudGF0aW9uIGNhbiBiZSB3ZWxsIGludGVncmF0ZWQgd2l0aCBRdWFsQ29tbW9uJ3MgbW9k
ZW0sIGlmIHdlIGRvIGxpa2UgdGhpcywgSSB0aGluayB3ZSBuZWVkIG1vZGVtIGZpcm13YXJlIGNo
YW5nZSwgbWF5YmUgbm90IGJlIHN1aXRhYmxlIGZvciBjdXJyZW50IE1USyBtb2RlbSBkaXJlY3Rs
eS4NCj4gPiA+IEV4Y2VwdCBmb3IgUXVhbGNvbW0gbW9kZW0gZHJpdmVyLCB0aGVyZSBpcyBhbHNv
IGFuIEludGVsIHd3YW4gDQo+ID4gPiBkcml2ZXIgJ2lvc20nIGFuZCBpdCB1c2UgZGV2bGluayB0
byBpbXBsZW1lbnQgZmlybXdhcmUgDQo+ID4gPiBmbGFzaChodHRwczovL3d3dy5rZXJuZWwub3Jn
L2RvYy9odG1sL2xhdGVzdC9uZXR3b3JraW5nL2RldmxpbmsvaW8NCj4gPiA+IHNtLmh0bWwpLCBJ
bnRlbCBhbmQgTVRLIGRlc2lnbiBhbmQgdXNlIGRldmxpbmsgdG8gZG8gdGhpcyB3b3JrIG9uDQo+
ID4NCj4gPiBJZiB0aGF0IGV4aXN0cywgSSBtYWRlIGEgbWlzdGFrZSBhcyBhIGdhdGVrZWVwZXIu
IFRoYXQgdXNhZ2UgbG9va3MgDQo+ID4gd3JvbmcuDQo+ID4NCj4gPiA+ICdtdGtfdDd4eCcgZHJp
dmVyIGFuZCBJIGNvbnRpbnVlIHRvIGRvIHRoaXMgd29yay4NCj4gPiA+DQo+ID4gPiBJIHRoaW5r
IGRldmxpbmsgZnJhbWV3b3JrIGNhbiBzdXBwb3J0IHRoaXMgc2NlbmUgYW5kIGlmIHdlIHVzZSBk
ZXZsaW5rIHdlIGRvbid0IG5lZWQgdG8gZGV2ZWxvcCBvdGhlciBmbGFzaCB0b29scyBvciBvdGhl
ciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucywgdXNlIHVwc3RyZWFtIGRldmxpbmsgY29tbWFuZHMg
ZGlyZWN0bHkuDQo+ID4NCj4gPiBQbGVhc2UgZG9uJ3QuDQoNCj4gU28gdGhpcyBpcyBjbGVhciB0
aGF0IGRldmxpbmsgc2hvdWxkIG5vdCBiZSB1c2VkIGZvciB0aGlzIHd3YW4NCmZpcm13YXJlIHVw
Z3JhZGUsIGlmIHlvdSBzdGlsbCB3YW50IHRvIGFic3RyYWN0IHRoZSBmYXN0Ym9vdCBwcm90b2Nv
bCBwYXJ0LCBtYXliZSB0aGUgZWFzaWVyIHdvdWxkIGJlIHRvIG1vdmUgb24gdGhlIGdlbmVyaWMg
ZmlybXdhcmUgZnJhbWV3b3JrLCBhbmQgZXNwZWNpYWxseSB0aGUgZmlybXdhcmUgdXBsb2FkIEFQ
SSB3aGljaCBzZWVtcyB0byBiZSBhIGdvb2QgZml0IGhlcmU/IGh0dHBzOi8vZG9jcy5rZXJuZWwu
b3JnL2RyaXZlci1hcGkvZmlybXdhcmUvZndfdXBsb2FkLmh0bWwjZmlybXdhcmUtdXBsb2FkLWFw
aQ0KDQoxLlRoaXMgQVBJIHNlZW1lZCBmaXQgaGVyZSwgYnV0IEkgaGF2ZW4ndCBmaW5kIHRoZSBy
ZWZlciB0byB1c2UgdGhlIEFQSSwgY29kZXMgaW4gL2xpYi90ZXN0X2Zpcm13YXJlLmMgc2hvd24g
c29tZSBpbnRydWR1Y2UsIEkgdGhpbmsgaWYgSSdtIGNvbnNpZGVyIGhvdyB0byBpbXBsZW1lbnQg
b3BzLnByZXBhcmUod2hhdCB0byB2ZXJpZnksIGl0IHNlZW1lZCBtb2RlbSB3aWxsIGRvIHRoYXQp
IGFuZCBvcHMucG9sbF9jb21wbGV0ZT8gQW5kIGl0IHNlZW1lZCByZXF1ZXN0X2Zpcm13YXJlIEFQ
SSBhbHNvIGNhbiByZWNpZXZlIHRoZSBkYXRhIGZyb20gdXNlIHNwYWNlLCBpcyBpdCBhIHdheSB0
byB1c2Ugc3lzZnMgdG8gdHJpZ2dlciByZXF1ZXN0IGZpcm13YXJlIHRvIGtlcm5lbD8NCg0KSW4g
YWRkaXRpb24gdG8gdGhpcywgSSBtYXkgaGF2ZSB0byBjcmVhdGUgc3lzZnMgaW50ZXJmYWNlIHRv
IHBhc3MgdGhlIGZpcm13YXJlIHBhcnRpdGlvbiBwYXJhbWV0ZXIuQW5kIGZpbmQgYSBub3RoZXIg
d2F5IHRvIGV4cG9ydCB0aGUgY29yZWR1bXAgcG9ydCB0byB1c2VyIHNwYWNlLg0KDQoyLkhvdyBh
Ym91dCB3ZSBhZGQgYSBuZXcgV1dBTiBwb3J0IHR5cGUsIGFic3RyYWN0IGZhc3Rib290IGFuZCBk
dW1wIGNoYW5uZWwsIGxpa2UgV1dBTl9QT1JUX1hYWCwgdGhlbiB1c2UgdGhpcyBwb3J0IHdpdGgg
V1dBTiBmcmFtZXdvcmsgdG8gaGFuZGxlIGZpcm13YXJlIG9wcyBhbmQgZHVtcCBvcHMuDQoNCkhv
cGUgdG8gZ2V0IHlvdXIgYWR2aWNlLCB0aGFua3MgdmVyeSBtdWNoLg0KDQpJIHdhbnQgdG8gaW1w
bGVtZW50IGl0IHVzZSB0aGUgd2F5IG9mIHRpdGxlIDIsIGNyZWF0ZSBhIG5ldyBXV0FOIHBvcnQg
dHlwZSB1c2VkIGZvciB0aGUgY2hhbm5lbCB3aXRoIG1vZGVtLg0KDQpSZWdhcmRzLA0KSmluamlh
bg0KDQo=
