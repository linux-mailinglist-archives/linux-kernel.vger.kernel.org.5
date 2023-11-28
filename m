Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874AC7FCA69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbjK1XDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjK1XDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:03:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05712C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701212622; x=1732748622;
  h=date:from:to:cc:subject:message-id;
  bh=VDo9B81HjFSp//2uiP97gGkbJLHv+j9urez1rTWilJ8=;
  b=ZZsvj3Lb/r5q/ntizsKN/jxWOoczRE1tpe0gjSaf6iOyk0P5qgmbrISf
   1GWy0rcoRt0NvcfCBEjHaTWp0mmNWpay01uPjkF0lgVZ9xOTnGvCzlQbV
   wXprs8LWGFTuSwLoYH5G63OX0yNM4RBNACgdC6f2ts99bdciZaYqJ/v9k
   DfV6QPEieb7dqq2rrDWSxoUNLYOOhftEKzwhjFQRNxUAgNNDVPaQrINiL
   DkXJ2RibiKLJdXJl+bclH3+RBTzEqP+DGuHjTWmN6FanzeB9mHzYy4SOq
   7Ytq2qbsrn37YY0gc0kOSAQerPHWl2HT68xt3gNhuI8oKQFXpSAybURKO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479244361"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479244361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:03:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="912613884"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="912613884"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2023 15:03:40 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r877C-0008GF-2Y;
        Tue, 28 Nov 2023 23:03:38 +0000
Date:   Wed, 29 Nov 2023 07:03:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/next20231127-Warray-bounds] BUILD
 SUCCESS cb7d8700da3e4c763ac30bfa34ee7dc143bd2758
Message-ID: <202311290720.TzNYq81c-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/next20231127-Warray-bounds
branch HEAD: cb7d8700da3e4c763ac30bfa34ee7dc143bd2758  Makefile: Enable -Warray-bounds globally

Unverified Warning (likely false positive, please contact us if interested):

arch/sparc/mm/init_64.c:3088:31: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds=]
fs/bcachefs/chardev.c:570:44: warning: array subscript i is outside array bounds of 'struct bch_ioctl_dev_usage_type[0]' [-Warray-bounds=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- arc-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- arc-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- arm-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- arm-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- csky-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- csky-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- csky-randconfig-002-20231128
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- loongarch-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- m68k-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- m68k-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- microblaze-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- microblaze-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- mips-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- nios2-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- nios2-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- riscv-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- riscv-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- s390-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- s390-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sh-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sh-allyesconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sh-randconfig-002-20231128
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sparc-allmodconfig
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sparc-randconfig-r133-20231128
|   |-- arch-sparc-mm-init_64.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sparc64-allmodconfig
|   |-- arch-sparc-mm-init_64.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sparc64-allyesconfig
|   |-- arch-sparc-mm-init_64.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
|-- sparc64-randconfig-001-20231128
|   |-- arch-sparc-mm-init_64.c:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type
`-- sparc64-randconfig-002-20231128
    |-- arch-sparc-mm-init_64.c:warning:array-subscript-is-outside-array-bounds-of-char
    `-- fs-bcachefs-chardev.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-bch_ioctl_dev_usage_type

elapsed time: 1487m

configs tested: 139
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231128   gcc  
arc                   randconfig-002-20231128   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231128   clang
arm                   randconfig-002-20231128   clang
arm                   randconfig-003-20231128   clang
arm                   randconfig-004-20231128   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                 randconfig-001-20231128   clang
arm64                 randconfig-002-20231128   clang
arm64                 randconfig-003-20231128   clang
arm64                 randconfig-004-20231128   clang
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
csky                  randconfig-001-20231128   gcc  
csky                  randconfig-002-20231128   gcc  
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20231128   clang
hexagon               randconfig-002-20231128   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231128   clang
i386         buildonly-randconfig-002-20231128   clang
i386         buildonly-randconfig-003-20231128   clang
i386         buildonly-randconfig-004-20231128   clang
i386         buildonly-randconfig-005-20231128   clang
i386         buildonly-randconfig-006-20231128   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231128   clang
i386                  randconfig-002-20231128   clang
i386                  randconfig-003-20231128   clang
i386                  randconfig-004-20231128   clang
i386                  randconfig-005-20231128   clang
i386                  randconfig-006-20231128   clang
i386                  randconfig-011-20231128   gcc  
i386                  randconfig-012-20231128   gcc  
i386                  randconfig-013-20231128   gcc  
i386                  randconfig-014-20231128   gcc  
i386                  randconfig-015-20231128   gcc  
i386                  randconfig-016-20231128   gcc  
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231128   gcc  
loongarch             randconfig-002-20231128   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          malta_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231128   gcc  
nios2                 randconfig-002-20231128   gcc  
openrisc                         allyesconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231128   gcc  
parisc                randconfig-002-20231128   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc               randconfig-001-20231128   clang
powerpc               randconfig-002-20231128   clang
powerpc               randconfig-003-20231128   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231128   clang
powerpc64             randconfig-002-20231128   clang
powerpc64             randconfig-003-20231128   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231128   clang
riscv                 randconfig-002-20231128   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231128   gcc  
s390                  randconfig-002-20231128   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231128   gcc  
sh                    randconfig-002-20231128   gcc  
sh                          rsk7264_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231128   gcc  
sparc64               randconfig-002-20231128   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231128   clang
um                    randconfig-002-20231128   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231128   clang
x86_64       buildonly-randconfig-002-20231128   clang
x86_64       buildonly-randconfig-003-20231128   clang
x86_64       buildonly-randconfig-004-20231128   clang
x86_64       buildonly-randconfig-005-20231128   clang
x86_64       buildonly-randconfig-006-20231128   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231128   gcc  
x86_64                randconfig-002-20231128   gcc  
x86_64                randconfig-003-20231128   gcc  
x86_64                randconfig-004-20231128   gcc  
x86_64                randconfig-005-20231128   gcc  
x86_64                randconfig-006-20231128   gcc  
x86_64                randconfig-011-20231128   clang
x86_64                randconfig-012-20231128   clang
x86_64                randconfig-013-20231128   clang
x86_64                randconfig-014-20231128   clang
x86_64                randconfig-015-20231128   clang
x86_64                randconfig-016-20231128   clang
x86_64                randconfig-071-20231128   clang
x86_64                randconfig-072-20231128   clang
x86_64                randconfig-073-20231128   clang
x86_64                randconfig-074-20231128   clang
x86_64                randconfig-075-20231128   clang
x86_64                randconfig-076-20231128   clang
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231128   gcc  
xtensa                randconfig-002-20231128   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
