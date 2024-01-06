Return-Path: <linux-kernel+bounces-18531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF92825ED0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3972BB233E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220C5253;
	Sat,  6 Jan 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJs5Zbsu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F194409
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704527693; x=1736063693;
  h=date:from:to:cc:subject:message-id;
  bh=R1KUc/XKaXKYilZAKmKJ4aHbS5g3jejtnPMSC4NhFoE=;
  b=NJs5ZbsuBPm62wxgUyTkrpW+vdXPC3PoXMPSrJHrE6hNln2Qbzfp/xo1
   f44rnn8760S5SRof7mXbZNeGyvFaa1+KapeY3jRMstLX0HF97XCLVswvL
   O/fNQvPNV/qwrsVLgYfZt/B07zghsjzftfxDvwpWHG4aQXzCWtW2E5MDV
   L2L7cyVg7dcGDn7nXPvb7x2cegff/t3kPQTyPhVoPuB/Kb84yfAdcckk/
   jh24kIFfSxg6KfpIe4JNicGPg7GAbFr3MUe463aytt0/AmRaetZkdaode
   pCVzbv8vF9XeNbVyMO5gU6Y1FlejZjAMT5xuVdQWaevBGEzSWoGArYP2p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="16251716"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="16251716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="757154662"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="757154662"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2024 23:54:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM1W4-0002Ca-20;
	Sat, 06 Jan 2024 07:54:48 +0000
Date: Sat, 06 Jan 2024 15:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a8bd4088b90f1d691f2bce67ec5ec04c4699c005
Message-ID: <202401061508.eRWaaaX1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a8bd4088b90f1d691f2bce67ec5ec04c4699c005  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1448m

configs tested: 188
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
arc                   randconfig-001-20240106   gcc  
arc                   randconfig-002-20240106   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20240106   gcc  
arm                   randconfig-002-20240106   gcc  
arm                   randconfig-003-20240106   gcc  
arm                   randconfig-004-20240106   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240106   gcc  
arm64                 randconfig-002-20240106   gcc  
arm64                 randconfig-003-20240106   gcc  
arm64                 randconfig-004-20240106   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240106   gcc  
csky                  randconfig-002-20240106   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240105   clang
i386         buildonly-randconfig-002-20240105   clang
i386         buildonly-randconfig-003-20240105   clang
i386         buildonly-randconfig-004-20240105   clang
i386         buildonly-randconfig-005-20240105   clang
i386         buildonly-randconfig-006-20240105   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240105   clang
i386                  randconfig-002-20240105   clang
i386                  randconfig-003-20240105   clang
i386                  randconfig-004-20240105   clang
i386                  randconfig-005-20240105   clang
i386                  randconfig-006-20240105   clang
i386                  randconfig-011-20240105   gcc  
i386                  randconfig-011-20240106   clang
i386                  randconfig-012-20240105   gcc  
i386                  randconfig-012-20240106   clang
i386                  randconfig-013-20240105   gcc  
i386                  randconfig-013-20240106   clang
i386                  randconfig-014-20240105   gcc  
i386                  randconfig-014-20240106   clang
i386                  randconfig-015-20240105   gcc  
i386                  randconfig-015-20240106   clang
i386                  randconfig-016-20240105   gcc  
i386                  randconfig-016-20240106   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240106   gcc  
loongarch             randconfig-002-20240106   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240106   gcc  
nios2                 randconfig-002-20240106   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240106   gcc  
parisc                randconfig-002-20240106   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc               randconfig-001-20240106   gcc  
powerpc               randconfig-002-20240106   gcc  
powerpc               randconfig-003-20240106   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc64             randconfig-001-20240106   gcc  
powerpc64             randconfig-002-20240106   gcc  
powerpc64             randconfig-003-20240106   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240106   gcc  
riscv                 randconfig-002-20240106   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240106   gcc  
sh                    randconfig-002-20240106   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240106   gcc  
sparc64               randconfig-002-20240106   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240106   gcc  
um                    randconfig-002-20240106   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240106   gcc  
x86_64       buildonly-randconfig-002-20240106   gcc  
x86_64       buildonly-randconfig-003-20240106   gcc  
x86_64       buildonly-randconfig-004-20240106   gcc  
x86_64       buildonly-randconfig-005-20240106   gcc  
x86_64       buildonly-randconfig-006-20240106   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240106   gcc  
x86_64                randconfig-012-20240106   gcc  
x86_64                randconfig-013-20240106   gcc  
x86_64                randconfig-014-20240106   gcc  
x86_64                randconfig-015-20240106   gcc  
x86_64                randconfig-016-20240106   gcc  
x86_64                randconfig-071-20240106   gcc  
x86_64                randconfig-072-20240106   gcc  
x86_64                randconfig-073-20240106   gcc  
x86_64                randconfig-074-20240106   gcc  
x86_64                randconfig-075-20240106   gcc  
x86_64                randconfig-076-20240106   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240106   gcc  
xtensa                randconfig-002-20240106   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

