Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7B7BD2BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbjJIFNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIFNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:13:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CE9F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696828420; x=1728364420;
  h=date:from:to:cc:subject:message-id;
  bh=uwRVDEAabDHlBHAdW6rT9web4r5LziGeBKdMynGZUK4=;
  b=ShLmFt1kWDRz2L3H6eVlFcPD7N+tBdoHQXF9T7+786uZNof6PGUN25c/
   oCFMBj6hsCxZRxpxnBJ5DRqxWGr6XTgZB2XDnYirHEHLuwkUppgSTQc2f
   Lmc0msUKHXlZP9PSijJPcsBEn6ESPH1mC8s8EWCNyoZtQN/GrQ4R4pRPo
   iDHJ36DwbJWCEeX/WfzBuSifTC3UuStdX1oXbXxE6F4dbRzvmjbYU/oBD
   5eCrat/n+MBFuk/wDp5PgaVYeEV47A+XwxctjB7z6LHU1zC5rUYQ+5yrd
   Q/SGtaRDwRlaX3CHIoMWSTTlr/0DWr9PtgK/iipxlSKTcWHF6BID6O61X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386910476"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386910476"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="729543793"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="729543793"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2023 22:13:38 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpiaG-00063L-21;
        Mon, 09 Oct 2023 05:13:36 +0000
Date:   Mon, 09 Oct 2023 13:13:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nolibc-merge.2023.10.08a] BUILD SUCCESS
 553e6deddc3d191508db2526f3644dafb296096c
Message-ID: <202310091359.xUJ6DE2T-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nolibc-merge.2023.10.08a
branch HEAD: 553e6deddc3d191508db2526f3644dafb296096c  Merge branches 'nolibc-fixes.2023.10.08a' and 'nolibc-next.2023.10.05a' into HEAD

elapsed time: 727m

configs tested: 139
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
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
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
powerpc                     ep8248e_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
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
sh                           se7751_defconfig   gcc  
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
x86_64                randconfig-071-20231009   gcc  
x86_64                randconfig-072-20231009   gcc  
x86_64                randconfig-073-20231009   gcc  
x86_64                randconfig-074-20231009   gcc  
x86_64                randconfig-075-20231009   gcc  
x86_64                randconfig-076-20231009   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
