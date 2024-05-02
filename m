Return-Path: <linux-kernel+bounces-166286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BFF8B9890
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE41B238B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991435B5D6;
	Thu,  2 May 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LBo35IVN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A+q1cnPa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598E57314;
	Thu,  2 May 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644620; cv=fail; b=cM3itWcYSpyWriC90CoYbqgzZiXRfAuKdlwzHUDYTqljcXaza9WcSs7A9OsckX6gt8koX49WxgyQOj6u6xAPwxhf567i67/KH1qlpHS5vUICDGHvxRyZDTempI4uE5yrMcarZHJOVW+4lnG5nk8+Y6TtAMb2c/sFIfUqFrI1mPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644620; c=relaxed/simple;
	bh=uTnfDK94eIi6d+YGpesPdoNmVvMf+ZxAwnLWu8it+Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hca+0rb08H/wn2A4N9tuz09Hlv+xXghyaKjnnCy7b+Q7AVtIqeEwZaBu5hUYmp1CDSn5mPrGliOsXuAJ4ttUwABts6A342Y44lNV4eyi19P5dl0IVQol6O2yPhlzHQpRrqYn2UCyb+bE4EKqxhEqb+KF2dNh5kOxpmc/e/Tu7H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LBo35IVN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A+q1cnPa; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714644618; x=1746180618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uTnfDK94eIi6d+YGpesPdoNmVvMf+ZxAwnLWu8it+Ss=;
  b=LBo35IVN7gqOiKfFFpdcQjUI5nt3e+HTeMjtx+Yc4EW/3kmvLPTFxE6m
   eLrkbcaX5GFEzauiP6qrKY4LPCmxcnn0N7hAeGA2GZMec5sMMBcDaMtOQ
   4AQsadc/o+m9PG4uDXLDCt7qDiSh0BcP4JYMGIFBH3x2q6Nj3YCOkuZyG
   WzP9lNkV7Uu5qjm3Gt+PZMo2//5H/oUebUJ8Jincqfjw3RlbO9i355DPm
   FNr+LMuOvkWe1DRy2fkQoU+sSVFhRVivfo0o/bDdbTG7ffAjauVXYrnJ7
   Sa318bNwihKjgYu+k2Ytt9DsLMbQmNJQ8LmhrdFmRjDxBYEIft9tBvdMt
   w==;
X-CSE-ConnectionGUID: 9xPnPBQ2ScyXZapFGKGEBg==
X-CSE-MsgGUID: jCVEZGt+SjqJ8rDL4qnAXw==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23353059"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 03:10:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 03:10:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 03:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kul2XeOxMLUQu80RD0VPuYM97dZOeR7AwGlXdJHi6sYfWOGmo5aa4CaXyvBxovPf5k1ntEaJCpxMm15O3PTkk2bRLlYNap2UJoPlXBh7RL/KycRD/aKBuwxnNG4C2cQyj3GCNXzzmcDgaEtXplWejr4wX9lB4lfFOb2kQzXdj2rnwZUacSYyP9iYlPObw+4z3WDUiQV44baRWmlg5eCzGe2qxVdfxN35dcA85LymQpxH+fivxixK1+66FTJ2tyG9mMVMjEKf/fi4Xs3aXW4pMeOFACFVY4YDNR0GZ+tO4Zbzi7UCx7iCoinkA72Z0tkw9Ig6ipkOhxPWQCP+JrKKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTnfDK94eIi6d+YGpesPdoNmVvMf+ZxAwnLWu8it+Ss=;
 b=hAQFZM/2J4dWnRXfDgwEbqB4jSfDA05zOEzXwSOxbfkMdIJ4sg9hxoGxQD+5XwAJ1rFzM/oOljyQ91SQkPbB7gmdDhqUGJVT1Qgsm5Xb1Dh6wJOOmpMe6y239jvm1u3S33RpduD9Idg+b0htVMcg6SKcCoCMSdbzFJyL3SHu2SFnm43jGaGTgtc4XR3odV42eZjyGRZS77EKXyumVa8GuXJQLJwjH3OWrFVNCbVh3Epg/m6+u08iKgrHGmMIeYPJVAWgyDCc2ePml2KASzuDadXo+Ou+k4JrMbtmQyanqV7yCLJODmkBU+sq5P8yZ2iWmqj46W8bJH1UBPpcdMds8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnfDK94eIi6d+YGpesPdoNmVvMf+ZxAwnLWu8it+Ss=;
 b=A+q1cnPa1SDNbfJI6zq1nPIiduCAsdhG3UpW9rBFR+yJnZ0Idwp4nX+eI3Qn6lEhP6sho5aHfd7Sq/BSCBbKD06Z3Ygkm621hSCty1m5RzATspOsCoupZhVdVVq7mlYFDsSroRoQLx30eVTYRP3DNJ7EmQQ5EUXj3JKVAZoX4RShcOl+pHEdYThfl8xdfqDJMSPwK4jpDcqezn0+XFTWrZpeLUjGgCVeUeYIkf3zu+zljAxBzaMxLAQAyAGX6QE5LCCxo7fdD5xiZ8LgG0PCO+P63Ii3NZjbWjtDcyYWhZ3/7dNaIzp8efk5BfQToBrphRkFIwzgh9V0wTB+neJhHA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM6PR11MB4595.namprd11.prod.outlook.com (2603:10b6:5:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:10:09 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 10:10:09 +0000
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
	<benjamin.bigler@bernformulastudent.ch>, <ramon.nordin.rodriguez@ferroamp.se>
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Topic: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Thread-Index: AQHambFe+IoUXQDhSE2fgqcXND6Bv7F+xDiAgABLB4CAABxbAIABpiQAgAAMLYCAAuCeAA==
Date: Thu, 2 May 2024 10:10:09 +0000
Message-ID: <f6dc7638-fcba-4c08-b1b3-43091005b74c@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
 <Zi94jdVg8a5MaB3E@builder> <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
 <a3719443-153b-49d5-b039-fa0a7928de28@microchip.com>
 <a7c43359-5d5a-47a9-a9b5-819e164457d4@lunn.ch>
In-Reply-To: <a7c43359-5d5a-47a9-a9b5-819e164457d4@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM6PR11MB4595:EE_
x-ms-office365-filtering-correlation-id: 49421250-31bd-4393-40f5-08dc6a900c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z2h2Q1FidzZROVlWSVJlb2RRZGlVVWd4VnZtNzFsaTJkRkovZ1BMMEVVTDBz?=
 =?utf-8?B?cUVWY2lHakkvM3cvWUhzcEs4UjdWWEVqWkVIRm1IcUpISVBvRkd4Y2RteUI0?=
 =?utf-8?B?ejlzbmtqRE5SUVN6MHV5UGZ6d0RZYXRNdk1WQVpSNDBEOFBpZ0dKWjZDRDJt?=
 =?utf-8?B?QldyNWd0ZFlkWldJbGhUU1JSVjVCVDBoQ2FhME1acmdWTlJZSG9tOWlvTXVI?=
 =?utf-8?B?SFNXdFFrVVJpbFFhbkJtaStPVmxlQ3pTZzNkbGZ6MXh5OUlpdUlHM2FldlJ3?=
 =?utf-8?B?V2lmN0lNNFZaSDNmZS96REl1bURUYWZheTFvN1IxanBuM2lwT1FlUHY1OG5j?=
 =?utf-8?B?Rm9YWWF5TU5kVXpKcVA0REVseVlGekZXMkc4Kzh0dGhScVJKbHJrNUtvTnNG?=
 =?utf-8?B?U0F3RG15cUNaQ083SzB4RGhISTByMG5rQXJDSDRCc1dzNjMwVXd5UDdxQ3JF?=
 =?utf-8?B?VE5kQlM2QXY5UitYamNXekphL05KWEgxa2FNbDZBeWZ3R0pVTUZNRlNYcXd3?=
 =?utf-8?B?SEF4UFN1RDdKV0JkYkRqU0V5SkpzK2JXN2pmWHVFTC8rbDhUSnowOFRzdkxZ?=
 =?utf-8?B?c2JhZjlwaGZhTVJmVDhKNFhnQU9tdkE0VU1UTUpUK1Z3WFJVb3lBZ1FzMjRI?=
 =?utf-8?B?WHVTV0twTVNoWjNZWlgxUm9vOVFDdkVNSnVOQjhMY1JVR1VqTTdGWXhzRlJ3?=
 =?utf-8?B?MkJkNnNGOTEvRVdERzJFL0owMVM3RmZuWVQyblRVbzlvZ3BBQlVFdXE3V0Vm?=
 =?utf-8?B?aG9EUGFEaFpqc1UxSmFpS2s5dllOL0dCYTVBTjNDT3NVNkMrdUZkTE10RXVm?=
 =?utf-8?B?WGZEU2Q4a3RrM0E4Rml6WmNyNmZLUFlXaFRNRzV2TXFabnAwZ1lncDdRbzFX?=
 =?utf-8?B?a1FtMS9hU3hzeW5zN0xUWGxTbXJDaVAzRFBGNGJmc0hsMjEzQ0s4a09oL2dk?=
 =?utf-8?B?dmV0dnpkaWxxakRvTkRzeHZmNzYzYnJWMmllNE4zWWJOaW80dGlBS1NwNFJY?=
 =?utf-8?B?Smd3Tms1NmNjQndEMDVBZEdTWE9yZEYrZWJVT2gzcUd2WFF4OFQxbU4yaWp4?=
 =?utf-8?B?V3NTRzNzNUFlbmtRaGRWazJpcjBXWC9ESUxCN2NzZFhNTG1EVmVKMmRyc2Z0?=
 =?utf-8?B?WW02QVYva1lxdFZNaUVVRmxwWXcvbW5CbG8yN09BNXBYcFlHOGMrVjFnZmk0?=
 =?utf-8?B?TkpiK0JKNTlYOTFaZy9ENXVud0h3M3p1MHdCSWhMY3ZHeGZlc0tzdW5QNWly?=
 =?utf-8?B?RXliOG9IN2RrRlBsNzc3K0NmdndXVGlGZzhKNi9hemN6dXpSd3dIQmxNbERT?=
 =?utf-8?B?MlY0WDc2OGJ1YUpGd3BtVkxXU2x1UnBhYnU0bk1OTHBqbjArUUx1ZkxIUUFx?=
 =?utf-8?B?MVRnbEdQWUN1QmFIWHRuTEliMTU3YjJSUUpTSFg1RVo5NXltcVFkOUdDc2sy?=
 =?utf-8?B?S2VjNTdCYVRCSGp6b00zN1hnc3BlSjRKV2VkVXR6TjZhR2UrWTFjMFIwSmVj?=
 =?utf-8?B?NUxDTnNHWmJGeFRWcnRMc2plRjR5a1hhMWE4RzZtV21zb2NJRnNscnpiNUtv?=
 =?utf-8?B?TUQvYVg1WUlyMXdHMlVYdis3SVpFVFZPVUZMMUptMVgzV2NBUlFGeWRnak9i?=
 =?utf-8?B?NExsYkZCcGk0TXdjQUpFQ2tUMmoydDRQbHZ4dHZMYXZ0UVRFSjRlaFVWVWJJ?=
 =?utf-8?B?akN3RTNDaUxIQ1loTDZnYlgwdnhkOC9NZysvdmpDeXh1T3ZvRE56WlJHSnVp?=
 =?utf-8?B?dUdaaGtla1diOFhoTWIrWTdJbWFPdzZOTjFBeWVkRGJYRXh0M2xTeVlKYWJr?=
 =?utf-8?B?UDFWWlpiWmlNZmFwVFczdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJDbjhCVmdhRTdIS1pPVmNtRHlRblB4bkhJeG1XZmxrcEM1a0FGVEw2ZUJP?=
 =?utf-8?B?eXdOZ3VOZmlWR0pwRGF6RW8vQjU2VGF5bnJ0bjFrNEZKT1VRazEzazBQcDA5?=
 =?utf-8?B?cUdZMG9sVER0T1VEVW1sS01Bc0U0ZHRSbURFS2hyUGt6R2YzczRHUi8xYWFX?=
 =?utf-8?B?SnVxOGg5RUVkdlc4NE9vRmMvTDFBWDJHQTlleW5DYW1WMVZUZVZ5RWNDRWRY?=
 =?utf-8?B?Z2ZiS3l3Sm1TckUza0FEMmw4SytyQmZvdkNRTFhNR3ZHRzFHRi9BVFhIL1c4?=
 =?utf-8?B?N0JFTVdLVk1MUjFHUkZYak4wRW1BcDNWb0wzbnE0ZysvRHlCT0JxbXd3eUVq?=
 =?utf-8?B?N2hIeG4yU3k1V0FDeTA3TitwUnZlNHhHbGlZTmNiZkx5ckhCY0NDQUhTRjBR?=
 =?utf-8?B?b1VnZG5HZmdLTlNzN1NsMnczc0xCZ2hoRzRsL2RNVmZaMmtsMkNST1ZhZVR2?=
 =?utf-8?B?Z1pjNUV4Y2VnR2xRallkQUhJY1hBNHhQeFh5WGpNNzBrNDljSmdPb2JkUjhY?=
 =?utf-8?B?bS9SUS9kWWloaGYwZzZvOFVINTIwYURQcDdTdXd0bXAxNkFmb2laK3FPaUx6?=
 =?utf-8?B?d3lmRCtjQWkyWmZnMW8yb2E2am43UVhucTRWRlNFSUJFMWVLeWNYOFJSYmFJ?=
 =?utf-8?B?dTJ3bFgzR1FmZnVOZ3ZEbnF0ZDhXQlBwSkw1OU5KM204YVg2RjNua2JZcEZk?=
 =?utf-8?B?ckwwTm15d3ZlWjI5ZnAzRUp6anE1WlhaNU9paXhOYzZGdzdQNCtrbFhvZCtq?=
 =?utf-8?B?dlhEd1ZnY0UrY3FkUnZlQjBtdWd6UytNelM0dU9DSVE5ajhUNDRETWVRUXY4?=
 =?utf-8?B?bVoyekx5dHdUci82Z0dkME5jbE02eFJnVkVpbVN5ZnlTYjYxc2pYN1NTRW1m?=
 =?utf-8?B?RXc5cXJvL0l0dkZLUlEzV3dXKzJ0cnBGenZqTmxnN01DQ2FPa25Xc21xWUov?=
 =?utf-8?B?YTRVSFduYXB4VFFsVHRnZ20yaWhMdXREU0MraUtwOHgxZmlLS1hUeGg4aXND?=
 =?utf-8?B?RHZKZ0plajhIY0ZGTkpmV1BFNHdsUWdiM2pnYUhuRHhjMHJUSEk1Vk1XT1JG?=
 =?utf-8?B?Q1JJM0srQnBOTi83eC9aYzBPVkVuUnFHS1g4alRzUWdmZlZib3ZMN2dvUkk0?=
 =?utf-8?B?VURxSTNCR2p1QytkU1RKL0FmNnd1akRHL05RRk4rL2M1MFk4ZHFwazVQdlpj?=
 =?utf-8?B?QmloNW8ySDZOc3ArTUtJQjBMVXFkNnpWcWdnZ1pncUZOSThkOG1qRXM0Qnlp?=
 =?utf-8?B?alBpUitiaWRSTHBMTWJmNDczNEhGcXNuSlhBRjBZN2E3dlJqaXN0aVN2cE42?=
 =?utf-8?B?YmtRT2ZzQkZIYmNuQzltbXUrRHZMdG5TSDJrbkFPd3REQmRBck1zSkZSWHF3?=
 =?utf-8?B?amYzcks1N3UwVVRMRUNGVExXVS9BRVhPVjdYVlVrZ0JIL0lMVGE0dnFYRSs1?=
 =?utf-8?B?VWhubW1yV0d0QXA4VTF2UEdlZjZJVldObzhrVmhuaGFYS0tpeFdrb3R1bVZD?=
 =?utf-8?B?Y283djlzKzM3VXNsZktMcFY4dk9JZkMrT0pqWjR3SU1nRjhiS1NLeWlXbGtD?=
 =?utf-8?B?R01xMXZDUXBKOXJBdlowb2JLaTZEaUVCZHlkcTRaYWV4Qmc5TnpNZThING5u?=
 =?utf-8?B?ZG40aDlLZzdCSExYb3ZqWlNkTXhiOHZBajBkT3ZiWFR2dWZLa2JDMzcvMllM?=
 =?utf-8?B?N1JrQllTSzg3OGlLTzdCeDVvamM5ZHBMYXdTUGRNdjRQeDR2S3VFVTFnSXE0?=
 =?utf-8?B?SHBJK3ZIZlI3OEVOK2dSWDUxd2hKaUVwRDFQQ0hCT0NLKythN3FtODkrcHVG?=
 =?utf-8?B?SWNTcTAwaHFUMXRBcHE1Z084cndqVmhzS3d5K2dWUkpoRzQ5SFJZSkhrRU50?=
 =?utf-8?B?bE96YWxxVVV4ZlNSakwzODJCc2ZOWHhyQkhRWTRIQ0RwT1U0ZTVWZ3lxeUZk?=
 =?utf-8?B?M3FJQXYwSFlqVzlhS0ZYdlF3RlpXK0N6cmo5NEVTaWp6Qk8vUnB5bGFPNkNK?=
 =?utf-8?B?TTVYZ1Y1WFF1MERtTWtZYmZHK2N6ZHJObW5LbU9LSUIrQ0pyb1hycjFldncv?=
 =?utf-8?B?ZmpXWmdNaE5CSW1mV1cvL1NZZXVxbnRLTS8valMrVlBGNXJybGZ6NVpEekVT?=
 =?utf-8?B?YkZuRVEzd3BiOHZrK3AyOFJlVmJVMDROVGROK2ExZVluKzh4UVhpN1JKRkRD?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F51683B0402624D984CECF210D657CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49421250-31bd-4393-40f5-08dc6a900c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 10:10:09.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0uSBYlCL2pQ2TfJ1mNuPpJOKSptGRrXWKsEU6Lec4W6cNMSIpONBWJsoQoRCnG0eKUXyKGiQnwdQdd8I4CUfj7gJMDEidgvqjEjvlxyiNNDkp4Zg1oglu+ngkFW962+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4595

SGkgQW5kcmV3LA0KDQpPbiAzMC8wNC8yNCA3OjQ0IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gSW4gdGhlIHNwZWMsIGV4
dGVybmFsIFJFU0VUIHBpbiBpcyBtZW50aW9uZWQgYXMgImlmIGltcGxlbWVudGVkIiwgaW4gbXkN
Cj4+IHVuZGVyc3RhbmRpbmcgaXQgaXMgTUFDLVBIWSB2ZW5kb3JzIGNob2ljZSBvZiBpbXBsZW1l
bnRpbmcgaXQgd2hlcmUNCj4+IE1pY3JvY2hpcCBpcyBpbXBsZW1lbnRlZCBpdC4gVXNpbmcgdGhp
cyByZXNldCwgY2FuIGJlIGEgYXBwbGljYXRpb24NCj4+IHJlcXVpcmVtZW50L2RlY2lzaW9uLiBJ
dCBjYW4gYmUgY29udHJvbGxlZCBmcm9tIGFuIGV4dGVybmFsIGFwcGxpY2F0aW9uDQo+PiB3aGVy
ZSBpdCBpcyBub3QgbmVlZGVkIFNQSSB0byBvcGVyYXRlLg0KPiANCj4gU2luY2UgaXQgaXMgb3B0
aW9uYWwsIGNvbnRyb2xsaW5nIHRoZSByZXNldCBwaW4gaXMgY2xlYXJseSBub3QNCj4gc29tZXRo
aW5nIGZvciB0aGUgVEM2IGNvcmUuDQo+IA0KPiBIb3dldmVyLCBpIGRvdWJ0IGhhdmluZyBhbiBl
eHRlcm5hbCBhcHBsaWNhdGlvbiBjb250cm9sbGluZyB0aGUgcmVzZXQNCj4gaXMgYSBnb29kIGlk
ZWEuIFlvdSBkb24ndCB3YW50IHRvIHJlc2V0IGR1cmluZyBvcGVyYXRpb24uIFNvIHRvIG1lLA0K
PiB0aGlzIHJlc2V0IHNob3VsZCBiZSBjb250cm9sbGVkIGJ5IHRoZSBkcml2ZXIuIEkgdGVuZCB0
byBhZ3JlZSwgdGhhdA0KPiBhY3R1YWxseSBwZXJmb3JtaW5nIGEgcmVzZXQgaXMgb3B0aW9uYWws
IGJ1dCBpIHdvdWxkIGV4cGVjdCB0aGUgZHJpdmVyDQo+IHRvIGVuc3VyZSB0aGUgZGV2aWNlIGlz
IHRha2VuIG91dCBvZiByZXNldCBkdXJpbmcgcHJvYmUsIGlmIHRoZSBwb3dlcg0KPiBvbiBkZWZh
dWx0IG9mIHRoZSBib2FyZCBpcyB0byBob2xkIGl0IGluIHJlc2V0Lg0KUE9SIC0gUG93ZXIgT04g
UmVzZXQuDQoNCklmIEkgdW5kZXJzdGFuZCB5b3UgY29ycmVjdGx5LCB3ZSBuZWVkIHRvIGVuc3Vy
ZSB0aGF0IHdoZXRoZXIgdGhlIA0KTUFDLVBIWSBpcyBvdXQgb2YgUE9SIGJlZm9yZSBkb2luZyBh
bnkgU1BJIG9wZXJhdGlvbiByaWdodD8gc28geW91IA0KZXhwZWN0IG9hX3RjNl9zd19yZXNldF9t
YWNwaHkoKSBhbHNvIG1heSBmYWlsIGFzIHRoZSBTV1JFU0VUIGJpdCB3cml0ZSANCm1heSBmYWls
IGlmIHRoZSBkZXZpY2UgaXMgc3RpbGwgaW4gUE9SLg0KDQpCYXNpY2FsbHkgb2FfdGM2X3N3X3Jl
c2V0X21hY3BoeSgpIGRvZXMgdGhlIGZvbGxvd2luZywNCiAgLSBXcml0ZXMgMSB0byBTV1JFU0VU
IGJpdCBpbiB0aGUgUmVzZXQgQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVyIHRvIA0KdHJpZ2dl
ciBzb2Z0d2FyZSByZXNldC4NCiAgLSBQb2xscyBmb3Igc29mdHdhcmUgcmVzZXQgY29tcGxldGUg
Zm9yIGV2ZXJ5IDFtcyB1bnRpbCAxcyB0aW1lb3V0Lg0KICAtIENsZWFycyByZXNldCBzdGF0dXMg
Y29tcGxldGUgc3RhdHVzLg0KDQpDYW4gd2UgcmVuYW1lIHRoZSBmdW5jdGlvbiBsaWtlIG9hX3Rj
Nl9jaGVja19wb3dlcl9vbl9yZXNldF9jb21wbGV0ZSgpDQphbmQgdGhlIGRlZmluaXRpb24gbGlr
ZSBiZWxvdz8NCiAgLSBQb2xsIGZvciBzb2Z0d2FyZSByZXNldCBjb21wbGV0ZSBmb3IgZXZlcnkg
MW1zIHVudGlsIDFzIHRpbWVvdXQuIFRoZSANCnJldHVybiB2YWx1ZSBvZiBvYV90YzZfcmVhZF9y
ZWdpc3RlcigpIG1heSBub3QgYmUgbmVlZGVkIHRvIGNoZWNrIGZvciANCmVycm9yIGFzIGl0IG1p
Z2h0IGZhaWwgaWYgdGhlIFBPUiBpcyB0YWtpbmcgcGxhY2UgcmlnaHQ/DQogIC0gQ2xlYXIgcmVz
ZXQgY29tcGxldGUgc3RhdHVzLg0KDQpCdXQgdGhpcyBjYXNlIHdpbGwgd29yayBmaW5lIHdpdGgg
aW5pdGlhbCBwb3dlciBPTiBidXQgYWZ0ZXIgdGhhdCBpZiB3ZSANCmFyZSBvbmx5IHJlbG9hZGlu
ZyB0aGUgZHJpdmVyIGZvciBuZXh0IHRpbWUgd2l0aG91dCBwb3dlcmluZyBPRkYgYW5kIE9OIA0K
dGhlbiBpdCB3aWxsIGZhaWwuDQoNCkkgYW0ganVzdCB0aGlua2luZyBmcm9tIFRDNiBmcmFtZXdv
cmsgcG9pbnQgb2Ygdmlldy4gQ29udHJvbGxpbmcgZnJvbSANCmV4dCByZXNldCBwaW4gd2lsbCBu
b3QgYmUgYW4gb3B0aW9uIGFzIGl0IGlzIG1lbnRpb25lZCBsaWtlIGFuIG9wdGlvbmFsIA0KaW1w
bGVtZW50YXRpb24gaW4gdGhlIE9QRU4gQWxsaWFuY2UuIFNvIHNvbWUgTUFDLVBIWSB2ZW5kb3Jz
IG1pZ2h0IG5vdCANCmltcGxlbWVudCB0aGlzLg0KDQpKdXN0IGFuIG9wZW4gcXVlc3Rpb24sIGFm
dGVyIHBvd2VyaW5nIE9OIHRoZSBMaW51eCBzeXN0ZW0sIHRoZXJlIGFyZSANCmRpZmZlcmVudCBz
dGFnZXMgYXJlIGludm9sdmVkIGluIHRoZSBib290aW5nIHNlcXVlbmNlIG9mIGEgc3lzdGVtIGJl
Zm9yZSANCmtlcm5lbCBkcml2ZXIgbG9hZHMuIEEgZGV2aWNlIGxpa2UgTUFDLVBIWSB3aGljaCB0
YWtlcyBoYXJkbHkgYXJvdW5kIDUgDQp0byAxMHVzIHdpbGwgY29tcGxldGUgdGhlIFBPUiBiZWZv
cmUgdGhhdD8gT1IgaXMgbXkgdW5kZXJzdGFuZGluZyBoZXJlIA0KaXMgd3Jvbmc/DQoNCkJlc3Qg
cmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgQW5kcmV3DQoNCg==

