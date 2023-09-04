Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EB8791419
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbjIDI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjIDI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:56:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3812E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693817809; x=1725353809;
  h=date:from:to:cc:subject:message-id;
  bh=Nb7vqYss0HF2a8l9aWr27CoRVNXpoX+wEDqOx1YoX1I=;
  b=Yl+4tCWukBLNW3nf5Ox3SOJGnKGNFt0SZCtSMf+FKq9RVOcmjawqalCo
   f6z+TAhEj7a4vKc2VeeMQDIwUX7HtsY21zGvmvaMbIOlhXaiq/odXD3cE
   yahVoY2vHw5GVYXaVpPk+eOZ8/ahKeuvGHJXBpTCERVng3AatECDgKqGb
   LCnW7PVWduuM8o94igxJyA+1SAlJpbN8zgN9//F4+h34lwl9OQd5wmQYq
   /XfXahd/k5D0GAMvNfGxnl3M4i5ubiiQXU90LPedzrrWlkekdOMtvIf/U
   XY8zyIGQFKrBYcdYFNs5UcdYoXIKwogJMKc2q6qMA45U19YAWI5+9f9EQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="440519321"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="440519321"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="690518517"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="690518517"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2023 01:56:47 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd5O1-0000Kp-0o;
        Mon, 04 Sep 2023 08:56:45 +0000
Date:   Mon, 04 Sep 2023 16:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 f8858d96061f5942216c6abb0194c3ea7b78e1e8
Message-ID: <202309041645.I5IXRCqC-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: f8858d96061f5942216c6abb0194c3ea7b78e1e8  sched/fair: Optimize should_we_balance() for large SMT systems

elapsed time: 2421m

configs tested: 178
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
arc                   randconfig-001-20230903   gcc  
arc                  randconfig-r023-20230903   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230903   clang
arm                         socfpga_defconfig   clang
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
csky                 randconfig-r025-20230903   gcc  
csky                 randconfig-r031-20230903   gcc  
hexagon               randconfig-001-20230903   clang
hexagon               randconfig-002-20230903   clang
hexagon              randconfig-r032-20230903   clang
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
loongarch            randconfig-r021-20230903   gcc  
loongarch            randconfig-r034-20230903   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                 randconfig-r036-20230903   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230903   gcc  
microblaze           randconfig-r013-20230903   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 randconfig-r022-20230903   clang
mips                          rm200_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230903   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230903   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          allyesconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r012-20230903   gcc  
powerpc              randconfig-r016-20230903   gcc  
powerpc              randconfig-r033-20230903   clang
powerpc                     tqm8540_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230903   clang
riscv                randconfig-r003-20230903   clang
riscv                randconfig-r006-20230903   clang
riscv                randconfig-r026-20230903   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230903   gcc  
s390                 randconfig-r014-20230903   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r005-20230903   gcc  
sh                           se7206_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230903   gcc  
sparc                randconfig-r035-20230903   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r011-20230903   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
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
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r004-20230903   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
