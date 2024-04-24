Return-Path: <linux-kernel+bounces-156263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383638B006B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D4CB22397
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA413D8AA;
	Wed, 24 Apr 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCduKI22"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F901F5E6;
	Wed, 24 Apr 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932117; cv=fail; b=lQAVwO+k8k3pevNnbkhnyrM1fyL4INP1xQAiqGVUV3d+dXLxoka6IBJ6QJSeoKdcpIB1jqSPeuHedHHB4hxDczCc/4/vp/yB6ERvxBgTUQXG2wXeWG400vU5xnL1j0qzz1O2Fm2T4A/hCrlNteKX6YycRAzjYVW3UOyu5NHr9dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932117; c=relaxed/simple;
	bh=NHzlg15vF3KCnUd5Lqv8Mxe1uACAOh+wFhpO7fti98E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3Ju6ygtPuGsd9ofHiQvOk56N0GFwnGcm9nxFQD5yz9+6//F0ffVw+8UUVZHlPUdc8bx1qEmltEJeULRT2zAb8Ydy5Hsk5UhIFEb5my5e2dLKUflutAL5RRkYy9CG6oALbQgCWmKMc0+L4huuhqOXFDYByGyYV1ISCeF4wYYqS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCduKI22; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713932116; x=1745468116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NHzlg15vF3KCnUd5Lqv8Mxe1uACAOh+wFhpO7fti98E=;
  b=PCduKI22RNtWpBet883fJ55MVwwyu1ZpuDLkfW0L5WMLgaoXPPcubYRu
   6+8F1XO9ztFDSiL671GFh+RtQVX6IT8CcNA3DqKGSI2ZJKUOfhfI4eQWb
   2TEl3k8OaV+YtaO0sDw+xuYbYfyAdoC/z/V0k6j/4feISbh5I/PQOt24M
   4xC3vmCa5+6ZvhZLTw/n+y8eO2JL7nxq1dqril/dkd2WsUVJdbvjNu8g8
   8hury2g752oz7JtX/sWXKE7GYwfnXjdbBR9JBg/Fu4e0WumlI0ODeMQXd
   8gvPwsTVSdyWPpR0ZhgKEFsIWyUYY8d7JoIpi+cIh542nW+M+cT4vVVri
   w==;
X-CSE-ConnectionGUID: H5d/G+SkQzWPlAqd6qASJg==
X-CSE-MsgGUID: fsxKewg+Rk63X2CINxVRGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20950843"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20950843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 21:15:15 -0700
X-CSE-ConnectionGUID: +DXZFSfSRtiD2Zl/0L6fUQ==
X-CSE-MsgGUID: lwevOfs7QsCl45pamn+sDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29060209"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 21:15:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 21:15:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 21:15:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 21:15:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QssuWyR8ayCwU9azQ85bubPSXVp7cgng7+V1Y52ApRTL1q6ebriFyo/DmVCrecvQeNasYmJHAdnpYMDb/9zNpk9Y4awBk5D5eM1gG7+csZBP/RLbgO0VJ3/v5YQmdGSNg5lNbiZh9y90il3nbyWmV5XV+XWM2n+fP5m5JbeEsZC7Zh1Jj3kfZWvOqhib/9sfC7DV+Vu9E/6xMNy681dCco74bhH1apqcWc0lxConvgmcRHXbp8HITP9chUuntdCaTcC7euX5QOTd339mRtVNeUDJAK6UPNyylKgEgZUIzYXQ2tB+/g8kBl/lkkUzB8L2jnzKhf/XhhAuyMYlq+qd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SBy6kAo3d20cZ3rsmGrIFwftHbbZdDV/c7b6SErXjQ=;
 b=VrdAxKIlarG8vdd7hMQRd6cPdnHJVFjAWk6D4MmryopeeYQ8INsPJTCmbLng3kNkY2AK3Qmkb+YdHQPg8kNiyLgqWfuySNe4Uz4u+XUZgKc9kkrYWKPgEn9EYhz2vOEWye4z8yZKNSyes1mK8WLQ1z899epvCfQN5drXSzhmP9aBblqLM7OpyNs6dfFYtcwlz3rpPW3LUE8sw3B9hA4BeKKNNTq08N8TmJqFCmiGPup9MWO5TZxkX20NIoEP5n0JmIJyf73rfL6/JGDxWY6MNUR7mTjF3qiGvGrpRGXM3kGQaL5x/UoEgd7y040shpvLQi3pICyioFmlNMtr6SSPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 04:15:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 04:15:11 +0000
Message-ID: <a5029ad6-3e5e-46bf-881f-950a8a393956@intel.com>
Date: Tue, 23 Apr 2024 21:15:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
CC: Peter Newman <peternewman@google.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<tj@kernel.org>, <peterz@infradead.org>, <yanjiewtw@gmail.com>,
	<kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>, <seanjc@google.com>,
	<jmattson@google.com>, <leitao@debian.org>, <jpoimboe@kernel.org>,
	<rick.p.edgecombe@intel.com>, <kirill.shutemov@linux.intel.com>,
	<jithu.joseph@intel.com>, <kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
 <ZiaRewZJnLaDSx3m@e133380.arm.com>
 <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>
 <ZierjRNDMfg5swT8@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZierjRNDMfg5swT8@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: adf108e0-4dfc-4795-312f-08dc64152260
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1QxWFQ4dnJOVGt2UDEweGpFK29jajVzTldMbkthZWpLdHcwZEI3Wk5meUp1?=
 =?utf-8?B?WHJiREExb3dRTlB5cjhGekpzSHNNQi9JUEp3b1Bzc3hsdEIwVTJzZXVwdXNU?=
 =?utf-8?B?NUhMK1NaR242UStaNkhKLzhVM1c0TE5zTHcveGNoZEJBNXRkbGoyWkVEZTV2?=
 =?utf-8?B?WTl6Q25zZnNnbHpsN2ZHMzZDOHAvRURQMnErMklaMW1ZKzJvalVkbVZZWnNE?=
 =?utf-8?B?OWpseEhKM3FyQmhHRGNOaVF2bHRrQjk2YndQOEFXMzA1a1B2UFJJdTRTRXVD?=
 =?utf-8?B?SDI4N3NHMUcvZGE0VzRQdlZWRnlrc3NLem9ubC9vOXo4RHkycXZJREJiN3Qv?=
 =?utf-8?B?Q1JGdldLRVkwT2tKYnZjeUZSWTNDUmtPVk9qOUhoZDJ1YmdpZXZ2MWNhaFo5?=
 =?utf-8?B?Y3FPTDRvRlExWnZ1b0FSallpdXUzOWFHMTVMaFI2cXJCZ3UydG93NG9GUHJZ?=
 =?utf-8?B?N0lkdFBVdXZIQXh2SW5tWTl2QjhXNEljaGVYa1g0YU1XSVlvL0NLSTRWU3hW?=
 =?utf-8?B?RjZjalpkY0YveTlaTUhXNWlWQ1Y1SWdOSHlqaUp6b01IZXhLRGFZNitEZ0RK?=
 =?utf-8?B?TkNlbWNhU1pHR3lRU0V5aUY2TDRENUg4TDBKbEFacHZ1SFplWmc4a1NtbkhU?=
 =?utf-8?B?MXI1UEsrZ3pJVGJoSjZvTEJiVlprOUM1MEJlQklKQklwY3ZVbDh3dWRHK2xI?=
 =?utf-8?B?ZFBkREIvSzJHanVzZjJEL0xiL1lQaS9RZnJON0xHL0hjQXZJckRhbXdieXhK?=
 =?utf-8?B?cDMrT2dzTnAvYzFNaTdTNjZueXM5dzNHaENOdTl4ODN1Ty9DT1dmbHVYSW83?=
 =?utf-8?B?ZkdLSXBVOHFSaVRXNzIxY0YyNUlTOW9uYURWdXROcHo4RGpVVFNQcDlBQ0JF?=
 =?utf-8?B?UFh6VzR0MzZjQjFRcFJtN045STBWWDRxVXJvM3ViUXpXQ2F3czFBbkxDNEY0?=
 =?utf-8?B?T0hBeVgyZWdEMUxrYjVSUkRHSXVKelpQOWVOOHpSbzBTZ1JFeUxSWXVzOGxI?=
 =?utf-8?B?NGVSWEoyMGFOTEx2aE8yampycStaOFVPdjg0cXZaUmZJMlltWUtwUzhkc0Q3?=
 =?utf-8?B?ZzZaVFJ1cGFsaUo3M0VEeWFrM2twRTJpaG9rRVRaeW1YUFFHS3lQVm96V1pZ?=
 =?utf-8?B?L1Y4VktmTUpqMzlMY2Z1RE1QYkFtajRFajlxVmcrQWMzZWI0S3pVRUJ1dXhJ?=
 =?utf-8?B?Z1RNTmFLaW5lcWRtUWJ1ZG5DNDFSYzNnRE5qSTFkUFhrV2grVUxwZEdONys2?=
 =?utf-8?B?TEhxUml3NzVKT09vNGhDeWtGWUpzNEJNWFUxd1QvaW9PUW5kd2pnZk1lOXpN?=
 =?utf-8?B?VzIzK0dscXRoRms4WDR2bmRwMnZnMTFFbUY5UU1FSWxESW5zeHhJYzFDVjNX?=
 =?utf-8?B?ZjVEb1FQaUdnWHFiYzd1c1BhcVdTanR5enhRZXovQllOUXYyNGVucTRrbXBp?=
 =?utf-8?B?MHZva2toQUNSb3pMdWF1emZLMjNJWTQzYUlwcThCSnovR1dqUkhvbUJyQmVI?=
 =?utf-8?B?dnU5SGJnY1pjTGFuanJ3ajI5NXJNeFdSTkkrQkZXR1RZOFg4UDZTbVhwb1hF?=
 =?utf-8?B?bnBCMlpjVjRSMDNQZnVjRldDMklCNUR1RmtLWWJjc2VKa1ArOVJrNzUzNG9H?=
 =?utf-8?B?bkxjTFJiZEhXemlrb3RmemtVaitDbFJNeVF3NDNXV0RjNWRwVnEvb3VJd3VP?=
 =?utf-8?B?ZitWRHJraHVQbkdMK1V0UVEyK3JUN1hFYmxsN3BpbE9oc2REOUZrK3lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRja3lFWG51alpLUzNLY2t4YWZqZ09SWDZONndvRVlva1d0RXQxeXBqcTRa?=
 =?utf-8?B?RFNsNEJ5MFZ2SWpJOGNZek54TWFLRElQTjlTWXc2MlZvZW1MUlVvM0ozL1ds?=
 =?utf-8?B?TnZZcm9qVGtNYWRtUnl6VU5HdllXTEZDT1YwSDlIODk2MUhzU1BDNmppbU9K?=
 =?utf-8?B?a0s2eG5jbyt6VkZsUFdhd2htQjlTUEZYUVozdDY3WksvWG9QY0plb2o3L0pu?=
 =?utf-8?B?RXQ0b2g0ZXNvZzgraFQyRU5NMk5tQUNkcndQVFNqdU1xZEVaNEUranoxTHdi?=
 =?utf-8?B?dnFpQmU4bVRuTlFFN0ZMYW9GaXVUcE5kazhHUkRDaTdZcnNTdWRYcldUK3Ru?=
 =?utf-8?B?MlNkNG9aT1M4ckpvVkwxd2N2dTYxMlFwOE53MmFnWEtEa0VHcFFQVXBoTTlQ?=
 =?utf-8?B?STZQTjNoZmJHKzM3Zkp4bkVBRy9ZUFdMckFFOHJRWWY4NU1tNW15cGc3WnMw?=
 =?utf-8?B?d0xQaG44eVZOOUxlUEdsYzNUd2ZEa3IxVU8xWi9ZaVVZMDRSZ2dGK25MTm9N?=
 =?utf-8?B?QnI3RU8wayt5STIrWHltUERPd0QvN2hHSUR6NzlzR1pvRmF2b2RxdE9WVjhB?=
 =?utf-8?B?R0ZaNnRWVW1lUlovK20rL1VXOHFhZjBDcmZzcEx6dWNBVE5BdGN4elEvaHdQ?=
 =?utf-8?B?VXdvRFY1cTVlOWtwV01keGh1Y25xdmdjVDBiVFQ3bE1sZ2Qvd1B5WFB3SElJ?=
 =?utf-8?B?czRKdjBxYzdhblJ2UUZPaWdnWmhIK0RPNTBya1BOUTlWemxLMTZDL1FFbGkx?=
 =?utf-8?B?aEJreElqS29UNVBiK1VJUjNCTEM2ak80SVVoWVYraWl2b1lWdFlTdUlFQU43?=
 =?utf-8?B?VWU2WVQybDc3Q3JlT1p3bytSdVUvTGo1WTNqbDMyZ2EwNWVvQzRBZWdMcjVP?=
 =?utf-8?B?NkowQ3VFUEppOGVvTUQ2NFJpZzJZdTUrT3ZNbEFLZm1OcVVkZVcvRHE3bXFm?=
 =?utf-8?B?N0dISTIzMlV6eUpzVGQ4MGtiSnFzb1B2UEwwVkNyaW1mUUMwN3EvU2VIbzdB?=
 =?utf-8?B?MDhlYmxuTm9pZG9hblcyWFVJS3ZxOTA5KzBPOWpyL1loS0M3dlYybzNVc3d4?=
 =?utf-8?B?bVMrbENWcVZSUjErS3VZZkpGK1NwekhoYkEzVFVZUzlaMjFrdWFGK3hmblc3?=
 =?utf-8?B?Qjd0cDNSMk0zV1dkZUk2WW81b3hVYmFYemVZRXJiZmNlSXRZaXRFS3FEWUpa?=
 =?utf-8?B?YVNpbjV6Z1RJZ3ZqMkpvVG5yZkFCZWVraTlqaEc3MkVrTHBERVpTdER3ZDdu?=
 =?utf-8?B?NUpQc1Z2Q1dFTm9GUFdRVVprdng3SkVib3h6TVNxdzBicmFRbTA5bzNhQWpI?=
 =?utf-8?B?QUZ6SEJNUHY2M1dIcmx0MVVwMUFpV2lQUG5DWko3SEJyUVhaRmF5RmxyeUJS?=
 =?utf-8?B?dGtVT053azF5RXVEakF5eGc5ajd2V2ViTGFWUVl4d0lmQXNoSENMaUtrS2Vj?=
 =?utf-8?B?OUdLL1VGWE5wSEVoWGMvRzlVdHpkMkZZRFdEQjFCc2NRL25KSXNpQjNOd2xo?=
 =?utf-8?B?ZlAxaUZlbmhBU1QzaHdxSUE3cVRMTUNiTXBXTGZQNGczWXA1WXdTb2tvd1lp?=
 =?utf-8?B?R0dJbTN4QnVRK0ZTTDZPdFRHeWRaZlgxRnlvemJRSFo4ZDlaMHZiTk9yS0RW?=
 =?utf-8?B?bXMvd0dqUHppbDBzS1VBS054eFdsWlpyU2ZEaTNhR0REdGJHczd2U3g2bWR6?=
 =?utf-8?B?dkoyOWRzSHQzMFNQUjVOWlg2eTUwUjd3Ly85OEtLTmZ1L3VhOUlhaWhuY0lR?=
 =?utf-8?B?NlZYcVlKcFZod0NWQkJsRlBtb1o4d2pOVnFJY2tnMzJieFNjTXNaUmhkd0dT?=
 =?utf-8?B?TFFXQ1A3NlEyYTljSlduUnQ2RitJN2VxZTRXdmFhY2xxbEhoS2VlSUFwdUJH?=
 =?utf-8?B?V1RUdnN0YXBwZlBhQjFFcVZWaytKSWdUYWR0SDI5WDY4SFVlUXNodjZFeWdX?=
 =?utf-8?B?d0FHTWlWZWVXY2UrMEF1ak9RREIvY2FGanlQWGhYbjBkWDFHTzRzOUQ4M3dm?=
 =?utf-8?B?cVpna3dWTXNwdXl1Qkc5WHlyQ1RRamg5RXJpSnRRV1JHeUFLTDR0bFlCY1Vp?=
 =?utf-8?B?MmtaOW5QNEdEQkdGa0dZM0ZFYUk3dHE4Q1RGcHRvZWwxbFRLVTVZTCtadVN1?=
 =?utf-8?B?bnRiWGFyaDlQdXl0ajdBWE5Qd3drcDRDOE50YlQzaHNuZ1kwanVGUGRiUzhv?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adf108e0-4dfc-4795-312f-08dc64152260
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 04:15:11.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT1DWkQCCl7KqS9ul3bJ7dOFaPIzi2ilyatNMhC1jrun7swyCNPqgbfO5Kr0ycUGRzCLXuzhRVNG43Fvka4vF+pJy/czTGYopt8OyH43Bqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com



On 4/23/2024 5:37 AM, Dave Martin wrote:
> On Mon, Apr 22, 2024 at 03:44:26PM -0500, Moger, Babu wrote:
>> Hi Dave,
>>
>> On 4/22/24 11:34, Dave Martin wrote:
>>> Hi Babu,
>>>
>>> On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
>>>> Hi Peter,
>>>>
>>>>
>>>> On 4/4/24 14:08, Peter Newman wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>>    The list follows the following format:
>>>>>>
>>>>>>        * Default CTRL_MON group:
>>>>>>                "//<domain_id>=<assignment_flags>"
>>>>>>
>>>>>>        * Non-default CTRL_MON group:
>>>>>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>>>>>
>>>>>>        * Child MON group of default CTRL_MON group:
>>>>>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>>>>>
>>>>>>        * Child MON group of non-default CTRL_MON group:
>>>>>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>>>>>
>>>>>>        Assignment flags can be one of the following:
>>>>>>
>>>>>>         t  MBM total event is assigned
>>>>>>         l  MBM local event is assigned
>>>>>>         tl Both total and local MBM events are assigned
>>>>>>         _  None of the MBM events are assigned
>>>>>>
>>>>>>         Examples:
>>>>>>
>>>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>
>>>>>>         There are four groups and all the groups have local and total event assigned.
>>>>>>
>>>>>>         "//" - This is a default CONTROL MON group
>>>>>>
>>>>>>         "non_defult_group//" - This is non default CONTROL MON group
>>>>>>
>>>>>>         "/default_mon1/"  - This is Child MON group of the defult group
>>>>>>
>>>>>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
>>>>>>
>>>>>>         =tl means both total and local events are assigned.
>>>>>
>>>>> I recall there was supposed to be a way to perform the same update on
>>>>> all domains together so that it isn't tedious to not do per-domain
>>>>
>>>> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.
>>>
>>> Would "*" be more intuitive?
>>
>> We could. But I don't see the need for wildcard ("*") or ranges and
>> complexity that comes with that.
> 
> For "*", I mean that this would just stand for "all cpus", not a generic
> string match; apologies if I didn't make that clear.

(reading this by replacing "all cpus" with "all domains")

This sounds reasonable to me. It may indeed make the parsing simpler by
not needing the ugly checks Babu mentioned in [1].

Reinette

[1] https://lore.kernel.org/lkml/7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com/

