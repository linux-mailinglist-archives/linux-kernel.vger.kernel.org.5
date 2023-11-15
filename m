Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71DB7EC64E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbjKOOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbjKOOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:51:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52A8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700059862; x=1731595862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9D3T4M10CW55F/QDP/Mvbsq/NHZU+GWFUpkbGjqS5g4=;
  b=nb5Nj/ryw3WXJDS8wAb83wFmeUF4B72jBz3uTzDwlWTb2XMhDQjDFmrh
   U05t+8XeRa8ajnjN9KIL0IbaXUWGkCWGz0axldTUW+Apq8/P1JnpURo+T
   ocz6M2jdQxDeQVlbV0sH4YkOJA3rl0v8p9qP2I3lyY/k5EkfhY0xgKqoa
   KkbmXaaDToD4JbteipuXllXFmPq2uqjnbW8q9pwEvUebNs/uiypjgY7bT
   2/aIV2+wxLzfoiOCOfFCtxF52Sz4tMdludLtc/JlqoyrmtZUJFpzJo4Io
   6+SDRf1oObmMOx2ONWbLRZzPQ326l5wAxUUvMBc97ZtvWokN6UV7y2i6j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9524551"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="9524551"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938496598"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="938496598"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2023 06:50:59 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3HEG-0000Pu-2g;
        Wed, 15 Nov 2023 14:50:56 +0000
Date:   Wed, 15 Nov 2023 22:50:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol
 '__pcpu_scope_irq_stack' was not declared. Should it be static?
Message-ID: <202311152232.0ru8PmcL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 163e76cc6ef43b7a5e9b6e245a6d6667c9d9b4a7 riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
date:   5 months ago
config: riscv-randconfig-r122-20231115 (https://download.01.org/0day-ci/archive/20231115/202311152232.0ru8PmcL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311152232.0ru8PmcL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152232.0ru8PmcL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol '__pcpu_scope_irq_stack' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack +49 arch/riscv/kernel/irq.c

    35	
    36	#ifdef CONFIG_VMAP_STACK
    37	static void init_irq_stacks(void)
    38	{
    39		int cpu;
    40		ulong *p;
    41	
    42		for_each_possible_cpu(cpu) {
    43			p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
    44			per_cpu(irq_stack_ptr, cpu) = p;
    45		}
    46	}
    47	#else
    48	/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
  > 49	DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack);
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
