Return-Path: <linux-kernel+bounces-5213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0781880B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CE128C7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F12B18656;
	Tue, 19 Dec 2023 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DuaD4fs8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3C1862F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336746a545fso295480f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1702990436; x=1703595236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90AFsETFiBQ92T8syUg6t+iVSilY7CpwzvHCJrI5YkQ=;
        b=DuaD4fs8BwACPBEPRbrWtTy4Rrtlv3FD3KiKtaiVCs+sRV65zzN7YhoX3H3swRaiwy
         aR69gJQ57lXvV6XdpMWvZCGijXRCuC93/ZaJsjZHUyrp9wBr1JQLPU2Q/a7TizjXV8Iz
         QhbN+DCjx3EIXU5MbSIg4KcqaJB4NAFMEmSBUQ+WyD942llAPmJ2InlHVD1ByR8pKP+s
         sE5SF710KiP7obiuRdjkB3VfPsG+JqwBO6DQJ4+o6x8GiIyc5j98RgCmh7hj1LeVduHt
         IEr/36+QO92pW+q1JrtKzPcNzNF9jJgO+woRgconcaIufSGLigG8zZXvX0iW41aptbk9
         E93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990436; x=1703595236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90AFsETFiBQ92T8syUg6t+iVSilY7CpwzvHCJrI5YkQ=;
        b=X2uNY1B707AEDFa4v0h9+8Zp3Ros0EozXC37CtdtuHjPjrbwXIGcoQbV4LTURJH4cv
         qYisCDvu+2CYsSsdXQVPGDyerS9jetcJB9dSFNoc4dGMUkV96Sx9T9YEOnl7vPxkFMC3
         g2T41fmEmQI+Ioc5/3aGXxzAec7D5j7tcZHWPUqql2szhN0f7mp0uNlNB9bF82b71aaW
         wnFm2tbOQCf+t6P8BDPpTkGZx0OIPiLNNYNNkhbBb0pixeTSuA7LLh94VORIsIeJE1Ft
         LRsYuDdxAkT4EAU6PZYMVMi/5PqWlwuqBi8fiRIjFQiCbJsjZn9bgfI4iLBnTD1G5gzh
         vfvA==
X-Gm-Message-State: AOJu0YzECGnnxWO2dqh0pjPpihCncaxprAwQy5/Om1J7iNzHPjD4oC3I
	NT8xRPdq1lKfh7lCnwbITQXZA5S0ap04RlSXGMOmXA==
X-Google-Smtp-Source: AGHT+IEdvQI32kDLw0uxcIXTpO/AeGkyUZW5M4jnD/fWwXY5ZR/gPwe05/DArwErdv5my8ooD3fx4g==
X-Received: by 2002:a5d:5444:0:b0:336:578d:1597 with SMTP id w4-20020a5d5444000000b00336578d1597mr437849wrv.16.1702990436168;
        Tue, 19 Dec 2023 04:53:56 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b003366aad3564sm4376929wrr.30.2023.12.19.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:53:55 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: cy8c95x0: Cache muxed registers
Date: Tue, 19 Dec 2023 13:53:49 +0100
Message-ID: <20231219125350.4031370-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the port specific registers behind the PORTSEL mux aren't
cached in the regmap and thus the typical setup time for a single pin
on cy8c9560 is about 200msec on our system. The hotspot is the IRQ
(un)masking, which causes lots of R/W operations.

Introduce a separate regmap for muxed registers and helper functions
to use the newly introduced regmap for muxed register access under
the i2c lock.

With the new cache in place the typical pin setup time is reduced to
20msec, making it about 10 times faster. As a side effect the system
boot time is also reduced by 50%.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 458 ++++++++++++++++++++---------
 1 file changed, 315 insertions(+), 143 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 4ccfa99ed93a..6992f522c422 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -58,6 +58,10 @@
 
 #define CY8C95X0_PIN_TO_OFFSET(x) (((x) >= 20) ? ((x) + 4) : (x))
 
+#define CY8C95X0_MUX_REGMAP_TO_PORT(x) ((x) / MUXED_STRIDE)
+#define CY8C95X0_MUX_REGMAP_TO_REG(x) (((x) % MUXED_STRIDE) + CY8C95X0_INTMASK)
+#define CY8C95X0_MUX_REGMAP_TO_OFFSET(x, p) ((x) - CY8C95X0_INTMASK + (p) * MUXED_STRIDE)
+
 static const struct i2c_device_id cy8c95x0_id[] = {
 	{ "cy8c9520", 20, },
 	{ "cy8c9540", 40, },
@@ -119,12 +123,13 @@ static const struct dmi_system_id cy8c95x0_dmi_acpi_irq_info[] = {
 #define MAX_BANK 8
 #define BANK_SZ 8
 #define MAX_LINE	(MAX_BANK * BANK_SZ)
-
+#define MUXED_STRIDE	16
 #define CY8C95X0_GPIO_MASK		GENMASK(7, 0)
 
 /**
  * struct cy8c95x0_pinctrl - driver data
- * @regmap:         Device's regmap
+ * @regmap:         Device's regmap. Only direct access registers.
+ * @muxed_regmap:   Regmap for all muxed registers.
  * @irq_lock:       IRQ bus lock
  * @i2c_lock:       Mutex for the device internal mux register
  * @irq_mask:       I/O bits affected by interrupts
@@ -147,6 +152,7 @@ static const struct dmi_system_id cy8c95x0_dmi_acpi_irq_info[] = {
  */
 struct cy8c95x0_pinctrl {
 	struct regmap *regmap;
+	struct regmap *muxed_regmap;
 	struct mutex irq_lock;
 	struct mutex i2c_lock;
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
@@ -376,6 +382,54 @@ static bool cy8c95x0_precious_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool cy8c95x0_muxed_register(unsigned int reg)
+{
+	switch (reg) {
+	case CY8C95X0_INTMASK:
+	case CY8C95X0_PWMSEL:
+	case CY8C95X0_INVERT:
+	case CY8C95X0_DIRECTION:
+	case CY8C95X0_DRV_PU:
+	case CY8C95X0_DRV_PD:
+	case CY8C95X0_DRV_ODH:
+	case CY8C95X0_DRV_ODL:
+	case CY8C95X0_DRV_PP_FAST:
+	case CY8C95X0_DRV_PP_SLOW:
+	case CY8C95X0_DRV_HIZ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cy8c95x0_wc_register(unsigned int reg)
+{
+	switch (reg) {
+	case CY8C95X0_DRV_PU:
+	case CY8C95X0_DRV_PD:
+	case CY8C95X0_DRV_ODH:
+	case CY8C95X0_DRV_ODL:
+	case CY8C95X0_DRV_PP_FAST:
+	case CY8C95X0_DRV_PP_SLOW:
+	case CY8C95X0_DRV_HIZ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cy8c95x0_quick_path_register(unsigned int reg)
+{
+	switch (reg) {
+	case CY8C95X0_INPUT_(0) ... CY8C95X0_INPUT_(7):
+	case CY8C95X0_INTSTATUS_(0) ... CY8C95X0_INTSTATUS_(7):
+	case CY8C95X0_OUTPUT_(0) ... CY8C95X0_OUTPUT_(7):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct reg_default cy8c95x0_reg_defaults[] = {
 	{ CY8C95X0_OUTPUT_(0), GENMASK(7, 0) },
 	{ CY8C95X0_OUTPUT_(1), GENMASK(7, 0) },
@@ -389,7 +443,89 @@ static const struct reg_default cy8c95x0_reg_defaults[] = {
 	{ CY8C95X0_PWMSEL, 0 },
 };
 
+static int
+cy8c95x0_mux_reg_read(void *context, unsigned int off, unsigned int *val)
+{
+	struct cy8c95x0_pinctrl *chip = context;
+	u8 port = CY8C95X0_MUX_REGMAP_TO_PORT(off);
+	int ret, reg = CY8C95X0_MUX_REGMAP_TO_REG(off);
+
+	mutex_lock(&chip->i2c_lock);
+	/* Select the correct bank */
+	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Read the register through direct access regmap. The target range
+	 * is marked volatile.
+	 */
+	ret = regmap_read(chip->regmap, reg, val);
+out:
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
+static int
+cy8c95x0_mux_reg_write(void *context, unsigned int off, unsigned int val)
+{
+	struct cy8c95x0_pinctrl *chip = context;
+	u8 port = CY8C95X0_MUX_REGMAP_TO_PORT(off);
+	int ret, reg = CY8C95X0_MUX_REGMAP_TO_REG(off);
+
+	mutex_lock(&chip->i2c_lock);
+	/* Select the correct bank */
+	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Write the register through direct access regmap. The target range
+	 * is marked volatile.
+	 */
+	ret = regmap_write(chip->regmap, reg, val);
+out:
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
+}
+
+static bool cy8c95x0_mux_accessible_register(struct device *dev, unsigned int off)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct cy8c95x0_pinctrl *chip = i2c_get_clientdata(i2c);
+	u8 port = CY8C95X0_MUX_REGMAP_TO_PORT(off);
+	u8 reg = CY8C95X0_MUX_REGMAP_TO_REG(off);
+
+	if (port >= chip->nport)
+		return false;
+
+	return cy8c95x0_muxed_register(reg);
+}
+
+static struct regmap_bus cy8c95x0_regmap_bus = {
+	.reg_read = cy8c95x0_mux_reg_read,
+	.reg_write = cy8c95x0_mux_reg_write,
+};
+
+/* Regmap for muxed registers CY8C95X0_INTMASK - CY8C95X0_DRV_HIZ */
+static const struct regmap_config cy8c95x0_muxed_regmap = {
+	.name = "muxed",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_FLAT,
+	.use_single_read = true,
+	.use_single_write = true,
+	.max_register = MUXED_STRIDE * BANK_SZ,
+	.num_reg_defaults_raw = MUXED_STRIDE * BANK_SZ,
+	.readable_reg = cy8c95x0_mux_accessible_register,
+	.writeable_reg = cy8c95x0_mux_accessible_register,
+};
+
+/* Direct access regmap */
 static const struct regmap_config cy8c95x0_i2c_regmap = {
+	.name = "direct",
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -405,6 +541,147 @@ static const struct regmap_config cy8c95x0_i2c_regmap = {
 	.max_register = CY8C95X0_COMMAND,
 };
 
+static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip,
+						   unsigned int reg,
+						   unsigned int port,
+						   unsigned int mask,
+						   unsigned int val,
+						   bool *change, bool async,
+						   bool force)
+{
+	struct regmap *regmap;
+	int ret, off, i, read_val;
+
+	/* Caller should never modify PORTSEL directly */
+	if (reg == CY8C95X0_PORTSEL)
+		return -EINVAL;
+
+	/* Registers behind the PORTSEL mux have their own regmap */
+	if (cy8c95x0_muxed_register(reg)) {
+		regmap = chip->muxed_regmap;
+		off = CY8C95X0_MUX_REGMAP_TO_OFFSET(reg, port);
+	} else {
+		regmap = chip->regmap;
+		/* Quick path direct access registers honor the port argument */
+		if (cy8c95x0_quick_path_register(reg))
+			off = reg + port;
+		else
+			off = reg;
+	}
+
+	ret = regmap_update_bits_base(regmap, off, mask, val, change, async, force);
+	if (ret < 0)
+		return ret;
+
+	/* Update the cache when a WC bit is written */
+	if (cy8c95x0_wc_register(reg) && (mask & val)) {
+		for (i = CY8C95X0_DRV_PU; i <= CY8C95X0_DRV_HIZ; i++) {
+			if (i == reg)
+				continue;
+			off = CY8C95X0_MUX_REGMAP_TO_OFFSET(i, port);
+
+			ret = regmap_read(regmap, off, &read_val);
+			if (ret < 0)
+				continue;
+
+			if (!(read_val & mask & val))
+				continue;
+
+			regcache_cache_only(regmap, true);
+			regmap_update_bits(regmap, off, mask & val, 0);
+			regcache_cache_only(regmap, false);
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * cy8c95x0_regmap_write_bits() - writes a register using the regmap cache
+ * @chip: The pinctrl to work on
+ * @reg: The register to write to. Can be direct access or muxed register.
+ *       MUST NOT be the PORTSEL register.
+ * @port: The port to be used for muxed registers or quick path direct access
+ *        registers. Otherwise unused.
+ * @mask: Bitmask to change
+ * @val: New value for bitmask
+ *
+ * This function handles the register writes to the direct access registers and
+ * the muxed registers while caching all register accesses, internally handling
+ * the correct state of the PORTSEL register and protecting the access to muxed
+ * registers.
+ * The caller must only use this function to change registers behind the PORTSEL mux.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int cy8c95x0_regmap_write_bits(struct cy8c95x0_pinctrl *chip, unsigned int reg,
+				      unsigned int port, unsigned int mask, unsigned int val)
+{
+	return cy8c95x0_regmap_update_bits_base(chip, reg, port, mask, val, NULL, false, true);
+}
+
+/**
+ * cy8c95x0_regmap_update_bits() - updates a register using the regmap cache
+ * @chip: The pinctrl to work on
+ * @reg: The register to write to. Can be direct access or muxed register.
+ *       MUST NOT be the PORTSEL register.
+ * @port: The port to be used for muxed registers or quick path direct access
+ *        registers. Otherwise unused.
+ * @mask: Bitmask to change
+ * @val: New value for bitmask
+ *
+ * This function handles the register updates to the direct access registers and
+ * the muxed registers while caching all register accesses, internally handling
+ * the correct state of the PORTSEL register and protecting the access to muxed
+ * registers.
+ * The caller must only use this function to change registers behind the PORTSEL mux.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int cy8c95x0_regmap_update_bits(struct cy8c95x0_pinctrl *chip, unsigned int reg,
+				       unsigned int port, unsigned int mask, unsigned int val)
+{
+	return cy8c95x0_regmap_update_bits_base(chip, reg, port, mask, val, NULL, false, false);
+}
+
+/**
+ * cy8c95x0_regmap_read() - reads a register using the regmap cache
+ * @chip: The pinctrl to work on
+ * @reg: The register to read from. Can be direct access or muxed register.
+ * @port: The port to be used for muxed registers or quick path direct access
+ *        registers. Otherwise unused.
+ * @read_val: Value read from hardware or cache
+ *
+ * This function handles the register reads from the direct access registers and
+ * the muxed registers while caching all register accesses, internally handling
+ * the correct state of the PORTSEL register and protecting the access to muxed
+ * registers.
+ * The caller must only use this function to read registers behind the PORTSEL mux.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int cy8c95x0_regmap_read(struct cy8c95x0_pinctrl *chip, unsigned int reg,
+				unsigned int port, unsigned int *read_val)
+{
+	struct regmap *regmap;
+	int off;
+
+	/* Registers behind the PORTSEL mux have their own regmap */
+	if (cy8c95x0_muxed_register(reg)) {
+		regmap = chip->muxed_regmap;
+		off = CY8C95X0_MUX_REGMAP_TO_OFFSET(reg, port);
+	} else {
+		regmap = chip->regmap;
+		/* Quick path direct access registers honor the port argument */
+		if (cy8c95x0_quick_path_register(reg))
+			off = reg + port;
+		else
+			off = reg;
+	}
+
+	return regmap_read(regmap, off, read_val);
+}
+
 static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 				    unsigned long *val, unsigned long *mask)
 {
@@ -412,7 +689,7 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	DECLARE_BITMAP(tval, MAX_LINE);
 	int write_val;
 	int ret = 0;
-	int i, off = 0;
+	int i;
 	u8 bits;
 
 	/* Add the 4 bit gap of Gport2 */
@@ -424,53 +701,22 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	bitmap_shift_left(tval, tval, 4, MAX_LINE);
 	bitmap_replace(tval, tval, val, chip->shiftmask, BANK_SZ * 3);
 
-	mutex_lock(&chip->i2c_lock);
 	for (i = 0; i < chip->nport; i++) {
 		/* Skip over unused banks */
 		bits = bitmap_get_value8(tmask, i * BANK_SZ);
 		if (!bits)
 			continue;
 
-		switch (reg) {
-		/* Muxed registers */
-		case CY8C95X0_INTMASK:
-		case CY8C95X0_PWMSEL:
-		case CY8C95X0_INVERT:
-		case CY8C95X0_DIRECTION:
-		case CY8C95X0_DRV_PU:
-		case CY8C95X0_DRV_PD:
-		case CY8C95X0_DRV_ODH:
-		case CY8C95X0_DRV_ODL:
-		case CY8C95X0_DRV_PP_FAST:
-		case CY8C95X0_DRV_PP_SLOW:
-		case CY8C95X0_DRV_HIZ:
-			ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, i);
-			if (ret < 0)
-				goto out;
-			off = reg;
-			break;
-		/* Direct access registers */
-		case CY8C95X0_INPUT:
-		case CY8C95X0_OUTPUT:
-		case CY8C95X0_INTSTATUS:
-			off = reg + i;
-			break;
-		default:
-			ret = -EINVAL;
-			goto out;
-		}
-
 		write_val = bitmap_get_value8(tval, i * BANK_SZ);
 
-		ret = regmap_update_bits(chip->regmap, off, bits, write_val);
+		ret = cy8c95x0_regmap_update_bits(chip, reg, i, bits, write_val);
 		if (ret < 0)
 			goto out;
 	}
 out:
-	mutex_unlock(&chip->i2c_lock);
 
 	if (ret < 0)
-		dev_err(chip->dev, "failed writing register %d: err %d\n", off, ret);
+		dev_err(chip->dev, "failed writing register %d, port %d: err %d\n", reg, i, ret);
 
 	return ret;
 }
@@ -483,7 +729,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	DECLARE_BITMAP(tmp, MAX_LINE);
 	int read_val;
 	int ret = 0;
-	int i, off = 0;
+	int i;
 	u8 bits;
 
 	/* Add the 4 bit gap of Gport2 */
@@ -495,43 +741,13 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	bitmap_shift_left(tval, tval, 4, MAX_LINE);
 	bitmap_replace(tval, tval, val, chip->shiftmask, BANK_SZ * 3);
 
-	mutex_lock(&chip->i2c_lock);
 	for (i = 0; i < chip->nport; i++) {
 		/* Skip over unused banks */
 		bits = bitmap_get_value8(tmask, i * BANK_SZ);
 		if (!bits)
 			continue;
 
-		switch (reg) {
-		/* Muxed registers */
-		case CY8C95X0_INTMASK:
-		case CY8C95X0_PWMSEL:
-		case CY8C95X0_INVERT:
-		case CY8C95X0_DIRECTION:
-		case CY8C95X0_DRV_PU:
-		case CY8C95X0_DRV_PD:
-		case CY8C95X0_DRV_ODH:
-		case CY8C95X0_DRV_ODL:
-		case CY8C95X0_DRV_PP_FAST:
-		case CY8C95X0_DRV_PP_SLOW:
-		case CY8C95X0_DRV_HIZ:
-			ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, i);
-			if (ret < 0)
-				goto out;
-			off = reg;
-			break;
-		/* Direct access registers */
-		case CY8C95X0_INPUT:
-		case CY8C95X0_OUTPUT:
-		case CY8C95X0_INTSTATUS:
-			off = reg + i;
-			break;
-		default:
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = regmap_read(chip->regmap, off, &read_val);
+		ret = cy8c95x0_regmap_read(chip, reg, i, &read_val);
 		if (ret < 0)
 			goto out;
 
@@ -545,10 +761,8 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
 	bitmap_replace(val, tmp, tval, chip->shiftmask, MAX_LINE);
 
 out:
-	mutex_unlock(&chip->i2c_lock);
-
 	if (ret < 0)
-		dev_err(chip->dev, "failed reading register %d: err %d\n", off, ret);
+		dev_err(chip->dev, "failed reading register %d, port %d: err %d\n", reg, i, ret);
 
 	return ret;
 }
@@ -563,12 +777,11 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 {
 	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
 	u8 port = cypress_get_port(chip, off);
-	u8 outreg = CY8C95X0_OUTPUT_(port);
 	u8 bit = cypress_get_pin_mask(chip, off);
 	int ret;
 
 	/* Set output level */
-	ret = regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
+	ret = cy8c95x0_regmap_write_bits(chip, CY8C95X0_OUTPUT, port, bit, val ? bit : 0);
 	if (ret)
 		return ret;
 
@@ -578,12 +791,12 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
 static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
 {
 	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
-	u8 inreg = CY8C95X0_INPUT_(cypress_get_port(chip, off));
+	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 	u32 reg_val;
 	int ret;
 
-	ret = regmap_read(chip->regmap, inreg, &reg_val);
+	ret = cy8c95x0_regmap_read(chip, CY8C95X0_INPUT, port, &reg_val);
 	if (ret < 0) {
 		/*
 		 * NOTE:
@@ -601,10 +814,10 @@ static void cy8c95x0_gpio_set_value(struct gpio_chip *gc, unsigned int off,
 				    int val)
 {
 	struct cy8c95x0_pinctrl *chip = gpiochip_get_data(gc);
-	u8 outreg = CY8C95X0_OUTPUT_(cypress_get_port(chip, off));
+	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
 
-	regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
+	cy8c95x0_regmap_write_bits(chip, CY8C95X0_OUTPUT, port, bit, val ? bit : 0);
 }
 
 static int cy8c95x0_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
@@ -615,24 +828,15 @@ static int cy8c95x0_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
 	u32 reg_val;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_read(chip->regmap, CY8C95X0_DIRECTION, &reg_val);
+	ret = cy8c95x0_regmap_read(chip, CY8C95X0_DIRECTION, port, &reg_val);
 	if (ret < 0)
 		goto out;
 
-	mutex_unlock(&chip->i2c_lock);
-
 	if (reg_val & bit)
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
 out:
-	mutex_unlock(&chip->i2c_lock);
 	return ret;
 }
 
@@ -648,13 +852,6 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 	u16 arg = 0;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-
-	/* Select port */
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret < 0)
-		goto out;
-
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
 		reg = CY8C95X0_DRV_PU;
@@ -681,7 +878,7 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 		reg = CY8C95X0_PWMSEL;
 		break;
 	case PIN_CONFIG_OUTPUT:
-		reg = CY8C95X0_OUTPUT_(port);
+		reg = CY8C95X0_OUTPUT;
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		reg = CY8C95X0_DIRECTION;
@@ -709,14 +906,15 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 	 * Writing 1 to one of the drive mode registers will automatically
 	 * clear conflicting set bits in the other drive mode registers.
 	 */
-	ret = regmap_read(chip->regmap, reg, &reg_val);
+	ret = cy8c95x0_regmap_read(chip, reg, port, &reg_val);
+	if (ret < 0)
+		goto out;
+
 	if (reg_val & bit)
 		arg = 1;
 
 	*config = pinconf_to_config_packed(param, (u16)arg);
 out:
-	mutex_unlock(&chip->i2c_lock);
-
 	return ret;
 }
 
@@ -730,13 +928,6 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	unsigned int reg;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-
-	/* Select port */
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret < 0)
-		goto out;
-
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
 		__clear_bit(off, chip->push_pull);
@@ -773,10 +964,8 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 	 * Writing 1 to one of the drive mode registers will automatically
 	 * clear conflicting set bits in the other drive mode registers.
 	 */
-	ret = regmap_write_bits(chip->regmap, reg, bit, bit);
-
+	ret = cy8c95x0_regmap_write_bits(chip, reg, port, bit, bit);
 out:
-	mutex_unlock(&chip->i2c_lock);
 	return ret;
 }
 
@@ -1093,14 +1282,8 @@ static int cy8c95x0_set_mode(struct cy8c95x0_pinctrl *chip, unsigned int off, bo
 {
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
-	int ret;
 
-	/* Select port */
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret < 0)
-		return ret;
-
-	return regmap_write_bits(chip->regmap, CY8C95X0_PWMSEL, bit, mode ? bit : 0);
+	return cy8c95x0_regmap_write_bits(chip, CY8C95X0_PWMSEL, port, bit, mode ? bit : 0);
 }
 
 static int cy8c95x0_pinmux_mode(struct cy8c95x0_pinctrl *chip,
@@ -1118,24 +1301,19 @@ static int cy8c95x0_pinmux_mode(struct cy8c95x0_pinctrl *chip,
 		return 0;
 
 	/* Set direction to output & set output to 1 so that PWM can work */
-	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, bit);
+	ret = cy8c95x0_regmap_write_bits(chip, CY8C95X0_DIRECTION, port, bit, bit);
 	if (ret < 0)
 		return ret;
 
-	return regmap_write_bits(chip->regmap, CY8C95X0_OUTPUT_(port), bit, bit);
+	return cy8c95x0_regmap_write_bits(chip, CY8C95X0_OUTPUT, port, bit, bit);
 }
 
 static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 			    unsigned int group)
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
-	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = cy8c95x0_pinmux_mode(chip, selector, group);
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return cy8c95x0_pinmux_mode(chip, selector, group);
 }
 
 static int cy8c95x0_gpio_request_enable(struct pinctrl_dev *pctldev,
@@ -1143,13 +1321,8 @@ static int cy8c95x0_gpio_request_enable(struct pinctrl_dev *pctldev,
 					unsigned int pin)
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
-	int ret;
-
-	mutex_lock(&chip->i2c_lock);
-	ret = cy8c95x0_set_mode(chip, pin, false);
-	mutex_unlock(&chip->i2c_lock);
 
-	return ret;
+	return cy8c95x0_set_mode(chip, pin, false);
 }
 
 static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
@@ -1159,13 +1332,7 @@ static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
 	u8 bit = cypress_get_pin_mask(chip, pin);
 	int ret;
 
-	/* Select port... */
-	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
-	if (ret)
-		return ret;
-
-	/* ...then direction */
-	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, input ? bit : 0);
+	ret = cy8c95x0_regmap_write_bits(chip, CY8C95X0_DIRECTION, port, bit, input ? bit : 0);
 	if (ret)
 		return ret;
 
@@ -1174,7 +1341,7 @@ static int cy8c95x0_pinmux_direction(struct cy8c95x0_pinctrl *chip,
 	 * the direction register isn't sufficient in Push-Pull mode.
 	 */
 	if (input && test_bit(pin, chip->push_pull)) {
-		ret = regmap_write_bits(chip->regmap, CY8C95X0_DRV_HIZ, bit, bit);
+		ret = cy8c95x0_regmap_write_bits(chip, CY8C95X0_DRV_HIZ, port, bit, bit);
 		if (ret)
 			return ret;
 
@@ -1189,13 +1356,8 @@ static int cy8c95x0_gpio_set_direction(struct pinctrl_dev *pctldev,
 				       unsigned int pin, bool input)
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
-	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = cy8c95x0_pinmux_direction(chip, pin, input);
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return cy8c95x0_pinmux_direction(chip, pin, input);
 }
 
 static const struct pinmux_ops cy8c95x0_pmxops = {
@@ -1397,12 +1559,22 @@ static int cy8c95x0_probe(struct i2c_client *client)
 		gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
 	}
 
+	/* Generic regmap for direct access registers */
 	chip->regmap = devm_regmap_init_i2c(client, &cy8c95x0_i2c_regmap);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
 		goto err_exit;
 	}
 
+	/* Port specific regmap behind PORTSEL mux */
+	chip->muxed_regmap = devm_regmap_init(&client->dev, &cy8c95x0_regmap_bus,
+					      chip, &cy8c95x0_muxed_regmap);
+	if (IS_ERR(chip->muxed_regmap)) {
+		ret = dev_err_probe(&client->dev, PTR_ERR(chip->muxed_regmap),
+				    "Failed to register muxed regmap\n");
+		goto err_exit;
+	}
+
 	bitmap_zero(chip->push_pull, MAX_LINE);
 	bitmap_zero(chip->shiftmask, MAX_LINE);
 	bitmap_set(chip->shiftmask, 0, 20);
-- 
2.43.0


