Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1477DFEEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjKCFrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:47:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E918E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698990460; x=1730526460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MKfnBiSPKBD9/IF9uOK0p2RwDRATySgwhmkr2BQB1Ss=;
  b=CeHhl4MGe9QD7JpHMIcPPjsaYntIc3uj0J5tIkZ4393uLv2+G97r2CdE
   Ea0jea6SPI4xrhF9Hl5k5Jg/HZCzYeD5mQ746Vjzqkopvut7WlLMXtkgQ
   Wz7EMdM8AISpXeNf32jzL7uhoe/A41nRDv78q6FFDMi6zhNgjgY1M2aUW
   ZtD04gZHzrmPVwMDLPyWJY8Na5FuCJCwY1ipCG6qh2kj3ZNcYtEALQxKG
   V9fPKwIWbeGhonyZQ8yhPEo05i1ISgclv0oiRWiE6GqTqEjKkIKQZG1j+
   oAFmfyvimSz1DXgWBtQa5zZVrxztfjO7CD8knOZUIDHKzeuijFECtFN+3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="455373318"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="455373318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 22:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905237570"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="905237570"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2023 22:47:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyn1r-0002GI-1x;
        Fri, 03 Nov 2023 05:47:35 +0000
Date:   Fri, 3 Nov 2023 13:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: drivers/pinctrl/pinctrl-cy8c95x0.c:168: warning: Function parameter
 or member 'gpio_reset' not described in 'cy8c95x0_pinctrl'
Message-ID: <202311031342.r4To3GaD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
commit: 99084881de88ffcd156b03aaeb7d4eb740005e3e pinctrl: cy8c95x0: Add reset support
date:   4 months ago
config: parisc-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231103/202311031342.r4To3GaD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031342.r4To3GaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031342.r4To3GaD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-cy8c95x0.c:168: warning: Function parameter or member 'gpio_reset' not described in 'cy8c95x0_pinctrl'


vim +168 drivers/pinctrl/pinctrl-cy8c95x0.c

e6cbbe42944de9 Patrick Rudolph 2022-08-16  124  
e6cbbe42944de9 Patrick Rudolph 2022-08-16  125  /**
e6cbbe42944de9 Patrick Rudolph 2022-08-16  126   * struct cy8c95x0_pinctrl - driver data
e6cbbe42944de9 Patrick Rudolph 2022-08-16  127   * @regmap:         Device's regmap
e6cbbe42944de9 Patrick Rudolph 2022-08-16  128   * @irq_lock:       IRQ bus lock
e6cbbe42944de9 Patrick Rudolph 2022-08-16  129   * @i2c_lock:       Mutex for the device internal mux register
e6cbbe42944de9 Patrick Rudolph 2022-08-16  130   * @irq_mask:       I/O bits affected by interrupts
e6cbbe42944de9 Patrick Rudolph 2022-08-16  131   * @irq_trig_raise: I/O bits affected by raising voltage level
e6cbbe42944de9 Patrick Rudolph 2022-08-16  132   * @irq_trig_fall:  I/O bits affected by falling voltage level
e6cbbe42944de9 Patrick Rudolph 2022-08-16  133   * @irq_trig_low:   I/O bits affected by a low voltage level
e6cbbe42944de9 Patrick Rudolph 2022-08-16  134   * @irq_trig_high:  I/O bits affected by a high voltage level
e6cbbe42944de9 Patrick Rudolph 2022-08-16  135   * @push_pull:      I/O bits configured as push pull driver
e6cbbe42944de9 Patrick Rudolph 2022-08-16  136   * @shiftmask:      Mask used to compensate for Gport2 width
e6cbbe42944de9 Patrick Rudolph 2022-08-16  137   * @nport:          Number of Gports in this chip
e6cbbe42944de9 Patrick Rudolph 2022-08-16  138   * @gpio_chip:      gpiolib chip
e6cbbe42944de9 Patrick Rudolph 2022-08-16  139   * @driver_data:    private driver data
e6cbbe42944de9 Patrick Rudolph 2022-08-16  140   * @regulator:      Pointer to the regulator for the IC
e6cbbe42944de9 Patrick Rudolph 2022-08-16  141   * @dev:            struct device
e6cbbe42944de9 Patrick Rudolph 2022-08-16  142   * @pctldev:        pin controller device
e6cbbe42944de9 Patrick Rudolph 2022-08-16  143   * @pinctrl_desc:   pin controller description
e6cbbe42944de9 Patrick Rudolph 2022-08-16  144   * @name:           Chip controller name
e6cbbe42944de9 Patrick Rudolph 2022-08-16  145   * @tpin:           Total number of pins
e6cbbe42944de9 Patrick Rudolph 2022-08-16  146   */
e6cbbe42944de9 Patrick Rudolph 2022-08-16  147  struct cy8c95x0_pinctrl {
e6cbbe42944de9 Patrick Rudolph 2022-08-16  148  	struct regmap *regmap;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  149  	struct mutex irq_lock;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  150  	struct mutex i2c_lock;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  151  	DECLARE_BITMAP(irq_mask, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  152  	DECLARE_BITMAP(irq_trig_raise, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  153  	DECLARE_BITMAP(irq_trig_fall, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  154  	DECLARE_BITMAP(irq_trig_low, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  155  	DECLARE_BITMAP(irq_trig_high, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  156  	DECLARE_BITMAP(push_pull, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  157  	DECLARE_BITMAP(shiftmask, MAX_LINE);
e6cbbe42944de9 Patrick Rudolph 2022-08-16  158  	int nport;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  159  	struct gpio_chip gpio_chip;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  160  	unsigned long driver_data;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  161  	struct regulator *regulator;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  162  	struct device *dev;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  163  	struct pinctrl_dev *pctldev;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  164  	struct pinctrl_desc pinctrl_desc;
e6cbbe42944de9 Patrick Rudolph 2022-08-16  165  	char name[32];
e6cbbe42944de9 Patrick Rudolph 2022-08-16  166  	unsigned int tpin;
99084881de88ff Patrick Rudolph 2023-07-14  167  	struct gpio_desc *gpio_reset;
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @168  };
e6cbbe42944de9 Patrick Rudolph 2022-08-16  169  

:::::: The code at line 168 was first introduced by commit
:::::: e6cbbe42944de93ba4e0785b4f90d284b1d7cdf6 pinctrl: Add Cypress cy8c95x0 support

:::::: TO: Patrick Rudolph <patrick.rudolph@9elements.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
