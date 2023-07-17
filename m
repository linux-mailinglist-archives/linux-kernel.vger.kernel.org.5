Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2C755975
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQCU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:20:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACEEC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689560453; x=1721096453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vcCX3SPmtOHwPlSuadW9L7ob9i6f79f9ftVeUnr0ZQ4=;
  b=Q+jZ3yLXZFeTnEhHJMuHT2+wopox/gPNaChG+AzbyKkwbB8bHkAvSkiC
   RlPqbxWgpzm9SNGHtg/yAhLTiYQOOcXYCj2cf51pHOZrQ0PfoVLnH7ogy
   HnBqEO5n788I7sqh0hUp0ZOUK2fIe1AbGXsbB7qKinB2SmcpD8xmPwiQr
   QsNp3tpjggENxG3pD5H6cJxRZDmeVXcfn+Anw6buSAp+RqfwYhc1mQoff
   tjTlDkB66amqaielx3Q3EGTXyXnw1XYMXrsvzWSPQVCHS1gHVzfotQqIV
   u7uDmaORZBCQN/Yda2xk0+an8kd0hvFJJJMdXIkjnvwcP9LCWHSJDUzSR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="368465750"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368465750"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 19:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="1053730759"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053730759"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2023 19:20:37 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLDqn-00098W-08;
        Mon, 17 Jul 2023 02:20:37 +0000
Date:   Mon, 17 Jul 2023 10:20:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/kernel/signal.c:94:16: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202307171012.U1gkffCQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   5b8d6e8539498e8b2fa67fbcce3fe87834d44a7a
commit: fa8e7cce55da3569259dc270801885c420eb50fe riscv: Enable Vector code to be built
date:   6 weeks ago
config: riscv-randconfig-r071-20230717 (https://download.01.org/0day-ci/archive/20230717/202307171012.U1gkffCQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230717/202307171012.U1gkffCQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307171012.U1gkffCQ-lkp@intel.com/

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
