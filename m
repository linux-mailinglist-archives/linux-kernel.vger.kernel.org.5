Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5E58081B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377867AbjLGHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjLGHOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:14:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA810C4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701933295; x=1733469295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uP/rW2h26wQKf5si47lpxRB+72uhSURU/9uU7uE4noI=;
  b=JFqr3xl8iUMQy+9innZ5Znf2i9UPwAlkbIiepF/zsywZGI1JgUfSnQEv
   DuQkSifBRC/EdENivBMMZbCFCTgWebPVaSsfDK7wLwZGfr5I19rmO+Tp7
   MT24l6nsQheUOFpeadha+uRAu2LdN2xbI9/HNON/QqjmUmcFEoz01j8z9
   IAmaUQ3wKi7Yx/oLtkbjI/0V3N2B5qSdQv0jbLAC/MMAlOncr5tXD4njf
   GTVkWHmXtgjpcRUWGFxmdUpDS0dOT/6eg9e7+UzKwM15Vk13egwn6qrlq
   d+Ewkh8nt9XfVrVg7ASbBX655k4Y0fW12TVY36vvtsHdFxAK8PK4hieHa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="373675828"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="373675828"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 23:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018847336"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018847336"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 23:14:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 23:14:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 23:14:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 23:14:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDo4233SEzLGglr79R5NFhvWbzJ/VFq2M2Gj/waNOunm1fQW7Te0eR6/70qtpTAHbHEiGjQz1fvZuN/rznhshv4oZWllNLwPrtrMKK6E/+WifEhqXAD39UfGIakgF7olQP35OkGNISGmMenlaKSxoqzqmEHTECuUWUNmr2lNnZ1OSP/gk86lsCrUQmzPaY7ZMpoVr/A/g4ovkuPhjKznP1CyUe5y123BIg4/55MQa0/VmXWIkXelU0/2BjhEe/dg30BGGt4p4e4Jseeai8yFZZqSnd7aXfCBeVTIw0sxR1TddAYd8dxR7bTuxJCidjVKo/z587ktVZK19DzXddmC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ArGUh2d1+gtdU5FiCV1yimCCcslsrfmSoFGRJLt+7Q=;
 b=J9/ZOhGSqCXK6IEO+KgdBQkBC1n8TmE/CrAG+U/wFFOeXRWqxFSKooNbNF4iugaGpHYkG/RxHHVmhGtYPakGueYMWrfcK8/NjSdOLjyPR/y19AxWzbTnCZXQKFfq4NznxQFONmNcwDKEiFyNC0oL/65bYP+4B0Q1DeN82JIoLlA2arXm9WhAZ8T/IqX8XXE3vTcoiALwHBF67czhO/NGketAOeXDVJT0YCJeQEzcMk+eR+iOAKvCNWDppzGThwFmdV/WhLPbCCbP2DhkwKhmx+xEancHeRyikJCKE72woUAmX46/cno1M4VYhhFNR1HhFkEaALFO8HXG9I0fMEjVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 07:14:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 07:14:45 +0000
Date:   Thu, 7 Dec 2023 15:14:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [peterz-queue:x86/kvm] [objtool]  a150ba8e3e:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-ID: <202312071255.667f7028-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bec360-e67f-4721-f678-08dbf6f430a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epode6eQ1H632aEZMVBjAcoXjYHjO1M7aTrhpbDloxAPHFweI5a94dFnfXhTBTD5GSorkabbNisIlh6L14D3cfg0WVvps8D+wbbUthEDAhKsn2m7qQ6r/3buVYVatLUPHDHh9N7C2DMniKETjl+HJFSDjXBL3tk1ZkA+37xLIYSeUa+h5Q0oT/zgvVpwmVRx3XPXwqgfxXIajNzueLjdyJhB+tFnXmY4QVXwhL1Ua01opTbTF6EcPo7BEvXBEnCg221b41QhCoE0OqAYcD7Z4v+FvMll4tHy11FjoQE79pRqqiJ9+SXHnF4mJfDfe9uKGSTZ4QzsKr4x9xrhQXcAyFhDyDSJuC3B2sEGRHHZfaM/U9jC9Dduzn+gstNscdyx9ViZM5bMfJ4oGYRKglCVpDDit7QVdk1aPp96flEaVaVCT/rcx5Eo9UH1xcaQ6BTvuTA1vXA3Fxxerg3vyDXNNWB6AMnUfmKmee96m884be9GHR44QDNeMwpwXjXqX5JR2bZ8ZeZZXscUVyZwvSmAe9eSGpJN1B3R9IstS4CmbLgPxZQCaiV0pXLdjGEdllbjNRynvJibPJjUfO5XdUmKCULSVq6xWi5S6gFehXu5O7ArjJhQHBExarNRInWQJ6GN6/x7xvD7T9KtNV9cFLqrHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(8676002)(8936002)(5660300002)(6666004)(966005)(36756003)(2616005)(6512007)(6506007)(107886003)(6916009)(316002)(6486002)(45080400002)(66476007)(66556008)(478600001)(66946007)(41300700001)(4326008)(2906002)(38100700002)(82960400001)(26005)(1076003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmiE5TI3CSbpfv5VOuEZD21Uc1LiCWw0IGDbUs3yUibWsWgelrpL/ewMGiju?=
 =?us-ascii?Q?vdfEMWNlOoYP7pDdCp4KrxJtnIlt9IlSArApTSwolb9q7TApXv/2WbMD3qQh?=
 =?us-ascii?Q?81sajjh5Sizewb5/qfIYrRkkV948JR6LJnEmheWgti+y/ZNlL2hoZlqqrHLg?=
 =?us-ascii?Q?73tLXMzmORrMw8F1weTW20TU1Qny/4Rbz3YKtHM7SmHVYNnCtzX5he2u4nFi?=
 =?us-ascii?Q?IA0Qc4evFpEu+ePk9oIP8PMK37Pv2nLdwjAvv8WkGdmXGVT56RfFs/FEhAGe?=
 =?us-ascii?Q?1HQY0WIeMp5UCHQQQ2sQwMH7Ixr9olz7aB9aVijzZ2xxdHZ1WHMZKbjixOtZ?=
 =?us-ascii?Q?ZPJynzXfh088tFp+HxD7Zulw+75T8DafhPK8XZshvV6IQns8pD5LmkZ1UOh3?=
 =?us-ascii?Q?MvgoKlv+Wej7xx1Aa98rVVCzbMQdZuycdjBrJS1xCB0tOfldKMBxvy6khYE4?=
 =?us-ascii?Q?RnHK1WaNhfGsuxnnRjXXfkAUj2YRTL7POhUzftNgYSChmzFkXVa8cqkuEray?=
 =?us-ascii?Q?EL/5nOFy9rkTPSorvU9r0zrdJexYccuMGVha+dyaS+ytE0WnLIMkOI6qu16z?=
 =?us-ascii?Q?L9fo7VpcrO2Z7JTAdjTLOtFMBWog23BlbrMNHJM0Zfg1MCL+IZGUq7XzLDUL?=
 =?us-ascii?Q?IbxevihfqYR1hh6heUZRws9GFyDtMSo98+NX6wALuDwgCmCt4MGTSd0agUBf?=
 =?us-ascii?Q?i68sG4k1paI/35lGLfsZFEaZptEVJcBhYj6PmzcXhnC1/FuGyt0sLakM1jYT?=
 =?us-ascii?Q?HspjdK+oUlikK7vNvv2XLKWBpVSqAJv0iYufYAf8+L6c8NMGZ/3A8g+f50o8?=
 =?us-ascii?Q?jJoAqG/L1HpEXipcpGS30PFvg4PTqkzfe3zevbTdjlibBNKEKHO54dBXxl7h?=
 =?us-ascii?Q?LPvJDLGWp6dg9iWDQnfeP7cGqd9yL+Cq5tFHgGFkpAi6oMNMvOX6vLvplnef?=
 =?us-ascii?Q?h/wKFbarqkBlsKTq/WXBuyWcqPGqS1VDQVrqu/SYVa8i7Bazy5tizg61bn2f?=
 =?us-ascii?Q?WPn6HwaH4i7QBK584f5m1o4R6VCLybI/KgLP72F28YkVz9vP8Yp5YE3eNgwa?=
 =?us-ascii?Q?3/OejUV276+0cg8jykxYuXexb8xrVBpw1msKDpSZL1l9pbQnu/9ne3lus4X1?=
 =?us-ascii?Q?JTA8BNzSAw7t/6aAB67RtmgEOpYOSCWc/7Yvju4V0bEA1qP3zzf3I5Oye1D1?=
 =?us-ascii?Q?d0AvT66Ppul7LxJgUMyuiPDc8yPdfz7v0LvN0G+PYKYnbv1s7MjRgGo9ccFt?=
 =?us-ascii?Q?oLQ7wxv5/iCT9nWINsX8S2KXFG1RXmJC/d9v4h0m5zJ2n02sAvH7WjM31g1G?=
 =?us-ascii?Q?ZmlDTiajlN39DDWyBnM8yezrxh/aRf2gAYZXCaCTxI5Piesy7OzpvAkjSHo0?=
 =?us-ascii?Q?QeS0bx0r8eevfWc/z/J1R+cib3dpqceXpKxGQd/3sjWY7xE3TN+rkEeOfhTT?=
 =?us-ascii?Q?LdaHvtCrrl5rFxlXY+NOzzzH2YYzNfrtD5NKq5i4tWg0cp0HwrB/XTs20NfE?=
 =?us-ascii?Q?sXMmNPeUbLr0ZAAw0iYpbO3X28w8Ydd1PD4k5VA2Wwx7Kh4yKPPXoM6OeZ2G?=
 =?us-ascii?Q?Fq47/nxfBhgTwvHU91z9sx4yDNs6RlJQFSnx19N0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bec360-e67f-4721-f678-08dbf6f430a3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 07:14:45.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM61z9XXGGC8AVO7e6O8j6/iR7wAPqPPYuT7XNSwnrjUP+9WCJHwOxaFjm2NwZlioniqRGIqSPGV2Zbi3eEE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:

commit: a150ba8e3e8f68327fb4d6a2ea801313e653ac63 ("objtool: Convert ANNOTATE_INTRA_FUNCTION_CALLS to ANNOTATE")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git x86/kvm

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | c0b9ba21ec | a150ba8e3e |
+-----------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace.c:#run_tracer_selftest                        | 0          | 37         |
| RIP:run_tracer_selftest                                                     | 0          | 37         |
| WARNING:at_kernel/trace/trace.c:#init_trace_selftests                       | 0          | 37         |
| RIP:init_trace_selftests                                                    | 0          | 37         |
| WARNING:at_kernel/trace/trace_events.c:#event_trace_self_test_with_function | 0          | 37         |
| RIP:event_trace_self_test_with_function                                     | 0          | 37         |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312071255.667f7028-oliver.sang@intel.com


[    4.298418][    T1] ------------[ cut here ]------------
[ 4.300350][ T1] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:2031 run_tracer_selftest (kernel/trace/trace.c:2031) 
[    4.303679][    T1] Modules linked in:
[    4.305714][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.7.0-rc3-00007-ga150ba8e3e8f #1 1842589a931247defa08c7633f42656bec93c944
[    4.309165][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 4.312930][ T1] RIP: 0010:run_tracer_selftest (kernel/trace/trace.c:2031) 
[ 4.315589][ T1] Code: 00 00 00 ba ff ff ff ff e8 82 ea fd ff 48 c7 c7 e0 73 91 97 e8 06 21 5d 03 e9 9b fe ff ff 48 c7 c7 60 73 91 97 e8 f5 20 5d 03 <0f> 0b bb ff ff ff ff e9 83 fe ff ff 4c 89 ff 48 c7 c6 20 fe 1e 99
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 ba ff ff ff ff    	add    %bh,-0x1(%rdx)
   8:	e8 82 ea fd ff       	call   0xfffffffffffdea8f
   d:	48 c7 c7 e0 73 91 97 	mov    $0xffffffff979173e0,%rdi
  14:	e8 06 21 5d 03       	call   0x35d211f
  19:	e9 9b fe ff ff       	jmp    0xfffffffffffffeb9
  1e:	48 c7 c7 60 73 91 97 	mov    $0xffffffff97917360,%rdi
  25:	e8 f5 20 5d 03       	call   0x35d211f
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  31:	e9 83 fe ff ff       	jmp    0xfffffffffffffeb9
  36:	4c 89 ff             	mov    %r15,%rdi
  39:	48 c7 c6 20 fe 1e 99 	mov    $0xffffffff991efe20,%rsi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
   7:	e9 83 fe ff ff       	jmp    0xfffffffffffffe8f
   c:	4c 89 ff             	mov    %r15,%rdi
   f:	48 c7 c6 20 fe 1e 99 	mov    $0xffffffff991efe20,%rsi
[    4.321810][    T1] RSP: 0000:ffff888105277ac8 EFLAGS: 00010282
[    4.327570][    T1] RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffff98d93260
[    4.331405][    T1] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881052778d8
[    4.332658][    T1] RBP: ffffffff99db94c8 R08: ffff8881052778df R09: 1ffff11020a4ef1b
[    4.335563][    T1] R10: dffffc0000000000 R11: ffffed1020a4ef1c R12: ffffffff99d88780
[    4.339230][    T1] R13: dffffc0000000000 R14: ffffffff99d88720 R15: 1ffffffff33b10f0
[    4.340714][    T1] FS:  0000000000000000(0000) GS:ffffffff98cee000(0000) knlGS:0000000000000000
[    4.344752][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.347562][    T1] CR2: ffff88843ffff000 CR3: 00000003ce2ca000 CR4: 00000000000406f0
[    4.351396][    T1] Call Trace:
[    4.352146][    T1]  <TASK>
[ 4.353634][ T1] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 4.355563][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031) 
[ 4.357961][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031) 
[ 4.360316][ T1] ? report_bug (lib/bug.c:?) 
[ 4.362560][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 4.364289][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 4.366537][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 4.368449][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031) 
[ 4.370964][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031) 
[ 4.372372][ T1] ? init_trace_selftests (kernel/trace/trace.c:2093) 
[ 4.374883][ T1] ? do_one_initcall (init/main.c:1236) 
[ 4.376326][ T1] ? latency_fsnotify_init (kernel/trace/trace.c:2076) 
[ 4.378988][ T1] ? do_initcall_level (init/main.c:1297) 
[ 4.380357][ T1] ? do_initcalls (init/main.c:1311) 
[ 4.382585][ T1] ? kernel_init_freeable (init/main.c:1555) 
[ 4.384377][ T1] ? rest_init (init/main.c:1433) 
[ 4.386655][ T1] ? kernel_init (init/main.c:1443) 
[ 4.388330][ T1] ? rest_init (init/main.c:1433) 
[ 4.390632][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.392335][ T1] ? rest_init (init/main.c:1433) 
[ 4.394615][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[    4.396345][    T1]  </TASK>
[    4.397946][    T1] irq event stamp: 4047
[ 4.399559][ T1] hardirqs last enabled at (4059): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 4.403563][ T1] hardirqs last disabled at (4070): console_unlock (kernel/printk/printk.c:339) 
[ 4.407564][ T1] softirqs last enabled at (3878): irq_exit_rcu (kernel/softirq.c:646) 
[ 4.411562][ T1] softirqs last disabled at (3861): irq_exit_rcu (kernel/softirq.c:646) 
[    4.415563][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231207/202312071255.667f7028-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

