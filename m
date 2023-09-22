Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9B7ABAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIVUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIVUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:51:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60251A4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695415891; x=1726951891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S560MoO4/Aq643/3boNM8DyTu41k6Mn6iW2w1aSYQdE=;
  b=ihTsTjFf2UFNOgkBNNyVsycQ9tCOVfGbMmTEDjSHY84bnA1lRbbxkk/a
   27uoxnOQvPsd5yTkZQ/+M6MVGbbOviWctpG89UOvDtiEEdYkIjffyK3B0
   WlcA5XEGe/ApmQVW3ZECY0kBhXQE1JcFsP1eYhSv1303UyIFg2w9/BSab
   SUbHRd9Po9TQJ+uah+IVPwjQQAiDryvy2/Fsg5iLUsq+VWiY0W3sTJ3nO
   slYcsHkw3Xx7S7nxI/KZTkQ10r/o2hdea7UCGIaAFrxS7jLa58Gfu65wv
   0HkQgPtxxrtzh+ZLpCpzwypAjzB9nIdAAPFIPwpT1zMvZVEL1W/DRii5P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="445040555"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="445040555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 13:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="863099735"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="863099735"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2023 13:51:29 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjn7X-0001IX-1B;
        Fri, 22 Sep 2023 20:51:27 +0000
Date:   Sat, 23 Sep 2023 04:51:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/opp/core.c:2092: warning: Function parameter or member
 'config_clks' not described in '_opp_set_clknames'
Message-ID: <202309230418.JKTJlSMq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc912ba91b7e2fa74650a0fc22cccf0e0d50f371
commit: 2083da24eb56ce622332946800a67a7449d85fe5 OPP: Allow multiple clocks for a device
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230923/202309230418.JKTJlSMq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230418.JKTJlSMq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230418.JKTJlSMq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1904: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1904: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:1947: warning: Function parameter or member 'opp_table' not described in '_opp_set_prop_name'
   drivers/opp/core.c:1947: warning: Excess function parameter 'dev' description in '_opp_set_prop_name'
   drivers/opp/core.c:1988: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:1988: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2092: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
>> drivers/opp/core.c:2092: warning: Function parameter or member 'config_clks' not described in '_opp_set_clknames'
   drivers/opp/core.c:2190: warning: Function parameter or member 'opp_table' not described in '_opp_set_config_regulators_helper'
   drivers/opp/core.c:2254: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
   drivers/opp/core.c:2481: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2481: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2092 drivers/opp/core.c

2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2075  
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2076  /**
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2077   * _opp_set_clknames() - Set clk names for the device
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2078   * @dev: Device for which clk names is being set.
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2079   * @names: Clk names.
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2080   *
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2081   * In order to support OPP switching, OPP layer needs to get pointers to the
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2082   * clocks for the device. Simple cases work fine without using this routine
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2083   * (i.e. by passing connection-id as NULL), but for a device with multiple
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2084   * clocks available, the OPP core needs to know the exact names of the clks to
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2085   * use.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2086   *
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2087   * This must be called before any OPPs are initialized for the device.
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2088   */
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2089  static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2090  			     const char * const names[],
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2091  			     config_clks_t config_clks)
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21 @2092  {
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2093  	const char * const *temp = names;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2094  	int count = 0, ret, i;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2095  	struct clk *clk;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2096  
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2097  	/* Count number of clks */
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2098  	while (*temp++)
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2099  		count++;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2100  
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2101  	/*
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2102  	 * This is a special case where we have a single clock, whose connection
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2103  	 * id name is NULL, i.e. first two entries are NULL in the array.
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2104  	 */
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2105  	if (!count && !names[1])
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2106  		count = 1;
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2107  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2108  	/* Fail early for invalid configurations */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2109  	if (!count || (config_clks && count == 1) || (!config_clks && count > 1))
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2110  		return -EINVAL;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2111  
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar 2022-05-25  2112  	/* Another CPU that shares the OPP table has set the clkname ? */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2113  	if (opp_table->clks)
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2114  		return 0;
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar 2022-05-25  2115  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2116  	opp_table->clks = kmalloc_array(count, sizeof(*opp_table->clks),
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2117  					GFP_KERNEL);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2118  	if (!opp_table->clks)
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2119  		return -ENOMEM;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2120  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2121  	/* Find clks for the device */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2122  	for (i = 0; i < count; i++) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2123  		clk = clk_get(dev, names[i]);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2124  		if (IS_ERR(clk)) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2125  			ret = dev_err_probe(dev, PTR_ERR(clk),
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2126  					    "%s: Couldn't find clock with name: %s\n",
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2127  					    __func__, names[i]);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2128  			goto free_clks;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2129  		}
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2130  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2131  		opp_table->clks[i] = clk;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2132  	}
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2133  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2134  	opp_table->clk_count = count;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2135  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2136  	/* Set generic single clk set here */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2137  	if (count == 1) {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2138  		opp_table->config_clks = _opp_config_clk_single;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2139  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2140  		/*
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2141  		 * We could have just dropped the "clk" field and used "clks"
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2142  		 * everywhere. Instead we kept the "clk" field around for
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2143  		 * following reasons:
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2144  		 *
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2145  		 * - avoiding clks[0] everywhere else.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2146  		 * - not running single clk helpers for multiple clk usecase by
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2147  		 *   mistake.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2148  		 *
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2149  		 * Since this is single-clk case, just update the clk pointer
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2150  		 * too.
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2151  		 */
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2152  		opp_table->clk = opp_table->clks[0];
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2153  	} else {
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2154  		opp_table->config_clks = config_clks;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2155  	}
0a43452bb6b1f4 drivers/opp/core.c            Viresh Kumar 2022-05-25  2156  
2368f57685768f drivers/opp/core.c            Viresh Kumar 2022-05-26  2157  	return 0;
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2158  
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2159  free_clks:
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2160  	_put_clks(opp_table, i);
2083da24eb56ce drivers/opp/core.c            Viresh Kumar 2022-06-10  2161  	return ret;
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2162  }
829a4e8c0e9aab drivers/base/power/opp/core.c Viresh Kumar 2017-06-21  2163  

:::::: The code at line 2092 was first introduced by commit
:::::: 829a4e8c0e9aab17bcfe2ddb070388b8ada26292 PM / OPP: Add dev_pm_opp_{set|put}_clkname()

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
