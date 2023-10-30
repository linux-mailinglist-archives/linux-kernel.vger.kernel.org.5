Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A457DB1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjJ3CHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:07:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7ABE;
        Sun, 29 Oct 2023 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698631630; x=1730167630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dbVY1ThUDo1weBPv8bgLKEZ7vpAIM1jDmAicjkFa74o=;
  b=OPrrqAennHFuo5x93Lu+aKsATqPdFBiYuqLGwt+aFoBkE2mmx5vEjqzI
   Av8z0mpF99iiFYBQ1Bt6d5az59MfdyDLDtOTim2ssi+dB55w9g6oMAg3J
   VogjA6/oDTQ3UDbqPJe+ep+qqKNI/R5MXSkswihdb/M+caQQiPcl2EX0x
   EfXG7Fi4HvdO8dmHLHOJYNMpGN2U6vPLCeInOKHvWYtO6yFimK7Y0qWLv
   scwnTavn26y/8KSc1UJrDPl5EhNbFPyMX5yl3bq0uU9wIrrPDdu7n1bmP
   sraO+35bHURWZkrOxW1zwpuzg3JFzcxLIX+BsWcUego4YgzN0l4+lEz0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="387812924"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="387812924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 19:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="876978077"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="876978077"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2023 19:07:07 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxHgH-000Cyp-2D;
        Mon, 30 Oct 2023 02:07:05 +0000
Date:   Mon, 30 Oct 2023 10:06:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Message-ID: <202310300959.8NLKyQDJ-lkp@intel.com>
References: <20231020130212.8919-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020130212.8919-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Savic/hwmon-Add-driver-for-Gigabyte-AORUS-Waterforce-AIO-coolers/20231020-210452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20231020130212.8919-1-savicaleksa83%40gmail.com
patch subject: [PATCH] hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231030/202310300959.8NLKyQDJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310300959.8NLKyQDJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310300959.8NLKyQDJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/gigabyte_waterforce.c:130:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     130 |                 if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/gigabyte_waterforce.c:155:7: note: uninitialized use occurs here
     155 |                 if (ret < 0)
         |                     ^~~
   drivers/hwmon/gigabyte_waterforce.c:130:3: note: remove the 'if' if its condition is always false
     130 |                 if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     131 |                         /* Data is up to date */
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     132 |                         goto unlock_and_return;
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     133 |                 }
         | ~~~~~~~~~~~~~~~~~
   drivers/hwmon/gigabyte_waterforce.c:127:9: note: initialize the variable 'ret' to silence this warning
     127 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +130 drivers/hwmon/gigabyte_waterforce.c

   124	
   125	static int waterforce_get_status(struct waterforce_data *priv)
   126	{
   127		int ret;
   128	
   129		if (!mutex_lock_interruptible(&priv->status_report_request_mutex)) {
 > 130			if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
   131				/* Data is up to date */
   132				goto unlock_and_return;
   133			}
   134	
   135			/*
   136			 * Disable raw event parsing for a moment to safely reinitialize the
   137			 * completion. Reinit is done because hidraw could have triggered
   138			 * the raw event parsing and marked the priv->status_report_received
   139			 * completion as done.
   140			 */
   141			spin_lock_bh(&priv->status_report_request_lock);
   142			reinit_completion(&priv->status_report_received);
   143			spin_unlock_bh(&priv->status_report_request_lock);
   144	
   145			/* Send command for getting status */
   146			ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
   147			if (ret < 0)
   148				return ret;
   149	
   150			if (wait_for_completion_interruptible_timeout
   151			    (&priv->status_report_received, msecs_to_jiffies(STATUS_VALIDITY)) <= 0)
   152				ret = -ENODATA;
   153	unlock_and_return:
   154			mutex_unlock(&priv->status_report_request_mutex);
   155			if (ret < 0)
   156				return ret;
   157		} else {
   158			return -ENODATA;
   159		}
   160	
   161		return 0;
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
