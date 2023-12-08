Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672980978C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444167AbjLHApv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:45:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB3FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701996354; x=1733532354;
  h=date:from:to:cc:subject:message-id;
  bh=zUoRVBinADnl3aVu0A/92Pwwq9dkYsoilEaLNHbBVpg=;
  b=BOH90b+IrLkgC8rXYjl3F5SAuJ7iAdjP7Cb9IfLFcolWh3hsBcJMHHET
   uZWNdfBnhHwutuIVoo7iRgjd3OUxFqjhfTy4eBDBd8MV0xVxg0jnp7fCV
   Vn+TbqJstTV7EhvTa+rRW0k9RddgjyeGa2W4VmD2i/1PSoZUjuz9dCcvn
   Xqnx59aUIQjb5EIvZ9OF3Gf+ztLZ1k8tK4I4nQKtAuRlgYnF+pRUGl5B4
   iiYmduwdOq5HpmU9qD5qkCHXqqYSY//+iMmyh0FIAFyA08N8qMcXI06oV
   q+iiPB2fqxs1nmnyHo9IH9vRzmN4ilXkDsHkDbzuKdEwvRiyC7KHmBFxL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1197040"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1197040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="765301217"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="765301217"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2023 16:45:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBP02-000D2L-1P;
        Fri, 08 Dec 2023 00:45:50 +0000
Date:   Fri, 08 Dec 2023 08:45:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e50e0836738d831b8bada1ae7963e916b8ff6821
Message-ID: <202312080803.pDfinul8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e50e0836738d831b8bada1ae7963e916b8ff6821  Merge tag 'rcu-next-v6.8' of ../neeraj-linux into HEAD

elapsed time: 1468m

configs tested: 226
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-001-20231208   gcc  
arc                   randconfig-002-20231207   gcc  
arc                   randconfig-002-20231208   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-001-20231208   gcc  
csky                  randconfig-002-20231207   gcc  
csky                  randconfig-002-20231208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231207   gcc  
i386         buildonly-randconfig-002-20231207   gcc  
i386         buildonly-randconfig-003-20231207   gcc  
i386         buildonly-randconfig-004-20231207   gcc  
i386         buildonly-randconfig-005-20231207   gcc  
i386         buildonly-randconfig-006-20231207   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231207   gcc  
i386                  randconfig-002-20231207   gcc  
i386                  randconfig-003-20231207   gcc  
i386                  randconfig-004-20231207   gcc  
i386                  randconfig-005-20231207   gcc  
i386                  randconfig-006-20231207   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231207   clang
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231207   clang
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231207   clang
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231207   clang
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231207   clang
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-001-20231208   gcc  
loongarch             randconfig-002-20231207   gcc  
loongarch             randconfig-002-20231208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-001-20231208   gcc  
nios2                 randconfig-002-20231207   gcc  
nios2                 randconfig-002-20231208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-001-20231208   gcc  
parisc                randconfig-002-20231207   gcc  
parisc                randconfig-002-20231208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231208   gcc  
s390                  randconfig-002-20231208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-001-20231208   gcc  
sh                    randconfig-002-20231207   gcc  
sh                    randconfig-002-20231208   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-001-20231208   gcc  
sparc64               randconfig-002-20231207   gcc  
sparc64               randconfig-002-20231208   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-001-20231208   clang
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-002-20231208   clang
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-003-20231208   clang
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-004-20231208   clang
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-005-20231208   clang
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64       buildonly-randconfig-006-20231208   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-011-20231208   clang
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-012-20231208   clang
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-013-20231208   clang
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-014-20231208   clang
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-015-20231208   clang
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-016-20231208   clang
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-071-20231208   clang
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-072-20231208   clang
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-073-20231208   clang
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-074-20231208   clang
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-075-20231208   clang
x86_64                randconfig-076-20231207   gcc  
x86_64                randconfig-076-20231208   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-001-20231208   gcc  
xtensa                randconfig-002-20231207   gcc  
xtensa                randconfig-002-20231208   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
