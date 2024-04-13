Return-Path: <linux-kernel+bounces-143683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E58A3C43
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE2B1C20DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1F4206E;
	Sat, 13 Apr 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lkl/9UGx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D640876
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004737; cv=none; b=aGMGsDc6MoZJBE09uet0WxPgXyvtwrrXggtDm5GakT7ZE6KIeAxnnKqic84FoCLEAI2EB3QV976+zaya+kzOK+XHlPJ3uwZOeByXDK8oVB6JJpM47cumhYRzVO7SYfRopnmgNzrsmZpnWwMCQCmyBXDh0ImCHgppd5lYFNxFrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004737; c=relaxed/simple;
	bh=sdMis4gi8zTrgLnTFU8weNWwezWnEvxwZUVowQy3sPQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AKOZFtvpXbt8586Na29Uswn43CVN7dRwXK3FfaxAFnTO4mI8kcz2JKvjROdRhMjtw4t2oQ5CMouVZxK9kD+WWcfmjrVomfEpv89UCzr9svIVdz0MtwYQdbNI0K4wH+BXYcPbKSV4rAugOezfkZdyWmN6FKqg8XNZu7grQVlHn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lkl/9UGx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713004735; x=1744540735;
  h=date:from:to:cc:subject:message-id;
  bh=sdMis4gi8zTrgLnTFU8weNWwezWnEvxwZUVowQy3sPQ=;
  b=Lkl/9UGxD9kVh1iqrMeRQzlFytOXI8+8KJ0iJoWp0sZFfLuekcqPHswI
   /wM8yizPnAhfhivC2o+OIsHG4dGOXUhdYnh86hA2V5YZ6/pRRftismT8s
   5d3zAsVkh8AbUU74PNeGKeteRQB1QXPyctAtn5CKkDRye51dDoIuEcoBP
   tNXZcxA5q5W9U9lzqkY/MV0pP5lJwuP/7FiRpp/YnWO+jC7sk5FV9LJXz
   cQTpLUsiMQvj1EwwajxMVMf034wMPWFisRbwJobO3iS9jCr5UbXAbofhb
   73YSMlLwnHyKM1iJTA13lMw9GEsgUxd3N30YCG7Xo3Af3BPyumfhfweFN
   Q==;
X-CSE-ConnectionGUID: sQMLERypQV+CQH6Wsy0ybA==
X-CSE-MsgGUID: E+Ljf4uPTpCAGEpnmI2x6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="25919204"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="25919204"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 03:38:54 -0700
X-CSE-ConnectionGUID: UfLvQwG+TbKN2/s8cxZn/w==
X-CSE-MsgGUID: MCiHrzFMRmqb2Yx8o5eL6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="22031671"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 13 Apr 2024 03:38:54 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvamZ-0002JQ-0x;
	Sat, 13 Apr 2024 10:38:51 +0000
Date: Sat, 13 Apr 2024 18:37:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 90167e96588df747c9b47a04ebac59b71e3b413f
Message-ID: <202404131857.cdF4xhZG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 90167e96588df747c9b47a04ebac59b71e3b413f  x86/sev: Take NUMA node into account when allocating memory for per-CPU SEV data

elapsed time: 1450m

configs tested: 167
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
arc                   randconfig-001-20240413   gcc  
arc                   randconfig-002-20240413   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
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
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-006-20240413   clang
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
x86_64                randconfig-012-20240413   clang
x86_64                randconfig-013-20240413   clang
x86_64                randconfig-014-20240413   clang
x86_64                randconfig-015-20240413   gcc  
x86_64                randconfig-016-20240413   clang
x86_64                randconfig-071-20240413   gcc  
x86_64                randconfig-072-20240413   gcc  
x86_64                randconfig-073-20240413   clang
x86_64                randconfig-074-20240413   gcc  
x86_64                randconfig-075-20240413   gcc  
x86_64                randconfig-076-20240413   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240413   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

