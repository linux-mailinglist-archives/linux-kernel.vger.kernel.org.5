Return-Path: <linux-kernel+bounces-154438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8848ADC14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B880C1C21623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4218659;
	Tue, 23 Apr 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjMg3Dpq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7917BDC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841556; cv=none; b=pklimNmn59jTzJwcVsflBSj08GvHKYVQh2b6hg3JzmqnSCajACSGRSzEJO578MZHYQu+0TFN0ZMXK+1mG8nbSfoLKHHP5f4p3Sqm+bRL15tDl51mdYiTZKydjU10Nk4LgYG0y1m/zHn1c2XUkIiHJtiVWMwuAy3mrt9uOVC2Pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841556; c=relaxed/simple;
	bh=ISXjIO1jcoCqkizp4S09RVgBXJog2nX8WRapuUGPLkU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=giQZD0+lfC7rkmWRFTXQdNrNLputdoNIWiKX+HU0VUxzPO8Yo+qxZov0iCjh3rcf0QO1ZpT7xMeuVv+NBT718T/wtSFInNPiJuhO4mZUj1cf5NVm8yzJNgQ3V65L1vzuvn2Lv5vvfUpPNUGvpaIKGIcfjaN7D+WW0GFIKH9XjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjMg3Dpq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713841554; x=1745377554;
  h=date:from:to:cc:subject:message-id;
  bh=ISXjIO1jcoCqkizp4S09RVgBXJog2nX8WRapuUGPLkU=;
  b=TjMg3DpqK9ydafM+guUVEHA5sJWDfZOHx5rJhEVieaUj8MpBgK/Qeleq
   eC/DNJCxya+Hg8AEL0dRChOxmQx4NaXVz1DhJUAdKsS39vxGGkBVBB0IW
   EAdbjL4jcqU0ARI353RA0iLchg7Yq3TJlps+YYgErrNnZRHEvKAW6tdeq
   eGQWdrGRkS4kywFAiMyap/fJye9atzEr+ktI8wVK+v+JIRX8ddRHxP99O
   wxTaEgvCG1qsSqhXZ6GqU83cHgnNu4hJepUpbxYYFIdGz+kvzkXt4Rnm6
   3/F17wsAJ72f4MNkdE48XrWy5V4Z7tnqyzjYHaH+ixRHT6UtTDC3XuezC
   g==;
X-CSE-ConnectionGUID: rT1J4tbnQZCEGCQk8G8cWA==
X-CSE-MsgGUID: Nvkm2vYGQdKDt71tS2zeJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13195171"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13195171"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:05:54 -0700
X-CSE-ConnectionGUID: ajT86rCeSbWCtehA0eJypA==
X-CSE-MsgGUID: 6sj8P3oGQBGOhnf/AnN4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29032451"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2024 20:05:53 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz6Te-0000RE-27;
	Tue, 23 Apr 2024 03:05:50 +0000
Date: Tue, 23 Apr 2024 11:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 b7c8e1f8a7b4352c1d0b4310686385e3cf6c104a
Message-ID: <202404231138.pCbvJsFS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: b7c8e1f8a7b4352c1d0b4310686385e3cf6c104a  hrtimer: Rename __hrtimer_hres_active() to hrtimer_hres_active()

elapsed time: 761m

configs tested: 135
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240422   clang
i386         buildonly-randconfig-002-20240422   gcc  
i386         buildonly-randconfig-003-20240422   clang
i386         buildonly-randconfig-004-20240422   gcc  
i386         buildonly-randconfig-005-20240422   gcc  
i386         buildonly-randconfig-006-20240422   clang
i386                                defconfig   clang
i386                  randconfig-001-20240422   clang
i386                  randconfig-002-20240422   clang
i386                  randconfig-003-20240422   gcc  
i386                  randconfig-004-20240422   clang
i386                  randconfig-005-20240422   gcc  
i386                  randconfig-006-20240422   gcc  
i386                  randconfig-011-20240422   clang
i386                  randconfig-012-20240422   clang
i386                  randconfig-013-20240422   clang
i386                  randconfig-014-20240422   clang
i386                  randconfig-015-20240422   clang
i386                  randconfig-016-20240422   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
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
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
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
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240423   clang
x86_64       buildonly-randconfig-002-20240423   clang
x86_64       buildonly-randconfig-003-20240423   gcc  
x86_64       buildonly-randconfig-004-20240423   gcc  
x86_64       buildonly-randconfig-005-20240423   clang
x86_64       buildonly-randconfig-006-20240423   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240423   clang
x86_64                randconfig-002-20240423   gcc  
x86_64                randconfig-003-20240423   gcc  
x86_64                randconfig-004-20240423   gcc  
x86_64                randconfig-005-20240423   gcc  
x86_64                randconfig-006-20240423   gcc  
x86_64                randconfig-011-20240423   gcc  
x86_64                randconfig-012-20240423   gcc  
x86_64                randconfig-013-20240423   clang
x86_64                randconfig-014-20240423   clang
x86_64                randconfig-015-20240423   clang
x86_64                randconfig-016-20240423   gcc  
x86_64                randconfig-071-20240423   clang
x86_64                randconfig-072-20240423   clang
x86_64                randconfig-073-20240423   clang
x86_64                randconfig-074-20240423   gcc  
x86_64                randconfig-075-20240423   gcc  
x86_64                randconfig-076-20240423   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

