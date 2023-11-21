Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B357F37E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjKUVNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:13:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241631AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601187; x=1732137187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yjJ553Y+4myjUDZDcFzbklN6xBWg/BjAN5ZYJ8061jg=;
  b=FJ2UtmDCmlv7y1kGY+YSw9ZAX8d/0uCHpeLKQM0lp6FjdvPUOBQrv3yc
   irfpO4LEW6TDkE4FQNtVZ63t4xMZfRSzx2DZrfzbVE8hIosZDD1wO7rrF
   +EHCQPipOlaVXw4PIU64l3WGVL97WPP72VeFL/p1o2YOTGR3JMboFGX4K
   ecP09+4YQevloNxQ7uyQYTTt4XaB6Q7Zfr+Svg6FtzcNqVQj+ocNzqZcF
   /YmojdNeLBwAKtVCdhdShbA06YgDoRnipOy95hcCcSzUJ9Waq7UPhPklX
   obbOfzcEUhccyGhlGYBnTSwCQwNfW8vdnV5I7WCmHKtHNPET9lwofwMrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456263880"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="456263880"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="884332583"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="884332583"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2023 13:13:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Y3K-0008Fq-1I;
        Tue, 21 Nov 2023 21:13:02 +0000
Date:   Wed, 22 Nov 2023 05:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured
 comments found
Message-ID: <202311220421.xKye7ZRO-lkp@intel.com>
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
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: d8f4494e70ae5fef159719bfbb6abedc53619bf1 pinctrl: mcp23s08: drop comment about missing irq support
date:   7 years ago
config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220421.xKye7ZRO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-mcp23s08.c: In function 'mcp_pinconf_set':
   drivers/pinctrl/pinctrl-mcp23s08.c:282:6: warning: variable 'val' set but not used [-Wunused-but-set-variable]
     u16 val;
         ^~~
   drivers/pinctrl/pinctrl-mcp23s08.c:281:11: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     u32 arg, mask;
              ^~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured comments found


vim +1 drivers/pinctrl/pinctrl-mcp23s08.c

   > 1	/* MCP23S08 SPI/I2C GPIO driver */
     2	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
