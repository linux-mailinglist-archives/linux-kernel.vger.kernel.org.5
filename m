Return-Path: <linux-kernel+bounces-133413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE389A363
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030B5B24419
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254EA171654;
	Fri,  5 Apr 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1pbcy7r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A71D530
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337326; cv=fail; b=aouPqpQ+FxSrJZM5ICy+NyslnMse/2ft/WXK2RB/eXI6L/Z9FWThFwXVf5LdLvNPZBLPwRf9kkM/KWgwZNC9siCTQBdxHB8KC+o2WHLDsP211MklKgHupQXbzQaFU3WsmNdS14yXqgCOcTwvEZ3cZcJETHUPTNqKtmrVSTqABOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337326; c=relaxed/simple;
	bh=DO9ytPv15UkxF//ub5bu3mT/Pi5Zu0NRKzJRr8jjvg4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sy9z6JaLMas/t6iQ89ndBFfuOhYbSyjSFY5P371Mklsv4jcpIcgANJQQtR6kdr7YST5HE1r96q8mWRcIXQlv5H9hBMiakH06eRJWJ8Y57cVb4Hd6PS4Rj9GpNg0kA/+D4mLz05ln+xiI9AJzqqPFCy70lW0xype76edb7qmGYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1pbcy7r; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712337324; x=1743873324;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DO9ytPv15UkxF//ub5bu3mT/Pi5Zu0NRKzJRr8jjvg4=;
  b=P1pbcy7rNdFjCQd/yMtLRpbT5lZGDORo2qiF9B2jktDaaOFY4ACByAYs
   mXKxY3H5+ZAqA37XcsWsXWaK/vTVp1GPmBFh5p0xQ0GRjo0KCXNVC517i
   bjEq2LPuiyObr2QDu6QYTzi3+0H7mOkhkrGgYHFvkAKETY9S7s2W+3KHp
   Zg8izPtkyz2qWTnJQ3xhu8nCFSUsfm1E54YSole0anV8xFHPapALABrS6
   rkbgYlUtmmfDNwXU6YAQ/LkbRtFqSzIRSDZvvOymsQjCTo6ww6HcZ4xiG
   5USVWjLbnH8tt7LSARAxpbWIyzxCFJt90tM/mFMsNGfR2YRpK+epnFDov
   w==;
X-CSE-ConnectionGUID: Q2KNrEtjQ/u2zzOH3FZoxA==
X-CSE-MsgGUID: ecemNzvGQKS+VIKFSKgkvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7908921"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7908921"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:15:15 -0700
X-CSE-ConnectionGUID: WFNxTndLSgiHJXiWi/1yvA==
X-CSE-MsgGUID: S1ltO8H0Sq6LZdN+CSwFNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19081167"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 10:15:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 10:15:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 10:15:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 10:15:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 10:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exvdFA/84bjD51oOlaeXyg8i6lWjjLf6TTpJdB38BKwFuWt+WseDAlrTBFD2Xhwm02Wogj+KJkDvrCj6G5vLB82ktjKs5zLCnZMOJZJBNdqUYc3sc5YPyhJ+rfhQl8BLoKwema4/GRylBWX3kPJ9qJc+XM6xihfJP2T29R+345qDqmvQzMi7z7u7z89j7wCnkRwDkqlI5PqMeayGpwTp5Ik5sJY0toQmm4HcenlEOqzf3eLmR32CWLHXY1tehi/UyQdROGwF3wLLwvPgSkjJcVc2WRd/7RUHYHn+pB0az/Fmrg6HkBnQzSYGWFLSGYW/7OsSX72XKv82XbFdSXr4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq+zbqA8s0bsDrmll9hNSnxb876+mfNihFnsGpDbcIo=;
 b=lhxiGpbIlStW8GTTJKq4kAApVq8fa8xa+tv3Q+KqBp29xw4pE6/CWe0KxMyKFcoMEqL+cH15zslYn/Gsh04vjZH/wVpDrputE6v2gWeKClbNLcP758xlMiKXPtgULirbl6RU0K5/oMatxur7az/xxMn6c7BDW9RTIeEQi35nFo6nB4fYe9/0SQMqksIbHByZ42iGR/t+A9rArkOMynSp3H3cfkl2idMrnox+NH4v3PP5ZJF5cWaKXuT9D067Mp6y4KlUB9QW5zxdrORP2Eupqy7BqOll5kLW+mwAEqC1YMTeRp9G0Wi9lniQakGdkbo1lN/NlIgdCmMASurEOsHKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 5 Apr
 2024 17:15:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 17:15:11 +0000
Message-ID: <d410aa13-0060-418d-bafa-c24f9653861c@intel.com>
Date: Fri, 5 Apr 2024 10:15:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] x86/resctrl: Abstract PQR_ASSOC from generic code
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike
 Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-6-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-6-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4874:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuQAQNogLa/si6TbSTY6URGUaDYfvhgYxSrLyxB+qkGN9bBGDAq+WTmgtsmEfPQLHubrTrzt9FmMVC4VItDr/AcJ9CPWQFQtGZ0XPjp1v/fJyRZvQ74yqeMSUcfDf3oOp/yYxCZfic40csKYa0LYvwSRKABhQHTSyICIVewXCFpGNiqNxPn0p7dKBG5isxfGX7cP9b41VnvKrrDReirjG5J/pO7AlEpWNHTsdn92CI5uXWyYFNnbSiEdreWO51nCovT3pfNq+LfZkpi0wwSBkTuXkgxNWbAtIjCkcYYzFgzNFz43CrT5tdSge4cfk8tWgt7PcADc8mwpKAkFiT4gQfxaQoeiWJPbb+IGIrv6YbKUA7V4pA8dIQCMKyzGUpt8qIGABoR3+rLqQOAb2Q1FabniadSNl5GUCMtzVwkwI+o8i/Bb2fISxD0w3vx283c0A5jKo2VFHaLt4N4UQfGhzVaBBMNnPgYmLW3cDPuSilQG63ozWDmE48AoaU3shxpAcSXF5xmBaQLzx70X0HwEwark0H2tfm64XTooMQj+CjUzwbTzkvPzcPMiR5jOoR8Ij3V+2h+sNutdBSxFCMMpY9d3XAwPhUVZIE2b57SRko7tk5TLMfQZgSnMrvpeqlbI4+jeCQy2GqYSQeY/mkFZ7nepFSjaMgrviUG510sznN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1UvazNuVWR5TGd3eDVpV2ZoMyt6T3grN3RQVFljais0cEU1cDFaOXJuVjVn?=
 =?utf-8?B?eWZxdUIrdGVDSHNPSWxUaHVJa1gxMTliQ2l5Q1JTdnp5akZEUEk5SkpEN1dY?=
 =?utf-8?B?WVpXRDNFY0RnM3d1KzR3YVdiK3lMUks3MXZHNHBrckpIV3lMUnBmLzQ4ak94?=
 =?utf-8?B?RklnQW9CNVJCQng1TVA0ZFlNNkgyakdqMjdyamlhT3JWaGMrTCtFYk1VaUF6?=
 =?utf-8?B?QUt2K3BxOTEvdkh2bWZ5YmY4ZkExQUo5RXNGUzcvcWVGMVFCdkt3RnYwbDJm?=
 =?utf-8?B?MnF5ZHcwRnlydy9ZVnYySFhUTkxYS1EzcnNkWjlZU0owQThKYS9BR2swc1Nw?=
 =?utf-8?B?dkYrVUxWQW9saXhTdUtOeHV6aXkzWjFSVkJFbXVBWnVTVDBta0hqUTJ5TkxJ?=
 =?utf-8?B?REVyNkE3bENjaEFrZFdDem0wekYrRmNSZ0hsK3RISmdGZ0ZFQUY0cGowWXpu?=
 =?utf-8?B?YzhETjhEWXNjVHlxbTZ4ZXNzTm9qVDVwRWVkTUtqaWFIaG5XMHp2V0tBalMw?=
 =?utf-8?B?SHI1bWNpQnBEdDV6NHh6NHNxZkhoUXNPY1pOU3pFOWtxd0pFdEtlK2xCSW54?=
 =?utf-8?B?YkFxbTlCUmg2a3ZGY1JTMVcrbHZRWFZMdmkxTkhYMXplS2lXWUdjbHIxem1s?=
 =?utf-8?B?Z241aEEzdlJFTFVZd1JINnY4Uk81dXFTMzcrTStxd2pHbHVsdmJZQkR0a0tF?=
 =?utf-8?B?WDFEZjZjaVNvUHZHOXVJS3I0b2F6UVh0bWtXSDA4OXZCSUd5OThaS3BEZ1RF?=
 =?utf-8?B?b1kyRzE4cjZCOHJzc2RlN2t1aVkwdzE4TFowdktER1Y4cnRyZlhFVlNkeXZI?=
 =?utf-8?B?WnUyazFDM3drVU5Zdjc3d0VEajNnTE9ubWhHbGlYa0dsQ0FadnhFR05nOXpY?=
 =?utf-8?B?djVjUTVVUnA0UWRObFRQUU1HRS84cmRZeHFjRjBlaWpodlE0cFhIZGVqRFA2?=
 =?utf-8?B?ZStBNVdnbTN1c3BhRXRSNnNjYk45U3hSaytGNnhBWUljbGk0MkU2R3J5ZTJW?=
 =?utf-8?B?OFJGMUV0NUY3NlZvYlZjcXNEL0J0OHoyRDNYdCt5cjQ5dDlDMjU4T0M0bmxY?=
 =?utf-8?B?RVc3RDZiUGlFaUViSkZjLzlHNFBhWHExL0tBYTh3azVoUnNCMjdiYjlHMStR?=
 =?utf-8?B?SHNNMWNubDRmMEJWbVFaTTEyMjY1cEVSYnJVRE9aaHpFakxkS0V2bnZPb3FR?=
 =?utf-8?B?OW82TmxWWlNPUWNKQlZnNkNCY3pNNGtML2hWSTVBMXV4NHI1VS9JeGI0RGVo?=
 =?utf-8?B?NjA2R3BaL2lrZTc3cWhxQWhoYTJEeStlRUo0eEZCaFVDK0tWSEJFMG12VEh1?=
 =?utf-8?B?K3ArdTA4WktINVoyMDJLaUpCR0NwOUNuQmFDVC9IMWRZV0Q4NjV1T1pLYTBH?=
 =?utf-8?B?ZVBJcjlteTdJWXJUUk1jajZFampPTllCTHVURElUOWRIRkR5OUIzbWFaN1Zy?=
 =?utf-8?B?VlJKdjBvQWlYUnJIeG01SVA3L0tZemdwV3VEZUhCWDIyNTJCYTNxdFNJSjFh?=
 =?utf-8?B?UHd6QkZJbUJtY0lwajZVbkpkWlFVeXAyREJWYzV3MFh1Q05XRFFUaWlCS0Ny?=
 =?utf-8?B?QUVRM1pyc1JobkIzNEF2Ukc1THorK2lCR3JMempZU0J4YXkvSkZVeVRETEhi?=
 =?utf-8?B?MFh5cUgzRjRFLzN1T3BROGxZUUppK1FWcjBWLzRIMlRoSmJLWnZCVXdDKy9l?=
 =?utf-8?B?WU56cElnS3FGZHpYUzU2QjdodDZnTTBLUFpYVytud0pOdWNHVWFmY0ZhWFdX?=
 =?utf-8?B?L0xyS0RFeUZ5MUg2aWdHYmsrQ0JpUXVUa05yTHVxSTRkZmh3V3lYMGhENWRs?=
 =?utf-8?B?K285aDdZeDRpMm9seVJhOCtKbjNZbUk5WlM1V3oyY3E2ekVjQ1FnY0J6WkZL?=
 =?utf-8?B?ZHFreWdaVWpzam1tY0FYVERPR1ovdUVxdEpXeU9DUC9Jdm45c3M1aVhoWmtr?=
 =?utf-8?B?clNnWWwvRHNTNDZRbG9valVHUkZnZDMydWM2TVF2cTFQTmx1TjRDRHNPczM3?=
 =?utf-8?B?eG0xeXJ3UVBrbnVMbnA3UjBTQWdNbDJEZytxelhmejRRSHNaODkrYktpNzk2?=
 =?utf-8?B?bEJia1RqdU1PT0JEV2NwbU1lUGNEZDQ0d2UzNEVKQWlFUEFZS0RwMG5KeGJH?=
 =?utf-8?B?RmMvMWh1NGhBeXA3NmxtOCtzZXlER0xKcElhYzlZTjZVWnVGNTNha2pZVXAw?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 450bcdc5-9315-481f-3b59-08dc5593f381
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 17:15:11.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg/43YrBjpiNVy84ExfFuIJ6WB2Bk5n7NL8twFlY/v1gr3rPTO8AgjTzjOEx7qGZHg9CCgVzoIul+kSIIe6nNkApD3CK8A+d77AqqUMUFT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> While CLOSID and RMID originated in RDT, the concept applies to other
> architectures, as it's standard to write allocation and monitoring IDs
> into per-CPU registers.
> 
>  - Rename resctrl_pqr_state and pqr_state to be more
>    architecturally-neutral.
> 
>  - Introduce resctrl_arch_update_cpu() to replace the explicit write to
>    MSR_IA32_PQR_ASSOC in __resctrl_sched_in(). In the case of MPAM,
>    PARTID[_I,D] and PMG are a simple function of closid, rmid, and an
>    internal global.
> 
>  - Update terminology containing explicit references to the PQR_ASSOC
>    register.

fyi ... I just noticed this while looking at the MPAM patches that there
is an instance in comments of update_closid_rmid() where this
was misspelled (PGR_ASSOC) and thus not picked up by your rename
script.

Reinette

