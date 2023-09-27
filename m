Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B467AFD19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0Hxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjI0Hxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:53:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44CBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801229; x=1727337229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DcXHyCO5j3RUIcNHILdnxwgTmKKNIxsyPlASeeCzVps=;
  b=B66CZUpfQsNS+OSBNseLytCrFo8w95+zZqVeS95MeXNs/xn2U29oISuC
   YXjBoRUzFnB2l1H3lRWXYhTNrw0HjYuICBiRqS+e1ZaOdSI/tuYbrIr4L
   qBMJ5WD+vvCT73hyZOY24TwdRI5nmSihXD9NJQ6HWExiVXrWk2xfwGZvx
   Vm0zz6UiyhVed2MrHDRHtIb4m8o6JpWIPI9MFWwz1pWe0aGFSRWPhDNTO
   nJFcKS0+bpqH1mMkrlkWeTtthLarO8+JdMpQMiQwalSnBpw6eyPuKQrkp
   FoACcc3/PKser29/43yptcP/efHCV03EzJhBOqZCpakGUDSPTaWaJcxRg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372096105"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372096105"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814775133"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="814775133"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 00:53:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:53:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 00:53:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 00:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJqCDLfHcR774Ojqoasmgb2DHggTxIbYKatMKhacGe8TxjBguwyubXq9+OtXGjbFr9NRJXXPM89DJEyHMVoxn0HYlCwgnOfirCsctaGFt6TsZaLmGZMgGW9s0NSZvXlvJ9Fz9VTd+ymc9K2zqdr5PMEAsSlBKxMSuvsVT0KwUQ3I+yCAMu8wqsWhp2Gkf5cnXhCH8XHxYQ1/JRl3oR858zR/CVA79t/TvOZRZhEvr/bI8G4k3OE1o5w/WQdg1c/5PSwpFUW3ySykc9psP8jFVPgikf3+Htr4ScrdbmJUhW3NnKWv77hiqeD2AMyUca6XYVSUbPq8O7anOSyiUeOnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki/CSxzI/FmM2qmVaYzHoAry1IBRxEc/kMt8fR0CwC0=;
 b=PCcvCu3LihBCpOa8SDufAxIkthArxqEbVKXWp+wMkK/3sogH0D0Cwhbb3baase+UMbgB4DC5fUA3MfsD5aUuqK0cUzdU3nsUyUAEKN5nxDuNLi9AiEXkIFbv2wwTIWIV+6Y4DJPgxy3ABLOBL5Vm0l+cKgeLShzSKhWst33K62i7FJA3iwtndBNE8Brl66lTctySlF7vs69iyCqbctMgIvz6otxJQRhFZ7lCVGsPgKgEe4KJsdDwwKnSv6iWU4/yYN2HBt016/10nWluQnXxPwVpMT6OzbQjvl2t6p9HOerNqVc0knWVLioJxrE4DocK2IELdemwJXRpPJlHC2fDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Wed, 27 Sep 2023 07:53:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:53:45 +0000
Date:   Wed, 27 Sep 2023 15:53:33 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Record the short sleeping time of a task
Message-ID: <20230927075333.GA210077@ziqianlu-dell>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 8653f3cf-4db6-41d2-28cb-08dbbf2edff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr3wO1ZJU+TO8rTcib/RNHz7noOZXO1Siq3DvvapAJgYQxj0RjEw8JDQgOp+WTV0LJrg2OvfXOUIAfGP0vl1rNgvLA0GAx9lMpsX0QgFpwbr0XnYvpc31l/m8j82RsY5vSpLaIlhib1JGrPVTZUtTwqSCNHFHIiy7Seg2EkzsXWxyOL1/0rIRZQPE8B3ZT0GGUi86JAeqsJuBL7lXbQlisaYs8vMk/F7fdPai4WLdKVmL+Q3IngTP6u6dfNCfH33u9QSXbITQqdMdizJp9DLu7PjGYkgbDH/j6Ci1TShzYNa5KLy6FRV+7Id1/d0VYDspsN7TkprOUkYIo32GPyflh0FX3KRNtDw03upsArd2OpW2qs3DA2swmUu0TMqtgtn3z8CwSgykLV5W9qZ7gO9RsVESOCLHhk5mBUL5K2M0dFcf6fCWIm7Sy3KULgcRbkU7JGlevIvaXlTZixk+S3b9GnzPifPX5rZqGVCLVvgwjRbG9mhEdD9KPplVwxBrVxnY//1n7/vUjUUTA7MpBjv4TBmTKOYJ2fNqI2rsq9DcBU018YICtF4FYHPhSKtMz9B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(9686003)(6666004)(6512007)(478600001)(33716001)(4326008)(6862004)(316002)(83380400001)(5660300002)(2906002)(7416002)(66946007)(66476007)(66556008)(8676002)(41300700001)(44832011)(8936002)(6636002)(54906003)(26005)(33656002)(6506007)(86362001)(6486002)(38100700002)(1076003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XotLNL0gDIs5IQHr3CYFY1sY6DtNqql7fBYKcqQi5TUxmzYJpCHabCQNytWX?=
 =?us-ascii?Q?lO5fKV6vzjE96eQcraxK6Ro1WByxKNxZLwfYVrvR1MWZRhgnEb4Zef5U1Xgf?=
 =?us-ascii?Q?1pThTWS0Qd5KpbI9TtPGRsgnanZlt3LGKUIyB6G5u0j8ndBIXnEibJnEaIT0?=
 =?us-ascii?Q?g9FJVYouJkAF54yX3uS74EIm9Xiq9XbTAIhPS2JjZrwJvie3FB/liGcC5iAn?=
 =?us-ascii?Q?LHkDfq0+27ZvqIkyufxgp2qimT+eOfp98gUXGfDGMc5LX+naLL/93dhCjm2p?=
 =?us-ascii?Q?zEzx6/dSurxSiJf0zeIdcgDhG1D6lY7c1WHK2FZ1NpkMvK+kG4jcLIUQRyHy?=
 =?us-ascii?Q?bwG9pfcLECj/NhpRy/sb43jLq+QXShJhyP/SaoCCo6N2snmoX6zxvm51KT2j?=
 =?us-ascii?Q?gua5R7EkhSuVQZgKhcn8u0TjHru67zjqnwjBFPm6U5WtWsUqA4WfB7QPZqxj?=
 =?us-ascii?Q?YU4cK+RXfGbAruSTDQC1ijk8NLtIZOXkaZceIETI1BENNbF5rIGQf+5/vLVm?=
 =?us-ascii?Q?4OwYZwbYZdEdZ0VKLgKQYE0dtxKLB8Au3fDKwfxikOPTfU6LV+8xjwE5p0gy?=
 =?us-ascii?Q?QIV+/6lUPIDWm0YnG1LSSHBDof8n7x0Ld2gL/oxjWwN1Ub9GWve95Mk5yiev?=
 =?us-ascii?Q?SzH64A5QN2BDeo3YWFWPLmcxQWfPvTWQmnemyrQtYb62889YhjY1cYue1zkj?=
 =?us-ascii?Q?NtHnWIMEunt2dnP8l32IOxzB1uChqkY7SQ/eywirkr8N7+s9AUVhLfnmf0yB?=
 =?us-ascii?Q?HP/3quoEbhU2iutWcfmyfwG8nVZTOoJM5NbQRoURwwwChm4o2koFQh5RM2QH?=
 =?us-ascii?Q?LLQzC4sI6LkfH+KMXVcRxH6i6s2qYZqU6uKfttPdEJC0Sjk58B1POrmX/8Vz?=
 =?us-ascii?Q?C8c/s71W2bO44cHRO4XaR3Txbucb9dEZFMh9ldkRyRskcMq5uzYaEWDdS7JY?=
 =?us-ascii?Q?f1WG7n/yQ7RhhOf3gjT51pRLCKADbzRBvSqa8iJPy+hnqoEDXZAkKDPKxZHq?=
 =?us-ascii?Q?JJt5/3AUo70QUJmicVksIGuQl4g4UWjuZRwA0cy9aM/1Ie/Pws4gHbzqpfNe?=
 =?us-ascii?Q?pmtcAY1JRm2Fg/llCkKVBv3zYLFfU/+P0knoi07Ho2Fa1im7AATiF3IU0UK3?=
 =?us-ascii?Q?3iT/3hDyUlew4TeHqJXqOnRcwwWkr+UjunNMEdgSQ1B9hpVSdZa7gSi9K1tf?=
 =?us-ascii?Q?F+1m0Ck1DJ45MMti1+OuuyNLUQnfeytysoSwxI3JiTjBiIKJ1rOdJVMAqL4U?=
 =?us-ascii?Q?Z2pXmW9vGHSuSMCOQtvERVDURE46vuA/eGO5cKCn2mDVHmNtrC0sLI+CuTlr?=
 =?us-ascii?Q?NVTcJ//WkmUgNyOW5JKQGiSUkts0Ejzs58lC4fBBAgXhIsSHdTb39LukuUY5?=
 =?us-ascii?Q?25CqnxbYuqzGuRKzbeNad1kJoCYay0VhFF0F9Sg20+2LrI4WgYBV6ZAf59XJ?=
 =?us-ascii?Q?YC1uJncxqG+NPtHlJCW9rhyaoKBOeHMA08uiLTzH7UlS2t59tgG3dgsf2ruA?=
 =?us-ascii?Q?XC7fiNqx98shwB4lQBcU5pWkrlComONOBZdJdsl37ts70k/Di6lZrSoyw88o?=
 =?us-ascii?Q?fOLBfjgQzjAubBDN/M485X+PXdTgrT+o67lCcTmr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653f3cf-4db6-41d2-28cb-08dbbf2edff8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:53:45.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6SY1cuSQgjN1EAzyWxG+pjvEScB1Nw/Gta3NCF087EyET9SLEYttpuRYBdj+xtTvpw/jLlLB2FzomhygOcQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:11:02PM +0800, Chen Yu wrote:
> During task wakeup, the wakee firstly checks if its previous
> running CPU is idle. If yes, choose that CPU as its first
> choice. However, in most cases, the wakee's previous CPU
> could be chosen by someone else, which breaks the cache
> locality.
> 
> Proposes a mechanism to reserve the task's previous
> CPU for a short while. In this reservation period, other
> tasks are not allowed to pick that CPU until a timeout.
> The reservation period is defined as the average short
> sleep time of the task. To be more specific, it is the
> time delta between this task being dequeued and enqueued.
> Only the sleep time shorter than sysctl_sched_migration_cost
> will be recorded. If the sleep time is longer than
> sysctl_sched_migration_cost, give the reservation period
> a penalty by shrinking it to half. In this way, the 'burst'
> sleeping time of the task is honored, meanwhile, if that
> task becomes a long-sleeper, the reservation time of that
> task is shrunk to reduce the impact on task wakeup.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched.h |  3 +++
>  kernel/sched/fair.c   | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index dc37ae787e33..4a0ac0276384 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -561,6 +561,9 @@ struct sched_entity {
>  	u64				vruntime;
>  	s64				vlag;
>  	u64				slice;
> +	u64				prev_dequeue_time;
> +	/* the reservation period of this task during wakeup */
> +	u64				sis_rsv_avg;

Nit: these info are only relavant for task, not group so might be better
to move them to task_struct to save a little memory?

>  
>  	u64				nr_migrations;
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d0877878bcdb..297b9470829c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6456,6 +6456,24 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	struct sched_entity *se = &p->se;
>  	int idle_h_nr_running = task_has_idle_policy(p);
>  	int task_new = !(flags & ENQUEUE_WAKEUP);
> +	u64 last_dequeue = p->se.prev_dequeue_time;
> +	u64 now = sched_clock_cpu(task_cpu(p));

I think cpu_of(rq) is more clear than task_cpu(p). Using task_cpu(p)
seems to suggest task_cpu(p) can be different from cpu_of(rq).

> +
> +	/*
> +	 * If the task is a short-sleepting task, there is no need
> +	 * to migrate it to other CPUs. Estimate the average short sleeping
> +	 * time of the wakee. This sleep time is used as a hint to reserve
> +	 * the dequeued task's previous CPU for a short while. During this
> +	 * reservation period, select_idle_cpu() prevents other wakees from
> +	 * choosing this CPU. This could bring a better cache locality.
> +	 */
> +	if ((flags & ENQUEUE_WAKEUP) && last_dequeue && cpu_online(task_cpu(p)) &&

Hmm...the cpu_online() check looks weird. If the cpu is offlined, no task
will be enqueued there, right?

Thanks,
Aaron

> +	    now > last_dequeue) {
> +		if (now - last_dequeue < sysctl_sched_migration_cost)
> +			update_avg(&p->se.sis_rsv_avg, now - last_dequeue);
> +		else
> +			p->se.sis_rsv_avg >>= 1;
> +	}
>  
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
> @@ -6550,6 +6568,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	int task_sleep = flags & DEQUEUE_SLEEP;
>  	int idle_h_nr_running = task_has_idle_policy(p);
>  	bool was_sched_idle = sched_idle_rq(rq);
> +	u64 now;
>  
>  	util_est_dequeue(&rq->cfs, p);
>  
> @@ -6611,6 +6630,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  dequeue_throttle:
>  	util_est_update(&rq->cfs, p, task_sleep);
>  	hrtick_update(rq);
> +	now = sched_clock_cpu(cpu_of(rq));
> +	p->se.prev_dequeue_time = task_sleep ? now : 0;
>  }
>  
>  #ifdef CONFIG_SMP
> -- 
> 2.25.1
> 
