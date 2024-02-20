Return-Path: <linux-kernel+bounces-72368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03385B280
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14F01C216BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004757334;
	Tue, 20 Feb 2024 05:55:59 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952A2030B;
	Tue, 20 Feb 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408558; cv=fail; b=d5F1JYKfNwCWrogRTorgR0LGm6xhUnggtnJbQosywupW4W9mZB2yuSLSCcQSVbX8pN9ee9YKIQAAx/N5kdXPqfEvhjEV1l3t30bH7ja7mxIwWWoMkcCXe+HXEzyzirXzH/IURriUnqGe8dzE5H0LsNMkC8TvElE7SBYkZVPMLdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408558; c=relaxed/simple;
	bh=fX1oFQXpwc2aJiOZR6Aag/utcG2ZR5XMpOo2bBYYlSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IsKNaMaEt8tK9Eu1Dwf1DHVDqCL0rUhvNK3ogZA/gXEx9RiKWWnx8fc2qDIi/jt5uiZsJtq3iMuvkSRDsFcZjgQ6dPgSkKdxxChPVD94FbwEFu8KK7/35wApVTmrLaW8WIfYnkymq35+CYk2SikIuUAbguWoLcoqhqDtex+0+p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISiA+7ZHc4/td96C4PTorn+oDISs5w6I0Nyu9cqTdQKp7gwCSjyaasxb75oOP142xt++JO/MxXhGpVzd8qMZ5Ewloe5EKpK077xVB064tF3F47Bb3rkSO0HyBSivJ/gUhEIZ5kIH/4rvDhDvdrhIRFxWtNqH1BhtrFBnuMdjWEJjhCGXfUXHiEHD+VRZTmy7MaLu0P2YF3RIs80QdY8K/vn8iYN5kItbfCkEsmQSsoEgUlyqMg/4rsMdd5zNsZVnN/r7oc+KAq5PGf4jd760NrBrjdWzz4xGAoTEvSQ1pQwviV90OW7/XEjKav+O96MY1+fDprU/uiqgkdZkGrRi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX1oFQXpwc2aJiOZR6Aag/utcG2ZR5XMpOo2bBYYlSo=;
 b=LXja7truWU5yyiVJzYXwPyQLVIDmwNWkZuafeaDPVi9wabqTvFim7WKUOnswaELIMwjqfJg/xV+Vr/wrZSYCSC9DmKAjMGOiTKGSZSklep2ChWiOfgYlKOKiKKX3lrN2476rzUMivyi9PfMAXSCdwT0UlHzys9ktVd4PHVJS/uvUXDUt6+Bj5R7NRu52qZNAzg/SRvAjUIQA1Q0eg6iUh9Vg1MTu0+aemXJHdhv5XwGeMhy0b3fpZUsvDn5TOOENYOvscvxGITbkhfIGb2xZyGJJHDVx0dNfp+ZezzKolYZhfrw1gEPIXytdc87/PYpltbX4XAzQ/vBr9zm2d+YPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1061.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Tue, 20 Feb
 2024 05:55:43 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 05:55:42 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>
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
Subject: RE: [RFC PATCH 2/6] pinctrl: starfive: jh8100: add pinctrl driver for
 sys_east domain
Thread-Topic: [RFC PATCH 2/6] pinctrl: starfive: jh8100: add pinctrl driver
 for sys_east domain
Thread-Index: AQHaUXlDs3sBux2SdEKzIvaJBY27p7ES24CQ
Date: Tue, 20 Feb 2024 05:55:42 +0000
Message-ID:
 <ZQ0PR01MB130267FBE0BFB694C2554605F650A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-3-yuklin.soo@starfivetech.com>
 <CACRpkdagPYfSq91dXOTJ9d8VjCMMG2AN3L9-Qxdw3C8tki09EQ@mail.gmail.com>
In-Reply-To:
 <CACRpkdagPYfSq91dXOTJ9d8VjCMMG2AN3L9-Qxdw3C8tki09EQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1061:EE_
x-ms-office365-filtering-correlation-id: 565d5cfb-1410-4657-15c2-08dc31d89304
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GftklZYvXiVhH3B/NkPVJBkm8Vu/VS3TLGGe8eXDiuNZWj4Kux7fyMpyZhc5OIjZxoBhj0ZbV2wH10l3WzymQM75gNN5iB1x7ikBgBFo2ALs0ChigarY3vXl+xIg66DTtGOI1INpF8tzlkcnxyosejmt8Iio2MPOkHtgeB5+B+0ofIBn7d7is0plRZJrE/iGAQ428eOG06CfZBr5OgX+rUq6xqQQAHSaK4R5jo3gG16ZKpMN82MR1z9gzJ4SNH17PsFgBKIL30a4UWc2XDElnTPg64dHS2WCaQYo6dmlDZk9LqY5PbqQTXF1pLFRSoUg4gtPmp9iEBPTJrm/KfONrOM68lIYgKJaFPGi06HWSbGyP74esbw2PUL/iuDExtYkGZJqaal4KEnp5sldABpHefR2MTHrjEPXkA6gTWYUypS/XsbdH6TvTRJerUyOuQRb25VWU5d274nBSyFWXEgHSK/SqK1x1Vtqb3XdDGy6vFqkprolKWQepyWaMceQOFLdDYFKvNF/9s+RBrcpwCRGLq3TTdueFJ9nwuvc5VVfJBDGhzCeqqFWK2cd9/uy7CSS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHFFSEh5dkNhemJQU0Z5emFxaCtkdVdKUmFHdG42QlJ1aHV0azNObDd3VzRn?=
 =?utf-8?B?M0VKN3VBcjd2bDJSZ3o5M3JMTFBaWnM1ZXV1OWY4WjJNN1E4SjZROGtFWkFQ?=
 =?utf-8?B?bUNxV0ZMT09Wc25zUm51RVN6cnAxTnVGUlNkbXhIdE5IWURuM1lnZzhPM2NK?=
 =?utf-8?B?NkhGaDgvNXA2SnhLdi8zb1dsMmhHREVUQS9NRnFPdEVoczM0WjlybDRjK1Qr?=
 =?utf-8?B?TUI1TnJwMDN5ZG1wTWxuVWtJTEsxVEZiSWhOSFVvNW5EcGNPSXFPN2V1blVO?=
 =?utf-8?B?dkNzZUxxZ0x6cGY3MHcxb1RQRzg0TEJRbEVYazlPdzVYRHA3TkF6V0ZVbnlz?=
 =?utf-8?B?SElGTGhBRjA2NWtaelZENEpENWFuNER6SHBNTm5oWUpiTVpmYXpIdTdrL1RC?=
 =?utf-8?B?dDRHOFQ3NXdjaDdVazNIZXNFVTBsa3JpOGxabngwRU1NdjhPajlTQVJLcmkz?=
 =?utf-8?B?UFZOSDBLSXlwUUJYdkwyL3ZOV2VNMi83dG1XNTM4RnFyd3Q5ZFpseU1VQTZK?=
 =?utf-8?B?VWlub3RuY25nSXMzOVVGYzVZdk9kRHFVOWVMbGY4d0t6ZTVLWURMMXRONlBG?=
 =?utf-8?B?WGxSTUZObm1wVElaazBWY3hYSnBjVWdLMDF1TERaWlQ2OHlkRGxLVzIvRi92?=
 =?utf-8?B?WkVVNkMrdXdYTlJpQ3NjOXRlOEtJdzdoVDJMcHJvN1RrRXIwVGpJYkEzcURI?=
 =?utf-8?B?TnJQSG9MY3QzaVZMeURqNW90eGxXcGxESEhBQlYzUmI2a1Q0NFVlRDA2OWYx?=
 =?utf-8?B?eUtsVDZETGZwS2N5UGJXZkVDYTdadHA0bm9lQzhPbHREdlNJeHJrcVFUdTFX?=
 =?utf-8?B?MFpNdkp2YTkraW1WM1F3eHZCOFhPb2p1Z252K3Noa3ZHdjc5alQxNEt1MGJV?=
 =?utf-8?B?aGtKNlI2MzFlSFRRL085MnVkakNLRm9Jb0tPU3ZNWDdrV2dzWDFNQjFlR3U5?=
 =?utf-8?B?S2JveThlb2lHZHFnSTVrVnhBN0cwelhRcGlScG1zbWdtWlVJWkJRNUhDSVBS?=
 =?utf-8?B?dGJMeXZ5V20waVhubGx4dm4wUSsrQWo3V3c5QnpqZTcxbzlWU0xzU2U1Q1Qv?=
 =?utf-8?B?czNwREdPeGVQaHovbVFiazRxdFVtM2NJS0RzcjJzNVZ1Wm1PVTZuRzdCbEdt?=
 =?utf-8?B?bGcwUjd6ZGtHK2RTQ0RIemx3dDBpU3NtYnBCdS9TcUR0U3NLWUtPNFg1d0VM?=
 =?utf-8?B?d2s1aUZkc3hUWStCUktEbjhGaXRhZmlSSDFYNE8ra21yYkxOWFVqK09nTU9K?=
 =?utf-8?B?ejZ0MlNoUmhoZzgwKzFWNW1VWUdaeHZucG1sem1MT2NQVHpHTW1lNnVrWU1t?=
 =?utf-8?B?cEdmcTVlcnlTeVdsZHE3THdYQVFWTDdmR2Z2U3Ztd24ycnlaUXNaa1JDSmV3?=
 =?utf-8?B?SmZVOG9sajZNZmp2V3BjK3BUbk5YWHdhNWE3S3VMdEkzYWVtN0JteCtvL0E2?=
 =?utf-8?B?WHN6UGVZTERhODd4NmxiVXBrUGxaWm1HRXA3YWwzNFVTOThEK1pHZnRLNVZT?=
 =?utf-8?B?bzh5RS9Ba1cxUlBhS0ptazhGTUNjcUJWNEh5aFp4c1pNYTRYNVVCN2xBRHlV?=
 =?utf-8?B?Z0diMTkwRWZZQ0pVcG5lSXlQSTFCZWJCenhnNHFRcXVmTmVtdHVHMGhnMkRF?=
 =?utf-8?B?bEZQRklmamVRY1pqVUVaMmxDbFpMYmFiOE9xanZ6b1NaNG05MVJJa2NRSlBy?=
 =?utf-8?B?UXplN0hEemJKcXBZS0xwZG94dm8xNUlpNlhEbkNUc0dDd2g4dnNGZTc0TWRO?=
 =?utf-8?B?cW4zNkJjeUxrdzhYRUpQZndXNlZIU25mVGNTcGNqVkNORDlIMUxKMExqa3pO?=
 =?utf-8?B?dDh5ckJ2Q292b2tzdkRYY0pDL3hKYnQzVnBmazgxVXZDN2kwL0lHWkJzbzVD?=
 =?utf-8?B?c2JibHJ0WEhHV3MzOGJkd3VhMUpVYmNDZVFxbWFkUTNCUWtPRnJORHJaaFVE?=
 =?utf-8?B?a21ZTU5LWmFsVmhQRUV3Wmp6Szlyc3dtZGZ6ZktReWRTSzRYR2trV2J2VHB4?=
 =?utf-8?B?SytaOVF3dFJuZkdYVHZQQno0elFYVVRBL0RQYjE4M0ZseXR6dEFDM29USDQv?=
 =?utf-8?B?TDdiU21TVk9ETWNNUXVkMi9POW8xd2IwWFNleW5ySi9oYld5NFNwa1dhVVM5?=
 =?utf-8?B?SFhFbFp3WTJLSW1FV1BJY2RCOERzVkgySmJDTzhrTXZUMVV4Sy8yd0xHQmcx?=
 =?utf-8?B?aXBzb2hxVVVjKzFmaS9DcUhMNWRBTU5XRkRxMWNpdGh4WlQ1Q3k0dVFVN2tD?=
 =?utf-8?B?bG1aVW4zenlxSFFsdXBZclR6SHFBPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d5cfb-1410-4657-15c2-08dc31d89304
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 05:55:42.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXoPMe/i54QtM/52SJJqkgv8AmZykgqCBqVMpV7kGny8UeOcOfGZfFvq2gpQlPkjrogRyecwdJppECarqiotA9POvJzy8bGX1EtzL9N7Xzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1061

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkgMjgsIDIw
MjQgNzozMyBBTQ0KPiBUbzogWXVrbGluIFNvbyA8eXVrbGluLnNvb0BzdGFyZml2ZXRlY2guY29t
Pg0KPiBDYzogQmFydG9zeiBHb2xhc3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5hcm8u
b3JnPjsgSGFsIEZlbmcNCj4gPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBMZXlmb29uIFRh
biA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47DQo+IEppYW5sb25nIEh1YW5nIDxqaWFu
bG9uZy5odWFuZ0BzdGFyZml2ZXRlY2guY29tPjsgRW1pbCBSZW5uZXIgQmVydGhpbmcNCj4gPGtl
cm5lbEBlc21pbC5kaz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
S296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBE
b29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBEcmV3IEZ1c3RpbmkgPGRyZXdAYmVhZ2xl
Ym9hcmQub3JnPjsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJp
c2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lm
aXZlLmNvbT47DQo+IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJlcnQg
T3UNCj4gPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
Mi82XSBwaW5jdHJsOiBzdGFyZml2ZTogamg4MTAwOiBhZGQgcGluY3RybCBkcml2ZXIgZm9yDQo+
IHN5c19lYXN0IGRvbWFpbg0KPiANCj4gSGkgQWxleCwNCj4gDQo+IHRoYW5rcyBmb3IgeW91ciBw
YXRjaCENCj4gDQo+IE9uIFRodSwgRGVjIDIxLCAyMDIzIGF0IDk6MzbigK9BTSBBbGV4IFNvbyA8
eXVrbGluLnNvb0BzdGFyZml2ZXRlY2guY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gQWRkIHBpbmN0
cmwgZHJpdmVyIGZvciBzeXNfZWFzdCBkb21haW4uDQo+IA0KPiBUaGlzIGNvbW1pdCBtZXNzYWdl
IGlzIHdyb25nLCBpdCBhbHNvIGNvbnRhaW5zIHRoZSBtYWluIGRyaXZlciBmb3Igamg4MTAwLg0K
PiBQbGVhc2UgYWRkIHNvbWUgcHJvcGVyIHN1YmplY3QgYW5kIGNvbW1pdCBtZXNzYWdlLg0KDQpX
aWxsIGNoYW5nZSB0aGUgY29tbWl0IGxvZyB0byAiYWRkIG1haW4gYW5kIHN5c19lYXN0IGRyaXZl
ciIgdG8gaW5kaWNhdGUgdGhlIGNvbW1pdCBvZiBib3RoIG1haW4gYW5kIHN5cy1lYXN0IGRyaXZl
ci4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNvbyA8eXVrbGluLnNvb0BzdGFyZml2
ZXRlY2guY29tPg0KPiA+IFJldmlld2VkLWJ5OiBMZXkgRm9vbiBUYW4gPGxleWZvb24udGFuQHN0
YXJmaXZldGVjaC5jb20+DQo+ICguLi4pDQo+ID4gKyNkZWZpbmUgcGluX3RvX2h3aXJxKHNmcCkg
KCgoc2ZwKS0+d2FrZXVwX2dwaW8pIC0gKChzZnApLT5nYy5iYXNlKSkNCj4gDQo+IFBsZWFzZSBk
byBub3QgcmVmZXJlbmNlIGdjLmJhc2UgbGlrZSB0aGlzLCBpdCBpcyBhIGdwaW8gaW50ZXJuYWwg
ZGV0YWlsLg0KPiANCj4gQWxzbywgdHVybiB0aGlzIGludG8gYSBzdGF0aWMgaW5saW5lIGZ1bmN0
aW9uLCB0aGUgbWFjcm8gaXMgaGFyZCB0byByZWFkLg0KDQpUaGUgcGluX3RvX2h3aXJxIG1hY3Jv
IHdpbGwgYmUgY29udmVydGVkIHRvIHRvIGEgc3RhdGljIGlubGluZSBmdW5jdGlvbiB0byBoaWRl
IGdwaW8NCmludGVybmFsIGRldGFpbCwgYW5kIGZvciBlYXNpZXIgY29kZSByZWFkYWJpbGl0eS4N
Cg0KPiANCj4gPiArLyogcGFkIGNvbnRyb2wgYml0cyAqLw0KPiA+ICsjZGVmaW5lIEpIODEwMF9Q
QURDRkdfUE9TICAgICAgQklUKDcpDQo+ID4gKyNkZWZpbmUgSkg4MTAwX1BBRENGR19TTVQgICAg
ICBCSVQoNikNCj4gPiArI2RlZmluZSBKSDgxMDBfUEFEQ0ZHX1NMRVcgICAgIEJJVCg1KQ0KPiA+
ICsjZGVmaW5lIEpIODEwMF9QQURDRkdfUEQgICAgICAgQklUKDQpDQo+ID4gKyNkZWZpbmUgSkg4
MTAwX1BBRENGR19QVSAgICAgICBCSVQoMykNCj4gPiArI2RlZmluZSBKSDgxMDBfUEFEQ0ZHX0JJ
QVMgICAgIChKSDgxMDBfUEFEQ0ZHX1BEIHwNCj4gSkg4MTAwX1BBRENGR19QVSkNCj4gDQo+IEpI
ODEwMF9QQURDRkdfQklBU19NQVNLDQoNCldpbGwgY2hhbmdlIHRvICJKSDgxMDBfUEFEQ0ZHX0JJ
QVNfTUFTSyIgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsjZGVmaW5lIEpIODEwMF9QQURD
RkdfRFNfTUFTSyAgR0VOTUFTSygyLCAxKQ0KPiA+ICsjZGVmaW5lIEpIODEwMF9QQURDRkdfRFNf
Mk1BICAgKDBVIDw8IDEpDQo+ID4gKyNkZWZpbmUgSkg4MTAwX1BBRENGR19EU180TUEgICBCSVQo
MSkNCj4gPiArI2RlZmluZSBKSDgxMDBfUEFEQ0ZHX0RTXzhNQSAgICgyVSA8PCAxKQ0KPiA+ICsj
ZGVmaW5lIEpIODEwMF9QQURDRkdfRFNfMTJNQSAgKDNVIDw8IDEpDQo+IA0KPiBQbGVhc2UgdXNl
ICgxVSA8PCAxKSBmb3IgNE1BLCB0aGlzIGxvb2tzIHdlaXJkIG90aGVyd2lzZS4NCg0KV2lsbCBj
aGFuZ2UgdG8gIigxVSA8PCAxKSIgZm9yIDRNQSBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgcGluY29uZl9vcHMgamg4MTAwX3BpbmNvbmZfb3BzID0gew0K
PiA+ICsgICAgICAgLnBpbl9jb25maWdfZ2V0ICAgICAgICAgPSBqaDgxMDBfcGluY29uZl9nZXQs
DQo+ID4gKyAgICAgICAucGluX2NvbmZpZ19ncm91cF9nZXQgICA9IGpoODEwMF9waW5jb25mX2dy
b3VwX2dldCwNCj4gPiArICAgICAgIC5waW5fY29uZmlnX2dyb3VwX3NldCAgID0gamg4MTAwX3Bp
bmNvbmZfZ3JvdXBfc2V0LA0KPiA+ICsgICAgICAgLnBpbl9jb25maWdfZGJnX3Nob3cgICAgPSBq
aDgxMDBfcGluY29uZl9kYmdfc2hvdywNCj4gPiArICAgICAgIC5pc19nZW5lcmljICAgICAgICAg
ICAgID0gdHJ1ZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgamg4MTAwX2dwaW9f
cmVxdWVzdChzdHJ1Y3QgZ3Bpb19jaGlwICpnYywgdW5zaWduZWQgaW50DQo+ID4gK2dwaW8pIHsN
Cj4gPiArICAgICAgIHJldHVybiBwaW5jdHJsX2dwaW9fcmVxdWVzdChnYywgZ3Bpbyk7IH0NCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIGpoODEwMF9ncGlvX2ZyZWUoc3RydWN0IGdwaW9fY2hpcCAq
Z2MsIHVuc2lnbmVkIGludCBncGlvKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBwaW5jdHJsX2dwaW9f
ZnJlZShnYywgZ3Bpbyk7DQo+ID4gK30NCj4gDQo+IFNraXAgb25lIGxldmVsIG9mIGluZGlyZWN0
aW9uLCBqdXN0IGFkZCBwaW5jdHJsX2dwaW9fcmVxdWVzdC9mcmVlIGRpcmVjdGx5IGludG8NCj4g
dGhlIHZ0YWJsZS4NCg0KVGhpcyB3aWxsIGJlIGZpeGVkIGluIG5leHQgdmVyc2lvbi4NCg0KPiAN
Cj4gPiArc3RhdGljIGludCBqaDgxMDBfZ3Bpb19zZXRfY29uZmlnKHN0cnVjdCBncGlvX2NoaXAg
KmdjLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
Z3BpbywgdW5zaWduZWQgbG9uZw0KPiA+ICtjb25maWcpIHsNCj4gPiArICAgICAgIHN0cnVjdCBq
aDgxMDBfcGluY3RybCAqc2ZwID0gY29udGFpbmVyX29mKGdjLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBqaDgxMDBfcGluY3RybCwgZ2MpOw0KPiA+ICsgICAgICAgdTMyIGFy
ZyA9IHBpbmNvbmZfdG9fY29uZmlnX2FyZ3VtZW50KGNvbmZpZyk7DQo+IA0KPiBQbGVhc2UgZG9u
J3QgcmVpbXBsZW1lbnQgLnNldF9jb25maWcsIGp1c3QgY2FsbCBpbnRvIHRoZSBwaW5jdHJsIGJh
Y2tlbmQgdXNpbmcNCj4gDQo+IC5zZXRfY29uZmlnID0gZ3Bpb2NoaXBfZ2VuZXJpY19jb25maWcN
Cg0KV2lsbCByZXBsYWNlICJqaDgxMDBfZ3Bpb19zZXRfY29uZmlnIiBieSAiZ3Bpb2NoaXBfZ2Vu
ZXJpY19jb25maWciIGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArc3RhdGljIGludCBqaDgx
MDBfZ3Bpb19hZGRfcGluX3JhbmdlcyhzdHJ1Y3QgZ3Bpb19jaGlwICpnYykgew0KPiA+ICsgICAg
ICAgc3RydWN0IGpoODEwMF9waW5jdHJsICpzZnAgPSBjb250YWluZXJfb2YoZ2MsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGpoODEwMF9waW5jdHJsLCBnYyk7DQo+ID4gKw0K
PiA+ICsgICAgICAgc2ZwLT5ncGlvcy5uYW1lID0gc2ZwLT5nYy5sYWJlbDsNCj4gPiArICAgICAg
IHNmcC0+Z3Bpb3MuYmFzZSA9IHNmcC0+Z2MuYmFzZTsNCj4gPiArICAgICAgIHNmcC0+Z3Bpb3Mu
cGluX2Jhc2UgPSAwOw0KPiA+ICsgICAgICAgc2ZwLT5ncGlvcy5ucGlucyA9IHNmcC0+Z2Mubmdw
aW87DQo+ID4gKyAgICAgICBzZnAtPmdwaW9zLmdjID0gJnNmcC0+Z2M7DQo+ID4gKyAgICAgICBw
aW5jdHJsX2FkZF9ncGlvX3JhbmdlKHNmcC0+cGN0bCwgJnNmcC0+Z3Bpb3MpOw0KPiA+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IFdoeSBhcmUgeW91IG5vdCBwdXR0aW5nIHRoZSBy
YW5nZXMgaW50byB0aGUgZGV2aWNlIHRyZWUgd2hlcmUgdGhlIEdQSU8gY29yZQ0KPiB3aWxsIGFk
ZCB0aGVtIGZvciB5b3U/DQoNCldpbGwgcmVtb3ZlIHRoZSBqaDgxMDBfZ3Bpb19hZGRfcGluX3Jh
bmdlcyBmdW5jdGlvbiBhbmQgdXNlIGdwaW8tcmFuZ2VzIGluIGRldmljZSB0cmVlIHRvDQpwcm92
aWRlIGluZm9ybWF0aW9uIGZvciBHUElPIGNvcmUgdG8gYWRkIHBpbiByYW5nZSBmb3IgZWFjaCBw
aW4gY29udHJvbGxlci4NCg0KPiANCj4gPiArICAgICAgIGlmIChpbmZvLT5pcnFfcmVnKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGpoODEwMF9pcnFfY2hpcC5uYW1lID0gc2ZwLT5nYy5sYWJlbDsN
Cj4gDQo+IFRoYXQncyBub3QgaW1tdXRhYmxlLiBUaGUgc3RydWN0IHNob3VsZCBiZSBjb25zdC4N
Cj4gWW91IGhhdmUgdG8gdXNlIC5pcnFfcHJpbnRfY2hpcCBpbiB0aGUgaXJxX2NoaXAuDQoNClRo
ZSBzdHJ1Y3QgaXJxX2NoaXAgd2lsbCBiZSB1c2VkIGFzIGEgY29uc3RhbnQgZGF0YSBzdHJ1Y3R1
cmUuIA0KV2lsbCBhZGQgYW4gaXJxX3ByaW50X2NoaXAgZnVuY3Rpb24gdG8gZGlzcGxheSBpcnFj
aGlwIG5hbWUgdG8gdXNlciBzcGFjZS4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgZ3Bpb19p
cnFfY2hpcF9zZXRfY2hpcCgmc2ZwLT5nYy5pcnEsDQo+ID4gKyAmamg4MTAwX2lycV9jaGlwKTsN
Cj4gDQo+IFVzZSB0aGUgY29udmVudGlvbjoNCj4gDQo+IHN0cnVjdCBncGlvX2lycV9jaGlwICpn
aXJxOw0KPiANCj4gZ2lycSA9ICZjaGlwLT5pcnE7DQo+IGdwaW9faXJxX2NoaXBfc2V0X2NoaXAo
Z2lycSwgJm5ta19pcnFfY2hpcCk7DQo+IA0KPiAuLi4gYW5kIHVzZSBnaXJxLT4gaW4gdGhlIHJl
c3Qgb2YgdGhlIGFzc2lnbm1lbnRzLg0KDQpnaXJxIHdpbGwgYmUgdXNlZCB0byByZXByZXNlbnQg
R1BJTyBpbnRlcnJ1cHQgY29udHJvbGxlci4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgZGV2
X2luZm8oZGV2LCAiU3RhckZpdmUgR1BJTyBjaGlwIHJlZ2lzdGVyZWQgJWQNCj4gPiArIEdQSU9z
XG4iLCBzZnAtPmdjLm5ncGlvKTsNCj4gDQo+IFN0YXJGaXZlIEpIODEwMCAoYmUgcHJlY2lzZSkN
Cg0KIlN0YXJGaXZlIEdQSU8iIHdpbGwgYmUgY2hhbmdlZCB0byAiU3RhckZpdmUgSkg4MTAwIEdQ
SU8iLg0KDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

