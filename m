Return-Path: <linux-kernel+bounces-158552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5CE8B21F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2731F22D01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA612C464;
	Thu, 25 Apr 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoLHM/p3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733B1494C3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049401; cv=none; b=Jont64VAtIkDI20e80ouclBeYUGSUQdTOxckmFrfcM/DrTvP8TPPhDLh7gCcGIvLJfuP74wmKKOt34edzxC0gKXC6For6eIUc2Ll47vvmtLUrkFhOS1pVXXp0lGmkhmIeR6rH2+1t2gSEe2nrbbNFREazOiaiwLFPzW6ccSsCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049401; c=relaxed/simple;
	bh=5zHyuNB2I8aWOEEr179pEKRqtqNCcY1pQ85Qo6n17w8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fJWqWZqnT8NozjjLhWwxFfUhq01BkoEar8Wc97uOuM3n08Z70RpAdHnHCVKFCdIPW3YQ87fbBkVrvHxccozfxyM2O7LMYYwDsW8ONDbZ3YAkIrzRGcDg3AD6Oi8ARoZYBH5tc4/M42F4TIHNcZqADZQzx9HCDRwvZ30yeKXNga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoLHM/p3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714049399; x=1745585399;
  h=date:from:to:cc:subject:message-id;
  bh=5zHyuNB2I8aWOEEr179pEKRqtqNCcY1pQ85Qo6n17w8=;
  b=aoLHM/p3joyzrZiMVbC0f7kyXrgJSqEfzKVlFK58/KOJ1oEE8jbmKBZu
   YCWyZUPTSkvzD7Q81+XiniJjm55DEhp+KKmfGgIdw00GRmKYKx8ihdBIY
   3LU1pMtGPbeoZNXy+v2lXfChh7gKQ42im8NhV7F3pEaRrz3VoR0vBP8al
   TnmaK6S8FSI6auA17xUNmImxca09wCsmPvaCUmtG/NV++LcTmo8ByPMyP
   JJunJQxrqwPoSmtySwMc4XhDQI3atCB3nqOzyPwC+2BCCfr78sw+uDP6T
   W3nDdJoQjUAn66ykIZwhU6Uts3dBgdZz42CzR0npK9CuyF31zSYYS/PKG
   w==;
X-CSE-ConnectionGUID: HvG9tY3zRWWE2NaFUY4deg==
X-CSE-MsgGUID: xnmQTonnQoutqGXMtq+2lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9579440"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9579440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:49:58 -0700
X-CSE-ConnectionGUID: Qfo4rWN1Tzy7nuKZqp/H1w==
X-CSE-MsgGUID: fDjao00cRue/QfhVGckmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29833351"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Apr 2024 05:49:57 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzyXy-0002M4-1g;
	Thu, 25 Apr 2024 12:49:54 +0000
Date: Thu, 25 Apr 2024 20:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 931be446c6cbc15691dd499957e961f4e1d56afb
Message-ID: <202404252058.EHNpaBUk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 931be446c6cbc15691dd499957e961f4e1d56afb  x86/resctrl: Add tracepoint for llc_occupancy tracking

elapsed time: 1459m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240425   gcc  
arc                   randconfig-002-20240425   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20240425   clang
arm                   randconfig-002-20240425   clang
arm                   randconfig-003-20240425   clang
arm                   randconfig-004-20240425   clang
arm                         s3c6400_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240425   gcc  
arm64                 randconfig-002-20240425   gcc  
arm64                 randconfig-003-20240425   gcc  
arm64                 randconfig-004-20240425   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240425   gcc  
csky                  randconfig-002-20240425   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240425   clang
hexagon               randconfig-002-20240425   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240425   gcc  
i386         buildonly-randconfig-003-20240425   gcc  
i386         buildonly-randconfig-006-20240425   gcc  
i386                  randconfig-004-20240425   gcc  
i386                  randconfig-013-20240425   gcc  
i386                  randconfig-014-20240425   gcc  
i386                  randconfig-015-20240425   gcc  
i386                  randconfig-016-20240425   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240425   gcc  
loongarch             randconfig-002-20240425   gcc  
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
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240425   gcc  
nios2                 randconfig-002-20240425   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240425   gcc  
parisc                randconfig-002-20240425   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc               randconfig-001-20240425   gcc  
powerpc               randconfig-002-20240425   gcc  
powerpc               randconfig-003-20240425   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240425   gcc  
powerpc64             randconfig-002-20240425   gcc  
powerpc64             randconfig-003-20240425   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240425   gcc  
riscv                 randconfig-002-20240425   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240425   gcc  
s390                  randconfig-002-20240425   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240425   gcc  
sh                    randconfig-002-20240425   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240425   gcc  
sparc64               randconfig-002-20240425   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240425   gcc  
um                    randconfig-002-20240425   clang
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-002-20240425   gcc  
x86_64       buildonly-randconfig-006-20240425   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-004-20240425   gcc  
x86_64                randconfig-005-20240425   gcc  
x86_64                randconfig-011-20240425   gcc  
x86_64                randconfig-014-20240425   gcc  
x86_64                randconfig-072-20240425   gcc  
x86_64                randconfig-073-20240425   gcc  
x86_64                randconfig-076-20240425   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240425   gcc  
xtensa                randconfig-002-20240425   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

