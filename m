Return-Path: <linux-kernel+bounces-158894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AB8B2665
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48711F22390
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27E14D2B2;
	Thu, 25 Apr 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOXMhsSw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCB12C466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062429; cv=none; b=hPvM2lQaeEsecHpTTcG7sVFz6aLvBMToZwrg8fbspHfGA1MUT4BxTo2o/OxaSKsjTm90y2e/eEJDQsUT4yL9j6mN6cfWPscrGtGR8WyU/XzBQCd4pyyfOY0gjChRFtGDn/+n3Vd1W/8K+70UloSE7MC9dK2K+sSZqBhkSmXmFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062429; c=relaxed/simple;
	bh=p7/5jJEknNzH52HmWmbdfokTUKdPfNcKZg7IYy4as+M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RnmaZWBil/xkXWZPLbYDc0lHjJuyENQSodbCu5BR7Qn7KbRu4te/EpYh5APsbgsKDAsDYAR+JBwccZTsfozkpVxRKqEfaaQIEQuKMmX7Xef9WVnRd6nS5jrBlYemS4wbkFcnUaEPVsMwOo2pdDfF3ZrTMydKCna/zFczm/OlzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOXMhsSw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714062427; x=1745598427;
  h=date:from:to:cc:subject:message-id;
  bh=p7/5jJEknNzH52HmWmbdfokTUKdPfNcKZg7IYy4as+M=;
  b=WOXMhsSwqD7NnFN4wSm83JKTqCQLN/V0wrUHnOU/bTXqAOWtyqh80WBx
   RYzhdORpQRFxqU5lzsDeYi/nQBb+egsoOi8XZdfhZjJRevARyrigZUpJc
   iTMmTB1OWb63pC35s1nQmyLDieWKnYUruSbDEUmuja/+/PcEheUSLyoc2
   3QrpuJQ142+fXeM6AlbVEzaBE7imBAtIJHB0QW334+d3gOgWLLfoduWfK
   Dy2vW89LpXxnL1bgbvgG33sogaPcQe9ViPCZSCL10b7bbvRguHdoRKLFo
   4HNu73K3Ih/6JMGc+VHLAd0eT4IcwSTTRbqizPcPY0I3lweq9EUMyPDmd
   w==;
X-CSE-ConnectionGUID: mxNLi9rmQaasHMKHu5yASA==
X-CSE-MsgGUID: 0OMfFSFRQX2RW6nEdH4IJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9589075"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9589075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 09:27:07 -0700
X-CSE-ConnectionGUID: l2DntHY9QWm2xfQM0Sns0A==
X-CSE-MsgGUID: 64vB+KuJTzKS0Krs1z9nXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25221977"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Apr 2024 09:27:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s01w7-0002b5-2K;
	Thu, 25 Apr 2024 16:27:03 +0000
Date: Fri, 26 Apr 2024 00:26:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240424-CbC] BUILD SUCCESS
 bebcd7097d3b1b92e3f246f7f3248f241f99d04f
Message-ID: <202404260032.yaC1cjKY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240424-CbC
branch HEAD: bebcd7097d3b1b92e3f246f7f3248f241f99d04f  wifi: rtlwifi: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1604m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240425   gcc  
arc                   randconfig-002-20240425   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                      integrator_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240425   clang
arm                   randconfig-002-20240425   clang
arm                   randconfig-003-20240425   clang
arm                   randconfig-004-20240425   clang
arm                       spear13xx_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240425   gcc  
arm64                 randconfig-002-20240425   gcc  
arm64                 randconfig-003-20240425   gcc  
arm64                 randconfig-004-20240425   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240425   gcc  
csky                  randconfig-002-20240425   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240425   gcc  
i386         buildonly-randconfig-002-20240425   clang
i386         buildonly-randconfig-003-20240425   gcc  
i386         buildonly-randconfig-004-20240425   clang
i386         buildonly-randconfig-005-20240425   clang
i386         buildonly-randconfig-006-20240425   gcc  
i386                  randconfig-001-20240425   clang
i386                  randconfig-002-20240425   clang
i386                  randconfig-003-20240425   clang
i386                  randconfig-004-20240425   gcc  
i386                  randconfig-005-20240425   clang
i386                  randconfig-006-20240425   clang
i386                  randconfig-011-20240425   clang
i386                  randconfig-012-20240425   clang
i386                  randconfig-013-20240425   gcc  
i386                  randconfig-014-20240425   gcc  
i386                  randconfig-015-20240425   gcc  
i386                  randconfig-016-20240425   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240425   gcc  
m68k                             alldefconfig   gcc  
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
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     tqm8555_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

