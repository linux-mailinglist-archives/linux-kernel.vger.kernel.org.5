Return-Path: <linux-kernel+bounces-149352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDA8A8FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626D4283265
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B3611B;
	Thu, 18 Apr 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2CS/s/W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6C17D2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399835; cv=none; b=REyD/awea9bM5l9FYpWpFleS/Ng6AvLalgXYoQ3azgFSH7WHVSmOz2TuJdP/YzLzzbZfd/GOGm1RjD2tr4XEISyt69G8uA7RbSNqz36Aie+DoglLMccBokRd+B/A4aUxwinXFeeWfqjXIbm9KHlgvSonnxjOIEVtKZQ8lPXUsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399835; c=relaxed/simple;
	bh=1uZFGkCAsXT1fNbSRjWRTzbetWz+Enn+pAR5DkEYul4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a8cIXPD4PDMSiULqIrRbZZRQQxu/YgJF5bU6Tax842wuPl3N0J70eVr2y+jGqaKB94mrC5Ig09d1LisT0+2XxYh9nD2SkQ+SSDcCXpzY4X/CF1lI+7vl4TEgdLgsjcj6jhSflU9DJpksKJA0qjojMCoT++EKHsS4OeyRxGPtcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2CS/s/W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713399834; x=1744935834;
  h=date:from:to:cc:subject:message-id;
  bh=1uZFGkCAsXT1fNbSRjWRTzbetWz+Enn+pAR5DkEYul4=;
  b=e2CS/s/W0HEUfsP+2nlE3HIGrtLg1mNUSoVJRroX/cTwMp5zve4mf7Yp
   imVVJkg/ruzGv6GeOfwoQBGVWTHgEgBXZHXs7zdnpZskkOn/N1t/F/S+4
   P6o/L9JxtiJXQUcQTUt5dX+gFm76JSWGywVxmnHVIQ24Hm7Npm0NMg5FM
   O26L1rzUTuFu5Q9kX8YJ5pX6ArRC7bgXBx5wEPkpt+yGdn60fIoWHK2vi
   xrS7E4r2Gyc4Lzn1WNdvMFEIKdl15nqeUAQq0h8C3tG055vSE53O+wOgd
   UhcdoBdBnCc9TZ8ZtZYdsHlbPtETYHTCWNxbrxPUNDKwe7wYxuou2RqKO
   A==;
X-CSE-ConnectionGUID: z9fGDeihRbGNtfJFR+N5Xw==
X-CSE-MsgGUID: acqqMD5qQeGHel5fTT02bA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26380715"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="26380715"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 17:23:53 -0700
X-CSE-ConnectionGUID: /F3S/7eNSkeR+Xi0h2Y5Cw==
X-CSE-MsgGUID: UUV/NWNCSM+NOGTXLUJwjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="54002558"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Apr 2024 17:23:51 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxFZ7-00077J-0c;
	Thu, 18 Apr 2024 00:23:49 +0000
Date: Thu, 18 Apr 2024 08:22:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 08a36a48544d73bf153960245aec6c5fa23960de
Message-ID: <202404180856.eSCDCs24-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 08a36a48544d73bf153960245aec6c5fa23960de  sched/vtime: Do not include <asm/vtime.h> header

elapsed time: 731m

configs tested: 128
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
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
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
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240417   clang
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240417   clang
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240417   clang
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
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
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            alldefconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

