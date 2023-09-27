Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55697AFAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjI0GSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0GR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:17:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D4DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695795475; x=1727331475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zagBoUbX03nZ+fMn04d501lhZ+FYN7r+mQdGJxOjXLY=;
  b=OtIY75xgFtDVV60GZDe/XpnNdiWqVAN+lU9jvG3Ua95aaMtWdhyuKDQJ
   kIDiplUw9/F5faIZ5sFNQSKnGR/NR6oILCdgvR1ooEij968q8NIUqvJ+F
   RDjr99FR0iJGrgXM+WKgGDGDvbBQQnaL/NxxziL7R+BIq6JFwX2MX+nPK
   JBIEPKTl+L8wxLcimrSnTpKdDfsAqongV+1vBdJHZ47S7qNSjNlBCeaKg
   PURrlac0/B0ulzN/gc3MBgg2HKC3FFgfwTBV7ciQAXrsMvD57znJdFVUO
   K/G7J84buX3pjy4Nk5E1Lxhv3LaKVsZ7xHE/neOvE9s7Vn2iTgxqQKCWL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372076510"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372076510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698739948"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="698739948"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:17:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:17:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:17:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:17:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mosC9nZzQvY4MVtS9zP/nTSozSWg+Cjs5DjOGwdKOplQPHqjT7eXbROsfNL8SlM+8wyfIGyn/stistT4G0QU9SgGltE6DMrAQFVcXaioCJVorjnSWRRKGbld5fENSyJ6cqKrWD8AiYUCP71WXmuMCksCXIpY4O4aJpctKjEXgR1/PBzNANPwjIwTi+DNluVOlDsO111S5hc3ak+um2m9CN1A3fzxOTfPbXaQ7HlHc4Vo8f9M0ALiFFWtncEKn8KmlmMaKLibzWNlOc3lhWxoO8zsaVXqqZK4E4p1A6SUbOzoXJdusSDlMVI6eP1fIiju2kLrvKcdY1SZBV8OhcvPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYZmHL2XJL1NSG6ldOl19qsQXS+6iSEULgsiUfCAEB0=;
 b=WNUmmtZdRuQbOIuxTwJoEl6s38KXVp9DDRJ5NI5d/As1208c1PJtSZJXrnNXi/utr3iKcA0UnGxOUNq6gsv2IUeBinNhy2TKFiv01N06BT+IAOKIObhjuyN23IqgJUGRnWRR7IvGDzfnmo2hqCslWiwBEmViWpQKgfyOMSF1LYuOCcyDky42dGRoYseKeoLZp/zUCFgxkR/j/nPQNKn2mmAgj33MrKVDLLkyncXaMe5Jk/StbKJkCxTQn9XvizsnBKgrmdVd+WL2B2J+qOTGTnNFXhvdAeRWNXF0HwBQRLfyR5jaNoe/Im1Bvp7476qg/nMu0k3GzThR5GBuKqiPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:17:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:17:16 +0000
Date:   Wed, 27 Sep 2023 14:17:00 +0800
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
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Record the short sleeping time of a task
Message-ID: <ZRPI3J9IjrrIrIo9@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
 <677cd7ab-4347-ed09-bf56-4c2a9833ae50@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <677cd7ab-4347-ed09-bf56-4c2a9833ae50@efficios.com>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: e3978058-ffb9-48d6-e423-08dbbf21650c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrnJ2bMFriEcP/r0BAGLKskbAzZKg/4kRt/71S9gThVZQ0ZF7CdHmoO4Qhv+IYkfAmXNJaqswxzDdbxdgsx5BGeCxECqbkEP2sQhh5TWCPVqDjUMxqOqxVi1yEtDEXXn048ZPPVgdTWr1IMG+d3D3EKKaENqJk52iM3oull7xxwVdyF4cViKxsMJ2DDW5//5yoYR5CnW+NUvZNBSBFTuuhQH5l9SHBAaBL9i2rtRGyj7/oHUvuXjwYqpSsiD64BM84BELOdA37lrxDET82gkqV0Wz0Ni+mkED7IQLO6UsqjTGuVM6wXRuiMaug4gV2EfoRkYplTwhLcji3u2VJ0Hc7MhRx5+xyOfkS1GDCiZXkriwQbBRZeHuxRYLfLT/JsRi1iRqCKNqldLAp+ekMLlPOXL82bXUiCdPwxxE+2iQjyObqvT/1xv5xwADE+XgY4DAhmdUIx9ZgaRW8i/wH+boGqaIRSswXTNO1dU+3RSiIllSuL3bb9OtGZ4y8kS2KLSZ8maNk//bnXGQeGtNWIx9faeTxOGFYjDXkdQjOlihsM7XbJ6Fc3jP8I6WRbhBcjk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(53546011)(6506007)(6666004)(478600001)(6486002)(38100700002)(82960400001)(7416002)(83380400001)(41300700001)(26005)(6512007)(2906002)(86362001)(66476007)(54906003)(66556008)(66946007)(5660300002)(8676002)(6916009)(316002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epKQqhP9U0Z1NnInlOVM+tC/daXKOYxiKHP8NcpeY/kpnE4xnPsKYMZ9ka2A?=
 =?us-ascii?Q?7KXl7NA2bLLgCH5LaJQkIfHPDaHNYkYReLVMnsWxMktNd3L5SbB8spaiElPj?=
 =?us-ascii?Q?p8wQr0Fp8FH45lTlYZIWxNG8HA15ACXM4AyfnVCfYLoEbaEZhG6PQbzq0dVI?=
 =?us-ascii?Q?znCXxlVdomMEczfakF+2kBUCJW/5uMdS06LvXl/P9AhM89qI8IaTxAYLC63q?=
 =?us-ascii?Q?HjqrrkqDmov2gPCVGYhViTOzgM3LToGI9DFIdc868WnAzVYY4ykj7Ax3/6dO?=
 =?us-ascii?Q?jq2rY/NSsMxlsfU9Lie5B9pwyU/a2Jo5EmzqSXXpHGBN4FIXpeegl0hrKGnZ?=
 =?us-ascii?Q?JWclnl9Ok46gHmqcQbk0qllyJHrXRwVAjb10NESaZMKSJpniFcGP4hszq1Vv?=
 =?us-ascii?Q?Ssi/1tT+AuEfNIC368mtaMxhVyDcYk3yKcUBLO+VsOUos2xy9u+m8MEzBPI4?=
 =?us-ascii?Q?qGWBTs+xUhU0HaW+Yx7tIsYppYSj3QZVOB7IYpQJn5GAnX3T7J0v9Zb1Odw8?=
 =?us-ascii?Q?e8TAx7RuAasq2mgcE9+BbaVQxwthccFR7PiYteh75GiiQrB1mCn9Fobw30We?=
 =?us-ascii?Q?e1T3kFhnx0+J2EnYtPEbQTPdqU3gXTgTmkwfqR5NANwYjhCP/jUwTtlA0JqZ?=
 =?us-ascii?Q?JYVh4r4jVAQeZkjptwXZlakwZL3UmXX5QE2dzAAHMXEytZoxQvytuTfDQkXQ?=
 =?us-ascii?Q?znaXlgwpeeEaWWy2vHfBaQJvZjgTvMTXpgCkgNdTfthUlqRPKzaNTPMRmEkL?=
 =?us-ascii?Q?gGi3Qpg1qwlRFPUS0x01yqrJH7Cj4+de32ohpBFX4aTcTA7TDeKwvXNVPU3K?=
 =?us-ascii?Q?8dz1nuOuFmpW3ZLIzrWyw724VXLOfJHhhFepOkiFwhjjsG4S4AGUSKO9zaA9?=
 =?us-ascii?Q?VZ1drZbjIBynsgUqYoMc6pxH6FD9YZdeSpvkaoISOF4tqKb5I+GboEmkLu5c?=
 =?us-ascii?Q?Q+nm/5Tv/9GhbZoUsfW6/TAZnsdZSDhPBlQtTNDrnFK1mb1zrzID1vfMvBNW?=
 =?us-ascii?Q?ByOrl+omJQDRRQ2dD2a/FKDnjmg+rDa/zlqBh+PhB8TMJAQhluhAcLMh7DcM?=
 =?us-ascii?Q?q5JMzdjlJnTampiO/DNtPk03APd7t3PkDxNIVXmOv68Rw9S5c4ot26hciF0f?=
 =?us-ascii?Q?F+rQ69AK6wF08BVOS8yiS/J1pfeXNnxhJUS6mAlUwjrAhXiwJg1fVVXo0uDm?=
 =?us-ascii?Q?3evMqvIC5Tln3P5bH1v6gxl8tfH0y2phA5hb8trNu+h7ayHhjA6tBh8aueON?=
 =?us-ascii?Q?cfFOM0RDFOsFMmLm6RBj0AgzE3mougiv6DRFt60+KKb8QRB5zhMQI8q4HDup?=
 =?us-ascii?Q?RFd3aHxj3EShrtZvqvIk+7Q7f5U0LRIVS0ToJpM3WF+L6/lp1XiUH13pwi6z?=
 =?us-ascii?Q?p7R/KJYT56Yye+z8DEaT9zCe/QSqy+xUe4arnDEzCn9jYPTI34sPle0q0ktX?=
 =?us-ascii?Q?xW6CHFmEjlo87rmwdujvYmp6L0M5TXGUejKQoYgSNbMZIa9EybxaNJSZfgz/?=
 =?us-ascii?Q?zpuKU/S9zMW5OA7qmqx/AMOnSOKMLAeBQ6HHkipEj0grvYBSdpT2a80S1es2?=
 =?us-ascii?Q?vaX71jyZF+mNkkbfS8DVS62HL9YgmoiLP2rJL7Ks?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3978058-ffb9-48d6-e423-08dbbf21650c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:17:15.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JF3rdhfk20Js1rsvnLOeyIUs3Y4d05OkkShv/PNhUcLoR1BBMFgxJ/HIUKFZEOMICq8apPgcFrcPPIqpVWy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
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

Hi Mathieu,

On 2023-09-26 at 06:29:40 -0400, Mathieu Desnoyers wrote:
> On 9/26/23 06:11, Chen Yu wrote:
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
> >   include/linux/sched.h |  3 +++
> >   kernel/sched/fair.c   | 21 +++++++++++++++++++++
> >   2 files changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index dc37ae787e33..4a0ac0276384 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -561,6 +561,9 @@ struct sched_entity {
> >   	u64				vruntime;
> >   	s64				vlag;
> >   	u64				slice;
> > +	u64				prev_dequeue_time;
> > +	/* the reservation period of this task during wakeup */
> > +	u64				sis_rsv_avg;
> >   	u64				nr_migrations;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d0877878bcdb..297b9470829c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6456,6 +6456,24 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >   	struct sched_entity *se = &p->se;
> >   	int idle_h_nr_running = task_has_idle_policy(p);
> >   	int task_new = !(flags & ENQUEUE_WAKEUP);
> > +	u64 last_dequeue = p->se.prev_dequeue_time;
> > +	u64 now = sched_clock_cpu(task_cpu(p));
> > +
> > +	/*
> > +	 * If the task is a short-sleepting task, there is no need
> > +	 * to migrate it to other CPUs. Estimate the average short sleeping
> > +	 * time of the wakee. This sleep time is used as a hint to reserve
> > +	 * the dequeued task's previous CPU for a short while. During this
> > +	 * reservation period, select_idle_cpu() prevents other wakees from
> > +	 * choosing this CPU. This could bring a better cache locality.
> 
> "This could bring a better cache locality." could be rephrased as
> "This improves cache locality for short-sleeping tasks."
>

OK, will do in the next version.
 
> Please add my:
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 

Thanks very much!

best,
Chenyu
