Return-Path: <linux-kernel+bounces-165380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BA8B8C00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E771BB22709
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C65433A8;
	Wed,  1 May 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSa+/JrM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AC14012
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574366; cv=none; b=J34r+Api9JnkPuExEsgmp8X8wrr9i4Npj58vvrY0vzZx8c6hzTYerM00fA7xY1I3IAwEaB0Xteyp+IGLhhlHz7AKd2MVNUKKKBGCS4iyiK0+RQcb2NOOfW4R7XkM4jE2vlItsHokux2yEfEjnEZikIf07JUu/vfAsaKh9yUAAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574366; c=relaxed/simple;
	bh=/UZnT0z85tWgBd5Kz0mfYyvJ9YRBdTpMuijTSkELqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JbiU74rjBrpDKMNuAatsYa8XIHtiYmhSc8vV38MZIllNEUUpWMPzJLr9j1XgaCX6419ExV23bQjzcpyHaXJ8/l6pmexZgtM6b69QghCjdz8r2bLRBu4hsf3rBDZsK/Fz5Ds7+2D+MklyTfNmK3klmoe6xpnTyjVMxskO/pnvDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSa+/JrM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714574364; x=1746110364;
  h=date:from:to:cc:subject:message-id;
  bh=/UZnT0z85tWgBd5Kz0mfYyvJ9YRBdTpMuijTSkELqNQ=;
  b=WSa+/JrMEPoXdozFGe216Achr6T5YuXxeSI2+Y1+6QOED5JhHZKYA36+
   MrerY7WkJLxgRIrg0+O2fSD4x7RmrLzFraZXP7fXUe57L6hBvRBggzNku
   BfQaeqF1rZXCJCcNZEdjRzVo6xTAUAMGUZsZpjnMG0h+jGnmoV6wcpS26
   rMC1RbOElQsXnn1V59pfKXyHuiolvL/OH1PyjwjFiMVtUrqg50XCPTzq4
   CCJ6NUg/Oh49fvL2wrqZPPg5snZoYIIjyB2dVurEZDr2f3XQzt3NsZ2Z4
   aCbtSIGzGKV8/8HtNJkyFEhVSwpUc8qnet+PMchAXwlo6xK+LwlFrm8nK
   Q==;
X-CSE-ConnectionGUID: zgLdG6YuTE6YfTgBnJHtdg==
X-CSE-MsgGUID: r6gh82xsS5+GnT7Uu5DUqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="27827289"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="27827289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 07:39:24 -0700
X-CSE-ConnectionGUID: YsZQgI98SEOTz50ue6YPng==
X-CSE-MsgGUID: nxbfQZdVQWGjwgCFMw2lMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="26880178"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 May 2024 07:39:23 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2B7A-0009cW-26;
	Wed, 01 May 2024 14:39:20 +0000
Date: Wed, 01 May 2024 22:38:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/irq] BUILD SUCCESS
 ed1e48ea43703002dc202ac7f3b0b0b9981ec2f0
Message-ID: <202405012234.PUHvs9PX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq
branch HEAD: ed1e48ea43703002dc202ac7f3b0b0b9981ec2f0  iommu/vt-d: Enable posted mode for device MSIs

elapsed time: 1509m

configs tested: 146
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
arc                   randconfig-001-20240501   gcc  
arc                   randconfig-002-20240501   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240501   gcc  
arm                   randconfig-002-20240501   gcc  
arm                   randconfig-004-20240501   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240501   gcc  
arm64                 randconfig-002-20240501   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240501   gcc  
csky                  randconfig-002-20240501   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240501   gcc  
i386         buildonly-randconfig-004-20240501   gcc  
i386         buildonly-randconfig-005-20240501   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240501   gcc  
i386                  randconfig-003-20240501   gcc  
i386                  randconfig-004-20240501   gcc  
i386                  randconfig-011-20240501   gcc  
i386                  randconfig-012-20240501   gcc  
i386                  randconfig-013-20240501   gcc  
i386                  randconfig-014-20240501   gcc  
i386                  randconfig-015-20240501   gcc  
i386                  randconfig-016-20240501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240501   gcc  
loongarch             randconfig-002-20240501   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240501   gcc  
nios2                 randconfig-002-20240501   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240501   gcc  
parisc                randconfig-002-20240501   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240501   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240501   gcc  
sh                    randconfig-002-20240501   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240501   gcc  
sparc64               randconfig-002-20240501   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240501   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240501   gcc  
x86_64       buildonly-randconfig-003-20240501   gcc  
x86_64       buildonly-randconfig-004-20240501   gcc  
x86_64       buildonly-randconfig-006-20240501   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240501   gcc  
x86_64                randconfig-002-20240501   gcc  
x86_64                randconfig-003-20240501   gcc  
x86_64                randconfig-006-20240501   gcc  
x86_64                randconfig-011-20240501   gcc  
x86_64                randconfig-013-20240501   gcc  
x86_64                randconfig-074-20240501   gcc  
x86_64                randconfig-075-20240501   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240501   gcc  
xtensa                randconfig-002-20240501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

