Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5FF7BD2D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJIFgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:36:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DC9E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696829795; x=1728365795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c79x3oWoFrS5Iag8aXiVJE3L5MyE4FU6TNBwqwIORQE=;
  b=Wt5Ma+9LgYS/yyAdMay6AUPCAoZI7v0Fb5ccIsRGKRrU+NkHQj9o7dGS
   6bgky5lsG8p9itGvb/fO890iRSOrtV7gFRryBE9OPKGHvNSnbbfzh+/Rt
   oskNNXLGAh2cSP6MYv3uZYReMoEraX5RFYwpWXgFwQc/i/k82nxoVLf6G
   o0lmccf87PkcGaARkMTHbZWqjGa69f+5AnqZcgzugxbkcmQ9ljkEGAX4F
   SSMGI6SLJ8Lss8OayyvdzbcxMpuT787CG+pGw0PK98gecDbVMWDcxOl1W
   +0075fH1EHaupRxHRK925a0Vk0+n+NzbMPzNcoS40fllWqfeUzNzHz9II
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="381337531"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="381337531"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="788047182"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="788047182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 22:36:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:36:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:36:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 22:36:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 22:36:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDoNW4gkcjGtl8aB26kswWcx5phRYMOYn+NHcnIXQXLuDK+dBtx9AOv8+wKGJgextT/4pYb8CCSU7L97bWHbyrjcPlwcZBy6K3uVPbfDJ+Bj5+K5EhLfRhMC6xs69KgDWm/SqVsR93YPMiv3OGUepWmeIb41i+sa86eM5Y+wRxz76wG9vhzZODb1xxPtL2LRmdLINfUeh7lMjzeDJ5NN99WwDYtZfakdgHZgtQ21eI1yFGs/ungdnUvu4crXqI07uqnCt8nxpTBNmYF332nlFnsMrfIKoAW/ZqPofd/fxxZubkEboA122pRz20zj2uQlXACoGlOZ8MvJbXXGkAUDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbtefPa+B2iIJY4P50lwkzUPvYjcE3+zVxw61ctd9Ss=;
 b=gM7t36oPHJIWRSZnaxAZuhYJw9FnKTu15p+fggb3oQQlrkJdKOKvrCZk2QKmNmlXCHVwPiXEmhC2KtDLEgilKt+uA78JZki7Fw/t4fUSt/Sey7rA00WGRSEn+gl7zGET/0y2nhmhKbmKv0gcIKZw57Pk9WtoutL3LBLunVcOD/DSIsNoprdCm3t73x5zs/pPEnNtmOgWNj/kCi6BHouh4K+6vTj2AvbDDtwgSESLQe27G5zU7FULKfQiFvHS04nbyb3K7kEd1SuoUklV4ULmIJwDJ0IcV+EkHvkMQewQ569UNcn+58PkLEM5Jhujo+Hb0aOJ6WAHqAgtfD0TgjqZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by SA0PR11MB7158.namprd11.prod.outlook.com (2603:10b6:806:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 05:36:30 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::413:a622:bff4:bdd6]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::413:a622:bff4:bdd6%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 05:36:30 +0000
Date:   Mon, 9 Oct 2023 13:36:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Message-ID: <ZSORUczD6tp2fbe7@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|SA0PR11MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc04e9b-7c47-4d08-54fd-08dbc889b08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+qWnzFU+eTsvkIDU1X9d3La5aITmeNcq7VGgHAXayzTFHKvq3gQ/5RJimEGTkYZ+3dcJ/jx6C+FDHXE4fPjgCjx8wPYlf9iTRXAmcN1vyR6gGk1xnwgVmMBs6AOkWFmGTkrViFCoYOuzOiJ3PDCq4a9QmY0VvpHQY6rBKTpPq3FjTfcNrLydGvm2J9tJ9uodLbM3PXA6XZYVjKFL2l5YLShbjDL00/jbNmZHHoS6ltuWaLhhcMv5DRpj5eJ0uiP4xsrVVumSQCc4GRZG0ktNwBqW21WiNyA6vc8fPwLjsv+JHg81cpJSdfR/dSyhsxx8vGD0M+g/7Qe471dykDBSTrI7eO99ytFTGzJ5lzrNVEgzCeP4/UKOi075fg8IOykqtnfMvY23Noti8udmVwBgH7b5eo2gePqpaB/joMgO7AVGlUVCsmYsNCEXKdEZ7DzkfBBH7Myi7pwMUXNLJcDzMxJd/H9oRA1DEIeyCnhCgAdF4suzj2MXaPSa1FfeNnTw+Eq78Vbqb01hG/ms2DocAD+5sWuz3HSTUOzFX1K2/fRRVPIYZASzoMBpVELNr/u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(82960400001)(86362001)(2906002)(6512007)(6486002)(478600001)(41300700001)(8936002)(5660300002)(4326008)(8676002)(53546011)(6666004)(6506007)(83380400001)(66556008)(66476007)(66946007)(7416002)(54906003)(316002)(6916009)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BsvYgd4xHp2r/CAovwVFp8ywJPGFBxDYbK3icBtq4Djxj/CAabaICYIgDIsA?=
 =?us-ascii?Q?yXrXPp+CI2aKNol2cEV/OczNeNu+1tJz36L3ZgOyhp7BaAYTHAnpPOBGzOYy?=
 =?us-ascii?Q?AN627HvoTqf7lUjplRt9jvVqJRbsZcUOzEJJ0uixTTR2qCm852w/bGRGlQuF?=
 =?us-ascii?Q?8MsM1uRFqlIkaHbIR9CWyUxyMTHztbl64p6f5VdRsbExpV1JaAKH45njf9Zb?=
 =?us-ascii?Q?Uew5qLAG3ICyawrEJxbmCCNmKhPl2AdOasQUhABCbZk5mvp32KPyWtWvNTrT?=
 =?us-ascii?Q?u6sFvYzkmfYJtn/BMxn7zt+HDduevfjoxD5KxsEgNQ1tnb0TGCEliSMCfL+K?=
 =?us-ascii?Q?rCIKUHdyDu/P5diaDhGcx/0RO/22CXMY7di5ecv3xmzfa4Uml7cCJtIejIrm?=
 =?us-ascii?Q?kbQhVfmQ8hQ6tUGTsBS2Qp7KcPFT0KNgx8o+8DuLp/aqSf/nl9iKfN7Oz5dR?=
 =?us-ascii?Q?rVbZdu7bHk11EDqYQDC2NB0V//BaHChhoo80X40fTPEIqtz624MMQ9udYy5o?=
 =?us-ascii?Q?BkcqOB1qj9IGpVQl2cUve8cUfgOm9Aj4YZD8BdcUgiQxaRkUeK5KFiOYBNbL?=
 =?us-ascii?Q?ohxhT2TezWCnD1E1qtqEG5tJCn2wJOQhgR7qTEFtx4JfyxsvJTpeloLvTCI3?=
 =?us-ascii?Q?uhBQvhGHNeeW8DPNalQa2GrzlrmugzFNlq2dH7+z9hzC+MoC7ILUKjDGWvCI?=
 =?us-ascii?Q?efkicvopEpIicYQevK4Lfk5R/mC1811hYZXEgg250JvlIQJa+g0EVdw4JxWj?=
 =?us-ascii?Q?ZNo6h3B3YK+B253pIeEyg/5B+cVeyTtjZH6nzBDsPq8Ase3aCRSTDV+8fORo?=
 =?us-ascii?Q?RnuIfGbDnwMl/nNk6RbzLZ+2HPXnDMyYS1Z61xL2oiupYyD3IiqvsApRfkVz?=
 =?us-ascii?Q?m7Yc2LDvRYU+nsXdH/lTih7LvkWMUEc9YfWrvpUlMHlF603fzWAX7+sC+OBa?=
 =?us-ascii?Q?8F2dL/CdS2Y9bixO6crrjNH5t/EDOCbiMsK/JC7+/e6HjwPh4KtwOxfdU6D2?=
 =?us-ascii?Q?WCeJGBQEifDSzZ4HY57g+ela8qDNsHVRtr7xv/mYuQQXbb8Vuq5Ele/FcnYt?=
 =?us-ascii?Q?DSaJ1n5M1eTHR3cnpKhShWj3EorzjQaQpwIsCvOjhvEmGvSSyWBvLnKLGNhW?=
 =?us-ascii?Q?LzfY9t/OZicsCObdio1H2z7hMQzUvUV37MIRqCLwHeConrE6dIisA/hT0RBZ?=
 =?us-ascii?Q?78xGQ971N9rfs3iWJR4sQJOp67nhNuNRWjf6YQTvFTF+0kHS1fp0nNEy165B?=
 =?us-ascii?Q?Q7KXNYLsdtq55ODLCDJGZRVEap2Kko0SO7strhu/FQEDJfBanSovU5Bnvpg1?=
 =?us-ascii?Q?5ng5LQgW/Oj/0Dz1STyoo1dHRv0WRmXgoGWoo81Z9PT2A/KssUZEkj91L2QF?=
 =?us-ascii?Q?pYnP/pgWVBN2AK+htE0BpFGPlOHunJ5dA+vPHf/AESmOPBej0I7roSk9Qi7r?=
 =?us-ascii?Q?IDlGOasyd5apFyUY3B0kxNozIbj9OkrYshbJMqwnGaM0+zGJQW73yFLKrYlw?=
 =?us-ascii?Q?CWKEO98J0UmzgDg/cF0A8PZR1kEc+1mCo5GsLjkt81ROzLPEa9R0oxpl8mgS?=
 =?us-ascii?Q?ooXmeloHG062kEjLvAFtfVjoamKkGnP81YMofbS1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc04e9b-7c47-4d08-54fd-08dbc889b08a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 05:36:30.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnErhQUTCXCE0BacSDwjX26lfgwd5kHoJkBRGEQxtAg9/ntwRyLDxAhBFZiSADR03+BaGL/nQD2wJJ7W7YlH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7158
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> On 9/30/23 03:11, Chen Yu wrote:
> > Hi Mathieu,
> > 
> > On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > > Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > > select_task_rq towards the previous CPU if it was almost idle
> > > (avg_load <= 0.1%).
> > 
> > Yes, this is a promising direction IMO. One question is that,
> > can cfs_rq->avg.load_avg be used for percentage comparison?
> > If I understand correctly, load_avg reflects that more than
> > 1 tasks could have been running this runqueue, and the
> > load_avg is the direct proportion to the load_weight of that
> > cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > that load_avg can reach, it is the sum of
> > 1024 * (y + y^1 + y^2 ... )
> > 
> > For example,
> > taskset -c 1 nice -n -20 stress -c 1
> > cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> >    .load_avg                      : 88763
> >    .load_avg                      : 1024
> > 
> > 88763 is higher than LOAD_AVG_MAX=47742
> 
> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> but it appears that it does not happen in practice.
> 
> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> does it really matter ?
> 
> > Maybe the util_avg can be used for precentage comparison I suppose?
> [...]
> > Or
> > return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> 
> Unfortunately using util_avg does not seem to work based on my testing.
> Even at utilization thresholds at 0.1%, 1% and 10%.
> 
> Based on comments in fair.c:
> 
>  * CPU utilization is the sum of running time of runnable tasks plus the
>  * recent utilization of currently non-runnable tasks on that CPU.
> 
> I think we don't want to include currently non-runnable tasks in the
> statistics we use, because we are trying to figure out if the cpu is a
> idle-enough target based on the tasks which are currently running, for the
> purpose of runqueue selection when waking up a task which is considered at
> that point in time a non-runnable task on that cpu, and which is about to
> become runnable again.
> 
>

Based on the discussion, another effort to inhit task migration is to make
WA_BIAS prefers previous CPU rather than the current CPU. However it did not
show much difference with/without this change applied. I think this is because
although wake_affine_weight() chooses the previous CPU, in select_idle_sibling()
it would still prefer the current CPU to the previous CPU if no idle CPU is detected.
Based on this I did the following changes in select_idle_sibling():

1. When the system is underloaded, change the sequence of idle CPU checking.
   If both the target and previous CPU are idle, choose previous CPU first.

2. When the system is overloaded, and all CPUs are busy, choose the previous
   CPU over the target CPU.

hackbench -g 16 -f 20 -l 480000 -s 100

Before the patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 81.076

After the patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 77.527

track the task migration count in 10 seconds:
kretfunc:select_task_rq_fair
{
        $p = (struct task_struct *)args->p;
        if ($p->comm == "hackbench") {
                if ($p->thread_info.cpu == retval) {
                        @wakeup_prev = count();
                } else if (retval == cpu) {
                        @wakeup_curr = count();
                } else {
                        @wakeup_migrate = count();
                }
        }
}

Before the patch:
@wakeup_prev: 8369160
@wakeup_curr: 3624480
@wakeup_migrate: 523936

After the patch
@wakeup_prev: 15465952
@wakeup_curr: 214540
@wakeup_migrate: 65020

The percentage of wakeup on previous CPU has been increased from
8369160 / (8369160 + 3624480 + 523936) = 66.85% to
15465952 / (15465952 + 214540 + 65020) = 98.22%.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2a69af8be36..9131cb359723 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7264,18 +7264,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, target))
-		return target;
-
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
+	 * The previous CPU is checked prio to the target CPU to inhibit
+	 * costly task migration.
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
+	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	    asym_fits_cpu(task_util, util_min, util_max, target))
+		return target;
+
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
 	 * kworker thread and the tasks previous CPUs are the same.
@@ -7342,6 +7344,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	 /* if all CPUs are busy, prefer previous CPU to inhibit migration */
+	if (prev != target && cpus_share_cache(prev, target))
+		return prev;
+
 	return target;
 }
 
-- 
2.25.1

