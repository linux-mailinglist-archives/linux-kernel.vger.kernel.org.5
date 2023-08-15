Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D8E77D002
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjHOQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbjHOQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:00:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447110B;
        Tue, 15 Aug 2023 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692115214; x=1723651214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VphquokXg/KQ2sztLX59OvGEdtXNoG/7VqBsTk84USU=;
  b=GYn9og8msHmLR6Nt0vTFhuRVuJSOddWM0dGaFFbdt8fTXitGcjNor7P2
   0Q98/MInjtsDMCDd5VIegLNgJedwV8VSMupQDwSMhiPlVc0v6U/WM3IdM
   vdVCkdoh040ziSHTmFo/kWoTEkO5jSWw5DR5jP38NS9uNvNdYouv/twNS
   fVF2OJSev1geJxTLIThUk6wc60kGo7uUgVK8zgqj9uOerFapbViM8mCOS
   sbNlj+I9zDRzN0yo0y/o4qAlQpHqt2lAqMNh/j6479kzNujUnQpvHinfq
   nE3kxfdivYIoCP0ZY4l+PcmHcYooBOhAeXKx7l8erayph4SiHXh8OlAYj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458662865"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="458662865"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="736961163"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="736961163"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Aug 2023 09:00:04 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVwRv-00014V-1y;
        Tue, 15 Aug 2023 15:59:27 +0000
Date:   Tue, 15 Aug 2023 23:58:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, dober@lenovo.com,
        mpearson@lenovo.com, David Ober <dober6023@gmail.com>
Subject: Re: [PATCH] hwmon: add in watchdog for nct6686
Message-ID: <202308152310.lu9rTudo-lkp@intel.com>
References: <20230815115515.286142-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815115515.286142-1-dober6023@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.5-rc6 next-20230815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ober/hwmon-add-in-watchdog-for-nct6686/20230815-195946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230815115515.286142-1-dober6023%40gmail.com
patch subject: [PATCH] hwmon: add in watchdog for nct6686
config: i386-randconfig-i015-20230815 (https://download.01.org/0day-ci/archive/20230815/202308152310.lu9rTudo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308152310.lu9rTudo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308152310.lu9rTudo-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/hwmon/nct6683.o: in function `nct6683_probe':
>> drivers/hwmon/nct6683.c:1514: undefined reference to `watchdog_init_timeout'
>> ld: drivers/hwmon/nct6683.c:1524: undefined reference to `devm_watchdog_register_device'


vim +1514 drivers/hwmon/nct6683.c

  1388	
  1389	static int nct6683_probe(struct platform_device *pdev)
  1390	{
  1391		struct device *dev = &pdev->dev;
  1392		struct nct6683_sio_data *sio_data = dev->platform_data;
  1393		struct attribute_group *group;
  1394		struct nct6683_data *data;
  1395		struct device *hwmon_dev;
  1396		struct resource *res;
  1397		int groups = 0;
  1398		int ret;
  1399		char build[16];
  1400		u_char reg;
  1401	
  1402		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
  1403		if (!devm_request_region(dev, res->start, IOREGION_LENGTH, DRVNAME))
  1404			return -EBUSY;
  1405	
  1406		data = devm_kzalloc(dev, sizeof(struct nct6683_data), GFP_KERNEL);
  1407		if (!data)
  1408			return -ENOMEM;
  1409	
  1410		data->kind = sio_data->kind;
  1411		data->sioreg = sio_data->sioreg;
  1412		data->addr = res->start;
  1413		mutex_init(&data->update_lock);
  1414		platform_set_drvdata(pdev, data);
  1415	
  1416		data->customer_id = nct6683_read16(data, NCT6683_REG_CUSTOMER_ID);
  1417	
  1418		/* By default only instantiate driver if the customer ID is known */
  1419		switch (data->customer_id) {
  1420		case NCT6683_CUSTOMER_ID_LENOVO:
  1421			break;
  1422		case NCT6683_CUSTOMER_ID_INTEL:
  1423			break;
  1424		case NCT6683_CUSTOMER_ID_MITAC:
  1425			break;
  1426		case NCT6683_CUSTOMER_ID_MSI:
  1427			break;
  1428		case NCT6683_CUSTOMER_ID_ASROCK:
  1429			break;
  1430		case NCT6683_CUSTOMER_ID_ASROCK2:
  1431			break;
  1432		default:
  1433			if (!force)
  1434				return -ENODEV;
  1435		}
  1436	
  1437		nct6683_init_device(data);
  1438		nct6683_setup_fans(data);
  1439		nct6683_setup_sensors(data);
  1440	
  1441		/* Register sysfs hooks */
  1442	
  1443		if (data->have_pwm) {
  1444			group = nct6683_create_attr_group(dev,
  1445							  &nct6683_pwm_template_group,
  1446							  fls(data->have_pwm));
  1447			if (IS_ERR(group))
  1448				return PTR_ERR(group);
  1449			data->groups[groups++] = group;
  1450		}
  1451	
  1452		if (data->in_num) {
  1453			group = nct6683_create_attr_group(dev,
  1454							  &nct6683_in_template_group,
  1455							  data->in_num);
  1456			if (IS_ERR(group))
  1457				return PTR_ERR(group);
  1458			data->groups[groups++] = group;
  1459		}
  1460	
  1461		if (data->have_fan) {
  1462			group = nct6683_create_attr_group(dev,
  1463							  &nct6683_fan_template_group,
  1464							  fls(data->have_fan));
  1465			if (IS_ERR(group))
  1466				return PTR_ERR(group);
  1467			data->groups[groups++] = group;
  1468		}
  1469	
  1470		if (data->temp_num) {
  1471			group = nct6683_create_attr_group(dev,
  1472							  &nct6683_temp_template_group,
  1473							  data->temp_num);
  1474			if (IS_ERR(group))
  1475				return PTR_ERR(group);
  1476			data->groups[groups++] = group;
  1477		}
  1478		data->groups[groups++] = &nct6683_group_other;
  1479	
  1480		if (data->customer_id == NCT6683_CUSTOMER_ID_INTEL)
  1481			scnprintf(build, sizeof(build), "%02x/%02x/%02x",
  1482				  nct6683_read(data, NCT6683_REG_BUILD_MONTH),
  1483				  nct6683_read(data, NCT6683_REG_BUILD_DAY),
  1484				  nct6683_read(data, NCT6683_REG_BUILD_YEAR));
  1485		else
  1486			scnprintf(build, sizeof(build), "%02d/%02d/%02d",
  1487				  nct6683_read(data, NCT6683_REG_BUILD_MONTH),
  1488				  nct6683_read(data, NCT6683_REG_BUILD_DAY),
  1489				  nct6683_read(data, NCT6683_REG_BUILD_YEAR));
  1490	
  1491		dev_info(dev, "%s EC firmware version %d.%d build %s\n",
  1492			 nct6683_chip_names[data->kind],
  1493			 nct6683_read(data, NCT6683_REG_VERSION_HI),
  1494			 nct6683_read(data, NCT6683_REG_VERSION_LO),
  1495			 build);
  1496	
  1497		hwmon_dev = devm_hwmon_device_register_with_groups(dev,
  1498				nct6683_device_names[data->kind], data, data->groups);
  1499	
  1500		ret = PTR_ERR_OR_ZERO(hwmon_dev);
  1501		if (ret)
  1502			return ret;
  1503	
  1504		if (data->kind == nct6686 && data->customer_id == NCT6683_CUSTOMER_ID_LENOVO) {
  1505			/* Watchdog initialization */
  1506			data->wdt.ops = &nct6686_wdt_ops;
  1507			data->wdt.info = &nct6686_wdt_info;
  1508	
  1509			data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
  1510			data->wdt.min_timeout = MIN_TIMEOUT;
  1511			data->wdt.max_timeout = MAX_TIMEOUT;
  1512			data->wdt.parent = &pdev->dev;
  1513	
> 1514			watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
  1515			watchdog_set_nowayout(&data->wdt, nowayout);
  1516			watchdog_set_drvdata(&data->wdt, data);
  1517	
  1518			/* reset trigger status */
  1519			reg = nct6686_read(data, WDT_STS);
  1520			nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
  1521	
  1522			watchdog_stop_on_unregister(&data->wdt);
  1523	
> 1524			return devm_watchdog_register_device(dev, &data->wdt);
  1525		}
  1526		return ret;
  1527	}
  1528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
