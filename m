Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3C76E157
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjHCH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjHCH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22BF187
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691047684; x=1722583684;
  h=date:from:to:cc:subject:message-id;
  bh=cw1hkUbjeuW+pkC8yiMbYdrJuF3lvNo3gy7xYLX0qLw=;
  b=I/KkRVVxAWyKyryH/zO8VZez+fVrgXlKsSE1334uzuBN0Wssx6PzKKsF
   bjPINtHYe39AF2G58ncQxay9uLeanBSgX1ph+kipX5pz+9FpgE6sVRBiA
   KBJbfFDQO0XDc9o/ERlTwhmZCCEVepGnHuI+MV2xXT0mRVIy55yX7+4lt
   /UNsWl0vC/cHo53j6qZhwexQ7Dtexi8//awiV0zi3XHI69Aj/6VJ0RULo
   MGa2NxL7hxiMmDOKK6a/uztiInm6zIg3+gPxeTJkfsCKga6s+iHVIZFGn
   KEqc0RYj2pHfhRjBCiguJjme3Z8I1TE0g1rtcEI1rOvzA/EcdquovhaYw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372531614"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="372531614"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 00:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729455558"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="729455558"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2023 00:28:01 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRSkZ-0001rb-2h;
        Thu, 03 Aug 2023 07:27:59 +0000
Date:   Thu, 03 Aug 2023 15:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230731] BUILD REGRESSION
 fb53d89ede1aed6cca2a6cb73ffecb99fe1bcc65
Message-ID: <202308031558.MhRIyeiu-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230731
branch HEAD: fb53d89ede1aed6cca2a6cb73ffecb99fe1bcc65  RDMA/irdma: Replace one-element array with flexible-array member

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308010320.Wqt7lyc4-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
arch/loongarch/include/asm/atomic.h:174:9: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
arch/parisc/mm/init.c:285:46: warning: array subscript -269484032 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
arch/sparc/mm/init_64.c:3073:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
drivers/gpu/drm/sun4i/sun8i_tcon_top.c:204:19: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c:133:17: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/soc/qcom/llcc-qcom.c:1038:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/spi/spi-stm32.c:1808:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
include/asm-generic/io.h:116:16: warning: array subscript 0 is outside array bounds of 'const volatile void[0]' [-Warray-bounds]
include/asm-generic/io.h:150:38: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 12 bytes into a region of size 1 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: writing 4 bytes into a region of size between 18446744073709551613 and 2 [-Wstringop-overflow=]
include/linux/iio/buffer.h:42:46: warning: array subscript 'int64_t {aka long long int}[0]' is partly outside array bounds of 's16[1]' {aka 'short int[1]'} [-Warray-bounds]
include/linux/list.h:73:19: warning: array subscript 0 is outside array bounds of 'struct list_head[0]' [-Warray-bounds]
include/net/xfrm.h:1363:19: warning: array subscript 'xfrm_address_t[0]' is partly outside array bounds of '__be32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
kernel/bpf/net_namespace.c:437:27: warning: array subscript [0, 1] is outside array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]
sound/core/ump.c:716:25: warning: array subscript 'struct snd_ump_block_info[0]' is partly outside array bounds of 'char[20]' [-Warray-bounds]
sound/soc/sunxi/sun8i-codec-analog.c:760:19: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
sound/soc/tegra/tegra_asoc_machine.c:486:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/m68k/include/asm/io_no.h:23:72: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]

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
|-- i386-randconfig-i005-20230731
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
|-- i386-randconfig-i006-20230731
|   `-- sound-core-ump.c:warning:array-subscript-struct-snd_ump_block_info-is-partly-outside-array-bounds-of-char
|-- loongarch-randconfig-r052-20230802
|   `-- arch-loongarch-include-asm-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
|-- m68k-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- m68k-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- m68k-randconfig-r083-20230730
|   `-- arch-m68k-include-asm-io_no.h:warning:array-subscript-is-outside-array-bounds-of-volatile-u8-aka-volatile-unsigned-char
|-- microblaze-randconfig-r093-20230730
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- nios2-randconfig-r032-20230731
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- nios2-randconfig-r081-20230730
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- parisc-allyesconfig
|   |-- drivers-net-ethernet-broadcom-bnxt-bnxt_dcb.c:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- parisc-randconfig-r006-20230801
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-soc-qcom-llcc-qcom.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- sound-soc-sunxi-sun8i-codec-analog.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   `-- sound-soc-tegra-tegra_asoc_machine.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|-- parisc-randconfig-r026-20230731
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- include-net-xfrm.h:warning:array-subscript-xfrm_address_t-is-partly-outside-array-bounds-of-__be32-aka-unsigned-int
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
|-- sparc-defconfig
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- sparc64-randconfig-r035-20230731
|   |-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
|-- sparc64-randconfig-r054-20230802
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- x86_64-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- x86_64-buildonly-randconfig-r002-20230731
|   |-- drivers-gpu-drm-sun4i-sun8i_tcon_top.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- drivers-spi-spi-stm32.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-r004-20230801
|   `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head
|-- x86_64-randconfig-r005-20230801
|   `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head
|-- x86_64-randconfig-x011-20230731
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
`-- x86_64-randconfig-x015-20230731
    `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head

elapsed time: 722m

configs tested: 123
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230801   gcc  
alpha                randconfig-r024-20230731   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r011-20230801   gcc  
arm                  randconfig-r046-20230731   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
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
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230801   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230801   gcc  
m68k                 randconfig-r033-20230731   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r022-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230731   gcc  
openrisc             randconfig-r015-20230801   gcc  
openrisc             randconfig-r025-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc               randconfig-r026-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230801   clang
riscv                randconfig-r034-20230731   gcc  
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230801   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r035-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230801   clang
um                   randconfig-r014-20230801   gcc  
um                   randconfig-r031-20230731   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r004-20230801   gcc  
x86_64               randconfig-r005-20230801   gcc  
x86_64               randconfig-r021-20230731   clang
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
