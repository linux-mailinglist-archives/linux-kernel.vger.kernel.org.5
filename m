Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6E7EC4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbjKOOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjKOOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:12:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF117C5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700057522; x=1731593522;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=SX2Nxnt01i0Mby4rGJaejb4L6bmvfGeMZOslOA8/zz8=;
  b=OnvgAy+unJFYkF7gpkvukt1h9GNV5FAaectlOrdwc9AgjvLe2utES26j
   ThsKxiLlYvIza3Xx1vYUEM5wUj5Hkceh0nKDRXYXp+xbZsdjvqG5HPjom
   QvO/fGlnajZ3apuIyWmT0jcp1D2gy4bR0z7lA75ltbAxVOi6jeGuhj/nh
   IcocI6lLl4ZxrbPtX42Zcs9jdVd6MKgU0Tl+RToVBieL5jK+KkokUnoxB
   PszRy3o2+VSG9KdZ/h/MN+0U7sc47K4KuTcui9FBlGMR3VuZms46NimmY
   oek1F9oeEe/DKBFUJcgaKgKb91raOGoptOb45LdGj+yFINd+HhWSIrr47
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3961325"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="3961325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908786561"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="908786561"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 06:12:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 06:12:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 06:12:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 06:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwEqnoHWq7+UWUf1wUUWDpKPfHqbjP/X4lEuDvRrTFnJYXPShpkwfvafupImb34WVtVf1hi/yqO/ibXY4ejOaL5/mi8evMnvH9JOIbksxBdhe4qTNxqlfEWwjXxl/AR0kaiz0ivPGAWkWmZ6NmWfCi6clPD3AePndaUQ8qfm+6mI8GKCX8+Bg5MU9Db39jYxoEpCs2H5sTCv4Z4ylTdsZk8wXzRtcUrHf1fj0RcBz8wv8w5qfssHz3PMsYQIGNMjoxHu7hzbDMZ3n1OKY1lcEMjY1F3ThTyD+tcDGtI6B9bV2g9xnJ9xYPzIZT6tOk9etTSQuxquo0q7SZzwYgK8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtCNRaWsKgrPZRoxPOAuQr8Y1gfbGWpthg3D2yuXStU=;
 b=A5GLgOawl0DmPjTjd5/WHfmhGwViDHNPAvHjM8RXD1Azg7saC6bNd31P5IqbriFEy7LF+9YFOOD+0IfsDBCGZojn8nPpq+CfJx2qqQXSc68lqJitdHzVz4cCqY8L0+3NEladN1S0ErHG6F1hb7Melbg2b2knYOYUIZ+FY6M8lZBjaHeUTjddjd5VR8x/Vjk7pCzO+yqXvl56WM3oOXAkMvzno0F8kFpu4czZKq3tFXI16U8rmmiLpd1hKRTN2sdvgy2H0lqgm5QbyMHFmqBA0om6BZKrq2xnp2HgW3IjPlbHDVuFGIJ+inwarcS4HwpAoJPFaFvmEETcrNcmTq4r6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 14:11:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 14:11:56 +0000
Date:   Wed, 15 Nov 2023 22:11:48 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  4ed4379881:  will-it-scale.per_thread_ops
 122.2% improvement
Message-ID: <202311151610.43a1e565-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d6af24-ce30-46cc-9cf8-08dbe5e4d31b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: db6T2n43D1SOqvWPW1bII0uQLoeRWny1WrP2eaIUW9h+1YdjHDgBatA9uPrxYhWSxvP+YoQcnK4fYm1V30hkirxrYrnbzSQmqIatddQAjRgr7Ty3gRM9TROCHyJ23NMuZOQFiKmIrzR84L+ELyqNEp2ewlLGctBNOy+8giXEH6YG3xYF8gqGnWZWP009qUbxZpQZ/thswD87So82W4eEmrCjIUkFWe5HiJjt9hBKEVdRZXyrdgWXEKFOMJohbam119+SoxBSm1ovMXB94QvITZOrhoBrrkb3hmhN7uiWrWek9tKrcZQBqquwluSx9P/xJd95Z0vY3up0KD7ikaL4eCT7Aje051/HU9PR/FtUptkRqnmNiHmn2BNgPpYTvsFJw5vBO9i4FKBvqRFXR3sUfd+t6l6g2SH2xf3dmOvorBed+m7uMiO80cqsJPpuW6cUAkAMcEYRxo9WgK0Z7EOT14KhaJvdQEhevrozRGDdFlKVhuESsPZx9eNsMD2wnv8Ur3o9GYwJuqBABMaeqsoEkTnu0BWgBL+jbjQi4Fdep3rQBSJedpSxm9jt7xkmacI3Z7IjnLH5tykBodPE0B1DRiCqY5YlpJPLPj4DVW9JEP0Q35FEWH6dVfL8vTPCTJUiRz1yWyDHsNyZbRN3C5Z19Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(230373577357003)(230473577357003)(1800799009)(451199024)(64100799003)(186009)(966005)(6486002)(478600001)(2906002)(6506007)(2616005)(6512007)(6666004)(86362001)(5660300002)(6916009)(316002)(54906003)(30864003)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(38100700002)(83380400001)(41300700001)(26005)(82960400001)(1076003)(107886003)(36756003)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CRB+z1W2/LooUtaoRsxFSEINFdCV2qGl9d7xQaSYvt/uqg7u+lstbM/w3P?=
 =?iso-8859-1?Q?PXBNoy7SrECsaxgUZMZZY0Hlh7JK1i+Lb6r7Yc8k9b7XVyB+GbWFHdhfmV?=
 =?iso-8859-1?Q?oFa2y7nqEilw1Y6QLmY4siw1AZer2qujHUgRHGhspePGAwHT8EZR05yk4s?=
 =?iso-8859-1?Q?HSK5Mpfi58ZFFTdCGLl1TJU08jX/GkkkaYGjkgF7kjN2ml3l4I49KdH+k+?=
 =?iso-8859-1?Q?Kicc5doasidg1Led4EWG/x06TJwGUer+bolWkai0uli6ZOnHB07eYT/3Av?=
 =?iso-8859-1?Q?s9CiNhYij44mLCgAAnIUWWPwb5xf7cGQzU7RVygzeVSjud50Xk9/0+y0Da?=
 =?iso-8859-1?Q?msoO8XCoJhr199nXrXYj7i2C3+XI+O04lEz1TbWnSPl1qSYP1kZHH1r7jS?=
 =?iso-8859-1?Q?HcX6bRg3iDsjB+mL/umL2X7o/f2oSL8J7A/c4/pJWTlK/DsB7LDhNWMxLC?=
 =?iso-8859-1?Q?58GySsQfGgNdLhJHuNkL+0v5KJICp/WYubgrF1GQsSL1AWIsebxPLUYZfU?=
 =?iso-8859-1?Q?n4y9H4zyXUoxlHNG+RGKJiRQ+KiLjxOWmoCZxdfotMjyS9oRxzQG+qAmME?=
 =?iso-8859-1?Q?98FsOTnrXxtMKa6glJjkGkAiy0l3AHVwGJHE7iLdyToRS/A0U5AFeDgB15?=
 =?iso-8859-1?Q?HuT3vIcTKnQ2aC5xvwcpo+Q1oTN1oSa77KKXONPAIbgM42KcUATU78gKZt?=
 =?iso-8859-1?Q?ScGe6uI51npNGhA1cUAwxTC6QcFmu5qnfxSL5E3AIMcvq5HRCblORaqBCT?=
 =?iso-8859-1?Q?DCTshyTzeh9OnPdp0AE/ypI7C/XUC6IWfRUw8VdAmSSw5A55azEHAwPLYh?=
 =?iso-8859-1?Q?Ylu1WoICG1qze7y6PJJzXEqXHAFBjqaTfu5CBP2RzshpXPVZ2L7XU/LVuj?=
 =?iso-8859-1?Q?wSnPV1+siu2p8rdBjW8G6nFRGj2buBfMSByoI3G5fa3Oe22fWQP8i+jCAp?=
 =?iso-8859-1?Q?KNl5YvzKwuXCPlpDpYY7lg+NhoSQNKy2UNuB39r3RnFXRgPAfC2vvbQFxK?=
 =?iso-8859-1?Q?zOghuEWRh69iRvZ3Fv6YYGAcdDdK/E1S7AKAtfZbFxPkENWyII3sn1Ijiu?=
 =?iso-8859-1?Q?f5TPrJd+oOLWaQ3sBon17S8FTCKAc2y1mmPJhdaQmf1ClNWJnmx3gacfC3?=
 =?iso-8859-1?Q?801xgYBLizaecw2BmvEA9NsE/UFPx+S5rICqXHU00CKCo1h6wVqPL5Yl+u?=
 =?iso-8859-1?Q?/T83hG3nug7yhHO6tx/boFX4ttjmJ5WDLUz5/PKX6TSIUTFkMVn3/VTtoy?=
 =?iso-8859-1?Q?eYTPUtdoNHiQMpZ9C1fRkuzJZSOfc36R/eRhbesDtJxvR5lzS6fHceRarq?=
 =?iso-8859-1?Q?QTgQl28cPWbiMdei4kq5qTTK/u+bkz7Fa7TmJPztWDXjoxccsj/zPAgLH5?=
 =?iso-8859-1?Q?pSkUpFlk/xRoy4iNhW8K6n9LxLKQmfx2raFaZBjsnFvz2TkhBdOGQlIfzL?=
 =?iso-8859-1?Q?CDQvcLonf0kXXzKWTgjuCDbdOe9DXhvByPsqszQy7KQsMIs7YDmwCfw0N1?=
 =?iso-8859-1?Q?fp7wYAMbLirMopLzSCXrJuaeJlTNqkKDpB653MryVTRJEXVh0UblZ/eXyE?=
 =?iso-8859-1?Q?rSbgbsEJs0MWGd77AXtB/PvfQl0VZ2YC4BWCHdUXjkpCBgCJ9dXo7y4a4m?=
 =?iso-8859-1?Q?QzHCq3I+pF/HNRJCngjCbOpl8XLvyZyoo+Yobj9HwagBgPIWRy/bgisw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d6af24-ce30-46cc-9cf8-08dbe5e4d31b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:11:56.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eflkzjhXh7ar5kfRrbFYHRTTZuLi2TnUirSuqKlt8zf+3dEHP/igMPKGp+S8S5h4BJHU+k/8IKIvfOVtExWDlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 122.2% improvement of will-it-scale.per_thread_ops on:


commit: 4ed4379881aa62588aba6442a9f362a8cf7624e6 ("mm: handle shared faults under the VMA lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 16
	mode: thread
	test: page_fault3
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 7.8% improvement                                   |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | mode=process                                                                                    |
|                  | nr_task=16                                                                                      |
|                  | test=page_fault3                                                                                |
+------------------+-------------------------------------------------------------------------------------------------+



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231115/202311151610.43a1e565-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/page_fault3/will-it-scale

commit: 
  164b06f238 ("mm: call wp_page_copy() under the VMA lock")
  4ed4379881 ("mm: handle shared faults under the VMA lock")

164b06f238b98631 4ed4379881aa62588aba6442a9f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    150146 ± 13%     +19.7%     179652 ±  7%  numa-meminfo.node0.Slab
     32317 ±  5%      -5.6%      30493        uptime.idle
     11.42 ±  2%      -1.2       10.22 ±  2%  mpstat.cpu.all.sys%
      1.86 ±  3%      +2.3        4.14        mpstat.cpu.all.usr%
   2648761           +89.3%    5013662        numa-numastat.node0.local_node
   2696913 ±  2%     +88.3%    5077488        numa-numastat.node0.numa_hit
   2696747 ±  2%     +88.3%    5077459        numa-vmstat.node0.numa_hit
   2648596           +89.3%    5013633        numa-vmstat.node0.numa_local
    107.33 ± 14%     +72.8%     185.50 ± 11%  perf-c2c.DRAM.local
      2752 ± 12%     -39.0%       1678 ± 15%  perf-c2c.HITM.local
      6748 ±  2%     -59.5%       2730        vmstat.system.cs
    175383           +76.1%     308919        vmstat.system.in
   3301453          +122.2%    7336336        will-it-scale.16.threads
     84.29            -1.1%      83.34        will-it-scale.16.threads_idle
    206340          +122.2%     458520        will-it-scale.per_thread_ops
   3301453          +122.2%    7336336        will-it-scale.workload
    263502 ±  2%      +4.7%     275788        proc-vmstat.nr_mapped
   3322833           +72.3%    5723978        proc-vmstat.numa_hit
   3215175           +74.7%    5616311        proc-vmstat.numa_local
   3408340           +70.6%    5814446        proc-vmstat.pgalloc_normal
 9.943e+08          +122.1%  2.208e+09        proc-vmstat.pgfault
   3359696           +71.6%    5765300        proc-vmstat.pgfree
   1102135 ±  9%     +19.8%    1320904 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.max
   1102135 ±  9%     +19.8%    1320904 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
    862.58 ±  3%     +13.3%     976.92 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    862.44 ±  3%     +13.2%     976.50 ±  6%  sched_debug.cfs_rq:/.util_avg.max
    286.93 ±  6%     +12.1%     321.76 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    202058 ±  8%     -35.9%     129538 ±  3%  sched_debug.cpu.avg_idle.stddev
     11549 ±  6%     -49.0%       5886        sched_debug.cpu.nr_switches.avg
     13882 ±  9%     -36.2%       8854 ± 11%  sched_debug.cpu.nr_switches.stddev
    450048 ±  4%     -92.1%      35653 ±  4%  turbostat.C1
      0.40 ±  5%      -0.4        0.02 ± 28%  turbostat.C1%
    986845           -75.4%     242529 ±  6%  turbostat.C1E
      1.07 ±  4%      -0.8        0.30 ± 12%  turbostat.C1E%
      0.08 ±  5%     +62.0%       0.14 ±  3%  turbostat.IPC
  76389757          +106.4%  1.577e+08        turbostat.IRQ
    218.21            +6.4%     232.07        turbostat.PkgWatt
     20.26            +2.6%      20.79        turbostat.RAMWatt
      0.01 ±145%     -94.2%       0.00 ±111%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.00 ±  9%     -78.3%       0.00 ± 82%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ±  9%     -73.9%       0.00 ± 57%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ± 14%     -87.5%       0.00 ± 99%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.02 ±164%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    167.10 ±223%    +200.2%     501.66 ± 99%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.03 ±160%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     12.57 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
      0.01 ± 23%     -54.1%       0.01 ± 67%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     47.80 ±  2%    +123.9%     107.01 ±  3%  perf-sched.total_wait_and_delay.average.ms
     18466 ±  2%     -55.7%       8181 ±  3%  perf-sched.total_wait_and_delay.count.ms
     47.77 ±  2%    +123.6%     106.82 ±  3%  perf-sched.total_wait_time.average.ms
      2.79 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.69 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
      0.82 ± 10%    +125.0%       1.85 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.12 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
    143.67 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     11285 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    971.50 ±  2%    +117.6%       2114 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    279.17 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      4.85 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     13.27 ± 47%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
      5.25 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     33.35 ± 14%     -85.5%       4.84 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.77 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.68 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
      0.81 ±  9%    +127.0%       1.84 ± 14%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      4.84 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      4.27          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
     32.32 ± 18%     -85.1%       4.83 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
 2.627e+09 ±  3%     +73.7%  4.562e+09        perf-stat.i.branch-instructions
      1.17 ± 29%      -0.3        0.89 ± 20%  perf-stat.i.branch-miss-rate%
  23408547 ±  2%     +49.2%   34925457        perf-stat.i.branch-misses
      5.77 ± 22%      +3.2        9.00 ± 17%  perf-stat.i.cache-miss-rate%
   8222112 ±  2%     +64.8%   13546123        perf-stat.i.cache-misses
      6727 ±  2%     -60.5%       2660        perf-stat.i.context-switches
      3.50 ±  5%     -38.4%       2.15 ±  5%  perf-stat.i.cpi
  4.18e+10 ±  2%      +7.6%  4.497e+10        perf-stat.i.cpu-cycles
      5076 ±  2%     -34.6%       3320        perf-stat.i.cycles-between-cache-misses
   7634922          +121.9%   16944094        perf-stat.i.dTLB-load-misses
 3.135e+09 ±  3%     +78.2%  5.587e+09        perf-stat.i.dTLB-loads
      5.14 ±  2%      +1.4        6.57        perf-stat.i.dTLB-store-miss-rate%
  94623040 ±  3%    +128.1%  2.158e+08        perf-stat.i.dTLB-store-misses
 1.713e+09 ±  3%     +77.4%  3.039e+09        perf-stat.i.dTLB-stores
     82.69            +4.3       87.04        perf-stat.i.iTLB-load-miss-rate%
   4833304 ±  3%    +121.4%   10702487 ±  3%  perf-stat.i.iTLB-load-misses
    996162           +57.1%    1564855        perf-stat.i.iTLB-loads
 1.251e+10 ±  3%     +73.2%  2.167e+10        perf-stat.i.instructions
      2571 ±  2%     -21.0%       2030 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.30 ±  2%     +62.0%       0.48        perf-stat.i.ipc
      0.40 ±  2%      +7.6%       0.43        perf-stat.i.metric.GHz
      1068 ±  2%     -75.6%     260.15 ± 10%  perf-stat.i.metric.K/sec
     73.25 ±  3%     +77.9%     130.33        perf-stat.i.metric.M/sec
   3223417 ±  3%    +124.8%    7247446        perf-stat.i.minor-faults
     26.42 ±  7%     -10.4       16.06 ±  3%  perf-stat.i.node-load-miss-rate%
    282161 ±  5%     +98.6%     560500 ±  7%  perf-stat.i.node-loads
   3248470 ±  3%    +124.2%    7282664        perf-stat.i.node-stores
   3223417 ±  3%    +124.8%    7247446        perf-stat.i.page-faults
      0.66            -4.9%       0.62        perf-stat.overall.MPKI
      0.89            -0.1        0.77        perf-stat.overall.branch-miss-rate%
      5.72 ± 22%      +3.2        8.95 ± 17%  perf-stat.overall.cache-miss-rate%
      3.34           -37.9%       2.07        perf-stat.overall.cpi
      5085 ±  2%     -34.7%       3319        perf-stat.overall.cycles-between-cache-misses
      0.24            +0.1        0.30        perf-stat.overall.dTLB-load-miss-rate%
      5.24            +1.4        6.63        perf-stat.overall.dTLB-store-miss-rate%
     82.90            +4.3       87.23        perf-stat.overall.iTLB-load-miss-rate%
      2589           -21.7%       2027 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.30           +61.0%       0.48        perf-stat.overall.ipc
     25.70 ±  4%     -10.0       15.74 ±  7%  perf-stat.overall.node-load-miss-rate%
      0.63 ± 13%      -0.3        0.30 ±  7%  perf-stat.overall.node-store-miss-rate%
   1168062           -23.0%     899539        perf-stat.overall.path-length
 2.618e+09 ±  3%     +73.6%  4.547e+09        perf-stat.ps.branch-instructions
  23334434 ±  2%     +49.2%   34805568        perf-stat.ps.branch-misses
   8195263 ±  2%     +64.8%   13501705        perf-stat.ps.cache-misses
      6706 ±  2%     -60.5%       2651        perf-stat.ps.context-switches
 4.167e+10 ±  2%      +7.6%  4.482e+10        perf-stat.ps.cpu-cycles
   7610946          +121.9%   16890018        perf-stat.ps.dTLB-load-misses
 3.125e+09 ±  3%     +78.2%  5.569e+09        perf-stat.ps.dTLB-loads
  94332447 ±  3%    +128.1%  2.151e+08        perf-stat.ps.dTLB-store-misses
 1.707e+09 ±  3%     +77.4%  3.029e+09        perf-stat.ps.dTLB-stores
   4818281 ±  3%    +121.4%   10668153 ±  3%  perf-stat.ps.iTLB-load-misses
    993104           +57.1%    1559797        perf-stat.ps.iTLB-loads
 1.248e+10 ±  3%     +73.2%   2.16e+10        perf-stat.ps.instructions
   3213492 ±  3%    +124.8%    7224439        perf-stat.ps.minor-faults
    281299 ±  5%     +98.6%     558721 ±  7%  perf-stat.ps.node-loads
   3238382 ±  3%    +124.2%    7259432        perf-stat.ps.node-stores
   3213492 ±  3%    +124.8%    7224439        perf-stat.ps.page-faults
 3.856e+12           +71.1%  6.599e+12        perf-stat.total.instructions
     46.83 ±  2%     -24.6       22.23 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     47.07 ±  2%     -24.4       22.68 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     16.08 ±  6%     -16.1        0.00        perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     14.24 ±  2%     -14.2        0.00        perf-profile.calltrace.cycles-pp.down_read_trylock.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     62.50            -7.9       54.60 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     63.71            -6.9       56.82 ±  2%  perf-profile.calltrace.cycles-pp.testcase
      6.62            -6.6        0.00        perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     18.65            -6.2       12.49 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     20.30            -5.0       15.35 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.34 ±  6%      -0.2        1.17 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.24 ±  6%      -0.2        1.07 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.84 ±  7%      -0.1        0.72 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.82 ±  7%      -0.1        0.71 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.66 ±  7%      -0.1        0.59 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.xas_descend.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range
      0.00            +0.6        0.56 ±  7%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.fault_dirty_shared_page.do_fault.__handle_mm_fault
      0.58 ±  4%      +0.6        1.22 ±  2%  perf-profile.calltrace.cycles-pp.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault
      0.35 ± 70%      +0.6        0.99 ±  3%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.00            +0.7        0.66 ±  5%  perf-profile.calltrace.cycles-pp.file_update_time.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.7        0.66 ± 13%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault.do_fault
      0.64 ±  3%      +0.7        1.35 ±  3%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.67 ±  4%      +0.7        1.39 ±  2%  perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.35 ± 70%      +0.7        1.06 ±  4%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.36 ± 71%      +0.8        1.15 ±  6%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.84 ±  4%      +0.8        1.67 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.19 ±141%      +0.9        1.06 ±  8%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.00            +0.9        0.90 ±  3%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.82 ± 11%      +1.0        1.80 ±  4%  perf-profile.calltrace.cycles-pp.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.21 ±  2%      +1.2        2.41 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      1.32 ± 11%      +1.2        2.52 ±  6%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.48 ±  2%      +1.4        2.88 ±  2%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.41 ±  2%      +1.5        2.87 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      1.56 ±  3%      +1.5        3.03 ±  2%  perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.65 ±  7%      +1.6        4.30 ±  8%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.79 ±  8%      +1.7        3.50 ±  4%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.11 ±  4%      +2.3        4.46 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      2.15 ±  4%      +2.4        4.54 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.16 ±  5%      +2.4        4.56 ±  3%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.16 ±  5%      +2.4        4.57 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.16 ±  5%      +2.4        4.57 ±  3%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.calltrace.cycles-pp.__munmap
      3.17 ±  2%      +3.2        6.36 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      3.62 ±  3%      +3.8        7.43 ±  2%  perf-profile.calltrace.cycles-pp.error_entry.testcase
      4.88 ±  3%      +3.9        8.80 ±  2%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.70 ±  3%      +4.0        7.66 ±  2%  perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
     46.92 ±  2%     -24.6       22.36 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
     47.10 ±  2%     -24.4       22.72 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
     16.11 ±  6%     -16.1        0.00        perf-profile.children.cycles-pp.lock_mm_and_find_vma
     14.41 ±  2%     -14.1        0.31 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
     57.26           -13.7       43.60 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      7.06            -6.8        0.30 ±  3%  perf-profile.children.cycles-pp.up_read
     18.72            -6.2       12.56 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
     20.36            -4.9       15.45 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     67.14            -3.0       64.11 ±  2%  perf-profile.children.cycles-pp.testcase
      1.58 ±  5%      -0.2        1.39 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.43 ±  5%      -0.2        1.27 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.98 ±  5%      -0.1        0.88 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.00 ±  5%      -0.1        0.90 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.09 ± 21%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.intel_idle
      0.20 ± 10%      -0.0        0.16 ±  9%  perf-profile.children.cycles-pp.__do_softirq
      0.15 ±  7%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.access_error
      0.06 ± 13%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.irqentry_enter
      0.59 ±  2%      +0.1        0.64 ±  4%  perf-profile.children.cycles-pp.mtree_range_walk
      0.04 ± 45%      +0.1        0.10 ±  6%  perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.06 ± 14%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.folio_mapping
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.pte_mkwrite
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.vm_normal_page
      0.15 ± 10%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.__pte_offset_map
      0.06 ±  7%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.perf_exclude_event
      0.09 ± 12%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.error_return
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.09 ±  9%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.free_swap_cache
      0.08 ±  4%      +0.1        0.17 ± 10%  perf-profile.children.cycles-pp.xas_start
      0.10 ± 26%      +0.1        0.19 ± 19%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.09 ± 10%      +0.1        0.18 ± 12%  perf-profile.children.cycles-pp.__count_memcg_events
      0.09 ±  6%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.timestamp_truncate
      0.10 ±  9%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.03 ±100%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.06 ± 19%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      0.08 ± 13%      +0.1        0.20 ± 16%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ± 10%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.flush_tlb_func
      0.14 ± 11%      +0.2        0.29 ±  4%  perf-profile.children.cycles-pp.release_pages
      0.21 ±  2%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.15 ± 10%      +0.2        0.31 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.11 ± 10%      +0.2        0.28 ±  5%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.15 ±  5%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp._compound_head
      0.01 ±223%      +0.2        0.20 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.11 ±  9%      +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.19 ±  3%      +0.2        0.40 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.13 ± 11%      +0.2        0.34 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.12 ± 11%      +0.2        0.34 ±  5%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.12 ± 11%      +0.2        0.34 ±  5%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.22 ± 13%      +0.2        0.44 ±  3%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.14 ±  9%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function
      0.19 ± 19%      +0.2        0.44 ± 12%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.25 ±  6%      +0.3        0.50 ±  4%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.29 ±  7%      +0.3        0.55 ±  2%  perf-profile.children.cycles-pp.xas_descend
      0.28 ± 13%      +0.3        0.57 ±  7%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.26 ± 17%      +0.3        0.58 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.34 ± 10%      +0.3        0.67 ±  5%  perf-profile.children.cycles-pp.file_update_time
      0.27 ± 10%      +0.3        0.60 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.36 ±  2%      +0.4        0.72 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.24 ±  6%      +0.4        0.66 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.53 ±  5%      +0.5        1.04 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.47 ± 16%      +0.6        1.08 ±  8%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.59 ±  4%      +0.6        1.23 ±  2%  perf-profile.children.cycles-pp.page_remove_rmap
      0.60 ± 11%      +0.7        1.30 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.67 ±  4%      +0.7        1.40 ±  2%  perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.84 ±  3%      +0.8        1.68 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.84 ± 10%      +1.0        1.84 ±  4%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.94 ±  2%      +1.1        2.00 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      1.22 ±  2%      +1.2        2.43 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      1.33 ± 12%      +1.2        2.54 ±  6%  perf-profile.children.cycles-pp.set_pte_range
      1.18 ±  4%      +1.3        2.51 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      1.48 ±  2%      +1.4        2.90 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      1.56 ±  3%      +1.5        3.03 ±  2%  perf-profile.children.cycles-pp.__do_fault
      1.46 ±  2%      +1.5        2.98 ±  2%  perf-profile.children.cycles-pp.sync_regs
      2.66 ±  7%      +1.7        4.31 ±  8%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.82 ±  8%      +1.7        3.56 ±  4%  perf-profile.children.cycles-pp.finish_fault
      1.98 ±  2%      +2.0        4.00 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.29 ±  5%      +2.4        4.68 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.28 ±  5%      +2.4        4.68 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      2.15 ±  4%      +2.4        4.55 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      2.17 ±  4%      +2.4        4.57 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.17 ±  4%      +2.4        4.57 ±  3%  perf-profile.children.cycles-pp.do_vmi_munmap
      2.16 ±  5%      +2.4        4.56 ±  3%  perf-profile.children.cycles-pp.unmap_region
      2.18 ±  4%      +2.4        4.58 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
      2.18 ±  5%      +2.4        4.58 ±  3%  perf-profile.children.cycles-pp.__munmap
      3.23 ±  2%      +3.3        6.52 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      3.67 ±  3%      +3.8        7.51 ±  2%  perf-profile.children.cycles-pp.error_entry
      4.93 ±  3%      +4.0        8.89 ±  2%  perf-profile.children.cycles-pp.do_fault
      3.71 ±  3%      +4.0        7.66 ±  2%  perf-profile.children.cycles-pp.__irqentry_text_end
     14.34 ±  2%     -14.0        0.31 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
     13.36 ±  3%     -10.0        3.32 ±  5%  perf-profile.self.cycles-pp.__handle_mm_fault
      7.01            -6.7        0.30 ±  3%  perf-profile.self.cycles-pp.up_read
      0.09 ± 21%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.intel_idle
      0.12 ±  5%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.14 ±  4%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.access_error
      0.04 ± 44%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.file_update_time
      0.06 ± 13%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.59 ±  2%      +0.0        0.63 ±  4%  perf-profile.self.cycles-pp.mtree_range_walk
      0.03 ±100%      +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.__do_fault
      0.04 ± 45%      +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.perf_swevent_event
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.flush_tlb_func
      0.05 ±  7%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.irqentry_enter
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.pte_mkwrite
      0.05 ± 45%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.folio_mapping
      0.14 ± 10%      +0.1        0.20 ±  8%  perf-profile.self.cycles-pp.__pte_offset_map
      0.06 ± 11%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.error_return
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.vm_normal_page
      0.06 ± 11%      +0.1        0.14 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.08 ±  8%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.free_swap_cache
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.08 ±  6%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.xas_start
      0.10 ± 26%      +0.1        0.18 ± 20%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.09 ±  9%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.tlb_flush_rmaps
      0.08 ±  5%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ± 14%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.06 ± 19%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      0.03 ±100%      +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.08 ± 12%      +0.1        0.19 ± 17%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.10 ±  4%      +0.1        0.23 ±  7%  perf-profile.self.cycles-pp._compound_head
      0.13 ±  7%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.exc_page_fault
      0.13 ±  5%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.14 ± 10%      +0.1        0.28 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.14 ±  4%      +0.1        0.29 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.12 ±  7%      +0.1        0.27 ±  4%  perf-profile.self.cycles-pp.finish_fault
      0.14 ±  9%      +0.2        0.29 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.21 ±  2%      +0.2        0.37 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.16 ± 14%      +0.2        0.32 ±  5%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.17 ±  9%      +0.2        0.34 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.18 ±  8%      +0.2        0.36 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.15 ± 15%      +0.2        0.33 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.27 ± 11%      +0.2        0.45 ±  8%  perf-profile.self.cycles-pp.do_fault
      0.00            +0.2        0.18 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.27 ±  3%      +0.2        0.47 ±  6%  perf-profile.self.cycles-pp.shmem_fault
      0.16 ± 18%      +0.2        0.38 ±  8%  perf-profile.self.cycles-pp.fault_dirty_shared_page
      0.18 ±  6%      +0.2        0.40 ±  5%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.19 ± 20%      +0.2        0.42 ± 14%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.27 ±  7%      +0.2        0.51 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.24 ± 12%      +0.3        0.51 ±  9%  perf-profile.self.cycles-pp.__perf_sw_event
      0.34 ±  4%      +0.3        0.61 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.25 ±  9%      +0.3        0.58 ±  4%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.28 ±  5%      +0.3        0.60 ±  5%  perf-profile.self.cycles-pp.set_pte_range
      0.28 ±  5%      +0.3        0.60 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.34 ±  4%      +0.3        0.66 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.32 ±  3%      +0.3        0.65 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.66 ±  5%      +0.7        1.39 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.82 ±  3%      +0.9        1.76 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      1.46 ±  2%      +1.5        2.98 ±  2%  perf-profile.self.cycles-pp.sync_regs
      1.97 ±  2%      +2.0        3.99 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      3.20 ±  2%      +3.1        6.33 ±  2%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      3.65 ±  3%      +3.8        7.47 ±  2%  perf-profile.self.cycles-pp.error_entry
      3.71 ±  3%      +4.0        7.66 ±  2%  perf-profile.self.cycles-pp.__irqentry_text_end
      5.82 ±  2%      +6.4       12.22 ±  2%  perf-profile.self.cycles-pp.testcase


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/16/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/page_fault3/will-it-scale

commit: 
  164b06f238 ("mm: call wp_page_copy() under the VMA lock")
  4ed4379881 ("mm: handle shared faults under the VMA lock")

164b06f238b98631 4ed4379881aa62588aba6442a9f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3.93 ±  9%      +0.6        4.48 ±  3%  mpstat.cpu.all.usr%
     69443 ± 37%     -43.5%      39209 ± 52%  numa-numastat.node0.other_node
     69443 ± 37%     -43.5%      39209 ± 52%  numa-vmstat.node0.numa_other
    815.58 ±  4%     -13.9%     702.42 ±  6%  sched_debug.cpu.nr_switches.min
      0.17           -11.8%       0.15        turbostat.IPC
   7829312            +7.8%    8442054        will-it-scale.16.processes
    489331            +7.8%     527628        will-it-scale.per_process_ops
   7829312            +7.8%    8442054        will-it-scale.workload
   6054588            +5.6%    6393936        proc-vmstat.numa_hit
   5946949            +5.7%    6286318        proc-vmstat.numa_local
   6138630            +5.6%    6479594        proc-vmstat.pgalloc_normal
 2.356e+09            +7.8%  2.541e+09        proc-vmstat.pgfault
   6094218            +5.6%    6435293        proc-vmstat.pgfree
  33370577 ±  5%      +8.1%   36086535 ±  2%  perf-stat.i.branch-misses
  13591855 ±  6%      +9.3%   14849901 ±  3%  perf-stat.i.cache-misses
  87506837            +2.6%   89773400        perf-stat.i.cache-references
   9248232 ±  6%     +10.3%   10201074 ±  3%  perf-stat.i.dTLB-load-misses
      4.89 ±  8%      +1.4        6.25 ±  3%  perf-stat.i.dTLB-store-miss-rate%
 2.039e+08 ±  9%     +14.0%  2.324e+08 ±  3%  perf-stat.i.dTLB-store-misses
      2165 ±  5%     -18.8%       1758 ±  7%  perf-stat.i.instructions-per-iTLB-miss
   7100967 ±  9%     +13.9%    8087600 ±  3%  perf-stat.i.minor-faults
   7137308 ±  9%     +13.9%    8128127 ±  3%  perf-stat.i.node-stores
   7100971 ±  9%     +13.9%    8087600 ±  3%  perf-stat.i.page-faults
      0.51 ±  3%     +21.1%       0.62        perf-stat.overall.MPKI
      0.60 ±  4%      +0.1        0.72        perf-stat.overall.branch-miss-rate%
      1.64           +16.4%       1.91        perf-stat.overall.cpi
      0.14 ±  3%      +0.0        0.17        perf-stat.overall.dTLB-load-miss-rate%
      5.33            +1.2        6.49        perf-stat.overall.dTLB-store-miss-rate%
      2276 ±  5%     -21.9%       1779 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.61           -14.1%       0.52        perf-stat.overall.ipc
   1126412           -20.9%     890493        perf-stat.overall.path-length
  33278957 ±  4%      +8.1%   35982000 ±  2%  perf-stat.ps.branch-misses
  13557468 ±  6%      +9.2%   14806522 ±  3%  perf-stat.ps.cache-misses
  87230707            +2.6%   89485467        perf-stat.ps.cache-references
   9225940 ±  6%     +10.3%   10171834 ±  3%  perf-stat.ps.dTLB-load-misses
 2.035e+08 ±  9%     +13.9%  2.318e+08 ±  3%  perf-stat.ps.dTLB-store-misses
   7085678 ±  9%     +13.8%    8065196 ±  3%  perf-stat.ps.minor-faults
   7121860 ±  9%     +13.8%    8105529 ±  3%  perf-stat.ps.node-stores
   7085683 ±  9%     +13.8%    8065196 ±  3%  perf-stat.ps.page-faults
 8.819e+12           -14.8%  7.518e+12        perf-stat.total.instructions
     23.48 ±  2%      -3.4       20.08        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     22.94 ±  2%      -3.3       19.65        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     16.46 ±  2%      -1.6       14.84        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     12.98 ±  2%      -1.1       11.92        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.58 ±  2%      +0.0        0.62        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range
      0.59 ±  6%      +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.xas_descend.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault
      0.53 ±  4%      +0.1        0.59 ±  3%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.fault_dirty_shared_page.do_fault.__handle_mm_fault
      1.08 ±  2%      +0.1        1.14 ±  3%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.64 ±  4%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.file_update_time.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault
      1.05 ±  4%      +0.1        1.12        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.76 ±  4%      +0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_file_rmap_range.set_pte_range.finish_fault.do_fault
      0.92 ±  2%      +0.1        1.01        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.34 ±  3%      +0.1        1.43 ±  3%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.71 ±  2%      +0.1        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.99 ±  3%      +0.1        1.09        perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.22 ±  2%      +0.1        1.34        perf-profile.calltrace.cycles-pp.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      1.24 ±  2%      +0.1        1.36        perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.40 ±  2%      +0.1        1.53        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.17 ±  4%      +0.1        1.30 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      1.76 ±  3%      +0.1        1.89        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      1.93 ±  3%      +0.2        2.10        perf-profile.calltrace.cycles-pp.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.52 ±  2%      +0.2        2.72        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      0.34 ± 70%      +0.2        0.55 ±  3%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.30 ±  2%      +0.2        2.51 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.86 ±  3%      +0.2        2.08        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      3.02 ±  2%      +0.2        3.26        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      3.31 ±  2%      +0.2        3.56        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.14 ±  2%      +0.2        3.40        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.32            +0.3        3.62 ±  2%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.22 ±  2%      +0.4        4.60        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      9.50 ±  2%      +0.4        9.88        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      4.30 ±  2%      +0.4        4.70        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      4.30 ±  2%      +0.4        4.70        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      4.30 ±  2%      +0.4        4.70        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.__munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      6.61 ±  2%      +0.6        7.21 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      7.67 ±  2%      +0.7        8.39        perf-profile.calltrace.cycles-pp.error_entry.testcase
      7.80 ±  2%      +0.8        8.57        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
     23.14 ±  2%      -3.4       19.72        perf-profile.children.cycles-pp.do_user_addr_fault
     23.52 ±  2%      -3.4       20.12        perf-profile.children.cycles-pp.exc_page_fault
     16.58 ±  2%      -1.6       14.99        perf-profile.children.cycles-pp.handle_mm_fault
     13.06 ±  2%      -1.1       11.97        perf-profile.children.cycles-pp.__handle_mm_fault
      1.38 ±  5%      -0.6        0.75        perf-profile.children.cycles-pp.mtree_range_walk
      1.05 ±  5%      -0.6        0.45 ± 10%  perf-profile.children.cycles-pp.handle_pte_fault
      0.58 ±  5%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.45 ±  3%      -0.3        0.14 ±  7%  perf-profile.children.cycles-pp.access_error
      0.65 ±  2%      -0.3        0.36 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      0.62 ±  5%      -0.3        0.34 ±  4%  perf-profile.children.cycles-pp.up_read
      0.33 ±  4%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.20 ±  4%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.42 ±  3%      +0.0        0.45 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.16 ±  4%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.30 ±  2%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.release_pages
      0.38 ±  5%      +0.0        0.42 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.50 ±  3%      +0.0        0.54 ±  3%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.51 ±  3%      +0.0        0.56 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.35 ±  4%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.60 ±  6%      +0.1        0.66 ±  2%  perf-profile.children.cycles-pp.xas_descend
      0.55 ±  3%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.54 ±  4%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.65 ±  4%      +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.file_update_time
      1.10 ±  4%      +0.1        1.17        perf-profile.children.cycles-pp.xas_load
      0.69 ±  2%      +0.1        0.77 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      1.00 ±  3%      +0.1        1.09        perf-profile.children.cycles-pp.mas_walk
      0.73 ±  2%      +0.1        0.83 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.24 ±  2%      +0.1        1.36        perf-profile.children.cycles-pp.page_remove_rmap
      1.41 ±  2%      +0.1        1.54        perf-profile.children.cycles-pp.tlb_flush_rmaps
      1.18 ±  4%      +0.1        1.31 ±  3%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      1.77 ±  3%      +0.1        1.90        perf-profile.children.cycles-pp.filemap_get_entry
      1.43 ±  3%      +0.1        1.57 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.03            +0.2        2.19        perf-profile.children.cycles-pp.___perf_sw_event
      1.97 ±  3%      +0.2        2.14        perf-profile.children.cycles-pp.fault_dirty_shared_page
      2.54 ±  2%      +0.2        2.74        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      2.31 ±  2%      +0.2        2.53 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      2.61 ±  2%      +0.2        2.83        perf-profile.children.cycles-pp.__perf_sw_event
      1.86 ±  3%      +0.2        2.09        perf-profile.children.cycles-pp.lock_vma_under_rcu
      3.33 ±  2%      +0.2        3.57        perf-profile.children.cycles-pp.__do_fault
      3.10 ±  2%      +0.3        3.36 ±  2%  perf-profile.children.cycles-pp.sync_regs
      3.16 ±  2%      +0.3        3.41        perf-profile.children.cycles-pp.shmem_fault
      3.39            +0.3        3.70 ±  2%  perf-profile.children.cycles-pp.finish_fault
      9.64 ±  2%      +0.4        9.99        perf-profile.children.cycles-pp.do_fault
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.__munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.do_vmi_munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.do_vmi_align_munmap
      4.30 ±  2%      +0.4        4.70        perf-profile.children.cycles-pp.unmap_vmas
      4.30 ±  2%      +0.4        4.70        perf-profile.children.cycles-pp.unmap_page_range
      4.30 ±  2%      +0.4        4.70        perf-profile.children.cycles-pp.zap_pmd_range
      4.30 ±  2%      +0.4        4.70        perf-profile.children.cycles-pp.zap_pte_range
      4.40 ±  2%      +0.4        4.80        perf-profile.children.cycles-pp.do_syscall_64
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.__vm_munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.__x64_sys_munmap
      4.32 ±  2%      +0.4        4.71        perf-profile.children.cycles-pp.unmap_region
      4.41 ±  2%      +0.4        4.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.07            +0.4        4.47        perf-profile.children.cycles-pp.native_irq_return_iret
      6.72 ±  2%      +0.6        7.32 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      7.75 ±  2%      +0.7        8.48        perf-profile.children.cycles-pp.error_entry
      7.80 ±  2%      +0.8        8.57        perf-profile.children.cycles-pp.__irqentry_text_end
      2.35 ±  2%      -0.8        1.51 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      1.37 ±  5%      -0.6        0.75        perf-profile.self.cycles-pp.mtree_range_walk
      1.93 ±  5%      -0.6        1.36 ±  5%  perf-profile.self.cycles-pp.handle_mm_fault
      0.63 ±  2%      -0.3        0.36 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
      0.47 ±  6%      -0.3        0.20 ± 17%  perf-profile.self.cycles-pp.handle_pte_fault
      0.90 ±  3%      -0.3        0.64 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.35 ±  7%      -0.2        0.12 ± 11%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.57 ±  5%      -0.2        0.34 ±  4%  perf-profile.self.cycles-pp.up_read
      0.37 ±  4%      -0.2        0.14 ±  7%  perf-profile.self.cycles-pp.access_error
      0.70 ±  3%      -0.1        0.58 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.31 ±  4%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.release_pages
      0.16 ±  4%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.26 ±  4%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.40 ±  4%      +0.0        0.44 ±  4%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.29 ±  3%      +0.0        0.33 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.42 ±  4%      +0.0        0.47 ±  4%  perf-profile.self.cycles-pp.fault_dirty_shared_page
      0.35 ±  3%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.60 ±  3%      +0.1        0.66 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.69 ±  2%      +0.1        0.75 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.52 ±  3%      +0.1        0.58 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.59 ±  5%      +0.1        0.66 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
      0.54 ±  5%      +0.1        0.63 ±  2%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      1.43            +0.1        1.54 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      1.80            +0.1        1.94        perf-profile.self.cycles-pp.___perf_sw_event
      3.10 ±  2%      +0.3        3.36 ±  2%  perf-profile.self.cycles-pp.sync_regs
      4.06            +0.4        4.46        perf-profile.self.cycles-pp.native_irq_return_iret
      6.52 ±  2%      +0.6        7.10 ±  2%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      7.72 ±  2%      +0.7        8.44        perf-profile.self.cycles-pp.error_entry
      7.80 ±  2%      +0.8        8.57        perf-profile.self.cycles-pp.__irqentry_text_end
     12.39            +1.1       13.50        perf-profile.self.cycles-pp.testcase



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

