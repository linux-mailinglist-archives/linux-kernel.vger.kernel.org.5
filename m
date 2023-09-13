Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743379EC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjIMPJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjIMPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:09:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF407B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694617759; x=1726153759;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=3rHqVlnU19IF4JSmMxfGJsYoJMwnTHOVipSOMlBGhKs=;
  b=hGT2XRlvL9dMVLVvn6QIcsV2pptTju6bTa5JF3s/Pd/fKHJn7QuSKP99
   3jMyX7rtYuG44eV7xAr3vVwjRXotMsRuXOLKP2MxAu8zWxk5njsCV+l7w
   EMeg5eo5o48DbMP4NQyRKRFkWDOrnP0Z0ACBNYBomjV4JwzhIYaalq7nv
   /lpQHZprxZQ4AMgOrtmtZajGlMOkuKJYSOBWsuIjnW+O3qwo0a+x6Cc5g
   fTzMAXJxYYu9NBAmtnK3u9zKJdKO2t9MWZN1jKH0/EKjMSbMV6SFkT0KK
   aASy+49k4RICRyVRWuiF7Gh6KqVIUtMDfZodtsJy6FvCWGB/TTjpJ4p4L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465058216"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="465058216"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747335358"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747335358"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:05:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:05:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:05:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:05:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcIpsJD4VpSpR3oshlD4JoyURJhVuxI8LSp4njy4p4A2ui27pFYvxqNzSrE1VB3VFiOzCfrX4ZimEzckguiJqdD04zQuzMdQd1CsvoqAabHREZ0A72NkNBg1xQa9PzkHkNYWKyAjpBcc9IE4+x1K4uVWVbPTVuUQCf1Bwn5HToh4e6x+aNL0AGMM7sU/WsoomZujWrdva7m31w9rbr7WfH9oDSEYK5YCO1bDSW60k7ibJRYdwSVtSPyRxCe5vU6bKxkl0FGTzKBEyiJs/8CAZBghm1u54zDQqyeP7pE0JfzQAmoWXWOrdbjkjIASpdf2dBGGEeBjJfMhVG9y0BmPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8wWY3z2Xt25ZvbMcu/r6XphjihKRg9uJALWiVIpbbE=;
 b=D9C/iOmdxnnWlDalXejKg4SiJQv0C4vL+bkWISpXfI28khEoQk9qeB3CPpNAErDuljw7NVgsvDUTZihb44ihsHenEsYSFJ2m4P4lqsAcdtpK6JC1/6KvWXoyqO2BN3rNDvrSXgLlgLW/PvOtBd9aTw14rKYWmVP2sbEviKWDhlOb+Kvy3MOYbc55Fv90FOJp+nBwEGiTEqCkw47ZGvDAKyOfDR1zHIOxb6mynhzZmyTT8EhEgtTfMN33JigeDVLl22QRBMdxI3ESiruR7q1FwjyfZmTEBkRMIwSbxGjlzY8W8V/cj5Yp+mPlsKXztq6ixxgoCXUfqUEhr8vy65zKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 15:05:46 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:05:46 +0000
Date:   Wed, 13 Sep 2023 23:05:34 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/fair]  5e963f2bd4:
 will-it-scale.per_thread_ops 2.5% improvement
Message-ID: <202309132209.cae4f58a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: d3be4069-fb9a-489d-d0e2-08dbb46ae8a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdnUlONlEiXkHyWEMDlHjIr8wvj2nsNWKsb8Nd5P8KSpB10e95lhAoD3DSpfvlaxcn7/CTjWMeZEwUjMtkqmIexymZ77MfPjPlfHKRP3rIwPgbKYDiKQVM/TsvXKyn5y2rk2cHWLMCIxyPjwf4Xpt8itvMoTRcFitmGrkzfVs2FijB7gzt06l1L2Q13y7tOPKBs56J9bpjea7qmxXVRmgHy+0CNRBgu5QGWn3s2BI1o6GknNVkevN45KgTvrJB8uKiPRgAB2M+Bm3LpEWcvTYNwX6vpREyqL/FjpVn5r/AkXpKyY6N+oQe325YlDjm8G5NAfM38MOFv73IolVcsm8W2ZwJFhijD7l+oU+SqiF9Mq6rY+wY0v53gV1/WqGFJiJRWzWP9JGyDNDuh69PZYjmY76oVgi5iP/qgpRy132adBzekrrJ5v5eILN1Rx6nN8Iy9bwZqLWxpObKm9V4dtq/OQSzrt5H8SQjRFM5qoF6uJjiIFi9wVvpPnz//eMA/b9EgEryXefxPw38N/xMnbbjWts8/99agihysQzs6UlsKVH/xiVrxriZ2Wv27TV8iBQ3hWguL+ElqzaQESHWPMzVMcuBlKcyR3ZJFEL+n5ShjVc/3krgdxZuAUC9RpudkVQZLA/RbHy07iXHJNmylvzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(83380400001)(38100700002)(86362001)(82960400001)(36756003)(2616005)(1076003)(26005)(316002)(6916009)(41300700001)(30864003)(66556008)(66476007)(66946007)(8676002)(966005)(8936002)(2906002)(478600001)(5660300002)(4326008)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+UqAMsRflkc/Oqgto7+fn9mUm3Kt/FKGQ3/8MgESksBOw53lY0oHPMX1HC?=
 =?iso-8859-1?Q?BCn7iZ0DCQABrPvLs0rm0yg7ezNmgWkMLWxj0ZSKm2wqg+luVH3f1yAb11?=
 =?iso-8859-1?Q?7w1DXbA1NVDbpUOz1SuWDgFZV//SDxrgKRktFDvt8HNh8H37zqN4SpQ2ZT?=
 =?iso-8859-1?Q?7R38GsTdLf4ZQTk49+C++/LuD6orwaZYMBQsTjKi/CGsz5FPRux94UIWOj?=
 =?iso-8859-1?Q?mPJA3oTleDk7mlrSm2Pu5Ure+/EWReeh4Smpeo7iVm+HhSlRY8tYt9aR8W?=
 =?iso-8859-1?Q?8QGhIpfbH6KJ9UBbE5K5lAt/MFZQvEZ5tAA6E0s2XABg8OijU7uXtVxBgu?=
 =?iso-8859-1?Q?OP0uWXBSWhVR0difFZ6HibcytPMT0SUMlM25QkgNqhULZFM018kB7ZToPp?=
 =?iso-8859-1?Q?1yiBq+8atkjsmGVUU1YMMlnwIgwoW8R6Kfbdg1ckgmEer1ZuV+Zg5PVeRd?=
 =?iso-8859-1?Q?EWt/MN6tfqvKNuQwb5ysBjKpvOpiJnSeeIRbC4oNyq0tS0tTvByHgnQP7z?=
 =?iso-8859-1?Q?1M9Xl6OQtlCcqyO2rP42uSySRQek8/jzydkGex4lgdJAZsG0+JSbp/LMl3?=
 =?iso-8859-1?Q?lL1UsMWN7sTVQShDDgl0w/sYUPDBtADSw0uJ0JXvbMOdvZwqQK9TQzQ3RH?=
 =?iso-8859-1?Q?RTWhBfC1TT7Dpw0psWj37pY7gccGoKH+8UZaXdBwMzZcHrLKEKyynTDSON?=
 =?iso-8859-1?Q?HZvLiwXGYLvgSqwzjo0DGDQHkrnaGCFN1PEUgxOA7kUlwgKuA+WC9Wm3n0?=
 =?iso-8859-1?Q?f3Ukh2KPMoiIwRKsDGaEmsd5MmRsDYoij+KT8H/GKgLE3T99rLxH2RH+Uu?=
 =?iso-8859-1?Q?PPpkMXIZEk/YHWuFwhzdaPzSP7tAArnItH7E1tpmaunhX6eLoywOzzurX6?=
 =?iso-8859-1?Q?bSiwrMqAzHIJfz2z/+E4R+rzINfiv2uR2h8/kjO9qWowo0wdGcmJ/k60E2?=
 =?iso-8859-1?Q?iLqahmT+h0MUd5i+U7QGzbHDGHiyUua5Kkxckhgb1TPZHkB6BcIgB1Eb6p?=
 =?iso-8859-1?Q?4jSv+CaS/amaqvSAqjh95u76jgF7AOs0aiTUoDDJ6KwAHrE1+sKy8gSdIj?=
 =?iso-8859-1?Q?beiUqTUPx+zeOAA7vjKqRZim/il0MRYIuwSaMTSSc9uY1jaLlyabUu8Lle?=
 =?iso-8859-1?Q?EZ/1NuFd2nLWWKqF8nlYNKm49cBTZGPbYu4AxOI6YxKITuTEWQGsuvegzi?=
 =?iso-8859-1?Q?beH3010Pz6qZQPuAoNuny4VPcTN+xtK0brS8wn7ut9Rs149LKtSnBg3/Ws?=
 =?iso-8859-1?Q?nYVHme23GLkawxP4aT3HIcBci2lubqVYrHUosBH5DcZ0BbnzjNDCBKOHpG?=
 =?iso-8859-1?Q?aJxWAT7d6O6TDyOgEkh+92NGCdLAdmlHLmyKGVlJ/caXkigmeIL0FMgj6C?=
 =?iso-8859-1?Q?Bwa09iaEwUjSJlY4ko6Ht6Zm3C2xR5ZBN7H0D51s42ayjcszIjrHN3+poj?=
 =?iso-8859-1?Q?8dZJ3T92n/EEc808zKU+ZtIbjAsITgZKky+tlhggdNCR0Jltvi7n/q8Ure?=
 =?iso-8859-1?Q?KExenanfpBXsyUYQTKRtW4vWz9pIsCZeTeVP90SyKdGiwKUwElOvIjyuPd?=
 =?iso-8859-1?Q?+Jtn/Tm4napghB0mpd9UwdE4QPA4T1g9LWhY0uC2nKwfvfD14OBOwjcc4r?=
 =?iso-8859-1?Q?9bzL4TPBOzXdd0kqzBeuJ6Y9zCKEdvochkt9OS1Kk+vp0cwYrHBgcL6w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3be4069-fb9a-489d-d0e2-08dbb46ae8a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:05:46.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNYGWpbc2UmbXxOT5Qhts/aBaoTcZtY3iMf9XyG8NIp5y3MvFhhMkvSosGTUgbYhmlxpRTWoR8uUvNisZuAbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Peter Zijlstra,

Yu helped review this report. though maybe not so valueable like those
hackbench/netperf report for EEVDF which has huge performance difference,
we report this just FYI since we got pretty stable results even by rebuilding
kernel and more reruns.


Hello,

kernel test robot noticed a 2.5% improvement of will-it-scale.per_thread_ops on:


commit: 5e963f2bd4654a202a8a05aa3a86cb0300b10e6c ("sched/fair: Commit to EEVDF")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: context_switch1
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230913/202309132209.cae4f58a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  e8f331bcc2 ("sched/smp: Use lag to simplify cross-runqueue placement")
  5e963f2bd4 ("sched/fair: Commit to EEVDF")

e8f331bcc270354a 5e963f2bd4654a202a8a05aa3a8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  18121238            +2.5%   18575201        vmstat.system.cs
  18317774            +2.5%   18781349        will-it-scale.104.threads
    176131            +2.5%     180589        will-it-scale.per_thread_ops
  18317774            +2.5%   18781349        will-it-scale.workload
 1.257e+08           -96.7%    4139803        sched_debug.sysctl_sched.sysctl_sched_features
      0.75          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
     24.00          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_latency
      4.00          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      1.65            +0.0        1.68        perf-stat.i.branch-miss-rate%
 4.185e+08            +1.3%   4.24e+08        perf-stat.i.branch-misses
  18284380            +2.5%   18745294        perf-stat.i.context-switches
      0.10            +0.0        0.10        perf-stat.i.dTLB-load-miss-rate%
  37343347            +2.5%   38269096        perf-stat.i.dTLB-load-misses
 3.711e+10            -1.1%  3.671e+10        perf-stat.i.dTLB-loads
 2.231e+10            -1.0%  2.208e+10        perf-stat.i.dTLB-stores
     60.89           +15.4       76.32        perf-stat.i.iTLB-load-miss-rate%
  42744641 ±  3%     +60.6%   68665465 ±  3%  perf-stat.i.iTLB-load-misses
  27283919           -21.7%   21361180 ±  2%  perf-stat.i.iTLB-loads
      3211 ±  3%     -37.7%       2001 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.10            +0.0        0.10        perf-stat.overall.dTLB-load-miss-rate%
     61.02           +15.2       76.26        perf-stat.overall.iTLB-load-miss-rate%
      3060 ±  3%     -38.2%       1890 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
   2146287            -3.2%    2077784        perf-stat.overall.path-length
 4.171e+08            +1.3%  4.226e+08        perf-stat.ps.branch-misses
  18221874            +2.5%   18680885        perf-stat.ps.context-switches
  37218153            +2.5%   38141041        perf-stat.ps.dTLB-load-misses
 3.699e+10            -1.1%  3.659e+10        perf-stat.ps.dTLB-loads
 2.223e+10            -1.0%  2.201e+10        perf-stat.ps.dTLB-stores
  42595400 ±  3%     +60.6%   68425583 ±  3%  perf-stat.ps.iTLB-load-misses
  27192032           -21.7%   21288405 ±  2%  perf-stat.ps.iTLB-loads
     25.66            -1.0       24.68        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     27.29            -0.8       26.46        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     38.80            -0.8       38.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     35.13            -0.8       34.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     15.91            -0.6       15.26        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     15.44            -0.6       14.79        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     22.78            -0.6       22.19        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.33            -0.5        8.81        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.70            -0.4        3.29        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.41            -0.4        1.03 ±  2%  perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.66            -0.3        1.36 ±  2%  perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      7.52            -0.3        7.24        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      7.31            -0.3        7.06        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.31 ±  2%      -0.2        1.13 ±  2%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
      1.57            -0.2        1.40 ±  3%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.71 ±  3%      -0.1        0.62 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.71 ±  3%      -0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      0.84            -0.0        0.80        perf-profile.calltrace.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.pipe_read
      0.87            -0.0        0.84        perf-profile.calltrace.cycles-pp.place_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.84 ±  2%      +0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.08            +0.1        1.16 ±  2%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.69            +0.1        0.76        perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule
      1.43            +0.1        1.52        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.pipe_read
      1.02 ±  3%      +0.1        1.12 ±  2%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04 ±  3%      +0.1        1.15 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      1.29 ±  4%      +0.2        1.48 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__libc_read
     25.69            -1.0       24.71        perf-profile.children.cycles-pp.vfs_read
     27.34            -0.8       26.52        perf-profile.children.cycles-pp.ksys_read
     22.95            -0.6       22.38        perf-profile.children.cycles-pp.pipe_read
     17.97            -0.5       17.44        perf-profile.children.cycles-pp.__schedule
      9.38            -0.5        8.86        perf-profile.children.cycles-pp.ttwu_do_activate
     18.42            -0.5       17.90        perf-profile.children.cycles-pp.schedule
      5.42            -0.4        5.04        perf-profile.children.cycles-pp.pick_next_task_fair
      1.43            -0.3        1.09 ±  2%  perf-profile.children.cycles-pp.check_preempt_wakeup
      1.67            -0.3        1.38 ±  2%  perf-profile.children.cycles-pp.check_preempt_curr
      3.09 ±  2%      -0.3        2.81 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      7.53            -0.3        7.26        perf-profile.children.cycles-pp.activate_task
      7.33            -0.2        7.08        perf-profile.children.cycles-pp.enqueue_task_fair
      1.68 ±  2%      -0.2        1.46 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.35 ±  2%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.pick_next_entity
      0.52 ± 10%      -0.1        0.39 ± 11%  perf-profile.children.cycles-pp.cpuacct_charge
      0.88 ±  2%      -0.1        0.77 ±  3%  perf-profile.children.cycles-pp.__calc_delta
      0.41 ±  6%      -0.1        0.31 ±  9%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.78 ±  2%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      0.57            -0.0        0.52        perf-profile.children.cycles-pp.__cond_resched
      0.24 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__list_add_valid
      1.29            -0.0        1.25        perf-profile.children.cycles-pp.mutex_lock
      0.41 ±  3%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.27 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.53            -0.0        0.50 ±  2%  perf-profile.children.cycles-pp.copyout
      0.50 ±  2%      -0.0        0.47 ±  2%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.20 ±  4%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.kill_fasync
      0.21 ±  4%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__x64_sys_write
      0.19 ±  4%      +0.0        0.22 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.08 ±  6%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.99            +0.0        1.03        perf-profile.children.cycles-pp.__switch_to
      1.33            +0.1        1.39        perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.make_vfsgid
      0.26 ±  3%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.54 ±  2%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.fput
      0.86 ±  2%      +0.1        0.93 ±  2%  perf-profile.children.cycles-pp.atime_needs_update
      0.50            +0.1        0.57 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
      1.09            +0.1        1.17 ±  2%  perf-profile.children.cycles-pp.touch_atime
      1.82            +0.1        1.93        perf-profile.children.cycles-pp.set_next_entity
      2.03 ±  3%      +0.1        2.17        perf-profile.children.cycles-pp.__fget_light
      2.10 ±  3%      +0.1        2.24        perf-profile.children.cycles-pp.__fdget_pos
      4.33            +0.2        4.55        perf-profile.children.cycles-pp.update_load_avg
      1.48            -0.3        1.14        perf-profile.self.cycles-pp.vfs_read
      0.60 ±  6%      -0.2        0.42 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      0.71            -0.2        0.54 ±  2%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.50 ± 10%      -0.1        0.38 ± 11%  perf-profile.self.cycles-pp.cpuacct_charge
      0.87 ±  2%      -0.1        0.76 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.62 ±  4%      -0.1        0.53        perf-profile.self.cycles-pp.dequeue_entity
      0.39 ±  7%      -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.32 ±  3%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.put_prev_entity
      1.37            -0.1        1.30 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.58 ±  3%      -0.1        0.52 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.76 ±  3%      -0.1        0.71 ±  2%  perf-profile.self.cycles-pp.__libc_read
      0.40 ±  2%      -0.0        0.36 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.23 ±  2%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.__list_add_valid
      0.18 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.36 ±  2%      -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.copyout
      0.19 ±  3%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.activate_task
      0.45 ±  2%      -0.0        0.42 ±  3%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.kill_fasync
      0.12 ±  5%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.34 ±  3%      +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.ksys_write
      0.18 ±  3%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.08 ±  7%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.rb_next
      0.90            +0.0        0.95        perf-profile.self.cycles-pp.__switch_to
      0.39 ±  2%      +0.0        0.43 ±  2%  perf-profile.self.cycles-pp.__dequeue_entity
      0.22 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.ttwu_do_activate
      1.30            +0.1        1.35        perf-profile.self.cycles-pp.__update_load_avg_se
      0.46 ±  2%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.fput
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.make_vfsgid
      0.19 ±  4%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.finish_task_switch
      0.38 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.ksys_read
      1.43 ±  2%      +0.1        1.54 ±  2%  perf-profile.self.cycles-pp.pipe_write
      1.05 ±  2%      +0.1        1.17 ±  2%  perf-profile.self.cycles-pp.vfs_write
      2.00 ±  3%      +0.1        2.14        perf-profile.self.cycles-pp.__fget_light
      1.71 ±  2%      +0.1        1.86 ±  2%  perf-profile.self.cycles-pp.update_load_avg



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

