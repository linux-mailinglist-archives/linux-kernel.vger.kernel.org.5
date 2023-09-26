Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2647AF1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjIZRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIZRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:23:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E55180;
        Tue, 26 Sep 2023 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695749002; x=1727285002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qjVC/s4j7SxQRGeSzIg7naJ8oHI9PB59wRQgY2RtkPE=;
  b=Gq6PY16UWxKVSSvV5/9Oh9wXMb/Tk7I/EsLqoPWGppz/RUQMt8/FLnmX
   DKnNKJOPpPy06ucDcbGexVuQjHJfmpjrKQiQOP/J6NZ2C5djUkDgTyqVP
   ET7qEeu66QeQBHDFH0w8RC8FqbaU7CIjZVUKlQRYhTyD4O+W1yK/Tzv4N
   w9AHvvfpqg3tvnWdTrdJM4zrAZf2KTAP99k0tJ3FsDQC/JmeZ7rO6d2S9
   saM2NUmqza2BvdbGzT7ZgLkCK2IKYI7staLqWcu08v1iMUEbiPm8E/llj
   b1B+umLtG3xZ0XLFXO9E3Aa/nQv0000BQNrzh6BkE5SKz66grtCmAziRO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381520625"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381520625"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="235632"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2023 10:21:23 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlBkp-0003Ap-2V;
        Tue, 26 Sep 2023 17:21:48 +0000
Date:   Wed, 27 Sep 2023 01:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: Re: [PATCH v4 11/18] PM: EM: Add runtime update interface to modify
 EM power
Message-ID: <202309270106.c56Z2Tci-lkp@intel.com>
References: <20230925081139.1305766-12-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925081139.1305766-12-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/thermal linus/master v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/PM-EM-Add-missing-newline-for-the-message-log/20230925-181243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230925081139.1305766-12-lukasz.luba%40arm.com
patch subject: [PATCH v4 11/18] PM: EM: Add runtime update interface to modify EM power
config: i386-randconfig-063-20230926 (https://download.01.org/0day-ci/archive/20230927/202309270106.c56Z2Tci-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270106.c56Z2Tci-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270106.c56Z2Tci-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/power/energy_model.c:125:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table *tmp @@     got struct em_perf_table [noderef] __rcu *runtime_table @@
   kernel/power/energy_model.c:125:13: sparse:     expected struct em_perf_table *tmp
   kernel/power/energy_model.c:125:13: sparse:     got struct em_perf_table [noderef] __rcu *runtime_table
>> kernel/power/energy_model.c:613:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/power/energy_model.c:613:27: sparse:    struct em_perf_table [noderef] __rcu *
>> kernel/power/energy_model.c:613:27: sparse:    struct em_perf_table *

vim +613 kernel/power/energy_model.c

   569	
   570	/**
   571	 * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a device
   572	 * @dev		: Device for which the EM is registered
   573	 *
   574	 * Unregister the EM for the specified @dev (but not a CPU device).
   575	 */
   576	void em_dev_unregister_perf_domain(struct device *dev)
   577	{
   578		struct em_perf_table __rcu *runtime_table;
   579		struct em_perf_domain *pd;
   580	
   581		if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
   582			return;
   583	
   584		if (_is_cpu_device(dev))
   585			return;
   586	
   587		pd = dev->em_pd;
   588		/*
   589		 * The mutex separates all register/unregister requests and protects
   590		 * from potential clean-up/setup issues in the debugfs directories.
   591		 * The debugfs directory name is the same as device's name.
   592		 * The lock also protects the updater of the runtime modifiable
   593		 * EM and this remover.
   594		 */
   595		mutex_lock(&em_pd_mutex);
   596	
   597		em_debug_remove_pd(dev);
   598	
   599		runtime_table = pd->runtime_table;
   600	
   601		/*
   602		 * Safely destroy runtime modifiable EM. By using the call
   603		 * synchronize_rcu() we make sure we don't progress till last user
   604		 * finished the RCU section and our update got applied.
   605		 */
   606		rcu_assign_pointer(pd->runtime_table, NULL);
   607		synchronize_rcu();
   608	
   609		/*
   610		 * After the sync no updates will be in-flight, so free the
   611		 * memory allocated for runtime table (if there was such).
   612		 */
 > 613		if (runtime_table != pd->default_table) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
