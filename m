Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A71800013
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377497AbjLAAPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377447AbjLAAPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC41722;
        Thu, 30 Nov 2023 16:14:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so14657935e9.3;
        Thu, 30 Nov 2023 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389698; x=1701994498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=BY6FVuHhiIpA1VGHZ1mmqCF8dsAlNTB2kwvzy0oWO6K8Z/dcl+iRSlkLVPkkssEuns
         L055R9M91icT9YeBXqgdk/EOI+e1gHvAxVa08YshdeoexvF4XAes4JlNb9OkX7EtIi3+
         FusEWBAbRgwtI3zn7E4cJd5p9hnC9QS7evrhpSmCHs9Xxm6M5tBj/tAfn57Md6qUmpQD
         0gwFy0nkHaabq+/gJnkT49R0d5mXG3fBHMSKATgBshJ09gk9fD8dwej5Z0giKgdwoxRV
         gH6i979byCbAsLmb8ByQKAlePmwPKZnW2a3SJszcXsRBQQFPdNbZXyLw3qZzL0wuCt34
         T3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389698; x=1701994498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=vAqVmHffckItnsIfK58RfNh70AkJVKi+N4fFHAEyrfors9Mm5nAsVt7rsIhgDyyySj
         0x1M/NMQuNOtkkK2mFv9WN4tv9WEyLR2H6UU56DLOJe6T0So5Z5JKqpmDWxfT3iWF/vi
         YjYVHnhVpmWtfmntKAMaLPRekGFO4vwERc5Szz/4Rn5HpCcBt78FtWddLRq5mfoDJ0ID
         ihTdNAWBtKcWVB4F4SZY69Az6zX+9tIlAzZzsSqNapjWyAUzaJ6RC3cNEY5xJwZLsMr9
         EBxaMhRz+Sc4l0hHR998XO7X2qdG+GXOO68AxLeDJp8I30Sw5xPO0Yc/ZlzU9IeDvywB
         QTSw==
X-Gm-Message-State: AOJu0YxvVHesz6X5Bd2RAmEXGadviqws+MK+WSvzKZI3GpEonXoIffNw
        leQ82hYkh+oS/x7J6UJUl9TDOuxnoGw=
X-Google-Smtp-Source: AGHT+IEr5excZYZRSQhXWBGBEpA7e9pSy1YoiqOhPSfnQxKWlKyXPv3rxaEXObR/3dZaj4lMpc+CcA==
X-Received: by 2002:a7b:c3d9:0:b0:40b:5e59:da9a with SMTP id t25-20020a7bc3d9000000b0040b5e59da9amr108816wmj.173.1701389697891;
        Thu, 30 Nov 2023 16:14:57 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:57 -0800 (PST)
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
Subject: [net-next PATCH v2 09/12] net: phy: at803x: move specific at8031 config_intr to dedicated function
Date:   Fri,  1 Dec 2023 01:14:19 +0100
Message-Id: <20231201001423.20989-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
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

Move specific at8031 config_intr bits to dedicated function to make
at803x_config_initr more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to setup interrupts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 2de7a59c0faa..1897030667d9 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -990,7 +990,6 @@ static int at803x_ack_interrupt(struct phy_device *phydev)
 
 static int at803x_config_intr(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int err;
 	int value;
 
@@ -1007,10 +1006,6 @@ static int at803x_config_intr(struct phy_device *phydev)
 		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
 		value |= AT803X_INTR_ENABLE_LINK_FAIL;
 		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-		if (priv->is_fiber) {
-			value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
-			value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
-		}
 
 		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
 	} else {
@@ -1619,6 +1614,29 @@ static int at8031_set_wol(struct phy_device *phydev,
 	return ret;
 }
 
+static int at8031_config_intr(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int err, value = 0;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED &&
+	    priv->is_fiber) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
+
+		err = phy_set_bits(phydev, AT803X_INTR_ENABLE, value);
+		if (err)
+			return err;
+	}
+
+	return at803x_config_intr(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2139,7 +2157,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= at803x_config_intr,
+	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-- 
2.40.1

