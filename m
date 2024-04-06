Return-Path: <linux-kernel+bounces-134101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED689AD9F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E6E1F217DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714257887;
	Sat,  6 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vpiy7FtX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AC535D1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712445116; cv=none; b=aXTxOkSUgb07S2cJLVPc5AYPtqIalVu8NUOMR8w/tRbFw59KxgS+bAVwL+ieyQ8x+oHnASNcI3kQudYabvx5zcGuuxp1p3lvNcPLvLUG2t+CYxmozr8Q36pLxJMPRyzCM+Mfzx5Ptaz394ZqeBDYU1JArPmZCnverxVaCH06xJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712445116; c=relaxed/simple;
	bh=3IvB0G836iHfUvGEJHfdKug7mWF8EeO12PXYFxfIZ7g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aH5q6mVp8lbCdl1qVTcR0QYakPilg1Qd6ZqQpOnG2MH7HefT3a1LDZFKzvkcycclYLBohjqzr/xuEFjI47Aej4P4jW5KNYpbuiv2cN5A+kAje8RrT6QQdtrEfJPb5dcGGXa6wMlkuKb3Imf1Ceg43Z+9t7vAiJ+ybGIKFBagnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vpiy7FtX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712445114; x=1743981114;
  h=date:from:to:cc:subject:message-id;
  bh=3IvB0G836iHfUvGEJHfdKug7mWF8EeO12PXYFxfIZ7g=;
  b=Vpiy7FtXaXd4RC7FblSJDUqL46N8dmp08HTPA/CqMHfCoo650HRbi8QY
   p59WGmH1dP2Rom0MM55BQqfWWz+EM4IgUdllid6Tm3y0GPyOo1zPADdTo
   MK/Cpx44ExzqJM/Tg6JM1UNoCuhEvxgMgQ3aISNfHid4r2/Rgf2YbAj7c
   JE8t5WkoiVTaOG8BgiSBetqmwV7zBH3zEjZFqqR95ALpeTM6LZXCm3MGR
   BnoWxOlnxIGBE646Fm8IoTZp9zKN+Oz/5wy/dzo13o8VL9kPE63EF/zk/
   rzB/F0bEBi4hON57ro1tSW1h/gM8DMcC3YGOCYOwvnOKkYlWt0ByWNtx/
   A==;
X-CSE-ConnectionGUID: 99SryqjcR+ODMJ5Ewe5c8A==
X-CSE-MsgGUID: S/+JlvQyQn+nJlAgbkgZXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18886048"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18886048"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 16:11:53 -0700
X-CSE-ConnectionGUID: ao5W46xSRpm0kd7vUiVUAg==
X-CSE-MsgGUID: WJkB4pYxT2aKgP0qTMbdQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19621861"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Apr 2024 16:11:52 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtFCQ-0003wy-0K;
	Sat, 06 Apr 2024 23:11:50 +0000
Date: Sun, 07 Apr 2024 07:11:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f6f609de2b987bfce0dd3283f7bfbff1aa692c7a
Message-ID: <202404070710.0kvHzp51-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f6f609de2b987bfce0dd3283f7bfbff1aa692c7a  Merge branch into tip/master: 'x86/shstk'

elapsed time: 723m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240407   gcc  
arc                   randconfig-002-20240407   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240407   gcc  
arm                   randconfig-002-20240407   clang
arm                   randconfig-003-20240407   gcc  
arm                   randconfig-004-20240407   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240407   gcc  
arm64                 randconfig-002-20240407   clang
arm64                 randconfig-003-20240407   gcc  
arm64                 randconfig-004-20240407   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240407   gcc  
csky                  randconfig-002-20240407   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240407   clang
hexagon               randconfig-002-20240407   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240406   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240406   gcc  
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240406   gcc  
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240406   gcc  
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240406   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240407   gcc  
loongarch             randconfig-002-20240407   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240407   gcc  
nios2                 randconfig-002-20240407   gcc  
openrisc                         alldefconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240407   gcc  
parisc                randconfig-002-20240407   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-001-20240407   clang
powerpc               randconfig-002-20240407   clang
powerpc               randconfig-003-20240407   gcc  
powerpc64             randconfig-001-20240407   clang
powerpc64             randconfig-002-20240407   clang
powerpc64             randconfig-003-20240407   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240407   clang
riscv                 randconfig-002-20240407   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240407   gcc  
s390                  randconfig-002-20240407   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240407   gcc  
sh                    randconfig-002-20240407   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240407   gcc  
sparc64               randconfig-002-20240407   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240407   gcc  
um                    randconfig-002-20240407   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240406   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-003-20240406   clang
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64       buildonly-randconfig-006-20240406   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-002-20240406   clang
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-004-20240406   clang
x86_64                randconfig-005-20240406   clang
x86_64                randconfig-006-20240406   clang
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-012-20240406   clang
x86_64                randconfig-013-20240406   clang
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-016-20240406   clang
x86_64                randconfig-071-20240406   clang
x86_64                randconfig-072-20240406   clang
x86_64                randconfig-073-20240406   clang
x86_64                randconfig-074-20240406   clang
x86_64                randconfig-075-20240406   clang
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240407   gcc  
xtensa                randconfig-002-20240407   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

