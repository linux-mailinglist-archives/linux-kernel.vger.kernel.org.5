Return-Path: <linux-kernel+bounces-133197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929B89A03D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028721F22868
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BFC16F29F;
	Fri,  5 Apr 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv+3p/wv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945716DEAB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328773; cv=none; b=GiVKzE025Z9C45guYJ3J97IuLIO/pIbiH9OQHKg5b0joRtPLeISB0n8+zfzUJlg2IOzh+MW8Z4Hdywvbs/27HqCSwSDKtMlBHdCQplNPMui/Pp4Y8GasGMimR4e6OCa6/eCB6gHRlL3GeCDrt8HbOq0ejFMgwNH0jAv5Qn+R1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328773; c=relaxed/simple;
	bh=9fXD74EoOk0Qq6pCxBrdU2yUnMV1sDo8MVE0kEQOWN0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LIaWQC0TESV/dksrmy4vI7TP3iv5VBlVbtkig25+PVoOkhN87QXUTSneBPfTVkKi1m29xzNeubVaYeH5//honVbjnQYNpM0tm+aI1l/RZj0pwaYYcEBG9zcjrnYomtdvGobV3yf2HXi8hqkF3+rTWvGydMJb1K1B3qKnNIEr+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv+3p/wv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328771; x=1743864771;
  h=date:from:to:cc:subject:message-id;
  bh=9fXD74EoOk0Qq6pCxBrdU2yUnMV1sDo8MVE0kEQOWN0=;
  b=Xv+3p/wveENcVopMbOj4NOtPFz4bKbqRMo6m+OGQzRJ0KcTsi0GOxIWP
   lYEQz0usbAyOZB3kDYv+kJCownKUPHCWlhTss55L3gTjZjtvOiz7E3V+H
   NBlSSpS6E69qOLNKf9fnT3lFQTZnoqbxpJ/grw58F5wkjCqEAoZp10sr0
   edGh31QPNqJ1ltA4+B882oTo5nr1vxY2+Gk9ASHuUv4SbENhXJ1ocdW/y
   k8S53AvBILkruKgKOjzVb7uNvjiLpnLTCT2U2cgQi2bqCtZ0+xpSxoQie
   DOhmk2+FwkQQkSEHNs2UaZ/uQa3BTW8xkjBRShW14Jz26yEbcOheZvuHa
   g==;
X-CSE-ConnectionGUID: uvFM6kJvSq2WUtdw3tn1mg==
X-CSE-MsgGUID: N8qnQZ0jQFyHMDJVJXLsWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25168595"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="25168595"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:52:51 -0700
X-CSE-ConnectionGUID: eXWGiqEWTuC2BKdv3Rukrw==
X-CSE-MsgGUID: RqAwg883Qh6WItxeo/jpKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19103787"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Apr 2024 07:52:49 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rskvv-0002Nl-1Z;
	Fri, 05 Apr 2024 14:52:47 +0000
Date: Fri, 05 Apr 2024 22:52:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.03b] BUILD REGRESSION
 f6416a4a0ebe5a37b471f04b20992be201563e81
Message-ID: <202404052259.aGa1vezk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.03b
branch HEAD: f6416a4a0ebe5a37b471f04b20992be201563e81  rcu: Reduce synchronize_rcu() delays when all wait heads are in use

Error/Warning: (recently discovered and may have been fixed)

kernel/locking/qspinlock_paravirt.h:333:(.text+0x3afeb9): undefined reference to `cmpxchg_emu_u8'
kernel/locking/qspinlock_paravirt.h:91:(.spinlock.text+0xcc1): undefined reference to `cmpxchg_emu_u8'
kernel/rcu/tasks.h:1482:(.text+0x3f6f): undefined reference to `cmpxchg_emu_u8'
ld.lld: error: undefined symbol: cmpxchg_emu_u8
ld: kernel/rcu/tasks.h:1482:(.text+0x3fa1): undefined reference to `cmpxchg_emu_u8'
ld: update.c:(.text+0x578): undefined reference to `cmpxchg_emu_u8'

Unverified Error/Warning (likely false positive, please contact us if interested):

ERROR: modpost: "cmpxchg_emu_u16" [drivers/platform/surface/aggregator/surface_aggregator.ko] undefined!
ERROR: modpost: "cmpxchg_emu_u8" [drivers/platform/surface/aggregator/surface_aggregator.ko] undefined!
controller.c:(.text+0xae5): undefined reference to `cmpxchg_emu_u16'
ld: qspinlock.c:(.spinlock.text+0x41f): undefined reference to `cmpxchg_emu_u16'
ld: qspinlock.c:(.spinlock.text+0x45a): undefined reference to `cmpxchg_emu_u8'
qspinlock.c:(.spinlock.text+0x393): undefined reference to `cmpxchg_emu_u8'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   |-- ERROR:cmpxchg_emu_u16-drivers-platform-surface-aggregator-surface_aggregator.ko-undefined
|   `-- ERROR:cmpxchg_emu_u8-drivers-platform-surface-aggregator-surface_aggregator.ko-undefined
|-- i386-allyesconfig
|   |-- controller.c:(.text):undefined-reference-to-cmpxchg_emu_u16
|   |-- ld:qspinlock.c:(.spinlock.text):undefined-reference-to-cmpxchg_emu_u16
|   |-- ld:qspinlock.c:(.spinlock.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- qspinlock.c:(.spinlock.text):undefined-reference-to-cmpxchg_emu_u8
|-- i386-buildonly-randconfig-004-20240405
|   `-- ld:update.c:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- i386-randconfig-002-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- i386-randconfig-061-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-buildonly-randconfig-004-20240405
|   `-- ld:update.c:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-012-20240405
|   `-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-013-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-015-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-071-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-072-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-074-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-075-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|-- x86_64-randconfig-076-20240405
|   |-- kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
|   `-- ld:kernel-rcu-tasks.h:(.text):undefined-reference-to-cmpxchg_emu_u8
`-- x86_64-randconfig-161-20240405
    |-- kernel-locking-qspinlock_paravirt.h:(.spinlock.text):undefined-reference-to-cmpxchg_emu_u8
    `-- kernel-locking-qspinlock_paravirt.h:(.text):undefined-reference-to-cmpxchg_emu_u8
clang_recent_errors
|-- i386-buildonly-randconfig-003-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- i386-randconfig-062-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- i386-randconfig-063-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-buildonly-randconfig-005-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-buildonly-randconfig-006-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-randconfig-001-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-randconfig-002-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-randconfig-003-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-randconfig-005-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
|-- x86_64-randconfig-011-20240405
|   `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8
`-- x86_64-randconfig-014-20240405
    `-- ld.lld:error:undefined-symbol:cmpxchg_emu_u8

elapsed time: 1124m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-002-20240405   clang
arm                   randconfig-003-20240405   gcc  
arm                   randconfig-004-20240405   clang
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240405   clang
hexagon               randconfig-002-20240405   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240405   gcc  
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
mips                      bmips_stb_defconfig   clang
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240405   clang
powerpc               randconfig-002-20240405   clang
powerpc               randconfig-003-20240405   clang
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240405   gcc  
powerpc64             randconfig-003-20240405   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240405   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240405   clang
s390                  randconfig-002-20240405   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240405   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240405   gcc  
um                    randconfig-002-20240405   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240405   clang
x86_64       buildonly-randconfig-002-20240405   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240405   clang
x86_64       buildonly-randconfig-006-20240405   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240405   clang
x86_64                randconfig-002-20240405   clang
x86_64                randconfig-003-20240405   clang
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240405   clang
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240405   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240405   clang
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240405   gcc  
xtensa                randconfig-002-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

