Return-Path: <linux-kernel+bounces-133082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06362899E89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72300B21829
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5616DEDF;
	Fri,  5 Apr 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYIXnTxg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493016DEBE;
	Fri,  5 Apr 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324362; cv=none; b=LcrU+OiTPlM/A72WvHO2SdQBcV03gh5j+Uq860TTg4e59tUdX2ELgNVwGeqrEbwohG6D/X1Ma9+m/4fOFmf0yK5GGw82NMgpMpi4q4hKBGEuoix5sDyDF+aKuDyRKvYzrIw024RaqJySS+t7ZPaKk107QumFKfX/Y94SvpTMBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324362; c=relaxed/simple;
	bh=yW/naWzfon+NL1XnviLeX65xitwouTc1eK2z+tp9PnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm+z7Ty3G2NRYn1wUop7SaayZFxCFLXwkSgOGXOncAZFfSqZH2NGaLUEXjp7Q8sz8hAVGrbSCdBtQlg4QBf37K7sfTIIAPyOC9NoFfv25lxxD9S3xmToTaM5VVeDitx6GmFAT0gj5O9DcNiDeUBuk+5urFsWFpJrRODjF8t4cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYIXnTxg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324360; x=1743860360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yW/naWzfon+NL1XnviLeX65xitwouTc1eK2z+tp9PnI=;
  b=bYIXnTxgdUTmsEa7mwXttOrFMQkS1CMZzE9RqtIw8tB1RqrGUxfRhdgK
   mE1HzFEM4iSSzC53YMiFdRpgUi9rmjmPqrA+dvc8Wur1GX7p7DIsT/iNi
   Fr6vcAItH00zHeJEiW/sLXmu/ImlsVxBcG8Y6J39UI0ljcjyDQ5x6WgCm
   YN2sovMQM9hCKsnic0A4dkZR6EPuVacfvQqYVJWRgC+hflMezwP3uSFmj
   wfWTG/s2gq0AJWzU/JuGJKedLexiy/lx1YXca0ys/3OYRd0b/X87PHgfr
   b/8de3C72ZiLqfv6jPRgbB8MXqRb4KHafjDeoiO8VHJpyWiU+2UDTN2bj
   Q==;
X-CSE-ConnectionGUID: 1pZAEu1ZT9yvxd+TJwa2Pw==
X-CSE-MsgGUID: pxkIcFHGRFymPdExseunTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219573"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219573"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:20 -0700
X-CSE-ConnectionGUID: OdFNPq2KRN6THm6zM6Jzkg==
X-CSE-MsgGUID: MgBCA5meQR27yAjcuZ1qOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600110"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:17 -0700
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
Subject: [PATCH RFC net-next 3/7] netdevice: introduce IFF_LOGICAL as (IFF_NO_QUEUE | IFF_LLTX)
Date: Fri,  5 Apr 2024 15:37:27 +0200
Message-ID: <20240405133731.1010128-4-aleksander.lobakin@intel.com>
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

These two are often used together when creating logical interfaces w/o
locking and Qdisc overhead.
Introduce a shorthand to avoid repeating the same pattern.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h                         | 3 +++
 drivers/net/amt.c                                 | 2 +-
 drivers/net/bareudp.c                             | 2 +-
 drivers/net/bonding/bond_main.c                   | 4 +---
 drivers/net/dummy.c                               | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 2 +-
 drivers/net/geneve.c                              | 2 +-
 drivers/net/gtp.c                                 | 2 +-
 drivers/net/loopback.c                            | 3 +--
 drivers/net/net_failover.c                        | 2 +-
 drivers/net/netkit.c                              | 3 +--
 drivers/net/nlmon.c                               | 2 +-
 drivers/net/team/team_core.c                      | 4 ++--
 drivers/net/veth.c                                | 3 +--
 drivers/net/vrf.c                                 | 4 +---
 drivers/net/vsockmon.c                            | 2 +-
 drivers/net/vxlan/vxlan_core.c                    | 2 +-
 drivers/net/wireguard/device.c                    | 2 +-
 net/batman-adv/soft-interface.c                   | 2 +-
 net/bridge/br_device.c                            | 2 +-
 net/core/net-sysfs.c                              | 2 +-
 net/hsr/hsr_device.c                              | 2 +-
 net/openvswitch/vport-internal_dev.c              | 2 +-
 23 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 065dd68fe97c..5234dd2144eb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1651,6 +1651,8 @@ struct net_device_ops {
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
  @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,
  *	such as tunnels.
+ * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
+ *	interfaces to avoid overhead from locking and Qdisc.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1688,6 +1690,7 @@ enum netdev_priv_flags {
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 	IFF_LLTX			= BIT_ULL(34),
+	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 9312274c330a..74ce40279316 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3097,7 +3097,7 @@ static void amt_link_setup(struct net_device *dev)
 	dev->flags		= IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
-	dev->priv_flags		|= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags		|= IFF_LOGICAL;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
 	dev->features		|= NETIF_F_NETNS_LOCAL;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 958ee2c55c9e..74f7072182b9 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -564,7 +564,7 @@ static void bareudp_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - BAREUDP_BASE_HLEN;
 	dev->type = ARPHRD_NONE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 70bfe60e5868..d503ccbdb6b5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5875,9 +5875,7 @@ void bond_setup(struct net_device *bond_dev)
 
 	/* Initialize the device options */
 	bond_dev->flags |= IFF_MASTER;
-	bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
-	/* don't acquire bond device's netif_tx_lock when transmitting */
-	bond_dev->priv_flags |= IFF_LLTX;
+	bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_LOGICAL;
 	bond_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
 
 #ifdef CONFIG_XFRM_OFFLOAD
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 6cd38b646d5e..a0122e867891 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -108,7 +108,7 @@ static void dummy_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST;
 	dev->features	|= NETIF_F_GSO_SOFTWARE;
 	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 5c79f3e3ad58..3cb3dbbd6240 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -384,7 +384,7 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	netdev->features &= ~NETIF_F_HW_VLAN_STAG_RX;
 	netif_set_tso_max_segs(netdev, NFP_NET_LSO_MAX_SEGS);
 
-	netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL | IFF_LLTX;
+	netdev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL;
 
 	if (nfp_app_has_tc(app)) {
 		netdev->features |= NETIF_F_HW_TC;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 51ef6d8f1f46..9ae7aaffd9fd 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1211,7 +1211,7 @@ static void geneve_setup(struct net_device *dev)
 
 	netif_keep_dst(dev);
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
 	eth_hw_addr_random(dev);
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2933ef5f0d5b..54dd0a134d97 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -956,7 +956,7 @@ static void gtp_link_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-	dev->priv_flags	|= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags	|= IFF_LOGICAL;
 	netif_keep_dst(dev);
 
 	dev->needed_headroom	= LL_MAX_HEADER + max_gtp_header_len;
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f38f0017b70a..f43e2c20d8b5 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -174,8 +174,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->addr_len		= ETH_ALEN;	/* 6	*/
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
-	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
-	dev->priv_flags		|= IFF_LLTX;
+	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 5ce1df4a6e3d..c7dc3b071dbf 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -726,7 +726,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	failover_dev->ethtool_ops = &failover_ethtool_ops;
 
 	/* Initialize the device options */
-	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE | IFF_LLTX;
+	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_LOGICAL;
 	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
 				       IFF_TX_SKB_SHARING);
 
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 65247de21761..bd7abb2d6c7b 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -241,8 +241,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
-	dev->priv_flags |= IFF_NO_QUEUE;
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 
 	dev->ethtool_ops = &netkit_ethtool_ops;
 	dev->netdev_ops  = &netkit_netdev_ops;
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index e08eec154227..e319a0d0771d 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -62,7 +62,7 @@ static const struct net_device_ops nlmon_ops = {
 static void nlmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_NETLINK;
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 
 	dev->netdev_ops	= &nlmon_ops;
 	dev->ethtool_ops = &nlmon_ethtool_ops;
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 396c1f7cae09..f5a55ebecf25 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2180,7 +2180,7 @@ static void team_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = team_destructor;
 	dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LOGICAL;
 	dev->priv_flags |= IFF_TEAM;
 
 	/*
@@ -2188,7 +2188,7 @@ static void team_setup(struct net_device *dev)
 	 * bring us to promisc mode in case a unicast addr is added.
 	 * Let this up to underlay drivers.
 	 */
-	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
+	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
 
 	dev->features |= NETIF_F_GRO;
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 4b2a437ff634..f17c5aab1f78 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1693,9 +1693,8 @@ static void veth_setup(struct net_device *dev)
 
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LOGICAL;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
-	dev->priv_flags |= IFF_LLTX;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index c3c009f2d39a..8da8875f411e 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1670,11 +1670,9 @@ static void vrf_setup(struct net_device *dev)
 	dev->hw_enc_features = dev->features;
 
 	/* default to no qdisc; user can add if desired */
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LOGICAL;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	/* don't acquire vrf device's netif_tx_lock when transmitting */
-	dev->priv_flags |= IFF_LLTX;
 
 	/* VRF devices do not care about MTU, but if the MTU is set
 	 * too low then the ipv4 and ipv6 protocols are disabled
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index 2fcdd80850d9..f0903f66d137 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -82,7 +82,7 @@ static const struct ethtool_ops vsockmon_ethtool_ops = {
 static void vsockmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_VSOCKMON;
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 
 	dev->netdev_ops	= &vsockmon_ops;
 	dev->ethtool_ops = &vsockmon_ethtool_ops;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4f2b48955073..95625e9779ac 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3301,7 +3301,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_CHANGE_PROTO_DOWN | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL | IFF_CHANGE_PROTO_DOWN;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 1492ea6c48b9..ef1a05e1b46e 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -288,7 +288,7 @@ static void wg_setup(struct net_device *dev)
 	dev->needed_tailroom = noise_encrypted_len(MESSAGE_PADDING_MULTIPLE);
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 	dev->features |= WG_NETDEV_FEATURES;
 	dev->hw_features |= WG_NETDEV_FEATURES;
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index dd7173cf5069..aeed74eb5957 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1021,7 +1021,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index acd43839f2f5..aa1d7ab43a6b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -480,7 +480,7 @@ void br_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->ethtool_ops = &br_ethtool_ops;
 	SET_NETDEV_DEVTYPE(dev, &br_type);
-	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE | IFF_LLTX;
+	dev->priv_flags = IFF_EBRIDGE | IFF_LOGICAL;
 
 	dev->features = COMMON_FEATURES | NETIF_F_NETNS_LOCAL |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1525024b1e51..34e3ed07ab9c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1764,7 +1764,7 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
-	if (dev->priv_flags & (IFF_NO_QUEUE | IFF_LLTX))
+	if (dev->priv_flags & IFF_LOGICAL)
 		return false;
 
 	return IS_ENABLED(CONFIG_BQL);
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 561dba9e79f0..1f779ca3ac00 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -498,7 +498,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->header_ops = &hsr_header_ops;
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL | IFF_LLTX;
+	dev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL;
 
 	dev->needs_free_netdev = true;
 
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 7f96ba7a27c1..99a0251922cf 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -102,7 +102,7 @@ static void do_setup(struct net_device *netdev)
 
 	netdev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_OPENVSWITCH |
-			      IFF_NO_QUEUE | IFF_LLTX;
+			      IFF_LOGICAL;
 	netdev->needs_free_netdev = true;
 	netdev->priv_destructor = NULL;
 	netdev->ethtool_ops = &internal_dev_ethtool_ops;
-- 
2.44.0


