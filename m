Return-Path: <linux-kernel+bounces-150995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A623A8AA780
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F44B24FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7D79F6;
	Fri, 19 Apr 2024 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM8HsdRR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19B2F29
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498882; cv=none; b=oyGixiveI8eNFyIdndHYrG5+wX8e//bhj5LXCuprTBmvtZRTHpf5mtNjjwWu1KoBj7ELCTzCiW2nPXPe4VADpPVfQ6eoQyrkhG6LwhjR8Tsel2rho/TH60ro2q5ybaZnhcSQqz6sj2EQVR/ZMesQi7J0u34v40ZAvpjLeaP2Y9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498882; c=relaxed/simple;
	bh=2w8qEQEOnoPJc9bCA87sZZP0Z+S/XH+87v7Ml4+FeSk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LVM8tgba0888sB/fisZwKUIsVnY7iSiAzmPUIc9Qdml+16MoWFa64oazTu/iWu4rc6t1zHO8+DvpwiQF6URiG2SKZQZ8d0UwDDNo6IVqfvyFrEFSpcMGy0utRmMJ/CQHYilBXIJnwvzZGfOhFoQeTybpdPclNnYJTdTQQLyy85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SM8HsdRR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713498881; x=1745034881;
  h=date:from:to:cc:subject:message-id;
  bh=2w8qEQEOnoPJc9bCA87sZZP0Z+S/XH+87v7Ml4+FeSk=;
  b=SM8HsdRRG6ztWDtvc9eF05pyPos5DYPrAshQF330QQGFQfKonhDKwIG6
   Quqgbq89tHyy9uJXh6wAlN3jhBlnkBMl73rFE6hItiSEQuP+K8vy4hSXd
   WLk+8WamIs/ThsS+2dQP6hEfmJN7IYkoZVggH7+YOnrkGYoIiSi5U+QqQ
   QWjuGMLsWstmmZa8pcoR2p9Vmj9JBQUGlWxWbWDCkjuiaRb5ihOvDmzBI
   s35KLH6ln3XYKOaQW1fsZYcmmNTYPfPmIfH94so8AC/lOXZQfPV2wBw4L
   Hqwt+cSGkg9Wdc6XwaggxQBAkD9un5F19a5lj+0fM7/yLAPvYHs0lB+uy
   Q==;
X-CSE-ConnectionGUID: JKO6MZDJStipQ9cmG1FOaw==
X-CSE-MsgGUID: v70WW7SCQ6Kw7fUsGXgsmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20227630"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20227630"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 20:54:40 -0700
X-CSE-ConnectionGUID: VkRhSSZ7Tom8rERrUqUh/Q==
X-CSE-MsgGUID: Z+/2Qe1QT/at21mzTGCAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23063868"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 18 Apr 2024 20:54:39 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxfKe-0009ZJ-19;
	Fri, 19 Apr 2024 03:54:36 +0000
Date: Fri, 19 Apr 2024 11:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9543f6e26634537997b6e909c20911b7bf4876de
Message-ID: <202404191150.Ti8SYP95-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9543f6e26634537997b6e909c20911b7bf4876de  x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

elapsed time: 736m

configs tested: 90
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240419   gcc  
arc                   randconfig-002-20240419   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                   randconfig-001-20240419   gcc  
arm                   randconfig-003-20240419   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240419   gcc  
csky                  randconfig-002-20240419   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386                                defconfig   clang
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240419   clang
i386                  randconfig-012-20240419   clang
i386                  randconfig-014-20240419   clang
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240419   gcc  
loongarch             randconfig-002-20240419   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240419   gcc  
nios2                 randconfig-002-20240419   gcc  
parisc                randconfig-001-20240419   gcc  
parisc                randconfig-002-20240419   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240419   gcc  
powerpc               randconfig-002-20240419   gcc  
powerpc               randconfig-003-20240419   gcc  
powerpc64             randconfig-001-20240419   gcc  
powerpc64             randconfig-002-20240419   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-002-20240419   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240419   gcc  
sh                    randconfig-002-20240419   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240419   gcc  
sparc64               randconfig-002-20240419   gcc  
um                               allyesconfig   gcc  
um                    randconfig-001-20240419   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20240419   gcc  
xtensa                randconfig-002-20240419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

