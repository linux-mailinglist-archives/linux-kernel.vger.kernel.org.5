Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437037B7100
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbjJCSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240772AbjJCSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:35:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08416AF;
        Tue,  3 Oct 2023 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358125; x=1727894125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1efFUb+6PT2mcTSVJjAVd93d/gbP7EU4t5/Y7eNlYo=;
  b=amX5lHa9EN6ufnuEvwVe0jRyMvrotxOg1VtyqE9HHm/6Tc2OlFU445x1
   LegIpRt7enCuarJZtkuT1hhl58MbsgtZdTmaMtHjQKZCP1DdZlj5ggxxM
   g7/JvOLiAOD4CFQJOYV6Xx9UVRgy4QIFJwvDmXCVD4iSSBRKh519B2V8S
   7qxsTWC9/FCTjWADfZn5/Q8shGUfH9VzkesKQdru1IJOpJW7mUsyKXtBn
   Hzav6un5YTaV9FUHJGD2K2U8IoekCaBhQXlcmkyQSrENnVY88BN+oTl2M
   nYT0sbfO6+QEZtOF6Kj+6dLEq3z5qU+9kgd3U/Nb2W8dY49F3aIelRhgy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="362315126"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="362315126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816804585"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816804585"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2023 11:35:23 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnkEp-0008K5-0l;
        Tue, 03 Oct 2023 18:35:19 +0000
Date:   Wed, 4 Oct 2023 02:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 30/36] pinctrl: remove old GPIO helpers
Message-ID: <202310040236.w3AOZ94W-lkp@intel.com>
References: <20231003145114.21637-31-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003145114.21637-31-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next next-20231003]
[cannot apply to brgl/gpio/for-next geert-renesas-drivers/renesas-pinctrl linus/master v6.6-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/pinctrl-remove-unneeded-extern-specifiers-from-consumer-h/20231003-225540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231003145114.21637-31-brgl%40bgdev.pl
patch subject: [PATCH 30/36] pinctrl: remove old GPIO helpers
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231004/202310040236.w3AOZ94W-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231004/202310040236.w3AOZ94W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310040236.w3AOZ94W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/core.c:338: warning: Excess function parameter 'offset' description in 'pinctrl_ready_for_gpio_range'


vim +338 drivers/pinctrl/core.c

2744e8afb3b763 Linus Walleij       2011-05-02  321  
51e13c2475913d Haojian Zhuang      2013-02-17  322  /**
51e13c2475913d Haojian Zhuang      2013-02-17  323   * pinctrl_ready_for_gpio_range() - check if other GPIO pins of
51e13c2475913d Haojian Zhuang      2013-02-17  324   * the same GPIO chip are in range
4b4af250917e1a Bartosz Golaszewski 2023-10-03  325   * @gc: GPIO chip structure from the GPIO subsystem
4b4af250917e1a Bartosz Golaszewski 2023-10-03  326   * @offset: hardware offset of the GPIO relative to the controller
51e13c2475913d Haojian Zhuang      2013-02-17  327   *
51e13c2475913d Haojian Zhuang      2013-02-17  328   * This function is complement of pinctrl_match_gpio_range(). If the return
51e13c2475913d Haojian Zhuang      2013-02-17  329   * value of pinctrl_match_gpio_range() is NULL, this function could be used
51e13c2475913d Haojian Zhuang      2013-02-17  330   * to check whether pinctrl device is ready or not. Maybe some GPIO pins
51e13c2475913d Haojian Zhuang      2013-02-17  331   * of the same GPIO chip don't have back-end pinctrl interface.
51e13c2475913d Haojian Zhuang      2013-02-17  332   * If the return value is true, it means that pinctrl device is ready & the
51e13c2475913d Haojian Zhuang      2013-02-17  333   * certain GPIO pin doesn't have back-end pinctrl device. If the return value
51e13c2475913d Haojian Zhuang      2013-02-17  334   * is false, it means that pinctrl device may not be ready.
51e13c2475913d Haojian Zhuang      2013-02-17  335   */
2afe8229687ec2 Haojian Zhuang      2013-03-28  336  #ifdef CONFIG_GPIOLIB
4b4af250917e1a Bartosz Golaszewski 2023-10-03  337  static bool pinctrl_ready_for_gpio_range(struct gpio_chip *gc)
51e13c2475913d Haojian Zhuang      2013-02-17 @338  {
51e13c2475913d Haojian Zhuang      2013-02-17  339  	struct pinctrl_dev *pctldev;
51e13c2475913d Haojian Zhuang      2013-02-17  340  	struct pinctrl_gpio_range *range = NULL;
942cde724075f8 Tony Lindgren       2015-09-03  341  
44d5f7bbead9e7 Linus Walleij       2013-05-16  342  	mutex_lock(&pinctrldev_list_mutex);
44d5f7bbead9e7 Linus Walleij       2013-05-16  343  
51e13c2475913d Haojian Zhuang      2013-02-17  344  	/* Loop over the pin controllers */
51e13c2475913d Haojian Zhuang      2013-02-17  345  	list_for_each_entry(pctldev, &pinctrldev_list, node) {
51e13c2475913d Haojian Zhuang      2013-02-17  346  		/* Loop over the ranges */
5ffbe2e6138732 Axel Lin            2013-08-18  347  		mutex_lock(&pctldev->mutex);
51e13c2475913d Haojian Zhuang      2013-02-17  348  		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
51e13c2475913d Haojian Zhuang      2013-02-17  349  			/* Check if any gpio range overlapped with gpio chip */
4b4af250917e1a Bartosz Golaszewski 2023-10-03  350  			if (range->base + range->npins - 1 < gc->base ||
4b4af250917e1a Bartosz Golaszewski 2023-10-03  351  			    range->base > gc->base + gc->ngpio - 1)
51e13c2475913d Haojian Zhuang      2013-02-17  352  				continue;
5ffbe2e6138732 Axel Lin            2013-08-18  353  			mutex_unlock(&pctldev->mutex);
44d5f7bbead9e7 Linus Walleij       2013-05-16  354  			mutex_unlock(&pinctrldev_list_mutex);
51e13c2475913d Haojian Zhuang      2013-02-17  355  			return true;
51e13c2475913d Haojian Zhuang      2013-02-17  356  		}
5ffbe2e6138732 Axel Lin            2013-08-18  357  		mutex_unlock(&pctldev->mutex);
51e13c2475913d Haojian Zhuang      2013-02-17  358  	}
44d5f7bbead9e7 Linus Walleij       2013-05-16  359  
44d5f7bbead9e7 Linus Walleij       2013-05-16  360  	mutex_unlock(&pinctrldev_list_mutex);
44d5f7bbead9e7 Linus Walleij       2013-05-16  361  
51e13c2475913d Haojian Zhuang      2013-02-17  362  	return false;
51e13c2475913d Haojian Zhuang      2013-02-17  363  }
2afe8229687ec2 Haojian Zhuang      2013-03-28  364  #else
4b4af250917e1a Bartosz Golaszewski 2023-10-03  365  static bool pinctrl_ready_for_gpio_range(struct gpio_chip *gc) { return true; }
2afe8229687ec2 Haojian Zhuang      2013-03-28  366  #endif
51e13c2475913d Haojian Zhuang      2013-02-17  367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
