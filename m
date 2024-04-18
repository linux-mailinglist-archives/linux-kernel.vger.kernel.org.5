Return-Path: <linux-kernel+bounces-150129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FBB8A9AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4D1C20C45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783A1465BA;
	Thu, 18 Apr 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="benUZ6j0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A531143C4A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445444; cv=fail; b=PUFGbwwGfPT72wVqp2GlDBJraE5ZfseVDpRedo772LTfMBW/vrXXgXzd+iu++A0FeXwnHjZt16wWZRng74NSk6FVKeKQZTNOpOBirnNus/0rUjO5NK3deG0pOzdYCoXq1xlrKKocxnMRsD+1FllZ0KjePfxPEIT2Xvn0mbpydVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445444; c=relaxed/simple;
	bh=6zn11GqQGjo9msSzzXPW3x6b9QMCblzO50CYfqIg5r0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBsH2OuwVid6Vo5sYik76iuyXEldTDI/fOOt48mzhy+4be9Z+2JTEu16biCxC4gq9SvKsL/MOofLt/PccP18VynRT1sEyWvLZZfz4RO63l0oImuf5tQDaw58VrPZZzvi/m7KWyvo1EP8RsoauYg4Uhi7QIyDRWKZ2/d5hMb8P8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=benUZ6j0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713445439; x=1744981439;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6zn11GqQGjo9msSzzXPW3x6b9QMCblzO50CYfqIg5r0=;
  b=benUZ6j0fOd7h1TlO0eekXdSwHVNWJheeZmM0a+z/N/ZmHBU5Ezag5V+
   buxdex1yaHqbOQgHyG8s3its0VBO/Zd4OiRsnfEgPnQsV2W5/4AvVjXsT
   emHrlgA/uMgTM8jDJkq+bxwRGOthFYXMmrTeaUK8SHne1lCxqcwbxTFba
   CAu2vB+mXAW8EjGwEVud+LI6zPCtR5ZHkm3Vd80s2InWpfcGai3pqCkM2
   VYp49Y6j7A0qghRPwmSzcSELkvTzJd+HgzdML9SArpdw0arklXNyTeh/6
   LMdNBzofL3GlGyy5Uu7o7sFtH9htcjkJ1QD12cqyQ5lDUudcae4xorCvP
   w==;
X-CSE-ConnectionGUID: 2gczj3MkSPu6xQnLL95rfw==
X-CSE-MsgGUID: SiDiE3vGRXu08Uw+nahpgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20134944"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20134944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:03:58 -0700
X-CSE-ConnectionGUID: Dg08weeyRoqCt5LQFZ5mOw==
X-CSE-MsgGUID: lwUzzTVLTvGpTiXUXsRl0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27750465"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 06:03:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 06:03:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 06:03:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 06:03:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 06:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj3XD3+zUTcg0b4thAGiaccmaBmBWAmJWsQad5Kwx7guTS1oLj9XiZBdhhInqs3ldTVozhPWeQJmVNg/27QpLSP8QAqmn1hiCT0g6O94FDRfl1afCuPljqjBfYzcdb2noU+cxTiusPJc5SICoiMopj8ivxRpcDWo+Q2J9u6VwFEJBUv9ZhiwyfvYsuN71cmfR/GoMjugMS+HxsHLoSLo8tPv6nwz5k2+61P1OF/nGLcLSRDGFEsQ0oVsKwcSkauJTF/sK1mMVn72MHF57LJkZAXpGQwCqH9BfsPjGHVv5ngPqlR7rgn42E27n33qEMAvEAo3k+O5gAmruDDWI0U0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk2WPs6CZUTUp7D+U/l0A/vbgnDwPnBIYKKb7RzFkCU=;
 b=F7j1zyv+wOVI6gGg+jJSmjctvqJw1X1eQ4R5Y2GHw/1wV5+GcFCMlnr4xc5WU63EfPsi4bx+R1XEn7zTwa8ZOibXHVKxUX8vQx17pn983JRS4rTd1hqnzq/SiaBDYV6gxYWAhQdJPkwlvDJKcl17U1btNXFqTwNtXYLTpNfUpJYqECdazx6X4dHkLLaxI6xVtKTIcFmEMGvFb/rols3sFNVJ/Et7puMUt5PratbjWpR+jWuFU4LcDmFZ3tYKp5FH3150vrOzt0rRKIkjq1XpLO0kYLJT1EGS5XEOWI2k/CUbv3Fyz0+17W1PZxps/KFmj3rYZ2FQT5Wbn8ISxuR38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.28; Thu, 18 Apr 2024 13:03:51 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 13:03:51 +0000
Date: Thu, 18 Apr 2024 21:03:36 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, "Tiwei
 Bie" <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 340d0b1c-eb0c-41ec-d6b3-08dc5fa7fe77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqt95qZzsrF+1iEoAXQaB1lTohpScLXz5bmOwRUMCKM/RAcAj2VTQZ8iXnRcAn1u36GWMeXcTlGzllc56a/ISULct7uF5hOVRrOiiYDI8znKyEDob4rBgaWTpJMo/zhCFsijXwlymdXZjZnjCMaObErBc47fpqq90hqC6G93HgwMXf4cmsYe04YNqClOd/IVD0w0OXfqutvoPqo/bm810cabJ1Ys6uxNw1uyje8RifCKoWsR4A2wBWamFKRUE/S23NdbmkxtZQe/alC5ivmAf0teTBFE2IuCDyzN2Bs7JoR6kAo6A9aeNILeAGvVB6Z9eg2KY4dfeYFqRqNWge66KObzu9HDk3BssH8SevReTsOZr21A6K3d8HEwU7Be+KvcSLSjMJlsERsOkGKgImTPjn4zUd822TzldL3iFy/sBZw9SIwO+YQkncMWSxdRppZN6fpKMLkbBF5FV1R74kSHfd92UAV0FIBT93peRzFs5/Y0dn7UWxNOFleEdKQFsoiyX0wiGco1H3Jsp9Ku3bFA8aAZkJ+rktL6ZxiyRIFNxPH7leldO3qHSzAGuKXXOq1Jaeg5jwtAYXh163PM1PdsQhN1f6JO1HHPTVtie0YZrTSK6stWzMt+oKS/PvfNTSHw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRxQXo5V2NCSjl6NTZRYlJqbGhKWTJqYWYyK3BEeisrZVlQWkgxeFhlY0pI?=
 =?utf-8?B?bEtyeXhEeVdWNDJIbmpnbE9aMHlVeTYxd3RRYTZkN0FhaEtSM2VjdU1vbVEr?=
 =?utf-8?B?ajhNeW9WTFNCNENHQ054RFFKTGo1aGVhTHo2am9mc2JvcUo2OHpHSFFRMHpn?=
 =?utf-8?B?M2ZqUDFqY3M2M3FRZHFEYkpQdFhNYXVzQ3l1bkgybSsrN2VndXl3alZVRkFC?=
 =?utf-8?B?RGpONXhPTDB3V2JwVHZUeVhBNGtXaGV4ZmFBYVFwUGc5UE5BdUtXSm9kWlhm?=
 =?utf-8?B?MUliTmhkNzhXMlRWTFY3ZXZhR1l4T2JGSm5mOXcrUmJIR1g4MGZpeExzekl5?=
 =?utf-8?B?ZFdxbzl6WVVnd1BKQkpHR3pPajJBUERnVDZnWk0vdFl5WEZvSDZtb1o5U1dM?=
 =?utf-8?B?Z0lOTXBHeTRacXc2RXYzZ2Q2UWRnVGdDNkRNNnR5NGh1dnJXM3BsTXZSY3Bw?=
 =?utf-8?B?eGlBQ0FPenNrMklwMjFGOVZiN09hYVpVNTBseHk0bjI4SllNcnVJMmwyUVdU?=
 =?utf-8?B?Y0ttVzNKNmtiVnc5OGxxbmQ2WjU0MmFUWnNjdmtGY2E3bWdJSlg3ekJhZU5L?=
 =?utf-8?B?YTljR0wrR3Via2M4dVF6VXlac0Ywem9MbXNnSVhxUDAwT25hTGtCWi84WEFK?=
 =?utf-8?B?Rno2QklYTXhhUTdaT1ZkUTRJdnJSbWpLWjQxN3Q0UXlBR09rUW45OEJ1ZWFF?=
 =?utf-8?B?SjdFaGVZcWJ5MWhNbVFJdTRQMTF1UitvTi9XYWlmcDRwT0h2b00xZU1yUklB?=
 =?utf-8?B?MHpKcFRiUThFRG81TnVJL1RwdE1KZnA5L3VGd1hwZmsyTVBaZnVMY2Zvejhw?=
 =?utf-8?B?S085SlZKZ1hyQjdsWVFKMTJVenJ1VW4zNit1eWFObU5rQ2h0NFFhMW82cGhN?=
 =?utf-8?B?elpncjlZbWZVZklxU2lkVHA3UlRsenVuOEV2eFFETmoyRG9kRk05Qnd5eUh3?=
 =?utf-8?B?eGhqTVFtUFJ0enIvSzB1bTZOd21jL2NGQXprQ041R29raGRuaXN3ckRMQTho?=
 =?utf-8?B?U2V6RnJldkw4T0ZGZWtjRGt5cG5uSG1BNnYzTEJINDlvT2ZEUTcvN0p1Y3hO?=
 =?utf-8?B?WGJFc1pONjJyUHluQXRzL1N6NHVKTS9KT0xuWi9majdBd2JXQ1FlcEt4UlVU?=
 =?utf-8?B?Z1BNQzFaRHpObVZaRkphNnBmU3pXOThlaXJJWURoOVBrdldCdEVja3p1NDVG?=
 =?utf-8?B?Z2RpNGVSSmpJc2g5UEt4ZUdaMXdkK1g2ZFkrTk9rUFA2cml6cVBnd1dva3M2?=
 =?utf-8?B?d0RuZlpXV2ZrQ1UzaWs4QnJwRDUrT2U1RXNHM1VZdUUyckFQQ0V1bzRPUTNn?=
 =?utf-8?B?bXVoMUgvUFI5T1dxbk9RMmxjbWlLRExZenRVZzJWd1VkYWo5YXJndC80SXRS?=
 =?utf-8?B?RVE1VFNuL3VaU0ZBcVhBTkw0RXRrVU5Lc1ZDSFQ5eWl0cVdPSnZVeFpDNHgv?=
 =?utf-8?B?Q3hPZVNMNGlLMTkzRWsrL1ZZcHhUMFM1di8yNkZ3MmhSZi9QK0pqbU4zanlT?=
 =?utf-8?B?VXYxM3ZIK0VyZHhrQm14WVJFMUkySWZUbGRWL1JFZzRtc0dqZmczZ2tWK2RY?=
 =?utf-8?B?MjZ2bms3ZENoUEhCbVovT3laeWxGemRRTnl0eU1xZ0VtNU0xNGJiUzFxY1FU?=
 =?utf-8?B?R1Ntc3Fuei8wci9pUzlOUjlZU2tlMGhxeVJBazBoTWZraklZTkNOUHlzd3RR?=
 =?utf-8?B?VnRFaCtPUk5XRnZRRTY3UVkwMjM0Ulk0WkVqTy9rS3N6cy9jeUs3eUNFODJ1?=
 =?utf-8?B?bHNVRW5VQnNEV2U3OGdNaTZlTmt1SUhhcmNleEtSd3E5cFBWaEd6a1A1aVph?=
 =?utf-8?B?MzJVUUN5eExVb1FiRkxRMmVPUzBGRVdXWkRTZEV1aERWcFQxRXNmdklseUp0?=
 =?utf-8?B?S0RQbytOcXZFZUhUcTdxbWYxb1NTdCtPd1l2S0pDVlU4VHhXWkhtUmMzSzVE?=
 =?utf-8?B?RjlKZFUzRlZYd3E4OWlJZVoxaE1XMjhwY2d1bWE2REQwTnpmdVdjRTVqTnJy?=
 =?utf-8?B?MHhKdXNmK0drVGRYbVNlQllPbldBdkRtVlJ3N1J4c3FYS3dOOGt5NWQxS0tZ?=
 =?utf-8?B?RzVLakNLWFhEYXZSa1RXNjNsNks4aHE1TTlyWTF5a0F0ZyszL1BLZUo1MFdH?=
 =?utf-8?Q?qW1SmOJaJpjysOc5jr1Nh+umw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 340d0b1c-eb0c-41ec-d6b3-08dc5fa7fe77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:03:51.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvOH0db2hdUPM0UwCCiGyguQyxYQZGjfUfoLBOGSmLfgPrym7oFa0i1nugbHJ+3aYmfi2atBbshTwL75kalpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

Hi Xuewen,

On 2024-04-18 at 10:57:22 +0800, Xuewen Yan wrote:
> Hi Yu
> 
> On Thu, Apr 18, 2024 at 2:35 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2024-04-09 at 11:21:04 +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> > > > On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > > > > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > > > >
> > > > > > > According to the log, vruntime is 18435852013561943404, the
> > > > > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > > > > > > thus:
> > > > > > > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> > > > > > >      delta * 2677 = 7733399554989275921
> > > > > > > that is to say, the multiply result overflow the s64, which turns the
> > > > > > > negative value into a positive value, thus eligible check fails.
> > > > > >
> > > > > > Indeed.
> > > > >
> > > > > From the data presented it looks like min_vruntime is wrong and needs
> > > > > update. If you can readily reproduce this, dump the vruntime of all
> > > > > tasks on the runqueue and see if min_vruntime is indeed correct.
> > > > >
> > > >
> > > > This was the dump of all the entities on the tree, from left to right,
> > >
> > > Oh, my bad, I thought it was the pick path.
> > >
> > > > and also from top down in middle order traverse, when this issue happens:
> > > >
> > > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 cfs_rq->min_vruntime:763383370431
> > > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> > > >                     min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > > >
> > > >
> > > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> > > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > >
> > > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
> > > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > >
> > > > The tree looks like:
> > > >
> > > >           se (0xec1234e0)
> > > >                   |
> > > >                   |
> > > >                   ----> se (0xec4fcf20)
> > > >
> > > >
> > > > The root se 0xec1234e0 is also the leftmost se, its min_vruntime and
> > > > vruntime are both 763383370431, which is aligned with
> > > > cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets
> > > > updated correctly, because it is monotonic increasing.
> > >
> > > Right.
> > >
> > > > My guess is that, for some reason, one newly forked se in a newly
> > > > created task group, in the rb-tree has not been picked for a long
> > > > time(maybe not eligible). Its vruntime stopped at the negative
> > > > value(near (unsigned long)(-(1LL << 20)) for a long time, its vruntime
> > > > is long behind the cfs_rq->vruntime, thus the overflow happens.
> > >
> > > I'll have to do the math again, but that's something in the order of not
> > > picking a task in about a day, that would be 'bad' :-)
> > >
> > > Is there any sane way to reproduce this, and how often does it happen?
> >
> > After adding some ftrace in place_entity() and pick_eevdf(), with the
> > help from Yujie in lkp, the issue was reproduced today. The reason why se's vruntime
> > is very small seems to be related to task group's reweight_entity():
> >
> > vlag = (s64)(avruntime - se->vruntime);
> > vlag = div_s64(vlag * old_weight, weight);
> > se->vruntime = avruntime - vlag;
> >
> > The vlag above is not limited by neither 2*se->slice nor TICK_NSEC,
> > if the new weight is very small, which is very likely, then the vlag
> > could be very large, results in a very small vruntime.
> >
> >
> > The followings are the details why I think above could bring problems:
> >
> > Here is the debug log printed by place_entity():
> >
> >
> > [  397.597268]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-1111846207333767
> >               cfs_rq.min_vruntime:810640668779
> >               avg_vruntime():686982466017
> >               curr(0xc59f4f20 rb_producer weight:15 vruntime:1447773196654 sum_exec_ns:187707021870 ctx(0 73)
> >               leftmost(0xeacb6e00 vruntime:332464705486 sum_exec_ns:78776125437 load:677)
> > ..
> >
> > [  397.877251]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-759390883821798
> >               cfs_rq.min_vruntime:810640668779
> >               avg_vruntime(): 689577229374
> >               curr(0xc59f4f20 rb_producer weight:15 vruntime:1453640907998 sum_ns:187792974673 ctx(0 73)
> >               leftmost(0xeacb6e00 vruntime:-59752941080010 sum_ns:78776125437 load:4)
> >
> >
> > The leftmost se is a task group, its vruntime reduces from 332464705486 to
> > -59752941080010, because its load reduced from 677 to 4 due to update_cfs_group()
> > on the tree entities.
> >
> > Back to reweight_entity():
> > vlag = avruntime - se->vruntime = 689577229374 - 332464705486 = 357112523888;
> > vlag = vlag * old_weight / weight = 357112523888 * 677 / 4 = 60441294668044;
> > se->vruntime = avruntime - vlag = -59751717438670;
> >
> > the new se vruntime -59751717438670 is close to what we printed -59752941080010,
> > consider that the avg_vruntime() vary.
> >
> > Then later this leftmost se has changed its load back and forth, and when the load is 2,
> > the vuntime has reached a dangerous threshold to trigger the s64 overflow in
> > eligible check:
> >
> > [  398.011991]cfs_rq:0xe75f7100
> >               cfs_rq.avg_vruntime:-11875977385353427
> >               cfs_rq.min_vruntime:810640668779
> >               cfs_rq.avg_load:96985
> >               leftmost(0xeacb6e00 vruntime:18446623907344963655 load:2)
> >
> > vruntime_eligible()
> > {
> >
> >    key = se.vruntime - cfs_rq.min_vruntime = -120977005256740;
> >    key * avg_load overflow s64...
> > }
> >
> > As a result the leftmost one can not be picked, and NULL is returned.
> >
> > One workaround patch I'm thinking of, if this analysis is in the
> > right direction, maybe I can have a test later:
> >
> > thanks,
> > Chenyu
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e0968fb9ba8..7ab26cdc3487 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3965,8 +3965,13 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >          *         = V  - vl'
> >          */
> >         if (avruntime != se->vruntime) {
> > +               s64 limit;
> > +
> >                 vlag = (s64)(avruntime - se->vruntime);
> >                 vlag = div_s64(vlag * old_weight, weight);
> > +               /* TBD: using old weight or new weight? */
> > +               limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +               vlag = clamp(lag, -limit, limit);
> >                 se->vruntime = avruntime - vlag;
> >         }
> >
> 
> According to previous discussion:
> https://lore.kernel.org/all/CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com/
> 
> Could this patch avoid this problem?
>

100 cycles has passed with the following change, with the fork() cased removed.
There was no NULL pointer issue observed so far. Meanwhile, I've launched a test
with Tianchen's patch set on top of this one to see if everything goes well.

Can you take a look if the following change make sense, and if yes, could you
send v2 and CC the reporters, so they could also have a try if this helps.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
Reported-by: Igor Raits <igor@gooddata.com>
Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com/
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
Reported-by: Yujie Liu <yujie.liu@intel.com>


And in v2, it would be helpful to include the reason why we did this change, how
about something like this:

"
kernel encounters the following error when running workload:

BUG: kernel NULL pointer dereference, address: 0000002c
EIP: set_next_entity (fair.c:?)

which was caused by NULL pointer returned by pick_eevdf().

Further investigation has shown that, the entity_eligible() has an
false-negative issue when the entity's vruntime is far behind the
cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
caused a s64 overflow, thus every entity on the rb-tree is not
eligible, which results in a NULL candidate.

The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
is because during a on_rq task group's update_cfs_group()->reweight_eevdf(),
there is no limit on the new entity's vlag. If the new weight is much
smaller than the old one,

vlag = div_s64(vlag * old_weight, weight)

generates a huge vlag, and results in very small(negative) vruntime.

Thus limit the range of vlag accordingly.

"

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31bca05c3612..9f203012e8f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
+
+static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
+{
+	s64 limit;
+
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	return clamp(lag, -limit, limit);
+}
+
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	s64 lag, limit;
+	s64 lag;
 
 	SCHED_WARN_ON(!se->on_rq);
 	lag = avg_vruntime(cfs_rq) - se->vruntime;
 
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-	se->vlag = clamp(lag, -limit, limit);
+	se->vlag = limit_entity_lag(se, lag);
 }
 
 /*
@@ -3721,6 +3729,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	if (avruntime != se->vruntime) {
 		vlag = (s64)(avruntime - se->vruntime);
 		vlag = div_s64(vlag * old_weight, weight);
+		vlag = limit_entity_lag(se, vlag);
 		se->vruntime = avruntime - vlag;
 	}
 
@@ -3768,6 +3777,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	update_load_set(&se->load, weight);
 
+	if (!se->on_rq)
+		se->vlag = limit_entity_lag(se, se->vlag);
+
 #ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
-- 
2.25.1



thanks,
Chenyu

