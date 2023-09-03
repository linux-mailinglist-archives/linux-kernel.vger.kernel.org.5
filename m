Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F0790A95
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 04:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbjICCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjICCjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 22:39:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F091CCA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693708781; x=1725244781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SWNrfbmSyetGOGOCGAak89UpOo8RCW54E69hKorpA48=;
  b=cidXYCvYhE5mCzwMiJIHTCgubr6YEWbUG9fOttx7KrZ7iu6hTIprQksM
   5tFJ/VrVeHbZaQOWvmFGK8MxACIXIpWyht3qrY1KlmxsA/TTAQgDZjY6y
   ut0qkOkBXRrZeU693LnIVFL4udo+pp6+5OvxX5jhzGFLlrWKNqaCCTi01
   b85k3cQQ7j2QTovpqX0PNXPCE5NqFfUEGxW1vzRmyw2MNUSCOAkgd2Ox3
   it5ZhENn7GxN4j8pXiZarCfRK1l1Zzppt/exGT/XJOSX/eBtVLL6NaUwf
   yFLs5UH7KoReRoPXZLOaS+k79ZswHOdLk3EnpyVyZsPi81REc5UvoNnae
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="442819268"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="442819268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 19:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="733936999"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="733936999"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2023 19:39:39 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcd1V-0002oh-0V;
        Sun, 03 Sep 2023 02:39:37 +0000
Date:   Sun, 3 Sep 2023 10:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Thompson <davthompson@nvidia.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: ld.lld: error: undefined symbol: sysfs_format_mac
Message-ID: <202309031058.JvwNDBKt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92901222f83d988617aee37680cb29e1a743b5e4
commit: 7e38a7422f128e7d7ba24b444e957d585dbb272f mlxbf-bootctl: Support sysfs entries for MFG fields
date:   10 days ago
config: arm64-randconfig-r024-20230902 (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: sysfs_format_mac
   >>> referenced by xarray.c
   >>>               vmlinux.o:(oob_mac_show)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
