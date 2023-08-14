Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D577BB68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHNOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHNOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E6FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692022740; x=1723558740;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=c6j96miXYj2tHS5SzTJPQGyoshRTAlsk5g/vP3VldmU=;
  b=fyw5HOZvmzTnfqze0rgkbPuRw5LrkwsFb1ZDDnL4VNbmWX+NEAXIk9mV
   PVBbtpiTsS8uf4OVbhIfRy4Dqy/dBrHi/6M6mmMwmM4oAZgckdIF9zPiW
   x6FnDTdToXN9AGY/2wKiDuame9Z4YgiFSZ2LwzcDxcploRiTf3QVHsV7L
   5jnaTJNiOwV8kgj6GIe6Q5WsDvsNNK6WeEeNYdnkHyV69CRMNGhUyXhFE
   LN5xr4DaBwaakECmVZFJeWQghOaFXbjrNaiMaiK6yMgm3rP/RZgGar3o9
   OdOzmuIauauP4V+Lz+3F5sM6akEecVKncLYTmrMNn5UQS/Pq9nrOwmwQP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370945868"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370945868"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798829324"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798829324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 07:19:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 07:18:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 07:18:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 07:18:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 07:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVbXxrBKAyQ1WRW/+n6ih21RlmnLWZNXM2yKYjy4z6bdD2obPnERZU5NQ6M5k+AyvzzybUfYQ8V1L8V1J8ahwpeLSjf9IjXxsIxXRO3/E15XWIL50NP0NKNZiYqdTyHJ2rZZWsQERJ9v/clw03BKcvdlryNWZX6u0dnK2CrSRC4g88EIcBxxD/GNG0UTz461S1rUil5jqYTxBN2yCaLzhJYbEEzknQuncaTLGTf0aTdehW0s9Ya74BZyglreHWRez7RcOGy5fmyLVus5AXGyceg+25d8RXzMPFmwzBYD0ytmm5GLx71+JJpe++I/d5SpmAasRO5udumbogL8Q/2ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT5KqV/G43QWRGdDac70k/AOVFTg3viWbf05ufDyPBc=;
 b=GNNfi3z/SBbiK4Gm1ih/GzZQYgZp4M5ltiO0q1Nla+A11tOzbfrxqqCI1qeMrFvYJXujCe/zxReHzp1qCe4/KDVIQUgD6LUY4oFGOwFqJJQd2NeE8lHLLa0QlvnrgEZfb58m5jEMxTLjXl78q5lkkqSv31mmQrkMJKkd7l+h0YdC+05GwZPu0CCRgRpIzq1PrJjvIUyVZPprqbAoumKgTZ03DRvVB6nLensKMYc+2FauNNawmLyNaUDH9bzH6+9QkGRPxx0CGmahXROUoVrsYGOHC8y7sB5SBC3Qo+XLvTTrcM8iwqPI7gHHEc7Bj03jv6iPPf2zbFjSDON6Vlr1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:18:57 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:18:56 +0000
Date:   Mon, 14 Aug 2023 22:18:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tio Zhang <tiozhang@didiglobal.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <jiangshanlai@gmail.com>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>, <tiozhang@didiglobal.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: let WORKER_CPU_INTENSIVE be included in
 watchdog
Message-ID: <202308142140.cf9be57a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811102250.GA7959@didi-ThinkCentre-M930t-N000>
X-ClientProxiedBy: KL1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:820:d::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 256e5fc8-1d59-4c2a-8dc1-08db9cd16551
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnJqiQb/8u5aSfbuUPtrBvfqqPrGZmSIvDjLMCEPn8B3eXKElCPFjF3ElOd/4HySGs1z6HbqQEjNAyt3Qw+AUBqpx90sgdGXFqlP4kDW4769dIKgm/67D9Mg1fWMGof1tlCUYTRqFkZHmWeaSKHEHJ4DNrxlTskOdUavx0X85P5sPv/iFPNZD26FeF3v8tKlzGqeI3w4mvJeKQuVMN1FVnMDidB8/Y4nCkDsWIVPEid8leTmpWeSSx1NI591ElFuyXe5Z58hBTrnY0Qz92io37JRY94GmTPIU2Nma/Jua/FZ/vYrz90yfIdpFvfb6y3qiAI+rIf4bni9Z2rcdBWPL14jQsHE/V36oDP5LYBLQluuGzo4a5Eav47jgP//W6JI0une0kpX049ZuCo8GlCXQaLBHMXm/B4HGaFky3Utwuy5VrSiH7IGE+hmr61g8vwOfFk4vqPROH0nAsULCHG4O3kQqkgmY/aurnEQmHE5EMcfziA98ItHXOdkZDvv1wPs4QeU1mOW53S7YorA169OYeS+NL7MRUXJtSN1PbxCXF4EZvx2EFacZ7JsImcv6R6LiFoBa7KNg5y/EwN0xSPxMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(36756003)(5660300002)(86362001)(2906002)(83380400001)(66556008)(6916009)(4326008)(316002)(66946007)(66476007)(38100700002)(41300700001)(26005)(1076003)(107886003)(6512007)(2616005)(6486002)(6506007)(8936002)(8676002)(45080400002)(6666004)(82960400001)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmP+W7FGTW/3YSBSQNRwpaH9USO4DA4aC7a45LBodi2yMd58ONQejvLa1u95?=
 =?us-ascii?Q?EnOlbPmeaFoK0dUUJZOoIbo5VjqSg6DmisinyWGL8sKoNo++NrL4qrR5nVt4?=
 =?us-ascii?Q?YjaLxxP+dx/Ttv/W0VZXoJC1Hl8h2/FjZr4SHAjDWeuUlCMIwPUc6mWJEL6l?=
 =?us-ascii?Q?cKIlWObqL/OzqZ59+Ovx2MPyENZ+dZkz/x15Khrm47VVIlvLizLpmteaEZSW?=
 =?us-ascii?Q?YVCpIIAirkzjTED76O/WOqRUnOiJ6uwrqcKShNf7AbMtg1zNuJHFalV8AioZ?=
 =?us-ascii?Q?qyxblChRbIhv24gxTD1vvZwo2hlaw6WTL+qEUgt/i9g8shwKUz7Oc18reFe7?=
 =?us-ascii?Q?jFQwuJJjwAxY/3xRWMjwndRB/Sa8AI2vFOE7w7B/K0JwoGUr8e8RfXxEoU2o?=
 =?us-ascii?Q?zcTqEp0x5Up1yHC7fE1PpUWzdBIcjvPjb06k8Jey2i9YG85f9xyI/aiPNDtv?=
 =?us-ascii?Q?VilNxz46Y4PeYPS2EIU42gcRdUnieF6f13a12uR3D2zwcqnYs+ekN65NMuZE?=
 =?us-ascii?Q?ObGkanUCPWNddSouWIvy1SyownDU1aS4zlHDLTmNC3fdYsIWH+BaKPY6VT10?=
 =?us-ascii?Q?Td5dXD2guuH0BvLTmLV9OYakHHAAZaxiZ7QjLyMBrZwpFDjq8Flflxipr05c?=
 =?us-ascii?Q?agaWbdVylyMpb6QLCNr6O/G4714DO7kdNcR5nVLZSf9TFSEJggS/jkcci1WJ?=
 =?us-ascii?Q?PrnPmzpI91W3u9J8OvjbkvyrMX06a0+O/1ICZwPT9dSm1hpz7MeiF1KUA/+j?=
 =?us-ascii?Q?s+K4KsYSEmj2rjrC/TpZMNg5a/nnoG7/+69yaf8i3xMfBn4k6gEK+ESrjIK/?=
 =?us-ascii?Q?naHYgx7lisMuH3nWOAhLnRcX2Sc9xxIlbthFiXoHDYFlyH/IDiSF1FG5JuWw?=
 =?us-ascii?Q?Tn8HwR1PCJIrGJF939fZGMKUcVfOif6R06jY9HwlVb4ob9e5cEdoDCF18bK3?=
 =?us-ascii?Q?bOXqGcM4n4s+P5QdTNNJbxFskkoZjBF+aVFl/kpQJNjlckEkPw1dusZuat8l?=
 =?us-ascii?Q?6rrTI7iI1VTU2Bdk2S41F+CJZTBxCaPCLnE1Bom2S2pgFiXvbHtxK2ivEWWc?=
 =?us-ascii?Q?kSHEyjYtADMXb3/bS1iDpmuf5kktg6v9Dhz0MDa7ZOqdsN0WO82JuWgKwByn?=
 =?us-ascii?Q?AnUF1hR0PEgq/Z9a6yKgC1hmQYzLAgkzQDNPMvYnMVAiPjLbBSYyyd/AL7N/?=
 =?us-ascii?Q?b5a1HA7YXZ7mWdN71/lc+j7yyJ4Z0nsR/3Wm47FIHszL6KPFV5ennYROQE+A?=
 =?us-ascii?Q?3/wdL6AEehJa7E0JN7wXpaTteV+cv1Tvlojekr1DROG+yDUpNK0HbAqDoMw3?=
 =?us-ascii?Q?S39n5qfl6mPra9UZS/6pFTN3EMqYWA/Pd9D+YlQSs4rHm3XY3VJ6gd1ztUeK?=
 =?us-ascii?Q?1hqYSrsxIkdJanhak2/kNM1tDcmnJ8/a/YTRwM/VCcusILwLwJAjRWIjiLnQ?=
 =?us-ascii?Q?1h6BGSx4L8a4IS0JPOS4MnfzKON8nEL+7gVBCNbJGZt3FENhMZZYYjPK0ofe?=
 =?us-ascii?Q?btHP+mmuGjunnvRGPgJD7Av5XMZ2/juu+u6QZDNwUGxE62p2S9qABiTWqs6u?=
 =?us-ascii?Q?lASxZ12/zgcoVRO/DXcYf4UapyNaykhO1ZXh7sFxUGELoyo0PXALNAZNmf5d?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 256e5fc8-1d59-4c2a-8dc1-08db9cd16551
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:18:56.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y12o79kU0+thqOqfWhx3E0BQtk1xDONPnga1XwLXMhbxR8l4rijcVJvf0eIPaYc95RkCry+f5pMlLeXeVGj3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
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

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#wq_watchdog_timer_fn" on:

commit: f5d265c1a77104897fad14235b2637b155c01efd ("[PATCH] workqueue: let WORKER_CPU_INTENSIVE be included in watchdog")
url: https://github.com/intel-lab-lkp/linux/commits/Tio-Zhang/workqueue-let-WORKER_CPU_INTENSIVE-be-included-in-watchdog/20230811-182610
base: https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git for-next
patch link: https://lore.kernel.org/all/20230811102250.GA7959@didi-ThinkCentre-M930t-N000/
patch subject: [PATCH] workqueue: let WORKER_CPU_INTENSIVE be included in watchdog

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcu



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308142140.cf9be57a-oliver.sang@intel.com



[   35.935095][    C0] ------------[ cut here ]------------
[   35.936505][    C0] WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:6400 wq_watchdog_timer_fn+0x185/0x3b0
[   35.938627][    C0] Modules linked in:
[   35.939641][    C0] CPU: 0 PID: 100 Comm: systemd-journal Not tainted 6.5.0-rc1-00043-gf5d265c1a771 #1
[   35.941708][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   35.948000][    C0] EIP: wq_watchdog_timer_fn+0x185/0x3b0
[   35.949262][    C0] Code: b8 bc bc 2b c2 e8 db ee c8 00 31 d2 89 c3 85 c0 b8 28 91 89 c2 6a 00 0f 94 c2 31 c9 e8 44 b9 10 00 85 db 58 0f 85 6d ff ff ff <0f> 0b ba
 01 00 00 00 e9 63 ff ff ff 8d b4 26 00 00 00 00 8b 75 e8
[   35.953232][    C0] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000001
[   35.954818][    C0] ESI: c22bb970 EDI: c3aa3500 EBP: c4067f0c ESP: c4067ee8
[   35.956302][    C0] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210246
[   35.957911][    C0] CR0: 80050033 CR2: b7ae9360 CR3: 2d43e000 CR4: 00040690
[   35.959401][    C0] Call Trace:
[   35.960250][    C0]  <SOFTIRQ>
[   35.961061][    C0]  ? show_regs+0x50/0x60
[   35.962135][    C0]  ? wq_watchdog_timer_fn+0x185/0x3b0
[   35.963335][    C0]  ? __warn+0x6f/0x1d0
[   35.964381][    C0]  ? wq_watchdog_timer_fn+0x185/0x3b0
[   35.965658][    C0]  ? report_bug+0x169/0x190
[   35.966864][    C0]  ? exc_overflow+0x40/0x40
[   35.968144][    C0]  ? handle_bug+0x28/0x50
[   35.969223][    C0]  ? exc_invalid_op+0x1a/0x60
[   35.970336][    C0]  ? handle_exception+0x14a/0x14a
[   35.971590][    C0]  ? poke_int3_handler+0x1eb/0x2e0
[   35.972787][    C0]  ? exc_overflow+0x40/0x40
[   35.973818][    C0]  ? wq_watchdog_timer_fn+0x185/0x3b0
[   35.975100][    C0]  ? exc_overflow+0x40/0x40
[   35.976255][    C0]  ? wq_watchdog_timer_fn+0x185/0x3b0
[   35.977590][    C0]  ? show_all_workqueues+0x300/0x300
[   35.978887][    C0]  call_timer_fn+0xb7/0x310
[   35.980130][    C0]  ? show_all_workqueues+0x300/0x300
[   35.981379][    C0]  ? show_all_workqueues+0x300/0x300
[   35.982658][    C0]  __run_timers+0x2a3/0x3b0
[   35.983860][    C0]  run_timer_softirq+0x1c/0x20
[   35.985029][    C0]  __do_softirq+0x144/0x518
[   35.986182][    C0]  ? __lock_text_end+0xc/0xc
[   35.987384][    C0]  call_on_stack+0x45/0x50
[   35.988532][    C0]  </SOFTIRQ>
[   35.989438][    C0]  ? irq_exit_rcu+0xb3/0xf0
[   35.990584][    C0]  ? sysvec_apic_timer_interrupt+0x1f/0x30
[   35.992046][    C0]  ? handle_exception+0x14a/0x14a
[   35.993299][    C0]  ? percpu_ref_put_many+0x64/0x140
[   35.994831][    C0]  ? vmware_sched_clock+0x100/0x100
[   35.996171][    C0]  ? lock_release+0x7b/0xe0
[   35.997313][    C0]  ? vmware_sched_clock+0x100/0x100
[   35.998584][    C0]  ? lock_release+0x7b/0xe0
[   35.999799][    C0]  ? percpu_ref_put_many+0x78/0x140
[   36.001302][    C0]  ? uncharge_folio+0x198/0x3a0
[   36.002498][    C0]  ? __mem_cgroup_uncharge_list+0x52/0x90
[   36.003965][    C0]  ? release_pages+0x17b/0x4b0
[   36.005193][    C0]  ? __folio_batch_release+0x1d/0x40
[   36.006440][    C0]  ? shmem_undo_range+0x2f8/0x7f0
[   36.007799][    C0]  ? shmem_evict_inode+0x111/0x2e0
[   36.008857][    C0]  ? __lock_release+0x152/0x2f0
[   36.009924][    C0]  ? check_preemption_disabled+0x2a/0x50
[   36.011540][    C0]  ? preempt_count_sub+0x74/0x150
[   36.012814][    C0]  ? _raw_spin_unlock+0x57/0x80
[   36.014052][    C0]  ? evict+0xed/0x220
[   36.015188][    C0]  ? evict+0xed/0x220
[   36.016345][    C0]  ? iput_final+0x148/0x190
[   36.017550][    C0]  ? iput+0x14f/0x180
[   36.024349][    C0]  ? dentry_unlink_inode+0xaf/0x110
[   36.025748][    C0]  ? __dentry_kill+0x11f/0x200
[   36.027051][    C0]  ? dentry_kill+0x7b/0x1f0
[   36.028271][    C0]  ? dput+0x2d8/0x2f0
[   36.029343][    C0]  ? __fput+0x164/0x400
[   36.030465][    C0]  ? ____fput+0xd/0x10
[   36.031626][    C0]  ? task_work_run+0x94/0xf0
[   36.033020][    C0]  ? exit_to_user_mode_prepare+0x335/0x340
[   36.034506][    C0]  ? syscall_exit_to_user_mode+0x1a/0x50
[   36.035998][    C0]  ? do_int80_syscall_32+0x62/0xa0
[   36.037305][    C0]  ? entry_INT80_32+0x107/0x107
[   36.038557][    C0] irq event stamp: 234966
[   36.039817][    C0] hardirqs last  enabled at (234978): [<c10eaca6>] __up_console_sem+0x56/0x60
[   36.041931][    C0] hardirqs last disabled at (234987): [<c10eac8d>] __up_console_sem+0x3d/0x60
[   36.044105][    C0] softirqs last  enabled at (233030): [<c1d34934>] __do_softirq+0x2a4/0x518
[   36.046155][    C0] softirqs last disabled at (234197): [<c1023fb5>] call_on_stack+0x45/0x50
[   36.048296][    C0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230814/202308142140.cf9be57a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

