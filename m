Return-Path: <linux-kernel+bounces-150526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF018AA084
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80C7B21D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5917A92D;
	Thu, 18 Apr 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yoDNJb9I"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B1171E48;
	Thu, 18 Apr 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459454; cv=none; b=J0L5RkKNjUhvPpp9fYmEGYlQKlArW8T8YspHChFJCsU3TTg1vXzecrPBQ3uhIPKuwBJcaF5Y4Q5Tp5RgX8JPWvFSNVEvgolGzO5l/8m29H3wG86jyDsMYDtJmUc5D967c5lAFFgWrSXPBbziB2MUd/YB/DQbFXUb5jXc2vqiHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459454; c=relaxed/simple;
	bh=z/xAOaDTmqkvVk/hZsD+Z4/Wx9LHmhiX52IaR6bPDLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Jy6NK2mFAH9F6ZBfI621RBiQaSCSyOwnMmqaQ4Lyko/82WlnTFX1BYfem+ub5LCtjD5V8NQqYf9hU7rpdFZ+WvwjmLFVb6qRbJCKaW6nr6hsIGZrFXmDzNmFoUe4ZbRJhzV30NGWNoADii6VJ4zLswHlUzpAuaNuI89enCvwu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yoDNJb9I; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713459453; x=1744995453;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=z/xAOaDTmqkvVk/hZsD+Z4/Wx9LHmhiX52IaR6bPDLE=;
  b=yoDNJb9InCIx/9+9z5q6JN/EGdWtzuF/M5Be8SIO/dQh3xoxs7QMtDc5
   xeGCzd4a9B31M55fRi8VM231SIfuSJULS51yDbNAXrAG0/AbThiWok/Nq
   9lsXFlu6fjUlfoSzje3Xl7EoBvoYQY360WlfJp2CGnreTIO/6cHhw0edG
   NxUCVvvaYp1Nolvi5jYJlkFlb3Jd3Tyn79dx7e4ItDeNbu0prCkc0eBIJ
   2KUn768ZDUNnZozaj1LZS9hbYzPjOraFP2+4TJbVrgfK68vOqH3jDltzO
   ohPXNfAakqaliqoQrYXliBEWJKuR/NitUdPVj7q0SpzgMfJlp6fQiz8Mv
   A==;
X-CSE-ConnectionGUID: knOBDkbjTBmC3G9PZhVd9w==
X-CSE-MsgGUID: RZfgzYGfTOGkmiP2urrtkQ==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="252441394"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 09:57:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:57:01 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:56:58 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 18:56:38 +0200
Subject: [PATCH net-next v2 5/5] net: sparx5: add support for matchall
 mirror stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v2-5-20642868b386@microchip.com>
References: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
In-Reply-To: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
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
index 540bde15eeff..9dcc3c22fe49 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -194,3 +194,40 @@ void sparx5_mirror_del(struct sparx5_mall_entry *entry)
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


