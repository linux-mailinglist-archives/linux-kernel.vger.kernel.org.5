Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4C7576D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGRIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjGRIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:41:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EA135
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689669670; x=1721205670;
  h=date:from:to:cc:subject:message-id;
  bh=b5UmKU3ABHGA9eto6Nf5invT9kepy5w8t6z+hWBLuuU=;
  b=Xp2Pc74USCGChSPqItjR/2bGp4nOXMjy7oHJ4jerpXqbDEv91stDhEV0
   BvZnYXU544eCJXfi53dAD/ebeHLe3N2k6oLumibs7iwHDzyZmANZICmf3
   mQU0KzB0rSR3yhAwxKi+SPhpssDoXKMcIOr2W+84RaHQ4RWlDypX8wytA
   3ZUIRxGxZL9L7j66DSWgUdPtqRaeI86tBmFk4Wk7ePzYMS1qw9PAds8vc
   2iRqSzSRX+PwYRPaeJ7AiVy/lEIraYbd2gDDlBk9uCsf4fwV7CL9vRTDw
   6MGqzIhWtrAtLi7kmUuo6/HeBagaFmrllDgM5NaZmabec5zsbgS4nVOZh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366189592"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="366189592"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 01:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726855155"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726855155"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 01:41:06 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLgGX-0000N3-2G;
        Tue, 18 Jul 2023 08:41:05 +0000
Date:   Tue, 18 Jul 2023 16:40:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 548cb932051fb6232ac983ed6673dae7bdf3cf4c
Message-ID: <202307181636.prQXMHzN-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 548cb932051fb6232ac983ed6673dae7bdf3cf4c  x86/mm: Fix PAT bit missing from page protection modify mask

elapsed time: 1033m

configs tested: 71
configs skipped: 137

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allyesconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
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
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                     loongson1b_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7705_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
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
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
