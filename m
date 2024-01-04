Return-Path: <linux-kernel+bounces-16403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B418823DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD4BB2269E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BBC1EA8F;
	Thu,  4 Jan 2024 08:55:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2075.outbound.protection.partner.outlook.cn [139.219.146.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980711EA7D;
	Thu,  4 Jan 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ0PR01MB1271.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::13) by ZQ2PR01MB1274.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 08:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtgQCGGy3JLuyS4mErMK1il+nu8SY+LUy5ubzGLwS5apHVDZDB7cOxEt+JzzAL59PW1uDN8ooVqtPGCBsyh7swD4dZzMKHE4ZJjHm/R7Te0Gw7970EGXXqOzV8ARix1VLFKe+8EdmxlAadks/sGPyVSiWYDZg3F/Vmf7wwF1szpKu5ms9D//JvH2/6vk2ZZIrwtFUppka01hGDHEzVX6gJEX2zwsREW+QJ+aGMaxnuhXVMeN+cjDIVnaDjmYziG6Ca6IevPooD7xTNK2tQiyajBP1DOuim81XWq/16d2sjgpZZ6hK+PM9ajN5cHIPPBzJ8Lu9k+GP5gpQh5m1C35qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS/gxIBoxCJyAYk0tPdRN2cQoWkPn5itoABvnfir5HA=;
 b=ljIvTM0rZDO8LTERYnkIQR8AdA5/gogBaSe/hPT151gYI0hrVvjf5mb0OYe/IfdlCb41AodOW1uXuQPOaI74tjtHL+3abOj7lshxcrf+pOUvGolvV7slj7vdTtlJrwkzZvnltPZtbJxQy3/X1NsKUr1s4Myxpu+J4qwtz63Zcv3dwMTWhW+XLK8yVifYcKlSbfdwIwh1v62yGF0qG7of2fnFFK9I5giY8DmaaDEBRVsEBpkkfjuSJP+mK8tPDLh2ExUIljdvARA7WjI5NEwVPkuxlXGvjCl5UvSP+k/M/jgovdHtREfBeU2v6sury6NBFGfII4X0NhNrIQ7lA4a+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1271.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 02:57:32 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::bc6e:a7fa:7ab5:7417]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::bc6e:a7fa:7ab5:7417%4])
 with mapi id 15.20.7135.026; Thu, 4 Jan 2024 02:57:32 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Yuklin Soo
	<yuklin.soo@starfivetech.com>
CC: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng
	<hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Drew
 Fustini <drew@beagleboard.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Topic: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Index: AQHaM+jQtC6UubUli02XCaS05iYu97CzPUUAgBXKZ+A=
Date: Thu, 4 Jan 2024 02:57:31 +0000
Message-ID:
 <ZQ0PR01MB13028072D9A36AED92CB1519F667A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <CACRpkdYL8wK2vX7P7p4QvU9VV2CPjRv_aXiLqO+07MMCCKKk4Q@mail.gmail.com>
In-Reply-To:
 <CACRpkdYL8wK2vX7P7p4QvU9VV2CPjRv_aXiLqO+07MMCCKKk4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ0PR01MB1302:EE_|ZQ0PR01MB1271:EE_|ZQ2PR01MB1274:EE_
x-ms-office365-filtering-correlation-id: 03124621-5f89-4917-557c-08dc0cd0e55b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nksblm3NEq2jYAW5VR3JF6RljUSV0Z79fxMgyKZxHqkM6H5pLyMcZ0dNUthysOgT5iuXNnP4EVlUVAucoUG6Mh0dhCJkj/bXZtnlnLsvEEiFCOTP0nH7R+oAs+1gmlTMvpKVBCl37f9Jgwn8iTbBpBML2EwvpU7Vok3huIQimKJHuvjdS6GArOJ8EZ0T8hoKZmepgfaJ4tpQ4pn6A9+Efvmbba+bpWUZ6rmmypbLugd0/qgzFHuki40mo7c33dJUSnnNUAhcDOIRkfSQUN4NAA5TrO8lgk5dC80yF+Wk9a+fgIkqHuW+rmiA+hmZdr31RnKqW0O1fQ+g4nF6pg2FXtTreil9dRuu6/nU1rz78wOFCUq+UoHurQI+jNTcr23vEtX4hC2PASJZJBaAyrl/Lru9N/ya3EGiS0LsgzUQX3ATVFRqa3zYKFONoM3cdhJg7N+UZvQC8VvB8D8MpdSY4FxsI5xKwDkfa09GF0phZkr3eSR5Dv17fYfU/k3700D6LIUSCeLW2XmBpmvZHpqRbTBZLy3BcLqnNKWh73ONtIAdL2WXUHYXDclNQ8vFc/DL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39830400003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(40160700002)(4326008)(33656002)(7696005)(53546011)(38100700002)(55016003)(122000001)(9686003)(83380400001)(71200400001)(508600001)(66556008)(41320700001)(76116006)(66476007)(66446008)(110136005)(64756008)(54906003)(66946007)(8676002)(8936002)(38070700009)(44832011)(41300700001)(40180700001)(86362001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2VXd3U2Q1YycnpyelpCMHlPL25xSHkyaTFud0Nsa1BaaHRHNzlkSThGZm9i?=
 =?utf-8?B?MGN2SGhuNXZON21QMVBWSXJkckU3dE11MmRONktUNzhPcEZpdjlrN0FiSU1O?=
 =?utf-8?B?U3IyZmpIbEd0NWNRL0ZpaFVtNlVNeGREaDV2T1FCam1Nd1d6amhYdGFzNVhm?=
 =?utf-8?B?WVdGVVZyNmtrYWZVbEhab0grSWtDSUpQaTl4aHlRUXp1U2p6dWJLOG5EdDZm?=
 =?utf-8?B?SllEc1kxZlFZbnV6RExSdDhSZHpuQ3MyQUE0Y2JBVTF0ajRUdy9YKys5cGdB?=
 =?utf-8?B?Rm51N1ZjNzZXTVZDb3QvVHY1RXEwME1PSzkxY2pMS2tva25xS3k5V0tlTkxo?=
 =?utf-8?B?ZVVpeFN3NmN6YThDNDNrSHBtK2laQWRoZVNNMkI5Yk1IQ3crVzF4WU5DOVpF?=
 =?utf-8?B?MmQ2R3dsQTNHVkVwLzZtUXBnSG5QNzduczByQWdTMDRhZU1YajhGc254Vmpx?=
 =?utf-8?B?eExheWRZenU1R0g3blBaZVpnY2VKd21tN0w0cFMzbjR6VW4reW4zamZ1eGRO?=
 =?utf-8?B?ckt1ZDhyUkUwUzRBNEY5Tnc3bFVKekdVSWxmbitsQ1V0dkFPNWRrUTNUL3pl?=
 =?utf-8?B?TzhYZCsrSzZKUkRpY3V3OEJBV3Vaajc5c2s1b2VWT08rNlBjM3pkQ0p5ei9I?=
 =?utf-8?B?dU9MK09sQnoxWVhoSXF4WmJPME5oYW94ZTN4TDBLek5FRFdGdmdwN1Q0Zm91?=
 =?utf-8?B?S2EzazRucVZiWFZBaFpKYmlkVURoR1Q3UUNRVzNxY2U0Y2lFUkNCUzc2NHpk?=
 =?utf-8?B?T1E2dzljZHhwczV3ZjNqSHNnMUc5eUVZdlNWN0dzRGduVjRnM05YOGVjUnVH?=
 =?utf-8?B?OUl2SkFnM3JUa3RQTlNKeHUvYklYM21JeUxFbTBlWXNocDIzZGRTYUxvQzN4?=
 =?utf-8?B?WE5FeWRuZmsvZXNhWUZLMnJwSFJPem1pUnlkZ1YwUjc3d0ZiK0t3SWIzWkxq?=
 =?utf-8?B?bXRwcDBxeUFaUzZ4Q1ZOYkJYTjF2ejk1RWtUTXBzS1plem9YVER6T2VyYm1m?=
 =?utf-8?B?VUZwRDdOTkMxb0NVVmRRWXdhZUY3RDF1ejZuMmJGWDFZMEx1OUhaajVHeGVa?=
 =?utf-8?B?MGJFaDFQTSsycFdwdWxsYVNtbWFDNTJhNkxTUEpIY2c2Q0JNVzFEbTY1bjVj?=
 =?utf-8?B?SzQrZVdWMGNLbzhpUEFLVG94TExnZFJmQ3h5UHpaUUxnQ2tiWVpvTWhkOFRs?=
 =?utf-8?B?UlNIYXFBUUwvWTNDMVFhS3dhRE00Q2pqRHZ1ZFdPNlRxakU2RndFN2FpNWZJ?=
 =?utf-8?B?Um1lZ2NFaWwyNG55ZElNVjJiRFdsbDhGZS9VODBPelNtZmYzMmpKZ0xFVDRC?=
 =?utf-8?B?S3Q4NkpWb1hDOVBqTEQwYVFFbFVOcHBRL25lajlJZ21STWI2cGcwVzFNMHVL?=
 =?utf-8?B?M3drT2pRM3YvaVNUeE1ma3prVDJkQWI5OU9lb1d5OEsyVFAwV0dHR3NkUzhG?=
 =?utf-8?B?UzFGYWhQaXgxY21HaXVGVEhWNlNrUnRpR1ZuZXhZYkIwd3RTSUNxVHJhMm80?=
 =?utf-8?B?eldEM3Y2UnAzTmVMN2NTWVNKa0l3UHJQMXpqZlA3dHNoUmJQaDhTcWxLSDVX?=
 =?utf-8?B?QURQcGdaWWJ4Y3Q0a2FrUXJ2a0h3eHlzQUFCUXZpSjZZZU9WNGVmbkZxZTBG?=
 =?utf-8?B?QjJ4anpqUDFTcG9uUXRkQWlLWFl1bFhSNkdvSExtTDhsYzUzRWxYVGRXc21K?=
 =?utf-8?B?dWx1YXpScXY2ckQydVFsZXpTdHFveFVkSU01OVVwRlVPM2lLZnFwUUxjb1JX?=
 =?utf-8?B?d042SmUzRTl1OUU2cmRFQUh0LzNVMzZyQ1N2NTVJT3MzZXkzYjJPdm1RRzM3?=
 =?utf-8?B?MzVab3lidm5ETEEvSHNFQXJtQkpzY1luV2NHRWZsL3hkRjFsS3N5eFBHQUlI?=
 =?utf-8?B?S0pzQjVtbU90VUxkTkhOcUtESEZhRTNmelY3ZDJxWnIybHd3RDh5TUhKWG50?=
 =?utf-8?B?S3FOczJwaGVqekFJYnlycXE5YitmL0tkR2ViMjNqNUhtNUdnc1hvOGRUUWg1?=
 =?utf-8?B?VEtzNzRWM0FpNnZra3ZCaGFBa1BjUGVJZVJpK05PZmkxMzRiVlg4aGZhUElW?=
 =?utf-8?B?dVVhVnRrekFvdm9LNHUxY1hTem9tK20xdzV6WU1kbHVHbURRRCt1ME1nZzE0?=
 =?utf-8?B?MzdFcUQ0N21Xc3Zac2ZKc3JTdkdNL2V1WlVLVzNkN210U3c2dmZ2V1BJbTBG?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 03124621-5f89-4917-557c-08dc0cd0e55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 02:57:32.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+qbeadx8M8Pk0dEjRYbTdqUTztlZj5ZuNJvFi8JCVZ4N9zBlkWTlQGciJKNT6LNqcotdsKkSYKMrhIEMRp1+CrnxIErr904jggGwkmelOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1271
X-OriginatorOrg: starfivetech.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjEs
IDIwMjMgOTo1NyBQTQ0KPiBUbzogWXVrbGluIFNvbyA8eXVrbGluLnNvb0BzdGFyZml2ZXRlY2gu
Y29tPg0KPiBDYzogQmFydG9zeiBHb2xhc3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5h
cm8ub3JnPjsgSGFsIEZlbmcNCj4gPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBMZXlmb29u
IFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47DQo+IEppYW5sb25nIEh1YW5nIDxq
aWFubG9uZy5odWFuZ0BzdGFyZml2ZXRlY2guY29tPjsgRW1pbCBSZW5uZXIgQmVydGhpbmcNCj4g
PGtlcm5lbEBlc21pbC5kaz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0
b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25v
ciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBEcmV3IEZ1c3RpbmkgPGRyZXdAYmVh
Z2xlYm9hcmQub3JnPjsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlA
c2lmaXZlLmNvbT47IFBhbG1lcg0KPiBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJl
cnQgT3UgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
MS82XSBkdC1iaW5kaW5nczogcGluY3RybDogc3RhcmZpdmU6IGFkZCBKSDgxMDAgcGluY3RybA0K
PiBiaW5kaW5ncw0KPiANCj4gSGkgQWxleCwNCj4gDQo+IHRoYW5rcyBmb3IgeW91ciBwYXRjaCEN
Cj4gDQo+IE9uIFRodSwgRGVjIDIxLCAyMDIzIGF0IDk6MzbigK9BTSBBbGV4IFNvbyA8eXVrbGlu
LnNvb0BzdGFyZml2ZXRlY2guY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gQWRkIGR0LWJpbmRpbmcg
ZG9jdW1lbnRhdGlvbiBhbmQgaGVhZGVyIGZpbGUgZm9yIEpIODEwMCBwaW5jdHJsDQo+ID4gZHJp
dmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBTb28gPHl1a2xpbi5zb29Ac3RhcmZp
dmV0ZWNoLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBz
dGFyZml2ZXRlY2guY29tPg0KPiAoLi4uKQ0KPiA+ICt0aXRsZTogU3RhckZpdmUgSkg4MTAwIEFP
TiBQaW4gQ29udHJvbGxlcg0KPiANCj4gSWYgQU9OIG1lYW5zICJhbHdheXMtb24iIHRoZW4gc3Bl
bGwgdGhhdCBvdXQgaW4gdGhlIHRpdGxlLCB0aGUgd29ybGQgaGFzIHRvbw0KPiBtYW55IG9wYXF1
ZSBUTEFzLg0KPiANCj4gdGl0bGU6IFN0YXJGaXZlIEpIODEwMCBBT04gKGFsd2F5cy1vbikgUGlu
IENvbnRyb2xsZXINCg0KVGhpcyB0aXRsZSB3aWxsIGJlIHVwZGF0ZWQgYXMgc2hvd24gYWJvdmUg
dG8gY2xhcmlmeSB0aGUgbWVhbmluZyBvZiBhY3JvbnltIEFPTi4NCg0KPiANCj4gKC4uLikNCj4g
PiArICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgcGlubXV4Og0KPiA+ICsgICAg
ICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAgICAgICAgIFRoZSBsaXN0IG9mIEdQ
SU9zIGFuZCB0aGVpciBtdXggc2V0dGluZ3Mgb3IgZnVuY3Rpb24gc2VsZWN0Lg0KPiA+ICsgICAg
ICAgICAgICAgIFRoZSBHUElPTVVYIGFuZCBQSU5NVVggbWFjcm9zIGFyZSB1c2VkIHRvIGNvbmZp
Z3VyZSB0aGUNCj4gPiArICAgICAgICAgICAgICBJL08gbXVsdGlwbGV4aW5nIGFuZCBmdW5jdGlv
biBzZWxlY3Rpb24gcmVzcGVjdGl2ZWx5Lg0KPiA+ICsNCj4gPiArICAgICAgICAgIGJpYXMtZGlz
YWJsZTogdHJ1ZQ0KPiA+ICsNCj4gPiArICAgICAgICAgIGJpYXMtcHVsbC11cDoNCj4gPiArICAg
ICAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsNCj4gPiArICAgICAgICAgIGJpYXMtcHVsbC1k
b3duOg0KPiA+ICsgICAgICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgZHJpdmUtc3RyZW5ndGg6DQo+ID4gKyAgICAgICAgICAgIGVudW06IFsgMiwgNCwgOCwgMTIg
XQ0KPiANCj4gTWlsbGlhbXBlcmVzPyBUaGVuIHNwZWxsIHRoYXQgb3V0IGluIGEgZGVzY3JpcHRp
b246DQoNClllcywgdGhlIHVuaXQgaXMgbWlsbGlhbXBlcmVzLCDigJxkcml2ZS1zdHJlbmd0aDri
gJ0gd2lsbCBiZSBjaGFuZ2VkIHRvIOKAnGRyaXZlLXN0cmVuZ3RoOiBEcml2ZSBzdHJlbmd0aCBp
biBtQeKAnQ0KDQo+IA0KPiA+ICsgIFZvbHRhZ2UgcmVndWxhdG9yIHN1cHBseSB0aGUgYWN0dWFs
IHZvbHRhZ2UgdG8gdGhlIEdQSU8gYmFuayB3aGlsZQ0KPiA+ICsgdGhlIHN5c2NvbiByZWdpc3Rl
ciAgY29uZmlndXJhdGlvbiBpbiBiaXQgWzE6MF0gaW5kaWNhdGVzIHRoZSBjdXJyZW50IHZvbHRh
Z2UNCj4gc2V0dGluZy4NCj4gPiArDQo+ID4gKyAgKy0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLSsNCj4gPiArICB8IEJpdDEgfCBCaXQwIHwgUmVmZXJlbmNlIFZvbHRhZ2UgfA0KPiA+
ICsgKy0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiArICB8ICAwICAgfCAg
MCAgIHwgICAgIDMuMyBWICAgICAgICAgfA0KPiA+ICsgICstLS0tLS0rLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0rDQo+ID4gKyAgfCAgMSAgIHwgIHggICB8ICAgICAxLjggViAgICAgICAgIHwN
Cj4gPiArICArLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICsNCj4gPiAr
ICBUbyBpbmNyZWFzZSB0aGUgZGV2aWNlIHZvbHRhZ2UsIHNldCBiaXQgWzE6MF0gdG8gdGhlIG5l
dyBvcGVyYXRpbmcNCj4gPiArIHN0YXRlIGZpcnN0IGJlZm9yZSAgcmFpc2luZyB0aGUgYWN0dWFs
IHZvbHRhZ2UgdG8gdGhlIGhpZ2hlciBvcGVyYXRpbmcgcG9pbnQuDQo+ID4gKw0KPiA+ICsgIFRv
IGRlY3JlYXNlIHRoZSBkZXZpY2Ugdm9sdGFnZSwgaG9sZCBiaXQgWzE6MF0gdG8gdGhlIGN1cnJl
bnQNCj4gPiArIG9wZXJhdGluZyBzdGF0ZSB1bnRpbCAgdGhlIGFjdHVhbCB2b2x0YWdlIGhhcyBz
dGFiaWxpemVkIGF0IHRoZQ0KPiA+ICsgbG93ZXIgb3BlcmF0aW5nIHBvaW50IGJlZm9yZSBjaGFu
Z2luZyB0aGUgIHNldHRpbmcuDQo+ID4gKw0KPiA+ICsgIEFsdGVybmF0aXZlbHksIGEgZGV2aWNl
IHZvbHRhZ2UgY2hhbmdlIGNhbiBhbHdheXMgYmUgaW5pdGlhdGVkIGJ5DQo+ID4gKyBmaXJzdCBz
ZXR0aW5nIHN5c2NvbiAgcmVnaXN0ZXIgYml0IFsxOjBdID0gMCwgdGhlIHNhZmUgMy4zViBzdGFy
dHVwDQo+ID4gKyBjb25kaXRpb24sIGJlZm9yZSBjaGFuZ2luZyB0aGUgZGV2aWNlICB2b2x0YWdl
LiBUaGVuIG9uY2UgdGhlIGFjdHVhbA0KPiA+ICsgdm9sdGFnZSBpcyBjaGFuZ2VkIGFuZCBoYXMg
c3RhYmlsaXplZCBhdCB0aGUgbmV3IG9wZXJhdGluZyAgcG9pbnQsIGJpdCBbMTowXQ0KPiBjYW4g
YmUgcmVzZXQgYXMgYXBwcm9wcmlhdGUuDQo+IA0KPiBBY3R1YWxseTogd2hlcmUgaXMgdGhpcyBp
bmZvcm1hdGlvbiBldmVuIHVzZWQ/DQoNCkVhY2ggcGluIGNvbnRyb2xsZXIgaW4gSkg4MTAwIFNv
QyBoYXMgYSBzZXQgb2YgcmVnbWFwLWJhc2VkIHN5c2NvbiByZWdpc3RlcnMgdG8gc2VydmUgZGlm
ZmVyZW50IHB1cnBvc2VzIGluIHJlc3BlY3RpdmUgcGluY3RybCBkb21haW4uDQpJbiBBT04gKGFs
d2F5cy1vbikgcGluY3RybCwgdGhlcmUgYXJlOiANCi0Jc3lzY29uIHJlZ2lzdGVycyB0byBpbmRp
Y2F0ZSB0aGUgSS9PIHZvbHRhZ2UgbGV2ZWwgb2YgZU1NQywgU0QwLCBSR1BJT3MsIGFuZCBYU1BJ
Lg0KLQlzeXNjb24gcmVnaXN0ZXJzIHRvIGNvbnRyb2wgdGhlIEdNQUMgc2V0dGluZ3MuDQoNClRo
ZSBmb3JtZXIgd2lsbCBiZSB1c2VkIGluIHRoZSBTRC9lTU1DIGRldmljZSBkcml2ZXIgdG8gaW5k
aWNhdGUgdGhlIGNoYW5nZSBpbiB2b2x0YWdlIHN1cHBseSBkdXJpbmcgdm9sdGFnZSBzd2l0Y2hp
bmcgaW4gdGhlIGluaXRpYWxpemF0aW9uIHByb2Nlc3MuIFRoZSBzeXNjb24gcmVnaXN0ZXIgY29u
ZmlndXJhdGlvbiBwcm92aWRlcyBpbmZvcm1hdGlvbiB0byBpbmRpY2F0ZSB0aGUgZGV2aWNlIEkv
TyB2b2x0YWdlIGxldmVsLiBUaGUgZGV2aWNlIGRyaXZlciBtdXN0IG1ha2Ugc3VyZSB0aGVzZSBz
eXNjb24gcmVnaXN0ZXJzIGFyZSBjb25maWd1cmVkIHByb3Blcmx5LiBJbiBjYXNlIGlmIHNldHRp
bmcgc3lzY29uIHJlZ2lzdGVyIHRvIGluZGljYXRlIGRldmljZSBJL08gdm9sdGFnZSBhcyAxLjhW
LCBidXQgdGhlIGFjdHVhbCB2b2x0YWdlIHN1cHBseSBpcyAzLjNWLiBUaGUgcGFkcyB1c2VkIGZv
ciB0aGUgZGV2aWNlIEkvTyBpbnRlcmZhY2Ugd2lsbCBnZXQgZGFtYWdlZC4NCg0KPiANCj4gPiAr
ICAgICAgICAgIHNsZXctcmF0ZToNCj4gPiArICAgICAgICAgICAgbWF4aW11bTogMQ0KPiANCj4g
TWlsbGlzZWNvbmRzPyBXcml0ZSB1bml0IGluIGRlc2NyaXB0aW9uIHBsZWFzZS4NCg0KVGhlIHNs
ZXctcmF0ZSBpcyBhIHNpbmdsZSBiaXQgaW4gdGhlIElPIFBhZCBjb25maWd1cmF0aW9uIHJlZ2lz
dGVyLiBCaXQgdmFsdWUgMCBtZWFucyBzbG93IGFuZCAxIG1lYW5zIGZhc3QuDQoNCiAgICAgICAg
ICBzbGV3LXJhdGU6DQogICAgICAgICAgICBtYXhpbXVtOiAxDQoNCndpbGwgYmUgY2hhbmdlZCB0
byANCg0KICAgICAgc2xldy1yYXRlOg0KICAgICAgICBlbnVtOiBbIDAsICAxIF0NCiAgICAgICAg
ZGVmYXVsdDogMA0KICAgICAgICBkZXNjcmlwdGlvbjogfA0KICAgICAgICAgICAgMDogc2xvdyAo
aGFsZiBmcmVxdWVuY3kpDQogICAgICAgICAgICAxOiBmYXN0DQoNCklzIHRoYXQgb2theT8NCg0K
PiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==

