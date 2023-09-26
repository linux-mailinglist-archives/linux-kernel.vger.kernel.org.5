Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DD7AE4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjIZEmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZEmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:42:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1397
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695703317; x=1727239317;
  h=date:from:to:cc:subject:message-id;
  bh=dEetNWU8bb+BYXPfHpUgI6EJMGulKbSmwbZrC7WSTq4=;
  b=N+Dy1WFg9SaHxKh2ew/ZDNb1Sm8PZT+F1Mc76J1ur0vYGwEmWLM5k4Ku
   osxAPFBKGqvxJtmua2PZm61GJF3ixoIgi5GxTsf830eNPYGMVRDzvMaX7
   ZlZGpSSml9m1TJhP4x4tg6G0jTumj4VPgB7Ov8GO1nUhldmvHlMC2vRCJ
   yCVfRC8XoOY9OI2d3tZ07n0L22v2BYfcIifa64d1O7j7Y7Xqxfgu8TjWn
   e2wH2JLwR7V12jfG9rKju6zCudRM28PGMK//ADGw+Y10Jdsh4/jNF3aQ/
   SF8Sg4/sAbwkwEG4sm81fM8mtt4XMshzW4lKYjiIVYmPXevleLSX4gqjd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360861061"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360861061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="864268920"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="864268920"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2023 21:41:55 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkztR-0002Qb-0j;
        Tue, 26 Sep 2023 04:41:53 +0000
Date:   Tue, 26 Sep 2023 12:41:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 599522d9d2e19d6240e4312577f1c5f3ffca22f6
Message-ID: <202309261250.5MkjXTkl-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 599522d9d2e19d6240e4312577f1c5f3ffca22f6  perf/x86/amd: Do not WARN() on every IRQ

elapsed time: 1134m

configs tested: 179
configs skipped: 116

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
arc                   randconfig-001-20230926   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                           omap1_defconfig   clang
arm                   randconfig-001-20230926   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230925   gcc  
i386         buildonly-randconfig-001-20230926   gcc  
i386         buildonly-randconfig-002-20230925   gcc  
i386         buildonly-randconfig-002-20230926   gcc  
i386         buildonly-randconfig-003-20230925   gcc  
i386         buildonly-randconfig-003-20230926   gcc  
i386         buildonly-randconfig-004-20230925   gcc  
i386         buildonly-randconfig-004-20230926   gcc  
i386         buildonly-randconfig-005-20230925   gcc  
i386         buildonly-randconfig-005-20230926   gcc  
i386         buildonly-randconfig-006-20230925   gcc  
i386         buildonly-randconfig-006-20230926   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230925   gcc  
i386                  randconfig-001-20230926   gcc  
i386                  randconfig-002-20230925   gcc  
i386                  randconfig-002-20230926   gcc  
i386                  randconfig-003-20230925   gcc  
i386                  randconfig-003-20230926   gcc  
i386                  randconfig-004-20230925   gcc  
i386                  randconfig-004-20230926   gcc  
i386                  randconfig-005-20230925   gcc  
i386                  randconfig-005-20230926   gcc  
i386                  randconfig-006-20230925   gcc  
i386                  randconfig-006-20230926   gcc  
i386                  randconfig-011-20230925   gcc  
i386                  randconfig-012-20230925   gcc  
i386                  randconfig-013-20230925   gcc  
i386                  randconfig-014-20230925   gcc  
i386                  randconfig-015-20230925   gcc  
i386                  randconfig-016-20230925   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230926   gcc  
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
mips                        bcm63xx_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                     cu1830-neo_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
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
powerpc                      ppc44x_defconfig   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230926   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                  randconfig-001-20230926   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230926   gcc  
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
x86_64       buildonly-randconfig-001-20230926   gcc  
x86_64       buildonly-randconfig-002-20230926   gcc  
x86_64       buildonly-randconfig-003-20230926   gcc  
x86_64       buildonly-randconfig-004-20230926   gcc  
x86_64       buildonly-randconfig-005-20230926   gcc  
x86_64       buildonly-randconfig-006-20230925   gcc  
x86_64       buildonly-randconfig-006-20230926   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230925   gcc  
x86_64                randconfig-001-20230926   gcc  
x86_64                randconfig-002-20230925   gcc  
x86_64                randconfig-002-20230926   gcc  
x86_64                randconfig-003-20230925   gcc  
x86_64                randconfig-003-20230926   gcc  
x86_64                randconfig-004-20230925   gcc  
x86_64                randconfig-004-20230926   gcc  
x86_64                randconfig-005-20230925   gcc  
x86_64                randconfig-005-20230926   gcc  
x86_64                randconfig-006-20230925   gcc  
x86_64                randconfig-006-20230926   gcc  
x86_64                randconfig-011-20230925   gcc  
x86_64                randconfig-011-20230926   gcc  
x86_64                randconfig-012-20230925   gcc  
x86_64                randconfig-012-20230926   gcc  
x86_64                randconfig-013-20230925   gcc  
x86_64                randconfig-013-20230926   gcc  
x86_64                randconfig-014-20230925   gcc  
x86_64                randconfig-014-20230926   gcc  
x86_64                randconfig-015-20230925   gcc  
x86_64                randconfig-015-20230926   gcc  
x86_64                randconfig-016-20230925   gcc  
x86_64                randconfig-016-20230926   gcc  
x86_64                randconfig-071-20230925   gcc  
x86_64                randconfig-071-20230926   gcc  
x86_64                randconfig-072-20230925   gcc  
x86_64                randconfig-072-20230926   gcc  
x86_64                randconfig-073-20230925   gcc  
x86_64                randconfig-073-20230926   gcc  
x86_64                randconfig-074-20230925   gcc  
x86_64                randconfig-074-20230926   gcc  
x86_64                randconfig-075-20230925   gcc  
x86_64                randconfig-075-20230926   gcc  
x86_64                randconfig-076-20230925   gcc  
x86_64                randconfig-076-20230926   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
