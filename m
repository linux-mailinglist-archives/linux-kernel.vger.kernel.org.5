Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB692759D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGSSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGSSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:04:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8D1FC1;
        Wed, 19 Jul 2023 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689789857; x=1721325857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k0ST5eRJQGf1AMKFy/YtWddswHjc7qS0Az8Lzm+dNQw=;
  b=GFkVzdVNQa8XFb3mq042BiowUzD46mxdMrGz9vBvvha51he3zeiHnZTJ
   xbW+G6oJ7UxUdbb2KPDgww/0mI0iQQtufZfx4Q0+7lErFEm8qlVzgb/fF
   jB9GoKa9kcixqVkeuqmoMb1noMs6SShx1fMeHDwzIV0S/l7NUEQflBkkn
   XTeYNEgd8mlsfPeV4pwbzwXU6mvgWh3h2idSnpGDMMIjs8MlfxfaV8si3
   aVBphyzTbyx0IpdAVPL4Cq0eiqIvgTq9dMFkGaKcO6DH0UWzXOI6RUWo4
   +oMKTDHCngYFJl/iNT/c6rOndcprR4go/EZo/iEZsF3aBTselTXlDzcVz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="366577142"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="366577142"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794136515"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794136515"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 11:04:13 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMBX2-0005MD-0F;
        Wed, 19 Jul 2023 18:04:12 +0000
Date:   Thu, 20 Jul 2023 02:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Message-ID: <202307200137.Wk1s5BY7-lkp@intel.com>
References: <20230719051525.46494-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719051525.46494-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.5-rc2 next-20230719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-core-Add-support-for-dev_name-0-0-naming-for-kernel-console/20230719-131657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230719051525.46494-1-tony%40atomide.com
patch subject: [PATCH] serial: core: Add support for dev_name:0.0 naming for kernel console
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230720/202307200137.Wk1s5BY7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307200137.Wk1s5BY7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307200137.Wk1s5BY7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/serial_core.c: In function 'serial_core_add_preferred_console':
>> drivers/tty/serial/serial_core.c:3337:36: error: 'struct uart_port' has no member named 'port_id'
    3337 |                                port->port_id);
         |                                    ^~


vim +3337 drivers/tty/serial/serial_core.c

  3324	
  3325	/*
  3326	 * Add preferred console if configured on kernel command line with naming
  3327	 * "console=dev_name:0.0".
  3328	 */
  3329	static int serial_core_add_preferred_console(struct uart_driver *drv,
  3330						     struct uart_port *port)
  3331	{
  3332		char *port_match, *opt, *name;
  3333		int len, ret = 0;
  3334	
  3335		port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
  3336				       dev_name(port->dev), port->ctrl_id,
> 3337				       port->port_id);
  3338		if (!port_match)
  3339			return -ENOMEM;
  3340	
  3341		opt = strstr(saved_command_line, port_match);
  3342		if (!opt)
  3343			goto free_port_match;
  3344	
  3345		len = strlen(port_match);
  3346	
  3347		if (strlen(opt) > len + 1 && opt[len] == ',')
  3348			opt += len + 1;
  3349		else
  3350			opt = NULL;
  3351	
  3352		name = kstrdup(drv->dev_name, GFP_KERNEL);
  3353		if (!name) {
  3354			ret = -ENOMEM;
  3355			goto free_port_match;
  3356		}
  3357	
  3358		add_preferred_console(name, port->line, opt);
  3359	
  3360		kfree(name);
  3361	
  3362	free_port_match:
  3363		kfree(port_match);
  3364	
  3365		return ret;
  3366	}
  3367	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
