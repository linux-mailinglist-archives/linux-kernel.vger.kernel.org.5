Return-Path: <linux-kernel+bounces-18844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D88263E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E0C1F217F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50DC12E54;
	Sun,  7 Jan 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9bX/zok"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06212E48
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704626995; x=1736162995;
  h=date:from:to:cc:subject:message-id;
  bh=PBdO6NbXxU//jDDfiXpPijGt5XPQNojfiGbFIrIaz08=;
  b=L9bX/zokBAv2oVm3sXUILOlXVfggFcBOIp3I1U/uuozv1VsbF5FxmljY
   Gpw5w+Lp2/4WcRJdJabOccVuBuSn+IKIJ4H+4wUCZWYD/7QHnIYTtkVxv
   oDAaGW4Q6nsgfoUCylMVhy8/PQPVwPY4Mq4dS50D+v046WTOptYkP5Lo6
   SzLGJ/nW6IyceEcD5wTwG/hrx4EumWI+xYIr0hK19cEuFjfaynerFk0Tr
   4a1LOa4VYGZGLtP/KDkX3YPiDHcj07TGo3eBvIiAkBrMFT0a78EfiDwXQ
   5XWKT4APDCUV/FVrHDjbGmWsCKUAcA9go1lx+QQgZnmYBXXl4NpNpJpuU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="11206717"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="11206717"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 03:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="809967201"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="809967201"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2024 03:29:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMRLi-0003lC-0d;
	Sun, 07 Jan 2024 11:29:50 +0000
Date: Sun, 07 Jan 2024 19:29:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 da609a249b78dc175764f76e167ae3d66cdfd54f
Message-ID: <202401071905.zmHfMx9r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: da609a249b78dc175764f76e167ae3d66cdfd54f  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1446m

configs tested: 143
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240107   gcc  
arc                   randconfig-002-20240107   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240107   clang
arm                   randconfig-002-20240107   clang
arm                   randconfig-003-20240107   clang
arm                   randconfig-004-20240107   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240107   clang
arm64                 randconfig-002-20240107   clang
arm64                 randconfig-003-20240107   clang
arm64                 randconfig-004-20240107   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240107   gcc  
csky                  randconfig-002-20240107   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240107   clang
hexagon               randconfig-002-20240107   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240106   gcc  
i386         buildonly-randconfig-002-20240106   gcc  
i386         buildonly-randconfig-003-20240106   gcc  
i386         buildonly-randconfig-004-20240106   gcc  
i386         buildonly-randconfig-005-20240106   gcc  
i386         buildonly-randconfig-006-20240106   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240106   gcc  
i386                  randconfig-002-20240106   gcc  
i386                  randconfig-003-20240106   gcc  
i386                  randconfig-004-20240106   gcc  
i386                  randconfig-005-20240106   gcc  
i386                  randconfig-006-20240106   gcc  
i386                  randconfig-011-20240106   clang
i386                  randconfig-012-20240106   clang
i386                  randconfig-013-20240106   clang
i386                  randconfig-014-20240106   clang
i386                  randconfig-015-20240106   clang
i386                  randconfig-016-20240106   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch             randconfig-001-20240107   gcc  
loongarch             randconfig-002-20240107   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20240107   gcc  
nios2                 randconfig-002-20240107   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240107   gcc  
parisc                randconfig-002-20240107   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc               randconfig-001-20240107   clang
powerpc               randconfig-002-20240107   clang
powerpc               randconfig-003-20240107   clang
powerpc64             randconfig-001-20240107   clang
powerpc64             randconfig-002-20240107   clang
powerpc64             randconfig-003-20240107   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20240107   clang
riscv                 randconfig-002-20240107   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                  randconfig-001-20240107   gcc  
s390                  randconfig-002-20240107   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240107   gcc  
sh                    randconfig-002-20240107   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240107   gcc  
sparc64               randconfig-002-20240107   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20240107   clang
um                    randconfig-002-20240107   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240107   clang
x86_64       buildonly-randconfig-002-20240107   clang
x86_64       buildonly-randconfig-003-20240107   clang
x86_64       buildonly-randconfig-004-20240107   clang
x86_64       buildonly-randconfig-005-20240107   clang
x86_64       buildonly-randconfig-006-20240107   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240107   gcc  
x86_64                randconfig-002-20240107   gcc  
x86_64                randconfig-003-20240107   gcc  
x86_64                randconfig-004-20240107   gcc  
x86_64                randconfig-005-20240107   gcc  
x86_64                randconfig-006-20240107   gcc  
x86_64                randconfig-011-20240107   clang
x86_64                randconfig-012-20240107   clang
x86_64                randconfig-013-20240107   clang
x86_64                randconfig-014-20240107   clang
x86_64                randconfig-015-20240107   clang
x86_64                randconfig-016-20240107   clang
x86_64                randconfig-071-20240107   clang
x86_64                randconfig-072-20240107   clang
x86_64                randconfig-073-20240107   clang
x86_64                randconfig-074-20240107   clang
x86_64                randconfig-075-20240107   clang
x86_64                randconfig-076-20240107   clang
x86_64                          rhel-8.3-rust   clang
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240107   gcc  
xtensa                randconfig-002-20240107   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

