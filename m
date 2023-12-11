Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FB80D466
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbjLKRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:48:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C41C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702316921; x=1733852921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLImz+EXZO7V7YXyByl+kJdIfQXnc14wntMYFsSl1j0=;
  b=mN/qKyX5bn1IIr0bjExdWYMUEhFMb61FMkNDKyAbe25pR+lLvRl4o3iV
   k13NLLtT24AonS3v3NBsefa5RFDeE5mvCV0ON4PnItnzw0qzGoqfOkO0A
   ckf44sfLLOrw8MnEt/nFso9pdmSkTdCmL6z0EZcX9Kg5Nko0vkaEspl8M
   k9CzWYL2kZKledShkCQHv30wAlN5pHd/F6vMEjnC/1nXjaRKE/GkXAPH/
   duDNlasOhlZbGM3BtzW4N2l7n4EXldoVbuSxJkI0/hhKbTf46rOQHWDsa
   TGkywxIfjBr45pXKzdHqREXFfsBl5AZ+yflxBU3QE2wKEddqXdmLO736Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="13379980"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="13379980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 09:40:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="14550105"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2023 09:40:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCkGq-000II6-1J;
        Mon, 11 Dec 2023 17:40:44 +0000
Date:   Tue, 12 Dec 2023 01:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/mips/include/asm/mipsregs.h:2791:3: error: instruction requires
 a CPU feature not currently enabled
Message-ID: <202312120116.CP1IYKWT-lkp@intel.com>
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

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: f12b034afeb3a977bbb1c6584dedc0f3dc666f14 scripts/Makefile.clang: default to LLVM_IAS=1
date:   2 years, 4 months ago
config: mips-malta_kvm_defconfig (https://download.01.org/0day-ci/archive/20231212/202312120116.CP1IYKWT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120116.CP1IYKWT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120116.CP1IYKWT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/kvm/tlb.c:13:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/mips/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/mips/include/asm/div64.h:89:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:32:
   In file included from arch/mips/include/asm/bitops.h:19:
   In file included from arch/mips/include/asm/barrier.h:11:
   In file included from arch/mips/include/asm/addrspace.h:13:
   In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
   In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
>> arch/mips/include/asm/mipsregs.h:2791:3: error: instruction requires a CPU feature not currently enabled
                   _ASM_SET_VIRT
                   ^
   arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_ASM_SET_VIRT'
   #define _ASM_SET_VIRT ".set\tvirt\n\t"
                                      ^
   <inline asm>:4:2: note: instantiated into assembly here
           tlbgp
           ^
   In file included from arch/mips/kvm/tlb.c:13:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/mips/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/mips/include/asm/div64.h:89:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:32:
   In file included from arch/mips/include/asm/bitops.h:19:
   In file included from arch/mips/include/asm/barrier.h:11:
   In file included from arch/mips/include/asm/addrspace.h:13:
   In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
   In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
   arch/mips/include/asm/mipsregs.h:2801:3: error: instruction requires a CPU feature not currently enabled
                   _ASM_SET_VIRT
                   ^
   arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_ASM_SET_VIRT'
   #define _ASM_SET_VIRT ".set\tvirt\n\t"
                                      ^
   <inline asm>:4:2: note: instantiated into assembly here
           tlbgr
           ^
   In file included from arch/mips/kvm/tlb.c:13:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/mips/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/mips/include/asm/div64.h:89:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:32:
   In file included from arch/mips/include/asm/bitops.h:19:
   In file included from arch/mips/include/asm/barrier.h:11:
   In file included from arch/mips/include/asm/addrspace.h:13:
   In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
   In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
   arch/mips/include/asm/mipsregs.h:2811:3: error: instruction requires a CPU feature not currently enabled
                   _ASM_SET_VIRT
                   ^
   arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_ASM_SET_VIRT'
   #define _ASM_SET_VIRT ".set\tvirt\n\t"
                                      ^
   <inline asm>:4:2: note: instantiated into assembly here
           tlbgwi
           ^
   In file included from arch/mips/kvm/tlb.c:13:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/mips/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/mips/include/asm/div64.h:89:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:32:
   In file included from arch/mips/include/asm/bitops.h:19:
   In file included from arch/mips/include/asm/barrier.h:11:
   In file included from arch/mips/include/asm/addrspace.h:13:
   In file included from arch/mips/include/asm/mach-malta/spaces.h:44:
   In file included from arch/mips/include/asm/mach-generic/spaces.h:15:
   arch/mips/include/asm/mipsregs.h:2801:3: error: instruction requires a CPU feature not currently enabled
                   _ASM_SET_VIRT
                   ^
   arch/mips/include/asm/mipsregs.h:2073:36: note: expanded from macro '_ASM_SET_VIRT'
   #define _ASM_SET_VIRT ".set\tvirt\n\t"
                                      ^
   <inline asm>:4:2: note: instantiated into assembly here
           tlbgr
           ^
   In file included from arch/mips/kvm/tlb.c:13:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/mips/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:14:
   In file included from include/linux/restart_block.h:10:
   In file included from include/linux/time64.h:5:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/mips/include/asm/div64.h:89:
   In file included from include/asm-generic/div64.h:55:


vim +2791 arch/mips/include/asm/mipsregs.h

^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16  2780  
^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16  2781  /*
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2782   * Guest TLB operations.
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2783   *
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2784   * It is responsibility of the caller to take care of any TLB hazards.
^1da177e4c3f41 include/asm-mips/mipsregs.h      Linus Torvalds 2005-04-16  2785   */
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2786  static inline void guest_tlb_probe(void)
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2787  {
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2788  	__asm__ __volatile__(
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2789  		".set push\n\t"
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2790  		".set noreorder\n\t"
00b4eb408aaff2 arch/mips/include/asm/mipsregs.h James Hogan    2017-11-22 @2791  		_ASM_SET_VIRT
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2792  		"tlbgp\n\t"
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2793  		".set pop");
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2794  }
7eb91118227d71 arch/mips/include/asm/mipsregs.h James Hogan    2016-05-11  2795  

:::::: The code at line 2791 was first introduced by commit
:::::: 00b4eb408aaff21aeb806de24c5ff25b398083a4 MIPS: VZ: Update helpers to use new asm macros

:::::: TO: James Hogan <jhogan@kernel.org>
:::::: CC: James Hogan <jhogan@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
