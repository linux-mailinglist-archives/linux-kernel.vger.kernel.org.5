Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687C279D069
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjILLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjILLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:53:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F68610CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694519618; x=1726055618;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dI86nYafUqLcxiNiwir3ZRJSY71I5+DwdmcWpLHw+Ls=;
  b=WSe95gwmM4W/kSbFWJ83L08/8FbZcGypndR6VMJCFNE0mkg0cwjxyzVO
   9yiIM3Zz+T3JCAZ8debyIv4qd2dZxXt2UI5KVH8abck2/4mFUKJMB0ZDU
   17FAdhQfV2e+mBkM3dZUtS8MpF/bc6C1z/xVQXYlLVJXD+PzLW3b+1gkV
   /nMP97ZCJ8DDdrPtzzVoBUy6rqe624PEOApooaz7MMluLc7aQH3pWprNK
   h6VXRE1IYaVrr+rzYK6aBxOX9PhfQPj1sXOZbzfnaesSjLJ9gujUAbiuV
   E20t1EeGpDd1rOTBltUdPHwvys8ap6doGlcX2uYyQeLPi9KZxB2IAdU5y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378261717"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378261717"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886910587"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="886910587"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 04:52:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 04:53:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 04:53:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 04:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoZAq0i7RogIWVTLvWtstgaawV+Ip9xZTE5Etf+uiSUplEqoK3vBeqhJ/2unaPpHJRcEnU/TmGuLD0IThH1Lh5KC/ntaCha+Kn6XBBZ4nLMqdINTAO7bWTX0KQWCjmfViMzBa2rCA7AydAXgcyOoD3/nsU6wmQ2bd4f25MFivHaer/d6eJrWFu1sPnAy70zrXeyVdRVIIqg3zaFVYSWdRCET2vc9Up82ifWTjhQ+9sTSZ8VGYAmrxCv6VBed9HAVQfCGD29gXsTShi/H47Ij20F3rXRe6ZZTRp46nUbU92/q8WZFvOwGhJhLamEHgfaAiaJaTv0vW5xlblywMpBIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp4q5I+qwa/IBOCOb4I9dpX655np0vGAJFtgFBTeq9U=;
 b=WolI+FrPIeR/VnzW8cCtZpfbhqODdWDAYQQ+ZT8f6od6EHHlkJ61w/AjqeNQIxjl0Dobyp7swamnuSY27b4v+aSvIns9Rb8W08FHGHcU2Gi4tnXs+R47czb26gtoC0MxxDd1yriANl75cfdK9+IGgjH+DjtjXKiCPvM0lU1lYaBlPiHfN+Z9nQOoVrDfpKZgRwhDJtHp64ghHJXi3tBtPkx8ugVP9qm8N1c4M6Icc1fd8Rlo6gV335PVlcZpivUOTM778jckI137nsYifKuzwmtaMq2Ok3s+AopGeDQ9Qv9QnCentr33r5xVyX2xHvzY+qKXzndt0c25AhHuK9Aikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 11:53:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 11:53:23 +0000
Date:   Tue, 12 Sep 2023 19:53:05 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQBRIUYT8PE/UbZe@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
 <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6f4cfe-ba99-4e15-b6e2-08dbb386dda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIm/yerXTZvzF/DmFEIHUxY4KhK0qLtkXTVC0n40aP6cL+CD5fhrK0BeEADrnNE7AUXqEGVTw23MEDo2hmwpdX/ki5wpOOPX9xbhKair44U01tQUYRq0PEYOlbAdOEYMekjzA3v0Yi8eaMrPw2vepOhM6Ost7vg+Zt5I6rqV9izGN+PmVoj0GtyA4W/7PRnvbz4Q1PA/baQPYZU+Ua3bEjLZLOuKS4d5XAf+y8wNsgf5/8bJSS1oyOCpVoxrilLuiZHcGXgmVFYnq7Z3jrS2yWLnEBoJ2rzEWWfHrakjayAb8x8eCViGTVSktgG/TzRiprbz78PCMAZ73ayl1OdW8oKe8pKCcZfn2txmOT32vzdUJv7dUwcNZTBe0y9vyE22MmYNif8Pa/7I8ZC1G+TISYa6JvTXikk9JLCMsIYWR2hHIwLQA+rpms9Ga7m4cWzDIW4jpyeW4T8GrfM8PQPKDJbf4bizo5y5UljTToO69ixohkeF494G/D820NXahIL+YFubQ0GfDpgzh2K0nBuOM6cR/ZYmym/eJHRPhcYKxzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(451199024)(186009)(66556008)(6506007)(6486002)(6512007)(478600001)(53546011)(82960400001)(66476007)(26005)(6666004)(66946007)(54906003)(316002)(41300700001)(38100700002)(966005)(83380400001)(86362001)(5660300002)(8936002)(4326008)(8676002)(7416002)(2906002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6dVgQ3oBzJddPjzWThQ+PK4kAPwF7VY+W8/CVJaJXp+DTNUjsNnXpdXAnF?=
 =?iso-8859-1?Q?IMaCne6rJKUQCRDrFmEVrTxg5Y/H2Tx/pgxEvgh7ebQG4XLNiUn0kBSssk?=
 =?iso-8859-1?Q?H5bI6iJrgk65aMzkN5fNUWVfTrqSVmmuqvF49xDcgtHfjPtAMVWiMuuBSQ?=
 =?iso-8859-1?Q?EtZxAC/zxj+7F3mpOY7PVXPc4Cp5wyrw62oQCYdJNiGwpC/mFE/nmf06nj?=
 =?iso-8859-1?Q?qNXxoagN4z+kRB8AuFosTwaQ29yaGFkR3gCK6IJ+1d7cS+EXMyRVd8RkTS?=
 =?iso-8859-1?Q?l+AtenOydMUhqpDtzg6lvjLvOerRhdVuFcpyudp9IXA5AGOFuIZM16csHn?=
 =?iso-8859-1?Q?KGF5dHMk3lZJ+QR0H3osJbHPfHBplCFB6tYL5F0EEHQm9ISBlEmcWSU58g?=
 =?iso-8859-1?Q?XPN3YV5WqZUHXgK9b7t9gNporIeiXNFsIVMfVzYvSR6sdxaSvqzR9wL25P?=
 =?iso-8859-1?Q?7jfDTDNRAkD7sDQralYObvKPQ5HaRp3z+FiykFvGThMjF1uwgjv7TtuzWZ?=
 =?iso-8859-1?Q?ci2gagErVlm8h84i9+qhMcELy92LJyMO96+qOEk8THVQovRv4IDpbonnWx?=
 =?iso-8859-1?Q?xhmD7CvcVM++ZmWyn+OxNFtOhGrQE94FNV9BcRoXHELEdWPj8e1VT2BVHE?=
 =?iso-8859-1?Q?dG8+KzjX2DpFg8IEZiNE8u1gca7bATyrVFeqzpoCDKZXXfh2l4OuJEt0R7?=
 =?iso-8859-1?Q?46eaJjiwuEp9B+kBoc37PdSYdz0lRMEqbWRRcrMgMZJcd7ZFk4ewcWkaSb?=
 =?iso-8859-1?Q?nwqtdqSeBaC80xWrryTPIrxNvPL13+tEL4TzKXe1AQ1aIaNaRF5UtFgj0n?=
 =?iso-8859-1?Q?Mue1Kdyp3+W+7g1siSjmXssEa79LjVgzVzVVhx9rSjRVBMOp57+m3Tjxws?=
 =?iso-8859-1?Q?CQTBBz7xWv/N+z3rDjMkWD0hHhsQqHPVTCPzNy5HeUsHyFF8JuVGOfW0J2?=
 =?iso-8859-1?Q?UqZpyGpYWHIfPd6osm8wJp6EwVHEmpvGEjReHBdJ+Y92Cw5g8ITb9uvFqG?=
 =?iso-8859-1?Q?OSlDCOtRZ0SM+YqqECe6+LjHsH7fch7mozKx+2Y5m6AZKcuBl+uTVqkPA/?=
 =?iso-8859-1?Q?lnGB7rSMGJUgyk/Rz7INy8iTrL953hbdGtDuzpxTBYjoucOKEXMLjUD90z?=
 =?iso-8859-1?Q?jmVi+YiuEjQFgv155zBFwL43PRauOh5PojFnMwbLhXVpuzbw66jqOmepRh?=
 =?iso-8859-1?Q?r4mSGweBYJ2kv1hXJf4JlVMwOCWTM3226ZvHwXMaDM/pRa2UR7e0VJ9FWt?=
 =?iso-8859-1?Q?ufs5sg15ELGKvwYpwEd0y2ofovqVtw7GyrrrdA8HkbZhZr84LGxhIkgJWD?=
 =?iso-8859-1?Q?jyS8Af3pgkVR7MutRpNAndo2QNVQVO1UrnuEoB0nCwj3vUz+psArt8sM6Z?=
 =?iso-8859-1?Q?aOLonURaFEPN2hVB21zx3fHL9EDvUgX2J6joh6AOhccjoUoxLE6UpDr16v?=
 =?iso-8859-1?Q?GFa6TKmF+YBl4RQlzDNqqS0Eig/ngZTk097etxv4uZXsHUUMlbDyeip2X1?=
 =?iso-8859-1?Q?7ECwcYJR8XB2FoD5j/5SSVrmnDe/4YxirQRHR3Vt3FYrW0zyJmFyjJRbVX?=
 =?iso-8859-1?Q?NcVuhYQJSFLuuffQUPLYdom8DRnGeJQlu2Fp63yUi0nVgcrK6oVy+3Pijk?=
 =?iso-8859-1?Q?WZGEh/KVOKa/L9U+Kk3Bd2IdbHyGRa9aea?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6f4cfe-ba99-4e15-b6e2-08dbb386dda0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 11:53:23.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REL4BEg5P9Cgf8WtSt3xPQcHwLCKrtE09Rbvgeimxj0BSSs14OtmCZMmhQYXgS+A7Ju1UpFN8SGfkO1ncm6mzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

thanks for the review,

On 2023-09-11 at 11:43:27 -0400, Mathieu Desnoyers wrote:
> On 9/11/23 11:26, Mathieu Desnoyers wrote:
> > On 9/10/23 22:50, Chen Yu wrote:
> [...]
> > > ---
> > >   kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> > >   kernel/sched/features.h |  1 +
> > >   kernel/sched/sched.h    |  1 +
> > >   3 files changed, 29 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e20f50726ab8..fe3b760c9654 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq,
> > > struct task_struct *p, int flags)
> > >       hrtick_update(rq);
> > >       now = sched_clock_cpu(cpu_of(rq));
> > >       p->se.prev_sleep_time = task_sleep ? now : 0;
> > > +#ifdef CONFIG_SMP
> > > +    /*
> > > +     * If this rq will become idle, and dequeued task is
> > > +     * a short sleeping one, check if we can reserve
> > > +     * this idle CPU for that task for a short while.
> > > +     * During this reservation period, other wakees will
> > > +     * skip this 'idle' CPU in select_idle_cpu(), and this
> > > +     * short sleeping task can pick its previous CPU in
> > > +     * select_idle_sibling(), which brings better cache
> > > +     * locality.
> > > +     */
> > > +    if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > > +        p->se.sleep_avg && p->se.sleep_avg <
> > > sysctl_sched_migration_cost)
> > > +        rq->cache_hot_timeout = now + p->se.sleep_avg;
> > 
> > This is really cool!
> > 
> > There is one scenario that worries me with this approach: workloads
> > that sleep for a long time and then have short blocked periods.
> > Those bursts will likely bring the average to values too high
> > to stay below sysctl_sched_migration_cost.
> > 
> > I wonder if changing the code above for the following would help ?
> > 
> > if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > p->se.sleep_avg)
> >      rq->cache_hot_timeout = now + min(sysctl_sched_migration_cost,
> > p->se.sleep_avg);
> > 
> > For tasks that have a large sleep_avg, it would activate this rq
> > "appear as not idle for rq selection" scheme for a window of
> > sysctl_sched_migration_cost. If the sleep ends up being a long one,
> > preventing other tasks from being migrated to this rq for a tiny
> > window should not matter performance-wise. I would expect that it
> > could help workloads that come in bursts.
> 
> There is perhaps a better way to handle bursts:
> 
> When calculating the sleep_avg, we actually only really care about
> the sleep time for short bursts, so we could use the sysctl_sched_migration_cost
> to select which of the sleeps should be taken into account in the avg.
> 
> We could rename the field "sleep_avg" to "burst_sleep_avg", and have:
> 
> u64 now = sched_clock_cpu(task_cpu(p));
> 
> if ((flags & ENQUEUE_WAKEUP) && last_sleep && cpu_online(task_cpu(p)) &&
>     now > last_sleep && now - last_sleep < sysctl_sched_migration_cost)
> 	update_avg(&p->se.burst_sleep_avg, now - last_sleep);
> 
> Then we can have this code is dequeue_task_fair:
> 
> if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.busrt_sleep_avg)
> 	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;
> 
> Thoughts ?
> 

This looks reasonable, it would be fine grained to only monitor the short sleep duration
of that task. Let me try this approach to see if there is any difference.

thanks,
Chenyu

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
