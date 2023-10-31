Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AA7DC61D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjJaFuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjJaFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:50:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2FC1;
        Mon, 30 Oct 2023 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698731398; x=1730267398;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=UK+7dBFdp0rMSADleKUC+6VHrNA1iIn27BE1xMMtK00=;
  b=R/ewWcn/9S61M7YvXV4WMv79dAA8XXqwdmHh9c0i7hWnybJhXTuAzofs
   6u1LI32Dwo7CEvoEe/sXQWncPkPuzXGMU3avsbPblwl45BHByOVJumfQi
   NZ8ADiub/EfVJn/04egC5O418gceO3JwUhM0jBwDgjUKiu7d+qNiAg/3e
   v41WydwwTBT6rcg0Ew/DGEsff+s6R2WCkmEoGw17QTs19QPONP5D3a4Ih
   4icguQ1IfhjPtRZcdXZMlIpbHb7kD5PKLZIst51RAMDgMZ0VyApCY4vv8
   0D2cM+Tzf5MyL5p3WbpPgsfEEEZgVaDxIOE3JDzB4NlXtO0yDNlKnHVPj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9749964"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="9749964"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 22:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884102848"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="884102848"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 22:49:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:49:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 22:49:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 22:49:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 22:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj3YisARxQL9qAjzxV+Gj4LNBhc+xvX/s9ATno/OFlrHTAinKFat20NXVq3Jhntw6ZI3WCozjf3dQCvT82ucvlELQlQGXQMIU9J9P0Y7h3ocWpDtzftnP1Quadv9KzV7I6vXzU15az04ndO7SPcawC0FdFruBOGtm6hsM2si8jbTRhkCmxNWLRjY1fefNYBhifvhRFJ/SfOlvlTzptTl8YLBbTk1/afObA3KXILlueZu0c74Vh8kas51lb+zCpLNGDEG1A+pPVSSacaPlLr0KizFmGlHlRHfKwyRazWNRRAxWM73Ssx9qkwFwcaT5Zbm7+RBs0sLVlHpOcRO9T/2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq4AZ9CDyk8idmE+kAg1qcLDcrcuYA3NjTn7LhS1P1I=;
 b=VcwoVZ7ZbQagw25FmH8dRpnkG9BA/0mzNcZ8mq0sjb8OiZZgnNmvR8Gm13H74emxdx0MJM9WqVvJfX0uoC6nm3j30i1V/UdeXzcIgYSuO2ycJRC204Ko6XsBevkA7KC4BBwafAED0u2CacArCRlcMLttKkcp8ZPYvmvPxMd5c8LTaCvvNbI+nv0Y8npPUpT7HXimd6IXlfXapUs8jk+4BF+qAeuaGwbKmDbTwAyE2AsNjf5pnjvYxqRee7DRdXKyKCLn92lPX/fo6OLyBUXs3MlPyiStqPN2msCC6DoVRRIlsAh3Gzg6e0RukJ52KBFn4jjjcVNLJaOja4WSS/9HdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 05:49:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 05:49:51 +0000
Date:   Tue, 31 Oct 2023 13:49:42 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>,
        <linux-xfs@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [xfs]  62334fab47:  stress-ng.rename.ops_per_sec 4.5%
 improvement
Message-ID: <202310311328.77701e96-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: db1346c9-8f0a-458f-357c-08dbd9d532e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK3SCMNyRwB9y2WpxMdYvRez1GQszKHMTs87zxemyTuztT5hmxWRA4abE4wQ4hOU2okKkIl2m+U0/Tsf+rh9cOm7zX4ADAXByqefHsT5afWXv3yoF3WWqxJiWfFy4EwO+UFLbUrSNjknrzT4qhMhGAUkpazxvIIUtcjThzKMgKLH6+49xPO65NT4XAWMOD464W5sg+PW8xq9F/7S3JDph/ofFeR9F54WSnGB7PJKA2eqJB0STYHnb8PHwYcn30g3AfxWNiFUGfQBrxO5ks8ZdzMT2T9LN16eaZHuv46hlohAX6WGmNwyBHeODi8PfBQ8yt6fZFOY40377MIH6dW7JQC0DyhXT7Oyb+2G2AbwwjZhkw9gQjDVN3Z4i3/rvR1pqPYsPC0d076EKx+6BdMduaDsMQtFYSpz+ZameUA0+7FukxtbmKIacmZdnXhZvLpRvx+ZnGppFThfVUhV+JHzX0TbHKT3YIBuU68IIfVzvybS27va+6Aw1YAu86RcPA9C/J4bCtdU42bR0K3oNkEUB+Ujb5typvJBRWPeJzWShhFdGjtXiW5oOxxurqUhWCepkj6eBjFxZGRlmpoIhsHAxx9nFNwJz6PavH32ZPUywt+eFe+zGj5fNaSNkH8zRSJaFB3/jJlfrwCNMklBb10GcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230373577357003)(230473577357003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6916009)(316002)(66476007)(66556008)(66946007)(36756003)(6506007)(6666004)(6512007)(2616005)(26005)(1076003)(107886003)(38100700002)(82960400001)(83380400001)(86362001)(478600001)(966005)(6486002)(4326008)(5660300002)(41300700001)(8676002)(8936002)(30864003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y0gD+fE8o44dtAP3ilg2MlD2LjsCCUvXb3SQQniZsOX2JTO8lURBRNgjok?=
 =?iso-8859-1?Q?iQmNal9XNLdYHUVSO3z63N5uPSDq6BAS7KULw9J5YJqWg5FE1RXDDZ3SX5?=
 =?iso-8859-1?Q?QF05mPFJUZRdOoUO7STxiOEjQ3njKQnPU3myh5sbVUIDaGIBxKWUPoD54Y?=
 =?iso-8859-1?Q?vTvKHguydPLwneSiuu1kjyqZG5kZX37Cl1Tsn49ojh7yOkKJH4Lgjek49n?=
 =?iso-8859-1?Q?HYzMZeKSb7GRRz5VFA9DoHdroaV1HcNnPSfTUnUcKGpJo8FdhgTXuD5Eqj?=
 =?iso-8859-1?Q?8UGe8vyFtg2EPuutNDZFhvN4+SNezBdKWwMnnUQr5NqUvAGCnSp9TY9vI6?=
 =?iso-8859-1?Q?InRwv0r3sr7IAVRnIbF7fwzNRHWBO94uspOtyKGBFaKyRBKG8clIArb/GD?=
 =?iso-8859-1?Q?yPM4cHJIhvaiLpSsAXZTm9rGb2Il+yNJjnhCDQpr9v2plIE2e3sHxHLTBo?=
 =?iso-8859-1?Q?1Jx06BmSHIKcB6nxZ1pOj9owDNubzjWUzFF3K3gvbN3YmhaQWUo6G0Whsu?=
 =?iso-8859-1?Q?3hEs5+IB2rbZErKB4Cr3H9l0y4At94ilHdYbYqexdorQG/X7cogsjrAi6l?=
 =?iso-8859-1?Q?1GPT856XYw2JcwtshT3DmY2GUVVkHbxc9fI4S7KmJi3lWMJGUACKJ62JpX?=
 =?iso-8859-1?Q?OEiOjTwl3P/YZY3FNBU2weetGSfswE+PcqjC1UTituh1RTDa1vvJKbA3gv?=
 =?iso-8859-1?Q?Vzn6F7J4S8DilL3kVMMwFIKZm1kzlLwK4GLpcnW/54GVsagXtiQgq4vahT?=
 =?iso-8859-1?Q?++g9qpN7Wd6HGKXMK/yQFjCS9XL4btG1IC5xlnWpM2EzOoi3Cc1iTJkBE/?=
 =?iso-8859-1?Q?/DFzkJSf1EcTqktOAU/BGmZi9E6UKqtC4VJqihi6ls/IRM5ugI6yjl6out?=
 =?iso-8859-1?Q?0E2fMj/NKwjby187un7/Fd/t9sGBEbVmcbW6UGEiTLbY7CBNHhQII7tYXi?=
 =?iso-8859-1?Q?vCm8TW8oiu/2LNPjBaExky03Ku6dtI0X6sOxXa08FDENMeuK/6F+zKm0/q?=
 =?iso-8859-1?Q?4VLbHvluCUUe0AIuGm9PsYl/bjp7zUvfHZ0ZRckEwDrJ5Nybj1F5PR+yiX?=
 =?iso-8859-1?Q?8akvANd46QOOSsJAnjyelzxNS4+QbDAVT65qSBdy/Q/jGneqVnM14tNVvp?=
 =?iso-8859-1?Q?Ee9kD/ViEpayQbezlzXstt+FQdMoayLizEOfBqHoD2Lx4F0Ggn8NBxVXcW?=
 =?iso-8859-1?Q?HvRWaLGqC+qQ9eC1FuatFMCHBGmALzPRwCQSN0KnLY6L9bpSzZWFHDawIB?=
 =?iso-8859-1?Q?2hSqszO7uFhdTJhso9Njie/KL1kIx8H3rqefTJ008RCyj7WXMAVh7Pgzqo?=
 =?iso-8859-1?Q?HVvNwJGnQ1IEIqQcq+CRruazjiBYsWyPM+mG6BtrWQ/SAQcCYWXbGAEcBH?=
 =?iso-8859-1?Q?9Tkn9NBJ6Qh20JGOcCG1aaIOCX9whzCt3kI0BOA/lsLDXPA47GS9TW505u?=
 =?iso-8859-1?Q?W019VyxRQj/+vE9U+QpabLhLJKznMUiMshLotaZ+YF2i95ojE8GoSm9h3Z?=
 =?iso-8859-1?Q?GWK+egUoN0qeCflcgnmD6rCZdHjwro+UdstTXSe/IaIRjfqGGg4/gtFXfQ?=
 =?iso-8859-1?Q?1yweiA4wbFEQIwuZ/MMX0oFiv09GgHE2qeRUppb4S2cj7CbSHJFGTSXuh1?=
 =?iso-8859-1?Q?I8j9nm1UwJasdp4ksOuVP6XLvbsnNnJkIq5xyW5S96MGRp3UZU5jOFxQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db1346c9-8f0a-458f-357c-08dbd9d532e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 05:49:51.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRHLnHzM7rZxXQZKbjGVYbFbguI2X4dIIoI/Q5d5R1O31SM9orO0gTJV8IZ/wZ4RNJ6cj7WrakdA2WKNMlPgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 4.5% improvement of stress-ng.rename.ops_per_sec on:


commit: 62334fab47621dd91ab30dd5bb6c43d78a8ec279 ("xfs: use per-mount cpumask to track nonempty percpu inodegc lists")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: rename
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.symlink.ops_per_sec 2.1% improvement                                |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory |
| test parameters  | class=filesystem                                                                         |
|                  | cpufreq_governor=performance                                                             |
|                  | disk=1SSD                                                                                |
|                  | fs=xfs                                                                                   |
|                  | nr_threads=10%                                                                           |
|                  | test=symlink                                                                             |
|                  | testtime=60s                                                                             |
+------------------+------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.link.ops_per_sec 3.2% improvement                                   |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory |
| test parameters  | class=filesystem                                                                         |
|                  | cpufreq_governor=performance                                                             |
|                  | disk=1SSD                                                                                |
|                  | fs=xfs                                                                                   |
|                  | nr_threads=10%                                                                           |
|                  | test=link                                                                                |
|                  | testtime=60s                                                                             |
+------------------+------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231031/202310311328.77701e96-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/rename/stress-ng/60s

commit: 
  ecd49f7a36 ("xfs: fix per-cpu CIL structure aggregation racing with dying cpus")
  62334fab47 ("xfs: use per-mount cpumask to track nonempty percpu inodegc lists")

ecd49f7a36fbccc8 62334fab47621dd91ab30dd5bb6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3065 ± 17%     +21.5%       3724 ±  8%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3065 ± 17%     +21.5%       3724 ±  8%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
  13731223            +4.5%   14352233        stress-ng.rename.ops
    228654            +4.5%     238992        stress-ng.rename.ops_per_sec
    208138            +4.1%     216733 ±  3%  stress-ng.time.voluntary_context_switches
      1.14            +0.0        1.17        perf-stat.i.branch-miss-rate%
      0.97            +1.5%       0.99        perf-stat.i.cpi
      0.03            +0.0        0.03        perf-stat.i.dTLB-load-miss-rate%
    798812            +3.5%     827138        perf-stat.i.dTLB-load-misses
      0.00 ± 11%      -0.0        0.00 ± 17%  perf-stat.i.dTLB-store-miss-rate%
 1.321e+09            +2.8%  1.359e+09        perf-stat.i.dTLB-stores
      1.03            -1.4%       1.02        perf-stat.i.ipc
    263342            +4.0%     273811 ±  2%  perf-stat.i.node-loads
      0.12 ±  2%      +3.6%       0.12        perf-stat.overall.MPKI
      0.97            +1.4%       0.99        perf-stat.overall.cpi
      0.03            +0.0        0.03        perf-stat.overall.dTLB-load-miss-rate%
      1.03            -1.4%       1.01        perf-stat.overall.ipc
    786211            +3.5%     814068        perf-stat.ps.dTLB-load-misses
   1.3e+09            +2.8%  1.337e+09        perf-stat.ps.dTLB-stores
    259165            +4.0%     269495 ±  2%  perf-stat.ps.node-loads
      2.99 ±  4%      -2.3        0.66 ± 10%  perf-profile.calltrace.cycles-pp.xfs_inodegc_queue_all.xfs_fs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs
      0.62 ±  6%      +0.1        0.71 ±  8%  perf-profile.calltrace.cycles-pp.lookup_dcache.lookup_one_qstr_excl.do_renameat2.__x64_sys_rename.do_syscall_64
      0.60 ±  5%      +0.1        0.68 ±  9%  perf-profile.calltrace.cycles-pp.d_lookup.lookup_dcache.lookup_one_qstr_excl.do_renameat2.__x64_sys_rename
      0.82 ±  6%      +0.1        0.94 ±  7%  perf-profile.calltrace.cycles-pp.d_move.vfs_rename.do_renameat2.__x64_sys_rename.do_syscall_64
      0.68 ±  6%      +0.1        0.81 ±  7%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.__d_alloc.d_alloc.lookup_one_qstr_excl.do_renameat2
      1.58 ±  3%      +0.2        1.74 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_rename.xfs_vn_rename.vfs_rename
      0.98 ±  4%      +0.2        1.15 ±  7%  perf-profile.calltrace.cycles-pp.xfs_dir_removename.xfs_rename.xfs_vn_rename.vfs_rename.do_renameat2
      0.96 ± 11%      +0.2        1.20 ±  8%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.do_renameat2.__x64_sys_rename.do_syscall_64
      1.53 ±  3%      +0.2        1.78 ±  7%  perf-profile.calltrace.cycles-pp.xfs_inode_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit
      1.94 ±  3%      +0.3        2.19 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_rename.xfs_vn_rename.vfs_rename.do_renameat2
      1.19 ± 10%      +0.3        1.45 ±  9%  perf-profile.calltrace.cycles-pp.__mutex_lock.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.78 ±  3%      +0.3        2.05 ±  7%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_rename
      2.24 ±  4%      +0.3        2.53 ±  8%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__statfs
      2.61 ±  3%      +0.3        2.94 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_rename.xfs_vn_rename
      2.41 ±  4%      +0.4        2.82 ± 10%  perf-profile.calltrace.cycles-pp.path_parentat.__filename_parentat.do_renameat2.__x64_sys_rename.do_syscall_64
      2.25 ±  4%      +0.4        2.69 ±  6%  perf-profile.calltrace.cycles-pp._find_next_or_bit.__percpu_counter_sum.xfs_fs_statfs.statfs_by_dentry.user_statfs
      2.74 ±  4%      +0.5        3.23 ±  9%  perf-profile.calltrace.cycles-pp.__filename_parentat.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ±223%      +0.5        0.58 ±  5%  perf-profile.calltrace.cycles-pp.path_init.path_parentat.__filename_parentat.do_renameat2.__x64_sys_rename
      4.69 ±  2%      +0.6        5.32 ±  8%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_rename.xfs_vn_rename.vfs_rename
      8.39 ±  4%      +1.2        9.54 ±  9%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.xfs_fs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs
     29.06 ±  2%      +3.9       32.91 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rename
     30.82 ±  2%      +4.1       34.94 ±  7%  perf-profile.calltrace.cycles-pp.rename
      3.00 ±  4%      -2.3        0.66 ± 10%  perf-profile.children.cycles-pp.xfs_inodegc_queue_all
      0.68 ±  7%      -0.5        0.13 ± 16%  perf-profile.children.cycles-pp._find_next_bit
      0.10 ± 12%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.kfree
      0.08 ± 16%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.__x64_sys_statfs
      0.31 ±  8%      +0.0        0.36 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.33 ±  7%      +0.1        0.40 ±  9%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.11 ± 11%      +0.1        0.18 ± 28%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.40 ±  7%      +0.1        0.47 ± 10%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.14 ± 12%      +0.1        0.22 ± 22%  perf-profile.children.cycles-pp.lookup_fast
      0.62 ±  5%      +0.1        0.71 ±  8%  perf-profile.children.cycles-pp.d_lookup
      0.48 ±  7%      +0.1        0.57 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      0.64 ±  6%      +0.1        0.74 ±  7%  perf-profile.children.cycles-pp.lookup_dcache
      0.50 ±  3%      +0.1        0.60 ±  6%  perf-profile.children.cycles-pp.xfs_dir2_sf_removename
      0.48 ±  6%      +0.1        0.58 ± 11%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.49 ±  8%      +0.1        0.61 ±  9%  perf-profile.children.cycles-pp.__d_move
      0.82 ±  5%      +0.1        0.96 ±  7%  perf-profile.children.cycles-pp.d_move
      0.82 ±  4%      +0.1        0.96 ±  4%  perf-profile.children.cycles-pp.__d_alloc
      0.71 ±  5%      +0.1        0.86 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.48 ± 11%      +0.1        0.62 ± 14%  perf-profile.children.cycles-pp.up_write
      0.97 ±  5%      +0.2        1.13 ±  5%  perf-profile.children.cycles-pp.d_alloc
      1.88 ±  2%      +0.2        2.04 ±  9%  perf-profile.children.cycles-pp.strncpy_from_user
      1.00 ±  4%      +0.2        1.18 ±  7%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.36 ± 24%      +0.2        0.58 ± 19%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.96 ± 11%      +0.2        1.20 ±  8%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.77 ± 11%      +0.2        1.02 ±  6%  perf-profile.children.cycles-pp.path_init
      1.58 ±  3%      +0.3        1.83 ±  6%  perf-profile.children.cycles-pp.xfs_inode_item_format
      2.02 ±  3%      +0.3        2.28 ±  6%  perf-profile.children.cycles-pp.xfs_trans_alloc
      2.23 ±  5%      +0.3        2.49 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      1.19 ± 10%      +0.3        1.45 ±  9%  perf-profile.children.cycles-pp.__mutex_lock
      1.89 ±  2%      +0.3        2.17 ±  6%  perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      2.73 ±  3%      +0.3        3.06 ±  6%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      2.51 ±  4%      +0.4        2.92 ±  9%  perf-profile.children.cycles-pp.path_parentat
      2.27 ±  3%      +0.4        2.70 ±  6%  perf-profile.children.cycles-pp._find_next_or_bit
      3.61 ±  3%      +0.5        4.07 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.83 ±  4%      +0.5        3.31 ±  8%  perf-profile.children.cycles-pp.__filename_parentat
      4.97 ±  2%      +0.6        5.60 ±  7%  perf-profile.children.cycles-pp.xlog_cil_commit
      7.91 ±  2%      +0.9        8.81 ±  7%  perf-profile.children.cycles-pp.__xfs_trans_commit
      8.76 ±  3%      +1.2        9.99 ±  9%  perf-profile.children.cycles-pp.__percpu_counter_sum
     26.27 ±  2%      +3.5       29.73 ±  7%  perf-profile.children.cycles-pp.do_renameat2
     30.90 ±  2%      +4.1       35.03 ±  7%  perf-profile.children.cycles-pp.rename
      1.93 ±  4%      -1.8        0.11 ± 21%  perf-profile.self.cycles-pp.xfs_inodegc_queue_all
      0.66 ±  7%      -0.5        0.13 ± 20%  perf-profile.self.cycles-pp._find_next_bit
      0.08 ± 17%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp.kfree
      0.08 ± 18%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.__x64_sys_statfs
      0.12 ± 18%      +0.0        0.17 ± 13%  perf-profile.self.cycles-pp.__percpu_counter_compare
      0.11 ± 11%      +0.1        0.17 ± 31%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.17 ± 13%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.xfs_inode_item_format_data_fork
      0.17 ± 10%      +0.1        0.24 ± 16%  perf-profile.self.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.28 ±  5%      +0.1        0.35 ±  9%  perf-profile.self.cycles-pp.__cond_resched
      0.32 ±  5%      +0.1        0.39 ±  5%  perf-profile.self.cycles-pp.__filename_parentat
      0.36 ± 23%      +0.2        0.57 ± 19%  perf-profile.self.cycles-pp.__legitimize_mnt
      1.52 ±  5%      +0.2        1.74 ±  8%  perf-profile.self.cycles-pp.__entry_text_start
      0.96 ± 11%      +0.2        1.20 ±  8%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      2.09 ±  5%      +0.2        2.34 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.75 ± 11%      +0.3        1.01 ±  6%  perf-profile.self.cycles-pp.path_init
      1.93 ±  5%      +0.4        2.30 ±  7%  perf-profile.self.cycles-pp._find_next_or_bit
      3.60 ±  3%      +0.5        4.06 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      5.79 ±  3%      +0.8        6.64 ± 10%  perf-profile.self.cycles-pp.__percpu_counter_sum


***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/symlink/stress-ng/60s

commit: 
  ecd49f7a36 ("xfs: fix per-cpu CIL structure aggregation racing with dying cpus")
  62334fab47 ("xfs: use per-mount cpumask to track nonempty percpu inodegc lists")

ecd49f7a36fbccc8 62334fab47621dd91ab30dd5bb6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    117708            +1.9%     119936        vmstat.system.cs
   1092777            +1.7%    1110814        proc-vmstat.numa_hit
   1092614            +2.3%    1117304        proc-vmstat.numa_local
    474.50            +2.1%     484.50        stress-ng.symlink.ops
      7.90            +2.1%       8.06        stress-ng.symlink.ops_per_sec
      0.02 ±131%   +5345.1%       1.29 ±130%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      0.01 ± 85%     -62.4%       0.01 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__xfs_free_extent_later.xfs_bmap_del_extent_real.__xfs_bunmapi
      0.02 ± 51%    +422.5%       0.10 ±146%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_dir.xfs_remove
      0.01 ± 24%    +392.7%       0.07 ±147%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_trans_roll
      0.77 ±145%    +129.3%       1.77 ± 90%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
     16.85            -0.5       16.33 ±  2%  perf-stat.i.cache-miss-rate%
    123504            +1.6%     125516        perf-stat.i.context-switches
      0.99            +1.0%       1.00        perf-stat.i.cpi
     16.87            -0.6       16.26 ±  2%  perf-stat.overall.cache-miss-rate%
      0.99            +1.0%       1.00        perf-stat.overall.cpi
    121555            +1.6%     123540        perf-stat.ps.context-switches
      3.17 ±  2%      -1.1        2.02 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inodegc_queue_all.xfs_fs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs
     12.49            -1.0       11.44 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
      8.02 ±  2%      -1.0        6.98 ±  2%  perf-profile.calltrace.cycles-pp.xfs_fs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
     11.88            -1.0       10.84 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      8.14 ±  2%      -1.0        7.10 ±  2%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.51            -1.0        9.48 ±  2%  perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     10.76            -1.0        9.74 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     14.25            -1.0       13.23 ±  2%  perf-profile.calltrace.cycles-pp.__statfs
      3.19 ±  2%      -1.2        2.03 ±  2%  perf-profile.children.cycles-pp.xfs_inodegc_queue_all
      8.14 ±  2%      -1.0        7.10 ±  2%  perf-profile.children.cycles-pp.statfs_by_dentry
      8.05 ±  2%      -1.0        7.00 ±  2%  perf-profile.children.cycles-pp.xfs_fs_statfs
     14.34            -1.0       13.31 ±  2%  perf-profile.children.cycles-pp.__statfs
     10.51            -1.0        9.49 ±  2%  perf-profile.children.cycles-pp.user_statfs
     10.76            -1.0        9.74 ±  2%  perf-profile.children.cycles-pp.__do_sys_statfs
      0.33 ± 10%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp._find_next_bit
      0.08 ±  9%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.xfs_btree_ptr_to_daddr
      0.34 ±  6%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.65 ±  4%      +0.1        0.73 ±  5%  perf-profile.children.cycles-pp.__filename_parentat
      1.12            -0.9        0.22 ±  7%  perf-profile.self.cycles-pp.xfs_inodegc_queue_all
      0.32 ± 11%      -0.2        0.13 ±  8%  perf-profile.self.cycles-pp._find_next_bit
      0.35 ±  5%      -0.0        0.30 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.08 ±  9%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.xfs_btree_ptr_to_daddr



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/link/stress-ng/60s

commit: 
  ecd49f7a36 ("xfs: fix per-cpu CIL structure aggregation racing with dying cpus")
  62334fab47 ("xfs: use per-mount cpumask to track nonempty percpu inodegc lists")

ecd49f7a36fbccc8 62334fab47621dd91ab30dd5bb6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.10 ± 27%     -37.0%       0.06 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
    862.00            +3.2%     889.50        stress-ng.link.ops
     14.35            +3.2%      14.81        stress-ng.link.ops_per_sec
 2.423e+09            -1.3%   2.39e+09        perf-stat.i.branch-instructions
  49572825 ±  2%      +5.6%   52346561 ±  3%  perf-stat.i.cache-references
      0.03            +0.0        0.03        perf-stat.i.dTLB-load-miss-rate%
   1021147            +1.8%    1039653        perf-stat.i.dTLB-load-misses
 2.028e+09            +2.3%  2.074e+09        perf-stat.i.dTLB-stores
      0.03            +0.0        0.03        perf-stat.overall.dTLB-load-miss-rate%
 2.385e+09            -1.3%  2.353e+09        perf-stat.ps.branch-instructions
  48787960 ±  2%      +5.6%   51523373 ±  3%  perf-stat.ps.cache-references
   1004980            +1.8%    1023298        perf-stat.ps.dTLB-load-misses
 1.996e+09            +2.3%  2.041e+09        perf-stat.ps.dTLB-stores
     46299 ± 56%     +97.1%      91275 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
      9861 ± 64%    +101.9%      19910 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     46299 ± 56%     +97.1%      91275 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
      9861 ± 64%    +101.9%      19910 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
     38310 ± 36%     +52.4%      58379        sched_debug.cpu.clock.avg
     38311 ± 36%     +52.4%      58381        sched_debug.cpu.clock.max
     38308 ± 36%     +52.4%      58378        sched_debug.cpu.clock.min
     38210 ± 36%     +52.1%      58133        sched_debug.cpu.clock_task.avg
     38238 ± 36%     +52.1%      58173        sched_debug.cpu.clock_task.max
     37820 ± 36%     +52.7%      57762        sched_debug.cpu.clock_task.min
      3535 ±  8%     +12.4%       3975        sched_debug.cpu.curr->pid.max
     14219 ± 93%    +132.7%      33087        sched_debug.cpu.nr_switches.avg
     31.08 ± 92%    +153.1%      78.67 ±  8%  sched_debug.cpu.nr_uninterruptible.max
    -23.83          +161.5%     -62.33        sched_debug.cpu.nr_uninterruptible.min
     10.35 ± 78%    +127.4%      23.54 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
     38309 ± 36%     +52.4%      58378        sched_debug.cpu_clk
     38230 ± 36%     +52.5%      58299        sched_debug.ktime
     38330 ± 36%     +52.4%      58401        sched_debug.sched_clk
     16.79 ±  2%      -2.1       14.74 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     16.32 ±  2%      -2.0       14.28 ±  3%  perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     18.83 ±  2%      -2.0       16.84 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     19.91 ±  2%      -2.0       17.95 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
     12.10 ±  2%      -1.9       10.18 ±  3%  perf-profile.calltrace.cycles-pp.xfs_fs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
     12.29 ±  2%      -1.9       10.36 ±  3%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.92            -1.7       21.20 ±  3%  perf-profile.calltrace.cycles-pp.__statfs
      0.74 ±  4%      +0.1        0.85        perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_da_read_buf.xfs_da3_node_lookup_int.xfs_dir2_node_addname.xfs_dir_createname
      1.32 ±  5%      +0.1        1.44 ±  3%  perf-profile.calltrace.cycles-pp.xfs_da_read_buf.xfs_da3_node_lookup_int.xfs_dir2_node_addname.xfs_dir_createname.xfs_link
      1.88 ±  3%      +0.2        2.07 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__statfs
      2.34 ±  4%      -2.2        0.16 ± 16%  perf-profile.children.cycles-pp.xfs_inodegc_queue_all
     16.80 ±  2%      -2.1       14.74 ±  3%  perf-profile.children.cycles-pp.__do_sys_statfs
     16.33 ±  2%      -2.0       14.29 ±  3%  perf-profile.children.cycles-pp.user_statfs
     12.14 ±  2%      -1.9       10.21 ±  3%  perf-profile.children.cycles-pp.xfs_fs_statfs
     12.29 ±  2%      -1.9       10.36 ±  3%  perf-profile.children.cycles-pp.statfs_by_dentry
     23.06            -1.7       21.34 ±  3%  perf-profile.children.cycles-pp.__statfs
      0.58 ±  8%      -0.4        0.13 ± 14%  perf-profile.children.cycles-pp._find_next_bit
      0.08 ± 16%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.xfs_qm_need_dqattach
      0.14 ± 18%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.xfs_vn_getattr
      3.96 ±  3%      +0.2        4.19 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.57 ±  9%      -0.4        0.13 ± 15%  perf-profile.self.cycles-pp._find_next_bit
      0.06 ± 13%      +0.0        0.08 ± 18%  perf-profile.self.cycles-pp.xfs_dir2_node_find_freeblk
      0.07 ± 18%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.xfs_mod_freecounter
      0.07 ± 16%      +0.0        0.10 ± 13%  perf-profile.self.cycles-pp.xfs_qm_need_dqattach
      0.17 ± 11%      +0.0        0.21 ±  7%  perf-profile.self.cycles-pp.xfs_link
      1.71 ±  5%      +0.1        1.84 ±  4%  perf-profile.self.cycles-pp._find_next_or_bit
      3.95 ±  3%      +0.2        4.19 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

