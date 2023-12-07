Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0C808AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443281AbjLGOfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443204AbjLGOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:35:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C293
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701959715; x=1733495715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lzz38CFmNv1w3ImzFjJ0wk5H6H1QV4kB/OetT+lFpa4=;
  b=AFTeEajJMqOTw5dLTOEGlbUxB0FQmCVXihuP/ZBEhkxOfYTcqGWnujwP
   OjySLVMAD6qFyxQhvXmicMm27TCDOlZ2Kk5Iv4ibyYHepR3FLJSOiNZq3
   CohaKqCVtWAd9aICnwqbbCDvPl9hhml6f+zqCuT6T2bRXb9OfyS+Ws3rC
   Gai0GgwvEdOEjjXgcVFBrldDJ/lOtlp8rlXoGVbwLLRS8EY4M3rNYbCpw
   Si9RDsNBY1/13sKITJ9UGjg+2cdWje6HwCdtLA/6X4yhvRwbnQaxdLpOS
   kyMPysHeANWPBsf/uqQERa/B+ivbaPP8cV7QKzrHxh334X/ZCouB41Xwl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1320828"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1320828"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1103213660"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103213660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 06:35:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 06:35:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 06:35:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 06:35:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAD8FeJv6MsQrO42NUUq9ozFxcxhaH133O9HLzvWAqIMo8861wo7gmEpcAXH2G/9NHK5iRnihEqYRDIUi7L0+7hPYub3j1LH8aHFdKsSWqcwPQ1evb1+qD5yEVo6qZfw7dgHB7Iy4T5uV3DpSMOQTvUZPoHoL9QCkYELjHGyFjnh7imn9QHnwpZK3Z7nU3wTcd7bewbyMGBDetlKYOIyfUmU1vDALMzmRXL+cYW/55vclKlBv0i9vq7HZzQs3zbN8zwr5dWbYUchLX5SUugIM+F6C33Hp9WGuvOmlsRy79yPiHUCPApuSGU8zu9GVsxFV4zP33bFkggT59MBpo0/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AORwfu8p8E0NJprP6KABTZxn2AwcIiH5ne3YUCYB9o4=;
 b=KDbNKqWkN5YwtxN/poEZFm/RW/SYaISgbvR7PlJkfdrONgzx0gUTFPnz8j9E+sFxJAbvCaolSb5tUgrbCYf8BmO85Y7x18yb5TTKevchX46ZPqJvOwOlOc63qkcxt+r0SfjzD90WpzjI7RkYIw8aL0K6EkMYLdQ9htkYAE19/ZNaKkXoCmWjXaTakAMcCLsFFwZPmHKvIcHqZCHMPPM/jPH7CDm/R3mH5KBxGpCWygYNrfs3hEoTah1vcfGSBoE49eCCtRivFFUujyOsqgzPqWL0nFi10J9RUbHXBbCOnTmLT6g67ouIRALwZojwFBlYxyhtFAoiSYtdwwsYdZ/5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Thu, 7 Dec
 2023 14:35:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 14:35:09 +0000
Date:   Thu, 7 Dec 2023 22:35:00 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Qais Yousef <qyousef@layalina.io>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [qais-yousef:generalized-misfit-lb] [sched/fair] 897408e9b7:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202312072255.202c77fb-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b18d58-9e58-4211-492f-08dbf731b6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ROwINhILCBILSLz8EuMtdsS/4XB+mdeAtiPaS6utxtumgJxVbhJEnIF+4xeXNTs3zztqBn/XcZLmHPau+fX8ElRsyc+vivaYjntbteCW86ye9aZzGoJtHPnCvCbzOrTlYiUQWNhwSzE4a9TaJKefPkkxMrCqicMrM2vwRJr4UCdxU7l2e6KJhDvXUAbPNUyt5tL9NFbFRWo86VQ0M9FWXqPtZ6K3xa8Ncy/sWwBmndvJkT/p99OT+tcdMpFApzQWiLnbvpbF3oS5Acy+qXRTxHe20NzDtCKIGFG4lvNKQKnJhPBiMjot7oG1WP4PLWDcfEK3vnJ9tjVsDsHAu+uFI5NoECDcLtmzBXRmHlJ9c8sRgjeOQVJytWhe15ujI+j1D5MgAm3piCHPrxqKiqyg21uT6fEqoDbRI5SGj9Ui+jJkbX5FaNCkvfzAAX6ZhppEURWrLjh5qDWjbxr4qQIiBXzRQO2AhYTyT0M/z57FU6VDg/xWbpqVw3jkvPLp02edg8T/T16Uom3YSpK5JsFN9zTGKzQEiyk2Bpajshyzg0o4ehaM7PJplcSQWvSgec4eZj/UZk4iXNgpw+5FO0SWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66946007)(66556008)(66476007)(8936002)(41300700001)(4326008)(316002)(6916009)(8676002)(478600001)(966005)(6666004)(6486002)(45080400002)(5660300002)(2906002)(36756003)(86362001)(82960400001)(83380400001)(2616005)(26005)(1076003)(6506007)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3kimsD1iKjTKl7cfnLxl2BBcXzO3aPf0aW4OvIhULMMzkf+h6njALaWIq2h?=
 =?us-ascii?Q?VpLpKVp5KUgT4eo8RnZnAn+OhCxCTPOnxV3PUqze8U5gx6ZwKnktOAxHUwoz?=
 =?us-ascii?Q?Yjvzt0UtJeSKvFFK8W/D+cMy8hgmQpYOc4+m18vzRsBO33DEmh8/ERm8td6c?=
 =?us-ascii?Q?0iLAqnilfy9oAa7KtEvsB0BWTQxxqw5x22dd//rFgBRG/xlMwjdRM8VahP3T?=
 =?us-ascii?Q?vckJvfJ6+OHQPEZ3FY3dwukTbM+XLptCJZGPmcQfe6JgbzEGzXtxpbwl3MHv?=
 =?us-ascii?Q?RqjwKmuP2MNsNlVnVWof8KXI5Y3XNBQBtb+NgNeuhEZyEnMEp8dN1lpNNPIG?=
 =?us-ascii?Q?BjRJLOQoBJUMwBG8r/UcN75IFsbzaK6la1FrvF4FwNQ/Tf5Ky429kRqnJV+S?=
 =?us-ascii?Q?ty89ndTkJBijTGdU9VBqYLgYgJVNu9qxb9ymjEzEp2U4uL81JX7T01ggw9qC?=
 =?us-ascii?Q?DB93BhtyREOZkVyT3yG3GOtWE7Cz+KYxKzFcAw4mNUwujGBWjnuB4RZMLY9h?=
 =?us-ascii?Q?kxLvgLxkjhA0TTBYIvqWcQqwqbYlzkccahgFh3Z6MPb70xSeI8Olf1eL4qkN?=
 =?us-ascii?Q?xsvjhmsz9FRluneNasthoHKZDvjExWr0MCfSeW34p832xCVJJL9lTZyVHnjP?=
 =?us-ascii?Q?/4/GRcWaH6Oif/yzTrg91/d0iB6txSXtgB5ojllZH1NfTUShIZgd3/odfDs6?=
 =?us-ascii?Q?QtjKoIbDg8cD81ivt1wj7GY2M5ov2mF7Uyfl6+F93Z4GlV3pRKkoAUlDOnc6?=
 =?us-ascii?Q?SKmVUH6U+VoW0uIVOWSVROP/aDSNPRsF3LhXsVuJWbXvjJrsossgtWcvfVu/?=
 =?us-ascii?Q?ooRg7j2xqsjG+4ziqmIhVtAT67Eegglr0jPxEadDa+bY9hp6P3VP2dZA8a9d?=
 =?us-ascii?Q?BydPgKBPvs8PWQoyvDhArrRvCILTpmNPEc14dB0GxZ+o584U4uY8N79o2DQc?=
 =?us-ascii?Q?rd5Se/SCqjJIPbDVHzj1MU5j5HJgl5H3gpiXUy2KeXQc68mjD0R4c+ErsyGO?=
 =?us-ascii?Q?pbmr1twQkGdgguubQE2P0VPiOkfyHPGg4J1WtGRY2toC6PgHkLQmet+0A8cb?=
 =?us-ascii?Q?rnfkjBU2DbnHcxrgYZA39gc1kj6D1yIG7PW4rg+99ZrMqVsWxp/5bI4hIa8C?=
 =?us-ascii?Q?HUbHlBwW7wCHJKTY0zFj/vHCCE+7Uqmujq+r/sm9tLdwvfbPj50bXlYIROjn?=
 =?us-ascii?Q?PUOOVydLmwWQFLYWdYwFKJxNcBgsy7ECg3iMvwBRFEdYDfwsIHSGHa1etJfE?=
 =?us-ascii?Q?YcKhe1SMJ0OemGGQ2VQ13UhEu2UKvcfJ04mlyriL90iy+ehZRYHR6/K34JJY?=
 =?us-ascii?Q?H23/+RfuMG4eatADQlmCmHZNGo6Ue2YkGOg2rqpITQHHUPOpMnZylm7st3+6?=
 =?us-ascii?Q?xbnfBkdvVOdU8iXuOUFJCrtO0PJaW3yU4z2KwYz0uLvtUqwnuRO1VOxj+If0?=
 =?us-ascii?Q?PDkxGfNOWXagfoFQ/LVmhx8vaJBu1YytoQAxU7UehT+xbAR+jAdHcFvmj/vn?=
 =?us-ascii?Q?mxeRjz2NvR6jBEhvwMPN6KOoyMjU2zssrP/8wv0FW1BXZyndCY0h2AHwKyFK?=
 =?us-ascii?Q?belMTu04vi+ocV35HqxLUVWVv5yBaXcFUWntjYc/9lpfszr4E5BxmFe4kqay?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b18d58-9e58-4211-492f-08dbf731b6a3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:35:09.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz/1UxWMK8TF/zwIFg3h2UoKNwSoX+3KAj/Qaq5AnjTc+yDlJvLHuEBsxd8DlH8jb0mcZVpySgkZO8s+d3Vh6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
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



Message-ID: <202312072255.202c77fb-oliver.sang@intel.com>
TO: Qais Yousef <qyousef@layalina.io>
CC: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com
BCC: 



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 897408e9b705bc0f61b481a7622c65516bb9456d ("sched/fair: Implement new type of misfit MISFIT_POWER")
https://github.com/qais-yousef/linux generalized-misfit-lb

in testcase: boot

compiler: clang-16
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------+------------+------------+
|                                                       | 59d2a8aad6 | 897408e9b7 |
+-------------------------------------------------------+------------+------------+
| boot_successes                                        | 13         | 0          |
| boot_failures                                         | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address           | 0          | 12         |
| Oops:#[##]                                            | 0          | 12         |
| EIP:load_balance                                      | 0          | 12         |
+-------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312072255.202c77fb-oliver.sang@intel.com


[    1.566108][    T2] BUG: kernel NULL pointer dereference, address: 00000814
[    1.566084][    T1] devtmpfs: initialized
[    1.566968][    T2] #PF: supervisor read access in kernel mode
[    1.566972][    T2] #PF: error_code(0x0000) - not-present page
[    1.568159][    T2] *pde = 00000000
[    1.568159][    T2] Oops: 0000 [#1] PREEMPT SMP
[    1.568159][    T2] CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.7.0-rc1-00024-g897408e9b705 #7
[    1.568159][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.568159][ T2] EIP: load_balance (kernel/sched/fair.c:11258) 
[ 1.568159][ T2] Code: 35 b0 db cd c2 8b 4c 24 1c 8b 44 24 28 8b 51 08 8b 4c 24 40 83 f8 08 0f 83 37 19 00 00 0f a3 01 0f 83 3b 1c 00 00 8b 44 24 20 <83> b8 14 08 00 00 01 75 11 8b 44 24 2c 83 b8 14 08 00 00 01 0f 85
All code
========
   0:	35 b0 db cd c2       	xor    $0xc2cddbb0,%eax
   5:	8b 4c 24 1c          	mov    0x1c(%rsp),%ecx
   9:	8b 44 24 28          	mov    0x28(%rsp),%eax
   d:	8b 51 08             	mov    0x8(%rcx),%edx
  10:	8b 4c 24 40          	mov    0x40(%rsp),%ecx
  14:	83 f8 08             	cmp    $0x8,%eax
  17:	0f 83 37 19 00 00    	jae    0x1954
  1d:	0f a3 01             	bt     %eax,(%rcx)
  20:	0f 83 3b 1c 00 00    	jae    0x1c61
  26:	8b 44 24 20          	mov    0x20(%rsp),%eax
  2a:*	83 b8 14 08 00 00 01 	cmpl   $0x1,0x814(%rax)		<-- trapping instruction
  31:	75 11                	jne    0x44
  33:	8b 44 24 2c          	mov    0x2c(%rsp),%eax
  37:	83 b8 14 08 00 00 01 	cmpl   $0x1,0x814(%rax)
  3e:	0f                   	.byte 0xf
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	83 b8 14 08 00 00 01 	cmpl   $0x1,0x814(%rax)
   7:	75 11                	jne    0x1a
   9:	8b 44 24 2c          	mov    0x2c(%rsp),%eax
   d:	83 b8 14 08 00 00 01 	cmpl   $0x1,0x814(%rax)
  14:	0f                   	.byte 0xf
  15:	85                   	.byte 0x85
[    1.568159][    T2] EAX: 00000000 EBX: fffedb16 ECX: c3c38398 EDX: c3c919a0
[    1.568159][    T2] ESI: c3c383a8 EDI: c3c38398 EBP: c3e7be98 ESP: c3e7bd20
[    1.568159][    T2] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010093
[    1.568159][    T2] CR0: 80050033 CR2: 00000814 CR3: 02e36000 CR4: 00040690
[    1.568159][    T2] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.568159][    T2] DR6: fffe0ff0 DR7: 00000400
[    1.568159][    T2] Call Trace:
[ 1.568159][ T2] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 1.568159][ T2] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 1.568159][ T2] ? page_fault_oops (arch/x86/mm/fault.c:703) 
[ 1.568159][ T2] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 1.568159][ T2] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:761) 
[ 1.568159][ T2] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:817) 
[ 1.568159][ T2] ? bad_area_nosemaphore (arch/x86/mm/fault.c:866) 
[ 1.568159][ T2] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
[ 1.568159][ T2] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 1.568159][ T2] ? exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 1.568159][ T2] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.568159][ T2] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 1.568159][ T2] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.568159][ T2] ? load_balance (kernel/sched/fair.c:11258) 
[ 1.568159][ T2] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1518) 
[ 1.568159][ T2] ? load_balance (kernel/sched/fair.c:11258) 
[ 1.568159][ T2] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 1.568159][ T2] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 1.568159][ T2] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 1.568159][ T2] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 1.568159][ T2] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 1.568159][ T2] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 1.568159][ T2] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 1.568159][ T2] ? lock_acquire (kernel/locking/lockdep.c:?) 
[ 1.568159][ T2] ? update_blocked_averages (kernel/sched/sched.h:1401) 
[ 1.568159][ T2] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 1.568159][ T2] ? lock_is_held_type (kernel/locking/lockdep.c:?) 
[ 1.568159][ T2] newidle_balance (kernel/sched/fair.c:12425) 
[ 1.568159][ T2] pick_next_task_fair (kernel/sched/fair.c:8521) 
[ 1.568159][ T2] __schedule (kernel/sched/core.c:6021) 
[ 1.568159][ T2] ? debug_smp_processor_id (lib/smp_processor_id.c:60) 
[ 1.568159][ T2] schedule (kernel/sched/core.c:6802 kernel/sched/core.c:6816) 
[ 1.568159][ T2] kthreadd (kernel/kthread.c:753) 
[ 1.568159][ T2] ? kthread_stop_put (kernel/kthread.c:737) 
[ 1.568159][ T2] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 1.568159][ T2] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 1.568159][ T2] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    1.568159][    T2] Modules linked in:
[    1.568159][    T2] CR2: 0000000000000814
[    1.568159][    T2] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231207/202312072255.202c77fb-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

