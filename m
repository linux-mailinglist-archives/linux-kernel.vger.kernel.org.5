Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13D77D942
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbjHPDsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjHPDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:48:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA8D1BF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692157253; x=1723693253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fYtbcEZvhx0Hq/2vqj6iuvfgtDJHJ7W8jpsM35URs60=;
  b=P7FcTK4lpmENWHJkWaigUqf6eyLHN4D1gWn0thlRKrL2lUxWlmlMHdNG
   ZYNPAPVxZ9KRcm0CClzJ90nbiAzjCOuns4Ql/uDdsHVE/OfxAIMc9lGd0
   oDlE/hMr5CEn+X/l/jKQaZjRe8giFXff2x18BFMwnwWgAZ36OCbbo+xib
   i70uGqQJuuiT4pNc9qcMFdsIrzvcYU4byT5EUPCFJ8IA4yHaFYc41a7cu
   ehoreXWkIfsCuyGFUV5bH47rMP5hWU/xekbHIoYljhWmwHzpNNqrVS3d+
   LxuoGhdVi/TN+vpxDrUE8o3B6t1XbQwEmTF+u8Q+a5kbfU/g8v8NtCOUk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438776571"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="438776571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 20:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877600910"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 20:40:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 20:40:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 20:40:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 20:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrzsrDpzYcHqASCi8XozlYiqBl5bZIsGVokjFEBXYHiqH3+OBii77difLFik8rAz8oZJuf6WU4sPjsZTIhDcd22E8gI0FzeuGMU6dVN4dGh+nexBbXJUxFYAGnok7hww5QIB2M84eZNWLGAtdGBlgWkOIHXZRHFZh16usg43G95H9a4ABX/hcHShzAh1ap0l6ySizU2lkl8DhOQI11E7c1EuVD9kDUEt4IVqV8LoEfHuFqKCKlROokPch+eeXu688fnQbPsZHLFMFXwq7QKK/eAoIvrFjIrRyP0MZntVJ34CgWyr0TLO1eXedldxJjIgvNhzpFM0YSOqbdFpGWvGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74x/TgVVwPiUg7YxcC+t49jaGZjy4hWxKDGBB3JBKuA=;
 b=jRYsrxnEBShrAdRtaTVUM+MvCkdEVkB0MoBCI7WqjFD8OVNp1rNkFWSlPhnpRIjfALnBrE4yqt0tTbiQ81Tbyc2pACfNqCTAfK/Botzsdr6wOSxGpYBTqyIsKbosZV5CWlQSXN6aMzNcvDZmIzOeHUc9qs4vIRNnzQLE6UOhbAvtS7T9EseVD/h8CHaNJ8eX9gImQlCqSTuOTWaLT/9lmVLVLk8zVE7CBkLxsyi9t6l0pPrk/wFRAUbef4lhN5gqX2RhttBmhtaCP3nsbfBLQb/S7N0kl/2QTs/DVoD9SgH+RFyRrFpZrufuofgnf0mboDv96Z+rcVZ9eRGvqqT5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5495.namprd11.prod.outlook.com (2603:10b6:208:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 03:40:50 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 03:40:50 +0000
Date:   Wed, 16 Aug 2023 11:40:33 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZNxFMYZNoyZSdUbd@chenyu5-mobl2>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814132935.GK776869@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: KU1PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:802:19::26) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: ef588fbc-075f-430c-fa6b-08db9e0a9581
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POhTBi1Q7eZ0xy3ClSZtiKNo5GLrMQ1E02bOhnX4Syfr6du16jdAoHK1H908S84a3jm5HRhCk3IaQ/f3kloFLGyotQOeS6ku63WEuVL2c1/Tr0eHon1EzrY9jlx+aqPbjPLecRmwXcpVLJGMHbJTNczkJzd8xLYg+1CdhUrYUxYUoibDSqwJu6WvMXi3GCt5C7PgWYb0wO6fd63UkxKpBJbYJ89m2egrOY/gls21CnqEtJnQ7L8veAHum8cFVwekRd6uv9so3WAFbEXaBgml7WHAoEgeoJCjq5dRji9Fk0KqouRVv7x9UkJvQHL38Qw8tnQ2R6DyEh3FPcHMn2IlULgHqUT3RJq/ppXb6H1qGhWfrncF68zSOp16IKtNkQJEXnWkPa3+xaK29jZx+k9Gn0nQwuGgPE8J0Of5aIhmMkTQ8q4CqTAfKD2sEMwHA3mjeO8rDRVEZhLTcW7DL9AJZe5UHZcZF/R3HZoSUeCIXbEEMDtIgZjcCS4+L6FmpRo07PGBV6kXQUi0mVUaMMkqE/5cDOM2WdDxK9iYHTUxUspTht1R4/0ArRGeYgH6AU+H4WxKXpF5A6jo5aF9t+vMRG7A2qfiN7HGeOHQmCCp4UC5akpewpOUJNe27fd5lKspZ33R+IQ9CP2TrSnkf/olUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(30864003)(2906002)(478600001)(9686003)(26005)(6916009)(5660300002)(83380400001)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(38100700002)(33716001)(82960400001)(86362001)(47234003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H9dKu3myuJbJCZcpxM0dWflIb8GjRIZ2KxlDF/nmlH9qjn5uGchQLEeWZ5v9?=
 =?us-ascii?Q?waxXLkOpIKGR2nn8Xj6d4jfxr7QTSlAmOcPGzFSSowBWiBlgMhtIevGtvq7N?=
 =?us-ascii?Q?A5LEthMilseVAeMjwtHWEnGoR0hMQ52msP/fVHv4jTc4dMSgaAbxMaa6m7Gv?=
 =?us-ascii?Q?zcQexAmYOS48VQqnfT70PCK0Xe1iJIsW2AcurDMBYYh11Bm7IdYuJGdgITdD?=
 =?us-ascii?Q?PSdS1taa7LwGdPBqDDmYYuDMaKVCAMYiCZNZ3Ga9wc/Grsn5t+n+gfLH5F6H?=
 =?us-ascii?Q?ahhr70dWX5zjgwPJtw5HbS4szx/5rtl/mBYnABoTK/Bn/rHgeujRwO/Faa+O?=
 =?us-ascii?Q?FXAKp1KrLb1erri2KIY/rlAbiNIZfFKioLtL30fQCKxcXBV+uhdHMKHPeo4J?=
 =?us-ascii?Q?iU7c2HYJJW8plmghn4vADAtIH+K3AtQyVS7ZBvQTqVwhnRS/x+X0I1a7bjvz?=
 =?us-ascii?Q?ZCSDfd3edtGIpMZSDRAFH7/dPcYsqOyEQUbCzwVm0nZoLGj6jE/d0lW3h3bI?=
 =?us-ascii?Q?YmHmmVqtkI/egtvs41mKbUNvVi85zh4ZrOH/qDauTfZs+sCQD20+aDh9YqIW?=
 =?us-ascii?Q?Zv1Vw3ZTOhuchvK3TsCE+HWpNKoZEtxZ2Fs5b/4t36hn3kT2OfqoabWg3yJp?=
 =?us-ascii?Q?ERUylC5QNiYNUhE2DsuriFQq0hxjh4JRPoLTJAmNt/VzSOWCpcLSJ60oB/lk?=
 =?us-ascii?Q?lq18Ql5wmV+h5p96rSR90HMV5e9jWzwvXFNnzjWtNxqNj72nBJnxIneHzFP6?=
 =?us-ascii?Q?ilOmJsBELqSlZZioforOUKaAZHBKbzvZ+9G6EKgBlTrtVUQjLUUYqVxlxgP0?=
 =?us-ascii?Q?ODN8Gyb+S5tqs/8mgEkwaIW6wHRByvFNg1hFcboSBK5oqj5aTJGwbDHSxHbo?=
 =?us-ascii?Q?wp4TCUwVToNgDraPfJ+3qsZE3L/D+WM+k0r6NtSF54J1Uy4+TQ1/f4WBHg2Q?=
 =?us-ascii?Q?CY7FrkahwUOprgNDcaXJuQKZJP/pV/WP3KPiOeqJuGAQJhPTNWqMrs0eClLA?=
 =?us-ascii?Q?U3mHk0jsRIeJeWEVr+CdYVFMWjE1KqeOiBSDkvgGzKV4wBjFbCWGgL84W9/S?=
 =?us-ascii?Q?IdOR6OQKl5g+9DHHJGlifXtvRqMcCegeBkLUD8psiD7hAxJa8UTEBQge/ZbH?=
 =?us-ascii?Q?spgcDXrZZknSlqorVJyIdJCSxrCPMPNrNZj3Dz7EM++cT0wal+fyMQKXwAJ0?=
 =?us-ascii?Q?r45YBq9p5Fd0dS8LavD4pBkvrS5TSQOlU+KUdaPZA+S4RDLrD2RylI71dNiy?=
 =?us-ascii?Q?Vm/bb3k2I1zAKLETCFaWgN+Nc59Cp23wWOZd5Pn4fLlVmAe/gqbdgbP1D9+g?=
 =?us-ascii?Q?tA6wgB/8K4rNCSST1OQ99CBy/HBesYscEBNK2vNyGMiCv7sRdRhKxYs5K7+u?=
 =?us-ascii?Q?sPB0eOoUDulKt3D8w3sscrBPn/JH7urkTtXqefYWb4RiSVEKKGB8XAwLRvqM?=
 =?us-ascii?Q?hqc+I/Gb7quctzD/LofqBVyRGENZY9zKUW8IaYgxdfLjvWb8u0xn+QbejWO1?=
 =?us-ascii?Q?VReXq6EmmeWUiO6yq9wjhILWXFMyU6yXWixT4pZV4ORJFph3EuoPJJFhoWwz?=
 =?us-ascii?Q?20PEzqfPSxOaZFY5ABpOHSm3pQZL2s4mAidyM7mw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef588fbc-075f-430c-fa6b-08db9e0a9581
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:40:50.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avJCddcXW4cBOcxj8dcSIEOEg6amXmPWoBEsbF37CSGkFGb++OPqt5fsRb/L3bTEB4ID3jjBNsQuLvKccfEhAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5495
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-14 at 15:29:35 +0200, Peter Zijlstra wrote:
> On Fri, Aug 11, 2023 at 10:42:09AM +0800, Chen Yu wrote:
> 
> > Since previously lkp has reported that with eevdf policy enabled, there was
> > a regression in hackbench, I did some experiments and found that, with eevdf
> > enabled there are more preemptions, and this preemption could slow down
> > the waker(each waker could wakes up 20 wakee in hackbench). The reason might
> > be that, check_preempt_wakeup() is easier to preempt the current task in eevdf:
> 
> This is true.
> 
> > Without eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
> > Thu Aug 10 11:02:02 2023              cpu8
> > .stats.check_preempt_count            51973       <-----
> > .stats.need_preempt_count             10514       <-----
> > .stats.rq_cpu_time                   5004068598
> > .stats.rq_sched_info.pcount           60374
> > .stats.rq_sched_info.run_delay       80405664582
> > .stats.sched_count                    60609
> > .stats.sched_goidle                    227
> > .stats.ttwu_count                     56250
> > .stats.ttwu_local                     14619
> > 
> > The preemption success ration is 10514 / 51973 = 20.23%
> > -----------------------------------------------------------------------------
> > 
> > With eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
> > Thu Aug 10 10:22:55 2023              cpu8
> > .stats.check_preempt_count            71673      <----
> > .stats.low_gran_preempt_count         57410
> > .stats.need_preempt_count             57413      <----
> > .stats.rq_cpu_time                   5007778990
> > .stats.rq_sched_info.pcount          129233
> > .stats.rq_sched_info.run_delay       164830921362
> > .stats.sched_count                   129233
> > .stats.ttwu_count                     70222
> > .stats.ttwu_local                     66847
> > 
> > The preemption success ration is 57413 / 71673 = 80.10%
> 
> note: wakeup-preemption
> 
> > According to the low_gran_preempt_count, most successfully preemption happens
> > when the current->vruntime is smaller than wakee->vruntime + sysctl_sched_wakeup_granularity,
> > which will not happen in current cfs's wakeup_preempt_entity().
> > 
> > It seems that, eevdf does not inhit the wakeup preemption as much as cfs, and
> > maybe it is because eevdf needs to consider fairness more?
> 
> Not fairness, latency. Because it wants to honour the virtual deadline.
> 
> 
> Are these wakeup preemptions typically on runqueues that have only a
> single other task?
>

There are 112 groups of hackbench waker/wakee on a 112 CPUs system.
Each group has 1 waker and 20 wakees. It seems that there are more than 1
other task on each runqueue. I collected the statistics below.
 
> That is, consider a single task running, then avg_vruntime will be it's
> vruntime, because the average of one variable must be the value of that
> one variable.
> 
> Then the moment a second task joins, we get two options:
> 
>  - positive lag
>  - negative lag
> 
> When the new task has negative lag, it gets placed to the right of the
> currently running task (and avg_vruntime has a forward discontinuity).
> At this point the new task is not eligible and does not get to run.
> 
> When the new task has positive lag, it gets placed to the left of the
> currently running task (and avg_vruntime has a backward discontinuity).
> At this point the currently running task is no longer eligible, and the
> new task must be selected -- irrespective of it's deadline.
> 
> The paper doesn't (AFAIR) consider the case of wake-up-preemption
> explicitly. It only considers task selection and vruntime placement.
> 
> One option I suppose would be to gate the wakeup preemption by virtual
> deadline, only allow when the new task has an earlier deadline than the
> currently running one, and otherwise rely on tick preemption.
> 
> NOTE: poking at wakeup preemption is a double edged sword, some
> workloads love it, some hate it. Touching it is bound to upset the
> balance -- again.
> 
> (also, did I get that the right way around? -- I've got a Monday brain
> that isn't willing to boot properly)
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe5be91c71c7..16d24e5dda8f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8047,6 +8047,15 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	cfs_rq = cfs_rq_of(se);
>  	update_curr(cfs_rq);
>  
> +	if (sched_feat(WAKEUP_DEADLINE)) {
> +		/*
> +		 * Only allow preemption if the virtual deadline of the new
> +		 * task is before the virtual deadline of the existing task.
> +		 */
> +		if (deadline_gt(deadline, pse, se))
> +			return;
> +	}
> +
>  	/*
>  	 * XXX pick_eevdf(cfs_rq) != se ?
>  	 */
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 61bcbf5e46a4..e733981b32aa 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -24,6 +24,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
>   * Allow wakeup-time preemption of the current task:
>   */
>  SCHED_FEAT(WAKEUP_PREEMPTION, true)
> +SCHED_FEAT(WAKEUP_DEADLINE, true)
>  
>  SCHED_FEAT(HRTICK, false)
>  SCHED_FEAT(HRTICK_DL, false)

Added more schedstats to track the counter, when the wakee
succeed to preempt the current task:

1. curr's deadline is smaller than the wakee's deadline
2. curr is not eligible
3. the cfs_rq->nr_running <= 2

Also applied Mike's RUN_TO_PARITY patch with some minor change
to only apply RUN_TO_PARITY for wakeup:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57e8bc14b06e..da7260ddd7e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -931,14 +931,20 @@ static struct sched_entity *pick_cfs(struct cfs_rq *cfs_rq, struct sched_entity
  *
  * Which allows an EDF like search on (sub)trees.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, int wake)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
-	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr))) {
 		curr = NULL;
+		if (wake)
+			schedstat_inc(cfs_rq->rq->curr_noeli_preempt_count);
+	}
+
+	if (sched_feat(RUN_TO_PARITY) && wake && curr)
+		return curr;
 
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
@@ -5441,7 +5447,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
 			return cfs_rq->next;
 
-		return pick_eevdf(cfs_rq);
+		return pick_eevdf(cfs_rq, 0);
 	}
 
 	se = left = pick_cfs(cfs_rq, curr);
@@ -8294,6 +8300,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	int next_buddy_marked = 0;
 	int cse_is_idle, pse_is_idle;
 
+	schedstat_inc(rq->check_preempt_count);
+
 	if (unlikely(se == pse))
 		return;
 
@@ -8358,8 +8366,19 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		/*
 		 * XXX pick_eevdf(cfs_rq) != se ?
 		 */
-		if (pick_eevdf(cfs_rq) == pse)
+		if (pick_eevdf(cfs_rq, 1) == pse) {
+			if (cfs_rq->curr->vruntime <
+			    pse->vruntime + sysctl_sched_wakeup_granularity) {
+				schedstat_inc(rq->curr_lowgran_preempt_count);
+			}
+			if (cfs_rq->curr->deadline < pse->deadline) {
+				schedstat_inc(rq->curr_lowdl_preempt_count);
+			}
+			if (cfs_rq->nr_running <= 2) {
+				schedstat_inc(rq->curr_lownr_preempt_count);
+			}
 			goto preempt;
+		}
 
 		return;
 	}
@@ -8377,6 +8396,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	return;
 
 preempt:
+	schedstat_inc(rq->need_preempt_count);
+
 	resched_curr(rq);
 	/*
 	 * Only set the backward buddy when the current task is still
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2a830eccda3e..d021dd0e0226 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -6,6 +6,7 @@
  */
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aa5b293ca4ed..b6e245d2bba5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1128,6 +1128,12 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+	unsigned int		check_preempt_count;
+	unsigned int		need_preempt_count;
+	unsigned int		curr_lowgran_preempt_count;
+	unsigned int		curr_lowdl_preempt_count;
+	unsigned int		curr_noeli_preempt_count;
+	unsigned int		curr_lownr_preempt_count;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..e7f02e7bfff2 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,16 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->check_preempt_count, rq->need_preempt_count, rq->curr_lowgran_preempt_count,
+		    rq->curr_lowdl_preempt_count,
+		    rq->curr_noeli_preempt_count,
+		    rq->curr_lownr_preempt_count);
 
 		seq_printf(seq, "\n");
 
-- 
2.25.1




NO_RUN_TO_PARITY:

Tue Aug 15 19:16:30 2023              cpu8  
.stats.check_preempt_count            85754 
.stats.curr_lowdl_preempt_count       5189  
.stats.curr_lowgran_preempt_count     70063
.stats.curr_lownr_preempt_count        31   
.stats.curr_noeli_preempt_count       30252 
.stats.need_preempt_count             70066 
.stats.rq_cpu_time                   5032932195
.stats.rq_sched_info.pcount          155748 
.stats.rq_sched_info.run_delay       159730175645
.stats.sched_count                   155748 
.stats.ttwu_count                     84568 
.stats.ttwu_local                     81029 


When the wakee succeeds to preempt the current task:

1. curr's deadline is smaller than wakee's deadline:
   5189 / 70066 = 7.41%

2. curr is not eligible
   30252 / 70066 = 43.18%

3. the cfs_rq->nr_running <= 2
   31 / 70066 = 0.04%

According to above data, maybe comparing the deadline does not take much
effect in this case(per 1). And the scenario of only 1 other task
seldom happens(per 3). And considering the current task's eligibility
without checking deadline might help(per 2, there are (70066 - 30252) times
that the current is eligible but preempted, and Mike's patch addressed
that)


RUN_TO_PARITY:

Tue Aug 15 19:19:07 2023           cpu8  
.stats.check_preempt_count         20147 
.stats.curr_lowdl_preempt_count     334  
.stats.curr_lowgran_preempt_count  4637  
.stats.curr_lownr_preempt_count      8   
.stats.curr_noeli_preempt_count    5451  
.stats.need_preempt_count          4645  
.stats.rq_cpu_time                5052091287
.stats.rq_sched_info.pcount        25486 
.stats.rq_sched_info.run_delay    166261574881
.stats.sched_count                 25486 
.stats.ttwu_count                  20146 
.stats.ttwu_local                  20146 

With Mike's change, the wakeup preemption success ratio drops
to 4645 / 20147 = 23.06%, which is very close to cfs wakeup preemption
ratio 20.23%. And the throughput has been increased:

echo NO_RUN_TO_PARITY > /sys/kernel/debug/sched/features 
hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 117.487

echo RUN_TO_PARITY > /sys/kernel/debug/sched/features 
hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 101.285  <--- lower the better

Also tested schbench with/without RUN_TO_PARITY, no much difference(especially wakeup
latency) is observed:

echo NO_RUN_TO_PARITY > /sys/kernel/debug/sched/features
./schbench -m 14 -t 16 -r 100
Wakeup Latencies percentiles (usec) runtime 100 (s) (941339 total samples)
	  50.0th: 4          (53382 samples)
	  90.0th: 3772       (353480 samples)
	* 99.0th: 7448       (84115 samples)
	  99.9th: 7976       (8244 samples)
	  min=1, max=15186
Request Latencies percentiles (usec) runtime 100 (s) (941598 total samples)
	  50.0th: 23264      (283891 samples)
	  90.0th: 32672      (375363 samples)
	* 99.0th: 52288      (83963 samples)
	  99.9th: 95360      (8449 samples)
	  min=4487, max=241201
RPS percentiles (requests) runtime 100 (s) (101 total samples)
	  20.0th: 9264       (22 samples)
	* 50.0th: 9392       (33 samples)
	  90.0th: 9584       (36 samples)
	  min=9055, max=10176
average rps: 9415.98

echo RUN_TO_PARITY > /sys/kernel/debug/sched/features
./schbench -m 14 -t 16 -r 100
Wakeup Latencies percentiles (usec) runtime 100 (s) (943005 total samples)
	  50.0th: 4          (53961 samples)
	  90.0th: 3772       (366473 samples)
	* 99.0th: 7496       (84902 samples)
	  99.9th: 9296       (8441 samples)
	  min=1, max=20467
Request Latencies percentiles (usec) runtime 100 (s) (943206 total samples)
	  50.0th: 23072      (283181 samples)
	  90.0th: 32096      (376473 samples)
	* 99.0th: 53568      (84586 samples)
	  99.9th: 99456      (8443 samples)
	  min=4078, max=219330
RPS percentiles (requests) runtime 100 (s) (101 total samples)
	  20.0th: 9296       (22 samples)
	* 50.0th: 9392       (34 samples)
	  90.0th: 9584       (38 samples)
	  min=9065, max=10188
average rps: 9432.06


thanks,
Chenyu

