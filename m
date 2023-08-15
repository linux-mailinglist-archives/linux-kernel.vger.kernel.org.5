Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3D77CA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjHOJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjHOJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:24:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609B10C;
        Tue, 15 Aug 2023 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692091456; x=1723627456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHYmmUR9H8aOJ0rR/sOs0OfTQXjNoR+u5wDRCiFmfsg=;
  b=XObfUcKHkVVWtUB1LzalsA0gIxLgAr+2WGkRzxZt/XacrmSriIaUfxNf
   RckB/oacQP9+anhsN1SRC+ENT/EH4O3wD8X3JviljHwZ5G8V2wXdizwxJ
   UiviEgzRfioRFZ5HG1fpsAEIltNCsFYPGQRVY9cAufwVgQYTd9uhnLJib
   pjWh9dWJuaj1YS5rLSgQg1s7WqNtwo2QF1xFA3ltr2FCvyU5shMpIjRJN
   bUKc63PpnpcYTSIlGKnZbU2xxQQOvoVswKPmDqtJ/YELS0UzuHMi1LlV8
   v4d099eA4bIYfP80rS6i9nFBQJFk1L4dqWCId0Km0Ktcur+URwRvddCdC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="458593537"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="458593537"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857387241"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="857387241"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2023 02:24:12 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVqHc-0000pP-0p;
        Tue, 15 Aug 2023 09:24:12 +0000
Date:   Tue, 15 Aug 2023 17:24:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: consumer: new virtual driver
Message-ID: <202308151712.RsWvOB3C-lkp@intel.com>
References: <20230812190359.5875-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812190359.5875-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-consumer-new-virtual-driver/20230813-030518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230812190359.5875-1-brgl%40bgdev.pl
patch subject: [PATCH v4] gpio: consumer: new virtual driver
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151712.RsWvOB3C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151712.RsWvOB3C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/gpio/gpio-consumer.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
