Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F777B33A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjHNIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjHNIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30FFA6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692000241; x=1723536241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ahRzTmQHPr7+LrmlUb+cJtlCVUcD88WJYpYPQe72Re8=;
  b=CsBgFVUL1B35ZXY0yQfO5jzJn7ZirH0rUOedPxny9a26dRWFtu9eDaXm
   pAJvZ3Q5JuPH8OC1ZVlMH1EGnbH3trzfts84hUCSdZF04bF0ImpFqsgzZ
   W59B3rv2pstodN7FiMhVKytae0VvoT86qyi3Ls9SLouXGGQ7CelEDU7sg
   fFfkZ7e+bluygrQ67FeKQTvQsweyX6g7kzoNkvYxbJsnangwwIwNuCSHB
   8kjzOU3xz0otdhbyMoIBI8KBBe8WmelP05LJsblJekm0cCc6JJxpM208i
   knkRlL06Fzdk03u/T7oiXqk5kYSPKnIzNF8LeA5xZZZFij7tS2EhZeQaF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438320418"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438320418"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 01:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="710240154"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="710240154"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 01:04:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:04:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 01:03:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 01:03:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 01:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgy1stUjY2K0ITRKJPf+KKRsQ1+yqo7fJUSjukzfGzIAa/BdIM7zaujLCdfYFNMhKJELN37Yv9OTmAH1rguF70zrVuLx604tneimdp2R3fA5rEIQHQYI1RztlIEUC7Dh6yskkbseTvbwvxRNni0GV1dgjRkcEby7Uz+Tkla8XW5BWaDZs9ZciNl1sV19GXimL7WhwltA7v6lcCfXISUNImM64ZnOgQWbD92jlUMWeQp+kLO9QhtJ1hX6Nr3eGJBdzkA+5zATf1dtjISfSwq3cIOaiMy7r3QcUka+Uw4pTC1pPCgU5YxMIJY9FUBCmrcbFHbl7jlJ0t/gKOzaAB84Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enHsp+fLu4indGqVSfI7XESLSSEWglaDKM7n1wztirE=;
 b=XUIBCfaBZmDpOg+TKlWvihzEwhThMc6dGC5GRsaFFFg8mz3TkYPUhCL09mgU+zAhA0NRjC696CrLa+F1m/UwyC1R8VbOcFuTyOZvCK3h5V7J4ieqkzR67OftxvXcLZ/SC9kJb0a8upeWUkYZLBVRcPAqDaXG7OR8HCBDBHVF7t7jLp6w+5gp9kF/T9BeLpbRqPcJSPq2iUHhFGAVdl9yei9I7ZtGayvDqUJrQ9HMnZWoe+Lrs7ou3V8hl00sBBd58zUwIR2qpCNTuecaIf6eYF6AWhIWCMku9d7OOt2F+yjt2DbVGKQBM4UMnL/8rt+6SiOP9Jc81H2BCGsnuQcl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:03:52 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:03:52 +0000
Date:   Mon, 14 Aug 2023 16:03:43 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [x86/cfi]  9831c6253a:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202308141050.5a684da8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ0PR11MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 648cc83b-2335-4188-1bae-08db9c9cffc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCMxjcN7E/Lm9qivi7QBcbI5MUNaOoftGRV73FVNR7M45NA3NjiVij4EtL4j+KUxpYh8+ZEIWfcYDFTe+PvsvvuHYPXiEREhYgLMC0kwHMrVxRQNt+Mk2dsO0XUSRo8LIUk5eXr8b6cPt/qrk36jNv6zfQZQJw6dqTZjJ8eeNSLrjumJITeKK63UvqkjMB1oARCqX9IkX7fQ1tHZ3LJcVVD8+D0YymunjjnHrO6zjYuM+Lo/QlEkAag9BOntgfqdBIQaP83YuzY3/Hgo+0MPg7EBZatls8hLEVuqd4r4+29ipq9U7H7jyL63btqMlZbG0C0HL1gV1RC8d1NQUmCVY9zodR2nuFWWamxa21llxiuIDVbS1vzkW8sdU7+/EAaV9Q7CIIla6AouIC5eESiYntav8WkzrdLb+jaGM499GtIwAfWBid85Edh0b2tGuklMiUVjq9erJUZscSCTg54xW9+OHW9AiJCkwDkka+iMkb6WObQY1bdmnq8gGHrvopo4zXSKtr+HCpNBv/YPj9VUU3kVvwHOGOpNo1m5JgWG6qCKZes5cTIh7X6tHCIYJSCgXUU005ai9ZMmNiFsQb0l8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(396003)(346002)(1800799006)(186006)(451199021)(2906002)(5660300002)(41300700001)(8676002)(8936002)(316002)(6486002)(45080400002)(478600001)(6666004)(107886003)(36756003)(66556008)(66476007)(6916009)(66946007)(6512007)(4326008)(966005)(54906003)(2616005)(82960400001)(86362001)(1076003)(83380400001)(6506007)(26005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHjfWckcUvRxFd2BYRE6jzlUT6CHcnbDVDp6AWH/zH4Qjp7FG/pkIWSSv3m0?=
 =?us-ascii?Q?W4lVok0qhNjrOyIKvUHG2neWfwUGxm7qIvrTxxjtIHLQUPUmjiUPMEytOjqr?=
 =?us-ascii?Q?WJh88Zw7xrW9cOSchrku8XOnuJuloHFctBu/vT4oSo1aDsedVgw8J1hrDXzh?=
 =?us-ascii?Q?5UeJ+YiabCuxLJ1JBfA5ddM9cR/NUlY7C/UWot5+gwQ0jq6v+rshF7Nl8OaM?=
 =?us-ascii?Q?AMRs49xI5MiDJdW4PCbB+dCllgUeGiA/9r9CIPxr7b4OhnhnZmGyT+DZMvn4?=
 =?us-ascii?Q?MH28IF8XTnOksPyJgsogRGRkzqhI4OYSMACJVx/44dDY0OYhWmeKACelTopC?=
 =?us-ascii?Q?wNiv0YbpGu8Hv5zlymu1ZoELKw4fSFFgkx057aA+DJHNu+3lyr0c/FlJjkB5?=
 =?us-ascii?Q?nNh9qHkC/LdZ5gVkQy0YspOIJJ6ue36KymYBNAkzM1VLmhJxP/bwLzaiY2d0?=
 =?us-ascii?Q?A8byW34qJdXU7nJPKvtzTSYia0wBWFvACGhS1Sc85hLDBU0bw/zqnsjnsiCN?=
 =?us-ascii?Q?G8G8/cQkIAvnKQfkikxzB7QMh9iS1rfsT9MXnZa89OCsUf3nzZPwVPirMCh1?=
 =?us-ascii?Q?cTZNhXVkC409JVjBTjL7Bp+yckT04XnI3E81I/Y1nHwACmUeyeZCb5yflJy2?=
 =?us-ascii?Q?45gJct3Pd2nXsQkG1Q8EY3R/V8oWbwF+q6eRT63iZ875EBal0F1sxOxj2cxC?=
 =?us-ascii?Q?2H2rSBgJ11A4O32UAUf78erjrEARpKWqCnK5wpdQ+VH2khrW2kfbXPrB8vPX?=
 =?us-ascii?Q?kdJSlLfm0eBEeRKIWT5OjeDhJTusn7Nsymy6iZgtkPZc786wfOKHGrg7lc6E?=
 =?us-ascii?Q?I47wYxHbtQdqWQVrzM90ODBFT3Q/1wWSmWQuRAE2F0aE/nB0Df2u2xb0b/v0?=
 =?us-ascii?Q?DF1hlAQ5Df52MPdj7iy4RmSwkSpHrcEMLFFWdx63pjDQG/FY7GhC5PNsXpup?=
 =?us-ascii?Q?xNOMzkYqRTcu7Kdk3qyCKxzujQIS6YtyNCemdzY6Pqvlk8YQV96GJ4I/lwj9?=
 =?us-ascii?Q?UgGric8RRi5yzRxhH4Vz/NXJuaDkC3R+o4oVviLaA88vYD6s/YrUqTPKOgT4?=
 =?us-ascii?Q?2B5/TngZna3x6wRp5fZh2MtjNpBaWluJbqFJEV5pa/pDJNG8V/O1GWlyO5kj?=
 =?us-ascii?Q?7TV4lNMGBU0rdIc1qOFmDRTrl+1eeNDLNytlp69huqFTX/L6EL24w5lI8Wq7?=
 =?us-ascii?Q?8+7oEhP267XWlMuRC7tgao5y1agafSAJNFee/PlmIflypPYmlqfngjITsmif?=
 =?us-ascii?Q?k6braRNq9tmVwIpisbKN2+xBo0C1TvmcqbWx7nfJb3YfvKzD6iP2XSDR2BKy?=
 =?us-ascii?Q?sBEE1U9YqC4+5DqRxCS7UKYEujP+LKqPVaSjz7u5PwpVvaNAFRdYzUEf/fFO?=
 =?us-ascii?Q?u2Wyyr5VPoYu9GzU1M4c2EzWe5kaRg2b8Bwroj2BzYL4hpgZ9w+wdnKblZLm?=
 =?us-ascii?Q?6Fel26G4uyKEdyOAx62BK2SZefpzccCzNz7AosCte/xMqW/kpM269R2uhD91?=
 =?us-ascii?Q?jSINbjXVw9Fir/HHk5K02VJqvsOVUif21TnIIRUzSLqPrsJdZ5uv5moNZFCC?=
 =?us-ascii?Q?okxzBY9jHpIhKlCtYmY5vUc8mi+NpYHsJpni/EvVZOItHUsqWyPhP4urvwBN?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 648cc83b-2335-4188-1bae-08db9c9cffc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 08:03:52.5608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjafU4SYtgkb7Jhb7bqDQ41TzFzeH8DsznMEVcVXuf977YNqJUIHE8JZEeLwcsBts6nPtFlqkQlloOwpZRI/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
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

commit: 9831c6253ace48051189f6d18a15f658f94babc2 ("x86/cfi: Extend ENDBR sealing to kCFI")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 190bf7b14b0cf3df19c059061be032bd8994a597]
[test failed on linux-next/master 21ef7b1e17d039053edaeaf41142423810572741]

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | be0fffa5ca | 9831c6253a |
+---------------------------------------------+------------+------------+
| boot_successes                              | 24         | 0          |
| boot_failures                               | 0          | 24         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 24         |
| Oops:#[##]                                  | 0          | 24         |
| RIP:ip_vs_control_init                      | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 24         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308141050.5a684da8-oliver.sang@intel.com


[   12.691264][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   12.691864][    T1] #PF: supervisor write access in kernel mode
[   12.691864][    T1] #PF: error_code(0x0002) - not-present page
[   12.691864][    T1] PGD 0 P4D 0
[   12.691864][    T1] Oops: 0002 [#1] PREEMPT SMP
[   12.691864][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T  6.5.0-rc1-00003-g9831c6253ace #1 bd2f260f97826618a72d724b7d0f852f1c6afa47
[ 12.691864][ T1] RIP: 0010:ip_vs_control_init (net/netfilter/ipvs/ip_vs_ctl.c:?) 
[ 12.691864][ T1] Code: f6 e8 79 d9 d8 fd ba 00 08 00 00 48 c7 c7 30 da a2 ac 31 f6 e8 66 d9 d8 fd 48 c7 c7 e0 8b bc aa e8 da 3a ab fd 89 c1 c1 f9 1f <21> 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f b7
All code
========
   0:	f6 e8                	imul   %al
   2:	79 d9                	jns    0xffffffffffffffdd
   4:	d8 fd                	fdivr  %st(5),%st
   6:	ba 00 08 00 00       	mov    $0x800,%edx
   b:	48 c7 c7 30 da a2 ac 	mov    $0xffffffffaca2da30,%rdi
  12:	31 f6                	xor    %esi,%esi
  14:	e8 66 d9 d8 fd       	callq  0xfffffffffdd8d97f
  19:	48 c7 c7 e0 8b bc aa 	mov    $0xffffffffaabc8be0,%rdi
  20:	e8 da 3a ab fd       	callq  0xfffffffffdab3aff
  25:	89 c1                	mov    %eax,%ecx
  27:	c1 f9 1f             	sar    $0x1f,%ecx
  2a:*	21 00                	and    %eax,(%rax)		<-- trapping instruction
  2c:	00 00                	add    %al,(%rax)
  2e:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	66 0f 1f 00          	nopw   (%rax)
  3e:	0f                   	.byte 0xf
  3f:	b7                   	.byte 0xb7

Code starting with the faulting instruction
===========================================
   0:	21 00                	and    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	66 0f 1f 00          	nopw   (%rax)
  14:	0f                   	.byte 0xf
  15:	b7                   	.byte 0xb7
[   12.691864][    T1] RSP: 0000:ffffc90000013ba8 EFLAGS: 00010246
[   12.691864][    T1] RAX: 0000000000000000 RBX: ffffffffab5ef700 RCX: 0000000000000000
[   12.691864][    T1] RDX: 0000000000000000 RSI: ffff88842fc22f88 RDI: 00000000000001ff
[   12.691864][    T1] RBP: ffffc90000013ee0 R08: fffffffffffa2fe1 R09: ffff88810226c000
[   12.691864][    T1] R10: 0000000000000000 R11: ffffffffa9176710 R12: ffffffffaa4936e0
[   12.691864][    T1] R13: 0000000000000000 R14: ffffffffab7388c4 R15: 0000000000000000
[   12.691864][    T1] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   12.691864][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.691864][    T1] CR2: 0000000000000000 CR3: 0000000058ea8000 CR4: 00000000000406a0
[   12.691864][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.691864][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.691864][    T1] Call Trace:
[   12.691864][    T1]  <TASK>
[ 12.691864][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 12.691864][ T1] ? page_fault_oops (arch/x86/mm/fault.c:703) 
[ 12.691864][ T1] ? __rtnl_unlock (net/core/rtnetlink.c:139) 
[ 12.691864][ T1] ? exc_page_fault (arch/x86/include/asm/paravirt.h:689 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1494 arch/x86/mm/fault.c:1542) 
[ 12.691864][ T1] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 12.691864][ T1] ? __cfi_ip_vs_init (net/netfilter/ipvs/ip_vs_core.c:2387) 
[ 12.691864][ T1] ? __cfi_ip_vs_dst_event (net/netfilter/ipvs/ip_vs_ctl.c:1767) 
[ 12.691864][ T1] ? ip_vs_control_init (net/netfilter/ipvs/ip_vs_ctl.c:?) 
[ 12.691864][ T1] ? ip_vs_control_init (net/netfilter/ipvs/ip_vs_ctl.c:?) 
[ 12.691864][ T1] ip_vs_init (net/netfilter/ipvs/ip_vs_core.c:2391) 
[ 12.691864][ T1] ? __cfi_ip_vs_init (net/netfilter/ipvs/ip_vs_core.c:2387) 
[ 12.691864][ T1] do_one_initcall (init/main.c:1232) 
[ 12.691864][ T1] do_initcall_level (init/main.c:1293) 
[ 12.691864][ T1] do_initcalls (init/main.c:1307) 
[ 12.691864][ T1] kernel_init_freeable (init/main.c:1550) 
[ 12.691864][ T1] ? __cfi_kernel_init (init/main.c:1429) 
[ 12.691864][ T1] kernel_init (init/main.c:1439) 
[ 12.691864][ T1] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[   12.691864][    T1]  </TASK>
[   12.691864][    T1] Modules linked in:
[   12.691864][    T1] CR2: 0000000000000000
[   12.691864][    T1] ---[ end trace 0000000000000000 ]---
[ 12.691864][ T1] RIP: 0010:ip_vs_control_init (net/netfilter/ipvs/ip_vs_ctl.c:?) 
[ 12.691864][ T1] Code: f6 e8 79 d9 d8 fd ba 00 08 00 00 48 c7 c7 30 da a2 ac 31 f6 e8 66 d9 d8 fd 48 c7 c7 e0 8b bc aa e8 da 3a ab fd 89 c1 c1 f9 1f <21> 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f b7
All code
========
   0:	f6 e8                	imul   %al
   2:	79 d9                	jns    0xffffffffffffffdd
   4:	d8 fd                	fdivr  %st(5),%st
   6:	ba 00 08 00 00       	mov    $0x800,%edx
   b:	48 c7 c7 30 da a2 ac 	mov    $0xffffffffaca2da30,%rdi
  12:	31 f6                	xor    %esi,%esi
  14:	e8 66 d9 d8 fd       	callq  0xfffffffffdd8d97f
  19:	48 c7 c7 e0 8b bc aa 	mov    $0xffffffffaabc8be0,%rdi
  20:	e8 da 3a ab fd       	callq  0xfffffffffdab3aff
  25:	89 c1                	mov    %eax,%ecx
  27:	c1 f9 1f             	sar    $0x1f,%ecx
  2a:*	21 00                	and    %eax,(%rax)		<-- trapping instruction
  2c:	00 00                	add    %al,(%rax)
  2e:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	66 0f 1f 00          	nopw   (%rax)
  3e:	0f                   	.byte 0xf
  3f:	b7                   	.byte 0xb7

Code starting with the faulting instruction
===========================================
   0:	21 00                	and    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	66 0f 1f 00          	nopw   (%rax)
  14:	0f                   	.byte 0xf
  15:	b7                   	.byte 0xb7


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230814/202308141050.5a684da8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

