Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F127D8D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjJ0DGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0DGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D04129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698375962; x=1729911962;
  h=date:from:to:cc:subject:message-id;
  bh=VElzB7OJzWkIyYW/JIzkOnzu2emYx7frllVo8boYpKk=;
  b=KvC1vJYXjIsjK3Bgh7sloGE1LGduBewDiX6DD5RCj5yCh/vjgJqp8gb1
   Uf28ZCpvR1TtPed37Bp9VJa9SkQ279cbZo+f8EhG+F1n2NNlj1u1TQCLR
   u1wo87J1ujb3HKaN0unljwEKPX0ydkC8dKtJAQHfbgf06Hb74a2idIhqY
   chZ8Qtaougkr/pDF2qp+JMFO9txbVONy+FktUCe2a98aV5kWOeKO2hJP6
   ImrLThu1XVKdfjX2uk1IXALIv99FLuYOIle8higmwXQje1TUo/CLckZuV
   2ht5nMmMa7/A2fM78EciHeGRJA48qSpKMHwUvEeI/YAX5vHIP+NmLEQh8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451939428"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="451939428"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 20:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="829828254"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="829828254"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2023 20:06:00 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwDAc-000ANq-2F;
        Fri, 27 Oct 2023 03:05:58 +0000
Date:   Fri, 27 Oct 2023 11:05:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 0548eb067ed664b93043e033295ca71e3e706245
Message-ID: <202310271109.SXR43fIN-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 0548eb067ed664b93043e033295ca71e3e706245  x86/percpu: Return correct variable from current_top_of_stack()

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310270909.QBAOkiZP-lkp@intel.com

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
include/linux/radix-tree.h:260:9: sparse: sparse: too many errors

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-061-20231026
|   `-- arch-x86-include-asm-current.h:sparse:sparse:dereference-of-noderef-expression
|-- i386-randconfig-062-20231025
|   `-- arch-x86-include-asm-current.h:sparse:sparse:dereference-of-noderef-expression
|-- i386-randconfig-063-20231026
|   `-- arch-x86-include-asm-current.h:sparse:sparse:dereference-of-noderef-expression
|-- x86_64-randconfig-121-20231026
|   `-- arch-x86-include-asm-current.h:sparse:sparse:dereference-of-noderef-expression
|-- x86_64-randconfig-122-20231026
|   `-- include-linux-radix-tree.h:sparse:sparse:too-many-errors
|-- x86_64-randconfig-122-20231027
|   `-- arch-x86-include-asm-processor.h:sparse:sparse:dereference-of-noderef-expression
`-- x86_64-randconfig-123-20231026
    `-- arch-x86-include-asm-current.h:sparse:sparse:dereference-of-noderef-expression

elapsed time: 3497m

configs tested: 187
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
arc                   randconfig-001-20231025   gcc  
arc                   randconfig-001-20231026   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231025   gcc  
arm                         s3c6400_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231025   gcc  
i386         buildonly-randconfig-001-20231026   gcc  
i386         buildonly-randconfig-002-20231025   gcc  
i386         buildonly-randconfig-002-20231026   gcc  
i386         buildonly-randconfig-003-20231025   gcc  
i386         buildonly-randconfig-003-20231026   gcc  
i386         buildonly-randconfig-004-20231025   gcc  
i386         buildonly-randconfig-004-20231026   gcc  
i386         buildonly-randconfig-005-20231025   gcc  
i386         buildonly-randconfig-005-20231026   gcc  
i386         buildonly-randconfig-006-20231025   gcc  
i386         buildonly-randconfig-006-20231026   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231025   gcc  
i386                  randconfig-001-20231026   gcc  
i386                  randconfig-002-20231025   gcc  
i386                  randconfig-002-20231026   gcc  
i386                  randconfig-003-20231025   gcc  
i386                  randconfig-003-20231026   gcc  
i386                  randconfig-004-20231025   gcc  
i386                  randconfig-004-20231026   gcc  
i386                  randconfig-005-20231025   gcc  
i386                  randconfig-005-20231026   gcc  
i386                  randconfig-006-20231025   gcc  
i386                  randconfig-006-20231026   gcc  
i386                  randconfig-011-20231025   gcc  
i386                  randconfig-011-20231026   gcc  
i386                  randconfig-012-20231025   gcc  
i386                  randconfig-012-20231026   gcc  
i386                  randconfig-013-20231025   gcc  
i386                  randconfig-013-20231026   gcc  
i386                  randconfig-014-20231025   gcc  
i386                  randconfig-014-20231026   gcc  
i386                  randconfig-015-20231025   gcc  
i386                  randconfig-015-20231026   gcc  
i386                  randconfig-016-20231025   gcc  
i386                  randconfig-016-20231026   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231025   gcc  
loongarch             randconfig-001-20231026   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                        maltaup_defconfig   clang
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
powerpc                      ppc44x_defconfig   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231025   gcc  
riscv                 randconfig-001-20231026   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231025   gcc  
s390                  randconfig-001-20231026   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231025   gcc  
sparc                 randconfig-001-20231026   gcc  
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
x86_64       buildonly-randconfig-001-20231025   gcc  
x86_64       buildonly-randconfig-001-20231026   gcc  
x86_64       buildonly-randconfig-002-20231025   gcc  
x86_64       buildonly-randconfig-002-20231026   gcc  
x86_64       buildonly-randconfig-003-20231025   gcc  
x86_64       buildonly-randconfig-003-20231026   gcc  
x86_64       buildonly-randconfig-004-20231025   gcc  
x86_64       buildonly-randconfig-004-20231026   gcc  
x86_64       buildonly-randconfig-005-20231025   gcc  
x86_64       buildonly-randconfig-005-20231026   gcc  
x86_64       buildonly-randconfig-006-20231025   gcc  
x86_64       buildonly-randconfig-006-20231026   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231025   gcc  
x86_64                randconfig-001-20231026   gcc  
x86_64                randconfig-002-20231025   gcc  
x86_64                randconfig-002-20231026   gcc  
x86_64                randconfig-003-20231025   gcc  
x86_64                randconfig-003-20231026   gcc  
x86_64                randconfig-004-20231025   gcc  
x86_64                randconfig-004-20231026   gcc  
x86_64                randconfig-005-20231025   gcc  
x86_64                randconfig-005-20231026   gcc  
x86_64                randconfig-006-20231025   gcc  
x86_64                randconfig-006-20231026   gcc  
x86_64                randconfig-011-20231025   gcc  
x86_64                randconfig-011-20231026   gcc  
x86_64                randconfig-012-20231025   gcc  
x86_64                randconfig-012-20231026   gcc  
x86_64                randconfig-013-20231025   gcc  
x86_64                randconfig-013-20231026   gcc  
x86_64                randconfig-014-20231025   gcc  
x86_64                randconfig-014-20231026   gcc  
x86_64                randconfig-015-20231025   gcc  
x86_64                randconfig-015-20231026   gcc  
x86_64                randconfig-016-20231025   gcc  
x86_64                randconfig-016-20231026   gcc  
x86_64                randconfig-071-20231025   gcc  
x86_64                randconfig-072-20231025   gcc  
x86_64                randconfig-073-20231025   gcc  
x86_64                randconfig-074-20231025   gcc  
x86_64                randconfig-075-20231025   gcc  
x86_64                randconfig-076-20231025   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
