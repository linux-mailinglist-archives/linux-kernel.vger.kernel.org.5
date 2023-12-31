Return-Path: <linux-kernel+bounces-13629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B638209AC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC262B20F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 04:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FE186C;
	Sun, 31 Dec 2023 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS6aN9hp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F217F4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703996381; x=1735532381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zloXj5UX2LuWzrooN0OpYA0j0P+jbK9JU33GI2cucaE=;
  b=lS6aN9hpj2tPJvouo4vViLz6MWi9etKwxzfJrhe+eB6xNZK6YsUGO37s
   ZAR7oHUFG64elIQtHI/Vxug7/1K5gfAgeRiJ3QFsqeI3EKI+WwimmUHre
   /xF/KNdd/Z4hyH7QVV3twAP43H33iVih/9Hyi8ip4Q3rFb2OhA6x/nJh/
   u6MQsZyGRp0oA8j9jp/PO9kga+SxFK627QDAcywwcKaZ9f3ScXWGnaFd4
   a2tXjb/luazwnDWKBHS6YyLheCJk5IX7TCiA7fHdzUGDN1ANXEQWM880g
   4NdVgrVv193lKET1J2odv9ljA7vleIC53I46uAyLUUliRQNT0vDIzlk8D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="3574244"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="3574244"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 20:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="772280800"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="772280800"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2023 20:19:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJnIW-000Izp-0e;
	Sun, 31 Dec 2023 04:19:36 +0000
Date: Sun, 31 Dec 2023 12:18:48 +0800
From: kernel test robot <lkp@intel.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/ti/am65-cpsw-nuss.c:1640:55: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202312311235.NwNBzCd7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   453f5db0619e2ad64076aab16ff5a00e0f7c53a2
commit: 93a76530316a3d8cc2d82c3deca48424fee92100 net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver
date:   3 years, 9 months ago
config: arm64-randconfig-r123-20231231 (https://download.01.org/0day-ci/archive/20231231/202312311235.NwNBzCd7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231231/202312311235.NwNBzCd7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312311235.NwNBzCd7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:1640:55: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct am65_cpsw_ndev_stats [noderef] __percpu *stats @@     got void *data @@
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1640:55: sparse:     expected struct am65_cpsw_ndev_stats [noderef] __percpu *stats
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1640:55: sparse:     got void *data
>> drivers/net/ethernet/ti/am65-cpsw-nuss.c:1692:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got struct am65_cpsw_ndev_stats [noderef] __percpu *stats @@
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1692:49: sparse:     expected void *data
   drivers/net/ethernet/ti/am65-cpsw-nuss.c:1692:49: sparse:     got struct am65_cpsw_ndev_stats [noderef] __percpu *stats

vim +1640 drivers/net/ethernet/ti/am65-cpsw-nuss.c

  1637	
  1638	static void am65_cpsw_pcpu_stats_free(void *data)
  1639	{
> 1640		struct am65_cpsw_ndev_stats __percpu *stats = data;
  1641	
  1642		free_percpu(stats);
  1643	}
  1644	
  1645	static int am65_cpsw_nuss_init_ndev_2g(struct am65_cpsw_common *common)
  1646	{
  1647		struct am65_cpsw_ndev_priv *ndev_priv;
  1648		struct device *dev = common->dev;
  1649		struct am65_cpsw_port *port;
  1650		int ret;
  1651	
  1652		port = am65_common_get_port(common, 1);
  1653	
  1654		/* alloc netdev */
  1655		port->ndev = devm_alloc_etherdev_mqs(common->dev,
  1656						     sizeof(struct am65_cpsw_ndev_priv),
  1657						     AM65_CPSW_MAX_TX_QUEUES,
  1658						     AM65_CPSW_MAX_RX_QUEUES);
  1659		if (!port->ndev) {
  1660			dev_err(dev, "error allocating slave net_device %u\n",
  1661				port->port_id);
  1662			return -ENOMEM;
  1663		}
  1664	
  1665		ndev_priv = netdev_priv(port->ndev);
  1666		ndev_priv->port = port;
  1667		ndev_priv->msg_enable = AM65_CPSW_DEBUG;
  1668		SET_NETDEV_DEV(port->ndev, dev);
  1669	
  1670		ether_addr_copy(port->ndev->dev_addr, port->slave.mac_addr);
  1671	
  1672		port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
  1673		port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
  1674		port->ndev->hw_features = NETIF_F_SG |
  1675					  NETIF_F_RXCSUM |
  1676					  NETIF_F_HW_CSUM;
  1677		port->ndev->features = port->ndev->hw_features |
  1678				       NETIF_F_HW_VLAN_CTAG_FILTER;
  1679		port->ndev->vlan_features |=  NETIF_F_SG;
  1680		port->ndev->netdev_ops = &am65_cpsw_nuss_netdev_ops_2g;
  1681		port->ndev->ethtool_ops = &am65_cpsw_ethtool_ops_slave;
  1682	
  1683		/* Disable TX checksum offload by default due to HW bug */
  1684		if (common->pdata->quirks & AM65_CPSW_QUIRK_I2027_NO_TX_CSUM)
  1685			port->ndev->features &= ~NETIF_F_HW_CSUM;
  1686	
  1687		ndev_priv->stats = netdev_alloc_pcpu_stats(struct am65_cpsw_ndev_stats);
  1688		if (!ndev_priv->stats)
  1689			return -ENOMEM;
  1690	
  1691		ret = devm_add_action_or_reset(dev, am65_cpsw_pcpu_stats_free,
> 1692					       ndev_priv->stats);
  1693		if (ret) {
  1694			dev_err(dev, "failed to add percpu stat free action %d", ret);
  1695			return ret;
  1696		}
  1697	
  1698		netif_napi_add(port->ndev, &common->napi_rx,
  1699			       am65_cpsw_nuss_rx_poll, NAPI_POLL_WEIGHT);
  1700	
  1701		common->pf_p0_rx_ptype_rrobin = false;
  1702	
  1703		return ret;
  1704	}
  1705	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

