Return-Path: <linux-kernel+bounces-130452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB9897862
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CD128B8C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F555153BF3;
	Wed,  3 Apr 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YLnKeusc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022015359C;
	Wed,  3 Apr 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169737; cv=none; b=DUzcbyx1yOtDFaRnmTQ2scqgNFQysg2SCHlMgU0zHgOY/JhCXDWiwF/x7d7Hgr0DCJjDPv8CJGbsTZ1QHEphHv/IkaPAO7anwiBYePW2L58mrQL5zom6IYVyC+4ehsmpu+z6bVZOYaFQQJIsYOMGr/3N+adht0evpEP2lbqzatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169737; c=relaxed/simple;
	bh=otSGrqELwfG2u5gWiiACNPA1KqM19QjHPY37cn0Pw7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oC1mKRUdmqB7KI39VyE1dUokK9ao8L2MU9JvWrNIrsifVrXRCF0VlwolZ8lkgA+eHKdt84svxawETM8WZJqCPrBQNyEizWF2A1w8vZt63zL6HvUw2HPjTvO5dZQmX1I9Gr3wioWBNS+OTOhCxhUlOZa8tQkK216vG47Y2fi5DQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YLnKeusc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712169734; x=1743705734;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=otSGrqELwfG2u5gWiiACNPA1KqM19QjHPY37cn0Pw7M=;
  b=YLnKeusc6bhryot9ig0m0Uf2mTNB8GleLy6x7VtZJwXcCvTJV9gUYq8m
   CtVgH/E6h9h8uX3Nfx92IOV8CgAX16/qM7P0heedakn2JhmbCw/Nk8sPg
   CSK/HXb8fJz02ZHr9gJ2dBTRZO/tid+20HOW+HnrhB5F10y8C09F2LWtS
   vRqAHXaDeLE9wZGblp1mLJ9jzEqPrQgBtUBaOqKCPWKoAFxVP+5e4ygI9
   BR+V3r8dWEQ8qCzJK4usfdU1y+jdk/U6CzB4vd06T0NfmuQ9XFxZ7iOsX
   vCfit90nEr3l5B3palHz88VjI4nGp7apT3tsE1hC2hMdDpmwwS2tISsuK
   A==;
X-CSE-ConnectionGUID: S7G30frMRjS4zHdERZ8jng==
X-CSE-MsgGUID: zGSWXMK5TQOOroPrNouTCQ==
X-IronPort-AV: E=Sophos;i="6.07,177,1708412400"; 
   d="scan'208";a="21259575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 11:42:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 11:42:10 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 11:42:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 3 Apr 2024 20:41:42 +0200
Subject: [PATCH net-next 1/3] net: sparx5: support 72-bit VCAP actions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240403-mirror-redirect-actions-v1-1-c8e7c8132c89@microchip.com>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
In-Reply-To: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

In preparation for supporting tc flower mirred and redirect action,
extend the VCAP API to support 72-bit wide VCAP actions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c        | 12 ++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api_client.h |  2 ++
 2 files changed, 14 insertions(+)

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


