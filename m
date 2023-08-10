Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27793777312
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjHJIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjHJIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:35:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D162103;
        Thu, 10 Aug 2023 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691656539; x=1723192539;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=fESBtOCHL4H/5o/6nd9U1PzdKwRQsVpQO/vwuxR0Hjo=;
  b=aoY2A0NequtW2xjloD5vPm+/5+FnHQ7LRP1OUWQvFfzLUyVO1MwUn/bM
   /WK+1OlP9s4MPnHZbQcPmg7J+LhgC07m4+23RkB8W5n0nUxNWnk8vKzgI
   ROyaeXe/ai67R9HOnLDmexg9ZnmtVyhrJ3S+aveezrOILTer/kQ/tvTL3
   vdH1sUYNU7eC0hgDNcYzmHh/N71WX2bdPtL6iw3rzXSkYcxguZlBsfq79
   7EVIxBqpb7yMU6yyZ6eHKasRc/AvJ5vhBShlA02dhY5bxE5l0gl78wRLR
   Uo41yyZYibeuY8KR6nV4wvtLqgehKTxHNVpA9zfeGW1prCfSFrXiyFtKM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371334562"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="371334562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905965676"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="905965676"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 01:35:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 01:35:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 01:35:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 01:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdebLuZunpPP/aiKIoslhaxm0O6z4bGUAH36urNG/FJqkG/3w7v3+7pRGwGRmD7ptIfOYFQgo3uorrSQV23kKSHhqW2OWaBsVNxzXjyHBVoUw0kHADEs2jlq6Pfmafai6p+GaJzMwAR8Mse6ePRqhi34EbfmD+L3J1oFoc49XwGsTsmp5XQT6bwHk86QcTMfDx9ZzJmT9mKVo0/1CJGiAL6xOCXiminAXIS+M1JhCbk45D7oG/WBQhw6yNcXXGXhF9BtxVKpSKDrJtKvqkNzf9THR7YyZmbfixMZOn0lVeFtmAELs8Rr22m2Ax61VuGmn7pSxFfaKDNCV0rT+2b98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yhR/6Sak44quYuAPliM+qPu+QkB2CBmiaAn1JYccUc=;
 b=Y8ZOFun/GE/bM1tO9JXMOcjudQd4ZMVEoU8oE3gOdIr6M+U1XFl7WO9ejYagaUvIpFEzEZv0XRFjBZ1MS3FmEY0mvXRsPu/xa0D5aUp1MsFhHBAtwEKC1VVGLKbUg0btp8wUs6nwjHeQzJI2TEOBxIrCzTho9S6nr5qZOcuUuHfer/wqegnIGO9lnwQZaFkytz5IXDooHwib9e1kK0rlfx5XhCVils1dMSeeTO4HEoHoGeHSC3c3y2JD+tebW7bVNLK90P0O8u5ofFhYYWcscLZjGMoE9+2ZIVb+Jvfzzq9fvAmVoRPL/vdboBGFa+AHtbxX9Xff8Q25MdFW5bb6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 08:35:35 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66%6]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 08:35:35 +0000
Date:   Thu, 10 Aug 2023 16:35:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ajay Kaher <akaher@vmware.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linux-next:master] [eventfs]  27152bceea:
 stress-ng.getdent.ops_per_sec -8.4% regression
Message-ID: <202308101425.8416d10d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: RO1PR80CA0233.lamprd80.prod.outlook.com (2603:10d6:10::31)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a79fc9-c0dc-4c86-c063-08db997cc42e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GJvYBzLfV4D4zTnv0EsFPJ8phit7IuZUtlED9NGEqaV4So2UOfPzA4Bt9Jj0Ee4posTAS4pNIagPbjlXE+q2w3dT+wfy4J7+ksfrQVakjCIzYlGi4hXIobybDWGr/Bonz73nUN8zu58LlRYbys1shIN4mSwHRY5yYfWhtm/hVLLVUZ5hbkFarZgOkVYoEWIid+sfbzfEMvRsMPmB1gAlEDtEqmsFjh38RMm/tMK9RMBxBhcQF3xNOGEWO2EZxHNtrG8eFLwLqqRA9mG8heJhHQMloeeaKzVXwsi+bKW/jfDxOVvINIfWa8k13pj7U6Z6Ac2bqTOsaiLGkhcdF1PpzAq0LHAXmy8wbEwu6we4c7a8mDQFhA9NTfbZ9/6h7cGc2BhKfdEex+AUhx/0edt0Cw01Vmg+CNf5HnqZ6H0Wrp9y1LNuPyUF6XieHsEJ9aKMwLaJ3LZFw2BfsK5wm991m7RL4U0/U2k/gGJJGzQfIQpMdE93LUgRgcN5wDueBsojIQmJExMFxva4/jGwb3SCmgnGlwabv8YyN6dtU5lfXbdiRGC/AfDvYI5py1zBVaYAGXTIUeXq8eUiHdikOfMbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(1800799006)(186006)(478600001)(38100700002)(86362001)(6486002)(54906003)(6666004)(82960400001)(6916009)(4326008)(966005)(6512007)(66476007)(66556008)(66946007)(316002)(41300700001)(36756003)(107886003)(83380400001)(8676002)(2906002)(2616005)(30864003)(5660300002)(26005)(8936002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WzMcpXEvSSaHjCHkJvAh154dKVlUkr3J2JR0uhblGcrI/3lrfTYbkBv/3q?=
 =?iso-8859-1?Q?hbzVn11dhLeXpXzEFg1Y3V/eJgPuHQ5LX7ZBQaD4UxuyUNJAZDHONM/M8z?=
 =?iso-8859-1?Q?1McapLOGA6py51WIkJFCP+dS1kb2vFkbq2JM9CSfGpMNpm7GmzKl8eoJGj?=
 =?iso-8859-1?Q?vv4+gGrD54Ict5oWVyUd2ZVZ7Ckp7/a/f24QRlAnuFQn1FDKqLSCJLPoQB?=
 =?iso-8859-1?Q?iUddEXA6qyAHyCAlMcoBpT2tA/VrVL2QQO8dPxYESvtBEzUFfP/vx8s5pQ?=
 =?iso-8859-1?Q?QiwEmirktsbdXK+lkEqroiGlir/Q7g1DoKIf/PY7D6CPuVV1WePpXC6+7X?=
 =?iso-8859-1?Q?YLp9IezGgSJHoVwL4ohfPymNh6MRSaGE3h3me+E33oo43pJ0eN8BI/U7QW?=
 =?iso-8859-1?Q?cpjE+/tuMlFy8/PpvFlmaBLJXxxKKownRSOSmg8m6pAQKkcgqwqD0UnVn3?=
 =?iso-8859-1?Q?XRNFFwtO4Np4ppId7n1qbXLnOrFL8+ycCIcC37GI1PFF7V6FmGbdfCcuEj?=
 =?iso-8859-1?Q?uXc9jyTNGKdTvQUhEObKJdO4ggM8z4w34yQtDOvio0HnmyRMkYSoU2CCUj?=
 =?iso-8859-1?Q?1Zj58Ac2EljBz9GaGEWsMzZR6vyRTG35N4RGY0iEuvYZt5qlDdJvaOYt6D?=
 =?iso-8859-1?Q?NCMRx370CelCXNxiVKNOCe5jGh5NR7+QjskkeUDaXF6Kaz2UezNqMXccRF?=
 =?iso-8859-1?Q?kqwvntkc3rY33oHUgF7msaYp4YykaI/B8MEobMBIfE/qPOwGlEdC0khryB?=
 =?iso-8859-1?Q?24W6V1C3bsLZD2eN0y/DqAfy7CL0Yo7/navlH2tcRjPdtnDT9QrCvDYa9+?=
 =?iso-8859-1?Q?BpP89hHT15HmEbeXLKSLklsCN8O3wknrH77y5FVISbpp6H1IhtoyqVlamn?=
 =?iso-8859-1?Q?OgbuiE8wb70wrl73hUYIaj3gb59Cdi1c2iRKDk6/SWOg2HdkFZuw7z0nHY?=
 =?iso-8859-1?Q?UqP7L/8qpyE2R0UKMzo2MdoJS4QZF6L0ltYRzfDLztMcOCEmjUdfSx/Nos?=
 =?iso-8859-1?Q?ddIKffEM3+Dd1QTUJOTXXEOoWrbCOQcIYoYTnrdvOBKomXDgpwfCXTtaPp?=
 =?iso-8859-1?Q?kntDkEGp/huaaX2qnOCsEqWuqK/ewhEiwtYP+cPhBDkOoYKn/idnEoNjsC?=
 =?iso-8859-1?Q?Hjy+TCFwjO+HN/T3xsh5wgXE1tfNCCUfsjaoUr8r1LjHXYBFPHoFkFXjdA?=
 =?iso-8859-1?Q?tG7wnMk5jO5OgQKXBYd9VbiD3EoMu517qEpqShLcJTcpahfnla5oW/7Fpw?=
 =?iso-8859-1?Q?T706lQizWWMiDFub+6tttiINDqHx1lEo5zd/wBkeEDBXw+bAulOs3SXqf9?=
 =?iso-8859-1?Q?sA/hTKpfUd9+ZIaaNNX9d+KzyYgXIXQIyTrbuaMhOrhX+OQMZZ/dsKPj3M?=
 =?iso-8859-1?Q?MKIyW282Tk73cvUevfjFzWpJrCD6pNm4JxDkzHxIQYSxfRdzIobwBDJdgR?=
 =?iso-8859-1?Q?ojzqSXucVyztzd611+8WWposr/HWKxtKAMcN7nArzAyzmBddNEM8EQAuhz?=
 =?iso-8859-1?Q?d1vKqIgR1j/kFpOAiwaXyohxtoWnH/DiU76xPO0wzddRZxcL4cA20zWT6O?=
 =?iso-8859-1?Q?tkiNlUDHpVaAnxva1qO07WHXk5q8BkQdUFfjqeey7n3pe7Uu6E0PjrIvbV?=
 =?iso-8859-1?Q?kIIElYnty6d1eKiK81JnOzpdFgnx08H6hQw+4OO+grqedw0gZ92aPS3g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a79fc9-c0dc-4c86-c063-08db997cc42e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 08:35:35.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAwD1saR8eMhHwTjWGr3dYT2lujy9eaLhZ7nacbcN3MXoA6bOJQkwu83qjqKeHarcdLnEPA3Xq6omswkvAvQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
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

kernel test robot noticed a -8.4% regression of stress-ng.getdent.ops_per_sec on:


commit: 27152bceea1df27ffebb12ac9cd9adbf2c4c3f35 ("eventfs: Move tracing/events to eventfs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: getdent
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308101425.8416d10d-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230810/202308101425.8416d10d-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/getdent/stress-ng/60s

commit: 
  5bdcd5f533 ("eventfs: Implement removal of meta data from eventfs")
  27152bceea ("eventfs: Move tracing/events to eventfs")

5bdcd5f5331a276a 27152bceea1df27ffebb12ac9cd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8.61            +1.5%       8.74        iostat.cpu.system
    379.67 ± 11%     +34.2%     509.50 ± 13%  perf-c2c.HITM.remote
  15882418 ±  7%     -14.5%   13581053 ± 10%  numa-numastat.node1.local_node
  15926621 ±  7%     -14.5%   13610475 ± 10%  numa-numastat.node1.numa_hit
  15926831 ±  7%     -14.5%   13610636 ± 10%  numa-vmstat.node1.numa_hit
  15882627 ±  7%     -14.5%   13581214 ± 10%  numa-vmstat.node1.numa_local
  38443696            -8.4%   35207563        stress-ng.getdent.ops
    640728            -8.4%     586792        stress-ng.getdent.ops_per_sec
  26234871            -8.6%   23974680        stress-ng.time.minor_page_faults
     41306            +2.2%      42218        proc-vmstat.nr_slab_unreclaimable
  29828360            -8.6%   27268832        proc-vmstat.numa_hit
  29762067            -8.6%   27201349        proc-vmstat.numa_local
  31109897 ±  2%      -9.2%   28250839 ±  2%  proc-vmstat.pgalloc_normal
  26551020            -8.5%   24287915        proc-vmstat.pgfault
  31026942 ±  2%      -9.2%   28164597 ±  2%  proc-vmstat.pgfree
     12911 ± 13%      -9.9%      11638        proc-vmstat.pgreuse
 3.097e+09            -4.2%  2.967e+09        perf-stat.i.branch-instructions
      0.74            +0.0        0.77        perf-stat.i.branch-miss-rate%
 1.581e+08            -2.6%  1.541e+08        perf-stat.i.cache-references
      1.50            +5.2%       1.58        perf-stat.i.cpi
   1067449 ±  2%      -6.7%     995871 ±  2%  perf-stat.i.dTLB-load-misses
 3.831e+09            -4.7%  3.652e+09        perf-stat.i.dTLB-loads
      0.14            -0.0        0.14        perf-stat.i.dTLB-store-miss-rate%
   3287323            -8.6%    3005920        perf-stat.i.dTLB-store-misses
 2.256e+09            -6.3%  2.115e+09        perf-stat.i.dTLB-stores
 1.484e+10            -4.4%  1.419e+10        perf-stat.i.instructions
      0.68            -3.4%       0.66        perf-stat.i.ipc
    145.93            -4.9%     138.83        perf-stat.i.metric.M/sec
    422840            -8.5%     386712        perf-stat.i.minor-faults
   7303977            +5.8%    7728544        perf-stat.i.node-load-misses
     76.90 ±  2%      -5.5       71.36 ±  4%  perf-stat.i.node-store-miss-rate%
   6875532            -3.1%    6661427        perf-stat.i.node-store-misses
    422840            -8.5%     386712        perf-stat.i.page-faults
      0.74            +0.0        0.78        perf-stat.overall.branch-miss-rate%
     28.72 ±  2%      +1.5       30.24 ±  2%  perf-stat.overall.cache-miss-rate%
      1.49            +5.2%       1.57        perf-stat.overall.cpi
      0.15            -0.0        0.14        perf-stat.overall.dTLB-store-miss-rate%
      0.67            -4.9%       0.64        perf-stat.overall.ipc
     78.18 ±  2%      -5.2       72.99 ±  4%  perf-stat.overall.node-store-miss-rate%
 3.047e+09            -4.2%  2.919e+09        perf-stat.ps.branch-instructions
 1.556e+08            -2.6%  1.516e+08        perf-stat.ps.cache-references
   1050526 ±  2%      -6.7%     979856 ±  2%  perf-stat.ps.dTLB-load-misses
  3.77e+09            -4.7%  3.594e+09        perf-stat.ps.dTLB-loads
   3235246            -8.6%    2957606        perf-stat.ps.dTLB-store-misses
  2.22e+09            -6.3%  2.081e+09        perf-stat.ps.dTLB-stores
  1.46e+10            -4.4%  1.396e+10        perf-stat.ps.instructions
    416143            -8.6%     380496        perf-stat.ps.minor-faults
   7187567            +5.8%    7604602        perf-stat.ps.node-load-misses
   6766067            -3.1%    6554471        perf-stat.ps.node-store-misses
    416143            -8.6%     380496        perf-stat.ps.page-faults
 9.202e+11            -4.5%  8.784e+11        perf-stat.total.instructions
     45.38            -3.9       41.44        perf-profile.calltrace.cycles-pp.syscall
     44.32            -3.9       40.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     44.13            -3.9       40.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     22.21            -1.9       20.27        perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     21.62            -1.9       19.69        perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     21.60            -1.9       19.68        perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     13.82 ±  3%      -1.9       11.91 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     21.14            -1.9       19.24        perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      5.33 ±  6%      -0.9        4.40 ±  6%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      3.71 ±  7%      -0.7        2.98 ±  7%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      6.19 ±  2%      -0.6        5.63 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      4.50 ±  2%      -0.5        4.00 ±  4%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      4.42 ±  2%      -0.4        3.98 ±  2%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      4.48 ±  2%      -0.4        4.05 ±  2%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.50 ±  2%      -0.4        4.08 ±  3%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.41 ±  2%      -0.4        4.00 ±  3%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      7.10            -0.4        6.70 ±  2%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.85 ±  9%      -0.3        1.52 ± 10%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      1.57 ±  6%      -0.3        1.23 ±  6%  perf-profile.calltrace.cycles-pp.up_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.96 ±  6%      -0.3        0.64 ± 15%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.36 ±  5%      -0.3        1.08 ±  5%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.95 ±  4%      -0.3        1.68 ±  6%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      1.32 ±  4%      -0.3        1.05 ± 12%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ±  4%      -0.3        0.67 ± 12%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      2.82 ±  3%      -0.3        2.55 ±  2%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.32 ±  3%      -0.3        1.06 ± 11%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  6%      -0.3        0.50 ± 44%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      2.35 ±  2%      -0.2        2.12        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
      2.62 ±  2%      -0.2        2.41 ±  4%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.56 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.38 ±  5%      -0.2        1.17 ±  6%  perf-profile.calltrace.cycles-pp.down_read.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      2.06 ±  2%      -0.2        1.86        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
      2.44 ±  2%      -0.2        2.26 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.34            -0.2        2.17 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.02 ±  2%      -0.1        1.87 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.24 ±  2%      -0.1        1.10 ±  2%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      1.28 ±  2%      -0.1        1.16 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pident_readdir
      1.52 ±  2%      -0.1        1.40 ±  2%  perf-profile.calltrace.cycles-pp.proc_readdir_de.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10 ±  3%      -0.1        0.99 ±  5%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      0.90 ±  3%      -0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.68            -0.1        0.57 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.iterate_dir.__x64_sys_getdents.do_syscall_64
      1.58 ±  3%      -0.1        1.48 ±  6%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71            -0.1        0.61 ±  6%  perf-profile.calltrace.cycles-pp.security_file_permission.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  5%      -0.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.14 ±  3%      -0.1        1.06 ±  5%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
      0.74 ±  5%      -0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.exit_to_user_mode_loop
      0.61 ±  4%      -0.1        0.55        perf-profile.calltrace.cycles-pp._raw_read_lock.proc_readdir_de.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.60 ±  2%      -0.1        0.54 ±  5%  perf-profile.calltrace.cycles-pp._raw_read_lock.proc_readdir_de.iterate_dir.__x64_sys_getdents.do_syscall_64
      0.63 ±  3%      -0.1        0.58 ±  5%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.66            -0.1        0.60 ±  6%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault
      0.00            +1.5        1.50 ± 18%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.create_dentry.dcache_dir_open_wrapper.do_dentry_open
      0.00            +2.1        2.14 ± 16%  perf-profile.calltrace.cycles-pp.__mutex_lock.create_dentry.dcache_dir_open_wrapper.do_dentry_open.do_open
      0.00            +2.4        2.41 ± 17%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.eventfs_release.__fput.task_work_run
      0.00            +2.8        2.76 ± 14%  perf-profile.calltrace.cycles-pp.create_dentry.dcache_dir_open_wrapper.do_dentry_open.do_open.path_openat
      3.66            +3.1        6.75 ±  5%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.45 ±  2%      +3.2        5.69 ±  6%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.4        3.35 ± 13%  perf-profile.calltrace.cycles-pp.dcache_dir_open_wrapper.do_dentry_open.do_open.path_openat.do_filp_open
      0.00            +3.4        3.36 ± 17%  perf-profile.calltrace.cycles-pp.__mutex_lock.eventfs_release.__fput.task_work_run.exit_to_user_mode_loop
      6.22            +4.0       10.27 ±  5%  perf-profile.calltrace.cycles-pp.__close
      5.87            +4.1        9.94 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      5.82            +4.1        9.88 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.80            +4.1        8.93 ±  7%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.85            +4.1        8.98 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.82            +4.1        8.96 ±  7%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.65            +4.1        8.79 ±  7%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.16 ±  2%      +4.2        8.32 ±  7%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +4.4        4.41 ± 15%  perf-profile.calltrace.cycles-pp.eventfs_release.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
     45.79            -4.0       41.83        perf-profile.children.cycles-pp.syscall
     42.82            -3.8       38.98        perf-profile.children.cycles-pp.iterate_dir
     22.24            -1.9       20.30        perf-profile.children.cycles-pp.__x64_sys_getdents
     21.62            -1.9       19.70        perf-profile.children.cycles-pp.__x64_sys_getdents64
     13.87 ±  3%      -1.9       11.95 ±  3%  perf-profile.children.cycles-pp.link_path_walk
     11.85 ±  4%      -1.3       10.53 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
     11.98 ±  2%      -1.1       10.86 ±  2%  perf-profile.children.cycles-pp.proc_readdir_de
      6.13 ±  6%      -1.0        5.10 ±  6%  perf-profile.children.cycles-pp.inode_permission
      5.63 ± 10%      -1.0        4.62 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.98 ±  2%      -0.8        8.13 ±  2%  perf-profile.children.cycles-pp.proc_tgid_net_readdir
      4.32 ±  7%      -0.8        3.50 ±  7%  perf-profile.children.cycles-pp.kernfs_iop_permission
      6.58 ±  2%      -0.7        5.92 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      1.91 ±  5%      -0.6        1.32 ± 13%  perf-profile.children.cycles-pp.scan_positives
      6.23 ±  2%      -0.6        5.66 ±  2%  perf-profile.children.cycles-pp.walk_component
      2.65 ±  3%      -0.5        2.12 ± 11%  perf-profile.children.cycles-pp.dcache_readdir
      2.72 ±  4%      -0.5        2.19 ±  5%  perf-profile.children.cycles-pp.lockref_put_or_lock
      7.41            -0.5        6.93 ±  2%  perf-profile.children.cycles-pp.dput
      7.12            -0.4        6.71 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      4.04 ±  3%      -0.4        3.66 ±  2%  perf-profile.children.cycles-pp._raw_read_lock
      1.78 ±  5%      -0.4        1.40 ±  5%  perf-profile.children.cycles-pp.step_into
      2.49 ±  3%      -0.3        2.15 ±  6%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      2.64            -0.2        2.42 ±  4%  perf-profile.children.cycles-pp.alloc_empty_file
      2.46 ±  2%      -0.2        2.28 ±  5%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.37            -0.2        2.20 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
      2.66 ±  2%      -0.2        2.50 ±  2%  perf-profile.children.cycles-pp.dentry_kill
      1.28            -0.2        1.12 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      1.20            -0.1        1.06 ±  6%  perf-profile.children.cycles-pp.apparmor_file_permission
      1.27 ±  2%      -0.1        1.13 ±  2%  perf-profile.children.cycles-pp.evict
      1.54 ±  2%      -0.1        1.41 ±  3%  perf-profile.children.cycles-pp.filldir64
      0.90 ± 12%      -0.1        0.78 ±  3%  perf-profile.children.cycles-pp.lockref_get_not_dead
      1.01 ± 11%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.__legitimize_path
      0.99 ± 11%      -0.1        0.88 ±  2%  perf-profile.children.cycles-pp.try_to_unlazy
      1.11 ±  3%      -0.1        1.00 ±  4%  perf-profile.children.cycles-pp.security_file_alloc
      2.24 ±  2%      -0.1        2.13        perf-profile.children.cycles-pp.__dentry_kill
      0.91 ±  3%      -0.1        0.80 ±  5%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.58 ±  3%      -0.1        1.48 ±  6%  perf-profile.children.cycles-pp.unmap_region
      0.77 ±  5%      -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.security_file_free
      0.75 ±  5%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.33 ±  7%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__traverse_mounts
      0.43 ±  6%      -0.1        0.36 ±  6%  perf-profile.children.cycles-pp.generic_permission
      0.60 ±  5%      -0.1        0.54 ±  4%  perf-profile.children.cycles-pp.pde_put
      0.96            -0.1        0.90 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.56 ±  4%      -0.1        0.51 ±  7%  perf-profile.children.cycles-pp.strncpy_from_user
      0.64 ±  3%      -0.1        0.59 ±  4%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.42 ±  8%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.strlcat
      0.42 ±  5%      -0.1        0.37 ±  8%  perf-profile.children.cycles-pp.zap_pte_range
      0.43 ±  4%      -0.0        0.38 ±  8%  perf-profile.children.cycles-pp.zap_pmd_range
      0.44 ±  5%      -0.0        0.40 ±  6%  perf-profile.children.cycles-pp.unmap_page_range
      0.33 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.proc_evict_inode
      0.14 ±  4%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.set_nlink
      0.23 ±  6%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.26 ±  4%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.get_proc_task_net
      0.10 ±  8%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.proc_match
      0.30 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.stress_time_now
      0.13 ±  5%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.08 ±  9%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.get_partial_node
      0.25 ± 10%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.60 ±  2%      +0.1        0.67 ±  4%  perf-profile.children.cycles-pp.__call_rcu_common
      0.16 ± 12%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.dcache_dir_close
      1.26 ±  2%      +0.2        1.44 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      0.00            +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.osq_unlock
      0.45 ±  4%      +0.3        0.76 ±  2%  perf-profile.children.cycles-pp.lockref_get
      0.00            +0.6        0.63 ± 14%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.32 ±  8%      +0.8        1.13 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.14 ±  6%      +1.0        1.09 ± 11%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +2.8        2.77 ± 14%  perf-profile.children.cycles-pp.create_dentry
      3.67            +3.1        6.77 ±  5%  perf-profile.children.cycles-pp.do_open
      2.48 ±  3%      +3.2        5.72 ±  6%  perf-profile.children.cycles-pp.do_dentry_open
      0.00            +3.4        3.36 ± 13%  perf-profile.children.cycles-pp.dcache_dir_open_wrapper
      0.00            +3.9        3.92 ± 17%  perf-profile.children.cycles-pp.osq_lock
      6.34            +4.0       10.38 ±  5%  perf-profile.children.cycles-pp.__close
      5.09            +4.1        9.19 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.94            +4.1        9.06 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      4.83            +4.1        8.96 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      4.68            +4.1        8.82 ±  7%  perf-profile.children.cycles-pp.task_work_run
      4.19 ±  2%      +4.2        8.35 ±  7%  perf-profile.children.cycles-pp.__fput
      0.00            +4.4        4.42 ± 14%  perf-profile.children.cycles-pp.eventfs_release
      0.00            +5.5        5.51 ± 16%  perf-profile.children.cycles-pp.__mutex_lock
      5.48 ± 10%      -1.0        4.48 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.30 ±  3%      -0.6        4.74 ±  2%  perf-profile.self.cycles-pp.proc_readdir_de
      3.89 ±  3%      -0.4        3.52 ±  2%  perf-profile.self.cycles-pp._raw_read_lock
      1.62 ±  4%      -0.4        1.27 ±  7%  perf-profile.self.cycles-pp.lockref_put_or_lock
      1.02 ±  3%      -0.1        0.87 ±  6%  perf-profile.self.cycles-pp.inode_permission
      1.10            -0.1        0.96 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      1.24            -0.1        1.14 ±  3%  perf-profile.self.cycles-pp.filldir64
      0.86 ±  3%      -0.1        0.76 ±  5%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.10 ±  3%      -0.1        1.01 ±  5%  perf-profile.self.cycles-pp.apparmor_file_open
      0.72 ±  4%      -0.1        0.64 ±  4%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.57 ±  5%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp.pde_put
      0.35 ±  9%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp.generic_permission
      0.44 ±  6%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.link_path_walk
      0.51 ±  7%      -0.1        0.45 ±  6%  perf-profile.self.cycles-pp.do_dentry_open
      0.42 ±  3%      -0.1        0.36 ±  6%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.40 ±  7%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.strlcat
      0.44 ±  6%      -0.0        0.40 ±  3%  perf-profile.self.cycles-pp.proc_lookup_de
      0.13 ±  6%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.set_nlink
      0.26 ±  4%      -0.0        0.23 ±  5%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.14 ±  6%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.get_proc_task_net
      0.11 ±  6%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__x64_sys_getdents
      0.12 ±  4%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.do_anonymous_page
      0.13 ±  4%      +0.0        0.17 ±  8%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.28 ±  9%      +0.1        0.36 ± 12%  perf-profile.self.cycles-pp.dcache_readdir
      1.23 ±  3%      +0.2        1.40 ±  4%  perf-profile.self.cycles-pp.lockref_put_return
      0.00            +0.2        0.20 ± 14%  perf-profile.self.cycles-pp.osq_unlock
      0.40 ±  3%      +0.3        0.71 ±  2%  perf-profile.self.cycles-pp.lockref_get
      0.00            +0.6        0.62 ± 15%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.8        0.76 ± 16%  perf-profile.self.cycles-pp.__mutex_lock
      0.24 ± 10%      +0.8        1.00 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.13 ±  7%      +0.9        1.06 ± 11%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +3.9        3.90 ± 17%  perf-profile.self.cycles-pp.osq_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

