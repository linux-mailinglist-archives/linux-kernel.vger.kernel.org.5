Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6631D7B1560
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjI1Hwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjI1Hwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:52:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E061F9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695887561; x=1727423561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F0mhc92vCv4gQR+xROT1Kfawmzv4XIU7TP+vVqyFEHQ=;
  b=fjLXBAAeLr0VRb7sepUwREjcp6ueF2YVzfFgmIK/79JML8EmWVhbJcc2
   COkgDDcl0CQw09corvyLVxxd7Jr6iR94482dyf0nIShI/GuQFjfcIcmuq
   qurirCqX8/c+lRxPvfaSUrXtfOWwylZrERpG3iPq7CNeUZpWjqcsElMzu
   +BK4bVn2GRbD1BLgTCz+UmMJEEi0CQaJ+BV7fwNuqBoIY6ZfOSy0qkOyE
   g4k8qf4I5ipsmC3jZzBHYFf0DAY9gzols/U6EsGwVHBFSQ1Mk/csKZqYI
   vYR7SLRe2gbvKrtKErydSwX5/RwJLIQNnFkzJHdVORki5O1caI+nlGvHC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361379371"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="361379371"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726141495"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="726141495"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 00:52:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 00:52:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 00:52:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 00:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT8HqHmhu70lHtqsACDbeBSK56DyN4meO/FjznpSp4Btyd/5FAwlBfDAWdRa2kJitEgqUss+nXGrj3n2aFWOi9+kasck1ILesIIFoB89uwKi3YaXtjHoUOwz1btXau/8As5plZOwdgKUR871Krt1rgkXjehq28zQb9CfYIi56Yik/m6Pj/RhV71ddzXJ3kXAofNfLI6fCn6WCBtkOGcyXH0iZzU97S5CYVZe7mTIpa6z6IgQlnHfKwxL0YUsW2KQ/ctDCoW05hLitLsJWLabsgxpxKvWU3SNepYiPn0BYiZJB5ml4jaXpPV81J7DlBsLbKxoPMvMSlzpjH6eIBOBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38VNoEJiZVqjI6N5pw71yITIPyh7v2S+gcUJ9Drx5Bk=;
 b=AcORjGADGqtivf8an2k1d35ILVdixc3MMKdICrsvfyUBTAtWEcgdMJsj2EEsXuRalk+oILDjm/dOqvQdBYIlEk34AVnx9WLk2LhQL3wpZ5E143aTyVm3iiezbNCMfwaKl81qct11pd+jLonYhnV8C/GkBPSZAnXKmrFy4SYc4YHeM0XLLS5Gjas8H6aFuskTJnd7+GI2TTYhU1yAhJyC5W7TbPTuDyvn9KZEKz34MgaAeQGpQVRXEOFKYTI/g4DDf/FiohEKz6uXnI9UVs+yTspDU/vGTyrBYNKeupMDYoUhTtns8eJLiPDXhRhBG4U6jNh7Vs3C/z13Bje7RbosNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 07:52:30 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 07:52:30 +0000
Date:   Thu, 28 Sep 2023 15:52:14 +0800
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
Subject: Re: [PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZRUwrnd5bnUP/kU/@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <4f2131940d43060eda55847a2affc8042179b4ee.1695704179.git.yu.c.chen@intel.com>
 <5a7d9084-a716-5641-6319-ae8c918ac3f9@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a7d9084-a716-5641-6319-ae8c918ac3f9@efficios.com>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA2PR11MB4842:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f57258-a14b-4409-6abc-08dbbff7dd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orMKq4ZJ0x9QEXjLnb0oK1WN1zUFZH3X1WTXcSz7+7OsUL2MCzX1ReXGM+QEQWBxVEwRgWsCn9RaLMrHm7fBuNmX5dAHUeU+rRFHZrUTa6DsLrjWHdqDaQAXmqgKbCq9VLmm4/QKEnOxlNlCP0lbfSfOYGGh5sqGVtXOh8n2PbOQTsKAV6y5T8Ta+VEhvm7bxh8Ux0+6mbSwoFPJa7ScjaFFmosOcKWudhnuW+g4dGwg7liGxNQM4Ke+F2sfYFd4GG8A3CuACM97aPiQDlhkmBHYqJGE+RnB1amkNuw8FAFJghBQFN87fLKHu06pLCnFFYMh5ydWipTcP+zBbDU4W3m0tewhOIXpFpKCJP1qWcoPKvYs9QMGKCiT18mquGZCN/X9+BnxHE2oVw9l7keP1ZKIoBrIXk39UFN9lyR4cmJM2DxnzNfT/sleq9i156dIfJkW6ZaXGpzYUWe8WtYNpPrbKpOxwigNIyJYaieO5ezwfzlSo5wH38VarinWd9oK+6jfcUcqygLyGD52/4xIHrg94k1F2vHSJJWUM600bs2TK/1i8EW2Y4AUbwb7km3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(53546011)(2906002)(86362001)(26005)(41300700001)(6512007)(7416002)(82960400001)(6666004)(6486002)(478600001)(38100700002)(5660300002)(6506007)(4326008)(8676002)(8936002)(66946007)(54906003)(316002)(6916009)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrtW66DX/9O+Hzjdfe8byR2CDBO4TPDhEy8fZkhwEz0yGMbVDlnBmXP/3trM?=
 =?us-ascii?Q?3jSCK0J/mZ+vrsIO9j/gB3bIdd7PNH+EDPzBdFZp6nuGc70RnrOqbGPn6tXR?=
 =?us-ascii?Q?zPLgLDzqTTf0gnDt04Tsg2wRN2wNaUgigS7YJMulhHDl8g6Hj1iuqZiNrEo7?=
 =?us-ascii?Q?DKqm0EvBJG0GDqDm3fI7kdaTFD2mn6cEv8RWhR6UvAV4tRjS1gyw8Iv0eJ9k?=
 =?us-ascii?Q?8Xhnm8deI8Xl+abJImW/RR8s8lmw+XhEBISYs9RBaai1OqOX5Mcusjy3f1wC?=
 =?us-ascii?Q?oL0yDvqAmZRdJaWRapx9I9kbbCvM7UX1mhAPJnVUTjlU1IQFURT3vT62Isra?=
 =?us-ascii?Q?p3PpX4hF4oXV3o537em67k2Wye1TTerO5lPCU+9XXzbdJ/T4P6VBQiUf+E+A?=
 =?us-ascii?Q?ifEEPnXn6PCcqxhYYZY+Di6h2mpqESflUiWTaFpa9kQgBleyRs7TyJKIUbb0?=
 =?us-ascii?Q?xUnxlKhZ+66vSEiE0AeWtTiPRNFt3UX/u0cUiZr1udxUdrv0dkCRfyLRTj2F?=
 =?us-ascii?Q?kPfu3npQSNl9R5WE6KIJqCPOjDYKjkB3jkMA1qXO/DE7QIyRAgdauzVzCVc+?=
 =?us-ascii?Q?ns/6ydTkNgxeID2QogQZUMHOecFYmn6yIesm8MLyviGwZROih9cnh9IbBNjH?=
 =?us-ascii?Q?LKNoZAc6+iTFFjSo5Z4VAAesLMeg32jVdX67xtqjR2w58IxfbhR1BzsjL20V?=
 =?us-ascii?Q?7zx0t2peVlnB/6g/XrkbpfOzAxyziBCB+1mz4Y/OH2jwWPgfiTzkt8pb6m/9?=
 =?us-ascii?Q?ShfWX5MtfmlzhIjLjrB6o20nEIS/Y1pK3j1Ho7KlF3DGQPBNk46bWO4DxZK6?=
 =?us-ascii?Q?dReE6kWbmBoSv/rtsdVOWOvNE7UYSQk6B5YFjE+pZkkvx8ZZ12c5nNIYY0Gh?=
 =?us-ascii?Q?lQbOD61uciMbytrB76UpoMYm23J3lcC115zjJQQ8pzA7cqX/9zf4wL5FRmIP?=
 =?us-ascii?Q?OPw3l9gzT8ganlcWveOSVYWZ5jNaz1EcLO5dE73XfhPnpV0/A4XSd50Npajb?=
 =?us-ascii?Q?c1MdwblFOSHBeHjawRv9CpoZ5IM9lH/q54yxWQcZDfUXtumNu19xKXwZOS32?=
 =?us-ascii?Q?NdThioCMeCYwr5SIf8oUgs1QNjWkRoy03PB9iSwM19/97U8+Pa89GCwcmf2G?=
 =?us-ascii?Q?OVO5q9GwDPOd6NnNqgEzDcHIX5xT3yjSTioxjACI3ua3pgQ2WThybS3XFWsR?=
 =?us-ascii?Q?NWx+G6BoIdGtHNe7cfsIZLzpTRs8+bRqRk7dNA2TXys5dCx6yJyQCrFYqDLd?=
 =?us-ascii?Q?+y7q8RadTr0lwKRAvnzvXeYkMOKxBY9dKWYw1sCQ5C88X0kACf5aZTuODp92?=
 =?us-ascii?Q?GUDhmWRxTbLo4SurBAYCZO4WxWjRGaioof65rZ6X/bRP0XSHKON/sLwO2VSZ?=
 =?us-ascii?Q?PFcL5Wx/jP59dbKuEaZetCDTVzYaIGl/bPwxVWKKFT8sqUfhFgv405T4x496?=
 =?us-ascii?Q?8V/0ax7gD17Ghs5BNbn7Ke0ZbKGoqVH4M/wmM/O5g+4fVbVuxyEb3Q2epRBm?=
 =?us-ascii?Q?sK+n/NH4gr1pk+bJCQ68mzC+yXYeL37DkmCoXrVurZN23hOHPpIA9jypfS0/?=
 =?us-ascii?Q?SOensy8HNAn/ycTr5AF67QvNpoXhNFR8+exIiOq7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f57258-a14b-4409-6abc-08dbbff7dd07
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:52:29.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdksDp/r4r0F9nbK6HyJHYj72/3aEukf96Mxx5eMEc4YZGpbzvA6/HnpWiN8zcXkbrWn3uftqYfGIVLQ4m7MBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
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

Hi Mathieu,

On 2023-09-27 at 12:11:33 -0400, Mathieu Desnoyers wrote:
> On 9/26/23 06:11, Chen Yu wrote:
> > Problem statement:
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases, the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Proposal:
> > Inspired by Mathieu's idea[1], introduce the SIS_CACHE. It considers
> > the sleep time of the task for better task placement. Based on the
> > task's short sleeping history, keep p's previous CPU idle for a short
> > while. Later when p is woken up, it can choose its previous CPU in
> > select_idle_sibling(). When p's previous CPU is reserved, another wakee
> > is not allowed to choose this CPU in select_idle_idle(). The reservation
> > period is set to the task's average short sleep time, AKA, se->sis_rsv_avg.
> > 
> > This does not break the work conservation of the scheduler, because
> > wakee will still try its best to find an idle CPU. The difference is that
> > different idle CPUs might have different priorities.
> > 
> > Prateek pointed out that, with SIS_CACHE enabled, if all idle CPUs are
> > cache-hot, select_idle_cpu() might have to choose a non-idle target CPU,
> > which brings task stacking. Mitigate this by returning the first cache-hot
> > idle CPU if no cache-cold CPU is found.
> 
> I've tried your patches on my reference hackbench workload:
> 
> ./hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> 
> Unfortunately they don't appear to help for that specific load.
>

I just ran the same test on a 224 CPU system and it seems that
there is no much difference with/without SIS_CACHE. To figure out
the reason, I used the bpftrace to track how often hackbench is woken
up on its previous CPU:

kretfunc:select_task_rq_fair
{
        $p = (struct task_struct *)args->p;
        if ($p->comm == "sender") {
                if ($p->thread_info.cpu != retval) {
                        @wakeup_migrate_sender = count();
                } else {
                        @wakeup_prev_sender = count();
                }
        }

        if ($p->comm == "receiver") {
                if ($p->thread_info.cpu != retval) {
                        @wakeup_migrate_receiver = count();
                } else {
                        @wakeup_prev_receiver = count();
                }
        }
}

and print the data every 10 seconds:

NO_SIS_CACHE:
23:50:24 Wakeup statistics: 
@wakeup_migrate_sender: 9043961
@wakeup_prev_sender: 20073128
@wakeup_migrate_receiver: 12071462
@wakeup_prev_receiver: 19587895

sender: migration/previous = 45.06%
receiver: migration/previous = 61.612%


SIS_CACHE:
23:49:21 Wakeup statistics: 
@wakeup_migrate_sender: 6716902
@wakeup_prev_sender: 22727513
@wakeup_migrate_receiver: 11547623
@wakeup_prev_receiver: 24615810
 
sender: migration/previous = 29.55%
receiver: migration/previous = 46.91%

Both the sender and receiver in hackbench has raised the chance
to be woken up on its previous CPU, but not as much as netperf.
Why there is no much score difference? I checked the bottleneck
via perf topdown.

perf stat -M TopdownL1 -- sleep 10
perf stat -M tma_frontend_bound_group -- sleep 10
perf stat -M tma_fetch_latency_group -- sleep 10

NO_SIS_CACHE:
15.2 %  tma_backend_bound
14.9 %  tma_bad_speculation
43.9 %  tma_frontend_bound
        30.3 %  tma_fetch_latency
                9.7 %  tma_ms_switches
        14.0 %  tma_fetch_bandwidth
26.1 %  tma_retiring


SIS_CACHE:
14.5 %  tma_backend_bound
15.3 %  tma_bad_speculation
44.5 %  tma_frontend_bound
        31.5 %  tma_fetch_latency
                10.6 %  tma_ms_switches
        13.0 %  tma_fetch_bandwidth
25.8 %  tma_retiring

There is no much ratio changed with/without SIS_CACHE enabled.
This is because SIS_CACHE might bring benefit if tasks have a large
cache foot print(backend like netperf), but it seems that hackbench
pipe mode is frontend bound and its bottleneck is the complexy of the
instruction being executes(tma_ms_switch: MS is to decode the complex
instructions, the increase of MS switch counter usually means that the
workload is running some complex instruction), that is to say, the
pipe_read/write's code path could be the bottleneck. Your original
rate limitation on task migration might be more aggressive to reduce
the ratio of tma_backend_bound, and that might bring the score benefit,
like netperf case. Let me apply your original patch to confirm
if this is the case.

thanks,
Chenyu
