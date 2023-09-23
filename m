Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D67AC0CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjIWKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIWKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D9194
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695465920; x=1727001920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ne1L2SX659vWY1O8tzgihrrpmyg4HBNO9E1cRuo201s=;
  b=E+W1UuRPQ3Qo6FzGWGlvr+EWSP4bc3R3ONUfB4aYNPfNQonIpoTr6o9u
   4ISktdPviYg2SZCYTDKZzHWjIV+Uid1ht8pwKDb4ldIDZIAzOEWLiYLvI
   UkCDhtU4AHl/5Eqmyqsp94ydVPXIXFSN5p+M8X/QahRxubAe41nuskTcg
   T6Y+6JJbSdUOsgi8551nDUiU/KYdxZxEmLhn0xNFuovwk5HrJdNZlZQGA
   xw/REcNXqOAIwiV5Qi5EFDEbo9PC1cBVX9USwKcO+RwnIMAdPVeeWXyI9
   /7bfEJGgbHTaKSIxY70RV8oHhtAa1rU47Qlxi5jiT8g2pQLZOf7lfJwlT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383766333"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="383766333"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="994831199"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="994831199"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2023 03:45:17 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk08R-00029t-30;
        Sat, 23 Sep 2023 10:45:15 +0000
Date:   Sat, 23 Sep 2023 18:44:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies
 from DT
Message-ID: <202309231829.VrGZUH4E-lkp@intel.com>
References: <20230922090330.1570350-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922090330.1570350-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 451e85e29c9d6f20639d4cfcff4b9dea280178cc]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-userspace-consumer-Retrieve-supplies-from-DT/20230922-170527
base:   451e85e29c9d6f20639d4cfcff4b9dea280178cc
patch link:    https://lore.kernel.org/r/20230922090330.1570350-1-naresh.solanki%409elements.com
patch subject: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies from DT
config: x86_64-randconfig-161-20230923 (https://download.01.org/0day-ci/archive/20230923/202309231829.VrGZUH4E-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309231829.VrGZUH4E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309231829.VrGZUH4E-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/userspace-consumer.c: In function 'get_num_supplies':
>> drivers/regulator/userspace-consumer.c:126:9: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
     126 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         for_each_child_of_node
>> drivers/regulator/userspace-consumer.c:126:59: error: expected ';' before '{' token
     126 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                           ^~
         |                                                           ;
   drivers/regulator/userspace-consumer.c:124:13: warning: unused variable 'num_supplies' [-Wunused-variable]
     124 |         int num_supplies = 0;
         |             ^~~~~~~~~~~~
   drivers/regulator/userspace-consumer.c:136:1: error: no return statement in function returning non-void [-Werror=return-type]
     136 | }
         | ^
   drivers/regulator/userspace-consumer.c: In function 'regulator_userspace_consumer_probe':
   drivers/regulator/userspace-consumer.c:162:67: error: expected ';' before '{' token
     162 |                 for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                                   ^~
         |                                                                   ;
   cc1: some warnings being treated as errors


vim +126 drivers/regulator/userspace-consumer.c

   120	
   121	static int get_num_supplies(struct platform_device *pdev)
   122	{
   123		struct  property *prop;
   124		int num_supplies = 0;
   125	
 > 126		for_each_property_of_node(pdev->dev.of_node, prop) {
   127			const char *prop_name = prop->name;
   128			int len = strlen(prop_name);
   129	
   130			if (len > SUPPLY_SUFFIX_LEN &&
   131			    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
   132				num_supplies++;
   133			}
   134		}
   135		return num_supplies;
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
