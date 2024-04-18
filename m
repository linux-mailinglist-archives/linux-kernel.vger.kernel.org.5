Return-Path: <linux-kernel+bounces-149675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C668A9467
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF831F2264A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4179950;
	Thu, 18 Apr 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XneAXZUF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E97441A;
	Thu, 18 Apr 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426594; cv=none; b=HWWz83y6b0mtQywyB6naHlxfGZoT/rVTWMbhEtZco4r6fV+aGhTWNgTq9Sxpga9HRubfDCBi7OKCidxiT8qJ8imBBUJmrHcs0NUxKGBdZvQN+VwS7RqZRFkXeLIRoZiYs1gfAkz0xwY+VgT7oXDuTxH3JiW8/JQQaybbZlZjezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426594; c=relaxed/simple;
	bh=FRrlT/aY2FgpGFg9r1Iu9ANqmOPu7yBIf9SqSQmObGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jyWyNXKMdRnIke0R8sI0x7PysJCljxU/4AEd+HIioCwYml3NX2JSP1pmUr+vuj9ljUsHv962yCbXyXXrIwr49kq334AJ+v3TdMUQk7vaS+PeJrzXFxAqdx3wbQMLgf67fEmP79QHJPy9lxifPRL2XKqzT/eL43qzM9RjSNpwfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XneAXZUF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713426592; x=1744962592;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FRrlT/aY2FgpGFg9r1Iu9ANqmOPu7yBIf9SqSQmObGA=;
  b=XneAXZUFY5IfngSsKlOJFwBB1BDAVg3Cb2LS3GlFpHTZcXvIIegX8fDq
   jXqAbfjTRkrc1Em3qsy7A3EXo+rLAZWgLd+walboPgDm4ffts83xpetXw
   l2dR5wNZNwcVspiQIDcEEcrbSS4mQfEVWEYJNDNzCR67TNJPO71t5+xOQ
   pWfd5N80YhiuxrcUW2WSDBty3WT/WTCgmF4+ltiyJmX+2JsIfc43iqVZI
   vY2Hi1DyYixX/NxpHiGnHc3Yv6jTrEnPHSdVMYgqGcCrggvdxFk1/Y9kR
   803d8czrceyJuoKgPXvJTbPdgZaE8yCswWGkWf3LhGXalllXTaEbLvkcd
   g==;
X-CSE-ConnectionGUID: DF5lhuK2QDKj8XIcvI9wEw==
X-CSE-MsgGUID: YNN3beuRSCqu/F8ftu1gcQ==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="252373487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 00:49:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 00:49:44 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 00:49:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 18 Apr 2024 09:49:03 +0200
Subject: [PATCH net-next 4/5] net: sparx5: add the tc glue to support port
 mirroring
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240418-port-mirroring-v1-4-e05c35007c55@microchip.com>
References: <20240418-port-mirroring-v1-0-e05c35007c55@microchip.com>
In-Reply-To: <20240418-port-mirroring-v1-0-e05c35007c55@microchip.com>
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
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 2a33b347098f..cfd6fcd3d74e 100644
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
@@ -115,7 +147,9 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
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


