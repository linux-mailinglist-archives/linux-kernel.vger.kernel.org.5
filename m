Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5067645C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjG0FiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0Fhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:37:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B362728
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb775625e2so3332315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436139; x=1691040939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQlXbwoci/ewwucHyWtCCTQ2+X4L0Fz5xsjb1IQcag4=;
        b=Bg5yjQAjktp2tJN/SXnI4Hbxj/NHVgUV4xq2Aq1auahzR1Uc+3pqQO1aOt8K2rE2Vh
         9S/5SYQbxmkPVwaFQQqurFrabLky1ex30remLU9wCYUbRBhdwNmgsqQCMP9pjh3qJOaF
         RlLL5pfKUQ6F/HOrNjjebOXkb3+9ZdefSZVrAQiQ7MCW64ortIe3AMxkBysncZBoy/i/
         o207ddtT7pYA7NCUIxD/m1AnPWwcjDV31mYa56A9BAD4V1a17UlN23zqU20OAfZ4wcYc
         IU89p/pQyc9/M6cNV31hcc4J1CoWIi0FSAGWlb73PvUJbjB14GYUhq6oQpRS8852jBn4
         YwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436139; x=1691040939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQlXbwoci/ewwucHyWtCCTQ2+X4L0Fz5xsjb1IQcag4=;
        b=lV53i/UP+JVdUZ4S59CN9LwY3QJdfro5MAoVifPCunewrJBfVOgPab1Kq4LOZgYCnu
         GRoByEwJY2xIdHPei+SHHdJkX+AOFS08kBmD8TtS/LDnLJwYm+8PGZW+yAenyILM4tzx
         5B/1ZiwIsLbVxp+Q2uI2XadQyeBpp3wr0JdSetO25TArc2bJhgViyxPPFcIkfUjTejC7
         Kh6fAO1n1ea7POuFMgVW/WkuQagVsqetzg6H5oOMG797FtuR+QjMXPA6q2DCku3zqxp7
         Ot6LkM13XdL4kShLoBxQfoBLDN/zBj8EQOGp7o1p+eflF78QKGaP5wWdFv5zGPuqs6Fn
         o2Nw==
X-Gm-Message-State: ABy/qLZ8oXf5nydREFncjuGptJMte1hW9mk8JYaYnNfZp9ssYT17mMRZ
        TYp65HcmJYaiYNEvZ7ZXiHfzLw==
X-Google-Smtp-Source: APBJJlHsDVCtvEOmrOaGJqf0BjQfeVpMuyWKgqwEHE5zMzyunm3gXSds0Z9gD5iv2xDyHelkUGaIeg==
X-Received: by 2002:a17:902:8c86:b0:1b8:c63:4b79 with SMTP id t6-20020a1709028c8600b001b80c634b79mr1658635plo.19.1690436138684;
        Wed, 26 Jul 2023 22:35:38 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:38 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 26/42] clk: at91: dt-compat: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:40 +0300
Message-Id: <20230727053156.13587-27-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch old dt-compat clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/dt-compat.c | 328 +++++++++++++++++++++++++----------
 1 file changed, 232 insertions(+), 96 deletions(-)

diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index dbc59ac44828..044e1fc821e2 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
@@ -29,11 +30,11 @@ static DEFINE_SPINLOCK(mck_lock);
 #ifdef CONFIG_HAVE_AT91_AUDIO_PLL
 static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
-	const char *parent_name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
@@ -41,9 +42,15 @@ static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
-	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name, NULL);
+	hw = at91_clk_register_audio_pll_frac(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -55,11 +62,11 @@ CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_frac_setup,
 
 static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
-	const char *parent_name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
@@ -67,9 +74,15 @@ static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
-	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name, NULL);
+	hw = at91_clk_register_audio_pll_pad(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -81,11 +94,11 @@ CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
 
 static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
-	const char *parent_name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
@@ -93,9 +106,15 @@ static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
-	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name, NULL);
+	hw = at91_clk_register_audio_pll_pmc(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -126,18 +145,26 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 	int num;
 	u32 id;
 	const char *name;
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[GENERATED_SOURCE_MAX];
+	struct clk_hw *hw, *parent_hws[GENERATED_SOURCE_MAX];
+	unsigned int num_parents, i;
 	struct device_node *gcknp, *parent_np;
 	struct clk_range range = CLK_RANGE(0, 0);
 	struct regmap *regmap;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 
 	num = of_get_child_count(np);
 	if (!num || num > PERIPHERAL_MAX)
@@ -171,7 +198,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &dt_pcr_layout, name,
-						 parent_names, NULL, NULL,
+						 NULL, parent_hws, NULL,
 						 num_parents, id, &range,
 						 chg_pid);
 		if (IS_ERR(hw))
@@ -187,11 +214,11 @@ CLK_OF_DECLARE(of_sama5d2_clk_generated_setup, "atmel,sama5d2-clk-generated",
 #ifdef CONFIG_HAVE_AT91_H32MX
 static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
-	const char *parent_name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
@@ -199,9 +226,15 @@ static void __init of_sama5d4_clk_h32mx_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
-	hw = at91_clk_register_h32mx(regmap, name, parent_name, NULL);
+	hw = at91_clk_register_h32mx(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -217,11 +250,10 @@ CLK_OF_DECLARE(of_sama5d4_clk_h32mx_setup, "atmel,sama5d4-clk-h32mx",
 static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
 {
 	struct regmap *regmap_sfr;
-	u8 bus_id;
-	const char *parent_names[2];
+	u8 bus_id, i;
 	struct device_node *i2s_mux_np;
-	struct clk_hw *hw;
-	int ret;
+	struct clk_hw *hw, *parent_hws[2] = {};
+	struct clk *clk;
 
 	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
 	if (IS_ERR(regmap_sfr))
@@ -234,16 +266,26 @@ static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
 		if (bus_id > I2S_BUS_NR)
 			continue;
 
-		ret = of_clk_parent_fill(i2s_mux_np, parent_names, 2);
-		if (ret != 2)
+		for (i = 0; i < 2; i++) {
+			clk = of_clk_get(np, i);
+			if (IS_ERR(clk))
+				break;
+
+			parent_hws[i] = __clk_get_hw(clk);
+			if (!parent_hws[i])
+				break;
+		}
+		if (!parent_hws[1])
 			continue;
 
 		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
-					       parent_names, NULL, 2, bus_id);
+					       NULL, parent_hws, 2, bus_id);
 		if (IS_ERR(hw))
 			continue;
 
 		of_clk_add_hw_provider(i2s_mux_np, of_clk_hw_simple_get, hw);
+
+		parent_hws[1] = NULL;
 	}
 }
 CLK_OF_DECLARE(sama5d2_clk_i2s_mux, "atmel,sama5d2-clk-i2s-mux",
@@ -258,6 +300,7 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 	struct regmap *regmap;
 	bool bypass;
 	struct device_node *parent_np;
+	static struct clk_parent_data parent_data;
 
 	of_property_read_string(np, "clock-output-names", &name);
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
@@ -269,7 +312,9 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_main_osc(regmap, name, parent_name, NULL, bypass);
+	parent_data.name = parent_name;
+	parent_data.fw_name = parent_name;
+	hw = at91_clk_register_main_osc(regmap, name, NULL, &parent_data, bypass);
 	if (IS_ERR(hw))
 		return;
 
@@ -308,13 +353,12 @@ CLK_OF_DECLARE(at91sam9x5_clk_main_rc_osc, "atmel,at91sam9x5-clk-main-rc-osc",
 
 static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
 	of_property_read_string(np, "clock-output-names", &name);
 
 	parent_np = of_get_parent(np);
@@ -323,7 +367,15 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, name, parent_name, NULL);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
+
+	hw = at91_clk_register_rm9200_main(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -334,18 +386,26 @@ CLK_OF_DECLARE(at91rm9200_clk_main, "atmel,at91rm9200-clk-main",
 
 static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
+	struct clk_hw *hw, *parent_hws[2];
+	unsigned int num_parents, i;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > 2)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
@@ -354,7 +414,7 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9x5_main(regmap, name, parent_names, NULL,
+	hw = at91_clk_register_sam9x5_main(regmap, name, NULL, parent_hws,
 					   num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -393,19 +453,27 @@ static void __init
 of_at91_clk_master_setup(struct device_node *np,
 			 const struct clk_master_layout *layout)
 {
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[MASTER_SOURCE_MAX];
+	struct clk_hw *hw, *parent_hws[MASTER_SOURCE_MAX];
+	unsigned int num_parents, i;
 	const char *name = np->name;
 	struct clk_master_characteristics *characteristics;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > MASTER_SOURCE_MAX)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < MASTER_SOURCE_MAX; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -420,12 +488,12 @@ of_at91_clk_master_setup(struct device_node *np,
 		return;
 
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", num_parents,
-					   parent_names, NULL, layout,
+					   NULL, parent_hws, layout,
 					   characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
-	hw = at91_clk_register_master_div(regmap, name, "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, name, NULL, hw,
 					  layout, characteristics,
 					  &mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
@@ -457,15 +525,19 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 {
 	int num;
 	u32 id;
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name;
 	struct device_node *periphclknp;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
 		return;
 
 	num = of_get_child_count(np);
@@ -490,7 +562,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 
 		if (type == PERIPHERAL_AT91RM9200) {
 			hw = at91_clk_register_peripheral(regmap, name,
-							  parent_name, NULL, id);
+							  NULL, parent_hw, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
 			unsigned long flags = 0;
@@ -511,8 +583,8 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 								 &pmc_pcr_lock,
 								 &dt_pcr_layout,
 								 name,
-								 parent_name,
 								 NULL,
+								 parent_hw,
 								 id, &range,
 								 INT_MIN,
 								 flags);
@@ -640,17 +712,23 @@ of_at91_clk_pll_setup(struct device_node *np,
 		      const struct clk_pll_layout *layout)
 {
 	u32 id;
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	struct regmap *regmap;
-	const char *parent_name;
 	const char *name = np->name;
 	struct device_node *parent_np;
 	struct clk_pll_characteristics *characteristics;
+	struct clk *clk;
 
 	if (of_property_read_u32(np, "reg", &id))
 		return;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -664,7 +742,7 @@ of_at91_clk_pll_setup(struct device_node *np,
 	if (!characteristics)
 		return;
 
-	hw = at91_clk_register_pll(regmap, name, parent_name, NULL, id, layout,
+	hw = at91_clk_register_pll(regmap, name, NULL, parent_hw, id, layout,
 				   characteristics);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
@@ -707,13 +785,19 @@ CLK_OF_DECLARE(sama5d3_clk_pll, "atmel,sama5d3-clk-pll",
 static void __init
 of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -723,7 +807,7 @@ of_at91sam9x5_clk_plldiv_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91_clk_register_plldiv(regmap, name, parent_name, NULL);
+	hw = at91_clk_register_plldiv(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -739,18 +823,26 @@ of_at91_clk_prog_setup(struct device_node *np,
 {
 	int num;
 	u32 id;
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[PROG_SOURCE_MAX];
+	struct clk_hw *hw, *parent_hws[PROG_SOURCE_MAX];
+	unsigned int num_parents, i;
 	const char *name;
 	struct device_node *progclknp, *parent_np;
 	struct regmap *regmap;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > PROG_SOURCE_MAX)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 
 	num = of_get_child_count(np);
 	if (!num || num > (PROG_ID_MAX + 1))
@@ -770,7 +862,7 @@ of_at91_clk_prog_setup(struct device_node *np,
 			name = progclknp->name;
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, num_parents,
+						    NULL, parent_hws, num_parents,
 						    id, layout, mux_table);
 		if (IS_ERR(hw))
 			continue;
@@ -802,18 +894,26 @@ CLK_OF_DECLARE(at91sam9x5_clk_prog, "atmel,at91sam9x5-clk-programmable",
 
 static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_names[2];
-	unsigned int num_parents;
+	struct clk_hw *hw, *parent_hws[2];
+	unsigned int num_parents, i;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents != 2)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 	parent_np = of_get_parent(np);
 	regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
@@ -822,7 +922,7 @@ static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names, NULL,
+	hw = at91_clk_register_sam9260_slow(regmap, name, NULL, parent_hws,
 					    num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -837,18 +937,26 @@ CLK_OF_DECLARE(at91sam9260_clk_slow, "atmel,at91sam9260-clk-slow",
 
 static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[SMD_SOURCE_MAX];
+	struct clk_hw *hw, *parent_hws[SMD_SOURCE_MAX];
+	unsigned int num_parents, i;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > SMD_SOURCE_MAX)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -858,7 +966,7 @@ static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names, NULL,
+	hw = at91sam9x5_clk_register_smd(regmap, name, NULL, parent_hws,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -873,11 +981,11 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 {
 	int num;
 	u32 id;
-	struct clk_hw *hw;
+	struct clk_hw *hw, *parent_hw;
 	const char *name;
 	struct device_node *sysclknp, *parent_np;
-	const char *parent_name;
 	struct regmap *regmap;
+	struct clk *clk;
 
 	num = of_get_child_count(np);
 	if (num > (SYSTEM_MAX_ID + 1))
@@ -898,7 +1006,13 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		if (of_property_read_string(np, "clock-output-names", &name))
 			name = sysclknp->name;
 
-		parent_name = of_clk_get_parent_name(sysclknp, 0);
+		clk = of_clk_get(sysclknp, 0);
+		if (IS_ERR(clk))
+			continue;
+
+		parent_hw = __clk_get_hw(clk);
+		if (!parent_hw)
+			continue;
 
 		/*
 		 * ddrck feeds DDR controller and is enabled by bootloader thus
@@ -908,7 +1022,7 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		if (!strcmp(sysclknp->name, "ddrck"))
 			flags = CLK_IS_CRITICAL;
 
-		hw = at91_clk_register_system(regmap, name, parent_name, NULL,
+		hw = at91_clk_register_system(regmap, name, NULL, parent_hw,
 					      id, flags);
 		if (IS_ERR(hw))
 			continue;
@@ -924,18 +1038,26 @@ CLK_OF_DECLARE(at91rm9200_clk_sys, "atmel,at91rm9200-clk-system",
 
 static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	unsigned int num_parents;
-	const char *parent_names[USB_SOURCE_MAX];
+	struct clk_hw *hw, *parent_hws[USB_SOURCE_MAX];
+	unsigned int num_parents, i;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > USB_SOURCE_MAX)
 		return;
 
-	of_clk_parent_fill(np, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++) {
+		clk = of_clk_get(np, i);
+		if (IS_ERR(clk))
+			return;
+
+		parent_hws[i] = __clk_get_hw(clk);
+		if (!parent_hws[i])
+			return;
+	}
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -945,7 +1067,7 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names, NULL,
+	hw = at91sam9x5_clk_register_usb(regmap, name, NULL, parent_hws,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -957,14 +1079,18 @@ CLK_OF_DECLARE(at91sam9x5_clk_usb, "atmel,at91sam9x5-clk-usb",
 
 static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
 		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
@@ -975,7 +1101,7 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name, NULL);
+	hw = at91sam9n12_clk_register_usb(regmap, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -986,15 +1112,19 @@ CLK_OF_DECLARE(at91sam9n12_clk_usb, "atmel,at91sam9n12-clk-usb",
 
 static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
 	u32 divisors[4] = {0, 0, 0, 0};
 	struct regmap *regmap;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name)
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
 		return;
 
 	of_property_read_u32_array(np, "atmel,clk-divisors", divisors, 4);
@@ -1008,7 +1138,7 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 	of_node_put(parent_np);
 	if (IS_ERR(regmap))
 		return;
-	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, NULL, divisors);
+	hw = at91rm9200_clk_register_usb(regmap, name, NULL, parent_hw, divisors);
 	if (IS_ERR(hw))
 		return;
 
@@ -1021,13 +1151,19 @@ CLK_OF_DECLARE(at91rm9200_clk_usb, "atmel,at91rm9200-clk-usb",
 #ifdef CONFIG_HAVE_AT91_UTMI
 static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 {
-	struct clk_hw *hw;
-	const char *parent_name;
+	struct clk_hw *hw, *parent_hw;
 	const char *name = np->name;
 	struct regmap *regmap_pmc, *regmap_sfr;
 	struct device_node *parent_np;
+	struct clk *clk;
 
-	parent_name = of_clk_get_parent_name(np, 0);
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return;
+
+	parent_hw = __clk_get_hw(clk);
+	if (!parent_hw)
+		return;
 
 	of_property_read_string(np, "clock-output-names", &name);
 
@@ -1055,7 +1191,7 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 			regmap_sfr = NULL;
 	}
 
-	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_name, NULL);
+	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, NULL, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
-- 
2.39.2

