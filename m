Return-Path: <linux-kernel+bounces-133081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63190899E88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922A7B21752
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EC16DED5;
	Fri,  5 Apr 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDJjlkpV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8816DEA0;
	Fri,  5 Apr 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324360; cv=none; b=ZloXbQ34Tk7A2s4tu+9CKVM4ZD+8lOT+kq3jgOrd0Z7GUpOerxDO+D0qp3yBGTFR8AhmWGndbaW0VwObrZlY2vLjFXZLi50gRrH7arPkm/TGo/UvxRw2u445LdFHuyO75//vcg8rEspiOqpsBCvvTjq699z47iy8H517QV+ZOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324360; c=relaxed/simple;
	bh=eEQM41ef+zxpRVCt2ubvtUu/JsWZ5LvK96a5i3NqRec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3k+bKlldb1i7vlkBN9gMMxXrbUJzOflx327aZr17sFV/kR+lae0v9UMcO96OYtpEHM6tKUyt7/L3bUINWuBMO25VNdxPgVQKbEh1OkYwBNqEmUScB/zI8reDoFSsAS6pv4kfIimg6AvqD6K1HW3uFMeHj/E29RPevWoXcSrJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDJjlkpV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324358; x=1743860358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEQM41ef+zxpRVCt2ubvtUu/JsWZ5LvK96a5i3NqRec=;
  b=TDJjlkpVzNZ0AsD2P3ATJ/nKYh5fE8wus0DYpjAqH/0bq4j3j4pDdkZG
   1cATJMp37Xu2biTB6ULHJbJsdozOuRkdYrjCNmHSVgXlt5bWYFt/uwW3/
   n3DEdQQR5mwQpyt8csae6RzYWiAbGnj3uWcyrKPEkZ1mQ+NXnmW7U4awg
   6LFXZZ1APphxiSL+oeMvB7y7BaW8x3E5pJq2Qw7UeixaBrUgcGrnC8XkG
   ygsxFQ7LPMuzdsbh3Txc5vb6kzyzHOulEWp5ch6ih8o991V1bDn6S1nu9
   f+XJhR5eCwngmfslxVtp6hHGxwVj6fQg9wWfph3P0/aXLgSJjoVNtrlMH
   g==;
X-CSE-ConnectionGUID: oX4KR22gQhqlHDRiZR5tpA==
X-CSE-MsgGUID: bjQiSLQdQRCG9z6a6aDe5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219559"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:17 -0700
X-CSE-ConnectionGUID: MfPNKEJfSmSBRSCn5QmuoQ==
X-CSE-MsgGUID: mhO9RL6tRY6ACzm+fChsqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600099"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:14 -0700
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
Subject: [PATCH RFC net-next 2/7] netdev_features: convert NETIF_F_LLTX to priv_flag IFF_LLTX
Date: Fri,  5 Apr 2024 15:37:26 +0200
Message-ID: <20240405133731.1010128-3-aleksander.lobakin@intel.com>
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

NETIF_F_LLTX can't be changed via Ethtool and is not a feature, rather
an attribute, very similar to IFF_NO_QUEUE.
Free one netdev_features_t bit and make it a private flag.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/netdev-features.rst      |  8 --------
 Documentation/networking/netdevices.rst           |  4 ++--
 drivers/net/ethernet/tehuti/tehuti.h              |  2 +-
 include/linux/netdev_features.h                   |  5 +----
 include/linux/netdevice.h                         |  9 ++++++---
 drivers/net/amt.c                                 |  3 +--
 drivers/net/bareudp.c                             |  3 +--
 drivers/net/bonding/bond_main.c                   |  5 ++---
 drivers/net/dummy.c                               |  4 ++--
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c         |  3 ++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c    |  4 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c    |  3 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +---
 drivers/net/ethernet/pasemi/pasemi_mac.c          |  5 +++--
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
 drivers/net/ethernet/sfc/ef100_rep.c              |  3 +--
 drivers/net/ethernet/tehuti/tehuti.c              |  4 ++--
 drivers/net/ethernet/toshiba/spider_net.c         |  3 ++-
 drivers/net/geneve.c                              |  3 +--
 drivers/net/gtp.c                                 |  3 +--
 drivers/net/hamradio/bpqether.c                   |  2 +-
 drivers/net/ipvlan/ipvlan_main.c                  |  3 ++-
 drivers/net/loopback.c                            |  2 +-
 drivers/net/macsec.c                              |  4 ++--
 drivers/net/macvlan.c                             |  3 ++-
 drivers/net/net_failover.c                        |  5 +----
 drivers/net/netkit.c                              |  3 ++-
 drivers/net/nlmon.c                               |  5 ++---
 drivers/net/ppp/ppp_generic.c                     |  2 +-
 drivers/net/rionet.c                              |  2 +-
 drivers/net/team/team_core.c                      |  3 +--
 drivers/net/tun.c                                 |  5 +++--
 drivers/net/veth.c                                |  2 +-
 drivers/net/vrf.c                                 |  5 ++---
 drivers/net/vsockmon.c                            |  5 ++---
 drivers/net/vxlan/vxlan_core.c                    |  3 +--
 drivers/net/wireguard/device.c                    |  3 +--
 drivers/staging/octeon/ethernet.c                 |  2 +-
 lib/test_bpf.c                                    |  3 +--
 net/8021q/vlan_dev.c                              |  4 ++--
 net/batman-adv/soft-interface.c                   |  3 +--
 net/bridge/br_device.c                            |  4 ++--
 net/core/net-sysfs.c                              |  3 +--
 net/dsa/user.c                                    |  3 ++-
 net/ethtool/common.c                              |  1 -
 net/hsr/hsr_device.c                              |  4 +---
 net/ipv4/ip_gre.c                                 |  4 +++-
 net/ipv4/ip_vti.c                                 |  2 +-
 net/ipv4/ipip.c                                   |  2 +-
 net/ipv6/ip6_gre.c                                |  4 +++-
 net/ipv6/ip6_tunnel.c                             |  2 +-
 net/ipv6/sit.c                                    |  2 +-
 net/l2tp/l2tp_eth.c                               |  2 +-
 net/openvswitch/vport-internal_dev.c              | 10 +++++-----
 net/xfrm/xfrm_interface_core.c                    |  2 +-
 56 files changed, 90 insertions(+), 108 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index d7b15bb64deb..f29d982ebf5d 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -139,14 +139,6 @@ chained skbs (skb->next/prev list).
 Features contained in NETIF_F_SOFT_FEATURES are features of networking
 stack. Driver should not change behaviour based on them.
 
- * LLTX driver (deprecated for hardware drivers)
-
-NETIF_F_LLTX is meant to be used by drivers that don't need locking at all,
-e.g. software tunnels.
-
-This is also used in a few legacy drivers that implement their
-own locking, don't use it for new (hardware) drivers.
-
  * netns-local device
 
 NETIF_F_NETNS_LOCAL is set for devices that are not allowed to move between
diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index c2476917a6c3..6f9737fa594c 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -258,11 +258,11 @@ ndo_get_stats:
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
 
-	When the driver sets NETIF_F_LLTX in dev->features this will be
+	When the driver sets IFF_LLTX in dev->priv_flags this will be
 	called without holding netif_tx_lock. In this case the driver
 	has to lock by itself when needed.
 	The locking there should also properly protect against
-	set_rx_mode. WARNING: use of NETIF_F_LLTX is deprecated.
+	set_rx_mode. WARNING: use of IFF_LLTX is deprecated.
 	Don't use it for new drivers.
 
 	Context: Process with BHs disabled or BH (timer),
diff --git a/drivers/net/ethernet/tehuti/tehuti.h b/drivers/net/ethernet/tehuti/tehuti.h
index 909e7296cecf..b2b9f2a0a225 100644
--- a/drivers/net/ethernet/tehuti/tehuti.h
+++ b/drivers/net/ethernet/tehuti/tehuti.h
@@ -260,7 +260,7 @@ struct bdx_priv {
 	int tx_update_mark;
 	int tx_noupd;
 #endif
-	spinlock_t tx_lock;	/* NETIF_F_LLTX mode */
+	spinlock_t tx_lock;	/* IFF_LLTX mode */
 
 	/* rarely used */
 	u8 port;
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 44c428d62db4..54d1578f6642 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -23,8 +23,6 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
 	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
-	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
-					/* do not use LLTX in new drivers */
 	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
@@ -119,7 +117,6 @@ enum {
 #define NETIF_F_HW_VLAN_CTAG_TX	__NETIF_F(HW_VLAN_CTAG_TX)
 #define NETIF_F_IP_CSUM		__NETIF_F(IP_CSUM)
 #define NETIF_F_IPV6_CSUM	__NETIF_F(IPV6_CSUM)
-#define NETIF_F_LLTX		__NETIF_F(LLTX)
 #define NETIF_F_LOOPBACK	__NETIF_F(LOOPBACK)
 #define NETIF_F_LRO		__NETIF_F(LRO)
 #define NETIF_F_NETNS_LOCAL	__NETIF_F(NETNS_LOCAL)
@@ -192,7 +189,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
 #define NETIF_F_NEVER_CHANGE	(NETIF_F_VLAN_CHALLENGED | \
-				 NETIF_F_LLTX | NETIF_F_NETNS_LOCAL)
+				 NETIF_F_NETNS_LOCAL)
 
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
 #define NETIF_F_ETHTOOL_BITS	((__NETIF_F_BIT(NETDEV_FEATURE_COUNT - 1) | \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c198620ac93..065dd68fe97c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1649,6 +1649,8 @@ struct net_device_ops {
  * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
  *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
+ @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,
+ *	such as tunnels.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1685,6 +1687,7 @@ enum netdev_priv_flags {
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
+	IFF_LLTX			= BIT_ULL(34),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -4436,7 +4439,7 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_LOCK(dev, txq, cpu) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (!((dev)->priv_flags & IFF_LLTX)) {		\
 		__netif_tx_lock(txq, cpu);		\
 	} else {					\
 		__netif_tx_acquire(txq);		\
@@ -4444,12 +4447,12 @@ static inline void netif_tx_unlock_bh(struct net_device *dev)
 }
 
 #define HARD_TX_TRYLOCK(dev, txq)			\
-	(((dev->features & NETIF_F_LLTX) == 0) ?	\
+	(!((dev)->priv_flags & IFF_LLTX) ?		\
 		__netif_tx_trylock(txq) :		\
 		__netif_tx_acquire(txq))
 
 #define HARD_TX_UNLOCK(dev, txq) {			\
-	if ((dev->features & NETIF_F_LLTX) == 0) {	\
+	if (!((dev)->priv_flags & IFF_LLTX)) {		\
 		__netif_tx_unlock(txq);			\
 	} else {					\
 		__netif_tx_release(txq);		\
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 6d15ab3bfbbc..9312274c330a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3097,8 +3097,7 @@ static void amt_link_setup(struct net_device *dev)
 	dev->flags		= IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
-	dev->priv_flags		|= IFF_NO_QUEUE;
-	dev->features		|= NETIF_F_LLTX;
+	dev->priv_flags		|= IFF_NO_QUEUE | IFF_LLTX;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
 	dev->features		|= NETIF_F_NETNS_LOCAL;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d5c56ca91b77..958ee2c55c9e 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -553,7 +553,6 @@ static void bareudp_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &bareudp_type);
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
-	dev->features    |= NETIF_F_LLTX;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
@@ -565,7 +564,7 @@ static void bareudp_setup(struct net_device *dev)
 	dev->max_mtu = IP_MAX_MTU - BAREUDP_BASE_HLEN;
 	dev->type = ARPHRD_NONE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2c5ed0a7cb18..70bfe60e5868 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5876,6 +5876,8 @@ void bond_setup(struct net_device *bond_dev)
 	/* Initialize the device options */
 	bond_dev->flags |= IFF_MASTER;
 	bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
+	/* don't acquire bond device's netif_tx_lock when transmitting */
+	bond_dev->priv_flags |= IFF_LLTX;
 	bond_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
 
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -5885,9 +5887,6 @@ void bond_setup(struct net_device *bond_dev)
 	spin_lock_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-	/* don't acquire bond device's netif_tx_lock when transmitting */
-	bond_dev->features |= NETIF_F_LLTX;
-
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
 	 * care is taken in the various xmit functions
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d29b5d7af0d7..6cd38b646d5e 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -108,10 +108,10 @@ static void dummy_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE | IFF_LLTX;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST;
 	dev->features	|= NETIF_F_GSO_SOFTWARE;
-	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
 	dev->features	|= NETIF_F_GSO_ENCAP_ALL;
 	dev->hw_features |= dev->features;
 	dev->hw_enc_features |= dev->features;
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index d2286adf09fe..9d0e8fc35ff9 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -1031,10 +1031,11 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->mem_start = mmio_start;
 		netdev->mem_end = mmio_start + mmio_len - 1;
 		netdev->ml_priv = adapter;
+		netdev->priv_flags |= IFF_LLTX;
 		netdev->hw_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
 			NETIF_F_RXCSUM;
 		netdev->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-			NETIF_F_RXCSUM | NETIF_F_LLTX | NETIF_F_HIGHDMA;
+			NETIF_F_RXCSUM | NETIF_F_HIGHDMA;
 
 		if (vlan_tso_capable(adapter)) {
 			netdev->features |=
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6..4129344e1541 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -229,7 +229,7 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->max_mtu = dpaa_get_max_mtu();
 
 	net_dev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-				 NETIF_F_LLTX | NETIF_F_RXHASH);
+				 NETIF_F_RXHASH);
 
 	net_dev->hw_features |= NETIF_F_SG | NETIF_F_HIGHDMA;
 	/* The kernels enables GSO automatically, if we declare NETIF_F_SG.
@@ -238,7 +238,7 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->features |= NETIF_F_GSO;
 	net_dev->features |= NETIF_F_RXCSUM;
 
-	net_dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	net_dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
 	/* we do not want shared skbs on TX */
 	net_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 40e881829595..bbd846bf12b0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4585,7 +4585,7 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 	dpaa2_eth_detect_features(priv);
 
 	/* Capabilities listing */
-	supported |= IFF_LIVE_ADDR_CHANGE;
+	supported |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
 
 	if (options & DPNI_OPT_NO_MAC_FILTER)
 		not_supported |= IFF_UNICAST_FLT;
@@ -4599,7 +4599,7 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 	net_dev->features = NETIF_F_RXCSUM |
 			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_SG | NETIF_F_HIGHDMA |
-			    NETIF_F_LLTX | NETIF_F_HW_TC | NETIF_F_TSO;
+			    NETIF_F_HW_TC | NETIF_F_TSO;
 	net_dev->gso_max_segs = DPAA2_ETH_ENQUEUE_MAX_FDS;
 	net_dev->hw_features = net_dev->features;
 	net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index bb642e9bb6cf..ba228f500539 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1693,9 +1693,10 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 
 	netif_carrier_off(dev);
 
-	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_LLTX | NETIF_F_SG |
+	dev->features |= NETIF_F_NETNS_LOCAL | NETIF_F_SG |
 			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_TC;
 	dev->hw_features |= NETIF_F_HW_TC | NETIF_F_LOOPBACK;
+	dev->priv_flags |= IFF_LLTX;
 
 	dev->min_mtu = 0;
 	dev->max_mtu = ETH_MAX_MTU;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 3af1229a3f08..5c79f3e3ad58 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -248,7 +248,6 @@ nfp_repr_fix_features(struct net_device *netdev, netdev_features_t features)
 
 	features = netdev_intersect_features(features, lower_features);
 	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_HW_TC);
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
@@ -385,8 +384,7 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	netdev->features &= ~NETIF_F_HW_VLAN_STAG_RX;
 	netif_set_tso_max_segs(netdev, NFP_NET_LSO_MAX_SEGS);
 
-	netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
-	netdev->features |= NETIF_F_LLTX;
+	netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL | IFF_LLTX;
 
 	if (nfp_app_has_tc(app)) {
 		netdev->features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index ed7dd0a04235..2dcbfe24134c 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1699,8 +1699,9 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netif_napi_add(dev, &mac->napi, pasemi_mac_poll);
 
-	dev->features = NETIF_F_IP_CSUM | NETIF_F_LLTX | NETIF_F_SG |
-			NETIF_F_HIGHDMA | NETIF_F_GSO;
+	dev->features = NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_HIGHDMA |
+			NETIF_F_GSO;
+	dev->priv_flags |= IFF_LLTX;
 
 	mac->dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
 	if (!mac->dma_pdev) {
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 9d2a9562c96f..b79426e6446a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -286,7 +286,7 @@ void rmnet_vnd_setup(struct net_device *rmnet_dev)
 	rmnet_dev->needs_free_netdev = true;
 	rmnet_dev->ethtool_ops = &rmnet_ethtool_ops;
 
-	rmnet_dev->features |= NETIF_F_LLTX;
+	rmnet_dev->priv_flags |= IFF_LLTX;
 
 	/* This perm addr will be used as interface identifier by IPv6 */
 	rmnet_dev->addr_assign_type = NET_ADDR_RANDOM;
diff --git a/drivers/net/ethernet/sfc/ef100_rep.c b/drivers/net/ethernet/sfc/ef100_rep.c
index 0b3083ef0ead..8819bbce8bf9 100644
--- a/drivers/net/ethernet/sfc/ef100_rep.c
+++ b/drivers/net/ethernet/sfc/ef100_rep.c
@@ -233,8 +233,7 @@ static struct efx_rep *efx_ef100_rep_create_netdev(struct efx_nic *efx,
 	net_dev->ethtool_ops = &efx_ef100_rep_ethtool_ops;
 	net_dev->min_mtu = EFX_MIN_MTU;
 	net_dev->max_mtu = EFX_MAX_MTU;
-	net_dev->features |= NETIF_F_LLTX;
-	net_dev->hw_features |= NETIF_F_LLTX;
+	net_dev->priv_flags |= IFF_LLTX;
 	return efv;
 fail1:
 	free_netdev(net_dev);
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index ca409515ead5..5c44d27a9f48 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1671,7 +1671,7 @@ static netdev_tx_t bdx_tx_transmit(struct sk_buff *skb,
 
 #endif
 #ifdef BDX_LLTX
-	netif_trans_update(ndev); /* NETIF_F_LLTX driver :( */
+	netif_trans_update(ndev); /* IFF_LLTX driver :( */
 #endif
 	ndev->stats.tx_packets++;
 	ndev->stats.tx_bytes += skb->len;
@@ -2019,7 +2019,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * set multicast list callback has to use priv->tx_lock.
 		 */
 #ifdef BDX_LLTX
-		ndev->features |= NETIF_F_LLTX;
+		ndev->priv_flags |= IFF_LLTX;
 #endif
 		/* MTU range: 60 - 16384 */
 		ndev->min_mtu = ETH_ZLEN;
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 87e67121477c..b712540d81ec 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2277,10 +2277,11 @@ spider_net_setup_netdev(struct spider_net_card *card)
 	netdev->hw_features = NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
 	if (SPIDER_NET_RX_CSUM_DEFAULT)
 		netdev->features |= NETIF_F_RXCSUM;
-	netdev->features |= NETIF_F_IP_CSUM | NETIF_F_LLTX;
+	netdev->features |= NETIF_F_IP_CSUM;
 	/* some time: NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 	 *		NETIF_F_HW_VLAN_CTAG_FILTER
 	 */
+	netdev->priv_flags |= IFF_LLTX;
 
 	/* MTU range: 64 - 2294 */
 	netdev->min_mtu = SPIDER_NET_MIN_MTU;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 163f94a5a58f..51ef6d8f1f46 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1192,7 +1192,6 @@ static void geneve_setup(struct net_device *dev)
 
 	SET_NETDEV_DEVTYPE(dev, &geneve_type);
 
-	dev->features    |= NETIF_F_LLTX;
 	dev->features    |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features    |= NETIF_F_RXCSUM;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
@@ -1212,7 +1211,7 @@ static void geneve_setup(struct net_device *dev)
 
 	netif_keep_dst(dev);
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE | IFF_LLTX;
 	eth_hw_addr_random(dev);
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ba4704c2c640..2933ef5f0d5b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -956,8 +956,7 @@ static void gtp_link_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-	dev->priv_flags	|= IFF_NO_QUEUE;
-	dev->features	|= NETIF_F_LLTX;
+	dev->priv_flags	|= IFF_NO_QUEUE | IFF_LLTX;
 	netif_keep_dst(dev);
 
 	dev->needed_headroom	= LL_MAX_HEADER + max_gtp_header_len;
diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 83a16d10eedb..090a4667931e 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -458,7 +458,7 @@ static void bpq_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->flags      = 0;
-	dev->features	= NETIF_F_LLTX;	/* Allow recursion */
+	dev->priv_flags	= IFF_LLTX;	/* Allow recursion */
 
 #if IS_ENABLED(CONFIG_AX25)
 	dev->header_ops      = &ax25_header_ops;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5920f7e63352..5a2e7fc397e1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -114,7 +114,7 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL)
 
 #define IPVLAN_ALWAYS_ON \
-	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_LLTX | NETIF_F_VLAN_CHALLENGED)
+	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_VLAN_CHALLENGED)
 
 #define IPVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
@@ -141,6 +141,7 @@ static int ipvlan_init(struct net_device *dev)
 	dev->vlan_features = phy_dev->vlan_features & IPVLAN_FEATURES;
 	dev->vlan_features |= IPVLAN_ALWAYS_ON_OFLOADS;
 	dev->hw_enc_features |= dev->features;
+	dev->priv_flags |= IFF_LLTX;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f6eab66c2660..f38f0017b70a 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -175,6 +175,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->priv_flags		|= IFF_LLTX;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -183,7 +184,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
 		| NETIF_F_HIGHDMA
-		| NETIF_F_LLTX
 		| NETIF_F_NETNS_LOCAL
 		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 0206b84284ab..5146feb52be7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3524,7 +3524,8 @@ static int macsec_dev_init(struct net_device *dev)
 		return err;
 
 	dev->features = real_dev->features & MACSEC_FEATURES;
-	dev->features |= NETIF_F_LLTX | NETIF_F_GSO_SOFTWARE;
+	dev->features |= NETIF_F_GSO_SOFTWARE;
+	dev->priv_flags |= IFF_LLTX;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	macsec_set_head_tail_room(dev);
@@ -3555,7 +3556,6 @@ static netdev_features_t macsec_fix_features(struct net_device *dev,
 
 	features &= (real_dev->features & MACSEC_FEATURES) |
 		    NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES;
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0cec2783a3e7..d8fca9e355cf 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -900,7 +900,7 @@ static struct lock_class_key macvlan_netdev_addr_lock_key;
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE | \
 	 NETIF_F_GSO_ROBUST | NETIF_F_GSO_ENCAP_ALL)
 
-#define ALWAYS_ON_FEATURES (ALWAYS_ON_OFFLOADS | NETIF_F_LLTX)
+#define ALWAYS_ON_FEATURES ALWAYS_ON_OFFLOADS
 
 #define MACVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
@@ -932,6 +932,7 @@ static int macvlan_init(struct net_device *dev)
 	dev->vlan_features	= lowerdev->vlan_features & MACVLAN_FEATURES;
 	dev->vlan_features	|= ALWAYS_ON_OFFLOADS;
 	dev->hw_enc_features    |= dev->features;
+	dev->priv_flags		|= IFF_LLTX;
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
 	macvlan_set_lockdep_class(dev);
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0c916a53d7c..5ce1df4a6e3d 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -726,13 +726,10 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	failover_dev->ethtool_ops = &failover_ethtool_ops;
 
 	/* Initialize the device options */
-	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
+	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE | IFF_LLTX;
 	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
 				       IFF_TX_SKB_SHARING);
 
-	/* don't acquire failover netdev's netif_tx_lock when transmitting */
-	failover_dev->features |= NETIF_F_LLTX;
-
 	/* Don't allow failover devices to change network namespaces. */
 	failover_dev->features |= NETIF_F_NETNS_LOCAL;
 
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a4d2e76a8d58..65247de21761 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -242,11 +242,12 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LLTX;
 
 	dev->ethtool_ops = &netkit_ethtool_ops;
 	dev->netdev_ops  = &netkit_netdev_ops;
 
-	dev->features |= netkit_features | NETIF_F_LLTX;
+	dev->features |= netkit_features;
 	dev->hw_features = netkit_features;
 	dev->hw_enc_features = netkit_features;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index e5a0987a263e..e08eec154227 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -62,14 +62,13 @@ static const struct net_device_ops nlmon_ops = {
 static void nlmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_NETLINK;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
 
 	dev->netdev_ops	= &nlmon_ops;
 	dev->ethtool_ops = &nlmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
-			NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
 	dev->flags = IFF_NOARP;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index fe380fe196e7..4d0d97645fa9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1616,7 +1616,7 @@ static void ppp_setup(struct net_device *dev)
 	dev->netdev_ops = &ppp_netdev_ops;
 	SET_NETDEV_DEVTYPE(dev, &ppp_type);
 
-	dev->features |= NETIF_F_LLTX;
+	dev->priv_flags |= IFF_LLTX;
 
 	dev->hard_header_len = PPP_HDRLEN;
 	dev->mtu = PPP_MRU;
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 4eececc94513..5ca6d236b8d7 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -515,7 +515,7 @@ static int rionet_setup_netdev(struct rio_mport *mport, struct net_device *ndev)
 	/* MTU range: 68 - 4082 */
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->max_mtu = RIONET_MAX_MTU;
-	ndev->features = NETIF_F_LLTX;
+	ndev->priv_flags |= IFF_LLTX;
 	SET_NETDEV_DEV(ndev, &mport->dev);
 	ndev->ethtool_ops = &rionet_ethtool_ops;
 
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4e3c8d404957..396c1f7cae09 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2188,9 +2188,8 @@ static void team_setup(struct net_device *dev)
 	 * bring us to promisc mode in case a unicast addr is added.
 	 * Let this up to underlay drivers.
 	 */
-	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
 
-	dev->features |= NETIF_F_LLTX;
 	dev->features |= NETIF_F_GRO;
 
 	/* Don't allow team devices to change network namespaces. */
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..d3d2cc392f59 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -990,10 +990,11 @@ static int tun_net_init(struct net_device *dev)
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
-	dev->features = dev->hw_features | NETIF_F_LLTX;
+	dev->features = dev->hw_features;
 	dev->vlan_features = dev->features &
 			     ~(NETIF_F_HW_VLAN_CTAG_TX |
 			       NETIF_F_HW_VLAN_STAG_TX);
+	dev->priv_flags |= IFF_LLTX;
 
 	tun->flags = (tun->flags & ~TUN_FEATURES) |
 		      (ifr->ifr_flags & TUN_FEATURES);
@@ -1129,7 +1130,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
-	/* NETIF_F_LLTX requires to do our own update of trans_start */
+	/* IFF_LLTX requires to do our own update of trans_start */
 	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index bcdfbf61eb66..4b2a437ff634 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1695,11 +1695,11 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
+	dev->priv_flags |= IFF_LLTX;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
 	dev->ethtool_ops = &veth_ethtool_ops;
-	dev->features |= NETIF_F_LLTX;
 	dev->features |= VETH_FEATURES;
 	dev->vlan_features = dev->features &
 			     ~(NETIF_F_HW_VLAN_CTAG_TX |
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bb95ce43cd97..c3c009f2d39a 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1655,9 +1655,6 @@ static void vrf_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	eth_hw_addr_random(dev);
 
-	/* don't acquire vrf device's netif_tx_lock when transmitting */
-	dev->features |= NETIF_F_LLTX;
-
 	/* don't allow vrf devices to change network namespaces. */
 	dev->features |= NETIF_F_NETNS_LOCAL;
 
@@ -1676,6 +1673,8 @@ static void vrf_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	/* don't acquire vrf device's netif_tx_lock when transmitting */
+	dev->priv_flags |= IFF_LLTX;
 
 	/* VRF devices do not care about MTU, but if the MTU is set
 	 * too low then the ipv4 and ipv6 protocols are disabled
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index a1ba5169ed5d..2fcdd80850d9 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -82,14 +82,13 @@ static const struct ethtool_ops vsockmon_ethtool_ops = {
 static void vsockmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_VSOCKMON;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
 
 	dev->netdev_ops	= &vsockmon_ops;
 	dev->ethtool_ops = &vsockmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
-			NETIF_F_HIGHDMA | NETIF_F_LLTX;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
 
 	dev->flags = IFF_NOARP;
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 72ecf6cf809c..4f2b48955073 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3292,7 +3292,6 @@ static void vxlan_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
 
-	dev->features	|= NETIF_F_LLTX;
 	dev->features	|= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->features   |= NETIF_F_RXCSUM;
 	dev->features   |= NETIF_F_GSO_SOFTWARE;
@@ -3302,7 +3301,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 	netif_keep_dst(dev);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_CHANGE_PROTO_DOWN;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_CHANGE_PROTO_DOWN | IFF_LLTX;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 3feb36ee5bfb..1492ea6c48b9 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -288,8 +288,7 @@ static void wg_setup(struct net_device *dev)
 	dev->needed_tailroom = noise_encrypted_len(MESSAGE_PADDING_MULTIPLE);
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-	dev->priv_flags |= IFF_NO_QUEUE;
-	dev->features |= NETIF_F_LLTX;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
 	dev->features |= WG_NETDEV_FEATURES;
 	dev->hw_features |= WG_NETDEV_FEATURES;
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..4bd3d1a3b9df 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -425,7 +425,7 @@ int cvm_oct_common_init(struct net_device *dev)
 		dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
 
 	/* We do our own locking, Linux doesn't need to */
-	dev->features |= NETIF_F_LLTX;
+	dev->priv_flags |= IFF_LLTX;
 	dev->ethtool_ops = &cvm_oct_ethtool_ops;
 
 	cvm_oct_set_mac_filter(dev);
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 569e6d2dc55c..c13bb6d96b66 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15077,8 +15077,7 @@ static struct skb_segment_test skb_segment_tests[] __initconst = {
 		.build_skb = build_test_skb_linear_no_head_frag,
 		.features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_GSO |
-			    NETIF_F_LLTX | NETIF_F_GRO |
-			    NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
+			    NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_STAG_TX
 	}
 };
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 39876eff51d2..90b649a51199 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -569,7 +569,8 @@ static int vlan_dev_init(struct net_device *dev)
 	if (real_dev->vlan_features & NETIF_F_HW_MACSEC)
 		dev->hw_features |= NETIF_F_HW_MACSEC;
 
-	dev->features |= dev->hw_features | NETIF_F_LLTX;
+	dev->features |= dev->hw_features;
+	dev->priv_flags |= IFF_LLTX;
 	netif_inherit_tso_max(dev, real_dev);
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
@@ -655,7 +656,6 @@ static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 		lower_features |= NETIF_F_HW_CSUM;
 	features = netdev_intersect_features(features, lower_features);
 	features |= old_features & (NETIF_F_SOFT_FEATURES | NETIF_F_GSO_SOFTWARE);
-	features |= NETIF_F_LLTX;
 
 	return features;
 }
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 89c51b3cf430..dd7173cf5069 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1021,8 +1021,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
-	dev->features |= NETIF_F_LLTX;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_LLTX;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c366ccc8b3db..acd43839f2f5 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -480,9 +480,9 @@ void br_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->ethtool_ops = &br_ethtool_ops;
 	SET_NETDEV_DEVTYPE(dev, &br_type);
-	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE;
+	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE | IFF_LLTX;
 
-	dev->features = COMMON_FEATURES | NETIF_F_LLTX | NETIF_F_NETNS_LOCAL |
+	dev->features = COMMON_FEATURES | NETIF_F_NETNS_LOCAL |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8cfa20b..1525024b1e51 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1764,8 +1764,7 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
-	if (dev->features & NETIF_F_LLTX ||
-	    dev->priv_flags & IFF_NO_QUEUE)
+	if (dev->priv_flags & (IFF_NO_QUEUE | IFF_LLTX))
 		return false;
 
 	return IS_ENABLED(CONFIG_BQL);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1f..08cca63d6b0a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2536,11 +2536,12 @@ void dsa_user_setup_tagger(struct net_device *user)
 
 	user->features = conduit->vlan_features | NETIF_F_HW_TC;
 	user->hw_features |= NETIF_F_HW_TC;
-	user->features |= NETIF_F_LLTX;
 	if (user->needed_tailroom)
 		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
 	if (ds->needs_standalone_vlan_filtering)
 		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	user->priv_flags |= IFF_LLTX;
 }
 
 int dsa_user_suspend(struct net_device *user_dev)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..44199d1780d5 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
 	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
 	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
-	[NETIF_F_LLTX_BIT] =             "tx-lockless",
 	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
 	[NETIF_F_GRO_BIT] =              "rx-gro",
 	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e9d45133d641..561dba9e79f0 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -498,7 +498,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->header_ops = &hsr_header_ops;
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
-	dev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL | IFF_LLTX;
 
 	dev->needs_free_netdev = true;
 
@@ -508,8 +508,6 @@ void hsr_dev_setup(struct net_device *dev)
 
 	dev->features = dev->hw_features;
 
-	/* Prevent recursive tx locking */
-	dev->features |= NETIF_F_LLTX;
 	/* VLAN on top of HSR needs testing and probably some work on
 	 * hsr_header_create() etc.
 	 */
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index c3af965dc407..01f217190e25 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -996,7 +996,7 @@ static void __gre_tunnel_init(struct net_device *dev)
 	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 	dev->needed_headroom = tunnel->hlen + sizeof(tunnel->parms.iph);
 
-	dev->features		|= GRE_FEATURES | NETIF_F_LLTX;
+	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
@@ -1010,6 +1010,8 @@ static void __gre_tunnel_init(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+
+	dev->priv_flags |= IFF_LLTX;
 }
 
 static int ipgre_tunnel_init(struct net_device *dev)
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 14536da9f5dc..08c22d426c85 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -443,7 +443,7 @@ static int vti_tunnel_init(struct net_device *dev)
 
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->priv_flags		|= IFF_LLTX;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 923a2ef68c2f..2ef9a06b0e34 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -378,7 +378,7 @@ static void ipip_tunnel_setup(struct net_device *dev)
 	dev->type		= ARPHRD_TUNNEL;
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->priv_flags		|= IFF_LLTX;
 	netif_keep_dst(dev);
 
 	dev->features		|= IPIP_FEATURES;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 95fbdaf85711..62326b6d7d92 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1472,7 +1472,7 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 {
 	struct ip6_tnl *nt = netdev_priv(dev);
 
-	dev->features		|= GRE6_FEATURES | NETIF_F_LLTX;
+	dev->features		|= GRE6_FEATURES;
 	dev->hw_features	|= GRE6_FEATURES;
 
 	/* TCP offload with GRE SEQ is not supported, nor can we support 2
@@ -1486,6 +1486,8 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+
+	dev->priv_flags |= IFF_LLTX;
 }
 
 static int ip6gre_tunnel_init_common(struct net_device *dev)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 57bb3b3ea0c5..16270e1acd23 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1846,7 +1846,7 @@ static void ip6_tnl_dev_setup(struct net_device *dev)
 	dev->type = ARPHRD_TUNNEL6;
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);
-	dev->features |= NETIF_F_LLTX;
+	dev->priv_flags |= IFF_LLTX;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 83b195f09561..b8d229cf8f8d 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1435,7 +1435,7 @@ static void ipip6_tunnel_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	netif_keep_dst(dev);
 	dev->addr_len		= 4;
-	dev->features		|= NETIF_F_LLTX;
+	dev->priv_flags		|= IFF_LLTX;
 	dev->features		|= SIT_FEATURES;
 	dev->hw_features	|= SIT_FEATURES;
 	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 39e487ccc468..6306ee2bc47b 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -109,7 +109,7 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &l2tpeth_type);
 	ether_setup(dev);
 	dev->priv_flags		&= ~IFF_TX_SKB_SHARING;
-	dev->features		|= NETIF_F_LLTX;
+	dev->priv_flags		|= IFF_LLTX;
 	dev->netdev_ops		= &l2tp_eth_netdev_ops;
 	dev->needs_free_netdev	= true;
 }
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 74c88a6baa43..7f96ba7a27c1 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -102,20 +102,20 @@ static void do_setup(struct net_device *netdev)
 
 	netdev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_OPENVSWITCH |
-			      IFF_NO_QUEUE;
+			      IFF_NO_QUEUE | IFF_LLTX;
 	netdev->needs_free_netdev = true;
 	netdev->priv_destructor = NULL;
 	netdev->ethtool_ops = &internal_dev_ethtool_ops;
 	netdev->rtnl_link_ops = &internal_dev_link_ops;
 
-	netdev->features = NETIF_F_LLTX | NETIF_F_SG | NETIF_F_FRAGLIST |
-			   NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			   NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL;
+	netdev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
+			   NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE |
+			   NETIF_F_GSO_ENCAP_ALL;
 
 	netdev->vlan_features = netdev->features;
 	netdev->hw_enc_features = netdev->features;
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
-	netdev->hw_features = netdev->features & ~NETIF_F_LLTX;
+	netdev->hw_features = netdev->features;
 
 	eth_hw_addr_random(netdev);
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 4df5c06e3ece..dd2b96bbf363 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -769,7 +769,7 @@ static int xfrmi_dev_init(struct net_device *dev)
 	if (err)
 		return err;
 
-	dev->features |= NETIF_F_LLTX;
+	dev->priv_flags |= IFF_LLTX;
 	dev->features |= XFRMI_FEATURES;
 	dev->hw_features |= XFRMI_FEATURES;
 
-- 
2.44.0


