Return-Path: <linux-kernel+bounces-130453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F52897864
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5E28B8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C6154C03;
	Wed,  3 Apr 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b/byF7Lx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2F153BD6;
	Wed,  3 Apr 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169740; cv=none; b=sA3m4VWlwOkNjkB75CGRK8QG3MhNl7r03Kn4AFrFRN8o9wu+RgypPxNFVG491p0ob67Hx6gVy+6vvCDPEJ2vtpIvPaNLGpxs9xuuAazG1ENe/sqx7NGR8I3jfFx1DVCpx9tfl6AtYp6819qbvABU/IoGMweDq0nHaOA3ii4eBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169740; c=relaxed/simple;
	bh=0BQfTNJh7WCqTooxO5jQh9nq8Nvly6zUvYcfVjQ186M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QqOqa6nLke4LFrOVJs6BUmxpHvVzMBd5jSrUigD7HkoqOOJDusMpwZKRrTiZkOXKJ9eZiKgF0S7an/EylZyH9mUdaIa3ZJwQD8Df1pUB7aUSktq0ho/6kZUSdGnpmvsNFQL+FUO2oj9MNljpQKhHGhDzf8cyLzHGZ2/CNs4RW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b/byF7Lx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712169737; x=1743705737;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0BQfTNJh7WCqTooxO5jQh9nq8Nvly6zUvYcfVjQ186M=;
  b=b/byF7Lx2yJkEBXIeIhFt6D70ituv07OKtBmnnraxqRQbwaz2lO/X4lk
   8TwbFn/nSaN3FbbPlx8Cb0XKNV0+B8Y9+ovwvq8lEAtxguRws/nuhJZ9+
   jFlHHvWwbT9L3J4K39yO/uI7EDyR4JpRViETb+oT2eZ0AQCrIumOJnkF4
   TQC3bPRbD+45m6tShzZ4mCvpmdMIbYwrViJq8nBb+lOKpgsHS6JPiTIAW
   YEyvba6OkZtoEvyt23acjy+51gPyCQ4EpkHUYEJlnM6tSLcEi+zUD4eKb
   EtSGLzoJDl6co/pR+HNrIWoLiMPX/WZ6nZYO1y+T+Juke3wS8ROW9e2hO
   w==;
X-CSE-ConnectionGUID: S7G30frMRjS4zHdERZ8jng==
X-CSE-MsgGUID: Gp10ytTDSTaEhG2Ch+jTtQ==
X-IronPort-AV: E=Sophos;i="6.07,177,1708412400"; 
   d="scan'208";a="21259577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 11:42:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 11:42:12 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 11:42:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 3 Apr 2024 20:41:43 +0200
Subject: [PATCH net-next 2/3] net: sparx5: add support for tc flower mirred
 action.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240403-mirror-redirect-actions-v1-2-c8e7c8132c89@microchip.com>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
In-Reply-To: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

Add support for tc flower mirred action. Two VCAP actions are encoded in
the rule - one for the port mask, and one for the port mask mode. When
the rule is hit, the destination mask is OR'ed with the port mask.

Also add helper to set port forwarding mask.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 523e0c470894..a86ce1f8f3e5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1004,6 +1004,44 @@ static int sparx5_tc_action_vlan_push(struct vcap_admin *admin,
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
@@ -1150,6 +1188,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
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

-- 
2.34.1


