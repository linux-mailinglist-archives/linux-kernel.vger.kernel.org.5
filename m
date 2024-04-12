Return-Path: <linux-kernel+bounces-142528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94D8A2CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310521F2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43242075;
	Fri, 12 Apr 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iP6PeJiy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B93CF79
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918865; cv=none; b=kac0PJJ4A2NzMat84zBGrLJJPPgmpjqdvH7MK+gxJXVf+SmXSfLdkZ3RI24jJOPrp1sgHCIVe+QdAEZOWT65mII9Fp7nhhBqe8BigpzQI+nkrKmTfTpZF9bjo4xPmL4SDHpY3KTZtZHFe46sxBdnFcFu/9t4n9tKKsBW4tre9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918865; c=relaxed/simple;
	bh=IseyYROrNtC5yCOh5GhyQmI6vCSbBmMCgIyPc8W0XFE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MYYPXSBFp68LevjFvSKhfPpG1Ps6q1ennKi+8Ub4PbqJrPYwY5mg8PFvn6beE4QXmY18IacodbPyG+kGnFSqYMdo48xWksRt5BBQt5tu0u+Ovra4P6jMloXTETZLgrf0TaC7tPoZN/TFB3RcH+HGEz7eOasGt38xqNNoRo9LYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iP6PeJiy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712918864; x=1744454864;
  h=date:from:to:cc:subject:message-id;
  bh=IseyYROrNtC5yCOh5GhyQmI6vCSbBmMCgIyPc8W0XFE=;
  b=iP6PeJiymqkVv6UyIiFPPG8HgY7V+KikblXNgaXTIarqHlxqybRFfMFO
   OO9aDD6T5QNdCe3JcH7dqz4QPnj4srA0vtuXF+lfmijvxhRsWGHdAmWCa
   MYbRgw1nik9KTfYRtj0InI5ChGF3+MA9xS+bq/Uhp5oR2Bd+LXII0RRqJ
   0tNHn0zvkJCzYwpl+R9ShjEondmpsosx9pzYPiMTvMryPNWKjWqywbqGW
   6yxgtxAYFY9n4jrCZtlcZ+NxyEMaUegM5tF5k9V5LcTNGvRl7VrcVwShU
   meT3BKf+8mkut360xDlXRfXyajfmC5vky22b7LzHaf6VodUXNMxbA5obR
   Q==;
X-CSE-ConnectionGUID: tssKzs6sT4ylHyHuFzq62Q==
X-CSE-MsgGUID: rZI3MtZdQ2mBQI+hF+JMBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8286897"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8286897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:47:43 -0700
X-CSE-ConnectionGUID: 06Hhb/+rT/62ZIe2aq1/kA==
X-CSE-MsgGUID: OdAtUEq7TqaIABTr/+dmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21254695"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Apr 2024 03:47:42 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvERX-0009gf-28;
	Fri, 12 Apr 2024 10:47:39 +0000
Date: Fri, 12 Apr 2024 18:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240408-CbC] BUILD SUCCESS
 84c645c6335a57d94c1414c704e2fdb38d0ae5c8
Message-ID: <202404121858.e5LP1BS4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240408-CbC
branch HEAD: 84c645c6335a57d94c1414c704e2fdb38d0ae5c8  smb: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1131m

configs tested: 162
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
arc                   randconfig-001-20240412   gcc  
arc                   randconfig-002-20240412   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240412   gcc  
arm                   randconfig-002-20240412   clang
arm                   randconfig-003-20240412   clang
arm                   randconfig-004-20240412   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240412   gcc  
arm64                 randconfig-002-20240412   gcc  
arm64                 randconfig-003-20240412   clang
arm64                 randconfig-004-20240412   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240412   gcc  
csky                  randconfig-002-20240412   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240412   clang
hexagon               randconfig-002-20240412   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240412   gcc  
i386         buildonly-randconfig-002-20240412   clang
i386         buildonly-randconfig-003-20240412   gcc  
i386         buildonly-randconfig-004-20240412   gcc  
i386         buildonly-randconfig-005-20240412   gcc  
i386         buildonly-randconfig-006-20240412   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240412   clang
i386                  randconfig-002-20240412   gcc  
i386                  randconfig-003-20240412   clang
i386                  randconfig-004-20240412   clang
i386                  randconfig-005-20240412   clang
i386                  randconfig-006-20240412   gcc  
i386                  randconfig-011-20240412   clang
i386                  randconfig-012-20240412   gcc  
i386                  randconfig-013-20240412   clang
i386                  randconfig-014-20240412   gcc  
i386                  randconfig-015-20240412   gcc  
i386                  randconfig-016-20240412   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240412   gcc  
loongarch             randconfig-002-20240412   gcc  
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
nios2                 randconfig-001-20240412   gcc  
nios2                 randconfig-002-20240412   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240412   gcc  
parisc                randconfig-002-20240412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240412   clang
powerpc               randconfig-002-20240412   clang
powerpc               randconfig-003-20240412   gcc  
powerpc64             randconfig-001-20240412   gcc  
powerpc64             randconfig-002-20240412   gcc  
powerpc64             randconfig-003-20240412   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240412   clang
riscv                 randconfig-002-20240412   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240412   gcc  
s390                  randconfig-002-20240412   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240412   gcc  
sh                    randconfig-002-20240412   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240412   gcc  
sparc64               randconfig-002-20240412   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240412   clang
um                    randconfig-002-20240412   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240412   gcc  
x86_64       buildonly-randconfig-002-20240412   gcc  
x86_64       buildonly-randconfig-003-20240412   gcc  
x86_64       buildonly-randconfig-004-20240412   clang
x86_64       buildonly-randconfig-005-20240412   clang
x86_64       buildonly-randconfig-006-20240412   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240412   clang
x86_64                randconfig-002-20240412   gcc  
x86_64                randconfig-003-20240412   gcc  
x86_64                randconfig-004-20240412   clang
x86_64                randconfig-005-20240412   clang
x86_64                randconfig-006-20240412   clang
x86_64                randconfig-011-20240412   clang
x86_64                randconfig-012-20240412   gcc  
x86_64                randconfig-013-20240412   clang
x86_64                randconfig-014-20240412   clang
x86_64                randconfig-015-20240412   clang
x86_64                randconfig-016-20240412   gcc  
x86_64                randconfig-071-20240412   gcc  
x86_64                randconfig-072-20240412   clang
x86_64                randconfig-073-20240412   clang
x86_64                randconfig-074-20240412   gcc  
x86_64                randconfig-075-20240412   gcc  
x86_64                randconfig-076-20240412   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

