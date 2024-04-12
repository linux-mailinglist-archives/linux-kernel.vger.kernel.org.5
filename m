Return-Path: <linux-kernel+bounces-142171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8558A286D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5971C23C41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2E4CDF9;
	Fri, 12 Apr 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1nV32DV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32372C683
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907879; cv=none; b=aOKHX4sLrHcymSsgMn1d4XAzUXAZukBeBJOw/k3EdVqGE/v835uSgEcYgTayyYKO8jR4pyR/XnROVIusOoKq//Y5W3lqqeIKIEWPPml/OrqciQzPlIs0IaME8CRoa5xy4VqLoQOGEBStbhEXSj3W//Ic07gWd+ctWNb3iifQ1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907879; c=relaxed/simple;
	bh=ghTkgrOk/ahJP9DFKGx5Q4jgJn6AK7ro0xQpT2L9IrY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C1U9mZrz3RYgb+K70N9npgoAvH3QmrE+QalhO5W2ccYbfyEWtuCS6WA95ovv2Pa+K08HACJbcWsmvOyAnMv7qR8paZs9FxIPhEdSaFg+46+TmCn8lVHGOJnL7SnSlT/Pc3Mfi1F8OY0Z24Jx+Kldd98c0xLzuaGoI6dZE2AXuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1nV32DV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712907878; x=1744443878;
  h=date:from:to:cc:subject:message-id;
  bh=ghTkgrOk/ahJP9DFKGx5Q4jgJn6AK7ro0xQpT2L9IrY=;
  b=m1nV32DVN86QodBn27mAuPfG44YmHEq1Yvo9bedbPnvoYqctek/+Ub2Y
   9bfyH7kOaJ0O++JIi3H7vT1aPff+PnGnx/N4QuyxtJ5dUfy5K5ZbnC8ZO
   drEHw/hAdP32ZpjskJCn5VHVl0W3ixwzzeIlY/p2Ty9aOHuQofzMt2EsF
   Jmd/nq/KtiubyQa+gyyR7q+PBSyeKRGMEvq6R/6ICw80vjXz0KnGOZ6c4
   BoHO9ja+l4Cq/oDxZoU1L/SinNPOg5Kdps2r0gYLiwsA68mYV2zeeNesS
   7zMU69pcfMuEcVFy1TKzi2l/s74h9FRT538wSiaPvOfPUZ2w/PetPUHoi
   A==;
X-CSE-ConnectionGUID: 7O91IlMsR6+5NnPjYjEuUg==
X-CSE-MsgGUID: sv19mt00SCajgyo5ktB6ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8226794"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8226794"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:44:37 -0700
X-CSE-ConnectionGUID: hVEht0c0S/6lTFdOKG2QIw==
X-CSE-MsgGUID: NoGFAGTIR52UVoM5Xyx4og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21734924"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Apr 2024 00:44:36 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvBaL-0009W7-34;
	Fri, 12 Apr 2024 07:44:33 +0000
Date: Fri, 12 Apr 2024 15:44:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b4ba814ae4a4d07d1b983601c3b2ea488864cc88
Message-ID: <202404121558.Oz9oTuqG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b4ba814ae4a4d07d1b983601c3b2ea488864cc88  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1019m

configs tested: 154
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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240412   gcc  
arc                   randconfig-002-20240412   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240412   gcc  
arm                   randconfig-002-20240412   clang
arm                   randconfig-003-20240412   clang
arm                   randconfig-004-20240412   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240412   gcc  
arm64                 randconfig-002-20240412   gcc  
arm64                 randconfig-003-20240412   clang
arm64                 randconfig-004-20240412   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240412   gcc  
csky                  randconfig-002-20240412   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240412   clang
hexagon               randconfig-002-20240412   clang
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
loongarch             randconfig-001-20240412   gcc  
loongarch             randconfig-002-20240412   gcc  
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
nios2                 randconfig-001-20240412   gcc  
nios2                 randconfig-002-20240412   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240412   gcc  
parisc                randconfig-002-20240412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240412   clang
powerpc               randconfig-002-20240412   clang
powerpc               randconfig-003-20240412   gcc  
powerpc64             randconfig-001-20240412   gcc  
powerpc64             randconfig-002-20240412   gcc  
powerpc64             randconfig-003-20240412   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240412   clang
riscv                 randconfig-002-20240412   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240412   gcc  
s390                  randconfig-002-20240412   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240412   gcc  
sh                    randconfig-002-20240412   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240412   gcc  
sparc64               randconfig-002-20240412   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240412   clang
um                    randconfig-002-20240412   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240412   gcc  
x86_64       buildonly-randconfig-002-20240412   gcc  
x86_64       buildonly-randconfig-003-20240412   gcc  
x86_64       buildonly-randconfig-004-20240412   clang
x86_64       buildonly-randconfig-005-20240412   clang
x86_64       buildonly-randconfig-006-20240412   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240412   clang
x86_64                randconfig-002-20240412   gcc  
x86_64                randconfig-003-20240412   gcc  
x86_64                randconfig-004-20240412   clang
x86_64                randconfig-005-20240412   clang
x86_64                randconfig-006-20240412   clang
x86_64                randconfig-011-20240412   clang
x86_64                randconfig-012-20240412   gcc  
x86_64                randconfig-013-20240412   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

