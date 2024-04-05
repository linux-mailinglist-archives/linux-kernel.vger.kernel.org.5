Return-Path: <linux-kernel+bounces-133084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45803899E92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D2BB2456B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA516F0C2;
	Fri,  5 Apr 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEMY9hTb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36016E879;
	Fri,  5 Apr 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324373; cv=none; b=NZLeT4Vl7Ey0C3r7JN/0ErthItzNk0UmOmzVdMDrdgOdaM9BWdQXJ6m0tP0/2gdqZJIC71hS2wa8I4V6K1UkUKL2PYue1vhopbxwcIOGZwXz7QWGJoIWtQwE3mf7EYT6fmjmiExFqHwP9fXsOAilEHFHAeIo+5SZ7qajC8xmUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324373; c=relaxed/simple;
	bh=RoeL9dxNSQ1roCSKpOrPf2w/odt2OIKeCOOcBntwUXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBnDxq6eiFx2ZeeyIPISS8qVyV/Tg1zzNaQQE9lB3FdWCDv974jVnzuvl43gBefWRwh29sBxyy4a2SidVyYLScufrBZWsWm8w5NzZerpBrTgkGWxUAIbLFeSTyeIInn/GkRIY6pSNPO3fIotrubia1ykVIY85M1eAR2D/ru5fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEMY9hTb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324367; x=1743860367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoeL9dxNSQ1roCSKpOrPf2w/odt2OIKeCOOcBntwUXA=;
  b=PEMY9hTbNODQ23ASpWvP+n6ztfnLLmnYJFoHpDTtmfOw/YD3LsZtMca3
   gZCHsrqtLIhTMjh76Lk5aQ3cSiqmzLfreZBk7Vmvpo7dxooAo0nZAzRMF
   bVgpljRfn9N6E/GMoUxvuuBkLx2tCLnDb4233U5iBqeZyFwewAK0cAo1C
   REqmLX8KeF0jBbZfStSX7ytU9yX9M0VDB86qQepQ+V5cCdb4PcWiEIwWw
   ZOcWI/b1akfHZpbDIGPAKEyHn6JpBKK/4akyoC5kZIS+otcSYWDh64OsN
   pYEaVckRcNDjT8mWdhWkybWkxO4VFmok7T6/S4vd2GJcX9FWpLMfOfxsr
   w==;
X-CSE-ConnectionGUID: ybZq36UoR8KPhP10s6BDZA==
X-CSE-MsgGUID: iwV7xbVrQG+g+Br/0YWygg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219603"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219603"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:27 -0700
X-CSE-ConnectionGUID: 5ApT8jVaSr2/QwOjTgR3Vg==
X-CSE-MsgGUID: lZvyYkytSSGEnhxxPV5s2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600136"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:24 -0700
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
Subject: [PATCH RFC net-next 5/7] netdev_features: convert NETIF_F_HIGHDMA to priv_flag IFF_HIGHDMA
Date: Fri,  5 Apr 2024 15:37:29 +0200
Message-ID: <20240405133731.1010128-6-aleksander.lobakin@intel.com>
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

The ability to send bufferst from the high memory is rather an
attribute, not a feature. It can't be toggled via Ethtool and
is constant for the whole interface lifetime.
Convert it to a private flag, carrying necessary inheritance for
lower interfaces.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/driver-api/usb/dma.rst          |  2 +-
 Documentation/networking/netdev-features.rst  |  5 ----
 include/linux/if_vlan.h                       |  5 ++--
 include/linux/netdev_features.h               |  6 ++---
 include/linux/netdevice.h                     | 13 +++++++++
 include/net/mac80211.h                        |  1 +
 include/net/net_failover.h                    |  6 ++++-
 net/mac80211/ieee80211_i.h                    |  4 +--
 drivers/firewire/net.c                        |  2 +-
 drivers/infiniband/hw/hfi1/vnic_main.c        |  3 ++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  4 +--
 drivers/net/bonding/bond_main.c               | 20 +++++++-------
 drivers/net/dummy.c                           |  4 +--
 drivers/net/ethernet/adaptec/starfire.c       |  2 +-
 drivers/net/ethernet/aeroflex/greth.c         |  3 ++-
 drivers/net/ethernet/alteon/acenic.c          |  2 +-
 drivers/net/ethernet/altera/altera_tse_main.c |  3 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  5 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c    |  4 +--
 drivers/net/ethernet/broadcom/bnx2.c          |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  5 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 ++---
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  4 +--
 drivers/net/ethernet/broadcom/tg3.c           |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c       |  9 +++----
 drivers/net/ethernet/calxeda/xgmac.c          |  4 +--
 .../net/ethernet/cavium/liquidio/lio_main.c   |  4 +--
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  4 +--
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |  4 +--
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  4 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  6 ++---
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  6 ++---
 drivers/net/ethernet/cisco/enic/enic_main.c   |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c   |  5 ++--
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  4 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  5 ++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  4 +--
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  3 ++-
 drivers/net/ethernet/freescale/gianfar.c      |  3 ++-
 .../ethernet/fungible/funeth/funeth_main.c    |  5 ++--
 drivers/net/ethernet/google/gve/gve_main.c    |  2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c |  4 +--
 .../net/ethernet/huawei/hinic/hinic_main.c    |  4 ++-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     |  6 ++---
 drivers/net/ethernet/intel/e1000/e1000_main.c |  6 ++---
 drivers/net/ethernet/intel/e1000e/netdev.c    |  5 +---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  6 ++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  3 +--
 drivers/net/ethernet/intel/ice/ice_main.c     |  5 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     |  4 +--
 drivers/net/ethernet/intel/igbvf/netdev.c     |  3 ++-
 drivers/net/ethernet/intel/igc/igc_main.c     |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 +--
 drivers/net/ethernet/jme.c                    |  6 ++---
 drivers/net/ethernet/marvell/skge.c           |  2 +-
 drivers/net/ethernet/marvell/sky2.c           |  2 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +--
 .../net/ethernet/myricom/myri10ge/myri10ge.c  |  4 ++-
 drivers/net/ethernet/natsemi/ns83820.c        |  4 +--
 drivers/net/ethernet/neterion/s2io.c          |  4 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  3 +--
 drivers/net/ethernet/nvidia/forcedeth.c       |  4 +--
 drivers/net/ethernet/pasemi/pasemi_mac.c      |  5 ++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +--
 .../ethernet/qlogic/netxen/netxen_nic_main.c  |  6 ++---
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  6 ++---
 drivers/net/ethernet/qlogic/qla3xxx.c         |  2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  6 ++---
 drivers/net/ethernet/realtek/8139cp.c         |  5 ++--
 drivers/net/ethernet/realtek/8139too.c        |  3 ++-
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   |  4 +--
 drivers/net/ethernet/sfc/ef100_netdev.c       |  3 ++-
 drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
 drivers/net/ethernet/sfc/efx.c                |  4 +--
 drivers/net/ethernet/sfc/falcon/efx.c         |  3 +--
 drivers/net/ethernet/sfc/siena/efx.c          |  4 +--
 drivers/net/ethernet/sgi/ioc3-eth.c           |  3 ++-
 drivers/net/ethernet/silan/sc92031.c          |  4 +--
 drivers/net/ethernet/socionext/netsec.c       |  3 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +--
 drivers/net/ethernet/sun/cassini.c            |  2 +-
 drivers/net/ethernet/sun/niu.c                |  2 +-
 drivers/net/ethernet/sun/sungem.c             |  2 +-
 drivers/net/ethernet/tehuti/tehuti.c          |  5 ++--
 drivers/net/ethernet/tundra/tsi108_eth.c      |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c   |  1 -
 drivers/net/hyperv/netvsc_drv.c               |  4 +--
 drivers/net/ifb.c                             |  4 +--
 drivers/net/ipvlan/ipvlan_main.c              |  4 +--
 drivers/net/loopback.c                        |  3 +--
 drivers/net/macsec.c                          |  4 +--
 drivers/net/macvlan.c                         |  9 ++++---
 drivers/net/net_failover.c                    | 24 ++++++++++-------
 drivers/net/netdevsim/netdev.c                |  6 ++---
 drivers/net/netkit.c                          |  2 +-
 drivers/net/nlmon.c                           |  4 +--
 drivers/net/ntb_netdev.c                      |  3 +--
 drivers/net/tap.c                             |  3 ++-
 drivers/net/team/team_core.c                  | 17 +++++++-----
 drivers/net/thunderbolt/main.c                |  3 ++-
 drivers/net/usb/r8152.c                       |  5 ++--
 drivers/net/veth.c                            |  3 ++-
 drivers/net/virtio_net.c                      |  3 +--
 drivers/net/vmxnet3/vmxnet3_drv.c             |  3 ++-
 drivers/net/vrf.c                             |  3 ++-
 drivers/net/vsockmon.c                        |  4 +--
 drivers/net/wireguard/device.c                |  4 +--
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  6 +++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +++--
 drivers/usb/fotg210/fotg210-hcd.c             |  2 +-
 drivers/usb/host/ehci-hcd.c                   |  2 +-
 drivers/usb/host/oxu210hp-hcd.c               |  2 +-
 net/8021q/vlan_dev.c                          |  5 ++--
 net/bridge/br_device.c                        |  3 ++-
 net/core/dev.c                                | 27 +++++++++++++++----
 net/ethtool/common.c                          |  1 -
 net/hsr/hsr_device.c                          |  3 ++-
 net/ipv4/ip_gre.c                             |  3 +--
 net/ipv4/ipip.c                               |  3 +--
 net/ipv6/ip6_gre.c                            |  3 +--
 net/ipv6/ip6_tunnel.c                         |  3 +--
 net/ipv6/sit.c                                |  3 +--
 net/mac80211/iface.c                          |  2 ++
 net/openvswitch/vport-internal_dev.c          |  4 +--
 132 files changed, 304 insertions(+), 268 deletions(-)

diff --git a/Documentation/driver-api/usb/dma.rst b/Documentation/driver-api/usb/dma.rst
index 02f6825ff830..b015e43f9629 100644
--- a/Documentation/driver-api/usb/dma.rst
+++ b/Documentation/driver-api/usb/dma.rst
@@ -78,7 +78,7 @@ and effects like cache-trashing can impose subtle penalties.
   way to expose these capabilities ... and in any case, HIGHMEM is mostly a
   design wart specific to x86_32.  So your best bet is to ensure you never
   pass a highmem buffer into a USB driver.  That's easy; it's the default
-  behavior.  Just don't override it; e.g. with ``NETIF_F_HIGHDMA``.
+  behavior.  Just don't override it; e.g. with ``IFF_HIGHDMA``.
 
   This may force your callers to do some bounce buffering, copying from
   high memory to "normal" DMA memory.  If you can come up with a good way
diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 5014f7cc1398..b95c9203b1aa 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -123,11 +123,6 @@ gso_size. On segmentation, it segments the payload on gso_size boundaries and
 replicates the network and UDP headers (fixing up the last one if less than
 gso_size).
 
- * Transmit DMA from high memory
-
-On platforms where this is relevant, NETIF_F_HIGHDMA signals that
-ndo_start_xmit can handle skbs with frags in high memory.
-
  * Transmit scatter-gather
 
 Those features say that ndo_start_xmit can handle fragmented skbs:
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index c1645c86eed9..29be1160a233 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -785,9 +785,8 @@ static inline netdev_features_t vlan_features_check(struct sk_buff *skb,
 		 * sure that only devices supporting NETIF_F_HW_CSUM will
 		 * have checksum offloading support.
 		 */
-		features &= NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			    NETIF_F_FRAGLIST | NETIF_F_HW_VLAN_CTAG_TX |
-			    NETIF_F_HW_VLAN_STAG_TX;
+		features &= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST |
+			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 	}
 
 	return features;
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 3bacd4b1adc9..b8e4c7f79e88 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -16,7 +16,6 @@ enum {
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
-	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
 	NETIF_F_FRAGLIST_BIT,		/* Scatter/gather IO. */
 	NETIF_F_HW_VLAN_CTAG_TX_BIT,	/* Transmit VLAN CTAG HW acceleration */
 	NETIF_F_HW_VLAN_CTAG_RX_BIT,	/* Receive VLAN CTAG HW acceleration */
@@ -109,7 +108,6 @@ enum {
 #define NETIF_F_GRO_HW		__NETIF_F(GRO_HW)
 #define NETIF_F_GSO		__NETIF_F(GSO)
 #define NETIF_F_GSO_ROBUST	__NETIF_F(GSO_ROBUST)
-#define NETIF_F_HIGHDMA		__NETIF_F(HIGHDMA)
 #define NETIF_F_HW_CSUM		__NETIF_F(HW_CSUM)
 #define NETIF_F_HW_VLAN_CTAG_FILTER __NETIF_F(HW_VLAN_CTAG_FILTER)
 #define NETIF_F_HW_VLAN_CTAG_RX	__NETIF_F(HW_VLAN_CTAG_RX)
@@ -219,8 +217,8 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
  * for all in netdev_increment_features.
  */
 #define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ROBUST | \
-				 NETIF_F_SG | NETIF_F_HIGHDMA |		\
-				 NETIF_F_FRAGLIST | NETIF_F_VLAN_CHALLENGED)
+				 NETIF_F_SG | NETIF_F_FRAGLIST | \
+				 NETIF_F_VLAN_CHALLENGED)
 
 /*
  * If one device doesn't support one of these features, then disable it
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0fafb3db8f0b..622d135957ad 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1652,8 +1652,13 @@ struct net_device_ops {
  @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,
  *	such as tunnels.
  * @IFF_NETNS_LOCAL: interface can't change network namespaces
+ * @IFF_HIGHDMA: device can transmit buffers from high memory
  * @IFF_LOGICAL: combines @IFF_NO_QUEUE and @IFF_LLTX, used by logical
  *	interfaces to avoid overhead from locking and Qdisc.
+ * @IFF_ONE_FOR_ALL: if one interface supports them, enable them for all in
+ *	netdev_intrement_priv_flags()
+ * @IFF_ALL_FOR_ALL: if at least one interface doesn't support them, disable
+ * them for all in netdev_intrement_priv_flags()
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1692,7 +1697,11 @@ enum netdev_priv_flags {
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 	IFF_LLTX			= BIT_ULL(34),
 	IFF_NETNS_LOCAL			= BIT_ULL(35),
+	IFF_HIGHDMA			= BIT_ULL(36),
 	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
+	IFF_ONE_FOR_ALL			= IFF_HIGHDMA,
+	IFF_ALL_FOR_ALL			= IFF_XMIT_DST_RELEASE |
+					  IFF_XMIT_DST_RELEASE_PERM,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -4931,6 +4940,10 @@ static inline netdev_features_t netdev_get_wanted_features(
 netdev_features_t netdev_increment_features(netdev_features_t all,
 	netdev_features_t one, netdev_features_t mask);
 
+u64 netdev_increment_priv_flags(u64 all, u64 one, u64 mask);
+void netdev_increment_priv_flags_finalize(struct net_device *dev,
+					  u64 priv_flags);
+
 /* Allow TSO being used on stacked device :
  * Performing the GSO segmentation before last device
  * is a performance improvement.
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f57c29de3a91..78e749f6b91f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3007,6 +3007,7 @@ struct ieee80211_hw {
 		s16 accuracy;
 	} radiotap_timestamp;
 	netdev_features_t netdev_features;
+	u64 netdev_priv_flags;
 	u8 uapsd_queues;
 	u8 uapsd_max_sp_len;
 	u8 max_nan_de_entries;
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
index b12a1c469d1c..9c3f38a3da86 100644
--- a/include/net/net_failover.h
+++ b/include/net/net_failover.h
@@ -32,9 +32,13 @@ void net_failover_destroy(struct failover *failover);
 
 #define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
+				 NETIF_F_LRO)
 
 #define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
 
+#define FAILOVER_PRIV_FLAGS	(IFF_XMIT_DST_RELEASE | \
+				 IFF_XMIT_DST_RELEASE_PERM | \
+				 IFF_HIGHDMA)
+
 #endif /* _NET_FAILOVER_H */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 458f63ce9a32..9cfc722b461d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1992,11 +1992,11 @@ void ieee80211_color_collision_detection_work(struct work_struct *work);
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
-					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE | \
-					 NETIF_F_HW_TC)
+					 NETIF_F_GSO_SOFTWARE | NETIF_F_HW_TC)
 #define MAC80211_SUPPORTED_FEATURES_RX	(NETIF_F_RXCSUM)
 #define MAC80211_SUPPORTED_FEATURES	(MAC80211_SUPPORTED_FEATURES_TX | \
 					 MAC80211_SUPPORTED_FEATURES_RX)
+#define MAC80211_SUPPORTED_PRIV_FLAGS	(IFF_HIGHDMA)
 
 int ieee80211_iface_init(void);
 void ieee80211_iface_exit(void);
diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 7a4d1a478e33..903696bf3d8b 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -1377,7 +1377,7 @@ static void fwnet_init_dev(struct net_device *net)
 	net->netdev_ops		= &fwnet_netdev_ops;
 	net->watchdog_timeo	= 2 * HZ;
 	net->flags		= IFF_BROADCAST | IFF_MULTICAST;
-	net->features		= NETIF_F_HIGHDMA;
+	net->priv_flags		|= IFF_HIGHDMA;
 	net->addr_len		= FWNET_ALEN;
 	net->hard_header_len	= FWNET_HLEN;
 	net->type		= ARPHRD_IEEE1394;
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index 16a4c297a897..2b8431338e0a 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -588,9 +588,10 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 	rn->free_rdma_netdev = hfi1_vnic_free_rn;
 	rn->set_id = hfi1_vnic_set_vesw_id;
 
-	netdev->features = NETIF_F_HIGHDMA | NETIF_F_SG;
+	netdev->features = NETIF_F_SG;
 	netdev->hw_features = netdev->features;
 	netdev->vlan_features = netdev->features;
+	netdev->priv_flags |= IFF_HIGHDMA;
 	netdev->watchdog_timeo = msecs_to_jiffies(HFI_TX_TIMEOUT_MS);
 	netdev->netdev_ops = &hfi1_netdev_ops;
 	mutex_init(&vinfo->lock);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 6f2a688fccbf..888fb9c62f91 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2142,13 +2142,13 @@ void ipoib_setup_common(struct net_device *dev)
 	dev->watchdog_timeo	 = 10 * HZ;
 
 	dev->flags		|= IFF_BROADCAST | IFF_MULTICAST;
+	dev->priv_flags		|= IFF_HIGHDMA;
 
 	dev->hard_header_len	 = IPOIB_HARD_LEN;
 	dev->addr_len		 = INFINIBAND_ALEN;
 	dev->type		 = ARPHRD_INFINIBAND;
 	dev->tx_queue_len	 = ipoib_sendq_size * 2;
-	dev->features		 = (NETIF_F_VLAN_CHALLENGED	|
-				    NETIF_F_HIGHDMA);
+	dev->features		 = NETIF_F_VLAN_CHALLENGED;
 	netif_keep_dst(dev);
 
 	memcpy(dev->broadcast, ipv4_bcast_addr, INFINIBAND_ALEN);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3d28be39e211..cebf1189241c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1419,7 +1419,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 
 #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
+				 NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
@@ -1427,11 +1427,12 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_GSO_SOFTWARE)
 
+#define BOND_PRIV_FLAGS		(IFF_XMIT_DST_RELEASE | \
+				 IFF_XMIT_DST_RELEASE_PERM | \
+				 IFF_HIGHDMA)
 
 static void bond_compute_features(struct bonding *bond)
 {
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1439,6 +1440,7 @@ static void bond_compute_features(struct bonding *bond)
 #endif /* CONFIG_XFRM_OFFLOAD */
 	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
 	struct net_device *bond_dev = bond->dev;
+	u64 priv_flags = BOND_PRIV_FLAGS;
 	struct list_head *iter;
 	struct slave *slave;
 	unsigned short max_hard_header_len = ETH_HLEN;
@@ -1449,6 +1451,7 @@ static void bond_compute_features(struct bonding *bond)
 		goto done;
 	vlan_features &= NETIF_F_ALL_FOR_ALL;
 	mpls_features &= NETIF_F_ALL_FOR_ALL;
+	priv_flags &= IFF_ALL_FOR_ALL;
 
 	bond_for_each_slave(bond, slave, iter) {
 		vlan_features = netdev_increment_features(vlan_features,
@@ -1468,7 +1471,10 @@ static void bond_compute_features(struct bonding *bond)
 							  slave->dev->mpls_features,
 							  BOND_MPLS_FEATURES);
 
-		dst_release_flag &= slave->dev->priv_flags;
+		priv_flags = netdev_increment_priv_flags(priv_flags,
+							 slave->dev->priv_flags,
+							 BOND_PRIV_FLAGS);
+
 		if (slave->dev->hard_header_len > max_hard_header_len)
 			max_hard_header_len = slave->dev->hard_header_len;
 
@@ -1489,11 +1495,7 @@ static void bond_compute_features(struct bonding *bond)
 	netif_set_tso_max_segs(bond_dev, tso_max_segs);
 	netif_set_tso_max_size(bond_dev, tso_max_size);
 
-	bond_dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if ((bond_dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
-	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		bond_dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
+	netdev_increment_priv_flags_finalize(bond_dev, priv_flags);
 	netdev_change_features(bond_dev);
 }
 
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index a0122e867891..5a326ade7d2c 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -108,10 +108,10 @@ static void dummy_setup(struct net_device *dev)
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL | IFF_HIGHDMA;
 	dev->features	|= NETIF_F_SG | NETIF_F_FRAGLIST;
 	dev->features	|= NETIF_F_GSO_SOFTWARE;
-	dev->features	|= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
+	dev->features	|= NETIF_F_HW_CSUM;
 	dev->features	|= NETIF_F_GSO_ENCAP_ALL;
 	dev->hw_features |= dev->features;
 	dev->hw_enc_features |= dev->features;
diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index 857361c74f5d..de085fb720de 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -692,7 +692,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	dev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER;
 #endif /* VLAN_RX_KILL_VID */
 #ifdef ADDR_64BITS
-	dev->features |= NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_HIGHDMA;
 #endif /* ADDR_64BITS */
 
 	/* Serial EEPROM reads are hidden by the hardware. */
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 27af7746d645..19d3bdf5d7e4 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1486,7 +1486,8 @@ static int greth_of_probe(struct platform_device *ofdev)
 	if (greth->gbit_mac) {
 		dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			NETIF_F_RXCSUM;
-		dev->features = dev->hw_features | NETIF_F_HIGHDMA;
+		dev->features = dev->hw_features;
+		dev->priv_flags |= IFF_HIGHDMA;
 		greth_netdev_ops.ndo_start_xmit = greth_start_xmit_gbit;
 	}
 
diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index eafef84fe3be..c51b61c4e092 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -589,7 +589,7 @@ static int acenic_probe_one(struct pci_dev *pdev,
 	}
 	ap->name = dev->name;
 
-	dev->features |= NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	pci_set_drvdata(pdev, dev);
 
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 1c8763be0e4b..a57350b27c07 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1372,13 +1372,14 @@ static int altera_tse_probe(struct platform_device *pdev)
 	 * so it is turned off
 	 */
 	ndev->hw_features &= ~NETIF_F_SG;
-	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
+	ndev->features |= ndev->hw_features;
 
 	/* VLAN offloading of tagging, stripping and filtering is not
 	 * supported by hardware, but driver will accommodate the
 	 * extra 4-byte VLAN tag for processing by upper layers
 	 */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_HIGHDMA;
 
 	/* setup NAPI interface */
 	netif_napi_add(ndev, &priv->napi, tse_poll);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 09e7da1a69c9..4ea6f732736e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3753,11 +3753,12 @@ static void ena_set_dev_offloads(struct ena_com_dev_get_features_ctx *feat,
 	netdev->features =
 		dev_features |
 		NETIF_F_SG |
-		NETIF_F_RXHASH |
-		NETIF_F_HIGHDMA;
+		NETIF_F_RXHASH;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
+
+	netdev->priv_flags |= IFF_HIGHDMA;
 }
 
 static void ena_set_conf_feat_params(struct ena_adapter *adapter,
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..cffb0468de32 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2580,11 +2580,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	dev->netdev_ops = &bcm_sysport_netdev_ops;
 	netif_napi_add(dev, &priv->napi, bcm_sysport_poll);
 
-	dev->features |= NETIF_F_RXCSUM | NETIF_F_HIGHDMA |
-			 NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+	dev->features |= NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->max_mtu = UMAC_MAX_MTU_SIZE;
 
 	/* Request the WOL interrupt and advertise suspend if available */
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index b65b8592ad75..f5237687a6ba 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -8190,7 +8190,7 @@ bnx2_init_board(struct pci_dev *pdev, struct net_device *dev)
 
 	/* Configure DMA attributes. */
 	if (dma_set_mask(&pdev->dev, dma_mask) == 0) {
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 		rc = dma_set_coherent_mask(&pdev->dev, persist_dma_mask);
 		if (rc) {
 			dev_err(&pdev->dev,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..f701ebf68763 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13182,7 +13182,7 @@ static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
 	dev->netdev_ops = &bnx2x_netdev_ops;
 	bnx2x_set_ethtool_ops(bp, dev);
 
-	dev->priv_flags |= IFF_UNICAST_FLT;
+	dev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6 |
@@ -13211,7 +13211,7 @@ static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
 	}
 
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6 | NETIF_F_HIGHDMA;
+		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6;
 
 	if (IS_PF(bp)) {
 		if (chip_is_e1x)
@@ -13224,7 +13224,6 @@ static int bnx2x_init_dev(struct bnx2x *bp, struct pci_dev *pdev,
 	 */
 
 	dev->features |= dev->hw_features | NETIF_F_HW_VLAN_CTAG_RX;
-	dev->features |= NETIF_F_HIGHDMA;
 	if (dev->features & NETIF_F_LRO)
 		dev->features &= ~NETIF_F_GRO_HW;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 795f3f957eb5..dd690ac5ef1e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15318,17 +15318,17 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM |
 				    NETIF_F_GSO_GRE_CSUM;
-	dev->vlan_features = dev->hw_features | NETIF_F_HIGHDMA;
+	dev->vlan_features = dev->hw_features;
 	if (bp->fw_cap & BNXT_FW_CAP_VLAN_RX_STRIP)
 		dev->hw_features |= BNXT_HW_FEATURE_VLAN_ALL_RX;
 	if (bp->fw_cap & BNXT_FW_CAP_VLAN_TX_INSERT)
 		dev->hw_features |= BNXT_HW_FEATURE_VLAN_ALL_TX;
 	if (BNXT_SUPPORTS_TPA(bp))
 		dev->hw_features |= NETIF_F_GRO_HW;
-	dev->features |= dev->hw_features | NETIF_F_HIGHDMA;
+	dev->features |= dev->hw_features;
 	if (dev->features & NETIF_F_GRO_HW)
 		dev->features &= ~NETIF_F_LRO;
-	dev->priv_flags |= IFF_UNICAST_FLT;
+	dev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..a6371a82f125 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4019,10 +4019,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	priv->msg_enable = netif_msg_init(-1, GENET_MSG_DEFAULT);
 
 	/* Set default features */
-	dev->features |= NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			 NETIF_F_RXCSUM;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	/* Request the WOL interrupt and advertise suspend if available */
 	priv->wol_irq_disabled = true;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6ff3c9bd7e5..11212c0db1b1 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17809,7 +17809,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	if (dma_mask > DMA_BIT_MASK(32)) {
 		err = dma_set_mask(&pdev->dev, dma_mask);
 		if (!err) {
-			features |= NETIF_F_HIGHDMA;
+			dev->priv_flags |= IFF_HIGHDMA;
 			err = dma_set_coherent_mask(&pdev->dev,
 						    persist_dma_mask);
 			if (err < 0) {
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index c32174484a96..2843dc8bef08 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3424,12 +3424,11 @@ bnad_netdev_init(struct bnad *bnad)
 		NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_HW_VLAN_CTAG_TX |
 		NETIF_F_HW_VLAN_CTAG_RX;
 
-	netdev->vlan_features = NETIF_F_SG | NETIF_F_HIGHDMA |
-		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-		NETIF_F_TSO | NETIF_F_TSO6;
+	netdev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+		NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
 
-	netdev->features |= netdev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER |
-			    NETIF_F_HIGHDMA;
+	netdev->features |= netdev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->mem_start = bnad->mmio_start;
 	netdev->mem_end = bnad->mmio_start + bnad->mmio_len - 1;
diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index 5e97f1e4e38e..a037b83ae24f 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1774,12 +1774,12 @@ static int xgmac_probe(struct platform_device *pdev)
 	if (device_can_wakeup(priv->device))
 		priv->wolopts = WAKE_MAGIC;	/* Magic Frame as default */
 
-	ndev->hw_features = NETIF_F_SG | NETIF_F_HIGHDMA;
+	ndev->hw_features = NETIF_F_SG;
 	if (readl(priv->base + XGMAC_DMA_HW_FEATURE) & DMA_HW_FEAT_TXCOESEL)
 		ndev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 				     NETIF_F_RXCSUM;
 	ndev->features |= ndev->hw_features;
-	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	/* MTU range: 46 - 9000 */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 34f02a8ec2ca..79aa2db2511b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3565,13 +3565,13 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 		if (OCTEON_CN23XX_PF(octeon_dev) ||
 		    OCTEON_CN6XXX(octeon_dev)) {
-			lio->dev_capability = NETIF_F_HIGHDMA
-					      | NETIF_F_IP_CSUM
+			lio->dev_capability = NETIF_F_IP_CSUM
 					      | NETIF_F_IPV6_CSUM
 					      | NETIF_F_SG | NETIF_F_RXCSUM
 					      | NETIF_F_GRO
 					      | NETIF_F_TSO | NETIF_F_TSO6
 					      | NETIF_F_LRO;
+			netdev->priv_flags |= IFF_HIGHDMA;
 		}
 		netif_set_tso_max_size(netdev, OCTNIC_GSO_MAX_SIZE);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 62c2eadc33e3..fb4db64830cc 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -2082,12 +2082,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 		lio->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
-		lio->dev_capability = NETIF_F_HIGHDMA
-				      | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
+		lio->dev_capability = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
 				      | NETIF_F_SG | NETIF_F_RXCSUM
 				      | NETIF_F_TSO | NETIF_F_TSO6
 				      | NETIF_F_GRO
 				      | NETIF_F_LRO;
+		netdev->priv_flags |= IFF_HIGHDMA;
 		netif_set_tso_max_size(netdev, OCTNIC_GSO_MAX_SIZE);
 
 		/* Copy of transmit encapsulation capabilities:
diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index 9d0e8fc35ff9..76c9e7b643a5 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -1031,11 +1031,11 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->mem_start = mmio_start;
 		netdev->mem_end = mmio_start + mmio_len - 1;
 		netdev->ml_priv = adapter;
-		netdev->priv_flags |= IFF_LLTX;
+		netdev->priv_flags |= IFF_LLTX | IFF_HIGHDMA;
 		netdev->hw_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
 			NETIF_F_RXCSUM;
 		netdev->features |= NETIF_F_SG | NETIF_F_IP_CSUM |
-			NETIF_F_RXCSUM | NETIF_F_HIGHDMA;
+			NETIF_F_RXCSUM;
 
 		if (vlan_tso_capable(adapter)) {
 			netdev->features |=
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2236f1d35f2b..55c65b7bb249 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3200,7 +3200,7 @@ static void cxgb3_init_iscsi_mac(struct net_device *dev)
 
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN)
 #define VLAN_FEAT (NETIF_F_SG | NETIF_F_IP_CSUM | TSO_FLAGS | \
-			NETIF_F_IPV6_CSUM | NETIF_F_HIGHDMA)
+			NETIF_F_IPV6_CSUM)
 static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int i, err;
@@ -3308,7 +3308,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				    NETIF_F_HW_VLAN_CTAG_TX;
 		netdev->vlan_features |= netdev->features & VLAN_FEAT;
 
-		netdev->features |= NETIF_F_HIGHDMA;
+		netdev->priv_flags |= IFF_HIGHDMA;
 
 		netdev->netdev_ops = &cxgb_netdev_ops;
 		netdev->ethtool_ops = &cxgb_ethtool_ops;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2eb33a727bba..f58e5c3a0086 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6207,7 +6207,7 @@ static void free_some_resources(struct adapter *adapter)
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN | \
 		   NETIF_F_GSO_UDP_L4)
 #define VLAN_FEAT (NETIF_F_SG | NETIF_F_IP_CSUM | TSO_FLAGS | \
-		   NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_HIGHDMA)
+		   NETIF_F_GRO | NETIF_F_IPV6_CSUM)
 #define SEGMENT_SIZE 128
 
 static int t4_get_chip_type(struct adapter *adap, int ver)
@@ -6811,7 +6811,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			NETIF_F_RXCSUM | NETIF_F_RXHASH | NETIF_F_GRO |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			NETIF_F_HW_TC | NETIF_F_NTUPLE | NETIF_F_HIGHDMA;
+			NETIF_F_HW_TC | NETIF_F_NTUPLE;
 
 		if (chip_ver > CHELSIO_T5) {
 			netdev->hw_enc_features |= NETIF_F_IP_CSUM |
@@ -6847,7 +6847,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 #endif /* CONFIG_CHELSIO_IPSEC_INLINE */
 
-		netdev->priv_flags |= IFF_UNICAST_FLT;
+		netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 		/* MTU range: 81 - 9600 */
 		netdev->min_mtu = 81;              /* accommodate SACK */
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 9ba0864592e8..83a02b2aad74 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1923,7 +1923,7 @@ static void cxgb4vf_get_wol(struct net_device *dev,
  */
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN)
 #define VLAN_FEAT (NETIF_F_SG | NETIF_F_IP_CSUM | TSO_FLAGS | \
-		   NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_HIGHDMA)
+		   NETIF_F_GRO | NETIF_F_IPV6_CSUM)
 
 static const struct ethtool_ops cxgb4vf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
@@ -3070,10 +3070,10 @@ static int cxgb4vf_pci_probe(struct pci_dev *pdev,
 		netdev->hw_features = NETIF_F_SG | TSO_FLAGS | NETIF_F_GRO |
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
-		netdev->features = netdev->hw_features | NETIF_F_HIGHDMA;
+		netdev->features = netdev->hw_features;
 		netdev->vlan_features = netdev->features & VLAN_FEAT;
 
-		netdev->priv_flags |= IFF_UNICAST_FLT;
+		netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 		netdev->min_mtu = 81;
 		netdev->max_mtu = ETH_MAX_MTU;
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d266a87297a5..6ea7d29d4c59 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2952,7 +2952,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif
 
 	if (using_dac)
-		netdev->features |= NETIF_F_HIGHDMA;
+		netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a8596ebcdfd6..f13ab2481416 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5189,13 +5189,12 @@ static void be_netdev_init(struct net_device *netdev)
 		netdev->hw_features |= NETIF_F_RXHASH;
 
 	netdev->features |= netdev->hw_features |
-		NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER |
-		NETIF_F_HIGHDMA;
+		NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	netdev->vlan_features |= NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 |
 		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
-	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	netdev->flags |= IFF_MULTICAST;
 
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 4129344e1541..75cea376ebef 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -231,14 +231,14 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 				 NETIF_F_RXHASH);
 
-	net_dev->hw_features |= NETIF_F_SG | NETIF_F_HIGHDMA;
+	net_dev->hw_features |= NETIF_F_SG;
 	/* The kernels enables GSO automatically, if we declare NETIF_F_SG.
 	 * For conformity, we'll still declare GSO explicitly.
 	 */
 	net_dev->features |= NETIF_F_GSO;
 	net_dev->features |= NETIF_F_RXCSUM;
 
-	net_dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
+	net_dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX | IFF_HIGHDMA;
 	/* we do not want shared skbs on TX */
 	net_dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index bbd846bf12b0..42938718e059 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4585,7 +4585,7 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 	dpaa2_eth_detect_features(priv);
 
 	/* Capabilities listing */
-	supported |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX;
+	supported |= IFF_LIVE_ADDR_CHANGE | IFF_LLTX | IFF_HIGHDMA;
 
 	if (options & DPNI_OPT_NO_MAC_FILTER)
 		not_supported |= IFF_UNICAST_FLT;
@@ -4598,8 +4598,7 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 	/* Features */
 	net_dev->features = NETIF_F_RXCSUM |
 			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-			    NETIF_F_SG | NETIF_F_HIGHDMA |
-			    NETIF_F_HW_TC | NETIF_F_TSO;
+			    NETIF_F_SG | NETIF_F_HW_TC | NETIF_F_TSO;
 	net_dev->gso_max_segs = DPAA2_ETH_ENQUEUE_MAX_FDS;
 	net_dev->hw_features = net_dev->features;
 	net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 11b14555802c..f5087b9f8dad 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -796,7 +796,7 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
 			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+	ndev->features = NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
 			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
@@ -806,7 +806,7 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->num_rss)
 		ndev->hw_features |= NETIF_F_RXHASH;
 
-	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index dfcaac302e24..cd18f66a5a0f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -137,12 +137,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+	ndev->features = NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
 			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->priv_flags |= IFF_HIGHDMA;
 
 	if (si->num_rss)
 		ndev->hw_features |= NETIF_F_RXHASH;
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index a811238c018d..9cc61d21528a 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3242,7 +3242,8 @@ static int gfar_probe(struct platform_device *ofdev)
 		dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_SG |
 				   NETIF_F_RXCSUM;
 		dev->features |= NETIF_F_IP_CSUM | NETIF_F_SG |
-				 NETIF_F_RXCSUM | NETIF_F_HIGHDMA;
+				 NETIF_F_RXCSUM;
+		dev->priv_flags |= IFF_HIGHDMA;
 	}
 
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_VLAN) {
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_main.c b/drivers/net/ethernet/fungible/funeth/funeth_main.c
index df86770731ad..f3f7d3bfc1b5 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_main.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_main.c
@@ -1356,7 +1356,7 @@ static const struct net_device_ops fun_netdev_ops = {
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN | \
 		   NETIF_F_GSO_UDP_L4)
 #define VLAN_FEAT (NETIF_F_SG | NETIF_F_HW_CSUM | TSO_FLAGS | \
-		   GSO_ENCAP_FLAGS | NETIF_F_HIGHDMA)
+		   GSO_ENCAP_FLAGS)
 
 static void fun_dflt_rss_indir(struct funeth_priv *fp, unsigned int nrx)
 {
@@ -1766,11 +1766,12 @@ static int fun_create_netdev(struct fun_ethdev *ed, unsigned int portid)
 	if (fp->port_caps & FUN_PORT_CAP_ENCAP_OFFLOADS)
 		netdev->hw_features |= GSO_ENCAP_FLAGS;
 
-	netdev->features |= netdev->hw_features | NETIF_F_HIGHDMA;
+	netdev->features |= netdev->hw_features;
 	netdev->vlan_features = netdev->features & VLAN_FEAT;
 	netdev->mpls_features = netdev->vlan_features;
 	netdev->hw_enc_features = netdev->hw_features;
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = FUN_MAX_MTU;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a515e5af843c..05574f4b2ec0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2537,7 +2537,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * Features might be set in other locations as well (such as
 	 * `gve_adminq_describe_device`).
 	 */
-	dev->hw_features = NETIF_F_HIGHDMA;
 	dev->hw_features |= NETIF_F_SG;
 	dev->hw_features |= NETIF_F_HW_CSUM;
 	dev->hw_features |= NETIF_F_TSO;
@@ -2546,6 +2545,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_RXHASH;
 	dev->features = dev->hw_features;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->watchdog_timeo = 5 * HZ;
 	dev->min_mtu = ETH_MIN_MTU;
 	netif_carrier_off(dev);
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 1a972b093a42..ff4be4a54cd6 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1222,7 +1222,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 
 	INIT_WORK(&priv->tx_timeout_task, hix5hd2_tx_timeout_task);
 	ndev->watchdog_timeo = 6 * HZ;
-	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 	ndev->netdev_ops = &hix5hd2_netdev_ops;
 	ndev->ethtool_ops = &hix5hd2_ethtools_ops;
 	SET_NETDEV_DEV(ndev, dev);
@@ -1230,7 +1230,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	if (HAS_CAP_TSO(priv->hw_cap))
 		ndev->hw_features |= NETIF_F_SG;
 
-	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
+	ndev->features |= ndev->hw_features;
 	ndev->vlan_features |= ndev->features;
 
 	ret = hix5hd2_init_hw_desc_queue(priv);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 499c657d37a9..438303ee034b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -918,7 +918,7 @@ static const struct net_device_ops hinicvf_netdev_ops = {
 
 static void netdev_features_init(struct net_device *netdev)
 {
-	netdev->hw_features = NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM |
+	netdev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			      NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
 			      NETIF_F_RXCSUM | NETIF_F_LRO |
 			      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
@@ -931,6 +931,8 @@ static void netdev_features_init(struct net_device *netdev)
 	netdev->hw_enc_features = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SCTP_CRC |
 				  NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN |
 				  NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_UDP_TUNNEL;
+
+	netdev->priv_flags |= IFF_HIGHDMA;
 }
 
 static void hinic_refresh_nic_cfg(struct hinic_dev *nic_dev)
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 1e29e5c9a2df..f02d8945e82e 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -2998,11 +2998,11 @@ static struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 	dev->hw_features = NETIF_F_SG | NETIF_F_TSO |
 		      NETIF_F_IP_CSUM | NETIF_F_HW_VLAN_CTAG_TX;
 	dev->features = NETIF_F_SG | NETIF_F_TSO |
-		      NETIF_F_HIGHDMA | NETIF_F_IP_CSUM |
+		      NETIF_F_IP_CSUM |
 		      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 		      NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXCSUM;
-	dev->vlan_features = NETIF_F_SG | NETIF_F_TSO | NETIF_F_HIGHDMA |
-			NETIF_F_IP_CSUM;
+	dev->vlan_features = NETIF_F_SG | NETIF_F_TSO | NETIF_F_IP_CSUM;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->watchdog_timeo = EHEA_WATCH_DOG_TIMEOUT;
 
 	/* MTU range: 68 - 9022 */
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 5b43f9b194fc..22dba0ec50d1 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1051,10 +1051,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				NETIF_F_RXALL |
 				NETIF_F_RXFCS);
 
-	if (pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
+	if (pci_using_dac)
+		netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->vlan_features |= (NETIF_F_TSO |
 				  NETIF_F_HW_CSUM |
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index bef65ee4c549..c65ab725660f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7559,10 +7559,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				  NETIF_F_TSO6 |
 				  NETIF_F_HW_CSUM);
 
-	netdev->priv_flags |= IFF_UNICAST_FLT;
-
-	netdev->features |= NETIF_F_HIGHDMA;
-	netdev->vlan_features |= NETIF_F_HIGHDMA;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	/* MTU range: 68 - max_hw_frame_size */
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 92de609b7218..f4ecfe7ad9ba 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2008,10 +2008,8 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		hw->mac.ops.set_dma_mask(hw, dma_get_mask(&pdev->dev));
 
 	/* update netdev with DMA restrictions */
-	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
+	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32))
+		netdev->priv_flags |= IFF_HIGHDMA;
 
 	/* reset and initialize the hardware so it is in a known state */
 	err = hw->mac.ops.reset_hw(hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 164afd8ce5a0..40b62f782ee8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13665,7 +13665,6 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	hw_enc_features = NETIF_F_SG			|
 			  NETIF_F_HW_CSUM		|
-			  NETIF_F_HIGHDMA		|
 			  NETIF_F_SOFT_FEATURES		|
 			  NETIF_F_TSO			|
 			  NETIF_F_TSO_ECN		|
@@ -13794,6 +13793,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_HIGHDMA;
 	/* Setup netdev TC information */
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7e0de0a9b883..350fa76d4568 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4769,7 +4769,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
 	hw_enc_features = NETIF_F_SG			|
 			  NETIF_F_IP_CSUM		|
 			  NETIF_F_IPV6_CSUM		|
-			  NETIF_F_HIGHDMA		|
 			  NETIF_F_SOFT_FEATURES	|
 			  NETIF_F_TSO			|
 			  NETIF_F_TSO_ECN		|
@@ -4832,7 +4831,7 @@ int iavf_process_config(struct iavf_adapter *adapter)
 		adapter->flags |= IAVF_FLAG_FDIR_ENABLED;
 	}
 
-	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	/* Do not turn on offloads when they are requested to be turned off.
 	 * TSO needs minimum 576 bytes to work correctly.
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f75ea4b9ea1..a65014ec0cdb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3545,15 +3545,16 @@ static void ice_set_netdev_features(struct net_device *netdev)
 	netdev_features_t dflt_features;
 	netdev_features_t tso_features;
 
+	netdev->priv_flags |= IFF_HIGHDMA;
+
 	if (ice_is_safe_mode(pf)) {
 		/* safe mode */
-		netdev->features = NETIF_F_SG | NETIF_F_HIGHDMA;
+		netdev->features = NETIF_F_SG;
 		netdev->hw_features = netdev->features;
 		return;
 	}
 
 	dflt_features = NETIF_F_SG	|
-			NETIF_F_HIGHDMA	|
 			NETIF_F_NTUPLE	|
 			NETIF_F_RXHASH;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d3532c27d57..f1a5c9336e3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -779,8 +779,9 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
-	dflt_features = NETIF_F_SG	|
-			NETIF_F_HIGHDMA;
+	netdev->priv_flags |= IFF_HIGHDMA;
+
+	dflt_features = NETIF_F_SG;
 
 	if (idpf_is_cap_ena_all(adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
 		dflt_features |= NETIF_F_RXHASH;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 74a998fcaa6f..93099ac95e08 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3314,8 +3314,6 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->mac.type >= e1000_i350)
 		netdev->hw_features |= NETIF_F_NTUPLE;
 
-	netdev->features |= NETIF_F_HIGHDMA;
-
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->mpls_features |= NETIF_F_HW_CSUM;
 	netdev->hw_enc_features |= netdev->vlan_features;
@@ -3325,7 +3323,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
-	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_SUPP_NOFCS | IFF_HIGHDMA;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 40ccd24ffc53..33deb1854c97 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2806,7 +2806,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->hw_features |= NETIF_F_GSO_PARTIAL |
 			       IGBVF_GSO_PARTIAL_FEATURES;
 
-	netdev->features = netdev->hw_features | NETIF_F_HIGHDMA;
+	netdev->features = netdev->hw_features;
 
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->mpls_features |= NETIF_F_HW_CSUM;
@@ -2816,6 +2816,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_TX;
+	netdev->priv_flags = IFF_HIGHDMA;
 
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d9bd001af7ba..a4382f0c0521 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6856,12 +6856,12 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 	netdev->hw_features |= netdev->features;
 
-	netdev->features |= NETIF_F_HIGHDMA;
-
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->mpls_features |= NETIF_F_HW_CSUM;
 	netdev->hw_enc_features |= netdev->vlan_features;
 
+	netdev->priv_flags |= IFF_HIGHDMA;
+
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 43e7e75ae18c..da5d21d55278 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11049,8 +11049,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->hw_features |= NETIF_F_NTUPLE |
 				       NETIF_F_HW_TC;
 
-	netdev->features |= NETIF_F_HIGHDMA;
-
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->hw_enc_features |= netdev->vlan_features;
 	netdev->mpls_features |= NETIF_F_SG |
@@ -11066,6 +11064,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3161a13079fe..f1115bcf8863 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4618,7 +4618,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->hw_features |= NETIF_F_GSO_PARTIAL |
 			       IXGBEVF_GSO_PARTIAL_FEATURES;
 
-	netdev->features = netdev->hw_features | NETIF_F_HIGHDMA;
+	netdev->features = netdev->hw_features;
 
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->mpls_features |= NETIF_F_SG |
@@ -4633,7 +4633,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
-	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
 
 	/* MTU range: 68 - 1504 or 9710 */
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 1732ec3c3dbd..e0ac7be53f7b 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -716,7 +716,7 @@ jme_set_clean_rxdesc(struct jme_adapter *jme, int i)
 	rxdesc->desc1.bufaddrl	= cpu_to_le32(
 					(__u64)rxbi->mapping & 0xFFFFFFFFUL);
 	rxdesc->desc1.datalen	= cpu_to_le16(rxbi->len);
-	if (jme->dev->features & NETIF_F_HIGHDMA)
+	if (jme->dev->priv_flags & IFF_HIGHDMA)
 		rxdesc->desc1.flags = RXFLAG_64BIT;
 	wmb();
 	rxdesc->desc1.flags	|= RXFLAG_OWN | RXFLAG_INT;
@@ -2005,7 +2005,7 @@ jme_map_tx_skb(struct jme_adapter *jme, struct sk_buff *skb, int idx)
 	struct jme_ring *txring = &(jme->txring[0]);
 	struct txdesc *txdesc = txring->desc, *ctxdesc;
 	struct jme_buffer_info *txbi = txring->bufinf, *ctxbi;
-	bool hidma = jme->dev->features & NETIF_F_HIGHDMA;
+	bool hidma = jme->dev->priv_flags & IFF_HIGHDMA;
 	int i, nr_frags = skb_shinfo(skb)->nr_frags;
 	int mask = jme->tx_ring_mask;
 	u32 len;
@@ -2969,7 +2969,7 @@ jme_init_one(struct pci_dev *pdev,
 						NETIF_F_HW_VLAN_CTAG_TX |
 						NETIF_F_HW_VLAN_CTAG_RX;
 	if (using_dac)
-		netdev->features	|=	NETIF_F_HIGHDMA;
+		netdev->priv_flags	|=	IFF_HIGHDMA;
 
 	/* MTU range: 1280 - 9202*/
 	netdev->min_mtu = IPV6_MIN_MTU;
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 1b43704baceb..b2f9e6b570e7 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3829,7 +3829,7 @@ static struct net_device *skge_devinit(struct skge_hw *hw, int port,
 	dev->max_mtu = ETH_JUMBO_MTU;
 
 	if (highmem)
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 
 	skge = netdev_priv(dev);
 	netif_napi_add(dev, &skge->napi, skge_poll);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 07720841a8d7..564582a17aef 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4636,7 +4636,7 @@ static struct net_device *sky2_init_netdev(struct sky2_hw *hw, unsigned port,
 	dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_TSO;
 
 	if (highmem)
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 
 	/* Enable receive hashing unless hardware is known broken */
 	if (!(hw->flags & SKY2_HW_RSS_BROKEN))
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 5d3fde63b273..9229ebeac31e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3291,9 +3291,10 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	}
 
 	dev->vlan_features = dev->hw_features;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->hw_features |= NETIF_F_RXCSUM | NETIF_F_RXHASH;
-	dev->features = dev->hw_features | NETIF_F_HIGHDMA |
+	dev->features = dev->hw_features |
 			NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			NETIF_F_HW_VLAN_CTAG_FILTER;
 	dev->hw_features |= NETIF_F_LOOPBACK |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d51ab72d69b9..7bb45429a213 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5264,10 +5264,9 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 #endif
 	}
 
-	netdev->features         |= NETIF_F_HIGHDMA;
 	netdev->features         |= NETIF_F_HW_VLAN_STAG_FILTER;
 
-	netdev->priv_flags       |= IFF_UNICAST_FLT;
+	netdev->priv_flags       |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(netdev);
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 7b7e1c5b00f4..ee98b4da71ce 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -3864,7 +3864,7 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* fake NETIF_F_HW_VLAN_CTAG_RX for good GRO performance */
 	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 
-	netdev->features = netdev->hw_features | NETIF_F_HIGHDMA;
+	netdev->features = netdev->hw_features;
 
 	netdev->vlan_features |= mgp->features;
 	if (mgp->fw_ver_tiny < 37)
@@ -3872,6 +3872,8 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (mgp->fw_ver_tiny < 32)
 		netdev->vlan_features &= ~NETIF_F_TSO;
 
+	netdev->priv_flags |= IFF_HIGHDMA;
+
 	/* make sure we can get an irq, and that MSI can be
 	 * setup (if available). */
 	status = myri10ge_request_irq(mgp);
diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 998586872599..12282ea8d0af 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -2155,7 +2155,7 @@ static int ns83820_init_one(struct pci_dev *pci_dev,
 	if (using_dac) {
 		printk(KERN_INFO "%s: using 64 bit addressing.\n",
 			ndev->name);
-		ndev->features |= NETIF_F_HIGHDMA;
+		ndev->priv_flags |= IFF_HIGHDMA;
 	}
 
 	printk(KERN_INFO "%s: ns83820 v" VERSION ": DP83820 v%u.%u: %pM io=0x%08lx irq=%d f=%s\n",
@@ -2163,7 +2163,7 @@ static int ns83820_init_one(struct pci_dev *pci_dev,
 		(unsigned)readl(dev->base + SRR) >> 8,
 		(unsigned)readl(dev->base + SRR) & 0xff,
 		ndev->dev_addr, addr, pci_dev->irq,
-		(ndev->features & NETIF_F_HIGHDMA) ? "h,sg" : "sg"
+		(ndev->priv_flags & IFF_HIGHDMA) ? "h,sg" : "sg"
 		);
 
 #ifdef PHY_CODE_IS_FINISHED
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 55408f16fbbc..ee96beb36f11 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -7861,8 +7861,8 @@ s2io_init_nic(struct pci_dev *pdev, const struct pci_device_id *pre)
 		NETIF_F_TSO | NETIF_F_TSO6 |
 		NETIF_F_RXCSUM | NETIF_F_LRO;
 	dev->features |= dev->hw_features |
-		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-		NETIF_F_HIGHDMA;
+		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->watchdog_timeo = WATCH_DOG_TIMEOUT;
 	INIT_WORK(&sp->rst_timer_task, s2io_restart_nic);
 	INIT_WORK(&sp->set_link_task, s2io_set_link);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 997cc4fcffdb..043e9688a9f2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2681,7 +2681,6 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	if (nn->cap & NFP_NET_CFG_CTRL_LIVE_ADDR)
 		netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	netdev->hw_features = NETIF_F_HIGHDMA;
 	if (nn->cap & NFP_NET_CFG_CTRL_RXCSUM_ANY) {
 		netdev->hw_features |= NETIF_F_RXCSUM;
 		nn->dp.ctrl |= nn->cap & NFP_NET_CFG_CTRL_RXCSUM_ANY;
@@ -2754,6 +2753,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	}
 
 	netdev->features = netdev->hw_features;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	if (nfp_app_has_tc(nn->app) && nn->port)
 		netdev->hw_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 3cb3dbbd6240..d1bec1d3f6b2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -338,7 +338,6 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	if (repr_cap & NFP_NET_CFG_CTRL_LIVE_ADDR)
 		netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	netdev->hw_features = NETIF_F_HIGHDMA;
 	if (repr_cap & NFP_NET_CFG_CTRL_RXCSUM_ANY)
 		netdev->hw_features |= NETIF_F_RXCSUM;
 	if (repr_cap & NFP_NET_CFG_CTRL_TXCSUM)
@@ -384,7 +383,7 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	netdev->features &= ~NETIF_F_HW_VLAN_STAG_RX;
 	netif_set_tso_max_segs(netdev, NFP_NET_LSO_MAX_SEGS);
 
-	netdev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL;
+	netdev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL | IFF_HIGHDMA;
 
 	if (nfp_app_has_tc(app)) {
 		netdev->features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 31f896c4aa26..a0dd34aed97f 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5793,7 +5793,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 				dev_info(&pci_dev->dev,
 					 "64-bit DMA failed, using 32-bit addressing\n");
 			else
-				dev->features |= NETIF_F_HIGHDMA;
+				dev->priv_flags |= IFF_HIGHDMA;
 		}
 	} else if (id->driver_data & DEV_HAS_LARGEDESC) {
 		/* packet format 2: supports jumbo frames */
@@ -6118,7 +6118,7 @@ static int nv_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 		 dev->name, np->phy_oui, np->phyaddr, dev->dev_addr);
 
 	dev_info(&pci_dev->dev, "%s%s%s%s%s%s%s%s%s%s%sdesc-v%u\n",
-		 dev->features & NETIF_F_HIGHDMA ? "highdma " : "",
+		 (dev->priv_flags & IFF_HIGHDMA) ? "highdma " : "",
 		 dev->features & (NETIF_F_IP_CSUM | NETIF_F_SG) ?
 			"csum " : "",
 		 dev->features & (NETIF_F_HW_VLAN_CTAG_RX |
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 2dcbfe24134c..e144883d7ce9 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1699,9 +1699,8 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netif_napi_add(dev, &mac->napi, pasemi_mac_poll);
 
-	dev->features = NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_HIGHDMA |
-			NETIF_F_GSO;
-	dev->priv_flags |= IFF_LLTX;
+	dev->features = NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_GSO;
+	dev->priv_flags |= IFF_LLTX | IFF_HIGHDMA;
 
 	mac->dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
 	if (!mac->dma_pdev) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7f0c6cdc375e..b983f4746a19 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1535,7 +1535,6 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 		return err;
 
 	/* tell the netdev what we actually can support */
-	netdev->features |= NETIF_F_HIGHDMA;
 
 	if (lif->hw_features & IONIC_ETH_HW_VLAN_TX_TAG)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
@@ -1576,7 +1575,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 	netdev->vlan_features |= netdev->features & ~NETIF_F_VLAN_FEATURES;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT |
-			      IFF_LIVE_ADDR_CHANGE;
+			      IFF_LIVE_ADDR_CHANGE |
+			      IFF_HIGHDMA;
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
 			       NETDEV_XDP_ACT_REDIRECT |
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index ed24d6af7487..5b5ecbaf8b92 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -1351,10 +1351,8 @@ netxen_setup_netdev(struct netxen_adapter *adapter,
 
 	netdev->vlan_features |= netdev->hw_features;
 
-	if (adapter->pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
+	if (adapter->pci_using_dac)
+		netdev->priv_flags |= IFF_HIGHDMA;
 
 	if (adapter->capabilities & NX_FW_CAPABILITY_FVLANTX)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 99df00c30b8c..7a021c505a74 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -900,16 +900,16 @@ static void qede_init_ndev(struct qede_dev *edev)
 					  NETIF_F_GSO_GRE_CSUM);
 	}
 
-	ndev->vlan_features = hw_features | NETIF_F_RXHASH | NETIF_F_RXCSUM |
-			      NETIF_F_HIGHDMA;
+	ndev->vlan_features = hw_features | NETIF_F_RXHASH | NETIF_F_RXCSUM;
 	ndev->features = hw_features | NETIF_F_RXHASH | NETIF_F_RXCSUM |
-			 NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HIGHDMA |
+			 NETIF_F_HW_VLAN_CTAG_RX |
 			 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_TX;
 
 	ndev->hw_features = hw_features;
 
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT;
+	ndev->priv_flags |= IFF_HIGHDMA;
 
 	/* MTU range: 46 - 9600 */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index fc78bc959ded..f69abca3759a 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3797,7 +3797,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 
 	qdev->msg_enable = netif_msg_init(debug, default_msg);
 
-	ndev->features |= NETIF_F_HIGHDMA;
+	ndev->priv_flags |= IFF_HIGHDMA;
 	if (qdev->device_id == QL3032_DEVICE_ID)
 		ndev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 90df4a0909fa..1019ef4be20f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -2277,9 +2277,9 @@ qlcnic_setup_netdev(struct qlcnic_adapter *adapter, struct net_device *netdev)
 
 	netdev->features |= (NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			     NETIF_F_IPV6_CSUM | NETIF_F_GRO |
-			     NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HIGHDMA);
+			     NETIF_F_HW_VLAN_CTAG_RX);
 	netdev->vlan_features |= (NETIF_F_SG | NETIF_F_IP_CSUM |
-				  NETIF_F_IPV6_CSUM | NETIF_F_HIGHDMA);
+				  NETIF_F_IPV6_CSUM);
 
 	if (QLCNIC_IS_TSO_CAPABLE(adapter)) {
 		netdev->features |= (NETIF_F_TSO | NETIF_F_TSO6);
@@ -2312,7 +2312,7 @@ qlcnic_setup_netdev(struct qlcnic_adapter *adapter, struct net_device *netdev)
 	}
 
 	netdev->hw_features = netdev->features;
-	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 	netdev->irq = adapter->msix_entries[0].vector;
 
 	/* MTU range: 68 - 9600 */
diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index f5786d78ed23..8a65f29e82dc 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1994,12 +1994,11 @@ static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
 
 	if (pci_using_dac)
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->hw_features |= NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
 		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
-	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
-		NETIF_F_HIGHDMA;
+	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
 
 	/* MTU range: 60 - 4096 */
 	dev->min_mtu = CP_MIN_MTU;
diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 9ce0e8a64ba8..369d7347928b 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1008,11 +1008,12 @@ static int rtl8139_init_one(struct pci_dev *pdev,
 	 * through the use of skb_copy_and_csum_dev we enable these
 	 * features
 	 */
-	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
 	dev->vlan_features = dev->features;
 
 	dev->hw_features |= NETIF_F_RXALL;
 	dev->hw_features |= NETIF_F_RXFCS;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	/* MTU range: 68 - 1770 */
 	dev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6f1e6f386b7b..b486b0512c23 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5401,7 +5401,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
 	    !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 
 	rtl_init_rxcfg(tp);
 
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index ecbe3994f2b1..03bdcf5c8fe6 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2107,11 +2107,11 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 		NETIF_F_RXCSUM | NETIF_F_TSO | NETIF_F_TSO6 |
 		NETIF_F_GRO;
-	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
+	ndev->features |= ndev->hw_features;
 	ndev->watchdog_timeo = msecs_to_jiffies(TX_TIMEO);
 
 	/* assign filtering support */
-	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->priv_flags |= IFF_UNICAST_FLT | IFF_HIGHDMA;
 
 	/* MTU range: 68 - 9000 */
 	ndev->min_mtu = MIN_MTU;
diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 7f7d560cb2b4..ed628a013d29 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -449,7 +449,8 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	net_dev->hw_features |= efx->type->offload_features;
 	net_dev->hw_enc_features |= efx->type->offload_features;
 	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
-				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
+				  NETIF_F_ALL_TSO;
+	net_dev->priv_flags |= IFF_HIGHDMA;
 	netif_set_tso_max_segs(net_dev,
 			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
 	efx->mdio.dev = net_dev;
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 6da06931187d..270f2324c2d8 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -1222,7 +1222,7 @@ void ef100_remove(struct efx_nic *efx)
 /*	NIC level access functions
  */
 #define EF100_OFFLOAD_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_RXCSUM |	\
-	NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_NTUPLE | \
+	NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_NTUPLE | \
 	NETIF_F_RXHASH | NETIF_F_RXFCS | NETIF_F_TSO_ECN | NETIF_F_RXALL | \
 	NETIF_F_HW_VLAN_CTAG_TX)
 
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index e9d9de8e648a..0873220702ce 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1021,8 +1021,7 @@ static int efx_pci_probe_post_io(struct efx_nic *efx)
 
 	/* Mask for features that also apply to VLAN devices */
 	net_dev->vlan_features |= (NETIF_F_HW_CSUM | NETIF_F_SG |
-				   NETIF_F_HIGHDMA | NETIF_F_ALL_TSO |
-				   NETIF_F_RXCSUM);
+				   NETIF_F_ALL_TSO | NETIF_F_RXCSUM);
 
 	/* Determine user configurable features */
 	net_dev->hw_features |= net_dev->features & ~efx->fixed_features;
@@ -1089,7 +1088,6 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	*probe_ptr = probe_data;
 	efx->net_dev = net_dev;
 	efx->type = (const struct efx_nic_type *) entry->driver_data;
-	efx->fixed_features |= NETIF_F_HIGHDMA;
 
 	pci_set_drvdata(pci_dev, efx);
 	SET_NETDEV_DEV(net_dev, &pci_dev->dev);
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 1cb32aedd89c..3a4443fcf410 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2873,7 +2873,6 @@ static int ef4_pci_probe(struct pci_dev *pci_dev,
 		return -ENOMEM;
 	efx = netdev_priv(net_dev);
 	efx->type = (const struct ef4_nic_type *) entry->driver_data;
-	efx->fixed_features |= NETIF_F_HIGHDMA;
 
 	pci_set_drvdata(pci_dev, efx);
 	SET_NETDEV_DEV(net_dev, &pci_dev->dev);
@@ -2899,7 +2898,7 @@ static int ef4_pci_probe(struct pci_dev *pci_dev,
 			      NETIF_F_RXCSUM);
 	/* Mask for features that also apply to VLAN devices */
 	net_dev->vlan_features |= (NETIF_F_HW_CSUM | NETIF_F_SG |
-				   NETIF_F_HIGHDMA | NETIF_F_RXCSUM);
+				   NETIF_F_RXCSUM);
 
 	net_dev->hw_features = net_dev->features & ~efx->fixed_features;
 
diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
index 59d3a6043379..dcae1dc94f87 100644
--- a/drivers/net/ethernet/sfc/siena/efx.c
+++ b/drivers/net/ethernet/sfc/siena/efx.c
@@ -1003,8 +1003,7 @@ static int efx_pci_probe_post_io(struct efx_nic *efx)
 		net_dev->features &= ~NETIF_F_ALL_TSO;
 	/* Mask for features that also apply to VLAN devices */
 	net_dev->vlan_features |= (NETIF_F_HW_CSUM | NETIF_F_SG |
-				   NETIF_F_HIGHDMA | NETIF_F_ALL_TSO |
-				   NETIF_F_RXCSUM);
+				   NETIF_F_ALL_TSO | NETIF_F_RXCSUM);
 
 	net_dev->hw_features |= net_dev->features & ~efx->fixed_features;
 
@@ -1053,7 +1052,6 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 		return -ENOMEM;
 	efx = netdev_priv(net_dev);
 	efx->type = (const struct efx_nic_type *) entry->driver_data;
-	efx->fixed_features |= NETIF_F_HIGHDMA;
 
 	pci_set_drvdata(pci_dev, efx);
 	SET_NETDEV_DEV(net_dev, &pci_dev->dev);
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 98d0b561a057..3df3e03cf906 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -927,7 +927,8 @@ static int ioc3eth_probe(struct platform_device *pdev)
 	dev->netdev_ops		= &ioc3_netdev_ops;
 	dev->ethtool_ops	= &ioc3_ethtool_ops;
 	dev->hw_features	= NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
-	dev->features		= NETIF_F_IP_CSUM | NETIF_F_HIGHDMA;
+	dev->features		= NETIF_F_IP_CSUM;
+	dev->priv_flags		|= IFF_HIGHDMA;
 
 	sw_physid1 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID1);
 	sw_physid2 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID2);
diff --git a/drivers/net/ethernet/silan/sc92031.c b/drivers/net/ethernet/silan/sc92031.c
index ff4197f5e46d..6f6e8779fcae 100644
--- a/drivers/net/ethernet/silan/sc92031.c
+++ b/drivers/net/ethernet/silan/sc92031.c
@@ -1437,8 +1437,8 @@ static int sc92031_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	/* faked with skb_copy_and_csum_dev */
-	dev->features = NETIF_F_SG | NETIF_F_HIGHDMA |
-		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->netdev_ops		= &sc92031_netdev_ops;
 	dev->watchdog_timeo	= TX_TIMEOUT;
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 5ab8b81b84e6..2de893dc95ac 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2113,9 +2113,10 @@ static int netsec_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &netsec_netdev_ops;
 	ndev->ethtool_ops = &netsec_ethtool_ops;
 
-	ndev->features |= NETIF_F_HIGHDMA | NETIF_F_RXCSUM | NETIF_F_GSO |
+	ndev->features |= NETIF_F_RXCSUM | NETIF_F_GSO |
 				NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	ndev->hw_features = ndev->features;
+	ndev->priv_flags |= IFF_HIGHDMA;
 
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe3498e86de9..07a5d97a6b8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7666,7 +7666,7 @@ int stmmac_dvr_probe(struct device *device,
 		}
 	}
 
-	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
+	ndev->features |= ndev->hw_features;
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
@@ -7723,7 +7723,7 @@ int stmmac_dvr_probe(struct device *device,
 	if (flow_ctrl)
 		priv->flow_ctrl = FLOW_AUTO;	/* RX/TX pause on */
 
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_HIGHDMA;
 
 	/* Setup channels NAPI */
 	stmmac_napi_add(ndev);
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index bfb903506367..c1c0947616fc 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -5037,7 +5037,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if ((cp->cas_flags & CAS_FLAG_NO_HW_CSUM) == 0)
 		dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
 
-	dev->features |= NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	/* MTU range: 60 - varies or 9000 */
 	dev->min_mtu = CAS_MIN_MTU;
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index f68aa813d4fb..98bf49ac3890 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9802,7 +9802,7 @@ static int niu_pci_init_one(struct pci_dev *pdev,
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
 	if (!err)
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 	if (err) {
 		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 9bd1df8308d2..958108efef2d 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2993,7 +2993,7 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	dev->features = dev->hw_features;
 	if (pci_using_dac)
-		dev->features |= NETIF_F_HIGHDMA;
+		dev->priv_flags |= IFF_HIGHDMA;
 
 	/* MTU range: 68 - 1500 (Jumbo mode is broken) */
 	dev->min_mtu = GEM_MIN_MTU;
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index 5c44d27a9f48..7ad7e42b4bcd 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -1978,8 +1978,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ndev->if_port = port;
 		ndev->features = NETIF_F_IP_CSUM | NETIF_F_SG | NETIF_F_TSO |
 		    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-		    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXCSUM |
-		    NETIF_F_HIGHDMA;
+		    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXCSUM;
 
 		ndev->hw_features = NETIF_F_IP_CSUM | NETIF_F_SG |
 			NETIF_F_TSO | NETIF_F_HW_VLAN_CTAG_TX;
@@ -2021,6 +2020,8 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef BDX_LLTX
 		ndev->priv_flags |= IFF_LLTX;
 #endif
+		ndev->priv_flags |= IFF_HIGHDMA;
+
 		/* MTU range: 60 - 16384 */
 		ndev->min_mtu = ETH_ZLEN;
 		ndev->max_mtu = BDX_MAX_MTU;
diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index 554aff7c8f3b..f16564a5e57e 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -1600,7 +1600,7 @@ tsi108_init_one(struct platform_device *pdev)
 	 * a new function skb_csum_dev() in net/core/skbuff.c).
 	 */
 
-	dev->features = NETIF_F_HIGHDMA;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	spin_lock_init(&data->txlock);
 	spin_lock_init(&data->misclock);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index fdd6b4f70b7a..d005cf3de5d9 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -588,13 +588,13 @@ static int ngbe_probe(struct pci_dev *pdev,
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features | NETIF_F_RXALL;
 	netdev->hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
-	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bd4624d14ca0..8f8e428b1d7f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -551,13 +551,13 @@ static int txgbe_probe(struct pci_dev *pdev,
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features | NETIF_F_RXALL;
 	netdev->hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
-	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 1072e2210aed..09aa5c87e9c3 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1405,7 +1405,6 @@ static int temac_probe(struct platform_device *pdev)
 	ndev->features |= NETIF_F_IP_CSUM; /* Can checksum TCP/UDP over IPv4. */
 	ndev->features |= NETIF_F_HW_CSUM; /* Can checksum all the packets. */
 	ndev->features |= NETIF_F_IPV6_CSUM; /* Can checksum IPV6 TCP/UDP */
-	ndev->features |= NETIF_F_HIGHDMA; /* Can DMA to high memory. */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_TX; /* Transmit VLAN hw accel */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX; /* Receive VLAN hw acceleration */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER; /* Receive VLAN filtering */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 11831a1c9762..3323c7e5310f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2602,10 +2602,10 @@ static int netvsc_probe(struct hv_device *dev,
 		schedule_work(&nvdev->subchan_work);
 
 	/* hw_features computed in rndis_netdev_set_hwcaps() */
-	net->features = net->hw_features |
-		NETIF_F_HIGHDMA | NETIF_F_HW_VLAN_CTAG_TX |
+	net->features = net->hw_features | NETIF_F_HW_VLAN_CTAG_TX |
 		NETIF_F_HW_VLAN_CTAG_RX;
 	net->vlan_features = net->features;
+	net->priv_flags |= IFF_HIGHDMA;
 
 	netdev_lockdep_set_classes(net);
 
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 2c1b5def4a0b..f7ea7dea7bf2 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -290,8 +290,7 @@ static const struct ethtool_ops ifb_ethtool_ops = {
 
 #define IFB_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG  | NETIF_F_FRAGLIST	| \
 		      NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL	| \
-		      NETIF_F_HIGHDMA | NETIF_F_HW_VLAN_CTAG_TX		| \
-		      NETIF_F_HW_VLAN_STAG_TX)
+		      NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX)
 
 static void ifb_dev_free(struct net_device *dev)
 {
@@ -325,6 +324,7 @@ static void ifb_setup(struct net_device *dev)
 
 	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	netif_keep_dst(dev);
 	eth_hw_addr_random(dev);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5a2e7fc397e1..62b4372dc205 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -117,7 +117,7 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	(IPVLAN_ALWAYS_ON_OFLOADS | NETIF_F_VLAN_CHALLENGED)
 
 #define IPVLAN_FEATURES \
-	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST | \
 	 NETIF_F_GSO | NETIF_F_ALL_TSO | NETIF_F_GSO_ROBUST | \
 	 NETIF_F_GRO | NETIF_F_RXCSUM | \
 	 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)
@@ -141,7 +141,7 @@ static int ipvlan_init(struct net_device *dev)
 	dev->vlan_features = phy_dev->vlan_features & IPVLAN_FEATURES;
 	dev->vlan_features |= IPVLAN_ALWAYS_ON_OFLOADS;
 	dev->hw_enc_features |= dev->features;
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | (phy_dev->priv_flags & IFF_HIGHDMA);
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 860f1a3df838..a9ca447774ec 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -175,7 +175,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_LOGICAL;
-	dev->priv_flags		|= IFF_NETNS_LOCAL;
+	dev->priv_flags		|= IFF_NETNS_LOCAL | IFF_HIGHDMA;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
@@ -183,7 +183,6 @@ static void gen_lo_setup(struct net_device *dev,
 		| NETIF_F_HW_CSUM
 		| NETIF_F_RXCSUM
 		| NETIF_F_SCTP_CRC
-		| NETIF_F_HIGHDMA
 		| NETIF_F_VLAN_CHALLENGED
 		| NETIF_F_LOOPBACK;
 	dev->ethtool_ops	= eth_ops;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5146feb52be7..4adb34f2fa45 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3511,7 +3511,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_FRAGLIST)
 
 static int macsec_dev_init(struct net_device *dev)
 {
@@ -3525,7 +3525,7 @@ static int macsec_dev_init(struct net_device *dev)
 
 	dev->features = real_dev->features & MACSEC_FEATURES;
 	dev->features |= NETIF_F_GSO_SOFTWARE;
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | (real_dev->priv_flags & IFF_HIGHDMA);
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	macsec_set_head_tail_room(dev);
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index d8fca9e355cf..040546613ebc 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -903,10 +903,10 @@ static struct lock_class_key macvlan_netdev_addr_lock_key;
 #define ALWAYS_ON_FEATURES ALWAYS_ON_OFFLOADS
 
 #define MACVLAN_FEATURES \
-	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
-	 NETIF_F_GSO | NETIF_F_TSO | NETIF_F_LRO | \
-	 NETIF_F_TSO_ECN | NETIF_F_TSO6 | NETIF_F_GRO | NETIF_F_RXCSUM | \
-	 NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)
+	(NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST | NETIF_F_GSO | \
+	 NETIF_F_TSO | NETIF_F_LRO | NETIF_F_TSO_ECN | NETIF_F_TSO6 | \
+	 NETIF_F_GRO | NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_FILTER | \
+	 NETIF_F_HW_VLAN_STAG_FILTER)
 
 #define MACVLAN_STATE_MASK \
 	((1<<__LINK_STATE_NOCARRIER) | (1<<__LINK_STATE_DORMANT))
@@ -933,6 +933,7 @@ static int macvlan_init(struct net_device *dev)
 	dev->vlan_features	|= ALWAYS_ON_OFFLOADS;
 	dev->hw_enc_features    |= dev->features;
 	dev->priv_flags		|= IFF_LLTX;
+	dev->priv_flags		|= (lowerdev->priv_flags & IFF_HIGHDMA);
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
 	macvlan_set_lockdep_class(dev);
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 8b8a84ed88b0..53e6e05939fa 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -379,10 +379,9 @@ static void net_failover_compute_features(struct net_device *dev)
 					  NETIF_F_ALL_FOR_ALL;
 	netdev_features_t enc_features  = FAILOVER_ENC_FEATURES;
 	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
 	struct net_failover_info *nfo_info = netdev_priv(dev);
 	struct net_device *primary_dev, *standby_dev;
+	u64 priv_flags = FAILOVER_PRIV_FLAGS;
 
 	primary_dev = rcu_dereference(nfo_info->primary_dev);
 	if (primary_dev) {
@@ -395,7 +394,12 @@ static void net_failover_compute_features(struct net_device *dev)
 						  primary_dev->hw_enc_features,
 						  FAILOVER_ENC_FEATURES);
 
-		dst_release_flag &= primary_dev->priv_flags;
+		priv_flags &= IFF_ALL_FOR_ALL;
+		priv_flags =
+			netdev_increment_priv_flags(priv_flags,
+						    primary_dev->priv_flags,
+						    FAILOVER_PRIV_FLAGS);
+
 		if (primary_dev->hard_header_len > max_hard_header_len)
 			max_hard_header_len = primary_dev->hard_header_len;
 	}
@@ -411,7 +415,13 @@ static void net_failover_compute_features(struct net_device *dev)
 						  standby_dev->hw_enc_features,
 						  FAILOVER_ENC_FEATURES);
 
-		dst_release_flag &= standby_dev->priv_flags;
+		if (!primary_dev)
+			priv_flags &= IFF_ALL_FOR_ALL;
+		priv_flags =
+			netdev_increment_priv_flags(priv_flags,
+						    standby_dev->priv_flags,
+						    FAILOVER_PRIV_FLAGS);
+
 		if (standby_dev->hard_header_len > max_hard_header_len)
 			max_hard_header_len = standby_dev->hard_header_len;
 	}
@@ -420,11 +430,7 @@ static void net_failover_compute_features(struct net_device *dev)
 	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
 	dev->hard_header_len = max_hard_header_len;
 
-	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE |
-				 IFF_XMIT_DST_RELEASE_PERM))
-		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
+	netdev_increment_priv_flags_finalize(dev, priv_flags);
 	netdev_change_features(dev);
 }
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8330bc0bcb7e..1082970c4314 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -338,9 +338,9 @@ static void nsim_setup(struct net_device *dev)
 	dev->tx_queue_len = 0;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
-			   IFF_NO_QUEUE;
-	dev->features |= NETIF_F_HIGHDMA |
-			 NETIF_F_SG |
+			   IFF_NO_QUEUE |
+			   IFF_HIGHDMA;
+	dev->features |= NETIF_F_SG |
 			 NETIF_F_FRAGLIST |
 			 NETIF_F_HW_CSUM |
 			 NETIF_F_TSO;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index bd7abb2d6c7b..5c6028532bcb 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -229,7 +229,6 @@ static void netkit_setup(struct net_device *dev)
 		NETIF_F_HW_CSUM |
 		NETIF_F_RXCSUM |
 		NETIF_F_SCTP_CRC |
-		NETIF_F_HIGHDMA |
 		NETIF_F_GSO_SOFTWARE |
 		NETIF_F_GSO_ENCAP_ALL;
 
@@ -242,6 +241,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_LOGICAL;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->ethtool_ops = &netkit_ethtool_ops;
 	dev->netdev_ops  = &netkit_netdev_ops;
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index e319a0d0771d..a2312a91f214 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -62,13 +62,13 @@ static const struct net_device_ops nlmon_ops = {
 static void nlmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_NETLINK;
-	dev->priv_flags |= IFF_LOGICAL;
+	dev->priv_flags |= IFF_LOGICAL | IFF_HIGHDMA;
 
 	dev->netdev_ops	= &nlmon_ops;
 	dev->ethtool_ops = &nlmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
 	dev->flags = IFF_NOARP;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 536bd6564f8b..9bc277a77dc9 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -420,9 +420,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
-	ndev->features = NETIF_F_HIGHDMA;
 
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_HIGHDMA;
 
 	ndev->hw_features = ndev->features;
 	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9f0495e8df4d..c71d2c709ea1 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -548,7 +548,8 @@ static int tap_open(struct inode *inode, struct file *file)
 	 * The macvlan supports zerocopy iff the lower device supports zero
 	 * copy so we don't have to look at the lower device directly.
 	 */
-	if ((tap->dev->features & NETIF_F_HIGHDMA) && (tap->dev->features & NETIF_F_SG))
+	if ((tap->dev->priv_flags & IFF_HIGHDMA) &&
+	    (tap->dev->features & NETIF_F_SG))
 		sock_set_flag(&q->sk, SOCK_ZEROCOPY);
 
 	err = tap_set_queue(tap, file, q);
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0fcb3b9ac4af..4393f94838c7 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -983,20 +983,23 @@ static void team_port_disable(struct team *team,
 
 #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
 			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO)
+			    NETIF_F_LRO)
 
 #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
 
+#define TEAM_PRIV_FLAGS		(IFF_XMIT_DST_RELEASE | \
+				 IFF_XMIT_DST_RELEASE_PERM | \
+				 IFF_HIGHDMA)
+
 static void __team_compute_features(struct team *team)
 {
 	struct team_port *port;
 	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
 					  NETIF_F_ALL_FOR_ALL;
 	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
+	u64 priv_flags = TEAM_PRIV_FLAGS & IFF_ALL_FOR_ALL;
 	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &team->port_list, list) {
@@ -1008,8 +1011,10 @@ static void __team_compute_features(struct team *team)
 						  port->dev->hw_enc_features,
 						  TEAM_ENC_FEATURES);
 
+		priv_flags = netdev_increment_priv_flags(priv_flags,
+							 port->dev->priv_flags,
+							 TEAM_PRIV_FLAGS);
 
-		dst_release_flag &= port->dev->priv_flags;
 		if (port->dev->hard_header_len > max_hard_header_len)
 			max_hard_header_len = port->dev->hard_header_len;
 	}
@@ -1021,9 +1026,7 @@ static void __team_compute_features(struct team *team)
 				     NETIF_F_HW_VLAN_STAG_TX;
 	team->dev->hard_header_len = max_hard_header_len;
 
-	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+	netdev_increment_priv_flags_finalize(team->dev, priv_flags);
 }
 
 static void team_compute_features(struct team *team)
diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0a53ec293d04..e7b4e4d5f2e8 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1328,7 +1328,8 @@ static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
 	 */
 	dev->hw_features = NETIF_F_SG | NETIF_F_ALL_TSO | NETIF_F_GRO |
 			   NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
-	dev->features = dev->hw_features | NETIF_F_HIGHDMA;
+	dev->features = dev->hw_features;
+	dev->priv_flags |= IFF_HIGHDMA;
 	dev->hard_header_len += sizeof(struct thunderbolt_ip_frame_header);
 
 	netif_napi_add(dev, &net->napi, tbnet_poll);
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 5d6aeb086fc7..8420bd92ab50 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9833,8 +9833,9 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 			      NETIF_F_IPV6_CSUM | NETIF_F_TSO6 |
 			      NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX;
 	netdev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
-				NETIF_F_HIGHDMA | NETIF_F_FRAGLIST |
-				NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
+				NETIF_F_FRAGLIST | NETIF_F_IPV6_CSUM |
+				NETIF_F_TSO6;
+	netdev->priv_flags |= IFF_HIGHDMA;
 
 	if (tp->version == RTL_VER_01) {
 		netdev->features &= ~NETIF_F_RXCSUM;
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f17c5aab1f78..c39911122b75 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1682,7 +1682,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-		       NETIF_F_RXCSUM | NETIF_F_SCTP_CRC | NETIF_F_HIGHDMA | \
+		       NETIF_F_RXCSUM | NETIF_F_SCTP_CRC | \
 		       NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL | \
 		       NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX | \
 		       NETIF_F_HW_VLAN_STAG_TX | NETIF_F_HW_VLAN_STAG_RX )
@@ -1695,6 +1695,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_LOGICAL;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..c87d990b3156 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4648,9 +4648,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	/* Set up network device as normal. */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
-			   IFF_TX_SKB_NO_LINEAR;
+			   IFF_TX_SKB_NO_LINEAR | IFF_HIGHDMA;
 	dev->netdev_ops = &virtnet_netdev;
-	dev->features = NETIF_F_HIGHDMA;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0578864792b6..8de901f9546b 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3507,7 +3507,7 @@ vmxnet3_declare_features(struct vmxnet3_adapter *adapter)
 	netdev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 		NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_CTAG_TX |
 		NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_TSO | NETIF_F_TSO6 |
-		NETIF_F_LRO | NETIF_F_HIGHDMA;
+		NETIF_F_LRO;
 
 	if (VMXNET3_VERSION_GE_4(adapter)) {
 		netdev->hw_features |= NETIF_F_GSO_UDP_TUNNEL |
@@ -3572,6 +3572,7 @@ vmxnet3_declare_features(struct vmxnet3_adapter *adapter)
 				~(NETIF_F_HW_VLAN_CTAG_TX |
 				  NETIF_F_HW_VLAN_CTAG_RX);
 	netdev->features = netdev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
+	netdev->priv_flags |= IFF_HIGHDMA;
 }
 
 
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 48c84ec3227c..9f83061e3f86 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1661,7 +1661,7 @@ static void vrf_setup(struct net_device *dev)
 	/* enable offload features */
 	dev->features   |= NETIF_F_GSO_SOFTWARE;
 	dev->features   |= NETIF_F_RXCSUM | NETIF_F_HW_CSUM | NETIF_F_SCTP_CRC;
-	dev->features   |= NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
+	dev->features   |= NETIF_F_SG | NETIF_F_FRAGLIST;
 
 	dev->hw_features = dev->features;
 	dev->hw_enc_features = dev->features;
@@ -1669,6 +1669,7 @@ static void vrf_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LOGICAL | IFF_NETNS_LOCAL;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	/* VRF devices do not care about MTU, but if the MTU is set
 	 * too low then the ipv4 and ipv6 protocols are disabled
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index f0903f66d137..f3af8846dac5 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -82,13 +82,13 @@ static const struct ethtool_ops vsockmon_ethtool_ops = {
 static void vsockmon_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_VSOCKMON;
-	dev->priv_flags |= IFF_LOGICAL;
+	dev->priv_flags |= IFF_LOGICAL | IFF_HIGHDMA;
 
 	dev->netdev_ops	= &vsockmon_ops;
 	dev->ethtool_ops = &vsockmon_ethtool_ops;
 	dev->needs_free_netdev = true;
 
-	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
 
 	dev->flags = IFF_NOARP;
 
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index ef1a05e1b46e..d44d573d4b97 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -276,7 +276,7 @@ static void wg_setup(struct net_device *dev)
 	struct wg_device *wg = netdev_priv(dev);
 	enum { WG_NETDEV_FEATURES = NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
 				    NETIF_F_SG | NETIF_F_GSO |
-				    NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA };
+				    NETIF_F_GSO_SOFTWARE };
 	const int overhead = MESSAGE_MINIMUM_LENGTH + sizeof(struct udphdr) +
 			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
 
@@ -288,7 +288,7 @@ static void wg_setup(struct net_device *dev)
 	dev->needed_tailroom = noise_encrypted_len(MESSAGE_PADDING_MULTIPLE);
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-	dev->priv_flags |= IFF_LOGICAL;
+	dev->priv_flags |= IFF_LOGICAL | IFF_HIGHDMA;
 	dev->features |= WG_NETDEV_FEATURES;
 	dev->hw_features |= WG_NETDEV_FEATURES;
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 52b008ce53bd..6b0599e731f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -96,8 +96,10 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
-	if (priv->trans->max_skb_frags)
-		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
+	if (priv->trans->max_skb_frags) {
+		hw->netdev_features = NETIF_F_SG;
+		hw->netdev_priv_flags = IFF_HIGHDMA;
+	}
 
 	hw->offchannel_tx_hw_queue = IWL_AUX_QUEUE;
 	hw->radiotap_mcs_details |= IEEE80211_RADIOTAP_MCS_HAVE_FMT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ac7d986d9cd7..98766c2829b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -417,8 +417,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (mvm->trans->num_rx_queues > 1)
 		ieee80211_hw_set(hw, USES_RSS);
 
-	if (mvm->trans->max_skb_frags)
-		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
+	if (mvm->trans->max_skb_frags) {
+		hw->netdev_features = NETIF_F_SG;
+		hw->netdev_priv_flags = IFF_HIGHDMA;
+	}
 
 	hw->queues = IEEE80211_NUM_ACS;
 	hw->offchannel_tx_hw_queue = IWL_MVM_OFFCHANNEL_QUEUE;
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 8c5aaf860635..4ed791a02a35 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -5015,7 +5015,7 @@ static int fotg210_run(struct usb_hcd *hcd)
 	 * can return segments above 4GB, if the device allows.
 	 *
 	 * NOTE:  the dma mask is visible through dev->dma_mask, so
-	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
+	 * drivers can pass this info along ... IFF_HIGHDMA,
 	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
 	 * host side drivers though.
 	 */
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 802bfafb1012..b8d3cc2a422a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -592,7 +592,7 @@ static int ehci_run (struct usb_hcd *hcd)
 	 * can return segments above 4GB, if the device allows.
 	 *
 	 * NOTE:  the dma mask is visible through dev->dma_mask, so
-	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
+	 * drivers can pass this info along ... like IFF_HIGHDMA,
 	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
 	 * host side drivers though.
 	 */
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index d467472f9d3c..13963a9a3eea 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -3135,7 +3135,7 @@ static int oxu_run(struct usb_hcd *hcd)
 	 * can return segments above 4GB, if the device allows.
 	 *
 	 * NOTE:  the dma mask is visible through dev->dma_mask, so
-	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
+	 * drivers can pass this info along ... like IFF_HIGHDMA,
 	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
 	 * host side drivers though.
 	 */
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 90b649a51199..421419ebac41 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -563,14 +563,13 @@ static int vlan_dev_init(struct net_device *dev)
 	dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
 			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
 			   NETIF_F_GSO_ENCAP_ALL |
-			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
-			   NETIF_F_ALL_FCOE;
+			   NETIF_F_SCTP_CRC | NETIF_F_ALL_FCOE;
 
 	if (real_dev->vlan_features & NETIF_F_HW_MACSEC)
 		dev->hw_features |= NETIF_F_HW_MACSEC;
 
 	dev->features |= dev->hw_features;
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | (real_dev->priv_flags & IFF_HIGHDMA);
 	netif_inherit_tso_max(dev, real_dev);
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a4410a8d5993..3fc6e2469648 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -18,7 +18,7 @@
 #include <linux/uaccess.h>
 #include "br_private.h"
 
-#define COMMON_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA | \
+#define COMMON_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | \
 			 NETIF_F_GSO_MASK | NETIF_F_HW_CSUM)
 
 const struct nf_br_ops __rcu *nf_br_ops __read_mostly;
@@ -481,6 +481,7 @@ void br_dev_setup(struct net_device *dev)
 	dev->ethtool_ops = &br_ethtool_ops;
 	SET_NETDEV_DEVTYPE(dev, &br_type);
 	dev->priv_flags = IFF_EBRIDGE | IFF_LOGICAL | IFF_NETNS_LOCAL;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			NETIF_F_HW_VLAN_STAG_TX;
diff --git a/net/core/dev.c b/net/core/dev.c
index 1022ab4c0b89..2e20db77d5d6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3411,7 +3411,7 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 #ifdef CONFIG_HIGHMEM
 	int i;
 
-	if (!(dev->features & NETIF_F_HIGHDMA)) {
+	if (!(dev->priv_flags & IFF_HIGHDMA)) {
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
@@ -10327,10 +10327,6 @@ int register_netdevice(struct net_device *dev)
 	if (dev->hw_enc_features & NETIF_F_TSO)
 		dev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
 
-	/* Make NETIF_F_HIGHDMA inheritable to VLAN devices.
-	 */
-	dev->vlan_features |= NETIF_F_HIGHDMA;
-
 	/* Make NETIF_F_SG inheritable to tunnel devices.
 	 */
 	dev->hw_enc_features |= NETIF_F_SG | NETIF_F_GSO_PARTIAL;
@@ -11501,6 +11497,27 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+u64 netdev_increment_priv_flags(u64 all, u64 one, u64 mask)
+{
+	all |= one & IFF_ONE_FOR_ALL & mask;
+	all &= one | ~IFF_ALL_FOR_ALL;
+
+	return all;
+}
+EXPORT_SYMBOL(netdev_increment_priv_flags);
+
+void netdev_increment_priv_flags_finalize(struct net_device *dev,
+					  u64 priv_flags)
+{
+	dev->priv_flags |= priv_flags;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((priv_flags & (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM)) ==
+	    (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+}
+EXPORT_SYMBOL(netdev_increment_priv_flags_finalize);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 66c8b6739260..64c736e897e9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -13,7 +13,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_IP_CSUM_BIT] =          "tx-checksum-ipv4",
 	[NETIF_F_HW_CSUM_BIT] =          "tx-checksum-ip-generic",
 	[NETIF_F_IPV6_CSUM_BIT] =        "tx-checksum-ipv6",
-	[NETIF_F_HIGHDMA_BIT] =          "highdma",
 	[NETIF_F_FRAGLIST_BIT] =         "tx-scatter-gather-fraglist",
 	[NETIF_F_HW_VLAN_CTAG_TX_BIT] =  "tx-vlan-hw-insert",
 
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 066e30ea5042..be1df345b841 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -499,10 +499,11 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->netdev_ops = &hsr_device_ops;
 	SET_NETDEV_DEVTYPE(dev, &hsr_type);
 	dev->priv_flags |= IFF_LOGICAL | IFF_DISABLE_NETPOLL | IFF_NETNS_LOCAL;
+	dev->priv_flags |= IFF_HIGHDMA;
 
 	dev->needs_free_netdev = true;
 
-	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
+	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX;
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 01f217190e25..597a449d8c17 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -975,7 +975,6 @@ static const struct net_device_ops ipgre_netdev_ops = {
 
 #define GRE_FEATURES (NETIF_F_SG |		\
 		      NETIF_F_FRAGLIST |	\
-		      NETIF_F_HIGHDMA |		\
 		      NETIF_F_HW_CSUM)
 
 static void ipgre_tunnel_setup(struct net_device *dev)
@@ -1011,7 +1010,7 @@ static void __gre_tunnel_init(struct net_device *dev)
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | IFF_HIGHDMA;
 }
 
 static int ipgre_tunnel_init(struct net_device *dev)
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 2ef9a06b0e34..5e9284da19a0 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -366,7 +366,6 @@ static const struct net_device_ops ipip_netdev_ops = {
 
 #define IPIP_FEATURES (NETIF_F_SG |		\
 		       NETIF_F_FRAGLIST |	\
-		       NETIF_F_HIGHDMA |	\
 		       NETIF_F_GSO_SOFTWARE |	\
 		       NETIF_F_HW_CSUM)
 
@@ -378,7 +377,7 @@ static void ipip_tunnel_setup(struct net_device *dev)
 	dev->type		= ARPHRD_TUNNEL;
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
-	dev->priv_flags		|= IFF_LLTX;
+	dev->priv_flags		|= IFF_LLTX | IFF_HIGHDMA;
 	netif_keep_dst(dev);
 
 	dev->features		|= IPIP_FEATURES;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 36a5f8997fc2..9a85c8b520c1 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1465,7 +1465,6 @@ static void ip6gre_tunnel_setup(struct net_device *dev)
 
 #define GRE6_FEATURES (NETIF_F_SG |		\
 		       NETIF_F_FRAGLIST |	\
-		       NETIF_F_HIGHDMA |	\
 		       NETIF_F_HW_CSUM)
 
 static void ip6gre_tnl_init_features(struct net_device *dev)
@@ -1487,7 +1486,7 @@ static void ip6gre_tnl_init_features(struct net_device *dev)
 	dev->features |= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | IFF_HIGHDMA;
 }
 
 static int ip6gre_tunnel_init_common(struct net_device *dev)
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 206a936427da..ebcd52e9d1dc 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1824,7 +1824,6 @@ static const struct net_device_ops ip6_tnl_netdev_ops = {
 
 #define IPXIPX_FEATURES (NETIF_F_SG |		\
 			 NETIF_F_FRAGLIST |	\
-			 NETIF_F_HIGHDMA |	\
 			 NETIF_F_GSO_SOFTWARE |	\
 			 NETIF_F_HW_CSUM)
 
@@ -1846,7 +1845,7 @@ static void ip6_tnl_dev_setup(struct net_device *dev)
 	dev->type = ARPHRD_TUNNEL6;
 	dev->flags |= IFF_NOARP;
 	dev->addr_len = sizeof(struct in6_addr);
-	dev->priv_flags |= IFF_LLTX;
+	dev->priv_flags |= IFF_LLTX | IFF_HIGHDMA;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 23df3c0638d6..02d344c4ebd1 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1414,7 +1414,6 @@ static void ipip6_dev_free(struct net_device *dev)
 
 #define SIT_FEATURES (NETIF_F_SG	   | \
 		      NETIF_F_FRAGLIST	   | \
-		      NETIF_F_HIGHDMA	   | \
 		      NETIF_F_GSO_SOFTWARE | \
 		      NETIF_F_HW_CSUM)
 
@@ -1435,7 +1434,7 @@ static void ipip6_tunnel_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	netif_keep_dst(dev);
 	dev->addr_len		= 4;
-	dev->priv_flags		|= IFF_LLTX;
+	dev->priv_flags		|= IFF_LLTX | IFF_HIGHDMA;
 	dev->features		|= SIT_FEATURES;
 	dev->hw_features	|= SIT_FEATURES;
 	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 395de62d9cb2..e64003fa1b73 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2191,6 +2191,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 		ndev->features |= local->hw.netdev_features;
 		ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+		ndev->priv_flags |= local->hw.netdev_priv_flags &
+				    MAC80211_SUPPORTED_PRIV_FLAGS;
 		ndev->hw_features |= ndev->features &
 					MAC80211_SUPPORTED_FEATURES_TX;
 		sdata->vif.netdev_features = local->hw.netdev_features;
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index e916b95a8d28..dc22a4c88940 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -102,13 +102,13 @@ static void do_setup(struct net_device *netdev)
 
 	netdev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_OPENVSWITCH |
-			      IFF_LOGICAL;
+			      IFF_LOGICAL | IFF_HIGHDMA;
 	netdev->needs_free_netdev = true;
 	netdev->priv_destructor = NULL;
 	netdev->ethtool_ops = &internal_dev_ethtool_ops;
 	netdev->rtnl_link_ops = &internal_dev_link_ops;
 
-	netdev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
+	netdev->features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE |
 			   NETIF_F_GSO_ENCAP_ALL;
 
-- 
2.44.0


