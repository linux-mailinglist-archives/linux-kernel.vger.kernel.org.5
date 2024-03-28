Return-Path: <linux-kernel+bounces-122520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8488F902
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DEE288125
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB8854663;
	Thu, 28 Mar 2024 07:43:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C53805;
	Thu, 28 Mar 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611783; cv=fail; b=Soh+5qI0rInTXi+szIpmLIXNUDNEjRxUr4XA82IuRDMKXazX2rBEHbPndV7qwClpKlfM/gEhv+CyJLQ+/y1Y82GH3/q1GsJKLWo1JtsuDsUBtH26XgeC6Jpks2PmnvUMrhQOjKeVKN6TZKL9KYPh8fzUT35OSY3jYAPVv7YYCOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611783; c=relaxed/simple;
	bh=xdj/pzZtu70tO/Z2iv8jCQ2zDljbfH0KCkpILt/9UZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N9JNGJDOMuBPlS9O3MGGdXT2Gr5UPN6cgco08hWjbd4Bi5WisnCuUmj7xVX5X9vyrd0H/FP+mY/48PAtC7C+sAeFW8ABhadkfL8tvXOZRnbmPIK0NhyGSm7qAP0f5kgNKmfXGYygZHVw/5d5/hp1PGUIcKtHR/OzCP9l6SyLOgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW9Ixru7sVm/IlXNQQ7JxITPX1rXXnIEaBWvf8K3dBuVPQIMuOr9czMlUXxaMJUFUwOxI14a5ASmUGRMw8eEeBtzg7/49rAZEqqXGMWDE5hv1VIlmKRjQSQCYXnIxUzl48s5809kN6HOTd9DOvoGoFxwSCQNsxzTAJVaR1BlvpdWJzBkp/NRS3IFXdTwblPDtp16ujIiNNKELx9SijjnCTyd8FIuGQOVyfT65KcMQvf3UQ5l1LHJnf0KPtiRJF/cActLAcYFu2tv84+HgPiz2KJzznv7MRVfXIT6ZQaq5zGt/AJ8uZVTV9T9ll/CqFMyd07du+YshQrv1tzlk/SAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdj/pzZtu70tO/Z2iv8jCQ2zDljbfH0KCkpILt/9UZY=;
 b=Aa2H6lEx+AXoEHSKlPihp2rurzeuXgS3lHBD8QhPtZZ47h6CgvzaSh3xNim1sF5fwz4VqzGpf9h/pb4V1RE8xXNDUq41C2T2yOXLc4xWhWcf0DyFljr2OxEFYq4dfUGOXal0IIfvGHP7Pv9dqP/aIIqa8m2+5u03gqIw4n7QLgEtGtK2+WmkcAsISVA0Sh3eZHcFTD8al6L8kKDahflg2vZpu8yOLy7jMXvUl+2qFjIv4rtMFMRD4vbTt4YdcDdMv1KJAcGyfWCmlBMzBLoReruz6El+1Ql3K4LltXNCSrfzO85/1pQCb3EdBB8VAfnAnLiKl5exfgzNgqeakoSFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1049.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Thu, 28 Mar
 2024 07:27:05 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::199a:2ff6:e892:d78b]) by
 NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn ([fe80::199a:2ff6:e892:d78b%5])
 with mapi id 15.20.7409.010; Thu, 28 Mar 2024 07:27:05 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker Chen
	<walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHY5IDAvM10gQWRkIHRpbWVyIGRyaXZlciBmb3IgU3Rh?=
 =?gb2312?Q?rFive_JH7110_RISC-V_SoC?=
Thread-Topic: [PATCH v9 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Thread-Index: AQHaeOFVWs9vQrp62USTWSA+i58p8LFMz5wQ
Date: Thu, 28 Mar 2024 07:27:05 +0000
Message-ID:
 <NTZPR01MB0986A4F77EF371F7CBEE3A51E13BA@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
References: <20240318030649.10413-1-ziv.xu@starfivetech.com>
In-Reply-To: <20240318030649.10413-1-ziv.xu@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0986:EE_|NTZPR01MB1049:EE_
x-ms-office365-filtering-correlation-id: 2e9660b2-8c25-4f36-3932-08dc4ef877f0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tyq5C4PcmfWGylseA/mbM/E9E066bviC710KowwXNisnRV77/zTJ3Si2VAyiFvkVxTAYUqzjnh6k4ACJLBHj2glT7IQ29C0Op5SLagMWDSJvft0YrgjbMsGTzDHVx52ofDv8IXI5Y1dB8lVZYj7+02VUnm/RPW09up/wsJb57cgEFlA0/8f0bwLF/wWz8DBXDK8lRGw99TlYtyyYukjQtxGrat0StooWlne4kuUOUUl/sKtZSk4nlwm1PcRCwzkCkOHiFlNzA7L0RnM2BEj8GjSklHTu6FLZZAeDb+kWsY69hwtXxagHWw4uDYnn0TuDrPd72i9xfrL7i3kWf/Nb4svKgp5E2FQm32XSJc6f8Tq3/cdYM8Gs7ETWtdiue4eG2RWD4r736jvJ/yHNTlQ2bFlfMILJmD7jXWrj87qDQgDviVkRCDu8Q+V9eqfKOsvW8msRb4XTiPpkAZ4kgmtUbFowgXD05O6d3LNa62XM5R0teidXonF1MJ9MGHl4CJyQurlMQ8+1g6mBiPfumzVso2fWimvQAwt6aihxH9um+ioE99WY6EJkNDazuo3SgJMeTppaNMoqlRxhH1W2dR3vDxyNUUX/ahykguwGKJshp3tj+38DJRuEFpbUnumVEyrK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Zmt3NkJkY3UvSWdCYnlYNGhhZ01DYWZrR0xMNlN2L05lS3FkZnI3OExHekhw?=
 =?gb2312?B?K3V2aklNT09kQldWM2JHY2JHYVdWVU5tR3hVSy8wWVRrMzhaK1I2T3Z2OWpn?=
 =?gb2312?B?V0p6ZDIwVUdJZXhKQUxnVXlBU2FqNDFQeGNLZ1ZGVDEzVmF6R1JzUityVmEw?=
 =?gb2312?B?WjcyYjZKc2MxaTl0U295dlU1MlQ1R2dDWFZXMlZkN0twbjRXZjZFNmYyb0tQ?=
 =?gb2312?B?dGZVS2JoU09DQk56UVBrV21NQzNjMytGbUFNRjJtejh5ZmtWcGhzOHlMZS9l?=
 =?gb2312?B?dkJZcWdCMllEYTBJTmFseGRKRXVqeEhpb2twQmlPVDg0MXRldGlhOW9iVXZB?=
 =?gb2312?B?QlgwVEJaOEtwMy9CdUw1ZXlsQ0sybDA0OURMK0pHaUU5Vmo3WVkxejhFeXpr?=
 =?gb2312?B?Q3BPTjFhcXE5K1dCeGppaDhYYStVMXUzWlQzNThKNWY1eWZTeGRDL1lncm5N?=
 =?gb2312?B?Q0R6Y0hXYUtoTWZ1ZUZlVUtvK05nUUZWa2NrUFUyYVc2ZXg1OTJVbmdwMDVO?=
 =?gb2312?B?Qy9NbytNUGtoSUxsbFRaSSt3NlkxbC8rUSt4aGNIOUtJanNHU3V5K2YwZ1Br?=
 =?gb2312?B?U2JvNGhxU3VEZDVRZnF6Y01RUjhQOXFnUjNHdHl4bTVuU2VYOFQrNk05cmV2?=
 =?gb2312?B?QVJ2ckxNa1Z0em9DbG1WSnh3QkJKVEhnT0g1VUFWTlNIY2ZTam9wNEh6eEQy?=
 =?gb2312?B?OWZIZnBPNll0RmNPSytsQnZMelRhTFk4TWdsaWtWWjIreVJBc25YM2h4ekRx?=
 =?gb2312?B?NS9UYzc0QWNpdUNZN01jN2xGYWNJSGlIaStxNHpzMTZxcTVoOUswbElTV1Zz?=
 =?gb2312?B?bW9GOXhpdkppb2hvcWJldjNrVUVnMS8zL2dZWkVQUU93VWVINE9CRU5jejdS?=
 =?gb2312?B?VjdyV1FTWWp3blJYZ3ptODJFTXJHa2htUTR0SGxTbzdDdjBaZHdaUlNCOVNQ?=
 =?gb2312?B?MUI4WU5xVjJHNEkxblJqbktGYVc1aVdiWEpPMVo2VHNLV2tUZnc5eVZGeHdu?=
 =?gb2312?B?TEF5ZUxCc003bjNUUmR4aktuU0NpVVc0dnowU0hpcGRGRGJuM0ZSTHVoYW1C?=
 =?gb2312?B?VUhrRmlaaXJIYWpmaHVJcXdhS2FndXhKU1BYek9PcXNQMlNxZ1NqQ1FzdEhp?=
 =?gb2312?B?T0dQZjQ1eTNLaFJhSWhjdGFMRTNnWm1iQkRqTXdoZHZwTURsaXBsb2pCcUM3?=
 =?gb2312?B?dGZBbHlnS2w4MjgvaHVnUTZUOUdId21BTkplWGo5OFZsTFNkMEZNdDlPTHlq?=
 =?gb2312?B?UFp4R08vSjFZTUhmcVpSSmE4dlVXYkU4OEFMNXE3VTRwZTFaeFhBUW5uMDBp?=
 =?gb2312?B?TnlSVTBWcGpiTW82dFB4OVkyZFZGWS9FZlMwY2lGTndiRFA0cmozTXhiQ2Fh?=
 =?gb2312?B?SGRjaGtXTkE4d1NkQnQ1eHZVak1WdUE4MXpQRHJlSmYrZGx5aWhtclJQV01h?=
 =?gb2312?B?RnErZFFRTW5QL2pJd2lpQjJrdmJBSUlIVUNpbXBBVXpHdEhCNkRDYUU5UlhL?=
 =?gb2312?B?dnlvNDhLQnMwN0VRRW52THV6bHdZZzYyeStUb0tZQk5oMEp0RUQ3SVBadzhB?=
 =?gb2312?B?R1lZNWtTTWE1c0pqUnhKbWdPbmU0WmZiOFZ0aXpLUTM2bnZTTFYvQXQ3Ry9a?=
 =?gb2312?B?MlR6U2RUZEFQUzR0ZzRGRkFJeVF0dE5VbFVBNGdCeGpFc0J0anh4UEpRR2Rn?=
 =?gb2312?B?SHo3WTRuSXVUSXgvRldBbWVSM09sQ1JMMnZiTGlyZVFoYzhBZmlWaDJwWFFw?=
 =?gb2312?B?QWxmcG9vVi9hc1gvZGpYV2dnWTFhNkVoZ3B3WHJ6dVIvYUwxSlpwbDJRSmhQ?=
 =?gb2312?B?b2xKckkwdU4vNU41bmYwOG9pVThMdU92RzNPRCt6dkZlNFFIOXZDR2puNVFn?=
 =?gb2312?B?YjRKUCtFODlGVmgyNnRhRm5SbXJML3lCTG83dXJYeWZMWjZyaGdFSVNwOG5s?=
 =?gb2312?B?bWp5aEI1a1VjR0I3MjJGbHZjSjh3RFZreHRxdFNkWGFwOWFxUDMrM2pDbG1p?=
 =?gb2312?B?QUpGbUsxLzZ5TnBBYnBDd25RQ1VQRDlCZE5mNVRMcEt5MVo2dTFka2xDY1pJ?=
 =?gb2312?B?UERTYkltT1hKOU5QR0o1Y09jM0dCT04wNzJWV1Y5QlkxbTlyMi9WUVBoc29D?=
 =?gb2312?Q?Ljq9luB7Y8RMMyEtJcuTlMmMh?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9660b2-8c25-4f36-3932-08dc4ef877f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:27:05.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAlrzW3hqetvUYt3veVQ6BJEdCCgOvVhbNOZSafUmaYNFoG0r/h2uzg5PSfEx7j2jv0fombJXcmEkMjq8P76jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1049

PiBUaGlzIHBhdGNoIHNlcmlzZXMgYXJlIHRvIGFkZCB0aW1lciBkcml2ZXIgZm9yIHRoZSBTdGFy
Rml2ZSBKSDcxMTAgUklTQy1WIFNvQy4NCj4gVGhlIGZpcnN0IHBhdGNoIGFkZHMgZG9jdW1lbnRh
dGlvbiB0byBkZXNjcmliZSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4gVGhlDQo+IHN1YnNlcXVlbnQg
cGF0Y2ggYWRkcyB0aW1lciBkcml2ZXIgYW5kIHN1cHBvcnQNCj4gSkg3MTEwIFNvQy4gVGhlIGxh
c3QgcGF0Y2ggYWRkcyBkZXZpY2Ugbm9kZSBhYm91dCB0aW1lciBpbiBKSDcxMTAgZHRzLg0KPiAN
Cj4gVGhpcyB0aW1lciBoYXMgZm91ciBmcmVlLXJ1bm5pbmcgMzIgYml0IGNvdW50ZXJzIGFuZCBy
dW5zIGluIDI0TUh6IGNsb2NrIG9uDQo+IFN0YXJGaXZlIEpINzExMCBTb0MuIEFuZCBlYWNoIGNo
YW5uZWwoY291bnRlcikgdHJpZ2dlcnMgYW4gaW50ZXJydXB0IHdoZW4NCj4gdGltZW91dC4gVGhl
eSBzdXBwb3J0IG9uZS1zaG90IG1vZGUgYW5kIGNvbnRpbnVvdXMtcnVuIG1vZGUuDQo+IA0KPiBU
aGlzIHRpbWVyIGlzIHVzZWQgYXMgZ2xvYmFsIHRpbWVyIGFuZCByZWdpc3RlciBjbG9ja2V2ZW50
IGZvciBlYWNoIENQVSBjb3JlDQo+IGFmdGVyIHJpc2N2LXRpbWVyIHJlZ2lzdHJhdGlvbiBvbiB0
aGUgU3RhckZpdmUgSkg3MTEwIFNvQy4NCj4gDQo+IENoYW5nZXMgc2luY2Ugdjg6DQo+IC0gUmVi
YXNlZCBvbiA2LjgNCj4gLSBJbXByb3ZlZCB0aGUgY3B1IGhvdCBzd2FwIHN0YXJ0dXAgcHJvY2Vz
cyBvZiB0aGUgdGltZXIuDQo+IC0gTW9kaWZpZWQgaXJxIHJlcXVlc3QgdGltaW5nIHRvIHByZXZl
bnQgc2xlZXAuDQo+IC0gRGVsZXRlZCBjbG9ja2V2ZW50IHN1c3BlbmQgYW5kIHJlc3VtZSBmdW5j
dGlvbiBhbmQgdGhlc2UNCj4gICBvcGVyYXRpb25zIGFyZSBpbmNsdWRlZCBpbiBjcHUgaG90IHN3
YXAgb3BlcmF0aW9ucy4NCj4gLSBGb3JtYXRlZCBkYXRhIHN0cnVjdHVyZXMuDQo+IA0KPiB2ODoN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMxMjE5MTQ1NDAyLjc4NzktMS14aW5n
eXUud3VAc3RhcmZpdmV0ZWNoLmNvDQo+IG0vDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY3Og0KPiAt
IFJlYmFzZWQgb24gNi43LXJjNi4NCj4gLSBNb2RpZmllZCB0aGUgS2NvbmZpZyBmaWxlIGFuZCBh
ZGRlZCBzZWxlY3Rpb24gaW4gU09DX1NUQVJGSVZFLg0KPiAtIFVzZWQgdGhlIHRpbWVyIGFzIGEg
Z2xvYmFsIHRpbWVyIGFuZCByZWdpc3RlcmVkIGFzIGNsb2NrZXZlbnQNCj4gICBmb3IgZWFjaCBD
UFUgY29yZS4NCj4gLSBEcm9wcGVkIHRoZSB0aW1lb3V0IGZ1bmN0aW9uIGluIHRoZSBpbnRlcnJ1
cHQgaGFuZGxlciBjYWxsYmFjay4NCj4gLSBDaGFuZ2VkIHRoZSB3YXkgaW4gdGhlIGZ1bmN0aW9u
cyBvZiBqaDcxMTBfdGltZXJfdGlja19yZXN1bWUoKSBhbmQNCj4gICBqaDcxMTBfdGltZXJfcmVz
dW1lKCkuDQo+IC0gRHJvcHBlZCB0aGUgcmVnaXN0cmF0aW9uIG9mIGNsb2Nrc291cmNlIGluIHRo
ZSBwcm9iZS4NCj4gDQo+IHY3Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEw
MTkwNTM1MDEuNDY4OTktMS14aW5neXUud3VAc3RhcmZpdmV0ZWNoLmMNCj4gb20vDQo+IA0KPiBD
aGFuZ2VzIHNpbmNlIHY2Og0KPiAtIFJlYmFzZWQgb24gNi42LXJjNi4NCj4gLSBVc2VkIHNpemVv
ZigpIGluc3RlYWQgb2YgdGhlIG51bWJlcnMgb2YgY2hhcmFjdGVycyBhYm91dCBuYW1lcy4NCj4g
LSBBZGRlZCBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSB0byByZWxlYXNlIHRoZSByZXNldHMg
YW5kDQo+ICAgY2xvY2tzb3VyY2VzIGluIHRoZSBjYXNlIG9mIHJlbW92ZSBvciBlcnJvciBpbiB0
aGUgcHJvYmUuDQo+IC0gQWRkZWQgZmxhZ3MgdG8gY2hlY2sgZWFjaCBjbG9ja3NvdXJjZSBpcyBz
dWNlZXNzZnVsbHkgcmVnaXN0ZXJlZCBhbmQNCj4gICB1c2VkIGluIHRoZSByZWxlYXNlIGZ1bmN0
aW9uLg0KPiAtIERyb3BwZWQgdGhlIHZhcmlhYmxlIG9mIGlycSBpbiB0aGUgamg3MTEwX2Nsa2V2
dCBzdHJ1Y3QuDQo+IC0gRHJvcHBlZCB0aGUgd3JhcHBlcnMgYW5kIHVzZWQgZW51bSBkZWZpbml0
aW9ucyBhbmQgd3JpdGVsKCkgY2FsbHMNCj4gICBkaXJlY3RseS4NCj4gDQo+IHY2Og0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEwMTIwODEwMTUuMzMxMjEtMS14aW5neXUud3VA
c3RhcmZpdmV0ZWNoLmMNCj4gb20vDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY1Og0KPiAtIFJlYmFz
ZWQgb24gNi42LXJjNS4NCj4gLSBDaGFuZ2VkIHRoZSBudW1iZXIgYWJvdXQgY2hhcmFjdGVycyBv
ZiBuYW1lLg0KPiAtIE1hZGUgdGhlIGNsa2V2dC0+cGVyaW9kaWMgdG8gYSBsb2NhbCB2YXJpYWJs
ZS4NCj4gLSBEcm9wcGVkIHRoZSB2YXJpYWJsZXMgb2YgZGV2aWNlIGFuZCBiYXNlLg0KPiAtIFVz
ZWQgY2xrZXZ0LT5ldnQuaXJxIGRpcmVjdGx5IGFuZCBkcm9wcGVkIHRoZSBleHRyYSBjb3B5IG9m
IGlycS4NCj4gDQo+IFY1Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MDcw
NTM3NDIuMjUwNDQ0LTEteGluZ3l1Lnd1QHN0YXJmaXZldGVjaC4NCj4gY29tLw0KPiANCj4gQ2hh
bmdlcyBzaW5jZSB2NDoNCj4gLSBSZWJhc2VkIG9uIDYuNS4NCj4gLSBEcm9wcGVkIHRoZSB1c2Vs
ZXNzIGVudW0gYW5kIHVzZWQgdmFsdWUgZGlyZWN0bHkgd2hlbiB3cml0aW5nDQo+ICAgcmVnaXN0
ZXJzLg0KPiAtIE1vZGlmaWVkIHRoZSBkZXNjcmlwdGlvbiBpbiBLY29uZmlnLg0KPiAtIEFkZCB0
aGUgcmV2aWV3ZWQgdGFnIGluIHBhdGNoIDMuDQo+IA0KPiB2NDoNCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjMwODE0MTAxNjAzLjE2Njk1MS0xLXhpbmd5dS53dUBzdGFyZml2ZXRl
Y2guDQo+IGNvbS8NCj4gDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0gUmViYXNlZCBvbiA2LjUt
cmM2DQo+IC0gRHJvcHBlZCB0aGUgdXNlbGVzcyBlbnVtIG5hbWVzIGxpa2UgJ0pINzExMF9USU1F
Ul9DSF8wJy4NCj4gLSBEcm9wcGVkIHRoZSBwbGF0Zm9ybSBkYXRhIGFib3V0IEpINzExMCBhbmQg
dXNlZCB0aGUgcmVnaXN0ZXIgb2Zmc2V0cw0KPiAgIGRpcmVjdGx5Lg0KPiAtIERycm9wZWQgdGhl
IHVzZWxlc3MgZnVuY3Rpb25zIG9mIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpLg0KPiANCj4gdjM6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDYyNzA1NTMxMy4yNTI1MTktMS14
aW5neXUud3VAc3RhcmZpdmV0ZWNoLg0KPiBjb20vDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0K
PiAtIFJlYmFzZWQgb24gNi40LXJjNy4NCj4gLSBNZXJnZWQgdGhlIGhlYWRlciBmaWxlIGludG8g
dGhlIGMgZmlsZS4NCj4gLSBSZW5hbWVkIHRoZSBmdW5jdGlvbnMgZnJvbSAnc3RhcmZpdmVfJyB0
byAnamg3MTEwXycNCj4gLSBVc2VkIGZ1bmN0aW9uICdjbG9ja3NvdXJjZV9yZWdpc3Rlcl9oeicg
aW5zdGVhZCBvZg0KPiAgICdjbG9ja3NvdXJjZV9tbWlvX2luaXQnLg0KPiANCj4gdjI6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDMyMDEzNTQzMy4xNDQ4MzItMS14aW5neXUu
d3VAc3RhcmZpdmV0ZWNoLg0KPiBjb20vDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtIEFk
ZGVkIGRlc2NyaXB0aW9uIGFib3V0IHRpbWVyIGFuZCBtb2RpZmllZCBwcm9wZXJ0aWVzJyBkZXNj
cmlwdGlvbg0KPiAgIGluIGR0LWJpbmRpbmdzLg0KPiAtIERyb3BwZWQgdGhlICdpbnRlcnJ1cHQt
bmFtZXMnIGFuZCAnY2xvY2stZnJlcXVlbmN5JyBpbiBkdC1iaW5kaW5ncy4NCj4gLSBSZW5hbWVk
IHRoZSBmdW5jdGlvbnMgYW5kIGFkZGVkICdzdGFyZml2ZV8nDQo+IC0gTW9kaWZpZWQgdGhhdCB0
aGUgZHJpdmVyIHByb2JlIGJ5IHBsYXRmb3JtIGJ1cy4NCj4gDQo+IHYxOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMjEyMjMwOTQ4MDEuMTgxMzE1LTEteGluZ3l1Lnd1QHN0YXJm
aXZldGVjaC4NCj4gY29tLw0KPiANCj4gWGluZ3l1IFd1ICgzKToNCj4gICBkdC1iaW5kaW5nczog
dGltZXI6IEFkZCB0aW1lciBmb3IgU3RhckZpdmUgSkg3MTEwIFNvQw0KPiAgIGNsb2Nrc291cmNl
OiBBZGQgSkg3MTEwIHRpbWVyIGRyaXZlcg0KPiAgIHJpc2N2OiBkdHM6IGpoNzExMDogc3RhcmZp
dmU6IEFkZCB0aW1lciBub2RlDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3RpbWVyL3N0YXJmaXZlLGpo
NzExMC10aW1lci55YW1sIHwgIDk2ICsrKysrDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFy
Zml2ZS9qaDcxMTAuZHRzaSAgICAgIHwgIDIwICsNCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICB8ICAxMSArDQo+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL01h
a2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90
aW1lci1qaDcxMTAuYyAgICAgICAgICAgIHwgMzQ1ICsrKysrKysrKysrKysrKysrKw0KPiAgaW5j
bHVkZS9saW51eC9jcHVob3RwbHVnLmggICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIDcg
ZmlsZXMgY2hhbmdlZCwgNDgxIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvc3RhcmZpdmUsamg3MTEw
LXRpbWVyLnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsb2Nrc291cmNlL3Rp
bWVyLWpoNzExMC5jDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0KSGksIERhbmllbA0KDQpDb3VsZCB5
b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggYW5kIGdpdmUgeW91ciBjb21tZW50
cyBpZiB5b3UgaGF2ZSB0aW1lPw0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClppdiBYdQ0K

