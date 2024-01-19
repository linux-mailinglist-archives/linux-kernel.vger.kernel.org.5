Return-Path: <linux-kernel+bounces-31262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C605832B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4D31C234CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1469537ED;
	Fri, 19 Jan 2024 14:31:49 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2085.outbound.protection.partner.outlook.cn [139.219.146.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A136AE0;
	Fri, 19 Jan 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674709; cv=fail; b=W+4QDmCHZ54f+JQJpJ9KeZ4Sv9nLNG4+lPIxtKWUVPkN+rXW180KamfDKtDiwZ8w2eqEsfPyZVACy+W8XzRaXE5tiRFJXQZ3lyDEg/H4FySyxiHudNi7s1pjReHBU4LjdgdZZICyHrytCTrHrLJCOqgZhDeO0BSFaGa5Nxr1qI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674709; c=relaxed/simple;
	bh=fCYn1jo8fL71UwAZ7WXwWebXkZwsEfOg50aMXcy3BAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STczY2GuracFCDMJktEpYZeJlLoc9ds/HgDMs5l3ZoaUCJ0JOI4a/IgALzcnuJRK88pdc5Z0DYkPg9SF+oWOSjkhYwrsjgO2VD9nT0yGyua7YVK2ESAPLURHinsuZdVneEL0oVNVVqpQ0DNndV9zpoaCvvReCshY0PeF60a06lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9oGhLoDFhhLlHeL8Gx1eZULAUZcQSmQRgL6H4j0qgEvEML1rOYBU9gDcHw84gnpy1zuAIqKU4RegEeSuyWVCQrv+koT7qhatv++57yd36kj9XGCeEqXO9wC5Ck4I2nRb1qI1sCHyQ22j4tUvF0V4+cZyMByBjYCsyRxO2ghl8gGwybKbj6GtQwef5r5HJWAMo7fLKJ3biAF/Qi9calOuPGBAfVi83Ip6nvElgnrC4tvAdg4ZZlIYdGkcIqRbYREenVLeyYmOszVH++8O0VCldEZ2VoVgQgfR+Xw2TiipHdb8eTPpd8YbsUO2CgV57Zm9r53Ihb8V4KXsxeKEvXYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCYn1jo8fL71UwAZ7WXwWebXkZwsEfOg50aMXcy3BAQ=;
 b=H226Jp8AAgW19jQrXzpCywWQKrdR5yXyrHhC7XpVlr902XA1sUcF5wmFKDJL0MyKgofTExhFQkuYcpncekWYRSg7chVaSGRhfeUNpIro73QgfI/PSYb83qFQ0xPthTnlLYKD5YnYZxgHIp33RCLU73wvWtlbGu3mr8kTAsZGeLCbzhGw+wZ5ieTe0N+JRuyzuFX1B7n16HBEHZIxgpoFUjHgpZv+gtCtAHlB9k9PoKx1RFbEgolyrB3OyAuqglIOVGTHGR77QJLhKr+YMW0Hu4MmKoRXTX/ynOB8HVPsR09eZPGtgksKj7bgwxDYg46wl1+DArrfXQTX30g2GYRvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0592.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.32; Fri, 19 Jan
 2024 12:57:22 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7135.033; Fri, 19 Jan 2024 12:57:22 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jack
 Zhu <jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxIDEvMl0gZHQtYmluZGluZ3M6IG1lZGlhOiBzdGFy?=
 =?gb2312?Q?five:_Match_driver_and_yaml_property_names?=
Thread-Topic: [PATCH v1 1/2] dt-bindings: media: starfive: Match driver and
 yaml property names
Thread-Index: AQHaSr81E8nk9BtrhUGN5g0sexXYkLDg67gAgAAseFA=
Date: Fri, 19 Jan 2024 12:57:22 +0000
Message-ID:
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
In-Reply-To: <20240119-despair-festival-59ab2d4d896b@wendy>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0592:EE_
x-ms-office365-filtering-correlation-id: d9c0a395-4373-44c3-e2d6-08dc18ee2d50
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BADrTlC6Y9HiwsgZSnmoXhQqIeguAakJ5yrbuJJsqj8TOy7BPPLVlMHWxWD/NwrHMHlv6QhEsObqNLKSJcbxiORT3dVH7Z0JwTqZUpS0Ujn42dcCSBage84b0km/xeIQRiVYqFO54EwbgUm3dKDuO6egVoLV9dCH7XX39FyPqPVQtNl/m7eSVW+vKJCNRSAFFJSxiEw8uUrAC818tWmgrLGhP9Z1IzahxgUw0R8T93FIH2YIqKII7tjwUHhroOHFc3tXBHhZ+M5o00BImoANUaVeWsvjGYaDRTpyZc8zjhkKtpOweRTuSYuGaT4JzQRWRkqL9AjBFY8ObAwRChwpXwLGRb6cjA0/7KbxN+aJG6XmXvxaRpsHY3Dnv0qYvcolU4/GATSCP7o3KpmujN8ueb7N8OEaGl+cDRshx5gWrYTYNQ+v+nuj5q3vyH74aEtY4SO4w9wSemYagB2BX+BcdbemdmBo+3R0hZcXVb9VrgfJXEzi/cW7EqvIqaJGkIR2fbAAAzLKDGCRq0zXIoXZ22c0DC8QBeBqIobkHydfAYkx046XLtLYtFiuc7zNa+2u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(55016003)(66946007)(76116006)(41320700001)(71200400001)(9686003)(508600001)(41300700001)(38070700009)(66556008)(44832011)(5660300002)(86362001)(54906003)(64756008)(66476007)(66446008)(4326008)(26005)(6916009)(8936002)(7696005)(83380400001)(122000001)(7416002)(33656002)(4744005)(2906002)(40180700001)(40160700002)(224303003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aTFCZDBnT0paMnl1UTdhU2xoYVpBNUc1eWxnZFZBUEdjYllORGdBd1dBeElK?=
 =?gb2312?B?a1F1dk5qYnhOblFncUxma0w4cUpPWThuc2hoQjZWNGlLVUZ0Ykl6c0ZNYWlp?=
 =?gb2312?B?OTVCQXRCNnlVaWVFTG1uTUlwOW94c0hNVlF3Q2ZZTU1RNEhubTFQSFR1dXRX?=
 =?gb2312?B?RXAvQ093bExPWUNxYnhGeXlUYzZMQTgzakVWTUlaekloYzRVYnlKRTh5dHA3?=
 =?gb2312?B?MHBNSy84RGtxMU5JVlBoZ0NnSU5oSTFHbVVqTXMzV0xJYktQangwTEJESk9T?=
 =?gb2312?B?VFptdGk1dmxFRHFlakdYSUw3TityRkNZYU1QL3pzSnppZitMem5JSzVmTWI0?=
 =?gb2312?B?WG4rV3BjaW45dzRJaHVZNDBQVHpmWlFBZzQ2cWoydTUwNml0UlprM2NjRmh2?=
 =?gb2312?B?bi94Sk5KSUN1QStxOC9QYzUzTDA4L1JHK1J5VytyYlA1QWJxTk16eEVGWmpD?=
 =?gb2312?B?NCs4MG5UdFd4NVRBNEJIMkE1UERUVEZuZEdWL1Y2ZWVnR2JPVW9WY3VLeU8w?=
 =?gb2312?B?OUFpOXNVazJnTURML3dqTjVOMUVhTXFCQjNpUHVUa2taejluZXFucklRUGti?=
 =?gb2312?B?Y3Z3UWNnQU1LaG1PQkR4RzBsbnpLeWFaeGdsbXNzWXFPVkIwUDdlYktLcnNQ?=
 =?gb2312?B?V0hhcFRXSDM0aXFLb1E2Nk8ycGpHR0ZibzFIc01Rd3FHZlBOOXpHZHdGSzlC?=
 =?gb2312?B?N2NGMXhWTElnYUZaUDYxN1o3NzhuWDJ0L2l0alZrWnVHZG4xMWRoSU13eko2?=
 =?gb2312?B?WS80aFFRd21VcmJ1VUpyRnMyUFdPZDZLakFiaXVyUkJMbkRDdGFVR3F2WGNG?=
 =?gb2312?B?RU1YeHNoTUhFMGk2Vy9uMEtGSEdadVpycVl1dE1Da0FvWGo3Z0FremNUL3h5?=
 =?gb2312?B?VEdrcXg5YUxCaDZDK29xR3ZMYml6ODNMeUJxWnNRelNoRkpyQzhRbEthQWdH?=
 =?gb2312?B?enJzUWRMSnB4eklXdCthcWMrR1FWdnF2TGhvOVorTXBXVFpsVHJxeERwVlMy?=
 =?gb2312?B?OFJ1QmYyS0ZWVUdSZGFrWlZwMkVnSzVrdFpLMk8xcXRVQkJqbUxWOEQ5QXNU?=
 =?gb2312?B?TUVvSkRkMmF5S3YwZFhDMUhXNC9BZ2lOaFZEaTQrRlZZdHNtTWkwWFA5RGRM?=
 =?gb2312?B?ZDhVSzFIRDdFTlZQODN2S1RjZTFyZWlHTUdVdXRvemRBa1hmOGJFRHkyWVN2?=
 =?gb2312?B?bWtnakVKbE5HcVJHVUFTd0p2a1dtd2FIODRTZC9KL1N6a3FFUWpvYXFZOGxL?=
 =?gb2312?B?YThQcnUwMS9rYjhyam5yM0tpRlgvQ2swVGs3QW9QUWEwUzNmNWM3SS9ZdVpP?=
 =?gb2312?B?M3VRYXNJQzFnVjJqZkxpdUNHVGFObWxkdDROWDlBZVNKaFVPQWF4aERpajVi?=
 =?gb2312?B?aWFxWWxHbDY2WEt2TVo1MWJBVUoyWndwakZVM2Z4YWFWQXJqWTJ6K0tRVmJZ?=
 =?gb2312?B?USt2YWthWmVBdE1MMmxJS0xzb2p1N3FVcm1rQ3dmSGo4T0J1SU83K0pUa1g4?=
 =?gb2312?B?bmd0OUV4MzJuQzNxMW53Z3hoa0t3dFYvenNhaHhrdXJuV0xub0tFYW9kMG1o?=
 =?gb2312?B?cERnR3B2MWtsT0lxeHIrOTA1VVkweHhtek1JdzNjdHRCbWJDTjcvK0tla0Nt?=
 =?gb2312?B?SGZ6czFsR1ZnTGphOVFoc3o4OEZzTWNCakpzWFVqcGNaRWQzelB3cVBuMU95?=
 =?gb2312?B?QWp1bXUzeXdKT1k1enVhbTFSRm00dE92UWpUNmtsSDlrZ3FhcXhvL21jMFNC?=
 =?gb2312?B?K1ZRR0NQblNvL1JPMVU2eHlia0FiRlNmWFJUOTlXQXNEZzNHRnQzeVVMZVZr?=
 =?gb2312?B?aERFcVZkNXBNWExlQktiMStBOVRlNm50MU1xUE9scVFHZzhhZlV3cFpYaEcw?=
 =?gb2312?B?UlpJb0szbUR2UndnOGtGRytoa2NJc2NHNkV3bERCQ0c5Yi96cWdJK1FaM01M?=
 =?gb2312?B?OG5pSm8zMGRQalRVdENIUDh0T1RFVVRkK3lyL2NTbGRDaVlDNEhyS0Zob1di?=
 =?gb2312?B?Q3R4UVpiZ3d5UkRSdG9MYmxselhPbXJKMjA0RXlURm5XcnAwYlBhQkxKSkdL?=
 =?gb2312?B?Rmt6MTJNR1luTmFHcDcxRFRPejcvZ2ltTjU3NE5iVGRCQnZXdnBwamFMemNQ?=
 =?gb2312?B?cm84TXk2RklDZW1XY0xFaDYxVXVwODZxUFNhK01WT2dWZzhtRGpMS1QyMWNi?=
 =?gb2312?B?NEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c0a395-4373-44c3-e2d6-08dc18ee2d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 12:57:22.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFddcfI2auLcxVREpGuhz0Sd3rF20u4xn0SdxdRH9KJaby8PyTevFpMOXjq14d1B7cBd/LO7wDgrzuykWnvnzUlnMyojY5Ey4ocxKE+afQASa2djCZHyWvBB3AMQcRzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0592

SGkgLCBDb25vcg0KDQo+INb3zOI6IFJlOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogbWVk
aWE6IHN0YXJmaXZlOiBNYXRjaCBkcml2ZXIgYW5kIHlhbWwNCj4gcHJvcGVydHkgbmFtZXMNCj4g
DQo+IE9uIEZyaSwgSmFuIDE5LCAyMDI0IGF0IDAyOjA2OjM4QU0gLTA4MDAsIENoYW5naHVhbmcg
TGlhbmcgd3JvdGU6DQo+ID4gRHJvcCBzb21lIHVudXNlZCBwcm9wZXJ0aWVzIGZvciBjbG9ja3Ms
IHJlc2V0cyBhbmQgaW50ZXJydXB0cyBmb3INCj4gPiBTdGFyRml2ZSBKSDcxMTAgY2FtZXJhIHN1
YnN5c3RlbS4NCj4gDQo+IFdoYXQgZG8geW91IG1lYW4gInVudXNlZCI/DQo+IA0KPiBEbyB0aGVz
ZSBjbG9ja3MgZXRjIGV4aXN0IGJ1dCBhcmUgbm90IHVzZWQgYnkgdGhlIGRyaXZlcj8NCj4gDQo+
IE9yIGRvIHRoZXkgbm90IGV4aXN0IGF0IGFsbD8NCj4gDQo+IFRoZSB0d28gYXJlIHZlcnkgZGlm
ZmVyZW50IQ0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQoNClRoZXNlIGNsb2NrcyBldGMg
ZXhpc3QgYnV0IGFyZSBub3QgdXNlZCBieSB0aGUgZHJpdmVyLg0KDQoNCg==

