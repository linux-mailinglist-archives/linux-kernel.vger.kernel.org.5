Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AAA7D7EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbjJZIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJZIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:50:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7E1AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698310197; x=1729846197;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hJsj+T3oD4RAwlRPazua0GZsznewB2AgmiXW592adDM=;
  b=DBStvRsAbDAI4p+JuKFxe9AXzXpPMO5nftJelubbWLX1Ak4TRm2FKEbi
   ycgPqUXmym6nd6e8esFYX7OTlAg1013RAkhiAIryp/p/cRx9dqct+ojVA
   50T7XR8zg0T9yndeDCyJjG6A/ytp57QZOWk24iXV/2123pTFE7VUCl1ZD
   zTGdMBRQDsWgSRb79Sqp9PmgivcNniuC8guOQZi6gGLANlqIBxLIVte3H
   DZV/lq1NnNJ9Wbmv/5xnacQXimpoCMGOUdRRxpFtrhH9LtEPkOqhM9iSi
   7vIWZaTcXcCe590aoQEEGX8FKkNGKz7J0/sADLf2DBCpltnd7Kjn3Ky+K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="301339"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="301339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932651107"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="932651107"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 01:49:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:49:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 01:49:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 01:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzwEj1nG+qW20qWQwmiDXFk0EFiaRN52E+2LyJrCiU9seB24qGnKyNN+hjg/6Iflyp9tAKxe5jzTgJAs46JkSloJl407Ib6Mm6RM/0t1d2oKWtbry2odYa5tTbjIXJCT0I6vZtMwbQyUUCBU93u/p/Mh5uWbiou/O7/dLeY6ac2eukD4kdKzSfo2nqaGCTGeJDEUuNYJzpoyDaCihSuDtu4vjeNh1FMfNhzIDj20Z95My4ml83OluXzgFSRn/gEtEliI4P8Co4UsUWxt2ddJn2JpsUpjSpMzDnuEKwCT3IZu55pqBTP1fdpVqlbmiH92zhkqb767SmI/+TKrJVJfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy7T9PlWj3reTWf4Qb0afMZHsRNz44mjQ/8mY95bicg=;
 b=odtmkNfwx9kGbVD3Y3K9J+qWLk89nVT4qAcX25SlKTX8n4peEPNgT46TfD/R3OXE9HKcAYkNmC2Rizl+mm1rfsi6BUtf3gFzUI/5AFwhevhtKAbHb6CUuH4YlMrj2xPs5G8i9S0bnW0L1Qj1gv+sa+3VnJnItC1tE1f7BUSYYOC5V1WnXxQ8ZrCnzw9S1SpaSail6iX407MFPaBXDzBzjgDwXaHU2paIzYsKDgUohsjRzq3kOAnIUUUxLx8E10ql6IP8S4ybkt9eMZpyoKURbzEelCsoiaN85zcb0x6dShNgRKp4jUdQstmy4yobRx7b9xgMGjdOwEiZ8DZ5vn7JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 08:49:52 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:49:52 +0000
Date:   Thu, 26 Oct 2023 16:49:43 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  fd892593d4:  will-it-scale.per_process_ops 3.9%
 improvement
Message-ID: <202310261659.18c0c7e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: b51bf351-98fc-47e6-423d-08dbd60084b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPUemNMeyoi83W4jYu+1YEb6AzgLzIBYizKfEyn1yhGOVKiu6ScUzQBE/gJqR0ELvfxLvAmebUunJAmSIEW6lhyPC+BcV2EPedxr0sg/SRI04EVdum26UK3zkByCZlipLmnefQZ5rxS7Cmj3H+fpGB5aMdzfACZObvVQ0e4gMVCsiB1POp2WKU0QHbEZbD4Trie7PZ0cnF33XprRuP4iOMWNQ6L/HyWU2Rz23rh+YJ6bzfMuVlyYwS8MXdvwL8s+NcRzk2resrqSMvroZN8hTubrWtL1D4VZgGYGkw9ECepAStQ7vOj/BTcEkrEw58kzC4KDBLdqi6Zs2KFQazLiw8OsoQUr6RGh8itcoHx673xaPxOXV+b/OW97frW0TbTu0dXT0waEFiD1gsy4FRN5jbulzXvDrT38kHsRHZKUv8dt6rh24ciC6UIwLNuz5oA741KCch7CKKN9mwi039VcPQ7PQcrm2PKeqhrIXd1TE1CuLvzH8zXMDywO8b/kI76VAxaWhk9ljGhiAGQN3glAqmFK7AJUqIyfGHUJskeksAdBO7uyhrPYqe2MdoUduuZ73v/nBdt378OzXMxyCJKLfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(41300700001)(2906002)(30864003)(86362001)(36756003)(82960400001)(2616005)(1076003)(107886003)(66476007)(66556008)(66946007)(26005)(54906003)(83380400001)(6916009)(316002)(6666004)(6512007)(6506007)(966005)(6486002)(478600001)(8936002)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oY/e+LudImDsJdBYJLUWaSqbsh4JhC+ubD9drQsL9pBS2xIbw5WRRZLwq1?=
 =?iso-8859-1?Q?Sm3CMEjA0HhLNv1YyXRhLpaDXQa3u9LvTnyzO7Z0yPQseqAF/RhfnVrf9R?=
 =?iso-8859-1?Q?9oUyJ08GhHI2ZpA9cV8WMkWsM82GEU0HtupFF3MMNJi1ZhdLjA6T7D4OoF?=
 =?iso-8859-1?Q?eIE8+oUYPY1CeY/ho5dFWvzSNCce2Fx4cK9vgxs4cjAWkHEAJao2E6SQgM?=
 =?iso-8859-1?Q?+pOVlsF2Sou6d2lw9TGyDvkazGsnG3DdFu8mQFAwoFCxdTkLCqGUOSE64G?=
 =?iso-8859-1?Q?iAMF/QUgWWQOW+dQ6SHkGTvjQZdsW5IRSNcjAq6Twa5xjaD5uRje25fZ8s?=
 =?iso-8859-1?Q?Ib389eYjFqY7wDfKsP4AWWXyaHOaOX4d6uH6viEI+NLSsVjysihVtfBSmt?=
 =?iso-8859-1?Q?2o4yDzRoPE3ISzh3Pv/PORE+dnAQWpD3fRhh+JrQIjd7DV4BR2APatjgtK?=
 =?iso-8859-1?Q?Y2Rz/lnbnPn9HVGxUik+nbbhZxLXsenvtTOZC4YL0ekpWOBvZsH0XXG9Gq?=
 =?iso-8859-1?Q?8P57uKUnjnSozywlisv8jwv98v47oYN/khXNSvBnPS6gYeUNaBtCDJB7vQ?=
 =?iso-8859-1?Q?g3HzFbe/ifI81c7XvDNSM4jbgcU740pNqNF25mSD8jrv/zncfT27Df3hhs?=
 =?iso-8859-1?Q?x4xOHv+0EKhf8qmglA2Qz0MxZVlvGutWp5aMaxUppdyfQKcFypbu/Xnzbe?=
 =?iso-8859-1?Q?DDU7PoQWw6HKKres+1OUzWM60Ap0ZXeHYhlNbjv2p0MoZ1dWJ1Ur0MN1FU?=
 =?iso-8859-1?Q?NtB0v/fPbwy/DboSkTNfSUc5Y3Aa7f0DuXuVyjN/P0l8CE9hoHERKUUw4G?=
 =?iso-8859-1?Q?yuqwWCTVZiUvMNQbR3WU4+fFn+6+BWFUoYnk48PKJwYrkP7elFcW75+zKZ?=
 =?iso-8859-1?Q?jZ86C9w8Bm78zOu+/NiYo/chKxYa4plQ06wpChtymC8MP6LzPf8lGC7TX7?=
 =?iso-8859-1?Q?mCrb+ji7o62v6guGLfskPNDkC8bx54OD5uOJBVb2SQZYL0BmgPGLgXkobJ?=
 =?iso-8859-1?Q?kwZ0oXxFOjKndSl39F+nubwZLGZUb63vrGehcTWggQqss0pJBSswaQlZn/?=
 =?iso-8859-1?Q?E5tjaApKjD3XmyZ84cnpFwPB1neucSuaX1itYM78kgrT7CaCkTAc9k62FH?=
 =?iso-8859-1?Q?xWu4ROw5Avbz7FqISMnh+p4FiTrgpEyACW7ChZCCA68TlaXUlKoEZ/sw/8?=
 =?iso-8859-1?Q?JG7+wA/EKn2xW0xW8faJDJHHMXxGUBf9BeQ6qXEDiWcsAp+mD5lLnHltJz?=
 =?iso-8859-1?Q?VG7aj6Ny4pqzAiNlQaE2VLMiplf48uGlemiDBAW1icY2q4QtB/naktfUrx?=
 =?iso-8859-1?Q?7hbReoiwpysZos3rFMzOMqPTwTpnUbXGZtQtdW7ld/F47eWzuGJysBMytq?=
 =?iso-8859-1?Q?mUDAFfnuYJULR6cd6G9dg/tT9cpdKME9MoNYuP5eoz77uPfmty1OFIM3rI?=
 =?iso-8859-1?Q?T8MAeTwwviBjxKFQPUTdCr1zM+zlDDAQ8IPirGO3iPm3XcDACXChvHcKRp?=
 =?iso-8859-1?Q?zedso4UNErsPR/M3qKZmG5bVsvt1jCk+HGGqDyPeX3PAQuzwBWrPT9MGlJ?=
 =?iso-8859-1?Q?9kys3BNWWQE0SSDQHnLVCjKyctcfbVZ3Z/L+37f7Gax2mpHUSKqh4ZwG9i?=
 =?iso-8859-1?Q?KQgU8lfhZNoXSxgKvBjL3PucQ3zJXoUTSCUJugapRaBMZ0fMK/qfMFhQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b51bf351-98fc-47e6-423d-08dbd60084b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:49:52.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI74kS7aurQFwJlYpx66sOHQCpxbE9BJX7hbw/vllg9c0Pf2O6jrNyyia0Q3sCS+WbrsFg7HWX8KQl+iCYNPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 3.9% improvement of will-it-scale.per_process_ops on:


commit: fd892593d44d8b649caf30a67f0c7696d976d901 ("mm: change do_vmi_align_munmap() tracking of VMAs to remove")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: brk2
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261659.18c0c7e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/brk2/will-it-scale

commit: 
  8c314f3b55 ("maple_tree: add benchmarking for mas_prev()")
  fd892593d4 ("mm: change do_vmi_align_munmap() tracking of VMAs to remove")

8c314f3b55fbc422 fd892593d44d8b649caf30a67f0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     44.35            +1.3%      44.94        turbostat.RAMWatt
      7472            +2.2%       7638        vmstat.system.cs
  13163009            +3.9%   13672076        will-it-scale.104.processes
    126566            +3.9%     131461        will-it-scale.per_process_ops
  13163009            +3.9%   13672076        will-it-scale.workload
 3.703e+08            +2.3%  3.789e+08        proc-vmstat.numa_hit
 3.702e+08            +2.3%  3.788e+08        proc-vmstat.numa_local
  7.24e+08            +2.3%  7.407e+08        proc-vmstat.pgalloc_normal
  7.23e+08            +2.3%  7.397e+08        proc-vmstat.pgfree
      5.72 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
    442.80 ±  5%      +9.9%     486.50 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags
    407.80 ±  6%     +12.5%     458.90 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
    311.30 ± 11%     -20.7%     246.80 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      1114 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
     28.01 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
      6.22 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      5.72 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
     14.25 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     28.01 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk
      2.49            +3.5%       2.58        perf-stat.i.MPKI
 3.407e+08            +3.5%  3.527e+08        perf-stat.i.cache-misses
 5.063e+08            +3.7%   5.25e+08        perf-stat.i.cache-references
      7446            +2.3%       7616        perf-stat.i.context-switches
    248.21            +2.2%     253.65        perf-stat.i.cpu-migrations
    817.56            -3.4%     789.61        perf-stat.i.cycles-between-cache-misses
      0.04            +0.0        0.04        perf-stat.i.dTLB-load-miss-rate%
  14854767            +3.6%   15392456        perf-stat.i.dTLB-load-misses
  13577896            +4.9%   14238965        perf-stat.i.iTLB-load-misses
  24153428            +3.4%   24977848        perf-stat.i.iTLB-loads
     10082            -4.6%       9618        perf-stat.i.instructions-per-iTLB-miss
      1532            +3.0%       1578        perf-stat.i.metric.K/sec
  43693423            +2.7%   44860627        perf-stat.i.node-loads
  86115914            +2.6%   88355886        perf-stat.i.node-stores
      2.49            +3.5%       2.58        perf-stat.overall.MPKI
    817.24            -3.4%     789.30        perf-stat.overall.cycles-between-cache-misses
      0.04            +0.0        0.04        perf-stat.overall.dTLB-load-miss-rate%
     10079            -4.6%       9614        perf-stat.overall.instructions-per-iTLB-miss
   3134760            -3.7%    3019810        perf-stat.overall.path-length
 3.396e+08            +3.5%  3.515e+08        perf-stat.ps.cache-misses
 5.046e+08            +3.7%  5.232e+08        perf-stat.ps.cache-references
      7420            +2.3%       7589        perf-stat.ps.context-switches
    247.36            +2.2%     252.76        perf-stat.ps.cpu-migrations
  14810795            +3.6%   15350854        perf-stat.ps.dTLB-load-misses
  13531716            +4.9%   14190673        perf-stat.ps.iTLB-load-misses
  24072354            +3.4%   24894366        perf-stat.ps.iTLB-loads
  43550846            +2.7%   44720688        perf-stat.ps.node-loads
  85827526            +2.6%   88063334        perf-stat.ps.node-stores
     36.62            -1.0       35.60        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.94            -0.8        1.18        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      5.74            -0.7        5.01        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.89 ±  3%      -0.5        2.41 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.rcu_do_batch.rcu_core.__do_softirq
      2.84 ±  3%      -0.5        2.36 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.rcu_do_batch.rcu_core
      5.17 ±  2%      -0.5        4.70 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      4.47            -0.4        4.04        perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64
      3.42            -0.4        3.06        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.49            -0.4        1.14 ±  3%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.kmem_cache_free_bulk.mas_destroy.mas_store_prealloc.do_brk_flags
      2.54            -0.3        2.21        perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk
      1.10            -0.3        0.82 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.kmem_cache_free_bulk.mas_destroy.mas_store_prealloc
      1.09            -0.3        0.82 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.kmem_cache_free_bulk.mas_destroy
      4.53            -0.3        4.28 ±  2%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      4.88            -0.3        4.63        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      5.53            -0.2        5.31        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.__do_sys_brk
      5.64            -0.2        5.42        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.60            -0.1        0.47 ± 33%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.85            -0.1        0.72        perf-profile.calltrace.cycles-pp.mas_next_slot.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10            -0.1        1.00 ±  3%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk
      0.81 ±  2%      -0.1        0.72 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.mas_destroy.mas_store_prealloc.do_brk_flags
      1.09            -0.1        1.01        perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mas_destroy.mas_store_prealloc.vma_complete.__split_vma
      0.53            +0.0        0.56        perf-profile.calltrace.cycles-pp.mas_store_b_node.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk
      0.58            +0.0        0.61        perf-profile.calltrace.cycles-pp.mab_mas_cp.mas_split_final_node.mas_split.mas_wr_bnode.mas_store_prealloc
      0.75            +0.0        0.78        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61            +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71            +0.0        0.75        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.71            +0.0        0.75        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      1.10            +0.0        1.14        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
      1.08            +0.0        1.12        perf-profile.calltrace.cycles-pp.mas_descend_adopt.mas_wmb_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc
      0.71 ±  2%      +0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.mas_pop_node.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      1.00            +0.1        1.05        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wmb_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc
      0.76            +0.1        0.81        perf-profile.calltrace.cycles-pp.mas_mab_cp.mas_store_b_node.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.74 ±  2%      +0.1        0.80        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.48            +0.1        1.55        perf-profile.calltrace.cycles-pp.__entry_text_start.brk
      1.02            +0.1        1.08        perf-profile.calltrace.cycles-pp.mas_split_final_node.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.91            +0.1        0.98 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_b_node.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      0.62            +0.1        0.69        perf-profile.calltrace.cycles-pp.mas_wr_walk_index.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk
      1.55            +0.1        1.62        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      1.18            +0.1        1.25        perf-profile.calltrace.cycles-pp.mas_descend_adopt.mas_wmb_replace.mas_split.mas_wr_bnode.mas_store_prealloc
      1.65            +0.1        1.74        perf-profile.calltrace.cycles-pp.mast_fill_bnode.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.72            +0.1        0.82        perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      2.28            +0.1        2.38        perf-profile.calltrace.cycles-pp.mas_wmb_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags
      2.09            +0.1        2.20        perf-profile.calltrace.cycles-pp.mas_wmb_replace.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      2.49            +0.1        2.63        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_sys_brk
      3.36            +0.1        3.49        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     14.95            +0.1       15.08        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.89            +0.1        3.03        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      3.85            +0.2        4.01        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.brk
      6.96            +0.3        7.29        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk
      6.29            +0.5        6.78 ±  2%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      9.84            +0.5       10.35        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64
      8.18            +0.5        8.69        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      4.09 ±  2%      +0.6        4.67 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.__unfreeze_partials
      4.11 ±  2%      +0.6        4.69 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.__unfreeze_partials.rcu_do_batch
      4.22 ±  2%      +0.6        4.81 ±  4%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_core
      4.25 ±  2%      +0.6        4.84 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq
      9.74            +0.6       10.34        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
     13.31            +0.6       13.92        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.__do_sys_brk
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do_sys_brk
     13.46            +0.6       14.10        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
     22.96            +0.7       23.64        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.73            -1.0       35.71        perf-profile.children.cycles-pp.do_vmi_align_munmap
     27.38            -1.0       26.40        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     27.64            -1.0       26.67        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.68            -0.7        1.94        perf-profile.children.cycles-pp.mas_wr_store_entry
      5.80            -0.7        5.06        perf-profile.children.cycles-pp.mas_store_gfp
     14.46            -0.7       13.77        perf-profile.children.cycles-pp.mas_alloc_nodes
      7.52            -0.5        7.06        perf-profile.children.cycles-pp.mas_destroy
      3.66            -0.4        3.25        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.80            -0.4        0.43 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      3.45            -0.4        3.09        perf-profile.children.cycles-pp.unmap_region
      1.85            -0.3        1.57        perf-profile.children.cycles-pp.mas_find
      1.48            -0.3        1.22        perf-profile.children.cycles-pp.mas_walk
      1.49            -0.2        1.25        perf-profile.children.cycles-pp.mtree_range_walk
      1.09            -0.2        0.85        perf-profile.children.cycles-pp.mas_next_slot
      2.68            -0.1        2.55        perf-profile.children.cycles-pp.kmem_cache_free
      4.33            -0.1        4.20        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.90            -0.1        1.79 ±  2%  perf-profile.children.cycles-pp.mas_pop_node
      0.22 ±  2%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.remove_vma
      0.22 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.30 ±  2%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.downgrade_write
      0.20 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.mas_nomem
      0.08 ±  3%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.discard_slab
      0.48            +0.0        0.51        perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.58            +0.0        0.61        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.10 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
      0.74            +0.0        0.78        perf-profile.children.cycles-pp.mas_wr_walk
      0.66            +0.0        0.70        perf-profile.children.cycles-pp.vma_prepare
      0.86            +0.0        0.89 ±  2%  perf-profile.children.cycles-pp.mas_prev_slot
      1.11            +0.0        1.15        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.11 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.anon_vma_clone
      0.62            +0.0        0.67        perf-profile.children.cycles-pp.get_unmapped_area
      1.22            +0.0        1.26        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.71            +0.0        0.76        perf-profile.children.cycles-pp.check_brk_limits
      0.94            +0.1        1.00        perf-profile.children.cycles-pp.__cond_resched
      0.76            +0.1        0.82        perf-profile.children.cycles-pp.zap_pmd_range
      1.02            +0.1        1.09        perf-profile.children.cycles-pp.mas_split_final_node
      1.02            +0.1        1.08        perf-profile.children.cycles-pp.memcpy_orig
      0.63            +0.1        0.69        perf-profile.children.cycles-pp.mas_wr_walk_index
      0.29 ±  2%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.mas_next_sibling
      1.56            +0.1        1.63        perf-profile.children.cycles-pp.perf_iterate_sb
      1.87            +0.1        1.94        perf-profile.children.cycles-pp.__entry_text_start
      1.66            +0.1        1.75        perf-profile.children.cycles-pp.mast_fill_bnode
      0.73            +0.1        0.83        perf-profile.children.cycles-pp.mas_push_data
      1.63            +0.1        1.74        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.27            +0.1        2.38        perf-profile.children.cycles-pp.mas_descend_adopt
      3.42            +0.1        3.53        perf-profile.children.cycles-pp.mab_mas_cp
      1.85            +0.1        1.97        perf-profile.children.cycles-pp.mas_store_b_node
      2.51            +0.1        2.63        perf-profile.children.cycles-pp.__call_rcu_common
      3.38            +0.1        3.52        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.90            +0.1        3.04        perf-profile.children.cycles-pp.vm_area_dup
      2.43            +0.2        2.58        perf-profile.children.cycles-pp.mas_mab_cp
      3.88            +0.2        4.05        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.40            +0.2        4.62        perf-profile.children.cycles-pp.mas_wmb_replace
     13.50            +0.3       13.77        perf-profile.children.cycles-pp.__unfreeze_partials
      7.00            +0.3        7.32        perf-profile.children.cycles-pp.mas_spanning_rebalance
     28.03            +0.5       28.49        perf-profile.children.cycles-pp.rcu_core
      9.86            +0.5       10.37        perf-profile.children.cycles-pp.mas_wr_spanning_store
      8.26            +0.5        8.77        perf-profile.children.cycles-pp.mas_split
     12.98            +0.6       13.62        perf-profile.children.cycles-pp.mas_wr_bnode
     13.58            +0.7       14.23        perf-profile.children.cycles-pp.vma_complete
     23.02            +0.7       23.70        perf-profile.children.cycles-pp.__split_vma
     28.32            +0.7       29.06        perf-profile.children.cycles-pp.mas_store_prealloc
     27.38            -1.0       26.40        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.76            -0.2        0.53        perf-profile.self.cycles-pp.mas_next_slot
      1.31            -0.2        1.09        perf-profile.self.cycles-pp.mtree_range_walk
      1.54            -0.1        1.40        perf-profile.self.cycles-pp.kmem_cache_alloc
      2.27            -0.1        2.13        perf-profile.self.cycles-pp.kmem_cache_free
      1.70            -0.1        1.58        perf-profile.self.cycles-pp.mas_pop_node
      0.48            -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.unmap_page_range
      0.52            -0.1        0.45        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.16 ±  3%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.free_pgtables
      0.31 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.11 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.remove_vma
      0.19 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.75            -0.0        0.71        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.82            -0.0        0.78        perf-profile.self.cycles-pp.___slab_alloc
      0.12 ±  4%      -0.0        0.09 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.downgrade_write
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.unmap_vmas
      0.24            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.unmap_region
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.can_vma_merge_after
      0.18 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.get_unmapped_area
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.unmap_single_vma
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.zap_pmd_range
      0.36 ±  2%      +0.0        0.39 ±  2%  perf-profile.self.cycles-pp.mas_push_data
      0.79            +0.0        0.82        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.99 ±  2%      +0.0        1.03        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.anon_vma_clone
      0.61            +0.0        0.65        perf-profile.self.cycles-pp.__cond_resched
      0.83            +0.0        0.87        perf-profile.self.cycles-pp.mast_fill_bnode
      0.20 ±  4%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.vma_complete
      1.22            +0.0        1.26        perf-profile.self.cycles-pp.mas_wr_spanning_store
      0.88            +0.0        0.93        perf-profile.self.cycles-pp.memcpy_orig
      1.26            +0.0        1.30        perf-profile.self.cycles-pp.__call_rcu_common
      0.21 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_next_sibling
      1.12            +0.1        1.18        perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.78            +0.1        0.83        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.79            +0.1        0.85        perf-profile.self.cycles-pp.__do_sys_brk
      0.56            +0.1        0.61        perf-profile.self.cycles-pp.mas_wr_walk_index
      0.51 ±  2%      +0.1        0.57        perf-profile.self.cycles-pp.__split_vma
      1.65            +0.1        1.72        perf-profile.self.cycles-pp.__entry_text_start
      1.32            +0.1        1.39        perf-profile.self.cycles-pp.mas_spanning_rebalance
      2.30            +0.1        2.37        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.04            +0.1        2.12        perf-profile.self.cycles-pp.mas_descend_adopt
      1.77            +0.1        1.86        perf-profile.self.cycles-pp.mas_mab_cp
      1.61            +0.1        1.71        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      3.13            +0.1        3.27        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.88            +0.2        4.04        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.75            +0.2        4.94        perf-profile.self.cycles-pp.__slab_free



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

