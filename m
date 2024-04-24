Return-Path: <linux-kernel+bounces-157133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D47E8B0D40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D137228BD63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3915F3EB;
	Wed, 24 Apr 2024 14:52:29 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6D15ECF9;
	Wed, 24 Apr 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970349; cv=fail; b=LLCL7Esj2QgLsVGRazkz9CfbVYicqRLKCkUFftWqSxaK9w7Lqyel/ndY0ZxsRlxyuJgaf9tsLW6PAvRq8nfPwsXWTZ/bJ+MK93EDtBenIp0sun+oC9vQk6TJJV8ryA4ri9zPdYwEuXdc0Ce/1q+bVrxfVTYHc771LDuNpeNtFwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970349; c=relaxed/simple;
	bh=psfozWF1j154RUelUZXACBziUeN3zSPn6NumkG1oHhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXDAsOwCqId03WU+UQFV4wr0EBY7x2ci3mniTzieuRpFpep4wkTOPjWViZmpOwzVILhgA0bOsCt+Gg1I/MOZm4Fil1eFXu9aWXPCqFDYGagOGVOsaNKt6Ei9+GT3Sfe8apWS54b+QhsPvUrYmEZPclHDthszK3kreuvVPhtx4s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKKM+uYIOW1wGTZijP72PxgrjWMG4aP527lWxguEkL+9JDGSK9r26bfbFAYE6r5EvE6DxpKlqa8p6x+GvaScZy+kiZubvvFT2/K/4NoeimzdS3n5qE0Jcoy96GxdxDbOEjzObjqgafmXhp4WCz4V1p4gKqAQzhgcCtdxxiuzAyF/LilCpIwKx6yy7+Ot0tO273SaLbhdR3FtOBS/TQ+sHEGpQTQbR53QsgC/Air3T/TZobbiez1McslFOspDKU7e25wA8Soc8aSmM/+79JpxPPf8/d1xd+MwFNK3IFyigtUSFUSBKwB/qa4aDzwP9h2ohdMNShVgIUc8INcz1p2IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psfozWF1j154RUelUZXACBziUeN3zSPn6NumkG1oHhs=;
 b=UWfLxwFIeOkSLe23FFqlWZa9ufQpbjWu2NKL+UNdHD6LOn1VAtYwmXFtdFNYucBItGpIj00wYXxeZZi1O0Q86FLVt02sy4wm15XQjCcBBqLNRy2GFprVAbSjSfFByRp7HIhH9a8KZO7I9nI1i05FMGFem8G8219VlQKOup5XWTDSsiM4GRk2eeQgeBAsDEbGjn5v9Qf+HeW4Odg62L4V8zOQvzsvPkSHEwZ2rV968oT1TF1J7DyRgXICi/Wq/KDukzJTqIzqIhcPVofE6tIyGuB612VoIAevgDMCEDraJmKleUA+H2hu4y8+NVb9zN8TMwSGdz0u5k1A5hjJkAHeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0570.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:52:15 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:52:15 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"conor@kernel.org" <conor@kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Topic: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Index:
 AQHalh1PRoL0YjHNUEq+ss3l976a9rF3N0uAgAA4OgCAAAhagIAAAw4wgAAEmwCAAAByQA==
Date: Wed, 24 Apr 2024 14:52:15 +0000
Message-ID:
 <SH0PR01MB08410B2FCAE1D9AA754865BFF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com>
 <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
 <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z_G5EKSjHztCQ+gXDGwfpziZTE=HsHmwydJWB-uorMOqA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z_G5EKSjHztCQ+gXDGwfpziZTE=HsHmwydJWB-uorMOqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0570:EE_
x-ms-office365-filtering-correlation-id: 9e41947f-6e67-4569-bf9f-08dc646e2185
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tRXSMw3sQ3FuwM2WQmfsFTnvpw2HNzJIIHMn5FSL0f9FOeSq+oJKGhWp2OP3qq1l7pIyCckAnKv9guHxZ/N5+xhdjncRahX2BGRQaMz7oDxY6Go/HTnAYUSxjjCQaBv8TAtr8tjdGDA615Ngwq+HgxIn6Ffo6w16SLS/e2PJQQC5gKF9wXqz1qATMvDhToS9+BkYVL/diu2pmRlRmX6fEE2M5UAdJgKD7dVxpEfeqa+pR1H0aN1TrRfgWoZc+y8SGLKYyfLzGXftGeM4j7B9KpaTM057l1LdQz74kH80WcvjtkcVtFffr2198IRwDelHMUdfVtX7Zg8u14oCyffKg5d8JJ0TShlun5QvY5JwRqzcL8aCyHiMSIxTaKbIvtupGtKx3IxRiAFBZCl9eydFhPIiOmM2Xb0KXTcKvUzjLBHEbGH4hYMuRR49+0XvOmsVDpshH9XRKhkUlcuSeDdaff8nXr4pXEgfotj6HFgWrilPO0gwTz8r7qq9is6eDmwRVNToQHhD87BqjWs5upeJvvMyWgYJTlJLysW6wb82LpQsPRv3R4UH5q2nKTG9tRaIsqSHIW6/6c7SXebBo/YaAsFzR1ZzKWw6IHd1jIcmDkWhhMn1Tfht+/RDS6/I8Oe71euEcPcc/SrzEpEMjQ69MQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejdWNVR6S1dEdk5GN0w1dEhNd0x1am1YZFgzbEY4VkZXa3pFTm1pV3JMWXhF?=
 =?utf-8?B?ckJRTWZEUjE3R1NoZktmUCt4TTZKbzJZSmVxZnlsYkwrdGdhSzdaMi8wc1d6?=
 =?utf-8?B?eHQ4N2VpWWFIWGlVUEVsekhKS1pGeUc3NE9zMHBRTFBlSjRSZW9wRVJxTDRF?=
 =?utf-8?B?U1I2cTBzRisrSTc2T2p0SzI1anJ2RTBiY1YxRzVGYlVmSHVIaCtLVWdaM0hK?=
 =?utf-8?B?NVozRkFCQkFyUWh0RkxoVG1EVVlRS3NWcTREOHZZQnJSWXRwOFdLczNrTWY5?=
 =?utf-8?B?aVNoNlJsMFVtdTUwbnUvYm5mYUM1S3FJai9ONjNiWVBLOE55MFN3Mm9RcGVG?=
 =?utf-8?B?SDlZNHdsM3VlWnhGSFlYZEQ3SG9Sc2NLTWU4RWx0MmZTU1pMbHl0bkoyYTEx?=
 =?utf-8?B?MWtpNkNLaVdOMVl4ZWZHc2VMMG8vTUxia1Jlbm1pV29lYU0vblhEbDNCOGla?=
 =?utf-8?B?em43OS9PNmRpVWVxd3pWQy8zZXJUTEQ1Mmd6QVMwcmJvYWFER0dyYUc3UDZt?=
 =?utf-8?B?azYyTlJHeHJNbXNBUTZuaXhlZm5yMnVTUmJ0T09TSzBKYzlaS3grb0RXcFRP?=
 =?utf-8?B?blRsZHovai9nT3N5VGhWUWtuc2lTc3NmVExMdzJlMUYxQnFyanZLeTJvQ0VG?=
 =?utf-8?B?ZnNiRlNKK09Qc0JMNUV6TnZ2RFIwcTNWbUpYcWZBMkhxK1FzODk2SHBGNjlU?=
 =?utf-8?B?YXZiMzFqb3U3RDROU2l2SXlVMktDSjMrMWUwRUQvRHlBS1AvL2I5N1M3RmNF?=
 =?utf-8?B?eFY1ZDBRSU1SeWFWRGc2NzlNYXYzWlBna3lld01mK0FxcVVrcU9ib3JKQUNL?=
 =?utf-8?B?NmFXWDZyT1VoZERoRFdkNnoxWHg2UWdyVlpmNlNXZXhlcU1odzZOUHZ2eWFG?=
 =?utf-8?B?TmJTWHQxV1pSQkpxZHN6ZjgyMnpzWGh5TnRldENGbFRCY3dwTDJEL2hWdUsx?=
 =?utf-8?B?VWVaa1dGUFZLVjVCR3NJL1Vwc0F0TGVxejlKTTBUSy9hSkdUalJocC9ta1FT?=
 =?utf-8?B?U3lrMzQ2djE3bXY4R3JPc2NwbXJmaUQxQjEvQlBRSU5pSjBTQjFhVWFaY1RM?=
 =?utf-8?B?SkhreWUvR3V3cVZWOEFNeTRBMTRKV0dBRFM5VGJ6aDNPZUl3NnVhNWVUMG5S?=
 =?utf-8?B?WEZrNFdWNGZGUFdEQmo4d1JyYlBWNWw1VmdETUE3SmZVY05IZHIrMENTU081?=
 =?utf-8?B?U0tuRU9IZEJsUjBTN0Zmcm9pVmUrRjBhQ0VTc2NKdHJmZ1FtTnFLUVlFTzZ5?=
 =?utf-8?B?Y3NnWTdIaldjL3lwMG40UUE2WDFoK0JIdVhZZ2E1RS9RYm05UTg0ZUZxbXhB?=
 =?utf-8?B?U3BFMW1iQ1hlUzJZYXlCVXVNZFhVbGJyTDJHa2hEaklPRWJXWThTZmlLTnN1?=
 =?utf-8?B?QnFPTUw4U3RqcitOVHdHTHArWVRheldQTXBZcGN5QjZ6bWFOOEMvQTlXYUxy?=
 =?utf-8?B?cUlrUGM1VThWcnVsbG9lQmVsMCtTM2ltUWVxUVg5b1d2dXFGSThLcmFLYlJM?=
 =?utf-8?B?amxsSWsxU29wRWROelBGcFRQb3A5WGJWWTVzTzJWemgxQlRZaU5zV0xxRDBI?=
 =?utf-8?B?QXh5ZUdtNytOWXJ1QkJoV24wYWt6V3V5Y2poVGVPN3NYclNsSFFLSGtjV0tY?=
 =?utf-8?B?aTJiSzRqYkdzRFFHalhVa1pSYi9EOU1JWlYwSzVGTnRqMVB2Y2VybWpaWHlS?=
 =?utf-8?B?L0VlWDlOVkJRZDV0RE10S0NxQjZneTAzQWV0RVdWRmRjRFVHWkp0VGhtWmRp?=
 =?utf-8?B?TjdrQXRmcHhTRHRhQVh0WGZBM2lYck4xdHBNMTdRaWJFUkxpb0JCci9XaW91?=
 =?utf-8?B?NUR6bFNtbTB6Z3Bqd09ReWxzcDBNR1Vuc1B0OXU5RTNuckVxVlBWY3J2NVB6?=
 =?utf-8?B?NUNLR2RqWmp4dXlwaFB3RWtOTlR3QXRZYzhiVS9abVlZRm5CTGFxa3E2R0Ft?=
 =?utf-8?B?QlRzTUtxUFN4UmlqODg0NVVBdHVaamphZUFWdGhGVWROMkpVTk5TM2N3RHkw?=
 =?utf-8?B?a2VVV1plcVkvcG5IWDdvZFlweEl5NXZDZFFSN2FnN0lHeUZwWWFJQW9PZ01D?=
 =?utf-8?B?eWdyb205MThRZDgwbG15SG5GZ3FTRTJHRWdSSW1tdHJ2eXV0L001bU5vaHho?=
 =?utf-8?B?bEprL28zbnZ2Y2llRXRzenVzcEFPMnk5ajI4T2x1dC90Q0ZkNmNPdlFrTnhG?=
 =?utf-8?B?WVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e41947f-6e67-4569-bf9f-08dc646e2185
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 14:52:15.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCGhR5I2K0/MYupoWLx3ac4tx0z2rvchOQ9DD2RDkPINxfpFHWGerMQ96Mblw4lvAroK3mrOI6vwfVBAnFy/34rfwmUyWjMmBSLqSelGIaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0570

RW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+IEpvc2h1YSBZZW9uZyB3cm90ZToNCj4gPg0K
PiA+DQo+ID4gRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+ID4gPiBKb3NodWEgWWVvbmcg
d3JvdGU6DQo+ID4gPiA+IEVtaWwgUmVubmVyIEJlcnRoaW5nIHdyb3RlOg0KPiA+ID4gPiA+IEpv
c2h1YSBZZW9uZyB3cm90ZToNCj4gPiA+ID4gPiA+IEFkZCBTdGFyRml2ZSBTdGFybGluayBjYWNo
ZSBtYW5hZ2VtZW50IGRyaXZlciBmb3INCj4gPiA+ID4gPiA+IEpIODEwMCBTb0MuIFRoaXMgZHJp
dmVyIGVuYWJsZXMgUklTQy1WIG5vbi1zdGFuZGFyZCBjYWNoZQ0KPiA+ID4gPiA+ID4gb3BlcmF0
aW9uIG9uDQo+ID4gPiA+ID4gPiBKSDgxMDAgdGhhdCBkb2VzIG5vdCBzdXBwb3J0IFppY2JvbSBl
eHRlbnNpb24gaW5zdHJ1Y3Rpb25zLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEpvc2h1YSBZZW9uZyA8am9zaHVhLnllb25nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2NhY2hlL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgfCAgIDkgKysNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2NhY2hlL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2NhY2hlL3N0YXJm
aXZlX3N0YXJsaW5rX2NhY2hlLmMgfCAxMzUNCj4gPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ID4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pICBjcmVhdGUNCj4gPiA+ID4gPiA+IG1vZGUNCj4gPiA+ID4gPiA+IDEw
MDY0NCBkcml2ZXJzL2NhY2hlL3N0YXJmaXZlX3N0YXJsaW5rX2NhY2hlLmMNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jYWNoZS9LY29uZmlnIGIvZHJpdmVy
cy9jYWNoZS9LY29uZmlnDQo+ID4gPiA+ID4gPiBpbmRleA0KPiA+ID4gPiA+ID4gOTM0NWNlNDk3
NmQ3Li45MTgxY2QzOTFmNTMgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2NhY2hl
L0tjb25maWcNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2FjaGUvS2NvbmZpZw0KPiA+ID4g
PiA+ID4gQEAgLTE0LDQgKzE0LDEzIEBAIGNvbmZpZyBTSUZJVkVfQ0NBQ0hFDQo+ID4gPiA+ID4g
PiAgCWhlbHANCj4gPiA+ID4gPiA+ICAJICBTdXBwb3J0IGZvciB0aGUgY29tcG9zYWJsZSBjYWNo
ZSBjb250cm9sbGVyIG9uIFNpRml2ZQ0KPiBwbGF0Zm9ybXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gK2NvbmZpZyBTVEFSRklWRV9TVEFSTElOS19DQUNIRQ0KPiA+ID4gPiA+ID4gKwlib29s
ICJTdGFyRml2ZSBTdGFyTGluayBDYWNoZSBjb250cm9sbGVyIg0KPiA+ID4gPiA+ID4gKwlkZXBl
bmRzIG9uIFJJU0NWDQo+ID4gPiA+ID4gPiArCWRlcGVuZHMgb24gQVJDSF9TVEFSRklWRQ0KPiA+
ID4gPiA+ID4gKwlzZWxlY3QgUklTQ1ZfRE1BX05PTkNPSEVSRU5UDQo+ID4gPiA+ID4gPiArCXNl
bGVjdCBSSVNDVl9OT05TVEFOREFSRF9DQUNIRV9PUFMNCj4gPiA+ID4gPiA+ICsJaGVscA0KPiA+
ID4gPiA+ID4gKwkgIFN1cHBvcnQgZm9yIHRoZSBTdGFyTGluayBjYWNoZSBjb250cm9sbGVyIG9u
IFN0YXJGaXZlDQo+IHBsYXRmb3Jtcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgaXMgYSBi
aXQgbWlzbGVhZGluZy4gVGhlIEpINzF4MHMgZG9uJ3QgaGF2ZSB0aGlzLiBJdCdzIG9ubHkNCj4g
PiA+ID4gPiBvbiB0aGUgSkg4MTAwIHNvIGZhciwgYW5kIGhvcGVmdWxseSBsYXRlciBTb0NzIHdp
bGwganVzdA0KPiA+ID4gPiA+IGltcGxlbWVudCBSSVNDLVYNCj4gPiA+IHN0YW5kYXJkcyBmb3Ig
dGhpcy4NCj4gPiA+ID4gPiBTbyBtYXliZSBzb21ldGhpbmcgbGlrZQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gIlN1cHBvcnQgZm9yIHRoZSBTdGFyTGluayBjYWNoZSBjb250cm9sbGVyIG9uIHRoZSBT
dGFyRml2ZSBKSDgxMDAgU29DLiINCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBFbWls
LA0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgU3RhckxpbmstNTAwIGNhY2hlIGNvbnRyb2xsZXIgaXMg
bm90IGRlc2lnbmVkIGV4Y2x1c2l2ZWx5IGZvciBKSDgxMDANCj4gU29DLg0KPiA+ID4gPiBXaGls
ZSBpdCBpcyB0cnVlIHRoYXQgaXQgY3VycmVudGx5IGV4aXN0cyBvbiB0aGUgU3RhckZpdmUNCj4g
PiA+ID4gcGxhdGZvcm0sIENQVS9Tb0MgdGhhdCBkb2VzIG5vdCBjb21lIHdpdGggWmljYm9tIGV4
dGVuc2lvbnMNCj4gPiA+ID4gc3VwcG9ydGVkIHdvdWxkIG5lZWQgdG8gcmVseSBvbiB0aGlzIGNh
Y2hlIGRyaXZlIHRvIGRvIGNhY2hlDQo+ID4gPiA+IG1hbmFnZW1lbnQgb3BlcmF0aW9ucy4gSSB0
aGluayB3ZSBkb27igJl0IG5lZWQgdG8gbWVudGlvbmVkICdKSDgxMDANCj4gU29DJyBoZXJlLg0K
PiA+ID4NCj4gPiA+IFdhaXQsIGluIHRoZSBwcmV2aW91cyBtYWlsIHlvdSBzYWlkIHRoYXQgZnV0
dXJlIGRlc2lnbnMgd2lsbA0KPiA+ID4gaW1wbGVtZW50IFppY2JvbSBhbmQgbm90IG5lZWQgdGhp
cyB3b3JrLWFyb3VuZCwgYnV0IGhlcmUgeW91J3JlDQo+ID4gPiB0YWxraW5nIGFib3V0IG90aGVy
IFNvQ3MgdGhhdCBkbyBuZWVkIGl0LiBTbyB3aGljaCBpcyBpdD8NCj4gPg0KPiA+IElmIHlvdSB2
aXNpdCB0aGUgY29tcGFueSB3ZWJzaXRlIGFuZCBsb29rIGZvciBTdGFyTGluay01MDAsIHlvdSB3
aWxsDQo+ID4gZmluZCB0aGF0IGl0IGlzIGEgc3RhbmRhbG9uZSBJUCB0aGF0IHRoZSBjb21wYW55
IGlzIHNlbGxpbmcgYXMgYW4NCj4gPiBpbnRlcmNvbm5lY3QuIEFueW9uZSB3aG8gaW50ZWdyYXRl
cyBTdGFyTGluayB3aXRob3V0IFppY2JvbSBleHRlbnNpb25zDQo+ID4gbWF5IHV0aWxpemUgdGhl
IGNhY2hlIG1hbmFnZW1lbnQgb3BlcmF0aW9uIGZyb20gdGhpcyBJUC4NCj4gDQo+IFNvIHRoZW4g
dGhlICJvbiBTdGFyRml2ZSBwbGF0Zm9ybXMiIHBhcnQgaXMgd3Jvbmc/IE9yIHdpbGwgdGhpcyBh
bHdheXMgZ28NCj4gdG9nZXRoZXIgd2l0aCB0aGUgRHViaGUgY29yZXM/DQoNCkl0IHdvdWxkIGJl
ICdvbiBTdGFyRml2ZSBwbGF0Zm9ybScgd2l0aG91dCAnSkg4MTAwIFNvQycgdGhhdCB5b3Ugc3Vn
Z2VzdGVkLg0KU3RhckZpdmUncyBuZXdlciBjb3JlcyB0aGF0IHdpbGwgaGF2ZSBaaWNib20gZXh0
ZW5zaW9ucyBzdXBwb3J0ZWQuIFRob3NlDQpDUFUgY29yZSB3aWxsIG5vdCBuZWVkIHRvIGhhdmUg
dGhpcyBjYWNoZSBjb250cm9sbGVyIGVuYWJsZWQuDQogDQo+IA0KPiA+DQo+ID4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1yaXNjdiBt
YWlsaW5nIGxpc3QNCj4gPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K

