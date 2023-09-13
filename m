Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3079EC82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjIMPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjIMPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:20:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697219B1;
        Wed, 13 Sep 2023 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694618446; x=1726154446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LTANdPAE8m2PHoe4hG/3j6oI5p3jyUM3ew3Mdwah6w=;
  b=jiYKS/gOLBjZh23IsE6wEHnQmcKATipXhTd+3wRmxvqyGFBBn4GsgfQl
   dXZx9q2Hz9XyuxYc6jEoI6dJ5tFkqLWRXPsEU9+q0l6SHKYf0S1W0f0Qu
   T6vtLXFITVSVAjiaPucsmqgx3y3whZeoGj9qWafHytLZqhqzsCrrkcVmt
   ZWcLTEU5ynnmstugP0ONTGA3bVW/4Sf3XVOIEoWnSjhpzAuXPRWPN9hmG
   0CA0HNcunfYU7VyzwdMGdYs9n66EXnTTFeh9Ui3nHNDC2x04+pDo+5qAg
   HVSxkHaF/ORVkW4vwLYwvFmfRgXeVtdfEYjpO7Nvookd4Gwjwwf9qQsks
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363723884"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363723884"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814249794"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="814249794"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 08:20:11 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgRez-0000E4-0J;
        Wed, 13 Sep 2023 15:20:09 +0000
Date:   Wed, 13 Sep 2023 23:19:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/5] gpiolib: provide gpiod_set_active_[low/high]()
Message-ID: <202309132304.Uw3cYH9C-lkp@intel.com>
References: <20230913115001.23183-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913115001.23183-2-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on mtd/nand/next linus/master ulf-hansson-mmc-mirror/next v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpiolib-provide-gpiod_set_active_-low-high/20230913-195053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230913115001.23183-2-brgl%40bgdev.pl
patch subject: [PATCH 1/5] gpiolib: provide gpiod_set_active_[low/high]()
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20230913/202309132304.Uw3cYH9C-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309132304.Uw3cYH9C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309132304.Uw3cYH9C-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/nvmem-provider.h:15,
                    from include/linux/rtc.h:18,
                    from include/linux/efi.h:20,
                    from block/partitions/efi.h:19,
                    from block/partitions/msdos.c:32:
>> include/linux/gpio/consumer.h:505:1: error: expected ';', ',' or ')' before '{' token
     505 | {
         | ^


vim +505 include/linux/gpio/consumer.h

   503	
   504	static inline void gpiod_set_active_low(struct gpio_desc *desc
 > 505	{
   506		/* GPIO can never have been requested */
   507		WARN_ON(desc);
   508	}
   509	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
