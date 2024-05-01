Return-Path: <linux-kernel+bounces-164994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF18B8626
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DEC283528
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04094D135;
	Wed,  1 May 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gso9D/2F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB54CB4E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548861; cv=none; b=AhHW/P2qXbxEOOARCoYUixy3nRP/Y539ydqx7wQYPepYUUJpVvWtgPDpI5V5m5K1HhB8ZkvuDcN04d8BYP0rAG2WIQ7quM2nd2YcULI8yOvS88Y1ZX3jFSNRwprJX2gTdDUJ4DtiToag2637AZFrHmyc+E58UJ6Ts4oYxg8rIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548861; c=relaxed/simple;
	bh=rMt1LuHyt+Vr+amQbnX6Gr7YtHnz5fHLcZ/NuLIvIwE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZWdcieMWUZE5dS71bSpk1AwvD2qfg11Czqf+jT/ic2NG5X6dpc58gbv6zFXhGhq9jf3pyC0Kb2qJJsJkqiJyl5hZ8L0q/ykDuEopWYGCNnMmaQ1Uc8i5lSKP/jKvh81SfOCHeo8ne+KCHXBagF9adPFXuYdltOnE+ph3luY/lF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gso9D/2F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714548859; x=1746084859;
  h=date:from:to:cc:subject:message-id;
  bh=rMt1LuHyt+Vr+amQbnX6Gr7YtHnz5fHLcZ/NuLIvIwE=;
  b=Gso9D/2F3Il1FWXVpAL+7wcHlgU0nY3pIZwch5ahvrkA7WYK7xWCGNob
   PgOdSEAWzhi8EvdDIugqgHhr3J4wxy1XaqlhOu54jJqJrWdOPku08djUr
   KeV11MTDOAYqN/uQHefZnJAngsWpJM669hsPCc7aARxl9noybf5HLUr+M
   knfo07qJpZ/DlzJi8g6tzkJ9Vj5Tv0k0WsH6w/i4gWYFB4BvW4YfbZ5At
   9Wyk5MrQewzxisBcRJZbigxt2bZHPIvmOq5crSfRIls8uSXN0LCx3Iu2k
   dZfTv7O4VxCd8dkzrm0juFthslUVn46SiXN4ZjNZiIqvpAchK0fZ6vRD6
   w==;
X-CSE-ConnectionGUID: qKC4ubExRumfeDB4VWtGCQ==
X-CSE-MsgGUID: clLLkDpnREi/WuYQnGSvmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20888608"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="20888608"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 00:34:17 -0700
X-CSE-ConnectionGUID: csiejvnySGOf4b5k9lpUSg==
X-CSE-MsgGUID: gAS7bsPDSl6Hvo3Pkuji6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="26720858"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 May 2024 00:34:16 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s24Tm-00095s-0f;
	Wed, 01 May 2024 07:34:14 +0000
Date: Wed, 01 May 2024 15:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c9e1dc9825319392b44d3c22493dc543075933b9
Message-ID: <202405011531.bXARceFO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: c9e1dc9825319392b44d3c22493dc543075933b9  x86/mm: Remove broken vsyscall emulation code from the page fault code

elapsed time: 1521m

configs tested: 173
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240430   gcc  
arc                   randconfig-001-20240501   gcc  
arc                   randconfig-002-20240430   gcc  
arc                   randconfig-002-20240501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-001-20240501   gcc  
arm                   randconfig-002-20240501   gcc  
arm                   randconfig-004-20240501   gcc  
arm                           spitz_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240501   gcc  
arm64                 randconfig-002-20240430   gcc  
arm64                 randconfig-002-20240501   gcc  
arm64                 randconfig-004-20240430   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240430   gcc  
csky                  randconfig-001-20240501   gcc  
csky                  randconfig-002-20240430   gcc  
csky                  randconfig-002-20240501   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240430   gcc  
i386         buildonly-randconfig-002-20240501   gcc  
i386         buildonly-randconfig-003-20240430   gcc  
i386         buildonly-randconfig-004-20240501   gcc  
i386         buildonly-randconfig-005-20240501   gcc  
i386         buildonly-randconfig-006-20240430   gcc  
i386                  randconfig-001-20240501   gcc  
i386                  randconfig-002-20240430   gcc  
i386                  randconfig-003-20240430   gcc  
i386                  randconfig-003-20240501   gcc  
i386                  randconfig-004-20240430   gcc  
i386                  randconfig-004-20240501   gcc  
i386                  randconfig-005-20240430   gcc  
i386                  randconfig-006-20240430   gcc  
i386                  randconfig-011-20240430   gcc  
i386                  randconfig-011-20240501   gcc  
i386                  randconfig-012-20240501   gcc  
i386                  randconfig-013-20240501   gcc  
i386                  randconfig-014-20240430   gcc  
i386                  randconfig-014-20240501   gcc  
i386                  randconfig-015-20240430   gcc  
i386                  randconfig-015-20240501   gcc  
i386                  randconfig-016-20240430   gcc  
i386                  randconfig-016-20240501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240430   gcc  
loongarch             randconfig-001-20240501   gcc  
loongarch             randconfig-002-20240430   gcc  
loongarch             randconfig-002-20240501   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240430   gcc  
nios2                 randconfig-001-20240501   gcc  
nios2                 randconfig-002-20240430   gcc  
nios2                 randconfig-002-20240501   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240430   gcc  
parisc                randconfig-001-20240501   gcc  
parisc                randconfig-002-20240430   gcc  
parisc                randconfig-002-20240501   gcc  
powerpc                          allmodconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240430   gcc  
powerpc               randconfig-002-20240430   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240430   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240430   gcc  
s390                  randconfig-001-20240501   gcc  
s390                  randconfig-002-20240430   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240430   gcc  
sh                    randconfig-001-20240501   gcc  
sh                    randconfig-002-20240430   gcc  
sh                    randconfig-002-20240501   gcc  
sh                           se7721_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240430   gcc  
sparc64               randconfig-001-20240501   gcc  
sparc64               randconfig-002-20240430   gcc  
sparc64               randconfig-002-20240501   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240501   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240430   gcc  
x86_64       buildonly-randconfig-002-20240501   clang
x86_64       buildonly-randconfig-005-20240501   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240430   gcc  
x86_64                randconfig-004-20240430   gcc  
x86_64                randconfig-004-20240501   clang
x86_64                randconfig-005-20240430   gcc  
x86_64                randconfig-005-20240501   clang
x86_64                randconfig-012-20240501   clang
x86_64                randconfig-013-20240430   gcc  
x86_64                randconfig-014-20240501   clang
x86_64                randconfig-015-20240501   clang
x86_64                randconfig-016-20240501   clang
x86_64                randconfig-071-20240501   clang
x86_64                randconfig-072-20240501   clang
x86_64                randconfig-073-20240501   clang
x86_64                randconfig-075-20240430   gcc  
x86_64                randconfig-076-20240501   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240430   gcc  
xtensa                randconfig-001-20240501   gcc  
xtensa                randconfig-002-20240430   gcc  
xtensa                randconfig-002-20240501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

