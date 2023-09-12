Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57479C8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjILHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjILHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:51:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B597E78
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694505068; x=1726041068;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Zsujct52SXc16UJhEDMP+x3+4/E6ooYUTQQuyZrhm5Q=;
  b=HGGa9JWgVlhXfVeHq6KXfeUC77Hylbi4ETHs89uzAU9vfsVpyKziN6lJ
   HTmHGCUYEHkdrRaQQn3iNnO0Sb3jfvbm+0yyin2V0KS9sNFWfnWfugAbc
   03sna1CboJw3HyIoibwF7TaPY0k0x+lL4XXNIhxCNUegw/Z+cfaWbJb3W
   9ribg1QNuIE4GBqvrXcEzFCfi/FlaD04NumljQ8FDC7SQ+YC0laHsOux/
   ND6BRRQu6xwyt19ivOLBq1lqu56iHAXa6ziIyt0NcrPZjbMfdhkoBpiSW
   1LngjAwfahLg6wkdWk3mCo3dS4hoapycF5IqXUQIRfS4jZp0yuNjAVi1c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409259368"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="409259368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917336466"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="917336466"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 00:51:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 00:51:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 00:51:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 00:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBjE68yzpB7pcvDf/N6MGAPv9r7+KBqSgUAEuObTz/dw4qU6YadnOfGWN5kcUSOCWdx1BHviOW/rIZ0n8UoCjG8rq6ABpxN0f1mjg5q1CMZkK9hFGSMTNd/dt8A3JBx0Jra4ef0oO1ly2R4JdTqfriZGyYtj5H9yrX68KgAVxFO10/+hiJrH9cDXA2pQ+0yMlm3gE1g62RulxzsUNd+8smopFYZeB0X38hO9d4q/d4FcwU99eP1OfKknHItwYutcqyPU0Pl7sfDTmyGymQV9Qq1l60zA9ugYLBuuV6l5Da2lD8RkIt2r55X0izVv3VvXqFZyBFEhVibdaI7gsWWeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpHTwHYWPClCwpMXKRC5LWt0oo1ONEmc7se+Iz2Atd0=;
 b=XEm/k02Kowt3Qk18xuCW1bTIlYBi59Mj/oxeWQm7IRn3geDvoSdWMckjmnYllJXEn468Gm7YvHSIyVm9BcUEiYHblBezihtCw0BZuTMUAoor4cyoZTNeZJ93CjalV75mlsqULaEQMLjMZPZs0TLnF11nXP8xXUhCTc2FHOoZNDm4jYBTmqY+8nhURFZACADiZJBHlqjm1pLm1vtLCYIk1eYvER6xp0T/Ay0s+lFDipBEe+jyQP4Sc7z8c2LiCPh1QFw2p9EQuv8sYtKcugBPvrDDuTP/kt57mpZ72OH/Izw7rOEBH8BgA5HDJPRy1eOQkXSPEGLO6zp1F6Adp3pqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 07:51:00 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 07:51:00 +0000
Date:   Tue, 12 Sep 2023 15:50:45 +0800
From:   kernelt test robot <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional
 scan logic
Message-ID: <202309121417.53f44ad6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87e3c08bd1770dd3e6eee099c01e595f14c76fc3.1693287931.git.raghavendra.kt@amd.com>
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1be0f2-4963-4907-33bc-08dbb3650141
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ln5STmMyDAA5qxHY2CZVRUAxrgrYTEmzvnYg+x4AleI+QdohjpHUT+TTsgHWdag2Mea6SBhgdQ008D/6U0a7t4y6JlbgMQMj4Xoin46se3I2NpzH/SiaGCGSt4Ju80OLi2r24o6fN/lgk7j/emHhLpwhWImKP9kLVM9MCiPmnD2kS0wQdg/arw9lnwBFxmCvtITerjKPE8gPzUlpcfXOv45RZDyzwGzJIJUjo71LyCd4MLi7Zw9C4A6gBis9wJIJ4mmdto9wJqrpKT5XtcthR8BY9Y7ahioV7/lKf6qwbshcGHnNGEVA43FtppSJrvmkc0S34l53GppijRSRB8/p0wWPXWRklxyULzyPZ219OPoj1g0i3zQXumi4TAFkAvvPjFf7mf5WeabrdIRlP9n3cw1Q8pGgiiIbhn6dYZ8XYQwvncXK+IxhY7pIh5KhFzYiQ5IyCrP+Yzys4+8X2QlePIa0e6XEnrNxzt4J7H1pipQfcpEY7wbc1+Zm7Y412DLJGMNdMJGpfeGRgoTzsfvWXtVngpOB5q+L+pNuPJnKBlcJmH+BXO4zpSb2tnPjnswAbCO45kE+aFCeV54LI6tRmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(41300700001)(1076003)(26005)(7416002)(66946007)(966005)(2906002)(86362001)(36756003)(6916009)(316002)(66556008)(478600001)(66476007)(54906003)(6486002)(6666004)(6506007)(6512007)(38100700002)(2616005)(82960400001)(83380400001)(30864003)(5660300002)(8676002)(8936002)(4326008)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pMSA7dTD61gVqzyBTbifA2m2SPDl/hxBXd1J58sh3ut6okidAFTwREu/3C?=
 =?iso-8859-1?Q?5HvHu8xuvHME70fa1q+kJ/nQ7tine3Ic0S6HaFxVMqSaj8Ybx/zELqxzpT?=
 =?iso-8859-1?Q?ZOjHBTIHrvVJ32lYc4L4vv/dS7I1q2PdND6UCScFUbI9Jk8pGmbLFVPS/x?=
 =?iso-8859-1?Q?QFvwIMZnFfxwG+/9t2DxQP1P8CzPbpZHbjr/N2911DsTmQz+8Ofj8O2eLc?=
 =?iso-8859-1?Q?c30yijaxE96WtZbIdgkHONfniYB9rojGImsB8/4CSVB91oO4i6XO1RyT8O?=
 =?iso-8859-1?Q?Ln9EhEboJUYx9lPgM0wls78g4kDMtzUFM0yC+Sa5jZSevBzX9ssrtQevYk?=
 =?iso-8859-1?Q?m1b6uLetyTyk4ORuaGMs4yRzOB5ehf3ayw2cW0N0aDy5U7zhPxkeDHZ2m8?=
 =?iso-8859-1?Q?w4pqnl8GjCzHkjhjR/B9Ux6Woiyhnf49Y7J9i9F/P27S9jnjQf4u7kTQ9r?=
 =?iso-8859-1?Q?T1WUj2sNCoFVi+3IWyBn0i5UgFPxcTjB+qiFQCefthoXVbdAoaAvLla/CF?=
 =?iso-8859-1?Q?XZZIfPDApioZMouzc9WRB35TnizF+NzA6XjeefuF9respJL1h2TsyfrzfK?=
 =?iso-8859-1?Q?qu4VHT9FEbbNlO7WFGKJflcqwSxIq7FRSxrys2Z+seQb/9F47MHayADBJ7?=
 =?iso-8859-1?Q?d9yLh8Yt0G6u/3yIWG6QLEb0LEyc3/cpg3mbcynqNrxQfh9/N7r4w7+tFH?=
 =?iso-8859-1?Q?CBOaZY4snBvUVI9FSncwUQzJ5jgF2dsOEz5n3vhD/v+6Dc4Src+LhEf7Ul?=
 =?iso-8859-1?Q?ZoFgryI9FRJ7Dg4e+yQlKYwt0BlYGLkQbtTJlxolLOoAIhfBB358tuO8Hp?=
 =?iso-8859-1?Q?UsBEqVkp37jst6fYrkDh3JX6g6ok1z0ssawWWf9SyQ+0AMNVTUk759m2Bd?=
 =?iso-8859-1?Q?mAtNrm8l9Uxm9UHTqhZH3xwMq+WoppF5IRBF4KSUlk5A72upww6G+gU6dn?=
 =?iso-8859-1?Q?SY22BYyCEDQSyYrNa+YvBIWEz9IGWiLoaRGGvq22tflZ1Ii3xqLO+ZUGe8?=
 =?iso-8859-1?Q?4dzJwgHkkHpBBRfdNsOiGb3C974sIE5acqOm4Q0wAAHQZMtDUCBwHcP3nN?=
 =?iso-8859-1?Q?0NjM1sxltm29MxujQbtRCM+csZxxpLlfE7yhtBo2tRuQM5jC4P0ahireyB?=
 =?iso-8859-1?Q?1MOKRiCw8zMOS0pAmqk/a3axWxvE4qUMfkgV6sFtmjzqGi7kCk6MPuBx2u?=
 =?iso-8859-1?Q?1D8XCSeAqLEr6Ha1TncNGzF37a2Gs7NIY/NDylwH0j6eUIJ7ColQ6wZvn8?=
 =?iso-8859-1?Q?558Q78c7Bcd7+X6vOERqk9VvpANJPoq+Kkzc2nAUmre7WTfT2J9lJ/FeZR?=
 =?iso-8859-1?Q?A//a4MhC/EDRppSLKFWBvVwcmJLWqXJKo/fjrFqYV21JCtzFFVEaXCUAHm?=
 =?iso-8859-1?Q?6RDIBFF+aWaIxTEkfm4K9h97GAKmCnlk1bTRvyN/No6P1GwsSzRFSC3IPq?=
 =?iso-8859-1?Q?THSaFvokhIzSeof86xCIQpc95NEoAjW1fh7C/2Yc1Z1LbgpIsY3RmSBuvE?=
 =?iso-8859-1?Q?x3v2AqsM+sf5d8DGS0kHFoPoTEilGPfPSgvEkUHWHHo0DschWF79951+7z?=
 =?iso-8859-1?Q?0+nDTl3Mvm7ebJKb+KokIjf5UsJ702k4QCShvILo4v1soTOQwaonW8yNCy?=
 =?iso-8859-1?Q?XwVAbfK0DxS/so/4WwvYRu7AFmEhpgbDNMgN0ONTpnl+3mMB2Wh4a/Jg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1be0f2-4963-4907-33bc-08dbb3650141
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:51:00.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWom/mnvKfJy8bm8ElqiwO6t8rEMspE/sX6wfj+rMdO3+6nWiTPd86OBtdS12wWrzsAvO3+vkbKVgzW13H5zvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -11.9% improvement of autonuma-benchmark.numa01_THREAD_ALLOC.seconds on:


commit: 1ef5cbb92bdb320c5eb9fdee1a811d22ee9e19fe ("[RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional scan logic")
url: https://github.com/intel-lab-lkp/linux/commits/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2f88c8e802c8b128a155976631f4eb2ce4f3c805
patch link: https://lore.kernel.org/all/87e3c08bd1770dd3e6eee099c01e595f14c76fc3.1693287931.git.raghavendra.kt@amd.com/
patch subject: [RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional scan logic

testcase: autonuma-benchmark
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	iterations: 4x
	test: numa01_THREAD_ALLOC
	cpufreq_governor: performance


hi, Raghu,

the reason there is a separate report for this commit besides
https://lore.kernel.org/all/202309102311.84b42068-oliver.sang@intel.com/
is due to bisection nature, for one auto-bisect, we so far only could capture
one commit for performance change.

this auto-bisect is running on another test machine (Sapphire Rapids), and it
happened to choose autonuma-benchmark.numa01_THREAD_ALLOC.seconds as indicator
to do the bisect, it finally captured
"[RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional"

and from
https://lore.kernel.org/all/acf254e9-0207-7030-131f-8a3f520c657b@amd.com/
I noticed you care more about the performance impact of whole patch set,
so let me give a summary table as below.

firstly, let me give out how we apply your patch again:

68cfe9439a1ba (linux-review/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007) sched/numa: Allow scanning of shared VMAs
af46f3c9ca2d1 sched/numa: Allow recently accessed VMAs to be scanned
167773d1ddb5f sched/numa: Increase tasks' access history
fc769221b2306 sched/numa: Remove unconditional scan logic using mm numa_scan_seq
1ef5cbb92bdb3 sched/numa: Add disjoint vma unconditional scan logic
2a806eab1c2e1 sched/numa: Move up the access pid reset logic
2f88c8e802c8b (tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well


we have below data on this test machine
(full table will be very big, if you want it, please let me know):

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark

commit:
  2f88c8e802 ("(tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well")
  2a806eab1c ("sched/numa: Move up the access pid reset logic")
  1ef5cbb92b ("sched/numa: Add disjoint vma unconditional scan logic")
  68cfe9439a ("sched/numa: Allow scanning of shared VMAs")


2f88c8e802c8b128 2a806eab1c2e1c9f0ae39dc0307 1ef5cbb92bdb320c5eb9fdee1a8 68cfe9439a1baa642e05883fa64
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    271.01            +0.8%     273.24            -0.7%     269.00           -26.4%     199.49 ±  3%  autonuma-benchmark.numa01.seconds
     76.28            +0.2%      76.44           -11.7%      67.36 ±  6%     -46.9%      40.49 ±  5%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
      8.11            -0.9%       8.04            -0.7%       8.05            -0.1%       8.10        autonuma-benchmark.numa02.seconds
      1425            +0.7%       1434            -3.1%       1381           -30.1%     996.02 ±  2%  autonuma-benchmark.time.elapsed_time


it has some difference with our previous report on Ice Lake that
autonuma-benchmark.numa02.seconds seems keep stable,
but autonuma-benchmark.numa01.seconds has more changes.

anyway, for both platforms, we see performance improvement consistently
in this test along the patch-set.


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309121417.53f44ad6-oliver.sang@intel.com


below are normal data we shared in our performance reports. FYI.
(you won't see data for autonuma-benchmark.numa01.seconds or autonuma-benchmark.numa02.seconds,
since the delta bewteen 2a806eab1c and 1ef5cbb92b are small so our tool won't
show them)

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark

commit: 
  2a806eab1c ("sched/numa: Move up the access pid reset logic")
  1ef5cbb92b ("sched/numa: Add disjoint vma unconditional scan logic")

2a806eab1c2e1c9f 1ef5cbb92bdb320c5eb9fdee1a8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.00 ± 79%      +0.0        0.00 ± 13%  mpstat.cpu.all.iowait%
    357.33 ± 12%     +90.4%     680.50 ± 30%  perf-c2c.DRAM.remote
     79.17 ± 14%     +34.7%     106.67 ± 18%  perf-c2c.HITM.remote
     16378 ± 16%     +53.9%      25200 ± 22%  turbostat.POLL
     50.24           +15.4%      57.99        turbostat.RAMWatt
     37.04 ±199%     -97.2%       1.05 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      7.46 ± 23%     -43.7%       4.20 ± 47%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    170.20 ±218%     -99.4%       1.05 ±141%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
    283.88 ± 28%     +49.3%     423.88 ± 16%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    189.72 ± 23%     +50.9%     286.24 ± 25%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     76.44           -11.9%      67.36 ±  6%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
      1434            -3.7%       1381        autonuma-benchmark.time.elapsed_time
      1434            -3.7%       1381        autonuma-benchmark.time.elapsed_time.max
   1132634            -6.0%    1064224 ±  2%  autonuma-benchmark.time.involuntary_context_switches
   2532130 ±  2%      +4.5%    2645367 ±  2%  autonuma-benchmark.time.minor_page_faults
    293184            -3.6%     282626        autonuma-benchmark.time.user_time
     16101           +41.9%      22846 ±  4%  autonuma-benchmark.time.voluntary_context_switches
      6.41 ± 52%   +3833.7%     251.97 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    401.88 ±  4%    +179.2%       1121 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.max
     39.18 ± 16%    +698.0%     312.66 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1662842           +10.5%    1838160 ±  2%  sched_debug.cpu.avg_idle.avg
    860266 ±  3%     -22.4%     667568 ± 11%  sched_debug.cpu.avg_idle.min
    647306 ±  4%     +13.6%     735595 ±  2%  sched_debug.cpu.avg_idle.stddev
    664890           +10.4%     733919 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
    203832 ±  4%     +45.7%     296934 ±  4%  sched_debug.cpu.max_idle_balance_cost.stddev
     58841 ± 19%    +205.6%     179845 ±  8%  proc-vmstat.numa_hint_faults
     47138 ± 20%    +145.1%     115557 ±  8%  proc-vmstat.numa_hint_faults_local
    652.00 ± 27%   +5217.2%      34668 ± 10%  proc-vmstat.numa_huge_pte_updates
    108295 ± 25%   +3179.6%    3551657 ± 11%  proc-vmstat.numa_pages_migrated
    499336 ± 16%   +3503.7%   17994636 ± 10%  proc-vmstat.numa_pte_updates
    108295 ± 25%   +3179.6%    3551657 ± 11%  proc-vmstat.pgmigrate_success
    238140            +6.7%     254200        proc-vmstat.pgreuse
    191.00 ± 29%   +3488.8%       6854 ± 11%  proc-vmstat.thp_migration_success
   4331500            -4.5%    4135400 ±  2%  proc-vmstat.unevictable_pgs_scanned
      0.66            +0.0        0.67        perf-stat.i.branch-miss-rate%
   1779997            +3.1%    1835782        perf-stat.i.branch-misses
      2096            +1.6%       2128        perf-stat.i.context-switches
    219.07            +2.3%     224.02        perf-stat.i.cpu-migrations
    163199           -11.6%     144321 ±  2%  perf-stat.i.cycles-between-cache-misses
    986545            +1.0%     996780        perf-stat.i.dTLB-store-misses
      4436            +4.1%       4616        perf-stat.i.minor-faults
     42.56 ±  3%      +3.4       45.95        perf-stat.i.node-load-miss-rate%
    396254           +28.2%     507952 ±  3%  perf-stat.i.node-load-misses
      4436            +4.1%       4617        perf-stat.i.page-faults
     38.37 ±  6%      +6.3       44.69 ±  7%  perf-stat.overall.node-load-miss-rate%
   1734727            +2.3%    1774826        perf-stat.ps.branch-misses
    216.66            +2.2%     221.40        perf-stat.ps.cpu-migrations
    983143            +1.1%     993856        perf-stat.ps.dTLB-store-misses
      4178            +4.3%       4357        perf-stat.ps.minor-faults
    384816           +29.9%     499993 ±  4%  perf-stat.ps.node-load-misses
      4178            +4.3%       4357        perf-stat.ps.page-faults
     47.25 ± 24%     -32.1       15.11 ±142%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     40.98 ± 34%     -27.0       13.98 ±141%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
     40.76 ± 34%     -26.9       13.90 ±141%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
     40.90 ± 36%     -26.6       14.32 ±141%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      6.07 ±101%      -5.4        0.62 ±223%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      5.76 ±110%      -5.1        0.62 ±223%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      5.42 ±101%      -4.9        0.48 ±223%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      0.58 ± 18%      +0.4        0.94 ± 18%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.49 ± 49%      +0.4        0.94 ± 17%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.70 ± 25%      +0.5        1.21 ± 22%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.71 ± 24%      +0.5        1.22 ± 22%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.20 ±142%      +0.5        0.74 ± 18%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.64 ± 53%      +0.5        1.18 ± 32%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.18 ±141%      +0.6        0.74 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read.read_counters
      0.18 ±141%      +0.6        0.74 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read
      0.18 ±141%      +0.6        0.75 ± 19%  perf-profile.calltrace.cycles-pp.__libc_read.readn.perf_evsel__read.read_counters.process_interval
      0.18 ±141%      +0.6        0.76 ± 19%  perf-profile.calltrace.cycles-pp.readn.perf_evsel__read.read_counters.process_interval.dispatch_events
      0.31 ±103%      +0.6        0.89 ± 18%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.10 ±223%      +0.6        0.69 ± 18%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ± 23%      +0.6        1.30 ± 26%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.31 ±103%      +0.6        0.90 ± 18%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
      0.22 ±142%      +0.6        0.81 ± 17%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.57 ± 60%      +0.6        1.19 ± 16%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.58 ± 60%      +0.6        1.21 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.58 ± 60%      +0.6        1.21 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      0.22 ±143%      +0.6        0.86 ± 18%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.58 ± 61%      +0.6        1.23 ± 16%  perf-profile.calltrace.cycles-pp.__xstat64
      0.25 ±150%      +0.6        0.90 ± 19%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.24 ±142%      +0.7        0.90 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      0.24 ±142%      +0.7        0.90 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      0.21 ±141%      +0.7        0.89 ± 19%  perf-profile.calltrace.cycles-pp.perf_evsel__read.read_counters.process_interval.dispatch_events.cmd_stat
      0.37 ±108%      +0.7        1.07 ± 17%  perf-profile.calltrace.cycles-pp.evlist__id2evsel.evsel__read_counter.read_counters.process_interval.dispatch_events
      0.64 ± 57%      +0.7        1.33 ± 20%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      0.10 ±223%      +0.7        0.81 ± 27%  perf-profile.calltrace.cycles-pp.show_stat.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.26 ±142%      +0.7        1.01 ± 19%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      0.51 ± 84%      +0.7        1.25 ± 28%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.09 ±223%      +0.8        0.85 ± 27%  perf-profile.calltrace.cycles-pp.vmstat_start.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.53 ± 53%      +0.8        1.30 ± 25%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.53 ± 53%      +0.8        1.30 ± 25%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ± 20%      +0.8        1.64 ± 26%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.30 ±103%      +0.8        1.12 ± 30%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ±143%      +0.8        1.03 ± 30%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.89 ± 23%      +0.8        1.72 ± 26%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.66 ± 70%      +0.8        1.48 ± 38%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±155%      +0.8        1.12 ± 33%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn
      0.32 ±150%      +0.9        1.18 ± 40%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.94 ± 23%      +0.9        1.83 ± 26%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.94 ± 23%      +0.9        1.83 ± 26%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.15 ±223%      +1.0        1.10 ± 44%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.15 ±223%      +1.0        1.12 ± 43%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.15 ±223%      +1.0        1.13 ± 43%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.00 ± 51%      +1.0        1.99 ± 36%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.00 ± 51%      +1.0        1.98 ± 36%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.01 ± 51%      +1.0        1.99 ± 36%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.01 ± 51%      +1.0        1.99 ± 36%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.06 ± 42%      +1.0        2.05 ± 17%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.17 ±223%      +1.0        1.22 ± 41%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.07 ± 54%      +1.0        2.12 ± 36%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.55 ± 75%      +1.2        1.74 ± 36%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.86 ± 59%      +1.2        2.10 ± 33%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.87 ± 59%      +1.2        2.11 ± 33%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.95 ± 59%      +1.3        2.29 ± 33%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.74 ± 46%      +1.4        3.17 ± 25%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.74 ± 46%      +1.4        3.17 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.19 ± 60%      +1.6        2.78 ± 31%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.19 ± 61%      +1.6        2.78 ± 31%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.19 ± 61%      +1.6        2.78 ± 31%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.82 ± 24%      +1.6        3.46 ± 23%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.82 ± 24%      +1.6        3.46 ± 23%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.82 ± 24%      +1.6        3.46 ± 23%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      2.15 ± 21%      +2.0        4.20 ± 24%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.48 ± 80%      +3.4        4.89 ± 18%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat
      1.54 ± 79%      +3.5        5.03 ± 18%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat
      1.54 ± 79%      +3.5        5.03 ± 18%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat
      1.54 ± 79%      +3.5        5.04 ± 18%  perf-profile.calltrace.cycles-pp.cmd_stat
      0.13 ±223%      +3.5        3.67 ± 62%  perf-profile.calltrace.cycles-pp.copy_page.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      0.14 ±223%      +3.6        3.73 ± 62%  perf-profile.calltrace.cycles-pp.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages
      0.14 ±223%      +3.6        3.73 ± 62%  perf-profile.calltrace.cycles-pp.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page
      0.14 ±223%      +3.6        3.73 ± 62%  perf-profile.calltrace.cycles-pp.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page
      0.14 ±223%      +3.9        4.00 ± 62%  perf-profile.calltrace.cycles-pp.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault
      0.14 ±223%      +3.9        4.00 ± 62%  perf-profile.calltrace.cycles-pp.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault
      0.14 ±223%      +3.9        4.00 ± 62%  perf-profile.calltrace.cycles-pp.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.90 ± 41%      +3.9        7.77 ± 27%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.97 ± 41%      +3.9        7.84 ± 27%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.14 ±223%      +3.9        4.06 ± 61%  perf-profile.calltrace.cycles-pp.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.13 ± 41%      +4.0        8.15 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.13 ± 41%      +4.0        8.17 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      4.18 ± 41%      +4.1        8.26 ± 27%  perf-profile.calltrace.cycles-pp.read
      1.80 ± 50%      +5.5        7.29 ± 43%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.02 ± 50%      +5.6        7.64 ± 41%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.04 ± 50%      +5.6        7.66 ± 41%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.36 ± 33%      +5.6        7.99 ± 33%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.14 ± 50%      +5.7        7.84 ± 40%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     69.69 ± 16%     -30.0       39.64 ± 40%  perf-profile.children.cycles-pp.__cmd_record
      6.08 ±101%      -5.5        0.62 ±223%  perf-profile.children.cycles-pp.perf_session__process_user_event
      6.15 ±100%      -5.4        0.72 ±190%  perf-profile.children.cycles-pp.__ordered_events__flush
      5.48 ±101%      -4.9        0.56 ±188%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.06 ± 29%      +0.0        0.11 ± 27%  perf-profile.children.cycles-pp.path_init
      0.02 ±141%      +0.0        0.06 ± 33%  perf-profile.children.cycles-pp.cp_new_stat
      0.02 ±141%      +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.02 ±146%      +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.08 ± 24%      +0.1        0.14 ± 32%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.02 ±141%      +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.vm_memory_committed
      0.11 ± 26%      +0.1        0.17 ± 19%  perf-profile.children.cycles-pp.aa_file_perm
      0.06 ± 50%      +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
      0.02 ±141%      +0.1        0.08 ± 40%  perf-profile.children.cycles-pp.set_next_entity
      0.09 ± 39%      +0.1        0.16 ± 28%  perf-profile.children.cycles-pp.try_charge_memcg
      0.02 ±143%      +0.1        0.09 ± 38%  perf-profile.children.cycles-pp.__evlist__disable
      0.01 ±223%      +0.1        0.08 ± 35%  perf-profile.children.cycles-pp._IO_setvbuf
      0.08 ± 36%      +0.1        0.16 ± 29%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.02 ±223%      +0.1        0.09 ± 27%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
      0.12 ± 23%      +0.1        0.20 ± 35%  perf-profile.children.cycles-pp.get_idle_time
      0.01 ±223%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.meminfo_proc_show
      0.10 ± 14%      +0.1        0.18 ± 33%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.12 ± 17%      +0.1        0.20 ± 32%  perf-profile.children.cycles-pp.xas_descend
      0.05 ± 77%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.fsnotify_perm
      0.02 ±223%      +0.1        0.10 ± 42%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.11 ± 13%      +0.1        0.19 ± 33%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.02 ±143%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.__kmalloc
      0.04 ±118%      +0.1        0.13 ± 43%  perf-profile.children.cycles-pp.xas_find
      0.00            +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ± 33%      +0.1        0.17 ± 37%  perf-profile.children.cycles-pp.node_read_vmstat
      0.09 ± 45%      +0.1        0.18 ± 29%  perf-profile.children.cycles-pp.select_task_rq
      0.01 ±223%      +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.slab_show
      0.03 ±143%      +0.1        0.12 ± 46%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.12 ± 36%      +0.1        0.21 ± 33%  perf-profile.children.cycles-pp.dequeue_entity
      0.01 ±223%      +0.1        0.10 ± 27%  perf-profile.children.cycles-pp._IO_file_doallocate
      0.08 ± 53%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.apparmor_ptrace_access_check
      0.04 ±105%      +0.1        0.13 ± 48%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.08 ± 32%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.12 ± 26%      +0.1        0.22 ± 31%  perf-profile.children.cycles-pp.__x64_sys_close
      0.11 ± 16%      +0.1        0.21 ± 36%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.04 ±107%      +0.1        0.13 ± 47%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.04 ±107%      +0.1        0.13 ± 47%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.02 ±146%      +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.thread_group_cputime
      0.12 ± 35%      +0.1        0.22 ± 21%  perf-profile.children.cycles-pp.atime_needs_update
      0.09 ± 44%      +0.1        0.18 ± 23%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.11 ± 32%      +0.1        0.21 ± 25%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.04 ±107%      +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.04 ±107%      +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.04 ±112%      +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.get_unmapped_area
      0.06 ± 58%      +0.1        0.16 ± 38%  perf-profile.children.cycles-pp.prepare_task_switch
      0.13 ± 34%      +0.1        0.23 ± 19%  perf-profile.children.cycles-pp.generic_exec_single
      0.10 ± 30%      +0.1        0.20 ± 30%  perf-profile.children.cycles-pp.__wait_for_common
      0.03 ±105%      +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.13 ± 32%      +0.1        0.24 ± 19%  perf-profile.children.cycles-pp.smp_call_function_single
      0.12 ± 40%      +0.1        0.23 ± 26%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.06 ± 58%      +0.1        0.17 ± 32%  perf-profile.children.cycles-pp.kstat_irqs_usr
      0.10 ± 31%      +0.1        0.22 ± 33%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.02 ±223%      +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.11 ± 48%      +0.1        0.22 ± 37%  perf-profile.children.cycles-pp.single_release
      0.15 ± 33%      +0.1        0.26 ± 17%  perf-profile.children.cycles-pp.perf_event_read
      0.08 ± 48%      +0.1        0.20 ± 27%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.10 ± 70%      +0.1        0.21 ± 33%  perf-profile.children.cycles-pp.vm_area_dup
      0.09 ± 31%      +0.1        0.21 ± 35%  perf-profile.children.cycles-pp.__wake_up_common
      0.20 ± 37%      +0.1        0.32 ± 21%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ± 35%      +0.1        0.24 ± 28%  perf-profile.children.cycles-pp.blk_mq_queue_tag_busy_iter
      0.12 ± 35%      +0.1        0.24 ± 28%  perf-profile.children.cycles-pp.blk_mq_in_flight
      0.20 ± 28%      +0.1        0.32 ± 16%  perf-profile.children.cycles-pp.__cond_resched
      0.17 ± 37%      +0.1        0.30 ± 26%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.08 ± 51%      +0.1        0.21 ± 36%  perf-profile.children.cycles-pp.free_swap_cache
      0.02 ±146%      +0.1        0.16 ± 38%  perf-profile.children.cycles-pp.flush_tlb_func
      0.09 ± 48%      +0.1        0.23 ± 37%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.18 ± 37%      +0.1        0.32 ± 26%  perf-profile.children.cycles-pp.update_curr
      0.02 ±142%      +0.1        0.16 ± 26%  perf-profile.children.cycles-pp.__x64_sys_newfstat
      0.04 ±109%      +0.1        0.18 ± 53%  perf-profile.children.cycles-pp.free_unref_page_list
      0.12 ± 38%      +0.1        0.26 ± 30%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.12 ± 59%      +0.1        0.27 ± 26%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.13 ± 40%      +0.1        0.28 ± 33%  perf-profile.children.cycles-pp.user_path_at_empty
      0.12 ± 31%      +0.1        0.27 ± 23%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.20 ± 31%      +0.1        0.35 ± 34%  perf-profile.children.cycles-pp.dev_attr_show
      0.13 ± 44%      +0.2        0.28 ± 31%  perf-profile.children.cycles-pp.readlink
      0.20 ± 30%      +0.2        0.35 ± 26%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.15 ± 64%  perf-profile.children.cycles-pp.pmdp_invalidate
      0.18 ± 31%      +0.2        0.34 ± 27%  perf-profile.children.cycles-pp.dup_task_struct
      0.13 ± 33%      +0.2        0.29 ± 29%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.2        0.16 ± 64%  perf-profile.children.cycles-pp.set_pmd_migration_entry
      0.19 ± 26%      +0.2        0.34 ± 27%  perf-profile.children.cycles-pp.__entry_text_start
      0.12 ± 32%      +0.2        0.29 ± 38%  perf-profile.children.cycles-pp.pipe_write
      0.25 ± 35%      +0.2        0.42 ± 32%  perf-profile.children.cycles-pp.__check_object_size
      0.23 ± 35%      +0.2        0.40 ± 20%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.22 ± 46%      +0.2        0.39 ± 21%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.18 ± 92%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.2        0.18 ± 92%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.2        0.18 ± 59%  perf-profile.children.cycles-pp.try_to_migrate
      0.00            +0.2        0.18 ± 59%  perf-profile.children.cycles-pp.try_to_migrate_one
      0.16 ± 37%      +0.2        0.34 ± 33%  perf-profile.children.cycles-pp.do_readlinkat
      0.19 ± 54%      +0.2        0.37 ± 44%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.16 ± 37%      +0.2        0.34 ± 32%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.00            +0.2        0.19 ± 60%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.00            +0.2        0.19 ± 66%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.00            +0.2        0.19 ± 95%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.00            +0.2        0.20 ± 59%  perf-profile.children.cycles-pp.migrate_folio_unmap
      0.21 ± 43%      +0.2        0.42 ± 27%  perf-profile.children.cycles-pp.diskstats_show
      0.28 ± 36%      +0.2        0.49 ± 24%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.2        0.21 ± 53%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.01 ±223%      +0.2        0.24 ± 63%  perf-profile.children.cycles-pp.sysvec_call_function
      0.39 ± 15%      +0.2        0.63 ± 15%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.22 ± 13%      +0.3        0.48 ± 28%  perf-profile.children.cycles-pp.all_vm_events
      0.21 ± 38%      +0.3        0.48 ± 40%  perf-profile.children.cycles-pp.write
      0.30 ± 45%      +0.3        0.58 ± 27%  perf-profile.children.cycles-pp._raw_spin_lock
      0.22 ± 40%      +0.3        0.50 ± 26%  perf-profile.children.cycles-pp.getname_flags
      0.28 ± 54%      +0.3        0.56 ± 24%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.30 ± 55%      +0.3        0.60 ± 39%  perf-profile.children.cycles-pp.dup_mmap
      0.01 ±223%      +0.3        0.32 ± 88%  perf-profile.children.cycles-pp.start_secondary
      0.20 ± 38%      +0.3        0.50 ± 40%  perf-profile.children.cycles-pp.release_pages
      0.01 ±223%      +0.3        0.32 ± 58%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.01 ±223%      +0.3        0.32 ± 85%  perf-profile.children.cycles-pp.do_idle
      0.01 ±223%      +0.3        0.32 ± 85%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.01 ±223%      +0.3        0.32 ± 85%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.37 ± 37%      +0.3        0.68 ± 30%  perf-profile.children.cycles-pp.__close_nocancel
      0.26 ± 24%      +0.3        0.58 ± 38%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.26 ± 24%      +0.3        0.58 ± 38%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.36 ± 37%      +0.3        0.69 ± 19%  perf-profile.children.cycles-pp.perf_read
      0.33 ± 29%      +0.3        0.66 ± 30%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.28 ± 48%      +0.3        0.62 ± 34%  perf-profile.children.cycles-pp.kmem_cache_free
      0.22 ± 81%      +0.4        0.58 ± 55%  perf-profile.children.cycles-pp.wait4
      0.36 ± 32%      +0.4        0.72 ± 25%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.40 ± 52%      +0.4        0.78 ± 32%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.43 ± 23%      +0.4        0.81 ± 27%  perf-profile.children.cycles-pp.show_stat
      0.42 ± 32%      +0.4        0.81 ± 24%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.24 ± 44%      +0.4        0.65 ± 43%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.02 ±223%      +0.4        0.45 ± 48%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.53 ± 48%      +0.4        0.97 ± 34%  perf-profile.children.cycles-pp.open_last_lookups
      0.03 ±223%      +0.4        0.48 ± 42%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.07 ± 58%      +0.5        0.52 ± 39%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.43 ± 37%      +0.5        0.89 ± 19%  perf-profile.children.cycles-pp.perf_evsel__read
      0.39 ± 18%      +0.5        0.85 ± 27%  perf-profile.children.cycles-pp.vmstat_start
      0.16 ± 57%      +0.5        0.63 ± 42%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.49 ± 31%      +0.5        0.97 ± 23%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.04 ±168%      +0.5        0.52 ± 51%  perf-profile.children.cycles-pp.newidle_balance
      0.45 ± 28%      +0.5        0.96 ± 32%  perf-profile.children.cycles-pp.finish_task_switch
      0.61 ± 20%      +0.5        1.13 ± 24%  perf-profile.children.cycles-pp.rebalance_domains
      0.55 ± 47%      +0.5        1.08 ± 17%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.46 ± 50%      +0.5        0.98 ± 51%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.29 ± 45%      +0.5        0.82 ± 37%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.44 ± 53%      +0.5        0.98 ± 32%  perf-profile.children.cycles-pp.wp_page_copy
      0.59 ± 29%      +0.6        1.14 ± 30%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.46 ± 28%      +0.6        1.03 ± 30%  perf-profile.children.cycles-pp.process_one_work
      0.54 ± 59%      +0.6        1.12 ± 29%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.63 ± 32%      +0.6        1.21 ± 31%  perf-profile.children.cycles-pp.__mmdrop
      0.76 ± 41%      +0.6        1.36 ± 32%  perf-profile.children.cycles-pp.walk_component
      0.58 ± 53%      +0.6        1.18 ± 40%  perf-profile.children.cycles-pp.dup_mm
      0.48 ± 30%      +0.6        1.12 ± 30%  perf-profile.children.cycles-pp.worker_thread
      0.30 ± 63%      +0.6        0.95 ± 41%  perf-profile.children.cycles-pp._compound_head
      0.68 ± 36%      +0.6        1.32 ± 17%  perf-profile.children.cycles-pp.readn
      0.61 ± 27%      +0.7        1.30 ± 25%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.99 ± 41%      +0.8        1.75 ± 32%  perf-profile.children.cycles-pp.lookup_fast
      0.78 ± 31%      +0.8        1.55 ± 22%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      1.77 ± 16%      +0.8        2.55 ± 21%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.58 ± 24%      +0.8        1.42 ± 29%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.61 ± 24%      +0.9        1.48 ± 29%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.61 ± 24%      +0.9        1.50 ± 30%  perf-profile.children.cycles-pp.find_busiest_group
      1.08 ± 29%      +0.9        2.00 ± 32%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.93 ± 48%      +0.9        1.87 ± 35%  perf-profile.children.cycles-pp.copy_process
      0.65 ± 26%      +1.0        1.62 ± 29%  perf-profile.children.cycles-pp.load_balance
      1.00 ± 51%      +1.0        1.99 ± 36%  perf-profile.children.cycles-pp.__do_sys_clone
      1.06 ± 42%      +1.0        2.05 ± 17%  perf-profile.children.cycles-pp.evsel__read_counter
      0.50 ± 62%      +1.0        1.51 ± 47%  perf-profile.children.cycles-pp.zap_pte_range
      0.51 ± 61%      +1.0        1.53 ± 46%  perf-profile.children.cycles-pp.zap_pmd_range
      0.53 ± 61%      +1.0        1.57 ± 46%  perf-profile.children.cycles-pp.unmap_page_range
      1.05 ± 31%      +1.1        2.10 ± 23%  perf-profile.children.cycles-pp.sched_setaffinity
      1.07 ± 54%      +1.1        2.12 ± 36%  perf-profile.children.cycles-pp.__libc_fork
      1.70 ± 17%      +1.1        2.80 ± 29%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.61 ± 61%      +1.1        1.73 ± 43%  perf-profile.children.cycles-pp.unmap_vmas
      1.32 ± 29%      +1.2        2.48 ± 40%  perf-profile.children.cycles-pp.__do_softirq
      1.30 ± 29%      +1.2        2.48 ± 28%  perf-profile.children.cycles-pp.do_fault
      1.02 ± 32%      +1.3        2.29 ± 32%  perf-profile.children.cycles-pp.schedule
      0.95 ± 59%      +1.3        2.30 ± 33%  perf-profile.children.cycles-pp.exit_mm
      1.15 ± 34%      +1.5        2.65 ± 31%  perf-profile.children.cycles-pp.__schedule
      1.18 ± 58%      +1.6        2.76 ± 32%  perf-profile.children.cycles-pp.exit_mmap
      1.18 ± 58%      +1.6        2.78 ± 32%  perf-profile.children.cycles-pp.__mmput
      1.23 ± 60%      +1.6        2.86 ± 31%  perf-profile.children.cycles-pp.do_exit
      1.23 ± 60%      +1.6        2.87 ± 31%  perf-profile.children.cycles-pp.do_group_exit
      1.23 ± 60%      +1.6        2.87 ± 31%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.82 ± 24%      +1.6        3.46 ± 23%  perf-profile.children.cycles-pp.kthread
      1.83 ± 24%      +1.7        3.51 ± 24%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.83 ± 23%      +1.7        3.50 ± 24%  perf-profile.children.cycles-pp.ret_from_fork
      2.70 ± 16%      +1.8        4.51 ± 30%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.85 ± 17%      +2.0        4.83 ± 29%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.90 ± 12%      +2.0        5.92 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.51 ± 39%      +2.4        4.89 ± 18%  perf-profile.children.cycles-pp.read_counters
      2.60 ± 38%      +2.4        5.03 ± 18%  perf-profile.children.cycles-pp.dispatch_events
      2.60 ± 38%      +2.4        5.03 ± 18%  perf-profile.children.cycles-pp.process_interval
      2.60 ± 38%      +2.4        5.04 ± 18%  perf-profile.children.cycles-pp.cmd_stat
      3.87 ± 43%      +3.2        7.04 ± 26%  perf-profile.children.cycles-pp.seq_read_iter
      0.23 ±170%      +3.6        3.83 ± 58%  perf-profile.children.cycles-pp.folio_copy
      0.23 ±169%      +3.6        3.84 ± 58%  perf-profile.children.cycles-pp.migrate_folio_extra
      0.23 ±169%      +3.6        3.84 ± 58%  perf-profile.children.cycles-pp.move_to_new_folio
      0.28 ±145%      +3.7        4.00 ± 56%  perf-profile.children.cycles-pp.copy_page
      0.24 ±171%      +3.9        4.14 ± 58%  perf-profile.children.cycles-pp.migrate_pages_batch
      0.24 ±171%      +3.9        4.14 ± 58%  perf-profile.children.cycles-pp.migrate_pages
      0.25 ±171%      +3.9        4.15 ± 58%  perf-profile.children.cycles-pp.migrate_misplaced_page
      0.22 ±166%      +3.9        4.13 ± 58%  perf-profile.children.cycles-pp.do_huge_pmd_numa_page
      4.19 ± 41%      +4.1        8.29 ± 27%  perf-profile.children.cycles-pp.read
      4.84 ± 41%      +4.1        8.96 ± 25%  perf-profile.children.cycles-pp.vfs_read
      5.01 ± 41%      +4.3        9.29 ± 25%  perf-profile.children.cycles-pp.ksys_read
      3.24 ± 32%      +6.3        9.52 ± 30%  perf-profile.children.cycles-pp.__handle_mm_fault
      3.68 ± 31%      +6.5       10.18 ± 28%  perf-profile.children.cycles-pp.handle_mm_fault
      4.55 ± 27%      +6.8       11.34 ± 24%  perf-profile.children.cycles-pp.do_user_addr_fault
      4.62 ± 27%      +6.8       11.43 ± 24%  perf-profile.children.cycles-pp.exc_page_fault
      5.01 ± 26%      +7.0       12.02 ± 23%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.02 ±141%      +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.11 ± 26%      +0.1        0.16 ± 19%  perf-profile.self.cycles-pp.aa_file_perm
      0.02 ±141%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.perf_evsel__read
      0.02 ±144%      +0.1        0.08 ± 40%  perf-profile.self.cycles-pp.check_heap_object
      0.07 ± 30%      +0.1        0.13 ± 34%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp._copy_to_iter
      0.07 ± 52%      +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.atime_needs_update
      0.06 ± 50%      +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
      0.01 ±223%      +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.wq_worker_comm
      0.05 ± 80%      +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.try_charge_memcg
      0.07 ± 57%      +0.1        0.14 ± 28%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.05 ± 84%      +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.02 ±223%      +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.01 ±223%      +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.thread_group_cputime
      0.04 ±104%      +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.fsnotify_perm
      0.05 ± 86%      +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.perf_read
      0.01 ±223%      +0.1        0.09 ± 27%  perf-profile.self.cycles-pp._IO_file_doallocate
      0.12 ± 19%      +0.1        0.20 ± 32%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.1        0.08 ± 30%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.10 ± 39%      +0.1        0.19 ± 26%  perf-profile.self.cycles-pp.update_curr
      0.03 ±105%      +0.1        0.12 ± 39%  perf-profile.self.cycles-pp.__fput
      0.03 ±150%      +0.1        0.13 ± 40%  perf-profile.self.cycles-pp.task_dump_owner
      0.06 ± 58%      +0.1        0.17 ± 33%  perf-profile.self.cycles-pp.kstat_irqs_usr
      0.02 ±223%      +0.1        0.12 ± 35%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.08 ± 27%      +0.1        0.20 ± 40%  perf-profile.self.cycles-pp.release_pages
      0.12 ± 37%      +0.1        0.23 ± 27%  perf-profile.self.cycles-pp.blk_mq_queue_tag_busy_iter
      0.17 ± 37%      +0.1        0.29 ± 28%  perf-profile.self.cycles-pp.__schedule
      0.08 ± 51%      +0.1        0.20 ± 35%  perf-profile.self.cycles-pp.free_swap_cache
      0.13 ± 23%      +0.1        0.26 ± 18%  perf-profile.self.cycles-pp.__entry_text_start
      0.13 ± 39%      +0.1        0.26 ± 24%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.02 ±142%      +0.1        0.15 ± 24%  perf-profile.self.cycles-pp.__x64_sys_newfstat
      0.08 ± 40%      +0.1        0.22 ± 17%  perf-profile.self.cycles-pp.vfs_read
      0.12 ± 38%      +0.1        0.26 ± 30%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.20 ± 32%      +0.2        0.35 ± 26%  perf-profile.self.cycles-pp.__memcpy
      0.22 ± 43%      +0.2        0.40 ± 22%  perf-profile.self.cycles-pp.do_dentry_open
      0.16 ± 41%      +0.2        0.34 ± 23%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.19 ± 54%      +0.2        0.37 ± 44%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.24 ± 52%      +0.2        0.43 ± 35%  perf-profile.self.cycles-pp.inode_permission
      0.20 ± 39%      +0.2        0.40 ± 17%  perf-profile.self.cycles-pp.evsel__read_counter
      0.14 ± 44%      +0.2        0.35 ± 18%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.39 ± 15%      +0.2        0.63 ± 15%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.22 ± 49%      +0.2        0.47 ± 31%  perf-profile.self.cycles-pp.kmem_cache_free
      0.02 ±223%      +0.3        0.27 ± 44%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.22 ± 13%      +0.3        0.47 ± 28%  perf-profile.self.cycles-pp.all_vm_events
      0.24 ± 62%      +0.3        0.50 ± 34%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.29 ± 42%      +0.3        0.56 ± 22%  perf-profile.self.cycles-pp.read_counters
      0.32 ± 28%      +0.3        0.65 ± 31%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.39 ± 52%      +0.4        0.76 ± 32%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.37 ± 18%      +0.4        0.75 ± 28%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.54 ± 46%      +0.5        1.05 ± 17%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.58 ± 29%      +0.5        1.10 ± 31%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.30 ± 63%      +0.6        0.92 ± 40%  perf-profile.self.cycles-pp._compound_head
      0.46 ± 22%      +0.6        1.11 ± 28%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.27 ±144%      +3.7        3.98 ± 57%  perf-profile.self.cycles-pp.copy_page




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

