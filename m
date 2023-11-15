Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B907ED730
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjKOW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKOW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:29:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DA195
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700087380; x=1731623380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EiC7gsbr7b2lX/ptHSJXPvI6xefRfK//8GO+TYZnEmw=;
  b=OaOiAseZZ/+FnCyuHhLWeZU/Zv7hGKE3NhMEwPA4oPyd/L/HbtuUVgDr
   o9Y7HplWurE5aH4+VxuKTpwyJ44FsTCI5wCjxg8mfaWiaLLGUJh5HjmBq
   m76XmDZPzY+lZcMe4DJ93cR1tVYs28L0WRRaS9CPo/bkBJI0L+o8uRu7A
   rGU9K9l80A+YycDg9HQT6S1z/moPSy14yQhRj5XVi5+s/TXpObvh239Gv
   1zKOE36yFcrWTA7EPKzUk7Z5kay/71DFVLolVnBX0FCOGSWSqk7LqgoMG
   IDqTk/NhX1a/mTQ+Io3u6ZSgZbW9UXK5Ybfo1CEKaQqed+tFGnRM3FOrQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370326109"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="370326109"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 14:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888717426"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="888717426"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2023 14:29:38 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3OO7-0000uq-2b;
        Wed, 15 Nov 2023 22:29:35 +0000
Date:   Thu, 16 Nov 2023 06:29:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: arch/riscv/kernel/traps_misaligned.c:249:21: sparse: sparse:
 dereference of noderef expression
Message-ID: <202311160606.obGOOwB3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 7c83232161f609bbc452a1255f823f41afc411dd riscv: add support for misaligned trap handling in S-mode
date:   2 weeks ago
config: riscv-randconfig-r122-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160606.obGOOwB3-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160606.obGOOwB3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160606.obGOOwB3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/traps_misaligned.c:249:21: sparse: sparse: dereference of noderef expression
   arch/riscv/kernel/traps_misaligned.c:261:21: sparse: sparse: dereference of noderef expression
   arch/riscv/kernel/traps_misaligned.c:269:21: sparse: sparse: dereference of noderef expression
>> arch/riscv/kernel/traps_misaligned.c:210:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__gu_ptr @@     got unsigned char const [usertype] *addr @@
   arch/riscv/kernel/traps_misaligned.c:210:24: sparse:     expected unsigned char const [noderef] __user *__gu_ptr
   arch/riscv/kernel/traps_misaligned.c:210:24: sparse:     got unsigned char const [usertype] *addr
>> arch/riscv/kernel/traps_misaligned.c:249:21: sparse: sparse: dereference of noderef expression
   arch/riscv/kernel/traps_misaligned.c:261:21: sparse: sparse: dereference of noderef expression
   arch/riscv/kernel/traps_misaligned.c:269:21: sparse: sparse: dereference of noderef expression
>> arch/riscv/kernel/traps_misaligned.c:220:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [noderef] __user *__gu_ptr @@     got unsigned char [usertype] *addr @@
   arch/riscv/kernel/traps_misaligned.c:220:24: sparse:     expected unsigned char [noderef] __user *__gu_ptr
   arch/riscv/kernel/traps_misaligned.c:220:24: sparse:     got unsigned char [usertype] *addr

vim +249 arch/riscv/kernel/traps_misaligned.c

   172	
   173	static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
   174	{
   175		register ulong __mepc asm ("a2") = mepc;
   176		ulong val, rvc_mask = 3, tmp;
   177	
   178		asm ("and %[tmp], %[addr], 2\n"
   179			"bnez %[tmp], 1f\n"
   180	#if defined(CONFIG_64BIT)
   181			__stringify(LWU) " %[insn], (%[addr])\n"
   182	#else
   183			__stringify(LW) " %[insn], (%[addr])\n"
   184	#endif
   185			"and %[tmp], %[insn], %[rvc_mask]\n"
   186			"beq %[tmp], %[rvc_mask], 2f\n"
   187			"sll %[insn], %[insn], %[xlen_minus_16]\n"
   188			"srl %[insn], %[insn], %[xlen_minus_16]\n"
   189			"j 2f\n"
   190			"1:\n"
   191			"lhu %[insn], (%[addr])\n"
   192			"and %[tmp], %[insn], %[rvc_mask]\n"
   193			"bne %[tmp], %[rvc_mask], 2f\n"
   194			"lhu %[tmp], 2(%[addr])\n"
   195			"sll %[tmp], %[tmp], 16\n"
   196			"add %[insn], %[insn], %[tmp]\n"
   197			"2:"
   198		: [insn] "=&r" (val), [tmp] "=&r" (tmp)
   199		: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
   200		  [xlen_minus_16] "i" (XLEN_MINUS_16));
   201	
   202		*r_insn = val;
   203	
   204		return 0;
   205	}
   206	#else
   207	static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
   208	{
   209		if (user_mode(regs)) {
 > 210			return __get_user(*r_val, addr);
   211		} else {
   212			*r_val = *addr;
   213			return 0;
   214		}
   215	}
   216	
   217	static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
   218	{
   219		if (user_mode(regs)) {
 > 220			return __put_user(val, addr);
   221		} else {
   222			*addr = val;
   223			return 0;
   224		}
   225	}
   226	
   227	#define __read_insn(regs, insn, insn_addr)		\
   228	({							\
   229		int __ret;					\
   230								\
   231		if (user_mode(regs)) {				\
   232			__ret = __get_user(insn, insn_addr);	\
   233		} else {					\
   234			insn = *insn_addr;			\
   235			__ret = 0;				\
   236		}						\
   237								\
   238		__ret;						\
   239	})
   240	
   241	static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
   242	{
   243		ulong insn = 0;
   244	
   245		if (epc & 0x2) {
   246			ulong tmp = 0;
   247			u16 __user *insn_addr = (u16 __user *)epc;
   248	
 > 249			if (__read_insn(regs, insn, insn_addr))
   250				return -EFAULT;
   251			/* __get_user() uses regular "lw" which sign extend the loaded
   252			 * value make sure to clear higher order bits in case we "or" it
   253			 * below with the upper 16 bits half.
   254			 */
   255			insn &= GENMASK(15, 0);
   256			if ((insn & __INSN_LENGTH_MASK) != __INSN_LENGTH_32) {
   257				*r_insn = insn;
   258				return 0;
   259			}
   260			insn_addr++;
   261			if (__read_insn(regs, tmp, insn_addr))
   262				return -EFAULT;
   263			*r_insn = (tmp << 16) | insn;
   264	
   265			return 0;
   266		} else {
   267			u32 __user *insn_addr = (u32 __user *)epc;
   268	
   269			if (__read_insn(regs, insn, insn_addr))
   270				return -EFAULT;
   271			if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
   272				*r_insn = insn;
   273				return 0;
   274			}
   275			insn &= GENMASK(15, 0);
   276			*r_insn = insn;
   277	
   278			return 0;
   279		}
   280	}
   281	#endif
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
