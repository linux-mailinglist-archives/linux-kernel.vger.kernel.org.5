Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E77A6BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjISTxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjISTxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:53:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D98F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153189; x=1726689189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geHwA3OeDB3eBBn9jJ8anp9OdK21qswmKQE2nVcMoVw=;
  b=l0XZJ+cbjn2wJejj7QsmshcSxpnqqKa9FzvfcNIr+W+PJhEYdnLL0N7f
   2S5Y2X8Nkz6W1tivjkWdqjn6pfO4veOCQWL8qy1sLDaDztBRYgjtfcI5M
   wX7Y1VToyQ2ulnHJmkpyIBpYtjCzu13ZjiHmne+4F4QRWXQkBKt+vvIRm
   lju52EWmFQ2QmMzy3TNG2PG9+jO5Va4zguE+K3pzl8xrJ+t3l8AXkzfs3
   +7R/eShkmrQERRoM1OJKMp/2evgDi9oF0FqAMm2Xa7/K9nOV6V/D3P1gw
   iJZkfBeMrR3Gep2TVI0+6GAE8lFI9SBwGFINIV0flN0Gt5XJv7WSPmEDG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410969233"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410969233"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="1077112204"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="1077112204"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2023 12:53:07 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qigmP-0007rA-06;
        Tue, 19 Sep 2023 19:53:05 +0000
Date:   Wed, 20 Sep 2023 03:52:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Retrieve supplies from DT
Message-ID: <202309200316.ACh8kKEW-lkp@intel.com>
References: <20230919061755.3412016-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919061755.3412016-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 451e85e29c9d6f20639d4cfcff4b9dea280178cc]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-userspace-consumer-Retrieve-supplies-from-DT/20230919-141840
base:   451e85e29c9d6f20639d4cfcff4b9dea280178cc
patch link:    https://lore.kernel.org/r/20230919061755.3412016-1-naresh.solanki%409elements.com
patch subject: [PATCH] regulator: userspace-consumer: Retrieve supplies from DT
config: i386-randconfig-014-20230919 (https://download.01.org/0day-ci/archive/20230920/202309200316.ACh8kKEW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200316.ACh8kKEW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200316.ACh8kKEW-lkp@intel.com/

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
