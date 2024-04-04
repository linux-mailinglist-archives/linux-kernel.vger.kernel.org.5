Return-Path: <linux-kernel+bounces-130862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64CE897E20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A6C1C21739
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBC210E7;
	Thu,  4 Apr 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRsOdD54"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4A20B28
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203230; cv=none; b=OQt5fz2JeDTTduKsaQbiaczo9OHroCh7mAI5MmNUK8HfDiDroZ7bxxZfWVs/ahSTC9v42lzi99fyg7K8cTGaEz2CWL6ETZdsudLQ05/Um6Q34pVtRsRB3tumLiUP13gcFdBDm6mZ4kMZx2rB+MBkmZBqfWEP51zEuxcBYq5Y41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203230; c=relaxed/simple;
	bh=8TYQMdSGK2BeLqywSGnN6J5z0SLZ/Znu6kREZiLNjw8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FveGGRGszJGTOXET10wb87xyTAkQbdchp3qZeCK6ruQgU2Xth3FMQuYbzUqoV6A/Kvno5Bx4lhVqyd3Jtq2ctV+ws5GGK6ilLP/7KUcqSmgNonDZaUh87AMutsQCMQY78Ca2T4GHZJ3zh8oV98EP7r5wIfIfkdLO5N97fBz+nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRsOdD54; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712203228; x=1743739228;
  h=date:from:to:cc:subject:message-id;
  bh=8TYQMdSGK2BeLqywSGnN6J5z0SLZ/Znu6kREZiLNjw8=;
  b=gRsOdD54vzQ03lZYudchI93z2F+f9TpuXrLfhUgop0iM8ptsWC9xb55g
   pO7kCd1emUdrvEs8pKUL0qTwCB2cf8FKr9rC+TvjzBUGsHwVDmmx7eXfq
   9V4jge9HngJ0IC9wnNFSk+Q0yyhqZ8nmnskaUNXv7+Jqb5FdA489rtMIY
   ExbQ/ebTsIyzSKFiPm2ky7RQPeNRtnz/6gtKN5pAyMTpcaScZYJ83ExOB
   T3Guwu4+joQ0uC44u5xfhZ7Dj252NjJe5SrljUCoh3zje/EfzEw7bzljD
   Dt5Gmd8LiWKKBRvgA+5Aeq63sRGHa0jZmsoQ8jyWMMHFOVoKFf1fGM0+X
   g==;
X-CSE-ConnectionGUID: P0MPF9MDQEeTWbT9lExO/A==
X-CSE-MsgGUID: gWeyB09zSf6bN/kUW+PcFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10434681"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="10434681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 21:00:28 -0700
X-CSE-ConnectionGUID: jfuNKyClQj+W7Rq5Mhpipw==
X-CSE-MsgGUID: Jz2QfzIpSJGLAHdCcVU9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19082108"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Apr 2024 21:00:27 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsEH2-0000aV-1W;
	Thu, 04 Apr 2024 04:00:24 +0000
Date: Thu, 04 Apr 2024 11:59:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 62fbc013c185896080bc5c7f6dfb26f0746eb217
Message-ID: <202404041142.9YpC3Qpd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 62fbc013c185896080bc5c7f6dfb26f0746eb217  x86/rtc: Remove unused intel-mid.h

elapsed time: 733m

configs tested: 64
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
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
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

