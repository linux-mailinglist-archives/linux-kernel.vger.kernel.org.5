Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03EE78D327
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjH3GK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbjH3GKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:10:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B31ECCB;
        Tue, 29 Aug 2023 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693375829; x=1724911829;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1gDJvDfxk26pgVTnZEZiJf3nZqnOsWKJRpTNHaqh8DU=;
  b=WFVeHDSsPWjm8M2vRxOZssPYPFf6l/c6I1Lw5AwybxrPgDh8eVXKJ53r
   8koSkKvU0FPt8CEbc4a7ULksQvH0Snwihkj1uxylql9BJjzjMOmrYD0EU
   YkoR6VbvJoneNYP+1kVAREunFz9hfmHxykUOgWN37cCJXa+jyLBMxoMUc
   2qNvmYEyqlUGKdIceQy71iAXlJ5U5EQsQoS+ADvV1f8TjO7A8HWR5qFy6
   rl+kuk6NRLVLHd0Ioh2WAWKeY/xJp0csBeL6QgLX/D3NVe2IUBQKLwve5
   FJYmh6UeywNwtRQQ7NIx+EEM5vUUVhWuk2e2157TuZYVV7cjuri64VKto
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374463814"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="374463814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 23:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="742112451"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="742112451"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 23:10:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 23:10:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 23:10:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 23:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0kGZgTZWrmSnQ/+yPSPPHhSlgN+lz0uVPAwK8OhLtd/JcnhEb9BMUGTV9R/WeaiDijcWQWit7r8opQ8/pywVPEHMoVOk05tlFeEQw+k5ztBMnmLXoMoPwOMKAE6ow2XmO865Fc88pCfvdOUPydF59/pXOeJ/h90QqwSJs8RHNl+YQZUqZNow2AqfkDOGvbxyT/dlTuWuQhm5OynQxtahIacK7M1WmdWrlJffxFPGG/d9YW4wFlPDavXhRsbW8nnj5skQbVi0TIR0gmOX8aAhan1PxVESe1dOBopfe1j3KlED1/BHd2wp75GYU8fKk+LRfR5cheEclvUVV1Eto3eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFt3BbsIf8tAm+lGyQ3yZApRoC4VUAtVWlbaPsGUGJQ=;
 b=kCjyTi+ojUovQgxJkzgwGu9kf3jGz9/92a6fvNmf9KpHCxIflnm0RykM3v6nxeRAhpHCt0UveC6Tiy44n2yZHHUjClhvstjjyBjyUMP3R+s0IBc+n9bjpgB/o7P5MmmAYpzLf6FlebTe/QKkU6bPj2eFGytZaEVId3KfFjgXgOXVwMDNxKgqVh5rknfqA3iz1Hd8HrfuPT6XdvvBi3VQC9OrrcjC5C1pvNd/6Rscs4ARt1Nj8j1EQ/US+oOfOTMyKuOSQjnIjqUSbaWAQ3UeAKXlaCnZpcwzTcVbK5POLMslOhbsZRFGOds5JJ1CVkZPfhuqij7s5gi5z5Dm/mBaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 06:10:00 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 06:10:00 +0000
Date:   Wed, 30 Aug 2023 14:09:51 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <netdev@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sock]  2d0c88e84e:  netperf.Throughput_Mbps 2.2%
 improvement
Message-ID: <202308301323.1332523-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de47d9b-8e04-4f50-a249-08dba91fbe54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: touLrggsRueSrxxHtsWPByQOf7YCY+qDuNg/EBycseaybHkNPv2J2t3bFPZSHhoIUzgdrki1OCj2nEGJ9gfHpw08jVygy56861Do6SkuPepOnb5RARBJEbrJCajrfApwDOizaPmPlMM54p2M1lLYBJUFyRsQ0c90+4kS8e3lmw+ENOHUPUQLYj1No3XzxYNhtUBqKmwkBq3NVm22krd4MQDISext4MeAyujGVAf1KTurfgLxQ6397IjocQ9x/F332PiTePSJOJqIizcSeorAWLpb9FJ7GBqEBqG3g3PDirAGJ2wLrC8I4A2p334A0d5HiITJ5PMUJtLzsRTO7m2CMC/iXeEFjYJBGthslOPJV5yV/KN4KH7zc6t7sOiMDwOSuMKNPuccH84BifrV4ju2fiaSZrSTLFy2FptlTiVIIyvx8XJC2xeqmm0AIb5IIPHow5PLLF6Nkq+RpHh72ABD6EdVHfcCD1sff/3PSlbYt9MF29q2/+40m1dj3OU6+UrJ5tWapBbyHKPIPRvr0qZcUUejaXyKad8bD8VwKZqd9V9Pkp58T7LFNX/Hf6qNCsaGezMDP5/rzm0mFJx2dKvTUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(186009)(451199024)(1800799009)(6512007)(6666004)(6506007)(6486002)(2616005)(1076003)(107886003)(30864003)(38100700002)(2906002)(82960400001)(8676002)(66946007)(86362001)(4326008)(66556008)(66476007)(54906003)(5660300002)(41300700001)(36756003)(6916009)(316002)(8936002)(83380400001)(478600001)(966005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0/nX00pqlKxDUcWr6IiGAKt3Me+asmuy1q9PMtgPM6ocjOKRL+bpoUaLd4?=
 =?iso-8859-1?Q?EIxY6W04xV9BjOySB7TIwFcM4Z9SVuzz/AwDcUTW1uN5Maf89CZV5xIC8F?=
 =?iso-8859-1?Q?5vgFKiHLLFaR3tWrHbak8G+TJVSnrGCx6TV5Z2ePdEuKqogHprbkl6hMgn?=
 =?iso-8859-1?Q?5+tRf/Xge1Xa12ouq7N9Tx6H10Wm+zD5dJTpgpxz51EsnK7/Kb+W/bWFK8?=
 =?iso-8859-1?Q?OJr94EYzOccSFQpsSLRhMyG1ES7SKKU4i6Abgyyn5ClIVqRNYWDKOdUuEW?=
 =?iso-8859-1?Q?dzUyyvQCPoiCLAfu2ZEgrvR2oalo88lZM4rTsoK0urSuRBkHoRmgIOefAN?=
 =?iso-8859-1?Q?k6bULH26O8KsUwFJG/sZZ6da60PGGVFECLiMyyE1lnXoI9MiVCGWrhqCnF?=
 =?iso-8859-1?Q?Myx1mgTMBLqdw1QFFNW2/3+v9tT+1CLRBSJx+waEBzZeJ4zoRo3HWGt+m3?=
 =?iso-8859-1?Q?N6+5cEXm+99m9ceTwg5XB/l8IhWphTNJuRcM4t2ruue12RsugbGMlXeMWc?=
 =?iso-8859-1?Q?szWYermjxHR9hnrKtWdqHHxuQoCgzy6CXiVXuKHfH/BdZ3wfRuovUJpr1e?=
 =?iso-8859-1?Q?sQM8M2wkRV/40ovEsRnweui5ftUY5yooGQ0JIYUnKpAHprUKL0upwgzKsW?=
 =?iso-8859-1?Q?tp3q41cipt/jq7j3GIbZMGUt4cp0RRlwjwViQ1mH5MH6PsRJ5Qz6Z+QjXW?=
 =?iso-8859-1?Q?OCGzeLB9JzzXLA4bsL1a7RPPzzys9bjeqQ2j5+PR+JaUU6u4kbtd9DIK2L?=
 =?iso-8859-1?Q?ugZhzdJPP3af9i5HceOtzf/xQWztz0n+KjVXmQqu/zNrzYehmMmFdK2mAZ?=
 =?iso-8859-1?Q?p+Y49deAJ06eC/YlBHfKdDU43kTY4whO/x+9UOqFkq+GVkVtec6U1s1bWH?=
 =?iso-8859-1?Q?Y/OVHZ+zcv6ZBcIXKIzZXulRZO+ivmmC+6H8aHbv9lKv6QJfRaX6X8eZiy?=
 =?iso-8859-1?Q?GmDyvkm5EZ7uqzyAq8Vetnk6UssOENflLuHNuKTLHjWCFsQp3XbFihcmtp?=
 =?iso-8859-1?Q?oheYLfqfMcFTGlKZ/15mPTL3T5ltZJqqFFzx5r0mgYElvGQkzJWq3E5Sb6?=
 =?iso-8859-1?Q?6J0DnGq35fdHW3PRDXmkf+kqd4cidoGRXNi8wOMB3B3LylmYrx7xsY8qV6?=
 =?iso-8859-1?Q?LO4m0lJhvcilHz+O9zxIBVvT4B338IUsOJSAEoGJcxPZ/BV7bazf8XrKjg?=
 =?iso-8859-1?Q?nJMqMefjqCX7VQqqH2NkHEAsnU3/UyUmrAqvIJC/p0J6gu9o8GBieiddsz?=
 =?iso-8859-1?Q?Y+bSjXPV5tQk78XEcOCvi6k+xNFK/Mas1BVOm+5kG4CkNxmVKDpJCS2CAk?=
 =?iso-8859-1?Q?BMXjFtPOT1GCYbMIIcct8uNPT0ARI+LyGKqkd+G5gLOTsoSE42xxtG00EH?=
 =?iso-8859-1?Q?JkhzDS7jNOakzpydOMx8FX/E2YTbpywUDYKYwPQR1iQ+LRuoZuNtNADzJo?=
 =?iso-8859-1?Q?3sWXcJIo9w2bTwyoPNXfQmYUJuxPOdaX+zsi3TDBX6wHqknE7RaDsGoAfl?=
 =?iso-8859-1?Q?C7VtqIPypf/9zGxtWyul+q7lsKyISaiCv8tJhsSw+fKL5kdhX6PfZwKwXX?=
 =?iso-8859-1?Q?wVvhBfkWpQjaokrBcEMiaWETgYAcX+GHAE8pcICdDiR9yW6fzjLxoXkmQX?=
 =?iso-8859-1?Q?nlLbpwvbEcEWgF0cIIg9e/3Tm/jFa9DfpMKjHDDgszdWP51i0B0oD6zA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de47d9b-8e04-4f50-a249-08dba91fbe54
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:10:00.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cii57RRzEkN4JJYSJwuoe5KnXnOTlCOS1EUcIMlJ9kqL8i6r1R/wd9e23Aan58Vp05T636BOcXZuUJ9cxI55Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 2.2% improvement of netperf.Throughput_Mbps on:


commit: 2d0c88e84e483982067a82073f6125490ddf3614 ("sock: Fix misuse of sk_under_memory_pressure()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	send_size: 10K
	test: TCP_SENDFILE
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230830/202308301323.1332523-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/50%/debian-11.1-x86_64-20220510.cgz/300s/10K/lkp-icl-2sp2/TCP_SENDFILE/netperf

commit: 
  54c9016eb8 ("sfc: don't fail probe if MAE/TC setup fails")
  2d0c88e84e ("sock: Fix misuse of sk_under_memory_pressure()")

54c9016eb8eda559 2d0c88e84e483982067a82073f6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    892258 ± 16%     -61.2%     346254 ± 38%  numa-meminfo.node1.Active
    892221 ± 16%     -61.4%     344819 ± 39%  numa-meminfo.node1.Active(anon)
    223700 ± 16%     -61.6%      85846 ± 39%  numa-vmstat.node1.nr_active_anon
    223700 ± 16%     -61.6%      85846 ± 39%  numa-vmstat.node1.nr_zone_active_anon
     27465            +2.2%      28081        netperf.Throughput_Mbps
   1757760            +2.2%    1797196        netperf.Throughput_total_Mbps
     78391 ±  2%     +14.4%      89652 ±  4%  netperf.time.voluntary_context_switches
 6.437e+09            +2.2%  6.582e+09        netperf.workload
   1011236 ± 28%     -57.1%     434012 ± 41%  meminfo.Active
   1011108 ± 28%     -57.2%     432521 ± 42%  meminfo.Active(anon)
   6406163 ±  7%     +15.2%    7379966 ±  3%  meminfo.Inactive
   6405999 ±  7%     +15.2%    7376785 ±  3%  meminfo.Inactive(anon)
   3673390 ±  7%     +14.6%    4210959 ±  4%  meminfo.Mapped
    252277 ± 27%     -56.9%     108759 ± 42%  proc-vmstat.nr_active_anon
   1601826 ±  7%     +15.1%    1843736 ±  3%  proc-vmstat.nr_inactive_anon
    918472 ±  7%     +14.6%    1052398 ±  4%  proc-vmstat.nr_mapped
      4176 ±  3%      +6.7%       4456 ±  2%  proc-vmstat.nr_page_table_pages
    252277 ± 27%     -56.9%     108759 ± 42%  proc-vmstat.nr_zone_active_anon
   1601826 ±  7%     +15.1%    1843736 ±  3%  proc-vmstat.nr_zone_inactive_anon
      0.02 ±  7%     -15.6%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.02 ± 15%     +47.2%       0.03 ± 24%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ±  7%     -13.5%       0.04 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    324.50 ±  4%     +10.6%     359.00 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      2688 ± 33%     -31.3%       1848 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    722.90 ± 18%     -19.2%     584.08 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ±  7%     -12.0%       0.02 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    240.85 ± 14%     -23.2%     185.01 ±  9%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      6.86            -5.2%       6.51        perf-stat.i.MPKI
  4.28e+10            +1.7%  4.353e+10        perf-stat.i.branch-instructions
      7.53 ±  3%      -1.4        6.18 ±  4%  perf-stat.i.cache-miss-rate%
 1.162e+08 ±  3%     -20.8%   91982369 ±  4%  perf-stat.i.cache-misses
 1.551e+09            -3.5%  1.496e+09        perf-stat.i.cache-references
      1.34            -1.5%       1.31        perf-stat.i.cpi
      2615 ±  3%     +27.2%       3327 ±  5%  perf-stat.i.cycles-between-cache-misses
  6.35e+10            +1.8%  6.462e+10        perf-stat.i.dTLB-loads
 3.488e+10            +1.9%  3.553e+10        perf-stat.i.dTLB-stores
 2.258e+11            +1.8%  2.299e+11        perf-stat.i.instructions
      0.75            +1.6%       0.76        perf-stat.i.ipc
      1115            +1.7%       1134        perf-stat.i.metric.M/sec
      6.87            -5.2%       6.51        perf-stat.overall.MPKI
      7.49 ±  3%      -1.3        6.15 ±  4%  perf-stat.overall.cache-miss-rate%
      1.34            -1.5%       1.32        perf-stat.overall.cpi
      2602 ±  3%     +26.7%       3296 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.75            +1.6%       0.76        perf-stat.overall.ipc
 4.266e+10            +1.7%  4.338e+10        perf-stat.ps.branch-instructions
 1.158e+08 ±  3%     -20.8%   91693008 ±  4%  perf-stat.ps.cache-misses
 1.546e+09            -3.5%  1.492e+09        perf-stat.ps.cache-references
 6.328e+10            +1.8%   6.44e+10        perf-stat.ps.dTLB-loads
 3.476e+10            +1.9%  3.541e+10        perf-stat.ps.dTLB-stores
 2.251e+11            +1.8%  2.291e+11        perf-stat.ps.instructions
 6.786e+13            +1.8%  6.907e+13        perf-stat.total.instructions
     31.66            -0.8       30.87        perf-profile.calltrace.cycles-pp.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct
     30.86            -0.8       30.07        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor
      3.30 ±  3%      -0.8        2.55        perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked
     35.03            -0.7       34.32        perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     34.84            -0.7       34.12        perf-profile.calltrace.cycles-pp.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
      5.10 ±  2%      -0.7        4.40        perf-profile.calltrace.cycles-pp.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      5.01 ±  2%      -0.7        4.32        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      4.93 ±  2%      -0.7        4.24        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg
      1.61 ±  8%      -0.7        0.94 ± 21%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
     18.00            -0.5       17.50        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      1.55 ±  2%      -0.4        1.14 ±  2%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     45.17            -0.4       44.77        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
     45.75            -0.4       45.36        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.86            -0.2       48.62        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      7.00            -0.2        6.78        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket
      7.51            -0.2        7.29        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      1.22 ±  5%      -0.2        1.01 ± 21%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      1.95            -0.2        1.78        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.36            -0.1        2.22        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.33 ±  2%      -0.1        1.19 ±  2%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      4.82            -0.1        4.67        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      1.17 ±  2%      -0.1        1.03 ±  2%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      4.81            -0.1        4.67        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
     11.79            -0.1       11.65        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     11.84            -0.1       11.70        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      1.43 ±  4%      -0.1        1.33 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      4.46            -0.1        4.37        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      4.84            -0.1        4.76        perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.tcp_sendmsg.sock_sendmsg.splice_to_socket
      4.97            -0.1        4.91        perf-profile.calltrace.cycles-pp.lock_sock_nested.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
      0.57            +0.0        0.59        perf-profile.calltrace.cycles-pp.__entry_text_start.sendfile.sendfile_tcp_stream.main.__libc_start_main
      0.94            +0.0        0.96        perf-profile.calltrace.cycles-pp.__fsnotify_parent.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.42            +0.0        1.45        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.50            +0.0        1.54        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      1.22            +0.0        1.26        perf-profile.calltrace.cycles-pp.iov_iter_extract_pages.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.60 ±  2%      +0.1        0.66        perf-profile.calltrace.cycles-pp.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.34            +0.1        4.40        perf-profile.calltrace.cycles-pp.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      2.36            +0.1        2.48        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.38            +0.1        2.50        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      7.46            +0.2        7.66        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      8.02            +0.2        8.24        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.88 ± 26%      +0.3        1.22        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_data_queue
      0.17 ±141%      +0.4        0.52        perf-profile.calltrace.cycles-pp.__fget_light.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.97            +0.4       13.34        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     13.06            +0.4       13.42        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      6.26 ±  3%      -1.0        5.24 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      3.25 ±  2%      -0.8        2.47 ±  3%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
     31.69            -0.7       30.98        perf-profile.children.cycles-pp.sock_sendmsg
      5.31 ±  2%      -0.7        4.60        perf-profile.children.cycles-pp.__sk_mem_schedule
     30.92            -0.7       30.21        perf-profile.children.cycles-pp.tcp_sendmsg
      5.23 ±  2%      -0.7        4.53        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      5.12 ±  2%      -0.7        4.44        perf-profile.children.cycles-pp.tcp_wmem_schedule
     35.05            -0.6       34.42        perf-profile.children.cycles-pp.direct_splice_actor
     34.98            -0.6       34.35        perf-profile.children.cycles-pp.splice_to_socket
     18.12            -0.5       17.65        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     45.21            -0.4       44.81        perf-profile.children.cycles-pp.splice_direct_to_actor
     45.78            -0.4       45.40        perf-profile.children.cycles-pp.do_splice_direct
      3.18            -0.3        2.87        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.70 ±  4%      -0.3        0.40 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
     15.98            -0.3       15.70        perf-profile.children.cycles-pp.tcp_rcv_established
     16.21            -0.3       15.93        perf-profile.children.cycles-pp.tcp_v4_do_rcv
      3.99            -0.3        3.72        perf-profile.children.cycles-pp.tcp_ack
     10.03            -0.2        9.78        perf-profile.children.cycles-pp.release_sock
     48.98            -0.2       48.74        perf-profile.children.cycles-pp.do_sendfile
     11.90            -0.1       11.77        perf-profile.children.cycles-pp.ip_local_deliver_finish
     11.86            -0.1       11.73        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      4.54            -0.1        4.46        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.12            -0.0        5.06        perf-profile.children.cycles-pp.lock_sock_nested
      0.19 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__ip_finish_output
      0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.24            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.14 ±  6%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.47            -0.0        0.45        perf-profile.children.cycles-pp.netperf_sendfile
      0.23            +0.0        0.24        perf-profile.children.cycles-pp.tcp_check_space
      0.10            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_skb_entail
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.38            +0.0        0.39        perf-profile.children.cycles-pp.__put_user_8
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_wfree
      0.17            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__sock_wfree
      0.30            +0.0        0.32        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.33            +0.0        0.35        perf-profile.children.cycles-pp.netif_rx_internal
      1.05            +0.0        1.07        perf-profile.children.cycles-pp.touch_atime
      0.49            +0.0        0.51        perf-profile.children.cycles-pp.kmem_cache_free
      0.47            +0.0        0.50        perf-profile.children.cycles-pp.iov_iter_advance
      0.17 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.54            +0.0        0.56        perf-profile.children.cycles-pp.menu_select
      0.50            +0.0        0.52        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.35            +0.0        0.38        perf-profile.children.cycles-pp.__netif_rx
      0.52            +0.0        0.54        perf-profile.children.cycles-pp.__mod_timer
      1.07            +0.0        1.09        perf-profile.children.cycles-pp.release_pages
      0.56            +0.0        0.58        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.18 ±  4%      +0.0        0.21 ±  9%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.70            +0.0        0.73        perf-profile.children.cycles-pp.__entry_text_start
      1.16            +0.0        1.19        perf-profile.children.cycles-pp.vfs_splice_read
      1.26            +0.0        1.29        perf-profile.children.cycles-pp.__folio_batch_release
      0.09 ±  8%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.12 ±  6%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__sk_dst_check
      0.66            +0.0        0.70        perf-profile.children.cycles-pp.__cond_resched
      0.44            +0.0        0.48        perf-profile.children.cycles-pp.__tcp_send_ack
      1.42            +0.0        1.46        perf-profile.children.cycles-pp.__fsnotify_parent
      0.91            +0.0        0.95        perf-profile.children.cycles-pp.__alloc_skb
      0.66            +0.0        0.70        perf-profile.children.cycles-pp.__fget_light
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.kthread_should_stop_or_park
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.nohz_run_idle_balance
      1.28            +0.1        1.33        perf-profile.children.cycles-pp.iov_iter_extract_pages
      0.83            +0.1        0.88        perf-profile.children.cycles-pp.__kfree_skb
      0.18 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.92            +0.1        0.98        perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.50            +0.1        1.56        perf-profile.children.cycles-pp.skb_release_data
      4.46            +0.1        4.53        perf-profile.children.cycles-pp.skb_splice_from_iter
      0.83            +0.1        0.90        perf-profile.children.cycles-pp.loopback_xmit
      1.04            +0.1        1.12        perf-profile.children.cycles-pp.apparmor_file_permission
      1.38            +0.1        1.46        perf-profile.children.cycles-pp.security_file_permission
     12.74            +0.1       12.86        perf-profile.children.cycles-pp.tcp_write_xmit
      8.16            +0.2        8.35        perf-profile.children.cycles-pp.filemap_splice_read
      7.62            +0.2        7.82        perf-profile.children.cycles-pp.copyout
      8.08            +0.2        8.30        perf-profile.children.cycles-pp._copy_to_iter
     13.04            +0.4       13.41        perf-profile.children.cycles-pp.__skb_datagram_iter
     13.06            +0.4       13.43        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      2.04 ±  4%      -0.9        1.12 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
      0.59 ±  2%      -0.5        0.13 ±  2%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.64 ±  4%      -0.3        0.34 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      4.51            -0.1        4.43        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.32 ±  4%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.dst_release
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.12 ±  7%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.__tcp_cleanup_rbuf
      0.08 ±  4%      +0.0        0.09        perf-profile.self.cycles-pp.__tcp_send_ack
      0.27            +0.0        0.28        perf-profile.self.cycles-pp.__entry_text_start
      0.17 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.loopback_xmit
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.lock_sock_nested
      0.46            +0.0        0.48        perf-profile.self.cycles-pp._copy_to_iter
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.tcp_data_queue
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__sock_wfree
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.tcp_wfree
      0.64            +0.0        0.66        perf-profile.self.cycles-pp._copy_from_user
      0.43            +0.0        0.45        perf-profile.self.cycles-pp.net_rx_action
      0.48            +0.0        0.50        perf-profile.self.cycles-pp.kmem_cache_free
      0.44            +0.0        0.46        perf-profile.self.cycles-pp.iov_iter_advance
      0.44            +0.0        0.46        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.39            +0.0        0.41        perf-profile.self.cycles-pp.__cond_resched
      0.95            +0.0        0.98        perf-profile.self.cycles-pp.release_pages
      0.92            +0.0        0.94        perf-profile.self.cycles-pp.tcp_write_xmit
      0.79            +0.0        0.82        perf-profile.self.cycles-pp.iov_iter_extract_pages
      0.57            +0.0        0.60        perf-profile.self.cycles-pp.tcp_rcv_established
      1.09            +0.0        1.12        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.08 ±  9%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.91            +0.0        0.94        perf-profile.self.cycles-pp.__skb_datagram_iter
      1.39            +0.0        1.43        perf-profile.self.cycles-pp.__fsnotify_parent
      1.05            +0.0        1.10        perf-profile.self.cycles-pp.filemap_splice_read
      0.63            +0.0        0.67        perf-profile.self.cycles-pp.__fget_light
      1.69            +0.0        1.73        perf-profile.self.cycles-pp.splice_to_socket
      1.18            +0.0        1.22        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.08            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.skb_attempt_defer_free
      1.07            +0.0        1.12        perf-profile.self.cycles-pp.skb_release_data
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__usecs_to_jiffies
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kthread_should_stop_or_park
      0.67            +0.1        0.73        perf-profile.self.cycles-pp.apparmor_file_permission
      7.55            +0.2        7.76        perf-profile.self.cycles-pp.copyout




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

