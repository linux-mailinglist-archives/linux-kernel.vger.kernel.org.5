Return-Path: <linux-kernel+bounces-151816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0A8AB449
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F99E285202
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8D13A25A;
	Fri, 19 Apr 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3me3GYd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491B137C32
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547379; cv=fail; b=kA0OjOyClgPax24irHZR6d/SOud0N9hbGoa7UxxMY+59hFpgQdSV8/nZ7mQhQ5ZskB703RVQ2ZbYIeNCnJHRahNLXY3aijF2KaBkFIeY5ztGyQ4hjqMpJVUKBbkXHQelitXnKKSuUJaUlPGR8UMO1nk3lxDYw5l9rwpTknTnSDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547379; c=relaxed/simple;
	bh=XpoUyCiqUUw4x887aTSTq44LkU5+tpYboCknMumBVD4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9LEz+rTucAEyDv747OU2YwZfS82vdPAOwo+Hoa5yQuZRjHHqly/721NB0tL+8KY55/TDuEiNYRspIslGheNNdPU4X0tu3iboGEb3eYjXvz27Hjfe+T+M2d9RpDOX41wYlzxLSCKC1o1MAHK0xUNsqg/PHRqZ6JtJTF5L6tfwpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3me3GYd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713547378; x=1745083378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XpoUyCiqUUw4x887aTSTq44LkU5+tpYboCknMumBVD4=;
  b=f3me3GYdxVa10wE6QBT4/yn4MXxC/fq10h9U2BKF2f3bXuKU71xHUx/L
   nLMqXNQEmLvIeS9wjugdYfplEImPJ5wvBLTS2BAuiIluQXaogGxxck5Xp
   bo0JCQ1o1AKmUrKZSfFERw/bgxcFmP+39awdv9HG2joFvO0o9JyxZ9/B2
   OtGfs/jCNd0kTxWDXHLvzhyKZTuEL9BL9Gg5hINbf59Tw2UztKAcgVLyE
   K3fjD6thg2r+/sA7mB6RT3BRvMogw7LreAcgWGjgO3xf8raCGoygskGWD
   A/uFoOG5oKsTQnBI1weC67rK47jjMi4o5cizl/TQeOHZB9HUB/ld9WXEH
   A==;
X-CSE-ConnectionGUID: wFmcH5vfQhq0bMwdY3ZAww==
X-CSE-MsgGUID: p2GRRc/aSvyEKE0QI/1WGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12102596"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="12102596"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:22:57 -0700
X-CSE-ConnectionGUID: B/JbZdYtQdqQg7TNg6/eqQ==
X-CSE-MsgGUID: SCfhCdGWRNCjenha/RHg+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23839106"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 10:22:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:22:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:22:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 10:22:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0qFmBvYC0l5MZoModI6KY2t2v7ogc/no6vfdnj7kXaQ9eNkzxt88Vm8wlZMKYWxCAvgOZMKSFe6p87gTPlcqJO3VsP8y/yG8b57C/seIUFrOVQSdFtjPgNc7gJrC2UG5R1Yst2lrkM8XGB8rkD+eMiA8L2Ap6kKnDg5EfCiz4E4oAk/PutwD6H5y0aWaAIbm33n3rMvO8F/HM9m4QH3omgVPdF10LM7Ia2wL5rvgtrw/VXaF9GQWkiUb6u2pIPtpA8ADftF+Y27XEPX10dPcG9GFaLSFeD37j1SXqV+xPP9iebC+lbTzb+fq6mablP8ifNohRWOeDvHPzyESoRkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1EkjGV29nFFdS7gAYKCU0epBtILVmFw0EZUT1ijjEc=;
 b=MgVg1CbmrLAy3WIiRozosWOZObu0tiDx1no/iyEBlKlJC9yursjers9fDpzFT7/iq6epwbo5imeE+Udaec3CEZd6aYAZOkAqwFr/PWsNxiwzYsJL+tTw8nwH30GQmKEQ25SXzuBCplOSM/kcYFnRoz/I5dHMwGJryuPa0DS3kMOqyZUUw+Q2/7nlLyD7sUWzzCfke9NucCEBo6M50ISXY8jgkransNco7v7CDD/xP1x5Yvg+zdoqMtTiYrh9lbO1WfKJcwnMnu0M7pB2HA7/BOavwV+BaggdDNKvVLdcmLxUlkYCx/0EBZX6A92cMwNtIC+aaFGeYgVBhZmFUxQqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Fri, 19 Apr 2024 17:22:48 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 17:22:48 +0000
Date: Sat, 20 Apr 2024 01:22:33 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Xuewen Yan <xuewen.yan94@gmail.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, "Tiwei
 Bie" <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZiKoWSlTD8oSWI0R@chenyu5-mobl2>
References: <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
 <20240419082440.GB6345@noisy.programming.kicks-ass.net>
 <ZiJBqRafMdBi+wCV@chenyu5-mobl2>
 <20240419162428.GB23130@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419162428.GB23130@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aef1d1a-b09e-4dfa-4c3b-08dc6095554e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZdKJX/s1G/9cq5UybTOffeGwp85ahbcRtND6N8j2aWE//anNGzqY0E+KZHNTZfs7C+mQemXnibfwJZu90mrIlwDEKqyIssUvCUd4rLkhrluzBcVICTPr41zurfzITbn962knyvb9jjG5hJaOG+EtxRpiTu6icd0txf7QRKRorD5JLIRFn5w4LG6m5jjbO5ageXBK8TmD9UfXSHD2O7akMUNP9yqZcONQEiMMv30IeclobMqn8XIyVM3C7kq8lAHTdL6mmpu7s9IVNZJwxgb26jG9AtLPNEWRLfLB5bOZ9/ZmApIP/jDnzTrrzqg/hW6XLxAgWjFFG9pkns4eEd6Mfhlj/yJSa0vK7ZMiuswWhWFGfDG0KsC0SfN1BJhq3lKBR2Y+OvmKJc1ronTKI8rSeHEZBgIJg06ABA/q1QamHLJsYyHqdY1xPaCcK+zPu656HkHacSW/VASJys2Vvds7Luo7LTYxH7fuGfgSzwpGz+C9A1uxJjnrPvXUW6+7ba6pgvp2GcsucK8eS4kajmnY4N0xqMYl1EjPvqErPjU6Q5HLyeTmFNpeOuc+KOKVpsfuvDmd0DP0hMFCPnL4Os+MkeCTr7X9t8t9DOcFR1kNPyYy6tMIVrSpEP/o2tXIsBhbSqlvz9Oxv6iu68MFAWo4a3qZM6BqQlPCJiZdqe7ZQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5XXL5KCL+xFth9rUgWI4mbpO/7cdLFVWrZpZ3kteMq5fyktGK9G/4zJWu/vG?=
 =?us-ascii?Q?9rPhVL4nqCekC1woW1vhcAfYOEv1jDlfnStiWdu5/6EK5eRuCX+8Tg75txmu?=
 =?us-ascii?Q?KfsArmjwCOd41/14QiC3oQTlcXk9c1Hj3BW6iaQDmd9dsCzMIX/gaeRIZiTv?=
 =?us-ascii?Q?IVnfd/+6mYfDv81czND/aD0lsYuGxRaffFPcS9+JVOjVZDdfQJTRksFZoXD+?=
 =?us-ascii?Q?iiPoBGXXV+3cg3Iss4HDqWcCq9EH3ghY+8EF/6UjDVlNLX9MHG/6rxaVh9zL?=
 =?us-ascii?Q?3r0yXW4yQwug0EcCmb0MWOlCMXKZX63Gb2EUL8CbpLWNO4OwLP3kPJFr7f80?=
 =?us-ascii?Q?jorSKKt0sIVlg3XY6VuXXSPEI4mo4/3T1DORC2a2z++Mgcq5Vu1mJy0uUplR?=
 =?us-ascii?Q?A9LROxoWqhSpFg1vJj33haKbSPGz8FbGjd/KTi24ZJwrSJJLTVXaS4eoVHbR?=
 =?us-ascii?Q?krOSS5hoirpf9LZMqv7LYfcIFoF9JGnv3S9k+UwDMFAUhBqUaZr86/2v5bJv?=
 =?us-ascii?Q?eQUNb/WOKDhTMHYlB0BeDKyBzsmGyeVV2a4QKal8wTUR/SQRD9D7eBtuQ8YN?=
 =?us-ascii?Q?shBlxlulCQkUeD3fRZqgcbTCuKhUCq6PX0VVCcpyCVhrgiDA5grO8yO8EQty?=
 =?us-ascii?Q?mpCLknHIcfY3t7tLEXNR39Z0+X6ZDPb9hQQyaRW6imeKk8Rq8EGYkD6xDbPL?=
 =?us-ascii?Q?KkoAFMv7WkyH7HOdGdGLIDhjJ3iUAj5QAWFqo5FDdG4PfDz5o+H9LFkoAraD?=
 =?us-ascii?Q?VYlgQMHzKC/JYIi31rD6mbylQuNJTpbFeRhY00j8/U7tzQ75JHr7fnj17Lcm?=
 =?us-ascii?Q?aUXdsvvRTFdUmscPkZfAWqiPZRsdzCHljRG7xVIlyC3H/N23e0MP6vpvAK6c?=
 =?us-ascii?Q?SXhiekY1igBOs+zH3FlR9XHFLGRL+SGWO/dgWS+xXpm2cCOjAea3DTvC9Ipn?=
 =?us-ascii?Q?vAVyYqC0HHG/ZEUF2QW/+slAu2OoRycnydbz1onvlUQl6GIsUEAi3+K+dPL/?=
 =?us-ascii?Q?KBtAl+f/ywdB0bAYS5nn4/Wu6kjI9e4e5IGejQoqNRGcXjqzOA3KsceIuHys?=
 =?us-ascii?Q?Aaft4rCTfcQam/Se6Q267SkLOtAaq3bJORmjXWf3wXQsQmmnjCERg96Ckx44?=
 =?us-ascii?Q?RUg1vv0JvEFuMVvu0B01uL1xnYIc8LiFtCPUsIOUJQclX+LTiD/TipdbsDQT?=
 =?us-ascii?Q?vRKwQ4tzO06wy0bm7U4whhJ+hgxnRKnusVIZsliFKycco6ct5KJmwFu3zq5M?=
 =?us-ascii?Q?2qqLeCmIZNZHf3GBTSlannChDUag844tPAxeTHjdqqe/WBPhwDLRRTTuKUSA?=
 =?us-ascii?Q?Kg11bsoFE1RZ9KuG6dPw8d9QzEDwhiTnOuYSIRYWdcZhVvTXXnk61Ip2hAZY?=
 =?us-ascii?Q?7wkqzT0GAWd/akCQof1hLpViSWSpLa7nVuDXMgDJnaxmfLllmlUTI4pVoYO9?=
 =?us-ascii?Q?Mko0ztx/20exCHLQEOLd2yValOO53x3ZUHLXImwnpI6U95BP0B9HUVwb6fkq?=
 =?us-ascii?Q?ZSA04IgYT8kr3Jmd3Bla+uFua3mJyxFtpqdvPpzcls/JcIHR8E8PidDK46ug?=
 =?us-ascii?Q?UOoYyU3Y6BzVQhDyLNX6f9onBojFYEvhY5CXpMe2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aef1d1a-b09e-4dfa-4c3b-08dc6095554e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 17:22:48.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkNyUcsvft0fMoxcuWO/4iAXh1rlHlfNkI3flKGd0nZj+qeePE19Qec0zarXu8dNw8JWIc6m9c0U9SYRyRBdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com

On 2024-04-19 at 18:24:28 +0200, Peter Zijlstra wrote:
> On Fri, Apr 19, 2024 at 06:04:25PM +0800, Chen Yu wrote:
> 
> > > Also, could you put a few words in on how often these clips are hit? I
> > > suspect it's fairly rare (but crucial when it does).
> > 
> > Everytime it happens a subsequent NULL pointer exception usually happens.
> > The trace data was posted here: 
> 
> That was not the question. Suppose I put a printk whenever the clamp()
> actually changes the value, do I get a stormflood of output, or do I get
> a sporadic blip.

I see, it is not a frequent clamp - around 5~30 clamp per CPU every second,
when running trinity.

thanks,
Chenyu

