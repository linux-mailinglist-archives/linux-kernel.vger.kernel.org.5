Return-Path: <linux-kernel+bounces-78858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0478619CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1527D1F26EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065B140E30;
	Fri, 23 Feb 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WJPbUmrk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF96140398;
	Fri, 23 Feb 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709307; cv=none; b=TAwExzHrrLIFJ5YkioEdBzk5DwyA9n0U6jG68A/SWfZSQp+5tS7cpjEt61621COH/K4SuL0x7noZZwv9IHYHTLKcqpZVVQNmmruquY9bob3ZU19xz5uhMiu748zW6aBWsDeJ0l1ylPnvRDD+ZJAW8g2nMg1Aw9LBvIlG4y+KM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709307; c=relaxed/simple;
	bh=+9RuzNpYmHyqf7fIjBX42rka1JAIk57K6KkiNE8I2wU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjE9gpN3QPh7e5FQPgZg7imSklT38PQaEF20FUAl6sK7E+VQ7TNNoq8sBeeuQahrtrw9fN2hAeSCipIiCikWXv8K6gzLB8rs3bBGfpP0XuWyCbpgbi7Kk/AQbRCKXJPd8f4fcgKwrhutum/nnyhNuCz3RBnbDwjq/+C6k4K5mW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WJPbUmrk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709305; x=1740245305;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+9RuzNpYmHyqf7fIjBX42rka1JAIk57K6KkiNE8I2wU=;
  b=WJPbUmrkBy3ce8HjRg9jR1WxIqglM5bP/8z+cHg9iutDR0TBbAFEb2w5
   Sqboxe3UteI7Byn/r14pKbG+wE5f9IuKefGNsAJb25oZoC0cotVakJPL5
   8FZFpMA6EybGmlJNFYJNUZsSOO6IfVeJw1JVqKJZlYkJIistVoed1OswR
   9k+e0dfat8FOBD6o4ucq9e7X1EqeEq8fpuHEfkciyp6drdhqfir3WZIdG
   wyAUzdSj1Y5EAItPwAVZOmj/FBBpsj5gai+EcstSKiUKDDXl7CoJsxE7q
   p3VrUEkZWoujEi2gWMgshTZMi0lgHb7hxFGT1yq/zqj7l1mdY+bYbjyJq
   Q==;
X-CSE-ConnectionGUID: cHovNnNySCWyq3qf4VhSKA==
X-CSE-MsgGUID: ZbQPapPVTx6bw5cP6MVfuA==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="16735967"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:28:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:28:09 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:28:05 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<mripard@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 24/39] clk: at91: sam9x7: add support for HW PLL freq dividers
Date: Fri, 23 Feb 2024 22:57:58 +0530
Message-ID: <20240223172758.672796-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for hardware dividers for PLL IDs in sam9x7 SoC. The system
PLL - PLLA and the system PLL divided by 2 - PLLADIV2 with PLL ID 0 and
4 respectively, both have a hardware divider /2. This has to taken into
account in the software to obtain the right frequencies. Support for the
same is added in the PLL driver.

fcorepllack -----> HW Div = 2 -+--> fpllack
                               |
                               +--> HW Div = 2 ---> fplladiv2ck

In this case the corepll freq is 1600 MHz. So, the plla freq is 800 MHz
after the hardware divider and the plladiv2 freq is 400 MHz after the
hardware divider (Given that the DIVPMC is 0).

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 38 ++++++++++++++++++++++++++----
 drivers/clk/at91/pmc.h             |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b0314dfd7393..1f80759309c0 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -73,9 +73,15 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	unsigned long freq;
 
-	return parent_rate * (frac->mul + 1) +
+	freq = parent_rate * (frac->mul + 1) +
 		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
+
+	if (core->layout->div2)
+		freq >>= 1;
+
+	return freq;
 }
 
 static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
@@ -432,6 +438,12 @@ static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
 }
 
+static unsigned long sam9x60_fixed_div_pll_recalc_rate(struct clk_hw *hw,
+						       unsigned long parent_rate)
+{
+	return parent_rate >> 1;
+}
+
 static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 					unsigned long *parent_rate,
 					unsigned long rate)
@@ -606,6 +618,16 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 	.restore_context = sam9x60_div_pll_restore_context,
 };
 
+static const struct clk_ops sam9x60_fixed_div_pll_ops = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_fixed_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
+};
+
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
@@ -725,10 +747,16 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
-	if (flags & CLK_SET_RATE_GATE)
-		init.ops = &sam9x60_div_pll_ops;
-	else
-		init.ops = &sam9x60_div_pll_ops_chg;
+
+	if (layout->div2) {
+		init.ops = &sam9x60_fixed_div_pll_ops;
+	} else {
+		if (flags & CLK_SET_RATE_GATE)
+			init.ops = &sam9x60_div_pll_ops;
+		else
+			init.ops = &sam9x60_div_pll_ops_chg;
+	}
+
 	init.flags = flags;
 
 	div->core.id = id;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index bb9da35198d9..91d1c6305d95 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -64,6 +64,7 @@ struct clk_pll_layout {
 	u8 frac_shift;
 	u8 div_shift;
 	u8 endiv_shift;
+	u8 div2;
 };
 
 extern const struct clk_pll_layout at91rm9200_pll_layout;
-- 
2.25.1


