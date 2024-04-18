Return-Path: <linux-kernel+bounces-149355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18A8A9000
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625321F225BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EA15C9;
	Thu, 18 Apr 2024 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n04gTQQN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE5382
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399895; cv=none; b=Agit09Prm2LSG93EAEM4IMIgez0WsJC4eauYsXY9UgBIFuUrH0BOTXcbXk+D7QgSHNyKH6on1tmZvGBDHHOJ9CULmibRnTg5yH9YaJIXfBWzKP7PnV3JukeBa6eVsE1RyOjjlCnMcixp0qUc4XoXeXWV0bsKW1fiQSs4OcvnRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399895; c=relaxed/simple;
	bh=1UBiJL0aM/tZ23zWx2R+mPZaBSEn0/ZD0YU8+hR4s60=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sonmyBOqEWtpbVoa0+kvvpdhmuwdiSV3x7RufsXblLmufCdWt7rX391lZC/O0SBbBlI73kESd4xWeHPe+sQFNgqVX4OB1FWj98w5H8QfXXmRRNv/gQzzolfxTnvQJno6XLVrkjGC+kidwcEAn/5NLbjEnhahK+Cx7j/8K0CdfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n04gTQQN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713399893; x=1744935893;
  h=date:from:to:cc:subject:message-id;
  bh=1UBiJL0aM/tZ23zWx2R+mPZaBSEn0/ZD0YU8+hR4s60=;
  b=n04gTQQNalZGQeNvrU8YRAFvULqOXJsd7k9IlwPKUfM5YYD5APeENqNq
   YaSkVvLTNmtkbiIAmHy/WlHeLOrzi7J5lLw7Qdh7vJrgFrJiOetNNACIo
   YnfiyrkjISmWq++peGp3rVnJmYNiQx5d7Axn6a0guMjguKLUAZWh8YfAX
   xqKylkcOTr4+KMUmAjg3cRWBdbeXxDuPXm5a2ZQSKTyujHcZ5lH3mo5Kr
   PMXlDKqEvRz2NwKDJHbyN7S0In0kxYwyD8y7/Jf74tR78tZAjITtaG93a
   xWagaQeO4z71WGvzOcf0kjlhEY6pqVhBx0+6L8/NyfPYIDBh8poGvb65+
   A==;
X-CSE-ConnectionGUID: CaLpaIYnRLKVTmlGJrTvmA==
X-CSE-MsgGUID: nUAED52NSPSEadWMmEAt7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20068111"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="20068111"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 17:24:53 -0700
X-CSE-ConnectionGUID: /joKDGQJRrCQgvF3C+zP8w==
X-CSE-MsgGUID: G8CIOFh8RE6F+ieLUAYa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="46083298"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Apr 2024 17:24:51 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxFa5-00077U-0k;
	Thu, 18 Apr 2024 00:24:49 +0000
Date: Thu, 18 Apr 2024 08:23:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1e0fd81e4f32a8a383c05d27a672d742b45c1088
Message-ID: <202404180851.qZq2VaNf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1e0fd81e4f32a8a383c05d27a672d742b45c1088  Merge branch into tip/master: 'x86/shstk'

elapsed time: 732m

configs tested: 101
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
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
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

