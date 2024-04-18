Return-Path: <linux-kernel+bounces-150680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1A8AA2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8681F22E49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FCE17BB2C;
	Thu, 18 Apr 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnr9kfDs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E147181BB2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469095; cv=none; b=ByExQQUufIXBB1zo5LARBekS1qQqSq7VJ60qiazgtM7yJ6hoLwq+iVwc6QGtUlQhsLkCuiLyw5XuVoGr402rltpoz8lvWbOz/Mgb2vcMCh83aqV0x0SOVmq9hEN6K/cTz6rY6G+86RXS5uzENLRAYWDfjf+y70bbtrNqAvLcLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469095; c=relaxed/simple;
	bh=oYLkPZY7RWrHa24F+0j6FGcdLw//k4l/jElhwMd0wEA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XUeOyjaoWfHFqYOYa+/0tagK8ZJhEFznRqSqAIWSqX15a+Ed+KOiBGWkewT6t/YGBZk/hNrmaBBpavsYio3rOkaIXsJ98ZbnUgdWWMnEg/0wVr+AGmMz5NgmHQ1TyKhgnAC4rTcylRbNL1tdo5JnCzivbsottQd109YBOACpZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnr9kfDs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713469094; x=1745005094;
  h=date:from:to:cc:subject:message-id;
  bh=oYLkPZY7RWrHa24F+0j6FGcdLw//k4l/jElhwMd0wEA=;
  b=Nnr9kfDsD/7cJNkeAm1TrPUgaA76THdGirUshXRWy0XN1medE2qY2YG4
   nUfeuhaNXoleIxnYwgBlp6ue612FAI3bJH3ovR+bI/NMiFHLYTtqfmuIT
   r+O2rAJbCLMR5pFP3RGql0r8ngmvZbaVoCw1PQfAVn8eAyjzW7o/BZwb4
   WdzWjaetxJm9oaUFwf1HOX8FTJvNx9BZVQJjxQvwzGSLgtb312GfibqiT
   PZ9RFv+M/z0vmkM7FwfHEwSIwBng2XhJbt96/44OW46/biWpmuxXzFezm
   dHMg7TwT3mN4vs/idgPGZJVtjO9qvVSlen8jMtbJa6w9pmakeaLWpokK2
   Q==;
X-CSE-ConnectionGUID: 7o+53ciPSsy9Sm+npVdpmA==
X-CSE-MsgGUID: lDrrxz7fQy6VROzZT1sxiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8912103"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8912103"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 12:38:14 -0700
X-CSE-ConnectionGUID: J6HvKc5kR1i1pKH7Pj0nEQ==
X-CSE-MsgGUID: TzyUlsh/Riu9ex1t5Kn6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23145010"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Apr 2024 12:38:13 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxXaE-00099P-1f;
	Thu, 18 Apr 2024 19:38:10 +0000
Date: Fri, 19 Apr 2024 03:37:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.13a] BUILD SUCCESS
 d77624179bb735003b7f725d3502fb8cc1def1ce
Message-ID: <202404190342.qeXxTKW1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.13a
branch HEAD: d77624179bb735003b7f725d3502fb8cc1def1ce  squash! sh: Emulate one-byte cmpxchg

elapsed time: 1042m

configs tested: 154
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
arc                   randconfig-001-20240418   gcc  
arc                   randconfig-002-20240418   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240418   gcc  
arm                   randconfig-002-20240418   gcc  
arm                   randconfig-003-20240418   gcc  
arm                   randconfig-004-20240418   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240418   gcc  
arm64                 randconfig-003-20240418   gcc  
arm64                 randconfig-004-20240418   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240418   gcc  
csky                  randconfig-002-20240418   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-004-20240418   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240418   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240418   gcc  
loongarch             randconfig-002-20240418   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          eyeq5_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240418   gcc  
nios2                 randconfig-002-20240418   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240418   gcc  
parisc                randconfig-002-20240418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc               randconfig-001-20240418   gcc  
powerpc               randconfig-003-20240418   gcc  
powerpc64             randconfig-001-20240418   gcc  
powerpc64             randconfig-002-20240418   gcc  
powerpc64             randconfig-003-20240418   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240418   gcc  
riscv                 randconfig-002-20240418   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240418   gcc  
sh                    randconfig-002-20240418   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240418   gcc  
sparc64               randconfig-002-20240418   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240418   gcc  
um                    randconfig-002-20240418   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-005-20240418   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240418   gcc  
x86_64                randconfig-003-20240418   gcc  
x86_64                randconfig-005-20240418   gcc  
x86_64                randconfig-006-20240418   gcc  
x86_64                randconfig-012-20240418   gcc  
x86_64                randconfig-014-20240418   gcc  
x86_64                randconfig-015-20240418   gcc  
x86_64                randconfig-016-20240418   gcc  
x86_64                randconfig-071-20240418   gcc  
x86_64                randconfig-074-20240418   gcc  
x86_64                randconfig-075-20240418   gcc  
x86_64                randconfig-076-20240418   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240418   gcc  
xtensa                randconfig-002-20240418   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

