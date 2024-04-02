Return-Path: <linux-kernel+bounces-128294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B98958EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502561F23D04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C213329D;
	Tue,  2 Apr 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqw67oQz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F41E480;
	Tue,  2 Apr 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073259; cv=fail; b=iN+D8VoTgYZJrzjcPMAzeK0nqlDoCt2lGNM2/kccC8rXMtq4/k6IL9W4LESDoCevsS34kmzi6NQzu8CuIF4wxIqPP4rqE8aWL+9z5Y1tenQe6SZ2UVxSAX94VcxWf1E1ifEyw2MlYobzDqCs2mmxig9bCrrJcTbwpOXgD2I+FEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073259; c=relaxed/simple;
	bh=tGCdCYhi/u8XxvW2tTUkiRRD0diwBTjXv9WuKrbLiF8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRYnnfY6n6otpMG3t7KP1EEXmG3UJGo/TSnNzV5A/XpcXHAnXXKr0DGcK1HPvhJB+LDEzk1kTJiaDMNDrE9l5noE1i2GyvETZkXVD59NTYLHUKvjp2sM17BOmsmpFQ20pTWy2lvOgQ+NqU1PYzNhclc62wt9tXanMnWD+aef0f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqw67oQz; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712073258; x=1743609258;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tGCdCYhi/u8XxvW2tTUkiRRD0diwBTjXv9WuKrbLiF8=;
  b=fqw67oQzobsi1scC9hHCwT+N/aHa5pdXqgSx+18mTnDunECF6HI2RvZ3
   ElQUie5tpRSQ+D9+On5LeiZB9B4Wsat7MiJcAIerYzANvD9/u53uxIcPR
   HsQG3WenuTgUSrOSJxeK6jAPznC5NZLW168tkBRh3Xn2wpbUNBiS1FaXU
   CIl2NIJJq/Kkbaep1vmYBifmnHKJ4Ghdz3m1TBASYsd/nnvMgJbcN99yg
   4ZcTaJN/H/nPxF7B8qka7GdMsLfNWXSjOPYhXb1DwgUgGT2Sh+zy/UIM+
   JY1RGqIyLCN3DK1DVdIbUNrsLpWnLFuAOgmRDgecUBeh/ZtCb5UHEOo9y
   w==;
X-CSE-ConnectionGUID: 7AXgMrMMRW2qk8AlS8jTCw==
X-CSE-MsgGUID: sLHbOVU8SdWYjv2yk9ac3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7097296"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7097296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:54:17 -0700
X-CSE-ConnectionGUID: Qg42fcO2TYCAw2HOF+slEg==
X-CSE-MsgGUID: biOIZtziT1W2zJB7XQjlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17928704"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 08:54:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:54:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:54:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:54:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 08:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGHPtqoN+ACEDAfPDXVa83G3C9K2/vJbXTqjbAF5qrlPzTK3ugL95VradbYAiUhAtkIlCXY5qivrDK/1p3ilpXTnKT1m1trang2B96DtwP4kzfGOHU8N5YufkmIrKe/DOIpLhL9mbnbFqqPwyEQ5ZG02PJk/JplThvHoPBMck+0pqDY7mcMLYYtfc96jkigzxoBSbA64HIXverlXQIv6fRazPy9gOQ40iRpIBXDXJU44dxC8lzZn4ZbAV12P+8FHrsipQbnWRcchE7u/ZvSQHVInwLSobCCOskqqQfa0/jx8iQhkUD1uFjgmrvVVKPUPUZX/VP3LzabAXQQT/QaYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP4zZlybD0p82V2fyVMlrGyoplynbabtxyp/8zVg1aY=;
 b=dsoGLX4DhBfkVDShE+SZiMq2Jx66+9juKSBW2SjsiObR5uroRuSe8fkOS0jQ/KLkrzK7X18meiGxs9cxGM1rk+bJn2e7f6AXKkQJ/Ahr2Lw82W9QtLMyFupG/9BCkKMXYicHVOY9xXTPbRywvbsIVrBr1UXPYhMQ8V2GDu/usLEQgtAE6nr8gSD/x3id1eykBeL4bq7G9mbxCv349UlTZhwLRbfTaRTdcrdOgDln2eCr/mCbcB7SB79FFvDU41H3KjtGAO72ElUxL1qv/rNJIlGRwwUen6r63BE2VY+8Ahu/QOdW0lUAHDduRcjCT3ScjDn6T26qF5RhoalK5eGIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 15:54:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 15:54:12 +0000
Message-ID: <22021664-6630-4663-ac28-c0df4187d8b6@intel.com>
Date: Tue, 2 Apr 2024 17:53:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse shadow
 warnings throughout the file
To: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
 <20240329170000.3241460-3-aleksander.lobakin@intel.com>
 <20240329131857.730c6528@kernel.org> <20240329135344.1a310f31@kernel.org>
 <912d1f9f-a88d-4751-8d91-b82a75f82a32@intel.com>
 <CANn89iL+goDgitdic97+um6D-PZDw2xYf=2eYgnNYEYU-Nws0Q@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iL+goDgitdic97+um6D-PZDw2xYf=2eYgnNYEYU-Nws0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB6052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW4pqDphsom3l5tsVQPWZ8+FmEaeCmsbY4p19XnNxiPg33+d+S0vOTPlnHnxHUXzlS8iS/cHHRP0bs5TiKGZz7eePfHi+zeZLLcdVPrfoyV3CVYQKUYBDqbUO5zVK6+xk+bSdOuo/XBRgT5PKUxJmwZezlCeh6pEtgzK5BjZQ5AFOeU08mim1Ls23LEDv9oBlLNrkFhzX7xlwXsNUUgINW2CshFUKSqW6aQvkn5Ov8m2lIaxzmoYSH2PdOw7Xs2kzEx5na7/HaaC5IN5rMMICz5/ny/528KMYBdkMRBJQRGkL3/TMo/MADStsyFXIs8BQfMcvYNFPYyxXu4kUxOjJQ4cih5kggJvbBtZWlzZlSD7kg5Prg5dnf5dIS6atVVFL5usbk0l2pgsLke2a8diMRNaspaB1Od49UYTEKb5rrgy3u85J8CcXqZKbPC++tdch+5Y7KTGzH5DLlc2LRy4H4pCqKDFoT3pdKHiGGnyez8HnYV9wpnab84nGHj5hg8ad8/2J8JrYaGdfvjoMieZoMx6SZjhDDpeyvCb5vu7eqgq+kdAPsEBxrJ/8aLJ077GPTRsGYRKmYmUZecJuzidQFS9sQr363i2qjgIn4yeCR2CxMhFR21PjVZs29AvKtpSlsutn4Ec2Ro8YJ9lVZMIpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxuWkxwTXJpNHlBZDJzYThSUklMc0dPTVN3TDdxTThXbEt6RGc5a1FmOTRr?=
 =?utf-8?B?eEg1Y1BGUDQydjdGZS9ja01HUjVwKzN6MmgvVjg5OUJxNGptenJFRENYOWJG?=
 =?utf-8?B?cDBnMkJDUW1lQiszeUh3NEVjUEhrZEZUV1AvSGFlMlhOdTVWbyt5cEkvOTlS?=
 =?utf-8?B?a2grU1NTbE5mTlMzaGcxaW1vREVvMGRhMC9FRnUxc3lWQ0RLY3M1aG9IeUJO?=
 =?utf-8?B?YklKRGVmZUpGYVlDNHc0UVhUb3k1aEh3UEZJOUxPUThhV2N5L2VVOTdpOXRi?=
 =?utf-8?B?M1krS1I5OFh4NFNzam5jWUxTSll5a2hWa3ZYZVI1dVdzVGowWUJ6aHhaNnUv?=
 =?utf-8?B?N1Q3cm4xRGMzWjZqeWs0ZXFyR2ZaQ0JwdWZMTEJkRTZJYnlFN0pPYVZyOG1B?=
 =?utf-8?B?WGwyWlVSbysvMXZhdTVRYmZwNkZxamNDTjM2UWtzRjllUjdyYmN6NWRKamQ5?=
 =?utf-8?B?L3RrL1MwYk50RVVFSmx1elRFMHNQTlZiR29zTUJISko2bU1IdlJ5OUUyQ0F2?=
 =?utf-8?B?STFUaTZlajhHOURmUnBKWFpTaElDWkx1VWp1bjBwODhxay82WDR2RUNoMHBS?=
 =?utf-8?B?aVBuVVBiMnc0U09GU1NyQmltTVdRREdzbWRGNTlEdVRsaHIxTGdFQUlTOTQ1?=
 =?utf-8?B?QzBIZXdubWVSWTFqN21CcmxwZXdTQTBlY3dyQkdnL1BIZ0k3QysvZklMblBy?=
 =?utf-8?B?c3V2OTZQM2dNKzRmQ1I5dDNUb0RLZzhqb1J1bU9RbTRzbTNOZk85clBObmdj?=
 =?utf-8?B?MDdPcEpabVgra05Mc2Nvb0lkaldndTQyZXdqT3J2QTlHYTRRMTZLVjV6NjFa?=
 =?utf-8?B?eUViUjVsU2c0L28vQUVFbHJaQTQ1TlNnaVlkbEFwWFRiQld2UW0xRjg5R2Ry?=
 =?utf-8?B?T1pVamlkZnlRci8reUJIamVKOXEwUHQwaGFuTVZTQ1pta1dvRUZqM1ZPZ0xN?=
 =?utf-8?B?cVhJNk5KNXRWWWUrV3lhQnAyMnQxSDRqdWludDVoeWNNbEtSbkgwN0hacmlX?=
 =?utf-8?B?UHB0aVIzUFRLbUxyUk1CUjIzSFVyMG5pQ3Z0WFAzUWl6dVNtZmtGZkNZalMx?=
 =?utf-8?B?WFAreS9MZWNac3dBVWd4bDZMZXYrQkp3REw1SXJ5NE9xVWZKL0NsTUpyZHRS?=
 =?utf-8?B?NlJGdDZBYU10NndxUk9SNEREZ2dJYWlndTFheWNSbG0xREY2aDlUVDYzdDF6?=
 =?utf-8?B?N0dKZ3Q1TFZXZVZWbXhGYkxYY3NnTHhMNE5MTW41dE5NbVJKV0V6ZndpMHl6?=
 =?utf-8?B?Uk1mSFl0QmhFdTBtWDJoTE5WN1RFUVJnejl4b0Vnd1IzS0ZsMGlFQkh6Z0VP?=
 =?utf-8?B?VHhnUkhlbU81QVhtOUlsM3RmUzlpQnBvQ3hvUHNJemlleEVnVk5aeUtUK3NW?=
 =?utf-8?B?eHRvK0taNkpYMjFnYW9nUDhJUHMrUEZieG1oL25GNE9hUHd5NHJpN0QySlUy?=
 =?utf-8?B?cDl4dExJb0NFS2VPTkl3cXRkdkNDWTFtREs0SEt4Wmw2M1NGVS9CQXdYazNH?=
 =?utf-8?B?QmNwTHFrcUVaZUxBbWJnenZPc0VMZ1JWaWFBS1FRbCtJdkE1Y0JUd2NGV2I5?=
 =?utf-8?B?bC9QVmlsWWMrTzhmd3NsQ1FVUC9sOW9JNmhVOVp5S0d5L2ZGbm1WaU5hSHdD?=
 =?utf-8?B?bWdIN1cxRHZvek9sMWdGcTNZdFNVWCtiMmQreUVkaXUrUEVuZnUwcjFlVEda?=
 =?utf-8?B?bXlIZVNJRGR2UVZ0bmNGQW9VSjIwbU1VRnl2SDd1NkwydHFSc0lwQVlDOGho?=
 =?utf-8?B?d2NZOXJUVk0xakZzK2dqekFWdS9lelB4ZlhZTk1vSHNFcDNSamJzamtnazZ1?=
 =?utf-8?B?NVJ0UjNoelZSbUtTaEpKcFhHdkN1ckxZTUNQU3ZNL3FOWERPMlF5VHlCVEJ3?=
 =?utf-8?B?UzdOY2J5ak52alVGSzlhYUFUVnNPdDFsQ1hzSGJBbXVoTWJRczA2WnhxNmFz?=
 =?utf-8?B?NEhKdSs2cVZOMitNL1dzSDhRcVBvUjgyN3pQZ0tDWG5FazBNVjBhVDZYMXk0?=
 =?utf-8?B?azdTWFc3WU9acGJJNHVFTXUvWUFpbzIyRXV3WnlwNFZlTXhRclBHYTNqTWV6?=
 =?utf-8?B?am9MaXEyN2xwUzZHSjNUMktQWlU3TDNzNDVzWTJTTkJQeWRYMmdsVXhya1Vu?=
 =?utf-8?B?UzVTZ3FDVFpzSW9HNE9XSWRYT1RpYW44M0V3SzZ1bDBqSk9TRjlDbnhSeUZy?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e95074de-3cda-4163-b284-08dc532d2429
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:54:12.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiQFO53nVaqNi7gN3RtbJ70qhluOqT7optOArMtmbRMiWIK6ssGxdJIF3HH0lWTSoms5jO9sJ3oOW92bKLGpjYo57vWhuH/iCPUtabUA8d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 14:45:07 +0200

> On Tue, Apr 2, 2024 at 1:55 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Jakub Kicinski <kuba@kernel.org>
>> Date: Fri, 29 Mar 2024 13:53:44 -0700
>>
>>> On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
>>>>> Sparse:
>>>>>
>>>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_res' shadows an earlier one
>>>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared here
>>>>
>>>> I don't see these building with LLVM=1 W=12 C=1
>>>> and I really don't like complicating the code because the compiler
>>>> is stupid. Can't you solve this with some renames? Add another
>>
>> It's not the compiler, its warnings are valid actually. Shadowing makes
>> it very easy to confuse variables and make bugs...
>>
>>>> underscore or something?
>>>
>>> I'm stupid I tried on the test branch which already had your fix..
>>
>> :D Sometimes it happens.
>>
>>>
>>> This is enough:
>>>
>>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>>> index 1ec408585373..2270fbb99cf7 100644
>>> --- a/include/net/netdev_queues.h
>>> +++ b/include/net/netdev_queues.h
>>> @@ -89,7 +89,7 @@ struct netdev_stat_ops {
>>>
>>>  #define netif_txq_try_stop(txq, get_desc, start_thrs)                        \
>>>       ({                                                              \
>>> -             int _res;                                               \
>>> +             int __res;                                              \
>>>                                                                       \
>>>               netif_tx_stop_queue(txq);                               \
>>>               /* Producer index and stop bit must be visible          \
>>> @@ -101,12 +101,12 @@ struct netdev_stat_ops {
>>>               /* We need to check again in a case another             \
>>>                * CPU has just made room available.                    \
>>>                */                                                     \
>>> -             _res = 0;                                               \
>>> +             __res = 0;                                              \
>>>               if (unlikely(get_desc >= start_thrs)) {                 \
>>>                       netif_tx_start_queue(txq);                      \
>>> -                     _res = -1;                                      \
>>> +                     __res = -1;                                     \
>>>               }                                                       \
>>> -             _res;                                                   \
>>> +             __res;                                                  \
>>>       })                                                              \
>>>
>>>  /**
>>
>> But what if there's a function which calls one of these functions and
>> already has _res or __res or something? I know renaming is enough for
>> the warnings I mentioned, but without __UNIQUE_ID() anything can happen
>> anytime, so I wanted to fix that once and for all :z
>>
>> I already saw some macros which have a layer of indirection for
>> __UNIQUE_ID(), but previously they didn't and then there were fixes
>> which added underscores, renamed variables etc etc...
>>
> 
> We have hundreds of macros in include/ directory which use local names without
> __UNIQUE_ID()

Most of them were added before __UNIQUE_ID() became norm, weren't they?
Lots of them were switched to __UNIQUE_ID() because of issues, weren't they?

> 
> What is the plan ? Hundreds of patches obfuscating them more than they are ?

Only those which flood the console when building with W=12 C=1 to
recheck that my new code is fine.

> 
> Can you show us how rb_entry_safe() (random choice) would be rewritten ?

Is it unique in some way?

#define _rb_entry_safe(ptr, type, member, ____ptr) \
	({ typeof(ptr) ____ptr = (ptr); \
	   ____ptr ? rb_entry(____ptr, type, member) : NULL; \
	})
#define rb_entry_safe(ptr, type, member)		\
	_rb_entry_safe(ptr, type, member,		\
		       __UNIQUE_ID(ptr_)

(@____ptr can be renamed if needed, this one would give the smallest
 code diff)

If you think +1 layer is a terrible obfuscating, look at
<linux/fortify-string.h> :D

Thanks,
Olek

