Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49B7F87C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjKYCLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYCK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:10:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373461990;
        Fri, 24 Nov 2023 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700878266; x=1732414266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wjT7nN/yRJnFdUOfXrxKJBNViAo8+mz9uQSvOtMNvuw=;
  b=OeLoMuHc5gB83eCTxZOy3cPhDXega+Ib0LQRwn4Jh0H+CKu5PrdamH1L
   KuwMAhpUqtrmtqqole52eBaXomMzjd0heT+gStElNB8C7FyUmb0spgeSx
   JkiYSBrcDjekY1mSlrzzCTD63EEUpBUckBZwLF82qmBakEu+AcpnpbKxs
   MEKjLSMb3K+FeAZDHSrKKNf/wNLZY6WqQqphMDEy1e/bkqdx4OhoPgoZT
   CQZAOqXIztNuH0txfpyBAhbJVHBAnWs1gSgLAdJPDnUJVL8tZZic4suEY
   Aa8OJ6o4bF7kn6p7IQhwCnwVQlI0IeBjV4TZ1DLyeXGTdJ8szCKsP/OVx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5713690"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="5713690"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 18:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="891185944"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="891185944"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Nov 2023 18:11:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 18:11:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 18:11:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 24 Nov 2023 18:11:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 24 Nov 2023 18:11:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrKRoGYO8WyiWsun4Av048J82JcNOZEAK3h+pDAiAbdwOWvmgDonipnMETQVCGDYIOUdtauYyT5OiDOEKKpLFZYb7RnSGZU03t8SrjQQLhsjuEeCY7/bglgdUoml7Tpq4izhgwgtkb2/wG7jHtO7czu78Ws1UJ3VZ2QsH0NdYdPHPpU4NMxcsqoy/JUyw52/KAvZfZjVka91lSABO/z4Fq4WpQPD7dv8zn25iTnDySl/RlSI/YdAL+n7ZU4p0/pITPdZlt9rCd3yXAC+VnIe39461f+QX7r1aKd7FFmfCdf++N4ojaV0jH5FzV3xegh4nH52I8rLmhnXc98rdfHazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLOipG2R7oFcyN/rlIDsWjxwwGiql3GLZJxusw6XAD8=;
 b=QyLFl7g/+RWS9q0gwbRs+tO8JY7sTPyG2tELV8R3F75GZrYThuKRxtL3QzJPOfEn4JEbI37JTAbK3NV8wssHAmLScN6PYlJt9aabQc4ALcTgPNakaEoNMCCHc/MJSSxI94SBmP8TsT23r1PCduIqsfQpFE2AC0k6gOxoOqIrTyTPjbUgJBLxaXV8qjgvx3QizlP+uRZ30Fa2yOREoxMIygdhq6OmPtzacaLNg/C0tAFY770YW33eX6E7xbC+KFJt/GTuz8G1oqSk0+zXZtzuQE0KGa2YQlmEGSIxIcNdKiTCPRkXJBpzFalf33t6c5yQ7g74596ET77gJIFeOf8wsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 25 Nov
 2023 02:11:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Sat, 25 Nov 2023
 02:11:00 +0000
Date:   Sat, 25 Nov 2023 10:10:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [function_graph] 1c96d64aa1:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-ID: <202311241731.d1159c9f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: bd002d11-fe58-43ff-634e-08dbed5bc4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhXUocb/YtpnD1kuclhUARpH/HjrLXGC/8lienGvdeyOlJ82kpu+GzEFkmfk/sbzeQKT0jTUetknotoGSb3dMR6xP2vEU5IsQflO4gdljR/MMHw/YSad032D00mNHERfkOQmy/J3uRteDiMTieCBN9oi7bxLOsRUoVcPZ9lBo7flt2Qjn+inDM2S7yfLXBmr7rF0Bs7061l+OSHjEIKj45A54kv1FmwgXzHe/OvNk7se5tMOHXSJaaFQ3CVXhiQ32E7krV4+pbKalIuQD5TMoAUqVJZ5BV7SYC/zZ+VPSrV2Sv5VJFgpQuiLDYm28YuShTOXtxFgT00lJHUrLma6BrHFyKPmgqixjG1CHfiL6+BSIejdFlBp6E3xreQYu8vz0Ze869lwzmdc9v95F3QLDCBQCObDoHZZw1tJWGyUzeXa+282F6rjyg5DwkiqHuQ/2tpnBjfUKMftzgY72af4x/QNBZJoXh6/teQPXcMbrVqpl/3eI07yCOxXoKFp8msBwt5kg5NpjF6j+JcKFgDKtwmS5DjBT270QGkRVXwBq/S4VYXugW9USDEFpR01jfTzNhkYS2bALEUqcIwQqm2JKWvBb2+QNT5y+K9PMzatbPJJ/Mbv9Ywq0/68UHS56FoiDevFlvOm1pZF/OIuPR746Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(4326008)(5660300002)(45080400002)(966005)(6486002)(6666004)(83380400001)(6512007)(26005)(82960400001)(107886003)(38100700002)(6506007)(8936002)(2616005)(1076003)(478600001)(66476007)(66946007)(6916009)(316002)(66556008)(8676002)(86362001)(41300700001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIyJuXssKtXD4bLG8d5MIdJT7nlrAjO65Cib2/Wivinn69xqGMJvFq7bmOZh?=
 =?us-ascii?Q?fPJrL4nBJlTQZQIy2mlRvAZlbbIef3PSlZQQPtZZEvYAQ/t0CyeahL4QTTwR?=
 =?us-ascii?Q?UEm1iP+x2C2mgsqVTYuLk/pFa7MZ20UrFtwwJt8IAX7NikCrk34luZdvhksn?=
 =?us-ascii?Q?Pxk5nNg+ZeEU/sntnEzAMKJADTn4XjCCO7rZBgwGRI/hs3zGQUZiysJv+Irc?=
 =?us-ascii?Q?LPo50BP9NdLNzhWc9mIEHwBYuY431fyr2drkonB2XOAsZRAIRd0kxhrgsTv0?=
 =?us-ascii?Q?vyBiT6VJRDRZ6Q36hfgGeRiO90ckEHRGiuEx4Lde2GCFS04GUZZJq+vkzq3o?=
 =?us-ascii?Q?hi5VBJt49tThE06SA0Fd/WNvE54l6mxQ1nWTyBHyVXBB7/3qPiKQHkMNNWag?=
 =?us-ascii?Q?0GAdlBpfW13dSm8cKmfuNPQX9+6ybmhj4+xHNWCCzS5HYwyo16McGr/G5sB3?=
 =?us-ascii?Q?lIprtT5wh5s7gLDHYZ7Pr9pwlR+i4kU5vhIn0aVY/Gpp2f/1R+9KwytryPmu?=
 =?us-ascii?Q?Mr9BVy7P6raAH02KnF0CUaykcd5AmcwZBINm7dbIEWbc7PxjUyJCT5x6RTi+?=
 =?us-ascii?Q?6DqoXCmHLoIDpjPLYI6D0eC5iYMrz0Xne8nbQ6k6afGwQjDNcNTmVBM9gxTR?=
 =?us-ascii?Q?ZEP9mGZRW0c2oN0R2MMUdkBvsCl+iMPM4b7xD6nqVe97gfyq9dyUO4lrK+ZP?=
 =?us-ascii?Q?yEUPye0vI994Vxqg16o5ijvynNd242tuReSPjR4DCFSQ+l0sh2/p44413UM2?=
 =?us-ascii?Q?XwCCIezoBw2TwVCucO1MrfIN/slPc7TQww3UJFYtaOQMAMPEMQg1EY+zjK3S?=
 =?us-ascii?Q?zN3SB34dW/4RPLNKUUnTaKg+NCQdWrWoh4zS2aS0NEpcW1bSH/nQEh8x1WqY?=
 =?us-ascii?Q?KIJYDNwI1iEnoyYGCVFwYuwjbRXPu/rOkR1nHI/g5TUAR2/2M7s1UFPC1VFS?=
 =?us-ascii?Q?WQE344qW6JkeRd440USETP7ggI01qFo+qt5Wxo6wTdgduh4ab+XRQm8hE1hH?=
 =?us-ascii?Q?zeM/KeZuVX+LmxJ7ZKdJVlghSka3WzqqYc8GfvE0FODs3/Bo1tHDz1CI45l4?=
 =?us-ascii?Q?NLu98NosjRlvGccb+FapjX6R5xMYZdVypfErTRL6AgR3K0CUXGCxcT/hdl3/?=
 =?us-ascii?Q?vopJJCbseYlolvYuyQ8JBQmToPAU4aNFGNywAaY551TSpnh2k1RHQHY4xNhQ?=
 =?us-ascii?Q?DqAzCINdZDVDXGqxePl+sa357vT8b7+VmISs+xpmUY0xKwBBHiR5W3jTyZ+9?=
 =?us-ascii?Q?wFItuyq0/MWHIGthMU9r1CD7299lcGufzAyrf4ilfDWCPekJyLvNNL3iPc5J?=
 =?us-ascii?Q?Asdw8QC/qP6xvgrVldIh9a53Wu+jW8ZcSOH4isbqsNlnNqwwRA9jYLOw/A5L?=
 =?us-ascii?Q?bCHqqazD8qnM7a7ZHBsjUmzY8STRRcsMlMKdEA6rH0qXGbweDFDsiipMvhbq?=
 =?us-ascii?Q?o44OwJsMlRdZpI3Ya5H9fYOmdNH6wtZc9+HT8Mb2yfV2mD08a5xwsreSHJ7C?=
 =?us-ascii?Q?BnyIQYNQn66HT53A1+mlNAF4DXlTQwUfimmPlbbAcBWdCltG3bmEj8nKaEBp?=
 =?us-ascii?Q?CMs3Tewz1Yi0Kc6UZdXVQrAYdLVeR3UcBP/KH7T2yZWSK2fYOvnVkUAqMJmU?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd002d11-fe58-43ff-634e-08dbed5bc4c3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 02:11:00.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/uNejWRnEKSrDzcD72pDZxj2uXOuInjfIs5zFyJhuvRw+3BbDcZ9Yw00TJ+OqLKq0P9KdOlf5eeP3oiDf4wzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:

commit: 1c96d64aa1853ed6272439901bb8daa85b012d89 ("function_graph: Add a new entry handler with parent_ip and ftrace_regs")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | c9e840a68b | 1c96d64aa1 |
+----------------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace.c:#run_tracer_selftest                             | 0          | 6          |
| EIP:run_tracer_selftest                                                          | 0          | 6          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311241731.d1159c9f-oliver.sang@intel.com


[   10.938801][    T1] ------------[ cut here ]------------
[ 10.938801][ T1] WARNING: CPU: 1 PID: 1 at kernel/trace/trace.c:2030 run_tracer_selftest (kernel/trace/trace.c:2030) 
[   10.939915][    T1] Modules linked in:
[   10.940689][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc7-00021-g1c96d64aa185 #1
[   10.945702][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 10.947518][ T1] EIP: run_tracer_selftest (kernel/trace/trace.c:2030) 
[ 10.948530][ T1] Code: 00 00 00 00 66 90 8b 15 ac 05 1d c3 a1 e8 05 1d c3 b9 ff ff ff ff e8 07 5c ff ff e9 29 fe ff ff 68 2f 0b be c2 e8 b4 8d f5 ff <0f> 0b b8 ff ff ff ff 5a e9 a5 fe ff ff b8 f4 ff ff ff e9 9b fe ff
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	66 90                	xchg   %ax,%ax
   6:	8b 15 ac 05 1d c3    	mov    -0x3ce2fa54(%rip),%edx        # 0xffffffffc31d05b8
   c:	a1 e8 05 1d c3 b9 ff 	movabs 0xffffffb9c31d05e8,%eax
  13:	ff ff 
  15:	ff                   	(bad)
  16:	e8 07 5c ff ff       	call   0xffffffffffff5c22
  1b:	e9 29 fe ff ff       	jmp    0xfffffffffffffe49
  20:	68 2f 0b be c2       	push   $0xffffffffc2be0b2f
  25:	e8 b4 8d f5 ff       	call   0xfffffffffff58dde
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  31:	5a                   	pop    %rdx
  32:	e9 a5 fe ff ff       	jmp    0xfffffffffffffedc
  37:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  3c:	e9                   	.byte 0xe9
  3d:	9b                   	fwait
  3e:	fe                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   7:	5a                   	pop    %rdx
   8:	e9 a5 fe ff ff       	jmp    0xfffffffffffffeb2
   d:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  12:	e9                   	.byte 0xe9
  13:	9b                   	fwait
  14:	fe                   	(bad)
  15:	ff                   	.byte 0xff
[   10.950058][    T1] EAX: 00000007 EBX: c345a6a0 ECX: 00000000 EDX: 00000000
[   10.951304][    T1] ESI: c2be3ee0 EDI: c4434400 EBP: c4d97ee4 ESP: c4d97ed4
[   10.952559][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[   10.953640][    T1] CR0: 80050033 CR2: 00000000 CR3: 03696000 CR4: 000406d0
[   10.954878][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   10.956215][    T1] DR6: fffe0ff0 DR7: 00000400
[   10.957111][    T1] Call Trace:
[ 10.957426][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 10.958254][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2030) 
[ 10.959206][ T1] ? __warn (kernel/panic.c:673) 
[ 10.960018][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2030) 
[ 10.960992][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 10.961462][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 10.962321][ T1] ? handle_bug (arch/x86/kernel/traps.c:216) 
[ 10.963166][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 10.964052][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 10.965001][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 10.965461][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2030) 
[ 10.966444][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 10.967306][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2030) 
[ 10.968289][ T1] register_tracer (kernel/trace/trace.c:2064 kernel/trace/trace.c:2187) 
[ 10.969155][ T1] ? init_graph_tracefs (kernel/trace/trace_functions_graph.c:1448) 
[ 10.969155][ T1] init_graph_trace (kernel/trace/trace_functions_graph.c:1462) 
[ 10.969155][ T1] do_one_initcall (init/main.c:1232) 
[ 10.969155][ T1] ? parameq (include/linux/fortify-string.h:214 kernel/params.c:98) 
[ 10.969155][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 10.969155][ T1] ? rest_init (init/main.c:1429) 
[ 10.969155][ T1] kernel_init_freeable (init/main.c:1549) 
[ 10.969155][ T1] kernel_init (init/main.c:1439) 
[ 10.969155][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 10.969155][ T1] ? rest_init (init/main.c:1429) 
[ 10.973466][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 10.974376][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   10.975233][    T1] irq event stamp: 4679531
[ 10.976101][ T1] hardirqs last enabled at (4679541): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:347 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 10.977685][ T1] hardirqs last disabled at (4679552): console_unlock (kernel/printk/printk.c:345 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 10.979295][ T1] softirqs last enabled at (4679152): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 10.980885][ T1] softirqs last disabled at (4679147): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   10.981739][    T1] ---[ end trace 0000000000000000 ]---
[   10.983191][    T1] pinctrl core: initialized pinctrl subsystem



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231124/202311241731.d1159c9f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

