Return-Path: <linux-kernel+bounces-10117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D536481D06C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB51F22ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5635EEB;
	Fri, 22 Dec 2023 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTRAkQ2i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B835EE2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703287394; x=1734823394;
  h=date:from:to:cc:subject:message-id;
  bh=6dA/pEMGyR0oXpkvmv6dQhMrqB6awVDP7KcSqNP7tnc=;
  b=gTRAkQ2iaAI7bToMUr1BUAkADyId+uu+YJ/9lu+jvUM1vM6KirCVb7Uc
   CGNPDuXHdKbhZ3QN0WkkdCHdCLxqAyjPug42uA26rfPBx4ZV6+XUT7kkb
   L4ivxSamRi1XlyfQ9bjmSEFJyRVHZmldYoptJD01V9IZgGQt9A0yXFv5r
   BDxXxvl65dPSvJx5SzTugtiTtpvt1ObXPW0DWclsG+Tnt35DJx2TeLvqM
   1aJ2sxOpYO4+IkvWWC1HB9LWPGfcLUR+DVYSpqrzEW1CB5oEd6d5ZJhG5
   +/w4qFZY2sRb3EBWY0JBlTK4Rqrvn0dZQsCS83Rz7RUZRisorsN/YATmd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="381145969"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="381145969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="847620413"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="847620413"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2023 15:23:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGor8-0009yd-26;
	Fri, 22 Dec 2023 23:23:05 +0000
Date: Sat, 23 Dec 2023 07:19:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS
 221a164035fd8b554a44bd7c4bf8e7715a497561
Message-ID: <202312230711.lU6lMPBK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
branch HEAD: 221a164035fd8b554a44bd7c4bf8e7715a497561  entry: Move syscall_enter_from_user_mode() to header file

elapsed time: 1501m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231222   gcc  
arc                   randconfig-001-20231223   gcc  
arc                   randconfig-002-20231222   gcc  
arc                   randconfig-002-20231223   gcc  
arm                               allnoconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231222   gcc  
arm                   randconfig-002-20231222   gcc  
arm                   randconfig-003-20231222   gcc  
arm                   randconfig-004-20231222   gcc  
arm                        spear6xx_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231222   gcc  
arm64                 randconfig-002-20231222   gcc  
arm64                 randconfig-003-20231222   gcc  
arm64                 randconfig-004-20231222   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231222   gcc  
csky                  randconfig-001-20231223   gcc  
csky                  randconfig-002-20231222   gcc  
csky                  randconfig-002-20231223   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20231222   clang
i386                  randconfig-011-20231223   gcc  
i386                  randconfig-012-20231222   clang
i386                  randconfig-012-20231223   gcc  
i386                  randconfig-013-20231222   clang
i386                  randconfig-013-20231223   gcc  
i386                  randconfig-014-20231222   clang
i386                  randconfig-014-20231223   gcc  
i386                  randconfig-015-20231222   clang
i386                  randconfig-015-20231223   gcc  
i386                  randconfig-016-20231222   clang
i386                  randconfig-016-20231223   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231222   gcc  
loongarch             randconfig-001-20231223   gcc  
loongarch             randconfig-002-20231222   gcc  
loongarch             randconfig-002-20231223   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231222   gcc  
nios2                 randconfig-001-20231223   gcc  
nios2                 randconfig-002-20231222   gcc  
nios2                 randconfig-002-20231223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231222   gcc  
parisc                randconfig-001-20231223   gcc  
parisc                randconfig-002-20231222   gcc  
parisc                randconfig-002-20231223   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231222   gcc  
powerpc               randconfig-002-20231222   gcc  
powerpc               randconfig-003-20231222   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231222   gcc  
powerpc64             randconfig-002-20231222   gcc  
powerpc64             randconfig-003-20231222   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231222   gcc  
riscv                 randconfig-002-20231222   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231223   gcc  
s390                  randconfig-002-20231223   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231222   gcc  
sh                    randconfig-001-20231223   gcc  
sh                    randconfig-002-20231222   gcc  
sh                    randconfig-002-20231223   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231222   gcc  
sparc64               randconfig-001-20231223   gcc  
sparc64               randconfig-002-20231222   gcc  
sparc64               randconfig-002-20231223   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231222   gcc  
um                    randconfig-002-20231222   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231222   gcc  
x86_64       buildonly-randconfig-002-20231222   gcc  
x86_64       buildonly-randconfig-003-20231222   gcc  
x86_64       buildonly-randconfig-004-20231222   gcc  
x86_64       buildonly-randconfig-005-20231222   gcc  
x86_64       buildonly-randconfig-006-20231222   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231222   gcc  
x86_64                randconfig-012-20231222   gcc  
x86_64                randconfig-013-20231222   gcc  
x86_64                randconfig-014-20231222   gcc  
x86_64                randconfig-015-20231222   gcc  
x86_64                randconfig-016-20231222   gcc  
x86_64                randconfig-071-20231222   gcc  
x86_64                randconfig-072-20231222   gcc  
x86_64                randconfig-073-20231222   gcc  
x86_64                randconfig-074-20231222   gcc  
x86_64                randconfig-075-20231222   gcc  
x86_64                randconfig-076-20231222   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20231222   gcc  
xtensa                randconfig-001-20231223   gcc  
xtensa                randconfig-002-20231222   gcc  
xtensa                randconfig-002-20231223   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

