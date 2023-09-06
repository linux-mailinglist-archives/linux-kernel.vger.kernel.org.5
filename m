Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95E379334B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIFBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjIFBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:18:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE466CF2;
        Tue,  5 Sep 2023 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693963117; x=1725499117;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xo3ZXQQ5wb3NLHpLwuSEFv0ma0UWWMCj4XjUltNYoHs=;
  b=DHtWq0fMQovj1nwwwMO5RppZuHRs3+iLcuv+wHFVB/eImsj4xRybuQ/g
   8RaJdHtzi8j0xH26mOGJACbNBDfLvy9S2t6PJHSyWZzeUfwoOvvWf+Jtf
   GWNULhyCVgrhwSB6mrfJ1FABMgxrcw2+zKQdKwWSax120B+KhCoiTRhIO
   AS8xgcL8bAiO3U45XAvrWjrpVb+YyB4Z5dc7NGrc7JEQH+xqCwiSvFhro
   0wHYKOXXViB+6uQvW0GhNCR6hI+LaMelxVmKPxvKlurwd5+ffzcRcVffx
   dwXSMinNZEHs9fvTyBixvMiLiy4La/d8V7+E6yzwe/0KvQuPux1WDRwIi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443334596"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443334596"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 18:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="770547993"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="770547993"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 18:18:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 18:18:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 18:18:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 18:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3AgJg3PDzS5vTlOPXl8ctrLawDHhj72yhzlxdJwmRJ7XUM/ITedJSDahvIbNYMXOqrxZmdMr5D0BYH3/pKVlAW0qfFym4XNFk1VHsjJkKYUUl9c3z4rjp7Vd5F4l5NM1Ugva6IpgrkwUqFuq0ZmjvYa8lzmvwiXYY2HZ3W/ECKcKhmt9Ef7pmsCC9HgIutnZKysmN0vkz53iotkxd/2TLGTCJ7T8z9HXgeSxoGxSJFxWoD1IW3dwlGPm+opjLjL4K3EBmTSfG+mNDm/DsiroKlleG2EYp+YST0f19YvuR3pkMCEpcxTx+9xSFM1yocbxrfTNyqM8MrTZZGLl6zflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXwxOJjgEB2GXvREM1x0IXEANWoWWqq4UejVqAaJ0sE=;
 b=hPnrIpkczEFXkdc7uN+569rFbvrayQ6RZ0mzNqmRkVHgkKi6ktfSVcoGDAR79pPDu8okynGRrYK4Vk5X27wwxTFLgGFun5ljpNE4MaBmH6ot3Ke0toqqDuEYZ71em/XK5Z69t25A81Ha9x3lg7MBtQ6IdvaAvQ8dNJxBVwpI8CIKUQBeWENQ+gFcNQXycvBmsYo+KSCI9l0zBpahsulplbPfD6tnlZDO/VRY+Z7OdI/qJIbQ/6XFPmWUO5aB6kYQQi+zGIWOHEvquIEs63ruUpZFCh6AqSZ7IpPyJZ0Or6zaa/QyanhcJsN/OLzgmbsA4Q6bvp3j9SKkOV4CCUqu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 6 Sep
 2023 01:18:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 01:18:31 +0000
Date:   Wed, 6 Sep 2023 09:18:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        <linux-pm@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [cpuidle]  5484e31bbb:
 adrestia.wakeup_cost_periodic_us -33.3% improvement
Message-ID: <202309051653.1dce02c8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 37259d0a-976c-4016-1984-08dbae772ec2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWrYcE11oRRTDjfpJa8xs/jy/B/z85J31sxPPJvxqxOLSl6ZKFZZfmwlEPecwHVYEwlY6mQBAvix4CfgqfgNwfm1LYX3mZ+TfJLb1qReVuSq/iIpKghRCqAYo/M+GFnOX35qO8nYUaVImPUpyXrFH6J4Z+2mG59TvFc9cGXTcznBICHPjWojYzmTwHa1UiHdYuWoWhQdy1C+RxUePNTbsbroOwf3CUpgqH8u+C76uEJ+aJ4vSmPM/l5g/4XSK81GFrvEcGKPHBlQbq2FVKz2ryWpHezWCarRglkjZn7QXrLpbwXEv7AxKhGSZOX0CkLVaRvYCrawbaaQzTkQ7aFpV38wxDF7pFo/AbzI0wKgufmHYb8wmfbwo75QabBURcBhJPMvHwA6OTskO0brFeWVEQsd89ynGRxIqrjEjxfnQZGE0wjcRLFWzpwcBIQTYphHc36NJ2HQHAk+8sUJUkSIlS70U9uHb/RgAxIhBXGuFSCdlsZYeM8CJCWdR4kwxevdncpcA63sKtTrKxU/gsp/wXRJyl2WBRrCFASnRx5bCEPpAdvecI844phHJOoCsQwZyD4RwD0aS9RnLXcavYaXNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(478600001)(36756003)(8676002)(4326008)(86362001)(2616005)(5660300002)(6666004)(1076003)(6506007)(6486002)(26005)(6512007)(6862004)(41300700001)(107886003)(8936002)(83380400001)(66556008)(37006003)(38100700002)(6636002)(66946007)(966005)(2906002)(66476007)(82960400001)(316002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AjxvP8zFr9/H7f32IF2ZSoNy1LZr8M6SX1HxxsPAVEy0QrxlGbzMrVBnbB?=
 =?iso-8859-1?Q?GCbW1DggKCDPl6pJBpNue+EYky/n6+egLMBP7zgzWQC+NNtQkmMKN1FNy3?=
 =?iso-8859-1?Q?/VNZbtsar/V9q3I7FXvoeYS3JEKduV52R5wt47Z/djxOVI7lBhGDnM+jA3?=
 =?iso-8859-1?Q?JXVA8odEpDQMtItd5HalJEu7tC2RrlCWxpkXUyaFsKhpkRS5qPskcLXnDr?=
 =?iso-8859-1?Q?4+Wo3XPcTf8Bc2SjzUhI8M9uSFECaI3Lf4DPfJejsKWjea/imhOJGRz7EO?=
 =?iso-8859-1?Q?Z3tydlYg2xyhbnNIXmsKn8dShDIUYPQshiTadkG4nGLC8Lz6//fDpT7w91?=
 =?iso-8859-1?Q?hwMOaHcrpie9h2Pv402yBtxzmj+42IqlyejOokECSbbJ2yMY9xQejP8XOH?=
 =?iso-8859-1?Q?o1zD0eWFuEbihitFpJIuL4iHuTsTTZ2rpoJAFhrWgmqFZVOEIPk0U9MNAM?=
 =?iso-8859-1?Q?mf42qcb5edipsXrNMZZxWEy3NR+IABgjDOigwhrqiB5AyBlsGcnS8bWCp0?=
 =?iso-8859-1?Q?gz+CCGO0MDOkwceJwhVir7HDX+mJlx2v7IHYBqLUaS9iQmy4Tm6kJMjZEJ?=
 =?iso-8859-1?Q?/4vXXwY3v8CO40NFVMurluqRoMo/Ni4DiLeI2GaBjQiLSCboJmD/Mmxzd0?=
 =?iso-8859-1?Q?/W0B6K5t0Qvqv5+J95NSGTjN0PknUwBg/jxImsnB66t4+V1FhOAULbX0Ax?=
 =?iso-8859-1?Q?PubiNL/qmPI7UHkN8JDj87fgrnrfIlhceZAud9872N2AcTZCozRLGZJPvO?=
 =?iso-8859-1?Q?1eEG0bgSQUGhRPW2kp0K9cMzVFv2iRioVNsv8bERjN7hpdjrjZsZI1xcHU?=
 =?iso-8859-1?Q?mOP5ucCmMpsblHVFAmRnQH5rVAM/S6tvxaOySec6DQQJUIylTP1pSmlUiA?=
 =?iso-8859-1?Q?eSQzm5EaENeIeL77q2dHXCBzNksKbWoIpBjf10ARsNVtwIW7MtNfdfd1Bb?=
 =?iso-8859-1?Q?5xRnBbu6OtPIgVMIiUA7Wiwph4r02uq88CwDCFR/UrBEISkgy8/tBbuMnG?=
 =?iso-8859-1?Q?qJUYNjUV3KqcN3ABCw9P76pd3qWuDNJXallhF+NeFoj1SL+aJECYDyMTLi?=
 =?iso-8859-1?Q?MaCBIJ8nSOsFjH0MvQU5JRK0I48sP1gl1Q/YbFLX3EHJL5NwWfxV5gfghC?=
 =?iso-8859-1?Q?Nl2kL/AVR/ri2r4GmrRNUt7P75VA6iom0cIKmPmWBMnhw8oQsW+hvpLziw?=
 =?iso-8859-1?Q?YmZarS+FMgX5R9Fv/RnF7ct0Vn1a2jj2Qo8MOJ3r5l5NAI28i3kq7m9/JU?=
 =?iso-8859-1?Q?YiVpOmE8UJ/eq4hbr2FNoJ7jBmcsa9LnXI7Wq5O0O03KrxkiZ3elVluzTn?=
 =?iso-8859-1?Q?4SLdcKRDV006+M6ySPNcacA/yS5hHeBCZSBICHhG6t6nFaWGDacpVhv9uu?=
 =?iso-8859-1?Q?/gfwhJZKIw/XRA23FcOiy/6dk4gz1ApA+QbxvBc8qkpP3JzjmIKguLmBAF?=
 =?iso-8859-1?Q?rhmHAU1WXzSB9+YYJLcMux4ogfSTXr33YdcUEUHg8HlOKpaPng0dga+UEG?=
 =?iso-8859-1?Q?AJOueZ65UREpwe+KPZM7RRWMMoFps4GLN4JpBfXgdr5j9msMm1BTlMRv6H?=
 =?iso-8859-1?Q?eUfUxbV31HjV8PcbC1LTI0kzuWIvzL9Hs5wZoEsQZChY0GDo/uPAlhaiyO?=
 =?iso-8859-1?Q?LL/VsoYu7FpwxS86GNhl8bkeOEu5nZeab30JZhQFsuKHzeIstEc7I4Aw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37259d0a-976c-4016-1984-08dbae772ec2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 01:18:31.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqByKjsm6qDJnrwtK6oP5LFOOOWig0sUATaOHLgTWdCnHp+/aRbcvc9NEEJ2OBtTSqMck/wAxCnxKtvE2ckoYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -33.3% improvement of adrestia.wakeup_cost_periodic_us on:


commit: 5484e31bbbff285f9505c4766373f840ffb746e5 ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: adrestia
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz (Haswell) with 8G memory
parameters:

	nr_threads: 100
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230905/202309051653.1dce02c8-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100/debian-11.1-x86_64-20220510.cgz/lkp-hsw-d04/adrestia

commit: 
  2662342079 ("cpuidle: teo: Gather statistics regarding whether or not to stop the tick")
  5484e31bbb ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")

2662342079f54b8a 5484e31bbbff285f9505c476637 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.06 ± 56%     -52.2%       0.03 ± 17%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      9603            -0.8%       9529        proc-vmstat.nr_slab_unreclaimable
     12707            -6.7%      11859        vmstat.system.in
      0.91            -0.2        0.74        mpstat.cpu.all.irq%
      0.06            -0.0        0.05        mpstat.cpu.all.soft%
    698830 ± 11%     +18.4%     827374 ±  7%  sched_debug.cpu.avg_idle.max
    222705 ± 10%     +18.7%     264460 ±  5%  sched_debug.cpu.avg_idle.stddev
      0.34 ± 16%     +35.5%       0.47 ± 15%  sched_debug.cpu.clock.stddev
    242150           -79.0%      50912 ±  7%  adrestia.time.involuntary_context_switches
     38.40            -5.7%      36.20        adrestia.time.percent_of_cpu_this_job_got
    138.60            -6.7%     129.34        adrestia.time.system_time
      6.00           -33.3%       4.00        adrestia.wakeup_cost_periodic_us
   5674120          +110.4%   11939267        turbostat.C1
     33.31            +5.8       39.11        turbostat.C1%
   3296324           +24.3%    4096313        turbostat.C1E
      4.70            +6.5       11.18 ±  2%  turbostat.C1E%
   5791021           -48.2%    3001325 ±  2%  turbostat.C3
     17.79            +4.8       22.59        turbostat.C3%
    810414           -85.6%     117003 ±  4%  turbostat.C6
      8.11            -6.8        1.31 ±  5%  turbostat.C6%
   1442211           -52.8%     680532 ±  2%  turbostat.C7s
     23.74            -9.1       14.69 ±  2%  turbostat.C7s%
     61.86           +20.3%      74.43        turbostat.CPU%c1
     14.52 ±  2%     -28.7%      10.35 ±  3%  turbostat.CPU%c3
      3.89           -93.4%       0.26 ± 11%  turbostat.CPU%c6
      7.81 ±  5%     -49.6%       3.94 ±  4%  turbostat.CPU%c7
     10.66            +3.9%      11.08        turbostat.CorWatt
      3.49            -0.5        3.02        turbostat.POLL%
      1.48 ±  2%     -75.0%       0.37 ± 18%  turbostat.Pkg%pc2
     18.29            +5.4%      19.28        turbostat.PkgWatt
     12.72           -16.8%      10.59        perf-stat.i.MPKI
 4.574e+08            -3.8%  4.398e+08        perf-stat.i.branch-instructions
      1.46            -0.1        1.31        perf-stat.i.branch-miss-rate%
   7284139            -8.1%    6690632        perf-stat.i.branch-misses
      2.68            -0.9        1.80        perf-stat.i.cache-miss-rate%
    458457           -41.3%     268958        perf-stat.i.cache-misses
  18029497           -17.1%   14954548        perf-stat.i.cache-references
      2.25            -6.0%       2.11        perf-stat.i.cpi
 3.612e+09            -8.1%  3.318e+09        perf-stat.i.cpu-cycles
      9738           -64.2%       3490 ±  4%  perf-stat.i.cpu-migrations
      9532           +49.8%      14284        perf-stat.i.cycles-between-cache-misses
      0.58 ±  2%      -0.2        0.43 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   1915780           -22.0%    1494726 ±  7%  perf-stat.i.dTLB-load-misses
      0.31 ±  3%      -0.1        0.25 ±  5%  perf-stat.i.dTLB-store-miss-rate%
    611947 ±  2%     -22.2%     476112 ±  3%  perf-stat.i.dTLB-store-misses
  3.11e+08            -4.8%  2.962e+08        perf-stat.i.dTLB-stores
     50.70           -12.1       38.63        perf-stat.i.iTLB-load-miss-rate%
    709004           -14.4%     606971 ±  4%  perf-stat.i.iTLB-load-misses
    641330           +22.2%     783541        perf-stat.i.iTLB-loads
 2.025e+09            -3.2%   1.96e+09        perf-stat.i.instructions
      2772           +23.4%       3420 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.48            +5.4%       0.50        perf-stat.i.ipc
      0.45            -8.1%       0.41        perf-stat.i.metric.GHz
    161.95            -3.4%     156.41        perf-stat.i.metric.M/sec
      8.90           -14.3%       7.63        perf-stat.overall.MPKI
      1.59            -0.1        1.52        perf-stat.overall.branch-miss-rate%
      2.54            -0.7        1.80        perf-stat.overall.cache-miss-rate%
      1.78            -5.1%       1.69        perf-stat.overall.cpi
      7878           +56.6%      12335        perf-stat.overall.cycles-between-cache-misses
      0.37            -0.1        0.30 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     52.51            -8.9       43.63 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      2856           +13.2%       3234 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.56            +5.4%       0.59        perf-stat.overall.ipc
 4.565e+08            -3.8%   4.39e+08        perf-stat.ps.branch-instructions
   7270403            -8.1%    6677885        perf-stat.ps.branch-misses
    457602           -41.3%     268449        perf-stat.ps.cache-misses
  17995840           -17.1%   14926426        perf-stat.ps.cache-references
 3.605e+09            -8.1%  3.312e+09        perf-stat.ps.cpu-cycles
      9720           -64.2%       3484 ±  4%  perf-stat.ps.cpu-migrations
   1912206           -22.0%    1491912 ±  7%  perf-stat.ps.dTLB-load-misses
    610806 ±  2%     -22.2%     475217 ±  3%  perf-stat.ps.dTLB-store-misses
 3.104e+08            -4.8%  2.956e+08        perf-stat.ps.dTLB-stores
    707671           -14.4%     605828 ±  4%  perf-stat.ps.iTLB-load-misses
    640132           +22.2%     782070        perf-stat.ps.iTLB-loads
 2.021e+09            -3.2%  1.957e+09        perf-stat.ps.instructions
 1.089e+12            -3.9%  1.047e+12        perf-stat.total.instructions
     28.35 ±  5%      -3.8       24.57 ± 11%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     70.22            -2.0       68.23        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.07 ±  6%      -0.5        1.57 ± 11%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.95 ±  5%      -0.4        3.57 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      4.02 ±  4%      -0.4        3.65 ±  2%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.82 ± 14%      +0.2        1.03 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.07            +0.2        2.29 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
      0.86 ± 15%      +0.2        1.08 ± 12%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.22 ±  3%      +0.3        3.53 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
      3.27 ±  3%      +0.3        3.59 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
      1.30 ± 12%      +0.4        1.71 ± 12%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.41 ± 11%      +0.4        1.84 ± 10%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.21 ±122%      +0.4        0.66 ±  8%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.08 ±  3%      +0.6        4.65 ±  8%  perf-profile.calltrace.cycles-pp.__libc_write.start_thread
     15.14 ±  2%      +0.9       16.08 ±  6%  perf-profile.calltrace.cycles-pp.start_thread
     28.56 ±  5%      -3.8       24.73 ± 11%  perf-profile.children.cycles-pp.poll_idle
     70.19            -2.0       68.19        perf-profile.children.cycles-pp.do_idle
     70.22            -2.0       68.23        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     70.22            -2.0       68.23        perf-profile.children.cycles-pp.cpu_startup_entry
      2.40 ±  4%      -0.6        1.80 ±  9%  perf-profile.children.cycles-pp.menu_select
      0.74 ± 18%      -0.4        0.33 ± 32%  perf-profile.children.cycles-pp.newidle_balance
      1.47 ±  8%      -0.4        1.05 ± 14%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.13 ±  4%      -0.4        3.72 ±  2%  perf-profile.children.cycles-pp.schedule
      0.76 ± 13%      -0.4        0.38 ± 26%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.58 ± 19%      -0.3        0.29 ± 24%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.55 ± 14%      -0.3        0.26 ± 45%  perf-profile.children.cycles-pp.load_balance
      0.42 ± 23%      -0.2        0.24 ± 32%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.22 ± 17%      -0.1        0.09 ± 31%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.21 ± 31%      -0.1        0.09 ± 65%  perf-profile.children.cycles-pp.select_idle_cpu
      0.16 ± 25%      -0.1        0.06 ± 88%  perf-profile.children.cycles-pp.set_task_cpu
      0.19 ± 47%      -0.1        0.09 ± 42%  perf-profile.children.cycles-pp.leave_mm
      0.27 ± 18%      -0.1        0.18 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.13 ± 32%      -0.1        0.04 ± 90%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.26 ±  3%      -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.09 ± 26%      +0.1        0.16 ± 28%  perf-profile.children.cycles-pp.clockevents_program_event
      0.44 ±  9%      +0.1        0.56 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.37 ±  3%      +0.2        0.54 ± 11%  perf-profile.children.cycles-pp.mutex_unlock
      0.46 ± 13%      +0.2        0.68 ± 10%  perf-profile.children.cycles-pp.prepare_to_wait_event
      1.63 ±  3%      +0.2        1.87 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      1.75 ± 12%      +0.3        2.04 ± 11%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.87 ± 11%      +0.3        2.19 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.32 ±  4%      +0.4        1.76 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
     13.54 ±  2%      +0.6       14.15 ±  2%  perf-profile.children.cycles-pp.__libc_read
     15.14 ±  2%      +0.9       16.08 ±  6%  perf-profile.children.cycles-pp.start_thread
     27.99 ±  6%      -3.7       24.26 ± 11%  perf-profile.self.cycles-pp.poll_idle
      0.56 ± 20%      -0.3        0.28 ± 24%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.34 ±  5%      -0.3        1.07 ± 11%  perf-profile.self.cycles-pp.menu_select
      0.24 ± 12%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.14 ± 12%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.touch_atime
      0.03 ±127%      +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.21 ± 17%      +0.1        0.35 ± 19%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.44 ± 20%      +0.2        0.59 ± 13%  perf-profile.self.cycles-pp.pipe_write
      0.36 ±  6%      +0.2        0.54 ± 12%  perf-profile.self.cycles-pp.mutex_unlock
      1.42 ±  4%      +0.2        1.60 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      1.32 ±  4%      +0.4        1.76 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

