Return-Path: <linux-kernel+bounces-24788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E782C28F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412691C21B99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE326E2D7;
	Fri, 12 Jan 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibtclRSU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1736EB40
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705072181; x=1736608181;
  h=date:from:to:cc:subject:message-id;
  bh=LVbK1H7/FmorM6HRCm5rl33ZF45UB3FlGKTjv/oh+5o=;
  b=ibtclRSUF3Np8eNoo4gI8vrzsWOnaheNTMg/iNqnQWLcj839jKmctt3d
   UBdxvs6Nw2N5Bh4q1usVgVoqJqYDuEw+uHMO8R286YiobrN6nqBqMoB++
   bh4sLDV/gzd57JxICGkZ+ZJMDciiAIHNGH2lGcwrKlbnTjG5EtE97NouS
   98HAt6dIF2idcJPhOxXUX5JOYiZXdJHMrfJ/T05i4H96cnoTWU5C5bXQw
   REsFY9q9dG2NJWd8J2JAyuGpprzr7g3vGvOxj97fWvKi4qPWcjNNIP6H3
   i5yv/6HcUGZFdTF32QTMy9NDIlhOLC8b0AP6H5gTgqgrGhhvF5ScvNMk6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6554894"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6554894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 07:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1029952621"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="1029952621"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2024 07:09:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOJA8-0009ay-2d;
	Fri, 12 Jan 2024 15:09:36 +0000
Date: Fri, 12 Jan 2024 23:08:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 e8b2ac1e883581bc9c37bf165b31cbedd6862ed0
Message-ID: <202401122353.JzjyGEEW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: e8b2ac1e883581bc9c37bf165b31cbedd6862ed0  Merge branch 'linus' into x86/merge, to ease integration testing

elapsed time: 1674m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240112   gcc  
arc                   randconfig-002-20240112   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20240112   clang
arm                   randconfig-002-20240112   clang
arm                   randconfig-003-20240112   clang
arm                   randconfig-004-20240112   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240112   clang
arm64                 randconfig-002-20240112   clang
arm64                 randconfig-003-20240112   clang
arm64                 randconfig-004-20240112   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240112   gcc  
csky                  randconfig-002-20240112   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240112   clang
hexagon               randconfig-002-20240112   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240112   clang
i386         buildonly-randconfig-002-20240112   clang
i386         buildonly-randconfig-003-20240112   clang
i386         buildonly-randconfig-004-20240112   clang
i386         buildonly-randconfig-005-20240112   clang
i386         buildonly-randconfig-006-20240112   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240112   clang
i386                  randconfig-002-20240112   clang
i386                  randconfig-003-20240112   clang
i386                  randconfig-004-20240112   clang
i386                  randconfig-005-20240112   clang
i386                  randconfig-006-20240112   clang
i386                  randconfig-011-20240112   gcc  
i386                  randconfig-012-20240112   gcc  
i386                  randconfig-013-20240112   gcc  
i386                  randconfig-014-20240112   gcc  
i386                  randconfig-015-20240112   gcc  
i386                  randconfig-016-20240112   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240112   gcc  
loongarch             randconfig-002-20240112   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                        bcm63xx_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240112   gcc  
nios2                 randconfig-002-20240112   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240112   gcc  
parisc                randconfig-002-20240112   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240112   clang
powerpc               randconfig-002-20240112   clang
powerpc               randconfig-003-20240112   clang
powerpc64             randconfig-001-20240112   clang
powerpc64             randconfig-002-20240112   clang
powerpc64             randconfig-003-20240112   clang
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240112   clang
riscv                 randconfig-002-20240112   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240112   gcc  
s390                  randconfig-002-20240112   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240112   gcc  
sh                    randconfig-002-20240112   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240112   gcc  
sparc64               randconfig-002-20240112   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240112   clang
um                    randconfig-002-20240112   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240112   gcc  
xtensa                randconfig-002-20240112   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

