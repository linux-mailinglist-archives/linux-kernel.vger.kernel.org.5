Return-Path: <linux-kernel+bounces-157028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D88B0BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640D21C20C86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120E15D5D7;
	Wed, 24 Apr 2024 14:01:01 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BF15AAB6;
	Wed, 24 Apr 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967261; cv=fail; b=d3sqBzSG6XA4KYhWjdKw3Zg+ci6TUBRl9dWfCSjTBp9eXAQtydaS2t/Jr2dz1zxurSsOT5UaaZt6CLCGe0ELhAvlUccE+BZUl47IHV2C9PFjEvBGHs4zjvZUx1YlLmUXC2yxx29aRULZCUyKmKEP5ANIYCHx1gmNUg69e/jEK8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967261; c=relaxed/simple;
	bh=sb0lJv1v6SgSykNtK0JoYbbslX1An6zjL8VRmNNBaDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OeHgJNkg5v5Ss3EnBOhU61RGC0Lvt2QZMeBUOZiSLOcjxPzgH9YHtjRyqSZ/AT1Wx8TqR6PYAW4QEkHf9W56ZBvsmBZ+s3gkAsMrroFrNjDKdFPHGyh+MKSMq+DCPFJ0f0t605VXcCyawLJJ/8euegN8XKayTZOs6+/WSxqO+Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcjDBezAVTjCHI30gjuT2y5zJxGcILCnMtDaeAgVD2Np+fK9qfWLftW7G+xw7d5i5aApJJoLIHitzCaqMKWLOX8uL20AwDguYq5/m+u3jSxACEY8R2iO3cHV12lrZV841uJ/44SARZhXaUJJiFci29Z/nXQlDiQMXb30hjnxqmAeTYUMEzyKe+qowFl8QPXO7mOE1Ds62pjPH55zC6CmbRZ5TV1btewjbfSG29D9tSQUHnYUtcwN36Q+sMInP8KV5Lt0xThK8lAVvkR8w3EkVaAOj4eQSFAGkKaVHiA62JxichNFpIFFA2Y7zf5eBG7ChcvLWtZtquCsMiY2Kq6rAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb0lJv1v6SgSykNtK0JoYbbslX1An6zjL8VRmNNBaDU=;
 b=OAPqUpsa/pLCJX6GBtOYwXLNwl9LwZ5pXUvGzGb+4IV44+A0stenJi0/gEOjaINCaSjIEW9iAHBrB+D9Zg1Ob/SoaUnZaV8SN3Gi55eH1pdQDT6F01veCPreo3URPiC5BHLn/JQFYaHsHCHmE+1CEvwqtbCix9rgQQpiI5jiB2nQyr2k46YcaQJXgp2900JZgeRA9Mhfi2YBXkt9td2/6tlXthOjD5ABdqw4HkGs904a7M/gu6VQSa/+7QqGv9GLLLis28hEwBu45qlAB4TriqB/8MUEpCqvzpH5cOvQ50vcxoZ5mIGPf9BNoelJK50M175aBfOujq2Rmt3LpvJXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0732.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 24 Apr
 2024 13:45:02 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:45:02 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>,
	Joshua Yeong <joshua.yeong@starfivetech.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 0/2] Add StarFive's JH8100 StarLink Cache Controller
Thread-Topic: [PATCH v3 0/2] Add StarFive's JH8100 StarLink Cache Controller
Thread-Index: AQHalh1L5wyUsS8uPEy7rWDMd1lKELF3MBQAgAA8cqA=
Date: Wed, 24 Apr 2024 13:45:02 +0000
Message-ID:
 <SH0PR01MB0841043563C57D877E0D682FF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <CAJM55Z9hObw7T=Z92w_5pYVcuR3UDW-Mas5YpCoGv4Y5s5M9xg@mail.gmail.com>
In-Reply-To:
 <CAJM55Z9hObw7T=Z92w_5pYVcuR3UDW-Mas5YpCoGv4Y5s5M9xg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0732:EE_
x-ms-office365-filtering-correlation-id: 35535004-2d49-4e8a-430f-08dc6464bdad
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zJuYqVJQ+ig2zJz7/IAIou1do3RiZZvoet3vw86JFZ7PnKOHNdph416KPWgvvmOGHYcgcOdkMicQc0AKjrsBvspa/ONukLrRs96k8b/UBkKDEfT/NJLKLjXZ7HW8qaLq4fqxAgaoSJo87JEUSL0uLiB4KkQH8ozsDu35YrJQi7g2YoDDKTzxTsfij3PoYRuQefkpjGQcGamP0Hqag9nUcTqKZcuY4hkWOpREmViXXAT0NwGD0NFA0i6uOvsrCWDrPAhHxLikJFc6bpfhKEqbprwS4krNL1fHkIx3KKMM3rpZaB656WvHj7XFz5pDdiPzqmi3qBPapY5u1bzS+qUgxxtg8vu5tk0H1Imn3KVohJ7YdVM391NY+JR7Mu0AC7oEVjuXB87w8LQfPgZrcKO577/ipemUXUUUjupQzfxArnC3JZ16nMWyHg2Rq5pjopO2wKM+2F27Pyj3ZhvhdQpzPycwrqfCF0EslSgIwyTIW/YgleSb05q0H4JQpcxm/F/pvOQs2GMYXAg8nSRCL5rRZDetchDTg89U9WOxSXjhAHS5l5Ml3cW8A4V4p7W3YASUzr+EV+S15vHLo7DLez8gMg8K4IoiNd2NUwVjgXgGwDpB7H6UAZHtGXa2amgdlMv75QsSa7QbXVE3k+kbaT4XMA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDJwdm5VK3FnTnR2MXpsZ1FDR3pwdzBydVBTNFVsMXN0MDRMbkZBTTA4Mi90?=
 =?utf-8?B?Z3cvWXdXMC93eE5wcEp5Wk5OSVpsQ0RiMWRYU1lHaUdHU28raDAranpXNHE2?=
 =?utf-8?B?bzRiaUIyMjRCRGllcWF5QlRCY2ZpZW8vTnpLQjJTblBLbGJ5ZlpXTlM4djBB?=
 =?utf-8?B?VnF4SVkvbVVIbk1lR21vSnhmbGViaWdWVlJZblRzK0lnVDdJYlhndTVFYUdv?=
 =?utf-8?B?UlhnMk41RlMyb1JqcFVQYnh6cDVlRXhBZW9yZExzWkszZ0ZOdlQvVENnSDVY?=
 =?utf-8?B?bmQ3ejMrVG1vcFRPUG9lNHFYcUdTRW9kdWRScmM0V0oyd2dSNTdHMlRwamdo?=
 =?utf-8?B?UVJzTkphOUlnSUxHMWlMVzBmM1puVm5nMUtrU0tJQ3BMV3dFT0NXU1M2NXph?=
 =?utf-8?B?ajFtbWxqdmFZb0pZaTZtYU5wNzVYcEwzdXJDZUxsOERERE1xZTVyelUzL1Zt?=
 =?utf-8?B?K2hkbXQydEIyV1RkR0c4WklKSzV3SEljNURmYitUSGRESWlQeG5Yb2tvbHo3?=
 =?utf-8?B?NVYxTmNmSFVWZUxQaVBXVWJQMThzNlAyUHNDblVNM2NGbnZ6Ui9BYlhUL05Q?=
 =?utf-8?B?b3J1TXgvNGUxRTd4VXVCREJ2QVZ6cU5ZdFVGOEg4b1B5SGRNYmtKV0Z0aHZm?=
 =?utf-8?B?dHpBR08vZzQ0ZjdBeVFCVG03R3pkM2pSSm5kTXo1SUNCcXVVemdXOGVPbWpz?=
 =?utf-8?B?VUgwbXl6dFRWZm1yMEQ1eTcva2RkM2VGWlRKTHhWaEJqdk5IalNHc3hNQkJ5?=
 =?utf-8?B?MVdndDllbG5tVTcybjdWU3ovd1FhNE1BT3JZTUltNVR5TklldVBNdXV4b0h6?=
 =?utf-8?B?SzV0M1ZqTEowd2JLODZMQTVsVUNmT2ZwVUhxVTJGdjhCNk1DWkJJeHVNV0lh?=
 =?utf-8?B?UGZkOUVvVmh0TmJ1WSt4NExSbkhaREs1di9zWC9qOXVyRTl3WkUveTdheHEz?=
 =?utf-8?B?NWs4MmtjRlRNMmk0U1ltZEVUYU9ORmJOQVdENEY2RjdVcHgvN3NMWWRMbzhl?=
 =?utf-8?B?T1ByR2x0N1NCZ2VEZ09Mb2I0SEtlZkR6RWNheGRqNTAxY0hrRFhHQUhvYysy?=
 =?utf-8?B?MnE4Wmw3VWNPUlJ6REdDRmVtMkZYNU9KS2FEbHJKV1kyMW01c0pRT3JPcG5Y?=
 =?utf-8?B?dzYvWC9vQndGSmpnZ0VHdHo3TTRaTkNtY3M2RlZCajRWZVZqYlVVYitPbGhV?=
 =?utf-8?B?MUlYcVdtclRZQVZmUk1sT3U5UW9GMWNIbXRDTGswN21YbmZPN2srci85cnJP?=
 =?utf-8?B?R1hhd2pEbUg1Tm55YnBRV3BBZmFnODE0UkpndEt6UWsrY0JBNEovT2xXQVZp?=
 =?utf-8?B?VEpURTlBWDlMNmxIcnpXeWw2c1lIZHNXcFV0ZmxaNnNWVGhpN04zNzVnOGQr?=
 =?utf-8?B?QWhXYjZ4Y3R5Y3BKcVRDUFFHcWRHOTd5WmFMM1JBZVc4ZmY2R3FLQ253cklx?=
 =?utf-8?B?V3Fuako5aFcrS2Z3S0M1cFh3TmswNW5RejJIc1VERWY3VG5VVXlvVkpybmhN?=
 =?utf-8?B?MWpERGNBMmVMT3YxazdyYlhya3RpL1BpZE9MTUJHVk4yL2VhejM5Q3Y4a0s4?=
 =?utf-8?B?OUVDZSsvMTBNc2NYZXdhbGRUdFh6NXBWd3c2UnI2emxsMlhZcW93MVNuU3h0?=
 =?utf-8?B?eXkwRDdDaVQwSE1TbkRKU3BNUkpNdlpKeTlTNTZJUFB0R20yczAwdEZmK0J5?=
 =?utf-8?B?NHlyWDl2UHRxd3dKWTRpNUZ6c1NvOFJKeFYyMFMxOGdJSzRKbkxpYlNxUnBY?=
 =?utf-8?B?Y3NaQXVKV2VWK3FoQXJBcmpNSGtEejVYakFZcTF4WkNjMzlnOGZaOTNrNjVr?=
 =?utf-8?B?WXl2OElXM2hCZ2JuUnkrVFcvYW1ob29OOVJDMldGSkFYRkMycU5ocm5NcnAr?=
 =?utf-8?B?dHJLOVRlcG9BZytXcHVuSmdhcVU2WEpEZ3RSdnROc3ZQS01MU3B6ZWZRZEt0?=
 =?utf-8?B?WTM3UHV1WGQwZjZTRUJ2V0VSQXcxVkJSa2E0N3V4RHNVUHJVdTRFSm82U0dM?=
 =?utf-8?B?VDZ6WGFEUzJ5eVExVTJUQlhZSDBDOUlZTDJYTzY2VnJkOGU2VjlzRHplZndp?=
 =?utf-8?B?Z08vL0NuYUxoSHdISlVjTDJKZHk2RERIWnk5d1Zja0RPRjdxeFlRVVZORXVF?=
 =?utf-8?B?YTNjMDdZNDZ3bFNtbE5renhOM2lQNGdPRGZmQys5RlRlK0RxTWlIdE5nYi93?=
 =?utf-8?B?V1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 35535004-2d49-4e8a-430f-08dc6464bdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:45:02.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1duhJ8cwLTPhQGd25AjdPvhsIa0OVAAcVnztGbaB0KDawENKWZ7tTg1SRJxPl96MXAOMSYjIQH2mml/KjWi3Vw01Wf37oxToKD3PDq/DFNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0732

RW1pbCBSZW5uZXIgQmVydGhpbmcgOg0KPiBKb3NodWEgWWVvbmcgd3JvdGU6DQo+ID4gU3RhckZp
dmUncyBKSDgxMDAgU3RhckxpbmsgQ2FjaGUgQ29udHJvbGxlciBmbHVzaC9pbnZhbGlkYXRlcyBj
YWNoZQ0KPiA+IHVzaW5nIG5vbi0gY29udmVudGlvbmFsIFJJU0MtViBaaWNib20gZXh0ZW5zaW9u
IGluc3RydWN0aW9ucy4gVGhpcw0KPiA+IGRyaXZlciBwcm92aWRlcyB0aGUgY2FjaGUgaGFuZGxp
bmcgb24gU3RhckZpdmUgUklTQy1WIFNvQy4NCj4gDQo+IEhpIEpvc2h1YSwNCj4gDQo+IEFzIGZh
ciBhcyBJIGtub3cgeW91IGRpZG4ndCB0YXBlIG91dCB0aGUgSkg4MTAwIHlldCwgYW5kIHlvdSBz
ZWVtIHRvIGhhdmUNCj4gcmVwbGFjZWQgdGhlIFNpRml2ZSBjYWNoZSBjb250cm9sbGVyIHdpdGgg
eW91ciBvd24gaW1wbGVtZW50YXRpb24uIENhbiB5b3UNCj4gZXhsYWluIGEgYml0IG1vcmUgYWJv
dXQgd2h5IHlvdSBkaWRuJ3QgaW1wbGVtZW50IHRoZSBwZXJmZWN0bHkgZ29vZCBaaWNib20NCj4g
c3RhbmRhcmQgaW5zdGVhZCBvZiBhZGRpbmcgeWV0IGFub3RoZXIgbm9uLXN0YW5kYXJkIHdvcmst
YXJvdW5kIGxpa2UgdGhpcz8NCj4gDQo+IC9FbWlsDQoNCkhpIEVtaWwsDQoNCkkgYWdyZWUgdGhh
dCB0aGUgWmljYm9tIHN0YW5kYXJkIGlzIGFuIGltcG9ydGFudCBleHRlbnNpb24gYW5kIGZ1dHVy
ZS0NCmRlc2lnbmVkIFNvQyBzaG91bGQgaGF2ZSB0aGlzLiBJbiB0aGUgVjEgcGF0Y2gsIEkgbWVu
dGlvbmVkIHRoYXQgdGhlIENQVSBjb3JlDQp1c2VkIGluIEpIODEwMCBpcyBtYXR1cmVkLCBidXQg
dW5mb3J0dW5hdGVseSwgaXQgZGlkIG5vdCBzdXBwb3J0IHRoZSBaaWNib20NCmV4dGVuc2lvbi4g
Skg4MTAwIGludGVncmF0ZXMgJ1N0YXJsaW5rLTUwMCcgSVAgKG1vcmUgaW5mb3JtYXRpb24gaG9t
ZXBhZ2UpLA0KYW4gaW4taG91c2UgZGVzaWduZWQgaW50ZXJjb25uZWN0IGJldHdlZW4gcGVyaXBo
ZXJhbHMgYW5kIENQVSB0byBoYW5kbGUNCmNhY2hlIG1hbmFnZW1lbnQgb3BlcmF0aW9ucy4NCg0K
UmVnYXJkcywNCkpvc2h1YQ0KDQo+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIEZpeCBjb2Rl
IHN5bnRheA0KPiA+IC0gTGluayB0byB2MjoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA0MjMwNzI2MzkuMTQzNDUwLTEtDQo+IGpvc2h1YS55ZW9uZ0BzdGFyZg0KPiA+IGl2
ZXRlY2guY29tLw0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIENoYW5nZSBwYXRjaCB0
aXRsZSBmcm9tICdBZGQgU3RhckZpdmUncyBTdGFyTGluay01MDAgQ2FjaGUgQ29udHJvbGxlcicN
Cj4gPiAtIFJlbW92ZSBTdGFyRml2ZSBhbHRlcm5hdGl2ZSBmcm9tIGVycmF0YSBmcmFtZXdvcmsN
Cj4gPiAtIEZpeGVzIHdhcm5pbmcgZnJvbQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29l
LWtidWlsZC1hbGwvMjAyNDAzMTUxNjI1LmJvS0RqSEdyLWxrcEBpbnRlbC4NCj4gPiBjb20vDQo+
ID4gLSBGbHVzaCBjb21wbGV0aW9uIHRocm91Z2ggYXRvbWljIHRpbWVvdXQgZnVuY3Rpb24NCj4g
PiAtIExpbmsgdG8gdjE6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDMx
NDA2MTIwNS4yNjE0My0xLQ0KPiBqb3NodWEueWVvbmdAc3RhcmYNCj4gPiBpdmV0ZWNoLmNvbS8N
Cj4gPg0KPiA+IEpvc2h1YSBZZW9uZyAoMik6DQo+ID4gICBjYWNoZTogQWRkIFN0YXJGaXZlIFN0
YXJMaW5rIGNhY2hlIG1hbmFnZW1lbnQgZm9yIFN0YXJGaXZlIEpIODEwMA0KPiA+ICAgZHQtYmlu
ZGluZ3M6IGNhY2hlOiBBZGQgZG9jcyBmb3IgU3RhckZpdmUgU3RhcmxpbmsgY2FjaGUgY29udHJv
bGxlcg0KPiA+DQo+ID4gIC4uLi9jYWNoZS9zdGFyZml2ZSxqaDgxMDAtc3RhcmxpbmstY2FjaGUu
eWFtbCB8ICA2NiArKysrKysrKysNCj4gPiAgZHJpdmVycy9jYWNoZS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA5ICsrDQo+ID4gIGRyaXZlcnMvY2FjaGUvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KPiA+ICBkcml2ZXJzL2NhY2hlL3N0YXJmaXZl
X3N0YXJsaW5rX2NhY2hlLmMgICAgICAgfCAxMzUgKysrKysrKysrKysrKysrKysrDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pICBjcmVhdGUg
bW9kZQ0KPiA+IDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
YWNoZS9zdGFyZml2ZSxqaDgxMDAtc3RhcmxpbmstY2FjaGUNCj4gPiAueWFtbCAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvY2FjaGUvc3RhcmZpdmVfc3RhcmxpbmtfY2FjaGUuYw0KPiA+DQo+
ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4g
PiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K

