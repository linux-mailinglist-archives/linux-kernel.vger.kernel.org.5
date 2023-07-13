Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3975191F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjGMGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjGMGxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:53:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2BE5F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689231221; x=1720767221;
  h=date:from:to:cc:subject:message-id;
  bh=Ks3t0WAdry2hFW6Bohn/IKwa1vwrm/QZYzAa+1LnYrM=;
  b=i0VniVed3A7mU9eLquFHx+IcXrE8TUIOH9mERaWf3cx5GTPHo1EnD5uC
   MwViNKImYil4kWyQlO8ZU8WmUc1HT+ChV6VcH5SH1dMk7mgl7wOrNpt4k
   NYSc6V9w6njt2QRiJYhxCx044Or3l6EtUbN0hl85yj5K3oTUZMTFNiYdC
   Iz3Eb/YR+xGwwHlQ1YYbc9MfcplsXujfKzwru/6DrBRJc2Qyn9J93W/6g
   EOEEVu+dOzlAmzOFav9LvgUxeHYJg4QkfhqbQzL3ibmKu3pCK9rlv/cXu
   qglV/U5EEjkwozUsYdDeGlkxS35IMTINvNZQR4siuzioEKfVvznAYfXTZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="368640246"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="368640246"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 23:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="757054963"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="757054963"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2023 23:53:39 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJqCp-0006KJ-0R;
        Thu, 13 Jul 2023 06:53:39 +0000
Date:   Thu, 13 Jul 2023 14:52:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230712] BUILD REGRESSION
 88351e5cbaffd248445e625adc8f97b5850eac0a
Message-ID: <202307131456.KdNHIIxj-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230712
branch HEAD: 88351e5cbaffd248445e625adc8f97b5850eac0a  udf: Fix -Wstringop-overflow warnings

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307130628.xn3HZQKC-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[22]' [-Warray-bounds]
fs/jffs2/summary.c:79:73: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[22]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'unsigned char[2147483647]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r043-20230710
|   |-- fs-jffs2-nodelist.h:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|   `-- fs-jffs2-summary.c:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|-- i386-buildonly-randconfig-r006-20230710
|   |-- fs-jffs2-nodelist.h:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|   `-- fs-jffs2-summary.c:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|-- mips-gcw0_defconfig
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-unsigned-char
`-- sparc-allyesconfig
    `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char

elapsed time: 725m

configs tested: 117
configs skipped: 2

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r015-20230712   gcc  
arm                  randconfig-r046-20230710   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230712   gcc  
hexagon              randconfig-r003-20230712   clang
hexagon              randconfig-r035-20230712   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i016-20230712   clang
i386                 randconfig-r024-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230712   gcc  
m68k                 randconfig-r013-20230712   gcc  
microblaze           randconfig-r005-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                 randconfig-r031-20230712   clang
mips                 randconfig-r032-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
openrisc             randconfig-r022-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230712   gcc  
parisc               randconfig-r036-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc              randconfig-r006-20230712   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230712   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230712   gcc  
sparc                randconfig-r021-20230712   gcc  
sparc64              randconfig-r023-20230712   gcc  
sparc64              randconfig-r026-20230712   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230712   clang
um                   randconfig-r016-20230712   gcc  
um                   randconfig-r025-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
