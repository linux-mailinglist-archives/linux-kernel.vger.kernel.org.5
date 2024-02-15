Return-Path: <linux-kernel+bounces-67263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E028568D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D501F2A202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACF136679;
	Thu, 15 Feb 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPlnZsx7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5A0133994;
	Thu, 15 Feb 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013009; cv=none; b=T1JMT7VF6FjxYTqWlRPDh80FO/tqLzIy6dHNcLD67/YMXf+zFaSHbvNqiP41ihX/N56be72dvjk/13b97yQfpTtEY+i4mxnyA7vrOrgXdS6zgzfviUKpVZZu3BMfhrjFjqWLT7j4lCWEdZxIQCjSsvTWcnNKesJ2q4FIaiPxqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013009; c=relaxed/simple;
	bh=VpiQZLRng134HOd+u7eImqm51VyTR3E0Jy/qPzO0dfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4Pd2iioLtjvNBEVsJnT0W+RdzRyYLya0MA4Hne4tPjLbS7FpX8e8T4hnu3keoLS6Ru53xZvW7m2RX7vwekoGeCJUHtKnhAQtv0/962kZZr/oMtgTZr65eI8eJnLvUgquIIgt+If/QXei0Oe9j3fvwzP+3IhzQE4d3WX8zvBxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPlnZsx7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E829320007;
	Thu, 15 Feb 2024 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJPO+/nnaxU0Id9ikRVBjeMR47kJHD/icAL+yePRrNQ=;
	b=jPlnZsx7epCGdRUfvHEg07b1XREsvyXLD+bppUiO2auUdHwHlif5V00aTBZ+5p3b1GQvsR
	3zIfJDUMIYnofNE4R160c9PUjPTXszxi0GtTw2yN9N88PreEqkc+VKXY6RaZS3G3Zk566o
	alT9oeh4HmwB/Fl8zK4MkBqWArRaXOOT8oawW94/dqYhhKGAW0bpLRvt1IgIRoR+3J7Y/+
	Zc1fbO9L+7tDPmMUuMAFi70LezB5As+pBc+1HknppYe83l0q7BlTLEKDalH2MsqVV1CHx4
	wwuXRtWyIH2P3cu6eUpPLujcqtHqjvH9HzvbSBmy5Jx8W/PcA8lo39v7Q9I0NQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:44 +0100
Subject: [PATCH net-next v4 03/17] net: pse-pd: Rectify and adapt the
 naming of admin_cotrol member of struct pse_control_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-3-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

In commit 18ff0bcda6d1 ("ethtool: add interface to interact with Ethernet
Power Equipment"), the 'pse_control_config' structure was introduced,
housing a single member labeled 'admin_cotrol' responsible for maintaining
the operational state of the PoDL PSE functions.

A noticeable typographical error exists in the naming of this field
('cotrol' should be corrected to 'control'), which this commit aims to
rectify.

Furthermore, with upcoming extensions of this structure to encompass PoE
functionalities, the field is being renamed to 'podl_admin_state' to
distinctly indicate that this state is tailored specifically for PoDL."

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_regulator.c | 8 ++++----
 include/linux/pse-pd/pse.h         | 4 ++--
 net/ethtool/pse-pd.c               | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pse-pd/pse_regulator.c b/drivers/net/pse-pd/pse_regulator.c
index e2bf8306ca90..1dedf4de296e 100644
--- a/drivers/net/pse-pd/pse_regulator.c
+++ b/drivers/net/pse-pd/pse_regulator.c
@@ -31,10 +31,10 @@ pse_reg_ethtool_set_config(struct pse_controller_dev *pcdev, unsigned long id,
 	struct pse_reg_priv *priv = to_pse_reg(pcdev);
 	int ret;
 
-	if (priv->admin_state == config->admin_cotrol)
+	if (priv->admin_state == config->podl_admin_control)
 		return 0;
 
-	switch (config->admin_cotrol) {
+	switch (config->podl_admin_control) {
 	case ETHTOOL_PODL_PSE_ADMIN_STATE_ENABLED:
 		ret = regulator_enable(priv->ps);
 		break;
@@ -43,14 +43,14 @@ pse_reg_ethtool_set_config(struct pse_controller_dev *pcdev, unsigned long id,
 		break;
 	default:
 		dev_err(pcdev->dev, "Unknown admin state %i\n",
-			config->admin_cotrol);
+			config->podl_admin_control);
 		ret = -ENOTSUPP;
 	}
 
 	if (ret)
 		return ret;
 
-	priv->admin_state = config->admin_cotrol;
+	priv->admin_state = config->podl_admin_control;
 
 	return 0;
 }
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index fb724c65c77b..199cf4ae3cf2 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -15,11 +15,11 @@ struct pse_controller_dev;
 /**
  * struct pse_control_config - PSE control/channel configuration.
  *
- * @admin_cotrol: set PoDL PSE admin control as described in
+ * @podl_admin_control: set PoDL PSE admin control as described in
  *	IEEE 802.3-2018 30.15.1.2.1 acPoDLPSEAdminControl
  */
 struct pse_control_config {
-	enum ethtool_podl_pse_admin_state admin_cotrol;
+	enum ethtool_podl_pse_admin_state podl_admin_control;
 };
 
 /**
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index cc478af77111..aef57a058f0d 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -130,7 +130,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct phy_device *phydev;
 
 	/* this values are already validated by the ethnl_pse_set_policy */
-	config.admin_cotrol = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
+	config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
 
 	phydev = dev->phydev;
 	if (!phydev) {

-- 
2.25.1


