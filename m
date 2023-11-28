Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB547FB95B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjK1LYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbjK1LYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:24:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F811A2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701170651; x=1732706651;
  h=date:from:to:cc:subject:message-id;
  bh=IT9iOwqt/CPp6qJmZdydbOpKxtwhyULNdObmyU2Tq/A=;
  b=ayWyQ+bmQinBqr0MULp6kXF8ySIUSayKfwQ5PVbCuoH4iRVE2xzG1s3L
   eJEOJ+5JVB8WqL5HwZFj65LZ3cLFNCtMvwv/ZUFqwfIBYIgp5yKsDiNc2
   fX288DhR6SxPJcowaCUUSuoPaLSCdfZPThpPDzz2oGRUP8uaMizR0fSk9
   KZLd7cXTeSgayfKkzIyGCb4Dyya4BEkSR2TzOp8T6q7F7Y7XLkNAadT/P
   zJlhqpA5aXVHYBgS3XECT03Ez16M9NxK5PUSZiUN2D+FcbzL3xMQ2jeW+
   8iZwwYg6hklP3YzEewgcPKJ+GaA7D2dUxDYd1vn1cGnvGKbHbOG+Jf+7H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="390055872"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="390055872"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="768496061"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="768496061"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2023 03:24:10 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7wCF-0007U8-2q;
        Tue, 28 Nov 2023 11:24:07 +0000
Date:   Tue, 28 Nov 2023 19:23:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 18caaedaf4c3712ab6821f292598a8f86e6d7972
Message-ID: <202311281948.jpoPZzXZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 18caaedaf4c3712ab6821f292598a8f86e6d7972  locking/lockdep: Slightly reorder 'struct lock_class' to save some memory

elapsed time: 1496m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231127   gcc  
i386         buildonly-randconfig-002-20231127   gcc  
i386         buildonly-randconfig-003-20231127   gcc  
i386         buildonly-randconfig-004-20231127   gcc  
i386         buildonly-randconfig-005-20231127   gcc  
i386         buildonly-randconfig-006-20231127   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231127   gcc  
i386                  randconfig-002-20231127   gcc  
i386                  randconfig-003-20231127   gcc  
i386                  randconfig-004-20231127   gcc  
i386                  randconfig-005-20231127   gcc  
i386                  randconfig-006-20231127   gcc  
i386                  randconfig-011-20231127   clang
i386                  randconfig-012-20231127   clang
i386                  randconfig-013-20231127   clang
i386                  randconfig-014-20231127   clang
i386                  randconfig-015-20231127   clang
i386                  randconfig-016-20231127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
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
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
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
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231127   gcc  
x86_64       buildonly-randconfig-001-20231128   clang
x86_64       buildonly-randconfig-002-20231127   gcc  
x86_64       buildonly-randconfig-002-20231128   clang
x86_64       buildonly-randconfig-003-20231127   gcc  
x86_64       buildonly-randconfig-003-20231128   clang
x86_64       buildonly-randconfig-004-20231127   gcc  
x86_64       buildonly-randconfig-004-20231128   clang
x86_64       buildonly-randconfig-005-20231127   gcc  
x86_64       buildonly-randconfig-005-20231128   clang
x86_64       buildonly-randconfig-006-20231127   gcc  
x86_64       buildonly-randconfig-006-20231128   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231127   clang
x86_64                randconfig-001-20231128   gcc  
x86_64                randconfig-002-20231127   clang
x86_64                randconfig-002-20231128   gcc  
x86_64                randconfig-003-20231127   clang
x86_64                randconfig-003-20231128   gcc  
x86_64                randconfig-004-20231127   clang
x86_64                randconfig-004-20231128   gcc  
x86_64                randconfig-005-20231128   gcc  
x86_64                randconfig-006-20231127   clang
x86_64                randconfig-006-20231128   gcc  
x86_64                randconfig-011-20231128   clang
x86_64                randconfig-012-20231127   gcc  
x86_64                randconfig-012-20231128   clang
x86_64                randconfig-013-20231128   clang
x86_64                randconfig-014-20231128   clang
x86_64                randconfig-015-20231128   clang
x86_64                randconfig-016-20231128   clang
x86_64                randconfig-071-20231128   clang
x86_64                randconfig-072-20231128   clang
x86_64                randconfig-073-20231128   clang
x86_64                randconfig-074-20231128   clang
x86_64                randconfig-075-20231128   clang
x86_64                randconfig-076-20231128   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
