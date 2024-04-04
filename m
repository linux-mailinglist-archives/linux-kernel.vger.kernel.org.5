Return-Path: <linux-kernel+bounces-131803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD7898BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D136C1C21B73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECC12AAF8;
	Thu,  4 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvYzbSRO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B01D531
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247329; cv=none; b=trKkMju1iP5diImk1/21lVeED0Cu7CD828GqUv37Cjj73zTFd6gTLbwR45NLhLjQXUhvMcukR2ZX3FHzWaEtyP/EYrSSk6OKBKO8CRj/yKtrYwkpgo8w89cGMaVQ1VrwA5Bcq3H9TSMvJ/EF4h8k+RnQWhySBtVm3GqwGNqKYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247329; c=relaxed/simple;
	bh=9yyejU07SDtH+1M1gf7274NHJN3gbvrvAuVSHcOJSMU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W+yMJPHEcFY8uBuHQi7S2LY3Nk3Gcg3gJMV9+9CANVtaYIF2yXyCEuBNSZ6QsHkslXBkkdYxDRp4B6xJFdypsFnzwjQetM+ZQ0gUGR8Uy8XGO4Ub+51pm5hyvV7qX8IafkJdm1esO0MQLVwSSF+AFWmlfxsjElyW6IN6B2nPgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvYzbSRO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712247327; x=1743783327;
  h=date:from:to:cc:subject:message-id;
  bh=9yyejU07SDtH+1M1gf7274NHJN3gbvrvAuVSHcOJSMU=;
  b=fvYzbSROX0k//i32DTq5KXO/Y9PgeyTkoQRsgUNCylu7gBSwxbSCWPyA
   TK4saxORDjT34uiYMnNn7shdaRJsNB5SQVdFVArKI1YB5OIFmauF7EqaO
   +q069O/kN+pOncFbNgrPpwivaGH3AXp/hiMjYnR8se//7fAlB6wEBEh7u
   skOWF4V3v89Iiye13lBRyatVAGdtC44BzSbQ/dIVb6SzAhgocrnxN9n7Y
   OPiXQhOiXWxpcV9wDXtbB/8yYNPey4P1GxxxWUsbaU/aS6wibjaONsL5o
   4zOVRvmb7eWI1P+7pYDCIS/ABgi/6RsQdGhZU/m1fYWzunBi9KgYFdBCn
   A==;
X-CSE-ConnectionGUID: T2GwOno8Sym3IauSyBafNg==
X-CSE-MsgGUID: h6Pv4nHESRydSmAkktxwow==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7408898"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7408898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:14:59 -0700
X-CSE-ConnectionGUID: 409RgTwaSAa3iHxPUmOV4g==
X-CSE-MsgGUID: Rxxd4Zt/T1G6G6SaG9w9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18763446"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Apr 2024 09:14:58 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsPjr-0001Ff-2q;
	Thu, 04 Apr 2024 16:14:55 +0000
Date: Fri, 05 Apr 2024 00:14:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 1fe1448b0f2bdf037c4150c7e35a1f8052f8fe7c
Message-ID: <202404050046.a9CDcdXS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1fe1448b0f2bdf037c4150c7e35a1f8052f8fe7c  ftrace: Asynchronous grace period for register_ftrace_direct()

elapsed time: 1177m

configs tested: 179
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
arc                   randconfig-001-20240404   gcc  
arc                   randconfig-002-20240404   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                   randconfig-001-20240404   gcc  
arm                   randconfig-002-20240404   gcc  
arm                   randconfig-003-20240404   clang
arm                   randconfig-004-20240404   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240404   gcc  
arm64                 randconfig-002-20240404   gcc  
arm64                 randconfig-003-20240404   clang
arm64                 randconfig-004-20240404   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240404   gcc  
csky                  randconfig-002-20240404   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240404   clang
hexagon               randconfig-002-20240404   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-005-20240404   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240404   gcc  
loongarch             randconfig-002-20240404   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240404   gcc  
nios2                 randconfig-002-20240404   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240404   gcc  
parisc                randconfig-002-20240404   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240404   gcc  
powerpc               randconfig-002-20240404   gcc  
powerpc               randconfig-003-20240404   clang
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240404   gcc  
powerpc64             randconfig-002-20240404   clang
powerpc64             randconfig-003-20240404   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240404   clang
riscv                 randconfig-002-20240404   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240404   gcc  
s390                  randconfig-002-20240404   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240404   gcc  
sh                    randconfig-002-20240404   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240404   gcc  
sparc64               randconfig-002-20240404   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240404   clang
um                    randconfig-002-20240404   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-074-20240404   gcc  
x86_64                randconfig-075-20240404   clang
x86_64                randconfig-076-20240404   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240404   gcc  
xtensa                randconfig-002-20240404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

