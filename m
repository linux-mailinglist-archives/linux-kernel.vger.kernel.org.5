Return-Path: <linux-kernel+bounces-38995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E810B83C980
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28988B2576E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B029135A5E;
	Thu, 25 Jan 2024 17:04:18 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2087.outbound.protection.partner.outlook.cn [139.219.146.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683E13541E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202257; cv=fail; b=Bs8A00ehJY7UVT/fxy1YbiMoN2K3H1f3I6l9bvsT89XIBTbULkT7nUsxfPgZejOTpuvVJ3bnwQReQ5qgql+tAWQbdVlLWGynXTC8xs0pUVvjmTXEEF1Bf/CBEULmqdu7tudNMfpWm7g43m6nOcUp9EiPBu+KNbP+QT73z3MG4wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202257; c=relaxed/simple;
	bh=Ti0YHvl3HFFrffMWAMzr96fhCYoBS7aCeOcougY8oN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpdIpbBMHsCqVp/Nhvndtbmz1aliYpXkHCe2s1IkpdSnoEzxuuNIguwqnlC0y43TLYHfdNLyJKAikx3qVad9QSo1l4VajndlE+38QKBdyzLNX2Ky9tOHyGjcz5w0V0d7tSRNVcedwh55Kd1rtS7xKXShhOCYcgawqCo2pazlRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ8P8dFYrxMpd48kLZhFCC1t1kwH2NCCvm0IV5uQ7SaJ3Ztu8tLIdP1GPfNW7etJOJ5hPeCWU06b7nD+xcsWKfrmOlPEu05igo9++XmY2PJ4XO76r+9yX5irJhVB4pJL8eCZZOLhbt3Rkl/vJWCQBeIKi75dh10wRC333Sm40a0uQ2/W1q+AR+5ccReRJvQYrzq0bpePrzwL4l/08AdOsVEF+85S/fZF8+Dp/7fCOiFidEX14U+x6cIGfWh+sp2KCmLFDguirKQSDQXSoXKwtspjCa/+Kz2Uq5ltk97+v6p66exmktD7Q2hTbGAvpl5MuCnytoxcn5GV+a2/VExtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti0YHvl3HFFrffMWAMzr96fhCYoBS7aCeOcougY8oN8=;
 b=Z1oH/564U/DN+lsSQ7lLBfX+Ea5UdlSD2hfdt7eH/PvWF9R/U1/7lMb6EASmvirpF/LtGQiD3jOsIPw+0jZqEe1Pmf/V7alV8PbZT/62IPnaPKqNdbPfKeEBRzrldQp0wawMYdbv69aSdVn3Rvqr52Xe0ZP3VSODIA+hKwD3lRs+HqtRY1z9Wi18xtJCQ4iPYRUypYXNYmu8DKaWowSv9g/WjXJgLmT8n8Gh7u1ySL1GpNuPy42qnKY4KvhOCA/8pbgxgk44Axk6jSDDpih8pEKLCsfZKxvMMWFQn6FqCaccNA3kw2ZIIFv3vMGFU4M0UIbz2tbqmNu/Ab0XvpxLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0964.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:04:03 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::4d2f:3393:3d7e:7a45]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::4d2f:3393:3d7e:7a45%4])
 with mapi id 15.20.7228.026; Thu, 25 Jan 2024 17:04:03 +0000
From: Leyfoon Tan <leyfoon.tan@starfivetech.com>
To: Anup Patel <apatel@ventanamicro.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"atishp@rivosinc.com" <atishp@rivosinc.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ley Foon Tan
	<lftan.linux@gmail.com>
Subject: RE: [PATCH] clocksource: timer-riscv: Clear timer interrupt on timer
 initialization
Thread-Topic: [PATCH] clocksource: timer-riscv: Clear timer interrupt on timer
 initialization
Thread-Index: AQHaT68sDX9PuDq740WBrDfcVF+1eLDqwI6AgAAAraA=
Date: Thu, 25 Jan 2024 17:04:03 +0000
Message-ID:
 <ZQZPR01MB0979832B777168ECF8A1DA8B8A7AA@ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn>
References: <20240125165416.1987576-1-leyfoon.tan@starfivetech.com>
 <CAK9=C2VKiSBX4349jRL0m+XAtT27KSW3GGH+xhaM4ZQoEsAgzg@mail.gmail.com>
In-Reply-To:
 <CAK9=C2VKiSBX4349jRL0m+XAtT27KSW3GGH+xhaM4ZQoEsAgzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0964:EE_
x-ms-office365-filtering-correlation-id: 5d473c27-b6ae-4cd4-3545-08dc1dc7a20a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6anqGnycaDg+VxcaU47jebW768l0ByCx7QL5nns7j/Gzl9+4FJMCgyhdTqc5JDg50XEstzrx5UeQfxrQnctNTjuPSlC11NuHsN7uJORLMP5gvpE9qVCz3OGmgO527G94YeXm/qYyQtourgwtMA5XmUhBVZdVLkdSez5Mclyx07KtHyTDZLihY4/pxJsNOnQGULK8/nl8C9NGj3ejyu5vynlbD1Vc6eZDx6rwUFbDzj2tXF6wfwKNjo8aFug5xcl76159+XL1I+oUvESa20hGpOC3yscpbD0qaNLWet23fzI+Uhm+5lmp3XmF2AYcTWAIGbooj1zAxvUzdCiUhnHJgTN4RX3Wu2pkhOhLnEapUKpsc8Gv2mjALuPxfo5dupvMz8vBCJquiLJ+taUrc/qXB4lwfdt7mE/3F8/icWryFJeyvDx7DEISvY9LTCYccaetIGNr0GKDaeHeijxwi3ho5V3Jz9RPeUAQdcZxGEJIzPUF17rbCTbSgcqIw5gMRYuKKqbjWZ3p+Qpnrxxc4PjnmXjD1VfIt9MDqOrhDE/a8QJ/uQPWGMFzVL6ijordRM0W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(4326008)(6916009)(122000001)(26005)(54906003)(64756008)(40180700001)(41320700001)(5660300002)(38070700009)(9686003)(7416002)(83380400001)(33656002)(40160700002)(44832011)(2906002)(41300700001)(66446008)(38100700002)(7696005)(53546011)(55236004)(508600001)(55016003)(66946007)(76116006)(86362001)(71200400001)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ayt0U0NETDJ3azBvNXFmN1hXSTdxMU9JOU9JQno4STh6ZWo5aGlBQTRJRWsv?=
 =?utf-8?B?RTM2V0JNZlIrR3pWU3JvZ3FVYmVYRFpSWFdGcExBTEhCL3RlN3dPdlhXbUVL?=
 =?utf-8?B?Wm94L1pLa1d2cGJmZkljRlZuUkRDazJqSzhUTUEya0txdkJYVFpaZkpFeEU2?=
 =?utf-8?B?UlV4UWladkM5cUxteGxkWkVOem5kS0pYVmZXeThoUnQvdjFWNTB2NEFrVnJM?=
 =?utf-8?B?U1BibWxhLzNyNCtEMWIwa3JVdXJOZExZeldEM2dQbGVqbkk2b0kwQlhWcmx6?=
 =?utf-8?B?QTB4R3hWbDNPaG12cTNtaFEyV0VuTjBWTzBod0xqU1Q0enFFK3NQSUg4NVZY?=
 =?utf-8?B?WnhGNmkreFNQNWxTaDRkbUZjWExjZW5hNk5uMHpUTlZtcTBDQWxub0F3bFIx?=
 =?utf-8?B?UWJVR1pCZ2crbm1CNXFZT2x3UE1mbkZaQVNGc0lVSkowMWJxWklqS2hPcFN4?=
 =?utf-8?B?U0IrN2ZOMHJ3WlcwT29EcXpaWGNRSjJhR3UwMlZPUUcrWmsxdkJPZUtwSG9t?=
 =?utf-8?B?ZCsrOHJoVjNsWldLd3VuY2xYLzBYeWxRS0hneHIwTndIZElrdnM3c0xZRHVi?=
 =?utf-8?B?RVU3eC9BSjFKSzRDL3pLWWxSNUxoQzZkbkxJRFVEeWJZN0VTQnVSNnpITmkz?=
 =?utf-8?B?L1FVMk5LVGJJQm9OUnNhdWpScUNNSzFtN3p4a0Fjd0VlV2ZPZnVJODNKNHRZ?=
 =?utf-8?B?RGd6QTFZTnBBUU9yTDVCWXcxVUpDOCtnNEM0VitrbFFqTUZ3ZHZVY1FCTWxj?=
 =?utf-8?B?SC9KajZIZ1hobWRWRGRPeDhKMVNObzR6K0hITHRHY2xnL3JCbWdCNVdBdWZv?=
 =?utf-8?B?eGpZWWl6M2ZNU2x6bmhSQWlTM295dUZGelBxNUNnS1E3ZzZiTjk1Z3dFWXNN?=
 =?utf-8?B?dGRRVXNTZE5ZNFZtckxMeGlwdGFLU0lVOWlnaTZwSGNVRENIY2hJUjZEWTZr?=
 =?utf-8?B?OEdpNnBBV3hPYnBIUFI1STlhbGRIaWpYTm1GVlJHakhDWWFwaWhDcUFZVmFH?=
 =?utf-8?B?T1lHNzZSai9FNGM2RXZ3d3hURzJHbEdHSE4zdHpGZ3JaVTU2RTZkN0tnZkpM?=
 =?utf-8?B?Z1NmRjNrYUNtVkpHODIrSjhQMm9paU5INDJzZEU1Zy9DdkpPUmhuM1RSNXJn?=
 =?utf-8?B?cUlWU2tGaDllZU9kZ2dZMktrbHRYQ21tZzRjNnc1M2c4amZPaUVQMG9pcXpq?=
 =?utf-8?B?dWVZVzM1ck1adTc4Ym5vUWNUanhxQzJIS2JRZ0oyMVVoM2FnN3dLclIxOWxD?=
 =?utf-8?B?TG5JNmZqUHArQVpkYi9vSEhNUzFWa3lQMjhsaERWbTdhMWZUM3dTV3Myc1Nw?=
 =?utf-8?B?bUZ4UnNuYVk4RzJXelRuUTdxa1RTRXV3QTliUWFTakZLV1VjcnhxeUt0eGJP?=
 =?utf-8?B?MUFabTdLWjZ0TmNVN29QcTcybVFvc2pBWHVJejBEaGY2bzc1WXI3S2lLeE5K?=
 =?utf-8?B?L3g4bndtenFHSTJrZlYyanp5cXUzbFFJWEJJRzNYajJ6cTZObHEyMUNWTGJ6?=
 =?utf-8?B?S0ozdzNrYk81Q2NxTDMrc1A3SE15NkhHc3hrQVN3M1lXMTJYdStvY2xqcXRE?=
 =?utf-8?B?anNXaVpsei9nSklPTnUzTnFibE5lZXRLc1gySDRZcWdKalFlaU9LUVllOWZm?=
 =?utf-8?B?NUhIUmtjbnBtS1pCV3JJd1lZVmJEQWFRQlU4UitXTFZ3RVRvSjZ6Y3Mwa1pa?=
 =?utf-8?B?WE5hQkprdUlaVCsrdXIzSmUrTGd4YitPaXN0ZnU5SXBUU2c5Z2F6WjQ3UGlD?=
 =?utf-8?B?K05ZT2dIRmZrb3NjSTR4NmxYbkw5WitEbGpjSE12cksxMC9zdWdoV0dMeTdy?=
 =?utf-8?B?bWRHYVRrbDUzOVRrT0xHc0ZsclNaeDhRamdFYnRPaDZYUW50T1ZubEdGKzNK?=
 =?utf-8?B?eDVhOVQzSWMyR3RaT2tUenF3YXRTcDdHNngrSmRldi9Vb1hGbUo4TGdxOWxn?=
 =?utf-8?B?dE9vWjhlY3NWTjEwSU5GM1J6cXZBSUJ1UVcwWnljMFBvelBUNWV0cDJObG0x?=
 =?utf-8?B?WkNxVVl3eU5PbzB2KzRmQmxuaFFLYXpsL3hONHJROWpIbk9jWmZJMEZzSldl?=
 =?utf-8?B?ZXVZVXhjUWl3Yk52dU9ndHJuSnVXWnFrQjhsam52aTlmSEwwWkwxOU83Wity?=
 =?utf-8?B?MzZsNG95aU81c0tIN2h5aFMrOVBKRHBuaWwyWVc3cWtjbGxpbDVmM3EyVXVn?=
 =?utf-8?B?SkE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d473c27-b6ae-4cd4-3545-08dc1dc7a20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 17:04:03.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7noe5jKigJLsETmO/32h9B/yiJ1kZ3cc8twj0gbvQSijLHqrtB5x7zMsllE/e4VvIsT/6bmcyizhg8AzXyEk68API7tIyO9L3pQy51Olob0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0964

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW51cCBQYXRlbCA8YXBh
dGVsQHZlbnRhbmFtaWNyby5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyNiwgMjAyNCAx
OjAwIEFNDQo+IFRvOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4N
Cj4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPjsgVGhvbWFz
IEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQYWxtZXIgRGFiYmVsdCA8cGFsbWVy
QGRhYmJlbHQuY29tPjsgUGF1bCBXYWxtc2xleQ0KPiA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29t
PjsgQWxiZXJ0IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+Ow0KPiBhdGlzaHBAcml2b3NpbmMu
Y29tOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGV5IEZvb24gVGFuIDxsZnRhbi5saW51eEBnbWFpbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGNsb2Nrc291cmNlOiB0aW1lci1yaXNjdjogQ2xlYXIgdGltZXIg
aW50ZXJydXB0IG9uIHRpbWVyDQo+IGluaXRpYWxpemF0aW9uDQo+IA0KPiBPbiBUaHUsIEphbiAy
NSwgMjAyNCBhdCAxMDoyNeKAr1BNIExleSBGb29uIFRhbg0KPiA8bGV5Zm9vbi50YW5Ac3RhcmZp
dmV0ZWNoLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiB0aGUgUklTQy1WIHNwZWNpZmljYXRpb24s
IHRoZSBzdGltZWNtcCByZWdpc3RlciBkb2Vzbid0IGhhdmUgYQ0KPiA+IGRlZmF1bHQgdmFsdWUu
IFRvIHByZXZlbnQgdGhlIHRpbWVyIGludGVycnVwdCBmcm9tIGJlaW5nIHRyaWdnZXJlZA0KPiA+
IGR1cmluZyB0aW1lciBpbml0aWFsaXphdGlvbiwgY2xlYXIgdGhlIHRpbWVyIGludGVycnVwdCBi
eSB3cml0aW5nDQo+ID4gc3RpbWVjbXAgd2l0aCBhIG1heGltdW0gdmFsdWUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMZXkgRm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmlzY3YuYyB8IDMgKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXJpc2N2LmMNCj4gPiBiL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvdGltZXItcmlzY3YuYw0KPiA+IGluZGV4IGU2NmRjYmQ2NjU2Ni4uYTc1YTc0NjQ3
MzQ0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmlzY3YuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItcmlzY3YuYw0KPiA+IEBAIC0xNzIs
NiArMTcyLDkgQEAgc3RhdGljIGludCBfX2luaXQgcmlzY3ZfdGltZXJfaW5pdF9jb21tb24odm9p
ZCkNCj4gPg0KPiA+ICAgICAgICAgc2NoZWRfY2xvY2tfcmVnaXN0ZXIocmlzY3Zfc2NoZWRfY2xv
Y2ssIDY0LCByaXNjdl90aW1lYmFzZSk7DQo+ID4NCj4gPiArICAgICAgIC8qIENsZWFyIHRpbWVy
IGludGVycnVwdCAqLw0KPiA+ICsgICAgICAgcmlzY3ZfY2xvY2tfZXZlbnRfc3RvcCgpOw0KPiA+
ICsNCj4gDQo+IFRoZSByaXNjdl90aW1lcl9pbml0X2NvbW1vbigpIGlzIGNhbGxlZCBvbmx5IG9u
IGJvb3QgSEFSVC4NCj4gDQo+IEkgc3VnZ2VzdCBkb2luZyByaXNjdl9jbG9ja19ldmVudF9zdG9w
KCkgaW4gcmlzY3ZfdGltZXJfc3RhcnRpbmdfY3B1KCkganVzdA0KPiBiZWZvcmUgZW5hYmxlX3Bl
cmNwdV9pcnEoKS4NCj4gDQo+IEkgYWxzbyBzdWdnZXN0IGFkZGluZyBhbiBhcHByb3ByaWF0ZSBG
aXhlcyB0YWcgaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFu
dXANCj4gDQoNCk9rYXksIHdpbGwgY2hhbmdlIGl0Lg0KDQpUaGFua3MuDQoNClJlZ2FyZHMNCkxl
eSBGb29uDQo=

