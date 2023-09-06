Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09067935DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjIFHEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjIFHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:04:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D8CFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693983842; x=1725519842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G14cF44Uw1xUH5kTB1AnujOh6lULkU2b5wXp5mDpx1o=;
  b=RFwC8KpSXJDvmSPTt61MIL8WqVUVc67JU6FUK08XtkgtepxD8+OPgPP+
   L1baWckxLDYN7O8gPhJl7SNn0AiHQAuLlhIlC5Zi8710zzPcLNUPtvK4G
   usHD4E+Et3yG+HPsKj3mmwTEhbDkHgkZoHPDK6DNnB7OU9VLuGMW4s8Un
   josPf5Lkb2/nnWEvOCczeFtp6tJAEDYXkmw1XbJIQOyCAEAG5JGWz4FKM
   CW8SNeD4Ec+Wn5jOa3Q4dJI4mMnR+C041LOuDwzLsQEM38Kq0sGgmPxqs
   ML3o32A0XddLmTNrI36PPep/jf/gaw00UPtlfVRU3VwnXDPMxrYKNYkWY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374382855"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374382855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="915156035"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915156035"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 00:03:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 00:03:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 00:02:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 00:02:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 00:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuSqZ65eqrlP9XOa+uPqG6BoQgpp6HKbUGG7JU/AyoJw9mgBpLr/nGd/I343U8S28w+3YybTcdrRsGwy7qDar6S1C/+Puj0RSuLckZ9Ecx1Rf3vDuIOJHYIPAOWx8ZM2BeYRweatpd9RqKsL5A4nMDystK1NpyVYeSZLy2zEBF0PbqTsAjP6h+gjoKBC9dG0aB8xBajdMPsqDzaC5+m+FDb1eWZ9IYcJAih4Qrggw9xynckTIXlVZ9S04m+2z6UwwWbl5IWo7XWTu3TpVB4e02UZXpcCNx7EAiL/7BMMOTTZ8VLK0a0iNfLMbo+vq3G8JdPJFf0hWZlwkXsDN9HgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twwUkRgDb9j/EolVwFNlwn8Fb8wwtM33xuYagvs0F4A=;
 b=YCRA5u7XKbrg4Ayg3ru0nLBSmcc7KMkNjZAZJHDhM44mKUMaqQkCrIFuAD1Dhm8uogbK6S5sbqQ+haJWxdL7wqNGmVmaAwpBf8eKrqkzAr++xDGMNQFbNtx2E6CO+DF99ZfsSb+iTWTKdLjQt5e/qmWNDa1b4lb6IAaomGt6sQDGm+RFnPncdJgIhw5QB/GjYXokXWGCTV7F+W0GGh7dhVfaWfyVmPkemyKDR3c1neL4zECzRb/bqJLJCnK8a8o/dGLm9sSYE4XgpwaOvE+WtXNk9oSYKsgRcCVGLC2QqWnOt0uXyDz2v6sZvWaPz7D/MwmBP08OioebFCp3/jZ+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 07:01:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 07:01:59 +0000
Date:   Wed, 6 Sep 2023 15:01:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Qais Yousef <qyousef@layalina.io>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [qais-yousef:generalized-misfit-lb] [sched/fair] 64f5eb4cce:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202309061448.29151a04-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ed2196-d490-4b70-6826-08dbaea729a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aX/eU8cy/cMDuSdQQhMKS+9t1ytJTCrj7srrq1gEWc2NxR5bDHmVWyGSlroS5MhY1G7phdHkpkfnvQOmZMtgRFiKA+IpI+3RVZEVnC4GlV21PAnTQE5v1v3UAuXU6Sft4joNKwvNKgVePz44ci5Nt5htAaMHcprVFKDNkQqU4EqvJ3pFyES6z33p2P+oivZIktMo8+M+WY3BNepysinI+7SqfdcmwvKfVC4OYzXzHDq+B8IgXiSMTGJC9KrIQ9L5a+aUf0jfIVO9HgGVLOh58RYkjhkl8jVM4VLcRpPQ3iJyTtlJUTuW+nOtyy5NHLNY9FVtNMovUMFc5u70FbfzuSqjzsEOz6Ij8Nuoyl08eVQr2ChbgQwqQGcxsJYcersuuuW+LbrArNU01ZHxrB4IjHMrXVQ+aBgCTiLnzCOqD6FflUueZdWas0LD/3lATEajtAyf0z0EKFjeMJsfUTduEc0e0xFpwyNf9UYd3QF5Yq5va1cGsyU1KeKGnsTYx4OMWIwGi/Z6nuS+XdZq3t4XNhxF9OK7OtW98wx4g7gXwLMDh+CCAxZ2HPu32rHHhhthkHil6lZ8TbZH+AVWC0mH2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(8676002)(8936002)(4326008)(2616005)(41300700001)(26005)(1076003)(5660300002)(83380400001)(2906002)(6666004)(478600001)(45080400002)(966005)(316002)(6916009)(6512007)(6486002)(6506007)(66476007)(66556008)(66946007)(36756003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZ1V9hyjffcthB+tzdsLVExwcbsZZnyAa/Ys/DDDWsyBBh8t7u2I4xXH7/6K?=
 =?us-ascii?Q?ZhiPVdA64OT+6Roqn2W33pi9vI4zjP3aUIYmQM3b2QEq9GG5UloZ+EL+luYJ?=
 =?us-ascii?Q?O3vaKg2hJ2ru0Rze1HUL9NZyTaE3wRMVdd/ou4vGrZjuCyIlKJm2Kh4xouQk?=
 =?us-ascii?Q?SAqSoVai7rnyBBXsndZVJKWo/ViPEBYhi6HsUaivlVcgBrrGiGsp42n8CjWZ?=
 =?us-ascii?Q?4Wjn36cJrBUEMc/bMdwMG7xpq/mKyiD8mYQBDca3DxwLLsNJ/uv4lF/OuO+2?=
 =?us-ascii?Q?PX1ksDNoOdbeWe4vPQ73JyHJ+OnJRavgijXTiHbSRnRuFxmqZYlCuZpeT1TO?=
 =?us-ascii?Q?iyQ5qqVqERJlMTW+O89/U359iaECFJN2nsqZAt7KdXUBCrAL1u/LkENp9hT1?=
 =?us-ascii?Q?HOn15NisgyToK0NP6Cq2RmkUlwOHY8yA6SVhJosAE9B1Nd7wcpRuxhWfIM5E?=
 =?us-ascii?Q?YQ/TQ6gLCW2q7WDyob27cAtUAyiPZo21Wbu/eOzoLAuN13KPeSOOuT+tb42s?=
 =?us-ascii?Q?do+lycM63w61rzt/148JjsVn3DhUnyCMGpX3TKqVjhhb5TVkWUXawuGVydo4?=
 =?us-ascii?Q?+TbJxeC8c90O7LPYuoF8Y0g0Ctk6IvREhvI5OypsiWVl9OQTOCA4vPOjDuq6?=
 =?us-ascii?Q?HTOdZ/xrdT56FmHrrvMTvl8FL54xzOoo+Dam7E8rRAZAuKr19hUo88E1sJT4?=
 =?us-ascii?Q?vgzOtIIaO97pAO5WFiybIix/WdZSyBjoaKNlWDAXcTyLmZgFVJGQLjtc6hMv?=
 =?us-ascii?Q?zazIseiqHiTh4r8Xw5PZAm1WhwAAjJZ7b1EOs5X/XxxcM6caxFwj86VdDJlf?=
 =?us-ascii?Q?10gnWxGD7z5JUDgkc3QCbGZfDebV6s1p7m/t2bGV/ESJSG/DUvpjzTcwT1rI?=
 =?us-ascii?Q?amPs0fj/X4ehZ+WZBljOsMk1wZpVTjcYXeee3ISeMR6JBdEq43e+7Hpz2vPi?=
 =?us-ascii?Q?vv4NzLWtwpihXHOaBaZg7I/ksdCmcK/61W7MVirch8o+lQUUl43VLtfRBksF?=
 =?us-ascii?Q?pcAs0F0vbfoW/JZuEMbxtEwTWUeSUg/R2DIk81Jd8bVtoJYN010kceimw6WQ?=
 =?us-ascii?Q?htJv9HzER04aUZxCiA8WG89qjpFyHghowKO6bEQ/NgCPAalxtrUEArrcnNad?=
 =?us-ascii?Q?mCK43FxQvGPUKOlqxwCnTLtGukzWUTU65pI4gIgKm4thlp2jhK5PHN5sIiI5?=
 =?us-ascii?Q?pRVWNtVUBULEO1I0P698Dovg1QUJmXorvPE5Gv+7XuEbOKttLOFlt3nFJH44?=
 =?us-ascii?Q?8TW+5ATcrGRDjU1/ZuCV3u1S8YMoWNc2eMSvrDf5bug45ClL1CyMr2D+5kQr?=
 =?us-ascii?Q?Xhh+uRjGIiGH5RUHXB3Bv5AB3fzJ03xhvb78CCz01vP9wck0aKJQHlnQrntW?=
 =?us-ascii?Q?bPZ76zZ9s5qxJCe2y/RJKEScSpPYtBgfuAkT+QghvJMUJ5SBfzWqWWGDR+J+?=
 =?us-ascii?Q?lmTVoilLCgLKOcLQH8A/JPxg9hHqi2nnumzdtweanJC7wzIumcZ/ZURPDYO9?=
 =?us-ascii?Q?KRVhCAFxrD7JRavtrHucm6Y10cD3HgRjN/unhYwIUqDGd0Msg8WMfApVEhm9?=
 =?us-ascii?Q?PughncsU221PKLXj0W+pZGXnVWwg6FPyIMk/RRdP/wmSrb5L3JELA8QeIbEb?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ed2196-d490-4b70-6826-08dbaea729a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 07:01:58.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLKJG4fbPlikX0gTKHBUvjMAksrFO+Tg/3a6EX6BpAG0V9KeFzNEo6n+mLoQ6fb2SV0arsSDv4Hus/POpONRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
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

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 64f5eb4cce71383f75074bf14ef47668098d5218 ("sched/fair: Implement new type of misfit MISFIT_POWER")
https://github.com/qais-yousef/linux generalized-misfit-lb

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 7023f08515 | 64f5eb4cce |
+---------------------------------------------+------------+------------+
| boot_successes                              | 24         | 0          |
| boot_failures                               | 0          | 24         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 24         |
| Oops:#[##]                                  | 0          | 24         |
| RIP:load_balance                            | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 24         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309061448.29151a04-oliver.sang@intel.com


[    0.567014][    T2] BUG: kernel NULL pointer dereference, address: 0000000000000d10
[    0.567066][    T2] #PF: supervisor read access in kernel mode
[    0.567066][    T2] #PF: error_code(0x0000) - not-present page
[    0.567066][    T2] PGD 0 P4D 0
[    0.567066][    T2] Oops: 0000 [#1] SMP PTI
[    0.567066][    T2] CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.5.0-rc2-00048-g64f5eb4cce71 #1
[    0.567066][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.567066][ T2] RIP: 0010:load_balance (kernel/sched/fair.c:11002 kernel/sched/fair.c:11077) 
[ 0.567066][ T2] Code: 83 c4 02 00 00 48 c7 c0 c0 d9 02 00 48 89 1c 24 48 8b 5c 24 18 49 89 f8 48 89 44 24 10 4c 89 6c 24 20 45 89 fd 48 8b 44 24 60 <83> b8 10 0d 00 00 01 0f 84 20 03 00 00 31 d2 83 bc 24 84 00 00 00
All code
========
   0:	83 c4 02             	add    $0x2,%esp
   3:	00 00                	add    %al,(%rax)
   5:	48 c7 c0 c0 d9 02 00 	mov    $0x2d9c0,%rax
   c:	48 89 1c 24          	mov    %rbx,(%rsp)
  10:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
  15:	49 89 f8             	mov    %rdi,%r8
  18:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1d:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
  22:	45 89 fd             	mov    %r15d,%r13d
  25:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  2a:*	83 b8 10 0d 00 00 01 	cmpl   $0x1,0xd10(%rax)		<-- trapping instruction
  31:	0f 84 20 03 00 00    	je     0x357
  37:	31 d2                	xor    %edx,%edx
  39:	83                   	.byte 0x83
  3a:	bc 24 84 00 00       	mov    $0x8424,%esp
	...

Code starting with the faulting instruction
===========================================
   0:	83 b8 10 0d 00 00 01 	cmpl   $0x1,0xd10(%rax)
   7:	0f 84 20 03 00 00    	je     0x32d
   d:	31 d2                	xor    %edx,%edx
   f:	83                   	.byte 0x83
  10:	bc 24 84 00 00       	mov    $0x8424,%esp
	...
[    0.567066][    T2] RSP: 0000:ffffaeabc001bc78 EFLAGS: 00010007
[    0.567066][    T2] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000fffffffe
[    0.567066][    T2] RDX: 0000000000000000 RSI: ffff892280221f28 RDI: ffff8922803a9bc0
[    0.567066][    T2] RBP: ffffaeabc001bd68 R08: ffff8922803a9bc0 R09: ffff892280221f28
[    0.567066][    T2] R10: 00000000eac0c6e6 R11: 0000000000000000 R12: 0000000000000000
[    0.567066][    T2] R13: 0000000000000000 R14: ffffaeabc001bd28 R15: 0000000000000000
[    0.567066][    T2] FS:  0000000000000000(0000) GS:ffff8925afc00000(0000) knlGS:0000000000000000
[    0.567066][    T2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.567066][    T2] CR2: 0000000000000d10 CR3: 00000000a7e18000 CR4: 00000000000406f0
[    0.567066][    T2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.567066][    T2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.567066][    T2] Call Trace:
[    0.567066][    T2]  <TASK>
[ 0.567066][ T2] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 0.567066][ T2] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 0.567066][ T2] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1494 arch/x86/mm/fault.c:1542) 
[ 0.567066][ T2] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 0.567066][ T2] ? load_balance (kernel/sched/fair.c:11002 kernel/sched/fair.c:11077) 
[ 0.567066][ T2] ? load_balance (arch/x86/include/asm/jump_label.h:27 kernel/sched/fair.c:11074) 
[ 0.567066][ T2] newidle_balance (kernel/sched/fair.c:12146) 
[ 0.567066][ T2] pick_next_task_fair (kernel/sched/fair.c:8274) 
[ 0.567066][ T2] __schedule (kernel/sched/core.c:6005 kernel/sched/core.c:6515 kernel/sched/core.c:6660) 
[ 0.567066][ T2] schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) arch/x86/include/asm/bitops.h:239 (discriminator 1) include/linux/thread_info.h:184 (discriminator 1) include/linux/sched.h:2245 (discriminator 1) kernel/sched/core.c:6774 (discriminator 1)) 
[ 0.567066][ T2] kthreadd (kernel/kthread.c:735) 
[ 0.567066][ T2] ? __pfx_kthreadd (kernel/kthread.c:720) 
[ 0.567066][ T2] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 0.567066][ T2] ? __pfx_kthreadd (kernel/kthread.c:720) 
[ 0.567066][ T2] ret_from_fork_asm (arch/x86/entry/entry_64.S:298) 
[    0.567066][    T2] RIP: 0000:0x0
[ 0.567066][ T2] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[    0.567066][    T2] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[    0.567066][    T2] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.567066][    T2] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.567066][    T2] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    0.567066][    T2] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    0.567066][    T2] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.567066][    T2]  </TASK>
[    0.567066][    T2] Modules linked in:
[    0.567066][    T2] CR2: 0000000000000d10
[    0.567066][    T2] ---[ end trace 0000000000000000 ]---
[ 0.567066][ T2] RIP: 0010:load_balance (kernel/sched/fair.c:11002 kernel/sched/fair.c:11077) 
[ 0.567066][ T2] Code: 83 c4 02 00 00 48 c7 c0 c0 d9 02 00 48 89 1c 24 48 8b 5c 24 18 49 89 f8 48 89 44 24 10 4c 89 6c 24 20 45 89 fd 48 8b 44 24 60 <83> b8 10 0d 00 00 01 0f 84 20 03 00 00 31 d2 83 bc 24 84 00 00 00
All code
========
   0:	83 c4 02             	add    $0x2,%esp
   3:	00 00                	add    %al,(%rax)
   5:	48 c7 c0 c0 d9 02 00 	mov    $0x2d9c0,%rax
   c:	48 89 1c 24          	mov    %rbx,(%rsp)
  10:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
  15:	49 89 f8             	mov    %rdi,%r8
  18:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1d:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
  22:	45 89 fd             	mov    %r15d,%r13d
  25:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  2a:*	83 b8 10 0d 00 00 01 	cmpl   $0x1,0xd10(%rax)		<-- trapping instruction
  31:	0f 84 20 03 00 00    	je     0x357
  37:	31 d2                	xor    %edx,%edx
  39:	83                   	.byte 0x83
  3a:	bc 24 84 00 00       	mov    $0x8424,%esp
	...

Code starting with the faulting instruction
===========================================
   0:	83 b8 10 0d 00 00 01 	cmpl   $0x1,0xd10(%rax)
   7:	0f 84 20 03 00 00    	je     0x32d
   d:	31 d2                	xor    %edx,%edx
   f:	83                   	.byte 0x83
  10:	bc 24 84 00 00       	mov    $0x8424,%esp


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061448.29151a04-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

