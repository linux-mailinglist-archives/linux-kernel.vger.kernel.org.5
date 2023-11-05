Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE57E13E0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjKEOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:22:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA78D6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699194139; x=1730730139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oBUFkQiTos0/X7+AGf9MwQ6Syhci7WVD47kNDlnjLc8=;
  b=AkG+XC7DEH6kw7ILeddT/IB/q5Dv7BZ4s6PZHm8pw/vh/HE/fCI4BZjg
   lXVjvVJNbI38XzghPsr31s0yTw7j2okH989mQewGJ15vSB65hogROmdK4
   dj2xV+VEcZhD7s5jYNDnLEXTM2x+hfJALrZjF5NT3mZHEIC1hoXQulNET
   wcX47iAKFBVZc07z0Ou6U3WwrB5vc1t44puuCaZfvBTYJycIRVqt0elMn
   EZwUu7LAfTyUBZQgfq8muCuKKliPj54zXhLF9lqLIwrmeSm2D0x1w8OBk
   TnR/ueMa0FRpQRJa89gPhngXjkxhKeotdSs0YIQ6gmZqRd+mOeXb1i0Ex
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2059754"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2059754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 06:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="711976082"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="711976082"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2023 06:22:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qze10-0005W0-0y;
        Sun, 05 Nov 2023 14:22:14 +0000
Date:   Sun, 5 Nov 2023 22:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
Message-ID: <202311052219.INoR2zgO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: f962396ce29244d9a64f241481fa73fa370404c3 ARM: davinci: support multiplatform build for ARM v5
date:   4 years, 2 months ago
config: arm-kismet-CONFIG_CPU_DCACHE_WRITETHROUGH-CONFIG_ARCH_DAVINCI_DA830-0-0 (https://download.01.org/0day-ci/archive/20231105/202311052219.INoR2zgO-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231105/202311052219.INoR2zgO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052219.INoR2zgO-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
   .config:6722:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH
     Depends on [n]: (CPU_ARM740T [=n] || CPU_ARM920T [=n] || CPU_ARM922T [=n] || CPU_ARM925T [=n] || CPU_ARM926T [=n] || CPU_ARM940T [=n] || CPU_ARM946E [=n] || CPU_ARM1020 [=n] || CPU_FA526 [=n]) && !CPU_DCACHE_DISABLE [=n]
     Selected by [y]:
     - ARCH_DAVINCI_DA830 [=y] && ARCH_DAVINCI [=y] && (!ARCH_DAVINCI_DMx [=y] || AUTO_ZRELADDR [=y] && ARM_PATCH_PHYS_VIRT [=y]) && !CPU_DCACHE_DISABLE [=n]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
