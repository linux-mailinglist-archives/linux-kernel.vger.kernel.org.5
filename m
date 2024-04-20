Return-Path: <linux-kernel+bounces-152362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C98ABCEC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8787A1C20AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4674D9F2;
	Sat, 20 Apr 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z11g4UwU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95C46441;
	Sat, 20 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641397; cv=none; b=g09CeIKGyB9nMckPF7l4sbF0J61PpZ8wSAIXD76PF0df2s0p8MAlZuu3dhDi6x1V6cnJG/HVIKdqYvBk824pNnX/kBO9D/e1X/q3UF9uY4NCjl3s4RBPvTDeMapSIjBcxPZCx/LvVr3W9hkOS0cM605zLOdCXyuC6Wv9/OzWvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641397; c=relaxed/simple;
	bh=FrLjMd7WgXxrkhcJPa3dqPPJxrUeznyOVxvRW+RY4K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NZDZDtDciIynBwo9pmmjUP6xfyD1oHYBDXU/ouu80cASiupfcFcrylTjO+dGtRj9uYV8lwrqcAZETc30vbAehQ92W9sC4sj+gjtyBiPZQHt1CMrN8sNTSjv4t7sawqSQiWvs2moANpXcRtRZTh+H7bbeV60DiT0r3Od8lBNuQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z11g4UwU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641395; x=1745177395;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FrLjMd7WgXxrkhcJPa3dqPPJxrUeznyOVxvRW+RY4K0=;
  b=z11g4UwUBnIShGtP0ylXb+c1HVm/zbKB8/fad1EDR1FTkhieahiOu1U8
   u67se5tt4/iB9jeLny3mgsdJ5WnYzCsqDQhcLpfF+FbLkV6yJrDx6Q2p3
   chGzXwkqEh9LhTNI0/0uL0VzgWZ4GuER2JRUiDu3KkqPji5MrCqN6J8de
   uy5QUrg+Ahkh3d+YpP89URSpJT8YcmlY/ut/njMCSR8hjoxwWmfvxraFP
   OoJTqyc3An0XqJAMGlfmeewJZI8zow5v2muyVvRMA9C6Nm9I3JQc0DCx4
   KEfmtL7CgEckvvsbjV2TvEoCvlJhzBvUutKlhhmNpbpcSk5KOptPf9AEu
   g==;
X-CSE-ConnectionGUID: r3PO+GVPQoGyYBK6996e2w==
X-CSE-MsgGUID: JpnCkACNSVS4oSYVFiQsyw==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="22513533"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:29:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:29:37 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 12:29:33 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Sat, 20 Apr 2024 21:29:14 +0200
Subject: [PATCH net-next v3 5/5] net: sparx5: add support for matchall
 mirror stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240420-port-mirroring-v3-5-0fe3ac52006d@microchip.com>
References: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
In-Reply-To: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Yue Haibing <yuehaibing@huawei.com>, Daniel Machon
	<daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

Add support for tc matchall mirror stats. When a new matchall mirror
rule is added, the baseline stats for that port is saved.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  3 ++
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 37 ++++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 27 ++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 5d026e1670f5..1982ae03b4fe 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -174,6 +174,7 @@ struct sparx5_port {
 	struct phylink_config phylink_config;
 	struct phylink *phylink;
 	struct phylink_pcs phylink_pcs;
+	struct flow_stats mirror_stats;
 	u16 portno;
 	/* Ingress default VLAN (pvid) */
 	u16 pvid;
@@ -562,6 +563,8 @@ void sparx5_new_base_time(struct sparx5 *sparx5, const u32 cycle_time,
 /* sparx5_mirror.c */
 int sparx5_mirror_add(struct sparx5_mall_entry *entry);
 void sparx5_mirror_del(struct sparx5_mall_entry *entry);
+void sparx5_mirror_stats(struct sparx5_mall_entry *entry,
+			 struct flow_stats *fstats);
 
 /* Clock period in picoseconds */
 static inline u32 sparx5_clk_period(enum sparx5_core_clockfreq cclock)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
index f029634a6a42..15db423be4aa 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -196,3 +196,40 @@ void sparx5_mirror_del(struct sparx5_mall_entry *entry)
 				  mirror_idx,
 				  SPX5_MIRROR_MONITOR_PORT_DEFAULT);
 }
+
+void sparx5_mirror_stats(struct sparx5_mall_entry *entry,
+			 struct flow_stats *fstats)
+{
+	struct sparx5_port *port = entry->port;
+	struct rtnl_link_stats64 new_stats;
+	struct flow_stats *old_stats;
+
+	old_stats = &entry->port->mirror_stats;
+	sparx5_get_stats64(port->ndev, &new_stats);
+
+	if (entry->ingress) {
+		flow_stats_update(fstats,
+				  new_stats.rx_bytes - old_stats->bytes,
+				  new_stats.rx_packets - old_stats->pkts,
+				  new_stats.rx_dropped - old_stats->drops,
+				  old_stats->lastused,
+				  FLOW_ACTION_HW_STATS_IMMEDIATE);
+
+		old_stats->bytes = new_stats.rx_bytes;
+		old_stats->pkts = new_stats.rx_packets;
+		old_stats->drops = new_stats.rx_dropped;
+		old_stats->lastused = jiffies;
+	} else {
+		flow_stats_update(fstats,
+				  new_stats.tx_bytes - old_stats->bytes,
+				  new_stats.tx_packets - old_stats->pkts,
+				  new_stats.tx_dropped - old_stats->drops,
+				  old_stats->lastused,
+				  FLOW_ACTION_HW_STATS_IMMEDIATE);
+
+		old_stats->bytes = new_stats.tx_bytes;
+		old_stats->pkts = new_stats.tx_packets;
+		old_stats->drops = new_stats.tx_dropped;
+		old_stats->lastused = jiffies;
+	}
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 4f9ae026fa47..6b4d1d7b9730 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -96,6 +96,8 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
 			}
 			return err;
 		}
+		/* Get baseline stats for this port */
+		sparx5_mirror_stats(mall_entry, &tmo->stats);
 		break;
 	case FLOW_ACTION_GOTO:
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
@@ -162,6 +164,29 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 	return err;
 }
 
+static int sparx5_tc_matchall_stats(struct net_device *ndev,
+				    struct tc_cls_matchall_offload *tmo,
+				    bool ingress)
+{
+	struct sparx5_port *port = netdev_priv(ndev);
+	struct sparx5 *sparx5 = port->sparx5;
+	struct sparx5_mall_entry *entry;
+
+	entry = sparx5_tc_matchall_entry_find(&sparx5->mall_entries,
+					      tmo->cookie);
+	if (!entry)
+		return -ENOENT;
+
+	if (entry->type == FLOW_ACTION_MIRRED) {
+		sparx5_mirror_stats(entry, &tmo->stats);
+	} else {
+		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 int sparx5_tc_matchall(struct net_device *ndev,
 		       struct tc_cls_matchall_offload *tmo,
 		       bool ingress)
@@ -171,6 +196,8 @@ int sparx5_tc_matchall(struct net_device *ndev,
 		return sparx5_tc_matchall_replace(ndev, tmo, ingress);
 	case TC_CLSMATCHALL_DESTROY:
 		return sparx5_tc_matchall_destroy(ndev, tmo, ingress);
+	case TC_CLSMATCHALL_STATS:
+		return sparx5_tc_matchall_stats(ndev, tmo, ingress);
 	default:
 		return -EOPNOTSUPP;
 	}

-- 
2.34.1


