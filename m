Return-Path: <linux-kernel+bounces-119123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8571B88C47E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1763F1F3521D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB6128397;
	Tue, 26 Mar 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W/dChuZD"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B54763E5;
	Tue, 26 Mar 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461901; cv=none; b=QQzC72cNjlKnjQqwYGyJgNNkYIS4tymsKHL5Wl0J6UdRCqCupoCHK2I1m6tEMLksJGX0FMRjNn5puekb7TfuTZxEdXk9DxXLFZTjlxFDZ09ZXsK9ZDWpeXC2d+uPHi0y0NUOEUREUqbAcCydJsbg6oCf6MqGrSpBPGGE9jMjn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461901; c=relaxed/simple;
	bh=EP0HfJVQX3dQ7P7tMjgbkOHtH9UoXRRRfiwMBG1+6Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgMWzcSrdgPImkddKamiPeyc7bvBp5Fqa3GBcfDJZieghrUMhpNCFmJg28iVYzHJy2FZ4hYcdSXI227g9X4CMv577oQdNoAlkhprcuuZmW3/W/gcj36F+7KPSw+L8OjpbZkYr0zp/6tDFWzrErzBxWp3HicHp8JNMW+FywOmnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W/dChuZD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AF9A1C000B;
	Tue, 26 Mar 2024 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7k8QkX4fdlE92WKkN+6NiV+6ahpylg/d9n7UHOTUC8=;
	b=W/dChuZDJVyyQEEc7IHxvUcQ3rgQnJFwop3lwjRsyxDv7bnCehdus9ZX/cc20AeLZxzV8T
	wlcHybVHENWam3FAvjOt7YM8KordYzGlHEA8dZUuGZVAdDvs5Cizi/if5sDHQmWt1lf9f8
	zKgQoG+0jF7jeYm/SLsA3VIwMt4g9olsbeGMUeEq7FV2kYWJe742AzQ2qjpU6KTpKSAxpt
	7SwHQr9Oecs54VpeqTOZjOwMgYP3CUvS9G/OdPubSM27QGylIeaEVmtpOf6pnyf+UK98/m
	KoukqIkkFKZ7E5e4pevYLTD6rASr1zsQfwnFv4o2smyuqu+dFtOtGhNvk9AHmw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:40 +0100
Subject: [PATCH net-next v6 03/17] net: pse-pd: Rectify and adapt the
 naming of admin_cotrol member of struct pse_control_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-3-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
In-Reply-To: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
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
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

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


