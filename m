Return-Path: <linux-kernel+bounces-148614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8D8A851E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01368B22B66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075EF1422B2;
	Wed, 17 Apr 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Xp0bG2gp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Q4+k6x7r"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA21420D7;
	Wed, 17 Apr 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361468; cv=none; b=OfxqUE4CkHJ0tGUqFiLLjLp7f0E2MFJCVAoXTGltq3aHhcfwf8YdJ0qfhQy370BD22JcWLFGcyIoRltUm3KtoNUp2oLJJjMJ/BiyIGHXCAiu1HUFLJnvGLl1KEYT+VL39kxhckB7pTj+scoUWDHKSw5nfS2PgnI8Rfy+g2iRVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361468; c=relaxed/simple;
	bh=yBJvo9fxw05iYnuFLCi6gZl2hY/U88+2pKil0WBPN14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOk1BPrfJsm/prR8i7bZldeiwwx2f2aau0yKtq9RVAUGDp05pgVtaL7whldpOfSQ5ILA8RwCUHd12tGJNdlpZDaXJCr711yTRm/UA/iLnvHofn/iaTJ95jpedPrDND7bi5rQTQ6Eq5wZ/Kf2A2OEGMfOKP4/fgzIXeJdK8iZUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Xp0bG2gp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Q4+k6x7r reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713361465; x=1744897465;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cTwHyBVGSzBF5RrV+Hrp9YM0PLGEUzjEGPZAV4aGLek=;
  b=Xp0bG2gpPkZqrJKSNrHYR3kTPwChZoUrypYoCpCCy/GMcZetorTEW9xK
   ZyKwNZfoilchMfgfeXyFS6bLdYgKRpmgklVCdAmSPbFBnB5H1ymqCCjEN
   ep63PdZDv2uOio5JqRFl3RVXj1WY7HO+dI6zg85bX5SMj4Yt6EZE1vHSN
   jDj362cOgDuJqwuMHMon4Bryah7/IZChmTWbd08D4hfyoVs3jqZGFMoC5
   LF2+dLe219QhdJaZA6EpBmkZ674acYlQIEX+IDMp2/Si+daWJ5sUF25kW
   UFLsGP5MArjyYHBDRRTRE+AcVA29ttDzeS4ZGzuvHSgPHXncoBWeWCkWI
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36469976"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 15:44:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DE2E173169;
	Wed, 17 Apr 2024 15:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713361458;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cTwHyBVGSzBF5RrV+Hrp9YM0PLGEUzjEGPZAV4aGLek=;
	b=Q4+k6x7rcegfhs59C7P3fF0opUq6vtUjixcnbfhcrQqWaf9aUKkMGkFHvORv/AmjU3Al1g
	tDgwRkZq5ekV1isW4a3Qotgw9vIfiONEuok9kW0GhylMnF5KxLvRLyvXxqvqI/59NMlIqu
	5ZmqYb4UZuOynOxAWQ35JlGD6taDzVM2WujY0fsCwlqVGeH3s3mE2M1+SF8JJXZbwJ693Y
	Q5jT9Qo4TfwJ9QoK0Vc3ziHaImyt7CsuaIrRTlLIXHOW0IcXmDpINurLOH7hCgdLpokPwA
	iGMQcjLWgbKYRS1Z+X+a7JKV12l0PRJBI4J4aHY67wa4Y0/pYXpu5jD9CO1aLg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 17 Apr 2024 15:43:56 +0200
Subject: [PATCH 3/4] can: mcp251xfd: add gpio functionality
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713361443; l=8827;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=yBJvo9fxw05iYnuFLCi6gZl2hY/U88+2pKil0WBPN14=;
 b=DSi00dmPgUB6iQeEXw/P/fusAlRMoZMFFi7HuTNcRk8vhnUCn8zItGByADAi8HpPT2v70tmgr
 2BGKPvBhdeJCgDhnDoa6dSeCrzkfyh4wl7YHMjvlufG7Cbok/UGNDJL
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

The mcp251xfd devices allow two pins to be configured as gpio. Add this
functionality to driver.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 138 ++++++++++++++++++++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c |  21 +++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h        |   4 +
 3 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index eb699288c076..5ba9fd0af4b6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -366,6 +367,8 @@ static int mcp251xfd_chip_wake(const struct mcp251xfd_priv *priv)
 
 static inline int mcp251xfd_chip_sleep(const struct mcp251xfd_priv *priv)
 {
+	int ret;
+
 	if (priv->pll_enable) {
 		u32 osc;
 		int err;
@@ -381,7 +384,12 @@ static inline int mcp251xfd_chip_sleep(const struct mcp251xfd_priv *priv)
 		priv->spi->max_speed_hz = priv->spi_max_speed_hz_slow;
 	}
 
-	return mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
+	ret = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_SLEEP);
+
+	regcache_cache_only(priv->map_reg, true);
+	regcache_mark_dirty(priv->map_reg);
+
+	return ret;
 }
 
 static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
@@ -389,6 +397,8 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 	const __be16 cmd = mcp251xfd_cmd_reset();
 	int err;
 
+	regcache_cache_only(priv->map_reg, false);
+
 	/* The Set Mode and SPI Reset command only works if the
 	 * controller is not in Sleep Mode.
 	 */
@@ -401,7 +411,12 @@ static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
 		return err;
 
 	/* spi_write_then_read() works with non DMA-safe buffers */
-	return spi_write_then_read(priv->spi, &cmd, sizeof(cmd), NULL, 0);
+	err = spi_write_then_read(priv->spi, &cmd, sizeof(cmd), NULL, 0);
+	if (err)
+		return err;
+
+	/* After reset restore cached register values to hardware */
+	return regcache_sync(priv->map_reg);
 }
 
 static int mcp251xfd_chip_softreset_check(const struct mcp251xfd_priv *priv)
@@ -1772,6 +1787,119 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+static const char * const mcp251xfd_gpio_names[] = {"GPIO0", "GPIO1"};
+
+static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 pin_mask = MCP251XFD_REG_IOCON_PM0 << offset;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  pin_mask, pin_mask);
+}
+
+static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+	u32 val;
+
+	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+
+	if (mask & val)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_GPIO0 << offset;
+	u32 val;
+
+	regcache_drop_region(priv->map_reg, MCP251XFD_REG_IOCON, MCP251XFD_REG_IOCON);
+	regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+
+	return !!(mask & val);
+}
+
+static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
+					   unsigned int offset, int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT0 << offset;
+	u32 val;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask | val_mask, val);
+}
+
+static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS0 << offset;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask, dir_mask);
+}
+
+static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT0 << offset;
+	u32 val;
+	int ret;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				 val_mask, val);
+	if (ret)
+		dev_warn(&priv->spi->dev,
+			 "Failed to set GPIO %u: %d\n", offset, ret);
+}
+
+static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	struct gpio_chip *gc = &priv->gc;
+
+	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
+		return 0;
+
+	if (priv->rx_int)
+		return dev_err_probe(&priv->spi->dev, -EINVAL,
+				     "Can't configure gpio-controller with RX-INT!\n");
+
+	gc->label = dev_name(&priv->spi->dev);
+	gc->parent = &priv->spi->dev;
+	gc->owner = THIS_MODULE;
+	gc->request = mcp251xfd_gpio_request;
+	gc->get_direction = mcp251xfd_gpio_get_direction;
+	gc->direction_output = mcp251xfd_gpio_direction_output;
+	gc->direction_input = mcp251xfd_gpio_direction_input;
+	gc->get = mcp251xfd_gpio_get;
+	gc->set = mcp251xfd_gpio_set;
+	gc->base = -1;
+	gc->can_sleep = true;
+	gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
+	gc->names = mcp251xfd_gpio_names;
+
+	return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
+}
+
 static int
 mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 			      u32 *effective_speed_hz_slow,
@@ -2142,6 +2270,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	if (err)
 		goto out_free_candev;
 
+	err = mcp251fdx_gpio_setup(priv);
+	if (err) {
+		dev_err_probe(&spi->dev, err, "Failed to register gpio-controller.\n");
+		goto out_free_candev;
+	}
+
 	err = mcp251xfd_register(priv);
 	if (err) {
 		dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index ab4e372baffb..868c424f22a4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -447,6 +447,21 @@ static const struct regmap_access_table mcp251xfd_reg_table = {
 	.n_yes_ranges = ARRAY_SIZE(mcp251xfd_reg_table_yes_range),
 };
 
+static bool mcp251xfd_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MCP251XFD_REG_ECCCON:
+	case MCP251XFD_REG_DEVID:
+	case MCP251XFD_REG_NBTCFG:
+	case MCP251XFD_REG_DBTCFG:
+	case MCP251XFD_REG_TDC:
+	case MCP251XFD_REG_TSCON:
+	case MCP251XFD_REG_IOCON:
+		return false;
+	}
+	return true;
+}
+
 static const struct regmap_config mcp251xfd_regmap_nocrc = {
 	.name = "nocrc",
 	.reg_bits = 16,
@@ -456,7 +471,8 @@ static const struct regmap_config mcp251xfd_regmap_nocrc = {
 	.max_register = 0xffc,
 	.wr_table = &mcp251xfd_reg_table,
 	.rd_table = &mcp251xfd_reg_table,
-	.cache_type = REGCACHE_NONE,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = mcp251xfd_volatile_reg,
 	.read_flag_mask = (__force unsigned long)
 		cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_READ),
 	.write_flag_mask = (__force unsigned long)
@@ -483,7 +499,8 @@ static const struct regmap_config mcp251xfd_regmap_crc = {
 	.max_register = 0xffc,
 	.wr_table = &mcp251xfd_reg_table,
 	.rd_table = &mcp251xfd_reg_table,
-	.cache_type = REGCACHE_NONE,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = mcp251xfd_volatile_reg,
 };
 
 static const struct regmap_bus mcp251xfd_bus_crc = {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..e2ab486862d8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -14,6 +14,7 @@
 #include <linux/can/core.h>
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -660,6 +661,9 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gc;
+#endif
 };
 
 #define MCP251XFD_IS(_model) \

-- 
2.34.1


