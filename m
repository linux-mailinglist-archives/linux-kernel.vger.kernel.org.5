Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7737AAE56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjIVJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjIVJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:38:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8FE192;
        Fri, 22 Sep 2023 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695375504; x=1726911504;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=LM9d2DdErj0d5xdkQ6thbqAVm1YRcM6iMKYvd/7qYpw=;
  b=fsDCDzB90d5eVGaIAc/7QAZpI0nEWJK4v+MgnWRZ1TeDlP0lmGA4gjLY
   OlUgchvhqdc+L6QTU5hcg9Vpn2+g4yEu73mOCQaDL6USHXweQB734H6Er
   zjTlSubRKUtKyaZSMFmDPFuefWH0snXXqGP8Nw/ICalgxDuPEnpk99tib
   GW7wxWmQsfL4H1gtlFAYSyF8dwkLO6U3hnfzeBkTaycnUpxV/9BTMRoKp
   pSOwxEdYQKjMcmHkb3HtWlDTlW3AJhBhpqZJweD9VvrcDJooypMY9t2jm
   RWkulFNlurbs2AoJVtPN3EaMe3qFkLSU0kX2dhDMZpN7Pcu1l0HJHjSY1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="379666786"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="379666786"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="724115402"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="724115402"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 02:38:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 02:38:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 02:38:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 02:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTbqok1KMwnQeOB6cypHUHA7tuAsC3QBfs3YClst/SjEnntP+8N3snCAS/bFs3bfDOXCvE2AzMT9xnVVRbMG+PgQ+iAS+HXsHdVx2KFEpDLzBWCrGl5x6VHhOvkSrYKy9IwyLIZ46n8K63SF99FNCoaeXUgc2IjH9Df1kb7l1nKBeqOdHNUsdYHknuvyDZPWRWTHZbvFgG8Ogd4oFDm3wcYn+iPJfqFtLu1GaAEr/VaCVWRyPEv3jeYhWE1cjQJxbWCIL6ntwNDVRI0lQYOyZZcAh7+HrnWnDk2+sKYsF3uqFXr3Ic81WDf66lFyLWGOv48c8zANt6qPuN+Y3UbKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2HlkPhnqqjcQT8RQ3x5Y9v8vgXmnRLA4RXfDUzTMIY=;
 b=KxBpY2dBtm2k8kklLCFcTSw37WFTTJ1GkwS2fyn3WMgGk90dRl7mxNJSaSoiWC2wikwD5xfkQqbPc79u1fNv0xGtJuw12+j6XM0r2diBqyNDqJ7uzwcznEp0d8ebb7U4U+hkG8ZIXSDewETUVF7TZAzET2Bu8lHxbQh7F+SC+m/EDT2tkRoSQMOB8Mg2RKmISVfUqLjvTQaXYgZMNOTwviCA0erSKInidbspJ7J9JDVgwVgKvxZ4TCek+tvpnTdD9R5L6a5DHUSeWbz0FR2OOf7XERAuQyHpqC8VO3sbsdBHfFYPC66inypKT17T6zKw2nqbSdCzBB2fM0eSfQHMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA2PR11MB5209.namprd11.prod.outlook.com (2603:10b6:806:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:38:20 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 09:38:20 +0000
Date:   Fri, 22 Sep 2023 17:38:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, <linux-doc@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [workqueue]  636b927eba:  stress-ng.io.ops_per_sec
 19.5% improvement
Message-ID: <202309221737.2ee51a68-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA2PR11MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: f6212e11-fc67-40ad-3652-08dbbb4fa7e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJcC8Nuyp0nCovxXgMPbx822wq1GhbUPiztsaECaUNnYJZEyLKh28pbYxJ6i+Vh2oLcXXsFTN2agL1ZDORKYEzupBEsSt0OJ7lsrpMEQ6AP9dNyEUk+y4GXLkBHPBv+FA7iVVeobDV2ieJookl3f3hBoAszqPbU5p+Qg9y1qTC5Ui6+M6wtyS8xQPhqzBX0wY0nKvL0eMeNdnyfSX+6S9VP2Zf8DGaWLLlEricsIw3za3/lJLGWEHKeBonsksfw+7nZAOUAuc9PvLaEwmBepuuT0SmWkGNf9qBiYGCbzo8sAQilEyWjSF/m8wT3t6e0fL4++HkKSyDpP2oolntnzteKwVfevArbSdoCuo20MwQuA9lZbSvrNLlUB75gBBSRaM+c1PqXS+PwXKOotAxh1nB8F+Hhimf4MuncVVfCdYAlOm57XNpXwExmhNpR9raKzgwULtxjS9d1bQLaNFwms8vrmwIk6GnZN2y3ikPKnW2ukxgf1QLKoyGZyCRFxaSvHk9GRoHzjqLNyFUr71yvsqYOS2W+Swh7uPV5UvLVlJKX7PP2jhiscpsRwusMRNqJFla023UKAqUNUR6JFsBo8jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(186009)(451199024)(1800799009)(478600001)(6506007)(82960400001)(26005)(2616005)(6666004)(966005)(38100700002)(6486002)(83380400001)(1076003)(6512007)(107886003)(6916009)(316002)(66946007)(66556008)(66476007)(54906003)(7416002)(5660300002)(2906002)(30864003)(36756003)(86362001)(41300700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+UcTg7g+1ZrKmf4lMfW3KWnlM3LW94rAAnUw57i3CYzXlWYleoTPKBdw6u?=
 =?iso-8859-1?Q?xXjChQ/choPuCM5wPgPtS19n61F7u0vlHqniNC70u1uOCi0+ajnJBXAQj8?=
 =?iso-8859-1?Q?GaAiJniEy/S6DCcCIT5ibmUAtkwNLniCm6kFjDw1QI+5qngNTbwuhBnuRT?=
 =?iso-8859-1?Q?0hHjQy/umq4d+lxMBBmtY16qvx0y1l/q61gBeafDoSGvvSFURZzd7CJ3I6?=
 =?iso-8859-1?Q?fk2fXGdxa09bypI7Z+QgKu3hIRBSsMhePcfrpd9xzGHjQTDIHBSOgtE1oZ?=
 =?iso-8859-1?Q?Fkmsp1UfJ+bjhEUJtHkOLniEAKZAurD2IbSAkyAxfzAnrKNWyptxIvn+TN?=
 =?iso-8859-1?Q?KjYi497hmdiEFjtsObBSRLolF+Ii9D1oLX/+Uj6dHd6+wA3Z4mxjvn1+lU?=
 =?iso-8859-1?Q?/RSfmHi90hJojcCowxK7IGH9/YUhwQVTFvWpXbGBDI/sg4QM90Nv6UDkLd?=
 =?iso-8859-1?Q?8FoKFrnDzzkFbYMr+e6Oi1ZXNomQfKWXLpHYrwwDbS6F6o3CQaXFLxljjG?=
 =?iso-8859-1?Q?4gMGZupBITEOV3OcFruGTp8DuY/7foA35KLF5gq1jx+2TJ/2RebXKQ5YJ9?=
 =?iso-8859-1?Q?s3NuFtoYMAThgk/Xw2OI4y1irfbPqg/5UMD4rkHyYUxarqjZaYCoVyJOC3?=
 =?iso-8859-1?Q?+2ERIdZoS70jY6IVfMa7Dnrrm8hO5JBejPPfqr1cGzI3G4dnw28zeK/51U?=
 =?iso-8859-1?Q?NvoiLEDlOB8ttEJPg/GckxzyyBxF5BVT0wGGZDYEHcPLy4pm+Hp4AAsv9N?=
 =?iso-8859-1?Q?PGpFlnMBLTh0iB4I55MQhMxLN+Ffc2vym3mj83RCmAqqmdPTEhi7GXpHBq?=
 =?iso-8859-1?Q?cOdirD+cCwRTiu0uaFiWReBSmub7aSVpE3yllzsMgtSey1coMj/I6U0o3m?=
 =?iso-8859-1?Q?yYHV85sn5qFZie+cl0iEhbI/2tP/4ZNUQXASsI15dSkptlHNYmPboIJV6A?=
 =?iso-8859-1?Q?5aZxfAfhIMJrx3zezRq8ZpUPh7XXTMgv9d0JjhAhg2T+SX9KGJkXg/lbts?=
 =?iso-8859-1?Q?3FA2djoB+3sjFVBPbV+tjzqqVBASPtynlqzMp/YezVRQXE/mLHThhhG6oT?=
 =?iso-8859-1?Q?sCliXIz7VBf37BuiFKR/EN4uoM681D3Yf8u5tnGA5iWp6sN33d3Fx++1G7?=
 =?iso-8859-1?Q?81GqGUoS8UZHZccy1mEFPHDbd5YPsJU09RiyEeeiYgrSXLuJt28Vpp02BB?=
 =?iso-8859-1?Q?RdIn2OaGQ5hPnwqDloUSSFzqLykINkDa0MxSW4ONDaIww9FpeLXULw2Izy?=
 =?iso-8859-1?Q?6IZAY27U0fEJcSowV7+DFntH9DIOfrPPlSOCRtIUWSWzFTX7yHrWt6hSvd?=
 =?iso-8859-1?Q?klM0p75HB4QLk/dG86OzknsQOUrdjcnhVFtNRncCk7YylBFgB/ScYDS1T6?=
 =?iso-8859-1?Q?ZOKl6LHNfBFBUb4OZFin37GZr46z8+gBaH9Nig5rfQZ+C4dwzLgcMVj6NS?=
 =?iso-8859-1?Q?FJ1Yz0mz+nQWRjBtCsXBVZo4aiynK0MqU7cti6k9GKAxjYZeVzcypq+JjV?=
 =?iso-8859-1?Q?sT8qsrUYe17yXrLzOvYuCeH5NXzLDIoEPdH7nQAuD717coGDVpuDQrQ9U8?=
 =?iso-8859-1?Q?y3+0zsfNCLI7GKJ8HuNoWxeJMkUN+DrbR05VNfOhFkhzXJt2AfIX925g44?=
 =?iso-8859-1?Q?wMZKqVFNPvbrJRwP6XwL5voJwl26y0ZnblUUiFGVugWBdLDb9lGUlK7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6212e11-fc67-40ad-3652-08dbbb4fa7e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:38:20.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhyEYAIHrEXSHOJSidr9i5io9VGy0+zWWKt25ioepOKR6rMdlm9E1wGs06wn2Idyt6HTmYZZpTGGVWbz63+jDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 19.5% improvement of stress-ng.io.ops_per_sec on:


commit: 636b927eba5bc633753f8eb80f35e1d5be806e51 ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: io
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230922/202309221737.2ee51a68-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/io/stress-ng/60s

commit: 
  4cbfd3de73 ("workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug")
  636b927eba ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")

4cbfd3de737b9d00 636b927eba5bc633753f8eb80f3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.53 ±  2%      +0.3        1.82 ±  3%  mpstat.cpu.all.usr%
      0.04 ± 25%     -58.2%       0.02 ± 43%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      7.29            -2.7%       7.09        iostat.cpu.system
      1.52 ±  2%     +18.2%       1.80 ±  3%  iostat.cpu.user
     58.72 ± 46%     -63.9%      21.18 ± 50%  sched_debug.cfs_rq:/.removed.load_avg.avg
    205.63 ± 27%     -47.3%     108.41 ± 52%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.13 ±  3%     +13.8%       0.15 ±  4%  turbostat.IPC
     82.74            +1.5%      83.95        turbostat.PkgWatt
   2954572           +19.5%    3529576 ±  4%  stress-ng.io.ops
     49242           +19.5%      58826 ±  4%  stress-ng.io.ops_per_sec
    151.67            -3.8%     145.86        stress-ng.time.system_time
     27.02           +21.6%      32.86 ±  4%  stress-ng.time.user_time
 1.017e+09           +21.7%  1.238e+09 ±  3%  perf-stat.i.branch-instructions
      2.07            -0.4        1.71 ±  3%  perf-stat.i.branch-miss-rate%
  1.42e+08           +20.9%  1.717e+08 ±  2%  perf-stat.i.cache-references
      2.54           -17.6%       2.09 ±  4%  perf-stat.i.cpi
      0.13            -0.0        0.12        perf-stat.i.dTLB-load-miss-rate%
   1359466           +19.1%    1618588 ±  4%  perf-stat.i.dTLB-load-misses
 1.134e+09           +19.6%  1.356e+09 ±  3%  perf-stat.i.dTLB-loads
      0.00 ±  7%      -0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
 5.421e+08           +19.6%  6.483e+08 ±  3%  perf-stat.i.dTLB-stores
     63.26 ±  4%      +6.1       69.35 ±  2%  perf-stat.i.iTLB-load-miss-rate%
  5.08e+09           +20.7%  6.131e+09 ±  3%  perf-stat.i.instructions
      0.42           +19.3%       0.50 ±  3%  perf-stat.i.ipc
     78.71           +20.4%      94.79 ±  3%  perf-stat.i.metric.M/sec
      2.23            -0.4        1.85 ±  3%  perf-stat.overall.branch-miss-rate%
      0.33 ±  4%      -0.1        0.28 ±  6%  perf-stat.overall.cache-miss-rate%
      2.44           -16.8%       2.03 ±  3%  perf-stat.overall.cpi
      0.00 ±  4%      -0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     62.97 ±  5%      +7.3       70.29 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      0.41           +20.4%       0.49 ±  3%  perf-stat.overall.ipc
 1.001e+09           +21.7%  1.218e+09 ±  3%  perf-stat.ps.branch-instructions
 1.398e+08           +20.9%   1.69e+08 ±  2%  perf-stat.ps.cache-references
   1337922           +19.1%    1592892 ±  4%  perf-stat.ps.dTLB-load-misses
 1.116e+09           +19.6%  1.334e+09 ±  3%  perf-stat.ps.dTLB-loads
 5.335e+08           +19.6%   6.38e+08 ±  3%  perf-stat.ps.dTLB-stores
 4.999e+09           +20.7%  6.033e+09 ±  3%  perf-stat.ps.instructions
 3.167e+11           +20.4%  3.811e+11 ±  3%  perf-stat.total.instructions
     21.48 ±  3%      -7.5       13.96 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64
     18.33 ±  3%      -7.0       11.30 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.iterate_supers.ksys_sync.__x64_sys_sync
     35.16 ±  3%      -6.9       28.21 ±  6%  perf-profile.calltrace.cycles-pp.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.20 ±  3%      -6.9       29.35 ±  6%  perf-profile.calltrace.cycles-pp.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
     36.20 ±  3%      -6.9       29.35 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
     36.44 ±  3%      -6.8       29.59 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
     36.54 ±  3%      -6.8       29.71 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sync
     36.86 ±  3%      -6.8       30.08 ±  6%  perf-profile.calltrace.cycles-pp.sync
     29.64 ±  8%      -5.1       24.54 ± 15%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.64 ±  8%      -5.1       24.54 ± 15%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     29.63 ±  8%      -5.1       24.54 ± 15%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.45 ±  8%      -5.1       24.37 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.07 ±  8%      -5.1       24.00 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     29.78 ±  8%      -4.1       25.66 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     28.89 ±  8%      -4.1       24.82 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     26.19 ±  8%      -4.0       22.20 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.73 ±  3%      -1.8        7.94 ±  4%  perf-profile.calltrace.cycles-pp.down_read.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64
      1.34 ±  5%      +0.2        1.50 ±  4%  perf-profile.calltrace.cycles-pp._find_next_bit.get_nr_inodes.get_nr_dirty_inodes.writeback_inodes_sb.sync_filesystem
      2.11 ±  5%      +0.2        2.32 ±  6%  perf-profile.calltrace.cycles-pp.__entry_text_start.syncfs
      1.14 ±  7%      +0.2        1.36 ±  8%  perf-profile.calltrace.cycles-pp.up_read.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64
      2.48 ±  6%      +0.4        2.84 ±  4%  perf-profile.calltrace.cycles-pp.down_read.__x64_sys_syncfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.syncfs
      4.64 ±  5%      +0.6        5.23 ±  5%  perf-profile.calltrace.cycles-pp.get_nr_inodes.get_nr_dirty_inodes.writeback_inodes_sb.sync_filesystem.__x64_sys_syncfs
      4.99 ±  6%      +0.6        5.58 ±  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syncfs
      4.33 ±  4%      +0.6        4.97 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syncfs
      9.99 ±  5%      +1.2       11.21 ±  4%  perf-profile.calltrace.cycles-pp.get_nr_dirty_inodes.writeback_inodes_sb.sync_filesystem.__x64_sys_syncfs.do_syscall_64
     10.31 ±  5%      +1.3       11.56 ±  4%  perf-profile.calltrace.cycles-pp.writeback_inodes_sb.sync_filesystem.__x64_sys_syncfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.35 ±  8%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      0.00            +1.8        1.78 ±  8%  perf-profile.calltrace.cycles-pp.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force
      0.00            +2.6        2.64 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force.xfs_fs_sync_fs.iterate_supers
      0.00            +2.7        2.66 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force.xfs_fs_sync_fs.iterate_supers.ksys_sync
      0.00            +2.7        2.69 ±  5%  perf-profile.calltrace.cycles-pp.xfs_log_force.xfs_fs_sync_fs.iterate_supers.ksys_sync.__x64_sys_sync
      0.00            +2.7        2.70 ±  5%  perf-profile.calltrace.cycles-pp.xfs_fs_sync_fs.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64
      0.00            +6.5        6.49 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.flush_workqueue_prep_pwqs.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      0.66 ±  9%      +7.0        7.63 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force.xfs_fs_sync_fs.sync_filesystem.__x64_sys_syncfs
      0.62 ± 10%      +7.0        7.59 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force.xfs_fs_sync_fs.sync_filesystem
      0.70 ±  9%      +7.0        7.68 ±  6%  perf-profile.calltrace.cycles-pp.xfs_log_force.xfs_fs_sync_fs.sync_filesystem.__x64_sys_syncfs.do_syscall_64
      0.77 ±  8%      +7.0        7.76 ±  6%  perf-profile.calltrace.cycles-pp.xfs_fs_sync_fs.sync_filesystem.__x64_sys_syncfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +7.5        7.46 ±  6%  perf-profile.calltrace.cycles-pp.flush_workqueue_prep_pwqs.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force
     12.60 ±  5%      +8.5       21.12 ±  5%  perf-profile.calltrace.cycles-pp.sync_filesystem.__x64_sys_syncfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.syncfs
     16.57 ±  5%      +9.2       25.72 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_syncfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.syncfs
      0.50 ± 45%      +9.7       10.18 ±  6%  perf-profile.calltrace.cycles-pp.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force.xfs_fs_sync_fs
     21.43 ±  5%      +9.8       31.22 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syncfs
     24.17 ±  5%     +10.1       34.30 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syncfs
     31.94 ±  5%     +11.0       42.94 ±  4%  perf-profile.calltrace.cycles-pp.syncfs
     22.38 ±  3%      -7.5       14.88 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
     18.34 ±  3%      -7.0       11.30 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     35.22 ±  3%      -6.9       28.30 ±  6%  perf-profile.children.cycles-pp.iterate_supers
     36.20 ±  3%      -6.9       29.35 ±  6%  perf-profile.children.cycles-pp.__x64_sys_sync
     36.20 ±  3%      -6.9       29.35 ±  6%  perf-profile.children.cycles-pp.ksys_sync
     36.88 ±  3%      -6.8       30.10 ±  6%  perf-profile.children.cycles-pp.sync
     29.64 ±  8%      -5.1       24.54 ± 15%  perf-profile.children.cycles-pp.start_secondary
     29.78 ±  8%      -4.1       25.66 ±  7%  perf-profile.children.cycles-pp.do_idle
     29.78 ±  8%      -4.1       25.66 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     29.78 ±  8%      -4.1       25.66 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
     29.20 ±  8%      -4.1       25.10 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter
     29.59 ±  8%      -4.1       25.50 ±  7%  perf-profile.children.cycles-pp.cpuidle_idle_call
     29.19 ±  8%      -4.1       25.10 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
     26.26 ±  8%      -4.0       22.28 ±  8%  perf-profile.children.cycles-pp.intel_idle_ibrs
     12.26 ±  3%      -1.4       10.84 ±  3%  perf-profile.children.cycles-pp.down_read
      1.89 ± 12%      -0.3        1.62 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.23 ±  7%      -0.1        0.18 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.09 ± 10%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.up_write
      0.16 ± 14%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.sync_fs_one_sb
      0.36 ±  7%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.47 ±  7%      +0.1        0.55 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.38 ± 11%      +0.1        0.47 ±  6%  perf-profile.children.cycles-pp.mutex_lock
      0.46 ±  9%      +0.1        0.56 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      1.24 ±  5%      +0.2        1.44 ±  5%  perf-profile.children.cycles-pp.sync_inodes_sb
      0.00            +0.2        0.22 ± 13%  perf-profile.children.cycles-pp.osq_lock
      0.44 ± 10%      +0.2        0.66 ±  7%  perf-profile.children.cycles-pp.mutex_unlock
      2.51 ±  6%      +0.3        2.77 ±  6%  perf-profile.children.cycles-pp.__entry_text_start
      1.46 ±  8%      +0.3        1.81 ±  6%  perf-profile.children.cycles-pp.up_read
      4.66 ±  4%      +0.6        5.28 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.92 ±  5%      +0.6        5.55 ±  4%  perf-profile.children.cycles-pp.get_nr_inodes
     10.29 ±  5%      +1.2       11.54 ±  4%  perf-profile.children.cycles-pp.get_nr_dirty_inodes
     10.32 ±  5%      +1.3       11.58 ±  4%  perf-profile.children.cycles-pp.writeback_inodes_sb
      0.00            +1.6        1.62 ±  7%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.00            +2.1        2.12 ±  7%  perf-profile.children.cycles-pp.__mutex_lock
      0.25 ± 11%      +6.4        6.63 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.49 ±  9%      +7.0        7.50 ±  6%  perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
     12.65 ±  5%      +8.5       21.16 ±  5%  perf-profile.children.cycles-pp.sync_filesystem
     16.61 ±  5%      +9.2       25.76 ±  4%  perf-profile.children.cycles-pp.__x64_sys_syncfs
      0.86 ± 10%      +9.3       10.19 ±  6%  perf-profile.children.cycles-pp.__flush_workqueue
      0.91 ±  8%      +9.3       10.24 ±  6%  perf-profile.children.cycles-pp.xlog_cil_push_now
      0.97 ±  8%      +9.3       10.30 ±  6%  perf-profile.children.cycles-pp.xlog_cil_force_seq
      1.11 ±  8%      +9.4       10.46 ±  6%  perf-profile.children.cycles-pp.xfs_fs_sync_fs
      1.02 ±  9%      +9.4       10.38 ±  6%  perf-profile.children.cycles-pp.xfs_log_force
     32.30 ±  5%     +11.1       43.37 ±  4%  perf-profile.children.cycles-pp.syncfs
     18.22 ±  3%      -7.0       11.25 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     26.26 ±  8%      -4.0       22.27 ±  8%  perf-profile.self.cycles-pp.intel_idle_ibrs
     11.86 ±  3%      -1.5       10.36 ±  3%  perf-profile.self.cycles-pp.down_read
      3.99 ±  2%      -0.5        3.53 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      1.62 ±  6%      -0.4        1.27 ±  9%  perf-profile.self.cycles-pp.iterate_supers
      0.12 ± 12%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.writeback_inodes_sb
      0.08 ± 13%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.up_write
      0.16 ± 14%      +0.1        0.22 ± 10%  perf-profile.self.cycles-pp.sync_fs_one_sb
      0.39 ±  7%      +0.1        0.46 ±  7%  perf-profile.self.cycles-pp.syncfs
      0.31 ±  8%      +0.1        0.38 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.46 ±  7%      +0.1        0.54 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.34 ± 10%      +0.1        0.43 ±  6%  perf-profile.self.cycles-pp.mutex_lock
      0.30 ± 13%      +0.1        0.39 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.32 ±  7%      +0.1        0.43 ±  6%  perf-profile.self.cycles-pp.sync_filesystem
      0.00            +0.2        0.22 ± 13%  perf-profile.self.cycles-pp.osq_lock
      0.43 ± 10%      +0.2        0.65 ±  7%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.2        0.24 ±  8%  perf-profile.self.cycles-pp.__mutex_lock
      1.40 ±  7%      +0.3        1.72 ±  6%  perf-profile.self.cycles-pp.up_read
      2.99 ±  5%      +0.4        3.36 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.21 ±  5%      +0.5        4.71 ±  5%  perf-profile.self.cycles-pp.get_nr_dirty_inodes
      3.82 ±  4%      +0.5        4.33 ±  5%  perf-profile.self.cycles-pp.get_nr_inodes
      4.48 ±  3%      +0.6        5.11 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.26 ±  6%      +0.6        0.91 ±  7%  perf-profile.self.cycles-pp.flush_workqueue_prep_pwqs
      0.00            +1.6        1.61 ±  7%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.24 ± 11%      +6.3        6.58 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

