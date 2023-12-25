Return-Path: <linux-kernel+bounces-11100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFE81E143
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB631C2109D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833C524D9;
	Mon, 25 Dec 2023 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icsBW66c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25E51C27
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703517121; x=1735053121;
  h=date:from:to:cc:subject:message-id;
  bh=KubMVrvh2W/iX19De3HYI93IZZAvuWqwFG1+ExiVGIM=;
  b=icsBW66cILGiGruMhRzE8fxGolNAAZ0KpxEwwavRGDU8vRdR1mmIhlrw
   0BUF0g4wIfWEExpKrTPmleAGz8cdns+NhHkM0Y8cz7kXIf4uSEJ2i05hF
   DoOp3/K9I39BKYqIJ3O8pJfBrHWW/cZw42y+Yt1KEHcpHLly9nJlZPhES
   WB6OsKowB7N0682uNx6ccnkjkImXvnGbY5735m80+IPqu42QXVtt+7oHY
   NxSpTJASkwk/uvauRCB746T9Ucuwpuo4yFaYLPmYPyvr1qoUHlFjlRQxO
   JBZS5psezmnHm/4Kd6tiuU1G13zN2oG2zyGouEsSEIvGRjNpDmiY/2UzA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9693086"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="9693086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 07:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="19449794"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Dec 2023 07:11:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHmcO-000DMf-3C;
	Mon, 25 Dec 2023 15:11:48 +0000
Date: Mon, 25 Dec 2023 23:11:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8b3f2a2af0f90c039e11a7261d952eda2355674c
Message-ID: <202312252334.VwMnJa6s-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8b3f2a2af0f90c039e11a7261d952eda2355674c  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1694m

configs tested: 98
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                   randconfig-001-20231225   gcc  
arc                   randconfig-002-20231225   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-001-20231225   clang
arm                   randconfig-002-20231225   clang
arm                   randconfig-003-20231225   clang
arm                   randconfig-004-20231225   clang
arm64                 randconfig-001-20231225   clang
arm64                 randconfig-002-20231225   clang
arm64                 randconfig-003-20231225   clang
arm64                 randconfig-004-20231225   clang
csky                  randconfig-001-20231225   gcc  
csky                  randconfig-002-20231225   gcc  
hexagon               randconfig-001-20231225   clang
hexagon               randconfig-002-20231225   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231225   clang
i386         buildonly-randconfig-002-20231225   clang
i386         buildonly-randconfig-003-20231225   clang
i386         buildonly-randconfig-004-20231225   clang
i386         buildonly-randconfig-005-20231225   clang
i386         buildonly-randconfig-006-20231225   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231225   clang
i386                  randconfig-002-20231225   clang
i386                  randconfig-003-20231225   clang
i386                  randconfig-004-20231225   clang
i386                  randconfig-005-20231225   clang
i386                  randconfig-006-20231225   clang
i386                  randconfig-011-20231225   gcc  
i386                  randconfig-012-20231225   gcc  
i386                  randconfig-013-20231225   gcc  
i386                  randconfig-014-20231225   gcc  
i386                  randconfig-015-20231225   gcc  
i386                  randconfig-016-20231225   gcc  
loongarch             randconfig-001-20231225   gcc  
loongarch             randconfig-002-20231225   gcc  
nios2                 randconfig-001-20231225   gcc  
nios2                 randconfig-002-20231225   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231225   gcc  
parisc                randconfig-002-20231225   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231225   clang
powerpc               randconfig-002-20231225   clang
powerpc               randconfig-003-20231225   clang
powerpc64             randconfig-001-20231225   clang
powerpc64             randconfig-002-20231225   clang
powerpc64             randconfig-003-20231225   clang
riscv                 randconfig-001-20231225   clang
riscv                 randconfig-002-20231225   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231225   gcc  
s390                  randconfig-002-20231225   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231225   gcc  
sh                    randconfig-002-20231225   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231225   gcc  
sparc64               randconfig-002-20231225   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231225   clang
um                    randconfig-002-20231225   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231225   clang
x86_64       buildonly-randconfig-002-20231225   clang
x86_64       buildonly-randconfig-003-20231225   clang
x86_64       buildonly-randconfig-004-20231225   clang
x86_64       buildonly-randconfig-005-20231225   clang
x86_64       buildonly-randconfig-006-20231225   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231225   gcc  
x86_64                randconfig-002-20231225   gcc  
x86_64                randconfig-003-20231225   gcc  
x86_64                randconfig-004-20231225   gcc  
x86_64                randconfig-005-20231225   gcc  
x86_64                randconfig-006-20231225   gcc  
x86_64                randconfig-011-20231225   clang
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231225   gcc  
xtensa                randconfig-002-20231225   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

