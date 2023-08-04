Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D776F8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjHDEGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjHDEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90A3C28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691121966; x=1722657966;
  h=date:from:to:cc:subject:message-id;
  bh=ZLkfxBBxjZ+HmgP+VVrx6Mn4ODPA1qIG01Bf+MjSrgA=;
  b=JIXdcQ2D9Dol/LKdFrWDfu4Sq5prjrvwWPDgcJxl5MPznO3Ao11szevN
   V+UH/LsVuboIQXWVBKE4ZPkxycW/uQuWshcRqeRsHLJoajGX6H0hswhl4
   yhJpU4cmf9kBcSeB5lyzkzhHiNc1T5L7+o2sW2gIYeB3jc9qcILTd5IWj
   Apsc/BcVnRpUja6asJo69HoYtqJr7awNN1LKHsJCxdav1bjyOJBpe8OYl
   PUX3iY51KcDxoZDnRJtLuc7laGoo7qvmu+rQSmZLMr/Ew3cJdzO9AagIa
   f/aDI8PonQml8DhOI7Q3YHMF146ze/bszrgX7puTHqrTwKCH+Dj/jCzY+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370049602"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370049602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873201817"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 21:06:05 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRm4g-0002bP-1g;
        Fri, 04 Aug 2023 04:06:02 +0000
Date:   Fri, 04 Aug 2023 12:05:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230731] BUILD REGRESSION
 7c2ff7e1f2ed48f8e189b3d1bafcbf675a7aad0c
Message-ID: <202308041216.4aKd7zcq-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230731
branch HEAD: 7c2ff7e1f2ed48f8e189b3d1bafcbf675a7aad0c  eth: bnxt: Fix -Wstringop-overflow warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308010320.Wqt7lyc4-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: writing 12 bytes into a region of size 0 [-Wstringop-overflow=]
arch/parisc/mm/init.c:285:46: warning: array subscript -1074790400 is outside array bounds of 'char[]' [-Warray-bounds]
arch/parisc/mm/init.c:285:46: warning: array subscript -269484032 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: writing 12 bytes into a region of size 0 [-Wstringop-overflow=]
arch/sparc/mm/init_64.c:3073:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
drivers/gpu/drm/sun4i/sun8i_tcon_top.c:204:19: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:135:17: warning: writing 12 bytes into a region of size 0 [-Wstringop-overflow=]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/soc/qcom/llcc-qcom.c:1038:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/spi/spi-stm32.c:1808:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
include/asm-generic/io.h:116:16: warning: array subscript 0 is outside array bounds of 'const volatile void[0]' [-Warray-bounds]
include/asm-generic/io.h:150:38: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 12 bytes into a region of size 0 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: writing 4 bytes into a region of size between 18446744073709551613 and 2 [-Wstringop-overflow=]
include/linux/iio/buffer.h:42:46: warning: array subscript 'int64_t {aka long long int}[0]' is partly outside array bounds of 's16[1]' {aka 'short int[1]'} [-Warray-bounds]
include/linux/list.h:73:19: warning: array subscript 0 is outside array bounds of 'struct list_head[0]' [-Warray-bounds]
kernel/bpf/net_namespace.c:437:27: warning: array subscript [0, 1] is outside array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]
sound/core/ump.c:716:25: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
sound/soc/sunxi/sun8i-codec-analog.c:760:19: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
sound/soc/tegra/tegra_asoc_machine.c:486:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- arch-alpha-include-asm-string.h:warning:writing-bytes-into-a-region-of-size
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:writing-bytes-into-a-region-of-size
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- alpha-randconfig-r036-20230801
|   `-- arch-alpha-include-asm-string.h:warning:writing-bytes-into-a-region-of-size
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
|-- m68k-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- m68k-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- microblaze-randconfig-r001-20230801
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|-- microblaze-randconfig-r003-20230801
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- microblaze-randconfig-r093-20230730
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- openrisc-randconfig-r012-20230803
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- openrisc-randconfig-r016-20230803
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|   `-- sound-core-ump.c:warning:array-subscript-struct-snd_ump_block_info-is-partly-outside-array-bounds-of-char
|-- openrisc-randconfig-r024-20230731
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- openrisc-randconfig-r034-20230801
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- openrisc-randconfig-r081-20230730
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- openrisc-virt_defconfig
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- parisc-allyesconfig
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-net-ethernet-broadcom-bnxt-bnxt_dcb.c:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- parisc-defconfig
|   `-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|-- parisc-randconfig-r006-20230801
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-soc-qcom-llcc-qcom.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- sound-soc-sunxi-sun8i-codec-analog.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   `-- sound-soc-tegra-tegra_asoc_machine.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|-- parisc64-defconfig
|   `-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|-- powerpc-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- powerpc-allyesconfig
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
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
|-- sparc-defconfig
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- sparc-randconfig-r015-20230803
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- sparc-randconfig-r033-20230801
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- sparc64-randconfig-r011-20230803
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- sparc64-randconfig-r031-20230801
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- x86_64-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- x86_64-buildonly-randconfig-r002-20230731
|   |-- drivers-gpu-drm-sun4i-sun8i_tcon_top.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- drivers-spi-spi-stm32.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-x011-20230731
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
`-- x86_64-randconfig-x015-20230731
    `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head

elapsed time: 847m

configs tested: 117
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230801   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r014-20230803   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r046-20230731   gcc  
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230803   clang
arm64                randconfig-r026-20230731   clang
csky                                defconfig   gcc  
hexagon              randconfig-r025-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230802   clang
i386                 randconfig-i002-20230802   clang
i386                 randconfig-i003-20230802   clang
i386                 randconfig-i004-20230802   clang
i386                 randconfig-i005-20230802   clang
i386                 randconfig-i006-20230802   clang
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
m68k                       m5475evb_defconfig   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                 randconfig-r002-20230801   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r012-20230803   gcc  
openrisc             randconfig-r016-20230803   gcc  
openrisc             randconfig-r024-20230731   gcc  
openrisc             randconfig-r034-20230801   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r021-20230731   gcc  
sh                   randconfig-r022-20230731   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230803   gcc  
sparc                randconfig-r033-20230801   gcc  
sparc64              randconfig-r011-20230803   gcc  
sparc64              randconfig-r031-20230801   gcc  
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
xtensa               randconfig-r023-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
