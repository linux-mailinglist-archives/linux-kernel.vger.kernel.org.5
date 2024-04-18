Return-Path: <linux-kernel+bounces-150524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CC08AA07F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F6B283DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E1176FB1;
	Thu, 18 Apr 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eEK+P2+k"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924E16078D;
	Thu, 18 Apr 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459443; cv=none; b=TA4cm/Y/c85row2uq6ubUQgfdPy3KAp2484VsWSLXZvlcA+O7EgwLy699bKSX2MNboIp6qE/LlSB+ywHK+eEQaYxNruYHHTqFs21m5rPEeauvXtUxF9HUBmXGmWS1pP1id5T4tCMtpm8xujeX10yDHOQIPSydDfy5md7ch9fWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459443; c=relaxed/simple;
	bh=9+3RpHdiu9N+hHXVc785KNc32OSelwLqLQLwZye2W9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZyiAtgyWXgUT/4GVL7oe/uEO4ioU9Bk5mWQ1MUoIIRqkK3ZMl21SApH8IaTdVYC9y9Eu0YSYaJMURtVr+Eag1mOs+h/1PmS+EXtVBGZv+Lo4sv5OCFpGblD0DuRsztrUZQOsH+BLFwt0+XE+YQERKo241XLEkAD87ffkLHz0QZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eEK+P2+k; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713459441; x=1744995441;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9+3RpHdiu9N+hHXVc785KNc32OSelwLqLQLwZye2W9A=;
  b=eEK+P2+kTSUDJi7qsfZXv5H+I6L8RxXD2/uo5/TxdIK8eb2UhYkzJzBE
   crEtIzRX76yt8uahwxTdpQ4T9M+mhJfRM5CF6IiRVaKStoiWGGcTT9jw6
   e75zDwH2/oeziySt4l/YJ3iWzXpTcu4YRqVi0jYvjRF2B5AM4wve0AXwE
   BbVeZzB9hZsP4AH4JpZhNmE3/GWUqQaTfcb6qpDwxGXPDJTbpnFHQCxlc
   pbhkw5WsYWbjqBboC7rnoqiBPpPWWzL8B5zwzZsA86167cHy+7i7CZ/Gr
   c1RkBe8ojuNjRVv1XgoCgLPdUSwvyBnmn9CDjf+gPV11gSXr2aSSvtzBC
   A==;
X-CSE-ConnectionGUID: IpAKQTwwQLuvUOb4hfuiSQ==
X-CSE-MsgGUID: KqRfNEAaRXOukzlUDeGtLg==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="188927091"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 09:57:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:56:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:56:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 18:56:36 +0200
Subject: [PATCH net-next v2 3/5] net: sparx5: add port mirroring
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v2-3-20642868b386@microchip.com>
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

The hardware supports three independent mirroring probes. Each probe can
be configured to mirror rx or tx traffic (direction).

Using tc matchall, it is now possible to add a source port and a monitor
port to a mirror probe. Depending on the mirror direction, rx or tx
traffic from a source port will be mirrored to the monitor port.

A single source port can be a member of multiple mirror probes.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  12 ++
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 196 +++++++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 1cb1cc3f1a85..b68fe9c9a656 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -10,7 +10,8 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
  sparx5_switchdev.o sparx5_calendar.o sparx5_ethtool.o sparx5_fdma.o \
  sparx5_ptp.o sparx5_pgid.o sparx5_tc.o sparx5_qos.o \
  sparx5_vcap_impl.o sparx5_vcap_ag_api.o sparx5_tc_flower.o \
- sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o sparx5_psfp.o
+ sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o \
+ sparx5_psfp.o sparx5_mirror.o
 
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
 sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 4de37a5387a4..5d026e1670f5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -228,12 +228,20 @@ struct sparx5_mdb_entry {
 	u16 pgid_idx;
 };
 
+struct sparx5_mall_mirror_entry {
+	u32 idx;
+	struct sparx5_port *port;
+};
+
 struct sparx5_mall_entry {
 	struct list_head list;
 	struct sparx5_port *port;
 	unsigned long cookie;
 	enum flow_action_id type;
 	bool ingress;
+	union {
+		struct sparx5_mall_mirror_entry mirror;
+	};
 };
 
 #define SPARX5_PTP_TIMEOUT		msecs_to_jiffies(10)
@@ -551,6 +559,10 @@ void sparx5_psfp_init(struct sparx5 *sparx5);
 void sparx5_new_base_time(struct sparx5 *sparx5, const u32 cycle_time,
 			  const ktime_t org_base_time, ktime_t *new_base_time);
 
+/* sparx5_mirror.c */
+int sparx5_mirror_add(struct sparx5_mall_entry *entry);
+void sparx5_mirror_del(struct sparx5_mall_entry *entry);
+
 /* Clock period in picoseconds */
 static inline u32 sparx5_clk_period(enum sparx5_core_clockfreq cclock)
 {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
new file mode 100644
index 000000000000..540bde15eeff
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include "sparx5_main.h"
+#include "sparx5_main_regs.h"
+#include "sparx5_tc.h"
+
+#define SPX5_MIRROR_PROBE_MAX 3
+#define SPX5_MIRROR_DISABLED 0
+#define SPX5_MIRROR_EGRESS 1
+#define SPX5_MIRROR_INGRESS 2
+#define SPX5_MIRROR_MONITOR_PORT_DEFAULT 65
+#define SPX5_QFWD_MP_OFFSET 9 /* Mirror port offset in the QFWD register */
+
+/* Convert from bool ingress/egress to mirror direction */
+static u32 sparx5_mirror_to_dir(bool ingress)
+{
+	return ingress ? SPX5_MIRROR_INGRESS : SPX5_MIRROR_EGRESS;
+}
+
+/* Get ports belonging to this mirror */
+static u64 sparx5_mirror_port_get(struct sparx5 *sparx5, u32 idx)
+{
+	return (u64)spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG1(idx)) << 32 |
+	       spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG(idx));
+}
+
+/* Add port to mirror (only front ports) */
+static void sparx5_mirror_port_add(struct sparx5 *sparx5, u32 idx, u32 portno)
+{
+	u32 val, reg = portno;
+
+	val = BIT(do_div(reg, 32));
+
+	if (reg == 0)
+		return spx5_rmw(val, val, sparx5, ANA_AC_PROBE_PORT_CFG(idx));
+	else
+		return spx5_rmw(val, val, sparx5, ANA_AC_PROBE_PORT_CFG1(idx));
+}
+
+/* Delete port from mirror (only front ports) */
+static void sparx5_mirror_port_del(struct sparx5 *sparx5, u32 idx, u32 portno)
+{
+	u32 val, reg = portno;
+
+	val = BIT(do_div(reg, 32));
+
+	if (reg == 0)
+		return spx5_rmw(0, val, sparx5, ANA_AC_PROBE_PORT_CFG(idx));
+	else
+		return spx5_rmw(0, val, sparx5, ANA_AC_PROBE_PORT_CFG1(idx));
+}
+
+/* Check if mirror contains port */
+static bool sparx5_mirror_contains(struct sparx5 *sparx5, u32 idx, u32 portno)
+{
+	return (sparx5_mirror_port_get(sparx5, idx) & BIT_ULL(portno)) != 0;
+}
+
+/* Check if mirror is empty */
+static bool sparx5_mirror_is_empty(struct sparx5 *sparx5, u32 idx)
+{
+	return sparx5_mirror_port_get(sparx5, idx) == 0;
+}
+
+/* Get direction of mirror */
+static u32 sparx5_mirror_dir_get(struct sparx5 *sparx5, u32 idx)
+{
+	u32 val = spx5_rd(sparx5, ANA_AC_PROBE_CFG(idx));
+
+	return ANA_AC_PROBE_CFG_PROBE_DIRECTION_GET(val);
+}
+
+/* Set direction of mirror */
+static void sparx5_mirror_dir_set(struct sparx5 *sparx5, u32 idx, u32 dir)
+{
+	spx5_rmw(ANA_AC_PROBE_CFG_PROBE_DIRECTION_SET(dir),
+		 ANA_AC_PROBE_CFG_PROBE_DIRECTION, sparx5,
+		 ANA_AC_PROBE_CFG(idx));
+}
+
+/* Set the monitor port for this mirror */
+static void sparx5_mirror_monitor_set(struct sparx5 *sparx5, u32 idx,
+				      u32 portno)
+{
+	spx5_rmw(QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL_SET(portno),
+		 QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL, sparx5,
+		 QFWD_FRAME_COPY_CFG(idx + SPX5_QFWD_MP_OFFSET));
+}
+
+/* Get the monitor port of this mirror */
+static u32 sparx5_mirror_monitor_get(struct sparx5 *sparx5, u32 idx)
+{
+	u32 val = spx5_rd(sparx5,
+			  QFWD_FRAME_COPY_CFG(idx + SPX5_QFWD_MP_OFFSET));
+
+	return QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL_GET(val);
+}
+
+/* Check if port is the monitor port of this mirror */
+static bool sparx5_mirror_has_monitor(struct sparx5 *sparx5, u32 idx,
+				      u32 portno)
+{
+	return sparx5_mirror_monitor_get(sparx5, idx) == portno;
+}
+
+/* Get a suitable mirror for this port */
+static int sparx5_mirror_get(struct sparx5_port *sport,
+			     struct sparx5_port *mport, u32 dir, u32 *idx)
+{
+	struct sparx5 *sparx5 = sport->sparx5;
+	u32 i;
+
+	/* Check if this port is already used as a monitor port */
+	for (i = 0; i < SPX5_MIRROR_PROBE_MAX; i++)
+		if (sparx5_mirror_has_monitor(sparx5, i, sport->portno))
+			return -EINVAL;
+
+	/* Check if existing mirror can be reused
+	 * (same direction and monitor port).
+	 */
+	for (i = 0; i < SPX5_MIRROR_PROBE_MAX; i++) {
+		if (sparx5_mirror_dir_get(sparx5, i) == dir &&
+		    sparx5_mirror_has_monitor(sparx5, i, mport->portno)) {
+			*idx = i;
+			return 0;
+		}
+	}
+
+	/* Return free mirror */
+	for (i = 0; i < SPX5_MIRROR_PROBE_MAX; i++) {
+		if (sparx5_mirror_is_empty(sparx5, i)) {
+			*idx = i;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int sparx5_mirror_add(struct sparx5_mall_entry *entry)
+{
+	u32 mirror_idx, dir = sparx5_mirror_to_dir(entry->ingress);
+	struct sparx5_port *sport, *mport;
+	struct sparx5 *sparx5;
+	int err;
+
+	/* Source port */
+	sport = entry->port;
+	/* monitor port */
+	mport = entry->mirror.port;
+	sparx5 = sport->sparx5;
+
+	if (sport->portno == mport->portno)
+		return -EINVAL;
+
+	err = sparx5_mirror_get(sport, mport, dir, &mirror_idx);
+	if (err)
+		return err;
+
+	if (sparx5_mirror_contains(sparx5, mirror_idx, sport->portno))
+		return -EEXIST;
+
+	/* Add port to mirror */
+	sparx5_mirror_port_add(sparx5, mirror_idx, sport->portno);
+
+	/* Set direction of mirror */
+	sparx5_mirror_dir_set(sparx5, mirror_idx, dir);
+
+	/* Set monitor port for mirror */
+	sparx5_mirror_monitor_set(sparx5, mirror_idx, mport->portno);
+
+	entry->mirror.idx = mirror_idx;
+
+	return 0;
+}
+
+void sparx5_mirror_del(struct sparx5_mall_entry *entry)
+{
+	struct sparx5_port *port = entry->port;
+	struct sparx5 *sparx5 = port->sparx5;
+	u32 mirror_idx = entry->mirror.idx;
+
+	sparx5_mirror_port_del(sparx5, mirror_idx, port->portno);
+	if (!sparx5_mirror_is_empty(sparx5, mirror_idx))
+		return;
+
+	sparx5_mirror_dir_set(sparx5, mirror_idx, SPX5_MIRROR_DISABLED);
+
+	sparx5_mirror_monitor_set(sparx5,
+				  mirror_idx,
+				  SPX5_MIRROR_MONITOR_PORT_DEFAULT);
+}

-- 
2.34.1


