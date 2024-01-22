Return-Path: <linux-kernel+bounces-32293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C528483599D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7477C281ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6A1859;
	Mon, 22 Jan 2024 03:07:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2088.outbound.protection.partner.outlook.cn [139.219.17.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF37FA;
	Mon, 22 Jan 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892843; cv=fail; b=IH6peLBO9/rqNcb6tdrjzPTrURFrgebrrIszcHCOTI+lzvQNJFQRp8USxvjOU/y7FaZGrBPm7OxmRUZgN+gMjf1nKoXKi8Br8HWI6fI4Q1aP3c3kCdiLXezLKlhPhOJDUI9L1fYvWJMYmdCyr2FrQeg9ZjfSzyDFOpY9QwHXDo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892843; c=relaxed/simple;
	bh=ydVI5f489jD/xG4iuTRnvfHsxFu7GpTr44frS69nH40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zh7rQ4LkyZ84lCjJYZRydcxmGK7jGkUIbyxIaj+9mphEwIna+Z50onkSvScq2kcJ76KYxDaLV6NABUGqKwPGIX24+snZXuCpOfdFPUmCjERgzIeP9rFmW8aTy6ThTsXRIUoPfsTlFnFXYzX03ms1UexqNDCZAcxB979hK1LH0jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebGI955NjbfqAavMTU9D//gLQz6exEHyjMfIycPOyAWfNgDruPgXNez0T06k8HpJ3iBMlNDgydmJAQnK3lvM41NW7ss7tQqZyv6LwhcinB4/cq50+YyYgoGC38Ga2v6QrunVPPO2U1nTVm6AbXRD7SkbWxmvC8x/yl0kr6VuTpCN5E7Yc1USsBeuckeI2ZnfUh13rEzW/xAiwx4qb8Z5+CjqQkcZs8M4zdrI3eEor30NJ0MCJb/k3QhTriheovSpqRM5osLZYeQgr4phInoLxFDsBcZp2APJ7TB99JJAr2zk8a7k9PdIvbaEFzdmTdSvQOy9h3umNUYxW2UVtVBylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydVI5f489jD/xG4iuTRnvfHsxFu7GpTr44frS69nH40=;
 b=nKZ2gSHl1OnFMt/wlzyA+OAaZKR00C91nFcDmZvc/EQMSSAW2RZZ7jqNwL4Jrx8xfuD0cggx1U0210C4LrooVwD4O94bHaRnOnO3uWPtMj5k5yeedbqF03vk+ME9kfN+tzO/ZnYPgdz1GECyQMuycY+6wesA1+VMC30LugGgQRXFVVW6dXtME/4VdRE/PM11mEVv4cFEe+RZl/3CyasRY+fItLwRgKWWLHf6z2tTKp3k4N5oCSSCbMB4QKBOIKeE8VpAgZRqt5L0W6RdS4NMF1iZzuyf6eg+/D1k0GbyM6/XQEgQ8iyKSmfL9NIrkoG+0ZH53Mv8BgLdJjvTUayNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::21) by BJXPR01MB0549.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.32; Mon, 22 Jan
 2024 01:33:57 +0000
Received: from BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn
 ([fe80::5d18:ac28:b012:299d]) by
 BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn ([fe80::5d18:ac28:b012:299d%4])
 with mapi id 15.20.7202.031; Mon, 22 Jan 2024 01:33:56 +0000
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
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdzOiBt?=
 =?utf-8?B?ZWRpYTogc3RhcmZpdmU6IE1hdGNoIGRyaXZlciBhbmQgeWFtbCBwcm9wZXJ0?=
 =?utf-8?Q?y_names?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogbWVkaWE6IHN0?=
 =?utf-8?Q?arfive:_Match_driver_and_yaml_property_names?=
Thread-Index: AQHaSr81E8nk9BtrhUGN5g0sexXYkLDg67gAgAAseFCAABFwgIAD5i7g
Date: Mon, 22 Jan 2024 01:33:56 +0000
Message-ID:
 <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
 <20240119-despair-festival-59ab2d4d896b@wendy>
 <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <20240119-preamble-calm-7724e17fcebc@wendy>
In-Reply-To: <20240119-preamble-calm-7724e17fcebc@wendy>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0662:EE_|BJXPR01MB0549:EE_
x-ms-office365-filtering-correlation-id: a38cad0e-6cee-45e6-82a0-08dc1aea3380
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6r2LJ+aKQAZjuCtEWEkG2quCBEquD+/2TVV7jy0uu+MPU0vch6dWhWeq+ZUZe0c0k1EsYSW8yYABJdWIxxaVgqaRY2bnNVK5Q7iDH36JC5xJwiXOLBbc8LBKT+4M16CDd6qn+lN/W7mCPzBfcX9cHZgRdCYOs8SPdmTDUIIvO8cTl21DIz7QZ9t8IGyjuPx65ksGqp/ToND+RrTu1eAF1taPc3HARFCrv05WeKpEhjTreH44t/ScKvhxCDx7PtBJjoMRe+Hhd0yxTqVjolo9mfS0CjxAdDMibc+KLb50/oBW4bnrjgAjMlPMTCGa9VURDJmBHrR+vSajc8CrE+azHqnQPgM8w/avl+CrwRKfhzVmrXH/oENNxKo1y41WeXFcMuMidI0aEM631B3H9S6snKD8uK5htE020XS5inn/K6vgLTq9msXj729iBq63QMiEqcHbQpu1RaFIcFgRl2R9s7iLUA/TS0Lc4LUkBFViACa+lDeI0orpwg6rVPxHsCBLurWpexuUb0lUAjGH9dck1IUDFnoZTnUTJ6CDFqZ1AUpPyBg286ITRU18ZZutgcRZXBbhawJYrRZE5rAeqHsl8bdlCQdAmBq1tEyUolJqhbI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39830400003)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(41320700001)(55016003)(7696005)(9686003)(40160700002)(71200400001)(26005)(38070700009)(38100700002)(224303003)(41300700001)(40180700001)(33656002)(86362001)(8936002)(44832011)(4744005)(66946007)(6916009)(122000001)(5660300002)(7416002)(83380400001)(4326008)(2906002)(76116006)(66446008)(64756008)(66556008)(508600001)(54906003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1RPRWVYdVA2NFZvcWZJSVNtcGtESVF4VldRQ1NUU2tseWlHSE1tVThmZUlX?=
 =?utf-8?B?NFhDODNLSXl5QnFNdmg3SFl0ZzNTUmJWT2hjTkpzbmFUSFczeFdsWlQ0T3VB?=
 =?utf-8?B?VXl4RjVoY0xPbk9kb2NkckIrcXl0cUtYNWNTT0xiTVJqYjZEYnNpOCs0L3JW?=
 =?utf-8?B?eUUvNExuWER2NW9CVHMwZW55Z3JsNWRwaHZ2RjM1MmwwNlBTUU5waXhuQ29O?=
 =?utf-8?B?YXlaSWxZZitzOXArNzJTZFR6M3BYZld6SjFrZm80UkZYZHZRZGNQOWdCR2Rs?=
 =?utf-8?B?UnJPc3lHYXFuRTcveDN0M0ZpdDBUVjdYNTdzVDZ2UlgyZXlkYndZcjQyTFJU?=
 =?utf-8?B?U25vMnN5NlhKR3JoVFVZR0xMUGd0bkh2amIwTmhZR2FnWXAyQjdpYmNNTnFM?=
 =?utf-8?B?ODNWMEpJZ0d2MnZUYlpUYjgwZDQ0NGcrcTZFZWk3RDhWVkxOVVBXSS8yV0NT?=
 =?utf-8?B?Q2JlTjY4ZmR2aHA0TnlKbnNkWWFDY1ZZTTlqZ3p1VVhsQ1BlckgzaDVNaTgw?=
 =?utf-8?B?UFEzQ3hWRFhpVUdtdlVlUDZyL09oU2sveCtLLzFPRzNPaFdIMmQ3UGovRmlO?=
 =?utf-8?B?TU1nTTF4dFZLTVVkVUx0bWZib2VDZlcvN29wMTR3STFkeiszdEFHekVrZWQ2?=
 =?utf-8?B?MDVyQ1pLa2grVWNQWmY2a0Z1Z2NpSC93NURBcFozTXNJZnh4Qll6a1VpRzhq?=
 =?utf-8?B?YXMvK3RXNnBZZFVLbTFKNEhBVVZvb1l1aE9sRDJ1RnBrTWFqYzhGbzIxWkdl?=
 =?utf-8?B?TnllblNXK3lLRmFrZGh1Um1PWkFNUkhpMllTVG8zTml4VkFlU1FwVnpZWFZ0?=
 =?utf-8?B?cWUwRzZkdlJWUElLKysxUDhrOTVkVEhwQmRTTlMyNWp0UEFHMDFId2N0RVR3?=
 =?utf-8?B?Snh0eDhHZ05QOTZWcWFVS1VteVZBRytGMHdTQ2F6L1A3VGYvc2FKS3FCZFlo?=
 =?utf-8?B?bUlRMVdDUTk1VU51VGQ5WnhaUUs0QW5JZmJDc0RwZG4yV1ZmUVNuZ2dDa3F5?=
 =?utf-8?B?RnlCa3pUR0tGQmVPSERjdjQ0S1FhaHAvRUpRdUFxQTk2NWN3MDhYdTBqb3Rt?=
 =?utf-8?B?ck9LRTlWbDFpWFR3YnhJYkljWDhIUUcyT24wQy9xNzdWYW9IWE1qUUtZUkdz?=
 =?utf-8?B?L1V3V3pQK0VVenZLbERxWkdZSHFaK0dPWlozb1JWV05sdGhHSmltMjZsNDFo?=
 =?utf-8?B?ZGtDZnJlNUFQekpJbE9SNmN5L3dHcVJ1dXlFUkthZ25KRUgvSW84SjNOV1pu?=
 =?utf-8?B?N0tXYS9NQURSTWtwUFRWQVQxL0szMHZpaUlXRkxEV2NMdU1BbWpCS3dkakpP?=
 =?utf-8?B?eE9ybkRuOTk2TzFYcEtuWXl3TDAvbE9NTGxuYXJBaFYxenFMRUxqWkVNV05w?=
 =?utf-8?B?VDQvakE0Wko3dENaRldvbHZOYTBjK3dsQzAwQjNjRThnQ2VtVHVvVHFyZlBx?=
 =?utf-8?B?SHAwZVlteEVLbllwVHJwa0tmN3ZMOXRISFFTSDJZc2ZMWWxEVExVQlZWSkR0?=
 =?utf-8?B?cTlKMU05dEJsRTZTYjFrc0J0K0JyYjl4TFVUTGRyUFl5UXN4NHhKaFV3T2Z4?=
 =?utf-8?B?Q2hMRDU3UjB0V0daaHhkY3ZENHAxWkxrUmxSK3pvbGNiblkvUXhEc24yTWhB?=
 =?utf-8?B?ZEtXdmFqSklXc3JVdEVBeVIyem5RWFlvWDYwMk8wV2Q1d0dEOHV1bm5OOXRu?=
 =?utf-8?B?ckEvbURMbFl0endzQWROVEZ5cFRpQzBLenRsK25XOGgvNy9CR2VqVUM4emhH?=
 =?utf-8?B?YjFMUmJiaTNNbWxwSHk0THAydlhaem51bnUrOHNyNVgvUGRPNlFPM2s3MWp3?=
 =?utf-8?B?Ym5ZRzZWTTkyZWRub3lSWW1wUjVxd09JTitFRVc5bXppU2FqRmxZMm1rSzZU?=
 =?utf-8?B?cEtNYlFoMHBKclBzRFQ4TU1PSEJ2OU1SZkNhYjg5MjNUVFgvVGdueEVvWFd6?=
 =?utf-8?B?Y2cyQUhQNGlFMjJUUUlCdVN2Zy9IOXh0eDRab1VmbHc2czVmV0R2R04yM2E3?=
 =?utf-8?B?RkwzS0RISzJoNWpOaXlBQmdUbGU4U1J1VlBUSWJ5NzE0czJkb2M2dU9INkFG?=
 =?utf-8?B?cktYVFhTOXEydmM1UkltYWVYQ25VNEM0QnZsSnM2ZjhOUVV0UWU3aUY0YTlo?=
 =?utf-8?B?K2RVclZna3d3cVJla1JLOXNhSHRoSXhrQnNUVG56TVBqRkJnTCsyUzQ4QjVu?=
 =?utf-8?B?UFE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a38cad0e-6cee-45e6-82a0-08dc1aea3380
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 01:33:56.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKp2vAwgf7AqHn29cXcZTL+dVtXr0cKzUjKfZtAP19m+ooU5gaboQvzHyxEYU1Msk2zjTIHTDstMVJAWtU6s6d364jJCYFptpiAOpZtomM4BMHeQUpu/4b5djr0HRqAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0549

DQo+IE9uIEZyaSwgSmFuIDE5LCAyMDI0IGF0IDEyOjU3OjIyUE0gKzAwMDAsIENoYW5naHVhbmcg
TGlhbmcgd3JvdGU6DQo+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPiA+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gPg0KPiA+IEhpICwgQ29ub3INCj4gPg0KPiA+ID4g5Li76aKYOiBSZTogW1BBVENIIHYxIDEv
Ml0gZHQtYmluZGluZ3M6IG1lZGlhOiBzdGFyZml2ZTogTWF0Y2ggZHJpdmVyDQo+ID4gPiBhbmQg
eWFtbCBwcm9wZXJ0eSBuYW1lcw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgSmFuIDE5LCAyMDI0IGF0
IDAyOjA2OjM4QU0gLTA4MDAsIENoYW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+ID4gPiA+IERyb3Ag
c29tZSB1bnVzZWQgcHJvcGVydGllcyBmb3IgY2xvY2tzLCByZXNldHMgYW5kIGludGVycnVwdHMg
Zm9yDQo+ID4gPiA+IFN0YXJGaXZlIEpINzExMCBjYW1lcmEgc3Vic3lzdGVtLg0KPiA+ID4NCj4g
PiA+IFdoYXQgZG8geW91IG1lYW4gInVudXNlZCI/DQo+ID4gPg0KPiA+ID4gRG8gdGhlc2UgY2xv
Y2tzIGV0YyBleGlzdCBidXQgYXJlIG5vdCB1c2VkIGJ5IHRoZSBkcml2ZXI/DQo+ID4gPg0KPiA+
ID4gT3IgZG8gdGhleSBub3QgZXhpc3QgYXQgYWxsPw0KPiA+ID4NCj4gPiA+IFRoZSB0d28gYXJl
IHZlcnkgZGlmZmVyZW50IQ0KPiANCj4gPiBUaGVzZSBjbG9ja3MgZXRjIGV4aXN0IGJ1dCBhcmUg
bm90IHVzZWQgYnkgdGhlIGRyaXZlci4NCj4gDQo+IFRoYXQncyBub3QgYW4gYWNjZXB0YWJsZSBy
ZWFzb24gZm9yIHJlbW92aW5nIHRoZW0gZnJvbSB0aGUgYmluZGluZy4gSWYgdGhleQ0KPiBleGlz
dCwgdGhleSBzaG91bGQgYmUgZG9jdW1lbnRlZCwgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBk
cml2ZXIgbWFrZXMgdXNlDQo+IG9mIHRoZW0uIE5BSy4NCg0KSWYgc28sIGhvdyB0byBhdm9pZCB0
aGUgd2FybmluZyBvZiBkdGJzX2NoZWNrLg0KDQpUaGFua3MsDQpDaGFuZ2h1YW5nDQo=

