Return-Path: <linux-kernel+bounces-132072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155A2898F58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C121C228ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A5134CC6;
	Thu,  4 Apr 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xu9CTg3x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997B134439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260992; cv=none; b=CTMxGL+ICeLg5hmr5TP1U1vg/K6PpwAAKhf1I2tzRdQRO8app9ZMCUrGxoLj6F2+MNSPYjgMLndBCZ76PssZIbrspii18jqGeGlgxvYLeECFWeiS8IVaPv97LQVgyYHETGA1q0sQ9YJamT6RuvzafAuo61unfUATGl1NzlNZVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260992; c=relaxed/simple;
	bh=g8jRKGhvQF7FPyutVABV6Rz/IUaHCXGH3+ZYaNJqB68=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tMo8TAHFuSqsI5Bq70BzFC+jhtCHhdYMLZndHkVz1VHtMonP71WAcGhLUNODY9mxMZB1QIm6SDT4DX43n2Cz1HVquBMIBl3Mll8dFlnkW7ZJBSmyCVddlJxvae2ZW2WHXxovqWtYm6UguzKzUVjulvWbJJCo4uAKg8o7LPgba1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xu9CTg3x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712260991; x=1743796991;
  h=date:from:to:cc:subject:message-id;
  bh=g8jRKGhvQF7FPyutVABV6Rz/IUaHCXGH3+ZYaNJqB68=;
  b=Xu9CTg3xVuTEq/SdRSOVVv9oHoPbLWV0L21Cam5vxsFPK1cCXLaGMI41
   kWCngTHqzqHv4ZejvbCLCrkB5M09qSd7roxK17+rU5jIHOSbwiFsMWSND
   nYTd7gxNwJb/9orE+7gU/DQ9ZfyIEIYV7wVuA/wvqRHRwN3hPaCMyUy4t
   g8isE5ARRxo266JPY+EtQBqmoWeZBbe1BVo8HQYQ0J2JemJry34pPaaSh
   ruODZiHai8JePA+u4rDWlzw44JuaCdfOqwqciyfnUrAWmfGzItOQL2bxw
   YQw9azcl18+biEoKnwIPaxFPFqINJoazvVvSKqyQWZARi9xXDDmWH9BAG
   Q==;
X-CSE-ConnectionGUID: 1r4QhGdGSdu3Meoy6Z06IQ==
X-CSE-MsgGUID: aCFx+ScTSTyhYQkGnuOpqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11349294"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="11349294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:03:09 -0700
X-CSE-ConnectionGUID: U806dEpNTniad8whVBODPQ==
X-CSE-MsgGUID: VQUY2jJPTVCxxyUa9cs/iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="56381201"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2024 13:03:08 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsTIf-0001SX-1O;
	Thu, 04 Apr 2024 20:03:05 +0000
Date: Fri, 05 Apr 2024 04:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 af813acf8c06db58c6e21d89d9e45e8cd1512965
Message-ID: <202404050452.DPcaHhLf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: af813acf8c06db58c6e21d89d9e45e8cd1512965  x86/fpu: Update fpu_swap_kvm_fpu() uses in comments as well

elapsed time: 727m

configs tested: 73
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-005-20240404   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
loongarch                        allmodconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-074-20240404   gcc  
x86_64                randconfig-075-20240404   clang
x86_64                randconfig-076-20240404   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

