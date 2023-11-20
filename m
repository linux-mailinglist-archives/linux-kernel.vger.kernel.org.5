Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE67F1427
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjKTNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:16:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14283112
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700486206; x=1732022206;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=VBFhEkAX+Z/+sntifJozf5FuE6M8LXM3X7zVAMS+qWk=;
  b=PySdXqOYvcvvNCsEQPhEhIbWs9VAyK5r5PGvhZp205ZszUX58tMwkEjo
   LZjuDRapb1bkMxzIXEH7lCSQcLHPaDVvbh63o+r5xclhBrogLp0P3OiDS
   /fjiJdXrRsne+Mb/c4YaZwD3CnnIntIa0PoRTOtWeGXmxrsBAtT/VUkSn
   p3BD0RLYe59jsmJOoX/bVfOEWpXpkmrt6+BL+O9pyhi827/kdeZAiij/L
   F6XrE4LQXwwZ3Weqe0/qHbJC3/gmR6PU7k4Qe7oreRmdnmynPeuOvKHk8
   hDRNDS6vVpn1CjBiufhvM7U7GkKSCNiLEiQZby0CpCd0Xpr8LseUTbetT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="395543346"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="395543346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="883850894"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="883850894"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 05:16:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 05:16:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 05:16:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 05:16:42 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 05:16:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsiaRhb/QUHr4ugPncAciLKVdXXFdnl46NMhNF1LxJ+p4ystxN1CM8uWIr8n1CgxthUMuixfOs5W+KL68CUH+jiU4de7ObhlN2D1YQWNMdIXVTuzxKVil2OvryH02XODUhFkiYPqvwDBT8OkXh5z7VqydGSmO5STbaN40geVBEJL7GB2k2dATk86bLldESCOtWUipCBDWekztgt5ZrhtIy7aNWUb8m8fZF7ndIjydbAxdtYWIWy7hjhyC57PdDxV6rgvaixXl1zwMc6w6P017Hx4j+Iqv28iOl8P48yQZYjmhUaR2FDnuGepg1xi/2XxNrQHzKa21jrXzrcKTFitEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRnr1gzK2E5sO0JM7uBywEERQ7zT2pKoncoAm8rz/TQ=;
 b=fTSVuX0kG5996ssehxn7FraVW5EnI3V35z1b/sx8qJFMiw7Ew0M5WRDywNVVmYCo3lIZSAD/MhQBoPC4tq3koiHWbO7wJmox1uaox47LaXuRDyhEW3Kp2nVWBE2PgSipyeV2mgn+7n0ocTZOhoWP+G4+YTqE6X1erRlQkZZgYjXQLmOCKhY5ZLC2VeJAidRZ1n+KsaN7xHcD0e02r+xoXaaD9ppLceml86PaA4OkUt7rmND937I7XSUg7N5ZnWBa+dJMPobk5jfk4Db/xoA1LkbK7E8yjz7oMRXUBUc2JDEb6J3oa1NL+4qqJP1v5QKZ3qPJLHwA8zyf/v7YwoyZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 13:16:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 13:16:39 +0000
Date:   Mon, 20 Nov 2023 21:16:24 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm, page_alloc]  c0a242394c:
 will-it-scale.per_process_ops 12.6% improvement
Message-ID: <202311201629.b861c327-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 8215dc93-59d0-47e6-3790-08dbe9caec9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJHQx8PXtKwo0SwJZsOIjlLl+dd6acVBouC5gMD2JO0gc1lZv0vTG1ZSTNhFnwEvlQkdayquNtSzkZCEjWuEfBArYagmhFA9OS9YcWHjtq/7VaH+p4ggquVuWMDXMzEJtY0hZCpNSbtCIGP0h2MVovrOFxU6zoLAfXcOL2G5r/FEcs1Njudlb45qKtlW9pSEJhi3w+cZn0forVG01ToaUEUNcLeUlqkHe0izhizjDRDaXlS5qPQaKYsMOkCsagb6qfJ658J3lvmrqQdhT02cMZncYHM0YlGGzY3T9vScqnKW+rJXou2PMoVKFXgtMZqRj6r6G5VFs8X6cyMG+iBKVLmHtW6IeFCFQKd6NBPl/rtz9SSfunC6fPaKI8IFJikvBnhxHJAG5F8ZnbrTWw2ubydN8zggFlEcEt0O1Lb1JvTR6+K4sL5TX01x2+CdgudbvQJGfs1EvdKttHetdxSX8wWTV8SJuF08IFA9KOlIlqHuv7Cqg7ETmCGxKy3y8KT9lWH7PXV6g96Grpp/iPcH5eb/5f+E+Ax7uqg/ykif+PUTxjmOFIbv1l2/0rwjv2ibn98zO2z8taLW1w0xWJE/B0iGwS+1eypUw2NLfeVBZKXKFIuun4Y5KX9rbwyLQ9MEVIc2famDuNjlKt5yadMadg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230473577357003)(230373577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(30864003)(2906002)(4326008)(6862004)(8676002)(8936002)(5660300002)(38100700002)(86362001)(7416002)(41300700001)(36756003)(2616005)(6512007)(1076003)(26005)(6666004)(6506007)(83380400001)(82960400001)(478600001)(66556008)(66946007)(66476007)(37006003)(54906003)(6636002)(316002)(966005)(19627235002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Wzetdddr4knMEhwV0i9utJvpOkl2Sl6wNHTWiTm756hGBqcEv6B9VWdA02?=
 =?iso-8859-1?Q?2wepE9Ah1qs+X+BzPirr3qALrjlcFJMxOVBFltwF6JfGFY3tvgWmXdq7mu?=
 =?iso-8859-1?Q?44+m7aBhl6qyjJc9jIubXRRvm1ZKagn9/2/Uyw0wzCI2y2GqRFh6F5srLt?=
 =?iso-8859-1?Q?GxOjjJU/zfjh3hyGXfd+0l4iVQDy0MRlcIFi8sYY0QuFVKLU6alPeDMlST?=
 =?iso-8859-1?Q?yMa8wQjXvyyHMLUe7j5Ft8vv6ssAzozrKioqWnb3CuOFjUoV2urMNgHYa1?=
 =?iso-8859-1?Q?Dc+ghL6GTX2g8c1ym5RZuNFR65CFBe4PHmKKRvS7z7XCTFW8eYbCHFBhxg?=
 =?iso-8859-1?Q?2lVDYPI5JnE74LvmJY6NndBbcjAdTy/GEbxNaA9Az1rYuJ+puAEPC5b4MY?=
 =?iso-8859-1?Q?zxeHyOHs386rWL896/ZfJWhl1NBbfFu/dhkKnYuy1+VWQRVSa29CYSDN3k?=
 =?iso-8859-1?Q?GhHsS75P5m0P6nsSKqneHggKktquqg47lt1rwWE9ZOLNm73ztj0F3Avme7?=
 =?iso-8859-1?Q?0/cDFg0BCeJxabYLuOQP+rpyYqzxfrFKbeAJswoDZVHT5+BLnsaQWQFFkT?=
 =?iso-8859-1?Q?pVxavKVivrITwZ1T4/PdED5A/OYxJz0olZ/w7T7byUEModrMxSYo55dnU9?=
 =?iso-8859-1?Q?iNgRN9InZ7Kdp3oGeb9JJuMfoNxwWYFyBh156ixiflkVN8hkXH3I+pBd4t?=
 =?iso-8859-1?Q?Pm1sbaNe7xx40ZUxPIc4W6oMjLeJZGA7ONI9C8/od0ad97kili7MB7VNAy?=
 =?iso-8859-1?Q?Wffn1dzg8alkt4V8DBfB5t2XLEglVBLpxRaEXwTGJZ2Su7IIHsMNF2jSe1?=
 =?iso-8859-1?Q?N2oNMZGuiLYsxp/JMpyzWdQk+TLg0gyHMDl45pWCeUg3qgGZCy9JqA2yYk?=
 =?iso-8859-1?Q?VWzRdaUQn1Czx2qGlzBl44nUbluunKmwqrlYKrqTrWnZQcFUSQk3HSM5Qw?=
 =?iso-8859-1?Q?mQfINN5YppQqMDMYVYAG684YrdyCTtO1XVXnC6CGC+VHKlGe2RQfAYnekC?=
 =?iso-8859-1?Q?dcVX3UmWXqfQu+cLTlGWd0KQ/OcMbzLAZbCZxQaeYa/hzBMKdoM83KIXPM?=
 =?iso-8859-1?Q?Hh3zwbQ5igWnK2QRB2DBH5yFyzNq1qqbzkRCg7Gdq1J7tBK01tIrabr0J+?=
 =?iso-8859-1?Q?uDTQVzjgfcpndBIkoXwQTFmQeRevZikVT9peNiK7ZW0iRgr9QQ7k12rIj2?=
 =?iso-8859-1?Q?+FAw1zbC1uECfp22IYkuN4UttsJiV/ENRrGDqf3ucaWyaRNGZBj9ULsCHL?=
 =?iso-8859-1?Q?JoLWEOtTVFRp8exz/LQXSuko/glHS6tsWnfD1dLq7KZ2yP80GTgRvUmIh0?=
 =?iso-8859-1?Q?ppT+ddIG/dCfxVgsZ7wPQ5/4AWjfIyhFRCVrGWAz1bwq27VtODp4PvttzM?=
 =?iso-8859-1?Q?uthf455bw1hGlcSsUstEA6Bu5enPgh4Y4HTXyjO0ff0pwfzYtIkluJInvz?=
 =?iso-8859-1?Q?qApGSt5B1wMqYf+LpadrRl8L9oPRu1ffOHtFjZFAGDMpL3SkQktAGW8CQx?=
 =?iso-8859-1?Q?WOe5zdhGU1BU9vDT+P3xoaz/6WHg91+7MtHAjvvOKCbXB0n2Xi9RLW4wEN?=
 =?iso-8859-1?Q?ZvlL3+7OLimDkilHb5D66UdXG7Lo8f59hM98pPeGlnl8n+96yHj8/CE0wa?=
 =?iso-8859-1?Q?K3GZiEEtdc10JDapNn6PJJRHTu0tx4MLmiPxDSAIVu1Wq8RKKdgP4yjQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8215dc93-59d0-47e6-3790-08dbe9caec9c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:16:37.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyFDR4rNFVgapts4UhdBPfPELe+zu6WM4Wa3Bs40QpD2Nghz4r9fUUJTkSpfK/zDEK9oHFw9XEkCQEVSCt1Cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 12.6% improvement of will-it-scale.per_process_ops on:


commit: c0a242394cb980bd00e1f61dc8aacb453d2bbe6a ("mm, page_alloc: scale the number of pages that are batch allocated")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 50%
	mode: process
	test: page_fault2
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231120/202311201629.b861c327-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  52166607ec ("mm: restrict the pcp batch scale factor to avoid too long latency")
  c0a242394c ("mm, page_alloc: scale the number of pages that are batch allocated")

52166607ecc98039 c0a242394cb980bd00e1f61dc8a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.90            +0.6        5.49        mpstat.cpu.all.usr%
      1367 ±  6%     +72.8%       2362 ±  4%  perf-c2c.HITM.local
   8592059           +12.6%    9677986        will-it-scale.52.processes
    165231           +12.6%     186114        will-it-scale.per_process_ops
   8592059           +12.6%    9677986        will-it-scale.workload
      2592 ± 19%    +587.0%      17809 ± 97%  numa-meminfo.node0.Active(anon)
   3494860 ±  2%     -22.6%    2703947        numa-meminfo.node0.AnonPages.max
   3538966 ±  2%     -24.9%    2657708 ±  7%  numa-meminfo.node1.AnonPages.max
      9310 ±  3%      +7.6%      10019 ±  5%  numa-meminfo.node1.KernelStack
 1.295e+09           +12.8%   1.46e+09        numa-numastat.node0.local_node
 1.294e+09           +12.8%   1.46e+09        numa-numastat.node0.numa_hit
  1.31e+09           +12.0%  1.467e+09        numa-numastat.node1.local_node
 1.309e+09           +12.0%  1.466e+09        numa-numastat.node1.numa_hit
    213394 ± 50%    +373.5%    1010435 ± 33%  sched_debug.cfs_rq:/.avg_vruntime.min
   1932637 ±  4%     -32.0%    1313931 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    213394 ± 50%    +373.5%    1010435 ± 33%  sched_debug.cfs_rq:/.min_vruntime.min
   1932637 ±  4%     -32.0%    1313931 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.08           +12.5%       0.09        turbostat.IPC
     63.77           -45.2       18.60 ± 22%  turbostat.PKG_%
    353.10            +2.9%     363.42        turbostat.PkgWatt
     68.28           +11.4%      76.03        turbostat.RAMWatt
    833540            +5.6%     880188        proc-vmstat.nr_anon_pages
 2.603e+09           +12.4%  2.925e+09        proc-vmstat.numa_hit
 2.605e+09           +12.4%  2.927e+09        proc-vmstat.numa_local
 2.599e+09           +12.4%   2.92e+09        proc-vmstat.pgalloc_normal
 2.591e+09           +12.4%  2.911e+09        proc-vmstat.pgfault
 2.599e+09           +12.4%   2.92e+09        proc-vmstat.pgfree
    648.18 ± 19%    +586.7%       4450 ± 97%  numa-vmstat.node0.nr_active_anon
    648.18 ± 19%    +586.7%       4450 ± 97%  numa-vmstat.node0.nr_zone_active_anon
 1.294e+09           +12.8%   1.46e+09        numa-vmstat.node0.numa_hit
 1.295e+09           +12.8%   1.46e+09        numa-vmstat.node0.numa_local
      9310 ±  3%      +7.6%      10021 ±  5%  numa-vmstat.node1.nr_kernel_stack
 1.309e+09           +12.0%  1.466e+09        numa-vmstat.node1.numa_hit
  1.31e+09           +12.0%  1.467e+09        numa-vmstat.node1.numa_local
      0.01 ± 80%     -93.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ±  9%     -46.3%       0.02 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±107%     -97.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  7%     -15.0%       0.02 ± 10%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.94 ± 16%     -51.9%       0.45 ± 22%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     98.83 ± 11%     -40.5%      58.83 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_cow_fault
    232.00 ± 10%     +48.4%     344.33 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     39.50 ± 54%     -87.3%       5.03        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.99 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      4.81 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     33.32 ± 69%     -85.0%       5.01        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     16.82            +1.6%      17.09        perf-stat.i.MPKI
   8.6e+09           +11.3%  9.573e+09        perf-stat.i.branch-instructions
  39148476            +5.6%   41324228        perf-stat.i.branch-misses
     81.02            -3.1       77.94        perf-stat.i.cache-miss-rate%
 7.134e+08           +13.5%  8.096e+08        perf-stat.i.cache-misses
 8.802e+08           +17.7%  1.036e+09        perf-stat.i.cache-references
      1813            +1.2%       1834        perf-stat.i.context-switches
      3.43            -9.9%       3.09        perf-stat.i.cpi
    204.33           -10.7%     182.42 ±  2%  perf-stat.i.cycles-between-cache-misses
  10135544           +11.8%   11330409 ±  2%  perf-stat.i.dTLB-load-misses
  1.06e+10           +11.5%  1.182e+10        perf-stat.i.dTLB-loads
  70683663           +12.6%   79603765        perf-stat.i.dTLB-store-misses
 6.001e+09           +12.8%  6.766e+09        perf-stat.i.dTLB-stores
   9753929           +12.9%   11015762        perf-stat.i.iTLB-load-misses
  4.24e+10           +11.5%  4.728e+10        perf-stat.i.instructions
      4377            -1.5%       4312        perf-stat.i.instructions-per-iTLB-miss
      0.29           +11.5%       0.33        perf-stat.i.ipc
      0.34 ± 23%     -48.0%       0.18 ± 11%  perf-stat.i.major-faults
      1343           +17.4%       1577        perf-stat.i.metric.K/sec
    253.10           +11.9%     283.16        perf-stat.i.metric.M/sec
   8585112           +12.0%    9619126        perf-stat.i.minor-faults
      0.32 ± 27%      +0.3        0.60 ± 53%  perf-stat.i.node-load-miss-rate%
    694018           +17.3%     813810 ±  3%  perf-stat.i.node-load-misses
 2.451e+08            +3.6%  2.539e+08 ±  2%  perf-stat.i.node-loads
    538019           +14.0%     613240        perf-stat.i.node-store-misses
  49463410           +25.2%   61905404        perf-stat.i.node-stores
   8585112           +12.0%    9619126        perf-stat.i.page-faults
     16.83            +1.7%      17.12        perf-stat.overall.MPKI
      0.46            -0.0        0.43        perf-stat.overall.branch-miss-rate%
     81.06            -2.9       78.18        perf-stat.overall.cache-miss-rate%
      3.42           -10.5%       3.07        perf-stat.overall.cpi
    203.46           -12.0%     179.07        perf-stat.overall.cycles-between-cache-misses
      4347            -1.3%       4291        perf-stat.overall.instructions-per-iTLB-miss
      0.29           +11.7%       0.33        perf-stat.overall.ipc
      0.28            +0.0        0.32        perf-stat.overall.node-load-miss-rate%
      1.08            -0.1        0.98 ±  2%  perf-stat.overall.node-store-miss-rate%
 8.572e+09           +11.3%  9.542e+09        perf-stat.ps.branch-instructions
  39013363            +5.6%   41189792        perf-stat.ps.branch-misses
 7.111e+08           +13.5%   8.07e+08        perf-stat.ps.cache-misses
 8.773e+08           +17.7%  1.032e+09        perf-stat.ps.cache-references
      1805            +1.2%       1826        perf-stat.ps.context-switches
  10101169           +11.8%   11293042 ±  2%  perf-stat.ps.dTLB-load-misses
 1.056e+10           +11.6%  1.179e+10        perf-stat.ps.dTLB-loads
  70446051           +12.6%   79343784        perf-stat.ps.dTLB-store-misses
 5.981e+09           +12.8%  6.744e+09        perf-stat.ps.dTLB-stores
   9719620           +13.0%   10983217        perf-stat.ps.iTLB-load-misses
 4.225e+10           +11.5%  4.713e+10        perf-stat.ps.instructions
      0.34 ± 22%     -48.1%       0.18 ± 11%  perf-stat.ps.major-faults
   8556237           +12.1%    9587784        perf-stat.ps.minor-faults
    691779           +17.3%     811254 ±  3%  perf-stat.ps.node-load-misses
 2.442e+08            +3.6%  2.531e+08 ±  2%  perf-stat.ps.node-loads
    536237           +14.0%     611234        perf-stat.ps.node-store-misses
  49302195           +25.2%   61706509        perf-stat.ps.node-stores
   8556237           +12.1%    9587784        perf-stat.ps.page-faults
 1.277e+13           +11.9%   1.43e+13        perf-stat.total.instructions
     23.92           -10.1       13.79        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.__munmap
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     23.92           -10.1       13.80        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     19.93            -9.8       10.12        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range
     20.07            -9.7       10.33        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     10.10            -9.3        0.84 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_list.release_pages
     10.10            -9.3        0.84 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush
     21.64            -9.2       12.46        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     21.66            -9.2       12.48        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     21.66            -9.2       12.48        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
     21.66            -9.2       12.48        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      9.06            -7.1        1.99 ±  2%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush.zap_pte_range
      9.58            -7.0        2.54 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      6.28 ±  2%      -6.3        0.00        perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
      6.67            -3.5        3.16 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
      6.90            -3.5        3.40 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
      7.28            -3.5        3.83 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault
      7.34            -3.4        3.90 ±  3%  perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault
      7.81            -3.4        4.41 ±  3%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      9.46            -2.9        6.54 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.zap_pte_range
      9.46            -2.9        6.54 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      9.44            -2.1        7.34 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush
     13.41            -2.0       11.42        perf-profile.calltrace.cycles-pp.copy_page.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.25            -1.0        1.28 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      2.26            -1.0        1.30 ±  2%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.26            -1.0        1.30 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      4.23            -0.8        3.47        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_cow_fault.do_fault
      4.35            -0.7        3.60        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_cow_fault.do_fault.__handle_mm_fault
      1.05            +0.0        1.09        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_cow_fault.do_fault
      0.67            +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.25            +0.1        1.33        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_cow_fault.do_fault.__handle_mm_fault
      1.34            +0.1        1.44        perf-profile.calltrace.cycles-pp.__do_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.61 ±  7%      +0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_cow_fault
      1.06            +0.1        1.18        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.75 ±  6%      +0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_cow_fault.do_fault
      0.82            +0.2        1.00 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      2.72            +0.3        3.02        perf-profile.calltrace.cycles-pp.error_entry.testcase
      2.52 ±  2%      +0.3        2.83        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      2.77            +0.3        3.10        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      0.72 ±  2%      +0.3        1.06        perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush
      0.75            +0.4        1.12 ±  2%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.17 ±141%      +0.4        0.58        perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +1.6        1.61 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      0.00            +1.6        1.62 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +2.6        2.56 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      0.00            +2.9        2.90 ±  4%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
     32.25            +7.6       39.90        perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     32.34            +7.7       39.99        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     32.92            +7.7       40.65        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     33.76            +7.8       41.56        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     35.34            +8.0       43.29        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     35.47            +8.0       43.44        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     44.87            +9.1       53.97        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     48.05            +9.4       57.46        perf-profile.calltrace.cycles-pp.testcase
      8.27 ±  2%     +12.8       21.10 ±  2%  perf-profile.calltrace.cycles-pp.finish_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.35 ±  8%     +13.0       14.35 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      1.43 ±  7%     +13.0       14.43 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      1.42 ±  7%     +13.0       14.42 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
      2.77 ±  5%     +13.4       16.18 ±  3%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_cow_fault
      2.90 ±  5%     +13.4       16.32 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_cow_fault.do_fault
      3.85 ±  4%     +13.6       17.42 ±  3%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_cow_fault.do_fault.__handle_mm_fault
     22.33           -10.8       11.57        perf-profile.children.cycles-pp.release_pages
     22.33           -10.7       11.63        perf-profile.children.cycles-pp.tlb_batch_pages_flush
     23.93           -10.1       13.80        perf-profile.children.cycles-pp.do_vmi_align_munmap
     23.92           -10.1       13.80        perf-profile.children.cycles-pp.__munmap
     23.92           -10.1       13.80        perf-profile.children.cycles-pp.__vm_munmap
     23.92           -10.1       13.80        perf-profile.children.cycles-pp.__x64_sys_munmap
     23.92           -10.1       13.79        perf-profile.children.cycles-pp.unmap_region
     23.93           -10.1       13.80        perf-profile.children.cycles-pp.do_vmi_munmap
     24.00           -10.1       13.87        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.99           -10.1       13.87        perf-profile.children.cycles-pp.do_syscall_64
     21.66            -9.2       12.48        perf-profile.children.cycles-pp.unmap_vmas
     21.66            -9.2       12.48        perf-profile.children.cycles-pp.unmap_page_range
     21.66            -9.2       12.48        perf-profile.children.cycles-pp.zap_pmd_range
     21.66            -9.2       12.48        perf-profile.children.cycles-pp.zap_pte_range
     11.00            -8.8        2.24 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
     11.59            -8.7        2.88 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      6.30 ±  2%      -3.7        2.58 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      6.70            -3.5        3.19 ±  4%  perf-profile.children.cycles-pp.rmqueue
      6.94            -3.5        3.44 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      7.37            -3.4        3.92 ±  3%  perf-profile.children.cycles-pp.__folio_alloc
      7.36            -3.4        3.92 ±  3%  perf-profile.children.cycles-pp.__alloc_pages
      7.85            -3.4        4.45 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
     13.43            -2.0       11.44        perf-profile.children.cycles-pp.copy_page
     25.59            -1.2       24.37 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     25.50            -1.2       24.28 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.26            -1.0        1.30 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      4.26            -0.8        3.50        perf-profile.children.cycles-pp._raw_spin_lock
      4.35            -0.7        3.61        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.92            -0.5        1.43 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.put_page
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.10 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.09 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.11 ±  4%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.13 ±  5%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.13 ±  5%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.13 ±  5%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.18 ±  3%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.blk_cgroup_congested
      0.36            +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.14 ±  5%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
      0.22 ±  2%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      1.06            +0.0        1.11        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.37 ±  2%      +0.0        0.41        perf-profile.children.cycles-pp.__mod_node_page_state
      0.46            +0.0        0.51 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.67            +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.13 ±  2%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.12 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.free_swap_cache
      0.48 ±  4%      +0.1        0.55 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.25            +0.1        1.34        perf-profile.children.cycles-pp.shmem_fault
      0.49            +0.1        0.58        perf-profile.children.cycles-pp.page_remove_rmap
      1.35            +0.1        1.44        perf-profile.children.cycles-pp.__do_fault
      0.73 ±  3%      +0.1        0.82        perf-profile.children.cycles-pp.___perf_sw_event
      0.93 ±  2%      +0.1        1.04        perf-profile.children.cycles-pp.__perf_sw_event
      1.10            +0.1        1.22        perf-profile.children.cycles-pp.sync_regs
      0.22 ±  5%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.75 ±  6%      +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.85 ±  4%      +0.2        1.00 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      1.44            +0.2        1.61        perf-profile.children.cycles-pp.native_irq_return_iret
      0.84            +0.2        1.02 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      2.74            +0.3        3.04        perf-profile.children.cycles-pp.error_entry
      2.56 ±  2%      +0.3        2.87        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      2.77            +0.3        3.10        perf-profile.children.cycles-pp.__irqentry_text_end
      0.79            +0.4        1.17        perf-profile.children.cycles-pp._compound_head
      0.81 ±  2%      +0.4        1.21        perf-profile.children.cycles-pp.__free_one_page
      0.00            +2.9        2.92 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
     32.30            +7.6       39.94        perf-profile.children.cycles-pp.do_cow_fault
     32.34            +7.6       39.99        perf-profile.children.cycles-pp.do_fault
     32.93            +7.7       40.67        perf-profile.children.cycles-pp.__handle_mm_fault
     33.81            +7.8       41.61        perf-profile.children.cycles-pp.handle_mm_fault
     35.36            +8.0       43.32        perf-profile.children.cycles-pp.do_user_addr_fault
     35.49            +8.0       43.46        perf-profile.children.cycles-pp.exc_page_fault
     42.09            +8.8       50.86        perf-profile.children.cycles-pp.asm_exc_page_fault
     49.44            +9.6       59.04        perf-profile.children.cycles-pp.testcase
     11.03 ±  2%     +10.8       21.81 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      8.29 ±  2%     +12.8       21.12 ±  2%  perf-profile.children.cycles-pp.finish_fault
      2.78 ±  5%     +13.4       16.21 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      2.90 ±  5%     +13.4       16.33 ±  3%  perf-profile.children.cycles-pp.folio_add_lru_vma
      3.86 ±  4%     +13.6       17.43 ±  3%  perf-profile.children.cycles-pp.set_pte_range
     13.36            -2.0       11.38        perf-profile.self.cycles-pp.copy_page
     25.49            -1.2       24.28 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.24            -0.8        3.48        perf-profile.self.cycles-pp._raw_spin_lock
      1.92            -0.5        1.42 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.22 ±  4%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.10 ±  7%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.11            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.uncharge_folio
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.put_page
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.exc_page_fault
      0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.13            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.11 ±  4%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.blk_cgroup_congested
      0.11 ±  6%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.06 ± 11%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.handle_pte_fault
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.free_unref_page_list
      0.28 ±  3%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.27 ±  2%      +0.0        0.30        perf-profile.self.cycles-pp.page_remove_rmap
      0.20            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.shmem_fault
      0.24 ±  3%      +0.0        0.27        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.34            +0.0        0.38 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.35 ±  3%      +0.0        0.40        perf-profile.self.cycles-pp.__mod_node_page_state
      0.44 ±  2%      +0.1        0.49        perf-profile.self.cycles-pp.__handle_mm_fault
      0.38            +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.lru_add_fn
      0.40 ±  4%      +0.1        0.46 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.12 ±  3%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.free_swap_cache
      0.65 ±  2%      +0.1        0.72        perf-profile.self.cycles-pp.___perf_sw_event
      0.29 ± 12%      +0.1        0.37 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.29            +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      1.10            +0.1        1.22        perf-profile.self.cycles-pp.sync_regs
      0.21 ±  4%      +0.1        0.33 ±  6%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      1.44            +0.2        1.60        perf-profile.self.cycles-pp.native_irq_return_iret
      0.38 ±  7%      +0.2        0.55 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      2.73            +0.3        3.03        perf-profile.self.cycles-pp.error_entry
      2.47            +0.3        2.78        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      2.77            +0.3        3.10        perf-profile.self.cycles-pp.__irqentry_text_end
      0.78            +0.4        1.15        perf-profile.self.cycles-pp._compound_head
      3.17            +0.4        3.54        perf-profile.self.cycles-pp.testcase
      0.75 ±  2%      +0.4        1.15        perf-profile.self.cycles-pp.__free_one_page




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

