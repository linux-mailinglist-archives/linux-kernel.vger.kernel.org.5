Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97E78CEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjH2VZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbjH2VYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:24:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EEFCC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693344292; x=1724880292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Shi7/IOyOuxY2qAg8pV9u6oOZl8+1AUEhzjUzRoeB10=;
  b=eVmSNu61mdXhHEdLREcL9Zyp9d0aU4La+OcnaMRuUlvX7wVwHFzTN+gA
   o4TXOylKPtdGdUshUvQmtJ73RuPDUzBKu+PY/uvKtIYMfvbrof6lqYJ+d
   xNxTSNgF8QgLEZfFMoGHVnZbcEvKp8FlLyaakhqzyRfaHJNaBEFAgNF8j
   +M1lCtdDu5P+Ev8sUpjbPaziGUnqezfvbeZyGHfhtppZeqICIQPcq0SH8
   SmrOWgZNjJeJ8v8NbVm4Cue20XToRTmyCDBgit8ZpTp/hrMk6M3PPUUmZ
   e2CYLB6aoxXJ3aZ4l5GkaOmzzZS3xPUBDN/Qlxe22rTYpkF9SRJ7EHWj2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="375440897"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="375440897"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741992117"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="741992117"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 14:24:49 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb6Ce-00095d-1j;
        Tue, 29 Aug 2023 21:24:48 +0000
Date:   Wed, 30 Aug 2023 05:24:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies
 from DT
Message-ID: <202308300533.15rJTpNI-lkp@intel.com>
References: <20230829141413.2605621-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829141413.2605621-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8950c4a350c188deb5f5b05df3244d4db82fe3d8]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-userspace-consumer-Retrieve-supplies-from-DT/20230829-222520
base:   8950c4a350c188deb5f5b05df3244d4db82fe3d8
patch link:    https://lore.kernel.org/r/20230829141413.2605621-1-Naresh.Solanki%409elements.com
patch subject: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies from DT
config: s390-randconfig-r016-20230830 (https://download.01.org/0day-ci/archive/20230830/202308300533.15rJTpNI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300533.15rJTpNI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300533.15rJTpNI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/regulator/userspace-consumer.c: In function 'get_num_supplies':
>> drivers/regulator/userspace-consumer.c:164:9: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
     164 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         for_each_child_of_node
>> drivers/regulator/userspace-consumer.c:164:59: error: expected ';' before '{' token
     164 |         for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                           ^~
         |                                                           ;
>> drivers/regulator/userspace-consumer.c:162:13: warning: unused variable 'num_supplies' [-Wunused-variable]
     162 |         int num_supplies = 0;
         |             ^~~~~~~~~~~~
   drivers/regulator/userspace-consumer.c:174:1: error: no return statement in function returning non-void [-Werror=return-type]
     174 | }
         | ^
   drivers/regulator/userspace-consumer.c: In function 'regulator_userspace_consumer_probe':
   drivers/regulator/userspace-consumer.c:200:67: error: expected ';' before '{' token
     200 |                 for_each_property_of_node(pdev->dev.of_node, prop) {
         |                                                                   ^~
         |                                                                   ;
   cc1: some warnings being treated as errors


vim +164 drivers/regulator/userspace-consumer.c

   158	
   159	static int get_num_supplies(struct platform_device *pdev)
   160	{
   161		struct  property *prop;
 > 162		int num_supplies = 0;
   163	
 > 164		for_each_property_of_node(pdev->dev.of_node, prop) {
   165			const char *prop_name = prop->name;
   166			int len = strlen(prop_name);
   167	
   168			if (len > SUPPLY_SUFFIX_LEN && \
   169			    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
   170				num_supplies++;
   171			}
   172		}
   173		return num_supplies;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
