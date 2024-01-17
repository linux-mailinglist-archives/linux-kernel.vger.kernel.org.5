Return-Path: <linux-kernel+bounces-28964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF9830543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC321F25A69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AC2033A;
	Wed, 17 Jan 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvFHYQ0H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568C20333
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494484; cv=none; b=rLXIUY43Q5XrTeIcTxp/CeJkX3Yzci8g6fH+Bj2wHb/FOD98HCDehOOtieWKHuWHSU/V8HdXMZGokNXIsuAY3k91a/M+6PTsktHsaGk/bEMOGaJa4Y3Dsleo8+kLaw+qOF43G4eqhUJbCJI66nzc8bmqztC0blcFCuMsU1lX5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494484; c=relaxed/simple;
	bh=58ubEWxaUrnQzehGwjgr7UIWMMzjTv6Z9AZIa4a/+Q8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent; b=UWYOLWeC2Np69cYp+RTzB6itawboS6m2hu7BX/SufwToS6Ujy0iAkxw8P9tX+20wo0drwIsnJqJj98WEEP1VvsadVFvDodiYpCmrwxmIaG2pjtgiAC8UvCA8OyRZbDpo7jALPZxunMSa9vG5rTZTwnzpnvGAzkTYGyUqTCVuQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvFHYQ0H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705494483; x=1737030483;
  h=date:from:to:cc:subject:message-id;
  bh=58ubEWxaUrnQzehGwjgr7UIWMMzjTv6Z9AZIa4a/+Q8=;
  b=mvFHYQ0HfRxwFxexhpLVfU7s0SRIkTiMWZwCzXbTXnL3VLH9OwEgp/5B
   Xj+ffwYN7GXZpQMpq2MjLejFglrU6dEMqedGj50mXd4qqISHAnjkJSGUG
   lrke2kUHo2QRxrYutxWdRHEjZg/Deu/My0NQX0RQsu4wkn0H1pOsM43NK
   sgT/QLcqZOICaC2aOeCe0lqhB8c0fC1ZpOMlp/iVAJAW1yYlKcdUMmIdq
   ly1l9maMdbkCi33bgEhIpg7vwiRjirUa8tpp8hub1QY1I7xVadiLxkHqv
   mzSb9PSqRo/eJPFvIilDDPLqHnwKIwIpAq5bv4krCsXQrR5QR2CeQxh8N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13509895"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13509895"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 04:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="760558583"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="760558583"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2024 04:28:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ51T-0001z0-0z;
	Wed, 17 Jan 2024 12:27:59 +0000
Date: Wed, 17 Jan 2024 20:27:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27
Message-ID: <202401172021.SpTIXyJr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27  sched/fair: Fix frequency selection for non-invariant case

elapsed time: 1560m

configs tested: 79
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240116   clang
i386         buildonly-randconfig-002-20240116   clang
i386         buildonly-randconfig-003-20240116   clang
i386         buildonly-randconfig-004-20240116   clang
i386         buildonly-randconfig-005-20240116   clang
i386         buildonly-randconfig-006-20240116   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240116   clang
i386                  randconfig-002-20240116   clang
i386                  randconfig-003-20240116   clang
i386                  randconfig-004-20240116   clang
i386                  randconfig-005-20240116   clang
i386                  randconfig-006-20240116   clang
i386                  randconfig-011-20240116   gcc  
i386                  randconfig-012-20240116   gcc  
i386                  randconfig-013-20240116   gcc  
i386                  randconfig-014-20240116   gcc  
i386                  randconfig-015-20240116   gcc  
i386                  randconfig-016-20240116   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
powerpc                          allmodconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
um                               allmodconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240117   gcc  
x86_64       buildonly-randconfig-002-20240117   gcc  
x86_64       buildonly-randconfig-003-20240117   gcc  
x86_64       buildonly-randconfig-004-20240117   gcc  
x86_64       buildonly-randconfig-005-20240117   gcc  
x86_64       buildonly-randconfig-006-20240117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240117   clang
x86_64                randconfig-002-20240117   clang
x86_64                randconfig-003-20240117   clang
x86_64                randconfig-004-20240117   clang
x86_64                randconfig-005-20240117   clang
x86_64                randconfig-006-20240117   clang
x86_64                randconfig-011-20240117   gcc  
x86_64                randconfig-012-20240117   gcc  
x86_64                randconfig-013-20240117   gcc  
x86_64                randconfig-014-20240117   gcc  
x86_64                randconfig-015-20240117   gcc  
x86_64                randconfig-016-20240117   gcc  
x86_64                randconfig-071-20240117   gcc  
x86_64                randconfig-072-20240117   gcc  
x86_64                randconfig-073-20240117   gcc  
x86_64                randconfig-074-20240117   gcc  
x86_64                randconfig-075-20240117   gcc  
x86_64                randconfig-076-20240117   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

