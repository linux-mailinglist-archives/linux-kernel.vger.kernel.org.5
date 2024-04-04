Return-Path: <linux-kernel+bounces-130860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CEE897E18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8118A1F24691
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB920B3E;
	Thu,  4 Apr 2024 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guoIa72d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B891CD32
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203109; cv=none; b=Q38jrGoWZGO2GUlkMAmxgMoq1LRfLprSbfQUnShcndEawtab3/zptJkLZyFjxDsDl1OZ44Q3ix+2C3RhZ5hz/XfA0kQ2VKOr1MNXNf9zz3gjcNuMRGySvjP7Gb8L+sUQrAZi6uH6nnNX24ZPNglzaIqf4A4LxdiC7B/m+Pqf1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203109; c=relaxed/simple;
	bh=CzdtxyX8zkizdQ9QTCyDQv7IdVgSsLd/lNjlK7nHrLo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S1wnkERbvvXXQAwaX3d/ys9Tb8Ow+vQ4HRZg+zH2klqdB8+VFi0qVLf3QsOvpnMSHdH1d+lalv4eBYCWqpEAcksTnBfdHnhyOJhTBdzqaj2AKkyYF3rNZnIjIBxh0447Vk7S1b2p8dlCIYdOYLVHMp5v9Q+0yuH4dP+nEF3aP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guoIa72d; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712203108; x=1743739108;
  h=date:from:to:cc:subject:message-id;
  bh=CzdtxyX8zkizdQ9QTCyDQv7IdVgSsLd/lNjlK7nHrLo=;
  b=guoIa72dUPWtG82L3h9ayXr9yqgqEF8Rcv859MTDAEmAr8O9iztYLCuY
   xNtQjpXe6CUZW+qKYhR1dv9ewfu6TuHvF0PjeSr23X20tWeHiNvq/Kvt1
   l4FNJZqNxCeEDvjXTtusj/aiQk10F/4E0XnCUxfy82AmvulORacmaw3Q4
   8QSPGio1d4wpKChDtZi+ESefsgUTeZanBGjGfxNd1/TvC7KduqV2pS5u9
   zCoiiNX8nVznNymZrsYCY9ZBhr96Z6FE0HQQI4wr18M5v7E8g3/QSa5OK
   hnHNWWDAFlBf3tDX9nZ4Q/8w0ijDS1VX3I8PeFraxMPlGGvZyhJbvWM0G
   w==;
X-CSE-ConnectionGUID: 510lJjFITrymfudXKrdQ9A==
X-CSE-MsgGUID: N6rsoSEpQhGUQtJ+e2YpwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11297071"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11297071"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 20:58:28 -0700
X-CSE-ConnectionGUID: 1u7AvG+tRWS0LDMXVWbyTg==
X-CSE-MsgGUID: yxa0Bow+TpyJaR4bfn/iVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23406518"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Apr 2024 20:58:26 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsEF5-0000Zw-3D;
	Thu, 04 Apr 2024 03:58:24 +0000
Date: Thu, 04 Apr 2024 11:58:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 0049f04c7dfe977a0f8f6935071db3416e641837
Message-ID: <202404041109.vXaSrTn4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 0049f04c7dfe977a0f8f6935071db3416e641837  x86/apic: Improve data types to fix Coccinelle warnings

elapsed time: 732m

configs tested: 94
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-005-20240404   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-075-20240404   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

