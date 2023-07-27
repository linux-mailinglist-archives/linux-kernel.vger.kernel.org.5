Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31176459A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjG0FfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjG0Fek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C52D59
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b91c2744so467092b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436051; x=1691040851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/H1fFwwjqngvhNBP4nbjwJK1x037U3/vvPMvetEGEQ=;
        b=cCou1bY1xsAlB2b6a4i1I7lerXT5fsZkJvyRpw5Mo4MywIyStAQwDk9yq+EDJcACv+
         h2SmYuQVZHU9kkmlOCKr1y+dS1nE+6HHS7IBwZ3cOYpwVss3HTw0KFT1F94ryGUj64lm
         SoPQOUfi/KhpZhMTINH5TLS4kuodTPnVVhfW31eCZHirZ0UAs2z4ul9GwbfySyvvdA3d
         K6lZcQC2Chzdedy8/ZqZ8Q8ymfVJ/9sen1+twv3SLcbjp4s0DNUEWCQNVCzAFczwJjF7
         BeO+Suhc57pDm8guAqAEW3eeDbwZ6vJ91DMZocS59FqJDRlxyzrN8tncrjrxZzQiFKFW
         aLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436051; x=1691040851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/H1fFwwjqngvhNBP4nbjwJK1x037U3/vvPMvetEGEQ=;
        b=C5aBhxg7RRfum67+nilUIOWdGRjiocAU8b+I4NHMIAUAhFxqm+Db7NF/1pmP1v8fnj
         frL/lBsW66kqG8nNtzQXzkQsyiZL7ezLStv/h7n9Ehnhjj5qWJweM9eP3UmTJ4dcqxeu
         RId7C2zD155OF+gxFr4lPk5+uB/vOfJ9fxHxDRR2iEJsX6e09cJ+Al+PhEgVGhO4VWK8
         wiGgsBKXnlTuTqsDvNl56NHwnGKku1+ydxeC7PGUnTpe9HfuSjgBFdPu7VWnLViVvtw2
         SA++r4YEifXGP8npcJ5Q7FtJHjnOl1IlNxvH3bkW7TARHRd7LtVxAB3/WfZwZwkmVm6T
         h+BQ==
X-Gm-Message-State: ABy/qLby52hWKf/nGC2S7vmdW1QSx+53UpTbymt0QnZ50sNmEDv/8tmX
        t3N8hzm87uz0VcnXdZmekpl11g==
X-Google-Smtp-Source: APBJJlHB/Kj7fixhJPcAfs7KQhIrnMeDg4xvC+Y2wuApi8GCcup3iOgeGozUrsiDj4ZDjwC/WZrsHA==
X-Received: by 2002:a05:6a21:a105:b0:135:38b5:7e63 with SMTP id aq5-20020a056a21a10500b0013538b57e63mr3366868pzc.46.1690436050915;
        Wed, 26 Jul 2023 22:34:10 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:10 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 14/42] clk: at91: sama5d4: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:28 +0300
Message-Id: <20230727053156.13587-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch SAMA5D4 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sama5d4.c | 131 +++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 1ff9286148da..ac7565b26dce 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -36,9 +37,9 @@ static const struct clk_pcr_layout sama5d4_pcr_layout = {
 	.pid_mask = GENMASK(6, 0),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sama5d4_systemck[] = {
@@ -46,14 +47,14 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "smdck", .p = "smdclk",       .id = 4 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
-	{ .n = "pck2",  .p = "prog2",        .id = 10 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "smdck", .id = 4 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
 };
 
 static const struct {
@@ -128,25 +129,29 @@ static const struct {
 
 static void __init sama5d4_pmc_setup(struct device_node *np)
 {
+	struct clk_hw *slow_clk_hw, *main_xtal_hw, *main_rc_hw, *main_osc_hw, *mainck_hw;
+	struct clk_hw *parent_hws[5], *smdck_hw, *usbck_hw, *hw;
+	static struct clk_parent_data parent_data;
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *slck_name, *mainxtal_name;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *sama5d4_pmc;
-	const char *parent_names[5];
 	struct regmap *regmap;
-	struct clk_hw *hw;
+	struct clk *clk;
 	int i;
 	bool bypass;
 
-	i = of_property_match_string(np, "clock-names", "slow_clk");
-	if (i < 0)
+	clk = of_clk_get_by_name(np, "slow_clk");
+	if (IS_ERR(clk))
 		return;
-
-	slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
+	slow_clk_hw = __clk_get_hw(clk);
+	if (!slow_clk_hw)
+		return;
+	clk = of_clk_get_by_name(np, main_xtal_name);
+	if (IS_ERR(clk))
+		return;
+	main_xtal_hw = __clk_get_hw(clk);
+	if (!main_xtal_hw)
 		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -158,54 +163,55 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	if (!sama5d4_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   100000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   100000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	parent_data.name = main_xtal_name;
+	parent_data.fw_name = main_xtal_name;
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+						 bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
+	parent_hws[0] = main_rc_hw;
+	parent_hws[1] = main_osc_hw;
+	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, mainck_hw, 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d4_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, mainck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d4_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = mainck_hw;
+	parent_hws[2] = sama5d4_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d4_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
@@ -214,36 +220,36 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	sama5d4_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91_clk_register_h32mx(regmap, "h32mxck", "masterck_div", NULL);
+	hw = at91_clk_register_h32mx(regmap, "h32mxck", NULL, sama5d4_pmc->chws[PMC_MCK]);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d4_pmc->chws[PMC_MCK2] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_hws[0] = sama5d4_pmc->chws[PMC_PLLACK];
+	parent_hws[1] = sama5d4_pmc->chws[PMC_UTMI];
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_hws[0] = sama5d4_pmc->chws[PMC_PLLACK];
+	parent_hws[1] = sama5d4_pmc->chws[PMC_UTMI];
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_hws, 2);
+	if (IS_ERR(smdck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = mainck_hw;
+	parent_hws[2] = sama5d4_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d4_pmc->chws[PMC_UTMI];
+	parent_hws[4] = sama5d4_pmc->chws[PMC_MCK];
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -252,9 +258,18 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		sama5d4_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama5d4_systemck[0].parent_hw = sama5d4_pmc->chws[PMC_MCK];
+	sama5d4_systemck[1].parent_hw = sama5d4_pmc->chws[PMC_MCK];
+	sama5d4_systemck[2].parent_hw = smdck_hw;
+	sama5d4_systemck[3].parent_hw = usbck_hw;
+	sama5d4_systemck[4].parent_hw = usbck_hw;
+	sama5d4_systemck[5].parent_hw = sama5d4_pmc->pchws[0];
+	sama5d4_systemck[6].parent_hw = sama5d4_pmc->pchws[1];
+	sama5d4_systemck[7].parent_hw = sama5d4_pmc->pchws[2];
 	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d4_systemck[i].n,
-					      sama5d4_systemck[i].p, NULL,
+					      NULL, sama5d4_systemck[i].parent_hw,
 					      sama5d4_systemck[i].id,
 					      sama5d4_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -267,7 +282,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL, sama5d4_pmc->chws[PMC_MCK],
 							 sama5d4_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d4_periphck[i].flags);
@@ -281,7 +296,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periph32ck[i].n,
-							 "h32mxck", NULL,
+							 NULL, sama5d4_pmc->chws[PMC_MCK2],
 							 sama5d4_periph32ck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
-- 
2.39.2

