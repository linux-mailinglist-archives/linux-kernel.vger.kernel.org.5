Return-Path: <linux-kernel+bounces-143680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB88A3C40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47321F2187F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3252AF10;
	Sat, 13 Apr 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAbSsBqP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460C101CA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004617; cv=none; b=MIbVURbXmPFSTmssW1ztkuhYw0MvhxSylCuDYQ4zBd6O+HaktTYC7eZTiDHM80A4iL+wBT5WfvDAZVKVDH7JbkxDewYrXZ6Me4DhKue53U9rNiJnLsdGFoNnF5Li56m8fDTVwavtLWF/yMr5zEB78DP0jdAwsvcmWl10fnIuVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004617; c=relaxed/simple;
	bh=Vbl8NwtslfKDzzVSAmZPtnbCa+L31bsL/TFwdt/b5eI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PwNg6AU1h7ZSUcdfC+gN3BZW4qcmm4IcJxAleMAliXsqz0ZGJhjiLGrimHZvX59i0uw2HEuD/SFa2NKxckaGQVc4+6vzRf8o/B1RPWamVCf1TubPKxiwBSQ4EdoHTsNzygoIdVu47MnNAu1NPJ2B6dEKWX0ao5yrjGnvsiOlBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAbSsBqP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713004615; x=1744540615;
  h=date:from:to:cc:subject:message-id;
  bh=Vbl8NwtslfKDzzVSAmZPtnbCa+L31bsL/TFwdt/b5eI=;
  b=KAbSsBqPoCS0sxMGWsTzJkELAfcvm5lxZmk3M+1L495bRdfpRnJnJcgX
   UMihxlSxU31BGynF+LnQdzTvcALc6pFb6wMKIphzQtxR4hu4FSJEXnpui
   1suOTHWOw76awO/kHATSKwnVGYP6W+R08dw7RfYHlvA9WVeKGmybppgNB
   R/9GttwY87IeRaO+Rm5VdKaEBTviO1pE47TUB+zBPVAACdmlUxyoNNEau
   3yHFsVky5QAiswioDayt8WfvHnyaZEUbdKzaT3FFlO6yAoGe86jG6w9Yx
   iCjNzxJGki1Jshx0pXG9+xjWk1IvyR1jBFRajiR0F98DoNMfpg/5oIWXo
   w==;
X-CSE-ConnectionGUID: Gd2E4JPtR86obPd1WdVzsQ==
X-CSE-MsgGUID: rXSYbT83RyGpwFBPEqjH2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19849535"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="19849535"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 03:36:54 -0700
X-CSE-ConnectionGUID: CvoefIq+Rr6ckNL8X9WdnQ==
X-CSE-MsgGUID: xDykJHwjQsqhnUtZbcS0fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="21389167"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 13 Apr 2024 03:36:53 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvakc-0002Hl-1b;
	Sat, 13 Apr 2024 10:36:50 +0000
Date: Sat, 13 Apr 2024 18:36:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7211274fe0ee352332255e41ab5e628b86e83994
Message-ID: <202404131843.22MHDUfx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7211274fe0ee352332255e41ab5e628b86e83994  x86/cpu/amd: Move TOPOEXT enablement into the topology parser

elapsed time: 1448m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

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
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-002-20240412   clang
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240412   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-004-20240412   gcc  
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-005-20240412   gcc  
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-006-20240412   gcc  
i386         buildonly-randconfig-006-20240413   clang
i386                                defconfig   clang
i386                  randconfig-001-20240412   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240412   gcc  
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-003-20240412   clang
i386                  randconfig-003-20240413   clang
i386                  randconfig-004-20240412   clang
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-005-20240412   clang
i386                  randconfig-005-20240413   clang
i386                  randconfig-006-20240412   gcc  
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240412   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
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
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240413   clang
powerpc               randconfig-002-20240413   clang
powerpc               randconfig-003-20240413   clang
powerpc64             randconfig-001-20240413   clang
powerpc64             randconfig-002-20240413   gcc  
powerpc64             randconfig-003-20240413   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
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
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240413   gcc  
xtensa                randconfig-002-20240413   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

