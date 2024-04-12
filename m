Return-Path: <linux-kernel+bounces-142102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF18A278D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F4FB24442
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A024EB38;
	Fri, 12 Apr 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHoTOsZA"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8A482F4;
	Fri, 12 Apr 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905270; cv=fail; b=D27/5DoluvvZjU+sBHlkJk5zoYZOCeWjFk6n8W00ofxDBqpVpZHA3dnwsiyfr3wmZ0YGWtAjakr51sDRu4TToz6do3Ii59NpGGtJd00YjyaLxz9DKlnn8q/0yZPEFbwHi/5matMKmYJyA4448BWvI6Xg3mIhTuYyRc0DgBED7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905270; c=relaxed/simple;
	bh=NIVNImOGC8PfG6GZ/pY1MMdpAjFC+SHlD+YtX5ltCQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0PpX9Xo7mQ97tLtz9ayIxar4LLSYG0j/HEw0cPDnLk7LJc8DyHF6YLOZ1sFUk8EIETzqhPCxC3ypdcN8ZLA8bV1OFa0NTTud+lRwtpmQ22nOrofGNoFTRKD+Hz/6boe5LPOmzA+Acsngb0fvDNl+MNEY2Hl4+DnxdSVzf2PYUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RHoTOsZA; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7XVGAw1rBBiKjfcv1krb3ZupCcSKMy1etQ0D5rwvGk9g/ZFbQVl4JzlFHYOs+AhXbyfBZR+VM8YSaJMFAcNq1zfutnsfzbLWMi6JJHWaTjgs+eRomDP50VUgcsAVfhh1EwRdGZi88ZsBVu12qYxOPErM19/vOoTUhZyoEKRyFqjC24IQaE8k2C168NFKtfDlrVaKCBS7tH5ruWt0XqxfIk9ClPc+dh0Lef5l7mrN8fU8SqQswgJ6z2KrC/dABZXtqI+vA1VU4q3VKbKjI45V+k03YV8zmEJgHd56A1rLMhralG0OL3O2AGZIJc6gFBMklwZRU/ZBVVV4bCYTmhjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIVNImOGC8PfG6GZ/pY1MMdpAjFC+SHlD+YtX5ltCQg=;
 b=PQVf8upATS77AgFl6bNc5v1zpURTRRBMVjCVgoDAfQGx+1S/fswJ3ZN1RRMISHeaTBL/5xwnOlyWSEGkXgXUbrFIYe/ez3GzSowedrRUAzaCQDhPbIlTOFUNLKaxm96LpEvT27sVid5ZkxfVLkUMsgN/oagFcNjh/dgaH0+e9F8RyMMGmJLYps9LwXU5WKCl3lYuQsTMZ0i8d6PHh+kRS5O/HinRWd/LYD5kN+h+TeiUB8FKSH517YGjux0LWDCZbnY/A9tnjyMAtbRcgHaAdGxoKtyD3MI6gja41prwdo1/a05YlytRjF3vGms+n+iHvmGHxqFcH0chDyGNYSFNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIVNImOGC8PfG6GZ/pY1MMdpAjFC+SHlD+YtX5ltCQg=;
 b=RHoTOsZAOZtirTRNLbZoh0nOynyLHytdv4Evgyo3xE9tscgQsrJjzM6dcN0YYMV6O20OZ0/kMeIePHxUxX28etcQOAOeygjW04RV2JKzcIxm+72RKufFHygidrxSRZCO9mQRC7SiQiYhsQ2mE3rhaeJfYijcTcZF5UzRpmLMyws=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:01:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 07:01:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Dhruva Gole <d-gole@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHajG43VACXpQ/Xz0Cypsv4qvfUjLFkJ/aAgAAM6mA=
Date: Fri, 12 Apr 2024 07:01:01 +0000
Message-ID:
 <DU0PR04MB9417DF1519C59AEBE156BC2488042@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
 <CAHp75VfBaU+F-+3zte66mxgJ+gW9N7j8E+0gw9_T9J5DHTnsBA@mail.gmail.com>
In-Reply-To:
 <CAHp75VfBaU+F-+3zte66mxgJ+gW9N7j8E+0gw9_T9J5DHTnsBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8323:EE_
x-ms-office365-filtering-correlation-id: 2da32323-33be-4e7b-82aa-08dc5abe4fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DjO/my8gijsP4Y7x6CgdC36hmUzMx3SpRaXjgN6IH0lpPhgBitu/JnTTEnHlm5yLAGVusdafYKg0woirq4yGcMIsBeLxS+Up/oyg472PPsobgDqwUcbxNfDBBSZ9JTLQR7c+jm4tLFjepGcdJyiM6yH4FW7/Q55HoZh0HoePgN+VcRlvIJLKizfV7IDXqBWgUUqZClZlmgTcBhHbu3qDOJsk4xpEN3dAbkNgy/Lv9Kiv5FQ7ZLbJeo/lgj3dahU/2rR2dnwqvw3FiHqo024fvZoVJ7gRAAj9QDBe+HWHHP4H8CaA9FvOrwfqnz6/o/4TyPvVPVoLoIG9ljho0nN8qRT+qdo5wiptmanN8Aq3dpZWJocR0eS27gTCEqMlkYV6Zmvxf/HxRcIulaD2g3614gSUkChlTxK01nMvAXvKQuLOr8JWMYPNblYNduSSXPMkAJC7M/Ie+VViHg9WhKYyyAMJ+LzBilMUZUKWTMQOf6k2M0d4mmfT3iMhHAlpIbembPsbEwR1BBSTES7Sv2C9ouaS5ApZSOy9Yy9nOA1lgLRBDCNhkmw3rbYduFdREOC2ISuFGVtmuHOz3Lmz+NJyZIbFI8JVvAwZADUs2Ox3aID9XoPpb0YSJljC+xhSDsNS/IaSe8NwaAf2gUDztw49LaoqSKGcstRtBHg5g70gE3ei5uu17PukyetI2ypTpAq2CvFU82AXQd/MTKpHd/VvTA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGFxWUVHS2xmWGhCdWlSS3Q0cU1qNnBXbERtZDBsWVJEL0hpbGlza3gxY1FR?=
 =?utf-8?B?STF3OUIxbzcxeUIwRDRmSDRLSjNPR1NiOTNlSFdvVjhzcjUvZFlQbFJocE8r?=
 =?utf-8?B?a1JGWi9yQU5wQm1qSUtmM0JOVENqZzVpSXN1QUJPc2pRekhzRzFxcmp1TTBl?=
 =?utf-8?B?V1dscVk4ek1NMG54MUFBc2xSSUh4Sm1KcnRoYys0aTM4TEpoK3lKdllqcVg1?=
 =?utf-8?B?ZFEwUExxNlhEU2tOcTJSczczSWc5RkZZNzJvTFJIb0pIbHFwa09HcThXU2ov?=
 =?utf-8?B?V2ROOU4yb3FKV2N3ZTY3aGFLYXVBVjdkM0xqN1cyNHE2a3E5dnJtSlkvQTFE?=
 =?utf-8?B?cDQ1aUhoblFEMHc3NDNLWEQ5c0FLT0hscDFHUnQvMFJXSk5GL29lVE9zM2lr?=
 =?utf-8?B?TldxMVdkc1hWS1F4Q1pxNXY0ZUhPd0oxa3YvdzJiRlZNZ3Q4KzlzMERoVGps?=
 =?utf-8?B?T1h2TWtSc3lsN0V6ZmpKUENVV2RMSXUrQnFjcWJia3VzTXlSUmtON2JlWXps?=
 =?utf-8?B?cldNZjFiQ0NMdXpBVkJkaHRwWG5QWGpROTJiUXNQMUlLVnE3OEwzeWFWVGNi?=
 =?utf-8?B?YmRnSXdBY0hHbXdDOXU0ZlZCWlU2cWh6QWNOTWsxcnlUcUIwOFhaNFFkVEVo?=
 =?utf-8?B?eG5KOWVGa1pyM0g5S3paU1BweWYvaFZZbytkOCs2STJQSUlINExrc05kWGJJ?=
 =?utf-8?B?emZoMGlSczhQem5LYnZGbzdoOWg4dFI4eGJac3owWU1Qb2ErQWYxTWdNNzN0?=
 =?utf-8?B?WktkRDhKVHg5dVNFeEZUckJMc0dKemZVbTZDMys1S0xSc1lmV0dnak1VTWN3?=
 =?utf-8?B?UXBFaFpZOXliWGpHaUNYOVg3U2tSUGNrRzRqOFNXUG9JbXZaK251SXJVMWJ4?=
 =?utf-8?B?dit2bnBid1p5a1FIeSt6c29pbThVVnlaeXZhNTFBOStBM21iQnFDeXlqYksv?=
 =?utf-8?B?M1g3NkJ0MURPV0FtNi9NMGY4NXpXeUducFJwZmErNEdFRlRuNlJJanhVQzlr?=
 =?utf-8?B?R29Va2tpYW1xeE4wekhVZHRsWTljS3NrNk5WWXR3bktTSHJPdzVvQUZHaWhG?=
 =?utf-8?B?MGhmandlWlNObGErVUNFSktnN1ZmMWNSb3lnL24yL0xQM05GY1VKVWZyZUd0?=
 =?utf-8?B?WkMxa2xLQWxzbllLakU3YTFUUWZiNGxacEM0SmdqcXBaY3JhaXVhb1BjL2Iv?=
 =?utf-8?B?azBxN0VoUnYza0pUM01YWUlRWFAzdFQ1Z2c1RmJCWGNncHVBaUFvSkFScjIx?=
 =?utf-8?B?WGhIeVREOVN4OE1JTzE5aEhNOHZNNS9POGViR3d5R0dDMkl2ZWFUWFlYK0Nx?=
 =?utf-8?B?a0lCVlNSZ29jaGZLbzVMb0ZHVzV3bGpobHp2R3Q3THZUdlhxOGF4bUphVk00?=
 =?utf-8?B?UG4xN012bmpRdzh6UXFGcElzaGdWaE5UZ1RYTDNWMU5GTlFUM1RKLzREajFD?=
 =?utf-8?B?dHlaKzk4YmFuUnlNTGsrMFFGMEFqang4ZlR0QitNUldSdTJGQUptZHJFSFdR?=
 =?utf-8?B?T01PelFHdHNzSzdlVEYwdkxNT0pUVUl5WDl6ZUpRNnZsaVV2Rm1aRFBON3JR?=
 =?utf-8?B?ejgvWjJidGlhNnZsZzVZNjU2czVOQlY1VTdGR2E3RzhYNnJlUkRDWVZ1MmNQ?=
 =?utf-8?B?eTVvQWpxRGNWbldTNTJRY3JJb1czUUVIWXlDNXJtMnhwMEJxTTNnS0pBS3hw?=
 =?utf-8?B?cEZvVlN2TFNTSU9jZkFJdnd4elQ0WFNGWGtVR3IvY0JQK2ROSlM2aE9FMmJy?=
 =?utf-8?B?NXZjNmQ2S2NTVTFvNjRjUjJsZjBFK3ZkbXl3YkV5ZDZjeU5lWDdST2MzNVdn?=
 =?utf-8?B?aGNSU0JVMkpJbElKaEdxKzBLTW8rbVVqNGRrSGVEMHNDS1ZQc2UzRDByTVZV?=
 =?utf-8?B?czN5RG9zeDVlazk3b3I4ZXZTMi9VVW4veXpXMTZ2U0JZV2plNXpyU2ZtWXJV?=
 =?utf-8?B?Mlk3aCs1ek82eEtndC8xUm16Q3BDK1I3K0p5anhqcEJ1OGJhaTdNejJ1MGU0?=
 =?utf-8?B?LzE2bmM4MktxQ2NVSWFnQzFBRnp5aUE1YXlkcnlheVNzWU52OXdWSjd5N3Zl?=
 =?utf-8?B?YVVuY0JxSUx4ZGVzZU13Q1Q5dkhzSjBkZFlMMDJmWHNMM2ZPTE1uQ0doZlpZ?=
 =?utf-8?Q?1nWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da32323-33be-4e7b-82aa-08dc5abe4fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 07:01:01.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9hIG0D9YWD9vIPr/EdhyfANuNrx8BzskCd9J4deAWmqqYldYCeR0EIuMKztCGaCZsqA+ZK0KX5YHlUat0nh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDAvNF0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0KPiANCj4gT24gRnJp
LCBBcHIgMTIsIDIwMjQgYXQgMzoxM+KAr0FNIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3Mu
bnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjk6DQo+ID4g
LSBSZWJhc2VkIHRvIG5leHQtMjAyNDA0MTANCj4gDQo+ID4gLSBCZWNhdXNlICJwaW5jdHJsOiBw
aW5jb25mLWdlbmVyaWM6IGNoZWNrIGVycm9yIHZhbHVlIEVPUE5PVFNVUFAiIHdhcw0KPiA+ICAg
YXBwbGllZCwgc28gcGluY3RybC1zY21pLmMgbm90IGNvbnZlcnQgdG8gZXJyIHJldHVybiB2YWx1
ZSBmb3INCj4gPiAgICdwaW5jdHJsX29wcy0+c2V0dGluZ3NfZ2V0X29uZSgpJy4NCj4gDQo+IEJl
Y2F1c2UgaXQncyB0aGVyZSBpdCBkb2VzIG5vdCBtZWFuIHdlIHdhbnQgaXQgcmlnaHQgbm93LiBJ
IHBpbmdlZCBMaW51cyBhYm91dA0KPiBpdCBhZ2Fpbi4NCg0Kb2ssIGxldCBtZSBpbmNsdWRlIHRo
ZSBkaWZmWzFdLCBpcyB0aGlzIG9rIGZvciB5b3U/DQoNClsxXWh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9EVTBQUjA0TUI5NDE3NTRBNkQ3NTFFODA4NDBGOUE3OTg4ODAxMkBEVTBQUjA0TUI5
NDE3LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
ID4gLSBBZGQgUi1iIGZvciBwYXRjaCBbMSwyLDRdLzQgZnJvbSBEaHJ1dmEgR29sZQ0KPiA+IC0g
TGluayB0byB2ODoNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlDQo+ID4gLmtlcm5lbC5vcmclMkZyJTJGMjAy
NDA0MDUtcGluY3RybC1zY21pLXY4LTAtDQo+IDVmYzhlMzM4NzFiZiU0MG54cC5jb20mZGENCj4g
Pg0KPiB0YT0wNSU3QzAyJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDYzA4YWQ1ZjM3ODQ2NDkxNGIz
MzgwOGRjNWFiNw0KPiBhMmNhJTdDNg0KPiA+DQo+IDg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzODQ4NDk5MTk1NzYxMzA3OA0KPiAlN0NVbmtub3duDQo+ID4gJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYQ0KPiBXd2lMQ0oNCj4gPg0KPiBYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9WSUy
QmpqWTRoTFpIaW03N1NjSUlhZzhDQ1J0T0ZODQo+IGxMNFhJS2FpWA0KPiA+IHRQTGVTbyUzRCZy
ZXNlcnZlZD0wDQo+IA0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hl
dmNoZW5rbw0K

