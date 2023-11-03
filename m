Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878757E0B22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbjKCWZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjKCWZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:25:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402AD53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699050315; x=1730586315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+oKiD9lHjzcEymhf0eNoGLgt+il2+nhhtokOR2Mrc5k=;
  b=S338ah9W96VefqYF7blu0KZ3lR6L+ZAUo0jjL5Y6/Eyodlh80E0IecEj
   lIOQnIGMdrx5suJJ80KzStN7c/L9RKy/MwGqkx7L1kr93oQiZLbx46m05
   6S7wxwgN7K8rHHAabTJ0YGyVehtQ4Vonc5C2mtoJ4n7Ei+FT2Xv4qyWuk
   gi6SRlYfWK4BOSg70Vuud5gvfTQPAQHV215vescNCVerjUg6MmVzS/cAn
   /NE0OyYHUEI5niOgrMSgDvw6LB1jGnzz7keaWDVzBoReLTVsf7kOOsADb
   3+llDsAMiwRX8KmYfOyb/o1sWYPxdutdpuknPNnJdvbaJeEpoBI30B03v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1987754"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1987754"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="3049769"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2023 15:25:07 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2bB-000308-0p;
        Fri, 03 Nov 2023 22:25:05 +0000
Date:   Sat, 4 Nov 2023 06:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
Message-ID: <202311040615.3JpahwtF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bdfe2d88b9ff8b0cce32ce87cd47c0e9d665f48
commit: f962396ce29244d9a64f241481fa73fa370404c3 ARM: davinci: support multiplatform build for ARM v5
date:   4 years, 2 months ago
config: arm-kismet-CONFIG_CPU_DCACHE_WRITETHROUGH-CONFIG_ARCH_DAVINCI_DA830-0-0 (https://download.01.org/0day-ci/archive/20231104/202311040615.3JpahwtF-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231104/202311040615.3JpahwtF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040615.3JpahwtF-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH when selected by ARCH_DAVINCI_DA830
   
   WARNING: unmet direct dependencies detected for CPU_DCACHE_WRITETHROUGH
     Depends on [n]: (CPU_ARM740T [=n] || CPU_ARM920T [=n] || CPU_ARM922T [=n] || CPU_ARM925T [=n] || CPU_ARM926T [=n] || CPU_ARM940T [=n] || CPU_ARM946E [=n] || CPU_ARM1020 [=n] || CPU_FA526 [=n]) && !CPU_DCACHE_DISABLE [=n]
     Selected by [y]:
     - ARCH_DAVINCI_DA830 [=y] && ARCH_DAVINCI [=y] && (!ARCH_DAVINCI_DMx [=y] || AUTO_ZRELADDR [=y] && ARM_PATCH_PHYS_VIRT [=y]) && !CPU_DCACHE_DISABLE [=n]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
