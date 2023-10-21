Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8407D1B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjJUHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:49:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB52D63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697874538; x=1729410538;
  h=date:from:to:cc:subject:message-id;
  bh=TyuXRMkBOM9f/dSwgdgaRaqbXS2/wgfn06hjXk/mVYA=;
  b=Xg5fc3H5nkrKoNbxM0WDMy9QG/vFVmiOPDTOAZMr5YddN9fCbIAUCZVL
   OPDouFS5Lm76J7nkVymcwceCNU4rBQ/2zOV0GGjEm36e6YTTGgZMD6P1+
   YcMPbQQuwCN1ruz3bz37rj6CKyLK9BDO7OjmW98tSfaA0T9bTSMfRdtS5
   guyuhjiqIi9W470VUHBHjVSgVFCI6ZwNd+5K5tDqms2hLoARiTdJqaYds
   XOXXdDdGe3EK1NgMx1MQZQHNx/d+X0x1gkgl0g/h08SNeEHQOBSlbfOgF
   i4XFD2yLKXLYxTM4u/dGmkDurlLG3X9VI0JX8MxQxJcu7Zsa5QJnaq6Hs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371686531"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="371686531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 00:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="787002366"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="787002366"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2023 00:48:56 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu6j8-0004aA-1I;
        Sat, 21 Oct 2023 07:48:54 +0000
Date:   Sat, 21 Oct 2023 15:48:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:mmap_sem.2023.10.18a] BUILD REGRESSION
 4015256f2bc734d4175381762282784597f41cfa
Message-ID: <202310211557.E69wdliB-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git mmap_sem.2023.10.18a
branch HEAD: 4015256f2bc734d4175381762282784597f41cfa  EXP TESTING: introduce delay between getting a VMA and using it in show_map

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310200320.JSEpTicA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310200814.xePmkBus-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/locking/qspinlock.c:741:23: warning: no previous declaration for '__pv_spinlock_dump' [-Wmissing-declarations]
task_mmu.c:(.text+0x614): undefined reference to `__bad_udelay'
task_mmu.c:(.text+0x6c4): undefined reference to `__bad_udelay'
task_mmu.c:(.text+0x87c): undefined reference to `__bad_udelay'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- task_mmu.c:(.text):undefined-reference-to-__bad_udelay
|-- arm-allyesconfig
|   `-- task_mmu.c:(.text):undefined-reference-to-__bad_udelay
|-- arm-defconfig
|   `-- task_mmu.c:(.text):undefined-reference-to-__bad_udelay
|-- arm-randconfig-002-20231019
|   `-- task_mmu.c:(.text):undefined-reference-to-__bad_udelay
`-- x86_64-randconfig-016-20231020
    `-- kernel-locking-qspinlock.c:warning:no-previous-declaration-for-__pv_spinlock_dump

elapsed time: 3394m

configs tested: 125
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231019   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231019   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20231020   gcc  
i386         buildonly-randconfig-002-20231020   gcc  
i386         buildonly-randconfig-003-20231020   gcc  
i386         buildonly-randconfig-004-20231020   gcc  
i386         buildonly-randconfig-005-20231020   gcc  
i386         buildonly-randconfig-006-20231020   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-016-20231019   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231019   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231019   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231019   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231019   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231019   gcc  
x86_64                randconfig-002-20231019   gcc  
x86_64                randconfig-003-20231019   gcc  
x86_64                randconfig-004-20231019   gcc  
x86_64                randconfig-005-20231019   gcc  
x86_64                randconfig-006-20231019   gcc  
x86_64                randconfig-011-20231020   gcc  
x86_64                randconfig-012-20231020   gcc  
x86_64                randconfig-013-20231020   gcc  
x86_64                randconfig-014-20231020   gcc  
x86_64                randconfig-015-20231020   gcc  
x86_64                randconfig-016-20231020   gcc  
x86_64                randconfig-071-20231020   gcc  
x86_64                randconfig-072-20231020   gcc  
x86_64                randconfig-073-20231020   gcc  
x86_64                randconfig-074-20231020   gcc  
x86_64                randconfig-075-20231020   gcc  
x86_64                randconfig-076-20231020   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
