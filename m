Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A37D7D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbjJZHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJZHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:01:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90038191
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698303679; x=1729839679;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=uv9FtYcgbdgRQT4dXgCHpDo7YSoiekT69lEvYb+L1/c=;
  b=ODHWUfT+fysk3GT68RpFEK06kM84p+drny9N53qj9O9vOQiCGZApz5T+
   wNMkXua6Q8306a41QQtdUg3N4IoRBybYmqWQGAMI3MTtPUogpPehak2gV
   wZfXESi0N92vNWmd0FOHU2a+o8KhStnWiOFf0Nbo24UV7VdtwL3uubI0i
   Y5mYlVR8Zrobq5rq2TGHamgZIGMg7E0++gArVQ/zVHFU3R7/TmaahRi8u
   +Xb5QzKGpNmpcolIAm7goXyAZgJHkY0rV4vkrlAe88D+QkOgNj9SmCI5l
   e25pRBcpXxHTWRVqDMQSJ7kNN0QVFv8ZROmrlBaLZKdd2c3qFsMFHO3IY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9032429"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9032429"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735644411"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="735644411"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 00:01:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:01:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:01:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 00:01:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 00:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8MgvPci7Y1Tay8zOVnShjAKxhebhzlpXuCkTiapOc7KxTTJx9Xmloej9OfiPWDCdpISYlxYA+kJCjTNzsqPQHB9pSOx9i5g7OcJO7HWtidFCl1W/7jxiuxE6XTknQw6mTlZ/g+zfo8k8Sj/MNg+RkO1gQDUi/u2oUvDURAu38Dtl1pKTdcdvSp5B2uO1l6KtnW/PDiU8++rPw/su4jCxGaLFt1FypciMQs1YEQ/CDk+XkKsdd5SFS3nPtjMXmpM3e3IRZRn9DuaB4TY9cjqEFC3Aj1hu9vvRpoTGuKh5rnn5C2ANH+sLTfR72f+2Oi9HNE46SwJF7JUFkjStw9DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpicIwgCyMiXMnViXnPSuo/iTpi5AXFW+c+iuqI68cY=;
 b=RnX0jnIKD9WVnNd8OijQojYDfKugfVs5cILKyhfg28kJVkxjS4MhL4nJd4Z8y1+CMWeRlxojfJ713ZDsIwRptsLHCLONSfR/LyG9VXR7tsolcbD72dd8AD1S8PMpj3Ot9FXWp31skTpQL+nMgHOcwHIe62rkZ4u5Q4U2wNws+3W9jdXZ3cQIwGMfrBBdZHFl7qZvavuQ1JnbnJqLOvwe3XFwyeRX6l2UvfUi94RlwXOoBoCCvH1Nggd8zDRwKrEUYjBwnr4WkQ9LVj9iGCz0gGMZqbCQRsuI3WBFhQ3Kd/RPhNei6MAMKQzT3/GB89b5wvWQ6DUvFlQgIiJr+QPAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 07:01:09 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:01:09 +0000
Date:   Thu, 26 Oct 2023 15:01:00 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>, Uros Bizjak <ubizjak@gmail.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in
 lib/cmpxchg{8,16}b_emu.S
Message-ID: <202310261417.b269d37e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012161237.114733-2-ubizjak@gmail.com>
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c73804-76c7-402a-c9c3-08dbd5f154b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzDrHq5mU1FNCPxfh9vxl9G0pkUWWYHnYpDwKAMOsviRaH+BxpWa5qyzMK8T4SfzSAsRnKLqsWpRt0TLmHLFhkAq8fg+6NxS4uf65TquCGtxX6kdPr6fX0OmeuTuTR1V+u6yOevj29ILmql2HEj6gboaPoMoBK1ep7kKJ4sxEop1S93IKDA2xyJFYvOUQoHo7R6dPpQxk1lCvlHaYmsmcEZTR3iEUsl8DzY5bn/obViq8zihSd0xrHYneWPvZ8pLZkibWQykel7ub+mdtpiZl0a4u7rWwwe76R/jepVsmq9CSh64pmIGKJatSu+Kxs7VM17MdqM5eN6l8/7qZ9WD69r1iqpQoD0kVr6Q8UQ3lCuzas0+DniUdakCsfqrCd9zuEL3nX3WQss9PmrraJl6RLkZdOBhQJxQeLlo2OLr3vWI4RicoXveHFsdCGZ1WCiiXLb9xbfjz+Yp+pzoA+PQcqh7BW/hfOOO/5hU97BD024xDCmtXFtlCoyJvYcydd8Mbuq+WVamHnWv8N/CkfRcEykdYEKUaezfXpdCftzDU5BGRFZSSMsfkyDiBs5eTEejbUBIiDVgp9U+dtLTW3EogpqMbwOii/p5P2fgNNzpcqTNyiD4xQA9E/N3yATwFMH/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82960400001)(38100700002)(36756003)(86362001)(316002)(6916009)(66556008)(66946007)(2616005)(66476007)(6512007)(1076003)(6506007)(6486002)(966005)(7416002)(6666004)(2906002)(478600001)(8936002)(8676002)(4326008)(26005)(41300700001)(5660300002)(54906003)(83380400001)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8s36tBkVeoNXQoQEGWr+ut9MfXQG8GligSyry09JfwmR51N+5CX9XjS3cfT?=
 =?us-ascii?Q?r4+NIwX67v2VR2iu/FY+URmqrrefSwd7LkJCYhlPR6pHR770DYzOtIE/G7C9?=
 =?us-ascii?Q?cin6UmKZ15blBOGjHQw8+p6ORXC994UehoVGMsPjOq97A0+P6dvzUDhgFe5P?=
 =?us-ascii?Q?GRMmcJQWO53dZJlg/Kx00gGRnFw5IoraKyKWtWiBHSagBieGhLjE9tU3QqFr?=
 =?us-ascii?Q?bIlO0GSvXHWYaMOe3zbeYVotWPhbe1avZFy+DU9rcZwTkau1iYh8LQVYhdyv?=
 =?us-ascii?Q?y+VJqQaZXVkTukFTTMPbo2ppOEVfDluQAQsepAz8Z9exYXCyWJ/FT+G7PFtq?=
 =?us-ascii?Q?KS+lCQeckWWRDmQ5Pwul2bUkxT/QTjktDoL/1ol/yyABiue+XrYuvSQPlerK?=
 =?us-ascii?Q?NEXl8Se+4Ut0wfXOWAAS4YpxziZ/ctkxsWTBmUeoMB/qjpPVVdIKRH27tgP2?=
 =?us-ascii?Q?Zd5oFV1Ppb7uQCygiFCs24pVeDkhAG0AbSPv6y6hLGhUGh+4yBIpCGJ6RAEj?=
 =?us-ascii?Q?Rxtv4SbNhDg0xn1bWj+X1KQmi2cxgck3/iD0A2RDRrvpXW2g8iSoq6CJB/yZ?=
 =?us-ascii?Q?mElmsz7bli6wmWRad4zu6c37eWyQQeu5OUob6rT6NyFV1L+FAiKTrzeuLJFY?=
 =?us-ascii?Q?WIWp/W5dpd3dv3jxwdP7anXsqZUEIcSbLGj9Tkah40urXuq/G9oggOAErZSG?=
 =?us-ascii?Q?AwrfI4Tm1/SLZUZazbxT0dDweakRnmaSP8oytyUwmMDxG+MaKWgZxhlRMWkZ?=
 =?us-ascii?Q?BTPhurnuWfhrYI1bfLG6d69vp/m7xlDMhgj1h0wsZ22nugnfH3ybXZpx9rgE?=
 =?us-ascii?Q?+yvl8wJr1uwbdvSqMdgV1g533s1bINV8DvcC9vAvRzNW4WeELTLW/1AtVRDc?=
 =?us-ascii?Q?72T3/bP/u5nT5WAteglfdIT3mb+OMQwfuZwRW5mldimfNSUpeEQQsUh8hk77?=
 =?us-ascii?Q?HUh7qp34bNkIUmJR3edVPVkoZjy2ATd+uVaDDQGkFunxSdSetZgtxjrLNAz9?=
 =?us-ascii?Q?JhkuGQKmgVlVLwY9DKbGyUhyLUwELBzGMv9iZewhwbzKRc9yMoJNG4ZZ1b4d?=
 =?us-ascii?Q?TJJeSNQZyjC3N/qU2afI4a+mTq+Q1eUUsRUlhft0cILIHoZm19J4Ycp2+kZ2?=
 =?us-ascii?Q?+C2hAFFL+5tcin8qArzjPWjeUpRL9mPJjiDsT0kggCnhJfeF8BwmAEzsl9ZN?=
 =?us-ascii?Q?Innosxi+hMvv1v4nWFJ2H0iI8uWL/ezINsqSPWP1ayIZA578erO6wjoK4QqT?=
 =?us-ascii?Q?LkRMl1EOxhHo6tHnDsNAZ8lvZKiSTv8JN3FXxkIffUlngHMBZE1B7zLkKoZF?=
 =?us-ascii?Q?T6hU+MjN5QfWlMBTqba90xN9oe/hasn0h4bkgMHB8sQpLEJcUeC2w60eynjZ?=
 =?us-ascii?Q?h/GYhEhUMYB25NuISmIfuEMZUo4uqIHY/YRV4XqKzmiLU5HKJ02efT8LIGg+?=
 =?us-ascii?Q?0fC1YM7H8SLSKVoe4Ik+EVP372wvTDFdK68J4nDvJVUOTuG4i8RCIwGfBwv/?=
 =?us-ascii?Q?dq+AgCoV5n2aAbcOrcU+5B1hySkLknx3CarVHmvsAt1EABhNWtRCTJ0Zezg/?=
 =?us-ascii?Q?YWag7RBL5PTJf65dSxOL4ActHp7FmicsMThIgE3+utRsW14IKr1GO5Lz396W?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c73804-76c7-402a-c9c3-08dbd5f154b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:01:09.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2b/gKn1gHUm3jJRoIS05VhsxSLpv6SpaYjQTYqxYRcORPUWwtqlfSue1dzrD01xsAcXfNt63pLlVjcvKhisCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
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



Hello,

kernel test robot noticed "general_protection_fault:#[##]" on:

commit: 33c7952d925e905f7af1fb7628e48e03f59885da ("[PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S")
url: https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/x86-percpu-Use-explicit-segment-registers-in-lib-cmpxchg-8-16-b_emu-S/20231017-111304
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 92fe9bb77b0c9fade150350fdb0629a662f0923f
patch link: https://lore.kernel.org/all/20231012161237.114733-2-ubizjak@gmail.com/
patch subject: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 92fe9bb77b | 33c7952d92 |
+------------------------------------------+------------+------------+
| boot_successes                           | 7          | 0          |
| boot_failures                            | 0          | 7          |
| general_protection_fault:#[##]           | 0          | 7          |
| EIP:this_cpu_cmpxchg8b_emu               | 0          | 7          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 7          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261417.b269d37e-oliver.sang@intel.com


[    0.186570][    T0] stackdepot hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.187499][    T0] Initializing HighMem for node 0 (0002ebfe:000bffe0)
[    1.727965][    T0] Initializing Movable for node 0 (00000000:00000000)
[    1.943274][    T0] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    1.944313][    T0] Memory: 2896220K/3145208K available (16182K kernel code, 5537K rwdata, 11756K rodata, 816K init, 9720K bss, 248988K reserved, 0K cma-reserved, 2379656K highmem)
[    1.947172][    T0] general protection fault: 0000 [#1] PREEMPT
[    1.947900][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc1-00024-g33c7952d925e #1 8d4b014f9a0a85cc9a3f6a52ed8e88f1e431f74e
[    1.949317][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.950480][ T0] EIP: this_cpu_cmpxchg8b_emu (kbuild/src/consumer/arch/x86/lib/cmpxchg8b_emu.S:73) 
[ 1.951093][ T0] Code: ff ff ff 8d b4 26 00 00 00 00 66 90 83 c6 01 3c 3d 0f 95 c0 0f b6 c0 83 c0 01 e9 56 ff ff ff bf ff ff ff ff eb a6 cc cc 9c fa <64> 3b 06 75 13 64 3b 56 04 75 0d 64 89 1e 64 89 4e 04 83 0c 24 40
All code
========
   0:	ff                   	(bad)
   1:	ff                   	(bad)
   2:	ff 8d b4 26 00 00    	decl   0x26b4(%rbp)
   8:	00 00                	add    %al,(%rax)
   a:	66 90                	xchg   %ax,%ax
   c:	83 c6 01             	add    $0x1,%esi
   f:	3c 3d                	cmp    $0x3d,%al
  11:	0f 95 c0             	setne  %al
  14:	0f b6 c0             	movzbl %al,%eax
  17:	83 c0 01             	add    $0x1,%eax
  1a:	e9 56 ff ff ff       	jmp    0xffffffffffffff75
  1f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  24:	eb a6                	jmp    0xffffffffffffffcc
  26:	cc                   	int3
  27:	cc                   	int3
  28:	9c                   	pushf
  29:	fa                   	cli
  2a:*	64 3b 06             	cmp    %fs:(%rsi),%eax		<-- trapping instruction
  2d:	75 13                	jne    0x42
  2f:	64 3b 56 04          	cmp    %fs:0x4(%rsi),%edx
  33:	75 0d                	jne    0x42
  35:	64 89 1e             	mov    %ebx,%fs:(%rsi)
  38:	64 89 4e 04          	mov    %ecx,%fs:0x4(%rsi)
  3c:	83 0c 24 40          	orl    $0x40,(%rsp)

Code starting with the faulting instruction
===========================================
   0:	64 3b 06             	cmp    %fs:(%rsi),%eax
   3:	75 13                	jne    0x18
   5:	64 3b 56 04          	cmp    %fs:0x4(%rsi),%edx
   9:	75 0d                	jne    0x18
   b:	64 89 1e             	mov    %ebx,%fs:(%rsi)
   e:	64 89 4e 04          	mov    %ecx,%fs:0x4(%rsi)
  12:	83 0c 24 40          	orl    $0x40,(%rsp)
[    1.953397][    T0] EAX: c3c01100 EBX: c3c01180 ECX: 00000004 EDX: 00000003
[    1.954231][    T0] ESI: e52cd090 EDI: e52cd090 EBP: c2b4bf00 ESP: c2b4bec4
[    1.955060][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210082
[    1.955949][    T0] CR0: 80050033 CR2: ffdeb000 CR3: 031b5000 CR4: 00000090
[    1.956783][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.957641][    T0] DR6: fffe0ff0 DR7: 00000400
[    1.958190][    T0] Call Trace:
[ 1.958554][ T0] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:479) 
[ 1.959026][ T0] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 1.959480][ T0] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:697 kbuild/src/consumer/arch/x86/kernel/traps.c:642) 
[ 1.960101][ T0] ? exc_bounds (kbuild/src/consumer/arch/x86/kernel/traps.c:642) 
[ 1.960579][ T0] ? handle_exception (kbuild/src/consumer/arch/x86/entry/entry_32.S:1049) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261417.b269d37e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

