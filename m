Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C655798187
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjIHF1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjIHF1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:27:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB919B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694150832; x=1725686832;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=zZsu6gy26XsZqPTTqNpzcR4jfR4gF2ToOZNE14wx4dM=;
  b=hxIKg4RWXbivjbRrvCOmlgu4ZM4RkrpIIeIFb2gBfs5ttp9cQseA6XFV
   gM0C8+Wh+I7s3tu5iNOxl736WobacHkIPj0vwmwZI4PjKoKfKnPpkHQSj
   LDcpccKz6Eq3NPTlD9KUed8DdQFunyhcknayKZAvboaL2/C3J2gBsGl+H
   PUU4jbN5+kL9viHdIILeMMwjos/gaxozldCo/jprBi8UpTAN/OV4ayejM
   9eL19JxwUZZQpf0MQXGfRSCbjuDHNntovA/VGcT17kHEQW6GtX4lPpkxJ
   Dbt29mY0NxW9zDVubRPXwjw/CZa6p00EX08T1wv2CrxAJvQ0zLh23gqRM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357025543"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="357025543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 22:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807879334"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807879334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 22:27:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 22:27:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 22:27:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 22:27:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 22:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc5jCL9VoVQoHwZLGRgIcTyrGBIGhTDmcvTLgoHLB9O8Dtq6KWvpl+OLb6ARB/OwxY3GNeCxTb7A1NM5sSg7fnnPWxMAshtby97ajeE1Vn+Wu9zUYcAWBZd2Jf+5l7/z1twFUaG/lOeb4E6g7KMCi2Pkpm/kQGqRtyvon909rXNkHsTy6bSg/bZ9B2FwED9dhQEsJUlNILqcgWa3Wtr3+yzzk/nq7OvFfkLF35X1P+IYcrLL92/l0cJIUrnjSM73szBLPWItCfzQoCGPXbnJEJgzZn2mkPIq1S/6WfGNX7wO2nHB4W9bJlXcubxnuimKrjgY5SwtCuXi5v2Msvfnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48+Npgl9HFXSvjAZNeE/Pdy+95FXq0RjguljUn8Tnh0=;
 b=O6Dja+sw0/9DMtCkUFRezix789HY6VStRpdOcjMdCjxuaz2YVqeKWS+AmGHR3ZBJoehDEYfxOzU7i3VQjAMEQ2QoEdOyJUF483sz2/fE8rnqhX/IzOD03MUInpk1C+ezPciWJfAEWijUZFEeZmbRFg1VGwYbdKn1dUPibh6ovOCnkik5rvHW64q/rfm2Mw0qKlMtYLhx1sbv9GgP3qf1jMUlgy1Io3E4erMrjv5HAShMWM0XRfprSPCDnR7W1vUoXqsGJgCGogZSuApZ/SXKFydDj3SmET6godP55b5yXtrSqZOHrOmM2OEbKCd9gRl12i8CNjn2u2CGRQU4SdB2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 05:27:06 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 05:27:06 +0000
Date:   Fri, 8 Sep 2023 13:26:57 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Message-ID: <202309081306.3ecb3734-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: db276909-6dae-461d-7d06-08dbb02c3dbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgvAKbfxcqeYLeWuDM4wEHgHAgFSzwmw7rVPub0IUqRvdF+XLsZLZHfh3n1qn7fnLJyBJpRqOneiX++cFa39b+XVfgS1+OwUfsWQHsJhRr4VjR5dKsaqrOrPrhgqG65T0ZxS0x/2x6p1rt7t0FZmZrOSGJqCDLufMW9IuZrAlDd+nv5LurEMYDNuXQr4QMDsUgmBJ4XWXVWbuaaOpvCRKcoOIECJ1Rw+H4IJKcxFSoVJjEce0Q7jSQodn9cORky5JK9JG6X+3LPsBm8LQBdwnCuQ6PuBK6O+mAQA2MEej6wirh5vvV7dRPPu15jpcZ4yQiY7gQa0FGvUmUtYH2ZNfqFXzhUgP55436jVslsQDFh525duP6zEI5OgZSWDbOGX/WQJDDBgjGrKSy8z/lomXIUpRPqoqbAQb6nKZy95FviVR4e/IOuGvVo8blMWiaFzXC+rYmxPSfQNzO22yJ4/A9kaPgNbNTac5b5zlqEz48cKof6rGLg24j/h3EdHAlmZpkVYP7kx/sUMnMWe0JCe4Dyig/hY61PJ7bFkHBFqdxFuppqX4U3F0v0IJipLP9yMhNHPSKU+kMAVgEx2qxYPFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(66476007)(6916009)(316002)(2616005)(1076003)(107886003)(6666004)(86362001)(66946007)(66556008)(2906002)(8676002)(41300700001)(4326008)(8936002)(30864003)(5660300002)(38100700002)(966005)(478600001)(6512007)(26005)(6506007)(6486002)(82960400001)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0aAu5nUBMeH0L7dTegMUN+8EJoBYsURAw5w1bMHbWRUCX67uYQAiDTpd1k?=
 =?iso-8859-1?Q?ByszRkQcj4xRQUnt+SM0t2rfk2jXeMRsXjSan2nbPkPFAmrLeNwtLcXpT3?=
 =?iso-8859-1?Q?nOO3LHHCJ/FcEo1ALeVciJ5NH+nAhBZhsVRodZvycJifx4AiGMtNkkM96x?=
 =?iso-8859-1?Q?T5xevD3cTNh52Hq2kkkRWb6UKNfi65aWqlTite/JHvbalWgRXDCK8ALiCo?=
 =?iso-8859-1?Q?XNtEwTUzN0yLHEVr6d+RHBU5BvWvq8RtufpvXHTAJweHr0t8ULl3ocmnPH?=
 =?iso-8859-1?Q?fr3UEDKo1j470CQK4WlLDEiUs3i6xhrBDoseKIxaQTxMHeiDUGH6QKKnsy?=
 =?iso-8859-1?Q?opBPvNvhaqbCtvIH4jsvhC5ZcQ71akHTW5Bd0K5XZTiky2ButwBQi97iDh?=
 =?iso-8859-1?Q?wUu1+ynTOZ/RIVm50UoDCL5eBos4dcszk5jDVPxv5QB+SrXvWNWcXZaqUO?=
 =?iso-8859-1?Q?BsPUqiXPAP27WSNperL5URsyExxCGfgE8IxFQN30eYbwPkwdmr6rWDAXcj?=
 =?iso-8859-1?Q?2+rEGJ0eZk5RM5LVA/9dhIz319OjNVfSuMaLCpuNp3EsV6/md+FtAYxZk4?=
 =?iso-8859-1?Q?322A9hp7DR6eQxuQTosCu3+h7gKh7+CiK84c37F9MG4flIH6MXXMvTW0eW?=
 =?iso-8859-1?Q?1c6s8QTy1i5xhEKKgU3DWUjL0wmzgFtG1GI//XLKVFn3x/3z2OMu1RT2E9?=
 =?iso-8859-1?Q?jtjww7abMmsVhSTtG3QNeYjVnGwEcOh5Xhpd89pSYkmNoMcLmpg2g3rIFA?=
 =?iso-8859-1?Q?XZn6A2zTmp3mxGqZ6R2kBfCC8iqeVUYo272zU5VBORaPGSam+zTIfiENp9?=
 =?iso-8859-1?Q?VRrVaNRpgCMHM5diPtLH8JLdjHSUnQT6WjeroPw1NvEn1cdbjysrAleTza?=
 =?iso-8859-1?Q?xqlC6+pnbcjvS9BbzM3W80ot3jfv2iqgls9dwPRXgcvT4qPkOLXbpmjdNK?=
 =?iso-8859-1?Q?zp8pEvEF62JgmC346SxwDo2rAzVEXCcYvwb64lckBkBHF0f/GTiGa8aSqg?=
 =?iso-8859-1?Q?zCJkpOXb0zO8fiUF5SzuQtSAhQ8XMCAoKeyJLT72RDjZwJvnAepFuw7MuL?=
 =?iso-8859-1?Q?LZgR40e5Mgj9dlIq8DOOdw+0LAqJXYw8ZGSAaHyW4ciPQXujjK7ykbhNaG?=
 =?iso-8859-1?Q?WE33CzGHpJdqU2I5VztqJ1ik1UZ6OPMpD5zyECMuNl8z0S7MfJSKYDW+18?=
 =?iso-8859-1?Q?fEgiVJKvfJ20+pedNuzVSNxDuoqEzfQAyYxIcJrirMSVc2c79WzaWJAkwH?=
 =?iso-8859-1?Q?TN8ktdY3wZeQFQvnl7Ncx0jmXdmpyL/38BNEhlo0CZG4rBISgPRrjC+QTn?=
 =?iso-8859-1?Q?mu2oTzT66C9Bmt6drfp9WIR9cuFKL8RhBAxk0XK650FFaPFaS+DrZxlWZd?=
 =?iso-8859-1?Q?Swq82RwOLMUBXfec2ZqlVY84kJI2kyGyegK5ROPkAzHIdLK2muYCrJZpso?=
 =?iso-8859-1?Q?QCm6WktiOSMpSmHfHcKnnIwi5b499w0re5qnNbDX0hNuiqR9C09icWJAuv?=
 =?iso-8859-1?Q?ORRT73CFXPsKzfFS1F4fAFlGjTD6EEslvN1aC+8bA3CUXFQLrUeWf7Ysff?=
 =?iso-8859-1?Q?26GYAw4L7zzBAQI/Gy1e5npMn+UgXU6hzhaAOfT3ZzH17v3lKjpjNFnZCl?=
 =?iso-8859-1?Q?UXVcpG6oQkMq5viTdPSqgw6PlQRRteLkkN5ClW3VhcJayhVhPU2PJwtA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db276909-6dae-461d-7d06-08dbb02c3dbd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 05:27:06.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wh64ZYN89vDZJS25/EYrNTOElD3IZpCOQnWEbRnwaAZfpRsR65b35COKKh71k0XbFdJg7I+97ToBoBB+o8KgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
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

kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:


commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	testtime: 300s
	test: disk_src
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | aim9: aim9.disk_src.ops_per_sec -14.6% regression                                               |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | test=all                                                                                        |
|                  | testtime=5s                                                                                     |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230908/202309081306.3ecb3734-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/disk_src/aim9/300s

commit: 
  23a31d8764 ("shmem: Refactor shmem_symlink()")
  a2e459555c ("shmem: stable directory offsets")

23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.26 ±  9%      +0.1        0.36 ±  2%  mpstat.cpu.all.soft%
      0.61            -0.1        0.52        mpstat.cpu.all.usr%
      0.16 ± 10%     -18.9%       0.13 ± 12%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.04 ±  7%   +1802.4%       0.78 ±115%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    202424           -19.0%     163868        aim9.disk_src.ops_per_sec
     94.83            -4.2%      90.83        aim9.time.percent_of_cpu_this_job_got
     73.62           -17.6%      60.69        aim9.time.user_time
     23541            +6.5%      25074        proc-vmstat.nr_slab_reclaimable
   1437319 ± 24%    +377.6%    6864201        proc-vmstat.numa_hit
   1387016 ± 25%    +391.4%    6815486        proc-vmstat.numa_local
   4864362 ± 34%    +453.6%   26931180        proc-vmstat.pgalloc_normal
   4835960 ± 34%    +455.4%   26856610        proc-vmstat.pgfree
    538959 ± 24%     -23.2%     414090        sched_debug.cfs_rq:/.load.max
    130191 ± 14%     -13.3%     112846 ±  6%  sched_debug.cfs_rq:/.load.stddev
    116849 ± 27%     -51.2%      56995 ± 20%  sched_debug.cfs_rq:/.min_vruntime.max
      1223 ±191%    -897.4%      -9754        sched_debug.cfs_rq:/.spread0.avg
    107969 ± 29%     -65.3%      37448 ± 39%  sched_debug.cfs_rq:/.spread0.max
     55209 ± 14%     -21.8%      43154 ± 14%  sched_debug.cpu.nr_switches.max
     11.21           +23.7%      13.87        perf-stat.i.MPKI
 7.223e+08            -4.4%  6.907e+08        perf-stat.i.branch-instructions
      2.67            +0.2        2.88        perf-stat.i.branch-miss-rate%
  19988363            +2.8%   20539702        perf-stat.i.branch-misses
     17.36            -2.8       14.59        perf-stat.i.cache-miss-rate%
  40733859           +19.5%   48659982        perf-stat.i.cache-references
      1.76            +3.5%       1.82        perf-stat.i.cpi
     55.21            +5.4%      58.21 ±  2%  perf-stat.i.cpu-migrations
  1.01e+09            -3.8%  9.719e+08        perf-stat.i.dTLB-loads
      0.26 ±  4%      -0.0        0.23 ±  3%  perf-stat.i.dTLB-store-miss-rate%
   2166022 ±  4%      -6.9%    2015917 ±  3%  perf-stat.i.dTLB-store-misses
 8.503e+08            +5.5%  8.968e+08        perf-stat.i.dTLB-stores
     69.22 ±  4%      +6.4       75.60        perf-stat.i.iTLB-load-miss-rate%
    316455 ± 12%     -31.6%     216531 ±  3%  perf-stat.i.iTLB-loads
 3.722e+09            -3.1%  3.608e+09        perf-stat.i.instructions
      0.57            -3.3%       0.55        perf-stat.i.ipc
    865.04           -10.4%     775.02 ±  3%  perf-stat.i.metric.K/sec
     47.51            -2.1       45.37        perf-stat.i.node-load-miss-rate%
    106705 ±  3%     +14.8%     122490 ±  5%  perf-stat.i.node-loads
    107169 ±  4%     +29.0%     138208 ±  7%  perf-stat.i.node-stores
     10.94           +23.3%      13.49        perf-stat.overall.MPKI
      2.77            +0.2        2.97        perf-stat.overall.branch-miss-rate%
     17.28            -2.7       14.56        perf-stat.overall.cache-miss-rate%
      1.73            +3.4%       1.79        perf-stat.overall.cpi
      0.25 ±  4%      -0.0        0.22 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     69.20 ±  4%      +6.4       75.60        perf-stat.overall.iTLB-load-miss-rate%
      0.58            -3.2%       0.56        perf-stat.overall.ipc
     45.25            -2.2       43.10        perf-stat.overall.node-load-miss-rate%
 7.199e+08            -4.4%  6.883e+08        perf-stat.ps.branch-instructions
  19919808            +2.8%   20469001        perf-stat.ps.branch-misses
  40597326           +19.5%   48497201        perf-stat.ps.cache-references
     55.06            +5.4%      58.03 ±  2%  perf-stat.ps.cpu-migrations
 1.007e+09            -3.8%  9.686e+08        perf-stat.ps.dTLB-loads
   2158768 ±  4%      -6.9%    2009174 ±  3%  perf-stat.ps.dTLB-store-misses
 8.475e+08            +5.5%  8.937e+08        perf-stat.ps.dTLB-stores
    315394 ± 12%     -31.6%     215816 ±  3%  perf-stat.ps.iTLB-loads
  3.71e+09            -3.1%  3.595e+09        perf-stat.ps.instructions
    106351 ±  3%     +14.8%     122083 ±  5%  perf-stat.ps.node-loads
    106728 ±  4%     +29.1%     137740 ±  7%  perf-stat.ps.node-stores
 1.117e+12            -3.0%  1.084e+12        perf-stat.total.instructions
      0.00            +0.8        0.75 ± 12%  perf-profile.calltrace.cycles-pp.__call_rcu_common.xas_store.__xa_erase.xa_erase.simple_offset_remove
      0.00            +0.8        0.78 ± 34%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_create.xas_store
      0.00            +0.8        0.83 ± 29%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_expand
      0.00            +0.9        0.92 ± 26%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_expand.xas_create
      0.00            +1.0        0.99 ± 27%  perf-profile.calltrace.cycles-pp.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_lru.xas_alloc
      0.00            +1.0        1.04 ± 28%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.xas_alloc.xas_create.xas_store.__xa_alloc
      0.00            +1.1        1.11 ± 26%  perf-profile.calltrace.cycles-pp.xas_alloc.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic
      1.51 ± 24%      +1.2        2.73 ± 10%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.24 ± 20%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.xas_alloc.xas_expand.xas_create.xas_store
      0.00            +1.3        1.27 ± 10%  perf-profile.calltrace.cycles-pp.xas_store.__xa_erase.xa_erase.simple_offset_remove.shmem_unlink
      0.00            +1.3        1.30 ± 10%  perf-profile.calltrace.cycles-pp.__xa_erase.xa_erase.simple_offset_remove.shmem_unlink.vfs_unlink
      0.00            +1.3        1.33 ± 19%  perf-profile.calltrace.cycles-pp.xas_alloc.xas_expand.xas_create.xas_store.__xa_alloc
      0.00            +1.4        1.36 ± 10%  perf-profile.calltrace.cycles-pp.xa_erase.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat
      0.00            +1.4        1.37 ± 10%  perf-profile.calltrace.cycles-pp.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.00            +1.5        1.51 ± 17%  perf-profile.calltrace.cycles-pp.xas_expand.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic
      0.00            +1.6        1.62 ± 12%  perf-profile.calltrace.cycles-pp.shmem_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.00            +2.8        2.80 ± 13%  perf-profile.calltrace.cycles-pp.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add
      0.00            +2.9        2.94 ± 13%  perf-profile.calltrace.cycles-pp.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod
      5.38 ± 24%      +3.1        8.51 ± 11%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      6.08 ± 24%      +3.2        9.24 ± 12%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.00            +3.2        3.20 ± 13%  perf-profile.calltrace.cycles-pp.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
      0.00            +3.2        3.24 ± 13%  perf-profile.calltrace.cycles-pp.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
      0.00            +3.4        3.36 ± 14%  perf-profile.calltrace.cycles-pp.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups.path_openat
      2.78 ± 25%      +3.4        6.17 ± 12%  perf-profile.calltrace.cycles-pp.shmem_mknod.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.16 ± 30%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.map_id_up
      0.02 ±146%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.shmem_is_huge
      0.02 ±141%      +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.free_unref_page
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.shmem_destroy_inode
      0.04 ±101%      +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.xas_find_marked
      0.02 ±144%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.03 ±106%      +0.2        0.19 ± 26%  perf-profile.children.cycles-pp.xas_descend
      0.01 ±223%      +0.2        0.17 ± 15%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.11 ± 22%      +0.2        0.29 ± 16%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.02 ±146%      +0.2        0.24 ± 13%  perf-profile.children.cycles-pp.__alloc_pages
      0.36 ± 79%      +0.6        0.98 ± 15%  perf-profile.children.cycles-pp.__slab_free
      0.50 ± 26%      +0.7        1.23 ± 14%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.8        0.82 ± 13%  perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.00            +1.1        1.14 ± 17%  perf-profile.children.cycles-pp.radix_tree_node_ctor
      0.16 ± 86%      +1.2        1.38 ± 16%  perf-profile.children.cycles-pp.setup_object
      1.52 ± 25%      +1.2        2.75 ± 10%  perf-profile.children.cycles-pp.vfs_unlink
      0.36 ± 22%      +1.3        1.63 ± 12%  perf-profile.children.cycles-pp.shmem_unlink
      0.00            +1.3        1.30 ± 10%  perf-profile.children.cycles-pp.__xa_erase
      0.20 ± 79%      +1.3        1.53 ± 15%  perf-profile.children.cycles-pp.shuffle_freelist
      0.00            +1.4        1.36 ± 10%  perf-profile.children.cycles-pp.xa_erase
      0.00            +1.4        1.38 ± 10%  perf-profile.children.cycles-pp.simple_offset_remove
      0.00            +1.5        1.51 ± 17%  perf-profile.children.cycles-pp.xas_expand
      0.26 ± 78%      +1.6        1.87 ± 13%  perf-profile.children.cycles-pp.allocate_slab
      0.40 ± 49%      +1.7        2.10 ± 13%  perf-profile.children.cycles-pp.___slab_alloc
      1.30 ± 85%      +2.1        3.42 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      1.56 ± 27%      +2.4        3.93 ± 11%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +2.4        2.44 ± 12%  perf-profile.children.cycles-pp.xas_alloc
      2.66 ± 13%      +2.5        5.14 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
     11.16 ± 10%      +2.7       13.88 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.77 ± 10%      +2.7       14.49 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.82 ± 13%  perf-profile.children.cycles-pp.xas_create
      5.40 ± 24%      +3.1        8.52 ± 11%  perf-profile.children.cycles-pp.lookup_open
      6.12 ± 24%      +3.1        9.27 ± 12%  perf-profile.children.cycles-pp.open_last_lookups
      0.00            +3.2        3.22 ± 13%  perf-profile.children.cycles-pp.__xa_alloc
      0.00            +3.2        3.24 ± 13%  perf-profile.children.cycles-pp.__xa_alloc_cyclic
      0.00            +3.4        3.36 ± 14%  perf-profile.children.cycles-pp.simple_offset_add
      2.78 ± 25%      +3.4        6.18 ± 12%  perf-profile.children.cycles-pp.shmem_mknod
      0.00            +4.2        4.24 ± 12%  perf-profile.children.cycles-pp.xas_store
      0.14 ± 27%      -0.1        0.08 ± 21%  perf-profile.self.cycles-pp.map_id_up
      0.00            +0.1        0.06 ± 24%  perf-profile.self.cycles-pp.shmem_destroy_inode
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.__xa_alloc
      0.02 ±146%      +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      0.01 ±223%      +0.1        0.10 ± 28%  perf-profile.self.cycles-pp.shuffle_freelist
      0.00            +0.1        0.11 ± 40%  perf-profile.self.cycles-pp.xas_create
      0.00            +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.xas_find_marked
      0.00            +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.xas_alloc
      0.03 ±103%      +0.1        0.17 ± 29%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.xas_expand
      0.10 ± 22%      +0.2        0.27 ± 16%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.4        0.36 ± 16%  perf-profile.self.cycles-pp.xas_store
      0.32 ± 30%      +0.4        0.71 ± 12%  perf-profile.self.cycles-pp.__call_rcu_common
      0.18 ± 27%      +0.5        0.65 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.36 ± 79%      +0.6        0.96 ± 15%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.8        0.80 ± 14%  perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.00            +1.0        1.01 ± 16%  perf-profile.self.cycles-pp.radix_tree_node_ctor


***************************************************************************************************
lkp-ivb-2ep1: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/all/aim9/5s

commit: 
  23a31d8764 ("shmem: Refactor shmem_symlink()")
  a2e459555c ("shmem: stable directory offsets")

23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9781285            +2.0%    9975309        proc-vmstat.pgalloc_normal
   4481052            -1.6%    4408359        proc-vmstat.pgfault
   9749965            +2.0%    9942285        proc-vmstat.pgfree
     14556            -1.6%      14324        perf-stat.i.minor-faults
     14556            -1.6%      14324        perf-stat.i.page-faults
     14505            -1.6%      14272        perf-stat.ps.minor-faults
     14505            -1.6%      14272        perf-stat.ps.page-faults
    849714            -3.6%     819341        aim9.brk_test.ops_per_sec
    478138            +3.1%     492806        aim9.dgram_pipe.ops_per_sec
    199087           -14.6%     170071        aim9.disk_src.ops_per_sec
    286595            -9.7%     258794        aim9.link_test.ops_per_sec
    303603            -2.8%     295009        aim9.page_test.ops_per_sec
   3692190            -1.7%    3629732        aim9.time.minor_page_faults
      0.00            +1.0        0.95 ± 25%  perf-profile.calltrace.cycles-pp.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add
      0.00            +1.0        1.01 ± 23%  perf-profile.calltrace.cycles-pp.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod
      1.54 ± 22%      +1.1        2.61 ± 22%  perf-profile.calltrace.cycles-pp.shmem_mknod.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.00            +1.2        1.15 ± 21%  perf-profile.calltrace.cycles-pp.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
      0.00            +1.2        1.18 ± 21%  perf-profile.calltrace.cycles-pp.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
      0.00            +1.2        1.22 ± 21%  perf-profile.calltrace.cycles-pp.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups.path_openat
      0.28 ± 21%      +0.2        0.45 ± 24%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.3        0.26 ± 43%  perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.14 ± 46%      +0.3        0.45 ± 20%  perf-profile.children.cycles-pp.setup_object
      0.00            +0.3        0.33 ± 24%  perf-profile.children.cycles-pp.radix_tree_node_ctor
      0.16 ± 49%      +0.4        0.52 ± 24%  perf-profile.children.cycles-pp.shuffle_freelist
      0.23 ± 43%      +0.4        0.63 ± 23%  perf-profile.children.cycles-pp.allocate_slab
      0.30 ± 35%      +0.4        0.74 ± 24%  perf-profile.children.cycles-pp.___slab_alloc
      0.17 ± 25%      +0.5        0.66 ± 23%  perf-profile.children.cycles-pp.shmem_unlink
      0.00            +0.5        0.49 ± 24%  perf-profile.children.cycles-pp.__xa_erase
      0.00            +0.5        0.52 ± 24%  perf-profile.children.cycles-pp.xa_erase
      0.00            +0.5        0.52 ± 64%  perf-profile.children.cycles-pp.xas_expand
      0.00            +0.5        0.53 ± 24%  perf-profile.children.cycles-pp.simple_offset_remove
      0.87 ± 26%      +0.7        1.56 ± 23%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      2.44 ± 12%      +0.8        3.25 ± 13%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.8        0.82 ± 24%  perf-profile.children.cycles-pp.xas_alloc
      0.01 ±230%      +1.0        0.99 ± 23%  perf-profile.children.cycles-pp.xas_create
      1.55 ± 22%      +1.1        2.63 ± 22%  perf-profile.children.cycles-pp.shmem_mknod
      0.00            +1.2        1.16 ± 21%  perf-profile.children.cycles-pp.__xa_alloc
      0.00            +1.2        1.18 ± 21%  perf-profile.children.cycles-pp.__xa_alloc_cyclic
      0.00            +1.2        1.22 ± 21%  perf-profile.children.cycles-pp.simple_offset_add
      0.18 ± 28%      +1.5        1.65 ± 21%  perf-profile.children.cycles-pp.xas_store
      0.11 ± 31%      +0.1        0.25 ± 27%  perf-profile.self.cycles-pp.xas_store
      0.11 ± 31%      +0.2        0.28 ± 24%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.00            +0.3        0.26 ± 44%  perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.00            +0.3        0.29 ± 23%  perf-profile.self.cycles-pp.radix_tree_node_ctor



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

