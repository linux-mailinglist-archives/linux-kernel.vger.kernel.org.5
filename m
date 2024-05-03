Return-Path: <linux-kernel+bounces-167965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C598BB1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B38128655C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84602158D9A;
	Fri,  3 May 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/l5s6AH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0515885F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756787; cv=none; b=COUE3UKMq/NQh+TB+eUTFuozMvz2Gyv0Mmw8dIoeBNnOwdcDHbMkSswN6xhWXu74+cFSufyna1Bd6TNJreBICHgELEegYCvMNe0Fch2/+b4mKP6l57PSaVFVqnZUWpeAxln6ZUiy8838db77p3SFOB8wF80tYiDIYpbqCFNlvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756787; c=relaxed/simple;
	bh=gFfce9/YqUqKMKl8N7lkGvPv61pbijOYVPdAqGSFILU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kbCE3KGzXZ85VDEmePCpvxIiHQOV8fWgp+qoUKhZxY09FIE5nYOnEz1ftqe8701uEYvgtAhhPVy9NyvxCEJqg2dUuxQ9GiBWrEuefuB3Ii64gEkWEJg0Ysz5RKn+sKezbWNpTM3pk7qzVqUSG7ugI09lxBCqh3g/CsQvwzCPtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/l5s6AH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756786; x=1746292786;
  h=date:from:to:cc:subject:message-id;
  bh=gFfce9/YqUqKMKl8N7lkGvPv61pbijOYVPdAqGSFILU=;
  b=K/l5s6AHuVqfzw8/eCNcPxQuj8T4je+HXiXW9YYj+PhmajA6eH1DBjTH
   zR+TgqG6JYhlWq3rsjQgn1ngpnBRUNtphA/FetLZqM6mEB/vUsmWv+l2W
   pKbr1udfpq28VusnhUK89+MgNlzzrQBwOeHqk+HIoikZUbpHfEyKXsnaP
   WYaZxnX6CuOEzNI+PmEDYYqKqFRHLGw87/FyXmfBM3T9UCmK5XqLnSJxK
   5x43VzI54zZ0Og1MNYlgM5dQ8I0nJ9pjbWq2sDvFi7xnPa84LhHs5yG6B
   KhsMt6jXcPhME3TO8XRiId5DyhovxbjttiQ0i2MDYx6+cB3gjbm2IDJBD
   Q==;
X-CSE-ConnectionGUID: Mjc3csYBRs+1HpycrG11IQ==
X-CSE-MsgGUID: 0OWXKi/GRDe/Oz1eR7M24w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10500208"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10500208"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:46 -0700
X-CSE-ConnectionGUID: hqz3UYJNS76Oe20uFtLv0A==
X-CSE-MsgGUID: IZOvtKIpTR+1tZV0UksdRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27911515"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 May 2024 10:19:44 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2wZS-000Bwe-0Q;
	Fri, 03 May 2024 17:19:42 +0000
Date: Sat, 04 May 2024 01:19:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240501-CbC] BUILD SUCCESS
 f4d622e4c21a03b694e3ffe991cff14742187f5f
Message-ID: <202405040159.b3fhOPGh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240501-CbC
branch HEAD: f4d622e4c21a03b694e3ffe991cff14742187f5f  treewide_some: fix multiple -Wfamnae warnings that must be audited separately

elapsed time: 1460m

configs tested: 139
configs skipped: 4

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
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-002-20240503   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240503   clang
arm                   randconfig-002-20240503   clang
arm                   randconfig-003-20240503   clang
arm                   randconfig-004-20240503   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240503   clang
arm64                 randconfig-002-20240503   gcc  
arm64                 randconfig-003-20240503   clang
arm64                 randconfig-004-20240503   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-002-20240503   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240503   clang
hexagon               randconfig-002-20240503   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-003-20240503   gcc  
i386         buildonly-randconfig-004-20240503   gcc  
i386         buildonly-randconfig-005-20240503   gcc  
i386         buildonly-randconfig-006-20240503   clang
i386                                defconfig   clang
i386                  randconfig-001-20240503   gcc  
i386                  randconfig-002-20240503   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240503   gcc  
i386                  randconfig-005-20240503   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240503   gcc  
i386                  randconfig-013-20240503   gcc  
i386                  randconfig-014-20240503   gcc  
i386                  randconfig-015-20240503   gcc  
i386                  randconfig-016-20240503   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-002-20240503   gcc  
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
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-002-20240503   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-002-20240503   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240503   clang
powerpc               randconfig-002-20240503   clang
powerpc               randconfig-003-20240503   gcc  
powerpc64             randconfig-001-20240503   clang
powerpc64             randconfig-002-20240503   clang
powerpc64             randconfig-003-20240503   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
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
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240503   gcc  
x86_64       buildonly-randconfig-002-20240503   gcc  
x86_64       buildonly-randconfig-003-20240503   gcc  
x86_64       buildonly-randconfig-004-20240503   clang
x86_64       buildonly-randconfig-005-20240503   gcc  
x86_64       buildonly-randconfig-006-20240503   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240503   clang
x86_64                randconfig-002-20240503   clang
x86_64                randconfig-003-20240503   clang
x86_64                randconfig-004-20240503   gcc  
x86_64                randconfig-005-20240503   gcc  
x86_64                randconfig-006-20240503   clang
x86_64                randconfig-011-20240503   clang
x86_64                randconfig-012-20240503   clang
x86_64                randconfig-013-20240503   clang
x86_64                randconfig-014-20240503   clang
x86_64                randconfig-015-20240503   clang
x86_64                randconfig-016-20240503   clang
x86_64                randconfig-071-20240503   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

