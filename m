Return-Path: <linux-kernel+bounces-152150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FF8AB9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EA01C2039E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F51F9DF;
	Sat, 20 Apr 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UG5pbMVr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CB7465
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590430; cv=none; b=cfp9AnlAh2N2xt5AeixasniWycZNtINzXMSODojISDYM33acc38J4ox/zQvu8uH/OesoBGorOUA6egpFk1NN2/LVxYBfPwGgAdITSAlbvfFga/RegMgkb/7Y3+z7DeKksEuZP3eR9JSsArD7afdmT4XRKyAOhbp/HTNiD5mauk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590430; c=relaxed/simple;
	bh=r8PsHjv5FDkq4fKjKJpaYPJrMyNuxrY3PKkCjKnZBc4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y2/6FW2/vdhn/5CciFBQNri4AmlcxJEuoKhBkeZ000Gk0xpvKULGKcmgVF3cGFV8nUU71yMF3jOlUSKIFqCRRk/J7XYieUk2BOcYwFDFKoimyNehc5C5PuQ2lKGCW1g/ppwCZsNDlWtlW4ouGj6H+QvjZPskoWDDfO5tMwfj15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UG5pbMVr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713590428; x=1745126428;
  h=date:from:to:cc:subject:message-id;
  bh=r8PsHjv5FDkq4fKjKJpaYPJrMyNuxrY3PKkCjKnZBc4=;
  b=UG5pbMVrHu0UddKqiLrM1c+SS/1IBzvHBfWVQlxIHmHO8rQDdt216+Pr
   fh1J41PX1Uj3vEm9i5grWhWmZr7aKtUQoMJJTxXNU5fS0iO4NI58Dzo49
   DmfEVeBKSakclLYIJ1gmQCQXAFT4qGHC9yAyX9CLrz8jExJ1gBVmnmRdV
   w35E2pfZvy9S+C0kOLYe498KvuGAOy+2M8DdMpVEpDOHv863ZEyv9zMMg
   H2b0S+SjBQqhMsHy7iqCyi3Xm2KE+T3/7ar5Q3waHWS3L5cu+g0rhnkYK
   wKLmWdAW914yX/0IcQLX8Ag1lXY0DCVFw0U9LYRuJ/3bPPa+8dU28aha/
   w==;
X-CSE-ConnectionGUID: qoxocZVeS7O6GXaGXnwNNw==
X-CSE-MsgGUID: i//eHM4hQf+Fbgjo7XjiFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="31683935"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="31683935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 22:20:28 -0700
X-CSE-ConnectionGUID: cBHesrE6RfuhvN0SsgpvJg==
X-CSE-MsgGUID: a+VPfWrhR3ClCNUx1wBpXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23584333"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 22:20:26 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ry39E-000Aky-06;
	Sat, 20 Apr 2024 05:20:24 +0000
Date: Sat, 20 Apr 2024 13:20:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7fcd76de8a7bc12e930ef383a157ce99d711715d
Message-ID: <202404201320.inxN06V0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7fcd76de8a7bc12e930ef383a157ce99d711715d  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1293m

configs tested: 160
configs skipped: 6

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
arc                   randconfig-001-20240419   gcc  
arc                   randconfig-002-20240419   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240419   gcc  
arm                   randconfig-002-20240419   clang
arm                   randconfig-003-20240419   gcc  
arm                   randconfig-004-20240419   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240419   clang
arm64                 randconfig-002-20240419   clang
arm64                 randconfig-003-20240419   clang
arm64                 randconfig-004-20240419   clang
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240419   gcc  
csky                  randconfig-002-20240419   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240419   clang
hexagon               randconfig-002-20240419   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386         buildonly-randconfig-002-20240419   gcc  
i386         buildonly-randconfig-003-20240419   gcc  
i386         buildonly-randconfig-004-20240419   gcc  
i386         buildonly-randconfig-005-20240419   gcc  
i386         buildonly-randconfig-006-20240419   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-004-20240419   gcc  
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240419   clang
i386                  randconfig-011-20240419   gcc  
i386                  randconfig-012-20240419   clang
i386                  randconfig-013-20240419   gcc  
i386                  randconfig-014-20240419   clang
i386                  randconfig-015-20240419   gcc  
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240419   gcc  
loongarch             randconfig-002-20240419   gcc  
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
nios2                 randconfig-001-20240419   gcc  
nios2                 randconfig-002-20240419   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240419   gcc  
parisc                randconfig-002-20240419   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240419   gcc  
powerpc               randconfig-002-20240419   gcc  
powerpc               randconfig-003-20240419   gcc  
powerpc64             randconfig-001-20240419   gcc  
powerpc64             randconfig-002-20240419   gcc  
powerpc64             randconfig-003-20240419   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240419   clang
riscv                 randconfig-002-20240419   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240419   clang
s390                  randconfig-002-20240419   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240419   gcc  
sh                    randconfig-002-20240419   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240419   gcc  
sparc64               randconfig-002-20240419   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240419   gcc  
um                    randconfig-002-20240419   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240420   gcc  
x86_64       buildonly-randconfig-002-20240420   clang
x86_64       buildonly-randconfig-003-20240420   gcc  
x86_64       buildonly-randconfig-004-20240420   gcc  
x86_64       buildonly-randconfig-005-20240420   clang
x86_64       buildonly-randconfig-006-20240420   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240420   clang
x86_64                randconfig-002-20240420   clang
x86_64                randconfig-003-20240420   gcc  
x86_64                randconfig-004-20240420   clang
x86_64                randconfig-005-20240420   clang
x86_64                randconfig-006-20240420   gcc  
x86_64                randconfig-011-20240420   gcc  
x86_64                randconfig-012-20240420   gcc  
x86_64                randconfig-013-20240420   gcc  
x86_64                randconfig-014-20240420   gcc  
x86_64                randconfig-015-20240420   clang
x86_64                randconfig-016-20240420   gcc  
x86_64                randconfig-071-20240420   gcc  
x86_64                randconfig-072-20240420   gcc  
x86_64                randconfig-073-20240420   gcc  
x86_64                randconfig-074-20240420   gcc  
x86_64                randconfig-075-20240420   gcc  
x86_64                randconfig-076-20240420   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240419   gcc  
xtensa                randconfig-002-20240419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

