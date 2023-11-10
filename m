Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972827E7F97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjKJR4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKJRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204604C31
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699597309; x=1731133309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yyYQ8amR3uB35gwrCOYFHTsujVGfnmg2sr5CJFdCqBk=;
  b=W2Q2CRa6p0cC3CxtUSDqAUpJZ/TUpttFyy6ZgXFR00gYjTQu7b78F3Cl
   frAcJfHx8AQEP99J66+n5EEysP2N2WH7yem+lqWwWw0PMSY3/ywmrd2TC
   //9cvogs7z2YeBi4unrvRhdhIK3LhyRagVqQXbO5jTYxLp0henF3GiKGt
   tzXP85KIIOGcqf30OdYbu6IYIdl5emHPoSjSATk/CWvSRECJLWIqWzfTm
   Y8VtnKczZK06tsJKgUeJoOfIocwEO2sSZ2TicT0I58tJ2/HXEagvWtF7w
   hbAynwGqCrUtxfBO8DubERiHHskpVMhpwRUB9jvZ2A4uhrdKDfl14MLxU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375178452"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="375178452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792780899"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792780899"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2023 21:59:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1KYP-0009S0-0R;
        Fri, 10 Nov 2023 05:59:41 +0000
Date:   Fri, 10 Nov 2023 13:59:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Excess function
 parameter 'hub' description in 'hub_pio_map'
Message-ID: <202311101336.BUL1JuvU-lkp@intel.com>
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
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: e8a3118e1f5cbe0c26704419390bf074689b349f objtool: make it visible in make V=1 output
date:   7 years ago
config: mips-randconfig-r035-20210927 (https://download.01.org/0day-ci/archive/20231110/202311101336.BUL1JuvU-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101336.BUL1JuvU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101336.BUL1JuvU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Function parameter or member 'cnode' not described in 'hub_pio_map'
>> arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Excess function parameter 'hub' description in 'hub_pio_map'


vim +30 arch/mips/sgi-ip27/ip27-hubio.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  18  
^1da177e4c3f41 Linus Torvalds 2005-04-16  19  /**
^1da177e4c3f41 Linus Torvalds 2005-04-16  20   * hub_pio_map	-  establish a HUB PIO mapping
^1da177e4c3f41 Linus Torvalds 2005-04-16  21   *
^1da177e4c3f41 Linus Torvalds 2005-04-16  22   * @hub:	hub to perform PIO mapping on
^1da177e4c3f41 Linus Torvalds 2005-04-16  23   * @widget:	widget ID to perform PIO mapping for
^1da177e4c3f41 Linus Torvalds 2005-04-16  24   * @xtalk_addr: xtalk_address that needs to be mapped
^1da177e4c3f41 Linus Torvalds 2005-04-16  25   * @size:	size of the PIO mapping
^1da177e4c3f41 Linus Torvalds 2005-04-16  26   *
^1da177e4c3f41 Linus Torvalds 2005-04-16  27   **/
^1da177e4c3f41 Linus Torvalds 2005-04-16  28  unsigned long hub_pio_map(cnodeid_t cnode, xwidgetnum_t widget,
^1da177e4c3f41 Linus Torvalds 2005-04-16  29  			  unsigned long xtalk_addr, size_t size)
^1da177e4c3f41 Linus Torvalds 2005-04-16 @30  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  31  	nasid_t nasid = COMPACT_TO_NASID_NODEID(cnode);
^1da177e4c3f41 Linus Torvalds 2005-04-16  32  	unsigned i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  33  
^1da177e4c3f41 Linus Torvalds 2005-04-16  34  	/* use small-window mapping if possible */
^1da177e4c3f41 Linus Torvalds 2005-04-16  35  	if ((xtalk_addr % SWIN_SIZE) + size <= SWIN_SIZE)
^1da177e4c3f41 Linus Torvalds 2005-04-16  36  		return NODE_SWIN_BASE(nasid, widget) + (xtalk_addr % SWIN_SIZE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  37  
^1da177e4c3f41 Linus Torvalds 2005-04-16  38  	if ((xtalk_addr % BWIN_SIZE) + size > BWIN_SIZE) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  39  		printk(KERN_WARNING "PIO mapping at hub %d widget %d addr 0x%lx"
^1da177e4c3f41 Linus Torvalds 2005-04-16  40  				" too big (%ld)\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  41  				nasid, widget, xtalk_addr, size);
^1da177e4c3f41 Linus Torvalds 2005-04-16  42  		return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  43  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  44  
^1da177e4c3f41 Linus Torvalds 2005-04-16  45  	xtalk_addr &= ~(BWIN_SIZE-1);
^1da177e4c3f41 Linus Torvalds 2005-04-16  46  	for (i = 0; i < HUB_NUM_BIG_WINDOW; i++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  47  		if (test_and_set_bit(i, hub_data(cnode)->h_bigwin_used))
^1da177e4c3f41 Linus Torvalds 2005-04-16  48  			continue;
^1da177e4c3f41 Linus Torvalds 2005-04-16  49  
^1da177e4c3f41 Linus Torvalds 2005-04-16  50  		/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  51  		 * The code below does a PIO write to setup an ITTE entry.
^1da177e4c3f41 Linus Torvalds 2005-04-16  52  		 *
^1da177e4c3f41 Linus Torvalds 2005-04-16  53  		 * We need to prevent other CPUs from seeing our updated
^1da177e4c3f41 Linus Torvalds 2005-04-16  54  		 * memory shadow of the ITTE (in the piomap) until the ITTE
^1da177e4c3f41 Linus Torvalds 2005-04-16  55  		 * entry is actually set up; otherwise, another CPU might
^1da177e4c3f41 Linus Torvalds 2005-04-16  56  		 * attempt a PIO prematurely.
^1da177e4c3f41 Linus Torvalds 2005-04-16  57  		 *
^1da177e4c3f41 Linus Torvalds 2005-04-16  58  		 * Also, the only way we can know that an entry has been
^1da177e4c3f41 Linus Torvalds 2005-04-16  59  		 * received  by the hub and can be used by future PIO reads/
^1da177e4c3f41 Linus Torvalds 2005-04-16  60  		 * writes is by reading back the ITTE entry after writing it.
^1da177e4c3f41 Linus Torvalds 2005-04-16  61  		 *
^1da177e4c3f41 Linus Torvalds 2005-04-16  62  		 * For these two reasons, we PIO read back the ITTE entry
^1da177e4c3f41 Linus Torvalds 2005-04-16  63  		 * after we write it.
^1da177e4c3f41 Linus Torvalds 2005-04-16  64  		 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  		IIO_ITTE_PUT(nasid, i, HUB_PIO_MAP_TO_MEM, widget, xtalk_addr);
e12f47ef1680d8 Ralf Baechle   2011-04-11  66  		(void) HUB_L(IIO_ITTE_GET(nasid, i));
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  
^1da177e4c3f41 Linus Torvalds 2005-04-16  68  		return NODE_BWIN_BASE(nasid, widget) + (xtalk_addr % BWIN_SIZE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  70  
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  	printk(KERN_WARNING "unable to establish PIO mapping for at"
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  			" hub %d widget %d addr 0x%lx\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  73  			nasid, widget, xtalk_addr);
^1da177e4c3f41 Linus Torvalds 2005-04-16  74  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  75  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  76  

:::::: The code at line 30 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
