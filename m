Return-Path: <linux-kernel+bounces-10761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1B81DB69
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E203C1C20ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763128824;
	Sun, 24 Dec 2023 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keBXuevC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDA746B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703435910; x=1734971910;
  h=date:from:to:cc:subject:message-id;
  bh=BQ1bvdoZZ5E+5p0j8NZPA8gXkxG3r2ZSFoxxh9Oy8Ok=;
  b=keBXuevC0WQwahb3ArF/29+TC3t9mK9g6v+X7UyyzGr3HWiNBZ0i6RGx
   JAHnQjzA32MtOuTinksPCu3u4aS4rYIGC8jUDpUbH68DO3fLlfyhYN8eu
   D+IIsvqbbTVhAu/8xtR99FzDb4Vkax16me0UvYeGF7tARuBufCPxtSCv2
   pSbq2BYCv0MCOkEPemvP0wrtjyzb2Mo3aTZkQkpGzI+27rTyfInLaEakL
   0cxtzJEpUYlkC9C3+cbUFhIfaxCqD/g2wJ5SDwpv5zsulIWHSaxzTBv9D
   P4znUUbnjbmWkKVai5AZep1sgIocrnMLGFovLu+o7hDEMbaUcVjFblNQA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3508396"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="3508396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 08:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="843492463"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="843492463"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Dec 2023 08:38:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHRTr-000CQ1-0t;
	Sun, 24 Dec 2023 16:37:56 +0000
Date: Mon, 25 Dec 2023 00:36:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 fbb66ce0b1d670c72def736a13ac9176b860df4e
Message-ID: <202312250050.xmuTCoyt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: fbb66ce0b1d670c72def736a13ac9176b860df4e  sched/fair: Remove unused 'next_buddy_marked' local variable in check_preempt_wakeup_fair()

elapsed time: 1454m

configs tested: 156
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231224   gcc  
arc                   randconfig-002-20231224   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231224   gcc  
arm                   randconfig-002-20231224   gcc  
arm                   randconfig-003-20231224   gcc  
arm                   randconfig-004-20231224   gcc  
arm                        shmobile_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231224   gcc  
arm64                 randconfig-002-20231224   gcc  
arm64                 randconfig-003-20231224   gcc  
arm64                 randconfig-004-20231224   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231224   gcc  
csky                  randconfig-002-20231224   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231224   clang
i386                  randconfig-012-20231224   clang
i386                  randconfig-013-20231224   clang
i386                  randconfig-014-20231224   clang
i386                  randconfig-015-20231224   clang
i386                  randconfig-016-20231224   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231224   gcc  
loongarch             randconfig-002-20231224   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231224   gcc  
nios2                 randconfig-002-20231224   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231224   gcc  
parisc                randconfig-002-20231224   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc               randconfig-001-20231224   gcc  
powerpc               randconfig-002-20231224   gcc  
powerpc               randconfig-003-20231224   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231224   gcc  
powerpc64             randconfig-002-20231224   gcc  
powerpc64             randconfig-003-20231224   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231224   gcc  
riscv                 randconfig-002-20231224   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231224   gcc  
sh                    randconfig-002-20231224   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231224   gcc  
sparc64               randconfig-002-20231224   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231224   gcc  
um                    randconfig-002-20231224   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231224   gcc  
x86_64       buildonly-randconfig-002-20231224   gcc  
x86_64       buildonly-randconfig-003-20231224   gcc  
x86_64       buildonly-randconfig-004-20231224   gcc  
x86_64       buildonly-randconfig-005-20231224   gcc  
x86_64       buildonly-randconfig-006-20231224   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231224   gcc  
x86_64                randconfig-012-20231224   gcc  
x86_64                randconfig-013-20231224   gcc  
x86_64                randconfig-014-20231224   gcc  
x86_64                randconfig-015-20231224   gcc  
x86_64                randconfig-016-20231224   gcc  
x86_64                randconfig-071-20231224   gcc  
x86_64                randconfig-072-20231224   gcc  
x86_64                randconfig-073-20231224   gcc  
x86_64                randconfig-074-20231224   gcc  
x86_64                randconfig-075-20231224   gcc  
x86_64                randconfig-076-20231224   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20231224   gcc  
xtensa                randconfig-002-20231224   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

