Return-Path: <linux-kernel+bounces-156595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F291F8B054B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E0B1F24E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2692158D66;
	Wed, 24 Apr 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+7yto/w"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0C158D86;
	Wed, 24 Apr 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949483; cv=fail; b=tcVV610nlSGdTRHTLMWsru/76XPQS7aZeX0eeojfkA5dDqfEk8FxUn8XPmu0zpxDfL8kOcF7U2jXa6zXBIaftTJ+eJU/iEJq6SIhwY5WCJN6r0Xrlbsw6Yk8MQkJ3AbLfihLE3xQdtfziDApb1b/KaPjYv40/qhVjtc19Bw24S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949483; c=relaxed/simple;
	bh=P5bB0fUs1iaF8HncknaGlOjOUVAJQfOcI9NuKL2rbbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IHY+G0F8EHvDnseNy1OjnN2s2pBFQ5lvSYfnn0FR8oxbz5pQLbQ+oUSPITrXqziDyC8J3qmD0ZoOAKz5nKg4cBuR43+c0jHA/Q1/iyhveuG0PPyc95kNi3xcip/y0nCqLtf0SpfW5l+VVny96qjrkepibnUovrfHnci8aQoiqdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g+7yto/w; arc=fail smtp.client-ip=40.107.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHziW68EOnAB8Mg5BSUS1sfm4JmDA/TjEJHzb09n8lvEVpzjj4r3Ea0c8VFa+fwLrWcj4EAlWBaznur3X6zDvoBtBUgXbY9C2iEP65Ef5CEAoaebE5H04m970e/aX9bxLh3xlyRyYx0yZ4ePxHXo4UERgrX1DCgM/AdJ1fKd6WgxKRn+I8Be7AKmc+7fukLsWRsUIFp6lAM7ypj/bJM5e4CdqTthrkzUdJJBZAOpG3BNGbSj5ttAk27p5rV4zmYCappHJmM3wldOHDM7E416RzgNmcQxIvcyjsKRz3RrUJhYs6Nxd5P2ozh05JnsLAHbgIbM8RZBpUhxhGrzHGWyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5bB0fUs1iaF8HncknaGlOjOUVAJQfOcI9NuKL2rbbI=;
 b=ZeAPpBeUYwdqmkHyZ4309iv0YwAudcXpkoJhgLLKQFo7ahYO1kdhqLZZsjg0p1sEiknlDMbm2gNEmLiYKq9IPDvLtAx8Mi7+GuMBSHdpIwqYyhT+16zohQiLqkhWuSIHrf7EFPSGEJkOuoLPvliOWfOFz4pTPyHkLxR3cndL77JKhcUbfsxmScEv2BGuo2fcxvc9SxpZb+MiSIrBGoNq/+nBMvrt7eZ9Fwl0RYTt7zvnfMUnDw30wSuOi5gUR2XVUYaFvUi/RxsDV1rNCkvUyVar/PlG6SmKpY+YjbvS1zEEPuBVT5C9tlNQNR1nlnNWu/BZrb9/JSJ+9T6D59WVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5bB0fUs1iaF8HncknaGlOjOUVAJQfOcI9NuKL2rbbI=;
 b=g+7yto/w5F1jNr2srIK5NTyhWpKLMKmEv/kHwB0AW1n7ABGuIE8hY0zh9wynnj1T9/nKnCY6fsjrLPEYzWlCGDKF7Q5A3eFcFVCxfFM0lcDXjD1RLpQcgwAzCZ3iQ5MrK7Dku513ifvf+i3lRI/ksmhnM1Z5pjc7jH2RiNCcufM=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM8PR04MB7971.eurprd04.prod.outlook.com (2603:10a6:20b:234::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 09:04:36 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:04:36 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Frank Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE:  Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131
 support
Thread-Topic: Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131
 support
Thread-Index: AQHaliZuZ3cvaEynak6a95WOrsnEIQ==
Date: Wed, 24 Apr 2024 09:04:36 +0000
Message-ID:
 <AS4PR04MB938629FE2E40DA32B8A95E2AE1102@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
 <20240417031455.3177778-2-joy.zou@nxp.com>
 <20240417045720.hk3y6m6roiqtuvfz@pengutronix.de>
 <AS4PR04MB9386FB10797C0AE8A19AA88BE1102@AS4PR04MB9386.eurprd04.prod.outlook.com>
 <20240424085955.xsseqmzarh3uyfys@pengutronix.de>
In-Reply-To: <20240424085955.xsseqmzarh3uyfys@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM8PR04MB7971:EE_
x-ms-office365-filtering-correlation-id: f3ee9b34-cf0c-4234-2ce3-08dc643d90b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVNzMlVZczcvdEdZUVh4OHRpQ3dhSlphdkU2TWZJWFphVWNrSzV6ZVZhVmNu?=
 =?utf-8?B?dVg0RWt2RDJ4dVVsUy9Cc3FQZ2RGY2RPUjkyV3EyS2pSNytTc1VBQWVuOXRV?=
 =?utf-8?B?cHorL3duZGNkSmJrUmFXTU5kakg0N2dnTmFPckE0K2t2WDZPN2UyZUJBZ3VT?=
 =?utf-8?B?cEFqQnY0REIwajRSeElFM1I1SzRMM3F5M05QSDhxZyt1d2N5WTVYVG9leU41?=
 =?utf-8?B?aUxZcGRxaExhbHVRdUdKUTJDeTg2RUc5RnZ2RXhiNktHVisxR2szTTFzK2oz?=
 =?utf-8?B?cHVvMzFMcUlzbnVxQkNwd1FPV1pIUXhjYVFOZ2ZLTThzN2dhSklVUy9iK3ZX?=
 =?utf-8?B?aExQVHhKT1Z2T0lBSVZwN2orb1NYdTFucHRIUmNLR2k0OHRwR3hvOTEya2dV?=
 =?utf-8?B?eHp2SGY5NjgvREVHUzBGY01OaUxRYXBhZ1ZvRldiNHJFK3ZnQUp2ODE4STBP?=
 =?utf-8?B?b2dEVHFuckt4YU9Fc3FraWoyQVNHSnV1SjhZOGovK0kwRFM0WGNxdVp1dEd2?=
 =?utf-8?B?Q0tFVFJqYnJTZ3Bsd2kxQ08wTGNPaTVxNExRY3lCSmtzZkVmSzBrQURGT1RU?=
 =?utf-8?B?ZmlQR2wxNXZRM0NUMzRPeWUvMWV3cjdmcCtwdzYra204QjhVTWg0cXorNWlQ?=
 =?utf-8?B?dU1PUDAwQUMyV0Q1c0FnNUlTTWFrclVmV1JMRDdySG84YVkzZ3dPZVNNSitO?=
 =?utf-8?B?Mm5GU2d6R2RZdjBCb0NrYVZzS09XRHhkdVBYaTQ2QjhzMWdjYnBiazRIYlRq?=
 =?utf-8?B?c2J2bXpwSTlUSnk1a1ZtTUhVbXpxWEdHOVhQNWhqaE1ZK01NVHQ0K1RCQkJx?=
 =?utf-8?B?VXpONzlDNmhpSWp2NDRnYnQyR3N5OG5uQ05Va2dkSzJwc0hFVzZDaVJnak9x?=
 =?utf-8?B?MDI1ZWZ6dnp1alc5YUVVbUhJRm4vNmhJS0l6QW1Wek5sWVdFZWF6WjllelA5?=
 =?utf-8?B?amhQQTdsQ2ZZaEtCN2lCUEV1RWtjZUw4WVlHYlNXeWMzMWlZcjRoR0lvcVNL?=
 =?utf-8?B?TFp6SW4zbjNCSk9EN01ZR0QrcDYxMStVaGpJNEdUeVRqWHEwZndJNnZ5dFJi?=
 =?utf-8?B?OGJ3Z1FMU0RHL3U1bnozazZLeEw0MTNTNytXYWdic2NFTTJML3NkMTVLcW9D?=
 =?utf-8?B?MkV0Qjd4NkZNOGpTREw4ei83Mjhhbm56dkNpS1BmbG5ZeGRzOGFjb1pjUFBw?=
 =?utf-8?B?WGl6U1gxMTRmNHVRQW5ERmNvcHZYWmVPNHNzcStxQnlNa1BpTGlEQURheDVq?=
 =?utf-8?B?emdrR2lXcWt1YnVIU2NaRDRLU0x6L0dvT0xhYkVFajRZeUc3QTRmWlI0c1hJ?=
 =?utf-8?B?UFkxeWdGdXVLM0FncVhSK0hLUDdwR1E2WmNQMXJyS1hZUkJRUTUvVHArekRX?=
 =?utf-8?B?NEkyMnI2MkV0eVlleHQzWkZmOTJ6SDZrU2Z4QTRYVUJQWnlpSTZ6MzRSMG81?=
 =?utf-8?B?NlUyVGxPZlhzY2VCVEFyQW84bGdWTmFVdjBUaHZTU0o5MTlsOVV2NXllTURK?=
 =?utf-8?B?bDlzMVVBUWlyVHk3SFBySXhyWDJEdXEvZ3ZZNVl2QlVzRHpvQzJWNWx1TjhP?=
 =?utf-8?B?R29GdUpTQWhsWEhuOHdMcXB6dDk0Y2Z2TTZBYTNGdkprMTExSVJ1ZG82YjRv?=
 =?utf-8?B?Ny8wazhxSDNUT2tkcWlGeWJWbXlpbVV4VnZ1WVFhbHkyUjh2aVBoVEY3cU5D?=
 =?utf-8?B?Vm0yT2tuS2dpQ1pLZjczUG5waUJVUlliWnkwY2ExN1dkdmFKVXc1d1p0NFdI?=
 =?utf-8?B?d0gxRERkdnFBNEN4aXphNVN1am1wc3lwWnh3TEpScU84M3UvTG5WZzhIZFFm?=
 =?utf-8?B?VUtVVU9yZDUxUktoNUhSZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFhWYytmT3FNbVlzMTYzOTN0N2RaUmFhTWxDQys4QllMbWZzK0pMSXBMWkdU?=
 =?utf-8?B?UERkYWVUN1FSRENkNUduLytOQ0IyelhqU3R5bGdPTWNNcTZwaDRSbkNqS1Uy?=
 =?utf-8?B?RGg5RWFlM1VacVp1V0F3aE1VOFlMNVd4U2RDaVExRmdwNE90R3IrdC9xY3BF?=
 =?utf-8?B?NlJFZnF1c0xvdDBLSlJjZjZ2blF6aU1xR09XSjBWUUV0QVRtMjJLVFZzWjh3?=
 =?utf-8?B?Y3N0U01wYlhhcWN2VEZoaHQ1dDV2bUVTWktJanN1a0R4emU2MzFheDZ1Ykc5?=
 =?utf-8?B?bElTZlo3c20ySEZ6ZE9SNDdMVEFyS0g3c3FCdjc3ZU93WXJCZHg5ZlpXalBY?=
 =?utf-8?B?dExpZVd6MTE2R0IyUnhjZWxHNTNFZnRvVTNxQ1l2M2ord3lTdTZveVkyeEVm?=
 =?utf-8?B?dVBXSzBTYmcxaVJiOVRTTlRyVTZZYnNBak1UMmZIRjVuTk5VbjZ4Y3NXL3N0?=
 =?utf-8?B?OGlkeDByWnRuYnc4aUkwRE1BZWl6T1RqbE4wM1hUb2l5cjlkK0dTdkUyeVFJ?=
 =?utf-8?B?WmFXVzdLNjlRVmV3TDlhZEMzTXVsZmNaRTV2NzBpOXozYis4OHhJaG9KY081?=
 =?utf-8?B?VUFFaUU2TFVxRGRFR3R6bk9iMUZaRllxU0gxUmx2Nnhxc3l3RWdXSHdVSk5k?=
 =?utf-8?B?WWdKbHZCaG02UGc3RnhvOFkrY2VteXkzamxJVG5TV2w1enRFR0kveVJ4YURX?=
 =?utf-8?B?SXhpODJ0K2FjSnhNNWZFYklNOG1obGEzNWxGemhka2JmTEtXd3MyNXoxY3Z3?=
 =?utf-8?B?QjBxODA2T011bE54WEJsdGkzMFpVUDNDQkxTOC8yUTRLa1JhNS9kL1dmcStk?=
 =?utf-8?B?UHVlNzcxYjhFVTNnTVQ4MFFJWkIxZ0ZneHVjUkRIRjhSelhSTlVIUHRPbzE0?=
 =?utf-8?B?MnVqQVlGVlZmdEE2UlFGVW84WC8wV0JmQTk5S0xhc3ZVdkJReDd2WEN3YkdW?=
 =?utf-8?B?WTBnemV5ZjZaVGc5VlR6NVpDUHl3aU95WkJja1RpL0FhUHZXLy9oWldmMy83?=
 =?utf-8?B?U2s3UHZaR281dlJDbDJWSFlkNmdzNDhZcDdrYXF2UmZwQStrWDV1OHN1ZktS?=
 =?utf-8?B?T0VJQ1p0TEZxUVR3NVFiWmM2NjZRaU9xbTh4Y2h5OXZnWjBiQWVpNUJSNmpC?=
 =?utf-8?B?M2w0Wlk5WFE2aGQyTnRhMDVQN0hxMnFaM1Z0NVdiMTFpU2pXbzhtTVd1L245?=
 =?utf-8?B?ZDR1NzJlS2pMN0JEWWp5eENZc2VRWGV1dWY4aEtGU21VMGJ0NThhak9GeHhL?=
 =?utf-8?B?LytsSWI5aHpIcGhUN29OQnhqSk91bzVQTU1VbjBlUEVmMUI0M0JOcWVSa0ZD?=
 =?utf-8?B?QjEzYTZyVlRPaU5VamVhY0lvTFpJaUY3bVpnS3U4TEtaanZpWitrTHBaSlg2?=
 =?utf-8?B?R1MySVVJZTdpOU5qdHJJNTVpaHY5SFNFZGhZVWRScjg1NnIyT1ZTWG9haXUr?=
 =?utf-8?B?Rm9xRm5rcDR3eXBXRllhNWJwcEdwdVhhWWlxZmhUaVdoNWthTmY1T1ZrQ3F1?=
 =?utf-8?B?bmdzSXM2ekZGV2N0MXB3UTVjY2pkMmdzRlNzcGtTYURXOUpBQ3ZZa3IzU2g3?=
 =?utf-8?B?RjEvalJXRHlPc2YrblppMHNVRHhCdW9nTlQwcDhqUCtSSmNkT1QvcW5DbXVV?=
 =?utf-8?B?d3lQUSs5MmxtdGliMWtuQ2hsTlplcE1RTTdkQzV1V21aOUw5STdHWmx2dEdm?=
 =?utf-8?B?eHR2LzJFU2d4UDE0a1hYN0RQRjFwL1UzMXo3K1laM1E2UlptNUFRR0tYT05S?=
 =?utf-8?B?NHVGa0Zockc2Sm5FSkVsUkErQUVjN3RuV1dXYlFwS2N0Mm1IUkhUVGx5OUp3?=
 =?utf-8?B?SnFybnZnTjIzZmJONmEwZHlPSTBDSkQ2Z3pQdVFqSFAyb1NpaG1Ycy9valRi?=
 =?utf-8?B?cEpPeC9nZm9pcTRqQVF6bWFIWk9aZlNGL2pGSndTRms3WE9DeWloS3F4T28z?=
 =?utf-8?B?aldhSmRXbDRTd1hPQ3BaQlZKYmh1ZVp1U05kckowSHlla04rczdySCtBNS9V?=
 =?utf-8?B?ZFdRMUI4cm1ISVFleDlGSDVxZ2xPTmwwWkRyMS8vL2QzV1I2Qkw1VWJvWlhr?=
 =?utf-8?B?elJzd3lGM0s3VjNUVmhFNXZzNHJYam1UNUoxOU1wWDhMYzRnZm9hZmFWcDFP?=
 =?utf-8?Q?3jOs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ee9b34-cf0c-4234-2ce3-08dc643d90b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 09:04:36.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59tjpxrVmhMWyfJW5VjfMqbqyNE3L0DLJeXmRIVFjyoICxgT0iebgv5utK+Zla79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7971

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNvIEZlbHNjaCA8bS5m
ZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTlubQ05pyIMjTml6UgMTc6MDANCj4g
VG86IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwu
b3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5l
bC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4g
PGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0
cy5saW51eC5kZXY7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogUmU6IFtQQVRDSCB2NCAx
LzFdIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azogYWRkIHJ0Yw0KPiBQQ0YyMTMxIHN1cHBv
cnQNCj4gDQo+IE9uIDI0LTA0LTI0LCBKb3kgWm91IHdyb3RlOg0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+
ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMN
Cj4gPiA+ID4gaW5kZXggMDdlODVhMzBhMjVmLi5iYzNjOTI3MWQ3NDcgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMN
Cj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEt
ZXZrLmR0cw0KPiA+ID4gPiBAQCAtMjgxLDYgKzI4MSwyMyBAQCBsZG81OiBMRE81IHsNCj4gPiA+
ID4gICAgICAgfTsNCj4gPiA+ID4gIH07DQo+ID4gPiA+DQo+ID4gPiA+ICsmbHBpMmMzIHsNCj4g
PiA+ID4gKyAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gPiA+ICsgICAgICNzaXplLWNl
bGxzID0gPDA+Ow0KPiA+ID4NCj4gPiA+IHdoaWxlIHJlYWRpbmcgeW91ciBwYXRjaCBJIGFsc28g
bm90aWNlZCB0aGF0IHlvdSBoYWQgdG8gc3BlY2lmeQ0KPiA+ID4gdGhlc2UgY2VsbHMgaGVyZS4g
SXQgaXMgdmVyeSBjb21tb24gdG8gc3BlY2lmeSBpdCB3aXRoaW4gdGhlIGJhc2UNCj4gPiA+IGR0
c2kgZmlsZSBpbXg5My5kdHNpLiBDYW4geW91IHBsZWFzZSBwcm92ZGUgYW4gZXh0cmEgcGF0Y2gg
d2hpY2gNCj4gPiA+IGFkZHMgdGhpcyB0byB0aGUgYmFzZSBkdHNpIGZvbGxvd2VkIGJ5IHRoaXMg
cGF0Y2gsIHdoaWNoIG9mIGNvdXJzZSBkbyBuZWVkDQo+IHRvIHNwZWNpZnkgaXQgYWdhaW4uDQo+
ID4gPg0KPiA+ID4gVGhhbmtzIHlvdSwNCj4gPiA+ICAgTWFyY28NCj4gPiA+DQo+ID4gVGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzIQ0KPiA+IEhhdmUgY2hlY2tlZCB0aGUgYmFzZSBkdHNpIGZpbGUg
aW14OTMuZHRzaS4gVGhlIHRoZXNlIGNlbGxzIGFscmVhZHkgZXhpc3RlZC4NCj4gDQo+IFlvdSdy
ZSByaWdodCwgbm90IHN1cmUgd2h5IEkgZGlkbid0IHNhdyBpdCBpbiB0aGUgZmlyc3QgcGxhY2Uu
DQo+IA0KPiA+IFRoZSBjdXJyZW50IGNlbGxzIGlzIHNhbWUgd2l0aCB0aGUgbHBpMmMzIG5vZGUg
aW4gaW14OTMuZHRzaS4gU28NCj4gPiBzaG91bGQgcmVtb3ZlIHRoZXNlIGNlbGxzIGluIG9yZGVy
IHRvIGtlZXAgdGVyc2U/DQo+IA0KPiBZZXMgcGxlYXNlIHJlbW92ZSBpdC4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+ICAgTWFyY28NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KV2lsbCBjaGFuZ2Ug
aXQgaW4gbmV4dCB2ZXJzaW9uLg0KQlINCkpveSBab3UNCg==

