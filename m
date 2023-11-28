Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CA7FC1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbjK1PMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbjK1PMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:12:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275241B9;
        Tue, 28 Nov 2023 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701184331; x=1732720331;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=uUa+iAhsaGA9LQbLkzHx2LtSgmprJlidyWOlacKkF5E=;
  b=nt+RfV3JfBq4iiGXHB+2ywcaTPYaozHO3WaJzufqIXNg6OGJvsCFegvx
   ZxELejpGYDHpMyoPWItKnS1D610OzqPsqhfC/7zdrLBKSFRcYZ11jfb46
   7KxQaifV0eqnKErln0UlpDdiyj36CfQFGGXi/XiiPhHYZcfeOv4mX3Qg+
   LN5vmv+82/JlTJrXnwFs+0IAyR1S+wqpWzBNz++Zal6aPHUi0V2U2lx8t
   xsmDtRUB1d4FLNiBswYXL1xt8a+vtI/Z2ef7BsTiGGv/MoiKVdBRFakoj
   mQhmZodmC0cr9XrV908JgrVQXArlgPIchwQ5t7JsjLJnqWCMjC3RjAboj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459447020"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459447020"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="9973189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 07:12:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 07:12:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 07:12:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 07:12:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hownpBpsOOObht0sXRGTXmQVU7eYINY/RgH6Jw11K/aSD6SLr22BRjUvOqHAJJlReBzUESByB1W+3C9SfNz95kxrndett37cEoVG6JwGQIM4G/oEw+5Iqcf1T5aBYHbxoTFT6XcSPKNBrVqOgk7XaU5PkWLz9Qj8Y5gBurBdwAJDHD/dLXTHyVfVPtTdh9c+0OJ/GzYL4nu758snJpK9/YUO1GbLnfvSoQx4cSe9kca3vsSJ4GWfe9AA5MTovWIp/GUJFN1thZCrQEdPv45XWQPVeS1X1fb6ermYKR7vftlTR1MeNP90P3H0cexbCBNgRM/teRfsQOqh8WsxUL74Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1R5bNfbw+DEanscdPATvzOt2Ov10pAnyCkky8TvwTE=;
 b=ctQdrnDxSDheTVwClx6scSB3je4lcyKUtztanNuN9S7rUEsMjIlPuofqywDNv32vfOrmK7T4Q34lBTl9lfdIAsTOcYRSJZkZriUHmatrKVBwk5e7F5LLrHhBC8A2kT/9RiaN13HmdOkYa6AMdMzwWZwtApmWbRZFhubM3WiFIk5CjaSnViErkvCAx/Gd1OLZNoOIEK1ROZnFb0TKemeMaDRR88ZFgoM6Bu6OPrd50E/8F7yB7zTfgGglBq5CLn0RioklWpnDjjhQRR3bec4Sn9idhed+3dwc9kmT16aZljNmMfdQzymrx3vxEqzndFdL1yNagYaHHrpZDTucnaxJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:12:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 15:12:05 +0000
Date:   Tue, 28 Nov 2023 23:11:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <tony@atomide.com>,
        <john.ogness@linutronix.de>, <tglx@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in
 uart_start()
Message-ID: <202311282251.b5351d99-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231124122258.1050-1-xuewen.yan@unisoc.com>
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c8b9e0-e61d-44f2-557c-08dbf0246172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VP1Wndxe60VbvJRu3N8+JJz/XvdiMnKG7ZYiLT3M+F5uMXNcD3d3WNpQkf1AKck2g+hTJHSK57xM2pWTlG7HlqeBefsjyIJNlMf2I9jlOIKTcx07wB0X8i8okaSdQP9yQBGOroJ80mC/ylXzpohs7xyrQ+B/Yp1k442+mExTnfk0zlOWLkTGHAnKUCLwqAaXtWWWTEblktSx3YowRKJWbMrO7jJ6y0xuunrHTY/gpLUIGbTCeB5ekyBMb4CQ+pjVx2knjal5arC6lXkDdaunHGpQA1sRyCZe+GeQNcI12zw7coW6cSn0/jD+qvTKLSKVwp8G9cBvoHhM257YvVwMyF17uVhZ90v3jezEH2e8vEKClx2Qy4LfvyRkRCxulge6gxQlFT8BE37GpuZQH7P03FeKDgCsfqkeAuP6hPpR7su3XdbXoK8v32HH9sPHMxQNL6CnAn/Fq7ss+E2KOfFi5scdd0jZs7lsUD/m1p3TMq9Upwn0PKpqgjwphtFaDDDLgYiyIb2WFiVpYm/MkjejQNgykjL3Gfm0B96utxtj/Sbh56gVOuoH2MGOcf2wEGj6ywxa5bpRH8sBd+w3EMHt7/GR5suzjANGqb/vQ3JNgt7EcwjnSsunhlasnagku5tF9fUfHo6aiNfngbKKJfmS5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(26005)(1076003)(6486002)(2616005)(6506007)(966005)(6666004)(478600001)(6512007)(38100700002)(82960400001)(86362001)(36756003)(7416002)(2906002)(5660300002)(66946007)(83380400001)(30864003)(41300700001)(66556008)(4326008)(316002)(6916009)(8936002)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8j9uKbzF+xgCS2FYNfzazFFHDzasozbZV3SNBu0sMAs/6y2SfOjr6tRgwY/?=
 =?us-ascii?Q?e7YfH45DTan1EG2hLpJOJXR2CeBYtWwbzVHtKbI1yuPhy55HG0izgn8rqHph?=
 =?us-ascii?Q?z1CF/6sbgLG6q5sZLKfc5iLVtDNdc/AuUCTmeAd+0mmEH6hOjnX7PJkzFXj2?=
 =?us-ascii?Q?BDeUpvHFeSVf7XVSuUurqNDFQPHBb8N274X3GRZ9I+6cUN+mEttJTQeexNk0?=
 =?us-ascii?Q?H+0fAUdfSjK4kc0qxp17LzuXJ/JYJ2MjoeXLJESNCUf2ZPc+DKjAry8HjbUT?=
 =?us-ascii?Q?j/w+VMj5z1pi0792JzW++tNDaU/C2fwyn1avbRM50AhmSA73B3etypd83N7s?=
 =?us-ascii?Q?tQwTYHeHVv/piZIz2co2fZHGVdXaqw0Kx60tRN+h1ND4Ej//s+wla+rEuGbf?=
 =?us-ascii?Q?G7+p0knCBW5IM7GovQaN9jZvBd5uQQ4GO1LOby6AWUTaggQMt6vYpf4IFCQi?=
 =?us-ascii?Q?LkijIbnCmehKWMYtPY7QD7q9Ml9LWuUOKltP6x1sAJOYzAI365Y+vt3lURWd?=
 =?us-ascii?Q?86uOVihvgDFFTj+/nmnwuvALxHPxH5kySfo/52pq2fAghtG/5I4/iu8Li7yy?=
 =?us-ascii?Q?uaK2xQYE7tjXbky39S4vlC2WCTbRttQlioh+AE2NanRi0I/KUb2IDOr0cmVI?=
 =?us-ascii?Q?hPMjUHoG7ljk80LxwWJ21BUbAPsiM5u1QNxoYS8l2pdaptztmVMQln3mBn7j?=
 =?us-ascii?Q?FcJSb//7dG820gm1ypkJnwaLBosmIdeAOalawKwN7g2pQ7KV2An+sdilWyLF?=
 =?us-ascii?Q?Msjr/npmQVEMfYMePZS92aEpOnw6ILO86ZEVu0jDK9vjcEkZCkPrBETgtlB/?=
 =?us-ascii?Q?V1v0pguoGqDNXOBRy5VNBArjZ2S3W37XI1S1uiJgdNKCm9o8K+dBXG9msO2v?=
 =?us-ascii?Q?hIEo/MFcliY0vGNFokLstiCekOjexTtg6B02ORLhqdkohT2rJ8gpobYm8zH4?=
 =?us-ascii?Q?hbjbsUR1SubjTbQ8QFFX/fPWmfU4+m3bboXDignAH2YUP0OZtHzPm+P5J7TN?=
 =?us-ascii?Q?F9/Lk5rSju3XhbYVmtXVur7l+fb321y7VN8g5TMbzuDlGqkANuZsFI5n/t59?=
 =?us-ascii?Q?0EoxjCTokERiD63xk44AiRRm85Hm07GKI7BA7+jKGxZnCBw4010qnKJH910S?=
 =?us-ascii?Q?AsKq5MmT6sPL6+HsV2ZTzr9d6Xmpp123ZMu3jFjWBXSBZwigg8HwUfCB91qF?=
 =?us-ascii?Q?j+YasdtxC9D1IEw+jn4pJ15V9s+Aw2o7XDasaJAlo1OajpmsonCeVbRBbv5f?=
 =?us-ascii?Q?aq9aMPl76FvNjESuUGsWjqwPGsuPazLzeXaScWdgvOsfCDoZBZy6wWIrlHTW?=
 =?us-ascii?Q?GUTY6k4i2PS0Lb/g9FVVFmQd0W78uK5n4PZps9VhXVFrEsDHxSCJeQP0R+ez?=
 =?us-ascii?Q?mSOze/Ht84c7SzmTPboO5GZbi5hybF27SpZ7IqiQU4oOJeivurfc+QSmYfji?=
 =?us-ascii?Q?qoEitRkIJFzVqdqUn9FkY1ea0attI4JuBcwGgH6X6w7wNAsXt39G/e0Oq3YX?=
 =?us-ascii?Q?9IHAQnn8503mKsSHbF60tOezMssoY1jmoztEjc55VU7qDnmTBuv12nRGl29V?=
 =?us-ascii?Q?id7KqXsowbxJLRYOoLF2XRdYcO0hO1wE0CDePkABSCpQwv8s1ZTa4ZdJyJkz?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c8b9e0-e61d-44f2-557c-08dbf0246172
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:12:05.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvB3Mh+SF8IVODR1L7EaewGzjsriEQYEJVCJaRWJ+sz33fOK/DN3UhXe2erAnyGoplfIKLmTqmZgykhP4TrgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
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

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_drivers/base/power/runtime.c" on:

commit: 81a787668db066cb86873bd4f8fbf7c36ac8dd5a ("[RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()")
url: https://github.com/intel-lab-lkp/linux/commits/Xuewen-Yan/serial-core-Use-pm_runtime_get_sync-in-uart_start/20231124-202425
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-next
patch link: https://lore.kernel.org/all/20231124122258.1050-1-xuewen.yan@unisoc.com/
patch subject: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311282251.b5351d99-oliver.sang@intel.com


[  678.716002][    T1] BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
[  678.716028][    T1]
[  678.716029][    T1] ======================================================
[  678.716030][    T1] WARNING: possible circular locking dependency detected
[  678.716031][    T1] 6.7.0-rc2-00001-g81a787668db0 #3 Tainted: G                 N
[  678.716033][    T1] ------------------------------------------------------
[  678.716033][    T1] init/1 is trying to acquire lock:
[ 678.716035][ T1] c249c82c (console_owner){-.-.}-{0:0}, at: console_flush_all (kernel/printk/printk.c:2894 kernel/printk/printk.c:2967) 
[  678.716047][    T1]
[  678.716047][    T1] but task is already holding lock:
[ 678.716048][ T1] c3356e90 (&port_lock_key){-.-.}-{2:2}, at: uart_write (drivers/tty/serial/serial_core.c:598) 
[  678.716057][    T1]
[  678.716057][    T1] which lock already depends on the new lock.
[  678.716057][    T1]
[  678.716057][    T1] the existing dependency chain (in reverse order) is:
[  678.716058][    T1]
[  678.716058][    T1] -> #1 (&port_lock_key){-.-.}-{2:2}:
[ 678.716062][ T1] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 678.716066][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 678.716069][ T1] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 678.716073][ T1] serial8250_console_write (drivers/tty/serial/8250/8250_port.c:3396) 
[ 678.716076][ T1] univ8250_console_write (drivers/tty/serial/8250/8250_core.c:601) 
[ 678.716079][ T1] console_flush_all (kernel/printk/printk.c:2905 kernel/printk/printk.c:2967) 
[ 678.716081][ T1] console_unlock (kernel/printk/printk.c:3037) 
[ 678.716084][ T1] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304) 
[ 678.716086][ T1] vprintk_default (kernel/printk/printk.c:2319) 
[ 678.716089][ T1] vprintk (kernel/printk/printk_safe.c:46) 
[ 678.716091][ T1] _printk (kernel/printk/printk.c:2332) 
[ 678.716093][ T1] register_console (kernel/printk/printk.c:3543) 
[ 678.716096][ T1] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:718) 
[ 678.716102][ T1] console_init (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/initcall.h:48 kernel/printk/printk.c:3689) 
[ 678.716104][ T1] start_kernel (init/main.c:1009 (discriminator 3)) 
[ 678.716108][ T1] i386_start_kernel (??:?) 
[ 678.716112][ T1] startup_32_smp (arch/x86/kernel/head_32.S:295) 
[  678.716115][    T1]
[  678.716115][    T1] -> #0 (console_owner){-.-.}-{0:0}:
[ 678.716118][ T1] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 678.716121][ T1] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868) 
[ 678.716124][ T1] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 678.716126][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 678.716129][ T1] console_flush_all (kernel/printk/printk.c:2901 kernel/printk/printk.c:2967) 
[ 678.716131][ T1] console_unlock (kernel/printk/printk.c:3037) 
[ 678.716134][ T1] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304) 
[ 678.716136][ T1] vprintk_default (kernel/printk/printk.c:2319) 
[ 678.716138][ T1] vprintk (kernel/printk/printk_safe.c:46) 
[ 678.716140][ T1] _printk (kernel/printk/printk.c:2332) 
[ 678.716142][ T1] __might_resched (kernel/sched/core.c:10130) 
[ 678.716145][ T1] __might_sleep (kernel/sched/core.c:10081 (discriminator 17)) 
[ 678.716147][ T1] __pm_runtime_resume (drivers/base/power/runtime.c:1163 (discriminator 5)) 
[ 678.716152][ T1] __uart_start (drivers/tty/serial/serial_core.c:149) 
[ 678.716156][ T1] uart_write (include/linux/spinlock.h:406 include/linux/serial_core.h:667 drivers/tty/serial/serial_core.c:617) 
[ 678.716159][ T1] process_output_block (drivers/tty/n_tty.c:574) 
[ 678.716163][ T1] n_tty_write (drivers/tty/n_tty.c:2380) 
[ 678.716166][ T1] iterate_tty_write (drivers/tty/tty_io.c:1022) 
[ 678.716169][ T1] file_tty_write+0x80/0x10c 
[ 678.716172][ T1] redirected_tty_write (drivers/tty/tty_io.c:1137) 
[ 678.716175][ T1] vfs_write (fs/read_write.c:492 fs/read_write.c:584) 
[ 678.716179][ T1] ksys_write (fs/read_write.c:638) 
[ 678.716180][ T1] __ia32_sys_write (fs/read_write.c:646) 
[ 678.716182][ T1] do_int80_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:184) 
[ 678.716185][ T1] restore_all_switch_stack (arch/x86/entry/entry_32.S:947) 
[  678.716190][    T1]
[  678.716190][    T1] other info that might help us debug this:
[  678.716190][    T1]
[  678.716191][    T1]  Possible unsafe locking scenario:
[  678.716191][    T1]
[  678.716192][    T1]        CPU0                    CPU1
[  678.716193][    T1]        ----                    ----
[  678.716193][    T1]   lock(&port_lock_key);
[  678.716195][    T1]                                lock(console_owner);
[  678.716196][    T1]                                lock(&port_lock_key);
[  678.716198][    T1]   lock(console_owner);
[  678.716199][    T1]
[  678.716199][    T1]  *** DEADLOCK ***
[  678.716199][    T1]
[  678.716200][    T1] 7 locks held by init/1:
[ 678.716202][ T1] #0: c3fc5060 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read (drivers/tty/tty_ldsem.c:341) 
[ 678.716211][ T1] #1: c3fc50b8 (&tty->atomic_write_lock){+.+.}-{3:3}, at: iterate_tty_write (drivers/tty/tty_io.c:954 drivers/tty/tty_io.c:973) 
[ 678.716217][ T1] #2: c3fc51c4 (&tty->termios_rwsem){++++}-{3:3}, at: n_tty_write (drivers/tty/n_tty.c:2365) 
[ 678.716223][ T1] #3: ef4112f0 (&ldata->output_lock){+.+.}-{3:3}, at: process_output_block (drivers/tty/n_tty.c:531) 
[ 678.716229][ T1] #4: c3356e90 (&port_lock_key){-.-.}-{2:2}, at: uart_write (drivers/tty/serial/serial_core.c:598) 
[ 678.716236][ T1] #5: c27bc9a8 (console_lock){+.+.}-{0:0}, at: vprintk_default (kernel/printk/printk.c:2319) 
[ 678.716241][ T1] #6: c27bca58 (console_srcu){....}-{0:0}, at: console_flush_all (include/linux/srcutiny.h:67 include/linux/srcu.h:70 include/linux/srcu.h:231 kernel/printk/printk.c:286 kernel/printk/printk.c:2959) 
[  678.716247][    T1]
[  678.716247][    T1] stack backtrace:
[  678.716248][    T1] CPU: 0 PID: 1 Comm: init Tainted: G                 N 6.7.0-rc2-00001-g81a787668db0 #3 457007a7b9fe78ab16bc9131e3cdb3e013769988
[  678.716253][    T1] Call Trace:
[ 678.716254][ T1] dump_stack_lvl (lib/dump_stack.c:108) 
[ 678.716259][ T1] dump_stack (lib/dump_stack.c:114) 
[ 678.716262][ T1] print_circular_bug (kernel/locking/lockdep.c:2061) 
[ 678.716266][ T1] check_noncircular (kernel/locking/lockdep.c:2190) 
[ 678.716271][ T1] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 678.716275][ T1] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868) 
[ 678.716279][ T1] __lock_acquire (kernel/locking/lockdep.c:5136) 
[ 678.716282][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:267) 
[ 678.716285][ T1] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[ 678.716290][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[ 678.716293][ T1] ? console_flush_all (kernel/printk/printk.c:2894 kernel/printk/printk.c:2967) 
[ 678.716296][ T1] ? console_flush_all (kernel/printk/printk.c:1854 kernel/printk/printk.c:2895 kernel/printk/printk.c:2967) 
[ 678.716299][ T1] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5775) 
[ 678.716303][ T1] console_flush_all (kernel/printk/printk.c:2901 kernel/printk/printk.c:2967) 
[ 678.716306][ T1] ? console_flush_all (kernel/printk/printk.c:2894 kernel/printk/printk.c:2967) 
[ 678.716310][ T1] console_unlock (kernel/printk/printk.c:3037) 
[ 678.716313][ T1] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304) 
[ 678.716316][ T1] vprintk_default (kernel/printk/printk.c:2319) 
[ 678.716319][ T1] vprintk (kernel/printk/printk_safe.c:46) 
[ 678.716322][ T1] _printk (kernel/printk/printk.c:2332) 
[ 678.716324][ T1] __might_resched (kernel/sched/core.c:10130) 
[ 678.716328][ T1] __might_sleep (kernel/sched/core.c:10081 (discriminator 17)) 
[ 678.716331][ T1] ? uart_write (drivers/tty/serial/serial_core.c:598) 
[ 678.716335][ T1] ? lock_acquired (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:6035) 
[ 678.716337][ T1] __pm_runtime_resume (drivers/base/power/runtime.c:1163 (discriminator 5)) 
[ 678.716341][ T1] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163) 
[ 678.716344][ T1] __uart_start (drivers/tty/serial/serial_core.c:149) 
[ 678.716348][ T1] uart_write (include/linux/spinlock.h:406 include/linux/serial_core.h:667 drivers/tty/serial/serial_core.c:617) 
[ 678.716352][ T1] ? uart_write_room (drivers/tty/serial/serial_core.c:74 drivers/tty/serial/serial_core.c:630) 
[ 678.716356][ T1] process_output_block (drivers/tty/n_tty.c:574) 
[ 678.716361][ T1] n_tty_write (drivers/tty/n_tty.c:2380) 
[ 678.716365][ T1] ? autoremove_wake_function (kernel/sched/wait.c:439) 
[ 678.716370][ T1] iterate_tty_write (drivers/tty/tty_io.c:1022) 
[ 678.716375][ T1] file_tty_write+0x80/0x10c 
[ 678.716378][ T1] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5775) 
[ 678.716382][ T1] redirected_tty_write (drivers/tty/tty_io.c:1137) 
[ 678.716385][ T1] vfs_write (fs/read_write.c:492 fs/read_write.c:584) 
[ 678.716389][ T1] ? exit_to_user_mode_prepare (kernel/entry/common.c:212 (discriminator 43)) 
[ 678.716395][ T1] ksys_write (fs/read_write.c:638) 
[ 678.716398][ T1] __ia32_sys_write (fs/read_write.c:646) 
[ 678.716400][ T1] do_int80_syscall_32 (arch/x86/entry/common.c:164 arch/x86/entry/common.c:184) 
[ 678.716403][ T1] ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
[ 678.716406][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:188) 
[ 678.716408][ T1] ? irqentry_exit_to_user_mode (kernel/entry/common.c:312) 
[ 678.716412][ T1] ? irqentry_exit (kernel/entry/common.c:445) 
[ 678.716415][ T1] ? exc_page_fault (arch/x86/mm/fault.c:1565) 
[ 678.716417][ T1] ? rest_init (init/main.c:1433) 
[ 678.716420][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  678.716424][    T1] EIP: 0xb7e9b6c2
[ 678.716427][ T1] Code: 90 66 90 66 90 66 90 90 56 53 83 ec 14 8b 5c 24 20 8b 4c 24 24 8b 54 24 28 65 a1 0c 00 00 00 85 c0 75 15 b8 04 00 00 00 cd 80 <3d> 00 f0 ff ff 77 47 83 c4 14 5b 5e c3 90 89 54 24 0c 89 4c 24 08
All code
========
   0:	90                   	nop
   1:	66 90                	xchg   %ax,%ax
   3:	66 90                	xchg   %ax,%ax
   5:	66 90                	xchg   %ax,%ax
   7:	90                   	nop
   8:	56                   	push   %rsi
   9:	53                   	push   %rbx
   a:	83 ec 14             	sub    $0x14,%esp
   d:	8b 5c 24 20          	mov    0x20(%rsp),%ebx
  11:	8b 4c 24 24          	mov    0x24(%rsp),%ecx
  15:	8b 54 24 28          	mov    0x28(%rsp),%edx
  19:	65 a1 0c 00 00 00 85 	movabs %gs:0x1575c0850000000c,%eax
  20:	c0 75 15 
  23:	b8 04 00 00 00       	mov    $0x4,%eax
  28:	cd 80                	int    $0x80


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231128/202311282251.b5351d99-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

