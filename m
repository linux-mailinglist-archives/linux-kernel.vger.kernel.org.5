Return-Path: <linux-kernel+bounces-57841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124584DE10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55AF1F2192D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4F6F53A;
	Thu,  8 Feb 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XkXe6n4x"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D706DCFC;
	Thu,  8 Feb 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387570; cv=none; b=bknBQGUXAPE5P3Fjbzv74UvpbGayYl4Rjkmc/zMZ8VFGMFVd2TmN4p/oddOtWiEbnlRTbCa27QlFAEHER/vvbnYDUjEymYElRwHtF1kRlbxYywS3P4RTey3Iygyf6zOohYAFAIik6/4dewOYck22Gr7AGWYgPiqSDBrCJuUVn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387570; c=relaxed/simple;
	bh=ug+3bGJkgwDpDORxyVWd+Exb7CLbDExfehRy4c6kcYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b67ubNWjgltGwYyYlv9uztVpbS63NK+1OsKEKhq3N9XewYmjcdEtJ62QHe31AJY9P3exq8VBpMWJy+78jLCuTKURLmZadWwEN7d839gTIwVJ5hlWgC5Jpr221CDr2X4R/e3OM/RKisq/jt4xMMen/sdiG4GGTb9qCoCpbdc3oZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XkXe6n4x; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4184HFA9003172;
	Thu, 8 Feb 2024 02:19:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Xuyta7Uijf8SIpbx7r46aziijivjY7yq3SE8YUiR1Ds=; b=XkX
	e6n4xcCAju4cJoigolMSm45PF4sx3MAX7sHTDHDpRUlETB9He9NP6Gzkgtn3DWGC
	XqSJT1ABtlzHmQeu5KqH6M0CneciyBasBskWoYX1I+JT3IHifJCroYQNzO69Umay
	cYjlufE1GHjFXRrh5zibf1A0WZmXESw0XhqIxvsrrA0tUltYREt1kNdApih68wuf
	HBWkPnImI5zo/78ueaEt51eRR0irb4r/A29Fylrx2JQ9+bEJlrfeBPyylBrXlKSW
	+9ACUTwn42UCTD2Uu6fu7tkkrkrTAlz1nzAsOsDmNBDAO05ssPG8xjqpiMyJBTWX
	eJfwzNh4iCeH3vIVhcg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w4qsq0wgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 02:19:19 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Feb
 2024 02:19:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 8 Feb 2024 02:19:16 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 359833F7080;
	Thu,  8 Feb 2024 02:19:16 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <hgani@marvell.com>, <vimleshk@marvell.com>,
        <sedara@marvell.com>, <srasheed@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>,
        "Satananda
 Burla" <sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>
Subject: [PATCH net-next v7 5/8] octeon_ep_vf: add support for ndo ops
Date: Thu, 8 Feb 2024 02:18:37 -0800
Message-ID: <20240208101841.3108103-6-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208101841.3108103-1-srasheed@marvell.com>
References: <20240208101841.3108103-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XQYWJdkPO3okvELvEiLFSPWAYq_OLr-L
X-Proofpoint-GUID: XQYWJdkPO3okvELvEiLFSPWAYq_OLr-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02

Add support for ndo ops to set MAC address, change MTU, get stats.
Add control path support to set MAC address, change MTU, get stats,
set speed, get and set link mode.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V7:
  - Moved addition of other ndo ops from [3/8] to this patch
  - Simplified logic for alignment in octep_vf_get_if_stats

V6: https://lore.kernel.org/all/20240207065207.3092004-6-srasheed@marvell.com/
  - No changes

V5: https://lore.kernel.org/all/20240129050254.3047778-6-srasheed@marvell.com/
  - No changes

V4: https://lore.kernel.org/all/20240108124213.2966536-6-srasheed@marvell.com/
  - Provide more stats in ndo_get_stats64 such as tx_dropped, rx_dropped
    etc.

V3: https://lore.kernel.org/all/20240105203823.2953604-6-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231223134000.2906144-6-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-6-srasheed@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_main.c      | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 997deb5283bd..ca823933b9fd 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -186,6 +186,26 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+int octep_vf_get_if_stats(struct octep_vf_device *oct)
+{
+	struct octep_vf_iface_rxtx_stats vf_stats;
+	int ret, size;
+
+	memset(&vf_stats, 0, sizeof(struct octep_vf_iface_rxtx_stats));
+	ret = octep_vf_mbox_bulk_read(oct, OCTEP_PFVF_MBOX_CMD_GET_STATS,
+				      (u8 *)&vf_stats, &size);
+
+	if (ret)
+		return ret;
+
+	memcpy(&oct->iface_rx_stats, &vf_stats.iface_rx_stats,
+	       sizeof(struct octep_vf_iface_rx_stats));
+	memcpy(&oct->iface_tx_stats, &vf_stats.iface_tx_stats,
+	       sizeof(struct octep_vf_iface_tx_stats));
+
+	return 0;
+}
+
 int octep_vf_get_link_info(struct octep_vf_device *oct)
 {
 	int ret, size;
@@ -199,6 +219,46 @@ int octep_vf_get_link_info(struct octep_vf_device *oct)
 	return 0;
 }
 
+/**
+ * octep_vf_get_stats64() - Get Octeon network device statistics.
+ *
+ * @netdev: kernel network device.
+ * @stats: pointer to stats structure to be filled in.
+ */
+static void octep_vf_get_stats64(struct net_device *netdev,
+				 struct rtnl_link_stats64 *stats)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
+	int q;
+
+	tx_packets = 0;
+	tx_bytes = 0;
+	rx_packets = 0;
+	rx_bytes = 0;
+	for (q = 0; q < oct->num_oqs; q++) {
+		struct octep_vf_iq *iq = oct->iq[q];
+		struct octep_vf_oq *oq = oct->oq[q];
+
+		tx_packets += iq->stats.instr_completed;
+		tx_bytes += iq->stats.bytes_sent;
+		rx_packets += oq->stats.packets;
+		rx_bytes += oq->stats.bytes;
+	}
+	stats->tx_packets = tx_packets;
+	stats->tx_bytes = tx_bytes;
+	stats->rx_packets = rx_packets;
+	stats->rx_bytes = rx_bytes;
+	if (!octep_vf_get_if_stats(oct)) {
+		stats->multicast = oct->iface_rx_stats.mcast_pkts;
+		stats->rx_errors = oct->iface_rx_stats.err_pkts;
+		stats->rx_dropped = oct->iface_rx_stats.dropped_pkts_fifo_full +
+				    oct->iface_rx_stats.err_pkts;
+		stats->rx_missed_errors = oct->iface_rx_stats.dropped_pkts_fifo_full;
+		stats->tx_dropped = oct->iface_tx_stats.dropped;
+	}
+}
+
 /**
  * octep_vf_tx_timeout_task - work queue task to Handle Tx queue timeout.
  *
@@ -239,11 +299,85 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	schedule_work(&oct->tx_timeout_task);
 }
 
+static int octep_vf_set_mac(struct net_device *netdev, void *p)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct sockaddr *addr = (struct sockaddr *)p;
+	int err;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	err = octep_vf_mbox_set_mac_addr(oct, addr->sa_data);
+	if (err)
+		return err;
+
+	memcpy(oct->mac_addr, addr->sa_data, ETH_ALEN);
+	eth_hw_addr_set(netdev, addr->sa_data);
+
+	return 0;
+}
+
+static int octep_vf_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct octep_vf_iface_link_info *link_info;
+	int err;
+
+	link_info = &oct->link_info;
+	if (link_info->mtu == new_mtu)
+		return 0;
+
+	err = octep_vf_mbox_set_mtu(oct, new_mtu);
+	if (!err) {
+		oct->link_info.mtu = new_mtu;
+		netdev->mtu = new_mtu;
+	}
+	return err;
+}
+
+static int octep_vf_set_features(struct net_device *netdev,
+				 netdev_features_t features)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u16 rx_offloads = 0, tx_offloads = 0;
+	int err;
+
+	/* We only support features received from firmware */
+	if ((features & netdev->hw_features) != features)
+		return -EINVAL;
+
+	if (features & NETIF_F_TSO)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_TSO6)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_IP_CSUM)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_IPV6_CSUM)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_RXCSUM)
+		rx_offloads |= OCTEP_VF_RX_OFFLOAD_CKSUM;
+
+	err = octep_vf_mbox_set_offloads(oct, tx_offloads, rx_offloads);
+	if (!err)
+		netdev->features = features;
+
+	return err;
+}
+
 static const struct net_device_ops octep_vf_netdev_ops = {
 	.ndo_open                = octep_vf_open,
 	.ndo_stop                = octep_vf_stop,
 	.ndo_start_xmit          = octep_vf_start_xmit,
+	.ndo_get_stats64         = octep_vf_get_stats64,
 	.ndo_tx_timeout          = octep_vf_tx_timeout,
+	.ndo_set_mac_address     = octep_vf_set_mac,
+	.ndo_change_mtu          = octep_vf_change_mtu,
+	.ndo_set_features        = octep_vf_set_features,
 };
 
 static const char *octep_vf_devid_to_str(struct octep_vf_device *oct)
-- 
2.25.1


