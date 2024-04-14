Return-Path: <linux-kernel+bounces-143950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39B8A3FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A86B21581
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610A17547;
	Sun, 14 Apr 2024 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvYvfUGo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DA168BE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063991; cv=none; b=f7f/SXEGMV6gfQ1EhoDVlg389CfT6uZEoccpxFc5eFNz30un1HyT+MtD5qgTiRuQtQLRsRhQAI+L68e7xrKHNZCBCwl1j9H7nUzZ4kYwAtpnlcA10QaKbv/HXV0LqVLoSNwziz4PASfOBurwu4Knd6tqz+IwtZ2iBkmdzVKeZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063991; c=relaxed/simple;
	bh=fNWcrz15k+GvLXStVubH5/gBJenA/4QM5ZlAl7nigfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LGk18HcdKTagWqhMJ/M5kaIJvLmvf4E4zxe83kybQc1v11PxZuWgNCt6KXT+JaQklsoBS5MfENPMYyW5Fcj2KAVfIoiRQbHJ5xtpw8+luDKUhx7FcBS6DLZjPL50uIq1oiMc/IftCvCFd7We7zWWnfywIBPTZRkU794F643cvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvYvfUGo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713063989; x=1744599989;
  h=date:from:to:cc:subject:message-id;
  bh=fNWcrz15k+GvLXStVubH5/gBJenA/4QM5ZlAl7nigfQ=;
  b=nvYvfUGo32BhqiOGUBcn94KzbAxpfN730q5r75ZaQygL2+YSNfQiYGbw
   gy+w4P58PcdZVxzau5eYNJ9JEd/dfsq0rtyvt1u8q65+4CV6L3lcMYe5I
   sQudqRFSdFnlEqPYGgC8FTilUyZsQDnbxdtlCJ8FEkutVQAiIKUAyXXPu
   2caVQO6TlkUoOL2juLoO3+E77UN6jW2/GCLVUE4eSC7oY47J7Bmwt/FCF
   nhYe5DqS0M3F34JILC+I1x6WqbK+e+tvNArzIWojN+WiN214dq0mOcx/m
   3JKhALUak3Odi1z5x6kJJ83k7MSBuIsIW5uS5qEiSoXXJB99DRB855JEg
   A==;
X-CSE-ConnectionGUID: nyvx3DaWSQSM2XOxsljU8A==
X-CSE-MsgGUID: m2Hek8ELRJaS/LhS4PU8pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="8654832"
X-IronPort-AV: E=Sophos;i="6.07,200,1708416000"; 
   d="scan'208";a="8654832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 20:06:29 -0700
X-CSE-ConnectionGUID: QFh1W/NQQL2lVyz5jDDDCA==
X-CSE-MsgGUID: ONvfgDrgRLyfiHZ63DF2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,200,1708416000"; 
   d="scan'208";a="59003946"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2024 20:06:28 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvqCH-0003C2-22;
	Sun, 14 Apr 2024 03:06:25 +0000
Date: Sun, 14 Apr 2024 11:05:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.12a] BUILD SUCCESS
 ecf0d768aacf7ee231aff016c1700252deddb747
Message-ID: <202404141148.PL0UJj1t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.12a
branch HEAD: ecf0d768aacf7ee231aff016c1700252deddb747  EXP cgroup/cpuset: Make cpuset hotplug processing synchronous

elapsed time: 1085m

configs tested: 159
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240414   gcc  
arc                   randconfig-002-20240414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-003-20240414   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240414   gcc  
arm64                 randconfig-003-20240414   gcc  
arm64                 randconfig-004-20240414   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240414   gcc  
csky                  randconfig-002-20240414   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-001-20240414   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-003-20240414   gcc  
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-004-20240414   gcc  
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-005-20240414   gcc  
i386         buildonly-randconfig-006-20240413   clang
i386         buildonly-randconfig-006-20240414   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-002-20240414   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-003-20240414   gcc  
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-004-20240414   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-005-20240414   gcc  
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-013-20240414   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-014-20240414   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
i386                  randconfig-016-20240414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240414   gcc  
loongarch             randconfig-002-20240414   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240414   gcc  
nios2                 randconfig-002-20240414   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240414   gcc  
parisc                randconfig-002-20240414   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-003-20240414   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-002-20240414   gcc  
powerpc64             randconfig-003-20240414   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240414   gcc  
sh                    randconfig-002-20240414   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240414   gcc  
sparc64               randconfig-002-20240414   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240414   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240414   gcc  
xtensa                randconfig-002-20240414   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

