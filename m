Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040D766848
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjG1JHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjG1JGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949F273D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690535207; x=1722071207;
  h=date:from:to:cc:subject:message-id;
  bh=DyZ2H0hrOVBqQroaR55JR9H9MAkoiwwAQ3xLXdWbjCg=;
  b=ZYN4JADC0Mw+Gaboyk+CjJcQAA4SOQqGr5sOrfQIgFUFrgnq5J68YimQ
   8fy9zp8RYp/qjq6xw4vGrwKLN5KHt8mX4DlK+ngZF4ugts7QUfgDnBWLb
   Oyi7iYePB4SkPUESHXXQXLmkaZsRma/DuT3U5AmTiZkvG1JnWLr+GsmR7
   tD/JHMI8VwwtrRkOuw6x8jQfcpSsVyhW9vjipT3/v+UmRtnmuBBrU/aBV
   CWe+x9bZArkz169rC0eKTjh/2SfMPx2at0ao0GcVZ8pHCXmWbI21zvke3
   fX3IWFknFge1gjaSYfDYPtpyy5hLy05iuGXkOsZXUK3AdTRueXr8GKcH3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434831514"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="434831514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762534673"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="762534673"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2023 02:06:46 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPJQr-00033M-0z;
        Fri, 28 Jul 2023 09:06:45 +0000
Date:   Fri, 28 Jul 2023 17:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 b6736f287910cdd07dd8ba531987b2a5b16b31b0
Message-ID: <202307281700.EciAC7r5-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: b6736f287910cdd07dd8ba531987b2a5b16b31b0  Revert "checkpatch: Error out if deprecated RCU API used"

elapsed time: 728m

configs tested: 132
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230727   gcc  
alpha                randconfig-r012-20230727   gcc  
alpha                randconfig-r014-20230727   gcc  
alpha                randconfig-r022-20230727   gcc  
alpha                randconfig-r024-20230727   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230727   gcc  
arc                  randconfig-r021-20230727   gcc  
arc                  randconfig-r025-20230727   gcc  
arc                  randconfig-r043-20230727   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r032-20230727   gcc  
arm                  randconfig-r046-20230727   clang
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230727   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230727   gcc  
csky                 randconfig-r021-20230727   gcc  
csky                 randconfig-r035-20230727   gcc  
hexagon              randconfig-r041-20230727   clang
hexagon              randconfig-r045-20230727   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230727   clang
i386         buildonly-randconfig-r005-20230727   clang
i386         buildonly-randconfig-r006-20230727   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230727   clang
i386                 randconfig-i002-20230727   clang
i386                 randconfig-i003-20230727   clang
i386                 randconfig-i004-20230727   clang
i386                 randconfig-i005-20230727   clang
i386                 randconfig-i006-20230727   clang
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-r012-20230727   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230727   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r011-20230727   gcc  
microblaze           randconfig-r013-20230727   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                 randconfig-r025-20230727   clang
mips                 randconfig-r034-20230727   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230727   gcc  
nios2                randconfig-r023-20230727   gcc  
nios2                randconfig-r024-20230727   gcc  
openrisc             randconfig-r001-20230727   gcc  
openrisc             randconfig-r026-20230727   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230727   gcc  
parisc               randconfig-r036-20230727   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230727   gcc  
riscv                randconfig-r042-20230727   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230727   clang
s390                 randconfig-r044-20230727   gcc  
sh                               allmodconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230727   gcc  
sparc                randconfig-r003-20230727   gcc  
sparc                randconfig-r026-20230727   gcc  
sparc                randconfig-r031-20230727   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230727   clang
x86_64       buildonly-randconfig-r002-20230727   clang
x86_64       buildonly-randconfig-r003-20230727   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230727   gcc  
x86_64               randconfig-x002-20230727   gcc  
x86_64               randconfig-x003-20230727   gcc  
x86_64               randconfig-x004-20230727   gcc  
x86_64               randconfig-x005-20230727   gcc  
x86_64               randconfig-x006-20230727   gcc  
x86_64               randconfig-x011-20230727   clang
x86_64               randconfig-x012-20230727   clang
x86_64               randconfig-x013-20230727   clang
x86_64               randconfig-x014-20230727   clang
x86_64               randconfig-x015-20230727   clang
x86_64               randconfig-x016-20230727   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230727   gcc  
xtensa               randconfig-r033-20230727   gcc  
xtensa               randconfig-r034-20230727   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
