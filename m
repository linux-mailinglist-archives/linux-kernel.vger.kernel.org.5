Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB727C6257
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJLBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJLBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:39:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199BBA9;
        Wed, 11 Oct 2023 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697074744; x=1728610744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=daGpMUfIbIbWopl8m0PHMFSs1YcPe9sCdDhFyZyEnPU=;
  b=i1uZCB1v4/35BoZoZNvqmJT/xXrgbcMlMhH64siA79aZHuXwI/4LoZ89
   qHERXZkK84FdjlkhUnjI28+gXzdch6HBOgRZKJD3wajA71k4tXpdYUlue
   bki9v3x2XWbq63RsHpImeasQlMSk6qnLKeXqRVo0HJTHtIVZ5g/zI8suK
   UuKmfEnuSo35Red0xgLCf54Jj8zomqqTSUvVIIeLM7TqeY381MK45ztNi
   vlxZhadsapF1niZ3VKCrmGX15j3imAO957viSUZwj/fGbrqmM7h4/jwqB
   awkLfR9Hvoc7eAQtFa7oSlQ947mhsDAtKcsjb4gjnuNiVmfIJl38Mq3cf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384663184"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="384663184"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 18:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="877925198"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="877925198"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 18:38:59 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqkfA-0002yj-1u;
        Thu, 12 Oct 2023 01:38:56 +0000
Date:   Thu, 12 Oct 2023 09:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/2] amba: bus: Enable compile testing
Message-ID: <202310120929.APpnCpDs-lkp@intel.com>
References: <20231006145732.3419115-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006145732.3419115-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.6-rc5 next-20231011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/amba-bus-Enable-compile-testing/20231006-225814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231006145732.3419115-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v3 2/2] amba: bus: Enable compile testing
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231012/202310120929.APpnCpDs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310120929.APpnCpDs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310120929.APpnCpDs-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/amba-pl011.c: In function 'pl011_sgbuf_init':
>> drivers/tty/serial/amba-pl011.c:380:30: error: implicit declaration of function 'phys_to_page'; did you mean 'pfn_to_page'? [-Werror=implicit-function-declaration]
     380 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
         |                              ^~~~~~~~~~~~
         |                              pfn_to_page
   drivers/tty/serial/amba-pl011.c:380:30: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     380 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
         |                              ^~~~~~~~~~~~~~~~~~~~~~
         |                              |
         |                              int
   In file included from include/linux/kfifo.h:42,
                    from include/linux/tty_port.h:5,
                    from include/linux/tty.h:12,
                    from drivers/tty/serial/amba-pl011.c:26:
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +380 drivers/tty/serial/amba-pl011.c

68b65f7305e54b drivers/serial/amba-pl011.c     Russell King   2010-12-22  368  
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  369  static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  370  	enum dma_data_direction dir)
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  371  {
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  372  	dma_addr_t dma_addr;
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  373  
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  374  	sg->buf = dma_alloc_coherent(chan->device->dev,
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  375  		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  376  	if (!sg->buf)
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  377  		return -ENOMEM;
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  378  
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  379  	sg_init_table(&sg->sg, 1);
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27 @380  	sg_set_page(&sg->sg, phys_to_page(dma_addr),
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  381  		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
cb06ff102e2d79 drivers/tty/serial/amba-pl011.c Chanho Min     2013-03-27  382  	sg_dma_address(&sg->sg) = dma_addr;
c64be9231e0893 drivers/tty/serial/amba-pl011.c Andrew Jackson 2014-11-07  383  	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  384  
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  385  	return 0;
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  386  }
ead76f329f777c drivers/tty/serial/amba-pl011.c Linus Walleij  2011-02-24  387  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
