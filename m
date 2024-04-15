Return-Path: <linux-kernel+bounces-144799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03E8A4AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF90281286
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8E3BBDE;
	Mon, 15 Apr 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtkHtOhg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468139FF4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171049; cv=none; b=YvNIo2mSOCkAJO6YV1QmSMPJsaAxn4Dz9+VwMSYuS27lvsk3VHzzVPIcK3QqTl+glBygUQbNBZSoMVdIegd4eVZt1u6llkHcsBzZbKhU8kO7hTt8Md4xUYmTT4uEC+p6FN1WSK14dXWUvuLVp7r9MyuL4tEW61I6eLzZ2eBxym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171049; c=relaxed/simple;
	bh=mjegr76g567DfzpkY8I7lo7a7PBSrzuWvtDG+zktdFM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VDyxbey/JpSSo+OmMUhJ27XeOTyCWqcA+OyilbkE76Zy0N/+an6llQ248liXi0uNSVI2UcXpyLNoa0ZU4sIryGwdVl204JPWawEhsRpCJ2DdWd0hVjnsXTuVcKmMg1tQQuVkzuSNkRpBMhMM0GkuiDQBf5BumKmItGR4Pi+Q/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtkHtOhg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171047; x=1744707047;
  h=date:from:to:cc:subject:message-id;
  bh=mjegr76g567DfzpkY8I7lo7a7PBSrzuWvtDG+zktdFM=;
  b=TtkHtOhgLfYu2yFgvXQ02M/e+rzHjRZmd6ac7pJl6y7UuZv4C2ybrisC
   5227hvKHYQNNaoOAOUXkWf25nD1AhB2amcLlomOG5IYZJm9Qv22QpRwas
   l5ixPMeMiEOLmsvSIG5PkVO55dlnbJdGEuWKvTehx6sb3uTaVUGOC2iCk
   Kj6tBbmU0/JuAIHt30a0r2od31m24sdsANQaHvx8z5JTjZFpZMk3WO7Xh
   1tQwieiB6DqeI6OLe2JRuvU6LUOH5BIRgTsns/sfn3hkbzWkJB+mKe8vR
   BJZ+PJZwFkeTm+cAvpMpggcEyTYqXC5FGGMi65OcNIGt2nPWfLy43quLC
   A==;
X-CSE-ConnectionGUID: bZb8Bc35Rl61zP/dQ/T3ZQ==
X-CSE-MsgGUID: wGgn0yIgTRWdWtqSLa+yig==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8769234"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8769234"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:50:46 -0700
X-CSE-ConnectionGUID: Wns0jrv7SWun+dUR1Hld/w==
X-CSE-MsgGUID: 9RWewqGMQbma5CVklOJwsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26486521"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Apr 2024 01:50:46 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwI30-00044r-2k;
	Mon, 15 Apr 2024 08:50:42 +0000
Date: Mon, 15 Apr 2024 16:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 d26e46f6bf329cfcc469878709baa41d3bfc7cc3
Message-ID: <202404151614.tjI8GO8B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: d26e46f6bf329cfcc469878709baa41d3bfc7cc3  locking/atomic/x86: Introduce arch_try_cmpxchg64_local()

elapsed time: 725m

configs tested: 180
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240415   gcc  
arc                   randconfig-002-20240415   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240415   gcc  
arm                   randconfig-002-20240415   gcc  
arm                   randconfig-003-20240415   clang
arm                   randconfig-004-20240415   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240415   clang
arm64                 randconfig-002-20240415   clang
arm64                 randconfig-003-20240415   clang
arm64                 randconfig-004-20240415   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240415   gcc  
csky                  randconfig-002-20240415   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240415   clang
hexagon               randconfig-002-20240415   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240415   clang
i386         buildonly-randconfig-002-20240415   gcc  
i386         buildonly-randconfig-003-20240415   gcc  
i386         buildonly-randconfig-004-20240415   gcc  
i386         buildonly-randconfig-005-20240415   gcc  
i386         buildonly-randconfig-006-20240415   clang
i386                                defconfig   clang
i386                  randconfig-001-20240415   gcc  
i386                  randconfig-002-20240415   clang
i386                  randconfig-003-20240415   gcc  
i386                  randconfig-004-20240415   gcc  
i386                  randconfig-005-20240415   gcc  
i386                  randconfig-006-20240415   clang
i386                  randconfig-011-20240415   gcc  
i386                  randconfig-012-20240415   clang
i386                  randconfig-013-20240415   gcc  
i386                  randconfig-014-20240415   gcc  
i386                  randconfig-015-20240415   gcc  
i386                  randconfig-016-20240415   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240415   gcc  
loongarch             randconfig-002-20240415   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip32_defconfig   clang
mips                      maltaaprp_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240415   gcc  
nios2                 randconfig-002-20240415   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240415   gcc  
parisc                randconfig-002-20240415   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc               randconfig-001-20240415   gcc  
powerpc               randconfig-002-20240415   gcc  
powerpc               randconfig-003-20240415   clang
powerpc64             randconfig-001-20240415   clang
powerpc64             randconfig-002-20240415   clang
powerpc64             randconfig-003-20240415   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240415   clang
riscv                 randconfig-002-20240415   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240415   gcc  
s390                  randconfig-002-20240415   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240415   gcc  
sh                    randconfig-002-20240415   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240415   gcc  
sparc64               randconfig-002-20240415   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240415   clang
um                    randconfig-002-20240415   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240415   clang
x86_64       buildonly-randconfig-002-20240415   clang
x86_64       buildonly-randconfig-003-20240415   clang
x86_64       buildonly-randconfig-004-20240415   clang
x86_64       buildonly-randconfig-005-20240415   gcc  
x86_64       buildonly-randconfig-006-20240415   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240415   gcc  
x86_64                randconfig-002-20240415   gcc  
x86_64                randconfig-003-20240415   clang
x86_64                randconfig-004-20240415   gcc  
x86_64                randconfig-005-20240415   clang
x86_64                randconfig-006-20240415   clang
x86_64                randconfig-011-20240415   clang
x86_64                randconfig-012-20240415   clang
x86_64                randconfig-013-20240415   gcc  
x86_64                randconfig-014-20240415   clang
x86_64                randconfig-015-20240415   clang
x86_64                randconfig-016-20240415   clang
x86_64                randconfig-071-20240415   gcc  
x86_64                randconfig-072-20240415   clang
x86_64                randconfig-073-20240415   clang
x86_64                randconfig-074-20240415   clang
x86_64                randconfig-075-20240415   clang
x86_64                randconfig-076-20240415   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240415   gcc  
xtensa                randconfig-002-20240415   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

