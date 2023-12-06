Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADC807CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441884AbjLGAAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441902AbjLGAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F4D72;
        Wed,  6 Dec 2023 16:00:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2718a768so3803185e9.0;
        Wed, 06 Dec 2023 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907223; x=1702512023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VxI3+LUEvRyW0jRbv9Ny2+Yv44I4YEi8/tstLSQ5Is=;
        b=H3djEn6wj8VvIEQXAkV6/zID4wz3v9QW0YhJY2WMO+uwKiNxbglDpA2ZTQME+W09G2
         EZyXHukeVD+0N+FsmqkHbGnCeA9LKizVyDMEly+GweYfs18CV1ucDE+GaQsYjT+GKBKH
         eRtM8POZJsyM0wk3IWm8oZ+fAF9ds7xFkDu5FCW6rLh6Mn6u4O3sNbGf3mGOoWegjxaA
         ghqop/41iqYOy3LSLdjnSh3yawT5LazBrDG6GadmMwgsk1ku3Bvr98EXSd/RD3vsKxex
         1Rx364V/ij0/usqtRLRjz3ev17CRUik0yxKQsUhUcL4l+YeZA0fkiKdsw7wB0/TCwepn
         oLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907223; x=1702512023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VxI3+LUEvRyW0jRbv9Ny2+Yv44I4YEi8/tstLSQ5Is=;
        b=qCQpzYTAKn5SI7wJjIqN94JF7rWalSU2eQor7dIjq6p5XOjzFM4yksNBjG6XRSD1wT
         AN1FRUzj4LHIGqAQooSPyttfe8d0h2CixixktWZyZQx6eMF+9fd9r6QABCt7KXox+myl
         DMIps0Yr7eP3EGscgXrUwqD2dWG0BxhVIZspgfHvRdmUuHtm/ntHeh8R/XuVc0xDvaxW
         PPHazAEM1vDUHJ0dhF0qIi1LspNSYnV6Jf28Mf/aIlZA77t7cTg8yIv/DuWtOuNCC/Yh
         B2kkxRUoW24VAB0/av6yKW6/Zk6IDoKbnMDGMQvKNqgcbhJ47llpqa1KxXX70viVbcF9
         Bnsw==
X-Gm-Message-State: AOJu0YwdBufJ3O4MCRiWQn/Y07Djl/OV12PMGFe1BgwiPVIVDWyIo2D3
        UXA1A8FBBleVY8XRFNUUP7Q=
X-Google-Smtp-Source: AGHT+IFy/1geWj6cEV4QJsdc31il2EEGsBN/HzrXDmfVEXFYy3eDuD7ziHG6CO5KP8PxEqknlE1ADg==
X-Received: by 2002:a05:600c:35d1:b0:40b:5e22:956 with SMTP id r17-20020a05600c35d100b0040b5e220956mr1185988wmq.69.1701907222670;
        Wed, 06 Dec 2023 16:00:22 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:22 -0800 (PST)
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
Subject: [net-next PATCH v3 06/13] net: phy: at803x: move specific at8031 probe mode check to dedicated probe
Date:   Thu,  7 Dec 2023 00:57:21 +0100
Message-Id: <20231206235728.6985-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move specific at8031 probe mode check to dedicated probe to make
at803x_probe more generic and keep code tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index e507bf2c9bdd..ed3be7ed5463 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -844,26 +844,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
-		int mode_cfg;
-
-		if (ccr < 0)
-			return ccr;
-		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
-
-		switch (mode_cfg) {
-		case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
-		case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
-			priv->is_1000basex = true;
-			fallthrough;
-		case AT803X_MODE_CFG_FX100_RGMII_50OHM:
-		case AT803X_MODE_CFG_FX100_RGMII_75OHM:
-			priv->is_fiber = true;
-			break;
-		}
-	}
-
 	return 0;
 }
 
@@ -1584,6 +1564,9 @@ static int at8031_parse_dt(struct phy_device *phydev)
 
 static int at8031_probe(struct phy_device *phydev)
 {
+	struct at803x_priv *priv = phydev->priv;
+	int mode_cfg;
+	int ccr;
 	int ret;
 
 	ret = at803x_probe(phydev);
@@ -1597,6 +1580,22 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
+	if (ccr < 0)
+		return ccr;
+	mode_cfg = ccr & AT803X_MODE_CFG_MASK;
+
+	switch (mode_cfg) {
+	case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
+	case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
+		priv->is_1000basex = true;
+		fallthrough;
+	case AT803X_MODE_CFG_FX100_RGMII_50OHM:
+	case AT803X_MODE_CFG_FX100_RGMII_75OHM:
+		priv->is_fiber = true;
+		break;
+	}
+
 	/* Disable WoL in 1588 register which is enabled
 	 * by default
 	 */
-- 
2.40.1

