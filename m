Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2647EAD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKNKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKNKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:05:48 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2037.outbound.protection.outlook.com [40.92.102.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DE8196;
        Tue, 14 Nov 2023 02:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbzRndLNyiXpj8hg3VaCj0Tz5roex4vuKL3neFF22osHykwALnEJsmEL2k12v9PUQ8Ixa2MR90KwSpur+CH0pFdptPAs2NihjN/fmLQlViUSFKZXIs7v4TVLXk9x6cTHaP9GFviUjVMheGV8NsAMDuj12iOnQUDu2IOA4Sizc7PdqE4cVD8kTdZpb/xeIEFECOazbRauyHDM5g/oOwbmNMGYAHVQnaw6PS1sKHDRZq8lNSuI4tc6taL1k1o6Ue/0WSkMCB4khrC+GjXEw1peEnBs4YL0Mv5IZSKIfgrbkWMrNZD3g0fRe0bcsw4eWI5s3B90nOJcAOOuUVLxZILazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnaENNPx1Oygjz+Se9BFiEfR9XwlKlt60ALaMLBsZQE=;
 b=gcWKu8lqln7cxGCORlFI/KWQ8YrNskmbwhIfZgkC4Va9uaSqtQYnFC5D48Xh2tMbqqeUbBFMnVDSm2pkhOIvbC7kOrgmqnikAv5VDoFwk2ZyVKmnFiLF6whwJutmxR67ocKr8iNbB1hATzow4XXD173coF4/26Ife3gUdruy9fNrm5MprA0TKTP9GR5Y/ISIgW5EjO81WUVVB3VpuV0rMfzyw1tsoSVojhopntBKoCC3DxU0igDTwwSDN6SkTOFecBx/ArbWVpkanD5VLfA462vmsp72+KzKkdacOji2HXli5V3tKnyHAZhmU6clXvv7SOR8qqFieMe8UY5T4qvWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnaENNPx1Oygjz+Se9BFiEfR9XwlKlt60ALaMLBsZQE=;
 b=p51d23eCHf1T3S/EkX6/6kHb9gDS2iOkTnwl+/rprBhbJoUnvKJ3DEqGXZaTqtAzCUPHuX+dF+RAHbO6cy7EVjZoIHqJEoZhw4O2BeFgKMEiHTaLRT+PWiHBUbdcZKCUl3wc4TXTMWXlGgF8ofsM/h92Ay8xDKxzUU5Z1CQGVBRo9utTb5ONJIqkhRACI3iWefcUoVsD2OlVgY+V0YlNDFXrywLXFXs/ARFTOIoKCEZaTkBTMMMEJoElP0IpDrTC4n350QIBkGDutpo5itTK1oHMf97iubwXnXx2V0VKbDznFLTYnNS2LhADdUZbjhKv0PjRLVJYdOJmw1Zgo9bU9g==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB1718.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:198::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 10:05:36 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 10:05:36 +0000
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
Thread-Index: AQHaFnQHPuYl63BuYUeFaxX8dCI6lbB45gMAgABzQceAAAopgIAAEGgAgAASIACAAAuGgIAABdak
Date:   Tue, 14 Nov 2023 10:05:36 +0000
Message-ID: <MA0P287MB02178B620C4AA55766E6A64DB8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
 <e2909986-34b5-3ae2-cf5c-a1f8c46a1e0a@marcan.st>
 <6574A65F-3C4D-4E26-8848-F12C38668478@live.com>
 <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
In-Reply-To: <03cdd06c-3991-dbf8-6068-e76384db8240@marcan.st>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [SUmJU7lzQLMWJ4g80Io/aWcGrlUuRgPHcg77Jx5B0dXCgxzN7iC7gvgz30LNIGhz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB1718:EE_
x-ms-office365-filtering-correlation-id: 586d41a8-21b5-4d98-1962-08dbe4f93f85
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: poQ1JMrNJ3wUJrRmQkpzT4Pu8pggHoEvOL9WTLdTG3LsuI64p21XA17UM3GJIBoZPWWZJiK8i0K6VNKe16GqihW3a5TMhSVlduhMu6Cn70xickJNYVtYg4uGXuj7J8/3Muu6y4fykWL6OGYvsq1049GGFad09lLg/tVFKzc60eDAqnXUOjp2zmayfq3fTsvTOGY1yqPr6jh6mpNd4R5mxhYhbDT5+S8gFw8tUrDbibO87Oq5KPnX3HR+oZ8UyMvD3t5bdIm6KymQ8j1evmDF6byLbp5ny9m8Ee7J51LpSySMoCtIJnx+zjYaM18Z7VFME9TI6+Pq55b4zbr1+/qic7LbNFvYTzQgoxLPADJl4gjs2Pgi4BRxUX9s7jPToMZea1ZdWjKUkF3XbXP5Q3O0SQzzYoa9Dsz86o7wdYB0HXAjZjswQzilLRqeWYNNREs4I3rbZ1N0P8HOYU8G1HSJ2u93AAtERiq2H/pbXUgCzLaVd95KodSCBCruaXGsSNK5SpJY39GrLIxDiOsfbh3ueyYcxjKb8wOfTxXtGb1e6FvZNvBeIhsHu7/h1mIoDneUifgpcmUQ99b6DZgUvVm5KnzoIGpvx1e8P+8RWz5rDKI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtndUF4SkVXU2drQ0YyUURSNlNlTjE4VUNDTEhKc01KZEJjbnlFSTdrM3BT?=
 =?utf-8?B?SGhFVUxXT2FId3lHYU5RSC9ndndrR3dQM2lPUUIvM2JOeVNrRDJ1T3NNdWU2?=
 =?utf-8?B?OXNuTzAyWmRFaTNBWkJGd2R4UDFtcG1jUzNGZGJDMFpnUTlFM2hFR2dhQ09o?=
 =?utf-8?B?UW4zejA5UTFwM2dacGlqOVljcDlDNUxnUEF0anJqQzdnZDcydDdVazdDWjMv?=
 =?utf-8?B?S1RTbTJzcXVIWWt1WDV5cFpteC9xZWNhYmRiMW1XUUFQV2hQSGVGRXdjU1VD?=
 =?utf-8?B?bTcwVHRLaVdreVp5c2xsMUgwZmZScXVncUZUNXJhdDdTTWVtbmZtQmp1aGtH?=
 =?utf-8?B?SlVVUjdnVy80cnphZ2RwOUluTFN3amxNcDZZVEN6YkdYRGcwYXNYTlEydVVE?=
 =?utf-8?B?TEtIQXlFRElXVThZZ2huUUdIclBPWmphZUEyQzZmVVNyYlk0NnRpQlYyZ1Er?=
 =?utf-8?B?djU4L0ZkNkpOMEw5TUVQdXlaUnVBenpoTXdxYVc2c2NtQ0t6Q1FYU2h0cWtH?=
 =?utf-8?B?ZjM1NnFuV0l4RnJnUStpcWpWOU1DM0xZY2Z5Rk5YUDVCVWIwSUJXbzNseVNP?=
 =?utf-8?B?eDBDZUIvQ2RsY2p6VVY1Q1B1dlA5KzM1akNTaHB6UTBuYTFLZWVEN1djRHlD?=
 =?utf-8?B?VHYxRzVHOVNpOXFPLzBNamZKaTF3anpPOUtOaHhQOThLekhTMmFnYlFGaVJ2?=
 =?utf-8?B?RWVNcDdPdkIvOHpGYksvY29WTWZpTU8vUXJrUVJKZ3lTaTJzK0xWSlBtUysv?=
 =?utf-8?B?UjFVZnpHRy9oaGdlUVVoWk9TTjYySzVOeUwzdnJTb0lIVmFFZDd3RXF1aW94?=
 =?utf-8?B?NHJ6d002cnRhMDdKYWovWmVGYzNrbDhjdHRyY3ZmMFF6Ymc2NVllNi83eUZX?=
 =?utf-8?B?a0hKOG5mbFczQ3o0SUhtdW9FRXcwM0tVSmROZ2RTUWh4azBCNURueHRJdDU1?=
 =?utf-8?B?anl0QXFPa0VmNTZ2STd6UGJlMThqSm5vWkNIUHQzMldtMEFUTGNQSXI2M2hy?=
 =?utf-8?B?MUI0MmVyQTdNQUNwaUNRUjIvSTNMQ1QwT05hcVgwaTIrUkNPWDRhK3NDR0VN?=
 =?utf-8?B?eHhLdUlqbXczaFpwM0Nkc0lQNjhoVXp2OUJsUkNLZWorNlYySmk3bENZQ203?=
 =?utf-8?B?UVpuMzBUNEk4aGhraXV3UmJma2wzRW04ZVBNSklWSjQxMXNVaFF0YUJTTU5S?=
 =?utf-8?B?c2EwWVFEVER5eGl0UVlKeXZzTE1RMnRRU2V5Y2ZIcGpDY1hwNTM1NDBnRE9X?=
 =?utf-8?B?VEhMU0t3UkhXSFNnNmsvb2RMaklZL1RxcHlxc0RkZ1NBRVdJeVZPbUdic3Yx?=
 =?utf-8?B?VGEyS09oMHh4UlNJSlQ5ZE5jclJiL1puVzVoZlh0RnhMcHRPM0RXMjlYb0Y4?=
 =?utf-8?B?OHVqNlJSckdxVmh5S21EYW9GRklUN2QxUTU0ZU4yOGFTcHhodHlNdjhyZ0Ro?=
 =?utf-8?B?Q1pOQzVLUlNjQ21NVEY4UDE5RWc0dmRoQ3o5VmpnZUs2ZHBTU1UwR0ZjUWNa?=
 =?utf-8?B?aVpWNWlQbDBpS3pLbm9CMTQrMmljMkkzaytoaFZGejlud2J6SUpvOStOUjhj?=
 =?utf-8?B?TTQ4VzFzbnNiVk9Lb2FSNzZ6MVFvdWp6RUZUVnVUUExicVQ1U1dkMkxVcXRi?=
 =?utf-8?B?N0ZVbHBmSnZTOWF1MWdZZ1dyZjViRC92U21Ram5jOHVrWnMrWTdTMVZnbGVu?=
 =?utf-8?B?U25SOTZuV2ZNb1Q1dUViNjhrb0NKdEI0cXZpd2tCelI2ZDZoRUpONHJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d41a8-21b5-4d98-1962-08dbe4f93f85
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 10:05:36.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1718
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTQtTm92LTIwMjMsIGF0IDM6MTXigK9QTSwgSGVjdG9yIE1hcnRpbiA8bWFyY2Fu
QG1hcmNhbi5zdD4gd3JvdGU6DQo+IA0KPiDvu79PbiAxNC8xMS8yMDIzIDE4LjAzLCBBZGl0eWEg
R2FyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+IE9uIDE0LU5vdi0yMDIzLCBhdCAxOjI44oCvUE0s
IEhlY3RvciBNYXJ0aW4gPG1hcmNhbkBtYXJjYW4uc3Q+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDE0
LzExLzIwMjMgMTUuNTksIEhlY3RvciBNYXJ0aW4gd3JvdGU6DQo+Pj4+IE9uIDE0LzExLzIwMjMg
MTUuMjMsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+PiBPbiAxNC1O
b3YtMjAyMywgYXQgNTowMeKAr0FNLCBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNv
bT4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4g77u/T24gTW9uLCBOb3YgMTMsIDIwMjMgYXQgMDg6
NTc6MzVQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+Pj4+IFN0YXJ0aW5nIGZyb20g
a2VybmVsIDYuNSwgYSByZWdyZXNzaW9uIGluIHRoZSBrZXJuZWwgaXMgY2F1c2luZyBCbHVldG9v
dGggdG8gbm90IHdvcmsgb24gVDIgTWFjcyB3aXRoIEJDTTQzNzcgY2hpcC4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IEpvdXJuYWxjdGwgb2Yga2VybmVsIDYuNC44IHdoaWNoIGhhcyBCbHVldG9vdGggd29y
a2luZyBpcyBnaXZlbiBoZXJlOiBodHRwczovL3Bhc3RlYmluLmNvbS91OVUza2JGSg0KPj4+Pj4+
PiANCj4+Pj4+Pj4gSm91cm5hbGN0bCBvZiBrZXJuZWwgNi41LjIsIHdoaWNoIGhhcyBCbHVldG9v
dGggYnJva2VuIGlzIGdpdmVuIGhlcmU6IGh0dHBzOi8vcGFzdGViaW4uY29tL2FWSE5GTVJzDQo+
Pj4+Pj4+IA0KPj4+Pj4+PiBBbHNvLCB0aGUgYnVnIGhhc27igJl0IGJlZW4gZml4ZWQgZXZlbiBp
biA2LjYuMSwgYXMgcmVwb3J0ZWQgYnkgdXNlcnMuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQ2FuIHlvdSBi
aXNlY3QgdGhpcyByZWdyZXNzaW9uIHBsZWFzZT8NCj4+Pj4+IA0KPj4+Pj4gU2luY2UgSSBkb24n
dCBoYXZlIGFjY2VzcyB0byB0aGlzIGhhcmR3YXJlLCBpdCdzIG5vdCBwb3NzaWJsZSBmb3IgbWUg
dG8gYmlzZWN0IHRoaXMgcmVncmVzc2lvbi4gTGV0J3MgaG9wZSBzb21lb25lIGlzIGFibGUgdG8g
ZG8gc28gdGhvdWdoLg0KPj4+PiANCj4+Pj4gSXQncyBub3QgYSByZWdyZXNzaW9uLCBpdCB3YXMg
YWx3YXlzIGJyb2tlbi4gSSdtIHNlbmRpbmcgYSBwYXRjaC4NCj4+Pj4gDQo+Pj4+IC0gSGVjdG9y
DQo+Pj4gDQo+Pj4gWW91IGFyZSBxdWl0ZSBsaWtlbHkgY29uZmxhdGluZyB0d28gcHJvYmxlbXMu
IFRoZSB1YnNhbiBpc3N1ZSB5b3UgcXVvdGVkDQo+Pj4gd2FzIGFsd2F5cyB0aGVyZSBhbmQgdGhl
IHBhdGNoIEkganVzdCBzZW50IGZpeGVzIGl0LCBidXQgaXQgYWxtb3N0DQo+Pj4gY2VydGFpbmx5
IGFsd2F5cyB3b3JrZWQgZmluZSBpbiBwcmFjdGljZSB3aXRob3V0IHVic2FuLg0KPj4+IA0KPj4+
IFRoZSBCbHVldG9vdGggcHJvYmxlbSB5b3UgYXJlIHJlZmVycmluZyB0byBpcyBsaWtlbHkgKnNw
ZWNpZmljIHRvDQo+Pj4gQmx1ZXRvb3RoIExFIGRldmljZXMqIGFuZCB0aGUgcmVncmVzc2lvbiB3
YXMgaW50cm9kdWNlZCBieSAyODhjOTAyMjRlDQo+Pj4gYW5kIGZpeGVkIGJ5IDQxZTljZGVhOWMs
IHdoaWNoIGlzIGFsc28gaW4gNi41LjExIGFuZCA2LjYuMS4NCj4+PiANCj4+PiBJZiBCbHVldG9v
dGggaXMgYnJva2VuIGluICpzb21lIG90aGVyIHdheSogaW4gNi42LjEgdGhlbiB3ZSBuZWVkIGEN
Cj4+PiBwcm9wZXIgcmVwb3J0IG9yIGEgYmlzZWN0LiBZb3VyIGxvZ3MgZG9uJ3Qgc2hvdyBhbnkg
aXNzdWVzIG90aGVyIHRoYW4NCj4+PiB0aGUgdWJzYW4gbm9pc2UsIHdoaWNoIGlzIG5vdCBhIHJl
Z3Jlc3Npb24uDQo+Pj4gDQo+Pj4gLSBIZWN0b3INCj4+PiANCj4+IA0KPj4gVUJTQU4gbm9pc2Ug
c2VlbXMgdG8gYmUgZml4ZWQsIEJsdWV0b290aCBub3Qgd29ya2luZyB0aG91Z2gNCj4+IA0KPj4g
aHR0cHM6Ly9wYXN0ZWJpbi5jb20vSGVWdk1WazQNCj4+IA0KPj4gSWxsIHRyeSBzZXR0aW5nIC5i
cm9rZW5fbGVfY29kZWQgPSB0cnVlLA0KPiANCj4gTm93IHlvdSBoYXZlIGEgcHJvYmUgdGltZW91
dCwgd2hpY2ggeW91IGRpZG4ndCBoYXZlIGJlZm9yZS4gVGhhdCdzIGENCj4gZGlmZmVyZW50IHBy
b2JsZW0uDQo+IA0KPiBQbGVhc2UgdHJ5IHRoaXMgY29tbWl0IGFuZCBzZWUgaWYgaXQgaGVscHM6
DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vQXNhaGlMaW51eC9saW51eC9jb21taXQvOGVjNzcw
YjRmNzhmYzE0NjI5NzA1MjA2ZTJkYjU0ZDlkNjQzOTY4Ng0KPiANCj4gSWYgaXQncyB0aGlzIHRo
ZW4gaXQncyBzdGlsbCBub3QgYSByZWdyZXNzaW9uLCBpdCdzIHByb2JhYmx5IGp1c3QgcmFuZG9t
DQo+IGNoYW5jZSBzaW5jZSBJIHRoaW5rIHRoZSBvbGQgdGltZW91dCB2YWx1ZSB3YXMgYm9yZGVy
bGluZSBmb3IgdGhlIG9sZGVyDQo+IGNoaXBzLg0KPiANCj4gLSBIZWN0b3INCj4gDQoNCkFscmln
aHQsIEknbGwgZ2V0IGl0IHRlc3RlZC4=
