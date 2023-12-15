Return-Path: <linux-kernel+bounces-408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9098140A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB37B22146
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434F53A9;
	Fri, 15 Dec 2023 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZXTJvsi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EF5382
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702611150; x=1734147150;
  h=date:from:to:cc:subject:message-id;
  bh=STU6jhfdqRIUUhxzPNw4/srXryc7mGsK4nsDErSR8lY=;
  b=fZXTJvsislyKXBiMoz4uAE4zB92aQuv41ih5ntyrT0XFflTu7UjmAALl
   jS0wzU0dZxWbKT5SSoGX/e7HmqdHJopI8aufOTFvctSex0ajeoPvPWZFj
   oTPOB1rsCVPeeCAq1uxft8rAhJBKfKxUkVgPmT7o5MAfwoWl4X922g//4
   7HT5PnarQ4XdxwUrrwaT1Hq1BuHD2KJPzui7+EhzZZiSDky8kuv8M54oq
   pn2bV6M+citJ8zD4O7BaYf0zjPwsbXU0+Pk2wOK4GsPP7Gz9Kx68693wy
   uHBssvZX/3b4EJ6mOn0vsfKYtKp+zzvtce+rCLvbNJ70Nem/EJKjrejFg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8583133"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="8583133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 19:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947813868"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="947813868"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2023 19:32:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDyw6-000N3d-1Y;
	Fri, 15 Dec 2023 03:32:26 +0000
Date: Fri, 15 Dec 2023 11:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/paravirt] BUILD SUCCESS
 f7af6977621a41661696d94c0c0a20c761404476
Message-ID: <202312151102.iE1RpXQv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
branch HEAD: f7af6977621a41661696d94c0c0a20c761404476  x86/paravirt: Remove no longer needed paravirt patching code

elapsed time: 953m

configs tested: 126
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231215   gcc  
arm                               allnoconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231215   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                              allnoconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                                allnoconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231215   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231215   clang
x86_64       buildonly-randconfig-002-20231215   clang
x86_64       buildonly-randconfig-003-20231215   clang
x86_64       buildonly-randconfig-004-20231215   clang
x86_64       buildonly-randconfig-005-20231215   clang
x86_64       buildonly-randconfig-006-20231215   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231215   clang
x86_64                randconfig-012-20231215   clang
x86_64                randconfig-013-20231215   clang
x86_64                randconfig-014-20231215   clang
x86_64                randconfig-015-20231215   clang
x86_64                randconfig-016-20231215   clang
x86_64                randconfig-071-20231215   clang
x86_64                randconfig-072-20231215   clang
x86_64                randconfig-073-20231215   clang
x86_64                randconfig-074-20231215   clang
x86_64                randconfig-075-20231215   clang
x86_64                randconfig-076-20231215   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231215   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

