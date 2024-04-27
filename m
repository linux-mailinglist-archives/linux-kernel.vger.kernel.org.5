Return-Path: <linux-kernel+bounces-160884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F608B4403
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB78DB2250A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506373C46B;
	Sat, 27 Apr 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1I+qur1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F67381CC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714190486; cv=none; b=SbKGCmNxDM+bfBYmHBsHhW0hYYkEasJ/Qo9M6eKD3cPnCex+ASSQE8JHgQg4pkUpF+kp33wHcmziQHVQ99YE52H0qNdyI0xW+YFuIRSD1bGYU2ZDaGiraiCRRLkGCgH0C87We+S9a8jfqFS2DcANxffZr6/d0NUlBUwXwVQmxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714190486; c=relaxed/simple;
	bh=p5Imtukc5X5UjiOVjVStRAo8ngBsLHfngXtytRIwISQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=leAhth7ZJF8byR+QTPP+SAbMqUZcE8TvRbi4YuO3J2oUH8zZJE0OPjZ/O6jWNiRBgSo7NzY+CJVbRVDGvbX0gHN1BK06JODjhW2joKPUWOj5jpo128lTQgc0FMQgeSbmSPkfYYlYPqAGkYCSudm7u8BBgDiepqppUDvmpJh1AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1I+qur1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714190485; x=1745726485;
  h=date:from:to:cc:subject:message-id;
  bh=p5Imtukc5X5UjiOVjVStRAo8ngBsLHfngXtytRIwISQ=;
  b=F1I+qur1fpQ7tpuZDqc+ZqTghr+yg73KgtwQYkiCCWcVEkqlD2wR9CiY
   J+qArJFKuI0k5K84MC6iXtRSqYYz5h/aIBVsKH/kOWTkFt99AjX8LqQJE
   /tj48epUXHHLwpz0xuqujn3J6NM39DO9l100sSEni6TidAMUAnzYbxLoQ
   YZXWsW8z+HEpLF7c8WPl4UWFwBLXx8kfx5cDk+fNZxYHHE56VxFUh/zAi
   CykbweFyI9xtuGsR/UZwXS54iLSC5Utwxq46a5pGNStCJP7YxWXlAwwQQ
   eFoHFAQKmZgVI/V8CI1t3ucuzl7sgzuOatF25gL2PTOOh3tjIKH1E+dAD
   A==;
X-CSE-ConnectionGUID: PCFXOtkwT/+IkUrEdYd9Dw==
X-CSE-MsgGUID: c+jA7WHWTWKO0vU5ELrrBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20546175"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="20546175"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 21:01:24 -0700
X-CSE-ConnectionGUID: +Ba50TNxRZWVrh7KK2k8vg==
X-CSE-MsgGUID: o0ncn+KSRJC7sk3aF6rEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="56517587"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Apr 2024 21:01:23 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0ZFY-0004ds-2M;
	Sat, 27 Apr 2024 04:01:20 +0000
Date: Sat, 27 Apr 2024 12:00:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d2d936b8cb4b34e8c8ccbdb2b4e309e9cd7a9bc4
Message-ID: <202404271250.tBnImwGZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d2d936b8cb4b34e8c8ccbdb2b4e309e9cd7a9bc4  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1128m

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
arc                   randconfig-001-20240426   gcc  
arc                   randconfig-002-20240426   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240426   clang
arm                   randconfig-002-20240426   gcc  
arm                   randconfig-003-20240426   gcc  
arm                   randconfig-004-20240426   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240426   gcc  
arm64                 randconfig-002-20240426   gcc  
arm64                 randconfig-003-20240426   clang
arm64                 randconfig-004-20240426   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240426   gcc  
csky                  randconfig-002-20240426   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240426   clang
hexagon               randconfig-002-20240426   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240426   gcc  
i386         buildonly-randconfig-002-20240426   clang
i386         buildonly-randconfig-003-20240426   gcc  
i386         buildonly-randconfig-004-20240426   gcc  
i386         buildonly-randconfig-005-20240426   clang
i386         buildonly-randconfig-006-20240426   clang
i386                                defconfig   clang
i386                  randconfig-001-20240426   gcc  
i386                  randconfig-002-20240426   clang
i386                  randconfig-003-20240426   gcc  
i386                  randconfig-004-20240426   gcc  
i386                  randconfig-005-20240426   gcc  
i386                  randconfig-006-20240426   clang
i386                  randconfig-011-20240426   gcc  
i386                  randconfig-012-20240426   clang
i386                  randconfig-013-20240426   clang
i386                  randconfig-014-20240426   clang
i386                  randconfig-015-20240426   clang
i386                  randconfig-016-20240426   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240426   gcc  
loongarch             randconfig-002-20240426   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240426   gcc  
nios2                 randconfig-002-20240426   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240426   gcc  
parisc                randconfig-002-20240426   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                       maple_defconfig   clang
powerpc                      mgcoge_defconfig   clang
powerpc               randconfig-001-20240426   clang
powerpc               randconfig-002-20240426   gcc  
powerpc               randconfig-003-20240426   clang
powerpc64             randconfig-001-20240426   gcc  
powerpc64             randconfig-002-20240426   gcc  
powerpc64             randconfig-003-20240426   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240426   clang
riscv                 randconfig-002-20240426   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240426   clang
s390                  randconfig-002-20240426   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240426   gcc  
sh                    randconfig-002-20240426   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240426   gcc  
sparc64               randconfig-002-20240426   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240426   gcc  
um                    randconfig-002-20240426   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240427   clang
x86_64       buildonly-randconfig-002-20240427   clang
x86_64       buildonly-randconfig-003-20240427   gcc  
x86_64       buildonly-randconfig-004-20240427   clang
x86_64       buildonly-randconfig-005-20240427   clang
x86_64       buildonly-randconfig-006-20240427   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240427   clang
x86_64                randconfig-002-20240427   clang
x86_64                randconfig-003-20240427   gcc  
x86_64                randconfig-004-20240427   clang
x86_64                randconfig-005-20240427   gcc  
x86_64                randconfig-006-20240427   gcc  
x86_64                randconfig-011-20240427   gcc  
x86_64                randconfig-012-20240427   clang
x86_64                randconfig-013-20240427   clang
x86_64                randconfig-014-20240427   clang
x86_64                randconfig-015-20240427   gcc  
x86_64                randconfig-016-20240427   gcc  
x86_64                randconfig-071-20240427   gcc  
x86_64                randconfig-072-20240427   clang
x86_64                randconfig-073-20240427   clang
x86_64                randconfig-074-20240427   clang
x86_64                randconfig-075-20240427   clang
x86_64                randconfig-076-20240427   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240426   gcc  
xtensa                randconfig-002-20240426   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

