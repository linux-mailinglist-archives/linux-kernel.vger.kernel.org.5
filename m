Return-Path: <linux-kernel+bounces-130550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E28979CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5028A1C229C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8198155A47;
	Wed,  3 Apr 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts51uBLl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5023D962
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176455; cv=none; b=CfYC3W40f/ZglvUcBcHiRDASE5Aq2mX3RWNif5ALfwQ2h7J8nNjvakNnWnU2urh0IRpGjQAsl8IgcQ95zWdbcURXcYNt+8U18V37sFouD3H0tUQmY6su0eiDSV5CdTfVsPIH64JsfRoHfTpsZoZm7FicV2snNPE5bP8w2dvc68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176455; c=relaxed/simple;
	bh=iNJJnjzgzQWBTnvnE6WJBX2a6ctIu15cGqI86ZcU0zA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l5F33S59TvDJO88q+d45EffB1ofUIginj/RGTjin5cvgu/dBbCuAdngWertfFAUZTxUjwpVsv+7oQP+0mbSnPf1jJGp6ra5hWhp4eixdGK0UNPdzbyYj0Nm4+SNOvLohhE4GDW+M3xdFdidzavmfLthjqKkaIrxspKFHY/dysFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts51uBLl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712176454; x=1743712454;
  h=date:from:to:cc:subject:message-id;
  bh=iNJJnjzgzQWBTnvnE6WJBX2a6ctIu15cGqI86ZcU0zA=;
  b=Ts51uBLlbeEZJgipjS6e7tOgnH/A7FE3cV/oMjsMde4UcQd3JNCT43Nn
   uSJ21saLa2UdJKZCfRaf80HFUoiA09UmZzbVYO8z3duFewxz7UvQtrwoI
   eQyjTfnYo2XCKB6C1i2Ovwvwy6koMw+quvEOLe4uCSegCZ9hNKbMrGMdm
   UgZdlY9Ao3WL5/kkhrKyclKHWmCOL+0iN8BrZQfxTxNW8iZxX209qSQRE
   2GXts6wNaGY9IvJEDDvziPDm2rmOOVgpkiWW6TlOrV1dfH47M73b4asDr
   pb51MSsZcfd9vUbbS99Hm/F5EnxqEaZT4jStDHxlVggHKkNd+P3rud12N
   w==;
X-CSE-ConnectionGUID: Rx84l5GLRJKgPyPRQuHLLw==
X-CSE-MsgGUID: mVaeQveHSHiKMhangEAz/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11212016"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="11212016"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:34:13 -0700
X-CSE-ConnectionGUID: /USgTaOOSo+8owL2ClnGEQ==
X-CSE-MsgGUID: vOtZKSu+Tj+TvvWCtMxivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23204644"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Apr 2024 13:34:12 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs7JB-0000D6-2n;
	Wed, 03 Apr 2024 20:34:09 +0000
Date: Thu, 04 Apr 2024 04:33:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 312be9fc2234c8acfb8148a9f4c358b70d358dee
Message-ID: <202404040425.t4jGSafU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 312be9fc2234c8acfb8148a9f4c358b70d358dee  perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS event

elapsed time: 731m

configs tested: 59
configs skipped: 134

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
i386                  randconfig-012-20240403   clang
i386                  randconfig-013-20240403   gcc  
i386                  randconfig-014-20240403   clang
i386                  randconfig-015-20240403   gcc  
i386                  randconfig-016-20240403   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240403   gcc  
x86_64       buildonly-randconfig-002-20240403   gcc  
x86_64       buildonly-randconfig-003-20240403   clang
x86_64       buildonly-randconfig-004-20240403   gcc  
x86_64       buildonly-randconfig-005-20240403   clang
x86_64       buildonly-randconfig-006-20240403   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240403   gcc  
x86_64                randconfig-002-20240403   clang
x86_64                randconfig-003-20240403   gcc  
x86_64                randconfig-004-20240403   gcc  
x86_64                randconfig-005-20240403   gcc  
x86_64                randconfig-006-20240403   clang
x86_64                randconfig-011-20240403   gcc  
x86_64                randconfig-012-20240403   gcc  
x86_64                randconfig-013-20240403   gcc  
x86_64                randconfig-014-20240403   gcc  
x86_64                randconfig-015-20240403   gcc  
x86_64                randconfig-016-20240403   gcc  
x86_64                randconfig-071-20240403   clang
x86_64                randconfig-072-20240403   gcc  
x86_64                randconfig-073-20240403   clang
x86_64                randconfig-074-20240403   gcc  
x86_64                randconfig-075-20240403   gcc  
x86_64                randconfig-076-20240403   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

