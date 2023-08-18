Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7A7806C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358398AbjHRH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358460AbjHRH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:56:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB363A96
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692345375; x=1723881375;
  h=date:from:to:cc:subject:message-id;
  bh=hGuTDlk0eS2bToy7bKin0hXDZYv+jTlo4/D0r3U0KJQ=;
  b=Y0pE6GV8o0QOmap2rotnYLJGI8WF6kiwJTm4b0njBvU26lCX25vZ1JdZ
   TD1O9t6Hj6GQ/82TZEASB18fZF+FsgKO4d6uX2VXwdxRakoIYJ6iR+PpD
   Q8GE6LvHZkH5u/6Vetj6EblkdLtPZpus+el3JsfS0ug6Bpslnnn2CjqmS
   9g1oiLD5LnLR64pYxBz/E+e9SCWiVZ1HgYBgLjhiTkxehsA0nDGSo5Nyp
   3O7Wz5WTbHyagm30a8WwIxG0KvC1DmW8yx7ygR6idHD5TQxcMTF2xjmMB
   52h8mWS49CxWy3nrwKdD03h2zvs7fBSSJ3Ma6OfubEx03ycYdYvp1/k3A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353344742"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="353344742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764477671"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="764477671"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 00:56:05 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWuKy-0002F6-37;
        Fri, 18 Aug 2023 07:56:04 +0000
Date:   Fri, 18 Aug 2023 15:55:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230817] BUILD SUCCESS WITH
 WARNING dbd3e479335bc8b09ea540102109ac38b0a73336
Message-ID: <202308181544.cTQDCUcQ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230817
branch HEAD: dbd3e479335bc8b09ea540102109ac38b0a73336  net: sched: cls_u32: Fix allocation in u32_init()

Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/io.h:129:9: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
arch/loongarch/include/asm/atomic.h:174:9: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' forming offset [132, 257] is out of the bounds [0, 132] of object 'send_data' with type 'u8[132]' {aka 'unsigned char[132]'} [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'unsigned char[2147483647]' [-Warray-bounds]
lib/vsprintf.c:2893:33: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
mm/mempolicy.c:3117:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- arc-randconfig-r043-20230818
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- loongarch-randconfig-r001-20230818
|   `-- arch-loongarch-include-asm-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
|-- mips-randconfig-r012-20230818
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-unsigned-char
|-- sparc-randconfig-r026-20230818
|   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-forming-offset-is-out-of-the-bounds-of-object-send_data-with-type-u8-aka-unsigned-char
`-- x86_64-defconfig
    |-- lib-vsprintf.c:warning:writing-byte-into-a-region-of-size
    `-- mm-mempolicy.c:warning:writing-byte-into-a-region-of-size

elapsed time: 845m

configs tested: 111
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230818   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230818   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r014-20230818   gcc  
arm                  randconfig-r046-20230818   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r023-20230818   clang
hexagon              randconfig-r033-20230818   clang
hexagon              randconfig-r041-20230818   clang
hexagon              randconfig-r045-20230818   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230818   gcc  
i386                 randconfig-i002-20230818   gcc  
i386                 randconfig-i003-20230818   gcc  
i386                 randconfig-i004-20230818   gcc  
i386                 randconfig-i005-20230818   gcc  
i386                 randconfig-i006-20230818   gcc  
i386                 randconfig-i011-20230818   clang
i386                 randconfig-i012-20230818   clang
i386                 randconfig-i013-20230818   clang
i386                 randconfig-i014-20230818   clang
i386                 randconfig-i015-20230818   clang
i386                 randconfig-i016-20230818   clang
i386                 randconfig-r022-20230818   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230818   gcc  
loongarch            randconfig-r035-20230818   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r003-20230818   gcc  
microblaze           randconfig-r024-20230818   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230818   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230818   gcc  
nios2                randconfig-r006-20230818   gcc  
openrisc             randconfig-r004-20230818   gcc  
openrisc             randconfig-r032-20230818   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r016-20230818   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230818   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230818   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r034-20230818   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230818   gcc  
sparc                randconfig-r026-20230818   gcc  
sparc64              randconfig-r025-20230818   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230818   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230818   gcc  
x86_64               randconfig-r013-20230818   clang
x86_64               randconfig-x001-20230818   clang
x86_64               randconfig-x002-20230818   clang
x86_64               randconfig-x003-20230818   clang
x86_64               randconfig-x004-20230818   clang
x86_64               randconfig-x005-20230818   clang
x86_64               randconfig-x006-20230818   clang
x86_64               randconfig-x011-20230818   gcc  
x86_64               randconfig-x012-20230818   gcc  
x86_64               randconfig-x013-20230818   gcc  
x86_64               randconfig-x014-20230818   gcc  
x86_64               randconfig-x015-20230818   gcc  
x86_64               randconfig-x016-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
