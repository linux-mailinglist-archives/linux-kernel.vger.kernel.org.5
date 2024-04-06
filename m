Return-Path: <linux-kernel+bounces-134056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315289AC9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D754B2152E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328D47A7D;
	Sat,  6 Apr 2024 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBevw7Pf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D83F9EC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712427708; cv=none; b=NTBWb+yeZ/CfgZGtOC2VP2ZCu0TC3HTk5A3alKZPePbUftVXsVbjAfIubh4z3z/loEdoy7fwXIcUMbYDmaBZOvP+NBcWHY+N92JwYGJ4fZaehOIViPNuVg9F5VfQPuEk+vS4RQcXyi3gknV1o+wHZCwo6FmpzeMvCqabq8dcS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712427708; c=relaxed/simple;
	bh=5mDC/6n7wjBfRlMFIIw70h4iOGj7yOHYL6KkSa5vnk8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=njXblEh2XblEBnn99CpRKq8NWQj0M2roxLvo/5VBAXj35+z6Dd79f/a0Mp30viCwLASSveHm8vJhOrXORd61r+PqSJFufVZ5597D0aGgngGFtTlp1hFrOgQKfuTjs0FXzohk36JfwYxKEBpyrPiMzuXztQoiw6Cx4Tmf+adkczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBevw7Pf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712427706; x=1743963706;
  h=date:from:to:cc:subject:message-id;
  bh=5mDC/6n7wjBfRlMFIIw70h4iOGj7yOHYL6KkSa5vnk8=;
  b=iBevw7PfojZ9BwAVJqVJjMs3HTZ1W7xVZBjUvrkNZF++phhKDdnnq8Eu
   9f3xibBrTYlNiZrpkyGfzEobUt4+EUx0gsHmOx+Reok/EnGu0477QOJ8P
   zu7VtQK2y3Ag/Y6Umz8x27r54n5rgdV5OwlO3MgSmmTUIrpYMkF9lJXHT
   0E5oCFycnLKQVCJuV2M+VvfSZRmkJKh9ZqTF2Hc2qzIYwOXzzPGzyob00
   ra5QNppO68WmORejZi6UvGrwcVbK3SC3hyLmY5ETYW9D234aw+kiw0Q7O
   4UNHl7JKMS7eY7lDoF2ngTRi0eTj6tNAnwll69z+ErArRKCdLpJmjHSBj
   Q==;
X-CSE-ConnectionGUID: gjkqV9/bQ/mCoCC6g3YZdw==
X-CSE-MsgGUID: hjAPFKClSxmF/r1x7HmXxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7601546"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="7601546"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 11:21:45 -0700
X-CSE-ConnectionGUID: /NKLWA4zS0Gcs5garhevkQ==
X-CSE-MsgGUID: Iju+YS8oQK+I0B+4EeRL5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="24195297"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Apr 2024 11:21:44 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtAfe-0003kz-0f;
	Sat, 06 Apr 2024 18:21:42 +0000
Date: Sun, 07 Apr 2024 02:20:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240405-CbC] BUILD SUCCESS
 446e1bb72bfad4018cdcaf9895c368da98082ce8
Message-ID: <202404070241.mz87xxb2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240405-CbC
branch HEAD: 446e1bb72bfad4018cdcaf9895c368da98082ce8  qtnfmac: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 723m

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
arc                   randconfig-001-20240406   gcc  
arc                   randconfig-002-20240406   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240406   clang
arm                   randconfig-002-20240406   clang
arm                   randconfig-003-20240406   gcc  
arm                   randconfig-004-20240406   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240406   clang
arm64                 randconfig-002-20240406   clang
arm64                 randconfig-003-20240406   clang
arm64                 randconfig-004-20240406   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240406   gcc  
csky                  randconfig-002-20240406   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240406   clang
hexagon               randconfig-002-20240406   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240406   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240406   gcc  
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240406   gcc  
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240406   gcc  
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240406   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240406   gcc  
loongarch             randconfig-002-20240406   gcc  
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
mips                        bcm47xx_defconfig   clang
mips                           ip27_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240406   gcc  
nios2                 randconfig-002-20240406   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240406   gcc  
parisc                randconfig-002-20240406   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc               randconfig-001-20240406   clang
powerpc               randconfig-002-20240406   clang
powerpc               randconfig-003-20240406   gcc  
powerpc64             randconfig-001-20240406   gcc  
powerpc64             randconfig-002-20240406   gcc  
powerpc64             randconfig-003-20240406   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240406   gcc  
riscv                 randconfig-002-20240406   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240406   gcc  
s390                  randconfig-002-20240406   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240406   gcc  
sh                    randconfig-002-20240406   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240406   gcc  
sparc64               randconfig-002-20240406   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240406   clang
um                    randconfig-002-20240406   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240406   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-003-20240406   clang
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64       buildonly-randconfig-006-20240406   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-002-20240406   clang
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-004-20240406   clang
x86_64                randconfig-005-20240406   clang
x86_64                randconfig-006-20240406   clang
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-012-20240406   clang
x86_64                randconfig-013-20240406   clang
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-016-20240406   clang
x86_64                randconfig-071-20240406   clang
x86_64                randconfig-072-20240406   clang
x86_64                randconfig-073-20240406   clang
x86_64                randconfig-074-20240406   clang
x86_64                randconfig-075-20240406   clang
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240406   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

