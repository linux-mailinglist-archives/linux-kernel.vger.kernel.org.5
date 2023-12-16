Return-Path: <linux-kernel+bounces-2289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B0815A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FC3285B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784633066C;
	Sat, 16 Dec 2023 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXvKlRUp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCB30645
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702746221; x=1734282221;
  h=date:from:to:cc:subject:message-id;
  bh=9EDOCvMvn+Uh6h7Zl6UFrabi57qU0svRisTOq+IgxMo=;
  b=MXvKlRUptubvfjXNPE+D0LVdZehkLie+ESGCo1GSY3tNcoROByx1/sOh
   NjtxwYlJYv7nTPGFw2lXtTNl8RkiZ7chp3uGVc4A1mLtsezh7F19bjGio
   xUlYxERDtMa8uowR6zw3RoSQKd6x97ToirC73tullzCOkMFcgu5pT6543
   +qzRGFKd2qaxHLjoEVZVAiUWPcQqGJ74Gm0+bL+X04Ew8ox5tl+NEK2jf
   XDBQEklaD66o75V05aZtJiJR9FePpdwsF7JoduHUHKFZbTDFQ+0xOMQt7
   IaYUF6jO67CR0FYEvgOquV9nsXohbIH50nGdr/KNn9/gvKKrNsi2Hx06R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2234178"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="2234178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 09:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="804055814"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="804055814"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2023 09:03:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEY4W-0001us-0I;
	Sat, 16 Dec 2023 17:03:28 +0000
Date: Sun, 17 Dec 2023 01:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 1f68ce2a027250aeeb1756391110cdc4dc97c797
Message-ID: <202312170148.mwlkNgnN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 1f68ce2a027250aeeb1756391110cdc4dc97c797  x86/mce: Handle Intel threshold interrupt storms

elapsed time: 1474m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
arm64                 randconfig-002-20231216   gcc  
arm64                 randconfig-003-20231216   gcc  
arm64                 randconfig-004-20231216   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231216   gcc  
csky                  randconfig-002-20231216   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231216   clang
hexagon               randconfig-002-20231216   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231216   gcc  
i386         buildonly-randconfig-002-20231216   gcc  
i386         buildonly-randconfig-003-20231216   gcc  
i386         buildonly-randconfig-004-20231216   gcc  
i386         buildonly-randconfig-005-20231216   gcc  
i386         buildonly-randconfig-006-20231216   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231216   gcc  
i386                  randconfig-002-20231216   gcc  
i386                  randconfig-003-20231216   gcc  
i386                  randconfig-004-20231216   gcc  
i386                  randconfig-005-20231216   gcc  
i386                  randconfig-006-20231216   gcc  
i386                  randconfig-011-20231216   clang
i386                  randconfig-012-20231216   clang
i386                  randconfig-013-20231216   clang
i386                  randconfig-014-20231216   clang
i386                  randconfig-015-20231216   clang
i386                  randconfig-016-20231216   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231216   gcc  
loongarch             randconfig-002-20231216   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231216   gcc  
nios2                 randconfig-002-20231216   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231216   gcc  
parisc                randconfig-002-20231216   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20231216   gcc  
powerpc               randconfig-002-20231216   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231216   gcc  
x86_64       buildonly-randconfig-002-20231216   gcc  
x86_64       buildonly-randconfig-003-20231216   gcc  
x86_64       buildonly-randconfig-004-20231216   gcc  
x86_64       buildonly-randconfig-005-20231216   gcc  
x86_64       buildonly-randconfig-006-20231216   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231216   clang
x86_64                randconfig-002-20231216   clang
x86_64                randconfig-003-20231216   clang
x86_64                randconfig-004-20231216   clang
x86_64                randconfig-005-20231216   clang
x86_64                randconfig-006-20231216   clang
x86_64                randconfig-011-20231216   gcc  
x86_64                randconfig-012-20231216   gcc  
x86_64                randconfig-013-20231216   gcc  
x86_64                randconfig-014-20231216   gcc  
x86_64                randconfig-015-20231216   gcc  
x86_64                randconfig-016-20231216   gcc  
x86_64                randconfig-071-20231216   gcc  
x86_64                randconfig-072-20231216   gcc  
x86_64                randconfig-073-20231216   gcc  
x86_64                randconfig-074-20231216   gcc  
x86_64                randconfig-075-20231216   gcc  
x86_64                randconfig-076-20231216   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

