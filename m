Return-Path: <linux-kernel+bounces-165923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF68B937E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88DBB20F82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239318E1D;
	Thu,  2 May 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0FjTwDS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19317C6C
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 02:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618558; cv=none; b=hwfdfq4x5Eq+tnZbI3RV34Y1QxMSPcKMrLhW8ALSy6q94u1qeh1CPRCE8W5ojIGAqrcfijN8MxlRu0uoy6uHGk45gJDf6tQaIGfndgmcx7hBbkCL114+STFCuf8ebnrosNjJKKrjGo1WrGqLX3YL+jjd5KW+JZBlUjEa0LCY9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618558; c=relaxed/simple;
	bh=rOYtVnECOk4vxRBuyHoxcpxugZsLeVIL0sFgchXLl+g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mcjgqMyvSB4D0G9999teD1y2chJmcIpJ0478CfXAxV2s7bhfqKc+Q4oPeUvLUxh5PY1mvK3p9bGMMjh3H6lnJccoa1EHTX3udK5mAFiSi4ax1CJ1QouLgtGnCUtBkmPWBbO9UQ14TOuKOaYh494dhvw2f4rUeDqZJFGV30ArJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0FjTwDS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714618557; x=1746154557;
  h=date:from:to:cc:subject:message-id;
  bh=rOYtVnECOk4vxRBuyHoxcpxugZsLeVIL0sFgchXLl+g=;
  b=a0FjTwDSKhNTHHIm7Rg8YgV+I73PVLb6X4XzH6/NiPmyu/xfvRaXdrKH
   1hKyiyROfrl2tKl+ir4KJ4vymSvkRtQ+mnrNiak5dwb9y0pbwCfqOmPPr
   Fkj07Ye7ejMs2bajNalZ+plzRg5fGV2t+i95XGQguS/QZxSxzqn+Qd4HW
   igQM4NyYuTLHJwo/DMvURWmIr0CzPtFBiwgaNr7FthXw1QXTsMKMocWzm
   GvyqoJ75S9XJHtO5MgL0dCpK1t2hFwXZ5tEZb+nvMOybDnNK63y+YNLjv
   ngmLmU7p4Ys3LroAeCEEg/07rZcN4HmyiPig8FApybwG1DR0aC10GwXuw
   w==;
X-CSE-ConnectionGUID: 9lNfrwFkRpuz9A7Rga/Flw==
X-CSE-MsgGUID: 2RpUpSZ+RsKf9JqQshRaow==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="32887783"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32887783"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 19:55:56 -0700
X-CSE-ConnectionGUID: va/u2pC1SRqMILaZ6gEEsg==
X-CSE-MsgGUID: 4t5MzRNBTSC7F1F6y3uA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31789983"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 May 2024 19:55:55 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2Mbw-000AKH-2Y;
	Thu, 02 May 2024 02:55:52 +0000
Date: Thu, 02 May 2024 10:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ddd9120983c3efbcaa3a4c7777da1440f8ce27d8
Message-ID: <202405021059.KfVgVpW3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ddd9120983c3efbcaa3a4c7777da1440f8ce27d8  rust: time: doc: Add missing C header links

elapsed time: 1719m

configs tested: 90
configs skipped: 4

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
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                   randconfig-001-20240502   gcc  
arm                        spear6xx_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240502   gcc  
i386         buildonly-randconfig-002-20240502   gcc  
i386         buildonly-randconfig-003-20240502   clang
i386         buildonly-randconfig-004-20240502   gcc  
i386         buildonly-randconfig-005-20240502   clang
i386         buildonly-randconfig-006-20240502   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240502   gcc  
i386                  randconfig-002-20240502   clang
i386                  randconfig-003-20240502   clang
i386                  randconfig-004-20240502   gcc  
i386                  randconfig-005-20240502   gcc  
i386                  randconfig-011-20240502   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
mips                       bmips_be_defconfig   gcc  
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
powerpc                     akebono_defconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   clang
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

