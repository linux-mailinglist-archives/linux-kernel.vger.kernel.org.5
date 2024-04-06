Return-Path: <linux-kernel+bounces-134099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8289AD9C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876D51C20B5D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929557892;
	Sat,  6 Apr 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EArHBFN3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBE1E86E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712444996; cv=none; b=VMyfH/TDhcHPbzy0SrdA0sqE67sK1Kpv4PB0EmM2mKS2lgfxzfMcm8lvvMcGQHqoG1Y9Y5xtWan2ykwDNXJosQdfjee4O9GzXnq7NTL13Uosk/syscWh4/uuvN/tBMZ6anWrgaLrVhG3+xMSUOdSXnL7PNqYKxWXyUgwjxKscqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712444996; c=relaxed/simple;
	bh=XH38bcf2ftRU7ftdpJzuT/0a5Z50XEhEvvsiqTOsF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fnboz4/ZcnDjhG3NzU6EMSRVFUABwRnjXv7qnY+lpsp/Dpcc6AMs1Eq8cuibSGPm1h43G2KKd9pY434hx9TeLeWY7Pd5tIa1HeH4yu2GGq3EtT8RwLHwgVP3WE1SrWpqUIxaZDDlHS4KX/KPdMFRHZcDmm3t3BOblXQbvYLeBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EArHBFN3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712444994; x=1743980994;
  h=date:from:to:cc:subject:message-id;
  bh=XH38bcf2ftRU7ftdpJzuT/0a5Z50XEhEvvsiqTOsF/Q=;
  b=EArHBFN3jogaCE8AqBlnDmsvpEeOqvdgmpTq8/sS2M88+UHIE6VIDTJJ
   XBBKgOT0wu9jiPnHcIlTOJAQVAtUYRhJxvsWPtMqV/0IWlrRs1yRBJkTo
   d8IM6lN4XoAWglZrXXk/5FKlby4xY+CCOTIv1EbZt9jF0Kh/4H1ZyaKI8
   OdIJKTyLZE7+a9ir086/B79DahYDsFbnAobsOOz0zCAELDkSZN08KLFEO
   Zwd5FGofLGzE9aHfO6BibayxQLkECkxYi67qQ7ws/j3xD7lWeLGPOxJeI
   2IxAm5mrrpeVxzJAY/sbt2aOJ1SRXdGI1X2W3VF81u+0a0Y2CTYthdHCS
   A==;
X-CSE-ConnectionGUID: WXYnasNXQJWQTPpcYkzYow==
X-CSE-MsgGUID: v33f9/kBS1ebEztTh7rI2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="8324018"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="8324018"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 16:09:53 -0700
X-CSE-ConnectionGUID: ks1GZ6XhSyGHxX9AWIevSQ==
X-CSE-MsgGUID: u6YTIvEJSuuZqbD++dltrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="20049446"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Apr 2024 16:09:53 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtFAT-0003w7-2s;
	Sat, 06 Apr 2024 23:09:49 +0000
Date: Sun, 07 Apr 2024 07:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 93cfa544cf9e4771def159002304a2e366cd97af
Message-ID: <202404070738.ytpsKaUc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 93cfa544cf9e4771def159002304a2e366cd97af  x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery

elapsed time: 722m

configs tested: 86
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm64                            allmodconfig   clang
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
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

