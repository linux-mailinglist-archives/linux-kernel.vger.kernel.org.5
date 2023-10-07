Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4B7BC4F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbjJGGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJGGQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:16:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D06C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696659362; x=1728195362;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=7yX/HaA8YkJMWlH4UejYNraGrL6i/6Tbi5mH1bSWapw=;
  b=nOI+bmVpjYDhcIzLi0iffL60vTucZ+qeHfsk2DAGXBr1JYYfoz96mxOK
   UN6T98OorcxBW6vtm8JJsRYxzCF0DnRpD7yAeFCCPURN9FMDQvcL46my3
   4wgfD4mlWpbRHbWE/75TAZ02T2iHAlt8AKpvCC1UeGnOXIugB7H5OhsCc
   6kwyZxQtt6QnCS7ZVQBmqeXzdG5dO/jwehJ7L+qcXOmp8idmh7WpnwVRG
   R0fCrJ2/T34w+YY2XRihBpbkvyoercxHpQJGXJ5IlAA63HGBTqBvRNL+l
   LERpiDkhSavLMMuNIY5Typez2q3SxhklyMN9lkSaas0D+WbCU++/H5cEB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="414893418"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="414893418"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822759543"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="822759543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 23:16:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 23:16:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 23:16:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 23:16:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 23:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8cvFuSAhwoZvfGgb7UU1rBAaTibnzKa0xIBxUyty2ULgLgx8qav/excuTcxEkXyopZUWScsM5PqgfgPP5VIfUWtRNIX9FTJbTKbPH+fgjfRsejkTPbC+qyYOWjUVt46m3GlN73eyECsRk2clFrTsHPgR8cb/O0ZeZJRlziTNTtzwevCovQ7/mhjnnmXf4tw2SZWTK2g2Lrs+N8w7XjizOAdiPgodnmIMbn6vId6UdQPm7Ejk2A1yGL+qYapJJwC3xSEUPpc91Al1TlopnnUjtgmyDFz++/ipBQyftVQuIUViJIXxUxYvvzRIaXD9n+xIPp5etBM/JhLvY1koNCamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omcGnb4/fOje7sBJJkJNCeDrFnC18v5kDqMYh7QC98E=;
 b=ZgDJXhtYrW/VIjVSmSjo7DNJ8k/XLckC7kGYlXvbwvm5PwVZFowbrShq5xbLLK2l5Tg9zI4MUWR0R/vXU9DNhMlBaarTY6Km04PcyRCODZTrKWr0z7F5JSTqOJdPWysGUK5sjM8+VGLYBpwMNyzKn9rqtROwd0wz75Bg2VWvjKkh/7FHVrepd0jACjr2RtzEJai+SoctQMXW9bn7uH/bM5t5bLQOdRCIgx2FV1rRXQM+pfprKzqiEHK1hn9vR5eAo9LnV83gUoS+UHHhq1rCXUf1CY6TWpAeyiDfZL7qMfgS3apFks67LDgkRujIoj4X++8Nmwev4KO+DMlWWhrB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Sat, 7 Oct
 2023 06:15:57 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Sat, 7 Oct 2023
 06:15:57 +0000
Date:   Sat, 7 Oct 2023 14:15:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <oliver.sang@intel.com>
Subject: [tip:x86/percpu] [x86/percpu]  ca42563486:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <202310071301.a5113890-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN6PR11MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 313fdca1-948b-4732-05d9-08dbc6fcde76
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnzbYH1Cjut5eBxlfcax3wVkRUv/Tq3x8zpc5+TUAWV4WcI52/BZCBlPVWXCxDHQDgAlhGn1x42+0hAA+W2uY1sgFxqkDHNrW09pQtN5p28pl06KLK5p2RToiK5HPyJnmrVQobEpgTyAE4kQV0eQCTqCz+R5chn+DzPK6GSkLCZ0rrjrHU5RBdcYn9vgfy2aLD1vkb+7HWgpLFClQXtBigyfAv4C8X60fIWKdf8hCdm1hh+zN31zpvhEu9Al0c91uUxyy5PWLX5HLiIdW9Vm/hg3uRyOeju1WVE4KIfcAg7+IydIiZalnoWl+L+uUU5WzqIOjsUGCH1ed+JxrULGTgH09G2hU2Pnm4k4KcRDJv5T2LGXTMVz185M2U26kyq5/bdYUNn5erxIJlbKl0qkxYbfRK01sbzRc0GsrY/jCPyCZcYB9TyxoM4iOIPAVCbEMxR+8wpyMMJRnw3L+ryBzE0OZAffk8ceDaRP0R0Mq5CfwfTZf8nk7X4xMg1Cj7AdHOokZkaBqAEmiORpAdTyYYXv3nhPAceP1jDcTPFJuswBi7gKilrsH9FwfQ5d77yIIXJ/TvvR5uFsn6y7TDmOCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(6506007)(6666004)(966005)(6512007)(478600001)(1076003)(26005)(83380400001)(2616005)(107886003)(7416002)(41300700001)(2906002)(66946007)(66556008)(66476007)(8676002)(5660300002)(4326008)(6916009)(8936002)(36756003)(54906003)(38100700002)(86362001)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GeG5MFYUs7hHbUezewZkzGsTZDMwrq8OUVUFFot2FE7YwSYZKgpgET8BgF0Y?=
 =?us-ascii?Q?CvAEZIJCUKOxdMLKzWwbFwpoiCrgoc95cr9SuZ68sZg76zzQXr8C8B2Sy+VO?=
 =?us-ascii?Q?FJIPh/YH3YBidC/yXz5sADXsOkdY4OCkf40dQiyX20+KOyOpi1VJCNRX+FhS?=
 =?us-ascii?Q?/4RjqOXtDnl7rXq+VIQos4vUaT4VzBiGJ6r+0EOi/rDRhRKzHSPpY+01dVz0?=
 =?us-ascii?Q?UZbl33aqa6LlEst/ImI4p1VvN3kmqPDHlQmpSb3amIrW7S2Mnpb2E0xmAyrf?=
 =?us-ascii?Q?twLZnlLQXsI9ud68/Xkwe4+pWMsLL/IHiXdVaDTawTVXhXX3w7tqwNGQOuni?=
 =?us-ascii?Q?0bFPdBjo/LMclgFRO+CC6YB/+Q+ESXJrIC76zSifTqe2GR+3lyvHAVgCrSmX?=
 =?us-ascii?Q?4ekrf41Hc0vSclODySDAH3UOxuqUQOBx6ITuFK/m8cPPRzFV9jFPEqQURcvO?=
 =?us-ascii?Q?04WeaBxEslQxE3PG3tGgw6m8Fex0GRkdzG6ajHDsCIs233dscuXGB8OdfxdL?=
 =?us-ascii?Q?0bmuD+ose5SNmvTWbBmShPlI13x/264/JFLYgZzLm3xVop3X85/b1aXUF5WT?=
 =?us-ascii?Q?XlKP/JZqPSnmiKoQz5yLtVjzOPTy8jZubr0uvuxC5+7Oq2AF0wm8wvLXCN/C?=
 =?us-ascii?Q?Wq8HEuMqjgPsxfenoK7bRee8ZT17qy20pu7eCd2lDm+MJVssR9tuMfXlz2xK?=
 =?us-ascii?Q?pDNz44Z797BiRrfszdo5BXP7uJ/+cy74RIHnkjBT8q2aYbf1FKFnW8PYtfn6?=
 =?us-ascii?Q?kXgA59ObS3vl+NwnJMaWY2XCwTlbnNdA8KhJqXnVdArAv21W1czhITOk61OO?=
 =?us-ascii?Q?IsFguYtGLgVLPLcNjj8a9gR0P+NtiE51R1N91kHSPCDiANxoBuFLp/6eceij?=
 =?us-ascii?Q?5q4oKk28+e0f+ZijRSqcXbsOmcAX1sh7gzCEkLWUIRL+x8f1pQ5vOmHtrKDG?=
 =?us-ascii?Q?WboIUd0bEUmiRe56XGnrJT2o3tRM6M+nSeQI2YzjA+3ocNjWHM8VrT2fE8me?=
 =?us-ascii?Q?A3fQJb0AsNKHktlQm2wcSqii5krZgQ95X+w9ppmB2J29XCo5VLwuj0YRO6Zj?=
 =?us-ascii?Q?dyJGKy3JRiylAZXoM0N8i9dYESpeKR9C9FU+KNymrczz+PDO1ySRkygurHs+?=
 =?us-ascii?Q?Th4ntUk8EmbkCq+Mhnjn27Xoq2iBg/srow5OWBTwYGrGRy/Etz6qcnJvN5Lv?=
 =?us-ascii?Q?j+GMZEodcGMiWb8MKSEUDVfPKotQZq4/nf1jPXqOzOD14aOsBqHXdopTxCIo?=
 =?us-ascii?Q?FP5IkKqrlskqoslfR36NkaFVVwoLXXnudnUEAhvSnWWsmN/7Oa1DXarEWFhp?=
 =?us-ascii?Q?CWUsGcCnPfRke+JHlM3KGp5F2oGg4qF4DqoC91Hhjt30U8k+5ITdxiWqIT0s?=
 =?us-ascii?Q?bXNDbPWVjvvIHHRq/GxwEc/w5zv7ZAgJncK18Fi2a9vc/Uqej8E6vK4BJ+jL?=
 =?us-ascii?Q?lZWaDrHy+9WYzyQmYZT0hE00cTVzXaOZSxWvsw1xCBZh+Kz1bF275A1+P9as?=
 =?us-ascii?Q?toeTAQ+DuqxK87rcIdAhAZIRyZEHy91IHVnYU6t7olGs0Uv/Xgjpx71D6+qW?=
 =?us-ascii?Q?0p+xmx119h2DLcBBAgW0eEa4mb8GiQU18gyPfybP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 313fdca1-948b-4732-05d9-08dbc6fcde76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 06:15:57.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EJQwgIJ8axT0u8x271RYk6RpaWHoH+rWVNnfOw7yaZ2ctELwYF6ylOmPVqR09oJnNu+ibiPhedx7CtfxkDclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:Booting_the_kernel(entry_offset:#)" on:

commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for pe=
rcpu read/write accessors")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/percpu

[test failed on linux-next/master 0f0fe5040de5e5fd9b040672e37725b046e312f0]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------=
------------+------------+------------+
|                                                                          =
            | 9a462b9eaf | ca42563486 |
+--------------------------------------------------------------------------=
------------+------------+------------+
| boot_successes                                                           =
            | 13         | 0          |
| boot_failures                                                            =
            | 0          | 13         |
| BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entr=
y_offset:#) | 0          | 13         |
+--------------------------------------------------------------------------=
------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310071301.a5113890-oliver.sang@=
intel.com


trampoline_32bit: 0x0000000000000000

Decompressing Linux... Parsing ELF... done.
Booting the kernel (entry_offset: 0x0000000000000080).
convert early boot stage from hang to failed
BUG: kernel failed in early-boot stage, last printk: Booting the kernel (en=
try_offset: 0x0000000000000080).
Linux version 6.5.0-11417-gca4256348660 #1
Command line: ip=3D::::vm-meta-312::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/re=
sult/boot/300/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-006-=
20231006/gcc-12/ca4256348660cb2162668ec3d13d1f921d05374a/3 BOOT_IMAGE=3D/pk=
g/linux/x86_64-randconfig-006-20231006/gcc-12/ca4256348660cb2162668ec3d13d1=
f921d05374a/vmlinuz-6.5.0-11417-gca4256348660 branch=3Dtip/x86/percpu job=
=3D/lkp/jobs/scheduled/vm-meta-312/boot-300-debian-11.1-x86_64-20220510.cgz=
-x86_64-randconfig-006-20231006-ca4256348660-20231007-59999-9pqjzt-4.yaml u=
ser=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-006-20231006 commit=3Dc=
a4256348660cb2162668ec3d13d1f921d05374a nmi_watchdog=3D0 vmalloc=3D256M ini=
tramfs_async=3D0 page_owner=3Don max_uptime=3D600 LKP_SERVER=3Dinternal-lkp=
-server selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cp=
u_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlo=
ckup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ra=
mdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel cons=
ole=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal r=
w rcuperf.shutdown=3D0 watchdog_thresh=3D240

Kboot worker: lkp-worker57
Elapsed time: 780


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231007/202310071301.a5113890-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

