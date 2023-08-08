Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A37773678
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHHCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHHCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:23:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47021711;
        Mon,  7 Aug 2023 19:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691461427; x=1722997427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7npmpsHRBPQceHeeiMRXcb5INCBFSr1nYwKql1PF7I=;
  b=hNUqbTV+E0B2uD2wQonu+8jR7ghVXuQBnz7xKMs4cV3+J4dUqGGtcULu
   yJv7S/o+1Xq4b2AZMzrnB3VKIIca7Mm1TZXF9GQrrLHVl4bGjd6Sn98JU
   SsgywGHobPP43ZvISRL3mZYcw+McAVb47YO6seT51vb1H/Hdfdy7cNsbs
   MIAYs+yaNj5QB1igYGgQtLlGudu+bppfZ5I5HCSP68K45kiIDxcTMgAHl
   9yKO7XobND3DgROS7a/vs7e+82YnvcV8tax0BEUgSD75DWA9PrrsbFeU2
   iQPACFugHrEyulFe7yoqFyl1iDQj0wB4uCVq85f7JKGHdm2ij7gkBbN1U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360788176"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360788176"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 19:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731196850"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="731196850"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2023 19:23:33 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTCNg-00051R-1Y;
        Tue, 08 Aug 2023 02:23:32 +0000
Date:   Tue, 8 Aug 2023 10:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] Makefile.extrawarn: enable
 -Wmissing-variable-declarations for W=1
Message-ID: <202308081000.tTL1ElTr-lkp@intel.com>
References: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/Makefile-extrawarn-enable-Wmissing-variable-declarations-for-W-1/20230808-005859
base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
patch link:    https://lore.kernel.org/r/20230807-missing_proto-v2-1-3ae2e188bb0c%40google.com
patch subject: [PATCH v2] Makefile.extrawarn: enable -Wmissing-variable-declarations for W=1
config: riscv-randconfig-r014-20230807 (https://download.01.org/0day-ci/archive/20230808/202308081000.tTL1ElTr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081000.tTL1ElTr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308081000.tTL1ElTr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   2 warnings generated.
--
   In file included from arch/riscv/kernel/process.c:10:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:15:
   In file included from include/linux/dev_printk.h:16:
   In file included from include/linux/ratelimit.h:6:
   In file included from include/linux/sched.h:12:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
>> arch/riscv/kernel/process.c:29:24: warning: no previous extern declaration for non-static variable 'gp_in_global' [-Wmissing-variable-declarations]
      29 | register unsigned long gp_in_global __asm__("gp");
         |                        ^
   arch/riscv/kernel/process.c:29:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      29 | register unsigned long gp_in_global __asm__("gp");
         |          ^
   3 warnings generated.
--
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
>> arch/riscv/mm/init.c:276:7: warning: no previous extern declaration for non-static variable 'trampoline_pg_dir' [-Wmissing-variable-declarations]
     276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
         |       ^
   arch/riscv/mm/init.c:276:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
     276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
         | ^
>> arch/riscv/mm/init.c:279:7: warning: no previous extern declaration for non-static variable 'early_pg_dir' [-Wmissing-variable-declarations]
     279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
         |       ^
   arch/riscv/mm/init.c:279:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
     279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
         | ^
   4 warnings generated.
--
   drivers/char/ipmi/ipmi_si_platform.c:272:15: warning: cast to smaller integer type 'enum si_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     272 |         io.si_type      = (enum si_type) match->data;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/char/ipmi/ipmi_si_platform.c:13:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   3 warnings generated.
--
>> net/atm/mpc.c:123:21: warning: no previous extern declaration for non-static variable 'mpcs' [-Wmissing-variable-declarations]
     123 | struct mpoa_client *mpcs = NULL; /* FIXME */
         |                     ^
   net/atm/mpc.c:123:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
     123 | struct mpoa_client *mpcs = NULL; /* FIXME */
         | ^
   In file included from net/atm/mpc.c:6:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   3 warnings generated.
--
>> net/llc/llc_conn.c:44:5: warning: no previous extern declaration for non-static variable 'sysctl_llc2_ack_timeout' [-Wmissing-variable-declarations]
      44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
         |     ^
   net/llc/llc_conn.c:44:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
         | ^
>> net/llc/llc_conn.c:45:5: warning: no previous extern declaration for non-static variable 'sysctl_llc2_p_timeout' [-Wmissing-variable-declarations]
      45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
         |     ^
   net/llc/llc_conn.c:45:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
         | ^
>> net/llc/llc_conn.c:46:5: warning: no previous extern declaration for non-static variable 'sysctl_llc2_rej_timeout' [-Wmissing-variable-declarations]
      46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
         |     ^
   net/llc/llc_conn.c:46:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
         | ^
>> net/llc/llc_conn.c:47:5: warning: no previous extern declaration for non-static variable 'sysctl_llc2_busy_timeout' [-Wmissing-variable-declarations]
      47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
         |     ^
   net/llc/llc_conn.c:47:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
         | ^
   In file included from net/llc/llc_conn.c:16:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   6 warnings generated.
--
   drivers/i2c/busses/i2c-bcm-iproc.c:1039:3: warning: cast to smaller integer type 'enum bcm_iproc_i2c_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
    1039 |                 (enum bcm_iproc_i2c_type)of_device_get_match_data(&pdev->dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-bcm-iproc.c:4:
   In file included from include/linux/delay.h:23:
   In file included from include/linux/sched.h:12:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   3 warnings generated.
--
>> drivers/i2c/busses/i2c-amd756.c:286:20: warning: no previous extern declaration for non-static variable 'amd756_smbus' [-Wmissing-variable-declarations]
     286 | struct i2c_adapter amd756_smbus = {
         |                    ^
   drivers/i2c/busses/i2c-amd756.c:286:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
     286 | struct i2c_adapter amd756_smbus = {
         | ^
   In file included from drivers/i2c/busses/i2c-amd756.c:25:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   3 warnings generated.
--
   drivers/i2c/busses/i2c-rcar.c:1066:18: warning: cast to smaller integer type 'enum rcar_i2c_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
    1066 |         priv->devtype = (enum rcar_i2c_type)of_device_get_match_data(dev);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/i2c/busses/i2c-rcar.c:15:
   In file included from include/linux/clk.h:14:
   In file included from include/linux/notifier.h:14:
   In file included from include/linux/mutex.h:14:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   3 warnings generated.
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
>> arch/riscv/include/asm/current.h:20:30: warning: no previous extern declaration for non-static variable 'riscv_current_is_tp' [-Wmissing-variable-declarations]
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |                              ^
   arch/riscv/include/asm/current.h:20:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      20 | register struct task_struct *riscv_current_is_tp __asm__("tp");
         |          ^
>> arch/riscv/include/asm/current.h:36:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |                        ^
   arch/riscv/include/asm/current.h:36:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
      36 | register unsigned long current_stack_pointer __asm__("sp");
         |          ^
   2 warnings generated.


vim +/riscv_current_is_tp +20 arch/riscv/include/asm/current.h

7db91e57a0acde Palmer Dabbelt 2017-07-10  19  
52e7c52d2ded59 Palmer Dabbelt 2020-02-27 @20  register struct task_struct *riscv_current_is_tp __asm__("tp");
52e7c52d2ded59 Palmer Dabbelt 2020-02-27  21  
7db91e57a0acde Palmer Dabbelt 2017-07-10  22  /*
7db91e57a0acde Palmer Dabbelt 2017-07-10  23   * This only works because "struct thread_info" is at offset 0 from "struct
7db91e57a0acde Palmer Dabbelt 2017-07-10  24   * task_struct".  This constraint seems to be necessary on other architectures
7db91e57a0acde Palmer Dabbelt 2017-07-10  25   * as well, but __switch_to enforces it.  We can't check TASK_TI here because
7db91e57a0acde Palmer Dabbelt 2017-07-10  26   * <asm/asm-offsets.h> includes this, and I can't get the definition of "struct
7db91e57a0acde Palmer Dabbelt 2017-07-10  27   * task_struct" here due to some header ordering problems.
7db91e57a0acde Palmer Dabbelt 2017-07-10  28   */
7db91e57a0acde Palmer Dabbelt 2017-07-10  29  static __always_inline struct task_struct *get_current(void)
7db91e57a0acde Palmer Dabbelt 2017-07-10  30  {
52e7c52d2ded59 Palmer Dabbelt 2020-02-27  31  	return riscv_current_is_tp;
7db91e57a0acde Palmer Dabbelt 2017-07-10  32  }
7db91e57a0acde Palmer Dabbelt 2017-07-10  33  
7db91e57a0acde Palmer Dabbelt 2017-07-10  34  #define current get_current()
7db91e57a0acde Palmer Dabbelt 2017-07-10  35  
fdecfea09328b3 Kees Cook      2022-02-23 @36  register unsigned long current_stack_pointer __asm__("sp");
fdecfea09328b3 Kees Cook      2022-02-23  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
