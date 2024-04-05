Return-Path: <linux-kernel+bounces-133086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C1899E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DBA283C9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8716D9C3;
	Fri,  5 Apr 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GO2l6NUc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E516E89D;
	Fri,  5 Apr 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324375; cv=none; b=ZLUgt/9nmiwtMcBQRBzuGLt+dleK59HhHiziah47Ki932WQAReC4U0CXqTl434XfENZJhyBRonL6+Dr1ac7upRn6Xz7XKq0Z015L3ob+zNSmkJNPddUWQWSWkn/RUfpm5vkSGnLybNE4Vnbnelh6Kasw8QQt8zu++bZ8LO8av8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324375; c=relaxed/simple;
	bh=2xNkmbDv2SWNtXDcTpaRPEKvPE6T8Iph7/ff5SiDq0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhS0cqmE7j2TbcoFr4FSZe+ypcrUeHTxnlFb97gzUyRxEBvKvBrLhcTsKJNBji2HMI7mRIUgAa85GVaONx7fGPOdJ0uBM24eWskIXA9F/pAjm3S6xXclqMjo0SlS1Cdskt6/fB46/ydgpf04sAZeDT8EIvBNQdpwvgeyHrFQKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GO2l6NUc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324373; x=1743860373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xNkmbDv2SWNtXDcTpaRPEKvPE6T8Iph7/ff5SiDq0E=;
  b=GO2l6NUcTJGduN93uBzuyrzL1h6gdM0mKmHYJ5HcJPdSuQ7klRlyO2qk
   ovuL2TlNp7p5v7YX8XjmGwImSo9wriTz6Bm0RNswKd1FB/A2WRLapHpjd
   ed/QSiKvhOSlTxBs/NLldKkc3UXbrboVWdgW4wjinF0oghBfdfczphAAL
   /6EupsD5+i9tpXpYDMhYjWMq7mVdrEJI9uaWwzlldfhmi/6/mNvs1+Y/G
   MU2pWWhsdLecA5NEa5un/+jfATCQ6aFVUPB6lxxsyayqwPdL6ZLeuWwoy
   IXhbxpuVdDe/ZgigCRrjp0nq3OtdbtaviZIoB5lM9JJOnoNBnbNGSQnnK
   g==;
X-CSE-ConnectionGUID: ckhHlai9RWa443GtnoL5FQ==
X-CSE-MsgGUID: bgBYJHYaRly3sCCFIpCQLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219637"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219637"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:33 -0700
X-CSE-ConnectionGUID: D1PUKHnrTEypwCesbnfADg==
X-CSE-MsgGUID: mPaIoziWS9q4RjkSIwIi1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600162"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:31 -0700
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
Subject: [PATCH RFC net-next 7/7] netdev_features: convert NETIF_F_FCOE_MTU to IFF_FCOE_MTU
Date: Fri,  5 Apr 2024 15:37:31 +0200
Message-ID: <20240405133731.1010128-8-aleksander.lobakin@intel.com>
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

Ability to handle maximum FCoE frames of 2158 bytes can never be changed
and thus more of an attribute, not a toggleable feature.
Move it from netdev_features_t to netdev_priv_flags and free one more
feature bit.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h                 | 5 +----
 include/linux/netdevice.h                       | 2 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c | 6 ++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c   | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c    | 3 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 9 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  | 4 ++--
 drivers/scsi/fcoe/fcoe.c                        | 4 ++--
 net/8021q/vlan_dev.c                            | 1 +
 net/ethtool/common.c                            | 1 -
 11 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 318c35c94305..9713069198e1 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -53,7 +53,6 @@ enum {
 
 	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
 	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
-	NETIF_F_FCOE_MTU_BIT,		/* Supports max FCoE MTU, 2158 bytes*/
 	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
 	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
 	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
@@ -100,7 +99,6 @@ enum {
 #define __NETIF_F(name)		__NETIF_F_BIT(NETIF_F_##name##_BIT)
 
 #define NETIF_F_FCOE_CRC	__NETIF_F(FCOE_CRC)
-#define NETIF_F_FCOE_MTU	__NETIF_F(FCOE_MTU)
 #define NETIF_F_FRAGLIST	__NETIF_F(FRAGLIST)
 #define NETIF_F_FSO		__NETIF_F(FSO)
 #define NETIF_F_GRO		__NETIF_F(GRO)
@@ -200,8 +198,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 #define NETIF_F_ALL_TSO 	(NETIF_F_TSO | NETIF_F_TSO6 | \
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
-#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FCOE_MTU | \
-				 NETIF_F_FSO)
+#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FSO)
 
 /* List of features with software fallbacks. */
 #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 57b8d3783b3f..09e25163e3d8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1654,6 +1654,7 @@ struct net_device_ops {
  * @IFF_NETNS_LOCAL: interface can't change network namespaces
  * @IFF_HIGHDMA: device can transmit buffers from high memory
  * @IFF_VLAN_CHALLENGED: device can't handle VLAN packets
+ * @IFF_FCOE_MTU: device supports maximum FCoE MTU, 2158 bytes
  * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
  *	interfaces to avoid overhead from locking and Qdisc.
  * @IFF_ONE_FOR_ALL: if one interface supports them, enable them for all in
@@ -1700,6 +1701,7 @@ enum netdev_priv_flags {
 	IFF_NETNS_LOCAL			= BIT_ULL(35),
 	IFF_HIGHDMA			= BIT_ULL(36),
 	IFF_VLAN_CHALLENGED		= BIT_ULL(37),
+	IFF_FCOE_MTU			= BIT_ULL(38),
 	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
 	IFF_ONE_FOR_ALL			= IFF_HIGHDMA | IFF_VLAN_CHALLENGED,
 	IFF_ALL_FOR_ALL			= IFF_XMIT_DST_RELEASE |
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
index 33b2c0c45509..6f6f36f06bb5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c
@@ -81,8 +81,7 @@ int cxgb_fcoe_enable(struct net_device *netdev)
 
 	netdev->features |= NETIF_F_FCOE_CRC;
 	netdev->vlan_features |= NETIF_F_FCOE_CRC;
-	netdev->features |= NETIF_F_FCOE_MTU;
-	netdev->vlan_features |= NETIF_F_FCOE_MTU;
+	netdev->priv_flags |= IFF_FCOE_MTU;
 
 	netdev_features_change(netdev);
 
@@ -112,8 +111,7 @@ int cxgb_fcoe_disable(struct net_device *netdev)
 
 	netdev->features &= ~NETIF_F_FCOE_CRC;
 	netdev->vlan_features &= ~NETIF_F_FCOE_CRC;
-	netdev->features &= ~NETIF_F_FCOE_MTU;
-	netdev->vlan_features &= ~NETIF_F_FCOE_MTU;
+	netdev->priv_flags &= ~IFF_FCOE_MTU;
 
 	netdev_features_change(netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index e85f7d2e8810..dcfebe9f6aa6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -317,7 +317,7 @@ static u8 ixgbe_dcbnl_set_all(struct net_device *netdev)
 		int max_frame = adapter->netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 
 #ifdef IXGBE_FCOE
-		if (adapter->netdev->features & NETIF_F_FCOE_MTU)
+		if (adapter->netdev->priv_flags & IFF_FCOE_MTU)
 			max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 18d63c8c2ff4..3be287a11a96 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -858,7 +858,7 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 
 	/* enable FCoE and notify stack */
 	adapter->flags |= IXGBE_FLAG_FCOE_ENABLED;
-	netdev->features |= NETIF_F_FCOE_MTU;
+	netdev->priv_flags |= IFF_FCOE_MTU;
 	netdev_features_change(netdev);
 
 	/* release existing queues and reallocate them */
@@ -898,7 +898,7 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 
 	/* disable FCoE and notify stack */
 	adapter->flags &= ~IXGBE_FLAG_FCOE_ENABLED;
-	netdev->features &= ~NETIF_F_FCOE_MTU;
+	netdev->priv_flags &= ~IFF_FCOE_MTU;
 
 	netdev_features_change(netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 0ee943db3dc9..81eda51a79e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -981,7 +981,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 			set_bit(__IXGBE_RX_CSUM_UDP_ZERO_ERR, &ring->state);
 
 #ifdef IXGBE_FCOE
-		if (adapter->netdev->features & NETIF_F_FCOE_MTU) {
+		if (adapter->netdev->priv_flags & IFF_FCOE_MTU) {
 			struct ixgbe_ring_feature *f;
 			f = &adapter->ring_feature[RING_F_FCOE];
 			if ((rxr_idx >= f->offset) &&
@@ -1299,4 +1299,3 @@ void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
 	context_desc->type_tucmd_mlhl	= cpu_to_le32(type_tucmd);
 	context_desc->mss_l4len_idx	= cpu_to_le32(mss_l4len_idx);
 }
-
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index da5d21d55278..b49208a75c9c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5080,7 +5080,7 @@ static void ixgbe_configure_dcb(struct ixgbe_adapter *adapter)
 		netif_set_tso_max_size(adapter->netdev, 32768);
 
 #ifdef IXGBE_FCOE
-	if (adapter->netdev->features & NETIF_F_FCOE_MTU)
+	if (adapter->netdev->priv_flags & IFF_FCOE_MTU)
 		max_frame = max(max_frame, IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif
 
@@ -5137,7 +5137,7 @@ static int ixgbe_hpbthresh(struct ixgbe_adapter *adapter, int pb)
 
 #ifdef IXGBE_FCOE
 	/* FCoE traffic class uses FCOE jumbo frames */
-	if ((dev->features & NETIF_F_FCOE_MTU) &&
+	if ((dev->priv_flags & IFF_FCOE_MTU) &&
 	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
 	    (pb == ixgbe_fcoe_get_tc(adapter)))
 		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
@@ -5198,7 +5198,7 @@ static int ixgbe_lpbthresh(struct ixgbe_adapter *adapter, int pb)
 
 #ifdef IXGBE_FCOE
 	/* FCoE traffic class uses FCOE jumbo frames */
-	if ((dev->features & NETIF_F_FCOE_MTU) &&
+	if ((dev->priv_flags & IFF_FCOE_MTU) &&
 	    (tc < IXGBE_FCOE_JUMBO_FRAME_SIZE) &&
 	    (pb == netdev_get_prio_tc_map(dev, adapter->fcoe.up)))
 		tc = IXGBE_FCOE_JUMBO_FRAME_SIZE;
@@ -11096,8 +11096,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				    NETIF_F_FCOE_CRC;
 
 		netdev->vlan_features |= NETIF_F_FSO |
-					 NETIF_F_FCOE_CRC |
-					 NETIF_F_FCOE_MTU;
+					 NETIF_F_FCOE_CRC;
 	}
 #endif /* IXGBE_FCOE */
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_CAPABLE)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index fcfd0a075eee..4e478cf79a2c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -495,7 +495,7 @@ static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 max_frame, u32 vf
 		int err = 0;
 
 #ifdef CONFIG_FCOE
-		if (dev->features & NETIF_F_FCOE_MTU)
+		if (dev->priv_flags & IFF_FCOE_MTU)
 			pf_max_frame = max_t(int, pf_max_frame,
 					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
 
@@ -857,7 +857,7 @@ static void ixgbe_set_vf_rx_tx(struct ixgbe_adapter *adapter, int vf)
 		int pf_max_frame = dev->mtu + ETH_HLEN;
 
 #if IS_ENABLED(CONFIG_FCOE)
-		if (dev->features & NETIF_F_FCOE_MTU)
+		if (dev->priv_flags & IFF_FCOE_MTU)
 			pf_max_frame = max_t(int, pf_max_frame,
 					     IXGBE_FCOE_JUMBO_FRAME_SIZE);
 #endif /* CONFIG_FCOE */
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f1429f270170..19a16a63d969 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -722,7 +722,7 @@ static int fcoe_netdev_config(struct fc_lport *lport, struct net_device *netdev)
 	 * will return 0, so do this first.
 	 */
 	mfs = netdev->mtu;
-	if (netdev->features & NETIF_F_FCOE_MTU) {
+	if (netdev->priv_flags & IFF_FCOE_MTU) {
 		mfs = FCOE_MTU;
 		FCOE_NETDEV_DBG(netdev, "Supports FCOE_MTU of %d bytes\n", mfs);
 	}
@@ -1863,7 +1863,7 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 	case NETDEV_CHANGE:
 		break;
 	case NETDEV_CHANGEMTU:
-		if (netdev->features & NETIF_F_FCOE_MTU)
+		if (netdev->priv_flags & IFF_FCOE_MTU)
 			break;
 		mfs = netdev->mtu - (sizeof(struct fcoe_hdr) +
 				     sizeof(struct fcoe_crc_eof));
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 421419ebac41..69afcba94b8e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -570,6 +570,7 @@ static int vlan_dev_init(struct net_device *dev)
 
 	dev->features |= dev->hw_features;
 	dev->priv_flags |= IFF_LLTX | (real_dev->priv_flags & IFF_HIGHDMA);
+	dev->priv_flags |= IFF_FCOE_MTU;
 	netif_inherit_tso_max(dev, real_dev);
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2de4dd5a30de..71e36e1a1b15 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -47,7 +47,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 
 	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
 	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
-	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",
 	[NETIF_F_NTUPLE_BIT] =           "rx-ntuple-filter",
 	[NETIF_F_RXHASH_BIT] =           "rx-hashing",
 	[NETIF_F_RXCSUM_BIT] =           "rx-checksum",
-- 
2.44.0


