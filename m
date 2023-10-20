Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B097D0F56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377362AbjJTMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377346AbjJTMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:03:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B19E;
        Fri, 20 Oct 2023 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697803391; x=1729339391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0cCePIIEGKptYoyh7Pp+IV6nY/vFaOdAf4qBUS5Nws=;
  b=oEREyZY7TT0rSKTajf4gbz050HzsGx2dXVkc6Ens+kWtvdk0HD8iu+a1
   XqSpS5GXdpuKAd9Q2c8LLy162ZmlatQWpmjX1nXSFy6u12wUuTTvwHggT
   04DRMQCs3td3OAxmWbfJwS9BYHJdXeUGYMzo5zzTeU9+NwMiDJF0Ded3J
   urmw8KdVYe9zLDDNHdwxiZQPSqLXh2Z+HhEZEXBW73F+Jmf98CjE+B5oR
   T49fxsTPtH6vEshn4a2as5wo0TXM/vxEtMKGWzctThXxxk11GUmW7xiQd
   uQJEYa4mC9SYCxi4yrtw66uklmNJhKg6fcaFZWswYMW2zSbMc5QpjDspd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452962009"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452962009"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="901123585"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="901123585"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2023 05:00:58 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtoDZ-0003Uk-22;
        Fri, 20 Oct 2023 12:03:05 +0000
Date:   Fri, 20 Oct 2023 20:02:20 +0800
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
Message-ID: <202310201933.9lZn2Ebl-lkp@intel.com>
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018211111.3437929-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/tty-i3c-add-tty-over-i3c-master-support/20231019-051407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231018211111.3437929-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] tty: i3c: add tty over i3c master support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310201933.9lZn2Ebl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310201933.9lZn2Ebl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310201933.9lZn2Ebl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/i3c_tty.c: In function 'tty_i3c_rxwork':
   drivers/tty/i3c_tty.c:265:26: error: 'struct i3c_priv_xfer' has no member named 'actual_len'
     265 |                 if (xfers.actual_len) {
         |                          ^
   drivers/tty/i3c_tty.c:266:82: error: 'struct i3c_priv_xfer' has no member named 'actual_len'
     266 |                         tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);
         |                                                                                  ^
   drivers/tty/i3c_tty.c:271:25: error: implicit declaration of function 'i3c_device_getstatus_format1' [-Werror=implicit-function-declaration]
     271 |                         i3c_device_getstatus_format1(sport->i3cdev, &status);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/i3c_tty.c: At top level:
>> drivers/tty/i3c_tty.c:400:6: warning: no previous prototype for 'i3c_remove' [-Wmissing-prototypes]
     400 | void i3c_remove(struct i3c_device *dev)
         |      ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/i3c_remove +400 drivers/tty/i3c_tty.c

   399	
 > 400	void i3c_remove(struct i3c_device *dev)
   401	{
   402		struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
   403	
   404		tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
   405		cancel_work_sync(&sport->txwork);
   406		destroy_workqueue(sport->workqueue);
   407	}
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
