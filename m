Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAEA7A5435
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIRUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:34:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD98F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695069278; x=1726605278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JE8WkXxWGNJHGH+00ed7qBc2wg/QAH1DiAO7I1aoU+g=;
  b=axfTnGrGWbhQLQfQsu0IdaxmPYZ9V4AWWbZ80QAZ2xu4f9/mKkihQsrz
   whzsUr8wnXM0bHbbOyeoNqA80QtWcTPSKQfwIV23HsDL+2aNYD4+xt4V9
   2GGD230LcN3xHvi1GXnDhH5B3qCZPd4L9k6fCIgYWAoEAijyTPV3YJjCf
   ug20uyiMgEYE9fBS7Uil1bdiw4LxOTCz6P/tDXaZZY7/C8IXRIQ+jn6Ps
   XfLhYAVadjsNbeXT4gJHRbtZTGeCIvTjncPS7VspOnWs+a8FO+0h9g9Yi
   GeMwYYN/xcwDpKhSclMLCYMcMm+i1UETGo8Hq+iEGT2qzhAKCh4dHtGUZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379679620"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="379679620"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 13:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076716229"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="1076716229"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2023 13:34:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiKx0-0006SQ-2A;
        Mon, 18 Sep 2023 20:34:34 +0000
Date:   Tue, 19 Sep 2023 04:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: drivers/video/fbdev/omap2/omapfb/dss/omapdss.o: warning: objtool:
 hdmi_power_on_full.isra.0+0x120: hdmi_pll_compute() is missing a __noreturn
 annotation
Message-ID: <202309190420.CoYRYNNK-lkp@intel.com>
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
head:   ce9ecca0238b140b88f43859b211c9fdfd8e5b70
commit: fedb724c3db5490234ddde0103811c28c2fedae0 objtool: Detect missing __noreturn annotations
date:   4 months ago
config: x86_64-buildonly-randconfig-005-20230919 (https://download.01.org/0day-ci/archive/20230919/202309190420.CoYRYNNK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309190420.CoYRYNNK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309190420.CoYRYNNK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/omap2/omapfb/dss/omapdss.o: warning: objtool: hdmi_power_on_full.isra.0+0x120: hdmi_pll_compute() is missing a __noreturn annotation


objdump-func vmlinux.o hdmi_power_on_full.isra.0:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
