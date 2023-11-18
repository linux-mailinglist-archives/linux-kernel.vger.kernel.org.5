Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE57EFEC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 10:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjKRJdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 04:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 04:32:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0612ED75
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700299975; x=1731835975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UT0xXKlsAD5tN+26TNuowKOiXYdidZQ+b0rSz01tHv8=;
  b=hT8W7cNcT4qx/1fz2jDSRSoT36+hC+IpXmlQ3LffIGp9XPJ9y/LFWbZK
   5MYmYv1kPWdS9vMq9FsJAxlg6bGBEsVAjeg82DxHJx18PhiVTEn7RpKy9
   vJ/vS9FXTfLs8KOCdJ1IrIcjXys8p/SVMY/DzaPN2n6Ao+jKY/BeC75C9
   Cr2WPyXZtL/eI/K3P9p8u4HWriVrp6b0i5iT84L6lHt0pR5GToQ5L/WEZ
   xYqAZ6cWYuuNVz0xuMTVmLc817NPTKOc4OVr4A7zCP8zFSS4LCOXtF/oh
   tyFDmLf1ks2h0ycK6viEp88BzDYbMSAxbZqyZLiVgpk8AalX6h+2NH1nZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="10077575"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="10077575"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 01:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097323012"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="1097323012"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2023 01:32:52 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Hh4-0003jr-0N;
        Sat, 18 Nov 2023 09:32:50 +0000
Date:   Sat, 18 Nov 2023 17:31:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naveen N Rao <naveen@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/kernel/trace/ftrace.c:752:46: sparse: sparse: cast
 truncates bits from constant value (200000000 becomes 0)
Message-ID: <202311181725.D58Uyh29-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: f3993a0330e2d11e42c095810c6c33084024df46 powerpc/ftrace: Extend ftrace support for large kernels to ppc32
date:   3 months ago
config: powerpc-randconfig-r111-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181725.D58Uyh29-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311181725.D58Uyh29-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181725.D58Uyh29-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/powerpc/kernel/trace/ftrace.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
>> arch/powerpc/kernel/trace/ftrace.c:752:46: sparse: sparse: cast truncates bits from constant value (200000000 becomes 0)
   arch/powerpc/kernel/trace/ftrace.c:752:72: sparse: sparse: cast truncates bits from constant value (200000000 becomes 0)

vim +752 arch/powerpc/kernel/trace/ftrace.c

84ade0a6655bee arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2022-05-16  720  
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  721  int __init ftrace_dyn_arch_init(void)
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  722  {
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  723  	unsigned int *tramp[] = { ftrace_tramp_text, ftrace_tramp_init };
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  724  	unsigned long addr = FTRACE_REGS_ADDR;
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  725  	long reladdr;
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  726  	int i;
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  727  	u32 stub_insns[] = {
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  728  #ifdef CONFIG_PPC_KERNEL_PCREL
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  729  		/* pla r12,addr */
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  730  		PPC_PREFIX_MLS | __PPC_PRFX_R(1),
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  731  		PPC_INST_PADDI | ___PPC_RT(_R12),
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  732  		PPC_RAW_MTCTR(_R12),
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  733  		PPC_RAW_BCTR()
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  734  #elif defined(CONFIG_PPC64)
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  735  		PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernel_toc)),
e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  736  		PPC_RAW_ADDIS(_R12, _R12, 0),
e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  737  		PPC_RAW_ADDI(_R12, _R12, 0),
e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  738  		PPC_RAW_MTCTR(_R12),
e89aa642be21b1 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  739  		PPC_RAW_BCTR()
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  740  #else
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  741  		PPC_RAW_LIS(_R12, 0),
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  742  		PPC_RAW_ADDI(_R12, _R12, 0),
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  743  		PPC_RAW_MTCTR(_R12),
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  744  		PPC_RAW_BCTR()
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  745  #endif
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  746  	};
af8b9f352ffd43 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  747  
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  748  	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  749  		for (i = 0; i < 2; i++) {
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  750  			reladdr = addr - (unsigned long)tramp[i];
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  751  
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08 @752  			if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  753  				pr_err("Address of %ps out of range of pcrel address.\n",
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  754  					(void *)addr);
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  755  				return -1;
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  756  			}
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  757  
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  758  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  759  			tramp[i][0] |= IMM_H18(reladdr);
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  760  			tramp[i][1] |= IMM_L(reladdr);
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  761  			add_ftrace_tramp((unsigned long)tramp[i]);
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  762  		}
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  763  	} else if (IS_ENABLED(CONFIG_PPC64)) {
af8b9f352ffd43 arch/powerpc/kernel/trace/ftrace.c Christophe Leroy 2022-05-09  764  		reladdr = addr - kernel_toc_addr();
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  765  
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  766  		if (reladdr >= (long)SZ_2G || reladdr < -(long long)SZ_2G) {
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  767  			pr_err("Address of %ps out of range of kernel_toc.\n",
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  768  				(void *)addr);
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  769  			return -1;
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  770  		}
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  771  
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  772  		for (i = 0; i < 2; i++) {
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  773  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  774  			tramp[i][1] |= PPC_HA(reladdr);
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  775  			tramp[i][2] |= PPC_LO(reladdr);
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  776  			add_ftrace_tramp((unsigned long)tramp[i]);
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  777  		}
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  778  	} else {
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  779  		for (i = 0; i < 2; i++) {
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  780  			memcpy(tramp[i], stub_insns, sizeof(stub_insns));
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  781  			tramp[i][0] |= PPC_HA(addr);
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  782  			tramp[i][1] |= PPC_LO(addr);
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  783  			add_ftrace_tramp((unsigned long)tramp[i]);
f3993a0330e2d1 arch/powerpc/kernel/trace/ftrace.c Naveen N Rao     2023-06-19  784  		}
7e3a68be42e10f arch/powerpc/kernel/trace/ftrace.c Nicholas Piggin  2023-04-08  785  	}
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  786  
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  787  	return 0;
67361cf8071286 arch/powerpc/kernel/trace/ftrace.c Naveen N. Rao    2018-10-17  788  }
6794c78243bfda arch/powerpc/kernel/ftrace.c       Steven Rostedt   2009-02-09  789  

:::::: The code at line 752 was first introduced by commit
:::::: 7e3a68be42e10f5fa5890e97afc0afd992355bc3 powerpc/64: vmlinux support building with PCREL addresing

:::::: TO: Nicholas Piggin <npiggin@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
