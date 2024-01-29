Return-Path: <linux-kernel+bounces-42172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62883FD65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530B91C2218C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41E4EB5E;
	Mon, 29 Jan 2024 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="inO+zzjf"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27A4D5A0;
	Mon, 29 Jan 2024 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504625; cv=none; b=DPeVwiLL1FviRmLEqszFWhVUA++BKCcQLtnk6D1kCbWCXIbQCzGYF29pqwVsWjcs+YO418cVrLU/Enx0ypJpsXxtihjanzvygKjxH0OAgBmhnP8rad2BsELg0qBWDLZ+IvVgwvC3Jt2xQRxIGpVgPF0vx7JUKp/s3UkliS/VwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504625; c=relaxed/simple;
	bh=VDWy5ha0ML+GPRyfJelPVKo953QF9ZZ1hyJRA1u+T28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBga9mSVIpXqSYx9cKIx/kLiLOpx0XO6mcJD5oz34g7TjTWaGh3QOBC6yWP1Bk3Vwkfs1oGVH8g0oc6J5X0obTeRazHkie81PA5FMSvQ5c9hgDYxXTrhAABuNgjm9zS+OvcqUPOqDQldgwilYDEr2uaBT2aanmwc5DBN1F4wX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=inO+zzjf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4KEjA027114;
	Sun, 28 Jan 2024 21:03:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=+kvS1QxmQ/Wdk07+od8wFyszLIrQ+4l0G6m7sQhHly8=; b=inO
	+zzjf9kUevaCAwG+dyQQENC1txkPU9TbTboOLz0hKjDgaZmqTYVm+HHNoUKp5RYm
	E6wixOiI7yqYiSjQwfVawXHSdUD9LYfhbVqdWdOsERUktu6dvJYUBhgR9KWfvs1u
	S7IPM2z5pazgQn6d7Rm57L+tvdwCR1wTeDVpQJY/Jv/crce6/AyjradOrwnA8E14
	LidyBaUdqd5xnkt9XlQzG+E3y+Iy8NSGWuBua59Mz5J4gL/pNObrV2DORoquus7r
	EvQvPIlkTh7mnbszzUCpQ8M5TW7wjdThpBBqytVD5pYQdXbn47CYsLOd+Cho5f6+
	82xhQco+fv7ozaohnDA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vr82dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:03:33 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 21:03:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 28 Jan 2024 21:03:32 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id AB53F3F7053;
	Sun, 28 Jan 2024 21:03:31 -0800 (PST)
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
Subject: [PATCH net-next v5 7/8] octeon_ep_vf: add ethtool support
Date: Sun, 28 Jan 2024 21:02:53 -0800
Message-ID: <20240129050254.3047778-8-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: RJocwmkTICj6mYznwIA3v5xlq-RF-15_
X-Proofpoint-GUID: RJocwmkTICj6mYznwIA3v5xlq-RF-15_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02

Add support for the following ethtool commands:

ethtool -i|--driver devname
ethtool devname
ethtool -S|--statistics devname

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
  - No changes

V4: https://lore.kernel.org/all/20240108124213.2966536-8-srasheed@marvell.com/
  - Removed stats which are already sent in ndo_get_stats64

V3: https://lore.kernel.org/all/20240105203823.2953604-8-srasheed@marvell.com/
  - Removed duplicate reporting of TX/RX packets/bytes, which is already
    done during ndo_get_stats64

V2: https://lore.kernel.org/all/20231223134000.2906144-8-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-8-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep_vf/Makefile    |   3 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 273 ++++++++++++++++++
 .../marvell/octeon_ep_vf/octep_vf_main.c      |   1 +
 .../marvell/octeon_ep_vf/octep_vf_main.h      |   1 +
 4 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile b/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
index 694eb9b46e99..4a5f9fcb0b40 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_OCTEON_EP_VF) += octeon_ep_vf.o
 
 octeon_ep_vf-y := octep_vf_main.o octep_vf_cn9k.o octep_vf_cnxk.o \
-		  octep_vf_tx.o octep_vf_rx.o octep_vf_mbox.o
+		  octep_vf_tx.o octep_vf_rx.o octep_vf_mbox.o \
+		  octep_vf_ethtool.o
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
new file mode 100644
index 000000000000..a1979b45e355
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeon EP (EndPoint) VF Ethernet Driver
+ *
+ * Copyright (C) 2020 Marvell.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+
+#include "octep_vf_config.h"
+#include "octep_vf_main.h"
+
+static const char octep_vf_gstrings_global_stats[][ETH_GSTRING_LEN] = {
+	"rx_alloc_errors",
+	"tx_busy_errors",
+	"tx_hw_pkts",
+	"tx_hw_octs",
+	"tx_hw_bcast",
+	"tx_hw_mcast",
+	"rx_hw_pkts",
+	"rx_hw_bytes",
+	"rx_hw_bcast",
+	"rx_dropped_bytes_fifo_full",
+};
+
+#define OCTEP_VF_GLOBAL_STATS_CNT (sizeof(octep_vf_gstrings_global_stats) / ETH_GSTRING_LEN)
+
+static const char octep_vf_gstrings_tx_q_stats[][ETH_GSTRING_LEN] = {
+	"tx_packets_posted[Q-%u]",
+	"tx_packets_completed[Q-%u]",
+	"tx_bytes[Q-%u]",
+	"tx_busy[Q-%u]",
+};
+
+#define OCTEP_VF_TX_Q_STATS_CNT (sizeof(octep_vf_gstrings_tx_q_stats) / ETH_GSTRING_LEN)
+
+static const char octep_vf_gstrings_rx_q_stats[][ETH_GSTRING_LEN] = {
+	"rx_packets[Q-%u]",
+	"rx_bytes[Q-%u]",
+	"rx_alloc_errors[Q-%u]",
+};
+
+#define OCTEP_VF_RX_Q_STATS_CNT (sizeof(octep_vf_gstrings_rx_q_stats) / ETH_GSTRING_LEN)
+
+static void octep_vf_get_drvinfo(struct net_device *netdev,
+				 struct ethtool_drvinfo *info)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+
+	strscpy(info->driver, OCTEP_VF_DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(oct->pdev), sizeof(info->bus_info));
+}
+
+static void octep_vf_get_strings(struct net_device *netdev,
+				 u32 stringset, u8 *data)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u16 num_queues = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	char *strings = (char *)data;
+	int i, j;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < OCTEP_VF_GLOBAL_STATS_CNT; i++) {
+			snprintf(strings, ETH_GSTRING_LEN,
+				 octep_vf_gstrings_global_stats[i]);
+			strings += ETH_GSTRING_LEN;
+		}
+
+		for (i = 0; i < num_queues; i++) {
+			for (j = 0; j < OCTEP_VF_TX_Q_STATS_CNT; j++) {
+				snprintf(strings, ETH_GSTRING_LEN,
+					 octep_vf_gstrings_tx_q_stats[j], i);
+				strings += ETH_GSTRING_LEN;
+			}
+		}
+
+		for (i = 0; i < num_queues; i++) {
+			for (j = 0; j < OCTEP_VF_RX_Q_STATS_CNT; j++) {
+				snprintf(strings, ETH_GSTRING_LEN,
+					 octep_vf_gstrings_rx_q_stats[j], i);
+				strings += ETH_GSTRING_LEN;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static int octep_vf_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u16 num_queues = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return OCTEP_VF_GLOBAL_STATS_CNT + (num_queues *
+		       (OCTEP_VF_TX_Q_STATS_CNT + OCTEP_VF_RX_Q_STATS_CNT));
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void octep_vf_get_ethtool_stats(struct net_device *netdev,
+				       struct ethtool_stats *stats, u64 *data)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct octep_vf_iface_tx_stats *iface_tx_stats;
+	struct octep_vf_iface_rx_stats *iface_rx_stats;
+	u64 rx_alloc_errors, tx_busy_errors;
+	int q, i;
+
+	rx_alloc_errors = 0;
+	tx_busy_errors = 0;
+
+	octep_vf_get_if_stats(oct);
+	iface_tx_stats = &oct->iface_tx_stats;
+	iface_rx_stats = &oct->iface_rx_stats;
+
+	for (q = 0; q < oct->num_oqs; q++) {
+		struct octep_vf_iq *iq = oct->iq[q];
+		struct octep_vf_oq *oq = oct->oq[q];
+
+		tx_busy_errors += iq->stats.tx_busy;
+		rx_alloc_errors += oq->stats.alloc_failures;
+	}
+	i = 0;
+	data[i++] = rx_alloc_errors;
+	data[i++] = tx_busy_errors;
+	data[i++] = iface_tx_stats->pkts;
+	data[i++] = iface_tx_stats->octs;
+	data[i++] = iface_tx_stats->bcst;
+	data[i++] = iface_tx_stats->mcst;
+	data[i++] = iface_rx_stats->pkts;
+	data[i++] = iface_rx_stats->octets;
+	data[i++] = iface_rx_stats->bcast_pkts;
+	data[i++] = iface_rx_stats->dropped_octets_fifo_full;
+
+	/* Per Tx Queue stats */
+	for (q = 0; q < oct->num_iqs; q++) {
+		struct octep_vf_iq *iq = oct->iq[q];
+
+		data[i++] = iq->stats.instr_posted;
+		data[i++] = iq->stats.instr_completed;
+		data[i++] = iq->stats.bytes_sent;
+		data[i++] = iq->stats.tx_busy;
+	}
+
+	/* Per Rx Queue stats */
+	for (q = 0; q < oct->num_oqs; q++) {
+		struct octep_vf_oq *oq = oct->oq[q];
+
+		data[i++] = oq->stats.packets;
+		data[i++] = oq->stats.bytes;
+		data[i++] = oq->stats.alloc_failures;
+	}
+}
+
+#define OCTEP_VF_SET_ETHTOOL_LINK_MODES_BITMAP(octep_vf_speeds, ksettings, name) \
+{ \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_T)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseT_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_R)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseR_FEC); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_CR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseCR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_KR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseKR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_LR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseLR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_10GBASE_SR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 10000baseSR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_25GBASE_CR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 25000baseCR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_25GBASE_KR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 25000baseKR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_25GBASE_SR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 25000baseSR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_40GBASE_CR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 40000baseCR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_40GBASE_KR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 40000baseKR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_40GBASE_LR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 40000baseLR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_40GBASE_SR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 40000baseSR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_CR2)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseCR2_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_KR2)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseKR2_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_SR2)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseSR2_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_CR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseCR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_KR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseKR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_LR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseLR_ER_FR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_50GBASE_SR)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 50000baseSR_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_100GBASE_CR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 100000baseCR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_100GBASE_KR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 100000baseKR4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_100GBASE_LR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 100000baseLR4_ER4_Full); \
+	if ((octep_vf_speeds) & BIT(OCTEP_VF_LINK_MODE_100GBASE_SR4)) \
+		ethtool_link_ksettings_add_link_mode(ksettings, name, 100000baseSR4_Full); \
+}
+
+static int octep_vf_get_link_ksettings(struct net_device *netdev,
+				       struct ethtool_link_ksettings *cmd)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct octep_vf_iface_link_info *link_info;
+	u32 advertised_modes, supported_modes;
+
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+
+	octep_vf_get_link_info(oct);
+
+	advertised_modes = oct->link_info.advertised_modes;
+	supported_modes = oct->link_info.supported_modes;
+	link_info = &oct->link_info;
+
+	OCTEP_VF_SET_ETHTOOL_LINK_MODES_BITMAP(supported_modes, cmd, supported);
+	OCTEP_VF_SET_ETHTOOL_LINK_MODES_BITMAP(advertised_modes, cmd, advertising);
+
+	if (link_info->autoneg) {
+		if (link_info->autoneg & OCTEP_VF_LINK_MODE_AUTONEG_SUPPORTED)
+			ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
+		if (link_info->autoneg & OCTEP_VF_LINK_MODE_AUTONEG_ADVERTISED) {
+			ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+			cmd->base.autoneg = AUTONEG_ENABLE;
+		} else {
+			cmd->base.autoneg = AUTONEG_DISABLE;
+		}
+	} else {
+		cmd->base.autoneg = AUTONEG_DISABLE;
+	}
+
+	cmd->base.port = PORT_FIBRE;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
+
+	if (netif_carrier_ok(netdev)) {
+		cmd->base.speed = link_info->speed;
+		cmd->base.duplex = DUPLEX_FULL;
+	} else {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
+	return 0;
+}
+
+static const struct ethtool_ops octep_vf_ethtool_ops = {
+	.get_drvinfo = octep_vf_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_strings = octep_vf_get_strings,
+	.get_sset_count = octep_vf_get_sset_count,
+	.get_ethtool_stats = octep_vf_get_ethtool_stats,
+	.get_link_ksettings = octep_vf_get_link_ksettings,
+};
+
+void octep_vf_set_ethtool_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &octep_vf_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index a2e56973c39e..f02a93cfd73b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -1091,6 +1091,7 @@ static int octep_vf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&octep_vf_dev->tx_timeout_task, octep_vf_tx_timeout_task);
 
 	netdev->netdev_ops = &octep_vf_netdev_ops;
+	octep_vf_set_ethtool_ops(netdev);
 	netif_carrier_off(netdev);
 
 	if (octep_vf_setup_mbox(octep_vf_dev)) {
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index 5a3b545ad590..5769f62545cd 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -327,6 +327,7 @@ void octep_vf_device_setup_cn93(struct octep_vf_device *oct);
 void octep_vf_device_setup_cnxk(struct octep_vf_device *oct);
 int octep_vf_iq_process_completions(struct octep_vf_iq *iq, u16 budget);
 int octep_vf_oq_process_rx(struct octep_vf_oq *oq, int budget);
+void octep_vf_set_ethtool_ops(struct net_device *netdev);
 int octep_vf_get_link_info(struct octep_vf_device *oct);
 int octep_vf_get_if_stats(struct octep_vf_device *oct);
 void octep_vf_mbox_work(struct work_struct *work);
-- 
2.25.1


