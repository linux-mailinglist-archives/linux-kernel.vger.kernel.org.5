Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA07CD16A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjJRAh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRAh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:37:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC8B7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697589476; x=1729125476;
  h=date:from:to:cc:subject:message-id;
  bh=zaxBEsGGXxwGT7il2oYI+KfC7QpXZHJb43gIynHfHHY=;
  b=kdm9MdreyLY5POP1HaGI5/PluyDgLWcZQqc5sJF2dgqbv8F0OmRfF9VW
   pKwrTdaU74FneBq6S/wUhd+qeUD8HrrXEs7TVhUsi9Qfoi6sPVLKUuJW1
   AN9qFTHHclxsNtxd5mAG3MDCZhflHj54sMXJwjRTttArhsRxldjJ5s+eL
   SjEy5vq43zTKhrQegot8HeQ54JOmpR0W61DvKFJ1PuU0FRHaMdfzOZbQv
   4DjzmP7eB83XwfDM7ulL19jY5HlLvBkAsRHDx+lH6aE0FHs7+X0lbZ6Q6
   FEERA/lQ6FJ1tIep6oMHEi6+YISuCbj7p1VAyBwlO4hwdib2LifjakR+p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389784155"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="389784155"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 17:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760016091"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="760016091"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2023 17:37:54 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsuZM-000AHF-0s;
        Wed, 18 Oct 2023 00:37:52 +0000
Date:   Wed, 18 Oct 2023 08:37:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.10.13a] BUILD SUCCESS
 bafc5de698a4a766dc7960ed71251ef1afdb7caa
Message-ID: <202310180838.uJIUAvnl-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.10.13a
branch HEAD: bafc5de698a4a766dc7960ed71251ef1afdb7caa  clocksource: disable irq when holding watchdog_lock.

elapsed time: 1488m

configs tested: 154
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
arc                   randconfig-001-20231017   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20231017   gcc  
arm                        realview_defconfig   gcc  
arm                           tegra_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231017   gcc  
i386         buildonly-randconfig-002-20231017   gcc  
i386         buildonly-randconfig-003-20231017   gcc  
i386         buildonly-randconfig-004-20231017   gcc  
i386         buildonly-randconfig-005-20231017   gcc  
i386         buildonly-randconfig-006-20231017   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231017   gcc  
i386                  randconfig-002-20231017   gcc  
i386                  randconfig-003-20231017   gcc  
i386                  randconfig-004-20231017   gcc  
i386                  randconfig-005-20231017   gcc  
i386                  randconfig-006-20231017   gcc  
i386                  randconfig-011-20231017   gcc  
i386                  randconfig-012-20231017   gcc  
i386                  randconfig-013-20231017   gcc  
i386                  randconfig-014-20231017   gcc  
i386                  randconfig-015-20231017   gcc  
i386                  randconfig-016-20231017   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231017   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
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
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231017   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231017   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231017   gcc  
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
x86_64       buildonly-randconfig-001-20231017   gcc  
x86_64       buildonly-randconfig-002-20231017   gcc  
x86_64       buildonly-randconfig-003-20231017   gcc  
x86_64       buildonly-randconfig-004-20231017   gcc  
x86_64       buildonly-randconfig-005-20231017   gcc  
x86_64       buildonly-randconfig-006-20231017   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231017   gcc  
x86_64                randconfig-002-20231017   gcc  
x86_64                randconfig-003-20231017   gcc  
x86_64                randconfig-004-20231017   gcc  
x86_64                randconfig-005-20231017   gcc  
x86_64                randconfig-006-20231017   gcc  
x86_64                randconfig-011-20231017   gcc  
x86_64                randconfig-012-20231017   gcc  
x86_64                randconfig-013-20231017   gcc  
x86_64                randconfig-014-20231017   gcc  
x86_64                randconfig-015-20231017   gcc  
x86_64                randconfig-016-20231017   gcc  
x86_64                randconfig-071-20231017   gcc  
x86_64                randconfig-072-20231017   gcc  
x86_64                randconfig-073-20231017   gcc  
x86_64                randconfig-074-20231017   gcc  
x86_64                randconfig-075-20231017   gcc  
x86_64                randconfig-076-20231017   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
