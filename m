Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015817EDC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:39:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797F19F;
        Wed, 15 Nov 2023 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700120374; x=1731656374;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rKsjleUV8mKTZfyeI3rAS4Yr6IVOfxbqDp61+/kza3w=;
  b=hzBm5hDAxij5IyA7oQ2qXjsNSvOMBGLaF8po/pJEwvVrZL7zjyEnC8mv
   EfVjZioE/9g50litVoBhqTNgyZsQJReqvl9FbRcucz17MZ2qwPqZgv1XL
   ZcsepKAbUFVyNLfcc7Y4HcEOwFh2pfMUA/RyXANlgDUEl7kzCIhrQ325N
   /wQnLo+TYhwYRAePgDzAKlXHil7IYfYHT4yyGrsXHCmc2jFY4Kar1RmXF
   MpnqkMOJT3xgnPK/f4f5cLc2Eo8K5aP2wpB4MifIW7XiLraJoG3DbmTe8
   yZYKh+JUrq443/SHX/Idf7Vy3X5Byb0XDz0I7dZ+EFBS+WWOHdPzH8mGB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371217382"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="371217382"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="835664285"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="835664285"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 23:39:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 23:39:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 23:39:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 23:39:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKONll5XeAmFt+rH6CoogzBN2RHaNY/6XFnIp5IkJSfSM0FMl1kMBA/AjUKPIUTlVdYlqVQFsV5ZFX18ucxynfiijzUe70av4iIZCPnKPZjpy1qu9fAC5hkiy8deIW2nLlEjqKDYU8Oar8zQl9MfjtFNAWZaWCeVRmIYmMbOpjq9g6p/VfHn0hQyZmDUR0XArPeuMT4uoDdy4DvatOElad4kByUXR0eJGRGBCo5KUpo9hYgbP9ETUlGWu46tZSegQySEE33RJUrCbLMT9DPRlb635DHxcTND455R/FMyiTrk6VSoZYWzvG6TN/kYm4YkCWeybavsIH8hMF4188Q7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaxelDsBKs2BjbQt2OodAVzag89d7apDgVV6Xch8ev8=;
 b=SWStY0xjKRNVYXhnjjDo4UjZHVaTZVCbtcVt+o0aPiUWqU429swRVEw4+f6janzCnvh9eh2xiG5ju84ebRsqdEmFQDuOnvwaSWTbwfqkiZt60P0YhEXy5TE0igge8jRmlFCd4udwlZDfVtkTyn9VvXy/ukboFqeQdda2GsPDRkJIctGCQMSV+KZIRRzRE4SrvCUutU65U19o3K2blXqR4LdCgQK+M01uFafTq6YhLcLEx1e2JxuoZ2wEYXNwt7m8/yyIbxY/h4H45/psnpuHaYxRRoyg2SxT37OKXazJSBxocGfAyPgCl+XbnvcwzaQNtJmlLxgu7HVGoXYLi+CM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Thu, 16 Nov
 2023 07:39:21 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 07:39:21 +0000
Date:   Thu, 16 Nov 2023 15:39:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <tj@kernel.org>, <jiangshanlai@gmail.com>, <song@kernel.org>,
        <junxiao.bi@oracle.com>, <oliver.sang@intel.com>
Subject: Re: [RFC] workqueue: allow system workqueue be used in memory reclaim
Message-ID: <202311161556.59af3ec9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108012821.56104-1-junxiao.bi@oracle.com>
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 58878d69-ea1d-419d-a000-08dbe677259a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+3CnVdiSkiH77ZluB1N4/G/gSGtfXUd5g4KhXhHV3Gm37AawOE061SZjLhDlmomWSjTTtbw7Qzhd4cYFNrBL7HSvpyix8eNq0dfWaG9P5iLxfwfQWsXBluXZmdZsc7EEvLKkMJUnYygGOeLulFF7f6RQ16OjwT0T6Cmot1T6Crj7WJL/wjIKOorzV+zgP8H92UskvJSX6/1zt6IER1YXcRM9nRupY/CTnytHjwgT5sR4+bfa1W2LMBlHytuPpxqoESU+7PltjCTs6kUWP3MWx6T0cDiiajaDyZjYOjWspH90fwBiX8UrgOORJV0pgvUUV7adGPx8SnwfatlCUDCnwR1wuXIesutfuVwmiIveDuQCKl3n0s57Ql3r089hHOoClk4PwfE57wsNsMfEydDT6gJ4tb3AEwgIqzPINWvlttFxjBMsVM4Cz4CJzSrzz5a7fuIHqEjjizHfTN+CfMKbEkzycKunV9U3TF2AVscsfnGChFN9X5hJkz8bhLLpKdZFsafgEjGwj1jKoASrEyqIp3zx/OysOa+0/MijWMr5+SUWc6HyiiyZrZwZkWaPZEeksd/CiAuaxvdLIkO/2HiLngQQDDvS6XBpxXL23BnuJXWEqaI9m/yOiD/Rw4PlLEB6UlqE7gaVYzQ+9oq8xpFAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(86362001)(2906002)(2616005)(5660300002)(41300700001)(1076003)(36756003)(8676002)(4326008)(66556008)(6916009)(966005)(26005)(83380400001)(8936002)(6506007)(316002)(6512007)(82960400001)(478600001)(6666004)(66476007)(38100700002)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPocBWPT1KFKdEbQcNzfg5sF51EPukm7jXs3G91LRC4Ka2aZXAbxgWqMvAjK?=
 =?us-ascii?Q?deSi37Ubi4FmzlAjod4SbvvJia4aEg33dfc8Q1UsrghUE64PqH0C9nV28Owi?=
 =?us-ascii?Q?cjk+PmDUEM3prijwHRyyoQ2KJ951+r1b5H5pg3q+BTO7U0qvt4wW1habU/1p?=
 =?us-ascii?Q?0hS82hkt269SAFogQd7wmcYSHr4sbSzGT/rsGd5t5vOXUXBpoy6LidljB6EH?=
 =?us-ascii?Q?NjA+eSiNC3grpR8r9rxUOXKcR+YyTkgSpWL19iX49qelPXDsSvRuz6M6DFby?=
 =?us-ascii?Q?SygG5K2FtnE/ez0HJb980RBG4PIN4FFz/re16fFHC1MWxFmupAe4o6x9EVZE?=
 =?us-ascii?Q?70XBaZUOhd+LgpZav0IX0z/hB2JVZLZLiCc6gY//X8ObGWIDHZNbmqSnEvOI?=
 =?us-ascii?Q?eLVmpqrGTIOM674gxTGOaX+xb3QU1MDfAaU1Q+YUNVUEn5PFOZB2QMRFhMmi?=
 =?us-ascii?Q?RrsHlF3qBMh7QvmGGp62ri0BZlYgR9qyQpUlblz24ZDq2Y3u6xM4nS4n6xwO?=
 =?us-ascii?Q?szzKI9z6YxLB7HSziR4NxMINGnqVQqJf/AdPZkgQdez2bM629VreBM32BqNP?=
 =?us-ascii?Q?Nlc+cN2kKiiiu1tr8x18bZJv52YVxLfIwYmZGKL44DF29d27a8JoIHEZhrWY?=
 =?us-ascii?Q?lwnf4/tB7//++qpQysvtKf8Zc0eyefq6X2H4aThxcZUM0Ryk0fs5Xaz1DXI4?=
 =?us-ascii?Q?dLVTDn43mppHH4fdyHliZAuu0u3DlUEYGNlCkqFdMUf6DmN38f0kfSXNqCJi?=
 =?us-ascii?Q?o5kiV6wD+q+bdiYWOyeCN0iwkTCF7QD2rdUuomBdpVZ6RnJfbybirfz3TcIU?=
 =?us-ascii?Q?1C73ym519XrvTL2NFv25jkmTQAOqydAsLSZxc3wF0kkWsLoPYOZub9mxtrr8?=
 =?us-ascii?Q?T5j9knwLXy6wSt9FJXszxhogO+MdKc2abe/NZ036ifEOacid4JVM99NLW7Da?=
 =?us-ascii?Q?ncF715yQA2lOR3VjsuC67NvQWsNaW7FGtDsBimA0jY1ZYJ+McHoo7YROl3tx?=
 =?us-ascii?Q?E7Af3n0ij/Gq2i8RSinsKLAP+a4Oh3iZ9pHhZ/bXWWybkCAGRh0V8yF2nVrJ?=
 =?us-ascii?Q?m/2aJxFA9e6S9JDbGYSq4JX8iMstFWZEYr2oXhWIrtjPNE2SKusdZPfFhLlc?=
 =?us-ascii?Q?wGYWOQLcg+UZbGzH2VReV5CjIBlUyS2ABw3CRRSVrQJO9F954n5BNYqenRes?=
 =?us-ascii?Q?BwTdLe5cpSEsTxJlJJFYzwZsXOo2hn2RX+kH853EMH+sh8UZbnPjzB8W9q3k?=
 =?us-ascii?Q?DzS3IZoeIe7mej8Mi0xbz5DzURhUtN68oBW4O2Jx9SQrLFadeqSlmIzszxGc?=
 =?us-ascii?Q?Ogm5D0udrVFGLxwu1/XHszVB15G93n5MbRZnt0Iibv+OpIPeePAskMlHlUX2?=
 =?us-ascii?Q?+SHiAVmdS+OZNan3ak7uy7blKEZ66Au8jRajGhR1pwZDc2/UrDU6rEfSPWKW?=
 =?us-ascii?Q?SNCRVePtgnICokjwoMKtoeEWG3UnXrJOxllu2G/yibvfb5UeCnHlLXgUDRrm?=
 =?us-ascii?Q?pAIJf0e01G6lpDilej5/1b5vRYBCUwkv9cFaOooQRLnFTEwAKDID9lbPLCYg?=
 =?us-ascii?Q?4qL6f43sPqiUfMCDXLxgLduNu2xZ+wbKD0/ZgyLIfJ9JMuTwgdkkmQF/iKXc?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58878d69-ea1d-419d-a000-08dbe677259a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:39:21.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JRhKVwqAltlz6lpB2rk5E9c8qOJvqtzhqtSFPYlnfJgkERRtWW5ioJKefADcxBRPMJ2Sdl8TFWnUCp9z9ayPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: c8c183493c1dcc874a9d903cb6ba685c98f6c12a ("[RFC] workqueue: allow system workqueue be used in memory reclaim")
url: https://github.com/intel-lab-lkp/linux/commits/Junxiao-Bi/workqueue-allow-system-workqueue-be-used-in-memory-reclaim/20231108-093107
base: https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git for-next
patch link: https://lore.kernel.org/all/20231108012821.56104-1-junxiao.bi@oracle.com/
patch subject: [RFC] workqueue: allow system workqueue be used in memory reclaim

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161556.59af3ec9-oliver.sang@intel.com


[    6.524239][    T9] WARNING: possible circular locking dependency detected
[    6.524787][    T9] 6.6.0-rc6-00056-gc8c183493c1d #1 Not tainted
[    6.525271][    T9] ------------------------------------------------------
[    6.525606][    T9] kworker/0:1/9 is trying to acquire lock:
[ 6.525606][ T9] ffffffff88f6f480 (cpu_hotplug_lock){++++}-{0:0}, at: vmstat_shepherd (include/linux/find.h:63 mm/vmstat.c:2025) 
[    6.525606][    T9]
[    6.525606][    T9] but task is already holding lock:
[ 6.525606][ T9] ffff888110aa7d88 ((shepherd).work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2606) 
[    6.525606][    T9]
[    6.525606][    T9] which lock already depends on the new lock.
[    6.525606][    T9]
[    6.525606][    T9] the existing dependency chain (in reverse order) is:
[    6.525606][    T9]
[    6.525606][    T9] -> #2 ((shepherd).work){+.+.}-{0:0}:
[ 6.525606][ T9] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 6.525606][ T9] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 6.525606][ T9] process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:82 kernel/workqueue.c:2629) 
[ 6.525606][ T9] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 6.525606][ T9] kthread (kernel/kthread.c:388) 
[ 6.525606][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.525606][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    6.525606][    T9]
[    6.525606][    T9] -> #1 ((wq_completion)events){+.+.}-{0:0}:
[ 6.525606][ T9] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 6.525606][ T9] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 6.525606][ T9] start_flush_work (kernel/workqueue.c:3383) 
[ 6.525606][ T9] __flush_work (kernel/workqueue.c:3406) 
[ 6.525606][ T9] schedule_on_each_cpu (kernel/workqueue.c:3668 (discriminator 3)) 
[ 6.525606][ T9] rcu_tasks_one_gp (kernel/rcu/rcu.h:109 kernel/rcu/tasks.h:587) 
[ 6.525606][ T9] rcu_tasks_kthread (kernel/rcu/tasks.h:625 (discriminator 1)) 
[ 6.525606][ T9] kthread (kernel/kthread.c:388) 
[ 6.525606][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.525606][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    6.525606][    T9]
[    6.525606][    T9] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[ 6.525606][ T9] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 6.525606][ T9] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868) 
[ 6.525606][ T9] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 6.525606][ T9] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 6.525606][ T9] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:489) 
[ 6.525606][ T9] vmstat_shepherd (include/linux/find.h:63 mm/vmstat.c:2025) 
[ 6.525606][ T9] process_one_work (kernel/workqueue.c:2635) 
[ 6.525606][ T9] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 6.525606][ T9] kthread (kernel/kthread.c:388) 
[ 6.525606][ T9] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.525606][ T9] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    6.525606][    T9]
[    6.525606][    T9] other info that might help us debug this:
[    6.525606][    T9]
[    6.525606][    T9] Chain exists of:
[    6.525606][    T9]   cpu_hotplug_lock --> (wq_completion)events --> (shepherd).work
[    6.525606][    T9]
[    6.525606][    T9]  Possible unsafe locking scenario:
[    6.525606][    T9]
[    6.525606][    T9]        CPU0                    CPU1
[    6.525606][    T9]        ----                    ----
[    6.525606][    T9]   lock((shepherd).work);
[    6.525606][    T9]                                lock((wq_completion)events);
[    6.525606][    T9]                                lock((shepherd).work);
[    6.525606][    T9]   rlock(cpu_hotplug_lock);
[    6.525606][    T9]
[    6.525606][    T9]  *** DEADLOCK ***
[    6.525606][    T9]
[    6.525606][    T9] 2 locks held by kworker/0:1/9:
[ 6.525606][ T9] #0: ffff88810007cd48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2603) 
[ 6.525606][ T9] #1: ffff888110aa7d88 ((shepherd).work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2606) 
[    6.525606][    T9]
[    6.525606][    T9] stack backtrace:
[    6.525606][    T9] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-rc6-00056-gc8c183493c1d #1
[    6.525606][    T9] Workqueue: events vmstat_shepherd
[    6.525606][    T9] Call Trace:
[    6.525606][    T9]  <TASK>
[ 6.525606][ T9] dump_stack_lvl (lib/dump_stack.c:107) 
[ 6.525606][ T9] check_noncircular (kernel/locking/lockdep.c:2187) 
[ 6.525606][ T9] ? print_circular_bug (kernel/locking/lockdep.c:2163) 
[ 6.525606][ T9] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 6.525606][ T9] ? stack_trace_snprint (kernel/stacktrace.c:114) 
[ 6.525606][ T9] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 6.525606][ T9] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868) 
[ 6.525606][ T9] ? check_prev_add (kernel/locking/lockdep.c:3824) 
[ 6.525606][ T9] ? hlock_class (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228) 
[ 6.525606][ T9] ? mark_lock (kernel/locking/lockdep.c:4655 (discriminator 3)) 
[ 6.525606][ T9] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 6.525606][ T9] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 6.525606][ T9] ? vmstat_shepherd (include/linux/find.h:63 mm/vmstat.c:2025) 
[ 6.525606][ T9] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 6.525606][ T9] ? debug_object_active_state (lib/debugobjects.c:772) 
[ 6.525606][ T9] ? __cant_migrate (kernel/sched/core.c:10142) 
[ 6.525606][ T9] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:489) 
[ 6.525606][ T9] ? vmstat_shepherd (include/linux/find.h:63 mm/vmstat.c:2025) 
[ 6.525606][ T9] vmstat_shepherd (include/linux/find.h:63 mm/vmstat.c:2025) 
[ 6.525606][ T9] process_one_work (kernel/workqueue.c:2635) 
[ 6.525606][ T9] ? worker_thread (kernel/workqueue.c:2740) 
[ 6.525606][ T9] ? show_pwq (kernel/workqueue.c:2539) 
[ 6.525606][ T9] ? assign_work (kernel/workqueue.c:1096) 
[ 6.525606][ T9] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 6.525606][ T9] ? __kthread_parkme (kernel/kthread.c:293 (discriminator 3)) 
[ 6.525606][ T9] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) arch/x86/include/asm/bitops.h:239 (discriminator 1) include/linux/thread_info.h:184 (discriminator 1) include/linux/sched.h:2255 (discriminator 1) kernel/sched/core.c:6773 (discriminator 1)) 
[ 6.525606][ T9] ? process_one_work (kernel/workqueue.c:2730) 
[ 6.525606][ T9] kthread (kernel/kthread.c:388) 
[ 6.525606][ T9] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161556.59af3ec9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

