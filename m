Return-Path: <linux-kernel+bounces-6201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3C8195D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D836B282CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DA23BB;
	Wed, 20 Dec 2023 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgwLLqJV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9B1FAF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703033134; x=1734569134;
  h=date:from:to:cc:subject:message-id;
  bh=GYPHL4RA1huHvRI2dq8LlXaE4QNA41e4Z2zZQ6OeCrE=;
  b=PgwLLqJV9s/aNwhKmzqEy8FWELyjjqyDJp9SXg5oTlGv9VZNrKD9jqJf
   9B3Bvfv66acLWOC/ssgCexiLk9ZW2SupEfIHQ5kDJkV3FpS2KCEhXG/eN
   SRWqIch15OuAM5sBNvqyoO6LIjwfIxzARW4FbLPAHOuh//i3Zs1lzN8y6
   AAedQU74GgBSQU7uIbupP6xbvY5wjLT5GJZ8/zd/3j8XaTjJ2xElfLzSb
   sJTiJU8GaWu9M9cYg7boDgw8SZC9U+eKZHQzm1YjWBj4FEV4TM/eEIKE4
   FFrkBG9h3uPnQWkJhwNAw3m4JRN24PHKkOWFTGj4ykejzx762+nuBO/jx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="17297220"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="17297220"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779665624"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779665624"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Dec 2023 16:45:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFkiH-00068B-2U;
	Wed, 20 Dec 2023 00:45:29 +0000
Date: Wed, 20 Dec 2023 08:44:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 88a2b4edda3d0709727be53f4423b0b832d91de3
Message-ID: <202312200842.Ku9syy2G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 88a2b4edda3d0709727be53f4423b0b832d91de3  x86/Kconfig: Rework CONFIG_X86_PAE dependency

elapsed time: 753m

configs tested: 117
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231219   clang
i386         buildonly-randconfig-002-20231219   clang
i386         buildonly-randconfig-003-20231219   clang
i386         buildonly-randconfig-004-20231219   clang
i386         buildonly-randconfig-005-20231219   clang
i386         buildonly-randconfig-006-20231219   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231219   clang
i386                  randconfig-002-20231219   clang
i386                  randconfig-003-20231219   clang
i386                  randconfig-004-20231219   clang
i386                  randconfig-005-20231219   clang
i386                  randconfig-006-20231219   clang
i386                  randconfig-011-20231219   gcc  
i386                  randconfig-011-20231220   clang
i386                  randconfig-012-20231219   gcc  
i386                  randconfig-012-20231220   clang
i386                  randconfig-013-20231219   gcc  
i386                  randconfig-013-20231220   clang
i386                  randconfig-014-20231219   gcc  
i386                  randconfig-014-20231220   clang
i386                  randconfig-015-20231219   gcc  
i386                  randconfig-015-20231220   clang
i386                  randconfig-016-20231219   gcc  
i386                  randconfig-016-20231220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231220   gcc  
x86_64       buildonly-randconfig-002-20231220   gcc  
x86_64       buildonly-randconfig-003-20231220   gcc  
x86_64       buildonly-randconfig-004-20231220   gcc  
x86_64       buildonly-randconfig-005-20231220   gcc  
x86_64       buildonly-randconfig-006-20231220   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231220   gcc  
x86_64                randconfig-012-20231220   gcc  
x86_64                randconfig-013-20231220   gcc  
x86_64                randconfig-014-20231220   gcc  
x86_64                randconfig-015-20231220   gcc  
x86_64                randconfig-016-20231220   gcc  
x86_64                randconfig-071-20231220   gcc  
x86_64                randconfig-072-20231220   gcc  
x86_64                randconfig-073-20231220   gcc  
x86_64                randconfig-074-20231220   gcc  
x86_64                randconfig-075-20231220   gcc  
x86_64                randconfig-076-20231220   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

