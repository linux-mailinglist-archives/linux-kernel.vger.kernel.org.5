Return-Path: <linux-kernel+bounces-24173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E082B882
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BC0B24523
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E468111B;
	Fri, 12 Jan 2024 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcvsN8DB"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E0A3F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705018334; x=1736554334;
  h=date:from:to:cc:subject:message-id;
  bh=vwtVgbEk9NJGIiczekQXbH9SeAquGudcwFkLo4HjMUg=;
  b=EcvsN8DBrZEs70iyiTd5sXbQgAM/hNk8sOMSoucN/hevdJL11ICAQXt2
   VjWIx7BIH4XgrFTWfxmVKj/ry+oegtuSdV3oMRaLRWesq4XWuebzMHkZ5
   QE7/gLD/thisTQTMwHUSGgDwg01HmwB8G3QzFmsREgY1XWdbOcsZFYlc4
   PsUM6EG7CnBPQGnhVe+Kv2Z++5c5Qg42Y4amvu3Zia6CGkU+S5ss5ej60
   1KT4wqNP+k0ckCdPHFN0+gWQOuJgeRWo0KBBv4YNM1ui0Urf20T/38WVE
   f64KA7opkmtg/uiEwPiam4M2OptY1HZdWfiZjl5H2YW3WlN5om/USZLZ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397915312"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="397915312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:12:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="816898214"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="816898214"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2024 16:12:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO59b-0008se-2n;
	Fri, 12 Jan 2024 00:12:07 +0000
Date: Fri, 12 Jan 2024 08:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 5ea9350aab7eda203739267355037bb7f2b46029
Message-ID: <202401120845.CbtyEPcI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 5ea9350aab7eda203739267355037bb7f2b46029  init: Kconfig: Disable -Wstringop-overflow for GCC-11

elapsed time: 1539m

configs tested: 117
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240111   gcc  
i386         buildonly-randconfig-002-20240111   gcc  
i386         buildonly-randconfig-003-20240111   gcc  
i386         buildonly-randconfig-004-20240111   gcc  
i386         buildonly-randconfig-005-20240111   gcc  
i386         buildonly-randconfig-006-20240111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240111   gcc  
i386                  randconfig-002-20240111   gcc  
i386                  randconfig-003-20240111   gcc  
i386                  randconfig-004-20240111   gcc  
i386                  randconfig-005-20240111   gcc  
i386                  randconfig-006-20240111   gcc  
i386                  randconfig-011-20240111   clang
i386                  randconfig-011-20240112   gcc  
i386                  randconfig-012-20240111   clang
i386                  randconfig-012-20240112   gcc  
i386                  randconfig-013-20240111   clang
i386                  randconfig-013-20240112   gcc  
i386                  randconfig-014-20240111   clang
i386                  randconfig-014-20240112   gcc  
i386                  randconfig-015-20240111   clang
i386                  randconfig-015-20240112   gcc  
i386                  randconfig-016-20240111   clang
i386                  randconfig-016-20240112   gcc  
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
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
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
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240112   clang
x86_64       buildonly-randconfig-002-20240112   clang
x86_64       buildonly-randconfig-003-20240112   clang
x86_64       buildonly-randconfig-004-20240112   clang
x86_64       buildonly-randconfig-005-20240112   clang
x86_64       buildonly-randconfig-006-20240112   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240112   clang
x86_64                randconfig-012-20240112   clang
x86_64                randconfig-013-20240112   clang
x86_64                randconfig-014-20240112   clang
x86_64                randconfig-015-20240112   clang
x86_64                randconfig-016-20240112   clang
x86_64                randconfig-071-20240112   clang
x86_64                randconfig-072-20240112   clang
x86_64                randconfig-073-20240112   clang
x86_64                randconfig-074-20240112   clang
x86_64                randconfig-075-20240112   clang
x86_64                randconfig-076-20240112   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

