Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D345B7DC4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJaCu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaCu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:50:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE1A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698720653; x=1730256653;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=562lLxy76Zw3kqnJQjd+vv7njDW3DF1/oCf6i4KKelg=;
  b=Pom/GTQJzK/wfhiDMHiAO+OHs6q6p/z1mVWBe+y/ATvJuYC5wCa/7fSk
   ka4Sjr2DMPFltxWBeULgVsA6A/yCdFf2Ea1OYCCru+V/2GFUwH2uQ1ZH3
   uu7dQC/7dmBxTksp9mD4Tn5RMK+5GAXPyAsf5RlKcoAjxSVEFXNPTp7TT
   GyGfAaQQmX0Ox2UPP+Y2/KQ7Y5yeSUZVSu8LuZAeVlI6+jJRn73NsbnrR
   RKAHaIG7WdiD7QD2sXeCfmpp+SrPxsNFYXGlWfbGD2z08qEpO+SVxVgIV
   uxjYm0DSIQ2zqlnKUZlb6HJRbVIwcF4Fc4DfCw981EjxKJSQ8wbS1mDEM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1079338"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1079338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884070431"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884070431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 19:50:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:50:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:50:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/jZE4RavBSC+zzSVGdfADI4J7mWpaWq84xB2IxclyRpg6Bya6ksescLyZN3O8N+0GMr3PFnxl97GmYQIIOvitc1HKSRDclwe9SqNaP12yC+E2p48iQDhrRiVl87SqUelT0GefJsweRYdfasvW98P8snnXpArrR6uslyFwiyCFGA6BrmySEa5xI6YDNTV+Yn/BtmttEi3YqjKgjq56grZb+qHoRUEeiXJmWb+tDi/s3VkEToUah/P+vkdAsBSC60DEDYYtMpq3vKYaUOx4trlj0EmtAelBusmzU+i8X3FPSSoj2SSzn9Td4JSZyip1w9+fRdaVzQtixwufekylu3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeftbRgBII6A3m67t6vWGX70DTIkKMGlpPWpKGgo7ao=;
 b=Z7K5NTzJOMNNQxuhF9NkAGvpYdGuPHG2E1oZuuwXYhatS3JrkxgGNWUFIDjx+mjtK8FGujrPfaf54BN3Nze9zP8+P5A5WYnVXgDNGK47NKTxSY1UzRvDa6yhCpqfMrB2ICpmo+QulscuqAB7W7M1RCcLD6S1IHVeIxN6x94a1+djTVudgorCc3gBibv8CTI4knF22V7E8v4MgRLMExP9Z3aXtlU2Dug3kM41hzsw8NliNrA2CS7LmnWAdQifcz1QfoN7wYSIXU4Mv5ddaz2UTdR4Mn9I32pB95jlYFaNxCWM0xNPdeNKlxuoOwe4IYgRZA3CYp61kZdeGgrk03Edrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB8515.namprd11.prod.outlook.com (2603:10b6:a03:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 02:50:45 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 02:50:45 +0000
Date:   Tue, 31 Oct 2023 10:50:33 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter" <cl@linux.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH -V3 7/9] mm: tune PCP high automatically
Message-ID: <202310311001.edbc5817-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016053002.756205-8-ying.huang@intel.com>
X-ClientProxiedBy: KL1PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b5edb1-dde2-4909-82a3-08dbd9bc2dbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emlAxYtjEXqKVqMjSG19KLGXa8Ia0XhTzaZGMFQRQkjc/Exja2yX+VpLWlM39/qs5kPIybwO4Tcf8A1jw5CI1DpNJxs+cLgo3T5cUgqDSihY53KAev0CgtYLAgrgkDO9fz4x/HL2dAuJG8qfcuqePOOPDx6RC6Ej35dsuqPdR3EqTJGyHTDyzyF8TK5hpubYOoiHaIvBeY7MfZIKyL/WN25iBSPP/8mjnFjyJingywIsKEaFqc075DKEOnqcp16FOA+aSx8Q4miKRJRX01Y0W6pbNe68TlromhZFgxldqu1BJtLy9lQVuSN62PslZILFIS4nThfEuFVG7NhPGvxbFPbJSWfp7Svp8YS2FjozEGOuliiAi0WY+tIzjXpzYmQVUQw9i5xsit6IKqVf9QatKv4IK/yweCMHZTPH13nkOPXSWQOjiNm+yZk37amVM1p7q0DiFfJ11F7xqV9w8j9FJllnJie7iwh/EgpT6ZgcNFqlUJgQbolEaL0dB0+t6CXmMwApOE4VSiIzbiSS+eyTXl/VuNPuV5NJFKgPKGKJFgs3OPLGEQuQNhrTp2FTCta8LcmHjAjScCkanxVGFSebqvlU8VinAd8axrwXUMQDPYpbDXBVNweaiZ7lIZLItHIWJs0S//Hud76VhoXszFrG5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230473577357003)(230373577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(26005)(1076003)(2616005)(38100700002)(86362001)(36756003)(82960400001)(30864003)(83380400001)(2906002)(7416002)(6486002)(478600001)(6506007)(6666004)(4326008)(8676002)(19627235002)(37006003)(316002)(54906003)(66476007)(6636002)(8936002)(6862004)(66556008)(966005)(5660300002)(41300700001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k8NCYUCpeBGjfsNek361VlFwMV35COMRIguMVSTcN4lrqnUJHA5P5diRS4?=
 =?iso-8859-1?Q?wxdAydpCnO5Jlp3j303ob2J46UyP5VOmZEbdjOW6qUKRYgkI01+omNK0Gw?=
 =?iso-8859-1?Q?KXZhsVSPCUHsYVqInnBcb/W8TeL+sDoxyxxNlVFEeTKcqPApbykZiEtbBD?=
 =?iso-8859-1?Q?D8oK/X0J3lsKoK5ZAZLIHP7wjBiZTWLePJFqKzmFBKNnF44vcBiHFLxa2e?=
 =?iso-8859-1?Q?7BfhPytnlINbDYGxQpkWuo/7uweIEd7NKMmeJ2aGhsjdlUjDy0+Av0npqq?=
 =?iso-8859-1?Q?m6I6+naUhv+hYBKi+WVuIt2MlNIiNDWs0F+9Yfq9lDg7Xk/KrNJCS2r4nO?=
 =?iso-8859-1?Q?CoObi1M4xljbcDwO9adoNa8SqQDZC1N3i3whxsj6yJeb6NHtCwS+YZidrm?=
 =?iso-8859-1?Q?mtaVAcwr3UDJxor9mXRznttqKDstbh9CzzMTbc+Tt56nEy9jX/Ejuh8lYJ?=
 =?iso-8859-1?Q?/QwAm7LFXc/PXxF8Lq3i9+y67yw+f4lSpOvHwFa1zswuOICj4JMey63zXi?=
 =?iso-8859-1?Q?AmjhwuxYRhxlKGuX7IP6/qvOWpeSPUxavfP9j6lfAluc9/6qul+D3/IG1n?=
 =?iso-8859-1?Q?jKOKF2lxD3P5uq9OCJgwzf93tYQ8RKlSXfaA40d7N071JCmP7b2yoxy9ms?=
 =?iso-8859-1?Q?a+UmZH2HnjnxNOOU3dTu0ml4VoMoaGh8pDjhYV2u2VdGyCPP7F+d/xbJvP?=
 =?iso-8859-1?Q?WJeRD99tU4Mna/WzaBKWzMci26YaKCl5WKQwoyXl0yieepftpkjj6GoGZr?=
 =?iso-8859-1?Q?5jzKmGAwTqa6mV8RUXrMcwV7rO8q/SdnFOeTOGK1gCeQsRwmPIW4T6MltK?=
 =?iso-8859-1?Q?on1RxrSMQzOTZU24rLcnmkuW9p010sI4m5Z+b12rXHz6uXSXyvij2INAFa?=
 =?iso-8859-1?Q?mt1gZS+q8ysnUXXy+rqlTMFUUSGL3xHDI/5qacUZmHLJp3H92ep82ntqYG?=
 =?iso-8859-1?Q?mkRwm08wvOFoinIDcNBi82z1WcZea14XfksYQ34pbA0u08GviDMItFWFk1?=
 =?iso-8859-1?Q?S6DYqQK2rUL/VcQyE/Q5zJIm7K+qiV0j5j1U9FNhvTytZfttg4GwLBhhK5?=
 =?iso-8859-1?Q?AkZgPEwf5cSJi0UCVMbA3YsOVBov0Bodj5NllbLokMvYIalHM92BlPc8yf?=
 =?iso-8859-1?Q?RiWj2J05+O9G9MokFZkaxf2btj4Eb6zfQMT8mK9P4GF+pfohVDryGB80uN?=
 =?iso-8859-1?Q?eCT8LxZKx0Q0uuCHElyhF1I4vSde4fpVSr3S0hmVrnTqqY4fV6zRv7K4zp?=
 =?iso-8859-1?Q?7hMnayMm7Uxc8r6/zVpI9p1x4r3QspVUJ2Frg+t+20b6sav7eagAVu82uo?=
 =?iso-8859-1?Q?C4J2whpXLrlQFhf8P0VhBK2W2wGqH4ymltGzFNgfWMNURemGOQGU2nY0k6?=
 =?iso-8859-1?Q?R1YABnZH1aDKLrBgNZUlNh6Rra4W55Xd0+3z6a4iWwdc2g2zY3cV/hqyrw?=
 =?iso-8859-1?Q?rG4gkyWsgeEhgCeTeptDVZ/auPBuJXDxcL82ZcJ8FQzmxjoy504nPR044g?=
 =?iso-8859-1?Q?0w7AknonCvUL/bef48BX4dRGg3SO249E8gZiTJztYZbhxyIJqWrtcDiJpx?=
 =?iso-8859-1?Q?BlTYGxLOixwiImC8OclsxSQS6EIXJkhrV39Gt47F1U2n8M8cTYNk53OIv0?=
 =?iso-8859-1?Q?etdyLU1cbmn1kBQXhC3xoaDylOy1Uz/7Bz7ulaz+EdfaYvxXnbT+r51A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b5edb1-dde2-4909-82a3-08dbd9bc2dbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:50:45.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JR5nDZ6g9Hf4qOs8pqoBGacDHgmEQt1UOyW33ZuBa4XLVZKp7+p4AJAsXR2CduygkvAbhzdJSJHpQJmzLcG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 8.4% improvement of will-it-scale.per_process_ops on:


commit: ba6149e96007edcdb01284c1531ebd49b4720f72 ("[PATCH -V3 7/9] mm: tune PCP high automatically")
url: https://github.com/intel-lab-lkp/linux/commits/Huang-Ying/mm-pcp-avoid-to-drain-PCP-when-process-exit/20231017-143633
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git 36b2d7dd5a8ac95c8c1e69bdc93c4a6e2dc28a23
patch link: https://lore.kernel.org/all/20231016053002.756205-8-ying.huang@intel.com/
patch subject: [PATCH -V3 7/9] mm: tune PCP high automatically

testcase: will-it-scale
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 16
	mode: process
	test: page_fault2
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231031/202310311001.edbc5817-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/16/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/page_fault2/will-it-scale

commit: 
  9f9d0b0869 ("mm: add framework for PCP high auto-tuning")
  ba6149e960 ("mm: tune PCP high automatically")

9f9d0b08696fb316 ba6149e96007edcdb01284c1531 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.29            +0.0        0.32        mpstat.cpu.all.usr%
   1434135 ±  2%     +15.8%    1660688 ±  4%  numa-meminfo.node0.AnonPages.max
     22.97            +2.0%      23.43        turbostat.RAMWatt
    213121 ±  5%     -19.5%     171478 ±  7%  meminfo.DirectMap4k
   8031428           +12.0%    8998346        meminfo.Memused
   9777522           +14.3%   11178004        meminfo.max_used_kB
   4913700            +8.4%    5326025        will-it-scale.16.processes
    307105            +8.4%     332876        will-it-scale.per_process_ops
   4913700            +8.4%    5326025        will-it-scale.workload
 1.488e+09            +8.5%  1.614e+09        proc-vmstat.numa_hit
 1.487e+09            +8.4%  1.612e+09        proc-vmstat.numa_local
 1.486e+09            +8.3%  1.609e+09        proc-vmstat.pgalloc_normal
 1.482e+09            +8.3%  1.604e+09        proc-vmstat.pgfault
 1.486e+09            +8.3%  1.609e+09        proc-vmstat.pgfree
   2535424 ±  2%      +6.2%    2693888 ±  2%  proc-vmstat.unevictable_pgs_scanned
      0.04 ±  9%     +62.2%       0.06 ± 20%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     85.33 ±  7%     +36.1%     116.17 ±  8%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    475.33 ±  3%     +24.8%     593.33 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ± 17%    +449.1%       0.87 ± 39%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.03 ± 10%     +94.1%       0.07 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
      0.04 ±  9%     +62.2%       0.06 ± 20%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.16 ± 17%    +449.1%       0.87 ± 39%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     14.01            +6.0%      14.85        perf-stat.i.MPKI
  5.79e+09            +3.6%  6.001e+09        perf-stat.i.branch-instructions
      0.20 ±  2%      +0.0        0.21 ±  2%  perf-stat.i.branch-miss-rate%
  12098037 ±  2%      +8.5%   13122446 ±  2%  perf-stat.i.branch-misses
     82.90            +2.1       85.03        perf-stat.i.cache-miss-rate%
 4.005e+08            +9.8%  4.399e+08        perf-stat.i.cache-misses
  4.83e+08            +7.1%  5.174e+08        perf-stat.i.cache-references
      2.29            -3.2%       2.22        perf-stat.i.cpi
    164.08            -9.0%     149.33        perf-stat.i.cycles-between-cache-misses
 7.091e+09            +4.2%  7.392e+09        perf-stat.i.dTLB-loads
      0.97            +0.0        1.01        perf-stat.i.dTLB-store-miss-rate%
  40301594            +8.8%   43829422        perf-stat.i.dTLB-store-misses
 4.121e+09            +4.4%  4.302e+09        perf-stat.i.dTLB-stores
     83.96            +2.6       86.59        perf-stat.i.iTLB-load-miss-rate%
  10268085 ±  3%     +23.0%   12628681 ±  3%  perf-stat.i.iTLB-load-misses
 2.861e+10            +3.7%  2.966e+10        perf-stat.i.instructions
      2796 ±  3%     -15.7%       2356 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.44            +3.3%       0.45        perf-stat.i.ipc
    984.67            +9.6%       1078        perf-stat.i.metric.K/sec
     78.05            +4.2%      81.29        perf-stat.i.metric.M/sec
   4913856            +8.4%    5329060        perf-stat.i.minor-faults
 1.356e+08           +10.6%  1.499e+08        perf-stat.i.node-loads
  32443508            +7.6%   34908277        perf-stat.i.node-stores
   4913858            +8.4%    5329062        perf-stat.i.page-faults
     14.00            +6.0%      14.83        perf-stat.overall.MPKI
      0.21 ±  2%      +0.0        0.22 ±  2%  perf-stat.overall.branch-miss-rate%
     82.92            +2.1       85.02        perf-stat.overall.cache-miss-rate%
      2.29            -3.1%       2.21        perf-stat.overall.cpi
    163.33            -8.6%     149.29        perf-stat.overall.cycles-between-cache-misses
      0.97            +0.0        1.01        perf-stat.overall.dTLB-store-miss-rate%
     84.00            +2.6       86.61        perf-stat.overall.iTLB-load-miss-rate%
      2789 ±  3%     -15.7%       2350 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.44            +3.2%       0.45        perf-stat.overall.ipc
   1754985            -4.7%    1673375        perf-stat.overall.path-length
 5.771e+09            +3.6%  5.981e+09        perf-stat.ps.branch-instructions
  12074113 ±  2%      +8.4%   13094204 ±  2%  perf-stat.ps.branch-misses
 3.992e+08            +9.8%  4.384e+08        perf-stat.ps.cache-misses
 4.814e+08            +7.1%  5.157e+08        perf-stat.ps.cache-references
 7.068e+09            +4.2%  7.367e+09        perf-stat.ps.dTLB-loads
  40167519            +8.7%   43680173        perf-stat.ps.dTLB-store-misses
 4.107e+09            +4.4%  4.288e+09        perf-stat.ps.dTLB-stores
  10234325 ±  3%     +23.0%   12587000 ±  3%  perf-stat.ps.iTLB-load-misses
 2.852e+10            +3.6%  2.956e+10        perf-stat.ps.instructions
   4897507            +8.4%    5310921        perf-stat.ps.minor-faults
 1.351e+08           +10.5%  1.494e+08        perf-stat.ps.node-loads
  32335421            +7.6%   34789913        perf-stat.ps.node-stores
   4897509            +8.4%    5310923        perf-stat.ps.page-faults
 8.623e+12            +3.4%  8.912e+12        perf-stat.total.instructions
      9.86 ±  3%      -8.4        1.49 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      8.11 ±  3%      -7.5        0.58 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      8.10 ±  3%      -7.5        0.58 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      7.52 ±  3%      -6.4        1.15 ±  5%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush.zap_pte_range
      7.90 ±  4%      -6.4        1.55 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      5.78 ±  4%      -5.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush
      5.78 ±  4%      -5.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_list.release_pages
     10.90 ±  3%      -5.3        5.59 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault
     10.57 ±  3%      -5.3        5.26 ±  3%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
     10.21 ±  3%      -5.3        4.94 ±  3%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
     11.18 ±  3%      -5.3        5.91 ±  2%  perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault
     11.15 ±  3%      -5.3        5.88 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_cow_fault.do_fault
     11.56 ±  3%      -5.2        6.37 ±  2%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      9.76 ±  3%      -4.3        5.50 ±  6%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range
     10.18 ±  3%      -4.2        5.95 ±  5%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.__munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     15.39 ±  3%      -3.7       11.70        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     14.08 ±  3%      -3.6       10.49        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     14.10 ±  3%      -3.6       10.52        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     14.10 ±  3%      -3.6       10.52        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     14.10 ±  3%      -3.6       10.52        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.60 ±  2%      -0.7        0.86 ±  6%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.96 ±  3%      -0.4        0.56 ±  3%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      1.00 ±  4%      -0.4        0.62 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      1.26 ±  4%      -0.1        1.11 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      1.28 ±  3%      -0.1        1.16 ±  3%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.28 ±  4%      -0.1        1.17 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.60 ±  3%      -0.0        0.57        perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.55 ±  3%      +0.0        0.60        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.73 ±  3%      +0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.68 ±  3%      +0.1        0.78 ±  3%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.57 ±  7%      +0.1        0.71 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_cow_fault
      1.41 ±  3%      +0.1        1.55        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
      0.77 ±  4%      +0.2        0.93 ±  5%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_cow_fault.do_fault
      0.94 ±  3%      +0.2        1.12 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.36 ± 70%      +0.2        0.57        perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.26 ±  5%      +0.2        1.47 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_cow_fault
      1.61 ±  5%      +0.3        1.87 ±  3%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_cow_fault.do_fault
      1.75 ±  5%      +0.3        2.05 ±  3%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_cow_fault.do_fault.__handle_mm_fault
      1.86 ±  4%      +0.3        2.17 ±  2%  perf-profile.calltrace.cycles-pp.__do_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.17 ±141%      +0.4        0.58 ±  3%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault
      2.60 ±  3%      +0.5        3.14 ±  5%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      4.51 ±  3%      +0.7        5.16        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_cow_fault.do_fault
      4.65 ±  3%      +0.7        5.32        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_cow_fault.do_fault.__handle_mm_fault
      1.61 ±  3%      +1.9        3.52 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      0.85 ±  2%      +1.9        2.77 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.zap_pte_range
      0.84 ±  2%      +1.9        2.76 ± 13%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush
      0.85 ±  2%      +1.9        2.78 ± 12%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      1.71 ±  3%      +1.9        3.64 ±  6%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      1.70 ±  2%      +1.9        3.63 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
      3.31 ±  2%      +2.2        5.52 ±  5%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_cow_fault
      3.46 ±  2%      +2.2        5.71 ±  5%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_cow_fault.do_fault
      4.47 ±  2%      +2.4        6.90 ±  4%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_cow_fault.do_fault.__handle_mm_fault
      9.22 ±  2%      +3.1       12.33 ±  2%  perf-profile.calltrace.cycles-pp.finish_fault.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
     44.13 ±  3%      +3.2       47.34        perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     44.27 ±  3%      +3.2       47.49        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     45.63 ±  2%      +3.3       48.95        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +3.4        3.37 ±  2%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
     46.88 ±  3%      +3.4       50.29        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     49.40 ±  2%      +3.6       53.03        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     49.59 ±  2%      +3.7       53.24        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     59.06 ±  2%      +4.5       63.60        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     56.32 ±  3%      +4.6       60.89        perf-profile.calltrace.cycles-pp.testcase
     20.16 ±  3%      +4.9       25.10        perf-profile.calltrace.cycles-pp.copy_page.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault
     16.66 ±  3%      -8.8        7.83 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     16.48 ±  3%      -8.8        7.66 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      9.90 ±  3%      -8.4        1.50 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
      8.92 ±  3%      -6.7        2.18 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      8.47 ±  3%      -6.7        1.74 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
     10.96 ±  3%      -5.3        5.64 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
     10.62 ±  3%      -5.3        5.30 ±  2%  perf-profile.children.cycles-pp.rmqueue
     10.26 ±  3%      -5.3        4.97 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
     11.24 ±  3%      -5.3        5.96 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
     11.18 ±  3%      -5.3        5.92 ±  2%  perf-profile.children.cycles-pp.__folio_alloc
     11.57 ±  3%      -5.2        6.37 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
     11.19 ±  3%      -4.4        6.82 ±  5%  perf-profile.children.cycles-pp.release_pages
     11.46 ±  3%      -4.3        7.12 ±  5%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
     15.52 ±  3%      -3.7       11.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     15.52 ±  3%      -3.7       11.81        perf-profile.children.cycles-pp.do_syscall_64
     15.41 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.__munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.do_vmi_munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.do_vmi_align_munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.__x64_sys_munmap
     15.40 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.__vm_munmap
     15.39 ±  3%      -3.7       11.70        perf-profile.children.cycles-pp.unmap_region
     14.10 ±  3%      -3.6       10.52        perf-profile.children.cycles-pp.unmap_vmas
     14.10 ±  3%      -3.6       10.52        perf-profile.children.cycles-pp.unmap_page_range
     14.10 ±  3%      -3.6       10.52        perf-profile.children.cycles-pp.zap_pmd_range
     14.10 ±  3%      -3.6       10.52        perf-profile.children.cycles-pp.zap_pte_range
      2.60 ±  3%      -2.0        0.56 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      1.28 ±  3%      -0.1        1.17 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.15 ± 19%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.61 ±  3%      -0.0        0.58 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.11 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.25 ±  4%      +0.0        0.26        perf-profile.children.cycles-pp.error_entry
      0.15 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.12 ±  8%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.18 ±  3%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.access_error
      0.07 ±  5%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.04 ± 45%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.30 ±  4%      +0.0        0.32        perf-profile.children.cycles-pp.down_read_trylock
      0.27 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.up_read
      0.15 ±  8%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.02 ±142%      +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.44 ±  2%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.mas_walk
      0.46 ±  4%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.67 ±  3%      +0.1        0.73 ±  4%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.42 ±  3%      +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
      0.43 ±  4%      +0.1        0.49 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.30 ±  5%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.xas_descend
      0.86 ±  3%      +0.1        0.92        perf-profile.children.cycles-pp.___perf_sw_event
      0.73 ±  3%      +0.1        0.80        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.40 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.__mod_node_page_state
      0.01 ±223%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.shmem_get_policy
      0.53 ±  2%      +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      1.09 ±  3%      +0.1        1.18        perf-profile.children.cycles-pp.__perf_sw_event
      0.50 ±  5%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.68 ±  3%      +0.1        0.78 ±  3%  perf-profile.children.cycles-pp.page_remove_rmap
      1.45 ±  3%      +0.1        1.60        perf-profile.children.cycles-pp.sync_regs
      0.77 ±  4%      +0.2        0.93 ±  5%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.84 ±  5%      +0.2        1.02 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.96 ±  4%      +0.2        1.15 ±  3%  perf-profile.children.cycles-pp.lru_add_fn
      1.27 ±  5%      +0.2        1.48 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      1.62 ±  4%      +0.3        1.88 ±  3%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      1.75 ±  5%      +0.3        2.06 ±  3%  perf-profile.children.cycles-pp.shmem_fault
      1.87 ±  4%      +0.3        2.18 ±  2%  perf-profile.children.cycles-pp.__do_fault
      2.19 ±  2%      +0.3        2.51        perf-profile.children.cycles-pp.native_irq_return_iret
      2.64 ±  4%      +0.5        3.18 ±  6%  perf-profile.children.cycles-pp._compound_head
      4.62 ±  3%      +0.6        5.26        perf-profile.children.cycles-pp._raw_spin_lock
      4.67 ±  3%      +0.7        5.34        perf-profile.children.cycles-pp.__pte_offset_map_lock
      3.32 ±  2%      +2.2        5.54 ±  5%  perf-profile.children.cycles-pp.folio_batch_move_lru
      3.47 ±  2%      +2.2        5.72 ±  5%  perf-profile.children.cycles-pp.folio_add_lru_vma
      4.49 ±  2%      +2.4        6.92 ±  4%  perf-profile.children.cycles-pp.set_pte_range
      9.25 ±  2%      +3.1       12.36 ±  2%  perf-profile.children.cycles-pp.finish_fault
      2.25 ±  2%      +3.1        5.36 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
     44.16 ±  3%      +3.2       47.37        perf-profile.children.cycles-pp.do_cow_fault
     44.28 ±  3%      +3.2       47.50        perf-profile.children.cycles-pp.do_fault
     45.66 ±  2%      +3.3       48.98        perf-profile.children.cycles-pp.__handle_mm_fault
     46.91 ±  2%      +3.4       50.33        perf-profile.children.cycles-pp.handle_mm_fault
     49.44 ±  2%      +3.6       53.08        perf-profile.children.cycles-pp.do_user_addr_fault
     49.62 ±  2%      +3.6       53.27        perf-profile.children.cycles-pp.exc_page_fault
      2.70 ±  3%      +4.1        6.75 ±  8%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     55.26 ±  2%      +4.2       59.44        perf-profile.children.cycles-pp.asm_exc_page_fault
     58.13 ±  3%      +4.6       62.72        perf-profile.children.cycles-pp.testcase
     20.19 ±  3%      +4.9       25.14        perf-profile.children.cycles-pp.copy_page
     16.48 ±  3%      -8.8        7.66 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.53 ±  3%      -2.0        0.54 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.12 ±  4%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.14 ± 19%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.10 ±  3%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.13 ±  5%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.13 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.exc_page_fault
      0.15 ±  5%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.18 ±  3%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.access_error
      0.30 ±  3%      +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.down_read_trylock
      0.16 ±  6%      +0.0        0.18        perf-profile.self.cycles-pp.set_pte_range
      0.26 ±  2%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.up_read
      0.15 ±  8%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.folio_add_lru_vma
      0.15 ±  8%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.22 ±  6%      +0.0        0.26 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.32 ±  6%      +0.0        0.36 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.28 ±  5%      +0.0        0.32 ±  4%  perf-profile.self.cycles-pp.do_cow_fault
      0.14 ±  7%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.shmem_fault
      0.34 ±  5%      +0.0        0.38 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__cond_resched
      0.44 ±  3%      +0.1        0.49 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.41 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.free_swap_cache
      0.75 ±  3%      +0.1        0.81 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.91 ±  2%      +0.1        0.98 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.29 ±  6%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.38 ±  2%      +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.01 ±223%      +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.shmem_get_policy
      0.58 ±  3%      +0.1        0.66 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.44 ±  4%      +0.1        0.54 ±  3%  perf-profile.self.cycles-pp.lru_add_fn
      1.44 ±  3%      +0.1        1.59        perf-profile.self.cycles-pp.sync_regs
      2.18 ±  2%      +0.3        2.50        perf-profile.self.cycles-pp.native_irq_return_iret
      4.36 ±  3%      +0.4        4.76        perf-profile.self.cycles-pp.testcase
      2.61 ±  4%      +0.5        3.14 ±  5%  perf-profile.self.cycles-pp._compound_head
      4.60 ±  3%      +0.6        5.23        perf-profile.self.cycles-pp._raw_spin_lock
      2.23 ±  2%      +3.1        5.34 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
     20.10 ±  3%      +4.9       25.02        perf-profile.self.cycles-pp.copy_page




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

