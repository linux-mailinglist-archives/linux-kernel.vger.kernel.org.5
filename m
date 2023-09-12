Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313979D125
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjILMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjILMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:32:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF559F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694521969; x=1726057969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Ah+cDcyo6Db634kaIJiv+RlB/9CIQYY0tlOBGxkd7w=;
  b=KEFSbT1t+XANsqz6tLzZwna/5zz7Q3AQi8wowdn9psrPwfqW9WLXzKxm
   v2jzJ1n6o4VbCOGTA8WTBd56uszuJfXalZM1VaRiYK5Zcp+WFw4PkPQvp
   FdK6wxo9AcFoCSyswKm0efosPrc1+qqe20nPoHwMePe3ywp0pnqzXBlg4
   JM5K7zotwvQ5OiooK63Bu+WP7g3v7EJBm+djsX59F4x09HUOudMJq7Ca2
   8y0/hS/XfPearn7BTWbW3cG9kjD7bY78xO2Je4EFTM91KvYY3hwbIXzM6
   hilYQ4yD62S27C/wvIuCNAtHiDePKyi/UYafU0Q3xlvlza0qAtBUS4DbA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357791209"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357791209"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="886918767"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="886918767"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 05:32:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 05:32:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 05:32:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 05:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr5RL5RhzL+cGk+X1mLg1CTZ2RHlhdGXviMsIx6p8z0KRdbaz1M0y9PZoG2egjI2oCMeSExqwqDslIFak18xzCL3r1DwxLJX7FFC9Z8i/Ok9f7zPRRjyb9PG2eHm48wUKeBf+1puXZIk2gnVlv2REidfprQgJBbz3CTJj+H4peT1Zbltwew0YifuRmHmedYn24GsxvZciKZzeNixg2zzbeBSi4f2PfMJi+R4ZQSVHnC2LCldWTFxO4JHADSiy2TJ49hII2qGzXgSgiWGTPH+hVsPOl8ggIVCPPfRAJCLxAY6QsvnpGAeul9/+UurKyGfEYZqmVS+O6UCHFUa+ssIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zZoS+pAg1GytwRZCse9IrEuhONJQvQhkQBDaJijwc0=;
 b=R5aCFv1mnfky/apLiztDVQRA18iut+fU0HFPCLm2ApfODyaOGCT3Bagtyw8VZ/jYtBbMQ0dPDHhY1mOybUC/GxyQRpbcOukJrvqUT7cdzySUjf0jDwU7oBjK1DkXvIj/SqwVtrFe39ml6/iDAKGa5zQfOaCHYkMsmW9qjaY+vquiyPoFa5pHmxt6xVHBDcRHB1k8cg6DdvHfeQ2PQAcOQoLXbhE0cGJPXVCtfmzVvqx0fdqk8qdU6wggGTDsTCfEtVCK+xar+k6JVXB4TlnwprC8tXDuON+BL8Klwpg9HB5e/Gd0cu1OYlfPb+YTc9JHRdnU4KnDaHSixhwnLd3eCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 12:32:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 12:32:44 +0000
Date:   Tue, 12 Sep 2023 20:32:25 +0800
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
Message-ID: <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e32e32-fb26-4dc8-3f6d-08dbb38c5d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGfnkVO9BZqfLZpt5nAoJBwhENt9tu/R/uU/Al/2Jv1m3bT/Sw0MZ/aAx5JLuBYPbpj6OyecFu5BOEwujQWS8MKiKlBHsbDzaX3VPVnJbJLNbuwWRHmQhrGhgVbUbv1D7yLnrtKGyw6dT4p1VE+fNnS+Dw8ZtFyjL+J0nnkwnqHcIxew6PL434wMNmj0sRpaWViky0Zr+60E/IzAAAP4ZuRUV+W8FTHa1weU1DGwDvRnT+YjyRpgKO4tdR+v1iE38c5e8tiUgC8qUbHQqTIz+LiQQw1Z1awEcum+Po2dRqAD4wQz5vM4WTUUwIuNb09Es9SY6ZAZOXfAGEVUylLqSFyxCTv5TYdNcX+DeIUGgCez6x5tldIC39uq2/C0hJBd8vS/fT4eURggZlk8aCcK06UlWlKQjJ+9WWO+Z8nAObWb4uKhH/Tt77X3mYSGfgGTkklS3rA9spRHHsz5q7PzpRH/Q7ulseI0XNH5uwIjcavLqu9MXHQavqk/IArQmXPIXtgu5lbe1laTEUHFZR+UnxbaJgc2flBk4CeUZdSKcsuIP1EENbDxe9aL58FRfC8J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(451199024)(186009)(86362001)(83380400001)(2906002)(53546011)(6666004)(6506007)(6486002)(7416002)(6512007)(82960400001)(38100700002)(478600001)(26005)(5660300002)(8676002)(66476007)(66556008)(316002)(54906003)(6916009)(4326008)(8936002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mW7pWiff9leMjYKZpn9FdbXV3dsKKDc9p3julfX+lO+nESkxR6MYFqoFCznx?=
 =?us-ascii?Q?CrhbhklYPNZkHCpcBKykyRBltmQGrRm3Mx/nW+zqqKtK0u1McZj8JqpxhR3P?=
 =?us-ascii?Q?+svB4VWNj715rcLyISjtDvs4zNZBQLyGJkSJn5dRpocByjH+EdnhHTj9LAjX?=
 =?us-ascii?Q?lv1/iVC0P6nHS6uMALgFHqTg+mqqyD9S1+zycXu5u7m+qJUCjTO498CPbb66?=
 =?us-ascii?Q?420A6cd+sOMCs0xAoaBP6XdBjmuj1MY5DPEH+ZWsLMHFPrfyEvGFM389TO3o?=
 =?us-ascii?Q?Ng9Tyk6XknQh7zjisBtCIpnCjmk9snjvhG2iPA6X7jXcvAMd4ZSDQ/rxYRRa?=
 =?us-ascii?Q?aQVJ++I5mBwSb1xjf6tEhAdYm1bFr/o3pXbM63DoMs4r8C6pyYq+j/UmYgc1?=
 =?us-ascii?Q?Ycl9IPdLd7FnZbx9VaYVqEwSX3tSgIcRh1KUrga+RIv0k7NOIhTky8r1tZZO?=
 =?us-ascii?Q?BULSD1GXpiR7XP0nkO6Vj5GlsxB6bA1+nDM89PjMnasbZcYBWZ/xiGuDuU4t?=
 =?us-ascii?Q?54q0PfL4iARyewc2srCajRnI4pw3Hy0Uk9F/rUcOZmC7Q40i0e9gq650z/ki?=
 =?us-ascii?Q?DbMOH95GEacRrSc/YOOw2r+/n5Xv7z8VpEMeMHNUOoxRFMh9yFK3klP+Wb0q?=
 =?us-ascii?Q?sSQLhaBWKuGktGJLl3lJGn3ofstngAdk/cLTRHF2NT4aFehGRH4d9fJNAb3F?=
 =?us-ascii?Q?zZ/oMQEOcXG3KE6+pE3RXsjaB0h9ue5KW+gOAN5sK8vNsJI+40/muQDfLXGU?=
 =?us-ascii?Q?oYld9yEeN73VLpF21g2fV3iso6nVqymfYzDV9+2b2iZldrFy6kbPxvaAi5oH?=
 =?us-ascii?Q?HAEOIcURpUfr8ktIqbKzO72CvlO8Lek2UgYdJLNDcR2ExhVYX1WqHX+BlSj9?=
 =?us-ascii?Q?Qjm5Aq1n+eP/zx7ars7ncnxmP0zvYgDW8arjh5Kyq9XDfSbxlH+kMWm9dEc0?=
 =?us-ascii?Q?0TAiseEHjL75HZCmUIFyi2vPryc+bvflkfULCVSPzmkfYuD845DpHuebPz2s?=
 =?us-ascii?Q?GDQab9jkXixCl253pHaBmiiZnm8W79DSjvO7FTRtrRGeEgeEji8h28cbL4O4?=
 =?us-ascii?Q?Qud1qkfXRUpJD7taJoCatw5/IuCBDQ1bEzu3Tq2z/JCfBD8815cTmE6xVe73?=
 =?us-ascii?Q?uB+gOd/zluR01O2CqD826HUyDkweAOhqodHeuDDcRk9M+51Fu49yqr/z+YES?=
 =?us-ascii?Q?CxUzU43E6HaHXkW2JHmFR5w04FQr7HmNdNOlI64Zeuqfj7UujUQ6TeQoBq76?=
 =?us-ascii?Q?lQLlaEmPb/l1lpWDt41B4/GCxzLCM2WqVVohNjAi/9NBoOoz6G7uydQWsmGn?=
 =?us-ascii?Q?YS4cqicL6q5U7NYWUWxNl9mOZ54NGtermS5jdVzJzCfpp1IGXFd+yESCAEVU?=
 =?us-ascii?Q?Y1nlIt/ntt/q4+DKp0thYEm8bZPDUr4+M90hyJlWVHl8fo9cKVY8Y15OVuxR?=
 =?us-ascii?Q?eRK5qaWHUfqSP0R1FLwR9fKNX0mVz8g3oRpAZiI1KnjNi7LaBW+w14fHh9CP?=
 =?us-ascii?Q?W/zSSJOlOjjtlGiAm6DOLBZ+cdoNo6NRxN3bngEcVF+lkRCIX4/sH9bFMxmB?=
 =?us-ascii?Q?TY81xua74jiWCMKDoNdvp0FKojt6tqpgPyHi68D9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e32e32-fb26-4dc8-3f6d-08dbb38c5d47
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 12:32:44.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQzyNI+b/XxTayp80to0mamWOmdve72CRx6mJ/eKmjox3Wp9Hox4Ewvjh0BUeqTYrIqUKbwXOQNDId1+OWp8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023-09-12 at 08:35:12 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/11/2023 3:49 PM, Chen Yu wrote:
> > Hi Prateek,
> > 
> > thanks for your review,
> > 
> > On 2023-09-11 at 13:59:10 +0530, K Prateek Nayak wrote:
> >> Hello Chenyu,
> >>
> >> On 9/11/2023 8:20 AM, Chen Yu wrote:
> >>>  [..snip..]
> >>>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> >>>  kernel/sched/features.h |  1 +
> >>>  kernel/sched/sched.h    |  1 +
> >>>  3 files changed, 29 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index e20f50726ab8..fe3b760c9654 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>>  	hrtick_update(rq);
> >>>  	now = sched_clock_cpu(cpu_of(rq));
> >>>  	p->se.prev_sleep_time = task_sleep ? now : 0;
> >>> +#ifdef CONFIG_SMP
> >>> +	/*
> >>> +	 * If this rq will become idle, and dequeued task is
> >>> +	 * a short sleeping one, check if we can reserve
> >>> +	 * this idle CPU for that task for a short while.
> >>> +	 * During this reservation period, other wakees will
> >>> +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> >>> +	 * short sleeping task can pick its previous CPU in
> >>> +	 * select_idle_sibling(), which brings better cache
> >>> +	 * locality.
> >>> +	 */
> >>> +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> >>> +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> >>> +		rq->cache_hot_timeout = now + p->se.sleep_avg;
> >>> +#endif
> >>>  }
> >>>  
> >>>  #ifdef CONFIG_SMP
> >>> @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> >>>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> >>>  {
> >>>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> >>> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> >>> +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> >>> +		if (sched_feat(SIS_CACHE) &&
> >>> +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> >>> +			return -1;
> >>
> >> Just wondering,
> >>
> >> Similar to how select_idle_core() caches the "idle_cpu" if it ends up
> >> finding one in its search for an idle core, would returning a "cache-hot
> >> idle CPU" be better than returning previous CPU / current CPU if all
> >> idle CPUs found during the search in select_idle_cpu() are marked
> >> cache-hot?
> >>
> > 
> > This is a good point, we can optimize this further. Currently I only
> > send a simple version to desmonstrate how we can leverage the task's
> > sleep time.
> > 
> >> Speaking of cache-hot idle CPU, is netperf actually more happy with
> >> piling on current CPU?
> > 
> > Yes. Per my previous test, netperf of TCP_RR/UDP_RR really likes to
> > put the waker and wakee together.
> > 
> >> I ask this because the logic seems to be
> >> reserving the previous CPU for a task that dislikes migration but I
> >> do not see anything in the wake_affine_idle() path that would make the
> >> short sleeper proactively choose the previous CPU when the wakeup is
> >> marked with the WF_SYNC flag. Let me know if I'm missing something?
> >>
> > 
> > If I understand correctly, WF_SYNC is to let the wakee to woken up
> > on the waker's CPU, rather than the wakee's previous CPU, because
> > the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
> > wakee's previous CPU. We can only restrict that other wakee does not
> > occupy the previous CPU, but do not enhance the possibility that
> > wake_affine_idle() chooses the previous CPU.
> 
> Correct me if I'm wrong here,
> 
> Say a short sleeper, is always woken up using WF_SYNC flag. When the
> task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
> and restrict any wakeup happening until the "cache_hot_timeout" is
> crossed. Let us assume a perfect world where the task wakes up before
> the "cache_hot_timeout" expires. Logically this CPU was reserved all
> this while for the short sleeper but since the wakeup bears WF_SYNC
> flag, the whole reservation is ignored and waker's LLC is explored.
> 

Ah, I see your point. Do you mean, because the waker has a WF_SYNC, wake_affine_idle()
forces the short sleeping wakee to be woken up on waker's CPU rather the
wakee's previous CPU, but wakee's previous has been marked as cache hot
for nothing?

> Should the timeout be cleared if the wakeup decides to not target the
> previous CPU? (The default "sysctl_sched_migration_cost" is probably
> small enough to curb any side effect that could possibly show here but
> if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
> a larger value, the wakeup path might be affected where lot of idle
> targets are overlooked since the CPUs are marked cache-hot forr longer
> duration)
> 
> Let me know what you think.
> 

This makes sense. In theory the above logic can be added in
select_idle_sibling(), if target CPU is chosen rather than
the previous CPU, the previous CPU's cache hot flag should be
cleared.

But this might bring overhead. Because we need to grab the rq
lock and write to other CPU's rq, which could be costly. It
seems to be a trade-off of current implementation. On the other
hand, if the user sets the sysctl_sched_migration_cost to a quite
large value:
1. Without SIS_CACHE, there is no task migration.
2. With SIS_CACHE enabled, all idle CPUs are cache hot and be skipped
   in select_idle_cpu(), the wakee will be woken up locally.
It seems to be of the same effect, so there is no much impact
to wakeup behavior I suppose.

thanks,
Chenyu

