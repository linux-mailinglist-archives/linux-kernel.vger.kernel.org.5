Return-Path: <linux-kernel+bounces-150523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE458AA07A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917BD285B44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78D17332B;
	Thu, 18 Apr 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k2/ST5Gv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA216F29F;
	Thu, 18 Apr 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459442; cv=none; b=tP2IrrzGZ2VDpugT2JvKuWJHqJJTI+YuSGju8ngnSsOhbDZQECT7oLZtt5EhNTXFtAEIzAXz4/K5X+icvt8o9bQfFmAu+yxoBjRQ7AKvzrBleTqOyVPgwb/0tZnL4MkMapwVyMvda5HSN4pH+es4+5DMGVyOQnNwFAs0ZB6W2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459442; c=relaxed/simple;
	bh=JSxhXh6RPEu44GhG9pzlc/+ekiyPeScDzIdegYj3TeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k0kn9MpcUXPNcgMU1NrylL/CZLzGgumq42wyGpfkgDQivbwgd2zSdk1R85l/zf0ppUoeJDEaHrd2b6auQZoIc87g7j03Now0V28jDZw7cWl2/CB7BSut1BND/j+ywkqXNkGBarsjcEoYvQZYL9ftQCB7BtXrwE3WyATPlLd81Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k2/ST5Gv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713459440; x=1744995440;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JSxhXh6RPEu44GhG9pzlc/+ekiyPeScDzIdegYj3TeE=;
  b=k2/ST5GvWVQDCeKE5py/HfitdtKCoxzFPkHBGclyIx9UtLr3+Qpn3weU
   T+84N+JbLfVjRVakMV6/zQkbytY1Nm10AARz8dkWICbKyZfNGIQCrWUEU
   cdWMTZTvYLvUyQouqbjdml/mOCcg7pmRlJP9xgtxU/mZm3HXj3xiTPaRh
   9MY7XgcN5BShqG6dmzuCOyqdNHBFqvDTfImp75FeehKen3+rC3tV6ODke
   8nmEx4hKlAON8WuihqnzdE+f0ORp3HGXUZr4njLtAWE/bh++V+F/1WdMa
   INNhQRtJQXfNG114vR/u7py0B5y2lMUSg0cMkm8lEpxok4+RIaCXohiDP
   Q==;
X-CSE-ConnectionGUID: IpAKQTwwQLuvUOb4hfuiSQ==
X-CSE-MsgGUID: iOTLrk4UTDWqDF7PYp7tHw==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="188927089"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 09:57:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:56:50 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:56:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 18:56:35 +0200
Subject: [PATCH net-next v2 2/5] net: sparx5: add bookkeeping code for
 matchall rules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v2-2-20642868b386@microchip.com>
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


