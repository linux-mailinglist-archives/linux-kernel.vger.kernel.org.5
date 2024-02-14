Return-Path: <linux-kernel+bounces-65521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D8854E28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973541C2166E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A86086A;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kH7nsdlG"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D585FF0B;
	Wed, 14 Feb 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927896; cv=none; b=NSR+pbIgBuvKmnSYK+Z5c7A42tay41v8fT+LFpMxMljvzKO+MD6tToa6rRa0p4+f4G8TDIBnkURCkHooxC0scaP6FEqtjXBstt0ZHvwVwklT0ZTc8sXJSUh2mUMYuqiM8Yt+BzVyjbjAEu4kyxKQNsuLAXVyLasPQFQ+n13zptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927896; c=relaxed/simple;
	bh=liIAu+HdBd+K5fea1uFUEyksEHrgCU91l/MPuFwanfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nm1TxlPTlV4R6vpNloe8f1qzu0D2MESAvkgwAs2nzNlag3v4w0Wd7PmrQdo6fRGRTzhaIsvrQNAeIDc5NPWqu5/iXwZbvJX9sfw+PsR57ariP1ES1bB0CxS5qJkC/lTAqPiEGSZWfUeOXbctqHEUPAWezhwGT6r6BD0gtXaY0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kH7nsdlG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DAB160016;
	Wed, 14 Feb 2024 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNwsUDGVccEaSEL1sdyKeqNgvGE7K6phcBXwuAXfoTc=;
	b=kH7nsdlGsizYX5Ap75XjtyQdaIEJcSnEQz53Xj/rPSpD2g0O3d1Fi4Qz+JDwqSaZ9DoJMS
	9+WarZmhOSe9DDUJVuA3Pil2LybE4ddEuEpy59DIF36EkAV5qQCNuEvVZjHc2YU3S7/P7+
	NJBkrCJ1EyicgOdm9lDuuTfWIrmN7rttUkWppTnb+5IbLe7b9XVesMxSs5o4HYzgILCZQu
	edbVKrwJPAvUdtW+HtXdNhgzxlCuWgoiIoVGjoSHw8RhdQFFO+QREfynoWx8iskhc20bVD
	GeSKV30sK67PkI8BdTrUxvBBB74TP/Txap3BgkFkYNJMfGdzvRX4pYQ7z/oWKA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:03 +0100
Subject: [PATCH 10/23] pinctrl: nomadik: follow whitespace kernel coding
 conventions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-10-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Fix strict checkpatch warnings relative to whitespace. Message types
addressed:

   ERROR: space required before the open parenthesis '('
   WARNING: quoted string split across lines
   CHECK: Alignment should match open parenthesis
   CHECK: Please don't use multiple blank lines
   CHECK: line length of 103 exceeds 100 columns
   CHECK: spaces preferred around that '+' (ctx:VxV)

Before: 1 errors, 2 warnings, 38 checks.
After:  0 errors, 1 warnings, 16 checks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 65 +++++++++++++++----------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 94338a3c8d4f..83e7868bc1d7 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -165,7 +165,6 @@
 #define PIN_SLEEPMODE_DISABLED	(0 << PIN_SLEEPMODE_SHIFT)
 #define PIN_SLEEPMODE_ENABLED	(1 << PIN_SLEEPMODE_SHIFT)
 
-
 /* Shortcuts.  Use these instead of separate DIR, PULL, and VAL.  */
 #define PIN_INPUT_PULLDOWN	(PIN_DIR_INPUT | PIN_PULL_DOWN)
 #define PIN_INPUT_PULLUP	(PIN_DIR_INPUT | PIN_PULL_UP)
@@ -341,7 +340,7 @@ static void nmk_write_masked(void __iomem *reg, u32 mask, u32 value)
 }
 
 static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
-	unsigned int offset, unsigned int alt_num)
+				    unsigned int offset, unsigned int alt_num)
 {
 	int i;
 	u16 reg;
@@ -385,7 +384,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 					nmk_write_masked(npct->prcm_base + reg, BIT(bit), 0);
 					dev_dbg(npct->dev,
 						"PRCM GPIOCR: pin %i: alternate-C%i has been disabled\n",
-						offset, i+1);
+						offset, i + 1);
 				}
 			}
 		}
@@ -395,8 +394,8 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	alt_index = alt_num - 1;
 	if (pin_desc->altcx[alt_index].used == false) {
 		dev_warn(npct->dev,
-			"PRCM GPIOCR: pin %i: alternate-C%i does not exist\n",
-			offset, alt_num);
+			 "PRCM GPIOCR: pin %i: alternate-C%i does not exist\n",
+			 offset, alt_num);
 		return;
 	}
 
@@ -414,7 +413,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 				nmk_write_masked(npct->prcm_base + reg, BIT(bit), 0);
 				dev_dbg(npct->dev,
 					"PRCM GPIOCR: pin %i: alternate-C%i has been disabled\n",
-					offset, i+1);
+					offset, i + 1);
 			}
 		}
 	}
@@ -422,7 +421,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	reg = gpiocr_regs[pin_desc->altcx[alt_index].reg_index];
 	bit = pin_desc->altcx[alt_index].control_bit;
 	dev_dbg(npct->dev, "PRCM GPIOCR: pin %i: alternate-C%i has been selected\n",
-		offset, alt_index+1);
+		offset, alt_index + 1);
 	nmk_write_masked(npct->prcm_base + reg, BIT(bit), BIT(bit));
 }
 
@@ -499,7 +498,7 @@ int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev, int gpi
 			reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 			bit = pin_desc->altcx[i].control_bit;
 			if (readl(npct->prcm_base + reg) & BIT(bit))
-				return NMK_GPIO_ALT_C+i+1;
+				return NMK_GPIO_ALT_C + i + 1;
 		}
 	}
 	return NMK_GPIO_ALT_C;
@@ -513,7 +512,7 @@ static int nmk_get_groups_cnt(struct pinctrl_dev *pctldev)
 }
 
 static const char *nmk_get_group_name(struct pinctrl_dev *pctldev,
-				       unsigned int selector)
+				      unsigned int selector)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
@@ -536,12 +535,12 @@ static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned int pin)
 	int i;
 	struct nmk_gpio_chip *nmk_gpio;
 
-	for(i = 0; i < NMK_MAX_BANKS; i++) {
+	for (i = 0; i < NMK_MAX_BANKS; i++) {
 		nmk_gpio = nmk_gpio_chips[i];
 		if (!nmk_gpio)
 			continue;
 		if (pin >= nmk_gpio->chip.base &&
-			pin < nmk_gpio->chip.base + nmk_gpio->chip.ngpio)
+		    pin < nmk_gpio->chip.base + nmk_gpio->chip.ngpio)
 			return nmk_gpio;
 	}
 	return NULL;
@@ -557,7 +556,7 @@ static struct gpio_chip *find_gc_from_pin(unsigned int pin)
 }
 
 static void nmk_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
-		   unsigned int offset)
+			     unsigned int offset)
 {
 	struct gpio_chip *chip = find_gc_from_pin(offset);
 
@@ -569,8 +568,8 @@ static void nmk_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 }
 
 static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned int *reserved_maps,
-		unsigned int *num_maps, const char *group,
-		const char *function)
+			      unsigned int *num_maps, const char *group,
+			      const char *function)
 {
 	if (*num_maps == *reserved_maps)
 		return -ENOSPC;
@@ -584,9 +583,9 @@ static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned int *reserved_m
 }
 
 static int nmk_dt_add_map_configs(struct pinctrl_map **map,
-		unsigned int *reserved_maps,
-		unsigned int *num_maps, const char *group,
-		unsigned long *configs, unsigned int num_configs)
+				  unsigned int *reserved_maps,
+				  unsigned int *num_maps, const char *group,
+				  unsigned long *configs, unsigned int num_configs)
 {
 	unsigned long *dup_configs;
 
@@ -702,15 +701,14 @@ static const char *nmk_find_pin_name(struct pinctrl_dev *pctldev, const char *pi
 }
 
 static bool nmk_pinctrl_dt_get_config(struct device_node *np,
-		unsigned long *configs)
+				      unsigned long *configs)
 {
 	bool has_config = 0;
 	unsigned long cfg = 0;
 	int i, val, ret;
 
 	for (i = 0; i < ARRAY_SIZE(nmk_cfg_params); i++) {
-		ret = of_property_read_u32(np,
-				nmk_cfg_params[i].property, &val);
+		ret = of_property_read_u32(np, nmk_cfg_params[i].property, &val);
 		if (ret != -EINVAL) {
 			if (nmk_dt_pin_config(i, val, &cfg) == 0) {
 				*configs |= cfg;
@@ -723,10 +721,10 @@ static bool nmk_pinctrl_dt_get_config(struct device_node *np,
 }
 
 static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
-		struct device_node *np,
-		struct pinctrl_map **map,
-		unsigned int *reserved_maps,
-		unsigned int *num_maps)
+					 struct device_node *np,
+					 struct pinctrl_map **map,
+					 unsigned int *reserved_maps,
+					 unsigned int *num_maps)
 {
 	int ret;
 	const char *function = NULL;
@@ -751,7 +749,7 @@ static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 		of_property_for_each_string(np, "groups", prop, group) {
 			ret = nmk_dt_add_map_mux(map, reserved_maps, num_maps,
-					  group, function);
+						 group, function);
 			if (ret < 0)
 				goto exit;
 		}
@@ -792,8 +790,9 @@ static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
-				 struct device_node *np_config,
-				 struct pinctrl_map **map, unsigned int *num_maps)
+				      struct device_node *np_config,
+				      struct pinctrl_map **map,
+				      unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
 	struct device_node *np;
@@ -805,7 +804,7 @@ static int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	for_each_child_of_node(np_config, np) {
 		ret = nmk_pinctrl_dt_subnode_to_map(pctldev, np, map,
-				&reserved_maps, num_maps);
+						    &reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
 			of_node_put(np);
@@ -920,7 +919,8 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 				g->grp.pins[i], g->grp.name, i);
 			goto out_glitch;
 		}
-		dev_dbg(npct->dev, "setting pin %d to altsetting %d\n", g->grp.pins[i], g->altsetting);
+		dev_dbg(npct->dev, "setting pin %d to altsetting %d\n",
+			g->grp.pins[i], g->altsetting);
 
 		clk_enable(nmk_chip->clk);
 		bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
@@ -934,7 +934,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		nmk_gpio_disable_lazy_irq(nmk_chip, bit);
 
 		__nmk_gpio_set_mode_safe(nmk_chip, bit,
-			(g->altsetting & NMK_GPIO_ALT_C), glitch);
+					 (g->altsetting & NMK_GPIO_ALT_C), glitch);
 		clk_disable(nmk_chip->clk);
 
 		/*
@@ -947,7 +947,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		 */
 		if ((g->altsetting & NMK_GPIO_ALT_C) == NMK_GPIO_ALT_C)
 			nmk_prcm_altcx_set_mode(npct, g->grp.pins[i],
-				g->altsetting >> NMK_GPIO_ALT_CX_SHIFT);
+						g->altsetting >> NMK_GPIO_ALT_CX_SHIFT);
 	}
 
 	/* When all pins are successfully reconfigured we get here */
@@ -1219,8 +1219,7 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	if (!npct->prcm_base) {
 		if (version == PINCTRL_NMK_STN8815) {
 			dev_info(&pdev->dev,
-				 "No PRCM base, "
-				 "assuming no ALT-Cx control is available\n");
+				 "No PRCM base, assuming no ALT-Cx control is available\n");
 		} else {
 			dev_err(&pdev->dev, "missing PRCM base address\n");
 			return -EINVAL;

-- 
2.43.1


