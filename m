Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007397CE070
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjJROza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjJROz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:55:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878394
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697640925; x=1729176925;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=/1FbuhGb2kSac5dvpTjVFIbbCGrtQx3c8RgFq+JoZho=;
  b=LTnIDB92Xf0+rhqnk6SdeJhHLOumQFcHk7QzVd7rH9w4tHgZ6qh7Fu4d
   CRiG0AAr6rAabl58l30AInxZV0Yt+vDtssRrreAq6AMhw/iNwUnuYDu/r
   8DhL7PMdhpvUJJMn0o95TKTvM2k4KnEOS8QXsH/feEVwxMGGqzAkKRInd
   EMJReOh+i4A3eznBc5KoYQL9uK5TSsZYskTj1RL8ZD/xnkm1pU4doNW0X
   s3d+rjJzWS3pOEXarvUskzsg+LMjHOhadPTgCEr9o22ww5d6LA1AzjSHR
   R0uEDryN2ujbUT6bmbsiib65O/t/hi/i4lsnh/n1Kh3rq7j4JUG9kvxwh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452499449"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="452499449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930227364"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930227364"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 07:55:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 07:55:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 07:55:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 07:55:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 07:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+WSy45FZwMLk25wBuduKAkjnfBa1wGz33UENYDeqhHLSZTShZcZKV0H9unbFRYjlnijhbSR7mB1DRblin+m2NGpvU8NpMj0iMhdlJalMToFyxfxAmHIG16W4bSgmbBR/YOjWH2Wu5RiLlVF+7u63V8mepNExe+uiU3OusoL0MzYw53i1EFN9y1icrHSR1Q2Jz2si0qTrhT1JKzMF0adJW1rKUheHvlbRrEHKRSlzJ01vywzaRIF4+9wv+RcpGodY0zgBuDL9AFGGdYd1H9rCZDl6+K+rfwxPJ2owRqY/kKUpFI25vdhDQhNKVdZ70qZo42C8KezDZL4ntGCpENNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxmeld7C49lIdHVtaAYS9yandRUyiP8xwJgROUU1YmU=;
 b=ASvx3Slx++CA5Rt0bg+UEFIrSr1e2CsJR4XPAsJB11+dd/RbV6a5E27/2LQ1fMK5zVzZsywUHaec105dlw63ZcfXMZ/+Ncza9QhbgBAKDja+ZDYHLmskA8xaVO2wYe+4E53q7ggimwhIGxPr1rSZZDIi7t8nadUWgtFuxRs7ffH5cotKywYGca1YaZWPPs/AKAenTBb6S4UAyBIhUNFE+zqlO2wmtMAqx+sxrCKch4m7YdVAkUZzXgqVTUpS6Sx1PsQYaH12bG+pI1TcLEmC7CoZxsQ+9ZtqJWoh/uGJ3G7Z5GZ/07aUYVZasDVevCIscR99fe/vMbrzo7Scp3E+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 14:55:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 14:55:16 +0000
Date:   Wed, 18 Oct 2023 22:55:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Benjamin Segall <bsegall@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [sched/eevdf]  b01db23d59:  hackbench.throughput
 -3.4% regression
Message-ID: <202310182229.78d950b2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fb3a82-03c9-41b7-5e3b-08dbcfea3d82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /t1mzwS8dghRlbCQ1UEnFkBIRjnZvIUS+9/zKJfO9ViCjoi9xHfg7MJT2hdjLvlQ2Y9x1rxWLFneKHbag/6DyWn5RrXoG+sNMj1k2+MT/sUnK795w21kd+HHqfe2VpVxh7npkY4H9oxqtpyE5YahowHjqFxUxdGMNa9jPToUSGF01SCnpevsQRIOX83AELyqKzvxouCgukJX4p0vNeKA8Q4OiMyEQsV+ts7Uc1VYE7hf2flsM9GtWO/BSsd8wyYD/qBV+x2CFOkd/aKgsVMuYv9y371fT4xmbFo/YjL+cYb/BEp5vIiLcK84GNY1asTWkwrHpURw4Ko3Rqs9YA1VnA52rERzrRquTcw8ryHNJ80WdwfAet0t9XXGpOzLiPjYWcbZn+hRWvIcj14iWdiFTcsXBde2xL++oyIaDzMPcfsCrBJYpIkl/nvfsbK2CuCSJPFNwNE1QFBfquPhfvOp/18d4o4K/U/8+wdaG5lPG3AkFEnZ4e7fGN4AlG1HViEAonAiQF9g1T2SwTJBztPxUIkDBlkCyqm1/ooPCUGC/7aJU3H2erqfkFWPT/IBca7JKh8ns6bqMTxrrHrCQ5IKAyyC56RBE7itBU8vovsbYwbhyW5Eos0qspKUdL5LLvXW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(8676002)(4326008)(8936002)(38100700002)(41300700001)(5660300002)(86362001)(2906002)(6506007)(6512007)(478600001)(6486002)(966005)(6666004)(36756003)(1076003)(2616005)(26005)(83380400001)(19627235002)(66556008)(66946007)(6916009)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Nki5x4YOBDTAYQba9TsA5h+ACa7SzxL5dWxtwQ7ObW42vqrCI95Q3T6Vq1?=
 =?iso-8859-1?Q?IGqu07GTcoU2+2kxhSwqYCg4WmLIZd3FFreMPfrSEgMDwB/qNcexB/xXwi?=
 =?iso-8859-1?Q?XDZOUprLt7FI7KQ/7qcfH+jF0V3ykSPdO7UYmYiSHkrRH6d3sRT30VXE3n?=
 =?iso-8859-1?Q?N2ePx325qxwcpzflujcwqOp/gFd9O0mhA38p8PV5moECWV9t3UPyX3ma7C?=
 =?iso-8859-1?Q?ZYqgi6SxiFh+GCsm//ewgzrfGxh9W1nwonxj14g9dp1NkJvelbxWcF5EV6?=
 =?iso-8859-1?Q?rwsBU7WNi9x6tJO0QfKuOrs/WBZIuDddk3lWXgUeWsnEigY4du5DN/UkiJ?=
 =?iso-8859-1?Q?zDg5+AXTGNR/PtYEatNBm6bN+5WZKX1IoeSqTxb/PvKfyhie+QAME6plna?=
 =?iso-8859-1?Q?fIH3tMlm5wnNnCj1LOik1ywBk+ikpNApWH4Gb84e/dn6VR2ckebdbd/Sav?=
 =?iso-8859-1?Q?YeKRafW8ln0U2yOAoX9VtfgQOgnhG1jza2rgzuFm0JKrufXcxOhuQ/PhCN?=
 =?iso-8859-1?Q?FxSrq8vzUfuYthv+/kYyeFIZBvWvRkcNZV7mHMambcMDNMt3o1tVA35GIE?=
 =?iso-8859-1?Q?MAOM//8HaYab7k3TN9CuO/l6FWMx3y6q6mQ/CyjdMf4IZVZ6a8pmgcVkIe?=
 =?iso-8859-1?Q?enACBFC+o+icfZO7cdKNt7AtTB9HlZEAwrfhANduvtJa0qfjqarrnbT6YT?=
 =?iso-8859-1?Q?TLX472br7Y/MKDE3QdKgjaLhODrIORrdfAD+pjjMAdWZegXvIboFbY1Jmn?=
 =?iso-8859-1?Q?vCZMZTwUC36tSMedu3JKFTO/qNlthTXK95UywVmQd4x9x6qeYtum8nZ8hF?=
 =?iso-8859-1?Q?cOYJS4zs7apcb8Z/1Ussmdwko7dwSzjRv9O/wAZvBw02+6G9ofLrpT54u7?=
 =?iso-8859-1?Q?PJBgiy6PrrKyOTnW5LzL0WJ3j2X5NkXMpP2fQt3dT11Yo3c8xUx7ecVc8k?=
 =?iso-8859-1?Q?XIfoRo4lqieoFDvP5ZY8MyLRtqtk/qDgzFSpOHaAK4SzAvde9mAhtEcDnN?=
 =?iso-8859-1?Q?PjvHWxd7lHYgeUOTQuVVBTuR0L/B4pCHlESs568hAcaG22Neu9MUOfhhwS?=
 =?iso-8859-1?Q?wj6iYRDqZZKa6lxE7ZZxxrvS2oNJB/DhCDE8+huRUm1+y/+cVo9A0nwwz+?=
 =?iso-8859-1?Q?paJmV7mnT/Coyxi7XIvyHX6uYkMMQ28imqWHczMT2qwVCjTsUcR//p98C+?=
 =?iso-8859-1?Q?uMXAlDWopQ1z2OCqCo5iqL4FG56rt2Jdd1B98ui75FwNZIczVUFjciO04T?=
 =?iso-8859-1?Q?Iswq/LRdeMlQhPm0vCcKsm7rCAvFljjJyATDMAjB7YCCtbSfooysPeCRqg?=
 =?iso-8859-1?Q?won4mPBEi7Ol2e+fMHQ7wG46PJ9sRrt+mUQyR+YMd3q3Hs+df+hwmMjWZA?=
 =?iso-8859-1?Q?9ed/ZfLMaT28Logjtvo8C6C5OPYhCimtLV6TJXQDvfHWOOMmkn+kRkv1E+?=
 =?iso-8859-1?Q?st8TKJcnRoZ+satifoiAZCVVdgCs5e5EE0ue3c5ykBAJ/zcuM4f0SSnJu3?=
 =?iso-8859-1?Q?10ei3xVoUvmC5zifgy0Dzm/bI6L6Sl77cNRH/hMVrWyQyEOdtZquIlZIOE?=
 =?iso-8859-1?Q?AZncjW24KgZx0GJn8Z3atzIjJUy31Dw2ZjMv4rFYuMveBM1jgn/6LMxEgD?=
 =?iso-8859-1?Q?4MIEuWBWIN6I8HA2qFZmUFlelwnX5NjFkRByIRZt0MWCefPJSHVap0Ag?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fb3a82-03c9-41b7-5e3b-08dbcfea3d82
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:55:16.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muWC/rCpXI28AAoEYvTk2wH7yvpNbC4qFSGDHdeCHoiNt/U4oPlz05UqcEaOrt1HAH/+JQ/wj1pC/fsSBUrDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -3.4% regression of hackbench.throughput on:


commit: b01db23d5923a35023540edc4f0c5f019e11ac7d ("sched/eevdf: Fix pick_eevdf()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: hackbench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 50%
	iterations: 4
	mode: process
	ipc: pipe
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310182229.78d950b2-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231018/202310182229.78d950b2-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/hackbench

commit: 
  8dafa9d0eb ("sched/eevdf: Fix min_deadline heap integrity")
  b01db23d59 ("sched/eevdf: Fix pick_eevdf()")

8dafa9d0eb1a1550 b01db23d5923a35023540edc4f0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.958e+08 ±  4%     +11.8%  5.544e+08 ±  9%  cpuidle..time
     47.00 ± 54%     -74.1%      12.18 ± 87%  turbostat.IPC
   2127266           +10.3%    2347320        sched_debug.cpu.nr_switches.avg
     36.94 ±  5%     +10.7%      40.89 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
   8760010            +9.9%    9630735        vmstat.system.cs
   1087178            +2.8%    1117923        vmstat.system.in
      8690 ±  4%    +108.2%      18091 ± 33%  meminfo.Active
      8034 ±  4%    +117.0%      17435 ± 35%  meminfo.Active(anon)
    695914 ±  4%     -10.0%     626568 ±  3%  meminfo.Mapped
    559.67 ± 71%    +741.2%       4708 ± 11%  perf-c2c.DRAM.remote
      3119 ± 76%    +972.2%      33448 ±  7%  perf-c2c.HITM.local
    236.00 ± 86%    +240.7%     804.17 ± 19%  perf-c2c.HITM.remote
      3355 ± 76%    +920.8%      34252 ±  7%  perf-c2c.HITM.total
   1052797            -3.4%    1016737        hackbench.throughput
   1011957            -3.2%     979124        hackbench.throughput_avg
   1052797            -3.4%    1016737        hackbench.throughput_best
    917410            -3.0%     890080        hackbench.throughput_worst
  99425414           +14.5%  1.138e+08        hackbench.time.involuntary_context_switches
      6523            +3.2%       6728        hackbench.time.system_time
    752.72            +2.6%     772.26        hackbench.time.user_time
 4.408e+08           +13.9%  5.021e+08        hackbench.time.voluntary_context_switches
    538.27 ± 56%    +180.9%       1511 ± 52%  numa-vmstat.node0.nr_active_anon
     44253 ± 39%    +609.8%     314098 ±115%  numa-vmstat.node0.nr_inactive_anon
     34617 ±  9%     +83.5%      63505 ± 54%  numa-vmstat.node0.nr_mapped
      1543 ± 22%  +16311.4%     253377 ±141%  numa-vmstat.node0.nr_shmem
    538.27 ± 56%    +180.9%       1511 ± 52%  numa-vmstat.node0.nr_zone_active_anon
     44252 ± 39%    +609.8%     314096 ±115%  numa-vmstat.node0.nr_zone_inactive_anon
    138022 ±  9%     -32.6%      92993 ± 41%  numa-vmstat.node1.nr_mapped
     15216 ± 45%     -52.7%       7199 ± 84%  numa-vmstat.node1.nr_page_table_pages
      2553 ± 49%    +149.5%       6369 ± 50%  numa-meminfo.node0.Active
      2225 ± 58%    +171.5%       6041 ± 53%  numa-meminfo.node0.Active(anon)
    177208 ± 38%    +610.0%    1258121 ±115%  numa-meminfo.node0.Inactive
    177010 ± 39%    +610.6%    1257927 ±115%  numa-meminfo.node0.Inactive(anon)
    138899 ±  9%     +83.1%     254371 ± 54%  numa-meminfo.node0.Mapped
      6256 ± 23%  +16125.5%    1015094 ±141%  numa-meminfo.node0.Shmem
    556497 ±  8%     -33.2%     371757 ± 40%  numa-meminfo.node1.Mapped
     60668 ± 45%     -52.7%      28716 ± 83%  numa-meminfo.node1.PageTables
    267338 ± 13%     -23.1%     205462 ± 21%  numa-meminfo.node1.Slab
      2008 ±  5%    +117.7%       4372 ± 35%  proc-vmstat.nr_active_anon
    173611 ±  5%      -9.6%     157026 ±  3%  proc-vmstat.nr_mapped
      2008 ±  5%    +117.7%       4372 ± 35%  proc-vmstat.nr_zone_active_anon
 1.243e+08            -1.8%  1.221e+08        proc-vmstat.numa_hit
 1.242e+08            -1.8%   1.22e+08        proc-vmstat.numa_local
    427.50 ± 26%    +428.8%       2260 ± 15%  proc-vmstat.pgactivate
 1.244e+08            -1.8%  1.222e+08        proc-vmstat.pgalloc_normal
 1.227e+08            -2.0%  1.202e+08        proc-vmstat.pgfree
    550400            +3.7%     571008        proc-vmstat.unevictable_pgs_scanned
      7.27 ± 68%      -4.8        2.42 ±161%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      7.27 ± 68%      -4.8        2.42 ±161%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.65 ± 77%      -4.2        2.42 ±161%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      6.65 ± 77%      -4.2        2.42 ±161%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      5.03 ±100%      -4.1        0.93 ±223%  perf-profile.calltrace.cycles-pp.number.vsnprintf.seq_printf.show_interrupts.seq_read_iter
      2.08 ±223%     +11.2       13.29 ± 53%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      2.78 ±223%     +12.6       15.36 ± 54%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      2.08 ±223%     +13.3       15.36 ± 54%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      7.27 ± 68%      -4.8        2.42 ±161%  perf-profile.children.cycles-pp.seq_read
      6.01 ± 75%      -4.4        1.59 ±144%  perf-profile.children.cycles-pp.number
      6.65 ± 77%      -4.2        2.42 ±161%  perf-profile.children.cycles-pp.proc_single_show
      6.65 ± 77%      -4.2        2.42 ±161%  perf-profile.children.cycles-pp.proc_pid_status
      2.08 ±223%     +11.2       13.29 ± 53%  perf-profile.children.cycles-pp.perf_session__deliver_event
      2.78 ±223%     +12.6       15.36 ± 54%  perf-profile.children.cycles-pp.perf_session__process_user_event
      2.78 ±223%     +12.6       15.36 ± 54%  perf-profile.children.cycles-pp.__ordered_events__flush
      6.01 ± 75%      -4.4        1.59 ±144%  perf-profile.self.cycles-pp.number
      0.39            +0.0        0.42        perf-stat.i.branch-miss-rate%
 1.983e+08            +5.2%  2.085e+08        perf-stat.i.branch-misses
   9200253           +10.1%   10127041        perf-stat.i.context-switches
    554899            +5.3%     584042        perf-stat.i.cpu-migrations
      0.04            +0.0        0.05        perf-stat.i.dTLB-load-miss-rate%
  33430860           +10.3%   36871351        perf-stat.i.dTLB-load-misses
      0.85            -0.9%       0.84        perf-stat.i.ipc
      9.94 ± 16%     -26.2%       7.34 ± 24%  perf-stat.i.major-faults
   4603385 ±  3%      +6.8%    4916292 ±  3%  perf-stat.i.node-stores
      0.39            +0.0        0.41        perf-stat.overall.branch-miss-rate%
      0.04            +0.0        0.05        perf-stat.overall.dTLB-load-miss-rate%
 1.947e+08            +5.3%  2.051e+08        perf-stat.ps.branch-misses
   9028654           +10.2%    9953106        perf-stat.ps.context-switches
    543976            +5.4%     573599        perf-stat.ps.cpu-migrations
  32914153           +10.4%   36349710        perf-stat.ps.dTLB-load-misses
   4512147 ±  3%      +7.0%    4827523 ±  3%  perf-stat.ps.node-stores
 1.588e+13            +3.3%   1.64e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

