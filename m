Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A37B1577
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjI1H55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjI1H5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:57:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB53698
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695887872; x=1727423872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LBZOrIlMeHApCc4yvrCTGSBUMvzvW5jGGbAiNxA7mq0=;
  b=WMzWPxtDDKsx39NprTIYY+nOZmgTnYbO3uHEhj5gH4uCQ6U2wu58mCGd
   vejMte/u6uu4cwn6VbAWebfnjRGLGLniBVen7xdhwv/yAqOJZGIWRV+hC
   yHA+vKQEscXQZxeQ+NeOlPUHg22175LYV2x3cKE1cHHOHKdhEvDVavl0Q
   NN/wkYKqluln3YMOl9ajiSe7QpTaYZYR8cfXib8moMS6OmJn4CrqPriEz
   oRxIrOpGaKxVS66CkpkqAJelwTgb2wY+xZy8PsZx/n0rQcfQuoatA8yCQ
   oChgn3mvmVywgKSHAirueWaLMeQ6qZjdWUP2SOyj2HsfvEonnTTSSSt+u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384805306"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="384805306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819757770"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="819757770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 00:57:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 00:57:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 00:57:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 00:57:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 00:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5LRtPGs2amMpj0PLK1+yn4+G3RZinUqGW+cSiBm9oKyNwBaoKtiv0hfge/EFcDOZNJG4d4b18u5aYA8FwhgMhrXgZTA2hcPREgegdsF3h7fZ4Imx+E88XDc062BAwdy04f9JexZiKXvI3356OzyKo6YWVj9cr1LaLnz2wGtkWXqzviD+JboCdlss2tH0AWJdEulRuVcSx8Q7LVs5jwiCoYZobIfSkoSGYxrUm2Ox+SeV5S0CtCZu/R0wH1m0NOdv9MUPT3sR09JzUNwDEQEDszobSyjamp6LZrkPvsExdzex94G3Lnt/kgHumw/2CQO+pEfireLTuxEFyYvklBtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBU0EdVJ1xpS+DKVJmDQ+bwJ8sbmVit2528UlX/iAyo=;
 b=M7fKQlScCTq3rrRtqMjtEtpLi5M4QaPBs3Vd/l9t09zwGdVtqSmF8Fb0IYiciWkRYzNuuH6FOnntY8VyLLI2lI/Ybm8nfuAsKCaHmPrJ26B1LC6CLDRuYpngYBNODBr8CFg7SLfuc4rVco64kClJdJ5Ig/UbRm96kQRUFOaLNhf33fW1Hz6cnv/KY35Ry9T+VSYQx2Hi2E7ZIh2wo9IU/mulzCNZTWBF99M8OnoPlWOZdUbrxSn0doe1B0OMW7QXEoNrTSmWYWXV8V/OJ4RHUdC4edH0OgsoEvmOMbgp5/LunIx8Q9ksCVVZZxepKeFjcuUuM6j5w5/uRbf6DV6thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 07:57:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 07:57:44 +0000
Date:   Thu, 28 Sep 2023 15:57:27 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Record the short sleeping time of a task
Message-ID: <ZRUx587pxJkLOTOB@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
 <20230927075333.GA210077@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927075333.GA210077@ziqianlu-dell>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA2PR11MB4842:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1bce65-ae64-4dcf-f08e-08dbbff898f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18wArVyBTt/1WxCo0nrv5i3JOiDXRIPNjAIGIN2OB+HHoe19mhgARfbu6jnnAnoXitR2B6CQOf5vDaHxrDD13vVsvajxiZkUHstGEDUBZK1obYScAcV/pBWbHcBNhtheExfDZt9uEqYBDyxSvLWA5buiU/LuzJpfQyzu62e5kkkZeRzznw4L3wpVes9ziTyosf/+3OjgmPR1U/VcG6VCGb9gmWyVckS8ETeNOmStvWDnldM/c5DeKFPJk0sFtzNRb+zOmmIGcQ/p351tciecPcgQlpLqR/cMV9yj6pOCcgCWeAdR04rEPKEa+mPl3k2f1NYzFapQR3dMmkvSjs2gIVp/YaGOOT6d1ylgfei6PcT87C7qJHVeTLGGXmAJgkgF2bGEbTxbHTd+CRI9QlruA6x45YjCJ2FCEJG1IY2K6eMNzGme4cEI4/NVD3Sw7h7qpRD4Nv8wkqgHUfo6VhpR39M0i5Iz+JzHaLmwM91I56UltreOX/WkEQuCjh4oK2eYFmxKkqG7lUq38RIpf0mL7OrufcSZjCs3QR8RcImG1h96Ota43on4z2vP+15KkA42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(38100700002)(478600001)(6666004)(66946007)(66899024)(66556008)(6636002)(316002)(54906003)(66476007)(8936002)(6862004)(4326008)(8676002)(86362001)(83380400001)(53546011)(2906002)(6512007)(41300700001)(26005)(82960400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neWfajAEbuV9eJH7udDfL+9vXvWkEuQYBBAl4H6fKA1VWrYoe5XN2fNeLzRL?=
 =?us-ascii?Q?4EkfM/7IsezetCW8baqobMnBKwIpbjdszFn1FiKPaT6tGzi0WWFE2tW+83fQ?=
 =?us-ascii?Q?aMv51nut7Cy9R6LSfQogRDDyfWlmcNR9eG/lXDMkiTZYYUo7aJ2FNIY3hDRe?=
 =?us-ascii?Q?O9JM4EE5IX/nVIMi67EXp7IFHQgl73o2XLweUA3FsBAvKUv3gajSVuWG5QPS?=
 =?us-ascii?Q?74KeVw4u03VC3YudvWzmQ4MoHQRyBdrSRC6mUbyNBaPKaUT4FiMKZEeWgF25?=
 =?us-ascii?Q?IzRILjiyshqBtuKlzUeuLEGM6qV0hnQpdyAqTz7d1qSSRP8+pSU1SvNQjlHi?=
 =?us-ascii?Q?PrXnYmDJqGUaA66tJZThPHz0YnIyISGKq2dNbKwmXSjBjIFkXmgi2AXN3jjR?=
 =?us-ascii?Q?sK5FG6JoBCpOCgrI3OzK72WnsZl+Myebq7fZQEyGPzc0HixoSP15rVUyUEWE?=
 =?us-ascii?Q?G3USn87K4o5J0f6yU9jjoRDjgESh616q2HzSnPGBD4RQc0LtoEaLYtmGk1TN?=
 =?us-ascii?Q?uWVAf5mL40sPVb3vYo0NO30XauPcYxYdQ5UOJlUMwRNi6VGzXhdl4gnZzuOe?=
 =?us-ascii?Q?kr8QlWbGxt0NuwuBOcEYer3T97A60++wsvlgcgBHrzeww276ep1YCgl3qOOZ?=
 =?us-ascii?Q?aB6cX8sMseusNzuWQ0sVxlltJN9KWWmhXUyHhNVUNoNmQ20r6M2F9/npKDUz?=
 =?us-ascii?Q?GhdK/pNtFcFjSqTsdzBE1UZ+38KZwRwAddFETuK02txQoVdBnVIJ7cTQNl3m?=
 =?us-ascii?Q?eNBxMDusQEHtggrufxYuLpHkPwVeyPs7ilawXiO/HV/hBVlIj2SpZldv19Gf?=
 =?us-ascii?Q?hJuPenfxe3V5onvTGwMC3vLbV5ibJt8BgPoqHyi+4D1B/Ir0VhD3pWIZmTah?=
 =?us-ascii?Q?pF+cyozPoFaYaSjNZD5jfTqJFekkiJR77d/qbcejWoIKt7QXtCABbOo6OUpc?=
 =?us-ascii?Q?uN0Ius7+jrd5Q4wovBq7FB2rdGHMQqwW7DsrnGqDv0Ds2MeNvsxU813T1g8t?=
 =?us-ascii?Q?KJJkzwnRGz8Lx3g47C9po8XdzUGhvpOwaNdgNUh83veL/ADx8YXdh1zem3SM?=
 =?us-ascii?Q?Yuzc4ZGnncVTE73Yk/8anCl2LYFInb8mnFGH7uisoZaumQ+F2SuAg3PvkAL0?=
 =?us-ascii?Q?rSe3zEdtX2yjpTeVB6sS5ZbVgONyjhJL8/IvbOA9/KBC7CGLMVgNmi0TpNn/?=
 =?us-ascii?Q?0yCy3elBIfCIvd70wDjho4SzZkSbZG0LXy5Delj/B30HPvcVODcM3EGtHiQ+?=
 =?us-ascii?Q?RHctpufe1ljQKpi5zl179YH/vZnO2Ppfx7kgzHGdl5IvySkpqEyRZ/QRL+Yd?=
 =?us-ascii?Q?gQw3QmNMfcmIo3zO89LquNB91uMoHaoTBtuTAa22ZRamWwvUf2HnDFkixs5M?=
 =?us-ascii?Q?rlm0TS+shKV/G8NRQo0mvJlux09BRISQgLDHxSs24NZqsgG5HAz2k+JmvM5i?=
 =?us-ascii?Q?psVq09ZwfphyojeA0A+m6P9U+ILNyihvkgZAy3ORRG74BL4Jx0ulwLN1YoJc?=
 =?us-ascii?Q?d71U5q3RI25+DsscZPmCIlpQzjG2LIfnZHIGkslUzy4FW8JgkAamYEzY2EOt?=
 =?us-ascii?Q?Hr45xCYJl+m8HSKgSi9PWb0J8H0pRtSBgTR+jSy8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1bce65-ae64-4dcf-f08e-08dbbff898f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:57:44.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyzz/l7c7v/h6y6tFl0F6y4nxnl7vNcaeqswGIUDQkj/SR1XbL/nst04rEqwL13J0OZuiXuqHK4Lf74qx0VyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
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

Hi Aaron,

On 2023-09-27 at 15:53:33 +0800, Aaron Lu wrote:
> On Tue, Sep 26, 2023 at 01:11:02PM +0800, Chen Yu wrote:
> > During task wakeup, the wakee firstly checks if its previous
> > running CPU is idle. If yes, choose that CPU as its first
> > choice. However, in most cases, the wakee's previous CPU
> > could be chosen by someone else, which breaks the cache
> > locality.
> > 
> > Proposes a mechanism to reserve the task's previous
> > CPU for a short while. In this reservation period, other
> > tasks are not allowed to pick that CPU until a timeout.
> > The reservation period is defined as the average short
> > sleep time of the task. To be more specific, it is the
> > time delta between this task being dequeued and enqueued.
> > Only the sleep time shorter than sysctl_sched_migration_cost
> > will be recorded. If the sleep time is longer than
> > sysctl_sched_migration_cost, give the reservation period
> > a penalty by shrinking it to half. In this way, the 'burst'
> > sleeping time of the task is honored, meanwhile, if that
> > task becomes a long-sleeper, the reservation time of that
> > task is shrunk to reduce the impact on task wakeup.
> > 
> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  include/linux/sched.h |  3 +++
> >  kernel/sched/fair.c   | 21 +++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index dc37ae787e33..4a0ac0276384 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -561,6 +561,9 @@ struct sched_entity {
> >  	u64				vruntime;
> >  	s64				vlag;
> >  	u64				slice;
> > +	u64				prev_dequeue_time;
> > +	/* the reservation period of this task during wakeup */
> > +	u64				sis_rsv_avg;
> 
> Nit: these info are only relavant for task, not group so might be better
> to move them to task_struct to save a little memory?
>

Yes, I'll try to do this.
 
> >  
> >  	u64				nr_migrations;
> >  
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d0877878bcdb..297b9470829c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6456,6 +6456,24 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	struct sched_entity *se = &p->se;
> >  	int idle_h_nr_running = task_has_idle_policy(p);
> >  	int task_new = !(flags & ENQUEUE_WAKEUP);
> > +	u64 last_dequeue = p->se.prev_dequeue_time;
> > +	u64 now = sched_clock_cpu(task_cpu(p));
> 
> I think cpu_of(rq) is more clear than task_cpu(p). Using task_cpu(p)
> seems to suggest task_cpu(p) can be different from cpu_of(rq).
>

You are right. My original thought is to use task's previous CPU rather than
the current rq. But at this stage the task's CPU has already been updated
to the same as rq. I'll think more about how to deal with this properly.
 
> > +
> > +	/*
> > +	 * If the task is a short-sleepting task, there is no need
> > +	 * to migrate it to other CPUs. Estimate the average short sleeping
> > +	 * time of the wakee. This sleep time is used as a hint to reserve
> > +	 * the dequeued task's previous CPU for a short while. During this
> > +	 * reservation period, select_idle_cpu() prevents other wakees from
> > +	 * choosing this CPU. This could bring a better cache locality.
> > +	 */
> > +	if ((flags & ENQUEUE_WAKEUP) && last_dequeue && cpu_online(task_cpu(p)) &&
> 
> Hmm...the cpu_online() check looks weird. If the cpu is offlined, no task
> will be enqueued there, right?
>

Right. If rq and the task's CPU are the same, there is no need to check cpu_online.

thanks,
Chenyu
