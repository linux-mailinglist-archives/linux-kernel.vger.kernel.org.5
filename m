Return-Path: <linux-kernel+bounces-4597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35704817FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F78D28345C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831375253;
	Tue, 19 Dec 2023 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7OG5Zvi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9704468A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702953038; x=1734489038;
  h=date:from:to:cc:subject:message-id;
  bh=In0QvpJjkggc3cIkkX2AG89mlryu++eRlRsTBAIj5Dc=;
  b=V7OG5ZviPrDed2ZncrLcz0L0Ze8Bgk3X2GbEcAUTBcnehPtXMfYXbVfu
   DVGEVpS/OFgOrNwRdZzfHLJv8tHtIvj2o/H7zzsta7EAN0kOD3hTnSkt3
   C//eYZgLNNpWK90vuyw5Ycm45xAV5WNltnKS6jFTMrOu6GYzZehc4tntO
   cCSKrwhO6Wwpmj+Uz/tQ9d4K3Bl2UpGESpOHgL9+wH5KrT5ToVLre+LiD
   gvh7HEjMe2jaRWnQb6UzJlPbMA74z/450hSJbwSTAo9UmnQmbahALkHju
   P5EeAlhOS88VrM4msiCcDMLgKpeG3BBEVNgvfPwRxGbtXRZOddY//qNN+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="398381694"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="398381694"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 18:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804733157"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="804733157"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2023 18:30:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFPsG-0004ko-0Y;
	Tue, 19 Dec 2023 02:30:28 +0000
Date: Tue, 19 Dec 2023 10:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d5a10b976ecb77fa49b95f3f1016ca2997c122cb
Message-ID: <202312191031.423bEfVo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d5a10b976ecb77fa49b95f3f1016ca2997c122cb  x86/acpi: Handle bogus MADT APIC tables gracefully

elapsed time: 740m

configs tested: 109
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231218   gcc  
i386         buildonly-randconfig-002-20231218   gcc  
i386         buildonly-randconfig-003-20231218   gcc  
i386         buildonly-randconfig-004-20231218   gcc  
i386         buildonly-randconfig-005-20231218   gcc  
i386         buildonly-randconfig-006-20231218   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231218   gcc  
i386                  randconfig-002-20231218   gcc  
i386                  randconfig-003-20231218   gcc  
i386                  randconfig-004-20231218   gcc  
i386                  randconfig-005-20231218   gcc  
i386                  randconfig-006-20231218   gcc  
i386                  randconfig-011-20231218   clang
i386                  randconfig-011-20231219   gcc  
i386                  randconfig-012-20231218   clang
i386                  randconfig-012-20231219   gcc  
i386                  randconfig-013-20231218   clang
i386                  randconfig-013-20231219   gcc  
i386                  randconfig-014-20231218   clang
i386                  randconfig-014-20231219   gcc  
i386                  randconfig-015-20231218   clang
i386                  randconfig-015-20231219   gcc  
i386                  randconfig-016-20231218   clang
i386                  randconfig-016-20231219   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                               defconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231219   clang
x86_64       buildonly-randconfig-002-20231219   clang
x86_64       buildonly-randconfig-003-20231219   clang
x86_64       buildonly-randconfig-004-20231219   clang
x86_64       buildonly-randconfig-005-20231219   clang
x86_64       buildonly-randconfig-006-20231219   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231219   clang
x86_64                randconfig-012-20231219   clang
x86_64                randconfig-013-20231219   clang
x86_64                randconfig-014-20231219   clang
x86_64                randconfig-015-20231219   clang
x86_64                randconfig-016-20231219   clang
x86_64                randconfig-071-20231219   clang
x86_64                randconfig-072-20231219   clang
x86_64                randconfig-073-20231219   clang
x86_64                randconfig-074-20231219   clang
x86_64                randconfig-075-20231219   clang
x86_64                randconfig-076-20231219   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

