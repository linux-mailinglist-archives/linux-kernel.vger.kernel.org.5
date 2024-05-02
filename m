Return-Path: <linux-kernel+bounces-166627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88438B9D38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F398284649
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B515B969;
	Thu,  2 May 2024 15:19:14 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1415B104;
	Thu,  2 May 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663153; cv=fail; b=bqRksVMN2EKWYH74Vd1du8xtil3x/WzqHEDR4okuyV45gxM703R6SfI1R06fEq70qcofMqwNF98fw9NCcf9u01OyW+E/2K8dW13K6rpjwFBM9FsAfFrGexeCGvVgW+U4dl6FBxM0wfunkChIHg46GYtdBT181/8q8ZvgQdRHYAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663153; c=relaxed/simple;
	bh=NyTyhJIv5ebnUvIe0Mw3QZzvM1z42f97+1xP/Tj+DGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1oYuc1DjFjxImOzR5Zr1drv5hfxpPS3OAQMsjDq2zuSJTM6L+1v7LrmslN+Ivk1yrZpK1tVZlu/fN7H9bqHumUREYRds2gxVunWnGXEsqcCNjsriAGHxe95W9firYrJZxbXQgejR41OZsEGcncE4j/qG9unhSIhEuyCYeOVGz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbDfDaY+GvaNdCA6szdCID51AE6imFbZx+4VJWkldubP1D7iDFjN1WjnxgFNQjbyTAfnN6VfyGTEMDnKxMdvmH/6PBEROtdmKlE/rNNBi8yR4gm+yk232aMnuTlM2fi624VwhZ3Ies/tzuSWBwGTow30FAPO1mRY2ZoWr+lLyQRHuzPsjsyvHU1g2YGbflCHFhMiIeccVCh45YffBU/CrYLV5hfrPB2LHmkzHx4upRE0mKwHvbFuqmMT7rxCfVDrcjLGGdWH1w+tg83h0l55stoC+YUDxkB/rN1ZjHfUv8uBuYUJD70J7+BmfXq3oFEDvlp/CEmruvU+V8cM+ieTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyTyhJIv5ebnUvIe0Mw3QZzvM1z42f97+1xP/Tj+DGs=;
 b=EFFJ3JEuvjRQ+A5xZY0VMbIS/N7IWsXxZ+XBqYR3c29q5ire5FYVSNMy8hcXvTuxTjc9M3RN8a4xyrLEiIvUHRigs4fSUhu8GjSTxgqLZz6nZ4sNSm7AH627CehjznVTy6uYzvsHaS+Rqy65AjdeBuTT/J8hhf2x+v2eU5ichS/5u0P0+3MYNtnHuxaSgMfzx4D5RiVnOJnx9Xi0PB+FUn4Pvw2cnlWqoSomtmd1fcc71FW050RWgZv1Uyb1/j4JtpLMiQXxgBsuWJSEVYU03Mit7TwuJ/ifTs5BH6l/JAqhG44Al64ajNnhfJ/xD+Qg7P6sckE3S4m9V/VycdCAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1313.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 12:45:49 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 12:45:49 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>, Lars-Peter Clausen <lars@metafoo.de>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, EngLee Teh <englee.teh@starfivetech.com>
Subject: RE: [PATCH v2 2/2] dt-bindings: spi: spi-cadence: Add optional reset
 control
Thread-Topic: [PATCH v2 2/2] dt-bindings: spi: spi-cadence: Add optional reset
 control
Thread-Index: AQHanH5J1xo3ta2QXkGkfo2fF/uLg7GD3ZcAgAADf9A=
Date: Thu, 2 May 2024 12:45:49 +0000
Message-ID:
 <ZQ4PR01MB1154B6FBA361C503AC10E6B6EB18A@ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn>
References: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
 <20240502104800.3030486-3-jisheng.teoh@starfivetech.com>
 <89f96e06-1966-43c2-b4c4-17e1669c2566@kernel.org>
In-Reply-To: <89f96e06-1966-43c2-b4c4-17e1669c2566@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1313:EE_
x-ms-office365-filtering-correlation-id: 54d92203-5a87-4bed-f929-08dc6aa5cb35
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NHxzQUhuK3Thj/tAOZycOUFqJeBo2wSThSoQPw6aLlH2m3kNRI40Yk+T1gWNZcY7bgwvoEtnmbGIBs3s4N2s4Xh1rC2Jw833m7h2sbvwVqg0GgR9yblN3hpQdo00kiD3NCXnl2m1Pv48lXdDoW7KAA8KspExQz6rAJAFW3tSmXO1CN9HKXhpnQ43ZAAk98YMQ8YAxkdeVKnLrVlLM4hdCUFBqg3WuuusFSc8Brxn16uJ43CcR0jcmNWfIXYrRWynCNF+g+LgnOzOv0MpkCqX2DiJqvhwW7UjnUU6yHzcnzIB/gxPpVrXQ3OwavKxacc5o7D2v7IOKH65PR08lOFtpJ7Jyn1YxU4dvxc/ymByG+C9ZC1UvPOF+sBs7UrcVL8zfd4W4tBZIQhWFxv/3lypq0gJRhr/i5rodd0+ybWbl7gjnTu5sh3Lg5A8TE7GIK+U68Q+YSl14RYCe90Cp0SacWmhSCi0SeN+Xg4lz9diYdlZBhkhioopro7CoDkJQqhWTmEuT9zLuuHvgmnbC5KSyZlw14gYPvTBpDf8XRkXpizdEXBFNgLsgrXh/GnSJHbX7LEeSccYWUt1vyianCtx7zPDwNlBUryYXp5hj30HURlQenbww2OvBoCLMhfoOUMF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWtwRjlsTG5nVFhCbHEybEhCTjY3a0tZdHJVcm1WNHZnOGVLWE1ONXZPR0pa?=
 =?utf-8?B?dFlKVjl6WkIxK3VXVzE1MHE5dmRZemRKU1VZWkhoM1E5Q0JVcDJYQTJLNlVV?=
 =?utf-8?B?UTJ5ZTZhWFkyVTVza0RhNU0rWXhxRGpEbmRvKzVuNUQ1dC9jcTZ3OEdDSzgz?=
 =?utf-8?B?bDlNZkpHWDJJQlFlcTJpQ0JseFU5Y2VheGU2eFExV3J4WDkxbjRHdHJoWFpk?=
 =?utf-8?B?L1BHYU1La1VkcEVJUU0raTlPc25sWldSR3M5NEtLU3pFV3RGVk5yOTJqTmJi?=
 =?utf-8?B?SVpaZDFvcklLUnZpUzJidU82T3RXTVB1MitlUHNSNm0zVytpNTgwcTRhaU9Z?=
 =?utf-8?B?MUtPT3hnbjJsU2FUMXB3QTE4NUszdGFlZnZoVGYvTzVzWTVOTFBXRCswSWtG?=
 =?utf-8?B?ZUt5NHVoWTMreE9Iek1pUEpzWFNsQTNKczNNUzl6WjlsRmVjaW0yZVM2UFZv?=
 =?utf-8?B?c3FxT0pESFVmOEk0dHE1MEY4QWtySmFuR2dTOG1kWFRaRG5xZytXMHBFczN3?=
 =?utf-8?B?cW9UazRCOHViZjdTNUIyS2VGT25TRHFuZHI5dWxIUzRrQnJMNlhWY2d5VHBZ?=
 =?utf-8?B?SnRZTzlXczdTNndhRnQ3RXdUQ2c5anFBUVdPWjJKZ2d4WnNXUmNROFl1RWpS?=
 =?utf-8?B?L1B4MGx2WGdYb1ZvZlFiQ1hDaVNwME1KYlExWUk1aEZ2QlF6bEhFZlNUWHdX?=
 =?utf-8?B?VHJXUWJ2OWh4ZUIxcWh5MDdVRmtURDVQRSt6MDZCdTJMYi9pUWVkZC8yZHlE?=
 =?utf-8?B?MFBaMmJpbGJTY0JJWXVjd3lDNlluSys2QTlRdW1sbTNZQmVzMTRwSlF1TWpw?=
 =?utf-8?B?RDY3dmJLeFh6eWdhd056VWdxbjhHc0ZYdFZnTmg4TXVkSUZHWWQ0Z0wxRUZ1?=
 =?utf-8?B?Q0V0Y3l6ekxpMUVFQ043M3MvTk1SenlSTGxrMXFSazJzcUloTFRkMmlvV1V2?=
 =?utf-8?B?UDhTcGt6RjBjQmlsUER3M2VwZHJpSFdvS2NHbWN4dmdtZmw1cHFLR3Rtc0Jr?=
 =?utf-8?B?Yk5Zb3JwSjEwZDF1eWFsU1pMTVQySVVhTHJMeTVjWkI5TEU3R0FFNE9zQ1ZT?=
 =?utf-8?B?K3B1eHVjRklPWTlmTW9JWm1rMy9TSVJRYkRCSGRrVXQ5eUdvbUpLN0k1cFJ1?=
 =?utf-8?B?L3UzemJEOXdpT3A0VXpmNUtyVDQ3UkIwOUNjK1lxVlk5MkxIdVRDTUNSdCt2?=
 =?utf-8?B?NjJEeDJjeHNqVStya2hsMENnT1VWbGZ0RkNHVjZteEg2Z0VLa1MzNGVXd3cv?=
 =?utf-8?B?anZDUHR3OU9ucTVmY0dtV2YvSmRCMEpOeG5xeDBwVEZLb3RHMFEzRU9nQS9L?=
 =?utf-8?B?L01FQ0tBWExyaytFZ3dpUEFjSzFydTRPTjkvTkxNMG8rWSs2RWJlTS8xRGxs?=
 =?utf-8?B?VUl3WnhJUUZycklRMC9SSEVaZCtCcXdkOGZUNHdQSkUwVWZqSHFvQ0I1YlpV?=
 =?utf-8?B?QUx3QjJnNExnWXYwZDhnV3lDRysrL0NVOStWNVdtT2tuNkljR2JpRHpFbjhO?=
 =?utf-8?B?ZG4vTDBNN1J2dkMzTEFrcm5DMnY5UE52SU5EQUdISFFHNGlRVzVVdFowdExS?=
 =?utf-8?B?c2hZYnk3WlkvR0Q0VExlWTRZUU96UlZsaXRNVVdBSFBmMXlaUis1VGdhSWxa?=
 =?utf-8?B?VVJWcFUxa1hQeUpvU2FxM2xHSmF5OW9aLzB0cVpoK3E3aVphcExaL0xiOTBx?=
 =?utf-8?B?dXo3bHIxd29RQ24yYTBPdjRYSlB6SU5MbFVTK3BqNGZObEtHeEpLSlNMUEpO?=
 =?utf-8?B?aDBLZHFFRHpqN1B0NEpydGwySXVLT1hrNTdSRXo4Q05VTXllSUNGWCtqYnZO?=
 =?utf-8?B?bzJUejYxTGJUZHZqVkptMENadjd6aUphRG5jR2c3eCt1MU15SFV2dENIZVA4?=
 =?utf-8?B?NlF3WDVHSENXTFZyM0F6UHgxUk1EVnpSMkV6MU1zeXBvNGVKT2YvSkNFYmo5?=
 =?utf-8?B?UDZrUGR3QW1uaHFQTEJML2ZwWVdzd3FzcGw1RVRLY1VWUnl5SGpRcE1EeWhW?=
 =?utf-8?B?Uzlrd3Jkam0zT0pmUkMvV0JKREM0Nit4dlpZdzM4bFNJU0syUXNCSG5pWUYr?=
 =?utf-8?B?WHNZOFhnWWlmS3NDaG9NYm1UclR2WnhROFN2dzBUQnBnQ3hJU1BKMG1WaS9J?=
 =?utf-8?B?R1FxWTNObjczMjZKSWdpTmhBMXRwZ1FHcUo3azcxOE95MjFwYkRWQlRYWDUv?=
 =?utf-8?B?NGc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d92203-5a87-4bed-f929-08dc6aa5cb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 12:45:49.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: celz+9N3lgUo7QhA1MNnjQPvHppBWRJ1e/+B9xCL0EXGvsdwknJ/n0uRq4HIoHp/YBdYB4eM8APKzUOzSIcSLt+8uwlVkBIdavwA8tkNfKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1313

PiBPbiAwMi8wNS8yMDI0IDEyOjQ4LCBKaSBTaGVuZyBUZW9oIHdyb3RlOg0KPiA+IERvY3VtZW50
IHRoZSBvcHRpb25hbCByZXNldCBjb250cm9sIHRvIFNQSS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEVuZyBMZWUgVGVoIDxlbmdsZWUudGVoQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTGV5IEZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEppIFNoZW5nIFRlb2ggPGppc2hlbmcudGVvaEBzdGFyZml2ZXRlY2gu
Y29tPg0KPiANCj4gV2hvIGlzIHRoZSBhdXRob3IgaGVyZT8gV2hhdCBhcmUgdGhlc2UgdGhyZWUg
U29CcyBleHByZXNzaW5nPyBSb2IgYXNrZWQgZm9yIHRoaXMgbGFzdCB0aW1lLg0KDQpGaXJzdCBT
b0Igd2FzIHRoZSBvcmlnaW5hbCBhdXRob3IsIHRoZSBzdWJzZXF1ZW50IFNvQiBtYWRlIGNoYW5n
ZXMgdG8gdGhlIG9yaWdpbmFsIHBhdGNoLg0KSWYgaW50ZW5kIHRvIG9ubHkga2VlcCB0aGUgYXV0
aG9yLCB0aGVuIHBsZWFzZSB0YWtlIHRoZSBmaXJzdCBTb0IuIFNvcnJ5IGZvciB0aGUgbm9pc2Uu
DQoNCg==

