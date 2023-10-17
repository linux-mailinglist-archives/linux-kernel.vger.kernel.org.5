Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B657CC18E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJQLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJQLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:10:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68FB6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697541017; x=1729077017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XkQf+V/AObazhO7bj82JZ++c/1FfyCPimdbmNhhJEuQ=;
  b=gCUeRiZVQMIDksy8oq7EyLBhmvOIlrgg3mzct23m1xNWMXcMUEVyZMZU
   JDrB/6UaZBFu5ZfSsiacC5ke7hFYkg2wpcOxcPi+gODthZHnUFuhZmwe2
   CLQRWYiXR234e0O2S19F7U35H8BhOIIGNL0tVqqVz+TeYldy2MLq4AJu/
   VXCIFu4JyweERMzQMKJgNKa7VYSdEIZJPHH90oBAGQrte5t56bCSyYnhf
   waO8iYG0Ynwqip2PaPhlvVoQ1a9Zgtf3nI4pyZGsD+qlv44qg+1p/64OF
   ruF9Ln1Kn/VJ/Fg8US3IMiYo247ae3hCUy7tz3K7niZoOB9XUNWzT9OGz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382980919"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="382980919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872522120"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="872522120"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 04:10:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 04:10:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 04:10:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 04:10:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 04:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr5xiZbN2Eb04rLux+kdL+rpsjd1RCbAQsqb9bQkosMHTjM493pRiv7aqu2CtPJiRLe4spPd5AH4DX6Nv7RuFsBjkMokbAMmUHEl8g1/7sc0L4YNemMhYvSh8GkQx4t8CG+FWBGh5Ujv0/CYWhcDzs5oHM/G9NJPkP7EOOwjj8yC8BP85LNBLTgmY5ZQlSPBsOWvECPB7GelD+ATxivKo0XABYdxjrJcPNMqSX3SN6yX8BRgjqxdXaFVrfta0i4mf4Hu+o2BHuDv+QbQg6nJ8SjSeOQI7L65lI7iBmpjcYH0m+PMSAtpYJE4R5HROO36tD10J05/AirPZp1sNVvkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd7qsYXR5GT5iwHYCgbX34tSFqxhlT64GyykPn0YFXE=;
 b=eSnneJREllX4homPwzT0cy771Hvtho9xZdNMJ9VKfWCo+z+5JxuqikQt5rxRLInOlD1MENygqZspYC2fY83XhtuQLcDQQJvio546Y1cjkv1EuRVbm4swWrhBF7fFSo+xIvJz0lrNNPZfw8EPMbb5K/c/02e031wyqL56OUv7lNTslrdGOhWg4BVw1A4yPGN+W2FGQnenAyOQnqBEDJ2vPhh1LWT9H7IiMdm22/hMd6MVSbmFxewh7Cg05xA/dLKdD9ytKT4TCNB+9wy3qpXhyln8AkCutmm5atnuxD21raVCiFlcKhZTOfV5sUx8rOzUVjCWofYX/rsnYb3D++01iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:10:12 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:10:11 +0000
Date:   Tue, 17 Oct 2023 19:09:56 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     <cover.1695704179.git.yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZS5rhO5XysGOUn4M@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <3f98806b-fd74-cfba-b48c-2526109d10a3@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f98806b-fd74-cfba-b48c-2526109d10a3@linux.ibm.com>
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bc4f0a-a80b-4f2e-cc5c-08dbcf01a19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVd1NLrr8gyZoIarVx485SVNbWsd6nGEDChonCSybOocLqR9817VFb+2l7RHgiWGJ0/gVP4/4xvxLWo0raeqes0YgEy6NadZutjux4eJApm8nh+PvUk7L/2IrxYzHf9qNCE3JgHJdCFE7zhlC8Phm+pRHivA+1LyETUH36b/J8jAt3/VOE0zi+w04Iy0Li8v6N/RgCqStmn0biiZ7lvKyWuPzkwJlL5QBPeMUj3xb3/4UEjpE0j4X5Lvw6N8DTAJffpob663wYM6zrEECY83gGOcGNmWWw2j7QNA/N3BZHF4Lx/OmfUWzm3xky508ZGb7rcr3SbaCngEAcPUm7uzmy/rz0Kglon+3KYd5wT5JS/xyPagzM7wqkAzjFGWYEBlZnZ3WNuUv678UOhMDks70y2+Dw20mzTsym+uMb6lX2swmx4SzCtaEmnnpgGa6GkXb2Fmn7RQRfLa7sWrBRdDY1w4Lv6nv8p82DDB3OUw8eI9vbcoT4msWxGf2DYY/g09C92zr/o0pfqSM9WVzhl0jNYSSRWNfrsnqfrXPFgkt2Ct+ExjmtJGzmhbGtEdDBRcukEDEEMUS5PevYsypFaVdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(7416002)(6506007)(6512007)(6666004)(4001150100001)(2906002)(5660300002)(34206002)(8676002)(4326008)(8936002)(41300700001)(66476007)(54906003)(66946007)(66556008)(6636002)(966005)(316002)(6486002)(478600001)(53546011)(26005)(83380400001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0eZNzU8TVc04/Fa04Bryg7TSQSROBUaavOLE3HATPb5ifjM6T++r9DP4DIR?=
 =?us-ascii?Q?pMCaWqT5Jq6Wby56kHEbdcIzYMuuNS/cPO2F8S1qOUfIeqi9R1f/yd6bESDp?=
 =?us-ascii?Q?PAIT965Z8rdtgP9giAGy0P39V9qv7banUfE6xNQEBYkOk6HWyTxS+He9s7hQ?=
 =?us-ascii?Q?j7sHNhQClrg6+MUwDUMjkmkappFDA1HFMx7VDdakEncSaz9WkfFCeaFjnbaw?=
 =?us-ascii?Q?/S1ktfX5OBHgrYOrvutRFhCPjGirdUYf0DLMGJ/2j7I/PlSk1d+Sf3YoWUZB?=
 =?us-ascii?Q?gie1gFqst1M8jo49LyctFIDo1y1fftjssqySP253MgPuZ7NBWCRC6xvXAaGn?=
 =?us-ascii?Q?jR8EALRjzmeSoEISZ8HpUaYP1F39kn7k1PZiEP90DENkwa0Tt5YH34FvmhjG?=
 =?us-ascii?Q?GRDwMmtRgFTfAXqtBeyMGF4q5GenfRZSgRVCNkDQY3I3lmX1mJaU16pMH92o?=
 =?us-ascii?Q?S8O1jEiQjTmF2/swiPwiYg4J27p05vLY9UqLbSk9AZ4GqT00QKZE2scsSmib?=
 =?us-ascii?Q?646kTUvZkoYHopY3W6jY25E206+R1g8NFBgb1Gag5nx7S9QhTv7OfAQiee7g?=
 =?us-ascii?Q?6xLRwL9mhkiUXn8Fsd5I24omUaTYey2hBFkB5qCbITHneHfnKmqTBlMRT1gW?=
 =?us-ascii?Q?FtTw+7/ISpjg/1YXYV88V68sqR0WYcc3KajVlVfKeTaE5xbJVneK6tHb8KHS?=
 =?us-ascii?Q?gByzeMK7yTi3lmTCSqbO1FiucMQNZRqQ7V4iErl1byDtDg7xGqTRqOYFNUYi?=
 =?us-ascii?Q?agmkboL+t1pqCreO18c5qHulpCN1N2iDkWPTSt5fbNTQQi/FqZcqR7kPLdGn?=
 =?us-ascii?Q?vDtq60672HGMMtTPXL/BeKcdGsp88rYPU/1RHbzaaKpPywiRQ7U0pFlqK68C?=
 =?us-ascii?Q?J1YHPbv6KF9PpFAWkH8fhyeej/CD3DIT+Eb2wD/t2A5Gc3kD2wuSSscchGVd?=
 =?us-ascii?Q?v5wx+x1FLDr9g54NXn5OQr9TKPV+/Z01bwyRmDS4ZxvQJkdhOn/yN48vVZnv?=
 =?us-ascii?Q?jKNHz3zUL0in0aPlC3ya5g2hauCa3JhX7fHdQ2kPnqehHbKJgUluSWuqMg/c?=
 =?us-ascii?Q?rFMV2PstZbVq9oy6uBUuzBchvyNT7UnaYWTFn1nYSaEU3xept58J6LapFyjZ?=
 =?us-ascii?Q?DDVIMUEc8I5hacMXNBH+kmjQjG/vQ9R6wqwpfCjFAT1WKRVrUEFaONsCNO4+?=
 =?us-ascii?Q?BXu/BgA0IffHtwzw2zNmu1X6wOrMVPcR+PumKydvbzZ9FtTaOvR00xnBl/uL?=
 =?us-ascii?Q?VpjYlcC811ccKgc1hPWSX+cl+Y4nwFQByif99sTCa01Pzt3zLffdg8nmjr9Q?=
 =?us-ascii?Q?c/oaGR59TXk3MP6ifheLX7pzGU//1KAxSQKfYHYdJPDee1MOf6lnE7T7SaBB?=
 =?us-ascii?Q?6Qp3t9HDabByUnyaLMt4LCfOlzMD+A177s/7uLMU22L1ubDAlcYrWcMSbnCR?=
 =?us-ascii?Q?iXyMkQoBcAQyl5n3iJOjsP5Ch1O6kTuR9mvpFWcblDN/xX1WJ1/KUnoMX6G2?=
 =?us-ascii?Q?6xV5n1THaxMQ31c/uffoNqTkOg70mlEoTR5OAFyCBz1bFtLEHaWdEhyTQzEr?=
 =?us-ascii?Q?/l2tAX19sXQO5CaeROSINHKNSAJEzkStkMDP4iTy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc4f0a-a80b-4f2e-cc5c-08dbcf01a19c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:10:11.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sD732Vph30jyqQHah4JtBE3odXaQf2SXexBhpDGbjnnR+5VlV+UX24uwduX6vTlrif94t4DLNzpXfHDOrQpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
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

Hi Madadi,

On 2023-10-17 at 15:19:24 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 26/09/23 10:40, Chen Yu wrote:
> > RFC -> v1:
> > - drop RFC
> > - Only record the short sleeping time for each task, to better honor the
> >   burst sleeping tasks. (Mathieu Desnoyers)
> > - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
> >   (Mathieu Desnoyers, Aaron Lu)
> > - Introduce a new helper function cache_hot_cpu() that considers
> >   rq->cache_hot_timeout. (Aaron Lu)
> > - Add analysis of why inhibiting task migration could bring better throughput
> >   for some benchmarks. (Gautham R. Shenoy)
> > - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
> >   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
> >   (K Prateek Nayak)
> > 
> > Thanks for your comments and review!
> > 
> > ----------------------------------------------------------------------
> 
> Regarding making the scan for finding an idle cpu longer vs cache benefits, 
> I ran some benchmarks.
> 

Thanks very much for your interest and your time on the patch.

> Tested the patch on power system with 12 cores. Total of 96 CPU's.
> System has two NUMA nodes.
>
> Below are some of the benchmark results
> 
> schbench 99.0th latency (lower is better)
> ========
> case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
> normal          1-mthreads      1.00 [ 0.00]( 3.66)            1.00 [  0.00]( 1.71)
> normal          2-mthreads      1.00 [ 0.00]( 4.55)            1.02 [ -2.00]( 3.00)
> normal          4-mthreads      1.00 [ 0.00]( 4.77)            0.96 [ +4.00]( 4.27)
> normal          6-mthreads      1.00 [ 0.00]( 60.37)           2.66 [ -166.00]( 23.67)
> 
> 
> schbench results are showing that there is not much impact in wakeup latencies due to more iterations 
> in search for an idle cpu in the select_idle_cpu code path and interestingly numbers are slightly better 
> for SIS_CACHE in case of 4-mthreads.

The 4% improvement is within std%, so I suppose we did not see much difference in 4 mthreads case.

> I think we can ignore the last case due to huge run to run variations.

Although the run-to-run variation is large, it seems that the decrease is within that range.
Prateek has also reported that when the system is overloaded there could be some regression
from schbench:
https://lore.kernel.org/lkml/27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com/
Could you also post the raw data printed by schbench? And maybe using the latest schbench could get the
latency in detail.
 
> producer_consumer avg time/access (lower is better)
> ========
> loads per consumer iteration   baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
> 5                  		1.00 [ 0.00]( 0.00)            0.87 [ +13.0]( 1.92)
> 20                   		1.00 [ 0.00]( 0.00)            0.92 [ +8.00]( 0.00)
> 50                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
> 100                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
> 
> The main goal of the patch of improving cache locality is reflected as SIS_CACHE only improves in this workload, 
> mainly when loads per consumer iteration is lower.
> 
> hackbench normalized time in seconds (lower is better)
> ========
> case            load        baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
> process-pipe    1-groups     1.00 [ 0.00]( 1.50)            1.02 [ -2.00]( 3.36)
> process-pipe    2-groups     1.00 [ 0.00]( 4.76)            0.99 [ +1.00]( 5.68)
> process-sockets 1-groups     1.00 [ 0.00]( 2.56)            1.00 [  0.00]( 0.86)
> process-sockets 2-groups     1.00 [ 0.00]( 0.50)            0.99 [ +1.00]( 0.96)
> threads-pipe    1-groups     1.00 [ 0.00]( 3.87)            0.71 [ +29.0]( 3.56)
> threads-pipe    2-groups     1.00 [ 0.00]( 1.60)            0.97 [ +3.00]( 3.44)
> threads-sockets 1-groups     1.00 [ 0.00]( 7.65)            0.99 [ +1.00]( 1.05)
> threads-sockets 2-groups     1.00 [ 0.00]( 3.12)            1.03 [ -3.00]( 1.70)
> 
> hackbench results are similar in both kernels except the case where there is an improvement of
> 29% in case of threads-pipe case with 1 groups.
> 
> Daytrader throughput (higher is better)
> ========
> 
> As per Ingo suggestion, ran a real life workload daytrader
> 
> baseline:
> =================================================================================== 
>  Instance      1
>      Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
>   ================       ===============   ===============   ===============
>        10124.5 			    2 		    0 		   3970
> 
> SIS_CACHE:
> ===================================================================================
>  Instance      1
>      Throughputs         Ave. Resp. Time   Min. Resp. Time   Max. Resp. Time
>   ================       ===============   ===============   ===============
>        10319.5                       2               0              5771
> 
> In the above run, daytrader perfomance was 2% better in case of SIS_CACHE.
>

Thanks for bringing this good news, a real life workload benefits from this change.
I'll tune this patch a little bit to address the regression from schbench. Also to mention
that, I'm working with Mathieu on his proposal to make the wakee choosing its previous
CPU easier(similar to SIS_CACHE, but a little simpler), and we'll check how to make more
platform benefit from this change.
https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/

thanks,
Chenyu
 
