Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5657E0EFC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjKDLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:11:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDB136;
        Sat,  4 Nov 2023 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699096311; x=1730632311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dxJ083WUhr/NqcnL95KQlbKdGT9jqtmw7YyUFjnoDFg=;
  b=CJ7auhsHpmaM5fGuXlnsC49bzXSnIq78ohahIQCkK4nBnVgmZBAV4hWJ
   j9+gEfPKlENrlDBR7fAKO+wAxJrGrvdZGvdpM3Q378XeEIZKrDwlP/RKk
   2SgJFpjmycXQ61kxUeVPbh61vRQ7UZC2i9Q8yhqDJh1u3KbGnKsgbPyes
   emCF43jjWagEc3+GOtNAy5uz03xssDF/3M5B9mMCIXHuxUINyeVn8igBf
   /qxuUIkBoh8VLty5fq+1Bl0naBvpClEHdIFPO8wEo/Hx68BmWn5pNmqBB
   63qQzE/fABPR2wfX5JqLKTCP4n6RplZOZDGKB1e/ewBESgvYhUPT8GCml
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="453379706"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="453379706"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832273061"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="832273061"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2023 04:11:47 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzEZ7-0003wd-19;
        Sat, 04 Nov 2023 11:11:45 +0000
Date:   Sat, 4 Nov 2023 19:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>,
        zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 -next 4/5] spi: mockup: Add speed and flags attribute
 support
Message-ID: <202311041823.CPs0Ymwh-lkp@intel.com>
References: <20231104064650.972687-5-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104064650.972687-5-zhangxiaoxu@huaweicloud.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231103]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Xiaoxu/spi-mockup-Add-SPI-controller-testing-driver/20231104-144859
base:   next-20231103
patch link:    https://lore.kernel.org/r/20231104064650.972687-5-zhangxiaoxu%40huaweicloud.com
patch subject: [PATCH v3 -next 4/5] spi: mockup: Add speed and flags attribute support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311041823.CPs0Ymwh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041823.CPs0Ymwh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041823.CPs0Ymwh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-mockup.c:339:1: error: expected ',' or ';' before 'static'
     339 | static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,     \
         | ^~~~~~
   drivers/spi/spi-mockup.c:364:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     364 | SPI_MOCKUP_ATTR(u32, max_speed)
         | ^~~~~~~~~~~~~~~
   In file included from drivers/spi/spi-mockup.c:15:
   drivers/spi/spi-mockup.c:361:18: error: 'spi_mockup_max_speed_store' undeclared here (not in a function); did you mean 'spi_mockup_min_speed_store'?
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:145:27: note: in definition of macro 'CONFIGFS_ATTR_WO'
     145 |         .store          = _pfx##_name##_store,          \
         |                           ^~~~
   drivers/spi/spi-mockup.c:364:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     364 | SPI_MOCKUP_ATTR(u32, max_speed)
         | ^~~~~~~~~~~~~~~
   drivers/spi/spi-mockup.c:339:1: error: expected ',' or ';' before 'static'
     339 | static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,     \
         | ^~~~~~
   drivers/spi/spi-mockup.c:365:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     365 | SPI_MOCKUP_ATTR(u16, flags)
         | ^~~~~~~~~~~~~~~
   drivers/spi/spi-mockup.c:361:18: error: 'spi_mockup_flags_store' undeclared here (not in a function); did you mean 'spi_mockup_enable_store'?
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:145:27: note: in definition of macro 'CONFIGFS_ATTR_WO'
     145 |         .store          = _pfx##_name##_store,          \
         |                           ^~~~
   drivers/spi/spi-mockup.c:365:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     365 | SPI_MOCKUP_ATTR(u16, flags)
         | ^~~~~~~~~~~~~~~
   drivers/spi/spi-mockup.c:339:1: error: expected ',' or ';' before 'static'
     339 | static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,     \
         | ^~~~~~
   drivers/spi/spi-mockup.c:366:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     366 | SPI_MOCKUP_ATTR(u16, num_cs)
         | ^~~~~~~~~~~~~~~
   drivers/spi/spi-mockup.c:361:18: error: 'spi_mockup_num_cs_store' undeclared here (not in a function); did you mean 'spi_mockup_enable_store'?
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:145:27: note: in definition of macro 'CONFIGFS_ATTR_WO'
     145 |         .store          = _pfx##_name##_store,          \
         |                           ^~~~
   drivers/spi/spi-mockup.c:366:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     366 | SPI_MOCKUP_ATTR(u16, num_cs)
         | ^~~~~~~~~~~~~~~
   drivers/spi/spi-mockup.c:368:1: error: expected ',' or ';' before 'static'
     368 | static struct configfs_attribute *spi_mockup_configfs_attrs[] = {
         | ^~~~~~
   drivers/spi/spi-mockup.c:380:27: error: 'spi_mockup_configfs_attrs' undeclared here (not in a function); did you mean 'spi_mockup_attrs'?
     380 |         .ct_attrs       = spi_mockup_configfs_attrs,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                           spi_mockup_attrs
>> drivers/spi/spi-mockup.c:361:18: warning: 'spi_mockup_attr_num_cs' defined but not used [-Wunused-variable]
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~
   drivers/spi/spi-mockup.c:366:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     366 | SPI_MOCKUP_ATTR(u16, num_cs)
         | ^~~~~~~~~~~~~~~
>> drivers/spi/spi-mockup.c:361:18: warning: 'spi_mockup_attr_flags' defined but not used [-Wunused-variable]
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~
   drivers/spi/spi-mockup.c:365:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     365 | SPI_MOCKUP_ATTR(u16, flags)
         | ^~~~~~~~~~~~~~~
>> drivers/spi/spi-mockup.c:361:18: warning: 'spi_mockup_attr_max_speed' defined but not used [-Wunused-variable]
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~
   drivers/spi/spi-mockup.c:364:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     364 | SPI_MOCKUP_ATTR(u32, max_speed)
         | ^~~~~~~~~~~~~~~
>> drivers/spi/spi-mockup.c:361:18: warning: 'spi_mockup_attr_min_speed' defined but not used [-Wunused-variable]
     361 | CONFIGFS_ATTR_WO(spi_mockup_, name)                                        \
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~
   drivers/spi/spi-mockup.c:363:1: note: in expansion of macro 'SPI_MOCKUP_ATTR'
     363 | SPI_MOCKUP_ATTR(u32, min_speed)
         | ^~~~~~~~~~~~~~~
>> drivers/spi/spi-mockup.c:336:18: warning: 'spi_mockup_attr_disable' defined but not used [-Wunused-variable]
     336 | CONFIGFS_ATTR_WO(spi_mockup_, disable);
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~
>> drivers/spi/spi-mockup.c:316:18: warning: 'spi_mockup_attr_enable' defined but not used [-Wunused-variable]
     316 | CONFIGFS_ATTR_WO(spi_mockup_, enable);
         |                  ^~~~~~~~~~~
   include/linux/configfs.h:141:34: note: in definition of macro 'CONFIGFS_ATTR_WO'
     141 | static struct configfs_attribute _pfx##attr_##_name = { \
         |                                  ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for BPF_EVENTS
   Depends on [n]: FTRACE [=n] && BPF_SYSCALL [=y] && (KPROBE_EVENTS [=n] || UPROBE_EVENTS [=n]) && PERF_EVENTS [=n]
   Selected by [y]:
   - SPI_MOCKUP [=y] && SPI [=y] && SPI_MASTER [=y] && OF [=y]


vim +/spi_mockup_attr_num_cs +361 drivers/spi/spi-mockup.c

   287	
   288	static ssize_t
   289	spi_mockup_enable_store(struct config_item *item, const char *page, size_t len)
   290	{
   291		int ret = len;
   292		struct platform_device_info pdevinfo = {0};
   293		struct spi_mockup_device *dev = to_spi_mockup_dev(item);
   294	
   295		mutex_lock(&dev->lock);
   296		if (dev->pdev) {
   297			ret = -EEXIST;
   298			goto out;
   299		}
   300	
   301		pdevinfo.name = "spi-mockup";
   302		pdevinfo.id = dev->bus_nr;
   303		pdevinfo.data = &dev->data;
   304		pdevinfo.size_data = sizeof(dev->data);
   305	
   306		dev->pdev = platform_device_register_full(&pdevinfo);
   307		if (IS_ERR(dev->pdev)) {
   308			ret = PTR_ERR(dev->pdev);
   309			dev->pdev = NULL;
   310			goto out;
   311		}
   312	out:
   313		mutex_unlock(&dev->lock);
   314		return ret;
   315	}
 > 316	CONFIGFS_ATTR_WO(spi_mockup_, enable);
   317	
   318	static ssize_t
   319	spi_mockup_disable_store(struct config_item *item, const char *page, size_t len)
   320	{
   321		int ret = len;
   322		struct spi_mockup_device *dev = to_spi_mockup_dev(item);
   323	
   324		mutex_lock(&dev->lock);
   325		if (!dev->pdev) {
   326			ret = -ENODEV;
   327			goto out;
   328		}
   329	
   330		platform_device_unregister(dev->pdev);
   331		dev->pdev = NULL;
   332	out:
   333		mutex_unlock(&dev->lock);
   334		return ret;
   335	}
 > 336	CONFIGFS_ATTR_WO(spi_mockup_, disable);
   337	
   338	#define SPI_MOCKUP_ATTR(type, name) \
   339	static ssize_t spi_mockup_ ## name ## _store(struct config_item *item,	   \
   340						     const char *page, size_t len) \
   341	{									   \
   342		int ret;							   \
   343		type val;							   \
   344		struct spi_mockup_device *dev = to_spi_mockup_dev(item);	   \
   345										   \
   346		mutex_lock(&dev->lock);						   \
   347		if (dev->pdev) {						   \
   348			ret = -EBUSY;						   \
   349			goto out;						   \
   350		}								   \
   351										   \
   352		ret = kstrto ## type(page, 0, &val);				   \
   353		if (ret)							   \
   354			goto out;						   \
   355										   \
   356		dev->data.name = val;						   \
   357	out:									   \
   358		mutex_unlock(&dev->lock);					   \
   359		return ret ? ret : len;						   \
   360	}									   \
 > 361	CONFIGFS_ATTR_WO(spi_mockup_, name)					   \
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
