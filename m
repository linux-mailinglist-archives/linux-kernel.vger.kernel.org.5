Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081087A035F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbjINMKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjINMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:10:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D695BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694693391; x=1726229391;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gzJDuiLKMeMhthk/nrfs+oegWakmJ0X5k3AbH1EjnnI=;
  b=TGBi3eIeTVnrUGRNnD8rK8O7yEuYGJ2W5fdCPCOLW6469pQFopYkc1VG
   BaJw1hRGqp4qbls31mSlpO0Jm5nCD2CZf9zxdsLZxlN6acFJK4LjO1msE
   7B0VvZSLKU4ti4yj9ED8ptCtNbR20vyu/cY+Ivb9c6rPnNcdhs73ac47v
   3KiyMLyDwV1++M0ssQvVAql1W0i16/eqKdieAWH1WxASLUoU8xCRuQ29c
   k1BTw+x7rTVtuGuAc+CDPqO3qsGyAoluQbQ5YH/u6sxh0iwW/XROay6Y4
   4/7tyrSiaqlWY2Hz76Y1vvpPPdlwxgXQ7R3PRQj0cWX2bqS+bWnORTzOO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363968109"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="363968109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 05:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="773857143"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773857143"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 05:09:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 05:09:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 05:09:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 05:09:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 05:09:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUTbBm88dgd7Ppas68gn6cyBj9wq2W/6Rn6wk/ZVSMsU0iTsdIX61kwPCXqS1/iZQAlkstVcWBFApraXC8hSBMfw9lJj3I+4Xf298ztCmZnv5ORHcEVP6HX8AJM/Vq5l5LPsvC32rwu9Rjrhgemq1OA8oIC8AoZO6xEBYQ0Ds7+C+fP+HrCJGAINNIP0uRtn7XXoPfhGwlJ4FZ+oltMH3ReNoy/XIys8DcTE4Hl+dxG9iq9H4ZTjpkv1ROhKze8IdBDRBHV1jbLpLZpyCAYY8mPYGqs9M79maBUQDnyhewa103HboBKLME1+UVlFoNhy/2Vgjidhat8bet7i5DI64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7cQxIUbRqYzAp46qcIL5uWt7ZeF9ACHwK7Pqn4OwvU=;
 b=daqF7y3H8za333gRRP4CQL773aN+c7nNbE+dy8IjxfzG5pR3VcUw+Az0EyvlUSJyg8A/2byjH+BXliFKIitLm6CioxCQaLIg5Pt5Ha61DHg/zajZ7ydEa5S/eINIpMY/5ZMc4ctoNYwGA0O6yxSkAHSykbvOk3OruICEoLWoBscYaCylu8/4UOOEOwt2bpzchAAnc5DfNXG4MdWaCnx6JhMhKJJSVJfIYIh5EoYMYr2Ai0+eqf8AA+PPpq4oF0V9Hy2trz/gXna+qgeyg69UQvnpBUdKenJtRUKbp3FyHiJ9lGcIC/GIq7exxQalu2vBhx0zMMKMRSLe7cVrRR4hOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 12:09:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 12:09:47 +0000
Date:   Thu, 14 Sep 2023 20:09:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQL39qpKQncZWs94@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
 <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
 <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
 <ZQKw+W7k+XNweKBu@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQKw+W7k+XNweKBu@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 79733410-3540-4d17-c8cf-08dbb51b7d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlTUH/xVSqBEwdAvXRF5tjL9RkiHXkFhfH/DFen8O2OvQ16bLAv7C9z74fiLub+9ZznvtKwchDetf/7YXN9KeOvgzH+pgiSWmF/0s4DCv5aiYUmmrKsiK5Qea4DZYXvZLxAiqbEizWFWj/UI2SLP+p/Hk5XTt32QgW3Bf7WutLf8lUqSx6tOV20E4e/PsSnzPbcPiwmGbCDFXCrpB9kXpnqTEn2BKTpn/a1ni/JpqnYde/HP8kcB5wIuhS+9c3q6fbjUHGPh2hJ65QDq84pJZU9GP8ly4VcSpznOg1P3wc7Iuej2So9yGQ0mjkD0ykC6CLvdcTjqcd2fPYtdsIgc+Jt5zG+XFDLkhyrY9loMA6xg+mZ3LtZruR5ZuC/ZshGsEijkL/u5GGe3YLM+4kF8e/2zLbqaerFop93ZPtjD+VZ7u/acCLMggqo47Ukn8uP0aoIr6x7uJhtKjAZveO0kGSlSKM+XyTH+dPVaFitKfySbaHzUt283l+VcrBGOl8W4NQ6P9+StnSKVKUZfW6wBPzV/PHeLkeXE0kgJtjth7YWqmEOPnL2LQhyp14kNJz9D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(53546011)(66899024)(6512007)(82960400001)(6666004)(6486002)(6506007)(26005)(8676002)(8936002)(7416002)(4326008)(5660300002)(86362001)(2906002)(316002)(41300700001)(54906003)(66476007)(66946007)(6916009)(66556008)(38100700002)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duox0g1+FytIYz6E4emTUXrE766hCAxJvZTPeOJjV8bIKiNNyFmEJOF4ynRt?=
 =?us-ascii?Q?qW1bbaP2OPkl+vJOdtpcVKrEjmRWNX5KPFvVXtHd12C2HOXQSTbIYpOCmTwY?=
 =?us-ascii?Q?vrvbAHsR2QBHb73o1/b/+kkbV6JFtiUgIr/DaCbnu28y7k7WsSo9hRF54iUc?=
 =?us-ascii?Q?zFDsMSoQgKGMRGH4xBuB3c+5K6uYGxlBVC9+2Yzy9nbjm/Wv+Oj1sKAMdo3F?=
 =?us-ascii?Q?EgxUGoRSF6JIo+2y+3IH5RJYAfXRW9XTgauux0EqTwpUiSMgmfjlXRO6Bpq7?=
 =?us-ascii?Q?6rtUOP38uyp9Iov7zs8CjoEFmoX4ZPaN973nvfIOJ1MACW+q6nZgrEcU/Lp0?=
 =?us-ascii?Q?tvI5bWWhLDZXpP3hDBbtD+PkpYieGyxcP29qEhKqV3cMwVZLbKugtWxZA6eL?=
 =?us-ascii?Q?Goi44G0IAw/IuZIXrcNbkqfGN3nnBUde9wRluGx74ItUKC4KMILbZ5B/YEOK?=
 =?us-ascii?Q?v+SYueMuyke1o3jsEHR7yb3g2mSM1pe0gJMgZXEm+b92mFDPKl9iRZYixVSC?=
 =?us-ascii?Q?iHwhzLPTbF7tIKdCU8n9w92d2x/cDHnOep+r1kLLlgxn51ZFpQii2Ml+KAHE?=
 =?us-ascii?Q?G5Ij0tU3q4IhE7urVlYD1dJtukUkvdWOQ7lr8t5ZsW1DIZaJCOYkmtj6a7J8?=
 =?us-ascii?Q?YUJV90xJ5mF7Nwgfb7/eDybdq2gSPWQ6mKlnsXOxcw4HFgmy45u42NmEsy/P?=
 =?us-ascii?Q?9IlRGx5aRsM5MYswab+RdvOgbxz44slQLmrNIedDyfro0lzvasA1SVGLvSeA?=
 =?us-ascii?Q?P9S8IdLLuRiPxJltg8OkjrQVwI3qUwrailDtDuxOe7gZ8E4TVh/CgkxpCwWq?=
 =?us-ascii?Q?II+pQgwZYs9OIzQhJODeyDSw/UZuEKIjKWGT7KCdSCpY0k9vpn5vN8binHQT?=
 =?us-ascii?Q?JO1QbYM/rse8rXokLFHdZTUUGZ5Kcl+bjUWbrECxfk3Y2pIVm3OOxrioXRqt?=
 =?us-ascii?Q?8gghpZaZB456lSqIUyh2j24TESD+lVm9nLJlFwBJnTXvjYJBTVZlRDs+RWaC?=
 =?us-ascii?Q?b+esCaNuCYJPJa9Sf/TG08Z+JZMYp8qaARrxve91N8aB8favnz/F2vtJ4vvb?=
 =?us-ascii?Q?7PKyMHkMl02sz0o3MkrNluAgi/sCzs9EjU5jGvNbV3EIyru4mlKOiHEsBmoO?=
 =?us-ascii?Q?94ecvSZG6iD+8aF2JCKQEiyqFNIJv9moP2SWKMQAv9ljyh53ZhRXmw8RsbwO?=
 =?us-ascii?Q?eecAqC2sQNWc41+DN2oHJlwMKHas1ow3TWJBfdtXsRPBr4Zvoo2LUThShUtC?=
 =?us-ascii?Q?yrZ8/29KkFVIC6x9Z1iyQBNSea1YKYj9//jn0RL11GqqIMrVo19Tar9wky5S?=
 =?us-ascii?Q?y/rbznFH9C6UwX6KMF5fQS/CJyo9gvTi/QpHRvD3mDjVHrcA9qPrK+ijGIZh?=
 =?us-ascii?Q?HSjfXsZ3UqP1eiWyRQannGcHMvkxx/xcDJst5ZWILu0dwraWqQ+GWTGwF0uN?=
 =?us-ascii?Q?YKyFi8xRb4v/wXXkwmHkhhGgZmH/46ph0nWj3wEM2kWD/q6wfe1bb6pI2dyU?=
 =?us-ascii?Q?oKm2o/xK5Uc/KvAHICgpbOLIVFZfJ2d7WAhfIpm4xsScNDRyA1QyZxxGWq2O?=
 =?us-ascii?Q?8W2ckPIS9pMtQF7rPIvUAe5YjsWwHbzhzcoJkWuL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79733410-3540-4d17-c8cf-08dbb51b7d0e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:09:47.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H3Y+xTClzchEg+5FEHsG7hgc93biqw3M3bn5sYJ9ffPBTNJRcrOZj1nUr38N+or3CtKUlOM/sD074u+HljvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham,

On 2023-09-14 at 12:36:33 +0530, Gautham R. Shenoy wrote:
> Hello Chen Yu,
> 
> On Wed, Sep 13, 2023 at 03:25:14PM +0800, Chen Yu wrote:
> > Hi Gautham,
> > 
> > thanks for the review,
> > 
> > On 2023-09-13 at 11:52:14 +0530, Gautham R. Shenoy wrote:
> > > On Mon, Sep 11, 2023 at 04:40:02PM +0800, Chen Yu wrote:
> > > > Hi Aaron,
> > > > 
> > > > thanks for the review,
> > > > 
> > > > On 2023-09-11 at 15:26:29 +0800, Aaron Lu wrote:
> > > 
> > > [..snip..]
> > > 
> > > > > > @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> > > > > >  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > > > > >  {
> > > > > >  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> > > > > > -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> > > > > > +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> > > > > > +		if (sched_feat(SIS_CACHE) &&
> > > > > > +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> > > > > > +			return -1;
> > > > > > +
> > > > > 
> > > > > Maybe introduce a new function that also considers rq->cache_hot_timeout,
> > > > > like available_idle_cpu_migrate() so that above and below logic can be
> > > > > simplified a bit?
> > > > > 
> > > > 
> > > > Yes, that would be simpler, I'll do in next version.
> > > > 
> > > > > I was thinking to simply add that rq->cache_hot_timeout check to
> > > > > available_idle_cpu() but then a long sleeping task could be forced to
> > > > > migrate if its prev_cpu happens to just deschedule a task that sets rq's
> > > > > cache_hot_timeout. I guess that's why you chose to only change the idle
> > > > > semantic in select_idle_cpu() but not in select_idle_sibling()?
> > > > >
> > > > 
> > > > Yes, sort of. And the reason I did not put this cache hot check in available_idle_cpu()
> > > > or idle_cpu() was mainly because these APIs are generic and could be invoked by select_idle_sibling().
> > > > If the task fall asleep and woken up quickly, its previous idle CPU will also be skipped,
> > > > thus no one could use this CPU within the cache hot period, including the cache-hot task
> > > > itself.
> > > 
> > > This happens even with this patch right? It is possible for a task p1
> > > whose avg sleep time is "t" to go to sleep which causes its CPU to go
> > > idle. When it wakes up after a time t' < t, the logic above skips the
> > > idle CPU because it is still cache-hot, despite the fact that it is
> > > cache hot for p1!
> > > 
> > Not sure if I understand correctly, in select_idle_sibling() p1's previous
> > CPU will be checked first, and that check does not involve cache-hot. So if
> > p1's previous CPU is idle, it will be picked, no?
> > 
> >         if (prev != target && cpus_share_cache(prev, target) &&
> >             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >             asym_fits_cpu(task_util, util_min, util_max, prev))
> >                 return prev;
> 
> 
> You are right, but the "if" condition is the one prior to "if (prev !=
> target ...)" which causes p1 can pick the previous CPU here. However,
> note that it is not just p1 which can pick the previous CPU as
> intended by your patch.
> 
> Consider the following case:
> 
> * p1' ran on CPUX, and went to sleep. We now update the
>   cache_hot_timeout for CPUX based on the sleep-avg of p1'
> 
> * When the CPU goes idle, during CPU_NEWLY_IDLE load balancing, (or
>   due to shared_runq search), the CPU could pull p1 from another CPU
>   Y.

Agree, newidle balance could scribble the cache-hot CPU.

> 
> * p1 now runs on CPUX, and goes to sleep.
> 
> * We update the cache_hot_timeout for CPUX based on the sleep-avg of p1.
> 
> * p1' wakesup and picks prev as the target after doing wake_affine()
>   check in select_task_rq_fair().
> 
> * In select_idle_sibling() it encounters the following, which checks
>   out and thus returns from target.
> 
> 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> 	    asym_fits_cpu(task_util, util_min, util_max, target))
> 		return target;
> 
> * p1 now wakes up, picks the previous cpu as the target. However,
>   available_idle_cpu() is no longer true.
> 
> So despite "reserving" the CPU for p1, which is likely to have its
> data still hot in the case, we would have scheduled p1', thus
> defeating the whole purpose of reservation.
> 

I see. So you mean, although we reserve the CPU for the wakee,
the wakee might not choose its previous CPU, which is against our
goal.

The reason to prevent the wakee choosing its previous CPU could be:
1. wake_affine() choose the waker's CPU rather the wakee's previous CPU, or
2. the wakee's CPU has already been taken by someone else, via newidle_balance().

For 1, I think Prateek has expressed the concern. One mitigation method could be
that, we give penalty to that wakee, if it decides not to choose its previous CPU:

"
new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
if (new_cpu != prev_cpu)
	p->burst_sleep_avg >>= 1;
So the duration of reservation could be shrinked.
"

For 2, maybe inhit the newidle balance, something in my mind:


--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12022,6 +12022,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
+	bool cache_hot = false;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -12055,8 +12056,19 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
+	if (sched_feat(SIS_CACHE)) {
+		s64 delta = this_rq->cache_hot_timeout - sched_clock_cpu(this_cpu);
+
+		/*
+		 * If a short time later, a short sleeping task will be woken up
+		 * on this idle CPU, do not launch the newidle balance.
+		 */
+		if (delta > 0 && delta < this_rq->max_idle_balance_cost)
+			cache_hot = true;
+	}
+
 	if (!READ_ONCE(this_rq->rd->overload) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost) || cache_hot) {
 
 		if (sd)
 			update_next_balance(sd, &next_balance);


> To be honest, this isn't so bad, because we have been able to avoid a
> migration in this case.
> 
> > 
> > Or do you mean, in select_idle_cpu(), we will re-check p1's previous
> > CPU but it is skipped due to cache-hot?
> 
> I had originally thought about this, but then as you pointed out we
> have an opportunity to pick the previous cpu in the early checks
> inside select_idle_sibling().
> 
> > 
> > > Have you considered recording p1's identity in the
> > > rq->cache_hot_sleeper so that in select_task_rq_fair(), we can simply
> > > return the previous CPU if it is cache hot and the wakee is
> > > rq->cache_hot_sleeper, thus avoiding the whole select_idle_sibling
> > > scan.
> > > 
> > 
> > Yes this seems to be donable, and one problem would be, if there are
> > more than 2 dequeued tasks prefer the same (previous) CPU, which task
> > should be the rq->cache_hot_sleeper. And per Mathieu's feedback[1], we
> > want to deal with multiple dequeued tasks. If we record all of them,
> > it might be costly.
> 
> If there are multiple dequeued tasks, then it doesn't make sense to
> record the identity of the tasks. However, we need the bail out to be
> much earlier, in select_task_rq_fair(), perhaps even before the
> want_affine() checks.
> 
> After all, if the previous CPU is idle, and its cache_hot_timeout
> hasn't expired, and if the wakee's sleep duration is less than the
> cache_hot_timeout, why don't we just pick it here and be done with it?
> 

Yes we can return the previous CPU earlier, one concern is that, should
we honor WF_SYNC flag or not,  because in wake_affine_idle(), WF_SYNC
seems to have a higher priority than available_idle_cpu(prev_cpu). Say,
if the current CPU has 1 running task, and the previous CPU is idle,
wake_affine_idle() still prefers the current CPU.

thanks,
Chenyu
