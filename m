Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E87ABC63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjIVXgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjIVXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:36:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C91A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695425775; x=1726961775;
  h=date:from:to:cc:subject:message-id;
  bh=M/ua2wAdHu4/fBsLzuMA79Jz/r90ZrDX+t+BFKyphTY=;
  b=Hp84YML6BrpGwCzy64gM6azNkX8w4Eq8jS0AIZuXIoV1fXbSALhe//nH
   p6P4HVucgOsiG6jOHQHOpE22FXiv5HQf+GS2oAZR8PKVsaYHYacmuBLrV
   ypX87Ztj2XKK77rJOeSalG0PoyNWAgSR+kql6QeWoE0GTAlWla6ysmmRe
   xmxx+OogDqfya/QC7jYJcGQlFFc9MV11q6EsDa4zd2Roe7xiWGnC30JNH
   /YV7X/zM+0+Fwg+iC38BguzpHK3sONGchgDoCdBolVDrHChuEHMAii52Q
   Ci95TYuPHPZW4zQWr/Uum+5wM1nrvt6CRwF7mbu7Rsey6Kah3IJnBjxCs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="411898085"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="411898085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 16:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="817977299"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="817977299"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2023 16:36:13 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjpgx-0001T3-2j;
        Fri, 22 Sep 2023 23:36:11 +0000
Date:   Sat, 23 Sep 2023 07:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 cfa92b6d52071aaa8f27d21affdcb14e7448fbc1
Message-ID: <202309230710.WzclkBmK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: cfa92b6d52071aaa8f27d21affdcb14e7448fbc1  locking/ww_mutex/test: Make sure we bail out instead of livelock

elapsed time: 927m

configs tested: 183
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20230922   gcc  
arc                   randconfig-001-20230923   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230922   gcc  
arm                        shmobile_defconfig   gcc  
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
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-001-20230923   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-002-20230923   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-003-20230923   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-004-20230923   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-005-20230923   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386         buildonly-randconfig-006-20230923   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-001-20230923   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-002-20230923   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-003-20230923   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-004-20230923   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-005-20230923   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-006-20230923   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-011-20230923   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-012-20230923   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-013-20230923   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-014-20230923   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-015-20230923   gcc  
i386                  randconfig-016-20230922   gcc  
i386                  randconfig-016-20230923   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230922   gcc  
loongarch             randconfig-001-20230923   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ip27_defconfig   clang
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
powerpc                     asp8347_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc64                           defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230922   gcc  
riscv                 randconfig-001-20230923   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230922   gcc  
s390                  randconfig-001-20230923   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230922   gcc  
sparc                 randconfig-001-20230923   gcc  
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
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-001-20230923   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-002-20230923   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-003-20230923   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-004-20230923   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-005-20230923   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-006-20230923   gcc  
x86_64                randconfig-011-20230923   gcc  
x86_64                randconfig-012-20230923   gcc  
x86_64                randconfig-013-20230923   gcc  
x86_64                randconfig-014-20230923   gcc  
x86_64                randconfig-015-20230923   gcc  
x86_64                randconfig-016-20230923   gcc  
x86_64                randconfig-071-20230922   gcc  
x86_64                randconfig-071-20230923   gcc  
x86_64                randconfig-072-20230922   gcc  
x86_64                randconfig-072-20230923   gcc  
x86_64                randconfig-073-20230922   gcc  
x86_64                randconfig-073-20230923   gcc  
x86_64                randconfig-074-20230922   gcc  
x86_64                randconfig-074-20230923   gcc  
x86_64                randconfig-075-20230922   gcc  
x86_64                randconfig-075-20230923   gcc  
x86_64                randconfig-076-20230922   gcc  
x86_64                randconfig-076-20230923   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
