Return-Path: <linux-kernel+bounces-20681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B0582836A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E01F2741A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AFC36B11;
	Tue,  9 Jan 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nv0Crvsy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877A36B08
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704793318; x=1736329318;
  h=date:from:to:cc:subject:message-id;
  bh=Ysun2aHtpA2ORdCgX3cEbFOiM7X5/+LOjFI+xOjR2Ek=;
  b=nv0CrvsyTN/nMCfidPALNkwcg2AiKAKCFGBPQqUkSK9FPDLGEGJVbCQ3
   2Qgxhbbabd/MP/uYHPEsjr1FErp22p5mE0CjaE/VErF36VQiVzq7jExja
   4MyG6hw3Z8h/m7CZ3zcWxMvMwEGjnsDgOy7SDA3AjuWWXUSt1zU1+WTUE
   MWXsGsAUTjhElQnRYFeGssrZaffR2FIeVmMLLwmUGGRL7X4abq5sjiNGd
   /8QUp1aeMUqiD5buRyFh/2bIjYuYbgqvTy1OyIntTKkVKd3bHceeuoxgd
   YGeGZ+bPOMN1gH2RgWbi9l3bLxzb1PZ9TyCBES3ZeaSLI0t3yxWOxixvi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11492457"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="11492457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 01:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925189716"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="925189716"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2024 01:41:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rN8cM-0005ge-0K;
	Tue, 09 Jan 2024 09:41:54 +0000
Date: Tue, 09 Jan 2024 17:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2
Message-ID: <202401091705.MawxNU9x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2  locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, can still use the lock object after it's unlocked

elapsed time: 1454m

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
arc                   randconfig-001-20240108   gcc  
arc                   randconfig-002-20240108   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240108   gcc  
arm                   randconfig-002-20240108   gcc  
arm                   randconfig-003-20240108   gcc  
arm                   randconfig-004-20240108   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240108   gcc  
arm64                 randconfig-002-20240108   gcc  
arm64                 randconfig-003-20240108   gcc  
arm64                 randconfig-004-20240108   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240108   gcc  
csky                  randconfig-002-20240108   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240108   clang
hexagon               randconfig-002-20240108   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240108   gcc  
i386         buildonly-randconfig-002-20240108   gcc  
i386         buildonly-randconfig-003-20240108   gcc  
i386         buildonly-randconfig-004-20240108   gcc  
i386         buildonly-randconfig-005-20240108   gcc  
i386         buildonly-randconfig-006-20240108   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240108   gcc  
i386                  randconfig-002-20240108   gcc  
i386                  randconfig-003-20240108   gcc  
i386                  randconfig-004-20240108   gcc  
i386                  randconfig-005-20240108   gcc  
i386                  randconfig-006-20240108   gcc  
i386                  randconfig-011-20240108   clang
i386                  randconfig-012-20240108   clang
i386                  randconfig-013-20240108   clang
i386                  randconfig-014-20240108   clang
i386                  randconfig-015-20240108   clang
i386                  randconfig-016-20240108   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240108   gcc  
loongarch             randconfig-002-20240108   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240108   gcc  
nios2                 randconfig-002-20240108   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240108   gcc  
parisc                randconfig-002-20240108   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc               randconfig-001-20240108   gcc  
powerpc               randconfig-002-20240108   gcc  
powerpc               randconfig-003-20240108   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240108   gcc  
powerpc64             randconfig-002-20240108   gcc  
powerpc64             randconfig-003-20240108   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240108   gcc  
riscv                 randconfig-002-20240108   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240108   clang
s390                  randconfig-002-20240108   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240108   gcc  
sh                    randconfig-002-20240108   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240108   gcc  
sparc64               randconfig-002-20240108   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240108   gcc  
um                    randconfig-002-20240108   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240108   gcc  
x86_64       buildonly-randconfig-002-20240108   gcc  
x86_64       buildonly-randconfig-003-20240108   gcc  
x86_64       buildonly-randconfig-004-20240108   gcc  
x86_64       buildonly-randconfig-005-20240108   gcc  
x86_64       buildonly-randconfig-006-20240108   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240108   clang
x86_64                randconfig-002-20240108   clang
x86_64                randconfig-003-20240108   clang
x86_64                randconfig-004-20240108   clang
x86_64                randconfig-005-20240108   clang
x86_64                randconfig-006-20240108   clang
x86_64                randconfig-011-20240108   gcc  
x86_64                randconfig-012-20240108   gcc  
x86_64                randconfig-013-20240108   gcc  
x86_64                randconfig-014-20240108   gcc  
x86_64                randconfig-015-20240108   gcc  
x86_64                randconfig-016-20240108   gcc  
x86_64                randconfig-071-20240108   gcc  
x86_64                randconfig-072-20240108   gcc  
x86_64                randconfig-073-20240108   gcc  
x86_64                randconfig-074-20240108   gcc  
x86_64                randconfig-075-20240108   gcc  
x86_64                randconfig-076-20240108   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240108   gcc  
xtensa                randconfig-002-20240108   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

