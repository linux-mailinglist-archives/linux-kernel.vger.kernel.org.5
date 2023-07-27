Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0A764D33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjG0IbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjG0I3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:29:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E8F9ABE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690445750; x=1721981750;
  h=date:from:to:cc:subject:message-id;
  bh=2flwP5tvX2sCPFwUTFEj96D6EoOZW5tSFp6hvxeh4a8=;
  b=GHQ1L2QCyxMADUI3+5QYlF3Ftfzk3NXXEkFEj4kRxV3pDWIjjJyhx0AE
   JPxP03YS6IpeMchEFksopSk0GIa9O+gN66NduoLV7K2SSg3odi+cXGEZH
   dYeZ6PAjxyiuBuLVJpZuihihunb8MY6Nm3WcF+xbK0na0PgbyEpfzWZIf
   bVlq0hZL9AEg9FoyRcvJpLn/1sycSJSHHWN1GXrYZU4pddSG8tql5H4iV
   4/GPtOy9n9cgr0KtB81p0GKnDx/hf+hV1paroi/qwuCfGEfJiH5asIRKZ
   CzayY+UDAKGrmCMOgY/gtIz6Tu1IzmZZl194lGfX815gLhJ2OrX1b33bo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434518355"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="434518355"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 01:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840627777"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840627777"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2023 01:13:51 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOw7b-000250-1t;
        Thu, 27 Jul 2023 08:13:31 +0000
Date:   Thu, 27 Jul 2023 16:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.07.24a] BUILD REGRESSION
 aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f
Message-ID: <202307271621.FDVwvqn6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.07.24a
branch HEAD: aaeb7f70ca6fef20998ac6aa580e42ca7b85fb7f  squash! fs/proc: Add /proc/cmdline_load for boot loader arguments

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307270622.15fzt0V1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307270637.D2qvjL9a-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/include/asm/cache.h:23: warning: "ARCH_DMA_MINALIGN" redefined
arch/parisc/include/asm/cache.h:25: warning: "__read_mostly" redefined
arch/sh/include/asm/cache.h:21: warning: "ARCH_DMA_MINALIGN" redefined
arch/sh/include/asm/cache.h:23: warning: "__read_mostly" redefined
include/linux/cache.h:72:31: error: 'L1_CACHE_SHIFT' undeclared here (not in a function); did you mean 'L1_CACHE_ALIGN'?
include/linux/init.h:149:32: error: expected ';' after top level declarator
include/linux/init.h:149:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__ro_after_init'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- arm64-defconfig
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- parisc-allyesconfig
|   |-- arch-parisc-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
|   |-- arch-parisc-include-asm-cache.h:warning:__read_mostly-redefined
|   |-- include-linux-cache.h:error:L1_CACHE_SHIFT-undeclared-here-(not-in-a-function)
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- parisc-defconfig
|   |-- arch-parisc-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
|   |-- arch-parisc-include-asm-cache.h:warning:__read_mostly-redefined
|   |-- include-linux-cache.h:error:L1_CACHE_SHIFT-undeclared-here-(not-in-a-function)
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- parisc-randconfig-r006-20230726
|   |-- arch-parisc-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
|   |-- arch-parisc-include-asm-cache.h:warning:__read_mostly-redefined
|   |-- include-linux-cache.h:error:L1_CACHE_SHIFT-undeclared-here-(not-in-a-function)
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- parisc-randconfig-r011-20230726
|   |-- arch-parisc-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
|   |-- arch-parisc-include-asm-cache.h:warning:__read_mostly-redefined
|   |-- include-linux-cache.h:error:L1_CACHE_SHIFT-undeclared-here-(not-in-a-function)
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
|-- parisc64-defconfig
|   |-- arch-parisc-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
|   |-- arch-parisc-include-asm-cache.h:warning:__read_mostly-redefined
|   |-- include-linux-cache.h:error:L1_CACHE_SHIFT-undeclared-here-(not-in-a-function)
|   `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
`-- sh-allmodconfig
    |-- arch-sh-include-asm-cache.h:warning:ARCH_DMA_MINALIGN-redefined
    |-- arch-sh-include-asm-cache.h:warning:__read_mostly-redefined
    `-- include-linux-init.h:error:expected-asm-or-__attribute__-before-__ro_after_init
clang_recent_errors
`-- arm64-randconfig-r012-20230726
    `-- include-linux-init.h:error:expected-after-top-level-declarator

elapsed time: 725m

configs tested: 122
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230726   gcc  
alpha                randconfig-r013-20230726   gcc  
alpha                randconfig-r031-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230726   gcc  
arc                  randconfig-r043-20230726   gcc  
arc                  randconfig-r043-20230727   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230726   clang
arm                  randconfig-r004-20230726   clang
arm                  randconfig-r021-20230726   gcc  
arm                  randconfig-r032-20230726   clang
arm                  randconfig-r046-20230726   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230726   clang
csky                                defconfig   gcc  
hexagon              randconfig-r036-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i016-20230726   clang
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-r015-20230726   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230726   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230726   gcc  
microblaze           randconfig-r026-20230726   gcc  
microblaze           randconfig-r034-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230726   gcc  
mips                 randconfig-r035-20230726   clang
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230726   gcc  
parisc               randconfig-r006-20230726   gcc  
parisc               randconfig-r011-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r013-20230726   clang
powerpc              randconfig-r025-20230726   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230726   clang
riscv                randconfig-r042-20230726   clang
riscv                randconfig-r042-20230727   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230726   clang
s390                 randconfig-r044-20230727   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230726   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230726   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230726   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230726   gcc  
xtensa               randconfig-r015-20230726   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
