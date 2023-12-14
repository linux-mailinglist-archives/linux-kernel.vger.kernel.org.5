Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9222812401
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442840AbjLNAnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNAnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:43:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA3B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702514603; x=1734050603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j8L7B4f1lnjXU3gnLVx/ZfQJMSKskxtQHsS23kK9EZE=;
  b=gFEM4/N+wtpWRNYbYeAgfmgNdzLqO/U5PtA+tBgP6apJv+8nt9DANCAQ
   qBqBuhuiUrGqb3aTqbD+MpRm5ekMz8IJZSO43o0iFfILOZyj8/69Ko9w5
   1Mpk3jQ1imuVceRynL6MV321ZW72IQPy8pi4G2ewT6NP7Gx5nTe04iMN3
   KjwmTMBRPPXW6sp47PWnfW286CQP2KcWCo3OYvYSw0GOXFa02jybqu6tc
   sX6BBntkpEG6DZqeDSlqm6djNlU/M5P4VBYUkE+decB9kEWxn8qFlWZJp
   6PRPSCS3lzKWQmdFM/6yk6P4pWQJCa9CvQzuyvrFcsPAQ5kQkL/juxGPz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398884449"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="398884449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021318409"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1021318409"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2023 16:43:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDZos-000LM1-1Y;
        Thu, 14 Dec 2023 00:43:18 +0000
Date:   Thu, 14 Dec 2023 08:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/tty/ipwireless/hardware.c:431:30: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202312140821.C5nNiybl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 15104de122a4f0258981b06ed94cf616a6eb03ef x86: Adjust types used in port I/O helpers
date:   1 year, 8 months ago
config: i386-randconfig-061-20231101 (https://download.01.org/0day-ci/archive/20231214/202312140821.C5nNiybl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140821.C5nNiybl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140821.C5nNiybl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/ipwireless/hardware.c:431:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:431:30: sparse:     expected unsigned short [usertype] value
   drivers/tty/ipwireless/hardware.c:431:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     expected unsigned short [usertype] value
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short @@
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     got unsigned short
   drivers/tty/ipwireless/hardware.c:889:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short @@
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     got unsigned short

vim +431 drivers/tty/ipwireless/hardware.c

d54c2752f6bb6cc drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  403  
93110f698fe92fc drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  404  static void do_send_fragment(struct ipw_hardware *hw, unsigned char *data,
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  405  			    unsigned length)
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  406  {
d4c0deb7009217d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  407  	unsigned i;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  408  	unsigned long flags;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  409  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  410  	start_timing();
93110f698fe92fc drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  411  	BUG_ON(length > hw->ll_mtu);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  412  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  413  	if (ipwireless_debug)
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  414  		dump_data_bytes("send", data, length);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  415  
63c4dbd1023b9ac drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  416  	spin_lock_irqsave(&hw->lock, flags);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  417  
eb4e545d4ac82d9 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  418  	hw->tx_ready = 0;
d54c2752f6bb6cc drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  419  	swap_packet_bitfield_to_le(data);
eb4e545d4ac82d9 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  420  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  421  	if (hw->hw_version == HW_VERSION_1) {
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  422  		outw((unsigned short) length, hw->base_port + IODWR);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  423  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  424  		for (i = 0; i < length; i += 2) {
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  425  			unsigned short d = data[i];
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  426  			__le16 raw_data;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  427  
d4c0deb7009217d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  428  			if (i + 1 < length)
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  429  				d |= data[i + 1] << 8;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  430  			raw_data = cpu_to_le16(d);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07 @431  			outw(raw_data, hw->base_port + IODWR);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  432  		}
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  433  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  434  		outw(DCR_TXDONE, hw->base_port + IODCR);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  435  	} else if (hw->hw_version == HW_VERSION_2) {
2e713165f892c83 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  436  		outw((unsigned short) length, hw->base_port);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  437  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  438  		for (i = 0; i < length; i += 2) {
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  439  			unsigned short d = data[i];
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  440  			__le16 raw_data;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  441  
d4c0deb7009217d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  442  			if (i + 1 < length)
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  443  				d |= data[i + 1] << 8;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  444  			raw_data = cpu_to_le16(d);
2e713165f892c83 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  445  			outw(raw_data, hw->base_port);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  446  		}
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  447  		while ((i & 3) != 2) {
2e713165f892c83 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  448  			outw((unsigned short) 0xDEAD, hw->base_port);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  449  			i += 2;
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  450  		}
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  451  		writew(MEMRX_RX, &hw->memory_info_regs->memreg_rx);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  452  	}
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  453  
63c4dbd1023b9ac drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  454  	spin_unlock_irqrestore(&hw->lock, flags);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  455  
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  456  	end_write_timing(length);
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  457  }
099dc4fb62653f6 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  458  

:::::: The code at line 431 was first introduced by commit
:::::: 099dc4fb62653f6019d78db55fba7a18ef02d65b ipwireless: driver for PC Card 3G/UMTS modem

:::::: TO: David Sterba <dsterba@suse.cz>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
