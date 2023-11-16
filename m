Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196D17EE215
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbjKPOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbjKPOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:01 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DA126;
        Thu, 16 Nov 2023 06:01:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F20820004;
        Thu, 16 Nov 2023 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700143316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWD9YrNTyyRNxL/jvzCdcI4G86YYPC0nobZQkHFIfzM=;
        b=YHVZmMobVurUKpgivgCtynY3fdmpB4WSsy1ZPbV1dLDm4vuNoeoMyZLwKzUuxPWLKviXdI
        LqWiptoBqhYHSLfi0UQqpOJnfPRlMajUnWmDnsVvus2AUXAjVF16aLgA69EtFpbxeKQtHJ
        qrhpU74Peshn1wizHHVe0mKnq3BtjYUgTE4xtq4xQxKkMXT+CiDW3QhN4MU30od167Iy3n
        3FhCoivbp0q0IXxR2JtPv8VKaySK7IoQBk8qDzycV+LUVM5cazWYseI+Bg8oDN1NsWvA0b
        ezkHGQFOxXEm8sDZzEcotThWz0BdvOexW3ze8l7cplNzk22BhhE+Xg1mZUKINA==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Thu, 16 Nov 2023 15:01:33 +0100
Subject: [PATCH net-next 1/9] net: pse-pd: Rectify and adapt the naming of
 admin_cotrol member of struct pse_control_config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-1-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

