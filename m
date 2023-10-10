Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D197C01ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJJQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjJJQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:48:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696956497; x=1728492497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8TD8fyZB8TbIJUDFLIBu/enOaX3wuVvp6P9AD7yJDE=;
  b=mVgkJ9Av+YfxvY4HvSBBYq873f1w8nry0C6whePtCRynVfAEztYcKQBM
   SajOlaD90PiN1ZcW5i9xfeJg+RhvSftejyeFvHhCzxO/hWgrdSNA07BYr
   1GMtMP/cfXeUBMiaweSDiSSdUUIHaikDcJcQt/OiJnm/iY9z7ctvRSH4C
   CSCjTeVrdTeB3moHVqLXJZwcry6T5J8PmhWLOsk4+gCB89DFYWQBXypjl
   Myk1tiPTlgQWjrNTHPeRCex+BLGCGZFAEmjN9nbUKuUWC2RPVUZpjchFg
   qsTqxOyrRn/LWNw1lCll6Ssn6DWzVHWlWwjnTpRU6hNJNEgCGzHMsfWaM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388319652"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="388319652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927221129"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="927221129"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Oct 2023 09:47:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqFt7-0000m0-2Y;
        Tue, 10 Oct 2023 16:47:17 +0000
Date:   Wed, 11 Oct 2023 00:47:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: userspace-consumer: Retrieve supplies
 from DT
Message-ID: <202310110043.uMSq3kAw-lkp@intel.com>
References: <20231004121010.1192344-2-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004121010.1192344-2-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on f9a1d31874c383f58bb4f89bfe79b764682cd026]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-userspace-consumer-Retrieve-supplies-from-DT/20231004-201151
base:   f9a1d31874c383f58bb4f89bfe79b764682cd026
patch link:    https://lore.kernel.org/r/20231004121010.1192344-2-naresh.solanki%409elements.com
patch subject: [PATCH v2 2/3] regulator: userspace-consumer: Retrieve supplies from DT
config: x86_64-buildonly-randconfig-003-20231010 (https://download.01.org/0day-ci/archive/20231011/202310110043.uMSq3kAw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110043.uMSq3kAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110043.uMSq3kAw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/userspace-consumer.c: In function 'get_num_supplies':
   drivers/regulator/userspace-consumer.c:139:9: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
     139 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         for_each_child_of_node
   drivers/regulator/userspace-consumer.c:139:59: error: expected ';' before '{' token
     139 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                           ^~
         |                                                           ;
   drivers/regulator/userspace-consumer.c:137:13: warning: unused variable 'num_supplies' [-Wunused-variable]
     137 |         int num_supplies = 0;
         |             ^~~~~~~~~~~~
>> drivers/regulator/userspace-consumer.c:144:1: error: no return statement in function returning non-void [-Werror=return-type]
     144 | }
         | ^
   drivers/regulator/userspace-consumer.c: In function 'regulator_userspace_consumer_probe':
   drivers/regulator/userspace-consumer.c:170:67: error: expected ';' before '{' token
     170 |                 for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                                   ^~
         |                                                                   ;
   drivers/regulator/userspace-consumer.c: At top level:
   drivers/regulator/userspace-consumer.c:121:15: warning: 'prop_supply_name' defined but not used [-Wunused-function]
     121 | static size_t prop_supply_name(char *prop_name)
         |               ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +144 drivers/regulator/userspace-consumer.c

   133	
   134	static int get_num_supplies(struct platform_device *pdev)
   135	{
   136		struct  property *prop;
   137		int num_supplies = 0;
   138	
   139		for_each_property_of_node(pdev->dev.of_node, prop) {
   140			if (prop_supply_name(prop->name))
   141				num_supplies++;
   142		}
   143		return num_supplies;
 > 144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
