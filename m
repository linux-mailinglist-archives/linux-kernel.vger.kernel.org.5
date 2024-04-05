Return-Path: <linux-kernel+bounces-133083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C85899E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976E81F22F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D916E884;
	Fri,  5 Apr 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYxPWbeB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A916DEDB;
	Fri,  5 Apr 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324366; cv=none; b=dFl3ZaolJvb4juDGvJXm1fbaBPTZfgzagbgAvkQ24ATKWAiyG08Gtqf81DJ3edxjjaWNOOrW0OV43umfUuP1haKY8p048QtuSNR7iX/3F9mGKqzDa+dr+ezOJBeflsN1qSvggnhsgIfMbxuh7juxh4m2e5nJFlWmex7f/I4hucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324366; c=relaxed/simple;
	bh=BqMHsdz4qYp5Ly1eJnt7VC15ESa/Igs/2TBJQ2N9OM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzjgh4DPozCwpkpzuQdmv3zP12NJWpNxjxicVMWPUXVQ2MlqW+MSWUcf/62VApivJX1Z+GRgFan94dgeJzV9tWKN1tcvbWGlE29cGY9SVjDaf02QUOAPdO804oEABfVkcVhZNDgux4Bs2MfYVjjcPsCeULGDchTTqcfJ+vdYoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYxPWbeB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324364; x=1743860364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqMHsdz4qYp5Ly1eJnt7VC15ESa/Igs/2TBJQ2N9OM8=;
  b=YYxPWbeBktttFt6oY0C0q7r7QM1XEp6cX2XrJoqqFo0i8tJSVLJWNLmf
   ZBWx6HA1+3KDLLsTXS74El0OHPZXB4vt7Ao/vk5eiXkNRd/iaNY19e4wj
   NNwDdoPEbeKQ1vgQ7PURgntuB8T1YepbUBCCEplGxDQB7SY2hkYvzvnsk
   VQTF78vQ07s4tLw9pekQMv4C6fQHPWDrs5edHnJbLVBOKqo864uZh6WAY
   0N8QHbSEMsBlJ5NV+vHJa2ow0ttKnEXKfmVsELjlj/VpisjXEcAeJmrk8
   ivmF1k6frAVDO0jltwGDGwSyJcm5zGVjaxHGi5I5LmIm831WlH/UcHCxg
   w==;
X-CSE-ConnectionGUID: 5320jXZDTsydGZEHVl0QAA==
X-CSE-MsgGUID: FbW7w716SB2JUpoAc/kU9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219590"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:23 -0700
X-CSE-ConnectionGUID: /wZkKmDBSu6cSuu3/ZPhXA==
X-CSE-MsgGUID: bNGBYBi2QG+dV8epWEhPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600123"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:21 -0700
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
Subject: [PATCH RFC net-next 4/7] netdev_features: convert NETIF_F_NETNS_LOCAL to IFF_NETNS_LOCAL
Date: Fri,  5 Apr 2024 15:37:28 +0200
Message-ID: <20240405133731.1010128-5-aleksander.lobakin@intel.com>
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

"Interface can't change network namespaces" is rather an attribute,
not a feature, and it can't be changed via Ethtool.
Make it a private flag instead of a netdev_feature and free one more
bit.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/netdev-features.rst          |  7 -------
 Documentation/networking/switchdev.rst                |  4 ++--
 include/linux/netdev_features.h                       |  5 +----
 include/linux/netdevice.h                             |  2 ++
 drivers/net/amt.c                                     |  3 +--
 drivers/net/bonding/bond_main.c                       |  5 ++---
 drivers/net/ethernet/adi/adin1110.c                   |  3 +--
 drivers/net/ethernet/marvell/prestera/prestera_main.c |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c     |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c      |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |  6 +++---
 drivers/net/ethernet/rocker/rocker_main.c             |  3 ++-
 drivers/net/ethernet/ti/cpsw_new.c                    |  3 ++-
 drivers/net/loopback.c                                |  2 +-
 drivers/net/net_failover.c                            |  5 ++---
 drivers/net/team/team_core.c                          |  5 ++---
 drivers/net/vrf.c                                     |  6 +-----
 net/batman-adv/soft-interface.c                       |  4 ++--
 net/bridge/br_device.c                                |  6 +++---
 net/core/dev.c                                        |  4 ++--
 net/ethtool/common.c                                  |  1 -
 net/hsr/hsr_device.c                                  |  6 +-----
 net/ieee802154/6lowpan/core.c                         |  3 +--
 net/ieee802154/core.c                                 | 10 +++++-----
 net/ipv4/ip_tunnel.c                                  |  2 +-
 net/ipv4/ipmr.c                                       |  2 +-
 net/ipv6/ip6_gre.c                                    |  3 +--
 net/ipv6/ip6_tunnel.c                                 |  2 +-
 net/ipv6/ip6mr.c                                      |  2 +-
 net/ipv6/sit.c                                        |  2 +-
 net/openvswitch/vport-internal_dev.c                  |  2 +-
 net/wireless/core.c                                   | 10 +++++-----
 tools/testing/selftests/net/forwarding/README         |  2 +-
 33 files changed, 54 insertions(+), 75 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index f29d982ebf5d..5014f7cc1398 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -139,13 +139,6 @@ chained skbs (skb->next/prev list).
 Features contained in NETIF_F_SOFT_FEATURES are features of networking
 stack. Driver should not change behaviour based on them.
 
- * netns-local device
-
-NETIF_F_NETNS_LOCAL is set for devices that are not allowed to move between
-network namespaces (e.g. loopback).
-
-Don't use it in drivers.
-
  * VLAN challenged
 
 NETIF_F_VLAN_CHALLENGED should be set for devices which can't cope with VLAN
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 758f1dae3fce..4b02287d210b 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -137,10 +137,10 @@ would be sub-port 0 on port 1 on switch 1.
 Port Features
 ^^^^^^^^^^^^^
 
-NETIF_F_NETNS_LOCAL
+IFF_NETNS_LOCAL
 
 If the switchdev driver (and device) only supports offloading of the default
-network namespace (netns), the driver should set this feature flag to prevent
+network namespace (netns), the driver should set this private flag to prevent
 the port netdev from being moved out of the default netns.  A netns-aware
 driver/device would not set this flag and be responsible for partitioning
 hardware to preserve netns containment.  This means hardware cannot forward
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 54d1578f6642..3bacd4b1adc9 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -23,7 +23,6 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
 	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
-	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
 
@@ -119,7 +118,6 @@ enum {
 #define NETIF_F_IPV6_CSUM	__NETIF_F(IPV6_CSUM)
 #define NETIF_F_LOOPBACK	__NETIF_F(LOOPBACK)
 #define NETIF_F_LRO		__NETIF_F(LRO)
-#define NETIF_F_NETNS_LOCAL	__NETIF_F(NETNS_LOCAL)
 #define NETIF_F_NOCACHE_COPY	__NETIF_F(NOCACHE_COPY)
 #define NETIF_F_NTUPLE		__NETIF_F(NTUPLE)
 #define NETIF_F_RXCSUM		__NETIF_F(RXCSUM)
@@ -188,8 +186,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
-#define NETIF_F_NEVER_CHANGE	(NETIF_F_VLAN_CHALLENGED | \
-				 NETIF_F_NETNS_LOCAL)
+#define NETIF_F_NEVER_CHANGE	NETIF_F_VLAN_CHALLENGED
 
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
 #define NETIF_F_ETHTOOL_BITS	((__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5234dd2144eb..0fafb3db8f0b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1651,6 +1651,7 @@ struct net_device_ops {
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
  @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,
  *	such as tunnels.
+ * @IFF_NETNS_LOCAL: interface can't change network namespaces
  * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
  *	interfaces to avoid overhead from locking and Qdisc.
  */
@@ -1690,6 +1691,7 @@ enum netdev_priv_flags {
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 	IFF_LLTX			= BIT_ULL(34),
+	IFF_NETNS_LOCAL			= BIT_ULL(35),
 	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
 };
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 74ce40279316..82c9429c408b 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3097,9 +3097,8 @@ static void amt_link_setup(struct net_device *dev)
 	dev->flags		= IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
-	dev->priv_flags		|= IFF_LOGICAL;
+	dev->priv_flags		|= IFF_LOGICAL | IFF_NETNS_LOCAL;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
 	dev->hw_features	|= NETIF_F_FRAGLIST | NETIF_F_RXCSUM;
 	dev->hw_features	|= NETIF_F_GSO_SOFTWARE;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d503ccbdb6b5..3d28be39e211 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5876,6 +5876,8 @@ void bond_setup(struct net_device *bond_dev)
 	/* Initialize the device options */
 	bond_dev->flags |= IFF_MASTER;
 	bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_LOGICAL;
+	/* Don't allow bond devices to change network namespaces. */
+	bond_dev->priv_flags |= IFF_NETNS_LOCAL;
 	bond_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
 
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -5892,9 +5894,6 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	/* Don't allow bond devices to change network namespaces. */
-	bond_dev->features |= NETIF_F_NETNS_LOCAL;
-
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 8b4ef5121308..3ff90a7e8bb5 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1598,8 +1598,7 @@ static int adin1110_probe_netdevs(struct adin1110_priv *priv)
 		netdev->if_port = IF_PORT_10BASET;
 		netdev->netdev_ops = &adin1110_netdev_ops;
 		netdev->ethtool_ops = &adin1110_ethtool_ops;
-		netdev->priv_flags |= IFF_UNICAST_FLT;
-		netdev->features |= NETIF_F_NETNS_LOCAL;
+		netdev->priv_flags |= IFF_UNICAST_FLT | IFF_NETNS_LOCAL;
 
 		port_priv->phydev = get_phy_device(priv->mii_bus, i + 1, false);
 		if (IS_ERR(port_priv->phydev)) {
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 4fb886c57cd7..afa277def8a3 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -633,7 +633,8 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
 	if (err)
 		goto err_dl_port_register;
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
+	dev->features |= NETIF_F_HW_TC;
+	dev->priv_flags |= IFF_NETNS_LOCAL;
 	dev->netdev_ops = &prestera_netdev_ops;
 	dev->ethtool_ops = &prestera_ethtool_ops;
 	SET_NETDEV_DEV(dev, sw->dev->dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 81e1c1e401f9..d51ab72d69b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4243,9 +4243,9 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
-		features |= NETIF_F_NETNS_LOCAL;
+		netdev->priv_flags |= IFF_NETNS_LOCAL;
 	} else {
-		features &= ~NETIF_F_NETNS_LOCAL;
+		netdev->priv_flags &= ~IFF_NETNS_LOCAL;
 	}
 
 	mutex_unlock(&priv->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index a74ee698671c..62598f803a98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -864,7 +864,7 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->hw_features    |= NETIF_F_RXCSUM;
 
 	netdev->features |= netdev->hw_features;
-	netdev->features |= NETIF_F_NETNS_LOCAL;
+	netdev->priv_flags |= IFF_NETNS_LOCAL;
 }
 
 static int mlx5e_init_rep(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index ba228f500539..342d435da439 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1693,10 +1693,10 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 
 	netif_carrier_off(dev);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG |
-			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_FILTER |
+			 NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | IFF_NETNS_LOCAL;
 
 	dev->min_mtu = 0;
 	dev->max_mtu = ETH_MAX_MTU;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 755db89db909..e5d4ccbb5be8 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2575,7 +2575,8 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx);
 	rocker_carrier_init(rocker_port);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG;
+	dev->features |= NETIF_F_SG;
+	dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	/* MTU range: 68 - 9000 */
 	dev->min_mtu = ROCKER_PORT_MIN_MTU;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 087dcb67505a..4cb17b5f9f95 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1407,7 +1407,8 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		cpsw->slaves[i].ndev = ndev;
 
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
-				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
+				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_TC;
+		ndev->priv_flags |= IFF_NETNS_LOCAL;
 
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f43e2c20d8b5..860f1a3df838 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -175,6 +175,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
+	dev->priv_flags		|= IFF_NETNS_LOCAL;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -183,7 +184,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
 		| NETIF_F_HIGHDMA
-		| NETIF_F_NETNS_LOCAL
 		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
 	dev->ethtool_ops	= eth_ops;
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index c7dc3b071dbf..8b8a84ed88b0 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -727,12 +727,11 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 
 	/* Initialize the device options */
 	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_LOGICAL;
+	/* Don't allow failover devices to change network namespaces. */
+	failover_dev->priv_flags |= IFF_NETNS_LOCAL;
 	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
 				       IFF_TX_SKB_SHARING);
 
-	/* Don't allow failover devices to change network namespaces. */
-	failover_dev->features |= NETIF_F_NETNS_LOCAL;
-
 	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
 				    NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_HW_VLAN_CTAG_RX |
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index f5a55ebecf25..0fcb3b9ac4af 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2189,12 +2189,11 @@ static void team_setup(struct net_device *dev)
 	 * Let this up to underlay drivers.
 	 */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	/* Don't allow team devices to change network namespaces. */
+	dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	dev->features |= NETIF_F_GRO;
 
-	/* Don't allow team devices to change network namespaces. */
-	dev->features |= NETIF_F_NETNS_LOCAL;
-
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8da8875f411e..48c84ec3227c 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1655,9 +1655,6 @@ static void vrf_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	eth_hw_addr_random(dev);
 
-	/* don't allow vrf devices to change network namespaces. */
-	dev->features |= NETIF_F_NETNS_LOCAL;
-
 	/* does not make sense for a VLAN to be added to a vrf device */
 	dev->features   |= NETIF_F_VLAN_CHALLENGED;
 
@@ -1669,8 +1666,7 @@ static void vrf_setup(struct net_device *dev)
 	dev->hw_features = dev->features;
 	dev->hw_enc_features = dev->features;
 
-	/* default to no qdisc; user can add if desired */
-	dev->priv_flags |= IFF_LOGICAL;
+	dev->priv_flags |= IFF_LOGICAL | IFF_NETNS_LOCAL;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index aeed74eb5957..e8c88d2978c7 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1020,8 +1020,8 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
-	dev->priv_flags |= IFF_LOGICAL;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->priv_flags |= IFF_LOGICAL | IFF_NETNS_LOCAL;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index aa1d7ab43a6b..a4410a8d5993 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -480,10 +480,10 @@ void br_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->ethtool_ops = &br_ethtool_ops;
 	SET_NETDEV_DEVTYPE(dev, &br_type);
-	dev->priv_flags = IFF_EBRIDGE | IFF_LOGICAL;
+	dev->priv_flags = IFF_EBRIDGE | IFF_LOGICAL | IFF_NETNS_LOCAL;
 
-	dev->features = COMMON_FEATURES | NETIF_F_NETNS_LOCAL |
-			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
+	dev->features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
+			NETIF_F_HW_VLAN_STAG_TX;
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
 	dev->vlan_features = COMMON_FEATURES;
diff --git a/net/core/dev.c b/net/core/dev.c
index 92f5bddbc2de..1022ab4c0b89 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11275,7 +11275,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-	if (dev->features & NETIF_F_NETNS_LOCAL)
+	if (dev->priv_flags & IFF_NETNS_LOCAL)
 		goto out;
 
 	/* Ensure the device has been registrered */
@@ -11653,7 +11653,7 @@ static void __net_exit default_device_exit_net(struct net *net)
 		char fb_name[IFNAMSIZ];
 
 		/* Ignore unmoveable devices (i.e. loopback) */
-		if (dev->features & NETIF_F_NETNS_LOCAL)
+		if (dev->priv_flags & IFF_NETNS_LOCAL)
 			continue;
 
 		/* Leave virtual devices for the generic cleanup */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 44199d1780d5..66c8b6739260 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
 	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
 	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
-	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
 	[NETIF_F_GRO_BIT] =              "rx-gro",
 	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
 	[NETIF_F_LRO_BIT] =              "rx-lro",
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 1f779ca3ac00..066e30ea5042 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -498,7 +498,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->header_ops = &hsr_header_ops;
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
-	dev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL;
+	dev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL | IFF_NETNS_LOCAL;
 
 	dev->needs_free_netdev = true;
 
@@ -512,10 +512,6 @@ void hsr_dev_setup(struct net_device *dev)
 	 * hsr_header_create() etc.
 	 */
 	dev->features |= NETIF_F_VLAN_CHALLENGED;
-	/* Not sure about this. Taken from bridge code. netdev_features.h says
-	 * it means "Does not change network namespaces".
-	 */
-	dev->features |= NETIF_F_NETNS_LOCAL;
 }
 
 /* Return true if dev is a HSR master; return false otherwise.
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 77b4e92027c5..3d3e083fd9e1 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -111,12 +111,11 @@ static void lowpan_setup(struct net_device *ldev)
 	/* We need an ipv6hdr as minimum len when calling xmit */
 	ldev->hard_header_len	= sizeof(struct ipv6hdr);
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
-	ldev->priv_flags	|= IFF_NO_QUEUE;
+	ldev->priv_flags	|= IFF_NO_QUEUE | IFF_NETNS_LOCAL;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
 	ldev->needs_free_netdev	= true;
-	ldev->features		|= NETIF_F_NETNS_LOCAL;
 }
 
 static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 60e8fff1347e..32e1354a3cff 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -226,11 +226,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
 		if (!wpan_dev->netdev)
 			continue;
-		wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+		wpan_dev->netdev->priv_flags &= ~IFF_NETNS_LOCAL;
 		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
 		if (err)
 			break;
-		wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+		wpan_dev->netdev->priv_flags |= IFF_NETNS_LOCAL;
 	}
 
 	if (err) {
@@ -242,11 +242,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 						     list) {
 			if (!wpan_dev->netdev)
 				continue;
-			wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+			wpan_dev->netdev->priv_flags &= ~IFF_NETNS_LOCAL;
 			err = dev_change_net_namespace(wpan_dev->netdev, net,
 						       "wpan%d");
 			WARN_ON(err);
-			wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+			wpan_dev->netdev->priv_flags |= IFF_NETNS_LOCAL;
 		}
 
 		return err;
@@ -291,7 +291,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	switch (state) {
 		/* TODO NETDEV_DEVTYPE */
 	case NETDEV_REGISTER:
-		dev->features |= NETIF_F_NETNS_LOCAL;
+		dev->priv_flags |= IFF_NETNS_LOCAL;
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
 		rdev->devlist_generation++;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 177f40c3a8e8..6ec4365cefa5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1162,7 +1162,7 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
 	if (!IS_ERR(itn->fb_tunnel_dev)) {
-		itn->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
+		itn->fb_tunnel_dev->priv_flags |= IFF_NETNS_LOCAL;
 		itn->fb_tunnel_dev->mtu = ip_tunnel_bind_dev(itn->fb_tunnel_dev);
 		ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));
 		itn->type = itn->fb_tunnel_dev->type;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6c750bd13dd8..ecc1159bb2ce 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -536,7 +536,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
+	dev->priv_flags		|= IFF_NETNS_LOCAL;
 }
 
 static struct net_device *ipmr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 62326b6d7d92..36a5f8997fc2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1629,8 +1629,7 @@ static int __net_init ip6gre_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ign->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
-
+	ign->fb_tunnel_dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 16270e1acd23..206a936427da 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2256,7 +2256,7 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ip6n->fb_tnl_dev->features |= NETIF_F_NETNS_LOCAL;
+	ip6n->fb_tnl_dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	err = ip6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cb0ee81a068a..f896c76ab9eb 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -640,7 +640,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
+	dev->priv_flags		|= IFF_NETNS_LOCAL;
 }
 
 static struct net_device *ip6mr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index b8d229cf8f8d..23df3c0638d6 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1855,7 +1855,7 @@ static int __net_init sit_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	sitn->fb_tunnel_dev->features |= NETIF_F_NETNS_LOCAL;
+	sitn->fb_tunnel_dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 99a0251922cf..e916b95a8d28 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -153,7 +153,7 @@ static struct vport *internal_dev_create(const struct vport_parms *parms)
 
 	/* Restrict bridge port to current netns. */
 	if (vport->port_no == OVSP_LOCAL)
-		vport->dev->features |= NETIF_F_NETNS_LOCAL;
+		vport->dev->priv_flags |= IFF_NETNS_LOCAL;
 
 	rtnl_lock();
 	err = register_netdevice(vport->dev);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3fb1b637352a..dec3bdc47726 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -165,11 +165,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
-		wdev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+		wdev->netdev->priv_flags &= ~IFF_NETNS_LOCAL;
 		err = dev_change_net_namespace(wdev->netdev, net, "wlan%d");
 		if (err)
 			break;
-		wdev->netdev->features |= NETIF_F_NETNS_LOCAL;
+		wdev->netdev->priv_flags |= IFF_NETNS_LOCAL;
 	}
 
 	if (err) {
@@ -181,11 +181,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 						     list) {
 			if (!wdev->netdev)
 				continue;
-			wdev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+			wdev->netdev->priv_flags &= ~IFF_NETNS_LOCAL;
 			err = dev_change_net_namespace(wdev->netdev, net,
 							"wlan%d");
 			WARN_ON(err);
-			wdev->netdev->features |= NETIF_F_NETNS_LOCAL;
+			wdev->netdev->priv_flags |= IFF_NETNS_LOCAL;
 		}
 
 		return err;
@@ -1468,7 +1468,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		SET_NETDEV_DEVTYPE(dev, &wiphy_type);
 		wdev->netdev = dev;
 		/* can only change netns with wiphy */
-		dev->features |= NETIF_F_NETNS_LOCAL;
+		dev->priv_flags |= IFF_NETNS_LOCAL;
 
 		cfg80211_init_wdev(wdev);
 		break;
diff --git a/tools/testing/selftests/net/forwarding/README b/tools/testing/selftests/net/forwarding/README
index 7fdb6a9ca543..24d9ed84ce42 100644
--- a/tools/testing/selftests/net/forwarding/README
+++ b/tools/testing/selftests/net/forwarding/README
@@ -6,7 +6,7 @@ to easily create and test complex environments.
 
 Unfortunately, these namespaces can not be used with actual switching
 ASICs, as their ports can not be migrated to other network namespaces
-(NETIF_F_NETNS_LOCAL) and most of them probably do not support the
+(IFF_NETNS_LOCAL) and most of them probably do not support the
 L1-separation provided by namespaces.
 
 However, a similar kind of flexibility can be achieved by using VRFs and
-- 
2.44.0


