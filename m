Return-Path: <linux-kernel+bounces-23386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A982AC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20821F23B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F2F14290;
	Thu, 11 Jan 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbAX9g+T"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE012E55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704969153; x=1736505153;
  h=date:from:to:cc:subject:message-id;
  bh=j7jzoFPLVZ8f2T+bZRix72hALqdI2dcSPKlJBXKi+1Q=;
  b=lbAX9g+Tq0Aib5RH+ZT6mLW6Z8Al9SVf2d2SeM9M9vElqTSVZM0wKTgL
   ZKzua0i5y8PYzcDRWPeDBCXW2byK22P/GjBQAbyMSlztrAZB0NMhjreI5
   Zt8KSv/5ZAQ4wc4BfCvkmb4SIBYxBGV46NF2rw//ydorNpof1iEIzKvai
   E2kYMAzB9Wpp77AdhlQS+58JmF1oC8CaIvuXt0Kxu9Z+4y8OxIoANtG+G
   jEHWrMC84hxE/0X1P50vIic3HpR1+SinyDSBYPwIUBosdoApZ9XB/d0ci
   8ofWkMwgjClmABMcqJ3V+rx/Bf+IpuGM9gKWLEOT/PlzHWqvX1pHOET0m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402577670"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="402577670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="872980109"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="872980109"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2024 02:32:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNsMO-00088m-2d;
	Thu, 11 Jan 2024 10:32:28 +0000
Date: Thu, 11 Jan 2024 18:32:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 0911b8c52c4d68c57d02f172daa55a42bce703f0
Message-ID: <202401111815.aoYqzZDz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 0911b8c52c4d68c57d02f172daa55a42bce703f0  x86/bugs: Rename CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK

elapsed time: 1460m

configs tested: 178
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
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240111   gcc  
arc                   randconfig-002-20240111   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240111   gcc  
arm                   randconfig-002-20240111   gcc  
arm                   randconfig-003-20240111   gcc  
arm                   randconfig-004-20240111   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240111   gcc  
arm64                 randconfig-002-20240111   gcc  
arm64                 randconfig-003-20240111   gcc  
arm64                 randconfig-004-20240111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240111   gcc  
csky                  randconfig-002-20240111   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20240111   clang
i386                  randconfig-012-20240111   clang
i386                  randconfig-013-20240111   clang
i386                  randconfig-014-20240111   clang
i386                  randconfig-015-20240111   clang
i386                  randconfig-016-20240111   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240111   gcc  
loongarch             randconfig-002-20240111   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240111   gcc  
nios2                 randconfig-002-20240111   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240111   gcc  
parisc                randconfig-002-20240111   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240111   gcc  
powerpc               randconfig-002-20240111   gcc  
powerpc               randconfig-003-20240111   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20240111   gcc  
powerpc64             randconfig-002-20240111   gcc  
powerpc64             randconfig-003-20240111   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20240111   gcc  
riscv                 randconfig-002-20240111   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240111   gcc  
sh                    randconfig-002-20240111   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240111   gcc  
sparc64               randconfig-002-20240111   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240111   gcc  
um                    randconfig-002-20240111   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240111   gcc  
x86_64       buildonly-randconfig-002-20240111   gcc  
x86_64       buildonly-randconfig-003-20240111   gcc  
x86_64       buildonly-randconfig-004-20240111   gcc  
x86_64       buildonly-randconfig-005-20240111   gcc  
x86_64       buildonly-randconfig-006-20240111   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240111   gcc  
x86_64                randconfig-012-20240111   gcc  
x86_64                randconfig-013-20240111   gcc  
x86_64                randconfig-014-20240111   gcc  
x86_64                randconfig-015-20240111   gcc  
x86_64                randconfig-016-20240111   gcc  
x86_64                randconfig-071-20240111   gcc  
x86_64                randconfig-072-20240111   gcc  
x86_64                randconfig-073-20240111   gcc  
x86_64                randconfig-074-20240111   gcc  
x86_64                randconfig-075-20240111   gcc  
x86_64                randconfig-076-20240111   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240111   gcc  
xtensa                randconfig-002-20240111   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

