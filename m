Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D579D940
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjILS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:58:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90800125
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694545122; x=1726081122;
  h=date:from:to:cc:subject:message-id;
  bh=ff9qCEtHw5JvFX9S+E7ICRm7hRFkhz8JSohTpuVz21g=;
  b=bTsWQ2H+pprXur5Z+Sm6lHlNf3DMof64JR3m7FOEtp5E781ft0r+VtCd
   fO7+6f6k45BrVn+Dl5gKkWDtU32MEWZUjqOnfCeK9xFldsJxgmmy4FcSf
   uh/Pl0TjXxmZ8STH6mLMb0+9aT6MqTgBm4xGLk1mbaOQR2aQr7hw8OB7B
   al2Vu7rJFs8WZ5DV8xTZZxybsfrtzoFf7d3WCdGhUKq+jRu1xJCmqxKzH
   /IBbomJBa4RKrBpNwD/nih3jZQ2qUJMT5PcWcT/M9iQ1DJ3siK+lRX/qo
   9Y9v964QeZcyyEh5QnjWlmehK6qBfTlZGlVa2M63EN0PoX3i5vd/X/zlO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357896492"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="357896492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917537523"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="917537523"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Sep 2023 11:57:15 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg8ZU-00009N-1y;
        Tue, 12 Sep 2023 18:57:12 +0000
Date:   Wed, 13 Sep 2023 02:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 72178d5d1a38dd185d1db15f177f2d122ef10d9b
Message-ID: <202309130228.GSFrPf28-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 72178d5d1a38dd185d1db15f177f2d122ef10d9b  objtool: Fix _THIS_IP_ detection for cold functions

elapsed time: 757m

configs tested: 253
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230912   gcc  
alpha                randconfig-r014-20230913   gcc  
alpha                randconfig-r022-20230912   gcc  
alpha                randconfig-r025-20230912   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20230912   gcc  
arc                  randconfig-r015-20230912   gcc  
arc                  randconfig-r021-20230912   gcc  
arc                  randconfig-r022-20230912   gcc  
arc                  randconfig-r036-20230912   gcc  
arc                        vdk_hs38_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20230912   clang
arm                  randconfig-r005-20230912   gcc  
arm                  randconfig-r011-20230912   clang
arm                  randconfig-r035-20230912   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230912   clang
arm64                randconfig-r016-20230912   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230912   gcc  
csky                 randconfig-r025-20230912   gcc  
hexagon               randconfig-001-20230912   clang
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230912   clang
hexagon               randconfig-002-20230913   clang
hexagon              randconfig-r002-20230912   clang
hexagon              randconfig-r005-20230913   clang
hexagon              randconfig-r022-20230912   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230912   clang
i386         buildonly-randconfig-001-20230913   gcc  
i386         buildonly-randconfig-002-20230912   clang
i386         buildonly-randconfig-002-20230913   gcc  
i386         buildonly-randconfig-003-20230912   clang
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-004-20230912   clang
i386         buildonly-randconfig-004-20230913   gcc  
i386         buildonly-randconfig-005-20230912   clang
i386         buildonly-randconfig-005-20230913   gcc  
i386         buildonly-randconfig-006-20230912   clang
i386         buildonly-randconfig-006-20230913   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230912   clang
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-002-20230912   clang
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-003-20230912   clang
i386                  randconfig-003-20230913   gcc  
i386                  randconfig-004-20230912   clang
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-005-20230912   clang
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-006-20230912   clang
i386                  randconfig-006-20230913   gcc  
i386                  randconfig-011-20230912   gcc  
i386                  randconfig-012-20230912   gcc  
i386                  randconfig-013-20230912   gcc  
i386                  randconfig-014-20230912   gcc  
i386                  randconfig-015-20230912   gcc  
i386                  randconfig-016-20230912   gcc  
i386                 randconfig-r015-20230912   gcc  
i386                 randconfig-r021-20230912   gcc  
i386                 randconfig-r032-20230912   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230912   gcc  
loongarch             randconfig-001-20230913   gcc  
loongarch            randconfig-r011-20230912   gcc  
loongarch            randconfig-r014-20230912   gcc  
loongarch            randconfig-r031-20230912   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230912   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r011-20230912   gcc  
microblaze           randconfig-r013-20230912   gcc  
microblaze           randconfig-r015-20230913   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r006-20230913   clang
mips                 randconfig-r014-20230912   clang
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230912   gcc  
nios2                randconfig-r022-20230912   gcc  
nios2                randconfig-r023-20230912   gcc  
nios2                randconfig-r026-20230912   gcc  
nios2                randconfig-r033-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r013-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230912   gcc  
parisc               randconfig-r013-20230912   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc              randconfig-r013-20230912   gcc  
powerpc              randconfig-r015-20230912   gcc  
powerpc              randconfig-r026-20230912   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64            randconfig-r012-20230912   gcc  
powerpc64            randconfig-r016-20230912   gcc  
powerpc64            randconfig-r035-20230912   clang
powerpc64            randconfig-r036-20230912   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20230912   clang
riscv                randconfig-r011-20230912   gcc  
riscv                randconfig-r014-20230912   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230912   gcc  
s390                  randconfig-001-20230913   clang
s390                 randconfig-r011-20230912   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r016-20230912   gcc  
sh                   randconfig-r034-20230912   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230912   gcc  
sparc                randconfig-r023-20230912   gcc  
sparc                randconfig-r026-20230912   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230912   gcc  
sparc64              randconfig-r014-20230912   gcc  
sparc64              randconfig-r015-20230912   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230912   gcc  
um                   randconfig-r015-20230912   clang
um                   randconfig-r023-20230912   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230912   clang
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-002-20230912   clang
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-003-20230912   clang
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-004-20230912   clang
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-005-20230912   clang
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-006-20230912   clang
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230912   gcc  
x86_64                randconfig-002-20230912   gcc  
x86_64                randconfig-003-20230912   gcc  
x86_64                randconfig-004-20230912   gcc  
x86_64                randconfig-005-20230912   gcc  
x86_64                randconfig-006-20230912   gcc  
x86_64                randconfig-011-20230912   clang
x86_64                randconfig-012-20230912   clang
x86_64                randconfig-013-20230912   clang
x86_64                randconfig-014-20230912   clang
x86_64                randconfig-015-20230912   clang
x86_64                randconfig-016-20230912   clang
x86_64                randconfig-071-20230912   clang
x86_64                randconfig-072-20230912   clang
x86_64                randconfig-073-20230912   clang
x86_64                randconfig-074-20230912   clang
x86_64                randconfig-075-20230912   clang
x86_64                randconfig-076-20230912   clang
x86_64               randconfig-r031-20230912   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r016-20230913   gcc  
xtensa               randconfig-r024-20230912   gcc  
xtensa               randconfig-r032-20230912   gcc  
xtensa               randconfig-r034-20230913   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
