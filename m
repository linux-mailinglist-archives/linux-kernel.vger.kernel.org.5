Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2345789B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 05:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjH0DfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 23:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjH0Der (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 23:34:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9A123
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693107284; x=1724643284;
  h=date:from:to:cc:subject:message-id;
  bh=jbA3aXgzKOYgfsLAwUQLKYWLY6YpSXa9ZETpJyEJk7I=;
  b=VFa7G0/rtAwSVH38H0Zc+p7koVl/gMAErdLEZ8Pt13EbbXS84DLrWKkU
   ZU6jdYcyDN7vcfWKrpABx6trpfhlb8eSrzx8f0t9i4I4Z3b2FIB2MsTXS
   +9rWqjauvytNNA/hp6enALX2CALBrjkgydsqVtFFZj+3IM+Na/TTZGqun
   f1Xx6KDlgOOcOrITNGTEfWCkK6ffK6IN5zYuAK+BQTVImxLWhE7/am+8/
   hxz9ty31Kop+GOMWF5Hg8BMXIq1XGsAasVY4xgd441Yz8HL+ujphXbKVh
   b49AWFkXt3DkVfi18p8o9dw3RIt91ty3gBDaIsKeSBXKlOYZ+fOJlBoCx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="378696711"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="378696711"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 20:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="731429829"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="731429829"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2023 20:34:42 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa6Xx-0005L1-33;
        Sun, 27 Aug 2023 03:34:41 +0000
Date:   Sun, 27 Aug 2023 11:33:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a] BUILD REGRESSION
 354957ec11dc80eac68c4b1e10c237d69adc1833
Message-ID: <202308271110.PIIQ4wZk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
branch HEAD: 354957ec11dc80eac68c4b1e10c237d69adc1833  locktorture: Dump CPUs running writer tasks when RCU stalls

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308250917.NOqF6Mad-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308250940.ak8AUxEz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308250944.F8nVkKh9-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308251055.cPX2KFlo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308251416.XkaIr6BV-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308251435.gwLevKf4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308251616.7HOmYRfg-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "dump_cpu_task" [kernel/locking/locktorture.ko] undefined!
kernel/locking/locktorture.c:279:13: warning: no previous prototype for 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/locktorture.c:279:13: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/locktorture.c:280:13: warning: no previous prototype for 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/locktorture.c:280:13: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/qspinlock.c:660:19: error: redefinition of 'tail_to_cpu'
kernel/locking/qspinlock.c:665:19: error: redefinition of 'tail_to_idx'
kernel/locking/qspinlock.c:670:29: error: redefinition of 'next_to_prev'
kernel/locking/qspinlock.c:691:29: error: redefinition of 'next_to_cpu_idx'
kernel/locking/qspinlock.c:691:6: error: redefinition of 'spinlock_dump'
kernel/locking/qspinlock.c:691:6: warning: no previous prototype for 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/qspinlock.c:691:6: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/qspinlock.c:709:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
kernel/locking/qspinlock.c:712:6: error: redefinition of 'spinlock_dump'
kernel/locking/qspinlock.c:712:6: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
kernel/locking/qspinlock.c:730:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- arc-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- arm-randconfig-r031-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- csky-allmodconfig
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- csky-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- i386-randconfig-013-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- i386-randconfig-014-20230825
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- loongarch-allmodconfig
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- loongarch-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- m68k-allmodconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- m68k-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- microblaze-allmodconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- microblaze-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- openrisc-allmodconfig
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- openrisc-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- parisc-allmodconfig
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- parisc-allyesconfig
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- riscv-randconfig-r022-20230825
|   `-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|-- x86_64-defconfig
|   `-- kernel-locking-qspinlock.c:warning:no-previous-prototype-for-spinlock_dump
|-- x86_64-randconfig-001-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- x86_64-randconfig-003-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- x86_64-randconfig-004-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
|-- x86_64-randconfig-005-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
`-- x86_64-randconfig-006-20230825
    `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-spinlock_dump
clang_recent_errors
|-- i386-buildonly-randconfig-001-20230825
|   |-- kernel-locking-qspinlock.c:error:redefinition-of-next_to_cpu_idx
|   |-- kernel-locking-qspinlock.c:error:redefinition-of-next_to_prev
|   |-- kernel-locking-qspinlock.c:error:redefinition-of-spinlock_dump
|   |-- kernel-locking-qspinlock.c:error:redefinition-of-tail_to_cpu
|   |-- kernel-locking-qspinlock.c:error:redefinition-of-tail_to_idx
|   `-- kernel-locking-qspinlock.c:warning:format-specifies-type-unsigned-long-but-the-argument-has-type-unsigned-int
|-- i386-randconfig-001-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- i386-randconfig-002-20230825
|   |-- ERROR:dump_cpu_task-kernel-locking-locktorture.ko-undefined
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- i386-randconfig-003-20230825
|   |-- kernel-locking-qspinlock.c:warning:format-specifies-type-unsigned-long-but-the-argument-has-type-unsigned-int
|   `-- kernel-locking-qspinlock.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- i386-randconfig-004-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- i386-randconfig-005-20230825
|   |-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|   |-- kernel-locking-qspinlock.c:warning:format-specifies-type-unsigned-long-but-the-argument-has-type-unsigned-int
|   `-- kernel-locking-qspinlock.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- i386-randconfig-006-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- mips-randconfig-r023-20230825
|   |-- kernel-locking-qspinlock.c:warning:format-specifies-type-unsigned-long-but-the-argument-has-type-unsigned-int
|   `-- kernel-locking-qspinlock.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- mips-randconfig-r025-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- riscv-randconfig-r032-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
|-- x86_64-buildonly-randconfig-006-20230825
|   `-- kernel-locking-locktorture.c:warning:no-previous-prototype-for-function-spinlock_dump
`-- x86_64-rhel-8.3-rust
    |-- kernel-locking-qspinlock.c:error:redefinition-of-next_to_cpu_idx
    |-- kernel-locking-qspinlock.c:error:redefinition-of-next_to_prev
    |-- kernel-locking-qspinlock.c:error:redefinition-of-spinlock_dump
    |-- kernel-locking-qspinlock.c:error:redefinition-of-tail_to_cpu
    `-- kernel-locking-qspinlock.c:error:redefinition-of-tail_to_idx

elapsed time: 3214m

configs tested: 140
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230825   gcc  
arc                  randconfig-r011-20230825   gcc  
arc                  randconfig-r034-20230825   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                   randconfig-001-20230825   clang
arm                  randconfig-r003-20230825   gcc  
arm                  randconfig-r031-20230825   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230825   gcc  
hexagon               randconfig-001-20230825   clang
hexagon               randconfig-002-20230825   clang
hexagon              randconfig-r004-20230825   clang
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230825   clang
i386                  randconfig-002-20230825   clang
i386                  randconfig-003-20230825   clang
i386                  randconfig-004-20230825   clang
i386                  randconfig-005-20230825   clang
i386                  randconfig-006-20230825   clang
i386                  randconfig-013-20230825   gcc  
i386                  randconfig-014-20230825   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230825   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r005-20230825   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                 randconfig-r023-20230825   clang
mips                 randconfig-r025-20230825   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230825   gcc  
nios2                randconfig-r033-20230825   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r035-20230825   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230825   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230825   clang
riscv                randconfig-r021-20230825   gcc  
riscv                randconfig-r022-20230825   gcc  
riscv                randconfig-r032-20230825   clang
riscv                randconfig-r036-20230825   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230825   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r026-20230825   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230825   gcc  
sparc                randconfig-r006-20230825   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r024-20230825   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230825   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-002-20230825   clang
x86_64       buildonly-randconfig-006-20230825   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
x86_64                randconfig-016-20230825   clang
x86_64                randconfig-076-20230825   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r013-20230825   gcc  
xtensa               randconfig-r015-20230825   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
