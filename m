Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B17D0A22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376487AbjJTH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376440AbjJTH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:59:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4A19E;
        Fri, 20 Oct 2023 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697788760; x=1729324760;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=PzatgTUSHvgOf3s5iGw0qkPI2C9l9ldwolVtEFyU0U8=;
  b=gAxuvNg0UMW+QY8vjhHamU9EAR64YZO27Evzs6QOXMDxgganB82AHZ+H
   sCJqgebOqm6EgS2UciCsIPfysSk+dfzjcn40XXZ8W4NvvBsLiaYHQ4n0j
   7fnL2cYgL+b/jWJNaFZXw3T2hDgCmjgN5HZX8xUd+xay8A5SDJiVsrrKp
   Z8EiPMhB5YJtwHw+Qlx3p8cidv/eLYJxVOeisVlFwa2CFeNyZ/MnN9rrt
   PIqEHWeKX1v+EAqfarW3c0d5bfuaPsqB4Qkzd28QvVSgsAPzsC9A+X6G9
   lnoBUNcqM9GPfACWLMplqHQdiTCZMp4XtSZSUjWDFAGH9V1pbhl1MnrC4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="5059756"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5059756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004524214"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004524214"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 00:59:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:59:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:59:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 00:59:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 00:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZsRwznKxu5MihLT6MGlTUAaA8OsTvphqdsBuG2LGv+fUgOdK0upQdg/5o0MrvsUsC9n3Y+8H70J9lHmsYULFwu7L+O3nFn4eyFyaaNefrJs5WhdsxKfuLRLtAokdUa5bt9EAZXqRh2F33Aeg/oJnWMKavz+1yhIhDEZEwoUqsAuq68WkccAmgwppbvvT2Cuc3uDRvJLskHAi902Xxe1WIeTgK93pwm5Usu/aaRMspEd3mfktzJrK5hb4mU+ypNeA2EX9rrv6XFfJYbtzxFwlqd/y0JYFSGsz8OuaCAc4Rf1gabB4U8RYlG2zs18mRiYtx4PqgiTvs/sG7jD6UG2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+3Kj2nPx71d53x1TH5aW3WjahBVDcTtlpRxg/HPsQY=;
 b=ife6LmK0qkIpFZh4Ynzrdz3PAW8krcSpUKXyJEm/WcrNzKLiC2Ebd69zrw7T4AsL0cxDBMc4oCVpmNmfYWghF031yimgiCI9/6gg2bChEhZGX5oL+GKTStrurx8YxXpL6xqDiNCvhYNDncuyZMhSvrOiCAgoBODfOUlO+qruhDpLbabXdo76XZswdX8s1jsztE7rGjIJTR1nO1nXOQ6QNiunvR1PR9cPAnzGBokitTgL9FV0D9dy9o49j/W1ZJe4h+8gbTfdnIdHJ3qX1qLimqDA4Udk/O/NMQ5+OzZMMRvhDV7sBYZj4pXKaExZ7LCji0Ftv09y8Moe90PlvB8Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 07:59:15 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 07:59:14 +0000
Date:   Fri, 20 Oct 2023 15:59:03 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jinyu Tang <tangjinyu@tinylab.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Jiexun Wang <wangjiexun@tinylab.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <bristot@kernel.org>,
        <ttjjyystupid@163.com>, <falcon@tinylab.org>,
        Jinyu Tang <tangjinyu@tinylab.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1] Ftrace: make sched_wakeup can focus on the target
 process
Message-ID: <202310201530.46065346-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009153714.10743-1-tangjinyu@tinylab.org>
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: c7da2647-40ed-4720-8a18-08dbd14273e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA+ygpjuHm7A8VYyieLFxFQBFVllv/LrUzMnX2xnW+q9Bc4Q9LUKie5WGsghcbThw9Fle1W7H6R+iUdXUrIXL7qTxJObPSfLKdl1x9yCAm6aeyAhW4XCQMziJ65aiCTOs3h1VQeug2BBAZUYDb4LzHsVKkAj36KvnvltS7xaOpCU36vILJ/82TUARf66gPa4qHz+axmbjB82SdBncvnNgEK+hvcIf5EMXCt8cDm2YDY/yzdliQQpIk539CWxdbVaCD6cBFe1eFL6IiWWfY2uYt3RprRW9yAsPtNPo9GbR+9i/YgDI8hLvH6YkyY0bXJKMRx27yU2JzGil/g6pJNsEw9A4R7a2hUqAMDVMuJwnxYOwrK/X631WWHEHzku9iIQrCb+xZS2h/7G/+rQsGuWE1Bamud6jyllmPDmh1Bhndx05i5h3Q3oJ2NMfDti2AX9B5XJ8ttzhZJFz8eNE/AxjTLVkB3FFGnWZ84GFP6LPKYvGi139wH/7kwM7qJRcERp3hHtNpmbXEHWMl8Z8bL26qV5YtTmP/svAN7tiERbFwThkyK8zvtYu8VdMIlOuxY2VCOpfPHLoCKv2QUoQ1fx5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6486002)(966005)(45080400002)(478600001)(107886003)(1076003)(66946007)(54906003)(66476007)(38100700002)(6916009)(316002)(26005)(2616005)(82960400001)(83380400001)(66556008)(6512007)(6666004)(6506007)(5660300002)(4326008)(8676002)(86362001)(2906002)(41300700001)(8936002)(36756003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RiQd0vmfpqLkxQ7BceSzsN1JP6+zBJQJBdRmbxNjZ4HUr+BqOQjyqwavIChG?=
 =?us-ascii?Q?NGy7q+Nl7ig9Wlu2tBm7cWLmWZQ8tctz0Y6ctpU2kSQPNvSdnrmUyDkqG2BQ?=
 =?us-ascii?Q?spgCm4yCfFpO+D02PfY+He4/2MsDeHLMjfjWqupNgbJVtqdWk4Fv2MeW2Ef7?=
 =?us-ascii?Q?hmcm3YyFiH9REz9WnqnFUNlg8P2i1jCiJXJtkqYwvIyGyfKXIL7q3cSusXRF?=
 =?us-ascii?Q?GOMbnzSCQYI0SzoB3poLKaFqK4bFBtchIw8c1CgVRMBkTMgqcNbwmGBbVl5P?=
 =?us-ascii?Q?o62U3EmRbAJ5dOTEVIinPk1Qn1wLei3aRitDvdQHnOwEMKouENrQJHLBDzN2?=
 =?us-ascii?Q?/RusaDP0F1BUavLdSjrkmALZzZX/tAis9x8RPyZai83v4jlHmsCElyD1j0cl?=
 =?us-ascii?Q?9YODikfL+39c/4UyEPUp8TS7J0N2NxOtZNVoL2fJ08W5GswB2GaMtw9dKJf0?=
 =?us-ascii?Q?HkbxjK6QxHEQ9zejngTp0k6PEdviHLCVoZzrb53f2iQmFEGN5fbRBIHJ9Vz0?=
 =?us-ascii?Q?xD+mtGT5kfXVLl1CTekD0m+GLPXVWWaxKMxqRuhAC8cFbSzmIz4R1wzvXFgJ?=
 =?us-ascii?Q?+L6MsW5GwEq8nuBMI3XBLW1ip86PbDppl4hhiigdSWXNI5SvWRb1mIiwQCdO?=
 =?us-ascii?Q?2AmTbzAy82eMTtpRLej/91Wrhj69HsvS8Ve4a6+Un3kMLfqYYfDBXDtTOlC8?=
 =?us-ascii?Q?aWAYC7bBpBFG0A3eDK+2FROCvirsr18HMMETjNBZyQbJuM3QqOfeGON5lqR4?=
 =?us-ascii?Q?FNIVnXAIcTRFPJ3ooXeBMiN3VvwvFGJVJqFsIpUSVBpmQCkA+ipkZg/mCFl4?=
 =?us-ascii?Q?Eic7c11HoS0bAScpeiRcOYcHbzoV87b8vTyzTpNDclX2vgnIGXqAne216KYd?=
 =?us-ascii?Q?RoBj4DMTFQY63HjNdkg+L3uR/sI46K2xnqcuIZmG8zUqj2tlc6bjnHIeDnG2?=
 =?us-ascii?Q?9k7i90xq1MeNFAhVAceTx9OvjtUCGRzmlwAnIQ5ZW2VpOEEJ5TTbpudlrQmy?=
 =?us-ascii?Q?nifu07P8vhDpJZqfU3euCKFhwOLPQWmBvkjCASqndFM8QAyE5Mt5HP43niJC?=
 =?us-ascii?Q?igTDa1zZmsg6cNII1jg6ZUEnsP8re4dEGq5HqGesA80ojm8Z1wENVrxFccoJ?=
 =?us-ascii?Q?vR9ZVRSIVHjhcDK42hUhbxp5E5mHnZ3KNk+shSVKlELHhTFkwsXl9zosKZ0S?=
 =?us-ascii?Q?HiJf3YHLIDuAfca7J58VVQf3N7zrQGwaRQ4qTgL76HzYOOXK9Scm0fn4uPSV?=
 =?us-ascii?Q?IfOhgJWvex4TJnN6F5K3SmJ9ZwhJLpQa9C0L3v/h/qcn9GCJyq5HEsI0s5Jc?=
 =?us-ascii?Q?Xfvy6vYVbMlBaAnCxRpA1eqVOaOmSgkSSVNnchZawZcLX45GPPbwVk8zlJiV?=
 =?us-ascii?Q?3NsMosl7eDmYKR4HCm1KlLRuOoUFVzQlp0Gbv2YTDyN2R9yBCylRecnlvPIC?=
 =?us-ascii?Q?D8E8kldpsTEifNkTfpEbJ13osGe7S/FS0L/sXDYLRx7XCGljdVlpJTj5ene4?=
 =?us-ascii?Q?4jR7mINTKSo8qfdc3wC5hXTwllWgY8t/cChUsBtsQMo2G6lTaSAdl4FGcLQF?=
 =?us-ascii?Q?jVq3cNCFQF0PkIg35Rg7ucQM5YX1vNi9MmzheC496seTGq4RMFtDIntIjejd?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7da2647-40ed-4720-8a18-08dbd14273e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:59:14.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yas2sxdFCvoEL0V5D4mWwiBVLDbnX/04Zp0bSijT9E1J+LYpT7HDOabNBELqADC1oix/wooQWZ6czapxpxBynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
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

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: e70b12f847f6d1b5db838c0eefa9d1d00c1591bd ("[PATCH v1] Ftrace: make sched_wakeup can focus on the target process")
url: https://github.com/intel-lab-lkp/linux/commits/Jinyu-Tang/Ftrace-make-sched_wakeup-can-focus-on-the-target-process/20231009-234127
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 94f6f0550c625fab1f373bb86a6669b45e9748b3
patch link: https://lore.kernel.org/all/20231009153714.10743-1-tangjinyu@tinylab.org/
patch subject: [PATCH v1] Ftrace: make sched_wakeup can focus on the target process

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+----------+------------+
|                                             | v6.6-rc5 | e70b12f847 |
+---------------------------------------------+----------+------------+
| boot_successes                              | 33       | 0          |
| boot_failures                               | 0        | 18         |
| BUG:kernel_NULL_pointer_dereference,address | 0        | 18         |
| Oops:#[##]                                  | 0        | 18         |
| EIP:__kmem_cache_alloc_lru                  | 0        | 18         |
| Kernel_panic-not_syncing:Fatal_exception    | 0        | 18         |
+---------------------------------------------+----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310201530.46065346-oliver.sang@intel.com


[    6.082261][    T1] BUG: kernel NULL pointer dereference, address: 0000000c
[    6.083178][    T1] #PF: supervisor read access in kernel mode
[    6.083178][    T1] #PF: error_code(0x0000) - not-present page
[    6.083178][    T1] *pde = 00000000
[    6.083178][    T1] Oops: 0000 [#1]
[    6.083178][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.6.0-rc5-00001-ge70b12f847f6 #1
[ 6.083178][ T1] EIP: __kmem_cache_alloc_lru+0x1d/0x88 
[ 6.083178][ T1] Code: 04 eb a7 31 db e9 a5 fe ff ff 8d 76 00 3e 8d 74 26 00 55 b9 ff ff ff ff 89 e5 83 ec 18 89 5d f4 89 c3 89 75 f8 89 7d fc 89 d7 <8b> 40 0c 89 04 24 89 d8 e8 ca fd ff ff 8b 55 04 89 c6 a1 e4 38 25
All code
========
   0:	04 eb                	add    $0xeb,%al
   2:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
   3:	31 db                	xor    %ebx,%ebx
   5:	e9 a5 fe ff ff       	jmpq   0xfffffffffffffeaf
   a:	8d 76 00             	lea    0x0(%rsi),%esi
   d:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
  12:	55                   	push   %rbp
  13:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  18:	89 e5                	mov    %esp,%ebp
  1a:	83 ec 18             	sub    $0x18,%esp
  1d:	89 5d f4             	mov    %ebx,-0xc(%rbp)
  20:	89 c3                	mov    %eax,%ebx
  22:	89 75 f8             	mov    %esi,-0x8(%rbp)
  25:	89 7d fc             	mov    %edi,-0x4(%rbp)
  28:	89 d7                	mov    %edx,%edi
  2a:*	8b 40 0c             	mov    0xc(%rax),%eax		<-- trapping instruction
  2d:	89 04 24             	mov    %eax,(%rsp)
  30:	89 d8                	mov    %ebx,%eax
  32:	e8 ca fd ff ff       	callq  0xfffffffffffffe01
  37:	8b 55 04             	mov    0x4(%rbp),%edx
  3a:	89 c6                	mov    %eax,%esi
  3c:	a1                   	.byte 0xa1
  3d:	e4 38                	in     $0x38,%al
  3f:	25                   	.byte 0x25

Code starting with the faulting instruction
===========================================
   0:	8b 40 0c             	mov    0xc(%rax),%eax
   3:	89 04 24             	mov    %eax,(%rsp)
   6:	89 d8                	mov    %ebx,%eax
   8:	e8 ca fd ff ff       	callq  0xfffffffffffffdd7
   d:	8b 55 04             	mov    0x4(%rbp),%edx
  10:	89 c6                	mov    %eax,%esi
  12:	a1                   	.byte 0xa1
  13:	e4 38                	in     $0x38,%al
  15:	25                   	.byte 0x25
[    6.083178][    T1] EAX: 00000000 EBX: 00000000 ECX: ffffffff EDX: 00000cc0
[    6.083178][    T1] ESI: c3213800 EDI: 00000cc0 EBP: c3217d78 ESP: c3217d60
[    6.083178][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
[    6.083178][    T1] CR0: 80050033 CR2: 0000000c CR3: 02364000 CR4: 000406d0
[    6.083178][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    6.083178][    T1] DR6: fffe0ff0 DR7: 00000400
[    6.083178][    T1] Call Trace:
[ 6.083178][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 6.083178][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 6.083178][ T1] ? __die (arch/x86/kernel/dumpstack.c:435) 
[ 6.083178][ T1] ? page_fault_oops (arch/x86/mm/fault.c:702) 
[ 6.083178][ T1] ? kernelmode_fixup_or_oops+0x94/0xf4 
[ 6.083178][ T1] ? __bad_area_nosemaphore+0x12f/0x1e4 
[ 6.083178][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:867) 
[ 6.083178][ T1] ? exc_page_fault (arch/x86/mm/fault.c:1472 arch/x86/mm/fault.c:1505 arch/x86/mm/fault.c:1561) 
[ 6.083178][ T1] ? _raw_spin_unlock (kernel/locking/spinlock.c:187) 
[ 6.083178][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 6.083178][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 6.083178][ T1] ? lookup_open (fs/namei.c:3121 fs/namei.c:3153 fs/namei.c:3456) 
[ 6.083178][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 6.083178][ T1] ? __kmem_cache_alloc_lru+0x1d/0x88 
[ 6.083178][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 6.083178][ T1] ? __kmem_cache_alloc_lru+0x1d/0x88 
[ 6.083178][ T1] kmem_cache_alloc (mm/slub.c:3503) 
[ 6.083178][ T1] tracefs_alloc_inode (fs/tracefs/inode.c:38) 
[ 6.083178][ T1] alloc_inode (fs/inode.c:259) 
[ 6.083178][ T1] new_inode_pseudo (fs/inode.c:1006) 
[ 6.083178][ T1] new_inode (fs/inode.c:1031) 
[ 6.083178][ T1] tracefs_get_inode (fs/tracefs/inode.c:153) 
[ 6.083178][ T1] ? tracefs_start_creating (fs/tracefs/inode.c:470) 
[ 6.083178][ T1] tracefs_create_file (fs/tracefs/inode.c:616) 
[ 6.083178][ T1] ? set_tracer_flag (kernel/trace/trace.c:5441) 
[ 6.083178][ T1] __wakeup_tracer_init (kernel/trace/trace_sched_wakeup.c:858) 
[ 6.083178][ T1] wakeup_tracer_init (kernel/trace/trace_sched_wakeup.c:873) 
[ 6.083178][ T1] trace_selftest_startup_wakeup (kernel/trace/trace_selftest.c:1216 (discriminator 1)) 
[ 6.083178][ T1] ? trace_selftest_ops (kernel/trace/trace_selftest.c:1155) 
[ 6.083178][ T1] ? wait_for_completion (kernel/sched/completion.c:97 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:148) 
[ 6.083178][ T1] run_tracer_selftest (kernel/trace/trace.c:2026) 
[ 6.083178][ T1] register_tracer (kernel/trace/trace.c:2063 kernel/trace/trace.c:2187) 
[ 6.083178][ T1] init_wakeup_tracer (kernel/trace/trace_sched_wakeup.c:985) 
[ 6.083178][ T1] ? init_function_trace (kernel/trace/trace_sched_wakeup.c:982) 
[ 6.083178][ T1] do_one_initcall (init/main.c:1232) 
[ 6.083178][ T1] ? parameq (kernel/params.c:89 kernel/params.c:98) 
[ 6.083178][ T1] ? parse_args (kernel/params.c:184) 
[ 6.083178][ T1] ? kernel_init_freeable (init/main.c:1304 init/main.c:1329 init/main.c:1547) 
[ 6.083178][ T1] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1547) 
[ 6.083178][ T1] ? rdinit_setup (init/main.c:1278) 
[ 6.083178][ T1] ? rest_init (init/main.c:1429) 
[ 6.083178][ T1] kernel_init (init/main.c:1439) 
[ 6.083178][ T1] ? schedule_tail (kernel/sched/core.c:5318) 
[ 6.083178][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.083178][ T1] ? rest_init (init/main.c:1429) 
[ 6.083178][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 6.083178][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    6.083178][    T1] Modules linked in:
[    6.083178][    T1] CR2: 000000000000000c
[    6.083178][    T1] ---[ end trace 0000000000000000 ]---
[ 6.083178][ T1] EIP: __kmem_cache_alloc_lru+0x1d/0x88 
[ 6.083178][ T1] Code: 04 eb a7 31 db e9 a5 fe ff ff 8d 76 00 3e 8d 74 26 00 55 b9 ff ff ff ff 89 e5 83 ec 18 89 5d f4 89 c3 89 75 f8 89 7d fc 89 d7 <8b> 40 0c 89 04 24 89 d8 e8 ca fd ff ff 8b 55 04 89 c6 a1 e4 38 25
All code
========
   0:	04 eb                	add    $0xeb,%al
   2:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
   3:	31 db                	xor    %ebx,%ebx
   5:	e9 a5 fe ff ff       	jmpq   0xfffffffffffffeaf
   a:	8d 76 00             	lea    0x0(%rsi),%esi
   d:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
  12:	55                   	push   %rbp
  13:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  18:	89 e5                	mov    %esp,%ebp
  1a:	83 ec 18             	sub    $0x18,%esp
  1d:	89 5d f4             	mov    %ebx,-0xc(%rbp)
  20:	89 c3                	mov    %eax,%ebx
  22:	89 75 f8             	mov    %esi,-0x8(%rbp)
  25:	89 7d fc             	mov    %edi,-0x4(%rbp)
  28:	89 d7                	mov    %edx,%edi
  2a:*	8b 40 0c             	mov    0xc(%rax),%eax		<-- trapping instruction
  2d:	89 04 24             	mov    %eax,(%rsp)
  30:	89 d8                	mov    %ebx,%eax
  32:	e8 ca fd ff ff       	callq  0xfffffffffffffe01
  37:	8b 55 04             	mov    0x4(%rbp),%edx
  3a:	89 c6                	mov    %eax,%esi
  3c:	a1                   	.byte 0xa1
  3d:	e4 38                	in     $0x38,%al
  3f:	25                   	.byte 0x25

Code starting with the faulting instruction
===========================================
   0:	8b 40 0c             	mov    0xc(%rax),%eax
   3:	89 04 24             	mov    %eax,(%rsp)
   6:	89 d8                	mov    %ebx,%eax
   8:	e8 ca fd ff ff       	callq  0xfffffffffffffdd7
   d:	8b 55 04             	mov    0x4(%rbp),%edx
  10:	89 c6                	mov    %eax,%esi
  12:	a1                   	.byte 0xa1
  13:	e4 38                	in     $0x38,%al
  15:	25                   	.byte 0x25


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310201530.46065346-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

