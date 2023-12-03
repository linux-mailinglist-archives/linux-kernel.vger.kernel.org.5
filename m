Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17F802132
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjLCGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjLCGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:07:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB2119
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701583667; x=1733119667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7KYcWgwLsMoyVqLFSY684yly5/cD8UmHcRCZe4oaSpE=;
  b=UPtLYKPbkWlzLPdIc0GkV09RSVeVZd7tMr3vbRYJno7cJisVKewCbJSs
   JbM414iwmKofObpfN3mYVRe+SA2EnyQb4DegVpJeTszgbro6qfGI8yEJw
   MTiIhFsRlhKSOZCySEwcM+KuYrt0wKbBOKe/s7A38Ah/C1unKRwRDKq3U
   b2nxYG9G5Rto/I6eAJTxWXXdQn9n9qjSUwWey7LlhHVx2doykJJgoMrbs
   /V92Xq9a964hTG//KbmL7X9luS0wHyxmAF1sx3SpoOW7vLkLE4uv1gVzF
   SSCaVWggKen9hVs228Xu/DCFXV5vu2Tu6RXe4Cg5C1WOM4ABS3j9OCqHK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="373049287"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="373049287"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770187869"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770187869"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:07:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9fdk-0006I8-32;
        Sun, 03 Dec 2023 06:07:40 +0000
Date:   Sun, 3 Dec 2023 14:07:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geoff Levand <geoff@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/ps3/setup.c:229:24: warning: '%u' directive
 output may be truncated writing between 1 and 5 bytes into a region of size
 between 4 and 12
Message-ID: <202312021810.bCVHtweA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 07e2d6cf91079ca01db7fb989a02edd8009dcacd powerpc/ps3: Add firmware version to sysfs
date:   2 years, 6 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20231202/202312021810.bCVHtweA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312021810.bCVHtweA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021810.bCVHtweA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/ps3/setup.c: In function 'ps3_setup_arch':
>> arch/powerpc/platforms/ps3/setup.c:229:24: warning: '%u' directive output may be truncated writing between 1 and 5 bytes into a region of size between 4 and 12 [-Wformat-truncation=]
     229 |                 "%u.%u.%u", ps3_firmware_version.major,
         |                        ^~
   arch/powerpc/platforms/ps3/setup.c:229:17: note: directive argument in the range [0, 65535]
     229 |                 "%u.%u.%u", ps3_firmware_version.major,
         |                 ^~~~~~~~~~
   arch/powerpc/platforms/ps3/setup.c:228:9: note: 'snprintf' output between 6 and 18 bytes into a destination of size 16
     228 |         snprintf(ps3_firmware_version_str, sizeof(ps3_firmware_version_str),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     229 |                 "%u.%u.%u", ps3_firmware_version.major,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     230 |                 ps3_firmware_version.minor, ps3_firmware_version.rev);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +229 arch/powerpc/platforms/ps3/setup.c

   219	
   220	static void __init ps3_setup_arch(void)
   221	{
   222		u64 tmp;
   223	
   224		DBG(" -> %s:%d\n", __func__, __LINE__);
   225	
   226		lv1_get_version_info(&ps3_firmware_version.raw, &tmp);
   227	
   228		snprintf(ps3_firmware_version_str, sizeof(ps3_firmware_version_str),
 > 229			"%u.%u.%u", ps3_firmware_version.major,
   230			ps3_firmware_version.minor, ps3_firmware_version.rev);
   231	
   232		printk(KERN_INFO "PS3 firmware version %s\n", ps3_firmware_version_str);
   233	
   234		ps3_spu_set_platform();
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
