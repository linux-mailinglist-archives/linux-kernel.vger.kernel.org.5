Return-Path: <linux-kernel+bounces-17517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60DE824EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4C1F212A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E651D68F;
	Fri,  5 Jan 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjAWIDrR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6E7E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704437144; x=1735973144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JlvFnuSmPNoN6vXHnFA8WgGBCZtC2XHTephpH6tPeLA=;
  b=LjAWIDrREOFyZ2a0st6h+NICfID0PE6y0erSJ0B/l5M1wGzfod/jNimv
   t4McFWwLCDOmnOqPRlL24DGJh/pfVFYiPX2OG/HPCsQRxjxW9a2kl3I+o
   JuZ9HnPzG9+/IhEfg1ezA8ZY62EcoxEHsypjCa/STIVgrRdRhnicIeEgv
   liI82SBRCdgH55gEKOag7zfFz/GbUKbhi0qJhvvK3ZHsWS742t1V8Yep8
   5ptpNpHE/lrbKUI988AR7FEeKc/Puxaao1F6REM3ZiyFmUIF0jommUqTG
   OKZWFkR6mkk4f4jfVWHAM2FK+5P6B8w3nF286kWUqn91TD//xIDiE+chF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="16064925"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="16064925"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851050332"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="851050332"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2024 22:45:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLdxZ-0000tk-0A;
	Fri, 05 Jan 2024 06:45:37 +0000
Date: Fri, 5 Jan 2024 14:44:46 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Ren <guoren@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202401051446.fmygnjmr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
commit: fa8e7cce55da3569259dc270801885c420eb50fe riscv: Enable Vector code to be built
date:   7 months ago
config: riscv-randconfig-r133-20231115 (https://download.01.org/0day-ci/archive/20240105/202401051446.fmygnjmr-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401051446.fmygnjmr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051446.fmygnjmr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
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

