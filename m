Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324247645E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjG0FlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG0Fkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:40:37 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70DC4683
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:39:02 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bbc64f9a91so4650335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436210; x=1691041010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q+Yl7hN1VwiQcIkQgiV66Esb2RGUFiRs91OdVgtBh0=;
        b=M0glJThlvwbGMQ+zCXsOdBo8zfEv8aUEkaRD1lWoFtxH8KWlcevQsd8CVfI5jCSbV5
         GviLj1eQYirIuNhvCwfOZYnKqOeGaDAGmQ81PpzBhpgCl3DFaXkBEbmGf4feY8CwCXbh
         sPrPP2xuvoBD4ePCM3Fdsz0idTiBaWIkTMf9ffxGN7PhhFC3fIG0ZaNpq37DJACJcPvZ
         MPDIofZp+XOLQELb9C6kXuwvLBe4xAz0PIaOHCipxoc6tIgR0Hi0laRXYOu1IDGDx8Bu
         zamHJme4DZQSOzBVNzw88sbqFlCLSPMF60KtvVt6e7of+G+gm7KBRLKOf5yQUjDJlyKR
         TyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436210; x=1691041010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q+Yl7hN1VwiQcIkQgiV66Esb2RGUFiRs91OdVgtBh0=;
        b=eyAjxx5JzZtuH96bZfom9VXElAlkCjUrayGY8MVzmsZbYkrAHpee5l4f7UwQjNKXyr
         v0yewbYjs1O7A28HX1WR6ODXsjLkJWDHifF2bEX3zVYijOSLIKVe5RBhv3oV/G++Ko+X
         0ThotPFSY2y2pAZS6yH0SowXoX0Ur6zeIpOljOAdWaJMWuRXY8G52sIuHvcAkstHJb3B
         UuWmio/VMOzr+TPO1vCdmMuS9ldH2Axivbs/ZtR+4Ulkt92/loDMweYa6CrxXZvkUy53
         9OlmoHw9+ETRUfFa6D62BYta1n38mWrQpxtoQ9f36m8r/Ey4xcNJH8ZhxSJpogUimFZV
         7thw==
X-Gm-Message-State: ABy/qLbNItwKG1Ld6jlm0mW6Jmnsp+BOGqi+kyMELPBlbOI3zW+cAPCE
        +9pFDrsAtGiPM/jix6NDnJc0vQ==
X-Google-Smtp-Source: APBJJlHVSJGhP4xROul0kKK8gz7i1cwuobZUOhpNAjMjCbAOJfpC/qq2G3ht/RzeTU5qSvAZiVg1jw==
X-Received: by 2002:a17:902:ea06:b0:1b8:4e00:96b with SMTP id s6-20020a170902ea0600b001b84e00096bmr5499076plg.9.1690436210347;
        Wed, 26 Jul 2023 22:36:50 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:50 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 36/42] clk: at91: clk-programmable: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:50 +0300
Message-Id: <20230727053156.13587-37-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parent_names support as parent_hw support is now available on all
platforms using clk-programmable driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c       |  2 +-
 drivers/clk/at91/at91sam9260.c      |  2 +-
 drivers/clk/at91/at91sam9g45.c      |  2 +-
 drivers/clk/at91/at91sam9n12.c      |  2 +-
 drivers/clk/at91/at91sam9rl.c       |  2 +-
 drivers/clk/at91/at91sam9x5.c       |  2 +-
 drivers/clk/at91/clk-programmable.c | 10 +++-------
 drivers/clk/at91/dt-compat.c        |  2 +-
 drivers/clk/at91/pmc.h              |  2 +-
 drivers/clk/at91/sam9x60.c          |  2 +-
 drivers/clk/at91/sama5d2.c          |  2 +-
 drivers/clk/at91/sama5d3.c          |  2 +-
 drivers/clk/at91/sama5d4.c          |  2 +-
 drivers/clk/at91/sama7g5.c          |  2 +-
 14 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index be88279c3443..9305cb6eaef2 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -178,7 +178,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 4, i,
+						    parent_hws, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index bd5e0ce432d3..c118ff23548b 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -451,7 +451,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 4, i,
+						    parent_hws, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 2bda11df7f0d..a5bc6f5c8173 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -197,7 +197,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91sam9g45_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 0c22b82ef368..b4dfe2d1de8a 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -223,7 +223,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 4ae8028600d5..48d79189fc98 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -150,7 +150,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index c2c5e9fe669c..f278bee3417c 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -247,7 +247,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 1195fb405503..a400aac5b2e2 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -213,8 +213,7 @@ static const struct clk_ops programmable_ops = {
 };
 
 struct clk_hw * __init
-at91_clk_register_programmable(struct regmap *regmap,
-			       const char *name, const char **parent_names,
+at91_clk_register_programmable(struct regmap *regmap, const char *name,
 			       struct clk_hw **parent_hws, u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout,
 			       u32 *mux_table)
@@ -224,7 +223,7 @@ at91_clk_register_programmable(struct regmap *regmap,
 	struct clk_init_data init = {};
 	int ret;
 
-	if (id > PROG_ID_MAX || !(parent_names || parent_hws))
+	if (id > PROG_ID_MAX || !parent_hws)
 		return ERR_PTR(-EINVAL);
 
 	prog = kzalloc(sizeof(*prog), GFP_KERNEL);
@@ -233,10 +232,7 @@ at91_clk_register_programmable(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &programmable_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 85193e4656b9..11fdbca8ee83 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -860,7 +860,7 @@ of_at91_clk_prog_setup(struct device_node *np,
 			name = progclknp->name;
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, num_parents,
+						    parent_hws, num_parents,
 						    id, layout, mux_table);
 		if (IS_ERR(hw))
 			continue;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index eed88a480b11..7d2524109776 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -226,7 +226,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
-			       const char **parent_names, struct clk_hw **parent_hws,
+			       struct clk_hw **parent_hws,
 			       u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout,
 			       u32 *mux_table);
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 148873fced1b..897a8f2d6102 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -318,7 +318,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 6, i,
+						    parent_hws, 6, i,
 						    &sam9x60_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 75d5b1a3733b..c64b79b44ba6 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -304,7 +304,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 6, i,
+						    parent_hws, 6, i,
 						    &sama5d2_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index a50e82460e70..021e012fe202 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -226,7 +226,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index b6b41ceae13c..e196ec80570f 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -249,7 +249,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    NULL, parent_hws, 5, i,
+						    parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 9cba1ad116a8..baec84bd5d06 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1171,7 +1171,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
-		hw = at91_clk_register_programmable(regmap, name, NULL, parent_hws,
+		hw = at91_clk_register_programmable(regmap, name, parent_hws,
 						    9, i,
 						    &programmable_layout,
 						    sama7g5_prog_mux_table);
-- 
2.39.2

