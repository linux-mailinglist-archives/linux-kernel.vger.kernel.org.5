Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08DA7645E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjG0Fkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjG0FkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:40:17 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B963C0D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:42 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b8b4749013so4392355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436203; x=1691041003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrKKqV0HQO2EhBMgbawQJpGyCpTF7In/U2sRYiMWbK8=;
        b=D5aKsLXGy2j6jm8tkzlTTceO4RSJRpKu2I3aRV4a0QzXpd5bjWkf+kAqE3F3BaNRfX
         DxaJ8Pde3fczdc/xBBGN/rAm0qcu8nBsr5/DMRo2EY6KhqcJL6B8It06mbh1wmECKQi+
         lXciwovoIn1XmRc1i3qlC0eKwscXTiOGxSvgnOBGDjs5uCo8FJuiENt0wdOflwftWEM6
         Z4bsbLB42Al2coRZvmXCMI4Of6jh6UC9ad+64wVD6PdAzwwvKuhWmE64zJU8vA6FZKfe
         eYFe0JJzcc+6TnQCAASwcDr20VpiO+it/Nl6pKOtUzOyZiIhmtbWNVsEaL65+KXKLIgN
         69Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436203; x=1691041003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrKKqV0HQO2EhBMgbawQJpGyCpTF7In/U2sRYiMWbK8=;
        b=KTMRpaIVi6eHH+KBSexgLvMUqp7igvxMtHIN/lQyE4SPTIwqny4XkyWr0uk3M/rQnH
         mQ4wULgq31dTh61FZBDS5JI2/rb7rWi+r+iuqcQfKXFEyZlovJIvB+PSXk1+oIo8G8CA
         MYrCCOmr9zyc8ZLAEvD/HYrG67lDIZeSJBEV4jUK+QTSYzsdXzix/xj0S/BC+ZZ7q2sb
         ZL5ljPCyt5xtVzze+n1ujBF7s1DmiihnV+NIpc+/xwvqXLIHfoYPDStSr+VZdxJSBo2b
         nnHpBjTy+K170C1gdwo2UfmghLICgsVPXef9R4j4wkbzAwwNmgu0m6XH77CJsPgT8pWH
         H4Tw==
X-Gm-Message-State: ABy/qLac6t4LvbK1aApQpLsWlXKo0IW6XWj9R64V0yRR8YpckCeX9WIh
        89ugw1LutUqYjK40o+GQtaE7Nw==
X-Google-Smtp-Source: APBJJlE+dM7AhEcN3LsCBRnRDe2BI9iVnvhfO+ozfURw/g7mC/rtS5q2NMPSSbrQGFnSw/NceZ2jnQ==
X-Received: by 2002:a17:902:b413:b0:1b8:2c6f:3248 with SMTP id x19-20020a170902b41300b001b82c6f3248mr3913704plr.39.1690436202969;
        Wed, 26 Jul 2023 22:36:42 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:42 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 35/42] clk: at91: clk-plldiv: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:49 +0300
Message-Id: <20230727053156.13587-36-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parent_names support as parent_hw support is now available on all
platforms using clk-plldiv driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9n12.c |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-plldiv.c  | 11 +++--------
 drivers/clk/at91/dt-compat.c   |  2 +-
 drivers/clk/at91/pmc.h         |  2 +-
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 9 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index ca585440c54f..2bda11df7f0d 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -146,7 +146,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 2109b8cdf4ad..0c22b82ef368 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -172,7 +172,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 4cbb72a29f14..c2c5e9fe669c 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -194,7 +194,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index 1d5a0a6d299d..e4efb4ccab33 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -72,7 +72,7 @@ static const struct clk_ops plldiv_ops = {
 
 struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw)
+			 struct clk_hw *parent_hw)
 {
 	struct clk_plldiv *plldiv;
 	struct clk_hw *hw;
@@ -85,13 +85,8 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &plldiv_ops;
-	if (parent_hw) {
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-		init.num_parents = 1;
-	} else {
-		init.parent_names = parent_name ? &parent_name : NULL;
-		init.num_parents = parent_name ? 1 : 0;
-	}
+	init.parent_hws = parent_hw ? (const struct clk_hw **)&parent_hw : NULL;
+	init.num_parents = parent_hw ? 1 : 0;
 	init.flags = CLK_SET_RATE_GATE;
 
 	plldiv->hw.init = &init;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 13e251e59853..85193e4656b9 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -805,7 +805,7 @@ of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_plldiv(regmap, name, NULL, parent_hw);
+	hw = at91_clk_register_plldiv(regmap, name, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 5fd1e76b3ec7..eed88a480b11 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -207,7 +207,7 @@ at91_clk_register_pll(struct regmap *regmap, const char *name,
 		      const struct clk_pll_characteristics *characteristics);
 struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw);
+			 struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index b99a8bb9bf9a..75d5b1a3733b 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -226,7 +226,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 35a9dfd0e66d..a50e82460e70 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -173,7 +173,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index ae76c59c7d42..b6b41ceae13c 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -188,7 +188,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.39.2

