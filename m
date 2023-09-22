Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96357AAA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjIVHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjIVHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:39:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C11C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695368380; x=1726904380;
  h=date:from:to:cc:subject:message-id;
  bh=I5yCiMPmAWsd6+vjEgsledVid74Vxn7qyByrOH0xlq0=;
  b=M0BtZDCVgBE7i1S5Ba/HHD+2KfhORR2H9tM/Lj7y9Aoj6SlCWkI8vC7j
   MhozvwunxT/wYRFTQnzfNjhSrAwEW3MnNEyA5igk3D/6baCxOPvi1ABLv
   Ql7tR79ZXQVYU/WVIC7ZI5eDtlSl3fzox87mFi1v463YdzRbRyQI/2ZDV
   0JHG9JEsec+dX1AbFgcxS51EpAMQCUG6+ufr/nqrrRj9cEvVpbztNdKIq
   CsEgfK8u13UFWWH9BwG5/3i3zYYnXvqyeu+wrUe/2a830V5gcNZG1O+Ca
   r8mtm/ki+v1tWYsQM25v/lBgppUathj8F6GIs1TY/z98jk4YfsAl1wmIZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411704815"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="411704815"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 00:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750748069"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750748069"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2023 00:39:39 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjalB-0000J9-00;
        Fri, 22 Sep 2023 07:39:34 +0000
Date:   Fri, 22 Sep 2023 15:38:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 41b43b6c6e30a832c790b010a06772e793bca193
Message-ID: <202309221535.h3xe2Jxs-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 41b43b6c6e30a832c790b010a06772e793bca193  locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()

elapsed time: 1475m

configs tested: 195
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
arc                   randconfig-001-20230921   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20230921   gcc  
arm                   randconfig-001-20230922   gcc  
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
i386         buildonly-randconfig-001-20230921   gcc  
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-002-20230921   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-003-20230921   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-004-20230921   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-005-20230921   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-006-20230921   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230921   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-002-20230921   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-003-20230921   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-004-20230921   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-005-20230921   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-006-20230921   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-011-20230921   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-012-20230921   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-013-20230921   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-014-20230921   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-015-20230921   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-016-20230921   gcc  
i386                  randconfig-016-20230922   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230921   gcc  
loongarch             randconfig-001-20230922   gcc  
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
mips                      bmips_stb_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230921   gcc  
riscv                 randconfig-001-20230922   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230921   gcc  
s390                  randconfig-001-20230922   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230921   gcc  
sparc                 randconfig-001-20230922   gcc  
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
x86_64       buildonly-randconfig-001-20230921   gcc  
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-002-20230921   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-003-20230921   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-004-20230921   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-005-20230921   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-006-20230921   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230921   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-002-20230921   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-003-20230921   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-004-20230921   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-005-20230921   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-006-20230921   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-011-20230921   gcc  
x86_64                randconfig-012-20230921   gcc  
x86_64                randconfig-013-20230921   gcc  
x86_64                randconfig-014-20230921   gcc  
x86_64                randconfig-015-20230921   gcc  
x86_64                randconfig-016-20230921   gcc  
x86_64                randconfig-071-20230921   gcc  
x86_64                randconfig-071-20230922   gcc  
x86_64                randconfig-072-20230921   gcc  
x86_64                randconfig-072-20230922   gcc  
x86_64                randconfig-073-20230921   gcc  
x86_64                randconfig-073-20230922   gcc  
x86_64                randconfig-074-20230921   gcc  
x86_64                randconfig-074-20230922   gcc  
x86_64                randconfig-075-20230921   gcc  
x86_64                randconfig-075-20230922   gcc  
x86_64                randconfig-076-20230921   gcc  
x86_64                randconfig-076-20230922   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                          iss_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
