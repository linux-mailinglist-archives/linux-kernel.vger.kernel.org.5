Return-Path: <linux-kernel+bounces-137620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1C89E4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743161F22F85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE315887B;
	Tue,  9 Apr 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmLcX6Xl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DD2905
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695625; cv=none; b=Uevh7PtGtjtvNHTq2lFyb/5VTgW/4nCUuFsNKbTTgEdamAYCAUw5WSQUcDEwmSIN8jPT4OnWXqabUXcfPFmatwJFOAaoZ0Aznk/YWX+Wgo2NNHzKQepY8tlkb4lVfLrwgBz/kENGAT0QVHFwcpRrHtKdqowRc+cGMvbP67VczdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695625; c=relaxed/simple;
	bh=QtUyiLmeuh4WXIA7zBsu7RgbNBKYIPJFxnhtfnlAPkM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EM1OgBi34Ip1WvDwfaIYzXbyiXjboT9F+PvWs8E1tw+HBBzemiHRLx2F84ha/yahX5XieS63to6v0OEpkuYXPTFiMU9eYkWccE737iE3AWtnC8JNzrYxgkoQilfNpCAf8RXYC55SXXG35VovDU+bfnCCwtgA+MNKTiOc/usKrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmLcX6Xl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712695623; x=1744231623;
  h=date:from:to:cc:subject:message-id;
  bh=QtUyiLmeuh4WXIA7zBsu7RgbNBKYIPJFxnhtfnlAPkM=;
  b=FmLcX6XlN63RDKOjfYL/zZ5cb2ljLxYQ4fa0kubl2X7oT7SY0IJa1ZqO
   Ye+GntmRTGSCVEpTGfUK8QE+Nrsm7G16DNS0IqHVSuFulKOAud2/7AMC4
   gKyFT34jwC6Z0YW5pwqy4r1+yvscd5W4+2LuMPi3b+hoZOwwEkGf8TMt5
   rQcE5IrgUt2IVqIUHO1CXx8VTErQGcf6biZeKZ0UNemgFWNDEAp/usO3B
   NzQqK6QvkKj3m7GuFovPOIKaXm98GpMcAI7Qv59YXzC+PHyuDvr3lPmII
   yKF24XR+7um/zuss+7bkyzRxYIHqx/Y7kUao28eKFsyv7O0Ts/pkEipR/
   A==;
X-CSE-ConnectionGUID: BRlUC+f9QoO7LeyUPtbdnQ==
X-CSE-MsgGUID: KTTtbdMORySBmj3ufKoCJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19460298"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19460298"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 13:47:03 -0700
X-CSE-ConnectionGUID: 7Wp7JKfJTQudxtxBOxjC+Q==
X-CSE-MsgGUID: YlgOmALPT3ijSkQaZqBGYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20779600"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Apr 2024 13:47:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruIMt-0006Uw-36;
	Tue, 09 Apr 2024 20:46:59 +0000
Date: Wed, 10 Apr 2024 04:46:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 b767fe5de0b4a5057b070d8cdefdcf6740733d6e
Message-ID: <202404100430.uwNs1rAa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: b767fe5de0b4a5057b070d8cdefdcf6740733d6e  x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S

elapsed time: 722m

configs tested: 53
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arm                        keystone_defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-006-20240410   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240410   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-016-20240410   gcc  
loongarch                        alldefconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                          rm200_defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                             allnoconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

