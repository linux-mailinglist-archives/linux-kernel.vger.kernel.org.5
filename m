Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF97EAAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKNHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:39:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72919E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699947563; x=1731483563;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=H0qVhaK8GdzVd+bVwEjCHjfI0M6yqU/HeFf9j84AlI4=;
  b=aOHnHwYBZvvfA6lGUaPUISYOIugQkW/JwP5rcVhXTq734WmkElYnK9T5
   tRlvodwxUZwpcYJNPPu+O+h78++K84D9aRcJgTynP5MgI5czu0/J4DKFm
   73ZPeZ45pvgAkuoLTh0tjlzWYSQMC0TzMq6qPFb3PXd2ufpibixvWLxOU
   kRX/9UxUmJNQ38OJsvXsgEG6c3l9zzZkTOcorlBm6LXkaBZAkCyhQvfTq
   wi0ZamqrrmCLp83K23G2w3/n+5Ae12CPkkmH5Cq2mU4CrcrAMKfHr8/Ev
   TUSTPbx59SHQ6aaCB2xgCDSXUdYSx2EtPTMFpwbKvhA4LqZSqF0hd6QFv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="457096639"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="457096639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834937658"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="834937658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 23:39:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:39:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 23:39:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 23:39:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdx4qy83/vDTgzF8YFVl4PuNJVliG/NPHq5Du6cB1DNN/yvB2ezjPE0icJLmwTzGpciMwNSDtazvPiDUR3hy/v30EJr3FsWPI4wOYrBxO1HkDOhMWWS7F0sgOxJRyk5Kj1yWK3HZ5axmenqEgJVlMHYbOujtLiD07YM/p747ntaPhV7n0T01QHaLqR1yFuJCFU/fdrsYrAsXWyAkZuWFEFLRR2zu/7myUYr2dWKDgT85d/EpP95KXGk2EPoXGJCBn/es2qosXL7C1nuQcRMrKqwGfn+sIVOtyHStm9nRbiBUMbe7SO13Vgkeu+BgivzP5FNX3+EDc33zweUxH1q3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhoq2ktyVLDvTIW7ykeBmBLEWlSSgdb59DG5SFU/LWg=;
 b=ogAq/NEdqWclujLRUF2i18Q1u6K5VnW/eiVBt/OLnQw/LUsGZGWyzzacKhgaZUJpp0f3ZhwjTCWfsmJV5YXCHsBI/BunRKnPibpZ9WS0gp7CUSUz27NdYvZilaapzhYzAsL7rAX+DI6xck8SvpNSBJAFBfFTfxKIrRwJYym/0jjoS3N7RCJmlzOmOpH90DJCjzglbF7qpo7BKqO6uQeTytwW86m2Wx4yv9hppxRQcWZSxmwX+k5qbPkjan6CwhzZIma+f32dAZJ/6kqvo2jlvp7OnLnGqO3o3yf2ZNxKGhmN74H/uYmUYSyJ4+VjEuJug9hGE0H/xVp7/yd7ZI7J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 07:39:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 07:39:04 +0000
Date:   Tue, 14 Nov 2023 15:38:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        <linux-mm@kvack.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [mm, pcp]  362d37a106:  netperf.Throughput_Mbps 14.5%
 improvement
Message-ID: <202311141422.64f32250-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7010d4-13c1-4950-2179-08dbe4e4c5ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXyRm4mE7OJTdUR/85PfjRlCT0bHWC1ppE1tF3D3V50cNx5P/if1X/iMI/Lco8QU2tdxRWN8PweN7E86PZPh/WPIDpgD19tiekbCJJG/8OBSM3E5OSSVlsy68MJxi/FDVQLdpF90AyIJyQZ/u0MtdyhbjkFSuH3NluPVdesTRihrxVMsIpqQGFN4qSCv9QjY13AG4YhOfE4VrTLh/jQu1ubPrjEwpCI7Xya/GXZNzQzINVM1bNm1LjcESQLzpEA6r2oMVBl9wfMx0PnqNtoR4o3wC4tP5MFM6+iPZzE9TPpMYVcsNMDywvsTH6bbWmdrYatqc+DaTCT51s2vW+NAHHUMbdq+DK0a3J5pGyhHlsmU+6N+963bo+97F90Lhy1aBejVjFfN22S7pmnaf3uIEHQewUrzusV9N7S1dc0+HFb3uClIMYnzRVOOcQu/Sg94dtL6wDCqOb99bjsBQnQcqngxMx/NznRSMP3VhKjMcr6NFsosPnjuBL3P6XzDCflVX2FN6jpRYecZuKo0pkYUCI1PfA1AySL0OmNRCMYb5o3NyeC+fRweQrp6VZZTfSHC1nkAhB3ybQvxjzbPGwk62U0MwlCwoCPwnhzg/hLknItn+IsWrU/t+BUQSuv4Dc0GB4YBThst6kYayQp14qPpoLLABfQ/liU/P/PsNAhqbfOoqK54u+zpI13J0EBF0sQp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230473577357003)(230373577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(37006003)(54906003)(66556008)(66946007)(66476007)(6636002)(26005)(86362001)(38100700002)(36756003)(6512007)(83380400001)(82960400001)(316002)(1076003)(2616005)(30864003)(6666004)(6486002)(41300700001)(7416002)(2906002)(6506007)(478600001)(966005)(4326008)(8936002)(5660300002)(8676002)(6862004)(579004)(559001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NQspm9Q6+HmhuudX7NNeNuuXJmnE2wziZ+yd0tv+Z6/O8yAOAMwNW1rGmY?=
 =?iso-8859-1?Q?BQ7kybZl2DV8WeUUTNgD6D+C1e600IdOg1820YLep9Qt3WmnVUT41emCay?=
 =?iso-8859-1?Q?1cdRIKtuS4O7X6LEvbD5XxBF9hGhHdi0FrbIxHMMgtMdJFI+GvIVXWXs7m?=
 =?iso-8859-1?Q?yX05UF5zWD+Jq5F+Wo6sCn4rPBgB2QzeJgbpl/i9xH9LMqZJUT8MCfEWdx?=
 =?iso-8859-1?Q?8BRYFYqGpqmoUK5OyO0ngKfeCaWzRGFTp+JVx6hhTSuDkzwxhF1rngc+SV?=
 =?iso-8859-1?Q?Tsr/YDF7nh3DBJoYSHUyTdzhUEyXI8RJctHGcnSf77Bwd4VhOpCEVGfFcd?=
 =?iso-8859-1?Q?LKbPZqTNnPMn1pvAUY1wcrVSV9V+c/U3/MaWbEKqnRvj0WC5XR0pEIPNQ8?=
 =?iso-8859-1?Q?+idUrc3yfm4am2OSiix3jT2tSm3TWrRuj8EZHw8y8MaG4dUv2+FfhUe1UP?=
 =?iso-8859-1?Q?cPvsOcytiSc6wK1Z/sUK11iGZz9HevtegvLUUVTRvSmZuPyZz7rK6HApkD?=
 =?iso-8859-1?Q?c2/B0oAnrH3cT10yrjxGYl/tQR1i8mE/FKO3Qz8i8NyjHcXa2VpYsfYbFz?=
 =?iso-8859-1?Q?8qJ9VPyMlbJr2jEICiDV7JBWcJXlB4tISAkWGKHEMjoMtDA2QUJkCudLLZ?=
 =?iso-8859-1?Q?CF5a6xTl4J6gSApw2Om7N/AvPjibakCuimOu1Oazz2WN+VDjRlb2ieEMP4?=
 =?iso-8859-1?Q?NddWh5OYe88t2pH+yGv7VSGWeT8CpbPoq5+Bxr1TJzCdu6MncgybdoocDo?=
 =?iso-8859-1?Q?s+fvAU264p4s3HAdAWgPpHW3oBZRngDGKFpGktuCLba42Wx+Bwk0qfcaKI?=
 =?iso-8859-1?Q?FDQKiV3NXDqnZif/o0HZd2ikHBBgSawV64AZGxEz2mG1Uk4mkFFIfkE+uX?=
 =?iso-8859-1?Q?jhq3+Ak4ry5nVmR2kY40M+eRcjGx0VJXjqt6soXu/VuV0lgaZTjJWA/aBT?=
 =?iso-8859-1?Q?FmEFtcZ/esJLpRloW9H/X77f3Tetg2PbjDoL/xPRKAH1OoCJjxXYrUE38P?=
 =?iso-8859-1?Q?d8Yc9aosOFHhkw4hLV5gi7jdOTvPTpNDGJrQFp3ur6svSMAUMkfea45/Tg?=
 =?iso-8859-1?Q?C4OR7HD5KtT2tu64L6DX1/RsJmppeKb/nioYPS6Dg8A2EYl5ZN8RuGvlkq?=
 =?iso-8859-1?Q?9s9CO8NTR2ycZlZr76m+kz7GGnPaTB5zxZr0F+TcMBcq6A+r/EMnnelewt?=
 =?iso-8859-1?Q?ETI3qQOSIBqJ3ZSmLd7CxaqRStC+TkqdGRIS2qaQUnpZtnMsdofAqkRRDy?=
 =?iso-8859-1?Q?osrQ43Ttp5orX+dtuI9d+75yKd3T5wpFZvFOsXvqwduM6voOqXRS3lYfmM?=
 =?iso-8859-1?Q?DDYydt+uX+aiSjaIvDd34NwjHHJ2YfoP9bomu7bk4E/Wb/+OpAZpeLB1dw?=
 =?iso-8859-1?Q?DNJbdwPJPAxfaFxvPKxiFvRtYDJ7jLTh2rjPkz4/XsIq2G4clqQ+qR3sOw?=
 =?iso-8859-1?Q?Nfwr2KrnGF9QIBpdTSGThywWJ4OFS7xSih+MCkAYnhm9C/QAUVAYRtdqIH?=
 =?iso-8859-1?Q?Lqk7bbl8t76S/PeX+sKXWdMLZpU95l+9gSumM/SXCEO8o1VQW8q830ryR3?=
 =?iso-8859-1?Q?mt8oyf0XtT3TqYMYVh9DkRtffE7Gt0Z0QLLYaJJ6Hihc7tUty6RelrzzW1?=
 =?iso-8859-1?Q?Kpx+w6ROt2WMfuyE+97wltnOagkSBHDtO5uBN+B6nT5cXYPAYucrMJIQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7010d4-13c1-4950-2179-08dbe4e4c5ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:39:03.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnoWO6vxmA07MbcfgDtY2Z/yTbr/Q/7VgeCacwvoySDGXNfellSaDg6K/DqOBBxx81dgmjRPPciUzEQ424Nnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Huang Ying,

when this commit is a review patch in
https://lore.kernel.org/all/20231016053002.756205-4-ying.huang@intel.com/

we made two reports

[1] 'a 14.6% improvement of netperf.Throughput_Mbps'
in https://lore.kernel.org/all/202310271441.71ce0a9-oliver.sang@intel.com/
now in mainline, we confirmed this commit cause similar performance change.

[2] 'a -60.4% regression of netperf.Throughput_Mbps'
in https://lore.kernel.org/all/202311061311.8d63998-oliver.sang@intel.com/
which per your education in
https://lore.kernel.org/all/87ttpzv11u.fsf@yhuang6-desk2.ccr.corp.intel.com/,
we know it's also an improvment in fact.

we also noticed similar results in mainline now, recorded in below
"In addition to that, the commit also has significant impact on the following tests:"
part.

just FYI about the results in maineline.



Hello,

kernel test robot noticed a 14.5% improvement of netperf.Throughput_Mbps on:


commit: 362d37a106dd3f6431b2fdd91d9208b0d023b50d ("mm, pcp: reduce lock contention for draining high-order pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	send_size: 10K
	test: SCTP_STREAM_MANY
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.ThroughputRecv_Mbps +245.1% improvement                                   |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cluster=cs-localhost                                                                       |
|                  | cpufreq_governor=performance                                                               |
|                  | ip=ipv4                                                                                    |
|                  | nr_threads=50%                                                                             |
|                  | runtime=300s                                                                               |
|                  | test=UDP_STREAM                                                                            |
+------------------+--------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231114/202311141422.64f32250-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-11.1-x86_64-20220510.cgz/300s/10K/lkp-icl-2sp2/SCTP_STREAM_MANY/netperf

commit: 
  94a3bfe407 ("cacheinfo: calculate size of per-CPU data cache slice")
  362d37a106 ("mm, pcp: reduce lock contention for draining high-order pages")

94a3bfe4073cd88b 362d37a106dd3f6431b2fdd91d9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.096e+10           -12.6%  1.831e+10 ±  2%  cpuidle..time
 5.789e+08           +14.3%  6.617e+08        cpuidle..usage
    809459 ±  4%     +10.9%     897385 ±  4%  meminfo.Inactive
    807091 ±  4%     +11.1%     896997 ±  4%  meminfo.Inactive(anon)
    408834 ±  6%     +14.2%     466794 ±  5%  meminfo.Mapped
 1.329e+09           +14.7%  1.525e+09        numa-numastat.node0.local_node
 1.329e+09           +14.7%  1.525e+09        numa-numastat.node0.numa_hit
 1.334e+09           +14.4%  1.526e+09        numa-numastat.node1.local_node
 1.334e+09           +14.4%  1.526e+09        numa-numastat.node1.numa_hit
 1.329e+09           +14.7%  1.525e+09        numa-vmstat.node0.numa_hit
 1.329e+09           +14.7%  1.525e+09        numa-vmstat.node0.numa_local
 1.334e+09           +14.4%  1.526e+09        numa-vmstat.node1.numa_hit
 1.334e+09           +14.4%  1.526e+09        numa-vmstat.node1.numa_local
     53.93           -13.3%      46.75        vmstat.cpu.id
     58.79           +14.5%      67.31        vmstat.procs.r
   3712230           +14.8%    4261665        vmstat.system.cs
   1987309           +13.8%    2261465        vmstat.system.in
     53.68            -7.3       46.41        mpstat.cpu.all.idle%
      2.11            +0.3        2.43        mpstat.cpu.all.irq%
      7.24            +1.3        8.51        mpstat.cpu.all.soft%
     35.72            +5.5       41.19        mpstat.cpu.all.sys%
      1.25            +0.2        1.46        mpstat.cpu.all.usr%
      7.00 ± 31%    +163.9%      18.47 ± 80%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     14.17 ± 74%    +115.0%      30.45 ± 61%  perf-sched.wait_and_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    226.00 ± 10%     -25.6%     168.17 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
     20.50 ± 16%     +34.1%      27.50 ± 12%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      2172 ±  2%     +15.9%       2518 ± 12%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     14.16 ± 74%    +115.0%      30.45 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1298           +15.2%       1495        turbostat.Avg_MHz
     50.06            +7.6       57.68        turbostat.Busy%
 5.789e+08           +14.3%  6.617e+08        turbostat.C1
     53.80            -7.0       46.76        turbostat.C1%
     49.94           -15.3%      42.32        turbostat.CPU%c1
 6.074e+08           +14.4%  6.949e+08        turbostat.IRQ
      0.01 ±223%     +70.8       70.82 ±  5%  turbostat.PKG_%
    393.62            +2.8%     404.63        turbostat.PkgWatt
      2203           +14.5%       2523        netperf.ThroughputBoth_Mbps
    564052           +14.5%     645891        netperf.ThroughputBoth_total_Mbps
      2203           +14.5%       2523        netperf.Throughput_Mbps
    564052           +14.5%     645891        netperf.Throughput_total_Mbps
    145457            +5.3%     153165        netperf.time.involuntary_context_switches
      3017           +16.5%       3514        netperf.time.percent_of_cpu_this_job_got
      8891           +16.4%      10351        netperf.time.system_time
    229.33           +14.1%     261.66        netperf.time.user_time
   2708074           +12.9%    3056807        netperf.time.voluntary_context_switches
 2.066e+09           +14.5%  2.365e+09        netperf.workload
   1323861            +3.2%    1366235        proc-vmstat.nr_active_anon
   2052345            +3.1%    2116315        proc-vmstat.nr_file_pages
    201772 ±  4%     +11.1%     224256 ±  4%  proc-vmstat.nr_inactive_anon
    102204 ±  6%     +14.2%     116709 ±  5%  proc-vmstat.nr_mapped
   1380852            +4.7%    1445326        proc-vmstat.nr_shmem
   1323861            +3.2%    1366235        proc-vmstat.nr_zone_active_anon
    201772 ±  4%     +11.1%     224256 ±  4%  proc-vmstat.nr_zone_inactive_anon
 2.663e+09           +14.5%  3.051e+09        proc-vmstat.numa_hit
 2.663e+09           +14.6%  3.051e+09        proc-vmstat.numa_local
 1.533e+10           +14.5%  1.755e+10        proc-vmstat.pgalloc_normal
 1.533e+10           +14.5%  1.755e+10        proc-vmstat.pgfree
   2925214           +34.1%    3921934        sched_debug.cfs_rq:/.avg_vruntime.avg
   3194737 ±  4%     +30.8%    4179249        sched_debug.cfs_rq:/.avg_vruntime.max
   2800753           +35.4%    3792613 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     47031 ± 15%     +19.8%      56357 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.42 ±  3%     +17.9%       0.49 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
     56720 ± 38%    +100.5%     113703 ± 26%  sched_debug.cfs_rq:/.left_vruntime.avg
   2588172 ± 16%     +48.6%    3847032 ±  4%  sched_debug.cfs_rq:/.left_vruntime.max
    361707 ± 24%     +72.8%     625018 ± 14%  sched_debug.cfs_rq:/.left_vruntime.stddev
   2925214           +34.1%    3921934        sched_debug.cfs_rq:/.min_vruntime.avg
   3194737 ±  4%     +30.8%    4179249        sched_debug.cfs_rq:/.min_vruntime.max
   2800753           +35.4%    3792613 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     47031 ± 15%     +19.8%      56357 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.41 ±  4%     +17.8%       0.49 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
     56720 ± 38%    +100.5%     113703 ± 26%  sched_debug.cfs_rq:/.right_vruntime.avg
   2588172 ± 16%     +48.6%    3847032 ±  4%  sched_debug.cfs_rq:/.right_vruntime.max
    361707 ± 24%     +72.8%     625018 ± 14%  sched_debug.cfs_rq:/.right_vruntime.stddev
    398.64           +15.7%     461.15 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    397.67           +15.8%     460.35 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    145.10 ±  7%     +31.8%     191.24 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    212.69 ±  3%     +12.9%     240.19 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      2249 ±  5%     +15.8%       2604 ±  5%  sched_debug.cpu.curr->pid.avg
      0.41 ±  5%     +15.9%       0.48 ±  5%  sched_debug.cpu.nr_running.avg
   4352165           +15.5%    5025032        sched_debug.cpu.nr_switches.avg
   4684469           +15.0%    5389122        sched_debug.cpu.nr_switches.max
   3905048 ±  4%     +17.4%    4586107        sched_debug.cpu.nr_switches.min
      0.56 ±  2%      -3.2%       0.54        perf-stat.i.MPKI
 2.306e+10           +13.4%  2.616e+10        perf-stat.i.branch-instructions
      0.65            -0.0        0.64        perf-stat.i.branch-miss-rate%
 1.492e+08           +10.7%  1.651e+08 ±  2%  perf-stat.i.branch-misses
      2.16 ±  2%      -0.1        2.08        perf-stat.i.cache-miss-rate%
  67530295           +10.2%   74410494        perf-stat.i.cache-misses
 3.197e+09           +14.6%  3.665e+09        perf-stat.i.cache-references
   3758728           +14.7%    4311773        perf-stat.i.context-switches
      1.42            +2.0%       1.45        perf-stat.i.cpi
  1.72e+11           +15.3%  1.984e+11        perf-stat.i.cpu-cycles
      5060           +48.8%       7531 ±  2%  perf-stat.i.cpu-migrations
      2560 ±  2%      +6.7%       2730 ±  3%  perf-stat.i.cycles-between-cache-misses
   2525722 ± 11%     +27.7%    3225099 ± 10%  perf-stat.i.dTLB-load-misses
 3.279e+10           +13.6%  3.724e+10        perf-stat.i.dTLB-loads
 2.039e+10           +13.7%   2.32e+10        perf-stat.i.dTLB-stores
 1.208e+11           +13.5%   1.37e+11        perf-stat.i.instructions
      0.71            -1.7%       0.69        perf-stat.i.ipc
      1.34           +15.3%       1.55        perf-stat.i.metric.GHz
    220.93 ±  2%      +8.0%     238.68        perf-stat.i.metric.K/sec
    620.53           +13.6%     705.06        perf-stat.i.metric.M/sec
   6980804           +15.1%    8037310 ±  2%  perf-stat.i.node-load-misses
    386919           +11.2%     430094 ±  2%  perf-stat.i.node-loads
     79.72            -1.4       78.37        perf-stat.i.node-store-miss-rate%
   3386551 ±  2%      +8.7%    3680783 ±  2%  perf-stat.i.node-stores
      0.56 ±  2%      -2.9%       0.54        perf-stat.overall.MPKI
      0.65            -0.0        0.63        perf-stat.overall.branch-miss-rate%
      2.11 ±  2%      -0.1        2.03        perf-stat.overall.cache-miss-rate%
      1.42            +1.6%       1.45        perf-stat.overall.cpi
      2548 ±  2%      +4.6%       2666        perf-stat.overall.cycles-between-cache-misses
      0.70            -1.6%       0.69        perf-stat.overall.ipc
     79.68            -1.2       78.49        perf-stat.overall.node-store-miss-rate%
 2.299e+10           +13.5%  2.608e+10        perf-stat.ps.branch-instructions
 1.487e+08           +10.7%  1.646e+08 ±  2%  perf-stat.ps.branch-misses
  67310184           +10.2%   74194024        perf-stat.ps.cache-misses
 3.187e+09           +14.7%  3.655e+09        perf-stat.ps.cache-references
   3746797           +14.8%    4299847        perf-stat.ps.context-switches
 1.715e+11           +15.4%  1.978e+11        perf-stat.ps.cpu-cycles
      5044           +48.9%       7511 ±  2%  perf-stat.ps.cpu-migrations
   2516580 ± 11%     +27.7%    3213035 ± 10%  perf-stat.ps.dTLB-load-misses
 3.268e+10           +13.6%  3.713e+10        perf-stat.ps.dTLB-loads
 2.033e+10           +13.8%  2.313e+10        perf-stat.ps.dTLB-stores
 1.204e+11           +13.5%  1.366e+11        perf-stat.ps.instructions
   6958364           +15.2%    8014526 ±  2%  perf-stat.ps.node-load-misses
    385693           +11.2%     428873 ±  2%  perf-stat.ps.node-loads
   3375913 ±  2%      +8.7%    3670695 ±  2%  perf-stat.ps.node-stores
 3.645e+13           +14.2%  4.161e+13        perf-stat.total.instructions
      4.36            -1.6        2.81        perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      5.82            -1.4        4.38        perf-profile.calltrace.cycles-pp.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      1.92 ±  2%      -1.4        0.55        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
     22.25            -1.3       20.94        perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     22.34            -1.3       21.04        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     22.67            -1.3       21.39        perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     23.36            -1.2       22.11        perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.57            -1.2       23.38        perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.06            -1.2       23.90        perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.40            -1.2       24.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     25.54            -1.1       24.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
     26.41            -1.1       25.29        perf-profile.calltrace.cycles-pp.recvmsg
      3.66            -0.9        2.75        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller
      4.74            -0.5        4.28        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve
      5.20            -0.4        4.75        perf-profile.calltrace.cycles-pp.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.93 ±  3%      -0.3        0.60 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      3.12            -0.3        2.78        perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.sctp_packet_transmit
      3.13            -0.3        2.80        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush
      3.16            -0.3        2.83        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      3.41            -0.3        3.09        perf-profile.calltrace.cycles-pp.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.61 ±  2%      -0.3        1.32        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node
      1.48 ±  2%      -0.3        1.20        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages
      1.60 ±  2%      -0.2        1.39 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__free_pages_ok.skb_release_data.kfree_skb_reason.sctp_recvmsg
      1.44 ±  2%      -0.2        1.23 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__free_pages_ok.skb_release_data.kfree_skb_reason
      1.95 ±  2%      -0.2        1.75 ±  2%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
      0.76            -0.2        0.58        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.85            -0.1        0.73        perf-profile.calltrace.cycles-pp.__slab_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      0.84            -0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.skb_release_data.consume_skb.sctp_chunk_put
      2.65            -0.1        2.54        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user
      2.57            -0.1        2.46        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty
      2.50            -0.1        2.40        perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk
      1.39            -0.1        1.29 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.consume_skb.sctp_chunk_put.sctp_outq_sack
      3.44            -0.1        3.35        perf-profile.calltrace.cycles-pp.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      1.93            -0.1        1.86        perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      0.62            +0.0        0.64        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      0.71            +0.0        0.74        perf-profile.calltrace.cycles-pp.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.54            +0.0        0.57        perf-profile.calltrace.cycles-pp.sock_kmalloc.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      0.57 ±  2%      +0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp.sctp_packet_config.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      0.63            +0.0        0.67        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.72 ±  2%      +0.0        0.77 ±  2%  perf-profile.calltrace.cycles-pp.sctp_outq_select_transport.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.60 ±  2%      +0.0        0.65        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.62            +0.1        0.68        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.68 ±  2%      +0.1        0.74        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      1.36            +0.1        1.42        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      0.96            +0.1        1.02        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.74 ±  2%      +0.1        0.80        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.90            +0.1        0.96        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.24            +0.1        1.30        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sctp_data_ready
      0.77            +0.1        0.84        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      1.03            +0.1        1.10        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.84            +0.1        0.90        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put
      0.86 ±  2%      +0.1        0.93 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_sendmsg_to_asoc.sctp_sendmsg
      1.27            +0.1        1.33        perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      1.31 ±  2%      +0.1        1.38        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sctp_data_ready.sctp_ulpq_tail_event
      1.50 ±  2%      +0.1        1.57        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data
      1.02 ±  2%      +0.1        1.09        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.skb_release_head_state.kfree_skb_reason.sctp_recvmsg.inet_recvmsg
      1.55            +0.1        1.63        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      1.84 ±  2%      +0.1        1.93        perf-profile.calltrace.cycles-pp.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      1.36            +0.1        1.45        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.40            +0.1        1.49        perf-profile.calltrace.cycles-pp.sctp_wfree.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack
      1.56            +0.1        1.65        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      2.05 ±  2%      +0.1        2.14        perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.00            +0.1        2.10        perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.43 ± 44%      +0.1        0.54        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
      1.43            +0.1        1.54        perf-profile.calltrace.cycles-pp.skb_release_head_state.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      1.24 ±  2%      +0.1        1.35 ±  2%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      1.28 ±  2%      +0.1        1.39 ±  2%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      1.84            +0.1        1.95        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      4.40            +0.1        4.51        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.01            +0.1        2.13        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.92            +0.1        2.06        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      2.70            +0.2        2.87        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      1.98            +0.2        2.15        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      3.04            +0.2        3.22        perf-profile.calltrace.cycles-pp.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.23            +0.2        2.41        perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      6.56            +0.2        6.76        perf-profile.calltrace.cycles-pp.__memcpy.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      3.60            +0.2        3.80        perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      6.90            +0.2        7.10        perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
     11.27            +0.2       11.48        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     10.94            +0.2       11.15        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     11.18            +0.2       11.40        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     11.88            +0.2       12.10        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.23            +0.2        7.47        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
      7.36            +0.3        7.61        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      0.92 ± 26%      +0.3        1.19        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      8.36            +0.3        8.64        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      8.40            +0.3        8.68        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      5.45            +0.3        5.74        perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
     13.30            +0.3       13.59        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     13.26            +0.3       13.55        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.28            +0.3       13.58        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     10.26            +0.3       10.56        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
     10.46            +0.3       10.76        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
     13.40            +0.3       13.71        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     11.20            +0.3       11.53        perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.17 ±141%      +0.4        0.53 ±  2%  perf-profile.calltrace.cycles-pp.sctp_sf_eat_data_6_2.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
     13.22            +0.4       13.65        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
     15.68            +0.4       16.12        perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      0.09 ±223%      +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
     15.27            +0.5       15.82        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.56            +0.6        1.14        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter
     55.03            +1.0       56.06        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     58.00            +1.1       59.06        perf-profile.calltrace.cycles-pp.__libc_start_main
     55.50            +1.2       56.65        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
      5.97            -2.3        3.64        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.90            -2.2        3.68        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.80            -1.9        4.93        perf-profile.children.cycles-pp.skb_release_data
      3.64            -1.7        1.93        perf-profile.children.cycles-pp.free_unref_page
      2.04            -1.7        0.33 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      5.84            -1.4        4.40        perf-profile.children.cycles-pp.kfree_skb_reason
     22.35            -1.3       21.05        perf-profile.children.cycles-pp.inet_recvmsg
     22.59            -1.3       21.30        perf-profile.children.cycles-pp.sctp_recvmsg
     22.68            -1.3       21.40        perf-profile.children.cycles-pp.sock_recvmsg
     23.38            -1.2       22.14        perf-profile.children.cycles-pp.____sys_recvmsg
     24.60            -1.2       23.40        perf-profile.children.cycles-pp.___sys_recvmsg
     25.09            -1.2       23.92        perf-profile.children.cycles-pp.__sys_recvmsg
     26.64            -1.1       25.52        perf-profile.children.cycles-pp.recvmsg
      5.43            -0.5        4.92        perf-profile.children.cycles-pp.__alloc_pages
      4.98            -0.5        4.47        perf-profile.children.cycles-pp.get_page_from_freelist
      5.93            -0.5        5.44        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      6.17            -0.5        5.68        perf-profile.children.cycles-pp.kmalloc_reserve
      5.85            -0.5        5.36        perf-profile.children.cycles-pp.__kmalloc_large_node
      3.85            -0.5        3.38        perf-profile.children.cycles-pp.rmqueue
      7.47            -0.5        7.01        perf-profile.children.cycles-pp.__alloc_skb
     82.68            -0.4       82.27        perf-profile.children.cycles-pp.do_syscall_64
     83.04            -0.4       82.66        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.62 ±  4%      -0.3        0.31 ±  4%  perf-profile.children.cycles-pp.sctp_wait_for_sndbuf
      1.76 ±  2%      -0.3        1.46        perf-profile.children.cycles-pp.lock_sock_nested
      1.89 ±  2%      -0.3        1.59        perf-profile.children.cycles-pp._raw_spin_lock_bh
      4.47            -0.2        4.26        perf-profile.children.cycles-pp.consume_skb
      1.97 ±  2%      -0.2        1.77 ±  2%  perf-profile.children.cycles-pp.__free_pages_ok
      6.01            -0.2        5.81        perf-profile.children.cycles-pp.sctp_outq_sack
      5.83            -0.2        5.66        perf-profile.children.cycles-pp.sctp_chunk_put
      1.20            -0.2        1.03        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.27            -0.1        1.15        perf-profile.children.cycles-pp.__slab_free
      0.86            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.74            -0.1        4.66        perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      0.38            -0.1        0.31        perf-profile.children.cycles-pp.__free_one_page
      4.70            -0.1        4.64        perf-profile.children.cycles-pp._sctp_make_chunk
      0.40            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.44            -0.0        0.40        perf-profile.children.cycles-pp.rmqueue_bulk
      0.65            -0.0        0.61 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.63            -0.0        0.60        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.55            -0.0        0.51        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.91            -0.0        0.88        perf-profile.children.cycles-pp.free_unref_page_commit
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.24 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.14 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__ip_finish_output
      0.24            +0.0        0.25        perf-profile.children.cycles-pp.irqentry_enter
      0.27 ±  3%      +0.0        0.28        perf-profile.children.cycles-pp.update_curr
      0.21 ±  3%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.22 ±  2%      +0.0        0.23        perf-profile.children.cycles-pp.__switch_to_asm
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.sctp_sched_fcfs_dequeue
      0.52 ±  2%      +0.0        0.54        perf-profile.children.cycles-pp.__fget_light
      0.34            +0.0        0.36        perf-profile.children.cycles-pp.sctp_make_control
      0.05 ±  7%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.49            +0.0        0.50        perf-profile.children.cycles-pp.sctp_gen_sack
      0.35            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.kmalloc_trace
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.sctp_make_sack
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ±  5%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.sk_leave_memory_pressure
      0.31 ±  2%      +0.0        0.33        perf-profile.children.cycles-pp.kfree
      0.54            +0.0        0.57 ±  2%  perf-profile.children.cycles-pp.__copy_skb_header
      0.15 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.30 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.sctp_inet_skb_msgname
      0.24            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.69            +0.0        0.72        perf-profile.children.cycles-pp.sctp_packet_append_chunk
      0.63            +0.0        0.65        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.24            +0.0        0.26        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.62            +0.0        0.65        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.37 ±  2%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.42 ±  2%      +0.0        0.45        perf-profile.children.cycles-pp.__kmalloc
      0.42 ±  2%      +0.0        0.45        perf-profile.children.cycles-pp.__mod_node_page_state
      0.79            +0.0        0.82        perf-profile.children.cycles-pp.__skb_clone
      0.66 ±  2%      +0.0        0.69        perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      0.56            +0.0        0.59        perf-profile.children.cycles-pp.sock_kmalloc
      0.68 ±  2%      +0.0        0.72        perf-profile.children.cycles-pp.__sctp_rcv_lookup
      0.39 ±  3%      +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.drain_stock
      0.31 ±  3%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.98            +0.0        1.01        perf-profile.children.cycles-pp.check_heap_object
      0.63            +0.0        0.67        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.36 ±  3%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      1.00            +0.0        1.03        perf-profile.children.cycles-pp.sctp_chunkify
      0.40 ±  3%      +0.0        0.44        perf-profile.children.cycles-pp.page_counter_try_charge
      0.39            +0.0        0.43 ±  3%  perf-profile.children.cycles-pp.dst_release
      0.78            +0.0        0.82        perf-profile.children.cycles-pp.refill_stock
      1.11 ±  2%      +0.0        1.15        perf-profile.children.cycles-pp.__rhashtable_lookup
      0.88            +0.0        0.93        perf-profile.children.cycles-pp.sctp_eat_data
      1.13            +0.0        1.18        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.63 ±  2%      +0.0        0.68        perf-profile.children.cycles-pp.dequeue_entity
      0.84            +0.0        0.88 ±  2%  perf-profile.children.cycles-pp.sctp_packet_config
      0.99            +0.0        1.04        perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      0.65            +0.0        0.70 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      1.30            +0.1        1.35        perf-profile.children.cycles-pp.try_to_wake_up
      0.66            +0.1        0.72        perf-profile.children.cycles-pp.enqueue_entity
      0.58            +0.1        0.64        perf-profile.children.cycles-pp.update_load_avg
      1.03            +0.1        1.09 ±  2%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      0.70 ±  2%      +0.1        0.76        perf-profile.children.cycles-pp.dequeue_task_fair
      0.87 ±  2%      +0.1        0.93        perf-profile.children.cycles-pp.pick_next_task_fair
      0.97            +0.1        1.03        perf-profile.children.cycles-pp.schedule_idle
      0.80            +0.1        0.86        perf-profile.children.cycles-pp.activate_task
      0.78            +0.1        0.84        perf-profile.children.cycles-pp.enqueue_task_fair
      3.92            +0.1        3.99        perf-profile.children.cycles-pp._copy_from_iter
      3.81            +0.1        3.88        perf-profile.children.cycles-pp.copyin
      1.54            +0.1        1.60        perf-profile.children.cycles-pp.__check_object_size
      1.36            +0.1        1.42        perf-profile.children.cycles-pp.autoremove_wake_function
      1.56            +0.1        1.62        perf-profile.children.cycles-pp.__wake_up_common
      1.38            +0.1        1.44        perf-profile.children.cycles-pp.kmem_cache_free
      1.29            +0.1        1.36        perf-profile.children.cycles-pp.sctp_ulpevent_free
      1.07            +0.1        1.14        perf-profile.children.cycles-pp.ttwu_do_activate
      1.60            +0.1        1.67        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.89 ±  2%      +0.1        0.97        perf-profile.children.cycles-pp.try_charge_memcg
      1.50            +0.1        1.57        perf-profile.children.cycles-pp.sctp_wfree
      4.47            +0.1        4.55        perf-profile.children.cycles-pp.sctp_user_addto_chunk
      1.90            +0.1        1.98        perf-profile.children.cycles-pp.sctp_data_ready
      1.07            +0.1        1.16 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_state
      2.14            +0.1        2.22        perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      1.40            +0.1        1.49        perf-profile.children.cycles-pp.sched_ttwu_pending
      3.18            +0.1        3.29        perf-profile.children.cycles-pp.sctp_outq_flush_data
      1.88            +0.1        2.00        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.06            +0.1        2.18        perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.77            +0.1        1.90        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      1.90            +0.1        2.05        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      3.26            +0.1        3.41        perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      6.94            +0.1        7.10        perf-profile.children.cycles-pp.__memcpy
      2.07            +0.2        2.22        perf-profile.children.cycles-pp.schedule
      2.31            +0.2        2.47        perf-profile.children.cycles-pp.schedule_timeout
     26.22            +0.2       26.40        perf-profile.children.cycles-pp.sctp_packet_transmit
      2.75            +0.2        2.93        perf-profile.children.cycles-pp.sysvec_call_function_single
      7.54            +0.2        7.72        perf-profile.children.cycles-pp.sctp_packet_pack
      2.94            +0.2        3.14        perf-profile.children.cycles-pp.__schedule
      2.42            +0.2        2.62        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      2.49            +0.2        2.69        perf-profile.children.cycles-pp.__sk_mem_schedule
      3.62            +0.2        3.82        perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      3.28            +0.2        3.50        perf-profile.children.cycles-pp.skb_release_head_state
     12.50            +0.2       12.72        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     12.52            +0.2       12.74        perf-profile.children.cycles-pp.ip_local_deliver_finish
     12.39            +0.2       12.61        perf-profile.children.cycles-pp.sctp_rcv
     11.28            +0.2       11.51        perf-profile.children.cycles-pp.cpuidle_enter_state
     11.36            +0.2       11.58        perf-profile.children.cycles-pp.cpuidle_enter
     11.98            +0.2       12.22        perf-profile.children.cycles-pp.cpuidle_idle_call
     11.02            +0.2       11.26        perf-profile.children.cycles-pp.acpi_idle_enter
     13.83            +0.2       14.06        perf-profile.children.cycles-pp.__do_softirq
     13.43            +0.2       13.66        perf-profile.children.cycles-pp.net_rx_action
     10.99            +0.2       11.23        perf-profile.children.cycles-pp.acpi_safe_halt
      5.72            +0.2        5.96        perf-profile.children.cycles-pp.sctp_ulpq_tail_data
     13.24            +0.2       13.48        perf-profile.children.cycles-pp.process_backlog
      7.27            +0.2        7.51        perf-profile.children.cycles-pp.copyout
     13.28            +0.2       13.52        perf-profile.children.cycles-pp.__napi_poll
     13.02            +0.2       13.27        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      7.37            +0.3        7.62        perf-profile.children.cycles-pp._copy_to_iter
     13.74            +0.3       14.01        perf-profile.children.cycles-pp.do_softirq
     13.95            +0.3       14.23        perf-profile.children.cycles-pp.__local_bh_enable_ip
      8.37            +0.3        8.65        perf-profile.children.cycles-pp.__skb_datagram_iter
      8.41            +0.3        8.69        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     13.30            +0.3       13.59        perf-profile.children.cycles-pp.start_secondary
     14.35            +0.3       14.65        perf-profile.children.cycles-pp.__dev_queue_xmit
     14.51            +0.3       14.82        perf-profile.children.cycles-pp.ip_finish_output2
     13.40            +0.3       13.71        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     13.40            +0.3       13.71        perf-profile.children.cycles-pp.cpu_startup_entry
     13.37            +0.3       13.69        perf-profile.children.cycles-pp.do_idle
     29.60            +0.3       29.92        perf-profile.children.cycles-pp.sctp_outq_flush
     15.02            +0.3       15.34        perf-profile.children.cycles-pp.__ip_queue_xmit
     29.02            +0.3       29.37        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     36.57            +0.4       36.93        perf-profile.children.cycles-pp.sctp_do_sm
     36.02            +0.4       36.39        perf-profile.children.cycles-pp.sctp_cmd_interpreter
      9.16            +0.4        9.54        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     15.95            +0.5       16.44        perf-profile.children.cycles-pp.sctp_primitive_SEND
     52.19            +0.6       52.82        perf-profile.children.cycles-pp.sock_sendmsg
     52.07            +0.6       52.71        perf-profile.children.cycles-pp.sctp_sendmsg
     54.19            +0.7       54.90        perf-profile.children.cycles-pp.____sys_sendmsg
     56.16            +0.7       56.91        perf-profile.children.cycles-pp.___sys_sendmsg
     56.76            +0.8       57.52        perf-profile.children.cycles-pp.__sys_sendmsg
     58.00            +1.1       59.06        perf-profile.children.cycles-pp.__libc_start_main
     57.44            +1.1       58.54        perf-profile.children.cycles-pp.sendmsg
     58.09            +1.4       59.51        perf-profile.children.cycles-pp.main
      5.96            -2.3        3.62        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.99            -0.2        0.80        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.26            -0.1        1.14        perf-profile.self.cycles-pp.__slab_free
      1.24            -0.1        1.15        perf-profile.self.cycles-pp.rmqueue
      0.39            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.47            -0.0        0.43        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.87            -0.0        0.84        perf-profile.self.cycles-pp.free_unref_page_commit
      0.14 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.18            +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.__sctp_packet_append_chunk
      0.18            +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.irqentry_enter
      0.10 ±  3%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp._copy_to_iter
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.28            +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.sctp_assoc_bh_rcv
      0.24            +0.0        0.26        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.22            +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__sys_recvmsg
      0.39            +0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.sk_leave_memory_pressure
      0.22 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.38            +0.0        0.40        perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.79 ±  2%      +0.0        0.81 ±  2%  perf-profile.self.cycles-pp.sctp_recvmsg
      0.46 ±  2%      +0.0        0.48        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.35            +0.0        0.37        perf-profile.self.cycles-pp.____sys_recvmsg
      0.23            +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.44 ±  3%      +0.0        0.47        perf-profile.self.cycles-pp.__rhashtable_lookup
      0.48            +0.0        0.51        perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.37            +0.0        0.40        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41 ±  2%      +0.0        0.44        perf-profile.self.cycles-pp.__mod_node_page_state
      0.32 ±  3%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.schedule
      0.27 ±  4%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.71            +0.0        0.75        perf-profile.self.cycles-pp.sctp_sendmsg
      0.70 ±  2%      +0.0        0.74        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.36 ±  4%      +0.0        0.39        perf-profile.self.cycles-pp.page_counter_try_charge
      0.45 ±  2%      +0.0        0.49 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.65            +0.0        0.69        perf-profile.self.cycles-pp.sctp_eat_data
      0.38            +0.0        0.42 ±  3%  perf-profile.self.cycles-pp.dst_release
      0.50 ±  4%      +0.0        0.54 ±  3%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.52 ±  3%      +0.0        0.57 ±  2%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      1.35            +0.1        1.41        perf-profile.self.cycles-pp.kmem_cache_free
      0.85            +0.1        0.92 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_state
      3.78            +0.1        3.84        perf-profile.self.cycles-pp.copyin
      7.30            +0.1        7.44        perf-profile.self.cycles-pp.acpi_safe_halt
      6.88            +0.2        7.03        perf-profile.self.cycles-pp.__memcpy
      7.23            +0.2        7.46        perf-profile.self.cycles-pp.copyout


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/50%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp2/UDP_STREAM/netperf

commit: 
  94a3bfe407 ("cacheinfo: calculate size of per-CPU data cache slice")
  362d37a106 ("mm, pcp: reduce lock contention for draining high-order pages")

94a3bfe4073cd88b 362d37a106dd3f6431b2fdd91d9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7524 ±  8%     +29.9%       9776 ±  3%  uptime.idle
 1.273e+09 ± 21%    +199.7%  3.815e+09 ±  7%  cpuidle..time
   1274197 ± 22%  +20412.9%  2.614e+08        cpuidle..usage
      3.04 ± 23%      +6.2        9.19 ±  7%  mpstat.cpu.all.idle%
      1.01            +0.7        1.66        mpstat.cpu.all.irq%
      5.95            -3.2        2.77        mpstat.cpu.all.soft%
      1.14            -0.1        1.02        mpstat.cpu.all.usr%
 1.456e+09 ±  5%     -30.9%  1.005e+09        numa-numastat.node0.local_node
 1.456e+09 ±  5%     -30.9%  1.005e+09        numa-numastat.node0.numa_hit
 1.436e+09 ±  4%     -31.0%  9.909e+08        numa-numastat.node1.local_node
 1.436e+09 ±  4%     -31.0%  9.906e+08        numa-numastat.node1.numa_hit
    108.17 ± 20%     -44.1%      60.50 ± 10%  perf-c2c.DRAM.local
      8938 ± 14%     -88.9%     993.83 ±  8%  perf-c2c.DRAM.remote
      8371 ± 14%     +67.7%      14042 ±  2%  perf-c2c.HITM.local
      6688 ± 13%     -92.4%     506.50 ± 13%  perf-c2c.HITM.remote
      3.69 ± 20%    +165.2%       9.78 ±  7%  vmstat.cpu.id
   3376131           +99.6%    6738492        vmstat.memory.cache
     43925 ± 36%   +5116.4%    2291314 ±  3%  vmstat.system.cs
    145227          +701.6%    1164089 ±  2%  vmstat.system.in
     18319 ± 67%    +600.7%     128356 ± 78%  numa-meminfo.node0.Mapped
    386752 ± 21%    +563.0%    2564036 ± 45%  numa-meminfo.node1.Active
    386534 ± 21%    +563.3%    2563708 ± 45%  numa-meminfo.node1.Active(anon)
    247887 ± 43%     +90.9%     473124 ± 24%  numa-meminfo.node1.Inactive
    247757 ± 43%     +90.9%     472930 ± 24%  numa-meminfo.node1.Inactive(anon)
     35531 ± 37%    +583.1%     242725 ± 33%  numa-meminfo.node1.Mapped
    400282 ± 21%    +587.6%    2752532 ± 44%  numa-meminfo.node1.Shmem
   1237566 ± 22%  +21016.7%  2.613e+08        turbostat.C1
      3.20 ± 21%      +6.6        9.75 ±  6%  turbostat.C1%
      3.17 ± 21%    +153.9%       8.04 ±  8%  turbostat.CPU%c1
      0.09           -22.2%       0.07        turbostat.IPC
  44929702          +692.6%  3.561e+08 ±  2%  turbostat.IRQ
     51.67 ± 28%  +12412.3%       6464 ± 11%  turbostat.POLL
     44.64 ±  4%     -30.2%      31.14        turbostat.RAMWatt
    551575 ±  8%    +563.4%    3659083        meminfo.Active
    550919 ±  8%    +564.1%    3658427        meminfo.Active(anon)
   3257775          +102.9%    6608864        meminfo.Cached
   1219821 ±  3%    +276.4%    4591517        meminfo.Committed_AS
    467148           +55.2%     725145 ±  4%  meminfo.Inactive
    466760           +55.3%     724757 ±  4%  meminfo.Inactive(anon)
     53822 ±  3%    +586.1%     369293 ±  5%  meminfo.Mapped
   5241056           +64.1%    8600901        meminfo.Memused
    573687 ±  8%    +584.1%    3924359        meminfo.Shmem
   5666306           +59.1%    9014810        meminfo.max_used_kB
     78924           -30.9%      54534        netperf.ThroughputBoth_Mbps
   5051167           -30.9%    3490181        netperf.ThroughputBoth_total_Mbps
      7695 ±  4%    +245.1%      26560        netperf.ThroughputRecv_Mbps
    492541 ±  4%    +245.1%    1699879        netperf.ThroughputRecv_total_Mbps
     71228           -60.7%      27973        netperf.Throughput_Mbps
   4558626           -60.7%    1790301        netperf.Throughput_total_Mbps
     22163            -2.0%      21715        netperf.time.minor_page_faults
      5443            +9.1%       5936        netperf.time.percent_of_cpu_this_job_got
     16212            +9.3%      17728        netperf.time.system_time
    395.00           -53.2%     185.04        netperf.time.user_time
 2.892e+09           -30.9%  1.998e+09        netperf.workload
      4644 ± 67%    +592.5%      32165 ± 78%  numa-vmstat.node0.nr_mapped
 1.456e+09 ±  5%     -30.9%  1.005e+09        numa-vmstat.node0.numa_hit
 1.456e+09 ±  5%     -30.9%  1.005e+09        numa-vmstat.node0.numa_local
     96749 ± 21%    +562.5%     640985 ± 45%  numa-vmstat.node1.nr_active_anon
     61933 ± 43%     +91.0%     118289 ± 24%  numa-vmstat.node1.nr_inactive_anon
      8935 ± 36%    +580.9%      60836 ± 33%  numa-vmstat.node1.nr_mapped
    100183 ± 21%    +587.0%     688240 ± 44%  numa-vmstat.node1.nr_shmem
     96749 ± 21%    +562.5%     640985 ± 45%  numa-vmstat.node1.nr_zone_active_anon
     61933 ± 43%     +91.0%     118289 ± 24%  numa-vmstat.node1.nr_zone_inactive_anon
 1.436e+09 ±  4%     -31.0%  9.906e+08        numa-vmstat.node1.numa_hit
 1.436e+09 ±  4%     -31.0%  9.909e+08        numa-vmstat.node1.numa_local
    137749 ±  8%    +563.8%     914395        proc-vmstat.nr_active_anon
    110973            +3.5%     114826        proc-vmstat.nr_anon_pages
   5601997            -1.5%    5518077        proc-vmstat.nr_dirty_background_threshold
  11217691            -1.5%   11049646        proc-vmstat.nr_dirty_threshold
    814469          +102.8%    1652061        proc-vmstat.nr_file_pages
  56370113            -1.5%   55529686        proc-vmstat.nr_free_pages
    116691           +55.3%     181269 ±  4%  proc-vmstat.nr_inactive_anon
     13488 ±  3%    +585.3%      92430 ±  5%  proc-vmstat.nr_mapped
      2821            +7.4%       3030        proc-vmstat.nr_page_table_pages
    143446 ±  8%    +583.8%     980934        proc-vmstat.nr_shmem
     29110            +6.6%      31023        proc-vmstat.nr_slab_reclaimable
    137749 ±  8%    +563.8%     914395        proc-vmstat.nr_zone_active_anon
    116691           +55.3%     181269 ±  4%  proc-vmstat.nr_zone_inactive_anon
     35388 ± 10%    +319.0%     148293 ± 41%  proc-vmstat.numa_hint_faults
     23666 ± 14%    +288.7%      91994 ± 18%  proc-vmstat.numa_hint_faults_local
 2.892e+09           -31.0%  1.996e+09        proc-vmstat.numa_hit
 2.892e+09           -31.0%  1.996e+09        proc-vmstat.numa_local
    176450 ±  3%    +101.7%     355834 ± 18%  proc-vmstat.numa_pte_updates
    162916 ±  7%    +295.6%     644434 ±  7%  proc-vmstat.pgactivate
 2.308e+10           -31.1%  1.591e+10        proc-vmstat.pgalloc_normal
   1033502           +24.6%    1287990 ±  4%  proc-vmstat.pgfault
 2.308e+10           -31.1%  1.591e+10        proc-vmstat.pgfree
  18958728 ±  2%     -21.0%   14970375        sched_debug.cfs_rq:/.avg_vruntime.avg
  20413945 ±  2%     -23.5%   15619661        sched_debug.cfs_rq:/.avg_vruntime.max
  17471158 ±  3%     -21.7%   13683884        sched_debug.cfs_rq:/.avg_vruntime.min
    886145 ±  5%     -65.5%     305904 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.78 ± 10%    -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
      0.15 ± 16%    +111.3%       0.32 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
     13682 ±141%   +1055.8%     158145 ± 12%  sched_debug.cfs_rq:/.left_vruntime.avg
   1751324 ±141%    +611.9%   12468237 ± 19%  sched_debug.cfs_rq:/.left_vruntime.max
    154192 ±141%    +771.6%    1343894 ± 14%  sched_debug.cfs_rq:/.left_vruntime.stddev
      6259 ± 10%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      5.08 ±  9%     -84.2%       0.81 ± 43%  sched_debug.cfs_rq:/.load_avg.min
  18958728 ±  2%     -21.0%   14970375        sched_debug.cfs_rq:/.min_vruntime.avg
  20413945 ±  2%     -23.5%   15619660        sched_debug.cfs_rq:/.min_vruntime.max
  17471158 ±  3%     -21.7%   13683884        sched_debug.cfs_rq:/.min_vruntime.min
    886145 ±  5%     -65.5%     305904 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.78 ± 10%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.07 ± 12%    +342.7%       0.29 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
     13682 ±141%   +1055.8%     158145 ± 12%  sched_debug.cfs_rq:/.right_vruntime.avg
   1751324 ±141%    +611.9%   12468237 ± 19%  sched_debug.cfs_rq:/.right_vruntime.max
    154192 ±141%    +771.6%    1343894 ± 14%  sched_debug.cfs_rq:/.right_vruntime.stddev
    899.24           -10.9%     801.56        sched_debug.cfs_rq:/.runnable_avg.avg
    553.92 ± 13%     -91.3%      47.92 ± 69%  sched_debug.cfs_rq:/.runnable_avg.min
    118.34 ±  9%    +100.2%     236.92 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    894.37           -11.2%     794.11        sched_debug.cfs_rq:/.util_avg.avg
      1423 ±  8%     +17.3%       1669 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    375.97 ± 11%     -90.7%      35.06 ± 73%  sched_debug.cfs_rq:/.util_avg.min
    113.96 ±  4%    +105.1%     233.80 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    552.12 ±  3%     -15.8%     464.75        sched_debug.cfs_rq:/.util_est_enqueued.avg
    134.00 ± 21%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
    569828 ±  2%     -67.3%     186585 ±  3%  sched_debug.cpu.avg_idle.avg
    377116           -52.9%     177762 ±  6%  sched_debug.cpu.avg_idle.stddev
      9.20 ±  6%     -27.1%       6.71 ±  7%  sched_debug.cpu.clock.stddev
      6714 ±  4%     -83.5%       1105 ± 11%  sched_debug.cpu.clock_task.stddev
      4465            -9.2%       4053        sched_debug.cpu.curr->pid.avg
      3854 ±  9%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    561.47 ±  2%    +172.3%       1529 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.78 ± 10%    -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.16 ± 17%    +107.8%       0.33 ±  2%  sched_debug.cpu.nr_running.stddev
     57951 ± 34%   +4529.2%    2682705 ±  2%  sched_debug.cpu.nr_switches.avg
    829877 ± 54%    +385.3%    4027719 ±  3%  sched_debug.cpu.nr_switches.max
      1210 ± 11%    +1e+05%    1272488 ± 19%  sched_debug.cpu.nr_switches.min
    116228 ± 42%    +383.4%     561896 ±  6%  sched_debug.cpu.nr_switches.stddev
      6.49 ± 10%     -81.6%       1.19 ± 30%  perf-stat.i.MPKI
 1.651e+10           -22.9%  1.273e+10        perf-stat.i.branch-instructions
      0.73            +0.1        0.78        perf-stat.i.branch-miss-rate%
   1.2e+08           -17.8%   98709480        perf-stat.i.branch-misses
     26.99 ± 15%     -25.5        1.50 ± 27%  perf-stat.i.cache-miss-rate%
 5.766e+08 ±  9%     -86.4%   78299254 ± 28%  perf-stat.i.cache-misses
 2.207e+09 ±  6%    +143.5%  5.373e+09        perf-stat.i.cache-references
     43842 ± 37%   +5171.8%    2311294 ±  3%  perf-stat.i.context-switches
      3.64           +29.7%       4.72        perf-stat.i.cpi
 3.208e+11            -4.1%  3.077e+11        perf-stat.i.cpu-cycles
    191.11 ±  2%   +1293.8%       2663 ±  7%  perf-stat.i.cpu-migrations
    885.36 ± 12%    +410.6%       4520 ± 19%  perf-stat.i.cycles-between-cache-misses
      0.00 ± 15%      +0.0        0.01 ±  6%  perf-stat.i.dTLB-load-miss-rate%
    834404 ± 19%    +203.3%    2530573 ±  7%  perf-stat.i.dTLB-load-misses
 2.383e+10           -27.8%  1.722e+10        perf-stat.i.dTLB-loads
      0.00 ± 31%      +0.0        0.01 ± 26%  perf-stat.i.dTLB-store-miss-rate%
    451420 ± 38%     +89.3%     854525 ± 29%  perf-stat.i.dTLB-store-misses
 1.289e+10           -29.6%  9.071e+09        perf-stat.i.dTLB-stores
 8.784e+10           -25.9%  6.506e+10        perf-stat.i.instructions
      0.28           -22.2%       0.22        perf-stat.i.ipc
      2.51            -4.1%       2.40        perf-stat.i.metric.GHz
    905.81 ± 16%     -62.7%     337.46 ± 36%  perf-stat.i.metric.K/sec
    435.42           -20.4%     346.74        perf-stat.i.metric.M/sec
      2813           +32.8%       3736 ±  5%  perf-stat.i.minor-faults
     99.72            -2.4       97.32        perf-stat.i.node-load-miss-rate%
 1.254e+08 ± 11%     -90.7%   11705077 ± 37%  perf-stat.i.node-load-misses
    242941 ±  7%     +10.9%     269429 ±  4%  perf-stat.i.node-loads
     75.99           +16.9       92.85        perf-stat.i.node-store-miss-rate%
 2.168e+08 ±  9%     -88.0%   26012874 ± 41%  perf-stat.i.node-store-misses
  69158158 ± 13%     -97.4%    1812179 ± 23%  perf-stat.i.node-stores
      2813           +32.8%       3736 ±  5%  perf-stat.i.page-faults
      6.57 ± 10%     -81.7%       1.20 ± 30%  perf-stat.overall.MPKI
      0.73            +0.0        0.78        perf-stat.overall.branch-miss-rate%
     26.37 ± 14%     -24.9        1.46 ± 28%  perf-stat.overall.cache-miss-rate%
      3.65           +29.5%       4.73        perf-stat.overall.cpi
    561.98 ± 10%    +643.4%       4177 ± 20%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 19%      +0.0        0.01 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 38%      +0.0        0.01 ± 29%  perf-stat.overall.dTLB-store-miss-rate%
      0.27           -22.8%       0.21        perf-stat.overall.ipc
     99.81            -2.2       97.56        perf-stat.overall.node-load-miss-rate%
     75.90           +17.3       93.20        perf-stat.overall.node-store-miss-rate%
      9310            +5.9%       9859        perf-stat.overall.path-length
 1.645e+10           -22.9%  1.269e+10        perf-stat.ps.branch-instructions
 1.196e+08           -17.7%   98407311        perf-stat.ps.branch-misses
  5.75e+08 ±  9%     -86.4%   77949265 ± 29%  perf-stat.ps.cache-misses
 2.199e+09 ±  6%    +143.4%  5.353e+09        perf-stat.ps.cache-references
     44158 ± 36%   +5124.7%    2307115 ±  3%  perf-stat.ps.context-switches
 3.197e+11            -4.0%  3.068e+11        perf-stat.ps.cpu-cycles
    190.32 ±  2%   +1298.2%       2661 ±  7%  perf-stat.ps.cpu-migrations
    831451 ± 19%    +200.8%    2500790 ±  7%  perf-stat.ps.dTLB-load-misses
 2.376e+10           -27.7%  1.717e+10        perf-stat.ps.dTLB-loads
    449675 ± 38%     +88.8%     849182 ± 29%  perf-stat.ps.dTLB-store-misses
 1.285e+10           -29.6%  9.047e+09        perf-stat.ps.dTLB-stores
 8.756e+10           -25.9%  6.488e+10        perf-stat.ps.instructions
      2806           +31.2%       3682 ±  5%  perf-stat.ps.minor-faults
  1.25e+08 ± 11%     -90.7%   11647116 ± 37%  perf-stat.ps.node-load-misses
    242224 ±  7%     +10.9%     268513 ±  4%  perf-stat.ps.node-loads
 2.162e+08 ±  9%     -88.0%   25880891 ± 41%  perf-stat.ps.node-store-misses
  68981864 ± 13%     -97.4%    1801815 ± 23%  perf-stat.ps.node-stores
      2806           +31.2%       3682 ±  5%  perf-stat.ps.page-faults
 2.692e+13           -26.8%   1.97e+13        perf-stat.total.instructions
      0.00 ±223%   +4775.0%       0.03 ± 87%  perf-sched.sch_delay.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
      0.11 ± 61%     -98.5%       0.00 ±113%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.06 ± 50%     -98.7%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.50 ± 28%     -84.5%       0.08 ± 23%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.25 ± 31%     -54.1%       0.11 ±  9%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.05 ± 68%    +329.7%       0.23 ± 57%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ±  3%     -68.4%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      0.03 ± 17%     +44.0%       0.04 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 22%   +6293.0%       2.14 ±208%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±178%  +13722.1%       3.96 ±163%  perf-sched.sch_delay.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
      1.21 ± 75%     -99.8%       0.00 ±100%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      3.70 ±  9%     -97.4%       0.10 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.29 ± 12%     -49.2%       2.18 ± 35%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±145%   +2960.0%       0.05 ±189%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      8.55 ± 96%    +323.5%      36.21 ± 53%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      3.32 ± 30%     -48.4%       1.72 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.03 ± 27%    +114.9%       6.51 ± 65%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.63 ± 20%   +6778.0%     249.49 ±218%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 20%     -49.0%       0.00 ± 17%  perf-sched.total_sch_delay.average.ms
      6.55 ± 47%     -94.6%       0.35 ±  3%  perf-sched.total_wait_and_delay.average.ms
    219803 ± 34%   +1680.6%    3913737        perf-sched.total_wait_and_delay.count.ms
      6.54 ± 47%     -94.7%       0.35 ±  3%  perf-sched.total_wait_time.average.ms
     99.26 ± 82%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      2.59 ±100%    +120.6%       5.71 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     50.97 ± 46%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    111.78 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    163.47 ± 72%    +328.8%     700.90 ± 42%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    200.78 ±115%    +248.6%     699.98 ± 20%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.07 ± 45%     -77.6%       0.02 ± 35%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    165.27 ± 47%    +270.0%     611.51 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.04 ±  3%     -49.8%       0.02 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
    526.99 ±  6%     -39.1%     320.76 ± 12%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.33 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      8.17 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     11.00 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      4.00 ± 64%    +162.5%      10.50 ± 50%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.17 ±223%   +1100.0%       2.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     96.00 ± 30%     -79.5%      19.67 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    104770 ± 35%   +3512.6%    3784994        perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      1075 ±  8%     +91.3%       2057 ± 10%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.50 ±152%    +400.0%       2.50 ± 20%  perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
    264.41 ± 79%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    282.57 ± 86%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    449.89 ± 84%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    577.48 ± 83%    +356.7%       2637 ± 32%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.66 ± 77%    +357.1%      89.88 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
     99.26 ± 82%     -99.9%       0.09 ±113%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    127.89 ± 83%     -99.9%       0.07 ±189%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.16 ± 49%     -88.7%       0.02 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.04 ±125%     -92.9%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     50.97 ± 46%     -99.9%       0.07 ± 73%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.13 ± 35%     -83.5%       0.02 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    111.78 ±100%     -99.9%       0.10 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    163.46 ± 72%    +328.8%     700.88 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    200.97 ±114%    +248.2%     699.72 ± 20%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.07 ± 45%     -77.9%       0.02 ± 36%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    165.22 ± 47%    +270.0%     611.27 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ±  4%     -40.0%       0.01        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
    526.93 ±  6%     -39.1%     320.73 ± 12%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    264.41 ± 79%     -99.9%       0.23 ±130%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    353.47 ± 85%    -100.0%       0.07 ±177%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      3.10 ± 58%     -97.5%       0.08 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.36 ±193%     -99.1%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    282.57 ± 86%     -99.9%       0.27 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      3.75 ±  9%     -94.7%       0.20 ± 87%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    449.89 ± 84%     -99.9%       0.32 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    577.46 ± 83%    +356.7%       2637 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.37 ± 61%    +451.6%      62.71 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
     43.56           -19.9       23.69        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data.__consume_stateless_skb
     43.95           -19.6       24.32        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg
     43.12           -19.5       23.59        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data
     45.09           -19.2       25.84        perf-profile.calltrace.cycles-pp.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg
     45.10           -19.2       25.85        perf-profile.calltrace.cycles-pp.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     44.47           -19.1       25.39        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg
     49.54            -8.3       41.26        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     49.55            -8.3       41.29        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     49.57            -8.2       41.38        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.72            -7.7       42.01        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     49.73            -7.7       42.04        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni
     49.76            -7.6       42.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests
     49.77            -7.5       42.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests.spawn_child
     49.80            -7.3       42.52        perf-profile.calltrace.cycles-pp.recvfrom.recv_omni.process_requests.spawn_child.accept_connection
     20.02 ±  2%      -6.1       13.88 ±  3%  perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
     19.53 ±  2%      -5.9       13.66 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
     19.08 ±  2%      -5.7       13.38 ±  3%  perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb
      8.97            -5.0        4.02 ±  3%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      8.72            -4.8        3.90 ±  3%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
      8.12 ±  2%      -4.5        3.64 ±  3%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
      7.71            -4.3        3.45 ±  3%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
      6.49 ±  2%      -3.6        2.86 ±  3%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      6.52 ±  2%      -3.6        2.92 ±  3%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      6.43 ±  2%      -3.6        2.83 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      5.90 ±  2%      -3.4        2.54 ±  3%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      5.75 ±  2%      -3.3        2.46 ±  3%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      5.72 ±  2%      -3.3        2.44 ±  3%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
      5.38 ±  2%      -3.1        2.29 ±  3%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      4.64 ±  2%      -2.6        1.99 ±  3%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      4.60 ±  2%      -2.6        1.98 ±  3%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      4.46 ±  2%      -2.5        1.91 ±  3%  perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      3.87 ±  2%      -2.2        1.67 ±  3%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      3.80 ±  2%      -2.2        1.64 ±  3%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      2.26 ±  2%      -1.6        0.68 ±  5%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
      1.99 ±  2%      -1.5        0.47 ± 44%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg
      1.18 ±  2%      -0.8        0.34 ± 70%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      1.13 ±  2%      -0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page.skb_release_data.__consume_stateless_skb
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.udp_rmem_release.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.udp_rmem_release.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +1.1        1.12 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      0.00            +1.1        1.15 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      0.00            +1.2        1.19 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      0.00            +1.3        1.34 ±  2%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +1.4        1.40 ±  2%  perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      0.00            +2.3        2.25        perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     49.90 ±  2%      +2.7       52.62        perf-profile.calltrace.cycles-pp.send_udp_stream.main.__libc_start_main
     49.88 ±  2%      +2.7       52.60        perf-profile.calltrace.cycles-pp.send_omni_inner.send_udp_stream.main.__libc_start_main
      0.00            +2.9        2.92        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +3.0        3.02        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +3.0        3.04        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     49.08 ±  2%      +3.2       52.24        perf-profile.calltrace.cycles-pp.sendto.send_omni_inner.send_udp_stream.main.__libc_start_main
      0.00            +3.3        3.27        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     48.71 ±  2%      +3.5       52.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream.main
     48.65            +3.6       52.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream
     48.35            +3.8       52.11        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner
     48.23            +3.8       52.04        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.00            +4.0        4.01 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +4.0        4.03 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +4.0        4.03 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00            +4.1        4.08 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +4.3        4.28 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     47.03            +4.5       51.51        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.54            +4.8       51.30        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      3.64 ±  3%      +8.2       11.87        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg
      3.68 ±  3%      +8.4       12.04        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
      3.92 ±  3%      +8.8       12.67        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
      3.93 ±  3%      +8.8       12.70        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     35.54 ±  2%     +10.9       46.42        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     33.02 ±  2%     +12.6       45.63        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     10.43 ±  2%     +19.8       30.25        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
     10.40 ±  2%     +19.8       30.23        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg
     10.00 ±  2%     +20.0       29.96        perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb
      9.75 ±  2%     +20.0       29.74        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data
      8.54 ±  2%     +20.5       29.00        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill
      6.19 ±  2%     +21.4       27.60        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.rmqueue.get_page_from_freelist
      6.26 ±  2%     +21.4       27.71        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages
      6.52 ±  2%     +22.0       28.47        perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill
     47.79           -21.9       25.89        perf-profile.children.cycles-pp.skb_release_data
     46.75           -21.3       25.44        perf-profile.children.cycles-pp.free_unref_page
     43.96           -19.6       24.34        perf-profile.children.cycles-pp.free_pcppages_bulk
     45.10           -19.2       25.85        perf-profile.children.cycles-pp.__consume_stateless_skb
     49.54            -8.3       41.27        perf-profile.children.cycles-pp.udp_recvmsg
     49.55            -8.2       41.30        perf-profile.children.cycles-pp.inet_recvmsg
     49.57            -8.2       41.39        perf-profile.children.cycles-pp.sock_recvmsg
     49.73            -7.7       42.02        perf-profile.children.cycles-pp.__sys_recvfrom
     49.74            -7.7       42.05        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     49.82            -7.2       42.61        perf-profile.children.cycles-pp.recvfrom
     49.86            -7.1       42.81        perf-profile.children.cycles-pp.accept_connection
     49.86            -7.1       42.81        perf-profile.children.cycles-pp.spawn_child
     49.86            -7.1       42.81        perf-profile.children.cycles-pp.process_requests
     49.86            -7.1       42.81        perf-profile.children.cycles-pp.recv_omni
     20.12 ±  2%      -6.2       13.96 ±  2%  perf-profile.children.cycles-pp.ip_generic_getfrag
     19.61 ±  2%      -5.9       13.74 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
     19.36 ±  2%      -5.8       13.59 ±  2%  perf-profile.children.cycles-pp.copyin
      9.02            -5.0        4.05 ±  2%  perf-profile.children.cycles-pp.udp_send_skb
      8.76            -4.8        3.93 ±  2%  perf-profile.children.cycles-pp.ip_send_skb
      8.16            -4.5        3.66 ±  2%  perf-profile.children.cycles-pp.ip_finish_output2
      7.77            -4.3        3.48 ±  2%  perf-profile.children.cycles-pp.__dev_queue_xmit
     98.69            -4.0       94.64        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     98.48            -4.0       94.52        perf-profile.children.cycles-pp.do_syscall_64
      6.52            -3.6        2.89 ±  2%  perf-profile.children.cycles-pp.do_softirq
      6.55            -3.6        2.94 ±  2%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      6.47            -3.6        2.89 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      5.94            -3.4        2.56 ±  2%  perf-profile.children.cycles-pp.net_rx_action
      5.78            -3.3        2.48 ±  2%  perf-profile.children.cycles-pp.__napi_poll
      5.75 ±  2%      -3.3        2.46 ±  2%  perf-profile.children.cycles-pp.process_backlog
      5.40 ±  2%      -3.1        2.30 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      4.66 ±  2%      -2.7        2.00 ±  2%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      4.63 ±  2%      -2.6        1.99 ±  2%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      4.49 ±  2%      -2.6        1.93 ±  2%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      3.88 ±  2%      -2.2        1.68 ±  2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      3.85 ±  2%      -2.2        1.66 ±  2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      2.29 ±  2%      -1.6        0.69 ±  4%  perf-profile.children.cycles-pp.__ip_make_skb
      2.00 ±  2%      -1.4        0.56 ±  5%  perf-profile.children.cycles-pp.__ip_select_ident
      1.59 ±  4%      -1.2        0.35        perf-profile.children.cycles-pp.free_unref_page_commit
      1.20            -0.7        0.51 ±  3%  perf-profile.children.cycles-pp.ip_route_output_flow
      1.14            -0.6        0.56        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.85 ±  2%      -0.5        0.37 ±  4%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.89 ±  2%      -0.5        0.43        perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.84            -0.4        0.40        perf-profile.children.cycles-pp.__alloc_skb
      0.75            -0.4        0.33 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.73 ±  3%      -0.4        0.32 ±  4%  perf-profile.children.cycles-pp.fib_table_lookup
      0.67 ±  2%      -0.4        0.30 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      0.71 ±  6%      -0.4        0.36 ±  2%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.46 ±  2%      -0.3        0.15 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.56 ±  2%      -0.3        0.27 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.44 ±  3%      -0.3        0.17 ±  3%  perf-profile.children.cycles-pp.ip_rcv
      0.42            -0.2        0.18 ±  3%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.40 ±  2%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.__udp4_lib_lookup
      0.32 ±  2%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.__netif_rx
      0.30            -0.2        0.12 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.31            -0.2        0.13 ±  4%  perf-profile.children.cycles-pp.netif_rx_internal
      0.30 ±  4%      -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.63            -0.2        0.46 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.28 ±  2%      -0.2        0.12 ±  3%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.29 ±  2%      -0.2        0.13 ±  2%  perf-profile.children.cycles-pp.send_data
      0.26 ±  3%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.38            -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.24 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.24 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.security_socket_sendmsg
      0.20 ±  3%      -0.1        0.08        perf-profile.children.cycles-pp.ip_output
      0.20 ±  3%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.sock_wfree
      0.21 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.21 ±  4%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__mkroute_output
      0.21 ±  4%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.21 ±  2%      -0.1        0.09        perf-profile.children.cycles-pp.validate_xmit_skb
      0.17 ±  2%      -0.1        0.06        perf-profile.children.cycles-pp.ip_rcv_core
      0.28 ±  3%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.34 ±  3%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.15 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__ip_local_out
      0.13            -0.1        0.05        perf-profile.children.cycles-pp.siphash_3u32
      0.14 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.ip_setup_cork
      0.13 ±  2%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.12 ±  6%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.dst_release
      0.13 ±  6%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.fib_lookup_good_nhc
      0.17 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.20 ±  2%      -0.1        0.13        perf-profile.children.cycles-pp.aa_sk_perm
      0.16 ±  3%      -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.23            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.10 ±  3%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.ip_send_check
      0.11            -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ipv4_mtu
      0.20 ±  2%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.32 ±  2%      -0.1        0.26        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.27 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.15 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.64            -0.0        0.60 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.free_tail_page_prepare
      0.11 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__folio_put
      0.13 ±  5%      -0.0        0.10        perf-profile.children.cycles-pp.alloc_pages
      0.24            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.prep_compound_page
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 17%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.05 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.43 ±  2%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.07 ±  5%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.50            +0.1        0.56        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__get_user_4
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.11 ±  8%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.10        perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.recv_data
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.02 ±141%      +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.01 ±223%      +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.33 ±  4%      +0.2        0.53        perf-profile.children.cycles-pp.__free_one_page
      0.00            +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.01 ±223%      +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.drain_stock
      0.03 ± 70%      +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.07 ± 10%      +0.2        0.30        perf-profile.children.cycles-pp.move_addr_to_user
      0.16 ±  3%      +0.2        0.39 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.07 ±  8%      +0.2        0.31 ±  2%  perf-profile.children.cycles-pp.refill_stock
      0.00            +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.3        0.25        perf-profile.children.cycles-pp.update_load_avg
      0.21 ±  4%      +0.3        0.49        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.3        0.34 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.09 ±  5%      +0.3        0.44 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +0.4        0.35 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.00            +0.4        0.36 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.4        0.37 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.4        0.39 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.4        0.40 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.4        0.40 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.18 ±  5%      +0.4        0.60        perf-profile.children.cycles-pp.udp_rmem_release
      0.00            +0.4        0.42 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      0.11 ±  8%      +0.4        0.54        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.12 ±  6%      +0.4        0.55 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.00            +0.4        0.44 ±  2%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +0.5        0.47 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.5        0.51 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
      0.00            +0.5        0.53 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.6        0.56 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.6        0.56 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.6        0.58        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.16 ±  4%      +0.6        0.78 ±  2%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.16 ±  4%      +0.6        0.79 ±  2%  perf-profile.children.cycles-pp.__sk_mem_schedule
      0.00            +0.8        0.78 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.41 ±  2%      +1.0        1.41 ±  2%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      0.01 ±223%      +1.2        1.17 ±  3%  perf-profile.children.cycles-pp.schedule
      0.00            +1.2        1.22 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +1.3        1.35 ±  3%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
     49.97            +1.6       51.59        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.01 ±223%      +1.7        1.66 ±  3%  perf-profile.children.cycles-pp.__schedule
     49.34            +1.9       51.28        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.27 ±  5%      +2.0        2.27        perf-profile.children.cycles-pp.__skb_recv_udp
      0.00            +2.6        2.64 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     50.06            +2.8       52.89        perf-profile.children.cycles-pp.send_udp_stream
     50.04            +2.8       52.88        perf-profile.children.cycles-pp.send_omni_inner
      0.00            +2.9        2.94 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.00            +3.0        2.96 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.00            +3.1        3.06 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +3.1        3.08 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     49.43            +3.2       52.61        perf-profile.children.cycles-pp.sendto
      0.00            +3.3        3.32 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     48.37            +3.7       52.12        perf-profile.children.cycles-pp.__x64_sys_sendto
     48.25            +3.8       52.06        perf-profile.children.cycles-pp.__sys_sendto
      0.00            +4.0        4.03 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.00            +4.1        4.06 ±  2%  perf-profile.children.cycles-pp.do_idle
      0.00            +4.1        4.08 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00            +4.1        4.08 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     47.04            +4.5       51.52        perf-profile.children.cycles-pp.sock_sendmsg
     46.61            +4.7       51.32        perf-profile.children.cycles-pp.udp_sendmsg
      3.66 ±  3%      +8.3       11.95        perf-profile.children.cycles-pp.copyout
      3.68 ±  3%      +8.4       12.04        perf-profile.children.cycles-pp._copy_to_iter
      3.92 ±  3%      +8.8       12.68        perf-profile.children.cycles-pp.__skb_datagram_iter
      3.93 ±  3%      +8.8       12.70        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     35.56 ±  2%     +10.9       46.42        perf-profile.children.cycles-pp.ip_make_skb
     33.05 ±  2%     +12.6       45.64        perf-profile.children.cycles-pp.__ip_append_data
     10.48 ±  2%     +19.8       30.33        perf-profile.children.cycles-pp.sk_page_frag_refill
     10.44 ±  2%     +19.9       30.31        perf-profile.children.cycles-pp.skb_page_frag_refill
     10.06 ±  2%     +20.0       30.05        perf-profile.children.cycles-pp.__alloc_pages
      9.82 ±  2%     +20.0       29.84        perf-profile.children.cycles-pp.get_page_from_freelist
      8.59 ±  2%     +20.5       29.08        perf-profile.children.cycles-pp.rmqueue
      6.55 ±  2%     +22.0       28.56        perf-profile.children.cycles-pp.rmqueue_bulk
     19.25 ±  2%      -5.7       13.52 ±  2%  perf-profile.self.cycles-pp.copyin
      1.88 ±  3%      -1.5        0.41 ±  2%  perf-profile.self.cycles-pp.rmqueue
      1.86 ±  2%      -1.4        0.50 ±  6%  perf-profile.self.cycles-pp.__ip_select_ident
      1.55 ±  4%      -1.2        0.32 ±  2%  perf-profile.self.cycles-pp.free_unref_page_commit
      1.30 ±  2%      -0.5        0.79 ±  2%  perf-profile.self.cycles-pp.__ip_append_data
      0.73 ±  2%      -0.4        0.29 ±  2%  perf-profile.self.cycles-pp.udp_sendmsg
      0.70 ±  6%      -0.4        0.34 ±  2%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.60 ±  2%      -0.3        0.26 ±  4%  perf-profile.self.cycles-pp.fib_table_lookup
      0.50 ±  2%      -0.3        0.16 ±  2%  perf-profile.self.cycles-pp.skb_release_data
      0.46            -0.3        0.15 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.62 ±  2%      -0.3        0.32 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  2%      -0.3        0.21 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      0.44 ±  3%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.37            -0.2        0.17 ±  2%  perf-profile.self.cycles-pp.send_omni_inner
      0.35 ±  4%      -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.29            -0.2        0.12 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.22 ±  2%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.free_unref_page
      0.24 ±  3%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.22            -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.sendto
      0.22 ±  3%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.send_data
      0.20 ±  4%      -0.1        0.08        perf-profile.self.cycles-pp.sock_wfree
      0.21 ±  2%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.__ip_make_skb
      0.20 ±  3%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.20 ±  6%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.20 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.udp_send_skb
      0.22 ±  5%      -0.1        0.11        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.20 ±  3%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.40 ±  4%      -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.25 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.18 ±  5%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__mkroute_output
      0.16 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ip_rcv_core
      0.27 ±  4%      -0.1        0.17 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.17 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.34 ±  4%      -0.1        0.24        perf-profile.self.cycles-pp.__slab_free
      0.16 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.sock_sendmsg
      0.26 ±  3%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.14 ±  3%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.14 ±  2%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.15 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.ip_output
      0.38 ±  3%      -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.14 ±  2%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.udp4_lib_lookup2
      0.12 ±  4%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.12 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.siphash_3u32
      0.12 ±  4%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.ip_send_check
      0.11 ±  4%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.20 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.14 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.process_backlog
      0.13 ±  2%      -0.1        0.06        perf-profile.self.cycles-pp.ip_send_skb
      0.17 ±  2%      -0.1        0.10        perf-profile.self.cycles-pp.aa_sk_perm
      0.12 ±  7%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.fib_lookup_good_nhc
      0.16 ±  3%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.10 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.16 ±  3%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.16 ±  4%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.__do_softirq
      0.13 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.net_rx_action
      0.19 ±  3%      -0.1        0.13 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.16 ±  2%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.12 ±  4%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.10 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.ipv4_mtu
      0.27 ±  2%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.11 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.ip_generic_getfrag
      0.15 ±  5%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.loopback_xmit
      0.16 ±  4%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.11            -0.0        0.08        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  2%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.__alloc_pages
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.free_tail_page_prepare
      0.09 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.prep_compound_page
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.sock_def_readable
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.move_addr_to_user
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.schedule_timeout
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__skb_wait_for_more_packets
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.menu_select
      0.11 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__get_user_4
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.recvfrom
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.recv_data
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.refill_stock
      0.00            +0.1        0.10        perf-profile.self.cycles-pp._copy_to_user
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.newidle_balance
      0.00            +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.recv_omni
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.06 ±  7%      +0.1        0.20        perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.04 ± 44%      +0.1        0.19        perf-profile.self.cycles-pp.__sys_recvfrom
      0.00            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__skb_recv_udp
      0.08            +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.09 ±  5%      +0.2        0.25 ±  3%  perf-profile.self.cycles-pp.udp_recvmsg
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.02 ± 99%      +0.2        0.21 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.2        0.19 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.2        0.22        perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.14 ±  3%      +0.2        0.37        perf-profile.self.cycles-pp.__free_one_page
      0.20 ±  4%      +0.3        0.48        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
     49.34            +1.9       51.28        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +2.0        2.02 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      3.65 ±  3%      +8.2       11.89        perf-profile.self.cycles-pp.copyout





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

