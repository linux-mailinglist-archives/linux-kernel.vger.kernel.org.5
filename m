Return-Path: <linux-kernel+bounces-25389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B0182CF80
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37111F21EB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 02:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2317CA;
	Sun, 14 Jan 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhnUDW1w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEF1102
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705201171; x=1736737171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r0HURhWCvZPblGXSVB0Zz+wbbsEEkCWKa57k4tOfoDc=;
  b=OhnUDW1wo4cF2hq4KmIPcGQuNWYnSNqQC61Epd4UfwWWaepbCvqGqAky
   5l4FKXKt8nft3wMWdlkEbg2QzvkmoC/ojJzrdi/eZaOrmR78oYsHsLQZ1
   lLwo99CbcXzxCLseCsCWObvAhlQgcgeFRWiP+n/0j/5VOU4LeLKxv1Rj/
   4qatceVRTdRf8EpixbPX6egWVNEY1VXpJLqAjlxfNsn/fcqD96vkL4q2q
   15BErIO5lazsF2VgGZxQ3OutqQ38l6uvw6EJU8oyiO8OstAQUw5oxNU9D
   ch7CJQoPwJHIiK+5Q/Q8cvJPXzgXsx5qEBuiBcJOwnryumnbCUyHv3Vzk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="20906260"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="20906260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 18:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="817480135"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="817480135"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2024 18:59:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOqic-000B8i-0G;
	Sun, 14 Jan 2024 02:59:26 +0000
Date: Sun, 14 Jan 2024 10:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: wx_ethtool.c:undefined reference to `phylink_ethtool_get_pauseparam'
Message-ID: <202401141033.L4W51adl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 2fe2ca09da953bac778eab5dfb309b4e7d274b1a net: wangxun: add flow control support
date:   10 days ago
config: loongarch-randconfig-001-20240111 (https://download.01.org/0day-ci/archive/20240114/202401141033.L4W51adl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401141033.L4W51adl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401141033.L4W51adl-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
   wx_ethtool.c:(.text+0x3ac): undefined reference to `phylink_ethtool_nway_reset'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_link_ksettings':
   wx_ethtool.c:(.text+0x3b4): undefined reference to `phylink_ethtool_ksettings_get'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
   wx_ethtool.c:(.text+0x3bc): undefined reference to `phylink_ethtool_ksettings_set'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':
>> wx_ethtool.c:(.text+0x3c4): undefined reference to `phylink_ethtool_get_pauseparam'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
>> wx_ethtool.c:(.text+0x3cc): undefined reference to `phylink_ethtool_set_pauseparam'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_close':
   ngbe_main.c:(.text+0x48): undefined reference to `phylink_stop'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `.L10':
   ngbe_main.c:(.text+0x1d8): undefined reference to `phylink_disconnect_phy'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `.L94':
   ngbe_main.c:(.text+0x748): undefined reference to `phylink_connect_phy'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `.L109':
   ngbe_main.c:(.text+0x814): undefined reference to `phylink_start'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `.L102':
   ngbe_main.c:(.text+0x820): undefined reference to `phylink_disconnect_phy'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_remove':
   ngbe_main.c:(.text+0x980): undefined reference to `phylink_destroy'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `.L185':
   ngbe_main.c:(.text+0xf20): undefined reference to `phylink_destroy'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.o: in function `.L46':
   ngbe_mdio.c:(.text+0x2f4): undefined reference to `phylink_create'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

