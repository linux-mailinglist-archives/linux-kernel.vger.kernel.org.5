Return-Path: <linux-kernel+bounces-154428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A248ADBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0203E1F21C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ACD1CA89;
	Tue, 23 Apr 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAVqqF4V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC8182DB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839397; cv=none; b=g0YBdaaqMhtta8k8smhdQKpcLME/VVng2VlxRVezcR4zb2lupZk7lmgeLgAVr38ZWWV9RMW5QDELqLT9zxYXxCyxv71gI/9xUggOmANO8Rma0u1gVsMkpL4Mv/9mRusDfyw7vyxfDIIAtKpzzRYqoA3Yxrp3/VkZ62L4eglfI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839397; c=relaxed/simple;
	bh=sqrJ/9c21yu/9LNxRuCV/MXZ7ImBF/hDWqk+7H2pvws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s1oXsiLY0YKR0MHysYmLxQf5hnnXSiNCA/mqTo2ZZiV3scjMGiEWvNlVdlfLqxRtAsXpIzagcRq55Bn4nSM2LrXJP01xytFXLmXrZg1C+LqIMkzSqe8AnQ46bZ3a1CmG+adYYH2zK4k6FE5/ZiIHkrBn/YuMUUv9kcKwKWQjf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAVqqF4V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839396; x=1745375396;
  h=date:from:to:cc:subject:message-id;
  bh=sqrJ/9c21yu/9LNxRuCV/MXZ7ImBF/hDWqk+7H2pvws=;
  b=eAVqqF4VRsfXyXahxJXvd5dqCFAJ9rm3Gdfd1xAeEcNr0+S0UHI5l8ox
   krLxStNQDuQFe4ZG5ue+JBJ0d0THKgOaiaLl6dtp7O3Vw0/rAZWPFoVqQ
   eRwgy6+nNc4kp2W3WBvMsacxyhpvg+dw2/9ILsy79k2MJAg2Kr1GXqGTb
   FuoePnaInYMU3D2qWWIaxU91PNIK89ip/Je4Ccp7q+WiIpNYr/G0Fr8vP
   W4v1+zlzJkkTWbpLUeWG45LpeYzSZu+YH0pkY9fW95J8mzEnX4ZcWsIHX
   bp4cbtff7aSOTsEbtSbTgboSAZJm/+WLPThI67tr6IoxsWfOaUm4xlWgT
   A==;
X-CSE-ConnectionGUID: EFlnQbDdSPWcx/Ea03jsEg==
X-CSE-MsgGUID: caRgyLJNR6yYj7VR0Ifo7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9235843"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9235843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:29:53 -0700
X-CSE-ConnectionGUID: 8E2FL9CLSFiWInqIear07Q==
X-CSE-MsgGUID: SCiaqA7uSUK8R0cADSN8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28727730"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2024 19:29:51 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz5un-0000PO-24;
	Tue, 23 Apr 2024 02:29:49 +0000
Date: Tue, 23 Apr 2024 10:29:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 1560d1f6eb6b398bddd80c16676776c0325fe5fe
Message-ID: <202404231021.EVandvQd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 1560d1f6eb6b398bddd80c16676776c0325fe5fe  sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()

elapsed time: 905m

configs tested: 200
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240423   gcc  
arc                   randconfig-002-20240423   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240423   clang
arm                   randconfig-002-20240423   clang
arm                   randconfig-003-20240423   clang
arm                   randconfig-004-20240423   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240423   clang
arm64                 randconfig-002-20240423   gcc  
arm64                 randconfig-003-20240423   clang
arm64                 randconfig-004-20240423   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240423   gcc  
csky                  randconfig-002-20240423   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240423   clang
hexagon               randconfig-002-20240423   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240422   clang
i386         buildonly-randconfig-002-20240422   gcc  
i386         buildonly-randconfig-003-20240422   clang
i386         buildonly-randconfig-003-20240423   gcc  
i386         buildonly-randconfig-004-20240422   gcc  
i386         buildonly-randconfig-005-20240422   gcc  
i386         buildonly-randconfig-006-20240422   clang
i386         buildonly-randconfig-006-20240423   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240422   clang
i386                  randconfig-001-20240423   gcc  
i386                  randconfig-002-20240422   clang
i386                  randconfig-002-20240423   gcc  
i386                  randconfig-003-20240422   gcc  
i386                  randconfig-004-20240422   clang
i386                  randconfig-004-20240423   gcc  
i386                  randconfig-005-20240422   gcc  
i386                  randconfig-006-20240422   gcc  
i386                  randconfig-011-20240422   clang
i386                  randconfig-011-20240423   gcc  
i386                  randconfig-012-20240422   clang
i386                  randconfig-013-20240422   clang
i386                  randconfig-014-20240422   clang
i386                  randconfig-014-20240423   gcc  
i386                  randconfig-015-20240422   clang
i386                  randconfig-015-20240423   gcc  
i386                  randconfig-016-20240422   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240423   gcc  
loongarch             randconfig-002-20240423   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240423   gcc  
nios2                 randconfig-002-20240423   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240423   gcc  
parisc                randconfig-002-20240423   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240423   gcc  
powerpc               randconfig-002-20240423   gcc  
powerpc               randconfig-003-20240423   clang
powerpc64             randconfig-001-20240423   gcc  
powerpc64             randconfig-002-20240423   clang
powerpc64             randconfig-003-20240423   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240423   gcc  
riscv                 randconfig-002-20240423   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240423   clang
s390                  randconfig-002-20240423   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240423   gcc  
sh                    randconfig-002-20240423   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240423   gcc  
sparc64               randconfig-002-20240423   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240423   gcc  
um                    randconfig-002-20240423   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240422   clang
x86_64       buildonly-randconfig-002-20240422   gcc  
x86_64       buildonly-randconfig-003-20240422   gcc  
x86_64       buildonly-randconfig-003-20240423   gcc  
x86_64       buildonly-randconfig-004-20240422   clang
x86_64       buildonly-randconfig-004-20240423   gcc  
x86_64       buildonly-randconfig-005-20240422   gcc  
x86_64       buildonly-randconfig-006-20240422   clang
x86_64       buildonly-randconfig-006-20240423   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240422   clang
x86_64                randconfig-002-20240422   gcc  
x86_64                randconfig-002-20240423   gcc  
x86_64                randconfig-003-20240422   clang
x86_64                randconfig-003-20240423   gcc  
x86_64                randconfig-004-20240422   gcc  
x86_64                randconfig-004-20240423   gcc  
x86_64                randconfig-005-20240422   gcc  
x86_64                randconfig-005-20240423   gcc  
x86_64                randconfig-006-20240422   clang
x86_64                randconfig-006-20240423   gcc  
x86_64                randconfig-011-20240422   gcc  
x86_64                randconfig-011-20240423   gcc  
x86_64                randconfig-012-20240422   clang
x86_64                randconfig-012-20240423   gcc  
x86_64                randconfig-013-20240422   gcc  
x86_64                randconfig-014-20240422   clang
x86_64                randconfig-015-20240422   gcc  
x86_64                randconfig-016-20240422   gcc  
x86_64                randconfig-016-20240423   gcc  
x86_64                randconfig-071-20240422   clang
x86_64                randconfig-072-20240422   gcc  
x86_64                randconfig-073-20240422   gcc  
x86_64                randconfig-074-20240422   gcc  
x86_64                randconfig-074-20240423   gcc  
x86_64                randconfig-075-20240422   gcc  
x86_64                randconfig-075-20240423   gcc  
x86_64                randconfig-076-20240422   gcc  
x86_64                randconfig-076-20240423   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-002-20240423   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

