Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9067DFC21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377445AbjKBV7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjKBV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:59:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC618C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698962340; x=1730498340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hPncJ/tczIojvzuxs6+9ig2+6Plzo2BNcq4eDxaFWjw=;
  b=EGO5wQOW2NrKnTkETVi4SCsB0RPF/o7fP0ML4xn5dpxN3WlWiQ9Pl1SM
   PF3uBK8k3t4OrmjSCVUJFbPBxNhct4hLPefkFrLL7/FRF50blktYzUk2f
   x2HpXOUrTpFDq2vXQ0J9RN89y+K6U2tcqbkXbuwRjJEF98QFDZvbiCDl5
   TK1ECcd/JSjSBy0RaRtHzWOsYhf3gwW0siUSUMSZ6y1U096m5EgOpvWO5
   F/iBEhSXE48x9D7BAgV3u7CmbGaf8Vlw48Y6jHt3xJs5n8LTiPfHt59FQ
   XeL6MbrzIPF95Pc9aPJkiHjp2l0z/stWVkSfbv3oTISplouB790T8+AB4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10359427"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10359427"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2695126"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2023 14:58:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyfiK-0001tr-0d;
        Thu, 02 Nov 2023 21:58:56 +0000
Date:   Fri, 3 Nov 2023 05:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
Message-ID: <202311030513.LDYgnPoh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: f962396ce29244d9a64f241481fa73fa370404c3 ARM: davinci: support multiplatform build for ARM v5
date:   4 years, 2 months ago
config: arm-kismet-CONFIG_CPU_DCACHE_WRITETHROUGH-CONFIG_ARCH_DAVINCI_DA830-0-0 (https://download.01.org/0day-ci/archive/20231103/202311030513.LDYgnPoh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311030513.LDYgnPoh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030513.LDYgnPoh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
   .config:6902:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   
   WARNING: unmet direct dependencies detected for CRYPTO_HMAC
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - IPV6_SEG6_HMAC [=y] && NET [=y] && INET [=y] && IPV6 [=y]
   
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - IPV6_SEG6_HMAC [=y] && NET [=y] && INET [=y] && IPV6 [=y]
   
   WARNING: unmet direct dependencies detected for CRYPTO_SHA256
     Depends on [n]: CRYPTO [=n]
     Selected by [y]:
     - IPV6_SEG6_HMAC [=y] && NET [=y] && INET [=y] && IPV6 [=y]
   
   WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH
     Depends on [n]: (CPU_ARM740T [=n] || CPU_ARM920T [=n] || CPU_ARM922T [=n] || CPU_ARM925T [=n] || CPU_ARM926T [=n] || CPU_ARM940T [=n] || CPU_ARM946E [=n] || CPU_ARM1020 [=n] || CPU_FA526 [=n]) && !CPU_DCACHE_DISABLE [=n]
     Selected by [y]:
     - ARCH_DAVINCI_DA830 [=y] && ARCH_DAVINCI [=y] && (!ARCH_DAVINCI_DMx [=y] || AUTO_ZRELADDR [=y] && ARM_PATCH_PHYS_VIRT [=y]) && !CPU_DCACHE_DISABLE [=n]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
