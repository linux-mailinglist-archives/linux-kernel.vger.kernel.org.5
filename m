Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C8805D94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbjLESaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:30:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5FAC;
        Tue,  5 Dec 2023 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701801018; x=1733337018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zz7EFTXIoG/cqIxk5/CEZFwnhwoZiqUADJITyhN0vUE=;
  b=lxij1JtBRLni95lEXPYixEk91lm6RS+/jwZAkrwQHwqU3F2rrOvBv3p3
   HpEe4NlMq3+zh62y1ET8O2CpYK6KUwcQoX+tbCBIurz9pAzwD5MmEosYr
   2uL27GS1x7lpe6dkFpaGCt7Ef5fu32D8X/YVTaY5IAQLU0cfbXP/MP6pC
   XxQW6MLrzY5UhflMbRjjxKHG9PqVbBQkXLLJBaKiN27Zgna1ymj21P34S
   GjxT1cW7y3uxLaniybYPDAzvwosirxz1L+JhIypZbfxOccjhbTPfsaAfP
   MMkp3U5IICoycUVZylZfg2MqhRFq0HuH0xJ+eN13J0DegbSZisfj5108R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396730845"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="396730845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894462843"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894462843"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 10:30:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAaBO-0009Xo-2s;
        Tue, 05 Dec 2023 18:30:10 +0000
Date:   Wed, 6 Dec 2023 02:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 4/4] serial: 8250: Add preferred console in
 serial8250_isa_init_ports()
Message-ID: <202312060232.s0uWr7z9-lkp@intel.com>
References: <20231205073255.20562-5-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205073255.20562-5-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/printk-Save-console-options-for-add_preferred_console_match/20231205-153731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231205073255.20562-5-tony%40atomide.com
patch subject: [PATCH v4 4/4] serial: 8250: Add preferred console in serial8250_isa_init_ports()
config: m68k-randconfig-r071-20231205 (https://download.01.org/0day-ci/archive/20231206/202312060232.s0uWr7z9-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060232.s0uWr7z9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060232.s0uWr7z9-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_core.c: In function 'serial8250_isa_init_ports':
>> drivers/tty/serial/8250/8250_core.c:597:55: warning: passing argument 1 of 'serial8250_isa_init_preferred_console' makes pointer from integer without a cast [-Wint-conversion]
     597 |                 serial8250_isa_init_preferred_console(i);
         |                                                       ^
         |                                                       |
         |                                                       int
   drivers/tty/serial/8250/8250_core.c:543:76: note: expected 'struct uart_port *' but argument is of type 'int'
     543 | static inline void serial8250_isa_init_preferred_console(struct uart_port *port,
         |                                                          ~~~~~~~~~~~~~~~~~~^~~~
>> drivers/tty/serial/8250/8250_core.c:597:17: error: too few arguments to function 'serial8250_isa_init_preferred_console'
     597 |                 serial8250_isa_init_preferred_console(i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_core.c:543:20: note: declared here
     543 | static inline void serial8250_isa_init_preferred_console(struct uart_port *port,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/serial8250_isa_init_preferred_console +597 drivers/tty/serial/8250/8250_core.c

   549	
   550	static void __init serial8250_isa_init_ports(void)
   551	{
   552		struct uart_8250_port *up;
   553		static int first = 1;
   554		int i, irqflag = 0;
   555	
   556		if (!first)
   557			return;
   558		first = 0;
   559	
   560		if (nr_uarts > UART_NR)
   561			nr_uarts = UART_NR;
   562	
   563		/*
   564		 * Set up initial isa ports based on nr_uart module param, or else
   565		 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
   566		 * need to increase nr_uarts when setting up the initial isa ports.
   567		 */
   568		for (i = 0; i < nr_uarts; i++)
   569			serial8250_setup_port(i);
   570	
   571		/* chain base port ops to support Remote Supervisor Adapter */
   572		univ8250_port_ops = *base_ops;
   573		univ8250_rsa_support(&univ8250_port_ops);
   574	
   575		if (share_irqs)
   576			irqflag = IRQF_SHARED;
   577	
   578		for (i = 0, up = serial8250_ports;
   579		     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
   580		     i++, up++) {
   581			struct uart_port *port = &up->port;
   582	
   583			port->iobase   = old_serial_port[i].port;
   584			port->irq      = irq_canonicalize(old_serial_port[i].irq);
   585			port->irqflags = 0;
   586			port->uartclk  = old_serial_port[i].baud_base * 16;
   587			port->flags    = old_serial_port[i].flags;
   588			port->hub6     = 0;
   589			port->membase  = old_serial_port[i].iomem_base;
   590			port->iotype   = old_serial_port[i].io_type;
   591			port->regshift = old_serial_port[i].iomem_reg_shift;
   592	
   593			port->irqflags |= irqflag;
   594			if (serial8250_isa_config != NULL)
   595				serial8250_isa_config(i, &up->port, &up->capabilities);
   596	
 > 597			serial8250_isa_init_preferred_console(i);
   598		}
   599	}
   600	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
