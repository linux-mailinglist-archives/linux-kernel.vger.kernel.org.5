Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3116279BCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjIKVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjIKKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:20:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9ECE5F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427596; x=1725963596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5kVEk4YHYxwttP6kGAeK1/9NEKNIkaVtfzCVh3LRQOQ=;
  b=kNHa1hd12m/UL0pMOIuojcaHZQqg7LpZVOEkZsnGOgCOJKiP/f6F9DNH
   d+Pdsfb7sxghIuFcGcVlIYK3E8t15xyr+T0JIiCrjc2AZ2E/+Je4psRli
   bV1OMgkUBObewLb/9B4vqy+ATAQt8D2Uf5V+hIAK+/FJhT6esFNDysGfG
   hMvoK195NLDO/ir//KzHCEsNcryOEpmsmLpX+X0wkxEPA9LcM1vYgYUFy
   god5KmR4YaPSCgdmI2r0Q3o5U/GUiO6Yt4IH+H7yH9G2ekPZo4yChC/+q
   rlGGGgAdLk6NDpPmbWLGwqJhZq//VYkErpg6qvgNWI9nUdOZVPs3S/8cv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381845821"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381845821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778336486"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778336486"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 03:19:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 03:19:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 03:19:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 03:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzxugt0dvI3dnSEhdPM0fKnHq3Dq0dP196hRfwbgpgLEUtoHaycqxxKwtD5/D23S7GcY+23uQncosZ+BeaBKLVHb9lz6dZhnlFXPqFSi2Yc7MS1xAYMXE3A8FUF2wX7zoTpoSQ0JoOS9deka2W+7NKl4jz+B/0Mf5E2KSDV8rYIhsCwhnj0FbJx3wBjAsUx/pjFZ7lzZfLH83CQgmKQENzqSGh0cj1/6D+2s+aE4L8oolUBu6YjF1meqk2bmL1hnAV764bNuvpnua3OSrhUNuUcOLCLElopRwUNZmdQJkcmJ9ucbOm+oplKKRvdHB/GuTosOph8fQsHfoSZD1UyigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56gzEgqmtRle+xpYWdyEnyrbYb4stjU9CKnFP9EJt9E=;
 b=jfDRniXC90LRzgdrnYJ6/rJYzEPGTY2Ts1dYedfYCEmT8DN1hrGuTCrO6WTUjsPbTlqBpvupD+sWvzKBLH3GXMk7679V8Ri1+v2TsCQPGwXZDgMdbDl4vzcJwTWKnwHEsEr+GQTg4eiCx+1JlWRbNZzDUNfaVhc6V2f4AfF+/TBrngRDqImUiNN3G3ow4bzaU1RZiAkD+eH2S9WohwIn7aKxRKkP0W4YZleaFe8CRq+UYrsEFNCxjVEklgNAVaQifjTyw6HtbYEwLreRGMZU7wevWibsGI4Y7318Og+hfcQv6c0r2qHYQNx22pCirsO2s196num7y3BQJZxqAqzGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:19:52 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:19:52 +0000
Date:   Mon, 11 Sep 2023 18:19:34 +0800
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
Message-ID: <ZP7ptt70uF10wxlg@chenyu5-mobl2>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a8ef4c-f348-48a9-22a1-08dbb2b0a2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PobMA3idV4Bfw8i9v2+ItIjbP0Yz9FJk5jYJe/nE9gsScEfeTfeNQPrZfkRaW5nWswfhmmN94U7no6n9GFybkHnTuj8QrfPp/4bhGEwdn21aV85fG0kpDLR7V5b3jhkEID75t6BKZbllL7BTqgcl11ow53xK3l+PXn01pZ7F3WVZ1Cx1jUsSL2GTnYYqvXOo56nl6E3QV3Xtclifz1XkNKmfA7XR1Bzf0/nMV5Ca29by73oei4wpiWmWBl3t2DXdgDrcu/HVO75+dbXD4u6NrqhTudLg3pt9uvThrclOScYur3OcWkdJuwlhE6Hdo3zxK+tsp/chYLZAsSF1jTXCizBbiVimKxe8quHktuO6fRRDIlaL29KXuNaGBaIJoBxqgbwaTSIxmj9mk3m6+SUbFYQHJWCxwNVSfXZZQkbLh/aH1gbDupSxhHO+TOWSKxdoHlTvBwmCNnGH+wnA3ZfymzSioPOK9w41VmhZ47s+TT0/rCMRMmrViP38OKMt39eK2ml52ZwKTFpFy++HqTKdP0EzjlO8y/sVCIvPEcto6jvC3Tlp/dzMeA/NIjF86zT8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(33716001)(86362001)(2906002)(26005)(83380400001)(6506007)(6666004)(53546011)(6486002)(7416002)(9686003)(6512007)(82960400001)(38100700002)(478600001)(5660300002)(4326008)(8936002)(8676002)(66476007)(66556008)(316002)(54906003)(6916009)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SuogIgZkYS7u2EWIfc4kqsuBVustMj8hlTjgNtJCtGHzWUWWYEHNsgFFtMdy?=
 =?us-ascii?Q?lXdjhclJhjREs7kV/kq6GPoFT74wRZbBLCMBWjRX9qPsxFNxdASK809CubCk?=
 =?us-ascii?Q?11rZlJ7aBvz/9o/iRNMSABfniZlJTjQrDD39VDOyU+Yo3gDcB4xoESSqEKLm?=
 =?us-ascii?Q?Ygzp/egnblRTuhOowh6dV0v+b/TwV0QPz9Iy0zvE3efNftd3QBREO9xG9sVO?=
 =?us-ascii?Q?heN4a1PWsrSpx4wy9f8A/UQm7QEQKcQAyHS1v7c7hAxXOPKgnzeCjooHM7FE?=
 =?us-ascii?Q?MFHB1jH2RUF/6leUhXB2kuU9hIJk2IZ8ua/9qCh02t6HGr0GY+zCxHcMUEjO?=
 =?us-ascii?Q?wVXxaVLPD/kAVDGcT/oLD3zlxL6t+nSxSRflBrJEEuJbUvff4c8nrmHQv2yW?=
 =?us-ascii?Q?6joudXBZVsuTWKzP25DfcB4D3/8P3nIFi7qGrM0cMATFuq+ZDRrSnxnLNhXU?=
 =?us-ascii?Q?c4BbaFzMxMDzGQGeL1vRfLICzkfVvqVwJV/lZSYmddzfFSg2nIpfliZpe0ym?=
 =?us-ascii?Q?XEuQ3v7ISYz1D+agVYsdaZRqwpDyFq1g9c7G9nvx96g0lR4UbdPA0KAX455y?=
 =?us-ascii?Q?0kwz+vKiYrN081sQnlwMEXSGvp2V+p2CGIYHTiMzxknj3sGZxgf//4Sg+28Y?=
 =?us-ascii?Q?TtVUlCXhfrCx+jhkCPyBx0cGQBXEFDeTjReF4AyAMSr0/n64fKdDEDVgAKbj?=
 =?us-ascii?Q?pGc6uneAdse9KDLnEEuBFaJuO/FBa7XewoupR7g8aQy6s+9Qs4jfzNd4bXwD?=
 =?us-ascii?Q?J9crlGopPmGyrgTVfEe4MMZppe9Ur8JoNqfgrFF7YcJ706q5bw0VmJcd687v?=
 =?us-ascii?Q?O5DZfzNLlFECB/dz50RgFebVq+mkGhE92bxKl8VUsQO8+z/LwVAt2IxMzB+w?=
 =?us-ascii?Q?W0Y4QztHiVnsWftN7on1C0MCIohDAZ2lDuZt6DImFxi+j9Ue/DyIF2HBc22d?=
 =?us-ascii?Q?FhlmH2a+ErLp5Ip4c+DhrB4fQNBWiyu7Gm4yqajeq7YRf0SwIA34dHX81Hnb?=
 =?us-ascii?Q?3P3AtgszG3dvQ62Dy/LbHQKXfSjwhMAodEpz1lADXJaCtkldQcSN6bfG+sAI?=
 =?us-ascii?Q?RN0DGOXiZdWK1X0ZVcdpXuTaLJtOe5m/4BMy+SRCQ/Jdby/HTX9nZukY4/Bs?=
 =?us-ascii?Q?S65uObmCRJzEUria8L1HiB1WqUARMhbEQ8cgt/E+45yd7niVRlYC5iCohRfD?=
 =?us-ascii?Q?UjVleys0jbiIrq1woWt/YP4Mhfh8QdaHKFH+uctI+htOShZ3ZhkoeNGD1mrq?=
 =?us-ascii?Q?rKK+tgfMGiAYxwHTG+gODpPurENhqze6IlOceLllm6qJKCAbyi752MMeA+pU?=
 =?us-ascii?Q?odcjnL6y3FroDdc1WFDMou22bw/SKQdMahYd/wQV5am+Y4Aqgl65FJRoBSsV?=
 =?us-ascii?Q?j9GqN1+IRog+yO3d9Mx14LtexkvasMrW5OQEBVyGJK6+wBtgAm2GBnfuKv5D?=
 =?us-ascii?Q?juUEx7QJ+0gWsCGOdLNJntR31R16q4/+bbohOWtKNYpYy6XV8VhawWybvALR?=
 =?us-ascii?Q?o/cxVThclTfHtl0mAdgq265gKnUj8u5KY3BqDu1A3NpsZHUBndzx5BZbisbw?=
 =?us-ascii?Q?PxDUxt8I0OcpvHTBFXUnh9TNa11HlbSviIF2wR9J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a8ef4c-f348-48a9-22a1-08dbb2b0a2f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:19:52.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABfGCtWNAWuD2vBh/hQ0luE8oPCGerGdI15tOHlPVOxj+AGbL1/Niect1px56V2M8skg3CVO9MczXEyIZtyQGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
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

Hi Prateek,

thanks for your review,

On 2023-09-11 at 13:59:10 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/11/2023 8:20 AM, Chen Yu wrote:
> >  [..snip..]
> >  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> >  kernel/sched/features.h |  1 +
> >  kernel/sched/sched.h    |  1 +
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e20f50726ab8..fe3b760c9654 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	hrtick_update(rq);
> >  	now = sched_clock_cpu(cpu_of(rq));
> >  	p->se.prev_sleep_time = task_sleep ? now : 0;
> > +#ifdef CONFIG_SMP
> > +	/*
> > +	 * If this rq will become idle, and dequeued task is
> > +	 * a short sleeping one, check if we can reserve
> > +	 * this idle CPU for that task for a short while.
> > +	 * During this reservation period, other wakees will
> > +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> > +	 * short sleeping task can pick its previous CPU in
> > +	 * select_idle_sibling(), which brings better cache
> > +	 * locality.
> > +	 */
> > +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> > +		rq->cache_hot_timeout = now + p->se.sleep_avg;
> > +#endif
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> >  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> >  {
> >  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> > -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> > +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> > +		if (sched_feat(SIS_CACHE) &&
> > +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> > +			return -1;
> 
> Just wondering,
> 
> Similar to how select_idle_core() caches the "idle_cpu" if it ends up
> finding one in its search for an idle core, would returning a "cache-hot
> idle CPU" be better than returning previous CPU / current CPU if all
> idle CPUs found during the search in select_idle_cpu() are marked
> cache-hot?
> 

This is a good point, we can optimize this further. Currently I only
send a simple version to desmonstrate how we can leverage the task's
sleep time.

> Speaking of cache-hot idle CPU, is netperf actually more happy with
> piling on current CPU?

Yes. Per my previous test, netperf of TCP_RR/UDP_RR really likes to
put the waker and wakee together.

> I ask this because the logic seems to be
> reserving the previous CPU for a task that dislikes migration but I
> do not see anything in the wake_affine_idle() path that would make the
> short sleeper proactively choose the previous CPU when the wakeup is
> marked with the WF_SYNC flag. Let me know if I'm missing something?
> 

If I understand correctly, WF_SYNC is to let the wakee to woken up
on the waker's CPU, rather than the wakee's previous CPU, because
the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
wakee's previous CPU. We can only restrict that other wakee does not
occupy the previous CPU, but do not enhance the possibility that
wake_affine_idle() chooses the previous CPU.

Say, there are two tasks t1, t2. t1's previous CPU is p1.
We don't enhance that when t1 is woken up, wake_affine_idle() will
choose p1 or not, but we makes sure t2 will not choose p1.

> To confirm this can you look at the trend in migration count with and
> without the series? Also the ratio of cache-hot idle CPUs to number
> of CPUs searched can help estimate overheads of additional search - I
> presume SIS_UTIL is efficient at curbing the additional search in
> a busy system.

OK, I'll collect these statistics.

> 
> In the meantime, I'll queue this series for testing on my end too.

Thanks again for your time.


thanks,
Chenyu 
