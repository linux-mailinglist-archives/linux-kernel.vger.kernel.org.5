Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F9757A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGRLTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGRLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:19:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1B10F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689679184; x=1721215184;
  h=date:from:to:cc:subject:message-id;
  bh=X640t2cGX60YkCKudarfxfGg8XyKkrABYMklnQ3eUIM=;
  b=ZL62FSbDguPOHAQoKMyctJf7xq0iOGQLlqpjslOhlpjH+eTtFImWrOkq
   lu6/cEdgCgZ+HM8ralpmLmY3PZBYpd0iGFleQBmJEd6IsLhVXlgDuDi4h
   QQOCSOvqEyRi7Mi5COIAux9a++yOxT5vriAg6DWdNO89UlSQfXMjxLadK
   ZQ3zB9oyRj5+jROHMLw/wYOWxr5Pe6UrbGKBBFoA8fYpwWxeNZZtRvLUY
   7jQguyJ/GRw2ALMaU0D7WIfOe08W/j+KafQl31eG09vMzHsaXTL9NodMg
   Hn6YZj1Yxm02mTXPc03RUGHvKgmEnMbRikx0qhA/+Pq4nDeDDUjTLuGux
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="365053708"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="365053708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 04:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="758755948"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="758755948"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 04:19:42 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLik2-0000Yp-0J;
        Tue, 18 Jul 2023 11:19:42 +0000
Date:   Tue, 18 Jul 2023 19:19:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230717] BUILD REGRESSION
 584ee211a23e349a6478767544c518f04b6cf2bd
Message-ID: <202307181906.wR6z5ime-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230717
branch HEAD: 584ee211a23e349a6478767544c518f04b6cf2bd  fs: omfs: Fix -Wstringop-overflow warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307181615.iVlmV0s6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm64/kernel/setup.c:228:56: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
arch/parisc/mm/init.c:285:46: warning: array subscript -269484032 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
arch/s390/include/asm/ctl_reg.h:45:24: warning: array subscript 0 is outside array bounds of 'addrtype[0]' [-Warray-bounds]
arch/s390/include/asm/ptrace.h:95:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:472:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
drivers/gpu/drm/nouveau/dispnv04/dac.c:432:39: warning: array subscript -1 is below array bounds of 'uint32_t[4]' {aka 'unsigned int[4]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/object.c:161:9: warning: 'memcpy' specified bound between 4294967264 and 4294967287 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
drivers/hwmon/pc87360.c:341:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1194:25: warning: array subscript 1 is outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
fs/ext4/mballoc.c:812:33: warning: array subscript -1 is below array bounds of 'ext4_grpblk_t[]' {aka 'int[]'} [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/linux/fortify-string.h:59:33: warning: '__builtin_memset' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1206:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1256:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- arm-randconfig-r063-20230716
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_dpia.c:error:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_fixed_vs_pe_retimer.c:error:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r024-20230717
|   |-- arch-arm64-kernel-setup.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- parisc-generic-32bit_defconfig
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:warning:memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   |-- kernel-cgroup-cgroup.c:warning:css_set_hash-accessing-bytes-in-a-region-of-size
|   `-- kernel-cgroup-cgroup.c:warning:find_existing_css_set-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-r025-20230717
|   |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:warning:memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- parisc-randconfig-r081-20230717
|   `-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
|-- powerpc-randconfig-r026-20230717
|   |-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-ext4-mballoc.c:warning:array-subscript-is-below-array-bounds-of-ext4_grpblk_t-aka-int
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|   `-- fs-ext4-mballoc.c:warning:array-subscript-is-below-array-bounds-of-ext4_grpblk_t-aka-int
|-- s390-randconfig-r023-20230717
|   |-- arch-s390-include-asm-atomic_ops.h:warning:array-subscript-is-outside-array-bounds-of-int
|   |-- arch-s390-include-asm-ctl_reg.h:warning:array-subscript-is-outside-array-bounds-of-addrtype
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|-- s390-randconfig-r044-20230717
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-specified-bound-exceeds-maximum-object-size
|-- sparc-allmodconfig
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
`-- sparc-allyesconfig
    `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size

elapsed time: 721m

configs tested: 125
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230717   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r033-20230717   gcc  
arc                  randconfig-r043-20230717   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                  randconfig-r046-20230717   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230717   gcc  
arm64                randconfig-r031-20230717   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230717   gcc  
hexagon              randconfig-r041-20230717   clang
hexagon              randconfig-r045-20230717   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230717   clang
i386         buildonly-randconfig-r005-20230717   clang
i386         buildonly-randconfig-r006-20230717   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230717   clang
i386                 randconfig-i002-20230717   clang
i386                 randconfig-i003-20230717   clang
i386                 randconfig-i004-20230717   clang
i386                 randconfig-i005-20230717   clang
i386                 randconfig-i006-20230717   clang
i386                 randconfig-i011-20230717   gcc  
i386                 randconfig-i012-20230717   gcc  
i386                 randconfig-i013-20230717   gcc  
i386                 randconfig-i014-20230717   gcc  
i386                 randconfig-i015-20230717   gcc  
i386                 randconfig-i016-20230717   gcc  
i386                 randconfig-r005-20230717   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230717   gcc  
m68k                 randconfig-r004-20230717   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r014-20230717   gcc  
parisc               randconfig-r025-20230717   gcc  
parisc               randconfig-r034-20230717   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc              randconfig-r026-20230717   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230717   clang
riscv                randconfig-r042-20230717   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230717   gcc  
s390                 randconfig-r036-20230717   clang
s390                 randconfig-r044-20230717   gcc  
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r032-20230717   gcc  
sh                   randconfig-r035-20230717   gcc  
sh                           se7722_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230717   gcc  
sparc                randconfig-r015-20230717   gcc  
sparc                randconfig-r022-20230717   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230717   clang
um                   randconfig-r021-20230717   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230717   clang
x86_64       buildonly-randconfig-r002-20230717   clang
x86_64       buildonly-randconfig-r003-20230717   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230717   gcc  
x86_64               randconfig-x002-20230717   gcc  
x86_64               randconfig-x003-20230717   gcc  
x86_64               randconfig-x004-20230717   gcc  
x86_64               randconfig-x005-20230717   gcc  
x86_64               randconfig-x006-20230717   gcc  
x86_64               randconfig-x011-20230717   clang
x86_64               randconfig-x012-20230717   clang
x86_64               randconfig-x013-20230717   clang
x86_64               randconfig-x014-20230717   clang
x86_64               randconfig-x015-20230717   clang
x86_64               randconfig-x016-20230717   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa               randconfig-r013-20230717   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
