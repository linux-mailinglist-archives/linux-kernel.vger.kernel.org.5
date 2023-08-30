Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6378DB05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjH3SiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbjH3HlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:41:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE99CD8;
        Wed, 30 Aug 2023 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693381275; x=1724917275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5QX2utJhe//XqFa+InE4SbM4WETASb0Mj1a/b7o6gis=;
  b=WJZ0IRXEaCGWgVGa2IhnGePCEisRvfIESnVkuNk1nci12CA1ZrJgURPf
   bQoFWEKegR2jUecFjiRWvijICHaLNyc2pWK63S1w6FTmCe4gcds9zTKCn
   M+XgQZC79pZ0nPEbbWvg1tESVbM6ueeUoE8+fFbeD/t2xS5F9qxMvrPtv
   lN0ypp62XslYUGC2BO01HyrWp3YFRe3x9vEmiZn/J5ZSB6kv++UOBJq3g
   QBP0W9rNy7A2w8o6YeJOcQORmnf8t7WeSlK+RGHf6AQDZfMlrhSI5MRGJ
   3/dvYrZvyiAoEAdNmippkxkvkpUHYr8XOlRiltSTqwBxQu3Wg7/Ff8FH5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374479606"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="374479606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069745573"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="1069745573"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 00:40:37 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbFoa-0009Zd-0z;
        Wed, 30 Aug 2023 07:40:36 +0000
Date:   Wed, 30 Aug 2023 15:40:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        william.gray@linaro.org, lee@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] counter: stm32-timer-cnt: add support for events
Message-ID: <202308301541.ZqWpJdto-lkp@intel.com>
References: <20230829134029.2402868-9-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829134029.2402868-9-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrice-Gasnier/counter-chrdev-fix-getting-array-extensions/20230829-230111
base:   linus/master
patch link:    https://lore.kernel.org/r/20230829134029.2402868-9-fabrice.gasnier%40foss.st.com
patch subject: [PATCH 8/8] counter: stm32-timer-cnt: add support for events
config: arm-randconfig-001-20230830 (https://download.01.org/0day-ci/archive/20230830/202308301541.ZqWpJdto-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308301541.ZqWpJdto-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308301541.ZqWpJdto-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/counter/stm32-timer-cnt.c:528:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     528 |         case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
         |         ^
   drivers/counter/stm32-timer-cnt.c:528:2: note: insert '__attribute__((fallthrough));' to silence this warning
     528 |         case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/counter/stm32-timer-cnt.c:528:2: note: insert 'break;' to avoid fall-through
     528 |         case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
         |         ^
         |         break; 
   1 warning generated.


vim +528 drivers/counter/stm32-timer-cnt.c

   516	
   517	static int stm32_count_watch_validate(struct counter_device *counter,
   518					      const struct counter_watch *watch)
   519	{
   520		struct stm32_timer_cnt *const priv = counter_priv(counter);
   521	
   522		switch (watch->event) {
   523		case COUNTER_EVENT_CAPTURE:
   524			if (watch->channel >= priv->nchannels) {
   525				dev_err(counter->parent, "Invalid channel %d\n", watch->channel);
   526				return -EINVAL;
   527			}
 > 528		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
   529			return 0;
   530		default:
   531			return -EINVAL;
   532		}
   533	}
   534	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
