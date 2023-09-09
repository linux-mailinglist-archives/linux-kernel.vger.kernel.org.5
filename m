Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DA799719
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjIIJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:35:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBF10F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694252105; x=1725788105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CW7nvquc7kZ7DHZsm+3uxj1qmSr/wg3g9BtxspYS5sY=;
  b=Gq9aT0bGM01gBwF6VK8RCraAA6D/CGRHuXMZfMCM7+GEkj8TsEUDF+Nd
   UL3u8sugEyrYsRwvGUM8GOX6K1RAM0ceJ0J+SK0jLndO4lNpvRN9yiHOB
   HfbECZgeOI7JyVgH9nMBSLdQFxevioWILD5WWe9j1RXuVdd6le54XccBR
   QCHHEyqT/8ohrlmy9s82KJAHkV32fHYNR4X830vHI0rlxIW/PtVyUTTw7
   J6VEdHLN3sbzF+Fr/Zx38SpeqlQ3pT2bWtAFsGij41W2BwWstaPGW6WC3
   AAJDfeN2d6iHQcVcxppH6bqSKflc5OnHvIY0OQZ9zURavMFfx5+qpz6yL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="358114014"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="358114014"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 02:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="719417143"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="719417143"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2023 02:35:02 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeuMm-0003FW-2P;
        Sat, 09 Sep 2023 09:35:00 +0000
Date:   Sat, 9 Sep 2023 17:34:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: drivers/opp/core.c:2113: warning: Function parameter or member
 'opp_table' not described in '_opp_set_regulators'
Message-ID: <202309091728.siozDgSB-lkp@intel.com>
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
commit: b0ec09428621daee5101130c307634a390b0213b OPP: Migrate set-regulators API to use set-config helpers
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091728.siozDgSB-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091728.siozDgSB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091728.siozDgSB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:2113: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
>> drivers/opp/core.c:2113: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2756: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2756: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2113 drivers/opp/core.c

01fb4d3c39d35b drivers/base/power/opp/core.c Viresh Kumar        2015-12-09  2098  
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2099  /**
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2100   * _opp_set_regulators() - Set regulator names for the device
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2101   * @dev: Device for which regulator name is being set.
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2102   * @names: Array of pointers to the names of the regulator.
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2103   * @count: Number of regulators.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2104   *
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2105   * In order to support OPP switching, OPP layer needs to know the name of the
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2106   * device's regulators, as the core would be required to switch voltages as
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2107   * well.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2108   *
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2109   * This must be called before any OPPs are initialized for the device.
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2110   */
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2111  static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2112  			       const char * const names[])
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09 @2113  {
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2114  	struct dev_pm_opp_supply *supplies;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2115  	const char * const *temp = names;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2116  	struct regulator *reg;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2117  	int count = 0, ret, i;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2118  
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2119  	/* Count number of regulators */
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2120  	while (*temp++)
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2121  		count++;
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2122  
87686cc845c3be drivers/opp/core.c            Viresh Kumar        2022-07-04  2123  	if (!count)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2124  		return -EINVAL;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2125  
779b783cfaa726 drivers/opp/core.c            Viresh Kumar        2018-05-22  2126  	/* Another CPU that shares the OPP table has set the regulators ? */
779b783cfaa726 drivers/opp/core.c            Viresh Kumar        2018-05-22  2127  	if (opp_table->regulators)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2128  		return 0;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2129  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2130  	opp_table->regulators = kmalloc_array(count,
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2131  					      sizeof(*opp_table->regulators),
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2132  					      GFP_KERNEL);
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2133  	if (!opp_table->regulators)
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2134  		return -ENOMEM;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2135  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2136  	for (i = 0; i < count; i++) {
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2137  		reg = regulator_get_optional(dev, names[i]);
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2138  		if (IS_ERR(reg)) {
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2139  			ret = dev_err_probe(dev, PTR_ERR(reg),
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2140  					    "%s: no regulator (%s) found\n",
543256d239b415 drivers/opp/core.c            Krzysztof Kozlowski 2022-04-08  2141  					    __func__, names[i]);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2142  			goto free_regulators;
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2143  		}
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2144  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2145  		opp_table->regulators[i] = reg;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2146  	}
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2147  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2148  	opp_table->regulator_count = count;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2149  
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2150  	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2151  	if (!supplies) {
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2152  		ret = -ENOMEM;
947355850fcb3b drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2153  		goto free_regulators;
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2154  	}
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2155  
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2156  	mutex_lock(&opp_table->lock);
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2157  	opp_table->sod_supplies = supplies;
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2158  	if (opp_table->set_opp_data) {
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2159  		opp_table->set_opp_data->old_opp.supplies = supplies;
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2160  		opp_table->set_opp_data->new_opp.supplies = supplies + count;
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2161  	}
38bb34393804b7 drivers/opp/core.c            Viresh Kumar        2021-01-19  2162  	mutex_unlock(&opp_table->lock);
947355850fcb3b drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2163  
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2164  	return 0;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2165  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2166  free_regulators:
24957db1004353 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2167  	while (i != 0)
24957db1004353 drivers/opp/core.c            Marek Szyprowski    2019-10-17  2168  		regulator_put(opp_table->regulators[--i]);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2169  
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2170  	kfree(opp_table->regulators);
dfbe4678d709e2 drivers/base/power/opp/core.c Viresh Kumar        2016-12-01  2171  	opp_table->regulators = NULL;
46f48aca2e5aef drivers/opp/core.c            Viresh Kumar        2018-12-11  2172  	opp_table->regulator_count = -1;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2173  
b0ec09428621da drivers/opp/core.c            Viresh Kumar        2022-07-04  2174  	return ret;
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2175  }
9f8ea969d5cfdd drivers/base/power/opp/core.c Viresh Kumar        2016-02-09  2176  

:::::: The code at line 2113 was first introduced by commit
:::::: 9f8ea969d5cfdd4353d2adb004e8e2286b984369 PM / OPP: get/put regulators from OPP core

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
