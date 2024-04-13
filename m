Return-Path: <linux-kernel+bounces-143681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4A8A3C41
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B80D282A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACF2110B;
	Sat, 13 Apr 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXVMGpN/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E8101CA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004676; cv=none; b=o+ffdUnb8mrOcigZiz7/JYHVoCzre59vNJgULbUISA8U+TCXBlIQABxFA5LNhUjkjz1qJAVhgPzkl7ClmpEPHQbZYE5zDqg0Nk72BJ7KaO2Oz4qGGyqzYvyxn34mTu8CDEStkSORd3SEN1LpVdkI2C3RNThBeQaY5DacdA4nFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004676; c=relaxed/simple;
	bh=AUxB1B/RBKNvrSdnOQZoKxlH9Rxki77JyRZNbRAOqe4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tkPe/fZExrVm9otF35cyn8oZSkHm5QgycghXFIs9uznd4mO2huqNM7pRQIOK7C9J2+pqGLk/3y7rLRojCW7Tvie9mkWtMS60vTw4sF1tAvVG6glTgpKjFIyxuB/pHOZWElKpkn2+QfOehAnDc7L83TlOlZEOx3Y0oYNdKySxoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXVMGpN/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713004675; x=1744540675;
  h=date:from:to:cc:subject:message-id;
  bh=AUxB1B/RBKNvrSdnOQZoKxlH9Rxki77JyRZNbRAOqe4=;
  b=AXVMGpN/A7DQ2VoBnRm6Cx8U9vX8sunTk2IzBlE6puWESB+dPMfv45lG
   FlccsIVgOKiD+Wik++wByeRr6M5vis3npFiiLKikQZfNSMLlKkGFmgT1q
   rFGVkk9EPdBUQt1EZsGC+pBr4+39UoTJslRgWI1QE7HlwjazLG4kqBuzR
   iEgEtWF7hzGkcBIToXBDsKVcYYCk27vzeH7AtebbBjhCDfpWFUkokJrWI
   ZELwz66dGg7ePHieOGO7794hmhEWctwvsSXlduIukfPzzCOaB2XKrihSi
   57KbTAXn9Rn0pSkdzwAH3z0+HcSd4VPQzOBvWxx+f7Oulo+IIGiW+ZkIn
   A==;
X-CSE-ConnectionGUID: o22miTN+TFW7agG1+vBewg==
X-CSE-MsgGUID: h2dLPdnaRzG2yukPcVPeyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="9008528"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="9008528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 03:37:54 -0700
X-CSE-ConnectionGUID: cvwH6VcGRSO4p1IY907ksg==
X-CSE-MsgGUID: 3nC7f1VlRgm1eT99cpcUAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="25888852"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Apr 2024 03:37:54 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvala-0002IQ-2i;
	Sat, 13 Apr 2024 10:37:50 +0000
Date: Sat, 13 Apr 2024 18:37:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS WITH WARNING
 93d3fde7fd19c2e2cde7220e7986f9a75e9c5680
Message-ID: <202404131827.W2EZQ91b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 93d3fde7fd19c2e2cde7220e7986f9a75e9c5680  perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static inlines

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404122021.kE3qOoZo-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/events/core.c:9596:12: warning: 'perf_event_set_bpf_handler' defined but not used [-Wunused-function]
kernel/events/core.c:9634:13: warning: 'perf_event_free_bpf_handler' defined but not used [-Wunused-function]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- kernel-events-core.c:warning:perf_event_free_bpf_handler-defined-but-not-used
|   `-- kernel-events-core.c:warning:perf_event_set_bpf_handler-defined-but-not-used
|-- alpha-randconfig-r111-20240413
|   |-- kernel-events-core.c:warning:perf_event_free_bpf_handler-defined-but-not-used
|   `-- kernel-events-core.c:warning:perf_event_set_bpf_handler-defined-but-not-used
|-- arm64-defconfig
|   |-- kernel-events-core.c:warning:perf_event_free_bpf_handler-defined-but-not-used
|   `-- kernel-events-core.c:warning:perf_event_set_bpf_handler-defined-but-not-used
|-- s390-randconfig-001-20240413
|   |-- kernel-events-core.c:warning:perf_event_free_bpf_handler-defined-but-not-used
|   `-- kernel-events-core.c:warning:perf_event_set_bpf_handler-defined-but-not-used
`-- x86_64-buildonly-randconfig-002-20240413
    |-- kernel-events-core.c:warning:perf_event_free_bpf_handler-defined-but-not-used
    `-- kernel-events-core.c:warning:perf_event_set_bpf_handler-defined-but-not-used

elapsed time: 1449m

configs tested: 148
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240413   gcc  
arc                   randconfig-002-20240413   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240413   clang
arm                   randconfig-002-20240413   gcc  
arm                   randconfig-003-20240413   clang
arm                   randconfig-004-20240413   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240413   clang
arm64                 randconfig-002-20240413   clang
arm64                 randconfig-003-20240413   clang
arm64                 randconfig-004-20240413   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240413   gcc  
csky                  randconfig-002-20240413   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240413   clang
hexagon               randconfig-002-20240413   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240412   gcc  
i386         buildonly-randconfig-002-20240412   clang
i386         buildonly-randconfig-003-20240412   gcc  
i386         buildonly-randconfig-004-20240412   gcc  
i386         buildonly-randconfig-005-20240412   gcc  
i386         buildonly-randconfig-006-20240412   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240412   clang
i386                  randconfig-002-20240412   gcc  
i386                  randconfig-003-20240412   clang
i386                  randconfig-004-20240412   clang
i386                  randconfig-005-20240412   clang
i386                  randconfig-006-20240412   gcc  
i386                  randconfig-011-20240412   clang
i386                  randconfig-012-20240412   gcc  
i386                  randconfig-013-20240412   clang
i386                  randconfig-014-20240412   gcc  
i386                  randconfig-015-20240412   gcc  
i386                  randconfig-016-20240412   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240413   gcc  
loongarch             randconfig-002-20240413   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240413   gcc  
nios2                 randconfig-002-20240413   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240413   gcc  
parisc                randconfig-002-20240413   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240413   clang
powerpc               randconfig-002-20240413   clang
powerpc               randconfig-003-20240413   clang
powerpc64             randconfig-001-20240413   clang
powerpc64             randconfig-002-20240413   gcc  
powerpc64             randconfig-003-20240413   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240413   clang
riscv                 randconfig-002-20240413   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240413   gcc  
s390                  randconfig-002-20240413   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240413   gcc  
sh                    randconfig-002-20240413   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240413   gcc  
sparc64               randconfig-002-20240413   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240413   clang
um                    randconfig-002-20240413   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240413   gcc  
x86_64       buildonly-randconfig-002-20240413   gcc  
x86_64       buildonly-randconfig-003-20240413   gcc  
x86_64       buildonly-randconfig-004-20240413   gcc  
x86_64       buildonly-randconfig-005-20240413   gcc  
x86_64       buildonly-randconfig-006-20240413   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240413   gcc  
x86_64                randconfig-002-20240413   gcc  
x86_64                randconfig-003-20240413   gcc  
x86_64                randconfig-004-20240413   gcc  
x86_64                randconfig-005-20240413   gcc  
x86_64                randconfig-006-20240413   gcc  
x86_64                randconfig-011-20240413   clang
x86_64                randconfig-012-20240413   clang
x86_64                randconfig-013-20240413   clang
x86_64                randconfig-014-20240413   clang
x86_64                randconfig-015-20240413   gcc  
x86_64                randconfig-016-20240413   clang
x86_64                randconfig-071-20240413   gcc  
x86_64                randconfig-072-20240413   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240413   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

