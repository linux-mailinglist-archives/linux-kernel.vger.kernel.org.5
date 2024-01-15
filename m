Return-Path: <linux-kernel+bounces-25851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617582D6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F1F1C21749
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0F101D0;
	Mon, 15 Jan 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="I5Hjuwjy"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1A2BAE7;
	Mon, 15 Jan 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK5g5VwmeIYkDv7O5vyU6DcugJtuDNkVpRmyGnutzzSpD9CytfMIsV1wCPJrVGcOXdQEWWEVPUKwZxfDt+5F60RAH66XoYfNvtpxCyv3nTu0+AW+ed2fo3nkBJZ+EcddvwE8AT/MGo3U4TyoPRjuE/IJmq0L0HIFR9AO8Nw5riBPXC+BdiCWUJ9jyNM8tl//p2lEL8FsLeXvSlUSNooIJqcXOc63J5xvz4XnlumlBgVaFAAF+61PyLgDXqE4L9h/b5ChVMucV6r1xiAA5uOv2aRCwYYuRwCCTcphWG2AaQsdnrnv8Ebi81iziyu1RhvoAfg4IrgNpLObunWgUIVfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO3Hl01wNnQnikEZ390QmfftcYmpHjfh8X4zo/gVmQM=;
 b=B2zyZcG7z9/4JJjlT6Uswo2pLq3+qgeSHyZwfvj0W0QCnGm40IhcN+qxMaX9W5dlXJnXMe6gSyF80vKGl6NtTWJxHCiwWDx4l0U5kBPBF9z82i7mZI6WM0fTRWUzvQTd41T5ka5RmFud3b8mU1/NKHxLS+TNjKMMxzzsjV/PG6DPC9vqvmE0lXUXkA0yr7JfoKOdP9Le+d4wSAcJ9kjW3+0JSXfEqVZyXhblzegdV9cIkchl56f8NGMfaR5HwRBn3P+ld5S27WtDzOHF/WxkUJYFlU0ywhw6B5tV+aDcGzt+02OOermYd4ZQvR1gjiY4TKG0NYiK5HoVfHNk6eDQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO3Hl01wNnQnikEZ390QmfftcYmpHjfh8X4zo/gVmQM=;
 b=I5HjuwjyavyIqqxxeJNc6PObCqKl9AVpnBxCiQUpSQdiu7cO1P3ZPuQ1qBu3o2NKnby3QJ525cn08bE5sonUIk/YRGQB7nBYk3uerXfiTjvm1wYX7CEgJWyHuAxLskQLvRg7FTu5U5IY1HvsOHJDua/ZyPhueNi9Q1G8d34Lnm8=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS4PR04MB9623.eurprd04.prod.outlook.com (2603:10a6:20b:4cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 10:05:56 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 10:05:56 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Topic: [PATCH v2 4/5] arm64: dts: add description for solidrun am642
 som and evaluation board
Thread-Index: AQHaRXqNRxBDBTIBFEOB99P14tzvurDWbMUAgALwy4CAASCFAIAAK9IA
Date: Mon, 15 Jan 2024 10:05:56 +0000
Message-ID: <2879689e-5a4e-4242-a23b-d2aa9f004b1d@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
 <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
 <0b03af70-7dc4-4a4f-b9dc-218ef365c237@linaro.org>
In-Reply-To: <0b03af70-7dc4-4a4f-b9dc-218ef365c237@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AS4PR04MB9623:EE_
x-ms-office365-filtering-correlation-id: 3d20b8e4-de97-4240-9e0d-08dc15b190f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KwVD724ADbS2N17ryphrNxNnwXgbDmmKmptIANqIIwZE6bJ4zlIMDDaqnGTb+VPztNxVBOsfLc5gCHaF6nu8/mEkJiUS0pEo7s2TMSDPcxppQH0LI79C8b5Em9smYxxpmcbFWA4H/MQmqiQEgrYK8OR4WKsmukWvCbLbeJennZOaMz6XiU3iP9veTOGEo+jagQjZUyZc7bfhXQLaX1GStHqwdaZmCutQYKZTgsWYyo8AihRZ2Bx5Nlu0LtNHNz8dDmFGZJc/njStgqr5t/wPfPj6vHQoXEwJH1t2+IH3c+v3q3aJMqrGsS/V+6P6pt/lgOIEUXpB9G4y3S/maYeIBbXiCht74HWAxqkiIzNU6Xm4NYXloKBu/R2PWok/EziY8Epi9X6jL9D781PWW0vNZpQtEtBZ93P883giaoo0KkzpxYVvklE4EK3Iug3nkQHgndO9wq45AtiatRdbIcJlWAf3mX6S5Y0WwVnVDZcFXwhvCIeNcqudhBQ5PZgedEylAEAi+dH4HBL7L2MV3ohE8dqlhI1T/FhvJw53v1XJe44VTe8PNcmb5ISCiehRz7QSQtd1kXj1bCqaDiMlX7v7REXGztymWHuyQHfe7/ZQ3KrJmmkf4AWMfAYnGEjqMeSI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39840400004)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(83380400001)(86362001)(31696002)(36756003)(38070700009)(8676002)(8936002)(4326008)(5660300002)(53546011)(2616005)(26005)(38100700002)(122000001)(71200400001)(66946007)(76116006)(66556008)(316002)(66446008)(66476007)(64756008)(54906003)(110136005)(91956017)(966005)(2906002)(41300700001)(6512007)(6506007)(7416002)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1JDUGhTdXh1ZkJNNzVtMGpMSGdSQWhPdU1PVVZBNitQVVNCTFpHOFVmdUZq?=
 =?utf-8?B?MXBhaDUwVFAyb28yNG1nOTFKZXZ6eFVaNy9aL0FEcWJ0KzNvdWhkWGNuUkY4?=
 =?utf-8?B?bnRlRCtndklEanpUMlBZTnBVZmJWckJqbVlvM1BwOXpNVUhGZ09YclZEaDZP?=
 =?utf-8?B?V095ck03ZWllMTZvVTJsalJ5djFTVzgyWktOZXZzWmxJQW82Y1ViMmIzRWF4?=
 =?utf-8?B?N054bHdDWGxxYW02dk4zWGhSa1d1dVc4VFg5NE5PVTVINlZDc05PbFIzZVJ0?=
 =?utf-8?B?MFI0dTFjeGNNSFpRS3lLSTlLQkl2TUNnRjVoS3hWVVo3UEswRkppYldNejJt?=
 =?utf-8?B?K3M5bWxEL21jOWVJdTA3dzdESGd5bFc2YjFhVFJtbENpLzgxci80aVRZdm9E?=
 =?utf-8?B?QmJOY01XWTIxY1J1aXVXdWdEN0VRbFIyK0k0TTNPTW11KzVkRzNYVTdjckFU?=
 =?utf-8?B?SGMwdVlETnBsZVFUMzBjQ2JQcDd5ZGpLTTNWenVGRkUzUWlxVzVIOURCcUlT?=
 =?utf-8?B?bG42ODdsb3lDdmh6bkZEcUgwMmg3M2kxMzRreDlxUUlma2g4bnR0Z3JPTUNR?=
 =?utf-8?B?bjJpZmw0ZkF2K2svWTdtN0U0OE1tQlZrVnA3V09SQ1F3WmxYazdQNUIvVHZv?=
 =?utf-8?B?NktzR3BocUZVbHFCckE3S2U5MjdlVG5pQ1djc0VoL08yZmhaaDYvZkVDbGda?=
 =?utf-8?B?ekRJSHJ0ZkpMbWFVa1YyVCtsejBZY3pGN2Jqd3h2Y0N1TEt2S1BoUVhYT3RO?=
 =?utf-8?B?Ti9FMDVEOE11Q1JMNVJQcFpmdmQ4am5Fb2lBSHljNlhNS05VK3I1R0g3Q2d2?=
 =?utf-8?B?Q1I2djBtWTZHZW1JVlllazhGdU1HSjRobnVjM2ZmbkpqTkg3QnkxTVhrbUJ3?=
 =?utf-8?B?Vm83R0NJUmRYd2F2UFpjaS9ncFlxUmNUTC9pTHlsei8relcxQ0lYUmFzM2RT?=
 =?utf-8?B?TGd0cjFHS3M3NFU4NTRITS9vRG44RnExWW5nZU5RM1dhYk12dVlsN2lwZVZT?=
 =?utf-8?B?YTNSRTNpSEIrNE9vSXVoUkY4eWlBOURZaDdJSkpSMWdGaHErTUk5RFhPUExB?=
 =?utf-8?B?Yk9HOVU5ZkVZZDhoR0oraFRFU2VLZjhBK3BCbzhoMkM2cUswSjg5cWtLTHlj?=
 =?utf-8?B?ZmZxR0RBcUtuMVgvb3cxWmlmQzBiYlN1aCtJMmFjalowcHJlWlhiaHFVV2Nw?=
 =?utf-8?B?eEVZNmVlYzB2SzFNalZZSnFXVkxsQ2FNTGxINm9PWUkrTm1jZTQvaGxuQUlJ?=
 =?utf-8?B?bjlyMHRUWUJVejU3eUdQZ1k4d1BIZnQrN0xsMmhvTTVLdCt2UXN5YnJxQWli?=
 =?utf-8?B?NldaNms2U1lueWd0a3h1OEhhdDBUajNydHIxcmtHeWFYT2tXSlFicXRwOXFR?=
 =?utf-8?B?V3huazJrNFF1Y2ZzMjRyNGhqaDhRa1RTUGlmQm5DNTZJVXlRdUhGMnRJK00z?=
 =?utf-8?B?QjYvaUE3VERCUVhtY2dhK25UamxDT3cycEtvcFM3Uld4bytUeDZvNXY1emZN?=
 =?utf-8?B?U3c2cW9EUDN4UEE5ZllUNEt6QnF3bjdWdG5vNWU4T3B2aG9OZTJpUTl0dnBa?=
 =?utf-8?B?ZFpmY1ZMdGtsRC9PYmxNdnUwakVsRDdDbEtWc3E2c0dUajJ2WThNd0w1Skxi?=
 =?utf-8?B?SHAvd28yWWorUkVwelI2VzFndkhyR2d3TTlobUhJT2N5bnNBUGNoUG4wK0J3?=
 =?utf-8?B?Y2Npc1BwVW1QV0x1Qm8yR2cxWmlTYWRHUytYdHo0bGFrYUd3OTRTc3hlS1Y0?=
 =?utf-8?B?N2N3MklEQTY3Q1RmZkFxV1pualc3S0pOWndWSXkydEI0OXE5M1ZjcFNuMnNP?=
 =?utf-8?B?VWorWEg0WFBEOUtBL2hJZXZoSkRrNFJtOXk5QXg0M3JjSU5BbnNXSzA2ckpF?=
 =?utf-8?B?YW1VbVFIQWhwUTUzenZBRVN1MnBiUEhReFRYN2RWTXJibEYyaVVQOTJ3dWlS?=
 =?utf-8?B?a0ViMlZxdGx0bUdGSHNQVU1FU2xaTFFUd1NCa3M4akliNGhYMGhYSFpoWVFS?=
 =?utf-8?B?bFZnKzFCQ2QySzZib01hYzdIdW1kaGx4UE53T2o0K3ppOE53akdvZzVlMTBa?=
 =?utf-8?B?OERETjMvZ2VpODZaM1d1REZMUUMyWEphb2tyZ2tST3FEQWpMdXBqY3Zta1ZS?=
 =?utf-8?Q?Cnmh87mcid4MlsHaGmfhpz36w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <464547BAE77F8E41A8C3021188814EB1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d20b8e4-de97-4240-9e0d-08dc15b190f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 10:05:56.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q80NppglxMDuwT28HjolANPjyyCenRV6fu6nHHFmIvYyW46Ixr9uJIPC+5vFsSY7EBzJ5JuF1t9RARQi8Wy0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9623

QW0gMTUuMDEuMjQgdW0gMDg6Mjkgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KDQo+IE9u
IDE0LzAxLzIwMjQgMTU6MTYsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQW0gMTIuMDEuMjQgdW0g
MTg6MjIgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPj4NCj4+Pj4gKwkvKiBQUlUgRXRo
ZXJuZXQgQ29udHJvbGxlciAqLw0KPj4+PiArCWljc3NnMV9ldGg6IGljc3NnMS1ldGggew0KPj4+
IE5vZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVyaWMuDQo+PiBUaGlzIG5hbWUgaW50ZW50aW9uYWxs
eSBpbmNsdWRlcyB0aGUgbmFtZSBvZiB0aGUgaXAgYmxvY2sgd2l0aGluIGFtNjQgc29jDQo+PiBw
cm92aWRpbmcgc29mdHdhcmUtZGVmaW5lZCBldGhlcm5ldCBjb250cm9sbGVyIHRocm91Z2ggY29w
cm9jZXNzb3JzIFRJIGNhbGwgInBydSIuDQo+IFdoeT8gVGhpcyBpbnRlbnRpb25hbGx5IHNob3Vs
ZCBub3QgaW5jbHVkZSBzcGVjaWZpYyBuYW1lLg0KSSB1bmRlcnN0YW5kLiBXaGljaCBpcyB3aHkg
SSBpbWFnaW5lZCBpbiB0aGUgb3RoZXIgcmVmZXJlbmNlIGhhZCBpbnRlbnRpb25hbGx5DQpkaXZl
cmdlZCBmcm9tIHRoYXQgcnVsZS4NCj4NCj4gQWxzbywgd3JhcCB5b3VyIGVtYWlscyBhdCBwcm9w
ZXIgbGVuZ3RoIHNvIHRoZXkgd2lsbCBiZSBtYW5hZ2VhYmxlLi4uDQo+DQo+Pj4gU2VlIGFsc28g
YW4gZXhwbGFuYXRpb24gYW5kIGxpc3Qgb2YNCj4+PiBleGFtcGxlcyAobm90IGV4aGF1c3RpdmUp
IGluIERUIHNwZWNpZmljYXRpb246DQo+Pj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRp
b24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtYmFzaWNzLmh0
bWwjZ2VuZXJpYy1uYW1lcy1yZWNvbW1lbmRhdGlvbg0KPj4+DQo+Pj4NCj4+Pj4gKwkJY29tcGF0
aWJsZSA9ICJ0aSxhbTY0Mi1pY3NzZy1wcnVldGgiOw0KPj4+PiArCQlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPj4+PiArCQlwaW5jdHJsLTAgPSA8JnBydV9yZ21paTFfcGluc19kZWZhdWx0
PiwgPCZwcnVfcmdtaWkyX3BpbnNfZGVmYXVsdD47DQo+Pj4+ICsNCj4+Pj4gKwkJc3JhbSA9IDwm
b2Nfc3JhbT47DQo+Pj4+ICsJCXRpLHBydXMgPSA8JnBydTFfMD4sIDwmcnR1MV8wPiwgPCZ0eF9w
cnUxXzA+LCA8JnBydTFfMT4sIDwmcnR1MV8xPiwgPCZ0eF9wcnUxXzE+Ow0KPj4+PiArCQlmaXJt
d2FyZS1uYW1lID0gInRpLXBydXNzL2FtNjV4LXNyMi1wcnUwLXBydWV0aC1mdy5lbGYiLA0KPj4+
PiArCQkJCSJ0aS1wcnVzcy9hbTY1eC1zcjItcnR1MC1wcnVldGgtZncuZWxmIiwNCj4+Pj4gKwkJ
CQkidGktcHJ1c3MvYW02NXgtc3IyLXR4cHJ1MC1wcnVldGgtZncuZWxmIiwNCj4+Pj4gKwkJCQki
dGktcHJ1c3MvYW02NXgtc3IyLXBydTEtcHJ1ZXRoLWZ3LmVsZiIsDQo+Pj4+ICsJCQkJInRpLXBy
dXNzL2FtNjV4LXNyMi1ydHUxLXBydWV0aC1mdy5lbGYiLA0KPj4+PiArCQkJCSJ0aS1wcnVzcy9h
bTY1eC1zcjItdHhwcnUxLXBydWV0aC1mdy5lbGYiOw0KPj4+PiArDQo+Pj4+ICsJCXRpLHBydXNz
LWdwLW11eC1zZWwgPSA8Mj4sCS8qIE1JSSBtb2RlICovDQo+Pj4+ICsJCQkJICAgICAgPDI+LA0K
Pj4+PiArCQkJCSAgICAgIDwyPiwNCj4+Pj4gKwkJCQkgICAgICA8Mj4sCS8qIE1JSSBtb2RlICov
DQo+Pj4+ICsJCQkJICAgICAgPDI+LA0KPj4+PiArCQkJCSAgICAgIDwyPjsNCj4+Pj4gKw0KPj4+
PiArCQl0aSxtaWktZy1ydCA9IDwmaWNzc2cxX21paV9nX3J0PjsNCj4+Pj4gKwkJdGksbWlpLXJ0
ID0gPCZpY3NzZzFfbWlpX3J0PjsNCj4+Pj4gKwkJdGksaWVwID0gPCZpY3NzZzFfaWVwMD4sIDwm
aWNzc2cxX2llcDE+Ow0KPj4+PiArDQo+Pj4+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8Jmljc3Nn
MV9pbnRjPjsNCj4+Pj4gKwkJaW50ZXJydXB0cyA9IDwyNCAwIDI+LCA8MjUgMSAzPjsNCj4+PiBO
b25lIG9mIHRoZXNlIGFyZSB0eXBpY2FsIGludGVycnVwdCBjb25zdGFudHMvZmxhZ3M/DQo+Pj4N
Cj4+Pj4gKwkJaW50ZXJydXB0LW5hbWVzID0gInR4X3RzMCIsICJ0eF90czEiOw0KPj4+PiArDQo+
Pj4+ICsJCWRtYXMgPSA8Jm1haW5fcGt0ZG1hIDB4YzIwMCAxNT4sIC8qIGVncmVzcyBzbGljZSAw
ICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIwMSAxNT4sIC8qIGVncmVzcyBz
bGljZSAwICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIwMiAxNT4sIC8qIGVn
cmVzcyBzbGljZSAwICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIwMyAxNT4s
IC8qIGVncmVzcyBzbGljZSAwICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1hIDB4YzIw
NCAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5fcGt0ZG1h
IDB4YzIwNSAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+Pj4+ICsJCSAgICAgICA8Jm1haW5f
cGt0ZG1hIDB4YzIwNiAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+Pj4+ICsJCSAgICAgICA8
Jm1haW5fcGt0ZG1hIDB4YzIwNyAxNT4sIC8qIGVncmVzcyBzbGljZSAxICovDQo+Pj4+ICsJCSAg
ICAgICA8Jm1haW5fcGt0ZG1hIDB4NDIwMCAxNT4sIC8qIGluZ3Jlc3Mgc2xpY2UgMCAqLw0KPj4+
PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDEgMTU+LCAvKiBpbmdyZXNzIHNsaWNlIDEg
Ki8NCj4+Pj4gKwkJICAgICAgIDwmbWFpbl9wa3RkbWEgMHg0MjAyIDA+LCAvKiBtZ21udCByc3Ag
c2xpY2UgMCAqLw0KPj4+PiArCQkgICAgICAgPCZtYWluX3BrdGRtYSAweDQyMDMgMD47IC8qIG1n
bW50IHJzcCBzbGljZSAxICovDQo+Pj4+ICsJCWRtYS1uYW1lcyA9ICJ0eDAtMCIsICJ0eDAtMSIs
ICJ0eDAtMiIsICJ0eDAtMyIsDQo+Pj4+ICsJCQkgICAgInR4MS0wIiwgInR4MS0xIiwgInR4MS0y
IiwgInR4MS0zIiwNCj4+Pj4gKwkJCSAgICAicngwIiwgInJ4MSI7DQo+Pj4+ICsNCj4+Pj4gKwkJ
c3RhdHVzID0gIm9rYXkiOw0KPj4+IERyb3AuIERpZG4ndCB5b3UgZ2V0IHN1Y2ggY29tbWVudHMg
YmVmb3JlPw0KPj4gWWVzLCBidXQgYWdhaW4gSSBjYW4gcG9pbnQgdG8gYW4gaW4tdHJlZSBleGFt
cGxlIG9mIHRoZSBzYW1lIHN0cnVjdHVyZS4NCj4+IEkgc2VlIG5vIHJlYXNvbiBmb3IgZGVzY3Jp
YmluZyB0aGUgc2FtZSB0aGluZyBkaWZmZXJlbnRseSBpbiBkaWZmZXJlbnQgcGxhY2VzLg0KPiBT
byBpZiB0aGVyZSBpcyBhIGJ1ZywgeW91IGFyZSBnb2luZyB0byBkdXBsaWNhdGUgaXQuDQpJIHdh
cyB0b3JuIGJldHdlZW4gbWFraW5nIG15IG93biBzb2x1dGlvbiwgYW5kIHVzaW5nIHJlY2VudGx5
DQphZGRlZCBhbmQgdG9waWNhbCAodG8gbXkgc3VibWlzc2lvbikgY29kZSBhcyB0ZW1wbGF0ZS4N
Cj4NCj4gUGxlYXNlIHByb3ZpZGUgcmVhbCBhcmd1bWVudCB3aHkgdGhpcyBpcyBuZWVkZWQsIG5v
dCAiSSBzYXcgaXQNCj4gc29tZXdoZXJlIiwgb3IgZHJvcCBpdC4gT3RoZXJ3aXNlIGl0J3MgYSBO
QUsgZnJvbSBtZS4NCkkgd2lsbCBhdHRlbXB0IHRvIGltcHJvdmUgdGhlIG1hZ2ljIG51bWJlcnMg
aW4gdGhpcyB3aG9sZSBub2RlLA0KYW5kIHJlY29uc2lkZXIgdGhlIG5vZGUgbmFtZS4gVGhhbmtz
Lg0KPg0KPj4gUGxlYXNlIHNlZSBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjU0LWlkay5k
dHNvDQo+PiBUaGVyZSBhcmUgb25seSBzbWFsbCBkaWZmZXJlbmNlcyBmb3IgdGhpcyBmZWF0dXJl
IGJldHdlZW4gYW02NSBhbmQgYW02NC4NCj4+IEl0J3MgaW5jbHVzaW9uIGluIHRoZSB0cmVlIHdh
cyB2ZXJ5IHJlY2VudCwgY2xlYXJseSBpdCB3YXMgZ29vZCBlbm91Z2ggcmlnaHQ/DQo+PiBTZWUg
YWxzbyBteSBjb3ZlciBsZXR0ZXIgZHRic19jaGVjayByZW1hcmsgb24gZG1hcyBwcm9wZXJ0eS4N
Cj4gSG93IGRvZXMgZG1hcyBtYXR0ZXI/IFdoYXQgYXJlIHlvdSB0YWxraW5nIGFib3V0Pw0KSSBh
bSB0cnlpbmcgdG8gZXN0YWJsaXNoIHdoZXRoZXIgSSBjYW4gdXNlIHRoYXQgYXMgZXhhbXBsZSBv
ciBub3QuDQpDbGVhcmx5IGl0IGlzIGEgYmFkIGV4YW1wbGUsIGFuZCBJIHNob3VsZCB0cnkgZGVz
Y3JpYmluZyBpdCBiZXR0ZXIuDQo+DQo+DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo+DQo=

