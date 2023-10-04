Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF57B8815
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbjJDSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbjJDSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:12:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90859100
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696443119; x=1727979119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n4HyfSA5w24SFcZe2aU+tZ+XRrIqdPWBEKVvtjaa8iQ=;
  b=L/TtXsfo8CsHHDkD5Dnx7qQLWCfmCUGOLmxdnRY5PXgIgD8GKR5JiO/Q
   6EGe32aHwwRmhoyOKVZrqBq91zDujW+w+Ao7DxXJh1ws6xIKWb0+526IR
   NkB3OySSTGXsCjjAgYHbWy9WTU5Jn2RFQsfvC/zFs7+aQHioOC9xvJBlO
   YA5yIhhjdffDlqvByVxty48mK88SxipCTRGPODVr3nO2s0SrGLcfRlamk
   ON2Ru6PmVBXITJWjMy64gMBJoi8sC//Nl7OPdLW+d8nRrXXGYE/EgSPcD
   UzI39vK5ImpBluUKpV/qPy2OpchcvZSIEWNVl4Kvst/PX6S5lZsVbGXY4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383162303"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383162303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="895085121"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="895085121"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Oct 2023 11:10:29 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qo6Li-000KU6-09;
        Wed, 04 Oct 2023 18:11:54 +0000
Date:   Thu, 5 Oct 2023 02:11:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: userspace-consumer: Retrieve supplies
 from DT
Message-ID: <202310050133.mv0eecfC-lkp@intel.com>
References: <20231004121010.1192344-2-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004121010.1192344-2-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-buildonly-randconfig-003-20231004 (https://download.01.org/0day-ci/archive/20231005/202310050133.mv0eecfC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050133.mv0eecfC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050133.mv0eecfC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/regulator/userspace-consumer.c: In function 'get_num_supplies':
>> drivers/regulator/userspace-consumer.c:139:9: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
     139 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         for_each_child_of_node
>> drivers/regulator/userspace-consumer.c:139:59: error: expected ';' before '{' token
     139 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                           ^~
         |                                                           ;
   drivers/regulator/userspace-consumer.c:137:13: warning: unused variable 'num_supplies' [-Wunused-variable]
     137 |         int num_supplies = 0;
         |             ^~~~~~~~~~~~
   drivers/regulator/userspace-consumer.c:144:1: error: no return statement in function returning non-void [-Werror=return-type]
     144 | }
         | ^
   drivers/regulator/userspace-consumer.c: In function 'regulator_userspace_consumer_probe':
   drivers/regulator/userspace-consumer.c:170:67: error: expected ';' before '{' token
     170 |                 for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                                   ^~
         |                                                                   ;
   drivers/regulator/userspace-consumer.c: At top level:
>> drivers/regulator/userspace-consumer.c:121:15: warning: 'prop_supply_name' defined but not used [-Wunused-function]
     121 | static size_t prop_supply_name(char *prop_name)
         |               ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +139 drivers/regulator/userspace-consumer.c

   120	
 > 121	static size_t prop_supply_name(char *prop_name)
   122	{
   123		int len = strlen(prop_name);
   124	
   125		if (len <= SUPPLY_SUFFIX_LEN)
   126			return 0;
   127	
   128		if (strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0)
   129			return len - SUPPLY_SUFFIX_LEN;
   130	
   131		return 0;
   132	}
   133	
   134	static int get_num_supplies(struct platform_device *pdev)
   135	{
   136		struct  property *prop;
   137		int num_supplies = 0;
   138	
 > 139		for_each_property_of_node(pdev->dev.of_node, prop) {
   140			if (prop_supply_name(prop->name))
   141				num_supplies++;
   142		}
   143		return num_supplies;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
