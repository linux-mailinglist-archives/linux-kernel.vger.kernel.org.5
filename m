Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398D1783DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjHVKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjHVKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:11:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C5CCE4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692699075; x=1724235075;
  h=date:from:to:cc:subject:message-id;
  bh=qtzaLJ+fJCOn5dmd5Q9STeMJ5SRXeN5iAd+7rBf8iwI=;
  b=hH1znlrSVkNH0rl0Y51SmtXhzV/rJGg3duEqUqjtt1kg8x/6ERrTp3Be
   Q2N5q5Tjg2Tr5u8tu2REFW48Z1xI7yExp8IOJz+e1qgQoE/LSnqN1i2eR
   SOAliVdi1gp7wVKvMB7qvj+o/o5tev2wPeuXfKkydSFYWkamlCo8hpfEV
   N1OmHrCQCijTOG8NbWlTdSLtysnzcC204Q9TUhEemy79vU9+TVKzZWGVM
   v/4hDdjz4quZqtJ+e7tom2HbL/6Hz1o9PlEm2tBeCPtB08Yh4KoqtUtl3
   cF2iPIt5oiXqjQ6BhBDmfEaRjuggvqIP2cMqfqqoAcW6zuqRUVVT+EBcZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="364000733"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="364000733"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 03:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859859317"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="859859317"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 03:10:08 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYOKu-00006F-0A;
        Tue, 22 Aug 2023 10:10:08 +0000
Date:   Tue, 22 Aug 2023 18:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66
Message-ID: <202308221813.v5qurMqh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66  x86/srso: Correct the mitigation status when SMT is disabled

elapsed time: 1915m

configs tested: 167
configs skipped: 164

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230822   gcc  
arc                  randconfig-r011-20230822   gcc  
arm                   randconfig-001-20230821   clang
arm                   randconfig-001-20230822   gcc  
arm                  randconfig-r006-20230822   clang
arm                  randconfig-r014-20230822   gcc  
arm                  randconfig-r022-20230821   clang
arm                  randconfig-r026-20230821   clang
arm64                randconfig-r032-20230822   gcc  
arm64                randconfig-r033-20230822   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230822   gcc  
csky                 randconfig-r016-20230822   gcc  
csky                 randconfig-r026-20230822   gcc  
hexagon               randconfig-001-20230821   clang
hexagon               randconfig-001-20230822   clang
hexagon               randconfig-002-20230821   clang
hexagon               randconfig-002-20230822   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20230821   clang
i386         buildonly-randconfig-001-20230822   gcc  
i386         buildonly-randconfig-002-20230821   clang
i386         buildonly-randconfig-002-20230822   gcc  
i386         buildonly-randconfig-003-20230821   clang
i386         buildonly-randconfig-003-20230822   gcc  
i386         buildonly-randconfig-004-20230821   clang
i386         buildonly-randconfig-004-20230822   gcc  
i386         buildonly-randconfig-005-20230821   clang
i386         buildonly-randconfig-005-20230822   gcc  
i386         buildonly-randconfig-006-20230821   clang
i386         buildonly-randconfig-006-20230822   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230821   clang
i386                  randconfig-001-20230822   gcc  
i386                  randconfig-002-20230821   clang
i386                  randconfig-002-20230822   gcc  
i386                  randconfig-003-20230821   clang
i386                  randconfig-003-20230822   gcc  
i386                  randconfig-004-20230821   clang
i386                  randconfig-004-20230822   gcc  
i386                  randconfig-005-20230821   clang
i386                  randconfig-005-20230822   gcc  
i386                  randconfig-006-20230821   clang
i386                  randconfig-006-20230822   gcc  
i386                  randconfig-011-20230821   gcc  
i386                  randconfig-011-20230822   clang
i386                  randconfig-012-20230821   gcc  
i386                  randconfig-012-20230822   clang
i386                  randconfig-013-20230821   gcc  
i386                  randconfig-013-20230822   clang
i386                  randconfig-014-20230821   gcc  
i386                  randconfig-014-20230822   clang
i386                  randconfig-015-20230821   gcc  
i386                  randconfig-015-20230822   clang
i386                  randconfig-016-20230821   gcc  
i386                  randconfig-016-20230822   clang
i386                 randconfig-r004-20230822   gcc  
loongarch             randconfig-001-20230821   gcc  
loongarch             randconfig-001-20230822   gcc  
loongarch            randconfig-r013-20230822   gcc  
loongarch            randconfig-r015-20230821   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230822   gcc  
m68k                 randconfig-r014-20230822   gcc  
m68k                 randconfig-r034-20230822   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r011-20230821   gcc  
microblaze           randconfig-r021-20230822   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230822   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230821   gcc  
nios2                randconfig-r016-20230821   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r005-20230822   gcc  
openrisc             randconfig-r015-20230822   gcc  
openrisc             randconfig-r036-20230822   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230821   gcc  
parisc               randconfig-r015-20230822   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r003-20230822   gcc  
powerpc              randconfig-r031-20230822   gcc  
powerpc64            randconfig-r002-20230822   gcc  
powerpc64            randconfig-r031-20230822   gcc  
powerpc64            randconfig-r035-20230822   gcc  
powerpc64            randconfig-r036-20230822   gcc  
riscv                 randconfig-001-20230821   clang
riscv                 randconfig-001-20230822   gcc  
riscv                randconfig-r002-20230822   gcc  
riscv                randconfig-r012-20230821   gcc  
s390                  randconfig-001-20230822   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r001-20230822   gcc  
sh                   randconfig-r013-20230822   gcc  
sh                   randconfig-r034-20230822   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230822   gcc  
sparc                randconfig-r022-20230822   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20230822   gcc  
x86_64       buildonly-randconfig-002-20230822   gcc  
x86_64       buildonly-randconfig-003-20230822   gcc  
x86_64       buildonly-randconfig-004-20230822   gcc  
x86_64       buildonly-randconfig-005-20230822   gcc  
x86_64       buildonly-randconfig-006-20230822   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230822   clang
x86_64                randconfig-002-20230822   clang
x86_64                randconfig-003-20230822   clang
x86_64                randconfig-004-20230822   clang
x86_64                randconfig-005-20230822   clang
x86_64                randconfig-006-20230822   clang
x86_64                randconfig-011-20230821   clang
x86_64                randconfig-012-20230821   clang
x86_64                randconfig-013-20230821   clang
x86_64                randconfig-014-20230821   clang
x86_64                randconfig-015-20230821   clang
x86_64                randconfig-016-20230821   clang
x86_64                randconfig-071-20230821   clang
x86_64                randconfig-071-20230822   gcc  
x86_64                randconfig-072-20230821   clang
x86_64                randconfig-072-20230822   gcc  
x86_64                randconfig-073-20230821   clang
x86_64                randconfig-073-20230822   gcc  
x86_64                randconfig-074-20230821   clang
x86_64                randconfig-074-20230822   gcc  
x86_64                randconfig-075-20230821   clang
x86_64                randconfig-075-20230822   gcc  
x86_64                randconfig-076-20230821   clang
x86_64                randconfig-076-20230822   gcc  
x86_64               randconfig-r035-20230822   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r003-20230822   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
