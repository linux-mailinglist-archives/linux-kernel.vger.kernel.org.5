Return-Path: <linux-kernel+bounces-132975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4589899CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5B284734
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B123EA90;
	Fri,  5 Apr 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVKcOfSP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95D16D308
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319470; cv=none; b=LvSEmKdACGx/1gLnziaIpPt6h0Ct3lQwEhKfs0Oo7yHDV/7C9JV0jaBuHca20aJuJwQmWke6Wixy8qs+NAnjvfKoeA4ybZS6gOZ7otWoUbkInX9qIPsCiH0M388kdQWENThfZIHiHNHhxbeqozOGPtdr7hBYeDiBlv1AsU5mREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319470; c=relaxed/simple;
	bh=iATkgjs+STBAZ4Y/cW+c6jfWesZL1R43sDcR9hnw9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YkPzQOyNm6XzCrvbRtqCjkLwVWIGljSJhHQlnqK58p5fSQOHJ5wGL9b49ZXri1dCjCZdDSyOejs8N6OXzfXKC+d8EfhpBCQ+U/7Ng+z78br7mL7ahcqgsYI7CBNoAkQzwv8UKoA4c+GNaWrpMNCnipFcciHpoDoTuAIj0UG6DDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVKcOfSP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712319466; x=1743855466;
  h=date:from:to:cc:subject:message-id;
  bh=iATkgjs+STBAZ4Y/cW+c6jfWesZL1R43sDcR9hnw9Ug=;
  b=IVKcOfSPEixDillvk4sfAHCzdeKN3Kjc2uYwjpOg7P+YYVfCcIrX38CO
   o9onZfVo2QIK9Fjjs+WbHPQeyK41JfisO6j0a8ICck5wSYybM3A3bANGz
   MAhksoxd/XP2+y5FzEffuRrULzxqoo/P2+j4Xw2nK38dvBOju8XAFqie7
   +vxV0UvL1XKcBDEmHaWUuVitqDKqmZNDSc370FBi/aSGMvkEHfVoCatzu
   NopKpnDpIbIojgg3rjVCamxj014gSNajik2iohQhCTfCKr6sot70gik5L
   vlxSWHriehVmdT6IKiayXhW7UsSRmEn+6j3txxDY1liBPl+gZlk8zRlQq
   w==;
X-CSE-ConnectionGUID: gHSExMC2TuSItIoItxjP+Q==
X-CSE-MsgGUID: b8KKfgzJRniSXxfXU25QOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25155698"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="25155698"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 05:17:45 -0700
X-CSE-ConnectionGUID: I4qF4BuGQVyD2WEy63NgLA==
X-CSE-MsgGUID: STA5AfDqQrieIb+RY7jeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19248668"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Apr 2024 05:17:43 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsiVp-0002FQ-1w;
	Fri, 05 Apr 2024 12:17:41 +0000
Date: Fri, 05 Apr 2024 20:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 3ddf944b32f88741c303f0b21459dbb3872b8bc5
Message-ID: <202404052034.DOMGHz02-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 3ddf944b32f88741c303f0b21459dbb3872b8bc5  x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

elapsed time: 1221m

configs tested: 179
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
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-002-20240405   clang
arm                   randconfig-003-20240405   gcc  
arm                   randconfig-004-20240405   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240405   clang
hexagon               randconfig-002-20240405   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240405   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc               randconfig-001-20240405   clang
powerpc               randconfig-002-20240405   clang
powerpc               randconfig-003-20240405   clang
powerpc                     redwood_defconfig   clang
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240405   gcc  
powerpc64             randconfig-003-20240405   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240405   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240405   clang
s390                  randconfig-002-20240405   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240405   gcc  
sh                           se7712_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240405   gcc  
um                    randconfig-002-20240405   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240405   clang
x86_64       buildonly-randconfig-002-20240405   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240405   clang
x86_64       buildonly-randconfig-006-20240405   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240405   clang
x86_64                randconfig-002-20240405   clang
x86_64                randconfig-003-20240405   clang
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240405   clang
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240405   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240405   clang
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240405   gcc  
xtensa                randconfig-002-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

