Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119267996D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjIIIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjIIIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:05:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE819BA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694246755; x=1725782755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qgclq8CPOgKk8H4kSoQbCWxgSCvCuniQV8vHrOX5+YQ=;
  b=irvts7Fzn4mTJv8btUPftQ510j6MiQ1GzIYOuni9GiGHgBNkajqPgkH5
   GpMwcOFUDq74qO46XtZjLeFUZiq3sURdYeptmevEWYcUcfoU0C6m0rLZF
   viUj1C9ExsIkrAazIu7MJ/+70cDlOEwIcKwBXaQKPU8py0yi3TwaFTbLm
   rEgiX2N9wymEDmx35+ntWtVvWKNmbJeXQsETlQyIxS096K/JV6WQJC4qv
   DWuVRJEsp/8GGS5B0o32D0NHd9z1c812s3EmdGYUC25rVLWgr6Yc6OINS
   KeSgC0gB5O1ha/mPl8S08bBVwEQqedtprXLzfbaBWmeNFwX68LC3qM9gn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362853638"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="362853638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 01:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812803563"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="812803563"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2023 01:05:53 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qesyW-00037i-05;
        Sat, 09 Sep 2023 08:05:52 +0000
Date:   Sat, 9 Sep 2023 16:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:2809: warning: Function parameter or member
 'token' not described in 'dev_pm_opp_clear_config'
Message-ID: <202309091558.x3JJrxFI-lkp@intel.com>
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
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 11b9b663585c4f8b00846089ebbca4d1e3283e86 OPP: Add dev_pm_opp_set_config() and friends
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091558.x3JJrxFI-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091558.x3JJrxFI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091558.x3JJrxFI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:2113: warning: Excess function parameter 'count' description in 'dev_pm_opp_set_regulators'
   drivers/opp/core.c:2251: warning: Excess function parameter 'count' description in 'devm_pm_opp_set_regulators'
>> drivers/opp/core.c:2809: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
>> drivers/opp/core.c:2809: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2809 drivers/opp/core.c

  2794	
  2795	/**
  2796	 * dev_pm_opp_clear_config() - Releases resources blocked for OPP configuration.
  2797	 * @opp_table: OPP table returned from dev_pm_opp_set_config().
  2798	 *
  2799	 * This allows all device OPP configurations to be cleared at once. This must be
  2800	 * called once for each call made to dev_pm_opp_set_config(), in order to free
  2801	 * the OPPs properly.
  2802	 *
  2803	 * Currently the first call itself ends up freeing all the OPP configurations,
  2804	 * while the later ones only drop the OPP table reference. This works well for
  2805	 * now as we would never want to use an half initialized OPP table and want to
  2806	 * remove the configurations together.
  2807	 */
  2808	void dev_pm_opp_clear_config(int token)
> 2809	{
  2810		struct opp_config_data *data;
  2811	
  2812		/*
  2813		 * This lets the callers call this unconditionally and keep their code
  2814		 * simple.
  2815		 */
  2816		if (unlikely(token <= 0))
  2817			return;
  2818	
  2819		data = xa_erase(&opp_configs, token);
  2820		if (WARN_ON(!data))
  2821			return;
  2822	
  2823		_opp_clear_config(data);
  2824	}
  2825	EXPORT_SYMBOL_GPL(dev_pm_opp_clear_config);
  2826	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
