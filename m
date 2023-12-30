Return-Path: <linux-kernel+bounces-13419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C919820638
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BB0281D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848A8BFB;
	Sat, 30 Dec 2023 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixcWtXED"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475798BE3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703940706; x=1735476706;
  h=date:from:to:cc:subject:message-id;
  bh=xFN968wrFircNz0rrsTqBTaBGP7s1HcN9QEgH6aqjuU=;
  b=ixcWtXEDdUhGKmF9aRmpzf1jeDXA5tFoU4FLFBIroGrgpiYZqz35Cqyj
   4+ac1fWwQ+JRkrPY9S2porpj54x77ldPzExxB0FpbElPZg5TN6DUutdUz
   iGmbqI80/OmLAOLFkQpDID13eyIxYuMtpmN7p94F5NfeEBNQ86bTolG41
   RtCbT3iAqP3TgDJspmiqD/RX/7QPbEThlT5f6L0wW3ZwUX5pV/V/heBPn
   anvHLYpuFE4+VVNA6UY8DHuSypAHxduw2zdEiMbQZ6lziS9M/8ABC8lfU
   /uzmxlot4PuFI6Duvysk4yIDyDelb63ed68GAJnR6Ie3Wo2HIy1pQfXUn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="10101412"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="10101412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 04:51:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="755252138"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="755252138"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Dec 2023 04:51:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJYoX-000IRH-2Y;
	Sat, 30 Dec 2023 12:51:41 +0000
Date: Sat, 30 Dec 2023 20:51:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 f60a631ab9ed5df15e446269ea515f2b8948ba0c
Message-ID: <202312302013.4X6s2TWI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: f60a631ab9ed5df15e446269ea515f2b8948ba0c  sched/fair: Fix tg->load when offlining a CPU

elapsed time: 1448m

configs tested: 247
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231229   gcc  
arc                   randconfig-001-20231230   gcc  
arc                   randconfig-002-20231229   gcc  
arc                   randconfig-002-20231230   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231229   clang
arm                   randconfig-002-20231229   clang
arm                   randconfig-003-20231229   clang
arm                   randconfig-004-20231229   clang
arm                        realview_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231229   clang
arm64                 randconfig-002-20231229   clang
arm64                 randconfig-003-20231229   clang
arm64                 randconfig-004-20231229   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231229   gcc  
csky                  randconfig-001-20231230   gcc  
csky                  randconfig-002-20231229   gcc  
csky                  randconfig-002-20231230   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231229   clang
hexagon               randconfig-002-20231229   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231229   clang
i386         buildonly-randconfig-002-20231229   clang
i386         buildonly-randconfig-003-20231229   clang
i386         buildonly-randconfig-004-20231229   clang
i386         buildonly-randconfig-005-20231229   clang
i386         buildonly-randconfig-006-20231229   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231229   clang
i386                  randconfig-002-20231229   clang
i386                  randconfig-003-20231229   clang
i386                  randconfig-004-20231229   clang
i386                  randconfig-005-20231229   clang
i386                  randconfig-006-20231229   clang
i386                  randconfig-011-20231229   gcc  
i386                  randconfig-011-20231230   gcc  
i386                  randconfig-012-20231229   gcc  
i386                  randconfig-012-20231230   gcc  
i386                  randconfig-013-20231229   gcc  
i386                  randconfig-013-20231230   gcc  
i386                  randconfig-014-20231229   gcc  
i386                  randconfig-014-20231230   gcc  
i386                  randconfig-015-20231229   gcc  
i386                  randconfig-015-20231230   gcc  
i386                  randconfig-016-20231229   gcc  
i386                  randconfig-016-20231230   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231229   gcc  
loongarch             randconfig-001-20231230   gcc  
loongarch             randconfig-002-20231229   gcc  
loongarch             randconfig-002-20231230   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1c_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231229   gcc  
nios2                 randconfig-001-20231230   gcc  
nios2                 randconfig-002-20231229   gcc  
nios2                 randconfig-002-20231230   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231229   gcc  
parisc                randconfig-001-20231230   gcc  
parisc                randconfig-002-20231229   gcc  
parisc                randconfig-002-20231230   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20231229   clang
powerpc               randconfig-002-20231229   clang
powerpc               randconfig-003-20231229   clang
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20231229   clang
powerpc64             randconfig-002-20231229   clang
powerpc64             randconfig-003-20231229   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231229   clang
riscv                 randconfig-002-20231229   clang
riscv                          rv32_defconfig   clang
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231229   gcc  
s390                  randconfig-001-20231230   gcc  
s390                  randconfig-002-20231229   gcc  
s390                  randconfig-002-20231230   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231229   gcc  
sh                    randconfig-001-20231230   gcc  
sh                    randconfig-002-20231229   gcc  
sh                    randconfig-002-20231230   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231229   gcc  
sparc64               randconfig-001-20231230   gcc  
sparc64               randconfig-002-20231229   gcc  
sparc64               randconfig-002-20231230   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231229   clang
um                    randconfig-002-20231229   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231229   clang
x86_64       buildonly-randconfig-001-20231230   clang
x86_64       buildonly-randconfig-002-20231229   clang
x86_64       buildonly-randconfig-002-20231230   clang
x86_64       buildonly-randconfig-003-20231229   clang
x86_64       buildonly-randconfig-003-20231230   clang
x86_64       buildonly-randconfig-004-20231229   clang
x86_64       buildonly-randconfig-004-20231230   clang
x86_64       buildonly-randconfig-005-20231229   clang
x86_64       buildonly-randconfig-005-20231230   clang
x86_64       buildonly-randconfig-006-20231229   clang
x86_64       buildonly-randconfig-006-20231230   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231229   gcc  
x86_64                randconfig-002-20231229   gcc  
x86_64                randconfig-003-20231229   gcc  
x86_64                randconfig-004-20231229   gcc  
x86_64                randconfig-005-20231229   gcc  
x86_64                randconfig-006-20231229   gcc  
x86_64                randconfig-011-20231229   clang
x86_64                randconfig-011-20231230   clang
x86_64                randconfig-012-20231229   clang
x86_64                randconfig-012-20231230   clang
x86_64                randconfig-013-20231229   clang
x86_64                randconfig-013-20231230   clang
x86_64                randconfig-014-20231229   clang
x86_64                randconfig-014-20231230   clang
x86_64                randconfig-015-20231229   clang
x86_64                randconfig-015-20231230   clang
x86_64                randconfig-016-20231229   clang
x86_64                randconfig-016-20231230   clang
x86_64                randconfig-071-20231229   clang
x86_64                randconfig-071-20231230   clang
x86_64                randconfig-072-20231229   clang
x86_64                randconfig-072-20231230   clang
x86_64                randconfig-073-20231229   clang
x86_64                randconfig-073-20231230   clang
x86_64                randconfig-074-20231229   clang
x86_64                randconfig-074-20231230   clang
x86_64                randconfig-075-20231229   clang
x86_64                randconfig-075-20231230   clang
x86_64                randconfig-076-20231229   clang
x86_64                randconfig-076-20231230   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231229   gcc  
xtensa                randconfig-001-20231230   gcc  
xtensa                randconfig-002-20231229   gcc  
xtensa                randconfig-002-20231230   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

