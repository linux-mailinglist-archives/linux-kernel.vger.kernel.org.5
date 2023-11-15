Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB567EC44D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjKOOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbjKOOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:02:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36843C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700056919; x=1731592919;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=a/VsRogNl5tMg648PPhUCQAPR4gtJqEzwPk2t4w09go=;
  b=GlznCJIO67uRcCSRSm2k2lmJNEhWkSe2gF3vfQ/IEnuOMiJVu3qv1eBu
   wt7ZgyErf5lyTWVQxyWUPo8wIv7li1rceZj5SzSfem3K5a8QEqDVDW1My
   O7kE4dgDQ++/2xdCnbTVsG6dpNQAq6QSK0KfIprdFxMjk3Xekvddaj3RS
   90WG220ngtELWnT6S5P+DdkDGkrC/zOPk9JprH2otAdyM93fXvqa93cPK
   4e9zHyFb4GZ+q1HrJviX2AjJdsVObp6/v0vp/0XrGCRAIum/Ks0X2KfVg
   Q6z/Mj7VgJLqgCPvxbyZw83uKYRAjnh+R5IChn50Jv1SD6FxyMCVlT9DG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="455169582"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="455169582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="794161737"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="794161737"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 06:01:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 06:01:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 06:01:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 06:01:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 06:01:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHyTT1DeWoXBIDgVqIXJ56KTgGE6FLV5FrmPrWstOngcYulTc+7VsSlMb843bMmWXGdvF0YVzAiKgNBWSklh0xtbMVcoaHkUNejDZKVYgRSXNXxtPoQaK5H8lAQYbCGDPuWbzXD4lTE7kUkSl4U8eAqrS3P0TwoYT63uUedTT9ActlejW6re3+jRFfaY1ax6HnV0OLme5BQgqH4yxWItCS2/Ez17jt+1XyWgpuxP2ICSr+IxbLNz3tu6UjF7UbmNriRf4Ccs47x3jpbJM8MZ5vY9r6aJ84QaXlSvA3HAST92YLBZyHz9dF+eEv23h+fMRbFvWP4o4dZpt75WHeIRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2B/HcJk5a+9uhqQz52c+u8ksgeu7s4N4Xbra2EhiA=;
 b=RIF5kW8jLBSE91WzRg9VQQ2mUumNFaw6X5CSW+aIK/B/nE3cqu/LlxpVyMpsQSKl1a/0f9elp4Kn9sBBxpKJIWKHhweqe7a8xnX0wl2n1XGErYpvnKL8Imin/XMalOUa3swo8M5PElcAkdALxuvahVEY8HBbK4/whC7SpFr1hRYW2uQRkrk6/5zwezg3J5w0zCiC9SAmDLkvLRZVihtpeixHLm/aEUnsXFGG7XI51NHP7bUNabWDZRIHSh6j449/HGH1xV60gPeSUEF7IIpXOdVSzsUuWHl2hm8PgqJTUw/TXrW+XSfEErk1QOL5nfMdDu71HgBrbnZSd8C2IezVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 14:01:53 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 14:01:53 +0000
Date:   Wed, 15 Nov 2023 22:01:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  12214eba19:  vm-scalability.throughput 49.5%
 improvement
Message-ID: <202311151633.ee9bb41f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1c6075-22f2-4d2a-85f9-08dbe5e36b8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/dOTAV7cUOamF3q05Xx/zCngv8ccN71lkw4Qsqxm7Dcl2GOfnS1Ou71tkBPWrK3yz/Kh8to3IXBjTFHQJXK+x5NRkjnADcWxGE/7bDiOQtCYD7tsEfbyTmEtSvcV49I9EBWBl8U63YsXcS8U027NA7sxtpLglEuPqPNAPhmyfRAt0359jv6Fr/OOcPAI365seMuf1AnJJg6MqWuAsIoON9OgTblGvooSmyQ6ZnRXq6nAqJTjosj51Y283Eciu5Fop3BCnxRcwB+DIaodmgyN4aDEUqFIHa4gLvg+OhDNsfAXhbXg/VrI/c6rzH3O2CWwsZmdVJgyDZHTi8iwUu5USQEFwJ19JisjdpH0OON9b+fi1PM7MnGMvtbS0hImbmQ4Rc8S+DAGT3HDSra3BKqTAZrqEWpv/CTjFq1xnIS6MAXAlf1V+rKlOdd6Gq8w9TT/SfcuzINhMR6QUwnxVwOBmYS/oguYr871GoRLUZXdzJTUdFuWMJA64f2aaRBowRWlNuqbKyIfmS23biHOqtvgWDlEPPJodGkS1f3AYKM3HMIw7oyGZfUFRSigM6rU51uWN+rYMf2lRqu9a58BhNvybTOdueP5XZjIjm84/SM2xSFuVrcTgzjqr/clxmqPltGxv5zyf93PPpeCNhJXAP5Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230373577357003)(230922051799003)(230473577357003)(64100799003)(451199024)(1800799009)(186009)(8936002)(8676002)(54906003)(2906002)(30864003)(5660300002)(4326008)(6486002)(83380400001)(966005)(6916009)(66476007)(478600001)(36756003)(66946007)(316002)(86362001)(82960400001)(38100700002)(66556008)(6506007)(6666004)(19627235002)(41300700001)(2616005)(107886003)(26005)(1076003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z35xhDRDSZ/TF7Z18/ZbVGnP3+Kiyb7cR0Rg4CR0k6a4FHA6g4WNq7poeC?=
 =?iso-8859-1?Q?NzKG1HGKs1jAZrQcf3LLrPO6OrOr/MLRmUo/uasrUPpnVrR6i15TswNb4N?=
 =?iso-8859-1?Q?nHkEr/KKCnPB0xcc+5wsQNQ2uaS0cjOjMgSQpZ2pg3AfLKuy/tRwUzIbvb?=
 =?iso-8859-1?Q?uxY06aLXShachgXlcwMj6tpladJcUruiuyPFG8sexj4wZ4hysF2JedjQz7?=
 =?iso-8859-1?Q?1q0xOHcL432pMs9CO9fnRYXAtSfrtuJq8IOOp+9S7efE0/DG8O5aGBi3+9?=
 =?iso-8859-1?Q?Uj8/Uo8D3ZFFY4CdMpI9v8kAg3vWNx1HckqX5czYv7yr6shG0InWa2MyIu?=
 =?iso-8859-1?Q?mMTYpCLnoYvjjSp3np59wwO8Kw48nOVW2J7dW/l+X1JegpgeKLpD21HwSv?=
 =?iso-8859-1?Q?KhNQxtc5KUdKU5toPIsXwjDe1JGewAorh9Ppv7Sb/8RYX0blckADIuztcg?=
 =?iso-8859-1?Q?dDpz5iFwsfrTJezuJpihBluDVof7PnaZpRV3DjeKzYj0YpYxBiSmB7Csh9?=
 =?iso-8859-1?Q?6hSC1PdREP04XozwWa+5ZuEwTD3L39bQZnIDY4mZq9x13ywgzA7oj17JDi?=
 =?iso-8859-1?Q?bHZgCF7bZOiR6b9Sk1ijBcufhdaB/16KLe9O/bNuyClSjGVFmq4uTwok8s?=
 =?iso-8859-1?Q?AZsiqSk7lXofsuhGowHBEpNVBr+hjTs+qAHYnqsYQz/PbKK1nRrp0xTrL3?=
 =?iso-8859-1?Q?CLkZZmUaQizIexMdAcadv4ZFBs8hA1yDCdJZOrzUEkV2WrLajnH4SiTg9n?=
 =?iso-8859-1?Q?8YhlkPRuE4Jkpay4zFpMVc6jHBS7AKzwlEmkWgv/4SgbMKTrIv2axxuI+1?=
 =?iso-8859-1?Q?N4jMEQcCfUEykCTIRmC3oSZUXriv0qIaiRiJ4pFuxFekSIxyhxJNzweN0f?=
 =?iso-8859-1?Q?Q8zunxYS3tIb0JgaXMvyC2Gzh91C8naN4TrQ1F/82W9a2pXXPiB5nrPghV?=
 =?iso-8859-1?Q?Fga58nL8Ixp9S+KlVecx+/Elfd+17i148NPBSqVpLoLIAWMS09u08mw+wh?=
 =?iso-8859-1?Q?DHy0iyKmNiZDNNC9Pq88cgD2bCbqA+KN3vLpCgR7/DUx/A2mFp3Z4qlMFh?=
 =?iso-8859-1?Q?8ssuUQMty7r2h/Y5OxXT9T3h4FwgnipL5jgoKNTsdVsSBTvW+DmHowiows?=
 =?iso-8859-1?Q?YH4L14IZ2Bh/rVLPmKhV6TrTjp8LO519kNccQag9BotBo1QepBgGgqDkAj?=
 =?iso-8859-1?Q?ESOSUc3BWbp2mbE0oyhoYEHlRVIgd9AIuXnG90h4HBK1vDXHVs9LE9yCov?=
 =?iso-8859-1?Q?VYzLr7R7ia56dMSQh+HAlHesnEoFzBypuxMG5lxWa56otPSciyzH5+6q+x?=
 =?iso-8859-1?Q?gTfvXBYDecmjOQYoY5pPoEHuSm+nEIs3v8U7aWoVFytJ6ElrOBhSq7dgNs?=
 =?iso-8859-1?Q?iyBKvXs5p/0x7jd/HexAE85OWFI9/F/FIcyn1nClTD9hEvmLKmSoUnGg6f?=
 =?iso-8859-1?Q?+kcWpKDI0fEm+KfcCucjFSG6JVQZkD4PrNmhhjOu7UE53mYZm2ibeRDf2o?=
 =?iso-8859-1?Q?GoM1AIMW3T0OpV3eHozNnc0TWr007P9poN+7EhxMSU4pa7pYOecEcl60Nz?=
 =?iso-8859-1?Q?NN+D4XnY8BiXZvyaSApw3kbbA4JHJNEN6E0SjUSdihxH/mauqbcXecGGS8?=
 =?iso-8859-1?Q?OTT2r89DSYIyS8UVLe6nzStA1Z68sdBxbhrwVUAnQDnlxyCBpAQuu5Lg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1c6075-22f2-4d2a-85f9-08dbe5e36b8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:01:53.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3kzLzgfqn9z9tOQlIFQXc73o7NavF5099QzHvPeV+I9cJeE/7QQg+Eq7fnGCk1X+E/SoxYeqDaXe6G+6gGqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 49.5% improvement of vm-scalability.throughput on:


commit: 12214eba1992642eee5813a9cc9f626e5b2d1815 ("mm: handle read faults under the VMA lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 2T
	test: shm-pread-seq
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/





Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231115/202311151633.ee9bb41f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/2T/lkp-cpl-4sp2/shm-pread-seq/vm-scalability

commit: 
  4de8c93a47 ("mm: handle COW faults under the VMA lock")
  12214eba19 ("mm: handle read faults under the VMA lock")

4de8c93a4751e107 12214eba1992642eee5813a9cc9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     25.26           +80.3%      45.55 ±  4%  vm-scalability.free_time
    166309           +49.5%     248702 ±  2%  vm-scalability.median
      0.06 ± 17%      -0.0        0.04 ± 28%  vm-scalability.stddev%
  37253200           +49.5%   55709403 ±  2%  vm-scalability.throughput
    329.93            +6.8%     352.34        vm-scalability.time.elapsed_time
    329.93            +6.8%     352.34        vm-scalability.time.elapsed_time.max
    204399           +15.0%     235056 ±  3%  vm-scalability.time.involuntary_context_switches
  37504320           +66.1%   62277600 ±  3%  vm-scalability.time.maximum_resident_set_size
 7.573e+08           +64.6%  1.247e+09        vm-scalability.time.minor_page_faults
     60103            +4.7%      62934        vm-scalability.time.system_time
      2677           +65.6%       4434 ±  3%  vm-scalability.time.user_time
 2.907e+08           +41.7%  4.119e+08 ±  2%  vm-scalability.time.voluntary_context_switches
 1.119e+10           +49.6%  1.674e+10 ±  2%  vm-scalability.workload
 2.561e+08           +42.2%  3.642e+08 ±  7%  cpuidle..usage
 1.905e+08           +17.7%  2.241e+08 ± 14%  turbostat.C1
      0.05 ±  9%     +34.2%       0.06 ±  7%  turbostat.IPC
 3.103e+08           +21.1%  3.758e+08 ±  8%  turbostat.IRQ
  65396804          +113.9%  1.399e+08 ±  3%  turbostat.POLL
   4592731           +77.5%    8150136 ±  7%  meminfo.Active
   4592558           +77.5%    8149968 ±  7%  meminfo.Active(anon)
    199212           +16.2%     231560 ±  4%  meminfo.KReclaimable
    199212           +16.2%     231560 ±  4%  meminfo.SReclaimable
  38088314           +66.4%   63396415 ± 14%  meminfo.max_used_kB
    656.00 ±  4%     +14.8%     753.38        perf-c2c.DRAM.local
     19685 ±  4%     +33.2%      26225 ±  2%  perf-c2c.DRAM.remote
     11307 ±  4%     +24.5%      14073 ±  2%  perf-c2c.HITM.local
     10620 ±  4%     +37.2%      14571 ±  2%  perf-c2c.HITM.remote
     21927 ±  4%     +30.6%      28644 ±  2%  perf-c2c.HITM.total
   1274254           +51.6%    1931316 ± 16%  sched_debug.cpu.nr_switches.avg
   1330622           +52.2%    2024967 ± 16%  sched_debug.cpu.nr_switches.max
   1169737           +49.4%    1747634 ± 17%  sched_debug.cpu.nr_switches.min
     23313 ±  3%     +56.5%      36484 ± 15%  sched_debug.cpu.nr_switches.stddev
   -601.85          +106.5%      -1243        sched_debug.cpu.nr_uninterruptible.min
    190.78 ± 10%     +52.0%     290.04 ± 20%  sched_debug.cpu.nr_uninterruptible.stddev
   4361232 ±  3%     +61.0%    7021897 ±  6%  numa-numastat.node0.local_node
   4423736 ±  3%     +61.0%    7120683 ±  6%  numa-numastat.node0.numa_hit
     62510 ± 63%     +58.0%      98777 ± 22%  numa-numastat.node0.other_node
   4186176 ±  3%     +58.7%    6642324 ±  3%  numa-numastat.node1.local_node
   4275058 ±  3%     +57.2%    6720332 ±  3%  numa-numastat.node1.numa_hit
   4281988 ±  2%     +55.5%    6658287 ±  5%  numa-numastat.node2.local_node
   4377154 ±  2%     +53.9%    6736235 ±  5%  numa-numastat.node2.numa_hit
   4970732 ±  2%     +57.9%    7846573 ±  6%  numa-numastat.node3.local_node
   5072257 ±  2%     +56.5%    7939683 ±  6%  numa-numastat.node3.numa_hit
    589678 ± 48%    +138.8%    1408222 ± 29%  numa-meminfo.node0.Active
    589604 ± 48%    +138.8%    1408190 ± 29%  numa-meminfo.node0.Active(anon)
   6000866 ± 20%     +62.5%    9750086 ± 11%  numa-meminfo.node0.FilePages
  39362890 ±  3%     -13.1%   34215245 ±  4%  numa-meminfo.node0.MemFree
   8676149 ± 15%     +59.3%   13823794 ± 12%  numa-meminfo.node0.MemUsed
   5279360 ±  6%     +69.0%    8923256 ± 17%  numa-meminfo.node0.Shmem
   2542157 ±  6%     +64.7%    4186028 ± 10%  numa-meminfo.node3.Active
   2542137 ±  6%     +64.7%    4185981 ± 10%  numa-meminfo.node3.Active(anon)
    148212 ± 27%     +62.1%     240250 ± 13%  numa-meminfo.node3.AnonPages.max
   7275379 ±  4%     +65.1%   12011702 ± 17%  numa-meminfo.node3.FilePages
   7134785 ±  3%     +58.2%   11290575 ± 13%  numa-meminfo.node3.Shmem
   1147703           +77.4%    2036461 ±  7%  proc-vmstat.nr_active_anon
     49805           +16.2%      57887 ±  4%  proc-vmstat.nr_slab_reclaimable
   1147703           +77.4%    2036461 ±  7%  proc-vmstat.nr_zone_active_anon
  18151336           +57.1%   28520631 ±  3%  proc-vmstat.numa_hit
  17803254           +58.2%   28172774 ±  3%  proc-vmstat.numa_local
   9636459           +65.9%   15986667 ±  2%  proc-vmstat.pgactivate
  18367048           +56.5%   28743362 ±  3%  proc-vmstat.pgalloc_normal
 7.591e+08           +64.5%  1.249e+09        proc-vmstat.pgfault
  17245013           +58.6%   27346493 ±  3%  proc-vmstat.pgfree
    178502 ±  2%     +13.2%     202009 ±  5%  proc-vmstat.pgreuse
   3501024 ±  5%     +20.8%    4230646 ± 28%  proc-vmstat.unevictable_pgs_scanned
      0.01           -28.6%       0.01        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      0.01 ±  9%     -19.8%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.08 ±  7%     -26.2%       0.06 ±  5%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     78.73 ±  6%     -20.7%      62.43 ±  7%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      0.01           -26.8%       0.01 ±  6%  perf-sched.total_sch_delay.average.ms
      0.65           -26.2%       0.48 ±  3%  perf-sched.total_wait_and_delay.average.ms
   3413581           +36.5%    4660142 ±  2%  perf-sched.total_wait_and_delay.count.ms
      0.64           -26.2%       0.47 ±  2%  perf-sched.total_wait_time.average.ms
      0.03           -29.6%       0.02        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
   3399862           +36.6%    4645123 ±  2%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      0.16 ±198%     -82.6%       0.03 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.02           -30.5%       0.02        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
    147244 ± 48%    +139.0%     351869 ± 29%  numa-vmstat.node0.nr_active_anon
   1499808 ± 20%     +62.6%    2438217 ± 11%  numa-vmstat.node0.nr_file_pages
   9840486 ±  3%     -13.1%    8551977 ±  4%  numa-vmstat.node0.nr_free_pages
   1319431 ±  6%     +69.1%    2231510 ± 17%  numa-vmstat.node0.nr_shmem
    147241 ± 48%    +139.0%     351866 ± 29%  numa-vmstat.node0.nr_zone_active_anon
   4423747 ±  3%     +61.0%    7120789 ±  6%  numa-vmstat.node0.numa_hit
   4361243 ±  3%     +61.0%    7022004 ±  6%  numa-vmstat.node0.numa_local
     62510 ± 63%     +58.0%      98776 ± 22%  numa-vmstat.node0.numa_other
   4275031 ±  3%     +57.2%    6720401 ±  3%  numa-vmstat.node1.numa_hit
   4186150 ±  3%     +58.7%    6642392 ±  3%  numa-vmstat.node1.numa_local
   4377220 ±  2%     +53.9%    6736168 ±  5%  numa-vmstat.node2.numa_hit
   4282054 ±  2%     +55.5%    6658220 ±  5%  numa-vmstat.node2.numa_local
    635357 ±  6%     +64.6%    1046089 ± 10%  numa-vmstat.node3.nr_active_anon
   1818439 ±  4%     +65.2%    3003397 ± 17%  numa-vmstat.node3.nr_file_pages
   1783291 ±  3%     +58.3%    2823116 ± 13%  numa-vmstat.node3.nr_shmem
    635354 ±  6%     +64.6%    1046084 ± 10%  numa-vmstat.node3.nr_zone_active_anon
   5072172 ±  2%     +56.5%    7939769 ±  6%  numa-vmstat.node3.numa_hit
   4970647 ±  2%     +57.9%    7846659 ±  6%  numa-vmstat.node3.numa_local
     42.17            -3.8       38.39 ± 16%  perf-stat.i.cache-miss-rate%
      7.60            -4.8%       7.24 ±  5%  perf-stat.i.cpi
     49.99            +4.2       54.23        perf-stat.i.iTLB-load-miss-rate%
      0.16           +40.4%       0.23 ±  2%  perf-stat.i.ipc
      0.09 ± 35%     -53.9%       0.04 ± 59%  perf-stat.i.major-faults
    904.06           +13.2%       1023 ±  2%  perf-stat.i.metric.K/sec
      4.24           -22.9%       3.27 ±  2%  perf-stat.overall.MPKI
      0.38            -0.1        0.28 ±  2%  perf-stat.overall.branch-miss-rate%
     43.12            -2.6       40.52        perf-stat.overall.cache-miss-rate%
      6.30           -29.9%       4.42        perf-stat.overall.cpi
      1485            -9.1%       1350        perf-stat.overall.cycles-between-cache-misses
      0.05 ±  2%      -0.0        0.05 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.04            +0.0        0.04        perf-stat.overall.dTLB-store-miss-rate%
     47.06            +2.5       49.59        perf-stat.overall.iTLB-load-miss-rate%
     10804           +21.8%      13154 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.16           +42.7%       0.23        perf-stat.overall.ipc
      3579            +3.8%       3716        perf-stat.overall.path-length
      0.09 ± 34%     -52.5%       0.04 ± 59%  perf-stat.ps.major-faults
 4.007e+13           +55.3%  6.222e+13 ±  2%  perf-stat.total.instructions
     63.05           -10.1       52.95        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     36.62            -9.6       27.00        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
     82.71            -3.4       79.30        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     83.18            -3.3       79.84        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     83.58            -3.3       80.25        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     83.60            -3.3       80.28        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     82.20            -3.3       78.88        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     82.21            -3.3       78.89        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     83.97            -3.1       80.83        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     15.72            -2.1       13.60 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     85.23            -1.6       83.61        perf-profile.calltrace.cycles-pp.do_access
      8.88            -1.2        7.64 ±  4%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.99            +0.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.filemap_map_pages.do_read_fault.do_fault
      1.21            +0.1        1.32 ±  3%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.37 ±  3%      +0.2        1.54 ±  3%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      1.38 ±  3%      +0.2        1.55 ±  3%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.51            +0.3        0.78        perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     14.54            +0.5       15.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_wake_bit.filemap_map_pages.do_read_fault
     14.96            +0.5       15.47        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_read_fault.do_fault.__handle_mm_fault
     16.57            +0.6       17.17        perf-profile.calltrace.cycles-pp.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.53            +0.7        2.25 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      2.08            +1.4        3.50 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.37            +2.2        5.59 ±  3%  perf-profile.calltrace.cycles-pp.do_rw_once
      6.18            +2.3        8.43        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      6.44            +2.4        8.79        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault
      5.34            +2.9        8.24        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_wake_bit.do_read_fault.do_fault
      9.41            +2.9       12.33        perf-profile.calltrace.cycles-pp.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      5.46            +3.0        8.45        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault
      5.95            +3.3        9.21        perf-profile.calltrace.cycles-pp.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     11.51            +3.9       15.42        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
     11.67            +3.9       15.62        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     11.69            +4.0       15.64        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     63.06           -10.1       52.95        perf-profile.children.cycles-pp.filemap_map_pages
     36.64            -9.6       27.01        perf-profile.children.cycles-pp.next_uptodate_folio
     82.71            -3.4       79.30        perf-profile.children.cycles-pp.__handle_mm_fault
     83.19            -3.3       79.85        perf-profile.children.cycles-pp.handle_mm_fault
     83.59            -3.3       80.26        perf-profile.children.cycles-pp.do_user_addr_fault
     83.60            -3.3       80.28        perf-profile.children.cycles-pp.exc_page_fault
     82.20            -3.3       78.89        perf-profile.children.cycles-pp.do_read_fault
     82.21            -3.3       78.90        perf-profile.children.cycles-pp.do_fault
     83.98            -3.1       80.85        perf-profile.children.cycles-pp.asm_exc_page_fault
     86.13            -1.8       84.34        perf-profile.children.cycles-pp.do_access
      8.91            -1.2        7.67 ±  4%  perf-profile.children.cycles-pp.acpi_safe_halt
      8.91            -1.2        7.67 ±  4%  perf-profile.children.cycles-pp.acpi_idle_enter
      8.28            -1.0        7.28 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.91 ±  6%      -0.8        0.14 ±  4%  perf-profile.children.cycles-pp.up_read
      0.97            -0.2        0.81        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      0.30 ±  2%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.25 ±  2%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.23 ±  2%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.22 ±  2%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.19 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.06 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.06            +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.update_blocked_averages
      0.06 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      0.05 ±  6%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.09 ±  3%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
      0.06 ±  5%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.llist_reverse_order
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.06            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.wake_affine
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.03 ± 77%      +0.0        0.06 ±  5%  perf-profile.children.cycles-pp.xas_descend
      0.09 ±  4%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.09 ±  5%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.select_task_rq
      0.04 ± 37%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_walk
      0.14 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.02 ±129%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.18            +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.12 ±  4%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.20 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.08 ±  5%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.16            +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.08 ±  5%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.set_next_entity
      0.51            +0.1        0.57 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.22 ±  2%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.26            +0.1        0.34 ±  4%  perf-profile.children.cycles-pp._compound_head
      0.60            +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.48 ±  5%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.22 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.enqueue_task_fair
      0.22 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.activate_task
      0.14 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.30 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.schedule_idle
      0.30            +0.1        0.40        perf-profile.children.cycles-pp.ttwu_do_activate
      0.13 ±  3%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.45            +0.1        0.59 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.44            +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.30 ±  2%      +0.1        0.44        perf-profile.children.cycles-pp.native_irq_return_iret
      1.16            +0.1        1.31 ±  2%  perf-profile.children.cycles-pp.wake_page_function
      1.38 ±  3%      +0.2        1.54 ±  3%  perf-profile.children.cycles-pp.schedule
      1.38 ±  3%      +0.2        1.55 ±  3%  perf-profile.children.cycles-pp.io_schedule
      0.62            +0.2        0.80 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.40            +0.2        1.62 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      1.63 ±  2%      +0.2        1.88 ±  3%  perf-profile.children.cycles-pp.__schedule
      1.32            +0.3        1.58 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.51            +0.3        0.78        perf-profile.children.cycles-pp.finish_fault
      1.57            +0.3        1.87 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      1.53            +0.7        2.25 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      2.09            +1.4        3.52 ±  4%  perf-profile.children.cycles-pp.poll_idle
      3.14            +2.1        5.20 ±  3%  perf-profile.children.cycles-pp.do_rw_once
      6.46            +2.4        8.82        perf-profile.children.cycles-pp._raw_spin_lock_irq
      9.41            +2.9       12.33        perf-profile.children.cycles-pp.folio_wait_bit_common
     20.55            +3.5       24.08        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     22.53            +3.9       26.39        perf-profile.children.cycles-pp.folio_wake_bit
     11.52            +3.9       15.42        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     11.67            +3.9       15.62        perf-profile.children.cycles-pp.shmem_fault
     11.69            +4.0       15.65        perf-profile.children.cycles-pp.__do_fault
     26.07            +5.6       31.69        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     36.28            -9.6       26.64        perf-profile.self.cycles-pp.next_uptodate_folio
      8.26            -1.3        7.00 ±  5%  perf-profile.self.cycles-pp.acpi_safe_halt
      8.35            -1.1        7.23 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.91 ±  6%      -0.8        0.14 ±  5%  perf-profile.self.cycles-pp.up_read
      0.47 ±  8%      -0.1        0.37 ±  8%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__switch_to_asm
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.09 ±  3%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.llist_add_batch
      0.12 ±  2%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.06 ±  5%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.llist_reverse_order
      0.06            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.06 ±  5%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.newidle_balance
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.06 ±  5%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.06            +0.0        0.09 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.08 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.set_pte_range
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.enqueue_entity
      0.26            +0.1        0.34 ±  4%  perf-profile.self.cycles-pp._compound_head
      0.24 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.__wake_up_common
      0.14 ±  3%      +0.1        0.23        perf-profile.self.cycles-pp.folio_unlock
      0.28 ±  2%      +0.1        0.38        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.60            +0.1        0.72        perf-profile.self.cycles-pp.folio_wake_bit
      0.30 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.native_irq_return_iret
      0.67            +0.2        0.83        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.49            +0.2        0.69 ±  2%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      1.31            +0.3        1.57 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      1.52            +0.4        1.90        perf-profile.self.cycles-pp.folio_wait_bit_common
      1.48            +0.6        2.12 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      1.57            +1.0        2.56 ±  2%  perf-profile.self.cycles-pp.do_access
      2.06            +1.4        3.47 ±  4%  perf-profile.self.cycles-pp.poll_idle
      2.42            +1.6        4.03 ±  3%  perf-profile.self.cycles-pp.do_rw_once
     26.07            +5.6       31.69        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

