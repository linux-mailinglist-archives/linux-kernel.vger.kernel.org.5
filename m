Return-Path: <linux-kernel+bounces-134299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D889B00F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476D11F22385
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236014A8F;
	Sun,  7 Apr 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJRTePDt"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2136.outbound.protection.outlook.com [40.107.105.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2909185E;
	Sun,  7 Apr 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481871; cv=fail; b=j0UL/BM9NQESNVcUfAi32OWr26UGWv+7LB5yU2kyirnL9P/v8y7iqgWa4EIX0zDrxlGfpBjJh3JrStK9WyiXL1/jVPwfABBjbh2DpgWDLlU5/TLvcV6AgMO/Q6qGlSLczjingjwPMKFTcJtOOpLW7i65S5Kv+RQZ1HxIV/wehKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481871; c=relaxed/simple;
	bh=8Ho++wtbPCTJ1XyMHPoxxfvDr8YsuDq8VgmTcv+nIcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dseHSXs2uRsVIFvfXHQGKNSkqzoEH9zFezaTzxtdoZaxsUgh8T92q8hQzIeKeEhHDQx2NxgHVFTVQhY80IP8pzd6Md09WXk7laMeLr7Z4AbdofwxdrnoCia6cdBVkBG0buFhcp4l0lkMCtonPRsafJWbb8bDHZ8MOM1VZ/d5RjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJRTePDt; arc=fail smtp.client-ip=40.107.105.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaDTWKCqltjS13TRFfgdzQhvku42vqG+G6zkWvQcvgDx2yNUsLSZgnjaZ6uY4hLaR613T/IjB1r9QWMRQkWLEpKyPgRU7FSBBUUXEHEcz6LCsvPM94mkSQ5FXhmNLsyhNZ2EJ5JWdh0hJ85GCw/tDwqBOto0wMWVLaPIze3RcpoACgJZtN1FYe2FnOB0BmcE8w+IS4aIwI6OyWGqkJTIM55lZ0NfI2apPzfWB3vL16uSez0MFEKjhJllzK5CuKTuhOHvlExpCcL5/Wd0QzRQs0yombeCKYj3o4DNJpDQrlCcDiPUdccQ2ZKjiqeDs1ad1y4fCHsv2el3mwRPIZ1J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ho++wtbPCTJ1XyMHPoxxfvDr8YsuDq8VgmTcv+nIcE=;
 b=TNFJudG6Tq0LPl8RuPsanX8c18Xdtb8zISC2w0TcVFheH4YSeU7ZGytt5D+T2TM1DseEDlHmghjpBX9pdiy9nf48eIfMYKVGbbAtyOzqQgc5z6FKxvKtaPNOuKLQMEEhjScshLTsMFug7+BALIWBwEqxgycUum+O/k+Xta5oZ+xZz0D65Wcz/8mahFRLN3sukrQGB7ctWIN2Twouw28CHH/WtHygWNuyJx9vFxTrXzVP3KVGqo+Nkk+46uWGR80iJFS5byuJribjng0dVLtl1QbPIrM/jipqN5+HOjVmFkmu4Cgg0ERzWRCYE6398cZLREcDxh8CemONlHxBlIAQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ho++wtbPCTJ1XyMHPoxxfvDr8YsuDq8VgmTcv+nIcE=;
 b=dJRTePDtU9cjWqJgRDkUWO0xVAWfSLaIvdmrrLxLXaEzi80+gBQa+ukWXadUpkhdOsqcpoz1a5HZLTRA8BiYrSRnyzYKq/lpUXOiswHaTqftHSY+y4jThtXK/47LjA+WQ7HHObu6/4VlPlzyl/azsIz0SSzMOajo9aK6GJZSdfk=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB9112.eurprd04.prod.outlook.com (2603:10a6:20b:44b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 09:24:27 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 09:24:26 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jacky Bai
	<ping.bai@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v1 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHaiKoUV5sWK7guV0m5MBzFERT0Z7Fcg9GAgAAA4QCAAAFYAIAAAoug
Date: Sun, 7 Apr 2024 09:24:26 +0000
Message-ID:
 <AS4PR04MB9386F99C9E901337603E94FFE1012@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240407051913.1989364-1-joy.zou@nxp.com>
 <20240407051913.1989364-2-joy.zou@nxp.com>
 <f019690a-2397-4bf8-9472-ec38f4b94c1d@linaro.org>
 <AS4PR04MB9386C629F898A8417AE57506E1012@AS4PR04MB9386.eurprd04.prod.outlook.com>
 <d18b05d9-266b-4a1b-a2cd-3b6f8173a39b@linaro.org>
In-Reply-To: <d18b05d9-266b-4a1b-a2cd-3b6f8173a39b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS8PR04MB9112:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WIxmwNocrUyJ9Off6fwcZZIKWGihQ766FJb4Evbt8YJq4qN3IbjCO9Bl1gAI3DFbI2yYy2AJF0ogZto+iADPDZ7fvouK8NgTJuuWkKDmZqHcD4NsEwXTKnMfPhw2QelvLwdPi7ZbJyolvTllELPGJAXve0Mz+YtnaGaRleOXQXUkpBKvTkxp46RluFgyEMRXfFAjaDniVHLu8imGiK/MDnJQMpKpWz+esgyQXMwJMKn8QtIj4zwgslQQxDvJ4ZOyW4sgQOyqstRm12lgWz9e+jcLeUOGBfAOzUE+xtm29ZGZ9ayTKJUdyFXdvjVmQA/FAtHyiOlxcLie5NACndHLxWEbAhE8cmSzSF00B+00rUrv4UAZigkHbwbjbJe45pejDe7jabALLLhiyK4EApbG1bkiFDhYosbMaAooLhzL1mpFKpHrRdmyP6YNeDCqYx49QrTmvkHc3Ho/MGNZco++NhxB1SSPGXTq00C18XX3GbKE0SANUTVsXP2w/c+UvLwYMcOTLKR7hwHzhJj4z3x9WzCMAyH2NSpR97aJ/CXzXGtzh5F+vL9fY0k2FxgS1USyGPQq6Xoteg69Xp+64fPKNUr6fd8KryVBRC3X4/b04VsSRUCMZVIsp80enF5vdfuDKJSWGHcDJ9PDRsf0hCGXkXqtmsmV7Ddb19qq9Q7n4r8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0Mya0M0aXYzYUZseDVCSk5GcXIwNzA3VVArTDlJVS9BdGdVZUg5LzhvVDUv?=
 =?utf-8?B?bUgrQWVnZ0crWWhRSHBxSitmR0p1Y25MZGdGOUtaWVdFd3daUSthK294em5C?=
 =?utf-8?B?ZnBWWm16MStDbnljKzlJQ0IrNzJVREY5TkZjWFZZTG1MUCtKWVEzYk5TNFBm?=
 =?utf-8?B?b3BLNDlrelNod2J1N2RJM1VyVmR4bDJwbjBLMmZqWGNVbDhkNkVzL295QVJD?=
 =?utf-8?B?bUJ6REIzSEcxaFhIU3FMYWVsMjhXc200cG9ybEEybXl2cSs0bWtQbno3cFVv?=
 =?utf-8?B?Q3RsR1IvcFRWbVhEOFVSd2ZVR3NkUnZHb3VBQ0RVRVNoa3d0cW5sNGU0MHR2?=
 =?utf-8?B?bm1EL0ZXMURXeXVTelhpTnhUa0lVak1ZRHc0RW1LR0t5eGROa2JDTVQvMmxD?=
 =?utf-8?B?TE9maURtOEVJd1NDR2pPMkl0Tys0d0xGRjRLRzNSOFQ5M3hRZGttU3RoNFVP?=
 =?utf-8?B?aytERExoanRTU0FYV2xvbWV6cEQzQlNsb2dORjRZUzFLTE12RFJHYUMzaEtk?=
 =?utf-8?B?YmNkUTh1WThyMWNVR1ZuUUtML1E3UHJLeXZxeUhIcHFaZTFoaHpDYUF0U2Jv?=
 =?utf-8?B?cEY5VHlkNVJsRkNIZm50WXlNVXhybGFzVHQ4c1Q0bkVjQTc4V1BiWFdtMEQ2?=
 =?utf-8?B?SXlTcGI3aGFrSzZyVXE3enFHRTlqM2M0MFBIQmtKRjFxSnFsSVZsTmtuOWVK?=
 =?utf-8?B?L2tmVVA4aUhuK25iWHhLOHViU1lCMUp4a0FaNzFQUGliNDZZekRkMUFGblpE?=
 =?utf-8?B?UGIxSTFpNDZwckNaOVI2NVpLdTdIM1hBRU5EZU1YcEVBZDBpQitveFhVc0Jh?=
 =?utf-8?B?bStmZ09EM056YUNOd0k3cVdyRTJoTzAvTEdsNStCcFhHM1VMTHZES09UNnJW?=
 =?utf-8?B?WXpnZWJUVXMrRE1OeEk2RzdVcWxJcjlKc0VMZDdTMHJwaTREd0ZjazdWWFZn?=
 =?utf-8?B?SXlya1QwcG0rR3kzUE1vTWtQV056MmFWak40aHovZXdnY1lweDVRQ3FhbVI5?=
 =?utf-8?B?UnY5a2srR2RmQTd4RHJSQ3FuemJLd0ZydmI2cS9SbnhPcUxtREN4TnMxUUNZ?=
 =?utf-8?B?VHNPYzgyS3U3Q1BrVHdQUVIvWjExNjZkVms4UHh0VzRMUkV3NFYzbGFTNzlT?=
 =?utf-8?B?dExtaTlWK0pJUTdMeFJGNDJCK2NtSlk5UG5FYTErT2RETWNUaXhMWVhyU3FV?=
 =?utf-8?B?clk5eUNSU3FTVEtNSkFzRFpUNjhwTWU4Uy9yWFMwZ0FSM1ZCOWVHMStyLzJS?=
 =?utf-8?B?NnVRd3lRTzNTRHdxVmRqUm9ZaXNJZnVpa0YvRDZDUGZSWTJ4b3doU2RLeXNB?=
 =?utf-8?B?Ykg5WVRQV0d2V2NDWGRWeTRjVDRJRjdXV2R2ZFd3dE4zRm4yMWJqSE1MMkFO?=
 =?utf-8?B?RHBBdGNMOWFZQ1B6ZDB5OHJ5emtiRnRCMDErOVJBcit1R1hyZHZKVmZRaDNo?=
 =?utf-8?B?Q2FFN0FJKytJTW93cjcrYkdFODJsK3pFZUxnRnNnOCt5WUFvOTczSEExaWVD?=
 =?utf-8?B?TVN4bmQ2VUlLbUJHVXcwU2pHT0FYQkN3QVFydFFERHVnczZqRDgrMlZNMldm?=
 =?utf-8?B?K2pIWkNyb2pQa09aU04vWXdZQXRTU2M0RHp6dWdXQThyemdjeldmOWR2R3J2?=
 =?utf-8?B?a3JqMGY2bHpxbFI2eHhDWVpwL3hRVXFLZnpzL1JRN1hmcmROUm9IMWNnZ3Vn?=
 =?utf-8?B?bmI2YkYyWXhEY0VlaVlTMHJSNGRUMFVwTW1OUUEyT3Vxa3UrSXFhZU1BRklN?=
 =?utf-8?B?ZW9HakI5ZVZMbVlTNzk2TWM5ankzOEUwbTN2RlpFc3VuNlRNTExCbmgwVEN0?=
 =?utf-8?B?STJKNStDdFVZMXBXRHNjYWkzMVRTdkREZDYyekZaamw3VXY4Ry9iVGJZd1Jq?=
 =?utf-8?B?VlhvbHpvckNaTjF4NEErUzVOay9GTk9VTm9SSCtXWVNjZmx6azN6TG8zZHhp?=
 =?utf-8?B?Wm5PZ1VoOGNmM0x2WS9Jd3hYalNBZHlSaU9wbzJPMndWR2c2WlZoVUxMUmN0?=
 =?utf-8?B?QTRCYWdYUWJNaHd4TWx1QjNZU1hQcHRkV21nNnd2NksvL2tRNEtYRkdyZU1Y?=
 =?utf-8?B?WkFybUFOamRVeC9FQWxyL2orQ3UyTDVIT0JGZExLZTBYclZiVHoxSGZFYS9l?=
 =?utf-8?Q?yyCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8ab1d9-6b78-4b6c-5f16-08dc56e48543
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 09:24:26.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgbmSP0+Q1Rcvt9zGyr2Ae42WXyG5y8n+vH7yl2TdGF9+l1EVSQ+A0+069fgJN+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9112

DQoNCkJSDQpKb3kgWm91DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiAyMDI05bm0NOaciDfml6UgMTc6MTINCj4gVG86IEpveSBab3UgPGpveS56b3VAbnhwLmNv
bT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMu
bGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0gg
djEgMS8xXSBhcm02NDogZHRzOiBpbXg5My0xMXgxMS1ldms6IGFkZCBydGMNCj4gUENGMjEzMSBz
dXBwb3J0DQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2Ug
dGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4g
V2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRo
aXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDA3LzA0LzIwMjQgMTE6MDksIEpveSBab3Ug
d3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+
PiBTZW50OiAyMDI05bm0NOaciDfml6UgMTc6MDQNCj4gPj4gVG86IEpveSBab3UgPGpveS56b3VA
bnhwLmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47DQo+ID4+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiA+PiBjb25vcitk
dEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
DQo+ID4+IENjOiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwt
bGludXgtaW14DQo+ID4+IDxsaW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVj
dDogW0VYVF0gUmU6IFtQQVRDSCB2MSAxLzFdIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azog
YWRkDQo+ID4+IHJ0Yw0KPiA+PiBQQ0YyMTMxIHN1cHBvcnQNCj4gPj4+ICsmbHBpMmMzIHsNCj4g
Pj4+ICsgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+Pj4gKyAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+ID4+PiArICAgICBjbG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwPjsNCj4gPj4+ICsg
ICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ID4+PiArICAgICBwaW5j
dHJsLTAgPSA8JnBpbmN0cmxfbHBpMmMzPjsNCj4gPj4+ICsgICAgIHBpbmN0cmwtMSA9IDwmcGlu
Y3RybF9scGkyYzM+Ow0KPiA+Pj4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+Pj4gKw0KPiA+
Pj4gKyAgICAgcGNmMjEzMTogcnRjQDUzIHsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gIm54cCxwY2YyMTMxIjsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MHg1Mz47DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVu
dCA9IDwmcGNhbDY1MjQ+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMg
PSA8MSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+Ow0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IHN0YXR1cyA9ICJva2F5IjsNCj4gPj4NCj4gPj4gUmVhbGx5LCBqdXN0IGRyb3AuLi4NCj4gPiBP
aywgd2lsbCBkcm9wIHRoZSBzdGF0dXMgaW4gbmV4dCB2ZXJzaW9uLg0KPiA+IFRoYW5rcyBmb3Ig
eW91ciBjb21tZW50IQ0KPiANCj4gUGxlYXNlIHJlYWQgRFRTIGNvZGluZyBzdHlsZS4NClRoYW5r
cyB5b3UgdmVyeSBtdWNoIQ0KWWVhaCwgSSBoYXZlIHJlYWQgdGhlIERUUyBjb2Rpbmcgc3R5bGUu
IFRoZSDigJxzdGF0dXPigJ0gcHJvcGVydHkgaXMgYnkgZGVmYXVsdCDigJxva2F54oCdLCB0aHVz
IGl0IGNhbiBiZSBvbWl0dGVkLg0KQlINCkpveSBab3UNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCg==

