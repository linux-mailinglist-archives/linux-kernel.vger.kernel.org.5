Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029E7EC69F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbjKOPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjKOPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:03:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7F1702
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700060599; x=1731596599;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Vzra8FtHel2cN9QukbdOlvCnm8/1jeTfS396oT6xZrQ=;
  b=S5GSHCcSOb93gR9BPSNadu/SqaQbsqLPX3ZTtbF3ImyRH8mB2ByPpX2K
   pyulzU0MIr9PGnl8XGwqzn0+qLHuJsNcTFdzXWtCNDfFWL73phi4nTRqO
   vcvTM8FGwerYoKC96vm+9p93h4BLRGkpcI5SoS+kDhUDblXu0ajnxK+7f
   e+Rc5l0Vl7LKCD8mZmln4HmpyD2kflBIHFoVsmprsuI0qxm8NAkWsxXEe
   RhJX288lO/AbkevEAQ+Q+VYSMVJbcm2+UkJfZ9SD9KdEQZW090DwoUAM2
   wmKnpbQgCgnQi0D0OqnNtRCSSVbSbqgFg/xJlYjSSxRMhtZ9iG1So0EFH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455180689"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="455180689"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768601359"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768601359"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 07:03:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 07:03:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 07:03:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 07:03:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 07:03:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtWQhPMarJcF6g3yOVI1UbSITyfOMkpww3phW1AmnVQw2l5t9Jf9Kmtk3arkKvi5uk0HLXfTFFjTaC/jjigOHT2fgH2cMmqFOVFp99qFlUXZCNTjlyCV7/35Dua1kA0Q3onlPsBnOkqEf0uyekezQRjuO3qyajc+cSCvCp46wwUT1iSvxHCPzr4i7AfbNOc3unSsZxXDkt1JGBB20FDu8z31pVaP52ndiGZTJ5kn8mF9WVXgqwtvFvtO/agWRHF1lh+EFsVIdNYYNBoqV3EUjQwfgmObwqe1wamvhm9svgM7pO+s6ZKOGeEctuLoMWerBB4+5U6FrMMhPg9ia6Imjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRCavXhYQToQ4d+K0io2ylbcZxp/ATerL9DjJkg4tuQ=;
 b=a6Y8GDhGxuGf1/uzr2RLR6VgNfpKjJeWlLsDZubobwJnZbcIUTpLHB3B35MDKGV9+zp8Ocb/hXDDraUjxpFCIb7iLHg9+ZzV55LxRYrGLjzCUd7lrClJa/qLcOwUoq2TZW38t1iOVgKJoeU/Wedfom9po/tlkB1K2/Z+xKcuDQAjknT3v96YQL1LLNr1E/Q6qdaSFpOJOCsAbXzwF55Z6keBzPP683va4rz7oDOtlmB/L+jUt62fWpyvdoonrMFuwNx0OdY1xFvLLF2biMsrOcKfwbJEsJOykFQwhORW259OTEDLCliEh6xl5lBe0hLcRBCn6xVcU/KU/huIfnCN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:03:10 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:03:08 +0000
Date:   Wed, 15 Nov 2023 23:02:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Daniel Gomez <da.gomez@samsung.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "Pankaj Raghav" <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <202311152254.610174ff-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231104005747.1389762-2-da.gomez@samsung.com>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: c968234a-4350-4799-d139-08dbe5ebfa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU9lhoM1mRqryut/AWPyY/nUcnab/Xl9VMR5wHIu7RtiHZSxt8uO/kKyFrME3o368pdmuJyIigkkdRA8l2hap4/rOt3vpO3VkZ6x1AFjGDBrn48jUebQwXGVEbxF2AUv1aoPwCJVPNbMKcLTDQAUqhnY5oDl3x78nmhFnDHPAwFx5ZOF4ZLwD5OcO1B5344Rb8tsPjHfy/pwXemygC93uc1RuXjkO3BjTEOSDM9Z4/o8iOzU9saQlchVZ7O4FT7EsIAoom8dbv1Mr7YH8Ein2FDbGIOqsuVZ0iqKZ4B4f2S0xb+wprRQC6/cnYNKhsTbpeWx4qjzVIcHPEqrLCusI6lxRX0Xj3yTatYcwJxuaicHZQgcXGGv+dVtqgJT/xFqZptcV2ICKy3S7k+TxdR8WcC0oFle94HN4Z30Gr8uliZb+K5BTw9L32OsQGaayOvp5GDk4/B6nSJjtFdRiN+8LAyJ49FAxXUemOH9Cvy41EGkZLAQHnvV8jjFAJ50pOh2Lp6/SNLl+Jr0Y3DPBJ1VNoUKKgs9eTKLaSTHDPnkcXUdxf8byUSWZIq3hasOYsnLkxdvnpFJbwnrN9aJ9pIRJoBRDC3EDaw25yaGAkhuRFxIwoRWrcln4EQb8UW8+nBarpIeCFiVoo+hXs4dcRJZvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(30864003)(478600001)(38100700002)(66946007)(66476007)(66556008)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(1076003)(6666004)(6506007)(6916009)(41300700001)(6486002)(966005)(82960400001)(83380400001)(4326008)(8936002)(8676002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej3B1aYqX5qMfhkE8XSXQHOwYfERPiBUDg23f/Xj6B7YWf0hGuKHnxIxniwj?=
 =?us-ascii?Q?wQSZpk3JC7c5uaIKCG7MFnb282EDzcKQusF/iPOUl5+xrPIDBCic6xMFYSqH?=
 =?us-ascii?Q?i58zy1H4bntjLnMOcjR3UGbw1433ducnkXk+FQDRR41rOu9clfsvrD1n5C/u?=
 =?us-ascii?Q?t8C/KEpzEt0UVK+wlrVyrBJf22K16QGDB06pOhW4i1LPTzZPsdugFdwzkD5S?=
 =?us-ascii?Q?9lW9BcrrydCNSK43RS9O49XwBUOh1Sbtlaa1dkgEmis4t9lVQn3m51KEK5V0?=
 =?us-ascii?Q?m3NPeI89WEVA05CBB4goq5/m4puEjvuCvc2xPLl1NtJrNkokK9B2FDisbEwB?=
 =?us-ascii?Q?W7lvoUWogrcEHRGPQdC6JRVjEMW6/wOE+4xokbRgipBPWkRIKICAqO/4OzO0?=
 =?us-ascii?Q?DdGPc9VRqrSqhcXuuEM5VzTFA55FJzDi5l5xhpf/S7lFFCnBX0opt+661HLx?=
 =?us-ascii?Q?xU/NhW99YfMCI23y2dMbeY7fiHxoM+dwF/mJXgZBQue/SMiT1tpFqPGiTYYj?=
 =?us-ascii?Q?r/i+XwfafYXDqwkIi7+8vIJspdgniI0hxlFoOZ1FODJs/v5N6kgCziDRYzCT?=
 =?us-ascii?Q?b1zLVBI8V5Af1nqfHLErWRCrH6EoB8rG6Jxajy8uhaMpkIjuTDxPUiGsQ5Go?=
 =?us-ascii?Q?eizSiy6T2DtTuNgmbuNh5xN11qZMILl40xa9SBb+P5xpwrTFo2eAXSng86w1?=
 =?us-ascii?Q?PYf564XipGZdzytW1luI4VU0bJzToZ+PIEznkKMzoZHarcxHO3jRwP0xTE/J?=
 =?us-ascii?Q?uIXmQZsCTpsjBKcVz+wlxbO0WsLTWdMW196EWBEB5CxsYFZptk0xaWq35i+G?=
 =?us-ascii?Q?w2SAZmaQVarV7mT08gtayV0+vNBqvrtayusC3QMXqnKyMrlmSBSSfdxf/9p7?=
 =?us-ascii?Q?If1x0HOdvgKLpwJKwAbND9Ln2Hg0SVlnYtOBFeL7eA9saUSTZ6dXqzDcGNbt?=
 =?us-ascii?Q?Au7/SxDkEDIHu/W5t7k2pbqVinlboy2pN5FSZuyCq8MIBPwUHrkRSksCijYF?=
 =?us-ascii?Q?o9e/aVlvLg6YyXoZ8irZFHgOekGRKhYOzGYw71rCuSXCq0VqXr1pLHqgvZzG?=
 =?us-ascii?Q?OrP5+2ZbNg13jCQYXO+2fD9SCBAZRlrWCVjZ+L6pR494e2umhy09duLzdcr3?=
 =?us-ascii?Q?gl8A4iJgp7Yr46ktdfky4+DLzX5hEzbjQKVUkA1sxG2yzg5uwSh7lovtaoL0?=
 =?us-ascii?Q?2+3wld4Y6tXVU39qhNqEo3bZldGvysefYANnJoMuXyd0blyc2tbup/Wft0It?=
 =?us-ascii?Q?X4XE6PX7qPc63WopENvESnh8dl0L+ZlPXfowjOzeHKqLMX5VpMzDEB6dMAUG?=
 =?us-ascii?Q?+WzU3sJvEIoUdw4w+gsbrdzpWb1aLKomkhaB/vdv2Rjzq3OjBw/U0ASB731Q?=
 =?us-ascii?Q?+1/FKsKMblYq3pdHZdp54l4UmmImHqi+QhWpuHDOVWsT9W458gA/liSfRJF2?=
 =?us-ascii?Q?hJyKpPC2jC4Y691AoCJscvokXJSKx/gynRvlTxkB7PnxYfLPkzZfLetVCloF?=
 =?us-ascii?Q?pX/jGgQg1yceHyijm9f+l85ZFF7CdbM4wZJ6ZCEswp213fcTapqAlz6b0gPJ?=
 =?us-ascii?Q?kabN/unf9SURlTH56W9e25emu2qrB4Sxgm0+AHsR4qvsdLcQ60gPdM8tK0qA?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c968234a-4350-4799-d139-08dbe5ebfa61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:03:08.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2rM5ftN9YCUYHBZu4Ndmx3JK92Uc2Z5YpSmdUY5d9W3Tq6LT+yk8QGwqpS0DDlf2zuh748jfc7JF7vuohBuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
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

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 68f563aa7e55d45795a0396c36a4d3d485f845a0 ("[PATCH 1/2] test_xarray: add tests for advanced multi-index use")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Gomez/test_xarray-add-tests-for-advanced-multi-index-use/20231104-085907
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e392ea4d4d00880bf94550151b1ace4f88a4b17a
patch link: https://lore.kernel.org/all/20231104005747.1389762-2-da.gomez@samsung.com/
patch subject: [PATCH 1/2] test_xarray: add tests for advanced multi-index use

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | e392ea4d4d | 68f563aa7e |
+----------------------------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                                     | 0          | 9          |
| include/linux/xarray.h:#suspicious_rcu_dereference_check()usage                  | 0          | 9          |
| include/linux/xarray.h:#suspicious_rcu_dereference_protected()usage              | 0          | 9          |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                                   | 0          | 9          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311152254.610174ff-oliver.sang@intel.com


[  304.121213][    T1] WARNING: suspicious RCU usage
[  304.122111][    T1] 6.6.0-12894-g68f563aa7e55 #1 Tainted: G                 N
[  304.123404][    T1] -----------------------------
[  304.124297][    T1] include/linux/xarray.h:1200 suspicious rcu_dereference_check() usage!
[  304.125787][    T1]
[  304.125787][    T1] other info that might help us debug this:
[  304.125787][    T1]
[  304.127648][    T1]
[  304.127648][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  304.129454][    T1] no locks held by swapper/1.
[  304.130560][    T1]
[  304.130560][    T1] stack backtrace:
[  304.131863][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
[  304.132791][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  304.132791][    T1] Call Trace:
[  304.132791][    T1]  <TASK>
[ 304.132791][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 304.132791][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 304.132791][ T1] xas_start (include/linux/xarray.h:1200 include/linux/xarray.h:1198 lib/xarray.c:190) 
[ 304.132791][ T1] xas_load (lib/xarray.c:237) 
[ 304.132791][ T1] xas_store (lib/xarray.c:789) 
[ 304.132791][ T1] ? xa_load (include/linux/rcupdate.h:306 include/linux/rcupdate.h:780 lib/xarray.c:1465) 
[ 304.132791][ T1] check_xa_multi_store_adv_delete+0xf0/0x120 
[ 304.132791][ T1] ? check_find_1+0x690/0x690 
[ 304.132791][ T1] check_xa_multi_store_adv+0x17d/0x650 
[ 304.132791][ T1] check_multi_store_advanced+0x36/0x90 
[ 304.132791][ T1] ? check_xas_retry+0xee0/0xee0 
[ 304.132791][ T1] xarray_checks (lib/test_xarray.c:1941) 
[ 304.132791][ T1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1237) 
[ 304.132791][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 304.132791][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 304.132791][ T1] kernel_init_freeable (init/main.c:1553) 
[ 304.132791][ T1] ? rest_init (init/main.c:1433) 
[ 304.132791][ T1] kernel_init (init/main.c:1443) 
[ 304.132791][ T1] ? rest_init (init/main.c:1433) 
[ 304.132791][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 304.132791][ T1] ? rest_init (init/main.c:1433) 
[ 304.132791][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  304.132791][    T1]  </TASK>
[  304.161541][    T1]
[  304.162053][    T1] =============================
[  304.162982][    T1] WARNING: suspicious RCU usage
[  304.163917][    T1] 6.6.0-12894-g68f563aa7e55 #1 Tainted: G                 N
[  304.165264][    T1] -----------------------------
[  304.166440][    T1] include/linux/xarray.h:1216 suspicious rcu_dereference_check() usage!
[  304.167982][    T1]
[  304.167982][    T1] other info that might help us debug this:
[  304.167982][    T1]
[  304.169978][    T1]
[  304.169978][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  304.171380][    T1] no locks held by swapper/1.
[  304.172271][    T1]
[  304.172271][    T1] stack backtrace:
[  304.173737][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
[  304.175951][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  304.177150][    T1] Call Trace:
[  304.177150][    T1]  <TASK>
[ 304.177150][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 304.177150][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 304.177150][ T1] xas_descend (include/linux/xarray.h:1216 include/linux/xarray.h:1212 lib/xarray.c:206) 
[ 304.177150][ T1] xas_load (lib/xarray.c:245) 
[ 304.177150][ T1] xas_store (lib/xarray.c:789) 
[ 304.177150][ T1] ? xa_load (include/linux/rcupdate.h:306 include/linux/rcupdate.h:780 lib/xarray.c:1465) 
[ 304.177150][ T1] check_xa_multi_store_adv_delete+0xf0/0x120 
[ 304.177150][ T1] ? check_find_1+0x690/0x690 
[ 304.177150][ T1] check_xa_multi_store_adv+0x17d/0x650 
[ 304.177150][ T1] check_multi_store_advanced+0x36/0x90 
[ 304.177150][ T1] ? check_xas_retry+0xee0/0xee0 
[ 304.177150][ T1] xarray_checks (lib/test_xarray.c:1941) 
[ 304.177150][ T1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1237) 
[ 304.177150][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 304.177150][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 304.177150][ T1] kernel_init_freeable (init/main.c:1553) 
[ 304.177150][ T1] ? rest_init (init/main.c:1433) 
[ 304.177150][ T1] kernel_init (init/main.c:1443) 
[ 304.177150][ T1] ? rest_init (init/main.c:1433) 
[ 304.177150][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 304.177150][ T1] ? rest_init (init/main.c:1433) 
[ 304.177150][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  304.177150][    T1]  </TASK>
[  304.209019][    T1]
[  304.209562][    T1] =============================
[  304.210489][    T1] WARNING: suspicious RCU usage
[  304.211422][    T1] 6.6.0-12894-g68f563aa7e55 #1 Tainted: G                 N
[  304.212738][    T1] -----------------------------
[  304.213856][    T1] include/linux/xarray.h:1225 suspicious rcu_dereference_protected() usage!
[  304.216097][    T1]
[  304.216097][    T1] other info that might help us debug this:
[  304.216097][    T1]
[  304.218820][    T1]
[  304.218820][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  304.220914][    T1] no locks held by swapper/1.
[  304.222183][    T1]
[  304.222183][    T1] stack backtrace:
[  304.223559][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
[  304.224892][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  304.224892][    T1] Call Trace:
[  304.224892][    T1]  <TASK>
[ 304.224892][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 304.224892][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 304.224892][ T1] xas_store (include/linux/xarray.h:1225 lib/xarray.c:835) 
[ 304.224892][ T1] check_xa_multi_store_adv_delete+0xf0/0x120 
[ 304.224892][ T1] ? check_find_1+0x690/0x690 
[ 304.224892][ T1] check_xa_multi_store_adv+0x17d/0x650 
[ 304.224892][ T1] check_multi_store_advanced+0x36/0x90 
[ 304.224892][ T1] ? check_xas_retry+0xee0/0xee0 
[ 304.224892][ T1] xarray_checks (lib/test_xarray.c:1941) 
[ 304.224892][ T1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1237) 
[ 304.224892][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 304.224892][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 304.224892][ T1] kernel_init_freeable (init/main.c:1553) 
[ 304.224892][ T1] ? rest_init (init/main.c:1433) 
[ 304.224892][ T1] kernel_init (init/main.c:1443) 
[ 304.224892][ T1] ? rest_init (init/main.c:1433) 
[ 304.224892][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 304.224892][ T1] ? rest_init (init/main.c:1433) 
[ 304.224892][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  304.224892][    T1]  </TASK>
[  304.254135][    T1]
[  304.254916][    T1] =============================
[  304.256249][    T1] WARNING: suspicious RCU usage
[  304.257611][    T1] 6.6.0-12894-g68f563aa7e55 #1 Tainted: G                 N
[  304.259429][    T1] -----------------------------
[  304.260792][    T1] include/linux/xarray.h:1241 suspicious rcu_dereference_protected() usage!
[  304.263056][    T1]
[  304.263056][    T1] other info that might help us debug this:
[  304.263056][    T1]
[  304.265748][    T1]
[  304.265748][    T1] rcu_scheduler_active = 2, debug_locks = 1
[  304.267891][    T1] no locks held by swapper/1.
[  304.269171][    T1]
[  304.269171][    T1] stack backtrace:
[  304.270787][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
[  304.272727][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  304.272727][    T1] Call Trace:
[  304.272727][    T1]  <TASK>
[ 304.272727][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 304.272727][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
[ 304.272727][ T1] xas_store (include/linux/xarray.h:1241 lib/xarray.c:492 lib/xarray.c:759 lib/xarray.c:844) 
[ 304.272727][ T1] check_xa_multi_store_adv_delete+0xf0/0x120 
[ 304.272727][ T1] ? check_find_1+0x690/0x690 
[ 304.272727][ T1] check_xa_multi_store_adv+0x3d4/0x650 
[ 304.272727][ T1] check_multi_store_advanced+0x36/0x90 
[ 304.272727][ T1] ? check_xas_retry+0xee0/0xee0 
[ 304.272727][ T1] xarray_checks (lib/test_xarray.c:1941) 
[ 304.272727][ T1] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1237) 
[ 304.272727][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 304.272727][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 304.272727][ T1] kernel_init_freeable (init/main.c:1553) 
[ 304.272727][ T1] ? rest_init (init/main.c:1433) 
[ 304.272727][ T1] kernel_init (init/main.c:1443) 
[ 304.272727][ T1] ? rest_init (init/main.c:1433) 
[ 304.272727][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 304.272727][ T1] ? rest_init (init/main.c:1433) 
[ 304.272727][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  304.272727][    T1]  </TASK>
[  342.420416][    C0] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 86s!
[  342.423303][    C0] Showing busy workqueues and worker pools:
[  342.424864][    C0] workqueue events: flags=0x0
[  342.426128][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  342.426185][    C0]     pending: psi_avgs_work, kfree_rcu_monitor, stop_one_cpu_nowait_workfn
[  342.426278][    C0] workqueue events_unbound: flags=0x2
[  342.432244][    C0]   pwq 2: cpus=0 flags=0x4 nice=0 active=1/512 refcnt=2
[  342.432286][    C0]     pending: idle_cull_fn
[  342.435502][    C0] workqueue events_power_efficient: flags=0x80
[  342.437095][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  342.437143][    C0]     pending: do_cache_clean, neigh_managed_work, neigh_periodic_work
[  342.437268][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  360.200350][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  360.200360][    C0] rcu: 	(detected by 0, t=26252 jiffies, g=20393, q=113135 ncpus=1)
[  360.200360][    C0] rcu: All QSes seen, last rcu_preempt kthread activity 26252 (4294981469-4294955217), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  360.200360][    C0] rcu: rcu_preempt kthread starved for 26252 jiffies! g20393 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  360.200360][    C0] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  360.200360][    C0] rcu: RCU grace-period kthread stack dump:
[  360.200360][    C0] task:rcu_preempt     state:R  running task     stack:0     pid:16    tgid:16    ppid:2      flags:0x00004000
[  360.200360][    C0] Call Trace:
[  360.200360][    C0]  <TASK>
[ 360.200360][ C0] __schedule (kernel/sched/core.c:5376 kernel/sched/core.c:6688) 
[ 360.200360][ C0] ? io_schedule_timeout (kernel/sched/core.c:6569) 
[ 360.200360][ C0] schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6764 kernel/sched/core.c:6778) 
[ 360.200360][ C0] schedule_timeout (kernel/time/timer.c:1628 include/linux/timer.h:199 kernel/time/timer.c:2168) 
[ 360.200360][ C0] ? usleep_range_state (kernel/time/timer.c:2129) 
[ 360.200360][ C0] ? enqueue_timer (kernel/time/timer.c:2091) 
[ 360.200360][ C0] ? prepare_to_swait_event (kernel/sched/swait.c:122 (discriminator 6)) 
[ 360.200360][ C0] rcu_gp_fqs_loop (kernel/rcu/tree.c:1626 (discriminator 13)) 
[ 360.200360][ C0] ? start_poll_synchronize_rcu_full (kernel/rcu/tree.c:1596) 
[ 360.200360][ C0] ? rcu_gp_init (kernel/rcu/tree.c:1521 (discriminator 23)) 
[ 360.200360][ C0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 360.200360][ C0] rcu_gp_kthread (kernel/rcu/tree.c:1828) 
[ 360.200360][ C0] ? rcu_gp_cleanup (kernel/rcu/tree.c:1800) 
[ 360.200360][ C0] ? __kthread_parkme (kernel/kthread.c:293 (discriminator 3)) 
[ 360.200360][ C0] ? rcu_gp_cleanup (kernel/rcu/tree.c:1800) 
[ 360.200360][ C0] kthread (kernel/kthread.c:388) 
[ 360.200360][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 360.200360][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 360.200360][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 360.200360][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  360.200360][    C0]  </TASK>
[  360.200360][    C0] rcu: Stack dump where RCU GP kthread last ran:
[  360.200360][    C0] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
[  360.200360][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 360.200360][ C0] RIP: 0010:xa_load (lib/xarray.c:1456) 
[ 360.200360][ C0] Code: e8 32 a7 5e fc 48 89 5c 24 28 48 89 6c 24 20 48 c7 44 24 30 00 00 00 00 48 c7 44 24 38 03 00 00 00 48 c7 44 24 40 00 00 00 00 <48> c7 44 24 48 00 00 00 00 48 c7 44 24 50 00 00 00 00 e8 a6 34 4f
All code
========
   0:	e8 32 a7 5e fc       	call   0xfffffffffc5ea737
   5:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
   a:	48 89 6c 24 20       	mov    %rbp,0x20(%rsp)
   f:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  16:	00 00 
  18:	48 c7 44 24 38 03 00 	movq   $0x3,0x38(%rsp)
  1f:	00 00 
  21:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
  28:	00 00 
  2a:*	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)		<-- trapping instruction
  31:	00 00 
  33:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  3a:	00 00 
  3c:	e8                   	.byte 0xe8
  3d:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
  3e:	34 4f                	xor    $0x4f,%al

Code starting with the faulting instruction
===========================================
   0:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
   7:	00 00 
   9:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  10:	00 00 
  12:	e8                   	.byte 0xe8
  13:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
  14:	34 4f                	xor    $0x4f,%al
[  360.200360][    C0] RSP: 0000:ffff888110a9fc90 EFLAGS: 00000246
[  360.200360][    C0] RAX: 0000000000000000 RBX: 00000000020f5ebf RCX: 0000000000000000
[  360.200360][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff87653c00
[  360.200360][    C0] RBP: ffffffff87653c00 R08: 0000000000000000 R09: 0000000000000000
[  360.200360][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff11022153f92
[  360.200360][    C0] R13: 0000000000035ebf R14: 0000000000000012 R15: 0000000002180000
[  360.200360][    C0] FS:  0000000000000000(0000) GS:ffffffff86b45000(0000) knlGS:0000000000000000
[  360.200360][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  360.200360][    C0] CR2: ffff88843ffff000 CR3: 0000000006b1a000 CR4: 00000000000406b0
[  360.200360][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  360.200360][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  360.200360][    C0] Call Trace:
[  360.200360][    C0]  <IRQ>
[ 360.200360][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 360.200360][ C0] ? rcu_check_gp_kthread_starvation (kernel/rcu/tree_stall.h:553 (discriminator 1)) 
[ 360.200360][ C0] ? print_other_cpu_stall (kernel/rcu/tree_stall.h:143 (discriminator 3) kernel/rcu/tree_stall.h:658 (discriminator 3)) 
[ 360.200360][ C0] ? atomic_notifier_call_chain (include/linux/rcupdate.h:306 include/linux/rcupdate.h:780 kernel/notifier.c:232) 
[ 360.200360][ C0] ? check_cpu_stall+0x361/0x4c0 
[ 360.200360][ C0] ? rcu_sched_clock_irq (kernel/rcu/tree.c:3884 kernel/rcu/tree.c:2254) 
[ 360.200360][ C0] ? rcu_note_context_switch (kernel/rcu/tree.c:2233) 
[ 360.200360][ C0] ? rcu_read_lock_sched_held (include/linux/lockdep.h:288 kernel/rcu/update.c:126 kernel/rcu/update.c:120) 
[ 360.200360][ C0] ? update_process_times (kernel/time/timer.c:2073) 
[ 360.200360][ C0] ? msleep_interruptible (kernel/time/timer.c:2065) 
[ 360.200360][ C0] ? tick_do_update_jiffies64 (kernel/time/tick-sched.c:150) 
[ 360.200360][ C0] ? tick_nohz_highres_handler (kernel/time/tick-sched.c:256 kernel/time/tick-sched.c:1516) 
[ 360.200360][ C0] ? __hrtimer_run_queues+0x54e/0x930 
[ 360.200360][ C0] ? tick_do_update_jiffies64 (kernel/time/tick-sched.c:1503) 
[ 360.200360][ C0] ? hrtimer_init (kernel/time/hrtimer.c:1720) 
[ 360.200360][ C0] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 360.200360][ C0] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1083) 
[ 360.200360][ C0] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14)) 
[  360.200360][    C0]  </IRQ>
[  360.200360][    C0]  <TASK>
[ 360.200360][ C0] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 360.200360][ C0] ? xa_load (lib/xarray.c:1456) 
[ 360.200360][ C0] ? xa_clear_mark (lib/xarray.c:1455) 
[ 360.200360][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:203) 
[ 360.200360][ C0] check_xa_multi_store_adv+0x47c/0x650 
[ 360.200360][ C0] check_multi_store_advanced+0x44/0x90 
[ 360.200360][ C0] ? check_xas_retry+0xee0/0xee0 
[ 360.200360][ C0] xarray_checks (lib/test_xarray.c:1941) 
[ 360.200360][ C0] do_one_initcall (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 init/main.c:1237) 
[ 360.200360][ C0] ? trace_event_raw_event_initcall_level (init/main.c:1227) 
[ 360.200360][ C0] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 360.200360][ C0] kernel_init_freeable (init/main.c:1553) 
[ 360.200360][ C0] ? rest_init (init/main.c:1433) 
[ 360.200360][ C0] kernel_init (init/main.c:1443) 
[ 360.200360][ C0] ? rest_init (init/main.c:1433) 
[ 360.200360][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 360.200360][ C0] ? rest_init (init/main.c:1433) 
[ 360.200360][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  360.200360][    C0]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231115/202311152254.610174ff-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

