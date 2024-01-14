Return-Path: <linux-kernel+bounces-25546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E243A82D22D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840951F21342
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080B1A287;
	Sun, 14 Jan 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqQlo+ga"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B1A27C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705271150; x=1736807150;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EY/5tEsd72MPhSsMUeIk31z7C3USkNnadaouy7F6oVo=;
  b=jqQlo+gaCkY2MzsgXMJoZsSpOD3p14AeuUQqAcI88Yqkh2/QH4L8C1qN
   0g51nPb+LqS4ScoMKcT3mMVxvrnb/vXP9Ml9JdRLxKD4w0VFASMAoNYNq
   qERNh+nu6HoMVPg432v7gjMhuJnGkTXZ5blA2iW4PEi6BlNWsO2ws9/No
   f+ydymMXeLg4ol7Oe7frC2sqJxLXu2kKRz87ZgIk8RxSxyJo06sxdjBFA
   T+xER+LOpiCK92D7JXLiHbQekje5aBwhTUuksHNgzrNGj2AILvanW74iD
   2cCftOdE53WMhznDpjAoZDSOaQ8dP+FSiO4pMkxI9Paam8AXVwEFv6744
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="18097622"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="18097622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 14:25:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114749662"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="1114749662"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2024 14:25:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rP8vK-000Bsi-1T;
	Sun, 14 Jan 2024 22:25:46 +0000
Date: Mon, 15 Jan 2024 06:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:433:undefined
 reference to `phylink_disconnect_phy'
Message-ID: <202401150644.ZJlVhPCe-lkp@intel.com>
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
commit: 883b5984a5d2900468af5ab979cae90547a78da4 net: wangxun: add ethtool_ops for ring parameters
date:   11 days ago
config: s390-randconfig-r032-20230101 (https://download.01.org/0day-ci/archive/20240115/202401150644.ZJlVhPCe-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401150644.ZJlVhPCe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401150644.ZJlVhPCe-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:193:(.text+0x76e): undefined reference to `phylink_ethtool_nway_reset'
   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_link_ksettings':
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:202:(.text+0x7b6): undefined reference to `phylink_ethtool_ksettings_get'
   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:211:(.text+0x7fe): undefined reference to `phylink_ethtool_ksettings_set'
   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:220:(.text+0x846): undefined reference to `phylink_ethtool_get_pauseparam'
   s390-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:229:(.text+0x88e): undefined reference to `phylink_ethtool_set_pauseparam'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_remove':
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:714:(.text+0x432): undefined reference to `phylink_destroy'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_probe':
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:684:(.text+0xd04): undefined reference to `phylink_destroy'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_down':
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:339:(.text+0xe18): undefined reference to `phylink_stop'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_close':
>> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:433:(.text+0x1090): undefined reference to `phylink_disconnect_phy'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_up':
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:362:(.text+0x1368): undefined reference to `phylink_start'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_open':
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:391:(.text+0x14e2): undefined reference to `phylink_connect_phy'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:407:(.text+0x16ce): undefined reference to `phylink_disconnect_phy'
   s390-linux-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.o: in function `ngbe_mdio_init':
   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c:130:(.text+0x5e2): undefined reference to `phylink_create'


vim +433 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

02338c484ab625 Mengyuan Lou 2022-10-31  414  
02338c484ab625 Mengyuan Lou 2022-10-31  415  /**
02338c484ab625 Mengyuan Lou 2022-10-31  416   * ngbe_close - Disables a network interface
02338c484ab625 Mengyuan Lou 2022-10-31  417   * @netdev: network interface device structure
02338c484ab625 Mengyuan Lou 2022-10-31  418   *
02338c484ab625 Mengyuan Lou 2022-10-31  419   * Returns 0, this is not allowed to fail
02338c484ab625 Mengyuan Lou 2022-10-31  420   *
02338c484ab625 Mengyuan Lou 2022-10-31  421   * The close entry point is called when an interface is de-activated
02338c484ab625 Mengyuan Lou 2022-10-31  422   * by the OS.  The hardware is still under the drivers control, but
02338c484ab625 Mengyuan Lou 2022-10-31  423   * needs to be disabled.  A global MAC reset is issued to stop the
02338c484ab625 Mengyuan Lou 2022-10-31  424   * hardware, and all transmit and receive resources are freed.
02338c484ab625 Mengyuan Lou 2022-10-31  425   **/
02338c484ab625 Mengyuan Lou 2022-10-31  426  static int ngbe_close(struct net_device *netdev)
02338c484ab625 Mengyuan Lou 2022-10-31  427  {
803df55d32eafb Mengyuan Lou 2023-01-06  428  	struct wx *wx = netdev_priv(netdev);
02338c484ab625 Mengyuan Lou 2022-10-31  429  
803df55d32eafb Mengyuan Lou 2023-01-06  430  	ngbe_down(wx);
e7956139a6cf9a Mengyuan Lou 2023-02-03  431  	wx_free_irq(wx);
b97f955ec47b49 Mengyuan Lou 2023-02-03  432  	wx_free_resources(wx);
bc2426d74aa35c Jiawen Wu    2024-01-03 @433  	phylink_disconnect_phy(wx->phylink);
803df55d32eafb Mengyuan Lou 2023-01-06  434  	wx_control_hw(wx, false);
02338c484ab625 Mengyuan Lou 2022-10-31  435  
02338c484ab625 Mengyuan Lou 2022-10-31  436  	return 0;
02338c484ab625 Mengyuan Lou 2022-10-31  437  }
02338c484ab625 Mengyuan Lou 2022-10-31  438  

:::::: The code at line 433 was first introduced by commit
:::::: bc2426d74aa35cd8ec9c97a253ef57c2c5cd730c net: ngbe: convert phylib to phylink

:::::: TO: Jiawen Wu <jiawenwu@trustnetic.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

