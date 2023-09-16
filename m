Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3197A2DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 06:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbjIPEWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 00:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjIPEWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 00:22:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C681BD3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 21:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694838132; x=1726374132;
  h=date:from:to:cc:subject:message-id;
  bh=lSdi7wSSGs9bRUM0+rdsiCv2bo1OZao7nsLHEZSejBM=;
  b=ckHww46/d4401RLyJEs6Y+ZoDXgOLF7haAfi+0MZi/xeUjML+jn1Xzlg
   vmO8FWbgyooWPwtaBVlcALUTbjMdcIpZYhKamXK/uE8n7HrVMjo8rctWN
   viwsnAiuqhjXMOhchXBFXpRLxySlYGlkH0TmAOjDE4WFaJK4jdwj2MPgn
   d6SC/X27mDLP/P044LA+QugWdPWsmtGQRfETnyaYfns9yr0TAzIAaHTDT
   NP97LUs88C3UNp+iW/HogmPjWIEFqjqUbbgvriHO77Ni4xME2OOI79Kg2
   xSY84e0FmNVLZvzgOAH6mpJhy42+Ayr47SIU7LY+G1Dx6wLTl1puaCVIP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410332690"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="410332690"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 21:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="721913739"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="721913739"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2023 21:22:10 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhMoq-0003qe-0D;
        Sat, 16 Sep 2023 04:22:08 +0000
Date:   Sat, 16 Sep 2023 12:21:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.09.15a] BUILD SUCCESS
 2c6b3306f972b125bfe428b6b9a26ca95c56f4ed
Message-ID: <202309161247.8AtIkYrn-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.09.15a
branch HEAD: 2c6b3306f972b125bfe428b6b9a26ca95c56f4ed  EXP sched: Export dump_cpu_task() to GPL modules for locktorture

elapsed time: 736m

configs tested: 147
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
arc                   randconfig-001-20230916   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                   randconfig-001-20230916   gcc  
arm                        realview_defconfig   gcc  
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
i386         buildonly-randconfig-001-20230916   gcc  
i386         buildonly-randconfig-002-20230916   gcc  
i386         buildonly-randconfig-003-20230916   gcc  
i386         buildonly-randconfig-004-20230916   gcc  
i386         buildonly-randconfig-005-20230916   gcc  
i386         buildonly-randconfig-006-20230916   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230916   gcc  
i386                  randconfig-002-20230916   gcc  
i386                  randconfig-003-20230916   gcc  
i386                  randconfig-004-20230916   gcc  
i386                  randconfig-005-20230916   gcc  
i386                  randconfig-006-20230916   gcc  
i386                  randconfig-011-20230916   gcc  
i386                  randconfig-012-20230916   gcc  
i386                  randconfig-013-20230916   gcc  
i386                  randconfig-014-20230916   gcc  
i386                  randconfig-015-20230916   gcc  
i386                  randconfig-016-20230916   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230916   gcc  
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
mips                  decstation_64_defconfig   gcc  
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
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20230916   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230916   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230916   gcc  
sparc                       sparc64_defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20230916   gcc  
x86_64       buildonly-randconfig-002-20230916   gcc  
x86_64       buildonly-randconfig-003-20230916   gcc  
x86_64       buildonly-randconfig-004-20230916   gcc  
x86_64       buildonly-randconfig-005-20230916   gcc  
x86_64       buildonly-randconfig-006-20230916   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230916   gcc  
x86_64                randconfig-002-20230916   gcc  
x86_64                randconfig-003-20230916   gcc  
x86_64                randconfig-004-20230916   gcc  
x86_64                randconfig-005-20230916   gcc  
x86_64                randconfig-006-20230916   gcc  
x86_64                randconfig-011-20230916   gcc  
x86_64                randconfig-012-20230916   gcc  
x86_64                randconfig-013-20230916   gcc  
x86_64                randconfig-014-20230916   gcc  
x86_64                randconfig-015-20230916   gcc  
x86_64                randconfig-016-20230916   gcc  
x86_64                randconfig-071-20230916   gcc  
x86_64                randconfig-072-20230916   gcc  
x86_64                randconfig-073-20230916   gcc  
x86_64                randconfig-074-20230916   gcc  
x86_64                randconfig-075-20230916   gcc  
x86_64                randconfig-076-20230916   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
