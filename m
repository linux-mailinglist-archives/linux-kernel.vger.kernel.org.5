Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692A67DF541
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjKBOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKBOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:44:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D312F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698936235; x=1730472235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ToMx0zsKHa33A5OS7v8oe2ysHJL48zSdQB/ks4J+aMk=;
  b=duSDRAl4ziRd3gDumWkN9Wh6/KCIhEqZ8U6Sbw0OiqRdn1POci8rLBe1
   wuoBhzzt4oE/my3c/RMAtd/Efiv+vSbdukqrzbCYhbaB7/ejix5MlyrgC
   kBMfWbw23GMT9n6kk/5sYiqY7fNGcdbDvAcEj7bnCjUpc5IaCEl/iwp4M
   AG+5QWsn54AkovnYSaVlTIx40O1s+5X+UEIz9S4xQl+lHIHrtr7SxrGWy
   0AUUzQ4GUnjy/pDoDNoaJ46zQqeWc2UQ6WNjEF/b09AnNLsnsr1MKGPaz
   kLAn8EUV5Lx3zhn8V5Ckl1a970tHfI57ue3c6w0qz1YZueqcTo9oYkmCg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368934050"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368934050"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 07:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878266017"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="878266017"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Nov 2023 07:43:52 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyYvG-0001Wl-0V;
        Thu, 02 Nov 2023 14:43:50 +0000
Date:   Thu, 2 Nov 2023 22:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202311022215.63HoWcPG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: fa8e7cce55da3569259dc270801885c420eb50fe riscv: Enable Vector code to be built
date:   5 months ago
config: riscv-randconfig-r112-20231102 (https://download.01.org/0day-ci/archive/20231102/202311022215.63HoWcPG-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231102/202311022215.63HoWcPG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311022215.63HoWcPG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *__val @@     got void [noderef] __user *[assigned] datap @@
   arch/riscv/kernel/signal.c:94:16: sparse:     expected void *__val
   arch/riscv/kernel/signal.c:94:16: sparse:     got void [noderef] __user *[assigned] datap

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

:::::: The code at line 94 was first introduced by commit
:::::: 8ee0b41898fa26f66e32237f179b6989c65600d6 riscv: signal: Add sigcontext save/restore for vector

:::::: TO: Greentime Hu <greentime.hu@sifive.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
