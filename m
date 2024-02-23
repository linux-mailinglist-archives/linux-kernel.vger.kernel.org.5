Return-Path: <linux-kernel+bounces-77684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE618608FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17541F23532
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEEC14F;
	Fri, 23 Feb 2024 02:46:38 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8DB665;
	Fri, 23 Feb 2024 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656397; cv=fail; b=MhgqjJf5vocrP5ZBcGu8tSWEppyTBa2y4cfew0+9YO4b+CR33ogCw9toX0E8PpS1pEjfNs15MQk3kVzO8ZPJgMRIwlX897Igs8p/r6QOMwkOLcQvCIV3nVuKBSYyNpjLe0K33x/mrxzMA++GWo7cbdvIDMf741ez9ZJA+Uq269o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656397; c=relaxed/simple;
	bh=6+5itIpGoCkxUWG3DyjAbyOriaVekKuZrqMplTfrpbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCg5RTl8Khb/R4dNB/CkC0/Luh63AbOvSPgTku1CHCJKSk2G4Yp4ISHPyj3OfJzeTUuRFregUS5Bc06bA7e3q2Nd5ml+VRl5fsa7bn+aROEKJpWfMB4es9pBPh468Oi702fI6yC+uktJnQC6ryF2Zyh3etk26gwnycmAMDcZDqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDzThBerPhQxGWyuycVujNtQY5EnrPGXzfsM2ldi0SEO9mG1VAYHnPj/gqkyEJNumol48oPZbwG7muJnEBtFP06L/QRN8asewom0pQdNSWdMDyIErV2E4WKGgcVKLi7TNnik5Apj43YzDdRr0o/gEG2lK/FEbVsz1oOWQb2ry3wSS4B1V6a3R+Oi3VIVUASGXZhtGLOfPS69ryqCbHuzZoYUrfSnhtb4bsz5iCw8UUyGFeV5CbGefxedx7voHiqcCFiQ0MPvwlj21k1XW4ofB98z/tQo6LliCLkbgFJDWDDzpLIu/JFhKk5MQ1RuQuTr7i+Sd9iPzC/mBIOUZB5MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+5itIpGoCkxUWG3DyjAbyOriaVekKuZrqMplTfrpbo=;
 b=RxXjK0m2f7kpaKfJBj20/h9YhOHacHftEp6+yU3lWcQy3eeMdXfn9OUlIWYl5jJZliZXtJ08uG/uHFXy2pGs/eBlxrmaWLY7CNvZ+O5EDi+lU+vD4AkdGaJCsGETqz+CVLPTCwt5F+PN8eYiRTip/MlLQIRhAsQJEjhcODT2xt3Jc5gTabL4QKfUayef6KEWwQr8K9AuUr4umN6ZsF/KAf4coatrQkoCrRUjbDeC9heHBllOJOjTiWulRiJbSZOHvpwQbPNRJ6DpG+8PHUaEXqk5ExfcnBhrC+jfGbKg5HZjw3kcW6BMKZ7EhZIJ6zEEB5V2kOcMQdje+Wab8gojCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0464.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.50; Fri, 23 Feb
 2024 02:46:23 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Fri, 23 Feb 2024 02:46:23 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Jai Luthra <j-luthra@ti.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans
 Verkuil <hverkuil-cisco@xs4all.nl>, Vaishnav Achath <vaishnav.a@ti.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>, Jack Zhu <jack.zhu@starfivetech.com>, Julien
 Massot <julien.massot@collabora.com>, Jayshri Pawar <jpawar@cadence.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkZDIDAyLzIxXSBtZWRpYTogY2FkZW5jZTogY3Np?=
 =?utf-8?B?MnJ4OiBjb25maWd1cmUgRFBIWSBiZWZvcmUgc3RhcnRpbmcgc291cmNlIHN0?=
 =?utf-8?Q?ream?=
Thread-Topic: [PATCH RFC 02/21] media: cadence: csi2rx: configure DPHY before
 starting source stream
Thread-Index: AQHaZYL0VtEMSs5rREyfMKAHqylE9bEXN+Bg
Date: Fri, 23 Feb 2024 02:46:23 +0000
Message-ID:
 <SHXPR01MB0671EA5450ADAB3F550712D0F255A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-2-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-2-1837ed916eeb@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0464:EE_
x-ms-office365-filtering-correlation-id: 99e58d42-7529-49e7-978e-08dc34199f71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v/MuS6S9IA5LJ1m7Ki4X7VrifneysTA9PCSvb2pepS1kZV4njFdowCX7O/fm6e/EkcXTiAy0BNODlgt3saDQhTZz048gRgq6NEesZRxROjBqMdo+i7LE2O4lMVIOqk0MzxSXddC+kY+QZbWol6UBEKR9qXWOW09++bOF2nw43gASGHcq9oFfEgTbXw22JaaYuFQZGUr6Zcq6c9rRHSbihgi3vDhMnmXs6T6LqSLK6sykvyae2xmW93eQ3xvQAm3apdKBKRkxDHJZZwyw0UJuDpZWzJ2QRJqvT457jkWg5pfhilSZKuHQ8jDdfUYplXCnL+tBl4y/kkjxCGddUE6JleLgfXcSvjdZulJbE6DOnEOJ8pSA1AVh+wiaBo3OWu3zdkyK8yDHfhKKEDwoG7vv9FHbV13G3z7DNPOZdp17UhkreVcmNzcyK1Qdyy3H+NisnMsfuZ+GQcTbWpqpsMXMB066bPnmOTW++gIxlCzHzznVBRZHoqKzV9y9jjHzUTt5HIsfXXOamXGSqCmPn/W5qdP5mjuSdPADTKtBcs5h3hwe3/2zpd+HBkyWeLg8F777ZKPASMoaU0vLOvzEaAuknQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2VKam1DL09Dd0FieXdCNk5malZWMVZoWndaMFV5Tk5QZ0dwWEF2cnUzUXdE?=
 =?utf-8?B?N3BIc2QzbTFIemgrNE90ZFdDLzBDaEZvRmszcXNLanBSVEdXT3ErUEprUEhF?=
 =?utf-8?B?STFjemx1ZHNNQVU5ZzFHQU55NE84MktCK3lwSDhITzBuMDU1akhSM0lFTS90?=
 =?utf-8?B?emxZMGk4RUVITnBEa3QzdDY4NndXMjBUTDlzZS9FNjB6YWRGZ0xiTDlHYzVG?=
 =?utf-8?B?SkRPZDF3alRwM083UkI1eWZmWkduTW5rK2VZWVIxOHB2VHoxQm9UTjlCL3hC?=
 =?utf-8?B?aTErbzkyaEY1SnpNUlZnZFpHVVpnc1JpWEpyNmJRcnZXZ1dmcm1tM1kvN2pn?=
 =?utf-8?B?VkRnYmE3K2VDZTRVR0dpZTAyTkdPeGtLL0ExUU9XcUR3VnUwaTJFZ0xMeUtC?=
 =?utf-8?B?QWNHb2hZbW0zU1NQYlBXTzVZQk14VXA3Zjkvak01NHdXYW95RU11OTByOE0v?=
 =?utf-8?B?Tkh5S3I0aURUVDJ3MnZna0JYMUh3UHE4V0cvVFJGM2RQYnJqSFN0ZEgrdGQ0?=
 =?utf-8?B?V0xOekpIcVlBVFJFNlNlbEMvYUgxb0NpU0RjTUxpK2s5SEEyN1RnTmN3QzRF?=
 =?utf-8?B?RHMzTXZOWlNoaVNQN2FtR1F5NWVEcUIwTThDcXBuNXI4cGowQndnaFdCYU5t?=
 =?utf-8?B?ZGk4aDlrQzJJTGtUKy9RamxJUWRlV1k3NVdadkhjc3BiQVloc1lVYlFwOVo0?=
 =?utf-8?B?SHp1bTlJNHAvYVI5bFRySENOSFpRS0ozVXN1ZUg5K1FrUnB5OEl2L3pwdkpz?=
 =?utf-8?B?L1Q3ZXRtMWRtMUROZDhkK3p0SUQ3VllONlk4RXZVNXZPN2IwVVhqSzRjcVpB?=
 =?utf-8?B?cWRNeTdMLzd3eGVuWW4rZTk1Nm42UHZtTEhpYzVWVW5sNnJmM3d2d2x0REJ2?=
 =?utf-8?B?VUsxV0ZjOTBXbU4waTBEZENyMnJXc0NXNG1KWmI4c05YRkZ2UUVnbEJJbWQy?=
 =?utf-8?B?dkJVZXEzRnNJQnBEazF5eHVzUlJobURsa1J2aTBTaENmUjYxZVJVcVZnZ0ZP?=
 =?utf-8?B?QXJ6SWtRM3Z5RGpFYVZxZE1nZUsrN1lLT0NGT0EyenY1NngzWmJiUE9PRGxo?=
 =?utf-8?B?QzJFdWZqelZRREhoWllGbUhmUk43eGdQNjAwdTk4bzFTNlZ4eHFLNFVhUFBJ?=
 =?utf-8?B?UEhGS1hTM0NubG1KWGhVVUsvbFpjRDdwVTRDVngvQ2xXREZzejJNRTRaYlhP?=
 =?utf-8?B?eHV3OHJNUjRoT2JvVTF2SGhFQm5UNTJremdtK001Umh6VytqcGZycVd5YzhL?=
 =?utf-8?B?bk8yMk8vdUF6aDFNMW9GRlI3M1VTODIwYzROMm9jLzhoZzExMTFkSFAxVVlJ?=
 =?utf-8?B?Zmhya3l0STZPVGZUOXltZEp4RDRKb3YrM245MkZFcHFqc3I5R284OE12NnNu?=
 =?utf-8?B?TVZFOGs5L2h6UzVGYTlidE10dEM4L0dxdlhTbFJ2V3VIOUlYWW1rSEFtZk9T?=
 =?utf-8?B?MUFkTGp0cC9Fak9pajJlLzFVanVJTXRlSDZ5a0VhdVgzOUNHR2xGSUgxL0FX?=
 =?utf-8?B?RnpsazBJeS9jQ1plTnBUZi9pUXhlYStBQzhHVUJOb05ZbkFTQlRBMzRTQjVs?=
 =?utf-8?B?TFZiaEFQeEdiWWExYlRFYlBNOG83bmZwQUp0enFCVDE5bnhvb2UvaXA3bVdk?=
 =?utf-8?B?Wmw4SllxOGRvMVRoUDBjUU56cEVUbm4vb0JTOGZIQ2Ywazl1dFhHUjZTdEVT?=
 =?utf-8?B?aUJUdHVra2pySHhUT01VWUVJOHk5RU14N0gvZ2FabWhxUSs5VzByZ2s0d1Nn?=
 =?utf-8?B?ZjRDY3hHbE9QT2xtSm9uc21yVW91WnNUbUR6bnViVk4zYUgwU3JGQmlXRTRL?=
 =?utf-8?B?UGlqUzJaYnF1UEtuUElpYktLSkdNYUQ1b1VUbVNReXh0Y1dDN3d2Mmg4TVB0?=
 =?utf-8?B?Y3NnaHowWlFJMzE2anBJSzM1Q2NvcE5mL09PSjh6MU5KaE1adWpsR2E3Wm5i?=
 =?utf-8?B?MWQ2TkxZOVdCQi8yWThZQTFuSW5LNXZIbWhsZzI2RHVDbWdGQ1Y1aitrb0tS?=
 =?utf-8?B?TUFWbW5vV0xRTk9BazNlNDJNMUFuQ2xEb0hJM2R1djY0ZVBWWWZSOTNBaUh3?=
 =?utf-8?B?MjNDSFJlb0VHQVhOWWxQTnNHSHRPWVpuQ3hueEw2K0YzSkhyRG4vdkwxbVNC?=
 =?utf-8?B?U3YzSkRGTEd0aUNjaGlDRzlaMTM4RVRsZ0szc0lwcGIxNG1QYnZwU0ZpNlFO?=
 =?utf-8?B?M3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e58d42-7529-49e7-978e-08dc34199f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 02:46:23.3596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIQM4oGhBQHhF5CgWGGFnKAC/8ypMMq4OyLBNwmm+wePL8P/N6zdxJXRgjbmf5Qkkxhq2Yv6bpcitzaW7PW2OKELf+rzuDognaV6MBEL/kqRm1MDMzBpZIZujVydjNG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0464

SGksIEphaQ0KDQo+IFtQQVRDSCBSRkMgMDIvMjFdIG1lZGlhOiBjYWRlbmNlOiBjc2kycng6IGNv
bmZpZ3VyZSBEUEhZIGJlZm9yZQ0KPiBzdGFydGluZyBzb3VyY2Ugc3RyZWFtDQo+IA0KPiBGcm9t
OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IA0KPiBXaGVuIHRoZSBzb3VyY2Ug
ZGV2aWNlIGlzIG9wZXJhdGluZyBhYm92ZSAxLjUgR2JwcyBwZXIgbGFuZSwgaXQgbmVlZHMgdG8g
c2VuZA0KPiB0aGUgU2tldyBDYWxpYnJhdGlvbiBTZXF1ZW5jZSBiZWZvcmUgc2VuZGluZyBhbnkg
SFMgZGF0YS4gSWYgdGhlIERQSFkgaXMNCj4gaW5pdGlhbGl6ZWQgYWZ0ZXIgdGhlIHNvdXJjZSBz
dHJlYW0gaXMgc3RhcnRlZCwgdGhlbiBpdCBtaWdodCBtaXNzIHRoZSBzZXF1ZW5jZQ0KPiBhbmQg
bm90IGJlIGFibGUgdG8gcmVjZWl2ZSBkYXRhIHByb3Blcmx5LiBNb3ZlIHRoZSBzdGFydCBvZiBz
b3VyY2Ugc3ViZGV2IHRvDQo+IHRoZSBlbmQgb2YgdGhlIHNlcXVlbmNlIHRvIG1ha2Ugc3VyZSBl
dmVyeXRoaW5nIGlzIHJlYWR5IHRvIHJlY2VpdmUgZGF0YQ0KPiBiZWZvcmUgdGhlIHNvdXJjZSBz
dGFydHMgc3RyZWFtaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAu
eWFkYXZAdGkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWkgTHV0aHJhIDxqLWx1dGhyYUB0aS5j
b20+DQo+IC0tLQ0KDQpJIGFsc28gdGVzdGVkIHRoaXMgcGF0Y2ggb24gU3RhckZpdmUgSkg3MTAw
IENBTVNTIGFuZCBpdCB3b3JrZWQgZmluZS4NCg0KUmV2aWV3ZWQtYnk6IENoYW5naHVhbmcgTGlh
bmcgPENoYW5naHVhbmcubGlhbmdAc3RhcmZpdmV0ZWNoLmNvbT4NClRlc3RlZC1ieTogQ2hhbmdo
dWFuZyBMaWFuZyA8Q2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KDQpyZWdhcmRz
DQpDaGFuZ2h1YW5nDQo=

