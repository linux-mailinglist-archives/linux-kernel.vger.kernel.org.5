Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A09806F09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377983AbjLFLvT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378068AbjLFLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:53 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CA010EC;
        Wed,  6 Dec 2023 03:50:48 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7972C24E314;
        Wed,  6 Dec 2023 19:50:47 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:50:47 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:50:38 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH v1 04/16] clk: starfive: Convert the word "jh71x0" to "starfive"
Date:   Wed, 6 Dec 2023 19:49:48 +0800
Message-ID: <20231206115000.295825-5-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.c    | 290 +++++-----
 drivers/clk/starfive/clk-starfive-common.h    |  68 +--
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 125 ++---
 drivers/clk/starfive/clk-starfive-jh7100.c    | 501 ++++++++---------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +--
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 ++--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 517 +++++++++---------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   2 +-
 10 files changed, 908 insertions(+), 897 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-common.c b/drivers/clk/starfive/clk-starfive-common.c
index a12490c97957..fd608286ca13 100644
--- a/drivers/clk/starfive/clk-starfive-common.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -12,27 +12,27 @@
 
 #include "clk-starfive-common.h"
 
-static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
+static struct starfive_clk *starfive_clk_from(struct clk_hw *hw)
 {
-	return container_of(hw, struct jh71x0_clk, hw);
+	return container_of(hw, struct starfive_clk, hw);
 }
 
-static struct jh71x0_clk_priv *jh71x0_priv_from(struct jh71x0_clk *clk)
+static struct starfive_clk_priv *starfive_priv_from(struct starfive_clk *clk)
 {
-	return container_of(clk, struct jh71x0_clk_priv, reg[clk->idx]);
+	return container_of(clk, struct starfive_clk_priv, reg[clk->idx]);
 }
 
-static u32 jh71x0_clk_reg_get(struct jh71x0_clk *clk)
+static u32 starfive_clk_reg_get(struct starfive_clk *clk)
 {
-	struct jh71x0_clk_priv *priv = jh71x0_priv_from(clk);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
 	void __iomem *reg = priv->base + 4 * clk->idx;
 
 	return readl_relaxed(reg);
 }
 
-static void jh71x0_clk_reg_rmw(struct jh71x0_clk *clk, u32 mask, u32 value)
+static void starfive_clk_reg_rmw(struct starfive_clk *clk, u32 mask, u32 value)
 {
-	struct jh71x0_clk_priv *priv = jh71x0_priv_from(clk);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
 	void __iomem *reg = priv->base + 4 * clk->idx;
 	unsigned long flags;
 
@@ -42,41 +42,41 @@ static void jh71x0_clk_reg_rmw(struct jh71x0_clk *clk, u32 mask, u32 value)
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 }
 
-static int jh71x0_clk_enable(struct clk_hw *hw)
+static int starfive_clk_enable(struct clk_hw *hw)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_ENABLE, JH71X0_CLK_ENABLE);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_ENABLE, STARFIVE_CLK_ENABLE);
 	return 0;
 }
 
-static void jh71x0_clk_disable(struct clk_hw *hw)
+static void starfive_clk_disable(struct clk_hw *hw)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_ENABLE, 0);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_ENABLE, 0);
 }
 
-static int jh71x0_clk_is_enabled(struct clk_hw *hw)
+static int starfive_clk_is_enabled(struct clk_hw *hw)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 
-	return !!(jh71x0_clk_reg_get(clk) & JH71X0_CLK_ENABLE);
+	return !!(starfive_clk_reg_get(clk) & STARFIVE_CLK_ENABLE);
 }
 
-static unsigned long jh71x0_clk_recalc_rate(struct clk_hw *hw,
-					    unsigned long parent_rate)
+static unsigned long starfive_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	u32 div = jh71x0_clk_reg_get(clk) & JH71X0_CLK_DIV_MASK;
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	u32 div = starfive_clk_reg_get(clk) & STARFIVE_CLK_DIV_MASK;
 
 	return div ? parent_rate / div : 0;
 }
 
-static int jh71x0_clk_determine_rate(struct clk_hw *hw,
-				     struct clk_rate_request *req)
+static int starfive_clk_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 	unsigned long parent = req->best_parent_rate;
 	unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
 	unsigned long div = min_t(unsigned long, DIV_ROUND_UP(parent, rate), clk->max_div);
@@ -102,226 +102,226 @@ static int jh71x0_clk_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static int jh71x0_clk_set_rate(struct clk_hw *hw,
-			       unsigned long rate,
-			       unsigned long parent_rate)
+static int starfive_clk_set_rate(struct clk_hw *hw,
+				 unsigned long rate,
+				 unsigned long parent_rate)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 	unsigned long div = clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
 				  1UL, (unsigned long)clk->max_div);
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_DIV_MASK, div);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_DIV_MASK, div);
 	return 0;
 }
 
-static unsigned long jh71x0_clk_frac_recalc_rate(struct clk_hw *hw,
-						 unsigned long parent_rate)
+static unsigned long starfive_clk_frac_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	u32 reg = jh71x0_clk_reg_get(clk);
-	unsigned long div100 = 100 * (reg & JH71X0_CLK_INT_MASK) +
-			       ((reg & JH71X0_CLK_FRAC_MASK) >> JH71X0_CLK_FRAC_SHIFT);
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	u32 reg = starfive_clk_reg_get(clk);
+	unsigned long div100 = 100 * (reg & STARFIVE_CLK_INT_MASK) +
+			       ((reg & STARFIVE_CLK_FRAC_MASK) >> STARFIVE_CLK_FRAC_SHIFT);
 
-	return (div100 >= JH71X0_CLK_FRAC_MIN) ? 100 * parent_rate / div100 : 0;
+	return (div100 >= STARFIVE_CLK_FRAC_MIN) ? 100 * parent_rate / div100 : 0;
 }
 
-static int jh71x0_clk_frac_determine_rate(struct clk_hw *hw,
-					  struct clk_rate_request *req)
+static int starfive_clk_frac_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
 {
 	unsigned long parent100 = 100 * req->best_parent_rate;
 	unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
 	unsigned long div100 = clamp(DIV_ROUND_CLOSEST(parent100, rate),
-				     JH71X0_CLK_FRAC_MIN, JH71X0_CLK_FRAC_MAX);
+				     STARFIVE_CLK_FRAC_MIN, STARFIVE_CLK_FRAC_MAX);
 	unsigned long result = parent100 / div100;
 
-	/* clamp the result as in jh71x0_clk_determine_rate() above */
-	if (result > req->max_rate && div100 < JH71X0_CLK_FRAC_MAX)
+	/* clamp the result as in starfive_clk_determine_rate() above */
+	if (result > req->max_rate && div100 < STARFIVE_CLK_FRAC_MAX)
 		result = parent100 / (div100 + 1);
-	if (result < req->min_rate && div100 > JH71X0_CLK_FRAC_MIN)
+	if (result < req->min_rate && div100 > STARFIVE_CLK_FRAC_MIN)
 		result = parent100 / (div100 - 1);
 
 	req->rate = result;
 	return 0;
 }
 
-static int jh71x0_clk_frac_set_rate(struct clk_hw *hw,
-				    unsigned long rate,
-				    unsigned long parent_rate)
+static int starfive_clk_frac_set_rate(struct clk_hw *hw,
+				      unsigned long rate,
+				      unsigned long parent_rate)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 	unsigned long div100 = clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rate),
-				     JH71X0_CLK_FRAC_MIN, JH71X0_CLK_FRAC_MAX);
-	u32 value = ((div100 % 100) << JH71X0_CLK_FRAC_SHIFT) | (div100 / 100);
+				     STARFIVE_CLK_FRAC_MIN, STARFIVE_CLK_FRAC_MAX);
+	u32 value = ((div100 % 100) << STARFIVE_CLK_FRAC_SHIFT) | (div100 / 100);
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_DIV_MASK, value);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_DIV_MASK, value);
 	return 0;
 }
 
-static u8 jh71x0_clk_get_parent(struct clk_hw *hw)
+static u8 starfive_clk_get_parent(struct clk_hw *hw)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	u32 value = jh71x0_clk_reg_get(clk);
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	u32 value = starfive_clk_reg_get(clk);
 
-	return (value & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT;
+	return (value & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT;
 }
 
-static int jh71x0_clk_set_parent(struct clk_hw *hw, u8 index)
+static int starfive_clk_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	u32 value = (u32)index << JH71X0_CLK_MUX_SHIFT;
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	u32 value = (u32)index << STARFIVE_CLK_MUX_SHIFT;
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_MUX_MASK, value);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_MUX_MASK, value);
 	return 0;
 }
 
-static int jh71x0_clk_get_phase(struct clk_hw *hw)
+static int starfive_clk_get_phase(struct clk_hw *hw)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	u32 value = jh71x0_clk_reg_get(clk);
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	u32 value = starfive_clk_reg_get(clk);
 
-	return (value & JH71X0_CLK_INVERT) ? 180 : 0;
+	return (value & STARFIVE_CLK_INVERT) ? 180 : 0;
 }
 
-static int jh71x0_clk_set_phase(struct clk_hw *hw, int degrees)
+static int starfive_clk_set_phase(struct clk_hw *hw, int degrees)
 {
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
+	struct starfive_clk *clk = starfive_clk_from(hw);
 	u32 value;
 
 	if (degrees == 0)
 		value = 0;
 	else if (degrees == 180)
-		value = JH71X0_CLK_INVERT;
+		value = STARFIVE_CLK_INVERT;
 	else
 		return -EINVAL;
 
-	jh71x0_clk_reg_rmw(clk, JH71X0_CLK_INVERT, value);
+	starfive_clk_reg_rmw(clk, STARFIVE_CLK_INVERT, value);
 	return 0;
 }
 
 #ifdef CONFIG_DEBUG_FS
-static void jh71x0_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void starfive_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
 {
-	static const struct debugfs_reg32 jh71x0_clk_reg = {
+	static const struct debugfs_reg32 starfive_clk_reg = {
 		.name = "CTRL",
 		.offset = 0,
 	};
-	struct jh71x0_clk *clk = jh71x0_clk_from(hw);
-	struct jh71x0_clk_priv *priv = jh71x0_priv_from(clk);
+	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
 	struct debugfs_regset32 *regset;
 
 	regset = devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
 	if (!regset)
 		return;
 
-	regset->regs = &jh71x0_clk_reg;
+	regset->regs = &starfive_clk_reg;
 	regset->nregs = 1;
 	regset->base = priv->base + 4 * clk->idx;
 
 	debugfs_create_regset32("registers", 0400, dentry, regset);
 }
 #else
-#define jh71x0_clk_debug_init NULL
+#define starfive_clk_debug_init NULL
 #endif
 
-static const struct clk_ops jh71x0_clk_gate_ops = {
-	.enable = jh71x0_clk_enable,
-	.disable = jh71x0_clk_disable,
-	.is_enabled = jh71x0_clk_is_enabled,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_gate_ops = {
+	.enable = starfive_clk_enable,
+	.disable = starfive_clk_disable,
+	.is_enabled = starfive_clk_is_enabled,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_div_ops = {
-	.recalc_rate = jh71x0_clk_recalc_rate,
-	.determine_rate = jh71x0_clk_determine_rate,
-	.set_rate = jh71x0_clk_set_rate,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_div_ops = {
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_fdiv_ops = {
-	.recalc_rate = jh71x0_clk_frac_recalc_rate,
-	.determine_rate = jh71x0_clk_frac_determine_rate,
-	.set_rate = jh71x0_clk_frac_set_rate,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_fdiv_ops = {
+	.recalc_rate = starfive_clk_frac_recalc_rate,
+	.determine_rate = starfive_clk_frac_determine_rate,
+	.set_rate = starfive_clk_frac_set_rate,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_gdiv_ops = {
-	.enable = jh71x0_clk_enable,
-	.disable = jh71x0_clk_disable,
-	.is_enabled = jh71x0_clk_is_enabled,
-	.recalc_rate = jh71x0_clk_recalc_rate,
-	.determine_rate = jh71x0_clk_determine_rate,
-	.set_rate = jh71x0_clk_set_rate,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_gdiv_ops = {
+	.enable = starfive_clk_enable,
+	.disable = starfive_clk_disable,
+	.is_enabled = starfive_clk_is_enabled,
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_mux_ops = {
+static const struct clk_ops starfive_clk_mux_ops = {
 	.determine_rate = __clk_mux_determine_rate,
-	.set_parent = jh71x0_clk_set_parent,
-	.get_parent = jh71x0_clk_get_parent,
-	.debug_init = jh71x0_clk_debug_init,
+	.set_parent = starfive_clk_set_parent,
+	.get_parent = starfive_clk_get_parent,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_gmux_ops = {
-	.enable = jh71x0_clk_enable,
-	.disable = jh71x0_clk_disable,
-	.is_enabled = jh71x0_clk_is_enabled,
+static const struct clk_ops starfive_clk_gmux_ops = {
+	.enable = starfive_clk_enable,
+	.disable = starfive_clk_disable,
+	.is_enabled = starfive_clk_is_enabled,
 	.determine_rate = __clk_mux_determine_rate,
-	.set_parent = jh71x0_clk_set_parent,
-	.get_parent = jh71x0_clk_get_parent,
-	.debug_init = jh71x0_clk_debug_init,
+	.set_parent = starfive_clk_set_parent,
+	.get_parent = starfive_clk_get_parent,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_mdiv_ops = {
-	.recalc_rate = jh71x0_clk_recalc_rate,
-	.determine_rate = jh71x0_clk_determine_rate,
-	.get_parent = jh71x0_clk_get_parent,
-	.set_parent = jh71x0_clk_set_parent,
-	.set_rate = jh71x0_clk_set_rate,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_mdiv_ops = {
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.get_parent = starfive_clk_get_parent,
+	.set_parent = starfive_clk_set_parent,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_gmd_ops = {
-	.enable = jh71x0_clk_enable,
-	.disable = jh71x0_clk_disable,
-	.is_enabled = jh71x0_clk_is_enabled,
-	.recalc_rate = jh71x0_clk_recalc_rate,
-	.determine_rate = jh71x0_clk_determine_rate,
-	.get_parent = jh71x0_clk_get_parent,
-	.set_parent = jh71x0_clk_set_parent,
-	.set_rate = jh71x0_clk_set_rate,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_gmd_ops = {
+	.enable = starfive_clk_enable,
+	.disable = starfive_clk_disable,
+	.is_enabled = starfive_clk_is_enabled,
+	.recalc_rate = starfive_clk_recalc_rate,
+	.determine_rate = starfive_clk_determine_rate,
+	.get_parent = starfive_clk_get_parent,
+	.set_parent = starfive_clk_set_parent,
+	.set_rate = starfive_clk_set_rate,
+	.debug_init = starfive_clk_debug_init,
 };
 
-static const struct clk_ops jh71x0_clk_inv_ops = {
-	.get_phase = jh71x0_clk_get_phase,
-	.set_phase = jh71x0_clk_set_phase,
-	.debug_init = jh71x0_clk_debug_init,
+static const struct clk_ops starfive_clk_inv_ops = {
+	.get_phase = starfive_clk_get_phase,
+	.set_phase = starfive_clk_set_phase,
+	.debug_init = starfive_clk_debug_init,
 };
 
-const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
+const struct clk_ops *starfive_clk_ops(u32 max)
 {
-	if (max & JH71X0_CLK_DIV_MASK) {
-		if (max & JH71X0_CLK_MUX_MASK) {
-			if (max & JH71X0_CLK_ENABLE)
-				return &jh71x0_clk_gmd_ops;
-			return &jh71x0_clk_mdiv_ops;
+	if (max & STARFIVE_CLK_DIV_MASK) {
+		if (max & STARFIVE_CLK_MUX_MASK) {
+			if (max & STARFIVE_CLK_ENABLE)
+				return &starfive_clk_gmd_ops;
+			return &starfive_clk_mdiv_ops;
 		}
-		if (max & JH71X0_CLK_ENABLE)
-			return &jh71x0_clk_gdiv_ops;
-		if (max == JH71X0_CLK_FRAC_MAX)
-			return &jh71x0_clk_fdiv_ops;
-		return &jh71x0_clk_div_ops;
+		if (max & STARFIVE_CLK_ENABLE)
+			return &starfive_clk_gdiv_ops;
+		if (max == STARFIVE_CLK_FRAC_MAX)
+			return &starfive_clk_fdiv_ops;
+		return &starfive_clk_div_ops;
 	}
 
-	if (max & JH71X0_CLK_MUX_MASK) {
-		if (max & JH71X0_CLK_ENABLE)
-			return &jh71x0_clk_gmux_ops;
-		return &jh71x0_clk_mux_ops;
+	if (max & STARFIVE_CLK_MUX_MASK) {
+		if (max & STARFIVE_CLK_ENABLE)
+			return &starfive_clk_gmux_ops;
+		return &starfive_clk_mux_ops;
 	}
 
-	if (max & JH71X0_CLK_ENABLE)
-		return &jh71x0_clk_gate_ops;
+	if (max & STARFIVE_CLK_ENABLE)
+		return &starfive_clk_gate_ops;
 
-	return &jh71x0_clk_inv_ops;
+	return &starfive_clk_inv_ops;
 }
-EXPORT_SYMBOL_GPL(starfive_jh71x0_clk_ops);
+EXPORT_SYMBOL_GPL(starfive_clk_ops);
diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index 1f32f7024e9f..fed45311360c 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -8,36 +8,36 @@
 #include <linux/spinlock.h>
 
 /* register fields */
-#define JH71X0_CLK_ENABLE	BIT(31)
-#define JH71X0_CLK_INVERT	BIT(30)
-#define JH71X0_CLK_MUX_MASK	GENMASK(27, 24)
-#define JH71X0_CLK_MUX_SHIFT	24
-#define JH71X0_CLK_DIV_MASK	GENMASK(23, 0)
-#define JH71X0_CLK_FRAC_MASK	GENMASK(15, 8)
-#define JH71X0_CLK_FRAC_SHIFT	8
-#define JH71X0_CLK_INT_MASK	GENMASK(7, 0)
+#define STARFIVE_CLK_ENABLE	BIT(31)
+#define STARFIVE_CLK_INVERT	BIT(30)
+#define STARFIVE_CLK_MUX_MASK	GENMASK(27, 24)
+#define STARFIVE_CLK_MUX_SHIFT	24
+#define STARFIVE_CLK_DIV_MASK	GENMASK(23, 0)
+#define STARFIVE_CLK_FRAC_MASK	GENMASK(15, 8)
+#define STARFIVE_CLK_FRAC_SHIFT	8
+#define STARFIVE_CLK_INT_MASK	GENMASK(7, 0)
 
 /* fractional divider min/max */
-#define JH71X0_CLK_FRAC_MIN	100UL
-#define JH71X0_CLK_FRAC_MAX	25599UL
+#define STARFIVE_CLK_FRAC_MIN	100UL
+#define STARFIVE_CLK_FRAC_MAX	25599UL
 
 /* clock data */
-struct jh71x0_clk_data {
+struct starfive_clk_data {
 	const char *name;
 	unsigned long flags;
 	u32 max;
 	u8 parents[4];
 };
 
-#define JH71X0_GATE(_idx, _name, _flags, _parent)				\
+#define STARFIVE_GATE(_idx, _name, _flags, _parent)				\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = CLK_SET_RATE_PARENT | (_flags),				\
-	.max = JH71X0_CLK_ENABLE,						\
+	.max = STARFIVE_CLK_ENABLE,						\
 	.parents = { [0] = _parent },						\
 }
 
-#define JH71X0__DIV(_idx, _name, _max, _parent)					\
+#define STARFIVE__DIV(_idx, _name, _max, _parent)					\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = 0,								\
@@ -45,79 +45,79 @@ struct jh71x0_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
-#define JH71X0_GDIV(_idx, _name, _flags, _max, _parent)				\
+#define STARFIVE_GDIV(_idx, _name, _flags, _max, _parent)				\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = _flags,							\
-	.max = JH71X0_CLK_ENABLE | (_max),					\
+	.max = STARFIVE_CLK_ENABLE | (_max),					\
 	.parents = { [0] = _parent },						\
 }
 
-#define JH71X0_FDIV(_idx, _name, _parent)					\
+#define STARFIVE_FDIV(_idx, _name, _parent)					\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = 0,								\
-	.max = JH71X0_CLK_FRAC_MAX,						\
+	.max = STARFIVE_CLK_FRAC_MAX,						\
 	.parents = { [0] = _parent },						\
 }
 
-#define JH71X0__MUX(_idx, _name, _nparents, ...)				\
+#define STARFIVE__MUX(_idx, _name, _nparents, ...)				\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = 0,								\
-	.max = ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
+	.max = ((_nparents) - 1) << STARFIVE_CLK_MUX_SHIFT,			\
 	.parents = { __VA_ARGS__ },						\
 }
 
-#define JH71X0_GMUX(_idx, _name, _flags, _nparents, ...)			\
+#define STARFIVE_GMUX(_idx, _name, _flags, _nparents, ...)			\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = _flags,							\
-	.max = JH71X0_CLK_ENABLE |						\
-		(((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT),			\
+	.max = STARFIVE_CLK_ENABLE |						\
+		(((_nparents) - 1) << STARFIVE_CLK_MUX_SHIFT),			\
 	.parents = { __VA_ARGS__ },						\
 }
 
-#define JH71X0_MDIV(_idx, _name, _max, _nparents, ...)				\
+#define STARFIVE_MDIV(_idx, _name, _max, _nparents, ...)				\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = 0,								\
-	.max = (((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT) | (_max),		\
+	.max = (((_nparents) - 1) << STARFIVE_CLK_MUX_SHIFT) | (_max),		\
 	.parents = { __VA_ARGS__ },						\
 }
 
-#define JH71X0__GMD(_idx, _name, _flags, _max, _nparents, ...)			\
+#define STARFIVE__GMD(_idx, _name, _flags, _max, _nparents, ...)			\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = _flags,							\
-	.max = JH71X0_CLK_ENABLE |						\
-		(((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT) | (_max),		\
+	.max = STARFIVE_CLK_ENABLE |						\
+		(((_nparents) - 1) << STARFIVE_CLK_MUX_SHIFT) | (_max),		\
 	.parents = { __VA_ARGS__ },						\
 }
 
-#define JH71X0__INV(_idx, _name, _parent)					\
+#define STARFIVE__INV(_idx, _name, _parent)					\
 [_idx] = {									\
 	.name = _name,								\
 	.flags = CLK_SET_RATE_PARENT,						\
-	.max = JH71X0_CLK_INVERT,						\
+	.max = STARFIVE_CLK_INVERT,						\
 	.parents = { [0] = _parent },						\
 }
 
-struct jh71x0_clk {
+struct starfive_clk {
 	struct clk_hw hw;
 	unsigned int idx;
 	unsigned int max_div;
 };
 
-struct jh71x0_clk_priv {
+struct starfive_clk_priv {
 	/* protect clk enable and set rate/parent from happening at the same time */
 	spinlock_t rmw_lock;
 	struct device *dev;
 	void __iomem *base;
 	struct clk_hw *pll[3];
-	struct jh71x0_clk reg[];
+	struct starfive_clk reg[];
 };
 
-const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
+const struct clk_ops *starfive_clk_ops(u32 max);
 
 #endif
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index dc4c278606d7..dfe2befddce5 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -27,66 +27,68 @@
 #define JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD	(JH7100_AUDCLK_END + 6)
 #define JH7100_AUDCLK_VAD_INTMEM                (JH7100_AUDCLK_END + 7)
 
-static const struct jh71x0_clk_data jh7100_audclk_data[] = {
-	JH71X0__GMD(JH7100_AUDCLK_ADC_MCLK, "adc_mclk", 0, 15, 2,
-		    JH7100_AUDCLK_AUDIO_SRC,
-		    JH7100_AUDCLK_AUDIO_12288),
-	JH71X0__GMD(JH7100_AUDCLK_I2S1_MCLK, "i2s1_mclk", 0, 15, 2,
-		    JH7100_AUDCLK_AUDIO_SRC,
-		    JH7100_AUDCLK_AUDIO_12288),
-	JH71X0_GATE(JH7100_AUDCLK_I2SADC_APB, "i2sadc_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0_MDIV(JH7100_AUDCLK_I2SADC_BCLK, "i2sadc_bclk", 31, 2,
-		    JH7100_AUDCLK_ADC_MCLK,
-		    JH7100_AUDCLK_I2SADC_BCLK_IOPAD),
-	JH71X0__INV(JH7100_AUDCLK_I2SADC_BCLK_N, "i2sadc_bclk_n", JH7100_AUDCLK_I2SADC_BCLK),
-	JH71X0_MDIV(JH7100_AUDCLK_I2SADC_LRCLK, "i2sadc_lrclk", 63, 3,
-		    JH7100_AUDCLK_I2SADC_BCLK_N,
-		    JH7100_AUDCLK_I2SADC_LRCLK_IOPAD,
-		    JH7100_AUDCLK_I2SADC_BCLK),
-	JH71X0_GATE(JH7100_AUDCLK_PDM_APB, "pdm_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0__GMD(JH7100_AUDCLK_PDM_MCLK, "pdm_mclk", 0, 15, 2,
-		    JH7100_AUDCLK_AUDIO_SRC,
-		    JH7100_AUDCLK_AUDIO_12288),
-	JH71X0_GATE(JH7100_AUDCLK_I2SVAD_APB, "i2svad_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0__GMD(JH7100_AUDCLK_SPDIF, "spdif", 0, 15, 2,
-		    JH7100_AUDCLK_AUDIO_SRC,
-		    JH7100_AUDCLK_AUDIO_12288),
-	JH71X0_GATE(JH7100_AUDCLK_SPDIF_APB, "spdif_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0_GATE(JH7100_AUDCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0__GMD(JH7100_AUDCLK_DAC_MCLK, "dac_mclk", 0, 15, 2,
-		    JH7100_AUDCLK_AUDIO_SRC,
-		    JH7100_AUDCLK_AUDIO_12288),
-	JH71X0_GATE(JH7100_AUDCLK_I2SDAC_APB, "i2sdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0_MDIV(JH7100_AUDCLK_I2SDAC_BCLK, "i2sdac_bclk", 31, 2,
-		    JH7100_AUDCLK_DAC_MCLK,
-		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
-	JH71X0__INV(JH7100_AUDCLK_I2SDAC_BCLK_N, "i2sdac_bclk_n", JH7100_AUDCLK_I2SDAC_BCLK),
-	JH71X0_MDIV(JH7100_AUDCLK_I2SDAC_LRCLK, "i2sdac_lrclk", 31, 2,
-		    JH7100_AUDCLK_I2S1_MCLK,
-		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
-	JH71X0_GATE(JH7100_AUDCLK_I2S1_APB, "i2s1_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0_MDIV(JH7100_AUDCLK_I2S1_BCLK, "i2s1_bclk", 31, 2,
-		    JH7100_AUDCLK_I2S1_MCLK,
-		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
-	JH71X0__INV(JH7100_AUDCLK_I2S1_BCLK_N, "i2s1_bclk_n", JH7100_AUDCLK_I2S1_BCLK),
-	JH71X0_MDIV(JH7100_AUDCLK_I2S1_LRCLK, "i2s1_lrclk", 63, 3,
-		    JH7100_AUDCLK_I2S1_BCLK_N,
-		    JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD),
-	JH71X0_GATE(JH7100_AUDCLK_I2SDAC16K_APB, "i2s1dac16k_apb", 0, JH7100_AUDCLK_APB0_BUS),
-	JH71X0__DIV(JH7100_AUDCLK_APB0_BUS, "apb0_bus", 8, JH7100_AUDCLK_DOM7AHB_BUS),
-	JH71X0_GATE(JH7100_AUDCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7100_AUDCLK_DOM7AHB_BUS),
-	JH71X0_GATE(JH7100_AUDCLK_USB_APB, "usb_apb", CLK_IGNORE_UNUSED, JH7100_AUDCLK_APB_EN),
-	JH71X0_GDIV(JH7100_AUDCLK_USB_LPM, "usb_lpm", CLK_IGNORE_UNUSED, 4, JH7100_AUDCLK_USB_APB),
-	JH71X0_GDIV(JH7100_AUDCLK_USB_STB, "usb_stb", CLK_IGNORE_UNUSED, 3, JH7100_AUDCLK_USB_APB),
-	JH71X0__DIV(JH7100_AUDCLK_APB_EN, "apb_en", 8, JH7100_AUDCLK_DOM7AHB_BUS),
-	JH71X0__MUX(JH7100_AUDCLK_VAD_MEM, "vad_mem", 2,
-		    JH7100_AUDCLK_VAD_INTMEM,
-		    JH7100_AUDCLK_AUDIO_12288),
+static const struct starfive_clk_data jh7100_audclk_data[] = {
+	STARFIVE__GMD(JH7100_AUDCLK_ADC_MCLK, "adc_mclk", 0, 15, 2,
+		      JH7100_AUDCLK_AUDIO_SRC,
+		      JH7100_AUDCLK_AUDIO_12288),
+	STARFIVE__GMD(JH7100_AUDCLK_I2S1_MCLK, "i2s1_mclk", 0, 15, 2,
+		      JH7100_AUDCLK_AUDIO_SRC,
+		      JH7100_AUDCLK_AUDIO_12288),
+	STARFIVE_GATE(JH7100_AUDCLK_I2SADC_APB, "i2sadc_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2SADC_BCLK, "i2sadc_bclk", 31, 2,
+		      JH7100_AUDCLK_ADC_MCLK,
+		      JH7100_AUDCLK_I2SADC_BCLK_IOPAD),
+	STARFIVE__INV(JH7100_AUDCLK_I2SADC_BCLK_N, "i2sadc_bclk_n", JH7100_AUDCLK_I2SADC_BCLK),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2SADC_LRCLK, "i2sadc_lrclk", 63, 3,
+		      JH7100_AUDCLK_I2SADC_BCLK_N,
+		      JH7100_AUDCLK_I2SADC_LRCLK_IOPAD,
+		      JH7100_AUDCLK_I2SADC_BCLK),
+	STARFIVE_GATE(JH7100_AUDCLK_PDM_APB, "pdm_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE__GMD(JH7100_AUDCLK_PDM_MCLK, "pdm_mclk", 0, 15, 2,
+		      JH7100_AUDCLK_AUDIO_SRC,
+		      JH7100_AUDCLK_AUDIO_12288),
+	STARFIVE_GATE(JH7100_AUDCLK_I2SVAD_APB, "i2svad_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE__GMD(JH7100_AUDCLK_SPDIF, "spdif", 0, 15, 2,
+		      JH7100_AUDCLK_AUDIO_SRC,
+		      JH7100_AUDCLK_AUDIO_12288),
+	STARFIVE_GATE(JH7100_AUDCLK_SPDIF_APB, "spdif_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE_GATE(JH7100_AUDCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE__GMD(JH7100_AUDCLK_DAC_MCLK, "dac_mclk", 0, 15, 2,
+		      JH7100_AUDCLK_AUDIO_SRC,
+		      JH7100_AUDCLK_AUDIO_12288),
+	STARFIVE_GATE(JH7100_AUDCLK_I2SDAC_APB, "i2sdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2SDAC_BCLK, "i2sdac_bclk", 31, 2,
+		      JH7100_AUDCLK_DAC_MCLK,
+		      JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	STARFIVE__INV(JH7100_AUDCLK_I2SDAC_BCLK_N, "i2sdac_bclk_n", JH7100_AUDCLK_I2SDAC_BCLK),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2SDAC_LRCLK, "i2sdac_lrclk", 31, 2,
+		      JH7100_AUDCLK_I2S1_MCLK,
+		      JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	STARFIVE_GATE(JH7100_AUDCLK_I2S1_APB, "i2s1_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2S1_BCLK, "i2s1_bclk", 31, 2,
+		      JH7100_AUDCLK_I2S1_MCLK,
+		      JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	STARFIVE__INV(JH7100_AUDCLK_I2S1_BCLK_N, "i2s1_bclk_n", JH7100_AUDCLK_I2S1_BCLK),
+	STARFIVE_MDIV(JH7100_AUDCLK_I2S1_LRCLK, "i2s1_lrclk", 63, 3,
+		      JH7100_AUDCLK_I2S1_BCLK_N,
+		      JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD),
+	STARFIVE_GATE(JH7100_AUDCLK_I2SDAC16K_APB, "i2s1dac16k_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	STARFIVE__DIV(JH7100_AUDCLK_APB0_BUS, "apb0_bus", 8, JH7100_AUDCLK_DOM7AHB_BUS),
+	STARFIVE_GATE(JH7100_AUDCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7100_AUDCLK_DOM7AHB_BUS),
+	STARFIVE_GATE(JH7100_AUDCLK_USB_APB, "usb_apb", CLK_IGNORE_UNUSED, JH7100_AUDCLK_APB_EN),
+	STARFIVE_GDIV(JH7100_AUDCLK_USB_LPM, "usb_lpm", CLK_IGNORE_UNUSED, 4,
+		      JH7100_AUDCLK_USB_APB),
+	STARFIVE_GDIV(JH7100_AUDCLK_USB_STB, "usb_stb", CLK_IGNORE_UNUSED, 3,
+		      JH7100_AUDCLK_USB_APB),
+	STARFIVE__DIV(JH7100_AUDCLK_APB_EN, "apb_en", 8, JH7100_AUDCLK_DOM7AHB_BUS),
+	STARFIVE__MUX(JH7100_AUDCLK_VAD_MEM, "vad_mem", 2,
+		      JH7100_AUDCLK_VAD_INTMEM,
+		      JH7100_AUDCLK_AUDIO_12288),
 };
 
 static struct clk_hw *jh7100_audclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7100_AUDCLK_END)
@@ -97,7 +99,7 @@ static struct clk_hw *jh7100_audclk_get(struct of_phandle_args *clkspec, void *d
 
 static int jh7100_audclk_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	unsigned int idx;
 	int ret;
 
@@ -116,12 +118,13 @@ static int jh7100_audclk_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7100_audclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
-			.num_parents = ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.num_parents = ((max & STARFIVE_CLK_MUX_MASK)
+					>> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7100_audclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 
 		for (i = 0; i < init.num_parents; i++) {
@@ -139,7 +142,7 @@ static int jh7100_audclk_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(priv->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 6bb6a6af9f28..946a437f534b 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -23,253 +23,257 @@
 #define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + 2)
 #define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + 3)
 
-static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
-	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 4,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL1_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_DLA_ROOT, "dla_root", 3,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL1_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_DSP_ROOT, "dsp_root", 4,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL1_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_GMACUSB_ROOT, "gmacusb_root", 3,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_PERH0_ROOT, "perh0_root", 2,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL0_OUT),
-	JH71X0__MUX(JH7100_CLK_PERH1_ROOT, "perh1_root", 2,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_VIN_ROOT, "vin_root", 3,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL1_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_VOUT_ROOT, "vout_root", 3,
-		    JH7100_CLK_OSC_AUD,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0_GDIV(JH7100_CLK_AUDIO_ROOT, "audio_root", 0, 8, JH7100_CLK_PLL0_OUT),
-	JH71X0__MUX(JH7100_CLK_CDECHIFI4_ROOT, "cdechifi4_root", 3,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL1_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_CDEC_ROOT, "cdec_root", 3,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL1_OUT),
-	JH71X0__MUX(JH7100_CLK_VOUTBUS_ROOT, "voutbus_root", 3,
-		    JH7100_CLK_OSC_AUD,
-		    JH7100_CLK_PLL0_OUT,
-		    JH7100_CLK_PLL2_OUT),
-	JH71X0__DIV(JH7100_CLK_CPUNBUS_ROOT_DIV, "cpunbus_root_div", 2, JH7100_CLK_CPUNDBUS_ROOT),
-	JH71X0__DIV(JH7100_CLK_DSP_ROOT_DIV, "dsp_root_div", 4, JH7100_CLK_DSP_ROOT),
-	JH71X0__DIV(JH7100_CLK_PERH0_SRC, "perh0_src", 4, JH7100_CLK_PERH0_ROOT),
-	JH71X0__DIV(JH7100_CLK_PERH1_SRC, "perh1_src", 4, JH7100_CLK_PERH1_ROOT),
-	JH71X0_GDIV(JH7100_CLK_PLL0_TESTOUT, "pll0_testout", 0, 31, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_PLL1_TESTOUT, "pll1_testout", 0, 31, JH7100_CLK_DLA_ROOT),
-	JH71X0_GDIV(JH7100_CLK_PLL2_TESTOUT, "pll2_testout", 0, 31, JH7100_CLK_PERH1_SRC),
-	JH71X0__MUX(JH7100_CLK_PLL2_REF, "pll2_refclk", 2,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_OSC_AUD),
-	JH71X0__DIV(JH7100_CLK_CPU_CORE, "cpu_core", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0__DIV(JH7100_CLK_CPU_AXI, "cpu_axi", 8, JH7100_CLK_CPU_CORE),
-	JH71X0__DIV(JH7100_CLK_AHB_BUS, "ahb_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0__DIV(JH7100_CLK_APB1_BUS, "apb1_bus", 8, JH7100_CLK_AHB_BUS),
-	JH71X0__DIV(JH7100_CLK_APB2_BUS, "apb2_bus", 8, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_DOM3AHB_BUS, "dom3ahb_bus", CLK_IS_CRITICAL, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_DOM7AHB_BUS, "dom7ahb_bus", CLK_IS_CRITICAL, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_U74_CORE0, "u74_core0", CLK_IS_CRITICAL, JH7100_CLK_CPU_CORE),
-	JH71X0_GDIV(JH7100_CLK_U74_CORE1, "u74_core1", CLK_IS_CRITICAL, 8, JH7100_CLK_CPU_CORE),
-	JH71X0_GATE(JH7100_CLK_U74_AXI, "u74_axi", CLK_IS_CRITICAL, JH7100_CLK_CPU_AXI),
-	JH71X0_GATE(JH7100_CLK_U74RTC_TOGGLE, "u74rtc_toggle", CLK_IS_CRITICAL, JH7100_CLK_OSC_SYS),
-	JH71X0_GATE(JH7100_CLK_SGDMA2P_AXI, "sgdma2p_axi", 0, JH7100_CLK_CPU_AXI),
-	JH71X0_GATE(JH7100_CLK_DMA2PNOC_AXI, "dma2pnoc_axi", 0, JH7100_CLK_CPU_AXI),
-	JH71X0_GATE(JH7100_CLK_SGDMA2P_AHB, "sgdma2p_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0__DIV(JH7100_CLK_DLA_BUS, "dla_bus", 4, JH7100_CLK_DLA_ROOT),
-	JH71X0_GATE(JH7100_CLK_DLA_AXI, "dla_axi", 0, JH7100_CLK_DLA_BUS),
-	JH71X0_GATE(JH7100_CLK_DLANOC_AXI, "dlanoc_axi", 0, JH7100_CLK_DLA_BUS),
-	JH71X0_GATE(JH7100_CLK_DLA_APB, "dla_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_VP6_CORE, "vp6_core", 0, 4, JH7100_CLK_DSP_ROOT_DIV),
-	JH71X0__DIV(JH7100_CLK_VP6BUS_SRC, "vp6bus_src", 4, JH7100_CLK_DSP_ROOT),
-	JH71X0_GDIV(JH7100_CLK_VP6_AXI, "vp6_axi", 0, 4, JH7100_CLK_VP6BUS_SRC),
-	JH71X0__DIV(JH7100_CLK_VCDECBUS_SRC, "vcdecbus_src", 4, JH7100_CLK_CDECHIFI4_ROOT),
-	JH71X0__DIV(JH7100_CLK_VDEC_BUS, "vdec_bus", 8, JH7100_CLK_VCDECBUS_SRC),
-	JH71X0_GATE(JH7100_CLK_VDEC_AXI, "vdec_axi", 0, JH7100_CLK_VDEC_BUS),
-	JH71X0_GATE(JH7100_CLK_VDECBRG_MAIN, "vdecbrg_mainclk", 0, JH7100_CLK_VDEC_BUS),
-	JH71X0_GDIV(JH7100_CLK_VDEC_BCLK, "vdec_bclk", 0, 8, JH7100_CLK_VCDECBUS_SRC),
-	JH71X0_GDIV(JH7100_CLK_VDEC_CCLK, "vdec_cclk", 0, 8, JH7100_CLK_CDEC_ROOT),
-	JH71X0_GATE(JH7100_CLK_VDEC_APB, "vdec_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_JPEG_AXI, "jpeg_axi", 0, 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0_GDIV(JH7100_CLK_JPEG_CCLK, "jpeg_cclk", 0, 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0_GATE(JH7100_CLK_JPEG_APB, "jpeg_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_GC300_2X, "gc300_2x", 0, 8, JH7100_CLK_CDECHIFI4_ROOT),
-	JH71X0_GATE(JH7100_CLK_GC300_AHB, "gc300_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0__DIV(JH7100_CLK_JPCGC300_AXIBUS, "jpcgc300_axibus", 8, JH7100_CLK_VCDECBUS_SRC),
-	JH71X0_GATE(JH7100_CLK_GC300_AXI, "gc300_axi", 0, JH7100_CLK_JPCGC300_AXIBUS),
-	JH71X0_GATE(JH7100_CLK_JPCGC300_MAIN, "jpcgc300_mainclk", 0, JH7100_CLK_JPCGC300_AXIBUS),
-	JH71X0__DIV(JH7100_CLK_VENC_BUS, "venc_bus", 8, JH7100_CLK_VCDECBUS_SRC),
-	JH71X0_GATE(JH7100_CLK_VENC_AXI, "venc_axi", 0, JH7100_CLK_VENC_BUS),
-	JH71X0_GATE(JH7100_CLK_VENCBRG_MAIN, "vencbrg_mainclk", 0, JH7100_CLK_VENC_BUS),
-	JH71X0_GDIV(JH7100_CLK_VENC_BCLK, "venc_bclk", 0, 8, JH7100_CLK_VCDECBUS_SRC),
-	JH71X0_GDIV(JH7100_CLK_VENC_CCLK, "venc_cclk", 0, 8, JH7100_CLK_CDEC_ROOT),
-	JH71X0_GATE(JH7100_CLK_VENC_APB, "venc_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_DDRPLL_DIV2, "ddrpll_div2", CLK_IS_CRITICAL, 2, JH7100_CLK_PLL1_OUT),
-	JH71X0_GDIV(JH7100_CLK_DDRPLL_DIV4, "ddrpll_div4", CLK_IS_CRITICAL, 2,
-		    JH7100_CLK_DDRPLL_DIV2),
-	JH71X0_GDIV(JH7100_CLK_DDRPLL_DIV8, "ddrpll_div8", CLK_IS_CRITICAL, 2,
-		    JH7100_CLK_DDRPLL_DIV4),
-	JH71X0_GDIV(JH7100_CLK_DDROSC_DIV2, "ddrosc_div2", CLK_IS_CRITICAL, 2, JH7100_CLK_OSC_SYS),
-	JH71X0_GMUX(JH7100_CLK_DDRC0, "ddrc0", CLK_IS_CRITICAL, 4,
-		    JH7100_CLK_DDROSC_DIV2,
-		    JH7100_CLK_DDRPLL_DIV2,
-		    JH7100_CLK_DDRPLL_DIV4,
-		    JH7100_CLK_DDRPLL_DIV8),
-	JH71X0_GMUX(JH7100_CLK_DDRC1, "ddrc1", CLK_IS_CRITICAL, 4,
-		    JH7100_CLK_DDROSC_DIV2,
-		    JH7100_CLK_DDRPLL_DIV2,
-		    JH7100_CLK_DDRPLL_DIV4,
-		    JH7100_CLK_DDRPLL_DIV8),
-	JH71X0_GATE(JH7100_CLK_DDRPHY_APB, "ddrphy_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0__DIV(JH7100_CLK_NOC_ROB, "noc_rob", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0__DIV(JH7100_CLK_NOC_COG, "noc_cog", 8, JH7100_CLK_DLA_ROOT),
-	JH71X0_GATE(JH7100_CLK_NNE_AHB, "nne_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0__DIV(JH7100_CLK_NNEBUS_SRC1, "nnebus_src1", 4, JH7100_CLK_DSP_ROOT),
-	JH71X0__MUX(JH7100_CLK_NNE_BUS, "nne_bus", 2,
-		    JH7100_CLK_CPU_AXI,
-		    JH7100_CLK_NNEBUS_SRC1),
-	JH71X0_GATE(JH7100_CLK_NNE_AXI, "nne_axi", 0, JH7100_CLK_NNE_BUS),
-	JH71X0_GATE(JH7100_CLK_NNENOC_AXI, "nnenoc_axi", 0, JH7100_CLK_NNE_BUS),
-	JH71X0_GATE(JH7100_CLK_DLASLV_AXI, "dlaslv_axi", 0, JH7100_CLK_NNE_BUS),
-	JH71X0_GATE(JH7100_CLK_DSPX2C_AXI, "dspx2c_axi", CLK_IS_CRITICAL, JH7100_CLK_NNE_BUS),
-	JH71X0__DIV(JH7100_CLK_HIFI4_SRC, "hifi4_src", 4, JH7100_CLK_CDECHIFI4_ROOT),
-	JH71X0__DIV(JH7100_CLK_HIFI4_COREFREE, "hifi4_corefree", 8, JH7100_CLK_HIFI4_SRC),
-	JH71X0_GATE(JH7100_CLK_HIFI4_CORE, "hifi4_core", 0, JH7100_CLK_HIFI4_COREFREE),
-	JH71X0__DIV(JH7100_CLK_HIFI4_BUS, "hifi4_bus", 8, JH7100_CLK_HIFI4_COREFREE),
-	JH71X0_GATE(JH7100_CLK_HIFI4_AXI, "hifi4_axi", 0, JH7100_CLK_HIFI4_BUS),
-	JH71X0_GATE(JH7100_CLK_HIFI4NOC_AXI, "hifi4noc_axi", 0, JH7100_CLK_HIFI4_BUS),
-	JH71X0__DIV(JH7100_CLK_SGDMA1P_BUS, "sgdma1p_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0_GATE(JH7100_CLK_SGDMA1P_AXI, "sgdma1p_axi", 0, JH7100_CLK_SGDMA1P_BUS),
-	JH71X0_GATE(JH7100_CLK_DMA1P_AXI, "dma1p_axi", 0, JH7100_CLK_SGDMA1P_BUS),
-	JH71X0_GDIV(JH7100_CLK_X2C_AXI, "x2c_axi", CLK_IS_CRITICAL, 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0__DIV(JH7100_CLK_USB_BUS, "usb_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
-	JH71X0_GATE(JH7100_CLK_USB_AXI, "usb_axi", 0, JH7100_CLK_USB_BUS),
-	JH71X0_GATE(JH7100_CLK_USBNOC_AXI, "usbnoc_axi", 0, JH7100_CLK_USB_BUS),
-	JH71X0__DIV(JH7100_CLK_USBPHY_ROOTDIV, "usbphy_rootdiv", 4, JH7100_CLK_GMACUSB_ROOT),
-	JH71X0_GDIV(JH7100_CLK_USBPHY_125M, "usbphy_125m", 0, 8, JH7100_CLK_USBPHY_ROOTDIV),
-	JH71X0_GDIV(JH7100_CLK_USBPHY_PLLDIV25M, "usbphy_plldiv25m", 0, 32,
-		    JH7100_CLK_USBPHY_ROOTDIV),
-	JH71X0__MUX(JH7100_CLK_USBPHY_25M, "usbphy_25m", 2,
-		    JH7100_CLK_OSC_SYS,
-		    JH7100_CLK_USBPHY_PLLDIV25M),
-	JH71X0_FDIV(JH7100_CLK_AUDIO_DIV, "audio_div", JH7100_CLK_AUDIO_ROOT),
-	JH71X0_GATE(JH7100_CLK_AUDIO_SRC, "audio_src", 0, JH7100_CLK_AUDIO_DIV),
-	JH71X0_GATE(JH7100_CLK_AUDIO_12288, "audio_12288", 0, JH7100_CLK_OSC_AUD),
-	JH71X0_GDIV(JH7100_CLK_VIN_SRC, "vin_src", 0, 4, JH7100_CLK_VIN_ROOT),
-	JH71X0__DIV(JH7100_CLK_ISP0_BUS, "isp0_bus", 8, JH7100_CLK_VIN_SRC),
-	JH71X0_GATE(JH7100_CLK_ISP0_AXI, "isp0_axi", 0, JH7100_CLK_ISP0_BUS),
-	JH71X0_GATE(JH7100_CLK_ISP0NOC_AXI, "isp0noc_axi", 0, JH7100_CLK_ISP0_BUS),
-	JH71X0_GATE(JH7100_CLK_ISPSLV_AXI, "ispslv_axi", 0, JH7100_CLK_ISP0_BUS),
-	JH71X0__DIV(JH7100_CLK_ISP1_BUS, "isp1_bus", 8, JH7100_CLK_VIN_SRC),
-	JH71X0_GATE(JH7100_CLK_ISP1_AXI, "isp1_axi", 0, JH7100_CLK_ISP1_BUS),
-	JH71X0_GATE(JH7100_CLK_ISP1NOC_AXI, "isp1noc_axi", 0, JH7100_CLK_ISP1_BUS),
-	JH71X0__DIV(JH7100_CLK_VIN_BUS, "vin_bus", 8, JH7100_CLK_VIN_SRC),
-	JH71X0_GATE(JH7100_CLK_VIN_AXI, "vin_axi", 0, JH7100_CLK_VIN_BUS),
-	JH71X0_GATE(JH7100_CLK_VINNOC_AXI, "vinnoc_axi", 0, JH7100_CLK_VIN_BUS),
-	JH71X0_GDIV(JH7100_CLK_VOUT_SRC, "vout_src", 0, 4, JH7100_CLK_VOUT_ROOT),
-	JH71X0__DIV(JH7100_CLK_DISPBUS_SRC, "dispbus_src", 4, JH7100_CLK_VOUTBUS_ROOT),
-	JH71X0__DIV(JH7100_CLK_DISP_BUS, "disp_bus", 4, JH7100_CLK_DISPBUS_SRC),
-	JH71X0_GATE(JH7100_CLK_DISP_AXI, "disp_axi", 0, JH7100_CLK_DISP_BUS),
-	JH71X0_GATE(JH7100_CLK_DISPNOC_AXI, "dispnoc_axi", 0, JH7100_CLK_DISP_BUS),
-	JH71X0_GATE(JH7100_CLK_SDIO0_AHB, "sdio0_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GDIV(JH7100_CLK_SDIO0_CCLKINT, "sdio0_cclkint", 0, 24, JH7100_CLK_PERH0_SRC),
-	JH71X0__INV(JH7100_CLK_SDIO0_CCLKINT_INV, "sdio0_cclkint_inv", JH7100_CLK_SDIO0_CCLKINT),
-	JH71X0_GATE(JH7100_CLK_SDIO1_AHB, "sdio1_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GDIV(JH7100_CLK_SDIO1_CCLKINT, "sdio1_cclkint", 0, 24, JH7100_CLK_PERH1_SRC),
-	JH71X0__INV(JH7100_CLK_SDIO1_CCLKINT_INV, "sdio1_cclkint_inv", JH7100_CLK_SDIO1_CCLKINT),
-	JH71X0_GATE(JH7100_CLK_GMAC_AHB, "gmac_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0__DIV(JH7100_CLK_GMAC_ROOT_DIV, "gmac_root_div", 8, JH7100_CLK_GMACUSB_ROOT),
-	JH71X0_GDIV(JH7100_CLK_GMAC_PTP_REF, "gmac_ptp_refclk", 0, 31, JH7100_CLK_GMAC_ROOT_DIV),
-	JH71X0_GDIV(JH7100_CLK_GMAC_GTX, "gmac_gtxclk", 0, 255, JH7100_CLK_GMAC_ROOT_DIV),
-	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_TX, "gmac_rmii_txclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
-	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_RX, "gmac_rmii_rxclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
-	JH71X0__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", 3,
-		    JH7100_CLK_GMAC_GTX,
-		    JH7100_CLK_GMAC_TX_INV,
-		    JH7100_CLK_GMAC_RMII_TX),
-	JH71X0__INV(JH7100_CLK_GMAC_TX_INV, "gmac_tx_inv", JH7100_CLK_GMAC_TX),
-	JH71X0__MUX(JH7100_CLK_GMAC_RX_PRE, "gmac_rx_pre", 2,
-		    JH7100_CLK_GMAC_GR_MII_RX,
-		    JH7100_CLK_GMAC_RMII_RX),
-	JH71X0__INV(JH7100_CLK_GMAC_RX_INV, "gmac_rx_inv", JH7100_CLK_GMAC_RX_PRE),
-	JH71X0_GATE(JH7100_CLK_GMAC_RMII, "gmac_rmii", 0, JH7100_CLK_GMAC_RMII_REF),
-	JH71X0_GDIV(JH7100_CLK_GMAC_TOPHYREF, "gmac_tophyref", 0, 127, JH7100_CLK_GMAC_ROOT_DIV),
-	JH71X0_GATE(JH7100_CLK_SPI2AHB_AHB, "spi2ahb_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GDIV(JH7100_CLK_SPI2AHB_CORE, "spi2ahb_core", 0, 31, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_EZMASTER_AHB, "ezmaster_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_E24_AHB, "e24_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_E24RTC_TOGGLE, "e24rtc_toggle", 0, JH7100_CLK_OSC_SYS),
-	JH71X0_GATE(JH7100_CLK_QSPI_AHB, "qspi_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_QSPI_APB, "qspi_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_QSPI_REF, "qspi_refclk", 0, 31, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_SEC_AHB, "sec_ahb", 0, JH7100_CLK_AHB_BUS),
-	JH71X0_GATE(JH7100_CLK_AES, "aes_clk", 0, JH7100_CLK_SEC_AHB),
-	JH71X0_GATE(JH7100_CLK_SHA, "sha_clk", 0, JH7100_CLK_SEC_AHB),
-	JH71X0_GATE(JH7100_CLK_PKA, "pka_clk", 0, JH7100_CLK_SEC_AHB),
-	JH71X0_GATE(JH7100_CLK_TRNG_APB, "trng_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GATE(JH7100_CLK_OTP_APB, "otp_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GATE(JH7100_CLK_UART0_APB, "uart0_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_UART0_CORE, "uart0_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_UART1_APB, "uart1_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_UART1_CORE, "uart1_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_SPI0_APB, "spi0_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_SPI0_CORE, "spi0_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_SPI1_APB, "spi1_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_SPI1_CORE, "spi1_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_I2C0_APB, "i2c0_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_I2C0_CORE, "i2c0_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_I2C1_APB, "i2c1_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GDIV(JH7100_CLK_I2C1_CORE, "i2c1_core", 0, 63, JH7100_CLK_PERH1_SRC),
-	JH71X0_GATE(JH7100_CLK_GPIO_APB, "gpio_apb", 0, JH7100_CLK_APB1_BUS),
-	JH71X0_GATE(JH7100_CLK_UART2_APB, "uart2_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_UART2_CORE, "uart2_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_UART3_APB, "uart3_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_UART3_CORE, "uart3_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_SPI2_APB, "spi2_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_SPI2_CORE, "spi2_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_SPI3_APB, "spi3_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_SPI3_CORE, "spi3_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_I2C2_APB, "i2c2_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_I2C2_CORE, "i2c2_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_I2C3_APB, "i2c3_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_I2C3_CORE, "i2c3_core", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_WDTIMER_APB, "wdtimer_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_WDT_CORE, "wdt_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER0_CORE, "timer0_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER1_CORE, "timer1_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER2_CORE, "timer2_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER3_CORE, "timer3_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER4_CORE, "timer4_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER5_CORE, "timer5_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GDIV(JH7100_CLK_TIMER6_CORE, "timer6_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
-	JH71X0_GATE(JH7100_CLK_VP6INTC_APB, "vp6intc_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GATE(JH7100_CLK_PWM_APB, "pwm_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GATE(JH7100_CLK_MSI_APB, "msi_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GATE(JH7100_CLK_TEMP_APB, "temp_apb", 0, JH7100_CLK_APB2_BUS),
-	JH71X0_GDIV(JH7100_CLK_TEMP_SENSE, "temp_sense", 0, 31, JH7100_CLK_OSC_SYS),
-	JH71X0_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS),
+static const struct starfive_clk_data jh7100_clk_data[] __initconst = {
+	STARFIVE__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 4,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL1_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_DLA_ROOT, "dla_root", 3,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL1_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_DSP_ROOT, "dsp_root", 4,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL1_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_GMACUSB_ROOT, "gmacusb_root", 3,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_PERH0_ROOT, "perh0_root", 2,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL0_OUT),
+	STARFIVE__MUX(JH7100_CLK_PERH1_ROOT, "perh1_root", 2,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_VIN_ROOT, "vin_root", 3,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL1_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_VOUT_ROOT, "vout_root", 3,
+		      JH7100_CLK_OSC_AUD,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE_GDIV(JH7100_CLK_AUDIO_ROOT, "audio_root", 0, 8, JH7100_CLK_PLL0_OUT),
+	STARFIVE__MUX(JH7100_CLK_CDECHIFI4_ROOT, "cdechifi4_root", 3,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL1_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__MUX(JH7100_CLK_CDEC_ROOT, "cdec_root", 3,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL1_OUT),
+	STARFIVE__MUX(JH7100_CLK_VOUTBUS_ROOT, "voutbus_root", 3,
+		      JH7100_CLK_OSC_AUD,
+		      JH7100_CLK_PLL0_OUT,
+		      JH7100_CLK_PLL2_OUT),
+	STARFIVE__DIV(JH7100_CLK_CPUNBUS_ROOT_DIV, "cpunbus_root_div", 2, JH7100_CLK_CPUNDBUS_ROOT),
+	STARFIVE__DIV(JH7100_CLK_DSP_ROOT_DIV, "dsp_root_div", 4, JH7100_CLK_DSP_ROOT),
+	STARFIVE__DIV(JH7100_CLK_PERH0_SRC, "perh0_src", 4, JH7100_CLK_PERH0_ROOT),
+	STARFIVE__DIV(JH7100_CLK_PERH1_SRC, "perh1_src", 4, JH7100_CLK_PERH1_ROOT),
+	STARFIVE_GDIV(JH7100_CLK_PLL0_TESTOUT, "pll0_testout", 0, 31, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_PLL1_TESTOUT, "pll1_testout", 0, 31, JH7100_CLK_DLA_ROOT),
+	STARFIVE_GDIV(JH7100_CLK_PLL2_TESTOUT, "pll2_testout", 0, 31, JH7100_CLK_PERH1_SRC),
+	STARFIVE__MUX(JH7100_CLK_PLL2_REF, "pll2_refclk", 2,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_OSC_AUD),
+	STARFIVE__DIV(JH7100_CLK_CPU_CORE, "cpu_core", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE__DIV(JH7100_CLK_CPU_AXI, "cpu_axi", 8, JH7100_CLK_CPU_CORE),
+	STARFIVE__DIV(JH7100_CLK_AHB_BUS, "ahb_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE__DIV(JH7100_CLK_APB1_BUS, "apb1_bus", 8, JH7100_CLK_AHB_BUS),
+	STARFIVE__DIV(JH7100_CLK_APB2_BUS, "apb2_bus", 8, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_DOM3AHB_BUS, "dom3ahb_bus", CLK_IS_CRITICAL, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_DOM7AHB_BUS, "dom7ahb_bus", CLK_IS_CRITICAL, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_U74_CORE0, "u74_core0", CLK_IS_CRITICAL, JH7100_CLK_CPU_CORE),
+	STARFIVE_GDIV(JH7100_CLK_U74_CORE1, "u74_core1", CLK_IS_CRITICAL, 8, JH7100_CLK_CPU_CORE),
+	STARFIVE_GATE(JH7100_CLK_U74_AXI, "u74_axi", CLK_IS_CRITICAL, JH7100_CLK_CPU_AXI),
+	STARFIVE_GATE(JH7100_CLK_U74RTC_TOGGLE, "u74rtc_toggle", CLK_IS_CRITICAL,
+		      JH7100_CLK_OSC_SYS),
+	STARFIVE_GATE(JH7100_CLK_SGDMA2P_AXI, "sgdma2p_axi", 0, JH7100_CLK_CPU_AXI),
+	STARFIVE_GATE(JH7100_CLK_DMA2PNOC_AXI, "dma2pnoc_axi", 0, JH7100_CLK_CPU_AXI),
+	STARFIVE_GATE(JH7100_CLK_SGDMA2P_AHB, "sgdma2p_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE__DIV(JH7100_CLK_DLA_BUS, "dla_bus", 4, JH7100_CLK_DLA_ROOT),
+	STARFIVE_GATE(JH7100_CLK_DLA_AXI, "dla_axi", 0, JH7100_CLK_DLA_BUS),
+	STARFIVE_GATE(JH7100_CLK_DLANOC_AXI, "dlanoc_axi", 0, JH7100_CLK_DLA_BUS),
+	STARFIVE_GATE(JH7100_CLK_DLA_APB, "dla_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_VP6_CORE, "vp6_core", 0, 4, JH7100_CLK_DSP_ROOT_DIV),
+	STARFIVE__DIV(JH7100_CLK_VP6BUS_SRC, "vp6bus_src", 4, JH7100_CLK_DSP_ROOT),
+	STARFIVE_GDIV(JH7100_CLK_VP6_AXI, "vp6_axi", 0, 4, JH7100_CLK_VP6BUS_SRC),
+	STARFIVE__DIV(JH7100_CLK_VCDECBUS_SRC, "vcdecbus_src", 4, JH7100_CLK_CDECHIFI4_ROOT),
+	STARFIVE__DIV(JH7100_CLK_VDEC_BUS, "vdec_bus", 8, JH7100_CLK_VCDECBUS_SRC),
+	STARFIVE_GATE(JH7100_CLK_VDEC_AXI, "vdec_axi", 0, JH7100_CLK_VDEC_BUS),
+	STARFIVE_GATE(JH7100_CLK_VDECBRG_MAIN, "vdecbrg_mainclk", 0, JH7100_CLK_VDEC_BUS),
+	STARFIVE_GDIV(JH7100_CLK_VDEC_BCLK, "vdec_bclk", 0, 8, JH7100_CLK_VCDECBUS_SRC),
+	STARFIVE_GDIV(JH7100_CLK_VDEC_CCLK, "vdec_cclk", 0, 8, JH7100_CLK_CDEC_ROOT),
+	STARFIVE_GATE(JH7100_CLK_VDEC_APB, "vdec_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_JPEG_AXI, "jpeg_axi", 0, 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE_GDIV(JH7100_CLK_JPEG_CCLK, "jpeg_cclk", 0, 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE_GATE(JH7100_CLK_JPEG_APB, "jpeg_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_GC300_2X, "gc300_2x", 0, 8, JH7100_CLK_CDECHIFI4_ROOT),
+	STARFIVE_GATE(JH7100_CLK_GC300_AHB, "gc300_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE__DIV(JH7100_CLK_JPCGC300_AXIBUS, "jpcgc300_axibus", 8, JH7100_CLK_VCDECBUS_SRC),
+	STARFIVE_GATE(JH7100_CLK_GC300_AXI, "gc300_axi", 0, JH7100_CLK_JPCGC300_AXIBUS),
+	STARFIVE_GATE(JH7100_CLK_JPCGC300_MAIN, "jpcgc300_mainclk", 0, JH7100_CLK_JPCGC300_AXIBUS),
+	STARFIVE__DIV(JH7100_CLK_VENC_BUS, "venc_bus", 8, JH7100_CLK_VCDECBUS_SRC),
+	STARFIVE_GATE(JH7100_CLK_VENC_AXI, "venc_axi", 0, JH7100_CLK_VENC_BUS),
+	STARFIVE_GATE(JH7100_CLK_VENCBRG_MAIN, "vencbrg_mainclk", 0, JH7100_CLK_VENC_BUS),
+	STARFIVE_GDIV(JH7100_CLK_VENC_BCLK, "venc_bclk", 0, 8, JH7100_CLK_VCDECBUS_SRC),
+	STARFIVE_GDIV(JH7100_CLK_VENC_CCLK, "venc_cclk", 0, 8, JH7100_CLK_CDEC_ROOT),
+	STARFIVE_GATE(JH7100_CLK_VENC_APB, "venc_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_DDRPLL_DIV2, "ddrpll_div2", CLK_IS_CRITICAL, 2,
+		      JH7100_CLK_PLL1_OUT),
+	STARFIVE_GDIV(JH7100_CLK_DDRPLL_DIV4, "ddrpll_div4", CLK_IS_CRITICAL, 2,
+		      JH7100_CLK_DDRPLL_DIV2),
+	STARFIVE_GDIV(JH7100_CLK_DDRPLL_DIV8, "ddrpll_div8", CLK_IS_CRITICAL, 2,
+		      JH7100_CLK_DDRPLL_DIV4),
+	STARFIVE_GDIV(JH7100_CLK_DDROSC_DIV2, "ddrosc_div2", CLK_IS_CRITICAL, 2,
+		      JH7100_CLK_OSC_SYS),
+	STARFIVE_GMUX(JH7100_CLK_DDRC0, "ddrc0", CLK_IS_CRITICAL, 4,
+		      JH7100_CLK_DDROSC_DIV2,
+		      JH7100_CLK_DDRPLL_DIV2,
+		      JH7100_CLK_DDRPLL_DIV4,
+		      JH7100_CLK_DDRPLL_DIV8),
+	STARFIVE_GMUX(JH7100_CLK_DDRC1, "ddrc1", CLK_IS_CRITICAL, 4,
+		      JH7100_CLK_DDROSC_DIV2,
+		      JH7100_CLK_DDRPLL_DIV2,
+		      JH7100_CLK_DDRPLL_DIV4,
+		      JH7100_CLK_DDRPLL_DIV8),
+	STARFIVE_GATE(JH7100_CLK_DDRPHY_APB, "ddrphy_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE__DIV(JH7100_CLK_NOC_ROB, "noc_rob", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE__DIV(JH7100_CLK_NOC_COG, "noc_cog", 8, JH7100_CLK_DLA_ROOT),
+	STARFIVE_GATE(JH7100_CLK_NNE_AHB, "nne_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE__DIV(JH7100_CLK_NNEBUS_SRC1, "nnebus_src1", 4, JH7100_CLK_DSP_ROOT),
+	STARFIVE__MUX(JH7100_CLK_NNE_BUS, "nne_bus", 2,
+		      JH7100_CLK_CPU_AXI,
+		      JH7100_CLK_NNEBUS_SRC1),
+	STARFIVE_GATE(JH7100_CLK_NNE_AXI, "nne_axi", 0, JH7100_CLK_NNE_BUS),
+	STARFIVE_GATE(JH7100_CLK_NNENOC_AXI, "nnenoc_axi", 0, JH7100_CLK_NNE_BUS),
+	STARFIVE_GATE(JH7100_CLK_DLASLV_AXI, "dlaslv_axi", 0, JH7100_CLK_NNE_BUS),
+	STARFIVE_GATE(JH7100_CLK_DSPX2C_AXI, "dspx2c_axi", CLK_IS_CRITICAL, JH7100_CLK_NNE_BUS),
+	STARFIVE__DIV(JH7100_CLK_HIFI4_SRC, "hifi4_src", 4, JH7100_CLK_CDECHIFI4_ROOT),
+	STARFIVE__DIV(JH7100_CLK_HIFI4_COREFREE, "hifi4_corefree", 8, JH7100_CLK_HIFI4_SRC),
+	STARFIVE_GATE(JH7100_CLK_HIFI4_CORE, "hifi4_core", 0, JH7100_CLK_HIFI4_COREFREE),
+	STARFIVE__DIV(JH7100_CLK_HIFI4_BUS, "hifi4_bus", 8, JH7100_CLK_HIFI4_COREFREE),
+	STARFIVE_GATE(JH7100_CLK_HIFI4_AXI, "hifi4_axi", 0, JH7100_CLK_HIFI4_BUS),
+	STARFIVE_GATE(JH7100_CLK_HIFI4NOC_AXI, "hifi4noc_axi", 0, JH7100_CLK_HIFI4_BUS),
+	STARFIVE__DIV(JH7100_CLK_SGDMA1P_BUS, "sgdma1p_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE_GATE(JH7100_CLK_SGDMA1P_AXI, "sgdma1p_axi", 0, JH7100_CLK_SGDMA1P_BUS),
+	STARFIVE_GATE(JH7100_CLK_DMA1P_AXI, "dma1p_axi", 0, JH7100_CLK_SGDMA1P_BUS),
+	STARFIVE_GDIV(JH7100_CLK_X2C_AXI, "x2c_axi", CLK_IS_CRITICAL, 8,
+		      JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE__DIV(JH7100_CLK_USB_BUS, "usb_bus", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
+	STARFIVE_GATE(JH7100_CLK_USB_AXI, "usb_axi", 0, JH7100_CLK_USB_BUS),
+	STARFIVE_GATE(JH7100_CLK_USBNOC_AXI, "usbnoc_axi", 0, JH7100_CLK_USB_BUS),
+	STARFIVE__DIV(JH7100_CLK_USBPHY_ROOTDIV, "usbphy_rootdiv", 4, JH7100_CLK_GMACUSB_ROOT),
+	STARFIVE_GDIV(JH7100_CLK_USBPHY_125M, "usbphy_125m", 0, 8, JH7100_CLK_USBPHY_ROOTDIV),
+	STARFIVE_GDIV(JH7100_CLK_USBPHY_PLLDIV25M, "usbphy_plldiv25m", 0, 32,
+		      JH7100_CLK_USBPHY_ROOTDIV),
+	STARFIVE__MUX(JH7100_CLK_USBPHY_25M, "usbphy_25m", 2,
+		      JH7100_CLK_OSC_SYS,
+		      JH7100_CLK_USBPHY_PLLDIV25M),
+	STARFIVE_FDIV(JH7100_CLK_AUDIO_DIV, "audio_div", JH7100_CLK_AUDIO_ROOT),
+	STARFIVE_GATE(JH7100_CLK_AUDIO_SRC, "audio_src", 0, JH7100_CLK_AUDIO_DIV),
+	STARFIVE_GATE(JH7100_CLK_AUDIO_12288, "audio_12288", 0, JH7100_CLK_OSC_AUD),
+	STARFIVE_GDIV(JH7100_CLK_VIN_SRC, "vin_src", 0, 4, JH7100_CLK_VIN_ROOT),
+	STARFIVE__DIV(JH7100_CLK_ISP0_BUS, "isp0_bus", 8, JH7100_CLK_VIN_SRC),
+	STARFIVE_GATE(JH7100_CLK_ISP0_AXI, "isp0_axi", 0, JH7100_CLK_ISP0_BUS),
+	STARFIVE_GATE(JH7100_CLK_ISP0NOC_AXI, "isp0noc_axi", 0, JH7100_CLK_ISP0_BUS),
+	STARFIVE_GATE(JH7100_CLK_ISPSLV_AXI, "ispslv_axi", 0, JH7100_CLK_ISP0_BUS),
+	STARFIVE__DIV(JH7100_CLK_ISP1_BUS, "isp1_bus", 8, JH7100_CLK_VIN_SRC),
+	STARFIVE_GATE(JH7100_CLK_ISP1_AXI, "isp1_axi", 0, JH7100_CLK_ISP1_BUS),
+	STARFIVE_GATE(JH7100_CLK_ISP1NOC_AXI, "isp1noc_axi", 0, JH7100_CLK_ISP1_BUS),
+	STARFIVE__DIV(JH7100_CLK_VIN_BUS, "vin_bus", 8, JH7100_CLK_VIN_SRC),
+	STARFIVE_GATE(JH7100_CLK_VIN_AXI, "vin_axi", 0, JH7100_CLK_VIN_BUS),
+	STARFIVE_GATE(JH7100_CLK_VINNOC_AXI, "vinnoc_axi", 0, JH7100_CLK_VIN_BUS),
+	STARFIVE_GDIV(JH7100_CLK_VOUT_SRC, "vout_src", 0, 4, JH7100_CLK_VOUT_ROOT),
+	STARFIVE__DIV(JH7100_CLK_DISPBUS_SRC, "dispbus_src", 4, JH7100_CLK_VOUTBUS_ROOT),
+	STARFIVE__DIV(JH7100_CLK_DISP_BUS, "disp_bus", 4, JH7100_CLK_DISPBUS_SRC),
+	STARFIVE_GATE(JH7100_CLK_DISP_AXI, "disp_axi", 0, JH7100_CLK_DISP_BUS),
+	STARFIVE_GATE(JH7100_CLK_DISPNOC_AXI, "dispnoc_axi", 0, JH7100_CLK_DISP_BUS),
+	STARFIVE_GATE(JH7100_CLK_SDIO0_AHB, "sdio0_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SDIO0_CCLKINT, "sdio0_cclkint", 0, 24, JH7100_CLK_PERH0_SRC),
+	STARFIVE__INV(JH7100_CLK_SDIO0_CCLKINT_INV, "sdio0_cclkint_inv", JH7100_CLK_SDIO0_CCLKINT),
+	STARFIVE_GATE(JH7100_CLK_SDIO1_AHB, "sdio1_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SDIO1_CCLKINT, "sdio1_cclkint", 0, 24, JH7100_CLK_PERH1_SRC),
+	STARFIVE__INV(JH7100_CLK_SDIO1_CCLKINT_INV, "sdio1_cclkint_inv", JH7100_CLK_SDIO1_CCLKINT),
+	STARFIVE_GATE(JH7100_CLK_GMAC_AHB, "gmac_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE__DIV(JH7100_CLK_GMAC_ROOT_DIV, "gmac_root_div", 8, JH7100_CLK_GMACUSB_ROOT),
+	STARFIVE_GDIV(JH7100_CLK_GMAC_PTP_REF, "gmac_ptp_refclk", 0, 31, JH7100_CLK_GMAC_ROOT_DIV),
+	STARFIVE_GDIV(JH7100_CLK_GMAC_GTX, "gmac_gtxclk", 0, 255, JH7100_CLK_GMAC_ROOT_DIV),
+	STARFIVE_GDIV(JH7100_CLK_GMAC_RMII_TX, "gmac_rmii_txclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
+	STARFIVE_GDIV(JH7100_CLK_GMAC_RMII_RX, "gmac_rmii_rxclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
+	STARFIVE__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", 3,
+		      JH7100_CLK_GMAC_GTX,
+		      JH7100_CLK_GMAC_TX_INV,
+		      JH7100_CLK_GMAC_RMII_TX),
+	STARFIVE__INV(JH7100_CLK_GMAC_TX_INV, "gmac_tx_inv", JH7100_CLK_GMAC_TX),
+	STARFIVE__MUX(JH7100_CLK_GMAC_RX_PRE, "gmac_rx_pre", 2,
+		      JH7100_CLK_GMAC_GR_MII_RX,
+		      JH7100_CLK_GMAC_RMII_RX),
+	STARFIVE__INV(JH7100_CLK_GMAC_RX_INV, "gmac_rx_inv", JH7100_CLK_GMAC_RX_PRE),
+	STARFIVE_GATE(JH7100_CLK_GMAC_RMII, "gmac_rmii", 0, JH7100_CLK_GMAC_RMII_REF),
+	STARFIVE_GDIV(JH7100_CLK_GMAC_TOPHYREF, "gmac_tophyref", 0, 127, JH7100_CLK_GMAC_ROOT_DIV),
+	STARFIVE_GATE(JH7100_CLK_SPI2AHB_AHB, "spi2ahb_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SPI2AHB_CORE, "spi2ahb_core", 0, 31, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_EZMASTER_AHB, "ezmaster_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_E24_AHB, "e24_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_E24RTC_TOGGLE, "e24rtc_toggle", 0, JH7100_CLK_OSC_SYS),
+	STARFIVE_GATE(JH7100_CLK_QSPI_AHB, "qspi_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_QSPI_APB, "qspi_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_QSPI_REF, "qspi_refclk", 0, 31, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_SEC_AHB, "sec_ahb", 0, JH7100_CLK_AHB_BUS),
+	STARFIVE_GATE(JH7100_CLK_AES, "aes_clk", 0, JH7100_CLK_SEC_AHB),
+	STARFIVE_GATE(JH7100_CLK_SHA, "sha_clk", 0, JH7100_CLK_SEC_AHB),
+	STARFIVE_GATE(JH7100_CLK_PKA, "pka_clk", 0, JH7100_CLK_SEC_AHB),
+	STARFIVE_GATE(JH7100_CLK_TRNG_APB, "trng_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GATE(JH7100_CLK_OTP_APB, "otp_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GATE(JH7100_CLK_UART0_APB, "uart0_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_UART0_CORE, "uart0_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_UART1_APB, "uart1_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_UART1_CORE, "uart1_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_SPI0_APB, "spi0_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SPI0_CORE, "spi0_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_SPI1_APB, "spi1_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SPI1_CORE, "spi1_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_I2C0_APB, "i2c0_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_I2C0_CORE, "i2c0_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_I2C1_APB, "i2c1_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GDIV(JH7100_CLK_I2C1_CORE, "i2c1_core", 0, 63, JH7100_CLK_PERH1_SRC),
+	STARFIVE_GATE(JH7100_CLK_GPIO_APB, "gpio_apb", 0, JH7100_CLK_APB1_BUS),
+	STARFIVE_GATE(JH7100_CLK_UART2_APB, "uart2_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_UART2_CORE, "uart2_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_UART3_APB, "uart3_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_UART3_CORE, "uart3_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_SPI2_APB, "spi2_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SPI2_CORE, "spi2_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_SPI3_APB, "spi3_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_SPI3_CORE, "spi3_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_I2C2_APB, "i2c2_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_I2C2_CORE, "i2c2_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_I2C3_APB, "i2c3_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_I2C3_CORE, "i2c3_core", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_WDTIMER_APB, "wdtimer_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_WDT_CORE, "wdt_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER0_CORE, "timer0_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER1_CORE, "timer1_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER2_CORE, "timer2_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER3_CORE, "timer3_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER4_CORE, "timer4_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER5_CORE, "timer5_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GDIV(JH7100_CLK_TIMER6_CORE, "timer6_coreclk", 0, 63, JH7100_CLK_PERH0_SRC),
+	STARFIVE_GATE(JH7100_CLK_VP6INTC_APB, "vp6intc_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GATE(JH7100_CLK_PWM_APB, "pwm_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GATE(JH7100_CLK_MSI_APB, "msi_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GATE(JH7100_CLK_TEMP_APB, "temp_apb", 0, JH7100_CLK_APB2_BUS),
+	STARFIVE_GDIV(JH7100_CLK_TEMP_SENSE, "temp_sense", 0, 31, JH7100_CLK_OSC_SYS),
+	STARFIVE_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS),
 };
 
 static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7100_CLK_PLL0_OUT)
@@ -283,7 +287,7 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
 
 static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	unsigned int idx;
 	int ret;
 
@@ -317,12 +321,13 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7100_clk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
-			.num_parents = ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.num_parents = ((max & STARFIVE_CLK_MUX_MASK)
+					>> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7100_clk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 
 		for (i = 0; i < init.num_parents; i++) {
@@ -344,7 +349,7 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(priv->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index 62954eb7b50a..a7ce89b566eb 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -23,40 +23,40 @@
 #define JH7110_AONCLK_GMAC0_GTXCLK	(JH7110_AONCLK_END + 5)
 #define JH7110_AONCLK_RTC_OSC		(JH7110_AONCLK_END + 6)
 
-static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
+static const struct starfive_clk_data jh7110_aonclk_data[] = {
 	/* source */
-	JH71X0__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4, JH7110_AONCLK_OSC),
-	JH71X0__MUX(JH7110_AONCLK_APB_FUNC, "apb_func", 2,
-		    JH7110_AONCLK_OSC_DIV4,
-		    JH7110_AONCLK_OSC),
+	STARFIVE__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4, JH7110_AONCLK_OSC),
+	STARFIVE__MUX(JH7110_AONCLK_APB_FUNC, "apb_func", 2,
+		      JH7110_AONCLK_OSC_DIV4,
+		      JH7110_AONCLK_OSC),
 	/* gmac0 */
-	JH71X0_GATE(JH7110_AONCLK_GMAC0_AHB, "gmac0_ahb", 0, JH7110_AONCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_AONCLK_GMAC0_AXI, "gmac0_axi", 0, JH7110_AONCLK_STG_AXIAHB),
-	JH71X0__DIV(JH7110_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
-		    JH7110_AONCLK_GMAC0_RMII_REFIN),
-	JH71X0_GMUX(JH7110_AONCLK_GMAC0_TX, "gmac0_tx",
-		    CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,
-		    JH7110_AONCLK_GMAC0_GTXCLK,
-		    JH7110_AONCLK_GMAC0_RMII_RTX),
-	JH71X0__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv", JH7110_AONCLK_GMAC0_TX),
-	JH71X0__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
-		    JH7110_AONCLK_GMAC0_RGMII_RXIN,
-		    JH7110_AONCLK_GMAC0_RMII_RTX),
-	JH71X0__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv", JH7110_AONCLK_GMAC0_RX),
+	STARFIVE_GATE(JH7110_AONCLK_GMAC0_AHB, "gmac0_ahb", 0, JH7110_AONCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_AONCLK_GMAC0_AXI, "gmac0_axi", 0, JH7110_AONCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
+		      JH7110_AONCLK_GMAC0_RMII_REFIN),
+	STARFIVE_GMUX(JH7110_AONCLK_GMAC0_TX, "gmac0_tx",
+		      CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,
+		      JH7110_AONCLK_GMAC0_GTXCLK,
+		      JH7110_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv", JH7110_AONCLK_GMAC0_TX),
+	STARFIVE__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
+		      JH7110_AONCLK_GMAC0_RGMII_RXIN,
+		      JH7110_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv", JH7110_AONCLK_GMAC0_RX),
 	/* otpc */
-	JH71X0_GATE(JH7110_AONCLK_OTPC_APB, "otpc_apb", 0, JH7110_AONCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_AONCLK_OTPC_APB, "otpc_apb", 0, JH7110_AONCLK_APB_BUS),
 	/* rtc */
-	JH71X0_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", 0, JH7110_AONCLK_APB_BUS),
-	JH71X0__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022, JH7110_AONCLK_OSC),
-	JH71X0__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
-		    JH7110_AONCLK_RTC_OSC,
-		    JH7110_AONCLK_RTC_INTERNAL),
-	JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
+	STARFIVE_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", 0, JH7110_AONCLK_APB_BUS),
+	STARFIVE__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022, JH7110_AONCLK_OSC),
+	STARFIVE__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
+		      JH7110_AONCLK_RTC_OSC,
+		      JH7110_AONCLK_RTC_INTERNAL),
+	STARFIVE_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
 };
 
 static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7110_AONCLK_END)
@@ -67,7 +67,7 @@ static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *d
 
 static int jh7110_aoncrg_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	unsigned int idx;
 	int ret;
 
@@ -88,13 +88,13 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7110_aonclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
 			.num_parents =
-				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7110_aonclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 
 		for (i = 0; i < init.num_parents; i++) {
@@ -120,7 +120,7 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index ce034ed28532..be6040f718c0 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -28,41 +28,41 @@ static struct clk_bulk_data jh7110_isp_top_clks[] = {
 	{ .id = "isp_top_axi" }
 };
 
-static const struct jh71x0_clk_data jh7110_ispclk_data[] = {
+static const struct starfive_clk_data jh7110_ispclk_data[] = {
 	/* syscon */
-	JH71X0__DIV(JH7110_ISPCLK_DOM4_APB_FUNC, "dom4_apb_func", 15,
-		    JH7110_ISPCLK_ISP_TOP_AXI),
-	JH71X0__DIV(JH7110_ISPCLK_MIPI_RX0_PXL, "mipi_rx0_pxl", 8,
-		    JH7110_ISPCLK_ISP_TOP_CORE),
-	JH71X0__INV(JH7110_ISPCLK_DVP_INV, "dvp_inv", JH7110_ISPCLK_DVP_CLK),
+	STARFIVE__DIV(JH7110_ISPCLK_DOM4_APB_FUNC, "dom4_apb_func", 15,
+		      JH7110_ISPCLK_ISP_TOP_AXI),
+	STARFIVE__DIV(JH7110_ISPCLK_MIPI_RX0_PXL, "mipi_rx0_pxl", 8,
+		      JH7110_ISPCLK_ISP_TOP_CORE),
+	STARFIVE__INV(JH7110_ISPCLK_DVP_INV, "dvp_inv", JH7110_ISPCLK_DVP_CLK),
 	/* vin */
-	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_CFG_IN, "m31dphy_cfg_in", 16,
-		    JH7110_ISPCLK_ISP_TOP_CORE),
-	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_REF_IN, "m31dphy_ref_in", 16,
-		    JH7110_ISPCLK_ISP_TOP_CORE),
-	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0, "m31dphy_tx_esc_lan0", 60,
-		    JH7110_ISPCLK_ISP_TOP_CORE),
-	JH71X0_GATE(JH7110_ISPCLK_VIN_APB, "vin_apb", 0,
-		    JH7110_ISPCLK_DOM4_APB_FUNC),
-	JH71X0__DIV(JH7110_ISPCLK_VIN_SYS, "vin_sys", 8, JH7110_ISPCLK_ISP_TOP_CORE),
-	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_IF0, "vin_pixel_if0", 0,
-		    JH7110_ISPCLK_MIPI_RX0_PXL),
-	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_IF1, "vin_pixel_if1", 0,
-		    JH7110_ISPCLK_MIPI_RX0_PXL),
-	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_IF2, "vin_pixel_if2", 0,
-		    JH7110_ISPCLK_MIPI_RX0_PXL),
-	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_IF3, "vin_pixel_if3", 0,
-		    JH7110_ISPCLK_MIPI_RX0_PXL),
-	JH71X0__MUX(JH7110_ISPCLK_VIN_P_AXI_WR, "vin_p_axi_wr", 2,
-		    JH7110_ISPCLK_MIPI_RX0_PXL,
-		    JH7110_ISPCLK_DVP_INV),
+	STARFIVE__DIV(JH7110_ISPCLK_M31DPHY_CFG_IN, "m31dphy_cfg_in", 16,
+		      JH7110_ISPCLK_ISP_TOP_CORE),
+	STARFIVE__DIV(JH7110_ISPCLK_M31DPHY_REF_IN, "m31dphy_ref_in", 16,
+		      JH7110_ISPCLK_ISP_TOP_CORE),
+	STARFIVE__DIV(JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0, "m31dphy_tx_esc_lan0", 60,
+		      JH7110_ISPCLK_ISP_TOP_CORE),
+	STARFIVE_GATE(JH7110_ISPCLK_VIN_APB, "vin_apb", 0,
+		      JH7110_ISPCLK_DOM4_APB_FUNC),
+	STARFIVE__DIV(JH7110_ISPCLK_VIN_SYS, "vin_sys", 8, JH7110_ISPCLK_ISP_TOP_CORE),
+	STARFIVE_GATE(JH7110_ISPCLK_VIN_PIXEL_IF0, "vin_pixel_if0", 0,
+		      JH7110_ISPCLK_MIPI_RX0_PXL),
+	STARFIVE_GATE(JH7110_ISPCLK_VIN_PIXEL_IF1, "vin_pixel_if1", 0,
+		      JH7110_ISPCLK_MIPI_RX0_PXL),
+	STARFIVE_GATE(JH7110_ISPCLK_VIN_PIXEL_IF2, "vin_pixel_if2", 0,
+		      JH7110_ISPCLK_MIPI_RX0_PXL),
+	STARFIVE_GATE(JH7110_ISPCLK_VIN_PIXEL_IF3, "vin_pixel_if3", 0,
+		      JH7110_ISPCLK_MIPI_RX0_PXL),
+	STARFIVE__MUX(JH7110_ISPCLK_VIN_P_AXI_WR, "vin_p_axi_wr", 2,
+		      JH7110_ISPCLK_MIPI_RX0_PXL,
+		      JH7110_ISPCLK_DVP_INV),
 	/* ispv2_top_wrapper */
-	JH71X0_GMUX(JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C, "ispv2_top_wrapper_c", 0, 2,
-		    JH7110_ISPCLK_MIPI_RX0_PXL,
-		    JH7110_ISPCLK_DVP_INV),
+	STARFIVE_GMUX(JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C, "ispv2_top_wrapper_c", 0, 2,
+		      JH7110_ISPCLK_MIPI_RX0_PXL,
+		      JH7110_ISPCLK_DVP_INV),
 };
 
-static inline int jh7110_isp_top_rst_init(struct jh71x0_clk_priv *priv)
+static inline int jh7110_isp_top_rst_init(struct starfive_clk_priv *priv)
 {
 	struct reset_control *top_rsts;
 
@@ -77,7 +77,7 @@ static inline int jh7110_isp_top_rst_init(struct jh71x0_clk_priv *priv)
 
 static struct clk_hw *jh7110_ispclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7110_ISPCLK_END)
@@ -110,7 +110,7 @@ static const struct dev_pm_ops jh7110_ispcrg_pm_ops = {
 
 static int jh7110_ispcrg_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	struct jh7110_top_sysclk *top;
 	unsigned int idx;
 	int ret;
@@ -153,13 +153,13 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7110_ispclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
 			.num_parents =
-				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7110_ispclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 		const char *fw_name[JH7110_ISPCLK_EXT_END - JH7110_ISPCLK_END] = {
 			"isp_top_core",
@@ -179,7 +179,7 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
index dafcb7190592..2d6ee0ad343a 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-stg.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
@@ -25,59 +25,59 @@
 #define JH7110_STGCLK_APB_BUS			(JH7110_STGCLK_END + 7)
 #define JH7110_STGCLK_EXT_END			(JH7110_STGCLK_END + 8)
 
-static const struct jh71x0_clk_data jh7110_stgclk_data[] = {
+static const struct starfive_clk_data jh7110_stgclk_data[] = {
 	/* hifi4 */
-	JH71X0_GATE(JH7110_STGCLK_HIFI4_CLK_CORE, "hifi4_clk_core", 0,
-		    JH7110_STGCLK_HIFI4_CORE),
+	STARFIVE_GATE(JH7110_STGCLK_HIFI4_CLK_CORE, "hifi4_clk_core", 0,
+		      JH7110_STGCLK_HIFI4_CORE),
 	/* usb */
-	JH71X0_GATE(JH7110_STGCLK_USB0_APB, "usb0_apb", 0, JH7110_STGCLK_APB_BUS),
-	JH71X0_GATE(JH7110_STGCLK_USB0_UTMI_APB, "usb0_utmi_apb", 0, JH7110_STGCLK_APB_BUS),
-	JH71X0_GATE(JH7110_STGCLK_USB0_AXI, "usb0_axi", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GDIV(JH7110_STGCLK_USB0_LPM, "usb0_lpm", 0, 2, JH7110_STGCLK_OSC),
-	JH71X0_GDIV(JH7110_STGCLK_USB0_STB, "usb0_stb", 0, 4, JH7110_STGCLK_OSC),
-	JH71X0_GATE(JH7110_STGCLK_USB0_APP_125, "usb0_app_125", 0, JH7110_STGCLK_USB_125M),
-	JH71X0__DIV(JH7110_STGCLK_USB0_REFCLK, "usb0_refclk", 2, JH7110_STGCLK_OSC),
+	STARFIVE_GATE(JH7110_STGCLK_USB0_APB, "usb0_apb", 0, JH7110_STGCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_USB0_UTMI_APB, "usb0_utmi_apb", 0, JH7110_STGCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_USB0_AXI, "usb0_axi", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GDIV(JH7110_STGCLK_USB0_LPM, "usb0_lpm", 0, 2, JH7110_STGCLK_OSC),
+	STARFIVE_GDIV(JH7110_STGCLK_USB0_STB, "usb0_stb", 0, 4, JH7110_STGCLK_OSC),
+	STARFIVE_GATE(JH7110_STGCLK_USB0_APP_125, "usb0_app_125", 0, JH7110_STGCLK_USB_125M),
+	STARFIVE__DIV(JH7110_STGCLK_USB0_REFCLK, "usb0_refclk", 2, JH7110_STGCLK_OSC),
 	/* pci-e */
-	JH71X0_GATE(JH7110_STGCLK_PCIE0_AXI_MST0, "pcie0_axi_mst0", 0,
-		    JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_PCIE0_APB, "pcie0_apb", 0, JH7110_STGCLK_APB_BUS),
-	JH71X0_GATE(JH7110_STGCLK_PCIE0_TL, "pcie0_tl", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_PCIE1_AXI_MST0, "pcie1_axi_mst0", 0,
-		    JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_PCIE1_APB, "pcie1_apb", 0, JH7110_STGCLK_APB_BUS),
-	JH71X0_GATE(JH7110_STGCLK_PCIE1_TL, "pcie1_tl", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_PCIE_SLV_MAIN, "pcie_slv_main", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE0_AXI_MST0, "pcie0_axi_mst0", 0,
+		      JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE0_APB, "pcie0_apb", 0, JH7110_STGCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE0_TL, "pcie0_tl", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE1_AXI_MST0, "pcie1_axi_mst0", 0,
+		      JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE1_APB, "pcie1_apb", 0, JH7110_STGCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE1_TL, "pcie1_tl", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_PCIE_SLV_MAIN, "pcie_slv_main", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_STG_AXIAHB),
 	/* security */
-	JH71X0_GATE(JH7110_STGCLK_SEC_AHB, "sec_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_SEC_MISC_AHB, "sec_misc_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_SEC_AHB, "sec_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_SEC_MISC_AHB, "sec_misc_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
 	/* stg mtrx */
-	JH71X0_GATE(JH7110_STGCLK_GRP0_MAIN, "mtrx_grp0_main", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_CPU_BUS),
-	JH71X0_GATE(JH7110_STGCLK_GRP0_BUS, "mtrx_grp0_bus", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_NOCSTG_BUS),
-	JH71X0_GATE(JH7110_STGCLK_GRP0_STG, "mtrx_grp0_stg", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_GRP1_MAIN, "mtrx_grp1_main", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_CPU_BUS),
-	JH71X0_GATE(JH7110_STGCLK_GRP1_BUS, "mtrx_grp1_bus", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_NOCSTG_BUS),
-	JH71X0_GATE(JH7110_STGCLK_GRP1_STG, "mtrx_grp1_stg", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_GRP1_HIFI, "mtrx_grp1_hifi", CLK_IS_CRITICAL,
-		    JH7110_STGCLK_HIFI4_AXI),
+	STARFIVE_GATE(JH7110_STGCLK_GRP0_MAIN, "mtrx_grp0_main", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_CPU_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_GRP0_BUS, "mtrx_grp0_bus", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_NOCSTG_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_GRP0_STG, "mtrx_grp0_stg", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_GRP1_MAIN, "mtrx_grp1_main", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_CPU_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_GRP1_BUS, "mtrx_grp1_bus", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_NOCSTG_BUS),
+	STARFIVE_GATE(JH7110_STGCLK_GRP1_STG, "mtrx_grp1_stg", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_GRP1_HIFI, "mtrx_grp1_hifi", CLK_IS_CRITICAL,
+		      JH7110_STGCLK_HIFI4_AXI),
 	/* e24_rvpi */
-	JH71X0_GDIV(JH7110_STGCLK_E2_RTC, "e2_rtc", 0, 24, JH7110_STGCLK_OSC),
-	JH71X0_GATE(JH7110_STGCLK_E2_CORE, "e2_core", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_E2_DBG, "e2_dbg", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GDIV(JH7110_STGCLK_E2_RTC, "e2_rtc", 0, 24, JH7110_STGCLK_OSC),
+	STARFIVE_GATE(JH7110_STGCLK_E2_CORE, "e2_core", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_E2_DBG, "e2_dbg", 0, JH7110_STGCLK_STG_AXIAHB),
 	/* dw_sgdma1p */
-	JH71X0_GATE(JH7110_STGCLK_DMA1P_AXI, "dma1p_axi", 0, JH7110_STGCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_DMA1P_AXI, "dma1p_axi", 0, JH7110_STGCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
 };
 
 static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7110_STGCLK_END)
@@ -88,7 +88,7 @@ static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *d
 
 static int jh7110_stgcrg_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	unsigned int idx;
 	int ret;
 
@@ -108,13 +108,13 @@ static int jh7110_stgcrg_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7110_stgclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
 			.num_parents =
-				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7110_stgclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		const char *fw_name[JH7110_STGCLK_EXT_END - JH7110_STGCLK_END] = {
 			"osc",
 			"hifi4_core",
@@ -138,7 +138,7 @@ static int jh7110_stgcrg_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index e63353c70209..00ef88d9c2fd 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -34,298 +34,301 @@
 #define JH7110_SYSCLK_PLL1_OUT			(JH7110_SYSCLK_END + 10)
 #define JH7110_SYSCLK_PLL2_OUT			(JH7110_SYSCLK_END + 11)
 
-static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
+static const struct starfive_clk_data jh7110_sysclk_data[] __initconst = {
 	/* root */
-	JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
-		    JH7110_SYSCLK_OSC,
-		    JH7110_SYSCLK_PLL0_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
-	JH71X0__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2, JH7110_SYSCLK_CPU_CORE),
-	JH71X0__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
-		    JH7110_SYSCLK_PLL2_OUT,
-		    JH7110_SYSCLK_PLL1_OUT),
-	JH71X0_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
-		    JH7110_SYSCLK_PLL0_OUT,
-		    JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
-		    JH7110_SYSCLK_OSC,
-		    JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3, JH7110_SYSCLK_BUS_ROOT),
-	JH71X0__DIV(JH7110_SYSCLK_AXI_CFG0, "axi_cfg0", 3, JH7110_SYSCLK_BUS_ROOT),
-	JH71X0__DIV(JH7110_SYSCLK_STG_AXIAHB, "stg_axiahb", 2, JH7110_SYSCLK_AXI_CFG0),
-	JH71X0_GATE(JH7110_SYSCLK_AHB0, "ahb0", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_SYSCLK_AHB1, "ahb1", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
-	JH71X0__DIV(JH7110_SYSCLK_APB_BUS, "apb_bus", 8, JH7110_SYSCLK_STG_AXIAHB),
-	JH71X0_GATE(JH7110_SYSCLK_APB0, "apb0", CLK_IS_CRITICAL, JH7110_SYSCLK_APB_BUS),
-	JH71X0__DIV(JH7110_SYSCLK_PLL0_DIV2, "pll0_div2", 2, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV2, "pll1_div2", 2, JH7110_SYSCLK_PLL1_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64, JH7110_SYSCLK_AUDIO_ROOT),
-	JH71X0__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
-		    JH7110_SYSCLK_MCLK_INNER,
-		    JH7110_SYSCLK_MCLK_EXT),
-	JH71X0_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0, JH7110_SYSCLK_MCLK_INNER),
-	JH71X0_MDIV(JH7110_SYSCLK_ISP_2X, "isp_2x", 8, 2,
-		    JH7110_SYSCLK_PLL2_OUT,
-		    JH7110_SYSCLK_PLL1_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_ISP_AXI, "isp_axi", 4, JH7110_SYSCLK_ISP_2X),
-	JH71X0_GDIV(JH7110_SYSCLK_GCLK0, "gclk0", 0, 62, JH7110_SYSCLK_PLL0_DIV2),
-	JH71X0_GDIV(JH7110_SYSCLK_GCLK1, "gclk1", 0, 62, JH7110_SYSCLK_PLL1_DIV2),
-	JH71X0_GDIV(JH7110_SYSCLK_GCLK2, "gclk2", 0, 62, JH7110_SYSCLK_PLL2_DIV2),
+	STARFIVE__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
+		      JH7110_SYSCLK_PLL2_OUT,
+		      JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
+		      JH7110_SYSCLK_PLL0_OUT,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3, JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_AXI_CFG0, "axi_cfg0", 3, JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_STG_AXIAHB, "stg_axiahb", 2, JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_AHB0, "ahb0", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_SYSCLK_AHB1, "ahb1", CLK_IS_CRITICAL, JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_SYSCLK_APB_BUS, "apb_bus", 8, JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_SYSCLK_APB0, "apb0", CLK_IS_CRITICAL, JH7110_SYSCLK_APB_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL0_DIV2, "pll0_div2", 2, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV2, "pll1_div2", 2, JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64, JH7110_SYSCLK_AUDIO_ROOT),
+	STARFIVE__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
+		      JH7110_SYSCLK_MCLK_INNER,
+		      JH7110_SYSCLK_MCLK_EXT),
+	STARFIVE_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0, JH7110_SYSCLK_MCLK_INNER),
+	STARFIVE_MDIV(JH7110_SYSCLK_ISP_2X, "isp_2x", 8, 2,
+		      JH7110_SYSCLK_PLL2_OUT,
+		      JH7110_SYSCLK_PLL1_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_ISP_AXI, "isp_axi", 4, JH7110_SYSCLK_ISP_2X),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK0, "gclk0", 0, 62, JH7110_SYSCLK_PLL0_DIV2),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK1, "gclk1", 0, 62, JH7110_SYSCLK_PLL1_DIV2),
+	STARFIVE_GDIV(JH7110_SYSCLK_GCLK2, "gclk2", 0, 62, JH7110_SYSCLK_PLL2_DIV2),
 	/* cores */
-	JH71X0_GATE(JH7110_SYSCLK_CORE, "core", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_CORE1, "core1", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_CORE2, "core2", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_CORE3, "core3", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_CORE4, "core4", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_DEBUG, "debug", 0, JH7110_SYSCLK_CPU_BUS),
-	JH71X0__DIV(JH7110_SYSCLK_RTC_TOGGLE, "rtc_toggle", 6, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE0, "trace0", 0, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE1, "trace1", 0, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE2, "trace2", 0, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE3, "trace3", 0, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE4, "trace4", 0, JH7110_SYSCLK_CPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_TRACE_COM, "trace_com", 0, JH7110_SYSCLK_CPU_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE, "core", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE1, "core1", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE2, "core2", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE3, "core3", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_CORE4, "core4", CLK_IS_CRITICAL, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_DEBUG, "debug", 0, JH7110_SYSCLK_CPU_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_RTC_TOGGLE, "rtc_toggle", 6, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE0, "trace0", 0, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE1, "trace1", 0, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE2, "trace2", 0, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE3, "trace3", 0, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE4, "trace4", 0, JH7110_SYSCLK_CPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_TRACE_COM, "trace_com", 0, JH7110_SYSCLK_CPU_BUS),
 	/* noc */
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_CPU_AXI, "noc_bus_cpu_axi", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_CPU_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI, "noc_bus_axicfg0_axi", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_CPU_AXI, "noc_bus_cpu_axi", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_CPU_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI, "noc_bus_axicfg0_axi", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_AXI_CFG0),
 	/* ddr */
-	JH71X0__DIV(JH7110_SYSCLK_OSC_DIV2, "osc_div2", 2, JH7110_SYSCLK_OSC),
-	JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV4, "pll1_div4", 2, JH7110_SYSCLK_PLL1_DIV2),
-	JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV8, "pll1_div8", 2, JH7110_SYSCLK_PLL1_DIV4),
-	JH71X0__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 4,
-		    JH7110_SYSCLK_OSC_DIV2,
-		    JH7110_SYSCLK_PLL1_DIV2,
-		    JH7110_SYSCLK_PLL1_DIV4,
-		    JH7110_SYSCLK_PLL1_DIV8),
-	JH71X0_GATE(JH7110_SYSCLK_DDR_AXI, "ddr_axi", CLK_IS_CRITICAL, JH7110_SYSCLK_DDR_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_OSC_DIV2, "osc_div2", 2, JH7110_SYSCLK_OSC),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV4, "pll1_div4", 2, JH7110_SYSCLK_PLL1_DIV2),
+	STARFIVE__DIV(JH7110_SYSCLK_PLL1_DIV8, "pll1_div8", 2, JH7110_SYSCLK_PLL1_DIV4),
+	STARFIVE__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 4,
+		      JH7110_SYSCLK_OSC_DIV2,
+		      JH7110_SYSCLK_PLL1_DIV2,
+		      JH7110_SYSCLK_PLL1_DIV4,
+		      JH7110_SYSCLK_PLL1_DIV8),
+	STARFIVE_GATE(JH7110_SYSCLK_DDR_AXI, "ddr_axi", CLK_IS_CRITICAL, JH7110_SYSCLK_DDR_BUS),
 	/* gpu */
-	JH71X0__DIV(JH7110_SYSCLK_GPU_CORE, "gpu_core", 7, JH7110_SYSCLK_GPU_ROOT),
-	JH71X0_GATE(JH7110_SYSCLK_GPU_CORE_CLK, "gpu_core_clk", 0, JH7110_SYSCLK_GPU_CORE),
-	JH71X0_GATE(JH7110_SYSCLK_GPU_SYS_CLK, "gpu_sys_clk", 0, JH7110_SYSCLK_ISP_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_GPU_APB, "gpu_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GDIV(JH7110_SYSCLK_GPU_RTC_TOGGLE, "gpu_rtc_toggle", 0, 12, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_GPU_AXI, "noc_bus_gpu_axi", 0, JH7110_SYSCLK_GPU_CORE),
+	STARFIVE__DIV(JH7110_SYSCLK_GPU_CORE, "gpu_core", 7, JH7110_SYSCLK_GPU_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_CORE_CLK, "gpu_core_clk", 0, JH7110_SYSCLK_GPU_CORE),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_SYS_CLK, "gpu_sys_clk", 0, JH7110_SYSCLK_ISP_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_GPU_APB, "gpu_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GDIV(JH7110_SYSCLK_GPU_RTC_TOGGLE, "gpu_rtc_toggle", 0, 12, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_GPU_AXI, "noc_bus_gpu_axi", 0, JH7110_SYSCLK_GPU_CORE),
 	/* isp */
-	JH71X0_GATE(JH7110_SYSCLK_ISP_TOP_CORE, "isp_top_core", 0, JH7110_SYSCLK_ISP_2X),
-	JH71X0_GATE(JH7110_SYSCLK_ISP_TOP_AXI, "isp_top_axi", 0, JH7110_SYSCLK_ISP_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_ISP_AXI, "noc_bus_isp_axi", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_ISP_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_ISP_TOP_CORE, "isp_top_core", 0, JH7110_SYSCLK_ISP_2X),
+	STARFIVE_GATE(JH7110_SYSCLK_ISP_TOP_AXI, "isp_top_axi", 0, JH7110_SYSCLK_ISP_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_ISP_AXI, "noc_bus_isp_axi", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_ISP_AXI),
 	/* hifi4 */
-	JH71X0__DIV(JH7110_SYSCLK_HIFI4_CORE, "hifi4_core", 15, JH7110_SYSCLK_BUS_ROOT),
-	JH71X0__DIV(JH7110_SYSCLK_HIFI4_AXI, "hifi4_axi", 2, JH7110_SYSCLK_HIFI4_CORE),
+	STARFIVE__DIV(JH7110_SYSCLK_HIFI4_CORE, "hifi4_core", 15, JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE__DIV(JH7110_SYSCLK_HIFI4_AXI, "hifi4_axi", 2, JH7110_SYSCLK_HIFI4_CORE),
 	/* axi_cfg1 */
-	JH71X0_GATE(JH7110_SYSCLK_AXI_CFG1_MAIN, "axi_cfg1_main", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_ISP_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_AXI_CFG1_AHB, "axi_cfg1_ahb", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG1_MAIN, "axi_cfg1_main", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_ISP_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG1_AHB, "axi_cfg1_ahb", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_AHB0),
 	/* vout */
-	JH71X0_GATE(JH7110_SYSCLK_VOUT_SRC, "vout_src", 0, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_VOUT_AXI, "vout_axi", 7, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_DISP_AXI, "noc_bus_disp_axi", 0, JH7110_SYSCLK_VOUT_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_AHB, "vout_top_ahb", 0, JH7110_SYSCLK_AHB1),
-	JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_AXI, "vout_top_axi", 0, JH7110_SYSCLK_VOUT_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK, "vout_top_hdmitx0_mclk", 0,
-		    JH7110_SYSCLK_MCLK),
-	JH71X0__DIV(JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF, "vout_top_mipiphy_ref", 2,
-		    JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_SRC, "vout_src", 0, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_VOUT_AXI, "vout_axi", 7, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_DISP_AXI, "noc_bus_disp_axi", 0,
+		      JH7110_SYSCLK_VOUT_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_AHB, "vout_top_ahb", 0, JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_AXI, "vout_top_axi", 0, JH7110_SYSCLK_VOUT_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK, "vout_top_hdmitx0_mclk", 0,
+		      JH7110_SYSCLK_MCLK),
+	STARFIVE__DIV(JH7110_SYSCLK_VOUT_TOP_MIPIPHY_REF, "vout_top_mipiphy_ref", 2,
+		      JH7110_SYSCLK_OSC),
 	/* jpegc */
-	JH71X0__DIV(JH7110_SYSCLK_JPEGC_AXI, "jpegc_axi", 16, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_CODAJ12_AXI, "codaj12_axi", 0, JH7110_SYSCLK_JPEGC_AXI),
-	JH71X0_GDIV(JH7110_SYSCLK_CODAJ12_CORE, "codaj12_core", 0, 16, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_CODAJ12_APB, "codaj12_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_JPEGC_AXI, "jpegc_axi", 16, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_CODAJ12_AXI, "codaj12_axi", 0, JH7110_SYSCLK_JPEGC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_CODAJ12_CORE, "codaj12_core", 0, 16, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_CODAJ12_APB, "codaj12_apb", 0, JH7110_SYSCLK_APB_BUS),
 	/* vdec */
-	JH71X0__DIV(JH7110_SYSCLK_VDEC_AXI, "vdec_axi", 7, JH7110_SYSCLK_BUS_ROOT),
-	JH71X0_GATE(JH7110_SYSCLK_WAVE511_AXI, "wave511_axi", 0, JH7110_SYSCLK_VDEC_AXI),
-	JH71X0_GDIV(JH7110_SYSCLK_WAVE511_BPU, "wave511_bpu", 0, 7, JH7110_SYSCLK_BUS_ROOT),
-	JH71X0_GDIV(JH7110_SYSCLK_WAVE511_VCE, "wave511_vce", 0, 7, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_WAVE511_APB, "wave511_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_VDEC_JPG, "vdec_jpg", 0, JH7110_SYSCLK_JPEGC_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_VDEC_MAIN, "vdec_main", 0, JH7110_SYSCLK_VDEC_AXI),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_VDEC_AXI, "noc_bus_vdec_axi", 0, JH7110_SYSCLK_VDEC_AXI),
+	STARFIVE__DIV(JH7110_SYSCLK_VDEC_AXI, "vdec_axi", 7, JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE511_AXI, "wave511_axi", 0, JH7110_SYSCLK_VDEC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE511_BPU, "wave511_bpu", 0, 7, JH7110_SYSCLK_BUS_ROOT),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE511_VCE, "wave511_vce", 0, 7, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE511_APB, "wave511_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_VDEC_JPG, "vdec_jpg", 0, JH7110_SYSCLK_JPEGC_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_VDEC_MAIN, "vdec_main", 0, JH7110_SYSCLK_VDEC_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_VDEC_AXI, "noc_bus_vdec_axi", 0,
+		      JH7110_SYSCLK_VDEC_AXI),
 	/* venc */
-	JH71X0__DIV(JH7110_SYSCLK_VENC_AXI, "venc_axi", 15, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_WAVE420L_AXI, "wave420l_axi", 0, JH7110_SYSCLK_VENC_AXI),
-	JH71X0_GDIV(JH7110_SYSCLK_WAVE420L_BPU, "wave420l_bpu", 0, 15, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GDIV(JH7110_SYSCLK_WAVE420L_VCE, "wave420l_vce", 0, 15, JH7110_SYSCLK_PLL2_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_WAVE420L_APB, "wave420l_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_VENC_AXI, "noc_bus_venc_axi", 0, JH7110_SYSCLK_VENC_AXI),
+	STARFIVE__DIV(JH7110_SYSCLK_VENC_AXI, "venc_axi", 15, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE420L_AXI, "wave420l_axi", 0, JH7110_SYSCLK_VENC_AXI),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE420L_BPU, "wave420l_bpu", 0, 15, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GDIV(JH7110_SYSCLK_WAVE420L_VCE, "wave420l_vce", 0, 15, JH7110_SYSCLK_PLL2_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_WAVE420L_APB, "wave420l_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_VENC_AXI, "noc_bus_venc_axi", 0,
+		      JH7110_SYSCLK_VENC_AXI),
 	/* axi_cfg0 */
-	JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN_DIV, "axi_cfg0_main_div", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_AHB1),
-	JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN, "axi_cfg0_main", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_AXI_CFG0),
-	JH71X0_GATE(JH7110_SYSCLK_AXI_CFG0_HIFI4, "axi_cfg0_hifi4", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_HIFI4_AXI),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN_DIV, "axi_cfg0_main_div", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_MAIN, "axi_cfg0_main", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_AXI_CFG0_HIFI4, "axi_cfg0_hifi4", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_HIFI4_AXI),
 	/* intmem */
-	JH71X0_GATE(JH7110_SYSCLK_AXIMEM2_AXI, "aximem2_axi", 0, JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_AXIMEM2_AXI, "aximem2_axi", 0, JH7110_SYSCLK_AXI_CFG0),
 	/* qspi */
-	JH71X0_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", 0, JH7110_SYSCLK_AHB1),
-	JH71X0_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0__DIV(JH7110_SYSCLK_QSPI_REF_SRC, "qspi_ref_src", 16, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0_GMUX(JH7110_SYSCLK_QSPI_REF, "qspi_ref", 0, 2,
-		    JH7110_SYSCLK_OSC,
-		    JH7110_SYSCLK_QSPI_REF_SRC),
+	STARFIVE_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", 0, JH7110_SYSCLK_AHB1),
+	STARFIVE_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_QSPI_REF_SRC, "qspi_ref_src", 16, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE_GMUX(JH7110_SYSCLK_QSPI_REF, "qspi_ref", 0, 2,
+		      JH7110_SYSCLK_OSC,
+		      JH7110_SYSCLK_QSPI_REF_SRC),
 	/* sdio */
-	JH71X0_GATE(JH7110_SYSCLK_SDIO0_AHB, "sdio0_ahb", 0, JH7110_SYSCLK_AHB0),
-	JH71X0_GATE(JH7110_SYSCLK_SDIO1_AHB, "sdio1_ahb", 0, JH7110_SYSCLK_AHB0),
-	JH71X0_GDIV(JH7110_SYSCLK_SDIO0_SDCARD, "sdio0_sdcard", 0, 15, JH7110_SYSCLK_AXI_CFG0),
-	JH71X0_GDIV(JH7110_SYSCLK_SDIO1_SDCARD, "sdio1_sdcard", 0, 15, JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GATE(JH7110_SYSCLK_SDIO0_AHB, "sdio0_ahb", 0, JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SDIO1_AHB, "sdio1_ahb", 0, JH7110_SYSCLK_AHB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_SDIO0_SDCARD, "sdio0_sdcard", 0, 15, JH7110_SYSCLK_AXI_CFG0),
+	STARFIVE_GDIV(JH7110_SYSCLK_SDIO1_SDCARD, "sdio1_sdcard", 0, 15, JH7110_SYSCLK_AXI_CFG0),
 	/* stg */
-	JH71X0__DIV(JH7110_SYSCLK_USB_125M, "usb_125m", 15, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0_GATE(JH7110_SYSCLK_NOC_BUS_STG_AXI, "noc_bus_stg_axi", CLK_IS_CRITICAL,
-		    JH7110_SYSCLK_NOCSTG_BUS),
+	STARFIVE__DIV(JH7110_SYSCLK_USB_125M, "usb_125m", 15, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE_GATE(JH7110_SYSCLK_NOC_BUS_STG_AXI, "noc_bus_stg_axi", CLK_IS_CRITICAL,
+		      JH7110_SYSCLK_NOCSTG_BUS),
 	/* gmac1 */
-	JH71X0_GATE(JH7110_SYSCLK_GMAC1_AHB, "gmac1_ahb", 0, JH7110_SYSCLK_AHB0),
-	JH71X0_GATE(JH7110_SYSCLK_GMAC1_AXI, "gmac1_axi", 0, JH7110_SYSCLK_STG_AXIAHB),
-	JH71X0__DIV(JH7110_SYSCLK_GMAC_SRC, "gmac_src", 7, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_GMAC1_GTXCLK, "gmac1_gtxclk", 15, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0__DIV(JH7110_SYSCLK_GMAC1_RMII_RTX, "gmac1_rmii_rtx", 30,
-		    JH7110_SYSCLK_GMAC1_RMII_REFIN),
-	JH71X0_GDIV(JH7110_SYSCLK_GMAC1_PTP, "gmac1_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
-	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
-		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
-		    JH7110_SYSCLK_GMAC1_RMII_RTX),
-	JH71X0__INV(JH7110_SYSCLK_GMAC1_RX_INV, "gmac1_rx_inv", JH7110_SYSCLK_GMAC1_RX),
-	JH71X0_GMUX(JH7110_SYSCLK_GMAC1_TX, "gmac1_tx",
-		    CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,
-		    JH7110_SYSCLK_GMAC1_GTXCLK,
-		    JH7110_SYSCLK_GMAC1_RMII_RTX),
-	JH71X0__INV(JH7110_SYSCLK_GMAC1_TX_INV, "gmac1_tx_inv", JH7110_SYSCLK_GMAC1_TX),
-	JH71X0_GATE(JH7110_SYSCLK_GMAC1_GTXC, "gmac1_gtxc", 0, JH7110_SYSCLK_GMAC1_GTXCLK),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_AHB, "gmac1_ahb", 0, JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_AXI, "gmac1_axi", 0, JH7110_SYSCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC_SRC, "gmac_src", 7, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC1_GTXCLK, "gmac1_gtxclk", 15, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE__DIV(JH7110_SYSCLK_GMAC1_RMII_RTX, "gmac1_rmii_rtx", 30,
+		      JH7110_SYSCLK_GMAC1_RMII_REFIN),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC1_PTP, "gmac1_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
+		      JH7110_SYSCLK_GMAC1_RGMII_RXIN,
+		      JH7110_SYSCLK_GMAC1_RMII_RTX),
+	STARFIVE__INV(JH7110_SYSCLK_GMAC1_RX_INV, "gmac1_rx_inv", JH7110_SYSCLK_GMAC1_RX),
+	STARFIVE_GMUX(JH7110_SYSCLK_GMAC1_TX, "gmac1_tx",
+		      CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, 2,
+		      JH7110_SYSCLK_GMAC1_GTXCLK,
+		      JH7110_SYSCLK_GMAC1_RMII_RTX),
+	STARFIVE__INV(JH7110_SYSCLK_GMAC1_TX_INV, "gmac1_tx_inv", JH7110_SYSCLK_GMAC1_TX),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC1_GTXC, "gmac1_gtxc", 0, JH7110_SYSCLK_GMAC1_GTXCLK),
 	/* gmac0 */
-	JH71X0_GDIV(JH7110_SYSCLK_GMAC0_GTXCLK, "gmac0_gtxclk", 0, 15, JH7110_SYSCLK_PLL0_OUT),
-	JH71X0_GDIV(JH7110_SYSCLK_GMAC0_PTP, "gmac0_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
-	JH71X0_GDIV(JH7110_SYSCLK_GMAC_PHY, "gmac_phy", 0, 31, JH7110_SYSCLK_GMAC_SRC),
-	JH71X0_GATE(JH7110_SYSCLK_GMAC0_GTXC, "gmac0_gtxc", 0, JH7110_SYSCLK_GMAC0_GTXCLK),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC0_GTXCLK, "gmac0_gtxclk", 0, 15, JH7110_SYSCLK_PLL0_OUT),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC0_PTP, "gmac0_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE_GDIV(JH7110_SYSCLK_GMAC_PHY, "gmac_phy", 0, 31, JH7110_SYSCLK_GMAC_SRC),
+	STARFIVE_GATE(JH7110_SYSCLK_GMAC0_GTXC, "gmac0_gtxc", 0, JH7110_SYSCLK_GMAC0_GTXCLK),
 	/* apb misc */
-	JH71X0_GATE(JH7110_SYSCLK_IOMUX_APB, "iomux_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_MAILBOX_APB, "mailbox_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_INT_CTRL_APB, "int_ctrl_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_IOMUX_APB, "iomux_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_MAILBOX_APB, "mailbox_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_INT_CTRL_APB, "int_ctrl_apb", 0, JH7110_SYSCLK_APB_BUS),
 	/* can0 */
-	JH71X0_GATE(JH7110_SYSCLK_CAN0_APB, "can0_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GDIV(JH7110_SYSCLK_CAN0_TIMER, "can0_timer", 0, 24, JH7110_SYSCLK_OSC),
-	JH71X0_GDIV(JH7110_SYSCLK_CAN0_CAN, "can0_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_CAN0_APB, "can0_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN0_TIMER, "can0_timer", 0, 24, JH7110_SYSCLK_OSC),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN0_CAN, "can0_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
 	/* can1 */
-	JH71X0_GATE(JH7110_SYSCLK_CAN1_APB, "can1_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GDIV(JH7110_SYSCLK_CAN1_TIMER, "can1_timer", 0, 24, JH7110_SYSCLK_OSC),
-	JH71X0_GDIV(JH7110_SYSCLK_CAN1_CAN, "can1_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_CAN1_APB, "can1_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN1_TIMER, "can1_timer", 0, 24, JH7110_SYSCLK_OSC),
+	STARFIVE_GDIV(JH7110_SYSCLK_CAN1_CAN, "can1_can", 0, 63, JH7110_SYSCLK_PERH_ROOT),
 	/* pwm */
-	JH71X0_GATE(JH7110_SYSCLK_PWM_APB, "pwm_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_PWM_APB, "pwm_apb", 0, JH7110_SYSCLK_APB_BUS),
 	/* wdt */
-	JH71X0_GATE(JH7110_SYSCLK_WDT_APB, "wdt_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_WDT_CORE, "wdt_core", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_WDT_APB, "wdt_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_WDT_CORE, "wdt_core", 0, JH7110_SYSCLK_OSC),
 	/* timer */
-	JH71X0_GATE(JH7110_SYSCLK_TIMER_APB, "timer_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_TIMER0, "timer0", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_TIMER1, "timer1", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_TIMER2, "timer2", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_TIMER3, "timer3", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER_APB, "timer_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER0, "timer0", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER1, "timer1", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER2, "timer2", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TIMER3, "timer3", 0, JH7110_SYSCLK_OSC),
 	/* temp sensor */
-	JH71X0_GATE(JH7110_SYSCLK_TEMP_APB, "temp_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GDIV(JH7110_SYSCLK_TEMP_CORE, "temp_core", 0, 24, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_TEMP_APB, "temp_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GDIV(JH7110_SYSCLK_TEMP_CORE, "temp_core", 0, 24, JH7110_SYSCLK_OSC),
 	/* spi */
-	JH71X0_GATE(JH7110_SYSCLK_SPI0_APB, "spi0_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_SPI1_APB, "spi1_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_SPI2_APB, "spi2_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_SPI3_APB, "spi3_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_SPI4_APB, "spi4_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_SPI5_APB, "spi5_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_SPI6_APB, "spi6_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI0_APB, "spi0_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI1_APB, "spi1_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI2_APB, "spi2_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI3_APB, "spi3_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI4_APB, "spi4_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI5_APB, "spi5_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_SPI6_APB, "spi6_apb", 0, JH7110_SYSCLK_APB_BUS),
 	/* i2c */
-	JH71X0_GATE(JH7110_SYSCLK_I2C0_APB, "i2c0_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_I2C1_APB, "i2c1_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_I2C2_APB, "i2c2_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_I2C3_APB, "i2c3_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_I2C4_APB, "i2c4_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_I2C5_APB, "i2c5_apb", 0, JH7110_SYSCLK_APB_BUS),
-	JH71X0_GATE(JH7110_SYSCLK_I2C6_APB, "i2c6_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C0_APB, "i2c0_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C1_APB, "i2c1_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C2_APB, "i2c2_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C3_APB, "i2c3_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C4_APB, "i2c4_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C5_APB, "i2c5_apb", 0, JH7110_SYSCLK_APB_BUS),
+	STARFIVE_GATE(JH7110_SYSCLK_I2C6_APB, "i2c6_apb", 0, JH7110_SYSCLK_APB_BUS),
 	/* uart */
-	JH71X0_GATE(JH7110_SYSCLK_UART0_APB, "uart0_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_UART0_CORE, "uart0_core", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_UART1_APB, "uart1_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_UART1_CORE, "uart1_core", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_UART2_APB, "uart2_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_UART2_CORE, "uart2_core", 0, JH7110_SYSCLK_OSC),
-	JH71X0_GATE(JH7110_SYSCLK_UART3_APB, "uart3_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_UART3_CORE, "uart3_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
-	JH71X0_GATE(JH7110_SYSCLK_UART4_APB, "uart4_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_UART4_CORE, "uart4_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
-	JH71X0_GATE(JH7110_SYSCLK_UART5_APB, "uart5_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_UART5_CORE, "uart5_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_UART0_APB, "uart0_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART0_CORE, "uart0_core", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART1_APB, "uart1_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART1_CORE, "uart1_core", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART2_APB, "uart2_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_UART2_CORE, "uart2_core", 0, JH7110_SYSCLK_OSC),
+	STARFIVE_GATE(JH7110_SYSCLK_UART3_APB, "uart3_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART3_CORE, "uart3_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_UART4_APB, "uart4_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART4_CORE, "uart4_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_UART5_APB, "uart5_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_UART5_CORE, "uart5_core", 0, 10, JH7110_SYSCLK_PERH_ROOT),
 	/* pwmdac */
-	JH71X0_GATE(JH7110_SYSCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_PWMDAC_CORE, "pwmdac_core", 0, 256, JH7110_SYSCLK_AUDIO_ROOT),
+	STARFIVE_GATE(JH7110_SYSCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_PWMDAC_CORE, "pwmdac_core", 0, 256, JH7110_SYSCLK_AUDIO_ROOT),
 	/* spdif */
-	JH71X0_GATE(JH7110_SYSCLK_SPDIF_APB, "spdif_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GATE(JH7110_SYSCLK_SPDIF_CORE, "spdif_core", 0, JH7110_SYSCLK_MCLK),
+	STARFIVE_GATE(JH7110_SYSCLK_SPDIF_APB, "spdif_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GATE(JH7110_SYSCLK_SPDIF_CORE, "spdif_core", 0, JH7110_SYSCLK_MCLK),
 	/* i2stx0 */
-	JH71X0_GATE(JH7110_SYSCLK_I2STX0_APB, "i2stx0_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_I2STX0_BCLK_MST, "i2stx0_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
-	JH71X0__INV(JH7110_SYSCLK_I2STX0_BCLK_MST_INV, "i2stx0_bclk_mst_inv",
-		    JH7110_SYSCLK_I2STX0_BCLK_MST),
-	JH71X0_MDIV(JH7110_SYSCLK_I2STX0_LRCK_MST, "i2stx0_lrck_mst", 64, 2,
-		    JH7110_SYSCLK_I2STX0_BCLK_MST_INV,
-		    JH7110_SYSCLK_I2STX0_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk",	2,
-		    JH7110_SYSCLK_I2STX0_BCLK_MST,
-		    JH7110_SYSCLK_I2STX_BCLK_EXT),
-	JH71X0__INV(JH7110_SYSCLK_I2STX0_BCLK_INV, "i2stx0_bclk_inv", JH7110_SYSCLK_I2STX0_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 2,
-		    JH7110_SYSCLK_I2STX0_LRCK_MST,
-		    JH7110_SYSCLK_I2STX_LRCK_EXT),
+	STARFIVE_GATE(JH7110_SYSCLK_I2STX0_APB, "i2stx0_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2STX0_BCLK_MST, "i2stx0_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX0_BCLK_MST_INV, "i2stx0_bclk_mst_inv",
+		      JH7110_SYSCLK_I2STX0_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2STX0_LRCK_MST, "i2stx0_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk",	2,
+		      JH7110_SYSCLK_I2STX0_BCLK_MST,
+		      JH7110_SYSCLK_I2STX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX0_BCLK_INV, "i2stx0_bclk_inv", JH7110_SYSCLK_I2STX0_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 2,
+		      JH7110_SYSCLK_I2STX0_LRCK_MST,
+		      JH7110_SYSCLK_I2STX_LRCK_EXT),
 	/* i2stx1 */
-	JH71X0_GATE(JH7110_SYSCLK_I2STX1_APB, "i2stx1_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_I2STX1_BCLK_MST, "i2stx1_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
-	JH71X0__INV(JH7110_SYSCLK_I2STX1_BCLK_MST_INV, "i2stx1_bclk_mst_inv",
-		    JH7110_SYSCLK_I2STX1_BCLK_MST),
-	JH71X0_MDIV(JH7110_SYSCLK_I2STX1_LRCK_MST, "i2stx1_lrck_mst", 64, 2,
-		    JH7110_SYSCLK_I2STX1_BCLK_MST_INV,
-		    JH7110_SYSCLK_I2STX1_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 2,
-		    JH7110_SYSCLK_I2STX1_BCLK_MST,
-		    JH7110_SYSCLK_I2STX_BCLK_EXT),
-	JH71X0__INV(JH7110_SYSCLK_I2STX1_BCLK_INV, "i2stx1_bclk_inv", JH7110_SYSCLK_I2STX1_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 2,
-		    JH7110_SYSCLK_I2STX1_LRCK_MST,
-		    JH7110_SYSCLK_I2STX_LRCK_EXT),
+	STARFIVE_GATE(JH7110_SYSCLK_I2STX1_APB, "i2stx1_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2STX1_BCLK_MST, "i2stx1_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX1_BCLK_MST_INV, "i2stx1_bclk_mst_inv",
+		      JH7110_SYSCLK_I2STX1_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2STX1_LRCK_MST, "i2stx1_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 2,
+		      JH7110_SYSCLK_I2STX1_BCLK_MST,
+		      JH7110_SYSCLK_I2STX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2STX1_BCLK_INV, "i2stx1_bclk_inv", JH7110_SYSCLK_I2STX1_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 2,
+		      JH7110_SYSCLK_I2STX1_LRCK_MST,
+		      JH7110_SYSCLK_I2STX_LRCK_EXT),
 	/* i2srx */
-	JH71X0_GATE(JH7110_SYSCLK_I2SRX_APB, "i2srx_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_I2SRX_BCLK_MST, "i2srx_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
-	JH71X0__INV(JH7110_SYSCLK_I2SRX_BCLK_MST_INV, "i2srx_bclk_mst_inv",
-		    JH7110_SYSCLK_I2SRX_BCLK_MST),
-	JH71X0_MDIV(JH7110_SYSCLK_I2SRX_LRCK_MST, "i2srx_lrck_mst", 64, 2,
-		    JH7110_SYSCLK_I2SRX_BCLK_MST_INV,
-		    JH7110_SYSCLK_I2SRX_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 2,
-		    JH7110_SYSCLK_I2SRX_BCLK_MST,
-		    JH7110_SYSCLK_I2SRX_BCLK_EXT),
-	JH71X0__INV(JH7110_SYSCLK_I2SRX_BCLK_INV, "i2srx_bclk_inv", JH7110_SYSCLK_I2SRX_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 2,
-		    JH7110_SYSCLK_I2SRX_LRCK_MST,
-		    JH7110_SYSCLK_I2SRX_LRCK_EXT),
+	STARFIVE_GATE(JH7110_SYSCLK_I2SRX_APB, "i2srx_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_I2SRX_BCLK_MST, "i2srx_bclk_mst", 0, 32, JH7110_SYSCLK_MCLK),
+	STARFIVE__INV(JH7110_SYSCLK_I2SRX_BCLK_MST_INV, "i2srx_bclk_mst_inv",
+		      JH7110_SYSCLK_I2SRX_BCLK_MST),
+	STARFIVE_MDIV(JH7110_SYSCLK_I2SRX_LRCK_MST, "i2srx_lrck_mst", 64, 2,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST_INV,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST),
+	STARFIVE__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 2,
+		      JH7110_SYSCLK_I2SRX_BCLK_MST,
+		      JH7110_SYSCLK_I2SRX_BCLK_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_I2SRX_BCLK_INV, "i2srx_bclk_inv", JH7110_SYSCLK_I2SRX_BCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 2,
+		      JH7110_SYSCLK_I2SRX_LRCK_MST,
+		      JH7110_SYSCLK_I2SRX_LRCK_EXT),
 	/* pdm */
-	JH71X0_GDIV(JH7110_SYSCLK_PDM_DMIC, "pdm_dmic", 0, 64, JH7110_SYSCLK_MCLK),
-	JH71X0_GATE(JH7110_SYSCLK_PDM_APB, "pdm_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_PDM_DMIC, "pdm_dmic", 0, 64, JH7110_SYSCLK_MCLK),
+	STARFIVE_GATE(JH7110_SYSCLK_PDM_APB, "pdm_apb", 0, JH7110_SYSCLK_APB0),
 	/* tdm */
-	JH71X0_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0, JH7110_SYSCLK_AHB0),
-	JH71X0_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0, JH7110_SYSCLK_APB0),
-	JH71X0_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64, JH7110_SYSCLK_MCLK),
-	JH71X0__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 2,
-		    JH7110_SYSCLK_TDM_INTERNAL,
-		    JH7110_SYSCLK_TDM_EXT),
-	JH71X0__INV(JH7110_SYSCLK_TDM_TDM_INV, "tdm_tdm_inv", JH7110_SYSCLK_TDM_TDM),
+	STARFIVE_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0, JH7110_SYSCLK_AHB0),
+	STARFIVE_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0, JH7110_SYSCLK_APB0),
+	STARFIVE_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64, JH7110_SYSCLK_MCLK),
+	STARFIVE__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 2,
+		      JH7110_SYSCLK_TDM_INTERNAL,
+		      JH7110_SYSCLK_TDM_EXT),
+	STARFIVE__INV(JH7110_SYSCLK_TDM_TDM_INV, "tdm_tdm_inv", JH7110_SYSCLK_TDM_TDM),
 	/* jtag */
-	JH71X0__DIV(JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG, "jtag_certification_trng", 4,
-		    JH7110_SYSCLK_OSC),
+	STARFIVE__DIV(JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG, "jtag_certification_trng", 4,
+		      JH7110_SYSCLK_OSC),
 };
 
 static struct clk_hw *jh7110_sysclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7110_SYSCLK_END)
@@ -350,7 +353,7 @@ static void jh7110_reset_adev_release(struct device *dev)
 	kfree(rdev);
 }
 
-int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
+int jh7110_reset_controller_register(struct starfive_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
@@ -387,7 +390,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
 
 static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	unsigned int idx;
 	int ret;
 	struct clk *pllclk;
@@ -446,13 +449,13 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7110_sysclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
 			.num_parents =
-				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7110_sysclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 
 		for (i = 0; i < init.num_parents; i++) {
@@ -490,7 +493,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 10cc1ec43925..aca93c370bce 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -30,45 +30,45 @@ static struct clk_bulk_data jh7110_vout_top_clks[] = {
 	{ .id = "vout_top_ahb" }
 };
 
-static const struct jh71x0_clk_data jh7110_voutclk_data[] = {
+static const struct starfive_clk_data jh7110_voutclk_data[] = {
 	/* divider */
-	JH71X0__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP_AHB),
-	JH71X0__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_VOUTCLK_VOUT_SRC),
-	JH71X0__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK_VOUT_SRC),
-	JH71X0__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	STARFIVE__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	STARFIVE__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_VOUTCLK_VOUT_SRC),
+	STARFIVE__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK_VOUT_SRC),
+	STARFIVE__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_VOUT_TOP_AHB),
 	/* dc8200 */
-	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
-	JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
-	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
-	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
-		    JH7110_VOUTCLK_DC8200_PIX,
-		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
-	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
-		    JH7110_VOUTCLK_DC8200_PIX,
-		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	STARFIVE_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	STARFIVE_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	STARFIVE_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	STARFIVE_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
+		      JH7110_VOUTCLK_DC8200_PIX,
+		      JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	STARFIVE_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
+		      JH7110_VOUTCLK_DC8200_PIX,
+		      JH7110_VOUTCLK_HDMITX0_PIXELCLK),
 	/* LCD */
-	JH71X0_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", 0, 2,
-		    JH7110_VOUTCLK_DC8200_PIX0,
-		    JH7110_VOUTCLK_DC8200_PIX1),
+	STARFIVE_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", 0, 2,
+		      JH7110_VOUTCLK_DC8200_PIX0,
+		      JH7110_VOUTCLK_DC8200_PIX1),
 	/* dsiTx */
-	JH71X0_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUTCLK_DSI_SYS),
-	JH71X0_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUTCLK_DSI_SYS),
-	JH71X0_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
-		    JH7110_VOUTCLK_DC8200_PIX,
-		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
-	JH71X0_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_VOUTCLK_TX_ESC),
+	STARFIVE_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUTCLK_DSI_SYS),
+	STARFIVE_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUTCLK_DSI_SYS),
+	STARFIVE_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
+		      JH7110_VOUTCLK_DC8200_PIX,
+		      JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	STARFIVE_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_VOUTCLK_TX_ESC),
 	/* mipitx DPHY */
-	JH71X0_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc", 0,
-		    JH7110_VOUTCLK_TX_ESC),
+	STARFIVE_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc", 0,
+		      JH7110_VOUTCLK_TX_ESC),
 	/* hdmi */
-	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
-		    JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
-	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
-		    JH7110_VOUTCLK_I2STX0_BCLK),
-	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_VOUTCLK_APB),
+	STARFIVE_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
+		      JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
+	STARFIVE_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
+		      JH7110_VOUTCLK_I2STX0_BCLK),
+	STARFIVE_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_VOUTCLK_APB),
 };
 
-static int jh7110_vout_top_rst_init(struct jh71x0_clk_priv *priv)
+static int jh7110_vout_top_rst_init(struct starfive_clk_priv *priv)
 {
 	struct reset_control *top_rst;
 
@@ -82,7 +82,7 @@ static int jh7110_vout_top_rst_init(struct jh71x0_clk_priv *priv)
 
 static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
 {
-	struct jh71x0_clk_priv *priv = data;
+	struct starfive_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
 	if (idx < JH7110_VOUTCLK_END)
@@ -115,7 +115,7 @@ static const struct dev_pm_ops jh7110_voutcrg_pm_ops = {
 
 static int jh7110_voutcrg_probe(struct platform_device *pdev)
 {
-	struct jh71x0_clk_priv *priv;
+	struct starfive_clk_priv *priv;
 	struct jh7110_top_sysclk *top;
 	unsigned int idx;
 	int ret;
@@ -158,13 +158,13 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7110_voutclk_data[idx].name,
-			.ops = starfive_jh71x0_clk_ops(max),
+			.ops = starfive_clk_ops(max),
 			.parent_data = parents,
 			.num_parents =
-				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
 			.flags = jh7110_voutclk_data[idx].flags,
 		};
-		struct jh71x0_clk *clk = &priv->reg[idx];
+		struct starfive_clk *clk = &priv->reg[idx];
 		unsigned int i;
 		const char *fw_name[JH7110_VOUTCLK_EXT_END - JH7110_VOUTCLK_END] = {
 			"vout_src",
@@ -186,7 +186,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 
 		clk->hw.init = &init;
 		clk->idx = idx;
-		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
 
 		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
 		if (ret)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 6b1bdf860f00..4a6dfd8d8636 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -10,7 +10,7 @@ struct jh7110_top_sysclk {
 	int top_clks_num;
 };
 
-int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
+int jh7110_reset_controller_register(struct starfive_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id);
 
-- 
2.34.1

