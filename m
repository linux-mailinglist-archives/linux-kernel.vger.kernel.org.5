Return-Path: <linux-kernel+bounces-132581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E08996D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BE1B246E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1513DDB1;
	Fri,  5 Apr 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KoEFXiK4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798113D290;
	Fri,  5 Apr 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303127; cv=none; b=RG9WyToNnYzQF/yyzHISGIMHYz1FNscOtFO6GM185gRsYnmQczIBXIQHTrxu3VaHhxUcp+Ic1JPGdgoXCx+xJTixcTXwPqV3BHJaJI5PptTlTUHEDVxwUaxebfV2ImxLkcFHNKZkYiPERdo3AgbI3TltHSZdmHiKjUWiUnc9zGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303127; c=relaxed/simple;
	bh=zxzwPUK588bPOtov+mR5roC3KbeuhPfT1VukrDFUP3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pQ7to1nMlYDfpjCCA4qarvxFSnMCqr7Ao86Mm4yExre5miB+CyxCXGa9MdRlJ7Q5U2QzUUrFkFT5QfL6JgpFMexv9cC17H2kpoqIiXEvo3GuQYgaqLO2GWhlMsrMXmELBmfrk0m7Jj2+vx0Ijj8wn0xc3jSxQpdh7NhZ9WebfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KoEFXiK4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712303125; x=1743839125;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zxzwPUK588bPOtov+mR5roC3KbeuhPfT1VukrDFUP3s=;
  b=KoEFXiK4uj/Q53yao3jPx9oiBqCEiC1nDHvqCLeYA8AI7Ohv059ohSz9
   0eJOS3XayJ+cx+NW2nsVjJmukyxSbKwwhV9+fCz4Z600mibP9lPy5HqkU
   rt91zaxIvcoUOAPjE/ERKs8yJkJKSXvm8fsKgKT/xnUNHySgIlvD2U6FD
   2AcZsTd0JbohY3fPDaKOQxMgqsFtlqpvNLZwzl76RtE//dmdLqxTO1ZLB
   xjfq11+IXZyUXkaMJcFkAFap8XjTk9/Hr/IVNnTDY4T0/FcF1kYpXcKn4
   tbcoqo17PGlLjSw9oqMstAg0qdjA0NuQtLqZJinPgNKq6dhtdHZZsLYRf
   g==;
X-CSE-ConnectionGUID: LnJ8QAI7QrCTf6/TR/LIZQ==
X-CSE-MsgGUID: B7RBzzQ/T+KnUHQ14QtQxQ==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="19563250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 00:45:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 00:45:05 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 00:45:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 5 Apr 2024 09:44:49 +0200
Subject: [PATCH net-next v2 1/2] net: sparx5: add support for tc flower
 mirred action.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-mirror-redirect-actions-v2-1-875d4c1927c8@microchip.com>
References: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
In-Reply-To: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Ratheesh Kannoth <rkannoth@marvell.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

Add support for tc flower mirred action. Two VCAP actions are encoded in
the rule - one for the port mask, and one for the port mask mode. When
the rule is hit, the destination mask is OR'ed with the port mask.

Also add new VCAP function for supporting 72-bit wide actions, and a tc
helper for setting the port forwarding mask.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 39 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 12 +++++++
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 523e0c470894..fb2e3004183a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1004,6 +1004,40 @@ static int sparx5_tc_action_vlan_push(struct vcap_admin *admin,
 	return err;
 }
 
+static void sparx5_tc_flower_set_port_mask(struct vcap_u72_action *ports,
+					   struct net_device *ndev)
+{
+	struct sparx5_port *port = netdev_priv(ndev);
+	int byidx = port->portno / BITS_PER_BYTE;
+	int biidx = port->portno % BITS_PER_BYTE;
+
+	ports->value[byidx] |= BIT(biidx);
+}
+
+static int sparx5_tc_action_mirred(struct vcap_admin *admin,
+				   struct vcap_rule *vrule,
+				   struct flow_cls_offload *fco,
+				   struct flow_action_entry *act)
+{
+	struct vcap_u72_action ports = {0};
+	int err;
+
+	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
+		NL_SET_ERR_MSG_MOD(fco->common.extack,
+				   "Mirror action not supported in this VCAP");
+		return -EOPNOTSUPP;
+	}
+
+	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
+				       SPX5_PMM_OR_DSTMASK);
+	if (err)
+		return err;
+
+	sparx5_tc_flower_set_port_mask(&ports, act->dev);
+
+	return vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
+}
+
 /* Remove rule keys that may prevent templates from matching a keyset */
 static void sparx5_tc_flower_simplify_rule(struct vcap_admin *admin,
 					   struct vcap_rule *vrule,
@@ -1150,6 +1184,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
 			if (err)
 				goto out;
 			break;
+		case FLOW_ACTION_MIRRED:
+			err = sparx5_tc_action_mirred(admin, vrule, fco, act);
+			if (err)
+				goto out;
+			break;
 		case FLOW_ACTION_ACCEPT:
 			err = sparx5_tc_set_actionset(admin, vrule);
 			if (err)
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ef980e4e5bc2..80ae5e1708a6 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2907,6 +2907,18 @@ int vcap_rule_add_action_u32(struct vcap_rule *rule,
 }
 EXPORT_SYMBOL_GPL(vcap_rule_add_action_u32);
 
+/* Add a 72 bit action field with value to the rule */
+int vcap_rule_add_action_u72(struct vcap_rule *rule,
+			     enum vcap_action_field action,
+			     struct vcap_u72_action *fieldval)
+{
+	struct vcap_client_actionfield_data data;
+
+	memcpy(&data.u72, fieldval, sizeof(data.u72));
+	return vcap_rule_add_action(rule, action, VCAP_FIELD_U72, &data);
+}
+EXPORT_SYMBOL_GPL(vcap_rule_add_action_u72);
+
 static int vcap_read_counter(struct vcap_rule_internal *ri,
 			     struct vcap_counter *ctr)
 {
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
index 88641508f885..56874f2adbba 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
@@ -200,6 +200,8 @@ int vcap_rule_add_action_bit(struct vcap_rule *rule,
 			     enum vcap_action_field action, enum vcap_bit val);
 int vcap_rule_add_action_u32(struct vcap_rule *rule,
 			     enum vcap_action_field action, u32 value);
+int vcap_rule_add_action_u72(struct vcap_rule *rule, enum vcap_action_field action,
+			     struct vcap_u72_action *fieldval);
 
 /* Get number of rules in a vcap instance lookup chain id range */
 int vcap_admin_rule_count(struct vcap_admin *admin, int cid);

-- 
2.34.1


