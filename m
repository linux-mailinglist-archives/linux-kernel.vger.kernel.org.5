Return-Path: <linux-kernel+bounces-161565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF58B4DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D2D28109E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51038AD5E;
	Sun, 28 Apr 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs5UV3YN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928301C14
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714336853; cv=none; b=MMtqSNuVMo1tpQ4mEjb7gBWXrK51LhcMmsEaRUVdM9k40yRp4wk+ci0O78Pswf7gGSSgtcXt32vVKBP21K5wNpBmzgE4kCWgU09Vo76NVPuskEC1cTLcLuKbtb1sYtrHO7TRy7xQ/u1vUyU/F1YX9ezjrNi+ZFvsVWVgiZehOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714336853; c=relaxed/simple;
	bh=XOfC5S3L4+Lfujli9SmLAl4lPqrUKzSaC9aTQ2pABeo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iT7HB/DeptoMlMAYgA27RdAtvkrOYeoXp/jDvtAw7PxKDOmgf8TVIlugRDthetu0//2rSA4REahVyFHwWBWGpl6NCSLmX1KlVxczP2/2SDCT6FX8Vbq6+FfLrtkUO+X6Vuump/3xybrDds4GyFaClu7XQ3dQjVEDgZYNrElftAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs5UV3YN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714336852; x=1745872852;
  h=date:from:to:cc:subject:message-id;
  bh=XOfC5S3L4+Lfujli9SmLAl4lPqrUKzSaC9aTQ2pABeo=;
  b=Fs5UV3YNPSRWTkmas3Dj5LmUvoDLxQVztxMBj7i5Ps/bpoKU2ipqNnwk
   NGszhoSV/fAVAiLaReb6xjG5a7JnJyrbL53emhG3IXKkCChyamldQ3j7O
   7O5tkss/o/+7KQ4Y2kBKpgMX7AGHQFi/gZYBlawNk1pjMoIfCLfoX53QZ
   2w9xaGxMzH0BBRriKykXSmLsytOm4nqY4yjbEN1d2kgOcXHB8K/LrXPbD
   cudA3OJ2BhTf0NNA5oE9hpLnoctPU2cwaStAqK1t6WU7uiKjPTvqPYI9g
   kf0PD7MebrfiBwBObmBOUymXB1YJ/f0XDxsaiDdbNy5zOP+rIBYGczE76
   g==;
X-CSE-ConnectionGUID: 9HYmF1tVRx6o0QmzKo93qw==
X-CSE-MsgGUID: xTlwzQLMROebv4PKb55KNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13824314"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="13824314"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 13:40:48 -0700
X-CSE-ConnectionGUID: MhOgX9GuSYOT1HqkchFu7Q==
X-CSE-MsgGUID: 6I3n799/TXaYRMtaS+MZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30718197"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Apr 2024 13:40:47 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1BKG-0006jv-0N;
	Sun, 28 Apr 2024 20:40:44 +0000
Date: Mon, 29 Apr 2024 04:40:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0a2f1c12ac1323c78789ca3ff28d2f99447a30c9
Message-ID: <202404290436.MCpYzNoC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0a2f1c12ac1323c78789ca3ff28d2f99447a30c9  Merge branch into tip/master: 'x86/shstk'

elapsed time: 722m

configs tested: 179
configs skipped: 4

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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240428   gcc  
arc                   randconfig-002-20240428   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         nhk8815_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240428   gcc  
arm                   randconfig-002-20240428   clang
arm                   randconfig-003-20240428   clang
arm                   randconfig-004-20240428   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240428   gcc  
arm64                 randconfig-002-20240428   gcc  
arm64                 randconfig-003-20240428   clang
arm64                 randconfig-004-20240428   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240428   gcc  
csky                  randconfig-002-20240428   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240428   clang
hexagon               randconfig-002-20240428   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240428   gcc  
i386         buildonly-randconfig-002-20240428   clang
i386         buildonly-randconfig-003-20240428   clang
i386         buildonly-randconfig-004-20240428   clang
i386         buildonly-randconfig-005-20240428   clang
i386         buildonly-randconfig-006-20240428   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240428   clang
i386                  randconfig-002-20240428   clang
i386                  randconfig-003-20240428   clang
i386                  randconfig-004-20240428   clang
i386                  randconfig-005-20240428   gcc  
i386                  randconfig-006-20240428   gcc  
i386                  randconfig-011-20240428   gcc  
i386                  randconfig-012-20240428   clang
i386                  randconfig-013-20240428   gcc  
i386                  randconfig-014-20240428   gcc  
i386                  randconfig-015-20240428   clang
i386                  randconfig-016-20240428   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240428   gcc  
loongarch             randconfig-002-20240428   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          eyeq5_defconfig   gcc  
mips                     loongson1b_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240428   gcc  
nios2                 randconfig-002-20240428   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240428   gcc  
parisc                randconfig-002-20240428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       maple_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240428   clang
powerpc               randconfig-002-20240428   gcc  
powerpc               randconfig-003-20240428   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     taishan_defconfig   clang
powerpc64             randconfig-001-20240428   gcc  
powerpc64             randconfig-002-20240428   clang
powerpc64             randconfig-003-20240428   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240428   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240428   clang
s390                  randconfig-002-20240428   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240428   gcc  
sh                    randconfig-002-20240428   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240428   gcc  
sparc64               randconfig-002-20240428   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240428   clang
um                    randconfig-002-20240428   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240428   gcc  
x86_64       buildonly-randconfig-002-20240428   clang
x86_64       buildonly-randconfig-003-20240428   gcc  
x86_64       buildonly-randconfig-004-20240428   clang
x86_64       buildonly-randconfig-005-20240428   gcc  
x86_64       buildonly-randconfig-006-20240428   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240428   gcc  
x86_64                randconfig-002-20240428   clang
x86_64                randconfig-003-20240428   gcc  
x86_64                randconfig-004-20240428   clang
x86_64                randconfig-005-20240428   gcc  
x86_64                randconfig-006-20240428   clang
x86_64                randconfig-011-20240428   gcc  
x86_64                randconfig-012-20240428   clang
x86_64                randconfig-013-20240428   gcc  
x86_64                randconfig-014-20240428   clang
x86_64                randconfig-015-20240428   clang
x86_64                randconfig-016-20240428   gcc  
x86_64                randconfig-071-20240428   gcc  
x86_64                randconfig-072-20240428   clang
x86_64                randconfig-073-20240428   gcc  
x86_64                randconfig-074-20240428   gcc  
x86_64                randconfig-075-20240428   clang
x86_64                randconfig-076-20240428   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240428   gcc  
xtensa                randconfig-002-20240428   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

