Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DD7A0A77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjINQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbjINQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:09:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635C1BDD;
        Thu, 14 Sep 2023 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694707770; x=1726243770;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rf6QmqbgMjPg1Cro02ZxCF8jcZ3YuY8jvDTq8IouEHU=;
  b=Q/2r7WnTQQABPthmXnCVibOPIJklEch6Cxxe+O9lptW4mzh3t90WRq0v
   +ihnZJxV05pRu37YZneX90KSTIk8cMo5b0wQBL7wCZp5mpPuz3DG3ngvQ
   28aGHL4/jVaJqf4I5bUeEbgb67mB5PJAVJrSiZsrcN80SBxfE8rZ+a3bX
   hJIQgsxk/oweDsI4EYlwJYatXach+aiyKA5T6FklMGvVLG8vtk3R3HgKp
   XOiWNhJyX2m6+l9Ygq7f32AYD6Cn8rVGfX0CQFP5Z0NZmjrfzb2lzdCPW
   ugl46kH8B0mBfeahNMdb1jUJt8QZxQEtnN19fLsbZA7f9sv6FwdmGgFFX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359255150"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359255150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918307499"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918307499"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:05:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:05:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:05:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfav85sPScRq4y2G4+r1/CQ3xJtL7hmqINQUsJO5Aw5we7bWj9gYtakdWC2VvHA2VBuEmzmm4dFl9n7yVPge6aDTCPwQPn1v6Nr26CDg17kyPupDl5h+j6Ue25p4cCXiHQeqGRPqiz+53FWcmKsJ5be7BOebPNLiJrMc0/OOlPJ1zI/p3zO3xJGfx7AO1Sq+ovW6URDzZFUSXp5tMbIxVTljSqmpNckik+juS+LV3jF9Z6Kw+k3gLyjwi0Rh1vz23KsB5Ri0D4f8cQzBhsKeWkVYz7T5WcZbIhB9ZVeAhWyiS2r9DYLQITtZNMCFP1RS3dW0gZCP5wBnD32K4Cq4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQwcE4JFH0oMxqeatDuBkkFUi3jILChXSmDiKvLfpTE=;
 b=RFoChexRsHOvBqZna+WbiN/gxzkmRolzzanqquMSPoihnnZBUaa7RioYfGTe1h62FHxbJoj6wQGYTg9NBHQs6prw/bb49imKfpngkRTki5kOSUDvQdeJ9sroj6/qsWZqBd+JLW/0gUD8JtjLpkdxscM9t4jrm5EGapYPesGd8jccKFsgv1xrol+XZlJsbdZmWaW4xYODc17muOx/lT046NJ/jKB3wMXu5yzMEU2Ivd/ZyYfBacV1KtO3w1YrT0fXhQZPy9B6uREbMXh7zHarXFoHx8hOrhyqqUpOsm4k5ucrLmcnVBzNAVsvF5izR90RANtSuQQWtFIKovAJdeuTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5465.namprd11.prod.outlook.com (2603:10b6:408:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 16:05:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:05:26 +0000
Date:   Fri, 15 Sep 2023 00:05:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
        <linux-mm@kvack.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        <stable@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
Message-ID: <202309142334.a345320b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5465:EE_
X-MS-Office365-Filtering-Correlation-Id: 660ecf60-aec0-4100-d62c-08dbb53c6857
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47Ny5vd7+Fi76C+1jjorEU64z3WqqA2z5zn5TlX2muh0tYqF1meTwA6qoFQK28xJxNEr3VKoVUvLUTZ++mWDZREqFzRw3Ugf8zSzWijVXA/ZNU4x4k9XPvchNuUaDVOspXYlnfxJp+nub0nBsAqZR0ZEW/BoGcEu3b5bLJHHvGLivfN95fGb2OgxcZ8/0EHSU6RcjM0IHdn01a8dgygfD0+jFc+KqmYkd97Neq94U4cuKSwvD2YUiQE/kTreYV9yC5YxkNUSmToosY05AA/elnj4d6G5cWZ7XORu0l0cl1P3XDgKsKOyEq9U/0Lt6SmWb/iq1OUeWkVuwjWXUNLFt88TTEpvRNbgrhyZroYdbjnORiRZ+0Uzrlub9TWFAYUN5MpfMM0w0rEhW3GHaGIDIgC+eMk2PU1jh989dAI2I5NnO3uPjsDGWNbqN17AlNZv2sM+5FqLz5oRcPc/7M3NQrQB5oKoOtU8gfLjru8BzIfN+Rc7R7aUJZWTtfrk5J7qERtY7qUsIDB8ppzI5vwRZ64IcBCZVsxA5w0Y6aoaIS/kr4aSEa8svNYc1otpNOkBVnoMiT5e8dsv3JkV/Ux04A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(66476007)(6512007)(2906002)(6486002)(6506007)(83380400001)(86362001)(41300700001)(26005)(107886003)(1076003)(2616005)(6916009)(54906003)(316002)(478600001)(7416002)(5660300002)(84970400001)(966005)(45080400002)(38100700002)(4326008)(8936002)(8676002)(6666004)(30864003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/SxY+jxh8d6/SJshKzVWdAOjMliA1TmMzaE3pklGmlXsbso9tPfHf/cJFF7?=
 =?us-ascii?Q?O47vsWz8yzJKYEPshv0ALbOWug29i85NIyI/uoF3FUuUEatajpU6YBmmfOVN?=
 =?us-ascii?Q?DuIXKZtH+9ZJiPKszxN7o148QWf0mAbXJNtpDTCg+XMVEqPkYyZyA8vbiWyH?=
 =?us-ascii?Q?GBEy8i3XtpDHav8cvA/pqxSgMRw7SYob2eTpXmWW/ujKn3ZeD00O3HczPvbr?=
 =?us-ascii?Q?22HHmAYm1OJRAZeK69RgiB4HtphHgTB/G4qvrva108iFGk3QbtQ22fl/+q7b?=
 =?us-ascii?Q?GUZYN9+YXCSeFiCtDYmKqGlHpM8a+QbD3J/yndjB13ki+3Lz5MkFDb98rhVN?=
 =?us-ascii?Q?p2Lv+V6Yeu/NJnpQ0haPmGkYICoLFSDxoiul8uCICU26SQEmMN45LoG14Te5?=
 =?us-ascii?Q?wjeNzZsNHemcPlxeRM141AkThxLhqAJs+oXj30cYwoelN6mu2jCXmE6I1cPu?=
 =?us-ascii?Q?YuRhycgVV/wFOZPPobAxUr+moVr5NxSH9FU6ncQXlDtggeSmEcJY2Yk+oPhO?=
 =?us-ascii?Q?+nbXeGdjSe6SPRqaoB/m3jmcKr+qgEPUbJHOJUi83iZqf05iB+co4Eehi5y4?=
 =?us-ascii?Q?CkcOdwcwdfUq+bdsgMqibBPQ+b/ehzXwDGz5/+XO1BJQ3FQaN84yLshymSVF?=
 =?us-ascii?Q?vk9jieztpGsRO5lLfT4DzQ7loscZXzSiMDbdp3xJpR9DdNNJ/7Ta9gc4yAgY?=
 =?us-ascii?Q?GkWw29yT4XfXxQ3qvmg02bV/aM5t6HRaHu9x0bYZji3h5ns5wTLc8QP2z2L9?=
 =?us-ascii?Q?3gatG3iJ5dtcS5XImbxxnkzjSOn+3J7q3UzSEfAWHvwvVH4jaW06dWx8zXJX?=
 =?us-ascii?Q?NqVKWI9XUKVB7Q0jGIzys86sbnSaf1381LeO4PvoX9N+PhSV5JTB7e8Lr8su?=
 =?us-ascii?Q?xpDi2x0uaI8mbbxQSG4DA+CSYySm5I9kbpHsHxnIJLyzt6GEYq8GFyEcdA4A?=
 =?us-ascii?Q?WqBNYztFfao8ADtqHzSjleTilgJzDXJqEddWbqKgpFEDtMdpv7OqoPMfc73j?=
 =?us-ascii?Q?FUOkwistbLtU5+yAR4xH2EJ7tv4RBp7aWFq/oeQlsxYrP+E74hrtG5eDT08a?=
 =?us-ascii?Q?GK3ZiPuQ5WFByQ3M2FNJqReE4qyRq8nK9DOIKjaksGUZjNbIHvjSHWEB0zdM?=
 =?us-ascii?Q?VRTovASLM3j2cPLnG6CVEF+WA1ZqMDQlPW5FsYzA7mFJrwpPvh/C8qIg1lZm?=
 =?us-ascii?Q?c9rTa6mTYEqLrsJOKofm2Fq4XCE9fyYsAM7Cqp9T1DYz8jjGzTo3idHjjODy?=
 =?us-ascii?Q?22BOa91bn2gfi4GjBMecyPpol0QuUjgq9hLDXQMX758CGcssoSrizMQUYpI8?=
 =?us-ascii?Q?sYyFryd2B8jXEDttNq7+B5mikxA1SQNI5zhKjIKNfDb/YgLb5heu/aE/F2av?=
 =?us-ascii?Q?G63hnbHJleiPz4ptEHheeBn2+THZpf3ohD+j1I5QQb8iSItiUxYWNs8HHUdl?=
 =?us-ascii?Q?3LTZMPFQDDDeJvaHLRQN/vCyWlPSS9SmhpHqT4RKUMLy43FGu6srM7O+Qhp/?=
 =?us-ascii?Q?gGLaXAgfy1gsmnX06bImbkPZaw6CgJK12vq3p0YpnSUiafqvRpEh/gs+oPTh?=
 =?us-ascii?Q?vqbRhiIQHiw7wFE4ziqAv4NeDtENC3rXXEGIQMV3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ecf60-aec0-4100-d62c-08dbb53c6857
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:05:25.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meE0ObWeHGC5SzZvfMqXmMcQYwxnD40kCK6Vd4aND1wfzUhHTlEDSs1czyvnHSpPeEODMCIRBjsyY+a8m67KNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5465
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c" on:

commit: afa19b70494c22ba27224f90c0805e88e5db41e1 ("[PATCH] init/main: Clear boot task idle flag")
url: https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/init-main-Clear-boot-task-idle-flag/20230913-085921
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 3669558bdf354cd352be955ef2764cde6a9bf5ec
patch link: https://lore.kernel.org/all/20230913005647.1534747-1-Liam.Howlett@oracle.com/
patch subject: [PATCH] init/main: Clear boot task idle flag

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


besides BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c,
we also observed other issues on this commit but clean on parent:


3669558bdf354cd3 afa19b70494c22ba27224f90c08
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6           17%           1:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_drivers/dma-buf/selftest.c
           :6           17%           1:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_drivers/net/ethernet/intel/e1000_hw.c
           :6          100%           6:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
           :6           83%           5:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
           :6           50%           3:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c
           :6           17%           1:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/rcu/tree.c
           :6          100%           6:6     dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/sched/completion.c
           :6          100%           6:6     dmesg.RIP:__do_softirq
           :6          100%           6:6     dmesg.RIP:__flush_smp_call_function_queue
           :6           33%           2:6     dmesg.RIP:__handle_irq_event_percpu
           :6          100%           6:6     dmesg.RIP:__hrtimer_run_queues
           :6          100%           6:6     dmesg.RIP:__note_gp_changes
           :6          100%           6:6     dmesg.RIP:__queue_work
           :6          100%           6:6     dmesg.RIP:__raise_softirq_irqoff
           :6          100%           6:6     dmesg.RIP:__run_timers
           :6          100%           6:6     dmesg.RIP:__smp_call_single_queue
           :6          100%           6:6     dmesg.RIP:__sysvec_apic_timer_interrupt
           :6          100%           6:6     dmesg.RIP:__sysvec_call_function_single
           :6           50%           3:6     dmesg.RIP:__update_load_avg_blocked_se
           :6          100%           6:6     dmesg.RIP:__update_load_avg_cfs_rq
           :6          100%           6:6     dmesg.RIP:__update_load_avg_se
           :6          100%           6:6     dmesg.RIP:__wake_nocb_gp
           :6           67%           4:6     dmesg.RIP:_raw_spin_unlock_irqrestore
           :6          100%           6:6     dmesg.RIP:arch_ftrace_ops_list_func
           :6          100%           6:6     dmesg.RIP:attach_entity_load_avg
           :6          100%           6:6     dmesg.RIP:call_timer_fn
           :6          100%           6:6     dmesg.RIP:default_idle
           :6          100%           6:6     dmesg.RIP:dequeue_task_fair
           :6          100%           6:6     dmesg.RIP:detach_entity_load_avg
           :6           33%           2:6     dmesg.RIP:detach_if_pending
           :6           67%           4:6     dmesg.RIP:dma_fence_signal_timestamp_locked
           :6           33%           2:6     dmesg.RIP:do_nocb_deferred_wakeup
           :6          100%           6:6     dmesg.RIP:do_nocb_deferred_wakeup_timer
           :6          100%           6:6     dmesg.RIP:enqueue_hrtimer
           :6          100%           6:6     dmesg.RIP:enqueue_task_fair
           :6          100%           6:6     dmesg.RIP:enqueue_timer
           :6           17%           1:6     dmesg.RIP:hrtimer_init
           :6           67%           4:6     dmesg.RIP:load_balance
           :6          100%           6:6     dmesg.RIP:lock_acquire
           :6          100%           6:6     dmesg.RIP:lock_acquired
           :6          100%           6:6     dmesg.RIP:lock_contended
           :6          100%           6:6     dmesg.RIP:lock_release
           :6           33%           2:6     dmesg.RIP:printk_sprint
           :6           17%           1:6     dmesg.RIP:rcu_barrier_trace
           :6          100%           6:6     dmesg.RIP:rcu_core
           :6          100%           6:6     dmesg.RIP:rcu_is_cpu_rrupt_from_idle
           :6           83%           5:6     dmesg.RIP:rcu_qs
           :6          100%           6:6     dmesg.RIP:rcu_report_qs_rnp
           :6          100%           6:6     dmesg.RIP:rcu_sched_clock_irq
           :6           50%           3:6     dmesg.RIP:resched_curr
           :6          100%           6:6     dmesg.RIP:set_task_cpu
           :6          100%           6:6     dmesg.RIP:trace_hardirqs_off
           :6          100%           6:6     dmesg.RIP:trace_hardirqs_off_finish
           :6          100%           6:6     dmesg.RIP:trace_hardirqs_on
           :6          100%           6:6     dmesg.RIP:trace_reschedule_entry
           :6          100%           6:6     dmesg.RIP:trace_reschedule_exit
           :6          100%           6:6     dmesg.RIP:try_to_wake_up
           :6          100%           6:6     dmesg.RIP:ttwu_do_activate
           :6          100%           6:6     dmesg.RIP:update_cpu_capacity
           :6          100%           6:6     dmesg.RIP:update_curr
           :6          100%           6:6     dmesg.RIP:update_dl_rq_load_avg
           :6          100%           6:6     dmesg.RIP:update_irq_load_avg
           :6          100%           6:6     dmesg.RIP:update_rt_rq_load_avg
           :6          100%           6:6     dmesg.RIP:update_sd_lb_stats
           :6           17%           1:6     dmesg.RIP:wake_up_nohz_cpu
           :6          100%           6:6     dmesg.WARNING:at_arch/x86/include/asm/trace/irq_vectors.h:#__sysvec_apic_timer_interrupt
           :6          100%           6:6     dmesg.WARNING:at_arch/x86/include/asm/trace/irq_vectors.h:#__sysvec_call_function_single
           :6          100%           6:6     dmesg.WARNING:at_arch/x86/include/asm/trace/irq_vectors.h:#trace_reschedule_entry
           :6          100%           6:6     dmesg.WARNING:at_arch/x86/include/asm/trace/irq_vectors.h:#trace_reschedule_exit
           :6          100%           6:6     dmesg.WARNING:at_include/linux/trace_recursion.h:#arch_ftrace_ops_list_func
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/csd.h:#__flush_smp_call_function_queue
           :6           67%           4:6     dmesg.WARNING:at_include/trace/events/dma_fence.h:#dma_fence_signal_timestamp_locked
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/ipi.h:#__smp_call_single_queue
           :6           50%           3:6     dmesg.WARNING:at_include/trace/events/ipi.h:#resched_curr
           :6           17%           1:6     dmesg.WARNING:at_include/trace/events/ipi.h:#wake_up_nohz_cpu
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/irq.h:#__do_softirq
           :6           33%           2:6     dmesg.WARNING:at_include/trace/events/irq.h:#__handle_irq_event_percpu
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/irq.h:#__raise_softirq_irqoff
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/lock.h:#lock_acquire
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/lock.h:#lock_acquired
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/lock.h:#lock_contended
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/lock.h:#lock_release
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/preemptirq.h:#trace_hardirqs_off
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/preemptirq.h:#trace_hardirqs_off_finish
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/preemptirq.h:#trace_hardirqs_on
           :6           33%           2:6     dmesg.WARNING:at_include/trace/events/printk.h:#printk_sprint
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#__note_gp_changes
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#__wake_nocb_gp
           :6           33%           2:6     dmesg.WARNING:at_include/trace/events/rcu.h:#do_nocb_deferred_wakeup
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#do_nocb_deferred_wakeup_timer
           :6           17%           1:6     dmesg.WARNING:at_include/trace/events/rcu.h:#rcu_barrier_trace
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#rcu_core
           :6           83%           5:6     dmesg.WARNING:at_include/trace/events/rcu.h:#rcu_qs
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#rcu_report_qs_rnp
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/rcu.h:#rcu_sched_clock_irq
           :6           50%           3:6     dmesg.WARNING:at_include/trace/events/sched.h:#__update_load_avg_blocked_se
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#__update_load_avg_cfs_rq
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#__update_load_avg_se
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#attach_entity_load_avg
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#dequeue_task_fair
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#detach_entity_load_avg
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#enqueue_task_fair
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#set_task_cpu
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#try_to_wake_up
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#ttwu_do_activate
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_cpu_capacity
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_curr
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_dl_rq_load_avg
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_irq_load_avg
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_rt_rq_load_avg
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/sched.h:#update_sd_lb_stats
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/timer.h:#__hrtimer_run_queues
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/timer.h:#__run_timers
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/timer.h:#call_timer_fn
           :6           33%           2:6     dmesg.WARNING:at_include/trace/events/timer.h:#detach_if_pending
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/timer.h:#enqueue_hrtimer
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/timer.h:#enqueue_timer
           :6           17%           1:6     dmesg.WARNING:at_include/trace/events/timer.h:#hrtimer_init
           :6          100%           6:6     dmesg.WARNING:at_include/trace/events/workqueue.h:#__queue_work
           :6          100%           6:6     dmesg.WARNING:at_kernel/rcu/tree.c:#rcu_is_cpu_rrupt_from_idle
           :6           17%           1:6     dmesg.WARNING:inconsistent_lock_state
           :6          100%           6:6     dmesg.WARNING:suspicious_RCU_usage
           :6           33%           2:6     dmesg.arch/x86/kernel/irq.c:#IRQ_failed_to_wake_up_RCU
           :6          100%           6:6     dmesg.include/linux/cgroup.h:#suspicious_rcu_dereference_check()usage
           :6          100%           6:6     dmesg.include/linux/rcupdate.h:#rcu_read_lock()used_illegally_while_idle
           :6          100%           6:6     dmesg.include/linux/rcupdate.h:#rcu_read_unlock()used_illegally_while_idle
           :6           17%           1:6     dmesg.inconsistent{IN-HARDIRQ-W}->{HARDIRQ-ON-W}usage
           :6          100%           6:6     dmesg.kernel/events/core.c:#suspicious_rcu_dereference_check()usage
           :6           83%           5:6     dmesg.kernel/exit.c:#suspicious_rcu_dereference_check()usage
           :6          100%           6:6     dmesg.kernel/rcu/tree.c:#RCU_dynticks_nmi_nesting_counter_underflow/zero
           :6           67%           4:6     dmesg.kernel/sched/core.c:#suspicious_rcu_dereference_check()usage
           :6          100%           6:6     dmesg.kernel/sched/fair.c:#suspicious_rcu_dereference_check()usage
           :6           83%           5:6     dmesg.kernel/workqueue.c:#RCU_or_wq_pool_mutex_should_be_held
           :6           83%           5:6     dmesg.kernel/workqueue.c:#suspicious_rcu_dereference_check()usage



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309142334.a345320b-oliver.sang@intel.com


[    2.318233][    T1] BUG: sleeping function called from invalid context at kernel/sched/completion.c:111
[    2.318647][    T1] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    2.319725][    T1] preempt_count: 0, expected: 0
[    2.320293][    T1] no locks held by swapper/0/1.
[    2.320882][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00034-gafa19b70494c #1
[    2.321957][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.321957][    T1] Call Trace:
[    2.321957][    T1]  <TASK>
[ 2.321957][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 2.321957][ T1] __might_resched (kernel/sched/core.c:10188) 
[ 2.321957][ T1] ? sched_core_find (kernel/sched/core.c:10142) 
[ 2.321957][ T1] __wait_for_common (kernel/sched/completion.c:115) 
[ 2.321957][ T1] ? usleep_range_state (kernel/time/timer.c:2129) 
[ 2.321957][ T1] ? reacquire_held_locks (kernel/locking/lockdep.c:5404) 
[ 2.321957][ T1] ? wait_for_completion_io_timeout (kernel/sched/completion.c:110) 
[ 2.321957][ T1] ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:121) 
[ 2.321957][ T1] ? rest_init (init/main.c:1431) 
[ 2.321957][ T1] kernel_init (init/main.c:1439) 
[ 2.321957][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 2.321957][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.321957][ T1] ? rest_init (init/main.c:1431) 
[ 2.321957][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    2.321957][    T1]  </TASK>
[    2.322276][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
[    2.327212][    T1] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    2.328461][    T1] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    2.330045][    T1] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    2.331385][    T1] Running RCU-tasks wait API self tests
[    2.333117][    T1] Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
[    2.334654][    T1] signal: max sigframe size: 1776
[    2.335915][    T1] rcu: Hierarchical SRCU implementation.
[    2.336653][    T1] rcu: 	Max phase no-delay instances is 1000.
[    2.342550][   T14] Callback from call_rcu_tasks_trace() invoked.
[    2.344299][    T1] smp: Bringing up secondary CPUs ...
[    2.347251][    T1] smpboot: x86: Booting SMP configuration:
[    2.347999][    T1] .... node  #0, CPUs:      #1
[    0.487313][    T0] masked ExtINT on CPU#1
[    2.348624][    T0] ------------[ cut here ]------------
[ 2.348624][ T0] WARNING: CPU: 0 PID: 0 at include/trace/events/preemptirq.h:36 trace_hardirqs_off_finish (include/trace/events/preemptirq.h:36 include/trace/events/preemptirq.h:36 kernel/trace/trace_preemptirq.c:78 kernel/trace/trace_preemptirq.c:73) 
[    2.348624][    T0] Modules linked in:
[    2.348624][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.6.0-rc1-00034-gafa19b70494c #1
[    2.348624][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.348624][ T0] RIP: 0010:trace_hardirqs_off_finish (include/trace/events/preemptirq.h:36 include/trace/events/preemptirq.h:36 kernel/trace/trace_preemptirq.c:78 kernel/trace/trace_preemptirq.c:73) 
[ 2.348624][ T0] Code: 03 80 3c 02 00 75 2a 48 8b 7b 08 31 d2 48 89 ee e8 99 f4 ff ff 65 ff 0d 0a 69 ce 7e e9 5d ff ff ff e8 38 18 e9 ff 84 c0 75 80 <0f> 0b e9 79 ff ff ff e8 c8 c0 3a 00 eb cf 66 0f 1f 44 00 00 65 8b
All code
========
   0:	03 80 3c 02 00 75    	add    0x7500023c(%rax),%eax
   6:	2a 48 8b             	sub    -0x75(%rax),%cl
   9:	7b 08                	jnp    0x13
   b:	31 d2                	xor    %edx,%edx
   d:	48 89 ee             	mov    %rbp,%rsi
  10:	e8 99 f4 ff ff       	call   0xfffffffffffff4ae
  15:	65 ff 0d 0a 69 ce 7e 	decl   %gs:0x7ece690a(%rip)        # 0x7ece6926
  1c:	e9 5d ff ff ff       	jmp    0xffffffffffffff7e
  21:	e8 38 18 e9 ff       	call   0xffffffffffe9185e
  26:	84 c0                	test   %al,%al
  28:	75 80                	jne    0xffffffffffffffaa
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 79 ff ff ff       	jmp    0xffffffffffffffaa
  31:	e8 c8 c0 3a 00       	call   0x3ac0fe
  36:	eb cf                	jmp    0x7
  38:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  3e:	65                   	gs
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 79 ff ff ff       	jmp    0xffffffffffffff80
   7:	e8 c8 c0 3a 00       	call   0x3ac0d4
   c:	eb cf                	jmp    0xffffffffffffffdd
   e:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  14:	65                   	gs
  15:	8b                   	.byte 0x8b
[    2.348624][    T0] RSP: 0000:ffffffff84a07d60 EFLAGS: 00010046
[    2.348624][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81513ac2
[    2.348624][    T0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff85a79540
[    2.348624][    T0] RBP: ffffffff8352c418 R08: 0000000000000000 R09: fffffbfff0b4f2a8
[    2.348624][    T0] R10: ffffffff85a79547 R11: 0000000000000000 R12: 0000000000000000
[    2.348624][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.348624][    T0] FS:  0000000000000000(0000) GS:ffff8883aea00000(0000) knlGS:0000000000000000
[    2.348624][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.348624][    T0] CR2: ffff88843ffff000 CR3: 0000000004a89000 CR4: 00000000000406f0
[    2.348624][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.348624][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.348624][    T0] Call Trace:
[    2.348624][    T0]  <TASK>
[ 2.348624][ T0] ? __warn (kernel/panic.c:673) 
[ 2.348624][ T0] ? trace_hardirqs_off_finish (include/trace/events/preemptirq.h:36 include/trace/events/preemptirq.h:36 kernel/trace/trace_preemptirq.c:78 kernel/trace/trace_preemptirq.c:73) 
[ 2.348624][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 2.348624][ T0] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 2.348624][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 2.348624][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 2.348624][ T0] ? irqentry_enter (kernel/entry/common.c:315) 
[ 2.348624][ T0] ? trace_hardirqs_off_finish (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/cpumask.h:504 include/linux/cpumask.h:1082 include/trace/events/preemptirq.h:36 kernel/trace/trace_preemptirq.c:78 kernel/trace/trace_preemptirq.c:73) 
[ 2.348624][ T0] ? trace_hardirqs_off_finish (include/trace/events/preemptirq.h:36 include/trace/events/preemptirq.h:36 kernel/trace/trace_preemptirq.c:78 kernel/trace/trace_preemptirq.c:73) 
[ 2.348624][ T0] irqentry_enter (kernel/entry/common.c:315) 
[ 2.348624][ T0] sysvec_call_function_single (arch/x86/kernel/smp.c:287) 
[ 2.348624][ T0] asm_sysvec_call_function_single (arch/x86/include/asm/idtentry.h:652) 
[ 2.348624][ T0] RIP: 0010:default_idle (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/kernel/process.c:750) 
[ 2.348624][ T0] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 37 79 30 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 04 25 40 a4 1f 00 f0 80 48 02 20 48 8b 10
All code
========
   0:	07                   	(bad)
   1:	76 e7                	jbe    0xffffffffffffffea
   3:	48 89 07             	mov    %rax,(%rdi)
   6:	49 c7 c0 08 00 00 00 	mov    $0x8,%r8
   d:	4d 29 c8             	sub    %r9,%r8
  10:	4c 01 c7             	add    %r8,%rdi
  13:	4c 29 c2             	sub    %r8,%rdx
  16:	e9 72 ff ff ff       	jmp    0xffffffffffffff8d
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	cc                   	int3
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d 37 79 30 00 	verw   0x307937(%rip)        # 0x30795f
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	65 48 8b 04 25 40 a4 	mov    %gs:0x1fa440,%rax
  36:	1f 00 
  38:	f0 80 48 02 20       	lock orb $0x20,0x2(%rax)
  3d:	48 8b 10             	mov    (%rax),%rdx

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	c3                   	ret
   2:	0f 1f 00             	nopl   (%rax)
   5:	65 48 8b 04 25 40 a4 	mov    %gs:0x1fa440,%rax
   c:	1f 00 
   e:	f0 80 48 02 20       	lock orb $0x20,0x2(%rax)
  13:	48 8b 10             	mov    (%rax),%rdx
[    2.348624][    T0] RSP: 0000:ffffffff84a07e40 EFLAGS: 00000206
[    2.348624][    T0] RAX: 0000000000003056 RBX: 0000000000000000 RCX: ffffffff8352c7ba
[    2.348624][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff812e3bd3
[    2.348624][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1075d7ed9d
[    2.348624][    T0] R10: ffff8883aebf6ceb R11: 0000000000000000 R12: 1ffffffff0940fca
[    2.348624][    T0] R13: ffffffff84a1e940 R14: dffffc0000000000 R15: 0000000000013f10
[ 2.348624][ T0] ? ct_kernel_exit+0xca/0x100 
[ 2.348624][ T0] ? cpuidle_idle_call (kernel/sched/idle.c:171) 
[ 2.348624][ T0] default_idle_call (include/linux/cpuidle.h:143 kernel/sched/idle.c:98) 
[ 2.348624][ T0] cpuidle_idle_call (kernel/sched/idle.c:171) 
[ 2.348624][ T0] ? arch_cpu_idle_exit+0x30/0x30 
[ 2.348624][ T0] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 2.348624][ T0] do_idle (kernel/sched/idle.c:282) 
[ 2.348624][ T0] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1)) 
[ 2.348624][ T0] rest_init (include/linux/rcupdate.h:750 init/main.c:697) 
[ 2.348624][ T0] arch_call_rest_init+0xf/0x20 
[ 2.348624][ T0] start_kernel (init/main.c:1021 (discriminator 1)) 
[ 2.348624][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:544) 
[ 2.348624][ T0] x86_64_start_kernel (??:?) 
[ 2.348624][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433) 
[    2.348624][    T0]  </TASK>
[    2.348624][    T0] irq event stamp: 12375
[ 2.348624][ T0] hardirqs last enabled at (12374): cpuidle_idle_call (kernel/sched/idle.c:171) 
[ 2.348624][ T0] hardirqs last disabled at (12375): sysvec_call_function_single (arch/x86/kernel/smp.c:287) 
[ 2.348624][ T0] softirqs last enabled at (8563): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 2.348624][ T0] softirqs last disabled at (8558): __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632) 
[    2.348624][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230914/202309142334.a345320b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

