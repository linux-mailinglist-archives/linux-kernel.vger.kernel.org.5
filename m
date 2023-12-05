Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328280611B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbjLEV4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:56:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C44C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701813415; x=1733349415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P686fvsMqjcZ08N/dNNsQ9HlTRKppMPrmcB94hY4uCs=;
  b=L3NX44/HbOlI78eSK541J7Qty42wb5mdZo2T94Oto3XA74sOgUnRm6aA
   GWWfzICnjjlIOTsyj23UL9b/8EFwrFnU/I5DqKMaspmPchZGwS9XwSPme
   8F1F87q5RwEZuQV5BPQel1CrG6t+5w7gGR/5vadyJaV/7Bk01UyBYiPik
   oafpar3dyJy0JS7G8bq422G6CHxr5Z4KPqVh50cOfhiwbaA1aeciUhP+M
   x55RH3oG+F/k3pC6fvpbayTWvSc4BbKSQS69iq9snh0ZGlk8wAwnr0qH0
   vr2TR6nZRkGzYIgxaqYmBTAKobdJ7UPLPl6AT8+9ez4b7JrXUnqZQEY2d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393697568"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393697568"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889087070"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="889087070"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 13:56:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAdPP-0009mM-2t;
        Tue, 05 Dec 2023 21:56:51 +0000
Date:   Wed, 6 Dec 2023 05:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/watchdog/ath79_wdt.c:161:37: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312060528.63wKEM3f-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 25fd529c34d063d1bef23742f2e8f8341c639dc3 sparse: group the defines by functionality
date:   3 years, 4 months ago
config: arm-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231206/202312060528.63wKEM3f-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060528.63wKEM3f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060528.63wKEM3f-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/ath79_wdt.c:161:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const * @@
   drivers/watchdog/ath79_wdt.c:161:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/ath79_wdt.c:161:37: sparse:     got char const *
   drivers/watchdog/ath79_wdt.c:235:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ath79_wdt.c:235:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ath79_wdt.c:235:27: sparse:     got int ( * )( ... )

vim +161 drivers/watchdog/ath79_wdt.c

f8394f61c66f48 Gabor Juhos 2011-01-04  148  
f8394f61c66f48 Gabor Juhos 2011-01-04  149  static ssize_t ath79_wdt_write(struct file *file, const char *data,
f8394f61c66f48 Gabor Juhos 2011-01-04  150  				size_t len, loff_t *ppos)
f8394f61c66f48 Gabor Juhos 2011-01-04  151  {
f8394f61c66f48 Gabor Juhos 2011-01-04  152  	if (len) {
f8394f61c66f48 Gabor Juhos 2011-01-04  153  		if (!nowayout) {
f8394f61c66f48 Gabor Juhos 2011-01-04  154  			size_t i;
f8394f61c66f48 Gabor Juhos 2011-01-04  155  
f8394f61c66f48 Gabor Juhos 2011-01-04  156  			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
f8394f61c66f48 Gabor Juhos 2011-01-04  157  
f8394f61c66f48 Gabor Juhos 2011-01-04  158  			for (i = 0; i != len; i++) {
f8394f61c66f48 Gabor Juhos 2011-01-04  159  				char c;
f8394f61c66f48 Gabor Juhos 2011-01-04  160  
f8394f61c66f48 Gabor Juhos 2011-01-04 @161  				if (get_user(c, data + i))
f8394f61c66f48 Gabor Juhos 2011-01-04  162  					return -EFAULT;
f8394f61c66f48 Gabor Juhos 2011-01-04  163  
f8394f61c66f48 Gabor Juhos 2011-01-04  164  				if (c == 'V')
f8394f61c66f48 Gabor Juhos 2011-01-04  165  					set_bit(WDT_FLAGS_EXPECT_CLOSE,
f8394f61c66f48 Gabor Juhos 2011-01-04  166  						&wdt_flags);
f8394f61c66f48 Gabor Juhos 2011-01-04  167  			}
f8394f61c66f48 Gabor Juhos 2011-01-04  168  		}
f8394f61c66f48 Gabor Juhos 2011-01-04  169  
f8394f61c66f48 Gabor Juhos 2011-01-04  170  		ath79_wdt_keepalive();
f8394f61c66f48 Gabor Juhos 2011-01-04  171  	}
f8394f61c66f48 Gabor Juhos 2011-01-04  172  
f8394f61c66f48 Gabor Juhos 2011-01-04  173  	return len;
f8394f61c66f48 Gabor Juhos 2011-01-04  174  }
f8394f61c66f48 Gabor Juhos 2011-01-04  175  

:::::: The code at line 161 was first introduced by commit
:::::: f8394f61c66f48b1fe9d6964ddce492d7f9a4cd9 watchdog: add driver for the Atheros AR71XX/AR724X/AR913X SoCs

:::::: TO: Gabor Juhos <juhosg@openwrt.org>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
