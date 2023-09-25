Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2433C7AE223
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjIYXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:15:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5A101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695683737; x=1727219737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZTEKHYjVFI7ks0FWdzDPMePD0AMHRt4zCALTjq/MNRs=;
  b=iH4aXCX4NyfySX/i96qNA+JhCccqd6Am+f41hPUqmNrKLI4RSDGvtVNP
   FeI9KknvrJl1oUZSK+lYUUW/YR0YmnYpeFVqOACsCnVwgXENwBLOVtpLk
   w3RTzwcUz5zjfc5Te4U3jf64VBOn8P77UlVLPPS2awQyvT/M1C1d1MLHa
   os0f8430PyUmv+t814PsKbRftZ84HpYdkGyCbeVg9Mmyl1v8qIZ9+sgQ9
   uI+rQ1NRC0sHPMhWF6TP47oH8MNnN5zXfwrQ59DETbBr6n6xcW+bO/EYY
   I2tIW9wQiquR1FtLgziUfA97hM8b1K8ucHU6Vq8TkgrVe8XutJdpe15lr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467719857"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="467719857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698247295"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="698247295"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2023 16:15:34 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkunc-00027m-0L;
        Mon, 25 Sep 2023 23:15:32 +0000
Date:   Tue, 26 Sep 2023 07:15:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202309260705.tXRNV0dr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: 15104de122a4f0258981b06ed94cf616a6eb03ef x86: Adjust types used in port I/O helpers
date:   1 year, 6 months ago
config: x86_64-randconfig-122-20230926 (https://download.01.org/0day-ci/archive/20230926/202309260705.tXRNV0dr-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230926/202309260705.tXRNV0dr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309260705.tXRNV0dr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast to restricted __le32
>> drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse:     expected unsigned int [usertype] value
   drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse:     got restricted __le32 [usertype]

vim +494 drivers/isdn/hardware/mISDN/avmfritz.c

6115d2f3fcaebe Karsten Keil 2009-07-22  434  
6115d2f3fcaebe Karsten Keil 2009-07-22  435  static void
6115d2f3fcaebe Karsten Keil 2009-07-22  436  hdlc_fill_fifo(struct bchannel *bch)
6115d2f3fcaebe Karsten Keil 2009-07-22  437  {
6115d2f3fcaebe Karsten Keil 2009-07-22  438  	struct fritzcard *fc = bch->hw;
6115d2f3fcaebe Karsten Keil 2009-07-22  439  	struct hdlc_hw *hdlc;
b41a9a66f67817 Karsten Keil 2012-07-29  440  	int count, fs, cnt = 0, idx;
b41a9a66f67817 Karsten Keil 2012-07-29  441  	bool fillempty = false;
6115d2f3fcaebe Karsten Keil 2009-07-22  442  	u8 *p;
6115d2f3fcaebe Karsten Keil 2009-07-22  443  	u32 *ptr, val, addr;
6115d2f3fcaebe Karsten Keil 2009-07-22  444  
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  445  	idx = (bch->nr - 1) & 1;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  446  	hdlc = &fc->hdlc[idx];
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  447  	fs = (fc->type == AVM_FRITZ_PCIV2) ?
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  448  		HDLC_FIFO_SIZE_V2 : HDLC_FIFO_SIZE_V1;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  449  	if (!bch->tx_skb) {
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  450  		if (!test_bit(FLG_TX_EMPTY, &bch->Flags))
6115d2f3fcaebe Karsten Keil 2009-07-22  451  			return;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  452  		count = fs;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  453  		p = bch->fill;
b41a9a66f67817 Karsten Keil 2012-07-29  454  		fillempty = true;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  455  	} else {
6115d2f3fcaebe Karsten Keil 2009-07-22  456  		count = bch->tx_skb->len - bch->tx_idx;
6115d2f3fcaebe Karsten Keil 2009-07-22  457  		if (count <= 0)
6115d2f3fcaebe Karsten Keil 2009-07-22  458  			return;
6115d2f3fcaebe Karsten Keil 2009-07-22  459  		p = bch->tx_skb->data + bch->tx_idx;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  460  	}
6115d2f3fcaebe Karsten Keil 2009-07-22  461  	hdlc->ctrl.sr.cmd &= ~HDLC_CMD_XME;
09e79a777a0c9c Karsten Keil 2012-05-15  462  	if (count > fs) {
09e79a777a0c9c Karsten Keil 2012-05-15  463  		count = fs;
6115d2f3fcaebe Karsten Keil 2009-07-22  464  	} else {
6115d2f3fcaebe Karsten Keil 2009-07-22  465  		if (test_bit(FLG_HDLC, &bch->Flags))
6115d2f3fcaebe Karsten Keil 2009-07-22  466  			hdlc->ctrl.sr.cmd |= HDLC_CMD_XME;
6115d2f3fcaebe Karsten Keil 2009-07-22  467  	}
6115d2f3fcaebe Karsten Keil 2009-07-22  468  	ptr = (u32 *)p;
b41a9a66f67817 Karsten Keil 2012-07-29  469  	if (!fillempty) {
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  470  		pr_debug("%s.B%d: %d/%d/%d", fc->name, bch->nr, count,
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  471  			 bch->tx_idx, bch->tx_skb->len);
6115d2f3fcaebe Karsten Keil 2009-07-22  472  		bch->tx_idx += count;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  473  	} else {
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  474  		pr_debug("%s.B%d: fillempty %d\n", fc->name, bch->nr, count);
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  475  	}
09e79a777a0c9c Karsten Keil 2012-05-15  476  	hdlc->ctrl.sr.xml = ((count == fs) ? 0 : count);
09e79a777a0c9c Karsten Keil 2012-05-15  477  	if (fc->type == AVM_FRITZ_PCIV2) {
6115d2f3fcaebe Karsten Keil 2009-07-22  478  		__write_ctrl_pciv2(fc, hdlc, bch->nr);
6115d2f3fcaebe Karsten Keil 2009-07-22  479  		addr = fc->addr + (bch->nr == 2 ?
6115d2f3fcaebe Karsten Keil 2009-07-22  480  				   AVM_HDLC_FIFO_2 : AVM_HDLC_FIFO_1);
6115d2f3fcaebe Karsten Keil 2009-07-22  481  	} else {
6115d2f3fcaebe Karsten Keil 2009-07-22  482  		__write_ctrl_pci(fc, hdlc, bch->nr);
6115d2f3fcaebe Karsten Keil 2009-07-22  483  		addr = fc->addr + CHIP_WINDOW;
6115d2f3fcaebe Karsten Keil 2009-07-22  484  	}
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  485  	if (fillempty) {
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  486  		while (cnt < count) {
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  487  			/* all bytes the same - no worry about endian */
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  488  			outl(*ptr, addr);
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  489  			cnt += 4;
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  490  		}
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  491  	} else {
6115d2f3fcaebe Karsten Keil 2009-07-22  492  		while (cnt < count) {
6115d2f3fcaebe Karsten Keil 2009-07-22  493  			val = get_unaligned(ptr);
6115d2f3fcaebe Karsten Keil 2009-07-22 @494  			outl(cpu_to_le32(val), addr);
6115d2f3fcaebe Karsten Keil 2009-07-22  495  			ptr++;
6115d2f3fcaebe Karsten Keil 2009-07-22  496  			cnt += 4;
6115d2f3fcaebe Karsten Keil 2009-07-22  497  		}
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  498  	}
6d1ee48fd0d8d2 Karsten Keil 2012-05-15  499  	if ((debug & DEBUG_HW_BFIFO) && !fillempty) {
6115d2f3fcaebe Karsten Keil 2009-07-22  500  		snprintf(fc->log, LOG_SIZE, "B%1d-send %s %d ",
6115d2f3fcaebe Karsten Keil 2009-07-22  501  			 bch->nr, fc->name, count);
6115d2f3fcaebe Karsten Keil 2009-07-22  502  		print_hex_dump_bytes(fc->log, DUMP_PREFIX_OFFSET, p, count);
6115d2f3fcaebe Karsten Keil 2009-07-22  503  	}
6115d2f3fcaebe Karsten Keil 2009-07-22  504  }
6115d2f3fcaebe Karsten Keil 2009-07-22  505  

:::::: The code at line 494 was first introduced by commit
:::::: 6115d2f3fcaebed5b88fa9cefd178bb5b07461ff mISDN: Driver for AVM Fritz!CARD PCI

:::::: TO: Karsten Keil <keil@b1-systems.de>
:::::: CC: Karsten Keil <keil@b1-systems.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
