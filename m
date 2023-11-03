Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2927E004D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjKCGa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:30:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFF1A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698993018; x=1730529018;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ov7SpjepZFBeCQiul1lD0agtxa8kmRSfr4IdbxN0rZc=;
  b=LXJtbni5Modh23cRyzwPbGXrVE+pg0pX2UAe7xQ7XrZYlDMQt/dNTuT8
   IN2sqBFTJQXHSDSBnm+qWdDm86iFlOpp5uBxyjrcDWX8+dUWtc5hR7psS
   T877Ar9dAPvMpuqG+Y5qgp3Tazx3i9eeozSiZxaosgThdR6Wb7bazySca
   fQ+9gKKkGQTxPC4bLiAfC3jWGPJ8nMZU6b9A6PBug5novP8wL9SfJG+km
   bHyCRr34WMDL3FvZ9Q2DN0XbmBOizoeCJo6mqivPMYE/ESe6TJkGNlbqC
   jafbMmNGjDJGdQtptcIDQpxoZChKPiYy76a17PemgIGo1oQvs+cmEUDoo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419996658"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="419996658"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 23:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="935014516"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="935014516"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 23:30:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 23:30:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 23:30:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 23:30:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcBm7z5YCO5hvAkd09F49QkeZijT0v/4JtUHte7bXJC0eSOh78El2PPE6EDUd7KJGuZFTvIJwCPaE+SsE43R0AtC3fXuCfLTYCE6Xe2k+FGUavSxHMxtu4M3JlH8WM2CwNHAAvNG5XzawdSh8kSjmuGEK+FIdhFNn3icHmjEsn6RyB9j4xPlJPQoRHzVO0pb1UP5GJZrIuFFisaMJ4DaYHMMQCa8tJwskMdKLVEItS6rMUF1TDhGYUiWdCfBIrYPfZENAWShkQdx3xP6LYVvUg7qsv9l7d96gURLt2bwdIS0vAtuP35iovD5LCyBNdQfxvw0sb0vBU6PwdFwrW3XJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6bRuK8UPZMaAsO9HuWUsSrMgh+CiYSHHQpmbtWE1Pw=;
 b=kmDNwEk7DwuYdRKOS8AL1BExn6x5IxEr/YH94EJCTpFTSp2IKDmm7oH0kc6rlz/F4YE5iI3x/Yo+PlqOM7S3Ji710OlQhDwhbEcoudkKCwqDyGImbHVJniLxDuf5b7XLHlBbOB2qdpX1UeN6gIiK4UaGbsdBCVDx56aPYh82/IoFgngaaGAHJtgi4s8W6nctzp+mMJ6x756Ow4qtVBnVaEDPXqbFej3vub5oXYIz3lWT8S8iJFbkQrTAA31DteFoym7yLg304DVH2a4ZT+VtlCxpGK2hHcrq2UOjgr5LWB9026TL5GGxvIegcSfeplsZGw+6xLFHNvdsf8xoFDyxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by CY8PR11MB7923.namprd11.prod.outlook.com (2603:10b6:930:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 06:30:14 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::f284:604e:8e12:2356]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::f284:604e:8e12:2356%3]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 06:30:14 +0000
Date:   Fri, 3 Nov 2023 14:30:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <surenb@google.com>, <mst@redhat.com>,
        <michael.christie@oracle.com>, <mathieu.desnoyers@efficios.com>,
        <mjguzik@gmail.com>, <npiggin@gmail.com>, <shakeelb@google.com>,
        <peterz@infradead.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Abhinav Singh <singhabhinav9051571833@gmail.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Message-ID: <202311031320.c3ebc782-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231028204609.426841-1-singhabhinav9051571833@gmail.com>
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|CY8PR11MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e30621-fa9a-4dde-b77f-08dbdc3655ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0DWuVSzoYcPBXorsQhGP3EcKGRWc6HSowBKTFaFwSYd9YbtHVSAma13f0Vc4qQO+9LI7wvMexvn9UqN0bPGQ1ME69gDKo11k2GtPbVIp9lgltkAHEIchLVB5PsNYkFjXOQ6mvhBsufcuMRpvlM2x/QzDDvJn3i721R4B6OweLvcYuyTGgAY7O4LYgsMOixQWfN04oX6MOWPy+Si817a9hZOYRkgvtS1Hy7+/6UkaUoMDhZcRV6iDa87pbwHCOqC4O2EmhAiltGgO4tlPOFX1Cqq2s/Gv5JVK5+jcbc9rVnke+o+O8LkF2zXrqmCW2imRzw3K6xhuEvlwq40xQE6kjqACAO1SGBGCOmpCCQ/BxKUVjKCX+XvJDL+1R5qgXq2zqXqkW1Ww0ccBQVeBM2eyi6wTkjZtJ0Iqec60V1mfFse1MrllaRFGVNwMkygwWRjA3dFQic9JATNELgOlGq5Ltw9f/ulNTAjjGJdX3VzEo/CXfF9jIdUsInQ4KT9dsQ1xR4nsJNvUAwHwR+h3RVLPOjzVi3ZPny83mg2yIYBnjyTedTwmUXnPA0SSVv+1VZoQw9n3Pweb1VMK6e4+GTtx15F59ky6YE3VTWRfJiOIi7/SXte099K1DhxiyTEkaKsCI6S2akfvtwRpd96OVFSrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6916009)(66556008)(66946007)(316002)(6512007)(6506007)(66476007)(2616005)(26005)(36756003)(1076003)(6666004)(82960400001)(38100700002)(86362001)(83380400001)(6486002)(107886003)(478600001)(966005)(2906002)(5660300002)(30864003)(7416002)(41300700001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xunzx88eLaCf6cmScIeEuX0kI3cy4ZE72SKCONksbFyKrvaEMVolyHMaoQ6g?=
 =?us-ascii?Q?4uM/vqyOxOmUWr43HHURH9bOSyZDgEA0LUBq8ckqvKThkNLTHhus8Tb6f75L?=
 =?us-ascii?Q?OxOT4N+Fy68DHDBOCPsT3oq6K4KdRk150TP+ToAn/eenRFvlPtvPUyrVW7JD?=
 =?us-ascii?Q?3Ll0oidCvd9+3C0sGzdWAHAuOkKqh2h7kFV7vKN7q66OJsjmsfyHhpElLed6?=
 =?us-ascii?Q?JZbWO96yqyKQBEqxx4uDl1Z0LUSL0HrbD9N5EutdimCIrZr0aq9Pf4FuenN1?=
 =?us-ascii?Q?e6aIutRyO8dlAz+UGUpmvZLD+vP21qDKp+vmE/Iq0+hFPioVS2dk+v2ptJQx?=
 =?us-ascii?Q?CDXf25Yt5gxOySuKx4FtCfQwKrtoggsftRDNowAJ5wiRzOMk0RBSI+1b3ZOg?=
 =?us-ascii?Q?WdNJ2h/UTDIXhrvov4ZHQBjA/luVMqZ64hqVevVjjCvFHNNSKy/w8nczrwIg?=
 =?us-ascii?Q?OgmpPGTYCcqVONhckzHeAMWSAkEwCPvHNWntLkKMwxaXMTQBveczmm2td4+A?=
 =?us-ascii?Q?GoA00xTDQoH2h7wXstVR3vhQYlrZ3twYXSzLmXpjijtwow4U66kQbmTia+El?=
 =?us-ascii?Q?sadJD/QiKSewfUYEC61yB/Q9ZmWcjL9P+QYR1INoxeJdLjyu2arCnmLFRle3?=
 =?us-ascii?Q?QoTyrFEeecyim9FJE1yKTce+v1NAQMuK+04uG3el8YBnf2rYrb7Gja1+R71R?=
 =?us-ascii?Q?NLW1uDacaJ0ZgMINFdiIgu3TV+KIRhL24NDCa0W3ZJMFRPbSSsbnc4aNyQ/a?=
 =?us-ascii?Q?HErY99CUya3eb5ALtMWHSr58ueCuSmD78F3SMgJDRUaHvv5Gc37iQBze5Y/K?=
 =?us-ascii?Q?sBpWWGPFcQ9TVysIHkqnn6nyCO7qdyovXmf+wCyASzLIyCMezjPDAvOBEKOH?=
 =?us-ascii?Q?8qWsT5rRWN9CSUEuMwUL0ObPx9SPAYd7gu9UOtS/mnBxYAmixEbpIJJM/+B5?=
 =?us-ascii?Q?izDo7/9saQ+sqed/Jyrfoe8QZvPddyXkt2eSesiBVtmsNDhefmXQmOkB4jg3?=
 =?us-ascii?Q?TiHc3g0FToBYWin7oC2oUU3Xknpy0OJkZNPrctG4eiv7q8uOVkWbO0umvEK/?=
 =?us-ascii?Q?TOYZisEnpY4XwQquLNU23hModhi4FoqjGrqJHDv5f5gQFIaPL0Ccu4MF6tk4?=
 =?us-ascii?Q?oPhdemseetlGarUBYNjIE2tO33oPwwHqK05LZA8X4PAimpS4vJl+7g57kj/h?=
 =?us-ascii?Q?a017SKP1p9sN97OukVWgfLqMM/2PG0ARd/xRW5xnh/k2x0dlGP+fzdERPF8k?=
 =?us-ascii?Q?E0ksXVVsORralaYrcB5btpB1muGo92UrxWmTUlXkJ/NRWZqmjGAK8uyrd7Zd?=
 =?us-ascii?Q?PI+jkVaMq+/VDlvIm2jN/sP0HLA9LLr9S/MWnVC4ug0nZ8gn7dKdr3OIO4bY?=
 =?us-ascii?Q?EpEZVnyklO6/ZHvXBPgIqLE1jwYSdyPBusloioiqwxlYFR17H0De4VudXo7g?=
 =?us-ascii?Q?qF7lIt387nQ0KA12K5ACez8vinlhy7OnPxtYltA7KMCDU/BsFklWkugYG4Il?=
 =?us-ascii?Q?c8MsSqPAXWNHpKCy2qDO+a96Nz6f8sMv/aC/UHSzcMuEUWKgrHU82FdDb8V6?=
 =?us-ascii?Q?xX2qTWn4HwDJzh47Ou+KuuG92WR6sQopCnp+8clFhCZ/lSShIq/9a2+p2jBm?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e30621-fa9a-4dde-b77f-08dbdc3655ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 06:30:13.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NcdbKViOmwq6sNlNDfmlG83kDWD0rwr80AnhBIjzBL+u6nfSOgYqBaVQLlEegQj9sqIuDAlNf25/DYUpytlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 0c940f3d0d4c41567b1957a4e09ad68bdeee2111 ("[PATCH v3] Fixing directly deferencing a __rcu pointer warning")
url: https://github.com/intel-lab-lkp/linux/commits/Abhinav-Singh/Fixing-directly-deferencing-a-__rcu-pointer-warning/20231029-044918
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20231028204609.426841-1-singhabhinav9051571833@gmail.com/
patch subject: [PATCH v3] Fixing directly deferencing a __rcu pointer warning

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 44c9217272 | 0c940f3d0d |
+--------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                           | 0          | 8          |
| kernel/fork.c:#suspicious_rcu_dereference_check()usage | 0          | 8          |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311031320.c3ebc782-oliver.sang@intel.com


[    2.386253][    T0] WARNING: suspicious RCU usage
[    2.386253][    T0] 6.6.0-rc4-00506-g0c940f3d0d4c #7 Not tainted
[    2.386253][    T0] -----------------------------
[    2.386253][    T0] kernel/fork.c:2688 suspicious rcu_dereference_check() usage!
[    2.386253][    T0]
[    2.386253][    T0] other info that might help us debug this:
[    2.386253][    T0]
[    2.386253][    T0] rcu_scheduler_active = 2, debug_locks = 1
[    2.386253][    T0] 3 locks held by swapper/0:
[ 2.386253][ T0] #0: ffffffff84dbdc50 (cgroup_threadgroup_rwsem){.+.+}-{0:0}, at: cgroup_can_fork (kbuild/src/rand-x86_64-3/kernel/cgroup/cgroup.c:6538) 
[ 2.386253][ T0] #1: ffffffff8482f010 (tasklist_lock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2624) 
[ 2.386253][ T0] #2: ffffffff84846178 (init_sighand.siglock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2226 kbuild/src/rand-x86_64-3/kernel/fork.c:2643) 
[    2.386253][    T0]
[    2.386253][    T0] stack backtrace:
[    2.386253][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4-00506-g0c940f3d0d4c #7 88a30a6c68427eeed926405592f52ff30544ebdd
[    2.386253][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.386253][    T0] Call Trace:
[    2.386253][    T0]  <TASK>
[ 2.386253][ T0] copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2688 (discriminator 9)) 
[ 2.386253][ T0] ? pidfd_prepare (kbuild/src/rand-x86_64-3/kernel/fork.c:2245) 
[ 2.386253][ T0] ? acpi_hw_validate_register (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:196) 
[ 2.386253][ T0] ? proc_register (kbuild/src/rand-x86_64-3/fs/proc/generic.c:383) 
[ 2.386253][ T0] kernel_clone (kbuild/src/rand-x86_64-3/include/linux/random.h:26 kbuild/src/rand-x86_64-3/kernel/fork.c:2903) 
[ 2.386253][ T0] ? acpi_hw_register_read (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:489) 
[ 2.386253][ T0] ? create_io_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2862) 
[ 2.386253][ T0] user_mode_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? kernel_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? acpi_hw_validate_io_request (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwvalid.c:128) 
[ 2.386253][ T0] ? rest_init (kbuild/src/rand-x86_64-3/init/main.c:1429) 
[ 2.386253][ T0] rest_init (kbuild/src/rand-x86_64-3/init/main.c:691) 
[ 2.386253][ T0] arch_call_rest_init+0x13/0x80 
[ 2.386253][ T0] start_kernel (kbuild/src/rand-x86_64-3/init/main.c:992 (discriminator 1)) 
[ 2.386253][ T0] x86_64_start_reservations (kbuild/src/rand-x86_64-3/arch/x86/kernel/head64.c:544) 
[ 2.386253][ T0] x86_64_start_kernel (??:?) 
[ 2.386253][ T0] secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[    2.386253][    T0]  </TASK>
[    2.386253][    T0]
[    2.386253][    T0] =============================
[    2.386253][    T0] WARNING: suspicious RCU usage
[    2.386253][    T0] 6.6.0-rc4-00506-g0c940f3d0d4c #7 Not tainted
[    2.386253][    T0] -----------------------------
[    2.386253][    T0] kernel/fork.c:2689 suspicious rcu_dereference_check() usage!
[    2.386253][    T0]
[    2.386253][    T0] other info that might help us debug this:
[    2.386253][    T0]
[    2.386253][    T0] rcu_scheduler_active = 2, debug_locks = 1
[    2.386253][    T0] 3 locks held by swapper/0:
[ 2.386253][ T0] #0: ffffffff84dbdc50 (cgroup_threadgroup_rwsem){.+.+}-{0:0}, at: cgroup_can_fork (kbuild/src/rand-x86_64-3/kernel/cgroup/cgroup.c:6538) 
[ 2.386253][ T0] #1: ffffffff8482f010 (tasklist_lock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2624) 
[ 2.386253][ T0] #2: ffffffff84846178 (init_sighand.siglock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2226 kbuild/src/rand-x86_64-3/kernel/fork.c:2643) 
[    2.386253][    T0]
[    2.386253][    T0] stack backtrace:
[    2.386253][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4-00506-g0c940f3d0d4c #7 88a30a6c68427eeed926405592f52ff30544ebdd
[    2.386253][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.386253][    T0] Call Trace:
[    2.386253][    T0]  <TASK>
[ 2.386253][ T0] copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2689 (discriminator 9)) 
[ 2.386253][ T0] ? pidfd_prepare (kbuild/src/rand-x86_64-3/kernel/fork.c:2245) 
[ 2.386253][ T0] ? acpi_hw_validate_register (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:196) 
[ 2.386253][ T0] ? proc_register (kbuild/src/rand-x86_64-3/fs/proc/generic.c:383) 
[ 2.386253][ T0] kernel_clone (kbuild/src/rand-x86_64-3/include/linux/random.h:26 kbuild/src/rand-x86_64-3/kernel/fork.c:2903) 
[ 2.386253][ T0] ? acpi_hw_register_read (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:489) 
[ 2.386253][ T0] ? create_io_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2862) 
[ 2.386253][ T0] user_mode_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? kernel_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? acpi_hw_validate_io_request (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwvalid.c:128) 
[ 2.386253][ T0] ? rest_init (kbuild/src/rand-x86_64-3/init/main.c:1429) 
[ 2.386253][ T0] rest_init (kbuild/src/rand-x86_64-3/init/main.c:691) 
[ 2.386253][ T0] arch_call_rest_init+0x13/0x80 
[ 2.386253][ T0] start_kernel (kbuild/src/rand-x86_64-3/init/main.c:992 (discriminator 1)) 
[ 2.386253][ T0] x86_64_start_reservations (kbuild/src/rand-x86_64-3/arch/x86/kernel/head64.c:544) 
[ 2.386253][ T0] x86_64_start_kernel (??:?) 
[ 2.386253][ T0] secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[    2.386253][    T0]  </TASK>
[    2.386253][    T0]
[    2.386253][    T0] =============================
[    2.386253][    T0] WARNING: suspicious RCU usage
[    2.386253][    T0] 6.6.0-rc4-00506-g0c940f3d0d4c #7 Not tainted
[    2.386253][    T0] -----------------------------
[    2.386253][    T0] kernel/fork.c:2690 suspicious rcu_dereference_check() usage!
[    2.386253][    T0]
[    2.386253][    T0] other info that might help us debug this:
[    2.386253][    T0]
[    2.386253][    T0] rcu_scheduler_active = 2, debug_locks = 1
[    2.386253][    T0] 3 locks held by swapper/0:
[ 2.386253][ T0] #0: ffffffff84dbdc50 (cgroup_threadgroup_rwsem){.+.+}-{0:0}, at: cgroup_can_fork (kbuild/src/rand-x86_64-3/kernel/cgroup/cgroup.c:6538) 
[ 2.386253][ T0] #1: ffffffff8482f010 (tasklist_lock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2624) 
[ 2.386253][ T0] #2: ffffffff84846178 (init_sighand.siglock){....}-{2:2}, at: copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2226 kbuild/src/rand-x86_64-3/kernel/fork.c:2643) 
[    2.386253][    T0]
[    2.386253][    T0] stack backtrace:
[    2.386253][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4-00506-g0c940f3d0d4c #7 88a30a6c68427eeed926405592f52ff30544ebdd
[    2.386253][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.386253][    T0] Call Trace:
[    2.386253][    T0]  <TASK>
[ 2.386253][ T0] copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2690 (discriminator 9)) 
[ 2.386253][ T0] ? pidfd_prepare (kbuild/src/rand-x86_64-3/kernel/fork.c:2245) 
[ 2.386253][ T0] ? acpi_hw_validate_register (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:196) 
[ 2.386253][ T0] ? proc_register (kbuild/src/rand-x86_64-3/fs/proc/generic.c:383) 
[ 2.386253][ T0] kernel_clone (kbuild/src/rand-x86_64-3/include/linux/random.h:26 kbuild/src/rand-x86_64-3/kernel/fork.c:2903) 
[ 2.386253][ T0] ? acpi_hw_register_read (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwregs.c:489) 
[ 2.386253][ T0] ? create_io_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2862) 
[ 2.386253][ T0] user_mode_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? kernel_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2971) 
[ 2.386253][ T0] ? acpi_hw_validate_io_request (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/hwvalid.c:128) 
[ 2.386253][ T0] ? rest_init (kbuild/src/rand-x86_64-3/init/main.c:1429) 
[ 2.386253][ T0] rest_init (kbuild/src/rand-x86_64-3/init/main.c:691) 
[ 2.386253][ T0] arch_call_rest_init+0x13/0x80 
[ 2.386253][ T0] start_kernel (kbuild/src/rand-x86_64-3/init/main.c:992 (discriminator 1)) 
[ 2.386253][ T0] x86_64_start_reservations (kbuild/src/rand-x86_64-3/arch/x86/kernel/head64.c:544) 
[ 2.386253][ T0] x86_64_start_kernel (??:?) 
[ 2.386253][ T0] secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[    2.386253][    T0]  </TASK>
[    2.387851][    T1] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    2.389031][    T1] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    2.390637][    T1] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    2.391901][    T1] Running RCU-tasks wait API self tests


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231103/202311031320.c3ebc782-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

