Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCC76C7D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHBICq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjHBICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:02:32 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B171BE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690963349; x=1722499349;
  h=date:from:to:cc:subject:message-id;
  bh=tOABhvM6y7pC3yiGRgr/ACaBl/eEO+I9QWkNn+3JroM=;
  b=bQyxo+Ly8km8q+DYniDBKGHFN2h+h+la7qJGC6EeFRs8FFEGMj8PZHRz
   42TTuxJvvYgFFywG26zrZf4ibk7VNwbAAf99PkdYewmc5JWOaky8lioSk
   NcLM/rYF8579BbqImXOVr3xAjnLQGRMX41pk206EIcLYAeCYCXIrbRHbk
   lRFlVSUIvuj7H6KzCumHBG0pKm4AZBxP55mq1/qAQb0kSSRFa7Y5olzJ2
   P8E/nubWgWoTXW/fkaqpytQ2oFk7TgmGPGG3mXkNRzqAFEnzdk7Dqn0G7
   X52Wp6dw73UyB0J3XN+k5WrAkLFgAr6PgiCvhPynXYZI7ronjipLMcwwx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="354433376"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="354433376"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975592957"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="975592957"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2023 01:02:19 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR6oE-00011N-2q;
        Wed, 02 Aug 2023 08:02:18 +0000
Date:   Wed, 02 Aug 2023 16:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e6267a943e97479fc9f2ee6e5ff28464f57be917
Message-ID: <202308021618.IcnvFk1r-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e6267a943e97479fc9f2ee6e5ff28464f57be917  refscale: Fix misplaced data re-read

elapsed time: 722m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230731   gcc  
alpha                randconfig-r016-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r043-20230802   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r046-20230802   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230731   gcc  
csky                 randconfig-r022-20230801   gcc  
hexagon              randconfig-r041-20230802   clang
hexagon              randconfig-r045-20230802   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-r015-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230801   clang
mips                 randconfig-r032-20230731   clang
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230801   gcc  
nios2                randconfig-r035-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230801   clang
riscv                randconfig-r042-20230802   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230801   clang
s390                 randconfig-r044-20230802   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230801   gcc  
sparc                randconfig-r034-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230731   clang
x86_64               randconfig-r036-20230731   gcc  
x86_64               randconfig-x001-20230802   gcc  
x86_64               randconfig-x002-20230802   gcc  
x86_64               randconfig-x003-20230802   gcc  
x86_64               randconfig-x004-20230802   gcc  
x86_64               randconfig-x005-20230802   gcc  
x86_64               randconfig-x006-20230802   gcc  
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230801   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
