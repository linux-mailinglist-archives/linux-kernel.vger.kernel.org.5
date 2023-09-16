Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7612D7A2DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjIPFP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbjIPFPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21171BC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YWEYl9oA0z7SJ68zQ/Nnnq1m8700sN5EcXcPdXr2XDk=; b=ng4lhClV3eQ5D7MeqtOl4xYQKg
        9ZQK1PIMVlXZmml85NxiO9nHeqxo5wpOXAoyKn9DwYLwl5KZ/JxPmJ+360bQixrhYRjZ0LuP3ivl+
        rQlbQzRqLpa+cF1+F4Fyi3IxQ8zaSNja1XXmJH0ylJEB48x/zPehs3J1VqygHQg2C9WIXBQ8HBpEm
        aYVD6PxDuMMMXcLAgU9RNGMI+Z/MDD4F9Jn3pmgj4gF9FhLW+9/LV5PU9oIOYPwOYBsF/C0XiSclg
        iGOcbCloGvhJTMoNkjrHXzuU5ExAk3RjmdW0QbzTihNaXjzTwsxpBE6AhPiYHU3yTFAaqm/y0gdgg
        sv1tz80Q==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhNdt-00BxxZ-0O;
        Sat, 16 Sep 2023 05:14:53 +0000
Message-ID: <bf1bd8ee-b102-47e5-82c7-e190a43d984c@infradead.org>
Date:   Fri, 15 Sep 2023 22:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/soundwire/bus_type.c:126:30: error: implicit declaration
 of function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <202309150820.6zuErL12-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202309150820.6zuErL12-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 17:26, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
> commit: 12a95123bfe1dd1a6020a35f5e67a560591bb02a soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
> date:   4 weeks ago
> config: s390-randconfig-r031-20220110 (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150820.6zuErL12-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309150820.6zuErL12-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/soundwire/bus_type.c: In function 'sdw_drv_probe':
>>> drivers/soundwire/bus_type.c:126:30: error: implicit declaration of function 'irq_create_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
>      126 |                 slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
>          |                              ^~~~~~~~~~~~~~~~~~
>          |                              irq_dispose_mapping
>    drivers/soundwire/bus_type.c: In function 'sdw_drv_remove':
>>> drivers/soundwire/bus_type.c:179:37: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
>      179 |                 irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
>          |                                     ^~~~~~~~~~~~~~~~
>          |                                     irq_dispose_mapping
>    cc1: some warnings being treated as errors
> --
>    drivers/soundwire/bus.c: In function 'sdw_bus_master_add':
>>> drivers/soundwire/bus.c:173:23: error: implicit declaration of function 'irq_domain_create_linear' [-Werror=implicit-function-declaration]
>      173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
>          |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/soundwire/bus.c:173:21: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
>          |                     ^
>    drivers/soundwire/bus.c: In function 'sdw_bus_master_delete':
>>> drivers/soundwire/bus.c:217:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
>      217 |         irq_domain_remove(bus->domain);
>          |         ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 

CONFIG_IRQ_DOMAIN is not set in the .config file.
Should SOUNDWIRE select IRQ_DOMAIN?

> 
> vim +126 drivers/soundwire/bus_type.c
> 
>     79	
>     80	static int sdw_drv_probe(struct device *dev)
>     81	{
>     82		struct sdw_slave *slave = dev_to_sdw_dev(dev);
>     83		struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>     84		const struct sdw_device_id *id;
>     85		const char *name;
>     86		int ret;
>     87	
>     88		/*
>     89		 * fw description is mandatory to bind
>     90		 */
>     91		if (!dev->fwnode)
>     92			return -ENODEV;
>     93	
>     94		if (!IS_ENABLED(CONFIG_ACPI) && !dev->of_node)
>     95			return -ENODEV;
>     96	
>     97		id = sdw_get_device_id(slave, drv);
>     98		if (!id)
>     99			return -ENODEV;
>    100	
>    101		/*
>    102		 * attach to power domain but don't turn on (last arg)
>    103		 */
>    104		ret = dev_pm_domain_attach(dev, false);
>    105		if (ret)
>    106			return ret;
>    107	
>    108		ret = drv->probe(slave, id);
>    109		if (ret) {
>    110			name = drv->name;
>    111			if (!name)
>    112				name = drv->driver.name;
>    113	
>    114			dev_err(dev, "Probe of %s failed: %d\n", name, ret);
>    115			dev_pm_domain_detach(dev, false);
>    116			return ret;
>    117		}
>    118	
>    119		mutex_lock(&slave->sdw_dev_lock);
>    120	
>    121		/* device is probed so let's read the properties now */
>    122		if (drv->ops && drv->ops->read_prop)
>    123			drv->ops->read_prop(slave);
>    124	
>    125		if (slave->prop.use_domain_irq) {
>  > 126			slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
>    127			if (!slave->irq)
>    128				dev_warn(dev, "Failed to map IRQ\n");
>    129		}
>    130	
>    131		/* init the sysfs as we have properties now */
>    132		ret = sdw_slave_sysfs_init(slave);
>    133		if (ret < 0)
>    134			dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
>    135	
>    136		/*
>    137		 * Check for valid clk_stop_timeout, use DisCo worst case value of
>    138		 * 300ms
>    139		 *
>    140		 * TODO: check the timeouts and driver removal case
>    141		 */
>    142		if (slave->prop.clk_stop_timeout == 0)
>    143			slave->prop.clk_stop_timeout = 300;
>    144	
>    145		slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
>    146						     slave->prop.clk_stop_timeout);
>    147	
>    148		slave->probed = true;
>    149	
>    150		/*
>    151		 * if the probe happened after the bus was started, notify the codec driver
>    152		 * of the current hardware status to e.g. start the initialization.
>    153		 * Errors are only logged as warnings to avoid failing the probe.
>    154		 */
>    155		if (drv->ops && drv->ops->update_status) {
>    156			ret = drv->ops->update_status(slave, slave->status);
>    157			if (ret < 0)
>    158				dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
>    159		}
>    160	
>    161		mutex_unlock(&slave->sdw_dev_lock);
>    162	
>    163		dev_dbg(dev, "probe complete\n");
>    164	
>    165		return 0;
>    166	}
>    167	
>    168	static int sdw_drv_remove(struct device *dev)
>    169	{
>    170		struct sdw_slave *slave = dev_to_sdw_dev(dev);
>    171		struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>    172		int ret = 0;
>    173	
>    174		mutex_lock(&slave->sdw_dev_lock);
>    175	
>    176		slave->probed = false;
>    177	
>    178		if (slave->prop.use_domain_irq)
>  > 179			irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
>    180							     slave->dev_num));
>    181	
>    182		mutex_unlock(&slave->sdw_dev_lock);
>    183	
>    184		if (drv->remove)
>    185			ret = drv->remove(slave);
>    186	
>    187		dev_pm_domain_detach(dev, false);
>    188	
>    189		return ret;
>    190	}
>    191	
> 

-- 
~Randy
