Return-Path: <linux-kernel+bounces-129233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D815C89676E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72F8B25F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF86BFCE;
	Wed,  3 Apr 2024 07:59:38 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78E6CDC2;
	Wed,  3 Apr 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131177; cv=fail; b=SIgqXYSdsTpc75iRct3ds8Z838XOND3Ote5/a6a0aKKx4cLsrdg5aO52Ly5jmCzezLYrOocGENI/WRvOByP7R6lFoPgYO/TplA9DNpTWfr4s8GMYvMFyP1Km0HpOn5Th2LyDJuUofTS/Mx6FDRbK273+vzpAkPGeK5LLbiQKZNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131177; c=relaxed/simple;
	bh=OnViBraitkPE5iWxrjNMvfcULUGarCkG8Od5Kax5Zts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YfUkjBdZlhzhlvGfyavjdDjT3qC5LNIVyaxT+q2Pj8/V29CxyZgMVI5DBr72OW04Gs67Iwocyw5f+Pxjt3y7DKK7hFa1dq5jwl71cU3gg7eT1mB+TTPpaeDMbRv2BGHkIDudK49PsapDzJoqwBej6bDbOvZbt5hqUfFZksdtQFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUqvKVFC4ZXw2/fGMi/7j/uu+3mVDY2MuTiAvY5QTPIK5Bfb/ghmUHkiDs6cEFyLJNH5TKusggzqkmopt2Fi4JhqD1FlB8mwXXkV2GOuKcAvwEyVXZU9IS6aoJkZatVrktVVOkr6w6I9Gorn2naelJ11Mx4QOiWBb2Zuf3uQipmqF8yxuv2i7r/Yp/N4OiQtFix8XrumQZfyckkZrFb9J0inlei76WgD9ka78n2HwNK5BRphs0ETT5ZNNOTuH7NZEAbSAc8WE7lga46RrxNgstmlPuL7YEEoHJCud6ta7ZDcESPU8PpevEmcWVRQF5ghh56AWj6U8nLHhmFBqM6o6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnViBraitkPE5iWxrjNMvfcULUGarCkG8Od5Kax5Zts=;
 b=fIUY6uoTwz5bkJG18MciMsApI9KGj6VcHI/IPwWjrLX95KEopBMckPuODXHXKnHUoDgjpKLTCCLDY0OKY/ZWGTEHFeHEtWFwe6W4ly32YIlWTZUcVSpWlLxAWGe9ZzbyXrFNfZBnTD2I2WiN701EjqRaj/JJLx3D1VvFCFQK1xDkU14N25ZAZUHLu/YoRARcdPuDHrEP8kRbgdUPbrdJB/qm4j36q0wlq5hZlKzLg5RoShG2LqER8DVy+QETcq+63rJAqX/awCPRtviczqGnpnWOOehTkV8Tappv3eUMBteKmrB3h3KXMU0yYb+T9SSnujrUzv15YbkOKejEaf9P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Wed, 3 Apr
 2024 07:24:39 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Wed, 3 Apr 2024 07:24:39 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Bo Gan <ganboing@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>, Emil Renner Berthing
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
Thread-Index: AQHahN18qtXBKBZlXUquUnYUH2QsmrFVKPiAgACIjgCAAHJBQA==
Date: Wed, 3 Apr 2024 07:24:39 +0000
Message-ID:
 <NTZPR01MB09560C9610FAE985884537C19F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
 <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
 <7e363fb9-5dff-b8de-fd4f-54b3596ad179@gmail.com>
In-Reply-To: <7e363fb9-5dff-b8de-fd4f-54b3596ad179@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1019:EE_
x-ms-office365-filtering-correlation-id: f7d11160-b84b-459c-abdd-08dc53af1f64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vtRZjzFwPdF+cY6PMxBSD+9LUaQuK9uFDDLqs9uKCjQv++Xl41D6jIvhYbqEIrAekLo456sMdj4a8ZhVs7+22h0jiOb6t/hndh9tiwyBHMpD/eLPg7+Q8d6xBSt7DXLb2XH94xozH5F5HWTgXhVrYiZuV9ZBdKdPRp3lXqGgNczKZk7x5YW+fltp8byH7nw9AQ/3if7LBoDHbZS5egWgRhWdVA+D7EoKpx8v3d/WaWHVn6SNVleQ2R5YZRDsb0dDKR3nvNE03yCRzEHQ2+Dqq4h4S2FxagednNA9hro0v+LC41aCh7XdUK3UbUmg7sssgx9VHvZw2U6MpLq8mP7fKCOjYsdx7NwPginOfUlzVD0/ZNmxBsYChico3mHk2UAYTUHhmJ1pn9Nhem7xc7W9W1W39zSfPckkdN/bnK76P4zSI74sfxWucLf+7X1OToZne0CzPMZKbdd5vWHXWiVna9q6BwsqPgXKL8mkoes3CHhe5UxlbTXuzodkkLwzJbSBwJrHJNHwgix2Of0+dWxOxAdgwayaco585lOd6gKyYN51SpujTVHgSIsqa8Sepn5v/1bm5W99MesgiL4r2iYfSELXuvqmsaaTBDMPocaATNxJtzUwMyr46hKlfn1G4l3Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFhuTDZpSWxOUWxnNXRUczdxK3IrdTZ2NVdaM3JTbm1YbjVONFhWRDExY1N2?=
 =?utf-8?B?bWRJQ1VFVExPTTJSZmJtalFkRGhWTk1DWDBhMkV0ZDFTWFhmMTBiNWxId0JY?=
 =?utf-8?B?WlJ4dVd4alB2c0krS2MrSW5TSGdVM2JQNHh0NHQyRC9wS3h6NXU0VTFMOXJE?=
 =?utf-8?B?ZDY5bHRwekFYeXBJaFVDaE9JT3VPaWFWZnFEQ3g0ZHJMaFZWaEZ1aStrbERY?=
 =?utf-8?B?SXh6UFY3SEpDbUhkRVJKdDRieC9Kd1hPTVNQMUpKYlJOcG8xSUtuZXhFQXNJ?=
 =?utf-8?B?ZHg5cnppVWtPY0NOZTM4dXZGRHRkOHdabW1BMzVDL0ZsMDBybWNJQlQyWU5W?=
 =?utf-8?B?aVpsZndad040VU4xeFRBMllOdi95enFTL2RETEpRZGRxelFqWFBwNEdhRytF?=
 =?utf-8?B?Zm9VbTVNV001anNqdDFSdHhSSjVya1JNTVE3WnFkMjljaGpsSHBIMW1QQmdO?=
 =?utf-8?B?a3duQ3U3NmR3cE8wZFE3MDRoaTB0dEdYV0FBRXoxSm1PYmo3QlhaZ2Nvc1hG?=
 =?utf-8?B?RGZtM1d3NnZCaEdJcllRSmUrK2Y3eGRSTFJxb3o5eGdPSmFzbEFRaCtSVG1N?=
 =?utf-8?B?cW5uaHkreXd3ZkNNUmR1UWd3Q25qYWFCaEg1dlZsd3lnUEpDZFhhN3JYZXFX?=
 =?utf-8?B?cTBuK0gzcHRUS252WTJRU1UwQk9BbFpabkdDZXhyM3hRWTV4ZFdvUE9adkdm?=
 =?utf-8?B?MythUHJNWjNEeE1BeCtEUXFoMFQyUW9QYmtyRHNTenhxdjRsVzdsbG1wK2Qr?=
 =?utf-8?B?SFBGMThxbWxnV0M4QmlxUzJ1WUlpdm1LcHpIY3hFZjZMd1l5a0xxS2xIMVBs?=
 =?utf-8?B?L0kySDY3Snk0WDNMblg4S0JKTHNoUzNNMkNocXoweUhNZHlDUzM2VUVXSkdU?=
 =?utf-8?B?elZXSk9FMWF6YVpkaHBvRnRqR05lcllTTE4vQWhKaS9KbElsR2J1a29lNjJu?=
 =?utf-8?B?bFhkS01kMzZTMnRhbkRSKythNkp6bUREQm4zcXdaWVArQm14eEpPU1dUZUNL?=
 =?utf-8?B?SldkbzFiRCtidnVZdGJmYzBSNk9LK093NXNJNGluYXZianFjVVRpMkVkYU11?=
 =?utf-8?B?bmNDMno1NmNLalRkQVlZT1VwdUhEUEhUZ2ZkdmFyYUFwM0I4cm9LUi9sM2JJ?=
 =?utf-8?B?aHdrRUpaRlpqNU84dmp0L1QwWDhQNXg3dVN4ZlhyQnJrRzBncmM3OWFCa3BT?=
 =?utf-8?B?bVIvVDAvaFhkKzc3MlZnNmFzZWVRbkpkc1NMb2VoSmg2Uys3VnAwMGs0MS9x?=
 =?utf-8?B?NmRLUFVrd2FQVTRvS1JLN3Y1ZFFqQjdLbkYvMFgwWVAxSkRmLzVIdm8wOVRV?=
 =?utf-8?B?OFgzQUR0ckFzdDJBUVQyak03ak83WVVhTkx0UEkvUmg5TVl1aU5NTEkrSnVz?=
 =?utf-8?B?R0x2K2xMcGxGL3VGN2t2Nm1TUzZQeGFnMlF4dHV0SkRnYkF1U1B2c2hNcFQ3?=
 =?utf-8?B?Y01wcnZ0Sm41M0tiNkRKVEhNS3R0amFHaFR1VC96citTUkx4K0N3SjI5UEgz?=
 =?utf-8?B?dC80aXNEVmRsRVRJNGFsZkdwcjJqMVFxWHFuNmtGZUU4RTlpaDZ0NDlxRnVL?=
 =?utf-8?B?L05Ma1N3YUFWUllzeThnS0tFUnlmM25aTXhIQXF5bEFMNmVqWkpBWi96ODEx?=
 =?utf-8?B?cW13ZkgzeVNqQndXcW9oZnBLVWtFd245cmVodTEvWjRCOHhTL3o3Q1NGVnNv?=
 =?utf-8?B?NG1uNHhEQUhyR0dudk93RHFjbmJmdHVmSEU3VGtaeEtGTVZPSktsR2FIRXZi?=
 =?utf-8?B?NHVMc1ZlcUJEYlJVbFVBWXFOaENWSTVLdFdBVTNYSEVsdERmTGRQTDM0WlFX?=
 =?utf-8?B?d1QvbWlJaW1EZXhlczFrV1dTT2FNMEUwa3Yxb3RWSXR2ZzBRMlFVanpVay9G?=
 =?utf-8?B?ZWMrWGEwWldyelFtRGNBMGs0ZHBEUktjYUU0Vy9tWlpYbmU1STV1ZDFVdUVZ?=
 =?utf-8?B?cDJBK3JVZndid1BHWUkwK0c0WmpaMlZBMEZLdEcyR29jUnplK3JTRGJVVDRy?=
 =?utf-8?B?Tzc5NHhuR3dYMlJFemxEY0RITHJLSmRNWlNVZlZHRWV4QkNoN2N4WEplYktx?=
 =?utf-8?B?d0kzbTBqTkxoT2dYbXpTTlNuc2dGVEFXTkRua1NQNW0xQlkwNWFRTzZxSEZT?=
 =?utf-8?Q?W5dPttAG1Nor0Dy9RpbGtPu6I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d11160-b84b-459c-abdd-08dc53af1f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:24:39.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ui6PfN5eh+f2PcW5LIOdcwQM/HVMMsatoho6ZT6ubY0cqwX5H+YbixxCvizV3swnFxay4ATgpccQqngGf66yUsneoy55HuOvPTpdX7NlqzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1019

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm8gR2FuIDxnYW5ib2lu
Z0BnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTlubQ05pyIM+aXpSA4OjI3DQo+IFRvOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBYaW5neXUgV3UNCj4gPHhpbmd5dS53dUBz
dGFyZml2ZXRlY2guY29tPjsgTWljaGFlbCBUdXJxdWV0dGUNCj4gPG10dXJxdWV0dGVAYmF5bGli
cmUuY29tPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+
IDxjb25vckBrZXJuZWwub3JnPjsgRW1pbCBSZW5uZXIgQmVydGhpbmcNCj4gPGVtaWwucmVubmVy
LmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsN
Cj4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3Jn
Pg0KPiBDYzogUGF1bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsgUGFsbWVy
IERhYmJlbHQNCj4gPHBhbG1lckBkYWJiZWx0LmNvbT47IEFsYmVydCBPdSA8YW91QGVlY3MuYmVy
a2VsZXkuZWR1PjsgSGFsIEZlbmcNCj4gPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsg
bGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gY2xrOiBzdGFyZml2ZTogcGxsOiBGaXggbG93
ZXIgcmF0ZSBvZiBDUFVmcmVxIGJ5IHNldHRpbmcgUExMMA0KPiByYXRlIHRvIDEuNUdIeg0KPiAN
Cj4gT24gNC8yLzI0IDk6MTggQU0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24g
MDIvMDQvMjAyNCAxMTowOSwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+PiBDUFVmcmVxIHN1cHBvcnRz
IDQgY3B1IGZyZXF1ZW5jeSBsb2FkcyBvbiAzNzUvNTAwLzc1MC8xNTAwTUh6Lg0KPiA+PiBCdXQg
bm93IFBMTDAgcmF0ZSBpcyAxR0h6IGFuZCB0aGUgY3B1IGZyZXF1ZW5jeSBsb2FkcyBiZWNvbWUN
Cj4gPj4gMzMzLzUwMC81MDAvMTAwME1IeiBpbiBmYWN0Lg0KPiA+Pg0KPiA+PiBTbyBQTEwwIHJh
dGUgc2hvdWxkIGJlIGRlZmF1bHQgc2V0IHRvIDEuNUdIei4gQnV0IHNldHRpbmcgdGhlDQo+ID4+
IFBMTDAgcmF0ZSBuZWVkIGNlcnRhaW4gc3RlcHM6DQo+ID4+DQo+ID4+IDEuIENoYW5nZSB0aGUg
cGFyZW50IG9mIGNwdV9yb290IGNsb2NrIHRvIE9TQyBjbG9jay4NCj4gPj4gMi4gQ2hhbmdlIHRo
ZSBkaXZpZGVyIG9mIGNwdV9jb3JlIGlmIFBMTDAgcmF0ZSBpcyBoaWdoZXIgdGhhbg0KPiA+PiAg
ICAgMS4yNUdIeiBiZWZvcmUgQ1BVZnJlcSBib290Lg0KPiA+PiAzLiBDaGFuZ2UgdGhlIHBhcmVu
dCBvZiBjcHVfcm9vdCBjbG9jayBiYWNrIHRvIFBMTDAgY2xvY2suDQo+ID4+DQo+ID4+IFJldmll
d2VkLWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4gRml4ZXM6
IGUyYzUxMGQ2ZDYzMCAoInJpc2N2OiBkdHM6IHN0YXJmaXZlOiBBZGQgY3B1IHNjYWxpbmcgZm9y
DQo+ID4+IEpINzExMCBTb0MiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5
dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gSGkgU3RlcGhlbiBh
bmQgRW1pbCwNCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYWJvdXQgbG93
ZXIgcmF0ZSBvZiBDUFVmcmVxWzFdIGJ5IHNldHRpbmcNCj4gPj4gUExMMCByYXRlIHRvIDEuNUdI
ei4NCj4gPj4NCj4gPj4gSW4gb3JkZXIgbm90IHRvIGFmZmVjdCB0aGUgY3B1IG9wZXJhdGlvbiwg
c2V0dGluZyB0aGUgUExMMCByYXRlIG5lZWQNCj4gPj4gY2VydGFpbiBzdGVwcy4gVGhlIGNwdV9y
b290J3MgcGFyZW50IGNsb2NrIHNob3VsZCBiZSBjaGFuZ2VkIGZpcnN0Lg0KPiA+PiBBbmQgdGhl
IGRpdmlkZXIgb2YgdGhlIGNwdV9jb3JlIGNsb2NrIHNob3VsZCBiZSBzZXQgdG8gMiBzbyB0aGV5
DQo+ID4+IHdvbid0IGNyYXNoIHdoZW4gc2V0dGluZyAxLjVHSHogd2l0aG91dCB2b2x0YWdlIHJl
Z3VsYXRpb24uIER1ZSB0bw0KPiA+PiBQTEwgZHJpdmVyIGJvb3QgZWFybGllciB0aGFuIFNZU0NS
RyBkcml2ZXIsIGNwdV9jb3JlIGFuZCBjcHVfcm9vdA0KPiA+PiBjbG9ja3MgYXJlIHVzaW5nIGJ5
IGlvcmVtYXAoKS4NCj4gPj4NCj4gPj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vc3RhcmZpdmUt
dGVjaC9WaXNpb25GaXZlMi9pc3N1ZXMvNTUNCj4gPj4NCj4gPj4gUHJldmlvdXMgcGF0Y2ggbGlu
azoNCj4gPj4gdjI6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgyMTE1
MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3RhcmZpdg0KPiA+PiBldGVjaC5jb20vDQo+ID4+IHYx
Og0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MTEwMzM2MzEuMTYwOTEy
LTEteGluZ3l1Lnd1QHN0YXJmaXYNCj4gPj4gZXRlY2guY29tLw0KPiA+Pg0KPiA+PiBUaGFua3Ms
DQo+ID4+IFhpbmd5dSBXdQ0KPiA+PiAtLS0NCj4gPj4gICAuLi4vamg3MTEwLXN0YXJmaXZlLXZp
c2lvbmZpdmUtMi5kdHNpICAgICAgICAgfCAgIDUgKw0KPiA+PiAgIC4uLi9jbGsvc3RhcmZpdmUv
Y2xrLXN0YXJmaXZlLWpoNzExMC1wbGwuYyAgICB8IDEwMiArKysrKysrKysrKysrKysrKysNCj4g
Pg0KPiA+IFBsZWFzZSBkbyBub3QgbWl4IERUUyBhbmQgZHJpdmVyIGNvZGUuIFRoYXQncyBub3Qg
cmVhbGx5IHBvcnRhYmxlLiBEVFMNCj4gPiBpcyBiZWluZyBleHBvcnRlZCBhbmQgdXNlZCBpbiBv
dGhlciBwcm9qZWN0cy4NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+DQo+ID4+IEBAIC00NTgsNiAr
NTM1LDggQEAgc3RhdGljIGludCBqaDcxMTBfcGxsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYpDQo+ID4+ICAgCXN0cnVjdCBqaDcxMTBfcGxsX3ByaXYgKnByaXY7DQo+ID4+
ICAgCXVuc2lnbmVkIGludCBpZHg7DQo+ID4+ICAgCWludCByZXQ7DQo+ID4+ICsJc3RydWN0IGRl
dmljZV9ub2RlICpucDsNCj4gPj4gKwlzdHJ1Y3QgcmVzb3VyY2UgcmVzOw0KPiA+Pg0KPiA+PiAg
IAlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJO
RUwpOw0KPiA+PiAgIAlpZiAoIXByaXYpDQo+ID4+IEBAIC00ODksNiArNTY4LDI5IEBAIHN0YXRp
YyBpbnQgamg3MTEwX3BsbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0K
PiA+PiAgIAkJCXJldHVybiByZXQ7DQo+ID4+ICAgCX0NCj4gPj4NCj4gPj4gKwlwcml2LT5pc19m
aXJzdF9zZXQgPSB0cnVlOw0KPiA+PiArCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVM
TCwgTlVMTCwgInN0YXJmaXZlLGpoNzExMC1zeXNjcmciKTsNCj4gPg0KPiA+IFlvdXIgZHJpdmVy
cyBzaG91bGQgbm90IGRvIGl0LiBJdCdzIGZyYWdpbGUsIGhpZGVzIHRydWUgbGluay9kZXBlbmRl
bmN5Lg0KPiA+IFBsZWFzZSB1c2UgcGhhbmRsZXMuDQo+ID4NCj4gPg0KPiA+PiArCWlmICghbnAp
IHsNCj4gPj4gKwkJcmV0ID0gUFRSX0VSUihucCk7DQo+ID4+ICsJCWRldl9lcnIocHJpdi0+ZGV2
LCAiZmFpbGVkIHRvIGdldCBzeXNjcmcgbm9kZVxuIik7DQo+ID4+ICsJCWdvdG8gbnBfcHV0Ow0K
PiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXJldCA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UobnAs
IDAsICZyZXMpOw0KPiA+PiArCWlmIChyZXQpIHsNCj4gPj4gKwkJZGV2X2Vycihwcml2LT5kZXYs
ICJmYWlsZWQgdG8gZ2V0IHN5c2NyZyByZXNvdXJjZVxuIik7DQo+ID4+ICsJCWdvdG8gbnBfcHV0
Ow0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXByaXYtPnN5c2NyZ19iYXNlID0gaW9yZW1hcChy
ZXMuc3RhcnQsIHJlc291cmNlX3NpemUoJnJlcykpOw0KPiA+PiArCWlmICghcHJpdi0+c3lzY3Jn
X2Jhc2UpDQo+ID4+ICsJCXJldCA9IC1FTk9NRU07DQo+ID4NCj4gPiBXaHkgYXJlIHlvdSBtYXBw
aW5nIG90aGVyIGRldmljZSdzIElPPyBIb3cgYXJlIHlvdSBnb2luZyB0byBlbnN1cmUNCj4gPiBz
eW5jZWQgYWNjZXNzIHRvIHJlZ2lzdGVycz8NCj4gPg0KPiA+DQo+ID4NCj4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gS3J6eXN6dG9mDQo+ID4NCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+
ID4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCj4gPg0KPiANCj4gSGkgWGlu
Z3l1LA0KPiANCj4gRWNob2luZyBLcnp5c3p0b2YncyBwb2ludC4gVGhpcyBwaWVjZSBjb2RlIHNl
ZW1zIHdyb25nIHRvIG1lLiBUaGlzIGxvZ2ljIGJlbG9uZ3MNCj4gdG8gc3lzY3JnLCByYXRoZXIg
dGhhbiBwbGwuIFdoeSBkb24ndCB5b3UgZG8gdGhlIHBsbDAtPm9zYy0+cGxsMCBzd2l0Y2hpbmcg
ZnJvbQ0KPiBzeXNjcmcgc2lkZSBkdXJpbmcgcHJvYmluZz8NCj4gDQo+IEJvDQoNClllcywgVGhh
dCdzIHdoYXQgSSB0aG91Z2h0IGFuZCBJIGRpZCBpdCBpbiBwcmV2aW91cyBwYXRjaGVzLiBCdXQg
RW1pbCBzZWVtZWQgdG8gbGlrZQ0KdG8gcHV0IHRoZSBzdGVwcyBpbnRvIHRoZSBjbGtfc2V0X3Jh
dGUoKSB3aGVuIHNldHRpbmcgUExMMCByYXRlWzFdLiBTbyBJIHRyaWVkIHRvIHVzZQ0KdGhpcyB3
YXkgaW4gdGhpcyBwYXRjaC4NCg0KWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FK
TTU1Wi1nWXBuX0ZqRzJaYl9fTnQ9cmJyTlFOOFFETkI9S0VGZGVWa3o5UHR2NzJRQG1haWwuZ21h
aWwuY29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpYaW5neXUgV3UNCg==

