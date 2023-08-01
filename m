Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A776A9E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHAHYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHAHYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:24:22 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957619B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690874661; x=1722410661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FD4ay0nON2MSitBOBmRVDfor2n4/MwUTNGlal5cKIv0=;
  b=L1G/UaRg1Mhisz2DLq0a2krRJdbSZzuQxdK+UQmv4w6ixOoHFMF0H9lb
   9+zAr6uDuH4fX22kiBMm5OzQchnSs0VS5LRRQw7yP60pfDWVQh8aQAVF1
   gHFnhUDFluxzUC9mRjIlFNRBIm9k5Kn7O9lWzK5sOn1TQFzghO3XU4kKr
   8Joo+AVPDlulFRapMXc3humEypMXh60iqiWeebpJnZVV+/AlCvbPzjWWK
   X/UzE/UuNeaY+Hiy+8JUJ3CEKhKy9tOYGJvj83j6p/6YuJSmhtC8P6GGT
   DVnij9k2ZtZTf1c4QaKlumJrkzehLyexto5rgIp36Gt4borW5aBnozXtD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359265869"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="359265869"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 00:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852335297"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="852335297"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 00:24:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:24:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:24:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 00:24:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 00:24:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5TlSxiGGwCMW2xwa7Av9+8xW7mEjQ1PBoDMRyUgLL0CDIhceRRUdyZpZK8BI7v0ivbpHG8/9x2F/mJuWlEYZFJdFaVCsbWYa9b0Yoeh81be0037sJZj3pg1DPT3S09sX+hPv5XY6aDUKOGpOUM7tARjnlQ69SeoSN+LX5X5eU+5bMNMYx+WlJy5o9N/Tl4IKCVsZd8YU0KZQsOKjodI3AOt7/97gJmSD3Uw9soVRlFCxAHH3nr0dihqhfKxYzVVyvnUws1c4GCGIJedyD78JsNPipB8u7oTWoE+mtnUXUEWzu2OXbd430a2wBrNSy7t6RpV71UJTRkOOsEMGNWvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1HPPzIIdHqq8y0aSbCdNVIu/Noc96sSGADVXbrdUdM=;
 b=J0WSqD0LD5wxPyp/Hjh3nAIW/NYSqgi88mRvLgqKgZjr2T7DyAjKQePQnCV3BHVO9ExyKT8lGHR4D7wO4FNsaPTVFlHcQsYYhSTnBLsYc1DE97sZGoXW3+/yhK5eW5Da4EwLPe81B5x6JS4tH5GmNmAuVxE5xeNZcq0omnZ8HHIue44hpjk76ScbJ+2giJpkarLnhO24yBOd4Qtyiwo+V9HD8bMqp8jCU5T4V1yraJONCD4k9Qy30E1aFbvt57s5fdBO0YNioof3wQi9qGiX3jMGudNT6PMCPqtKZNN7a3u6+sOOKWYut6ZXfWiz8jbNtCMOS212otAF93deKW6VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 07:24:18 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d4:a7ee:93ca:1a7a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d4:a7ee:93ca:1a7a%3]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 07:24:17 +0000
Date:   Tue, 1 Aug 2023 15:24:03 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Swapnil Sapkal" <Swapnil.Sapkal@amd.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Message-ID: <20230801072403.GA20269@ziqianlu-dell>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
X-ClientProxiedBy: KL1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:820:d::23) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354487c-7b79-4ccc-c5b7-08db926050f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/8hB/Q+1RBYx4GsPcJ0Y1Y8+yCn+oaOUKoir433wjsYGe3lKXw0p6svF0sVt338Vfz6+FDMHX20SUWgWJVudRezHeb8vw35D88evSF1Y67WSfkl5tJxFmiQq51hgajx3XCK7O+1tWU3MtsusRMRK0ear8txAkg9yyW9sMaIGZ1UB0YFUI1wy5sFrXk5P6aeRyh+DkFVMyCZ7vyF6fdFhy4J9OG7RLiaMjn6YjIXXuDIKcWgI+U9zAzNl3L3Cbaq9QicBuvYfQgXY8vFJcuXvIloyOvQk6bMjBYf/ydYKUE/20Cb0+JpYTO8kEZowxxLS7aYuujla7msO2ZYso+rNNkizRp8VQuB89v5EnaQ9xO7pGMbdSL5asDk40lL4EbtfSSTh0IDntsfubljY3KmcNCkfqqbeL6uLdfozqvPDZ7hsCU7NLYHbCoAKKHQY+wWtMMlBrNRtol4tJPkNadDlu7OxtKC2gm99llmmLuAY3fzSgqAWmBdrA7GMGSBgJeKMEE/BhNUtUCfmdTlkRsfi6id3Y6GSU35FLkTmVF9AdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(6916009)(26005)(478600001)(186003)(316002)(4326008)(1076003)(6506007)(41300700001)(966005)(82960400001)(9686003)(54906003)(6666004)(6512007)(6486002)(38100700002)(2906002)(44832011)(83380400001)(5660300002)(86362001)(33716001)(33656002)(8936002)(8676002)(7416002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEPcIpTZR8KbugF9lECLEDutyj/NzGpyVOpy2D3yImzp/a6WH5dtiadUDLtu?=
 =?us-ascii?Q?WF1+SqjvEsCn7Qi6iTzVv3fvyFjnO2i7gQCdv8ivQ3MuKsgZgy0m+hcIxbCd?=
 =?us-ascii?Q?kP677lNpiLXj7HAKIozJzBmjtx6bFUn5wk1EC5rn56/mO2z3y/y7kd+TAgCK?=
 =?us-ascii?Q?YsFDSqAs5fM/OSAiGCrQof+p0Md3OP2WP9Kw+R/69FcPBLgLqyp0Y2818z+X?=
 =?us-ascii?Q?I86ELUGpsdSvWmszKMdareTER/wAlrNxXFj2YQ/BAmcUu705LhlQrCa7lGQJ?=
 =?us-ascii?Q?4U69opJHba/In9vMLe8Ltyp2knCBs2uIj7bdpJ/62Ryr2kfBmTGaJKp65R3r?=
 =?us-ascii?Q?PZjK10cklIKxoOanx2AjPTJuoqr2I0U1gtGvahmGXiJiz/8r37nq0+9Sfb9g?=
 =?us-ascii?Q?LqR6JXC8hTqgjAC2Y09W1OV2cakaz73hKMxFMVAQjAQFu69hBmZ2vl7bcojS?=
 =?us-ascii?Q?N3hg8C+X1oZT1VSxGtzmOK3oaTrSRSNFh8eLzST9/T2uF9X0U83m0+rVsFYm?=
 =?us-ascii?Q?3zWIndRbu1OgZMZFmBRnznOHNYFZnb2TzWXKUcsQDSReOm+whk9Fvu8iUCg3?=
 =?us-ascii?Q?GhuptfZDXUxA6Pu7c8tOEJxaGXN/qNHIPia1/8GNltpXBN+5cGH25zr9srDC?=
 =?us-ascii?Q?5K9VWoBL7+ExgeWfT0SwMxJKFlXnhYnTUZMf4LnGUPHH9HEMVM8skRzfk7Pi?=
 =?us-ascii?Q?S+i1D/JbQjrQ/Xf+3oftlSCtUorvY0Y21tdbWiiuoz1OqGs8XHXQG3/tbllB?=
 =?us-ascii?Q?jV6yoBwWntlot0+P4FBUP2Q9ZzWkr/7uO3EWr/toWR5F2ol67iYdKYjdkSjX?=
 =?us-ascii?Q?QlCXbhgsvwjVOOfcpqEL9KvqdASegtxfzW/O1HYGaa1GGbCD56I1MVroXdiW?=
 =?us-ascii?Q?PbtzJA9NZQh+3hpDQMwRB2Om+jdpSS4wyrOqNc8acggaxLAcmKs7YYZgfUAV?=
 =?us-ascii?Q?7mJimqa8qF/3kz78J/G2Fg2DMnsRCW3IOGu7fR8mhm9VRqYyDT0kHvVYiC33?=
 =?us-ascii?Q?Mkndr+umlaKv34LDe75yKJ3rMKVQUtEpGIkftqJ1BxtpRNgosOIXNMQ/x1wl?=
 =?us-ascii?Q?zxKITdMT78f6+2qtrKz9EEOye/nQTNgutYPEZHwdflBQjoHC0a4gRm/4WcVS?=
 =?us-ascii?Q?+4ugNkSRswu5D7JtnpqJZbC+wOhiD1wBsv5+QzB9LMVrYwGKIdvksQTJQtS0?=
 =?us-ascii?Q?Q+b7J89xqnEF7ekyf6/FXSsqAIFERfI1kAGVkhCsfV1EWHP19QSGaJC1xOrF?=
 =?us-ascii?Q?8OJuxNv6+Lo9Jra5rPzd+wTIw1LhZNXGaofJOi7mipWUmdOJxgoQg9hNGqX9?=
 =?us-ascii?Q?6LBV14+HniPrDhl8CdRn1SlV9r8T8uypzcuiaJV9yYKTnrtX+UwmQmGcTGi8?=
 =?us-ascii?Q?eETeEk0MZdISkVad8gfnSyBolXa61gMlUd3MyLX9NXexHIm2+czODu/P6PZZ?=
 =?us-ascii?Q?CoNGVXINwXG19oxVod+iaG+gZkzmmwPF9KWUYYghZ4S6+b+bmC0eOJJ3R7OP?=
 =?us-ascii?Q?hgUeaLNMsIZ3mNaYkDf30IF/w7QCGOFDbmfn5N8vi6pCo2Hkf+VqK6Q9s/DE?=
 =?us-ascii?Q?u2Bjndxp3y6MzmLelqmCKdoRHhMk2NHpKKZUK/1g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354487c-7b79-4ccc-c5b7-08db926050f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:24:17.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n022dsr+5z9t/Yvw5YquN2QXyNm14aIgk41mtaf3NKCkpIdvqUygKQe+3fVFgjuoZ9OhBMq+q/osi4oiE8ODbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:56:19PM -0400, Mathieu Desnoyers wrote:

... ...

> The updated patch:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..1c7d5bd2968b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7300,6 +7300,10 @@ int idle_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> +	if (READ_ONCE(rq->nr_running) <= IDLE_CPU_DELAY_MAX_RUNNING &&
> +	    sched_clock_cpu(cpu_of(rq)) < READ_ONCE(rq->clock_idle) + IDLE_CPU_DELAY_NS)
> +		return 1;
> +
>  	if (rq->curr != rq->idle)
>  		return 0;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 81ac605b9cd5..57a49a5524f0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -97,6 +97,9 @@
>  # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>  #endif
> +#define IDLE_CPU_DELAY_NS		1000000		/* 1ms */
> +#define IDLE_CPU_DELAY_MAX_RUNNING	4
> +
>  struct rq;
>  struct cpuidle_state;
>

I gave this patch a run on Intel SPR(2 sockets/112cores/224cpus) and I
also noticed huge improvement when running hackbench, especially for
group=32/fds=20 case:

when group=10/fds=20(400 tasks):
            time   wakeups/migration  tg->load_avg%
base:        43s  27874246/13953871      25%
this patch:  32s  33200766/244457         2%
my patch:    37s  29186608/16307254       2%

when group=20/fds=20(800 tasks):
            time   wakeups/migrations tg->load_avg%
base:        65s  27108751/16238701      27%
this patch:  45s  35718552/1691220        3%
my patch:    48s  37506974/24797284       2%

when group=32/fds=20(1280 tasks):
            time   wakeups/migrations tg->load_avg%
base:       150s  36902527/16423914      36%
this patch:  57s  30536830/6035346        6%
my patch:    73s  45264605/21595791       3%

One thing I noticed is, after this patch, the migration on wakeup path
has dramatically reduced(see above wakeups/migrations, the number were
captured for 5s during the run). I think this makes sense because now a
cpu is more likely to be considered idle so a wakeup task will more
likely stay on its prev_cpu. And when migrations is reduced, the cost of
accessing tg->load_avg is also reduced(tg->load_avg% is the sum of
update_cfs_group()% + update_load_avg()% as reported by perf). I think
this is part of the reason why performance improved on this machine.

Since I've been working on reducing the cost of accessing tg->load_avg[1],
I also gave my patch a run. According to the result, even when the cost
of accessing tg->load_avg is smaller for my patch, Mathieu's patch is
still faster. It's not clear to me why, maybe it has something to do
with cache reuse since my patch doesn't inhibit migration? I suppose ipc
could reflect this?

[1]: https://lore.kernel.org/lkml/20230718134120.81199-1-aaron.lu@intel.com/

Thanks,
Aaron
