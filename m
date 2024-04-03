Return-Path: <linux-kernel+bounces-128928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032E8961F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9D728A493
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790212E4E;
	Wed,  3 Apr 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhOOoMGg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7410957
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107521; cv=none; b=HlK9wuEYgIoU46+DfcMB0G2CwW9ttJzlv/Zkb/Eyf7C/fxmkF0+Oh3hWjv43AotuBmbctJAOo0nTS3RpehThveiU9gCGj2I4ObRjfQWE60a8f08Pw1W/OB55dtJ7NB8N6BlU7eg9TxdJ4ykVh9i+stf41jps7jIdaIXtZWRw6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107521; c=relaxed/simple;
	bh=Gtah+pV2Mac52Y9zmNvXXmaxj1kiK/XyQarpg/FqbA4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rTjT8wMcttS/GFDIx7Wt/Qz2T/ZNNclsEcK6j8rKrLoCrYB2sfCFNJEJtlffurO8JbnzAX8gi2qr2qDr6D7Oy9y/VHg9ibxin21311O04uMsv5+q4Rxdbd5bsZ0+LRI4KlYpGedOkh3ydCtDqLJmojSY+/o5z4hVUDI78acoMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhOOoMGg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712107520; x=1743643520;
  h=date:from:to:cc:subject:message-id;
  bh=Gtah+pV2Mac52Y9zmNvXXmaxj1kiK/XyQarpg/FqbA4=;
  b=DhOOoMGgW4bZNqnxFIBvXKFjIXctBcw5b4mbJQH2NBFUge7eYoe673yP
   yrUEjUzI0j1owkyz9Swcx5kIIuPj9AcS5f/ju6wKGrUn/v+A/4iG5nK4K
   KbrReUSPNHOYAh+Srlz6IM10PVWtsIgDF/+8l/XD8pFtMTE8QayHpf0Ry
   lArIBOXZeGblo8jMBwU+rqDMOjCR8QvxiZGFRvKokwv7TUc2zpprGPQ6w
   vfkts7VfMMyfkiaYOH+zwhAPfShpzlstMmxMmUgfaEd+NYiFDSh6mCv7M
   WhYTAzo4IPKnTnsTxaEdl0LgAwFjGNfjBw3lA66/JRW0gyYjyLwoocH4r
   Q==;
X-CSE-ConnectionGUID: lrh2M1p8TeCwdFBMniXnHw==
X-CSE-MsgGUID: cLf/6IzcSTWSFfjR/wE5mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7213774"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7213774"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:25:19 -0700
X-CSE-ConnectionGUID: 5rmNtuVVSia8HgbF/sJbqw==
X-CSE-MsgGUID: Z4LzGZZKRsOcN8VRKbxJ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18235739"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Apr 2024 18:25:19 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrpNM-0001jF-18;
	Wed, 03 Apr 2024 01:25:16 +0000
Date: Wed, 03 Apr 2024 09:24:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 52b2c101b9ce3b954ebbed4c24396ec28f66fcd9
Message-ID: <202404030946.EbCrlRBE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 52b2c101b9ce3b954ebbed4c24396ec28f66fcd9  x86/32: Remove unused IA32_STACK_TOP and two externs

elapsed time: 724m

configs tested: 27
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240403   gcc  
i386         buildonly-randconfig-002-20240403   clang
i386         buildonly-randconfig-003-20240403   clang
i386         buildonly-randconfig-004-20240403   clang
i386         buildonly-randconfig-005-20240403   gcc  
i386         buildonly-randconfig-006-20240403   clang
i386                                defconfig   clang
i386                  randconfig-001-20240403   gcc  
i386                  randconfig-002-20240403   clang
i386                  randconfig-003-20240403   gcc  
i386                  randconfig-004-20240403   gcc  
i386                  randconfig-005-20240403   clang
i386                  randconfig-006-20240403   gcc  
i386                  randconfig-011-20240403   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
um                               allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

