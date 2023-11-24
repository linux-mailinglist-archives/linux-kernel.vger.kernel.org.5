Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881CF7F69F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjKXAq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:46:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D2110DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700786791; x=1732322791;
  h=date:from:to:cc:subject:message-id;
  bh=wwk43fZCnDykHBhpu4ZYG8H3qRyWDURs5GjTjFkKk1g=;
  b=eK3zQDSa3P/Wu+c8/MEnjoFiXB3JYY32pkt+7Ls8Y1IgaFoTmWdHhs/y
   tqT+RPMDz0L+5Ilsv1wkaPwG2pn8acr8YFq8xHp1pOvz5AyaK70Z1yQ5G
   J7tIjc6taW663qzioQnEhnSnmxyFy2txFECMT3xZyH6J71yc5KUcwpjfH
   fFMiZj+jYhiSrp4pzHazxyboceNp0DTe6rh/9JLCfuw0tGAzd4W8uY3dj
   VBoLxk44YqNgE99B/H+c1h0fgg2FsxvMZ+i0WTY/m58NAlDLePg5cyYwT
   n8G/ZpTo63usjQeY1PdNNr3KhLoUIcb7RpzWR5lsuabtMFDO7REfCtkNt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389498671"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="389498671"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 16:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796443995"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="796443995"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2023 16:46:29 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6KKx-0001tf-0k;
        Fri, 24 Nov 2023 00:46:27 +0000
Date:   Fri, 24 Nov 2023 08:46:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 8e5647a723c49d73b9f108a8bb38e8c29d3948ea
Message-ID: <202311240816.tUPWIUD6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 8e5647a723c49d73b9f108a8bb38e8c29d3948ea  x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

elapsed time: 740m

configs tested: 55
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
