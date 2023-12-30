Return-Path: <linux-kernel+bounces-13610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FA82092D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771611C21AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF7F9C4;
	Sat, 30 Dec 2023 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btWdNYC1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79BE555
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703980652; x=1735516652;
  h=date:from:to:cc:subject:message-id;
  bh=LjUV7k+jql6hoeayu4lqel4/rUKQGPjM5cqoQxxVpjQ=;
  b=btWdNYC15hLQydymsKxoo4T6UqGUB+iDPHuAU9EKVt3VZhCIqq0b/wgl
   5d4U/w0tXwsmxu7dFZ8n45N8MvyIIHr6JNSBrVb4POsoRTlC2SvumuycM
   +3/mdVbNgS6yIemlGbKPgNAuO88O2BYERFJSDtzO/kujo61eQ+qA7t8Bm
   YYGallUHXkMIOEw0ntEDzl7upgqI0gdIYQa70BFLrXsJn8u1kQXt/Zxvo
   ZrjC1zDMNjuNg9vf0zfXlYyOPHJ0e7uuXErk2BaAYvBBCuAYAWbNP+oeX
   ymJy1SCiW/r0qsn+y4Ag7bguLvxzbpYdkiRumgTFPyaPFle6LiUkSvIgx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="4034994"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="4034994"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 15:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="772246045"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="772246045"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2023 15:57:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJjCk-000Iqf-1H;
	Sat, 30 Dec 2023 23:57:22 +0000
Date: Sun, 31 Dec 2023 07:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0147ba23ddaee4c32fe9c9f327d276763e2db349
Message-ID: <202312310709.Occ8JaDz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0147ba23ddaee4c32fe9c9f327d276763e2db349  Merge x86/paravirt into tip/master

elapsed time: 731m

configs tested: 158
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231231   gcc  
arc                   randconfig-002-20231231   gcc  
arm                               allnoconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231231   gcc  
arm                   randconfig-002-20231231   gcc  
arm                   randconfig-003-20231231   gcc  
arm                   randconfig-004-20231231   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231231   gcc  
arm64                 randconfig-002-20231231   gcc  
arm64                 randconfig-003-20231231   gcc  
arm64                 randconfig-004-20231231   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231231   gcc  
csky                  randconfig-002-20231231   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231230   clang
i386         buildonly-randconfig-002-20231230   clang
i386         buildonly-randconfig-003-20231230   clang
i386         buildonly-randconfig-004-20231230   clang
i386         buildonly-randconfig-005-20231230   clang
i386         buildonly-randconfig-006-20231230   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231230   clang
i386                  randconfig-002-20231230   clang
i386                  randconfig-003-20231230   clang
i386                  randconfig-004-20231230   clang
i386                  randconfig-005-20231230   clang
i386                  randconfig-006-20231230   clang
i386                  randconfig-011-20231230   gcc  
i386                  randconfig-011-20231231   clang
i386                  randconfig-012-20231230   gcc  
i386                  randconfig-012-20231231   clang
i386                  randconfig-013-20231230   gcc  
i386                  randconfig-013-20231231   clang
i386                  randconfig-014-20231230   gcc  
i386                  randconfig-014-20231231   clang
i386                  randconfig-015-20231230   gcc  
i386                  randconfig-015-20231231   clang
i386                  randconfig-016-20231230   gcc  
i386                  randconfig-016-20231231   clang
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231231   gcc  
loongarch             randconfig-002-20231231   gcc  
m68k                              allnoconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231231   gcc  
nios2                 randconfig-002-20231231   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231231   gcc  
parisc                randconfig-002-20231231   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231231   gcc  
powerpc               randconfig-002-20231231   gcc  
powerpc               randconfig-003-20231231   gcc  
powerpc64             randconfig-001-20231231   gcc  
powerpc64             randconfig-002-20231231   gcc  
powerpc64             randconfig-003-20231231   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231231   gcc  
riscv                 randconfig-002-20231231   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231231   gcc  
sh                    randconfig-002-20231231   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231231   gcc  
sparc64               randconfig-002-20231231   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231231   gcc  
um                    randconfig-002-20231231   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231231   gcc  
x86_64       buildonly-randconfig-002-20231231   gcc  
x86_64       buildonly-randconfig-003-20231231   gcc  
x86_64       buildonly-randconfig-004-20231231   gcc  
x86_64       buildonly-randconfig-005-20231231   gcc  
x86_64       buildonly-randconfig-006-20231231   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231231   clang
x86_64                randconfig-002-20231231   clang
x86_64                randconfig-003-20231231   clang
x86_64                randconfig-004-20231231   clang
x86_64                randconfig-005-20231231   clang
x86_64                randconfig-006-20231231   clang
x86_64                randconfig-011-20231231   gcc  
x86_64                randconfig-012-20231231   gcc  
x86_64                randconfig-013-20231231   gcc  
x86_64                randconfig-014-20231231   gcc  
x86_64                randconfig-015-20231231   gcc  
x86_64                randconfig-016-20231231   gcc  
x86_64                randconfig-071-20231231   gcc  
x86_64                randconfig-072-20231231   gcc  
x86_64                randconfig-073-20231231   gcc  
x86_64                randconfig-074-20231231   gcc  
x86_64                randconfig-075-20231231   gcc  
x86_64                randconfig-076-20231231   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231231   gcc  
xtensa                randconfig-002-20231231   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

