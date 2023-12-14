Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97981240F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442907AbjLNApn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442898AbjLNApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:45:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5514DD;
        Wed, 13 Dec 2023 16:45:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-336471815c4so89450f8f.1;
        Wed, 13 Dec 2023 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514741; x=1703119541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOR5ojDqgOZh8TgFAYUGsLmhZvWja5pYQDWlBF86PYQ=;
        b=m0wABbGfB7NF7pB2ZGMnu5G7+8FPshKQJwZEWEFhfjJL85q7RBD3EeklsvqAQFGHTP
         J7vA/y9hgObZE1Pr151r5BvwX0aVfU2SweQNGHX14us7SOsRB4GIUjU/do5Rx3K1jQs4
         kLoeHa1V2dpzFQpuVfuKurtk7TfXXFJmImkro9QLO2KknsL8fJ+JjwrJ+IgDm5WBFR5F
         NxPZLs+n3tEezvsKflSWjYqDFrCpxF1S1Qwq424vivwfm0I+D+Ad0+3jEJc+QF6GSyhS
         hkkqZVbf2G3CH5jy0huNHHKBzcQ537CY4Dm5oJMZJWUEjqI4W/SQEbENiRdA+qpoq8Eg
         g3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514741; x=1703119541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOR5ojDqgOZh8TgFAYUGsLmhZvWja5pYQDWlBF86PYQ=;
        b=TDh5qDS7MeoaVDGn5SJTQJJvyiFbGPLbepsI2HuHiK3CLri6PQ0HY2B3jloysGWwUN
         bb+q/FwN3ExsHkuxhZ0rBK66cAy/3biau16XrbKWZl+HQml/+c9jp92mFnVBWNzOFVmr
         pVbU7H/tmSM7svJaV6MvcyEdanTmVuzJCjnAFaL4YSiIr3eAclj+q5pr3cLCoeZ7ZuVB
         TL3CaXgiqwSJ7TThDadUtyriADgSXpxUhy+PAXAf3daeiPqoo/gvYVi3RYeWUAE0TTkC
         Z3prHXiZozTt/IGri54/J4Js7crGAIQw5Mgh+tMRTQATqBaeAzH0STv0FTPxheNJ4tnF
         wTYg==
X-Gm-Message-State: AOJu0Yxc37fDNLqEE9xibndVpQ0CSIfJXE/GwGRhT0jnTzp1AoxGwAS2
        ZfQrf92BtD/mNFcQRNxY6ZU=
X-Google-Smtp-Source: AGHT+IFCXWjWwJ3vBywzuLDdrdaXytVJz4dNq5U4zGfR6T5loW3mh13IJAKkcoWZ2dCZ7WXXUx8YZA==
X-Received: by 2002:a5d:4342:0:b0:333:591c:6507 with SMTP id u2-20020a5d4342000000b00333591c6507mr2365594wrr.248.1702514741066;
        Wed, 13 Dec 2023 16:45:41 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g15-20020adfe40f000000b003364470f30bsm959013wrm.52.2023.12.13.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:45:40 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 2/2] net: phy: at803x: make read specific status function more generic
Date:   Thu, 14 Dec 2023 01:44:32 +0100
Message-Id: <20231214004432.16702-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214004432.16702-1-ansuelsmth@gmail.com>
References: <20231214004432.16702-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework read specific status function to be more generic. The function
apply different speed mask based on the PHY ID. Make it more generic by
adding an additional arg to pass the specific speed (ss) mask and use
the provided mask to parse the speed value.

This is needed to permit an easier deatch of qca808x code from the
at803x driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 03f945cc7626..a7d28848ee93 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -301,6 +301,11 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
 };
 
+struct at803x_ss_mask {
+	u16 speed_mask;
+	u8 speed_shift;
+};
+
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -921,7 +926,8 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int at803x_read_specific_status(struct phy_device *phydev)
+static int at803x_read_specific_status(struct phy_device *phydev,
+				       struct at803x_ss_mask ss_mask)
 {
 	int ss;
 
@@ -940,11 +946,8 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 		if (sfc < 0)
 			return sfc;
 
-		/* qca8081 takes the different bits for speed value from at803x */
-		if (phydev->drv->phy_id == QCA8081_PHY_ID)
-			speed = FIELD_GET(QCA808X_SS_SPEED_MASK, ss);
-		else
-			speed = FIELD_GET(AT803X_SS_SPEED_MASK, ss);
+		speed = ss & ss_mask.speed_mask;
+		speed >>= ss_mask.speed_shift;
 
 		switch (speed) {
 		case AT803X_SS_SPEED_10:
@@ -989,6 +992,7 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 static int at803x_read_status(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
+	struct at803x_ss_mask ss_mask = { 0 };
 	int err, old_link = phydev->link;
 
 	if (priv->is_1000basex)
@@ -1012,7 +1016,9 @@ static int at803x_read_status(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	err = at803x_read_specific_status(phydev);
+	ss_mask.speed_mask = AT803X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(AT803X_SS_SPEED_MASK);
+	err = at803x_read_specific_status(phydev, ss_mask);
 	if (err < 0)
 		return err;
 
@@ -1869,6 +1875,7 @@ static int qca808x_config_init(struct phy_device *phydev)
 
 static int qca808x_read_status(struct phy_device *phydev)
 {
+	struct at803x_ss_mask ss_mask = { 0 };
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
@@ -1882,7 +1889,10 @@ static int qca808x_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = at803x_read_specific_status(phydev);
+	/* qca8081 takes the different bits for speed value from at803x */
+	ss_mask.speed_mask = QCA808X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(QCA808X_SS_SPEED_MASK);
+	ret = at803x_read_specific_status(phydev, ss_mask);
 	if (ret < 0)
 		return ret;
 
-- 
2.40.1

