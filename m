Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA77E8B41
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjKKOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjKKOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:45:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313B3C05
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699713910; x=1731249910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Z5GBhvikeNhgd5pBavXtTRMfLTDXAG5he18S2VN6aM=;
  b=KEHg2BFxEX+HQyZhPNU/odX1U6gNNv8ppM9OUFweWbTBqHZu7+8M1Zdn
   dwfpfIshXfMtRJAUM1/Tl8bO3nnTEMazzoMfkCXBeEffbJ653yRAPCR8d
   Jr3re8eM7Iw7P+TLVwUTsMVPyfmZyZE5v/NGEiSpFd9LEDZoRcF8Xyv/m
   9p2TuVWigN9dcs4OLiBZ3kMgU7/oKtaxigWONc2H4a7LOGXcrUxj93+fO
   xIjeN1Zhjjrjlp73yiqsCXLjHw6B5vvmiSN1zs4jWrdMeS07I6htp4hRN
   TB6tr1VaKTYyX6oQbgXKWhkJeMJrKUo2TJztwGn7ubhu2dbb0Oju8fl4s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="369610495"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="369610495"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 06:45:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="5282460"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2023 06:45:08 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1pEQ-000AWE-0K;
        Sat, 11 Nov 2023 14:45:06 +0000
Date:   Sat, 11 Nov 2023 22:43:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function
 parameter or member 'phys.phy' not described in 'exynos5_usbdrd_phy'
Message-ID: <202311112233.05ft5O4Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 0b56e9a7e8358e59b21d8a425e463072bfae523c phy: Group vendor specific phy drivers
date:   6 years ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231111/202311112233.05ft5O4Q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112233.05ft5O4Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112233.05ft5O4Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys' not described in 'exynos5_usbdrd_phy'
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys.phy' not described in 'exynos5_usbdrd_phy'
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys.index' not described in 'exynos5_usbdrd_phy'
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys.reg_pmu' not described in 'exynos5_usbdrd_phy'
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys.pmu_offset' not described in 'exynos5_usbdrd_phy'
>> drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'phys.phy_cfg' not described in 'exynos5_usbdrd_phy'
   drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'vbus' not described in 'exynos5_usbdrd_phy'
   drivers/phy/samsung/phy-exynos5-usbdrd.c:184: warning: Function parameter or member 'vbus_boost' not described in 'exynos5_usbdrd_phy'


vim +184 drivers/phy/samsung/phy-exynos5-usbdrd.c

59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  146  
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  147  /**
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  148   * struct exynos5_usbdrd_phy - driver data for USB 3.0 PHY
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  149   * @dev: pointer to device instance of this platform device
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  150   * @reg_phy: usb phy controller register memory base
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  151   * @clk: phy clock for register access
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  152   * @pipeclk: clock for pipe3 phy
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  153   * @utmiclk: clock for utmi+ phy
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  154   * @itpclk: clock for ITP generation
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  155   * @drv_data: pointer to SoC level driver data structure
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  156   * @phys[]: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  157   *	    instances each with its 'phy' and 'phy_cfg'.
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  158   * @extrefclk: frequency select settings when using 'separate
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  159   *	       reference clocks' for SS and HS operations
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  160   * @ref_clk: reference clock to PHY block from which PHY's
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  161   *	     operational clocks are derived
a6867836db35d1 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  162   * vbus: VBUS regulator for phy
a6867836db35d1 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  163   * vbus_boost: Boost regulator for VBUS present on few Exynos boards
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  164   */
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  165  struct exynos5_usbdrd_phy {
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  166  	struct device *dev;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  167  	void __iomem *reg_phy;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  168  	struct clk *clk;
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  169  	struct clk *pipeclk;
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  170  	struct clk *utmiclk;
9bde18c1b5d2c9 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  171  	struct clk *itpclk;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  172  	const struct exynos5_usbdrd_phy_drvdata *drv_data;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  173  	struct phy_usb_instance {
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  174  		struct phy *phy;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  175  		u32 index;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  176  		struct regmap *reg_pmu;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  177  		u32 pmu_offset;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  178  		const struct exynos5_usbdrd_phy_config *phy_cfg;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  179  	} phys[EXYNOS5_DRDPHYS_NUM];
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  180  	u32 extrefclk;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  181  	struct clk *ref_clk;
4fc8a4e65fda32 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  182  	struct regulator *vbus;
a6867836db35d1 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-11-21  183  	struct regulator *vbus_boost;
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13 @184  };
59025887fb08a8 drivers/phy/phy-exynos5-usbdrd.c Vivek Gautam 2014-05-13  185  

:::::: The code at line 184 was first introduced by commit
:::::: 59025887fb08a8b913605fb20f8a62eb0bb69b36 phy: Add new Exynos5 USB 3.0 PHY driver

:::::: TO: Vivek Gautam <gautam.vivek@samsung.com>
:::::: CC: Kishon Vijay Abraham I <kishon@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
