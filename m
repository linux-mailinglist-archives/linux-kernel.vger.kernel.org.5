Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E47F6A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjKXBo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:44:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94FD6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700790299; x=1732326299;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Zws5Zzhqtp992orAerzFaw6zNA15Ilq2OcCWEinoKPI=;
  b=PKNu64yXjn+CIGuoV+hC8HS0LzmcZ3AZMBd2tLODHrkb0l2Hcl78GWXF
   /eduBaEdCbdpIJw+dbsTk+JB3or34avjryH3OYjLoY9U5mp5MGXD4qdf8
   mnUN1iuBx2KyXx/+JyRSnrxgqb5h9NgMITTnpYNsAmI4T6VaY3T6gloAi
   pTAMM/5lUpuBKunOr5QTlSvqDQx6v002ww7fzW/hStwq2GLcRnRiEBXCA
   hbp9cqVLT+5l/MdbFKswIw9gT1Ntgq08ncRO4+kG8dwV6nj6PsAGICwSH
   fRT8SAm37uv3yUbLmr4cCWLHH4lWIsuFPraA2D19PBG20G6IczuIARrOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="392115731"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="392115731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 17:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796451752"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="796451752"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 17:44:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 17:44:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 17:44:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 17:44:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 17:44:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEEP9vQqW7/fNE0z9ndSyPK5lQVzFyJ01S3dDmfsZwq9bW3HonFFReUqOzG9azyYMA2i9LGXGci41hlz9wxKZG7/R1CUGRpIJX5vU1r8CTztYCIPoAJtBuKH7m8hZUN8ZXSrXuONaJYA6Q7diEZwfowkvfBqMW1MnwVMMFIbzFlCWj+Uq27dnpUl86BthG3M0OY9BW/NIwLvZtji99nwD0IacsFZRJ4zoOfSJooVwdNL0+CjS96VVRvxzFHLRflG2bprHGUHnjE0hItdyu4P1YddkL8o0b5b7+kNiR6XCtbdTfPSoPXsbyJBYqMlZjs0XbBlLZe8JONwsRcbJakkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlVrjYJ4AcSQR+3JcRcY8JQRGrG6R+4nDdXrNEScLjw=;
 b=MxlpX1wUeeMAjHh/MLih6JQ2GgOn6YrFZxhbdj0piOy5X/bM4L1gW0NGuRTHqNTadQdk9p7w0E9qZcuqGu7Migav/Vhh7Dbe//6M8B4NxKYDTPr9QL8oa2WoYDaaVR19MpB1ei+33RN4v0dFzmqOtqq50N364BNf+wzoVhFIzfY5UM6auIQHjXH6e0gtFdulIYInDrDFfhFtcZh/TdmRHdae90seIg2gjF+Dfz+sKDhJUJtZnOlN83s/bNsKqJ0CNauYZ92N6Vfb+NeDnp0CcIlVZC1EPFNthdrOOYXo7QF3qpTU55qDMkJ0k9xoixj0g+1vC/rCK6koG0wpPFad9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB8023.namprd11.prod.outlook.com (2603:10b6:806:2ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 01:44:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Fri, 24 Nov 2023
 01:44:53 +0000
Date:   Fri, 24 Nov 2023 09:44:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/numa]  84db47ca71:
 autonuma-benchmark.numa01_THREAD_ALLOC.seconds -46.2% improvement
Message-ID: <202311231611.59bca875-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: OS7PR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:604:254::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc0816c-f100-4bb3-f8f8-08dbec8ef44d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OncFzHOTNxWOf4gDfY+sZkrEZG8016t2qxiouxTI+6WbaBYeGTrMr1VeNaNPVcJcj/yEE84uqu+xuAqL1/azbdrgGP2wJe1FzrJFnQeCvVAGzxJrBbv/xHb0+MUHS9VpTrRReuvlsC+/cus4oOOzyNFjXx0g8XahgoBKMD/F+tig+6L2YN67TfX0hFh+aF0zDcwEmaiDjUBW9moyrNld9fM9P2e3bKCHE9TvCh4H/q+aBk8EE4xd1pJeaqPeRmISja0X20ABPmDqAfKXNCFa0kqEaHmvSMBHnHbVWyfkWwg3Hek16WysF88d39uA+/mAVRUt497GqKsOVg/6+bc9qlCvK4q8Qp9Xdy0OtoV8HvKlrVaABoBl8gwG97QFurwX7fgUmU4jiwAvT/wU1pwvJsj1wUQ7XULSDf0PHIVHWi1AmEN3HGHjWCU8uHWFtlS4OlMHlnbiNKjfKFuDzTWFc22K/jx1IiqGHY5Zx49AApM1WddW2qRWtBNoL50r0xGTSHMtaRb1S7T0s2C5aCYFJtfArkA2NIMYQW3X3GlCLOhM7B/6l+9Z543opHz1oHYQvEJ3UP8wW6vD8yYdoWVQxOXR8Y17GcbDsNhuAnTVXlsq3LYxlF8ZOG4FPGbT09S8hHt3Itpt6VENMQlCQhnrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230473577357003)(230373577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(66556008)(66476007)(54906003)(38100700002)(82960400001)(36756003)(86362001)(478600001)(1076003)(83380400001)(2616005)(6512007)(6666004)(6506007)(6486002)(2906002)(30864003)(5660300002)(6916009)(316002)(966005)(8676002)(26005)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KMovmhuvMZpgFIHFtc3/KqUzZc1YeoKb2+AK2OocmAqLlSvBTw4MIDoI9p?=
 =?iso-8859-1?Q?Y9V9AjtdVLXZc3bBGiTPiJrNpJ5gu4SSprMB+eI5M++/5X6V2K8IPW7ET6?=
 =?iso-8859-1?Q?j4iAoydQZRrXOn+IkMH15Xyr2MbI8wTzKc6ov4yKs0e5ufUe0Ov2pv90Qt?=
 =?iso-8859-1?Q?+3SbRpP28Bkgi5H1m1Q9PhqCHfDKmOyCvcvlx52spOck+zJbU/5Kax+IFM?=
 =?iso-8859-1?Q?O0ZsXuIrtI6laQPkzvK/yFwTHvQe3JqBLK1hkYAbGgrnZP0p1ae49OLe7A?=
 =?iso-8859-1?Q?zELGnUeRHHeEOTsyMzaRSWn+LO4eFcIKf5W5wx1tEj0zvc5UzVwtjeJ1eO?=
 =?iso-8859-1?Q?W/lxbB4ETKdOIRQIcJ2x/ct17fAZ6n5DPmc1rLgMweJKn9D2zv+G2hLPyj?=
 =?iso-8859-1?Q?a7DhVpwRTU5QkdPVUw2uecfQe/sXcxVP221l01AR4QShGQgPYOfCXwOBJP?=
 =?iso-8859-1?Q?NK9dlnw+FD5Hv/XHRNWAhB7YggZdIUL6NtY2Ih0Bq5d5vPbteMlaxN4Ji8?=
 =?iso-8859-1?Q?xxiF9jDbmdv7xi6go6gK6Tk6PSgYknyRDPvZo1TBF+PvV16KekQglM5eNe?=
 =?iso-8859-1?Q?GW+ufq7nYfeXVq5Ny55adogsT9Kinanq7UhMFY34lWbdrGgoOR8O4w64+i?=
 =?iso-8859-1?Q?6XuHztQmQvihVN8FxFbkwsBipqzEYMJNw41zkY5Tzy0xR3OznH2NMdeEJk?=
 =?iso-8859-1?Q?F4hkB9y5K9pSzOSMts7MeYU9bnB/lcmaoModxB5DHZCPrTC4Btt7ALvPkF?=
 =?iso-8859-1?Q?z/K/TDVj1x8v+RiKrSHXZMiDjo+6hUoLEvzrOa7zAEldk1HwbAWlXrKqiT?=
 =?iso-8859-1?Q?e5+sbWmcc/QigTYcH6OgXlX8zw3Z5I2yknzOUp+nJi3NmV5BB1iVYfp1zO?=
 =?iso-8859-1?Q?t/jFRZ10U2mGuagJ7yH/OgtTK03C4Ug3gyZlE/KJbCqg2Lk85BSqP2Z31o?=
 =?iso-8859-1?Q?0+Z4uH4YVb/I64+OWdR+O6ABW8ARpLzYreRoWEp+tso0sZYWM2LoC/ncFk?=
 =?iso-8859-1?Q?VjQZDEnS6FQBK0+i4DRukFcXKq4pHurBQOiBgDAMCzHyLWUxwV0RpZnxup?=
 =?iso-8859-1?Q?5Jsp6MhskIjtXiuPdrmHIRO66Yr/pF2KMhMIj9k4VOA4FiSblCZeOn/GcY?=
 =?iso-8859-1?Q?6oVYVKdZTcgApYrP3yxYWpBJjG89RrZctbAxNOZ69Z1EXTU2UOaQTrNxqi?=
 =?iso-8859-1?Q?/lwcUFSA8dTCPO6z3qGsf6rCOJZCN5Js25YIuKZ8fvAIqY69360NLnO8aA?=
 =?iso-8859-1?Q?7bNDPH2E/cPUChMbI4Eh6cmkvy0RkPkihqgfLlr/YBKtkSQUZF9mnswFHQ?=
 =?iso-8859-1?Q?y2BN64CCS9Y/sP/RMO3hE/qX7AhYRzPTkV2YmNwAyFbB7ETg9xl2qwsL4E?=
 =?iso-8859-1?Q?AbOzhoQ8nPSUc+uAlSWhwhed+O5c6OaIRihy++LLvmOAAUszy5+xP15gE3?=
 =?iso-8859-1?Q?++McUuXNChIDjBtxtdTOvka5FZrLBh2HyY+0MUcxkN/YG2mY+WeuVXl9Qc?=
 =?iso-8859-1?Q?o1w71TpnyABWJPZZEGhBmd5Bz0sOXFAtD1OXuY5a9lbfdP/KxOZAAitdKh?=
 =?iso-8859-1?Q?qzAZXpKqC4bnJO3Z1iI/ta6bcJF2i45QsloxKX9RiXR3X9WLPI/EO4hCiG?=
 =?iso-8859-1?Q?hNzCh32+Fg/GMxtXCKAZNwhNm7687uCjhcOQecKcDs+puvSDCt36cILw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc0816c-f100-4bb3-f8f8-08dbec8ef44d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:44:53.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgAAlELSmvbPJijbMY26Dola0rLrLsKrGdlUrls5TNDUyaG/I696DB8WiRg717bbt5gRlKlkZA5Y7JNMhDF63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -46.2% improvement of autonuma-benchmark.numa01_THREAD_ALLOC.seconds on:


commit: 84db47ca7146d7bd00eb5cf2b93989a971c84650 ("sched/numa: Fix mm numa_scan_seq based unconditional scan")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: autonuma-benchmark
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	iterations: 4x
	test: numa01_THREAD_ALLOC
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231123/202311231611.59bca875-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark

commit: 
  d6111cf45c ("sched: Use WRITE_ONCE() for p->on_rq")
  84db47ca71 ("sched/numa: Fix mm numa_scan_seq based unconditional scan")

d6111cf45c578728 84db47ca7146d7bd00eb5cf2b93 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1424           -21.6%       1117 ±  2%  uptime.boot
      0.02 ± 38%    +139.7%       0.05 ± 20%  vmstat.procs.b
      0.01 ± 15%      +0.0        0.01 ±  9%  mpstat.cpu.all.iowait%
      0.09 ±  2%      -0.0        0.07 ±  2%  mpstat.cpu.all.soft%
      1.84            +0.4        2.24 ±  4%  mpstat.cpu.all.sys%
      9497 ± 17%     +37.1%      13024 ± 10%  turbostat.C1
 3.161e+08           -20.8%  2.503e+08 ±  2%  turbostat.IRQ
      8.86 ±  8%      -1.7        7.16 ± 14%  turbostat.PKG_%
    646.52            +2.9%     665.41        turbostat.PkgWatt
     52.74           +32.6%      69.93        turbostat.RAMWatt
    258.20           -16.3%     216.21 ±  2%  autonuma-benchmark.numa01.seconds
     78.26           -46.2%      42.10 ±  5%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
      1381           -22.6%       1069 ±  2%  autonuma-benchmark.time.elapsed_time
      1381           -22.6%       1069 ±  2%  autonuma-benchmark.time.elapsed_time.max
   1090459 ±  2%     -23.1%     838693 ±  3%  autonuma-benchmark.time.involuntary_context_switches
    286141           -23.6%     218671 ±  2%  autonuma-benchmark.time.user_time
      0.00 ±223%  +23983.3%       0.24 ±110%  perf-sched.sch_delay.avg.ms.__cond_resched.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      0.01 ±223%  +1.3e+05%      15.11 ±179%  perf-sched.sch_delay.max.ms.__cond_resched.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      3.35 ± 31%     -70.7%       0.98 ±149%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    167.50 ± 32%     -69.8%      50.67 ±102%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      8.50 ± 39%     -80.4%       1.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.22 ±134%    +215.3%       3.83 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      1.60 ±136%   +2231.7%      37.39 ±156%  perf-sched.wait_time.max.ms.__cond_resched.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
   1578414            -1.4%    1556033        proc-vmstat.nr_anon_pages
     74441 ± 14%     +85.7%     138261 ±  6%  proc-vmstat.numa_hint_faults
     41582 ± 22%     +91.1%      79461 ±  9%  proc-vmstat.numa_hint_faults_local
     34327 ±  6%    +148.2%      85213 ±  2%  proc-vmstat.numa_huge_pte_updates
   5578006            -8.1%    5123719 ±  4%  proc-vmstat.numa_local
   4649420 ±  4%    +126.1%   10511526 ±  3%  proc-vmstat.numa_pages_migrated
  17706681 ±  6%    +147.2%   43778740 ±  2%  proc-vmstat.numa_pte_updates
   6749037           -10.7%    6027035        proc-vmstat.pgfault
   4649420 ±  4%    +126.1%   10511526 ±  3%  proc-vmstat.pgmigrate_success
    236153           -14.4%     202067 ±  3%  proc-vmstat.pgreuse
      9057 ±  4%    +126.3%      20497 ±  3%  proc-vmstat.thp_migration_success
  30217875 ±  2%     -20.4%   24043125        proc-vmstat.unevictable_pgs_scanned
     10.73 ±  5%    +125.3%      24.17 ± 17%  perf-stat.i.MPKI
 2.427e+08            +4.0%  2.523e+08        perf-stat.i.branch-instructions
     24.45            +3.2       27.63        perf-stat.i.cache-miss-rate%
  14364771 ±  5%    +122.0%   31896201 ± 18%  perf-stat.i.cache-misses
  37679065           +70.9%   64408862 ± 10%  perf-stat.i.cache-references
    545.38            -2.9%     529.43        perf-stat.i.cpi
    221.07            +7.7%     238.10        perf-stat.i.cpu-migrations
    156883 ±  2%     -36.8%      99195        perf-stat.i.cycles-between-cache-misses
 3.331e+08            +3.3%  3.443e+08        perf-stat.i.dTLB-loads
   1031040            +2.6%    1057642        perf-stat.i.dTLB-store-misses
 1.877e+08            +3.5%  1.942e+08        perf-stat.i.dTLB-stores
  1.24e+09            +3.7%  1.286e+09        perf-stat.i.instructions
      0.00 ± 12%     +54.1%       0.00 ± 39%  perf-stat.i.ipc
      2.07           +12.9%       2.33 ±  2%  perf-stat.i.metric.M/sec
      5074 ±  2%     +12.7%       5718        perf-stat.i.minor-faults
     43.56 ±  2%      +4.0       47.59 ±  3%  perf-stat.i.node-load-miss-rate%
    519245 ±  3%     +57.1%     815750 ±  3%  perf-stat.i.node-load-misses
      5074 ±  2%     +12.7%       5718        perf-stat.i.page-faults
     10.68 ±  4%    +124.9%      24.01 ± 18%  perf-stat.overall.MPKI
     37.27 ±  5%     +11.6       48.91 ±  7%  perf-stat.overall.cache-miss-rate%
    504.52            -5.1%     479.03        perf-stat.overall.cpi
     47358 ±  4%     -56.6%      20561 ± 17%  perf-stat.overall.cycles-between-cache-misses
      0.00            +5.4%       0.00        perf-stat.overall.ipc
     42.32 ±  7%      +8.3       50.63 ±  6%  perf-stat.overall.node-load-miss-rate%
 2.384e+08            +4.2%  2.486e+08        perf-stat.ps.branch-instructions
  13020509 ±  5%    +133.4%   30395642 ± 17%  perf-stat.ps.cache-misses
  34948633 ±  2%     +76.6%   61721520 ±  9%  perf-stat.ps.cache-references
    218.01            +7.5%     234.41        perf-stat.ps.cpu-migrations
 3.285e+08            +3.6%  3.402e+08        perf-stat.ps.dTLB-loads
   1021092            +2.9%    1050584        perf-stat.ps.dTLB-store-misses
 1.845e+08            +3.7%  1.914e+08        perf-stat.ps.dTLB-stores
 1.219e+09            +3.9%  1.267e+09        perf-stat.ps.instructions
      4707           +14.8%       5406        perf-stat.ps.minor-faults
    502656 ±  3%     +63.9%     823962 ±  4%  perf-stat.ps.node-load-misses
      4707           +14.8%       5406        perf-stat.ps.page-faults
 1.686e+12           -19.1%  1.363e+12 ±  2%  perf-stat.total.instructions
 1.824e+08 ±  2%     -27.1%   1.33e+08 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
 1.869e+08 ±  2%     -26.9%  1.366e+08 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
 1.498e+08 ±  6%     -27.4%  1.087e+08 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
   3892383 ±  9%     -20.8%    3081639 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.81 ±  5%     -11.7%       0.72 ±  6%  sched_debug.cfs_rq:/.h_nr_running.min
      4130 ±  3%     +33.5%       5516 ± 14%  sched_debug.cfs_rq:/.load_avg.max
 1.824e+08 ±  2%     -27.1%   1.33e+08 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.869e+08 ±  2%     -26.9%  1.366e+08 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
 1.498e+08 ±  6%     -27.4%  1.087e+08 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
   3892382 ±  9%     -20.8%    3081638 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.81 ±  5%     -11.7%       0.72 ±  6%  sched_debug.cfs_rq:/.nr_running.min
     25.69 ± 11%     +33.1%      34.20 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.max
    804.13 ±  6%     -13.2%     697.93 ±  5%  sched_debug.cfs_rq:/.runnable_avg.min
    642.08 ±  7%     -18.7%     522.15 ±  5%  sched_debug.cfs_rq:/.util_avg.min
     30.15 ± 67%   +1148.5%     376.47 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    490.48 ± 19%    +140.0%       1177 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
     77.81 ± 47%    +298.2%     309.83 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    840536 ±  3%     -29.6%     592026 ±  6%  sched_debug.cpu.avg_idle.min
    516622 ±  5%     -16.1%     433228 ±  3%  sched_debug.cpu.avg_idle.stddev
    713848 ±  2%     -24.3%     540516 ±  4%  sched_debug.cpu.clock.avg
    715060 ±  2%     -24.3%     541264 ±  4%  sched_debug.cpu.clock.max
    712575 ±  2%     -24.3%     539699 ±  4%  sched_debug.cpu.clock.min
    714.85 ±  8%     -38.1%     442.30 ± 10%  sched_debug.cpu.clock.stddev
    705718 ±  2%     -24.3%     534516 ±  4%  sched_debug.cpu.clock_task.avg
    708387 ±  2%     -24.3%     536010 ±  4%  sched_debug.cpu.clock_task.max
    686460 ±  2%     -24.5%     518080 ±  4%  sched_debug.cpu.clock_task.min
      2041 ± 12%     -32.5%       1377 ±  7%  sched_debug.cpu.clock_task.stddev
     23332 ±  3%     -20.1%      18646 ±  5%  sched_debug.cpu.curr->pid.avg
     26909           -15.7%      22694 ±  2%  sched_debug.cpu.curr->pid.max
     16993 ± 13%     -33.7%      11263 ± 21%  sched_debug.cpu.curr->pid.min
   1393930 ±  3%     -14.1%    1197373 ±  3%  sched_debug.cpu.max_idle_balance_cost.max
    154458 ±  5%     -12.8%     134638 ±  3%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  7%     -37.3%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.82 ±  6%     -12.6%       0.72 ±  9%  sched_debug.cpu.nr_running.min
      7472 ±  2%     -19.9%       5982 ±  3%  sched_debug.cpu.nr_switches.avg
      2879 ±  6%     -15.1%       2445 ±  7%  sched_debug.cpu.nr_switches.min
      5925 ±  5%     -14.3%       5080 ±  4%  sched_debug.cpu.nr_switches.stddev
      6.07 ±  9%     +39.6%       8.48 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
    712557 ±  2%     -24.3%     539685 ±  4%  sched_debug.cpu_clk
    711344 ±  2%     -24.3%     538474 ±  4%  sched_debug.ktime
      0.15 ± 78%    +111.4%       0.31 ± 33%  sched_debug.rt_rq:.rt_time.avg
     32.86 ± 78%    +111.4%      69.47 ± 33%  sched_debug.rt_rq:.rt_time.max
      2.19 ± 78%    +111.4%       4.63 ± 33%  sched_debug.rt_rq:.rt_time.stddev
    713438 ±  2%     -24.2%     540572 ±  4%  sched_debug.sched_clk
      3.34 ± 33%      -1.5        1.81 ± 18%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.45 ± 39%      -1.1        0.36 ±101%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.45 ± 39%      -1.1        0.36 ±101%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.37 ± 38%      -1.0        0.34 ±101%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      3.04 ± 32%      -1.4        1.60 ± 18%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.78 ± 29%      -1.3        1.44 ± 17%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.37 ± 28%      -1.2        1.16 ± 23%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.95 ± 28%      -1.0        0.97 ± 13%  perf-profile.children.cycles-pp.task_mm_cid_work
      2.17 ± 29%      -1.0        1.19 ± 16%  perf-profile.children.cycles-pp.task_work_run
      0.69 ± 30%      -0.3        0.38 ± 49%  perf-profile.children.cycles-pp.khugepaged
      0.67 ± 31%      -0.3        0.37 ± 49%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.67 ± 31%      -0.3        0.37 ± 49%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.38 ± 27%      -0.1        0.26 ± 23%  perf-profile.children.cycles-pp.security_file_permission
      0.34 ± 27%      -0.1        0.23 ± 23%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.26 ± 48%      -0.1        0.15 ± 19%  perf-profile.children.cycles-pp.dup_task_struct
      0.24 ± 35%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.11 ± 51%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.14 ± 33%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10 ± 32%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.move_page_tables
      0.02 ±142%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±223%      +0.1        0.13 ± 56%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.04 ±113%      +0.2        0.20 ± 48%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.00            +0.2        0.16 ± 56%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.04 ±107%      +0.2        0.25 ± 42%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ± 79%      +0.2        0.38 ± 40%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.18 ± 80%      +0.2        0.38 ± 40%  perf-profile.children.cycles-pp.kernel_wait4
      0.17 ± 76%      +0.2        0.38 ± 40%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.3        0.26 ± 77%  perf-profile.children.cycles-pp.intel_idle
      0.06 ±104%      +0.3        0.32 ± 44%  perf-profile.children.cycles-pp.update_process_times
      0.06 ±106%      +0.3        0.33 ± 46%  perf-profile.children.cycles-pp.tick_sched_handle
      0.07 ± 81%      +0.3        0.36 ± 48%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.18 ± 54%      +0.4        0.62 ± 48%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ± 50%      +0.6        0.76 ± 47%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ± 51%      +0.6        0.79 ± 46%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.68 ± 44%      +1.1        1.80 ± 60%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.46 ± 52%      +1.2        2.62 ± 45%  perf-profile.children.cycles-pp.__schedule
      0.72 ± 46%      +1.2        1.89 ± 60%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.72 ± 46%      +1.2        1.89 ± 60%  perf-profile.children.cycles-pp.find_busiest_group
      0.03 ±141%      +1.3        1.31 ± 75%  perf-profile.children.cycles-pp.start_secondary
      0.01 ±223%      +1.3        1.36 ± 80%  perf-profile.children.cycles-pp.cpuidle_enter
      0.01 ±223%      +1.3        1.36 ± 80%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.77 ± 44%      +1.4        2.15 ± 62%  perf-profile.children.cycles-pp.load_balance
      0.20 ± 61%      +1.4        1.64 ± 77%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.02 ±142%      +1.5        1.50 ± 80%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.04 ±146%      +1.6        1.62 ± 80%  perf-profile.children.cycles-pp.newidle_balance
      0.03 ±141%      +1.6        1.66 ± 79%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.03 ±141%      +1.6        1.66 ± 79%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.03 ±141%      +1.6        1.66 ± 79%  perf-profile.children.cycles-pp.do_idle
      1.94 ± 28%      -1.0        0.95 ± 13%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.13 ± 31%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.3        0.26 ± 77%  perf-profile.self.cycles-pp.intel_idle
      0.67 ± 44%      +1.1        1.76 ± 60%  perf-profile.self.cycles-pp.update_sg_lb_stats




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

