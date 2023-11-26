Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562587F91BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 08:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKZHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 02:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 02:21:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE82101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700983325; x=1732519325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OcrVfh5/LLGNxBN8mWoj8K709J6vgwc+oX5n99In2v0=;
  b=OZDbIGKNUP4bJ/Wx6Ustl0483TyH/hBpbzt7t4Qz6eFp61dRroM+Iavx
   tBmoRJi9lBrj8i6h8s6nnC980VsxH+aOJKeISPrYfLkLzR/c0rsaGWpSz
   9apjjCX4ZBrjrYesC4H6YQGOFDQdD69MPliKQapxn7JuzDkFZr/V1Dz3W
   4UihJ92bGU7PvNBzAoGbAAuSkTzeqERut4BjCq0aKCuspWw20GBMuJjLm
   O8fX5DDfmmH9RE+E1DSGm8z2Y5tyGO92tXNK9aBlculRXMGqLzTpKhAB/
   HlKgFTTglb6Q7keDnbP4PxuSrthm2gZ0HWFOVzCOYaCk2ITklCGJgtuvB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="14113541"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="14113541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 23:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="885662797"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="885662797"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2023 23:22:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 25 Nov 2023 23:22:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 25 Nov 2023 23:22:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 25 Nov 2023 23:22:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 25 Nov 2023 23:22:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+7Lr6JvdsTjx7bz3WxVYFhupCnEd1nWC56G6CEabDu9dSuBbnhFGLUx9217XSK6WHaElO2ooIntOpIT0hIfeKJMyf5lBJpnXOzbnlPEihdc7tLp64cGK6NqfR8F16fxXtN6PaghFwURqy6US/zlIIx5SlIDCaUSlL+rCGHXsgFSkgwj0SpNc4QURad45TPVj7it08rkDi2K4+rfQfnBSrpngBQ1Vrk84x0mEmFpFcx+l/tnlmdOTeS7i3UQs3O2u2NrCpcsnjCbvRT5UCOc+h1D0Hm9W0HssrlBwMZAkqyGYOgdQGfk9cFFbOgoz5sXh6ulP60oWf7BplXlEopwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QxErmmB8a6BbBmgIRo5T/UOn4OUvK8XqpUB2sfIX2I=;
 b=KCGxyUDcBQhcqlogtqZA0K8iwkRTL+/hkwkIhYmYV2FJkIIg8MUGJHwDVeDCEQlv7EH9B39a1o89bZzeXY3fD1C4ccTY7zTPVAyYpyJBmgKyH1S5zn/h+kMu/lfe6OjS+Cu5PhIEf8h0GGSX6wNPY2gkXnNkICCfbTezL4I+AiM8ER9eEB4Iv1ibFUxEZmJoUZjyMkWpLDn2R0cF+bZJ6lpf1Eriwfj2pqbuGJUG2hNP8KrwRMI9KvrjC/ahL3y0a787CcCvckT+Th/VxgRBf/2M8nQhQPNFAev8J1/XrwIpCRJ7hrhJac0DhvAS0f1mMMNrut5/5uy+G0SDVEur5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 07:22:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 07:22:01 +0000
Date:   Sun, 26 Nov 2023 15:21:46 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        <6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] sched/fair: Calculate the cache-hot time of the
 idle CPU
Message-ID: <ZWLyChTTXq049zRy@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com>
 <29f5225a-e0fb-2381-4f19-49334a0dbbc8@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29f5225a-e0fb-2381-4f19-49334a0dbbc8@linux.ibm.com>
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: d86cf34a-d3e2-4982-1238-08dbee506171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxJfqDErmaBPz/O5wYuOH6j1vIJ5orFvzANZwUyFY527V2RIpB84u8nnFwPVco+87prNjorAYmvbggeFKY3Lnl8byFpBuhEPqTsyHs4FSEaAUeJbUvpJKY8F9vfvIuAzaofNv2Ih1qnkbr6Lpz3rL4g8Q+jmZxLK0TJ/KdhnzJyj+ak6/KbbxcBDEiY4yo7n1XwOUtanfS5TuPHA//CD8FpyH6xzT/IK7rTHgV1hEbCYYqXrJ+g0i5WGf9gHbDoYjq0veW6W+7aMLtEH6sP86tdTW+t8LACw8qMFpya02eUc7WFI+aIM6TcEb0zOvGzn09JMl6sHo+KjpwYwmqyIFUJvJvsR4bWAIE8jKNqjoeEvBaXhUI2xxfFJD7ZUqeSrh9kRTo4dl92kqiPyOZSRdAOS9ox722ph4F4HKZsTuJNsevgOKTqSEB2cIw3VloBRelhI1DyCT1A0NOTGz1c3HUCHFapqZxFoBZMmo2iEtKM8yF2jGrBl9DRNkMEbM50NRj//Zs6PLZTfW+QOeoYmadk5fIto3VykT997p0AJzYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(6506007)(6666004)(6512007)(82960400001)(8936002)(8676002)(4326008)(7416002)(86362001)(5660300002)(478600001)(6486002)(316002)(966005)(54906003)(66556008)(66946007)(66476007)(6916009)(38100700002)(83380400001)(53546011)(2906002)(41300700001)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyHfHqQqMBRywSWtr6EfvSq7npUz8OMLXOaill7cyREbNo9JScgH+Fl/M/jo?=
 =?us-ascii?Q?nYJX29DjChGal4AayF9izVfLxHkyB1507eb9nEEKtexU+VTc/J/EPAhPRfUZ?=
 =?us-ascii?Q?S9Y0ITUYFWPInbn0m83GVIMbWdh7bdxALaG3tWVxonM1wSBUEbC34DPm4BYt?=
 =?us-ascii?Q?ANyHch4urTzOPlFHXca7jf+lqyJTpRQu/psZ6flwnzRipRkMxqb9wbwntSXB?=
 =?us-ascii?Q?ZW0Q3zvWvisAjb0+l/s2Ilagx5y/xKa75a7pqsaAIrengLrW/CEYWTxGj+Fc?=
 =?us-ascii?Q?Q1gbjgQ3tv/VJUVjXHW96PcgFcLqB8TZWTfqfDsULE7PWaLajMIdLFanalQF?=
 =?us-ascii?Q?GQXahBj+Xtl/XmUlbxghQcAWkFRm91DmWDX1JlbSwLUpicylD7ipkBk4+OvJ?=
 =?us-ascii?Q?21bU9kZNJymCciQsnPJdRV3m2lsPfPDFoQ0N9PMd4u6VRfZ4wbEYgUosVM0T?=
 =?us-ascii?Q?qw9vvwWvhGfWMMeuoQGCqKxUknwBJ1z2P1B0lzPGkdQWr2uYV6OjrepY+Hbx?=
 =?us-ascii?Q?iIFUR6DQU85YMzNay9dsWitei7UpR7sMccLGsRyrVSJlYfiT9cVpDAft+Ygd?=
 =?us-ascii?Q?JiqgjX5Vqonp4hfTHEn6MqcWIbKqdD5H2AE2qtxX2RmLmOvVCyOyLVxoYI94?=
 =?us-ascii?Q?wOETCPh+1ahc8TuxazzDFrvXNnBnUmIzzVbNGDnhXuYL4dMt08tr0UlyU4iP?=
 =?us-ascii?Q?N3pyLeZH+q4HmZd8+MAeZS/XGzkxxdqDUw4K1Bxr3Gnwz+INEJ7HthBhMC9p?=
 =?us-ascii?Q?Cb/sQ9rY+zzz2XwGpVx0veIjtXzZoEVj1JfZ/V2jU4KNkmCZ//c1EsvRVHH/?=
 =?us-ascii?Q?4KoiuanUKs3KHmCG6Z6caoszKkWbrasoXGioyHdPMpxz9/Fs3t3Cx5KgMQAj?=
 =?us-ascii?Q?rEgzTvylDmmOp77+31EbvHXrjj13LMsHTCAFWJTPadEd9/HHHzTqwceozsdk?=
 =?us-ascii?Q?+3DZAnXoddzoUeVF05NoGt4Ixcytzid65zCi8VxSR6J3lM9+fGo801QupsSf?=
 =?us-ascii?Q?SbUQt2ycQ1Mx/MV9rWbnwpKFzv8J2jlkG7XilmdgW8asGch4FlFHoK0w1YEv?=
 =?us-ascii?Q?+623vxBeouu5aSpN0mtcciHqSsXTLjh2568Mnl++yOP/C/zwRVxOkLyyXTMT?=
 =?us-ascii?Q?IIyuVETrqB3xgtlYXCRrBVBFEhx8LdXILNLBQ0g2QH/63cDwAZlJwSiKLLrW?=
 =?us-ascii?Q?dRtvnO3hPLXhZQl8eAsM+wm7G15OW8OxneVx+MJbKDgea9bkWbnOP3oBr77q?=
 =?us-ascii?Q?GyaidA5vyxlPKv798GtFV4Exa8x/QHfGG3Gsti66UfzYAcPuebqGqa99GQRK?=
 =?us-ascii?Q?3ESeedRAu2H63gh9DdEjCRID5nFwCqiwRdAisnpAa4NEPLiMjb9NBepVClLN?=
 =?us-ascii?Q?BgeLN7GUqblW05HLKWlVuGiokYyoKJidABJpwz9GTMNE1sMyz6lkSyeM68Hb?=
 =?us-ascii?Q?oCd2FFgO4eU4+Zd26NKpg/BEKPjcJaLfdKOIGXm0pwB3Ez1FufDl2V+t15sn?=
 =?us-ascii?Q?x5yIyIPc+S8h5vNpeMEniz7U1ZYer50q7dz/PBMRQwTZ6o+bmez+QgrORsO4?=
 =?us-ascii?Q?fc7s/d7ViXkBBiuO0MFywUmlJcKGDCWwvFqup86A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d86cf34a-d3e2-4982-1238-08dbee506171
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 07:22:00.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW00vx8lk9GoEf9BBt9Bx/FVOUU8raUgy0ncgpyFOn5kVE5+fMDgt1PQLrbdDVJxDifm4/HT16iBwSJnwz5MkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madadi,

On 2023-11-25 at 12:40:18 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 21/11/23 13:09, Chen Yu wrote:
> > When a CPU is about to become idle due to task dequeue, uses
> > the dequeued task's average sleep time to set the cache
> > hot timeout of this idle CPU. This information can facilitate
> > SIS to skip the cache-hot idle CPU and scan for the next
> > cache-cold one. When that task is woken up again, it can choose
> > its previous CPU and reuses its hot-cache.
> > 
> > This is a preparation for the next patch to introduce SIS_CACHE
> > based task wakeup.
> > 
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++++-
> >  kernel/sched/features.h |  1 +
> >  kernel/sched/sched.h    |  1 +
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 672616503e35..c309b3d203c0 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6853,8 +6853,17 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	util_est_update(&rq->cfs, p, task_sleep);
> >  
> >  	if (task_sleep) {
> > -		p->last_dequeue_time = sched_clock_cpu(cpu_of(rq));
> > +		u64 now = sched_clock_cpu(cpu_of(rq));
> > +
> > +		p->last_dequeue_time = now;
> >  		p->last_dequeue_cpu = cpu_of(rq);
> > +
> > +#ifdef CONFIG_SMP
> > +		/* this rq becomes idle, update its cache hot timeout */
> > +		if (sched_feat(SIS_CACHE) && !rq->nr_running &&
> > +		    p->avg_hot_dur)
> > +			rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->avg_hot_dur);
> 
> As per the discussion in the rfc patch, you mentioned that SIS_CACHE only honors the average sleep time
> of the latest dequeued task and that we don't know how much of the cache is polluted by the latest task.
> 
> So I was wondering what made you to put max here.
>

Thanks for taking a look. Yes, previously SIS_CACHE only honors the latest dequeue task.
But as Mathieu pointed out[1], the latest dequeue task might not have enough time to scribble
the cache footprint of some older dequeue tasks, and we should honor the sleep time of
those older dequeue tasks. Consider the following scenario:

task p1 is dequeued with an average sleep time of 2 msec. Then p2 is scheduled in
on this cpu, but only runs for 10 us(does not pollute the cache footprint) and
dequeued with average sleep time of 1 msec. Should we tag the CPU runqueue's timeout
as 2 msec or 1 msec later? We choose 2 msec. The idea is to make the timeout moving
forward so the SIS_CACHE could make it easier for the p1 to be woken up on its previous
CPU.

[1] https://lore.kernel.org/lkml/2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com/

thanks,
Chenyu
