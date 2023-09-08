Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AF79894E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjIHOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjIHOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:55:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B67F1BF1;
        Fri,  8 Sep 2023 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694184913; x=1725720913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oPQGn9VNNhKld4xDCFy6ahkwNcYXJKmcT+cnd6zuM0=;
  b=TDJqdjcbE+IZGOQwQFRig2mLBTSIdW3ZiLas7717u2oIWxzNPWHYyHR+
   EqyWPh5zaiv6xXH00wh/2otxsiA/G4ZyJBTfQaZX6qqZ6aJWnjsMwB5Px
   u68xI2QLOtolz+xdBK59eQbZiVcuF8TID0uFNgd060yh/E948fHm0zLIQ
   l6XuP6CsnV4cva6E+JIj3jq/ZV+OdiJSHUAzQESEsBE0s3+rtu49PjxcU
   grN/oJZP8f2/M5v1Nvijmfz4DZWpjf9DWEbol5/bjW7+ALM5cwSwKC2oX
   n2mmfI2w0mOO/wAkO7fxfCqgaQoHKk2m62VxBk75RGJgZ9X/3JXti78tz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357969715"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="357969715"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="1073339874"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="1073339874"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2023 07:55:10 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qect2-0002Mt-2E;
        Fri, 08 Sep 2023 14:55:08 +0000
Date:   Fri, 8 Sep 2023 22:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ober <dober6023@gmail.com>, wim@linux-watchdog.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: Re: [PATCH] watchdog: add in watchdog for nct6686
Message-ID: <202309082202.ZRLExbNG-lkp@intel.com>
References: <20230907113517.31147-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907113517.31147-1-dober6023@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230908]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ober/watchdog-add-in-watchdog-for-nct6686/20230907-235048
base:   linus/master
patch link:    https://lore.kernel.org/r/20230907113517.31147-1-dober6023%40gmail.com
patch subject: [PATCH] watchdog: add in watchdog for nct6686
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20230908/202309082202.ZRLExbNG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309082202.ZRLExbNG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309082202.ZRLExbNG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/nct6686_wdt.c:352:3: warning: variable 'wdt' is uninitialized when used here [-Wuninitialized]
     352 |                 wdt->timeout, nowayout);
         |                 ^~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/watchdog/nct6686_wdt.c:309:29: note: initialize the variable 'wdt' to silence this warning
     309 |         struct watchdog_device *wdt;
         |                                    ^
         |                                     = NULL
   1 warning generated.


vim +/wdt +352 drivers/watchdog/nct6686_wdt.c

   305	
   306	static int nct6686_probe(struct platform_device *pdev)
   307	{
   308		struct device *dev = &pdev->dev;
   309		struct watchdog_device *wdt;
   310		struct resource *res;
   311		struct nct6686_data *data;
   312		struct nct6686_sio_data *sio_data = dev->platform_data;
   313		int ret;
   314		u_char reg;
   315	
   316		dev_dbg(&pdev->dev, "Probe NCT6686 called\n");
   317		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
   318		if (!devm_request_region(dev, res->start, IOREGION_LENGTH, DRVNAME))
   319			return -EBUSY;
   320	
   321		data = devm_kzalloc(dev, sizeof(struct nct6686_data), GFP_KERNEL);
   322		if (!data)
   323			return -ENOMEM;
   324	
   325		data->sio_data.sioreg = sio_data->sioreg;
   326		data->addr = res->start;
   327		mutex_init(&data->update_lock);
   328		platform_set_drvdata(pdev, data);
   329	
   330		/* Watchdog initialization */
   331		data->wdt.ops = &nct6686_wdt_ops;
   332		data->wdt.info = &nct6686_wdt_info;
   333	
   334		data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
   335		data->wdt.min_timeout = MIN_TIMEOUT;
   336		data->wdt.max_timeout = MAX_TIMEOUT;
   337		data->wdt.parent = &pdev->dev;
   338	
   339		watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
   340		watchdog_set_nowayout(&data->wdt, nowayout);
   341		watchdog_set_drvdata(&data->wdt, data);
   342	
   343		/* reset trigger status */
   344		reg = nct6686_read(data, WDT_STS);
   345		nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
   346	
   347		watchdog_stop_on_unregister(&data->wdt);
   348	
   349		ret = devm_watchdog_register_device(dev, &data->wdt);
   350	
   351		dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
 > 352			wdt->timeout, nowayout);
   353	
   354		return ret;
   355	}
   356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
