Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE317ACA15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjIXOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIXOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:43:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF37FD;
        Sun, 24 Sep 2023 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695566602; x=1727102602;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tgtJIneFR6bmG5NjGtJ9anTdH3rjezAEHvziEyF2zoU=;
  b=Ah/LDIAMU/QOpHBng2kCgly39tqE3rqkihcG8ZI/nDNTR+sitsuBtpxf
   B/mwciG2zUAm92BRy3ERB44klGdQ3aJ+a5bIKDjHdcwYjGKNDpL1Yujz4
   fnnrAd+CgSkx0o7U2Ol411PJHiG6twZCtE3NGphGMiBcOPd8Nli2UoP5/
   ofPlN3dP+2oqQOV4og9JqOqhK1P9lK3k+QEpvAzmxAgK990g2NmTtEk4A
   SIrqKB3XkxA6/MpJJOWa5eJBCtpk/sjYaq1LXwT81ceL0EPU9XsLbxzB2
   xAZP8LNZBiwmMa+243Nmbfa7sueEK0Eiq6R9Kfycb8f2dKVahmIaQenFs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360489922"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="360489922"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 07:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1078944373"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="1078944373"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 07:43:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 07:43:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 07:43:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 07:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ92Gg3ZiX+PnzVpRXGs+0po9K15irwWMVigbIaagqCOT2mChB8GDRekoWs7+oJIRqlR/sP9pvewNl9Kg56K2iuve3U7MDes+ZJDJWk8qkJmf6puG08bGKjGrH8ZGkTshBQwQQFDNhMHt/jXBWg3X7aQ/PUjYcFzSEQrkqOvVjWwdrM3WTMn9wb/lv3ZK+MdoBh4Kv4KnIrj6OgdQcYessAgad+sE3gcvOaVW9kH4IwOGvHH0ZSKQ8bnRaHcyDoG+8thFFEskx2yDSN7LkF2i1ojCivtYskAJIBLL8d5hh2lT1qo5Jc6hnQ3ZApHGURiJGZPrRJm9IobMYP3DtBtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFttmcvZJ9TjoOZmnEfbtg5BbZVmds1XrSWJAp164+U=;
 b=mqpOjOYQsyBEF5C7y0Kk5iABKARkWpXKVWiCTAKpKs1wFF3W1lggkOlRqtvXPsBKMZlnW9eZs/Q28rLX6ammwQnAsZyfMtsvEeAt8W7eZakawVDtaNXAn/nuQdFEGcfkqL6S1I/wlqd39IJKOr91+xnZtJ9V2+GjdbQfMs7nmdgYGFglIHxbvXymb7wZELzquenHgRKtY4+jOJkV6N3c6gS6A/Jp9J7F8GukMwUsxxVEM0/yliLYRCE8RAWqNHpbmywhYjpbcOfZoPVAltNFcmA6NNt3XYeGLnhJCyVl2WTLDfB8CsiNOQELk7eURM00IQFEgnl+jmQ5naFcMm6nkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sun, 24 Sep
 2023 14:43:18 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 14:43:18 +0000
Date:   Sun, 24 Sep 2023 22:43:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH V2] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <202309242253.a3803da4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b9a5f306e488bc77bf8521faeade420a0adf3e4.1695224204.git.bristot@kernel.org>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff86dd9-ddc5-4c0e-5d54-08dbbd0c9796
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeZsgeQeg5ZzR/if1/DQ+QN6+GV9e5DyIHccj8VbNea3TgVttzM3Y/B3zUnjHUPM08gx6U02OctmyxyKaLZX6k1v7CEMezjHty/Eq2hHlJa/vhP/Xy72M/ZkcYC9nF4/VBIxE+XtMefk60pvWgIvnmXqF5GATrELSwjksHnTRiOq78IetKu270g7Y1u+h2oMzIIzNmI6jX6TGahB9hgjiU012n2Rf+6dSFJGVfXu5YvOX3/1WUY1em5FXXieGPYiKqtbEiGk7qoGsUYuuzshhmVjQfnDkKCGFe/sQcVC8856Oi2oCOnk85+oyI6rn1TMf75/FkLs7R4LLuA6iQqFGg8nqNL3Eo6BFIJlDPnYiq81pxqa465csYvhZG9ZE6P4xIXcnsRikv2W0igHtMdw8T/wWUua4DDv6OXERiPaDXnLtb/iOTxu+3rX/lNaPA9dMfvUYFuzOPs69xg0YSW87G4EtqVd4BDYQTJbVEntDlqYY1AeVbDHBrduxrAqIMR1A6vlXxhe/p420RqmDTnuUhPW4lJxLNMwhnCKateRbeB7kQTrajWbXZ/jLyHxSFvuf0U9ccNKlbXUNpnJA0G/ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6506007)(2616005)(966005)(6486002)(478600001)(8936002)(83380400001)(6666004)(26005)(1076003)(2906002)(66946007)(107886003)(66556008)(66476007)(316002)(6916009)(54906003)(4326008)(8676002)(5660300002)(41300700001)(36756003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R63rHO6MyBc9ZTloAbyyorhkR0w/IZ87wS2GHctRfBhW59gTwZZ0qzaEZrq8?=
 =?us-ascii?Q?W6D4jCBWXT6nyP7diZdL2qLgaDA8rJhqc6Ssz2AZgsKhINbLvrRzp0P7lvEh?=
 =?us-ascii?Q?d6MfEncgDyQWU2rRzXXu55ZEM8pN8MOoAoDt6oODvjs5e2Sr68Cgdcz1t79n?=
 =?us-ascii?Q?uvmVANniynVhe4pi1mc5IVhdxI7rIC0cxeZuiVI/cteoz55ylTaFPL+D3eLy?=
 =?us-ascii?Q?fhB2KgocrBrxGGWzrXYIQJ6xDs7hOsClu5/67/hJ7wJ8692KUx6yUfNlaClm?=
 =?us-ascii?Q?62PS78/eAX1qWVdbI1VhcfBMcc0lBOIPWaF7JQEj9l2Z0axvtsfXvmYWLAbd?=
 =?us-ascii?Q?K9WmudTG5PDKRpxUv1O2u9qNLIDHU8VNjaVr2awdzb1Hh44DP5gILz7z/Q9j?=
 =?us-ascii?Q?q/hQur+PQ2AipP9ECeGSKFccN7elysZ7CviY2EIPAZwIPjENNMIB7XW9x7Iq?=
 =?us-ascii?Q?AyO45aSCm4cVZs575RbBmQHMYUk5AcCnvzaXo64wk7UHHahX5/CupUcqB6FX?=
 =?us-ascii?Q?iyO6xTwGqZYB6MhoB+Ckz/MJ0IabCBKC7LJ92n1L5pcA0uI651zPA+tS3jq4?=
 =?us-ascii?Q?xIwRSiO5uXj/1oR2bwoHNk635YejWuvJpMvTMvFrMO/pnc0BN14ZHBIwONwO?=
 =?us-ascii?Q?65mbfMmZzytiQKx/8CPe8T6rGoqgK3iH/wmzwM6QBhtckGOsoQRAVFIE7KR9?=
 =?us-ascii?Q?RgjlrGJmzFhjrFoAGtDc2lyCrJKLjIL56avBnixr+S9rLFznVVBa327JO0ju?=
 =?us-ascii?Q?WlZq7m/Lwy+eD5J2lRtJQLHxLkleMYkIzkv2tITT9WoF63YBNxRL2dDGXjAv?=
 =?us-ascii?Q?0ScT3p2wQTajLITfGzN1t+0HNpc3EUdr91D82raOv2+JQbwLNsNpQV2ihOoO?=
 =?us-ascii?Q?0wxUXoqoh15AqjsZq+WgjcgAkpuDRSCs7J5r91tFvQKH0yAWVnKfr/Peaklx?=
 =?us-ascii?Q?cMMuGn7oZUoUVXMc4qgL1oEJuGZJK8kA/Fy7AuQ2nzjjCkfNAUIKwDaY33ZT?=
 =?us-ascii?Q?G589OYnTRaI/RKb8LBAzaHi9X420r0UrphAYQRNjtCGWLagbOIhg1u4Msplc?=
 =?us-ascii?Q?lR6f9BryG4B/HOe/oFEnUzhYmq9A4aAmcRIq6EZXjBNNyZGJ5W5iOGJ+/y3h?=
 =?us-ascii?Q?RKLohnGY+y2ExaA21XzbNNUFzLW9OjnTdb/1Qs+kv9bwOMneGOnb7cBuZOCE?=
 =?us-ascii?Q?2ZhjQMpcSNGmmpnviWoARRx3JTrK27SAfmEgvwsmohRro8s0EO5wDdSHZ8b9?=
 =?us-ascii?Q?21aEtDa+F+N3iXBTFgAPCve0crPhQkuI6rhtof7wHqvDqQ6Ez96ksPWfIBQ6?=
 =?us-ascii?Q?P2k0+4D3Kjzm6lZNat1qkG8lwKrg5YOAUdEHHgtpvE8PZ9tRz/JkZ4FsPOFP?=
 =?us-ascii?Q?Nl8Xx0PLzC7/XYcs5luLnB7qfxkZfhP/aeJC6V1tnraTMNZQHcTabuAqgUF/?=
 =?us-ascii?Q?xKm6+BH6dUj4zUs44PNuBqVPC74/Blw6i/Nl+tE+2KhzQpoxdEXsybptWbY9?=
 =?us-ascii?Q?4eIpg/ViiIfb1bqaEcHt4OomzjJS3a25er9S693vYUtxiBIjJctN5GuPVvMr?=
 =?us-ascii?Q?rC5p1NYD3j63i4aa0PJ+uxCtZgrBG1iy/9LgBIJS/wyslFhd5n8dGbb9piR9?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff86dd9-ddc5-4c0e-5d54-08dbbd0c9796
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 14:43:18.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1SgDTuuWWoUrCGXCTKmuMYslycdV0t/awOooZlKssGEj31fFGSfmiPqOUFF6k0WHkZaOf+cxKQzBtIYzlzufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
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

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: d2618f89d9ede5e14fd2eb2d140fff1d31f4948b ("[PATCH V2] tracing/timerlat: Hotplug support for the user-space interface")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/tracing-timerlat-Hotplug-support-for-the-user-space-interface/20230920-234738
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 2cf0f715623872823a72e451243bbf555d10d032
patch link: https://lore.kernel.org/all/6b9a5f306e488bc77bf8521faeade420a0adf3e4.1695224204.git.bristot@kernel.org/
patch subject: [PATCH V2] tracing/timerlat: Hotplug support for the user-space interface

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309242253.a3803da4-oliver.sang@intel.com


[  108.795325][    T1] WARNING: possible recursive locking detected
[  108.796115][    T1] 6.6.0-rc2-00019-gd2618f89d9ed #1 Not tainted
[  108.796898][    T1] --------------------------------------------
[  108.797664][    T1] swapper/0/1 is trying to acquire lock:
[ 108.798384][ T1] ffffffff85550630 (cpu_hotplug_lock){++++}-{0:0}, at: __cpuhp_setup_state (kernel/cpu.c:2553) 
[  108.799656][    T1]
[  108.799656][    T1] but task is already holding lock:
[ 108.800596][ T1] ffffffff85550630 (cpu_hotplug_lock){++++}-{0:0}, at: init_osnoise_tracer (kernel/trace/trace_osnoise.c:3186) 
[  108.801843][    T1]
[  108.801843][    T1] other info that might help us debug this:
[  108.802890][    T1]  Possible unsafe locking scenario:
[  108.802890][    T1]
[  108.803843][    T1]        CPU0
[  108.804266][    T1]        ----
[  108.804685][    T1]   lock(cpu_hotplug_lock);
[  108.805267][    T1]   lock(cpu_hotplug_lock);
[  108.805845][    T1]
[  108.805845][    T1]  *** DEADLOCK ***
[  108.805845][    T1]
[  108.806885][    T1]  May be due to missing lock nesting notation
[  108.806885][    T1]
[  108.807952][    T1] 1 lock held by swapper/0/1:
[ 108.808547][ T1] #0: ffffffff85550630 (cpu_hotplug_lock){++++}-{0:0}, at: init_osnoise_tracer (kernel/trace/trace_osnoise.c:3186) 
[  108.809838][    T1]
[  108.809838][    T1] stack backtrace:
[  108.819007][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00019-gd2618f89d9ed #1
[  108.821026][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  108.823537][    T1] Call Trace:
[  108.824310][    T1]  <TASK>
[ 108.824999][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 108.826053][ T1] validate_chain (kernel/locking/lockdep.c:3857) 
[ 108.827124][ T1] ? __pfx_validate_chain (kernel/locking/lockdep.c:3824) 
[ 108.828310][ T1] ? mark_lock (kernel/locking/lockdep.c:4655 (discriminator 3)) 
[ 108.829327][ T1] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 108.830430][ T1] ? __cpuhp_setup_state (kernel/cpu.c:2553) 
[ 108.831632][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[ 108.832576][ T1] ? __cpuhp_setup_state (kernel/cpu.c:2553) 
[ 108.833259][ T1] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5721) 
[ 108.833944][ T1] ? __pfx___might_resched (kernel/sched/core.c:10142) 
[ 108.834708][ T1] ? preempt_latency_start (include/linux/ftrace.h:974 kernel/sched/core.c:5825 kernel/sched/core.c:5822) 
[ 108.835443][ T1] ? __pfx_init_osnoise_tracer (kernel/trace/trace_osnoise.c:3162) 
[ 108.836185][ T1] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:489) 
[ 108.836774][ T1] ? __cpuhp_setup_state (kernel/cpu.c:2553) 
[ 108.837437][ T1] __cpuhp_setup_state (kernel/cpu.c:2553) 
[ 108.838089][ T1] ? __pfx_osnoise_cpu_die (kernel/trace/trace_osnoise.c:2168) 
[ 108.839689][ T1] ? __pfx_osnoise_cpu_init (kernel/trace/trace_osnoise.c:2159) 
[ 108.840399][ T1] init_osnoise_tracer (kernel/trace/trace_osnoise.c:2180 kernel/trace/trace_osnoise.c:3187) 
[ 108.841052][ T1] do_one_initcall (init/main.c:1232) 
[ 108.841674][ T1] ? __pfx_do_one_initcall (init/main.c:1223) 
[ 108.842388][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 108.842971][ T1] kernel_init_freeable (init/main.c:1549) 
[ 108.843629][ T1] ? __pfx_kernel_init (init/main.c:1429) 
[ 108.844265][ T1] kernel_init (init/main.c:1439) 
[ 108.844816][ T1] ? __pfx_kernel_init (init/main.c:1429) 
[ 108.845440][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 108.846002][ T1] ? __pfx_kernel_init (init/main.c:1429) 
[ 108.846634][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[  108.847259][    T1]  </TASK>
[  108.884553][    T1] Loading compiled-in X.509 certificates
[  109.254386][    T1] kmemleak: Kernel memory leak detector initialized (mem pool available: 13820)
[  109.254412][   T88] kmemleak: Automatic memory scanning thread started
[  109.255698][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[  112.395476][   T26] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  112.409788][    T1] Sending DHCP requests ., OK
[  113.402700][    T1] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[  113.403839][    T1] IP-Config: Complete:
[  113.404411][    T1]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[  113.405811][    T1]      host=vm-meta-46, domain=, nis-domain=(none)
[  113.406763][    T1]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[  113.406775][    T1]      nameserver0=10.0.2.3
[  113.420894][    T1] clk: Disabling unused clocks
[  113.421617][    T1] kunit: disabled
[  113.437394][    T1] Freeing unused kernel image (initmem) memory: 6728K
[  113.443061][    T1] Write protecting the kernel read-only data: 69632k
[  113.445756][    T1] Freeing unused kernel image (rodata/data gap) memory: 400K
[  113.454231][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[  113.455584][    T1] x86/mm: Checking user space page tables
[  113.456470][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[  113.466947][    T1] Run /init as init process
[  113.467438][    T1]   with arguments:
[  113.467806][    T1]     /init
[  113.468091][    T1]   with environment:
[  113.468441][    T1]     HOME=/
[  113.468746][    T1]     TERM=linux
[  113.469067][    T1]     RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-001-20230921/gcc-12/d2618f89d9ede5e14fd2eb2d140fff1d31f4948b/3
[  113.470561][    T1]     BOOT_IMAGE=/pkg/linux/x86_64-randconfig-001-20230921/gcc-12/d2618f89d9ede5e14fd2eb2d140fff1d31f4948b/vmlinuz-6.6.0-rc2-00019-gd2618f89d9ed
[  113.471876][    T1]     branch=linux-devel/devel-hourly-20230920-182124
[  113.472519][    T1]     job=/lkp/jobs/scheduled/vm-meta-46/boot-1-debian-11.1-i386-20220923.cgz-x86_64-randconfig-001-20230921-d2618f89d9ed-20230921-20850-pprsaz-1.yaml
[  113.473851][    T1]     user=lkp
[  113.474160][    T1]     ARCH=x86_64
[  113.474497][    T1]     kconfig=x86_64-randconfig-001-20230921
[  113.475072][    T1]     commit=d2618f89d9ede5e14fd2eb2d140fff1d31f4948b
[  113.475699][    T1]     nmi_watchdog=panic
[  113.476119][    T1]     vmalloc=256M
[  113.476449][    T1]     max_uptime=600
[  113.476808][    T1]     LKP_SERVER=internal-lkp-server
[  113.477275][    T1]     selinux=0
[  113.477584][    T1]     softlockup_panic=1
[  113.477978][    T1]     prompt_ramdisk=0
[  113.478354][    T1]     vga=normal
[  113.586654][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230924/202309242253.a3803da4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

