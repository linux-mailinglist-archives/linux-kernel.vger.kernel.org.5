Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4980C7D678D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjJYJw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjJYJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:52:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483D189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698227561; x=1729763561;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+QsdbCCQPy3QgpaUPUc2FK6jziZQ3wfg3wZIElDZ0Tw=;
  b=AyrqplTeJE0PZUclIEp6Q/7ytBFreUGuAO+SuY9nvjNzwWcAMFOGOE84
   GolLnZXrhpPlcOnqGvxS6KzfeN3npGk92slYtYmj5ljH3caxaPscOPvZ0
   ShO+ONHIDNypfgDSmVPczo4bzZlfRMbA3U643GceBOLBAdZ5fspBZlyQu
   enCghnRQoBtUeSIbo1QXKBXOFDEDK8dHaY512sq2fIHBOuEty28Abftij
   NrkcAGQcH6h5QyUObHsrbwxfVeO3DpL1cCsLODChgqd463r2REDShMOPO
   yFezc/v3uyAdrpx7zCRVn+OLz4y3Gdl6NhXbwoxo3qCoZyzV21nz6VnS/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="387092543"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="387092543"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6480226"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 02:51:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 02:52:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 02:52:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 02:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+0y88bDLRf9iu4cFw/qRlvt+8YaSYlKqL1FEdx4VmYwthlBFsc5nCcyh59D6oxZR1/X6MCXAnUX3MRgLRS+Gk8sUvVe5jZux9nyrW8b4Kvb5S3LnNc+hRgU0SVrKYFA7Gd/57kMAbIWSSFOX4eCzbOH3/OMS72s4QJSe+eZM8/sTZZeZXPMjgUDZUM7FgAFqFuWNLe061cVmXMvvqb9j4rEu8/QJYKaoTmDhtb7dLo0djVw+YvjXqtzrmwfWRa7aPEcYQvdaQ/chPnWLpGi63xhaFLiOoyNmR+4qFlNopoi+HazzCQP1lP64mZ+pVN1SJEyZ+cyGoeSmxYAH2/6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJllKvv1W6mV789EA1Y4g7gh1rGaG1vJDfqfXpuRldU=;
 b=bcW+bFsnv3eR4q8r0I2s5UztsFVo3+VUq6o2NefBS5eI//8FF93VLiQKvp7hWGYx0ZD49k8m1ASZaBotaGpZ9xmsvvQNri1isf7NVV2ti3gEffpDWHJ9RkZYKbGSxwa3PpA+Az48BtdelZ8ClOpITybO93i7M9W73QhmgXMIBcWDm7ppJMc4nK1TTAnhcHNi9cFA1VhVJFBQU78QjI8iUaBMsPXu20WLTc+ttt3WLIhzCy8ShgVvwmzVvVf8fgwRiybCttBkHXN1M2cznaJ1got8muQLSHWg0IctBfnACkzZ4DknedHVcVK8++JyY6FymOIx//ydS69C+cGSif6X6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:52:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 09:52:26 +0000
Date:   Wed, 25 Oct 2023 17:52:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <liam.howlett@oracle.com>,
        <zhangpeng.00@bytedance.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
Message-ID: <202310251706.6e6f6c4a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009201639.920512-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: afcede6d-cd2a-4b98-e00f-08dbd5401815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWIzyPUqClHGhxreJOVA+RqsZhZj64S3rhZ8dNm/fIvwr7OZRm/448nTO92UNcKg9wrCRz2WCIapRKlHskzaM2Ch1ZC6CqdBpo35vRrKwFsvMwTpOKc6Ta+5/HRzWe3q16bSrBVHnqakLPaXSFekcVTvUkzXfYanLjaJMZrEy+9R/JyiTnwn7ZL+31RNCJ1ZKW8CdTjw+LJG2mbTkq/VAnq3fNTAFT5ZQNhmTpikr4ceAG+JevQmd+qoG393/4wCpxwLCHgIMIC2VlUw0GehqtlK8ExI+Hrl/VK6++CorSNJJW+q2B9FNflPfIByDqVE8pdg8WOMfp7u+ZelmdIxI5hRpx9BRuR+n6Zal+VVrnhlqGPDXwCtk8dVZZ0+8czf3cj/zfdtjtsmv+VK9PQuvLGQzzacsPzr1Xxj+Fn8YBZTRv9DAC9I05WjW8FPfHd8fWTsByYrgi0Rwj74Pz9VtKyv48RN/d262DgMWC0wzE7wsL8oddMPVecz+iSJ9gbi38tJKS2bI+Ks/NkFNJhijmFNJDDinQlNd4Ys+pHesdqzLzR92rbBDK7Kf6SE/wCzFKpLgqQLtNEquqzddVE/dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(36756003)(5660300002)(6666004)(966005)(66476007)(66946007)(86362001)(41300700001)(66556008)(478600001)(6916009)(6506007)(6486002)(6512007)(316002)(8936002)(8676002)(2906002)(30864003)(4326008)(38100700002)(2616005)(1076003)(107886003)(26005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pc3J6qtD9ZIsOLCf6hh7S7KEl+KonTU8DdhNAEKIQQuAWTh9/g+KqLtP8rff?=
 =?us-ascii?Q?l19HaLMNPQQVBbPWTtq12U+/9M7qLrdmugeLsbGkvBhstGdFUypk4b5gcI0R?=
 =?us-ascii?Q?krQvyHSm6xpXZz7FN1vKP6v/1YMgRtpFglkpWRnolbcZoJbo+VnwKh/NsWdZ?=
 =?us-ascii?Q?yqJoS4NL4KfvKpoa9cjJh0/ipEJ90soH/yy9zBx7YSfue2TgIipMXuVQG2TY?=
 =?us-ascii?Q?EwheugyKjpxgSoZqd8Yf/S48GnuSBhk4uJ8GZtdgR/JAeAh9ETEuhs0wR48W?=
 =?us-ascii?Q?fC97VgTXbqhoxqs/M6cl/wYENYRpGsdp4wxg8DBDR5tIzNOgXdodXYZ0h+iC?=
 =?us-ascii?Q?2ZzOuu8GZ8n0P5LBq4RyShmcsB9O6gyOOseb0rTINZBl35OjQkoYlR0UeTmZ?=
 =?us-ascii?Q?fAnQnPA4emCOEdeU8fK2B5qDMrE04f+f7GYEManjC8U7UO3nW1e0TCtQ3vHD?=
 =?us-ascii?Q?cyhgy1WnuvyLBV3aPSff5Rhdx5Vfd8PHYSyuQuVvZVh3I/Tzo54gRbbreClJ?=
 =?us-ascii?Q?AmN8iCgsZ2tUqqcoJjqUSvxGLc8faUcY5g/IFB3ciznKlcUcwsZHRvKP2Byy?=
 =?us-ascii?Q?09uV8WB5JaYKPhEi7hQBtLemwB3spEgCMf463PYx/LfyZAKy51XnUEqwhPcg?=
 =?us-ascii?Q?3ieDE565T2zJgVCp0CyLKPZsGtxkUsjKDFCGIpkeyzLV3th8PJi8pPDlB1p4?=
 =?us-ascii?Q?vYknb0nIhOGbIfEct6/ydDs1PYv001RmnK3bC0e/s49lAGZPWUieSP2LAppD?=
 =?us-ascii?Q?5xscfGbsKhqBUCR/67v50vdOAGcjBTOHIKzolrT8d0B++puAf7kegOR/fvWY?=
 =?us-ascii?Q?O3oOPgynSZ+817YcVnQjBFIXqVZaxAU7+xtOE2vrXC1q+fAWmkCH2fMNzDeP?=
 =?us-ascii?Q?+f1cKSx/yWePMKf4+XzDiWZyk9eRHRClZhVClQOz1tmwqHWz+iqGjBfAuN/b?=
 =?us-ascii?Q?JTzvi5I6rIr1frJj3tjxLe1HDjD6QneM3RSvbVFxpqqjQBX9qxxKn154FdnX?=
 =?us-ascii?Q?ec/e6GMAXhoG0nG+rF6cCLVYMIs+KVJpbXSQ2X0wUEi7egmHZrB/AZRxtvuI?=
 =?us-ascii?Q?fklpObzhTzLLcmAF7Y4sCviTzTkGeIiEfrlgDBCn1BWknGNzmJTVq/CAA1/L?=
 =?us-ascii?Q?kbCJOccDFd1lhZtd0rIrU9TRcV8yw3Bbg6b6G09Xc2265jhLDo27CdPrnzEd?=
 =?us-ascii?Q?Fcpizb8MCBbz4d5pM+aLmMBThRRJR2pELn/+Z81bgkbw1/8MsfWNkWUFdckB?=
 =?us-ascii?Q?0XszmjN6/5+CwyQikpjea7/hBtxIT+UUKvgenNoJFSd3SBL0isG8IJo/sybZ?=
 =?us-ascii?Q?WxQAiE3uV9t5ngRDkE2Cn8P611mzMauLPUI1OBv2jJW3kV35/cm1eo/vZVpi?=
 =?us-ascii?Q?2Vac3jkHdfzhqgCu9osFyQHbMLcmAY/gQOgYDn+oZI018RZ0O350bRmeg+ZQ?=
 =?us-ascii?Q?zwvFGiia4xrikqNIHIXtKVddTGFvbvXkQrw2UnW0NrR2GGTe/zmF+NZpEGBf?=
 =?us-ascii?Q?hj7Ul7yWNIK1AQwvg0wIaDmYJ3s5ahm6jlQgs9kJkdnYGLAR0r02tWws6+6+?=
 =?us-ascii?Q?oQkjfM5IVIGPqMACc7aqtyqmlyN88+O0zoAogmXu/pKWGfspH0+IUFZYk251?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afcede6d-cd2a-4b98-e00f-08dbd5401815
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:52:26.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0m/OYiY3tO4Llxoqdo1MiLInTQ9rYqXtfCBHFwgp/D6dKN5ZYs812rEIyGRuCuS0JxUbq7XL7kZ3rbSH6RVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: 9116baa49536116f013d691d2178c520959f46c2 ("[PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()")
url: https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-mas_prealloc_calc/20231010-041859
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20231009201639.920512-3-sidhartha.kumar@oracle.com/
patch subject: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------------+------------+------------+
|                                                                                    | 9cbebad6db | 9116baa495 |
+------------------------------------------------------------------------------------+------------+------------+
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h      | 0          | 7          |
| WARNING:suspicious_RCU_usage                                                       | 0          | 7          |
| include/linux/rcupdate.h:#Illegal_context_switch_in_RCU_read-side_critical_section | 0          | 7          |
+------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310251706.6e6f6c4a-oliver.sang@intel.com


[   12.322393][    T1] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[   12.324008][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
[   12.325486][    T1] preempt_count: 1, expected: 0
[   12.326345][    T1] 1 lock held by swapper/1:
[ 12.327164][ T1] #0: c2b52570 (&mt->ma_lock){+.+.}-{2:2}, at: check_root_expand+0x46/0xac0 
[   12.328850][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.6.0-rc4-00400-g9116baa49536 #1
[   12.329034][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.329034][    T1] Call Trace:
[ 12.329034][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 12.329034][ T1] dump_stack (lib/dump_stack.c:114) 
[ 12.329034][ T1] __might_resched (kernel/sched/core.c:10188) 
[ 12.329034][ T1] __might_sleep (kernel/sched/core.c:10117 (discriminator 17)) 
[ 12.329034][ T1] kmem_cache_alloc (include/linux/sched/mm.h:306 mm/slab.h:705 mm/slub.c:3460 mm/slub.c:3486 mm/slub.c:3493 mm/slub.c:3502) 
[ 12.329034][ T1] ? mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 12.329034][ T1] mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 12.329034][ T1] mas_node_count_gfp (lib/maple_tree.c:1347) 
[ 12.329034][ T1] mas_store_gfp (lib/maple_tree.c:256 lib/maple_tree.c:5491) 
[ 12.329034][ T1] ? check_empty_area_fill+0x3d0/0x3d0 
[ 12.329034][ T1] check_root_expand+0x162/0xac0 
[ 12.329034][ T1] maple_tree_seed (lib/test_maple_tree.c:3577) 
[ 12.329034][ T1] ? check_gap_combining+0xdf8/0xdf8 
[ 12.329034][ T1] do_one_initcall (init/main.c:1232) 
[ 12.329034][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 12.329034][ T1] kernel_init_freeable (init/main.c:1551) 
[ 12.329034][ T1] ? rest_init (init/main.c:1429) 
[ 12.329034][ T1] kernel_init (init/main.c:1439) 
[ 12.329034][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 12.329034][ T1] ? rest_init (init/main.c:1429) 
[ 12.329034][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 12.329034][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   12.353802][    T1]
[   12.354345][    T1] =============================
[   12.355188][    T1] WARNING: suspicious RCU usage
[   12.356056][    T1] 6.6.0-rc4-00400-g9116baa49536 #1 Tainted: G        W       T
[   12.357413][    T1] -----------------------------
[   12.358272][    T1] include/linux/rcupdate.h:375 Illegal context switch in RCU read-side critical section!
[   12.359905][    T1]
[   12.359905][    T1] other info that might help us debug this:
[   12.359905][    T1]
[   12.361711][    T1]
[   12.361711][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   12.363058][    T1] 2 locks held by swapper/1:
[ 12.363877][ T1] #0: c2ad5938 (rcu_read_lock){....}-{1:2}, at: check_mas_store_gfp+0xa9/0x1b0 
[ 12.365646][ T1] #1: c3965e84 (&mt->ma_lock){+.+.}-{2:2}, at: check_mas_store_gfp+0x104/0x1b0 
[   12.367338][    T1]
[   12.367338][    T1] stack backtrace:
[   12.368430][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G        W       T  6.6.0-rc4-00400-g9116baa49536 #1
[   12.369129][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.369129][    T1] Call Trace:
[ 12.369129][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 12.369129][ T1] dump_stack (lib/dump_stack.c:114) 
[ 12.369129][ T1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6713) 
[ 12.369129][ T1] __might_resched (include/linux/rcupdate.h:375 kernel/sched/core.c:10149) 
[ 12.369129][ T1] __might_sleep (kernel/sched/core.c:10117 (discriminator 17)) 
[ 12.369129][ T1] kmem_cache_alloc (include/linux/sched/mm.h:306 mm/slab.h:705 mm/slub.c:3460 mm/slub.c:3486 mm/slub.c:3493 mm/slub.c:3502) 
[ 12.369129][ T1] ? mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 12.369129][ T1] mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 12.369129][ T1] mas_node_count_gfp (lib/maple_tree.c:1347) 
[ 12.369129][ T1] mas_store_gfp (lib/maple_tree.c:256 lib/maple_tree.c:5491) 
[ 12.369129][ T1] check_mas_store_gfp+0x14b/0x1b0 
[ 12.369129][ T1] maple_tree_seed (lib/test_maple_tree.c:3646) 
[ 12.369129][ T1] ? check_gap_combining+0xdf8/0xdf8 
[ 12.369129][ T1] do_one_initcall (init/main.c:1232) 
[ 12.369129][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 12.369129][ T1] kernel_init_freeable (init/main.c:1551) 
[ 12.369129][ T1] ? rest_init (init/main.c:1429) 
[ 12.369129][ T1] kernel_init (init/main.c:1439) 
[ 12.369129][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 12.369129][ T1] ? rest_init (init/main.c:1429) 
[ 12.369129][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 12.369129][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   15.220029][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   16.033920][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   17.655206][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   19.245918][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   36.522020][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   37.994914][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   38.766533][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   41.775652][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   43.236341][   T35] torture_spin_lock_write_delay: delay = 24 jiffies.
[   44.106914][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   46.776934][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   47.165604][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   49.209209][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   50.316931][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   51.511048][   T34] torture_spin_lock_write_delay: delay = 25 jiffies.
[   54.564928][   T35] torture_spin_lock_write_delay: delay = 25 jiffies.
[   59.372367][    T1] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[   59.374045][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
[   59.375483][    T1] preempt_count: 1, expected: 0
[   59.376310][    T1] 1 lock held by swapper/1:
[ 59.377090][ T1] #0: c2b52570 (&mt->ma_lock){+.+.}-{2:2}, at: check_empty_area_fill+0xe5/0x3d0 
[   59.378744][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G        W       T  6.6.0-rc4-00400-g9116baa49536 #1
[   59.380409][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   59.381080][    T1] Call Trace:
[ 59.381080][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 59.381080][ T1] dump_stack (lib/dump_stack.c:114) 
[ 59.381080][ T1] __might_resched (kernel/sched/core.c:10188) 
[ 59.381080][ T1] __might_sleep (kernel/sched/core.c:10117 (discriminator 17)) 
[ 59.381080][ T1] kmem_cache_alloc (include/linux/sched/mm.h:306 mm/slab.h:705 mm/slub.c:3460 mm/slub.c:3486 mm/slub.c:3493 mm/slub.c:3502) 
[ 59.381080][ T1] ? mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 59.381080][ T1] mas_alloc_nodes (lib/maple_tree.c:160 lib/maple_tree.c:1265) 
[ 59.381080][ T1] mas_node_count_gfp (lib/maple_tree.c:1347) 
[ 59.381080][ T1] mas_store_gfp (lib/maple_tree.c:256 lib/maple_tree.c:5491) 
[ 59.381080][ T1] check_empty_area_fill+0xab/0x3d0 
[ 59.381080][ T1] maple_tree_seed (lib/test_maple_tree.c:3837) 
[ 59.381080][ T1] ? check_gap_combining+0xdf8/0xdf8 
[ 59.381080][ T1] do_one_initcall (init/main.c:1232) 
[ 59.381080][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 59.381080][ T1] kernel_init_freeable (init/main.c:1551) 
[ 59.381080][ T1] ? rest_init (init/main.c:1429) 
[ 59.381080][ T1] kernel_init (init/main.c:1439) 
[ 59.381080][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 59.381080][ T1] ? rest_init (init/main.c:1429) 
[ 59.381080][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 59.381080][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   59.571154][    T1] maple_tree: 3807933 of 3807933 tests passed
[   59.572831][    T1] test_memcat_p: test passed
[   59.590510][    T1] test_meminit: all 11 tests in test_pages passed
[   59.621976][    T1] test_meminit: all 40 tests in test_kvmalloc passed
[   60.207905][    T1] test_meminit: all 70 tests in test_kmemcache passed
[   60.217750][    T1] test_meminit: all 10 tests in test_rcu_persistent passed
[   60.219088][    T1] test_meminit: all 131 tests passed!
[   60.220126][    T1] ref_tracker: reference already released.
[   60.220912][    T1] ref_tracker: allocated in:



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251706.6e6f6c4a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

