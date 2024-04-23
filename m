Return-Path: <linux-kernel+bounces-154506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46648ADCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441A2B22B72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2701CFA8;
	Tue, 23 Apr 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lckVytn3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82E4C8F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847089; cv=none; b=AjBJWsvl2F25n2aKLoDMzy3B9PDvySUxGDp1WEyn8yPOKFOxywhbiPNMvjhwYG+a9n8dbWl7z98mpZtDuh8WYBTbv+HDApOzvjHoU9odVMXnsovE3pzSXpVHBqhTjVnrw40r9XGZG6Bc7A8q3j+qXHxvt+dCx23+Ewv6JGJleAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847089; c=relaxed/simple;
	bh=fWt3wsHQW3gWE2MC7b6fz/q/+IhfFJ791AztMksthYA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WX8j12HSpzxbRvFjiftqG+HU1sHczFVcB5DQXz4q8K/ylrtOC1yl+sKThXnR0mwazwGEmPUzN8QfbMY2F+EQ4KMlqrdCVL2vQCrJoTrtY517C+D48r9ogayTHFk0KWZpgYzptIM0FrGLS/j4t9ZIshYQN+IhWd79kcD36vMJ6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lckVytn3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713847087; x=1745383087;
  h=date:from:to:cc:subject:message-id;
  bh=fWt3wsHQW3gWE2MC7b6fz/q/+IhfFJ791AztMksthYA=;
  b=lckVytn3liNLTatq47BX82YqZW+LghbrMxyweCIrU8MFvHjhtrzhot8K
   eA6vrlyMOvj1lGvfsyXM1jkrghcxbCdDZNx+tIgwV+GvRANO8f9Mz8czF
   xti6iJdep8CCLZkinrxaZCZc5Av/JVorVzcH9APCFh2FPFwV4yegaUBYk
   +Dl50tIuZT+UeOzB7PchrpHGp7QFKngCpTvyuxnY22VFvtNdb0VsX1Yi0
   S4Rkb5THfPCM6+1quvSDDlew2EFi1pcBPfsvdvEOf7yrvv09cIe7eQruD
   5aOPsVzPBtHAuqEpDJ9kDK9WzFqC/HeAvHMZ8DjkmD7KEvfJZmClh0FYa
   w==;
X-CSE-ConnectionGUID: 0bpCaucYTZiaaRAlkaoFiQ==
X-CSE-MsgGUID: PnZlyIsyRyOeH0fJAoFrUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9331618"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9331618"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 21:38:06 -0700
X-CSE-ConnectionGUID: G86mMchoTR6S76CdNu79aw==
X-CSE-MsgGUID: js055VbkT0OfCPVZ6cj2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24299182"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Apr 2024 21:38:07 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz7us-0000To-0O;
	Tue, 23 Apr 2024 04:38:02 +0000
Date: Tue, 23 Apr 2024 12:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 f055b6260eb3ef20a6e310d1e555a5d5a0a28ca0
Message-ID: <202404231232.iASVLRRr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: f055b6260eb3ef20a6e310d1e555a5d5a0a28ca0  x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h

elapsed time: 1098m

configs tested: 51
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm64                            allyesconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240422   clang
i386         buildonly-randconfig-002-20240422   gcc  
i386         buildonly-randconfig-003-20240422   clang
i386         buildonly-randconfig-004-20240422   gcc  
i386         buildonly-randconfig-005-20240422   gcc  
i386         buildonly-randconfig-006-20240422   clang
i386                                defconfig   clang
i386                  randconfig-001-20240422   clang
i386                  randconfig-002-20240422   clang
i386                  randconfig-003-20240422   gcc  
i386                  randconfig-004-20240422   clang
i386                  randconfig-005-20240422   gcc  
i386                  randconfig-006-20240422   gcc  
i386                  randconfig-011-20240422   clang
i386                  randconfig-012-20240422   clang
i386                  randconfig-013-20240422   clang
i386                  randconfig-014-20240422   clang
i386                  randconfig-015-20240422   clang
i386                  randconfig-016-20240422   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240423   clang
x86_64       buildonly-randconfig-002-20240423   clang
x86_64       buildonly-randconfig-003-20240423   gcc  
x86_64       buildonly-randconfig-004-20240423   gcc  
x86_64       buildonly-randconfig-005-20240423   clang
x86_64       buildonly-randconfig-006-20240423   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240423   clang
x86_64                randconfig-002-20240423   gcc  
x86_64                randconfig-003-20240423   gcc  
x86_64                randconfig-004-20240423   gcc  
x86_64                randconfig-005-20240423   gcc  
x86_64                randconfig-006-20240423   gcc  
x86_64                randconfig-011-20240423   gcc  
x86_64                randconfig-012-20240423   gcc  
x86_64                randconfig-013-20240423   clang
x86_64                randconfig-014-20240423   clang
x86_64                randconfig-015-20240423   clang
x86_64                randconfig-016-20240423   gcc  
x86_64                randconfig-071-20240423   clang
x86_64                randconfig-072-20240423   clang
x86_64                randconfig-073-20240423   clang
x86_64                randconfig-074-20240423   gcc  
x86_64                randconfig-075-20240423   gcc  
x86_64                randconfig-076-20240423   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

