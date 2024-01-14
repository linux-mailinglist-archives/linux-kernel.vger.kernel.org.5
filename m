Return-Path: <linux-kernel+bounces-25409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCC82CFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98AE1C20D95
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FCA1852;
	Sun, 14 Jan 2024 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak/9ArGA"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F01841
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705211703; x=1736747703;
  h=date:from:to:cc:subject:message-id;
  bh=aLS1ObstBnTEFPUSV9Nx2G1jdYOBmLlfpp943B5ZQWg=;
  b=ak/9ArGABmCkOdePo8cFNEokzn9WxvRQvx+OLnBr0Gd6xYLf8yq8QFdu
   pKRV0ebKTardf7LQqPDcLQWmpSY0pD4pbGS52xxIleBwSEX9Mw4hPIntS
   Ckjw+xstBI9Kl3JBJsLWc+o2L1MRUtAvsR/TAkwIlNbR6oYApR+lShvqQ
   Xmk3+t3sD/50KI6mBCta46kGgNzVDOMqB9EzbxyelvcE7Aw5KFUskhmmV
   cSiy4LeNVohVHly9DGEEXRwzYMkPXYdTCmTMCnHirNM7rpmbMdzicCyqn
   rXKc2hFx5s5KQGUg2Usv8ju1sjRyrg1Dt9zBJz0So/KycvbuS+h9y/KSv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="403201290"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="403201290"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 21:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="25139569"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 13 Jan 2024 21:55:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOtSL-000BDo-2y;
	Sun, 14 Jan 2024 05:54:55 +0000
Date: Sun, 14 Jan 2024 13:54:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bd009225e8cbb6e18ad3389328fa640e4887dd9e
Message-ID: <202401141307.hFiSfpOa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bd009225e8cbb6e18ad3389328fa640e4887dd9e  Merge branch into tip/master: 'x86/tdx'

elapsed time: 2645m

configs tested: 116
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240114   gcc  
arc                   randconfig-002-20240114   gcc  
arm                               allnoconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20240114   clang
arm                   randconfig-002-20240114   clang
arm                   randconfig-003-20240114   clang
arm                   randconfig-004-20240114   clang
arm                        spear6xx_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240114   clang
arm64                 randconfig-002-20240114   clang
arm64                 randconfig-003-20240114   clang
arm64                 randconfig-004-20240114   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240114   gcc  
csky                  randconfig-002-20240114   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240114   clang
hexagon               randconfig-002-20240114   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240113   gcc  
i386         buildonly-randconfig-002-20240113   gcc  
i386         buildonly-randconfig-003-20240113   gcc  
i386         buildonly-randconfig-004-20240113   gcc  
i386         buildonly-randconfig-005-20240113   gcc  
i386         buildonly-randconfig-006-20240113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240113   gcc  
i386                  randconfig-002-20240113   gcc  
i386                  randconfig-003-20240113   gcc  
i386                  randconfig-004-20240113   gcc  
i386                  randconfig-005-20240113   gcc  
i386                  randconfig-006-20240113   gcc  
i386                  randconfig-011-20240113   clang
i386                  randconfig-012-20240113   clang
i386                  randconfig-013-20240113   clang
i386                  randconfig-014-20240113   clang
i386                  randconfig-015-20240113   clang
i386                  randconfig-016-20240113   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240114   gcc  
loongarch             randconfig-002-20240114   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240114   gcc  
nios2                 randconfig-002-20240114   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240114   gcc  
parisc                randconfig-002-20240114   gcc  
powerpc                          allmodconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240114   clang
powerpc               randconfig-002-20240114   clang
powerpc               randconfig-003-20240114   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20240114   clang
powerpc64             randconfig-002-20240114   clang
powerpc64             randconfig-003-20240114   clang
riscv                 randconfig-001-20240114   clang
riscv                 randconfig-002-20240114   clang
s390                  randconfig-001-20240114   gcc  
s390                  randconfig-002-20240114   gcc  
sh                               alldefconfig   gcc  
sh                               allyesconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240114   gcc  
sh                    randconfig-002-20240114   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc64               randconfig-001-20240114   gcc  
sparc64               randconfig-002-20240114   gcc  
um                    randconfig-001-20240114   clang
um                    randconfig-002-20240114   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240114   gcc  
xtensa                randconfig-002-20240114   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

