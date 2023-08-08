Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1277467C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjHHS5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjHHS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3731D3FA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515024; x=1723051024;
  h=date:from:to:cc:subject:message-id;
  bh=T+O0D2jg/XZ91+6dzsOol+OcNtKaDrVfDmrRlyURUPw=;
  b=PeRNLSj/f4JMB2NojkyNuTwhn6F2qGwlyMP1QJUAXLiMd8SpFIQ4/JGV
   xQi4vFwY1qpYCjMMNCvRl1Au93ye82rZ5By+ziBcyT0zigdp1QCRLpsbh
   FkwUgmUS0NltTJ+cLpk8UDhWEKfCzg66+Cl2QRVrdNd6k5fUPP+OsGf5n
   L1QCdZx2S5YPjD9c3DwChOhf+lOGaf+kuU92u1+ooF1CITFC9/Ng6BlzR
   D9zJCBQV4CDI08aYRf7tSJCtnj9yJrA5Sm7pQir+n2Y+LL9Z4BJzBOncD
   xolaaujaoC7hcM7F5Na/AGqX3kFTNA9d+ClihVDhoWIkumLnxKbYqVqlf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360806180"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360806180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 21:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731227695"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="731227695"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2023 21:32:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTEOe-000563-1K;
        Tue, 08 Aug 2023 04:32:40 +0000
Date:   Tue, 08 Aug 2023 12:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230731] BUILD REGRESSION
 83c48427efe530e35feb57e55873e5e7dda20cbe
Message-ID: <202308081237.0dXVRoH5-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230731
branch HEAD: 83c48427efe530e35feb57e55873e5e7dda20cbe  bnxt_en: Fix W=stringop-overflow warning in bnxt_dcb.c

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308010320.Wqt7lyc4-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/io.h:150:9: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
arch/parisc/mm/init.c:285:46: warning: array subscript -269484032 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
arch/sparc/mm/init_64.c:3073:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' writing 255 bytes into a region of size 129 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:504:25: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
include/asm-generic/bitops/generic-non-atomic.h:128:27: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
include/asm-generic/io.h:116:16: warning: array subscript 0 is outside array bounds of 'const volatile void[0]' [-Warray-bounds]
include/asm-generic/io.h:150:38: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
include/linux/iio/buffer.h:42:46: warning: array subscript 'int64_t {aka long long int}[0]' is partly outside array bounds of 's16[1]' {aka 'short int[1]'} [-Warray-bounds]
include/linux/list.h:73:19: warning: array subscript 0 is outside array bounds of 'struct list_head[0]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arc-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arc-randconfig-r043-20230807
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arm-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- arm64-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- i386-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- i386-buildonly-randconfig-r004-20230807
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size
|-- m68k-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- m68k-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- mips-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- openrisc-randconfig-r023-20230807
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- parisc-allyesconfig
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- parisc-defconfig
|   `-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|-- parisc64-defconfig
|   `-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|-- powerpc-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- riscv-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- riscv-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- riscv-randconfig-r004-20230807
|   `-- include-asm-generic-bitops-generic-non-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
|-- s390-allmodconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- s390-allyesconfig
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- sh-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|   `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head
|-- sparc-allyesconfig
|   |-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- sparc-defconfig
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- sparc-randconfig-r026-20230807
|   |-- arch-sparc-kernel-irq_32.c:error:array-subscript-is-outside-array-bounds-of-struct-tt_entry
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- um-randconfig-r014-20230807
|   |-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- include-asm-generic-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- x86_64-allyesconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-iio-buffer.h:warning:array-subscript-int64_t-aka-long-long-int-is-partly-outside-array-bounds-of-s16-aka-short-int
|-- x86_64-buildonly-randconfig-r002-20230807
|   `-- include-linux-list.h:warning:array-subscript-is-outside-array-bounds-of-struct-list_head
`-- xtensa-randconfig-r024-20230807
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_fixed_vs_pe_retimer.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size

elapsed time: 725m

configs tested: 105
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230807   gcc  
arc                  randconfig-r043-20230807   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230807   clang
arm                  randconfig-r046-20230807   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230807   clang
arm64                randconfig-r036-20230807   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r031-20230807   clang
hexagon              randconfig-r041-20230807   clang
hexagon              randconfig-r045-20230807   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230807   gcc  
i386         buildonly-randconfig-r005-20230807   gcc  
i386         buildonly-randconfig-r006-20230807   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230807   gcc  
i386                 randconfig-i002-20230807   gcc  
i386                 randconfig-i003-20230807   gcc  
i386                 randconfig-i004-20230807   gcc  
i386                 randconfig-i005-20230807   gcc  
i386                 randconfig-i006-20230807   gcc  
i386                 randconfig-i011-20230807   clang
i386                 randconfig-i012-20230807   clang
i386                 randconfig-i013-20230807   clang
i386                 randconfig-i014-20230807   clang
i386                 randconfig-i015-20230807   clang
i386                 randconfig-i016-20230807   clang
i386                 randconfig-r006-20230807   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230807   gcc  
loongarch            randconfig-r034-20230807   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230807   gcc  
openrisc             randconfig-r023-20230807   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r013-20230807   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230807   gcc  
riscv                randconfig-r042-20230807   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230807   clang
s390                 randconfig-r044-20230807   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230807   gcc  
sh                   randconfig-r025-20230807   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230807   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230807   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230807   gcc  
x86_64       buildonly-randconfig-r002-20230807   gcc  
x86_64       buildonly-randconfig-r003-20230807   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230807   clang
x86_64               randconfig-x002-20230807   clang
x86_64               randconfig-x003-20230807   clang
x86_64               randconfig-x004-20230807   clang
x86_64               randconfig-x005-20230807   clang
x86_64               randconfig-x006-20230807   clang
x86_64               randconfig-x011-20230807   gcc  
x86_64               randconfig-x012-20230807   gcc  
x86_64               randconfig-x013-20230807   gcc  
x86_64               randconfig-x014-20230807   gcc  
x86_64               randconfig-x015-20230807   gcc  
x86_64               randconfig-x016-20230807   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r024-20230807   gcc  
xtensa               randconfig-r033-20230807   gcc  
xtensa               randconfig-r035-20230807   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
