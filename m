Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405B7A4CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjIRPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIRPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:43:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9208FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051640; x=1726587640;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=0wWpHrT1663r5gkToGX0Afzo6ELaOnUZZN/FNEwNb4U=;
  b=Xopd48dot7eVi9fP4aFfepiIa3R2UnhpxfVgvCk36rWWNngaE1Pkvsp3
   e1NcCJAUrwOg8bokhMqKm6yTlfQOOmbjlUvC2+VqpcAN6GJLqzqvAE30A
   MjOqKiCQG9WDyJ0nvEHoE0mjm8fY4528YvB16Ohm4ii+OsMu/uO0+LHfO
   xpCDf5hvWBdWr6GY88yAUXnfdAuueaHNc9OD/cJQOFdQYWYirSEOxtYMr
   40szx2ZvoAWTlj8c06Cm95SYQxT1OVIg1icFhsQbJJOHnogHUkKu+FBRe
   wcjJP9SdEnY4IrHmgLXM0C450gG2cW7n75aBnp+StgcVtPk4dFccexmy0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="376998292"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="376998292"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749054127"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="749054127"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 08:08:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 08:08:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 08:08:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 08:07:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj012dU7l4VB8Q8mRcoZLKqAKRZWFGnurT/l2DyudahunevkN8xRhxDu9l719B5uUh7hvIdkNoPdiscwOHptx2Dj9QMwSs/Dbg7bh+X1aFdKz+bpYydd20uBxgxJ9Y9S7cjFjM4ttrDdxnf2LIJZizQ4G0VR4ijd6YJjUtZBHU3onzOj8CNMS7Dln+eaq6NRJIt1z4pH1v4ymO4eFrpFCnLNLhV5Iql8S4YSmbLDl0vlnrrW3n9ohLRVqmlPJ1BXfq/yMLPcAxfvD6XL2zDcQzz0gUb2v2rDEzzEgptBJdSs0P4Ibid6lVKNs4K/Xa9gpZ7RTsuMBrKXJrtakUl8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxa6aQxHBBRPgIEXbYwNS710UhwOqUXrUetSQ0H5t+Q=;
 b=U1barVylcJpNrOG8cih3V1ZyAoBVHDh0kokxyPjCcPOitVxg6isgQwa7iuJFWH/++X+cKxr6qynTXfEtg0vaRg8sNfzejjGWyDGlFf7EQZaPKnwGfK6nqQUn9kfKZ7gUVb/6jyz71o1ijroaWEVyTOY0EYVFIZqnIx/sUTfht5KoNn20p3QNKFtKEPzyL1y3o1NFdHmVY+W8UD7qpr9qS7z6JaY/3QbhFE76q2NKnd8lNOXHp7RV1Pl3xv+WJGPrut7roKD5Iuq7jU0GT6ar/RR6O6zl3CkWAN8vrqvVGXXr+g+umAcCZc1EyY8XAn0loCsZjggG47e7uGAddw9Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 15:07:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:07:56 +0000
Date:   Mon, 18 Sep 2023 23:07:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [workqueue]  fe089f87cc:
 fxmark.ssd_xfs_dbench_client_72_bufferedio.works/sec -32.0% regression
Message-ID: <202309182202.4bab967a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8120d5-b346-45f8-5fe8-08dbb85909e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSN1XHgbyL/fcNND6lX789zIFmMGXalv9g9GolVInlPo8ZtE4nzx9Me14tePW5SjE8eBImJSMmRjgZw4XBxQTvc5SjyShm9Kt1ecWtyNcMvc5Hti8+zqxE9h7Mv+MBjsSw4Deavd945dbnV9J4dqnTdF7z42H4m4npExcz5Q0gj7j9jFJHD8w4g25AVvyvIvs2+iZJx+f70RYmWVz0s5OmWV/xH2FUypZ4ASnPh3cuuRwKM3frOyKrKI8PEQfsl3z7cMrkrhnFgjAnqBt+CZW6hJgac6UsmewEjukCQ3Y2r4dPgRC133BUpexjbUnQMlSdudci83Ze0o7rqnzvjBmQ//nauJChu6FxOnVtWpHfpAf4JHLP1z8MYCOsmBHih5lLZTb7P1CpqHyyxpYAe4QcaUN8A99KLiku59GPZAdPDBBMKyFj6fDAV9NsEZAowVZVcC22wIUnFkQhnxL3s/rhl80UpAdOZolLk/C+0BK13zQhgh/I3ZcGH6s43KwASKGkNvXk9uPwhHmlkdYOGm1b0JpSb0tbYF2FJOInIpoWf7GQmt4AGV2NzYYDaZLQsfyv0JmtmdigrUKajd2lrSIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(316002)(6916009)(86362001)(66476007)(66946007)(66556008)(30864003)(38100700002)(82960400001)(2906002)(36756003)(41300700001)(966005)(5660300002)(478600001)(6666004)(6506007)(6486002)(6512007)(4326008)(8676002)(8936002)(1076003)(107886003)(83380400001)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cqkc3fGJgZ8dOuhbyaU1Uo8YlVw9L06mKiI9xSjx2mmVpxhqXRPPC6fDVm?=
 =?iso-8859-1?Q?lls9iZzF1QtAH3yb0sOuhc+QUYqDJtoHFj0YkVbqkw4N2kMx3AdPgruWlr?=
 =?iso-8859-1?Q?0IZgkC5z3uFfkMWhylZMg7AVa9Gy8PvsqI324mJweLDCaD0WJg7VVyKub9?=
 =?iso-8859-1?Q?ucEbhSLsw2gZKcXOO0rFNILfDEws5Lmknin6aAHTHyAwAMgBUKMx6UgCME?=
 =?iso-8859-1?Q?Yl9zKWwE7lohPHdOxATNfdXc5DxsjEUo/F4lRJ0uJKStMz0aqk0yzl+8bb?=
 =?iso-8859-1?Q?WFMMn2Kn/xzF5yY7qa5yDHFdEYvuH4LeBwgS1Mq1TX77nWOxwZNMKNGNxr?=
 =?iso-8859-1?Q?/zy2xTMzSr2107I39ZQOEaSkP4W30elStxuSO5NsSN6PPpMsKoI8hXjtHX?=
 =?iso-8859-1?Q?pwJrXV5CKLaITBeUzaE76AwITMYd77NqEKU/zFEu0aKF/rtUfxDbhGXv6S?=
 =?iso-8859-1?Q?afVOFYwKCyg9KeqtESFE4bN5WiTKsftOSUAxNh7tuq7z1bv4E4UweSeN2Z?=
 =?iso-8859-1?Q?MU8pNPrbqlqxgQggLwFSNq5pG9uTFH2DwzKRj19p0wojoNg0yIWdz1+u3m?=
 =?iso-8859-1?Q?dHCFxSczoC/gpwyQA5Hy22rPp3FOMwVsFN8E2mbhrXieTjqbCbmYt7iP54?=
 =?iso-8859-1?Q?YFiA9xTRmCEHNJPTSARgw7UwnyC/NycvKDqwCryNFakq3Zt84O8WJWtwIp?=
 =?iso-8859-1?Q?iFr7V8QaX3Z4ePOVw0eBO7reapNhsmh4Rw/HJk7Rw/KFeeU0oEBBGCaVBh?=
 =?iso-8859-1?Q?mfgarE6gKRw4n7cmCNPhe6cVf8QbJL06i86egl7dStpoDeIdusK6Eh77Xo?=
 =?iso-8859-1?Q?u0MsjHYzJKbHs7pmu5wAjUYaHsFQT+SH+1NoJK/dk5Xkpmx6A6/TyLaW23?=
 =?iso-8859-1?Q?N2FucVFrRG+7BmDFIXpXHVi3CO92dWJ/G13m+uRBocQ8UButq7SnTafjKH?=
 =?iso-8859-1?Q?6ERcj4BNFkRWdfF7VnNHEOCnB9vEDW2ohYSLMTsf3ZRWOIvZjCxlkES++R?=
 =?iso-8859-1?Q?2cHFlXMk2urxIvQE7vAMyKkDTswPm7foUrGl9Q4d0+N4qBWxtJJxiP6GI6?=
 =?iso-8859-1?Q?tjTasK6xeyTLh9eB6MZWTbefefDuKKNwqUevywKVOXiJV6X596dbw6ekOy?=
 =?iso-8859-1?Q?i78qLU3I5erpodY+MObB348qKdd5EEGugc+3A5YU4JdXkOVhQmxwBsNUyE?=
 =?iso-8859-1?Q?TAEtOTl5aOlwe0tHJ80zThr5junbb8r+kM3jMZcw+U+C29cvy39x1FObCx?=
 =?iso-8859-1?Q?e+tYOKg6qNyKIr/HmhAvyQ07RR8lYmrdzdYLCQefo16j8ZLXKivCoEi+rf?=
 =?iso-8859-1?Q?CJOC1V0pH2zLyOz8+zVFaSBy2XukGra5kEEMHjlmLCaD3SfQAl3/nKxT0s?=
 =?iso-8859-1?Q?ZTyAf1NBdgzKvp2P5wTWhre+4DIN/1Le0aMW/aPE56Hj5yoeSxoeLwlaoc?=
 =?iso-8859-1?Q?rRll312TKVIJnXhVvqJk5D2oy+lCyn9S0svfrEz6vaU3DuU+FT3ypj0r+y?=
 =?iso-8859-1?Q?hGoDb5h0BDH04LepeCHT51HpNSUpsW8PD34iwLL0m1TlH5k5qZmietzY7j?=
 =?iso-8859-1?Q?Q/30+xkvydlT50gyCSaeHvyUCImpxEZsHpcK3Oq49C1S8sNq3nl+SiZMCW?=
 =?iso-8859-1?Q?Cv2/Ec2CwKMInonLcj+zYAXsPU7tcFFPxyAugJUJWTbLJvCHjw6w6vuw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8120d5-b346-45f8-5fe8-08dbb85909e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:07:56.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMkx8IndF213C2mePhgcr/WwxUr0/Hcj1okyqGxYmBiZtba/Xxk9d6ezstJrdKdjXbFHDf8bZrajuAkwTFIHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -32.0% regression of fxmark.ssd_xfs_dbench_client_72_bufferedio.works/sec on:


commit: fe089f87cccb066e8ad20f49ddf05e95adc1fa8d ("workqueue: Not all work insertion needs to wake up a worker")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fxmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1SSD
	media: ssd
	test: dbench_client
	fstype: xfs
	directio: bufferedio
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309182202.4bab967a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230918/202309182202.4bab967a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/bufferedio/1SSD/xfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/dbench_client/fxmark

commit: 
  c0ab017d43 ("workqueue: Cleanups around process_scheduled_works()")
  fe089f87cc ("workqueue: Not all work insertion needs to wake up a worker")

c0ab017d43f4c414 fe089f87cccb066e8ad20f49ddf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  39209971           -10.4%   35133502 ±  2%  cpuidle..usage
     52.91            +5.1%      55.59        iostat.cpu.idle
     22.75            -9.7%      20.56 ±  2%  iostat.cpu.iowait
  10466069 ±  2%     -29.5%    7376773 ± 11%  numa-numastat.node1.local_node
  10510900 ±  2%     -28.8%    7480808 ± 11%  numa-numastat.node1.numa_hit
      1179 ± 15%     -22.0%     919.83 ±  5%  perf-c2c.DRAM.remote
      1145 ± 14%     -29.3%     809.67 ±  9%  perf-c2c.HITM.local
     46807 ± 21%     -45.8%      25346 ± 50%  numa-meminfo.node0.Active(anon)
    504904 ± 25%     -45.3%     276367 ± 47%  numa-meminfo.node0.Shmem
     66660 ±  8%     -33.3%      44451 ± 18%  numa-meminfo.node1.Dirty
   -828.44           -61.2%    -321.18        sched_debug.cpu.nr_uninterruptible.avg
     -5154           -58.8%      -2121        sched_debug.cpu.nr_uninterruptible.min
    892.09 ±  6%     -49.8%     447.61 ± 21%  sched_debug.cpu.nr_uninterruptible.stddev
    142456 ±  2%      -7.6%     131656 ±  3%  vmstat.io.bo
    124966 ±  2%     -20.0%      99939 ±  4%  vmstat.system.cs
     51184            -8.8%      46683 ±  2%  vmstat.system.in
    124596 ±  2%     -19.9%      99792 ±  4%  perf-stat.i.context-switches
      3454 ±  2%     -31.2%       2377 ± 10%  perf-stat.i.cpu-migrations
    124479 ±  2%     -19.9%      99650 ±  4%  perf-stat.ps.context-switches
      3453 ±  2%     -31.2%       2374 ± 10%  perf-stat.ps.cpu-migrations
    131582 ± 15%     -23.7%     100437 ± 14%  meminfo.Active
     59138 ± 34%     -52.4%      28159 ± 49%  meminfo.Active(anon)
   1088512 ± 22%     -30.6%     755813 ± 19%  meminfo.Committed_AS
    380805           -11.5%     337183 ±  3%  meminfo.Dirty
   1235425 ± 18%     -24.4%     933365 ± 14%  meminfo.Inactive
    902090 ± 24%     -33.8%     596946 ± 21%  meminfo.Inactive(anon)
    642365 ± 37%     -52.0%     308283 ± 46%  meminfo.Shmem
     11701 ± 21%     -45.9%       6336 ± 50%  numa-vmstat.node0.nr_active_anon
    126226 ± 25%     -45.3%      69093 ± 47%  numa-vmstat.node0.nr_shmem
     11701 ± 21%     -45.9%       6336 ± 50%  numa-vmstat.node0.nr_zone_active_anon
  10617306 ±  2%     -29.5%    7484793 ± 12%  numa-vmstat.node1.nr_dirtied
     16646 ±  8%     -33.2%      11111 ± 18%  numa-vmstat.node1.nr_dirty
   2570325 ±  2%     -28.0%    1849961 ± 12%  numa-vmstat.node1.nr_written
     16619 ±  8%     -33.2%      11093 ± 18%  numa-vmstat.node1.nr_zone_write_pending
  10510971 ±  2%     -28.8%    7480700 ± 11%  numa-vmstat.node1.numa_hit
  10466140 ±  2%     -29.5%    7376665 ± 11%  numa-vmstat.node1.numa_local
     14789 ± 34%     -52.4%       7043 ± 48%  proc-vmstat.nr_active_anon
  73542893           -12.1%   64665529 ±  4%  proc-vmstat.nr_dirtied
     95176           -11.2%      84481 ±  3%  proc-vmstat.nr_dirty
    949397 ±  6%      -8.7%     866798 ±  4%  proc-vmstat.nr_file_pages
    225533 ± 24%     -33.8%     149239 ± 21%  proc-vmstat.nr_inactive_anon
    160600 ± 37%     -52.0%      77072 ± 46%  proc-vmstat.nr_shmem
  17820341           -10.9%   15872978 ±  3%  proc-vmstat.nr_written
     14789 ± 34%     -52.4%       7043 ± 48%  proc-vmstat.nr_zone_active_anon
    225533 ± 24%     -33.8%     149239 ± 21%  proc-vmstat.nr_zone_inactive_anon
     94869           -11.3%      84180 ±  3%  proc-vmstat.nr_zone_write_pending
  72272965           -11.9%   63654005 ±  4%  proc-vmstat.numa_hit
  72137253           -11.9%   63522521 ±  4%  proc-vmstat.numa_local
   1532444 ±  4%     -15.8%    1290917 ±  4%  proc-vmstat.pgactivate
  72444739           -11.9%   63805246 ±  4%  proc-vmstat.pgalloc_normal
    170396 ± 37%     -52.2%      81460 ± 46%  proc-vmstat.pgdeactivate
  72261159           -11.8%   63709587 ±  4%  proc-vmstat.pgfree
  84054518            -7.2%   77981052 ±  2%  proc-vmstat.pgpgout
      2064           +20.2%       2480 ±  7%  fxmark.ssd_xfs_dbench_client_54_bufferedio.idle_sec
     63.92           +19.5%      76.41 ±  7%  fxmark.ssd_xfs_dbench_client_54_bufferedio.idle_util
    743.56 ±  2%     -42.5%     427.65 ± 33%  fxmark.ssd_xfs_dbench_client_54_bufferedio.iowait_sec
     23.03 ±  2%     -42.8%      13.18 ± 33%  fxmark.ssd_xfs_dbench_client_54_bufferedio.iowait_util
     41.98           +32.2%      55.50 ± 12%  fxmark.ssd_xfs_dbench_client_54_bufferedio.irq_sec
      1.30           +31.5%       1.71 ± 12%  fxmark.ssd_xfs_dbench_client_54_bufferedio.irq_util
     10.09           -17.7%       8.31 ± 11%  fxmark.ssd_xfs_dbench_client_54_bufferedio.softirq_sec
      0.31           -18.1%       0.26 ± 11%  fxmark.ssd_xfs_dbench_client_54_bufferedio.softirq_util
    297.40           -26.7%     218.07 ± 19%  fxmark.ssd_xfs_dbench_client_54_bufferedio.sys_sec
      9.21           -27.0%       6.72 ± 19%  fxmark.ssd_xfs_dbench_client_54_bufferedio.sys_util
     71.92           -22.2%      55.94 ± 15%  fxmark.ssd_xfs_dbench_client_54_bufferedio.user_sec
      2.23           -22.6%       1.72 ± 15%  fxmark.ssd_xfs_dbench_client_54_bufferedio.user_util
      5264           -28.2%       3777 ± 19%  fxmark.ssd_xfs_dbench_client_54_bufferedio.works/sec
      2971           +19.2%       3543        fxmark.ssd_xfs_dbench_client_72_bufferedio.idle_sec
     68.77           +18.6%      81.58        fxmark.ssd_xfs_dbench_client_72_bufferedio.idle_util
    910.14 ±  6%     -51.0%     446.38 ± 11%  fxmark.ssd_xfs_dbench_client_72_bufferedio.iowait_sec
     21.06 ±  6%     -51.2%      10.28 ± 11%  fxmark.ssd_xfs_dbench_client_72_bufferedio.iowait_util
     76.95           +31.1%     100.90 ±  2%  fxmark.ssd_xfs_dbench_client_72_bufferedio.irq_sec
      1.78           +30.4%       2.32 ±  2%  fxmark.ssd_xfs_dbench_client_72_bufferedio.irq_util
     11.05           -15.6%       9.33 ±  2%  fxmark.ssd_xfs_dbench_client_72_bufferedio.softirq_sec
      0.26           -16.0%       0.21 ±  2%  fxmark.ssd_xfs_dbench_client_72_bufferedio.softirq_util
    281.46 ±  2%     -31.1%     193.89 ±  5%  fxmark.ssd_xfs_dbench_client_72_bufferedio.sys_sec
      6.51 ±  2%     -31.5%       4.46 ±  5%  fxmark.ssd_xfs_dbench_client_72_bufferedio.sys_util
     70.03 ±  3%     -29.2%      49.56 ±  5%  fxmark.ssd_xfs_dbench_client_72_bufferedio.user_sec
      1.62 ±  3%     -29.6%       1.14 ±  5%  fxmark.ssd_xfs_dbench_client_72_bufferedio.user_util
      4529 ±  2%     -32.0%       3080 ±  5%  fxmark.ssd_xfs_dbench_client_72_bufferedio.works/sec
 5.884e+08           -12.1%  5.173e+08 ±  4%  fxmark.time.file_system_outputs
   8226682           -26.2%    6068375 ±  7%  fxmark.time.involuntary_context_switches
    204845            -1.2%     202350        fxmark.time.minor_page_faults
    209.83           -16.0%     176.17 ±  5%  fxmark.time.percent_of_cpu_this_job_got
    943.47           -17.0%     783.39 ±  5%  fxmark.time.system_time
    299.18           -11.7%     264.25 ±  3%  fxmark.time.user_time
  18576211           -16.6%   15496778 ±  5%  fxmark.time.voluntary_context_switches
      0.01 ± 41%     -90.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__mutex_lock.constprop.0.__flush_workqueue
      0.01 ± 89%    +490.2%       0.05 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_force_lsn
      0.03 ± 54%     +97.5%       0.05 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xfs_can_free_eofblocks.xfs_release.__fput
      0.01 ± 30%     -93.2%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__mutex_lock.constprop.0.__flush_workqueue
      0.41 ± 18%     -49.0%       0.21 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time
    770542 ± 44%     -58.4%     320650 ± 55%  perf-sched.total_wait_and_delay.count.ms
      0.46 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
    555.61 ± 19%     +28.0%     711.18 ±  8%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    177.28 ±  8%     +18.7%     210.40 ±  7%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.67 ± 12%     +38.1%       0.93 ± 23%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     52.59 ± 71%     -98.7%       0.70 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      1.80 ± 28%    +194.2%       5.28 ± 31%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.67 ± 13%     -43.0%       0.38 ± 56%  perf-sched.wait_and_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fsync
      4396 ± 49%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     18311 ± 52%     -68.1%       5841 ± 62%  perf-sched.wait_and_delay.count.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      5076 ± 44%     -83.9%     817.33 ±162%  perf-sched.wait_and_delay.count.__cond_resched.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
    120.67 ±  3%     -37.6%      75.33 ± 71%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    262.17 ± 39%     -51.7%     126.50 ± 51%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      8.42 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     10.54 ± 10%     +96.1%      20.67 ± 83%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
    554.95 ± 87%     -92.9%      39.45 ±223%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.43 ± 41%     -98.3%       0.01 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__mutex_lock.constprop.0.__flush_workqueue
    555.59 ± 19%     +28.0%     711.16 ±  8%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    177.24 ±  8%     +18.7%     210.35 ±  7%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.33 ± 41%    +293.7%       1.28 ± 39%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.56 ± 46%    +195.7%       1.65 ± 57%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.66 ± 13%     +37.6%       0.91 ± 22%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     52.58 ± 71%     -95.0%       2.61 ± 91%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      1.79 ± 28%    +194.6%       5.27 ± 31%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      7.29 ± 25%     +39.4%      10.17 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin
      1.32 ± 87%     -81.7%       0.24 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.__filemap_fdatawait_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fsync
      5.99 ± 31%     +69.4%      10.14 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_lookup
      0.73 ± 66%     -99.0%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.__flush_workqueue
      8.41 ±  9%     +36.1%      11.44 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      3.42 ± 46%     -72.2%       0.95 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_file_fsync.__x64_sys_fsync.do_syscall_64
      6.45 ± 39%     +55.2%      10.00 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_ilock.xfs_file_buffered_read.xfs_file_read_iter
      8.75 ± 20%     +37.4%      12.02 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_ilock_data_map_shared.xfs_dir_open.do_dentry_open
      7.50 ± 11%     +39.9%      10.49 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_create
      3.28 ± 79%     -67.8%       1.06 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
      6.70 ± 28%     +56.6%      10.49 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin
      8.38 ± 34%     +56.7%      13.13 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      9.59 ± 14%     +33.7%      12.82 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      9.16 ± 23%     +29.4%      11.86 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      8.25 ± 25%     +41.5%      11.68 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      7.87 ± 28%     +45.3%      11.43 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      8.36 ± 28%     +43.2%      11.97 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      8.65 ± 11%     +37.6%      11.90 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      7.41 ± 32%     +45.8%      10.81 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

