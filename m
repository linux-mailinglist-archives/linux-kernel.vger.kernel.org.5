Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC39805BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjLEO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345685AbjLEO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:57:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62520CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701788270; x=1733324270;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=LqFHooz6rFevKqML4i2eo7nGmKu8jU/i06cslBYKWSk=;
  b=fWqMjNeJc9zTRxdBW3/lyWIHsZ3ZjoBc05ofq2n5jSQMauN0f1DiI8jF
   2zTgL20E09s03lKjVy0ELLvgRP4Rw7YWz6hVFZt8/bZ+dTYWjgSVGO+Gi
   HRQmvPLZaZ09EEBQ3iXudtvodOrMdUZGQiq4USEHRqqAy2FRva1ZBNbN7
   5/no2drFZnVlc2wQWENfTRi+mRQg7ck7rBEGltPKYKHxlbU4VWEiPaoIr
   RtQe44aCwfWgrRxtMRY2vjJtyfPP/5m25vbNHWwXCfQ3C41sYMWseKjr3
   DmYQ/kRmej+5dJFVKM/ZcCu4PnqJXe+lAtOlfVYFuh2v39Xi7ZvXy1tU2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425061104"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="425061104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1102472001"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1102472001"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 06:57:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:57:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 06:57:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 06:57:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 06:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOrOo/o2y1L6x5NGyTMCLOZltksRZXIMswLkqA1SANSop88if4+d3iLmbBMBDj9q8onmiXIUMWrsFP2S3TUyjy0MARwhwZETD1oYvwoi8DzfZp8TRs1Ypey0DONcFwH80z0eEUlwAYzYiZeNAZuYX7LDB7FBTSQautI2vQOF73Qc2vdlGszD+Dv2F5uoW/lO4uTZiWgQxmX8mRKGYHIhtx5/fzorl9vVvqalYwDLWYdDOJl13VJEioFwBbwqke0rAj/Gz5C0xfgZJ9hp3+8KCWjhZKtWJla1u6IScNVYqy0Q3sVPvzHwvBt7Tn49Y0p4e9jqSXIP68d9LJZYhN3eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8glVCBPTEUX7SkZCrlkTV48fFWE80stOJowDLv5OMzc=;
 b=WeogemxSxwzusBIE7vrb0+7UtBGyAbvolGmQAVsJNjwX9Sgg+mAiRHrZLpNgugCrErqFId8Ae9cu911t+s971GuwGsKHQPLYRRMdGIvZpBW7VHpjfpDdAUvtsk2WgrVelPUf5zjFO30Bw6Z5glVoQCig+YqxztEm1Npv6wPtw9jg9FOp5vGLMckgxkfLGa6c/DhVwyzw44g53TzGphKtOlzbsu6v1wzBBhH7SRRyhDffk+W4TuHwBXWagO7MERRM8Yz1BwhkK9Yd7VYUB+cdC7Yxn8+kJIrMFwN3PexPXx6ds6c3EsLiYYkdC3qtT420PCNY0ZZa5SRgQnu9T8CnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:57:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:57:46 +0000
Date:   Tue, 5 Dec 2023 22:57:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [peterz-queue:locking/futex] [futex]  e1a4bd5d6d:
 will-it-scale.per_thread_ops -11.2% regression
Message-ID: <202312052213.d20bec0a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: bf717aa0-80d6-4ea9-b45f-08dbf5a28a6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZrf5c/2VcZs9OVQfAadJWgfL3i9iaSuhuPS6H/rw07pwv0R6K0xl2L69Bip0Dq+rFWJXoJtCnp9o/V8tO8VMnWtSAD5IkhP1JKcXtXSFtTiKBMkip/0kSljmSRStGzCyaH1FkCl4CO5fh+k6dHnn6rQR+dxyIaDsBqRJS8X5bOE3/TLhsiWPQmaJRlFB+WPokRW1MpzvJOxfOTazpMfnm2Jq23omKL/B+NzdOVZUKxiqJUrxpjXz4si5BEvUe89PETDQRBHp3smLj/yIzPaEPxu1ityOk1MwjxI5/aqCPmAYfkpcww08lYfnmPZ6c3d1dhsr4bzP5Pg7KM6mqfI3f0fa/hTIir45cCgZx5BhqupodFbAkUKvcSxadJewnVFf/a1qgfCJ66ING6iaalajWq5z/01E5cA4m4UOYhSgjxl8K1CDAkNXMUu9LWkLxDqhEpaT+rXiNWTQMZ1ZoMvSylxlwMMMFqkhyGX4NFKabdEwrevJjiygawAAVlzuVMXrywBUQ+G9C/v3/WlGkJZxXgqbccwFsjYWOconxCGC6j4EFQlAczE2Nc+zHYbFuws7zCJvK0fCJmZvYhgJtvBHjhhqjBJwwjxtvA+G4pdjiVTFKIT9ny5VXRgwizfcQm3Gfz4iBzt84KWYC4ZHpNX6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230373577357003)(230922051799003)(230473577357003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(19627235002)(6512007)(6506007)(6486002)(966005)(6666004)(478600001)(66946007)(66476007)(66556008)(316002)(26005)(107886003)(2616005)(1076003)(83380400001)(4326008)(8676002)(6916009)(8936002)(82960400001)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y1GLXGElgYhnRBuYONoRSgc/Z0OsNcxbIMtzL6ggEC3Tb8Wl0xU01Np0Mm?=
 =?iso-8859-1?Q?l7V4C0wrP6sQWL8t6Y8snXcBZp8u6S0BQcNpWWJRKiBl2b1mZlwMd0uFPx?=
 =?iso-8859-1?Q?tlvi01jBWsociC7CiHoxvcqTtV5unz5G3ng3ArF4l1lPB4VKWYfMDgNZvH?=
 =?iso-8859-1?Q?nXEKPzC56saRvKzxTxvhygaYfAxpLSikV/8Qdxw1gHbPhO+izizU/Cwjz+?=
 =?iso-8859-1?Q?raTnUByYjW4eAX2LXDAxyM6fO3WWK4+xDe0LBM5Dn9dMr15NrK8brN7HGh?=
 =?iso-8859-1?Q?GNT2Cb02lYhyAkOc4NHsi4WzZ9getc1zUVTBMwIJFSqkGE+un7f51982i+?=
 =?iso-8859-1?Q?/diEM2CfwCyb+/ZTT6bhK+4pcug1MHnLbNvvO2+pfsTphIQ2S8zVm9hzfx?=
 =?iso-8859-1?Q?FIcY0k8AwuDoiTSJfbiRrARRjccG3VT6PHF6HtZaT4MWNJFU2lN7QQAMna?=
 =?iso-8859-1?Q?t/1G5GdPcoTtDD33+cB5HiQIKtgQB5U5QtikEKTAv3B5T48tk5quuLSlgY?=
 =?iso-8859-1?Q?VAl2GSjnmeO3z7FiiHe4GEw66nFE9DRUQEta47XmEAvny/azagKt/hTuTP?=
 =?iso-8859-1?Q?J6QZgTFkwa4DainFkq5+28TbgNVkrtBQKxvoZqQlnd6Do0BWvw//pwumac?=
 =?iso-8859-1?Q?GmO889w4On37uG3tuo/3+EOHK8463sqwdcgcw1XRCnJ7ug54DwGqh16dP7?=
 =?iso-8859-1?Q?7fdWcawzmGQmTAzNo41ffrjPAg5CmdLEFsBrJvJ9hy9Rt/d/a5oXtB3WbB?=
 =?iso-8859-1?Q?38wM1aQH/Z4SrLS/7EeZHNgczQ3ULsJE88uiTP9isDTVGo0HrWuUVpPDFh?=
 =?iso-8859-1?Q?ypWGYf1RcjWRPWV9pype5sGo20QJEM/e2a2QDYAKyUjtvBGOa5Omfi+XFq?=
 =?iso-8859-1?Q?OtYsKfe4J2wD9HKUEmdjRuihMzwuS84KgYQIReZDEiw6GD+TB8HyV1bO++?=
 =?iso-8859-1?Q?9Q1UBk6xc9Z69M5s/xG34cLzrTi31XmRuMfwlZsdZ9k0/IICXWDAaEpH2s?=
 =?iso-8859-1?Q?ut1oXBdgI7QXO7yaIFFQ1jG1OOKbPKhOozquq/7W8Aog6Dw2PSLViOzMCg?=
 =?iso-8859-1?Q?6wPugLhYRZ+qAEZf6UlujJXsZ/hPvjVwNNYcYWhqnoj+XT36/sjYm9uclC?=
 =?iso-8859-1?Q?XJ6NsGtxqzLnhKxViDfvMpnp1idDCOSdy6ZmmUACarmKEaztxar0W2xPvO?=
 =?iso-8859-1?Q?oXJHTLCWeRn6w97E7i4D66/Q7uAUG8sUjtNr75+ypSFLKnyc4S30uOerDe?=
 =?iso-8859-1?Q?Hn0nJTrX/NBTxIqFdapb9okVL81uQi/R3F/bkhBiCOkfF1LlXAFNMyrWYf?=
 =?iso-8859-1?Q?p9iF7TnAuhPUE4YPiYhHzcUXAnR1qBqwQMpQi3e8tDjI067r/e4t5SCq5k?=
 =?iso-8859-1?Q?HzPVLZMTnOO9v/mzVM/VKCHMXIzhBNfTxijoGwDf6INQdg2nxy4xpCAPOd?=
 =?iso-8859-1?Q?WPATjHPlF4y7sWLwHvjmi/ge0p6NpUzpzAvcL0Pe+KIlq+n4zgaBbjGxa8?=
 =?iso-8859-1?Q?vU+DPdbK4t4iXoij5rx+1+c9yYZ97blXxTQ5CmGPWdtf+e6dwEs4dupQ9d?=
 =?iso-8859-1?Q?9QEqJD97CVlzzt91gPXdyHSwKAkXkWPKnwEIHSE0a7DDSdbQvEF2ckYdYL?=
 =?iso-8859-1?Q?Ttljv5+0N0u5W8vIJyJLXpgh5jjuupn8pJdXH0U20zg1qCX6t9jWjt/g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf717aa0-80d6-4ea9-b45f-08dbf5a28a6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:57:46.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tpLIyXqYEtKuljStEWrndj7U6AskGE5frTVs+bttvPZeor+q0u6j7+c9/tqm+OdNuF2vS5GXjXZF1b+oGQq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -11.2% regression of will-it-scale.per_thread_ops on:


commit: e1a4bd5d6d978ba147f823c669373e3596e0bbcc ("futex: Implement FUTEX2_NUMA")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git locking/futex

testcase: will-it-scale
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 16
	mode: thread
	test: futex1
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312052213.d20bec0a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231205/202312052213.d20bec0a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/futex1/will-it-scale

commit: 
  38d12f1c15 ("mm: Add vmalloc_huge_node()")
  e1a4bd5d6d ("futex: Implement FUTEX2_NUMA")

38d12f1c15069458 e1a4bd5d6d978ba147f823c6693 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.29            -0.1        1.16        mpstat.cpu.all.usr%
     16082 ± 47%    +268.8%      59317 ± 46%  numa-meminfo.node3.AnonHugePages
    443502 ± 10%     -21.7%     347354 ± 16%  numa-numastat.node3.numa_hit
    443856 ± 10%     -21.7%     347355 ± 16%  numa-vmstat.node3.numa_hit
      1821 ± 30%     -45.9%     985.13 ± 52%  sched_debug.cfs_rq:/.load_avg.stddev
   9224874 ±  5%     +54.4%   14242474 ±  5%  meminfo.DirectMap2M
    163286 ±  5%     +30.9%     213804 ±  5%  meminfo.DirectMap4k
      0.55 ±  7%     -14.3%       0.47        turbostat.IPC
     72.33            +1.8%      73.67        turbostat.PkgTmp
 1.155e+08           -11.2%  1.026e+08        will-it-scale.16.threads
   7220531           -11.2%    6414312        will-it-scale.per_thread_ops
 1.155e+08           -11.2%  1.026e+08        will-it-scale.workload
 2.035e+10            -8.9%  1.853e+10        perf-stat.i.branch-instructions
      0.31            -0.0        0.30        perf-stat.i.branch-miss-rate%
  62615280           -12.4%   54851709        perf-stat.i.branch-misses
      0.54            +9.3%       0.59        perf-stat.i.cpi
      0.00 ±  5%      +0.0        0.00 ±  2%  perf-stat.i.dTLB-load-miss-rate%
    139076 ±  5%    +104.7%     284748 ±  2%  perf-stat.i.dTLB-load-misses
 2.634e+10            -8.2%  2.418e+10        perf-stat.i.dTLB-loads
 1.927e+10            -8.8%  1.756e+10        perf-stat.i.dTLB-stores
  55538465           -10.4%   49774500 ±  4%  perf-stat.i.iTLB-load-misses
   2514504           -10.7%    2245869        perf-stat.i.iTLB-loads
  1.25e+11            -8.1%  1.149e+11        perf-stat.i.instructions
      1.85            -8.5%       1.69        perf-stat.i.ipc
    294.40            -8.6%     268.98        perf-stat.i.metric.M/sec
      0.31            -0.0        0.30        perf-stat.overall.branch-miss-rate%
      0.54            +9.3%       0.59        perf-stat.overall.cpi
      0.00 ±  5%      +0.0        0.00 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  6%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      1.85            -8.5%       1.69        perf-stat.overall.ipc
    325727            +3.2%     336234        perf-stat.overall.path-length
 2.028e+10            -8.9%  1.847e+10        perf-stat.ps.branch-instructions
  62436489           -12.4%   54701854        perf-stat.ps.branch-misses
    138701 ±  5%    +104.7%     283927 ±  2%  perf-stat.ps.dTLB-load-misses
 2.625e+10            -8.2%  2.409e+10        perf-stat.ps.dTLB-loads
  1.92e+10            -8.8%   1.75e+10        perf-stat.ps.dTLB-stores
  55348676           -10.4%   49598644 ±  4%  perf-stat.ps.iTLB-load-misses
   2506036           -10.7%    2238080        perf-stat.ps.iTLB-loads
 1.246e+11            -8.1%  1.145e+11        perf-stat.ps.instructions
 3.763e+13            -8.3%  3.451e+13        perf-stat.total.instructions
     14.56 ±  2%      -1.5       13.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
     27.62 ±  2%      -1.4       26.24        perf-profile.calltrace.cycles-pp.get_user_pages_fast.get_futex_key.futex_wake.do_futex.__x64_sys_futex
     25.52 ±  2%      -1.0       24.52        perf-profile.calltrace.cycles-pp.internal_get_user_pages_fast.get_user_pages_fast.get_futex_key.futex_wake.do_futex
     11.08 ±  2%      -0.6       10.48 ±  2%  perf-profile.calltrace.cycles-pp.gup_pte_range.gup_pgd_range.lockless_pages_from_mm.internal_get_user_pages_fast.get_user_pages_fast
      3.74 ±  2%      -0.5        3.26 ±  3%  perf-profile.calltrace.cycles-pp.try_grab_folio.gup_pte_range.gup_pgd_range.lockless_pages_from_mm.internal_get_user_pages_fast
      1.04 ±  3%      -0.3        0.77 ±  3%  perf-profile.calltrace.cycles-pp.is_valid_gup_args.get_user_pages_fast.get_futex_key.futex_wake.do_futex
      2.05 ±  4%      -0.2        1.90 ±  2%  perf-profile.calltrace.cycles-pp.testcase
      1.64 ±  3%      -0.1        1.51        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.33 ±  3%      -0.1        1.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.syscall
      0.98 ±  3%      -0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syscall
      1.02 ±  3%      -0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.69 ±  2%      -0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      3.88 ±  5%      +0.6        4.44 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      4.71 ±  6%      +0.6        5.31 ±  5%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     47.98 ±  2%      +2.7       50.66        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     43.62 ±  2%      +3.1       46.74        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.64 ±  3%      +3.2        5.87        perf-profile.calltrace.cycles-pp.futex_hash.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     41.53 ±  2%      +3.3       44.86        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     40.19 ±  2%      +3.5       43.64        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.78 ±  2%      -1.4       26.37        perf-profile.children.cycles-pp.get_user_pages_fast
     25.77 ±  2%      -1.0       24.73        perf-profile.children.cycles-pp.internal_get_user_pages_fast
      9.17 ±  2%      -0.9        8.28        perf-profile.children.cycles-pp.entry_SYSCALL_64
     11.42 ±  2%      -0.7       10.77 ±  2%  perf-profile.children.cycles-pp.gup_pte_range
      5.61 ±  3%      -0.6        5.06        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.30 ±  2%      -0.5        3.85        perf-profile.children.cycles-pp.try_grab_folio
      1.11 ±  3%      -0.3        0.80 ±  3%  perf-profile.children.cycles-pp.is_valid_gup_args
      2.09 ±  4%      -0.2        1.91        perf-profile.children.cycles-pp.testcase
      2.05 ±  3%      -0.2        1.88        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.42 ±  3%      -0.1        1.29        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.12 ±  3%      -0.1        1.00        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.02 ±  3%      -0.1        0.91 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.69 ±  2%      -0.1        0.63 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  9%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.syscall@plt
      0.39 ±  5%      -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.folio_fast_pin_allowed
      0.08 ± 12%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.06 ± 17%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.check_cpu_stall
      0.04 ± 45%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.hrtimer_forward
      1.02 ±  7%      +0.3        1.29 ±  6%  perf-profile.children.cycles-pp.ktime_get
     48.20 ±  2%      +2.7       50.86        perf-profile.children.cycles-pp.do_syscall_64
     43.65 ±  2%      +3.1       46.74        perf-profile.children.cycles-pp.__x64_sys_futex
      2.65 ±  3%      +3.2        5.88        perf-profile.children.cycles-pp.futex_hash
     41.68 ±  2%      +3.3       44.99        perf-profile.children.cycles-pp.do_futex
     40.38 ±  2%      +3.4       43.81        perf-profile.children.cycles-pp.futex_wake
      7.80 ±  3%      -0.8        6.98        perf-profile.self.cycles-pp.syscall
      5.48 ±  3%      -0.5        4.94        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.24 ±  2%      -0.5        3.71        perf-profile.self.cycles-pp.futex_wake
      4.28 ±  2%      -0.5        3.80        perf-profile.self.cycles-pp.try_grab_folio
      2.60 ±  2%      -0.3        2.28 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.01 ±  2%      -0.3        0.70 ±  2%  perf-profile.self.cycles-pp.is_valid_gup_args
      3.79 ±  2%      -0.3        3.50        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.96 ±  3%      -0.2        1.74 ±  3%  perf-profile.self.cycles-pp.internal_get_user_pages_fast
      1.83 ±  4%      -0.2        1.63        perf-profile.self.cycles-pp.__x64_sys_futex
      1.79 ±  4%      -0.2        1.64        perf-profile.self.cycles-pp.testcase
      1.44 ±  2%      -0.1        1.29 ±  2%  perf-profile.self.cycles-pp.do_futex
      1.40 ±  3%      -0.1        1.25        perf-profile.self.cycles-pp.do_syscall_64
      1.42 ±  3%      -0.1        1.29        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.12 ±  3%      -0.1        1.00        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.96 ±  3%      -0.1        0.86 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.96 ±  3%      -0.1        0.87 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.27 ±  6%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.folio_fast_pin_allowed
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.hrtimer_forward
      0.97 ±  8%      +0.3        1.24 ±  6%  perf-profile.self.cycles-pp.ktime_get
      5.72 ±  3%      +2.1        7.83        perf-profile.self.cycles-pp.get_futex_key
      2.51 ±  3%      +3.2        5.73        perf-profile.self.cycles-pp.futex_hash




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

