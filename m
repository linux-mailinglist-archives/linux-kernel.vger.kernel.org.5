Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A477905B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbjIBHTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjIBHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:19:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587610F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693639154; x=1725175154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6etIzLZCD2H756zLMjjzsCwqksqcT5pJT4+aCvV7nVw=;
  b=bYmlDsYthAl0esX+LTJAKdx8ZQARmsGPfzDJXEQfQ5f4AbAyseh0lDTI
   vZEuG8Mumg/M6m36MkfKKkVkj5HzJY5ep0HUsRtKlOn5UoyAMgtnODtud
   rXUuhENZBJP2G7Jysh4356/kVEX2iWv+EdoTCPQZkM6x6qJ9bnTvRtLEC
   C1EEUV4LIH059oocSdTjoHuGHkn/MZWlM8BBF/d/dlwwyjFp0PbI2N0gA
   R2OBGdLzs8VFuIBTGOLNk1emle6XP59d7a8hj6tws0mH9JhzcwGcQEjX5
   piAxuzewtyRAg9YimOivUsigE414jjgLhUXmaXm95+xCWPfac0RMUkyj8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462714498"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="462714498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 00:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854959943"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="854959943"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2023 00:19:12 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcKuT-00026x-2W;
        Sat, 02 Sep 2023 07:19:09 +0000
Date:   Sat, 2 Sep 2023 15:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: drivers/video/fbdev/g364fb.c:115:9: error:
 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean
 'FB_DEFAULT_IOMEM_OPS'?
Message-ID: <202309021523.xzaOVMYD-lkp@intel.com>
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

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0468be89b3fa5b9249cee1097f1d50314950a2df
commit: 5011260838551cefbf23d60b48c3243b6d5530a2 fbdev/g364fb: Use fbdev I/O helpers
date:   4 weeks ago
config: mips-jazz_defconfig (https://download.01.org/0day-ci/archive/20230902/202309021523.xzaOVMYD-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309021523.xzaOVMYD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309021523.xzaOVMYD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/g364fb.c:115:9: error: 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean 'FB_DEFAULT_IOMEM_OPS'?
     115 |         FB_DEFAULT_IOMEM_HELPERS,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         FB_DEFAULT_IOMEM_OPS


vim +115 drivers/video/fbdev/g364fb.c

   112	
   113	static const struct fb_ops g364fb_ops = {
   114		.owner		= THIS_MODULE,
 > 115		FB_DEFAULT_IOMEM_HELPERS,
   116		.fb_setcolreg	= g364fb_setcolreg,
   117		.fb_pan_display	= g364fb_pan_display,
   118		.fb_blank	= g364fb_blank,
   119	};
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
