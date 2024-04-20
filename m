Return-Path: <linux-kernel+bounces-152361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E377B8ABCEA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C191C209B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BA4AEC7;
	Sat, 20 Apr 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NvuvUZvk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3093FE4E;
	Sat, 20 Apr 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641396; cv=none; b=IPwe7BQ0wQVTWqjZsCdG3EHHMydPqN7nZ8KA1to1vIEFg3FZUxQxeKx90Ub4IesLW/N61rjnvMrQNYbRl2uPJra11wbspyJzH96zXiTDdZxI9lzrv84pStD9rbNkWoMNjr4CaDxqpd7xg4nS59E0hHVm44n3VJw/3uV/yjZqYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641396; c=relaxed/simple;
	bh=Ik9EQbMe8HbPkSq9sr1NNJbIkQ1gQWFBQhm04HdPJ9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hQ/qss/DMHj8f+RVOpD3xJoqNzu0iniXKNs+CuxOhxqbhlsM2xsmXUmdqyVMMQT+tQ7KfNjvLyxO/5xL6oJUpv7HhuTZyqMgXnKlI/bLW1JqmqP56e7n7F0La4agOqUUJlxoc08DKcYIoeLfucoKP+Ny5H70zxQmxjOmEht5ObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NvuvUZvk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641395; x=1745177395;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ik9EQbMe8HbPkSq9sr1NNJbIkQ1gQWFBQhm04HdPJ9w=;
  b=NvuvUZvkhkuTFqpAdrBRpZp/WwNMoNtRt7IGyzaEIlFF/mZKthMM2KpO
   kFJH3QWgdAHzYbpRw04lBiALvr0s/Xdn7J4SPunLmtVX2DbtSBmbVGlzI
   RmvX1Np2fRg6kF5koVj6MK/I6hJ9YXYKVYfM5KE9MsJBTpxjBBxHTuurO
   h5WN7+7tf0e3uJu2gTLxIZnxuq2vPdOE0P04M+4xaw2kWNAn/rNuWU+IX
   q2R6AXIi3/UiILK7wzv9RGaqqenfwpvFGZmYKMH/Z+c/DMnE42usrln3H
   dLSEbwX3FVxdrRMDVSIq0A05xX8LUbEnMOg2CKykqTB+wxuP7IQ5d73Ck
   Q==;
X-CSE-ConnectionGUID: r3PO+GVPQoGyYBK6996e2w==
X-CSE-MsgGUID: afDOspa6Qi6pagNpuqwhsg==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="22513532"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:29:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:29:33 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 12:29:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Sat, 20 Apr 2024 21:29:13 +0200
Subject: [PATCH net-next v3 4/5] net: sparx5: add the tc glue to support
 port mirroring
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240420-port-mirroring-v3-4-0fe3ac52006d@microchip.com>
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

Add the necessary tc glue to add and delete mirror rules through tc
matchall.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 38 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 2a33b347098f..4f9ae026fa47 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -36,6 +36,13 @@ static void sparx5_tc_matchall_parse_action(struct sparx5_port *port,
 	entry->cookie = cookie;
 }
 
+static void
+sparx5_tc_matchall_parse_mirror_action(struct sparx5_mall_entry *entry,
+				       struct flow_action_entry *action)
+{
+	entry->mirror.port = netdev_priv(action->dev);
+}
+
 static int sparx5_tc_matchall_replace(struct net_device *ndev,
 				      struct tc_cls_matchall_offload *tmo,
 				      bool ingress)
@@ -65,6 +72,31 @@ static int sparx5_tc_matchall_replace(struct net_device *ndev,
 
 	sparx5 = port->sparx5;
 	switch (action->id) {
+	case FLOW_ACTION_MIRRED:
+		sparx5_tc_matchall_parse_mirror_action(mall_entry, action);
+		err = sparx5_mirror_add(mall_entry);
+		if (err) {
+			switch (err) {
+			case -EEXIST:
+				NL_SET_ERR_MSG_MOD(tmo->common.extack,
+						   "Mirroring already exists");
+				break;
+			case -EINVAL:
+				NL_SET_ERR_MSG_MOD(tmo->common.extack,
+						   "Cannot mirror a monitor port");
+				break;
+			case -ENOENT:
+				NL_SET_ERR_MSG_MOD(tmo->common.extack,
+						   "No more mirror probes available");
+				break;
+			default:
+				NL_SET_ERR_MSG_MOD(tmo->common.extack,
+						   "Unknown error");
+				break;
+			}
+			return err;
+		}
+		break;
 	case FLOW_ACTION_GOTO:
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
 					  tmo->common.chain_index,
@@ -108,14 +140,16 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 	struct sparx5_port *port = netdev_priv(ndev);
 	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_mall_entry *entry;
-	int err;
+	int err = 0;
 
 	entry = sparx5_tc_matchall_entry_find(&sparx5->mall_entries,
 					      tmo->cookie);
 	if (!entry)
 		return -ENOENT;
 
-	if (entry->type == FLOW_ACTION_GOTO) {
+	if (entry->type == FLOW_ACTION_MIRRED) {
+		sparx5_mirror_del(entry);
+	} else if (entry->type == FLOW_ACTION_GOTO) {
 		err = vcap_enable_lookups(sparx5->vcap_ctrl, ndev,
 					  0, 0, tmo->cookie, false);
 	} else {

-- 
2.34.1


