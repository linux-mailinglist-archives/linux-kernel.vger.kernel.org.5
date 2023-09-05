Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0D792512
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjIEQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353706AbjIEHWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:22:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880EAA8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693898519; x=1725434519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4+bh0u2tbzQcC0zEiZ5D/fmiuZH+NJrvssLLN1PdfSQ=;
  b=OpKeETYKQSaiBiJLnjJpsaI5oD+UUsxobb7MBFE1RZUeMlckxuVNbJnY
   0vlljzqlQKIWHvQNMjrkljPkKG6IhJPMX3NzfxTccBExB1mz/T5E7gYJZ
   gTea+Kx8Jmwxyt0TJJnvSgMstCEeLlWJ8wy9WtWx73CeoOsEazDzd9RBN
   A4DN0Yuy3UFFhzBSpb+e/LeDwKtSpuXgzIMDd5v7HkEg3vyBfi1voPpys
   jjLptCeYygOGN0jt91TEUjqzD1LWa32BFQb7q9AFltUfPkA5vTjH2JIb+
   SsPF59YXFBtAzmaCLBHCCDkpz8V+uP71yfRnrPwI4PWhQQD16qguLhXSK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440706831"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="440706831"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 00:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="717790914"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="717790914"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 00:21:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 00:21:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 00:21:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 00:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcjfiRITjzIdI+tbKo0F72yEpKA7yQujThJ6bkg7e6K24yQqcg50WFqubdg4nR7eW8771EZXzGMJ1v8BCp1C9CcOwQR0P8F1w5ZElRvYD1G6Z770NHfyyZEpjeutt2gAVvAjzMLXpPT15kRXXqK4sBaZ/8TvS+3SxDhJvuWnQloqV+oWhJNTokzblryd33iF1FwmymosziXSNg0BKwx/9pJCtbs/NZTsvDrpbREUSdoxb8MsomtJ/j+qUvawaIDGesI20BS65b6GUwCQ7zhE7XVdG2Gn0b4tX3MIdYxD84D3bczyBuv7AYBiuVZzvEd4WFl3wUaFYEuBPLCsWGDrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxLA5zyIls6NFhf+BUi/yjpttNt8c/B6AxYJ3T5JaxI=;
 b=E5mb3nMewLYGHu8tQi65oyqfifJtr4owKE7AGjvjRrVq/9dqus7Fx7cFsAtZ3ezTYm4drp8B+soHZi7C1/vIAXOLWiQY7dE3nsve7ts3Xdq8BfCw0PV0X4U+/VyBjSCLq6f9ruedPIzGw5Rv0qwcEOz8/TAGHRtANYmR+h0c0Aiu450DemUgblST1xZX6cj+Zyg93mGyrS48X0iVK9qwEVB/RpemEgaOOwPAwKzhcHXDRFGJBXyZC2JC3Fhy2NGgMu4tmhDfB3L01IzTW8eE+rPUMrPNrOAHSJjDqfrZHj+0jRT/QAuUVmB66n3hgGMFKD3OCSR2ApXalfxweNRNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 07:21:55 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 07:21:55 +0000
Date:   Tue, 5 Sep 2023 15:21:41 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        "Julien Desfossez" <jdesfossez@digitalocean.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Message-ID: <20230905072141.GA253439@ziqianlu-dell>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
 <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
 <20230828111945.GA504382@ziqianlu-dell>
 <20230901134528.GA46365@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901134528.GA46365@ziqianlu-dell>
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 69483fc8-3079-45a4-d74e-08dbade0c86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKQmv7wxZI2OGRQeeBjT7L/7wJVlGDzh9mQoFl3NwYTsvNLZAj6LiXED7PgLTXpWHHrnTfJYVDzuabsL3t556t2lTiFitUb9MPkgSYj86OP5TPxFhjM3O5n4jYD2+inqQKFN+zdzcYPSuY/kqhd/HSsBKKAo0CfycsdnKbwqJOmEflUI5e0MOiuXzMvhzTG1Y5/cfcpdojDGZMBZ2H9t4xsfs1l6OfHcMkNm2HwQzNQZQwAs6nBgXqN8W51DMSRUd38Yx3QgZdwMnTuwJ/ig7X8qqyFlAsy+/5g0AIAezEcRGUN2/xGv0DRYKpc/mj4VpMRPKacSxgDP37/MtBDN8Sgjx6BLZsuhHbLSP8xrggF3MrAQubJ/JRBuy5l8Ev+az8T/WFv8QaE7JlagEGCzlMi7y0svzhZr/ScIb9qxfeVHfp5fa3l6YS0w1EwwMJ/hMelFpftobp1cPhnphmBRA26PM3k0+nl03/Zz0SYqmsJVAFbI+E1pl7vHqTH1V2onMKtTgiZWhsVFF0HPqgDXGDDvGXGW3L1XhmpS40o2Ii8sD/reRbz+zgxKb08wwr7A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199024)(1800799009)(186009)(82960400001)(66946007)(66556008)(66476007)(54906003)(6916009)(478600001)(38100700002)(316002)(2906002)(7416002)(86362001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(44832011)(83380400001)(53546011)(6506007)(9686003)(6512007)(6666004)(6486002)(26005)(1076003)(33716001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YwaKE4GG003wQbp6d0l39bzIX1oCvLY5rs8DTCdGD3fikdkJFZhjM7jDR8C?=
 =?us-ascii?Q?eacgwUkUnHzhLH3nFc5ZOQsuqxmKgEVAmTVJUmaxdZ7VcA3MzC16a2WZ1SAB?=
 =?us-ascii?Q?YG/DUoDIBLNv5R66aKuNuSiKZcCqpIVmYiWReoOxLaWe8OMc2typOrFdk2Fx?=
 =?us-ascii?Q?7ZxcvA41bzrOp/GZdTYR3PoRdvDw96vs6cSnSbPnI4Nf/WoZLNwqFk/SqWN3?=
 =?us-ascii?Q?yrAHLWp9c8qFz5h1Yka/4bJD2GpVeVsvyiP2nDS/mTV5NuJWL1HibNc7vOpA?=
 =?us-ascii?Q?w6i08wYQUjqjTOmjAxahPgnQs75nRondD/Rl5AZbiCizRfR4UWL1wDf6fj8H?=
 =?us-ascii?Q?4r9B+RmzLXQskmgKvLkON9TFwFbENge8STaj6wkh80QHFtYQ5ughAXrmtj0H?=
 =?us-ascii?Q?oIRDHx0dvBDmVIAxbNvrYrU3Nrfj2ernU98sHE29T+GugNIBdYaYNkZNJt1c?=
 =?us-ascii?Q?Z2jk8YGB3gkBkDW0FykP6Vqg/n767A24j+40pcdDzvHqrHeWYxmiqOSQo09U?=
 =?us-ascii?Q?JBTN3gXXVbJuMG2chuiA3mYvZLWHyZPfK/A7hUq/mxDhpYhgAnmMNPjN4YzA?=
 =?us-ascii?Q?7AoOeDZrLKIXrckClCDguGjCyVVvAh82gsYoOsNL4QR8Nakjk36Gbqh+oMq0?=
 =?us-ascii?Q?uXo/Yq/SRjPkVOO81hzid9QdcIGf4PDYbgwNHbqtxSPxWl1xDNU2OomP5UdA?=
 =?us-ascii?Q?hTHtKZEq5cv8jlMT+hsdJGTUUwa4I4pVWvnIg31T+UTwU7IGwFEhD4FfQHUj?=
 =?us-ascii?Q?c3xpFW1aOX1BLYYch77PpOTbqL5n6U+h8r5gzMTAh69R8Bzm47Ej259Evaiz?=
 =?us-ascii?Q?X+NPcRyYhIu4zaaj78v2doVo6wtcwbCN6PQawin+nw2Ms27ieXD7U666IBRZ?=
 =?us-ascii?Q?+fXMdqZdLJwwJg4gLnJC8wmcigi6qWeY5y1x/6AxJioi8soaSfp++fZ2S1/b?=
 =?us-ascii?Q?ZO+Go4Av2C4OqdZFRir6K94BItsLQYIRkTNZx5TMj9IHw9Sil6YpzLI2QWCr?=
 =?us-ascii?Q?MsXBqVGKyxt+Ovj/OU6PmA6KdSEEgMlPchIkcHPhjj+tJIVnzjPyJsUkV1yf?=
 =?us-ascii?Q?VIWPs7Y+oGAuYilGQvfMcrjGtosC0eCkflCwhPdFwXzD1szuKPe6AZvqcWI0?=
 =?us-ascii?Q?Gb/UP+ReZoC2nk6RUd89mtEEki76zSBbLFxBpU1Jr7czB6uf3+kDelpU78iL?=
 =?us-ascii?Q?glOALYdTS7S9d5aq7/rxvSfwgUfNw+zZftnl+uWjNaTFVdFU4W514UH19QrN?=
 =?us-ascii?Q?QbXUsN991hlMxlWbUikT21c15HJjaHdc23TjPZ2Ee9xxangCNoBWC+Occ90d?=
 =?us-ascii?Q?c7iO49NYUwP0FbraYQCAGzHoyMGl118v2vHlAmzbDxkW/BGZTQALOn9D1zMZ?=
 =?us-ascii?Q?vxjWJ21h4Ts1h6Rjb9NW/qI62ejVFNULr3sOIVh7spOJ5/fgmpaoxYosLFuN?=
 =?us-ascii?Q?lN/KJ8T04426sGzqmPq+FNaZv+ixVqBXF9w3qsOfs1qfK+X9Fg4HLIFMe36O?=
 =?us-ascii?Q?6zD4bL7BtAwAtHkiKlvRhHI/N4NvmWsjC9XMC6uVpyMEWiJLs72MpDCzoJkM?=
 =?us-ascii?Q?38VyPj2+qhfEZ2gvxzcWcXvVe4leQ0Ic5/khtDpf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69483fc8-3079-45a4-d74e-08dbade0c86a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 07:21:55.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWT3uNqwdzFmPS/ZCZMT6Gkk675cJ/y6Wh4oK5vFu5ewklNAr4DJodLnHJqdI7l5sjsbsr2E1kxxGjlxzAplzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
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

On Fri, Sep 01, 2023 at 09:45:28PM +0800, Aaron Lu wrote:
> On Mon, Aug 28, 2023 at 07:19:45PM +0800, Aaron Lu wrote:
> > On Fri, Aug 25, 2023 at 09:51:19AM -0400, Mathieu Desnoyers wrote:
> > > On 8/25/23 02:49, Aaron Lu wrote:
> > > > On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
> > > [...]
> > > > > > - task migrations dropped with this series for nr_group=20 and 32
> > > > > >     according to 'perf stat'. migration number didn't drop for nr_group=10
> > > > > >     but the two update functions' cost dropped which means fewer access to
> > > > > >     tg->load_avg and thus, fewer task migrations. This is contradictory
> > > > > >     and I can not explain yet;
> > > > > 
> > > > > Neither can I.
> > > > > 
> > > 
> > > [...]
> > > 
> > > > > 
> > > > > > It's not clear to me why this series can reduce task migrations. I doubt
> > > > > > it has something to do with more wakelist style wakeup becasue for this
> > > > > > test machine, only a single core with two SMT threads share L2 so more
> > > > > > wakeups are through wakelist. In wakelist style wakeup, the target rq's
> > > > > > ttwu_pending is set and that will make the target cpu as !idle_cpu();
> > > > > > This is faster than grabbing the target rq's lock and then increase
> > > > > > target rq's nr_running or set target rq's curr to something else than
> > > > > > idle. So wakelist style wakeup can make target cpu appear as non idle
> > > > > > faster, but I can't connect this with reduced migration yet, I just feel
> > > > > > this might be the reason why task migration reduced.
> > > > > 
> > > > 
> > > [...]
> > > > > I've tried adding checks for rq->ttwu_pending in those code paths on top of
> > > > > my patch and I'm still observing the reduction in number of migrations, so
> > > > > it's unclear to me how doing more queued wakeups can reduce migrations the
> > > > > way it does.
> > > > 
> > > > An interesting puzzle.
> > > 
> > > One metric that can help understand the impact of my patch: comparing
> > > hackbench from a baseline where only your load_avg patch is applied
> > > to a kernel with my l2c patch applied, I notice that the goidle
> > > schedstat is cut in half. For a given CPU (they are pretty much alike),
> > > it goes from 650456 to 353487.
> > > 
> > > So could it be that by doing queued wakeups, we end up batching
> > > execution of the woken up tasks for a given CPU, rather than going
> > > back and forth between idle and non-idle ? One important thing that
> > > this changes is to reduce the number of newidle balance triggered.
> > 
> > I noticed the majority(>99%) migrations are from wakeup path on this
> > Intel SPR when running hackbench: ttwu() -> set_task_cpu() ->
> > migrate_task_rq_fair(), so while I think it's a good finding that
> > newidle balance dropped, it's probably not the reason why migration
> > number dropped...
> 
> I profiled select_idle_sibling() and found that with this series,
> select_idle_cpu() tends to fail more and select_idle_sibling() fallbacks
> to use target in the end, which equals to prev_cpu very often.
> 
> Initially I think the reason why select_idle_cpu() failed more with this
> series is because "wake_list style enqueue" can make the target cpu appear
> as busy earlier and thus, it will be harder for select_idle_cpu() to
> find an idle cpu overall. But I also suspect SIS_UTIL makes a difference
> here: in vanilla kernel, the idle% is 8% and with this series, the idle%
> is only 2% and SIS_UTIL may simply skip doing any search for idle cpu.
> Anyway, I think I'll also need to profile select_idle_cpu() to see
> what's going on there too.

Looks like the reduction in task migration is due to SIS_UTIL, i.e.
select_idle_cpu() aborts a lot more after applying this series because
system utilization increased.

Here are some numbers:
                 @sis       @sic     @migrate_idle_cpu  @abort
vanilla:       24640640   15883958     11913588          4148649
this_series:   22345434   18597564      4294995         14319284

note:
- @sis: number of times select_idle_sibling() called;
- @sic: number of times select_idle_cpu() called;
- @migrate_idle_cpu: number of times task migrated due to
  select_idle_cpu() found an idle cpu that is different from prev_cpu;
- @abort: number of times select_idle_cpu() aborts the search due to
  SIS_UTIL.

All numbers are captured during a 5s window while running the below
workload on a 2 sockets Intel SPR(56 cores, 112 threads per socket):
hackbench -g 20 -f 20 --pipe --threads -l 480000 -s 100

So for this workload, I think this series is doing something good: it
increased system utilization and due to SIS_UTIL, it also reduced task
migration where task migration isn't very useful since system is already
overloaded.

Thanks,
Aaron
