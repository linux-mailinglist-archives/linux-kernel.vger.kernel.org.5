Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700D88139FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572995AbjLNSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjLNSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:30:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19911B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702578606; x=1734114606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ew09GcjkZYq5BSwV4yo5CvVrIH5rflhUjotYPDNsyGI=;
  b=Lv4K0OXC+LskXODW+mHY/tB+Pupj9BNK3cBbE96kJKEwShuAcDtDhuxl
   kKvAKBeX1g9H4+b6mZF54g5i1U61uajolOAWYoamZ8pWaX7UyLtsfHVy5
   I0rX7Kaild7ScBI5ey0ElNNlOiaVeJxhpztDLQyuv/8vzuqAoe7fsOnVU
   0HyiHojp+Lzvt4TF0iL5c5MDe7jlr8CeJQ4Jj51lFK/rarRjAjw1VrXZE
   qAXeg4SethJFszMEQu8DGt2vTjyzN5RwZPEumv2g+qEl5R3lSImvvhyIv
   FPygiEcpAiPJyHZ8yhE6p5hCO+wshY54+HNWNSASXeNxrEe5dpY1G8w+X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="459487335"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="459487335"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="777980982"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="777980982"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 10:30:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDqTB-000MTB-1f;
        Thu, 14 Dec 2023 18:30:01 +0000
Date:   Fri, 15 Dec 2023 02:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/gpio/gpio-xilinx.c:75: warning: Excess struct member
 'irqchip' description in 'xgpio_instance'
Message-ID: <202312150239.IyuTVvrL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: b4510f8fd5d0e9afa777f115871f5d522540c417 gpio: xilinx: Convert to immutable irq_chip
date:   9 months ago
config: arm-randconfig-r081-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150239.IyuTVvrL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150239.IyuTVvrL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150239.IyuTVvrL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-xilinx.c:75: warning: Excess struct member 'irqchip' description in 'xgpio_instance'


vim +75 drivers/gpio/gpio-xilinx.c

74600ee017557b drivers/gpio/gpio-xilinx.c Michal Simek    2013-06-03  43  
74600ee017557b drivers/gpio/gpio-xilinx.c Michal Simek    2013-06-03  44  /**
74600ee017557b drivers/gpio/gpio-xilinx.c Michal Simek    2013-06-03  45   * struct xgpio_instance - Stores information about GPIO device
1ebd06871b57a6 drivers/gpio/gpio-xilinx.c Robert Hancock  2019-06-07  46   * @gc: GPIO chip
1ebd06871b57a6 drivers/gpio/gpio-xilinx.c Robert Hancock  2019-06-07  47   * @regs: register block
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  48   * @hw_map: GPIO pin mapping on hardware side
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  49   * @sw_map: GPIO pin mapping on software side
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  50   * @state: GPIO write state shadow register
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  51   * @last_irq_read: GPIO read state register from last interrupt
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  52   * @dir: GPIO direction shadow register
4ae798fae200f1 drivers/gpio/gpio-xilinx.c Ricardo Ribalda 2014-12-17  53   * @gpio_lock: Lock used for synchronization
a32c7caea292c4 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2021-01-29  54   * @irq: IRQ used by GPIO device
a32c7caea292c4 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2021-01-29  55   * @irqchip: IRQ chip
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  56   * @enable: GPIO IRQ enable/disable bitfield
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  57   * @rising_edge: GPIO IRQ rising edge enable/disable bitfield
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  58   * @falling_edge: GPIO IRQ falling edge enable/disable bitfield
65bbe531b54668 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2020-11-12  59   * @clk: clock resource for this driver
74600ee017557b drivers/gpio/gpio-xilinx.c Michal Simek    2013-06-03  60   */
0bcb6069a6e1af drivers/gpio/xilinx_gpio.c John Linn       2008-11-12  61  struct xgpio_instance {
1ebd06871b57a6 drivers/gpio/gpio-xilinx.c Robert Hancock  2019-06-07  62  	struct gpio_chip gc;
1ebd06871b57a6 drivers/gpio/gpio-xilinx.c Robert Hancock  2019-06-07  63  	void __iomem *regs;
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  64  	DECLARE_BITMAP(hw_map, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  65  	DECLARE_BITMAP(sw_map, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  66  	DECLARE_BITMAP(state, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  67  	DECLARE_BITMAP(last_irq_read, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  68  	DECLARE_BITMAP(dir, 64);
37ef3346808002 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2021-01-29  69  	spinlock_t gpio_lock;	/* For serializing operations */
a32c7caea292c4 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2021-01-29  70  	int irq;
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  71  	DECLARE_BITMAP(enable, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  72  	DECLARE_BITMAP(rising_edge, 64);
02b3f84d9080b0 drivers/gpio/gpio-xilinx.c Andy Shevchenko 2021-05-10  73  	DECLARE_BITMAP(falling_edge, 64);
65bbe531b54668 drivers/gpio/gpio-xilinx.c Srinivas Neeli  2020-11-12  74  	struct clk *clk;
749564ffd52d91 drivers/gpio/gpio-xilinx.c Ricardo Ribalda 2014-12-17 @75  };
749564ffd52d91 drivers/gpio/gpio-xilinx.c Ricardo Ribalda 2014-12-17  76  

:::::: The code at line 75 was first introduced by commit
:::::: 749564ffd52d91ddf9917315e6fba2a3dcf3137e gpio/xilinx: Convert the driver to platform device interface

:::::: TO: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
