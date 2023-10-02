Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2C7B4B37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjJBFsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:48:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDDAC;
        Sun,  1 Oct 2023 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696225711; x=1727761711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J300lc2/XlevYcthNDggpmKzApVBzf8LFhTwZPuoBYY=;
  b=DbrBx/z44nGV0H1AWw4AYFnlWyMcr2mT3KsKPy9bam98zX83nSG96XpW
   BGAx69etgy7DK9cj+BRFebVyoPH9pbgdfOwEsg/i38SGm6QKcR/5M+ljS
   R93fsbE/J8efKKFKOtowMl4K1BFxewZ3U5vWwDq0DdbvBE1a2duBeGQP3
   QMHLacQtETqPL7NkHa5YD9KjruwjRhhE2g+tze7JBE4D6bIKbMnM1UO2D
   Liu35lMILkWk/gxlsbWB9De6OIAy28KqJHBpBT8vokZanfEeEv1BUXkt9
   mF1SpXpJV24HK6EWnxe1xdKwQCDmerVfhfPuuzOnW1+mcpv5rvCaOeu4Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="446742225"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="446742225"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 22:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081546722"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="1081546722"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2023 22:48:29 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnBn9-0005n7-1d;
        Mon, 02 Oct 2023 05:48:27 +0000
Date:   Mon, 2 Oct 2023 13:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface between RS422/RS485
Message-ID: <202310021306.ewtlC1QY-lkp@intel.com>
References: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002015702.30509-5-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crescent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.6-rc4 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Crescent-CY-Hsieh/tty-serial-8250-Cleanup-MOXA-configurations-in-8250_pci-c/20231002-095945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20231002015702.30509-5-crescentcy.hsieh%40moxa.com
patch subject: [PATCH 4/4] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface between RS422/RS485
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231002/202310021306.ewtlC1QY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310021306.ewtlC1QY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021306.ewtlC1QY-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_pci.c: In function 'pci_moxa_setup':
>> drivers/tty/serial/8250/8250_pci.c:2010:50: error: 'SER_RE422_ENABLED' undeclared (first use in this function); did you mean 'SER_RS422_ENABLED'?
    2010 |                         port->port.rs485.flags = SER_RE422_ENABLED;
         |                                                  ^~~~~~~~~~~~~~~~~
         |                                                  SER_RS422_ENABLED
   drivers/tty/serial/8250/8250_pci.c:2010:50: note: each undeclared identifier is reported only once for each function it appears in


vim +2010 drivers/tty/serial/8250/8250_pci.c

  1990	
  1991	static int pci_moxa_setup(struct serial_private *priv,
  1992				  const struct pciserial_board *board,
  1993				  struct uart_8250_port *port,
  1994				  int idx)
  1995	{
  1996		struct pci_dev *dev = priv->dev;
  1997		unsigned short device = dev->device;
  1998		unsigned int bar = FL_GET_BASE(board->flags);
  1999		int offset;
  2000	
  2001		/*
  2002		 * For the device IDs of MOXA PCIe boards match the pattern 0x*3** and 0x*1**,
  2003		 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
  2004		 */
  2005		if ((device & 0x0F00) == 0x0100 || (device & 0x0F00) == 0x0300) {
  2006			port->port.rs485_config = pci_moxa_rs485_config;
  2007			port->port.rs485_supported = pci_moxa_rs485_supported;
  2008	
  2009			if ((device & 0x0F00) == 0x0300)
> 2010				port->port.rs485.flags = SER_RE422_ENABLED;
  2011		}
  2012		if (board->num_ports == 4 && idx == 3)
  2013			offset = 7 * board->uart_offset;
  2014		else
  2015			offset = idx * board->uart_offset;
  2016	
  2017		return setup_port(priv, port, bar, offset, 0);
  2018	}
  2019	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
