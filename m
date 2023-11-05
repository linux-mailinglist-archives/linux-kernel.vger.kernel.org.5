Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38247E15B2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKESAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKESAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:00:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0330DB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699207246; x=1730743246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gJFzfPSb88O0T9UB0E9018pHQHIMEC6ZWbhAy2ZPC9c=;
  b=L0tAAT54iaHGARwW5ZghOOO3A3yDXilfPyMHtBqdCr4cEjYD9Mc8AY91
   ItQ3UNc0zPdQux4ho7sPj5qz3EkXceFUBag800zLeQVyQPgBf07fGY3Pd
   1MEX/zT9XPnmFDX6uH9MEzweJS5WNHa0heUOK4MDQFM+iQHGWaaYWSs8d
   hEp/xvm6SFPiyZIa9YIkBoa0Bx3W0xVCZXnW2I+jb1yexvNeYSc/0HGPu
   4C/CIZgOYW+5uQ49GWGmZNGQuehvG9mDoF55lcMc0t9zQAVU9Z/q+81u9
   gmdwxUqineiiHLJScjfrn/UarLLFCnPcd7s5qo5d4+S0Va1FL5s86Qrml
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="7796679"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="7796679"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 10:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885700075"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="885700075"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2023 10:00:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzhQP-0005gd-1S;
        Sun, 05 Nov 2023 18:00:41 +0000
Date:   Mon, 6 Nov 2023 02:00:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/hwmon/scpi-hwmon.c:144:19: warning: 'snprintf' output may be
 truncated before the last format character
Message-ID: <202311060113.1tMMoa8m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 8f1498c03d1503c8675a633e9f354041558cc459 firmware: arm_scpi: make it depend on MAILBOX instead of ARM_MHU
date:   7 years ago
config: x86_64-buildonly-randconfig-006-20231018 (https://download.01.org/0day-ci/archive/20231106/202311060113.1tMMoa8m-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060113.1tMMoa8m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060113.1tMMoa8m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21:0,
                    from include/linux/module.h:17,
                    from drivers/hwmon/scpi-hwmon.c:18:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:37: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     return kernfs_find_and_get(parent, name);
                                        ^~~~
   In file included from include/linux/sysfs.h:15:0,
                    from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/hwmon/scpi-hwmon.c:18:
   include/linux/kernfs.h:440:1: note: expected 'const char *' but argument is of type 'const unsigned char *'
    kernfs_find_and_get(struct kernfs_node *kn, const char *name)
    ^~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c: In function 'scpi_hwmon_probe':
>> drivers/hwmon/scpi-hwmon.c:144:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "temp%d_input", num_temp + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:143:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "temp%d_input", num_temp + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:146:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "temp%d_label", num_temp + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:145:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "temp%d_label", num_temp + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:158:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "curr%d_input", num_current + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:157:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "curr%d_input", num_current + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:160:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "curr%d_label", num_current + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:159:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "curr%d_label", num_current + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/scpi-hwmon.c:165:14: warning: '_input' directive output may be truncated writing 6 bytes into a region of size between 5 and 14 [-Wformat-truncation=]
         "power%d_input", num_power + 1);
                 ^~~~~~
   drivers/hwmon/scpi-hwmon.c:164:4: note: 'snprintf' output between 13 and 22 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "power%d_input", num_power + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/scpi-hwmon.c:167:14: warning: '_label' directive output may be truncated writing 6 bytes into a region of size between 5 and 14 [-Wformat-truncation=]
         "power%d_label", num_power + 1);
                 ^~~~~~
   drivers/hwmon/scpi-hwmon.c:166:4: note: 'snprintf' output between 13 and 22 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "power%d_label", num_power + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:172:15: warning: '_input' directive output may be truncated writing 6 bytes into a region of size between 4 and 13 [-Wformat-truncation=]
         "energy%d_input", num_energy + 1);
                  ^~~~~~
   drivers/hwmon/scpi-hwmon.c:171:4: note: 'snprintf' output between 14 and 23 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "energy%d_input", num_energy + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:174:15: warning: '_label' directive output may be truncated writing 6 bytes into a region of size between 4 and 13 [-Wformat-truncation=]
         "energy%d_label", num_energy + 1);
                  ^~~~~~
   drivers/hwmon/scpi-hwmon.c:173:4: note: 'snprintf' output between 14 and 23 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "energy%d_label", num_energy + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +144 drivers/hwmon/scpi-hwmon.c

68acc77a2d5197 Punit Agrawal    2015-06-24   96  
ea98b29a05e9c7 Punit Agrawal    2015-05-21   97  static int scpi_hwmon_probe(struct platform_device *pdev)
ea98b29a05e9c7 Punit Agrawal    2015-05-21   98  {
ea98b29a05e9c7 Punit Agrawal    2015-05-21   99  	u16 nr_sensors, i;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  100  	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
fb3b07ef399bd6 Sudeep Holla     2016-01-25  101  	int num_energy = 0;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  102  	struct scpi_ops *scpi_ops;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  103  	struct device *hwdev, *dev = &pdev->dev;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  104  	struct scpi_sensors *scpi_sensors;
d7817ff27b06bf Eduardo Valentin 2016-03-09  105  	int idx, ret;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  106  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  107  	scpi_ops = get_scpi_ops();
ea98b29a05e9c7 Punit Agrawal    2015-05-21  108  	if (!scpi_ops)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  109  		return -EPROBE_DEFER;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  110  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  111  	ret = scpi_ops->sensor_get_capability(&nr_sensors);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  112  	if (ret)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  113  		return ret;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  114  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  115  	if (!nr_sensors)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  116  		return -ENODEV;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  117  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  118  	scpi_sensors = devm_kzalloc(dev, sizeof(*scpi_sensors), GFP_KERNEL);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  119  	if (!scpi_sensors)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  120  		return -ENOMEM;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  121  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  122  	scpi_sensors->data = devm_kcalloc(dev, nr_sensors,
ea98b29a05e9c7 Punit Agrawal    2015-05-21  123  				   sizeof(*scpi_sensors->data), GFP_KERNEL);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  124  	if (!scpi_sensors->data)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  125  		return -ENOMEM;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  126  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  127  	scpi_sensors->attrs = devm_kcalloc(dev, (nr_sensors * 2) + 1,
ea98b29a05e9c7 Punit Agrawal    2015-05-21  128  				   sizeof(*scpi_sensors->attrs), GFP_KERNEL);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  129  	if (!scpi_sensors->attrs)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  130  		return -ENOMEM;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  131  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  132  	scpi_sensors->scpi_ops = scpi_ops;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  133  
cef03d7e66bd70 Sudeep Holla     2015-10-28  134  	for (i = 0, idx = 0; i < nr_sensors; i++) {
cef03d7e66bd70 Sudeep Holla     2015-10-28  135  		struct sensor_data *sensor = &scpi_sensors->data[idx];
ea98b29a05e9c7 Punit Agrawal    2015-05-21  136  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  137  		ret = scpi_ops->sensor_get_info(i, &sensor->info);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  138  		if (ret)
ea98b29a05e9c7 Punit Agrawal    2015-05-21  139  			return ret;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  140  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  141  		switch (sensor->info.class) {
ea98b29a05e9c7 Punit Agrawal    2015-05-21  142  		case TEMPERATURE:
ea98b29a05e9c7 Punit Agrawal    2015-05-21  143  			snprintf(sensor->input, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21 @144  				 "temp%d_input", num_temp + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  145  			snprintf(sensor->label, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21  146  				 "temp%d_label", num_temp + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  147  			num_temp++;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  148  			break;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  149  		case VOLTAGE:
ea98b29a05e9c7 Punit Agrawal    2015-05-21  150  			snprintf(sensor->input, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21  151  				 "in%d_input", num_volt);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  152  			snprintf(sensor->label, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21  153  				 "in%d_label", num_volt);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  154  			num_volt++;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  155  			break;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  156  		case CURRENT:
ea98b29a05e9c7 Punit Agrawal    2015-05-21  157  			snprintf(sensor->input, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21  158  				 "curr%d_input", num_current + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  159  			snprintf(sensor->label, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21  160  				 "curr%d_label", num_current + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  161  			num_current++;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  162  			break;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  163  		case POWER:
ea98b29a05e9c7 Punit Agrawal    2015-05-21  164  			snprintf(sensor->input, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21 @165  				 "power%d_input", num_power + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  166  			snprintf(sensor->label, sizeof(sensor->input),
ea98b29a05e9c7 Punit Agrawal    2015-05-21 @167  				 "power%d_label", num_power + 1);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  168  			num_power++;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  169  			break;
fb3b07ef399bd6 Sudeep Holla     2016-01-25  170  		case ENERGY:
fb3b07ef399bd6 Sudeep Holla     2016-01-25  171  			snprintf(sensor->input, sizeof(sensor->input),
fb3b07ef399bd6 Sudeep Holla     2016-01-25  172  				 "energy%d_input", num_energy + 1);
fb3b07ef399bd6 Sudeep Holla     2016-01-25  173  			snprintf(sensor->label, sizeof(sensor->input),
fb3b07ef399bd6 Sudeep Holla     2016-01-25  174  				 "energy%d_label", num_energy + 1);
fb3b07ef399bd6 Sudeep Holla     2016-01-25  175  			num_energy++;
fb3b07ef399bd6 Sudeep Holla     2016-01-25  176  			break;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  177  		default:
cef03d7e66bd70 Sudeep Holla     2015-10-28  178  			continue;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  179  		}
ea98b29a05e9c7 Punit Agrawal    2015-05-21  180  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  181  		sensor->dev_attr_input.attr.mode = S_IRUGO;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  182  		sensor->dev_attr_input.show = scpi_show_sensor;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  183  		sensor->dev_attr_input.attr.name = sensor->input;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  184  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  185  		sensor->dev_attr_label.attr.mode = S_IRUGO;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  186  		sensor->dev_attr_label.show = scpi_show_label;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  187  		sensor->dev_attr_label.attr.name = sensor->label;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  188  
cef03d7e66bd70 Sudeep Holla     2015-10-28  189  		scpi_sensors->attrs[idx << 1] = &sensor->dev_attr_input.attr;
cef03d7e66bd70 Sudeep Holla     2015-10-28  190  		scpi_sensors->attrs[(idx << 1) + 1] = &sensor->dev_attr_label.attr;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  191  
cef03d7e66bd70 Sudeep Holla     2015-10-28  192  		sysfs_attr_init(scpi_sensors->attrs[idx << 1]);
cef03d7e66bd70 Sudeep Holla     2015-10-28  193  		sysfs_attr_init(scpi_sensors->attrs[(idx << 1) + 1]);
cef03d7e66bd70 Sudeep Holla     2015-10-28  194  		idx++;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  195  	}
ea98b29a05e9c7 Punit Agrawal    2015-05-21  196  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  197  	scpi_sensors->group.attrs = scpi_sensors->attrs;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  198  	scpi_sensors->groups[0] = &scpi_sensors->group;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  199  
68acc77a2d5197 Punit Agrawal    2015-06-24  200  	platform_set_drvdata(pdev, scpi_sensors);
68acc77a2d5197 Punit Agrawal    2015-06-24  201  
ea98b29a05e9c7 Punit Agrawal    2015-05-21  202  	hwdev = devm_hwmon_device_register_with_groups(dev,
ea98b29a05e9c7 Punit Agrawal    2015-05-21  203  			"scpi_sensors", scpi_sensors, scpi_sensors->groups);
ea98b29a05e9c7 Punit Agrawal    2015-05-21  204  
68acc77a2d5197 Punit Agrawal    2015-06-24  205  	if (IS_ERR(hwdev))
68acc77a2d5197 Punit Agrawal    2015-06-24  206  		return PTR_ERR(hwdev);
68acc77a2d5197 Punit Agrawal    2015-06-24  207  
68acc77a2d5197 Punit Agrawal    2015-06-24  208  	/*
68acc77a2d5197 Punit Agrawal    2015-06-24  209  	 * Register the temperature sensors with the thermal framework
68acc77a2d5197 Punit Agrawal    2015-06-24  210  	 * to allow their usage in setting up the thermal zones from
68acc77a2d5197 Punit Agrawal    2015-06-24  211  	 * device tree.
68acc77a2d5197 Punit Agrawal    2015-06-24  212  	 *
68acc77a2d5197 Punit Agrawal    2015-06-24  213  	 * NOTE: Not all temperature sensors maybe used for thermal
68acc77a2d5197 Punit Agrawal    2015-06-24  214  	 * control
68acc77a2d5197 Punit Agrawal    2015-06-24  215  	 */
68acc77a2d5197 Punit Agrawal    2015-06-24  216  	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
68acc77a2d5197 Punit Agrawal    2015-06-24  217  	for (i = 0; i < nr_sensors; i++) {
68acc77a2d5197 Punit Agrawal    2015-06-24  218  		struct sensor_data *sensor = &scpi_sensors->data[i];
d7817ff27b06bf Eduardo Valentin 2016-03-09  219  		struct thermal_zone_device *z;
68acc77a2d5197 Punit Agrawal    2015-06-24  220  		struct scpi_thermal_zone *zone;
68acc77a2d5197 Punit Agrawal    2015-06-24  221  
68acc77a2d5197 Punit Agrawal    2015-06-24  222  		if (sensor->info.class != TEMPERATURE)
68acc77a2d5197 Punit Agrawal    2015-06-24  223  			continue;
68acc77a2d5197 Punit Agrawal    2015-06-24  224  
68acc77a2d5197 Punit Agrawal    2015-06-24  225  		zone = devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
d7817ff27b06bf Eduardo Valentin 2016-03-09  226  		if (!zone)
d7817ff27b06bf Eduardo Valentin 2016-03-09  227  			return -ENOMEM;
68acc77a2d5197 Punit Agrawal    2015-06-24  228  
68acc77a2d5197 Punit Agrawal    2015-06-24  229  		zone->sensor_id = i;
68acc77a2d5197 Punit Agrawal    2015-06-24  230  		zone->scpi_sensors = scpi_sensors;
d7817ff27b06bf Eduardo Valentin 2016-03-09  231  		z = devm_thermal_zone_of_sensor_register(dev,
d7817ff27b06bf Eduardo Valentin 2016-03-09  232  							 sensor->info.sensor_id,
d7817ff27b06bf Eduardo Valentin 2016-03-09  233  							 zone,
d7817ff27b06bf Eduardo Valentin 2016-03-09  234  							 &scpi_sensor_ops);
68acc77a2d5197 Punit Agrawal    2015-06-24  235  		/*
68acc77a2d5197 Punit Agrawal    2015-06-24  236  		 * The call to thermal_zone_of_sensor_register returns
68acc77a2d5197 Punit Agrawal    2015-06-24  237  		 * an error for sensors that are not associated with
68acc77a2d5197 Punit Agrawal    2015-06-24  238  		 * any thermal zones or if the thermal subsystem is
68acc77a2d5197 Punit Agrawal    2015-06-24  239  		 * not configured.
68acc77a2d5197 Punit Agrawal    2015-06-24  240  		 */
d7817ff27b06bf Eduardo Valentin 2016-03-09  241  		if (IS_ERR(z)) {
68acc77a2d5197 Punit Agrawal    2015-06-24  242  			devm_kfree(dev, zone);
68acc77a2d5197 Punit Agrawal    2015-06-24  243  			continue;
68acc77a2d5197 Punit Agrawal    2015-06-24  244  		}
68acc77a2d5197 Punit Agrawal    2015-06-24  245  	}
68acc77a2d5197 Punit Agrawal    2015-06-24  246  
68acc77a2d5197 Punit Agrawal    2015-06-24  247  	return 0;
ea98b29a05e9c7 Punit Agrawal    2015-05-21  248  }
ea98b29a05e9c7 Punit Agrawal    2015-05-21  249  

:::::: The code at line 144 was first introduced by commit
:::::: ea98b29a05e9c70dbe159cbc6254d111059a2bb9 hwmon: Support sensors exported via ARM SCP interface

:::::: TO: Punit Agrawal <punit.agrawal@arm.com>
:::::: CC: Sudeep Holla <sudeep.holla@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
