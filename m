Return-Path: <linux-kernel+bounces-135979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC689CE86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9894B218F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8FF2744B;
	Mon,  8 Apr 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAeMspch"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D756171B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616069; cv=none; b=g+1zVKHekEyFwNdP0GyDdJ63O/kTgoQiHoF+Z4O8eJMOrXgoWUeRcUi2KTiMJE5GwceOYI5HfyYu+OXGGwIbByHVaen0/0vUgZV8cfptr66fTbhsRS8aK2to/BVGijHDvjp2193H7Y4lwubsyerGkhHzATwfat6eiIImSkWU8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616069; c=relaxed/simple;
	bh=0i/1kreiE3c0+vaEQuFrE5fqk3FFjYC8JR7q2a3jxtk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HjTAbC+QHgXRYryp+G/eyNHkZjMywH595KCQDAoN/IrtCrwsWJWh/z86JD0dN7r2a+5MPIvx74EIcssairjrv3sLh2JTnfWcGe048jkdYZxEuMfw9yqp4ApoCVPqIQp8D0g6+xj0ZxS+TwRe0wc3ic6R4UjT7TQKf4fgUPnkpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAeMspch; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712616067; x=1744152067;
  h=date:from:to:cc:subject:message-id;
  bh=0i/1kreiE3c0+vaEQuFrE5fqk3FFjYC8JR7q2a3jxtk=;
  b=jAeMspchKu3rLFX/Al5AYoL0bL4nVcbLEHR9Inom58RZLKPn5z2F0MEz
   nQb6UHkQt92A1kDiLidkS0aNlosXOLRwQr3MJ4J0GytJjZzbGawjYCmHW
   9iWYXVGnnUkqF0QhpZey9KEJXScjajx0Spl+j/zr+AEV9oLQ5ruvyh/cX
   2fT/26xcX6D3mX440uX8L9v10f2uchIHvs7yE+IOHzVKeQUeyBAfPo5si
   3qLa8JO607rx7ofPkZEf+IlwuNJmTXYA17F1NIjmDBruq1QY2JV022E8I
   lT/xGxOqJZwC3I/cw/zgD69902een8eVaxtWL7DbXXxMu33YrEmc3/RVm
   g==;
X-CSE-ConnectionGUID: RkNtz04fQqypSMp7pqjlRg==
X-CSE-MsgGUID: MS1YyCmyRHeqlirOIc72ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19346273"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19346273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 15:41:06 -0700
X-CSE-ConnectionGUID: hDWVqSBLQvioNByEIrOlfw==
X-CSE-MsgGUID: UZww+WLXQIK9unrkDmDpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20080472"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2024 15:41:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtxfi-0005Wm-37;
	Mon, 08 Apr 2024 22:41:02 +0000
Date: Tue, 09 Apr 2024 06:40:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 a2ea3cd78317ae8995b65b52299158bbae52a77f
Message-ID: <202404090646.ii9z9v7O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: a2ea3cd78317ae8995b65b52299158bbae52a77f  irqdomain: Check virq for 0 before use in irq_dispose_mapping()

elapsed time: 721m

configs tested: 186
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
arc                   randconfig-001-20240408   gcc  
arc                   randconfig-002-20240408   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240408   clang
arm                   randconfig-002-20240408   clang
arm                   randconfig-003-20240408   clang
arm                   randconfig-004-20240408   clang
arm                           sunxi_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240408   clang
arm64                 randconfig-002-20240408   clang
arm64                 randconfig-003-20240408   gcc  
arm64                 randconfig-004-20240408   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240408   gcc  
csky                  randconfig-002-20240408   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240408   clang
hexagon               randconfig-002-20240408   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240408   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240408   gcc  
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240408   gcc  
i386         buildonly-randconfig-004-20240408   clang
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240408   clang
i386         buildonly-randconfig-006-20240408   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240408   clang
i386                  randconfig-001-20240409   clang
i386                  randconfig-002-20240408   clang
i386                  randconfig-003-20240408   clang
i386                  randconfig-003-20240409   clang
i386                  randconfig-004-20240408   clang
i386                  randconfig-005-20240408   gcc  
i386                  randconfig-006-20240408   clang
i386                  randconfig-006-20240409   clang
i386                  randconfig-011-20240408   clang
i386                  randconfig-012-20240408   gcc  
i386                  randconfig-012-20240409   clang
i386                  randconfig-013-20240408   clang
i386                  randconfig-013-20240409   clang
i386                  randconfig-014-20240408   gcc  
i386                  randconfig-014-20240409   clang
i386                  randconfig-015-20240408   gcc  
i386                  randconfig-016-20240408   gcc  
i386                  randconfig-016-20240409   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240408   gcc  
loongarch             randconfig-002-20240408   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240408   gcc  
nios2                 randconfig-002-20240408   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240408   gcc  
parisc                randconfig-002-20240408   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240408   gcc  
powerpc               randconfig-002-20240408   clang
powerpc               randconfig-003-20240408   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240408   clang
powerpc64             randconfig-002-20240408   gcc  
powerpc64             randconfig-003-20240408   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240408   clang
riscv                 randconfig-002-20240408   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240408   clang
s390                  randconfig-002-20240408   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240408   gcc  
sh                    randconfig-002-20240408   gcc  
sh                           se7705_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240408   gcc  
sparc64               randconfig-002-20240408   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240408   clang
um                    randconfig-002-20240408   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240409   clang
x86_64       buildonly-randconfig-002-20240409   clang
x86_64       buildonly-randconfig-003-20240409   gcc  
x86_64       buildonly-randconfig-004-20240409   gcc  
x86_64       buildonly-randconfig-005-20240409   clang
x86_64       buildonly-randconfig-006-20240409   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240409   clang
x86_64                randconfig-002-20240409   clang
x86_64                randconfig-003-20240409   gcc  
x86_64                randconfig-004-20240409   gcc  
x86_64                randconfig-005-20240409   clang
x86_64                randconfig-006-20240409   clang
x86_64                randconfig-011-20240409   gcc  
x86_64                randconfig-012-20240409   clang
x86_64                randconfig-013-20240409   gcc  
x86_64                randconfig-014-20240409   clang
x86_64                randconfig-015-20240409   gcc  
x86_64                randconfig-016-20240409   gcc  
x86_64                randconfig-071-20240409   gcc  
x86_64                randconfig-072-20240409   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240408   gcc  
xtensa                randconfig-002-20240408   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

