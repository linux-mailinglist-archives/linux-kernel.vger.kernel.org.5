Return-Path: <linux-kernel+bounces-1833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7081549E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8087C1F25936
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949D48CF9;
	Fri, 15 Dec 2023 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjxMClHA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D648CD5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702683872; x=1734219872;
  h=date:from:to:cc:subject:message-id;
  bh=11oJUcoSj8+AwJLZndHeuHoqp1/tagBP78tIFExaaK4=;
  b=gjxMClHAoJaPOUPXKj/mL/un8Pgzq4t9PCiTvwIo+t/ttaRM38aufYoN
   +rkdGq0mE7RVlKUBh44xHZOZz4zUZgEk+mxoU8H/13fqaVcoePv87lHGY
   b8L7Xva8MZCovznBdZvpYqS2FSPLeEoZEy4Z4srItkcQO9k424KG9ZKP/
   /nhm8gwYr3mFksdK4ww3mM+dAnSpEzQw86nEKfDf2Em5V8W4UG4+le8UO
   URDLrjiJ3guuhe5Hf5hYTthTVxxlB2sviV5kX6AiFbrFH1R2aWPVJnxgv
   nFQliWjzWHBS/r8jV8CHa8ndfbpjEVrlZJC/TO2s19Hiojj92xWfu2cIu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2181734"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2181734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="803866208"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="803866208"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2023 15:44:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEHr1-0000u8-2t;
	Fri, 15 Dec 2023 23:44:27 +0000
Date: Sat, 16 Dec 2023 07:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8
Message-ID: <202312160718.e8oim23U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8  x86/virt/tdx: Make TDX host depend on X86_MCE

elapsed time: 1519m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
csky                             alldefconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231215   clang
i386         buildonly-randconfig-002-20231215   clang
i386         buildonly-randconfig-003-20231215   clang
i386         buildonly-randconfig-004-20231215   clang
i386         buildonly-randconfig-005-20231215   clang
i386         buildonly-randconfig-006-20231215   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231215   clang
i386                  randconfig-002-20231215   clang
i386                  randconfig-003-20231215   clang
i386                  randconfig-004-20231215   clang
i386                  randconfig-005-20231215   clang
i386                  randconfig-006-20231215   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                          malta_defconfig   clang
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

