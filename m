Return-Path: <linux-kernel+bounces-166026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FF8B94EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E4B1F21268
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16A1CD3D;
	Thu,  2 May 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDT4VD0t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DD1527BD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632994; cv=none; b=N797+EqhzLOfVlz3qhtIs0fNIwKZz0uZbhwDoF2P4khh4G6fRc89majxlEb9u+JjYExnatjWvqf+zRmxR7IilSS6yF65nGu/NGfy9DsXcBxZwuD8/8g21UHbOsdOW3du8DzI4TmEtneMAP2GJ5RIn7lQPyloQG3cL0EfQTP+4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632994; c=relaxed/simple;
	bh=Z8AsIC9TggLPGl5mDIWjigGptzKGPkOeAv76Z2bONtA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r8+ayQW9V8qz+efLuYVt+d0Bp1ZzOgVJxOSPqbHskPyGy3NfbGvsx3vpowuIkSLDCipMtmVgBvkXLupmECO97DVkaWVEh1R0nmNabzhUlc8LcoSAE5+oV1XHUKqkK+VUhDEpVj2oo8vR6c44JsW/BJ7+kSqGrkMcz2zJsrwpbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDT4VD0t; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714632992; x=1746168992;
  h=date:from:to:cc:subject:message-id;
  bh=Z8AsIC9TggLPGl5mDIWjigGptzKGPkOeAv76Z2bONtA=;
  b=mDT4VD0tSj8yVd0s5Ctq183nJPNWUk/6818yAha2bl5vQP7qRgdYn0uT
   sNQqgBunw4S2DQYV5dlEHRwBJaMohQto/DW8TEUCaAlQGYA0idtGFC267
   H+KIi5AKuDH4dSkYbi1KN4BPdtkuXaQCtyWaGKykTLJwMRCX6zvLmsLdI
   HOvQKNrOwlJzFK7NZ80rh63YXk/Cvc+UbVGpy5qEOgNlBO1+jzIVudha3
   eWw9gXSvUfqmcRBg/ApYXubItvEw+GL+jWOz9mESpU0xpBuYHVU+MrMWA
   /ONs7vck98ImEXLaLr0zHoHxf17/G0HUbJQio/2sVpCUaxywU5724k34C
   w==;
X-CSE-ConnectionGUID: MNyUO5LqRHCSYtYvrfToLQ==
X-CSE-MsgGUID: euBJp43WTo68fRvRGQVF6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14190430"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14190430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 23:56:32 -0700
X-CSE-ConnectionGUID: BJvUAshUSWSnpJG58s3ZVQ==
X-CSE-MsgGUID: E1kw/iRmSe+CYeISmJF1iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31501620"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 May 2024 23:56:31 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2QMm-000ATm-2F;
	Thu, 02 May 2024 06:56:28 +0000
Date: Thu, 02 May 2024 14:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 02b670c1f88e78f42a6c5aee155c7b26960ca054
Message-ID: <202405021451.2S4SHBWM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 02b670c1f88e78f42a6c5aee155c7b26960ca054  x86/mm: Remove broken vsyscall emulation code from the page fault code

elapsed time: 1391m

configs tested: 51
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
powerpc                    klondike_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

