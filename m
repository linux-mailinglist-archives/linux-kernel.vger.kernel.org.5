Return-Path: <linux-kernel+bounces-152437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560C8ABE67
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 04:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504871C20A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADB4A39;
	Sun, 21 Apr 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/NUtgiP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EB4414
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713665590; cv=none; b=shsC1Z6SFyK58h+f9jLq3ne6nca5rK60QISGcTGXGUK0z0pFu+6HcHiMNcu56T23HIxXEczWrn6H63l3Q4vvXyPJR7CBRaA/ymWPf4U3SnlXb7BdXrbH4XJOts0RzWSIB8j8tnnHL5nZQedu88DxfoWuN2dseHE6+hX5arV+5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713665590; c=relaxed/simple;
	bh=ZGe4TBejBeBF82VPYNTHeSBjacyaNjWwEhTlP0f+yDw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b5ocDUJgDy15dfjQw1YzVsfQlmIs7YmgUUGTtPStFGkfH7KnQXAOUuCQtj7vkaDBrdLTFA28nksjXQIYVTuof49MU+MPqXCC/l7XYGvyqvZusSZijfK647yiaewWPWzHmcUiuVWatKNdrpQycfRw5IFg7xgZvdz1SR2BnExwQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/NUtgiP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713665588; x=1745201588;
  h=date:from:to:cc:subject:message-id;
  bh=ZGe4TBejBeBF82VPYNTHeSBjacyaNjWwEhTlP0f+yDw=;
  b=K/NUtgiPTSuk7BKbtoYPHXok/hydF0JKpVMu+M7XjjVjaCiursm0h7tk
   A0zC6GRlTG1XDRhaPAJjWv2FPNQDIwxEo1YgdSTA+zhH2w9/xb6AJa4KR
   rTHRlPgK1nmW8Vqy8l9a5N+U1cp/VnJqpTu5hMf0sx8i70o0YwyOH3GoH
   gJxFfP2gU1o4Y4rKZ0H5O1fQ4v2GyG/+3dz5+sgMcOlke+vNFTYnKy/TS
   Wd7Hn18SFHGbM8a6HeYbRVNX3OTQ9EYWQcNmsaGeZe1iVXsyRKUzR9OeV
   KcS9/ijHn4lKCHwQAievsS9eJOQFJS+BRiBe3ws19WRlngyWY0LuftpHe
   A==;
X-CSE-ConnectionGUID: qPsFqSB/TXqTMkTvWk4n2w==
X-CSE-MsgGUID: z6YpnZL7TNSZVFOq1Q68nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="19844137"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="19844137"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 19:13:08 -0700
X-CSE-ConnectionGUID: NM4nvzcNRTKMYbUtS9p4Kg==
X-CSE-MsgGUID: a8KW8qPWRJyssPfceRbS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="23566328"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 Apr 2024 19:13:06 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryMhT-000Bd4-2X;
	Sun, 21 Apr 2024 02:13:03 +0000
Date: Sun, 21 Apr 2024 10:12:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 88b063eac6bdfd464c111c4b2c2a243cd9aaed01
Message-ID: <202404211024.QK4ReJ8f-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 88b063eac6bdfd464c111c4b2c2a243cd9aaed01  Merge branch into tip/master: 'x86/shstk'

elapsed time: 983m

configs tested: 161
configs skipped: 5

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
arc                   randconfig-001-20240421   gcc  
arc                   randconfig-002-20240421   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240421   clang
arm                   randconfig-002-20240421   clang
arm                   randconfig-003-20240421   clang
arm                   randconfig-004-20240421   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240421   gcc  
arm64                 randconfig-002-20240421   clang
arm64                 randconfig-003-20240421   gcc  
arm64                 randconfig-004-20240421   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240421   gcc  
csky                  randconfig-002-20240421   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240421   clang
hexagon               randconfig-002-20240421   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240420   gcc  
i386         buildonly-randconfig-002-20240420   clang
i386         buildonly-randconfig-003-20240420   gcc  
i386         buildonly-randconfig-004-20240420   gcc  
i386         buildonly-randconfig-005-20240420   gcc  
i386         buildonly-randconfig-006-20240420   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240420   clang
i386                  randconfig-002-20240420   gcc  
i386                  randconfig-003-20240420   gcc  
i386                  randconfig-004-20240420   gcc  
i386                  randconfig-005-20240420   clang
i386                  randconfig-006-20240420   gcc  
i386                  randconfig-011-20240420   clang
i386                  randconfig-012-20240420   clang
i386                  randconfig-013-20240420   clang
i386                  randconfig-014-20240420   clang
i386                  randconfig-015-20240420   clang
i386                  randconfig-016-20240420   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240421   gcc  
loongarch             randconfig-002-20240421   gcc  
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
nios2                 randconfig-001-20240421   gcc  
nios2                 randconfig-002-20240421   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240421   gcc  
parisc                randconfig-002-20240421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240421   clang
powerpc               randconfig-002-20240421   clang
powerpc               randconfig-003-20240421   clang
powerpc64             randconfig-001-20240421   clang
powerpc64             randconfig-002-20240421   gcc  
powerpc64             randconfig-003-20240421   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240421   clang
riscv                 randconfig-002-20240421   gcc  
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240421   clang
s390                  randconfig-002-20240421   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240421   gcc  
sh                    randconfig-002-20240421   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240421   gcc  
sparc64               randconfig-002-20240421   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240421   gcc  
um                    randconfig-002-20240421   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240420   gcc  
x86_64       buildonly-randconfig-002-20240420   clang
x86_64       buildonly-randconfig-003-20240420   gcc  
x86_64       buildonly-randconfig-004-20240420   gcc  
x86_64       buildonly-randconfig-005-20240420   clang
x86_64       buildonly-randconfig-006-20240420   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240420   clang
x86_64                randconfig-002-20240420   clang
x86_64                randconfig-003-20240420   gcc  
x86_64                randconfig-004-20240420   clang
x86_64                randconfig-005-20240420   clang
x86_64                randconfig-006-20240420   gcc  
x86_64                randconfig-011-20240420   gcc  
x86_64                randconfig-012-20240420   gcc  
x86_64                randconfig-013-20240420   gcc  
x86_64                randconfig-014-20240420   gcc  
x86_64                randconfig-015-20240420   clang
x86_64                randconfig-016-20240420   gcc  
x86_64                randconfig-071-20240420   gcc  
x86_64                randconfig-072-20240420   gcc  
x86_64                randconfig-073-20240420   gcc  
x86_64                randconfig-074-20240420   gcc  
x86_64                randconfig-075-20240420   gcc  
x86_64                randconfig-076-20240420   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240421   gcc  
xtensa                randconfig-002-20240421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

