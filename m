Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF3799ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbjIJPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjIJP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:29:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EEF118
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694359794; x=1725895794;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Bk4SPgmZR1UAK5t13tLxe/Phvpazlc/M/A1M1EgZBa8=;
  b=YtCiUQSs0Cq/COrbMmEXJdrabXv/MgZeVetHc67m5R4Dni7/+LCgTTc8
   mnW7dAetLAErAoiGQtn6WW+ICgZYXH1XRcBKobym4ejtSoXpQail3F/0m
   1HvVNg0klBu9voCsxT9DadySbnAZbZvZn/SNAIneMrawg4v3Oz5pH/aP6
   0hDH9+3KKHMNV8QouLjpqrGVDDsrh8xNvpr7yJTHOyqE4K98djTryCKbu
   RKh3DLxnobFUsz0J2PmJ+MeUkLdVL8DbKhdPEQNe241ltEIyiJuxsIel8
   A9iuPtmuV4Izkmk7WT8Ud6qaHLKKKYRLAipbELk5aGcQKb41q7lm9kuqe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444333397"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="444333397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 08:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1073844798"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="1073844798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 08:29:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 08:29:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 08:29:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 10 Sep 2023 08:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTSZcy5v1xay0ytSgH4BWn3gjsD6cvCkTAgzg3RDIDJuqtPpe8QCbyb/naeP3+lryh2Z8VQEU9hb3qc+lLHnHzp8mZ1/SOdpF1oLgrFs17/DiUR2XmQ93SIqVUozONEu5oOL8TEPF2I+sXtu/O1O7brtxDFhAAmduJ9dN+drdtVuzCghsDu0ByckLfPbIDdACHqlxE5nWGX+6Uj+akaePWCvP56O5ZJEpWEDvSkh2AGC6IZPUUsNuNktITWJBlSdeDEwF0//0pxJ4JTWGGt204g/xiPs/872Zo9BoeZv0uexNNXIFj6hvHPxgwYAtOItrPksT8zkCf6RciNQUWy/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+aCrNggeu3GsjA3nSk468dgNvD9xtu50Q27u16e02Y=;
 b=LDeyGEMHFwvYFRLNANY70Mlcz7TyvD1TBMn2RO5emOqJzyxaadE04+B3ecdnz9y6qsjwejrLq7mR+Tkdmv7MpJhlu5CWGLkFWMZnxWWbQT5MX4+vAAr3n8ewMJ35KUnCPo08UeagWAl1ew7WHuvNVzNR5CjAcSCFra3OqlO43Rru+I6ASFmC4MRlMfqi7wqbe4OOISKoQnX3/yx83mu+z7mA2qIed5m6W0pdkXiYAQpXROjFpNJyJ5geo5ov/Nnqz1t0soCw7eRjZKcKo3OSxeF9IvRSJcwuVLbyJ8FFDBdlti2+WsZg72Fs7QQoRUTOSmh6vMeCDCABoOV1aZ3cAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 15:29:43 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 15:29:42 +0000
Date:   Sun, 10 Sep 2023 23:29:28 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to
 be scanned
Message-ID: <202309102311.84b42068-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <109ca1ea59b9dd6f2daf7b7fbc74e83ae074fbdf.1693287931.git.raghavendra.kt@amd.com>
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f35ca6-aee3-47af-887d-08dbb212c0f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJ3/AJEfJ2cCK9EY9b4QUlCfQ0s49iilXO+gwSSz5fp2FQjUYp6lVoFYh4kgtsaXLbmLH5rbhJpmN5eDvlPzImf/qqN/DCVeRnsyOHx8pqinxnu0Pesh86gF3ppM7l8O2UnnUEWJzrEPWxbSXs85j9yne5I5uF+ZFlgpN+qda5hJrbniGQ8qwkc/Sco5WRyre6L3D4ZpaunnxUmvOkvUkUJjng6AXERoz4muXSet2c5d/JyQeeEw+TeEnaGzayJdLZNz8eXbdDZwGnEZuv+5M501U4q5FcKfVVyZiZ9ohrNq7GrWC2OHGMuyKypKLHOn1+oVPUugCvc/plKVeAS2cFx5dLy4PZWlxXIBKylTrZeAuxYcnEQTcWHqWmn/y2S7NFCngtX77g+MEedKaI0KNclXJe2T6Gzr8BvxQcrre7j++2OUO8ZexopO8TaJRAJa4auUDkuf84iqlCJfduay4hJkR+7rYx8nNu82TLE+xvwipEy2wI15cW0Wp69E47jDOgPQCStoPZ6HcPakt6V/D4lm4LWEJP4INQrIDNTZ1Z0GiGuYRuQ+mookp0ftyXO0owUySgsyKsxzFKIOjVLzYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(83380400001)(86362001)(82960400001)(38100700002)(36756003)(2616005)(1076003)(26005)(316002)(6916009)(7416002)(41300700001)(2906002)(8676002)(4326008)(54906003)(8936002)(66476007)(66946007)(66556008)(478600001)(966005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2cgOTqa5Vir6s3/eO5lL4G8tvaYb7ngrcDkzP52BUlzvXjsZf2z4waEgRh?=
 =?iso-8859-1?Q?5z1yAtX//7I9cCE/vlXQpamU17uCTKftn4deNYglx03/9b5slGg/8/uI3h?=
 =?iso-8859-1?Q?dmJst7hg8JAOokIoDIlBJhlW67pImvtuHp+4EQbW2lvRQ34+nIl4Us/flj?=
 =?iso-8859-1?Q?BFE76CCxPNq7FvYdjfTmANoEZQhHdHaxh4j6sUtbEu2V8xdPMQDaUniDTv?=
 =?iso-8859-1?Q?psBXpotiJRye3WDVYZOVHnFQFRif2GmH5wihJng6V85z6/HPvTTkUuCk9L?=
 =?iso-8859-1?Q?6QvRtK6DN3qW5tUNx4OqCz8cdKr/d7vEaUBVlwQEc7bv1lpkMF3lkNJmbB?=
 =?iso-8859-1?Q?YENC23KvJkBIjXtblSVkTmp+M7V4nqJMUzbE8JEQkgshtX1rZptzr5GQxU?=
 =?iso-8859-1?Q?jtkwbXlao2U6zklmqA1sVYvxd3AyiJreO022ccUnVBLWSF2U22/GbWuVl4?=
 =?iso-8859-1?Q?exxtmECDmLATkYgr55t3iSE6hyYRgmRTY5BynIOZJ+MNUglqpy6CXf4/Vy?=
 =?iso-8859-1?Q?ujcAAiG55z+UgHgKjCXVmz06aaHKtHQIBOGwq2k3qN1RYqfYUUAMGlcfBO?=
 =?iso-8859-1?Q?4YFkvMQCdpD4fGbNuxwX/HoPYqSqBVPSrd5rdA1M6IhK8+SAJp3bNN722S?=
 =?iso-8859-1?Q?2qm1o3MyD2zMgoc74lv7Bl6gMVOHrNs9b5jAUIXzbMT5qUBbVBnG2cDZoz?=
 =?iso-8859-1?Q?GoFLo/rbKXSYu2UYYw0vw9jT0126GMQ2ZvyB9AB1csHEMnA9/sEEPXQkYo?=
 =?iso-8859-1?Q?7hU59paWjyGhHNaK5inW4ZxgDQcPj8zDjZjhHY2F8iPbTeIfNQqDY1h1W/?=
 =?iso-8859-1?Q?0NHnNKIX2/GcQ9gheY5xWsSqtV5hJppEUAkcAfHpifL/4eZSHY+1cYkZ/b?=
 =?iso-8859-1?Q?vbfRRtxODPOsEDGybaEg3Bm67+f7+FIZLp7qNlXzDVIDch9lJt/J5Pj9QN?=
 =?iso-8859-1?Q?pOwB/nfbko4kwrTuPAHYspLORQFrCcYrqU75XHhIDyM0+aiHR6EVvSsbGl?=
 =?iso-8859-1?Q?S8+f8zX4PumpFcnAgT04Lxz+nn0JKOIwBgBXOVVhv/fojYcQtVmFbUMfP+?=
 =?iso-8859-1?Q?83aXxfERKxu4DFwtCQCg5nBw/mmRdoa3xTzUbCrmzUQjK0+7bVC6d6+5S/?=
 =?iso-8859-1?Q?LfN+n4pvNWsdMbJINwp2fV/Sx6gu5K+J7BdIHHsvjhyF4g3VTqbkrFcuVT?=
 =?iso-8859-1?Q?QMzo5LseRr7czixrFspLl+r04f8uJ828GkUlk0J2lavGwK7HSX3GUVrwLg?=
 =?iso-8859-1?Q?XqkrOicwbh4WVIkdPLe0iFsoSpFL3V8A6N5RRNxEE6WhrobtM/X0GiE1AT?=
 =?iso-8859-1?Q?/WV7VqGVnqnzNsN9LcKBs1mCg0NkwI8g/rEWOxYlbOUVD4oOS8Bs52ESOo?=
 =?iso-8859-1?Q?LMUdhdu6H0qLTfwBLoVKUR6NLFS02XTIfcrH6bIxZcTBQgAHWjWGQKK+ke?=
 =?iso-8859-1?Q?2hvNP9FESBhB7rG/IxOWeJV81qry8/wnCfrMDbBcWaC2FfGXyuvVMcMAhG?=
 =?iso-8859-1?Q?4cZm1nDUWsSIPgWJXf7l5H0qj0hisO9ccEnZgtFLuFKVoQhle9v8jXcIkm?=
 =?iso-8859-1?Q?fechwaFDxwcFzSAq1Yx8BNotlRWu7YWVUDJ5b7zKK+I7TOSbR4BJiUQqy/?=
 =?iso-8859-1?Q?8DWPQ3A00oZ8ftKU2ECpNMztzyWDwW2npArM730h+uElXuCCnXr1In1w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f35ca6-aee3-47af-887d-08dbb212c0f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 15:29:42.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTJL3ES5Z7CRyAzB221GXi0b+FM53YyYvZ48NvK0FU07+vpxie/a7z/7H+wBTCQlNEzKGpxHyeeJNZxQwp1MoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
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

kernel test robot noticed a -33.6% improvement of autonuma-benchmark.numa02.seconds on:


commit: af46f3c9ca2d16485912f8b9c896ef48bbfe1388 ("[RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to be scanned")
url: https://github.com/intel-lab-lkp/linux/commits/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2f88c8e802c8b128a155976631f4eb2ce4f3c805
patch link: https://lore.kernel.org/all/109ca1ea59b9dd6f2daf7b7fbc74e83ae074fbdf.1693287931.git.raghavendra.kt@amd.com/
patch subject: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to be scanned

testcase: autonuma-benchmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	iterations: 4x
	test: numa01_THREAD_ALLOC
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230910/202309102311.84b42068-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/numa01_THREAD_ALLOC/autonuma-benchmark

commit: 
  167773d1dd ("sched/numa: Increase tasks' access history")
  af46f3c9ca ("sched/numa: Allow recently accessed VMAs to be scanned")

167773d1ddb5ffdd af46f3c9ca2d16485912f8b9c89 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.534e+10 ± 10%     -13.0%  2.204e+10 ±  7%  cpuidle..time
  26431366 ± 10%     -13.2%   22948978 ±  7%  cpuidle..usage
      0.15 ±  4%      -0.0        0.12 ±  3%  mpstat.cpu.all.soft%
      2.92 ±  3%      +0.4        3.32 ±  4%  mpstat.cpu.all.sys%
      2243 ±  2%     -12.7%       1957 ±  3%  uptime.boot
     29811 ±  8%     -11.1%      26507 ±  6%  uptime.idle
      5.32 ± 79%     -64.2%       1.91 ± 60%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      2.70 ± 18%     +37.8%       3.72 ±  9%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.64 ±137%  +26644.2%     169.91 ±220%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.08 ± 20%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.terminate_walk
      0.10 ± 25%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.wake_up_q
      0.06 ± 50%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.vfs_readlink
      0.15 ± 36%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.readlink
      1.31 ± 19%      +0.4        1.69 ± 12%  perf-profile.children.cycles-pp.unmap_vmas
      2.46 ± 19%      +0.5        2.99 ±  4%  perf-profile.children.cycles-pp.exit_mmap
    311653 ± 10%     -23.7%     237884 ±  9%  turbostat.C1E
  26018024 ± 10%     -13.1%   22597563 ±  7%  turbostat.C6
      6.41 ±  9%     -13.6%       5.54 ±  8%  turbostat.CPU%c1
      2.47 ± 11%     +36.0%       3.36 ±  6%  turbostat.CPU%c6
 2.881e+08 ±  2%     -12.8%  2.513e+08 ±  3%  turbostat.IRQ
    212.86            +2.8%     218.84        turbostat.RAMWatt
    341.49            -4.1%     327.42 ±  2%  autonuma-benchmark.numa01.seconds
    186.67 ±  6%     -27.1%     136.12 ±  7%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
     21.17 ±  7%     -33.6%      14.05        autonuma-benchmark.numa02.seconds
      2200 ±  2%     -13.0%       1913 ±  3%  autonuma-benchmark.time.elapsed_time
      2200 ±  2%     -13.0%       1913 ±  3%  autonuma-benchmark.time.elapsed_time.max
   1159380 ±  2%     -12.0%    1019969 ±  3%  autonuma-benchmark.time.involuntary_context_switches
   3363550            -5.0%    3194802        autonuma-benchmark.time.minor_page_faults
    243046 ±  2%     -13.3%     210725 ±  3%  autonuma-benchmark.time.user_time
   7494239            -6.8%    6984234        proc-vmstat.numa_hit
    118829 ±  6%     +13.7%     135136 ±  6%  proc-vmstat.numa_huge_pte_updates
   6207618            -8.4%    5686795 ±  2%  proc-vmstat.numa_local
   8834573 ±  3%     +20.2%   10616944 ±  4%  proc-vmstat.numa_pages_migrated
  61094857 ±  6%     +13.6%   69409875 ±  6%  proc-vmstat.numa_pte_updates
   8602789            -9.0%    7827793 ±  2%  proc-vmstat.pgfault
   8834573 ±  3%     +20.2%   10616944 ±  4%  proc-vmstat.pgmigrate_success
    371818           -10.1%     334391 ±  2%  proc-vmstat.pgreuse
     17200 ±  3%     +20.3%      20686 ±  4%  proc-vmstat.thp_migration_success
  16401792 ±  2%     -12.7%   14322816 ±  3%  proc-vmstat.unevictable_pgs_scanned
 1.606e+08 ±  2%     -13.8%  1.385e+08 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
 1.666e+08 ±  2%     -14.0%  1.433e+08 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
 1.364e+08 ±  2%     -11.7%  1.204e+08 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   4795327 ±  7%     -17.5%    3956991 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
 1.606e+08 ±  2%     -13.8%  1.385e+08 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.666e+08 ±  2%     -14.0%  1.433e+08 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
 1.364e+08 ±  2%     -11.7%  1.204e+08 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   4795327 ±  7%     -17.5%    3956991 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
    364.96 ±  6%     +16.6%     425.70 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
   1099114           -13.0%     956021 ±  2%  sched_debug.cpu.clock.avg
   1099477           -13.0%     956344 ±  2%  sched_debug.cpu.clock.max
   1098702           -13.0%     955643 ±  2%  sched_debug.cpu.clock.min
   1080712           -13.0%     940415 ±  2%  sched_debug.cpu.clock_task.avg
   1085309           -13.1%     943557 ±  2%  sched_debug.cpu.clock_task.max
   1064613           -13.0%     925993 ±  2%  sched_debug.cpu.clock_task.min
     28890 ±  3%     -11.7%      25504 ±  3%  sched_debug.cpu.curr->pid.avg
     35200           -11.0%      31344        sched_debug.cpu.curr->pid.max
    862245 ±  3%      -8.7%     786984        sched_debug.cpu.max_idle_balance_cost.max
     74019 ±  9%     -28.2%      53158 ±  7%  sched_debug.cpu.max_idle_balance_cost.stddev
     15507           -11.9%      13667 ±  2%  sched_debug.cpu.nr_switches.avg
     57616 ±  6%     -19.0%      46642 ±  8%  sched_debug.cpu.nr_switches.max
      8460 ±  6%     -12.9%       7368 ±  5%  sched_debug.cpu.nr_switches.stddev
   1098689           -13.0%     955631 ±  2%  sched_debug.cpu_clk
   1097964           -13.0%     954907 ±  2%  sched_debug.ktime
      0.00           +15.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.avg
      0.03           +15.0%       0.03 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.max
      0.00           +15.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.stddev
      0.00           +15.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_running.avg
      0.03           +15.0%       0.03 ±  2%  sched_debug.rt_rq:.rt_nr_running.max
      0.00           +15.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_running.stddev
   1099511           -13.0%     956501 ±  2%  sched_debug.sched_clk
      1162 ±  2%     +15.2%       1339 ±  3%  perf-stat.i.MPKI
 1.656e+08            +3.6%  1.716e+08        perf-stat.i.branch-instructions
      0.95 ±  4%      +0.1        1.03        perf-stat.i.branch-miss-rate%
   1538367 ±  6%     +11.0%    1707146 ±  2%  perf-stat.i.branch-misses
 6.327e+08 ±  3%     +18.7%  7.513e+08 ±  4%  perf-stat.i.cache-misses
 8.282e+08 ±  2%     +15.2%  9.542e+08 ±  3%  perf-stat.i.cache-references
    658.12 ±  3%     -11.4%     582.98 ±  6%  perf-stat.i.cycles-between-cache-misses
 2.201e+08            +2.8%  2.263e+08        perf-stat.i.dTLB-loads
    579771            +0.9%     584915        perf-stat.i.dTLB-store-misses
 1.122e+08            +1.4%  1.138e+08        perf-stat.i.dTLB-stores
 8.278e+08            +3.1%  8.538e+08        perf-stat.i.instructions
     13.98 ±  2%     +14.3%      15.98 ±  3%  perf-stat.i.metric.M/sec
      3797            +4.3%       3958        perf-stat.i.minor-faults
    258749            +8.0%     279391 ±  2%  perf-stat.i.node-load-misses
    261169 ±  2%      +7.4%     280417 ±  5%  perf-stat.i.node-loads
     40.91 ±  3%      -3.0       37.89 ±  3%  perf-stat.i.node-store-miss-rate%
 3.841e+08 ±  6%     +27.6%  4.902e+08 ±  7%  perf-stat.i.node-stores
      3797            +4.3%       3958        perf-stat.i.page-faults
    998.24 ±  2%     +11.8%       1116 ±  2%  perf-stat.overall.MPKI
    463.91            -3.2%     448.99        perf-stat.overall.cpi
    604.23 ±  3%     -15.9%     508.08 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.00            +3.3%       0.00        perf-stat.overall.ipc
     39.20 ±  5%      -4.5       34.70 ±  6%  perf-stat.overall.node-store-miss-rate%
 1.636e+08            +3.8%  1.698e+08        perf-stat.ps.branch-instructions
   1499760 ±  6%     +11.1%    1665855 ±  2%  perf-stat.ps.branch-misses
 6.296e+08 ±  3%     +19.0%  7.489e+08 ±  4%  perf-stat.ps.cache-misses
 8.178e+08 ±  2%     +15.5%  9.447e+08 ±  3%  perf-stat.ps.cache-references
  2.18e+08            +2.9%  2.244e+08        perf-stat.ps.dTLB-loads
    578148            +0.9%     583328        perf-stat.ps.dTLB-store-misses
 1.117e+08            +1.4%  1.132e+08        perf-stat.ps.dTLB-stores
 8.192e+08            +3.3%   8.46e+08        perf-stat.ps.instructions
      3744            +4.3%       3906        perf-stat.ps.minor-faults
    255974            +8.2%     276924 ±  2%  perf-stat.ps.node-load-misses
    263796 ±  2%      +7.7%     284110 ±  5%  perf-stat.ps.node-loads
  3.82e+08 ±  6%     +27.7%  4.879e+08 ±  7%  perf-stat.ps.node-stores
      3744            +4.3%       3906        perf-stat.ps.page-faults
 1.805e+12 ±  2%     -10.1%  1.622e+12 ±  2%  perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

