Return-Path: <linux-kernel+bounces-1736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2581535A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C41C2309B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF118EB0;
	Fri, 15 Dec 2023 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtNco/u7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717518EA9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702678468; x=1734214468;
  h=date:from:to:cc:subject:message-id;
  bh=ZZAohyiDm9flxJ9DkJhHiTozgm7jEmruDKoc18NP2SU=;
  b=EtNco/u7fra27GD/TMaM9cql2upk1zEWDF2uf+/8MJgKydVPHXYzC3Tw
   Nh5RcIUFrXO8joYtM2uHVIzd1ht4hnZuwrIWewfKuKGra0J7tSqrG8EGe
   8hIgo2Ia1fSvQXKqaoSL474Mi/QlVHYYZbeEL1JRcylMlZepeF2xw1bXp
   dPSMNMRKwCNMBdZFEuvF6hLYB63BNroDOtVD8nxTL3ngkM6DkhPEtijCX
   Cg4JzQmwg6ZljcRC76DiQPQ/6HZ6j+eirNuXL5KqaL8MTGOkQiyfTSurO
   lM+zQumY3afu/e6Fjw46eVZtzfrt/DYhqzmgpMMu6DkNvABysLcriBXkp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2502628"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2502628"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="803851207"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="803851207"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2023 14:14:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEGRr-0000oy-1S;
	Fri, 15 Dec 2023 22:14:23 +0000
Date: Sat, 16 Dec 2023 06:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 f1242ec0ad8f11c414da5bd56ba62ae8264df643
Message-ID: <202312160624.WWAYKagW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: f1242ec0ad8f11c414da5bd56ba62ae8264df643  doc: Update checklist.rst discussion of callback execution

elapsed time: 1495m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
arm64                 randconfig-002-20231216   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231216   gcc  
csky                  randconfig-002-20231216   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231215   clang
i386         buildonly-randconfig-002-20231215   clang
i386         buildonly-randconfig-003-20231215   clang
i386         buildonly-randconfig-004-20231215   clang
i386         buildonly-randconfig-005-20231215   clang
i386         buildonly-randconfig-006-20231215   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231215   clang
i386                  randconfig-002-20231215   clang
i386                  randconfig-003-20231215   clang
i386                  randconfig-004-20231215   clang
i386                  randconfig-005-20231215   clang
i386                  randconfig-006-20231215   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231215   gcc  
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
mips                              allnoconfig   clang
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
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

