Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129278C2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjH2LDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjH2LCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:02:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9601BF;
        Tue, 29 Aug 2023 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693306937; x=1724842937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3IQM9XUFuiw0cc6YWUAcx9te9fkr2VyGxhJSVNY+I0=;
  b=QFBFJ/4QlSUy8fePOGJgsQ/ckuIiemRWAFTygk+mJH1zdlAro7N+WDEb
   T1mAhE+xYqFiEOuc2pjU9GBdDihJmo46RQe2WkF0t09N+wsXDUUuYdiAn
   zHXQYq1kmQ58OPaRfRiKxsd8nBS6+5Xbo7lP4lnGGAkt/Cq/PIT3s/Q2d
   beUHQcWqWLCohlTH7i2pU4DbfKjrjk7gUBkSMrhv8Motcpmb3qa6Hs4mY
   q8HZCKvgXKwKdlyHvXPXUBswJNnzZ9LkY+TfX4paH8kWbCXXt6h6tcPJs
   qvoNmm4cy5zYzj0sRHRSXsTtteCZU5x4VJK2jERx4Wch0RrSNhXqwgzQ7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375301306"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="375301306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 04:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="828759941"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="828759941"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2023 04:02:12 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qawTu-0008g1-02;
        Tue, 29 Aug 2023 11:02:00 +0000
Date:   Tue, 29 Aug 2023 19:00:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Mateusz Majewski <m.majewski2@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 10/11] thermal: exynos: use set_trips
Message-ID: <202308291857.W4jDgr7Y-lkp@intel.com>
References: <20230829091853.626011-11-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829091853.626011-11-m.majewski2@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on krzk/for-next arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.5 next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Majewski/ARM-dts-exynos-enable-polling-in-Exynos-4210/20230829-172850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230829091853.626011-11-m.majewski2%40samsung.com
patch subject: [PATCH 10/11] thermal: exynos: use set_trips
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230829/202308291857.W4jDgr7Y-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308291857.W4jDgr7Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308291857.W4jDgr7Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/samsung/exynos_tmu.c:198: warning: Function parameter or member 'tmu_set_low_temp' not described in 'exynos_tmu_data'
>> drivers/thermal/samsung/exynos_tmu.c:198: warning: Function parameter or member 'tmu_set_high_temp' not described in 'exynos_tmu_data'
>> drivers/thermal/samsung/exynos_tmu.c:198: warning: Function parameter or member 'tmu_set_crit_temp' not described in 'exynos_tmu_data'
>> drivers/thermal/samsung/exynos_tmu.c:198: warning: Function parameter or member 'tmu_disable_low' not described in 'exynos_tmu_data'
>> drivers/thermal/samsung/exynos_tmu.c:198: warning: Function parameter or member 'tmu_disable_high' not described in 'exynos_tmu_data'


vim +198 drivers/thermal/samsung/exynos_tmu.c

7efd18a2a181551 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  137  
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  138  /**
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  139   * struct exynos_tmu_data : A structure to hold the private data of the TMU
9625e9e694e7470 drivers/thermal/samsung/exynos_tmu.c Amit Kucheria             2019-11-20  140   *			    driver
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  141   * @base: base address of the single instance of the TMU controller.
9025d563cd9bd14 drivers/thermal/samsung/exynos_tmu.c Naveen Krishna Chatradhi  2013-12-19  142   * @base_second: base address of the common registers of the TMU controller.
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  143   * @irq: irq number of the TMU controller.
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  144   * @soc: id of the SOC type.
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  145   * @lock: lock to implement synchronization.
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  146   * @clk: pointer to the clock structure.
14a11dc7e0dbf4a drivers/thermal/samsung/exynos_tmu.c Naveen Krishna Chatradhi  2013-12-19  147   * @clk_sec: pointer to the clock structure for accessing the base_second.
6c247393cfdd669 drivers/thermal/samsung/exynos_tmu.c Abhilash Kesavan          2015-01-27  148   * @sclk: pointer to the clock structure for accessing the tmu special clk.
199b3e3c860cdf3 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  149   * @cal_type: calibration type for temperature
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  150   * @efuse_value: SoC defined fuse value
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  151   * @min_efuse_value: minimum valid trimming data
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  152   * @max_efuse_value: maximum valid trimming data
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  153   * @temp_error1: fused value of the first point trim.
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  154   * @temp_error2: fused value of the second point trim.
fccfe0993b5dc55 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  155   * @gain: gain of amplifier in the positive-TC generator block
fccfe0993b5dc55 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  156   *	0 < gain <= 15
61020d189dbc4a7 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  157   * @reference_voltage: reference voltage of amplifier
61020d189dbc4a7 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  158   *	in the positive-TC generator block
61020d189dbc4a7 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  159   *	0 < reference_voltage <= 31
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  160   * @reg_conf: pointer to structure to register with core thermal.
9625e9e694e7470 drivers/thermal/samsung/exynos_tmu.c Amit Kucheria             2019-11-20  161   * @tzd: pointer to thermal_zone_device structure
88fc6f73fddf64e drivers/thermal/samsung/exynos_tmu.c Marek Szyprowski          2018-04-16  162   * @enabled: current status of TMU device
9625e9e694e7470 drivers/thermal/samsung/exynos_tmu.c Amit Kucheria             2019-11-20  163   * @tmu_set_trip_temp: SoC specific method to set trip (rising threshold)
9625e9e694e7470 drivers/thermal/samsung/exynos_tmu.c Amit Kucheria             2019-11-20  164   * @tmu_set_trip_hyst: SoC specific to set hysteresis (falling threshold)
72d1100b736d2ff drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  165   * @tmu_initialize: SoC specific TMU initialization method
37f9034f99c3c1b drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  166   * @tmu_control: SoC specific TMU control method
b79985ca74b2592 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  167   * @tmu_read: SoC specific TMU temperature read method
285d994a51e45ca drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  168   * @tmu_set_emulation: SoC specific TMU emulation setting method
a7331f72d3eb2bf drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  169   * @tmu_clear_irqs: SoC specific TMU interrupts clearing method
cebe7373a7e659d drivers/thermal/samsung/exynos_tmu.c Amit Daniel Kachhap       2013-06-24  170   */
f22d9c03ccc9339 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2012-08-16  171  struct exynos_tmu_data {
9d97e5c81e15afa drivers/hwmon/exynos4_tmu.c          Donggeun Kim              2011-09-07  172  	void __iomem *base;
9025d563cd9bd14 drivers/thermal/samsung/exynos_tmu.c Naveen Krishna Chatradhi  2013-12-19  173  	void __iomem *base_second;
9d97e5c81e15afa drivers/hwmon/exynos4_tmu.c          Donggeun Kim              2011-09-07  174  	int irq;
f22d9c03ccc9339 drivers/thermal/exynos_thermal.c     Amit Daniel Kachhap       2012-08-16  175  	enum soc_type soc;
9d97e5c81e15afa drivers/hwmon/exynos4_tmu.c          Donggeun Kim              2011-09-07  176  	struct mutex lock;
6c247393cfdd669 drivers/thermal/samsung/exynos_tmu.c Abhilash Kesavan          2015-01-27  177  	struct clk *clk, *clk_sec, *sclk;
199b3e3c860cdf3 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  178  	u32 cal_type;
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  179  	u32 efuse_value;
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  180  	u32 min_efuse_value;
e3ed36499bc9565 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  181  	u32 max_efuse_value;
6c247393cfdd669 drivers/thermal/samsung/exynos_tmu.c Abhilash Kesavan          2015-01-27  182  	u16 temp_error1, temp_error2;
fccfe0993b5dc55 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  183  	u8 gain;
61020d189dbc4a7 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-16  184  	u8 reference_voltage;
3b6a1a805f34247 drivers/thermal/samsung/exynos_tmu.c Lukasz Majewski           2015-01-23  185  	struct thermal_zone_device *tzd;
88fc6f73fddf64e drivers/thermal/samsung/exynos_tmu.c Marek Szyprowski          2018-04-16  186  	bool enabled;
3b6a1a805f34247 drivers/thermal/samsung/exynos_tmu.c Lukasz Majewski           2015-01-23  187  
93106a41fa1d04f drivers/thermal/samsung/exynos_tmu.c Mateusz Majewski          2023-08-29  188  	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
93106a41fa1d04f drivers/thermal/samsung/exynos_tmu.c Mateusz Majewski          2023-08-29  189  	void (*tmu_set_high_temp)(struct exynos_tmu_data *data, u8 temp);
93106a41fa1d04f drivers/thermal/samsung/exynos_tmu.c Mateusz Majewski          2023-08-29  190  	void (*tmu_set_crit_temp)(struct exynos_tmu_data *data, u8 temp);
93106a41fa1d04f drivers/thermal/samsung/exynos_tmu.c Mateusz Majewski          2023-08-29  191  	void (*tmu_disable_low)(struct exynos_tmu_data *data);
93106a41fa1d04f drivers/thermal/samsung/exynos_tmu.c Mateusz Majewski          2023-08-29  192  	void (*tmu_disable_high)(struct exynos_tmu_data *data);
c35268f589d545f drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2018-04-26  193  	void (*tmu_initialize)(struct platform_device *pdev);
37f9034f99c3c1b drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  194  	void (*tmu_control)(struct platform_device *pdev, bool on);
b79985ca74b2592 drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  195  	int (*tmu_read)(struct exynos_tmu_data *data);
17e8351a77397e8 drivers/thermal/samsung/exynos_tmu.c Sascha Hauer              2015-07-24  196  	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
a7331f72d3eb2bf drivers/thermal/samsung/exynos_tmu.c Bartlomiej Zolnierkiewicz 2014-11-13  197  	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
9d97e5c81e15afa drivers/hwmon/exynos4_tmu.c          Donggeun Kim              2011-09-07 @198  };
9d97e5c81e15afa drivers/hwmon/exynos4_tmu.c          Donggeun Kim              2011-09-07  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
