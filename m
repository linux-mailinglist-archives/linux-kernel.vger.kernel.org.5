Return-Path: <linux-kernel+bounces-161564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD18B4DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686211F2120A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9D8BF0;
	Sun, 28 Apr 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo5ieR86"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E7389
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714336851; cv=none; b=iODKru0Vl9ylq7ZsKi3nKGiGo+CCI74oSjZdYtmY9t647t37o1Okaw1PVFi3N0Inpa5ZmcTRJoFQqTNrMe/PyWRum1LIQBPkPbilF3/ZSP5t5PMlZ8QTpCyMKPPopyXm4OD1zUvQjWHBoNDye+riVqFq8hBEJb//OXoHrwwugls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714336851; c=relaxed/simple;
	bh=lDWxile2I7M8x6r0NlvEmESN/WnANxmW78NTMpySTlk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fuX7VN63/dYPEIjcv+wK3PkN1Z5IEaii+UP4EBn6XXM8hp6i1xPNyHSJ+xDtRGcdiYyBBR/sfKJKofGuMOkaiNKPO6YDgG1OjLNwRf3w6LZW2btFhJ178tg+70qshJ8UDXyzXljhFcyG5BiJb2xRjTV9nNQLfpe76owP1qM3cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo5ieR86; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714336849; x=1745872849;
  h=date:from:to:cc:subject:message-id;
  bh=lDWxile2I7M8x6r0NlvEmESN/WnANxmW78NTMpySTlk=;
  b=Wo5ieR86eejyzPK9/Fd2JUh8iTM+isAMpqxRcHXCr2b6iSB9VushqagF
   20+DUBO4PxifICgedK56NaVAfiQeFFgQpOV9soJHL9pKmx5KhXAKVy/qA
   tIkD0t6WOu2n4rPyyy5hln/NrCwxJ9Z+GgFRIHCR56AJjB6V7+EDQtJqA
   ldGqUOaj1v53pKc0XyajQtRwTWw836As4VUd4+15F6y6T7DJngsrO0aJf
   0gy/XiDCbRX1ENX/9XC3kUJhH+cnR/cFYkmg3gXERE1+m9DaJWT1G4hfq
   pigmnrxoMeTkmz5LVblG927hz+KHeC8odhAQ+IhyoQ79HyopfhCjdrmWe
   g==;
X-CSE-ConnectionGUID: LTmo9ItBQqeh4S7aktYI3A==
X-CSE-MsgGUID: cfdliKGPTHSD9UniCLrepQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13824312"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="13824312"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 13:40:48 -0700
X-CSE-ConnectionGUID: dZHFPP7/T2idJl6xLsZ6pA==
X-CSE-MsgGUID: Y7pMHbfASOS6+zBUM9qNGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30718195"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Apr 2024 13:40:47 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1BKG-0006jq-0C;
	Sun, 28 Apr 2024 20:40:44 +0000
Date: Mon, 29 Apr 2024 04:40:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 257bf89d84121280904800acd25cc2c444c717ae
Message-ID: <202404290421.gwP6Ubv9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 257bf89d84121280904800acd25cc2c444c717ae  sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

elapsed time: 722m

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
arc                   randconfig-001-20240428   gcc  
arc                   randconfig-002-20240428   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                            mmp2_defconfig   gcc  
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240428   gcc  
arm                   randconfig-002-20240428   clang
arm                   randconfig-003-20240428   clang
arm                   randconfig-004-20240428   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240428   gcc  
arm64                 randconfig-002-20240428   gcc  
arm64                 randconfig-003-20240428   clang
arm64                 randconfig-004-20240428   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240428   gcc  
csky                  randconfig-002-20240428   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240428   clang
hexagon               randconfig-002-20240428   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240428   gcc  
i386         buildonly-randconfig-002-20240428   clang
i386         buildonly-randconfig-003-20240428   clang
i386         buildonly-randconfig-004-20240428   clang
i386         buildonly-randconfig-005-20240428   clang
i386         buildonly-randconfig-006-20240428   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240428   clang
i386                  randconfig-002-20240428   clang
i386                  randconfig-003-20240428   clang
i386                  randconfig-004-20240428   clang
i386                  randconfig-005-20240428   gcc  
i386                  randconfig-006-20240428   gcc  
i386                  randconfig-011-20240428   gcc  
i386                  randconfig-012-20240428   clang
i386                  randconfig-013-20240428   gcc  
i386                  randconfig-014-20240428   gcc  
i386                  randconfig-015-20240428   clang
i386                  randconfig-016-20240428   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240428   gcc  
loongarch             randconfig-002-20240428   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240428   gcc  
nios2                 randconfig-002-20240428   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240428   gcc  
parisc                randconfig-002-20240428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240428   clang
powerpc               randconfig-002-20240428   gcc  
powerpc               randconfig-003-20240428   gcc  
powerpc                     tqm8548_defconfig   clang
powerpc64             randconfig-001-20240428   gcc  
powerpc64             randconfig-002-20240428   clang
powerpc64             randconfig-003-20240428   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240428   gcc  
riscv                 randconfig-002-20240428   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240428   clang
s390                  randconfig-002-20240428   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240428   gcc  
sh                    randconfig-002-20240428   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240428   gcc  
sparc64               randconfig-002-20240428   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240428   clang
um                    randconfig-002-20240428   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240428   gcc  
x86_64       buildonly-randconfig-002-20240428   clang
x86_64       buildonly-randconfig-003-20240428   gcc  
x86_64       buildonly-randconfig-004-20240428   clang
x86_64       buildonly-randconfig-005-20240428   gcc  
x86_64       buildonly-randconfig-006-20240428   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240428   gcc  
x86_64                randconfig-002-20240428   clang
x86_64                randconfig-003-20240428   gcc  
x86_64                randconfig-004-20240428   clang
x86_64                randconfig-005-20240428   gcc  
x86_64                randconfig-006-20240428   clang
x86_64                randconfig-011-20240428   gcc  
x86_64                randconfig-012-20240428   clang
x86_64                randconfig-013-20240428   gcc  
x86_64                randconfig-014-20240428   clang
x86_64                randconfig-015-20240428   clang
x86_64                randconfig-016-20240428   gcc  
x86_64                randconfig-071-20240428   gcc  
x86_64                randconfig-072-20240428   clang
x86_64                randconfig-073-20240428   gcc  
x86_64                randconfig-074-20240428   gcc  
x86_64                randconfig-075-20240428   clang
x86_64                randconfig-076-20240428   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240428   gcc  
xtensa                randconfig-002-20240428   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

