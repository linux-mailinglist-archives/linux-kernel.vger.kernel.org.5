Return-Path: <linux-kernel+bounces-119089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86388C40A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B972C1F63E73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3C1272CF;
	Tue, 26 Mar 2024 13:43:54 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D670CC2;
	Tue, 26 Mar 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460634; cv=fail; b=mdiZqnYEppa7xAXWvneajzIaCgTv+/qChwOzKpHvPevQuYE2/hM/EyEseRl0djRBw38MOTFIq0WC+599G6nlymhl61s7lcYwT/mDbx5GKGscfZIonKqXsYjmuXEJYR/d/X4Qiv/k3egie3FDZuaBUev94/fCZG7w+w/lO+j7HDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460634; c=relaxed/simple;
	bh=fgVSZp1/O91+awlYczJc1Vh2BH1ggI7xl9ORKfASGyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5l/wwfT1bgY5uTEeFxeSPB2rcxRl5MgCJWjxTJydEF6PxYCUT8qgUvbAH3K2HKbxv8fRS1XPTW1RUSyJsntZrQwbGVlYwn03iY5UFFgeMx6f7HO366egJpSmI9FynmHxF8IeYy23+VNkPlaQu3Gbp6syUeOgV9+lGZeR4hRTHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avlogUOBHFONAa9mRa6YU4MhjzH5AJ9lkbA57evVeqa+s7m0QnisSRRF4lkZtFl8rxeSyw1lZmH9lcBNzuzT6svmypahKL8Yn3IBedo/y9Sh/Z5hAk5oWOAyIg4IwtOFWZniOfDcmiUE1ozc23WgUKKBfKsXMu77NVxfGN6LdqGCEFWyc3eaP5l4oq3bOFoSEMLvVSvzoMUBRc4Uj6k0LxKzpcZgITLxgMjLI2U2wECF1fDEOs0rcCnoQHyAwCqOIp26k99zPDr47Fe0YDLC4A5j5aBBLaCEoNKNldXYcmJkc7bmSOO/6ClYOTiBjL205MtZe6SnBaxKhIc8zj1wCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgVSZp1/O91+awlYczJc1Vh2BH1ggI7xl9ORKfASGyY=;
 b=TFkKs4PuNtvyIjt2TluQGP+xmIK+ZbXNk8s+3FXdckHArE1vc1dL22gDjnIi2v5HFooyS+rmdhzhRYw4eDNTR/pldRd6HyDQAVurx8Pv0RDig4pxrWNjkUARIGjr2E/IuvjaeYki6x3LZORw3VZ0Otoc1OPJMq4N9Hr8ETrK1I4wLDl1bV8bgL2sbJApx1+hqdUthpoZwLrLeXOgh3GrSEh2/Xd+obSfJISBl9FT0xMp9miI6fTdNEdDjrW0pU1IJYL0DqeGdbq1m6Jn0o6YLmyqHwJusaj+CgLObEX2QDDcNE3Sk70ZdS7yiNpKsGB9lBxYBOL9NHmBLZavtyDs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Tue, 26 Mar
 2024 13:43:22 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Tue, 26 Mar 2024 13:43:22 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject:
 =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gQVNvQzogZHQtYmluZGluZ3M6?=
 =?utf-8?Q?_Add_bindings_for_Cadence_I2S-MC_controller?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8yXSBBU29DOiBkdC1iaW5kaW5nczogQWRk?=
 =?utf-8?Q?_bindings_for_Cadence_I2S-MC_controller?=
Thread-Index: AQHaeqVg8Gitft8lDUSWv/hm2rXn9rFB3QUAgAeCKECAAD4OAIAAZEYQ
Date: Tue, 26 Mar 2024 13:43:21 +0000
Message-ID:
 <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
In-Reply-To: <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1002:EE_
x-ms-office365-filtering-correlation-id: 883d5523-c0ac-458c-94fc-08dc4d9ab3fa
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 np4yAnpiSm/v06FQnuRY6pT08OGbG44/pzwpuqOvF6LSanmvvtesokUH5P9LPxXt0gRbRZPJwhAMfpZqDalfDyH8xOR71YTw2oYqGZ3CQcaI+h/kGJOnOUGLZQl079LdVGYremQqNhVlDeFvM5WxZ74EnuJocExA2hOfIRBOUUa/MKutTUQVtjz7i/dlO8lvlp0KAUTySvrUuVmPI9rqi2RvYFYH3onfL/aNnZ3YcBbVT/G6SEWQXWtjAHsVQg1oDdXAtJf43naye4Dno2esAWs/QYLkGA4KbeSfhr/oTBktCN1twwpLuN2T8RXGOCuKgY3qE7rWs3pivkrTuhTPIxps2t1fDxGJseuaZzrEVT/IXhyfkzRrUHt2FzpnhK1xfp5ofBsh8ZXEb6cDzxYm69Xv/hW9b3p6gDfQuBafwZ8rsWe/xgiLGF9WvqMFPTPVtoMcpKTYdHV7ZGAgE1UTzpyxSYbPWeUbAFYDswBRV55Fn6zBqb0Bp9HNVK/8jtdeng3UsfRVP2qPtVbfmSIGAhUwjdZ2bGyYNireevcFauOMmRybtqLOCX4BhnGs3y5b+38MEYZj7tcButgcEjTgoUhZPgBSbzW60SN7oG5a0lLejg0kDorWPAkX8RdXinY0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0o5NTQ5R2tmU2JLK0JpbnN6M3lmRVdrK2ppNU5vaFZOZ2dneENITUQ3ckpz?=
 =?utf-8?B?NVpTcVRhYkkvTE4rTlROeWZwM0g0dDZIZktvK3M3WWd0WktYM29CY1lnUmJ0?=
 =?utf-8?B?WFQzamtQOEUvMHNlWUJRSWhrcWpMbndpZkVKTU0zQTZsN0YrRWMvQUhEUGt3?=
 =?utf-8?B?dUtNUXpwN2JUZzVHME0reDdQN3RZUmJFc1hMSW1sdm1mUVVVcmc5cllNeTRi?=
 =?utf-8?B?dW9YYTVkeTJsdXBrSHJ1R2kwVHppUzNsVGlMc0VtTmZ6UG9WRi9iN1FwTk9T?=
 =?utf-8?B?R090elpuSkJNRjBpNHM0bExzZVBhSUl6S2s4eVAremxqZnRsNDBveVNRQ1JG?=
 =?utf-8?B?eVA1WlJmNmUxRU9pcWtka2tRZ0hlS0kyZXR6dTZsbFQxcllYbnhna0xWSmhM?=
 =?utf-8?B?aVhnU256QmIwTmNza1g5c2lUdGlXeE9zMU4vcW5jTHNzbG8xRTBmQnY4ZjVx?=
 =?utf-8?B?ZG1ycUZqR0RETm53V3YwWlA4RnUzbVR1TjBxdEVDa3kzMXhidzlDYkcvdFNl?=
 =?utf-8?B?Rm1SVE9qa0xoUklrc21ZbEpKc21LaWhXbkJoWVRySThxUmJoaFdIdEJIcS9u?=
 =?utf-8?B?UmVKT1MveUpkbG9Cd1BoSVdNOFdhWllnNjYrOStVeGlsVTNqa1JxaXdIT2lN?=
 =?utf-8?B?UUluTXZtUkVFeTBJK0NjWjdoVUd3Ym0weFpzdTlMcjJUU3FWOHRheExyMmFu?=
 =?utf-8?B?ZEtrL1hGeFJWU20xbHVxYmJYQnNaV09ublRHaFJMVVlpUUQ5SzdOcGdOL3Nr?=
 =?utf-8?B?ejFvZDNuM3NudktWbjg1R3dmVmV6djBkbnFGZ1Bqd053eFpDUkNxZVI2Tmtu?=
 =?utf-8?B?eWp6SEtXNlJtSEdDc3NkYzhMbktGWDJxYWdvSEVTT2VpS2JTVllmWlZDU1gx?=
 =?utf-8?B?eUhmZDVSMUJ6dlFvRjh4MU5aYTBubEtFVzNnMGF5NFNPRFpWbjNiUWp6TnpB?=
 =?utf-8?B?VzRTM1VsRWNodUE2YVQzQU12WUxCb1lrQW5zNnZVNldsSVgrYU5DRnNLaXhO?=
 =?utf-8?B?TWpxbVNicUhmSGJMR1JKUVhIcy9QV2tvVXhJTk9rTmh3djR1TzBCZSthUGtD?=
 =?utf-8?B?N0U4dXR0OHMvSis3dGlBeTBhUkpHZ2J5eGFTYjR2QUZ2dHJqYWxQOVZEdjE3?=
 =?utf-8?B?MVhmcSttNHJPdmFERWpQbXZQNlFTaWNTSGlLSmlaR1BZU2dmTXV2UjFqeGhJ?=
 =?utf-8?B?L1JzRHo1TGtHbTdwamxKZUhFMXRWUURmTExRNW5LWk5oRDRzZWRMZi9oaHVt?=
 =?utf-8?B?aXFxWVhzUXl0VzNkMm13RTFKU3Y3d1I1ZlFLUXJXTFdFcXZ4U3ViUWdIR3R2?=
 =?utf-8?B?R3pTa0xOVFZQZ21RN1NuQW9SenQ4amdTVmFUcW11ZFh2eGlWY29PUWNhTnVF?=
 =?utf-8?B?WWRhdjB1WkVGN0wxZUl0N2VVWVFaN1pjdGxMSVZIeGV5MjB2WC9Fczc4bHhU?=
 =?utf-8?B?NEw4WWswY09oQXBPM0hqM3F4d1l2N0xPRmh2Z3BlaWVkNFA0cHJ0UUQ5Y2No?=
 =?utf-8?B?THRiMjJXTlhQNXdBaWZqUlJmYzcyQ1ZyT0JYTVpQMnk2YjNmTGpBdm5kejJm?=
 =?utf-8?B?T09uVFFJWGRJMkw1enlvZGxqWGhEV0RNTTI2anBLR3loOXowRDdQcFFoa3J5?=
 =?utf-8?B?emJ5YUJYWmpBelowbFlKZElzQ21vTVk2S2tqNXNGZG1BTTJhdjc0MHMvQWdB?=
 =?utf-8?B?alRqR21SeFhlRFZvSUY0dERRR1JXUGNFeWFxNzA2bGxySXZXN2NlU0hPbmZs?=
 =?utf-8?B?dzZpMS9uUEh4ejAwdms3WGRoTHRRQ1Jrd1FLRmduSjM1Y3QvOEdPMEUzTXMw?=
 =?utf-8?B?UFdJMzBKNUt6UzEzdW51MnJVZk9CUjFnWE50a05vVFZjWUdRYnpwa2c4bitT?=
 =?utf-8?B?WC9xMEp5R2MxNitjWWlHYmVIeXRnYy9xQ0hvUlhOS3lsUlNNMWlhQS9MZzFV?=
 =?utf-8?B?bG8ra1pTUW8wdTlseFRIL2hNV1FMbXRkcmpMTTJncFp5TTRNWm1nWkpjVjNr?=
 =?utf-8?B?aTRLaW0vOFNwM0JWdW5mbERxNDFFSFFGbHhmanZNbTlvUVFYLzc0eE5tcjZU?=
 =?utf-8?B?MUloTlFQZVJlRkY5R0Vqd2xoMWdYQm1EL3EyOVJvelpzNnBiWDBjeUpzZHNt?=
 =?utf-8?Q?LsHUDqD5TFr97z29vTrMEW59w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d5523-c0ac-458c-94fc-08dc4d9ab3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 13:43:21.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xi73DyGMqO8G+CqqTOSxZVaXaHyPrFtnt35iYlPH/Od4NmRXDMQ8OCpQVrRI1GMZbIG31hKB2mwMBRhZmuSxm6c/BM3OOTRfKn4HWLiYRHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1002

T24gMjYvMDMvMjAyNCAxNDo0NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gDQo+IE9u
IDI2LzAzLzIwMjQgMDc6MjksIFhpbmd5dSBXdSB3cm90ZToNCj4gPj4NCj4gPj4gT24gMjAvMDMv
MjAyNCAxMDowMiwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+Pj4gQWRkIGJpbmRpbmdzIGZvciB0aGUg
TXVsdGktQ2hhbm5lbCBJMlMgY29udHJvbGxlciBvZiBDYWRlbmNlLg0KPiANCj4gWW91ciBlbWFp
bCBhcHAgcmVzcG9uZHMgdmVyeSB3ZWlyZC4gWW91IGJ5cGFzc2VkIGFsbCBwb3NzaWJsZSBmaWx0
ZXJzIGFuZCBpdCBpcw0KPiBzaW1wbHkgbm90IHZpc2libGUgdGhhdCB5b3UgYW5zd2VyIHRvIG1l
LiBZb3UgUmVwbHkgdG8gZXZlcnlvbmUsIG5vdCB0byBtZSB3aXRoDQo+IENjIHRvIG90aGVycy4g
VGhlcmUgaXMgbm8gc3RhbmRhcmQgaGVhZGVyIHdob20gZG8geW91IHF1b3RlLCBlLmcuICJPbg0K
PiAyNi8wMy8yMDI0IDA3OjI5LCBYaW5neXUgV3Ugd3JvdGU6Ig0KPiANCj4gUGxlYXNlIHVzZSBz
b21lIGRlY2VudCBlbWFpbCBzeXN0ZW0sIG90aGVyd2lzZSBJIHdpbGwgbWlzcyBhbGwgcmVwbGll
cyBmcm9tIHlvdS4NCg0KVGhhbmsgeW91IGZvciByZW1pbmRpbmcgbWUuIEkgd2lsbCBjb3JyZWN0
IGl0Lg0KDQo+IA0KPiA+Pj4gKw0KPiA+Pj4gK3Byb3BlcnRpZXM6DQo+ID4+PiArICBjb21wYXRp
YmxlOg0KPiA+Pj4gKyAgICBlbnVtOg0KPiA+Pj4gKyAgICAgIC0gY2RucyxpMnMtbWMNCj4gPj4N
Cj4gPj4gV2h5IGRpZCB0aGlzIGFwcGVhcj8gV2hvIGFza2VkIGZvciB0aGlzPyBVc3VhbGx5IHRo
ZXNlIGJsb2NrcyBhcmUgbm90DQo+ID4+IHVzYWJsZSBvbiB0aGVpciBvd24uDQo+ID4NCj4gPiBJ
IHdvbmRlciBpZiBJIHNob3VsZCBrZWVwIHRoZSBvcmlnaW5hbCBJUCBjb21wYXRpYmxlLiBEbyBJ
IG5vdCBuZWVkIGl0Pw0KPiANCj4gQXMgSSBzYWlkLCBpdCBpcyBub3QgdXNhYmxlIG9uIGl0cyBv
d24sIHNvIHVubGVzcyB5b3UgaGF2ZSBvdGhlciBhcmd1bWVudHMgdGhlbiBuby4NCj4gQnV0IG15
IHBvaW50IHdhcyB0aGF0IG5vIG9uZSBhc2tlZCBmb3IgdGhpcy4NCg0KSSB3YW50IHRvIGtlZXAg
dGhlIG9yaWdpbmFsIElQIGNvbXBhdGlibGUgd2hpY2ggY2FuIGRpc3Rpbmd1aXNoIGZyb20gdGhl
IEpIODEwMCBTb0MuDQpDYW4gSSB3cml0ZSBpdCBsaWtlIHRoaXM6DQpjb21wYXRpYmxlOg0KICAg
ZW51bToNCiAgICAgICAgICAtIHN0YXJmaXZlLGpoODEwMC1pMnMNCiAgIGNvbnN0OiBjZG5zLGky
cy1tYw0KDQphbmQgSSB3cml0ZSB0aGlzIGluIHRoZSBEVFM6DQpjb21wYXRpYmxlID0gInN0YXJm
aXZlLGpoODEwMC1pMnMiLCAiY2RucyxpMnMtbWMiOw0KDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiAr
ICAgICAgLSBzdGFyZml2ZSxqaDgxMDAtaTJzDQo+ID4+PiArDQo+ID4+PiArICByZWc6DQo+ID4+
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4+PiArDQo+ID4+PiArICBpbnRlcnJ1cHRzOg0KPiA+Pj4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBUaGUgaW50ZXJydXB0IGxpbmUgbnVtYmVy
IGZvciB0aGUgSTJTIGNvbnRyb2xsZXIuIEFkZCB0aGlzDQo+ID4+PiArICAgICAgcGFyYW1ldGVy
IGlmIHRoZSBJMlMgY29udHJvbGxlciB0aGF0IHlvdSBhcmUgdXNpbmcgZG9lcyBub3QNCj4gPj4+
ICsgICAgICB1c2luZyBETUEuDQo+ID4+DQo+ID4+IFRoYXQncyBzdGlsbCB3cm9uZy4gWW91IGFs
cmVhZHkgZ290IGNvbW1lbnQgb24gdGhpcy4gRWl0aGVyIHlvdSBoYXZlIGludGVycnVwdA0KPiBv
ciBub3QuDQo+ID4+IFlvdSBkbyBub3QgYWRkIGludGVycnVwdHMsIGJhc2VkIG9uIHlvdXIgY2hv
aWNlIG9yIG5vdCBvZiBoYXZpbmcgRE1BLg0KPiA+PiBEcm9wIHRoZSBjb21tZW50Lg0KPiA+DQo+
ID4gRG8gSSBrZWVwIHRoaXMgcHJvcGVydHkgYW5kIGRyb3AgdGhpcyBkZXNjcmlwdGlvbj8NCj4g
DQo+IERyb3AgZGVzY3JpcHRpb24uIEtlZXAgcHJvcGVydHksIGlmIHlvdXIgaGFyZHdhcmUgaGFz
IGludGVycnVwdHMuDQo+IA0KDQpXaWxsIGRyb3AuDQoNCj4gLi4uDQo+IA0KPiA+Pg0KPiA+Pj4g
KyAgLSBjb21wYXRpYmxlDQo+ID4+PiArICAtIHJlZw0KPiA+Pj4gKyAgLSBjbG9ja3MNCj4gPj4+
ICsgIC0gY2xvY2stbmFtZXMNCj4gPj4+ICsgIC0gcmVzZXRzDQo+ID4+PiArDQo+ID4+PiArb25l
T2Y6DQo+ID4+PiArICAtIHJlcXVpcmVkOg0KPiA+Pj4gKyAgICAgIC0gZG1hcw0KPiA+Pj4gKyAg
ICAgIC0gZG1hLW5hbWVzDQo+ID4+PiArICAtIHJlcXVpcmVkOg0KPiA+Pj4gKyAgICAgIC0gaW50
ZXJydXB0cw0KPiA+Pg0KPiA+PiBUaGlzIHdvbid0IHdvcmsuIFByb3ZpZGUgYm90aCBpbnRlcnJ1
cHRzIGFuZCBkbWFzLCBhbmQgdGhlbiB0ZXN0IHlvdXIgRFRTLg0KPiA+DQo+ID4gSSBwcm92aWRl
ZCBib3RoIHByb3BlcnRpZXMgaW4gdGhlIERUUyBhbmQgdGVzdCBieSBkdGJzX2NoZWNrLiBUaGVu
IGl0IHByaW50ZWQNCj4gdGhhdDoNCj4gPiAnTW9yZSB0aGFuIG9uZSBjb25kaXRpb24gdHJ1ZSBp
biBvbmUgb2Ygc2hlbWE6IC4uLicNCj4gDQo+IEV4YWN0bHkuIEhhdmluZyBib3RoIHByb3BlcnRp
ZXMgaXMgYSBjb3JyZWN0IERUUy4gSW50ZXJydXB0cyBkbyBub3QgZGlzYXBwZWFyIGp1c3QNCj4g
YmVjYXVzZSB5b3UgZGVjaWRlIHRvIGRlc2NyaWJlIERNQS4gSXQgaXMgT1MgY2hvaWNlIHdoYXQg
dG8gdXNlIGlmIGJvdGggYXJlDQo+IHByb3ZpZGVkLg0KPiANCg0KQnV0IHRoaXMgSTJTIGNhbiBv
bmx5IHVzZSBlaXRoZXIgRE1BIG9yIGludGVycnVwdHMuDQoNCkNhbiBJIHVzZSB0aGUgY29uZmln
IChsaWtlIFNORF9TT0NfQ0FERU5DRV9JMlNfTUNfUENNKSAgdG8gY2hvb3NlIERNQSBvcg0KaW50
ZXJydXB0IGlmIGhhdmluZyBib3RoIHRoZW0gaW4gRFRTPw0KDQpCZXN0IHJlZ2FyZHMsDQpYaW5n
eXUgV3UNCg==

