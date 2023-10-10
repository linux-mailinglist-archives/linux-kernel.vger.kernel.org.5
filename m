Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6207BF4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442584AbjJJHyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442572AbjJJHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:54:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0CAC;
        Tue, 10 Oct 2023 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696924467; x=1728460467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TmSdkSG6Z/JnFvgy8Ifi8L9Qbrdkwpn1ukDraLUMGVk=;
  b=cqfRdzYfIzLmAVwkhsW7wswv6kfbQA3YhS3DxwXBh/6U2EyBWQIWJWtL
   DePpKllOKAHwalHLqqP6P/F9RbH5dhukvyYXSrCQOE+J+7EDLFIA6XQTE
   83lliNrX4f8rzPGyBqRNCVtSHlpEv7F9JLB8RK/cqzhfqHLIOlf3LEhlh
   RW2BYd0SXreqtjKTQg0pkiWzpypAP1Ix25fi1Hm4pfTg45v8x2jKf7tHv
   eOxZTM79yzW2I8DP0xntnUP6RlwNajcCpfGNftM6gf98FHugsedePKmP3
   UzikKBQ3x8/3PHt6yZEbME6s5c13KrEe8pZP0DU2Jupij+67tC+sKMP92
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450829766"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450829766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084679080"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084679080"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 00:54:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 00:54:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 00:54:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 00:54:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 00:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGYhdZjFR2V8exN7RC+DXph+18s9y1cGVxLaHbZyuYv7fJy/gYj193syPXcmKRIIPZq5+UybeR31SE7/eBXkRnR5F4TvdPnWV4ckpsmp6PEkweJTxMhZyJ6EBnJZY4GHERk/1iCOoz225wO7LzU9ml2jyuc4n7ooxjYuI33pNW7MDpXQvGmdgzgc0LYgb0OVvqYcDrJtORS7F7Azo4leTH2EmF9G7YaqLoJ271OBM4PRjCwumEtFvOEFM7XByyJfELI2gk8u3MJOVfs72zhOp91vcRUyiVzooW3ucLL/K61ICfEoyAZqlPdf33Ih4zHydMJM6dfFYTNUW9MjgbsjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIY+rAT1B+2xTNaZqqIlknbmlonL/I8uRRqZYO44f5c=;
 b=i4qe1rXR90+iz14S6SNuGIUqDXuorXGVkMyYFYJc9v0SM7d8+XTNF7a2oMS9yYIemMDp7W5uSFBaet9aFH9evbkX3ti7Qe1jHwgrufLaqTzi8nkUTMltmxlJ8AqfPU97IwZYHqnZQYpsMxpvYryuBhdhJ/A+RwJ02u8KazneFxUFdWnyXIFg9mNAHyX95MK4Oz2FR+yl8WtprfaIXwcAYdsGttwcKLbE7yr1D8/9Kxr0Ux2ySiyH123AxTTmzFNMIc87V0Vusr2HkN7lb9KleDj37CgGSCfHaTayNqFC73ZPa9H3NZIRUfRi5kfeIygszP2iWrwI6Z+UtKM32SN3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5497.namprd11.prod.outlook.com (2603:10b6:408:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 07:54:23 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Tue, 10 Oct 2023
 07:54:23 +0000
Date:   Tue, 10 Oct 2023 15:54:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "John Stultz" <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-doc@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [torture]  5d248bb39f: BUG:workqueue_lockup-pool
Message-ID: <202310101456.53664ae-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:820:e::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2f3d9f-f30d-4112-8767-08dbc9661dc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2J477YzJisrRLJrrU5msIye2KODT+53T66U5QTVpEC8eYfkMgC/qycU7VT9QUrWCBSbaZVct9XeU2dDAEe/TnEhZLYEX15PxW72LE02famUErUqM2tknizu3/7lLFKA97bCyyfT+Aim2B9ui2cspy3ceYA1AYn6fzKRBkHucqWEei4IngnNOPDww3l6eBwVRgkXAwKSOEsKzRLyuINug3URZ4yHf9/PUql05mUkUxuww2/GWVchWrnQ6NIqULP0IUM9CPu03T9RIPNO7XjxNGcw9WLIKUk/L18ImqeqjnXuGuDBH6dNL08T5YDuBEpU5TafX7kfVs0ZUiisynWcCDvdflbValvYcSU7Qb0GireOuEud8xEFilhZLrYZUMWfK0JZ+8m25NcgT6p03vua3JYxKXaQpubmeus6Vw6lqSk7GTvdZiQbMlBOhlhuloGIEtOBBfhuPIrexyBWLw8NeVDBNVEgpzvNtvVNQU6muC+PjD9ogvwIjtH2h18vk1fu8+ExTOW//vk1iQ8QXcofMcb9+Mukyo301wYj9r/coLukqn+DfTQqhwLpAKWpApeY18clkZrDA0Gm0vg6aYgik/FvXTZV3zWd0GpoQNApdWwwXRclOm6U9QXjEBSX9CVORLFLNEPd0+ObKBzKvrP10+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(107886003)(36756003)(478600001)(6666004)(6512007)(6506007)(38100700002)(54906003)(966005)(6486002)(66556008)(1076003)(2616005)(26005)(66946007)(66476007)(6916009)(316002)(41300700001)(8676002)(8936002)(4326008)(5660300002)(82960400001)(7416002)(2906002)(30864003)(86362001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2MF0RK5yVP6RqyKCzi9l1oS61C2aDEvGkcI4HjrrRRAUuuXGH4OVV3dgfgl?=
 =?us-ascii?Q?nWZfw1qMTnPDXrySqmVYZOvf/cTAYfQQOvqK0UZhMNisitxjsEr/RIVhxhMp?=
 =?us-ascii?Q?+jnJJ9zQVY3yJ49s6oWta61R4GHpMu3z7K0EMJMN8nTcboie14oyqsoNJE6S?=
 =?us-ascii?Q?nmzhCv7SawvBxZhcgXU1ARX0c4zrbfX9r9D87oxww0APqwJGsm8jVNiOAP8H?=
 =?us-ascii?Q?eOpptvxqjmD/ziztTFHDNbjKPQGb7Zj9RmdM7mZ472MSXgGMpg9runPG4G4H?=
 =?us-ascii?Q?TuVMiBiseKp8yo0A0QGTFtCXGLzVXO0bwJ/D6KRsd40Y8cge0SG+q25KCV5O?=
 =?us-ascii?Q?0rPizZVtWz0zhPr1oHj2Gtb5PhmTrUUYaW0FD0Boji727gFf9h4cHnkMAPG8?=
 =?us-ascii?Q?bS3jkrNWYUp9CYtkJ+xpS/Ru1w03aegNDX2YAm6d2dJXnOmaNQJA8KvDslKo?=
 =?us-ascii?Q?E2KPC3mCxRLH6DweaNL9OSBamLW2D4K0V9a6+Nk2vhySoGqw7LvL1NWcdMxr?=
 =?us-ascii?Q?CmtUys+IQueIB5rjaZn93BAkRWWIbp4zvAPi2trdW0TT4lFkmr2cjvF7NQIC?=
 =?us-ascii?Q?FyRDof4e8kynpZrSRlNl9EqYlDJ5WKki8uPH/jkO1mOZU+aHn7xg5mGb1gr7?=
 =?us-ascii?Q?w4zSP5dPX5y72hlOZ3hFG9wMni8nXbuDLnSMBgzGpiRnvQ6GRhQ8hXPXrVWF?=
 =?us-ascii?Q?5AQft0nkhRBA3JkO5iGuCSeF8by57uACDiSB1jn/v0M5MVddTjODDF+3fGbm?=
 =?us-ascii?Q?44IMFSbYHUeg9HhWilb/BKdnW9MlD27dSZxxo8jm7T4gBJn4QxE3jbY2raOa?=
 =?us-ascii?Q?1sOx5XpnxA/xV2hNvKEhBhhoA/OiCWya6HcsCTo+4Id2HQhnIjje3RVsP+YY?=
 =?us-ascii?Q?igO8hudwT4NnTRlnvfUcx67ejpBR/emgvXq8R3+bws6ZdPj4gikcgQM1T47a?=
 =?us-ascii?Q?zXGC80pMZuSte/XUKN70nnLk4UvBnujxmdrKUIb2NOKrJt+ganvsLrJjpYPx?=
 =?us-ascii?Q?3o/twErXqrzAY2Vy528iXrmaXaKVIOOyAIer6vYj23RumWEMwoQqHBCcsWX7?=
 =?us-ascii?Q?Sw9KCdrdQ4RgLzHO6eQpTcfOyjFuRED9ZUEOCoOHyV6ohtqsi0bu4BbVqfTz?=
 =?us-ascii?Q?54ws/K4sQrkiadzJO1Xqgt18j9/xu6rk7AKLO2p+aDZNPd4kAbfqmBncRa1R?=
 =?us-ascii?Q?14XEKta6z1Ams54rkGDMyf3AraJ4N6uRVni6wxSjt+uWaUIOTTbYpT8NMlNP?=
 =?us-ascii?Q?3lP2AiDPiknFXIa1Pp2n62sOclcSlLWZshb3RRcVDd6lS9wMPyLrz7OwT2EO?=
 =?us-ascii?Q?C9ais54bwi7IlCeu942zcayTuM/1qKnSPSVqJdKtJnGzIEeHg8ZNkBRq36Zp?=
 =?us-ascii?Q?Y5YSzPYb1ZtHmeiKlWjl6bvjremu+wQ6PbEAK/bBKtykwX1I090x31/mFRol?=
 =?us-ascii?Q?gNQSAnBUB9o4MbZy8Kyg5boz/65cwavUitvkS5J/yS3moAeA5UrXb9+5vgo9?=
 =?us-ascii?Q?OcUG7xrQr9uRYf9kKqPhDKN0eXj3CkMK/I54Ej3R47mpGPoOyP2Vi9N68O4W?=
 =?us-ascii?Q?kW2Ijse1z0iz1shzbpNU5F2UYG+ahojDKi4K/2/dIjuPRg3hqMpGA+XqEYzF?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2f3d9f-f30d-4112-8767-08dbc9661dc0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:54:22.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybQXvnQoIZcWvFy41pXz0h7G94MDjE9JxzyEf25by/97Yxq6FLBJBf/Nh50aviffAfe1Nv5KlEYm8cE1eZuPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Dietmar Eggemann,

we don't have enough knowledge to explain below issue, just report what we
observed in our tests FYI.

since random, we run the jobs for both 5d248bb39f and parent to 999 times:

67d5404d27437689 5d248bb39fe1388943acb6510f8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :999          6%          56:999   dmesg.BUG:workqueue_lockup-pool   <--------
           :999          0%           1:999   dmesg.INFO:rcu_preempt_detected_stalls_on_CPUs/tasks
           :999          0%           1:999   dmesg.INFO:rcu_tasks_detected_stalls_on_tasks
          2:999          2%          19:999   dmesg.INFO:task_blocked_for_more_than#seconds
          8:999         -1%            :999   dmesg.IP-Config:Auto-configuration_of_network_failed
          2:999          2%          19:999   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
           :999          0%           2:999   dmesg.RIP:__might_resched
           :999          0%           1:999   dmesg.RIP:debug_lockdep_rcu_enabled
           :999          0%           2:999   dmesg.RIP:ftrace_likely_update
          1:999         -0%            :999   dmesg.RIP:kasan_check_range
           :999          0%           1:999   dmesg.RIP:kfree_rcu_monitor
           :999          0%           1:999   dmesg.RIP:lock_acquire
           :999          0%           2:999   dmesg.RIP:lock_is_held_type
           :999          0%           1:999   dmesg.RIP:process_one_work
          1:999         -0%            :999   dmesg.WARNING:inconsistent_lock_state
          1:999         -0%            :999   dmesg.calltrace:irq_exit_rcu
          1:999         -0%            :999   dmesg.inconsistent{IN-HARDIRQ-W}->{HARDIRQ-ON-W}usage

as above, both commits have various random issues.
however, for dmesg.BUG:workqueue_lockup-pool, we only observed it happens for
5d248bb39f with a low rate (56 times out of 999 runs), but never happen on
parent.

below is more details. 

Hello,

kernel test robot noticed "BUG:workqueue_lockup-pool" on:

commit: 5d248bb39fe1388943acb6510f8f48fa5570e0ec ("torture: Add lock_torture writer_fifo module parameter")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 6465e260f48790807eef06b583b38ca9789b6072]
[test failed on linux-next/master 4ae73bba62a367f2314f6ce69e3085a941983d8b]

in testcase: boot

compiler: gcc-9
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310101456.53664ae-oliver.sang@intel.com


[  456.238517][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 34s!
[  456.263857][    C0] Showing busy workqueues and worker pools:
[  456.283499][    C0] workqueue events_power_efficient: flags=0x80
[  456.299402][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  456.302891][    C0]     pending: check_lifetime
[  456.331425][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  464.399159][    C0] hrtimer: interrupt took 9163921 ns
[  486.958477][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 65s!
[  486.974447][    C0] Showing busy workqueues and worker pools:
[  486.984953][    C0] workqueue events_power_efficient: flags=0x80
[  486.996029][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  486.996193][    C0]     pending: check_lifetime
[  486.996710][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  517.678504][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 96s!
[  517.694928][    C0] Showing busy workqueues and worker pools:
[  517.706364][    C0] workqueue events_power_efficient: flags=0x80
[  517.716928][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  517.717091][    C0]     pending: check_lifetime
[  517.717615][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  548.398534][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 126s!
[  548.415903][    C0] Showing busy workqueues and worker pools:
[  548.445877][    C0] workqueue events_power_efficient: flags=0x80
[  548.472451][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  548.472645][    C0]     pending: check_lifetime
[  548.473106][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  579.118467][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 157s!
[  579.227632][    C0] Showing busy workqueues and worker pools:
[  579.238527][    C0] workqueue events_power_efficient: flags=0x80
[  579.249190][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  579.249353][    C0]     pending: check_lifetime
[  579.249896][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  609.838492][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 188s!
[  609.854400][    C0] Showing busy workqueues and worker pools:
[  609.869467][    C0] workqueue events_power_efficient: flags=0x80
[  609.884664][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  609.884855][    C0]     pending: check_lifetime
[  609.885412][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  640.558322][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 219s!
[  640.573488][    C0] Showing busy workqueues and worker pools:
[  640.584383][    C0] workqueue events_power_efficient: flags=0x80
[  640.596724][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  640.596891][    C0]     pending: check_lifetime
[  640.597439][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  671.278472][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 249s!
[  671.305078][    C0] Showing busy workqueues and worker pools:
[  671.317258][    C0] workqueue events_power_efficient: flags=0x80
[  671.333460][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  671.333624][    C0]     pending: check_lifetime
[  671.357925][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  701.998584][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 280s!
[  702.019680][    C0] Showing busy workqueues and worker pools:
[  702.030924][    C0] workqueue events_power_efficient: flags=0x80
[  702.042393][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  702.043337][    C0]     pending: check_lifetime
[  702.044403][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  732.718468][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 311s!
[  732.741426][    C0] Showing busy workqueues and worker pools:
[  732.758915][    C0] workqueue events_power_efficient: flags=0x80
[  732.768737][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  732.768923][    C0]     pending: check_lifetime
[  732.806456][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  763.438485][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 342s!
[  763.461942][    C0] Showing busy workqueues and worker pools:
[  763.472996][    C0] workqueue events_power_efficient: flags=0x80
[  763.484138][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  763.484304][    C0]     pending: check_lifetime
[  763.484727][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  794.158571][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 372s!
[  794.174418][    C0] Showing busy workqueues and worker pools:
[  794.188676][    C0] workqueue events_power_efficient: flags=0x80
[  794.199823][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  794.199990][    C0]     pending: check_lifetime
[  794.200477][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  824.878523][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 403s!
[  824.898973][    C0] Showing busy workqueues and worker pools:
[  824.915273][    C0] workqueue events_power_efficient: flags=0x80
[  824.926393][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  824.926581][    C0]     pending: check_lifetime
[  824.927107][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  855.598509][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 434s!
[  855.628235][    C0] Showing busy workqueues and worker pools:
[  855.638889][    C0] workqueue events_power_efficient: flags=0x80
[  855.651558][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  855.651727][    C0]     pending: check_lifetime
[  855.652271][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  886.318451][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 464s!
[  886.343400][    C0] Showing busy workqueues and worker pools:
[  886.353541][    C0] workqueue events_power_efficient: flags=0x80
[  886.372345][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  886.372510][    C0]     pending: check_lifetime
[  886.373057][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  917.038624][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 495s!
[  917.061144][    C0] Showing busy workqueues and worker pools:
[  917.072203][    C0] workqueue events_power_efficient: flags=0x80
[  917.094365][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  917.094591][    C0]     pending: check_lifetime
[  917.095106][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  947.758605][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 526s!
[  947.794471][    C0] Showing busy workqueues and worker pools:
[  947.806830][    C0] workqueue events_power_efficient: flags=0x80
[  947.819558][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  947.819811][    C0]     pending: check_lifetime
[  947.820305][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  978.478528][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 557s!
[  978.503662][    C0] Showing busy workqueues and worker pools:
[  978.514379][    C0] workqueue events_power_efficient: flags=0x80
[  978.525533][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  978.525723][    C0]     pending: check_lifetime
[  978.548149][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[ 1009.198483][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 587s!
[ 1009.221412][    C0] Showing busy workqueues and worker pools:
[ 1009.237792][    C0] workqueue events_power_efficient: flags=0x80
[ 1009.269282][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[ 1009.269477][    C0]     pending: check_lifetime
[ 1009.290321][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[ 1029.678914][   T30] INFO: task swapper/0:1 blocked for more than 491 seconds.
[ 1029.699579][   T30]       Not tainted 6.5.0-rc1-00004-g5d248bb39fe1 #1
[ 1029.718868][   T30] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1029.740371][   T30] task:swapper/0       state:D stack:0     pid:1     ppid:0      flags:0x00004000
[ 1029.767948][   T30] Call Trace:
[ 1029.773801][   T30]  <TASK>
[ 1029.778983][ T30] __schedule (kernel/sched/core.c:5381 kernel/sched/core.c:6710) 
[ 1029.791567][ T30] ? io_schedule_timeout (kernel/sched/core.c:6592) 
[ 1029.800242][ T30] ? __lock_acquire (kernel/locking/lockdep.c:5144) 
[ 1029.808382][ T30] schedule (kernel/sched/core.c:6787 (discriminator 1)) 
[ 1029.815057][ T30] schedule_timeout (kernel/time/timer.c:2144) 
[ 1029.822775][ T30] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4663 (discriminator 3)) 
[ 1029.833948][ T30] ? usleep_range_state (kernel/time/timer.c:2129) 
[ 1029.842598][ T30] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 1029.851647][ T30] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 1029.860296][ T30] ? wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[ 1029.869302][ T30] wait_for_completion (kernel/sched/completion.c:86 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[ 1029.877507][ T30] ? wait_for_completion_io (kernel/sched/completion.c:137) 
[ 1029.886807][ T30] __cpuhp_kick_ap (kernel/cpu.c:737) 
[ 1029.894385][ T30] cpuhp_issue_call (kernel/cpu.c:1123 kernel/cpu.c:2324) 
[ 1029.907022][ T30] __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2473) 
[ 1029.917563][ T30] ? rcu_read_lock_held (kernel/rcu/update.c:380) 
[ 1029.926533][ T30] ? xz_dec_bcj_reset (lib/percpu_counter.c:201) 
[ 1029.934476][ T30] __cpuhp_setup_state (include/linux/percpu-rwsem.h:99 kernel/cpu.c:501 kernel/cpu.c:2503) 
[ 1029.942992][ T30] ? libcrc32c_mod_init (lib/percpu_counter.c:258) 
[ 1029.951358][ T30] percpu_counter_startup (lib/percpu_counter.c:263) 
[ 1029.959755][ T30] do_one_initcall (init/main.c:1232) 
[ 1029.967660][ T30] ? trace_event_raw_event_initcall_level (init/main.c:1223) 
[ 1029.978323][ T30] ? parameq (kernel/params.c:171) 
[ 1029.985581][ T30] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 1029.994714][ T30] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 1030.004702][ T30] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1546) 
[ 1030.013031][ T30] ? rest_init (init/main.c:1429) 
[ 1030.020898][ T30] kernel_init (init/main.c:1439) 
[ 1030.027964][ T30] ? rest_init (init/main.c:1429) 
[ 1030.035129][ T30] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[ 1030.047506][   T30]  </TASK>
[ 1030.052818][   T30]
[ 1030.052818][   T30] Showing all locks held in the system:
[ 1030.065360][   T30] 2 locks held by swapper/0/1:
[ 1030.073338][ T30] #0: ffffffff84b35190 (cpu_hotplug_lock){++++}-{0:0}, at: percpu_counter_startup (lib/percpu_counter.c:263) 
[ 1030.091412][ T30] #1: ffffffff84b37848 (cpuhp_state_mutex){+.+.}-{3:3}, at: __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2278 kernel/cpu.c:2449) 
[ 1030.109624][   T30] 1 lock held by rcu_tasks_kthre/11:
[ 1030.117928][ T30] #0: ffffffff84f38e50 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp (kernel/rcu/tasks.h:525) 
[ 1030.134843][   T30] 1 lock held by rcu_tasks_trace/12:
[ 1030.143010][ T30] #0: ffffffff84f38b50 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp (kernel/rcu/tasks.h:525) 
[ 1030.163969][   T30] 1 lock held by khungtaskd/30:
[ 1030.180109][ T30] #0: ffffffff84f39aa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks (kernel/locking/lockdep.c:6615) 
[ 1030.200232][   T30]
[ 1030.204126][   T30] =============================================
[ 1030.204126][   T30]
[ 1030.217675][   T30] Kernel panic - not syncing: hung_task: blocked tasks
[ 1030.221472][   T30] CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.5.0-rc1-00004-g5d248bb39fe1 #1
[ 1030.221472][   T30] Call Trace:
[ 1030.221472][   T30]  <TASK>
[ 1030.221472][ T30] dump_stack_lvl (lib/dump_stack.c:107) 
[ 1030.221472][ T30] dump_stack (lib/dump_stack.c:114) 
[ 1030.221472][ T30] panic (kernel/panic.c:340) 
[ 1030.221472][ T30] ? panic_smp_self_stop+0x100/0x100 
[ 1030.221472][ T30] watchdog (kernel/hung_task.c:195 kernel/hung_task.c:379) 
[ 1030.221472][ T30] kthread (kernel/kthread.c:389) 
[ 1030.221472][ T30] ? calculate_sigpending (kernel/signal.c:200) 
[ 1030.221472][ T30] ? proc_dohung_task_timeout_secs (kernel/hung_task.c:362) 
[ 1030.221472][ T30] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 1030.221472][ T30] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[ 1030.221472][   T30]  </TASK>
[ 1030.221472][   T30] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231010/202310101456.53664ae-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

