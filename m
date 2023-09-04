Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E047913FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352585AbjIDIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbjIDIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:53:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EC9180
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693817621; x=1725353621;
  h=date:from:to:cc:subject:message-id;
  bh=02QOs7D1qJdNKUxWVY4/rk+nUOYhUqQDs+mqrS7kUqI=;
  b=RUMyAFb82B5rqA81g8SdjvB2HeQ1E8/AmzPqesk6nwLX+wGTYgRqX405
   tA78HdoeAUPscKbE1O2KaDGa98ueUFKqy4NBW+Zz+vnLFkj2o+62+w0yQ
   RZkZugMi0KLNFHpWs17rRfFk9V1N/2818USSgSblQkIB6NbR2WAJvU+Gc
   BNiKQJpLzHSNpKj2iGE+vGBbH3gwv6vXGfp36cnIrH5A8dFMReJZMqAjh
   PSzbx5Tsv5DlKheYRI6cmNuRNIWwk3K2F6aNgVlOTbzmxHFSwDy/NDjw8
   5uiTEDH7SLIRoeJo5vR85F0C4Pi+/LVzETAHncq4DqW5EHYu6p7YTztCf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442949462"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="442949462"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="775779756"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="775779756"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2023 01:53:39 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd5K0-0000Hz-1o;
        Mon, 04 Sep 2023 08:52:54 +0000
Date:   Mon, 04 Sep 2023 16:52:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.24a] BUILD SUCCESS WITH WARNING
 ed763051f63059bdb6d728c0890993eab8833feb
Message-ID: <202309041620.Dj2WZBr4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.24a
branch HEAD: ed763051f63059bdb6d728c0890993eab8833feb  rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309032246.VhgyldbK-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/locking/qspinlock.c:779:23: warning: no previous declaration for '__pv_spinlock_dump' [-Wmissing-declarations]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-003-20230903
    `-- kernel-locking-qspinlock.c:warning:no-previous-declaration-for-__pv_spinlock_dump

elapsed time: 1271m

configs tested: 181
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230903   gcc  
alpha                randconfig-r031-20230903   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20230903   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          gemini_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230903   clang
arm                        spear3xx_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230903   gcc  
hexagon               randconfig-001-20230903   clang
hexagon               randconfig-002-20230903   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230903   clang
i386         buildonly-randconfig-002-20230903   clang
i386         buildonly-randconfig-003-20230903   clang
i386         buildonly-randconfig-004-20230903   clang
i386         buildonly-randconfig-005-20230903   clang
i386         buildonly-randconfig-006-20230903   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230903   clang
i386                  randconfig-002-20230903   clang
i386                  randconfig-003-20230903   clang
i386                  randconfig-004-20230903   clang
i386                  randconfig-005-20230903   clang
i386                  randconfig-006-20230903   clang
i386                  randconfig-011-20230903   gcc  
i386                  randconfig-012-20230903   gcc  
i386                  randconfig-013-20230903   gcc  
i386                  randconfig-014-20230903   gcc  
i386                  randconfig-015-20230903   gcc  
i386                  randconfig-016-20230903   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230903   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230903   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230903   gcc  
microblaze           randconfig-r026-20230903   gcc  
microblaze           randconfig-r036-20230903   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                 randconfig-r012-20230903   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230903   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc              randconfig-r011-20230903   gcc  
powerpc              randconfig-r013-20230903   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230903   clang
riscv                randconfig-r003-20230903   clang
riscv                randconfig-r006-20230903   clang
riscv                randconfig-r016-20230903   gcc  
riscv                randconfig-r025-20230903   gcc  
riscv                randconfig-r035-20230903   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230903   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r005-20230903   gcc  
sh                           se7206_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230903   gcc  
sparc                randconfig-r021-20230903   gcc  
sparc                randconfig-r022-20230903   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r034-20230903   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230903   clang
x86_64       buildonly-randconfig-002-20230903   clang
x86_64       buildonly-randconfig-003-20230903   clang
x86_64       buildonly-randconfig-004-20230903   clang
x86_64       buildonly-randconfig-005-20230903   clang
x86_64       buildonly-randconfig-006-20230903   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230903   gcc  
x86_64                randconfig-002-20230903   gcc  
x86_64                randconfig-003-20230903   gcc  
x86_64                randconfig-004-20230903   gcc  
x86_64                randconfig-005-20230903   gcc  
x86_64                randconfig-006-20230903   gcc  
x86_64                randconfig-011-20230903   clang
x86_64                randconfig-012-20230903   clang
x86_64                randconfig-013-20230903   clang
x86_64                randconfig-014-20230903   clang
x86_64                randconfig-015-20230903   clang
x86_64                randconfig-016-20230903   clang
x86_64                randconfig-071-20230903   clang
x86_64                randconfig-072-20230903   clang
x86_64                randconfig-073-20230903   clang
x86_64                randconfig-074-20230903   clang
x86_64                randconfig-075-20230903   clang
x86_64                randconfig-076-20230903   clang
x86_64               randconfig-r032-20230903   clang
x86_64               randconfig-r033-20230903   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r004-20230903   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
