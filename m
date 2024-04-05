Return-Path: <linux-kernel+bounces-132387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDB8993EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25CC28C721
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B21B813;
	Fri,  5 Apr 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/WmQdPD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41D1643D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712288310; cv=none; b=gNZWxVAeqHCx3Uow/z0i5tB3MEZrvnmDrPLsrsXrS7k6gljayJ0qHMsKfuL5zQD5yndoF+lfz1oL3gVB/rfntTZcjHLv47LL4UO3Mc956bRpXy+GAR/O3sa9tsGL8pNFuGQm/hA+hGKZ2WyNJ2dRDw9OojQH9ihB8DNt9tR1f9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712288310; c=relaxed/simple;
	bh=Npx8EzspB33EAk75V65R5ZqAorWao9gaOPcjc00K7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IgAz7lxrydtLeTEVSaQRtUrHsOxKYPrHRyDygldxpbvKBT7zkrYKxmApEhnKSs9CFaQfUkKLEHPfpp3NRiVUOFWHNZxTrJvVs2cZBzKmy5OicZYfcwoEo3G471w/nuUCU7/63zP3aztk0v0ZJdrVrJejFh7wQEXe2NvgfEa6vPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/WmQdPD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712288308; x=1743824308;
  h=date:from:to:cc:subject:message-id;
  bh=Npx8EzspB33EAk75V65R5ZqAorWao9gaOPcjc00K7Ac=;
  b=j/WmQdPDdOYZg41Lm5ztpyl6ke8ZcnicR50xdcThlfZJtu8I8V9tR7B6
   9/NEeB/L7eVdcCjt+Pwavek8ffzDb7Mnkkr/VFcTsTpEZe09G9oIxwQVQ
   fzuXKL4Zy5wiv6Pz9NEIcyyCR17iUHAOYWsfzNFdnEwPCYYIfMicIoqUT
   aKXBv4ZRWj3snVXlOgQfAsLGJZ7WAqiwWwgQkJwP91+fsKse/x5GNZWsm
   cZL1U30PXAwQZr4MY0WiNQq2ENcCjSvgLnu2kJTk1zu0iFUKg+eJ4hKXd
   8B5YqdHHQlUJHxEDDyx3QXgu/5Jqc7SbMztg3lw61ITAYoNtotwE4ds4n
   g==;
X-CSE-ConnectionGUID: gdcHjqHfSZ++KMoHnO0P/g==
X-CSE-MsgGUID: hrQn4rxgQn286ZgOCF9VdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7733850"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7733850"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:38:28 -0700
X-CSE-ConnectionGUID: NLZnt1NHRUGDrIVoVgfDJA==
X-CSE-MsgGUID: jnHf72n4TEGstJvJuCgSSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19126240"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Apr 2024 20:38:25 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsaPG-0001qY-1d;
	Fri, 05 Apr 2024 03:38:22 +0000
Date: Fri, 05 Apr 2024 11:38:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 cb517619f96718a4c3c2534a3124177633f8998d
Message-ID: <202404051100.DZX48D53-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: cb517619f96718a4c3c2534a3124177633f8998d  x86/extable: Remove unused fixup type EX_TYPE_COPY

elapsed time: 741m

configs tested: 81
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-011-20240405   clang
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

