Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E577F78E4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbjHaC1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjHaC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:26:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A6A1BF;
        Wed, 30 Aug 2023 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693448812; x=1724984812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0HFXW+aQXS3/SAm+A0MJedsea9Gtejtv5bN8vQeixLA=;
  b=J2uro+l0VOYFbRoGUddUd1vBDY4zhHIUXG71cMicBwlyv4KjW0buwTwb
   T+FuNOJJVMeWYkFwYt57r8Vb4MGUOjLZ9pCZaCHCwFmmSlb2EfE46AqCl
   +DdO/JHyt4jYja8fW1zq+x8gTc9Cvq/uq/Pva8goePZ4QtoaOUOxMFwdS
   MPHmXw1b5cC/hWtg1PIVfRdlOX+3jeqkdkfEnIY4IKh/0JsuddIl/GgBV
   RvLy9xGjdzrirbRaf4tY/o5KMilOX2yA2cz7npz70hnKgYJ9/gk4uel5v
   xd+Fb1B2paJOfLyAsVeF2NF6jQwUqHFlRoJzdrRPoNWPtw4GJPaQ8WikL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379544763"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="379544763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768627620"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="768627620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 19:26:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 19:26:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 19:26:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 19:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+oiR7AaXMHui3WSrQbh4spFDkwQ7UR+KSAz+jYJO7uXX13pKjWouVW0aQXFIknLdc/ogIi1KSMgTc9mcqOfHIb8uLhO+X+e8nCphhXlBHPAPulWbs18Hx9hpOdw52OYtK2ANuMtgnLJRwNAJgN6DhXVcEAN/ABMosqwI8jXuYIIxoVvaQe8vwtEw756CJx7IO/ywxbyc4N8ELD5MpiKmABPI3daVjALFfg1nsrMRypIFznAtA5K3zFH7bYgab4wETyVYl/OInu+2Dmne+Moxpbll4tJwtOkqpk3SESFZ07IjOshDyDkEh6EPE//DNx3OFrlPp00CogsTDbnzhUvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqxYbeqcrQU+GeuKgxcyzJI3EIn1/ZJ1bCw5IxZitt0=;
 b=ByJ23++zPDqHSuELs+d6IvZMv2yi3yIqoRMKftBIgQd7KWcjHzc41orWK0nsFb/M5GD6uD/EPECJclqYfMS78boacyw3ixQcl4muDw+QxFbDEKYHg+qA3lr5OGNnifj802n1lZC9fH+M7YOEDdPBXN11LpgE1Z7+fPEOKCn2znF/dFpWsZjMNpqKlq9n8FACyE84O7gwv2ztiNerppRbqSjdvLG0aRY/tVTCsJUJJPyF5qfA40gJQKcG3jek2NpdFMyZtRcjEoecYTa4pgsPa1OejEztSpv5Va+95Kb0USktjt1hsJj3K2xb1GXRfbHCfpkNqoEj5K49HAgUTOcDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 02:26:48 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 02:26:48 +0000
Date:   Thu, 31 Aug 2023 10:26:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing/synthetic]  ddeea494a1:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202308311026.b4bc6948-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:820::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: beacb58a-1e00-4964-2ffd-08dba9c9ba0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VoTyokFSjzUYOgQYPEuEQss8zOCGX61M5X322mkqVqj5iw1hwXPD5LgjHV2+ULmICmBNAOJ6LDfsw4iO7UZCUOi8+l/2qoBiAKV4FdiqxEbsxCZpE/1bmqiCD0hWCTaoZFNXOVsvBY68hgVVKZyl7O7Dq9P3+AV8+ToaNljboskgrGNT+sUabwuCjZzRVawCEdlcbdenLpiIuML0Lxit2vTvKInfFtA8a2HmrCuDV7JVdAbwkuMow/DaNSRkBtl3eR6o52OOrSE0nbOltMjrYYgd+CqLZnfCSBWH3BIQ47bBSvo9kJ0kku3qx7ZNuOdcsvK7y0R/I4/6CwBFkaSm574hZsEVmC8eiAFj3lLGbyyQ1pwMCSwxT909GW+iLRIaRXt2H3ZlBiHfdy3Q0kl+iSADb1a9K430lJqfGOmKMk2A+3DtECyT/wG4AawrhcHZq8PfPSEsUbTKJs2tIvQSVFKmCCeRVEd1x4OeLbzXdtNHNQeHdsyUpwUXgdt9m2hPa+R3cyRAfvJ+xMPh6Qx7Fmj3k3ICWtypLyHnB+KBZ1FfPxZLcXwxRlF78dSMigZPlrisFL6ZLe4lETBm22W0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(1800799009)(186009)(451199024)(6506007)(6666004)(6486002)(6512007)(36756003)(86362001)(38100700002)(82960400001)(2616005)(26005)(2906002)(5660300002)(478600001)(1076003)(6916009)(45080400002)(107886003)(966005)(66556008)(4326008)(8936002)(41300700001)(66946007)(83380400001)(316002)(54906003)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSw6xw6ZGj7hD9atjFZ3A+p66BCGCKSrnPx8aWMfNq4vkM84Pzei3VUvNPnE?=
 =?us-ascii?Q?kpy7y3EoMkFm0V8k29wZM1oFJfMfq3W8VB4rXGG2ETacafsEnfD4S0RCmr1O?=
 =?us-ascii?Q?CX5gUVIa6O29bvWrIW7bf22aigfuhbU0PwjKEkbjmjqssusrJJdXJ4J3gKxl?=
 =?us-ascii?Q?0aFnRwfVzcRfY3fVKGaMi55vkNkcZ1YKmt+l2Kb1TSb4+tgqRQ7jSGjFCUxa?=
 =?us-ascii?Q?9AzVuLtR3OQb8u1nRWni1vVwLTWtGXLcVsu2EnrXLc9k4/aGOzscjQyyhnHu?=
 =?us-ascii?Q?g3mS7V3fa3pihrZY6xcO7nZmVH1iXYO9rnNigOpoRYHJg846ZNoMXu3ACc/y?=
 =?us-ascii?Q?zCyY42XXnB9C78PtLHZtbcQdJRuiQ1h15R8zPp22YLijt0Eb8rwlBmrgnEZF?=
 =?us-ascii?Q?EPcYSRA199aE5TdFyAG5Ths2MzBmLpLATLXnDdgaaomA9Wb6LYoaeaEclbhF?=
 =?us-ascii?Q?yU9zaUlHSw5lgAhhuv5n/3A8JSe2O1MNXuKImNZduhTfqBeBvmxtdvTKZfII?=
 =?us-ascii?Q?gztqxRDtzK8IjQWIt7OoYRxCz5ckXPBDgThO/mbggJ2V1aoaU5+xNyTNbxwm?=
 =?us-ascii?Q?18JD31qgu5DHLJYWb+ZC3AKeHS1VhFpo2xPvwVhvWfD7KFjSQ5LdYF+PHp0m?=
 =?us-ascii?Q?aklrRhxI1IOcRqiVT152/A2FJl/xunz2cY6hcLzvVS6zXbBOxnNMfO/W0tS2?=
 =?us-ascii?Q?i9I6/yKUWA91u6GoV1FmQqDiRvIlVKwaB2nQS/8VNK/kuZTDRIppIaYXjdZZ?=
 =?us-ascii?Q?HLYdutWYKrg0jlhwucEUPjx28HUOKSB4jEC1C0ax6DvNMOmJd961NMLEGgYo?=
 =?us-ascii?Q?T3AZVJSn6YaE0exSA1L9DL0P8I0zRE1BYYk25CfHaWiaSfnqjwkCbbl2a2S9?=
 =?us-ascii?Q?3WuI4rH/VeNXvi6McPQw8yv5QZl/6Q/UVCsyxsHR5lXWkGtzDPXxwXZGeHb1?=
 =?us-ascii?Q?AF4Y02pYLxEJA/qnudXsyIzXcs4ko/nHLNUnivOZz+dTTNm2h3i4yOiV8EPE?=
 =?us-ascii?Q?Ssb+hG2NbvOoHQjVHC2r4qGE57amyh1vepd0wFDykJcSj6YiXjPyn1VUz/yA?=
 =?us-ascii?Q?zzvvzOAzt7yY01jsOfKu5M47iAXUW42cfoFZT5Frrhw9A1RfrQTA4A5pn/0E?=
 =?us-ascii?Q?4VhNgwI6y4U+oMlwgu+057syNJSg361Y2Ihe66vHZmShOpBXx3dK/gleHQPY?=
 =?us-ascii?Q?5gsi6UYWkkIWX7znnOG1dINToA6BpZ2cs1njIY9OqYAWfOtR2yqwFNTGQAPZ?=
 =?us-ascii?Q?oyDZkA49xyYSq0hrCKc95jzd29kEQIcOdrmeM3X0hlflv3q/g7P1YKykvfyl?=
 =?us-ascii?Q?juN/CQHg6dbsKKMg3TbfRoUrplg+vgpypa0NRYyKylTUXTRFuMZplxCFrR6p?=
 =?us-ascii?Q?L5B1a3RW/dGgkhs7BGAGC4pshAVzp6VHTpInRmn6ZDSSQ3age4HOqi7DRubJ?=
 =?us-ascii?Q?SgOz1Q1dHxXGRpFtf93HmfWfCVg5UJ6Qovdql4QaYHjP7Vmb2O6fp7xBu4kK?=
 =?us-ascii?Q?wvNQ8BSGmae9MvZUWzhsYhUdlFbouIJHad2INjJRB2klR2hqAuTPRr6HjJbP?=
 =?us-ascii?Q?kGd4curXNDDkxf7rR/X1nYrurLHDaX9UK92lj79197zGRPFr+3VIrXCI2Bex?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: beacb58a-1e00-4964-2ffd-08dba9c9ba0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 02:26:48.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXPLvrtdKlV4edWjNacI7fbobvpAEgexhUGawADn78U59j3RNNqVbpmH5DyRWzd6alX4dkGdlMTwFy2u1pp31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: ddeea494a16f32522bce16ee65f191d05d4b8282 ("tracing/synthetic: Use union instead of casts")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: boot

compiler: clang-16
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308311026.b4bc6948-oliver.sang@intel.com


[  390.645593][   T41] BUG: unable to handle page fault for address: 001c24ca
[  390.646174][   T41] #PF: supervisor read access in kernel mode
[  390.646669][   T41] #PF: error_code(0x0000) - not-present page
[  390.647170][   T41] *pdpt = 000000002e192001 *pde = 0000000000000000
[  390.647717][   T41] Oops: 0000 [#1] PREEMPT SMP
[  390.648101][   T41] CPU: 1 PID: 41 Comm: rcu_scale_write Tainted: G                T  6.5.0-rc6-00003-gddeea494a16f #1 402c7a624341eb9320bc4b1c80c0d4ec9184aa32
[ 390.649312][ T41] EIP: string (lib/vsprintf.c:644) 
[ 390.649695][ T41] Code: 73 43 89 c1 8b 44 24 10 89 04 24 89 5c 24 04 c1 fb 10 0f 84 ab 00 00 00 31 c0 89 ce eb 09 40 39 c3 0f 84 a2 00 00 00 8d 0c 07 <0f> b6 14 06 84 d2 0f 84 99 00 00 00 3b 4c 24 0c 73 e2 88 11 eb de
All code
========
   0:	73 43                	jae    0x45
   2:	89 c1                	mov    %eax,%ecx
   4:	8b 44 24 10          	mov    0x10(%rsp),%eax
   8:	89 04 24             	mov    %eax,(%rsp)
   b:	89 5c 24 04          	mov    %ebx,0x4(%rsp)
   f:	c1 fb 10             	sar    $0x10,%ebx
  12:	0f 84 ab 00 00 00    	je     0xc3
  18:	31 c0                	xor    %eax,%eax
  1a:	89 ce                	mov    %ecx,%esi
  1c:	eb 09                	jmp    0x27
  1e:	40 39 c3             	rex cmp %eax,%ebx
  21:	0f 84 a2 00 00 00    	je     0xc9
  27:	8d 0c 07             	lea    (%rdi,%rax,1),%ecx
  2a:*	0f b6 14 06          	movzbl (%rsi,%rax,1),%edx		<-- trapping instruction
  2e:	84 d2                	test   %dl,%dl
  30:	0f 84 99 00 00 00    	je     0xcf
  36:	3b 4c 24 0c          	cmp    0xc(%rsp),%ecx
  3a:	73 e2                	jae    0x1e
  3c:	88 11                	mov    %dl,(%rcx)
  3e:	eb de                	jmp    0x1e

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 06          	movzbl (%rsi,%rax,1),%edx
   4:	84 d2                	test   %dl,%dl
   6:	0f 84 99 00 00 00    	je     0xa5
   c:	3b 4c 24 0c          	cmp    0xc(%rsp),%ecx
  10:	73 e2                	jae    0xfffffffffffffff4
  12:	88 11                	mov    %dl,(%rcx)
  14:	eb de                	jmp    0xfffffffffffffff4
[  390.651345][   T41] EAX: 00000000 EBX: ffffffff ECX: c31b291f EDX: 00000000
[  390.651928][   T41] ESI: 001c24ca EDI: c31b291f EBP: c428fcc4 ESP: c428fca0
[  390.652517][   T41] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
[  390.653162][   T41] CR0: 80050033 CR2: 001c24ca CR3: 2e2a62a0 CR4: 000406f0
[  390.653800][   T41] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  390.654421][   T41] DR6: fffe0ff0 DR7: 00000400
[  390.654809][   T41] Call Trace:
[ 390.655097][ T41] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 390.655473][ T41] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 390.655807][ T41] ? page_fault_oops (arch/x86/mm/fault.c:703) 
[ 390.656237][ T41] ? pvclock_clocksource_read_nowd (arch/x86/include/asm/pvclock.h:36 arch/x86/kernel/pvclock.c:79 arch/x86/kernel/pvclock.c:120) 
[ 390.656769][ T41] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:761) 
[ 390.657284][ T41] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:817) 
[ 390.657763][ T41] ? pvclock_clocksource_read_nowd (arch/x86/include/asm/pvclock.h:36 arch/x86/kernel/pvclock.c:79 arch/x86/kernel/pvclock.c:120) 
[ 390.658279][ T41] ? bad_area_nosemaphore (arch/x86/mm/fault.c:866) 
[ 390.658710][ T41] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 390.659137][ T41] ? exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1494 arch/x86/mm/fault.c:1542) 
[ 390.659538][ T41] ? local_clock_noinstr (kernel/sched/build_utility.c:301) 
[ 390.659974][ T41] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1499) 
[ 390.660529][ T41] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 390.660982][ T41] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1499) 
[ 390.661525][ T41] ? string (lib/vsprintf.c:644) 
[ 390.661882][ T41] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1499) 
[ 390.662443][ T41] ? string (lib/vsprintf.c:644) 
[ 390.662796][ T41] vsnprintf (lib/vsprintf.c:2817) 
[ 390.663174][ T41] seq_buf_vprintf (lib/seq_buf.c:64) 
[ 390.663579][ T41] trace_seq_printf (include/linux/seq_buf.h:47 kernel/trace/trace_seq.c:96) 
[ 390.663979][ T41] print_synth_event (kernel/trace/trace_events_synth.c:? kernel/trace/trace_events_synth.c:409) 
[ 390.664446][ T41] print_trace_fmt (kernel/trace/trace.c:?) 
[ 390.664878][ T41] print_trace_line (kernel/trace/trace.c:?) 
[ 390.665321][ T41] ftrace_dump (kernel/trace/trace.c:10167) 
[ 390.665711][ T41] rcu_scale_writer (kernel/rcu/rcuscale.c:486) 
[ 390.666140][ T41] kthread (kernel/kthread.c:391) 
[ 390.666516][ T41] ? rcu_scale_reader (kernel/rcu/rcuscale.c:410) 
[ 390.666972][ T41] ? kthread_unuse_mm (kernel/kthread.c:342) 
[ 390.667422][ T41] ? kthread_unuse_mm (kernel/kthread.c:342) 
[ 390.667879][ T41] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 390.668271][ T41] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 390.668691][ T41] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  390.669124][   T41] Modules linked in:
[  390.669435][   T41] CR2: 00000000001c24ca
[  390.669806][   T41] ---[ end trace 0000000000000000 ]---
[ 390.670258][ T41] EIP: string (lib/vsprintf.c:644) 
[ 390.670623][ T41] Code: 73 43 89 c1 8b 44 24 10 89 04 24 89 5c 24 04 c1 fb 10 0f 84 ab 00 00 00 31 c0 89 ce eb 09 40 39 c3 0f 84 a2 00 00 00 8d 0c 07 <0f> b6 14 06 84 d2 0f 84 99 00 00 00 3b 4c 24 0c 73 e2 88 11 eb de
All code
========
   0:	73 43                	jae    0x45
   2:	89 c1                	mov    %eax,%ecx
   4:	8b 44 24 10          	mov    0x10(%rsp),%eax
   8:	89 04 24             	mov    %eax,(%rsp)
   b:	89 5c 24 04          	mov    %ebx,0x4(%rsp)
   f:	c1 fb 10             	sar    $0x10,%ebx
  12:	0f 84 ab 00 00 00    	je     0xc3
  18:	31 c0                	xor    %eax,%eax
  1a:	89 ce                	mov    %ecx,%esi
  1c:	eb 09                	jmp    0x27
  1e:	40 39 c3             	rex cmp %eax,%ebx
  21:	0f 84 a2 00 00 00    	je     0xc9
  27:	8d 0c 07             	lea    (%rdi,%rax,1),%ecx
  2a:*	0f b6 14 06          	movzbl (%rsi,%rax,1),%edx		<-- trapping instruction
  2e:	84 d2                	test   %dl,%dl
  30:	0f 84 99 00 00 00    	je     0xcf
  36:	3b 4c 24 0c          	cmp    0xc(%rsp),%ecx
  3a:	73 e2                	jae    0x1e
  3c:	88 11                	mov    %dl,(%rcx)
  3e:	eb de                	jmp    0x1e

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 06          	movzbl (%rsi,%rax,1),%edx
   4:	84 d2                	test   %dl,%dl
   6:	0f 84 99 00 00 00    	je     0xa5
   c:	3b 4c 24 0c          	cmp    0xc(%rsp),%ecx
  10:	73 e2                	jae    0xfffffffffffffff4
  12:	88 11                	mov    %dl,(%rcx)
  14:	eb de                	jmp    0xfffffffffffffff4


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230831/202308311026.b4bc6948-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

