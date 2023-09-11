Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9341179BE94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbjIKWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjIKIkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:40:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E5FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694421626; x=1725957626;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6WkueCWK0Nl4baoPnCyi/x3MKId9TZY0p5Wuz4ZqBaY=;
  b=UMuendrlMTL6vT3ZCq4Tj+hxRplRgl6P4+BJYMIfVz8t+oYeToEc9iTl
   HqN5ZRGZtdYgXXtAeju4Q+tW4yFcCD3PEWMnHTAHL40F4pnQsTpVSqU8C
   eVYBHzSTVQNqu4Hb5rcOON0V7YbC6BzeF6Ob9/08JCeC6hNI383UFqtKh
   1TDdX3thKwbApMrLwl0iZ5yL8pGAJ3/GKxVATJDRYwOBiZy7I1io+Wgyt
   w+yAWcdvoGHlVqi43dgxJif8lv2HZVH6WGRHFOOlYIM/SfXhobkG83H4B
   LNWwpiKBKnsk4uJ+ZMLwIcWOcgyTNqFIPXpIPtaabbAYLWJoSfALLZBCd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376943553"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376943553"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833422147"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="833422147"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 01:40:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:40:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:40:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 01:40:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 01:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlwmsH1h4GVM4FlHsulqFFhD4RRYkFNNjCFLQk4XSBqcUIGsmfg92rR6c5N/wA677g/awUMvuEJ5k5frz6gMYbYcluLxhztW+xfT46cFGqYyprQFrub07Y2d6E12RF1Lf0I9PvPghOEmhX0dBWj931i+rSpvLCuVJPwXS1SZLpO20LSGKl9msezFzqbYCagR+81xlk5omaj+x9/ULcPxcRpuXDpYdUS+ft0m5ejQuz/rTGWiQV7QiBWZEPRnrWyFJK0EzRHGB+nY+adcL9o871Q1znqG7RNd3C0Lq4SAfCuBWHO0/Ue0yvwt16r6EmbQYJGaQaCdaAhixP89BKMYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RVbUYM05w0V5nTNyhyv9hPsHhWwYc7LPwQVevZn0VA=;
 b=VlcKFErcCXib2jKmi7i6Iiiaw/8KLOKJl7n85ew6NO094ecEWNJ81vQy4i5wIdhue2D9eOA0yVD+KLN9e2QjthHXubdyNekPlLBzJsvML29fMsLQ5VVhptCFf0LhpzJmTikmxjXchEUPMYTUEPB58QFy7Vbkxs0quwUn8a4OJ2qAO8JF68VQ0FKC55SJ98KAHhc/ehEWfC+MAPBEx9LpGkRciucXkWNmCc3ZWbHz4vSiIGdp5kTJdLwDXgyJFRS5o8MrRd8DQMgm7EbCAvF1zU4Gq1CAL6eaPA3474eFC0l/s8WfSMBaXDVorgtrkiNurxe8rLGXO2qLKxEXxi0+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 08:40:22 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:40:21 +0000
Date:   Mon, 11 Sep 2023 16:40:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230911072629.GA298322@ziqianlu-dell>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: f84671b0-ec4f-45cd-e751-08dbb2a2bb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YSUvbdpjUzaQgfT3LfPlBWthXNtPWtvPyATsZpIR/xKF3Q2AkmfRCCIh0qytqzCdpwi2lZLSm7jj5B+/wqzffz/MDJiWp9EPZaLVwe4CMJmOO7vc5Ol8wM8OxfQ92Zyj9+Guj3UPc6zSUck1G4DVSOUqk795dD1o/6LOftwow+V6HmKxOrGxIaRjYF9OoNg0KPXhTiE9GL1RFXj4tM66YjMcMXXvL2cwWeQMt2zrPU/mSWlUkkklfYlTd+fEHpJWFsKVgGXYp+nfWZXcOJ84Pk+Zxbw8FUZSGWUQXq6wK7QLC/bsSm8x2BvmKw9nOkVxQYD2+eZa+GEa+8zVQweiFyfBRHsrHixIQ1ayrxrRXWYdIuUKG5EoRXaiqyhVInahIPmkmEdROWshAA8EQkMwC4vPfTcf95SLXIfLzHSKqfG1B4Xphq/qWTRjWjN5Xw6UqDs6XxWi7iIq5filIqWz/FOmWXbfElItnvZ8Fsmo46iWbktuyp+YLeMm4eLr0UJT//dkNxlwNh2Y46ddjG0e9IZ/szG8tMwj8xDFpFzgu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(8676002)(33716001)(4326008)(8936002)(83380400001)(6862004)(478600001)(6636002)(6666004)(966005)(316002)(54906003)(66556008)(66476007)(66946007)(9686003)(41300700001)(26005)(53546011)(6486002)(6506007)(6512007)(2906002)(38100700002)(82960400001)(5660300002)(7416002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4K2NyejYeRNExCWZCqDkmQ+hn37iv9rhY1xaxVBg8Xgwc4eJqgtk7InvVBP?=
 =?us-ascii?Q?dMUA1xxPsz/Yjc2rLqDWSMe1/sVJ711oA7jIF473+B2BoyHQgi9WSAYT3QyX?=
 =?us-ascii?Q?x8fITDBEqqW0Duwgic42U9yVaF44JFMQPh1WZJxXtdhaUWkTeo8Lfol/pL7B?=
 =?us-ascii?Q?Y6hwWaaB0If6FlWuopjTKpjZHR7axN1qCkymxjV/Db4vTKawyPBLHs6hz0Ei?=
 =?us-ascii?Q?Hx1ompnX+EL1IpA4kWVseC2A8EtjZjq5nOzYSHG2PhimrMBVwIPgo1C1T/G1?=
 =?us-ascii?Q?McGRwGxNrzganf+TMGd9YD74XsLgunBJEcHT/0xnR8OxIlQgR9QqHC5nGYty?=
 =?us-ascii?Q?ZRunDX8hQuvyiK30QP/f5E/k8teL7qnvAK+0pyLwdzk5vIyKx+bmb4pvJm70?=
 =?us-ascii?Q?SzzffWko4SOwaC2CSTOMaBnd8g6qNir8dpVGjthOk3qa8RrI7+dN4RN7V/P9?=
 =?us-ascii?Q?cxPOt8CfINzgQfc6JOdiQCzOdaelI+DhkJ0SKykXX0Gismig8LrIUsM4gceA?=
 =?us-ascii?Q?2TinfjM//gnQCNchgSQeisWPgijR4ls0mrBDzvX+NTwcXBxsea1/rHKb7gir?=
 =?us-ascii?Q?XvL0Ayyol8CdcKEobpZ2L+izqMpuKLr1wE5VyWMII8TGB1arU1h8f2E6Upzx?=
 =?us-ascii?Q?CtBRisUaG/qjIlqyaxPq6+Ws9fNI4OFbGpTKVzvmVM64AS5rlYRJat52wLTV?=
 =?us-ascii?Q?tUQpJ531O0IYIQXmY72xHOtIuRNyVQbePNZzyzshvEQIwYc/2d0yK/hgfGfy?=
 =?us-ascii?Q?JgQNAttMNhNqU/wxMFcNj0FanFUrTBKskxKAXHo5liUlRgy5Ii1NBAKAt3M8?=
 =?us-ascii?Q?5acwbZhPTe24+XQxIP2CLdrAVm2/KzCjoEWJGMfpck5kB82TJlXLrvR9kM+B?=
 =?us-ascii?Q?z/qwKTinbNG9SgZTbaZbTwjJcWfHYmaNgy+x+ZVsgPqQ/ErjoiUtJ9n3b+za?=
 =?us-ascii?Q?MParSm5G5ZDOH1Yv5IWjQOvQvaCVN/1NNRNRIRo3m+9dlx8UvSTvbANLsoxd?=
 =?us-ascii?Q?QIRXfMNqAldMh9jxY8xCjg1gwjhQCJk4pXb2947cS/J2A2mxasBTr1skuJV0?=
 =?us-ascii?Q?Foukbk9gZ3IT617/bEaV1kx14bYUgcZ5aD34ef+FpyCrZPRCPlNfsJlovYpp?=
 =?us-ascii?Q?2HjgrX099WSgzZI9yW12iwKvbVGeYLfzjBYRv1CuodiYOINpQ/r47W9jkT5Q?=
 =?us-ascii?Q?9uzp/h8SOAW1A9DyZOk5COXvUKCztPKmLSFHuNz4n0rDpcGchAes0mzQpZbO?=
 =?us-ascii?Q?jwaOvUaV14/U+CLh577psbtAqQKq/erRsZafA7ucCToUpvcIrnPjNURuSB4c?=
 =?us-ascii?Q?79Ugm9wIuG2CZNSNMF64xWEB0uRCuQcvVFaoYNt458dTT2PLa4ndY0GxX8ps?=
 =?us-ascii?Q?04nVPH+evglCkNtrLIViQbj6TDTwIG1w5G0EeadBZdsC6jKU0SxyhW/dJ2Ft?=
 =?us-ascii?Q?O0n7ZqQR2K16HBHI15ZUBQs3awDGSJ+fdvfU8W0Rka/T4vo99Qc4PLU0UlkY?=
 =?us-ascii?Q?vXB9hXk4/a5P/0lYbO5XiipCepsOJwtYCzlasvVjXaS1EjWRxJD9/6rGCnYM?=
 =?us-ascii?Q?xS+1Q0MErPNI3T1HJIGttNTySB9ex3KDVBP+/ufX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f84671b0-ec4f-45cd-e751-08dbb2a2bb71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:40:20.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEBveC2Nf7qXFYS6t4lWBWpV5oOs6eygtKddMhoYQniH94t1L6KrVPOC/5QB3C6DX6uD87+k9TNk5jFBxoJQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
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

Hi Aaron,

thanks for the review,

On 2023-09-11 at 15:26:29 +0800, Aaron Lu wrote:
> On Mon, Sep 11, 2023 at 10:50:00AM +0800, Chen Yu wrote:
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Inspired by Mathieu's idea[1], consider the sleep time of the task.
> > If that task is a short sleeping one, keep p's previous CPU idle
> > for a short while. Later when p is woken up, it can choose its
> > previous CPU in select_idle_sibling(). When p's previous CPU is reserved,
> > other wakee is not allowed to choose this CPU in select_idle_idle().
> > The reservation period is set to the task's average sleep time. That
> > is to say, if p is a short sleeping task, there is no need to migrate
> > p to another idle CPU.
> > 
> > This does not break the work conservation of the scheduler,
> > because wakee will still try its best to find an idle CPU.
> > The difference is that, different idle CPUs might have different
> > priorities. On the other hand, in theory this extra check could
> > increase the failure ratio of select_idle_cpu(), but per the
> > initial test result, no regression is detected.
> > 
> > Baseline: tip/sched/core, on top of:
> > Commit 3f4feb58037a ("sched: Misc cleanups")
> > 
> > Benchmark results on Intel Sapphire Rapids, 112 CPUs/socket, 2 sockets.
> > cpufreq governor is performance, turbo boost is disabled, C-states deeper
> > than C1 are disabled, Numa balancing is disabled.
> > 
> > netperf
> > =======
> > case                    load            baseline(std%)  compare%( std%)
> > UDP_RR                  56-threads       1.00 (  1.34)   +1.05 (  1.04)
> > UDP_RR                  112-threads      1.00 (  7.94)   -0.68 ( 14.42)
> > UDP_RR                  168-threads      1.00 ( 33.17)  +49.63 (  5.96)
> > UDP_RR                  224-threads      1.00 ( 13.52)  +122.53 ( 18.50)
> > 
> > Noticeable improvements of netperf is observed in 168 and 224 threads
> > cases.
> > 
> > hackbench
> > =========
> > case                    load            baseline(std%)  compare%( std%)
> > process-pipe            1-groups         1.00 (  5.61)   -4.69 (  1.48)
> > process-pipe            2-groups         1.00 (  8.74)   -0.24 (  3.10)
> > process-pipe            4-groups         1.00 (  3.52)   +1.61 (  4.41)
> > process-sockets         1-groups         1.00 (  4.73)   +2.32 (  0.95)
> > process-sockets         2-groups         1.00 (  1.27)   -3.29 (  0.97)
> > process-sockets         4-groups         1.00 (  0.09)   +0.24 (  0.09)
> > threads-pipe            1-groups         1.00 ( 10.44)   -5.88 (  1.49)
> > threads-pipe            2-groups         1.00 ( 19.15)   +5.31 ( 12.90)
> > threads-pipe            4-groups         1.00 (  1.74)   -5.01 (  6.44)
> > threads-sockets         1-groups         1.00 (  1.58)   -1.79 (  0.43)
> > threads-sockets         2-groups         1.00 (  1.19)   -8.43 (  6.91)
> > threads-sockets         4-groups         1.00 (  0.10)   -0.09 (  0.07)
> > 
> > schbench(old)
> > ========
> > case                    load            baseline(std%)  compare%( std%)
> > normal                  1-mthreads       1.00 (  0.63)   +1.28 (  0.37)
> > normal                  2-mthreads       1.00 (  8.33)   +1.58 (  2.83)
> > normal                  4-mthreads       1.00 (  2.48)   -2.98 (  3.28)
> > normal                  8-mthreads       1.00 (  3.97)   +5.01 (  1.28)
> > 
> > No much difference is observed in hackbench/schbench, due to the
> > run-to-run variance.
> > 
> > Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
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
> 
> Should this be written as:
> 		rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->se.sleep_avg);
> ?
> 
> A even earlier task may have a bigger sleep_avg and overwriting
> rq->cache_hot_timeout here with an earlier time may cause that task
> migrate. Not sure how much impact this can have, just someting hit my
> brain while reading this code.
>

My previous thought was that, SIS_CACHE only honors the average sleep time
of the latest dequeued task. Say, task p1 goes to sleep, then task p2 is woken
up and godes to sleeps, we only honor the sleep time of p2. Because we don't
know how long p2 has been executed, and how much p2 has polluted the L1/L2 cache,
and does it still make sense to let p1 be woken up on its previous
CPU(is this CPU still cache hot for p1?)
 
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
> > +
> 
> Maybe introduce a new function that also considers rq->cache_hot_timeout,
> like available_idle_cpu_migrate() so that above and below logic can be
> simplified a bit?
> 

Yes, that would be simpler, I'll do in next version.

> I was thinking to simply add that rq->cache_hot_timeout check to
> available_idle_cpu() but then a long sleeping task could be forced to
> migrate if its prev_cpu happens to just deschedule a task that sets rq's
> cache_hot_timeout. I guess that's why you chose to only change the idle
> semantic in select_idle_cpu() but not in select_idle_sibling()?
>

Yes, sort of. And the reason I did not put this cache hot check in available_idle_cpu()
or idle_cpu() was mainly because these APIs are generic and could be invoked by select_idle_sibling().
If the task fall asleep and woken up quickly, its previous idle CPU will also be skipped,
thus no one could use this CPU within the cache hot period, including the cache-hot task
itself.

thanks,
Chenyu
