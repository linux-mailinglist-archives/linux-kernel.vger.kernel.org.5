Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5A7A9BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjIUTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIUTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F760E0CA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318582; x=1726854582;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=jRlYGwObnAv+ATGcospJWmUDfRSp8hWyBx+dF+G3AdI=;
  b=fzwhKvOVMzvqVsvbUHUCFqeHJCRFoL99/AcB7BSdAcmexkd+4xXkkcB/
   wU824J3hRsZBlPKFJREJmZS1ujUVMLm36N5GoEQ98hHUOLKwrg//qfkRe
   A7VDXhPxj22eW4LMsJFqsuYeN+g3zlwSOBdBR7tf3dz4N9nS3juQBehgv
   CuinKt55nga95TwFDP+Vt8mIzbugGq3pak6dNOSJj9erZgXH9X1ixEd8x
   z9lV9qAmdRSOVh4lQGAdjXiYLeixSu+Eat8xfW4tsCsRfM3SgXSyL6d1u
   fEOpfM4a19Uh/3Cf9iDoX8N9MG4qdshDdZczBGDbwF4ARPQypiErgHyz8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446916102"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="446916102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:44:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870697498"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="870697498"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 00:44:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 00:44:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 00:44:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 00:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvjenkyU3p9N85aIRhM1WMh/bcb6784vsjVAudQEKzlixcdp/vwlACiZQ8bwZTAxS6OFgXAVH6lrwiJVjCp4PRBHj24sats5DjjCJ1GowjkfXHMZ28fyW+r1O+FFgYnZ22S1Qo68ofxVkmI0c8L/Zsr2VDPz8vf6/gxKbiPKh8z2mJyDArPtDdRraL1sU4UHnv/wy8cfznOXBc1tXuzuE3i0bzvMoaPH6HqR5WyydZhlPihrLZU9q9L49vg0kYDvBVOXuxS4g+wSQdKnEqpY9QSsnXq7QtH+HvepNDTAw4Gk9L3LtNUbHmus1DCpHFo4BZ3smaUmpMFbpyEdkMT8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN39f5FOHW6F1WnmJZaeyCjcdEbEUsUL7b9al30KyF4=;
 b=it4oybmcWZq6DxnLIL/7BlaD3JbXL4rm++1tqPdJwu0txvrWiQBqVHC7/5Fn3Dhhh10CeqlhTSDKD9Gu/t9qH7MXnoHvLduQeZRU+ZOe4XYkefSY2zh0pwhCWaxOhFlr4bQmmHSfpFwZYIl/R4++KwAiOopn0LuvZKjHHHivAMod4XCymxVdU/U817ft3e2P4+dRuogPH1/Fd0hweuR6TVO00dqKeXruuLWvaGQFuhgzaJe2xDpIGMydJr5J2EZuUKJq6WO4qpaPvcZ6cVm43wBgWl8h7OE8UFOMcmmWygARPBH0JzZpGuJJ7owCPRAw0brTdCSJvDfOE7DqhZz4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 21 Sep
 2023 07:44:24 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 07:44:24 +0000
Date:   Thu, 21 Sep 2023 15:43:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Yu Ma <yu.ma@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm/mmap]  6852c46c78:  stress-ng.spawn.ops_per_sec
 2.9% improvement
Message-ID: <202309211530.ca9c00a1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b494036-e1d9-4eed-8281-08dbba769297
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6GKxOLmEaOfLgt2zUon8532fY19qur2dn3xyIfoNqMTtXOWfGmyaGmYC4QQTlrvr0RjtDcon3cGr1qo7Mzj60/h2FG/KWSkmXIa8+PfYU4SnJdZiK4YZMz6eUKVV4IcF6c3ZggdUhLR3tJLhfQ0/mKrry2U3UmB7/zF4+dgJ6r/yqsy2mHV1y8pdFiNMDgv2+C57KRRfdNBEv21JD1fDY5C1HWeR3iBpDOP+6rIXNqG0nC4j1PtoHj78JhqM8+TI13wEsv0EOyEPqDmopSHuY33CM3W8ITsd7tqBZfO9mb0YApKg67eTI36HDmFTHCiRGRt8XT++nLexmaa2OoH4FbX8atNpeG6KpaRP2SQXjhzAftIcQfRcSiEo6cbt7EU0qAWE4glZ5JhCuHNQKdyOTSx0qCthTcVTYAs4LNHHvTLzz3Ps8z1gwGasEF8Oh/PyXk7zptULjIFa1aiisTdT6oAeghsccu58kumejHEQdzHwrrugZC6HJ+773ZBK497NNIo7w3DWN05esA2sQGlnEbBRsBpEMo7fG2DZyMbMqqWk5cxhB//a4JWO0Ncd3gKq15PYPTki1K2cgYjL1+JFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(186009)(451199024)(1800799009)(86362001)(30864003)(83380400001)(2906002)(36756003)(6512007)(1076003)(2616005)(6666004)(26005)(6486002)(5660300002)(966005)(38100700002)(8936002)(6862004)(82960400001)(478600001)(19627235002)(54906003)(8676002)(66476007)(316002)(6506007)(66946007)(37006003)(41300700001)(66556008)(6636002)(4326008)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?V7Xgi00EoxlkpuyEKq1jOYpaMBvJRNY+G5CbySti22+h00Hed0GBQRW9PF?=
 =?iso-8859-1?Q?lwgGGBod8WR6kWulsEHNfr1mo7MbwhYychIfPi+WS6fFHp3cZJmb8dYd/W?=
 =?iso-8859-1?Q?IJA0ROPjmW5C3j8bpGUKpWBtjNdXeQzHnCF4IBnXpHwkPRpbiXH/eJ2q7B?=
 =?iso-8859-1?Q?MOrvxaXhu7kNQrNk+BWUDCREb9mJxcY9s3N6d1P782skcSz1tTh5arIQu2?=
 =?iso-8859-1?Q?bgakdHmxKobYWkn1eKaZ/kkAE0tyeP11Wc522EmIXzkDKM4i/3+/+OBAcu?=
 =?iso-8859-1?Q?K9BV0q1453bwmPfzHcxwyFNQ1f0VasdUrinGI15ryqLbKcDq88vhW/Ei2F?=
 =?iso-8859-1?Q?a6Yo6stERhmSObtT2bAx0gZL4SN8y+kzIyZ/8x/KvOjAc/jeVTYjdOiawR?=
 =?iso-8859-1?Q?nUuDlxynmzSm1SJh6UYG/nBOAu1h5GVeNzn+kq38bUHA4FA71XK6s6kx6r?=
 =?iso-8859-1?Q?blIHJINF9lvrWQ9ycAXZzUpVNM0u+eZccXihB4mddyYzEUbn/kNKSzj5el?=
 =?iso-8859-1?Q?TyIIoEkHpG1scEqXMtvKcGaekdC8L8dV7Fdqy7FRSWKbzNNlwzgtgC0J3g?=
 =?iso-8859-1?Q?6gst5eM3KnJxdpqoEztNaP+xYY/MUKrfh7U8GFpfaXJn8cN2Nlun2u0qYZ?=
 =?iso-8859-1?Q?hv+ztzsTCdEd2ZYxqppgIvZatYyUVgqibQ5Z4sDFk8XnawoY1sTaO1h843?=
 =?iso-8859-1?Q?nao+EiUxnC4zLaIc5L4ARHzlouZr7FZLSBhXIAWyEarhU6X8KF7klA+vot?=
 =?iso-8859-1?Q?PnPszXCb/KwbPKWZgzRByIEMspW1rAqPwsjwrShghBUXD8p0E2dS5me5x9?=
 =?iso-8859-1?Q?K2th3J+825g4CwHV+W7978WWMB4kR/VdmtIquFkhD5z8nSmnD+GCR6TPEp?=
 =?iso-8859-1?Q?+oJtWbZsJaA7+loxz8RhRgbui4PiOdJZJJIjf3eloYxZLWd0RbPMXmhIEk?=
 =?iso-8859-1?Q?fTtIzqFOAJoiSuLNtVeAvrUfe1Jw6yR8fdMbwxQYZ7YoPZMhFFh+W4NPek?=
 =?iso-8859-1?Q?Vmr7BzpLIMZJa0yOyx4ekU3FiCiDgM9CTPpukKuYqmDfT8UKyYfjYuXrgp?=
 =?iso-8859-1?Q?42dGVkBF68knxkLfARats8PrMdamVZz1FtOEXtbTzsvYbhye80ngQfxnej?=
 =?iso-8859-1?Q?JvpQo932NR7NXALlEKzXs/l0ynDl9SxB3gwLM1D77nL8+tzn5e699CsZAt?=
 =?iso-8859-1?Q?dbP04S29a8qmngwmLrVL8t/d+cjTp6532iKCW+cu2q0fsXl3MzoW4EjnW/?=
 =?iso-8859-1?Q?vVqHdE8kRqJza35flcpS1BW45chlzdFK5mnJZM9tDXkdcZ9n3HUmb3Wg5W?=
 =?iso-8859-1?Q?iyfqTXh11bjav5aS1ypu1p0cu6VPyDKJCD9xgl5W5BT+IJ4klYsWOugj3n?=
 =?iso-8859-1?Q?gVfa6jm3sNrgi4v87nwe6PRKaB2jvqCbEqlHT0qR+Tzi0azbpM7EWxyN/6?=
 =?iso-8859-1?Q?pQC7w/Jx9CQRbrhsqrt83NWKvqlWuZbbl1NlU0v+jA9NM/5YDS+qqw0Z6s?=
 =?iso-8859-1?Q?7X+y40VvXHuYHVbh/QJGPh4YZjrQox/PN7rWRL9HTiMls5cK6aFftQfj8C?=
 =?iso-8859-1?Q?jff49jO/C+rh5IHgeJ+SW2v3hLpd/F8tUyYaX8F6beWtLH2Cbnmjq08PMJ?=
 =?iso-8859-1?Q?39DKMZQ7Npu76ZKaauPIP3ro2G0mGjJargXsk3FsETkFzWt0gEKXf05Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b494036-e1d9-4eed-8281-08dbba769297
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 07:44:24.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5/kql8L8TfHN1TjP9cUEC6Y/FspdLuR+xCZVcfZ19r3wUUQluvXE/rMSwPPsTwIOTPWwiD3RNereU1W5/hqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 2.9% improvement of stress-ng.spawn.ops_per_sec on:


commit: 6852c46c783d20a4c0153d14d2990040e5e6e47e ("mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	class: exec_spawn
	test: spawn
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score 6.4% improvement                                                        |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480L (Sapphire Rapids) with 512G memory           |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=shell8                                                                                        |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 23.5% improvement                                        |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=small-allocs                                                                                  |
+------------------+----------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230921/202309211530.ca9c00a1-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  exec_spawn/gcc-12/performance/1HDD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/spawn/stress-ng/60s

commit: 
  73e791d738 ("mm: remove clear_page_idle()")
  6852c46c78 ("mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock")

73e791d73877e904 6852c46c783d20a4c0153d14d29 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10609 ± 11%     -19.9%       8493 ±  9%  numa-meminfo.node0.PageTables
      2666 ± 11%     -22.4%       2069 ±  9%  numa-vmstat.node0.nr_page_table_pages
     73.76            -1.5%      72.67        iostat.cpu.system
     11.69            +3.3%      12.07        iostat.cpu.user
      9706 ±  5%     +35.6%      13159 ± 22%  turbostat.POLL
     86.46            +0.9%      87.20        turbostat.RAMWatt
    301.24 ± 14%     -16.3%     252.23 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    -60827           +81.7%    -110508        sched_debug.cfs_rq:/.spread0.avg
      1216 ± 13%     +33.8%       1627 ± 12%  sched_debug.cpu.nr_uninterruptible.max
   1282527            +2.9%    1319688        stress-ng.spawn.ops
     21375            +2.9%      21994        stress-ng.spawn.ops_per_sec
    593917           +46.2%     868090        stress-ng.time.major_page_faults
 2.721e+08            +2.9%  2.799e+08        stress-ng.time.minor_page_faults
      2943            -1.5%       2899        stress-ng.time.system_time
    434.40            +4.3%     453.01        stress-ng.time.user_time
    602081 ±  2%      +4.2%     627620        proc-vmstat.nr_anon_pages
    823789 ±  2%      +4.2%     858619        proc-vmstat.nr_inactive_anon
    219961            +3.6%     227832        proc-vmstat.nr_mapped
    346359            +2.1%     353585        proc-vmstat.nr_shmem
    823789 ±  2%      +4.2%     858619        proc-vmstat.nr_zone_inactive_anon
 1.826e+08            +3.0%  1.881e+08        proc-vmstat.numa_hit
 1.825e+08            +3.0%   1.88e+08        proc-vmstat.numa_local
    425017            +2.2%     434312        proc-vmstat.pgactivate
 1.874e+08            +3.0%  1.931e+08        proc-vmstat.pgalloc_normal
 2.767e+08            +3.0%   2.85e+08        proc-vmstat.pgfault
 1.857e+08            +3.0%  1.913e+08        proc-vmstat.pgfree
      5030            +2.6%       5159        proc-vmstat.thp_split_pmd
      0.01 ±  9%     +30.2%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      0.54 ± 22%     -46.9%       0.29 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.15 ± 80%     -67.6%       0.05 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      0.63 ± 12%     -32.5%       0.42 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.03 ±  2%     +15.9%       0.03 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4292 ±  5%     -14.2%       3683 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      3397 ±  4%     +16.8%       3966 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      5346 ±  4%     +14.1%       6100 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     27421 ±  2%     +49.2%      40919        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     18122 ±  5%     -13.9%      15598 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
     78347 ±  5%     -14.6%      66894 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      2.02 ± 27%     -46.2%       1.09 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.01 ± 23%    +109.1%       0.02 ± 63%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__do_fault.do_cow_fault
      0.02 ±  6%     +68.4%       0.03 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.vm_brk_flags.load_elf_interp
      0.02 ± 21%     +49.0%       0.03 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.02 ±  6%     +19.5%       0.03 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.mprotect_fixup
      0.01 ±  3%     +20.3%       0.01 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.04 ± 54%    +138.4%       0.10 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.08 ± 52%    +290.1%       0.33 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.vm_brk_flags.load_elf_interp
      0.03 ± 70%    +101.1%       0.06 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write.exit_mmap.__mmput.exit_mm
      0.54 ±  7%     -48.8%       0.27 ± 69%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
      0.54 ±  3%     +18.9%       0.64 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2.30 ± 18%     -22.0%       1.79 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
     13.82            +1.5%      14.03        perf-stat.i.MPKI
      1.93            +0.0        1.96        perf-stat.i.branch-miss-rate%
 4.182e+08            +2.3%   4.28e+08        perf-stat.i.branch-misses
 2.549e+08            +1.9%  2.598e+08        perf-stat.i.cache-misses
 1.545e+09            +2.5%  1.584e+09        perf-stat.i.cache-references
      1.86            -2.0%       1.82        perf-stat.i.cpi
    945.76 ±  3%      -5.3%     895.17 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.249e+10            +2.7%  1.283e+10        perf-stat.i.dTLB-stores
      0.55            +3.0%       0.56        perf-stat.i.ipc
      9557           +46.8%      14033        perf-stat.i.major-faults
      2025            +2.4%       2074        perf-stat.i.metric.K/sec
    996.43            +1.3%       1009        perf-stat.i.metric.M/sec
   4413113            +2.7%    4533786        perf-stat.i.minor-faults
  12764008 ±  2%      +3.7%   13236279        perf-stat.i.node-loads
  47197681            +2.6%   48424472        perf-stat.i.node-stores
   4422671            +2.8%    4547820        perf-stat.i.page-faults
     14.16            +1.6%      14.39        perf-stat.overall.MPKI
      1.92            +0.0        1.95        perf-stat.overall.branch-miss-rate%
      1.87            -1.8%       1.84        perf-stat.overall.cpi
    810.88            -2.8%     788.33        perf-stat.overall.cycles-between-cache-misses
      0.53            +1.8%       0.54        perf-stat.overall.ipc
 4.094e+08            +2.3%   4.19e+08        perf-stat.ps.branch-misses
 1.511e+09            +2.5%  1.549e+09        perf-stat.ps.cache-references
     17556 ±  2%      +3.9%      18239        perf-stat.ps.cpu-migrations
 1.226e+10            +2.7%   1.26e+10        perf-stat.ps.dTLB-stores
      9359           +46.0%      13666        perf-stat.ps.major-faults
   4325409            +2.8%    4445394        perf-stat.ps.minor-faults
  12743809 ±  2%      +4.1%   13262041        perf-stat.ps.node-loads
  46090814            +2.7%   47343915        perf-stat.ps.node-stores
   4334769            +2.9%    4459060        perf-stat.ps.page-faults
     17.36            -1.2       16.11        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
     14.04            -1.1       12.96        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
     69.96            -0.9       69.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.01            -0.9       69.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.28            -0.9       11.37        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      9.72            -0.8        8.90        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
     10.90 ±  2%      -0.8       10.10        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      9.96            -0.8        9.16        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      7.46 ±  2%      -0.8        6.69        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      7.33 ±  2%      -0.8        6.56        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
     10.95            -0.8       10.20        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
     12.30            -0.7       11.60        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      8.52 ±  2%      -0.5        8.03        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      8.72 ±  2%      -0.5        8.24        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      7.36            -0.4        6.92        perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      7.95            -0.4        7.52        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
      5.72 ±  2%      -0.4        5.30        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      3.96 ±  2%      -0.4        3.55        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.mprotect_fixup
      8.40            -0.4        7.98        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      8.12            -0.4        7.71        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      4.10 ±  2%      -0.4        3.70        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.mprotect_fixup.do_mprotect_pkey
      8.68            -0.4        8.28        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      5.16            -0.3        4.84        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      9.61            -0.3        9.30        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      7.33            -0.2        7.14        perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      2.84            -0.2        2.66        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      2.18            -0.2        2.02        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      1.18            -0.1        1.11        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      0.84 ±  3%      -0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_map.load_elf_interp.load_elf_binary.search_binary_handler
      0.79 ±  3%      -0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_map.load_elf_interp
      0.82            -0.0        0.78        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.56            +0.0        0.58        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.60            +0.0        0.63        perf-profile.calltrace.cycles-pp.__sysconf
      0.57 ±  2%      +0.0        0.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.55 ±  2%      +0.0        0.58        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.57 ±  2%      +0.0        0.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.67            +0.0        0.70        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault
      0.55            +0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_complete.__split_vma.mprotect_fixup.do_mprotect_pkey
      0.61            +0.0        0.64        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04            +0.0        1.08        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      1.08            +0.0        1.12        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.56            +0.0        0.60 ±  3%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64            +0.0        0.68        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.mprotect_fixup.do_mprotect_pkey
      0.54            +0.0        0.58        perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.54 ±  2%      +0.0        0.58        perf-profile.calltrace.cycles-pp.finish_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.93            +0.0        0.98        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.94            +0.0        0.99        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±  2%      +0.1        0.68        perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.06            +0.1        1.12        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00            +0.1        1.06        perf-profile.calltrace.cycles-pp._dl_addr
      1.07            +0.1        1.12        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ±  2%      +0.1        0.63 ±  2%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_prepare.__split_vma.mprotect_fixup.do_mprotect_pkey
      0.93            +0.1        0.99        perf-profile.calltrace.cycles-pp.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.03            +0.1        1.09        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      1.03            +0.1        1.09        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      0.97            +0.1        1.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.97            +0.1        1.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.96            +0.1        1.03        perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.98            +0.1        1.04        perf-profile.calltrace.cycles-pp.getdents64
      0.97            +0.1        1.03        perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.37            +0.1        1.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      1.33 ±  2%      +0.1        1.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      0.96            +0.1        1.04        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.50            +0.1        1.58        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      1.30            +0.1        1.38        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.51            +0.1        1.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve.__clone
      1.51            +0.1        1.60        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve.__clone
      1.52            +0.1        1.61        perf-profile.calltrace.cycles-pp.execve.__clone
      1.52            +0.1        1.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve.__clone
      1.60            +0.1        1.70        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.26 ±  2%      +0.1        1.36        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.20            +0.1        1.30        perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.52            +0.1        1.62        perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.43 ± 44%      +0.1        0.55 ±  3%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.86 ±  2%      +0.2        2.03        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      3.24            +0.2        3.42        perf-profile.calltrace.cycles-pp.__clone
      2.30            +0.2        2.50        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      2.33            +0.2        2.52        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      2.64            +0.2        2.84        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.83            +0.2        3.03        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.13            +0.2        3.34        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      3.34            +0.2        3.55        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      3.41            +0.2        3.63        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.02            +0.2        2.24        perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.62            +0.2        3.86        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      4.88            +0.4        5.31        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.5        0.51 ±  2%  perf-profile.calltrace.cycles-pp.copy_page.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      7.28            +0.6        7.86        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.68            +0.6        8.29        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.90            +0.7        9.59        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.97            +0.7        9.67        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      9.85            +0.7       10.58        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     39.11            -3.0       36.10        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     39.79            -3.0       36.79        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     40.99            -2.9       38.11        perf-profile.children.cycles-pp.down_write
     31.42            -2.5       28.90        perf-profile.children.cycles-pp.osq_lock
     19.60            -1.2       18.41        perf-profile.children.cycles-pp.unlink_file_vma
     21.27            -1.1       20.14        perf-profile.children.cycles-pp.free_pgtables
     40.67            -1.0       39.70        perf-profile.children.cycles-pp.mmap_region
     41.06            -1.0       40.10        perf-profile.children.cycles-pp.do_mmap
     41.28            -0.9       40.34        perf-profile.children.cycles-pp.vm_mmap_pgoff
     79.55            -0.8       78.73        perf-profile.children.cycles-pp.do_syscall_64
     79.62            -0.8       78.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.54            -0.7       16.80        perf-profile.children.cycles-pp.vma_prepare
      6.88            -0.5        6.38        perf-profile.children.cycles-pp.rwsem_spin_on_owner
     24.95            -0.5       24.48        perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.10            -0.5       24.64        perf-profile.children.cycles-pp.do_vmi_munmap
     21.02            -0.4       20.64        perf-profile.children.cycles-pp.__split_vma
     10.25            -0.3        9.94        perf-profile.children.cycles-pp.unmap_region
      2.79 ±  4%      -0.2        2.54 ±  3%  perf-profile.children.cycles-pp.elf_map
      0.39            -0.1        0.30        perf-profile.children.cycles-pp.mas_wr_walk
      1.50            -0.0        1.46        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.11            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      0.23 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.init_file
      0.16 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.unmap_single_vma
      0.25            +0.0        0.27        perf-profile.children.cycles-pp.__memcpy
      0.24 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.21 ±  2%      +0.0        0.23        perf-profile.children.cycles-pp.mas_push_data
      0.16            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.padzero
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.d_path
      0.30            +0.0        0.31        perf-profile.children.cycles-pp.__vm_area_free
      0.29            +0.0        0.31        perf-profile.children.cycles-pp.mas_find
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.34 ±  2%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.30            +0.0        0.32        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.36 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.find_idlest_cpu
      0.29 ±  2%      +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.34            +0.0        0.36        perf-profile.children.cycles-pp.link_path_walk
      0.44 ±  2%      +0.0        0.46        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.41            +0.0        0.43        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.31 ±  2%      +0.0        0.33        perf-profile.children.cycles-pp.alloc_empty_file
      0.25 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.wake_up_new_task
      0.41 ±  2%      +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.35 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.mas_next_slot
      0.35 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.33            +0.0        0.35        perf-profile.children.cycles-pp.find_vma
      0.45 ±  2%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.__rb_erase_color
      0.28 ±  2%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.27            +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.up_read
      0.51            +0.0        0.53        perf-profile.children.cycles-pp.mas_store_gfp
      0.41 ±  2%      +0.0        0.43        perf-profile.children.cycles-pp.free_swap_cache
      0.44            +0.0        0.47        perf-profile.children.cycles-pp.___perf_sw_event
      0.05 ± 13%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.get_any_partial
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.mt_find
      0.37 ±  2%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.33 ±  2%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.50 ±  2%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.copy_page
      0.33 ±  2%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_init
      0.24 ±  5%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.down_read
      0.31            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      0.37            +0.0        0.40        perf-profile.children.cycles-pp.__open64_nocancel
      0.39 ±  2%      +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.37 ±  2%      +0.0        0.40        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.53            +0.0        0.56        perf-profile.children.cycles-pp.__perf_sw_event
      0.43 ±  2%      +0.0        0.46        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.66            +0.0        0.68        perf-profile.children.cycles-pp.get_page_from_freelist
      0.62            +0.0        0.65        perf-profile.children.cycles-pp.__sysconf
      0.55 ±  2%      +0.0        0.58        perf-profile.children.cycles-pp.kernel_wait4
      0.59 ±  2%      +0.0        0.62        perf-profile.children.cycles-pp.wait4
      0.47 ±  2%      +0.0        0.50 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.53            +0.0        0.56        perf-profile.children.cycles-pp.mas_split
      0.30            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.folio_add_lru_vma
      0.06 ± 11%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.io_schedule
      0.51            +0.0        0.54        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.47            +0.0        0.50 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.41            +0.0        0.44 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc
      0.60            +0.0        0.64        perf-profile.children.cycles-pp.mas_wr_bnode
      0.06 ± 11%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.61 ±  2%      +0.0        0.65        perf-profile.children.cycles-pp.copy_process
      0.48            +0.0        0.51        perf-profile.children.cycles-pp.page_add_file_rmap
      0.75            +0.0        0.79        perf-profile.children.cycles-pp.native_irq_return_iret
      0.69            +0.0        0.73        perf-profile.children.cycles-pp.vm_area_alloc
      0.56            +0.0        0.60 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.54            +0.0        0.58        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.46 ±  2%      +0.0        0.50 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.51            +0.0        0.55 ±  2%  perf-profile.children.cycles-pp.mm_init
      0.15 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      0.61            +0.0        0.65        perf-profile.children.cycles-pp.mas_walk
      0.67            +0.0        0.71        perf-profile.children.cycles-pp.vma_alloc_folio
      0.88            +0.0        0.92        perf-profile.children.cycles-pp.sync_regs
      0.83            +0.0        0.87        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.56            +0.0        0.60 ±  2%  perf-profile.children.cycles-pp.alloc_bprm
      0.83            +0.0        0.87        perf-profile.children.cycles-pp.mas_wr_node_store
      0.58            +0.0        0.62        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.79            +0.0        0.83 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.06 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp.folio_wake_bit
      0.92            +0.0        0.97        perf-profile.children.cycles-pp.__alloc_pages
      0.75            +0.0        0.80        perf-profile.children.cycles-pp.mtree_range_walk
      1.04            +0.0        1.09        perf-profile.children.cycles-pp.__slab_free
      0.77            +0.0        0.82        perf-profile.children.cycles-pp.vm_area_dup
      0.55 ±  2%      +0.0        0.60        perf-profile.children.cycles-pp.finish_fault
      1.01            +0.1        1.06        perf-profile.children.cycles-pp._dl_addr
      1.06            +0.1        1.12        perf-profile.children.cycles-pp.perf_iterate_sb
      0.75 ±  2%      +0.1        0.81        perf-profile.children.cycles-pp._compound_head
      1.03            +0.1        1.09        perf-profile.children.cycles-pp.__do_sys_clone
      1.03            +0.1        1.09        perf-profile.children.cycles-pp.kernel_clone
      0.96            +0.1        1.03        perf-profile.children.cycles-pp.iterate_dir
      0.94            +0.1        1.00        perf-profile.children.cycles-pp.kernfs_fop_readdir
      0.98            +0.1        1.04        perf-profile.children.cycles-pp.getdents64
      0.97            +0.1        1.03        perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.36 ±  4%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.wake_page_function
      0.36            +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.filemap_fault
      1.81            +0.1        1.89        perf-profile.children.cycles-pp.perf_event_mmap_event
      1.42            +0.1        1.49        perf-profile.children.cycles-pp.do_sys_openat2
      0.56            +0.1        0.63        perf-profile.children.cycles-pp.__do_fault
      1.87            +0.1        1.95        perf-profile.children.cycles-pp.perf_event_mmap
      0.76 ±  2%      +0.1        0.84        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      1.42            +0.1        1.50        perf-profile.children.cycles-pp.__x64_sys_openat
      0.32 ±  3%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.get_partial_node
      1.40            +0.1        1.48        perf-profile.children.cycles-pp.path_openat
      1.42            +0.1        1.50        perf-profile.children.cycles-pp.do_filp_open
      0.70            +0.1        0.79 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.71            +0.1        0.79        perf-profile.children.cycles-pp.lru_add_drain
      1.39            +0.1        1.48        perf-profile.children.cycles-pp.wp_page_copy
      1.43            +0.1        1.53        perf-profile.children.cycles-pp.do_set_pte
      3.10            +0.1        3.20        perf-profile.children.cycles-pp.mas_store_prealloc
      2.00            +0.1        2.11        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.35 ±  2%      +0.1        1.46        perf-profile.children.cycles-pp.page_remove_rmap
      0.94            +0.1        1.04        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.76 ±  2%      +0.1        0.87 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      1.22            +0.1        1.33        perf-profile.children.cycles-pp.mas_destroy
      0.98            +0.1        1.11 ±  2%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      1.11            +0.1        1.24 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.96 ±  3%      +0.1        1.09        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.38            +0.1        1.52        perf-profile.children.cycles-pp.mas_preallocate
      1.43            +0.1        1.58        perf-profile.children.cycles-pp.mas_alloc_nodes
      2.02            +0.2        2.19        perf-profile.children.cycles-pp.release_pages
      3.25            +0.2        3.43        perf-profile.children.cycles-pp.__clone
      3.39            +0.2        3.58        perf-profile.children.cycles-pp.vma_complete
      2.40            +0.2        2.60        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      4.42            +0.2        4.62        perf-profile.children.cycles-pp.vma_interval_tree_insert
      2.82            +0.2        3.02        perf-profile.children.cycles-pp.next_uptodate_page
      2.65            +0.2        2.86        perf-profile.children.cycles-pp.tlb_finish_mmu
      3.50            +0.2        3.73        perf-profile.children.cycles-pp.zap_pte_range
      2.10            +0.2        2.33        perf-profile.children.cycles-pp.do_cow_fault
      3.59            +0.2        3.82        perf-profile.children.cycles-pp.zap_pmd_range
      3.73            +0.2        3.97        perf-profile.children.cycles-pp.unmap_page_range
      1.61 ±  2%      +0.3        1.87 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.99            +0.3        4.26        perf-profile.children.cycles-pp.unmap_vmas
      1.33 ±  2%      +0.3        1.60 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.00            +0.3        5.33        perf-profile.children.cycles-pp.filemap_map_pages
      5.37            +0.4        5.72        perf-profile.children.cycles-pp.do_read_fault
      7.51            +0.6        8.09        perf-profile.children.cycles-pp.do_fault
     10.64            +0.8       11.41        perf-profile.children.cycles-pp.__handle_mm_fault
     11.19            +0.8       12.00        perf-profile.children.cycles-pp.handle_mm_fault
     12.75            +0.9       13.66        perf-profile.children.cycles-pp.do_user_addr_fault
     12.82            +0.9       13.73        perf-profile.children.cycles-pp.exc_page_fault
     14.29            +1.0       15.27        perf-profile.children.cycles-pp.asm_exc_page_fault
     30.81            -2.5       28.33        perf-profile.self.cycles-pp.osq_lock
      6.72            -0.5        6.23        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.34 ±  2%      -0.1        0.26        perf-profile.self.cycles-pp.mas_wr_walk
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.access_error
      0.20            +0.0        0.21        perf-profile.self.cycles-pp.__memcpy
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.38            +0.0        0.40        perf-profile.self.cycles-pp.___perf_sw_event
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.free_swap_cache
      0.26            +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.up_read
      0.47            +0.0        0.49 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.32 ±  2%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.22 ±  4%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.down_read
      0.49            +0.0        0.51 ±  2%  perf-profile.self.cycles-pp.copy_page
      0.36            +0.0        0.38        perf-profile.self.cycles-pp.do_set_pte
      0.37            +0.0        0.40        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.41            +0.0        0.44 ±  3%  perf-profile.self.cycles-pp.___slab_alloc
      0.06 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.try_to_wake_up
      0.49            +0.0        0.52        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.50            +0.0        0.52 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.41            +0.0        0.44        perf-profile.self.cycles-pp.page_add_file_rmap
      0.58 ±  2%      +0.0        0.62        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.75            +0.0        0.79        perf-profile.self.cycles-pp.native_irq_return_iret
      0.50            +0.0        0.53        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.55            +0.0        0.59        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.77            +0.0        0.81        perf-profile.self.cycles-pp.filemap_map_pages
      0.87            +0.0        0.91        perf-profile.self.cycles-pp.sync_regs
      0.72            +0.0        0.76        perf-profile.self.cycles-pp.mtree_range_walk
      1.03            +0.0        1.07 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.89            +0.0        0.94        perf-profile.self.cycles-pp._dl_addr
      1.10            +0.1        1.15        perf-profile.self.cycles-pp.zap_pte_range
      0.69 ±  2%      +0.1        0.74        perf-profile.self.cycles-pp._compound_head
      1.08            +0.1        1.16        perf-profile.self.cycles-pp.release_pages
      1.14 ±  2%      +0.1        1.23        perf-profile.self.cycles-pp.page_remove_rmap
      1.10 ±  2%      +0.1        1.20        perf-profile.self.cycles-pp.down_write
      4.32            +0.2        4.52        perf-profile.self.cycles-pp.vma_interval_tree_insert
      2.72            +0.2        2.92        perf-profile.self.cycles-pp.next_uptodate_page
      1.33 ±  2%      +0.3        1.60 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-spr-2sp3: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480L (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-spr-2sp3/shell8/unixbench

commit: 
  73e791d738 ("mm: remove clear_page_idle()")
  6852c46c78 ("mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock")

73e791d73877e904 6852c46c783d20a4c0153d14d29 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    128621 ± 44%     -35.5%      83021 ± 18%  sched_debug.cfs_rq:/.spread0.stddev
     68.67            -2.7%      66.83        turbostat.PkgTmp
     30.36            +1.2%      30.74        turbostat.RAMWatt
     23470 ±  2%      +6.4%      24970 ±  2%  unixbench.score
    799587 ±  3%     +11.6%     892414 ±  3%  unixbench.time.involuntary_context_switches
     83795 ±  8%     +39.5%     116914 ±  5%  unixbench.time.major_page_faults
 1.003e+08 ±  2%      +6.5%  1.068e+08 ±  2%  unixbench.time.minor_page_faults
    328.24 ±  2%      +6.1%     348.20        unixbench.time.user_time
    894180 ±  2%      +6.7%     953859 ±  2%  unixbench.workload
  70334849 ±  2%      +6.3%   74748722 ±  2%  proc-vmstat.numa_hit
  70084753 ±  2%      +6.3%   74504737 ±  2%  proc-vmstat.numa_local
     54187 ±  2%      +6.3%      57597 ±  2%  proc-vmstat.pgactivate
  74859673 ±  2%      +6.3%   79582401 ±  2%  proc-vmstat.pgalloc_normal
 1.024e+08 ±  2%      +6.4%   1.09e+08 ±  2%  proc-vmstat.pgfault
  74344826 ±  2%      +6.4%   79067399 ±  2%  proc-vmstat.pgfree
   4212400 ±  2%      +6.2%    4474364 ±  2%  proc-vmstat.pgreuse
      3869 ±  2%      +7.1%       4145 ±  3%  proc-vmstat.thp_fault_alloc
   1612101 ±  2%      +6.3%    1713519 ±  2%  proc-vmstat.unevictable_pgs_culled
      5.69 ±  2%      +5.1%       5.98 ±  2%  perf-stat.i.MPKI
      0.94 ±  2%      +0.0        0.98        perf-stat.i.branch-miss-rate%
 2.934e+08 ±  2%      +5.8%  3.105e+08 ±  2%  perf-stat.i.branch-misses
 2.844e+08 ±  2%      +6.1%  3.016e+08 ±  2%  perf-stat.i.cache-misses
  9.76e+08 ±  2%      +5.8%  1.033e+09 ±  2%  perf-stat.i.cache-references
      2.99            -1.3%       2.95        perf-stat.i.cpi
 5.226e+11            -0.9%  5.179e+11        perf-stat.i.cpu-cycles
  33882826 ±  2%      +7.2%   36317869 ±  2%  perf-stat.i.dTLB-store-misses
 9.478e+09 ±  2%      +5.9%  1.004e+10 ±  2%  perf-stat.i.dTLB-stores
      0.36            +2.1%       0.36        perf-stat.i.ipc
      1312 ±  8%     +39.6%       1831 ±  5%  perf-stat.i.major-faults
      2.33            -0.9%       2.31        perf-stat.i.metric.GHz
    513.19 ±  2%      +6.0%     544.03 ±  2%  perf-stat.i.metric.K/sec
   1545804 ±  2%      +6.5%    1646269 ±  2%  perf-stat.i.minor-faults
  60502067 ±  2%      +5.4%   63798162 ±  2%  perf-stat.i.node-load-misses
  14871403 ±  2%      +6.2%   15796551 ±  2%  perf-stat.i.node-loads
   1547117 ±  2%      +6.5%    1648101 ±  2%  perf-stat.i.page-faults
      5.78 ±  2%      +5.4%       6.10 ±  2%  perf-stat.overall.MPKI
      0.87 ±  2%      +0.0        0.92 ±  2%  perf-stat.overall.branch-miss-rate%
      3.10            -1.3%       3.06        perf-stat.overall.cpi
      1839 ±  3%      -6.6%       1718 ±  2%  perf-stat.overall.cycles-between-cache-misses
  12132105 ±  2%      -5.5%   11462241 ±  2%  perf-stat.overall.path-length
 2.901e+08 ±  2%      +5.8%   3.07e+08 ±  2%  perf-stat.ps.branch-misses
 2.815e+08 ±  2%      +6.1%  2.986e+08 ±  2%  perf-stat.ps.cache-misses
 9.661e+08 ±  2%      +5.8%  1.022e+09 ±  2%  perf-stat.ps.cache-references
 5.174e+11            -0.9%  5.128e+11        perf-stat.ps.cpu-cycles
  33544567 ±  2%      +7.2%   35957170 ±  2%  perf-stat.ps.dTLB-store-misses
 9.376e+09 ±  2%      +5.9%  9.933e+09 ±  2%  perf-stat.ps.dTLB-stores
      1299 ±  8%     +39.6%       1813 ±  5%  perf-stat.ps.major-faults
   1529961 ±  2%      +6.5%    1629550 ±  2%  perf-stat.ps.minor-faults
  59908353 ±  2%      +5.4%   63173333 ±  2%  perf-stat.ps.node-load-misses
  14730891 ±  2%      +6.2%   15646714 ±  2%  perf-stat.ps.node-loads
   1531260 ±  2%      +6.5%    1631363 ±  2%  perf-stat.ps.page-faults



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/lkp-cpl-4sp2/small-allocs/vm-scalability

commit: 
  73e791d738 ("mm: remove clear_page_idle()")
  6852c46c78 ("mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock")

73e791d73877e904 6852c46c783d20a4c0153d14d29 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     42167           +23.5%      52085        vm-scalability.median
     55.63            +4.8       60.48 ±  5%  vm-scalability.stddev%
   9445724           +23.5%   11667563        vm-scalability.throughput
    380.73            +5.2%     400.43        vm-scalability.time.elapsed_time
    380.73            +5.2%     400.43        vm-scalability.time.elapsed_time.max
    106067           +51.4%     160541        vm-scalability.time.involuntary_context_switches
 6.307e+08           +23.6%  7.795e+08        vm-scalability.time.minor_page_faults
     78306            +4.6%      81916        vm-scalability.time.system_time
    777.26           +22.8%     954.12        vm-scalability.time.user_time
   2562168 ±  2%     -19.3%    2068789 ±  3%  vm-scalability.time.voluntary_context_switches
 2.838e+09           +23.6%  3.507e+09        vm-scalability.workload
 5.815e+09           +10.4%  6.421e+09 ±  3%  cpuidle..time
      6.66            +0.3        6.99 ±  3%  turbostat.C1%
     17067 ±  2%     -16.7%      14220 ±  2%  vmstat.system.cs
      0.05            -0.0        0.04 ±  3%  mpstat.cpu.all.soft%
      0.96            +0.1        1.11        mpstat.cpu.all.usr%
      2261 ±  5%     +22.8%       2776 ±  6%  perf-c2c.HITM.local
      1329 ±  8%     +20.8%       1605 ±  4%  perf-c2c.HITM.remote
  18499960           +19.0%   22006663        meminfo.Memused
   2990186           +26.8%    3790943        meminfo.PageTables
  10350121           +26.1%   13050399        meminfo.SUnreclaim
  10515083           +25.7%   13215478        meminfo.Slab
  18692470           +19.1%   22260889        meminfo.max_used_kB
    407798 ± 17%     +67.2%     682010 ± 20%  sched_debug.cfs_rq:/.load.max
    869895 ± 16%     -34.9%     566399 ± 18%  sched_debug.cfs_rq:/.spread0.avg
   -743993           +53.2%   -1139615        sched_debug.cfs_rq:/.spread0.min
     17559 ±  2%     -12.8%      15312 ±  2%  sched_debug.cpu.nr_switches.avg
     13015 ±  2%     -10.6%      11629 ±  2%  sched_debug.cpu.nr_switches.min
      4612           -18.2%       3772 ± 10%  sched_debug.cpu.nr_switches.stddev
    223.38 ±  8%     -15.7%     188.21 ± 12%  sched_debug.cpu.nr_uninterruptible.max
   1169323           +13.4%    1326004 ±  4%  numa-numastat.node0.local_node
   1239338           +13.9%    1411769 ±  2%  numa-numastat.node0.numa_hit
   1115777 ±  2%     +16.7%    1302136 ±  3%  numa-numastat.node1.local_node
   1181029 ±  2%     +19.6%    1412041 ±  3%  numa-numastat.node1.numa_hit
     65251 ± 31%     +68.4%     109907 ±  7%  numa-numastat.node1.other_node
   1111909 ±  5%     +15.5%    1284183 ±  2%  numa-numastat.node2.local_node
   1218212 ±  5%     +11.5%    1358029        numa-numastat.node2.numa_hit
   1285007 ±  2%     +25.7%    1615828 ±  2%  numa-numastat.node3.local_node
   1391326 ±  2%     +21.8%    1694543 ±  2%  numa-numastat.node3.numa_hit
    137025 ±  2%      +6.1%     145442        proc-vmstat.nr_active_anon
     95233            -1.5%      93787        proc-vmstat.nr_anon_pages
   4427600            -2.0%    4339914        proc-vmstat.nr_dirty_background_threshold
   8866026            -2.0%    8690440        proc-vmstat.nr_dirty_threshold
  44521360            -2.0%   43643224        proc-vmstat.nr_free_pages
    747466           +26.8%     948001        proc-vmstat.nr_page_table_pages
    168941 ±  2%      +4.9%     177164        proc-vmstat.nr_shmem
   2587999           +26.1%    3264111        proc-vmstat.nr_slab_unreclaimable
    137025 ±  2%      +6.1%     145442        proc-vmstat.nr_zone_active_anon
   5032565           +16.8%    5879446        proc-vmstat.numa_hit
   4684671           +18.1%    5530835        proc-vmstat.numa_local
   7168214           +18.3%    8479220        proc-vmstat.pgalloc_normal
 6.322e+08           +23.5%   7.81e+08        proc-vmstat.pgfault
   6881231           +18.9%    8181469        proc-vmstat.pgfree
   3627776            +4.5%    3791232        proc-vmstat.unevictable_pgs_scanned
   3935473 ±  5%     +34.6%    5297695 ± 16%  numa-meminfo.node0.MemUsed
    748076           +26.7%     947801        numa-meminfo.node0.PageTables
   2597779           +26.1%    3275316        numa-meminfo.node0.SUnreclaim
   2625903           +26.1%    3310684        numa-meminfo.node0.Slab
    747754           +26.9%     948714        numa-meminfo.node1.PageTables
   2580884           +26.5%    3264576        numa-meminfo.node1.SUnreclaim
   2652930           +25.8%    3336480        numa-meminfo.node1.Slab
    141326 ± 10%     -21.1%     111532 ± 19%  numa-meminfo.node2.Inactive(anon)
   3886953 ±  2%     +20.1%    4666698        numa-meminfo.node2.MemUsed
    751265           +26.3%     949188        numa-meminfo.node2.PageTables
   2591514           +25.6%    3255894        numa-meminfo.node2.SUnreclaim
   2622178           +24.9%    3274703        numa-meminfo.node2.Slab
    327366 ± 10%     +39.0%     454988 ± 20%  numa-meminfo.node3.Active
    327339 ± 10%     +39.0%     454931 ± 20%  numa-meminfo.node3.Active(anon)
     17238 ±  7%     +16.9%      20158 ± 11%  numa-meminfo.node3.Mapped
   4217474           +22.9%    5184418 ±  3%  numa-meminfo.node3.MemUsed
    745042           +27.0%     946381        numa-meminfo.node3.PageTables
   2586773           +26.0%    3259792        numa-meminfo.node3.SUnreclaim
    379407 ± 18%     +30.5%     495065 ± 18%  numa-meminfo.node3.Shmem
   2620922           +25.9%    3298794        numa-meminfo.node3.Slab
      0.88 ± 71%     -80.8%       0.17 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.13 ± 53%    +311.7%       0.53 ± 55%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.20 ± 13%     +32.6%       0.26 ± 15%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.10 ±  9%    +110.7%       0.21 ±  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 28%    +138.4%       0.13 ± 29%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01        +14036.1%       1.70 ±221%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9.50 ± 34%    +476.1%      54.73 ± 84%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.31 ± 39%     -78.8%       0.49 ±216%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    138.30 ± 14%     +48.7%     205.63 ± 23%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
     13.72 ± 12%    +100.6%      27.53 ± 35%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9.63 ± 18%    +114.0%      20.60 ± 10%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.26 ±  6%     +17.9%       2.66 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
    213.13 ±  2%     -11.2%     189.35 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1074 ±  4%     +65.8%       1781 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
     39318 ±  7%     -17.4%      32472 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
    171.51 ± 29%     +87.8%     322.16 ± 43%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      2.06 ±  6%     +16.5%       2.40 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
    213.03 ±  2%     -11.2%     189.14 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.68 ± 19%     +53.1%      16.34 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.02 ± 29%     -42.3%       0.01 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     27.23 ± 10%     +56.4%      42.58 ± 17%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     72.93 ± 46%    +126.7%     165.37 ± 43%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
    186850           +26.8%     236835        numa-vmstat.node0.nr_page_table_pages
    648927           +26.1%     818461        numa-vmstat.node0.nr_slab_unreclaimable
   1239327           +13.9%    1411687 ±  2%  numa-vmstat.node0.numa_hit
   1169311           +13.4%    1325922 ±  4%  numa-vmstat.node0.numa_local
    186769           +26.9%     237070        numa-vmstat.node1.nr_page_table_pages
    644727           +26.5%     815732        numa-vmstat.node1.nr_slab_unreclaimable
   1180822 ±  2%     +19.6%    1411883 ±  3%  numa-vmstat.node1.numa_hit
   1115570 ±  2%     +16.7%    1301978 ±  3%  numa-vmstat.node1.numa_local
     65251 ± 31%     +68.4%     109907 ±  7%  numa-vmstat.node1.numa_other
     35329 ± 10%     -21.1%      27874 ± 19%  numa-vmstat.node2.nr_inactive_anon
    187645           +26.4%     237184        numa-vmstat.node2.nr_page_table_pages
    647359           +25.7%     813590        numa-vmstat.node2.nr_slab_unreclaimable
     35330 ± 10%     -21.1%      27874 ± 19%  numa-vmstat.node2.nr_zone_inactive_anon
   1218056 ±  5%     +11.5%    1357863        numa-vmstat.node2.numa_hit
   1111753 ±  5%     +15.5%    1284018 ±  2%  numa-vmstat.node2.numa_local
     81831 ± 10%     +38.9%     113699 ± 20%  numa-vmstat.node3.nr_active_anon
      4376 ±  8%     +17.1%       5125 ± 10%  numa-vmstat.node3.nr_mapped
    186088           +27.1%     236505        numa-vmstat.node3.nr_page_table_pages
     94854 ± 18%     +30.5%     123744 ± 18%  numa-vmstat.node3.nr_shmem
    646172           +26.1%     814570        numa-vmstat.node3.nr_slab_unreclaimable
     81831 ± 10%     +38.9%     113699 ± 20%  numa-vmstat.node3.nr_zone_active_anon
   1391229 ±  2%     +21.8%    1694455 ±  2%  numa-vmstat.node3.numa_hit
   1284909 ±  2%     +25.7%    1615740 ±  2%  numa-vmstat.node3.numa_local
 2.182e+10            +5.7%  2.307e+10        perf-stat.i.branch-instructions
     67.44            -1.4       66.01        perf-stat.i.cache-miss-rate%
 1.084e+08            +5.0%  1.138e+08 ±  3%  perf-stat.i.cache-references
     17046 ±  2%     -17.1%      14132 ±  2%  perf-stat.i.context-switches
      8.89            -2.0%       8.71        perf-stat.i.cpi
    488.32            +5.3%     514.19        perf-stat.i.cpu-migrations
      0.03            +0.0        0.04 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   9099499           +14.7%   10433460 ±  2%  perf-stat.i.dTLB-load-misses
 2.527e+10            +4.3%  2.636e+10        perf-stat.i.dTLB-loads
   1732945           +15.5%    2001701        perf-stat.i.dTLB-store-misses
 2.005e+09           +12.5%  2.256e+09        perf-stat.i.dTLB-stores
     93.66            -3.6       90.02        perf-stat.i.iTLB-load-miss-rate%
    431003 ±  5%     +42.8%     615338        perf-stat.i.iTLB-loads
 9.349e+10            +4.1%  9.729e+10        perf-stat.i.instructions
     17597            +4.2%      18333 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.12            +4.5%       0.12        perf-stat.i.ipc
    218.73            +5.1%     229.81        perf-stat.i.metric.M/sec
   1645267           +16.2%    1911350        perf-stat.i.minor-faults
     80.15            +1.7       81.87        perf-stat.i.node-load-miss-rate%
  22474764 ±  2%      +3.5%   23258402        perf-stat.i.node-load-misses
   6215674 ±  3%      -6.3%    5824416        perf-stat.i.node-loads
   5207478           +17.4%    6113199        perf-stat.i.node-store-misses
    831077           +17.9%     979621        perf-stat.i.node-stores
   1645267           +16.2%    1911350        perf-stat.i.page-faults
     68.37            -2.1       66.31        perf-stat.overall.cache-miss-rate%
      8.49            -4.5%       8.11        perf-stat.overall.cpi
      0.04            +0.0        0.04 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.09            +0.0        0.09        perf-stat.overall.dTLB-store-miss-rate%
     93.41            -2.5       90.92        perf-stat.overall.iTLB-load-miss-rate%
     15175            +3.4%      15687        perf-stat.overall.instructions-per-iTLB-miss
      0.12            +4.7%       0.12        perf-stat.overall.ipc
     78.20            +1.6       79.79        perf-stat.overall.node-load-miss-rate%
     12543           -11.2%      11140        perf-stat.overall.path-length
 2.183e+10            +6.1%  2.316e+10        perf-stat.ps.branch-instructions
 1.102e+08            +5.6%  1.164e+08 ±  2%  perf-stat.ps.cache-references
     17070 ±  2%     -16.9%      14191 ±  2%  perf-stat.ps.context-switches
    486.54            +5.7%     514.33        perf-stat.ps.cpu-migrations
   9294872           +15.8%   10767066 ±  2%  perf-stat.ps.dTLB-load-misses
 2.525e+10            +4.5%  2.639e+10        perf-stat.ps.dTLB-loads
   1747511           +16.6%    2038370        perf-stat.ps.dTLB-store-misses
 2.024e+09           +13.5%  2.298e+09        perf-stat.ps.dTLB-stores
    434045 ±  5%     +42.8%     619721        perf-stat.ps.iTLB-loads
 9.339e+10            +4.3%  9.739e+10        perf-stat.ps.instructions
   1658111           +17.4%    1946167        perf-stat.ps.minor-faults
  22728635 ±  2%      +4.0%   23636858        perf-stat.ps.node-load-misses
   6338224 ±  3%      -5.5%    5988664        perf-stat.ps.node-loads
   5139882           +17.1%    6017185        perf-stat.ps.node-store-misses
    840111           +18.9%     998845        perf-stat.ps.node-stores
   1658111           +17.4%    1946167        perf-stat.ps.page-faults
  3.56e+13            +9.8%  3.907e+13        perf-stat.total.instructions
     94.07            -1.6       92.46        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
     93.61            -1.6       92.01        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
     94.14            -1.6       92.57        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
     94.18            -1.6       92.62        perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     94.87            -1.3       93.61        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     94.94            -1.2       93.69        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.95            -1.2       93.70        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     94.99            -1.2       93.76        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     96.35            -0.9       95.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     96.35            -0.9       95.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     96.39            -0.9       95.53        perf-profile.calltrace.cycles-pp.__mmap
      0.77            +0.2        0.98        perf-profile.calltrace.cycles-pp.do_rw_once
      0.55            +0.3        0.81 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      0.56            +0.3        0.82 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
      0.80            +0.3        1.12        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      1.36            +0.4        1.72 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.36            +0.4        1.72 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.36            +0.4        1.72 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.36            +0.4        1.72 ±  5%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.33            +0.4        1.70 ±  5%  perf-profile.calltrace.cycles-pp.task_numa_work.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.16            +0.4        1.53 ±  6%  perf-profile.calltrace.cycles-pp.vma_migratable.task_numa_work.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.07            +0.4        1.48        perf-profile.calltrace.cycles-pp.do_access
     94.07            -1.6       92.46        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     93.63            -1.6       92.03        perf-profile.children.cycles-pp.osq_lock
     94.14            -1.6       92.57        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     94.18            -1.6       92.62        perf-profile.children.cycles-pp.down_write
     94.88            -1.3       93.61        perf-profile.children.cycles-pp.mmap_region
     94.94            -1.2       93.69        perf-profile.children.cycles-pp.do_mmap
     94.95            -1.2       93.70        perf-profile.children.cycles-pp.vm_mmap_pgoff
     94.99            -1.2       93.76        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     96.38            -0.9       95.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.38            -0.9       95.52        perf-profile.children.cycles-pp.do_syscall_64
     96.39            -0.9       95.54        perf-profile.children.cycles-pp.__mmap
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.mas_walk
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__perf_sw_event
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.sync_regs
      0.08            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mtree_range_walk
      0.10            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.17 ±  2%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.06            +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.28 ±  2%      +0.0        0.33 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.07 ±  7%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.___slab_alloc
      0.13 ±  3%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.07 ±  7%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.mas_destroy
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.mt_find
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.find_vma
      0.10            +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.mas_preallocate
      0.10            +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.09            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.09            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.10 ±  4%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.get_partial_node
      0.15 ±  5%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.up_write
      0.17 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.14 ±  6%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08            +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.28 ±  2%      +0.2        0.45 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.34 ±  2%      +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      2.24 ±  3%      +0.2        2.47 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.90            +0.2        1.15        perf-profile.children.cycles-pp.do_rw_once
      0.56            +0.3        0.81        perf-profile.children.cycles-pp.do_user_addr_fault
      0.57            +0.3        0.82        perf-profile.children.cycles-pp.exc_page_fault
      0.83            +0.3        1.16        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.36            +0.4        1.73 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.39            +0.4        1.78 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.38            +0.4        1.77 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      1.38            +0.4        1.77 ±  5%  perf-profile.children.cycles-pp.task_work_run
      1.36            +0.4        1.75 ±  5%  perf-profile.children.cycles-pp.task_numa_work
      1.18            +0.4        1.58 ±  5%  perf-profile.children.cycles-pp.vma_migratable
      1.46            +0.5        1.96        perf-profile.children.cycles-pp.do_access
     92.91            -1.6       91.28        perf-profile.self.cycles-pp.osq_lock
      0.38            -0.0        0.35        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.sync_regs
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mtree_range_walk
      0.06            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.08 ±  5%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  2%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.down_write
      0.17 ±  2%      +0.1        0.24        perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.08            +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.55            +0.1        0.70        perf-profile.self.cycles-pp.do_access
      0.24 ±  3%      +0.2        0.39 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.68            +0.2        0.86        perf-profile.self.cycles-pp.do_rw_once
      1.16            +0.4        1.56 ±  6%  perf-profile.self.cycles-pp.vma_migratable





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

