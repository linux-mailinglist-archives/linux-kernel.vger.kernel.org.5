Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BDF7E6321
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIFT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:19:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B822683
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699507192; x=1731043192;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=RZaow84lJ6ph8r2hBSUOQBVQbCm7I4rqOTgNUMcrTx4=;
  b=ZdRkvHQtsglWnGFF2PmeMxrYR40ESLf8ClaQdxZSGhSBQKwg8RgiLyVi
   UkETGQdL7oiX9qib3ascXOUU5czTc5rSihz+4pXFVxWsKH0WIiV12N260
   86n8YQqkR2vQzAlsQJqIrd/n/p1nqoEUiY6UCG4hLIiaDXT32ZzCM17ir
   QXGu7ZSAsCSa8XemA7y/tYuQxkK81bStCyWM5W6KmbQmtIAwXM588RM4/
   cpd+QEDC+lnlS7GTbrzSroVrDNv5ZsEkMrH1Xoj50xsvbzTsaO/HG/Rxc
   d1jmzI+ZRaRtANMBJ0avM6NqNC/I20o5aG9Pa/LhnxVgpSjFrSIuwvc/B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454222969"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="454222969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="936737098"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="936737098"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 21:19:50 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 21:19:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 21:19:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 21:19:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XySpqYjrP6DweGp/btmFnphFkQRM0rLWh5VBgdhwNIgB46x6FWNwMziL+86IdAJ7jC96NP65eFV9SjCyo6+CWp9ISn7x+xmYh1mOtdj7sxkNdn6tTA5jdKhy2IGTQ9aMghFIJWpYwAlS5ObNOtxwi4I14MRjCPrU52lVT79G/xCiKbjPVDty7DFNy5raG9JiVhgS+rXBT8GkQS4oFlB4WcJzoIoydaAmk+7leTUV7FnyQyGXHcblkIv1aVj3KveimJ7uq5E5pH6GqqMFjlhmk9QB3NjUL//jz7+qZAvnK7tO4s6Mz1Z2stUIJtO5ly03d3JdJLPrRlI7orHQExgwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZyTL8+dE+LEA9kYG6UhS6qtZNs3yzKi5sYxdYLYTQU=;
 b=Pg9OQ6cFbZ/GAozqqgIq1qK2e6kqc2EoI57Yx3HvrOrqnz8P3sPvYAupSUmZ7ZEVgygy14n9oSwIhk8hY/yIqT1MHHvt/y8uWFaeiTalSTicC/9RY3KBD5RBymm3hRe0MQ8w+7bi9FKodHn9WDwYvqe2akhk4GExtaVsGnkBZbUoinYwMjNI52riEKHEhGLFMmg3NhM525quT8hQxZ1dI8yg+t2/lFXPIy4HQObUSRoqR95SxdyuYUKbqaIRd5I61SATauslGE/5x19cLv4Xs/Oa174iRMdihID3mXWKR2ev+Lxp2+2M1Rd/iJzNGzoSx1ogNYaPeTIbNDlAN1+N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 05:19:46 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 05:19:46 +0000
Date:   Thu, 9 Nov 2023 13:19:38 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <greearb@candelatech.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ben Greear <greearb@candelatech.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH/RFC] debugobjects/slub:  Print slab info and backtrace.
Message-ID: <202311091331.f2eaf4f7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103013704.1232723-1-greearb@candelatech.com>
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: e9403f9f-3b75-4293-ac35-08dbe0e37caa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MVTzMbCZTRBlgxP/liy1Vd5E7sDoHgiOBmM1ebFr9FxrJq33iT2ndIVpBO8KuXx6hkOO/bmo4SNnkCulrpfA3kUjDRm06gza+g4b9hFIcX49pSVPBiljq7rrtJDhtoz245pgKN9ZtgvjoCYwqkFwgeRYa60d0LdFyGhclGVbw198/6pgk8FmAkwehhgtginMsyZfP+1ZPYJNt2v+E/tdEWmo70Xsxg4v6K2mdj5yRDqDrkg2kLZ3Sxzqhu79z6QfymOjjqN2YnPJokLZbnEwnJmgDHVlt1J3MTfrPe3sn3UtV8QPZvnTi+6yHC6T18T3dDRBkrvCZO77kMAsXOwHAAInFu74jV5xmgDy+nXtUv8uAW350rf9z8RR+yq3DdVQRXFElLYFvfFDB7CmSrVmis9SL6Dm4Q+iw4cI2w0IVeLsEdyeQyApCMk5lXhDUiAuXhpXWLVU0jiDU1je9y8OMkKnagk4XZIqLFEaPD82NBP3Y4YKk9lDMN+Pot/f8Ulkx2WTwDH2J9Q9vH77GPV3h+ar0791kK/iaS/6XIVEUSHnCi5UNd7x3JljarSz2yiQX1rKnSzYRUMlSTaldO/p0KEL5Z6AHwKX+0qmuu6u8BlbfId6DDimJzOeVT3MW+NzaH7/x3WgarzfjmaexDEvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(6506007)(8676002)(6486002)(966005)(4326008)(8936002)(6666004)(6512007)(5660300002)(26005)(107886003)(66556008)(1076003)(316002)(478600001)(6916009)(66476007)(66946007)(2616005)(2906002)(41300700001)(83380400001)(82960400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4DInFp40BPTAtjyExiBfZYzfhmHj3AiNMWgFw45MOu6wGheVOuNkABoVZjT?=
 =?us-ascii?Q?8LvRSgtUhHv/0RHfoWcd03jVtNpExxcxcbB6TUCHuMyvfTg4gE8eWPrnX8I3?=
 =?us-ascii?Q?hVedy4QeK7aBsBP87Bkt6/pHtV5QSBOQbRtZ0T6H6nfOGpZ79YcZMxuGBR++?=
 =?us-ascii?Q?jn3ZhwkvTzCpIC+vUZeR0I9dbjCWbKC09o+IgQF+4m32wHZMwiEgXJq1pzPB?=
 =?us-ascii?Q?pyPHTxagU1dFGF8ODUl3mKE1PTvpP30zt29+0doRuumYIrMp/sDr+p635OJ7?=
 =?us-ascii?Q?87ozrCeFVEvx/YTug/y+xtbAuEOZNOh5T64sJL7xFq2lHdfTn/azHi7OAKyQ?=
 =?us-ascii?Q?73TeE68y1qREhenY7tPhQ5WO+yzYIQ2YjqRXm376cgT2ZEiALQJQ7Opn07+K?=
 =?us-ascii?Q?d9QobvZJYmCiA043P/clV741vInqOcEbDnw7y8K/Esj8y65gAhFrJfe2eZEi?=
 =?us-ascii?Q?LestaLBsfQSW0YxS68uYnfWIaIlxniL46Nm/2xqDO/qHiRGzHmNwY5eLiBgO?=
 =?us-ascii?Q?dEC84yKFZchRfF/PL+dS5ddFdBjv7PSmcvnMrKwIOu2rLJzL6scTuSyJOZbG?=
 =?us-ascii?Q?WaxuWgl+O206nU88PvGKGd7SPTdP0nsMZXLFxw7dDT3phKI7GieBDHJvsPGu?=
 =?us-ascii?Q?q4fjvU02UN3Qmihzt+x/o01SRy1Qz/aO2WhBdYw9mmth6aCiV7TyUawQK6nI?=
 =?us-ascii?Q?FbL+1jBddSGMIOoZe9do4oC6WFxLGc7ylA9HmoH9/6e0pahklXRoQKuNoiFO?=
 =?us-ascii?Q?3IaL6o5+jLN7hPFb3ito05j2+OCe/X+BIZ1T1ZqruxpiYfR++RPFp5Fz4+Z6?=
 =?us-ascii?Q?X/wD+eMZga8J899h/PXvVzzvT8BQRO6BVdXV0RzJtKF6wQ+mz2QS65PHLkG5?=
 =?us-ascii?Q?cJ+jOU8UpQFCIjrllB0/VqWQdpDTJe5oeCjsFrnx0OGD8QZ3iFvo85THy8Cp?=
 =?us-ascii?Q?Hs+/lz0Qw8VpRoOlWaUUCh74JZOEdtcjvlyHDjvwDn8Zo90or8ZP7RWLnt9Z?=
 =?us-ascii?Q?BBn0TEQPo3KZLEQdzASN9mdZBr/epcjhAO8sAnNveW2UtEMB16qYSrZ0Y7tE?=
 =?us-ascii?Q?7g2aqQn2xU+OmoOH4Ezm3k05AAUofaFPHCxvlHDnJFlzWPHXkAr5Yr+EHyEM?=
 =?us-ascii?Q?yQcdKPrOKuSVsVQRZE8sm2QCfS16O+cXGdKACdUfkT4K1FJk54w9lJ0xhUQx?=
 =?us-ascii?Q?nfE9ERcsDQsHObjUwmqmdW4WkHTkpc2F1aCCbkrr8TeJqxwKs7Z2Zhkn8MGt?=
 =?us-ascii?Q?NiELejigYyCM7VmYmEAP0UOo+ecCbf+y+LZzbrlR/Ps5NVEVKcBOFxPtRyy/?=
 =?us-ascii?Q?nMJJrPszrfbl/bbZpjhypHXrVNrDHAICL6wlPuB8w+Xy5KB68TaPPIoMu04M?=
 =?us-ascii?Q?Hcmj+CkMB9usJtlGvUW6Hy0KidpKvaRMi57+a+WcamYMwclg47P/s1C9lEhH?=
 =?us-ascii?Q?LiJwNV3mBJnVsZhCHHBbMcuYjB2ebPg4hNJcApfUxfQcZ+drxw6fcYe7lBw+?=
 =?us-ascii?Q?PMe6FSRt7+6Lcrv3XbGTl3xZ63Wcx6Fc01zdjK7lQWfxD0V+w+AcPaugmYYX?=
 =?us-ascii?Q?pEmwW9dMRJQXMl3S8Ta/YUdA/qsWjXs4fiNsojEa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9403f9f-3b75-4293-ac35-08dbe0e37caa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 05:19:46.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwp+8EWlsn++v7sTlh5hvLCgRVC8h6Uaa3Ik9k56DxrcWTZj2NQCdmp42UoX2RKhuNAez/HSnydzgUHCHIp/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: d132b3de19193c996402718d76e63f797d4259a9 ("[PATCH/RFC] debugobjects/slub:  Print slab info and backtrace.")
url: https://github.com/intel-lab-lkp/linux/commits/greearb-candelatech-com/debugobjects-slub-Print-slab-info-and-backtrace/20231103-093945
base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
patch link: https://lore.kernel.org/all/20231103013704.1232723-1-greearb@candelatech.com/
patch subject: [PATCH/RFC] debugobjects/slub:  Print slab info and backtrace.

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue doesn't always happen for this commit in our tests (shows 39 times
in 50 runs), but keeps clean on parent.

90f055df112162fd d132b3de19193c996402718d76e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :51          76%          39:50    dmesg.WARNING:possible_recursive_locking_detected
           :51          76%          39:50    dmesg.WARNING:possible_recursive_locking_detected_swapper_is_trying_to_acquire_lock:at:__debug_check_no_obj_freed_but_task_is_already_holding_lock:at:__debug_object_init/0x



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311091331.f2eaf4f7-oliver.sang@intel.com


[    2.997328][    T1] WARNING: possible recursive locking detected
[    2.997927][    T1] 6.6.0-rc4-00006-gd132b3de1919 #1 Tainted: G                T
[    2.997927][    T1] --------------------------------------------
[    2.997927][    T1] swapper/1 is trying to acquire lock:
[ 2.997927][ T1] ffffffff85425790 (&obj_hash[i].lock){..-.}-{2:2}, at: __debug_check_no_obj_freed (lib/debugobjects.c:1057) 
[    2.997927][    T1]
[    2.997927][    T1] but task is already holding lock:
[ 2.997927][ T1] ffffffff8531abc0 (&obj_hash[i].lock){..-.}-{2:2}, at: __debug_object_init (lib/debugobjects.c:528 lib/debugobjects.c:667) 
[    2.997927][    T1]
[    2.997927][    T1] other info that might help us debug this:
[    2.997927][    T1]  Possible unsafe locking scenario:
[    2.997927][    T1]
[    2.997927][    T1]        CPU0
[    2.997927][    T1]        ----
[    2.997927][    T1]   lock(&obj_hash[i].lock);
[    2.997927][    T1]
[    2.997927][    T1]  *** DEADLOCK ***
[    2.997927][    T1]
[    2.997927][    T1]  May be due to missing lock nesting notation
[    2.997927][    T1]
[    2.997927][    T1] 1 lock held by swapper/1:
[ 2.997927][ T1] #0: ffffffff8531abc0 (&obj_hash[i].lock){..-.}-{2:2}, at: __debug_object_init (lib/debugobjects.c:528 lib/debugobjects.c:667) 
[    2.997927][    T1]
[    2.997927][    T1] stack backtrace:
[    2.997927][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.6.0-rc4-00006-gd132b3de1919 #1 2ef50b864013db82ef063ed2d8014756ac6c0996
[    2.997927][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.997927][    T1] Call Trace:
[    2.997927][    T1]  <TASK>
[ 2.997927][ T1] __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 2.997927][ T1] ? local_clock (arch/x86/include/asm/preempt.h:85 kernel/sched/clock.c:316) 
[ 2.997927][ T1] ? lock_release (kernel/locking/lockdep.c:223 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5435 kernel/locking/lockdep.c:5773) 
[ 2.997927][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 2.997927][ T1] ? __debug_check_no_obj_freed (lib/debugobjects.c:1057) 
[ 2.997927][ T1] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 2.997927][ T1] ? __debug_check_no_obj_freed (lib/debugobjects.c:1057) 
[ 2.997927][ T1] __debug_check_no_obj_freed (lib/debugobjects.c:1057) 
[ 2.997927][ T1] ? local_clock (arch/x86/include/asm/preempt.h:85 kernel/sched/clock.c:316) 
[ 2.997927][ T1] ? lock_release (kernel/locking/lockdep.c:223 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5435 kernel/locking/lockdep.c:5773) 
[ 2.997927][ T1] free_unref_page_prepare (mm/page_alloc.c:1146 mm/page_alloc.c:2312) 
[ 2.997927][ T1] ? find_held_lock (kernel/locking/lockdep.c:5243) 
[ 2.997927][ T1] free_unref_page (mm/page_alloc.c:2405) 
[ 2.997927][ T1] __stack_depot_save (lib/stackdepot.c:443) 
[ 2.997927][ T1] set_track_prepare (mm/kmemleak.c:620) 
[ 2.997927][ T1] ? pm_runtime_init (drivers/base/power/runtime.c:1731) 
[ 2.997927][ T1] ? device_initialize (drivers/base/core.c:3102) 
[ 2.997927][ T1] ? device_register (drivers/base/core.c:3706) 
[ 2.997927][ T1] ? subsys_register (drivers/base/bus.c:1230) 
[ 2.997927][ T1] ? container_dev_init (drivers/base/container.c:39) 
[ 2.997927][ T1] ? kernel_init_freeable (init/main.c:1327 init/main.c:1547) 
[ 2.997927][ T1] ? kernel_init (init/main.c:1439) 
[ 2.997927][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.997927][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[ 2.997927][ T1] lookup_object_or_alloc (lib/debugobjects.c:308 lib/debugobjects.c:624) 
[ 2.997927][ T1] __debug_object_init (lib/debugobjects.c:672) 
[ 2.997927][ T1] pm_runtime_init (drivers/base/power/runtime.c:1731) 
[ 2.997927][ T1] device_initialize (drivers/base/core.c:3102) 
[ 2.997927][ T1] device_register (drivers/base/core.c:3706) 
[ 2.997927][ T1] subsys_register (drivers/base/bus.c:1230) 
[ 2.997927][ T1] container_dev_init (drivers/base/container.c:39) 
[ 2.997927][ T1] kernel_init_freeable (init/main.c:1327 init/main.c:1547) 
[ 2.997927][ T1] ? wait_for_completion (kernel/sched/completion.c:149) 
[ 2.997927][ T1] ? rest_init (init/main.c:1429) 
[ 2.997927][ T1] kernel_init (init/main.c:1439) 
[ 2.997927][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.997927][ T1] ? rest_init (init/main.c:1429) 
[ 2.997927][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    2.997927][    T1]  </TASK>
[    3.000434][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    3.001966][    T1] futex hash table entries: 256 (order: 2, 24576 bytes, linear)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231109/202311091331.f2eaf4f7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

