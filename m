Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53FE7678BA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjG1W4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1W4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:56:51 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA43AB4;
        Fri, 28 Jul 2023 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690585010; x=1722121010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUS/zgobdp00tWjroB1Igu16JTbPo1ZwgRINYeNVxL8=;
  b=hzhsfYHIFU077QKzsUjNxEvY5OEmj9hBB9EhoPM9krIVL6fwZfmL0uS0
   oHk6fc0oZXrtwXoHZZ3vsTLmBu2ZL+UZV7HdO2Pqqp5KCG21lkrlG/a60
   pbodb8YatgJBE+QKKpYLf8u/L50qMEcMUgEPkWVmFYeskwXWbBwSJ+Rt2
   K0uVEOFmjjSFVuCG5K+us8Xosqtr2SGXzUtxOr/LkOoZlm+idD57XyV29
   zO4IvourKDYNiupvsKd3cDmrLtZEuF9TbrvfhJHius83V0AjwRtH+P5CI
   0Z6/eWkRBnOAPl5l4Yq8ud/w0B4JYEIB6KE3aTqBEg++FD1S4sgILOoDS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="399642066"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="399642066"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 15:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="677653032"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="677653032"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 15:56:32 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPWNr-0003dn-0K;
        Fri, 28 Jul 2023 22:56:31 +0000
Date:   Sat, 29 Jul 2023 06:55:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Purdie <rpurdie@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] led: trig: timer: stop offloading on deactivation
Message-ID: <202307290641.SUCRTRMI-lkp@intel.com>
References: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on wireless-next/main wireless/main linus/master pavel-leds/for-next v6.5-rc3 next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/led-trig-timer-stop-offloading-on-deactivation/20230728-203243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel%40makrotopia.org
patch subject: [PATCH] led: trig: timer: stop offloading on deactivation
config: mips-randconfig-r093-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290641.SUCRTRMI-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290641.SUCRTRMI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290641.SUCRTRMI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/leds/trigger/ledtrig-timer.c:129:47: sparse: sparse: Using plain integer as NULL pointer
   drivers/leds/trigger/ledtrig-timer.c:129:50: sparse: sparse: Using plain integer as NULL pointer

vim +129 drivers/leds/trigger/ledtrig-timer.c

   123	
   124	static void timer_trig_deactivate(struct led_classdev *led_cdev)
   125	{
   126		/* Stop blinking */
   127		led_set_brightness(led_cdev, LED_OFF);
   128		if (led_cdev->blink_set)
 > 129			led_cdev->blink_set(led_cdev, 0, 0);
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
