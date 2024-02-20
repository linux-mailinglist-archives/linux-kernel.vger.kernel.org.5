Return-Path: <linux-kernel+bounces-72354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F385B25D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2871F224D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862458217;
	Tue, 20 Feb 2024 05:39:09 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2389288CF;
	Tue, 20 Feb 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407548; cv=fail; b=j5Z6EV/Ebxb9/PRgVMj8iCZaCZzIExO2ZppO+JbhbKqCmSJSyHdx6TTK8EVEX9tdRIxohGWdMrBZXzZUyW1q43FnKTfY85ILxNh0gD/5C0iFQWPzPVC9nkNBJxoiFpue13mtP7op/K+L1pYVWe6X4ooFFCEnoGK3Msrx6IOw9sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407548; c=relaxed/simple;
	bh=vPVt+6N4qL9HCX/4iP0qojrAZa7/YgiYjfgWGOJLX1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SDOtctT/oiciEAeW3X3RAqKFu78NLJRlol5zz4KxbGFSHhQRVU6BXLcZh+tO/MWEfEG5PlpUgep8I5aLZSYPI+xbAZXsQIH0IKlvCLXSdtS4pW4a5TACbUYcZR2T1VpuNlHDZBXiDvcyzvXapRqUll42JFsTFZPpwOubNg231fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUyAOrqw955xZ2IBbuVMVIxRTm1LIxDQGKP5pztVtuLaBiv4UyqiGJ5uIcbxc3ezCYKQAtk9O4bdcLGr2G2j1AE1jltDtqolHi06eweWmq6x+8eZ1CIjgIXJHglkj/J5QutXmSDkeNgTgRr0kP/4lN184Sc6RZ7JPfNuqkr/uRnGhb9W+CJlGNO+Onxg5qDsC0dUGx+8yredqmKYKebQ+Gb7kIIjLfo103y9Tmt83ayoXFABjIg7aaUE9B+kGlkK2SfJTLSp0PoyXn0QrguuB/njzB3zQafSu4jzhcnmQKynDltoFT0/ul65JP/4rp7UcoFpmzK8bLVLF/FhYHMQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPVt+6N4qL9HCX/4iP0qojrAZa7/YgiYjfgWGOJLX1g=;
 b=aBeDrcbSyYbf+EX0s+zB3XHJu/38n8ch0gwDQmsIphfga3n4GUJXUF12ADsxwmtdgb41+4nq2gJUEiAlMSJKHoYh5yqCaQFUZuFCmEQ+9xm8Ktgyo5comUCU1XNHszDsMqSFPDjp12gAKEZk8hXZ37uKJckcgi7ndmYB4JAZRqD4acAbUt6lyoyccPlBP8POzsdK/gmO+TQrgyJfszfu8QO5+ErvMRQZy+pXyzQTmLWEBoY2zUqnTFv4DOlkwViHmTW4zr2hl5pT8baAFnIjwyGz3H0ijz6gMQASxgYABf14jym/18dpGaxVmH5w6QQTScnRyihQJiLk/6OpQTMi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1064.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Tue, 20 Feb
 2024 05:38:52 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 05:38:52 +0000
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
Subject: RE: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
Thread-Topic: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
Thread-Index: AQHaM+jMLz7GJ6Ui60+OoD/LjAWT9LC1Ex6AgF4CGNA=
Date: Tue, 20 Feb 2024 05:38:51 +0000
Message-ID:
 <ZQ0PR01MB1302D57C95A3C2A564B3C529F650A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <CACRpkdZEu5AcdPtaH7MQSC88+CT-PhgegEVcWk6KAzAipzasPw@mail.gmail.com>
In-Reply-To:
 <CACRpkdZEu5AcdPtaH7MQSC88+CT-PhgegEVcWk6KAzAipzasPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1064:EE_
x-ms-office365-filtering-correlation-id: da77f901-5d3a-4736-598f-08dc31d63876
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 D4ihqyjrSsyietMCXzdlSApgbnb8eZMkWUgjSuyDTFlXPYBWb+PbDyPHymls/+S3Tao+1tICn8hckJU2pCQSqznw346SEQL+8XcoobLQiG5wqSSExTWw0bN0T5WIgaMbOoIarSIUo8M3ofCzodG0JZmgAH3R1bWp/357zwU7W05yKQT2b4p9UeGQGcC4vwFWcg6DTnNwDynL6u3HM7rfYBf1KL1uSc/YXbpShXOF9y8K8k2VyaRBkLXQ0c9sVS6ekNYDuZxwWB/AmPjPQ0aUjB6vjgZ/yX4TSzTwo1lCycBQRb/U2BiRYm88Y6qA9uGlwUiRRZ+ovB23Ke91z/0ZsGIFFQypjhScmVlG2Dn7NMjfNzkhqx3S/d1Ea+q7Fs1ccw6SqSv0s9VkPRCAKHNRRJUM7KHCIIt6pFH+Ra44ultyui/6aV6AIsvKLU14QU2gPBBoOeQtgshE6v6jpXM3oz+VnZvCmCPxLNodrl6IwJO58hIF4O6j4lGda4FtyeM4IuxVEIaSlFxV8izkJh24n/B5AHvwUh/AdDdK1HUk7wnE3qzaF13F6aq2mSvuD2G2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnAzRWlHRjFIUHlnQ29UenFNcm5sSjBJZnNlaDZsMjczTVF3M0R1ditMQXQr?=
 =?utf-8?B?MlhzRk9BZVE3V0p5dmtDTzkxM0NYOEdkN241SEFsaEEzOHgwQTYrb21Wa0JE?=
 =?utf-8?B?N1lXQlBaWldOaG0xcWR5Zk9sYXFQdkNuNUswT1VMdGdZR1hhbEI2dTlaZ2tn?=
 =?utf-8?B?bktLOE9tSG5BRUVjbWo3TjB4cHBkTUJoMnFQUVJXMGh4SWRKNmJqd2YwaDBy?=
 =?utf-8?B?WnozaWlaUVZzanRIMEtHbFhSVjlUYjczVTYxRFBPZmJ3OS9LTS9pWUF4cTBv?=
 =?utf-8?B?a0tDL3ZwekVpZGxscWRZUGJDZTViTSswWkRaWExvdEp6ZW1BVFN3UExVRm9v?=
 =?utf-8?B?NlhXeEtuRElDN1VoMW5kSnN5L3lWWm9mQkhWQStjdXIrZDdSRUduV2pWdDc4?=
 =?utf-8?B?RkVhVUthVVQ3V0RwVmNDS3NTcHpaeHpKbXdjaWRDaWZIaHJWWUtFOVVKUUor?=
 =?utf-8?B?b2NlMHYvS1Q1MCtHb0dYeUR2RE9xSzBXV3c3M1B6NjRVNk9NTENaN0o4WFpZ?=
 =?utf-8?B?QVBHZWFzQmFqdFpOLzVBWTJ5blB0Z1ZjdmJweFBmNGNucFJGd0d4eDBsdk9P?=
 =?utf-8?B?RmFBemtEbTVjbnpvRit3c0ZTamk1RThKM3JmQ3JBbjFoZlAxM0gxNmRQMkhn?=
 =?utf-8?B?cGNzNVJpdG85RGpnbFAveGo2azNsdC80elFObEU1OHFGQm9jMS9lVFQ1NHBE?=
 =?utf-8?B?N3NHNEswbXBsVTQ2ZVhMRHNUeEIzQjI2QVMxTUxYTk8ybjNCRjlvWXlvNVA0?=
 =?utf-8?B?THlxNXp2SnpZWVlDOXBCZnlxQ3ZpekhoQVNqbjFIeEoyRFNWbHBMZHpLanRa?=
 =?utf-8?B?RmNqV2FlRFZSdE5WbVp1MFl1d3JxTFIvUG1KN3EySndxdzM3WWNjMzFYaWNI?=
 =?utf-8?B?RHk0bVV1Y0tFaCt2SDJvenJtNW5hTXdkNXZhMUlVMDJWemlnZjFwa1UyNldO?=
 =?utf-8?B?SHUzNy9JU0tiR0ZFM2dHSG1IS2xtbk1KbU1OQjYzRFhxRFBibGViejBlTEVk?=
 =?utf-8?B?MHY1Qm1LWHRFRWpjR25zZzU2d0VQTWhIeUVNMTNzdENkSkgzeks0VWtvTG55?=
 =?utf-8?B?aHNlc3A5K05vMm1ERnJOenQvWnNPME5rOXBFTElCTS9Dc054dU1BZjA4R1I1?=
 =?utf-8?B?bnVzQXV0aXRiL1Y2QnprUWVQNGU5NjhtTDY1VGZPSG40TG9zQ3ZRZTBzbmJD?=
 =?utf-8?B?Q2pqbGw4ckt3Zjc1R2lubElFOFoyemtGeldkWmtHQlB4SkRQV2NNdGVLbTE3?=
 =?utf-8?B?NnYzbGxFdHFBTjJkWUxrOUdmVkt2cng0SlFGellzOHRNWmdmWkVEcmt3VkRE?=
 =?utf-8?B?SStHdW1VdHBrb29LeGJCd0ozUVU2RzlNQmRnMkJZT3MzOGN4bVdCU0JGVC9B?=
 =?utf-8?B?dUhvS1J1ZFlhTTlaaVFVRUNQRnM0N3VFdDRsaVNYN1dyT2JTWnp3c2VZOW5H?=
 =?utf-8?B?MTB0SkdRaVpaSVZsWVNiSFdoYnB3U0E4T3VJeTA2R21CQ3FRdEFnc3JuQU5a?=
 =?utf-8?B?cUhpUmtrN0o5K1VjZlI2SGJzZEwvR29HN0UrRzlpMnVRd0hXZEZvV1k0eGM5?=
 =?utf-8?B?aWxEeHBhVXVDWGFhWE8xdlMxbVl3NjM4YWNmWCtUQXhVbmZ1OWZjbzN5Tjdw?=
 =?utf-8?B?WjhzYnBMRVByVzBJMU80NTd1ckhmMmxhemJxenNRQm9icjZsZ1dMWktUVjRW?=
 =?utf-8?B?akxzZERLbXplYUFUWUR2aGZnS3lwTTNVa2dQcHo0TWRBY3FLdTU3NW5qODRM?=
 =?utf-8?B?WDUzSUZUM1pPamZBMFBjVmIrY0ZyWEhPQngzSVA2MUN1c0EvMkdOOVAzNmRU?=
 =?utf-8?B?Y25CTHNnQ3VRTHNNL1NhWEpSN24yRkZUZjQ0TEpNMXdaYUNQc0tBeTBZSVh5?=
 =?utf-8?B?L1A4SG5sODhoTXVxRS9PVEtBY2FLdXZ2TGVqTy9lNTZ2LzJ3eVBtdmRtdHdJ?=
 =?utf-8?B?ajFwY0dHWDMzRjdFVHYwUnM5R0s4RHVUVnd5NWlYNFNCUmh6WGd1WUJrMXlm?=
 =?utf-8?B?STJCQTh1Y1hHanV1ODV4bkY3TnoxTkcveG9xa2t4WHF6UHVUa0QwNUtSZmds?=
 =?utf-8?B?cGUyaEd4NUZHTWZUZHpvQ0VCSmJSS2l3cEFJcXdqdlZCZGthQmUrbUMrYjZw?=
 =?utf-8?B?REZpTnNLWCtwa04zR2x4ZWxiempwTi9CZnhEYW02bGRTd3hWZzNqRzhQa2Jw?=
 =?utf-8?B?elBkZEZlYjFud1BjdGJ2TEQxK2lLS2lJaGZoVHJqM2ZFcm9aVDl5RnBwbU8r?=
 =?utf-8?B?WXFuQ0dtT0xTU0dXN0dFTkhTWjh3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da77f901-5d3a-4736-598f-08dc31d63876
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 05:38:51.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgOApM/l2IngKMRIbTxmVdJJIQUupOJgXleMR2DF/FSwgn1sYc/SIIwQ2YphTSCPMnh5jUtwnmp6M/G1OTGk/D6zNt4w4lf/YyQiC8fjofg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1064

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMjMs
IDIwMjMgMTo1OSBBTQ0KPiBUbzogWXVrbGluIFNvbyA8eXVrbGluLnNvb0BzdGFyZml2ZXRlY2gu
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
c2lmaXZlLmNvbT47DQo+IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJl
cnQgT3UNCj4gPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggMC82XSBBZGQgUGluY3RybCBkcml2ZXIgZm9yIFN0YXJmaXZlIEpIODEwMCBTb0MNCj4gDQo+
IEhpIEFsZXgsDQo+IA0KPiB0aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBPbiBUaHUsIERl
YyAyMSwgMjAyMyBhdCA5OjM24oCvQU0gQWxleCBTb28gPHl1a2xpbi5zb29Ac3RhcmZpdmV0ZWNo
LmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+ICAgcGluY3RybDogc3RhcmZpdmU6IGpoODEwMDogYWRk
IHBpbmN0cmwgZHJpdmVyIGZvciBzeXNfZWFzdCBkb21haW4NCj4gPiAgIHBpbmN0cmw6IHN0YXJm
aXZlOiBqaDgxMDA6IGFkZCBwaW5jdHJsIGRyaXZlciBmb3Igc3lzX3dlc3QgZG9tYWluDQo+ID4g
ICBwaW5jdHJsOiBzdGFyZml2ZTogamg4MTAwOiBhZGQgcGluY3RybCBkcml2ZXIgZm9yIHN5c19n
bWFjIGRvbWFpbg0KPiA+ICAgcGluY3RybDogc3RhcmZpdmU6IGpoODEwMDogYWRkIHBpbmN0cmwg
ZHJpdmVyIGZvciBBT04gZG9tYWluDQo+IA0KPiBUbyBteSBleWUgaXQgbG9va3MgbGlrZSBhIGxv
dCBvZiBjb2RlIGlzIGR1cGxpY2F0ZWQgYmV0d2VlbiB0aGUgZm91ciBzdWJkcml2ZXJzLg0KPiAN
Cj4gVGhlIHBhdHRlcm4gZnJvbSBvdGhlciBwaW4gY29udHJvbGxlcnMgaXMgdG8gY3JlYXRlIGEg
ZmlsZSB3aXRoIGFsbCB0aGUgY29tbW9uDQo+IGNvZGUgYW5kIHRoZW4gc3ViZHJpdmVycyBmb3Ig
ZWFjaCBzdWItcGluY29udHJvbGxlciB0aGF0IGhhdmUgdGhlaXIgb3duDQo+IHByb2JlIGJ1dCBj
YWxscyBpbnRvIHRoZSBsaWJyYXJ5Lg0KPiANCj4gQy5mLg0KPiBkcml2ZXJzL3BpbmN0cmwvcWNv
bS9waW5jdHJsLWFwcTgwNjQuYzoNCj4gDQo+IHN0YXRpYyBpbnQgYXBxODA2NF9waW5jdHJsX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gICAgICAgICByZXR1cm4gbXNt
X3BpbmN0cmxfcHJvYmUocGRldiwgJmFwcTgwNjRfcGluY3RybCk7IH0NCj4gDQo+IEFuZCB0aGF0
IGZ1bmN0aW9uIGlzIGluIGRyaXZlcnMvcGluY3RybC9xY29tL3BpbmN0cmwtbXNtLmMNCj4gYW5k
IHlvdSBmaW5kIGdyZWF0IGluc3BpcmF0aW9uIGluIHRoZSBxY29tIEtjb25maWcgYW5kIE1ha2Vm
aWxlIGFuZA0KPiBkcml2ZXJzL3BpbmN0cmwvcWNvbS9waW5jdHJsLW1zbS5oDQo+IHRoYXQgeW91
IGNhbiBjb3B5cGFzdGUgdG8gcHVsbCB0aGlzIG9mZi4NCj4gDQo+IE1heWJlIHlvdSBzaG91bGQg
c3RhcnQgd2l0aCBhIHBhdGNoIHRoYXQgZXh0cmFjdCB0aGUgY29tbW9uIHN0dWZmIGZyb20gdGhl
DQo+IGV4aXN0aW5nIGpoNzEwMC9qaDcxMTAgZHJpdmVycyBhbmQgdGhlbiByZXVzZSB0aGF0IGZv
ciBqaDgxMDA/DQoNClRoZSBkdXBsaWNhdGVkIGNvZGVzIGluIHRoZSBzdWJkcml2ZXJzIGhhdmUg
YmVlbiBtb3ZlZCB0byB0aGUgbWFpbiBkcml2ZXIuDQpUaGUgc3ViZHJpdmVycyB3aWxsIGNhbGwg
dGhvc2UgZnVuY3Rpb25zIGZyb20gdGhlIG1haW4gZHJpdmVyLg0KVGhlIHRlc3QgcmVzdWx0cyBh
cmUgc3VjY2Vzc2Z1bCBhbmQgd2lsbCBzdWJtaXQgaW4gdGhlIG5leHQgdmVyc2lvbiBmb3IgcmV2
aWV3Lg0KDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

