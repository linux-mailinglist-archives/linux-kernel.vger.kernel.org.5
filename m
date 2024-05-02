Return-Path: <linux-kernel+bounces-166926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA308BA222
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292E51F229B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E686181317;
	Thu,  2 May 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wvusyi9X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5B1DDC5
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684683; cv=none; b=mAsSeUQitUIo3ISfi28QSkaSm2cEtg0Kce+uYJLgBYJYcRVMzX54R/XeldFdosxnyXRPU611WsqYkEX+11pJipTnIS0cbL5rguei6ZvvPniBDEBrp5RmytQVe3aaTs3Fs3+9gj8gDh2RYYpakKmNGMuKHNDwb0vYkm02CJ4zDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684683; c=relaxed/simple;
	bh=dcZqNKIqngkYBqah6aNnmOOCYOt9NBiRopxv3hySSTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CLcmd3LGP34CmV8E5DkH1chGMYVAN0PET+gdR+MZOUQScVQ9/f5jWNElf5TuanxcIKVpctQbpZw5uiut0I+wOaRZ2ZdSdt4Nt92GAjqLzBdAiOIjHKKrtFaG4YOAOC5I9T4hxNRcefeQzacT5z6TJfzzLGqw4/FQaZ2UGTx1PEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wvusyi9X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714684681; x=1746220681;
  h=date:from:to:cc:subject:message-id;
  bh=dcZqNKIqngkYBqah6aNnmOOCYOt9NBiRopxv3hySSTs=;
  b=Wvusyi9XcFR7deyYJo0mhpBCc+ueQdxqE2eaHj2RS6zXNBZAeWVIPQ/9
   AxrfjGhandDUZ81cnYAn8kV7RQbMs8BVvus6EWlE4PBZNdvE7jSJlSAEC
   sISVnMYLIaFipBaO0k85Ke1AGQrcMX9pQybFjIH3SzYQhr67k6ySaDk8a
   2/dDWlTaibrEltnt32qHFeC9sQFOwAmyL6TtieHoqGjxcUA+SsHnLEE9k
   kk1Lr107KdDdT5OKuNuLpPoZ76erDFgFlkd3JJo7aVfBKS+hMR8aAkgmm
   53BZK4NyDEyWwbgTa9UJ3mHYC4CKlC3BhduqRjAhb2MTH/aEWx9MJrkbQ
   Q==;
X-CSE-ConnectionGUID: yPqrbYHsTemMmQPHnC7zHw==
X-CSE-MsgGUID: XO5quDt/TeqiDg4isLbTYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10611437"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10611437"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:18:01 -0700
X-CSE-ConnectionGUID: uAXGz6JNR8WUiEG3ZI1l6Q==
X-CSE-MsgGUID: W6+2f+IeTAK3wyuzP9Qumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27335927"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 May 2024 14:17:59 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2doT-000B1N-1p;
	Thu, 02 May 2024 21:17:57 +0000
Date: Fri, 03 May 2024 05:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e7d6f9dff52c43bca09f3b175f0e6dfeadc37760
Message-ID: <202405030520.tcPqxcpl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e7d6f9dff52c43bca09f3b175f0e6dfeadc37760  rcu/nocb: Remove buggy bypass lock contention mitigation

elapsed time: 1457m

configs tested: 174
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
arc                   randconfig-001-20240502   gcc  
arc                   randconfig-002-20240502   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240502   gcc  
arm                   randconfig-002-20240502   gcc  
arm                   randconfig-003-20240502   gcc  
arm                   randconfig-004-20240502   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240502   gcc  
arm64                 randconfig-002-20240502   clang
arm64                 randconfig-003-20240502   clang
arm64                 randconfig-004-20240502   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240502   gcc  
csky                  randconfig-002-20240502   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240502   clang
hexagon               randconfig-002-20240502   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240502   gcc  
i386         buildonly-randconfig-002-20240502   gcc  
i386         buildonly-randconfig-003-20240502   clang
i386         buildonly-randconfig-004-20240502   gcc  
i386         buildonly-randconfig-005-20240502   clang
i386         buildonly-randconfig-006-20240502   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240502   gcc  
i386                  randconfig-002-20240502   clang
i386                  randconfig-003-20240502   clang
i386                  randconfig-004-20240502   gcc  
i386                  randconfig-005-20240502   gcc  
i386                  randconfig-006-20240502   clang
i386                  randconfig-011-20240502   gcc  
i386                  randconfig-012-20240502   clang
i386                  randconfig-013-20240502   clang
i386                  randconfig-014-20240502   gcc  
i386                  randconfig-015-20240502   clang
i386                  randconfig-016-20240502   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240502   gcc  
loongarch             randconfig-002-20240502   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240502   gcc  
nios2                 randconfig-002-20240502   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240502   gcc  
parisc                randconfig-002-20240502   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc               randconfig-001-20240502   clang
powerpc               randconfig-002-20240502   clang
powerpc               randconfig-003-20240502   clang
powerpc64             randconfig-001-20240502   gcc  
powerpc64             randconfig-002-20240502   clang
powerpc64             randconfig-003-20240502   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240502   clang
riscv                 randconfig-002-20240502   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240502   gcc  
s390                  randconfig-002-20240502   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240502   gcc  
sh                    randconfig-002-20240502   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240502   gcc  
sparc64               randconfig-002-20240502   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240502   clang
um                    randconfig-002-20240502   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240502   gcc  
x86_64       buildonly-randconfig-002-20240502   gcc  
x86_64       buildonly-randconfig-003-20240502   clang
x86_64       buildonly-randconfig-004-20240502   gcc  
x86_64       buildonly-randconfig-005-20240502   gcc  
x86_64       buildonly-randconfig-006-20240502   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240502   gcc  
x86_64                randconfig-002-20240502   clang
x86_64                randconfig-003-20240502   clang
x86_64                randconfig-004-20240502   gcc  
x86_64                randconfig-005-20240502   clang
x86_64                randconfig-006-20240502   clang
x86_64                randconfig-011-20240502   clang
x86_64                randconfig-012-20240502   clang
x86_64                randconfig-013-20240502   gcc  
x86_64                randconfig-014-20240502   gcc  
x86_64                randconfig-015-20240502   gcc  
x86_64                randconfig-016-20240502   clang
x86_64                randconfig-071-20240502   gcc  
x86_64                randconfig-072-20240502   gcc  
x86_64                randconfig-073-20240502   gcc  
x86_64                randconfig-074-20240502   clang
x86_64                randconfig-075-20240502   clang
x86_64                randconfig-076-20240502   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240502   gcc  
xtensa                randconfig-002-20240502   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

