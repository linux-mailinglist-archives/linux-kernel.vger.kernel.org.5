Return-Path: <linux-kernel+bounces-111708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B236E886FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672401F230DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B14524DF;
	Fri, 22 Mar 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EsNYOAsT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562C2E62E;
	Fri, 22 Mar 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121916; cv=fail; b=BJguVW17Y/RCBTu0kSO+W80yIgPygiFT3F74pZLJAHaiIwL8VEsoBIFPJrIcT5Jv/nMlMWD8jtLEdutKRFLsnRGNgqpsySj1p82PK6BjT69g4J02D9MQ6kk4wQrjUwkKInwpd9BKyaAU5Mz+uSxQUG5ZLpgmUHsDP+OF7IdQycE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121916; c=relaxed/simple;
	bh=8hzwsZ1wkoMt2D0G8jsFgoEsOojUZhYuC+68j6eRepE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FsgOX9FTPvZNIa9rg4PdkwupLoRlk7Lf5UbDV4bfp1u4axNkjc8/ZberFmjjBAbg/OhNlObitvXvIWrsty22TaaRSnE6xtBRyd6hqfuwbr1U2n81TkUKeoEggmi+SwasnOIMpDxhTuD67YZVX+WaWncd65WUvmC6a1fXdjrcPY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EsNYOAsT; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpEyrr/8YkgGSZ6fKgoIQw6QnGtd/ldUHz1vZ7GV3ZFBdGhPSUbnziS4s9INQPZyn+CuWI+lgVjHwmllecAItJo5gYkMzASnD43HzTGPUw00loog5hc276xwOTC+DIE9VB8SeDIuyvJaooh2XmKS9J5gHW1h+PLqhpJYw+88V77Wd34cL7oRSBEv2lYNa0OnfNcOgpTudK7VoWXA4pGou6bZLEU8q/IAxGELfB8lclX5P0FbL+X56LvnAPtiDcmk0U9oUPhSP3mXIKeWny5hhNpu9E6EDJOrMGmpAPXLUfLm+DSQCIvNVyJJ7BXJDLp/Nt5csemXOvhxJee7GReqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hzwsZ1wkoMt2D0G8jsFgoEsOojUZhYuC+68j6eRepE=;
 b=F+1bc9AoyBKbeKPQyamhLEwmpfW6H0GFwj4cPRkVTW7aVnLCYOeL2gau60u66RcDHQAE7qi2vGMJsKy1rdTXFZd7TeA3iQjkYNCUHVxdwPruf47z9NmQHKNS73DbM1LkhUSlfxg0M/ZlJ8yOEA+0Sz1htVdtSta7Dgli+97p8ymp78mtZ3eA18PMnc2ponkcs2zFA9VWZibrrVrMDrqYdtsBLolOkuF1Ktm9A6+Duwdt3je9iroi5AyCz7C71qBdDFSAfZs5zs3kPtT1iIohtqHHR11UfNx+6KyXcz2VdWd8nHzAIpEXcG9yG8m4P3ZzlDPFrhTI33DeNwu31i5BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hzwsZ1wkoMt2D0G8jsFgoEsOojUZhYuC+68j6eRepE=;
 b=EsNYOAsTGUlBSKriWpNjV/vkFmHURWkpVBonA/zjU/jmd+TdSOk0o2++ZuPoOGFdWB8w6l3S9yzcKjX23SxbaVWAzTtRPIIx8n6KyB21a2zV2OVNhed9v32fak+6G1A46ElbntxulOsDUrk4dhZVlaA24vkuG+A1auZjQiqxtxc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 22 Mar
 2024 15:38:31 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 15:38:30 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Topic: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Index: AQHae9lamF1Na8/mpEGgdJkfFpR9o7FCvoaAgADHmICAADb7AIAAKS8A
Date: Fri, 22 Mar 2024 15:38:30 +0000
Message-ID: <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
 <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
In-Reply-To: <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU0PR04MB9418:EE_
x-ms-office365-filtering-correlation-id: ed6a9252-2566-4207-e0bc-08dc4a86205e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qrv2e6XLxwTvtnVd16VY8lH/kUs2x+H7YJdzIX0/L7MyAhX24s8cDTOFOIBm36fnKqUG4Zx2s2J/aDuS15Is0ffkALngZ9EFUMs9lOTs8Vx/zOBdHwMZBeDtlzu1ieMHtq1eKaoTj4/a85DpXma00pkqXhPSbQEjMJwPDaTBmJ4wk2dXaYrEk178NAXyEzGzlqlRoiU5pUu/OwWhyuMVe69yUJvN/fsugGyZoSsajCF+uqQIDOgZsguNsmWxyc9H4Z1CD2he/1K7t90cgTS98A4BDhDnB5jKx+OY42n1S93RBr4BwpxwftctGK4NIb3liHd67yqAk/ePY2OvCEgy/D9/Hab77/bpON6osr7mKa7+OmLQ04BoUm56SKqwn0cH6WrSMiN+SXU3A2Fzr0hbue7WQEzjc5/u4t+1oei20SBgbvDiTkEKUMoANBCSgQmbvEYbDSFrSDv5ZSB0MJtG4zeuAu5543QnJq6NV4RtmOMJW51zkVrQGecQd/o/xflyAAtm4eMIZZqos/7xl/ECSQR2I9cqDRlmh88bgE933K7dccbxDDc4pj8y0V3rTJrfNh+dns6eyKNZ+hyG+fvBbHTAogtQM6WNB7Wj3ga6xojA2CEoXe3uaaswcOwt/M5ReRtO0vSCsMaCPK7M0rOdk1BFEsOJUfpwPZyDZn1J4rQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVlkTXZzeXI5ZTBXNEY2RDNYWE1SYm05QS9Ka1kxTlFMckVhQ1FGc0xkY0FQ?=
 =?utf-8?B?SmFVaEZ6aHcrekl1SGZ5T1AwbzYzZUpISEpkeEd3KzFlNjBuYUtVTjVCMU1L?=
 =?utf-8?B?ai94VUZuakJrNmo2MXQrQ3VjVUgrNjVObHd0OFU3REg0T2VNS0tFNWUreUw0?=
 =?utf-8?B?N1NkcDR1ZHQ4RTE1VjhxaFBtb0hOY2NxMVRjV08rcTl0ek1jSVphNlNodXN2?=
 =?utf-8?B?enF3SUFXaUliYTF4TGtzTjZ2L0tJNExva3hhWC94aHJxWm1PaWVkb0t4OThq?=
 =?utf-8?B?NmRuKzVPdkFFZlBqZFNVdS9pdVJ4VzR3Q0c0SVBGTmllSWFSTzlvRVl2c3BK?=
 =?utf-8?B?cWM2aVlQbjc5S3RUTzZCT2VrMWc5V0FqS050TEhXdEhtdVQrZ3F4aUtReVIx?=
 =?utf-8?B?SEw2b2RhSnhtcDA3N3JqZnJWTURIRGl6Wk1jb0pQN0VuRjhQTTYvYStpcXpq?=
 =?utf-8?B?aFoyZnZGMWd3WUZZWEdNaFVtZngyMkRzU0dmY2ZWTWFUQ09JZzhiS255bHdW?=
 =?utf-8?B?aURqdkNxMWUvREluc1IwVG5GRGNSL3FHRUI2OHpmL3M3cGEzY1RzUEFoMVM3?=
 =?utf-8?B?QnZFd040aEl0R3ZwZE80aUdSc0FKK0JOQ1pibElyb1VKQnh4dHh3WTNSb0tF?=
 =?utf-8?B?VUFFYlBlc3Awamwxc0pQRDBNWmFVeE1MSURhVEY2Z2xyTlpVVk9lbUp5OHJx?=
 =?utf-8?B?Wk5jeTJ0RzVsdTk0T3lRVzN1VU5RNmNjMnZNaldHVk5sa0Q0WHdaWjJUWkpj?=
 =?utf-8?B?bjZDTysxQjhVcGNBa1BTdmFUSEhsR3Z5OW8rV3B6SWl2dVdaUDM4aVpqN05a?=
 =?utf-8?B?RDRBN3R4R1pVMHlSdUdMU2dYVU1GVHFoeWhQU2cxUXphTytWZEZidnI2NjJq?=
 =?utf-8?B?T1VBaXBGcmZ5WlhIRnJLWGdVMnpCYUlFQjZKckJLNndiZ0N5c3FrR2R4TmMz?=
 =?utf-8?B?UENscXZxa05KRnFWTVNJM3hGeUx6WnpQaDJJMnBTOTN1NDJMMFR2aElBVDFB?=
 =?utf-8?B?YVY0Wk5TZ1daZ3dwUUhiNGcyWGtKTjdFS2o0N09Zc3hNSm5WcXUvZWkydnl2?=
 =?utf-8?B?RkVrMm0vQ3NXZEdWSG44ZC95RTlSeUx1VU9TZ2g4UkVSWDVOSUJKQWVudTV0?=
 =?utf-8?B?YWx6eWtRR29SVEdDaDdsajZxZFlPdDRyOHBuQTBvNWNUVU9Sa2o0NmRTVTBP?=
 =?utf-8?B?cGNUZmIra2h0eW1pNjZ3eVJFSWVWOXFpTDFHbWVtUHdXT3pYalQ4ZzUzeDh2?=
 =?utf-8?B?eE1RdnE4VHZHeWZTQlV6c0g3amZZaCtnSEpFWDJpOWZSWXozMmpjRzNtcG9z?=
 =?utf-8?B?SjkyK3BUKzA5WWtrVCtTWEdxQkhFQ1lZa21nell5cEJLZitYdnp5ZXVlTmp3?=
 =?utf-8?B?d014bVNaTjRYcVE5d2xjM2F4TzExWkVqaXhvYmF2emUzb2pHNEFjeGRGT3Jp?=
 =?utf-8?B?SEQ0UFdSOTQ1eXBWQS8zSFhYa25IQnowLzBaRm9zWjJMSWxIaUh6NUVJQ3Y0?=
 =?utf-8?B?cVZQT0xkQU04ZW9lR041ZU85WmZCWWZmblo0ZE5sQWtxbjZVUFRCMTJ3YW5B?=
 =?utf-8?B?SnQ4MFY5VWIrdCtUMDZSOEtBR1FIRlUvUXNKcHoyeDBUaTRlT0VSK3c5MHM3?=
 =?utf-8?B?TFBBditsLzlhb3ZYY21zV0xldWhTbnpmSy9oUlpzOHNOa1dKdk9HQ2h3dlRW?=
 =?utf-8?B?Vjl1MHZpMTFHTlZYVXBHQ0hZb3p5Uk5Kdlh0aFhFcFExcHlFQTZVRmY2K092?=
 =?utf-8?B?Y0QvbDV2TWl6UGE4WUF1eEpHTVJsejdrUUtXQlVHUDQ0a2pMSFU1TUFtblNF?=
 =?utf-8?B?Qzgvdjh2d0gxekl2d0psb1h6UXpoZng0K0hWNUFISXcyQk1nT29CTEhnQWFT?=
 =?utf-8?B?YytLcXFCMWFVOHVvcHd1RUFhRzcwKzBkQVJndGJSbFdLU1dZKzI3RUU3L3lP?=
 =?utf-8?B?WTUrZWR5UG5MZ254VkdYQ2tQYWlUdFBsRkJKdkEzZEVRVlJVWWJHa2RLVis1?=
 =?utf-8?B?RHpjNTQ5Z2dSTjFSWTl4M2dFcGRBNlg2YldJNFRHZ2lCSHNhb0N2ZjRVRkhq?=
 =?utf-8?B?bjhHL2xQUUtGYUxZWnBPeTJvbzBpK2ZZUzhxV29nc1RsQ3EzVHRpSjdvTUY0?=
 =?utf-8?Q?91+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53161C3644D8F149B1665E1D1C18D7FE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6a9252-2566-4207-e0bc-08dc4a86205e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 15:38:30.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aj7Vsx8tdeq4hpE2LAUKDAq4p+vOCrZ5iedVWIE+eEtx4O4enift/sJ8FOsS1IxzutXhF6JpnX+toHfA3zVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418

QW0gMjIuMDMuMjQgdW0gMTQ6MTEgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+PiBTb3JyeSwgYnV0
IG5vLiBMaXN0IHRoZSBMRURzIGluIHRoZSBQSFkgbm9kZSwgYW5kIHRoZXkgY2FuIHRoZW4gYmUN
Cj4+PiBjb250cm9sbGVkIHZpYSAvc3lzL2NsYXNzL2xlZHMuDQo+PiBNYXkgSSBhc2sgbW9yZSBw
cmVjaXNlbHkgdGhlIG1vdGl2YXRpb24/DQo+PiBEb2VzIHRoaXMgcmVwbGFjZSB0aGUgcGh5J3Mg
YnVpbHRpbiBhdXRvbWF0aWMgbGVkIGNvbnRyb2w/DQo+Pj4gYXJjaC9hcm0vYm9vdC9kdHMvbWFy
dmVsbC9hcm1hZGEtMzcwLXJkLmR0cyBpcyBhbiBleGFtcGxlLg0KPj4gSSB3aWxsIGludmVzdGln
YXRlIGl0Lg0KPj4NCj4+IE15IG1haW4gbW90aXZhdGlvbiBmb3IgdHdlYWtpbmcgdGhlIGxlZCBj
b250cm9scyB3YXMgdG8gbWFrZSB0aGVtIGFsbCBjb25zaXN0ZW50IGFjcm9zcyB0aGUgdHdvIGJv
YXJkczoNCj4+IC0gTEVEcyB1bmRlciBjb250cm9sIG9mIFBIWXMgb24gY3B1IG1kaW8gYnVzDQo+
PiAtIExFRHMgdW5kZXIgY29udHJvbCBvZiBldGhlcm5ldCBzd2l0Y2ggb24gbWRpbyBidXMNCj4+
IC0gTEVEcyB1bmRlciBjb250cm9sIG9mIGV0aGVybmV0IHBoeSBvbiBleHRlcm5hbCBtZGlvIGJ1
cyBiZWhpbmQgZXRoZXJuZXQgc3dpdGNoDQo+Pg0KPj4gSXQgbG9va3MgYXMgaWYgdGhlIG1hcnZl
bGwgcGh5IGRyaXZlciBzdXBwb3J0cyBsZWQgc3Vibm9kZXMsDQo+PiBUaGUgc3dpdGNoIGRyaXZl
ciBkb2VzIG5vdC4NCj4gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzk2NTc3NS8NCkdyZWF0IQ0K
Pg0KPiBUaGVyZSBoYXMgYmVlbiBxdWl0ZSBhIGJpdCBvZiBpbnRlcmVzdCBpbiBtdjg4ZTZ4eHgg
ZHJpdmVyIHN1cHBvcnQsIHNvDQo+IGkgZXhwZWN0IHN1cHBvcnQgZm9yIG90aGVyIGZhbWlsaWVz
IG91dHNpZGUgb2YgNjM1MiB3aWxsIGJlIGFkZGVkDQo+IGFmdGVyIGl0IGhhcyBiZWVuIG1lcmdl
ZCwgYW5kIGl0IGlzIG5vdCBkaWZmaWN1bHQgY29kZSB0byB3cml0ZS4NCj4NCj4+IEZpbmFsbHkg
b25lIHBoeSBjYW4gb25seSBiZSB3cml0dGVuIHRvIGJ1dCBub3QgcmVhZCwNCj4+IHRoZSBjcHUg
Y2FuIG5ldmVyIGtub3cgaXRzIGxpbmsgc3RhdGUuDQo+IE8uSy4gVGhhdCBvbmUgY2Fubm90IHVz
ZSB0aGUgTEVEIGluZnJhc3RydWN0dXJlIGluIGEgbWVhbmluZ2Z1bCB3YXkuDQo+DQo+PiBTbyBJ
IHByZWZlciAoZm9yIHRoZSBDbGVhcmZvZyBQcm8pIGJvYXJkIHRvIGV4cGxpY2l0bHkgdXNlIHRo
ZSBwaHlzDQo+PiBhdXRvbm9tb3VzIG1hbmFnZW1lbnQgb2YgTEVEcy4NCj4+IElzIHRoYXQgc3Rp
bGwgcG9zc2libGUgaWYgSSBhZGRlZCBsZWQgc3Vibm9kZXM/DQo+IFlvdSBjYW4gY29tYmluZSBi
b3RoLiBUaGUgaG9ycmlibGUgbWFydmVsbCxyZWctaW5pdCB3aWxsIGJlIGFwcGxpZWQNCj4gZmly
c3QuIFRoZSBnZW5lcmljIExFRCBjb2RlIHdpbGwgdGhlbiB0YWtlIG92ZXIgY29udHJvbGxpbmcg
dGhlIExFRHMuDQpJIChjdXJyZW50bHkpIGNhbid0IHB1dCBpbiB0aGUgbGVkIG5vZGUgZS5nLg0K
bGludXgsZGVmYXVsdC10cmlnZ2VyID0gImxpbmsxMDB8bGluazEwMDB8dHh8cngiOw0KUmlnaHQ/
DQo+DQo+IEZvciB0aGUgZGlzY3JldGUgUEhZcywgdGhlIGdlbmVyaWMgTEVEIGNvZGUgY2FuIG1h
a2UgdXNlIG9mIHRoZQ0KPiBoYXJkd2FyZSBvZmZsb2FkIHN1cHBvcnQgdG8gcmVhZCBiYWNrIHRo
ZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGFuZA0KPiBjb25maWd1cmUgaXRzZWxmIHRvIG1hdGNo
LiBUaGUgc3dpdGNoIGNvZGUgaXMgbWlzc2luZyBoYXJkd2FyZSBvZmZsb2FkDQo+IGF0IHRoZSBt
b21lbnQuIFNvIGl0IGNhbm5vdCByZWFkIGJhY2sgdGhlIGN1cnJlbnQNCj4gY29uZmlndXJhdGlv
bi4gSG93ZXZlciwgaXQgaXMgc2ltcGxlIGNvZGUgdG8gYWRkLCBhbmQgdGhlIGRpc2NyZXRlDQo+
IGNvZGUgaXMgYSBnb29kIGV4YW1wbGUgdG8gZm9sbG93Lg0KPg0KPiBtYXJ2ZWxsLHJlZy1pbml0
IGlzIG5vdCBnb2luZyB0byBnbyBhd2F5LCBiZWNhdXNlIG9mIGJhY2t3YXJkcw0KPiBjb21wYXRp
YmlsaXR5IHdpdGggb2xkIERUIGJsb2JzLiBCdXQgaW4gZ2VuZXJhbCwgaSBleHBlY3QgYWxsIHZl
bmRvcg0KPiBwcm9wcmlldGFyeSBtZXRob2RzIG9mIGNvbmZpZ3VyaW5nIExFRHMgdG8gYmUgZGVw
cmVjYXRlZCBhbmQgcmVwbGFjZWQNCj4gd2l0aCB0aGUgdmVuZG9yIG5ldXRyYWwgL3N5cy9jbGFz
cy9sZWRzLg0KU291bmRzIGdvb2QuDQo=

