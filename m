Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FE7A6E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjISWPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjISWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:15:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75002D8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161725; x=1726697725;
  h=date:from:to:cc:subject:message-id;
  bh=IN1z6jyF7Ykw4DESPKn9Oc0ZlMSkkheGe48dW+fOHPs=;
  b=P2bhsnA/bFfDulpwfZZxQEk8i9fB9u3pANIbV1/bb7JrIBjq9qT8saXg
   z8jmIQ7SfrFDdr+yV4wt1lIeeNJX9AwQjrl8u9sNZ2sbU3tXsKkPTxGLq
   674YfSks8p0+qQoY7AheMBhiq/65E/Y4RX27cacGWIlN+9XTvN0dY2nmt
   bM8B6+OiwLcelmroUbpqjvjm8Qr/7dyiVDzi6U+4HCFFReuyQltQFT+wo
   qV7VIQo3dn4B0uKieSfXFUAwp1TImnT1i78tDbPMYE6ycX7XPl0JZclQS
   GmEmwfccrNOb5Z6YSFCDeIPd2LkZrrQY9B/SADs8xMEbbC2hBXo4oJaqm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383904444"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383904444"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781454626"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="781454626"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 15:15:23 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qij04-0007yu-29;
        Tue, 19 Sep 2023 22:15:20 +0000
Date:   Wed, 20 Sep 2023 06:14:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 f75a0e70ed379019b209cdb591ffbfe2fbf4342f
Message-ID: <202309200615.B4oefUwY-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: f75a0e70ed379019b209cdb591ffbfe2fbf4342f  x86/pti: Fix kernel warnings for pti= and nopti cmdline options

elapsed time: 731m

configs tested: 169
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
arc                   randconfig-001-20230919   gcc  
arc                   randconfig-001-20230920   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20230919   gcc  
arm                   randconfig-001-20230920   gcc  
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
i386         buildonly-randconfig-001-20230919   gcc  
i386         buildonly-randconfig-002-20230919   gcc  
i386         buildonly-randconfig-003-20230919   gcc  
i386         buildonly-randconfig-004-20230919   gcc  
i386         buildonly-randconfig-005-20230919   gcc  
i386         buildonly-randconfig-006-20230919   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230919   gcc  
i386                  randconfig-002-20230919   gcc  
i386                  randconfig-003-20230919   gcc  
i386                  randconfig-004-20230919   gcc  
i386                  randconfig-005-20230919   gcc  
i386                  randconfig-006-20230919   gcc  
i386                  randconfig-011-20230919   gcc  
i386                  randconfig-012-20230919   gcc  
i386                  randconfig-013-20230919   gcc  
i386                  randconfig-014-20230919   gcc  
i386                  randconfig-015-20230919   gcc  
i386                  randconfig-016-20230919   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230919   gcc  
loongarch             randconfig-001-20230920   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     loongson2k_defconfig   clang
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
powerpc                 canyonlands_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230919   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230919   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230919   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230919   gcc  
x86_64       buildonly-randconfig-002-20230919   gcc  
x86_64       buildonly-randconfig-003-20230919   gcc  
x86_64       buildonly-randconfig-004-20230919   gcc  
x86_64       buildonly-randconfig-005-20230919   gcc  
x86_64       buildonly-randconfig-006-20230919   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230919   gcc  
x86_64                randconfig-002-20230919   gcc  
x86_64                randconfig-003-20230919   gcc  
x86_64                randconfig-004-20230919   gcc  
x86_64                randconfig-005-20230919   gcc  
x86_64                randconfig-006-20230919   gcc  
x86_64                randconfig-011-20230919   gcc  
x86_64                randconfig-012-20230919   gcc  
x86_64                randconfig-013-20230919   gcc  
x86_64                randconfig-014-20230919   gcc  
x86_64                randconfig-015-20230919   gcc  
x86_64                randconfig-016-20230919   gcc  
x86_64                randconfig-071-20230919   gcc  
x86_64                randconfig-071-20230920   gcc  
x86_64                randconfig-072-20230919   gcc  
x86_64                randconfig-072-20230920   gcc  
x86_64                randconfig-073-20230919   gcc  
x86_64                randconfig-073-20230920   gcc  
x86_64                randconfig-074-20230919   gcc  
x86_64                randconfig-074-20230920   gcc  
x86_64                randconfig-075-20230919   gcc  
x86_64                randconfig-075-20230920   gcc  
x86_64                randconfig-076-20230919   gcc  
x86_64                randconfig-076-20230920   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
