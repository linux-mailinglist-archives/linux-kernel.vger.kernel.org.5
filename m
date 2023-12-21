Return-Path: <linux-kernel+bounces-9085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607E81C04B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DA3B21BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412D76DD6;
	Thu, 21 Dec 2023 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkZPTb8A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A59745DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703194632; x=1734730632;
  h=date:from:to:cc:subject:message-id;
  bh=ZjyV4fqw4yiQgogMLosUiSy9wAEF6vT3f29B6pnuh18=;
  b=TkZPTb8AbY9b8GjacqaqKuG7JrCR4lPfe8ZqzUxKlvV1Oz/+v0JMIBPN
   OHOl16HH27chECsOUMklcCxD3KVIYX7dTR2RVtsh+fQU/bbvNuFZtjqRp
   U3cwhq4wgwWyHRWyZ2/sJlhb7k3o68O0+1aEIpswGswZYdO1z5dWFhURQ
   3d4rk0mNQkYVXWPoBmM1+RKY9YjmCFRpj2zZMbCbouxqc4+FPVs4e00bo
   6TE+6bHtX1fgqZrwy5t+jTH8JZB87TbPZReS/n/jIdtdVYE9575ub4S6b
   ayJ+vcVrjA5TpkTptBpITtIgupVgaDR07JR1bLdC5FoYjOLkHGm3L/JYO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="381026803"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="381026803"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 13:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="780340277"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="780340277"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Dec 2023 13:37:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGQj5-0008kT-14;
	Thu, 21 Dec 2023 21:37:07 +0000
Date: Fri, 22 Dec 2023 05:32:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 257ca14f4d780e27a0605fd68053d2cc3178a232
Message-ID: <202312220534.0IhbmFbM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 257ca14f4d780e27a0605fd68053d2cc3178a232  x86/boot: Remove redundant initialization of the 'delta' variable in strcmp()

elapsed time: 1427m

configs tested: 146
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231221   gcc  
arc                   randconfig-002-20231221   gcc  
arm                               allnoconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                       spear13xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231221   gcc  
csky                  randconfig-002-20231221   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231221   gcc  
i386                  randconfig-012-20231221   gcc  
i386                  randconfig-013-20231221   gcc  
i386                  randconfig-014-20231221   gcc  
i386                  randconfig-015-20231221   gcc  
i386                  randconfig-016-20231221   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231221   gcc  
loongarch             randconfig-002-20231221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                      pic32mzda_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231221   gcc  
nios2                 randconfig-002-20231221   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231221   gcc  
parisc                randconfig-002-20231221   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231221   gcc  
s390                  randconfig-002-20231221   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20231221   gcc  
sh                    randconfig-002-20231221   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231221   gcc  
sparc64               randconfig-002-20231221   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231221   clang
x86_64       buildonly-randconfig-001-20231222   gcc  
x86_64       buildonly-randconfig-002-20231221   clang
x86_64       buildonly-randconfig-002-20231222   gcc  
x86_64       buildonly-randconfig-003-20231221   clang
x86_64       buildonly-randconfig-003-20231222   gcc  
x86_64       buildonly-randconfig-004-20231221   clang
x86_64       buildonly-randconfig-004-20231222   gcc  
x86_64       buildonly-randconfig-005-20231221   clang
x86_64       buildonly-randconfig-005-20231222   gcc  
x86_64       buildonly-randconfig-006-20231221   clang
x86_64       buildonly-randconfig-006-20231222   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231221   clang
x86_64                randconfig-011-20231222   gcc  
x86_64                randconfig-012-20231221   clang
x86_64                randconfig-012-20231222   gcc  
x86_64                randconfig-013-20231221   clang
x86_64                randconfig-013-20231222   gcc  
x86_64                randconfig-014-20231221   clang
x86_64                randconfig-014-20231222   gcc  
x86_64                randconfig-015-20231221   clang
x86_64                randconfig-015-20231222   gcc  
x86_64                randconfig-016-20231221   clang
x86_64                randconfig-016-20231222   gcc  
x86_64                randconfig-071-20231221   clang
x86_64                randconfig-071-20231222   gcc  
x86_64                randconfig-072-20231221   clang
x86_64                randconfig-072-20231222   gcc  
x86_64                randconfig-073-20231221   clang
x86_64                randconfig-073-20231222   gcc  
x86_64                randconfig-074-20231221   clang
x86_64                randconfig-074-20231222   gcc  
x86_64                randconfig-075-20231221   clang
x86_64                randconfig-075-20231222   gcc  
x86_64                randconfig-076-20231221   clang
x86_64                randconfig-076-20231222   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231221   gcc  
xtensa                randconfig-002-20231221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

