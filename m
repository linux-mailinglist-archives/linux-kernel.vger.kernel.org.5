Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4F7AD143
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjIYHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:20:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C77100;
        Mon, 25 Sep 2023 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695626393; x=1727162393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+ZdZWZOtv0T0y/UtTNQkU2QttflOTo8vbik5PDcQDOc=;
  b=TDA5lCEutg4IXn3izm3mmCWKPIuneWxOqXAGq6pFHk5LUU8ZVZr2iKkc
   SczqDGzQqhYCQUy0czOU37BzBTcYPdcFZIi18ZxX4z0PAR403iJ4o8NQ5
   XA2a5YzVdVTwOcW+veAhIVTS0ALIvJf//hKyH5caCOAXZVoEV2rPzbrCO
   Opt8pzmd8htqQnROZ/IS3IYBExteJB21z8EWjPO/Qti+JinoYU/V1yZHn
   pgd3KmUIpHGQVFRi/QtLwiwG6AicuLb4YclLQlJQQew0dwI6kEnaTIDvU
   xWMXBXE5aqaHKtgkI9dbqlVT8MAJZ4BPiu0Hy7WKUEGn7twj4zd4Y7LrG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371508972"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="371508972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="921880328"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="921880328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 00:19:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 00:19:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 00:19:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 00:19:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 00:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYh9t5t4Ua9UGHlVpXirPbMfZTRywiu88s4eqDJykPR0NW13uhkrcZmLBH3aL/18zbpWKF7Pz0rke8Q/tAN7JojsCJYMT7yc4uK1Rh8BfkrATGIfphGfcMsgm0ZC/R0ZQn91We1VVg82ClSomN2z4FwXrBdVMXrLcbltkiKJT70Zizj2+iTtC+qUlflwdMxJ+rv5g+daBrxDxykmgVruaBQefb9679XfrfAiZQxUmHfrZF5nKFTgEuh2w3rmeErEOGxWLMgymgwV9xF3uU/KmQLXgrzAvdqmPyG66THyJsIOFJuxCxdmpTG2c9PEVQiAzdj0c/t9V3EH/3cUriBe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHC3moK+2TeCISbXs63+USEJs8v/DcoOyteXMS3xqio=;
 b=Xa0yptQFnJ0wrIhZ4xBZoEGJwlvGCH7cQA9NGyfMXCIpTYjA+WM/ItBGiOtRgVpkiCVuLmC3HunZ01ZGZuMg1YJ8zjP982Tuvs8WhLNXKv6A4FwPHPCGmXcYf688y+uYNxTnIYfjjV2auDh3+RpOwpaqQOhRBW6ob6wccdayrPBCTqjqLGAOHMV84hko0TCq9bCHu1o+wI6xkbWjNOrAVxUBMg3oWpnow1RaFfkCJAXd+gomsahQBUZN9YWOUbOMzxzag4jODRnC3Do5DA59rVzGryy2kC1MUKbQ0xqJDkcq6ws/pdOYIaBMZHE5SGtPmEAc9YBfKcG/DENi/vQvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 07:19:42 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 07:19:42 +0000
Date:   Mon, 25 Sep 2023 15:18:46 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [workqueue]  8a1dd1e547:
 BUG:KCSAN:data-race_in_print_report/wq_worker_tick
Message-ID: <202309251423.8ef230c0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL1PR11MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d124fca-1cfa-429e-c20d-08dbbd97c924
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwVW/IofLvsBD+TkQrwcMeM+u/XEUAE37HBwAXQ1wwqykROCF4uI0INUG4dRH/rOoVom+1tAmyvQ9Ec7IY1XWRRCp+RD5n/ijcUmJVhuwICPAVYuZ7mWBFQPPYti1QGro0hQWDN9Y5IwaDII+AO5fd2o9CCttB+xFDnqOymmu/Bu4boBFAT2J5DPlt4xQ+yf1LRXq2v/poickbSZO9394sUR3akALuvWaMscgmPQXtB2HXtDIq9sx802Thz67Vd0a06TKXfUNnO1iqnJoTt2ueI5OYAzzBz488kcB9MXlXJ/UKFKwjXeAzZqK+G1YMnPkyTa917yI6bvoKTn+fg34b/97DFQ71rgDUlfi0F03iNnCDyHp4K5QHaZnvpMCvTGXfbrDFJshpSXUKmUWQNpAGJhglRyKuAlKcAF80mYCTZi1lNwbENwm0+lUcqfkGC4iX9U3ZdxKbYvWgetSv/Lx4TSBbfbGvEys0OjlUsv3d9KcKKOa/BwmCPK5BhWxNFxBHjnnYoTioTREcRLfyMInUFQZFFi9MkTm/JRIyO6CWO5i0BAjy9BzKvU5EGNSsvXqwiIJ2+DeHrl0GUAvagB0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(38100700002)(6512007)(6506007)(966005)(6486002)(1076003)(478600001)(2616005)(83380400001)(66946007)(86362001)(66476007)(82960400001)(26005)(66556008)(6916009)(107886003)(8676002)(5660300002)(4326008)(41300700001)(8936002)(316002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3Pa8D86CM1/nFjYd8RgTYZ4n3AWmhYQq5MVsJUuFmm331pOD/e6FfAnF4O4?=
 =?us-ascii?Q?dzcXA35Ot0wCO3QcT3KVzZCd/dbGAAxT0pp01RvH+TLcPbD+OLNWd8WzApp2?=
 =?us-ascii?Q?imOMxQ6WtTiTkgbitIqQl+e6KhA8QjUlhTuUQZJRgPevlV3fVUgbOrUoC7P4?=
 =?us-ascii?Q?T4gKeTuPk+RkQvSOSP9VStbMIEN0+CTw3wanMRbF69Ek6Y6iotBygy9je+N2?=
 =?us-ascii?Q?1mbPCxoT6AXqMGa9IdicnjEQz4caWRgjf0BXaFRmESYhHLMHmWhsCwc8Dx6S?=
 =?us-ascii?Q?wkuk0zSo0He06AX++wxJzBjSYtuz1nLN9mRWP/qZB0qe3COVs1xZdNCcpcFl?=
 =?us-ascii?Q?xnI5SxGouzgeGbFWuQyAUmkqdyX3TRxvvSEaVNnFeEJkx9Xsbp0o/X7mCx4E?=
 =?us-ascii?Q?6zxDB0qSL07dBgwbotU3TLHquvQJDPPcc3qhw+m+8EyGgNwgp0O7cgFiuO7u?=
 =?us-ascii?Q?HkccMyUwPpvRFi6NDUw6whXIqANe48hIqWdJEEQ00Lm6MfiGIT16R/aFHXF2?=
 =?us-ascii?Q?UnsamRwV3KbkgiRWl4PRwKua8r0zQuO6fMrR/bjDC/NzJR4XpFm+XSjIlhdi?=
 =?us-ascii?Q?LTox5jj90Lls2079TBS8nIoYYYYykBAxcEIbPUSata/buwtBZgJk/1lOBzJg?=
 =?us-ascii?Q?e4p35skDMP9TXncvrhdrhs2Wg0aJleLDvkqh3jGfyboQKF3dHOwTJSm6bR4N?=
 =?us-ascii?Q?jSykI2JtM9qUgknEakU3WYm4YupaAEhqPHja/oOgOIGRZjXqWkB+4ig0g0F1?=
 =?us-ascii?Q?IEGGfKiqHhAhC8ydQOLVhslbjAtpcgdSdyvCgcp2JiEhmBO7l/Em/wkhK9pU?=
 =?us-ascii?Q?PchTJ78lTD9JUG0pmwmbPSeUaA6liImhkOgolPBd0CX2fmdU2Kuza5mk6VGC?=
 =?us-ascii?Q?Yc4WpKgtv6ZDTE35HUEuZpFUbKQeHfh7POvTk595gMJlrLpGbIhXZnhrk3A7?=
 =?us-ascii?Q?QP7Tfp0+NEf/VQuGlOphk66P4s85tFW3+NDc6fVEL9FlnzZa+O9itU4+NOgF?=
 =?us-ascii?Q?yTsHOEZwfICOP6+qSe6Qsoy9W48mRrB5anGXcifhw17P+BCEujgxNHCRlIer?=
 =?us-ascii?Q?JPIicN3bJMlgQf1BobXm8wqk9NWcO+3VSa3aX4hUXoKgwe13ec+bG0Pay9gC?=
 =?us-ascii?Q?dNpQNxGNir9/LxQJrhPgEg79tkz3FcNPg2aqTfUnJFPw+E11RRza5nkFuTrJ?=
 =?us-ascii?Q?423/wl+0KcTZcn6rvPrP+WJUi+JhXrGimA53aJQxgDxH6xvHwwVcZzv3U4sF?=
 =?us-ascii?Q?LEhqm/vODSy8nQQUEcit2y+9GmH5WNO6metIdA3TRsNoQ/g/K/BqT2SN5KHO?=
 =?us-ascii?Q?+57E13lzkol56H9eWVFTVgn3Fh/+JQirH6pb3eKOE6E0TcsdrDaxvMV35bzv?=
 =?us-ascii?Q?mURQQiOerrki2XyURbDmzY83YEfaPWs8Brd0sbcADBedLJKWxg6JExJQz/Ed?=
 =?us-ascii?Q?47BQtw8mr3QF1vy3aAVGDp7QxL3EOOv+b9n4c4Dy2KuHC0u5zZEATUdJJNCN?=
 =?us-ascii?Q?hA8IJR9cuGVZxiGkR1SsRRNwkYkJtvuiyBwCpuSSjjKWOYwXDy2JeVLibL4J?=
 =?us-ascii?Q?tGTgQ/G4Aeb2kYRv99XuKTQd/GRKSC+nZ9JQTG3WlH6gILEC4+FnDVK8HfDB?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d124fca-1cfa-429e-c20d-08dbbd97c924
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 07:19:41.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTZhsnqA74xnIO7sr8xjwY3WaMMVp7e/+LZh0ugmRbAR/tVEkKGVUa2/2z7k7MLbFx6O+xF5jpB6lpyOHJb/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_print_report/wq_worker_tick" on:

commit: 8a1dd1e547c1a037692e7a6da6a76108108c72b1 ("workqueue: Track and monitor per-workqueue CPU time usage")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 2cf0f715623872823a72e451243bbf555d10d032]
[test failed on linux-next/master 29e400e3ea486bf942b214769fc9778098114113]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we found various KCSAN issues happen on both parent/fbc, but below (1)
only happens on this commit and clean on parent after almost 1000 runs.
we don't have enough knowledge how connect the code change to the issue,
just report what we observed in our tests FYI.

6363845005202148 8a1dd1e547c1a037692e7a6da6a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
        956:986         -0%         955:981   dmesg.BUG:KCSAN:data-race_in__mutex_add_waiter/print_report
          4:986         -0%           1:981   dmesg.BUG:KCSAN:data-race_in__mutex_remove_waiter/print_report
          1:986         -0%            :981   dmesg.BUG:KCSAN:data-race_in_do_timer/print_report
          1:986          0%           2:981   dmesg.BUG:KCSAN:data-race_in_enqueue_timer/print_report
          4:986         -0%           1:981   dmesg.BUG:KCSAN:data-race_in_print_report/process_one_work
          5:986         -0%           4:981   dmesg.BUG:KCSAN:data-race_in_print_report/threadfunc
          4:986          0%           4:981   dmesg.BUG:KCSAN:data-race_in_print_report/tick_nohz_handler
        175:986          2%         199:981   dmesg.BUG:KCSAN:data-race_in_print_report/tick_nohz_stop_tick
           :986          2%          24:981   dmesg.BUG:KCSAN:data-race_in_print_report/wq_worker_tick     <----- (1)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309251423.8ef230c0-oliver.sang@intel.com


[  121.059354][    C0] ==================================================================
[  121.060132][    C0] BUG: KCSAN: data-race in print_report / wq_worker_tick
[  121.060132][    C0]
[  121.060132][    C0] write to 0xffff88810336eaa8 of 8 bytes by interrupt on cpu 1:
[ 121.060132][ C0] wq_worker_tick (kernel/workqueue.c:1140) 
[ 121.060132][ C0] scheduler_tick (kernel/sched/core.c:5639) 
[ 121.060132][ C0] update_process_times (kernel/time/timer.c:2078) 
[ 121.060132][ C0] tick_nohz_handler (kernel/time/tick-sched.c:1369) 
[ 121.060132][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1113) 
[ 121.060132][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1106 (discriminator 14)) 
[ 121.060132][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 121.060132][ C0] kcsan_setup_watchpoint (kernel/kcsan/core.c:704 (discriminator 7)) 
[ 121.060132][ C0] do_raw_spin_unlock (kernel/locking/spinlock_debug.c:99 kernel/locking/spinlock_debug.c:140) 
[ 121.060132][ C0] _raw_spin_unlock (arch/x86/include/asm/preempt.h:85 include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186) 
[ 121.060132][ C0] __ww_mutex_lock+0x7fb/0xcfd 
[ 121.060132][ C0] ww_mutex_lock (kernel/locking/mutex.c:873) 
[ 121.060132][ C0] stress_one_work (kernel/locking/test-ww_mutex.c:545) 
[ 121.060132][ C0] process_one_work (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/workqueue.h:108 kernel/workqueue.c:2589) 
[ 121.060132][ C0] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2736) 
[ 121.060132][ C0] kthread (kernel/kthread.c:381) 
[ 121.060132][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  121.060132][    C0]
[  121.060132][    C0] read to 0xffff88810336eaa8 of 8 bytes by interrupt on cpu 0:
[ 121.060132][ C0] print_report (kernel/kcsan/report.c:396) 
[ 121.060132][ C0] kcsan_report_known_origin (kernel/kcsan/report.c:504 kernel/kcsan/report.c:694) 
[ 121.060132][ C0] kcsan_setup_watchpoint (kernel/kcsan/core.c:678) 
[ 121.060132][ C0] wq_worker_tick (kernel/workqueue.c:1140) 
[ 121.060132][ C0] scheduler_tick (kernel/sched/core.c:5639) 
[ 121.060132][ C0] update_process_times (kernel/time/timer.c:2078) 
[ 121.060132][ C0] tick_nohz_handler (kernel/time/tick-sched.c:1369) 
[ 121.060132][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1113) 
[ 121.060132][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1106 (discriminator 14)) 
[ 121.060132][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 121.060132][ C0] queued_spin_lock_slowpath (include/linux/instrumented.h:69 include/linux/atomic/atomic-instrumented.h:27 arch/x86/include/asm/qspinlock.h:100 kernel/locking/qspinlock.c:327) 
[ 121.060132][ C0] do_raw_spin_lock (kernel/locking/spinlock_debug.c:93 kernel/locking/spinlock_debug.c:117) 
[ 121.060132][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 121.060132][ C0] __ww_mutex_lock+0x941/0xcfd 
[ 121.060132][ C0] ww_mutex_lock (kernel/locking/mutex.c:873) 
[ 121.060132][ C0] stress_reorder_work (kernel/locking/test-ww_mutex.c:505) 
[ 121.060132][ C0] process_one_work (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/workqueue.h:108 kernel/workqueue.c:2589) 
[ 121.060132][ C0] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2736) 
[ 121.060132][ C0] kthread (kernel/kthread.c:381) 
[ 121.060132][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  121.060132][    C0]
[  121.060132][    C0] value changed: 0x00000000001364d8 -> 0x00000000001368c0
[  121.060132][    C0]
[  121.060132][    C0] Reported by Kernel Concurrency Sanitizer on:
[  121.060132][    C0] CPU: 0 PID: 42 Comm: kworker/u4:3 Tainted: G                T  6.4.0-rc1-00009-g8a1dd1e547c1 #1
[  121.060132][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  121.060132][    C0] Workqueue: test-ww_mutex stress_reorder_work
[  121.060132][    C0] ==================================================================
[  121.932570][    T1] All ww mutex selftests passed
[  121.942977][    T1] Initialise system trusted keyrings
[  121.950392][    T1] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[  121.975697][    T1] NET: Registered PF_ALG protocol family
[  121.977547][    T1] Key type asymmetric registered
[  121.979060][    T1] Asymmetric key parser 'x509' registered
[  121.980897][    T1] Asymmetric key parser 'pkcs8' registered
[  121.982622][    T1]
[  121.982622][    T1] Start testing find_bit() with random-filled bitmap
[  122.008302][    T1] find_next_bit:                 8628942 ns, 163936 iterations
[  122.020467][    T1] find_next_zero_bit:            9789528 ns, 163745 iterations
[  122.032835][    T1] find_last_bit:                10001837 ns, 163935 iterations
[  122.248386][    T1] find_nth_bit:                213810108 ns,  16175 iterations
[  122.437809][    T1] find_first_bit:              187071076 ns,  16176 iterations



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230925/202309251423.8ef230c0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

