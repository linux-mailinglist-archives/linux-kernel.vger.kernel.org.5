Return-Path: <linux-kernel+bounces-139734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE58A06F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8928736F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B813BC05;
	Thu, 11 Apr 2024 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZyQBOzQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601B1E863
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808428; cv=none; b=jtC/+VT4rmVxfp6qnddL0FQQED+jEIsMpZNFx65xlGudTCm6w7pfOqdsjm9AjwmnMm2bNEefFxR8hOBSbXEtDAr/PoJx4TXFOWvkq2P6y7IAa/a3vaTJ5jLcKQDkWVGdp4+cEPrlzBSgQehcqP2tChMySBZCmC/B9s1HPrA9tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808428; c=relaxed/simple;
	bh=Lnjj6fL6i0e/W1J4P0NVTzwcDSf5vnNOaQg49kVg++I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q6iQcdkW0YslrfREC5TDn1/hVaSWHH42g6mj8nsF6J6oE3J1KgrAfShwMDpd0osTvAAjM7VA1XoQBBHtgmVrJ/t5jhHfPaUQZqt+tq6Wm6SJPLBdfMxF1aqcy9lzYfGst49kLqF8xpr/NN43Voj58AIlp7RvNE6BDOvYSQF/PUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZyQBOzQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712808426; x=1744344426;
  h=date:from:to:cc:subject:message-id;
  bh=Lnjj6fL6i0e/W1J4P0NVTzwcDSf5vnNOaQg49kVg++I=;
  b=aZyQBOzQx02JMVNXrZW1U48qmG1Ttjs801BPXBKcDEJ3ggwfeyxbB/ZX
   brvs5jatCKwtC9UfxF6ivwK7S1upy50GGXmwa14OqIJ6UhH73bv4bAXD1
   ct86sVrmzC40UB/ybSKUX97kXX3VzWRssJFd9+zJZzvoKZn6BmAx4Bti6
   8Zt3NTfMr2trnSaOr+8hFzjJhV5dHupW7gQQ4rtV7Y/OqGMJwSCx7lPvY
   HBhtYB2IcoqfuLWyq7klhH3KbMkxGFdC+3ix3jvm3pT/3Iwt2zea86vco
   Lp4SN7l/N4LypzNeVlUB+FgCxkicytqctpRo6jhRR/WlzVMuYfpLLiIBi
   g==;
X-CSE-ConnectionGUID: h2BEiA90TreHo/tTKN87nA==
X-CSE-MsgGUID: BzJXaHP9S+SAgo3XPBAsjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="12053414"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="12053414"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 21:07:06 -0700
X-CSE-ConnectionGUID: S5yZ/pr2QLimPhpi2vv5Dw==
X-CSE-MsgGUID: CkQSySDCTSWKTXkJ4V6G4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51739415"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Apr 2024 21:07:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruliI-0008CK-1p;
	Thu, 11 Apr 2024 04:07:02 +0000
Date: Thu, 11 Apr 2024 12:06:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.09b] BUILD SUCCESS
 1331453f446328079da60d23feaa618b6345cc4e
Message-ID: <202404111202.LZWKCAXT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.09b
branch HEAD: 1331453f446328079da60d23feaa618b6345cc4e  EXP cgroup/cpuset: Make cpuset hotplug processing synchronous

elapsed time: 1318m

configs tested: 178
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
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240411   gcc  
arc                   randconfig-002-20240411   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240411   gcc  
arm                   randconfig-002-20240411   gcc  
arm                   randconfig-003-20240411   clang
arm                   randconfig-004-20240411   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240411   clang
arm64                 randconfig-002-20240411   gcc  
arm64                 randconfig-003-20240411   gcc  
arm64                 randconfig-004-20240411   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240411   gcc  
csky                  randconfig-002-20240411   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240411   clang
hexagon               randconfig-002-20240411   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240410   gcc  
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-001-20240410   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240410   gcc  
i386                  randconfig-016-20240411   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240411   gcc  
loongarch             randconfig-002-20240411   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240411   gcc  
nios2                 randconfig-002-20240411   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240411   gcc  
parisc                randconfig-002-20240411   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240411   gcc  
powerpc               randconfig-002-20240411   clang
powerpc               randconfig-003-20240411   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240411   clang
powerpc64             randconfig-002-20240411   gcc  
powerpc64             randconfig-003-20240411   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240411   clang
riscv                 randconfig-002-20240411   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240411   clang
s390                  randconfig-002-20240411   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240411   gcc  
sh                    randconfig-002-20240411   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240411   gcc  
sparc64               randconfig-002-20240411   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240411   gcc  
um                    randconfig-002-20240411   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240411   clang
x86_64       buildonly-randconfig-003-20240411   clang
x86_64       buildonly-randconfig-005-20240411   clang
x86_64       buildonly-randconfig-006-20240411   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240411   clang
x86_64                randconfig-002-20240411   clang
x86_64                randconfig-004-20240411   clang
x86_64                randconfig-006-20240411   clang
x86_64                randconfig-011-20240411   clang
x86_64                randconfig-013-20240411   clang
x86_64                randconfig-071-20240411   clang
x86_64                randconfig-072-20240411   clang
x86_64                randconfig-073-20240411   clang
x86_64                randconfig-076-20240411   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240411   gcc  
xtensa                randconfig-002-20240411   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

