Return-Path: <linux-kernel+bounces-15414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651A822BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB01C22781
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043D18E10;
	Wed,  3 Jan 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cjf5vdhJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D418E06
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704279261; x=1735815261;
  h=date:from:to:cc:subject:message-id;
  bh=06y4//2HCvOaoJM5B7IanewZNCVyOStotoMtfbw/fpc=;
  b=Cjf5vdhJ1QjJ0a32RHuaN0OHrX5rtptRL4VwgYhkE0gfhH4RrW919Y9N
   Bw0MHbbSNHSF28tlsmkwNG0Jj7KiXbOJ5aDInIz3dg9CPs3+s0VqIduSI
   tOTcCfudcP8Rc39+NbackwOcMVtHc8VWmstqSeakQck35kA7snOTjJASz
   nahnWWX7ND8kwAQZ5rWWiYNOJLPrPXlgpbDcV+AIodc0dAOroncY/9/T+
   TSSlyPAf+ahFAVj6+Uh/BUUYJW8e2gSlsN+lEW73wdNMxXH2mDeao2hvV
   zpiP5Isw2YL9KCq+/iatMurDs+BmX3c8mbmfKbbl5nbPfQum9rCe1Wdnd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4345889"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4345889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 02:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808804000"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="808804000"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2024 02:54:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKyt6-000LzM-2V;
	Wed, 03 Jan 2024 10:54:16 +0000
Date: Wed, 03 Jan 2024 18:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 67a1723344cfe05430977483d6d3c7a999480143
Message-ID: <202401031834.jH6PzwpX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 67a1723344cfe05430977483d6d3c7a999480143  Merge tag 'v6.7-rc8' into locking/core, to pick up dependent changes

elapsed time: 1469m

configs tested: 254
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240102   gcc  
arc                   randconfig-001-20240103   gcc  
arc                   randconfig-002-20240102   gcc  
arc                   randconfig-002-20240103   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240102   gcc  
arm                   randconfig-002-20240102   gcc  
arm                   randconfig-003-20240102   gcc  
arm                   randconfig-004-20240102   gcc  
arm                             rpc_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240102   gcc  
arm64                 randconfig-002-20240102   gcc  
arm64                 randconfig-003-20240102   gcc  
arm64                 randconfig-004-20240102   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240102   gcc  
csky                  randconfig-001-20240103   gcc  
csky                  randconfig-002-20240102   gcc  
csky                  randconfig-002-20240103   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240102   clang
hexagon               randconfig-002-20240102   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240102   gcc  
i386         buildonly-randconfig-001-20240103   clang
i386         buildonly-randconfig-002-20240102   gcc  
i386         buildonly-randconfig-002-20240103   clang
i386         buildonly-randconfig-003-20240102   gcc  
i386         buildonly-randconfig-003-20240103   clang
i386         buildonly-randconfig-004-20240102   gcc  
i386         buildonly-randconfig-004-20240103   clang
i386         buildonly-randconfig-005-20240102   gcc  
i386         buildonly-randconfig-005-20240103   clang
i386         buildonly-randconfig-006-20240102   gcc  
i386         buildonly-randconfig-006-20240103   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240102   gcc  
i386                  randconfig-001-20240103   clang
i386                  randconfig-002-20240102   gcc  
i386                  randconfig-002-20240103   clang
i386                  randconfig-003-20240102   gcc  
i386                  randconfig-003-20240103   clang
i386                  randconfig-004-20240102   gcc  
i386                  randconfig-004-20240103   clang
i386                  randconfig-005-20240102   gcc  
i386                  randconfig-005-20240103   clang
i386                  randconfig-006-20240102   gcc  
i386                  randconfig-006-20240103   clang
i386                  randconfig-011-20240102   clang
i386                  randconfig-011-20240103   gcc  
i386                  randconfig-012-20240103   gcc  
i386                  randconfig-013-20240103   gcc  
i386                  randconfig-014-20240103   gcc  
i386                  randconfig-015-20240103   gcc  
i386                  randconfig-016-20240103   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240102   gcc  
loongarch             randconfig-001-20240103   gcc  
loongarch             randconfig-002-20240102   gcc  
loongarch             randconfig-002-20240103   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                          rm200_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240102   gcc  
nios2                 randconfig-001-20240103   gcc  
nios2                 randconfig-002-20240102   gcc  
nios2                 randconfig-002-20240103   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240102   gcc  
parisc                randconfig-001-20240103   gcc  
parisc                randconfig-002-20240102   gcc  
parisc                randconfig-002-20240103   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     ksi8560_defconfig   gcc  
powerpc               randconfig-001-20240102   gcc  
powerpc               randconfig-002-20240102   gcc  
powerpc               randconfig-003-20240102   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc64             randconfig-001-20240102   gcc  
powerpc64             randconfig-002-20240102   gcc  
powerpc64             randconfig-003-20240102   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20240102   gcc  
riscv                 randconfig-002-20240102   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240102   clang
s390                  randconfig-001-20240103   gcc  
s390                  randconfig-002-20240102   clang
s390                  randconfig-002-20240103   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240102   gcc  
sh                    randconfig-001-20240103   gcc  
sh                    randconfig-002-20240102   gcc  
sh                    randconfig-002-20240103   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240102   gcc  
sparc64               randconfig-001-20240103   gcc  
sparc64               randconfig-002-20240102   gcc  
sparc64               randconfig-002-20240103   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240102   gcc  
um                    randconfig-002-20240102   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240103   clang
x86_64       buildonly-randconfig-002-20240103   clang
x86_64       buildonly-randconfig-003-20240103   clang
x86_64       buildonly-randconfig-004-20240103   clang
x86_64       buildonly-randconfig-005-20240103   clang
x86_64       buildonly-randconfig-006-20240103   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240103   gcc  
x86_64                randconfig-002-20240103   gcc  
x86_64                randconfig-003-20240103   gcc  
x86_64                randconfig-004-20240103   gcc  
x86_64                randconfig-005-20240103   gcc  
x86_64                randconfig-006-20240103   gcc  
x86_64                randconfig-011-20240103   clang
x86_64                randconfig-012-20240103   clang
x86_64                randconfig-013-20240103   clang
x86_64                randconfig-014-20240103   clang
x86_64                randconfig-015-20240103   clang
x86_64                randconfig-016-20240103   clang
x86_64                randconfig-071-20240103   clang
x86_64                randconfig-072-20240103   clang
x86_64                randconfig-073-20240103   clang
x86_64                randconfig-074-20240103   clang
x86_64                randconfig-075-20240103   clang
x86_64                randconfig-076-20240103   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240102   gcc  
xtensa                randconfig-001-20240103   gcc  
xtensa                randconfig-002-20240102   gcc  
xtensa                randconfig-002-20240103   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

