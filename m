Return-Path: <linux-kernel+bounces-133085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D8899E90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6798CB22FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92016D9C5;
	Fri,  5 Apr 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz6pdurY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53A16E890;
	Fri,  5 Apr 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324373; cv=none; b=HdYA+5DzGuasTjmNNDwp0M9dwNng3YKmlxOJ9f4iRprpgO572uXc0148gLL97xjD8hFLJWq/XVcA/kK/MIkAaF3SljPxGCbUgx9MuG/t4eyoLJ6/8WFWJnZLdRwM5PRSOIYK55rkkNlEGymY/rZYLC2COhjbLjKfFP2qUEZrJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324373; c=relaxed/simple;
	bh=hjPVp3pOEhVylvVm83FPY56nrnr6E+uOIFZ05QksjPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZniN5zfgQsna+3UmdUu3OcgGjLYaku3F2ksgIbPH2UU8KdeQrUu23mPVdI501thZBKFMmheZp9fOUnunKmg1nyYvgncox6PmOUWpgRND5SsHROB75xD5XqRGvay8A5KhWP7z5UgM8KhnINCCBaRIFupk7jSKcMK2pll8k3Xxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz6pdurY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324371; x=1743860371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hjPVp3pOEhVylvVm83FPY56nrnr6E+uOIFZ05QksjPY=;
  b=Mz6pdurYfvYLMCLO5uhLPYblvR2B0j+07LicJOUGNOMVYxmAjuX0zwQn
   P7m/2vA4laytA7NbrcLBNpD5rNJgsZXN7TDrI8Ncg/XSDsXemzQtB0Ww+
   Mak3z21RxizYd9LWYWCt5ukdl0vDIPnrVU3Pa2y1feqeQAC3Pf9mjA3GZ
   X1x93dJ5Cx8v2kZErF+LtriwReZ7lAcl+JYK2NZtvkiez0V0MiqAS4X/f
   KYH+iz4V4SVI7Gy2oVZvp0lFTn7fUU8ddnmwq3faD4zhNWJX/vbJGcak3
   LvCsvbY5sauiDOHtic3oSkXJOu7H5m2ZYnurxy3Rx4Ofnv/LTe/ZOv4jq
   g==;
X-CSE-ConnectionGUID: uNnD0a9rRNmD8AzRm7TBOw==
X-CSE-MsgGUID: PEopgYX0RNuPBGvVNAueIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219617"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219617"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:30 -0700
X-CSE-ConnectionGUID: qVYAbEpGTT2OaJoCyoaUvg==
X-CSE-MsgGUID: x0nJzc7wSReMW446RLY/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600148"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:27 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 6/7] netdev_features: convert NETIF_F_VLAN_CHALLENGED to IFF_VLAN_CHALLENGED
Date: Fri,  5 Apr 2024 15:37:30 +0200
Message-ID: <20240405133731.1010128-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inability to handle VLAN-tagged packets is more of an attribute, not
a feature.
Convert it to a private flag and add it to IFF_ONE_FOR_ALL with special
handling in netdev_increment_priv_flags() as it previously was in
netdev_increment_features().
Note that starting from this change, ETHTOOL_A_FEATURES_NOCHANGE
will always return 0 to userspace as there's no more
NETIF_F_NEVER_CHANGE.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/ethtool-netlink.rst |  2 +-
 Documentation/networking/netdev-features.rst | 11 +----------
 include/linux/netdev_features.h              | 12 +++---------
 include/linux/netdevice.h                    |  4 +++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c    |  3 +--
 drivers/net/bonding/bond_main.c              | 12 ++++++------
 drivers/net/ethernet/intel/e100.c            |  2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |  3 +--
 drivers/net/ethernet/wiznet/w5100.c          |  2 +-
 drivers/net/ethernet/wiznet/w5300.c          |  2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c  |  1 -
 drivers/net/ipvlan/ipvlan_main.c             | 10 ++++------
 drivers/net/loopback.c                       |  2 +-
 drivers/net/net_failover.c                   |  2 +-
 drivers/net/team/team_core.c                 |  2 +-
 drivers/net/vrf.c                            |  5 ++---
 drivers/net/wwan/t7xx/t7xx_netdev.c          |  3 +--
 drivers/s390/net/qeth_l2_main.c              |  2 +-
 net/8021q/vlan.c                             |  2 +-
 net/core/dev.c                               |  3 ++-
 net/ethtool/common.c                         |  1 -
 net/ethtool/features.c                       |  2 +-
 net/ethtool/ioctl.c                          |  3 +--
 net/hsr/hsr_device.c                         | 10 ++++------
 24 files changed, 39 insertions(+), 62 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9abf2f8..eff6a6a09ce2 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -756,7 +756,7 @@ Kernel response contents:
   ``ETHTOOL_A_FEATURES_HW``             bitset  dev->hw_features
   ``ETHTOOL_A_FEATURES_WANTED``         bitset  dev->wanted_features
   ``ETHTOOL_A_FEATURES_ACTIVE``         bitset  dev->features
-  ``ETHTOOL_A_FEATURES_NOCHANGE``       bitset  NETIF_F_NEVER_CHANGE
+  ``ETHTOOL_A_FEATURES_NOCHANGE``       bitset  0
   ====================================  ======  ==========================
 
 Bitmaps in kernel response have the same meaning as bitmaps used in ioctl
diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index b95c9203b1aa..25150c955c50 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -82,9 +82,7 @@ This callback should not modify hardware nor driver state (should be
 stateless).  It can be called multiple times between successive
 ndo_set_features calls.
 
-Callback must not alter features contained in NETIF_F_SOFT_FEATURES or
-NETIF_F_NEVER_CHANGE sets. The exception is NETIF_F_VLAN_CHALLENGED but
-care must be taken as the change won't affect already configured VLANs.
+Callback must not alter features contained in NETIF_F_SOFT_FEATURES.
 
  * ndo_set_features:
 
@@ -134,13 +132,6 @@ chained skbs (skb->next/prev list).
 Features contained in NETIF_F_SOFT_FEATURES are features of networking
 stack. Driver should not change behaviour based on them.
 
- * VLAN challenged
-
-NETIF_F_VLAN_CHALLENGED should be set for devices which can't cope with VLAN
-headers. Some drivers set this because the cards can't handle the bigger MTU.
-[FIXME: Those cases could be fixed in VLAN code by allowing only reduced-MTU
-VLANs. This may be not useful, though.]
-
 *  rx-fcs
 
 This requests that the NIC append the Ethernet Frame Checksum (FCS)
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index b8e4c7f79e88..318c35c94305 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -20,7 +20,6 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_TX_BIT,	/* Transmit VLAN CTAG HW acceleration */
 	NETIF_F_HW_VLAN_CTAG_RX_BIT,	/* Receive VLAN CTAG HW acceleration */
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
-	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
@@ -125,7 +124,6 @@ enum {
 #define NETIF_F_TSO6		__NETIF_F(TSO6)
 #define NETIF_F_TSO_ECN		__NETIF_F(TSO_ECN)
 #define NETIF_F_TSO		__NETIF_F(TSO)
-#define NETIF_F_VLAN_CHALLENGED	__NETIF_F(VLAN_CHALLENGED)
 #define NETIF_F_RXFCS		__NETIF_F(RXFCS)
 #define NETIF_F_RXALL		__NETIF_F(RXALL)
 #define NETIF_F_GSO_GRE		__NETIF_F(GSO_GRE)
@@ -184,12 +182,9 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
-#define NETIF_F_NEVER_CHANGE	NETIF_F_VLAN_CHALLENGED
-
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
-#define NETIF_F_ETHTOOL_BITS	((__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
-		(__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) - 1)) & \
-		~NETIF_F_NEVER_CHANGE)
+#define NETIF_F_ETHTOOL_BITS	(__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
+		(__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) - 1))
 
 /* Segmentation offload feature mask */
 #define NETIF_F_GSO_MASK	(__NETIF_F_BIT(NETIF_F_GSO_LAST + 1) - \
@@ -217,8 +212,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
  * for all in netdev_increment_features.
  */
 #define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ROBUST | \
-				 NETIF_F_SG | NETIF_F_FRAGLIST | \
-				 NETIF_F_VLAN_CHALLENGED)
+				 NETIF_F_SG | NETIF_F_FRAGLIST)
 
 /*
  * If one device doesn't support one of these features, then disable it
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 622d135957ad..57b8d3783b3f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1653,6 +1653,7 @@ struct net_device_ops {
  *	such as tunnels.
  * @IFF_NETNS_LOCAL: interface can't change network namespaces
  * @IFF_HIGHDMA: device can transmit buffers from high memory
+ * @IFF_VLAN_CHALLENGED: device can't handle VLAN packets
  * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
  *	interfaces to avoid overhead from locking and Qdisc.
  * @IFF_ONE_FOR_ALL: if one interface supports them, enable them for all in
@@ -1698,8 +1699,9 @@ enum netdev_priv_flags {
 	IFF_LLTX			= BIT_ULL(34),
 	IFF_NETNS_LOCAL			= BIT_ULL(35),
 	IFF_HIGHDMA			= BIT_ULL(36),
+	IFF_VLAN_CHALLENGED		= BIT_ULL(37),
 	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
-	IFF_ONE_FOR_ALL			= IFF_HIGHDMA,
+	IFF_ONE_FOR_ALL			= IFF_HIGHDMA | IFF_VLAN_CHALLENGED,
 	IFF_ALL_FOR_ALL			= IFF_XMIT_DST_RELEASE |
 					  IFF_XMIT_DST_RELEASE_PERM,
 };
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 888fb9c62f91..3c9db03c56a3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2142,13 +2142,12 @@ void ipoib_setup_common(struct net_device *dev)
 	dev->watchdog_timeo	 = 10 * HZ;
 
 	dev->flags		|= IFF_BROADCAST | IFF_MULTICAST;
-	dev->priv_flags		|= IFF_HIGHDMA;
+	dev->priv_flags		|= IFF_HIGHDMA | IFF_VLAN_CHALLENGED;
 
 	dev->hard_header_len	 = IPOIB_HARD_LEN;
 	dev->addr_len		 = INFINIBAND_ALEN;
 	dev->type		 = ARPHRD_INFINIBAND;
 	dev->tx_queue_len	 = ipoib_sendq_size * 2;
-	dev->features		 = NETIF_F_VLAN_CHALLENGED;
 	netif_keep_dst(dev);
 
 	memcpy(dev->broadcast, ipv4_bcast_addr, INFINIBAND_ALEN);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index cebf1189241c..1de5efbde227 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1864,8 +1864,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	/* vlan challenged mutual exclusion */
 	/* no need to lock since we're protected by rtnl_lock */
-	if (slave_dev->features & NETIF_F_VLAN_CHALLENGED) {
-		slave_dbg(bond_dev, slave_dev, "is NETIF_F_VLAN_CHALLENGED\n");
+	if (slave_dev->priv_flags & IFF_VLAN_CHALLENGED) {
+		slave_dbg(bond_dev, slave_dev, "is IFF_VLAN_CHALLENGED\n");
 		if (vlan_uses_dev(bond_dev)) {
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Can not enslave VLAN challenged device to VLAN enabled bond");
@@ -1874,7 +1874,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			slave_warn(bond_dev, slave_dev, "enslaved VLAN challenged slave. Adding VLANs will be blocked as long as it is part of bond.\n");
 		}
 	} else {
-		slave_dbg(bond_dev, slave_dev, "is !NETIF_F_VLAN_CHALLENGED\n");
+		slave_dbg(bond_dev, slave_dev, "is !IFF_VLAN_CHALLENGED\n");
 	}
 
 	if (slave_dev->features & NETIF_F_HW_ESP)
@@ -2363,10 +2363,10 @@ static int __bond_release_one(struct net_device *bond_dev,
 			      bool all, bool unregister)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
+	u64 old_priv_flags = bond_dev->priv_flags;
 	struct slave *slave, *oldcurrent;
 	struct sockaddr_storage ss;
 	int old_flags = bond_dev->flags;
-	netdev_features_t old_features = bond_dev->features;
 
 	/* slave is not a slave or master is not master of this slave */
 	if (!(slave_dev->flags & IFF_SLAVE) ||
@@ -2470,8 +2470,8 @@ static int __bond_release_one(struct net_device *bond_dev,
 	}
 
 	bond_compute_features(bond);
-	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
-	    (old_features & NETIF_F_VLAN_CHALLENGED))
+	if (!(bond_dev->priv_flags & IFF_VLAN_CHALLENGED) &&
+	    (old_priv_flags & IFF_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
 
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9b068d40778d..6a57c0d5072d 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2893,7 +2893,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* D100 MAC doesn't allow rx of vlan packets with normal MTU */
 	if (nic->mac < mac_82558_D101_A4)
-		netdev->features |= NETIF_F_VLAN_CHALLENGED;
+		netdev->priv_flags |= IFF_VLAN_CHALLENGED;
 
 	/* locks must be initialized before calling hw_reset */
 	spin_lock_init(&nic->cb_lock);
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 5ee8e8980393..3aa351b8f877 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -1499,7 +1499,7 @@ int gelic_net_setup_netdev(struct net_device *netdev, struct gelic_card *card)
 		 * As vlan is internally used,
 		 * we can not receive vlan packets
 		 */
-		netdev->features |= NETIF_F_VLAN_CHALLENGED;
+		netdev->priv_flags |= IFF_VLAN_CHALLENGED;
 	}
 
 	/* MTU range: 64 - 1518 */
@@ -1885,4 +1885,3 @@ module_init(ps3_gelic_driver_init);
 module_exit(ps3_gelic_driver_exit);
 
 MODULE_ALIAS(PS3_MODULE_ALIAS_GELIC);
-
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index b26fd15c25ae..a1c4f312387d 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -1136,7 +1136,7 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
 	/* This chip doesn't support VLAN packets with normal MTU,
 	 * so disable VLAN for this device.
 	 */
-	ndev->features |= NETIF_F_VLAN_CHALLENGED;
+	ndev->priv_flags |= IFF_VLAN_CHALLENGED;
 
 	err = register_netdev(ndev);
 	if (err < 0)
diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index f165616f36fe..2a741d604eb1 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -607,7 +607,7 @@ static int w5300_probe(struct platform_device *pdev)
 	/* This chip doesn't support VLAN packets with normal MTU,
 	 * so disable VLAN for this device.
 	 */
-	ndev->features |= NETIF_F_VLAN_CHALLENGED;
+	ndev->priv_flags |= IFF_VLAN_CHALLENGED;
 
 	err = register_netdev(ndev);
 	if (err < 0)
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 09aa5c87e9c3..d6cec0a216ad 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1408,7 +1408,6 @@ static int temac_probe(struct platform_device *pdev)
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_TX; /* Transmit VLAN hw accel */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX; /* Receive VLAN hw acceleration */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER; /* Receive VLAN filtering */
-	ndev->features |= NETIF_F_VLAN_CHALLENGED; /* cannot handle VLAN pkts */
 	ndev->features |= NETIF_F_GSO; /* Enable software GSO. */
 	ndev->features |= NETIF_F_MULTI_QUEUE; /* Has multiple TX/RX queues */
 	ndev->features |= NETIF_F_LRO; /* large receive offload */
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 62b4372dc205..98537ec29885 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -113,9 +113,6 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	(NETIF_F_SG | NETIF_F_HW_CSUM | \
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL)
 
-#define IPVLAN_ALWAYS_ON \
-	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_VLAN_CHALLENGED)
-
 #define IPVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST | \
 	 NETIF_F_GSO | NETIF_F_ALL_TSO | NETIF_F_GSO_ROBUST | \
@@ -137,11 +134,12 @@ static int ipvlan_init(struct net_device *dev)
 	dev->state = (dev->state & ~IPVLAN_STATE_MASK) |
 		     (phy_dev->state & IPVLAN_STATE_MASK);
 	dev->features = phy_dev->features & IPVLAN_FEATURES;
-	dev->features |= IPVLAN_ALWAYS_ON;
+	dev->features |= IPVLAN_ALWAYS_ON_OFLOADS;
 	dev->vlan_features = phy_dev->vlan_features & IPVLAN_FEATURES;
 	dev->vlan_features |= IPVLAN_ALWAYS_ON_OFLOADS;
 	dev->hw_enc_features |= dev->features;
 	dev->priv_flags |= IFF_LLTX | (phy_dev->priv_flags & IFF_HIGHDMA);
+	dev->priv_flags |= IFF_VLAN_CHALLENGED;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
 
@@ -245,8 +243,8 @@ static netdev_features_t ipvlan_fix_features(struct net_device *dev,
 	features &= (ipvlan->sfeatures | ~IPVLAN_FEATURES);
 	features = netdev_increment_features(ipvlan->phy_dev->features,
 					     features, features);
-	features |= IPVLAN_ALWAYS_ON;
-	features &= (IPVLAN_FEATURES | IPVLAN_ALWAYS_ON);
+	features |= IPVLAN_ALWAYS_ON_OFLOADS;
+	features &= (IPVLAN_FEATURES | IPVLAN_ALWAYS_ON_OFLOADS);
 
 	return features;
 }
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index a9ca447774ec..0a60bd1cc42a 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -176,6 +176,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
 	dev->priv_flags		|= IFF_NETNS_LOCAL | IFF_HIGHDMA;
+	dev->priv_flags		|= IFF_VLAN_CHALLENGED;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -183,7 +184,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_HW_CSUM
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
-		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
 	dev->ethtool_ops	= eth_ops;
 	dev->header_ops		= hdr_ops;
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 53e6e05939fa..0862f24651f6 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -487,7 +487,7 @@ static int net_failover_slave_pre_register(struct net_device *slave_dev,
 				  !dev_is_pci(slave_dev->dev.parent)))
 		return -EINVAL;
 
-	if (failover_dev->features & NETIF_F_VLAN_CHALLENGED &&
+	if (failover_dev->priv_flags & IFF_VLAN_CHALLENGED &&
 	    vlan_uses_dev(failover_dev)) {
 		netdev_err(failover_dev, "Device %s is VLAN challenged and failover device has VLAN set up\n",
 			   failover_dev->name);
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4393f94838c7..af39e8a9c91f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1172,7 +1172,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EBUSY;
 	}
 
-	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
+	if (port_dev->priv_flags & IFF_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
 		netdev_err(dev, "Device %s is VLAN challenged and team device has VLAN set up\n",
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 9f83061e3f86..0600600a8aa1 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1655,9 +1655,6 @@ static void vrf_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	eth_hw_addr_random(dev);
 
-	/* does not make sense for a VLAN to be added to a vrf device */
-	dev->features   |= NETIF_F_VLAN_CHALLENGED;
-
 	/* enable offload features */
 	dev->features   |= NETIF_F_GSO_SOFTWARE;
 	dev->features   |= NETIF_F_RXCSUM | NETIF_F_HW_CSUM | NETIF_F_SCTP_CRC;
@@ -1670,6 +1667,8 @@ static void vrf_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_HIGHDMA;
+	/* does not make sense for a VLAN to be added to a vrf device */
+	dev->priv_flags |= IFF_VLAN_CHALLENGED;
 
 	/* VRF devices do not care about MTU, but if the MTU is set
 	 * too low then the ipv4 and ipv6 protocols are disabled
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 3ef4a8a4f8fd..4fec45a5ac47 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -231,8 +231,7 @@ static void t7xx_ccmni_wwan_setup(struct net_device *dev)
 	dev->watchdog_timeo = CCMNI_NETDEV_WDT_TO;
 
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-
-	dev->features = NETIF_F_VLAN_CHALLENGED;
+	dev->priv_flags |= IFF_VLAN_CHALLENGED;
 
 	dev->features |= NETIF_F_SG;
 	dev->hw_features |= NETIF_F_SG;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 75910c0bcc2b..89c6e063fd6a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1093,7 +1093,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
 
 	if (IS_OSM(card)) {
-		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
+		card->dev->priv_flags |= IFF_VLAN_CHALLENGED;
 	} else {
 		if (!IS_VM_NIC(card))
 			card->dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e45187b88220..a414b1b82673 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -131,7 +131,7 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->priv_flags & IFF_VLAN_CHALLENGED) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
diff --git a/net/core/dev.c b/net/core/dev.c
index 2e20db77d5d6..df56e9f25018 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11484,7 +11484,6 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 {
 	if (mask & NETIF_F_HW_CSUM)
 		mask |= NETIF_F_CSUM_MASK;
-	mask |= NETIF_F_VLAN_CHALLENGED;
 
 	all |= one & (NETIF_F_ONE_FOR_ALL | NETIF_F_CSUM_MASK) & mask;
 	all &= one | ~NETIF_F_ALL_FOR_ALL;
@@ -11499,6 +11498,8 @@ EXPORT_SYMBOL(netdev_increment_features);
 
 u64 netdev_increment_priv_flags(u64 all, u64 one, u64 mask)
 {
+	mask |= IFF_VLAN_CHALLENGED;
+
 	all |= one & IFF_ONE_FOR_ALL & mask;
 	all &= one | ~IFF_ALL_FOR_ALL;
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 64c736e897e9..2de4dd5a30de 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -21,7 +21,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_VLAN_STAG_TX_BIT] =  "tx-vlan-stag-hw-insert",
 	[NETIF_F_HW_VLAN_STAG_RX_BIT] =  "rx-vlan-stag-hw-parse",
 	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
-	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
 	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
 	[NETIF_F_GRO_BIT] =              "rx-gro",
 	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index b6cb101d7f19..652759407f00 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -44,7 +44,7 @@ static int features_prepare_data(const struct ethnl_req_info *req_base,
 	ethnl_features_to_bitmap32(data->hw, dev->hw_features);
 	ethnl_features_to_bitmap32(data->wanted, dev->wanted_features);
 	ethnl_features_to_bitmap32(data->active, dev->features);
-	ethnl_features_to_bitmap32(data->nochange, NETIF_F_NEVER_CHANGE);
+	ethnl_features_to_bitmap32(data->nochange, 0);
 	all_features = GENMASK_ULL(NETDEV_FEATURE_COUNT - 1, 0);
 	ethnl_features_to_bitmap32(data->all, all_features);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..2a20d7f70ffd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -96,8 +96,7 @@ static int ethtool_get_features(struct net_device *dev, void __user *useraddr)
 		features[i].available = (u32)(dev->hw_features >> (32 * i));
 		features[i].requested = (u32)(dev->wanted_features >> (32 * i));
 		features[i].active = (u32)(dev->features >> (32 * i));
-		features[i].never_changed =
-			(u32)(NETIF_F_NEVER_CHANGE >> (32 * i));
+		features[i].never_changed = 0;
 	}
 
 	sizeaddr = useraddr + offsetof(struct ethtool_gfeatures, size);
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index be1df345b841..4561a087e75d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -499,7 +499,10 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
 	dev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL | IFF_NETNS_LOCAL;
-	dev->priv_flags |= IFF_HIGHDMA;
+	/* VLAN on top of HSR needs testing and probably some work on
+	 * hsr_header_create() etc.
+	 */
+	dev->priv_flags |= IFF_HIGHDMA | IFF_VLAN_CHALLENGED;
 
 	dev->needs_free_netdev = true;
 
@@ -508,11 +511,6 @@ void hsr_dev_setup(struct net_device *dev)
 			   NETIF_F_HW_VLAN_CTAG_TX;
 
 	dev->features = dev->hw_features;
-
-	/* VLAN on top of HSR needs testing and probably some work on
-	 * hsr_header_create() etc.
-	 */
-	dev->features |= NETIF_F_VLAN_CHALLENGED;
 }
 
 /* Return true if dev is a HSR master; return false otherwise.
-- 
2.44.0


