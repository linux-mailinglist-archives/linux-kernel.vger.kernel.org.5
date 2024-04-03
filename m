Return-Path: <linux-kernel+bounces-130456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E689786C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A5B1F28C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD9154BFB;
	Wed,  3 Apr 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pYr8Vq9v"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28892146D62;
	Wed,  3 Apr 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169770; cv=none; b=aP2ryVp792LUYKtHvHncZJFqj5k0gjvLmZkkw6w95sDZxgrmVdAGe6Cy3wCYcwPtjeGIgMs6yG2/pcJ741oRxllOl30jgKkuMn7t7tDON6YNxLwsdBiB+jXt/DLxhKwVSYDXqsbxIBZ+rs+4eQ1idCkPhtk25tqCmk04lMAyI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169770; c=relaxed/simple;
	bh=g9OGTjriFjC5okqqsdE43uxvtzt0NrohNgdOIFqLUPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Pt8vfiu512NAdhFd59c2pMfnmIzxRwCNwwrDeB1KpvVHn1bY7XronKDK5TI6QdTGI0I4/1yfMQSPrc8Z5mcFfbWokfd4TvPCnfUIMry4RQrvZ67eaNjF0ukX4eDUOaFUeoHQnS+RXyBJCDPsmKZY+wDHKA2nV3AwPssSNoXbJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pYr8Vq9v; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712169769; x=1743705769;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g9OGTjriFjC5okqqsdE43uxvtzt0NrohNgdOIFqLUPc=;
  b=pYr8Vq9ve23Kd4NzOdN3PxsKUWZ2eLfX70rdBTBYMuj5NBC26ZMSKHjQ
   yuCW2NAeyO1uJV+YpSQVF2u2cwbyyf5Z3B8Pda5yeVbIYunxf0OWoRFAM
   rCPqT5AZ4toxLoliGGygEdrSyc4IHKQEQD0wAe8EBY9k/7c0aa5LI3iJr
   7z4sKO4GpWVlC9cim9z2PBPg9lfhvz4VD0bItM4QWrJBHG4eM5gM6YdKi
   GAdqx7ViQnd27x8XgTDENoJG6ULf7Z2R0nWnIQ3lLwkckB7Qn6dGqkcVM
   0UuHGqsyeVOqtPLPk8pbG7aUptWT2xayBuaSvThTtU9LFLBh88QQ8+xvd
   g==;
X-CSE-ConnectionGUID: By3oU9PeTtGY31IsBtby0Q==
X-CSE-MsgGUID: roZiApLfSA2APbX12J9Lhw==
X-IronPort-AV: E=Sophos;i="6.07,177,1708412400"; 
   d="scan'208";a="21259638"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 11:42:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 11:42:15 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 11:42:13 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 3 Apr 2024 20:41:44 +0200
Subject: [PATCH net-next 3/3] net: sparx5: add support for tc flower
 redirect action
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240403-mirror-redirect-actions-v1-3-c8e7c8132c89@microchip.com>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
In-Reply-To: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

Add support for the flower redirect action. Two VCAP actions are encoded
in the rule - one for the port mask, and one for the port mask mode.
When the rule is hit, the port mask is used as the final destination
set, replacing all other port masks.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index a86ce1f8f3e5..0df8724251a0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1042,6 +1042,34 @@ static int sparx5_tc_action_mirred(struct vcap_admin *admin,
 	return 0;
 }
 
+static int sparx5_tc_action_redirect(struct vcap_admin *admin,
+				     struct vcap_rule *vrule,
+				     struct flow_cls_offload *fco,
+				     struct flow_action_entry *act)
+{
+	struct vcap_u72_action ports = {0};
+	int err;
+
+	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
+		NL_SET_ERR_MSG_MOD(fco->common.extack,
+				   "Redirect action not supported in this VCAP");
+		return -EOPNOTSUPP;
+	}
+
+	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
+				       SPX5_PMM_REPLACE_ALL);
+	if (err)
+		return err;
+
+	sparx5_tc_flower_set_port_mask(&ports, act->dev);
+
+	err = vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /* Remove rule keys that may prevent templates from matching a keyset */
 static void sparx5_tc_flower_simplify_rule(struct vcap_admin *admin,
 					   struct vcap_rule *vrule,
@@ -1193,6 +1221,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
 			if (err)
 				goto out;
 			break;
+		case FLOW_ACTION_REDIRECT:
+			err = sparx5_tc_action_redirect(admin, vrule, fco, act);
+			if (err)
+				goto out;
+			break;
 		case FLOW_ACTION_ACCEPT:
 			err = sparx5_tc_set_actionset(admin, vrule);
 			if (err)

-- 
2.34.1


