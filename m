Return-Path: <linux-kernel+bounces-12522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D5A81F60D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DEF283D30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4444F63B6;
	Thu, 28 Dec 2023 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWdCCn6m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E35235
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703753047; x=1735289047;
  h=date:from:to:cc:subject:message-id;
  bh=OVQHMDZzsRsLed9e5KnxlYTrZaVGX5hmcC6wYEHna+o=;
  b=CWdCCn6mZskXGs/HYQVcX54v0vrEyzXAu9C7F+pKUPTyCHoktqB4gM0U
   Nr12fFVBIE0mmWATIQ/Kqz1czdAdPcC7UPFuQcADJpuA+04x15kLJCatO
   egCJJsEMj413r0wGR53/S/aSm6H/M0AEg6tIJAAcUVH1ydo05QK35SduV
   RxkGPtee7IUR828H+xxTFzAtNhwPz0SirHx7blNcqfe8F4VTmH/VXX2Ir
   YQGzf+2QF7/R9JcJQmVUoBYHeMEHnwDMpMRPyqTd+tNB4qIoTieuT07v7
   7vs1gUUnsjZrhdyc7pX6XxUH/g2GGfmBVo8nN5LJM7nMUgfZ67hGi1Unn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="462943049"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="462943049"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="771668660"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="771668660"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2023 00:44:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIlzm-000GFX-1E;
	Thu, 28 Dec 2023 08:44:02 +0000
Date: Thu, 28 Dec 2023 16:43:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0cd7f0ac8c4bb49515363cc81d8ebc777b1e5d8b
Message-ID: <202312281654.2QQ5c3ky-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0cd7f0ac8c4bb49515363cc81d8ebc777b1e5d8b  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1453m

configs tested: 179
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
arc                   randconfig-001-20231227   gcc  
arc                   randconfig-002-20231227   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231227   clang
arm                   randconfig-002-20231227   clang
arm                   randconfig-003-20231227   clang
arm                   randconfig-004-20231227   clang
arm                        realview_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231227   clang
arm64                 randconfig-002-20231227   clang
arm64                 randconfig-003-20231227   clang
arm64                 randconfig-004-20231227   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231227   gcc  
csky                  randconfig-002-20231227   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231227   clang
hexagon               randconfig-002-20231227   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231227   clang
i386         buildonly-randconfig-002-20231227   clang
i386         buildonly-randconfig-003-20231227   clang
i386         buildonly-randconfig-004-20231227   clang
i386         buildonly-randconfig-005-20231227   clang
i386         buildonly-randconfig-006-20231227   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231227   clang
i386                  randconfig-002-20231227   clang
i386                  randconfig-003-20231227   clang
i386                  randconfig-004-20231227   clang
i386                  randconfig-005-20231227   clang
i386                  randconfig-006-20231227   clang
i386                  randconfig-011-20231227   gcc  
i386                  randconfig-012-20231227   gcc  
i386                  randconfig-013-20231227   gcc  
i386                  randconfig-014-20231227   gcc  
i386                  randconfig-015-20231227   gcc  
i386                  randconfig-016-20231227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231227   gcc  
loongarch             randconfig-002-20231227   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231227   gcc  
nios2                 randconfig-002-20231227   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231227   gcc  
parisc                randconfig-002-20231227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231227   clang
powerpc               randconfig-002-20231227   clang
powerpc               randconfig-003-20231227   clang
powerpc                     tqm8540_defconfig   clang
powerpc64             randconfig-001-20231227   clang
powerpc64             randconfig-002-20231227   clang
powerpc64             randconfig-003-20231227   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231227   clang
riscv                 randconfig-002-20231227   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231227   gcc  
s390                  randconfig-002-20231227   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20231227   gcc  
sh                    randconfig-002-20231227   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231227   gcc  
sparc64               randconfig-002-20231227   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231227   clang
um                    randconfig-002-20231227   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231227   clang
x86_64       buildonly-randconfig-002-20231227   clang
x86_64       buildonly-randconfig-003-20231227   clang
x86_64       buildonly-randconfig-004-20231227   clang
x86_64       buildonly-randconfig-005-20231227   clang
x86_64       buildonly-randconfig-006-20231227   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231227   gcc  
x86_64                randconfig-002-20231227   gcc  
x86_64                randconfig-003-20231227   gcc  
x86_64                randconfig-004-20231227   gcc  
x86_64                randconfig-005-20231227   gcc  
x86_64                randconfig-006-20231227   gcc  
x86_64                randconfig-011-20231227   clang
x86_64                randconfig-012-20231227   clang
x86_64                randconfig-013-20231227   clang
x86_64                randconfig-014-20231227   clang
x86_64                randconfig-015-20231227   clang
x86_64                randconfig-016-20231227   clang
x86_64                randconfig-071-20231227   clang
x86_64                randconfig-072-20231227   clang
x86_64                randconfig-073-20231227   clang
x86_64                randconfig-074-20231227   clang
x86_64                randconfig-075-20231227   clang
x86_64                randconfig-076-20231227   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231227   gcc  
xtensa                randconfig-002-20231227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

