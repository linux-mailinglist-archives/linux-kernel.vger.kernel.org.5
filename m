Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D987997D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjIIMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIIMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:08:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CECC1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694261300; x=1725797300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4I3lBU2DMVueFg6TaIyefQ5zLIqyw+5/iO6Pt81J8Mk=;
  b=G22ietgyDQXj479JrUOMwmNhLe6+uNbQuWCo924kTt4PPhoi0R2iXfTS
   CYXbSnwPzaSqY0QlTAZPpyYHB6lnPxJXOD1ppbou0qFE85lq3rsu8wOaF
   2B9x/J4nfk5hBJriGvvdNV21vE7Cs/j543sFoi4I2tw+WMfouUw7yxJ1B
   v7UjujX/ay1xOcOMyU0EpLGAVbZ9vk5Znm9ANPLMUsaQVDcFrmvk+79x3
   uQvY9C/qmlwtiLyARohdLy4clCG6Ag6yhuO+uVJNa7KMk4/gTNQb3N+lC
   c8y+ZAqDfcrC/cgH2umC+Eubzp321dQ3ZxYQB1f9njWUXrlZKm5Wk0GLv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="358120958"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="358120958"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 05:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="885952515"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="885952515"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2023 05:08:00 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qewl6-0003Te-2U;
        Sat, 09 Sep 2023 12:08:16 +0000
Date:   Sat, 9 Sep 2023 20:07:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:2181: warning: Function parameter or member
 'opp_table' not described in '_opp_set_clknames'
Message-ID: <202309092008.fU1U8cHe-lkp@intel.com>
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
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 2368f57685768f9f9cd666eaa4194a359d89afb8 OPP: Migrate set-clk-name API to use set-config helpers
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309092008.fU1U8cHe-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309092008.fU1U8cHe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309092008.fU1U8cHe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1967: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1967: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:2068: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:2068: warning: Excess function parameter 'count' description in '_opp_set_regulators'
>> drivers/opp/core.c:2181: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
   drivers/opp/core.c:2653: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2653: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2181 drivers/opp/core.c

32aee78bc5184c drivers/opp/core.c            Yangtao Li          2021-03-14  2165  
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2166  /**
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2167   * _opp_set_clknames() - Set clk names for the device
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2168   * @dev: Device for which clk names is being set.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2169   * @names: Clk names.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2170   *
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2171   * In order to support OPP switching, OPP layer needs to get pointers to the
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2172   * clocks for the device. Simple cases work fine without using this routine
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2173   * (i.e. by passing connection-id as NULL), but for a device with multiple
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2174   * clocks available, the OPP core needs to know the exact names of the clks to
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2175   * use.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2176   *
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2177   * This must be called before any OPPs are initialized for the device.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2178   */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2179  static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2180  			     const char * const names[])
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21 @2181  {
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2182  	const char * const *temp = names;
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2183  	int count = 0;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2184  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2185  	/* Count number of clks */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2186  	while (*temp++)
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2187  		count++;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2188  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2189  	/*
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2190  	 * This is a special case where we have a single clock, whose connection
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2191  	 * id name is NULL, i.e. first two entries are NULL in the array.
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2192  	 */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2193  	if (!count && !names[1])
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2194  		count = 1;
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2195  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2196  	/* We support only one clock name for now */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2197  	if (count != 1)
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2198  		return -EINVAL;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2199  
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2200  	/* Another CPU that shares the OPP table has set the clkname ? */
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2201  	if (opp_table->clk_configured)
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2202  		return 0;
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2203  
32439ac7535a8e drivers/opp/core.c            Viresh Kumar        2021-01-28  2204  	/* clk shouldn't be initialized at this point */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2205  	if (WARN_ON(opp_table->clk))
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2206  		return -EBUSY;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2207  
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2208  	/* Find clk for the device */
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2209  	opp_table->clk = clk_get(dev, names[0]);
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2210  	if (IS_ERR(opp_table->clk)) {
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2211  		return dev_err_probe(dev, PTR_ERR(opp_table->clk),
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2212  				    "%s: Couldn't find clock\n", __func__);
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2213  	}
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2214  
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2215  	opp_table->clk_configured = true;
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar        2022-05-25  2216  
2368f57685768f drivers/opp/core.c            Viresh Kumar        2022-05-26  2217  	return 0;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2218  }
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar        2017-06-21  2219  

:::::: The code at line 2181 was first introduced by commit
:::::: 829a4e8c0e9aab17bcfe2ddb070388b8ada26292 PM / OPP: Add dev_pm_opp_{set|put}_clkname()

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
