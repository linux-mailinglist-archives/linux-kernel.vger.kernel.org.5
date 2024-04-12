Return-Path: <linux-kernel+bounces-142399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F48A2B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6321C21763
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8A53815;
	Fri, 12 Apr 2024 09:23:07 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2110.outbound.protection.partner.outlook.cn [139.219.146.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12270537F1;
	Fri, 12 Apr 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913787; cv=fail; b=r0Wm7j8oq8HmC99R2CTFujPFuEm9UJm/p4ZMDkbCUfcdBLVHX5x85UA7FrB3DlyUcNI2GTHmXHBwWqSMerZ5+rN+cEsHX57/reR3SL6l+4+XZifBW3LnM7Mp9kk6Mo5DmvYFU1GE/UGq9VMDjaPyYLnk2PIO39fM1TejpSyUGlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913787; c=relaxed/simple;
	bh=nsfXByscsTsrkJYkrTmIyQI0UPJhy1uV2JM15gBze/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MM06MvM2JJuNZ2M7SOO+kZZnInElt41PppxD2s0hrUKTo18dUWDfQBDC49PEG5BcR76E7rOyRFqD9ZFDCVArKGqkMREU+qq4YQE0CtG6jgyQ9VXrsTlJSnmOc45kLUBNvV3OHCvNtakOaYiI2mw3ppilqeLVYpdWdQSuAUiJrl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq9ZY9/5RXGLteuMfwxrs1iOP05prw/DBX6scFWOVDL8caLX6NfXgmSGp9CbjOpqI6T3IB+oauUjpZ0ov0avrF3F+e1TRMINeM6jY6cfY68pma1jMenHWPzFrv/8ysD2RE26YaTk/gqa6oACAbISnL2pm/2XVkS6XXUVxS5gTqHAGGwgorU+AlKbx6JKSzVzyNg4FWG1KdIVuLvpeqkl+POLMTS1ZAPqCiKhu/nwdV6MA8YPcvHY/gjNrjLhLn9W4Scx+7OCCQ8FkO23VvUbZrfV/GmEgM6+qXqENK5XHA0ZgE48sGI4U6PN8MZz2kE7t0CHYRm5oISkAzg6+j/Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsfXByscsTsrkJYkrTmIyQI0UPJhy1uV2JM15gBze/8=;
 b=BOpGIY3mb/KWCChu4/Gb2HboyXDfJjMQPIhVTWHp19O+7lcr+uycn1wJGfGd01Ex+i7lhYQ+DFZZ1mdnsu/QVIy/EGfsVHPPQupsF7f6LOdA/X+V639P1AWs3bcVDVzN2O6PMWwBstzk6gOukREn3SPjL9WTvTO0dkbzfk5oPeuDbo09cJP/o51QAGMPnlUrtigpiwlawQGpLMfEe+L9DKTxASEY3tj5APr21SCG60W0OH5o6/9vfaz6atBHf2ORrZ2PmmAb4Qv1oQmGhgFRSpnTTDsA1ci49G/52PMs4ZbRzlPWpaHiHR7vVhnfYsPlWcK2LsNt2BC2cQ93vYQVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:48:19 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 08:48:19 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] clk: starfive: jh7110-sys: Add notifier for PLL
 clock
Thread-Topic: [PATCH v4 1/2] clk: starfive: jh7110-sys: Add notifier for PLL
 clock
Thread-Index: AQHaivejELTw7uowOEWZFUqhB7mbD7FhI7sAgAMxGjA=
Date: Fri, 12 Apr 2024 08:48:19 +0000
Message-ID:
 <NTZPR01MB09568F1094DFB1F0BBFE29ED9F04A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
 <20240410033148.213991-2-xingyu.wu@starfivetech.com>
 <858299c27c63aa2974b169f9adf624e9.sboyd@kernel.org>
In-Reply-To: <858299c27c63aa2974b169f9adf624e9.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1019:EE_
x-ms-office365-filtering-correlation-id: fe2f1c94-efc0-4cd1-280c-08dc5acd4d59
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ovXyooCcACVdZp0PlxMqeScxTQJQVm5q3Wlu96GRJaf64Fwk6II/Y1c+mR65GE8GXSoQslBteTnJtz5K3Nsw2TVX6754CwV3X55rpFs429twhsVs4xsqPJd13Ofqi9G2OIc5cl/yBLNvRESntUPrMXz3MLzxdaeWue4dI/bteqFyJwXfqT8GPS4WCimgsu93v/94gI4B/Dy8otueLAzXw//AQSFKUBMdg9/CScPDx7Mr8XWKc2Kx7B3bDufEwQdjgJEStISEsF4w6qUogbUJTUDdwIT7EeJmVJW+Qb/049p8/CyFuclhap2YmB79XWuhrnhNQPbEpZtyik2ZtiO2nzrg7I27Vunm1rGU5gHCKoIStcagItnT3Ve4OC/w2PbnOKEl1kunm6l5LhiRtxR9/OPGMY8zkMoPToUZ4AeUnkLDbO0uGamWlWOwo9cUVAlwB+0EUhgeiGTaqt93XKCHdgIIa7PUmqS8OjI66BuZE1izEMdviyeHD9DfRGY0HvC0bXrv++iBiPIRwdF1PVqMgvRkytlV2LJJvUFivmGDg4lntxAqxLUeZonUq0cHCZaw9hdNFwCIuwRC2eAEpPdkMfMMIzqyYran0ZaCln9RkjuVhs8se9TGqrysH96zFczi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czNQTklDWjh3ODk5SnN6V0U3Y3dXOFhUN2FwS0dhOUVVMWhoK28xOFgyeDV6?=
 =?utf-8?B?QUN3ZWVKT1cweGpkcVVmSHZsOWxHY24yNlBRR2lKbGJzZnk1dkRFYUFmeFBl?=
 =?utf-8?B?R1g0UU0vVXhVRVhyQTFZVVA5VGd1b2dQVjNDQ0l1R3JzVUY1bWMvSEJHVjBX?=
 =?utf-8?B?aTJyTzFVbllxb1BrTmJsakNsNWV1aXRJWTh1TzVRTUxuYjcwWSszb0RkNkZG?=
 =?utf-8?B?UC9zNlY2R0pLbGY3cFJ0dHJnVWhlVS9rZGliVThja3hnVTMzRlVJbGpoN250?=
 =?utf-8?B?alhMTXRDbWhZZWRydGNHZ212Q3U0VXUveWRKVkpNR2cyaGd6N0VPQnV5Yjlu?=
 =?utf-8?B?dHBQTTdtZm5aQ3ZqWjA1S1M0ak5lOWpIUUNPdnZ5em40RklaYVZud1UrM3VD?=
 =?utf-8?B?RUlwTVdFVU5IOTlmQmVNclVqNklGTUI1R3ZBZDBrZHNuOGY3ODB4QTRYcEk1?=
 =?utf-8?B?SnZWS1ZnM0tLcUl6akZhRzVjWVB3M0tvWTVBS3diWGIvZTF1MUZ6d0hwK2pp?=
 =?utf-8?B?cmtCYmMwM0F3RnZkdkk0OFFvYmV1UkplTUFmRDMrQ3lCMFpNdGFjVnQ4Y1ky?=
 =?utf-8?B?QnpYRkUvam5VRVVVU1Bvc3VtVm1ya1lPa1ZKcWNNaWJxT2llc28yaE5ubXM3?=
 =?utf-8?B?OUdlV3NJUkkyOXdlYnQzRFdtVVpnSXZkcGl0UmZ0dHcwTmp2ZU9Cd3ZYeXNI?=
 =?utf-8?B?OWdkK29DWllyTUpJYzlQZjhLcWJmSVlTQTJvR1kwVGc0L2FUYnhhSTlxOWVV?=
 =?utf-8?B?YTlkTU82eUFlK3VUZkdsdFk4RytScjZ3Y0ZyM0VDVTkyK0JZcERpQTlnWTN2?=
 =?utf-8?B?WTd3cEZDWnRuR2NxaWFpaWRqU2YzL2RlTGp3Sk95UFRHWUdmamJWbTlCOVFv?=
 =?utf-8?B?cm92SzlsdFgxSEJxZFdUUzB1ZVhuUGxodWE0QnMybER6TmF2L1g4THR0SEpG?=
 =?utf-8?B?QkpNMDkvQTRsRFM0WFZwbm9oYU10VW1HaG9TWGxxaUl2QWZCQytpNjlCTk9n?=
 =?utf-8?B?MUtuSkUva01yRS9vNEZnM0psUUllYkZQNGROU1RwYlpadzIzVGtTZm40TzhV?=
 =?utf-8?B?byttNGZRZTl3ZFkvVU5wUWhGSnFBNGNzbDVGSmhoM0VUQ3RDQkhuSDJHTWpu?=
 =?utf-8?B?QmZRYi85Z1NJQitnWkFqQlhoNE8vUGNSTkhQK3FKTWpzV01TK2xRcHVNVW5R?=
 =?utf-8?B?R3dRNjNiR3o1Q2ZvVklBUytLR2t1Ykx6azZNTDBHNEN0V3N2T09TbVVZV0x2?=
 =?utf-8?B?ZnVYTlhGTXU3WkZSa0g4Ym5IdFU4VEVXaEhwckJwcXZ2RU1wdzVvTEpSRGNG?=
 =?utf-8?B?RStVVnhqSGNlOFd0ZjNaMGhvQTV2VFMvV0NPNmUxcExKRmptZ1k4YXl2OFdP?=
 =?utf-8?B?VGJQcTNLMUJpVHRQa2ZzSjBwRVhxRWdhUzdEbmNJMStxSm0zeUN4Tlh4dmds?=
 =?utf-8?B?N0tXenZFS0wzWlBvemUzUDB5U3E3WlZTeGpjNUtrY3hENW5PWDJhVzNHZFpp?=
 =?utf-8?B?UEh5UWVOL3FBVkUwYnN2UHVvbURueDVzaTNoR3IxRDM1QjREQm9zOXYvbzNY?=
 =?utf-8?B?ZDcvR1d6ZVRnaTRRYXZwdlEydGJFZDJva2ZHLzk0ZHpDeVRjYTF1UjJPN2My?=
 =?utf-8?B?b2c0TUFKeTlyRExzZHJhOXVNQVR5UzM1Ri9vL3d2cWZBRDcvMnphYXdseVo1?=
 =?utf-8?B?MjYwankvMFRLMG9ZcENjUnJoeU55K0hSR3J1MTRJcmJLUUFjNmptYjdPNlZs?=
 =?utf-8?B?UWNXVWE3SDBpTFRaU2pBdk5HYThUdTZGK1YrbVQxUTQvR3pvQi9GSDNDTE9F?=
 =?utf-8?B?bEI3OGFTUnBHeUZybXU4c2JUdXhoSmNGeFV3RTFWRXZDT0JDZnR1YUNpUVdG?=
 =?utf-8?B?S2hFeEhoTW5VdTBGMFJ0VmhOMUJzK2pwc0NVYTN3WDZzMSs0MWVsQ2RGR292?=
 =?utf-8?B?K0tPcTBTQVlxL0laSlVRb3Q4WDFJenFxUDE0SE1FMEdVaDBoV3VxNGwyZVUw?=
 =?utf-8?B?OUFycHFxek1kU2pSVUZtOWU2UjlyR2duUFdHSC9qbFZQL2tCeW0rRGZybzJB?=
 =?utf-8?B?d2NjamU4c1lYMCtBazJ1eUJRVUJ3aS9qY1hxdE9lalpiNG9MRDV6d2hjZUNH?=
 =?utf-8?Q?OE+lHLg9QrJWtFetWf+R8eVq1?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2f1c94-efc0-4cd1-280c-08dc5acd4d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 08:48:19.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NynfWusYYcK1iBXgvmoIvG5jU5iuTS+XhcgZEPNXvGaOSvTomPSmxi3tkYS7KoUUeaqIC62xxgwCFNyBZm1l+K0KdTcEKBpp2GFf7oC9Xj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1019

T24gMTAvMDQvMjAyNCAxNTo1OCwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiANCj4gUXVvdGluZyBY
aW5neXUgV3UgKDIwMjQtMDQtMDkgMjA6MzE6NDcpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxMTAtc3lzLmMNCj4gPiBiL2RyaXZlcnMvY2xr
L3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxMTAtc3lzLmMNCj4gPiBpbmRleCA4ZjVlNWFiZmEx
NzguLmFkZjYyZTRkOTRlNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9j
bGstc3RhcmZpdmUtamg3MTEwLXN5cy5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvc3RhcmZpdmUv
Y2xrLXN0YXJmaXZlLWpoNzExMC1zeXMuYw0KPiA+IEBAIC0zODUsNiArMzg1LDMyIEBAIGludCBq
aDcxMTBfcmVzZXRfY29udHJvbGxlcl9yZWdpc3RlcihzdHJ1Y3QNCj4gPiBqaDcxeDBfY2xrX3By
aXYgKnByaXYsICB9DQo+ID4gRVhQT1JUX1NZTUJPTF9HUEwoamg3MTEwX3Jlc2V0X2NvbnRyb2xs
ZXJfcmVnaXN0ZXIpOw0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIFRoaXMgY2xvY2sgbm90aWZpZXIg
aXMgY2FsbGVkIHdoZW4gdGhlIHJhdGUgb2YgUExMMCBjbG9jayBpcyB0byBiZQ0KPiA+ICtjaGFu
Z2UsDQo+IA0KPiBzL2NoYW5nZSwvY2hhbmdlZC4vDQoNCldpbGwgZml4Lg0KDQo+IA0KPiA+ICsg
KiBUaGUgY3B1X3Jvb3QgY2xvY2sgc2hvdWxkIHNhdmUgY3VyZW50IHBhcmVudCBjbG9jayBhbmQg
c3dpY3RoIGl0cw0KPiA+ICsgcGFyZW50DQo+IA0KPiBzL3N3aWN0aC9zd2l0Y2gvDQoNCldpbGwg
Zml4Lg0KDQo+IA0KPiA+ICsgKiBjbG9jayB0byBvc2MgYmVmb3JlIFBMTDAgcmF0ZSB3aWxsIGJl
IGNoYW5nZWQuIEFuZCBzd2l0Y2ggaXRzDQo+ID4gKyBwYXJlbnQgY2xvY2sNCj4gPiArICogYmFj
ayBhZnRlciBQTEwgcmF0ZSBmaW5pc2hlZC4NCg0KVGhhbmtzLA0KWGluZ3l1IFd1DQo=

