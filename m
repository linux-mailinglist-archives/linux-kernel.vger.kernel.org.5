Return-Path: <linux-kernel+bounces-134629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B589B3D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCABB21129
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03003D541;
	Sun,  7 Apr 2024 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+v/p6Zg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2011181
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712518768; cv=none; b=jcA9DKuldS0Hmny+4ZnPqnbPV8e2BPfgJBEcbzI1v6F8nL4JzOkbzoTbMWAfiHADYqTNCkRhhR8tFkakT97Gpri/M5UwyRLS5A5HjJDLfccaHGDDwjB9QQfjOuRNrg1jt4bSSDvL8bLcqxXdG0aqZzOggr2JnRc2dBvwve5VthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712518768; c=relaxed/simple;
	bh=Q7SGCJiTAe5yAa6pnmJmyPMC4bsDccwYpLb1GSSizn4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e2tj3Bj/eULd1HaolMOC1FRLofYMIvCFTq7suBHfuEDVWP178DrJy+x6Mma0osYiRBsV6aw48g37wy7/7tReHLLo4NDZbWq/F6Imiaq9NhVfr29kj00PdVlduKcPIXGJT7su18m9mk6D9iZERYqEaqpQS7B3Sgdab5SzTU6tycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+v/p6Zg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712518767; x=1744054767;
  h=date:from:to:cc:subject:message-id;
  bh=Q7SGCJiTAe5yAa6pnmJmyPMC4bsDccwYpLb1GSSizn4=;
  b=K+v/p6ZgXwb3s3+IwBM3CsMJZuWJwpx1lFa76ZaIFO1fkMi7Z9xkb8Ha
   5gCnO9zynq0EvrlohS60eYfaywBzvUx9bog22xai7CvINaQiPb6ReYwSu
   frOKnGEEGT9kDGMNjTpcJAe9p3TOPqUbUpqw8wLFit7yH4L0cC5H++FLB
   nrrsMN81hnNB7JfDNeizBHpSMuh6JXYNJ5jFBWL9wfkYQl9qZpv9WS3Hb
   K0wOmIOqcz0OXPNgLn6Og329FbDwPlNTujD3mur1z5gQCh3QLk2OLZyeP
   DG1qcwBA8AJHZ/X0jkr1o3qrLVVBU2VthyksrfxTdOJ8MXn+/oIB206cZ
   A==;
X-CSE-ConnectionGUID: CuBuWyQSSzq6nY7EmmjvgA==
X-CSE-MsgGUID: haUYJmpzSxaH7oNx3DlZ6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7652614"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7652614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:39:26 -0700
X-CSE-ConnectionGUID: ZAkGEQ4EQJeoUrRrJvi/Ug==
X-CSE-MsgGUID: 43KY5C9MSA6v9axhP1Mijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="42849122"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Apr 2024 12:39:25 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtYMM-0004ZG-2K;
	Sun, 07 Apr 2024 19:39:22 +0000
Date: Mon, 08 Apr 2024 03:38:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a18b42d8997abfd77aa1637c0de6850b0c30b1fe
Message-ID: <202404080330.ME3v47uC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a18b42d8997abfd77aa1637c0de6850b0c30b1fe  Merge branch into tip/master: 'x86/shstk'

elapsed time: 724m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240407   gcc  
arc                   randconfig-002-20240407   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240407   gcc  
arm                   randconfig-002-20240407   clang
arm                   randconfig-003-20240407   gcc  
arm                   randconfig-004-20240407   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240407   gcc  
arm64                 randconfig-002-20240407   clang
arm64                 randconfig-003-20240407   gcc  
arm64                 randconfig-004-20240407   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240407   gcc  
csky                  randconfig-002-20240407   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240407   clang
hexagon               randconfig-002-20240407   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240407   gcc  
i386         buildonly-randconfig-002-20240407   clang
i386         buildonly-randconfig-003-20240407   gcc  
i386         buildonly-randconfig-004-20240407   clang
i386         buildonly-randconfig-005-20240407   gcc  
i386         buildonly-randconfig-006-20240407   clang
i386                                defconfig   clang
i386                  randconfig-001-20240407   gcc  
i386                  randconfig-002-20240407   gcc  
i386                  randconfig-003-20240407   gcc  
i386                  randconfig-004-20240407   clang
i386                  randconfig-005-20240407   gcc  
i386                  randconfig-006-20240407   gcc  
i386                  randconfig-011-20240407   gcc  
i386                  randconfig-012-20240407   gcc  
i386                  randconfig-013-20240407   clang
i386                  randconfig-014-20240407   gcc  
i386                  randconfig-015-20240407   clang
i386                  randconfig-016-20240407   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240407   gcc  
loongarch             randconfig-002-20240407   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm63xx_defconfig   clang
mips                       bmips_be_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240407   gcc  
nios2                 randconfig-002-20240407   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240407   gcc  
parisc                randconfig-002-20240407   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240407   clang
powerpc               randconfig-002-20240407   clang
powerpc               randconfig-003-20240407   gcc  
powerpc64             randconfig-001-20240407   clang
powerpc64             randconfig-002-20240407   clang
powerpc64             randconfig-003-20240407   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240407   clang
riscv                 randconfig-002-20240407   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240407   gcc  
s390                  randconfig-002-20240407   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240407   gcc  
sh                    randconfig-002-20240407   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240407   gcc  
sparc64               randconfig-002-20240407   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240407   gcc  
um                    randconfig-002-20240407   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240407   gcc  
x86_64       buildonly-randconfig-002-20240407   gcc  
x86_64       buildonly-randconfig-003-20240407   gcc  
x86_64       buildonly-randconfig-004-20240407   clang
x86_64       buildonly-randconfig-005-20240407   gcc  
x86_64       buildonly-randconfig-006-20240407   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240407   clang
x86_64                randconfig-002-20240407   gcc  
x86_64                randconfig-003-20240407   clang
x86_64                randconfig-004-20240407   gcc  
x86_64                randconfig-005-20240407   gcc  
x86_64                randconfig-006-20240407   gcc  
x86_64                randconfig-011-20240407   gcc  
x86_64                randconfig-012-20240407   clang
x86_64                randconfig-013-20240407   clang
x86_64                randconfig-014-20240407   clang
x86_64                randconfig-015-20240407   clang
x86_64                randconfig-016-20240407   clang
x86_64                randconfig-071-20240407   clang
x86_64                randconfig-072-20240407   clang
x86_64                randconfig-073-20240407   gcc  
x86_64                randconfig-074-20240407   gcc  
x86_64                randconfig-075-20240407   clang
x86_64                randconfig-076-20240407   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240407   gcc  
xtensa                randconfig-002-20240407   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

