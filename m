Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5B7D45B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJXCss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjJXCsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:48:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEE10D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698115718; x=1729651718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z0f1IlylB7+SscNjc1gnBRr78gaizZ2vo/6yZJVip1o=;
  b=Ae5X2z0D1Yki7aKQPGvuCb5jTRm8LQuAJFFotzm4YCxKYX/mp7RR4Jrw
   xW4bc/gRbBkKqTAvYbjcopQDw8OjdTgI82l01PHdwHCH/21kW4GkxfyyF
   T5DfFuhzBYefxeWlFa5752WK31Jpkkz+Yl+lWHmcUwMdUezM9ebYJ+m7R
   SBw0cjl2wFMLtBg+6kcz0J8v5Y4p2hfKWfSO8J4Rq52tBxFDFAndUhsbg
   szIgCotUXOz095fwyPAYz+vN7Ufoynlpdu7zyqftx8hpZWeoKvBMrCf8u
   QoNfdeAdkGhFGalq9kZfbMQbbDnQEal7iywo/bFMMbVG7j+2Gi5Jn3qtU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384172004"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="384172004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="6020661"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Oct 2023 19:47:20 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv7T8-0007Uv-0U;
        Tue, 24 Oct 2023 02:48:34 +0000
Date:   Tue, 24 Oct 2023 10:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shych <michaelsh@mellanox.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mlx_wdt.c:55: warning: Function parameter or member
 'regmap_val_sz' not described in 'mlxreg_wdt'
Message-ID: <202310241044.lvqeOGli-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e017769f4ce20dc0d3fa3220d4d359dcc4431274
commit: eee851143bca4422eeee3bb2e104b85537ba449d watchdog: mlx-wdt: support new watchdog type with longer timeout period
date:   3 years, 3 months ago
config: x86_64-randconfig-r013-20230824 (https://download.01.org/0day-ci/archive/20231024/202310241044.lvqeOGli-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241044.lvqeOGli-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241044.lvqeOGli-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/mlx_wdt.c:55: warning: Function parameter or member 'regmap_val_sz' not described in 'mlxreg_wdt'
   drivers/watchdog/mlx_wdt.c:55: warning: Function parameter or member 'wdt_type' not described in 'mlxreg_wdt'


vim +55 drivers/watchdog/mlx_wdt.c

c60923dd5feedc Michael Shych 2019-02-20  20  
c60923dd5feedc Michael Shych 2019-02-20  21  #define MLXREG_WDT_CLOCK_SCALE		1000
c60923dd5feedc Michael Shych 2019-02-20  22  #define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
c60923dd5feedc Michael Shych 2019-02-20  23  #define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
eee851143bca44 Michael Shych 2020-05-04  24  #define MLXREG_WDT_MAX_TIMEOUT_TYPE3	65535
c60923dd5feedc Michael Shych 2019-02-20  25  #define MLXREG_WDT_MIN_TIMEOUT		1
c60923dd5feedc Michael Shych 2019-02-20  26  #define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | \
c60923dd5feedc Michael Shych 2019-02-20  27  				 WDIOF_SETTIMEOUT)
c60923dd5feedc Michael Shych 2019-02-20  28  
c60923dd5feedc Michael Shych 2019-02-20  29  /**
c60923dd5feedc Michael Shych 2019-02-20  30   * struct mlxreg_wdt - wd private data:
c60923dd5feedc Michael Shych 2019-02-20  31   *
c60923dd5feedc Michael Shych 2019-02-20  32   * @wdd:	watchdog device;
c60923dd5feedc Michael Shych 2019-02-20  33   * @device:	basic device;
c60923dd5feedc Michael Shych 2019-02-20  34   * @pdata:	data received from platform driver;
c60923dd5feedc Michael Shych 2019-02-20  35   * @regmap:	register map of parent device;
c60923dd5feedc Michael Shych 2019-02-20  36   * @timeout:	defined timeout in sec.;
c60923dd5feedc Michael Shych 2019-02-20  37   * @action_idx:	index for direct access to action register;
c60923dd5feedc Michael Shych 2019-02-20  38   * @timeout_idx:index for direct access to TO register;
c60923dd5feedc Michael Shych 2019-02-20  39   * @tleft_idx:	index for direct access to time left register;
c60923dd5feedc Michael Shych 2019-02-20  40   * @ping_idx:	index for direct access to ping register;
c60923dd5feedc Michael Shych 2019-02-20  41   * @reset_idx:	index for direct access to reset cause register;
c60923dd5feedc Michael Shych 2019-02-20  42   * @wd_type:	watchdog HW type;
c60923dd5feedc Michael Shych 2019-02-20  43   */
c60923dd5feedc Michael Shych 2019-02-20  44  struct mlxreg_wdt {
c60923dd5feedc Michael Shych 2019-02-20  45  	struct watchdog_device wdd;
c60923dd5feedc Michael Shych 2019-02-20  46  	struct mlxreg_core_platform_data *pdata;
c60923dd5feedc Michael Shych 2019-02-20  47  	void *regmap;
c60923dd5feedc Michael Shych 2019-02-20  48  	int action_idx;
c60923dd5feedc Michael Shych 2019-02-20  49  	int timeout_idx;
c60923dd5feedc Michael Shych 2019-02-20  50  	int tleft_idx;
c60923dd5feedc Michael Shych 2019-02-20  51  	int ping_idx;
c60923dd5feedc Michael Shych 2019-02-20  52  	int reset_idx;
eee851143bca44 Michael Shych 2020-05-04  53  	int regmap_val_sz;
c60923dd5feedc Michael Shych 2019-02-20  54  	enum mlxreg_wdt_type wdt_type;
c60923dd5feedc Michael Shych 2019-02-20 @55  };
c60923dd5feedc Michael Shych 2019-02-20  56  

:::::: The code at line 55 was first introduced by commit
:::::: c60923dd5feedc337b1450e3f4c6e19ffa305439 watchdog: mlx-wdt: introduce a watchdog driver for Mellanox systems.

:::::: TO: Michael Shych <michaelsh@mellanox.com>
:::::: CC: Wim Van Sebroeck <wim@linux-watchdog.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
