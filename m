Return-Path: <linux-kernel+bounces-17566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFF824F72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63651C22BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFF2031C;
	Fri,  5 Jan 2024 08:02:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2054.outbound.protection.partner.outlook.cn [139.219.146.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD5200AC;
	Fri,  5 Jan 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt/YuTKLX6PH4tchcIIa/DVwVvv0pzchGHhFaGMukBZSYBrcC0/gu6NenlcGMpQzb5mBNEjRvyI7AxDkTzKxtKgBRsvhw/G3l3lh4js86rWbbSLxrtp4uHpbdVvE0P0Fn5rKX+q3U5QyqNP5Y5BGSAgwIe+DvcPMluQUEwaiL3X9NinhTa/mowifissBkdlLqEihxFBzX/SDimQduJHzL8lc3d+yWudzLgi+Wg+WIznEkFutC0tXRSh1kCENOgynBQHy9Ux3SQJ2fTCXwa8D03bDDbLOrOUrVe/l+QkNQ2WSNNBwRz12C2KiU/UmdbVxUqHzHaZmI/CL+MDMscCgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+ksHeympk2WGT6O5XIxjIcSOCWZ/HTs79c8bSuT8+4=;
 b=Z+JvFA0piSVG8EWb0A5TF69SbcxWfbDoTcqapJ1cQPACcQGvFZAta7HNHfMD5Na7BWjvYoe2IZc+405R/RzSerFqE+93byUdnifsa1AbvZbJDri461lmPsyFaiGodUNrU3I8exSGqOuRdJG3uAUqoe9OG0u2yuaKLw0sw2q/d5Qx0JRKdM+SKbkyWZnwN0ycASOMaYJc1bBJMjBwmGLEwaBwwku0AV4mIkZj7vQ+H8e0FCPEa8e85lk89Wf6IH7B5B0CVzCGV00XDsC31oYcJvf38Wj5xpr8q7HLN4g9Ki19hPoyjw163lavcnmwAdYL8MUve14Yvj9MvFEGDQ5DKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::17) by SHXPR01MB0509.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.29; Fri, 5 Jan
 2024 08:02:29 +0000
Received: from SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn
 ([fe80::ab14:c31e:d14e:f545]) by
 SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn ([fe80::ab14:c31e:d14e:f545%2])
 with mapi id 15.20.7135.028; Fri, 5 Jan 2024 08:02:29 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Hal Feng <hal.feng@starfivetech.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
Subject: RE: [PATCH v10 2/4] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v10 2/4] pwm: opencores: Add PWM driver support
Thread-Index: AQHaNLumKMWI92ZqLkONpDhrjXMz6LDKVKgAgACWT3A=
Date: Fri, 5 Jan 2024 08:02:29 +0000
Message-ID:
 <SHXPR01MB07352176E8B44BF3FD3A7A4A9F66A@SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-3-william.qiu@starfivetech.com>
 <mtqzl3hdfivkty2gdwabfxpshz276fjke477eql3nua4west63@u53ruikv5hz2>
In-Reply-To: <mtqzl3hdfivkty2gdwabfxpshz276fjke477eql3nua4west63@u53ruikv5hz2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0735:EE_|SHXPR01MB0509:EE_
x-ms-office365-filtering-correlation-id: 2a360fab-372a-4249-3072-08dc0dc4a9d4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DHA3caoETF8DUyo+pciOX3B1pqT1IRwO/H7zkJ4jykNVxuriN9wF7Yus6wmbIT8S4NQ+GrlkhCi2Mq+HplA7r7HKbeeNxK44kVOXT0kx4Q03XMKSCRCbUG1NgetaIV2kxjHwWDTX/fPbiZaJQ0ZkJD95louaTYC/OIRCuYLQkGpt2Tf3bDa0XfY/YMX9DKiViGuMfNhwp5WOujvQjltWqX2l9G1qcsoSC4v8oTby3zAqqXZy9pHfaQxuni7TuuemM+kmnUstqaXitUZ7Dd5ZyKT2a+ePNUI81bEWVzGGuGeBx8pWDVluiJxS7cwU8GXn59sQWdehnBKLvp3YPhXiIoGmBhojOtx9a2suIjrdjoPK4zKc4CBonE5BdbIpL4ueIBPT4P637ESXKtJahv8h98yaOnAnEjeXxKl7/YwXlXVav7oycoYcpl3+IDKWvT9+dfRhT4Eqcd6UkWjM2T20pbWv8zlZuGkUQ3y2Iijwx5OQnqrnqCboNUeuT+zlFCxcyqPmTJs7XlDkFKlnpmAkNJEevD2iN+V5OUZ9j/s7s62F84kJa7IZS3Ftjbhqfv5M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39830400003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(40180700001)(33656002)(41320700001)(38100700002)(38070700009)(122000001)(66446008)(6916009)(966005)(64756008)(8936002)(41300700001)(66556008)(54906003)(76116006)(66476007)(66946007)(40160700002)(86362001)(2906002)(7696005)(83380400001)(53546011)(9686003)(71200400001)(26005)(5660300002)(4326008)(7416002)(8676002)(508600001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekU2L3BHSFZEOGNoM1pSWS81QXZZWUF0YVZxMzlzaTJlaXlRZGFjekJkYWtC?=
 =?utf-8?B?Q3NZUWhCTlVkbVBiL3RHMUhYSEdzeTZUT2dNaDV2WEtFbXhEL0FLZHp2QjJO?=
 =?utf-8?B?cnc2NXRSTlBZc0ZremtIb3I1STBxb2xnK05VTVk3bDZBdVFHUkF0dHNGbkFq?=
 =?utf-8?B?YVFKOHNUV1JIMjhBcktKWTN5NlA1ZWxXckNENkRqUXVUamR5aVhpdHlRbTNE?=
 =?utf-8?B?VUk2aGQ5ZlhvM2tHRFRXTTZleExhdzlOcERvZTA3ZUpETFVicWExdlBZc2V6?=
 =?utf-8?B?VGRBSi9FRUZBTGhyd3Q4UEFTMytOSVRiZjA0c3lRd1NJR2VOdmthOUhUbkp0?=
 =?utf-8?B?UmJEVmV2c0pRNUtiWE54TzJWbDBvRFRmUXR0YUxybzlWc0Z4T0cyMTZ4cDQ0?=
 =?utf-8?B?WUJHVUJ0SU1hZnlzQ3VtazJtTWl4RkkwQ0JMYUdML2QrRUM4eHFLSnVCdlJ2?=
 =?utf-8?B?eWNkc3lXZlJOWW5ldkV4eGxINENNM2g5SUxTczhqRTZrcEZHNTVMMUUyanBB?=
 =?utf-8?B?MjdGMHVGYlozVDgzcVNmSmFSZEV6T2UyS29KNzRqOUxremF4NEVwTU1IZFFC?=
 =?utf-8?B?ZmduK1VZU3dYOEZObXFmK2d6MURVd0k5aDMzWGhSeStJOU1MSTM0ZUpYTVZy?=
 =?utf-8?B?c2lRRGRFTzF3ZDBKcnlkWWpSTDRmYTQyK2RJaHkxMC9xc0ZCdHhyZjBzN3BP?=
 =?utf-8?B?U0c5Y1FVMWM4dTRNUnpMb1o0c0JmbWt6Rk1hWXd6dGZ5YlVGdko3QjhTMURv?=
 =?utf-8?B?eTBCZjZhMTJtczA2UVI5UWFjSk1pR2ZBc3Z5WTB1VlBhZkwxcmNyTlNmZzlQ?=
 =?utf-8?B?Wjk3b2NQS2RJMFliSkF3SGdnWWY4QVRiVm5NTHlncnRueHpSbU5JRExDY2o0?=
 =?utf-8?B?UkZ3UWh3QldzWmVPaDBhT1hHTDI3anYzR28rRGlDc2twS29NUDZkS0tCWkxy?=
 =?utf-8?B?RlJZTnpJMGlrTldPVTlCbWxRaE9qT3BGMEtTSE1SdzNaZzJWbEVWYnVvNjVT?=
 =?utf-8?B?VXhYUzUxQk1USWF4R3lXT2xQV0Iya1FoV0dOT3lONXJyNVpJMU1xTHlySzE2?=
 =?utf-8?B?WVVqRHhvSFY0MVdBcFBibDE5UTIzZ2JRcTk2V1FFZmovRWh4eWFHWUV2QVM0?=
 =?utf-8?B?cDdqSnNvYVJ5V3lKVFFWelF0ZFNDYlZqai92Q29Vdys0azBOMUYyZmlxSTRl?=
 =?utf-8?B?dWVRY3NJakJUWHI1OWlxTzV3L3JtT1N0K3l0djRkVlhQMGF4bkl0T1dZWEVE?=
 =?utf-8?B?eitFWXV1VHlwbFVUb1ZhWi9tYkdSdHRXL2UxbW9SZkw0eXV3amsrSHZLVVUx?=
 =?utf-8?B?MzEwOG5kRTcrSmtpODFDcEIweis5c3lCUmlha202WUpEcDJJTk1TQ1R0UGsv?=
 =?utf-8?B?RW1KL3pJalhPakZhQzV6VGRCMm9JdUJxeldHcXR1VnhDMHFENEM2cGY0cFE2?=
 =?utf-8?B?MzQrQVNjS3J3bHFEVjR6TzNsenhYZlprMGo0ZVprUWxOOGtja2g0WmZhRGRH?=
 =?utf-8?B?ZEtNYnRLU0tPOEYyU3kvaXNaQU5ITHJUTlMxRDZKZGhuR2cyYjREb2hVNW52?=
 =?utf-8?B?OUhhL0FZQVg4RGV4WW5hdE0vcjRseld0cWd6MmF6cnVjNWlhZlU2RjlJcjlz?=
 =?utf-8?B?OWdBOEhnS1BKMFJqTG5yeUlhZjZKbEFjYVdzcmI0aW5ZbmhaZEVZQ3hLajZC?=
 =?utf-8?B?QXFxWnBIdXI5MUJaS3VsdE1UNzExeFlMTmZvU3NNS2x5UngycnJNSHZhdmF2?=
 =?utf-8?B?dkFaUmsrQkczaWFubjRvbGNpOTBybm9MUC9odUhZdE9kdERWWUx6ZWJTMzRM?=
 =?utf-8?B?aTdxYW1TTldCbTNCN2xrTEhET2pSaWRkbkY5ZG1Ec3FrQzZ4WFlLb1hyM0w4?=
 =?utf-8?B?bmMrY3J6Y0laNlRjanpJM2ZCZkdUaEE2MWFDczM2VnVVbGtIUVBaTjNLZWl1?=
 =?utf-8?B?ZGhMbzdIQ2ZMRXc2SmttNllqSkgybEdyTndnMUowMm5oRUZpMFJpaXVFYm81?=
 =?utf-8?B?S04yTFdER2xnTkZKYWRxVVhyWWl4VGRmMEYrM05sd3F5c1d6UGxUdkcyeldC?=
 =?utf-8?B?dHVXY2luY1JvNU5xY0czOXdmN3ZqOE9hWXNzUG8zOE1nSUFqemtCeDUwTFdo?=
 =?utf-8?B?SHV2Ti9xU2E4eHRkOGgxNnNoYmxGZHljNU44emgyYVZocEl2MHkrQWlsYUZC?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0735.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a360fab-372a-4249-3072-08dc0dc4a9d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 08:02:29.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckRp6dn6IU8qZI/RRgrs8NWG784DvdvwVrjeCQxoCIwsZWqzic+q8hKbvPn6UlIDfLWfD9rk7+0hubWW31saIvA1imLzijgi55hj/KaG81s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0509

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MeaciDXml6Ug
Njo0MQ0KPiBUbzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+
IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcHdtQHZnZXIu
a2VybmVsLm9yZzsgRW1pbCBSZW5uZXINCj4gQmVydGhpbmcgPGtlcm5lbEBlc21pbC5kaz47IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBUaGllcnJ5DQo+IFJlZGluZyA8dGhpZXJy
eS5yZWRpbmdAZ21haWwuY29tPjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5k
ZT47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEhhbCBGZW5nIDxo
YWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPjsgUGF1bA0KPiBXYWxtc2xleSA8cGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tPjsgUGFsbWVyIERhYmJlbHQNCj4gPHBhbG1lckBkYWJiZWx0LmNvbT47IEFs
YmVydCBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
MCAyLzRdIHB3bTogb3BlbmNvcmVzOiBBZGQgUFdNIGRyaXZlciBzdXBwb3J0DQo+IA0KPiBIZWxs
byBhZ2FpbiwNCj4gDQo+IE9uIEZyaSwgRGVjIDIyLCAyMDIzIGF0IDA1OjQ1OjQ2UE0gKzA4MDAs
IFdpbGxpYW0gUWl1IHdyb3RlOg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9jb3Jlc19wd21f
ZGF0YSBqaDcxMDBfcHdtX2RhdGEgPSB7DQo+ID4gKwkuZ2V0X2NoX2Jhc2UgPSBzdGFyZml2ZV9q
aDcxeDBfZ2V0X2NoX2Jhc2UsIH07DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9j
b3Jlc19wd21fZGF0YSBqaDcxMTBfcHdtX2RhdGEgPSB7DQo+ID4gKwkuZ2V0X2NoX2Jhc2UgPSBz
dGFyZml2ZV9qaDcxeDBfZ2V0X2NoX2Jhc2UsIH07DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBvY29yZXNfcHdtX29mX21hdGNoW10gPSB7DQo+ID4gKwl7IC5j
b21wYXRpYmxlID0gIm9wZW5jb3Jlcyxwd20tdjEiIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0g
InN0YXJmaXZlLGpoNzEwMC1wd20iLCAuZGF0YSA9ICZqaDcxMDBfcHdtX2RhdGF9LA0KPiA+ICsJ
eyAuY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtcHdtIiwgLmRhdGEgPSAmamg3MTEwX3B3
bV9kYXRhfSwNCj4gPiArCXsgLyogc2VudGluZWwgKi8gfQ0KPiANCj4gTG9va2luZyBhdCB0aGUg
YmluZGluZw0KPiANCj4gCWNvbXBhdGlibGUgPSAib3BlbmNvcmVzLHB3bS12MSI7DQo+IA0KPiBp
c24ndCBhIHZhbGlkIGNvbmZpZ3VyYXRpb24uIElmIHRoYXQgaXMgaW5kZWVkIHRoZSBjYXNlIGFu
ZCB5b3UgYWx3YXlzIGhhdmUgZWl0aGVyDQo+IHN0YXJmaXZlLGpoNzEwMC1wd20gb3Igc3RhcmZp
dmUsamg3MTEwLXB3bSwgeW91IGNhbiBkcm9wIHRoZSBsb2dpYyB0byBvbmx5IHVzZQ0KPiBzdGFy
Zml2ZV9qaDcxeDBfZ2V0X2NoX2Jhc2UgY29uZGl0aW9uYWxseS4NCj4gDQo+IEJlc3QgcmVnYXJk
cw0KPiBVd2UNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IFV3ZSBLbGVpbmUtS8O2bmlnDQo+IHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1
dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwNCg0K
SGkgVXdlLA0KDQpJIGp1c3QgdXBsb2FkIGNvZGUgZm9yIE9wZW5Db3Jlcy4uIEFuZCBJIG5lZWQg
dG8gYWRkIHRoZSBzdGFyZml2ZV9qaDcxeDBfZ2V0X2NoX2Jhc2UNCnRvIGNvbXBhdGliaWxpdHkg
d2l0aCBqaDcxeDAuIFNvIGV2ZW4gdGhlICJvcGVuY29yZXMscHdtLXYxIiBpc24ndCBhIHZhbGlk
DQpjb25maWd1cmF0aW9uLCBidXQgSSBzdGlsbCBuZWVkIHRvIGFkZCBpdCBmb3IgT3BlbkNvcmVz
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpXaWxsaWFtDQo=

