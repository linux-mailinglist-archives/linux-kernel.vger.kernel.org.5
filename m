Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F44778595
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjHKCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKCme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:42:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470442D48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691721753; x=1723257753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xqzNe6gKNOKOH4eYM3m1J76YyhfQRXncGwksKV1k4DI=;
  b=en2IIxbe0wrBSrr8Hi02MVAKtSs5cCUa8N0N+MMLZrPLYbOEoKBCP5yb
   gRDd07vZiSxOXwMCz23GKqvOm/2Dy77Xd6UQA7sb2dDCj8SYOTR38tWUm
   nijm+VhT11S25Aq3L7bmtvOUb40p8/+GWxx8iji3Thg6PJSjwTqr6dGMu
   0Xa5icf9acfTS9zC5zAi7JE9XVJOkgmLyqwUyEOGt9+feFjRBwU6TvC5N
   9ie3iJ8xWywitr9r6g1X1rnn0cge7YIiZxHpQaN/kFWO2ibjoPqgcj9pY
   rFx4Au2bMSIQDjxOixl7r7yf89bN4BWzLwoTGhP5C9dODxToXryAaT2s/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374343381"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="374343381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 19:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767496588"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="767496588"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 19:42:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 19:42:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 19:42:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 19:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoRMpEYjj8pjQNh++fo6U0na8DGttWFGhiuYOZjphlRGZrWK4VvqhxWu8e9A/hVF8QAaDF5mGaHdUP2wImzJ0dWv/UdVNiOHOf0pqiRh2lmUkWq4KKlzYtkzmCiRGV7Q//2qKgERksmw/qcydaW/8c0ePSjrA9sJYrV6gyato/ZJHWejLvDYLgqE1UdOWnn65CV8dozkY28oVwlM/QVld0HSN3Z6fDPGnj4859Rx425JIS9KyOaG2JfkDlRlfhQHEvIMPnaaqGsYu5y8Ok4srDwGGiyDAgLbDSW7faGEcexe+8ByGk1xhRnzXK1PS+bFmJf9upWmQikzELKgN0LOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgdaAWv2AAfR3zqV5KGKh2dJTX90LZTqUqFhn9TBK14=;
 b=A0tgHJQt+P8KtQ0wcOW4uQSzKwh/CqmMV4Z/LldAiWkxeg8uW00P2qmrH7XLSCUuZzFexMK24wxcapq7QuPSXAk6qFwUTks0r0KSDUxtZ9mQiQXlBc9vK8wFU7oKESf4vRGj//z1znt25okOrU7Q8FAHZBavwAD21DXVuUB+o4jWQj3E1XJNE8YuXuUIvjA0mkOJhOAPSfA1AMoic9NHWf3ZOC2bSxXQ2yJekhgnO/M5SJSMH6c+A1o79oPkqwAuQgCU2TCO6NyEo8GUZMoZUes6xZlQ2999BTsLdEr5OsPHsbd8E3q/BNydRZ2Ol/XMz8K+Fhh9ZKKb9WHzXJSNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 02:42:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 02:42:24 +0000
Date:   Fri, 11 Aug 2023 10:42:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY5PR11MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f66836-53b1-457a-68fd-08db9a14978f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ca3jU0n4WSZfRX7YKPH6Blfg4cov7y+zmGBGX9IESXJh9TjtMJo7rY8qD5xJq1rUTgEQ8qoChOpHUXsC2FeXBsFNcsePZ7kntNLkTx8AFxiIfTpbfH8MkNAw/VT8a6Ht5cY2zDE1g6HKmhTZwKDpl926c7XVBjDa6uLHLPj0JQNLqcXZzOpkhLs5a934K4vDG7N8N00O5qD0W8CHLsHq+4jWcgfVfLxHxspZe3YUXjgTDHZsshRiaeKlDYgf4in4sW7IhIvtvXUJmdEsRxxcDGj0XfzCK74B10yYAD2KGxUMsK58Sn24pDswiScSwVc4KGQpHensDBL9fzlnTo2xSNtLd/WbfeSlxjqva9Sh3TOPpVpzPP3T4et6pBx4UPfIFCjDagGR1CnHUBfY/jaMTSzuiIW+QzETNNZ7g1p2p1C+FnJ3VepX6gt67LCidasxN8HT+2m4c89S4MSml2tEMAMAiBlNYxFsyhf0O0EePv7hEgSZlCZJfR2uxL/bTnz3A1ctHf8hT2Ls/ksRQvnVdevfdwRAhh4gWlSRJRiy+ADTtV+qhvJTaaq9t9NQGrXcSAexwsoVtIf7x60nj2ti6QSS2BeVtwzhntNSLw6wveCzu4SWe6rrPntR06k9ABe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(1800799006)(186006)(53546011)(2906002)(478600001)(26005)(6506007)(6512007)(9686003)(966005)(6486002)(6666004)(86362001)(8936002)(5660300002)(316002)(8676002)(6916009)(66946007)(4326008)(66556008)(66476007)(41300700001)(82960400001)(38100700002)(54906003)(83380400001)(47234003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LftyOrLI7v3UhIw8N3F0WptIf/hFo33NXRJgRsF699NHW9uyl4kBxKRyjXLs?=
 =?us-ascii?Q?Rdk7vxSVXREHJN8ftbqYVw1eaSSwnTa4ySvNbhTZJYj1wQG2cO4ZBOi2M5LE?=
 =?us-ascii?Q?nD9FfqMQHIoIGavIeNugj8HD3bgzZdWIfRfe88xE3uKOl0zZosTH9Mx7uTWC?=
 =?us-ascii?Q?sRjhmBA2gpvBkp/X9GIcGrQSpldsegw6RON2vjC8/c+sgNWxUzgyo3hgKDDp?=
 =?us-ascii?Q?Vt5TpCVRBDjgrnAXOE0TIvX6IYBWeLcLjQ4xyvpb8ujDEQ3gNB2lz9QSzu0u?=
 =?us-ascii?Q?ngxCdUrK28BjPf5KaKdwiF2hTtUbbLwo+vKTfe1lMiwjPcKuwvUpCZyD0T3/?=
 =?us-ascii?Q?09NPm37PA0BwDxu7qvA/FEzbjGpkRfN4ObsH9nsXOcha6OYLpnF4SmDypp7m?=
 =?us-ascii?Q?iQuXswMWObXaWu0GplNlB8gldW/BgvTZ9QJid52kwr5RR5xgRbKv67FFcYAv?=
 =?us-ascii?Q?5vz5ewVeqtQIOJww+rl3jnwoRVqlbEdbYizyXeEoFqZsQ7jTzUjElrCGRPm4?=
 =?us-ascii?Q?rvrxVfpF6vLMj1OoTD5WAI16pYymtaK2WMwNtxigrTlRLhg0jAldn8MDQwbb?=
 =?us-ascii?Q?qxPihT/+R1NNnDgFdyxPV8M/r04EoxV4b0wCQQ+mDmQnXIsvf2BFxc7i/uTz?=
 =?us-ascii?Q?4KY4kLXN8E2JT4XZXOf23OWhzDxnnFdCWuliIg6iaXaOMat8rlimkxzOzGH/?=
 =?us-ascii?Q?Mwe3KLpUc8z9DVRBT7fO9awDdcd7I7duOU+BR+/6WvhHgM/IX/BUCBMJUAqq?=
 =?us-ascii?Q?p2kybQbAIB/k2RncfYiftU+WKIwkivWbRXePJ4LpWKdxErHeHJxfO4TWt1Yz?=
 =?us-ascii?Q?n5DpaX+ZdfuOfJJaxCKPD6yEg647hwsxOE0f6qOHZCxQVdV8XO/IlWWZ2MIl?=
 =?us-ascii?Q?59hEVHbnqQeU8m1qH9RgkfScHSnJ3c1Fm5MqdfNpSV6Uo/1hcOAbMIG11GfZ?=
 =?us-ascii?Q?ykAy6miCSMIXMT+FI70lhuQpswkWoYj/VmjkBDGeQG2QiqY7rxJ+qW0ZwADO?=
 =?us-ascii?Q?S/5PJHZq5I2LFl2kHqE+OTdW3lnQoVcacI1yqYOTdAdgweGWAFYON5SKh0UY?=
 =?us-ascii?Q?/5a/dAEMznA/vExriMXZvTYrNAD/Db6ofIbJj4cOwKpHkmw7yX8kd/+Ptegs?=
 =?us-ascii?Q?WVdMTExDZdpVZm+b9CXIPpio9BKp9eu0odiB67Sft4Dqrni/dqY8JckVZx2d?=
 =?us-ascii?Q?Y6N1tVwcCoL/GMmdY44IQRAPkKKqeRybonJS6p2wkS58bvutt9QsyzsDbMmE?=
 =?us-ascii?Q?a8fWNVKF6ApJitxo3NQFhzjzMmYoFmBI/UeHWpSE1DAZ6PMUAZ0mAmyo0REU?=
 =?us-ascii?Q?Vf1JewcrgeboKuByxlcKDSBjNX9aQ8bLqJ7Qht7MboBwY5rYGAXNhpJlk2ga?=
 =?us-ascii?Q?I3kN0Zg/4lkG9quEH05eBxLr7UtVRrdbHj8Pfu03QhHmZTW9yb9gUZj3ZWzn?=
 =?us-ascii?Q?hFoZqgWwW9ScwspdgsOGDH80ZGgIqIlCtaVPeHAp9GCVvsS0HlcsDY13t6wu?=
 =?us-ascii?Q?DR35U2SlUBEvbCO7+NjApsmJWNK+g2I7w90aQookC3elMahO/770Jjoz0Ei4?=
 =?us-ascii?Q?o/elqDSI02odbiLaH5A05yXT63oAEelYv94IdqlJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f66836-53b1-457a-68fd-08db9a14978f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:42:24.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRMsElYQQjhWXw5C6bxteBvkEnfxgTC6BiYvbDH9gRx8YDEVzmbMdwIr1P9CBFfnK/YqbWax0P1HaHhya5RoXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2023-08-11 at 09:11:21 +0800, Chen Yu wrote:
> On 2023-08-10 at 21:24:37 +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -34.8% regression of phoronix-test-suite.blogbench.Write.final_score on:
> > 
> > 
> > commit: e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13 ("sched/fair: Remove sched_feat(START_DEBIT)")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/eevdf
> > 
> > testcase: phoronix-test-suite
> > test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> > parameters:
> > 
> > 	test: blogbench-1.1.0
> > 	option_a: Write
> > 	cpufreq_governor: performance
> > 
> 
> It seems that commit e0c2ff903c32 removed the sched_feat(START_DEBIT) for initial
> task, but also increases the vruntime for non-initial task:
> Before the e0c2ff903c32, the vruntime for a enqueued task is:
> cfs_rq->min_vruntime
> After the e0c2ff903c32, the vruntime for a enqueued task is:
> avg_vruntime(cfs_rq) = \Sum v_i * w_i / W
>                      = \Sum v_i / nr_tasks
> which is usually higher than cfs_rq->min_vruntime, and we give less sleep bonus to
> the wakee, which could bring more or less impact to different workloads.
> But since later we switched to lag based placement, this new vruntime will minus
> lag, which could mitigate this problem. 
> 
>

Since previously lkp has reported that with eevdf policy enabled, there was
a regression in hackbench, I did some experiments and found that, with eevdf
enabled there are more preemptions, and this preemption could slow down
the waker(each waker could wakes up 20 wakee in hackbench). The reason might
be that, check_preempt_wakeup() is easier to preempt the current task in eevdf:

baseline(no eevdf): sched/fair: Add cfs_rq::avg_vruntime
compare(eevdf): sched/smp: Use lag to simplify cross-runqueue placement

hackbench -g 112 -f 20 --threads -l 30000 -s 100
on a system with 1 socket 56C/112T online

1. Use the following bpf script to track the preemption count
   within 10 seconds:

tracepoint:sched:sched_switch
{
        if (args->prev_state == TASK_RUNNING) {
                @preempt = count();
        }
}

baseline:
bpftrace preemption.bt 
Attaching 4 probes...
10:54:45 Preemption count: 
@preempt: 2409638


compare:
bpftrace preemption.bt 
Attaching 4 probes...
10:02:21 Preemption count: 
@preempt: 12147709

There are much more preemptions with eevdf enabled.


2. Add the following schedstats to track the ratio of successful preemption
in check_preempt_wakeup():

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57e8bc14b06e..dfd4a6ebdf23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8294,6 +8294,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	int next_buddy_marked = 0;
 	int cse_is_idle, pse_is_idle;
 
+	schedstat_inc(rq->check_preempt_count);
+
 	if (unlikely(se == pse))
 		return;
 
@@ -8358,8 +8360,12 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		/*
 		 * XXX pick_eevdf(cfs_rq) != se ?
 		 */
-		if (pick_eevdf(cfs_rq) == pse)
+		if (pick_eevdf(cfs_rq) == pse) {
+			if (se->vruntime <= pse->vruntime + sysctl_sched_wakeup_granularity)
+				schedstat_inc(rq->low_gran_preempt_count);
+
 			goto preempt;
+		}
 
 		return;
 	}
@@ -8377,6 +8383,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	return;
 
 preempt:
+	schedstat_inc(rq->need_preempt_count);
+
 	resched_curr(rq);
 	/*
 	 * Only set the backward buddy when the current task is still
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aa5b293ca4ed..58abd3d53f1d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1128,6 +1128,9 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+	unsigned int		check_preempt_count;
+	unsigned int		need_preempt_count;
+	unsigned int		low_gran_preempt_count;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..99392cad0c07 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->check_preempt_count, rq->need_preempt_count,
+		    rq->low_gran_preempt_count);
 
 		seq_printf(seq, "\n");
 
-- 
2.25.1

Without eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
Thu Aug 10 11:02:02 2023              cpu8
.stats.check_preempt_count            51973       <-----
.stats.need_preempt_count             10514       <-----
.stats.rq_cpu_time                   5004068598
.stats.rq_sched_info.pcount           60374
.stats.rq_sched_info.run_delay       80405664582
.stats.sched_count                    60609
.stats.sched_goidle                    227
.stats.ttwu_count                     56250
.stats.ttwu_local                     14619

The preemption success ration is 10514 / 51973 = 20.23%
-----------------------------------------------------------------------------

With eevdf enabled, the /proc/schedstat delta within 5 seconds on CPU8 is:
Thu Aug 10 10:22:55 2023              cpu8
.stats.check_preempt_count            71673      <----
.stats.low_gran_preempt_count         57410
.stats.need_preempt_count             57413      <----
.stats.rq_cpu_time                   5007778990
.stats.rq_sched_info.pcount          129233
.stats.rq_sched_info.run_delay       164830921362
.stats.sched_count                   129233
.stats.ttwu_count                     70222
.stats.ttwu_local                     66847

The preemption success ration is 57413 / 71673 = 80.10%

According to the low_gran_preempt_count, most successfully preemption happens
when the current->vruntime is smaller than wakee->vruntime + sysctl_sched_wakeup_granularity,
which will not happen in current cfs's wakeup_preempt_entity().

It seems that, eevdf does not inhit the wakeup preemption as much as cfs, and
maybe it is because eevdf needs to consider fairness more?

thanks,
Chenyu
