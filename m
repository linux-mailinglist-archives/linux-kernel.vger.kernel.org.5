Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC17ACA21
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIXOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIXOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:54:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95AFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695567273; x=1727103273;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Couc04AXjOSIgQ0+e25/PXk97m6vNshX1YViDcpiu0Y=;
  b=i9XK8mzjxIiPhtff9ts4c/+RrrhdecTc7LEAG60Ms+9+BeAMGkFGR2rL
   YfSLu+4b+7M8a50vb50NhzDuvN+ed1Yj2jl9LS/lR63JWIe/ntInh1/M1
   pc28wrc7V7EsORgny4PFSE3GGfTfT2oNJJBE67OCdV/xtdo8xrdU7OkNw
   aK1tef0Y+W2y/ea5aB5aposb1G8Kz0MY/L9zhbnNGz6o77EjcPrMSLSOJ
   g8alTYPn0ktl3rnx1Tz9ESU29HyXtYqIyCdC74Ql56wsqnioIaoCgHxqw
   9jZfDmBmKXqA0vqkX8xFldn2v/dEcypuVVprME8mM8lTy+8bnldIV6WKH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381009487"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="381009487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 07:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="724718469"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="724718469"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 07:54:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 07:54:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 07:54:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 07:54:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 07:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njCvVJTYBXrgRjYMX6Yv4pEwWmSOKMefb2vNAvdB0uik4Q+F82OwCSN4d1w53tpPERxPKnllQqKHu8aoGvkaIWsgePwmPJRek0gmHRbNyMyi3HMV72e40KR1bBACFV1xstlOV5sv0uiRZ3YzDzKSD6Y57CkKvf3SdNtzS8tv0vdbtYlBiw5YcZsXIBMQs8SdYBEixJOS6YEAMfAKZvj+IBU0DXjbblY0eESymaNiPUSAhYlws+6h0/EKZgZMzzOaM18g+l3/Z/0Lr8VbYD+SmQcZNBR8UjEhmTfLgJzWJUI5aYu4+cMCHGR4LG5/z8clFjpWv5HsRtqgJR+x2ktFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXSE/UWX4FuIjbsob60JHA7D5p6uHURyd/te+3AScu8=;
 b=aC+skRqznwQr5CAFCQPZau2VLuoc/y93qEi9YePp1MfPCsV1tv3fp05PdAhnB4W+zCFZvLLrzarHjHS/hzBlyY2NzTfqKsyt0TdNgn5a0OUC5RUcnI/tpS+ZIdERcKyPvLmUdsuS8Mxj5BhU+dH047z0B8n100Z+njJu76OiIXalxL4+Q2WiReGYdVp830kF1b6eIgDEFSPUiruI+bhYRK/xmljcg1gt9nUgUsOr8s3F+95vU+GRunf4n7exjT3VbVfJohyacBhUT7avOoHQLl2mK5mQPjU3dujEFwUtYMNxK0297kFCtwCjiDuIlJSFy2cjS9jfg35C1mkl9L1gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sun, 24 Sep
 2023 14:54:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 14:54:22 +0000
Date:   Sun, 24 Sep 2023 22:54:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [maple_tree]  52ae298e3e:
 stress-ng.madvise.ops_per_sec 3.5% improvement
Message-ID: <202309242216.3b413af9-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d43aa8-d4a6-4ffd-361e-08dbbd0e22c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4rwdcgfDtKvBGE5Loj4PoVPdoS/jwLLtXn+9HRKK5HkCnopSiW24Zgz7RLkQ8pwoN5+umq6U9pod/AV2UqYIYWGp4BGBIdgTc+Kn7xE4CDt9B7L/dsa/O/0WIMyPbeHk4bwfYaQwXPNOdLDW3L6nnyP8xyo4hl0brMwC3MEfLs8WzN46C54qDGWniGKFoDCrJOa16Rcug7DJGbfrQH3P1dZ6lrIl3wOvSvThsVUbc85qqSL2ln7N5gucoEGiGg48AQvROYokYU1QZEaZO6ziIzuuSLBqjy+1o8s0yCC1oicFfS6HkbtJSjXJOAlTCpC5zJWREuyK0vzrSiDtMxeXAkWNH7O0wr0ul9FLSCjmGqu34ViKVNkzsko3kI5nebQSrZqDK8clyswmhEagH3oifVYcAvyF2EHB3LrBDQajGpi+hZIyjvedWXuxbZrUTj6+aD3z2zftuuqpzyINBw+GO1xtc9znSO7I16m9UuqLaF5/98ezFz7gTU6DPSJzKO7O0YSdT3oSRBT56Sq77pmf4p9/srELQjJGa6zUm58Dz7V8u3R9dE+ZvpzejqrnZS0aA7WfZMLrl611MPqmKZNDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(4326008)(5660300002)(26005)(2616005)(1076003)(8936002)(8676002)(107886003)(83380400001)(30864003)(2906002)(36756003)(38100700002)(86362001)(6666004)(19627235002)(966005)(6506007)(478600001)(6512007)(66556008)(54906003)(316002)(66476007)(82960400001)(6486002)(41300700001)(6916009)(66946007)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7hKcAf1uaKo874YtrXB8mxro9MPA/8zrbTJQ9p/foBMxs+N/2eJ9mzHd2o?=
 =?iso-8859-1?Q?8OP+OPlI74E5mfcRVghA0Oyp9U/g8MBORZlqkEBdSZCDu4Ks5NisfV63DI?=
 =?iso-8859-1?Q?Z9l1VHeC6lt6ukGBodEpVmy5E7dJ3vEcQQ/lDISnYuLZ5IFuE98miDH7Hs?=
 =?iso-8859-1?Q?Go/jZCTEPG41jqQZZ9PBwHvxTk9L8Bo0F9Ye9SLji9tIEHg1SL/Z5O+RsO?=
 =?iso-8859-1?Q?g9ob5CR+B/f5WXmovLGqhUX95sYJzymsSzuBU45khdwDnIpjPHkLit1fys?=
 =?iso-8859-1?Q?xguijM34TtvZ3cd6pcPfjOROymbv8zQspvo4FO3kxZnynqRpdAHKzZ2wI8?=
 =?iso-8859-1?Q?BpFHZOpnQjcmuD5kmiiHduPuspcBsHm14BRmI2g5hRpxmDpHXWkr6H25w4?=
 =?iso-8859-1?Q?7U5PlXCYubbpsqnNvhCrKMHZikcPIg53QQ67ymvLS5BEDawjqQ32JXmwHw?=
 =?iso-8859-1?Q?edpfyBgw4Ipw2c+oaGlOvEQkFIpj5Ysq8WjuV5e7fVEr7DZ/kgGgCw5SUq?=
 =?iso-8859-1?Q?dn9EUSlYp1saMamtPYESrDlsmBjI3YtxccjwVXkwPwdopLW3QyAP0DtryF?=
 =?iso-8859-1?Q?Fu1RBl2Ptghg8dNnCPuzJQcELFjUmZKTZM5WnLaf6q1cMGzvuq/Bc66ExV?=
 =?iso-8859-1?Q?mZG7BKqaVXQb3bAFqAH06DyLATOf8xL/rNZ5J9PVeJomemamEkDDBV5FN4?=
 =?iso-8859-1?Q?HUyNuKtwxh2EY+VnpMh48JUHOxMwpM/DGDCg8YPOfEL0VhoZ7TByUzaatj?=
 =?iso-8859-1?Q?wGVuwHk8BDv6+QdLNt5PfqKfgWVNVHT55nBtndhWulge86ybSZ+m6Qavx1?=
 =?iso-8859-1?Q?Veg9MOL4bKc/0JZU2YXuqbedX+z2pU+0EWjsclPlIvlNQgJPAPvkxoJu6K?=
 =?iso-8859-1?Q?8uDoXi8XolD/8s+iEtIvBe/3dHVr2lEHQQ5oLjLbUEp5KKwJSQvnPXf4iF?=
 =?iso-8859-1?Q?Mt4IhfH2qeUgUJtSG5y20+eXoxJi2m4kEBkogvL93fUAvUCG4SH6eh9Tw5?=
 =?iso-8859-1?Q?rAUE2XZcwHiJf1ovFh1CadGIoBn9skXQd8jKlQ8lS4cyeMVtaCovUxmcbe?=
 =?iso-8859-1?Q?RJcapOkDMH44AQaIkoyFMcERMEnPk6O/7YpkS2mgfJFJSyFhmKPgJT7tQM?=
 =?iso-8859-1?Q?5n0sTF5zZfUJhlkDpcsVkfTcA8nT3bMtj/BpWqvjMJvw8DtvxCwHJqpEKO?=
 =?iso-8859-1?Q?n7aY1naNXhpbFvtNtQmV9hwvhRdd1oTtwiJOYPFo1bgEGnMNJU6j/hajC7?=
 =?iso-8859-1?Q?7RsvA6f2yF3FJkGuxgEIxw9+ypogSP/G5dW5xIdp1CdSyyUUihl40fBzL1?=
 =?iso-8859-1?Q?ANUB3CeQMttH3/jwKS5u+OBAIQzEbF3yyTHesA/gxlDwkn9y4nGLF61z2N?=
 =?iso-8859-1?Q?GHp+z7aRd2n2rnEEWrYSgPYwMYie4ql5GV5bWW49l4USQPgonolU+xX1sa?=
 =?iso-8859-1?Q?7PxByeG1p+/SvXfqVU2JamLlySaDweMbopksaVUiqMxlcG7XgSPJog3kyy?=
 =?iso-8859-1?Q?Irahb0UZdnM1F0Y4vvFzMg5U+s8ZtTLrSS9gQiVKSYszK7z5YbkkRigPFa?=
 =?iso-8859-1?Q?MlJDpcL1m8tmtCI0phrVI6Vrux9NgwI6SDRnP68TsGbSnPQ7xEGGxxYrG0?=
 =?iso-8859-1?Q?8OzgjjTavQC17z94GapuMwnFoWNxDljZFOcJsKsdz9pyLGpiM8KV9YXg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d43aa8-d4a6-4ffd-361e-08dbbd0e22c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 14:54:21.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+saVNZ9sPWQzbYIqO9+FHnzw0aVN1Z/fQ5DPTNiOb7JnZUeedWBacUC1j2Ot8j0qnXrjn5zIQt4RC/EarBNIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 3.5% improvement of stress-ng.madvise.ops_per_sec on:


commit: 52ae298e3e5c9be5bb95e1c6d9199e5210f2a156 ("maple_tree: shrink struct maple_tree")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: vm
	test: madvise
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230924/202309242216.3b413af9-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  vm/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/madvise/stress-ng/60s

commit: 
  432af5c966 ("maple_tree: clean up mas_wr_append()")
  52ae298e3e ("maple_tree: shrink struct maple_tree")

432af5c966667f12 52ae298e3e5c9be5bb95e1c6d91 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    142.68            +3.5%     147.67        stress-ng.madvise.ops_per_sec
      0.35 ±  7%     -20.7%       0.28 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.35 ±  7%     -20.1%       0.28 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
    107.78 ± 13%     -32.6%      72.60 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     14496 ± 13%     -29.6%      10212 ± 16%  sched_debug.cpu.curr->pid.avg
      0.36 ±  6%     -22.7%       0.27 ±  4%  sched_debug.cpu.nr_running.avg
    182077 ± 43%     +61.2%     293438 ± 12%  numa-meminfo.node0.AnonPages
    224490 ± 35%     +48.4%     333235 ±  9%  numa-meminfo.node0.AnonPages.max
    204400 ± 38%     +51.3%     309269 ± 12%  numa-meminfo.node0.Inactive
    187986 ± 42%     +59.4%     299635 ± 12%  numa-meminfo.node0.Inactive(anon)
     16413 ± 24%     -41.3%       9633 ± 37%  numa-meminfo.node0.Inactive(file)
      2470 ± 11%     +25.5%       3098 ±  6%  numa-meminfo.node0.PageTables
      2889 ±  8%     -18.9%       2342 ±  6%  numa-meminfo.node1.PageTables
     45508 ± 43%     +61.2%      73348 ± 12%  numa-vmstat.node0.nr_anon_pages
     47018 ± 42%     +59.3%      74900 ± 12%  numa-vmstat.node0.nr_inactive_anon
      4122 ± 24%     -41.9%       2397 ± 37%  numa-vmstat.node0.nr_inactive_file
    617.00 ± 11%     +25.5%     774.17 ±  6%  numa-vmstat.node0.nr_page_table_pages
     47018 ± 42%     +59.3%      74895 ± 12%  numa-vmstat.node0.nr_zone_inactive_anon
      4122 ± 24%     -41.9%       2397 ± 37%  numa-vmstat.node0.nr_zone_inactive_file
    721.83 ±  8%     -18.9%     585.17 ±  7%  numa-vmstat.node1.nr_page_table_pages
      0.00           +50.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__mm_populate
      0.03           +11.2%       0.03        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      0.03          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
     24741 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
      1095 ±  5%     -18.3%     895.33 ±  7%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_mprotect_pkey
      0.92 ± 86%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
      0.02           +11.9%       0.03        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      0.01 ±  3%     +16.4%       0.01 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
      0.02           +15.5%       0.03 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
      0.28 ±  9%     -21.6%       0.22 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.smaps_pte_range.walk_pmd_range.isra.0
      2.39 ±  2%     +18.6%       2.83        perf-stat.i.MPKI
      1.01            +0.1        1.09        perf-stat.i.branch-miss-rate%
     31.95 ±  2%      +3.2       35.12        perf-stat.i.cache-miss-rate%
      2.24            -2.9%       2.17        perf-stat.i.cpi
    959.61 ±  2%     -17.1%     795.28        perf-stat.i.cycles-between-cache-misses
      0.01            +0.0        0.01        perf-stat.i.dTLB-store-miss-rate%
     51.23            +1.8       53.05        perf-stat.i.node-store-miss-rate%
  12624855 ±  3%     +18.4%   14953167 ±  5%  perf-stat.i.node-store-misses
      2.42 ±  2%     +18.1%       2.86        perf-stat.overall.MPKI
      0.98            +0.1        1.06        perf-stat.overall.branch-miss-rate%
     32.34 ±  2%      +3.3       35.62        perf-stat.overall.cache-miss-rate%
      2.24            -3.2%       2.17        perf-stat.overall.cpi
    924.09 ±  2%     -18.1%     757.01        perf-stat.overall.cycles-between-cache-misses
      0.01            +0.0        0.01        perf-stat.overall.dTLB-store-miss-rate%
     51.86            +1.6       53.47        perf-stat.overall.node-store-miss-rate%
  12420952 ±  3%     +18.4%   14710333 ±  5%  perf-stat.ps.node-store-misses
     47.32            -9.8       37.56        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
     50.47            -9.7       40.78        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64
     51.00            -9.5       41.51        perf-profile.calltrace.cycles-pp.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.02            -9.2       28.78        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
     65.19            -6.8       58.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     65.26            -6.8       58.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     64.94            -6.8       58.18        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     64.98            -6.7       58.23        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     65.84            -6.7       59.13        perf-profile.calltrace.cycles-pp.__madvise
      0.52            +0.0        0.56        perf-profile.calltrace.cycles-pp.seq_put_decimal_ull_width.__show_smap.show_smap.seq_read_iter.seq_read
      0.58            +0.0        0.63 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise.do_syscall_64
      0.54            +0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__show_smap.show_smap.seq_read_iter.seq_read.vfs_read
      0.57 ±  3%      +0.1        0.63        perf-profile.calltrace.cycles-pp.__mmap
      0.57 ±  3%      +0.1        0.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.57 ±  3%      +0.1        0.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.84            +0.1        0.92        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake.up_write
      0.56            +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.71 ±  2%      +0.1        0.79 ±  3%  perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64
      0.53            +0.1        0.62        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.osq_lock
      0.87 ±  2%      +0.1        0.96 ±  3%  perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86            +0.1        0.95        perf-profile.calltrace.cycles-pp.down_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66            +0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_wake.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59            +0.1        0.69        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.osq_lock.rwsem_optimistic_spin
      0.58            +0.1        0.69        perf-profile.calltrace.cycles-pp.up_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.65 ±  2%      +0.1        0.76        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath
      0.62            +0.1        0.73        perf-profile.calltrace.cycles-pp.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
      0.57            +0.1        0.68        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
      0.63            +0.1        0.74        perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range
      0.64            +0.1        0.74        perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout
      0.58            +0.1        0.69        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      0.87            +0.1        0.99        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable
      0.67            +0.1        0.79        perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior
      0.62            +0.1        0.75        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      0.67            +0.1        0.79        perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise
      1.34 ±  2%      +0.1        1.47 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable
      0.72            +0.1        0.85        perf-profile.calltrace.cycles-pp.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.62 ±  3%      +0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.mt_find.find_vma.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38 ±  2%      +0.1        1.51 ±  2%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
      1.38 ±  2%      +0.1        1.52 ±  2%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
      0.64 ±  3%      +0.1        0.77 ±  2%  perf-profile.calltrace.cycles-pp.find_vma.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      1.06            +0.1        1.21 ±  2%  perf-profile.calltrace.cycles-pp.vma_merge.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.82            +0.2        0.97        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.55 ±  2%      +0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.osq_unlock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
      1.26 ±  2%      +0.2        1.43        perf-profile.calltrace.cycles-pp.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.80            +0.2        1.98        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_write.do_madvise
      1.16            +0.2        1.34        perf-profile.calltrace.cycles-pp.rwsem_mark_wake.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      1.91            +0.2        2.09        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      0.45 ± 44%      +0.2        0.64 ±  4%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.09            +0.2        1.30        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.68 ±  2%      +0.2        0.89        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
      1.04 ±  2%      +0.2        1.29        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.07            +0.3        1.32        perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.60 ±  2%      +0.3        0.88 ± 20%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_preempt_disabled
      0.34 ± 70%      +0.3        0.62 ±  4%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.43 ±  2%      +0.3        1.72        perf-profile.calltrace.cycles-pp.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      1.23 ±  2%      +0.3        1.52 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.27 ±  2%      +0.3        1.57 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      2.30 ±  7%      +0.3        2.63 ±  6%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
      0.34 ± 70%      +0.3        0.68        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      3.12 ±  5%      +0.4        3.48 ±  4%  perf-profile.calltrace.cycles-pp.show_smap.seq_read_iter.seq_read.vfs_read.ksys_read
      1.92            +0.4        2.28        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.98            +0.4        2.36        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.17 ±141%      +0.4        0.54        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath
      0.25 ±100%      +0.4        0.64        perf-profile.calltrace.cycles-pp.madvise_cold.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      3.62 ±  4%      +0.4        4.05 ±  4%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.61 ±  4%      +0.4        4.04 ±  4%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      3.64 ±  4%      +0.4        4.07 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.66 ±  4%      +0.4        4.09 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.68 ±  4%      +0.4        4.12 ±  4%  perf-profile.calltrace.cycles-pp.read
      3.66 ±  4%      +0.4        4.09 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.65 ±  4%      +0.4        4.09 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.80            +0.5        2.27        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.62 ±  4%      +0.5        1.12 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.madvise_free_single_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__do_sys_msync
      1.83            +0.6        2.44        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      1.86            +0.6        2.46        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__do_sys_msync.do_syscall_64
      2.36            +0.6        2.97        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.85 ±  2%      +0.6        2.46        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__do_sys_msync
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.resched_curr.check_preempt_curr.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      5.24            +0.6        5.88        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rwsem_wake.up_write.do_madvise
      3.13            +0.8        3.92        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      3.32            +0.8        4.14        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__do_sys_msync.do_syscall_64
      3.76            +0.9        4.64        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.do_madvise.__x64_sys_madvise.do_syscall_64
      4.11            +1.0        5.09        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      4.22            +1.1        5.31        perf-profile.calltrace.cycles-pp.up_write.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.62            +1.2        7.86        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.24            +1.3        7.58        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.42            +1.6        5.00        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.14            +1.7        5.89        perf-profile.calltrace.cycles-pp.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      6.34            +2.2        8.52        perf-profile.calltrace.cycles-pp.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      6.48            +2.2        8.69        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      6.54            +2.2        8.75        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msync
      7.22            +2.3        9.52        perf-profile.calltrace.cycles-pp.msync
     14.75            +2.8       17.53        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     15.16            +2.9       18.02        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     15.24            +2.9       18.12        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     16.08            +3.0       19.08        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     18.74            +3.4       22.16        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     18.77            +3.4       22.20        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     19.14            +3.4       22.57        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     18.79            +3.4       22.22        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     20.27            +3.8       24.10        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     48.28            -9.8       38.43        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     50.63            -9.7       40.89        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     51.15            -9.5       41.62        perf-profile.children.cycles-pp.down_write_killable
     38.31            -9.3       29.05        perf-profile.children.cycles-pp.osq_lock
     64.98            -6.7       58.23        perf-profile.children.cycles-pp.__x64_sys_madvise
     65.24            -6.7       58.52        perf-profile.children.cycles-pp.do_madvise
     65.97            -6.7       59.28        perf-profile.children.cycles-pp.__madvise
     77.42            -3.9       73.52        perf-profile.children.cycles-pp.do_syscall_64
     77.53            -3.9       73.64        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.proc_mem_open
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.reweight_entity
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.error_entry
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.09 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.__do_sys_clone
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.10            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.__clone
      0.11 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.seq_path
      0.15 ±  2%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.09 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.try_to_unmap_flush
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.read_tsc
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.arch_tlbbatch_flush
      0.17 ±  2%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.16 ±  5%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.m_stop
      0.13 ±  4%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.08 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.18 ±  5%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.mas_preallocate
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.get_cpu_device
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.update_min_vruntime
      0.13 ±  6%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      0.11 ±  3%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.pid_smaps_open
      0.24 ±  3%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  4%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.vma_prepare
      0.17 ±  5%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.mas_split
      0.15 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.copy_page
      0.24 ±  3%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.num_to_str
      0.20            +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.strlen
      0.18 ±  5%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.20 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.down_write
      0.19 ±  3%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.14 ±  5%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__call_rcu_common
      0.23 ±  4%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.19 ±  3%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__close
      0.32 ±  4%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.show_map_vma
      0.48            +0.0        0.51 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.23 ±  4%      +0.0        0.26        perf-profile.children.cycles-pp.lru_add_drain
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.stress_madvise_pages
      0.18 ±  4%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.14 ±  4%      +0.0        0.17        perf-profile.children.cycles-pp.do_open
      0.22 ±  4%      +0.0        0.25        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      0.19 ±  7%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.18 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.zap_pmd_range
      0.17 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.10 ±  7%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.irqentry_exit
      0.48            +0.0        0.51 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.33            +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.27 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.syscall
      0.24 ±  4%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.24 ±  5%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.27 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.__do_sys_process_madvise
      0.23            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.24 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.46 ±  2%      +0.0        0.49 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.folio_referenced_one
      0.22 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.20 ±  4%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.tick_irq_enter
      0.16 ±  3%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.down_read_killable
      0.35 ±  5%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      0.35 ±  5%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.__munmap
      0.21 ±  3%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      0.35 ±  4%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.38 ±  2%      +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.seq_puts
      0.21 ±  5%      +0.0        0.25 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.24 ±  2%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.30 ±  2%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.26 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.26 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.kthread
      0.21 ±  4%      +0.0        0.25        perf-profile.children.cycles-pp.folio_referenced
      0.16 ±  8%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.poll_idle
      0.11 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.33 ±  5%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.26 ±  3%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.26 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.28            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.22 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.stress_mwc32
      0.16 ±  3%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.33 ±  5%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.10 ±  5%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__calc_delta
      0.28 ±  2%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.48 ±  3%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.smaps_account
      0.32 ±  4%      +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.30 ±  4%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.do_fault
      0.36            +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.29 ±  4%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.do_cow_fault
      0.34 ±  2%      +0.0        0.39        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.35 ±  3%      +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.33 ±  3%      +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.28 ±  6%      +0.1        0.33 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.20 ±  4%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.m_start
      0.55            +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.__show_smap
      0.34            +0.1        0.39        perf-profile.children.cycles-pp.path_openat
      0.31 ±  7%      +0.1        0.37 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.34            +0.1        0.40        perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.wake_q_add_safe
      0.57 ±  3%      +0.1        0.63        perf-profile.children.cycles-pp.__mmap
      0.30 ±  6%      +0.1        0.36 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.57 ±  3%      +0.1        0.63        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.30 ±  6%      +0.1        0.36 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.23 ±  3%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.34            +0.1        0.40        perf-profile.children.cycles-pp.update_rq_clock
      0.50 ±  3%      +0.1        0.56        perf-profile.children.cycles-pp.__get_user_pages
      0.50 ±  3%      +0.1        0.56 ±  2%  perf-profile.children.cycles-pp.populate_vma_page_range
      0.70            +0.1        0.76        perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.36 ±  6%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.41            +0.1        0.47        perf-profile.children.cycles-pp.do_sys_openat2
      0.54 ±  4%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.55 ±  4%      +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      0.50 ±  4%      +0.1        0.57        perf-profile.children.cycles-pp.__mm_populate
      0.42            +0.1        0.49        perf-profile.children.cycles-pp.open64
      0.41            +0.1        0.48        perf-profile.children.cycles-pp.__x64_sys_openat
      0.51 ±  2%      +0.1        0.58        perf-profile.children.cycles-pp.rcu_do_batch
      0.44 ±  2%      +0.1        0.50        perf-profile.children.cycles-pp.mas_store_prealloc
      0.29 ±  3%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.54 ±  2%      +0.1        0.62        perf-profile.children.cycles-pp.rcu_core
      0.36 ±  3%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.43 ±  6%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.newidle_balance
      0.26 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__x2apic_send_IPI_mask
      0.35            +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.stress_mwc64
      0.28 ±  3%      +0.1        0.36        perf-profile.children.cycles-pp.available_idle_cpu
      0.21            +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.58            +0.1        0.66 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.29 ±  4%      +0.1        0.37        perf-profile.children.cycles-pp.wake_affine
      0.54 ±  2%      +0.1        0.62        perf-profile.children.cycles-pp.wake_q_add
      0.74 ±  2%      +0.1        0.82 ±  3%  perf-profile.children.cycles-pp.mas_walk
      0.44 ±  4%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.32 ±  4%      +0.1        0.41        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.64 ±  2%      +0.1        0.72        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.66            +0.1        0.75        perf-profile.children.cycles-pp.__do_softirq
      0.38            +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.irqentry_enter
      0.88 ±  2%      +0.1        0.97 ±  3%  perf-profile.children.cycles-pp.find_vma_prev
      0.54 ±  4%      +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.43 ±  3%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.madvise_free_single_vma
      0.60            +0.1        0.70        perf-profile.children.cycles-pp.reclaim_pages
      0.58            +0.1        0.68        perf-profile.children.cycles-pp.reclaim_folio_list
      0.54            +0.1        0.63        perf-profile.children.cycles-pp.shrink_folio_list
      0.61            +0.1        0.70        perf-profile.children.cycles-pp.native_irq_return_iret
      0.60 ±  2%      +0.1        0.70 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.58            +0.1        0.68        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.44 ±  2%      +0.1        0.54        perf-profile.children.cycles-pp.select_task_rq_fair
      0.50 ±  2%      +0.1        0.62        perf-profile.children.cycles-pp.flush_tlb_func
      0.24 ±  5%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.mm_cid_get
      0.56            +0.1        0.68 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.51            +0.1        0.64        perf-profile.children.cycles-pp.select_task_rq
      0.82 ±  4%      +0.1        0.95 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.23 ±  2%      +0.1        1.36 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
      1.08            +0.1        1.23        perf-profile.children.cycles-pp.vma_merge
      0.78            +0.1        0.93 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.56 ±  2%      +0.2        0.71        perf-profile.children.cycles-pp.madvise_cold
      0.66 ±  2%      +0.2        0.81        perf-profile.children.cycles-pp.llist_reverse_order
      0.56 ±  2%      +0.2        0.72 ±  2%  perf-profile.children.cycles-pp.update_curr
      1.00            +0.2        1.16        perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
      0.82 ±  3%      +0.2        0.97 ±  2%  perf-profile.children.cycles-pp.find_vma
      0.50 ±  2%      +0.2        0.67        perf-profile.children.cycles-pp.resched_curr
      0.55 ±  2%      +0.2        0.72        perf-profile.children.cycles-pp.check_preempt_curr
      1.27            +0.2        1.45        perf-profile.children.cycles-pp.__split_vma
      0.56 ±  2%      +0.2        0.74 ±  2%  perf-profile.children.cycles-pp.osq_unlock
      0.95 ±  2%      +0.2        1.12 ±  2%  perf-profile.children.cycles-pp.mt_find
      1.13            +0.2        1.32        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.73            +0.2        0.92        perf-profile.children.cycles-pp.llist_add_batch
      1.11 ±  5%      +0.2        1.30 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.80            +0.2        1.00        perf-profile.children.cycles-pp.finish_task_switch
      1.09            +0.2        1.30        perf-profile.children.cycles-pp.zap_page_range_single
      1.39            +0.2        1.62        perf-profile.children.cycles-pp.walk_page_range
      1.20            +0.2        1.44 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      1.20 ±  2%      +0.3        1.45        perf-profile.children.cycles-pp.dequeue_entity
      1.31 ±  2%      +0.3        1.58        perf-profile.children.cycles-pp.dequeue_task_fair
      1.02            +0.3        1.29        perf-profile.children.cycles-pp.__sysvec_call_function
      1.40 ±  2%      +0.3        1.68 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.27            +0.3        1.55        perf-profile.children.cycles-pp.madvise_pageout
      1.44 ±  2%      +0.3        1.73 ±  2%  perf-profile.children.cycles-pp.activate_task
      1.16            +0.3        1.46        perf-profile.children.cycles-pp.sysvec_call_function
      3.14 ±  5%      +0.4        3.50 ±  4%  perf-profile.children.cycles-pp.show_smap
      2.03            +0.4        2.40        perf-profile.children.cycles-pp.schedule_idle
      1.74            +0.4        2.12        perf-profile.children.cycles-pp.asm_sysvec_call_function
      2.84 ±  5%      +0.4        3.23 ±  5%  perf-profile.children.cycles-pp.walk_p4d_range
      2.82 ±  5%      +0.4        3.21 ±  5%  perf-profile.children.cycles-pp.walk_pud_range
      2.80 ±  5%      +0.4        3.18 ±  5%  perf-profile.children.cycles-pp.walk_pmd_range
      1.35            +0.4        1.74        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      1.35            +0.4        1.74        perf-profile.children.cycles-pp.smp_call_function_many_cond
      2.22            +0.4        2.63        perf-profile.children.cycles-pp.up_read
      1.38            +0.4        1.79        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.68            +0.4        2.10        perf-profile.children.cycles-pp.rwsem_mark_wake
      2.58            +0.4        3.01        perf-profile.children.cycles-pp.try_to_wake_up
      3.62 ±  4%      +0.4        4.04 ±  4%  perf-profile.children.cycles-pp.seq_read_iter
      3.62 ±  4%      +0.4        4.05 ±  4%  perf-profile.children.cycles-pp.seq_read
      3.64 ±  4%      +0.4        4.07 ±  4%  perf-profile.children.cycles-pp.vfs_read
      3.65 ±  4%      +0.4        4.09 ±  4%  perf-profile.children.cycles-pp.ksys_read
      1.54            +0.4        1.98        perf-profile.children.cycles-pp.tlb_finish_mmu
      3.00 ±  5%      +0.4        3.44 ±  4%  perf-profile.children.cycles-pp.walk_pgd_range
      3.68 ±  4%      +0.4        4.12 ±  4%  perf-profile.children.cycles-pp.read
      3.01 ±  5%      +0.4        3.45 ±  4%  perf-profile.children.cycles-pp.__walk_page_range
      2.77            +0.4        3.22        perf-profile.children.cycles-pp.wake_up_q
      1.06 ±  2%      +0.4        1.50        perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.02            +0.5        2.48        perf-profile.children.cycles-pp.ttwu_do_activate
      1.38 ±  2%      +0.6        1.95 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.63            +0.6        3.24        perf-profile.children.cycles-pp.sched_ttwu_pending
      1.37 ±  2%      +0.7        2.05        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.59            +0.7        5.28        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.63            +0.7        4.38        perf-profile.children.cycles-pp.schedule_preempt_disabled
      3.66            +0.8        4.41        perf-profile.children.cycles-pp.schedule
      3.66            +0.8        4.50        perf-profile.children.cycles-pp.__sysvec_call_function_single
      4.49            +1.0        5.50        perf-profile.children.cycles-pp.sysvec_call_function_single
      4.93            +1.0        5.96        perf-profile.children.cycles-pp.rwsem_wake
      4.45            +1.0        5.49        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      5.58            +1.1        6.70        perf-profile.children.cycles-pp.__schedule
      4.62            +1.2        5.79        perf-profile.children.cycles-pp.up_write
      6.91            +1.3        8.18        perf-profile.children.cycles-pp.madvise_vma_behavior
      4.19            +1.7        5.87        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      5.10            +1.9        6.96        perf-profile.children.cycles-pp.down_read
      6.36            +2.2        8.54        perf-profile.children.cycles-pp.__do_sys_msync
      7.33            +2.3        9.65        perf-profile.children.cycles-pp.msync
     12.90            +2.5       15.36        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     15.03            +2.8       17.82        perf-profile.children.cycles-pp.acpi_idle_enter
     15.00            +2.8       17.79        perf-profile.children.cycles-pp.acpi_safe_halt
     15.46            +2.9       18.33        perf-profile.children.cycles-pp.cpuidle_enter_state
     15.53            +2.9       18.41        perf-profile.children.cycles-pp.cpuidle_enter
     16.40            +3.0       19.40        perf-profile.children.cycles-pp.cpuidle_idle_call
     19.12            +3.4       22.54        perf-profile.children.cycles-pp.do_idle
     19.14            +3.4       22.57        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     19.14            +3.4       22.57        perf-profile.children.cycles-pp.cpu_startup_entry
     18.79            +3.4       22.22        perf-profile.children.cycles-pp.start_secondary
     37.28            -9.3       27.96        perf-profile.self.cycles-pp.osq_lock
      5.28            -1.5        3.77        perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.47 ±  3%      -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.irqtime_account_irq
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.os_xsave
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.sysvec_call_function_single
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.place_entity
      0.11 ±  6%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.read_tsc
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.08 ±  4%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.14 ±  3%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.stress_mwc32modn
      0.15 ±  4%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.stress_madvise_pages
      0.10 ±  3%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.asm_sysvec_call_function_single
      0.11 ±  6%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.19            +0.0        0.21        perf-profile.self.cycles-pp.strlen
      0.16 ±  4%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.dequeue_entity
      0.23 ±  3%      +0.0        0.25        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ±  3%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp.mtree_load
      0.18 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.down_write
      0.16 ±  3%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.smaps_page_accumulate
      0.18 ±  5%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.13 ±  8%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.poll_idle
      0.10 ±  3%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.select_task_rq
      0.16 ±  2%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.do_idle
      0.07 ± 10%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.23 ±  4%      +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.16 ±  4%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.18 ±  3%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__madvise
      0.46            +0.0        0.49 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.vma_merge
      0.24 ±  3%      +0.0        0.27 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.45 ±  2%      +0.0        0.48 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.21 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.stress_mwc32
      0.16 ±  4%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.25 ±  4%      +0.0        0.29 ±  4%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.17 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.18 ±  6%      +0.0        0.22 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.10 ± 10%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__calc_delta
      0.34 ±  3%      +0.0        0.38 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__x2apic_send_IPI_mask
      0.31 ±  3%      +0.0        0.36 ±  4%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.22 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.update_rq_clock
      0.28 ±  4%      +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.15 ±  3%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.walk_pgd_range
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.wake_q_add_safe
      0.23 ±  3%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.cpuacct_charge
      0.23 ±  2%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.43 ±  3%      +0.1        0.50 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.36 ±  2%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.21 ±  2%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.32            +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.stress_mwc64
      0.32 ±  4%      +0.1        0.40        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.28 ±  3%      +0.1        0.36        perf-profile.self.cycles-pp.available_idle_cpu
      0.53 ±  2%      +0.1        0.61        perf-profile.self.cycles-pp.wake_q_add
      0.27 ±  3%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.flush_tlb_func
      0.50 ±  2%      +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.madvise_vma_behavior
      0.53 ±  4%      +0.1        0.62 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.32 ±  2%      +0.1        0.41 ±  3%  perf-profile.self.cycles-pp.irqentry_enter
      0.30 ±  4%      +0.1        0.40 ±  6%  perf-profile.self.cycles-pp.mt_find
      0.61            +0.1        0.70        perf-profile.self.cycles-pp.native_irq_return_iret
      0.42 ±  5%      +0.1        0.52 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.62 ±  3%      +0.1        0.74 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.24 ±  6%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.mm_cid_get
      0.56            +0.1        0.68 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.63 ±  3%      +0.1        0.75        perf-profile.self.cycles-pp.do_madvise
      1.20 ±  2%      +0.1        1.33 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.65 ±  2%      +0.2        0.80        perf-profile.self.cycles-pp.llist_reverse_order
      0.62 ±  2%      +0.2        0.78        perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.50 ±  2%      +0.2        0.67        perf-profile.self.cycles-pp.resched_curr
      0.70            +0.2        0.88 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
      0.43            +0.2        0.60 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.52 ±  2%      +0.2        0.70        perf-profile.self.cycles-pp.finish_task_switch
      0.55 ±  2%      +0.2        0.73 ±  2%  perf-profile.self.cycles-pp.osq_unlock
      0.73            +0.2        0.91        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.50 ±  3%      +0.2        0.68        perf-profile.self.cycles-pp.down_write_killable
      0.89            +0.2        1.08 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.98 ±  2%      +0.2        1.17 ±  2%  perf-profile.self.cycles-pp.down_read
      0.77 ±  2%      +0.2        0.97 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.84            +0.2        1.08        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      1.05 ±  3%      +0.2        1.30        perf-profile.self.cycles-pp.up_read
      0.94            +0.2        1.18        perf-profile.self.cycles-pp.rwsem_mark_wake
      0.83 ±  2%      +0.3        1.12 ±  2%  perf-profile.self.cycles-pp.up_write
      1.36 ±  2%      +0.7        2.03        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.72            +0.7        4.44        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      9.50            +1.6       11.09        perf-profile.self.cycles-pp.acpi_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

