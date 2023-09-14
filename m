Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A87A1025
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjINV7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:59:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B64B270B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694728755; x=1726264755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VvHYPw4PBqg2OBLzpmfzy5WhfsqdqcPxJdOtRSKXE6U=;
  b=biWKo2+YjxTzekA7/LF+vZjTC7U+lhfvOL8zWlL9oku1gEjZN6VOVlim
   RdhjPI5enHf+hYQ59eDq0Unf7RTRTY3uqvOXuFS7SSjJnQKPnzO2QFscc
   jqjwe7MBFo4C73oLogEx7JU2eYcU2WGDytYK8tWNt72KcKzqj2YDEp/KQ
   rwKS53YJznVcxJroAvT0pGWedOGZGxyAExEiq92YR5A+PcjnG93MDKEpB
   ppJE4owyljgOrmFkiGplbrPij67DftLk8x6hjaGzqbWDa6ezqIwZAgtJm
   3xyUqm7uiUDJ5oELaOOqfTJJe3VLK82syMgW2OqcMDmlo9I9xOay23d2O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="377999184"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="377999184"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 14:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="747939319"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="747939319"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2023 14:58:50 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qguMK-00025z-1y;
        Thu, 14 Sep 2023 21:58:48 +0000
Date:   Fri, 15 Sep 2023 05:58:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: drivers/soundwire/bus.c:173:21: warning: assignment to 'struct
 irq_domain *' from 'int' makes pointer from integer without a cast
Message-ID: <202309150522.MoKeF4jx-lkp@intel.com>
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
config: s390-randconfig-r031-20220110 (https://download.01.org/0day-ci/archive/20230915/202309150522.MoKeF4jx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150522.MoKeF4jx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soundwire/bus.c: In function 'sdw_bus_master_add':
   drivers/soundwire/bus.c:173:23: error: implicit declaration of function 'irq_domain_create_linear' [-Werror=implicit-function-declaration]
     173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/soundwire/bus.c:173:21: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     173 |         bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
         |                     ^
   drivers/soundwire/bus.c: In function 'sdw_bus_master_delete':
   drivers/soundwire/bus.c:217:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
     217 |         irq_domain_remove(bus->domain);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +173 drivers/soundwire/bus.c

    45	
    46	/**
    47	 * sdw_bus_master_add() - add a bus Master instance
    48	 * @bus: bus instance
    49	 * @parent: parent device
    50	 * @fwnode: firmware node handle
    51	 *
    52	 * Initializes the bus instance, read properties and create child
    53	 * devices.
    54	 */
    55	int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
    56			       struct fwnode_handle *fwnode)
    57	{
    58		struct sdw_master_prop *prop = NULL;
    59		int ret;
    60	
    61		if (!parent) {
    62			pr_err("SoundWire parent device is not set\n");
    63			return -ENODEV;
    64		}
    65	
    66		ret = sdw_get_id(bus);
    67		if (ret < 0) {
    68			dev_err(parent, "Failed to get bus id\n");
    69			return ret;
    70		}
    71	
    72		ret = sdw_master_device_add(bus, parent, fwnode);
    73		if (ret < 0) {
    74			dev_err(parent, "Failed to add master device at link %d\n",
    75				bus->link_id);
    76			return ret;
    77		}
    78	
    79		if (!bus->ops) {
    80			dev_err(bus->dev, "SoundWire Bus ops are not set\n");
    81			return -EINVAL;
    82		}
    83	
    84		if (!bus->compute_params) {
    85			dev_err(bus->dev,
    86				"Bandwidth allocation not configured, compute_params no set\n");
    87			return -EINVAL;
    88		}
    89	
    90		/*
    91		 * Give each bus_lock and msg_lock a unique key so that lockdep won't
    92		 * trigger a deadlock warning when the locks of several buses are
    93		 * grabbed during configuration of a multi-bus stream.
    94		 */
    95		lockdep_register_key(&bus->msg_lock_key);
    96		__mutex_init(&bus->msg_lock, "msg_lock", &bus->msg_lock_key);
    97	
    98		lockdep_register_key(&bus->bus_lock_key);
    99		__mutex_init(&bus->bus_lock, "bus_lock", &bus->bus_lock_key);
   100	
   101		INIT_LIST_HEAD(&bus->slaves);
   102		INIT_LIST_HEAD(&bus->m_rt_list);
   103	
   104		/*
   105		 * Initialize multi_link flag
   106		 */
   107		bus->multi_link = false;
   108		if (bus->ops->read_prop) {
   109			ret = bus->ops->read_prop(bus);
   110			if (ret < 0) {
   111				dev_err(bus->dev,
   112					"Bus read properties failed:%d\n", ret);
   113				return ret;
   114			}
   115		}
   116	
   117		sdw_bus_debugfs_init(bus);
   118	
   119		/*
   120		 * Device numbers in SoundWire are 0 through 15. Enumeration device
   121		 * number (0), Broadcast device number (15), Group numbers (12 and
   122		 * 13) and Master device number (14) are not used for assignment so
   123		 * mask these and other higher bits.
   124		 */
   125	
   126		/* Set higher order bits */
   127		*bus->assigned = ~GENMASK(SDW_BROADCAST_DEV_NUM, SDW_ENUM_DEV_NUM);
   128	
   129		/* Set enumuration device number and broadcast device number */
   130		set_bit(SDW_ENUM_DEV_NUM, bus->assigned);
   131		set_bit(SDW_BROADCAST_DEV_NUM, bus->assigned);
   132	
   133		/* Set group device numbers and master device number */
   134		set_bit(SDW_GROUP12_DEV_NUM, bus->assigned);
   135		set_bit(SDW_GROUP13_DEV_NUM, bus->assigned);
   136		set_bit(SDW_MASTER_DEV_NUM, bus->assigned);
   137	
   138		/*
   139		 * SDW is an enumerable bus, but devices can be powered off. So,
   140		 * they won't be able to report as present.
   141		 *
   142		 * Create Slave devices based on Slaves described in
   143		 * the respective firmware (ACPI/DT)
   144		 */
   145		if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
   146			ret = sdw_acpi_find_slaves(bus);
   147		else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
   148			ret = sdw_of_find_slaves(bus);
   149		else
   150			ret = -ENOTSUPP; /* No ACPI/DT so error out */
   151	
   152		if (ret < 0) {
   153			dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
   154			return ret;
   155		}
   156	
   157		/*
   158		 * Initialize clock values based on Master properties. The max
   159		 * frequency is read from max_clk_freq property. Current assumption
   160		 * is that the bus will start at highest clock frequency when
   161		 * powered on.
   162		 *
   163		 * Default active bank will be 0 as out of reset the Slaves have
   164		 * to start with bank 0 (Table 40 of Spec)
   165		 */
   166		prop = &bus->prop;
   167		bus->params.max_dr_freq = prop->max_clk_freq * SDW_DOUBLE_RATE_FACTOR;
   168		bus->params.curr_dr_freq = bus->params.max_dr_freq;
   169		bus->params.curr_bank = SDW_BANK0;
   170		bus->params.next_bank = SDW_BANK1;
   171	
   172		bus->irq_chip.name = dev_name(bus->dev);
 > 173		bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
   174						       &sdw_domain_ops, bus);
   175		if (!bus->domain) {
   176			dev_err(bus->dev, "Failed to add IRQ domain\n");
   177			return -EINVAL;
   178		}
   179	
   180		return 0;
   181	}
   182	EXPORT_SYMBOL(sdw_bus_master_add);
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
