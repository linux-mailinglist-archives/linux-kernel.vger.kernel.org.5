Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867E7BCCA2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjJHG0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHG0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:26:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5606C5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 23:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696746399; x=1728282399;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=NX7nYk00wSHa3vO6o6pxF2G+elCzUUHLakuCm4EP7d8=;
  b=d/PbN6t/FRxaGRqHPGLmhDxI6xPcjSlJGcQ2ir5Bu3dN5bKofnmIh9E2
   vpPslLQiek2+BE8Uax5VxrlF+bnm3VwpRvseJsaNt+CE6hI2qppaOlVH0
   7HgY2+/O7L1EufnO9ZDOEBqPiCabJBfZiYOuGLclZMXQjXO8gZz41NTU0
   JgQwdbLPTmPKFOId9TUx7IK3iimvFqt+5Vot2bodXtgy+X2jQixforpaZ
   wPNyyJKEESq+LfxJD7VqRX7WHQrUw00die+JaaRWsRRIkiPMmEjE54xEX
   A6CVMeC58TE54t/8gWe7IPO2Jjq8OS4H6RqB8ikJgxvAbKM6JGaIk3YAS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="381241571"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="381241571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 23:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="702527578"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="702527578"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 23:26:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 23:26:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 23:26:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 23:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp/hftp3EaYhRaAynq/YwFCM3X5qH4+/pNNfKV0GezcbzlPksNjpZJyD5tQ3uuNjmya6eXt/ySKXztpVcfBgKirc7CPXYzyCUWTg8+medzUud3cQ0lupYefUTeMhRGIvtWnXNyvb4PVfwuSDx3xmFlqpb8wGoLYXuxwPk1WDrL1oeOsArtxN8s13UfGAB3ip5WzfmTMCSXsCxX+EF4/Xbwp9u3DezbDmM64GqM74SIcgP+gQSD2WQGJ1R/BiYr1jXMTEtdwuM3ynTBwyNdbQHlSBn5ygNQOEY9Fxd8Tr8JnT1ewnjwBKy9Lt7wX66qvBI57vxHcDLCIax+EweEKMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOdC1p9ZXViyLEJNrfslFpYkoEHX93D02+84g938cDQ=;
 b=eNlmQ/s0vqi5KF8RIiGmwHTusPrlb8oXBR/+KXlcmVVnTzBgK1ikHfwHW/SaZm7vq+H1gyRxSqUcl4cwWPOTl0pOdoo+ugKilPmlFwTt6aA+3BBcCGSl5B4L1fWqK+2hPuQUWInkQg5uQiHNQrfxb1IFj2/ts/tEzbaL7IGF9nYqqRoCTlDLK7OrBtVNXgptf+Bp6g3DGh63tNrTCUGZvHjfTJk11H/sQ2U1tlDRYapHfwy24m2IRYqAnxsGGWkBAgXL3q+98nPL1e40T5jGaCKACLX+HVZayhLtEVsiOUePOXQEFSYId8pRS8OJX7dxf57kOl37/HvfyW6rRs6/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 06:26:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Sun, 8 Oct 2023
 06:26:27 +0000
Date:   Sun, 8 Oct 2023 14:26:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Vernet <void@manifault.com>,
        "Swapnil Sapkal" <Swapnil.Sapkal@amd.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/fair]  1528c661c2:
 stress-ng.nanosleep.ops_per_sec 132.1% improvement
Message-ID: <202310081420.1e3f0ec2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:820:c::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 40af6fc6-84c5-4d74-6c2e-08dbc7c78022
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kT4o6HxPg5uETRO59pJiPdvEMrcFrbSIbvUwg1T8kXkSLSOv7vcOc6VViGq+wrPgIku/yKxUOfg2vOBqG62gYy7iZtBnoJsPNGf/mR8p8qMPqgVinA0idQshvHfJC6QFovf1aqP3jyfJC55ZhZ7AF9/wC8lEbeTGr7CzmInR0HnkU+xKBzS5q9qR0S4zdfZ50NyDoHLVvDVSBAQVBWqJ/LSBazPXJpNJFeC4ZWd9dyUzIIJK0f0oWGd+hmzcQkeq5MYo0P3OcZrsIebeQ7Q3jUEhRzQIhWu0UJyF5yE79nCLMFNnLhrH0ToTlZQAPUloL8IozKaFlsmK06rfF/y5LzLnOYJqdiL+fQgMVCMaXsY9yeUnHCmBYS3nXoBgj8i3pnvUUshHTT/7s956g0XGs7wQZ9+vOiGdcHWoAVcMIU/l5Sh8R2Y2Yb85nyinyrRQ7jWmnAuCfds1JeDuktGVDZAx5UjbproiSED2H1jE7o1maUkiMTGsjVBWPHaafAJcamyWd5LyInwA+8USm9QJYNuUxl71dSmfnUIyzJvVxNcpk/HyjuJlzMgmpgH3OpKHUY19YP7Sz+Vfe/tFPG6SOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(6506007)(2616005)(966005)(478600001)(83380400001)(6666004)(6486002)(1076003)(2906002)(30864003)(7416002)(37006003)(5660300002)(66476007)(66556008)(19627235002)(6636002)(54906003)(66946007)(8936002)(6862004)(4326008)(26005)(316002)(41300700001)(8676002)(36756003)(82960400001)(38100700002)(86362001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gAvcS2D6eR1d40JBZDfLP+SQjQvmkJmsMYsIKp0+9Ankqv/SmJufC+F6UQ?=
 =?iso-8859-1?Q?/EZ1kiYC+T+sxj8uystelJ5qfmi3lgl+iYFBMWiXco/rMOUKBYA1+4rZaG?=
 =?iso-8859-1?Q?KmD6RzLiRTYTOUpzbLhza+9Bzo8/VeLvYjGAC8LJTzhby0no2CifK2J/vP?=
 =?iso-8859-1?Q?8B6blRT9FuaiaNJILY38U9sVCZ7Q5mYFEPaIZrIMhUzyMRfl49HJWWzFOz?=
 =?iso-8859-1?Q?hkv8xd4Bu7vNuUkamv45muJtpmJQLIbGe+Fr0Xj9chgyFfUh+/lgeFC/54?=
 =?iso-8859-1?Q?kD5sIbsRh2FYc4x+9Hmvw6yukM/9hpKvVUnbCZ123FMdgOVg6IaAMufnE5?=
 =?iso-8859-1?Q?cykJV9UuD/RHnOytr9h1W/JSfQT92yb7QQiCqng9Ct+biEDjJVlZnp0B5L?=
 =?iso-8859-1?Q?DCt8RTMu8dyw7av+2pTNbBPUhkPIM03Uq+6uzIiZdaG/3VyXa+a0/jD331?=
 =?iso-8859-1?Q?Xkx81HjQ7LuWEarxmhWFbqEO8YS/6NqHAACoZ1bi5+8W2ssi7XsjaGaVGS?=
 =?iso-8859-1?Q?e5YMMuesEJee11BYTVux5zIfkC2e49GyxGJvHmnnM+wK4DQgTRAV5g/hnW?=
 =?iso-8859-1?Q?EZ77Rx0vX+zdBPjnR//uxb4dYn007pFJdKY2DxWSGs9rQpaQFwTaVwWS9J?=
 =?iso-8859-1?Q?aGkZGSj+Xhlscru7H/VUeqjpvACKiDEr/rI1yiNCDv8YwL/WauX1BkE0t9?=
 =?iso-8859-1?Q?37fhAi8MCe47iD6NP1vVi2n5ALZVh+VvKzjS7OyT3OxnPhaToaEHefCANg?=
 =?iso-8859-1?Q?vad0N2CHUCJ+8x8svP8ZwOdEc8LTCEwHuyrMdh4GCMdDDspcxIKtUyCLHz?=
 =?iso-8859-1?Q?l4w7/lu8NvwG+O0Uhs5tic9GibSpbzdlrbiVnUncSmq76EgpA/4ZWLIL7l?=
 =?iso-8859-1?Q?dGiaA20oOLmaViRyQ/PIDk7ovhcJpZaqDuINPOgHK9QZXPPXUaVZffk2GC?=
 =?iso-8859-1?Q?oARWqBDqVfNXG49fHLPwSg1xFUITYMi9FJjz5I7zEdhBzUjetjm9Y8D6tQ?=
 =?iso-8859-1?Q?AlHqIYnoPnrpBUahGlgufZuWAToOLSibk6JvPEPk3lXvSpu5D9wJHWP+Ar?=
 =?iso-8859-1?Q?oh2S1iaJGdNwkFXAlCqHktbSryK9L3XMuMrfnU2l8JT7V6j/XByIx6IohU?=
 =?iso-8859-1?Q?4G9kuFTm6WNm2h7pNtiyHEM4/a06E7mvhDn7T6LM62Whx0cKdVgQ/xVo+X?=
 =?iso-8859-1?Q?Ag72Nvvh/nKN3+QIvc/GRCH/AZOyDdTSjj/Or3B+ltfPpT3f+N38lTmxIL?=
 =?iso-8859-1?Q?H3zX2aEt10V6J6MJkdWhwf+Zr6hZ3Fa2tsmyACf1uapeWnUU4JA4wLKpwn?=
 =?iso-8859-1?Q?DZhoeUR47vYgH60HioaX7h/DNzsOzNerFRRA7e5EkQm6KBSdQK5r9MLCet?=
 =?iso-8859-1?Q?xUhdb9/37CY1EBvUA0kgfFSU5t41DqRwV0Hd5NuLz8s4LFyVKHuAImp5CS?=
 =?iso-8859-1?Q?3yNJPI1vMZwGjJVF4YSqtHJZos9uhCwHCz2BUj6N6zRw8Je2OKQ+zsiUD5?=
 =?iso-8859-1?Q?CCcVb0N0xtXUkfu0yUeuKshYmtbi6e8ihqgkSax9hzfG22zcAcHKDcT7+s?=
 =?iso-8859-1?Q?Fey4KFwoGx2OY4miiKAZJb8Peu19m5NFt0rPilsQB8Zhm5o7ZQxH0t29Wd?=
 =?iso-8859-1?Q?94OE+ifylY6P8nnlYuoASJD0N1pOneLXnKZ6j43elchDyPOrXefNxrkQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40af6fc6-84c5-4d74-6c2e-08dbc7c78022
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 06:26:27.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS8Ji6eetWMJIOQmJ/t0l14IRXW+NnyAvQatItHQSiZyttL3Wlnml3+UHzrjkfkA15H6gTxJIxzCv3EleVRVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
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

kernel test robot noticed a 132.1% improvement of stress-ng.nanosleep.ops_per_sec on:


commit: 1528c661c24b407e92194426b0adbb43de859ce0 ("sched/fair: Ratelimit update to tg->load_avg")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: nanosleep
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231008/202310081420.1e3f0ec2-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-spr-r02/nanosleep/stress-ng/60s

commit: 
  8f0eed4a78 ("freezer,sched: Use saved_state to reduce some spurious wakeups")
  1528c661c2 ("sched/fair: Ratelimit update to tg->load_avg")

8f0eed4a78a81668 1528c661c24b407e92194426b0a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1788278 ± 22%     +82.1%    3256900 ± 17%  numa-numastat.node1.numa_hit
 1.196e+09 ± 11%     +68.2%  2.013e+09 ±  4%  cpuidle..time
  35305629 ± 12%    +868.2%  3.418e+08 ±  3%  cpuidle..usage
     42048 ±  5%    +124.3%      94302 ±  3%  perf-c2c.HITM.local
      2061 ±  3%     +17.1%       2414 ±  3%  perf-c2c.HITM.remote
     44110 ±  5%    +119.3%      96716 ±  3%  perf-c2c.HITM.total
      8.19 ±  7%      +7.4       15.56 ±  5%  mpstat.cpu.all.idle%
     61.19            -8.0       53.21        mpstat.cpu.all.irq%
      0.22 ±  5%      -0.1        0.12 ±  2%  mpstat.cpu.all.soft%
     24.09 ±  2%      -4.1       19.96 ±  2%  mpstat.cpu.all.sys%
      6.30 ±  3%      +4.8       11.14 ±  2%  mpstat.cpu.all.usr%
     10.68 ±  5%     +69.9%      18.15 ±  4%  vmstat.cpu.id
   6699292 ±  4%     +64.2%   11002864        vmstat.memory.cache
    806.44           -43.3%     457.42 ±  2%  vmstat.procs.r
   9342020 ±  3%    +180.3%   26182293        vmstat.system.cs
   2314629 ±  4%    +134.8%    5434232        vmstat.system.in
   6504429 ±  4%     +65.3%   10752882        meminfo.Cached
  20096347           +21.9%   24496061        meminfo.Committed_AS
   4412262 ±  6%     +98.2%    8745790        meminfo.Inactive
   4412077 ±  6%     +98.2%    8745604        meminfo.Inactive(anon)
   1221815 ±  3%     +14.5%    1399226        meminfo.Mapped
  10558172 ±  2%     +41.0%   14885880        meminfo.Memused
   3758023 ±  7%    +113.1%    8006551        meminfo.Shmem
  10680780 ±  2%     +40.6%   15014302        meminfo.max_used_kB
      1069 ± 55%    +439.3%       5767 ± 91%  numa-vmstat.node0.nr_active_anon
      1069 ± 55%    +439.3%       5767 ± 91%  numa-vmstat.node0.nr_zone_active_anon
    892095 ± 26%    +115.8%    1925428 ± 18%  numa-vmstat.node1.nr_inactive_anon
    200147 ±  4%     +21.0%     242200 ±  2%  numa-vmstat.node1.nr_mapped
    839229 ± 29%    +118.5%    1833653 ± 19%  numa-vmstat.node1.nr_shmem
     49686 ±  5%      +7.3%      53298 ±  4%  numa-vmstat.node1.nr_slab_unreclaimable
    892090 ± 26%    +115.8%    1925422 ± 18%  numa-vmstat.node1.nr_zone_inactive_anon
   1788022 ± 22%     +82.0%    3254216 ± 17%  numa-vmstat.node1.numa_hit
      4359 ± 54%    +429.7%      23092 ± 91%  numa-meminfo.node0.Active
      4276 ± 55%    +438.5%      23028 ± 91%  numa-meminfo.node0.Active(anon)
    583541 ± 13%     +26.6%     739012 ±  7%  numa-meminfo.node1.AnonPages.max
   3567199 ± 26%    +115.6%    7691598 ± 18%  numa-meminfo.node1.Inactive
   3567139 ± 26%    +115.6%    7691501 ± 18%  numa-meminfo.node1.Inactive(anon)
    800329 ±  4%     +20.6%     965248 ±  2%  numa-meminfo.node1.Mapped
   5754327 ± 25%     +64.8%    9485787 ± 15%  numa-meminfo.node1.MemUsed
    198757 ±  5%      +7.3%     213175 ±  4%  numa-meminfo.node1.SUnreclaim
   3355207 ± 29%    +118.3%    7323480 ± 19%  numa-meminfo.node1.Shmem
    189767 ±  3%     -61.2%      73643        stress-ng.nanosleep.nanosec_sleep_overrun
  27598723 ±  3%    +133.2%   64356222        stress-ng.nanosleep.ops
    462089 ±  3%    +132.1%    1072572        stress-ng.nanosleep.ops_per_sec
  34475924 ±  3%     -28.4%   24670674 ±  4%  stress-ng.time.involuntary_context_switches
     44200 ±  2%     +11.7%      49387        stress-ng.time.minor_page_faults
      4994 ±  4%     +49.9%       7486        stress-ng.time.percent_of_cpu_this_job_got
      2512 ±  4%     +21.8%       3059        stress-ng.time.system_time
    595.11 ±  4%    +167.9%       1594        stress-ng.time.user_time
 5.234e+08 ±  3%    +133.4%  1.221e+09        stress-ng.time.voluntary_context_switches
  22040868 ± 11%    +994.7%  2.413e+08 ±  3%  turbostat.C1
      0.59 ± 16%      +4.0        4.56 ±  8%  turbostat.C1%
   8313600 ± 26%    +273.4%   31045343 ± 13%  turbostat.C1E
      7.33 ± 13%     +35.3%       9.91 ±  8%  turbostat.CPU%c1
      0.11 ±  3%    +128.4%       0.26        turbostat.IPC
 1.533e+08 ±  3%    +133.8%  3.584e+08        turbostat.IRQ
      0.51 ±149%     +93.2       93.69 ±  3%  turbostat.PKG_%
   4412934 ± 11%   +1464.1%   69024287 ±  3%  turbostat.POLL
      0.66 ± 11%      +1.9        2.51 ±  2%  turbostat.POLL%
     47.67            +4.9%      50.00        turbostat.PkgTmp
    611.58           +10.6%     676.35        turbostat.PkgWatt
     18.31            +7.4%      19.66        turbostat.RAMWatt
    215717 ±  2%      +5.1%     226642        proc-vmstat.nr_anon_pages
   6289822            -1.7%    6181574        proc-vmstat.nr_dirty_background_threshold
  12595023            -1.7%   12378263        proc-vmstat.nr_dirty_threshold
   1626170 ±  4%     +65.5%    2691142        proc-vmstat.nr_file_pages
  63275083            -1.7%   62191019        proc-vmstat.nr_free_pages
   1103413 ±  6%     +98.4%    2188968        proc-vmstat.nr_inactive_anon
    306286 ±  3%     +14.7%     351386        proc-vmstat.nr_mapped
    939568 ±  7%    +113.3%    2004558        proc-vmstat.nr_shmem
     37887            +6.4%      40323        proc-vmstat.nr_slab_reclaimable
   1103413 ±  6%     +98.4%    2188968        proc-vmstat.nr_zone_inactive_anon
   2336230 ±  4%     +66.8%    3896214        proc-vmstat.numa_hit
   2102646 ±  5%     +74.3%    3664234        proc-vmstat.numa_local
     67982 ± 13%     +49.1%     101369 ± 12%  proc-vmstat.numa_pages_migrated
   2616709 ±  4%     +61.2%    4217711        proc-vmstat.pgalloc_normal
     67982 ± 13%     +49.1%     101369 ± 12%  proc-vmstat.pgmigrate_success
     27451            +3.8%      28482 ±  2%  proc-vmstat.pgreuse
   1726569 ±  8%     +21.9%    2103977 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1337584 ±  7%     +20.3%    1608878 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
      2.22 ±  5%     -49.9%       1.11 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.68 ±  3%     -28.3%       1.20 ± 11%  sched_debug.cfs_rq:/.h_nr_running.stddev
    641617 ± 14%     -23.6%     489902 ±  7%  sched_debug.cfs_rq:/.left_vruntime.avg
   1726569 ±  8%     +21.9%    2103977 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
   1337583 ±  7%     +20.3%    1608878 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      0.50           -12.9%       0.44 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
      0.24 ±  6%     +36.2%       0.33 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    641617 ± 14%     -23.6%     489902 ±  7%  sched_debug.cfs_rq:/.right_vruntime.avg
      2114           -54.3%     967.23 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      6417 ± 11%     -67.2%       2105 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    845.90 ±  6%     -61.7%     324.18 ± 30%  sched_debug.cfs_rq:/.runnable_avg.stddev
    316.80 ±  2%     +19.8%     379.50        sched_debug.cfs_rq:/.util_avg.avg
     24.45 ±  9%     -36.3%      15.59 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    707.75 ±  4%     +13.6%     804.17 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.max
     61.20 ± 10%     +15.0%      70.40 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      4596 ± 10%     -41.1%       2706 ±  9%  sched_debug.cpu.avg_idle.min
     34.11 ±  5%     -62.0%      12.94 ±  8%  sched_debug.cpu.clock.stddev
      0.00 ± 38%     -54.5%       0.00 ± 28%  sched_debug.cpu.next_balance.stddev
      2.05 ±  6%     -48.7%       1.05 ±  6%  sched_debug.cpu.nr_running.avg
     10.25 ± 12%     -31.7%       7.00 ± 17%  sched_debug.cpu.nr_running.max
      1.62 ±  3%     -28.3%       1.16 ±  8%  sched_debug.cpu.nr_running.stddev
   1314950 ±  3%    +177.9%    3654540        sched_debug.cpu.nr_switches.avg
   1474859 ±  6%    +171.4%    4003108        sched_debug.cpu.nr_switches.max
    423172 ± 25%    +198.2%    1262042 ±  3%  sched_debug.cpu.nr_switches.min
    129725 ± 43%     +81.7%     235732 ±  2%  sched_debug.cpu.nr_switches.stddev
 2.458e+10 ±  2%    +111.0%  5.186e+10        perf-stat.i.branch-instructions
      2.32 ±  2%      -0.1        2.18        perf-stat.i.branch-miss-rate%
 5.015e+08 ±  4%    +106.6%  1.036e+09        perf-stat.i.branch-misses
  23929219 ±  4%    +135.2%   56282049 ±  2%  perf-stat.i.cache-misses
 2.244e+09 ±  4%    +117.5%  4.879e+09        perf-stat.i.cache-references
   9753123 ±  3%    +180.7%   27375300        perf-stat.i.context-switches
      5.55 ±  2%     -57.2%       2.38        perf-stat.i.cpi
 6.042e+11            -3.0%  5.858e+11        perf-stat.i.cpu-cycles
   2696454 ±  7%    +487.5%   15842861        perf-stat.i.cpu-migrations
     27921 ±  4%     -58.8%      11493 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.27 ±  2%      +0.1        0.37 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  75502425 ±  4%    +216.3%  2.388e+08 ±  3%  perf-stat.i.dTLB-load-misses
 2.884e+10 ±  3%    +126.8%  6.542e+10        perf-stat.i.dTLB-loads
      0.09            +0.0        0.12        perf-stat.i.dTLB-store-miss-rate%
  11726278 ±  4%    +242.5%   40162917        perf-stat.i.dTLB-store-misses
  1.44e+10 ±  3%    +145.5%  3.536e+10        perf-stat.i.dTLB-stores
  1.18e+11 ±  3%    +119.1%  2.585e+11        perf-stat.i.instructions
      0.23 ±  3%     +97.9%       0.45        perf-stat.i.ipc
      2.69            -3.0%       2.61        perf-stat.i.metric.GHz
    167.39 ±  4%    +184.1%     475.63        perf-stat.i.metric.K/sec
    312.50 ±  3%    +125.0%     702.99        perf-stat.i.metric.M/sec
   8403055 ±  3%     +89.8%   15946397 ±  6%  perf-stat.i.node-load-misses
   1963848 ± 18%    +144.4%    4799465 ± 23%  perf-stat.i.node-loads
      1.04 ±  4%      +0.1        1.14 ±  3%  perf-stat.overall.cache-miss-rate%
      5.27 ±  3%     -56.5%       2.29        perf-stat.overall.cpi
     25657 ±  4%     -59.0%      10531 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.27 ±  2%      +0.1        0.37 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.08            +0.0        0.11        perf-stat.overall.dTLB-store-miss-rate%
      0.19 ±  3%    +129.4%       0.44        perf-stat.overall.ipc
 2.356e+10 ±  3%    +114.2%  5.047e+10        perf-stat.ps.branch-instructions
 4.967e+08 ±  4%    +106.2%  1.024e+09        perf-stat.ps.branch-misses
  23248271 ±  4%    +136.1%   54900505 ±  3%  perf-stat.ps.cache-misses
 2.232e+09 ±  4%    +116.2%  4.825e+09        perf-stat.ps.cache-references
   9616674 ±  3%    +181.5%   27067126        perf-stat.ps.context-switches
 5.952e+11            -3.0%  5.775e+11        perf-stat.ps.cpu-cycles
   2651495 ±  7%    +490.9%   15667625        perf-stat.ps.cpu-migrations
  74077179 ±  4%    +218.2%  2.357e+08 ±  3%  perf-stat.ps.dTLB-load-misses
 2.775e+10 ±  3%    +130.2%  6.387e+10        perf-stat.ps.dTLB-loads
  11551638 ±  4%    +243.8%   39717859        perf-stat.ps.dTLB-store-misses
 1.382e+10 ±  3%    +149.9%  3.453e+10        perf-stat.ps.dTLB-stores
 1.131e+11 ±  3%    +122.6%  2.518e+11        perf-stat.ps.instructions
   8218605 ±  4%     +90.2%   15635851 ±  6%  perf-stat.ps.node-load-misses
   2176073 ± 16%    +132.8%    5066642 ± 23%  perf-stat.ps.node-loads
 7.181e+12 ±  2%    +118.9%  1.572e+13        perf-stat.total.instructions
     13.34           -13.3        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.do_nanosleep
     17.52           -12.7        4.82        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
     39.72           -11.9       27.86        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     12.39 ±  2%     -11.8        0.59        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
     12.28 ±  2%     -11.7        0.55        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
     12.25 ±  2%     -11.7        0.52        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
     40.10           -11.5       28.59        perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     44.60           -10.5       34.10        perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
     45.34           -10.0       35.36        perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.37            -9.9       35.45        perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     19.18            -9.1       10.05        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     46.45            -9.0       37.41        perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      7.85 ±  2%      -7.9        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      9.90 ±  4%      -7.5        2.41        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
     48.86            -7.3       41.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     49.19            -7.0       42.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     11.50            -7.0        4.53        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     11.43            -7.0        4.48        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry
     11.35            -6.9        4.46        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle
     11.34 ±  2%      -6.9        4.45        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue
     45.55 ±  2%      -6.4       39.10        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     44.38 ±  2%      -6.4       37.97        perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     44.39 ±  2%      -6.4       38.03        perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     10.82 ±  3%      -6.4        4.47        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     22.34 ±  3%      -5.9       16.42        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
     22.37 ±  3%      -5.9       16.46        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      6.00 ±  7%      -5.3        0.67        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      6.19 ±  4%      -4.5        1.68        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
     16.18 ±  4%      -4.3       11.86        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule.do_nanosleep
     16.04 ±  4%      -4.3       11.72        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule
     54.64            -4.1       50.55        perf-profile.calltrace.cycles-pp.clock_nanosleep
      4.65 ±  6%      -4.0        0.66        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      4.48 ±  6%      -3.9        0.53        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      4.52 ±  6%      -3.9        0.58        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
     16.51 ±  4%      -3.4       13.11        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      8.69 ±  2%      -3.2        5.46        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      6.12 ±  5%      -2.7        3.44        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      6.15 ±  5%      -2.6        3.54        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      6.26 ±  5%      -2.1        4.16        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      6.62 ±  3%      -1.8        4.82        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
      6.65 ±  3%      -1.8        4.86        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      6.40 ±  5%      -1.6        4.83        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      2.02 ±  2%      -1.5        0.55        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle.do_idle
     39.26            -1.2       38.06        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.50            -1.1       38.35        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     39.32            -1.1       38.18        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.32            -1.1       38.20        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      2.88 ±  5%      -0.5        2.42        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.do_nanosleep
      9.94            -0.4        9.58        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.62 ± 11%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.nohz_run_idle_balance
      1.07 ±  6%      -0.3        0.80        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state
      1.07 ±  6%      -0.2        0.83        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter
      1.30            -0.2        1.06        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep
      1.08 ±  6%      -0.2        0.87        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.09 ±  6%      -0.1        0.95        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.20 ±  3%      -0.1        1.08        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.18 ±  3%      -0.1        1.06        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep
      1.19 ±  4%      -0.1        1.07        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep
      1.18 ±  4%      -0.1        1.07        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep
      0.66 ±  9%      -0.1        0.55        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.65 ±  9%      -0.1        0.54        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle
      0.66 ±  9%      -0.1        0.55        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry.start_secondary
      0.65 ±  9%      -0.1        0.55        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry
      1.69            -0.1        1.61        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.93            +0.2        1.13        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      1.70 ± 10%      +0.2        1.92        perf-profile.calltrace.cycles-pp.nohz_run_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.76 ±  3%      +0.3        1.03        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel
      0.76 ±  3%      +0.3        1.04        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep
      0.75 ±  3%      +0.3        1.03        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active
      0.76 ±  4%      +0.3        1.04        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep
      0.58            +0.3        0.89        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.60 ±  5%      +0.4        1.01        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.58 ±  5%      +0.4        0.99        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.58 ±  5%      +0.4        0.99        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.59 ±  5%      +0.4        1.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.do_nanosleep
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.tick_nohz_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.83 ±  2%      +0.5        1.38 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.86 ±  2%      +0.5        1.41 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.84 ±  2%      +0.5        1.38 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.84 ±  2%      +0.5        1.38 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      1.03 ±  4%      +0.6        1.58 ±  4%  perf-profile.calltrace.cycles-pp.stress_mwc32
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_mwc32
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_mwc32
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_mwc32
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.6        0.60 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.stress_mwc32
      0.62 ±  2%      +0.6        1.24        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp._copy_from_user.get_timespec64.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.24            +0.6        1.89        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.__switch_to.clock_nanosleep
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.57 ±  3%      +0.7        1.28        perf-profile.calltrace.cycles-pp.__switch_to_asm.clock_nanosleep
      0.00            +0.7        0.71 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.71 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.71 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.72 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.get_timespec64.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.__update_idle_core.pick_next_task_idle.__schedule.schedule.do_nanosleep
      0.00            +0.8        0.79        perf-profile.calltrace.cycles-pp.pick_next_task_idle.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      3.18 ±  4%      +0.9        4.03        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.__switch_to_asm
      3.02 ±  4%      +0.9        3.88        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      3.04 ±  4%      +0.9        3.90        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      3.02 ±  4%      +0.9        3.89        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      1.44 ±  2%      +0.9        2.36        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +1.0        1.00        perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.40 ±  2%      +1.1        2.46        perf-profile.calltrace.cycles-pp.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.38 ± 71%      +1.1        1.45        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      0.37 ± 71%      +1.1        1.45        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle
      0.38 ± 71%      +1.1        1.47        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      0.38 ± 71%      +1.1        1.48        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.45 ±  2%      +1.1        2.58        perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.84 ±  5%      +1.2        2.06 ± 12%  perf-profile.calltrace.cycles-pp.clock_gettime
      2.06            +1.3        3.38        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +1.4        1.38 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      2.16            +1.4        3.56        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.80 ±  2%      +1.5        3.30        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±  3%      +1.7        3.55 ±  2%  perf-profile.calltrace.cycles-pp.stress_pthread_func
      0.58 ± 11%      +2.1        2.66 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.80 ±  9%      +2.2        2.98        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.69 ±  3%      +2.4        6.08        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.70 ±  3%      +2.4        6.09        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.73 ±  3%      +2.5        6.19        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.74 ±  3%      +2.5        6.23        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +5.6        5.64        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
      6.25 ±  2%      +6.8       13.10        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.28 ±  2%      +7.0       13.24        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.60 ±  2%      +7.4       14.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.11 ± 26%      +8.0        9.07        perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     30.42           -29.2        1.18 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
     26.09           -20.3        5.76        perf-profile.children.cycles-pp.enqueue_task_fair
     26.80           -19.4        7.43        perf-profile.children.cycles-pp.activate_task
     27.01           -19.2        7.85        perf-profile.children.cycles-pp.ttwu_do_activate
     17.54           -12.6        4.89        perf-profile.children.cycles-pp.dequeue_task_fair
     50.44           -12.5       37.97        perf-profile.children.cycles-pp.__schedule
     40.74           -11.9       28.87        perf-profile.children.cycles-pp.schedule
     44.63           -10.5       34.17        perf-profile.children.cycles-pp.do_nanosleep
     45.34           -10.0       35.38        perf-profile.children.cycles-pp.hrtimer_nanosleep
     45.42            -9.8       35.58        perf-profile.children.cycles-pp.common_nsleep
     19.35            -9.2       10.20        perf-profile.children.cycles-pp.flush_smp_call_function_queue
     46.46            -9.0       37.44        perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
     11.63 ±  2%      -8.1        3.49        perf-profile.children.cycles-pp.enqueue_entity
     10.86 ±  2%      -7.4        3.47        perf-profile.children.cycles-pp.update_load_avg
     49.02            -7.4       41.64        perf-profile.children.cycles-pp.do_syscall_64
     49.34            -7.1       42.25        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     25.90 ±  3%      -7.0       18.94        perf-profile.children.cycles-pp.finish_task_switch
     50.42 ±  2%      -6.9       43.54        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     50.95 ±  2%      -6.9       44.08        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     48.45 ±  2%      -6.8       41.62        perf-profile.children.cycles-pp.try_to_wake_up
     48.46 ±  2%      -6.8       41.65        perf-profile.children.cycles-pp.hrtimer_wakeup
     49.64 ±  2%      -6.8       42.84        perf-profile.children.cycles-pp.__hrtimer_run_queues
     49.87 ±  2%      -6.7       43.16        perf-profile.children.cycles-pp.hrtimer_interrupt
     49.94 ±  2%      -6.7       43.26        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     11.98 ±  4%      -5.3        6.64        perf-profile.children.cycles-pp.sched_ttwu_pending
     12.31 ±  4%      -4.5        7.83        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     54.78            -3.9       50.88        perf-profile.children.cycles-pp.clock_nanosleep
      5.90 ±  3%      -2.8        3.05        perf-profile.children.cycles-pp.__sysvec_call_function_single
      5.93 ±  3%      -2.7        3.18        perf-profile.children.cycles-pp.sysvec_call_function_single
      6.01 ±  3%      -2.5        3.52        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     39.45            -1.2       38.26        perf-profile.children.cycles-pp.do_idle
     39.50            -1.1       38.35        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     39.50            -1.1       38.35        perf-profile.children.cycles-pp.cpu_startup_entry
     39.32            -1.1       38.20        perf-profile.children.cycles-pp.start_secondary
      2.91 ±  5%      -0.4        2.48        perf-profile.children.cycles-pp.dequeue_entity
      0.72 ±  7%      -0.4        0.34        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.39 ±  5%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      1.32            -0.2        1.08        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.47 ±  4%      -0.2        0.26        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.49 ±  6%      -0.2        0.30        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.42 ±  4%      -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.42 ±  3%      -0.2        0.25 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.38 ±  4%      -0.2        0.21 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.38 ±  2%      -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.rb_insert_color
      0.44 ±  4%      -0.2        0.27        perf-profile.children.cycles-pp.tick_sched_timer
      0.48 ±  2%      -0.1        0.34        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.19 ± 51%      -0.1        0.08 ± 61%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.20 ± 45%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.__libc_start_main
      0.20 ± 45%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.main
      0.20 ± 45%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.run_builtin
      0.18 ± 51%      -0.1        0.07 ± 60%  perf-profile.children.cycles-pp.perf_mmap__push
      0.19 ± 51%      -0.1        0.09 ± 38%  perf-profile.children.cycles-pp.cmd_record
      0.40 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp.get_nohz_timer_target
      1.70            -0.1        1.63        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.10            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.entity_eligible
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.perf_swevent_event
      0.13 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mm_cid_get
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.put_prev_entity
      0.08            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.04 ± 44%      +0.0        0.08        perf-profile.children.cycles-pp._find_next_and_bit
      0.05            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.08            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.idle_cpu
      0.25 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.nanosleep@plt
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.15 ± 10%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.call_cpuidle
      0.10 ±  6%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.06            +0.1        0.12        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__update_load_avg_blocked_se
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.perf_exclude_event
      0.13 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.13 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.__hrtimer_init
      0.24 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.pick_eevdf
      0.19 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.local_clock_noinstr
      0.16 ±  5%      +0.1        0.24        perf-profile.children.cycles-pp.hrtimer_init_sleeper
      0.08 ±  4%      +0.1        0.16        perf-profile.children.cycles-pp.resched_curr
      0.05            +0.1        0.13        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.08            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rb_next
      0.10            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  6%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.set_next_buddy
      0.07            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ±  7%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.28            +0.1        0.39        perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__calc_delta
      0.09 ±  7%      +0.1        0.21        perf-profile.children.cycles-pp.avg_vruntime
      0.42 ± 10%      +0.1        0.54        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.newidle_balance
      0.08 ±  6%      +0.1        0.21        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.24            +0.1        0.38        perf-profile.children.cycles-pp.os_xsave
      0.05            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.14            +0.2        0.29        perf-profile.children.cycles-pp.read_tsc
      0.48 ±  2%      +0.2        0.64        perf-profile.children.cycles-pp.update_rq_clock
      0.17            +0.2        0.33        perf-profile.children.cycles-pp.check_preempt_curr
      0.26 ± 24%      +0.2        0.43        perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  9%      +0.2        0.25        perf-profile.children.cycles-pp.cpuacct_charge
      0.08 ± 18%      +0.2        0.26        perf-profile.children.cycles-pp.menu_select
      0.15 ±  2%      +0.2        0.33        perf-profile.children.cycles-pp.stress_mwc32modn
      0.24 ±  2%      +0.2        0.42        perf-profile.children.cycles-pp.perf_tp_event
      0.09 ±  5%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.19 ±  5%      +0.2        0.39        perf-profile.children.cycles-pp.update_min_vruntime
      0.14 ±  3%      +0.2        0.34        perf-profile.children.cycles-pp.__entry_text_start
      0.45 ±  2%      +0.2        0.66        perf-profile.children.cycles-pp.__update_load_avg_se
      0.16 ±  3%      +0.2        0.38        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  3%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.cpus_share_cache
      0.16 ±  3%      +0.2        0.38        perf-profile.children.cycles-pp.timerqueue_del
      0.21 ±  2%      +0.2        0.44        perf-profile.children.cycles-pp.__enqueue_entity
      0.41            +0.2        0.64        perf-profile.children.cycles-pp.update_rq_clock_task
      0.38            +0.2        0.62        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.71 ± 10%      +0.3        1.97        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.28 ± 14%      +0.3        0.55 ±  5%  perf-profile.children.cycles-pp.__nanosleep
      0.35 ±  2%      +0.3        0.66        perf-profile.children.cycles-pp._copy_from_user
      0.45 ±  2%      +0.3        0.77        perf-profile.children.cycles-pp.get_timespec64
      0.09 ±  7%      +0.3        0.41 ±  2%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      1.54 ±  4%      +0.4        1.89        perf-profile.children.cycles-pp.pick_next_task_fair
      0.24 ±  3%      +0.4        0.59        perf-profile.children.cycles-pp.___perf_sw_event
      0.15 ±  4%      +0.4        0.52        perf-profile.children.cycles-pp.native_sched_clock
      0.16 ±  4%      +0.4        0.54        perf-profile.children.cycles-pp.sched_clock
      0.36 ± 14%      +0.4        0.75 ± 11%  perf-profile.children.cycles-pp.clock_gettime@plt
      0.24 ±  2%      +0.4        0.69        perf-profile.children.cycles-pp.sched_clock_cpu
      0.78 ±  2%      +0.5        1.24        perf-profile.children.cycles-pp.reweight_entity
      0.56 ±  3%      +0.5        1.08        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.25 ±  2%      +0.5        1.80        perf-profile.children.cycles-pp._find_next_bit
      1.04 ±  3%      +0.6        1.60 ±  4%  perf-profile.children.cycles-pp.stress_mwc32
      0.21 ±  5%      +0.6        0.84        perf-profile.children.cycles-pp.llist_reverse_order
      0.53 ±  4%      +0.7        1.21        perf-profile.children.cycles-pp.update_curr
      0.71            +0.7        1.44        perf-profile.children.cycles-pp.prepare_task_switch
      0.04 ± 45%      +0.7        0.77        perf-profile.children.cycles-pp.__update_idle_core
      0.05 ±  8%      +0.7        0.79        perf-profile.children.cycles-pp.pick_next_task_idle
      0.86 ±  5%      +0.7        1.60 ±  3%  perf-profile.children.cycles-pp.clock_gettime
      1.45 ±  2%      +0.9        2.37        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.60 ±  3%      +0.9        1.53        perf-profile.children.cycles-pp.__switch_to
      0.67 ±  3%      +0.9        1.60        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.07 ±  6%      +0.9        1.01 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
      1.42 ±  2%      +1.1        2.48        perf-profile.children.cycles-pp.hrtimer_active
      0.34 ±  7%      +1.1        1.45        perf-profile.children.cycles-pp.llist_add_batch
      1.46 ±  2%      +1.1        2.59        perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      2.56            +1.1        3.69        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.30 ±  8%      +1.2        1.50        perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.29 ±  4%      +1.3        2.63        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.16            +1.4        3.57        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.44 ±  6%      +1.5        1.90        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.68 ±  3%      +1.5        2.16        perf-profile.children.cycles-pp.__switch_to_asm
      0.42 ±  3%      +1.5        1.91        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.82 ±  2%      +1.5        3.32        perf-profile.children.cycles-pp.switch_fpu_return
      0.22 ±  6%      +1.6        1.83 ±  5%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.43 ±  7%      +1.7        2.12        perf-profile.children.cycles-pp.set_task_cpu
      1.82 ±  3%      +1.8        3.60 ±  2%  perf-profile.children.cycles-pp.stress_pthread_func
      1.48            +1.8        3.32        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.60 ±  5%      +1.9        2.53        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.58 ± 11%      +2.1        2.68 ±  2%  perf-profile.children.cycles-pp.intel_idle
      0.81 ±  9%      +2.2        3.03        perf-profile.children.cycles-pp.poll_idle
      2.53 ±  2%      +2.3        4.87        perf-profile.children.cycles-pp._raw_spin_lock
      6.30 ±  2%      +7.0       13.28        perf-profile.children.cycles-pp.cpuidle_enter_state
      6.31 ±  2%      +7.0       13.30        perf-profile.children.cycles-pp.cpuidle_enter
      6.63 ±  2%      +7.4       14.07        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.40 ±  5%     +10.5       12.91        perf-profile.children.cycles-pp.select_idle_core
     30.41           -29.3        1.15 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      9.76 ±  2%      -8.6        1.19        perf-profile.self.cycles-pp.update_load_avg
     11.21 ±  3%      -4.4        6.84        perf-profile.self.cycles-pp.select_idle_cpu
      0.38 ±  2%      -0.2        0.21        perf-profile.self.cycles-pp.rb_insert_color
      0.48 ±  2%      -0.1        0.34        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.24 ±  3%      -0.1        0.12        perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.38 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp.get_nohz_timer_target
      0.10            -0.1        0.05        perf-profile.self.cycles-pp.entity_eligible
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.ktime_get
      0.09 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.perf_swevent_event
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.select_task_rq
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.mm_cid_get
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.05            +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.06 ±  9%      +0.0        0.09        perf-profile.self.cycles-pp.place_entity
      0.05            +0.0        0.09        perf-profile.self.cycles-pp.set_next_entity
      0.06 ±  8%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.33 ±  3%      +0.0        0.38        perf-profile.self.cycles-pp.update_rq_clock
      0.16 ±  3%      +0.0        0.21        perf-profile.self.cycles-pp.__dequeue_entity
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.cpu_startup_entry
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__bitmap_and
      0.08 ±  4%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__hrtimer_init
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.10 ±  5%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.05            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.remove_entity_load_avg
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.activate_task
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__update_load_avg_blocked_se
      0.13 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.07        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±  8%      +0.1        0.13        perf-profile.self.cycles-pp.do_syscall_64
      0.13 ±  3%      +0.1        0.20        perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rb_next
      0.08            +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.resched_curr
      0.07 ±  6%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.rb_erase
      0.09            +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.06 ±  9%      +0.1        0.14        perf-profile.self.cycles-pp.common_nsleep
      0.04 ± 44%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.10 ±  3%      +0.1        0.19        perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.set_next_buddy
      0.08 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.07 ±  5%      +0.1        0.17        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  4%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.avg_vruntime
      0.06 ±  7%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.13 ±  3%      +0.1        0.24        perf-profile.self.cycles-pp.pick_eevdf
      0.17 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.do_nanosleep
      0.07 ± 20%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.06 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.call_cpuidle
      0.10 ±  4%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.stress_mwc32modn
      0.24            +0.1        0.37        perf-profile.self.cycles-pp.os_xsave
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.newidle_balance
      0.08 ±  6%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.02 ±141%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.16 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ±  5%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.timerqueue_add
      0.14 ± 11%      +0.1        0.28 ± 17%  perf-profile.self.cycles-pp.clock_gettime
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.34            +0.1        0.48        perf-profile.self.cycles-pp.dequeue_entity
      0.12 ±  4%      +0.1        0.27        perf-profile.self.cycles-pp.try_to_wake_up
      0.14 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.read_tsc
      0.16 ±  2%      +0.1        0.31        perf-profile.self.cycles-pp.perf_tp_event
      0.32 ±  3%      +0.2        0.47        perf-profile.self.cycles-pp.update_rq_clock_task
      0.13 ± 14%      +0.2        0.28 ±  6%  perf-profile.self.cycles-pp.__nanosleep
      0.26 ± 24%      +0.2        0.43        perf-profile.self.cycles-pp.native_irq_return_iret
      0.08 ±  6%      +0.2        0.25        perf-profile.self.cycles-pp.cpuacct_charge
      0.08 ±  5%      +0.2        0.28        perf-profile.self.cycles-pp.attach_entity_load_avg
      0.19 ±  5%      +0.2        0.38        perf-profile.self.cycles-pp.update_min_vruntime
      0.21 ±  9%      +0.2        0.41        perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.42 ±  2%      +0.2        0.62        perf-profile.self.cycles-pp.__update_load_avg_se
      0.12            +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.cpus_share_cache
      0.15 ±  4%      +0.2        0.36        perf-profile.self.cycles-pp.schedule
      0.19 ±  2%      +0.2        0.40        perf-profile.self.cycles-pp._copy_from_user
      0.20            +0.2        0.42        perf-profile.self.cycles-pp.__enqueue_entity
      0.12 ±  4%      +0.2        0.34        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.13 ±  8%      +0.2        0.38        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.32 ±  2%      +0.3        0.61        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.29 ±  3%      +0.3        0.58        perf-profile.self.cycles-pp.update_curr
      0.28            +0.3        0.58        perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.08 ±  4%      +0.3        0.38        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.16 ±  3%      +0.3        0.46        perf-profile.self.cycles-pp.___perf_sw_event
      0.24 ± 17%      +0.3        0.55 ± 12%  perf-profile.self.cycles-pp.clock_gettime@plt
      0.13 ±  3%      +0.3        0.45        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.09 ±  7%      +0.3        0.41        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.00            +0.3        0.33        perf-profile.self.cycles-pp.do_idle
      0.27 ±  3%      +0.3        0.60        perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.58 ±  3%      +0.3        0.92 ±  5%  perf-profile.self.cycles-pp.stress_mwc32
      0.14 ±  3%      +0.4        0.50        perf-profile.self.cycles-pp.native_sched_clock
      0.59 ±  2%      +0.4        1.01        perf-profile.self.cycles-pp.reweight_entity
      0.11 ±  7%      +0.4        0.55        perf-profile.self.cycles-pp.set_task_cpu
      0.07 ± 10%      +0.5        0.54        perf-profile.self.cycles-pp.nohz_run_idle_balance
      1.12 ±  3%      +0.5        1.60        perf-profile.self.cycles-pp._find_next_bit
      0.23 ±  4%      +0.5        0.72        perf-profile.self.cycles-pp.enqueue_task_fair
      0.40 ±  2%      +0.5        0.91        perf-profile.self.cycles-pp.enqueue_entity
      0.55 ±  3%      +0.5        1.06        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.72            +0.6        1.27        perf-profile.self.cycles-pp.dequeue_task_fair
      0.36 ±  3%      +0.6        0.94        perf-profile.self.cycles-pp.switch_fpu_return
      0.57            +0.6        1.17        perf-profile.self.cycles-pp.prepare_task_switch
      0.21 ±  6%      +0.6        0.84        perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.7        0.65 ±  2%  perf-profile.self.cycles-pp.__update_idle_core
      0.48 ±  2%      +0.8        1.24        perf-profile.self.cycles-pp.finish_task_switch
      0.66 ±  3%      +0.8        1.44        perf-profile.self.cycles-pp.hrtimer_active
      0.78            +0.9        1.63 ±  4%  perf-profile.self.cycles-pp.clock_nanosleep
      0.60 ±  3%      +0.9        1.50        perf-profile.self.cycles-pp.__switch_to
      1.45 ±  2%      +0.9        2.37        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.67 ±  3%      +0.9        1.60        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      1.24            +1.0        2.23        perf-profile.self.cycles-pp._raw_spin_lock
      0.34 ±  6%      +1.1        1.44        perf-profile.self.cycles-pp.llist_add_batch
      0.88 ±  6%      +1.2        2.05 ±  2%  perf-profile.self.cycles-pp.stress_pthread_func
      0.07 ± 10%      +1.2        1.28        perf-profile.self.cycles-pp.poll_idle
      1.29 ±  4%      +1.3        2.63        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.50 ±  3%      +1.4        1.94        perf-profile.self.cycles-pp.select_idle_sibling
      0.38 ±  3%      +1.5        1.86        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.68 ±  3%      +1.5        2.16        perf-profile.self.cycles-pp.__switch_to_asm
      0.21 ±  6%      +1.6        1.79 ±  5%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.80 ±  4%      +1.7        2.46        perf-profile.self.cycles-pp.select_idle_core
      1.43            +1.8        3.19        perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.39 ±  2%      +1.8        3.20        perf-profile.self.cycles-pp.__schedule
      0.58 ± 11%      +2.1        2.68 ±  2%  perf-profile.self.cycles-pp.intel_idle



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

