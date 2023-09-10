Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD9799C56
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjIJCoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 22:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJCoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 22:44:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2A1B5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 19:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694313859; x=1725849859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BBrB4C8WENENbT69vmFWNvN4pRGJ44rD3Si2Hq7lPW4=;
  b=SyHUdFEaNZx/GU/GgIlAVjI9q8dcg0oOCz7ybPjwOs7bnoO97RD+HFuF
   PgmEyQmkWCs2JvuwEvQs8Ypskw+jhKTsPPj3sZ6Z+1wL/imXCM++NaGy9
   cvhczgFRgcaMI9JIjN6r726LWfImpjTAIHLYDOoUnWlt0H9AEP+vhtNGL
   ETHrc5KgGFvMRPmRuIrouFg09H5/nOGzJ70ikHvKRiQT935ANivGVkQDZ
   TT0DgE3Uf75yzUgAD7hcgsKvrGiN+mmHSqmZZnO8WPhMXeGklFTX8kQZy
   yYJPoEHxkhMwRdcsIQeIBENTa6+eZsX4eLzSXp8wFTyaCpjBnTrQU8+GQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="375232554"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="375232554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 19:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="772166798"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="772166798"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2023 19:44:17 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfAQo-0004Fs-38;
        Sun, 10 Sep 2023 02:44:14 +0000
Date:   Sun, 10 Sep 2023 10:43:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/opp/core.c:2304: warning: Function parameter or member
 'opp_table' not described in '_opp_set_config_regulators_helper'
Message-ID: <202309101018.J5Y4Fs3E-lkp@intel.com>
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
head:   a3c57ab79a06e333a869ae340420cb3c6f5921d3
commit: aee3352f6ecf8cfad1f1ee5838cfc4d37c6b8f75 OPP: Add support for config_regulators() helper
date:   1 year, 2 months ago
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230910/202309101018.J5Y4Fs3E-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309101018.J5Y4Fs3E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309101018.J5Y4Fs3E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/opp/core.c:1989: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
   drivers/opp/core.c:1989: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
   drivers/opp/core.c:2032: warning: Function parameter or member 'opp_table' not described in '_opp_set_prop_name'
   drivers/opp/core.c:2032: warning: Excess function parameter 'dev' description in '_opp_set_prop_name'
   drivers/opp/core.c:2073: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
   drivers/opp/core.c:2073: warning: Excess function parameter 'count' description in '_opp_set_regulators'
   drivers/opp/core.c:2186: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
   drivers/opp/core.c:2250: warning: Function parameter or member 'opp_table' not described in '_opp_register_set_opp_helper'
>> drivers/opp/core.c:2304: warning: Function parameter or member 'opp_table' not described in '_opp_set_config_regulators_helper'
   drivers/opp/core.c:2368: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
   drivers/opp/core.c:2602: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
   drivers/opp/core.c:2602: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'


vim +2304 drivers/opp/core.c

  2292	
  2293	/**
  2294	 * _opp_set_config_regulators_helper() - Register custom set regulator helper.
  2295	 * @dev: Device for which the helper is getting registered.
  2296	 * @config_regulators: Custom set regulator helper.
  2297	 *
  2298	 * This is useful to support platforms with multiple regulators per device.
  2299	 *
  2300	 * This must be called before any OPPs are initialized for the device.
  2301	 */
  2302	static int _opp_set_config_regulators_helper(struct opp_table *opp_table,
  2303			struct device *dev, config_regulators_t config_regulators)
> 2304	{
  2305		/* Another CPU that shares the OPP table has set the helper ? */
  2306		if (!opp_table->config_regulators)
  2307			opp_table->config_regulators = config_regulators;
  2308	
  2309		return 0;
  2310	}
  2311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
