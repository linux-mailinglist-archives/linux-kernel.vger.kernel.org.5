Return-Path: <linux-kernel+bounces-8781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719581BC24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F801F25EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969236094;
	Thu, 21 Dec 2023 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLt0Lq0u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AD58221
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703176463; x=1734712463;
  h=date:from:to:cc:subject:message-id;
  bh=M0Sp/DaQmYqTCOYqw/V/YgCpz1XDrypqFPzzzp2q3sU=;
  b=hLt0Lq0uLqisCkwNIQoyyZHuEKdvl98t6n1TnVrw5sbQ7Sm5kY6ZOb+g
   JuR7KnCLhibQArzlcag7G7h+AdlMYzacZZOWOTLv45mQTPRMGEBw8ZbyL
   uv7AHTbQ+wD7pAWj3z7Jk+au7wyCkMjT3VSnlX7bzuahX5Ein9xpdjWSt
   ALWZ2Wjzf8jBIXSMiTJErS13GEzLKgYXlfSydOmnqf2l326WqiVfKPdJ1
   l88qMIJExdyGBo80EgS5Q+W5vkzs2IdP5DE/iMkp9/2p9YpNK8EdTL79/
   HTkuKbJmT/Zd+rJdMLIgKwRE97aDGwtiTPD+SE1Yqz5tqXtU82ESDcwfH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17553882"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="17553882"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="11170817"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Dec 2023 08:34:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGLyw-0008U3-1y;
	Thu, 21 Dec 2023 16:33:19 +0000
Date: Fri, 22 Dec 2023 00:27:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
Message-ID: <202312220034.IGjnLtDQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5  timers: Fix nextevt calculation when no timers are pending

elapsed time: 1473m

configs tested: 149
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
arc                   randconfig-001-20231221   gcc  
arc                   randconfig-002-20231221   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   clang
arm                       spear13xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231221   gcc  
csky                  randconfig-002-20231221   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231221   clang
i386         buildonly-randconfig-002-20231221   clang
i386         buildonly-randconfig-003-20231221   clang
i386         buildonly-randconfig-004-20231221   clang
i386         buildonly-randconfig-005-20231221   clang
i386         buildonly-randconfig-006-20231221   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231221   clang
i386                  randconfig-002-20231221   clang
i386                  randconfig-003-20231221   clang
i386                  randconfig-004-20231221   clang
i386                  randconfig-005-20231221   clang
i386                  randconfig-006-20231221   clang
i386                  randconfig-011-20231221   gcc  
i386                  randconfig-012-20231221   gcc  
i386                  randconfig-013-20231221   gcc  
i386                  randconfig-014-20231221   gcc  
i386                  randconfig-015-20231221   gcc  
i386                  randconfig-016-20231221   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231221   gcc  
loongarch             randconfig-002-20231221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        maltaup_defconfig   clang
mips                      pic32mzda_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231221   gcc  
nios2                 randconfig-002-20231221   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231221   gcc  
parisc                randconfig-002-20231221   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231221   gcc  
s390                  randconfig-002-20231221   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231221   gcc  
sh                    randconfig-002-20231221   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231221   gcc  
sparc64               randconfig-002-20231221   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231221   clang
x86_64       buildonly-randconfig-002-20231221   clang
x86_64       buildonly-randconfig-003-20231221   clang
x86_64       buildonly-randconfig-004-20231221   clang
x86_64       buildonly-randconfig-005-20231221   clang
x86_64       buildonly-randconfig-006-20231221   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231221   clang
x86_64                randconfig-012-20231221   clang
x86_64                randconfig-013-20231221   clang
x86_64                randconfig-014-20231221   clang
x86_64                randconfig-015-20231221   clang
x86_64                randconfig-016-20231221   clang
x86_64                randconfig-071-20231221   clang
x86_64                randconfig-072-20231221   clang
x86_64                randconfig-073-20231221   clang
x86_64                randconfig-074-20231221   clang
x86_64                randconfig-075-20231221   clang
x86_64                randconfig-076-20231221   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231221   gcc  
xtensa                randconfig-002-20231221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

