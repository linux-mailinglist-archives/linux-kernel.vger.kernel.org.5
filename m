Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0C79DE66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjIMC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIMC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:57:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569831719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694573863; x=1726109863;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MjMUF9BiA3lLKVMZvZmDGh/ZPURGDHEABm0wtkAFi+A=;
  b=BgJK2KauaVh0QBSyuxACgUggqxzuAHYeUmtWD1HHIVYeZFjcZtyZnT2X
   JUBYRyYOaVK3H47ovofhZ6l/KNRgonO8zY5oK82WcypPlauGlQ3KL8bmb
   +6BWU1ZF1Sli/TBCRaSDsvi8jVrgkiGt3r7c+WZGlQWQeEhX9E8tBdJyV
   AsIS1cXk7sMcFn+k96crI+48qWh/SgI0pqtjusmITkvFXjIsXAfALypH9
   W/02TJS8276wUb0b3GQSjaP0hDfugwN56q8KSR2KBUCPax7JDNZVzDj/1
   xUdGC+lweg+IEjz7wZi6RL4vKI7/tgmr08e1tQgHT6iPdhjm9mYwuDPJ3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442578472"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="442578472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773266790"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="773266790"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 19:57:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:57:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 19:57:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 19:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5zaCaYnpB5Cl1HjN+Xpy5yi9bTxH++l97vdUEbjOvoaycA12nVihVdJf88RiMmv7g/NAIcGX1SE7A6MHdR0s7nCjdzj9ZlPm784niSehEvFROWECYXZrFfumQNnIyWYKFb+3lYeAzWFkDv7101jy72J8Kinz2ulCKTE8RRcXMP7c7EvWNmW02YRWoMj7Dc5mKhIvB+R6Vl4tERLQ7U3zVfzzkSScokvr9OCL464YBhM2I1zUgytOqOTjkDRUrVXRPzktvdMpI9kqSqdFl9rswjr3SyP60hKme424a6qd1F8CBA7QGJpvc6VTB5/lQCQ4fj24MMJH+J/datmSNrOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7YijSwWlqAPUgitVUhyAlWpx7E1ZlVzUtjQjKUcn3g=;
 b=UY5OkW3MapM26XKBoK/HI9UN6ru25RYsrMthptbSZm5D0oXaykbam3l+0N3ydriowaMJG8c7cPfOvdbrFwKB7DUTRJDd5h71lVs46fo3z63ZLig5/GX9cDSxv77U4hRkOBVO7h5HBb0dEszjewOX74T/nkdyCyi7fPZv/sJkuk3JQQMjk2WLlq2r2z69e1dgnOSK86q1c6kcjujV2uD6VnXXEq7ET4OeodB3QuKIjMfwg+qlz6so9WTwdXuRlb8I0lGDdH8CaPQ5PC2OIkPA4oGlggIrEqwIbn+tnm5B6ezhoyR1/HFyJq3KpZ8egFRuFYJH8hlwPIWXYaDvHXs35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:57:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:57:33 +0000
Date:   Wed, 13 Sep 2023 10:57:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQElEM5GAn/Vq0tM@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
 <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
 <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e169e91-7f37-4533-eaf6-08dbb4052cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCs3zqB5fvuYE+vc1aFSikKSIVZvwhuzfQe4u+hOG/0KjSe/M5Js8i5pv/b6GwD+15wsFHMQJuKlspweqpSbwW0zq+Fy3pS9awANGEMaerSwBOibw6VVPir6QtOA+ZwcfjxgWMKVuFB7x80VvIcyN8ga63I5jGMDXs873Jy3/Q+BMZ8M7lK8zSgAilYlUpRkL/GKtol4g6aH+K2Nl+nran8W4ZLBgxf6tabgqO192bEYeVLN7dFmUiavQj3X6lUyWFGcUoN+c3R38yXl0i7SC2IqsJ/rxcwzbl9l0pDoR1QbIliAREN+vy4fSiAv6/NBbssv1NamePtQLwDfAPUJm2Q9/M94SyM8QuQ7avyvoN7lxRj2n66Xb+ejrCraTusjwg7CoHDqxnsJ3gXdsaQ6DnbNCJW3VXa2xH5ZaI+3OWOnJ32am+fCj8VqKCdgRiBqDebcnIwTkNQx/82e9uoaQT0kodcCI4CClv8DG3FbGcgc/FzcTSZyAj/0UnAVaZvuyJKFWJJgrcGSOUKIjW9nNSDOvDDRt8Uz6WEdhzsVcVJadvfyMlS3zJz6ssYiCimu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(8676002)(86362001)(4326008)(8936002)(5660300002)(2906002)(7416002)(6506007)(38100700002)(82960400001)(83380400001)(53546011)(6486002)(6512007)(6666004)(478600001)(316002)(66946007)(6916009)(54906003)(66476007)(41300700001)(26005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TibLvM6S/ZgmT7tp7j7BgH4DCkYgSnex2fYQj2ouEs1c2MwB4hLDc4Vv9UMA?=
 =?us-ascii?Q?b1+5KT/fINniEmtWFam7fxU9N0YBq3OuJ+R/QNLdWNV8Qh4Le7VsJZaAJaIw?=
 =?us-ascii?Q?Vd/jROO1hG9/RkC9GTGVpHyZOzcUQVHq15iJywWFobesKJU8C1iWQm2FEEAb?=
 =?us-ascii?Q?Cl/DKzi6j6os1fkNP+mfD873rb7R/XUtW3IfZgRm1Ql1/JjQhlvSV0yAcPkz?=
 =?us-ascii?Q?L6IjjuBGcK0GyEhoB0yWT9822LY6AdqPe63mOJGwMQ9Sm5Ekkh+HiRPsEMWD?=
 =?us-ascii?Q?gGy1cMQauGYey7tE3YPQFQE70IIEkgWoiXS8J/zVxFfYOV4VTu+psajAz2AB?=
 =?us-ascii?Q?enUGQoi8nxeLhXWqoW1hCyCSPmW8LvArZ5q7+pAUisQxAy07x8nxv6Zj0oZm?=
 =?us-ascii?Q?SwAjpcCiNgL+ORUW2TUEmaNRIuDPNCfE8vMYQG1es6gIRexwO5/OOLMo/A5y?=
 =?us-ascii?Q?nI+zofEtkstnkfgJZXD2AiRYUbtzV6aU8+4Y+8ya5oTdZK9c6YYaZvMDAGQX?=
 =?us-ascii?Q?1mcqAb78fI7vGVFR9iDq0HT65BnmzYX8QurnEk5/DzNplT7PZZkCCl9fQnn9?=
 =?us-ascii?Q?Ybp7s7sjeoKy9fjSXMiXNSwmX8NnuYmSC2/XGDm6RKxCulTCKv4krOV/KQ+T?=
 =?us-ascii?Q?wU67vEF6lomzhtJNeZc3KhghHkgru8LrcqROx0wj+k54MZszl984q8LctDAc?=
 =?us-ascii?Q?dReqRU6UQLBui1/g/NpX/4CCe07MalLto0SwrRTdILoGy2MPoS4UYuNfJGjp?=
 =?us-ascii?Q?L/374t8dvCWEVMjcSrP1MCS0/L5s6lWIETxb5BwED94pM5CYcAKSTz9ZrAze?=
 =?us-ascii?Q?jB78LCBAUo4pCx9JHVkR+txNf5NOvtVaeWdZ8LnzsPlnUJOoW8J2vqtX8JIn?=
 =?us-ascii?Q?aiAzMbs8ofZWQY2LY2/qB8yZMw/v3NJBujZ+T1RZuQaWk9fIaFkecrmr23xU?=
 =?us-ascii?Q?+bkBCoEpMmJ8jBSp2dPZwdJJBad4kX5k0idyDI0yM4i4w3PEW6LdWfW7Wg4c?=
 =?us-ascii?Q?c16qosh97Jevi6cJnW0DvL/CYRCKpZUg4hewFKVdboEalJwH3eIYhqeHWrwE?=
 =?us-ascii?Q?/L6jK2DGlWi82dVqShkPo2CFmrantlRWaAYqampuH9wFezsD/dQMjCR671Pu?=
 =?us-ascii?Q?vo+nt/7wRv0WtonLWePnQVghtTVMxwv7zhBT2abAryVtL3hVZmgDBTgVCJIF?=
 =?us-ascii?Q?ZhPXgfOXDMA5hHMxGk5V3Gd6YTfraF7n8i7ze545mgh+Flhp2cei57PAEExM?=
 =?us-ascii?Q?OEvKotgqE4NHv+17Y7fN2ZoWLK2AZHsuWxmoDoSp+3NLeAUGkRLbTSbZG/5t?=
 =?us-ascii?Q?NtkI9Pajv9gS7UVImJXY7AogUDbahB+7bD/JsmGaNReaMfDNmQRSXGrYSNLh?=
 =?us-ascii?Q?q1KcpP9ONQigYppYuhowoeqkH4D4v0TjWZIZP25nkHlOlUiHWCiD4xH03xVV?=
 =?us-ascii?Q?5hegplCdhT5+9HXP1p55Kh4a75UMOOv4yaXaijPEjC8vdRKjgcoBLELZ4Gem?=
 =?us-ascii?Q?iIRHcJnADDL59qgWiERjAU//TJbRTP3AUr5B4i0/YS/R0fGZ77l5fokD6bDf?=
 =?us-ascii?Q?xR7WdtTjpBK98Vd3XZtc9aRjAVDuFOxvCvKhyUYi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e169e91-7f37-4533-eaf6-08dbb4052cf1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:57:33.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOZQwUcGKETWpCwLWEJRvAf+q7uBY2eca9BaO1YX9bWRsNLKc2eHyK4KkRQ6izt5OYje3YFFWOOc7NE98O832A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 at 19:56:37 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/12/2023 6:02 PM, Chen Yu wrote:
> > [..snip..]
> >
> >>> If I understand correctly, WF_SYNC is to let the wakee to woken up
> >>> on the waker's CPU, rather than the wakee's previous CPU, because
> >>> the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
> >>> wakee's previous CPU. We can only restrict that other wakee does not
> >>> occupy the previous CPU, but do not enhance the possibility that
> >>> wake_affine_idle() chooses the previous CPU.
> >>
> >> Correct me if I'm wrong here,
> >>
> >> Say a short sleeper, is always woken up using WF_SYNC flag. When the
> >> task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
> >> and restrict any wakeup happening until the "cache_hot_timeout" is
> >> crossed. Let us assume a perfect world where the task wakes up before
> >> the "cache_hot_timeout" expires. Logically this CPU was reserved all
> >> this while for the short sleeper but since the wakeup bears WF_SYNC
> >> flag, the whole reservation is ignored and waker's LLC is explored.
> >>
> > 
> > Ah, I see your point. Do you mean, because the waker has a WF_SYNC, wake_affine_idle()
> > forces the short sleeping wakee to be woken up on waker's CPU rather the
> > wakee's previous CPU, but wakee's previous has been marked as cache hot
> > for nothing?
> 
> Precisely :)
> 
> > 
> >> Should the timeout be cleared if the wakeup decides to not target the
> >> previous CPU? (The default "sysctl_sched_migration_cost" is probably
> >> small enough to curb any side effect that could possibly show here but
> >> if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
> >> a larger value, the wakeup path might be affected where lot of idle
> >> targets are overlooked since the CPUs are marked cache-hot forr longer
> >> duration)
> >>
> >> Let me know what you think.
> >>
> > 
> > This makes sense. In theory the above logic can be added in
> > select_idle_sibling(), if target CPU is chosen rather than
> > the previous CPU, the previous CPU's cache hot flag should be
> > cleared.
> > 
> > But this might bring overhead. Because we need to grab the rq
> > lock and write to other CPU's rq, which could be costly. It
> > seems to be a trade-off of current implementation.
> 
> I agree, it will not be pretty. Maybe the other way is to have a
> history of the type of wakeup the task experiences (similar to
> wakee_flips but for sync and non-syn wakeups) and only reserve
> the CPU if the task wakes up more via non-sync wakeups? Thinking
> out loud here.
>

This looks good to consider the task's attribute, or maybe something
like this:

new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
if (new_cpu != prev_cpu)
	p->burst_sleep_avg >>= 1;
So the duration of reservation could be shrinked.

> > On the other
> > hand, if the user sets the sysctl_sched_migration_cost to a quite
> > large value:
> > 1. Without SIS_CACHE, there is no task migration.
> 
> But that is in the load balancing path. I think the wakeup path will
> still migrate the task.

OK, I see.

> But I believe there might be very few cases
> where all CPUs are marked cache-hot and the SIS_UTIL will not bail
> out straight away as a result of high utilization. Probably a rare
> scenario.
>

Agree.

thanks,
Chenyu 
