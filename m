Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA3799774
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbjIIKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIIKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:50:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540410FA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694256612; x=1725792612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jBF9UUw92i6Jdvyg4+vrgTVAmTYw3v8TbaMzVFJhzLo=;
  b=aVglJ0VhLS7EasFHQHpfjMW5RhKSNNgkcpY6oScXy0g2z+C6v+MJxKF+
   JthvVrJMhFvc2Bzx2HDSzqH/4PO6BaKz03f47Fn9t46ewl/N7Ui2ixaXy
   AMiwPXt36sWbyVBwJ9Q4IGgkcNKXQ6Jd6u4abp9Yoe7NMRPmbyP5o75Pn
   chAb5XjdiNhJXX42XNfbIsHTnYwbzZc7YIQGFOe20UYuUPjT/o3oYGqYL
   y3l/xiODLW4lyorp8J/B96Iw2Bbe8zeoW5VY/DvTMbBKsGjEpvnmOiH3Z
   lPC49LUIOiHhbA1mhtyM1tWVuKx9ACm061sUZmD3L/npIPd4twuU5COC6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464182909"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="464182909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 03:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="772024262"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="772024262"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2023 03:50:10 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qevXT-0003Km-2U;
        Sat, 09 Sep 2023 10:50:07 +0000
Date:   Sat, 9 Sep 2023 18:49:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:1967: warning: Function parameter or member
 'opp_table' not described in '_opp_set_supported_hw'
Message-ID: <202309091848.KgU5T4Kb-lkp@intel.com>
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
commit: 89f03984fa2abface1ffb1fe050b7c175651ffc7 OPP: Migrate set-supported-hw API to use set-config helpers
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091848.KgU5T4Kb-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091848.KgU5T4Kb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091848.KgU5T4Kb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/opp/core.c:1967: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
>> drivers/opp/core.c:1967: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:2068: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:2068: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2709: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2709: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +1967 drivers/opp/core.c

38393409da345c drivers/base/power/opp.c      Viresh Kumar 2014-11-25  1953  
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1954  /**
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1955   * _opp_set_supported_hw() - Set supported platforms
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1956   * @dev: Device for which supported-hw has to be set.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1957   * @versions: Array of hierarchy of versions to match.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1958   * @count: Number of elements in the array.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1959   *
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1960   * This is required only for the V2 bindings, and it enables a platform to
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1961   * specify the hierarchy of versions it supports. OPP layer will then enable
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1962   * OPPs, which are available for those versions, based on its 'opp-supported-hw'
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1963   * property.
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1964   */
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1965  static int _opp_set_supported_hw(struct opp_table *opp_table,
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar 2017-01-23  1966  				 const u32 *versions, unsigned int count)
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09 @1967  {
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar 2018-05-22  1968  	/* Another CPU that shares the OPP table has set the property ? */
25419de1b8dda2 drivers/opp/core.c            Viresh Kumar 2018-05-22  1969  	if (opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1970  		return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1971  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1972  	opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1973  					GFP_KERNEL);
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1974  	if (!opp_table->supported_hw)
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1975  		return -ENOMEM;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1976  
2c2709dc6921c5 drivers/base/power/opp/core.c Viresh Kumar 2016-02-16  1977  	opp_table->supported_hw_count = count;
fa30184d192ec7 drivers/base/power/opp/core.c Viresh Kumar 2017-01-23  1978  
89f03984fa2abf drivers/opp/core.c            Viresh Kumar 2022-05-26  1979  	return 0;
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1980  }
7de36b0aa51a5a drivers/base/power/opp/core.c Viresh Kumar 2015-12-09  1981  

:::::: The code at line 1967 was first introduced by commit
:::::: 7de36b0aa51a5a59e28fb2da768fa3ab07de0674 PM / OPP: Parse 'opp-supported-hw' binding

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
