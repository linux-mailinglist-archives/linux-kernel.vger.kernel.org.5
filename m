Return-Path: <linux-kernel+bounces-65544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F95854E84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0B21C281BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456C6A334;
	Wed, 14 Feb 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eV/b3sjW"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6360EE5;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928084; cv=none; b=bDWcP2a4lwkGD/bjD/wPi+p6CQcHNjGH8YawcXFnaVaEyCMln1qxV5ahYbe06+HEGqSSKbbbBwwZubNDWrvL5hZ53m+U9x1lqbgj0CV4wCgJBIgRCXWt21PjT5UVvQHWaYIIaqvhDw0jHBteV7IjJL5Pv68gA25tdELoZLbICxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928084; c=relaxed/simple;
	bh=A3T5SM//1/4ymVFZvPaOVT1OvRFtKQIqEqwd57cE7Uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nxsh2/7BIu/kqo8aSMeoTjBk6Fx2oAjHpYs8r5se073rrCkCK5/gmWPjHGAwJwkH351tXps9NNcKVb7RHuZ3YvnPNC/tgcx/iETTaQu/P16bF5nPCeFFml2Pt+w1tQSebi3bgUYE8UYxll7L3Vikz6kWR/xJjtk+6b9MBOSnyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eV/b3sjW; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E0821C358D;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BCFE60013;
	Wed, 14 Feb 2024 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjxjuGOrCVIWRm1Z72QvMwQu7C7GEtJPDQOWRkQbA+0=;
	b=eV/b3sjWul3zBV0V30Z9HDyaLBhDuIoqZI9ZOhBPbcqRMoruz4FikgLu1i0RqcD3XoUhd/
	ZJkwyp600skRK0IFKs8S08A2lqBGRjGbcVum1wG6LALw218tPJrHS/6HMgsH0OnrIkbrNT
	AxRvt186PtyZyPT/93zHywVdMTUNVAUwhJqqlSjR52ick0Bb7ySOhUjCUgcbvT0jkLpL7T
	4VUGGZaQ6dP43jJwEBHAQq5LMWn7BfbngnFZi1+m2EAwHNZ71glWXvwrCxCWoFjgcn880k
	KTdp5O/n3pefPFEgr8W42wX1j1Wn6xEXMXwffzWKsKtmotN978x/828pa1Srvg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:02 +0100
Subject: [PATCH 09/23] pinctrl: nomadik: follow type-system kernel coding
 conventions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-9-f88c0ccf372b@bootlin.com>
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

Fix strict checkpatch warnings relative to types. Warning types
addressed:

   WARNING: do not add new typedefs
   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
   WARNING: static const char * array should probably be static const
            char * const

Total messages before: 1 errors, 40 warnings, 39 checks.
Total messages after:  1 errors,  2 warnings, 38 checks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 78 +++++++++++++++----------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index c1cb3a363692..94338a3c8d4f 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -71,8 +71,6 @@
  * PIN_CFG	   - default config with alternate function
  */
 
-typedef unsigned long pin_cfg_t;
-
 #define PIN_NUM_MASK		0x1ff
 #define PIN_NUM(x)		((x) & PIN_NUM_MASK)
 
@@ -215,7 +213,7 @@ struct nmk_gpio_chip *nmk_gpio_chips[NMK_MAX_BANKS];
 DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
 
 static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
-				unsigned offset, int gpio_mode)
+				unsigned int offset, int gpio_mode)
 {
 	u32 afunc, bfunc;
 
@@ -230,7 +228,7 @@ static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
 }
 
 static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
-				unsigned offset, enum nmk_gpio_pull pull)
+				unsigned int offset, enum nmk_gpio_pull pull)
 {
 	u32 pdis;
 
@@ -254,7 +252,7 @@ static void __nmk_gpio_set_pull(struct nmk_gpio_chip *nmk_chip,
 }
 
 static void __nmk_gpio_set_lowemi(struct nmk_gpio_chip *nmk_chip,
-				  unsigned offset, bool lowemi)
+				  unsigned int offset, bool lowemi)
 {
 	bool enabled = nmk_chip->lowemi & BIT(offset);
 
@@ -271,13 +269,13 @@ static void __nmk_gpio_set_lowemi(struct nmk_gpio_chip *nmk_chip,
 }
 
 static void __nmk_gpio_make_input(struct nmk_gpio_chip *nmk_chip,
-				  unsigned offset)
+				  unsigned int offset)
 {
 	writel(BIT(offset), nmk_chip->addr + NMK_GPIO_DIRC);
 }
 
 static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
-				     unsigned offset, int gpio_mode,
+				     unsigned int offset, int gpio_mode,
 				     bool glitch)
 {
 	u32 rwimsc = nmk_chip->rwimsc;
@@ -304,7 +302,7 @@ static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
 }
 
 static void
-nmk_gpio_disable_lazy_irq(struct nmk_gpio_chip *nmk_chip, unsigned offset)
+nmk_gpio_disable_lazy_irq(struct nmk_gpio_chip *nmk_chip, unsigned int offset)
 {
 	u32 falling = nmk_chip->fimsc & BIT(offset);
 	u32 rising = nmk_chip->rimsc & BIT(offset);
@@ -343,7 +341,7 @@ static void nmk_write_masked(void __iomem *reg, u32 mask, u32 value)
 }
 
 static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
-	unsigned offset, unsigned alt_num)
+	unsigned int offset, unsigned int alt_num)
 {
 	int i;
 	u16 reg;
@@ -515,15 +513,15 @@ static int nmk_get_groups_cnt(struct pinctrl_dev *pctldev)
 }
 
 static const char *nmk_get_group_name(struct pinctrl_dev *pctldev,
-				       unsigned selector)
+				       unsigned int selector)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
 	return npct->soc->groups[selector].grp.name;
 }
 
-static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
-			      const unsigned **pins,
+static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+			      const unsigned int **pins,
 			      unsigned int *num_pins)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
@@ -533,7 +531,7 @@ static int nmk_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned pin)
+static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned int pin)
 {
 	int i;
 	struct nmk_gpio_chip *nmk_gpio;
@@ -549,7 +547,7 @@ static struct nmk_gpio_chip *find_nmk_gpio_from_pin(unsigned pin)
 	return NULL;
 }
 
-static struct gpio_chip *find_gc_from_pin(unsigned pin)
+static struct gpio_chip *find_gc_from_pin(unsigned int pin)
 {
 	struct nmk_gpio_chip *nmk_gpio = find_nmk_gpio_from_pin(pin);
 
@@ -559,7 +557,7 @@ static struct gpio_chip *find_gc_from_pin(unsigned pin)
 }
 
 static void nmk_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
-		   unsigned offset)
+		   unsigned int offset)
 {
 	struct gpio_chip *chip = find_gc_from_pin(offset);
 
@@ -570,8 +568,8 @@ static void nmk_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	nmk_gpio_dbg_show_one(s, pctldev, chip, offset - chip->base, offset);
 }
 
-static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
+static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
 		const char *function)
 {
 	if (*num_maps == *reserved_maps)
@@ -586,9 +584,9 @@ static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned *reserved_maps,
 }
 
 static int nmk_dt_add_map_configs(struct pinctrl_map **map,
-		unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
-		unsigned long *configs, unsigned num_configs)
+		unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
+		unsigned long *configs, unsigned int num_configs)
 {
 	unsigned long *dup_configs;
 
@@ -727,8 +725,8 @@ static bool nmk_pinctrl_dt_get_config(struct device_node *np,
 static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np,
 		struct pinctrl_map **map,
-		unsigned *reserved_maps,
-		unsigned *num_maps)
+		unsigned int *reserved_maps,
+		unsigned int *num_maps)
 {
 	int ret;
 	const char *function = NULL;
@@ -795,9 +793,9 @@ static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 static int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct device_node *np_config,
-				 struct pinctrl_map **map, unsigned *num_maps)
+				 struct pinctrl_map **map, unsigned int *num_maps)
 {
-	unsigned reserved_maps;
+	unsigned int reserved_maps;
 	struct device_node *np;
 	int ret;
 
@@ -835,7 +833,7 @@ static int nmk_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
 }
 
 static const char *nmk_pmx_get_func_name(struct pinctrl_dev *pctldev,
-					 unsigned function)
+					 unsigned int function)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
@@ -843,7 +841,7 @@ static const char *nmk_pmx_get_func_name(struct pinctrl_dev *pctldev,
 }
 
 static int nmk_pmx_get_func_groups(struct pinctrl_dev *pctldev,
-				   unsigned function,
+				   unsigned int function,
 				   const char * const **groups,
 				   unsigned * const num_groups)
 {
@@ -855,8 +853,8 @@ static int nmk_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
-		       unsigned group)
+static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
+		       unsigned int group)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	const struct nmk_pingroup *g;
@@ -913,7 +911,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 
 	for (i = 0; i < g->grp.npins; i++) {
 		struct nmk_gpio_chip *nmk_chip;
-		unsigned bit;
+		unsigned int bit;
 
 		nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i]);
 		if (!nmk_chip) {
@@ -966,12 +964,12 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 
 static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 				   struct pinctrl_gpio_range *range,
-				   unsigned offset)
+				   unsigned int offset)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
-	unsigned bit;
+	unsigned int bit;
 
 	if (!range) {
 		dev_err(npct->dev, "invalid range\n");
@@ -997,7 +995,7 @@ static int nmk_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 static void nmk_gpio_disable_free(struct pinctrl_dev *pctldev,
 				  struct pinctrl_gpio_range *range,
-				  unsigned offset)
+				  unsigned int offset)
 {
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1015,30 +1013,30 @@ static const struct pinmux_ops nmk_pinmux_ops = {
 	.strict = true,
 };
 
-static int nmk_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
+static int nmk_pin_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			      unsigned long *config)
 {
 	/* Not implemented */
 	return -EINVAL;
 }
 
-static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
-			      unsigned long *configs, unsigned num_configs)
+static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			      unsigned long *configs, unsigned int num_configs)
 {
-	static const char *pullnames[] = {
+	static const char * const pullnames[] = {
 		[NMK_GPIO_PULL_NONE]	= "none",
 		[NMK_GPIO_PULL_UP]	= "up",
 		[NMK_GPIO_PULL_DOWN]	= "down",
 		[3] /* illegal */	= "??"
 	};
-	static const char *slpmnames[] = {
+	static const char * const slpmnames[] = {
 		[NMK_GPIO_SLPM_INPUT]		= "input/wakeup",
 		[NMK_GPIO_SLPM_NOCHANGE]	= "no-change/no-wakeup",
 	};
 	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
 	struct nmk_gpio_chip *nmk_chip;
-	unsigned bit;
-	pin_cfg_t cfg;
+	unsigned int bit;
+	unsigned long cfg;
 	int pull, slpm, output, val, i;
 	bool lowemi, gpiomode, sleep;
 
@@ -1055,7 +1053,7 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned pin,
 		 * here we just ignore that part. It's being handled by the
 		 * framework and pinmux callback respectively.
 		 */
-		cfg = (pin_cfg_t) configs[i];
+		cfg = configs[i];
 		pull = PIN_PULL(cfg);
 		slpm = PIN_SLPM(cfg);
 		output = PIN_DIR(cfg);

-- 
2.43.1


