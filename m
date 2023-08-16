Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC477E0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjHPL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbjHPL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:58:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9767212E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692187087; x=1723723087;
  h=date:from:to:cc:subject:message-id;
  bh=P1VNOIbxf5QvOuDpWyP0eoYwbvD57+4x3idnlWQv2gA=;
  b=Dl2UnvchhiL2LjmFReul1tn1DbHRM0FqWb+KKsSQRvRHuPQZ0qcIW5oC
   wL+UE5kO9QiVYFfV7Wr9ElrK7ibkYseIzCnqXUwxXPeIVUdYiUfZoILCo
   EX9Mh5H3l4zOA7uU6E3RCI3wI48eL1HOqQ6NxylLyrKWKj82ik19/HNDI
   FazWKxFM2Zx98bkiQhrPQwCVVJYAjPXpSZ+LSULbdU69wRSYmlVkad1km
   +RqSYjgtc31ESckHBavMNf9gBxjeGmEm4i4HFwVkuOAsVydCASEqDiyBW
   TL3+Bkg7D0f/Z2HD+YnRid/AKNAD7hN/m/rW0A53va2u9I99eZcpCeaQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369982847"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="369982847"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763605508"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="763605508"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 04:57:47 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWF9m-0000IB-0s;
        Wed, 16 Aug 2023 11:57:46 +0000
Date:   Wed, 16 Aug 2023 19:57:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.14a] BUILD REGRESSION
 a90c4cbc91475bd5df35f712a954972fbfff40a1
Message-ID: <202308161902.iDDLABr0-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.14a
branch HEAD: a90c4cbc91475bd5df35f712a954972fbfff40a1  rcutorture: Copy out ftrace into its own console file

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308160930.YEekR3Wf-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308161021.xxxuCjro-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308161041.0EOMbdcX-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308161157.fjx0zzow-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/rcutorture.c:24:10: fatal error: 'linux/rcu_notifier.h' file not found
kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such file or directory
kernel/rcu/tree_stall.h:11:10: fatal error: 'linux/rcu_notifier.h' file not found
kernel/rcu/tree_stall.h:11:10: fatal error: linux/rcu_notifier.h: No such file or directory

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arc-randconfig-r043-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-allmodconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-omap2plus_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-qcom_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm-stm32_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm64-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- arm64-defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- csky-randconfig-r083-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-buildonly-randconfig-r006-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-debian-10.3
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-i001-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-i003-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-i004-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-i005-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-i006-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-m021-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- i386-randconfig-r071-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- loongarch-allmodconfig
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- loongarch-randconfig-r031-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- loongarch-randconfig-r033-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- m68k-allmodconfig
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- m68k-allyesconfig
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- microblaze-randconfig-r053-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- mips-allmodconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- mips-allyesconfig
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- nios2-randconfig-m041-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- nios2-randconfig-r062-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- parisc-defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- powerpc-allmodconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- riscv-allmodconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- riscv-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- riscv-defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- riscv-nommu_k210_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- riscv-rv32_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- s390-allmodconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- s390-allyesconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- s390-defconfig
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- s390-randconfig-r063-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- sh-allmodconfig
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- sparc-randconfig-r073-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- sparc-randconfig-r081-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- sparc-sparc64_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- um-randconfig-r072-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-buildonly-randconfig-r001-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-buildonly-randconfig-r002-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-buildonly-randconfig-r003-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-randconfig-m001-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-randconfig-r035-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-randconfig-x071-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
|-- x86_64-randconfig-x072-20230816
|   `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
`-- x86_64-randconfig-x073-20230816
    `-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h:No-such-file-or-directory
clang_recent_errors
|-- arm-vexpress_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- hexagon-randconfig-r005-20230816
|   |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h-file-not-found
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- i386-randconfig-i011-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- i386-randconfig-i014-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- i386-randconfig-i015-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- i386-randconfig-i016-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- mips-malta_kvm_defconfig
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
|-- mips-randconfig-r036-20230816
|   `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found
`-- x86_64-randconfig-x004-20230816
    |-- kernel-rcu-rcutorture.c:fatal-error:linux-rcu_notifier.h-file-not-found
    `-- kernel-rcu-tree_stall.h:fatal-error:linux-rcu_notifier.h-file-not-found

elapsed time: 723m

configs tested: 119
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230816   gcc  
arc                  randconfig-r043-20230816   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r046-20230816   gcc  
arm                           stm32_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230816   gcc  
hexagon              randconfig-r005-20230816   clang
hexagon              randconfig-r034-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r013-20230816   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230816   gcc  
loongarch            randconfig-r032-20230816   gcc  
loongarch            randconfig-r033-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r006-20230816   clang
mips                 randconfig-r036-20230816   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230816   gcc  
nios2                randconfig-r022-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r012-20230816   clang
powerpc                     tqm8540_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r003-20230816   gcc  
riscv                randconfig-r026-20230816   clang
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230816   clang
s390                 randconfig-r044-20230816   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r025-20230816   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r035-20230816   gcc  
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
