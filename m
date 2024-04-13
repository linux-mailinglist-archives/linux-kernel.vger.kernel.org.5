Return-Path: <linux-kernel+bounces-143624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1AA8A3B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F707B21A96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9E8C15;
	Sat, 13 Apr 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="it0HzjsI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E171D545
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712995393; cv=none; b=TVSYaXkCldZNiDrImLzmGKk8a9m72WAEGcPxsiGWGR0OwkSj24rCJHL5GVdVabTvK9Gb1WkV2koJJ82psUZRgiY7UZprTqQe6SVBd1Sg4W/3DVG1HL0mBXjH14q9LExFUwqJIUpENMc4IxSoy24NScd1Mlbsz+PrgwoXDD/lMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712995393; c=relaxed/simple;
	bh=BZzuA1IAYbmjQHu2QiVbkmN1yObj7axezpWEaikI0rM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cOFDENbAfMPAONv6ub4mOjw0+wBPYldtqLj36wOL76QplvI/keB3twJdE/HGYHUI1J53xT1UnmNTgl6zEjfvsIDBTPozzGHkyxNEFXpaobhBA4X+JQn2fVY6GgUuo6UB/jm3aE/VoCtWCJK3T0DOFMijdg9XUjL+FrnAIF1cL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=it0HzjsI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712995391; x=1744531391;
  h=date:from:to:cc:subject:message-id;
  bh=BZzuA1IAYbmjQHu2QiVbkmN1yObj7axezpWEaikI0rM=;
  b=it0HzjsIS5Rh0yqhEBdWJJ7j1+uCq4pVTxr+QX0OoCHmxHRB5YTMu922
   cLA0jA0TmeRbscLaTAAPQRun3RrQLMxHh3Gmt2ev1whgQ7jcgIao5udpu
   Br7FMf8b1e/3doxhQzr4tbYq1jdlbOlSX4iFeHTdEV4QGx566jN1Deuub
   as4g9ARCQICLPm9vzN/xAAmIJqgPQ6v8Mk+d1ZfGWAxq31vsB7tVfsmda
   rsJHcos36/z1tfamAfloZSfDA7T28hps8aiKXkawnjBKH1D2cuJvDMMz5
   V6CDsbRdsjup20sLRz1cr03iPVy3NzrQseSJLtpdu03Tzk7//72Oedve+
   A==;
X-CSE-ConnectionGUID: j/Fxu9g0TFOO0z2/kRgMXg==
X-CSE-MsgGUID: hdvGO1a/TPOPhaG+ZQ8/tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19846020"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="19846020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 01:03:10 -0700
X-CSE-ConnectionGUID: qnbENAa9RUCr8LT0qKeyuQ==
X-CSE-MsgGUID: s2r58Qh5RBWWacK8Emd77w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="21424941"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Apr 2024 01:03:09 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvYLr-000257-1O;
	Sat, 13 Apr 2024 08:03:07 +0000
Date: Sat, 13 Apr 2024 16:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 86d1b22a75cffa50160e4621da00311e6f6f48de
Message-ID: <202404131648.oPjeZVY8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 86d1b22a75cffa50160e4621da00311e6f6f48de  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1295m

configs tested: 83
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
i386                                defconfig   clang
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
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
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
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

