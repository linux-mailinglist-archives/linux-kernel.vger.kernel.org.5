Return-Path: <linux-kernel+bounces-2488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BB8815DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64839B229EC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B8185B;
	Sun, 17 Dec 2023 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPID4WuM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D61845
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702796736; x=1734332736;
  h=date:from:to:cc:subject:message-id;
  bh=SfVhyC97GgMPM/mxX1Cfgfxm5KDzRcSX3KZyvrqNajA=;
  b=kPID4WuMSezEvtrbMEmBWRqgQxqDwcrug7mAuCqAuHvBZ6bjNvyG3/7O
   f3bSKqWaH7k+K+LhJ9NT4Djzb/0FM9820Gl6mpXLdLxaI2Zn0pN/qpRLn
   JMd8u3SI3FqE4sPtj8lEYmX5MJlcNtRT2A6mNQOz+dKqI8YAwLguGT7KT
   lIH2rAM0xVioDZwkJyx6Pun+jhkMp4Ai/ly1eXxPOTnHs6+YYtcnj2wNh
   cTzJGb0epgXgk8YcwNG7pIEhUkNCIevEUCW7QG2DsforgAjRYCVMs8sS6
   PHyDst8oEHUzn3/7Z2cxhsNnmfRAskDXEsNPQdmlOvlgzD4FbA2VM9yCI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="395140564"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="395140564"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 23:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="865871837"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="865871837"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2023 23:05:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rElDQ-0002mU-1F;
	Sun, 17 Dec 2023 07:05:32 +0000
Date: Sun, 17 Dec 2023 15:04:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 2dc4196138055eb0340231aecac4d78c2ec2bea5
Message-ID: <202312171534.V2K18mjZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 2dc4196138055eb0340231aecac4d78c2ec2bea5  x86/alternatives: Disable interrupts and sync when optimizing NOPs in place

elapsed time: 1084m

configs tested: 120
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                             rpc_defconfig   gcc  
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
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231217   clang
x86_64       buildonly-randconfig-002-20231217   clang
x86_64       buildonly-randconfig-003-20231217   clang
x86_64       buildonly-randconfig-004-20231217   clang
x86_64       buildonly-randconfig-005-20231217   clang
x86_64       buildonly-randconfig-006-20231217   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231217   clang
x86_64                randconfig-012-20231217   clang
x86_64                randconfig-013-20231217   clang
x86_64                randconfig-014-20231217   clang
x86_64                randconfig-015-20231217   clang
x86_64                randconfig-016-20231217   clang
x86_64                randconfig-071-20231217   clang
x86_64                randconfig-072-20231217   clang
x86_64                randconfig-073-20231217   clang
x86_64                randconfig-074-20231217   clang
x86_64                randconfig-075-20231217   clang
x86_64                randconfig-076-20231217   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

