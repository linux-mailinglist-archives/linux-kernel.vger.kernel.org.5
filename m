Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65AD7FC1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbjK1PIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbjK1PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:08:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A51B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701184125; x=1732720125;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1QyUdTU/KWciEHRb7UDaUP0eHS65UW1rFva1Drvcztw=;
  b=QgUh3Cex9RPmT0mLxJeNAzw9OT23qBsKqlpfMQW8yl8hFqj7batDvlAh
   bJZBZLiqOCXAN4Lmi4wi9Vf4tXkn1d+n/+oCw5KJ+ix/sMW8mtM7cfuYN
   BvfWxOLeGrsJYjwIz29Nx2Ft98OrNYQ4vip/c/wSyTrmSioHVG0qWmemh
   Kq3yyXQVdzC6I0laATC3YbHTBShnNPEp3UunIhq+ui8/p1vEcceBeM5z5
   wlt3dfGuk+mDI7WB8anlNb81ZaeQUOB/brJNi+5C2f2rsfcVxjQoLE4Xa
   18/c5a2Gy0EK7uYVl3m69BIeAibkb1oP2F5m693Sp91YxOq56MfphT4b/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457267721"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457267721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859453459"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859453459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 07:08:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 07:08:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 07:08:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 07:08:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT7N4Q8xfIHGzLeOVNvcFGxmBAX3xcdEwx+3h0QVU0zT0CTIm3OzA/3Cn2CAevV7DbbXbp9iNGyyUhG94mAA/X4YzL8mWYU8qYPs66Bv1gBGebEdY0wa3hCOGdm5Vno0ClL75jnDk09TDPGQ09x2NIxaSn+lEE+tVc+YF+Se/y4UwlycNoJw0fXsQHn/E/JQtyrLda8N4QvVndsA51O5EYIY94xh5jp+YJEEVvgDlqX2GzPjVaZ1Av/8jipBDy2e1+HZj5724jMw1DTZxR7MSf7ImJdYVNIC5zPYW0PGOVgwYebwiCmRi9+JPkCfWjdls7l55+HhnTxDR5WdPGoEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt03n6ZwaOlQYmu+gcJNep46nc3hSti/oG7EwhDrubw=;
 b=MS+EqfRtrZ+jHU73dqTsqsOoy6854pYl9tQq3f5nWBoEDxoG7YPwSuk/ij8GsL3gYm1w8zxMwu/xKGVGxjIti+6aKACx1CPwh6TVWRf1QyjG/pZXlR0WD68V/2igq4vSZnY5pXpSV8ZrqrQtT73kOWzblnnHp+sKbFGuY+SRPgFN8J9L+fwhzbKfHSC5IFAzbaxRhZMOUlOGO8J3HMtMbY/iaFXBXMgjwrw39oiQ3ulGHfFOSPZSkHEEb0kUScnGej2PbubolIFEDG81eVxE2J0XrPzbtYqm1p/SP5EwOhpzRki20ImojHU4T25E+8/OsvC6Mfvh4ZUtcXfhlQWYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 15:08:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 15:08:40 +0000
Date:   Tue, 28 Nov 2023 23:08:30 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/deadline]  63ba8422f8:
 stress-ng.cyclic.ops_per_sec 1.6% improvement
Message-ID: <202311282250.9aabf7b9-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ca7b37-f9ee-4d49-07e4-08dbf023e770
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZAylnh7OQfNxckmRgcnfj4YAMcNc6j9AH0eIkkyUrbR+bMrutFf5s25H1R3e0tvjo0umeNO9VNm6jEcfyChWuZy41vSY6R9qVJXS19Nn9VmNr9dqyvJoben/O4JfZFhcIglRmmoqRKpQSkzWMhekFDtvM6xPBeGq4ffRmxrfEqA7YL1+j1PQ/0G5956RwmYOIOTEq3IBTSEzBcof101Q8/ejV3OfhYoe+vwQnpq9v0XI+45nPDcR/uqqfRbSFrA5OGHiAPP7qodW0Etj3HyYCCM3krwHRLtslMaAYX4M7hFMYSLP4lbp+HllWLtruVwD91sW5ha6al2QlSKqzUlkzSvBvW0yA1k7Tt3AkcOuv4KribXRdcw2IaVm6fZ8wkPto8002fjgM0HIjPEGJ2hFDatv0j74599E1NI1K6ajPDWLtjMSvIIt685j3T1QqjkJnSPC9k5uGEaFr7ps5bxWG4AtsMzSeOkxtz+BIWkHFf3VKuBjtC37UGXZkbSLlwGtY6GZ2RRiq2k5Wn9Jf/odtJ7FxQ5QdcXMVYhlNZgO8+FG6NoKsgxzrNIDWaVm7hNqdSkTdrNf4bRitsKlazDRrvSHtJ9v9zqxZ7azAuKT8hQsjOSwqgqtPOPKEbqKG2JpGgJiiCWkn/di10jk28kbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230373577357003)(230473577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(6666004)(8936002)(8676002)(6512007)(6506007)(6916009)(66946007)(66556008)(66476007)(316002)(6486002)(478600001)(966005)(30864003)(36756003)(38100700002)(41300700001)(1076003)(86362001)(26005)(2906002)(2616005)(83380400001)(5660300002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bC36IMaJkuVf8SKKzYFMVoW0Lo2RlsmQAtYupYfRUAHRxbLlhjJS6Q8kzu?=
 =?iso-8859-1?Q?gk8Bp5A12K/iX0Z6QLD2hNjloCp+BFZtZbWKz5VBwpCLRXtma/2DelbWxC?=
 =?iso-8859-1?Q?WZvLGmh3HywRv/qE2cMKt3RpkS0/WfyAoH+5/IGoMyPm4zL3jxoW6W1u9w?=
 =?iso-8859-1?Q?r3GOszZw0xT8mrRsSWNifZCbI7aZX48IFbJrQ5UFtw0K+SgTbB00I1nFn/?=
 =?iso-8859-1?Q?QcJgn3/ersVCdk49iFFLAIsR/O0tBLf6X6nryQbq4mxJmPERYMK1X3MvcZ?=
 =?iso-8859-1?Q?2rmhII2TWUyXNYMeW4X0iHVFP7f3/+OFPMADN+vldcb6Wg/bcS5na0JpdP?=
 =?iso-8859-1?Q?miMWHGtEUsuRS6LReDcpS4Cav7Idv7TlF4rK3p2PIPcoPGNhxwGC/zhV4Q?=
 =?iso-8859-1?Q?ecCSwaBW91uPWaZtyNSWtqOx7X+xLn2tbN9kkMAzqtMkG57+GuKX21fHRd?=
 =?iso-8859-1?Q?GVfx6W5ZKDjE6Z7AaYqxJZK6pSUgzr90vzEaG0nM6OK+XC8YVvWYl09ksn?=
 =?iso-8859-1?Q?TOuoiSmPPrPwHGGlwzn7FqZt9qbRKpYzdGYBslUzmpNnXibaqtnfX93ZPU?=
 =?iso-8859-1?Q?GpERSombaMoszEknKlggKSxWkuCh3lupM1lxN3V5+5VmuMkfuSGDZ9zQHC?=
 =?iso-8859-1?Q?oepWi70pECp1Yf3fregUTFOLHQ1SLM6IgliiWMKAIWfewawXrQocjNEmnJ?=
 =?iso-8859-1?Q?d9WL3/VeQnMC5Fd/6/kBykU5krDqtJA+29Qp3B7tgumgR3sMA6GrPwYn9b?=
 =?iso-8859-1?Q?HuAIzGdn3849WmIVcQN+3V/6TB9g9rBHCy+g8l5nsisERSaibqxXGh9ZV4?=
 =?iso-8859-1?Q?cLleAT30KrNhPOX0+ftoHXZxos/hfNnu9dP9HfMrCaFk5MfkbsES0n13QB?=
 =?iso-8859-1?Q?ceb1IiN9z8+slKlQB33+8QsQ0eznUlG7wikNqVgGEb5DCODrq4l8PdyFMZ?=
 =?iso-8859-1?Q?2j4VGR6c+rQYa+VW0k9IhaRXzyrUkGWNau3WbWOpGLVwyyoNkA3HqqfgPe?=
 =?iso-8859-1?Q?hWM/oM4WL8gYU4F5/7q+tGBLzCIfFeDHKODv5C9InX6aPq3/bWP/3iJV5z?=
 =?iso-8859-1?Q?V8AChnI/1WQ+u8icHIBJ0hiPa1VK0wDO/T/Ods6/s3lgcip49DAzHMjRqZ?=
 =?iso-8859-1?Q?ymD5lvE3gxwMBTnKWGqLf9b/qIpzShPKlAEwE9qgIFn4jv//Dou35XuOkG?=
 =?iso-8859-1?Q?zGUEdWnqH4+iqOzTFNneOf2vFdbj8WJukVi9DOPR3ho5oF6AP0P/wfIAyG?=
 =?iso-8859-1?Q?ktkzkIVey1ndtxanM6rz0o0KwwThOrNJmeFCKsqb1YAavlFfhi1GVARVoG?=
 =?iso-8859-1?Q?zfJ584m7PeW7d4qtjMAgUlFHE9TAIRixDJCIjjcmnD8FD/De0eOwokNDtB?=
 =?iso-8859-1?Q?GmVGD3H7Ez+hcdzaRSKza39NBPIfXtHpapG3e2GPiBru0FTXVmkUMCXhBN?=
 =?iso-8859-1?Q?cDMS+sI8OJSMgJtfLkCwLnOPmNVarIo1pVKn3A4GIRTKZTTlW69PrLnNk8?=
 =?iso-8859-1?Q?2dyfu+dc8xlauf2dCZbxTonXn4eVgWcn3Y7Jp+tqI63VggpHDogEciEpZA?=
 =?iso-8859-1?Q?ETLluZ6ye5mVqWwmndaDEgjAiK1/Be9afa09vhROj+ET23maImOkdrlfrE?=
 =?iso-8859-1?Q?fI8e1xApfXjLYEe0GQ2pFGiRxEroM/WAsWZrjMiGBjZU7AsugttkDhUQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ca7b37-f9ee-4d49-07e4-08dbf023e770
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:08:40.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E01BDyoCQwyc+TJeENFPaoYSfblmzj294zcMnLn8fayfucf/XaKimUklBeHBLc0aSKnIe+/OzlftAFpvqn2Fqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
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

kernel test robot noticed a 1.6% improvement of stress-ng.cyclic.ops_per_sec on:


commit: 63ba8422f876e32ee564ea95da9a7313b13ff0a1 ("sched/deadline: Introduce deadline servers")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: cyclic
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231128/202311282250.9aabf7b9-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/cyclic/stress-ng/60s

commit: 
  2f7a0f5894 ("sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity")
  63ba8422f8 ("sched/deadline: Introduce deadline servers")

2f7a0f58948d8231 63ba8422f876e32ee564ea95da9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3727107           +77.4%    6611892 ± 76%  cpuidle..usage
      0.15            -0.0        0.12 ± 26%  mpstat.cpu.all.sys%
    570282            +1.6%     579142        stress-ng.cyclic.ops
      9504            +1.6%       9652        stress-ng.cyclic.ops_per_sec
    570463            +1.6%     579323        stress-ng.time.voluntary_context_switches
     18653           +13.8%      21233 ± 18%  proc-vmstat.nr_active_anon
     20747           +11.7%      23171 ± 14%  proc-vmstat.nr_shmem
     18653           +13.8%      21233 ± 18%  proc-vmstat.nr_zone_active_anon
     28307            +5.3%      29809        proc-vmstat.pgactivate
     52.33           +27.1%      66.50 ±  5%  turbostat.Avg_MHz
     32506 ± 23%   +2687.6%     906150        turbostat.C1
      0.14 ± 17%      +1.1        1.26 ± 37%  turbostat.C1%
   1500076           -16.4%    1253940 ±  2%  turbostat.C1E
      4.99            -1.7        3.34 ± 34%  turbostat.C1E%
      4.33 ± 18%    +263.7%      15.76 ± 61%  turbostat.CPU%c6
      0.30           -28.7%       0.21 ± 34%  turbostat.IPC
   3796031           +75.9%    6678998 ± 75%  turbostat.IRQ
     13917 ±  5%     +70.9%      23779 ± 53%  turbostat.POLL
     10.13            -5.1%       9.61 ±  2%  turbostat.RAMWatt
      0.01 ±  7%     -33.9%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00           -50.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 16%     -43.3%       0.00 ± 24%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  7%     -58.1%       0.00 ± 49%  perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 16%     -45.7%       0.00 ± 21%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 17%     -53.8%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 14%     -40.0%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 17%     -38.2%       0.01 ± 24%  perf-sched.sch_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.01 ± 11%     -37.3%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.01 ± 10%     -29.2%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  9%     -37.9%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 18%     -55.2%       0.01 ± 40%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  7%     -58.1%       0.00 ± 49%  perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.00           -50.0%       0.00        perf-sched.total_sch_delay.average.ms
      3503 ± 14%     -33.3%       2337 ± 20%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.28 ±  6%     -22.2%       0.22 ±  6%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3502 ± 14%     -33.3%       2337 ± 20%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.63 ± 11%    +234.5%       2.10 ±101%  perf-stat.i.MPKI
      2.59 ±  4%      +2.4        4.99 ± 67%  perf-stat.i.branch-miss-rate%
    581917 ±  7%     +71.8%     999790 ± 20%  perf-stat.i.cache-misses
   6134527 ± 14%    +169.5%   16530221 ± 34%  perf-stat.i.cache-references
      2.46 ±  2%     +90.4%       4.69 ± 68%  perf-stat.i.cpi
 1.531e+09 ±  2%     +41.6%  2.167e+09 ±  8%  perf-stat.i.cpu-cycles
      9314 ± 29%     -69.2%       2868 ± 15%  perf-stat.i.cycles-between-cache-misses
      0.18 ± 16%      +0.5        0.65 ± 94%  perf-stat.i.dTLB-load-miss-rate%
    215973 ± 16%    +202.5%     653347 ± 37%  perf-stat.i.dTLB-load-misses
      0.04 ± 16%      +0.1        0.15 ±108%  perf-stat.i.dTLB-store-miss-rate%
     23577 ± 17%    +226.3%      76935 ± 48%  perf-stat.i.dTLB-store-misses
      0.53 ±  2%     -31.2%       0.36 ± 29%  perf-stat.i.ipc
      0.27 ± 46%     -68.5%       0.09 ± 44%  perf-stat.i.major-faults
      0.04 ±  2%     +41.6%       0.06 ±  8%  perf-stat.i.metric.GHz
    193.78 ± 12%    +223.5%     626.90 ± 76%  perf-stat.i.metric.K/sec
      0.58 ±  6%    +154.1%       1.46 ± 92%  perf-stat.overall.MPKI
      3.23 ±  2%      +1.3        4.53 ± 43%  perf-stat.overall.branch-miss-rate%
      9.58 ±  7%      -3.3        6.25 ±  9%  perf-stat.overall.cache-miss-rate%
      1.52 ±  2%     +95.4%       2.96 ± 74%  perf-stat.overall.cpi
      2638 ±  4%     -16.2%       2211 ±  9%  perf-stat.overall.cycles-between-cache-misses
      0.09 ± 16%      +0.3        0.40 ±107%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ± 17%      +0.1        0.10 ±114%  perf-stat.overall.dTLB-store-miss-rate%
      0.66 ±  2%     -32.9%       0.44 ± 32%  perf-stat.overall.ipc
    572699 ±  7%     +72.4%     987288 ± 21%  perf-stat.ps.cache-misses
   6038971 ± 14%    +170.5%   16335282 ± 35%  perf-stat.ps.cache-references
 1.507e+09 ±  2%     +41.9%  2.139e+09 ±  9%  perf-stat.ps.cpu-cycles
    212612 ± 16%    +203.7%     645713 ± 37%  perf-stat.ps.dTLB-load-misses
     23211 ± 17%    +227.8%      76083 ± 49%  perf-stat.ps.dTLB-store-misses
      0.27 ± 46%     -68.4%       0.08 ± 44%  perf-stat.ps.major-faults
 6.308e+10           +24.8%  7.873e+10 ± 36%  perf-stat.total.instructions
     24.41            -3.3       21.12 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.08 ± 14%      -3.1        2.99 ± 13%  perf-profile.calltrace.cycles-pp.clock_nanosleep
      4.96 ± 13%      -2.5        2.46 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      4.94 ± 12%      -2.5        2.44 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      4.74 ± 12%      -2.4        2.31 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     15.96 ±  2%      -2.3       13.64 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      4.35 ± 11%      -2.2        2.10 ± 10%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      4.32 ± 11%      -2.2        2.08 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.01 ± 10%      -2.1        1.88 ± 10%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      2.78 ± 12%      -1.4        1.33 ± 10%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.62 ± 13%      -1.4        1.27 ± 11%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      1.74 ± 15%      -0.8        0.90 ± 21%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.40 ± 17%      -0.8        0.59 ± 48%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.59 ± 23%      -0.8        0.84 ± 45%  perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.53 ± 22%      -0.7        0.82 ± 45%  perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.36 ± 15%      -0.5        0.87 ± 15%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      1.31 ± 28%      -0.5        0.82 ± 17%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.73 ± 19%      -0.4        0.35 ± 70%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.65 ± 47%      +0.5        1.19 ± 22%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.58 ± 47%      +0.6        1.18 ± 22%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.2        1.18 ± 19%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq
      0.00            +1.2        1.18 ± 19%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state
      0.00            +1.4        1.41 ± 19%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      0.00            +2.6        2.56 ± 19%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     90.83            +4.3       95.11        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     85.89            +4.4       90.30 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     87.88            +4.4       92.29 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     87.87            +4.4       92.29 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     87.75            +4.5       92.20        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     81.53            +4.7       86.20 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     82.91 ±  2%      +4.8       87.69        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +7.1        7.06 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.14 ± 14%      -3.1        3.04 ± 14%  perf-profile.children.cycles-pp.clock_nanosleep
      6.33 ± 12%      -3.1        3.24 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.27 ± 12%      -3.1        3.21 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
      4.74 ± 12%      -2.4        2.31 ± 10%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      4.42 ± 12%      -2.3        2.14 ±  9%  perf-profile.children.cycles-pp.common_nsleep
      4.32 ± 11%      -2.2        2.08 ±  9%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      4.04 ± 10%      -2.2        1.89 ± 10%  perf-profile.children.cycles-pp.do_nanosleep
      2.86 ± 13%      -1.5        1.40 ± 10%  perf-profile.children.cycles-pp.schedule
      3.74 ± 12%      -1.4        2.39 ± 12%  perf-profile.children.cycles-pp.__schedule
      2.52 ± 15%      -0.9        1.57 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      2.08 ± 14%      -0.9        1.17 ±  6%  perf-profile.children.cycles-pp.lapic_next_deadline
      1.90 ± 14%      -0.7        1.23 ± 14%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      1.65 ± 23%      -0.5        1.12 ± 22%  perf-profile.children.cycles-pp.hrtimer_wakeup
      1.36 ± 29%      -0.5        0.87 ± 15%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      1.60 ± 22%      -0.5        1.11 ± 21%  perf-profile.children.cycles-pp.try_to_wake_up
      0.85 ± 26%      -0.4        0.42 ± 28%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.75 ± 25%      -0.4        0.38 ± 32%  perf-profile.children.cycles-pp.dequeue_entity
      1.13 ± 24%      -0.4        0.78 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.00 ± 20%      -0.3        0.66 ± 10%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.48 ± 23%      -0.3        0.22 ± 28%  perf-profile.children.cycles-pp.__switch_to
      0.48 ± 42%      -0.2        0.23 ± 40%  perf-profile.children.cycles-pp.update_load_avg
      0.75 ± 17%      -0.2        0.52 ± 12%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.53 ± 20%      -0.2        0.32 ± 21%  perf-profile.children.cycles-pp.__switch_to_asm
      0.80 ± 20%      -0.2        0.58 ± 13%  perf-profile.children.cycles-pp.sched_clock
      0.42 ± 15%      -0.2        0.22 ± 17%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.34 ± 35%      -0.2        0.14 ± 22%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.30 ± 16%      -0.2        0.12 ± 27%  perf-profile.children.cycles-pp.do_execveat_common
      0.30 ± 28%      -0.2        0.12 ± 16%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.30 ± 16%      -0.2        0.12 ± 30%  perf-profile.children.cycles-pp.execve
      0.30 ± 16%      -0.2        0.12 ± 30%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.30 ± 28%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.exc_page_fault
      0.27 ± 18%      -0.2        0.09 ± 20%  perf-profile.children.cycles-pp.handle_mm_fault
      0.23 ± 20%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.18 ± 36%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.cpupri_set
      0.20 ± 28%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.20 ± 28%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.do_group_exit
      0.20 ± 28%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.do_exit
      0.22 ± 12%      -0.1        0.09 ± 22%  perf-profile.children.cycles-pp.bprm_execve
      0.24 ± 17%      -0.1        0.11 ± 73%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.20 ± 17%      -0.1        0.08 ± 50%  perf-profile.children.cycles-pp.exec_binprm
      0.20 ± 17%      -0.1        0.08 ± 50%  perf-profile.children.cycles-pp.search_binary_handler
      0.19 ± 26%      -0.1        0.07 ± 52%  perf-profile.children.cycles-pp.__mmput
      0.19 ± 26%      -0.1        0.07 ± 52%  perf-profile.children.cycles-pp.exit_mmap
      0.29 ± 28%      -0.1        0.17 ± 19%  perf-profile.children.cycles-pp.___perf_sw_event
      0.19 ± 21%      -0.1        0.07 ± 52%  perf-profile.children.cycles-pp.load_elf_binary
      0.15 ± 32%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.exit_mm
      0.15 ± 39%      -0.1        0.05 ± 80%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.15 ± 25%      -0.1        0.06 ± 80%  perf-profile.children.cycles-pp._copy_from_user
      0.14 ± 22%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.do_fault
      0.29 ± 20%      -0.1        0.21 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.10 ± 33%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.12 ± 20%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.do_read_fault
      0.09 ± 17%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.21 ± 19%      -0.1        0.15 ± 15%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.hrtick
      0.01 ±223%      +0.1        0.11 ± 56%  perf-profile.children.cycles-pp.check_cpu_stall
      0.03 ±100%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.12 ± 40%      +0.1        0.25 ± 14%  perf-profile.children.cycles-pp.irqentry_enter
      0.06 ± 73%      +0.1        0.19 ± 24%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.06 ± 79%      +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.dequeue_task_dl
      0.20 ± 27%      +0.2        0.36 ± 23%  perf-profile.children.cycles-pp.rcu_pending
      0.07 ± 80%      +0.2        0.26 ± 31%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.24 ± 24%      +0.2        0.44 ± 23%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.06 ± 82%      +0.3        0.33 ± 31%  perf-profile.children.cycles-pp.pick_next_task_dl
      0.72 ± 30%      +0.6        1.32 ± 22%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.68 ± 30%      +0.6        1.30 ± 22%  perf-profile.children.cycles-pp.tick_irq_enter
     22.71 ±  2%      +1.5       24.26 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     90.80            +4.3       95.08        perf-profile.children.cycles-pp.do_idle
     90.83            +4.3       95.11        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     90.83            +4.3       95.11        perf-profile.children.cycles-pp.cpu_startup_entry
     88.73            +4.3       93.05        perf-profile.children.cycles-pp.cpuidle_idle_call
     87.88            +4.4       92.29 ±  2%  perf-profile.children.cycles-pp.start_secondary
     84.11 ±  2%      +4.6       88.70        perf-profile.children.cycles-pp.cpuidle_enter_state
     84.15 ±  2%      +4.6       88.78        perf-profile.children.cycles-pp.cpuidle_enter
      0.26 ± 54%      +5.1        5.38 ± 14%  perf-profile.children.cycles-pp.intel_idle_irq
      3.20 ±  9%      -0.9        2.28 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      2.08 ± 14%      -0.9        1.17 ±  6%  perf-profile.self.cycles-pp.lapic_next_deadline
      1.90 ± 14%      -0.7        1.23 ± 14%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      1.13 ± 24%      -0.4        0.78 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.75 ± 17%      -0.2        0.52 ± 12%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.44 ± 25%      -0.2        0.22 ± 29%  perf-profile.self.cycles-pp.__switch_to
      0.53 ± 20%      -0.2        0.31 ± 20%  perf-profile.self.cycles-pp.__switch_to_asm
      0.48 ± 26%      -0.2        0.28 ± 27%  perf-profile.self.cycles-pp.__schedule
      0.36 ± 13%      -0.2        0.19 ± 23%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.18 ± 36%      -0.1        0.05 ± 75%  perf-profile.self.cycles-pp.cpupri_set
      0.23 ± 16%      -0.1        0.10 ± 87%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.17 ± 18%      -0.1        0.06 ± 55%  perf-profile.self.cycles-pp.do_nanosleep
      0.19 ± 52%      -0.1        0.09 ± 57%  perf-profile.self.cycles-pp.clock_nanosleep
      0.02 ±142%      +0.1        0.09 ± 25%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.03 ±143%      +0.1        0.11 ± 30%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.13 ± 22%      +0.1        0.23 ± 21%  perf-profile.self.cycles-pp.rcu_pending
      0.01 ±223%      +0.1        0.11 ± 56%  perf-profile.self.cycles-pp.check_cpu_stall
      0.02 ±141%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.11 ± 32%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.06 ± 73%      +0.1        0.19 ± 24%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.17 ± 60%      +3.6        3.74 ± 15%  perf-profile.self.cycles-pp.intel_idle_irq




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

