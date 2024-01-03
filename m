Return-Path: <linux-kernel+bounces-16104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D9823905
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE72928697C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3561EB46;
	Wed,  3 Jan 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2yAIjMr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27161EB20
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704323464; x=1735859464;
  h=date:from:to:cc:subject:message-id;
  bh=cKAymo3olLy2ejprgUkI4cbb///sJeM2jb7WvEbJQW4=;
  b=G2yAIjMrzH36gctRviJl1KBhcbItloeeBJVcNS19uf5uCP05pJdPUHXo
   m9+bWtGNPXyMWzjnOQpjNAv3C/qgnKtQ/+nL+8rDo4iwGpwTvnTnN9Fw6
   giSmVSVRjtdHvBfOqIwLCnJgS7bqnofXr1Zl+TkTxrm1yfSgZh6pHb0cH
   7D2v1QCxbcjxprlhjjVbf+H/G9UzR2aACSFSL9o1QtmnnweJis2ot6sH+
   PXgSM84msqZ2xNQSJQ/hN3ulZPI7qGPB5IKrE2d0yJpsoj+Jx8iX6y6IN
   njbCBo616pVCoz9q0fZ7y7/lgxVAVY8mbzKX5z1q2Pc7pY1ZSDR5hLiat
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4159956"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="4159956"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 15:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="21931373"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Jan 2024 15:11:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLAO3-000MfS-2P;
	Wed, 03 Jan 2024 23:10:59 +0000
Date: Thu, 04 Jan 2024 07:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 54aa699e8094efb7d7675fefbc03dfce24f98456
Message-ID: <202401040721.Q0YnMUV7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 54aa699e8094efb7d7675fefbc03dfce24f98456  arch/x86: Fix typos

elapsed time: 727m

configs tested: 50
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240103   clang
i386         buildonly-randconfig-002-20240103   clang
i386         buildonly-randconfig-003-20240103   clang
i386         buildonly-randconfig-004-20240103   clang
i386         buildonly-randconfig-005-20240103   clang
i386         buildonly-randconfig-006-20240103   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240103   clang
i386                  randconfig-002-20240103   clang
i386                  randconfig-003-20240103   clang
i386                  randconfig-004-20240103   clang
i386                  randconfig-005-20240103   clang
i386                  randconfig-006-20240103   clang
i386                  randconfig-011-20240103   gcc  
i386                  randconfig-012-20240103   gcc  
i386                  randconfig-013-20240103   gcc  
i386                  randconfig-014-20240103   gcc  
i386                  randconfig-015-20240103   gcc  
i386                  randconfig-016-20240103   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240104   gcc  
x86_64       buildonly-randconfig-002-20240104   gcc  
x86_64       buildonly-randconfig-003-20240104   gcc  
x86_64       buildonly-randconfig-004-20240104   gcc  
x86_64       buildonly-randconfig-005-20240104   gcc  
x86_64       buildonly-randconfig-006-20240104   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240104   clang
x86_64                randconfig-002-20240104   clang
x86_64                randconfig-003-20240104   clang
x86_64                randconfig-004-20240104   clang
x86_64                randconfig-005-20240104   clang
x86_64                randconfig-006-20240104   clang
x86_64                randconfig-011-20240104   gcc  
x86_64                randconfig-012-20240104   gcc  
x86_64                randconfig-013-20240104   gcc  
x86_64                randconfig-014-20240104   gcc  
x86_64                randconfig-015-20240104   gcc  
x86_64                randconfig-016-20240104   gcc  
x86_64                randconfig-071-20240104   gcc  
x86_64                randconfig-072-20240104   gcc  
x86_64                randconfig-073-20240104   gcc  
x86_64                randconfig-074-20240104   gcc  
x86_64                randconfig-075-20240104   gcc  
x86_64                randconfig-076-20240104   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

