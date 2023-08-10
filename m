Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5677F777983
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjHJNZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHJNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:24:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCAAA3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691673898; x=1723209898;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WISvcLxT27dL7NNpr6sQ/2/+OMlIdud914candx1nhE=;
  b=Gg8kpefz54Qfnni/1xiMnNAlYnlfKZC4+pzs6bOHNYO7af81WKkuAcbU
   qd0CJmLBfWq+yRVVK7OdrP+ZQNg912K1qpbgfYUfhBS3/KHndaPe33YzL
   +A8LMzLcP39Vv0r0b4cNFQV45C1OKtc4LPYy0xv1PZar2YcCSLE2hKRz4
   G/9BxxY1ti5flX9YBfxi7YrT+h/Pb/dxorsmFF09aNNIbVskWfOYMwFjU
   R2rNSc9FIx6GyQ2T5zMyoPSaiKEb9X4bxhG+Pnw/Wg9AxnBLlnTLtf8ca
   Qizve8g/u3wG61ujF7QOtcGjwPnrcTZFEDLIO8iNXQu8STV0qREoYzJ/k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435294513"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435294513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="802201947"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="802201947"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2023 06:24:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 06:24:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 06:24:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 06:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdOYFGGEBRl1PKvupryC/pBpVv7uAXvYvx9UQpuVfT17E0PQEoIQt5vwEQFCYO9BxbhA6duqJByJyJsst/sjo74Ny0iEoIZ612u6c8dyK1Re3Z/dnV6hh6875uBbBtHuHoFtv4wtWmyhh6eiCOp343MAMQrMmcQKunKDvMBXAr7StT4TKiZubzkCRpo2GZb0JKCh6GxJkVz5eUneG+pJLN80jQixF/65qyss+tIuGP+cK6wWWt5NOEPBH/7vk2F7E+IPR4SWK/oij4mzO5O67n/n8mGAzxgPw13JOJNceZD+oqp+Zf+kP0XCQcuaebdAp8PcNtotmaA231k6WXB6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgcbZSzqyUV1zXmRRhis9iJSAK8i7y9zeWX6rIJ+myc=;
 b=Br4CzZPi0iufMGvMmtPnPuAUmGKYSy7tqGqjNBvCfMXVA25wynql5ckCt8isr6qMRnBr+KzNyom9B6lOZgURMreAGF4DhnkHwPxmn/Vlp+lZdqh5hiF+QHfvMBYGBrb+3/bM3ypHOxUZby2RpVAnaLrGvKwgSSu5SIewBTqhsWg4Xnim93E/gryaHAX1MSHAWS5IBKkCcLtW0eTFiewrYuobpPnsNtgwB02skBdFrssLRWdC9adPcrktvqnYWdbAFpJCTAcCF1HB2Ry2uqTAMFR7Co2xRDaTW1F0KWBrKwp0jV0kZvvt2NqGD379UDK6sdyXIvgY+2rj5lzjsE7brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA2PR11MB4812.namprd11.prod.outlook.com (2603:10b6:806:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 13:24:49 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66%6]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 13:24:49 +0000
Date:   Thu, 10 Aug 2023 21:24:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <202308101628.7af4631a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA2PR11MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: f739c7c8-d2f3-4f94-26a8-08db99a52be6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVE91Ggs434NVLq0rgiaVagw/eLiPAvLDwNTYrqvcD1DThX5YeZd4buAWN903TmDLxOJbdT6vbV/TWEnQIVtZKTvkhxSyEOHfa4S9zPoF1CvI6d/JZ7xNAO2akqZ2gAMXukwAw3paTc7FOF4p7Z3R7cpDYmfzxu4npzquSG2KQ63bjEEbcEsMzDskyE2tNIivF6HqWKweeaO2kHWZU57L3l28EwvJutGOyiG1RHPiZqv/lNO5tUkJIiCKHh/nf47sBs2sXcKNQlHjzRTgD4LJgv/OHD5jnj5gFiaLiqV/xknOH69YmSdwOtG73DTj3wBXjznQEr41Zk+aiz87O3Zn+pty7OufQpwVf45hxDAitqu2360Iyqhp/kfc7TRtZh9Jv+LApOf22RckoYkxdwD0r2LPBRlg35tTOvuJLlVoUurmBSImO2+xWZKyUEm6a7Y+k3Ohdya3y/cUoKDL/E/0K6S0Ebz1ZefGCmb+Lc2v0pDx/g9QxasF9BGsBBVDX9N5aGFaRKIwNcreX0zgr9GOIc/TSsErjjWLDSCcE6xds+d0S0Z3dpzflhPgZLLdVPgRNzwXb6GNunQLJqU+8UCVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799006)(186006)(451199021)(66476007)(66946007)(4326008)(66556008)(8936002)(8676002)(6666004)(6916009)(316002)(5660300002)(2906002)(41300700001)(6486002)(19627235002)(478600001)(966005)(1076003)(6512007)(36756003)(6506007)(2616005)(83380400001)(26005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dlmkr1/J9ScVH/xrQ5Y+sx2JUvTfgqQjz2D8Fs2pgWTIOXDEQo1SJQ30oz?=
 =?iso-8859-1?Q?uoZRMo0xtJLa8t9eN6scJp9uX/rj/MD1HihNj0pRXnUJ19as3VbW/s61sx?=
 =?iso-8859-1?Q?hoxIdjfcwb1Y+i8MVXEgQ3SGDrEeGh6pJVJPRXVIAkfxPO2Jt8/h+oC8a5?=
 =?iso-8859-1?Q?X95hPrt+anltSRsoAaGhxSelk91JpGj17+BlQmLo+2XXSd0hb87kvMnaAw?=
 =?iso-8859-1?Q?NTxTHD+pZqPgI7qYRHm4Z9F/l34nmfrSrpuBnAxAf5foJyoNBmkYsEbj23?=
 =?iso-8859-1?Q?qgo7PHpzydzD8TXCa0yT2Vi3P5HRWIlYau7xJiOl9EDvrQRkitn+h0omoA?=
 =?iso-8859-1?Q?VzCPYZExwEx9Yl8ikAjZyg4+8tVIkcpK6FgmqDxogJfH8MgZeknNsUre0F?=
 =?iso-8859-1?Q?Pr4FS9dFNtBCowg9BIUiu/NGcMDw6dixCL4u51DXfjbAWWKz7XzFIjscqx?=
 =?iso-8859-1?Q?6gwBSP+FtRxGtQmoKbfsMmELD0gn0Kz/7k+qNZQG6mkE1ob6KTXqbmLxmg?=
 =?iso-8859-1?Q?jQGONxJJff7/90PyxK5fV9k2GtMERt/kmQ3N/JYKgEWVdAgwclcPZFLyDE?=
 =?iso-8859-1?Q?ne1g4Qfgrn5cZctAlWaTvVJTU0jvCeps4Xplf6tnnUNbwp30EHd0UXxW2o?=
 =?iso-8859-1?Q?XpCMuPUiKEEurEPq/7ryFunsmPSO7Pp3m43tZymk1CQyRtiTmEl5CQDHqe?=
 =?iso-8859-1?Q?SaE8nNf7wwezUE2FDa8GLI1/yxfqMC2JwfRq1NdesECdxUH9yB+I84cLne?=
 =?iso-8859-1?Q?0as3k1Z+H/2KDQonkVeA5JC5Ijoo5dckpA0WI5ne+jD/ObivcVfoPm4hW0?=
 =?iso-8859-1?Q?KNWsw8/7N1RCtDIs1tfqtTnGDxrGkemNtyiHXmvsuuJMXhhnXHFYPM32Lk?=
 =?iso-8859-1?Q?N0piEAZNhMxp8Fhd/wn7AjMg6TFBVer0di/zuv2FawTLs14iofPp3BQeSe?=
 =?iso-8859-1?Q?asrAy6/9pGhElTxUb/XfIyiPDzJkCgOVMzWOFvPbrPUa7n5kqsml4jRRKV?=
 =?iso-8859-1?Q?5uPxzIr65750kkKUnzDBjr/uJcEahQyEfRvrT7ZiJxk5wRCwe3VlnURcJg?=
 =?iso-8859-1?Q?6hRC+f6MLyneuEIDD40YjN1gZoGZxA9p2wX/Ilt3+4Chse/HcKhd48HPcK?=
 =?iso-8859-1?Q?Gdse4MQDWb4+7Wj9S/zQsDx8ZS81lU31tc8ih2NUmxCiKw7h8EsDSu1jIH?=
 =?iso-8859-1?Q?XxJJcn25O3hV61/NoK7hMSSClwvLoL7CR5/dHssp5xKoy0LeBpiJ7p3CqK?=
 =?iso-8859-1?Q?wShRtPlCXcUEFQC2zVqIvDsbvYgVEurV5nMYPQhDV7EjEcBTtvWSH6QYQX?=
 =?iso-8859-1?Q?TFfF4OsdTJijUqTA8o+oCyBwZopVSJY5EFgNGqxKebIom1vkjyzFKGBwJJ?=
 =?iso-8859-1?Q?q1B1RGV8/2Hmx3wpO5w4du12kw7WuAzobwIOS5QUKH92yLNOBWG4HsaGfg?=
 =?iso-8859-1?Q?vyh+IUk3wHCyrKAE7ASk7UeeABnOjUxyrETaICmHzujYTsprI60VpnW3Dz?=
 =?iso-8859-1?Q?ebFPP3moX7yyJo+M94R5Kr8VFxDUloVY5ClGx+Ru2/KUuWLbuZio75fDwi?=
 =?iso-8859-1?Q?dWeU4YHXNkshqHt29AEBvB0ZWVx+4psWdBTm9eN8GPRfE4MoH3k2A/1S5k?=
 =?iso-8859-1?Q?NspI2ZeEtup7jSSE5AIBysDlxwPdkBb4FAG9+6wyrHUnTaorposwwvAQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f739c7c8-d2f3-4f94-26a8-08db99a52be6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 13:24:49.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rtynvuhD2A9N4MuYclDW9bTdMU9v/5c+IQKu2q9zGBOM5nYS0YwIIt3rlreorMrPgNK+7Df3Z7Ix7oCdNPVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4812
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

kernel test robot noticed a -34.8% regression of phoronix-test-suite.blogbench.Write.final_score on:


commit: e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13 ("sched/fair: Remove sched_feat(START_DEBIT)")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/eevdf

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: blogbench-1.1.0
	option_a: Write
	cpufreq_governor: performance


(
previously, we reported
"[tip:sched/eevdf] [sched/fair]  e0c2ff903c: pft.faults_per_sec_per_cpu 7.0% improvement"
on
https://lore.kernel.org/all/202308091624.d97ae058-oliver.sang@intel.com/
since now we found a regression, so report again FYI
)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308101628.7af4631a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230810/202308101628.7af4631a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/Write/debian-x86_64-phoronix/lkp-csl-2sp7/blogbench-1.1.0/phoronix-test-suite

commit: 
  af4cf40470 ("sched/fair: Add cfs_rq::avg_vruntime")
  e0c2ff903c ("sched/fair: Remove sched_feat(START_DEBIT)")

af4cf40470c22efa e0c2ff903c320d3fd3c2c604dc4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13.43 ±  6%      +1.7       15.15 ±  5%  mpstat.cpu.all.idle%
 4.516e+09 ±  7%     +13.6%  5.129e+09 ±  6%  cpuidle..time
   5386162 ±  6%     +15.1%    6199901 ±  5%  cpuidle..usage
   5829408 ±  7%      -8.7%    5320418 ±  4%  numa-numastat.node0.local_node
   5839930 ±  7%      -8.7%    5333078 ±  4%  numa-numastat.node0.numa_hit
   6025065 ±  5%     -12.9%    5245696 ±  7%  numa-numastat.node1.local_node
     57086           -28.2%      40989        vmstat.io.bo
  11120354           -21.6%    8721798        vmstat.memory.cache
     18750           +12.1%      21014        vmstat.system.cs
    215070 ± 25%     +29.4%     278379 ± 23%  numa-meminfo.node1.AnonPages.max
   5507703 ± 13%     -31.6%    3766183 ± 23%  numa-meminfo.node1.FilePages
   2118171 ± 13%     -26.7%    1551936 ± 25%  numa-meminfo.node1.Inactive
   6824965 ± 12%     -26.7%    5005740 ± 18%  numa-meminfo.node1.MemUsed
      4960           -34.8%       3235 ±  2%  phoronix-test-suite.blogbench.Write.final_score
  35120853           -29.4%   24804986        phoronix-test-suite.time.file_system_outputs
      8058            -1.9%       7908        phoronix-test-suite.time.percent_of_cpu_this_job_got
     26517            -1.2%      26196        phoronix-test-suite.time.system_time
   1445969           +10.6%    1599011        phoronix-test-suite.time.voluntary_context_switches
    600079 ±  3%     +26.4%     758665 ±  3%  turbostat.C1E
      0.75 ±  3%      +0.1        0.84 ±  4%  turbostat.C1E%
   4372028 ±  7%     +14.1%    4987180 ±  7%  turbostat.C6
     13.09 ±  6%      +1.6       14.72 ±  6%  turbostat.C6%
     11.39 ±  5%     +10.4%      12.57 ±  4%  turbostat.CPU%c1
   2330913 ± 13%     -23.5%    1782895 ± 14%  numa-vmstat.node0.nr_dirtied
   2256547 ± 13%     -23.8%    1719197 ± 14%  numa-vmstat.node0.nr_written
   5840154 ±  7%      -8.7%    5333324 ±  4%  numa-vmstat.node0.numa_hit
   5829632 ±  7%      -8.7%    5320664 ±  4%  numa-vmstat.node0.numa_local
   2287685 ± 11%     -33.8%    1514622 ± 20%  numa-vmstat.node1.nr_dirtied
   1376658 ± 13%     -31.6%     941500 ± 23%  numa-vmstat.node1.nr_file_pages
    127.17 ± 18%     -52.4%      60.50 ± 31%  numa-vmstat.node1.nr_writeback
   2215841 ± 12%     -34.1%    1460272 ± 20%  numa-vmstat.node1.nr_written
   6025232 ±  5%     -12.9%    5245703 ±  7%  numa-vmstat.node1.numa_local
     74.24 ±  8%     -38.1%      45.97 ± 11%  sched_debug.cfs_rq:/.load_avg.avg
      3167 ± 14%     -78.6%     676.56 ± 45%  sched_debug.cfs_rq:/.load_avg.max
    339.56 ± 15%     -74.2%      87.77 ± 38%  sched_debug.cfs_rq:/.load_avg.stddev
      1829 ±  6%     -12.7%       1597 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
      1490 ±  7%     -13.5%       1289 ±  7%  sched_debug.cfs_rq:/.util_avg.max
      1495 ±  7%     -13.3%       1296 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.max
     33772           +15.4%      38971        sched_debug.cpu.nr_switches.avg
    117253 ± 10%    +106.6%     242187 ± 13%  sched_debug.cpu.nr_switches.max
     11889 ±  9%     +96.8%      23399 ± 12%  sched_debug.cpu.nr_switches.stddev
  58611259           -50.0%   29305629        sched_debug.sysctl_sched.sysctl_sched_features
   6885022 ±  2%     -25.3%    5139844 ±  2%  meminfo.Active
   6735239 ±  2%     -25.9%    4988483 ±  2%  meminfo.Active(file)
  10388292           -21.3%    8173968        meminfo.Cached
   3953695           -11.9%    3483739        meminfo.Inactive
   2793179           -16.8%    2323187        meminfo.Inactive(file)
    716630           -21.7%     561030        meminfo.KReclaimable
  12938216           -18.5%   10538792        meminfo.Memused
    716630           -21.7%     561030        meminfo.SReclaimable
    462556           -10.4%     414369        meminfo.SUnreclaim
   1179187           -17.3%     975399        meminfo.Slab
  13543613           -19.3%   10926031        meminfo.max_used_kB
   1682930 ±  2%     -25.9%    1246741 ±  2%  proc-vmstat.nr_active_file
   4618598           -28.6%    3297498 ±  2%  proc-vmstat.nr_dirtied
    115523 ±  2%      -4.3%     110605        proc-vmstat.nr_dirty
   2596313           -21.3%    2043401        proc-vmstat.nr_file_pages
    698013           -16.8%     580677        proc-vmstat.nr_inactive_file
    179075           -21.7%     140220        proc-vmstat.nr_slab_reclaimable
    115576           -10.4%     103600        proc-vmstat.nr_slab_unreclaimable
    200.00 ± 12%     -60.2%      79.67 ± 27%  proc-vmstat.nr_writeback
   4472388           -28.9%    3179453 ±  2%  proc-vmstat.nr_written
   1682930 ±  2%     -25.9%    1246741 ±  2%  proc-vmstat.nr_zone_active_file
    698013           -16.8%     580677        proc-vmstat.nr_zone_inactive_file
    115652 ±  2%      -4.4%     110571        proc-vmstat.nr_zone_write_pending
  11888053           -10.8%   10598323 ±  2%  proc-vmstat.numa_hit
  11861225           -10.9%   10573027 ±  2%  proc-vmstat.numa_local
   3434596           -28.4%    2460772        proc-vmstat.pgactivate
  18752650            -8.2%   17219808 ±  3%  proc-vmstat.pgalloc_normal
  18252683            -8.4%   16727157 ±  3%  proc-vmstat.pgfree
  19379562           -27.5%   14053587 ±  2%  proc-vmstat.pgpgout
    205988            +3.5%     213118        proc-vmstat.pgreuse
     97.12            -1.1       96.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.08            -1.1       96.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.33            -1.0       51.36        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     52.32            -1.0       51.35        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.12            -1.1       96.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.08            -1.1       96.02        perf-profile.children.cycles-pp.do_syscall_64
     85.21            -1.0       84.18        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     85.58            -1.0       84.56        perf-profile.children.cycles-pp._raw_spin_lock
     52.33            -1.0       51.36        perf-profile.children.cycles-pp.__x64_sys_openat
     52.32            -1.0       51.35        perf-profile.children.cycles-pp.do_sys_openat2
      0.64 ±  2%      +0.0        0.68 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.28 ±  5%      +0.0        0.32 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.02 ±141%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__x64_sys_rename
      0.08 ± 29%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.process_one_work
      0.01 ±223%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.do_renameat2
      0.08 ± 29%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.worker_thread
      0.03 ±101%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__extent_writepage
      0.03 ±103%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.do_writepages
      0.03 ±103%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.extent_writepages
      0.03 ±103%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.extent_write_cache_pages
     84.73            -1.0       83.69        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
 5.487e+09            -2.2%  5.364e+09        perf-stat.i.branch-instructions
      0.73 ±  8%      +0.2        0.92 ± 12%  perf-stat.i.branch-miss-rate%
     18867           +12.0%      21136        perf-stat.i.context-switches
 2.307e+11            -2.0%  2.261e+11        perf-stat.i.cpu-cycles
      1352 ±  2%      +3.5%       1399        perf-stat.i.cpu-migrations
   4638095 ± 27%     -38.2%    2865514 ± 23%  perf-stat.i.dTLB-load-misses
 6.107e+09            -2.3%  5.965e+09        perf-stat.i.dTLB-loads
 2.391e+10            -2.3%  2.335e+10        perf-stat.i.instructions
      0.17            -7.8%       0.16 ±  2%  perf-stat.i.ipc
      0.62 ±  2%     +14.5%       0.71 ±  6%  perf-stat.i.major-faults
      2.40            -2.0%       2.35        perf-stat.i.metric.GHz
    139.98            -2.3%     136.76        perf-stat.i.metric.M/sec
     66.90            -1.8       65.11        perf-stat.i.node-load-miss-rate%
  65029001            -5.5%   61464545 ±  3%  perf-stat.i.node-load-misses
      0.08 ± 27%      -0.0        0.05 ± 24%  perf-stat.overall.dTLB-load-miss-rate%
     67.28            -2.3       64.93        perf-stat.overall.node-load-miss-rate%
 5.474e+09            -2.2%  5.352e+09        perf-stat.ps.branch-instructions
     18821           +12.1%      21105        perf-stat.ps.context-switches
 2.301e+11            -2.0%  2.256e+11        perf-stat.ps.cpu-cycles
      1349 ±  2%      +3.6%       1398        perf-stat.ps.cpu-migrations
   4630176 ± 27%     -38.2%    2859589 ± 23%  perf-stat.ps.dTLB-load-misses
 6.092e+09            -2.3%  5.952e+09        perf-stat.ps.dTLB-loads
 2.385e+10            -2.3%   2.33e+10        perf-stat.ps.instructions
      0.61 ±  2%     +14.6%       0.70 ±  6%  perf-stat.ps.major-faults
  64859061            -5.5%   61314167 ±  3%  perf-stat.ps.node-load-misses
 8.031e+12            -1.4%  7.921e+12        perf-stat.total.instructions



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

