Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312BF807CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442925AbjLGAAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441889AbjLGAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E1D6F;
        Wed,  6 Dec 2023 16:00:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so3785545e9.2;
        Wed, 06 Dec 2023 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907219; x=1702512019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrcJkPIDuZzmYGZsrVgKVn9yf3oQKZHA4PrUxB3CbJA=;
        b=ZUq2wWfavQeOa3p2ucQUTBLy4NGT+EIeT1gH4obYjgJrH61pbxefgbfgiqclyG1OEy
         L0H2R9CobnQD6JsqnMhUCdzoEHloBg81Il+Tmb5vm3irNlEcBaGFdC87LwgysYcIBA29
         WJ/rFPbdNZajEGaDKowjdP0uGul2kwK4hdxbwc8l7x2Y8Vl+NvK42B1D1rRcLgR1svNP
         7YGaWw46YXFRNPl3bnnNuN5awzcjufT5HNg2Al1z/G/uCFdXAxE4d6ypFJT3LmN/LbiX
         Wj+bHhBuaONrRvp8OtEiULDALclmU90bIGj0hWHYDgz8POqOWIlxEh19EuOwTob3lDTc
         /h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907219; x=1702512019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrcJkPIDuZzmYGZsrVgKVn9yf3oQKZHA4PrUxB3CbJA=;
        b=rKGBBkEl0DCS3J/EFnjFnnzysrkux+FuNruwpINj5p+nR2cYnAfuPWY41iNiYamisN
         S3hVfp9W4qMBPVomlIkALXG/zCckD+QOi9pS3cDFmMJMBlPVnWMn9XCdh9D9e4lcu2Cr
         AOlAuUFJfLrbx4MMpMhFs0b7UwGSOnFQ94Uv94ZuvHDbYEqsGXVQgR3HZnUHB31J8SWP
         0IURyzjljznIMN4JbioC8cw/3cO4R1CV1DLGBldBBBtmAHfjL0SXTD3CkW1DMonQipjb
         yZRi1U5iRm74XRMq+sSMkkzlNYJUZsw62UhABPmai6rUrMieCJsgOpSBMdoanlqfyR38
         Vi2g==
X-Gm-Message-State: AOJu0YzAcfYXeZgjFonaUMMBjmEFdR6QQxBIG6+HMBHNBvWMu0Xfn94v
        8Tk0EbW+cAfeq1wT5RAYW/s=
X-Google-Smtp-Source: AGHT+IEUIHuPLr5fFZ/86Yf7NAulTLD3gkTHTp73vEl8W4KU9sma9QQKiJGIs3kkn7cWuQj+ele1QQ==
X-Received: by 2002:a7b:cb95:0:b0:40c:1855:1c27 with SMTP id m21-20020a7bcb95000000b0040c18551c27mr999316wmi.103.1701907218720;
        Wed, 06 Dec 2023 16:00:18 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:18 -0800 (PST)
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
Subject: [net-next PATCH v3 03/13] net: phy: at803x: raname hw_stats functions to qca83xx specific name
Date:   Thu,  7 Dec 2023 00:57:18 +0100
Message-Id: <20231206235728.6985-4-ansuelsmth@gmail.com>
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

The function and the struct related to hw_stats were specific to qca83xx
PHY but were called following the convention in the driver of calling
everything with at803x prefix.

To better organize the code, rename these function a more specific name
to better describe that they are specific to 83xx PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 85302d96d133..b1ea52ba3f07 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -295,7 +295,7 @@ struct at803x_hw_stat {
 	enum stat_access_type access_type;
 };
 
-static struct at803x_hw_stat at803x_hw_stats[] = {
+static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
 	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
@@ -311,7 +311,7 @@ struct at803x_priv {
 	bool is_1000basex;
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
-	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
+	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
 };
 
 struct at803x_context {
@@ -529,24 +529,24 @@ static void at803x_get_wol(struct phy_device *phydev,
 		wol->wolopts |= WAKE_MAGIC;
 }
 
-static int at803x_get_sset_count(struct phy_device *phydev)
+static int qca83xx_get_sset_count(struct phy_device *phydev)
 {
-	return ARRAY_SIZE(at803x_hw_stats);
+	return ARRAY_SIZE(qca83xx_hw_stats);
 }
 
-static void at803x_get_strings(struct phy_device *phydev, u8 *data)
+static void qca83xx_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(at803x_hw_stats); i++) {
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++) {
 		strscpy(data + i * ETH_GSTRING_LEN,
-			at803x_hw_stats[i].string, ETH_GSTRING_LEN);
+			qca83xx_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-static u64 at803x_get_stat(struct phy_device *phydev, int i)
+static u64 qca83xx_get_stat(struct phy_device *phydev, int i)
 {
-	struct at803x_hw_stat stat = at803x_hw_stats[i];
+	struct at803x_hw_stat stat = qca83xx_hw_stats[i];
 	struct at803x_priv *priv = phydev->priv;
 	int val;
 	u64 ret;
@@ -567,13 +567,13 @@ static u64 at803x_get_stat(struct phy_device *phydev, int i)
 	return ret;
 }
 
-static void at803x_get_stats(struct phy_device *phydev,
-			     struct ethtool_stats *stats, u64 *data)
+static void qca83xx_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(at803x_hw_stats); i++)
-		data[i] = at803x_get_stat(phydev, i);
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++)
+		data[i] = qca83xx_get_stat(phydev, i);
 }
 
 static int at803x_suspend(struct phy_device *phydev)
@@ -2177,9 +2177,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
@@ -2193,9 +2193,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
@@ -2209,9 +2209,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
-- 
2.40.1

