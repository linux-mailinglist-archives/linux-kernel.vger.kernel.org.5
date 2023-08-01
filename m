Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE876B007
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjHAJ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHAJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:56:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79222E7D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690883790; x=1722419790;
  h=date:from:to:cc:subject:message-id;
  bh=wgWQsg2Q3xIGYG981kdcpnbeECyEfcAQg3zjhu5Mo+0=;
  b=HHzoTQmON1dM+gxQ77Ga+n2r9lJf6gDoHvwnayudQ6cQfo6jVicTli2X
   aZBOvPjYc6xXEg2o6KBbJONHNT6f257HYQWOlnFUzOh5FYClU1cmKDqdZ
   u8iTJf1qUDx4tJgZA5DcCVhTqnasOhtKHC9ME+X6aGVOLCQy0DocDbVzo
   cY85+G/stvHq6JIF3jMd+DS3NZ+9Noku0ezEX4HcCJmLAxdP5OMPXOTZs
   gQc2+WNf/8pGA8daa2X561COecFU7loCJbs9xKV1LpXujqg9ZYNerTmat
   dmKL/PtaRbCBONRXi/A38/HItvAidBuEVsRX1Xmdlg4qr0s3go2Zz0YGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="433094774"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="433094774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 02:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728631422"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="728631422"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 02:56:27 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQm78-0000Ab-2j;
        Tue, 01 Aug 2023 09:56:26 +0000
Date:   Tue, 01 Aug 2023 17:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230731] BUILD REGRESSION
 686a448268382aefe178130cd2b582db09b14aeb
Message-ID: <202308011728.yuCjRewL-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230731
branch HEAD: 686a448268382aefe178130cd2b582db09b14aeb  cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308010320.Wqt7lyc4-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
arch/sparc/include/asm/string.h:15:25: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
arch/sparc/mm/init_64.c:3073:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
drivers/gpu/drm/sun4i/sun8i_tcon_top.c:204:19: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:17: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/spi/spi-stm32.c:1808:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: writing 4 bytes into a region of size between 18446744073709551613 and 2 [-Wstringop-overflow=]
include/linux/iio/buffer.h:42:46: warning: array subscript 'int64_t {aka long long int}[0]' is partly outside array bounds of 's16[1]' {aka 'short int[1]'} [-Warray-bounds]
include/linux/list.h:73:19: warning: array subscript 0 is outside array bounds of 'struct list_head[0]' [-Warray-bounds]
kernel/bpf/net_namespace.c:437:27: warning: array subscript [0, 1] is outside array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]
sound/core/ump.c:716:25: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:writing-bytes-into-a-region-of-size
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arc-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arm-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arm-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arm64-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- i386-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- i386-randconfig-i006-20230731
|   `-- sound-core-ump.c:warning:array-subscript-struct-snd_ump_block_info-is-partly-outside-array-bounds-of-char
|-- m68k-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- m68k-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- parisc-allyesconfig
|   |-- drivers-net-ethernet-broadcom-bnxt-bnxt_dcb.c:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- powerpc-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- riscv-allmodconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- riscv-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- s390-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- s390-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- sh-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|   `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-string.h:warning:writing-bytes-into-a-region-of-size
|   |-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- sparc64-randconfig-r021-20230731
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- sparc64-randconfig-r035-20230731
|   |-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
|-- x86_64-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- x86_64-buildonly-randconfig-r002-20230731
|   |-- drivers-gpu-drm-sun4i-sun8i_tcon_top.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- drivers-spi-spi-stm32.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size-between-and
`-- x86_64-randconfig-x015-20230731
    `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head

elapsed time: 727m

configs tested: 104
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230731   gcc  
arm                  randconfig-r025-20230731   gcc  
arm                  randconfig-r032-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230731   clang
arm64                randconfig-r036-20230731   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230731   clang
hexagon              randconfig-r026-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230731   gcc  
riscv                randconfig-r023-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230731   clang
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230731   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r021-20230731   gcc  
sparc64              randconfig-r035-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r034-20230731   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
