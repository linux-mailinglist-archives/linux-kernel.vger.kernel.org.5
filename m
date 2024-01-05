Return-Path: <linux-kernel+bounces-17649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB99825098
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E76281B62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54422F05;
	Fri,  5 Jan 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nds/cX3E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F024201
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704445813; x=1735981813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dZPVqfWRlpt41RlG0uqz1mITwbjH23pG5K3j08buB/Y=;
  b=Nds/cX3EflC6mjbloV1086wnxTWdE3vT/YVHor+SSBv5EHi9Zi0QapRl
   uezDZmm8vCsiqWgy6OSQMW8PGK45VXJ5m1Hoqd1BA1ZeL1zTOkH3W3QEA
   ovONdmqGwvnMW6kD7PqpurLpMNKNnardt1O9lLjcGuxKZMhyGvyePJKRC
   2a/FszS7fFCPO8KU+6Yy/czR3+FXua47RUXCU6uLfzS36ASQIjYE3Wwnk
   CUk58AIiQWKUsnCUZfFzbmy6mhALfh7CZfy3/nqt2Oea1Jfc0ITruCL8a
   Ttj3+fz1eZOiDs52II38b52fzRodk+GRf6iQHEjGaakN5Qu4RYIYoxqsK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="461768752"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="461768752"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 01:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="15192501"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jan 2024 01:10:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLgDR-00012O-1s;
	Fri, 05 Jan 2024 09:10:09 +0000
Date: Fri, 5 Jan 2024 17:10:08 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Ren <guoren@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol
 '__pcpu_scope_irq_stack' was not declared. Should it be static?
Message-ID: <202401051709.Lg5tIeRM-lkp@intel.com>
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
commit: 163e76cc6ef43b7a5e9b6e245a6d6667c9d9b4a7 riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
date:   7 months ago
config: riscv-randconfig-r122-20231115 (https://download.01.org/0day-ci/archive/20240105/202401051709.Lg5tIeRM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401051709.Lg5tIeRM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051709.Lg5tIeRM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
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

