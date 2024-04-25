Return-Path: <linux-kernel+bounces-158785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADF8B24E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948911C218FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BE14A638;
	Thu, 25 Apr 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIM8cn2i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D637152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058285; cv=none; b=lKTZGCfmBH4qKR4wSexEdrMI41WrO0a0EyE0ZUtM1zcZQXTtkbu8SWW7gBieG9IEuZWBqKLowgInAToZlMpKElPRoAiji9Ioy1I4agKBJPN84rroKco5vPuO1Q1R+flTFzEsDEvgVSBpDVul8MS6n2MrZJDWh972VqayNnS9ccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058285; c=relaxed/simple;
	bh=xo4yL34fTU4Y0vY9rS/rSIWj2OIPBwIeOaqTSAc/hik=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JHT5AYKN7sTINf/q4AVnAb+GaRUWhRlQuYooBjrSXS8r35SxW2NydQYzZPUX2LaBYpVCfrcK66HB4AWihmta+KOxsd16s2ZtDLshG/6msqzmhumBRnvALAOezZDloD3NdstVRFwrXZuWQkoFcrzyG1jitgydUwMyTnq4n3659gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIM8cn2i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714058284; x=1745594284;
  h=date:from:to:cc:subject:message-id;
  bh=xo4yL34fTU4Y0vY9rS/rSIWj2OIPBwIeOaqTSAc/hik=;
  b=iIM8cn2iDnz7VmdWbDmAEO1t7PTiaKIHlGtRNlpmrc+CWYaWZdw05h+1
   FMeVLQBPtPmo3ZQAeEXlL+AQTkZJcFqejRPmxutme8ZgQ8mFzWfeElnj9
   e2IgNeGAvGx6G/Rr+ualfiQOyMdM7I9GebEGmzbLhYemWLzN7KTtXtWX/
   kzzfzeBA5zg/cIRhEF+m/u2l2AhOLDWdYxFZi8LFUBYP9tRstNUUMUywy
   a3jLpC9e9MYt00vpx+WpuQIqUwtLeGK/9+i1PoMfhCbsiAMUm0TKgAtl9
   bvyWaDB8CeY7RuxF3xbO7i0zM5q3qe+7u+5MKcaMScLK1tW2jihMXh9IH
   Q==;
X-CSE-ConnectionGUID: WRRpokXOTw6M4mcSnWLDzw==
X-CSE-MsgGUID: ACS9ZNKlStOmfXnRz16Xqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27209694"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="27209694"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:18:03 -0700
X-CSE-ConnectionGUID: P0LA64zRT2qg6IEWMhUmYA==
X-CSE-MsgGUID: a65QegBnRdOfiu5mDbMpag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25591611"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2024 08:18:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s00rH-0002Uk-1o;
	Thu, 25 Apr 2024 15:17:59 +0000
Date: Thu, 25 Apr 2024 23:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 279d33d155a7e5eb5a996edeb162bd33b1ea709b
Message-ID: <202404252320.R7uECheb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 279d33d155a7e5eb5a996edeb162bd33b1ea709b  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1728m

configs tested: 115
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240425   gcc  
arc                   randconfig-002-20240425   gcc  
arm                               allnoconfig   clang
arm                         assabet_defconfig   clang
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240425   clang
arm                   randconfig-002-20240425   clang
arm                   randconfig-003-20240425   clang
arm                   randconfig-004-20240425   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240425   gcc  
arm64                 randconfig-002-20240425   gcc  
arm64                 randconfig-003-20240425   gcc  
arm64                 randconfig-004-20240425   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240425   gcc  
csky                  randconfig-002-20240425   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240425   clang
hexagon               randconfig-002-20240425   clang
i386         buildonly-randconfig-001-20240425   gcc  
i386         buildonly-randconfig-002-20240425   clang
i386         buildonly-randconfig-003-20240425   gcc  
i386         buildonly-randconfig-004-20240425   clang
i386         buildonly-randconfig-005-20240425   clang
i386         buildonly-randconfig-006-20240425   gcc  
i386                  randconfig-001-20240425   clang
i386                  randconfig-002-20240425   clang
i386                  randconfig-003-20240425   clang
i386                  randconfig-004-20240425   gcc  
i386                  randconfig-005-20240425   clang
i386                  randconfig-006-20240425   clang
i386                  randconfig-011-20240425   clang
i386                  randconfig-012-20240425   clang
i386                  randconfig-013-20240425   gcc  
i386                  randconfig-014-20240425   gcc  
i386                  randconfig-015-20240425   gcc  
i386                  randconfig-016-20240425   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240425   gcc  
loongarch             randconfig-002-20240425   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240425   gcc  
nios2                 randconfig-002-20240425   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240425   gcc  
parisc                randconfig-002-20240425   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc               randconfig-001-20240425   gcc  
powerpc                     sequoia_defconfig   clang
powerpc                     stx_gp3_defconfig   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                              defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

