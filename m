Return-Path: <linux-kernel+bounces-162451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C068B5B76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62E51C21165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2BD7E110;
	Mon, 29 Apr 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aKc61sEI"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7F7D40E;
	Mon, 29 Apr 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401374; cv=fail; b=Y7zBTQCAQj/xfNy1tikRO+ZWNijc4ZpgKibsbWsHBQTCBo0Y0vgl82jF7QA6gPb1G2UxcQBtBtgc2a67bkFm5Yz5K7I2RPBujoawViZRvgU3lrqdDR0j0l/77gn7CbpMr1S/6gVzXtaMNYMYIIyDDVYaaV3N1x3mXQ0xHALAzUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401374; c=relaxed/simple;
	bh=A2xwj8G95OiPRES/XiyXM4GxDuSCNLo+5lhry35ml3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cm3ZYHM5BrFe02I9ihd5hyvxejfU87ZPafUUX5ROeGe0Xnq212r9ljGBzfYw/4NS1tM1LNcn5+bT7j2DlsaB3mbvB7Zg0PgGNttk+Ocu3T1COwzxTH3VVQg2ZMjqGheiDpSSKH+VI8painEO62VifabuUl/tL56ViML+YVBOSNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aKc61sEI; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEVtHQ001520;
	Mon, 29 Apr 2024 07:35:59 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtdcn81je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuGn0VWy6c8gOZ7PmJ6Y+KEqYvx9L+yHKC/Bsl1eclyCQpyZCFJTHRNBW56qmj0HjrAjf4K4hJk3TD/ZEWPfvvgHhH2r7uwQRdf9qT5xJRrrSetKGJwxhyJ6LZXqRZ4rm0D6QGmTkOGzdYqTMUUHlrVTiCeQS9+J3xBMKUEwQaFsAgOhVA0RC8ha6wgGqwooWtSxIz63HkPCw4BuFPod4YJoi+kc88wE9Mv0FrQiGVkjrAPlzbsYvkA3D0lf9vZwA915dPXr1+gUkll9CfwDOr57LZmPBRG5Q5qQ52HKyG0dUXUVfHhxfB1hloIJigBx82d636Q5uNIDJylnQ75pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2xwj8G95OiPRES/XiyXM4GxDuSCNLo+5lhry35ml3I=;
 b=T0ez2n/pmiyMgNdT6F+eeiN4Al/9eXwLl6aWqiLmt1XTRVE6RbHmg/wSBUXnll/oh5ehPYvH9ZUcic1gmX0sOjG4gSQmKABcAMdTockcmOn/midSGsaYf1oZ3kV7EdzASj8yZuI652fLMhb3zTWz+NZg0nJk4U/JdkMclV8dH3rGIDYPmLyuffPseQvV6vjHbgTgi5TvPuIwV8TqgLqP80k2QBpRov8T87+oV9QQCLu6dAINh/sp/8Rt14MmKXbGl4oTcsuNy/jXkyaZpWwlNCSRDBsuC9e/wkhEGljzApgWVagExySZdw+gSX7ZDvoOj8QTBeLc9tew++6nsmQ7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2xwj8G95OiPRES/XiyXM4GxDuSCNLo+5lhry35ml3I=;
 b=aKc61sEIVjiESgqr52VgF544Dy4pdGpplESYkwfO+PPakSANMt7s8uQMqrS9X9JqlACBLeq5z99+iNGP/NlaFj1mtP6Zdyzl0XK4nn4ZBGda6rIqiadwBN0wNrb99xHhcvl0dHqol7px2o+tbUTH/UXkYmCg1MkXBLJIPQ7BeyE=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 SJ0PR18MB4947.namprd18.prod.outlook.com (2603:10b6:a03:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:35:48 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:35:48 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 2/5] spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Thread-Index: AQHakS28W/KzCqcstE+2q5E6FRh8o7FuTv4AgBESUtA=
Date: Mon, 29 Apr 2024 14:35:48 +0000
Message-ID: 
 <CO6PR18MB40980502E0D9841C2B75E612B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-3-wsadowski@marvell.com>
 <35f11a74-6671-4d43-bb68-6391be2d576a@linaro.org>
In-Reply-To: <35f11a74-6671-4d43-bb68-6391be2d576a@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|SJ0PR18MB4947:EE_
x-ms-office365-filtering-correlation-id: ad3fc6c3-4ed2-4e7d-c017-08dc6859a986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bTloNGduR0hzUFFTZ1BEaDFiZm9PWFlzdDNWZ2RaRXlhVWdBN1NjSzhRYlJx?=
 =?utf-8?B?ZHMvczl5VGo0Rmp6N2ppRDZFdzY3MkVIQ2Z3SFNlMG1Cc0paSDN4Q2sxOFlq?=
 =?utf-8?B?TjRLWk9zTk9Tck56TWpmUFh3bmt0bUxXdTZEcUpZcnRtZFVpN3VhYnBtdGs1?=
 =?utf-8?B?d0JyMk9rZDlzYkZFaGFwOFByUFlzbVJWOFhGeExSRzN4aGp0Kys1OFF3NW0x?=
 =?utf-8?B?R3pxODB1aXAzdjZnOFdGMDFYY3Z2UUtIRzQvNjB4UkYySlBlK1hWemFLeXRC?=
 =?utf-8?B?dUdaR2pqK2tybUZoYlpCUm9uTTJUSVJGbVl1aW1QaEVuUktlbk5SSitLekpU?=
 =?utf-8?B?R3R4b1JYOWxhWHBXUkpqWFJNMk9EL21ZRktVOWVvV0MwWERTbFpGS2YyY3pp?=
 =?utf-8?B?UVdYd0FpU3ZQeGN0K2N4a3VpYndodGdZMHp6c3NPekQ2NWRJdlIwaTlHN0ln?=
 =?utf-8?B?QVN1K3llSFY2eWZQRzR2UFJvU1NLNDRYOEMrZlJ6RmVoSW5lekdoblR2OG0y?=
 =?utf-8?B?amVYVWp3RTc4SDcxV0dQR0hkQmRnWFFjZVhaaHJzSGdvWkZadWQ2eXhQOGsz?=
 =?utf-8?B?QzVpd0NpbUZHOHFPWDRDTWd4UnhxQ2xTTjdicU40ajY4czAzZW1wNFZEOGdD?=
 =?utf-8?B?cjZxLzZsVHRhQmxkTnBXWVFYVWx4SUFIN1cxVGlYbFhNR3VhQjNTOTQ2NXh2?=
 =?utf-8?B?VXA3MW9Wa1FMVU1MVlVrbk5xV2VvcWRUKzRPQzNXTWVVMWRrYk5zSkRlbGdo?=
 =?utf-8?B?R0ZZY2dLNmdOMTE2SnhpOTlRK3lITk1TRDZQQXJtd0pLUzdSZHJaY2w0UnUr?=
 =?utf-8?B?TmwxQVVEUXYxZjNucWEvV2FBQmVDajZDK0JCTHZnVG1ISm5jN0wxd2RReEdE?=
 =?utf-8?B?MmxXV2hFVnRCa1FON0FPdTc5VlFqNDhsODhBb2VUOWkwNDhjbTVOQ01XOHp3?=
 =?utf-8?B?cTJoUWdvSXlkbWQ2OXZkZmYrZ2VIT3VRakhsRVRQRkJ0VXJJZmgxWVdua3lt?=
 =?utf-8?B?VnlpTHZMbEkvUWtJbkx5VmFlT2g2ZTluS0hubEh5akF1ZjNScGtmYnQ3UFdC?=
 =?utf-8?B?WWs3RWJOQ1BUYjVyVlVYbjVuVXpQd1YydXZ1UDlLTXM5N0NmS3dSVlVLaEtJ?=
 =?utf-8?B?UVFEQkJCK3V4TGJ0YXl0VFlleGFpMmNrZEtUblR3YWF1U1BmMnU3amRyZTJy?=
 =?utf-8?B?U0x2ZW1WdnlwbjNrWVlWYXVzVHhHaW9BVUwxaFN1Wk8wRngxd0VqQk9YSDl3?=
 =?utf-8?B?cnZTNXJLRzZyQTBFdExuYUwrR0ZtU1hxVGtUelZkM3BUN3l2SVpBZ2UzMkU2?=
 =?utf-8?B?SjdmbThnRVVoTnExR3oxdG5YZnhrRjFHYWxLZ3BrQ2YxdnRSQlBGS1VYR0x6?=
 =?utf-8?B?RkhMRVdJeEcwTFUvM3o0Q01xMVJTQXE4akRwQzRsQXJ3VW5iSUQrR2FOQm03?=
 =?utf-8?B?Uk1McENpQ2QrTUtmaUp2L2tpNlRmd0JqeFc0OUp0YkFQd1UxN0RuZnRIN3hO?=
 =?utf-8?B?MnVNUTVwOGl0dFNZeXpPOEIvWWlObm14YXBPdWRrYmNybUIydG10VWg2eUM4?=
 =?utf-8?B?OXpWbnAxRzVwdnJ1UDNwNVFlczJqRVZ2N3NXdjcwZVVqTTdPc1VVQ3BlbUdS?=
 =?utf-8?B?NklxWm0zZVd3K1gwZEh6RnpKTDF1TjFaUVE0OGE1L05EcDJoeStuK0RuRFZn?=
 =?utf-8?B?TUZXbnByRHpVYmZzQSthS0gwRW91WEsrbFBZdU1QN1RTNTRRUEdQaWpra1lP?=
 =?utf-8?Q?/20NjcDD0zkrHj3aAlqURkkoG/1Fy2S5LS8kWno?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RXlxY25TVlI1WGdPQzQxZGpjaWlZdVBqYWpybDgrcGxYVWJOTW41NStTMmNI?=
 =?utf-8?B?U3BEZXVhM3lRRkZJTFArZmk5WFpuaFpxQ2FRVVFtOG5kSER1dVJyNEk2S21H?=
 =?utf-8?B?bkVKdlFMM3dqeUp1UjRwaTMzOFNsRi9DYUxMQjQ3a0grRjM5WnU2ckg0SnhE?=
 =?utf-8?B?Nko2R3dmZGJTSjNVV0EzYWV2amYzS3NGZ1V4VWM0REEyNTNNckprRWJsVWNW?=
 =?utf-8?B?aW94UlJmNHJCNFg2bjhlZ1I0VHFrbVl0Z2ZKc1RaUW5ycGFIVWF2TUFnRk5w?=
 =?utf-8?B?c2M3WTF6dThBdGRqdkM3by9tRC9NNmJEV01VMzFmZWhlS0dicXRXTHZJOTky?=
 =?utf-8?B?bVR5NVdORTdzeUl2bkhOODJmWlRjSDRIdUJVOGRBZTRhWmx3UXJMMVJ3QWo5?=
 =?utf-8?B?eFMvbnF5QS9Nd0dXQUNYcTdkLzFIVVJNMTJPK0JGbmVWVWovdWJZenNQTG9R?=
 =?utf-8?B?NXQybnBDbWVhZVowT29mL1Yya0FtWk5UaG15eHorUFJIb3p5WmVOTmZtT2tS?=
 =?utf-8?B?VkVvTGxzZlFRWWFCVWdDbmxweWRxYitOUlIrL0dHN2N1cjVMVFlCbkVqWXBo?=
 =?utf-8?B?c0g5cmt2QjdYb0NGa0k0R1Q3eFZmNUZYNkIxWHFpelB1ME1KNFJRVGh6TFlt?=
 =?utf-8?B?NFFCcEVLcVAvaEM2R1hkUkZ5RXN1YWZacFpPc01aSjF3ejROb0xqV1AxNU0y?=
 =?utf-8?B?ejUzblI5OC9wdjNIeVRmL1doOGZWUzd5SEdIcEhlT1h6cklGdW16cHJVSlBl?=
 =?utf-8?B?MXdrRUljeVFMRUhHbUk2eWw4QXROVkRXWnZ1KzJ5YUY5ZjFRZUFGbGhlZVlF?=
 =?utf-8?B?U3NpL2d1QnAyMWFMTE83QW9jOWpaMjRaZFUyaHVvTURucTJFbU4wZGtjNnpQ?=
 =?utf-8?B?M0xuMFpwNnlTekNLNzQrQ2R0cXVlRXVCd2ZVRnlIMUtkaTJ6cjNaZmRKQlZ1?=
 =?utf-8?B?bVFMb2crWmNrakF3dFd3c1FvS3VxKzFhS0ZUclVUVzdLM0ViejhxcStUNWl4?=
 =?utf-8?B?SkZhd1BNZ05Rcmt5TXBSa2F3Q282Z081UUFjUXNaOTlpN0UwTjErQ3JueFZM?=
 =?utf-8?B?NURBd2RlRXQ4MnhtRE8zaU1sUHNRZEdESDJCbmVaQkVmUVRXdS9BVzFkUE03?=
 =?utf-8?B?NVp4UG1iTFcrWlhFQlpERm9scmVoOGhvdE44YXNIVE5hWkpFc1Vqak1GR3Jt?=
 =?utf-8?B?TDdjWjlKdXZmSCtyR0FOTjQ3ZlZMS0dCdU5NSTZYU1F1V1lWWFh1NkFzZHIw?=
 =?utf-8?B?Y1RVdkVlY256TnEvZitGNVBaQm8rdkFPTThVTzBQNzY5QnMvVHhTc3l5MTBs?=
 =?utf-8?B?ZnpmdWR5UGhoZWdnVVh6dlIzakd2MHFFNHJFNk81NFlsZWNQV0F5TFlBL0N1?=
 =?utf-8?B?NE5JWm9aeXpqQlQzdnpiM3RxQTE4MlFmb1FoMFFCNG5LUERlWjhrTDRIV25R?=
 =?utf-8?B?RHB5SzRCUG1hcVY1Z0czamZyZEFRRzNhUEVEY0lRd2JpNDByaXBwTFFQRHdU?=
 =?utf-8?B?MzhGRHhyVDVKSkV2alUyYlZ6N1BiSk5wSm1EMlJVWGhqNUtZc0s5V3RrQm1W?=
 =?utf-8?B?QkpvNmdHdUFEc3F1VFJCanozdVZrVHZua2FzUXFRY2JjeTJyMUNjRzZ5aDEx?=
 =?utf-8?B?a2xxazR0alQ4cUV0WStrSTJKVnpNSWpMRjU0OWFYbHQxVnV0aXV0Z1JvUCtr?=
 =?utf-8?B?OSttLzFlNXpRVjE3OENNYndWUDBMREVTWWRkSHVjanU5MjZuRFQ1WFdkMWJt?=
 =?utf-8?B?MVFSMDRFeGF4T0w1MS85cEQ0d2JVSkRLWUI5NlJmWm9HVnBsM1BiTEcxMXQ0?=
 =?utf-8?B?L3lkZ3QxNXBqais1U0lGNkgvUktOdWV0VjZKTU5PcTJ1UTdMUGc0aE1qdjFC?=
 =?utf-8?B?dkNHUzdLdzRQL0ViRmRmTnRkd21IQ2FDVWRXVisvQlpWbWUvMTN1ZzdUTHdW?=
 =?utf-8?B?bXpkN2JwcmRzdHdlQ0k5cEJtM2t2ZnpVMWFWRFRZbUhlbkRrN2N6eVdzSXp1?=
 =?utf-8?B?VzIzcTMyR05jNWY5U3F0V0xEYjE5c3pHSkpEZXFMS04vUlJEbWpYdTdmNFcr?=
 =?utf-8?B?RkxqVUdWYkN5enZqLzRUVGxadVloTDBBT0lWNTF0UnZYNHhibjRBcit2b25G?=
 =?utf-8?Q?GcTFkQwSL5XruePfrfd3wYoyF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3fc6c3-4ed2-4e7d-c017-08dc6859a986
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:35:48.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPXudLPG9BbIlxXr+GPznXbSqil5jbWLQF9x8nTQSkcRhZAIFZuG+fCSb2SSN1Ag01AE3+QjLZC3z/C1/6dEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4947
X-Proofpoint-GUID: F0iP6ImTKuERNyfqkny46tS9K9HItQin
X-Proofpoint-ORIG-GUID: F0iP6ImTKuERNyfqkny46tS9K9HItQin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IE9uIDE4LzA0LzIwMjQgMDM6MTMsIFdpdG9sZCBTYWRvd3NraSB3
cm90ZToNCj4gPiBBZGQgbmV3IGJpbmRpbmdzIGZvciB2MiBNYXJ2ZWxsIHhTUEkgb3ZlcmxheToN
Cj4gPiBtcnZsLHhzcGktbm9yICBjb21wYXRpYmxlIHN0cmluZw0KPiA+IE5ldyBjb21wYXRpYmxl
IHN0cmluZyB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIG9yZ2luYWwgYW5kIG1vZGlmaWVkIHhTUEkN
Cj4gPiBibG9jaw0KPiA+DQo+IA0KPiBEbyBub3QgYXR0YWNoICh0aHJlYWQpIHlvdXIgcGF0Y2hz
ZXRzIHRvIHNvbWUgb3RoZXIgdGhyZWFkcyAodW5yZWxhdGVkIG9yDQo+IG9sZGVyIHZlcnNpb25z
KS4gVGhpcyBidXJpZXMgdGhlbSBkZWVwIGluIHRoZSBtYWlsYm94IGFuZCBtaWdodCBpbnRlcmZl
cmUNCj4gd2l0aCBhcHBseWluZyBlbnRpcmUgc2V0cy4NCk9rLg0KPiANCj4gPiBQSFkgY29uZmln
dXJhdGlvbiByZWdpc3RlcnMNCj4gPiBBbGxvdyB0byBjaGFuZ2Ugb3JnaW5hbCB4U1BJIFBIWSBj
b25maWd1cmF0aW9uIHZhbHVlcy4gSWYgbm90IHNldCwgYW5kDQo+ID4gTWFydmVsbCBvdmVybGF5
IGlzIGVuYWJsZWQsIHNhZmUgZGVmYXVsdHMgd2lsbCBiZSB3cml0dGVuIGludG8geFNQSQ0KPiA+
IFBIWQ0KPiA+DQo+ID4gT3B0aW9uYWwgYmFzZSBmb3IgeGZlciByZWdpc3RlciBzZXQNCj4gPiBB
ZGRpdGlvbmFsIHJlZyBmaWVsZCB0byBhbGxvY2F0ZSB4U1BJIE1hcnZlbGwgb3ZlcmxheSBYRkVS
IGJsb2NrDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXaXRvbGQgU2Fkb3dza2kgPHdzYWRvd3Nr
aUBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhl
cyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtIGZvcg0KPiBleGFtcGxl
IHdpdGggYGdpdCBsb2cgLS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUgZGly
ZWN0b3J5DQo+IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQo+IA0KPiBZb3UgYWxyZWFkeSByZWNl
aXZlZCAqZXhhY3RseSogdGhlIHNhbWUgY29tbWVudC4gQ2FuIHlvdSByZXNwb25kIHRvDQo+IGZl
ZWRiYWNrcyBhbmQgYWNrbm93bGVkZ2UgdGhhdCB5b3Ugd2lsbCBpbXBsZW1lbnQgdGhlbT8NCj4g
DQo+IA0KPiBQbGVhc2UgcHJvdmlkZSBjaGFuZ2Vsb2cgYW5kIGV4cGxhaW4gd2hhdCBoYXBwZW5l
ZCBpbiBiZXR3ZWVuLiBUaGVyZSB3ZXJlDQo+IHNldmVyYWwgY29tbWVudHMgYWxyZWFkeSwgc28g
ZGlkIHlvdSBpbXBsZW1lbnQgdGhlbT8gV2VyZSB0aGV5IGlnbm9yZWQ/DQo+IA0KPiBUaGVyZSB3
YXMgbm8gc2luZ2xlIHJlc3BvbnNlIGZyb20geW91Lg0KDQpTb3JyeSBmb3IgdGhhdC4gSSB3aWxs
IHRyeSB0byBkbyBiZXR0ZXIgZnJvbSBub3cgb24uDQoNCj4gDQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9jZG5zLHhzcGkueWFtbCAgICB8IDkyICsrKysrKysrKysrKysrKysrKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L2NkbnMseHNwaS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL2NkbnMseHNwaS55YW1sDQo+ID4gaW5kZXggZWIwZjkyNDY4MTg1Li4wZTYwODI0NWIxMzYg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9j
ZG5zLHhzcGkueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvY2Rucyx4c3BpLnlhbWwNCj4gPiBAQCAtMjAsMjMgKzIwLDgyIEBAIGFsbE9mOg0KPiA+
DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAtICAgIGNvbnN0OiBj
ZG5zLHhzcGktbm9yDQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
VmFuaWxsYSBDYWRlbmNlIHhTUEkgY29udHJvbGxlcg0KPiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAgICAgLSBjb25zdDogY2Rucyx4c3BpLW5vcg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBDYWRlbmNlIHhTUEkgY29udHJvbGxlciB3aXRoIHYyIE1hcnZlbGwgb3ZlcmxheQ0KPiA+
ICsgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogbXJ2bCx4c3BpLW5vcg0K
PiA+ICsNCj4gPg0KPiANCj4gTm8gbmVlZCBmb3IgdHdvIGJsYW5rIGxpbmVzLiBCVFcsIHRoYXQn
cyBqdXN0IGVudW0uDQpPaywgd2lsbCBjaGFuZ2UgdGhhdC4NCj4gDQo+IA0KPiA+ICAgIHJlZzoN
Cj4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBkZXNj
cmlwdGlvbjogYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250cm9sbGVyIHJlZ2lzdGVyIHNl
dA0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFNs
YXZlIERNQSBkYXRhIHBvcnQNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjogYWRkcmVzcyBhbmQg
bGVuZ3RoIG9mIHRoZSBhdXhpbGlhcnkgcmVnaXN0ZXJzDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgeGZlciByZWdpc3RlcnMNCj4gPg0KPiA+ICAg
IHJlZy1uYW1lczoNCj4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gICAgICBpdGVtczoNCj4gPiAg
ICAgICAgLSBjb25zdDogaW8NCj4gPiAgICAgICAgLSBjb25zdDogc2RtYQ0KPiA+ICAgICAgICAt
IGNvbnN0OiBhdXgNCj4gPiArICAgICAgLSBjb25zdDogeGZlcmJhc2UNCj4gPg0KPiA+ICAgIGlu
dGVycnVwdHM6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4gKyAgY2RucyxkbGwtcGh5
LWNvbnRyb2w6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiANCj4gRG8gbm90IG5lZWQgJ3wn
IHVubGVzcyB5b3UgbmVlZCB0byBwcmVzZXJ2ZSBmb3JtYXR0aW5nLg0KPiANCj4gPiArICAgICAg
UEhZIGNvbmZpZyByZWdpc3Rlci4gVmFsaWQgb25seSBmb3IgY2RucyxtcnZsLXhzcGktbm9yDQo+
ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiArICAgIGRlZmF1bHQ6IDB4NzA3DQo+ID4gKw0KPiA+ICsgIGNkbnMscmZpbGUtcGh5LWNvbnRy
b2w6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBQSFkgY29uZmlnIHJlZ2lz
dGVyLiBWYWxpZCBvbmx5IGZvciBjZG5zLG1ydmwteHNwaS1ub3INCj4gPiArICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVsdDog
MHg0MDAwMA0KPiA+ICsNCj4gPiArICBjZG5zLHJmaWxlLXBoeS10c2VsOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246IHwNCj4gPiArICAgICAgUEhZIGNvbmZpZyByZWdpc3Rlci4gVmFsaWQgb25seSBm
b3IgY2RucyxtcnZsLXhzcGktbm9yDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlZmF1bHQ6IDANCj4gPiArDQo+ID4gKyAg
Y2RucyxwaHktZHEtdGltaW5nOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAg
UEhZIGNvbmZpZyByZWdpc3Rlci4gVmFsaWQgb25seSBmb3IgY2RucyxtcnZsLXhzcGktbm9yDQo+
ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiArICAgIGRlZmF1bHQ6IDB4MTAxDQo+ID4gKw0KPiA+ICsgIGNkbnMscGh5LWRxcy10aW1pbmc6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBQSFkgY29uZmlnIHJlZ2lzdGVy
LiBWYWxpZCBvbmx5IGZvciBjZG5zLG1ydmwteHNwaS1ub3INCj4gPiArICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVsdDogMHg3
MDA0MDQNCj4gPiArDQo+ID4gKyAgY2RucyxwaHktZ2F0ZS1scGJrLWN0cmw6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBQSFkgY29uZmlnIHJlZ2lzdGVyLiBWYWxpZCBvbmx5
IGZvciBjZG5zLG1ydmwteHNwaS1ub3INCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVsdDogMHgyMDAwMzANCj4gPiAr
DQo+ID4gKyAgY2RucyxwaHktZGxsLW1hc3Rlci1jdHJsOg0KPiA+ICsgICAgZGVzY3JpcHRpb246
IHwNCj4gPiArICAgICAgUEhZIGNvbmZpZyByZWdpc3Rlci4gVmFsaWQgb25seSBmb3IgY2Rucyxt
cnZsLXhzcGktbm9yDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gPiArICAgIGRlZmF1bHQ6IDB4MDA4MDAwMDANCj4gPiArDQo+ID4gKyAg
Y2RucyxwaHktZGxsLXNsYXZlLWN0cmw6DQo+IA0KPiBQbGVhc2UgdXNlIHNvbWUgZWFzaWVyIHRv
IHJlYWQgbG9naWNhbCBwcm9wZXJ0aWVzLCBub3QganVzdCByZWdpc3Rlcg0KPiB2YWx1ZXMuIFNw
ZWNpZmljYWxseSwgdGhpcyBpcyBpbXBvc3NpYmxlIHRvIHJldmlldyB3aGV0aGVyIGFueSBvZiB0
aGVzZQ0KPiBhcmUgYWN0dWFsbHkgT1MgcG9saWN5LCBpbnN0ZWFkIG9mIGhhcmR3YXJlIGNvbmZp
Z3VyYXRpb24uDQo+IA0KPiBZb3UgYWxzbyBtaXNzIGNvbnN0cmFpbmluZyB0aGVzZSBhbmQgcmVn
IHBlciB2YXJpYW50IChidXQgdGhhdCB3YXMNCj4gbWVudGlvbmVkIGJ5IENvbm9yLCBJIHRoaW5r
KS4NCg0KQWxsIG9mIHRoYXQgd2lsbCBiZSByZW1vdmVkLCBQSFkgY29uZmlndXJhdGlvbiBpcyBz
dGFibGUgYXJvdW5kIHdob2xlDQpTUEkgZnJlcXVlbmN5IHJhbmdlLiBJbnRlcm5hbCBTb0Mgc3Ry
dWN0dXJlIG11c3QgYmUgY2hhbmdlZCB0byBjaGFuZ2UNClRoYXQgdmFsdWVzLCBpdCB3aWxsIGJl
IGVhc2llciB0byB0cmFjayB0aGF0IGluIHRoZSBkcml2ZXIsIGJhc2VkIG9uDQpTb0MgdmVyc2lv
bi9vdmVybGF5IHZlcnNpb24oaWYgZXZlciB0aGF0IHdpbGwgYmUgbmVjZXNzYXJ5KQ0KDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

