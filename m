Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95647CE05E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjJROvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJROvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:51:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29055A4;
        Wed, 18 Oct 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697640662; x=1729176662;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=cTTw7EYcqvlPg5uYDr/CocVmkujz72nldBegE73zlQw=;
  b=ixDv95iwVZEtib6TpSt5L6DxmM6mltKvCi5qmDyrKwVa919/xNhyWJLt
   3PpoX3UbEwh6PhBjT4D9FtSSVGGX9go5g5aKJOkQCNFpw+qc2mqCqR1oJ
   S9Efa0+5yJiwjWRyq0t6mbKI3QaFYc/YKx0jcZbRDU6oMOGzricDUi9q0
   bcZcbBL+Os+7yz57sJqrZXCkOy9dpjTeSI8n83EgT23MpKPGvs4CpL/7T
   vwevx2m+r8cgfLG4OTWZG8PnCj7wkbMsw6WDkbXjfM5TCqUxkBoz4waC4
   SnCLLGHS95PGgnJm3MDB5fBJGxlGY/L/6eiKtnJ9BwQ4St5ZUAA4GjSkw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="384909456"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="384909456"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756613881"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756613881"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 07:50:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 07:50:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 07:50:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 07:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHXXpvaDzpfCTx5GrddSzEY63rVQeTZafCuLaHDh7AshJW4uYDh97fhIrMzhNjlPblmGVUdwKpC9k0puli+/eEyOGO/KPFB/ZKK6v3/2J2rT7Sd4K6M0xAlkgOETosBFgf+VAeC4xKATM6xqajnRJLBD9RjZe9jzCdsPCEyu1O+yMp+UMAUKmpph8ehq6yDMlDYKd2cldZ7QSPXBK2OJCnvYefOA5gyIjfm9WpDhtF6pEyFFKiTagy6cZkFeFownZmxO77et+9vaGcOSZXyoJ48JDu8ZqGZZEv5PIFa+Z74msEj6RTqImcSkUvprSfvxtbUiI/KRztmIu5N8Tydi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Cg0Z5ppP8Uy4Q67LN/nWE1sdyLlAYEKcrUuqHK8HI=;
 b=InzxmT+92vuy1GrwBSjsI3Lrsb96wyl+WN8rO+GxTFczL4/LYePvGxqrGDM8g4uipUDKTCCCcIadgVh4YxVFbdA2B7Cziu8UrVG/CAtg18awrVACAh0FUl5HcqxY3c1iqRXsNk2gWjiMbgr2K5mfmUNiL9bJ6IrqK3H/1ZUBYkPtXAyh83M2oCwVu3INiqGhniQNQh3ZQuEiMgi/+esW8WDD+J7RQ+sULdirfkfz0OwF5m+IcFy39aF/VbLVkErpe/KhvJdBYg8pyDPGjfeKGWSUzLrbpX/5RcJ6E/x8tJ9hf5PS35BBUoI6o7jHi6Txk7E0DVM9d4qPIAk2Umx0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 14:50:55 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 14:50:55 +0000
Date:   Wed, 18 Oct 2023 22:50:46 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        <linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/numa]  f169c62ff7:
 autonuma-benchmark.numa01.seconds -32.0% improvement
Message-ID: <202310182223.6ef26fcb-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: acefa347-a1fd-4655-93b7-08dbcfe9a1c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2at6+OxCDSRwzJ/DDr91zNCasvvyAhTwguVRaYBQkuxXzP2fwm6oYA0vvVl1DWO4gNo9rOQ8c+R5OWS1oMSOkN5mbaMYK3v4Etz/7gAN+0qMsJYRejz3UYaN0TGmchyy0JJm47u1uxcsKkyNO4lVJiH2/e/82pfd4F0BbHIXAjERSgPFcny/ay9vHPU3XOog35fNkajQsrHMTKsJK5GIRxw+PXPvhkkeRmpfpybidvIbmbqH3ALGfOn7sNsaqbAUKT8gYRc2smnW6bNA40xyl8Iy15QP3dNqvuuswofC66pj6p2Puq95JGcmkBHaiI8cF/PVa7Voba/Rj8gd7eXnyi2ZoD2yIKqddoM6Tz1ecoPjgwSq28GtEWSSEtfMDzMiEqDFJwl+Q8rJ4sTi5y/RaEsAOCwrxim13GObcASQO8ONjub5Br7SN8ZWKZr3LPb4qyATezaF94k7eGzP2ggMNeP2Mm5fzzJqymIrBWL/pi+4JOpCmNN1ni7kfm19TZP+af+Jf6gwR9Lcq5If1Yi52jikXFMJoLRKVnL76aNlC/I/kbgyINJsaxA5i4amiSRRmF5kdWwPlt1i7fLwhTXew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82960400001)(26005)(2616005)(1076003)(8936002)(8676002)(4326008)(5660300002)(38100700002)(83380400001)(478600001)(2906002)(6486002)(966005)(41300700001)(86362001)(30864003)(6512007)(316002)(6666004)(6506007)(66946007)(66476007)(54906003)(36756003)(66556008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RrYl/jkGDvlhUiW0Xmb+THBhOGjtRDOEwsBPda0xJAjz6JuBgDlGZuw8Y/?=
 =?iso-8859-1?Q?HIv1Ru6y2NU7GlNLKQ+ipA8Zz8Cqubhz1anlDnq5p1GUC1iXePmkI1aSNy?=
 =?iso-8859-1?Q?FABe714HVb+OL9ABlrDz+PFHOkbM94aqX96hdYSk4pBIfOQhXzKdkr1VXC?=
 =?iso-8859-1?Q?Taw4+npO2iuoRgHrLytuAWcPx4czyNJm5ad3H/PV7RvA9gZDIr/W81Z0qm?=
 =?iso-8859-1?Q?h6ElBH8Bm1DtgO9Grt4A1BrZYDita0o3JdzTuVjGLHbX/XaKri+iejwlBO?=
 =?iso-8859-1?Q?UIGbC5ZkauoFZ6KJNuCZwrzTnJx3PldN2beBIy3zYa2kI43vTiuAkFy3t1?=
 =?iso-8859-1?Q?VksKHQnSk3ciKyshjCYMtfrd+2WrjUFk3wX8h3/6tORgmnaeI53IngpRzW?=
 =?iso-8859-1?Q?1wBpKWh3bsOrfIr+fCUXLcZfedIKC2t3yZsOxrbC2Cj/ZMm8vFdjvVRPkE?=
 =?iso-8859-1?Q?tTylGM7P5c/UN54FoBCBDvBJEaG9gkOM8k954LPJYONzRs+pNBq1+DiRE9?=
 =?iso-8859-1?Q?2dDBcNDdv0YVh9+hbs7SaQaVefeSVNLnGPB3HidBy3/wTtTmIqI0fpIWZ4?=
 =?iso-8859-1?Q?zJ02ja9KdX0r1wRJSofHPCGScIFReSfjsHG+UsyGgjFhcYbYWQGGQsMrj/?=
 =?iso-8859-1?Q?/OeNrB4AwUExLA6nOKl/0h4tvmdz2uEJQ8PSe+T2cya4G54p0qlzIf7ak/?=
 =?iso-8859-1?Q?W1MQcsHPAtw6b+BTn+cqCTlum2pmzidwyLMLmMo/o6XcjONdIiuCHeaXvv?=
 =?iso-8859-1?Q?t6nk5ulEojxLSEHgRNSiDyl3ZcDamKdkA/z6dLWqg+FEA+zvqR/9z+jZIC?=
 =?iso-8859-1?Q?YaGNbGFVWecnVMX2/I3+yNVf33CKxa6yEudihj2rtibao4yOYYYCeQ1JBx?=
 =?iso-8859-1?Q?1S9kKksnaRHpP7L9q7xeeu6u4bjYDYNhYgPAmX/zHGUNimEfi94mgTzIp6?=
 =?iso-8859-1?Q?/vt58O1CJjdo+Ox6M8uoGYUJBSe9UaZUx9Z9yQcQKD+EjAXGKqV+TFsj1+?=
 =?iso-8859-1?Q?6HoNVxHFivArtTjMyBpHBttfwPaqV46g5kEpVp+oheox78JzxR8z+E5jCx?=
 =?iso-8859-1?Q?OsSkUbFSs3qdmL14U9sKe1dZBz4c68O0Ld+z1qGliptPcmthA3j34D9Zgi?=
 =?iso-8859-1?Q?s2xagptP53FsIShDlliGz81RRT2t/QLIIsYCDRCV1dQtJlEkuad9u8DJu7?=
 =?iso-8859-1?Q?hUhz12+NnRYnmaepCYJUuJvKxU7fT1IP4DtkMMXdYb0pHkOEUIfXoyunWB?=
 =?iso-8859-1?Q?eozim8zEqmSppfKliDtdAnggOtoxcunHhU5+2mQC3kk+sRofl+S6RS9tVu?=
 =?iso-8859-1?Q?WeRTanqRAGUt4wxOsNfENLjW0jVwUOridHlDWS4BnLsewjp2SliWziawuS?=
 =?iso-8859-1?Q?vqci756joRotiHb6Ug3MKPMxMVCnMbHFBKJ7Isc1YkiSHhHCfSz9i30s3H?=
 =?iso-8859-1?Q?p+HcSmojcKNlnVv1bHzlDNCgMC0RqK2Nlv8FhNeVrUz8cKgQhLQjIqGjqA?=
 =?iso-8859-1?Q?wzk2hWdsbY+1vI1qbTTjXcgXglwQRZdl+qq7SBMpOhRqLWM65tcKBKYLhS?=
 =?iso-8859-1?Q?tFGOeKLpiddKQvsjeZi2jK8F4idD/ZyR6Tfl8QU/6WFkCifft2z+ZnLlIk?=
 =?iso-8859-1?Q?U+sW9w71n3+oWRmvMz7H01VyXJPyI9Ras7z4yIkhrAVpP3aOW7231+xg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acefa347-a1fd-4655-93b7-08dbcfe9a1c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:50:55.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O7mXk1eSKH2+MCSdTNXvWOJd/+0TPKOY45FY22i9mFtrOX3I75wgMr3vCEGcsHr+M07IXt3G0ydGn+XOu5orw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -32.0% improvement of autonuma-benchmark.numa01.seconds on:


commit: f169c62ff7cd1acf8bac8ae17bfeafa307d9e6fa ("sched/numa: Complete scanning of inactive VMAs when there is no alternative")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: autonuma-benchmark
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	iterations: 4x
	test: _HARD_BIND
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231018/202310182223.6ef26fcb-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/_HARD_BIND/autonuma-benchmark

commit: 
  b7a5b537c5 ("sched/numa: Complete scanning of partial VMAs regardless of PID activity")
  f169c62ff7 ("sched/numa: Complete scanning of inactive VMAs when there is no alternative")

b7a5b537c55c088d f169c62ff7cd1acf8bac8ae17bf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.00 ± 58%   +3290.8%       0.06 ± 30%  vmstat.procs.b
 2.101e+10 ±  6%     -47.7%  1.099e+10 ±  5%  cpuidle..time
  21679574 ±  6%     -47.8%   11321089 ±  5%  cpuidle..usage
      2441           -25.2%       1826 ±  2%  uptime.boot
     25666 ±  5%     -40.3%      15332 ±  3%  uptime.idle
    208968 ±  8%     -11.6%     184676 ±  3%  meminfo.Active
    208280 ±  8%     -11.7%     183990 ±  3%  meminfo.Active(anon)
    221680 ±  8%     -11.7%     195741 ±  2%  meminfo.Shmem
   3154708 ±  7%     -12.1%    2773727 ±  4%  numa-numastat.node0.local_node
   3621021 ±  4%     -12.9%    3154008 ±  3%  numa-numastat.node0.numa_hit
   3424075 ±  5%     -19.2%    2767342 ±  3%  numa-numastat.node1.local_node
   3659250 ±  4%     -15.8%    3079449 ±  3%  numa-numastat.node1.numa_hit
   3620012 ±  4%     -12.9%    3153670 ±  3%  numa-vmstat.node0.numa_hit
   3153693 ±  7%     -12.1%    2773388 ±  4%  numa-vmstat.node0.numa_local
   3657708 ±  4%     -15.8%    3078660 ±  3%  numa-vmstat.node1.numa_hit
   3422533 ±  5%     -19.2%    2766552 ±  3%  numa-vmstat.node1.numa_local
      0.03 ± 31%    +840.9%       0.29 ±179%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.34 ± 49%     -83.7%       0.38 ±194%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
    948.50 ± 16%     -30.3%     661.33 ± 20%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1142 ±  9%     -24.3%     865.00 ±  9%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.20 ±  6%      -2.8        6.43 ±  5%  mpstat.cpu.all.idle%
      0.00 ± 14%      +0.0        0.03 ± 28%  mpstat.cpu.all.iowait%
      2.25            -0.5        1.73        mpstat.cpu.all.irq%
      0.08 ±  3%      -0.0        0.06 ±  2%  mpstat.cpu.all.soft%
      2.18 ±  4%      +0.5        2.69 ±  2%  mpstat.cpu.all.sys%
    474.78           -32.0%     322.76 ±  2%  autonuma-benchmark.numa01.seconds
      2386           -25.7%       1774 ±  2%  autonuma-benchmark.time.elapsed_time
      2386           -25.7%       1774 ±  2%  autonuma-benchmark.time.elapsed_time.max
   1298583 ±  2%     -24.3%     983395 ±  3%  autonuma-benchmark.time.involuntary_context_switches
   3120169            -6.0%    2932947        autonuma-benchmark.time.minor_page_faults
      8443            +3.9%       8771        autonuma-benchmark.time.percent_of_cpu_this_job_got
    197252           -23.2%     151486 ±  2%  autonuma-benchmark.time.user_time
     26055           +45.4%      37896 ±  8%  autonuma-benchmark.time.voluntary_context_switches
     42526 ±  9%     -15.6%      35892 ± 10%  turbostat.C1
      0.03            +0.0        0.05 ± 20%  turbostat.C1E%
  21430219 ±  6%     -48.2%   11099622 ±  5%  turbostat.C6
      9.14 ±  6%      -2.7        6.40 ±  5%  turbostat.C6%
      8.80 ±  6%     -31.1%       6.06 ±  5%  turbostat.CPU%c1
  2.31e+08           -24.9%  1.735e+08 ±  2%  turbostat.IRQ
     37846 ±  7%     -29.3%      26768 ±  9%  turbostat.POLL
    283.70            +3.1%     292.44        turbostat.PkgWatt
     63.32           +16.3%      73.65        turbostat.RAMWatt
     52079 ±  8%     -11.6%      46034 ±  3%  proc-vmstat.nr_active_anon
   1560738            -1.8%    1532470        proc-vmstat.nr_anon_pages
      3000            -2.2%       2934        proc-vmstat.nr_anon_transparent_hugepages
    754040            -0.9%     747564        proc-vmstat.nr_file_pages
   1564055            -1.8%    1535343        proc-vmstat.nr_inactive_anon
      3964            -1.4%       3911        proc-vmstat.nr_page_table_pages
     55430 ±  8%     -11.7%      48954 ±  2%  proc-vmstat.nr_shmem
     52079 ±  8%     -11.6%      46034 ±  3%  proc-vmstat.nr_zone_active_anon
   1564055            -1.8%    1535343        proc-vmstat.nr_zone_inactive_anon
     31021 ±  4%    +356.7%     141673 ±  3%  proc-vmstat.numa_hint_faults
     26070 ± 14%    +232.5%      86687 ±  5%  proc-vmstat.numa_hint_faults_local
   7281579           -14.4%    6235148        proc-vmstat.numa_hit
      2255 ±  9%   +3726.0%      86295 ±  3%  proc-vmstat.numa_huge_pte_updates
   6580091           -15.8%    5542759        proc-vmstat.numa_local
    490705         +1551.4%    8103581 ±  3%  proc-vmstat.numa_pages_migrated
   1256422 ±  9%   +3426.6%   44309531 ±  3%  proc-vmstat.numa_pte_updates
   8560551           -16.7%    7127497        proc-vmstat.pgfault
    490705         +1551.4%    8103581 ±  3%  proc-vmstat.pgmigrate_success
    370032 ±  2%     -19.7%     296973 ±  2%  proc-vmstat.pgreuse
    951.67         +1560.5%      15802 ±  3%  proc-vmstat.thp_migration_success
  17842432           -25.5%   13288960 ±  2%  proc-vmstat.unevictable_pgs_scanned
 1.408e+08 ±  2%     -26.2%   1.04e+08 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
 1.476e+08 ±  2%     -27.3%  1.073e+08 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
 1.252e+08           -24.9%   94038602 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   4459866 ±  7%     -40.1%    2672703 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.22 ±  4%     -10.8%       0.20 ±  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
 1.408e+08 ±  2%     -26.2%   1.04e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.476e+08 ±  2%     -27.3%  1.073e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
 1.252e+08           -24.9%   94038602 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   4459866 ±  7%     -40.1%    2672703 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
    131.57 ± 11%     -17.7%     108.34 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      6.43 ± 26%   +4528.1%     297.67 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    289.38 ±  9%    +195.6%     855.43 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
     37.21 ± 11%    +508.1%     226.25 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    827702 ±  3%     -12.7%     722480 ±  6%  sched_debug.cpu.avg_idle.min
    306806 ±  5%     -18.8%     249093 ±  5%  sched_debug.cpu.avg_idle.stddev
   1219552 ±  2%     -25.7%     906296 ±  2%  sched_debug.cpu.clock.avg
   1219905 ±  2%     -25.7%     906607 ±  2%  sched_debug.cpu.clock.max
   1219166 ±  2%     -25.7%     905967 ±  2%  sched_debug.cpu.clock.min
    212.97 ±  6%     -13.3%     184.61 ± 11%  sched_debug.cpu.clock.stddev
   1191500 ±  2%     -25.3%     890437 ±  2%  sched_debug.cpu.clock_task.avg
   1199519 ±  2%     -25.6%     892331 ±  2%  sched_debug.cpu.clock_task.max
   1176815 ±  2%     -25.1%     881433 ±  2%  sched_debug.cpu.clock_task.min
      7162 ± 46%     -77.7%       1593 ± 19%  sched_debug.cpu.clock_task.stddev
     28968 ±  4%     -16.3%      24235 ±  6%  sched_debug.cpu.curr->pid.avg
     36717           -20.7%      29133 ±  2%  sched_debug.cpu.curr->pid.max
      3810 ± 11%     -34.7%       2487 ± 11%  sched_debug.cpu.curr->pid.stddev
   1074237           -17.0%     892137 ±  6%  sched_debug.cpu.max_idle_balance_cost.max
    137289 ±  3%     -43.4%      77712 ± 11%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  6%     -13.2%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.23 ±  3%     -10.5%       0.20 ±  4%  sched_debug.cpu.nr_running.stddev
     22190 ±  2%     -23.8%      16898 ±  3%  sched_debug.cpu.nr_switches.avg
      9201 ±  4%     -15.7%       7756 ±  6%  sched_debug.cpu.nr_switches.min
     10098 ±  3%     -15.0%       8588 ±  7%  sched_debug.cpu.nr_switches.stddev
      7.02 ± 10%     +43.9%      10.10 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
   1219153 ±  2%     -25.7%     905956 ±  2%  sched_debug.cpu_clk
   1218584 ±  2%     -25.7%     905387 ±  2%  sched_debug.ktime
   1219711 ±  2%     -25.7%     906506 ±  2%  sched_debug.sched_clk
     26.19           +28.8%      33.74        perf-stat.i.MPKI
 1.144e+08            +4.0%   1.19e+08        perf-stat.i.branch-instructions
      1.46            -0.1        1.37        perf-stat.i.branch-miss-rate%
     63.10            +3.1       66.21        perf-stat.i.cache-miss-rate%
  14186186           +29.8%   18412463        perf-stat.i.cache-misses
  22674336           +24.7%   28269331        perf-stat.i.cache-references
    502.02            +2.0%     512.29        perf-stat.i.cpi
 2.643e+11            +3.9%  2.745e+11        perf-stat.i.cpu-cycles
    126.73            +7.2%     135.83        perf-stat.i.cpu-migrations
     21465           -23.4%      16442        perf-stat.i.cycles-between-cache-misses
 1.572e+08            +3.2%  1.623e+08        perf-stat.i.dTLB-loads
      0.27            +0.0        0.29        perf-stat.i.dTLB-store-miss-rate%
    223732            +9.2%     244255        perf-stat.i.dTLB-store-misses
  88029014            +3.0%   90626204        perf-stat.i.dTLB-stores
     80.17            +1.7       81.85        perf-stat.i.iTLB-load-miss-rate%
    314646           -16.1%     263974 ±  5%  perf-stat.i.iTLB-loads
 5.846e+08            +3.7%  6.063e+08        perf-stat.i.instructions
      1246 ±  2%     +13.7%       1416 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      2.75            +3.9%       2.86        perf-stat.i.metric.GHz
      2.57            +9.1%       2.81        perf-stat.i.metric.M/sec
      3527           +10.9%       3913        perf-stat.i.minor-faults
    233066           +31.7%     306835        perf-stat.i.node-load-misses
    238123           +13.9%     271245        perf-stat.i.node-loads
   3112998           +44.6%    4502856 ±  2%  perf-stat.i.node-store-misses
   9385414           +24.5%   11686725 ±  2%  perf-stat.i.node-stores
      3527           +10.9%       3913        perf-stat.i.page-faults
     24.08           +25.2%      30.16        perf-stat.overall.MPKI
      1.54            -0.1        1.49        perf-stat.overall.branch-miss-rate%
     63.01            +2.4       65.42        perf-stat.overall.cache-miss-rate%
     19050           -20.6%      15118        perf-stat.overall.cycles-between-cache-misses
      0.25            +0.0        0.27        perf-stat.overall.dTLB-store-miss-rate%
     62.66            +2.2       64.86        perf-stat.overall.iTLB-load-miss-rate%
      1161 ±  4%     +10.8%       1286 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
     49.19            +3.7       52.85        perf-stat.overall.node-load-miss-rate%
     26.10            +2.6       28.67 ±  2%  perf-stat.overall.node-store-miss-rate%
 1.134e+08            +4.5%  1.185e+08        perf-stat.ps.branch-instructions
  13962667           +30.4%   18209922        perf-stat.ps.cache-misses
  22159412           +25.6%   27835158        perf-stat.ps.cache-references
  2.66e+11            +3.5%  2.752e+11        perf-stat.ps.cpu-cycles
    126.06            +7.4%     135.36        perf-stat.ps.cpu-migrations
  1.56e+08            +3.6%  1.617e+08        perf-stat.ps.dTLB-loads
    222631            +9.1%     242846        perf-stat.ps.dTLB-store-misses
  87353212            +3.2%   90174337        perf-stat.ps.dTLB-stores
    297718 ±  2%     -14.4%     254772 ±  5%  perf-stat.ps.iTLB-loads
 5.797e+08            +4.1%  6.038e+08        perf-stat.ps.instructions
      3454           +11.6%       3856        perf-stat.ps.minor-faults
    231688           +32.7%     307530        perf-stat.ps.node-load-misses
    239364           +14.6%     274365 ±  2%  perf-stat.ps.node-loads
   3208117           +42.8%    4581795 ±  2%  perf-stat.ps.node-store-misses
   9084897           +25.5%   11404755 ±  2%  perf-stat.ps.node-stores
      3455           +11.6%       3856        perf-stat.ps.page-faults
 1.384e+12           -22.6%  1.072e+12        perf-stat.total.instructions
     45.09 ± 10%     -30.4       14.72 ± 55%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.07 ± 30%      -1.9        2.14 ± 40%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      4.07 ± 30%      -1.9        2.14 ± 40%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      4.07 ± 30%      -1.9        2.14 ± 40%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.74 ± 33%      -1.2        0.57 ± 72%  perf-profile.calltrace.cycles-pp.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      1.75 ± 33%      -1.2        0.58 ± 73%  perf-profile.calltrace.cycles-pp.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      1.74 ± 33%      -1.2        0.58 ± 73%  perf-profile.calltrace.cycles-pp.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      1.69 ± 33%      -1.1        0.55 ± 72%  perf-profile.calltrace.cycles-pp.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread
      1.58 ± 33%      -1.1        0.51 ± 72%  perf-profile.calltrace.cycles-pp.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged
      1.38 ± 32%      -0.9        0.45 ± 72%  perf-profile.calltrace.cycles-pp.copy_mc_fragile.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot
      1.90 ± 17%      -0.9        0.99 ± 54%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      1.20 ± 18%      -0.6        0.55 ± 75%  perf-profile.calltrace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.dispatch_events
      1.20 ± 18%      -0.6        0.55 ± 75%  perf-profile.calltrace.cycles-pp.__libc_read.readn.evsel__read_counter.read_counters.process_interval
      1.17 ± 19%      -0.6        0.54 ± 75%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.readn.evsel__read_counter.read_counters
      1.17 ± 19%      -0.6        0.54 ± 75%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn.evsel__read_counter
     46.12 ± 10%     -30.1       15.98 ± 51%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.07 ± 30%      -1.9        2.14 ± 40%  perf-profile.children.cycles-pp.kthread
      1.74 ± 33%      -1.1        0.67 ± 42%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      1.74 ± 33%      -1.1        0.67 ± 43%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      1.75 ± 33%      -1.1        0.68 ± 43%  perf-profile.children.cycles-pp.khugepaged
      1.69 ± 33%      -1.0        0.64 ± 41%  perf-profile.children.cycles-pp.collapse_huge_page
      1.58 ± 33%      -1.0        0.60 ± 41%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      1.90 ± 17%      -0.9        1.05 ± 42%  perf-profile.children.cycles-pp.evsel__read_counter
      1.92 ± 18%      -0.8        1.10 ± 44%  perf-profile.children.cycles-pp.readn
      1.92 ± 18%      -0.8        1.10 ± 44%  perf-profile.children.cycles-pp.__libc_read
      0.87 ± 15%      -0.4        0.51 ± 38%  perf-profile.children.cycles-pp.do_anonymous_page
      0.65 ± 16%      -0.2        0.42 ± 37%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.46 ± 26%      -0.2        0.23 ± 45%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.44 ± 22%      -0.2        0.24 ± 46%  perf-profile.children.cycles-pp.mprotect_fixup
      0.40 ± 18%      -0.2        0.21 ± 41%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.24 ± 46%      -0.2        0.07 ± 64%  perf-profile.children.cycles-pp.start_thread
      0.23 ± 45%      -0.2        0.07 ± 64%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.40 ± 17%      -0.2        0.25 ± 34%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.28 ± 19%      -0.1        0.14 ± 40%  perf-profile.children.cycles-pp.__fget_light
      0.26 ± 32%      -0.1        0.13 ± 33%  perf-profile.children.cycles-pp.pte_alloc_one
      0.18 ± 43%      -0.1        0.06 ± 80%  perf-profile.children.cycles-pp.__collapse_huge_page_copy_succeeded
      0.16 ± 30%      -0.1        0.04 ±109%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.30 ± 21%      -0.1        0.19 ± 40%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.19 ± 16%      -0.1        0.09 ± 62%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.22 ± 22%      -0.1        0.12 ± 27%  perf-profile.children.cycles-pp.shift_arg_pages
      0.15 ± 33%      -0.1        0.06 ± 71%  perf-profile.children.cycles-pp.xas_find
      0.12 ± 26%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.15 ± 28%      -0.1        0.06 ± 63%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.14 ± 27%      -0.1        0.06 ± 71%  perf-profile.children.cycles-pp.try_charge_memcg
      0.19 ± 29%      -0.1        0.11 ± 51%  perf-profile.children.cycles-pp.down_write
      0.17 ± 32%      -0.1        0.09 ± 39%  perf-profile.children.cycles-pp.__pte_alloc
      0.10 ± 32%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.blk_mq_queue_tag_busy_iter
      0.15 ± 16%      -0.1        0.08 ± 54%  perf-profile.children.cycles-pp.vsnprintf
      0.10 ± 32%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.blk_mq_in_flight
      0.12 ± 20%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.slab_show
      0.16 ± 24%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.__get_free_pages
      0.09 ± 35%      -0.1        0.04 ± 79%  perf-profile.children.cycles-pp.lookup_open
      0.00            +0.3        0.27 ± 57%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.03 ±100%      +0.3        0.33 ± 50%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.4        0.38 ± 53%  perf-profile.children.cycles-pp.sysvec_call_function
      0.04 ± 80%      +1.6        1.67 ± 58%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     43.32 ± 10%     -29.9       13.42 ± 61%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.40 ± 17%      -0.2        0.20 ± 41%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.28 ± 19%      -0.1        0.13 ± 40%  perf-profile.self.cycles-pp.__fget_light
      0.24 ± 30%      -0.1        0.12 ± 29%  perf-profile.self.cycles-pp.zap_pte_range
      0.14 ± 28%      -0.1        0.06 ± 76%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.13 ± 30%      -0.1        0.05 ± 75%  perf-profile.self.cycles-pp.try_charge_memcg
      0.17 ± 27%      -0.1        0.10 ± 51%  perf-profile.self.cycles-pp.down_write
      0.10 ± 31%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.blk_mq_queue_tag_busy_iter
      0.13 ± 30%      -0.1        0.06 ± 65%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.11 ± 30%      -0.1        0.05 ± 75%  perf-profile.self.cycles-pp.mutex_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

