Return-Path: <linux-kernel+bounces-157085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4578B0CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9D51F25FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94715E80A;
	Wed, 24 Apr 2024 14:36:26 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283615E1E2;
	Wed, 24 Apr 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969385; cv=fail; b=RFQ/3r2amoeg+IWt9vMsv8OHBXLTHP0BHpMfuBlmT03p2HHwgrFZeY7LWymIMCQDAEyz22ltg5raKsuUR1VpcFjuDZOrG8AuKiR3vpjKZ5YDv/fAR7m14lIRMbKzgCScy+yRgBiwCp93t2oXCy6RcS12ibHiLj1JJkAadho+Zv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969385; c=relaxed/simple;
	bh=DIOqEheMJt+LKnYQ56V58TOSOPMd2HSuZ0nxqHeVerE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5VqzCC4gizOh3NzfythsDzTHQ+zeywAmM+gPpgCMkmJJR8XzVkMUycnKMzkbWUMUHqeMgVfu1vS/xvVi9Gmgc3QAexEqQKB5cW/YRvUh7/RKMSmre8OJECX19xWGh1EhSC/OTpQQZIvRZFYGdjs5nnyPJiUSA97Nhm4JBJC830=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShQN4kki14rwLwBWpC5W7GILtPnL7mzNI/w83wh43/6nPclYpzYaCF95L4lSV34SRD84Zp+/s6a1VCcelZeHfNwrt81N7fNwURZOQXy4aLan89PM9ViLQ90f4wQ4ZMVciMtp2QE11aD3X1up48Nl/NIHtK40FeJzhyhuX2y/6FQuRnFL1lzytS3uqMXVmiUajIxY1Hjw/7RLKtlWt03+rDg2NyGzFcAjOPcgH1ezWPHSlN2Jq4RWAjbM1CerZY/hsa5T0dhcKubxXmkWd3CgBYCZf/k8QU4+Ni95ZYa83oh2hZ4o6fFd7DL9lt0PUBP/i7WYOIf3OI1vA7e6gEA+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIOqEheMJt+LKnYQ56V58TOSOPMd2HSuZ0nxqHeVerE=;
 b=eB4FwNG7wbfhlM2dIAZhGedLJT0+y8A6GEiCd4AuUyHqxiCBGzTGOFUOkkGUdYHmwm1TiTkT3xRz5nJgXqqbgoyolzaqOJndTsI0X0hMNWP+3wtb9lGODTgueRBGsXKv1nZj2CbZaYVRGLUEg8FZJuHd2V6nQ6lhg16Rdhar0EWfUsVj4oi5ZmqjCa7ly6QkjFw71IkKRHTsPd4dil/RSSXluiT5//fZKST+wegC+qkRg0m7rPbNdvD00VZ03csvEL6do/Va5OAKlTMe/z51JWDxvI96utVk2XjbdBWXJOxuu5zTIhv2539T+l7BD2phDh64TmDTMmWGNx7O/enNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0459.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:36:14 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:36:13 +0000
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
Subject: RE: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Topic: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Thread-Index: AQHalh1PRoL0YjHNUEq+ss3l976a9rF3N0uAgAA4OgCAAAhagIAAAw4w
Date: Wed, 24 Apr 2024 14:36:13 +0000
Message-ID:
 <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com>
 <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
In-Reply-To:
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0459:EE_
x-ms-office365-filtering-correlation-id: b968e7f9-abd2-45f1-3b39-08dc646be49f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hoAll6oqdsMZsal/pZfbgFcLNMchyDiyvK1j0bRzy1SMxvolkUQH28HBkv+M2KMu+ZZ/fQJMVUpMzeNOuX1bBveK2w2oedsAAZBq8hWIbMMVyHSol8jFQY6A+5YzOnBuqwNhghB5sf/7HkVDQ0QTDLy1XydYvhTETSFbbkRN6hQ+7mKVnV8UNn0qXxgGu35XzaXCzWPvoAQVb3pH2aIqha6zKpcQ2hq7KK+bs8UJ1o1XL9d4QSFPdmj0nMdMb/Kgze6GfRYCmX6y9gj2sansYPsuSz1v9Z2fUTuc1490zxU+BmoQmLwoG4lkyJWO9i3W727D+n2enYOhERyg3poiU+eiNUC6M+O0sxoYx2NWe/YvVmljPQJKEP4EoIOApsSlMurt6Dhf8Ds2hF6vntLyD8AuKoC5NdRjOSbpYNuOqDw/89SoCdFUglPzl8AzQpVm0GLPBe3UsEa8PdCrCUfyMzaxKWoGsuj3YfQrYNxyqlWc3XUeJUu5ZBccYALAoIyCw/k+HxS98qbYLptTZer/1vJG1rdL0eSIL9Vwh+6SRsVDfE7FPZVJ0xLstPWeNOkxD6Or1D+YM3hEko/eRutX9Bg89cKNWciOHcuOCnFwvKKHlhoD5h0EC8UifHPHZgXc5JvvSw3rBk8/L6CTzE2jdQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUN0M3pnOHJTR05zWGROT3UrY21nK2xvR2QvWHlrZGtSY1dLc0NOc3B1aFAr?=
 =?utf-8?B?MVJSUTFOWGE0QWs5bjZseWtpZ1NQdnlnZUpOaktsb3RaSjhEalowRmpJREI4?=
 =?utf-8?B?SHZEKzRtNEVVbm9TVXNBbEFmN0tscVZYbzRjY3QxTFBKTzJLYWtBOUVLR3Y3?=
 =?utf-8?B?a3pXQjJnWUdZT1UvS29tSjRpL2xsQm9yR1NvNHJLKzIyWTJNd3JkRTgzVHMz?=
 =?utf-8?B?bFNPTTMzVHZFbjlSWFdvai9COVpCSCtPMWtLWUJBdTV3eXU4YWdHSzJxNmo3?=
 =?utf-8?B?WERnc0pNZS9NeEpSanRyYVdFaG1NT1ZDY2dMZzdOdUVDOStlanRXMFZWak9G?=
 =?utf-8?B?dG5SM1F3bk84SWRURVh3bWR6WkJwWW0rTlNEWWt5NjJwTGxnRGVPaGJSb3Zx?=
 =?utf-8?B?cHBySC80ZFRmbHBhbUpXcVR6ZDZiQldBRzJLN0NKSENiNkhSVlZRZDh6dEZ3?=
 =?utf-8?B?QlNUbU11cnIxek1Va0NsdVRmWTRnYVdUd2M5WXUwNVFzRk50emR2c3AxaWJN?=
 =?utf-8?B?Wk1meXY5ckF0U2lhZHFPLzJmdytONUswdHNJNWFuMXN1Q2ZldlVUWGwvdDhS?=
 =?utf-8?B?ektqODFXQVh2d2dhMG8xNzYyaGNFdEdtc0VrcFg0R0NKU0RJQlhaK2tBQVhq?=
 =?utf-8?B?Y3Z2blNQdkNqT2FwRGJ6ZTZPL2kreGZsQm54b1NOeG92RVo2NE55clJKYzhQ?=
 =?utf-8?B?c1RBcW9NSVd6SUZxeE9xOEJ0UVlyU2R2YXZkT0ViVEVtNTNZNWNseGhwdnlu?=
 =?utf-8?B?ZzZPNHl3ck1iWkhVL0VXajgyT3hPYWIrWDVBdjFWajJHTTVmYWdxenBndGQ3?=
 =?utf-8?B?L2R0aU14MTI4b24xT0FyOU8xaVRqMHYwUlRmbUNZYjJMNWJlcVhKMkdFNXJT?=
 =?utf-8?B?WXFkN3luUlpvUThQUWxyWjBSWm1NbHlsQkQ0NnBPR3RMaTFpSWp4T3pUSGN0?=
 =?utf-8?B?WWE5aFRINnBZbjJTRDU4eVl2UlVQMWZSU3RacHB6ZlBqRU5SRDRDNGdsdENF?=
 =?utf-8?B?M1Q5RWgrb3FyK21LSGkzZ1FLZVp4WVVvaGVrejhURkQ1dG5FODgzdVpsZUdC?=
 =?utf-8?B?Y0lyc09NcDltVUt1OGtwbFNTbWYxNXRLMjhlaDluYXNadXNjUnI3bExKNjVq?=
 =?utf-8?B?YUV6MUVCZXNmOTRVdk9wOCsxUS9LaU4vSTV6UmZ6S0xrc1lJOWxsR0xFNFNH?=
 =?utf-8?B?dTI2MElzSkozT2kvQ1JYWkJIQm5uU3poNXd2a281UW0rYzU0SFVsOTVuc0Uy?=
 =?utf-8?B?UE5pUzl3NWVHY2FicjhnUkZiUnFlN21OWTEvL0ovTUFPQnZMN3RIQUphZ1N2?=
 =?utf-8?B?RWVLL2ZRMmdNVDA0bmgvQ1FDUm1UM3NhMFlDamZqZFR4SVNMKzRGQlZPejI4?=
 =?utf-8?B?S0RDbldsNGg5cVJEeUxrbktFMUFKZW9JSFFZbm9kdW8xNVlpaFNvTlJvZkh5?=
 =?utf-8?B?alp5OHZCNWFIWGJNb2JicnZURjlMVTdZQjJ4YXU1MkJwRXpIdFRqSGdFMWhp?=
 =?utf-8?B?WFV5bHFBZkpnQjlJOEpKT2sxMExxUjJpQ1JnK1FGZGN1S0hSdUlNR0dFclJD?=
 =?utf-8?B?enhteEVrS2QxZzBYcnJkYXJ3cXRuQzlJdmxOd1VFNlJFK0F6R2xYOTlWQUwr?=
 =?utf-8?B?Ykd0VlIrYmNGMmdlSmM3VnhPcjRSQktoTzRoWFRodzh3bDhrdC9sUmFKN3Fj?=
 =?utf-8?B?V09uM1dIb3FGZTBUWnNHTEREZEVnTDhEWXZ1UUpVNzhLZ1hvaXh4SGdwem9h?=
 =?utf-8?B?MTNPZmY2bWtJeXFTK0M2SVVBaHlPSjVyaklmM05ZRU9FNEU2aFJJZFVUTUZV?=
 =?utf-8?B?cDNoSlNuRTJra0piSURSRUduQTFmTXVETjJrL2I5VkYyVmxCVGFlN2xsTDFX?=
 =?utf-8?B?RCt0R0dURU1ucDFzUFh4TFRxTnBVdlhDWUg0NnR2bzY2Vi9sTEdtaC82ZmtH?=
 =?utf-8?B?UkNwSG11VFpHWEtQWHloTndHODloT3c0NlJIQzc3QVZ2ZjlFUzFwcHA0NE9p?=
 =?utf-8?B?VEp4VzNUVkF6WC8zK2IrTWgyK1hkR0p4aE50a2pZWHo1NkY0N3F2VnYwT2RE?=
 =?utf-8?B?Zkw0Vk94OGtzelhlcmVkMlBRQlZNa0tNbStwY0tpb09sNFoxMS9lL1VQQU9O?=
 =?utf-8?B?Zyt1U3I1MWZjMGFpbEtNRitXUFFGaFR4U0RQaTJzT0lwcm45dnVmV0pycUsw?=
 =?utf-8?B?Y3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b968e7f9-abd2-45f1-3b39-08dc646be49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 14:36:13.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBrg6tkHXvQagDc/jZgmGjgMv/XJ2Tc20ad8j0y9arm795ilenzn3h50RIVb/SyFQyojAh+YbGvaHR+roG5h979YT3pcI005LTvlobOLKL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0459

DQoNCkVtaWwgUmVubmVyIEJlcnRoaW5nIHdyb3RlOg0KPiBKb3NodWEgWWVvbmcgd3JvdGU6DQo+
ID4gRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+ID4gPiBKb3NodWEgWWVvbmcgd3JvdGU6
DQo+ID4gPiA+IEFkZCBTdGFyRml2ZSBTdGFybGluayBjYWNoZSBtYW5hZ2VtZW50IGRyaXZlciBm
b3INCj4gPiA+ID4gSkg4MTAwIFNvQy4gVGhpcyBkcml2ZXIgZW5hYmxlcyBSSVNDLVYgbm9uLXN0
YW5kYXJkIGNhY2hlDQo+ID4gPiA+IG9wZXJhdGlvbiBvbg0KPiA+ID4gPiBKSDgxMDAgdGhhdCBk
b2VzIG5vdCBzdXBwb3J0IFppY2JvbSBleHRlbnNpb24gaW5zdHJ1Y3Rpb25zLg0KPiA+ID4gPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb3NodWEgWWVvbmcgPGpvc2h1YS55ZW9uZ0BzdGFyZml2
ZXRlY2guY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvY2FjaGUvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICB8ICAgOSArKw0KPiA+ID4gPiAgZHJpdmVycy9jYWNoZS9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgIHwgICA1ICstDQo+ID4gPiA+ICBkcml2ZXJzL2NhY2hlL3N0YXJm
aXZlX3N0YXJsaW5rX2NhY2hlLmMgfCAxMzUNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiA+ID4gMTAwNjQ0IGRyaXZlcnMvY2FjaGUvc3RhcmZp
dmVfc3RhcmxpbmtfY2FjaGUuYw0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jYWNoZS9LY29uZmlnIGIvZHJpdmVycy9jYWNoZS9LY29uZmlnIGluZGV4DQo+ID4gPiA+IDkz
NDVjZTQ5NzZkNy4uOTE4MWNkMzkxZjUzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nh
Y2hlL0tjb25maWcNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jYWNoZS9LY29uZmlnDQo+ID4gPiA+
IEBAIC0xNCw0ICsxNCwxMyBAQCBjb25maWcgU0lGSVZFX0NDQUNIRQ0KPiA+ID4gPiAgCWhlbHAN
Cj4gPiA+ID4gIAkgIFN1cHBvcnQgZm9yIHRoZSBjb21wb3NhYmxlIGNhY2hlIGNvbnRyb2xsZXIg
b24gU2lGaXZlIHBsYXRmb3Jtcy4NCj4gPiA+ID4NCj4gPiA+ID4gK2NvbmZpZyBTVEFSRklWRV9T
VEFSTElOS19DQUNIRQ0KPiA+ID4gPiArCWJvb2wgIlN0YXJGaXZlIFN0YXJMaW5rIENhY2hlIGNv
bnRyb2xsZXIiDQo+ID4gPiA+ICsJZGVwZW5kcyBvbiBSSVNDVg0KPiA+ID4gPiArCWRlcGVuZHMg
b24gQVJDSF9TVEFSRklWRQ0KPiA+ID4gPiArCXNlbGVjdCBSSVNDVl9ETUFfTk9OQ09IRVJFTlQN
Cj4gPiA+ID4gKwlzZWxlY3QgUklTQ1ZfTk9OU1RBTkRBUkRfQ0FDSEVfT1BTDQo+ID4gPiA+ICsJ
aGVscA0KPiA+ID4gPiArCSAgU3VwcG9ydCBmb3IgdGhlIFN0YXJMaW5rIGNhY2hlIGNvbnRyb2xs
ZXIgb24gU3RhckZpdmUgcGxhdGZvcm1zLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgYSBiaXQgbWlz
bGVhZGluZy4gVGhlIEpINzF4MHMgZG9uJ3QgaGF2ZSB0aGlzLiBJdCdzIG9ubHkgb24NCj4gPiA+
IHRoZSBKSDgxMDAgc28gZmFyLCBhbmQgaG9wZWZ1bGx5IGxhdGVyIFNvQ3Mgd2lsbCBqdXN0IGlt
cGxlbWVudCBSSVNDLVYNCj4gc3RhbmRhcmRzIGZvciB0aGlzLg0KPiA+ID4gU28gbWF5YmUgc29t
ZXRoaW5nIGxpa2UNCj4gPiA+DQo+ID4gPiAiU3VwcG9ydCBmb3IgdGhlIFN0YXJMaW5rIGNhY2hl
IGNvbnRyb2xsZXIgb24gdGhlIFN0YXJGaXZlIEpIODEwMCBTb0MuIg0KPiA+ID4NCj4gPg0KPiA+
IEhpIEVtaWwsDQo+ID4NCj4gPiBUaGUgU3RhckxpbmstNTAwIGNhY2hlIGNvbnRyb2xsZXIgaXMg
bm90IGRlc2lnbmVkIGV4Y2x1c2l2ZWx5IGZvciBKSDgxMDAgU29DLg0KPiA+IFdoaWxlIGl0IGlz
IHRydWUgdGhhdCBpdCBjdXJyZW50bHkgZXhpc3RzIG9uIHRoZSBTdGFyRml2ZSBwbGF0Zm9ybSwN
Cj4gPiBDUFUvU29DIHRoYXQgZG9lcyBub3QgY29tZSB3aXRoIFppY2JvbSBleHRlbnNpb25zIHN1
cHBvcnRlZCB3b3VsZCBuZWVkDQo+ID4gdG8gcmVseSBvbiB0aGlzIGNhY2hlIGRyaXZlIHRvIGRv
IGNhY2hlIG1hbmFnZW1lbnQgb3BlcmF0aW9ucy4gSSB0aGluaw0KPiA+IHdlIGRvbuKAmXQgbmVl
ZCB0byBtZW50aW9uZWQgJ0pIODEwMCBTb0MnIGhlcmUuDQo+IA0KPiBXYWl0LCBpbiB0aGUgcHJl
dmlvdXMgbWFpbCB5b3Ugc2FpZCB0aGF0IGZ1dHVyZSBkZXNpZ25zIHdpbGwgaW1wbGVtZW50IFpp
Y2JvbQ0KPiBhbmQgbm90IG5lZWQgdGhpcyB3b3JrLWFyb3VuZCwgYnV0IGhlcmUgeW91J3JlIHRh
bGtpbmcgYWJvdXQgb3RoZXIgU29DcyB0aGF0DQo+IGRvIG5lZWQgaXQuIFNvIHdoaWNoIGlzIGl0
Pw0KDQpJZiB5b3UgdmlzaXQgdGhlIGNvbXBhbnkgd2Vic2l0ZSBhbmQgbG9vayBmb3IgU3Rhckxp
bmstNTAwLCB5b3Ugd2lsbCBmaW5kIHRoYXQgDQppdCBpcyBhIHN0YW5kYWxvbmUgSVAgdGhhdCB0
aGUgY29tcGFueSBpcyBzZWxsaW5nIGFzIGFuIGludGVyY29ubmVjdC4gQW55b25lIA0Kd2hvIGlu
dGVncmF0ZXMgU3Rhckxpbmsgd2l0aG91dCBaaWNib20gZXh0ZW5zaW9ucyBtYXkgdXRpbGl6ZSB0
aGUgY2FjaGUgDQptYW5hZ2VtZW50IG9wZXJhdGlvbiBmcm9tIHRoaXMgSVAuDQoNCg==

