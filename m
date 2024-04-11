Return-Path: <linux-kernel+bounces-140592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6A8A1699
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4321C21D94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6914EC5C;
	Thu, 11 Apr 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3u4JU4N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044814EC4C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844219; cv=none; b=ZDnIhlNX1eukNjHDa2LbEpmQJFz3y274CxJvDz+oTqo1WC/zuUV/riMn5ZeceLpXHpgU2zPhjY+dhfB0xrMaXaDHYGGWNKw8d0TDfKdOhTv0fLsaY6qq2ciRHyu8wb6nfLmSOfcXZtdS50j+Lppi3iHhU4U1ddKHGOCC51O/qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844219; c=relaxed/simple;
	bh=Cc1/2MlHfG3GFnwQp/1VxGBnF4MZ7pXx1G7Hp720HgQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GBhjjWFjEZS8AixxjMb4yeEp38sWz5yKIA2aLw42YboZrZw/LmQhsB7ULGI209/NLubhE64gQ8xmQ9ZMfTOU6CuiDmPlH3MHogQQJ2TDevYM1lfnD1LOLJbUIl4VqNL3dNVkr/XiH8S3Fhzo+J562ipQiKZG6azksBdEm4zDhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3u4JU4N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712844218; x=1744380218;
  h=date:from:to:cc:subject:message-id;
  bh=Cc1/2MlHfG3GFnwQp/1VxGBnF4MZ7pXx1G7Hp720HgQ=;
  b=B3u4JU4NuqMPas4bJRAKEj1zKGp++YYT88F8PSkQ1/dHOCfrAaHazlWf
   FEp0/flpjVzFUf1rLnWExLh0j+J08MR/PVsTTFVCBkZTqzP+OTlyPJZQG
   7VEbkmKBcgZQCyNvgzTMxUHQi7sp/4iC5b/JwpElx/WXq0bvnD+geQIFC
   vNAWwCE4UZcb76qXiOxAJymG7MyCH9R3G1Wdw3VBe8QLg0isD6aZ3sK0C
   OUzEefBWPHtwEGuw91tCmB4Ck0g1ET/wpqojDnRI/Gov1sJgVGSHxeyuQ
   x1tVidZv6yp0yb5pQlJm+8wWwRU6BaWPeh+YlIkbSJ5FU05ThLT/MzwTO
   w==;
X-CSE-ConnectionGUID: 6zyfFDEeTzK6FSJuRV5XPg==
X-CSE-MsgGUID: Q3ZFl9c0REqwOUtctuTbGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12033436"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12033436"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:03:34 -0700
X-CSE-ConnectionGUID: +pB7ZTEgSAWfnHAP641/9A==
X-CSE-MsgGUID: kkWXDYx8RraPCPpg3FjyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25681857"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Apr 2024 07:03:33 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruv1W-0008gD-1k;
	Thu, 11 Apr 2024 14:03:30 +0000
Date: Thu, 11 Apr 2024 22:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 21689e4bfb9ae8f8b45279c53faecaa5a056ffa5
Message-ID: <202404112245.ec6SSZJQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 21689e4bfb9ae8f8b45279c53faecaa5a056ffa5  locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions

elapsed time: 1454m

configs tested: 176
configs skipped: 7

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
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240411   gcc  
arc                   randconfig-002-20240411   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240411   gcc  
arm                   randconfig-002-20240411   gcc  
arm                   randconfig-003-20240411   clang
arm                   randconfig-004-20240411   gcc  
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240411   clang
arm64                 randconfig-002-20240411   gcc  
arm64                 randconfig-003-20240411   gcc  
arm64                 randconfig-004-20240411   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240411   gcc  
csky                  randconfig-002-20240411   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240411   clang
hexagon               randconfig-002-20240411   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-001-20240411   gcc  
i386                  randconfig-002-20240411   gcc  
i386                  randconfig-005-20240411   gcc  
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240411   gcc  
i386                  randconfig-013-20240411   gcc  
i386                  randconfig-014-20240411   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240411   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240411   gcc  
loongarch             randconfig-002-20240411   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                     cu1830-neo_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240411   gcc  
nios2                 randconfig-002-20240411   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240411   gcc  
parisc                randconfig-002-20240411   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                       holly_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240411   gcc  
powerpc               randconfig-002-20240411   clang
powerpc               randconfig-003-20240411   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240411   clang
powerpc64             randconfig-002-20240411   gcc  
powerpc64             randconfig-003-20240411   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240411   clang
riscv                 randconfig-002-20240411   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240411   clang
s390                  randconfig-002-20240411   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240411   gcc  
sh                    randconfig-002-20240411   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240411   gcc  
sparc64               randconfig-002-20240411   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240411   gcc  
um                    randconfig-002-20240411   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240411   gcc  
x86_64       buildonly-randconfig-002-20240411   clang
x86_64       buildonly-randconfig-003-20240411   clang
x86_64       buildonly-randconfig-004-20240411   gcc  
x86_64       buildonly-randconfig-005-20240411   clang
x86_64       buildonly-randconfig-006-20240411   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240411   clang
x86_64                randconfig-002-20240411   clang
x86_64                randconfig-003-20240411   gcc  
x86_64                randconfig-004-20240411   clang
x86_64                randconfig-005-20240411   gcc  
x86_64                randconfig-006-20240411   clang
x86_64                randconfig-011-20240411   clang
x86_64                randconfig-012-20240411   gcc  
x86_64                randconfig-013-20240411   clang
x86_64                randconfig-014-20240411   gcc  
x86_64                randconfig-015-20240411   gcc  
x86_64                randconfig-016-20240411   gcc  
x86_64                randconfig-071-20240411   clang
x86_64                randconfig-072-20240411   clang
x86_64                randconfig-073-20240411   clang
x86_64                randconfig-074-20240411   gcc  
x86_64                randconfig-075-20240411   gcc  
x86_64                randconfig-076-20240411   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240411   gcc  
xtensa                randconfig-002-20240411   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

