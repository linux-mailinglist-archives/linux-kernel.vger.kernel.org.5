Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A97FFE62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377136AbjK3WTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjK3WTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:19:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617410DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701382758; x=1732918758;
  h=date:from:to:cc:subject:message-id;
  bh=K5orLlLAOzro8w6ZotRLhbBcMEizXly4dDcrcWEEZgM=;
  b=c9ygPR0z4iRlKMx3mZc1zyK8XB3f0h8baVNtCSizm/rDNAcGDoxDUo65
   MNApwc5+G+BoClfHtqlKmRFcuz12lIYvathRBc+Oc82n6VT+cS6Czxo9h
   hltbI5V+TEnJqzL2ZcSGB9q6jYzlfEfGSm/DJ+0iXaOsF6jRZh05k5A8H
   V2PiR4Jb0q5Eui8Qi+zBREJsNSHXBeRNqAxhqXhzBmlWouPW98++mDGlz
   PW3zrqj5J3YgJnvgx1UWccpKc3mX2Ehb6U1lA3Oj15+v3AuK6DlQ/6JbD
   gOLYlyMJojddzaeyTS5sEsSnJmIsAVtWPZ0SPWCiabYytswDxGrlfu0sV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="457722958"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="457722958"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 14:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="839947073"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="839947073"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2023 14:19:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8pNI-0002hX-2n;
        Thu, 30 Nov 2023 22:19:13 +0000
Date:   Fri, 01 Dec 2023 06:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 27d25348d42161837be08fc63b04a2559d2e781c
Message-ID: <202312010639.cKfJmMvH-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 27d25348d42161837be08fc63b04a2559d2e781c  x86/sev: Fix kernel crash due to late update to read-only ghcb_version

elapsed time: 744m

configs tested: 200
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231130   gcc  
arc                   randconfig-001-20231201   gcc  
arc                   randconfig-002-20231130   gcc  
arc                   randconfig-002-20231201   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                   randconfig-001-20231130   gcc  
arm                   randconfig-001-20231201   gcc  
arm                   randconfig-002-20231130   gcc  
arm                   randconfig-002-20231201   gcc  
arm                   randconfig-003-20231130   gcc  
arm                   randconfig-003-20231201   gcc  
arm                   randconfig-004-20231130   gcc  
arm                   randconfig-004-20231201   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231130   gcc  
arm64                 randconfig-001-20231201   gcc  
arm64                 randconfig-002-20231130   gcc  
arm64                 randconfig-002-20231201   gcc  
arm64                 randconfig-003-20231130   gcc  
arm64                 randconfig-003-20231201   gcc  
arm64                 randconfig-004-20231130   gcc  
arm64                 randconfig-004-20231201   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231130   gcc  
csky                  randconfig-001-20231201   gcc  
csky                  randconfig-002-20231130   gcc  
csky                  randconfig-002-20231201   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231130   gcc  
i386         buildonly-randconfig-002-20231130   gcc  
i386         buildonly-randconfig-003-20231130   gcc  
i386         buildonly-randconfig-004-20231130   gcc  
i386         buildonly-randconfig-005-20231130   gcc  
i386         buildonly-randconfig-006-20231130   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231130   gcc  
i386                  randconfig-002-20231130   gcc  
i386                  randconfig-003-20231130   gcc  
i386                  randconfig-004-20231130   gcc  
i386                  randconfig-005-20231130   gcc  
i386                  randconfig-006-20231130   gcc  
i386                  randconfig-011-20231130   clang
i386                  randconfig-012-20231130   clang
i386                  randconfig-013-20231130   clang
i386                  randconfig-014-20231130   clang
i386                  randconfig-015-20231130   clang
i386                  randconfig-016-20231130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231130   gcc  
loongarch             randconfig-001-20231201   gcc  
loongarch             randconfig-002-20231130   gcc  
loongarch             randconfig-002-20231201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231130   gcc  
nios2                 randconfig-001-20231201   gcc  
nios2                 randconfig-002-20231130   gcc  
nios2                 randconfig-002-20231201   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231130   gcc  
parisc                randconfig-001-20231201   gcc  
parisc                randconfig-002-20231130   gcc  
parisc                randconfig-002-20231201   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc               randconfig-001-20231130   gcc  
powerpc               randconfig-001-20231201   gcc  
powerpc               randconfig-002-20231130   gcc  
powerpc               randconfig-002-20231201   gcc  
powerpc               randconfig-003-20231130   gcc  
powerpc               randconfig-003-20231201   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64             randconfig-001-20231130   gcc  
powerpc64             randconfig-001-20231201   gcc  
powerpc64             randconfig-002-20231130   gcc  
powerpc64             randconfig-002-20231201   gcc  
powerpc64             randconfig-003-20231130   gcc  
powerpc64             randconfig-003-20231201   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231130   gcc  
riscv                 randconfig-001-20231201   gcc  
riscv                 randconfig-002-20231130   gcc  
riscv                 randconfig-002-20231201   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231130   gcc  
sh                    randconfig-001-20231201   gcc  
sh                    randconfig-002-20231130   gcc  
sh                    randconfig-002-20231201   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231130   gcc  
sparc64               randconfig-001-20231201   gcc  
sparc64               randconfig-002-20231130   gcc  
sparc64               randconfig-002-20231201   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231130   gcc  
um                    randconfig-001-20231201   gcc  
um                    randconfig-002-20231130   gcc  
um                    randconfig-002-20231201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231130   gcc  
x86_64       buildonly-randconfig-002-20231130   gcc  
x86_64       buildonly-randconfig-003-20231130   gcc  
x86_64       buildonly-randconfig-004-20231130   gcc  
x86_64       buildonly-randconfig-005-20231130   gcc  
x86_64       buildonly-randconfig-006-20231130   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231130   gcc  
x86_64                randconfig-012-20231130   gcc  
x86_64                randconfig-013-20231130   gcc  
x86_64                randconfig-014-20231130   gcc  
x86_64                randconfig-015-20231130   gcc  
x86_64                randconfig-016-20231130   gcc  
x86_64                randconfig-071-20231130   gcc  
x86_64                randconfig-072-20231130   gcc  
x86_64                randconfig-073-20231130   gcc  
x86_64                randconfig-074-20231130   gcc  
x86_64                randconfig-075-20231130   gcc  
x86_64                randconfig-076-20231130   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231130   gcc  
xtensa                randconfig-001-20231201   gcc  
xtensa                randconfig-002-20231130   gcc  
xtensa                randconfig-002-20231201   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
