Return-Path: <linux-kernel+bounces-18472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4C825E1F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617FE1C23B99
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19215D2;
	Sat,  6 Jan 2024 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyduCkpL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35215B1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704512238; x=1736048238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8JNeGAeX5ljoZas15MfqQAb6FSvYoz7XZzjafFbHUuk=;
  b=kyduCkpL7GCjXspcdT1QEMrn/6FmpQ2eMwUkJq25+QHvu9HpKApoytoJ
   zk0xKx7IXHuD+LEF/vsbFd/47niEcgz/03cKTMeT6/K6g8UzdxVmifdu8
   0jAiuAF4Rw4BYwJWqHAUse4K/9N6gsJJUA1qZYJ1n7w06Be0erhJ87HFH
   sh4Fdw6vj+e0IROQpOILgpwOsRDGLsc7faF66PgNdC1owC9WuiY/TbT53
   GiVMvTiggIXD2ImYfyef/U2c+HyyECGF+a1U5i36JVRi0hBzz8YezZq8Z
   90c4eeUkUYGiJUptZx9mNWKz9OCDmptz4o8b/mND5eyPITT04QuJLQW0e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="10987219"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="10987219"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 19:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="730636255"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="730636255"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2024 19:37:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLxUo-0001zI-1H;
	Sat, 06 Jan 2024 03:37:14 +0000
Date: Sat, 6 Jan 2024 11:36:20 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Ren <guoren@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/irq.c:49:1: sparse: sparse: symbol
 '__pcpu_scope_irq_stack' was not declared. Should it be static?
Message-ID: <202401061149.NAyvwB2V-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4ab2706bb1280693e7dff1c5c42a8cb9d70c177
commit: 163e76cc6ef43b7a5e9b6e245a6d6667c9d9b4a7 riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
date:   7 months ago
config: riscv-randconfig-r122-20231115 (https://download.01.org/0day-ci/archive/20240106/202401061149.NAyvwB2V-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240106/202401061149.NAyvwB2V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061149.NAyvwB2V-lkp@intel.com/

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

