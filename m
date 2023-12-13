Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBA810BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378554AbjLMH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjLMH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:57:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C169BD;
        Tue, 12 Dec 2023 23:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702454283; x=1733990283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhr6XmX/fHUnfrR1VEsNJngQs5Qv2/CPJI50nFNpUH8=;
  b=oH4AfQ29lAizwfO24kFObOzoJ/StZKwPT0F5Bx4g2zR2Y9/MppiaHuJw
   B2R3oIOKyGL8agHJb6w3ApO/sSwD+5PJMTmvlJl7t+F0eoVOg0E5tRlXk
   XwD3v3+5Th6SpQFPSTbGGe5lx9n1HtPWzFpQg2XguigB0O1/bDBEhbQ5y
   M1rlJhpvIVSe+OcOP6y9GYOFlwgB+odcWryi1ny86Un8Ff5XMRNEC4Ps/
   42s73QrddytGylxaZEvZFLXcYAYtPNwpvh21gwTA9MW/g8o3h2bTVTYsL
   NUuZmmt24tMgaqvc9wVBW9hmJdeXjrsemh0e7gg0jLUZwid+Wh7fomCyO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="13621432"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="13621432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802794304"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="802794304"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 23:57:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDK7m-000KEZ-06;
        Wed, 13 Dec 2023 07:57:57 +0000
Date:   Wed, 13 Dec 2023 15:57:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        lukasz.luba@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Message-ID: <202312131518.2Fjrrxot-lkp@intel.com>
References: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-debugfs-Add-thermal-debugfs-information-for-mitigation-episodes/20231213-001321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231212161047.1631077-1-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device debugfs information
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231213/202312131518.2Fjrrxot-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131518.2Fjrrxot-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131518.2Fjrrxot-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/thermal/thermal_core.h:16:0,
                    from drivers/thermal/thermal_core.c:27:
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_add':
>> drivers/thermal/thermal_debugfs.h:10:50: error: parameter name omitted
    static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
                                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_remove':
   drivers/thermal/thermal_debugfs.h:11:53: error: parameter name omitted
    static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
                                                        ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h: In function 'thermal_debug_cdev_transition':
   drivers/thermal/thermal_debugfs.h:12:57: error: parameter name omitted
    static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
                                                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_debugfs.h:12:57: error: parameter name omitted


vim +10 drivers/thermal/thermal_debugfs.h

     2	
     3	#ifdef CONFIG_THERMAL_DEBUGFS
     4	void thermal_debug_init(void);
     5	void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
     6	void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
     7	void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, int state);
     8	#else
     9	static inline void thermal_debug_init(void) {}
  > 10	static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
