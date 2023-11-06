Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAF7E2E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjKFUYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:24:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8ABD71;
        Mon,  6 Nov 2023 12:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699302250; x=1730838250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUQJarH/crV1JopZJb9YSb1wHfMu7JhiXQvXe0faobI=;
  b=dXk2ebsKvvNWPDE301Pv9Ge5nX9Umy4WaHt6++1CVS6ZC9K4i1TgdqzC
   cix6COZk0k8mbcqcCpgtSlJCnxbAW1gTreLIy5S3w9mjU8wipWNHL41IU
   QmHMQDdfPSUCen56wzLXX/GzG3PaGTE1Y5vRWTlLXlhxfsT0QT591SSex
   SUb+3QiHlxyDB7b/oJOfWvclUfSa8dbSPRZbLT3lw/7yhE/BtDvRdfwad
   +rt6nIZSSkAewZOcisYewFh9OmyOe4VWY9t7WCnbvTTpjfyDYSSROE6Dz
   qlWaFtWPYiZ80SnoWELdZOy8BFs6lUWHbTNAkdoqASyWn/lAeeYPEeGcy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453670644"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="453670644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="797421965"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="797421965"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2023 12:24:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r068i-0006i4-0B;
        Mon, 06 Nov 2023 20:24:04 +0000
Date:   Tue, 7 Nov 2023 04:22:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" 
        <linux-serial@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/1] tty: i3c: add tty over i3c master support
Message-ID: <202311070330.5mylauLR-lkp@intel.com>
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018211111.3437929-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.6 next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/tty-i3c-add-tty-over-i3c-master-support/20231019-051407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231018211111.3437929-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] tty: i3c: add tty over i3c master support
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20231107/202311070330.5mylauLR-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070330.5mylauLR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070330.5mylauLR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/i3c_tty.c: In function 'tty_i3c_rxwork':
>> drivers/tty/i3c_tty.c:265:26: error: 'struct i3c_priv_xfer' has no member named 'actual_len'
     265 |                 if (xfers.actual_len) {
         |                          ^
   drivers/tty/i3c_tty.c:266:82: error: 'struct i3c_priv_xfer' has no member named 'actual_len'
     266 |                         tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);
         |                                                                                  ^
>> drivers/tty/i3c_tty.c:271:25: error: implicit declaration of function 'i3c_device_getstatus_format1' [-Werror=implicit-function-declaration]
     271 |                         i3c_device_getstatus_format1(sport->i3cdev, &status);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/i3c_tty.c: At top level:
   drivers/tty/i3c_tty.c:400:6: warning: no previous prototype for 'i3c_remove' [-Wmissing-prototypes]
     400 | void i3c_remove(struct i3c_device *dev)
         |      ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +265 drivers/tty/i3c_tty.c

   246	
   247	static void tty_i3c_rxwork(struct work_struct *work)
   248	{
   249		struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
   250		struct i3c_priv_xfer xfers;
   251		int retry = I3C_TTY_RETRY;
   252		u16 status = BIT(0);
   253	
   254		do {
   255			memset(&xfers, 0, sizeof(xfers));
   256			xfers.data.in = sport->buffer;
   257			xfers.len = I3C_TTY_TRANS_SIZE;
   258			xfers.rnw = 1;
   259	
   260			if (I3C_TTY_RX_STOP & atomic_read(&sport->status))
   261				break;
   262	
   263			i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
   264	
 > 265			if (xfers.actual_len) {
   266				tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);
   267				retry = 20;
   268				continue;
   269			} else {
   270				status = BIT(0);
 > 271				i3c_device_getstatus_format1(sport->i3cdev, &status);
   272				/*
   273				 * Target side need some time to fill data into fifo. Target side may not
   274				 * have hardware update status in real time. Software update status always
   275				 * need some delays.
   276				 *
   277				 * Generally, target side have cicular buffer in memory, it will be moved
   278				 * into FIFO by CPU or DMA. 'status' just show if cicular buffer empty. But
   279				 * there are gap, espcially CPU have not response irq to fill FIFO in time.
   280				 * So xfers.actual will be zero, wait for little time to avoid flood
   281				 * transfer in i3c bus.
   282				 */
   283				usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
   284				retry--;
   285			}
   286	
   287		} while (retry && (status & BIT(0)));
   288	
   289		tty_flip_buffer_push(&sport->port);
   290	}
   291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
