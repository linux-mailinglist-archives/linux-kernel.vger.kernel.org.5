Return-Path: <linux-kernel+bounces-158420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AED8B1FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A61C21970
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647B23746;
	Thu, 25 Apr 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYAdT0Ew"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79501EB3E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042918; cv=none; b=i4cN4fDe0CTCyjDd5pQtAsXeWqR4kenCI1sl0FSQ0tRYyZN54zrr/arJXCtLtKTuXm/OWhc2dIqkZ7P6oA1EloH1MJ4fJHPyPEtbXCFYpGnWYBjWnAwuNVpjyfUmX6gd0881QG1NET1aRY6yFIlTYb+6a5ugNv7JLjebBs6HfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042918; c=relaxed/simple;
	bh=J8JNHH5jxuyS3NlCBc/iWMwx7Bvw3C4Sv3E+pZUfzVQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M+BcbK/MdqPF97XY2X+XVIsPm7U8JHF2AUMgJlu8UU/mfzFyrIqrQpnRvFbCmiYDcRYlg0BjkYVoX5zQ2/p1SzKdfZQc0PN/ooLeQ/J71j+IQooXsLIroSmC12LV9bwERWdWkynjbQ8Eswblca1gl23KocJA3pM0k1ukn0r/MXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYAdT0Ew; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714042917; x=1745578917;
  h=date:from:to:cc:subject:message-id;
  bh=J8JNHH5jxuyS3NlCBc/iWMwx7Bvw3C4Sv3E+pZUfzVQ=;
  b=IYAdT0Ewe3713HWNJtb6snAQ+0kaB56aG4aRO02z0kTGAd6/WHZK+AnY
   98gAwuT7+I+v0wITtgYcYBZ4m23gov3KnbhL8dBkxBplo7jKIDyOB13r2
   LXfSIrY9qCB1vi/rNsP7/6k6R5u5eEi3CgZ2kY5VaFJLJsD5UlnMjmq05
   3MXYPmF19vueDvZTRONYz8Sz8fx8RnDABD16FwpSfw4eBYmoayLGGCde9
   RocxzwwMEIVlZNEQqd1LuxggwirS32cKyxuWBZYL7wGG/yoSKb5wTetCx
   FQQXSfbuTKW0fatTvssQIlbn4/U/gKNjPgsopZOyQR+3uoia2SAXyjlAI
   A==;
X-CSE-ConnectionGUID: xqrTmsTJTDSp+onrbLFQew==
X-CSE-MsgGUID: ogaglKwRR/K4BQyTNBf/HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9878448"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9878448"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:01:56 -0700
X-CSE-ConnectionGUID: SzBdKnc2Suul4vBClPjZeA==
X-CSE-MsgGUID: +NsRQa/NReuEfm2rbWdUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29825921"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Apr 2024 04:01:55 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzwrQ-0002Hp-1U;
	Thu, 25 Apr 2024 11:01:52 +0000
Date: Thu, 25 Apr 2024 19:01:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 97450eb909658573dcacc1063b06d3d08642c0c1
Message-ID: <202404251941.JCTGaWJs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 97450eb909658573dcacc1063b06d3d08642c0c1  sched/pelt: Remove shift of thermal clock

elapsed time: 1473m

configs tested: 150
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
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
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

