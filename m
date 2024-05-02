Return-Path: <linux-kernel+bounces-165991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908C8B946F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D568428400B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED02135B;
	Thu,  2 May 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wdXDQ2C4";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BFMsJ3Uc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4D2032D;
	Thu,  2 May 2024 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629420; cv=fail; b=G2OLBmL4IsrtXcmsIOizJ1xfH0OzF8+YASGGps22VOg+cN3zuGh6l4VmqnV91YRyggm7VWfujbJMLSZ7NqdPoQAf9nCyfpENw6KvvFpfn2cKJzFUhj+waPLPpPdnsfBh+eWUXryIXaZKrklbet7ycAnU89DepdEIXH6fgcspl3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629420; c=relaxed/simple;
	bh=F8+1cY/dI/cVOBW/hPgmHxdS8zSu0GL3sMieZe+ocqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLZ70ayhxXvM96/HXVslzIxsSyDoPc5ntDYCDrxrxWW9cFpTq40Z4MNqYLCj58fEDUCCYWEbAFys9KRhYnqU/4nHFtrJJp9+TgRwQ7YgUhuXGK3MwnAD/R4ELIM3z3paBSPHRWIBAT/QZ0O1kB9/dkMpJr1NwINJasEolfvksvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wdXDQ2C4; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BFMsJ3Uc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714629418; x=1746165418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F8+1cY/dI/cVOBW/hPgmHxdS8zSu0GL3sMieZe+ocqY=;
  b=wdXDQ2C4LYeIdcPkZ7SVCwa7FXKgeV1kwOKmtdfzfRnCi866+fN7gETj
   qKddjEWPbpq6n19fYw6ApIRkkxygxt2mfxIlmlvg8KPqIWMIEA3F5ezg3
   7cwEpJrJyamRCEgZNQP9uNT+3XCUiL9Gi76JLY+pSAA5P0nZklQKTE60y
   ZjHj1d6vxF/6I+ctAAAzlxCs+8QaG8jXJJd2kfy3zjO4i9FjHEH84zGzN
   gWyOgM5a2q5E+kKZ6Y9wvY4s9pTht6ec85gviYnZKXKPLOwwFiy8MHDhB
   ULTiJDXyNtUudCWQMWPXu75dme7X4vyQBMZ7BxAxZy10kHSSrF9ugp2Uy
   Q==;
X-CSE-ConnectionGUID: kDMd9dskThyLmww7EZH4FQ==
X-CSE-MsgGUID: AgcycY+SSIyFHMOOu+24pQ==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="190690732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 22:56:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 22:56:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 22:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ9HCgRPn30k5SlTQw+N+ou3uypGLtlNLKQ8SRqcsW6qmklADIYR9Bs/qzOaKnQcLgII+orVbVCG/bkE/Fmkpp755YRSpOIj0wVL9Dj7CGysds/RAurS5+ZY15F5ovh0epxz75KVDb6n0UhiB5TOZOqXhXk3acQVx2H4MbLC4JpfAMudOjyD+tz4wlrZ+8EVNcrC8MntoGDh5u8e3ROwNy7IrSEOKzy6uUR+7/tHKUKeUyUes88o6QdG50UvKtRpHBHVlI/hRgZmI9XpN0+KEpeVNa0sbOOR9gLHkffZKj0ASiHsz0AsFO0HZJ/S7c1XvLlkz//DgiR6rDcq3zZW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8+1cY/dI/cVOBW/hPgmHxdS8zSu0GL3sMieZe+ocqY=;
 b=XjYod+yMc0cawXmJtJ3vuSBl5cIH0/8FNgWIb/thYXwB+0tmcc0gHda87whFDp0EYexXTzT+DWugUysBmwdPfZF6ZJbze2npvW9OlqcSDH3nPB+O1+QNFgVBmii+I4PNXQ858/giblMAPU9bZ1/FDQ9/AfhwT9wkK7qhQ5So7BaAWzE5iv6E0ya/1aMHCPEYSqEyi56qhngzQyp+r9uzp88auQf56HEhs8x5x98z4KppPLAmrotTIIPTBFHRj9ZAyZhr0WUzcCTlh76dkLDQNo8YSOAQ6ZUbnEiBbr5E7GtGb7qf9nxWhbLcjujcwNvzv5ICLVx94lv/TTKfzWvSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8+1cY/dI/cVOBW/hPgmHxdS8zSu0GL3sMieZe+ocqY=;
 b=BFMsJ3Uc39wXGIGN4BxIybh/So9jOiieSrgvls0S2m4liy5M5If2DEZxp/lwSxxgyogWT674cKJDYIx+7NKyJkZUo/ov80t6MWASHgiSuEuaxHihHUWCyqr7bFvgPnH6dh7/JF5ItVubxK8Z5Bs87p1EottkiPwJAFK1jZr3I56/XSAQohou17TK+Zv4nhZmsW28gq1d+QWHj/bn5TW8PiDBcg3fkiR64PEgJfpT15zN1Q9jcRcVRwS48p8E2a9rs3WZMu/lxDrv8NSlL6HiTohwpliffVGcmsr8O7Mmk8Dw7qIY57B1PXKm3rR1HxTY77Bjx3Sp5O5FMRD0J/lgbg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 05:56:46 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:56:46 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <conor@kernel.org>
CC: <andrew@lunn.ch>, <ramon.nordin.rodriguez@ferroamp.se>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHakZAq1RqgTRBTy0mY7YMhKP6dQLF8jIwAgAAKqICAAnocgIAAJ6wAgAGo6gCAADlYAIACbMEA
Date: Thu, 2 May 2024 05:56:45 +0000
Message-ID: <b06b5195-9079-485e-b83f-db416f16a389@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder> <20240427-vaporizer-pencil-be6a25030f08@spud>
 <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>
 <243dab3b-ac07-4d88-8c43-aed53a34cea9@lunn.ch>
 <bc54d514-cd93-4b12-a10a-3d613efc98a2@microchip.com>
 <20240430-sharpie-manor-fd53df03b77d@spud>
In-Reply-To: <20240430-sharpie-manor-fd53df03b77d@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB7631:EE_
x-ms-office365-filtering-correlation-id: fc1ed9f8-7b0a-44c5-8ae8-08dc6a6ca657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SVlRTzZ5cGVDTi9rWkhQSDVvS3pISW0xRVlLc2V0ak9tclp2Q2k0NERydWNv?=
 =?utf-8?B?WEErN3pZeTQ1MFA1MEc1TnRTSU5GeEJuK0tzSGZuaG1xSU9nb2c3MThLS2VJ?=
 =?utf-8?B?eEI2NzBQNExCd2Q3TFRwQnNWeWl6YXppSXkxTjhXdlBhekpKbzhrNTNXS2NI?=
 =?utf-8?B?MUQyVEx2SEpoVUIwZWhSeit4WjZqRXovMGJ0YWxWakUvWFVnQ2liWkxHSWlZ?=
 =?utf-8?B?TjFsK2xyaFBPWXlDNVkzbzc1bmdTNEhHcjJwam4raERGbkZYa2RGUWpSL3VC?=
 =?utf-8?B?MGJYTGpLODBhUTFHNWVWTkR2SHM3NDRpay8welNTQVE5dmtyeHNOMjVwWFp4?=
 =?utf-8?B?OFdSM3VDbnVYSmh5S013SjM4N1YzWEl0SGtlNXpCVnM0cUJOQTN5cEp2cXAy?=
 =?utf-8?B?MTBOMzVaU0ZQcVNTTHpTa0M3RTJRcUpsSUxrcm1WZXlGRWFQMzA1RzJmRm1k?=
 =?utf-8?B?MGl1WXYwbURvUTl4VFZta3h1V01wWG91ekp5UFkzQmc1SUdNcnlaWkZEWldl?=
 =?utf-8?B?d0hxUXdQMTFUM083Vm1KWFp3WkJlM2E1YnNSczVDME1lQnZySmJZdytPeXJO?=
 =?utf-8?B?K0ZUMW5DT3pkWHdSM1VDTUtnQVVsSk1Ga1dBT2lFeGpLR0lDVjI3dDFEaUdh?=
 =?utf-8?B?alhQK0hYZGV5MzhiTk9qWHRCb1hiTWZKL2UvTnNldFM1RVJVMjladzl6RWRS?=
 =?utf-8?B?VU1mc0Y3Tmt3bDdyOXhhSGJMN1FZUzdtcmE0a3hkeFR5RjIyUTMyMHZPVmlx?=
 =?utf-8?B?aGF6bVpMSmcrZk5KU0xjZWpvR1hEY2JvWm12L3BybmJXRUUvL1EwczJ3d1M3?=
 =?utf-8?B?c3NXdG4vN1NHZE10MGcvbklmNHBBSGZna3VEMG1oVDQ0TGdzdzZOTEE4ZWc0?=
 =?utf-8?B?cmowVzZoWXdHeks5TFFyNlZ5RFlTblFjZkg0TEdHNlFUbHh3d1VVWHZmME54?=
 =?utf-8?B?aGJGTkdaeFlFaE1YTXd1K0tMc3NYTGZ3bmcwV3BjZ2ZrNmFwM1JqWFdDS25B?=
 =?utf-8?B?R0pVYWdkZlpjeVFlanNNZXBBZU92SitLQlgvWGdRQVBZaWNsb2F5dDAxdHl6?=
 =?utf-8?B?bWpLbzVRVHQ2WWszS21xSTdsTG5RdExrTVUrKzZybFlwQ2I0V0VGTFRKdEU1?=
 =?utf-8?B?Y2tqUG5vaHNmSTlVUFJCTHNsUm1ML2xNSW9JWmdRWnRUaFBlanB1eHF5cndx?=
 =?utf-8?B?eTFpdnh3ZU9TT3FoWUFaQThhYWN0eVd5MWgrbG5Ta21GUFg1YUVwZXowWC96?=
 =?utf-8?B?Y2VHSWNIMllYZXZiUDdNS0xvMEcvRVNxa09PZm1Xb2dadm9HN290MkEwdVZE?=
 =?utf-8?B?UVZKTC80ejhpc2NWZVAxejNsOTM0T1FLczNpNm43Z3o0ZHMrdC9nUTlOSXVt?=
 =?utf-8?B?V0hGK0VWUWdGSDR2ZE13MDBWRERKVlVPbG5pYUNYSlozalE0eTVTdGhjV29y?=
 =?utf-8?B?UzBDd1o5TWh0aklMVUtDZ0R4QXU5VWFKZlhFTnRBVTVFOWY2THFTQ2dnNDZh?=
 =?utf-8?B?SzNndjVHQmZLTW80amZVaVNYVjV6VFkvUWREeEZWZ1RxNW1JOG9qV2FobkhX?=
 =?utf-8?B?WmZFZDlneFZLcUVNbHpZR2RMNVd0MjdPNmJ4cUpPRFpRVjJmTlVnYVR1UEpi?=
 =?utf-8?B?WExwT0pMVEE0Nm5hRGtDRnorVlRORHQ2WjFTWFFIeTltRUh2c1JMYlg5UXZR?=
 =?utf-8?B?cHR2RXVPK25vM3hnOS8zcGhzUENpMTJ5WlhJL2lkOHliYkJ0dUw5WDZHVzNs?=
 =?utf-8?Q?cw71BZ1zg7z7WaSEt4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJNelVZbDZaTldacTlMVVRmOUZBTXFmM09GTkp6QlBQR24yS21DeEZhaE1P?=
 =?utf-8?B?L0V4NHVZc3F6QlU3SU10dkFtQXFubDQrTlp1ZmpGYVZwbDNxQlpiV3ZjZDZ0?=
 =?utf-8?B?WEtOTmZRTTlKLytEU20valNmQTdHS1NtU0FXN1oyRmg3MVFsa01acUJwbXdu?=
 =?utf-8?B?T0w4c3U4c3VGTnVJT2FHUG10OXZHUXhaem9zQlMvT3k1cE54R0kyU2FuSjdI?=
 =?utf-8?B?dWExMlpKcnhsdW1POEE1UnJoMlFzS2tnVXRrNjFhQ0haNWFaWVVqV2RKdHds?=
 =?utf-8?B?bDhpRkZEK2xkNUd4blZJOUkrbGtWazI3UlJFTHF3aGlpblFTT25Sb0VHdnZ3?=
 =?utf-8?B?aXN4WHNZbGkvaDdFNzFQSjdlSzRhTDVhdDQ1UjAzL3drV1FITWxZQ3B6My9T?=
 =?utf-8?B?Yk4ySGRsbHJjSmd6aTFyYzl5cTIzdy9MZExJbmlCbDJDZlg4Um1oREZFY2NW?=
 =?utf-8?B?ZU9YSlYyYzE0TUZFYmVHYkRkeElxUTBwc21vdVpsVkNmRnZuaVBQRXRaWG9O?=
 =?utf-8?B?MkpiNDNUS2Fkdk00TExZS2x1VjRBNlJybEZnQitxbTJZY0RhNjRSQUNkOTFt?=
 =?utf-8?B?Q1dlRWxqNlFXOUU1MlJRUjZHQlIrV1hhaWJ6aDBEazZ4dzJVTHhCMzFXemdO?=
 =?utf-8?B?Y0p2Mk1hME9QUUMwZlYyempJSTI0M2FxSDNJMHpnc2FRMnhlWjdQY3MreExX?=
 =?utf-8?B?N3FGMzlYdmhScDQ3bEJNUVppRVFTM2IvRVhzQ0NyUlpiSDhLZ3g5TkUwRDVq?=
 =?utf-8?B?NFZxWTlIUW9GUmVsbFdncWRMNUczWkIyNXZNaEJPOGY1aFoxekEzMGdFbXRy?=
 =?utf-8?B?OTFMWUFqVGh1R1djb2k4VzRFWk9XU01lcHl1STI0Kyt0bjAvVzNHN1pSTXBM?=
 =?utf-8?B?UmM5dnpYQTFWZWFhTGs2V1U5OCt4RTg1OXRXUFFBYlBUZCtZOUVoYlRzd2JC?=
 =?utf-8?B?czcyU3VGdlNndlUyMmhKVWNmUWRTcVhPekxVU0Q5UW9UY25SVzJEdnQ3VnRp?=
 =?utf-8?B?YUMrWGd4Mkd2WmVUMDNTNXZPdndjblUyYnQxQnpzeEpUM2Urc05DdDlyU0Ev?=
 =?utf-8?B?UFd3UzJZRmJ6dk5YMzR1QTlhQU56Rkpub1hqR3Bua0lxZHo1SmFjdjFVM0xV?=
 =?utf-8?B?WktRUXJkOVluRzYycHBvaEhGOE1TQWxJYXJ3WmFGUTJwMFJ6OGVzOXpNYlBi?=
 =?utf-8?B?SEpoTjhIRUZmaU8vUE0zUmlaVER4UG1JSEx6am1zSC9xZTA4WkZrU0Y5aHhn?=
 =?utf-8?B?VnR0b3VOTzVXNkxGZStxRk9oSTU0eFNHN2I5V1ZQUE5tOExyY1J2YVpnZEE1?=
 =?utf-8?B?T1hYR1MvR0Y3ZUw2UWVTbWcvMnVockEvbUYzUThtcjU4aEs5NEZoamhJcVR3?=
 =?utf-8?B?eU5wR1NFeDY2QmJaS3RCOExSWjRQM0NkVDVoSk54eko3SDRjK2FieEZMaVVJ?=
 =?utf-8?B?K3BJYlFRWVUrL2laOG9JNVlmZ0Q5M0NrRFl1bFA0SUF6TjZRbzFrbGJIZU1K?=
 =?utf-8?B?bW93cEF0NmJnWUVhK3ArQWZ2ZTZKVUw5eU90dXFUYms4RmdOTTFsdG41SEhF?=
 =?utf-8?B?MGdzMWd6ZWxYbWZJbTJDWmNjTDFjbm5FbXZSWHlabktCSVdSclNYRENXU0RX?=
 =?utf-8?B?dzNNdyszY2NXNTdISERZOEtiVHNadVJlVjByT3pGcXRuSHo5MGtHSytBekFa?=
 =?utf-8?B?LzRERVNWUm5seGljRWNOMW1iNVR5UkVjZGVUNitCZ25WREsxUlV5cExWR0hN?=
 =?utf-8?B?TVBxMjdwY0JpT1VyRXlYblBDVHNoU2FuSjI5b2lBci9pMHJUR0R1ZS9Za3c2?=
 =?utf-8?B?cy8vSExzR2N2VDVwTkY0QStVYlJ2UjBON3NIUzVkQ1M3VFMzK1l1all6N2tq?=
 =?utf-8?B?cVFubmw0dnBzQ3diVkFDbVpuSksvYXpKZUx0UGpjamVQQUxqL1h3bXJGeGFo?=
 =?utf-8?B?NTFwMnlzOXVWQmFGUzd6ZzNNT0RoTFpXU1NFaHludFdUcDFMazJHK0lpcG5I?=
 =?utf-8?B?Q2FnOTF1TlhqT2ZsNTY5YjYzdkdMeHMwT0FwTGpDQVFCM2gyeDlId05uUk5Y?=
 =?utf-8?B?NFNtMXBxSDZHVlZjSUpvVkZjSXREVU1rQ0FnOWxtbUc3STBaL3B6NDVXNTJx?=
 =?utf-8?B?Q0tMbkM2QTE4L1Y2NEpSakZKMGZIakptWmJmVGVmSVFML2dpbUJZcVpGMzM3?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966BB7CF7ACBB946969A545B6C2E9353@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ed9f8-7b0a-44c5-8ae8-08dc6a6ca657
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 05:56:45.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq83xTb+8qTyNisCko2D78/NKGYLg1oMX5rq4i5XzMBWE3EUoJNHavjW/PeWTeiIfyPZhNRyoeahocOmGCmczsgkTz6KniK8546GEjy8HiU1MVDQ10hcrB/95dbQqs+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631

SGkgQ29ub3IsDQoNCk9uIDMwLzA0LzI0IDEwOjI1IHBtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgQXByIDMwLCAyMDI0IGF0IDAxOjMwOjIyUE0gKzAwMDAsUGFydGhpYmFuLlZlZXJh
c29vcmFuQG1pY3JvY2hpcC5jb20gIHdyb3RlOg0KPj4gSGkgQW5kcmV3LA0KPj4NCj4+IE9uIDI5
LzA0LzI0IDU6MzkgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4+IExvb2tzIGxpa2UsIHRoZSBiZWxvdyBjaGFuZ2Vz
IG5lZWRlZCB0byB3b3JrIGNvcnJlY3RseSwNCj4+Pj4NCj4+Pj4gbGFuODY1eC5jOg0KPj4+PiAt
IGNvbXBhdGlibGUgc3RyaW5nIHRvIGJlIGNoYW5nZWQgbGlrZSBiZWxvdyBhcyBpdCBpcyBhIGZh
bGxiYWNrIGZvciBhbGwNCj4+Pj4gdmFyaWFudHMsDQo+Pj4+ICAgICAgICAgLmNvbXBhdGlibGUg
PSAibWljcm9jaGlwLGxhbjg2NTAiDQo+Pj4+IC0gRFJWX05BTUUgdG8gYmUgY2hhbmdlZCBsaWtl
IGJlbG93LA0KPj4+PiAgICAgICAgICNkZWZpbmUgRFJWX05BTUUgICAgICAgICAgICAgICAgICAg
ICAgICAibGFuODY1MCINCj4+Pj4NCj4+Pj4gbWljcm9jaGlwLGxhbjg2NXguZXhhbXBsZS5kdHMg
Zm9yIGxhbjg2NTA6DQo+Pj4+IC0gY29tcGF0aWJsZSBzdHJpbmcgdG8gYmUgY2hhbmdlZCBsaWtl
IGJlbG93LA0KPj4+PiAgICAgICAgIC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW44NjUwIjsN
Cj4+Pj4gICAgICAgICBPUg0KPj4+PiBtaWNyb2NoaXAsbGFuODY1eC5leGFtcGxlLmR0cyBmb3Ig
bGFuODY1MToNCj4+Pj4gLSBjb21wYXRpYmxlIHN0cmluZyB0byBiZSBjaGFuZ2VkIGxpa2UgYmVs
b3csDQo+Pj4+ICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIsICJtaWNy
b2NoaXAsbGFuODY1MCI7DQo+Pj4+DQo+Pj4+IEkgdGVzdGVkIHdpdGggdGhlIGFib3ZlIGNoYW5n
ZXMgYW5kIHRoZXJlIHdhcyBubyBpc3N1ZXMgb2JzZXJ2ZWQuIEFueQ0KPj4+PiBjb21tZW50cyBv
biB0aGlzPyBPdGhlcndpc2Ugd2UgY2FuIHN0aWNrIHdpdGggdGhlc2UgY2hhbmdlcyBmb3IgdGhl
IG5leHQNCj4+Pj4gdmVyc2lvbi4NCj4+PiBBcyBDb25vciBzYWlkLCB0aGlzIGlzIHByb2JhYmx5
IHJlbHlpbmcgb24gdGhlIGZhbGxiYWNrDQo+Pj4gbWVjaGFuaXNtLiBQbGVhc2UgbG9vayBhdCBv
dGhlciBTUEkgZGV2aWNlcywgZS5nLiBod21vbiwgYW5kIHNlZSBob3cNCj4+PiB0aGV5IHByb2Jl
IGZvciBtdWx0aXBsZSBkaWZmZXJlbnQgZGV2aWNlcy4NCj4+IEkganVzdCByZWZlcnJlZCB0aGUg
YmVsb3cgZHJpdmVycyBmb3IgdGhlIHNwaSBkZXZpY2VzIGhhbmRsaW5nIGFsb25nDQo+PiB3aXRo
IHRoZSBjb21wYXRpYmxlLA0KPj4NCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9uZXQvZXRoZXJuZXQvZGF2aWNvbS9kbTkwNTEuYyNMMTIz
OQ0KPj4NCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2Uv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvYWRpL2FkaW4xMTEwLmMjTDE2NDQNCj4+DQo+PiBsYW44NjUw
IC0gTUFDLVBIWSBjaGlwDQo+PiBsYW44NjUxIC0gRVRIIENsaWNrLU1pa3JvZSB3aXRoIE1BQy1Q
SFkgY2hpcA0KPj4NCj4+IFNvLCB0aGV5IGFyZSBkaWZmZXJlbnQgaW4gaW50ZXJmYWNlIGJ1dCBu
b3QgaW4gZnVuY3Rpb25hbGl0eS4gVGhlcmUgaXMNCj4+IG5vIGRpZmZlcmVuY2UgaW4gdGhlIGNv
bmZpZ3VyYXRpb24uIFNvIGxldCdzIGNvbnNpZGVyIGxhbjg2NTAgaXMgdGhlDQo+PiBmYWxsYmFj
ayBvcHRpb24gZm9yIGxhbjg2NTEuDQo+Pg0KPj4gQnkgcmVmZXJyaW5nIHRoZSBhYm92ZSBsaW5r
cywgSSBoYXZlIHJlc3RydWN0dXJlZCB0aGUgY29kZSBsaWtlIGJlbG93IHRvDQo+PiBzdXBwb3J0
IHdpdGggbGFuODY1MSBmYWxsYmFjay4gU3RpbGwgdGhlcmUgaXMgbm8gY2hhbmdlIGluIHRoZSBl
eGlzdGluZw0KPj4gZGV2aWNlIHRyZWUgYmluZGluZy4gVGhpcyBpcyB0aGUgb25seSBjaGFuZ2Ug
aW4gbGFuODY1eC5jLg0KPj4NCj4+IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBz
cGlkZXZfc3BpX2lkc1tdID0gew0KPj4gICAgICAgICAgIHsgLm5hbWUgPSAibGFuODY1MCIgfSwN
Cj4+ICAgICAgICAgICB7fSwNCj4+IH07DQo+Pg0KPj4gc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbGFuODY1eF9kdF9pZHNbXSA9IHsNCj4+ICAgICAgICAgICB7IC5jb21wYXRpYmxl
ID0gIm1pY3JvY2hpcCxsYW44NjUwIiB9LA0KPj4gICAgICAgICAgIHsgLyogU2VudGluZWwgKi8g
fQ0KPj4gfTsNCj4+IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGxhbjg2NXhfZHRfaWRzKTsNCj4+
DQo+PiBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgbGFuODY1eF9kcml2ZXIgPSB7DQo+PiAgICAg
ICAgICAgLmRyaXZlciA9IHsNCj4+ICAgICAgICAgICAgICAgICAgIC5uYW1lID0gRFJWX05BTUUs
DQo+PiAgICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBsYW44NjV4X2R0X2lkcywN
Cj4+ICAgICAgICAgICAgfSwNCj4+ICAgICAgICAgICAucHJvYmUgPSBsYW44NjV4X3Byb2JlLA0K
Pj4gICAgICAgICAgIC5yZW1vdmUgPSBsYW44NjV4X3JlbW92ZSwNCj4+ICAgICAgICAgICAuaWRf
dGFibGUgPSBzcGlkZXZfc3BpX2lkcywNCj4+IH07DQo+Pg0KPj4gSSBhbHNvIHJlZmVycmVkIHRo
ZSBiZWxvdyB0d28gbGlua3MgZm9yIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5nIGFuZA0KPj4gZHJp
dmVyIGluIGNhc2Ugb2YgZmFsbGJhY2suDQo+IERpZCB5b3UgYWxzbyB2ZXJpZnkgdGhhdCB0aGUg
d2FybmluZyBmcm9tIHRoZSBzcGkgY29yZSBpcyBubyBsb25nZXINCj4gZ2VuZXJhdGVkIHdoZW4g
dXNpbmcgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIsICJtaWNyb2NoaXAsbGFuODY1
MCI/DQpEbyB5b3UgbWVhbiBjaGFuZ2luZyBpbiB0aGUgbGFuODY1eC5jIGZpbGU/IGlmIHllcyB0
aGVuIEkgZ290IHRoZSANCndhcm5pbmcgIlNQSSBkcml2ZXIgbGFuODY1eCBoYXMgbm8gc3BpX2Rl
dmljZV9pZCBmb3IgbWljcm9jaGlwLGxhbjg2NTEiDQoNCkJ1dCBhZnRlciB1cGRhdGluZyB0aGUg
bGFuODY1eC5jIGxpa2UgYmVsb3csIHRoZSB3YXJuaW5nIGRpc2FwcGVhcmVkLg0KDQpzdGF0aWMg
Y29uc3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgc3BpZGV2X3NwaV9pZHNbXSA9IHsNCiAgICAgICAg
IHsgLm5hbWUgPSAibGFuODY1MCIgfSwNCiAgICAgICAgIHsgLm5hbWUgPSAibGFuODY1MSIgfSwN
CiAgICAgICAgIHt9LA0KfTsNCg0KTm90ZTogSW4gYm90aCB0aGUgYWJvdmUgdHdvIGNhc2VzIGNv
bXBhdGlibGUgaW4gdGhlIGR0cyBpcw0KY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuODY1MSIs
ICJtaWNyb2NoaXAsbGFuODY1MCI7DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo=

