Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C878EAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjHaKrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345400AbjHaKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:47:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF0E7B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693478837; x=1725014837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TMTOyBvAA/aHXHlf2oCsA4xoLiT0CytHJhiC9pSTczs=;
  b=UR5lvLU+WYNAlI1iG701/OBMuNZeGEJ1lO0MbIPjxw0jyM/ZJMwt/a5l
   ubD/X4MICzJm5C27pGOwquSbkcKaGBsYcSfotRo0tVvy3qY5mxsfyjt9r
   6mkd338gp5/wGEv1W+Kw3XbEZPejZ5+RrI1F50+AUk2YSlq4DaafQ07qU
   HSwuRQeSg+AcXyVj2cY5TBAOYdhMxm2eW7zAfj+W6UZUAV/i+NCIcPyhq
   JriCv9Nqehu/mvk56aEB6Qc0+S+yVAD9okvNt+AbDjzIA628tgzxL8ljp
   KtxVw42AzZepSQ5JiSScFvTpYIDREQgiP0o30ccfexnoYsQymtR2uVL0n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373298855"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="373298855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913185272"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="913185272"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 03:45:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 03:45:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 03:45:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 03:45:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 03:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5BF6kgIvrN/Ef8jGnQ/83zkVx0dF6ft1VcrrPU7+iY02Xsb00qxHzOGPdFwgiAwp5h7NFCnyuPF3fIrlFJ9dSY9JYjA7naRstSICxA7+powI2GlWudBt5s94LWaGRvqZp+I8KWdbqYccPABwXUA0gfOyNfiju0kG8OrbATgek5HZwd0n+IUtAz8COA3E3YyoySqpI8vHDOFjM0nXaGQ7xsE+5DEvm+W5UEqmlT64n5XVczwrJz2qvUrBDy6D93oR7Grper60ht+qvrHSbfc6JWgLVT8m9ZslfL98hufibxHnoEm8ndg6zoCt/ZgwzzPOKZjlf6bnx3az6x7sb66GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky9hSiHpcEGGP3r4QJyvXOpZvrbK6U5o8qPXt6Cn57Y=;
 b=K+Z5UKmpVGqUMXU961obQwC0az0kWEEkyoOdsyzehkbtuoAEMTvMNmwl2ewDbEtsrqla77Oe52Ow4bmfdmNpeUT+FAUsoWGi/gzUTE4e668IEkG0fy3GuaxVPLlEBds5zg3P0ag5Pq5wr4Srl2ZbiXTY/bDHldfSLdh/upHU+GRGSTklzjq4Nq8oZycqAx6g+1rSNovkl6ntFTrVYQ7Flxs+5L2HbKiMp/5xAI0lY+jZ9B8Y2/nSwmtszYcgGoaSD71xjBWcnL0FlqFiyKouiCLQu4dTANfohIqwvjcGETFcWhJekrOGw2FrA76YNCFAuVv+k9WhxJZCbdMa1abjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 10:45:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Thu, 31 Aug 2023
 10:45:34 +0000
Date:   Thu, 31 Aug 2023 18:45:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     David Vernet <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <aaron.lu@intel.com>,
        <wuyun.abel@bytedance.com>, <kernel-team@meta.com>,
        <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <ZPBvN9W6RYOr51zQ@chenyu5-mobl2>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-8-void@manifault.com>
 <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
 <20230831000147.GA506447@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831000147.GA506447@maniforge>
X-ClientProxiedBy: KL1PR01CA0089.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::29) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1bb74e-27ff-40e2-5ea2-08dbaa0f6742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+C3x7GEVGe1cZJCMnjJ5VH5jNfcCgJFrnaru49vXJ46uq7JIVC7XX5IPEEBWooCLkxU3jcFNj+r1+EtACCRfRBkRnanRLg9rTFNEHzoSrbahVt/8BX/w1D8JE+gCp4zIijlNYd20vB32/DH5Bl2FqqdCdv/LZF65U7OXo8DddXPQB8shtIUdTevx6ast/0gc+SIZ1pY3HZTjFepRT1QvlnduetINcuGi0CiGHnhRhLvhme7eEROgk3tAi0OyvKo2jkq8QgwiHheMhZwQUQdiphbUVJnUaiHhH2Lp6JNLp5MIzE6swFyCqiKHZ32QjFkXI1oxvC9CBojMNTC2PqeOor/w2PSP2ZQpMVQRTDfbAg+RDD82eOyKf1AADUqJAtUCc8qhzBd1BoCTQ4CC8pjRoknxFdHfrCRA+gXqKP+cx/e5U4tt8jnQgkBBtJMZC5yLAj4qvWCGkQNGzF4fxAbcictQOxvEb+fastoeLYNbpELTCX67A491cY13YYG0dYScp3VxlZRP9xYLJZtb0lRtRQzeIARVX8ZxnDwzaKiJBSpFLBvkfyg1Uvs5tMglem+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(9686003)(6506007)(6512007)(6666004)(6486002)(53546011)(478600001)(107886003)(6916009)(26005)(5660300002)(7416002)(33716001)(8676002)(316002)(66476007)(2906002)(41300700001)(4326008)(66556008)(83380400001)(66946007)(82960400001)(86362001)(38100700002)(8936002)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrbZQf+IRhSnZsoZhIm5rbImSmRmCOaIKkDeY/g/ZoONbUpJrEwGd2zvjKGz?=
 =?us-ascii?Q?InWilxZFnqhbT7YWAEZ2Mf1CEOVrrcFxLorn5UCefJ+qQwbDiPOuUqDO2Ekb?=
 =?us-ascii?Q?ZoUjVi2opTf5XL8KWC0gqSx94eFgJZmwJWF60e69Xt7IL4ktY8gsISpxrVMa?=
 =?us-ascii?Q?rTjI3Dpy+f9ZVFVzP5dv4EysBs3vb+CZr74btGJ+aRDGkkmJxnCBMlQqPJnH?=
 =?us-ascii?Q?j6ZSrDlPG00RghHpdR/eWAFDBxfUdA1ZX86zUkzGUILFE0kP5fcmUl0qrblV?=
 =?us-ascii?Q?dq884UJLvbhHGZuz7sBxYIv9OH+Y6pBduujx1SoLUBCT0g9uRQO88CAeRvkN?=
 =?us-ascii?Q?yFFXJpNeLu6300X4cgfmgpL5ucyZhGX+FGNjxRSrLZjphHMlEcuQcYqAkWUM?=
 =?us-ascii?Q?Ff8vi8T+LW8EOJvS8KF3KPRCbghwGtirNlNbEC6p0sB3La8McZM0jdbheaLD?=
 =?us-ascii?Q?ul6NBBsfLyjQ/vflgH5xRqI43huwkRJ9VYcOle19auswTLhunCyRS9HLWmWx?=
 =?us-ascii?Q?GDw/Z6Fh3jXzxVnhBNcU0aOBfrQnGONAEzf/ypUj0IRVWDqCpvuzAL/slz4n?=
 =?us-ascii?Q?DhhFOIZEJdRCQ4Bfh2U4umdFnqgX06JnrjrMrON+ftHCSjbFLRGpPbSqOeX7?=
 =?us-ascii?Q?MzQc2IoZB2MYojCj4RZ9sSGVT5I2DFSKi+JyJcojtL2xr1gGJkvq0uG5lNWd?=
 =?us-ascii?Q?YQOSzWjisE0zV0ydfVoEGorWCPl3ubL/pL/XB4dOM0uQrkSsmARklMYqXdzN?=
 =?us-ascii?Q?V7Fd2s6tpu5G8ktrHJpKMqexP+2f3uOnzi4EAmRvaa22+fxA51OWPsKtvfo7?=
 =?us-ascii?Q?CnA/YzIWF4inJSu7XEp45ShTyAlFbgoTBE6R9eJb6wp5fUAvbb2H7dKv4HDP?=
 =?us-ascii?Q?N3UtoL2D+NSqdxh8XLNSujfbO3r/AXdqgDQqv8587RbNy8ws0eqW2Aaz5Bth?=
 =?us-ascii?Q?vMksIyAFJsp+m5n30laNTEfRv4Igc3cqxbIjGJ2y5oBLNHYmkS7Wn+GwiA/I?=
 =?us-ascii?Q?JfXWSIdqfG3A0Iit4P3DVOHDeV29+Bm177bfBaDzScoD78ibUSDESmswtJyI?=
 =?us-ascii?Q?SNaMSICVgmBUhSOFN3A+ouTu0LMEcbseSpB+C6ngELFJs4pXLC0BrM9DITgi?=
 =?us-ascii?Q?VQVXpuT0mhlRJ67UYEMZEOrJ5MfkYYxHIPyULzNIzDGLQD2/PJGMSnoFGXRc?=
 =?us-ascii?Q?mc2QvnyRtWyDOsnT+iZGv3pky3SgcW1f3yZ3WXt1vHxqXjC8YsFo2OeUwlnF?=
 =?us-ascii?Q?tH9A+BnJVzW8142kgn0o92ZaJs16nhNJ6fFTpTmQ75iNkc2OONmw516QEyby?=
 =?us-ascii?Q?RtN11GKpAIjnzAY1kLgp4hcG89ElVGuEl40hS/u3mqhFRPee6T2O+WcxtTe+?=
 =?us-ascii?Q?I2z+aQKgHPUgP2vrnl96nIcOQLHfZjVentZJqpggt5lvhdX57Ddymd/wDDOi?=
 =?us-ascii?Q?CbpNBinnB1cGnvH7wLsBJfc+Y1MWUufz3hXETug/bJrwfKrRzp5mzirAhOke?=
 =?us-ascii?Q?EC53tJ2SIEdK9AUTRxvarmVh+HgVq4S0cbWQ13Zg+DaRzrj1Hb71hjl+g+BD?=
 =?us-ascii?Q?vAsCS6eC0TjuT2l6omns8tqJrDmHeeePgzzXxPnZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1bb74e-27ff-40e2-5ea2-08dbaa0f6742
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:45:34.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leJL5IvhsORufpsNfTRa9bkF1XasZLzZM7njhN/x24GnSNqkM1jivnesftBudgcBjd3Id7RZFfLx7MpzOMU8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-30 at 19:01:47 -0500, David Vernet wrote:
> On Wed, Aug 30, 2023 at 02:17:09PM +0800, Chen Yu wrote:
> > 
> > 5. Check the L2 cache miss rate.
> > perf stat -e l2_rqsts.references,l2_request.miss sleep 10
> > The results show that the L2 cache miss rate is nearly the same with/without
> > shared_runqueue enabled.
> 
> As mentioned below, I expect it would be interesting to also collect
> icache / iTLB numbers. In my experience, poor uop cache locality will
> also result in poor icache locality, though of course that depends on a
> lot of other factors like alignment, how many (un)conditional branches
> you have within some byte window, etc. If alignment, etc were the issue
> though, we'd likely observe this also without SHARED_RUNQ.
>

[snip...] 

> 
> Interesting. As mentioned above, I expect we also see an increase in
> iTLB and icache misses?
> 

This is a good point, according to the perf topdown:

SHARED_RUNQ is disabled:

     13.0 %  tma_frontend_bound
      6.7 %  tma_fetch_latency
       0.3 %  tma_itlb_misses
       0.7 %  tma_icache_misses

itlb miss ratio is 13.0% * 6.7% * 0.3%
icache miss ratio is 13.0% * 6.7% * 0.7%

SHARED_RUNQ is enabled:
     20.0 %  tma_frontend_bound
      11.6 %  tma_fetch_latency
       0.9 %  tma_itlb_misses
       0.5 %  tma_icache_misses

itlb miss ratio is 20.0% * 11.6% * 0.9%
icache miss ratio is 20.0% * 11.6% * 0.5%

So both icache and itlb miss ratio increase, and itlb miss increases more,
although the bottleneck is neither icache nor itlb.
And as you mentioned below, it depends on other factors, including the hardware
settings, icache size, tlb size, DSB size, eg.

> This is something we deal with in HHVM. Like any other JIT engine /
> compiler, it is heavily front-end CPU bound, and has very poor icache,
> iTLB, and uop cache locality (also lots of branch resteers, etc).
> SHARED_RUNQ actually helps this workload quite a lot, as explained in
> the cover letter for the patch series. It makes sense that it would: uop
> locality is really bad even without increasing CPU util. So we have no
> reason not to migrate the task and hop on a CPU.
>

I see, this makes sense.
 
> > I wonder, if SHARED_RUNQ can consider that, if a task is a long duration one,
> > say, p->avg_runtime >= sysctl_migration_cost, maybe we should not put such task
> > on the per-LLC shared runqueue? In this way it will not be migrated too offen
> > so as to keep its locality(both in terms of L1/L2 cache and DSB).
> 
> I'm hesitant to apply such heuristics to the feature. As mentioned
> above, SHARED_RUNQ works very well on HHVM, despite its potential hit to
> icache / iTLB / DSB locality. Those hhvmworker tasks run for a very long
> time, sometimes upwards of 20+ms. They also tend to have poor L1 cache
> locality in general even when they're scheduled on the same core they
> were on before they were descheduled, so we observe better performance
> if the task is migrated to a fully idle core rather than e.g. its
> hypertwin if it's available. That's not something we can guarantee with
> SHARED_RUNQ, but it hopefully illustrates the point that it's an example
> of a workload that would suffer with such a heuristic.
>

OK, the hackbench is just a microbenchmark to help us evaluate
what the impact SHARED_RUNQ could bring. If such heuristic heals
hackbench but hurts the real workload then we can consider
other direction.
 
> Another point to consider is that performance implications that are a
> result of Intel micro architectural details don't necessarily apply to
> everyone. I'm not as familiar with the instruction decode pipeline on
> AMD chips like Zen4. I'm sure they have a uop cache, but the size of
> that cache, alignment requirements, the way that cache interfaces with
> e.g. their version of the MITE / decoder, etc, are all going to be quite
> different.
>

Yes, this is true.
 
> In general, I think it's difficult for heuristics like this to suit all
> possible workloads or situations (not that you're claiming it is). My
> preference is to keep it as is so that it's easier for users to build a
> mental model of what outcome they should expect if they use the feature.
> Put another way: As a user of this feature, I'd be a lot more surprised
> to see that I enabled it and CPU util stayed low, vs. enabling it and
> seeing higher CPU util, but also degraded icache / iTLB locality.
>

Understand.
 
> Let me know what you think, and thanks again for investing your time
> into this.
> 

Let me run other benchmarks to see if others are sensitive to
the resource locality.

thanks,
Chenyu
