Return-Path: <linux-kernel+bounces-129154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E485289660A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5BBB24212
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91D59B4A;
	Wed,  3 Apr 2024 07:19:37 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DE58106;
	Wed,  3 Apr 2024 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128776; cv=fail; b=ZC0nxLSnO5V9ZDPby5zaqeL0HBaPzu1SRxTUjxQ1B4j0/EPp4QNYh63McyLAndIHuKeNYUEvoIfHVKV2Y+KvI7n043O1YJD3sxkp0rK7TCLffxiHZG0HYLFHNl3bXRkMPpOBMf2YGPItnsy+l3yDpFmXbLF45s7dJHFq1X0bBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128776; c=relaxed/simple;
	bh=J5TWBHue3KQrc8B9IIWELf1S6Fn66DtmoMzYVjeCmGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLcB0OsqyAwDeqMzfy/Ro6eYMThnzmasi1rQGViDgpTgnzG8Ia5r/xBalhZX7qjMoSwWZ3R5ZJBNhZLsUyajB26Ueyk5WdBWcZRg/uIAlK7KoX+NN5tLBHVSA11ta2a69LF80Oj3C2v4ctupfSPRNmiBAL0Mb++gJebkXdw4Pqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJiG2KGZWbe9LUWo2Pye5jjPo9PlfTvEj4rWq9xOyUYQW0yYeNmtOwqP2HDRSm9yOoKBzqPTMjQu9cm4us6RiN7H+A3vfSDyr93YlGbMi554uOpGX0UAw8pd2SG8tpAw02JPmUUL/qKKfKfgVYf5jSnRPLIQ2xJfK8EUg6ze0b2nmTYGBc5EYvGUtcoqMK+jxj05t76ZDqGL1drindTVbsZKqX2XP0+kwYv+Tvebmrqb9+/iI0tGK1CCPldMpvgNAf0KnIN4YUANfo+uXIc8F15NR6Q9mmOjncyxLoDerJph/geDPzx62wNP23iKnQ2KuvvvKuXBgH4EY/cgomjbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5TWBHue3KQrc8B9IIWELf1S6Fn66DtmoMzYVjeCmGQ=;
 b=dGb/H9yjx4x8YpkKO1sb7zB9NevbvDQS4HJt76K8yMCie/a0yZaiO86RKE1jknPOjGk3x77uZhb1qUAad15ykG8HJxJ+aD/7ju4Jd6VxmZJsVD8cbDV72gkaA4ngaWNRyXoC15T1tjoqI9s6tyJMIKwI2zWv811omJ/grbBcxWXVSVGheALxZHs2Tipaues2IL44YML+vKWuAsW6UUfiXKvnnUZvrcPBORloCoTjhtj39oGewWzkm0S7SNhy+vXUHfxbHvikEKLZ6NY/MGk+3HcJr4TVcnI3k6M4TObUVoidQunF3zes1ywpV7nDep6yg+eNb+Is+lvX74VgBiKiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0987.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 07:19:27 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Wed, 3 Apr 2024 07:19:27 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng
	<hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Index: AQHahN18qtXBKBZlXUquUnYUH2QsmrFVKPiAgACsqfA=
Date: Wed, 3 Apr 2024 07:19:27 +0000
Message-ID:
 <NTZPR01MB095662C4A6FCAEB7B35C48FF9F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
 <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
In-Reply-To: <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB0987:EE_
x-ms-office365-filtering-correlation-id: a7b516e9-8101-4184-648f-08dc53ae65e6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DmylQNxB3g6o4BxiKSIXl+s9rqmz/Op6phwrYg4t2doBxLaVO/+xW42sOT0voCksIoIJtj5IAacwVKyrVqQMNJ2zM7+wreflz080GRCkhfZ7W/ZjaiUEOtzpfPDncEkB/lBJA4vDdV7yR4BmK884OtYoA8Hk5PjRM3c8Gd3Dfv2oRekXyj7QIYio4suKowSX94twcOQQ39Tdhj7u6RWv037qBqWZweabiq7lBTbN4QO6B89JVALyT7KZxfI8+htG4OhvHwCUPhJIGkfyC3dV2ybYsRaJVZdD9X12z6SjDOv33Bd9wKRSlBWdI8yswWpmwWS++UX6iGMPI+PuediT2vx8zxCj+uJ9tOEAG2XlhcX3tNbZwnpjqy1UBjstWIa0VHgwX0DRQv8XIt2a58E119l4lmqc0p598OqDxtA4fSRTrp5+RLQMjtO5dB9/UDHVuubUe4kkebGu9giiUF7d5Pa3aWRmX/gvb5+sQ3pPlY7XqPDUHAqzqAO9JxDvRoMXl1kd3mePsW9ZcSdVKq7TcOE44pyxXTqx0rdzP+7O+vyzLcaobwIeRS+Gt0VVY923RMAtWoAPiIFlRLULNZ0pIAEaYOxjNrJ8M83gH59bHIMqVjWIc+woIWAUwPK1wnRD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHRwdmNhNjNLQUZrMTExc3pGdldXNzVlQjhIQzM1MW5DRTRKREhFNjZjS0Z5?=
 =?utf-8?B?cFFoWEx0Z2EwOGtHRGNKekR3ZHoweld0SVk1K3NsQTBaTjlQRmdNYVZmUk5V?=
 =?utf-8?B?QmVGaWU5RUVBb01PS2k1V3VYV1B5SXFCeVdUbU9HK1pkMTQvUEF0aWZucDBj?=
 =?utf-8?B?NzZLMkI0b0g0S21ySFowaHM4UnlYem5hNE1YdkkzVHl1NlYxaDRqemRXc2RN?=
 =?utf-8?B?WXQwblNtT2l4Y2JVSTh6QmVIMm5nQ3lZNHJnR2xkbGZaR1Zpdk1ObHNyNEhE?=
 =?utf-8?B?MmtpUnlQTXFWbkd2NVJMeUpnRjIrWWx1Z3JEVUJnRmVKc2lIZG1pMk03K1Fq?=
 =?utf-8?B?TlNvY0xDV3BZdm5lTmR2Nmd4SEh4aEhFZjNYSjJSWFZVVnA4eGxBV0RLc1lU?=
 =?utf-8?B?Z1NXRlRwOENaUWRqa1lDM0lUZWF1OGdXcTUvZ2d2T01URnIrbTJKK2g4WUJm?=
 =?utf-8?B?OGVlSGpFKzFSNUJRVlM0RmdZL3paVUNVVlRINDgxYjVjeHVITGlKeUc0WWpo?=
 =?utf-8?B?bHVvbDZCSHVuNFZKNzlmQTB3Tmg5a1JOYkJBeVN0Ulhxcjd4eDdFTzRNVGo3?=
 =?utf-8?B?MHZPZVd2RVMwS0xXaWlCZGhiRVB1WUt3RlFKcytvc2FRN0hHb2RHZkZtSjRI?=
 =?utf-8?B?bnMxL3FZd0YwN3B0cmFIdktWcWNqRUNSWlJKYWhPdThnOUdWR3dhMXFncDBl?=
 =?utf-8?B?TkpxWFdNY2FMU3owTkR0YUJsYnBNc2ptNnJwLzlVN01MRlorUzkvbG5hNzMz?=
 =?utf-8?B?aFBpVmt4RmtzK2dYSnlCL0tHNEhyeXl4Mit3dDFibytXYzZ6Yk5IcnlYYnZC?=
 =?utf-8?B?WWtCM3lEWWlZeTFoZjVFU1ovUU9GdUM4U3A5TkdHbUNCdXRSaDE4SHNoU05P?=
 =?utf-8?B?THF2S0J6UnNkT0h0N0g0TTdLK0JGN3lBejB3R1E2bFJxMGJBTGxrN2dWWjBV?=
 =?utf-8?B?bG10ZUFUYklmQlBNYjdGMkhEK1EyOEczWTJXRnNqSjc2NXB4NXh5SnNRTnpz?=
 =?utf-8?B?TkdQclNhcmRaaFBsbk4yWUtoam1tbjBxUjAyaVYrMVRxWmxuZmZTeHdrRStX?=
 =?utf-8?B?b3d1SmJLTnZjb0g5VVpldExMb2dYb3g4ZEVCK2ptVlN5ZXJXd1hFQlFIMlA5?=
 =?utf-8?B?RHhQY2ZRTTh0cWNtZlN6MkZ4M3phV3p1aG91bWs3N0ZtcmZtUlNuMVVvRlJF?=
 =?utf-8?B?cForMXhaWjJkVGJreHFuZm5PM0RvR0ZEcGppS2c3QXUwQWhXMWU2Nkd5M0Nm?=
 =?utf-8?B?NmV0cHExd2ZHN0FBUG1vUHBxTmwwdkJUY3F3eHV1cTZZZHlHZnJoTXFBRnpl?=
 =?utf-8?B?UndIOW9xcW9BKy9aWVFGaktsQ0s3dWtUNVUwWUN2YVVSSitXdytHRFVZT1Bm?=
 =?utf-8?B?UXhVWEpjeXJjWVo3aEZKZEJMTk1wQ3BNdnBKUHhTYkJENmt4TmVPampWWGtN?=
 =?utf-8?B?ekd1TTV1VTVQd0YxelZ3aEFKMUFMbnRHUGJGRUpBcnFFeVNVK2JCSWxyTXh5?=
 =?utf-8?B?ZndNS1Naall3ODNERkdXbFhwWkZCbVZ6VmJlZlh6d25VS3VadGIwRkkxOFc3?=
 =?utf-8?B?K0lPamFhWmVmd1QybUxKY1JyUHovV21BYnprTC9FRWNjNnlHeGxVTXFxOHJ0?=
 =?utf-8?B?Q3J3WiszbHRFbEV4dWZFSkpsUlF5VW9ybFROanRZZmdPTjhYazhsYWFvcERT?=
 =?utf-8?B?QXRENU9sb3NINi80amFzVWR3cHlxTEJ0SUt3U3dTNWk2c3RST3ZpQ2ZhSVdU?=
 =?utf-8?B?RVR3VElwNUh0QjBaM0VQOHhKWkx0RVFVNTRGNGkxQUhXQTNVV3JPWUV2a2Fl?=
 =?utf-8?B?eDFVNUJ4MEhjQkoyYmhCeXhCRjF0ZXNjZ1FONi93UWpNaHNnSjNsazlvbVJL?=
 =?utf-8?B?VkFPTnh5UllhZ0hlWmxRd2RTSzBKd3NGM3lTdXdFczErYTNHbEdhWG4wZEZp?=
 =?utf-8?B?WWRYSzNVM2UreVVBQzNEN0R4K0V4UERHRkEwaHhPbXVLV2pxUmVVKzFNMXhY?=
 =?utf-8?B?WXNuZXdrc3Z1TkE0bUFHdTRxMThMejdSVWMyc2xRek5pYWFZUlFWYitJbkdT?=
 =?utf-8?B?TUJaTGFlaWVuenpTMkVLM1hRaytpdTZ6VWlKb0lqVXpUZE0wbXhZN1NQVDZy?=
 =?utf-8?Q?rAqa3ZSDkCi4AIp5IG7CXuBHO?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b516e9-8101-4184-648f-08dc53ae65e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:19:27.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Otnlr7Nd7bKDnVkOLWwRrag3JfDDOTnD26qSMGRb19VDY+BpsVA8hzLQp/ihynhtNfFEE+cXdAcEbS2tjXNRDlqPPANTBzKu6XPaMYyB9Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0987

T24gMDMvMDQvMjAyNCAwOjE4LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiANCj4gT24g
MDIvMDQvMjAyNCAxMTowOSwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+IENQVWZyZXEgc3VwcG9ydHMg
NCBjcHUgZnJlcXVlbmN5IGxvYWRzIG9uIDM3NS81MDAvNzUwLzE1MDBNSHouDQo+ID4gQnV0IG5v
dyBQTEwwIHJhdGUgaXMgMUdIeiBhbmQgdGhlIGNwdSBmcmVxdWVuY3kgbG9hZHMgYmVjb21lDQo+
ID4gMzMzLzUwMC81MDAvMTAwME1IeiBpbiBmYWN0Lg0KPiA+DQo+ID4gU28gUExMMCByYXRlIHNo
b3VsZCBiZSBkZWZhdWx0IHNldCB0byAxLjVHSHouIEJ1dCBzZXR0aW5nIHRoZQ0KPiA+IFBMTDAg
cmF0ZSBuZWVkIGNlcnRhaW4gc3RlcHM6DQo+ID4NCj4gPiAxLiBDaGFuZ2UgdGhlIHBhcmVudCBv
ZiBjcHVfcm9vdCBjbG9jayB0byBPU0MgY2xvY2suDQo+ID4gMi4gQ2hhbmdlIHRoZSBkaXZpZGVy
IG9mIGNwdV9jb3JlIGlmIFBMTDAgcmF0ZSBpcyBoaWdoZXIgdGhhbg0KPiA+ICAgIDEuMjVHSHog
YmVmb3JlIENQVWZyZXEgYm9vdC4NCj4gPiAzLiBDaGFuZ2UgdGhlIHBhcmVudCBvZiBjcHVfcm9v
dCBjbG9jayBiYWNrIHRvIFBMTDAgY2xvY2suDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogSGFsIEZl
bmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gRml4ZXM6IGUyYzUxMGQ2ZDYzMCAo
InJpc2N2OiBkdHM6IHN0YXJmaXZlOiBBZGQgY3B1IHNjYWxpbmcgZm9yIEpINzExMA0KPiA+IFNv
QyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWGluZ3l1IFd1IDx4aW5neXUud3VAc3RhcmZpdmV0ZWNo
LmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IEhpIFN0ZXBoZW4gYW5kIEVtaWwsDQo+ID4NCj4gPiBU
aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBhYm91dCBsb3dlciByYXRlIG9mIENQVWZyZXFbMV0g
Ynkgc2V0dGluZw0KPiA+IFBMTDAgcmF0ZSB0byAxLjVHSHouDQo+ID4NCj4gPiBJbiBvcmRlciBu
b3QgdG8gYWZmZWN0IHRoZSBjcHUgb3BlcmF0aW9uLCBzZXR0aW5nIHRoZSBQTEwwIHJhdGUgbmVl
ZA0KPiA+IGNlcnRhaW4gc3RlcHMuIFRoZSBjcHVfcm9vdCdzIHBhcmVudCBjbG9jayBzaG91bGQg
YmUgY2hhbmdlZCBmaXJzdC4NCj4gPiBBbmQgdGhlIGRpdmlkZXIgb2YgdGhlIGNwdV9jb3JlIGNs
b2NrIHNob3VsZCBiZSBzZXQgdG8gMiBzbyB0aGV5IHdvbid0DQo+ID4gY3Jhc2ggd2hlbiBzZXR0
aW5nIDEuNUdIeiB3aXRob3V0IHZvbHRhZ2UgcmVndWxhdGlvbi4gRHVlIHRvIFBMTA0KPiA+IGRy
aXZlciBib290IGVhcmxpZXIgdGhhbiBTWVNDUkcgZHJpdmVyLCBjcHVfY29yZSBhbmQgY3B1X3Jv
b3QgY2xvY2tzDQo+ID4gYXJlIHVzaW5nIGJ5IGlvcmVtYXAoKS4NCj4gPg0KPiA+IFsxXTogaHR0
cHM6Ly9naXRodWIuY29tL3N0YXJmaXZlLXRlY2gvVmlzaW9uRml2ZTIvaXNzdWVzLzU1DQo+ID4N
Cj4gPiBQcmV2aW91cyBwYXRjaCBsaW5rOg0KPiA+IHYyOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3RhcmZpdmUNCj4g
PiB0ZWNoLmNvbS8NCj4gPiB2MToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzA4MTEwMzM2MzEuMTYwOTEyLTEteGluZ3l1Lnd1QHN0YXJmaXZlDQo+ID4gdGVjaC5jb20vDQo+
ID4NCj4gPiBUaGFua3MsDQo+ID4gWGluZ3l1IFd1DQo+ID4gLS0tDQo+ID4gIC4uLi9qaDcxMTAt
c3RhcmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kgICAgICAgICB8ICAgNSArDQo+ID4gIC4uLi9jbGsv
c3RhcmZpdmUvY2xrLXN0YXJmaXZlLWpoNzExMC1wbGwuYyAgICB8IDEwMiArKysrKysrKysrKysr
KysrKysNCj4gDQo+IFBsZWFzZSBkbyBub3QgbWl4IERUUyBhbmQgZHJpdmVyIGNvZGUuIFRoYXQn
cyBub3QgcmVhbGx5IHBvcnRhYmxlLiBEVFMgaXMgYmVpbmcNCj4gZXhwb3J0ZWQgYW5kIHVzZWQg
aW4gb3RoZXIgcHJvamVjdHMuDQoNCk9LLCBJIHdpbGwgc3VibWl0IHRoYXQgaW4gdHdvIHBhdGNo
ZXMuDQoNCj4gDQo+IC4uLg0KPiANCj4gPg0KPiA+IEBAIC00NTgsNiArNTM1LDggQEAgc3RhdGlj
IGludCBqaDcxMTBfcGxsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+
ID4gIAlzdHJ1Y3Qgamg3MTEwX3BsbF9wcml2ICpwcml2Ow0KPiA+ICAJdW5zaWduZWQgaW50IGlk
eDsNCj4gPiAgCWludCByZXQ7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICsJ
c3RydWN0IHJlc291cmNlIHJlczsNCj4gPg0KPiA+ICAJcHJpdiA9IGRldm1fa3phbGxvYygmcGRl
di0+ZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICghcHJpdikNCj4g
PiBAQCAtNDg5LDYgKzU2OCwyOSBAQCBzdGF0aWMgaW50IGpoNzExMF9wbGxfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgCQkJcmV0dXJuIHJldDsNCj4gPiAgCX0N
Cj4gPg0KPiA+ICsJcHJpdi0+aXNfZmlyc3Rfc2V0ID0gdHJ1ZTsNCj4gPiArCW5wID0gb2ZfZmlu
ZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgInN0YXJmaXZlLGpoNzExMC1zeXNjcmciKTsN
Cj4gDQo+IFlvdXIgZHJpdmVycyBzaG91bGQgbm90IGRvIGl0LiBJdCdzIGZyYWdpbGUsIGhpZGVz
IHRydWUgbGluay9kZXBlbmRlbmN5Lg0KPiBQbGVhc2UgdXNlIHBoYW5kbGVzLg0KPiANCj4gDQo+
ID4gKwlpZiAoIW5wKSB7DQo+ID4gKwkJcmV0ID0gUFRSX0VSUihucCk7DQo+ID4gKwkJZGV2X2Vy
cihwcml2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHN5c2NyZyBub2RlXG4iKTsNCj4gPiArCQlnb3Rv
IG5wX3B1dDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBvZl9hZGRyZXNzX3RvX3Jlc291
cmNlKG5wLCAwLCAmcmVzKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKHByaXYt
PmRldiwgImZhaWxlZCB0byBnZXQgc3lzY3JnIHJlc291cmNlXG4iKTsNCj4gPiArCQlnb3RvIG5w
X3B1dDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlwcml2LT5zeXNjcmdfYmFzZSA9IGlvcmVtYXAo
cmVzLnN0YXJ0LCByZXNvdXJjZV9zaXplKCZyZXMpKTsNCj4gPiArCWlmICghcHJpdi0+c3lzY3Jn
X2Jhc2UpDQo+ID4gKwkJcmV0ID0gLUVOT01FTTsNCj4gDQo+IFdoeSBhcmUgeW91IG1hcHBpbmcg
b3RoZXIgZGV2aWNlJ3MgSU8/IEhvdyBhcmUgeW91IGdvaW5nIHRvIGVuc3VyZSBzeW5jZWQNCj4g
YWNjZXNzIHRvIHJlZ2lzdGVycz8NCg0KQmVjYXVzZSBzZXR0aW5nIFBMTDAgcmF0ZSBuZWVkIHNw
ZWNpZmljIHN0ZXBzIGFuZCB1c2UgdGhlIGNsb2NrcyBvZiBTWVNDUkcuDQpCdXQgU1lTQ1JHIGRy
aXZlciBhbHNvIG5lZWQgUExMIGNsb2NrIHRvIGJlIGNsb2NrIHNvdXJjZSB3aGVuIGFkZGluZyBj
bG9jaw0KcHJvdmlkZXJzLiBJIHRyaWVkIHRvIGFkZCBTWVNDUkcgY2xvY2tzIGluICdjbG9ja3Mn
IHByb3BlcnR5IGluIERUIGFuZCB1c2UNCmNsa19nZXQoKSB0byBnZXQgdGhlIGNsb2Nrcy4gQnV0
IGl0IGNvdWxkIG5vdCBydW4gYW5kIGNyYXNoLiBTbyBJIHVzZSBpb3JlbWFwKCkNCmluc3RlYWQu
DQoNCkJlc3QgcmVnYXJkcywNClhpbmd5dSBXdQ0K

