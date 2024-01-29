Return-Path: <linux-kernel+bounces-42844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C0284079F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DAA1C21967
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1107664B9;
	Mon, 29 Jan 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzmIW2u/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A86657CB;
	Mon, 29 Jan 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536589; cv=none; b=tqkDNmWB3s4C0nzJqcsx6HoxZPB1Ih2B53+iEANAk5wiKdRq9usOhRNmpnxEfVxWHwHHsHmW9HqflcJRDNMn6tcHc6CYhvVFaB/IQOR7Chbpf8xx3I+FZvW3ZTmASg678WfYIzeuXGPbrS9iGkns7800S1viG5SYmSH7HTiUz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536589; c=relaxed/simple;
	bh=LE0UJhi2UDP0MTQE6T2yWuU0twLWJsvTjl7WIk9UoXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKTsh5trRSW/hr64zWVLLmbfdQCXcVNpU7leqZjHrjrxh4zKJjJZcUpKii7wr/fVuet23ZVoKaFnDwC7D0EATB0VoSS/fJkeqjutJcn0fzclCpERvCLeKF+l9aG4gznWbx/Z1rtJCqMazkJ9zAPOQArbRMo3+zsCdmQMfDIkRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzmIW2u/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso24409265e9.2;
        Mon, 29 Jan 2024 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536586; x=1707141386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGZ7g8+GW2jddKqidzCnSKvqoGpmSbkCQHK3oOQ56iw=;
        b=SzmIW2u/d3iLHkbpFi97DlAkzNnOV/87Yagi7oc0/LzmRHF87OQCY8byORIMPBefEx
         fWkt+c+mRBpaTDFWuPWlw73+1zy1C6wcQCpr8Ziqd4fkU0AMQJkHZFe3w5lcmVpOYliD
         6zhOFCNJUnMPg0+bdMJcJrE4B3cFB1AILT78Je/jn2WQWqRnUQZYB8rDow5wPeB2Zr9l
         LBhCsfUIqfVQxatJe1bRw82hmwAxXm14ITd7uW5NTQm07tGl3gXSC4bVyfth3I0QH81i
         fzCq6yyfhLPDn5VhaPbK3dgWjUQ7T0n+aBNnZ7mdFilUuXR9EKXt6olj2LT5s82P2+5x
         Q0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536586; x=1707141386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGZ7g8+GW2jddKqidzCnSKvqoGpmSbkCQHK3oOQ56iw=;
        b=n/UJ0CT+beB7N/CgtpxBKIN6LW5uOiG0zWGUwTkgJsZztqJY1uBwYRNQk899d0A3mr
         yV50HTJp9fI8d3CR3JW9CBWr7IX/hwFoAO/ZlfspRa6GhGftZy5jouANA5fNpFBS80S9
         d/qA+TvYBdqrsnHTmJIClkQ4eiAeVVv8o+I+RfgqoM20g/z4atnfaWGNZHrLlhbH9Sg1
         DWTRaGBH4t+OmqNvg44r8NVDHMJ2e3O+zdiUU+0ZeVHsTfdmyzuXJVK6+AOnomN0PKE9
         ek6QKwq82CFTQ+kwkSnRAHLBCcYbz+Kaeea6So6I9QtjonjJ6ufwhBzgOreHHNJajxmG
         Ihvw==
X-Gm-Message-State: AOJu0YyNL8RxVsbDSvizqJBjN0W7eqZU/W9/5Vmx6/FmWVK5p6XNo/YM
	SPIFtgMqukPch4dynm+ff1m8Lo61ESVgUYn0OZahgFUpV/I/S6Ds
X-Google-Smtp-Source: AGHT+IFv/uY6xUhfIwCb4YZT6cAchxzBARhuGsaZylI2Hb8CKOd+mS9P+NuXisupX49ZKhDV8jEyTA==
X-Received: by 2002:adf:ff92:0:b0:33a:e791:d8a6 with SMTP id j18-20020adfff92000000b0033ae791d8a6mr3190741wrr.47.1706536585346;
        Mon, 29 Jan 2024 05:56:25 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0033aed46956csm3058057wrb.80.2024.01.29.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:56:24 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 2/4] pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() macro
Date: Mon, 29 Jan 2024 13:55:54 +0000
Message-Id: <20240129135556.63466-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Currently we assume all the port pins are sequential ie always PX_0 to
PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins P19_1 to
P28_5 which have holes in them, for example only one pin on port19 is
available and that is P19_1 and not P19_0. So to handle such cases
include pinmap for each port which would indicate the pin availability
on each port. As the pincount can be calculated based on pinmap drop this
from RZG2L_GPIO_PORT_PACK() macro.

Previously we had a max of 7 pins on each port but on RZ/Five Port-20
has 8 pins, so move the single pin configuration to BIT(63).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 56 +++++++++++++------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c7dc32176bfe..33ea5f8dc998 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -80,19 +80,20 @@
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
-#define PIN_CFG_PIN_CNT_MASK		GENMASK(30, 28)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
 #define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
 #define PIN_CFG_MASK			GENMASK(19, 0)
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_CNT_MASK, (n)) | \
+
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	((((1ULL << (n)) - 1) << 28) | \
 					 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
 					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
 
 /*
- * BIT(31) indicates dedicated pin, p is the register index while
+ * BIT(63) indicates dedicated pin, p is the register index while
  * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
  * (b * 8) and f is the pin configuration capabilities supported.
  */
-#define RZG2L_SINGLE_PIN		BIT(31)
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
 
@@ -196,12 +197,12 @@ struct rzg2l_hwcfg {
 
 struct rzg2l_dedicated_configs {
 	const char *name;
-	u32 config;
+	u64 config;
 };
 
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
-	const u32 *port_pin_configs;
+	const u64 *port_pin_configs;
 	unsigned int n_ports;
 	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
@@ -302,7 +303,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	pins = group->grp.pins;
 
 	for (i = 0; i < group->grp.npins; i++) {
-		unsigned int *pin_data = pctrl->desc.pins[pins[i]].drv_data;
+		u64 *pin_data = pctrl->desc.pins[pins[i]].drv_data;
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
@@ -565,13 +566,13 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u32 cfg, u32 port, u8 bit)
+				   u64 cfg, u32 port, u8 bit)
 {
-	u8 pincount = FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);
+	u8 pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
-	u32 data;
+	u64 data;
 
-	if (bit >= pincount || port >= pctrl->data->n_port_pins)
+	if (!(pinmap & BIT(bit)) || port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
@@ -863,7 +864,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
 	u32 off, cfg;
 	int ret;
@@ -966,7 +967,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i, arg, index;
 	u32 cfg, off;
@@ -1171,7 +1172,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	u32 *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
@@ -1203,7 +1204,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 				     bool output)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1224,7 +1225,7 @@ static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
@@ -1255,7 +1256,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1288,7 +1289,7 @@ static int rzg2l_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	u16 reg16;
@@ -1373,7 +1374,7 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 r9a07g044_gpio_configs[] = {
+static const u64 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
@@ -1425,7 +1426,7 @@ static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a07g043_gpio_configs[] = {
+static const u64 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
@@ -1447,7 +1448,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a08g045_gpio_configs[] = {
+static const u64 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)) |
@@ -1615,12 +1616,12 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_
 	bit = virq % 8;
 
 	if (port >= data->n_ports ||
-	    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[port]))
+	    bit >= hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, data->port_pin_configs[port])))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[i]);
+		gpioint += hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, data->port_pin_configs[i]));
 
 	return gpioint;
 }
@@ -1631,7 +1632,7 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1658,7 +1659,7 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1795,7 +1796,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		bit = offset % 8;
 
 		if (port >= pctrl->data->n_ports ||
-		    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, pctrl->data->port_pin_configs[port]))
+		    bit >= hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK,
+					      pctrl->data->port_pin_configs[port])))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1877,7 +1879,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
-	u32 *pin_data;
+	u64 *pin_data;
 	int ret;
 
 	pctrl->desc.name = DRV_NAME;
-- 
2.34.1


