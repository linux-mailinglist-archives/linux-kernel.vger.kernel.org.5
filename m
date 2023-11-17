Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9E7EFBFD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbjKQXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbjKQXDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:03:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCED75
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700262210; x=1731798210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XCnGx03/DyrJDe1LWGEXv7UDgbMq4ECQ+rRhQMq61k=;
  b=B2Y/xK2jJT6PLSHG7VRQLqa8DfM2AI+GsibE6OGNwtqyDmB6Z0ApogaX
   Xj86svc+Z6icdp8zI3LND2ekt0GEbWqzHxOh6BYqoeF7SOGpMCOcgQtn9
   iscPCEokUxMi7d3WWZwLkkswlBpsQuoT4n6SzgItid5lD1XN5Hxd6F80s
   paTX/CvFLqsUV7ZYZH0kBupb+s2YbKhtbCDG/AQ23PE4If62xNG4pJ+3I
   FS0k1HD080NINcDCJYcGuAEyLYM1Gk2+BSPcHL+Q+/5bAu3Gy6R6fsoze
   ijmch+EqwDJYuiQwaCmNzJ1DjEZg7Jq1JRm98UsIABrkTiQMNMVWtOjL+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="477597421"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="477597421"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 15:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889384114"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889384114"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2023 15:03:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r47rr-0003GP-2g;
        Fri, 17 Nov 2023 23:03:19 +0000
Date:   Sat, 18 Nov 2023 07:03:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, andriy.shevchenko@linux.intel.com,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] mtd:nand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <202311180630.FuB77L6v-lkp@intel.com>
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113131634.614467-1-debug.penguin32@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ronald-Monthero/mtd-nand-Increment-IFC_TIMEOUT_MSECS-for-nand-controller-response/20231113-212730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20231113131634.614467-1-debug.penguin32%40gmail.com
patch subject: [PATCH] mtd:nand: Increment IFC_TIMEOUT_MSECS for nand controller response
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231118/202311180630.FuB77L6v-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180630.FuB77L6v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180630.FuB77L6v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mtd/nand/raw/nand_base.c:40:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/mtd/nand/raw/nand_base.c:40:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/mtd/nand/raw/nand_base.c:40:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/mtd/nand/raw/nand_base.c:368:4: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
     368 |                 pr_info("nand_chip->options indicates NAND_BROKEN_XD %d\n",
         |                                                                      ~~
         |                                                                      %lu
     369 |                         (chip->options & NAND_BROKEN_XD));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:528:34: note: expanded from macro 'pr_info'
     528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   7 warnings generated.


vim +368 drivers/mtd/nand/raw/nand_base.c

   352	
   353	/**
   354	 * nand_check_wp - [GENERIC] check if the chip is write protected
   355	 * @chip: NAND chip object
   356	 *
   357	 * Check, if the device is write protected. The function expects, that the
   358	 * device is already selected.
   359	 */
   360	static int nand_check_wp(struct nand_chip *chip)
   361	{
   362		u8 status;
   363		int ret;
   364	
   365		/* Broken xD cards report WP despite being writable */
   366		if (chip->options & NAND_BROKEN_XD) {
   367			pr_info("nand_chip->options indicates NAND_BROKEN_XD %d\n",
 > 368				(chip->options & NAND_BROKEN_XD));
   369			return 0;
   370		}
   371	
   372		/* Check the WP bit */
   373		ret = nand_status_op(chip, &status);
   374		if (ret)
   375			return ret;
   376	
   377		return status & NAND_STATUS_WP ? 0 : 1;
   378	}
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
