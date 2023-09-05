Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE479289B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjIEQX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbjIECuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:50:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8F18D;
        Mon,  4 Sep 2023 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693882208; x=1725418208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=indCdXc3G90ISXOcWqQT4YdU4vUh8sGOAiNhlvcuM/o=;
  b=G6He61S/pqRR4SMTbAOzNb2DxuiIE7NDeEcjnXqDZ1UETYAJZ5Lm0VVC
   azA7zMNmo1K/aTLi0MVLEGW1Ze9sjLxe9ykW2L/eC8hWv6QVRaGXVjdA+
   wwzwlTc7EPQKBhBYqd5g6Xds96JJCXKc56cwQYunXgfIzRKHjyOf2NfON
   A9yGxFIDS/QFYVT4HXHGTW73wS4DPSUJ3bVZtr50XBP0axkHOqx29JIQP
   ds1XTlw3gXC/3jxW6vu7dX7W4w2q1i0Bxki5VdyM7+RqXjmcuIYiM8A4R
   HZEW5vaL0gfD3t+UU/5S6/EXraTCCvUARqMNgQhgm2F+BHObhePxpA4I7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443091321"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="443091321"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 19:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="690770377"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="690770377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 19:50:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:50:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:50:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 19:50:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 19:50:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETnNIDhCxPHXlf9/kH8KDNU8b4eVW+eSsu3qA4j3IMReqCYyClW4vW8Ia0TK6xrWk/eM1d6AHjna15U8e2ljaRtIvZJeLb15k9Jj3704Y8ObwAK8tqA0aBcD8UXNpNINdGH6z2/p/3tiM56eTrZrBqfzRETg1DcalfLDSpRXmMxwdvnMt2RcZ/4x+Rxu4MbdsMuW/Z99jyGcySNGnrn8ya2Qfq0o6LLanQWU66FMkLgDS+q9V3qnCjkp57sg/FLoIze1IVeSDqNiWBXHmrL5WWLEy+ddeltKxRcKDLx4CrKaQ9czWIJ3ZcZ/YPi9yCH9ZtKJ+v+2WpzKjcpFykU3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZKsIdbq8EeebIj2VOKHLXDLkDuPpKe4rqlT69esshs=;
 b=HZB4pG/qgAfmILA64VTDr3vq38Q3YcO11iwYAls6oqKnNAQ6E6930zKm3gY/g0mngpGngJXBn5CcQtwTPbAxtXEkJAnWP8AL6hVub7eZm0LLwFJpAULQp5r8URAF79uwvJnSk/P5YptBLCUExhYw0psXcF0v5sCmuywJeITUhmiIgEmgm/5DV1KCEWZe2Cp3SG3WpOcHIvyuqHWC23jHJraJoTdem0anOw5moaNZeUg7yOm2Og0c8BWSZfC6OkWDpE9yQ1r7FdNGa7SI+DpNXRk6puFLmPT4bxy+v/TJybMN0WtNzp7CBBjK+MRcZoqTN0Mc0j7dg1DNPV2/g0/OJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 02:50:03 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:50:03 +0000
Date:   Tue, 5 Sep 2023 10:49:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing]  1d18538e6a:
 WARNING:at_kernel/trace/trace_kprobe.c:#kprobe_trace_self_tests_init
Message-ID: <202309051054.cc75bafb-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4685f9-2cd3-44af-0194-08dbadbacdeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alKNFC4s15KHkuKFQ6+YJ26Gb0nVpA4NoSN9WfvWtWrnqSv0ee9XVWwhqJRm5WhTLKe04AuAT66HH7TTuSe5DhUH2Jn1SgQcwU/ZnLsmgSJsHAWVRLmI+7x2k/Jk7P2wzXsNQkQzvs/nc0hKuMnFEqNF2Rb/qGYkeRTY/pUJn3DCixvz0ahHsY129KzgzfJfR0mMmeBsb2MGdGx/qyMZOK7ol2BPZHFYZ7M2+b2vPRIRB9JzCHeQBqnOINBWDpkQ9hhE5awRJNckVySFbjpUVPsJV9hyculZYHNdRyLxoFN/kotMZhTdMwKsT2vEuSza7fvqwCgpim+QEs4cKJPd76TKk6KBK5pBETcHD9hbXpf0VZO5adEBNX/JyPrHR2NuFoB/NgCBmkhViR4PhVQl9VCmXKcVRxNwCVxei3DsDuYpLwS4Qm55QDet/OtJ3gz11fdmuXEyYW9rcZlqsukwGPx+QsftFjCAHHEO4QVCWIFW/sFgmD6DEhaH/DS3zd3kGpr18sYli85aMh5B/UGVsNooNAdzBAAa9nU3mQl0e7sIcnKS5cPI7o+KsVsX1/mLdZ0eqdp0IXI/4lsl7xTxNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(6512007)(45080400002)(107886003)(478600001)(83380400001)(966005)(2616005)(26005)(2906002)(316002)(66476007)(66556008)(6916009)(41300700001)(66946007)(4326008)(1076003)(5660300002)(8676002)(8936002)(36756003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UoRuddGZwq+XVG3oXi9JKyzTRxqQZ0NtXKETSjv+79FN3JD914sqEEQaeQ67?=
 =?us-ascii?Q?2mjEFyqhQWSeFw0pUtGrFYnv3dBFotC8VyFY3uCwT7BCLWLaWaAbfZTqAX6Z?=
 =?us-ascii?Q?eHOf5YnKL7NtRNYPFhhKmgvBN9t1Gm5gqn6d3+xqoPV89YXWRLVOEj5rA2C+?=
 =?us-ascii?Q?tueGMV6keOwMdFMYCa7W+ocAmFh8kC0VK1rlNM4c8DKLFwmLci1HjiCbv1TD?=
 =?us-ascii?Q?P85/V9nQOQGsNLOrrWZsUupf1MpxS1OnrZBOoT3lrBrXYGyOk0YE2DHRb3Od?=
 =?us-ascii?Q?BYuBZHcaogzOt4qlKGSphfCFENidxQegtnUy8YcQ5HSHXOikK07PAOAnbbZz?=
 =?us-ascii?Q?OFymngyxQScTLaUGaYKm/VnjFFFwC/tFuy2w+FvW0i4Qvh5P5wgxuI8fy3Om?=
 =?us-ascii?Q?Y1iMWLpZ7tFMh1BbHd57kgyDcnsgzSdLZNtgwyD1vVEy8piyHPufoxjkRU+0?=
 =?us-ascii?Q?yEK89Q9lVBstp3JFn31p5RCKv5/hk+4jmjUHU/zvXnOoU9qzQl2uI2/fJWj3?=
 =?us-ascii?Q?jOHrRVmDH/frZNhYh2eBQNNl4Cvhlv8952Mkh/t3tDgbxE12RvuXRO0VfUak?=
 =?us-ascii?Q?Yrodihn9fugsvHtQWVgVI1YMJdJLAKTYbrMZJAT3l0VzyY48EhXR8q7EkPNM?=
 =?us-ascii?Q?4rv0YELlxNcvITRUS7HzMV1Grjv4/ZPYsRLBVBJYKgu9b8vLxBoK8WO34zfX?=
 =?us-ascii?Q?/IIWcloxpxSwnxtit44pBtsJYd9FX+PKhHZJhiHNYeNNGkxgKaT41w6x+Dy5?=
 =?us-ascii?Q?f0bZqWrjj+oIKKOzBD5GKM4tQ3kuCi02Jz69gCnGyvtI1aT07pBmhvuYd8ju?=
 =?us-ascii?Q?kj46Rw/UOs5TmJJ+IPS7sGh1psDUfDh3niBOLyPdy3L026fGMs8wEJlMx1MD?=
 =?us-ascii?Q?KTSil4C+ZbUvBCLU9lHlJgNpBI4AdLzs5oUqmP0NF/n1oRwW6ew84r7JpYSk?=
 =?us-ascii?Q?ljGGZcGXhyKls7s3xi6m2EsqQVAYBsFcT7blLv6jrZ+tsHOd526Xt+oxp7bE?=
 =?us-ascii?Q?xKG1J4T+/bgvdFRfS5n516rZs8vyGpK0D0lB5ls0EY804ZHmCvZT8WTTPclH?=
 =?us-ascii?Q?l+KcehiuxyEgNqbQ9S4yCW3AiIfzbox8zPuEK0UhzbCM5ZF0R743C5RX7mmq?=
 =?us-ascii?Q?RdjFQyD8/Y585gTQzl2/s356KCGdsXJVvqYctw6fkW3JCpcgtCTRWSo94dBd?=
 =?us-ascii?Q?RrnHZdiJaCgBKuf8/tLqdNthC0Cxds63+41VNR1qrKHWlXz3C5/hYH+U5oAi?=
 =?us-ascii?Q?V4GRM5zr/lKiHzN8GBZ7itVD8DxgQ6WkTK+dEabc/3295ZPA9qxhViyA2i0G?=
 =?us-ascii?Q?+YiafQrjjf9YwntfN/S0TP5juXEB2DoMWnkkKhVoNcjAaKeHfbPi1EaZo4WE?=
 =?us-ascii?Q?zibrmvEjHETzi7QP38lLBAvD0ZOluoKLBVFQLl+V2oa9D/8Cu7LV5FHxwDbQ?=
 =?us-ascii?Q?aGbkxiZNvQcfOERdgZnVGwyDnwdf/cBZFXYRa8JaCJ2Bec9rDK5WZRDhSbI5?=
 =?us-ascii?Q?L+hR/hTlWSuVsDa2tiISHjgkDD5mdb/kACqMbA7bKcBSVJQqbYdzmrBA5wzs?=
 =?us-ascii?Q?km+TQhrQpqOupN2a8I/BXAr02udu5/xjh3C3hn2rQCQPUqHA03g9aeQlltsb?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4685f9-2cd3-44af-0194-08dbadbacdeb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 02:50:03.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQnUkhonhCAmSYDag/s9UR2+hg4veI2Wb8AJ3FCUZvJQQpYRk0i3yyASZaAIL9jOVzLb0CvSm4tW8tCQaPdk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
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

kernel test robot noticed "WARNING:at_kernel/trace/trace_kprobe.c:#kprobe_trace_self_tests_init" on:

commit: 1d18538e6a09265003a0a94ca779d7a6127cb76c ("tracing: Have dynamic events have a ref counter")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 0468be89b3fa5b9249cee1097f1d50314950a2df]
[test failed on linux-next/master a47fc304d2b678db1a5d760a7d644dac9b067752]
[test failed on fix commit 7249921d94ff64f67b733eca0b68853a62032b3d]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309051054.cc75bafb-oliver.sang@intel.com


[  635.235522][    T1] ------------[ cut here ]------------
[ 635.237065][ T1] WARNING: CPU: 0 PID: 1 at kernel/trace/trace_kprobe.c:2100 kprobe_trace_self_tests_init (kernel/trace/trace_kprobe.c:2100) 
[  635.238389][    T1] Modules linked in:
[  635.238874][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.14.0-rc2-00045-g1d18538e6a09 #1
[  635.239910][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 635.241298][ T1] EIP: kprobe_trace_self_tests_init (kernel/trace/trace_kprobe.c:2100) 
[ 635.242039][ T1] Code: fe b8 4b 3e d0 c1 fe 85 d0 c1 fe 85 0b 68 7d 3e 0b 68 7d 3e 88 47 ff b8 88 47 ff b8 e8 87 14 c2 e8 87 14 c2 74 35 0f 0b 74 35 <0f> 0b 81 e8 49 88 81 e8 49 88 62 bf fe 58 62 bf fe 58 00 ba 8a f9
All code
========
   0:	fe                   	(bad)
   1:	b8 4b 3e d0 c1       	mov    $0xc1d03e4b,%eax
   6:	fe 85 d0 c1 fe 85    	incb   -0x7a013e30(%rbp)
   c:	0b 68 7d             	or     0x7d(%rax),%ebp
   f:	3e 0b 68 7d          	ds or  0x7d(%rax),%ebp
  13:	3e 88 47 ff          	ds mov %al,-0x1(%rdi)
  17:	b8 88 47 ff b8       	mov    $0xb8ff4788,%eax
  1c:	e8 87 14 c2 e8       	call   0xffffffffe8c214a8
  21:	87 14 c2             	xchg   %edx,(%rdx,%rax,8)
  24:	74 35                	je     0x5b
  26:	0f 0b                	ud2
  28:	74 35                	je     0x5f
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	81 e8 49 88 81 e8    	sub    $0xe8818849,%eax
  32:	49 88 62 bf          	rex.WB mov %spl,-0x41(%r10)
  36:	fe                   	(bad)
  37:	58                   	pop    %rax
  38:	62                   	(bad)
  39:	bf fe 58 00 ba       	mov    $0xba0058fe,%edi
  3e:	8a f9                	mov    %cl,%bh

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	81 e8 49 88 81 e8    	sub    $0xe8818849,%eax
   8:	49 88 62 bf          	rex.WB mov %spl,-0x41(%r10)
   c:	fe                   	(bad)
   d:	58                   	pop    %rax
   e:	62                   	(bad)
   f:	bf fe 58 00 ba       	mov    $0xba0058fe,%edi
  14:	8a f9                	mov    %cl,%bh
[  635.244386][    T1] EAX: fffffff0 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  635.245402][    T1] ESI: ee1d16c0 EDI: 00000000 EBP: 83c73f20 ESP: 83c73f18
[  635.246304][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
[  635.247265][    T1] CR0: 80050033 CR2: 77eee844 CR3: 0257e000 CR4: 000406f0
[  635.248166][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  635.249201][    T1] DR6: fffe0ff0 DR7: 00000400
[  635.249789][    T1] Call Trace:
[ 635.250204][ T1] ? init_kprobe_trace (kernel/trace/trace_kprobe.c:1976) 
[ 635.250861][ T1] do_one_initcall (init/main.c:1287) 
[ 635.251460][ T1] ? lock_is_held (include/linux/lockdep.h:284) 
[ 635.251993][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125) 
[ 635.252813][ T1] do_initcalls (init/main.c:1359 init/main.c:1376) 
[ 635.253377][ T1] kernel_init_freeable (init/main.c:1602) 
[ 635.253991][ T1] ? rest_init (init/main.c:1482) 
[ 635.254526][ T1] kernel_init (init/main.c:1492) 
[ 635.255052][ T1] ret_from_fork (arch/x86/entry/entry_32.S:775) 
[  635.255618][    T1] irq event stamp: 23945227
[ 635.256148][ T1] hardirqs last enabled at (23945235): console_unlock (arch/x86/include/asm/irqflags.h:45 (discriminator 1) arch/x86/include/asm/irqflags.h:80 (discriminator 1) arch/x86/include/asm/irqflags.h:140 (discriminator 1) kernel/printk/printk.c:2668 (discriminator 1)) 
[ 635.257407][ T1] hardirqs last disabled at (23945244): console_unlock (kernel/printk/printk.c:2589 (discriminator 3)) 
[ 635.258495][ T1] softirqs last enabled at (23883956): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:402 kernel/softirq.c:587) 
[ 635.259587][ T1] softirqs last disabled at (23883945): do_softirq_own_stack (arch/x86/kernel/irq_32.c:60 arch/x86/kernel/irq_32.c:149) 
[  635.260899][    T1] ---[ end trace e6ccfb1eebc48ce3 ]---
[  635.261605][    T1] trace_kprobe: error on cleaning up probes.
[  635.262352][    T1] NG: Some tests are failed. Please check them.



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230905/202309051054.cc75bafb-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

