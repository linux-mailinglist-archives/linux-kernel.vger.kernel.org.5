Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B97E1B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjKFHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjKFHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:30:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9B112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699255834; x=1730791834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y9+hMyZOY8DXV+V5+GVt/uSbUtua7jEKShXj5NCtDRg=;
  b=SSaY1Tt8xyuJyAqAUXR26YyyIFPZmrYYKWfuG1wfjfkPYMSinYd5M+uM
   nHHw0MjGjM0ZyQGJZ+JvdXzStPzmW22B2yN/FWr14wEjXJRQiMYz+Tsp3
   ux+W8pyZm0pZ1fFDC7OU7TWWqxbh4kLNQjgd3RNYi6qIm+W5bjxyYfppU
   QLvovXHp0c+IlfoQSUYw/41CX2WoM4WM+Ys2ldCGgSxpiDOnDdqnsyZ8m
   E/4K8uslu3ibTi5BJMdCLd5d31NY5KE9axLPd0Bvq7BsT3IwoS/e+7IGR
   I3bzsbMzoKowB46IE+1ASBb/QdCjfRcNFKyRgKjIj6UmdxYb3967saA22
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388105388"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="388105388"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="3362408"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2023 23:30:33 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzu46-0006EO-0D;
        Mon, 06 Nov 2023 07:30:30 +0000
Date:   Mon, 6 Nov 2023 15:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Function parameter or
 member 'nasid' not described in 'hub_pio_map'
Message-ID: <202311061528.2HBbx68B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 4bf841ebf17aaa0f7712623896c699b44fa92f44 MIPS: SGI-IP27: get rid of compact node ids
date:   4 years, 1 month ago
config: mips-randconfig-r035-20210927 (https://download.01.org/0day-ci/archive/20231106/202311061528.2HBbx68B-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061528.2HBbx68B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061528.2HBbx68B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Function parameter or member 'nasid' not described in 'hub_pio_map'
   arch/mips/sgi-ip27/ip27-hubio.c:30: warning: Excess function parameter 'hub' description in 'hub_pio_map'


vim +30 arch/mips/sgi-ip27/ip27-hubio.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  18  
^1da177e4c3f41 Linus Torvalds      2005-04-16  19  /**
^1da177e4c3f41 Linus Torvalds      2005-04-16  20   * hub_pio_map	-  establish a HUB PIO mapping
^1da177e4c3f41 Linus Torvalds      2005-04-16  21   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  22   * @hub:	hub to perform PIO mapping on
^1da177e4c3f41 Linus Torvalds      2005-04-16  23   * @widget:	widget ID to perform PIO mapping for
^1da177e4c3f41 Linus Torvalds      2005-04-16  24   * @xtalk_addr: xtalk_address that needs to be mapped
^1da177e4c3f41 Linus Torvalds      2005-04-16  25   * @size:	size of the PIO mapping
^1da177e4c3f41 Linus Torvalds      2005-04-16  26   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  27   **/
4bf841ebf17aaa Thomas Bogendoerfer 2019-10-03  28  unsigned long hub_pio_map(nasid_t nasid, xwidgetnum_t widget,
^1da177e4c3f41 Linus Torvalds      2005-04-16  29  			  unsigned long xtalk_addr, size_t size)
^1da177e4c3f41 Linus Torvalds      2005-04-16 @30  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  31  	unsigned i;
^1da177e4c3f41 Linus Torvalds      2005-04-16  32  
^1da177e4c3f41 Linus Torvalds      2005-04-16  33  	/* use small-window mapping if possible */
^1da177e4c3f41 Linus Torvalds      2005-04-16  34  	if ((xtalk_addr % SWIN_SIZE) + size <= SWIN_SIZE)
^1da177e4c3f41 Linus Torvalds      2005-04-16  35  		return NODE_SWIN_BASE(nasid, widget) + (xtalk_addr % SWIN_SIZE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  36  
^1da177e4c3f41 Linus Torvalds      2005-04-16  37  	if ((xtalk_addr % BWIN_SIZE) + size > BWIN_SIZE) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  38  		printk(KERN_WARNING "PIO mapping at hub %d widget %d addr 0x%lx"
^1da177e4c3f41 Linus Torvalds      2005-04-16  39  				" too big (%ld)\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16  40  				nasid, widget, xtalk_addr, size);
^1da177e4c3f41 Linus Torvalds      2005-04-16  41  		return 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  42  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  43  
^1da177e4c3f41 Linus Torvalds      2005-04-16  44  	xtalk_addr &= ~(BWIN_SIZE-1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  45  	for (i = 0; i < HUB_NUM_BIG_WINDOW; i++) {
4bf841ebf17aaa Thomas Bogendoerfer 2019-10-03  46  		if (test_and_set_bit(i, hub_data(nasid)->h_bigwin_used))
^1da177e4c3f41 Linus Torvalds      2005-04-16  47  			continue;
^1da177e4c3f41 Linus Torvalds      2005-04-16  48  
^1da177e4c3f41 Linus Torvalds      2005-04-16  49  		/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  50  		 * The code below does a PIO write to setup an ITTE entry.
^1da177e4c3f41 Linus Torvalds      2005-04-16  51  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  52  		 * We need to prevent other CPUs from seeing our updated
^1da177e4c3f41 Linus Torvalds      2005-04-16  53  		 * memory shadow of the ITTE (in the piomap) until the ITTE
^1da177e4c3f41 Linus Torvalds      2005-04-16  54  		 * entry is actually set up; otherwise, another CPU might
^1da177e4c3f41 Linus Torvalds      2005-04-16  55  		 * attempt a PIO prematurely.
^1da177e4c3f41 Linus Torvalds      2005-04-16  56  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  57  		 * Also, the only way we can know that an entry has been
^1da177e4c3f41 Linus Torvalds      2005-04-16  58  		 * received  by the hub and can be used by future PIO reads/
^1da177e4c3f41 Linus Torvalds      2005-04-16  59  		 * writes is by reading back the ITTE entry after writing it.
^1da177e4c3f41 Linus Torvalds      2005-04-16  60  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  61  		 * For these two reasons, we PIO read back the ITTE entry
^1da177e4c3f41 Linus Torvalds      2005-04-16  62  		 * after we write it.
^1da177e4c3f41 Linus Torvalds      2005-04-16  63  		 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  64  		IIO_ITTE_PUT(nasid, i, HUB_PIO_MAP_TO_MEM, widget, xtalk_addr);
db0e7d4e42b055 Thomas Bogendoerfer 2019-02-19  65  		__raw_readq(IIO_ITTE_GET(nasid, i));
^1da177e4c3f41 Linus Torvalds      2005-04-16  66  
^1da177e4c3f41 Linus Torvalds      2005-04-16  67  		return NODE_BWIN_BASE(nasid, widget) + (xtalk_addr % BWIN_SIZE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  68  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  69  
^1da177e4c3f41 Linus Torvalds      2005-04-16  70  	printk(KERN_WARNING "unable to establish PIO mapping for at"
^1da177e4c3f41 Linus Torvalds      2005-04-16  71  			" hub %d widget %d addr 0x%lx\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16  72  			nasid, widget, xtalk_addr);
^1da177e4c3f41 Linus Torvalds      2005-04-16  73  	return 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  74  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  75  

:::::: The code at line 30 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
