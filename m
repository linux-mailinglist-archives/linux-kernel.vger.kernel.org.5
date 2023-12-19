Return-Path: <linux-kernel+bounces-5262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3DB8188AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9896C1F2220A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15A1A58C;
	Tue, 19 Dec 2023 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esqHqOFR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40318EB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702992646; x=1734528646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WH076I+ueJVW536LmNYtx9/DY+wiT7jp/09mfVfGvXA=;
  b=esqHqOFRiEwHCcJRtZriQAySRsFK82NOgpklM25EktyQRGk9jPxON2ZV
   CJz6pz3Pdxh55jaKEFUl8RhSUUL+ORqVKHJBUAbijxlXFLcR4FfnptEOu
   ZTSfID11cMTI8/p/7LqOR+i79cJPcsNyYd/5/qt8OwWCZQySc5q7nCL8w
   8KkUPM3p+aMAXDfU7N1lFowRxcTrLkj4fH4gZcz+s9nrH0r7VIASF5/uw
   GtQkn8Hblbo+gzywsZDzdIL6KECBuJtg0Kpn5tfdfuluXwXGw7Wwruw88
   7gkYJy/trIWGsiTn6nOJ/3qL/up6XGhgfyxic+QQkedJqt+7UwL14s0zP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14345359"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="14345359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769237580"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="769237580"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2023 05:30:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFaBD-0005Mf-2o;
	Tue, 19 Dec 2023 13:30:39 +0000
Date: Tue, 19 Dec 2023 21:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202312192107.YhRbeka3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 15104de122a4f0258981b06ed94cf616a6eb03ef x86: Adjust types used in port I/O helpers
date:   1 year, 8 months ago
config: i386-randconfig-062-20231014 (https://download.01.org/0day-ci/archive/20231219/202312192107.YhRbeka3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312192107.YhRbeka3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.YhRbeka3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/isdn/hardware/mISDN/avmfritz.c:421:23: sparse: sparse: cast to restricted __le32
>> drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse:     expected unsigned int [usertype] value
   drivers/isdn/hardware/mISDN/avmfritz.c:494:30: sparse:     got restricted __le32 [usertype]

vim +494 drivers/isdn/hardware/mISDN/avmfritz.c

6115d2f3fcaebe Karsten Keil 2009-07-22  388  
6115d2f3fcaebe Karsten Keil 2009-07-22  389  static void
6115d2f3fcaebe Karsten Keil 2009-07-22  390  hdlc_empty_fifo(struct bchannel *bch, int count)
6115d2f3fcaebe Karsten Keil 2009-07-22  391  {
6115d2f3fcaebe Karsten Keil 2009-07-22  392  	u32 *ptr;
6115d2f3fcaebe Karsten Keil 2009-07-22  393  	u8 *p;
6115d2f3fcaebe Karsten Keil 2009-07-22  394  	u32  val, addr;
7206e659f68955 Karsten Keil 2012-05-15  395  	int cnt;
6115d2f3fcaebe Karsten Keil 2009-07-22  396  	struct fritzcard *fc = bch->hw;
6115d2f3fcaebe Karsten Keil 2009-07-22  397  
6115d2f3fcaebe Karsten Keil 2009-07-22  398  	pr_debug("%s: %s %d\n", fc->name, __func__, count);
c27b46e7f1cbf3 Karsten Keil 2012-05-15  399  	if (test_bit(FLG_RX_OFF, &bch->Flags)) {
c27b46e7f1cbf3 Karsten Keil 2012-05-15  400  		p = NULL;
c27b46e7f1cbf3 Karsten Keil 2012-05-15  401  		bch->dropcnt += count;
c27b46e7f1cbf3 Karsten Keil 2012-05-15  402  	} else {
7206e659f68955 Karsten Keil 2012-05-15  403  		cnt = bchannel_get_rxbuf(bch, count);
7206e659f68955 Karsten Keil 2012-05-15  404  		if (cnt < 0) {
257daba4eb7f2b Kefeng Wang  2019-10-18  405  			pr_warn("%s.B%d: No bufferspace for %d bytes\n",
7206e659f68955 Karsten Keil 2012-05-15  406  				fc->name, bch->nr, count);
6115d2f3fcaebe Karsten Keil 2009-07-22  407  			return;
6115d2f3fcaebe Karsten Keil 2009-07-22  408  		}
6115d2f3fcaebe Karsten Keil 2009-07-22  409  		p = skb_put(bch->rx_skb, count);
c27b46e7f1cbf3 Karsten Keil 2012-05-15  410  	}
6115d2f3fcaebe Karsten Keil 2009-07-22  411  	ptr = (u32 *)p;
09e79a777a0c9c Karsten Keil 2012-05-15  412  	if (fc->type == AVM_FRITZ_PCIV2)
6115d2f3fcaebe Karsten Keil 2009-07-22  413  		addr = fc->addr + (bch->nr == 2 ?
6115d2f3fcaebe Karsten Keil 2009-07-22  414  				   AVM_HDLC_FIFO_2 : AVM_HDLC_FIFO_1);
6115d2f3fcaebe Karsten Keil 2009-07-22  415  	else {
6115d2f3fcaebe Karsten Keil 2009-07-22  416  		addr = fc->addr + CHIP_WINDOW;
6115d2f3fcaebe Karsten Keil 2009-07-22  417  		outl(bch->nr == 2 ? AVM_HDLC_2 : AVM_HDLC_1, fc->addr);
6115d2f3fcaebe Karsten Keil 2009-07-22  418  	}
7206e659f68955 Karsten Keil 2012-05-15  419  	cnt = 0;
6115d2f3fcaebe Karsten Keil 2009-07-22  420  	while (cnt < count) {
6115d2f3fcaebe Karsten Keil 2009-07-22 @421  		val = le32_to_cpu(inl(addr));
c27b46e7f1cbf3 Karsten Keil 2012-05-15  422  		if (p) {
6115d2f3fcaebe Karsten Keil 2009-07-22  423  			put_unaligned(val, ptr);
6115d2f3fcaebe Karsten Keil 2009-07-22  424  			ptr++;
c27b46e7f1cbf3 Karsten Keil 2012-05-15  425  		}
6115d2f3fcaebe Karsten Keil 2009-07-22  426  		cnt += 4;
6115d2f3fcaebe Karsten Keil 2009-07-22  427  	}
c27b46e7f1cbf3 Karsten Keil 2012-05-15  428  	if (p && (debug & DEBUG_HW_BFIFO)) {
6115d2f3fcaebe Karsten Keil 2009-07-22  429  		snprintf(fc->log, LOG_SIZE, "B%1d-recv %s %d ",
6115d2f3fcaebe Karsten Keil 2009-07-22  430  			 bch->nr, fc->name, count);
6115d2f3fcaebe Karsten Keil 2009-07-22  431  		print_hex_dump_bytes(fc->log, DUMP_PREFIX_OFFSET, p, count);
6115d2f3fcaebe Karsten Keil 2009-07-22  432  	}
6115d2f3fcaebe Karsten Keil 2009-07-22  433  }
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

