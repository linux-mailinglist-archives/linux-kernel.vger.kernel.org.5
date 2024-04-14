Return-Path: <linux-kernel+bounces-144420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CE8A4632
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A9F1C211B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049AC137771;
	Sun, 14 Apr 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqRiZRHj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FD2942A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713138083; cv=none; b=acQdDl9r6dx+ElZpIL74zclAfJLDwuS/Wgt8Dp7NOFjuMIrtRjH8hB093FXuXX4RwLe4b0fTjmwhW/7dzJBzLesM9ybeFwase47rOa0UAUU1czYkX6d6o048Ww2/C7fAArFjPstxYrkghxg/d3W6FIjsx3FzPU5l8JG63wvv1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713138083; c=relaxed/simple;
	bh=mkBggmJG81Vol1LPFWDUTVskQqv5izhLbu5z1j0yYT0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m+nmpInBkRYQ0+UstNhv+QWf1PM9se/wh9EVhZ6qrC+NmW7ViE/ZBC+yMzo9oTiXfUbhJx03TRIjtlGyFjCvRw4BSwp4RWSLni4d5j8NgWt6IGUubvdGYpr5V2jccjnR+nwpqhv4PJXGN/xWvBFMjRc4/v7y8B1adFf2M0GvzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqRiZRHj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713138081; x=1744674081;
  h=date:from:to:cc:subject:message-id;
  bh=mkBggmJG81Vol1LPFWDUTVskQqv5izhLbu5z1j0yYT0=;
  b=lqRiZRHjONklRdLH+ThdNTRdLdV/HlnxPsnjOnkxsDiQVlgw+FwB3XtO
   8uw7l73D0oF7DI4PVKpWISQ33di7j4rPEkOKl4EiUFtviSKHYB3Ox/36A
   pVlKHaLNItduHgkdmjNvEF0OZwWyimJBgZXxFDekA2TuEQm4EJc7cGzNW
   kPpSY3cI4YX8OdkTx9QT4n1pyD4pzeAVCv1PSRw/Cz2Cw4dJ5exPVLsuw
   EtGk9teB4rV3YGl3jxaW0BT2rYbXgzArFA+xgVg4QVzUxZw+xBg/mBbqN
   +Br1yc/0XkvxTt48Q+fuufUrsFS1cZvb1jbGLV6QddlVGAfGnzQt00Jqg
   Q==;
X-CSE-ConnectionGUID: qX8C6y2KTyyGujoe3VnU4g==
X-CSE-MsgGUID: uaEBqbC6Tp6zogOLySMt3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8637862"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8637862"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 16:41:20 -0700
X-CSE-ConnectionGUID: DKE7Y5lkRC+yazdP68x4og==
X-CSE-MsgGUID: qDB1giu/TjmpYtRBsX5oCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26552529"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 14 Apr 2024 16:41:19 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rw9TI-0003ro-1h;
	Sun, 14 Apr 2024 23:41:16 +0000
Date: Mon, 15 Apr 2024 07:41:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 35d77eb7b974f62aaef5a0dc72d93ddb1ada4074
Message-ID: <202404150712.a2rtORpV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 35d77eb7b974f62aaef5a0dc72d93ddb1ada4074  irqchip/riscv-imsic: Fix boot time update effective affinity warning

elapsed time: 725m

configs tested: 180
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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240414   gcc  
arc                   randconfig-002-20240414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240414   clang
arm                   randconfig-002-20240414   clang
arm                   randconfig-003-20240414   gcc  
arm                   randconfig-004-20240414   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240414   gcc  
arm64                 randconfig-002-20240414   clang
arm64                 randconfig-003-20240414   gcc  
arm64                 randconfig-004-20240414   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240414   gcc  
csky                  randconfig-002-20240414   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240414   clang
hexagon               randconfig-002-20240414   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240414   gcc  
i386         buildonly-randconfig-002-20240414   clang
i386         buildonly-randconfig-003-20240414   gcc  
i386         buildonly-randconfig-004-20240414   gcc  
i386         buildonly-randconfig-005-20240414   gcc  
i386         buildonly-randconfig-006-20240414   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240414   clang
i386                  randconfig-002-20240414   gcc  
i386                  randconfig-003-20240414   gcc  
i386                  randconfig-004-20240414   gcc  
i386                  randconfig-005-20240414   gcc  
i386                  randconfig-006-20240414   clang
i386                  randconfig-011-20240414   clang
i386                  randconfig-012-20240414   clang
i386                  randconfig-013-20240414   gcc  
i386                  randconfig-014-20240414   gcc  
i386                  randconfig-015-20240414   clang
i386                  randconfig-016-20240414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240414   gcc  
loongarch             randconfig-002-20240414   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                         rt305x_defconfig   clang
mips                        vocore2_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240414   gcc  
nios2                 randconfig-002-20240414   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240414   gcc  
parisc                randconfig-002-20240414   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240414   clang
powerpc               randconfig-002-20240414   clang
powerpc               randconfig-003-20240414   gcc  
powerpc64             randconfig-001-20240414   clang
powerpc64             randconfig-002-20240414   gcc  
powerpc64             randconfig-003-20240414   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240414   clang
riscv                 randconfig-002-20240414   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240414   clang
s390                  randconfig-002-20240414   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240414   gcc  
sh                    randconfig-002-20240414   gcc  
sh                           se7724_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240414   gcc  
sparc64               randconfig-002-20240414   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240414   gcc  
um                    randconfig-002-20240414   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240414   clang
x86_64       buildonly-randconfig-002-20240414   clang
x86_64       buildonly-randconfig-003-20240414   clang
x86_64       buildonly-randconfig-004-20240414   clang
x86_64       buildonly-randconfig-005-20240414   gcc  
x86_64       buildonly-randconfig-006-20240414   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240414   gcc  
x86_64                randconfig-002-20240414   clang
x86_64                randconfig-003-20240414   gcc  
x86_64                randconfig-004-20240414   gcc  
x86_64                randconfig-005-20240414   clang
x86_64                randconfig-006-20240414   clang
x86_64                randconfig-011-20240414   clang
x86_64                randconfig-012-20240414   gcc  
x86_64                randconfig-013-20240414   gcc  
x86_64                randconfig-014-20240414   gcc  
x86_64                randconfig-015-20240414   gcc  
x86_64                randconfig-016-20240414   gcc  
x86_64                randconfig-071-20240414   gcc  
x86_64                randconfig-072-20240414   clang
x86_64                randconfig-073-20240414   clang
x86_64                randconfig-074-20240414   gcc  
x86_64                randconfig-075-20240414   clang
x86_64                randconfig-076-20240414   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240414   gcc  
xtensa                randconfig-002-20240414   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

