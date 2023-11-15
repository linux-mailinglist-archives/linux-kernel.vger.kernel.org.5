Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C97EC6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbjKOPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjKOPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:12:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDF018A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700061166; x=1731597166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zg/FrYNguA5bYUtmam6boMPWLJ82sxXO7j+pEqMltYM=;
  b=TfR2qfBGTI7Bl6ChWkmei/T6uKwAmA22bjL/GOT0s85N338+t7s9ZZd0
   nkypxehhVbhPS3SgvR93Aa2SWhiIzRtsQLZZV8zetuL3aLclkWugh4HSQ
   49la4oYUPm4d63aIjbqH/EmBQlyslXbVbGsoV3KTio1ueaefHUfO4AvQL
   tZX8MCam9nD2/BtNjM8iyh3GaOBg2MUOAzNGDhIztxjepHCp5Nmo7ThzH
   MRqSlbbQ6Z2VK6E9fyPIWNmt/DHajfOvT2HiYdfzvxFwDdFQFV+RvmoiA
   63fBc08iQ71uAlT+8Ztmyb7/YgnIRS9dQe0r+ysr6OdjVsnGIonLo/r82
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393747582"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393747582"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765004764"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="765004764"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 07:12:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3HZJ-0000RG-2j;
        Wed, 15 Nov 2023 15:12:41 +0000
Date:   Wed, 15 Nov 2023 23:12:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202311152329.0WtGONlQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: fa8e7cce55da3569259dc270801885c420eb50fe riscv: Enable Vector code to be built
date:   5 months ago
config: riscv-randconfig-r133-20231115 (https://download.01.org/0day-ci/archive/20231115/202311152329.0WtGONlQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311152329.0WtGONlQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152329.0WtGONlQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *__x @@     got void [noderef] __user *[assigned] datap @@
   arch/riscv/kernel/signal.c:94:16: sparse:     expected void *__x
   arch/riscv/kernel/signal.c:94:16: sparse:     got void [noderef] __user *[assigned] datap
>> arch/riscv/kernel/signal.c:126:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:126:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:126:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:126:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:126:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:126:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:126:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:126:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:126:15: sparse:     got void *
>> arch/riscv/kernel/signal.c:126:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *datap @@     got void * @@
   arch/riscv/kernel/signal.c:126:15: sparse:     expected void [noderef] __user *datap
   arch/riscv/kernel/signal.c:126:15: sparse:     got void *

vim +94 arch/riscv/kernel/signal.c

8ee0b41898fa26 Greentime Hu 2023-06-05   72  
8ee0b41898fa26 Greentime Hu 2023-06-05   73  static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
8ee0b41898fa26 Greentime Hu 2023-06-05   74  {
8ee0b41898fa26 Greentime Hu 2023-06-05   75  	struct __riscv_ctx_hdr __user *hdr;
8ee0b41898fa26 Greentime Hu 2023-06-05   76  	struct __sc_riscv_v_state __user *state;
8ee0b41898fa26 Greentime Hu 2023-06-05   77  	void __user *datap;
8ee0b41898fa26 Greentime Hu 2023-06-05   78  	long err;
8ee0b41898fa26 Greentime Hu 2023-06-05   79  
8ee0b41898fa26 Greentime Hu 2023-06-05   80  	hdr = *sc_vec;
8ee0b41898fa26 Greentime Hu 2023-06-05   81  	/* Place state to the user's signal context space after the hdr */
8ee0b41898fa26 Greentime Hu 2023-06-05   82  	state = (struct __sc_riscv_v_state __user *)(hdr + 1);
8ee0b41898fa26 Greentime Hu 2023-06-05   83  	/* Point datap right after the end of __sc_riscv_v_state */
8ee0b41898fa26 Greentime Hu 2023-06-05   84  	datap = state + 1;
8ee0b41898fa26 Greentime Hu 2023-06-05   85  
8ee0b41898fa26 Greentime Hu 2023-06-05   86  	/* datap is designed to be 16 byte aligned for better performance */
8ee0b41898fa26 Greentime Hu 2023-06-05   87  	WARN_ON(unlikely(!IS_ALIGNED((unsigned long)datap, 16)));
8ee0b41898fa26 Greentime Hu 2023-06-05   88  
8ee0b41898fa26 Greentime Hu 2023-06-05   89  	riscv_v_vstate_save(current, regs);
8ee0b41898fa26 Greentime Hu 2023-06-05   90  	/* Copy everything of vstate but datap. */
8ee0b41898fa26 Greentime Hu 2023-06-05   91  	err = __copy_to_user(&state->v_state, &current->thread.vstate,
8ee0b41898fa26 Greentime Hu 2023-06-05   92  			     offsetof(struct __riscv_v_ext_state, datap));
8ee0b41898fa26 Greentime Hu 2023-06-05   93  	/* Copy the pointer datap itself. */
8ee0b41898fa26 Greentime Hu 2023-06-05  @94  	err |= __put_user(datap, &state->v_state.datap);
8ee0b41898fa26 Greentime Hu 2023-06-05   95  	/* Copy the whole vector content to user space datap. */
8ee0b41898fa26 Greentime Hu 2023-06-05   96  	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
8ee0b41898fa26 Greentime Hu 2023-06-05   97  	/* Copy magic to the user space after saving  all vector conetext */
8ee0b41898fa26 Greentime Hu 2023-06-05   98  	err |= __put_user(RISCV_V_MAGIC, &hdr->magic);
8ee0b41898fa26 Greentime Hu 2023-06-05   99  	err |= __put_user(riscv_v_sc_size, &hdr->size);
8ee0b41898fa26 Greentime Hu 2023-06-05  100  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  101  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  102  
8ee0b41898fa26 Greentime Hu 2023-06-05  103  	/* Only progress the sv_vec if everything has done successfully  */
8ee0b41898fa26 Greentime Hu 2023-06-05  104  	*sc_vec += riscv_v_sc_size;
8ee0b41898fa26 Greentime Hu 2023-06-05  105  	return 0;
8ee0b41898fa26 Greentime Hu 2023-06-05  106  }
8ee0b41898fa26 Greentime Hu 2023-06-05  107  
8ee0b41898fa26 Greentime Hu 2023-06-05  108  /*
8ee0b41898fa26 Greentime Hu 2023-06-05  109   * Restore Vector extension context from the user's signal frame. This function
8ee0b41898fa26 Greentime Hu 2023-06-05  110   * assumes a valid extension header. So magic and size checking must be done by
8ee0b41898fa26 Greentime Hu 2023-06-05  111   * the caller.
8ee0b41898fa26 Greentime Hu 2023-06-05  112   */
8ee0b41898fa26 Greentime Hu 2023-06-05  113  static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
8ee0b41898fa26 Greentime Hu 2023-06-05  114  {
8ee0b41898fa26 Greentime Hu 2023-06-05  115  	long err;
8ee0b41898fa26 Greentime Hu 2023-06-05  116  	struct __sc_riscv_v_state __user *state = sc_vec;
8ee0b41898fa26 Greentime Hu 2023-06-05  117  	void __user *datap;
8ee0b41898fa26 Greentime Hu 2023-06-05  118  
8ee0b41898fa26 Greentime Hu 2023-06-05  119  	/* Copy everything of __sc_riscv_v_state except datap. */
8ee0b41898fa26 Greentime Hu 2023-06-05  120  	err = __copy_from_user(&current->thread.vstate, &state->v_state,
8ee0b41898fa26 Greentime Hu 2023-06-05  121  			       offsetof(struct __riscv_v_ext_state, datap));
8ee0b41898fa26 Greentime Hu 2023-06-05  122  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  123  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  124  
8ee0b41898fa26 Greentime Hu 2023-06-05  125  	/* Copy the pointer datap itself. */
8ee0b41898fa26 Greentime Hu 2023-06-05 @126  	err = __get_user(datap, &state->v_state.datap);
8ee0b41898fa26 Greentime Hu 2023-06-05  127  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  128  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  129  	/*
8ee0b41898fa26 Greentime Hu 2023-06-05  130  	 * Copy the whole vector content from user space datap. Use
8ee0b41898fa26 Greentime Hu 2023-06-05  131  	 * copy_from_user to prevent information leak.
8ee0b41898fa26 Greentime Hu 2023-06-05  132  	 */
8ee0b41898fa26 Greentime Hu 2023-06-05  133  	err = copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
8ee0b41898fa26 Greentime Hu 2023-06-05  134  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu 2023-06-05  135  		return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  136  
8ee0b41898fa26 Greentime Hu 2023-06-05  137  	riscv_v_vstate_restore(current, regs);
8ee0b41898fa26 Greentime Hu 2023-06-05  138  
8ee0b41898fa26 Greentime Hu 2023-06-05  139  	return err;
8ee0b41898fa26 Greentime Hu 2023-06-05  140  }
8ee0b41898fa26 Greentime Hu 2023-06-05  141  #else
8ee0b41898fa26 Greentime Hu 2023-06-05  142  #define save_v_state(task, regs) (0)
8ee0b41898fa26 Greentime Hu 2023-06-05  143  #define __restore_v_state(task, regs) (0)
8ee0b41898fa26 Greentime Hu 2023-06-05  144  #endif
8ee0b41898fa26 Greentime Hu 2023-06-05  145  

:::::: The code at line 94 was first introduced by commit
:::::: 8ee0b41898fa26f66e32237f179b6989c65600d6 riscv: signal: Add sigcontext save/restore for vector

:::::: TO: Greentime Hu <greentime.hu@sifive.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
