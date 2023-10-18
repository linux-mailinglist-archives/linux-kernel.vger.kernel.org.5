Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E67CE06D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjJROyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjJROyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:54:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEABEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697640844; x=1729176844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ch037SdgEfWW6A5AilP30fpS6HMwXYGXqO9W83Cx+yc=;
  b=Y0QuGM4X+KAl7yZpVBk27rij/mqH2oYd166/9TjKM29WdHliPpgdmPno
   C4Wk/J7BMFJBUujI1Ws+axR5kLrW+Sfiac2msJgfnifX0V0vdI5+pxFsE
   +vJW0qtR1FpzDVipRU2JZZR2NK+GWroGQNNe+QkHYUL8et9hFoD/mLPxS
   sggiYtva4YYbp8hNENi6qRbVVK8LEvMCkkvRFbDeVODjlSZSccZO8g9KU
   STwpP2aDpOzSnu19pByFgDYxgoVkoZJ70neoFNl2AgUjOsLzQkC/BqrhT
   oWKsMcjJxwpEqmHVq5vFhkxhE+OZuBspwVU6BN0poCcw9r0r7EB9BLWLf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472255006"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472255006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="785954091"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="785954091"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2023 07:54:02 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt7vr-0000Xo-2E;
        Wed, 18 Oct 2023 14:53:59 +0000
Date:   Wed, 18 Oct 2023 22:53:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/ti/netcp_core.c:1594:47: warning: '%s'
 directive output may be truncated writing up to 15 bytes into a region of
 size 8
Message-ID: <202310182209.afvozfWB-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 6 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20231018/202310182209.afvozfWB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182209.afvozfWB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182209.afvozfWB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/ti/netcp_core.c: In function 'netcp_setup_navigator_resources':
>> drivers/net/ethernet/ti/netcp_core.c:1594:47: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size 8 [-Wformat-truncation=]
    1594 |         snprintf(name, sizeof(name), "rx-pool-%s", ndev->name);
         |                                               ^~
   drivers/net/ethernet/ti/netcp_core.c:1594:9: note: 'snprintf' output between 9 and 24 bytes into a destination of size 16
    1594 |         snprintf(name, sizeof(name), "rx-pool-%s", ndev->name);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/ti/netcp_core.c:1603:47: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size 8 [-Wformat-truncation=]
    1603 |         snprintf(name, sizeof(name), "tx-pool-%s", ndev->name);
         |                                               ^~
   drivers/net/ethernet/ti/netcp_core.c:1603:9: note: 'snprintf' output between 9 and 24 bytes into a destination of size 16
    1603 |         snprintf(name, sizeof(name), "tx-pool-%s", ndev->name);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/ti/netcp_core.c:1613:48: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size 7 [-Wformat-truncation=]
    1613 |         snprintf(name, sizeof(name), "tx-compl-%s", ndev->name);
         |                                                ^~
   drivers/net/ethernet/ti/netcp_core.c:1613:9: note: 'snprintf' output between 10 and 25 bytes into a destination of size 16
    1613 |         snprintf(name, sizeof(name), "tx-compl-%s", ndev->name);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/ti/netcp_core.c:1633:48: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size 7 [-Wformat-truncation=]
    1633 |         snprintf(name, sizeof(name), "rx-compl-%s", ndev->name);
         |                                                ^~
   drivers/net/ethernet/ti/netcp_core.c:1633:9: note: 'snprintf' output between 10 and 25 bytes into a destination of size 16
    1633 |         snprintf(name, sizeof(name), "rx-compl-%s", ndev->name);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/ti/netcp_core.c:1655:54: warning: '%s' directive output may be truncated writing up to 15 bytes into a region of size 9 [-Wformat-truncation=]
    1655 |                 snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
         |                                                      ^~
   drivers/net/ethernet/ti/netcp_core.c:1655:46: note: directive argument in the range [0, 3]
    1655 |                 snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
         |                                              ^~~~~~~~~~~~~~
   drivers/net/ethernet/ti/netcp_core.c:1655:17: note: 'snprintf' output between 10 and 25 bytes into a destination of size 16
    1655 |                 snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1594 drivers/net/ethernet/ti/netcp_core.c

84640e27f23041 Karicheri, Muralidharan 2015-01-15  1582  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1583  static int netcp_setup_navigator_resources(struct net_device *ndev)
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1584  {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1585  	struct netcp_intf *netcp = netdev_priv(ndev);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1586  	struct knav_queue_notify_config notify_cfg;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1587  	struct knav_dma_cfg config;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1588  	u32 last_fdq = 0;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1589  	u8 name[16];
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1590  	int ret;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1591  	int i;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1592  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1593  	/* Create Rx/Tx descriptor pools */
84640e27f23041 Karicheri, Muralidharan 2015-01-15 @1594  	snprintf(name, sizeof(name), "rx-pool-%s", ndev->name);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1595  	netcp->rx_pool = knav_pool_create(name, netcp->rx_pool_size,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1596  						netcp->rx_pool_region_id);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1597  	if (IS_ERR_OR_NULL(netcp->rx_pool)) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1598  		dev_err(netcp->ndev_dev, "Couldn't create rx pool\n");
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1599  		ret = PTR_ERR(netcp->rx_pool);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1600  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1601  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1602  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1603  	snprintf(name, sizeof(name), "tx-pool-%s", ndev->name);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1604  	netcp->tx_pool = knav_pool_create(name, netcp->tx_pool_size,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1605  						netcp->tx_pool_region_id);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1606  	if (IS_ERR_OR_NULL(netcp->tx_pool)) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1607  		dev_err(netcp->ndev_dev, "Couldn't create tx pool\n");
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1608  		ret = PTR_ERR(netcp->tx_pool);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1609  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1610  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1611  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1612  	/* open Tx completion queue */
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1613  	snprintf(name, sizeof(name), "tx-compl-%s", ndev->name);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1614  	netcp->tx_compl_q = knav_queue_open(name, netcp->tx_compl_qid, 0);
d01eb808c7b8bf Julia Lawall            2016-11-16  1615  	if (IS_ERR(netcp->tx_compl_q)) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1616  		ret = PTR_ERR(netcp->tx_compl_q);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1617  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1618  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1619  	netcp->tx_compl_qid = knav_queue_get_id(netcp->tx_compl_q);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1620  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1621  	/* Set notification for Tx completion */
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1622  	notify_cfg.fn = netcp_tx_notify;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1623  	notify_cfg.fn_arg = netcp;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1624  	ret = knav_queue_device_control(netcp->tx_compl_q,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1625  					KNAV_QUEUE_SET_NOTIFIER,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1626  					(unsigned long)&notify_cfg);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1627  	if (ret)
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1628  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1629  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1630  	knav_queue_disable_notify(netcp->tx_compl_q);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1631  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1632  	/* open Rx completion queue */
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1633  	snprintf(name, sizeof(name), "rx-compl-%s", ndev->name);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1634  	netcp->rx_queue = knav_queue_open(name, netcp->rx_queue_id, 0);
d01eb808c7b8bf Julia Lawall            2016-11-16  1635  	if (IS_ERR(netcp->rx_queue)) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1636  		ret = PTR_ERR(netcp->rx_queue);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1637  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1638  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1639  	netcp->rx_queue_id = knav_queue_get_id(netcp->rx_queue);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1640  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1641  	/* Set notification for Rx completion */
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1642  	notify_cfg.fn = netcp_rx_notify;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1643  	notify_cfg.fn_arg = netcp;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1644  	ret = knav_queue_device_control(netcp->rx_queue,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1645  					KNAV_QUEUE_SET_NOTIFIER,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1646  					(unsigned long)&notify_cfg);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1647  	if (ret)
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1648  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1649  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1650  	knav_queue_disable_notify(netcp->rx_queue);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1651  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1652  	/* open Rx FDQs */
866b8b18e380f8 WingMan Kwok            2015-08-04  1653  	for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN && netcp->rx_queue_depths[i];
866b8b18e380f8 WingMan Kwok            2015-08-04  1654  	     ++i) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1655  		snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1656  		netcp->rx_fdq[i] = knav_queue_open(name, KNAV_QUEUE_GP, 0);
d01eb808c7b8bf Julia Lawall            2016-11-16  1657  		if (IS_ERR(netcp->rx_fdq[i])) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1658  			ret = PTR_ERR(netcp->rx_fdq[i]);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1659  			goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1660  		}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1661  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1662  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1663  	memset(&config, 0, sizeof(config));
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1664  	config.direction		= DMA_DEV_TO_MEM;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1665  	config.u.rx.einfo_present	= true;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1666  	config.u.rx.psinfo_present	= true;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1667  	config.u.rx.err_mode		= DMA_DROP;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1668  	config.u.rx.desc_type		= DMA_DESC_HOST;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1669  	config.u.rx.psinfo_at_sop	= false;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1670  	config.u.rx.sop_offset		= NETCP_SOP_OFFSET;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1671  	config.u.rx.dst_q		= netcp->rx_queue_id;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1672  	config.u.rx.thresh		= DMA_THRESH_NONE;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1673  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1674  	for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN; ++i) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1675  		if (netcp->rx_fdq[i])
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1676  			last_fdq = knav_queue_get_id(netcp->rx_fdq[i]);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1677  		config.u.rx.fdq[i] = last_fdq;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1678  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1679  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1680  	netcp->rx_channel = knav_dma_open_channel(netcp->netcp_device->device,
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1681  					netcp->dma_chan_name, &config);
5b6cb43b4d625b Ivan Khoronzhuk         2017-05-10  1682  	if (IS_ERR(netcp->rx_channel)) {
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1683  		dev_err(netcp->ndev_dev, "failed opening rx chan(%s\n",
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1684  			netcp->dma_chan_name);
5b6cb43b4d625b Ivan Khoronzhuk         2017-05-10  1685  		ret = PTR_ERR(netcp->rx_channel);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1686  		goto fail;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1687  	}
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1688  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1689  	dev_dbg(netcp->ndev_dev, "opened RX channel: %p\n", netcp->rx_channel);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1690  	return 0;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1691  
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1692  fail:
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1693  	netcp_free_navigator_resources(netcp);
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1694  	return ret;
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1695  }
84640e27f23041 Karicheri, Muralidharan 2015-01-15  1696  

:::::: The code at line 1594 was first introduced by commit
:::::: 84640e27f23041d474c31d3362c3e2185ad68ec2 net: netcp: Add Keystone NetCP core ethernet driver

:::::: TO: Karicheri, Muralidharan <m-karicheri2@ti.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
