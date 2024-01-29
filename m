Return-Path: <linux-kernel+bounces-42167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33D83FD57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA731C22BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB54595D;
	Mon, 29 Jan 2024 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JxKT68lB"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275F3C49C;
	Mon, 29 Jan 2024 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504615; cv=none; b=WquncPy4JA1ColKiWru+SWqLw6AEGHQxlebjMWYBHI3S3UiyRgg3kLOKnrCDw3IHuUiYAk0QzYUj6aRXpqejmc617evjeA+442ZJwCS8rMeTEk2Vd6uOkVKR+ItvmmkTcA9f9hMwMb5lDeAOYhq1Kr9y49Dd2AlQvE7P69f+Gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504615; c=relaxed/simple;
	bh=j1q4tB+oOQYzR1/x6opmItWuKWDj32zm3XHggC6iVEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5et+sO1ipBArzINH34KWt+imHeR2OLnIXvLJOoyzRwfOUODVxEmQ7SFp7Y+Sey4C0faACEHdEZz+chDffbyAJ9+Ptkka7xAECNwYFEtRvvJW7RcIp8ARQEWatkGSEH/A3NLSzWGTjKm0QdevSPHKXZpKtlbKVMfS3cYmPfQcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JxKT68lB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4KEj9027114;
	Sun, 28 Jan 2024 21:03:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=ZOvduTOyCNrJIKJ8Qa9RNSmLbNmT5aw5W2vZ3KoliyQ=; b=JxK
	T68lBtY2bT+5pnFPi/7Bnmu7O6RB4yYE9gtvvwsJ17+wpyC6QqG6Tjom+yZ0/C/g
	evC1OwJKIUrhim3PuClpE1WiTBSK1Q8gixxUf038mFHKdNfl3WKaeIhc6KpxKTwj
	61uI8g2HsRjgcoySwSkqwCix/wDSGngVZH6rrIsHRm7Qu7HOo7vQ/XRI6VCObfgI
	+m6stqdmzUt3oOuNambwTeMR+V+8VCzaA2c7QVrQVzrG7Lk4N5Hihu3BMJJ/TB86
	pnukbgavxAaxqRlZTDUgKEwyKdHBMxhRxBSmD5yEhr0t4Y6UAIHhFFMTMTwKs0fw
	GTshs22gIfoZZjoAsAA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vr82dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:03:26 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 21:03:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 28 Jan 2024 21:03:24 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id A14733F703F;
	Sun, 28 Jan 2024 21:03:24 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v5 5/8] octeon_ep_vf: add support for ndo ops
Date: Sun, 28 Jan 2024 21:02:51 -0800
Message-ID: <20240129050254.3047778-6-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129050254.3047778-1-srasheed@marvell.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pFQG03xlhIJ8uPBjJ_4l9AtQVxMHh5G7
X-Proofpoint-GUID: pFQG03xlhIJ8uPBjJ_4l9AtQVxMHh5G7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02

Add support for ndo ops to set MAC address, change MTU, get stats.
Add control path support to set MAC address, change MTU, get stats,
set speed, get and set link mode.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
  - No changes

V4: https://lore.kernel.org/all/20240108124213.2966536-6-srasheed@marvell.com/
  - Provide more stats in ndo_get_stats64 such as tx_dropped, rx_dropped
    etc.

V3: https://lore.kernel.org/all/20240105203823.2953604-6-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231223134000.2906144-6-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-6-srasheed@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_main.c      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 51f92c8223e8..13084cac9ce0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -187,6 +187,23 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
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
+	if (!ret) {
+		memcpy(&oct->iface_rx_stats, &vf_stats.iface_rx_stats,
+		       sizeof(struct octep_vf_iface_rx_stats));
+		memcpy(&oct->iface_tx_stats, &vf_stats.iface_tx_stats,
+		       sizeof(struct octep_vf_iface_tx_stats));
+	}
+	return ret;
+}
+
 int octep_vf_get_link_info(struct octep_vf_device *oct)
 {
 	int ret, size;
@@ -200,6 +217,46 @@ int octep_vf_get_link_info(struct octep_vf_device *oct)
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
@@ -312,6 +369,7 @@ static const struct net_device_ops octep_vf_netdev_ops = {
 	.ndo_open                = octep_vf_open,
 	.ndo_stop                = octep_vf_stop,
 	.ndo_start_xmit          = octep_vf_start_xmit,
+	.ndo_get_stats64         = octep_vf_get_stats64,
 	.ndo_tx_timeout          = octep_vf_tx_timeout,
 	.ndo_set_mac_address     = octep_vf_set_mac,
 	.ndo_change_mtu          = octep_vf_change_mtu,
-- 
2.25.1


