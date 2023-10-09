Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA17BD2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbjJIFNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:13:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E18A4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696828421; x=1728364421;
  h=date:from:to:cc:subject:message-id;
  bh=8ZhoGiH2J4vdCz9JOg4jot3zpEIgoDdpzdPD9cbn4xU=;
  b=CB7VyGsJeJscQ7ngM44HBkFujWSU/QWaFpTsEZ8P/3ole0MkQnBSTN6Q
   /GFqFfdu7f9+usyNibWiE/PtgHrfoKnZ5jRmWGUT6stzOBg1E5ULNdqFK
   tLpjldci2Kd54XUWNK/Sre5KkTOhv94HYFRrV5asnWfXkvVZfGWoD3EPA
   xwH9GLr4ENA8RhQL/Af2bdTUZegWvgYwTwhc1Kb6/Pns6f5q5COwkwTc3
   c3cuxqllcyjav0e5UjzA2BRVSs4R8Cp6sVk4RvSL5tRJyrE8O+kTKWVld
   I6HbMBHJiaxyt+xDfL7INUQrnKwVOg/vPogA1VGc3eiGz8LxFZdWc9OBt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386910474"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386910474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="729543792"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="729543792"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2023 22:13:38 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpiaG-000637-1E;
        Mon, 09 Oct 2023 05:13:36 +0000
Date:   Mon, 09 Oct 2023 13:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nolibc-rebase.2023.10.08a] BUILD SUCCESS
 ced2d2387b4336697b3f7b99a93e109b27c0705e
Message-ID: <202310091336.TrO22icM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nolibc-rebase.2023.10.08a
branch HEAD: ced2d2387b4336697b3f7b99a93e109b27c0705e  tools/nolibc: automatically detect necessity to use pselect6

elapsed time: 727m

configs tested: 132
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
arc                   randconfig-001-20231009   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231009   gcc  
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
i386         buildonly-randconfig-001-20231009   gcc  
i386         buildonly-randconfig-002-20231009   gcc  
i386         buildonly-randconfig-003-20231009   gcc  
i386         buildonly-randconfig-004-20231009   gcc  
i386         buildonly-randconfig-005-20231009   gcc  
i386         buildonly-randconfig-006-20231009   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231009   gcc  
i386                  randconfig-002-20231009   gcc  
i386                  randconfig-003-20231009   gcc  
i386                  randconfig-004-20231009   gcc  
i386                  randconfig-005-20231009   gcc  
i386                  randconfig-006-20231009   gcc  
i386                  randconfig-011-20231009   gcc  
i386                  randconfig-012-20231009   gcc  
i386                  randconfig-013-20231009   gcc  
i386                  randconfig-014-20231009   gcc  
i386                  randconfig-015-20231009   gcc  
i386                  randconfig-016-20231009   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231009   gcc  
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
mips                       rbtx49xx_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
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
riscv                 randconfig-001-20231009   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231009   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231009   gcc  
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
x86_64       buildonly-randconfig-001-20231009   gcc  
x86_64       buildonly-randconfig-002-20231009   gcc  
x86_64       buildonly-randconfig-003-20231009   gcc  
x86_64       buildonly-randconfig-004-20231009   gcc  
x86_64       buildonly-randconfig-005-20231009   gcc  
x86_64       buildonly-randconfig-006-20231009   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231009   gcc  
x86_64                randconfig-002-20231009   gcc  
x86_64                randconfig-003-20231009   gcc  
x86_64                randconfig-004-20231009   gcc  
x86_64                randconfig-005-20231009   gcc  
x86_64                randconfig-006-20231009   gcc  
x86_64                randconfig-011-20231009   gcc  
x86_64                randconfig-012-20231009   gcc  
x86_64                randconfig-013-20231009   gcc  
x86_64                randconfig-014-20231009   gcc  
x86_64                randconfig-015-20231009   gcc  
x86_64                randconfig-016-20231009   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
