Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302EF810806
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378269AbjLMCPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378226AbjLMCO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:14:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51EFAF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433705; x=1733969705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R3wPK74lI3isRxG8q1/3e0bayBSEhIqQESBOeWOeJcg=;
  b=f93cWWmucO+fpgvYiJfYfeqViIVbcRupJDapRJpGjIV7YSLE5OJQd/HW
   m+2mAe6AaFg+qXbnAoC2RejoUXTsnCgPh21++gWDPO+ohXQeFcSuiKlFY
   pd984ZLi6VyA7SnTTQ0nU2uBYZkk0dJsj3aBYJFAZBX++wlU1fZ++Idvr
   8IWNmE0JVOfpDcphWTd+BmDk1RlpyEL8pO9x/UOC51gw8i9u3VP10GwLB
   4zdT00TSBvHPjtte6Ewe6K1kOqGTmn+xc49otp3sNFxL/jEbsL20AQev7
   UotPacvfKgsNIK0T1ZqqX9xqC0YHD3p8TMvtHarL69FVxNp94Q+f0OS5j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1746348"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1746348"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897156722"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="897156722"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 18:15:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDElx-000K0F-2c;
        Wed, 13 Dec 2023 02:14:54 +0000
Date:   Wed, 13 Dec 2023 10:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312131026.UI2RWnbl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf52eed70e555e864120cfaf280e979e2a035c66
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   3 years, 4 months ago
config: i386-randconfig-061-20231101 (https://download.01.org/0day-ci/archive/20231213/202312131026.UI2RWnbl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131026.UI2RWnbl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131026.UI2RWnbl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
>> drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
   drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:130:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:130:42: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:130:42: sparse:     got void *
   drivers/uio/uio_aec.c:131:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:131:43: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:131:43: sparse:     got void *
   drivers/uio/uio_aec.c:133:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/uio/uio_aec.c:133:28: sparse:     expected void const [noderef] __iomem *
   drivers/uio/uio_aec.c:133:28: sparse:     got void *
   drivers/uio/uio_aec.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *priv @@
   drivers/uio/uio_aec.c:138:21: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:138:21: sparse:     got void *priv

vim +50 drivers/uio/uio_aec.c

1bafeb378e915f Brandon Philips 2009-01-27  41  
1bafeb378e915f Brandon Philips 2009-01-27  42  static irqreturn_t aectc_irq(int irq, struct uio_info *dev_info)
1bafeb378e915f Brandon Philips 2009-01-27  43  {
1bafeb378e915f Brandon Philips 2009-01-27  44  	void __iomem *int_flag = dev_info->priv + INTA_DRVR_ADDR;
1bafeb378e915f Brandon Philips 2009-01-27  45  	unsigned char status = ioread8(int_flag);
1bafeb378e915f Brandon Philips 2009-01-27  46  
1bafeb378e915f Brandon Philips 2009-01-27  47  
1bafeb378e915f Brandon Philips 2009-01-27  48  	if ((status & INTA_ENABLED_FLAG) && (status & INTA_FLAG)) {
1bafeb378e915f Brandon Philips 2009-01-27  49  		/* application writes 0x00 to 0x2F to get next interrupt */
1bafeb378e915f Brandon Philips 2009-01-27 @50  		status = ioread8(dev_info->priv + MAILBOX);
1bafeb378e915f Brandon Philips 2009-01-27  51  		return IRQ_HANDLED;
1bafeb378e915f Brandon Philips 2009-01-27  52  	}
1bafeb378e915f Brandon Philips 2009-01-27  53  
1bafeb378e915f Brandon Philips 2009-01-27  54  	return IRQ_NONE;
1bafeb378e915f Brandon Philips 2009-01-27  55  }
1bafeb378e915f Brandon Philips 2009-01-27  56  

:::::: The code at line 50 was first introduced by commit
:::::: 1bafeb378e915f39b1bf44ee0871823d6f402ea5 uio: add the uio_aec driver

:::::: TO: Brandon Philips <brandon@ifup.org>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
