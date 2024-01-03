Return-Path: <linux-kernel+bounces-15893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE811823517
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D431F25764
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340D1D541;
	Wed,  3 Jan 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anib4DlZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9131D525
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704308065; x=1735844065;
  h=date:from:to:cc:subject:message-id;
  bh=gruHyCY1dxEQ4h+QRdcLN4eE2UqMI2MWt/vSFLnr/ss=;
  b=Anib4DlZ2huIDd2clzxFiOmqNZXN9toklFCtXrR0yDcwkzRxBEErHDUw
   VthM6WIi1lNDbPgD84Mo8hMZZ/Of5fwjQqnUyqR8SeThJo7HU0UeEWEfO
   BJ5Qz2r1tXJ7ym8VcFQkgr3sXUYOIZ37bSbokf6B73jowHDA5ZcRUnLAJ
   xQ8Xxs8TCwBuH627AzIn62stwGtpd99bdMw90MLNGw//8flqSP7bVYJ+F
   9SaUmXTQQwz5keXWUbeREA7PqSnFoczUhLJHyRlxrIY/h2oKww9Ech7E4
   SYCF63R+tl3ROJakVTEAaX/4FpOdTm7B88oAJEw1r5MVPsCxb5vLtw9wm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="3816751"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="3816751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="729860720"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="729860720"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2024 10:50:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL6JE-000MSe-32;
	Wed, 03 Jan 2024 18:50:25 +0000
Date: Thu, 04 Jan 2024 02:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 d642ef7111014805f2e21e9cddb0c0a93ae1313d
Message-ID: <202401040258.LCx9Gx2U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: d642ef7111014805f2e21e9cddb0c0a93ae1313d  virt: sev-guest: Convert to platform remove callback returning void

elapsed time: 1458m

configs tested: 187
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
arc                   randconfig-001-20240103   gcc  
arc                   randconfig-002-20240103   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240103   clang
arm                   randconfig-002-20240103   clang
arm                   randconfig-003-20240103   clang
arm                   randconfig-004-20240103   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240103   clang
arm64                 randconfig-002-20240103   clang
arm64                 randconfig-003-20240103   clang
arm64                 randconfig-004-20240103   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240103   gcc  
csky                  randconfig-002-20240103   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240103   clang
hexagon               randconfig-002-20240103   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240103   clang
i386         buildonly-randconfig-002-20240103   clang
i386         buildonly-randconfig-003-20240103   clang
i386         buildonly-randconfig-004-20240103   clang
i386         buildonly-randconfig-005-20240103   clang
i386         buildonly-randconfig-006-20240103   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240103   clang
i386                  randconfig-002-20240103   clang
i386                  randconfig-003-20240103   clang
i386                  randconfig-004-20240103   clang
i386                  randconfig-005-20240103   clang
i386                  randconfig-006-20240103   clang
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
loongarch             randconfig-001-20240103   gcc  
loongarch             randconfig-002-20240103   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240103   gcc  
nios2                 randconfig-002-20240103   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240103   gcc  
parisc                randconfig-002-20240103   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc               randconfig-001-20240103   clang
powerpc               randconfig-002-20240103   clang
powerpc               randconfig-003-20240103   clang
powerpc                      tqm8xx_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20240103   clang
powerpc64             randconfig-002-20240103   clang
powerpc64             randconfig-003-20240103   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240103   clang
riscv                 randconfig-002-20240103   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240103   gcc  
s390                  randconfig-002-20240103   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240103   gcc  
sh                    randconfig-002-20240103   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240103   gcc  
sparc64               randconfig-002-20240103   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240103   clang
um                    randconfig-002-20240103   clang
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
xtensa                randconfig-001-20240103   gcc  
xtensa                randconfig-002-20240103   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

