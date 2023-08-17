Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5777FA44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352758AbjHQPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352742AbjHQPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:06:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B866106
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692284801; x=1723820801;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iQK4e/q4llsuAD9vidq4QQ9ZFfvTE3WDOhpB4WMrFnQ=;
  b=Y+BnadAWRIVjw/+WXH82Bbu3eCTS+/KDPmRMv6zJs6GQdPCxM6vopW+B
   EniRL/iSoPHHXafImQ6uzLzheHT4dqf9J+eJP3Zfn2lgmBqkSv2WDW+OE
   sp/ZIWuWUT355j7kRereJoJOAgCJa9KnnmjIv0hzp4K8wNJAniFKJMcgY
   6tfdbljqFqhzMxLdBKcJAMcfQiq81tUuubzHLcrmr5K+siJtfssLBt2FR
   QpGCHrICEMn3S50Jg9a78wx3ywOVZmYdfN5eHG8sslGI0pimjEA5nwV3l
   bB1FH/EVT51obDLc/9VhfjeFlNY8AUa88QTPKEEQKGExa1XUFUKc8Drg0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436752174"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436752174"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800084303"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="800084303"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 08:05:32 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWeYK-0001FT-2T;
        Thu, 17 Aug 2023 15:04:57 +0000
Date:   Thu, 17 Aug 2023 23:03:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/opp/cpu.c:45: warning: Function parameter or member
 'opp_table' not described in 'dev_pm_opp_init_cpufreq_table'
Message-ID: <202308172310.FzcidE4c-lkp@intel.com>
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

Hi Viresh,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: d613458332ccbab83c0600145d851796787305b4 OPP: Use consistent names for OPP table instances
date:   1 year, 1 month ago
config: i386-buildonly-randconfig-r006-20230817 (https://download.01.org/0day-ci/archive/20230817/202308172310.FzcidE4c-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172310.FzcidE4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172310.FzcidE4c-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/opp/cpu.c:45: warning: Function parameter or member 'opp_table' not described in 'dev_pm_opp_init_cpufreq_table'
>> drivers/opp/cpu.c:45: warning: Excess function parameter 'table' description in 'dev_pm_opp_init_cpufreq_table'
>> drivers/opp/cpu.c:98: warning: Function parameter or member 'opp_table' not described in 'dev_pm_opp_free_cpufreq_table'
>> drivers/opp/cpu.c:98: warning: Excess function parameter 'table' description in 'dev_pm_opp_free_cpufreq_table'


vim +45 drivers/opp/cpu.c

f59d3ee8480d30 drivers/base/power/opp/cpu.c  Viresh Kumar              2015-09-04   23  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   24  /**
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   25   * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   26   * @dev:	device for which we do this operation
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   27   * @table:	Cpufreq table returned back to caller
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   28   *
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   29   * Generate a cpufreq table for a provided device- this assumes that the
2c2709dc6921c5 drivers/base/power/opp/cpu.c  Viresh Kumar              2016-02-16   30   * opp table is already initialized and ready for usage.
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   31   *
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   32   * This function allocates required memory for the cpufreq table. It is
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   33   * expected that the caller does the required maintenance such as freeing
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   34   * the table as required.
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   35   *
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   36   * Returns -EINVAL for bad pointers, -ENODEV if the device is not found, -ENOMEM
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   37   * if no memory available for the operation (table is not populated), returns 0
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   38   * if successful and table is populated.
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   39   *
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   40   * WARNING: It is  important for the callers to ensure refreshing their copy of
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   41   * the table if any of the mentioned functions have been invoked in the interim.
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   42   */
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   43  int dev_pm_opp_init_cpufreq_table(struct device *dev,
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09   44  				  struct cpufreq_frequency_table **opp_table)
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  @45  {
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   46  	struct dev_pm_opp *opp;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   47  	struct cpufreq_frequency_table *freq_table = NULL;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   48  	int i, max_opps, ret = 0;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   49  	unsigned long rate;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   50  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   51  	max_opps = dev_pm_opp_get_opp_count(dev);
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   52  	if (max_opps <= 0)
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   53  		return max_opps ? max_opps : -ENODATA;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   54  
4a823c0be80fa9 drivers/opp/cpu.c             Jia-Ju Bai                2018-01-26   55  	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   56  	if (!freq_table)
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   57  		return -ENOMEM;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   58  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   59  	for (i = 0, rate = 0; i < max_opps; i++, rate++) {
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   60  		/* find next rate */
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   61  		opp = dev_pm_opp_find_freq_ceil(dev, &rate);
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   62  		if (IS_ERR(opp)) {
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   63  			ret = PTR_ERR(opp);
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   64  			goto out;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   65  		}
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   66  		freq_table[i].driver_data = i;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   67  		freq_table[i].frequency = rate / 1000;
79eea44a5d7b91 drivers/cpufreq/cpufreq_opp.c Bartlomiej Zolnierkiewicz 2015-07-29   68  
79eea44a5d7b91 drivers/cpufreq/cpufreq_opp.c Bartlomiej Zolnierkiewicz 2015-07-29   69  		/* Is Boost/turbo opp ? */
79eea44a5d7b91 drivers/cpufreq/cpufreq_opp.c Bartlomiej Zolnierkiewicz 2015-07-29   70  		if (dev_pm_opp_is_turbo(opp))
79eea44a5d7b91 drivers/cpufreq/cpufreq_opp.c Bartlomiej Zolnierkiewicz 2015-07-29   71  			freq_table[i].flags = CPUFREQ_BOOST_FREQ;
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   72  
8a31d9d94297b1 drivers/base/power/opp/cpu.c  Viresh Kumar              2017-01-23   73  		dev_pm_opp_put(opp);
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   74  	}
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   75  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   76  	freq_table[i].driver_data = i;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   77  	freq_table[i].frequency = CPUFREQ_TABLE_END;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   78  
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09   79  	*opp_table = &freq_table[0];
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   80  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   81  out:
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   82  	if (ret)
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   83  		kfree(freq_table);
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   84  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   85  	return ret;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   86  }
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   87  EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   88  
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   89  /**
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   90   * dev_pm_opp_free_cpufreq_table() - free the cpufreq table
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   91   * @dev:	device for which we do this operation
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   92   * @table:	table to free
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   93   *
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   94   * Free up the table allocated by dev_pm_opp_init_cpufreq_table
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   95   */
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05   96  void dev_pm_opp_free_cpufreq_table(struct device *dev,
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09   97  				   struct cpufreq_frequency_table **opp_table)
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  @98  {
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09   99  	if (!opp_table)
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  100  		return;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  101  
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09  102  	kfree(*opp_table);
d613458332ccba drivers/opp/cpu.c             Viresh Kumar              2022-06-09  103  	*opp_table = NULL;
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  104  }
a0dd7b79657bd6 drivers/cpufreq/cpufreq_opp.c Nishanth Menon            2014-05-05  105  EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
33692dc381f9b8 drivers/base/power/opp/cpu.c  Viresh Kumar              2015-09-04  106  #endif	/* CONFIG_CPU_FREQ */
f59d3ee8480d30 drivers/base/power/opp/cpu.c  Viresh Kumar              2015-09-04  107  

:::::: The code at line 45 was first introduced by commit
:::::: a0dd7b79657bd6644b914d16ce7f23468c44a7b4 PM / OPP: Move cpufreq specific OPP functions out of generic OPP library

:::::: TO: Nishanth Menon <nm@ti.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
