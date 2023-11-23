Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A07F5798
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbjKWFDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKWFDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:03:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE91A3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700715834; x=1732251834;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=tk/+V6dIT1aaQZPflXFBOlDadVlwbGEK6cpx6xj1ftg=;
  b=Vj4VU4WqicnsGFl3b0g165FKAQV7IyG07jWC5OttIWGgcfFQjk6t5yMR
   KU9QCaoxVCQp4kY9TiQzE0DGmJs25q3pvXDwOg9bClRrPPwoIarfLfxtc
   2G+1HjMR1gQrKavIwPGP5b6sdDbyEV36ismJSPP6xcb/yF7DMBpmxwGuI
   9Uf2FwB5EQ7ELqDMTe3XYT/bESortIksxx7MwP+FooEfkFo4QQY0cazZB
   FuDfa0xqktBzmvOUa7nVelb5cO1pOgqYp21k3DKWtBXxi07br6gViljvB
   kr2yw/wjO7GNsIoG23CTUVhonMONgbAGQhV2dLIJBk/1E56kWuf70LYk/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10877262"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="10877262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="884863957"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="884863957"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 21:03:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 21:03:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 21:03:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 21:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOAE8YmnBjIAHqaOHiV4kGBViZZbLs799lWlKEmZvEwa57nbYXgNL6yxa5XymrHGgkNG0cCwObJeP5/OEPA/dBOI8pLIAdC7bZ41pSBbeZxWciVGgO1rOnMs0k+n3D50l+lG+aCOkiD7BRuYOUVV3RfCUYMmefptkA0KQjwHLBV+jBAVeJ5zDm3tluicASSjKVKoEZIavQqQmYC3kEzcRLD05lqMPode8yEuREpwnXWA+1SqWA3gcaZgtWDT879ryykGClD6607ZtwhLA2SGhNGBK3dNABVgKTetxJxqUTukjNmHp0ueimKw3kTnEnGS/7NrTaMZ9ATuebMYmbE33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqcP4qxh2/qOIlffr4BqxaXfoQ8tttpM6Cjup/xlHA0=;
 b=fXM7FsVaIwsgOHsMBIwqFQDMuddY8XLNKhShihL5JRuAfMrCVdNB7dh+AHFH1keBYHdNarqZTEivqxKmf3aWDJR2+mRfIe2EgPzsBX78+76tVYoFz3ovxV3NAb/QnyXx2AmzDtoXCzG/rIiZ0i3XZ7XXBqePoe3FTI8wjgeMz3gQ3Gzo010eiMYyZjR2wuxomC3cafqUAPrJqaEafacsa1f/a92Z3ObbpkczNztcZu8UCkP0IuN9LkNDz90gWXaNTQH2Q42qVjOigt9YwkxLMOJZU7jgiHpXmGSjU9Unk+TdkVUnC09Z3db5+mYghzioTShJ3Hbswi5GmLXvVI9jZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 05:03:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Thu, 23 Nov 2023
 05:03:48 +0000
Date:   Thu, 23 Nov 2023 13:03:34 +0800
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
Subject: [linus:master] [mm, pcp]  6ccdcb6d3a:  stress-ng.judy.ops_per_sec
 -4.7% regression
Message-ID: <202311231029.3aa790-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: e983eb01-8a9f-41c1-d48d-08dbebe192bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwyZ9CZ6uRCNV3MW2ds0GrM7gI+IzqJXfGZFqztnNctQsi2KjaBnEu3n3FT+3OyUrWIEIR3OARNt5Xqu8B70ZB5OuXbkEcMkxmvXdBA17nlTETJrl4VYvDcmBrJA9Z1cN5C6+Xnewk8OnG/Ckn9UbQNluUR0otucLNCeV8JIyNMRNyTmLbswrKE1xXpYFxLBqCbu4wt6+gyZz1avgALEF2uL0DsRiHWU58OUEvSoldTG+YZHv2DQtdq9Wytqt9MrA4YY+D3jBT3S92MCrvz4WtPsVyU0xsY4wUgXdmKe/YyFGuTVkrCJoX5/pbY7kZ1znUJMDsVJK0AOQLMRi2EYYNWgmSL0i0yIKHj07EE8KVQvHpd+6oJNmHiNt52wF3vmulb+KifNswovDSGzVEmq3Zlq4DGZh15y9b/6NNKPoHOtR2gc/gpEGbRvw3PO1qb6AUUZYBJq8gifTOrUk3UFxqjodnDeWqsTNEVbZdq9upIr1dA2PPAdmE0SRCY7KCrWdFUTAYnkCF9v3er5AGMt7ZEOvDKfr+QTUeD05P+opNl5vFkYQFaS2RQA5yD7VHBt+Y2nss7zgXtKEbLxmz4969N4kQtyEORfGNeS/Il3sJ7Hw9ZG46OFjRwuxaWJJh6WTRfG43GWOsqR42OhNdIahA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(230373577357003)(230473577357003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(38100700002)(82960400001)(86362001)(36756003)(6636002)(316002)(66946007)(66476007)(54906003)(37006003)(66556008)(41300700001)(8936002)(8676002)(6862004)(4326008)(84970400001)(19627235002)(7416002)(5660300002)(30864003)(2906002)(6512007)(1076003)(26005)(2616005)(6666004)(966005)(6486002)(478600001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z+Gs/bJ/Jde3s+JRdgse/6IvYVM2Da3nINBSOIBLnNfHc7uRp8TUxrjwgr?=
 =?iso-8859-1?Q?IGItK4p9wIzXuObtuHoHOObuNdLl/yYsL/MHs4LYzS79r160MXSGeUOFgD?=
 =?iso-8859-1?Q?wWp6Sh4E9ZeWtloeCoQJW5p3781mUWxHS2JkrqKYFMGdmb0D4XVP1DGkI4?=
 =?iso-8859-1?Q?GKYyEi7wqgiPOTRw2ek4oAUHHm7omISET3oISgIsqq58PCWRVwwzG2DOeO?=
 =?iso-8859-1?Q?v2n+X7fYiCFGG73XxabY3Vrc1HtrEdT3RSuG+Xcys+wX+GnNoBZqMcIdUt?=
 =?iso-8859-1?Q?cHMRuRpTlij+XbHEItZmXgqzZy1ucPx8MC+F99wS44NcUszYk6y0JaqOG0?=
 =?iso-8859-1?Q?2D5ordE38o6wk+iV++ULoLbCUQaey2QH/+uu91tmIrrUV0Q2xHft4zKLhf?=
 =?iso-8859-1?Q?vTYYJGK9voAcU9SiB7l+Fi8Q8+Cl2LccQNtorKPHhXgrQv8U927cfFNqha?=
 =?iso-8859-1?Q?F9NmGMcC5xDyWbhKaVD4OJLpqJgR5ol8Zj8o4HY3fa1ouKUVvU+jTx9+w+?=
 =?iso-8859-1?Q?W6QjnkUfEqTcqDQYiGUn/+K8lr/18LHdxIffvwZbW14tiVkERDICBO6tTy?=
 =?iso-8859-1?Q?SDwh/OXgrW7a0GetHvG+LuHKyauyzzDfByzklSKenVR69b3CvQmTLEwpgt?=
 =?iso-8859-1?Q?V3z8AAGOic9/LJ2ioEtzgEUpu/Eu7thiwanpKeNZ0JR3u4jiTetgpcBk/p?=
 =?iso-8859-1?Q?ZGIqLwTsF50oAy8ivSt/hrJ5TUvKHmmlTGnlJcdqAR3RFH3misJQat3UIJ?=
 =?iso-8859-1?Q?Ameu0ln18n1wstsMNu32Zlg3ZwrtSCfBOtmmhBFWFFHiNpX9HTEQKwXbEe?=
 =?iso-8859-1?Q?5+he8HBho26PKbXL1Z6z547HlBpjbPDeVfpZ1x2JfwvS3D5DKp46BKi5Gw?=
 =?iso-8859-1?Q?doS9ZMV2Uix7qqRhe+8sIcGlWYWCLqOv6mxKDRYtVjk2cosyile+IDTOe4?=
 =?iso-8859-1?Q?DBdWsS6mdw/T1bBgT4+uAUzPgUmK9uCx5mD6CflOH4W7auis8A0dV6Vm35?=
 =?iso-8859-1?Q?uJ3u7rbWjqFdnek1JVqdgrsCOLvllTqS95097V3xePSwBIPMUp+nQz6nml?=
 =?iso-8859-1?Q?k/uKLiaW2S3YIYJGtr00wuYzRHcX4Xd5JcMPnLQz7/VkOb9o97lu8b+HsM?=
 =?iso-8859-1?Q?FnrCgTOz//3uCI3XcX9qHcsVszDn0t05KWODhVyF/HSccugfxggdCySDiq?=
 =?iso-8859-1?Q?awRAnhY3TQ6H1D59CzTrm4vluWQa5hpZjpktN5gYEeLYSxNWqvWt+lGi+M?=
 =?iso-8859-1?Q?xVBfrPYG3Ek6DnzsM2yjnKFvvkO8XXe5ujXB+Jb4B1CVeaptQSvea8xUgG?=
 =?iso-8859-1?Q?e+bozDNut02oXE2T6wqNmTSYPxidd+OHljvYilZPiCSgFSpR/JQ/bElDYK?=
 =?iso-8859-1?Q?p59ev9pnkwORnm9hvh0pIN6SikV+3Qf03bGU5oFN6Qorx5vv17SanT5v4x?=
 =?iso-8859-1?Q?qS2ohmQ0DGIPotSf/eljjhGkB+hWBL0TxfrHIQv15sdUrSWBtcTovHe7Bu?=
 =?iso-8859-1?Q?yONJkTooGIxI2duqk+Yr77H8Gpa1fQFX5/Nbda6g+6F5VSJLeUJR5fy8YD?=
 =?iso-8859-1?Q?29uOdC/NthS+nZxcFK1Itm4ZEub00GljPh+z75BpkWMncOcuSBktdErGBQ?=
 =?iso-8859-1?Q?WudXP0NC2SqHIOz2Ho/VKO6csYEwS3+fokPCWNXU8So9ofTFAUx7LLlQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e983eb01-8a9f-41c1-d48d-08dbebe192bb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:03:47.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwdJnJ+WrDenZqqsicCdZziGQURHhxDRqGwBLxs2nZfBmv7xDNjENXDU5QOmAxyiXcLSKtJXIpIPaSHX3R7paQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -4.7% regression of stress-ng.judy.ops_per_sec on:


commit: 6ccdcb6d3a741c4e005ca6ffd4a62ddf8b5bead3 ("mm, pcp: reduce detecting time of consecutive high order page freeing")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: cpu-cache
	test: judy
	disk: 1SSD
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.10MB.MB/sec 23.7% improvement                           |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | mode=development                                                                                |
|                  | nr_threads=100%                                                                                 |
|                  | test=TCP                                                                                        |
|                  | test_memory_size=50%                                                                            |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.file-ioctl.ops_per_sec -6.6% regression                                    |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
| test parameters  | class=filesystem                                                                                |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1SSD                                                                                       |
|                  | fs=btrfs                                                                                        |
|                  | nr_threads=10%                                                                                  |
|                  | test=file-ioctl                                                                                 |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311231029.3aa790-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231123/202311231029.3aa790-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  cpu-cache/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/judy/stress-ng/60s

commit: 
  57c0419c5f ("mm, pcp: decrease PCP high if free pages < high watermark")
  6ccdcb6d3a ("mm, pcp: reduce detecting time of consecutive high order page freeing")

57c0419c5f0ea2cc 6ccdcb6d3a741c4e005ca6ffd4a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.57 ±  5%     +46.8%       6.71 ± 17%  iostat.cpu.system
      2842            +1.0%       2871        turbostat.Bzy_MHz
      0.12 ±  3%      +0.4        0.55 ± 26%  mpstat.cpu.all.soft%
      3.05 ±  6%      +1.8        4.86 ± 20%  mpstat.cpu.all.sys%
  81120642            -2.9%   78746159        proc-vmstat.numa_hit
  80886548            -2.9%   78513494        proc-vmstat.numa_local
  82771023            -2.9%   80399459        proc-vmstat.pgalloc_normal
  82356596            -2.9%   79991041        proc-vmstat.pgfree
  12325708 ±  3%      +5.3%   12974746        perf-stat.i.dTLB-load-misses
      0.38 ± 44%     +27.2%       0.48        perf-stat.overall.cpi
    668.74 ± 44%     +24.7%     834.02        perf-stat.overall.cycles-between-cache-misses
      0.00 ± 45%      +0.0        0.01 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
  10040254 ± 44%     +26.0%   12650801        perf-stat.ps.dTLB-load-misses
   7036371 ±  3%      -2.8%    6842720        stress-ng.judy.Judy_delete_operations_per_sec
   9244466 ±  3%      -7.8%    8524505 ±  3%  stress-ng.judy.Judy_insert_operations_per_sec
      2912 ±  3%      -4.7%       2774        stress-ng.judy.ops_per_sec
     13316 ±  8%     +22.8%      16355 ± 13%  stress-ng.time.maximum_resident_set_size
    445.86 ±  5%     +64.2%     732.21 ± 15%  stress-ng.time.system_time
     40885 ± 40%    +373.8%     193712 ± 11%  sched_debug.cfs_rq:/.left_vruntime.avg
    465264 ± 31%    +142.5%    1128399 ±  5%  sched_debug.cfs_rq:/.left_vruntime.stddev
      8322 ± 34%    +140.8%      20039 ± 17%  sched_debug.cfs_rq:/.load.avg
     40886 ± 40%    +373.8%     193713 ± 11%  sched_debug.cfs_rq:/.right_vruntime.avg
    465274 ± 31%    +142.5%    1128401 ±  5%  sched_debug.cfs_rq:/.right_vruntime.stddev
    818.77 ± 10%     +43.3%       1172 ±  5%  sched_debug.cpu.curr->pid.stddev
      0.05 ± 74%    +659.6%       0.41 ± 35%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.10 ± 48%    +140.3%       0.24 ± 11%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 14%    +102.6%       0.03 ± 29%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ±122%   +1322.6%       0.65 ± 20%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      1.70 ± 79%    +729.3%      14.10 ± 48%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.08 ±101%    +233.4%       3.60 ±  7%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01 ±  8%     +54.7%       0.02 ± 18%  perf-sched.total_sch_delay.average.ms
      0.18 ±  5%    +555.7%       1.20 ± 38%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.21 ±  4%    +524.6%       1.29 ± 47%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    235.65 ± 31%     -57.0%     101.40 ± 17%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    127.50 ±100%    +126.3%     288.50 ±  9%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    125.83 ±144%    +407.2%     638.17 ± 27%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    344.50 ± 36%    +114.6%     739.33 ± 24%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.92 ±114%    +482.2%       5.38 ± 47%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      3.22 ± 89%    +223.9%      10.44 ± 50%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.18 ± 43%    +471.8%       1.01 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
     34.39 ± 46%     +88.8%      64.95 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.21 ± 13%    +813.6%       1.95 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      0.18 ± 15%    +457.1%       1.02 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
    417.61 ± 68%     -87.6%      51.85 ±146%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.22 ± 25%    +614.2%       1.57 ± 71%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.18 ±  5%    +556.3%       1.20 ± 38%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.21 ±  4%    +524.6%       1.29 ± 47%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     38.72 ± 39%     -53.1%      18.17 ± 30%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    235.60 ± 31%     -57.0%     101.37 ± 17%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.17 ± 30%     +45.3%       3.16 ± 13%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.02 ±131%    +574.3%       6.90 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.18 ±191%  +92359.0%     169.05 ±219%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     69.64 ± 44%     +33.2%      92.76 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.64 ± 67%    +653.6%       4.82 ± 54%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      1.75 ± 49%    +206.5%       5.38 ± 47%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      3.22 ± 89%    +223.9%      10.44 ± 50%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi


***************************************************************************************************
lkp-ivb-2ep1: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-12/performance/x86_64-rhel-8.3/development/100%/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/TCP/50%/lmbench3

commit: 
  57c0419c5f ("mm, pcp: decrease PCP high if free pages < high watermark")
  6ccdcb6d3a ("mm, pcp: reduce detecting time of consecutive high order page freeing")

57c0419c5f0ea2cc 6ccdcb6d3a741c4e005ca6ffd4a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.07 ± 38%    +105.0%       0.14 ± 32%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     26.75            -4.9%      25.45        turbostat.RAMWatt
    678809            +7.2%     727594 ±  2%  vmstat.system.cs
  97929782           -13.1%   85054266        numa-numastat.node0.local_node
  97933343           -13.1%   85056081        numa-numastat.node0.numa_hit
  97933344           -13.1%   85055901        numa-vmstat.node0.numa_hit
  97929783           -13.1%   85054086        numa-vmstat.node0.numa_local
     32188           +23.7%      39813        lmbench3.TCP.socket.bandwidth.10MB.MB/sec
    652.63            -4.4%     624.04        lmbench3.time.elapsed_time
    652.63            -4.4%     624.04        lmbench3.time.elapsed_time.max
      8597            -5.9%       8092        lmbench3.time.system_time
      0.88 ±  7%      -0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ± 10%      -0.1        0.61 ±  7%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.78 ±  3%      -0.1        0.70 ±  6%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.36 ±  9%      +0.1        0.42 ± 11%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.40 ± 10%      +0.1        0.48 ± 12%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.51 ±  4%      -0.1        0.44 ± 13%  perf-profile.self.cycles-pp.sock_read_iter
      0.36 ± 10%      +0.1        0.42 ± 11%  perf-profile.self.cycles-pp.skb_page_frag_refill
    158897 ±  2%      -6.8%     148107        proc-vmstat.nr_anon_pages
    160213 ±  2%      -6.8%     149290        proc-vmstat.nr_inactive_anon
    160213 ±  2%      -6.8%     149290        proc-vmstat.nr_zone_inactive_anon
 1.715e+08            -7.1%  1.593e+08        proc-vmstat.numa_hit
 1.715e+08            -7.1%  1.592e+08        proc-vmstat.numa_local
 1.367e+09            -7.1%   1.27e+09        proc-vmstat.pgalloc_normal
   2324641            -2.7%    2261187        proc-vmstat.pgfault
 1.367e+09            -7.1%   1.27e+09        proc-vmstat.pgfree
     77011            -4.4%      73597        proc-vmstat.pgreuse
      5.99 ±  3%     -29.9%       4.20 ±  4%  perf-stat.i.MPKI
 7.914e+09 ±  2%      +4.5%  8.271e+09        perf-stat.i.branch-instructions
  1.51e+08            +4.6%  1.579e+08        perf-stat.i.branch-misses
      7.65 ±  4%      -0.9        6.73 ±  3%  perf-stat.i.cache-miss-rate%
  66394790 ±  2%     -21.9%   51865866 ±  3%  perf-stat.i.cache-misses
    682132            +7.2%     731279 ±  2%  perf-stat.i.context-switches
      4.01           -16.0%       3.37        perf-stat.i.cpi
     71772 ±  4%     +11.5%      80055 ±  8%  perf-stat.i.cycles-between-cache-misses
 9.368e+09 ±  2%      +3.6%  9.706e+09        perf-stat.i.dTLB-stores
  33695419 ±  2%      +7.1%   36096466 ±  2%  perf-stat.i.iTLB-load-misses
    573897 ± 35%     -38.6%     352477 ± 19%  perf-stat.i.iTLB-loads
  4.09e+10 ±  2%      +4.5%  4.273e+10        perf-stat.i.instructions
      0.37            +4.3%       0.39        perf-stat.i.ipc
      0.09 ± 22%     -44.0%       0.05 ± 26%  perf-stat.i.major-faults
    490.16 ±  2%      -8.6%     448.21 ±  2%  perf-stat.i.metric.K/sec
    635.38 ±  2%      +3.5%     657.46        perf-stat.i.metric.M/sec
     37.54            +2.3       39.84        perf-stat.i.node-load-miss-rate%
   8300835 ±  2%     -10.8%    7406820 ±  2%  perf-stat.i.node-load-misses
  76993977 ±  3%      -6.6%   71936169 ±  3%  perf-stat.i.node-loads
     26.58 ±  4%      +4.1       30.71 ±  3%  perf-stat.i.node-store-miss-rate%
   2341211 ±  4%     -29.6%    1648802 ±  3%  perf-stat.i.node-store-misses
  34198780 ±  3%     -33.2%   22857201 ±  3%  perf-stat.i.node-stores
      1.63           -25.5%       1.21 ±  3%  perf-stat.overall.MPKI
     10.67            -2.3        8.36        perf-stat.overall.cache-miss-rate%
      2.83            -5.2%       2.69        perf-stat.overall.cpi
      1740           +27.3%       2216 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.35            +5.5%       0.37        perf-stat.overall.ipc
      9.73            -0.4        9.34        perf-stat.overall.node-load-miss-rate%
      6.39            +0.3        6.72        perf-stat.overall.node-store-miss-rate%
 7.914e+09 ±  2%      +4.6%  8.276e+09        perf-stat.ps.branch-instructions
 1.509e+08            +4.7%  1.579e+08        perf-stat.ps.branch-misses
  66615187 ±  2%     -22.1%   51881477 ±  3%  perf-stat.ps.cache-misses
    679734            +7.2%     729007 ±  2%  perf-stat.ps.context-switches
 9.369e+09 ±  2%      +3.7%  9.712e+09        perf-stat.ps.dTLB-stores
  33673038 ±  2%      +7.2%   36098564 ±  2%  perf-stat.ps.iTLB-load-misses
  4.09e+10 ±  2%      +4.6%  4.276e+10        perf-stat.ps.instructions
      0.09 ± 23%     -44.4%       0.05 ± 26%  perf-stat.ps.major-faults
   8328473 ±  2%     -11.0%    7410272 ±  2%  perf-stat.ps.node-load-misses
  77301667 ±  3%      -6.9%   71997671 ±  3%  perf-stat.ps.node-loads
   2344250 ±  4%     -29.7%    1647553 ±  3%  perf-stat.ps.node-store-misses
  34315831 ±  3%     -33.4%   22865994 ±  3%  perf-stat.ps.node-stores



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/file-ioctl/stress-ng/60s

commit: 
  57c0419c5f ("mm, pcp: decrease PCP high if free pages < high watermark")
  6ccdcb6d3a ("mm, pcp: reduce detecting time of consecutive high order page freeing")

57c0419c5f0ea2cc 6ccdcb6d3a741c4e005ca6ffd4a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    127.00 ± 10%     +36.1%     172.83 ± 15%  perf-c2c.HITM.local
      0.00 ± 72%    +130.4%       0.01 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_clone_files
     14.83 ± 19%     +33.7%      19.83 ± 10%  sched_debug.cpu.nr_uninterruptible.max
    339939            -6.6%     317593        stress-ng.file-ioctl.ops
      5665            -6.6%       5293        stress-ng.file-ioctl.ops_per_sec
      6444 ±  4%     -25.2%       4820 ±  5%  stress-ng.time.involuntary_context_switches
  89198237            -6.5%   83411572        proc-vmstat.numa_hit
  89117176            -6.8%   83056324        proc-vmstat.numa_local
  92833230            -6.6%   86743293        proc-vmstat.pgalloc_normal
  92791999            -6.6%   86700599        proc-vmstat.pgfree
      0.25 ± 56%    +110.2%       0.53 ± 12%  perf-stat.i.major-faults
    127575 ± 27%    +138.3%     303957 ±  3%  perf-stat.i.node-stores
      0.25 ± 56%    +110.2%       0.52 ± 12%  perf-stat.ps.major-faults
    125751 ± 27%    +138.3%     299653 ±  3%  perf-stat.ps.node-stores
 1.199e+12            -2.1%  1.174e+12        perf-stat.total.instructions
     15.80            -0.7       15.14        perf-profile.calltrace.cycles-pp.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
     15.46            -0.6       14.84        perf-profile.calltrace.cycles-pp.btrfs_read_folio.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      9.84            -0.5        9.32        perf-profile.calltrace.cycles-pp.memcmp.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range
     11.95            -0.4       11.52        perf-profile.calltrace.cycles-pp.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      8.72 ±  2%      -0.4        8.28        perf-profile.calltrace.cycles-pp.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      5.56 ±  2%      -0.4        5.18        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      0.64 ± 10%      -0.3        0.36 ± 71%  perf-profile.calltrace.cycles-pp.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate
      2.57 ±  5%      -0.3        2.29 ±  2%  perf-profile.calltrace.cycles-pp.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.44 ±  6%      -0.3        2.17 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
      2.53 ±  5%      -0.3        2.26 ±  2%  perf-profile.calltrace.cycles-pp.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  9%      -0.2        0.46 ± 45%  perf-profile.calltrace.cycles-pp.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate
      1.42 ±  3%      -0.1        1.31 ±  4%  perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range
      0.70 ±  4%      -0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.69 ±  4%      -0.1        0.63 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
     29.90            +0.6       30.49        perf-profile.calltrace.cycles-pp.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range
      0.00            +0.9        0.86 ±  6%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
     68.10            +1.2       69.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     68.47            +1.2       69.68        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     67.35            +1.2       68.59        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     21.54 ±  3%      +1.5       23.02        perf-profile.calltrace.cycles-pp.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.51 ±  3%      +1.5       23.00        perf-profile.calltrace.cycles-pp.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
     21.46 ±  3%      +1.5       22.94        perf-profile.calltrace.cycles-pp.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl
     21.53 ±  3%      +1.5       23.01        perf-profile.calltrace.cycles-pp.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00            +1.5        1.49 ±  3%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_commit.free_unref_page.btrfs_clone
     21.15 ±  3%      +1.5       22.66        perf-profile.calltrace.cycles-pp.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone
     64.61            +1.5       66.16        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.66 ±  2%      +1.8        4.51 ±  3%  perf-profile.calltrace.cycles-pp.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      0.97 ±  3%      +1.8        2.82 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc.do_read_cache_folio
      2.02 ±  3%      +1.9        3.90 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      1.27 ±  2%      +1.9        3.17 ±  4%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.35 ± 70%      +2.0        2.31 ±  5%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc
      0.00            +2.0        2.00 ±  4%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      1.72 ±  2%      +2.1        3.78        perf-profile.calltrace.cycles-pp.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range
      0.00            +2.1        2.09 ±  2%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.btrfs_clone.btrfs_clone_files
      0.00            +2.1        2.12 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range
      0.00            +2.1        2.14 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
     15.81            -0.7       15.15        perf-profile.children.cycles-pp.filemap_read_folio
     15.47            -0.6       14.86        perf-profile.children.cycles-pp.btrfs_read_folio
      9.89            -0.5        9.38        perf-profile.children.cycles-pp.memcmp
     11.98            -0.4       11.54        perf-profile.children.cycles-pp.btrfs_do_readpage
      8.74 ±  2%      -0.4        8.30        perf-profile.children.cycles-pp.filemap_add_folio
      9.73 ±  3%      -0.4        9.35        perf-profile.children.cycles-pp.__clear_extent_bit
      5.66 ±  2%      -0.4        5.30        perf-profile.children.cycles-pp.__filemap_add_folio
      2.45 ±  6%      -0.3        2.17 ±  2%  perf-profile.children.cycles-pp.btrfs_fallocate
      2.57 ±  5%      -0.3        2.29 ±  2%  perf-profile.children.cycles-pp.ioctl_preallocate
      2.53 ±  5%      -0.3        2.26 ±  2%  perf-profile.children.cycles-pp.vfs_fallocate
      4.67 ±  2%      -0.3        4.41 ±  3%  perf-profile.children.cycles-pp.__set_extent_bit
      4.83 ±  2%      -0.3        4.58 ±  3%  perf-profile.children.cycles-pp.lock_extent
      5.06 ±  2%      -0.2        4.82 ±  2%  perf-profile.children.cycles-pp.alloc_extent_state
      4.11 ±  2%      -0.2        3.94 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.37 ±  4%      -0.1        1.25 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.66 ±  9%      -0.1        0.54 ±  6%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.64 ± 10%      -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.find_free_extent
      0.96 ±  4%      -0.1        0.87 ±  6%  perf-profile.children.cycles-pp.__wake_up
      0.62 ±  4%      -0.1        0.54 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      1.20 ±  4%      -0.1        1.12 ±  3%  perf-profile.children.cycles-pp.free_extent_state
      0.99 ±  3%      -0.1        0.92 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.89 ±  3%      -0.1        0.81 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.69 ±  4%      -0.1        0.64 ±  4%  perf-profile.children.cycles-pp.btrfs_punch_hole
      0.12 ± 10%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.__fget_light
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.calc_available_free_space
      0.29 ±  8%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.09 ± 17%      +0.2        0.25 ±  6%  perf-profile.children.cycles-pp.__kmalloc_node
      0.09 ± 15%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.kvmalloc_node
      0.08 ± 11%      +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.__kmalloc_large_node
      0.24 ± 13%      +0.2        0.41 ±  4%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.32 ± 15%      +0.6        0.91 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     30.03            +0.6       30.64        perf-profile.children.cycles-pp.do_read_cache_folio
      1.10 ±  4%      +0.6        1.72 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.58 ±  6%      +0.9        1.50 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
     67.36            +1.2       68.60        perf-profile.children.cycles-pp.__x64_sys_ioctl
     21.52 ±  3%      +1.5       23.00        perf-profile.children.cycles-pp.do_clone_file_range
     21.54 ±  3%      +1.5       23.02        perf-profile.children.cycles-pp.ioctl_file_clone
     21.53 ±  3%      +1.5       23.01        perf-profile.children.cycles-pp.vfs_clone_file_range
     21.16 ±  3%      +1.5       22.66        perf-profile.children.cycles-pp.btrfs_clone_files
      0.00            +1.5        1.52 ±  3%  perf-profile.children.cycles-pp.__free_one_page
     64.61            +1.5       66.16        perf-profile.children.cycles-pp.do_vfs_ioctl
     64.16            +1.5       65.71        perf-profile.children.cycles-pp.btrfs_remap_file_range
      2.68 ±  3%      +1.8        4.52 ±  3%  perf-profile.children.cycles-pp.folio_alloc
      0.54 ±  6%      +2.0        2.51 ±  5%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.03 ±  3%      +2.0        3.04 ±  5%  perf-profile.children.cycles-pp.rmqueue
      2.16 ±  3%      +2.0        4.19 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      1.32 ±  2%      +2.1        3.42 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +2.1        2.10 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      2.66 ±  2%      +2.1        4.77        perf-profile.children.cycles-pp.btrfs_clone
      0.03 ±100%      +2.1        2.17 ±  2%  perf-profile.children.cycles-pp.free_unref_page
      0.40 ±  6%      +2.2        2.55 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +2.2        2.21 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      9.82            -0.5        9.32        perf-profile.self.cycles-pp.memcmp
      0.84 ±  5%      -0.1        0.76 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.13 ±  4%      -0.1        1.05 ±  2%  perf-profile.self.cycles-pp.free_extent_state
      0.99 ±  3%      -0.1        0.92 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.22 ±  8%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.find_free_extent
      0.38 ±  4%      -0.1        0.32 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.12 ± 10%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__fget_light
      0.06 ±  7%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.07 ± 15%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.folio_alloc
      0.28 ± 10%      +0.1        0.36 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.26 ±  8%      +0.1        0.36 ±  4%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.22 ± 14%      +0.2        0.38 ±  5%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.00            +0.2        0.24 ±  6%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.32 ± 15%      +0.6        0.91 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.6        0.62 ± 10%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.55 ±  6%      +0.9        1.46 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.00            +1.3        1.32 ±  4%  perf-profile.self.cycles-pp.__free_one_page





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

