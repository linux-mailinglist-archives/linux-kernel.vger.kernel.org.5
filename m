Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5A77DC34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbjHPI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjHPI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:26:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953931990
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692174400; x=1723710400;
  h=date:from:to:cc:subject:message-id;
  bh=gH2h+fVR9JEEisbTB+Lu43Wt/PCzR1smR7yCAAKDXnA=;
  b=lzKL3+BRpU9OHIp79Ie3BJnsfm3ovHh7FIF91Uo5FgV/4HqEUHmMYSaK
   GYggcjJ9BU10p5/4/dFswfDsfIntdIxMXhyo+iGgJJU2r1FSmlO0PO6Ka
   ZkOhXXW5i/DqiiGj7aGHKcvdYGSSlYHSNPZpH5PeQQ+NNct7I+I6oLcEB
   LubjOUq8vTYzT5pvTde2aQ5uK2/LP3IxLWMXPvwGBa1zDcDUO+pllwLnB
   ULHSZoJ9VY+UIRytzPpYPZuqNoU4cEH7ciFI24tfqtpMFfOe6dcGzZehC
   o2b3LC+clHrHc6Vq0slOft5C/zVPKcxJoX22UuSv05PzP1YJyrF3HrftY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403454296"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="403454296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711037611"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711037611"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 01:26:26 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWBqB-00008Z-04;
        Wed, 16 Aug 2023 08:25:31 +0000
Date:   Wed, 16 Aug 2023 16:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230815] BUILD REGRESSION
 7d3ebbc1f4bfba0fdd9ade111e93edf6be617187
Message-ID: <202308161610.uARLhZlY-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230815
branch HEAD: 7d3ebbc1f4bfba0fdd9ade111e93edf6be617187  alpha: Replace one-element array with flexible-array member

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308160635.14367Mw4-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/sparc/mm/init_64.c:3088:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
drivers/hwmon/pc87360.c:341:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r006-20230816
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- arm64-allyesconfig
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- sparc-allyesconfig
|   |-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- sparc64-randconfig-r001-20230816
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
`-- sparc64-randconfig-r024-20230816
    `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char

elapsed time: 722m

configs tested: 96
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r035-20230816   gcc  
arc                  randconfig-r043-20230816   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r033-20230816   clang
arm                  randconfig-r046-20230816   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230816   clang
csky                                defconfig   gcc  
csky                 randconfig-r015-20230816   gcc  
hexagon              randconfig-r034-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230816   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230816   gcc  
m68k                 randconfig-r021-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230816   clang
nios2                               defconfig   gcc  
nios2                randconfig-r036-20230816   gcc  
openrisc             randconfig-r026-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230816   gcc  
parisc               randconfig-r022-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230816   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230816   gcc  
sh                   randconfig-r014-20230816   gcc  
sh                   randconfig-r031-20230816   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230816   gcc  
sparc64              randconfig-r024-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230816   clang
um                   randconfig-r016-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230816   gcc  
xtensa               randconfig-r023-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
