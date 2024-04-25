Return-Path: <linux-kernel+bounces-158248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC38B1D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F0A1F26CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872178289C;
	Thu, 25 Apr 2024 09:08:33 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2118.outbound.protection.partner.outlook.cn [139.219.146.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7726EB4D;
	Thu, 25 Apr 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036112; cv=fail; b=kIHfuoxHlOkKpZHxq8zUSc2UWUGrFXnZaAaE+TJrPFpG8eRTJVF2PJge0HPMLsktxQeoGVoqPl2QY2XHBVuHiU+onsNxxpF9UMKGi2gn/jumjfHD65ai/LiAL2aer2H5e6HUZlYUkW6ORAMhq+o1+iojRWWeWu1ghlVtWsSQ0zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036112; c=relaxed/simple;
	bh=WkrlDEOdCdv02uY5YzsN7twTCir4pdnjca+sqQJd08E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SMoiV6d2e07/95pxgiqE+g1OjBoSHVeJfSLPz29rSeTeVyBY9NhAxUjSSzvAnHOr2GI9XKrJ4KMFnUB/wsfJq/R89oBRSgVMhG/FDz33A5WLS5doV4VVERY/UlmrFeVz/d9r2YiYBhPIZ6GGAMrRvIJacD3Wu7UuQrgpbOMJtvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ0Y77D4Q5b39j+dwwu7fXQsFIm/ak0vL7hQEXBLDrL+6G0CM6eoO/yePzoZNyGFicQ9fwBQXm1aF3LNFvEYyhF0w9Jz2tb4ftPKIdnhMbYBU1QyUPXqL2xZCfEoiZql9sd8pQWSg8tchXdhimGm+KbXAKVjwqcr3Ib1p9AQtb5xFvHNZ0aKobslZ2Q5d1HF1vfTaCCcXDN2n6hbK83kYeG+5jazdVr4nT9TDnIv9CHIZljtSFJqv+oAUPce5tdnMDtmxR9OX8d10Ab4/QKbqIci4Zyi3MBOsa0Fno2w8XmK21RoCPhU2+z2dncB8LFUdXpC7uOxm+59D5GLA3l+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkrlDEOdCdv02uY5YzsN7twTCir4pdnjca+sqQJd08E=;
 b=ddbJ3QevVzxZ7X0kKei+Mp+jW1a02qxFkezg9UHuamikywy0IA+9IIkZmEd3x/lUnSpfdcnUuXZRn/TO0hSq+u7zxZFAjnGWtQ5osAP4bn4e4GsF7KRzYjUA8FnwJ7Dr7GlOdo+fliVKNbniaunjv7WF5NVunj271kttCw8LJ0v/COBswhPDwZ4pgL1f0HcTKRaQNPdRnHdKRJYh2IUV2lW/s5U5DH0plIfQw2ndEVx7Yh+2xxW2oLD+WOoI/zeEtqejYVn/K/I7nIjR0M64bIll04Blt7FFYIJ6HoX54SZSx860M8ZDcIWB7ww5Pq7hKmVwTWgJtQXUOug68opswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0985.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Thu, 25 Apr
 2024 09:08:19 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Thu, 25 Apr 2024 09:08:19 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Topic: [PATCH v4 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Index: AQHaiveiGH+bVC0OIUmk/t+RfIuugLF39x6AgAC7tCA=
Date: Thu, 25 Apr 2024 09:08:19 +0000
Message-ID:
 <NTZPR01MB0956902DF5CB459302BA263F9F17A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
 <41835766-b7d7-4f81-aca7-4a8136ba9971@ghiti.fr>
In-Reply-To: <41835766-b7d7-4f81-aca7-4a8136ba9971@ghiti.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB0985:EE_
x-ms-office365-filtering-correlation-id: 1acda268-120e-419f-8476-08dc65074044
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p2x5JhL73xGoJGo4hbMCfo6P1/rDivRFOItKfIvnhF1aMBatzZBwcRHu7tqIrI1pIfp7IYShb+F0oYObsM8OG3j3J+W74J+hk5UDUvZngvk3LNrBi3NE0hLGPHiYd++gOWs30jh75mLJDJIBzPIPfUGc9Ue83JQTS8auGTijxZx1WLR8LWVWxCruvUlidzV2N9JHin+aH2SV/S8ceyF3XkH/Ga6JCYI19bcnbPyY9/a05LN6nYSLVMO8/cZv4DmGLsLK+4wckq28bNSfS6HKicspPyustJWZLmE0pajSDK+JZiN7WhC3HssHizPqIm9tpJOksRdVKajW8uHn4owqqy1C7leyEBgnoK+fOwzriFZR6Vbdb2lW8m3marD97Hqud2NDeJQYKnnKAVXpKsea+4FLQVTcj3vcuKITf3tK4fyrAbGpaDtxKWdIMe3RgTlduGe5u9kIPOJhzHSyRymRvf8lheiMJZI6fMo6EMld5v/SkCZhX1yYmU4oSkLFD1SXsdbiL+RyqHDdQm8bZ9OF2vWfYNUal0UGH43ZBzdFCGK08WH15k4soMHPkA8vPFCXAMmUki2nitpWcNmPg4ceP47GhNwKeeRdZFJi4Hf3e81z0oJEl8jyTh7sFpOGtnN3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zkkra3VaTnFNTjRTNUFhNmRHM0E2eXZmc0VpekVoVEYrMzRnY2l1cXVOT2t6?=
 =?utf-8?B?SFFvVjJqV0RoWlpKU3F2NUw2VnduY2VhRmUxTTlJWVNscWlVNTZoSUZTck5k?=
 =?utf-8?B?QjN2MzZZM2ZSdko0c2MwSlhXMVFYN2hpMVExWk1sMkRVT2JrdmZoRFk4V0Vu?=
 =?utf-8?B?YWxMZENCdFJzQWlVQUlCWjY2OUNSNktIVmFuWGJCclFEUDg1NExIR3NKZzlR?=
 =?utf-8?B?aFZyZXBIWmJLOERkK0tiMjgwSmtnaWFZamtqSGthZ2VybkY1Vlo0cVlkNGhz?=
 =?utf-8?B?cERlZSt4bkIvMUx5ZkJneUlCUVJIeE1oS2F4bTlvbW1UcjF6ZzhJcjBQSmhn?=
 =?utf-8?B?VWN6VnluSDJjNWxrOEtTOFRPUU0yR1lQekk0VGhNSUh4NlRXRXdwc3lKRlZV?=
 =?utf-8?B?NzFhK2NnV0NMUWlrcVhlaU5PZFEwSXpBNVlTYW1LcWpqY2lQNjB3OFpJWEVH?=
 =?utf-8?B?dlZPODgvVTY3QkJtMXBnbko1aDR1MzJ4aXpkM2VmQ0ZBN2ZhdkRCMVZ4OHlI?=
 =?utf-8?B?UnNYcEtyemhvTllyMWt2ckdSanhaNDhUdnpqZjVCTU5LRklLL1dsOUlXN1R1?=
 =?utf-8?B?WmtyUFBkS3FaemMwc1h6ZU9rckUvUjZ5V3lwL0wzdDUrMlhhYXNiOXVNVlVP?=
 =?utf-8?B?QS9BQlYrbDgweGFrb1p6VTh0ak5pczZReVJ4eS9rVm5TZkdQM3ZIN2k5aEZS?=
 =?utf-8?B?c040M1RVVDlCcVZJTnR3dTNncFhsVjZHN1pocDQzV0NPd2FtemNRa21WUm4x?=
 =?utf-8?B?SWhNNHRKaWNnV3liOVZWZ2xWa25UbUs4WDRmb0VBNEUvaHNVdHdzRnNoYUth?=
 =?utf-8?B?TzByU202NTRPcGJuSXVkN3F1OU1SQ2RIYytVYUJVMnJOUDFVUlUwYVhreklU?=
 =?utf-8?B?RzFEa3JIQXMvUjR3bGZRVGp1SWE5dTc2OW10NEFMcFJ2QS9CR1QyeHhXdSsx?=
 =?utf-8?B?eUkzdlh2cTJ0ZmtEa1Bmd29qUEQvT2Q3Q0NpQUFOaGZtT21lMnY3WHZDNEc0?=
 =?utf-8?B?WFVFV0s3Z1VKY3R0ODAzQ2dva1Bqa1RVMndKcXpOcDQvQnV1clNkdWlrMEdG?=
 =?utf-8?B?WU9OZEtIV3ZRNk92aTJoNW4zMkFQR0laN29pNG5UQXdsM090MUJqcGk3WW5q?=
 =?utf-8?B?M0tnbk1zZXFtL3A4MmkydXIvVGdhMldJSm5RalNSbkpJT3hmOFZQTzU0R1BJ?=
 =?utf-8?B?OTU4N3UwYUhyVWFQWnFRYUN3ZlVyMlIyZWpjVG5KV3dwY05SNG55Y1BDQVBa?=
 =?utf-8?B?dittUVpMRG0yc3FwOFBDTzd5eVFwNWZkL0dqSis1cTlKWkd6a0tIOGt1V09Q?=
 =?utf-8?B?aFFRSmx3MHdTeE85UlRhNzEySWp4WHpHYmNzWUNSMHhVUDZ2cXU4YS9ZM1l2?=
 =?utf-8?B?aUhmMURMZlVxZHpyMzRrR1diREowdHoxQjBpVUVsRTdZUEREM1dxc21YZUR2?=
 =?utf-8?B?UFdlSDRKWW9MTytpSlRtc3BHUVJsVitoRWR6eXNkdUk3NFE2M0FpelJiTmMz?=
 =?utf-8?B?T29vZnZmOG9scjVkM0k0ZWFXS0NuQUt2cDNDYzNLc2RYTll0MjV6U1EvV0ps?=
 =?utf-8?B?cEgrOC9UWXd5SVZSajZ1bjdrREpnZkk1R3N2a0VhYWUrZmNhei8rSWxsUkFE?=
 =?utf-8?B?NUVsSmlLeEoySExhTDVZbVl5K05FREx1S1VVU2hKbURUK1JhakZVVVF2NW1a?=
 =?utf-8?B?MDRhZEVZYWpTcFdCNFI0Ri9OcW4xQ3dEMVgwcW5seHUwdTFzZitJRE84K0h2?=
 =?utf-8?B?YThJc1VKWTdQWUVQcjN3SDFGclZBaUI0UGxPUk5QRjdvejFRNmdQZXhFNDBE?=
 =?utf-8?B?cUJDR3NORFVPWVQ0Uzc3a2YyOHBLMm1ZdmppcVN2clhSNitCdmxRNWNEb2RZ?=
 =?utf-8?B?KzFybnQ2K2FRNzNyMzFuVlVPUGdUOUFNTnU4Y0hRSmFRY1JZQXR4eGltZk05?=
 =?utf-8?B?QTlsYkR0NDBTMTJhVEFCVWNONXVNT09SZ0VRUzRnbVBjbDRaUDRGSy9Odmp4?=
 =?utf-8?B?V0pPM1FKYlpQS3FFZzEwZEVBMXBSN0VLM2ZSekFrRTFPR1hyL2pGMzZBcjJO?=
 =?utf-8?B?RXQva1lWTGJWMlpBbUU4SWxKVzJFcW9jczN1dzFvWCttSWRDZG1MSEJtNElm?=
 =?utf-8?Q?SBtmMjsrgRYk8Vme6I9NF/uXr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acda268-120e-419f-8476-08dc65074044
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:08:19.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYoLAtJR23Y8Rf94nZlWRe9rvKDewQ7ArOgXDdips/O61sQ8FVQbl/hNiCLE8btSEdzKRH+ghDVEcFngsvu6XQj7ond2P8Ns3W6nvQCnpHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0985

T24gMjUvMDQvMjAyNCAwNDozMiwgQWxleGFuZHJlIEdoaXRpIHdyb3RlOg0KPiANCj4gSGkgWGlu
Z3l1LA0KPiANCj4gT24gMTAvMDQvMjAyNCAwNTozMSwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2ggaXMgdG8gYWRkIHRoZSBub3RpZmllciBmb3IgUExMMCBjbG9jayBhbmQgc2V0IHRo
ZSBQTEwwIHJhdGUNCj4gPiB0byAxLjVHSHogdG8gZml4IHRoZSBsb3dlciByYXRlIG9mIENQVWZy
ZXEgb24gdGhlIEpINzExMCBTb0MuDQo+ID4NCj4gPiBUaGUgZmlyc3QgcGF0Y2ggaXMgdG8gYWRk
IHRoZSBub3RpZmllciBmb3IgUExMMCBjbG9jay4gU2V0dGluZyB0aGUNCj4gPiBQTEwwIHJhdGUg
bmVlZCB0aGUgc29uIGNsb2NrIChjcHVfcm9vdCkgdG8gc3dpdGNoIGl0cyBwYXJlbnQgY2xvY2sg
dG8NCj4gPiBPU0MgY2xvY2sgYW5kIHN3aXRjaCBpdCBiYWNrIGFmdGVyIHNldHRpbmcgUExMMCBy
YXRlLiBJdCBuZWVkIHRvIHVzZQ0KPiA+IHRoZSBjcHVfcm9vdCBjbG9jayBmcm9tIFNZU0NSRyBh
bmQgcmVnaXN0ZXIgdGhlIG5vdGlmaWVyIGluIHRoZSBTWVNDUkcNCj4gPiBkcml2ZXIuDQo+ID4N
Cj4gPiBUaGUgc2Vjb25kIHBhdGNoIGlzIHRvIHNldCBjcHVfY29yZSByYXRlIHRvIDUwME1IeiBh
bmQgUExMMCByYXRlIHRvDQo+ID4gMS41R0h6IHRvIGZpeCB0aGUgcHJvYmxlbSBhYm91dCB0aGUg
bG93ZXIgcmF0ZSBvZiBDUFVmcmVxIG9uIHRoZQ0KPiA+IHZpc2lvbmZpdmUgYm9hcmQuIFRoZSBj
cHVfY29yZSBjbG9jayByYXRlIGlzIHNldCB0byA1MDBNSHogZmlyc3QgdG8NCj4gPiBlbnN1cmUg
dGhhdCB0aGUgY3B1IGZyZXF1ZW5jeSB3aWxsIG5vdCBzdWRkZW5seSBiZWNvbWUgaGlnaCBhbmQg
dGhlDQo+ID4gY3B1IHZvbHRhZ2UgaXMgbm90IGVub3VnaCB0byBjYXVzZSBhIGNyYXNoIHdoZW4g
dGhlIFBMTDAgaXMgc2V0IHRvIDEuNUdIei4NCj4gPiBUaGUgY3B1IHZvbHRhZ2UgYW5kIGZyZXF1
ZW5jeSBhcmUgdGhlbiBhZGp1c3RlZCB0b2dldGhlciBieSBDUFVmcmVxLg0KPiA+DQo+ID4gQ2hh
bmdlcyBzaW5jZSB2MzoNCj4gPiAtIEFkZGVkIHRoZSBub3RpZmllciBmb3IgUExMMCBjbG9jay4N
Cj4gPiAtIFNldCBjcHVfY29yZSByYXRlIGluIERUUw0KPiA+DQo+ID4gdjM6DQo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNDAyMDkwOTIwLjExNjI3LTEteGluZ3l1Lnd1QHN0
YXJmaXZldA0KPiA+IGVjaC5jb20vDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+IC0g
TWFkZSB0aGUgc3RlcHMgaW50byB0aGUgcHJvY2VzcyBpbnRvIHRoZSBwcm9jZXNzIG9mIHNldHRp
bmcgUExMMA0KPiA+IHJhdGUNCj4gPg0KPiA+IHYyOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3RhcmZpdmUNCj4gPiB0
ZWNoLmNvbS8NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gLSBBZGRlZCB0aGUgZml4
ZXMgdGFnIGluIHRoZSBjb21taXQuDQo+ID4NCj4gPiB2MToNCj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyMzA4MTEwMzM2MzEuMTYwOTEyLTEteGluZ3l1Lnd1QHN0YXJmaXZlDQo+
ID4gdGVjaC5jb20vDQo+ID4NCj4gPiBYaW5neXUgV3UgKDIpOg0KPiA+ICAgIGNsazogc3RhcmZp
dmU6IGpoNzExMC1zeXM6IEFkZCBub3RpZmllciBmb3IgUExMIGNsb2NrDQo+ID4gICAgcmlzY3Y6
IGR0czogc3RhcmZpdmU6IHZpc2lvbmZpdmUtMjogRml4IGxvd2VyIHJhdGUgb2YgQ1BVZnJlcSBi
eQ0KPiA+ICAgICAgc2V0dGluZyBQTEwwIHJhdGUgdG8gMS41R0h6DQo+ID4NCj4gPiAgIC4uLi9q
aDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kgICAgICAgICB8ICA2ICsrKysNCj4gPiAg
IC4uLi9jbGsvc3RhcmZpdmUvY2xrLXN0YXJmaXZlLWpoNzExMC1zeXMuYyAgICB8IDMxICsrKysr
KysrKysrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1q
aDcxeDAuaCAgICB8ICAyICsrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IA0KPiBJIG9ubHkgdG9vayBhIHF1aWNrIGxvb2sgc28g
SSdtIG5vdCBzdXJlOiBkb2VzIHBhdGNoIDIgZGVwZW5kIG9uIHBhdGNoIDE/IEluIHRoYXQNCj4g
Y2FzZSwgSSB0aGluayB0aGUgRml4ZXMgdGFnIHNob3VsZCBiZSBhcHBsaWVkIHRvIGJvdGggcGF0
Y2hlcy4NCg0KSGkgQWxleCwNCg0KWWVzLCBQYXRjaCAyIGlzIGRlcGVuZGVudCBvbiBwYXRjaCAx
LiBJZiBwYXRjaCAyIGlzIGFwcGxpZWQgYWxvbmUsIGl0IGRvZXMgbm90IHdvcmsuDQpJIHdpbGwg
YWRkIHRoZSBGaXhlcyB0YWcgYm90aCBwYXRjaGVzLg0KDQo+IA0KPiBBbmQgYXMgdGhpcyBpcyBh
IGZpeCwgd2lsbCB5b3UgcmVzcGluIGEgbmV3IHZlcnNpb24gc29vbiBmb3IgNi45Pw0KDQpZZXMu
IEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gb2YgdGhpcyBwYXRjaGVzLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpYaW5neXUgV3UNCg==

