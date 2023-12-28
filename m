Return-Path: <linux-kernel+bounces-12445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F881F4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DB1F224C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC53C0B;
	Thu, 28 Dec 2023 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RvtAHtOM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2013.outbound.protection.outlook.com [40.92.103.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D923A7;
	Thu, 28 Dec 2023 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBkqf6nuFo8oap8Yd8OtP/5y9WjZbWdpdX3O8X/MH186/iVOIY0/7tsNrdUJQ7GVSUl0PNTPZRU99iKNoziH064qFXiommu1W/I0pyYVDToSGB9OhHRn3Qf4aD+cW62v7Ir8YP8VuVe0ruEuybzG4xsfrGh5lZnYE5OeBLP73iXuYmDmm/6sURSkpZX4qxBSuA6F/1H7ZEBfp3R7rSzv8dY6gp6XW74p/I+ucdz99PXTn/hEcRekAapewQUzwnyGuUjC/nqohk8SuFd/Sc/Jh0EWF1JuQZfGfIGUdycwPt2dE3qAZWQD9CM1PxdIgxdi82pay3cSf7VJZRCNLfsxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ws92o1rn9IM+BqjWFv6Bw8/aKAik9uQ2qxbzGhr/hI=;
 b=c3KWPYVNKs8+xZdk/iTtl+5mOO4QXHPu21uGmD7NUYuqPVJNJ4gOH63/va2thh6YZpqhC1GjLpKFTs9WGdTyjKtY/CIPxyE+kXWZHK9bEjcWSRunMdvbRWVxPzeg650oUAYP4l9rj3/4HVeGhm2ynR7jJJX+MdCCjruzdb9HokJK208A/h5dc3ZxUX32Ib5N5wbxB8Mw/O1apaMLmc2ZrVdgNorrHCJu/rbV5UsC8hyvBp/PDo+PrFQGzesWu4xTQBl+jm7a1Y0bh4OvDjo3mAPovfJqoBVIWOErKYiEJNUaUDjEStNPcOCDHmVkRIUvsBPYiuF1VpBNy/keW/n9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ws92o1rn9IM+BqjWFv6Bw8/aKAik9uQ2qxbzGhr/hI=;
 b=RvtAHtOMOInYTQ+fZwY/a5gwkc/PEtEt+bPNJcIBsSw7K8SZ1DdpGwlE+VxbhMCKJCf5Q74QaEKKEUHiHTtpvzTW7WcnWZ8B9Z5VO+lZo+JobMMWLsKEfiL+SrJhsUTCCCPCVGnhrn3aZV8dFY9CbljWyc/La/01ewxD/lx/MfCvYtPZRR5ZM3wxZrAV0636DMpoRo103+cAifJ1f7Db4LaDqoGt1nL4QjDP3Kwuw/D5688R/XuaC9ZWhysYWFsnKa5ui2OguAPl4vsO1CFqf5uXcjerBWXvv7l2xruGiefBAR2uAetk70GuGGyxsVuaELW7e7zDTDgm+ZUmrOraqA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.27; Thu, 28 Dec 2023 06:13:42 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::6037:db64:7000:119f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 06:13:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Johan Hovold <johan@kernel.org>
CC: Felix Zhang <mrman@mrman314.tech>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "marcan@marcan.st" <marcan@marcan.st>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "sven@svenpeter.dev"
	<sven@svenpeter.dev>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>, "kekrby@gmail.com"
	<kekrby@gmail.com>, "admin@kodeit.net" <admin@kodeit.net>, "j@jannau.net"
	<j@jannau.net>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Thread-Topic: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Thread-Index: AQHaN2/oF0vjfoypA0WLL/Bc2KeqL7C88eIAgAFJOkM=
Date: Thu, 28 Dec 2023 06:13:42 +0000
Message-ID:
 <MA0P287MB0217E3282699E84E790DAC4DB89EA@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
 <ZYv95BOowY38NesX@hovoldconsulting.com>
In-Reply-To: <ZYv95BOowY38NesX@hovoldconsulting.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [5UftSdDZ9YovIuRHUOpcqnxIcrixjSdx/kUcvHUzZ01UEW0jg5iOgLsHQfNwxr9r]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB1320:EE_
x-ms-office365-filtering-correlation-id: cdab0bcc-9d01-4814-9661-08dc076c2463
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qpDc2uOfNpKV2V4H2A9cJrQyM49QjK2JnBGXkFROSPLQ4BHdKp5nvgDqLhWtZnbRb9Oh/kUL+y6QJw8o95q3AXKrWQZZAV0hLId7IsZ2Nr/iBLY8dyFy6C2fwXZ9y15RKu41HfeAk6eXWUBil2CKrCGoFaZDcGTAfq9rxZ5UQgEagxfJ7mt8dFD7xAmzh2YesVxLJXaTNOebemCX/BU0IDOq02bxhRSC/P7ndBzr3FanF7d7xjwrfDi3995otSMocvUbu5XYWyZv4BOcejJ3G7hzYwsQKub+rTTHcHLlO3F/UXF6DRwxNwPo42Wd5IZEoqyJW8sMljyVB5JRK/Fq4HyRGMh1aRiERtR6kDO1oFqgrW/UdxLs69wVMB3QOoX3wQiQXVqC09foT1LBGB5cJcq3ypWc4DD+vxc2L4BGXFLYgcMH07GS+8ncwPCjFjj6ZUyoowm7zdECIDuvTq+ki2XpTjRakGiCgyQhgDzH8T8FIvVDbgj70MVQYXDuxoaQMo8nibY5Z/Z+c8e1vuesAHk8BjhFqKeDlAHCAN0N9r6/7oP+O0VkHb1LyGgCXOtCZ2QZvM04xh04OpjryNZkPx3Uorv6IlGbM8/rijUzvbI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0Jkb29aTDZLYVpxQ2tjOCtjOTg5Z1hBZnhQOVh2WWVINGszaHQva29yMHRu?=
 =?utf-8?B?RGh2Zk1RZVRTdy9Sb3ZuMTZlcWxVQjhrMGNVN1FTUTJGaGEvZHBheUpMS202?=
 =?utf-8?B?UGRldnV6WHk5WTVROTh5STZYdXBYL2ZLOHZaSXgrd3VPalExV0VFWlBhbk5N?=
 =?utf-8?B?RzdhUWtIazhEa3VNcmxJcHFZVlVacTNiWVQzb1dRcUFEU1FzbmgrQWxGeGk5?=
 =?utf-8?B?R00yakpoYnlOR0wrUFMvcGpWVnNaWmg2SXRsV1J5dTdQK0d1d2xrTjVkYWRJ?=
 =?utf-8?B?NWlFK0RraG1KVXZBcmczU01ZOGhUeWU2cXhrcG5yYy9SZDZLb1FzR3VzS2hz?=
 =?utf-8?B?TFNKU1pIZlN0S0hDZnFYdzRxZDE0YkgvcVRjTUlzYTlqMDdsR1ZwK0s2blJn?=
 =?utf-8?B?eFczQ3BsMEpHTXRiUXA5eHFIdUE5eUxxMWpyOEdyMG95NG1GaHNhcVJpcVpF?=
 =?utf-8?B?Qzk1RjBBWmd6TFl2T3kwVmQwUlU2V1JTeWFteEYvQVA2L2pVaTFaUUU1YXVr?=
 =?utf-8?B?N0dycjBYbkl1bnEvTmpWQkx1aWhDeG8zOFhrZ25yZGxSZ0VJM2FOTTIvTkRR?=
 =?utf-8?B?SlpJYm52bkhYL3dZR1MrMWJmcVVieVpSa3I1anNrclVLUDBBZS9oMUxRZEtr?=
 =?utf-8?B?VWlIR3FjSXJrMURmSnlHOFRaOTRJSmt6T2JTdTlheTBaQUUzK0R1T3A0R1c0?=
 =?utf-8?B?WkhNNVVxdUxGUWVTbVVYYWdySjRpNXlYajJIOEZvcVB0WUh0a3hNRWNCYk9S?=
 =?utf-8?B?RFhqMVFRVmo5aExibUowM1JoMk4vMkhxWlBUUzkxbEYvYURpdTRoMytHSC80?=
 =?utf-8?B?S3l6elV5RitobnNkOUo1TGdBb2RNU2EvWk5qejdmNTNjeHByejNGRTBvb29L?=
 =?utf-8?B?bnlLeHBZUnYrdjhEQ2Frc2M2Q09aRjkrUHNSUXFJaTVIMEtiL0xYQ0x3TmxL?=
 =?utf-8?B?eFhabW1EYVArZmhiZGYrUG5ROGRHMGhIa0FkdU5sUzJHeTQ4QUUvOXdQajBn?=
 =?utf-8?B?d21sRWdHREhjaGs2OTg2RTNOYzNvV0dWdFAyTlRkQzZWZjdaUzI2K0ZHUFU1?=
 =?utf-8?B?dGRMSUt2bmtSK3ZuY0k2QWhlZGQ5U0tIVTdUQUdlV2ZOUWMwckFlUW1LNFBQ?=
 =?utf-8?B?ZVRMN283dmtOS2piSSsyc0dKTjZielBVTHZRazFoZy9LTmNmVUZwSXhLNml2?=
 =?utf-8?B?Y2lkVzhFb1NYM1hFNWRsbitSU1hrSmtZS0EzQnMzbndlVmxvYWdUSC9JWGI3?=
 =?utf-8?B?cUJta2pOTEs3SytSOEFKaDBlazFMN1pNcEpLeFVLNVRuUWYrcmtwemdKR3pi?=
 =?utf-8?B?R3BNUVhTTFdrcjZWTVJhRlNRVFdNc2ptbTd3WEdCbyt6cEhBL3hpVDhKOTFS?=
 =?utf-8?B?TTdrNGUwWWtEdFQ0SzAwV3daMitnLzFMNXZsQTlSY0NTcGROaitXMDVza3E2?=
 =?utf-8?B?bHBIMW8rRFdLa25ucUVUNTErZWptNEw5d3VKUmJMdERDaHRWVXcwR3p3WTlO?=
 =?utf-8?B?ODNCYkNBWU00WURaQ0c1NnM0UnBwd3FhZlBmRjBZZ2FTOTBrNkpWaTNKZ0Iy?=
 =?utf-8?B?Vk1wcXBpNkRxUy9jSUg2VDcyWjZpRWhvWS9PVXcvdkJRSXFQZjBXb01EUFNm?=
 =?utf-8?B?MnhrM0lYYmtsVFpzcGoySnVpc01NRFIzS1RURGZmTXB3bDU1bk84dEMxT0N5?=
 =?utf-8?B?empDY1A0Ym52N0JUZjVYT2FlUFNvZHVkOFZVR21KUGpVVFVXSlZvakJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cdab0bcc-9d01-4814-9661-08dc076c2463
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:13:42.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1320

SSBnb3QgaXQgdGVzdGVkIGJ5IGEgcGVyc29uIGFuZCBKb2hhbidzIHBhdGNoIHdvcmtzLg0KDQo+
IE9uIDI3LURlYy0yMDIzLCBhdCA0OjA14oCvUE0sIEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIERlYyAyNSwgMjAyMyBhdCAwMzoyMTowNFBN
IC0wNTAwLCBGZWxpeCBaaGFuZyB3cm90ZToNCj4+IFN0YXJ0aW5nIHY2LjUsIEJsdWV0b290aCBk
b2VzIG5vdCB3b3JrIGF0IGFsbCBvbiBteSBUMg0KPj4gTWFjQm9va0FpcjksMSB3aXRoIHRoZSBC
Q000Mzc3IGNoaXAuICBXaGVuIEkgYm9vdCB1cCB0aGUgY29tcHV0ZXIsDQo+PiBnbyBpbnRvIGJs
dWV0b290aGN0bCwgYW5kIHRoZW4gdHJ5IHRvIHJ1biBjb21tYW5kcyBsaWtlIHNjYW4gb24sDQo+
PiBzaG93LCBsaXN0LCBpdCByZXR1cm5zICJObyBkZWZhdWx0IGNvbnRyb2xsZXIgYXZhaWxhYmxl
LiIgIEkgaGF2ZQ0KPj4gdHJpZWQgcmVsb2FkaW5nIHRoZSBrZXJuZWwgbW9kdWxlLCBpbiB3aGlj
aCB0aGUgbG9nIG91dHB1dHMNCj4+ICJ7QWRkZWQsUmVtb3ZlZH0gaGNpMCAodW5jb25maWd1cmVk
KS4iICBXaXRoIHRoaXMgcGF0Y2gsIEkNCj4+IGFtIGFibGUgdG8gdXNlIEJsdWV0b290aCBhcyBu
b3JtYWwgd2l0aG91dCBhbnkgZXJyb3JzIHJlZ2FyZGluZw0KPj4gaGNpMCBiZWluZyB1bmNvbmZp
Z3VyZWQuICBIb3dldmVyLCBhbiBpc3N1ZSBpcyBzdGlsbCBwcmVzZW50DQo+PiB3aGVyZSBzb21l
dGltZXMgaGNpX2JjbTQzNzcgd2lsbCBoYXZlIHRvIGJlIHJlbG9hZGVkIGluIG9yZGVyIHRvDQo+
PiBnZXQgYmx1ZXRvb3RoIHRvIHdvcmsuICBJIGJlbGlldmUgdGhpcyB3YXMgc3RpbGwgcHJlc2Vu
dCBiZWZvcmUNCj4+IHRoZSBwcmV2aW91c2x5IG1lbnRpb25lZCBjb21taXQuDQo+PiANCj4+IEkg
d291bGQgYWxzbyBsaWtlIHRvIHRoYW5rIEtlcmVtIEthcmFiYXkgPGtla3JieUBnbWFpbC5jb20+
IGZvcg0KPj4gYXNzaXN0aW5nIG1lIHdpdGggdGhpcyBwYXRjaC4NCj4+IA0KPj4gRml4ZXM6IDY5
NDU3OTViYzgxYSAoIkJsdWV0b290aDogZml4IHVzZS1iZGFkZHItcHJvcGVydHkgcXVpcmsiKQ0K
Pj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogRmVsaXgg
WmhhbmcgPG1ybWFuQG1ybWFuMzE0LnRlY2g+DQo+PiAtLS0NCj4+IHY0Og0KPj4gKiBBZGp1c3Qg
dGhlIGZvcm1hdCB0byBwYXNzIHRoZSBDSSAoYWdhaW4pLg0KPj4gKiBTaG9ydGVuIGRlc2NyaXB0
aW9uDQo+IA0KPiBBcyBleHBsYWluZWQgaGVyZToNCj4gDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9aWXY4dHAzZk1pQXFLOE9JQGhvdm9sZGNvbnN1bHRpbmcuY29tLw0KPiANCj4g
SSBkb24ndCB0aGlzIGlzIG5lY2Vzc2FyaWx5IHRoZSByaWdodCBmaXguIFRoZSBCRF9BRERSIHF1
aXJrIHByb3BlcnR5DQo+IHNob3VsZCBub3QgYmUgc2V0IHVuY29uZGl0aW9uYWxseSBidXQgaXQg
aXMgc3RpbGwgbmVlZGVkIGZvciBkZXZpY2VzDQo+IHRoYXQgbGFjayBzdG9yYWdlIGZvciBhIHVu
aXF1ZSBkZXZpY2UgYWRkcmVzcy4NCj4gDQo+IFNvIHRoZSBmb2xsb3dpbmcgZml4IGlzIG5lZWRl
ZCBlaXRoZXIgd2F5IGFuZCBpcyBwcm9iYWJseSBhbGwgdGhhdCBpcw0KPiBuZWVkZWQgaGVyZToN
Cj4gDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzEyMjcxMDEwMDMuMTA1
MzQtMS1qb2hhbitsaW5hcm9Aa2VybmVsLm9yZy8NCj4gDQo+IEpvaGFuDQo=

