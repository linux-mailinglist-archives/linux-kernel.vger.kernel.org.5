Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3777F6D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKXH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjKXH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:57:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71DD5E;
        Thu, 23 Nov 2023 23:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700812667; x=1732348667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=reO45DBNXcC0NtvfY1wTXQz3ggEphLlBMXK6lHvMXR0=;
  b=DyQNJ+stYq6Ol4X/WFDPyikrohaTFWZ4481p6Z3WNCFNMfEHhxLK9gAW
   NT5jZRcCTPmuy7uCPsHa+6g2P9fWBLBQCuGNLdyc3gNDCzRQRcIFWdhMR
   tgVHO363OtHoaZn3SvckpJX4Fl9ICZMtCC8YbLmbx4z8pmSTfL3fgpnt8
   K3Ww/gN21cH2L2Gon2w/O2CUnbqSX77soRn2ZcvIJYE5tHWRQidHh0Ejn
   T8otyhy0iLTU5GxnpCVmNyPxtKVF5C1d/bo5WRQDTw1eFs6FzbQbV3RO+
   9LKi6CublvtOtE5JHoMaX50GR2yX9MjG5YHvhyf1YJZ+y/L1RI/G0cN8X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395199324"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="395199324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:57:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767393149"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="767393149"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 23:57:39 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6R4D-0002FC-1I;
        Fri, 24 Nov 2023 07:57:37 +0000
Date:   Fri, 24 Nov 2023 15:56:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, shengnan.wang@mediatek.com,
        yaya.chang@mediatek.com, 10572168@qq.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
        zhi.mao@mediatek.com, hverkuil-cisco@xs4all.nl, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com,
        hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com,
        gerald.loacker@wolfvision.net, andy.shevchenko@gmail.com,
        bingbu.cao@intel.com, dan.scally@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <202311241238.fnVeS1ty-lkp@intel.com>
References: <20231123115104.32094-3-zhi.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123115104.32094-3-zhi.mao@mediatek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linuxtv-media-stage/master sailus-media-tree/streams linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhi-Mao/media-dt-bindings-media-i2c-Document-GC08A3-bindings/20231123-203838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231123115104.32094-3-zhi.mao%40mediatek.com
patch subject: [PATCH 2/2] media: i2c: Add GC08A3 image sensor driver
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20231124/202311241238.fnVeS1ty-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241238.fnVeS1ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241238.fnVeS1ty-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/i2c/gc08a3.c: In function 'gc08a3_probe':
   drivers/media/i2c/gc08a3.c:1965:13: error: 'V4L2_SUBDEV_NAME_SIZE' undeclared (first use in this function); did you mean 'V4L2_SUBDEV_FL_IS_I2C'?
    1965 |         if (V4L2_SUBDEV_NAME_SIZE - strlen(gc08a3->sd.name) - 2 <
         |             ^~~~~~~~~~~~~~~~~~~~~
         |             V4L2_SUBDEV_FL_IS_I2C
   drivers/media/i2c/gc08a3.c:1965:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/i2c/gc08a3.c: At top level:
   drivers/media/i2c/gc08a3.c:2038:10: error: 'struct i2c_driver' has no member named 'probe_new'
    2038 |         .probe_new  = gc08a3_probe,
         |          ^~~~~~~~~
   drivers/media/i2c/gc08a3.c:2038:23: error: initialization of 'const struct i2c_device_id *' from incompatible pointer type 'int (*)(struct i2c_client *)' [-Werror=incompatible-pointer-types]
    2038 |         .probe_new  = gc08a3_probe,
         |                       ^~~~~~~~~~~~
   drivers/media/i2c/gc08a3.c:2038:23: note: (near initialization for 'gc08a3_i2c_driver.id_table')
   drivers/media/i2c/gc08a3.c: In function 'gc08a3_probe':
>> drivers/media/i2c/gc08a3.c:1971:9: warning: 'strncat' specified bound 1 equals source length [-Wstringop-overflow=]
    1971 |         strncat(gc08a3->sd.name, " ", 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/strncat +1971 drivers/media/i2c/gc08a3.c

  1889	
  1890	static int gc08a3_probe(struct i2c_client *client)
  1891	{
  1892		struct device *dev = &client->dev;
  1893		struct gc08a3 *gc08a3;
  1894		int ret;
  1895	
  1896		dev_info(dev, "--- %s +", __func__);
  1897	
  1898		ret = gc08a3_parse_fwnode(dev);
  1899		if (ret)
  1900			return ret;
  1901	
  1902		gc08a3 = devm_kzalloc(dev, sizeof(*gc08a3), GFP_KERNEL);
  1903		if (!gc08a3)
  1904			return -ENOMEM;
  1905	
  1906		gc08a3->dev = dev;
  1907	
  1908		gc08a3->xclk = devm_clk_get(dev, NULL);
  1909		if (IS_ERR(gc08a3->xclk)) {
  1910			dev_err(dev, "could not get xclk\n");
  1911			return PTR_ERR(gc08a3->xclk);
  1912		}
  1913	
  1914		ret = clk_set_rate(gc08a3->xclk, GC08A3_DEFAULT_CLK_FREQ);
  1915		if (ret) {
  1916			dev_err(dev, "could not set xclk frequency\n");
  1917			return ret;
  1918		}
  1919	
  1920		ret = gc08a3_get_regulators(dev, gc08a3);
  1921		if (ret < 0) {
  1922			dev_err(dev, "cannot get regulators\n");
  1923			return ret;
  1924		}
  1925	
  1926		gc08a3->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
  1927		if (IS_ERR(gc08a3->enable_gpio)) {
  1928			dev_err(dev, "cannot get enable gpio\n");
  1929			return PTR_ERR(gc08a3->enable_gpio);
  1930		}
  1931	
  1932		gc08a3->regmap = devm_regmap_init_i2c(client, &sensor_regmap_config);
  1933		if (IS_ERR(gc08a3->regmap)) {
  1934			dev_err(dev, "regmap init failed\n");
  1935			return PTR_ERR(gc08a3->regmap);
  1936		}
  1937	
  1938		v4l2_i2c_subdev_init(&gc08a3->sd, client, &gc08a3_subdev_ops);
  1939	
  1940		gc08a3_power_on(gc08a3->dev);
  1941	
  1942		ret = gc08a3_identify_module(gc08a3);
  1943		if (ret) {
  1944			dev_err(&client->dev, "failed to find sensor: %d\n", ret);
  1945			gc08a3_power_off(gc08a3->dev);
  1946			return ret;
  1947		}
  1948	
  1949		mutex_init(&gc08a3->mutex);
  1950		gc08a3->cur_mode = &gc08a3_modes[0];
  1951	
  1952		ret = gc08a3_init_controls(gc08a3);
  1953		if (ret) {
  1954			dev_err(&client->dev, "failed to init controls: %d", ret);
  1955			goto free_ctrl;
  1956		}
  1957	
  1958		gc08a3->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
  1959		gc08a3->pad.flags = MEDIA_PAD_FL_SOURCE;
  1960		gc08a3->sd.dev = &client->dev;
  1961		gc08a3->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
  1962	
  1963		dev_dbg(&client->dev, "gc08a3->sd.name: %s, dev->of_node->name: %s\n",
  1964			gc08a3->sd.name, dev->of_node->name);
  1965		if (V4L2_SUBDEV_NAME_SIZE - strlen(gc08a3->sd.name) - 2 <
  1966		    strlen(dev->of_node->name)) {
  1967			dev_err(&client->dev,
  1968				"the string length of (sd.name + of_node->name) is too long.\n");
  1969			return -EINVAL;
  1970		}
> 1971		strncat(gc08a3->sd.name, " ", 1);
  1972		strncat(gc08a3->sd.name, dev->of_node->name,
  1973			V4L2_SUBDEV_NAME_SIZE - strlen(gc08a3->sd.name) - 2);
  1974		dev_dbg(&client->dev, "after: gc08a3->sd.name: %s\n", gc08a3->sd.name);
  1975	
  1976		ret = media_entity_pads_init(&gc08a3->sd.entity, 1, &gc08a3->pad);
  1977		if (ret < 0) {
  1978			dev_err(dev, "could not register media entity\n");
  1979			goto free_ctrl;
  1980		}
  1981	
  1982		ret = v4l2_async_register_subdev_sensor(&gc08a3->sd);
  1983		if (ret < 0) {
  1984			dev_err(dev, "could not register v4l2 device\n");
  1985			goto free_entity;
  1986		}
  1987	
  1988		pm_runtime_set_active(gc08a3->dev);
  1989		pm_runtime_enable(gc08a3->dev);
  1990		pm_runtime_idle(gc08a3->dev);
  1991	
  1992		dev_info(dev, "--- %s -", __func__);
  1993	
  1994		return 0;
  1995	
  1996	free_entity:
  1997		media_entity_cleanup(&gc08a3->sd.entity);
  1998	free_ctrl:
  1999		mutex_destroy(&gc08a3->mutex);
  2000		v4l2_ctrl_handler_free(&gc08a3->ctrls);
  2001		pm_runtime_disable(gc08a3->dev);
  2002	
  2003		return ret;
  2004	}
  2005	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
