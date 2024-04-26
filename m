Return-Path: <linux-kernel+bounces-159585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28218B30A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB782879EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2413A88F;
	Fri, 26 Apr 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xvBhKDYl";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lxSeeLFc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A12F2F;
	Fri, 26 Apr 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113526; cv=fail; b=hvNz7csDZOXu64UtYnSKfdoPGyQbx2Lb6WjFdLEQnqJmlUDW+R1j+AJR1vCVJs6wf5mFyBjj/cISY8lhIzwCUAqdxxgQVb0+m3MUifhrY+S8gPv2Snn90iaNcdGGnhooDKije9/uLkL1gRBGkTY6HfChCBFKuq9U/bSgpI48zd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113526; c=relaxed/simple;
	bh=ueXrEyQgLeiC1Te3Y53QwLFTjbz1OwjyDE93NGBpiZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XMlQ1FUSloKlekRvAKop0+OBCBHp1tF7PsC4+akPCmMQyn9g64qHP7kqjzfu8dC3IT+bn49c8Id4tQyaF275mCxQoo+EKyjbz+t2YKG96xumjjz/RXezyxcC3y6E10/GCtckTUMwlN+zkA9q3dBniW93TjiAj0D38KjrtyRXnQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xvBhKDYl; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lxSeeLFc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714113524; x=1745649524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ueXrEyQgLeiC1Te3Y53QwLFTjbz1OwjyDE93NGBpiZY=;
  b=xvBhKDYlaKYbNDwHCMk/8OY6m3g6JugmfyHLFJurVBN1CwTdBAJQ7fcR
   4WJfK28ymbAClsJraAmIi5TAsIB/RunsRjOKd2V6GISmdv4cxcH3c1gta
   3mE5S0WqGKOnQWS2uefqhbP/IshQZoEVxgSPXJpbHLRxFkFd4rU3dX3fO
   gEvhQOZG8NmJiPwOfB7Si1Lp190OAa97Et5er+IFK6jFPaKK4wwMLBPfi
   r4JkPgiTLR5D+xNPdht9hGQtTlZ5Sj7HB47Ty38eoXK1DklKK7rbM1v8/
   HOFHXfVfgJgxIXXwM1dp7oxiVtNx8gqWpIxWKDkbKhjbMfK0xmA6a7dAp
   g==;
X-CSE-ConnectionGUID: 7bsMvethRfedngU3dCmVpg==
X-CSE-MsgGUID: 9EznONodRdaADJKY7QYnRw==
X-IronPort-AV: E=Sophos;i="6.07,231,1708412400"; 
   d="scan'208";a="22724979"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 23:38:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 23:38:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 23:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMDSUgSPVHPnFl1hiycV0TZH5e65k+VNqzrqFy9UB0Z5bPCpwXiVdWE5xl0RU6htXmOlslcuD75tzvnzY6+BxpSq7fkbcqPXScqMifDelUOZRutxmVmwofA+uiv70FcZG4F6DyOzKVDGuWDkGohDIaVUDMZbhlkOVtZsZVfhrH1AEFM+1YYpOd2CilOjNdqC5+zsibJDfso5yYfhxCgPZxnMKIOcjfcy2EwrjsrRakr36rvf2UHyPZQ9GX219b+MIuCvn+vwJQivfXabVI2yBkLznZSwMTHCyUU/pjLiQps5wtdetcv8nygEhK8L/pzmMoQYEH4mZSJBSY5YJx74eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueXrEyQgLeiC1Te3Y53QwLFTjbz1OwjyDE93NGBpiZY=;
 b=DJ/SDFxpHyVxP4lnqRqHpRTHqj25vh6Uetvf8LNPUEw8tlMh+C01Poy8jXz7ds66RskRgE/9war5Cr+WepHPSH57bE81w0JwbrBF8ZMWhvZqrNE7O9z51nKGTvjsof+cNYVFVnw2ldxPP0sInvaN7ELZiO4Wcfm9C1fR48atlFnPqVPwu/Z5RiSWedt/s8NOJpNATR14KsBoDfQymQW4P87o9+GpoaDMEEpVAxBRhuk8dtadzkRIopO+kzpMYjI/S93DPt5OD1OcZg5AeE91acLlsC4yBZK8Yu3l/NpxFQBQiFe/HcWQ2gnt4f+DR7xsU9cZyebZZBxs7KM+DZg7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueXrEyQgLeiC1Te3Y53QwLFTjbz1OwjyDE93NGBpiZY=;
 b=lxSeeLFcZLm5nRg8BYnJX/KQlT9n1OFI3tjF0krNtyeRGHJS4bYYZvseGJ25Y2o9vI0GUZPX18/V/cCkiB4PB7elCXCHHkSnc3f8NvxXphXjdpwVduS+Ge0XN2P/Afdxzdj+woxg0oToofCYpdOSnkjjoFFobYOGK0WHA8gV/459zpuX9xME5XzFAEcTWk0Vvs/dtuUhtDARdeh1AjTsQnhmxFBv8xW8SWAdoq6+ajmExPdccClyjDn5vpKKsGTnSZsz2dVQ7BbD/KTknQ8PFWZHaQt3VAfT6UwphUPsLe+0hBztAhGd+PlpzgiGzm15Sib8iJX2ILnR8zbk0qClvg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB7650.namprd11.prod.outlook.com (2603:10b6:8:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 06:38:19 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 06:38:19 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
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
Subject: Re: [PATCH net-next v4 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Topic: [PATCH net-next v4 04/12] net: ethernet: oa_tc6: implement
 software reset
Thread-Index: AQHakZAEWLIz8hJ3EECPod2ygCbMn7F2iCeAgAOdd4A=
Date: Fri, 26 Apr 2024 06:38:19 +0000
Message-ID: <0300fa1d-efdf-4176-836e-d60a905bfd78@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-5-Parthiban.Veerasooran@microchip.com>
 <1083000b-55db-4fea-843a-6d1db802242d@lunn.ch>
In-Reply-To: <1083000b-55db-4fea-843a-6d1db802242d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB7650:EE_
x-ms-office365-filtering-correlation-id: 3ca76a03-d1c2-4775-caa5-08dc65bb75ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZEVNaWptNEszZGF6N0ZXL2ZYdjkwRjdYdCtNUmhUSWViR1dnQW9nYWpmRWg2?=
 =?utf-8?B?TGEvYkFyRzE1ZjYwV0srdHhPbkxpNnZsamlsWDVqa1VLdk9TcitFNVdvS2pl?=
 =?utf-8?B?N2R2aVpZZXNreE5RalY0WllrSmJjSnVtcVpXdllxWWRGdE5FRll4QjJSYVNn?=
 =?utf-8?B?WlBhSU1HNTlTUDBvTm1HSFI4UGNVajBDUVN3T1p5Z3llRnZZR2J1Vm91OVF4?=
 =?utf-8?B?TVdHQ0JCV2RyT1NtVVdWUWFOcXdkRlhmdGYvdFhLVU9pOGx1M0R6SytMdDkz?=
 =?utf-8?B?Q1U1VTZTQ3B5SDVpNXFoT21VQm5Obm9zbnVJS2FNYkdlUDl3WU9YMTdRUVZK?=
 =?utf-8?B?SGVhaHhtUEpVQ0xZVFRYWlUvbUthV0xwdExsRDE0K2hYTVdFNGFzNjVkSitB?=
 =?utf-8?B?UU9yRFd1dm11NTZzd1hYRWVQcVRXUlBJdHlkQlc3ZHkzVDNreWtBU3QxaDJW?=
 =?utf-8?B?SmJtdE5DTTBCbEUxL2dJM0M5VWlNRnFNbjZ5SlhFVEcxSGJpbUpTY3YyN3Jj?=
 =?utf-8?B?WWtGVUpsUmhqRGk1T0o3dzkrbWVxdVNFZTB3MllHQ2ppcS85TmliZ3V1Zytu?=
 =?utf-8?B?UnlETjczQXFxbkRhcmlNZTk1WDJUb2RRV2NpV2M2Tm5KYkZ0TDQ3VDhLZDZm?=
 =?utf-8?B?NWdJVWdpYThIQk9ZbDVzOGVzS1N0TEVaMnFCMzV5MUZaM0JMVThuNjNoRzg3?=
 =?utf-8?B?OTZ1T3k1anN3YkV2K01pMkpiTjVTdzE0Y0E5ZTIxZjJxOHhyK0pHaUl0OUxQ?=
 =?utf-8?B?UHhKeTc1ZXhzMEFnaUhlL1RjY0xHbGtmYWVRbWRjS1NQUjdXWjY0MjRTVXZZ?=
 =?utf-8?B?ZHMzSEZFYjZsaXF2dzB1Tk9yYzNaWlNlOFdrSFdvUFVJcGN1MWMzLzlMRzhS?=
 =?utf-8?B?ejZHMXdkMDlsTnpoVDBQcW1DZ2JPTlFMcHFlcjJIaTJITHQ2QmxVNVZHRFdC?=
 =?utf-8?B?MGUvOUJ4N1AyL3F4R2JsRGl4U3Y5MTFjSE1XM1hpY2Y5SEVvMzNNT2RaL0hz?=
 =?utf-8?B?bmhuV1h1R2Uyc0tYTjB4S0dtM1hKZXBlcktSdmZYWXNwY1l2bk9VZmJIVXJQ?=
 =?utf-8?B?TXFySUNtcHowR0FuaTBMM3dXcWhnNFdNdDdEbDZUeC83T1gxcW9XTEJ2TVZU?=
 =?utf-8?B?S2t2Z1p6aVo2QnJNRlVNWGcxWUNDNnJyYVI0ZFRRSWN3dURTTDIxNWJSczlN?=
 =?utf-8?B?dnF4d2VQNnQycDZFSlhXdm56akU1eExpdHFjc1ZXMDZnZEd1dmg4aWJIR1cy?=
 =?utf-8?B?anB1VnFLcm96ZGtIRlpuTTVUeHRZS0d6cGNRdkR3OHNxN2trcGRuNHQ1ZVdZ?=
 =?utf-8?B?ckcvT3EyQXErTlVNSVNocnA5WHhLcVArZjBSSGdxUXp2RlhBZmNJY1c4QXBN?=
 =?utf-8?B?MnRCbVZYcUM3ZHZkM0FoU0h1ME1hMkxjWjVtZlBIK3dka2NhOFhScHdTVGJV?=
 =?utf-8?B?d1ZWN3B0OHY1emM1U1dpRzZPeWowUDhzZm1qT21FRzgwRmg3RXZhSHZNNlBt?=
 =?utf-8?B?UVdtRGhieXV0Y2JOYXEvditva2dsSlNrZ0tmRGVBTnFRZm1yNHpKRmJaWldF?=
 =?utf-8?B?eGpKcmJsSkhpRnN6a3NtK3JLUmgycVZnRm0rUml4Y0E2aC93aUZqMW9yaXFC?=
 =?utf-8?B?azdHV0xSY0JQOHZOUFBlT291Y1RrUXVyakIrR1RKSGhDKzVTVjg3dWZvTEcv?=
 =?utf-8?B?YTBORjZGUktsNnFyeEV5TytXdHFEblVPU0FtZG16YXlRZUd2aVMrWXNSdlBa?=
 =?utf-8?B?dVA5R1dIOVdoYU1HcTZNOTNxTk5McEZVTW1PbXgxbXMrSWJYYjg3Y1kzWklD?=
 =?utf-8?B?WlRQNk1hUGEzQnN1NGdHdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0RQV2FvU1JPTEoyRk1iNlFleWVQak1aazAwRUg5eXN0VXYwYjR5c3NjOU9j?=
 =?utf-8?B?RkVMdkhaT0xDNkdwS3BldC9zZHVkdTJXUTJwWW5xTENxbzM3Wko3SzBYSENk?=
 =?utf-8?B?Zk9CRUF2TktOVWxqL1Z5NlZnVzZyRzFQRjVJZUtqbDNCTUpVL0NMMk1uTnRn?=
 =?utf-8?B?OHU5elJhaDRqRTB3QzBXRTVMSXJWczV4RkRtU3FXSjdTalZRZnlTeGN6YXFF?=
 =?utf-8?B?UE1TTVdQQUo2N3VzZHVCc3p4dEp0d0tJV2VOK2JjWkx3RVBoUG1WK2VMTytC?=
 =?utf-8?B?TWJDVlhTT1dDS2wrVERhRWZDTDZsVlh2dWNCZTVZZ3N2R3Y2aDhoc0ladDZX?=
 =?utf-8?B?dCs1L0pTUksza0tHTW16bzdsVXRSWnM5dG1jNXQ5WXk2akh4ZVFDRVBialBl?=
 =?utf-8?B?R0tqRjUzalFud2xsS1kzTldWbWpUT0FTYjNIc2xiejVhVlZNUWFsT2Q3Zkt0?=
 =?utf-8?B?VnRheU5zTm9zd055OEVlc0FxWmRtYi95ZUxMTVp5QmlMaEV5cVhCc0t3clda?=
 =?utf-8?B?UjVaU1phcU5KUzZLUnkxMncvZXVScEpzTVoyTGFqNWw3MmFsRnpWUUFJckNu?=
 =?utf-8?B?WlpuMEpxWGFLOHJ3aW15MDhZaVNyVHRxQUp0aXV4NXJMRHVBck9tY1l1OGZ2?=
 =?utf-8?B?LzJEajlGRGlpODd4bnV5c0FuNmhRK0x6YlJQc29HN2QwZHZrNkh5b1ZINEY1?=
 =?utf-8?B?NktVdjA3UnJuVFN6Z3RLVlMvTEJzcUlNTk5NQmJwUFE3SGhaR0VDQnpTVUdt?=
 =?utf-8?B?eEczRzFsdSt5OWhnSDQzZGRrdVhqWDFhWUhCWHI2VERqWW1qcDZZL3F3V3Qz?=
 =?utf-8?B?ekRyZ1ZOc0FCQWFaVTNIa1ViM0YyZzJsNXY3MlFaTmxKQUFQcDJHV0NuNUdW?=
 =?utf-8?B?Z0FtZnVEVC9pZGJBZjhsWFVid0o1cCs2aVVraVBpd3kyKzJXMHp0a245VEVR?=
 =?utf-8?B?R0tGeHJoeFJ3M2FyZE9UWFcwdGszMkRwenEwZ2ZjeFAvM1I0V0YzTnVzc1cr?=
 =?utf-8?B?Nk9XaHk3Tm80ZHBZUFRhb1gxYWw3US9uaEViUG5UR1p4UzNDWHlMcWczTlcz?=
 =?utf-8?B?Sm4yaVJYZ05MWHJNcGFKUlBmK3dRV2UzUDNZZGZvUHltSHgyWGp0cXZBMVVO?=
 =?utf-8?B?WkhxWGM1NmhXbEI2QXF1cUc0M3FWeWZGQlJnTWZwZ1dLeGN3dTdWVXFjWmRQ?=
 =?utf-8?B?SmlqS245Nk9GblI1Z1p1WnFJLzlUaHBwQ2JPblNENFVBZnU0WGxUcFlLSFJn?=
 =?utf-8?B?a1FGK1oxUFJkN2R3cHlnS1daTCs5dXQyVVRVQ2sxa2dFcDgxdGJHRFlkMUVk?=
 =?utf-8?B?byt3M0NZbUgydzJuUWJTS25uR0xxZ2syY3NEdXZJdUMvcWQyZ01nNzFRby9o?=
 =?utf-8?B?M0RKV29OdG9nYUl0am9LTXhKQTlMMzZxQUJQUWZqZXA0MTlJYlowOVFqRGlG?=
 =?utf-8?B?cXliN050M0dmYlBhRGU3T1RMMDVsbGROYW1RL0I1ejRDSVB4eVBaWHRuL25t?=
 =?utf-8?B?Uk8vWXhmbE9nZEFoemdsMFRuNGd0Y0FqOUdpK2o0Q0JyRU9FekVmSkwyT3Jt?=
 =?utf-8?B?MFN2OXZ3N0pGbUxtVElseUFwN2hBemVCaEx0MzZ5Q2l1ZDhmZ0d2eUQzaDlI?=
 =?utf-8?B?ckVITTdvOFN2MGo0N2g0Y2EwZ25OUkdQbk90T3VlaUl6QzNjbnNIcHNOYzBm?=
 =?utf-8?B?dGlWZ3lOem1wTkpUc1doczkydUkwQWc1VWY4Slg3TDRZa0pDVWp6TUswc0tY?=
 =?utf-8?B?aDFkcGZrTU54YURJYmVKaGJheEl6Q2JObXpuQXBKV0RwNmM5Qk9LRTVvL2lt?=
 =?utf-8?B?TjR5dmZDRXQrVE5ja0o0Q2tncWZCK25kbk1VODFVcG5zTmZrMllxWjZiN0Fl?=
 =?utf-8?B?ZnhBQXJpM3RqLzFITkRiVzVHY1AzM2NNL08raEVzSlFic3g3K2NhMmNGck1I?=
 =?utf-8?B?RkFPeENEVitaRzRjdTBvSWJWUXFQakNNcHFGUytaVWROckhjZXhMTFZ5c29w?=
 =?utf-8?B?MzRBM3JNM1BsSVJ5ZTdSVE02bXppTi9oZFpUOUdPODRzRWtzUmRIZmkzcDdl?=
 =?utf-8?B?cXA5RWZaNU0rWFFWTERPbXZCWGMvOXFkeUhLcnp4bmxLL1M5T0NDclZnT0FB?=
 =?utf-8?B?V3BiUGRJY3RES0NqQjM4L3BramdwVXhuWG5Bd1FWTkl2Wlp0YmYwaWxHcXRr?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E17C1511A92084F968D92567D3A7566@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca76a03-d1c2-4775-caa5-08dc65bb75ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 06:38:19.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj6+1vmJy/Iycq7rDujoYD3EUM+jhPmLxAT/gkSuTTl1BKPsflpw2RBCftU1i5UxhaesUnTTOzW8rV5D4iHAZDtSLdHXUFe6SiIYj3TC+0G4+GK/Y8yNKTpu+RMRNDal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7650

SGkgQW5kcmV3LA0KDQpPbiAyNC8wNC8yNCA0OjU2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgb2Ff
dGM2X3JlYWRfc3RhdHVzMChzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+PiArew0KPj4gKyAgICAgdTMy
IHJlZ3ZhbDsNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICByZXQgPSBvYV90YzZf
cmVhZF9yZWdpc3Rlcih0YzYsIE9BX1RDNl9SRUdfU1RBVFVTMCwgJnJlZ3ZhbCk7DQo+PiArICAg
ICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IElmIHRoZXJlIGlz
IGFuIGVycm9yLCB5b3VyIHRocm93IHRoZSBlcnJvciBjb2RlIGF3YXk/DQo+IA0KPiBJdCBpcyBh
IGJpdCBtZXNzeSwgc2luY2UgeW91IGFyZSB1c2luZyB0aGlzIGluc2lkZQ0KPiByZWFkeF9wb2xs
X3RpbWVvdXQoKS4gSSB3b3VsZCBwcm9iYWJseSBkbyBhIG5ldGRldl93YXJuKCkgb3Igc2ltaWxh
ciwNCj4gc2luY2UgaXQgc2hvdWxkIG5vdCBoYXBwZW4sIGFuZCB0aGVuIHJldHVybiAwPyBJIF90
aGlua18gdGhpcyBpcw0KPiBwcm9iYWJseSB0aGUgZmlyc3QgYnVzIHRyYW5zYWN0aW9uIHdlIGRv
LCBzbyBpZiBpdCBmYWlscywga25vd2luZyB0aGUNCj4gZXJyb3IgY29kZSB3aWxsIGhlbHAgZmln
dXJpbmcgb3V0IHdoYXQgaXMgd3Jvbmcgd2l0aCB0aGUgU1BJIGJ1cw0KPiBjb25maWd1cmF0aW9u
Lg0KT0ssIEkgd2lsbCBhZGQgdGhlIGJlbG93IHByaW50IGJlZm9yZSAicmV0dXJuIDA7IiBpbiB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpkZXZfZXJyKCZ0YzYtPnNwaS0+ZGV2LCAiU1RBVFVTMCByZWdp
c3RlciByZWFkIGZhaWxlZDogJWRcbiIsIHJldCk7DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJh
biBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCj4gDQoNCg==

