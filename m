Return-Path: <linux-kernel+bounces-144798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A28A4AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E7B271F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962553BBCE;
	Mon, 15 Apr 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDv0UKGN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6737707
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171048; cv=none; b=l2rok4A1wW3vszbbohyQbtUc+40X7rR/Kc24NllArrEYMvQ26CJZMyth/X+z3Kh1mB3fREfkCi6WVUgKzNY9ZZGSB0tfU/DFTfevwN6Fe2QL13bbYG7FHbwlqk+84P+S5rowUvReCY1c0W+51PjgEWFeolwAQbMlwE8j9S6ZjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171048; c=relaxed/simple;
	bh=CdxoAsHbC1vDgX2zkS57us0JtHlpJ9oAdT+Fn4y4ru8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S1xai3XcePzviLOIHJIbQUWRput6/+b0fh7FwGwaHO+nJbRCz9lCEOI1v3A3hGFBDAJZ8swOPDjxRnJzf9BC+ysC497BJ8xLPcesJ3shMMOT22hMU2mL22hOxgnhLXVuuBxHf+N9c+E+DykKurPeLEjrSgX0P/5lJFJGzwUWY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDv0UKGN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171047; x=1744707047;
  h=date:from:to:cc:subject:message-id;
  bh=CdxoAsHbC1vDgX2zkS57us0JtHlpJ9oAdT+Fn4y4ru8=;
  b=oDv0UKGNZYxPSPCDLtFDVQmudaY8GmRSm2Mic5zSb8WMnsd27J94wSt3
   Y0Wd3Kiivk7kLKb8D94oSzfShfWyI7bs9qc+lsae/ne223TYgrSjg/4L0
   r07QOYTZa2O3mWfriUdCZLfbOfPIuhdlnAtK/f/FexYkIxQPu7sP6QjVk
   1Q8LxIfmVPst4O/Q/gqHirE/RXo8Z1XghAcmfkhHtDRS8Kd8EP6xD2rqY
   2mPQQeMqB5pKBC8zdNVDWI5LLsjSZ07/qN0syokrzZJsFGRFnj0syJftU
   kw5uOsRNfN2C7DlDHiJT4UqG1322yj4DK9GOlgtpdq08yirBIyx+7bBsc
   Q==;
X-CSE-ConnectionGUID: TZEUyDosTQOw5Tm0gFdLsA==
X-CSE-MsgGUID: boBV4hEYTVafhxErPAXCrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8658989"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8658989"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:50:47 -0700
X-CSE-ConnectionGUID: AVTCRQxPQzuEPh2K1rvNpQ==
X-CSE-MsgGUID: IZW9bEAMSJuSj5BnMIrdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26405848"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2024 01:50:45 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwI30-00044w-2s;
	Mon, 15 Apr 2024 08:50:42 +0000
Date: Mon, 15 Apr 2024 16:49:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 5bc8b0f5dac04cd4ebe47f8090a5942f2f2647ef
Message-ID: <202404151654.WbvHDDwR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 5bc8b0f5dac04cd4ebe47f8090a5942f2f2647ef  x86/pat: Fix W^X violation false-positives when running as Xen PV guest

elapsed time: 724m

configs tested: 67
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm                          ixp4xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240415   clang
i386         buildonly-randconfig-002-20240415   gcc  
i386         buildonly-randconfig-003-20240415   gcc  
i386         buildonly-randconfig-004-20240415   gcc  
i386         buildonly-randconfig-005-20240415   gcc  
i386         buildonly-randconfig-006-20240415   clang
i386                                defconfig   clang
i386                  randconfig-001-20240415   gcc  
i386                  randconfig-002-20240415   clang
i386                  randconfig-003-20240415   gcc  
i386                  randconfig-004-20240415   gcc  
i386                  randconfig-005-20240415   gcc  
i386                  randconfig-006-20240415   clang
i386                  randconfig-011-20240415   gcc  
i386                  randconfig-012-20240415   clang
i386                  randconfig-013-20240415   gcc  
i386                  randconfig-014-20240415   gcc  
i386                  randconfig-015-20240415   gcc  
i386                  randconfig-016-20240415   gcc  
loongarch                        allyesconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
openrisc                         allmodconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240415   clang
x86_64       buildonly-randconfig-002-20240415   clang
x86_64       buildonly-randconfig-003-20240415   clang
x86_64       buildonly-randconfig-004-20240415   clang
x86_64       buildonly-randconfig-005-20240415   gcc  
x86_64       buildonly-randconfig-006-20240415   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240415   gcc  
x86_64                randconfig-002-20240415   gcc  
x86_64                randconfig-003-20240415   clang
x86_64                randconfig-004-20240415   gcc  
x86_64                randconfig-005-20240415   clang
x86_64                randconfig-006-20240415   clang
x86_64                randconfig-011-20240415   clang
x86_64                randconfig-012-20240415   clang
x86_64                randconfig-013-20240415   gcc  
x86_64                randconfig-014-20240415   clang
x86_64                randconfig-015-20240415   clang
x86_64                randconfig-016-20240415   clang
x86_64                randconfig-071-20240415   gcc  
x86_64                randconfig-072-20240415   clang
x86_64                randconfig-073-20240415   clang
x86_64                randconfig-074-20240415   clang
x86_64                randconfig-075-20240415   clang
x86_64                randconfig-076-20240415   clang
x86_64                          rhel-8.3-rust   clang
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

