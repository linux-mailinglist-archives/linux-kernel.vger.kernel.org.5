Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526457998AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbjIINf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIINf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:35:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D0D12B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694266523; x=1725802523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dzTDb+rbzDlxMvyXj5wfCQ+vb5o5IwOugPWV6O5Wl18=;
  b=IQQz8saABuwzEOuE1cgg4uqkmpfxvJnooQQ2dQcPysy5DZjS63QWlX8Y
   8NJunGG47CoC5hZ+oiag2Agl+vobU0olsv+czs11YTeBiGDK7xquZmz92
   m9wHMlw6KOLavj43fHBS3mKllhBSuDkcGsLPwTzAaC4CibNURsuzGOwg8
   VYAxyvCz8BN8PiKltrhkbD3Q1NDXXYH63+Ym92NP7xEKR2O7fgYO4P/V4
   iPt9F4j4LwD168rIuVIq2FUbhSlD/vs8zTP4sA/ESGw1Jm1YGIJWzWr4z
   YLFCTwe8q8ley6AG+w+CbASwPVbegaOKf9QalB+JueJH11TidZp3UWPQ7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464190332"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="464190332"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 06:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="1073618275"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="1073618275"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2023 06:35:22 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qey7M-0003Y8-0S;
        Sat, 09 Sep 2023 13:35:20 +0000
Date:   Sat, 9 Sep 2023 21:35:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:2331: warning: Function parameter or member
 'opp_table' not described in '_opp_attach_genpd'
Message-ID: <202309092131.Z35nBw8N-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 442e7a1786e628b38175314ec1805966b8d0c02c OPP: Migrate attach-genpd API to use set-config helpers
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309092131.Z35nBw8N-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309092131.Z35nBw8N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309092131.Z35nBw8N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1967: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1967: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:2068: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:2068: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2181: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
   drivers/opp/core.c:2245: warning: Function parameter or member 'opp_table' not described in '_opp_register_set_opp_helper'
>> drivers/opp/core.c:2331: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
   drivers/opp/core.c:2555: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2555: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2331 drivers/opp/core.c

6319aee10e5303 Viresh Kumar    2019-05-08  2306  
4f018bc0e1cfde Viresh Kumar    2018-06-26  2307  /**
442e7a1786e628 Viresh Kumar    2022-05-26  2308   * _opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
6319aee10e5303 Viresh Kumar    2019-05-08  2309   * @dev: Consumer device for which the genpd is getting attached.
6319aee10e5303 Viresh Kumar    2019-05-08  2310   * @names: Null terminated array of pointers containing names of genpd to attach.
17a8f868ae3e85 Viresh Kumar    2019-07-08  2311   * @virt_devs: Pointer to return the array of virtual devices.
4f018bc0e1cfde Viresh Kumar    2018-06-26  2312   *
4f018bc0e1cfde Viresh Kumar    2018-06-26  2313   * Multiple generic power domains for a device are supported with the help of
4f018bc0e1cfde Viresh Kumar    2018-06-26  2314   * virtual genpd devices, which are created for each consumer device - genpd
4f018bc0e1cfde Viresh Kumar    2018-06-26  2315   * pair. These are the device structures which are attached to the power domain
4f018bc0e1cfde Viresh Kumar    2018-06-26  2316   * and are required by the OPP core to set the performance state of the genpd.
6319aee10e5303 Viresh Kumar    2019-05-08  2317   * The same API also works for the case where single genpd is available and so
6319aee10e5303 Viresh Kumar    2019-05-08  2318   * we don't need to support that separately.
4f018bc0e1cfde Viresh Kumar    2018-06-26  2319   *
4f018bc0e1cfde Viresh Kumar    2018-06-26  2320   * This helper will normally be called by the consumer driver of the device
6319aee10e5303 Viresh Kumar    2019-05-08  2321   * "dev", as only that has details of the genpd names.
4f018bc0e1cfde Viresh Kumar    2018-06-26  2322   *
6319aee10e5303 Viresh Kumar    2019-05-08  2323   * This helper needs to be called once with a list of all genpd to attach.
6319aee10e5303 Viresh Kumar    2019-05-08  2324   * Otherwise the original device structure will be used instead by the OPP core.
baea35e4db17a7 Viresh Kumar    2019-07-17  2325   *
baea35e4db17a7 Viresh Kumar    2019-07-17  2326   * The order of entries in the names array must match the order in which
baea35e4db17a7 Viresh Kumar    2019-07-17  2327   * "required-opps" are added in DT.
4f018bc0e1cfde Viresh Kumar    2018-06-26  2328   */
442e7a1786e628 Viresh Kumar    2022-05-26  2329  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
3734b9f2cee01d Dmitry Osipenko 2021-09-27  2330  			const char * const *names, struct device ***virt_devs)
4f018bc0e1cfde Viresh Kumar    2018-06-26 @2331  {
6319aee10e5303 Viresh Kumar    2019-05-08  2332  	struct device *virt_dev;
baea35e4db17a7 Viresh Kumar    2019-07-17  2333  	int index = 0, ret = -EINVAL;
3734b9f2cee01d Dmitry Osipenko 2021-09-27  2334  	const char * const *name = names;
4f018bc0e1cfde Viresh Kumar    2018-06-26  2335  
cb60e9602cce15 Viresh Kumar    2020-08-31  2336  	if (opp_table->genpd_virt_devs)
442e7a1786e628 Viresh Kumar    2022-05-26  2337  		return 0;
4f018bc0e1cfde Viresh Kumar    2018-06-26  2338  
6319aee10e5303 Viresh Kumar    2019-05-08  2339  	/*
6319aee10e5303 Viresh Kumar    2019-05-08  2340  	 * If the genpd's OPP table isn't already initialized, parsing of the
6319aee10e5303 Viresh Kumar    2019-05-08  2341  	 * required-opps fail for dev. We should retry this after genpd's OPP
6319aee10e5303 Viresh Kumar    2019-05-08  2342  	 * table is added.
6319aee10e5303 Viresh Kumar    2019-05-08  2343  	 */
442e7a1786e628 Viresh Kumar    2022-05-26  2344  	if (!opp_table->required_opp_count)
442e7a1786e628 Viresh Kumar    2022-05-26  2345  		return -EPROBE_DEFER;
6319aee10e5303 Viresh Kumar    2019-05-08  2346  
4f018bc0e1cfde Viresh Kumar    2018-06-26  2347  	mutex_lock(&opp_table->genpd_virt_dev_lock);
4f018bc0e1cfde Viresh Kumar    2018-06-26  2348  
c0ab9e0812da8e Viresh Kumar    2019-05-08  2349  	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
c0ab9e0812da8e Viresh Kumar    2019-05-08  2350  					     sizeof(*opp_table->genpd_virt_devs),
c0ab9e0812da8e Viresh Kumar    2019-05-08  2351  					     GFP_KERNEL);
c0ab9e0812da8e Viresh Kumar    2019-05-08  2352  	if (!opp_table->genpd_virt_devs)
c0ab9e0812da8e Viresh Kumar    2019-05-08  2353  		goto unlock;
4f018bc0e1cfde Viresh Kumar    2018-06-26  2354  
6319aee10e5303 Viresh Kumar    2019-05-08  2355  	while (*name) {
6319aee10e5303 Viresh Kumar    2019-05-08  2356  		if (index >= opp_table->required_opp_count) {
6319aee10e5303 Viresh Kumar    2019-05-08  2357  			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
6319aee10e5303 Viresh Kumar    2019-05-08  2358  				*name, opp_table->required_opp_count, index);
6319aee10e5303 Viresh Kumar    2019-05-08  2359  			goto err;
6319aee10e5303 Viresh Kumar    2019-05-08  2360  		}
4f018bc0e1cfde Viresh Kumar    2018-06-26  2361  
6319aee10e5303 Viresh Kumar    2019-05-08  2362  		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
4ea9496cbc959e Tang Bin        2022-05-24  2363  		if (IS_ERR_OR_NULL(virt_dev)) {
4ea9496cbc959e Tang Bin        2022-05-24  2364  			ret = PTR_ERR(virt_dev) ? : -ENODEV;
6319aee10e5303 Viresh Kumar    2019-05-08  2365  			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
6319aee10e5303 Viresh Kumar    2019-05-08  2366  			goto err;
4f018bc0e1cfde Viresh Kumar    2018-06-26  2367  		}
4f018bc0e1cfde Viresh Kumar    2018-06-26  2368  
4f018bc0e1cfde Viresh Kumar    2018-06-26  2369  		opp_table->genpd_virt_devs[index] = virt_dev;
baea35e4db17a7 Viresh Kumar    2019-07-17  2370  		index++;
6319aee10e5303 Viresh Kumar    2019-05-08  2371  		name++;
6319aee10e5303 Viresh Kumar    2019-05-08  2372  	}
6319aee10e5303 Viresh Kumar    2019-05-08  2373  
17a8f868ae3e85 Viresh Kumar    2019-07-08  2374  	if (virt_devs)
17a8f868ae3e85 Viresh Kumar    2019-07-08  2375  		*virt_devs = opp_table->genpd_virt_devs;
4f018bc0e1cfde Viresh Kumar    2018-06-26  2376  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
4f018bc0e1cfde Viresh Kumar    2018-06-26  2377  
442e7a1786e628 Viresh Kumar    2022-05-26  2378  	return 0;
6319aee10e5303 Viresh Kumar    2019-05-08  2379  
6319aee10e5303 Viresh Kumar    2019-05-08  2380  err:
442e7a1786e628 Viresh Kumar    2022-05-26  2381  	_detach_genpd(opp_table);
c0ab9e0812da8e Viresh Kumar    2019-05-08  2382  unlock:
6319aee10e5303 Viresh Kumar    2019-05-08  2383  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
442e7a1786e628 Viresh Kumar    2022-05-26  2384  	return ret;
6319aee10e5303 Viresh Kumar    2019-05-08  2385  

:::::: The code at line 2331 was first introduced by commit
:::::: 4f018bc0e1cfdec2e25072db9fecc1f363ba79ea OPP: Add dev_pm_opp_{set|put}_genpd_virt_dev() helper

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Viresh Kumar <viresh.kumar@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
