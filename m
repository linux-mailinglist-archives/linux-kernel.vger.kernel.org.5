Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51117A124B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjIOA1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjIOA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:27:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A5269D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694737627; x=1726273627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NfawGZ/wOoTAAqH0D5cMeL8UCV11W9FTI2gsyatgKMQ=;
  b=ijKagMNcSvvbRQxn0wMWBmw9YIJy6hiuFZqlcx2upCf+AykZpGVrEmvi
   ln9TdCpkIULyUZViKjZtZLpQ+XP5yzrS/bNGk0nXz39Gs+Hh8P8rimDRI
   715f6joNROiMndnFXc//gTHhKOZh8pICkbelgEAeM+9zRWYNvzhWyZOUe
   sd4+OLOI1ZfUUUVkkOslyE5Oe3EpyXt5Zk7AmETLup/nWAPsvZbNZLyUu
   tKR9wqFqLVIhC0nT6ynp3m/vd8Ss1/6ENXNchg0tX+XVfayxh4tHLiaYJ
   FJnvAMTTJNLwUCkRi8RKO6+Cb9XCGtbyVO65RUpprDmHfGWjarylzfxL7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369432936"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="369432936"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 17:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744754672"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="744754672"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Sep 2023 17:27:05 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgwfl-0002Cz-0n;
        Fri, 15 Sep 2023 00:27:01 +0000
Date:   Fri, 15 Sep 2023 08:26:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: drivers/soundwire/bus_type.c:126:30: error: implicit declaration of
 function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'?
Message-ID: <202309150820.6zuErL12-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: 12a95123bfe1dd1a6020a35f5e67a560591bb02a soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
date:   4 weeks ago
config: s390-randconfig-r031-20220110 (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150820.6zuErL12-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soundwire/bus_type.c: In function 'sdw_drv_probe':
>> drivers/soundwire/bus_type.c:126:30: error: implicit declaration of function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
     126 |                 slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
         |                              ^~~~~~~~~~~~~~~~~~
         |                              irq_dispose_mapping
   drivers/soundwire/bus_type.c: In function 'sdw_drv_remove':
>> drivers/soundwire/bus_type.c:179:37: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
     179 |                 irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
         |                                     ^~~~~~~~~~~~~~~~
         |                                     irq_dispose_mapping
   cc1: some warnings being treated as errors
--
   drivers/soundwire/bus.c: In function 'sdw_bus_master_add':
>> drivers/soundwire/bus.c:173:23: error: implicit declaration of function 'irq_domain_create_linear' [-Werror=implicit-function-declaration]
     173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/soundwire/bus.c:173:21: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
         |                     ^
   drivers/soundwire/bus.c: In function 'sdw_bus_master_delete':
>> drivers/soundwire/bus.c:217:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
     217 |         irq_domain_remove(bus->domain);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +126 drivers/soundwire/bus_type.c

    79	
    80	static int sdw_drv_probe(struct device *dev)
    81	{
    82		struct sdw_slave *slave = dev_to_sdw_dev(dev);
    83		struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
    84		const struct sdw_device_id *id;
    85		const char *name;
    86		int ret;
    87	
    88		/*
    89		 * fw description is mandatory to bind
    90		 */
    91		if (!dev->fwnode)
    92			return -ENODEV;
    93	
    94		if (!IS_ENABLED(CONFIG_ACPI) && !dev->of_node)
    95			return -ENODEV;
    96	
    97		id = sdw_get_device_id(slave, drv);
    98		if (!id)
    99			return -ENODEV;
   100	
   101		/*
   102		 * attach to power domain but don't turn on (last arg)
   103		 */
   104		ret = dev_pm_domain_attach(dev, false);
   105		if (ret)
   106			return ret;
   107	
   108		ret = drv->probe(slave, id);
   109		if (ret) {
   110			name = drv->name;
   111			if (!name)
   112				name = drv->driver.name;
   113	
   114			dev_err(dev, "Probe of %s failed: %d\n", name, ret);
   115			dev_pm_domain_detach(dev, false);
   116			return ret;
   117		}
   118	
   119		mutex_lock(&slave->sdw_dev_lock);
   120	
   121		/* device is probed so let's read the properties now */
   122		if (drv->ops && drv->ops->read_prop)
   123			drv->ops->read_prop(slave);
   124	
   125		if (slave->prop.use_domain_irq) {
 > 126			slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
   127			if (!slave->irq)
   128				dev_warn(dev, "Failed to map IRQ\n");
   129		}
   130	
   131		/* init the sysfs as we have properties now */
   132		ret = sdw_slave_sysfs_init(slave);
   133		if (ret < 0)
   134			dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
   135	
   136		/*
   137		 * Check for valid clk_stop_timeout, use DisCo worst case value of
   138		 * 300ms
   139		 *
   140		 * TODO: check the timeouts and driver removal case
   141		 */
   142		if (slave->prop.clk_stop_timeout == 0)
   143			slave->prop.clk_stop_timeout = 300;
   144	
   145		slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
   146						     slave->prop.clk_stop_timeout);
   147	
   148		slave->probed = true;
   149	
   150		/*
   151		 * if the probe happened after the bus was started, notify the codec driver
   152		 * of the current hardware status to e.g. start the initialization.
   153		 * Errors are only logged as warnings to avoid failing the probe.
   154		 */
   155		if (drv->ops && drv->ops->update_status) {
   156			ret = drv->ops->update_status(slave, slave->status);
   157			if (ret < 0)
   158				dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
   159		}
   160	
   161		mutex_unlock(&slave->sdw_dev_lock);
   162	
   163		dev_dbg(dev, "probe complete\n");
   164	
   165		return 0;
   166	}
   167	
   168	static int sdw_drv_remove(struct device *dev)
   169	{
   170		struct sdw_slave *slave = dev_to_sdw_dev(dev);
   171		struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
   172		int ret = 0;
   173	
   174		mutex_lock(&slave->sdw_dev_lock);
   175	
   176		slave->probed = false;
   177	
   178		if (slave->prop.use_domain_irq)
 > 179			irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
   180							     slave->dev_num));
   181	
   182		mutex_unlock(&slave->sdw_dev_lock);
   183	
   184		if (drv->remove)
   185			ret = drv->remove(slave);
   186	
   187		dev_pm_domain_detach(dev, false);
   188	
   189		return ret;
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
