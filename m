Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071FA803620
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjLDOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:12:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A788AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701699178; x=1733235178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HFdzMqrzwqNZHvZ+q8qF6HBIGZqzbdaSOeOSLhTPCN4=;
  b=eLJxvH3K5SqO7/Jt5f3tLSFYgNlvfSSNLeJG1Rg8MsB6JAUirvDnSFG0
   lQukD95sInFdyXXiR6DX6k119J4pN8IyyOw+st4uW0A2dy23/gFeqQpAR
   DqktijTEl/7D3sxsliuSpOQd7t5sKlG7D/5X/Ry4PhjR6NTJZenZTJ41/
   EwuWRU2V6UhEdbRT7rzbbK8ICpsF5xdiSDIYEehjGsqWPUWLCIXREr+PH
   V46OZ0AsGPOG37jaCRaHvZL2FLHkgYbepDHL2nRVSK9R0Vufw46pDDNT9
   cK5SBVmWeaNp3KYR7B7dTqte9Slhe0bi+ys2xjTRQBuhulzhGdwOvnVrM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458059588"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="458059588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 06:12:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888540358"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="888540358"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2023 06:12:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA9gr-0007na-1l;
        Mon, 04 Dec 2023 14:12:53 +0000
Date:   Mon, 4 Dec 2023 22:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/spi/spi-lp8841-rtc.c:112:17: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312042226.NQmCRdOG-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 years, 3 months ago
config: sh-randconfig-r133-20231118 (https://download.01.org/0day-ci/archive/20231204/202312042226.NQmCRdOG-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312042226.NQmCRdOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312042226.NQmCRdOG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-lp8841-rtc.c:112:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iomem @@     got void [noderef] __iomem * @@
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     expected void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem

vim +112 drivers/spi/spi-lp8841-rtc.c

7ecbfff6711fb3 Sergei Ianovich 2016-02-23   97  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   98  static int
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   99  spi_lp8841_rtc_transfer_one(struct spi_master *master,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  100  			    struct spi_device *spi,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  101  			    struct spi_transfer *t)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  102  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  103  	struct spi_lp8841_rtc	*data = spi_master_get_devdata(master);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  104  	unsigned		count = t->len;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  105  	const u8		*tx = t->tx_buf;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  106  	u8			*rx = t->rx_buf;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  107  	u8			word = 0;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  108  	int			ret = 0;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  109  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  110  	if (tx) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  111  		data->state &= ~SPI_LP8841_RTC_nWE;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23 @112  		writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  113  		while (likely(count > 0)) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  114  			word = *tx++;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  115  			bitbang_txrx_be_cpha0_lsb(data, 1, 0,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  116  					SPI_MASTER_NO_RX, word, 8);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  117  			count--;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  118  		}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  119  	} else if (rx) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  120  		data->state |= SPI_LP8841_RTC_nWE;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  121  		writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  122  		while (likely(count > 0)) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  123  			word = bitbang_txrx_be_cpha0_lsb(data, 1, 0,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  124  					SPI_MASTER_NO_TX, word, 8);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  125  			*rx++ = word;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  126  			count--;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  127  		}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  128  	} else {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  129  		ret = -EINVAL;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  130  	}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  131  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  132  	spi_finalize_current_transfer(master);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  133  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  134  	return ret;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  135  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  136  

:::::: The code at line 112 was first introduced by commit
:::::: 7ecbfff6711fb331591003ac32c002ce55a0758f spi: master driver to enable RTC on ICPDAS LP-8841

:::::: TO: Sergei Ianovich <ynvich@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
