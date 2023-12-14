Return-Path: <linux-kernel+bounces-206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C87813D71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60BCB21BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DC6DD08;
	Thu, 14 Dec 2023 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAg01sC5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC06D1AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702593817; x=1734129817;
  h=date:from:to:cc:subject:message-id;
  bh=pKk+jHkFQmrkd+tDXuElrE3cuI2UcOfZ0m4CvYXWk6c=;
  b=dAg01sC5FR5I/cOPBJRD1A4BwofizyU6n+JNQr2hvDgCxnvDwrkRAGWg
   DfkDlrYn/ZUGD4tg2P7QuMMitnqQnGyGlHEX+yl01UVZToxWsC7W2mUQC
   Tn2Ulj8Ncp16Cp3UzWbSfqJMGMA7+wPdA545dwcORXbCi1K35B4yiYny8
   IqC5Zfe2djiWFJVHo0hl2nceCwUOPvEf00IjQ2lrSfdPZ0SfQh7BpBdjv
   cppWeGnaXIvSQJLXelGcgeUTe5nLM+/8WLWikzejKGCbMJlP67O9Ggvm5
   j51tK7qtZ5dPqFCABiJ63mf40QyoK/9s6StA5s2Ysnjx8xmFlqhdlTE+2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8596206"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="8596206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808754763"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="808754763"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2023 14:43:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDuQQ-000MgZ-0a;
	Thu, 14 Dec 2023 22:43:26 +0000
Date: Fri, 15 Dec 2023 06:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.12.11a] BUILD SUCCESS
 bb36c40c1a346f2c2ca75f448c2354fd68a9903a
Message-ID: <202312150635.f80UPvLp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.12.11a
branch HEAD: bb36c40c1a346f2c2ca75f448c2354fd68a9903a  doc: Update checklist.rst discussion of callback execution

elapsed time: 1488m

configs tested: 233
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231214   gcc  
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231214   gcc  
arc                   randconfig-002-20231215   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231214   gcc  
arm                   randconfig-002-20231214   gcc  
arm                   randconfig-003-20231214   gcc  
arm                   randconfig-004-20231214   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231214   gcc  
arm64                 randconfig-002-20231214   gcc  
arm64                 randconfig-003-20231214   gcc  
arm64                 randconfig-004-20231214   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231214   gcc  
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231214   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231214   gcc  
i386         buildonly-randconfig-002-20231214   gcc  
i386         buildonly-randconfig-003-20231214   gcc  
i386         buildonly-randconfig-004-20231214   gcc  
i386         buildonly-randconfig-005-20231214   gcc  
i386         buildonly-randconfig-006-20231214   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231214   gcc  
i386                  randconfig-002-20231214   gcc  
i386                  randconfig-003-20231214   gcc  
i386                  randconfig-004-20231214   gcc  
i386                  randconfig-005-20231214   gcc  
i386                  randconfig-006-20231214   gcc  
i386                  randconfig-011-20231214   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231214   clang
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231214   clang
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231214   clang
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231214   clang
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231214   clang
i386                  randconfig-016-20231215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231214   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231214   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231214   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231214   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231214   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231214   gcc  
parisc                randconfig-002-20231215   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231214   gcc  
powerpc               randconfig-002-20231214   gcc  
powerpc               randconfig-003-20231214   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231214   gcc  
powerpc64             randconfig-002-20231214   gcc  
powerpc64             randconfig-003-20231214   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231214   gcc  
riscv                 randconfig-002-20231214   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231214   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231214   gcc  
sh                    randconfig-002-20231215   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231214   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231214   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231214   gcc  
um                    randconfig-002-20231214   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231214   gcc  
x86_64       buildonly-randconfig-001-20231215   clang
x86_64       buildonly-randconfig-002-20231214   gcc  
x86_64       buildonly-randconfig-002-20231215   clang
x86_64       buildonly-randconfig-003-20231214   gcc  
x86_64       buildonly-randconfig-003-20231215   clang
x86_64       buildonly-randconfig-004-20231214   gcc  
x86_64       buildonly-randconfig-004-20231215   clang
x86_64       buildonly-randconfig-005-20231214   gcc  
x86_64       buildonly-randconfig-005-20231215   clang
x86_64       buildonly-randconfig-006-20231214   gcc  
x86_64       buildonly-randconfig-006-20231215   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231214   gcc  
x86_64                randconfig-011-20231215   clang
x86_64                randconfig-012-20231214   gcc  
x86_64                randconfig-012-20231215   clang
x86_64                randconfig-013-20231214   gcc  
x86_64                randconfig-013-20231215   clang
x86_64                randconfig-014-20231214   gcc  
x86_64                randconfig-014-20231215   clang
x86_64                randconfig-015-20231214   gcc  
x86_64                randconfig-015-20231215   clang
x86_64                randconfig-016-20231214   gcc  
x86_64                randconfig-016-20231215   clang
x86_64                randconfig-071-20231214   gcc  
x86_64                randconfig-071-20231215   clang
x86_64                randconfig-072-20231214   gcc  
x86_64                randconfig-072-20231215   clang
x86_64                randconfig-073-20231214   gcc  
x86_64                randconfig-073-20231215   clang
x86_64                randconfig-074-20231214   gcc  
x86_64                randconfig-074-20231215   clang
x86_64                randconfig-075-20231214   gcc  
x86_64                randconfig-075-20231215   clang
x86_64                randconfig-076-20231214   gcc  
x86_64                randconfig-076-20231215   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231214   gcc  
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231214   gcc  
xtensa                randconfig-002-20231215   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

