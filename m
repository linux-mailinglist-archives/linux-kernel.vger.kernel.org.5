Return-Path: <linux-kernel+bounces-152358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1788ABCE4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9173281798
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26941207;
	Sat, 20 Apr 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V+CfZjYU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918B3D0BE;
	Sat, 20 Apr 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641382; cv=none; b=QHQri5kN0IeB1f7t8VpcgEwX/T6ROvJ9sv4/iiIf8azVen8p3zwIuZgCoG2Qo4RlnRQKcil+m2jJ2RcLlb4vEFt9+A6osBcjScK742rhKSpiF0JpTCoxuwA061w5lrHSRNpM78uAxNeZgIx6lFMIbmm1zH43E/seXEMcZ7MXSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641382; c=relaxed/simple;
	bh=JSxhXh6RPEu44GhG9pzlc/+ekiyPeScDzIdegYj3TeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rbO5duhlGz+xEfdgLdiNayGSIIXiM/grh85J6yTZeJbO2MzuJZWdXjdBGC7Vz98K8Fr/FcMxc+xXHexwSabtizRGXiLNq7HnMn0K8q8WWkjH1UFktky4ZRne+CsGDNfsSeOXRPdBt/OqfVl1KQ6BI8Qnf5dFfrRglnrpwdn9Syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V+CfZjYU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641381; x=1745177381;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JSxhXh6RPEu44GhG9pzlc/+ekiyPeScDzIdegYj3TeE=;
  b=V+CfZjYU4C+nxMNR80cZWG87E+hSOE4pbQle4uVRskXHYgSaEcsV3UsZ
   sxHFH6QXLxvzMFPoXROZwuWSaDBV+koA8VDVB3frN8L69aEg4KC8jlJD6
   VlfAYKQP3AmjEw/nbXt+hr81jIAxbD07W5t4KWGpqqN8khjuDew4f86hv
   diVEuhyAt2r5sTUd2+L01xgu0bVIkaQ3motIbtXCwGDU4mxgFriqKYG53
   HIlpoHXYUQXCnqpRJpb8Xk+BV4t7u+F9xWFG7UHrcJrICoilMqod4bjPI
   v/OFZmA4l5vlUkqnCrHPRPy8LoZTkTDBa/MNi5147anIUkTPhO6iI1xzR
   g==;
X-CSE-ConnectionGUID: oyE2RY9sR1SS7WfkUKvMrg==
X-CSE-MsgGUID: yE3vbxSITrW2jR6BTWrz3g==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="21962176"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:29:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:29:26 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 12:29:23 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Sat, 20 Apr 2024 21:29:11 +0200
Subject: [PATCH net-next v3 2/5] net: sparx5: add bookkeeping code for
 matchall rules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240420-port-mirroring-v3-2-0fe3ac52006d@microchip.com>
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

In preparation for new tc matchall rules, we add a bit of bookkeeping
code to keep track of them. The rules are identified by the cookie
passed from the tc stack.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  3 ++
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 10 ++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 62 +++++++++++++++++++---
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 3c066b62e689..b64c814eac11 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -899,6 +899,9 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		dev_err(sparx5->dev, "PTP failed\n");
 		goto cleanup_ports;
 	}
+
+	INIT_LIST_HEAD(&sparx5->mall_entries);
+
 	goto cleanup_config;
 
 cleanup_ports:
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 316fed5f2735..4de37a5387a4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -18,6 +18,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/hrtimer.h>
 #include <linux/debugfs.h>
+#include <net/flow_offload.h>
 
 #include "sparx5_main_regs.h"
 
@@ -227,6 +228,14 @@ struct sparx5_mdb_entry {
 	u16 pgid_idx;
 };
 
+struct sparx5_mall_entry {
+	struct list_head list;
+	struct sparx5_port *port;
+	unsigned long cookie;
+	enum flow_action_id type;
+	bool ingress;
+};
+
 #define SPARX5_PTP_TIMEOUT		msecs_to_jiffies(10)
 #define SPARX5_SKB_CB(skb) \
 	((struct sparx5_skb_cb *)((skb)->cb))
@@ -295,6 +304,7 @@ struct sparx5 {
 	struct vcap_control *vcap_ctrl;
 	/* PGID allocation map */
 	u8 pgid_map[PGID_TABLE_SIZE];
+	struct list_head mall_entries;
 	/* Common root for debugfs */
 	struct dentry *debugfs_root;
 };
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index d88a93f22606..2a33b347098f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -11,11 +11,37 @@
 #include "sparx5_main.h"
 #include "sparx5_vcap_impl.h"
 
+static struct sparx5_mall_entry *
+sparx5_tc_matchall_entry_find(struct list_head *entries, unsigned long cookie)
+{
+	struct sparx5_mall_entry *entry;
+
+	list_for_each_entry(entry, entries, list) {
+		if (entry->cookie == cookie)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void sparx5_tc_matchall_parse_action(struct sparx5_port *port,
+					    struct sparx5_mall_entry *entry,
+					    struct flow_action_entry *action,
+					    bool ingress,
+					    unsigned long cookie)
+{
+	entry->port = port;
+	entry->type = action->id;
+	entry->ingress = ingress;
+	entry->cookie = cookie;
+}
+
 static int sparx5_tc_matchall_replace(struct net_device *ndev,
 				      struct tc_cls_matchall_offload *tmo,
 				      bool ingress)
 {
 	struct sparx5_port *port = netdev_priv(ndev);
+	struct sparx5_mall_entry *mall_entry;
 	struct flow_action_entry *action;
 	struct sparx5 *sparx5;
 	int err;
@@ -27,6 +53,16 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
 	}
 	action = &tmo->rule->action.entries[0];
 
+	mall_entry = kzalloc(sizeof(*mall_entry), GFP_KERNEL);
+	if (!mall_entry)
+		return -ENOMEM;
+
+	sparx5_tc_matchall_parse_action(port,
+					mall_entry,
+					action,
+					ingress,
+					tmo->cookie);
+
 	sparx5 = port->sparx5;
 	switch (action->id) {
 	case FLOW_ACTION_GOTO:
@@ -59,6 +95,9 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
 		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
 		return -EOPNOTSUPP;
 	}
+
+	list_add_tail(&mall_entry->list, &sparx5->mall_entries);
+
 	return 0;
 }
 
@@ -67,19 +106,26 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 				      bool ingress)
 {
 	struct sparx5_port *port = netdev_priv(ndev);
-	struct sparx5 *sparx5;
+	struct sparx5 *sparx5 = port->sparx5;
+	struct sparx5_mall_entry *entry;
 	int err;
 
-	sparx5 = port->sparx5;
-	if (!tmo->rule && tmo->cookie) {
+	entry = sparx5_tc_matchall_entry_find(&sparx5->mall_entries,
+					      tmo->cookie);
+	if (!entry)
+		return -ENOENT;
+
+	if (entry->type == FLOW_ACTION_GOTO) {
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
 					  0, 0, tmo->cookie, false);
-		if (err)
-			return err;
-		return 0;
+	} else {
+		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
+		err = -EOPNOTSUPP;
 	}
-	NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
-	return -EOPNOTSUPP;
+
+	list_del(&entry->list);
+
+	return err;
 }
 
 int sparx5_tc_matchall(struct net_device *ndev,

-- 
2.34.1


