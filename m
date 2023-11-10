Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654867E854C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKJWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKJWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:03:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924B4229
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699653822; x=1731189822;
  h=date:from:to:cc:subject:message-id;
  bh=Y4NRAoVhUmOAI9tOq7yL1fKPsGT5TAOq7BNc5slO0OA=;
  b=Xdegt7HIqKQdczK49V1a8ogyy0qiW3MRTm6e8wN677yKaHNAX2gt94Oj
   8O81Wk90StGyrFmqjV/CcDo2hvUkP9rD/30Oa069oezSf/HjmzDA08/B4
   HgbC1dFnR7Jn3riiZMDMZnRh6/i0SMvoPPNlK9ij0cCPcO7nqHc/PgdKy
   fQ25YP3DmauUW8ibXvvCOTw1W0OxOO5VACb7rnfrue6LhWor094bk5IJB
   OF2iLIKM/d2YU9gj+VBXuM6Y/YnJU3JEZvjouuUGJIaKkBzEXJGm+JF3f
   kma2QH6Do1KKt/7owaS4PfE68YAGkXq51z0WAo87B9imF2ul/vOEqiAZu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="390045102"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="390045102"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 14:03:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="834235132"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="834235132"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2023 14:03:41 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ZbH-0009x8-0C;
        Fri, 10 Nov 2023 22:03:39 +0000
Date:   Sat, 11 Nov 2023 06:02:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 68f721e904b253ae9f782db0362f608048225403
Message-ID: <202311110626.K40HKEPI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 68f721e904b253ae9f782db0362f608048225403  rcu: Restrict access to RCU CPU stall notifiers

elapsed time: 1453m

configs tested: 211
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231110   gcc  
arc                   randconfig-002-20231110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20231110   gcc  
arm                   randconfig-002-20231110   gcc  
arm                   randconfig-003-20231110   gcc  
arm                   randconfig-004-20231110   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231110   gcc  
arm64                 randconfig-002-20231110   gcc  
arm64                 randconfig-003-20231110   gcc  
arm64                 randconfig-004-20231110   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231110   gcc  
csky                  randconfig-002-20231110   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231110   gcc  
i386         buildonly-randconfig-002-20231110   gcc  
i386         buildonly-randconfig-003-20231110   gcc  
i386         buildonly-randconfig-004-20231110   gcc  
i386         buildonly-randconfig-005-20231110   gcc  
i386         buildonly-randconfig-006-20231110   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231110   gcc  
i386                  randconfig-001-20231111   gcc  
i386                  randconfig-002-20231110   gcc  
i386                  randconfig-002-20231111   gcc  
i386                  randconfig-003-20231110   gcc  
i386                  randconfig-003-20231111   gcc  
i386                  randconfig-004-20231110   gcc  
i386                  randconfig-004-20231111   gcc  
i386                  randconfig-005-20231110   gcc  
i386                  randconfig-005-20231111   gcc  
i386                  randconfig-006-20231110   gcc  
i386                  randconfig-006-20231111   gcc  
i386                  randconfig-011-20231110   gcc  
i386                  randconfig-012-20231110   gcc  
i386                  randconfig-013-20231110   gcc  
i386                  randconfig-014-20231110   gcc  
i386                  randconfig-015-20231110   gcc  
i386                  randconfig-016-20231110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231110   gcc  
loongarch             randconfig-002-20231110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231110   gcc  
nios2                 randconfig-002-20231110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231110   gcc  
parisc                randconfig-002-20231110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231110   gcc  
powerpc               randconfig-002-20231110   gcc  
powerpc               randconfig-003-20231110   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-001-20231110   gcc  
powerpc64             randconfig-002-20231110   gcc  
powerpc64             randconfig-003-20231110   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231110   gcc  
riscv                 randconfig-002-20231110   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231110   gcc  
s390                  randconfig-002-20231110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231110   gcc  
sh                    randconfig-001-20231111   gcc  
sh                    randconfig-002-20231110   gcc  
sh                    randconfig-002-20231111   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231110   gcc  
sparc                 randconfig-001-20231111   gcc  
sparc                 randconfig-002-20231110   gcc  
sparc                 randconfig-002-20231111   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231110   gcc  
sparc64               randconfig-001-20231111   gcc  
sparc64               randconfig-002-20231110   gcc  
sparc64               randconfig-002-20231111   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231110   gcc  
um                    randconfig-001-20231111   gcc  
um                    randconfig-002-20231110   gcc  
um                    randconfig-002-20231111   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231110   gcc  
x86_64       buildonly-randconfig-002-20231110   gcc  
x86_64       buildonly-randconfig-003-20231110   gcc  
x86_64       buildonly-randconfig-004-20231110   gcc  
x86_64       buildonly-randconfig-005-20231110   gcc  
x86_64       buildonly-randconfig-006-20231110   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231110   gcc  
x86_64                randconfig-002-20231110   gcc  
x86_64                randconfig-003-20231110   gcc  
x86_64                randconfig-004-20231110   gcc  
x86_64                randconfig-005-20231110   gcc  
x86_64                randconfig-006-20231110   gcc  
x86_64                randconfig-011-20231110   gcc  
x86_64                randconfig-012-20231110   gcc  
x86_64                randconfig-013-20231110   gcc  
x86_64                randconfig-014-20231110   gcc  
x86_64                randconfig-015-20231110   gcc  
x86_64                randconfig-016-20231110   gcc  
x86_64                randconfig-071-20231110   gcc  
x86_64                randconfig-072-20231110   gcc  
x86_64                randconfig-073-20231110   gcc  
x86_64                randconfig-074-20231110   gcc  
x86_64                randconfig-075-20231110   gcc  
x86_64                randconfig-076-20231110   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                randconfig-001-20231110   gcc  
xtensa                randconfig-001-20231111   gcc  
xtensa                randconfig-002-20231110   gcc  
xtensa                randconfig-002-20231111   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
