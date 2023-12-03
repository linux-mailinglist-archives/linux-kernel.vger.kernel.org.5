Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CF8021D1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjLCIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 03:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjLCIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 03:35:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46599116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 00:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701592556; x=1733128556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3I73M/VgrkDIRpt+r6UOwWES8qJCXRmPCTx82HkOTc=;
  b=ngIBEAGEKwTPSCm0fFbmnCyTE1qfe/ELDFHejoKGKaG8oWchpEO+tobW
   Hpb6ZdaUkfifK3AMFy1ooORtkN1Xa546xbqQOA1t7FvA+hPLhPQSF0QX8
   TiIlqH7UEbYiNCHUO5EjR05dOEOu1PgXzR/Ix7r6rTCZCLdP+OHwTAJ1x
   R5CTNNJkPjSlQxSOsHvHEu7vSnIFeDEafvXKi+OLNAxjuGq8jWSNoKVm5
   6DlbX4/hYp0DOdNydheBcga8byxZcJJCZDymVZDWoUl7KwCnSHUAeNT12
   /00RgxLU05t1mnCW9gmBi0skE8pjl0UDkXMl3NN87I2mVcccWT39eE9qW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="392509081"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="392509081"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 00:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="888193127"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="888193127"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2023 00:35:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9hx8-0006Se-3A;
        Sun, 03 Dec 2023 08:35:50 +0000
Date:   Sun, 3 Dec 2023 16:35:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alan Mizrahi <alan@mizrahi.com.ve>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: drivers/leds/leds-apu.c:105:35: warning: 'apu_led_dmi_table' defined
 but not used
Message-ID: <202312031626.TICxZCaC-lkp@intel.com>
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

Hi Alan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: 3faee9423ce07186fc9dcec2981d4eb8af8872bb leds: Add driver for PC Engines APU/APU2 LEDs
date:   6 years ago
config: i386-buildonly-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231203/202312031626.TICxZCaC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312031626.TICxZCaC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031626.TICxZCaC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/dmi.h:5,
                    from drivers/leds/leds-apu.c:34:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             \
         |                                       ^~~
   drivers/leds/leds-apu.c: At top level:
>> drivers/leds/leds-apu.c:105:35: warning: 'apu_led_dmi_table' defined but not used [-Wunused-const-variable=]
     105 | static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
         |                                   ^~~~~~~~~~~~~~~~~


vim +/apu_led_dmi_table +105 drivers/leds/leds-apu.c

   104	
 > 105	static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
   106		{
   107			.ident = "apu",
   108			.matches = {
   109				DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
   110				DMI_MATCH(DMI_PRODUCT_NAME, "APU")
   111			}
   112		},
   113		{
   114			.ident = "apu2",
   115			.matches = {
   116				DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
   117				DMI_MATCH(DMI_BOARD_NAME, "APU2")
   118			}
   119		},
   120		{}
   121	};
   122	MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
