Return-Path: <linux-kernel+bounces-134100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3A89AD9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF021C20D4E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664B58AB6;
	Sat,  6 Apr 2024 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIaZSpd2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0915787B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712444998; cv=none; b=ce2NQwfe3kjaiIpE908RVxgFz5cGA8vKr3SG3nsMnTp+jRZtWfY8TnF9JVp7Wo6U/jZv/w8HWpz6eHaeb2F3L/xk+EeSVXvcvOKnOYuMPpRLNZqpwsz1266w3mNgF0VB04SUfwhKk5vVsBWDX4t8oMbchNoJ/B0SH0gyUGFAbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712444998; c=relaxed/simple;
	bh=6A+Q/vwtoF2bfw0WvpXDjtXkhdoMRUXZ/d1yuMElQbw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cJsXO4H4vDSQ4CMz5iTRuOJPYaIiybFjsawB0gqWptbi0Xdr41n5wmrqiLS9dkeh9j3kZL+Lzg4st0k3jALbogXpf73IUHDf2zIp2qSwuXTYP6uVVOytY3XlGd+BuFnlgFIKZoFmQTFmG0pDVUhgTt7F5fOscRFOoJ8vJcHEZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIaZSpd2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712444996; x=1743980996;
  h=date:from:to:cc:subject:message-id;
  bh=6A+Q/vwtoF2bfw0WvpXDjtXkhdoMRUXZ/d1yuMElQbw=;
  b=hIaZSpd2aP6ypm3Pc+2uyn+OwvDz2Ip+4mXwTUfy3Fqj4BBV2yqmO0Gq
   ocoeBWJXNUw7Fu5SStjP7zqy82ZkX4eY8NpCDEISIpgHc2bAlkPVNkXxE
   BXWvZthrHj/Ak+T5uUe3Plj6b8nMN1hWLA85O+JQErAKmsSIEpsGKFCfW
   CJ24USm5X37zbr03pvtmk2eTly34uLnupIxO4NWxO7Msw2u3Iy4pAEick
   6Jjpu3LMlIOKINslxYSF8KnyHroIfxc1E72BeckxqA1NUPhBosJVZUave
   L3JAO8WTJmWXUXyPBEPGdXO55KZ9zDM30BvsDi19s14h0f/0nS0VUUwsA
   g==;
X-CSE-ConnectionGUID: ptjo9k+YSmqQZOjjb0hjlQ==
X-CSE-MsgGUID: iIl8d6xXT9+HEjmAhpC5Mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="8324021"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="8324021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 16:09:53 -0700
X-CSE-ConnectionGUID: o/rGaMxUTZKzabk1S46eoQ==
X-CSE-MsgGUID: FPWbiUePRM+pAtKlfkgcKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="20049445"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Apr 2024 16:09:53 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtFAT-0003vs-2V;
	Sat, 06 Apr 2024 23:09:49 +0000
Date: Sun, 07 Apr 2024 07:09:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b377c66ae3509ccea596512d6afb4777711c4870
Message-ID: <202404070724.TXf0dSpA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b377c66ae3509ccea596512d6afb4777711c4870  x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

elapsed time: 721m

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
arc                   randconfig-001-20240407   gcc  
arc                   randconfig-002-20240407   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240407   gcc  
arm                   randconfig-002-20240407   clang
arm                   randconfig-003-20240407   gcc  
arm                   randconfig-004-20240407   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240407   gcc  
arm64                 randconfig-002-20240407   clang
arm64                 randconfig-003-20240407   gcc  
arm64                 randconfig-004-20240407   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240407   gcc  
csky                  randconfig-002-20240407   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240407   clang
hexagon               randconfig-002-20240407   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240406   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240406   gcc  
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240406   gcc  
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240406   gcc  
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240406   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240407   gcc  
loongarch             randconfig-002-20240407   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                     loongson2k_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240407   gcc  
nios2                 randconfig-002-20240407   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240407   gcc  
parisc                randconfig-002-20240407   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                 canyonlands_defconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   clang
powerpc               randconfig-001-20240407   clang
powerpc               randconfig-002-20240407   clang
powerpc               randconfig-003-20240407   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240407   clang
powerpc64             randconfig-002-20240407   clang
powerpc64             randconfig-003-20240407   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240407   clang
riscv                 randconfig-002-20240407   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240407   gcc  
s390                  randconfig-002-20240407   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240407   gcc  
sh                    randconfig-002-20240407   gcc  
sh                          rsk7203_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240407   gcc  
sparc64               randconfig-002-20240407   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240407   gcc  
um                    randconfig-002-20240407   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240406   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-003-20240406   clang
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64       buildonly-randconfig-006-20240406   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-002-20240406   clang
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-004-20240406   clang
x86_64                randconfig-005-20240406   clang
x86_64                randconfig-006-20240406   clang
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-012-20240406   clang
x86_64                randconfig-013-20240406   clang
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-016-20240406   clang
x86_64                randconfig-071-20240406   clang
x86_64                randconfig-072-20240406   clang
x86_64                randconfig-073-20240406   clang
x86_64                randconfig-074-20240406   clang
x86_64                randconfig-075-20240406   clang
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240407   gcc  
xtensa                randconfig-002-20240407   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

