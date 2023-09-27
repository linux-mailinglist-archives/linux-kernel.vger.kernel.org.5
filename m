Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942267AF8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjI0Dom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjI0Dmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:42:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6EA244
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695784085; x=1727320085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QDd+32FprjQsJFSJKfUjZgJ+Hmm0kmJfuXdwni+O0Gg=;
  b=VM04+VHZtDEw6MkyDf6B8CPmcO85Fmwwr/5xvqugl/oZvAxtHaDs/Lvu
   qF7H4cNJGwck2GHpEMGcNv59XIdijMKXZHNCdvAoaPSNXtkzKwbCGwQlI
   yAebksb4VGi+7IAvEHqQYMWd7P9kx8bmY05dVGYpKV/Dz4zPePPPwTs5E
   osn5N7KJkWNFx119Z0a537U2RV8IPambamUAUm8tAaQFtIiWXC7SEeS7i
   Qe8YcRwl15YQLGp4M7Mlar6ss19Ha3WhMU89mu6YNyb1PTTyEpm4iE3lh
   AAz8VyHe0PUYz1noXfxGZduxBnnEGi7pN5APsylxi6IomLRPEup9wKm1v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361098556"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361098556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749029258"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749029258"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2023 20:08:04 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlKtE-0003fa-0q;
        Wed, 27 Sep 2023 03:07:31 +0000
Date:   Wed, 27 Sep 2023 11:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sh4-linux-gcc: error: -pg and -fomit-frame-pointer are incompatible
Message-ID: <202309271150.F7XFcO2K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e945134b680040b8613e962f586d91b6d40292d
commit: 2a61f4747eeaa85ce26ca9fbd81421b15facd018 stack-protector: test compiler capability in Kconfig and drop AUTO mode
date:   5 years ago
config: sh-randconfig-r082-20230815 (https://download.01.org/0day-ci/archive/20230927/202309271150.F7XFcO2K-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309271150.F7XFcO2K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309271150.F7XFcO2K-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sh4-linux-gcc: error: -pg and -fomit-frame-pointer are incompatible
   make[2]: *** [./Kbuild:21: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1086: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:146: sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
