Return-Path: <linux-kernel+bounces-126494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A7E8938A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF941C21069
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9207B67D;
	Mon,  1 Apr 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIwqLREx"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1068F6E;
	Mon,  1 Apr 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956412; cv=fail; b=EWJoaRUUaqNgNK7b2St16Ql1t2w42JRDvCWgbIVvTlKYo7eWPzv9LQz+9bDzQgUNDR0RE6GbBKm9LuXPOFi39wuTKL1sAa2NKHe2BXdq+0PHNSqbRP5+cb98rPweweWr78GU25+DE56RKhlS0IlgY2S8Cp6hAHbqWHh3U1pzTk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956412; c=relaxed/simple;
	bh=1raNL0GGHxN2nqMDSye8RjemmmCF9QjpXnYqtleE4Zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XR+0q3V+ZipbwSkZ7yHR+abdm+chMdN//kgn/YRuFiPQ/9e1gRz+NTLLFV2fURWHVJI1UjN0qROuq+rYjqtJcDJLWe/CK79+ZJP0QCv5RDvZ2spfefZ6Oh/6TK0zQbh+mn5Avw0RZJi0vU4psbwXwbEh+uua4c+hwCHBM2qUZkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FIwqLREx; arc=fail smtp.client-ip=40.107.8.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCMU1k1+jcygw3CT8DzDmDep0rSyobVQ9UMERX5vzt9PPQrF45KPZnec2fp73Dt+Ae1265XUYnzqq41BGTxkjOo2FD1BDhXLE7V/tKZWpb3diaSRmCDyXardiyJNlU0CHQGxoGtI2P2fm6x/UbC7Hrg3MLaGnZBvywpQaz8WxQsCZsR6ql3IaPLAG++keZiiJMN8cwwlkPUWDJvQB8AsG3Xfqka+J5QBVoBSKXFGJUq6uzexPUe/X7nuSSRDtBVRqS362Ojac2NhneRaCUpWiArgJIlVUGt5AznnAkeh6Mv2W24/tTHXR+krqIpqhl5XO9d3qq3rY1UPVpYhhTzTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1raNL0GGHxN2nqMDSye8RjemmmCF9QjpXnYqtleE4Zo=;
 b=aAoAOcNwPtYUad3yBBmOfhOltYGNTMEsH8n9dIC+OocHaghsqpB3Wx0NKs6LttA1sFqj0xptFW4BU2PeBsMvDEJ+Npa63lkfr5JwlS0ckyZDCp6ccgaReHFFpjMEBVN74XfdmrgHnEMtm+iLjkibR2wtTW9GUFItd/MmZvvAcsL/T9vYn3dsrFbPBN/ImgXCnUHI/9aLoUkuaVLcY01Nj2zuM1kaVrogXvA6wX87hqSdwDsE0eFbBsE+d4SoJX+cQiNa9xqp6oe/g1hGbETkwsy2/z7idtA8ePUiTI1ly48XjkEm2zTs+o5A/njAqvCwi+OegRJT+zqOW/F93Q8kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1raNL0GGHxN2nqMDSye8RjemmmCF9QjpXnYqtleE4Zo=;
 b=FIwqLRExgJVHXIww4+6Batr0NYBsyhlDOmkAkH6Pj7t8+DaWwfIitbSo5C8AM9p48h0WIPwisPHXhfw206KK9+ZE/Frtfu4JU9z0t1Wu1+sxHTSZLesCnCrp7gJt2d14QozLUdEnj/F4XKdekJUR8+ko192mpvf5SkDtILT23eM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8994.eurprd04.prod.outlook.com (2603:10a6:20b:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:26:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 07:26:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] dt-bindings: clock: add i.MX95 clock header
Thread-Topic: [PATCH v5 3/4] dt-bindings: clock: add i.MX95 clock header
Thread-Index: AQHafb8M1T56G0UGOUeRRrQyv48VEbFI2C8AgAo3ktA=
Date: Mon, 1 Apr 2024 07:26:46 +0000
Message-ID:
 <DU0PR04MB9417AD4C2F5644FAE6D5A762883F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <20240324-imx95-blk-ctl-v5-3-7a706174078a@nxp.com>
 <31b493d1-ad74-48c7-8585-9df323418ae3@linaro.org>
In-Reply-To: <31b493d1-ad74-48c7-8585-9df323418ae3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8994:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G4ya88hlGO9YQgm3s9/z5D8sMrkos/bperG+1z+REjobhesUo6hjOvP34onzzlREm7e2E78M7pxLSzHdHAfICLcmam+TXHzq4sPkLmdWrfshFprEmqxdHuX2OS2Ax1DKSTM1zdIzZxQ5fYcfwBOwrbnZEl59+HGMnXaESUJGXIjR/OqM8wxmjw6Oye00rYnGEhfe+SyUCQiofL9/LWyhBqweaZQn1LvakBtz9necdglpSM7fLeEodZzg2NvSMhH97S/8h6vBcGdoNhJq/HHLDltUh5J//qvHAesqCy99ycv+c+mFulLNawAha0X/yxmFOstrrpiDDfm2zcuiH0k4EPwR9rShshhmMTMcIcnkNZBD54jWFEJwXEJoVOLQ0/cB8hH+G6MJ3csmNA5RSVrcZ8aN3ERV84gDGF9M23Eq0J4G81c2mzs5TTa4oGMb2o7ov0oL+6BuPKASoAsZxEz2tcwXyr84yy0kuAkcxm1k/6uCdPFc9hbnjEZ0/tNaqGtobQmRAJ7z53L0g6yrV9dES9jyp3cMbu0Jev0NWsKxRj1Fg2IvODVto9VcOMZ5SvGlFXa/iQjD7JlBlmpwBTENN9ikpGgvfJdTPVA+xhPEPsEdLgMsbhvfjW3sAVe6F9t7S616CFHLf1hWnnqNexgJtQbMbooCqKZ6CHWwHXPZdUSolGhPH1MiTolJOW5sFn5WWf69NVKRWTlmZhiNkEZh2Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0lLQVV2TEZPaVVkSlJuaS92OEM3MDF3dGtIaUs2ZitpL0lZN2pUOU5xM1Qy?=
 =?utf-8?B?RWVxekppSUw2VERBRHBTdktZTU03VWhDQXpkR3VJMEdaRjh3bDR3ZVZQZlV4?=
 =?utf-8?B?dERlZjRTY2Z2ejRwVmVrRGZaeXBodUliUS9NcENsd0pOT3NUSGJvOU5INVFi?=
 =?utf-8?B?NXppc1FRTUFFSFhYQVJTWWIvSXIxMXB1RFZZNkl3cGNJb1B5bEgwbGZrNE1v?=
 =?utf-8?B?SmxMaThJeEc3aFBLNTNNYlZ6WFFWSXBzMXdnTzZPMTRxYlJJaW9kMTdUcmZi?=
 =?utf-8?B?RmkyZWVaaDM0YlJaYWZjeGYrcktiaThUVzJUbzlTRkQyTDNqU1BTRmVYbHB4?=
 =?utf-8?B?TEU1a3g3V0hUY0RmZ2VkZUZjeU5VekI5aGhiR1FiSnJmekZPVFQzTEQveVMr?=
 =?utf-8?B?b2VCWENyWmFpd2c2b0gwZ0hQNFYrUDNtUTJQU3NHQU9Rd3lWSzBCdVNDL2Zq?=
 =?utf-8?B?M2FITjdzczR0ZnM2QmhLMnVVZlBZWjExamp5aUhNY2ZJT004ZklLZ0ZVUldI?=
 =?utf-8?B?b2lpTjFqZmRjZzR0MmEwenE5MUdEWkdVNzg0SnFkSnNrSGNia2czVnNzOXkr?=
 =?utf-8?B?L3FIMDlUQnFlZXpkYlFKOXE5SEc0dHVtK25iR2dxR3cxSGpFUnk0MUVabEV0?=
 =?utf-8?B?YnlVOXZ6WHl1SnBIZWJvUjlobTJEdS9wZGI0a0hwQ2JxelpUZjc0Z0NzUlBD?=
 =?utf-8?B?aGdMY0ZuSzVHZ0gzc1p5Y1p1WUJ0aDFQWUFFT0Z5NENIYllSWUdkSjhqTjF6?=
 =?utf-8?B?bmNNQW9oTit2UTJHSXNsSlp4d2FZamJvSHMrK29oQWFmNy8vWm5OcEVva1hu?=
 =?utf-8?B?SW5DSXJWVDRiTTJkWTFlaVhaVWE3b3Y2S1Z5SVJiM0dIcFRYQVFYM3ZtdE1D?=
 =?utf-8?B?WEF2UnJoNHdjZjk4Q3BuYWgrNXZWaWRLY3pQMWY0SkJnVXdrUUt1YTBISkw3?=
 =?utf-8?B?Y3lHcDJOOVBBV0hVT0JhSCt1NjErMzJ1MUtrS3JZTmNOV0hRQVp2Z3lvS093?=
 =?utf-8?B?c2pQT3U3dVE2bG9RVVhXMDltWlREM3IxcUloYjg0Rm9MTXVod1RqNS8rejRa?=
 =?utf-8?B?S09kbmY0N2tlODZuMmdDanIxaEEyN3hpTnZmSU9nSEZKU1MwZVhlK1JJcGRw?=
 =?utf-8?B?c2Q5MEFWV3h3NXB1SW0zTzNxQ2Z2SktnK0tzSys5aTU4SWZQblJjL3NvVlRI?=
 =?utf-8?B?am9DMkZpcWUxZTJYQUtpZTRkZHBlck8zek1HRURuYzYydXFmaWN4VVFyczk4?=
 =?utf-8?B?ejV5ZDYzUk95REUyZ0o0VHVUVU9WamJiRlJDWVFwb0NKaVB0WlVKUmJqRkxx?=
 =?utf-8?B?NUFZWm1vWUFRNXIvdWZxVlIwY0JWb1lucEU1bWxtUkZuS0ZyUEFrYWtoSnZx?=
 =?utf-8?B?dkhPcUF1SDJSUVNOY3d2UkwxL0NITi80azFYOWdlSDBZZXpyTFEza2kvN1kx?=
 =?utf-8?B?THBqRzAxZmhLaDBGRHRFeHdCb05mcW1CcG9ZNlpvNXF2MWRSbWZTR3RtMnIz?=
 =?utf-8?B?bU5nVGU2TnZtRnNhOHNOUy9LaEZKMnhuOStUc3FqRFpTSkVwTjdLQTIwTU84?=
 =?utf-8?B?dFZoVklqbU54NUtQV2F4eDhHdElrcjNLYUpxVGVQcXBFd0V5QWV2L3AvdXZK?=
 =?utf-8?B?dnVQczlndWVha0Z1QVVxTmY1em15TDhwYS8vTm1COXpzU0hjQTlvdzhhOGZt?=
 =?utf-8?B?eHZhRWF5RUE4ZWhpYjVEc1dXNkF1cTV6ZEptZ2laU1lPbEEzcGN4RlBtSStH?=
 =?utf-8?B?TkF5NE9GYkxDWEpRdWdnMUZzeHhGcStPM0ZUR3p2YU01RU9XQ3Z0bUw3L0Y0?=
 =?utf-8?B?TlIxZDVPdVpTVThSazl0K1pDVVZZTi9URHlnSGZrM0hUaHQ5M0pwZXJoOFNy?=
 =?utf-8?B?Wnppd01XVnRYY2FaU2RMU0tVdG9nRS9XdjVBYTViYy9HWXBOeGpibXRUTm1k?=
 =?utf-8?B?UU9MZlpHaHI5Q2lEeEpLZWhXcDJSaGh3MWNLb0RIM3R5WmV0c09IVlhaUmtT?=
 =?utf-8?B?ZHBmNHZvSHJ4NG1wQVpzVlVzQ3cxQjJnd2tnWmxaZC9CN09mQVBncllRN2J1?=
 =?utf-8?B?c3JzdU9Na0tHVU5jZWxyWFBtZDBWNGlzNlVTd1V3UTcwMUhZbXFVY1VSMFhG?=
 =?utf-8?Q?E0Ps=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3ebcc8-8bc5-4421-2875-08dc521d16a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 07:26:46.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5iijJbSAA/oFwwyCPxAj06lpR7hHl0pxaqyN6EsHJ+NB1Ev7RriYfxrTNHvY69Eflr55F8GP99m8xIzxzCJww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8994

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBhZGQgaS5N
WDk1IGNsb2NrIGhlYWRlcg0KPiANCj4gT24gMjQvMDMvMjAyNCAwODo1MiwgUGVuZyBGYW4gKE9T
Uykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4g
PiBBZGQgY2xvY2sgaGVhZGVyIGZvciBpLk1YOTUgQkxLIENUTCBtb2R1bGVzDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9ueHAsaW14OTUtY2xvY2suaCB8IDMyDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9u
eHAsaW14OTUtY2xvY2suaCBiL2luY2x1ZGUvZHQtDQo+IGJpbmRpbmdzL2Nsb2NrL254cCxpbXg5
NS1jbG9jay5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjgzZmEzZmZlNzhhOA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL254cCxpbXg5NS1jbG9jay5oDQo+ID4gQEAgLTAsMCArMSwzMiBAQA0K
PiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9SIE1JVCAqLw0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNCBOWFANCj4gPiArICovDQo+ID4gKw0KPiA+
ICsjaWZuZGVmIF9fRFRfQklORElOR1NfQ0xPQ0tfSU1YOTVfSA0KPiA+ICsjZGVmaW5lIF9fRFRf
QklORElOR1NfQ0xPQ0tfSU1YOTVfSA0KPiA+ICsNCj4gPiArI2RlZmluZSBJTVg5NV9DTEtfVlBV
QkxLX1dBVkUJCQkwDQo+ID4gKyNkZWZpbmUgSU1YOTVfQ0xLX1ZQVUJMS19KUEVHX0VOQwkJMQ0K
PiA+ICsjZGVmaW5lIElNWDk1X0NMS19WUFVCTEtfSlBFR19ERUMJCTINCj4gPiArI2RlZmluZSBJ
TVg5NV9DTEtfVlBVQkxLX0VORAkJCTMNCj4gDQo+IE5vIGltcHJvdmVtZW50cywgc28gYWdhaW46
IGRyb3AgY291bnRpbmcuDQoNCkNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGRldGFpbHMgb24g
d2hhdCB5b3UgdGhpbmsgbmVlZHMNCnRvIGJlIGFkZHJlc3NlZCBoZXJlPyBJIG1heSBvdmVybG9v
ayB5b3VyIGNvbW1lbnRzIGJlZm9yZSwNCmJ1dCBJIHNlYXJjaCB2MS12NCwgbm90IGZpbmQgY29t
bWVudHMgb24gdGhlIGhlYWRlcnMsDQpleGNlcHQgdGhlIG9uZSBmaWxlIG5hbWUgYWxpZ24gd2l0
aCBiaW5kaW5nIGlmIDE6MSBtYXRjaC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gU2FtZSBp
biBvdGhlciBwbGFjZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

