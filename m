Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E7D75C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJYUfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:35:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E0136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698266139; x=1729802139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o1yuSRsgQc+sPh946y487tolXIujCnSoSyc/S22vVb8=;
  b=UdwAp3hBmiuImjD4wgrDWTnKyHqDmcqnjtaHtkIvEe/tAAhF1RZweM9B
   nIbiBIIQtNyHSjHvYtXI+y2wQ3i/XYjvxD0+MGlSXHegda4FShoZp/wZO
   bgiDeCIxU+7Ziqfwo5fsetUucaa+vEQvVpwdUdLbMf1JW/1fHFyk7Yggh
   szMz/lZ9U60U7G1l4MjD0xQDU5vKCnK6pDQGc941+jbyCH8o8769q2eqL
   ddZolwyKItCxxZPcOiAxcToIaDlVKbekKq0jKSisGh6qA2jWwRnszMfyO
   HcLiSTWFQjorGy1er8NHSgc0SQA5KhaIXg9fy2Yv7/3KQj/I4hFf0oKSz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="8949855"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="8949855"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762579376"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762579376"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2023 13:35:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvkbE-0009BS-19;
        Wed, 25 Oct 2023 20:35:32 +0000
Date:   Thu, 26 Oct 2023 04:34:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-si521xx.c:318:26: warning: '%d' directive output may
 be truncated writing between 1 and 10 bytes into a region of size 2
Message-ID: <202310260412.AGASjFN4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   611da07b89fdd53f140d7b33013f255bf0ed8f34
commit: edc12763a3a29836b23c4fc97a1207baea1d11e8 clk: si521xx: Clock driver for Skyworks Si521xx I2C PCIe clock generators
date:   7 months ago
config: x86_64-buildonly-randconfig-004-20231026 (https://download.01.org/0day-ci/archive/20231026/202310260412.AGASjFN4-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260412.AGASjFN4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260412.AGASjFN4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/clk-si521xx.c: In function 'si521xx_probe':
>> drivers/clk/clk-si521xx.c:318:26: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
      snprintf(name, 6, "DIFF%d", i);
                             ^~
   drivers/clk/clk-si521xx.c:318:21: note: directive argument in the range [0, 2147483647]
      snprintf(name, 6, "DIFF%d", i);
                        ^~~~~~~~
   drivers/clk/clk-si521xx.c:318:3: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
      snprintf(name, 6, "DIFF%d", i);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +318 drivers/clk/clk-si521xx.c

   279	
   280	static int si521xx_probe(struct i2c_client *client)
   281	{
   282		const u16 chip_info = (u16)(uintptr_t)device_get_match_data(&client->dev);
   283		const struct clk_parent_data clk_parent_data = { .index = 0 };
   284		struct si521xx *si;
   285		unsigned char name[6] = "DIFF0";
   286		struct clk_init_data init = {};
   287		int i, ret;
   288	
   289		if (!chip_info)
   290			return -EINVAL;
   291	
   292		si = devm_kzalloc(&client->dev, sizeof(*si), GFP_KERNEL);
   293		if (!si)
   294			return -ENOMEM;
   295	
   296		i2c_set_clientdata(client, si);
   297		si->client = client;
   298	
   299		/* Fetch common configuration from DT (if specified) */
   300		ret = si521xx_get_common_config(si);
   301		if (ret)
   302			return ret;
   303	
   304		si->regmap = devm_regmap_init(&client->dev, NULL, client,
   305					      &si521xx_regmap_config);
   306		if (IS_ERR(si->regmap))
   307			return dev_err_probe(&client->dev, PTR_ERR(si->regmap),
   308					     "Failed to allocate register map\n");
   309	
   310		/* Always read back 1 Byte via I2C */
   311		ret = regmap_write(si->regmap, SI521XX_REG_BC, 1);
   312		if (ret < 0)
   313			return ret;
   314	
   315		/* Register clock */
   316		for (i = 0; i < hweight16(chip_info); i++) {
   317			memset(&init, 0, sizeof(init));
 > 318			snprintf(name, 6, "DIFF%d", i);
   319			init.name = name;
   320			init.ops = &si521xx_diff_clk_ops;
   321			init.parent_data = &clk_parent_data;
   322			init.num_parents = 1;
   323			init.flags = CLK_SET_RATE_PARENT;
   324	
   325			si->clk_dif[i].hw.init = &init;
   326			si->clk_dif[i].si = si;
   327	
   328			si521xx_diff_idx_to_reg_bit(chip_info, i, &si->clk_dif[i]);
   329	
   330			ret = devm_clk_hw_register(&client->dev, &si->clk_dif[i].hw);
   331			if (ret)
   332				return ret;
   333		}
   334	
   335		ret = devm_of_clk_add_hw_provider(&client->dev, si521xx_of_clk_get, si);
   336		if (!ret)
   337			si521xx_update_config(si);
   338	
   339		return ret;
   340	}
   341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
