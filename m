Return-Path: <linux-kernel+bounces-2812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C122281624A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382511C20F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4849F6A;
	Sun, 17 Dec 2023 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYt6b+qm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74C49F60
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702847270; x=1734383270;
  h=date:from:to:cc:subject:message-id;
  bh=7VNMIhqijNox9wCT3jThtBuMkO28BLO475GfpGYDzUw=;
  b=QYt6b+qmjQyQn76gPGrXPe46HRRyQXOpn1zzWyQozfl0niPbGf7kMACV
   bJL3J5afi7msU+8iDfXC9cnXETH6gOhQ/62zgL8A1gu6ZzTAcqef8B7Gr
   +eaP6on48ets6Q8k2fgqLWw96YUo9Ixz8DBq6IWEAwAwgJubER/j3U8ew
   g8V9OIkxEIu5UCGoYdd5d0CPxPXxCpwhi+VmbLpJXYJWO136tPxoaQo9l
   24C+fw8cWb7AK1KcsPuia3qQOl6TrBWMZRIss9AYYJIhkcRXfKI3uw0ON
   Sw0yYgh5k1SaZob1sZkZPIEm7qnxtqA824ZMbrZ8uYQ+0/IU4kBfEgibG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8789376"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="8789376"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 13:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898752480"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="898752480"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2023 13:07:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEyMT-0003QO-0Y;
	Sun, 17 Dec 2023 21:07:45 +0000
Date: Mon, 18 Dec 2023 05:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b14a5a4af75ee4226251bd076373ffce38335bfe
Message-ID: <202312180500.p8KrvqyC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b14a5a4af75ee4226251bd076373ffce38335bfe  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1463m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231218   gcc  
arc                   randconfig-002-20231218   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                   randconfig-001-20231218   gcc  
arm                   randconfig-002-20231218   gcc  
arm                   randconfig-003-20231218   gcc  
arm                   randconfig-004-20231218   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231218   gcc  
arm64                 randconfig-002-20231218   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231217   clang
i386         buildonly-randconfig-002-20231217   clang
i386         buildonly-randconfig-003-20231217   clang
i386         buildonly-randconfig-004-20231217   clang
i386         buildonly-randconfig-005-20231217   clang
i386         buildonly-randconfig-006-20231217   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231217   clang
i386                  randconfig-002-20231217   clang
i386                  randconfig-003-20231217   clang
i386                  randconfig-004-20231217   clang
i386                  randconfig-005-20231217   clang
i386                  randconfig-006-20231217   clang
i386                  randconfig-011-20231217   gcc  
i386                  randconfig-012-20231217   gcc  
i386                  randconfig-013-20231217   gcc  
i386                  randconfig-014-20231217   gcc  
i386                  randconfig-015-20231217   gcc  
i386                  randconfig-016-20231217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
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
powerpc                   bluestone_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

