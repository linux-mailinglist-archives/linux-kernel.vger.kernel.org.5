Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD97B991F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbjJEAJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244055AbjJEAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:09:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EC95;
        Wed,  4 Oct 2023 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696464585; x=1728000585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vD9VEolBkptu3ld3JXFL+7vX77/UDE2BMoEaEvzGOjk=;
  b=cbrtMiQalejOiuXysqp7G2hc5/BesTnJ1JLcLd3TuAHGU4ZuA2SM/app
   +TIh33WOIpKYIU7Obw9TCPaVpnbTyppnZ2EXIgW4W+NCk/+ccFCBLulKH
   bwnzvmRmC1E+VnQEJD4DojP2/1MCerk5DfsCNZHDCxK/vhmC7o89v9RRA
   lkHwqnubIRQOvAHNr4nHO9bFRevCIp9iiL7kjrg49kBft6CLDjqGjwYx1
   BM0rsVw2y76sUzWR6537S7oTr6GxFweiJyI0h01r+qX0A+xRSt93sVhi8
   XVpXMWXQS4jr9hR7BcdTNZfSp+ONPbXvlhh/GXdiNXcXSGk12ffrfCrBv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383252183"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383252183"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 17:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875327203"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="875327203"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2023 17:09:39 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoBvf-000Kn6-0S;
        Thu, 05 Oct 2023 00:09:36 +0000
Date:   Thu, 5 Oct 2023 08:08:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 10/11] MIPS: generic: Add support for Mobileye EyeQ5
Message-ID: <202310050726.GDpZbMDO-lkp@intel.com>
References: <20231004161038.2818327-11-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161038.2818327-11-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on lee-mfd/for-mfd-next linus/master v6.6-rc4 next-20231004]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-CLEMENT/MIPS-compressed-Use-correct-instruction-for-64-bit-code/20231005-001314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231004161038.2818327-11-gregory.clement%40bootlin.com
patch subject: [PATCH 10/11] MIPS: generic: Add support for Mobileye EyeQ5
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231005/202310050726.GDpZbMDO-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050726.GDpZbMDO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050726.GDpZbMDO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/amba-pl011.c: In function 'pl011_sgbuf_init':
>> drivers/tty/serial/amba-pl011.c:380:30: error: implicit declaration of function 'phys_to_page'; did you mean 'pfn_to_page'? [-Werror=implicit-function-declaration]
     380 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
         |                              ^~~~~~~~~~~~
         |                              pfn_to_page
>> drivers/tty/serial/amba-pl011.c:380:30: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
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
