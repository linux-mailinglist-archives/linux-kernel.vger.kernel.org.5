Return-Path: <linux-kernel+bounces-16390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1C823DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53A5281E53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64620B10;
	Thu,  4 Jan 2024 08:44:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2058.outbound.protection.partner.outlook.cn [139.219.146.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CA208D0;
	Thu,  4 Jan 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDcOYMY4ndbsGRtrwlTeymYIyEqREYHmaA0N0jkrWYBkPWMfmZf6uQeEBWfLlL3bEiZiwmddWG4AJhTGNLxOLaS6/tDaYp2YTw16UZg56FyPBbfg3FMZRX74RJeF98BkuAUO4miS/4HdLCFZ9LTgOlviCh7UG5jxG4XfssouCGltzdZSgH7cIL3C9NrLBjV1BJLT/g0yI0KWSIqC7xWbBpB8n0UJxR0RweOhUlegGpM2o+ShF42LX/OJDOKbIRFMXwXsM5aPucTgaz/a1/Aebsz7xM0KVkhHIxiWJCfB43DcOCKeWay033e0ZKNheD1bTLjQdxGIt/+eyHervu7jPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp6gx790fBfZsVZON8GVoDBV805XhXnoTAC6urWoKEc=;
 b=Wy2wg4kPjz3l9XYl7U949dgqT1vO8ZiQIuQys9rX4yKPQwVrl4u3Bh3PDJufYALMWg/u4AB1Bf2U89ojFw7RIkFOZo6Z1r0zWBjnYB5IbUAHcyElZjRGX4ceYA/VU/ygfJZ90v8cufkBZYhyzxI8FUayFNGMEiB0oNPyUPXOn21x1PAKOLVoJbPfzHhkiuolrD5HypWnPXdlBWaiis23ov5nTxmTU1eN/jX3r5bouwxF/UCvLrD8rIaAmB0NVcyOi1HypzI9GWSY4bvOvTirgROqNlhAPQkGsYqs6bI7zu0CnGXrllR4fuiaJbtcKWpPHXzdczAJfNRM1C+ZjQBMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1256.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 08:28:11 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::bc6e:a7fa:7ab5:7417]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::bc6e:a7fa:7ab5:7417%4])
 with mapi id 15.20.7135.026; Thu, 4 Jan 2024 08:28:10 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yuklin Soo
	<yuklin.soo@starfivetech.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng
	<hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Drew
 Fustini <drew@beagleboard.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
Thread-Topic: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
Thread-Index: AQHaM+jMLz7GJ6Ui60+OoD/LjAWT9LCzZR6AgBYChkA=
Date: Thu, 4 Jan 2024 08:28:10 +0000
Message-ID:
 <ZQ0PR01MB1302318322A6534DF8119E81F667A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <233f293d-49bb-4bb9-ab2f-bc53a54ca611@linaro.org>
In-Reply-To: <233f293d-49bb-4bb9-ab2f-bc53a54ca611@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1256:EE_
x-ms-office365-filtering-correlation-id: 0b07e85b-9d5e-4554-06d3-08dc0cff162d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v9DNyFuqjh/KqYCKE4QKMx+pFxuVhjImhsubOfaBBXVmKC9vuLzZwPrhIylo4FvmFhEqze6/tJNs6VJfHg5/UBzbKjxY8+d6krdieBDUZq9bU02/5/+7Em25KCeUj5+RAvRx6TyaSkgJkak2+SViPtKdgFRuSYOOy+pexmqq3wdLIdqEjEJP07AWj5qDwylbYsG+eI/mpHRrpMzCEzZ3BU7k2OV7I2VFK12icb9a8PcOaZAwrL6GEyaaGVjIOD0TMpUW1o7Ttu+TYTE2Kmy+8SMc7LjakuBUfXA7T0pEufJcSjiGhbJPrqkevJUaSN+K4w0XrC74b2MNo4AiWLPnVExeh2RNeJ/FtiBMy10Bjq/BiuEsGCrFzFP6ZfjrpZMOK3e4EGpfxR4Fy7R3Mc7b3m4wyLw87OoGlC//YmOoeUfiNMaMeiCpU2MmznDS7TriAglPyW/fJ1WfIN74nIxlw+sXZ7BJXDNN8BSTqF/kc+Dz67AT/1VvtBEdLgR4TJ3eF0q3TaLnwQXlm+dnpKDABfJTgsrdopACXONRyXGbrsORz414mgSQ6ymxiDmc1B1PwNRiH1DdfpiHoQWfaszOYA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(41300700001)(26005)(41320700001)(83380400001)(7416002)(966005)(55016003)(66446008)(122000001)(4326008)(40160700002)(38100700002)(33656002)(44832011)(2906002)(40180700001)(71200400001)(508600001)(921011)(5660300002)(76116006)(66556008)(66476007)(110136005)(54906003)(64756008)(66946007)(38070700009)(9686003)(53546011)(7696005)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDUxaktpZEZERCtWaGlQa3pabnd1MFJGYlFkcVZPOUM4OGNBSVV2cGNUdEt1?=
 =?utf-8?B?YkVta1cvWXE4V2pkWXpVcmh0L2R6UUVIdlAwTUFzTk5KOWVDWGxRZkJNdEpX?=
 =?utf-8?B?SURObGhHNzVZR3d1bU42cm0rOWNpYWx6TGt5bmFiT0RkVDlWSno1bFNkdzZP?=
 =?utf-8?B?MlpLZThRWi9TMUc3cHBRKzZQVFQ5VTVJbUhFSHMvQ2JlYVVsNDhUVk1BbWgv?=
 =?utf-8?B?a0VJK00ydHQ4R0E3WDdlc2cwZmlyVE9XUVMySWt2ak9KRC9ieXdBcFFvYkth?=
 =?utf-8?B?V0FHQWVNdWpoSWxJS01hbFJxVk5YbERxTU1MRlJ0YytZUHl2THdUYnFBQllI?=
 =?utf-8?B?aS9DbXVqWUxtNkZmVFFZd2xZWUFiMThjNjlocisxZ2czZ0FuNGI4dFN6ZkdL?=
 =?utf-8?B?M1cyT2tzSWIrY0ZIcFU4VVZMWWZ4c1NERnFmQzk3cHhkWEpsRkFhSTk1Wmcz?=
 =?utf-8?B?WUY4NjFBM0xyRjBRYlR3S2hiSGNTdlY1Sk0va3oyRHdjVmVVQWhuUmk3L0N4?=
 =?utf-8?B?d2hicllkTC9QRU9pMisvZk5IcytpUjFRVUZVS2lXcFVFazRSZTRTdy9xcFQx?=
 =?utf-8?B?UlVUT3NIemt1SFFDRVh2bVZJc2xmeXBJcksxT2doNUswdFRDVXFCcmtSRUVV?=
 =?utf-8?B?S3l4aW1NOFpvVVkrQk9LMkR3U1pmalBtRjhnTndTeVE1OEhTaUMwcEhxeTAw?=
 =?utf-8?B?b2sweWJEczkrYXM4dC9NSlFRNU1YV1RoYmZuWkZMejU1TEljempqVm1zM1ll?=
 =?utf-8?B?MHhNeEF2TXdGZVUwVUNxQ3A5VjFSM0dnTlNwN0o1TktlU0J1KzYvVTlHTE56?=
 =?utf-8?B?aFdaemJFZ1ZVYnFWZHRLRWMxZ2NEcnNSenZ4UUpIY0tiZUk4TmxEVzJzYyto?=
 =?utf-8?B?YklZMzB5QkF1Q3U5MlZjNmVaQ2FZM2lXWGc1dmlma3I3ektHT2FwZ29nSEN0?=
 =?utf-8?B?Z0REeHF2NWxjNW9jcGE5N1MyRkIzdWxYTkxrSmNOcHdtWm9SNURUNjc3MldD?=
 =?utf-8?B?b21Oa1o1SXZDMzhlRDl5R2hlRGEvSEcvaFJraG5ma3NLaytTaFBaejl2N0xi?=
 =?utf-8?B?eFJ3bWY3TkhyS21tcmRtOHdFV1Y0aENRNzljK0dwd2pqNUNxTnZTbzk3UjRu?=
 =?utf-8?B?TXppdm1HRm51WG9Nd2paM1hWaTUwZGVFS2JpNE9CeVV4c2RialN2NllBMzBW?=
 =?utf-8?B?UXhkS0VpZmpaWnJSY01zUXR6a29nN1U0L21qNGZPNEdPVjh4aVh4ZmZtSWRp?=
 =?utf-8?B?OFRobndCY2d5SjNHNFBuY1l2SStUTkYxeXdRSElnYzdjWFlpYno2RGFJOThI?=
 =?utf-8?B?QUlDZlgvL2ZIRm1iTW5TQm52QWlvNTdBNk1DaFhjY1pQZFM4aEloMHN6Tmdy?=
 =?utf-8?B?K1VkY29EOEN1dWV2eUozU2srSXduWkxpTXJrYWtyVk9VNG9Ed3RBMTRacFdr?=
 =?utf-8?B?MmRCbDdiTDBUcUNRNEdjLzBOUWVBc2paL05GVWVPYVk4NkpRdTF4YTJ5bTgz?=
 =?utf-8?B?S0d2L3I4TVRQUWZFZlhXQ2lId29BSHdKMWxuM2lPaXF2ZUFQcG9GS2FQTjBW?=
 =?utf-8?B?U1dZYm9YdC8vbmhrTzNMSERjeVZYRFFoeW5wa0NraWwzRmdtRm5PaDVYcW9r?=
 =?utf-8?B?dnpsWUIrYTJmcW95ckdGL3Z5T21WbFVMKzdZS1NsQWxnOFg2Z2kraktGekEr?=
 =?utf-8?B?dmFWWTdRWWpUNFNwMFpKSEhjbFI3cDlvTFptKzdnNGEzYkdSNjRKS0RRNWxQ?=
 =?utf-8?B?NnludUhPOXY1alRhcjA0aGFET0lwd2Y5MW5vOERMTUlURHQwM21HWE9LU1VF?=
 =?utf-8?B?M1VQWmU5VHo4MVM2ZnpnS2FjeDF6bndkK0VxQnl2dDNvdXoySzFIWmJGMWZY?=
 =?utf-8?B?NVIxVFpWQW14M25HdkRoVEV0S0JBbWdpNUdtSWloWDNHNWpGQ3ZHS1hsUXdC?=
 =?utf-8?B?WGhaTWxoT3FzOEx5bk1BMVBFZEFGWVErYmJ4NDBIbWFLRFpzSEtZSlV5Z2Y0?=
 =?utf-8?B?a0wrd2xmc3ptODZlazFSQzRyYVZqN3JIdUQwckgrVUdZWndjbS9RRXZQRDBG?=
 =?utf-8?B?SmUzMnpEWjZKSXRUUDFTWVNzQWw4Wm1WZDV5WW0vQlVkOWsydllRcDNQd3F4?=
 =?utf-8?B?UHhRWk93azRsWUNTcVh4cmRUViswamFJNFNOQXlOK1I1L1ZnSG1wUHpYWGFT?=
 =?utf-8?B?cnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b07e85b-9d5e-4554-06d3-08dc0cff162d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 08:28:10.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr04y7s5JJ+dd/DV9bBQzrKYOyRLxKJRmyXUOYomMXAr8VDVH30LakoSu2a5g694ekx78nwI00aNjBWdltSImnKJUtgHAYfYKjLyZkW2Q0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1256

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIERl
Y2VtYmVyIDIyLCAyMDIzIDEyOjIwIEFNDQo+IFRvOiBZdWtsaW4gU29vIDx5dWtsaW4uc29vQHN0
YXJmaXZldGVjaC5jb20+OyBMaW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc+OyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxiYXJ0b3N6LmdvbGFzemV3c2tpQGxpbmFyby5v
cmc+OyBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47DQo+IExleWZvb24gVGFu
IDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPjsgSmlhbmxvbmcgSHVhbmcNCj4gPGppYW5s
b25nLmh1YW5nQHN0YXJmaXZldGVjaC5jb20+OyBFbWlsIFJlbm5lciBCZXJ0aGluZw0KPiA8a2Vy
bmVsQGVzbWlsLmRrPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBL
b3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IERyZXcgRnVzdGluaSA8ZHJld0BiZWFnbGVi
b2FyZC5vcmc+DQo+IENjOiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJp
c2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IFBhdWwgV2FsbXNsZXkNCj4gPHBhdWwud2FsbXNsZXlA
c2lmaXZlLmNvbT47IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+Ow0KPiBBbGJl
cnQgT3UgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
MC82XSBBZGQgUGluY3RybCBkcml2ZXIgZm9yIFN0YXJmaXZlIEpIODEwMCBTb0MNCj4gDQo+IE9u
IDIxLzEyLzIwMjMgMDk6MzYsIEFsZXggU29vIHdyb3RlOg0KPiA+IFN0YXJmaXZlIEpIODEwMCBT
b0MgY29uc2lzdHMgb2YgNCBwaW5jdHJsIGRvbWFpbnMgLSBzeXNfZWFzdCwNCj4gPiBzeXNfd2Vz
dCwgc3lzX2dtYWMsIGFuZCBhb24uIFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgcGluY3RybCBkcml2
ZXJzDQo+ID4gZm9yIHRoZXNlIDQgcGluY3RybCBkb21haW5zIGFuZCB0aGlzIHBhdGNoIHNlcmll
cyBpcyBkZXBlbmRpbmcgb24gdGhlDQo+ID4gSkg4MTAwIGJhc2UgcGF0Y2ggc2VyaWVzIGluIFsx
XSBhbmQgWzJdLg0KPiA+IFRoZSByZWxldmFudCBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gZm9y
IGVhY2ggcGluY3RybCBkb21haW4gaGFzIGJlZW4NCj4gPiB1cGRhdGVkIGFjY29yZGluZ2x5Lg0K
PiANCj4gUGxlYXNlIGV4cGxhaW4gd2h5IHRoaXMgaXMgUkZDLiBFdmVyeSBwYXRjaCBpcyBSRkMs
IHNvIHdoYXQgaXMgc3BlY2lhbCBhYm91dA0KPiBoZXJlPyBVc3VhbGx5IHRoaXMgbWVhbnMgd29y
ayBpcyBub3QgZmluaXNoZWQgYW5kIHNob3VsZCBub3QgYmUgbWVyZ2VkLA0KPiBuZWl0aGVyIHJl
dmlld2VkLiBJZiB5b3Ugc3BlbGxlZCBvdXQgaGVyZSB0aGUgcmVhc29ucywgaXQgd291bGQgYmUg
ZWFzaWVyIGZvcg0KPiB1cyB0byB1bmRlcnN0YW5kIHdoZXRoZXIgd2Ugc2hvdWxkIGNvbXBsYWlu
IGFib3V0IGJyb2tlbiBhbmQgbm9uLQ0KPiBidWlsZGluZyBjb2RlIG9yIG5vdC4NCg0KVGhpcyBK
SDgxMDAgU29DIHBpbmN0cmwgcGF0Y2ggaXMgZGVwZW5kZW50IG9uIHRoZSBmb2xsb3dpbmc6IA0K
LQlJbml0aWFsIGRldmljZSB0cmVlIHN1cHBvcnQgYW5kIGR0LWJpbmRpbmdzIGZvciBKSDgxMDAg
U29DDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMjE0LXBsYXRvbmljLXVuaGVh
cmluZy0yN2UyZWMzZDhmNzVAc3B1ZC8NCi0JQ2xvY2sgJiBSZXNldCBTdXBwb3J0IGZvciBKSDgx
MDAgU29DDQogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTIwNjExNTAwMC4yOTU4
MjUtMS1qZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tLw0KIA0KDQpSZWZlciB0byB0aGUgZmly
c3QgbGluaywgdGhlcmUgaXMgbWFpbnRhaW5lciBmZWVkYmFjayB0aGF0IGlmIG91ciBldmFsdWF0
aW9uIHBsYXRmb3JtIGlzIEZQR0EtYmFzZWQgKHNpbmNlIGFjdHVhbCBzaWxpY29uIGlzIHN0aWxs
IHVuYXZhaWxhYmxlKSwgdGhleSBhcmUgbm90IGtlZW4gb24gbWVyZ2luZyB0aGUgcGF0Y2hlcywg
YW5kIHRoaW5ncyBsaWtlIHBpbmN0cmwgb3IgY2xvY2sgZHJpdmVycyBzaG91bGQgZmlyc3QgYmUg
c3VibWl0dGVkIGFzIOKAnG5vdCB0byBiZSBtZXJnZWTigJ0sIGluIG90aGVyIHdvcmRzLCBhcyBS
RkMgcGF0Y2hlcy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

