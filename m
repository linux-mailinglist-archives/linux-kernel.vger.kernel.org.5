Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660107D7AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJZCdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:33:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EE182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698287610; x=1729823610;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=afWuW7Tg6/NQREVQIUYp56TvNXG1fhL9JXSINR4qIBs=;
  b=GUpNNPdzJFYfqv8j6WTCONf0t9YDu7oKVWiUOornEeFv05MSVt98pkPV
   jHUne/8f/smUlvKQzjB+IbilH2ZdDux9WF5cCNZD3S5NnqHeA2tp3/LY0
   eQyc46Z7rbyqlsYqCVsHEdHB3r/uXE7Dhil+pn4WAVgc8w+2y3JyirJjH
   iiOtRs0w/CQUxxZI3eU3sDnbVq2q/Bn8GmfelOWI2xXYMeqZnJpoWpJaQ
   eylUH0m395QNmi5lI033BsbMxAwlVjpBkntQnt809rpSiFFQR8vZj9g/Q
   C7LP48LInWtRGPflWTPfIWvmVV6isHdBuw+mlMGPH3RaGyDRBWExUw0OP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9000017"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9000017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829453045"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829453045"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 19:33:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 19:33:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 19:33:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 19:33:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXrLI6ZNhXBscriGKq0FHdPaOWZIDg7mZc7/yCbdeKxMRdGyCYoknyMN/luJ0jWzVmu1JUwK6eyRhhQOovsJsQd2td6CXtjLi1H0qBXnC3NXxe0YC7ezn+RWWSMHQNpzMGF0w5BsIhVe+3KJYD/4c72AW4qdaxgLzGVJj2Jwn8Wv3TiYO5rtI1ZA6QINa4vHZnjS5VvpaapdtXWC/Tl6y3yxXDNzoTEuNYH1gQcBCslnrEb/HFkIfDR4psnhK1EYdk79KQ1Os8RlVfnd12zbvQFwHCFm0MTtXpl8LdYF27PVoOpWGGlmPErgmAf42CgUNQv1Kj/ciI66O6wBr1LB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+OmCD5Tz1+o3NAyIxiPpW6JMCsc2HP0QNL4xyvT83U=;
 b=cUlMvY+xvrXctDP4IPzWRqHc0ImSlpSJHUcA87VVke6C2mHJXwU9s82Kswy7dMa+Qz2/VDGnOgMQcuKXu8hgoWAuRG8cX6uXSD24DEeE63KPwyNm7IWfjtZ99Ydthd7g/P5AfdK3dAkLlkgbcLk/3riMs9Jg0pRtWkGWDrVrTJ/vXBaeqi6GCWrhifsC99HxyNmKyU4oNO0y8AB0Ro0TJual2kO3eWBUGwuxvBRlgDQW/Lol56BuBaxNm3KPPhPHm18LzOB2Suq2c26DWtMkxsYNXHGSQTeMeMfK91iyh21DdSOZ8nYdhNZXiMMcXZnUXqTYULow94Q5Z33RAOF9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:33:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:33:26 +0000
Date:   Thu, 26 Oct 2023 10:33:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <202310261029.ea8e81e8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: KL1PR0401CA0036.apcprd04.prod.outlook.com
 (2603:1096:820:e::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 11069c36-204a-4ea9-d8eb-08dbd5cbee8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4OaZOjc5lGMuUpWl3PFE4hGZPHVPYy8x2jMBlpCk6OEKY9o6V/wFKDkB+aImg07S8I+yTVs1Hl9yYTi8nl2B5B/4UU5UXCA/0FZXjLKwdpjVIR4vIHYyLYDh8PVAgnqZHj0lwD190DGMNJv/eyh++g9yZF+4JBS1/67DTHxWze/moYQL1fp+qsokYNfO7ZJIFkRBiRuZ2F0Mms14eyi6VMXoypFOWCbsFo/RmZ8Np66BeXaYVK86aKe97kNHQTQopLP6j/TyiTbSbWil4jH3NjuPj4EMnE6CH25TNd7/fUV6To5ItCxiNBnRDaMGBmelfEn4QLU+FCYaA0mypwYHs5tYMmLowa0fKAMkZk5f6SjrYFO4C78QDEh24A7oZ1Nqx/ZfeUpXxV2zB9yMgaehlMm932U7C5fuhnq7HdADiDqRKD8DQoIlFrgOYS+ofsbf93mCHk6JyyezFjHDu4xBT2vwum27Y9ExgecIvso7qOc5BbaDLgB7AkvG13BNoIBiQO42n++/L3Sb0stMccOGTV5uTyAHsIOfIXP7lrZe3T0rj4W1bW8mKbesxVlLagEAkrS1wK3qDNsgk/WLKoCMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6666004)(45080400002)(478600001)(6506007)(107886003)(66476007)(2616005)(66556008)(54906003)(66946007)(6512007)(36756003)(1076003)(6916009)(966005)(86362001)(6486002)(26005)(82960400001)(38100700002)(41300700001)(8676002)(8936002)(83380400001)(4326008)(316002)(5660300002)(2906002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hF762pcE3Ev8SICiiwci+utWTaCUZ9TQmZng/PyRgt63i8EV/dKrGOrZWMLo?=
 =?us-ascii?Q?hMTYtDi42Veehi7H1GOFYKNMSvZe6MdKMZo36Fln0OI7wkY2GKzfWXudqK5Z?=
 =?us-ascii?Q?WeG5S1vylaioAedNRrHTJnwhrTuBmXYh9hCt1Xx1GTD33emXncMFOR+MdUoN?=
 =?us-ascii?Q?TWKykI7qpWAUhvoJbPZtZusd7s/8juB5BHo/pHbbes5P0pVlz7YoW0odXzfV?=
 =?us-ascii?Q?zU2tO6AnzjwnJLdFQjVZiGJJsqccs6+gqdg/Vs0wy8vZKrPElz/ERjcHyC5j?=
 =?us-ascii?Q?ESat3JlqlpJsasrgDPYJjJA8G2aMRCGBBcHqsmmG3zPkTrBWk7ijL1BY1knS?=
 =?us-ascii?Q?W7AM2V2O4wqIIw2JvcNDG7o2PvoAwYWRvERSlrM0ktya73ila5rmP/Dk0wDk?=
 =?us-ascii?Q?8veL9hHzYOAxPPdfkjoKFLZsoiZiDig8/pjhzT8pZ7rsGEe6ReKqT8IGmDhi?=
 =?us-ascii?Q?KiIsqQOZgf+e++EDY3qtYCwQ+C0G8SrKvtb/JnEbC39UnPKUJkp85Cmb/sdO?=
 =?us-ascii?Q?jsez81rptzLElsq6nUmw4mJkV9rd2k3M3qCOk+WX/OSxzp6/R0etTKTcx8Ko?=
 =?us-ascii?Q?ES/rsNdgWZHV5e3XKdth+QVvbR46L2Pyc0kpFPVK6UCofjf61i/4rfyLYi7G?=
 =?us-ascii?Q?SFZR3e2Ia/40Geilau8KKjaT1twZmw0E6WAusS5dJRtv74444mZFYndmLdus?=
 =?us-ascii?Q?ARThV5OA3gNQKigw1IHAMswsy+FCntNmvMJz6Qz4XexLz0CcwLh/xYLAFTFt?=
 =?us-ascii?Q?UA41faL8PAb0/pmLiPuMXTaxumXFWkPdkoh1vNA2DcWSwYXAy6Zf9SHwyykA?=
 =?us-ascii?Q?vwVZHDU9cfQWAe0afM5U5lp3OUWwWo6vELdXDorGz3h4XQIQsmmpHDu0jlbb?=
 =?us-ascii?Q?MTmHunxhrnmA2EkaUzbSrszNURI9NMuZjK5nEt1UTYpel3XnFkNOzppioKqu?=
 =?us-ascii?Q?7qTdtt8L98V9uIHrCxwkWoJKzy+xskS6EXAyquv0RgAx20XwAWCDp8VqNven?=
 =?us-ascii?Q?GZvH8FwRKkkaIhFNHksML8EVGc0IEfXt8K7NblRdOAAIGY+AKUn7QXqwE8ea?=
 =?us-ascii?Q?qsnCZwg1kOBZ0n3O3du2P7NQ2+p55MABZEOWaj4pvGZyEP83x3LOspl+BWkL?=
 =?us-ascii?Q?gk9p44OQiyc9OT1tfCK/Uwcq4Wz4Y2MEl8NUgL5RH3AMMEf0zk/68+0iOxLT?=
 =?us-ascii?Q?SCdl+LTqqvZQGZ+UgaX5zsCIcdd+rUEPnsZIrxdeItKiRv7MigfVremcHtfj?=
 =?us-ascii?Q?IxCB/ZALo93e4AEyp+FB9aKxOU9V7r/VcZ8BvEPtGmYrmHCIO9daMPk6iUZg?=
 =?us-ascii?Q?pGpYmSy9LPVxW+sQwhhHlGXh565D8G06XJkmbTRkua1WnNfzl+Ji4DlygOJo?=
 =?us-ascii?Q?Bvvpw4zCHcfFnWzJv4hyg8bmh1JLxhqG1JxUJ7QiO1Q3BsVzAy5DNj8UplKb?=
 =?us-ascii?Q?nONyRlE79P05bBlIpH+yIRVG3xVWEHtAFJBITiedeYh/+XladxgWhpAFajvu?=
 =?us-ascii?Q?+bQdCCrmLw7t4dVVHjlpNM0M2ZSJZVyprGq0VrCgxigE8SqEyCqfoHKdm/+r?=
 =?us-ascii?Q?pS1z3h1Z19Ud8sTVQ6AGAujvOcWWcsRZkNJ74nTH53iNeNRf7s5QlO0bE6W6?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11069c36-204a-4ea9-d8eb-08dbd5cbee8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:33:26.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LldmsRFj4pxWzJo6JdfCcYZeNIr5+W1gLqyZvdEWPhm3YIISDn4HqQrLvhC2AnooBv2XwWX9zvMaFQjIsyhzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/locking/irqflag-debug.c:#warn_bogus_irq_restore" on:

commit: e0e3e69931bce73960e6583cd6385ebbd77fa12f ("[PATCH] clocksource: disable irq when holding watchdog_lock.")
url: https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/clocksource-disable-irq-when-holding-watchdog_lock/20231017-143723
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 8ceea12d183cf29f28072dede218a04eda2a789c
patch link: https://lore.kernel.org/all/80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp/
patch subject: [PATCH] clocksource: disable irq when holding watchdog_lock.

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------+------------+------------+
|                                                                   | 8ceea12d18 | e0e3e69931 |
+-------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/locking/irqflag-debug.c:#warn_bogus_irq_restore | 0          | 13         |
| RIP:warn_bogus_irq_restore                                        | 0          | 13         |
+-------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261029.ea8e81e8-oliver.sang@intel.com


[   33.794687][    C0] ------------[ cut here ]------------
[   33.795935][    C0] raw_local_irq_restore() called with IRQs enabled
[ 33.797202][ C0] WARNING: CPU: 0 PID: 10 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore (kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[   33.798562][    C0] Modules linked in:
[   33.799208][    C0] CPU: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.6.0-rc1-00009-ge0e3e69931bc #1 1a5570c26ece064894076fe3d70a31d4a0268b39
[   33.801328][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   33.802561][    C0] Workqueue: events_unbound padata_mt_helper
[ 33.803751][ C0] RIP: 0010:warn_bogus_irq_restore (kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 33.804801][ C0] Code: 0f 1f 44 00 00 f3 0f 1e fa 90 80 3d 92 d0 f9 00 00 74 02 90 c3 c6 05 87 d0 f9 00 01 90 48 c7 c7 68 ad 59 82 e8 0c a4 29 ff 90 <0f> 0b 90 90 eb e3 0f 1f 44 00 00 f3 0f 1e fa 44 8b 05 39 1a fc 00
All code
========
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	f3 0f 1e fa          	endbr64
   9:	90                   	nop
   a:	80 3d 92 d0 f9 00 00 	cmpb   $0x0,0xf9d092(%rip)        # 0xf9d0a3
  11:	74 02                	je     0x15
  13:	90                   	nop
  14:	c3                   	ret
  15:	c6 05 87 d0 f9 00 01 	movb   $0x1,0xf9d087(%rip)        # 0xf9d0a3
  1c:	90                   	nop
  1d:	48 c7 c7 68 ad 59 82 	mov    $0xffffffff8259ad68,%rdi
  24:	e8 0c a4 29 ff       	call   0xffffffffff29a435
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	eb e3                	jmp    0x13
  30:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  35:	f3 0f 1e fa          	endbr64
  39:	44 8b 05 39 1a fc 00 	mov    0xfc1a39(%rip),%r8d        # 0xfc1a79

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	90                   	nop
   4:	eb e3                	jmp    0xffffffffffffffe9
   6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   b:	f3 0f 1e fa          	endbr64
   f:	44 8b 05 39 1a fc 00 	mov    0xfc1a39(%rip),%r8d        # 0xfc1a4f
[   33.806560][    C0] RSP: 0000:ffff88842fa05e40 EFLAGS: 00010286
[   33.807965][    C0] RAX: 0000000000000000 RBX: ffffffff82c290c0 RCX: 0000000000000100
[   33.809247][    C0] RDX: ffff888100578000 RSI: ffffffff810c1d4f RDI: 0000000000000001
[   33.810559][    C0] RBP: 0000000000000246 R08: 0000000000000000 R09: 0000000000000001
[   33.812116][    C0] R10: 0000000000000001 R11: ffffffff82c10bf8 R12: ffffffff811c03c0
[   33.813603][    C0] R13: 00000000fffedb90 R14: 00000000fffedb90 R15: ffff88842fa05f08
[   33.814564][    C0] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[   33.816171][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.817290][    C0] CR2: ffff88843ffff000 CR3: 0000000002853000 CR4: 00000000000406f0
[   33.818566][    C0] Call Trace:
[   33.819066][    C0]  <IRQ>
[ 33.819497][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 33.820147][ C0] ? __warn (kernel/panic.c:673) 
[ 33.820756][ C0] ? warn_bogus_irq_restore (kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 33.821557][ C0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 33.822432][ C0] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 33.822560][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 33.823248][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 33.823984][ C0] ? clocksource_watchdog_kthread (kernel/time/clocksource.c:400) 
[ 33.824914][ C0] ? __warn_printk (kernel/panic.c:722) 
[ 33.825736][ C0] ? warn_bogus_irq_restore (kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 33.826566][ C0] _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:134 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 33.827489][ C0] call_timer_fn (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/timer.h:127 kernel/time/timer.c:1701) 
[ 33.828252][ C0] ? clocksource_watchdog_kthread (kernel/time/clocksource.c:400) 
[ 33.829277][ C0] __run_timers (kernel/time/timer.c:1752 kernel/time/timer.c:2022) 
[ 33.830126][ C0] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[ 33.830563][ C0] ? sched_clock_cpu (kernel/sched/clock.c:270 kernel/sched/clock.c:405) 
[ 33.831364][ C0] irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[ 33.832124][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14)) 
[   33.833107][    C0]  </IRQ>
[   33.833608][    C0]  <TASK>
[ 33.834109][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 33.834562][ C0] RIP: 0010:clear_page_rep (arch/x86/lib/clear_page_64.S:20) 
[ 33.835452][ C0] Code: 5b 08 48 83 c7 18 e8 24 ab fe ff 48 89 5d 20 48 85 db 75 e2 5b 5d e9 34 e8 3f ff 0f 1f 40 00 f3 0f 1e fa b9 00 02 00 00 31 c0 <f3> 48 ab c3 90 f3 0f 1e fa 31 c0 b9 40 00 00 00 0f 1f 44 00 00 ff
All code
========
   0:	5b                   	pop    %rbx
   1:	08 48 83             	or     %cl,-0x7d(%rax)
   4:	c7                   	(bad)
   5:	18 e8                	sbb    %ch,%al
   7:	24 ab                	and    $0xab,%al
   9:	fe                   	(bad)
   a:	ff 48 89             	decl   -0x77(%rax)
   d:	5d                   	pop    %rbp
   e:	20 48 85             	and    %cl,-0x7b(%rax)
  11:	db 75 e2             	(bad)  -0x1e(%rbp)
  14:	5b                   	pop    %rbx
  15:	5d                   	pop    %rbp
  16:	e9 34 e8 3f ff       	jmp    0xffffffffff3fe84f
  1b:	0f 1f 40 00          	nopl   0x0(%rax)
  1f:	f3 0f 1e fa          	endbr64
  23:	b9 00 02 00 00       	mov    $0x200,%ecx
  28:	31 c0                	xor    %eax,%eax
  2a:*	f3 48 ab             	rep stos %rax,%es:(%rdi)		<-- trapping instruction
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	f3 0f 1e fa          	endbr64
  33:	31 c0                	xor    %eax,%eax
  35:	b9 40 00 00 00       	mov    $0x40,%ecx
  3a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   3:	c3                   	ret
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64
   9:	31 c0                	xor    %eax,%eax
   b:	b9 40 00 00 00       	mov    $0x40,%ecx
  10:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  15:	ff                   	.byte 0xff
[   33.838561][    C0] RSP: 0000:ffff88810057fc98 EFLAGS: 00010246
[   33.839599][    C0] RAX: 0000000000000000 RBX: ffffea0005140000 RCX: 0000000000000200
[   33.840946][    C0] RDX: 0000000000000200 RSI: ffffea0005148000 RDI: ffff888145200000
[   33.842280][    C0] RBP: 0000000000000700 R08: 0000000000000001 R09: 0000000000000001
[   33.842562][    C0] R10: 0000000000000001 R11: ffffffff84799a30 R12: 0000000000145000
[   33.843895][    C0] R13: 000000000000000a R14: 0000000000000001 R15: 0000000000000400
[ 33.845247][ C0] __free_pages_ok (mm/page_alloc.c:1070 mm/page_alloc.c:1164 mm/page_alloc.c:1266) 
[ 33.846083][ C0] deferred_free_range (mm/mm_init.c:1990) 
[ 33.846565][ C0] deferred_init_maxorder (mm/mm_init.c:2145) 
[ 33.847517][ C0] deferred_init_memmap_chunk (mm/mm_init.c:2168) 
[ 33.848497][ C0] padata_mt_helper (include/linux/spinlock.h:351 kernel/padata.c:448) 
[ 33.849347][ C0] process_one_work (kernel/workqueue.c:2635) 
[ 33.850240][ C0] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 33.850569][ C0] ? process_one_work (kernel/workqueue.c:2730) 
[ 33.851504][ C0] kthread (kernel/kthread.c:388) 
[ 33.852237][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 33.853263][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 33.854093][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 33.854566][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[   33.855469][    C0]  </TASK>
[   33.856020][    C0] irq event stamp: 110440
[ 33.856786][ C0] hardirqs last enabled at (110448): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:347 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 33.858488][ C0] hardirqs last disabled at (110455): console_unlock (kernel/printk/printk.c:345 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 33.858561][ C0] softirqs last enabled at (105760): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 33.860220][ C0] softirqs last disabled at (109873): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[   33.861864][    C0] ---[ end trace 0000000000000000 ]---
[   43.589614][   T12] rcu_tasks_wait_gp: rcu_tasks grace period number 5 (since boot) is 2542 jiffies old.
[   47.973598][   T26] node 0 deferred pages initialised in 14620ms
[   47.974563][   T26] pgdatinit0 (26) used greatest stack depth: 14104 bytes left
[   48.006348][    T1] allocated 268435456 bytes of page_ext
[   48.007874][    T1] Node 0, zone    DMA32: page owner found early allocated 9 pages
[   48.013919][   T12] Callback from call_rcu_tasks() invoked.
[   48.059811][    T1] Node 0, zone   Normal: page owner found early allocated 67566 pages
[   48.063845][    T1] devtmpfs: initialized
[   48.063942][    T1] x86/mm: Memory block size: 128MB
[   48.105976][    T1] Running RCU synchronous self tests
[   48.106615][    T1] Running RCU synchronous self tests
[   48.106615][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   48.106615][    T1] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[   48.110571][    T1] prandom: seed boundary self test passed
[   48.115313][    T1] prandom: 100 self tests passed


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261029.ea8e81e8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

