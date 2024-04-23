Return-Path: <linux-kernel+bounces-155901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F28AF8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71541C22C04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE3143865;
	Tue, 23 Apr 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrjPm9ta"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B912142E74
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906168; cv=none; b=b6Sd4RaXQrofiy4TdV2vIdc1YJmEsnPv3olljsUgIUPXwhqgQaxUJKCBwqdXEJaNIZWBHF4S76n+SJAl/qF3HKLV4CzhlrC4T1L7G+TZPF5pg2Cp6YL/RE2ZMH24mzwsGGeznAK3PboIYKjEYwp8adr5ucK16ia+uVNfyUEB44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906168; c=relaxed/simple;
	bh=cDl4XZPxQWTpxj5blcOmXam97d7ldd8LQhS8RqWqX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q9iCIHZNyE8m8kljGkxuIDR0ElAiCoUKvnheLapQP1uCitan6vmgijyXBo6SZR9hIH6T0OUhFV/8S6ZBPWATy3T3lExTglyoY+rj5yxGs3B9st9NDGBWkDym96ckimypg6gbEGIaz05oXN9GJfBjpVjEKchWAxkxdp6EX9rKQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrjPm9ta; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713906166; x=1745442166;
  h=date:from:to:cc:subject:message-id;
  bh=cDl4XZPxQWTpxj5blcOmXam97d7ldd8LQhS8RqWqX5Q=;
  b=HrjPm9taJE81qxT8gUgbxWYCa039Fb3I/vBj60eYEKvF/b7d3B6Gu+/J
   60OiNkxkwRU7DxBIzAwKs2Fyj1xJID82qv5sFsrZuogf2xW3Fu7Y75/mf
   TYVjmGShV4Wrw0MmqZdsdUT8IU7EZolXEZxRde+FRXm2fO9wRp+P4vMyM
   q5xMWxNmD6RGg3VVzpTuvBADE3E6+JUzmq5D/kCg8IoyYvcmIzAs8t9OK
   vMvU5IVrekMZ8lCoIGvesjpOiQ+CEbrDbLMCJBk0YW9mS/kExjtt4PG0D
   souwwfSEUydRPZVH3cpgXhOCALIERrg/SwqeaY9Pg7BR3pDgSa4Ww/24C
   Q==;
X-CSE-ConnectionGUID: FCSRahA3RPuCE/ZJz54A/g==
X-CSE-MsgGUID: qogNLLPkSnye2MVko0WMLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20919499"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20919499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:02:45 -0700
X-CSE-ConnectionGUID: Lio/AtW1Rn66vTBA2gPGVw==
X-CSE-MsgGUID: b/3NDR3PRLq+1spOweFRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55693383"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2024 14:02:44 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzNHm-0000Wq-15;
	Tue, 23 Apr 2024 21:02:42 +0000
Date: Wed, 24 Apr 2024 05:01:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5a04007fb7a9a3f101fe551f0e47849f2cd1125b
Message-ID: <202404240556.AyEKWPkV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5a04007fb7a9a3f101fe551f0e47849f2cd1125b  Merge branch into tip/master: 'x86/shstk'

elapsed time: 726m

configs tested: 113
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
arc                   randconfig-001-20240424   gcc  
arc                   randconfig-002-20240424   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240424   gcc  
arm                   randconfig-002-20240424   gcc  
arm                   randconfig-003-20240424   gcc  
arm                   randconfig-004-20240424   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240424   clang
arm64                 randconfig-002-20240424   gcc  
arm64                 randconfig-003-20240424   gcc  
arm64                 randconfig-004-20240424   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240424   gcc  
csky                  randconfig-002-20240424   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240423   clang
i386         buildonly-randconfig-002-20240423   clang
i386         buildonly-randconfig-003-20240423   gcc  
i386         buildonly-randconfig-004-20240423   clang
i386         buildonly-randconfig-005-20240423   clang
i386         buildonly-randconfig-006-20240423   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240423   gcc  
i386                  randconfig-002-20240423   gcc  
i386                  randconfig-003-20240423   clang
i386                  randconfig-004-20240423   gcc  
i386                  randconfig-005-20240423   clang
i386                  randconfig-006-20240423   clang
i386                  randconfig-011-20240423   gcc  
i386                  randconfig-012-20240423   clang
i386                  randconfig-013-20240423   clang
i386                  randconfig-014-20240423   gcc  
i386                  randconfig-015-20240423   gcc  
i386                  randconfig-016-20240423   clang
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

