Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673279D35D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjILOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:15:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA28CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694528122; x=1726064122;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+ORwNwf/i9QJDP/2C8O35aeRzBA42yRQtHuk7zgGn0k=;
  b=Ump20ZuNzx24m0Shl7LAA1ZMa7BzwwBm+Z0XP1pr7lObW1fntgUFxPs6
   ZetLxh5o8XDH7f+xjfEDPsUKIXw1bb1mSbsktf9uNiHLEUSj2DpmdTY8w
   5hzvK44MUVgnNyo4EoxmOTBr+qHcDZk0juZZ5W/bCT4owbCQmhL/w2M6J
   PCzc6dzG/vCJG+e1tQMXD3YHb8cpwrLXf8kwdw6Aqct6hoQMfy7DoTqQQ
   3BFBQDzDDszhvNAX1aPQ+kTsyMn/boNqlEOkDwEx6ndvGZnIgV5a5REgy
   m1q7SxXaKu0ZOH9eGGLO3OcocnftvTOxf/Gbp0j0yK0gvjefcngL0xkLZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358660538"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358660538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867403026"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867403026"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 07:15:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 07:15:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 07:15:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 07:15:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 07:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD2jIDJ1zudX3iGNGuvghEdHGwJJCuW1/Tf1IUw6rvAYC076epDcsfTN/d/6sx5o/rh2dYKsL9boi3TdOD/uhAu0IGGnNE6bLgewnEva3Hb0bFv8iWN4NPM+RcO+oHTSCPTwCddrVXEVVYxWSSy1AH8PAO8NHXcp4XmandwYadILajDXtXksQTiKDlggpdb8cfPeTWCQmNke3dHabuIjc94oY95SmIqrGyUSojAVfWkj9cHFkDGTOiZASUwHkaEJD8lsxHlm1AuFXzmZMxufZWDHJ+tI7mBAg7tVqe+zJHcizvI5LqCsuwDD/9mli6TJ5NjrjsK21Tpiu8iv5AC4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMpIIuXnSMe5W4nGIersiCYUiMIrbWzfY6w9kYOnq3k=;
 b=JeaOm74jll8V4qJtWZ8pSetRqqF+lxDNMo4vVtw8eg8guP4ORQcfIrUO/NwlCXDOfZHD6uwIBbjJxNarGLK9bQuNrvSmOkdQP2QNxnVSbLxlWFhder8+nva9d++6jbHoLhw/naSUtfyVpiK5s43rQbJhpIsnDQnHy8bfPuPZul3kPNgkq6pOmdUEfSxwueYqrTrAA6+NyDWonJXe96CSn75Lxn0HT3jp9ao1/3dXGRlvzh4KmQNKB5oDKXxuQp4+QNwlUsxDlh13eQOmFaURSszuOd7KzS8EL3+LzOIC/R/TY2AxLay0INdkUsK7EY7Gr720M8sdU2zyROK3QS1+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB7506.namprd11.prod.outlook.com (2603:10b6:8:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 14:15:17 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 14:15:17 +0000
Date:   Tue, 12 Sep 2023 22:14:59 +0800
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
Message-ID: <ZQByY4rDvjejRRs5@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
 <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
 <ZQBRIUYT8PE/UbZe@chenyu5-mobl2.ccr.corp.intel.com>
 <244ff1b9-c51e-be9b-0755-757f969b36e1@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <244ff1b9-c51e-be9b-0755-757f969b36e1@efficios.com>
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 35548bbc-37a9-4ad0-eae9-08dbb39ab072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhXyvU3wNJ0nBDPhHThq/ec9ey4IDyneRdoBuFlidp/qIsV5z9W2INuNMleckOD+UmwB5Lal07gKp5rRHzMJiAn7U225S3CED+/UXy5wJYUtglq2V/zliPcntt5FPRygxbA/76xEr7IS9vr+aioB7/C+Fjpl4o0LejKBZZI1wBTO/h+BaP4/Ean4TuQMxCkGxlOkMBJzwJPZVPUPCWC6rkK+5+hZiJiHONtNhVzAyo8kbnaVgk89CXM5KUF2eeh4BqKuwE8LlMFFOxXEP2NOYEcTZoB+tKg/iZT/Wr57MRDl+55kY8WEXA/smsJG/EMPyQQ8UA1qM/YuL0hgKX6PP6OOm5Cw7XHJbeeZP6225JMy/WWjl3j4biMuNCIpY8u2jQvN+0L+2foIL6wzIs4Hg5Qd/22uckZhF6zGuETi+2oiTgXgtPjk7upVrMS4/MWQwqbIlzDycYb4BSkqTajJDm3RZJyfmUGANoEaMDnqhgH9r0rgusSMQN5BDYozjVWo5B+8Fd2g0a/SJzLPsBOzUVUaVXwtL3wXpPCG1U64tc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(1800799009)(451199024)(186009)(38100700002)(53546011)(6486002)(6666004)(6506007)(86362001)(82960400001)(26005)(2906002)(6512007)(83380400001)(478600001)(966005)(316002)(4326008)(41300700001)(8936002)(5660300002)(8676002)(7416002)(54906003)(66946007)(66556008)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mbbQ0Hk26xCWSeoiXldgFDcaXIT2GbhkKvsPBqkxZeiUGkh00PDdtJP89t?=
 =?iso-8859-1?Q?0+kuzHAUpidSB2B2XTIJ2Bp3oCVt5xJ/NEAQ73jB0tqN49L0GHHYwfQKsh?=
 =?iso-8859-1?Q?7jNr5txpsMipz87uQw1tbUZRndoAPYa0g5Fq7PANz+IGOgE339DYKbfJKF?=
 =?iso-8859-1?Q?2YFMd5Ja7onx9Nl41TBk2ZrunsigsCnvIHfdVsGzRNF7sLGMaMwkwPOJ5M?=
 =?iso-8859-1?Q?CImfQnRV4XhoEw6TKtwH2LprclGzESy+tg33g8viWAhc054qr1wr72BZln?=
 =?iso-8859-1?Q?D0mpil3+lsa0JEKT7myEwoAo5GlvBy9oHre7X5NT0XEKR+YDd4idyNFu1n?=
 =?iso-8859-1?Q?WOHc03WnPRF+RH0MoU0WY0XqgQ30D4LCqYwLL2Hv1YCrrpbvvapCpmdfvh?=
 =?iso-8859-1?Q?iGAEpmWYviexcA1DWCOB0XqJLLJv4+3LIfoJ/mQJinKf90azR54dE1iY/c?=
 =?iso-8859-1?Q?GRs6ldIZHWtsoqqqs+pW9h52otmlwo2/IgrhxCLTIgLU2jBOaMahrlPo3o?=
 =?iso-8859-1?Q?UdYV8AVmifhLingP6/VZK6loB7//d6VkD0v4O45j0Pia6c39csTvracvGg?=
 =?iso-8859-1?Q?cl/apQxHLfiwxP3UN5eLaO4CG4KjXbwJVdyUylh1S5ZBOmHmVDbroBZS6m?=
 =?iso-8859-1?Q?5mhTk65zrFkE3NAHINA/d2g8YAC1D6G/+EXLgijcid6uqmubPsuJat3VXR?=
 =?iso-8859-1?Q?rOQ/R5pnMzrq4gRFlO5wlU/BQa32Di5JUkbZQ3YjAEtjX7q98q6y1YGxr6?=
 =?iso-8859-1?Q?vRwE0RCyrS4HH27xN1io/iFOzs58VEztgh0lopAibvxuWoEoZ4IdG7IaOX?=
 =?iso-8859-1?Q?rt12B0TA46WjI4V1R5mEue2tiMTreXRR15ouj6cIGsWS67AJioMkVdzGBI?=
 =?iso-8859-1?Q?6/IJc0LVNQtEE+DRfgaWjEYSo6aVzA2W1XifYvZElbnSRK6N02rGgfOLs1?=
 =?iso-8859-1?Q?UhI0B++1L0l4FZI+HAcJck1+n/gL2jdDAcNqh6O4mjUermn3Pj2irOMwB5?=
 =?iso-8859-1?Q?oQ5X9dYCEaEvtcUq92W2J9QPGMokd6yhwiyYyp3IBPD1NfF04KKvxCUvtY?=
 =?iso-8859-1?Q?4GEjqYPhlWeyfonZzfaoYYXDQfGXU12N+55cH7dyAnJC3AUeOJe1Y+hHMr?=
 =?iso-8859-1?Q?+9LEXjUmoc2AwK4l18LHanHOMBQ47gKYC2K1305WGz8c/pySN6mzCZddmq?=
 =?iso-8859-1?Q?dX68JEGZlcSxVZqO9OPwUkoAaQugG//ui3X5abmwEYTFC43N4OqwJMqj9l?=
 =?iso-8859-1?Q?1+xfODF7zHmoLVn5vCDapfcqKQjKaopGLnNh4MJ39wkiOY4cwA+/uYSLeW?=
 =?iso-8859-1?Q?VTH1koWqz2wyr8+sDoxZK8QoDYxdy6oIM9uMRtxa1xtHbh1+C8JQDmJvna?=
 =?iso-8859-1?Q?9i8r8ihTclDwZhsPsRAnN/Gt0ML/OBsXKWlKFYi/5bmY8JsehXaa9+WS8e?=
 =?iso-8859-1?Q?Qfi6QedyTYkedeY44s/jg758Jiu+/3eRhBbzQSBoyFMVApHVDhhsjR3X08?=
 =?iso-8859-1?Q?CtWLTegdHP56aTkke+bXNpOx7+rtjjTvViBbyB/enKyqlOjKrZJgdTQAuo?=
 =?iso-8859-1?Q?t50SciEFQQWUQEt0MvgC2l4K4ZX2iDjiJuv81t1DyD1bwFV0B+fhBKtfE+?=
 =?iso-8859-1?Q?C7NA/4gHhnDVLv0LdTjk+jqXocQYXa/Skf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35548bbc-37a9-4ad0-eae9-08dbb39ab072
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:15:17.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URT1rzRwvGtVZH/UK44hOZOrwb2MZWPqf7LpmCobxkWtRb54ys21wM4PK8TUZGxry5uLJOhC2ysiMs49VTrJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 at 10:06:27 -0400, Mathieu Desnoyers wrote:
> On 9/12/23 07:53, Chen Yu wrote:
> > Hi Mathieu,
> > 
> > thanks for the review,
> > 
> > On 2023-09-11 at 11:43:27 -0400, Mathieu Desnoyers wrote:
> > > On 9/11/23 11:26, Mathieu Desnoyers wrote:
> > > > On 9/10/23 22:50, Chen Yu wrote:
> > > [...]
> > > > > ---
> > > > >    kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> > > > >    kernel/sched/features.h |  1 +
> > > > >    kernel/sched/sched.h    |  1 +
> > > > >    3 files changed, 29 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index e20f50726ab8..fe3b760c9654 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq,
> > > > > struct task_struct *p, int flags)
> > > > >        hrtick_update(rq);
> > > > >        now = sched_clock_cpu(cpu_of(rq));
> > > > >        p->se.prev_sleep_time = task_sleep ? now : 0;
> > > > > +#ifdef CONFIG_SMP
> > > > > +    /*
> > > > > +     * If this rq will become idle, and dequeued task is
> > > > > +     * a short sleeping one, check if we can reserve
> > > > > +     * this idle CPU for that task for a short while.
> > > > > +     * During this reservation period, other wakees will
> > > > > +     * skip this 'idle' CPU in select_idle_cpu(), and this
> > > > > +     * short sleeping task can pick its previous CPU in
> > > > > +     * select_idle_sibling(), which brings better cache
> > > > > +     * locality.
> > > > > +     */
> > > > > +    if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > > > > +        p->se.sleep_avg && p->se.sleep_avg <
> > > > > sysctl_sched_migration_cost)
> > > > > +        rq->cache_hot_timeout = now + p->se.sleep_avg;
> > > > 
> > > > This is really cool!
> > > > 
> > > > There is one scenario that worries me with this approach: workloads
> > > > that sleep for a long time and then have short blocked periods.
> > > > Those bursts will likely bring the average to values too high
> > > > to stay below sysctl_sched_migration_cost.
> > > > 
> > > > I wonder if changing the code above for the following would help ?
> > > > 
> > > > if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > > > p->se.sleep_avg)
> > > >       rq->cache_hot_timeout = now + min(sysctl_sched_migration_cost,
> > > > p->se.sleep_avg);
> > > > 
> > > > For tasks that have a large sleep_avg, it would activate this rq
> > > > "appear as not idle for rq selection" scheme for a window of
> > > > sysctl_sched_migration_cost. If the sleep ends up being a long one,
> > > > preventing other tasks from being migrated to this rq for a tiny
> > > > window should not matter performance-wise. I would expect that it
> > > > could help workloads that come in bursts.
> > > 
> > > There is perhaps a better way to handle bursts:
> > > 
> > > When calculating the sleep_avg, we actually only really care about
> > > the sleep time for short bursts, so we could use the sysctl_sched_migration_cost
> > > to select which of the sleeps should be taken into account in the avg.
> > > 
> > > We could rename the field "sleep_avg" to "burst_sleep_avg", and have:
> > > 
> > > u64 now = sched_clock_cpu(task_cpu(p));
> > > 
> > > if ((flags & ENQUEUE_WAKEUP) && last_sleep && cpu_online(task_cpu(p)) &&
> > >      now > last_sleep && now - last_sleep < sysctl_sched_migration_cost)
> > > 	update_avg(&p->se.burst_sleep_avg, now - last_sleep);
> > > 
> > > Then we can have this code is dequeue_task_fair:
> > > 
> > > if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.busrt_sleep_avg)
> > > 	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;
> > > 
> > > Thoughts ?
> > > 
> > 
> > This looks reasonable, it would be fine grained to only monitor the short sleep duration
> > of that task. Let me try this approach to see if there is any difference.
> > 
> 
> One more tweak: given that more than one task can update the cache_hot_timeout forward
> one after another, and given that some tasks have larger burst_sleep_avg values than
> others, I suspect we want to keep the forward movement monotonic with something like:
> 
> if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.burst_sleep_avg &&
>     rq->cache_hot_timeout < now + p->se.burst_sleep_avg)
> 	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;
>

Yeah, Aaron has mentioned this too:
https://lore.kernel.org/lkml/ZP7SYu+gxlc%2FYjHu@chenyu5-mobl2/
May I know the benefit of keeping forward movement monotonic?
I thought that, should we only honor the latest dequeued task's burst_sleep_avg?
Because we don't know whether the old deuqued task's cache has been scribbled by the latest
dequeued task or not, does it still make sense to wake up the old dequeued task on its
previous CPU?

thanks,
Chenyu
