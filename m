Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25B47CAAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjJPOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:09:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1D9B;
        Mon, 16 Oct 2023 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697465348; x=1729001348;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yZ3tLGrkukNVUITd3uenwl6hBT9KO+Rsb8aeId3JaVc=;
  b=l1nExO7DjyXPgQ1cE/GuMQuWgvCG702M3dYq7DvjKArLyao/xJH3d3XI
   Nl0xTkLQYLzcCgHIyO0RW1XJbIZp0CRv3mIyaRdmsGQY8tUUCQAKpzy7R
   WpP5o/lpI/hi1F690pmKMRVi7qbb1W8N2j1yYECPpMKzMHy9aDWwLaHgM
   WlN4II7Y8wkiBgiNlzPASq5TB912CjjPd9fbxtBf649x3ULgIFZKTfc4K
   So5c9m0RcanaL0/mX9IEpARtlzQW2YRg1p/tTqqJX9pI5eF2T5f/vszKx
   LejWWl4WA3KAOba6U7c1bJiZfC3uxYWiwBK99VQFjSJFK15vr/3x3uT59
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370609029"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="370609029"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="755703930"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="755703930"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 07:09:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 07:09:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 07:09:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 07:09:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 07:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHyYNWDaNvEKxK3SxKez9vZZUY1k/JWKZX+e6JbxUJwZXTskLgt0BwsvckE2w/c7VUKLREityqYWcDNwcYrLBFhQOUhn/67aLcmmrXIRTBhR7dr11feOVIIf2qDs7MHRKlutlH9fzkLExg0mFOKpB0KH+w8QbRhydQaTf75nRtgIHtFky615C50LfnapD6rOQeWPABgur1CpCisIz3UoLxUhFE4q0LwLN+9Gp7FfKv47orKNrJl3RNPkSvs+KB2fuKKlKyBGF+lmZY9M5Ca55OnPc4kb5QWwyga9EzZ6qGBZTvHB1Rwg4YRBQNUdYOFRcN86f2jPPzd9tUrPm/QkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anIJhHluOVvrdPbMrfDWMAzc8UXSrYagbGM/aRQlVvQ=;
 b=fyCYZzNOog+m6AOR2PBmUAEjIfmoYMpLkyUmmemEEkf992+V+beBA1IUXliKelSu6ueE0cjy7mL9IVl1WYqk8O8FRAWA85nszYrGL4W3tiB/06M1fZRIqjNIx998rHJCfjx5AMQdS0ujjK73d+jVIiRAiV+nuu3wHENag0zWu/EV7MPllmN2dWVnpH3tjLcqTOzcN2GWWbwukoOvni++ToljACLAqjCn3D/v6EyNgckUsXTBj5hECGoGikCH9LqxRNz7VLfs7y4yzMBmMUDCg0TQHzb0W1qQFifSdwpyIzf/wnRNig0dyC9EapENqrzQ3k3h0K8KPAfjX+lkeG8Wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 14:09:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 14:09:04 +0000
Date:   Mon, 16 Oct 2023 22:08:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Abhinav Singh <singhabhinav9051571833@gmail.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] Remove extra unlock for the mutex
Message-ID: <202310162034.6677994c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0774a151-bccc-4618-93b4-08dbce5173f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nr5cBFDlWD8s7Uv+ycJwCu1OD6uXLbyFF8GdlpF4bRiamRQwxa1RStOENxcXTpq4Vb7t9GzptTnphCJkaSH7i0enM3Hgpwax/gpT1W6+C3M0pIyYV7nwJDb4IYoYUUZe7fx4nM5gKB3VYs+e8vCJK6p8g15G9ZMOWV0v1KZYUX8HwpnTJ8kxlH4dwotZM/7KeqQAYEzxKKX+stgAfCp2tnQOr1LQsu9WZav7g3WvfWeZQIGMO71GFU7WLuou7wnqpyjNxwGAiU0th8LuItSUO7ax9MKlDPF9A1YK+dAeiGRJ0IHLlSJiq0G0AY4ZpJJVqfjieWjIEukRqpvCx7ltxsGVfkz6cFSExfwd2RrxGKH0XBq7/Mi4iJO+gv43eNPpcOL9QTiemDZyCgTc/ezZp3lU9aiGBWsPsK/JiWa839HOXbOypMY57SvtjZmrVxBMIBgYZjur1V2zYeV9C7Zx5+kL1DauMP1w9URa5F6nzYfA0KLtwhY86zd0dOCBzcta0oWHHUDpdJxzMRhvsFVzBwsgkoFr3D1rIUyNOc/PVE40EW0vIk96LsaOnjqeXPxr+EznJronlud6UlIe4uN+4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(8676002)(4326008)(5660300002)(2906002)(7416002)(41300700001)(86362001)(36756003)(38100700002)(6506007)(82960400001)(107886003)(1076003)(2616005)(26005)(83380400001)(6512007)(478600001)(6666004)(966005)(6486002)(66946007)(66556008)(66476007)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rh5dG81MCoGB8fQne5JWqjOCn+ZEaf5Q8sxKhl3btpHffmHaoHtzXcTeqvD2?=
 =?us-ascii?Q?HZrHC8Meu3eC33yQf/uRfbYg9++9c5D0G06zYaxHa7qOkFaBqXkFUADu1XVc?=
 =?us-ascii?Q?MAoBQvg6JTsQQcSJl60yFX/Sxqa1aHCIP1RuzP+lurTRRsQ2/BJmRdwwdXdJ?=
 =?us-ascii?Q?kzkzr8U3JkbNc7BpMroVWO9lB3iIDgTcA2mzj5k+YQSr8ZBN0foovY9dDjUz?=
 =?us-ascii?Q?hr9mPRZiL5Om2aTkbCho02QESHCgJm9sFmdLz/8wxicvocmkpYhBTohcUlVo?=
 =?us-ascii?Q?cSoeeKR1VKJ0XJt+S0XCpt2dkaxcvyy212XdbV3aSlo1bG/EcthbX+vbdBKp?=
 =?us-ascii?Q?N/GnfNBx8+seQYjgH/e5vkgICWYljAPS5o8Y4uyXMmDkVaQJA+WVdM4uk0lX?=
 =?us-ascii?Q?Qg678hnGEv3VFy/EtSdXCxNyhBLcKOXGNu58aTlaR+GX5TkZMfvMJ/buog4v?=
 =?us-ascii?Q?TiOr0UGMnCeKYr9i3rw4nUiqmAzzrRSWbbzYpi9zJQoAPmlHbgmVecIw6PzC?=
 =?us-ascii?Q?p+eoE9xe9k4dSbZl/P28cY7XoE9tjOEkvVk+w6xl1oj17NgZ/foNQaezvzrS?=
 =?us-ascii?Q?8D6YKgoF6JIKTQQYcEBAlrwZVwhgFnlJ9x10gn7Q7X3fbiCKnmjHkbJw/U+H?=
 =?us-ascii?Q?+jXjKGIa4y4CD+LkjWR1DG9/5+1cwwIz8nV2OAfvFaM0UlRaJvEySgCYVCja?=
 =?us-ascii?Q?btu1LuQsfIgzI3joZHnfpEMrHIo+iJYfMNtPl2Youf341cCbdPPu4pXX5qyy?=
 =?us-ascii?Q?IPGzkUAMC8j8qs+FTWBT0GopYGPLl7JhnEbC/jMz+Y+CRTn0uAzPyV8MkeNM?=
 =?us-ascii?Q?bWThLc1C+/eKYqAI0fZF3Xgw/qV4I5bDeE3eZ+Zml7PYjk4rEd5Y/Po8R9kd?=
 =?us-ascii?Q?00BD6zRwo24LEQqD0mrCXPwvxxd/QzLuNRPpTHvYexLMsJcYLv3bgMPQR+4G?=
 =?us-ascii?Q?L84gSEfuhryrxsJfYBHpPjTFAHw8M58AdHkqiox3uOC7b9QfZVlZpoHly/Oy?=
 =?us-ascii?Q?BYFVgTuBaSe3nomwjEAYLjei/0WwcdTHBABP8040f55oxHUpnZGlSvFDdgTA?=
 =?us-ascii?Q?1GVTDsu4tKN01dhV5afl36QnCu2/3QWUTxFAhRKgPQan9bVJoyZ6eOgPH1un?=
 =?us-ascii?Q?2Npcvzf/ijD/yj4IC110OLKjUiAdvVowc2QAGICol1JFEo5I637fxwT24N9h?=
 =?us-ascii?Q?S9xnWH5kRWhqIPca3acFzhfcbRqYC+KhOt/Wzbsqm9FDZNsQck5qQALX2dyw?=
 =?us-ascii?Q?hq6JOXKMDYKqTf/UoqVuwy/BJ2w5kp3YYH4erEozMZgUXR8SMCZ3G3iYCaP3?=
 =?us-ascii?Q?DpOudB8qH8elzgV1j/lBJpOfTvWrN655lYesLmG5eWs/uk4YusRV2CUM/a3o?=
 =?us-ascii?Q?QO5Vao1ELr9jlbcGAgdIgEe7ZvKJomP1crGEzHsftfA2Z7S8dDatDzjlDVbw?=
 =?us-ascii?Q?fR3wBhb1MsFV7Gd2cWzLcq963ToWXOBN2OOxyrlX4WMDJLd5xpLFm+oWTpew?=
 =?us-ascii?Q?UAWaTVgyBYyO6hFSjYLDX7zvp69KqG0hzg6laryQoPXilrxDjClp23rUuOSK?=
 =?us-ascii?Q?2cZx6q8oZc1u01MQbAASXsLowUzrsDiiiJFrt+08?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0774a151-bccc-4618-93b4-08dbce5173f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:09:04.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opgzIBNRRFha5t7j1UPTlktqCddVTu4IrIKEjI2oFpTsxkyVYVzaeijU3EYxX8DrAyMy64puSzOSEUWxP8T/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
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

kernel test robot noticed "INFO:rcu_sched_self-detected_stall_on_CPU" on:

commit: f0b98c2f83318c5b0668d160244c97a4c9b4f823 ("[PATCH] Remove extra unlock for the mutex")
url: https://github.com/intel-lab-lkp/linux/commits/Abhinav-Singh/Remove-extra-unlock-for-the-mutex/20231011-064851
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
patch link: https://lore.kernel.org/all/20231010224630.238254-1-singhabhinav9051571833@gmail.com/
patch subject: [PATCH] Remove extra unlock for the mutex

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310162034.6677994c-oliver.sang@intel.com


[  340.173373][    C0] rcu: INFO: rcu_sched self-detected stall on CPU
[  340.174586][    C0] rcu: 	0-....: (1 GPs behind) idle=03dc/1/0x4000000000000000 softirq=3450/3451 fqs=24649
[  340.175977][    C0] rcu: 	(t=100002 jiffies g=3977 q=51 ncpus=2)
[  340.176937][    C0] CPU: 0 PID: 84 Comm: (sd-listen) Not tainted 6.6.0-rc5-00056-gf0b98c2f8331 #1
[  340.178240][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 340.179747][ C0] RIP: 0010:native_queued_spin_lock_slowpath (arch/x86/include/asm/vdso/processor.h:19 arch/x86/include/asm/qspinlock.h:99 kernel/locking/qspinlock.c:327) 
[ 340.180789][ C0] Code: 55 41 54 55 53 48 89 fb 66 90 ba 01 00 00 00 8b 03 85 c0 75 13 f0 0f b1 13 85 c0 75 f2 5b 5d 41 5c 41 5d c3 cc cc cc cc f3 90 <eb> e3 81 fe 00 01 00 00 74 4a 81 fe ff 00 00 00 77 77 f0 0f ba 2b
All code
========
   0:	55                   	push   %rbp
   1:	41 54                	push   %r12
   3:	55                   	push   %rbp
   4:	53                   	push   %rbx
   5:	48 89 fb             	mov    %rdi,%rbx
   8:	66 90                	xchg   %ax,%ax
   a:	ba 01 00 00 00       	mov    $0x1,%edx
   f:	8b 03                	mov    (%rbx),%eax
  11:	85 c0                	test   %eax,%eax
  13:	75 13                	jne    0x28
  15:	f0 0f b1 13          	lock cmpxchg %edx,(%rbx)
  19:	85 c0                	test   %eax,%eax
  1b:	75 f2                	jne    0xf
  1d:	5b                   	pop    %rbx
  1e:	5d                   	pop    %rbp
  1f:	41 5c                	pop    %r12
  21:	41 5d                	pop    %r13
  23:	c3                   	retq   
  24:	cc                   	int3   
  25:	cc                   	int3   
  26:	cc                   	int3   
  27:	cc                   	int3   
  28:	f3 90                	pause  
  2a:*	eb e3                	jmp    0xf		<-- trapping instruction
  2c:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  32:	74 4a                	je     0x7e
  34:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  3a:	77 77                	ja     0xb3
  3c:	f0                   	lock
  3d:	0f                   	.byte 0xf
  3e:	ba                   	.byte 0xba
  3f:	2b                   	.byte 0x2b

Code starting with the faulting instruction
===========================================
   0:	eb e3                	jmp    0xffffffffffffffe5
   2:	81 fe 00 01 00 00    	cmp    $0x100,%esi
   8:	74 4a                	je     0x54
   a:	81 fe ff 00 00 00    	cmp    $0xff,%esi
  10:	77 77                	ja     0x89
  12:	f0                   	lock
  13:	0f                   	.byte 0xf
  14:	ba                   	.byte 0xba
  15:	2b                   	.byte 0x2b
[  340.183349][    C0] RSP: 0018:ffffb338c047fdc8 EFLAGS: 00000202
[  340.184239][    C0] RAX: 0000000000000001 RBX: ffff9f0300e68d60 RCX: ffff9f03003b6bf8
[  340.185380][    C0] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9f0300e68d60
[  340.186574][    C0] RBP: 000000000000006f R08: 0000000000000000 R09: 0000000000000000
[  340.187764][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff86d34d40
[  340.188949][    C0] R13: 0000000000000000 R14: ffffffff86d37a80 R15: ffff9f0300e68d60
[  340.190188][    C0] FS:  00007f34324f1900(0000) GS:ffff9f062fc00000(0000) knlGS:0000000000000000
[  340.191487][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  340.192453][    C0] CR2: 000055e1849fc3fc CR3: 0000000100856000 CR4: 00000000000406f0
[  340.193640][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  340.194791][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  340.195997][    C0] Call Trace:
[  340.196616][    C0]  <IRQ>
[ 340.197133][ C0] ? rcu_dump_cpu_stacks (kernel/rcu/tree_stall.h:372) 
[ 340.197953][ C0] ? print_cpu_stall (kernel/rcu/tree_stall.h:692) 
[ 340.198677][ C0] ? check_cpu_stall (kernel/rcu/tree_stall.h:775) 
[ 340.199433][ C0] ? rcu_pending (kernel/rcu/tree_nocb.h:1018 kernel/rcu/tree.c:3865) 
[ 340.200129][ C0] ? rcu_sched_clock_irq (kernel/rcu/tree.c:2240) 
[ 340.200928][ C0] ? update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
[ 340.201731][ C0] ? tick_sched_handle (kernel/time/tick-sched.c:255) 
[ 340.202471][ C0] ? tick_sched_timer (kernel/time/tick-sched.c:1497) 
[ 340.203215][ C0] ? __pfx_tick_sched_timer (kernel/time/tick-sched.c:1479) 
[ 340.204056][ C0] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 340.204889][ C0] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 340.205654][ C0] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 340.206540][ C0] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14)) 
[  340.207374][    C0]  </IRQ>
[  340.207877][    C0]  <TASK>
[ 340.208388][ C0] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 340.209329][ C0] ? native_queued_spin_lock_slowpath (arch/x86/include/asm/vdso/processor.h:19 arch/x86/include/asm/qspinlock.h:99 kernel/locking/qspinlock.c:327) 
[ 340.210253][ C0] _raw_spin_lock_bh (arch/x86/include/asm/paravirt.h:586 arch/x86/include/asm/qspinlock.h:51 include/asm-generic/qspinlock.h:114 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 340.210996][ C0] inet_csk_get_port (net/ipv4/inet_connection_sock.c:536) 
[ 340.211757][ C0] inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1255) 
[ 340.212570][ C0] __inet_listen_sk (net/ipv4/af_inet.c:218) 
[ 340.213320][ C0] ? __cond_resched (kernel/sched/core.c:8581) 
[ 340.214041][ C0] ? aa_sk_perm (security/apparmor/include/cred.h:153 security/apparmor/net.c:176) 
[ 340.214778][ C0] ? __cond_resched (kernel/sched/core.c:8581) 
[ 340.215488][ C0] ? lock_sock_nested (net/core/sock.c:3509) 
[ 340.216234][ C0] inet_listen (net/ipv4/af_inet.c:239) 
[ 340.216950][ C0] __sys_listen (include/linux/file.h:32 net/socket.c:1885) 
[ 340.217686][ C0] __x64_sys_listen (net/socket.c:1892 net/socket.c:1890 net/socket.c:1890) 
[ 340.218414][ C0] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 340.219135][ C0] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  340.220005][    C0] RIP: 0033:0x7f3432ccefa7
[ 340.220771][ C0] Code: f0 ff ff 73 01 c3 48 8b 0d e6 ee 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 32 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 ee 0b 00 f7 d8 64 89 01 48
All code
========
   0:	f0 ff                	lock (bad) 
   2:	ff 73 01             	pushq  0x1(%rbx)
   5:	c3                   	retq   
   6:	48 8b 0d e6 ee 0b 00 	mov    0xbeee6(%rip),%rcx        # 0xbeef3
   d:	f7 d8                	neg    %eax
   f:	64 89 01             	mov    %eax,%fs:(%rcx)
  12:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  16:	c3                   	retq   
  17:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1e:	00 00 00 
  21:	66 90                	xchg   %ax,%ax
  23:	b8 32 00 00 00       	mov    $0x32,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d b9 ee 0b 00 	mov    0xbeeb9(%rip),%rcx        # 0xbeef3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d b9 ee 0b 00 	mov    0xbeeb9(%rip),%rcx        # 0xbeec9
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231016/202310162034.6677994c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

