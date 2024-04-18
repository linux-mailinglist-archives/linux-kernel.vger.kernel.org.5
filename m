Return-Path: <linux-kernel+bounces-149519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803ED8A9252
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0729C1F22081
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73E54BE4;
	Thu, 18 Apr 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYLjh0o6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2C4F1E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417413; cv=fail; b=FhPNTaP8Q97KOjyNtZDqouXq86WTNVxEW81svDSxfra+omVURtJ7NfJMN20LkoLZ3YJ4+cGlWKPdY2HEH8X6o1kWl5EEZMboqutF/c/JMEiAhxoMzebAYWfn2pSJm+JBJ4CoWaF8vGqvf5+p4qo8IZHZLIPeb1SEGDgw02T4CZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417413; c=relaxed/simple;
	bh=iRf4dkAVgNUVKe5oY9DZCMtslLj56dkjc48Bgt+Csmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lbhk16GGJTC8Em5b880boVQxzylFMgyTKhxQF9Ta5o5QX1AZI1Z20TQCjXhtVOErI7I5mIyALq9VG4xUBeRqPPXT8BGNG3GmaF/lHIM8tlrJwSWBn7jl7nygPaOc5WrtbwHsRSpNl+gaR7bakznKITW4qtjP4v07hVVq7hiL2Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYLjh0o6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713417412; x=1744953412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iRf4dkAVgNUVKe5oY9DZCMtslLj56dkjc48Bgt+Csmc=;
  b=lYLjh0o600xhmy3xyqdhGH5dsufobph42dF6KJ/m3T3d22YUFma32/1R
   6JJKUhD0itkBKbSkytPU9dx4IIcZMt/noIBwyAhyah2DXJtttSQdlMx5P
   BfQEAy4/rYHIX+NZYam4zLCq1GnEW+vcqMMLBLzGY+3JpJBWb3dv6o4Fp
   ybxQ77mxUa6JnAeoSN9f4za57drzcQibneJvSDt3x+kHYwlraNZJjW/DN
   0LWXd9/ZO/Kdk2WPqT6YWCqHxHC10dbpgsLTMlBsmAewuGG0LhUqSVEvh
   gScyK3qe4dATAKSOhpDmFhIB2Q0wdkPpI0qRjI0XfBab8DyZFjM+pigOJ
   Q==;
X-CSE-ConnectionGUID: jNXFRVdnQNa0Hc7a80PMpg==
X-CSE-MsgGUID: 0Ckfq/i2TuCJro848UpQaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20088336"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20088336"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:16:51 -0700
X-CSE-ConnectionGUID: 2nmqzWGSTTeyj6ItRyaS7A==
X-CSE-MsgGUID: R6KG6QAuRuyWpEA1kduieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27517294"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:16:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:16:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:16:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZzVZR22vY6KOsFL2/Ne26MnYC9xhSM1aqKZYfnI4ZDVpT4oqC+836PPqoDI9yJw8go/mIgNmj/6tc60IsiS+lnVuzS5ecuJLMlz+58t+qUQvDVoVrnRbXs0Y17IORB/aQ4todXqsv4dLBcNUOTuJWcBAQM+held5njyVJXw0DKWzxUEmwjzxwFc12LdrpnSkclfBi04sYR2y+gPW4HANllN/eHZYbrnIKHtDApva2liR6Bn9j9Lj6TfOJw/3kFhek684lpLuVIMKzq6iGNTFseLuh/sldHhm3M85T89VssCJHvqVil50oRkzI/2tMEj9WJmcWFgM0zQLyXYTAtn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBSFnmyCLsxaKSA64j8MCArTSYY1OCNjht7CVAQ9p04=;
 b=ll0NVdIRgAV921ChibWBulavZfVQl1PpCQsqb4ApHOTda2X20jSS25T4WrEYoMMyxgsN1BorZZpnTBYzudNs2ueZrEJyd7NC2qVkGKE2xfx9dSmNuJmumqTCgtkyIq5OnFA1nmK8Zy4giD+xdEhQsovMcAFLDVCj+UB6uCQXmhyzIrSkPHOs8x8H/AGyCo3e0A2gnulCri0tD3VaSmtR8SiyY0GEqdVjhtsJ4UK+EkRFFvWPROr/YCSC2GU5AU0k4fVF0zhwHKBrvsFddJ7oC3Hj4ouyPWBNLxGqd9NEHyxa5bjGgwr26gb580Wrp0WEMFO0d+6hilehKpksHoTnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:16:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:16:47 +0000
Message-ID: <3391a909-d8a4-4ee6-9836-b16c0ad8944e@intel.com>
Date: Wed, 17 Apr 2024 22:16:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/31] x86/resctrl: Move max_{name,data}_width into
 resctrl code
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-13-james.morse@arm.com>
 <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>
 <ZhfwjBJPeTvO04BL@e133380.arm.com>
 <d269b5d2-bd6d-44b2-8d99-0e0a2790bf50@intel.com>
 <Zh/flJb3obutHTbD@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh/flJb3obutHTbD@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 01202f35-a32b-4605-3d66-08dc5f66bef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpocFdLs5+QxfATxM+uuiPJXLwcxsjQGFuZQ61/drMfQ6tzesxRVldAzPGVxQZyg0if3lVNLL//osDYl5ny0XfjN/LwpV8HnofJrSQh4/56POq9R0NTwvHFA60Sfr+8KiKJq5h54pbtFBVFMZu+cSw6wDEkh1F5RjX9BIqfezIrr4qM/RGUuXixidDlPXRON86h+BtUd/uY/WNTCorNxXSMC0Y19oong3W871BUHFoR6KDCQC2pnjzP3dv7sLIC/6+kc3yC1HHLmoa8i/89FQgcm7R/lFdCsZF7Dd7Ir4EIRECnT39HGN4vJtJQfm7l3QweYBql2m5JjAtn4tyiC/Opdbt+Iwki0XEsioqLIrXVTkTX2CO7qOQaBU0NVG6msx7ibxeby+0fTmEF2rzwsYkygpi9KdtxDrHxzzYM1v1sMzCl5ddNYQef/emNTsrkLoTawYD+jfVDsL/BzoI4kxG5aBnJda4pptoxduyPwzBVh1NvljocMxwibGAQ2uY2rLPMtzXrNVOJjz1M4kFwaWCICIHcBatT7owAcOmp1DIYqqOx9D0wneR8OKfdarIH3zOuuhGelK+SnM2u5qIosglDXlPGWkPDVlD7gCX36QXO4eFgyvY7d0n2QLZOt65U6VsRXX0vApd1OHwCK7oT0oOuKOEwBntjQeb+cSk8oX+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpDMUNvVFlOc3o0YkMyTXR3cEJFVjFYbjlQTGZmZVlyQ0YyaFhCNm13OUJK?=
 =?utf-8?B?eVY1MDFJUnBUTVR6REt2QjFQZ2xCMTNza1BWbFh5MWRoUzEyWlJrOG9LVnJI?=
 =?utf-8?B?WFc2OG80TWI3QzZuS1NMWkYyLzFZejYwNE0yOE5Sc2IxZTVjVlBPcGM0VGtT?=
 =?utf-8?B?U204RWV0SDdpK2YvZmVaQ1p0RmQ2bHQ2S1RPajlLR0Q0Myt1am1uUm5KamJl?=
 =?utf-8?B?S2k4UU9aa3dIQmVwalEwZmVLSis2YlVBNitYYlRDUGE1K0JocEZtQkFDSnV3?=
 =?utf-8?B?c1V6bE5vaWFjYXphQmQxQTVGMkkyTmt3RHR6YWJtUzUzb0cvM2R5VnFyOG1l?=
 =?utf-8?B?QVJ1UE85d2lLVnYzUGVxMDRzVWd1Z1lyQmx6NUdEY3RELzNCL1RyZnl5azE2?=
 =?utf-8?B?VitpdGh0TVM2dGhSa3VVek8yalhiWUQrY0UzWHlnU0l4OVR0NWRzcDVpakM0?=
 =?utf-8?B?K3cvR25WZHQ3NjRTMGxXM0NSUlB0RmF6b0daeWdCRlBHelpVZW93d09janlQ?=
 =?utf-8?B?Q01TUDV4cE12bm8yV3VnakcxS2wzNWp3QVVIaGdRaGRCQTZ3WS9lSUM4VHZt?=
 =?utf-8?B?NnVZZzQ3NEd3TDlKSmMxTmovNVk3QnpySDd0Rjc1TnFvZXdyOXZkN3hyWTgw?=
 =?utf-8?B?anMyNkdVd2ZoMDlBd3dXTkp0TURxQm9XVHF3K2Y5MEUxd0NmUXVOWklHUjdn?=
 =?utf-8?B?eHNleGJNRXhQTzlWa0JUSkVJZjErSlh2cmZDTVRLTTRwbE5zNDVNMHBWalFR?=
 =?utf-8?B?TUt2MG1kb00ySXJqWnVYUjFEQ2dHVW5ST3JzdWMzNWZ3S3JESUswbnVUTTQw?=
 =?utf-8?B?aU93NGxHOXBFMHpjTUNNQldUSXRlZVpnVHB3K3hHMHF0MFFHY01FZmxONTFF?=
 =?utf-8?B?YmN3dmhaczE0S1JBbzlXbm9KOWhTZlJyTVFqZmJ3S1VWcEk3TmF6NHlLcG9C?=
 =?utf-8?B?T1ZULzJvQkhYYjBZZzhFNVdJSFErNmFJano4L3ppWGsreHBKL0lzZCtjVkdD?=
 =?utf-8?B?T0IrYjd0bWd6NXBoSFRFbFBMTmVrcVlYR3I0TDkwU0dCVldUTkQ0OFF6QW5p?=
 =?utf-8?B?SXRJL3RkNmZvME1qdU1Ba0JoNHhmcDE3aExKdzFhc21vVVJVcmlhYTBPOW00?=
 =?utf-8?B?YWFQMUR3UEdhNnVFeXE0WlpjQTRqcHQwMmM1M25pWXIrTWhPNEJGQmxpbEhP?=
 =?utf-8?B?dzc3TDJWNE5yd1F3U1dCTVpNVStqZ0pQbTMyY21yN1VpYzdWSy9aUk05K3Zh?=
 =?utf-8?B?aWJGNjliMlExRkh2bW5ZcUl1ekVrSmZueVZIdGpBVFNSOFkwUDNVVW1JZUJu?=
 =?utf-8?B?Uk9kMXJ0bkkrZHRwb3B2TWFuOXh5UVNuU3Y5VC9yRG5HS0pGc0FmN1JFN0lU?=
 =?utf-8?B?ZFplR2l1clU2TFZGREJwTFFOTm5UUHd5ZjN1RE0xUDlnNWM0TVVxTng1Z3Iw?=
 =?utf-8?B?QXlEaDdvM1IvUWpFcmcrYVBrNTJ6c3NGNlM1OU9GL3JwMDA3K3c0QmNJQWJB?=
 =?utf-8?B?ZFFPekZxSmMzVTcrdEt2RVhMOTVUWFBtMFpZZFgwSmIyN0ZRT0NobmNuSk5S?=
 =?utf-8?B?ZXpMeW42bER2R0V5UzIwQ3VyNk14ekRTVDlJZ3NzQnNNS2pmVVZQaTNSR2ZO?=
 =?utf-8?B?K1lhNG95OURpdUNpL1JwSzlhVVh0VkFzUmdUeWdIN2xjcjRPak1RNXh3Y3hy?=
 =?utf-8?B?RHJ0ajhTSUtVckJreEp2b3M3R21lQzFXYklXUmRUbUlYMjY4RjlISXlFdWIv?=
 =?utf-8?B?NHJjS1VuMC9jenIyMW5DeUFkUEJ1QjA0VTdRTmFSWFV3ZUJIdkhGSEsvWmVx?=
 =?utf-8?B?Q1o0Y2t2S3Z0azdDUVpKanpsNnZUMVBOTmNhQ3RtOTFuKytOWDJXb3ZtMEp4?=
 =?utf-8?B?MHFUeEV1TW85MjM4ZGYxTlR6dmgzQ2RCdEpnWVV4YzZjR2E4SjVObWhsbmpL?=
 =?utf-8?B?SVFFTW1OdmZ4SHozZ0NIWDB4SmgyODg3MzBKWStGL01qM3BtR2tkZVc1a3pG?=
 =?utf-8?B?dnB1cWQ3MTFQTWVGUDdvZklVKzN0Q3lkV1VkY29WMEs5VGNLTkt6cUhGNmZq?=
 =?utf-8?B?eUEyNTJXa1l0Y21UR3FYL1hDbXhMMGhFTjdFMGpQbWJjRlowbDUxWUhQUHJn?=
 =?utf-8?B?L0Q1V1Y2VWowOGVmbUN5cHczejF4NHdFVlNJNEY1b094RVdnYW5BN1NSaDVi?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01202f35-a32b-4605-3d66-08dc5f66bef4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:16:47.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my5GQx5hndNpjvVpW05EquDOe6HVoB3CiMd4FJlmnnKdarQFjyi8dTj7FqtbQNEhjnBOhT9CLdNLGVa7WVy54UkiPJhBpMwWEaxo5VBkmSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

Hi Dave,

On 4/17/2024 7:41 AM, Dave Martin wrote:
> On Thu, Apr 11, 2024 at 10:38:20AM -0700, Reinette Chatre wrote:
>> On 4/11/2024 7:15 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:19:15PM -0700, Reinette Chatre wrote:
>>>> Hi James,
>>>>
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>> @@ -2595,6 +2601,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
>>>>>  	if (cl > max_name_width)
>>>>>  		max_name_width = cl;
>>>>>  
>>>>> +	/*
>>>>> +	 * Choose a width for the resource data based on the resource that has
>>>>> +	 * widest name and cbm.
>>>>
>>>> Please check series to ensure upper case is used for acronyms.
>>>
>>> [...]
>>>
>>>> Reinette
>>>
>>> This patch is just moving existing code around AFAICT.  See:
>>> commit de016df88f23 ("x86/intel_rdt: Update schemata read to show data in tabular format")
>>>
>>> Since no new usage of any term is being introduced here, can it be
>>> left as-is?
>>>
>>> There seem to be other uses of "cbm" with this sense in the resctrl
>>> code already.
>>
>> I am not asking to change all existing usages of these terms but in
>> any new changes, please use upper case for acronyms.
> 
> While there is a general argument to be made here, it sounds from this
> like you are not requesting a change to this patch; can you confirm?

Sorry for confusion. I do think in a small change like this it is a good
opportunity to make sure the style is clean. Since this changes the code
anyway, it might as well ensure the style is clean. So, yes, could
you please use CBM instead of cbm.

The final patch of this series is in a different category altogether and I
do not think style changes will be appropriate in it.

Reinette


