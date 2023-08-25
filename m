Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D79787F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjHYF0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjHYF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:26:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C31BE2;
        Thu, 24 Aug 2023 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692941160; x=1724477160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VeiQSmyWECcHa26Vjd2sYnyrxqrZYUQfB/LEIP7n220=;
  b=Qqp2OZpD5pYGeOEW3x69nt7p11tp1rI9AjlOSYc1src2LynBwZs/UHdu
   ooHH0hOaSJWPS0lN+Td4B05IDzMI8+PFZf9nQo6PAhORdAyGpLtZBx2Hy
   HOVx1qCupUlPVf9LzenEHQQkX8H7m8JiBEC8mRySpu7SPrd08Idw+l3iF
   Kr+talnOBJN0n+/ItouAZU5ZwUDBYo5zcwBpkdDE6CvjGzPPxyH3CMzdC
   luxSewQlAdNk/iOj36YAq7Qx+butOnzhj/Fcw5TsluQJNzANWnF3POMt5
   7PSVWE30ZOjfv55B5lnV03Be1apjtHSEULtJpZVR6ktafXn4ZAe6NaN/E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440978237"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440978237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 22:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881045209"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 22:26:01 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZPKV-0003Ek-2B;
        Fri, 25 Aug 2023 05:25:55 +0000
Date:   Fri, 25 Aug 2023 13:25:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>, Linhua Xu <Linhua.Xu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 1/6] pinctrl: sprd: Modify the probe function parameters
Message-ID: <202308251318.Xng4apdW-lkp@intel.com>
References: <20230825031826.31599-2-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-2-Linhua.xu@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linhua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.5-rc7 next-20230824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linhua-Xu/pinctrl-sprd-Modify-the-probe-function-parameters/20230825-113950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230825031826.31599-2-Linhua.xu%40unisoc.com
patch subject: [PATCH 1/6] pinctrl: sprd: Modify the probe function parameters
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230825/202308251318.Xng4apdW-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251318.Xng4apdW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251318.Xng4apdW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/sprd/pinctrl-sprd.c:156: warning: Function parameter or member 'common_pin_offset' not described in 'sprd_pinctrl'
>> drivers/pinctrl/sprd/pinctrl-sprd.c:156: warning: Function parameter or member 'misc_pin_offset' not described in 'sprd_pinctrl'


vim +156 drivers/pinctrl/sprd/pinctrl-sprd.c

41d32cfce1ae61 Baolin Wang 2017-08-17  141  
41d32cfce1ae61 Baolin Wang 2017-08-17  142  /**
41d32cfce1ae61 Baolin Wang 2017-08-17  143   * struct sprd_pinctrl: represent the pin controller device
41d32cfce1ae61 Baolin Wang 2017-08-17  144   * @dev: pointer to the device structure
41d32cfce1ae61 Baolin Wang 2017-08-17  145   * @pctl: pointer to the pinctrl handle
41d32cfce1ae61 Baolin Wang 2017-08-17  146   * @base: base address of the controller
41d32cfce1ae61 Baolin Wang 2017-08-17  147   * @info: pointer to SoC's pins description information
41d32cfce1ae61 Baolin Wang 2017-08-17  148   */
41d32cfce1ae61 Baolin Wang 2017-08-17  149  struct sprd_pinctrl {
41d32cfce1ae61 Baolin Wang 2017-08-17  150  	struct device *dev;
41d32cfce1ae61 Baolin Wang 2017-08-17  151  	struct pinctrl_dev *pctl;
41d32cfce1ae61 Baolin Wang 2017-08-17  152  	void __iomem *base;
41d32cfce1ae61 Baolin Wang 2017-08-17  153  	struct sprd_pinctrl_soc_info *info;
435130f487a5b7 Linhua Xu   2023-08-25  154  	u32 common_pin_offset;
435130f487a5b7 Linhua Xu   2023-08-25  155  	u32 misc_pin_offset;
41d32cfce1ae61 Baolin Wang 2017-08-17 @156  };
41d32cfce1ae61 Baolin Wang 2017-08-17  157  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
