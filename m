Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116537ACA38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIXPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:15:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC9B8;
        Sun, 24 Sep 2023 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695568510; x=1727104510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zsb6+Qoqaj1RLHpJIhfGmSC1lI8T3VPWwdtnnDnvAik=;
  b=n5eRnfKF7HrjLx4tFp996gzd2g3j92xOXkWYQTqfK3rwfoP/0QnfvT8s
   UZ1tbPV6x5PbtElcXEjcuJNCQBHq5FpseibMWNeuw/ZRBEq9TbCevZCNo
   MUCmea5+hnTeqoSNTqmqDs1DMe9Vffg+g5vvOFN+VDuXPN5opQ3AiI8KI
   sGmHy0ERPmQb7YO+1/LOL0fXvZut4Na3q5rHDZqfVgHFgl6P81FdgAuy8
   ycy1kr2m/JAx9GBltpEi7viqe6ls/rdhi9zE/OaCJWf9KC2AVN8NkKbsi
   VxmqiEo5E4eQWt377qaFSMqxfmIuNUf/g21K40BvCQfe550uMXX6SioyI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366161545"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="366161545"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 08:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891396985"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="891396985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 08:14:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 08:15:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 08:15:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 08:15:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 08:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHbdaE4PTMuBU3BoYY2VDDaCtwCb6B3Hf0CnSzjtiW95qouIC8edt6JnYKSMJEMB/ai20h2SOqfzuQ9p8cJ8syDMIuOSDMuh2KNP6GTOd66pBj8PVpAvuOH9u0NyzjVa6CDZV2ZgEo5eIown2RUjES3GoY2eakk9FzbflMoDbrDP1UfVDnBm3zU8CxgrjpR/R+Nd9O8vmQlwLHMrp6Sfz5l3a1zfspO4MOp3lPybF/UdV5kSZFDp1bWTYtyHlrf+Vq6v4Jl0foImSqTsLZj7tDQOPgG51nq3xOoi58YIIPovDX+asGKnjXknCSuCYXhY+9cwv9DnZXj340My9PupzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMeNRL6InMg56DzY1UUz1PHyZGPWIPTgoPpTx2qlzJo=;
 b=ac0rg5iDYFH3XmRKSYLQM4GRRowYcWE84wYgwNjBsBDp8H0Ho4PD9HIM5uEGSla6ksQ3t6z/c/gwpxwUipyIRSOuWES5Rt3uPc2TxTDm/JoDI2MfmDOLkjD114R6dUJmY8ArxfzGROvUGc4qpt0r3+5uEK2GTyDHca+KLFxb+WuslBRJ3+1jTpWij+an068yt8SJF/B27ZVJF2dbCtat1mnK0gvix46D/8l4JLhHX7x+rApXciLg79dbZU0yBsX4fr1WgIsasVFNbSe45PZELpGim3sB5ZxPTBwJaYYuXC3qjjc5NQdGHOClSghUh5u/xJh2a7utqFu0BqaoAMSxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Sun, 24 Sep
 2023 15:15:06 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 15:15:06 +0000
Date:   Sun, 24 Sep 2023 23:14:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing]  9fe41efaca:
 WARNING:at_kernel/trace/trace_events.c:#event_trace_self_tests_init
Message-ID: <202309242249.94de41a1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2cd6fd-9316-4d6b-3f7a-08dbbd11085c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzrC7HTkpkTCztWZDaJriBCQFCxBaKupL4IrImPPD6qanPs+B5SNbAH8h9QwO/5i34pvXcg7iPoOxV8H6ZvFqugRrYjBdIeeENXfkqsyPr3X+N0Oppi8RjShy549NjGHePGCLhp1eVsgdjHBTu/O42n9EbbM9U3Hg5f/QoGUPNanlUsJ+OXOriBi0KiCXoiqtH7a65NUauK8EKaTbt22caY4DKGiqkHf3nsIGYppDLORpkOiAc0p1tSA/NP5EacNv6ZuvTsmnnBw53pUpMyln09FLYTfpASYeEa8NH0IM/+HqiSgG1vkvB2ahFY0sppz4+MlHdPDRxlyqweCvWgw56/7dKNqpFWC4S8x/G4PFoFQam/glVTxcCOtDJr5uHsq0vHB+a2P6ouB4ghOdrestyt1tI2mge7vQLmfg41FDGMubqrrz/TRf60igJ/jDUjEy4uVWUFMRLU8lgg4bDvtUBVXl4Aw0wj0rxFJVDg5ij0f8ZO9LlXbvbpHell1jxMnMmZ6Dh2n++neMy8sNCdI/uxi9nBgRdmZ4ySaBXIXUN7HtTq4rp+sCkJ9uEZxa8hA1753J/uNpO5bo7SWUgoPTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799009)(2906002)(966005)(5660300002)(26005)(66476007)(54906003)(8936002)(66556008)(41300700001)(6916009)(66946007)(316002)(478600001)(1076003)(45080400002)(4326008)(8676002)(6666004)(6486002)(6506007)(6512007)(2616005)(36756003)(107886003)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHMJiPTHDrEq7W3m4K5qsYKv6Fm/hiZiBYqUHOyskSf0QUb+dhjNb2o3tmjM?=
 =?us-ascii?Q?gMEckiH5h1HGbE7tx4nJEYqBaKkhfaUNMl8MgUJCKgCJaDvkw7f/sUAUQbBi?=
 =?us-ascii?Q?XW0Zx7KfLyD05tTVBceoHXAJJ48MMjgA6UtBkn+aJl2nkcuoytKOj1+4bgA5?=
 =?us-ascii?Q?ZtX5ZTPFmg7Q8U4m0jUAo0DQSE7Rgr+v1/WWwRZeDDdYZa+jeyWuAWWHtuB7?=
 =?us-ascii?Q?PVLEQZpzfEAVXtPEFzveoxL1Sr4EG7Nsu99F++5IoxLoO7fjcu661xsyFjUi?=
 =?us-ascii?Q?MvlWtOJh11NT6b64u8kHQDtY/AwYVhu5l8CtfbqJlmtzSelV7IRWP7U/Q0bz?=
 =?us-ascii?Q?W412NCJQecaXelZyqyGaNAsJPIRFStTERzPPsVBZ1T0IRhtXfublPHjrq2mh?=
 =?us-ascii?Q?s9WVhqsJ2fzrABtGnnuGs9U2+t/TzzZM2g/1tApwTUbFIGfNTgz7MLHwVEcY?=
 =?us-ascii?Q?XIWjm1eKRhOt76NNrAammkDJdRRCCMq0r4Dm3WPD6wYqvLD3fwWhl5SjYmcE?=
 =?us-ascii?Q?qH+y3sYR/aGmm4v/ARb0ThqOgd9hIihzdbsJ6i7vXmrtUlfRhdz2dQ1AO3wR?=
 =?us-ascii?Q?VbyH3Ency9nxtmZ8lXmc78G4JjL2VIVbN0GkNT5YK1ZfGddh73/La6OKXyXY?=
 =?us-ascii?Q?OnMIDqYe7ZePz48e5yegsPMZUzXw7PjmhNczulUZrBg2bWEsL/FQLP5vARS0?=
 =?us-ascii?Q?PRk+LsuGRC4WiYyyUmuCnJaAfdRgD9Hqiopi6KVetf31fUdzyQwTGLYUfd4r?=
 =?us-ascii?Q?I9Vpo+rcnWZbon1VIIqhYZczac9yElywMA0fl7REQNjTr9/tjIY0s8Q+bLaf?=
 =?us-ascii?Q?sqyfwRbnlR6vuHjYcJhTljMjSYf08PEH6CVdr8KsSsEuhJixsTZJ+Ta69KXI?=
 =?us-ascii?Q?iHIBmvkJ++zs+tRiGEOJzm4VjQQggxn5eoDW0ZKdK5coglFsA7xmI4iJuHSW?=
 =?us-ascii?Q?1uEohOttBf+AMXhqlxWyo4IYm+/rsUil9PtjfPu6xu48kx95Y22zBzxJpbY8?=
 =?us-ascii?Q?o1QDfrBu4a6D84zy33PQ69xxpTV5Rm3fIjNSSyzc3Hr9H9LQA3p3d2XHYi/N?=
 =?us-ascii?Q?hFzBNe/zIGEl0S6kYz9FqfnhKKjt6hQyAML2XpfvdPXBVwYGcVkouUZYTkGh?=
 =?us-ascii?Q?wH+2Zl3OSOGJF+wsQRaHXFP7D2Uw/4ENrL9nfBJ3KptRuuO3HhCZUU9mmtjS?=
 =?us-ascii?Q?Oh173iTAGAVEk5YBaH6MJ/HhjdBgtwiC1LJ4DSguOoHD0E4ksj41vtTC4XvU?=
 =?us-ascii?Q?De1kOLJbHGB8Ce15ewSHWAi1CCC0u2ufCxWrt/gVNmn8PheFW9sBmwD8mzvD?=
 =?us-ascii?Q?tW6pVdVtE+VCtnsPeJJ8qSJteqZSx2OyUmHBkFtL4TOyPTpBxmB8AwX6XU5U?=
 =?us-ascii?Q?/OJyEoKyFBLXkTh920AZCFQkDFnymmjqE8QY8GzuAontag/ykIWbE9fjljTV?=
 =?us-ascii?Q?fnPxKA8ikpl9iYKUHlNzRQ8W2F2/Kb5i5HHTudczTFL/3iSZfjMOSWjgR+PW?=
 =?us-ascii?Q?mw+scs3/51jQGokW2xJACMulPfIsPgS9eGunhV2x3XZP2Wy37cUNxPc7eyu7?=
 =?us-ascii?Q?3pML57yAnE6qIqeKF/BkFfttHLuaQptZur0cyltbQ2Hc2Qy5XwDlGxSjD/wI?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2cd6fd-9316-4d6b-3f7a-08dbbd11085c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 15:15:05.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivh6nZDeecdJvmwQDyHrWfoAIFdLEkQQLB92wfHuoPCyOEf2Uy9mIEVgVibL+LMZmQTBg4y1XxP3MW2v+CSOOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#event_trace_self_tests_init" on:

commit: 9fe41efaca08416657efa8731c0d47ccb6a3f3eb ("tracing: Add synth event generation test module")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309242249.94de41a1-oliver.sang@intel.com


[   43.576702][    T1] ------------[ cut here ]------------
[ 43.577569][ T1] WARNING: CPU: 1 PID: 1 at kernel/trace/trace_events.c:3403 event_trace_self_tests_init (kernel/trace/trace_events.c:3402 kernel/trace/trace_events.c:3546) 
[   43.579528][    T1] Modules linked in:
[   43.580160][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc6-00065-g9fe41efaca0841 #1
[ 43.581559][ T1] RIP: 0010:event_trace_self_tests_init (kernel/trace/trace_events.c:3402 kernel/trace/trace_events.c:3546) 
[ 43.582586][ T1] Code: fc 48 8d 7d 48 48 89 f8 48 c1 e8 03 42 80 3c 20 00 74 05 e8 fd 3b c6 fc f6 45 48 01 74 10 48 c7 c7 20 4a 91 8b e8 6f 10 8a fc <0f> 0b eb 2c 31 d2 be 01 00 00 00 48 89 ef e8 b8 a1 9f fc e8 b6 fa
All code
========
   0:	fc                   	cld    
   1:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
   5:	48 89 f8             	mov    %rdi,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  11:	74 05                	je     0x18
  13:	e8 fd 3b c6 fc       	callq  0xfffffffffcc63c15
  18:	f6 45 48 01          	testb  $0x1,0x48(%rbp)
  1c:	74 10                	je     0x2e
  1e:	48 c7 c7 20 4a 91 8b 	mov    $0xffffffff8b914a20,%rdi
  25:	e8 6f 10 8a fc       	callq  0xfffffffffc8a1099
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb 2c                	jmp    0x5a
  2e:	31 d2                	xor    %edx,%edx
  30:	be 01 00 00 00       	mov    $0x1,%esi
  35:	48 89 ef             	mov    %rbp,%rdi
  38:	e8 b8 a1 9f fc       	callq  0xfffffffffc9fa1f5
  3d:	e8                   	.byte 0xe8
  3e:	b6 fa                	mov    $0xfa,%dh

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb 2c                	jmp    0x30
   4:	31 d2                	xor    %edx,%edx
   6:	be 01 00 00 00       	mov    $0x1,%esi
   b:	48 89 ef             	mov    %rbp,%rdi
   e:	e8 b8 a1 9f fc       	callq  0xfffffffffc9fa1cb
  13:	e8                   	.byte 0xe8
  14:	b6 fa                	mov    $0xfa,%dh
[   43.585621][    T1] RSP: 0000:ffff8883ac827dd8 EFLAGS: 00010286
[   43.586569][    T1] RAX: 000000000000001f RBX: ffffffff8c38ae60 RCX: 0000000000000000
[   43.587821][    T1] RDX: 000000000000001f RSI: 0000000000000006 RDI: ffffed1075904fb1
[   43.589057][    T1] RBP: ffff8883ad2d5618 R08: 00000000001f1194 R09: 0000000000000000
[   43.590290][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
[   43.591532][    T1] R13: ffff88837e7ed340 R14: ffff88837e5c6880 R15: ffffffff8c38cb78
[   43.596827][    T1] FS:  0000000000000000(0000) GS:ffff8883af000000(0000) knlGS:0000000000000000
[   43.598225][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.599253][    T1] CR2: 0000000000000000 CR3: 000000009a015000 CR4: 00000000000406e0
[   43.600508][    T1] Call Trace:
[ 43.601044][ T1] ? test_work (kernel/trace/trace_events.c:3545) 
[ 43.601718][ T1] do_one_initcall (init/main.c:1107) 
[ 43.602455][ T1] ? boot_config_checksum (init/main.c:1098) 
[ 43.603274][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:361 kernel/rcu/update.c:122) 
[ 43.604158][ T1] ? rcu_read_lock_bh_held (kernel/rcu/update.c:117) 
[ 43.604997][ T1] ? test_bit (arch/x86/include/asm/bitops.h:214 include/asm-generic/bitops/instrumented-non-atomic.h:111) 
[ 43.605662][ T1] kernel_init_freeable (init/main.c:1174 init/main.c:1190 init/main.c:1210 init/main.c:1381) 
[ 43.606481][ T1] ? rest_init (init/main.c:1285) 
[ 43.607182][ T1] kernel_init (init/main.c:1290) 
[ 43.607865][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:54 arch/x86/include/asm/irqflags.h:94 include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:199) 
[ 43.608678][ T1] ? rest_init (init/main.c:1285) 
[ 43.609368][ T1] ret_from_fork (arch/x86/entry/entry_64.S:358) 
[   43.610087][    T1] irq event stamp: 6455462
[ 43.610784][ T1] hardirqs last enabled at (6455461): console_unlock (arch/x86/include/asm/irqflags.h:41 (discriminator 2) arch/x86/include/asm/irqflags.h:84 (discriminator 2) kernel/printk/printk.c:2502 (discriminator 2)) 
[ 43.612288][ T1] hardirqs last disabled at (6455462): trace_hardirqs_off_thunk (arch/x86/entry/thunk_64.S:42) 
[ 43.613880][ T1] softirqs last enabled at (6455326): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:320) 
[ 43.615340][ T1] softirqs last disabled at (6455313): irq_exit (kernel/softirq.c:373 kernel/softirq.c:413) 
[   43.616764][    T1] ---[ end trace a06cced81771bf57 ]---
[   43.617997][    T1] Testing event empty_synth_test:
[   43.618000][    T1] Enabled event during self test!
[   43.619614][    T1] Testing event gen_synth_test:


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230924/202309242249.94de41a1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

