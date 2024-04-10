Return-Path: <linux-kernel+bounces-137937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625989E9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71CA1F22E55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62E20B27;
	Wed, 10 Apr 2024 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXra4gfV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228E199A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727341; cv=none; b=n+ICcak/hetX8hA0V7nCrkIScrOpunKt/o3LDIFx9ck3ZvG0LahttsH8NqrsubXqX9EqjguMyYXz4AzxGHaWKJ8kqjTLhhDIxl2JNS09z9A2koyLjUq1bd7qJi4LW56zh4SErJr8AB8VJumulm8aYbvs4nT8H3zQ5E2jlSVqMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727341; c=relaxed/simple;
	bh=rH3AG0PWkAZmhhfiBcN2N3fXT3da5+Aiu9glsvKckKM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P2w5ybXEbi3M9KpIinAiS4On9YnpYUPLtdm6v+WZ59KNcgBdkM8DQ2FDQ6O63b1ItQdUaLEeaafi7+Hrw37NHatP3i1x6zEdbeZ66KyUGhOz1dV27pJJ7cAPdu7Fk4TuYhN6FF2oqoQOGaRJF6j9x2c7C/FnRgdeXfUJwqSTmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXra4gfV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712727339; x=1744263339;
  h=date:from:to:cc:subject:message-id;
  bh=rH3AG0PWkAZmhhfiBcN2N3fXT3da5+Aiu9glsvKckKM=;
  b=iXra4gfVnEcHbNue7OQK0dgeY+bQXFff9hgK0d7eU+yK6JbuLLvQMsv1
   u3zcrtM7e6zM79pvgEYoM1sRKV3S5nSPRJVQOBXRJbuKAnRWzyMvVNnfX
   m88y2EtxNvTPtvZNFba7gINXqwD+udaH/QRhosQFqmqus733olsCNzrZN
   K4Zhwfuf72duv5mU4GwcCuSNhPStcNru8z1G2u7mCPEnERsCpyPG2vxZS
   PN6DXDH9siyZm/MxeJP5CfBCYVK2K7nn0tV1o+FBG62DOtFRKzSRioHWg
   DurWP+1Py8vzcvZfVumGDlBgqMQ2/fyV+lq/lB3AiNLVo7tBp8FZQBOPL
   g==;
X-CSE-ConnectionGUID: iWIhPpxkQISvCaYDy+aTkA==
X-CSE-MsgGUID: PrezTSapRr6x5kW7Jqd0fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8248214"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8248214"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:35:36 -0700
X-CSE-ConnectionGUID: 5ezOHuXUTwqtRM9N/Wf6oA==
X-CSE-MsgGUID: 7Ai8LPcNQ72b3JfF79MnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25200702"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2024 22:35:34 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruQcO-0006xF-2H;
	Wed, 10 Apr 2024 05:35:32 +0000
Date: Wed, 10 Apr 2024 13:35:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 aef95dac9ce4f271cc43195ffc175114ed934cbe
Message-ID: <202404101306.qc4ICla8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: aef95dac9ce4f271cc43195ffc175114ed934cbe  locking/atomic/x86: Introduce arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64

elapsed time: 1250m

configs tested: 172
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
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240410   gcc  
arc                   randconfig-002-20240410   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240410   gcc  
arm                   randconfig-002-20240410   clang
arm                   randconfig-003-20240410   gcc  
arm                   randconfig-004-20240410   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240410   clang
arm64                 randconfig-002-20240410   gcc  
arm64                 randconfig-003-20240410   gcc  
arm64                 randconfig-004-20240410   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240410   gcc  
csky                  randconfig-002-20240410   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240410   clang
hexagon               randconfig-002-20240410   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-006-20240410   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240410   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-016-20240410   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240410   gcc  
loongarch             randconfig-002-20240410   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240410   gcc  
nios2                 randconfig-002-20240410   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240410   gcc  
parisc                randconfig-002-20240410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc               randconfig-001-20240410   gcc  
powerpc               randconfig-002-20240410   gcc  
powerpc               randconfig-003-20240410   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240410   gcc  
powerpc64             randconfig-002-20240410   gcc  
powerpc64             randconfig-003-20240410   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240410   gcc  
riscv                 randconfig-002-20240410   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240410   clang
s390                  randconfig-002-20240410   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240410   gcc  
sh                    randconfig-002-20240410   gcc  
sh                           se7712_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240410   gcc  
sparc64               randconfig-002-20240410   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240410   clang
um                    randconfig-002-20240410   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240410   clang
x86_64       buildonly-randconfig-003-20240410   clang
x86_64       buildonly-randconfig-005-20240410   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240410   clang
x86_64                randconfig-003-20240410   clang
x86_64                randconfig-004-20240410   clang
x86_64                randconfig-006-20240410   clang
x86_64                randconfig-014-20240410   clang
x86_64                randconfig-016-20240410   clang
x86_64                randconfig-072-20240410   clang
x86_64                randconfig-074-20240410   clang
x86_64                randconfig-076-20240410   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240410   gcc  
xtensa                randconfig-002-20240410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

