Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B47DAE94
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjJ2V16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjJ2V1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:27:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9AAC0;
        Sun, 29 Oct 2023 14:27:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CCE45C0165;
        Sun, 29 Oct 2023 17:27:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 29 Oct 2023 17:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698614866; x=1698701266; bh=sPSgcwKkfnrqnXpSyrNRl5PfjZhAo3I6N64
        oZP29y7A=; b=h2vohgyZZXX+Yjue3st/rNZRIQvNRnn0/TtFRbqufHxcl6kIuj3
        zH+0Sa7x++cguO47kxSjCfpMpAcWg4HQQAL2o9PmF4GYKwLCTMWbT2MjYDYvmZGz
        xk/kkFzzUACfoZdhw7qE9/E6tpMRM9ikNlKY4/eQdB/VDcxiafISNryNXyHeJhDk
        vkWNHExMFl+uKsyt//MRfzAKCDSTZ53Fh2zXyIFE12YR3SU/QRaZjeHKKnlOvJJx
        lpv4Dmu4VXMEWshcf/zat8zM/6x78FaCsPLvzJqZg6FhBlohhkD7GQ4MiXsJuDVr
        sm9QCLql8FQVH0s78rtM2IUrCEdeEeqJaLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698614866; x=1698701266; bh=sPSgcwKkfnrqnXpSyrNRl5PfjZhAo3I6N64
        oZP29y7A=; b=I/iLbdObcYo+Vn2VR47kn9Uh+DuGcm5p0nEvM0ja98+SIb+2c/b
        0qEfGB75pM914DRQp5vRqO3ctg6KUg/FRji9f0ym0HMdur9W/qUQtt0yiFSLONX3
        oFGDVGRAGD2/ggBm1Fkbw9VwEWNCoanVM95ouc2s9PlRRV92nF2mqwcgSjlliJDu
        Jq5KjOVnXLMwdPimcWfU4eNMNkuH5ocxVBjXPyZHP1EN7V5Gexh19QZLpdC7Mchl
        lCY1Ha/QaVSbWSpRiQpKqe/6yKpfDBEGjj8hVn5GDkg0RXUKy+Ej762fxiqSsG/+
        6dZ3VZZ6Kqd6pIp64tcxyz84Sb6xCcGZBVA==
X-ME-Sender: <xms:Us4-ZdGXIjdPc7yJF685pKwR2jCJ3Hfp2x71Y2rMegDIv75DZt7SgA>
    <xme:Us4-ZSWGwghoOeMsAfFemFaI8rTnIYC9Z9HBvt6PsPwC2CeomstzJb6988gvkZ2p2
    lBM1aOsNc3tQ45swA>
X-ME-Received: <xmr:Us4-ZfKz1DYKbY_TK-maA0jBOut3KzmIbFhnZCIoRZ305TUe6MfXaj64Q4p2aF6GtXZOpbCibbW1VGcreIuOCtjuffdMA0CiZIgi03tx_UwPkEN1ThD945uEqRM0_Vbs0dM-Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefueevueeffeelheelhfelgeelgffgieekffevteefveejueei
    teeugfefieehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Us4-ZTF2N3aL51_tcxSV1JtcaO-bca2HicRGDlUhXr3MLyXhW2Y4vA>
    <xmx:Us4-ZTUdPdmLL_95iJDUxr6CqefcOKeHrHuYkqeI8dShMcRsl_Ea7w>
    <xmx:Us4-ZeOpBcu2wZOMa97qm--Iu6BltR-M6tDd9oFAemDWwt50l7p72w>
    <xmx:Us4-ZZ1shgMvE7qNlr3rHUL9GVll64kcCoSQeXzygVuyttvu-PV1Cw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 17:27:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        John Watts <contact@jookia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Trevor Woerner <twoerner@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v8 2/5] leds: sun50i-a100: New driver for the A100 LED controller
Date:   Sun, 29 Oct 2023 16:26:56 -0500
Message-ID: <20231029212738.7871-3-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029212738.7871-1-samuel@sholland.org>
References: <20231029212738.7871-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner sunxi SoCs, starting with the A100, contain an LED
controller designed to drive RGB LED pixels. Add a driver for it using
the multicolor LED framework, and with LEDs defined in the device tree.

Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v8:
 - Fix spelling in the Kconfig description
 - Fix the file header comment style
 - Wrap to 100 columns instead of 80
 - Use GENMASK for register bit fields
 - Use FIELD_PREP for setting all multiple-bit register fields
 - Add and use the LEDC_CHANNELS_PER_LED macro
 - Make length and offset variables unsigned to avoid mixed signedness
 - Add __counted_by for sun50i_a100_ledc::leds
 - Move the new/existing xfer logic out of sun50i_a100_ledc_pio_xfer()
 - Get the FIFO usage from INT_STS instead of assuming it is half full
 - Make the DMA channel optional; always use PIO if it is unavailable
 - Set up DMA before triggering the LEDC transfer to avoid underrun
 - Correctly enable/disable the DRQ for each transfer
 - Use more descriptive names for variables containing register values
 - Add blank lines and comments to improve readability
 - Add a comment explaining the write to the status register
 - Remove unnecessary debugging prints
 - Use the more-idiomatic post-increment operator in for loops
 - Allow gaps in child node 'reg' values (separate max_addr/num_leds)
 - Use device-managed allocation for the DMA buffer
 - Unregister LEDs before shutting down the controller to correctly
   respect LED_RETAIN_AT_SHUTDOWN (or lack thereof)
 - Use the .remove_new platform driver hook

Changes in v7:
 - Use DEFINE_SIMPLE_DEV_PM_OPS

Changes in v5:
 - Rename the driver R329 -> A100, since that is the actual original
   implementation

Changes in v4:
 - Depend on LEDS_CLASS_MULTICOLOR

Changes in v3:
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware
 - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa

Changes in v2:
 - Renamed from sunxi-ledc to sun50i-r329-ledc
 - Added missing "static" to functions/globals as reported by 0day bot

 drivers/leds/Kconfig            |   9 +
 drivers/leds/Makefile           |   1 +
 drivers/leds/leds-sun50i-a100.c | 580 ++++++++++++++++++++++++++++++++
 3 files changed, 590 insertions(+)
 create mode 100644 drivers/leds/leds-sun50i-a100.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b92208eccdea..bfc5af75761e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -297,6 +297,15 @@ config LEDS_COBALT_RAQ
 	help
 	  This option enables support for the Cobalt Raq series LEDs.
 
+config LEDS_SUN50I_A100
+	tristate "LED support for Allwinner A100 RGB LED controller"
+	depends on LEDS_CLASS_MULTICOLOR && OF
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  This option enables support for the RGB LED controller found
+	  in some Allwinner sunxi SoCs, including A100, R329, and D1.
+	  It uses a one-wire interface to control up to 1024 LEDs.
+
 config LEDS_SUNFIRE
 	tristate "LED support for SunFire servers."
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d7348e8bc019..b82a538e3f8c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
 obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
+obj-$(CONFIG_LEDS_SUN50I_A100)		+= leds-sun50i-a100.o
 obj-$(CONFIG_LEDS_SUNFIRE)		+= leds-sunfire.o
 obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
 obj-$(CONFIG_LEDS_TCA6507)		+= leds-tca6507.o
diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-sun50i-a100.c
new file mode 100644
index 000000000000..e4a7e692a908
--- /dev/null
+++ b/drivers/leds/leds-sun50i-a100.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2023 Samuel Holland <samuel@sholland.org>
+ *
+ * Partly based on drivers/leds/leds-turris-omnia.c, which is:
+ *     Copyright (c) 2020 by Marek Behún <kabel@kernel.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define LEDC_CTRL_REG			0x0000
+#define LEDC_CTRL_REG_DATA_LENGTH		GENMASK(28, 16)
+#define LEDC_CTRL_REG_RGB_MODE			GENMASK(8, 6)
+#define LEDC_CTRL_REG_LEDC_EN			BIT(0)
+#define LEDC_T01_TIMING_CTRL_REG	0x0004
+#define LEDC_T01_TIMING_CTRL_REG_T1H		GENMASK(26, 21)
+#define LEDC_T01_TIMING_CTRL_REG_T1L		GENMASK(20, 16)
+#define LEDC_T01_TIMING_CTRL_REG_T0H		GENMASK(10, 6)
+#define LEDC_T01_TIMING_CTRL_REG_T0L		GENMASK(5, 0)
+#define LEDC_RESET_TIMING_CTRL_REG	0x000c
+#define LEDC_RESET_TIMING_CTRL_REG_TR		GENMASK(28, 16)
+#define LEDC_RESET_TIMING_CTRL_REG_LED_NUM	GENMASK(9, 0)
+#define LEDC_DATA_REG			0x0014
+#define LEDC_DMA_CTRL_REG		0x0018
+#define LEDC_DMA_CTRL_REG_DMA_EN		BIT(5)
+#define LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL	GENMASK(4, 0)
+#define LEDC_INT_CTRL_REG		0x001c
+#define LEDC_INT_CTRL_REG_GLOBAL_INT_EN		BIT(5)
+#define LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN	BIT(1)
+#define LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN	BIT(0)
+#define LEDC_INT_STS_REG		0x0020
+#define LEDC_INT_STS_REG_FIFO_WLW		GENMASK(15, 10)
+#define LEDC_INT_STS_REG_FIFO_CPUREQ_INT	BIT(1)
+#define LEDC_INT_STS_REG_TRANS_FINISH_INT	BIT(0)
+
+#define LEDC_FIFO_DEPTH			32U
+#define LEDC_MAX_LEDS			1024
+#define LEDC_CHANNELS_PER_LED		3 /* RGB */
+
+#define LEDS_TO_BYTES(n)		((n) * sizeof(u32))
+
+struct sun50i_a100_ledc_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled_info[LEDC_CHANNELS_PER_LED];
+	u32 addr;
+};
+
+#define to_ledc_led(mc) container_of(mc, struct sun50i_a100_ledc_led, mc_cdev)
+
+struct sun50i_a100_ledc_timing {
+	u32 t0h_ns;
+	u32 t0l_ns;
+	u32 t1h_ns;
+	u32 t1l_ns;
+	u32 treset_ns;
+};
+
+struct sun50i_a100_ledc {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *bus_clk;
+	struct clk *mod_clk;
+	struct reset_control *reset;
+
+	u32 *buffer;
+	struct dma_chan *dma_chan;
+	dma_addr_t dma_handle;
+	unsigned int pio_length;
+	unsigned int pio_offset;
+
+	spinlock_t lock;
+	unsigned int next_length;
+	bool xfer_active;
+
+	u32 format;
+	struct sun50i_a100_ledc_timing timing;
+
+	u32 max_addr;
+	u32 num_leds;
+	struct sun50i_a100_ledc_led leds[] __counted_by(num_leds);
+};
+
+static int sun50i_a100_ledc_dma_xfer(struct sun50i_a100_ledc *priv, unsigned int length)
+{
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+
+	desc = dmaengine_prep_slave_single(priv->dma_chan, priv->dma_handle,
+					   LEDS_TO_BYTES(length), DMA_MEM_TO_DEV, 0);
+	if (!desc)
+		return -ENOMEM;
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return -EIO;
+
+	dma_async_issue_pending(priv->dma_chan);
+
+	return 0;
+}
+
+static void sun50i_a100_ledc_pio_xfer(struct sun50i_a100_ledc *priv, unsigned int fifo_used)
+{
+	unsigned int burst, length, offset;
+	u32 control;
+
+	length = priv->pio_length;
+	offset = priv->pio_offset;
+	burst  = min(length, LEDC_FIFO_DEPTH - fifo_used);
+
+	iowrite32_rep(priv->base + LEDC_DATA_REG, priv->buffer + offset, burst);
+
+	if (burst < length) {
+		priv->pio_length = length - burst;
+		priv->pio_offset = offset + burst;
+
+		if (!offset) {
+			control = readl(priv->base + LEDC_INT_CTRL_REG);
+			control |= LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
+			writel(control, priv->base + LEDC_INT_CTRL_REG);
+		}
+	} else {
+		/* Disable the request IRQ once all data is written. */
+		control = readl(priv->base + LEDC_INT_CTRL_REG);
+		control &= ~LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
+		writel(control, priv->base + LEDC_INT_CTRL_REG);
+	}
+}
+
+static void sun50i_a100_ledc_start_xfer(struct sun50i_a100_ledc *priv, unsigned int length)
+{
+	bool use_dma = false;
+	u32 control;
+
+	if (priv->dma_chan && length > LEDC_FIFO_DEPTH) {
+		int ret;
+
+		ret = sun50i_a100_ledc_dma_xfer(priv, length);
+		if (ret)
+			dev_warn(priv->dev, "Failed to set up DMA (%d), using PIO\n", ret);
+		else
+			use_dma = true;
+	}
+
+	/* The DMA trigger level must be at least the burst length. */
+	control = FIELD_PREP(LEDC_DMA_CTRL_REG_DMA_EN, use_dma) |
+		  FIELD_PREP_CONST(LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL, LEDC_FIFO_DEPTH / 2);
+	writel(control, priv->base + LEDC_DMA_CTRL_REG);
+
+	control = readl(priv->base + LEDC_CTRL_REG);
+	control &= ~LEDC_CTRL_REG_DATA_LENGTH;
+	control |= FIELD_PREP(LEDC_CTRL_REG_DATA_LENGTH, length) | LEDC_CTRL_REG_LEDC_EN;
+	writel(control, priv->base + LEDC_CTRL_REG);
+
+	if (!use_dma) {
+		/* The FIFO is empty when starting a new transfer. */
+		unsigned int fifo_used = 0;
+
+		priv->pio_length = length;
+		priv->pio_offset = 0;
+
+		sun50i_a100_ledc_pio_xfer(priv, fifo_used);
+	}
+}
+
+static irqreturn_t sun50i_a100_ledc_irq(int irq, void *data)
+{
+	struct sun50i_a100_ledc *priv = data;
+	u32 status;
+
+	status = readl(priv->base + LEDC_INT_STS_REG);
+
+	if (status & LEDC_INT_STS_REG_TRANS_FINISH_INT) {
+		unsigned int next_length;
+
+		spin_lock(&priv->lock);
+
+		/* If another transfer is queued, dequeue and start it. */
+		next_length = priv->next_length;
+		if (next_length)
+			priv->next_length = 0;
+		else
+			priv->xfer_active = false;
+
+		spin_unlock(&priv->lock);
+
+		if (next_length)
+			sun50i_a100_ledc_start_xfer(priv, next_length);
+	} else if (status & LEDC_INT_STS_REG_FIFO_CPUREQ_INT) {
+		/* Continue the current transfer. */
+		sun50i_a100_ledc_pio_xfer(priv, FIELD_GET(LEDC_INT_STS_REG_FIFO_WLW, status));
+	}
+
+	/* Clear the W1C status bits. */
+	writel(status, priv->base + LEDC_INT_STS_REG);
+
+	return IRQ_HANDLED;
+}
+
+static void sun50i_a100_ledc_brightness_set(struct led_classdev *cdev,
+					    enum led_brightness brightness)
+{
+	struct sun50i_a100_ledc *priv = dev_get_drvdata(cdev->dev->parent);
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct sun50i_a100_ledc_led *led = to_ledc_led(mc_cdev);
+	unsigned int next_length;
+	unsigned long flags;
+	bool xfer_active;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	priv->buffer[led->addr] = led->subled_info[0].brightness << 16 |
+				  led->subled_info[1].brightness <<  8 |
+				  led->subled_info[2].brightness;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Start, enqueue, or extend an enqueued transfer, as appropriate. */
+	next_length = max(priv->next_length, led->addr + 1);
+	xfer_active = priv->xfer_active;
+	if (xfer_active)
+		priv->next_length = next_length;
+	else
+		priv->xfer_active = true;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if (!xfer_active)
+		sun50i_a100_ledc_start_xfer(priv, next_length);
+}
+
+static const char *const sun50i_a100_ledc_formats[] = {
+	"rgb", "rbg", "grb", "gbr", "brg", "bgr",
+};
+
+static int sun50i_a100_ledc_parse_format(const struct device_node *np,
+					 struct sun50i_a100_ledc *priv)
+{
+	const char *format = "grb";
+	u32 i;
+
+	of_property_read_string(np, "allwinner,pixel-format", &format);
+
+	for (i = 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); i++) {
+		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
+			priv->format = i;
+			return 0;
+		}
+	}
+
+	return dev_err_probe(priv->dev, -EINVAL, "Bad pixel format '%s'\n", format);
+}
+
+static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc *priv)
+{
+	u32 control;
+
+	control = readl(priv->base + LEDC_CTRL_REG);
+	control &= ~LEDC_CTRL_REG_RGB_MODE;
+	control |= FIELD_PREP(LEDC_CTRL_REG_RGB_MODE, priv->format);
+	writel(control, priv->base + LEDC_CTRL_REG);
+}
+
+static const struct sun50i_a100_ledc_timing sun50i_a100_ledc_default_timing = {
+	.t0h_ns = 336,
+	.t0l_ns = 840,
+	.t1h_ns = 882,
+	.t1l_ns = 294,
+	.treset_ns = 300000,
+};
+
+static int sun50i_a100_ledc_parse_timing(const struct device_node *np,
+					 struct sun50i_a100_ledc *priv)
+{
+	struct sun50i_a100_ledc_timing *timing = &priv->timing;
+
+	*timing = sun50i_a100_ledc_default_timing;
+
+	of_property_read_u32(np, "allwinner,t0h-ns", &timing->t0h_ns);
+	of_property_read_u32(np, "allwinner,t0l-ns", &timing->t0l_ns);
+	of_property_read_u32(np, "allwinner,t1h-ns", &timing->t1h_ns);
+	of_property_read_u32(np, "allwinner,t1l-ns", &timing->t1l_ns);
+	of_property_read_u32(np, "allwinner,treset-ns", &timing->treset_ns);
+
+	return 0;
+}
+
+static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
+{
+	const struct sun50i_a100_ledc_timing *timing = &priv->timing;
+	unsigned long mod_freq = clk_get_rate(priv->mod_clk);
+	u32 cycle_ns = NSEC_PER_SEC / mod_freq;
+	u32 control;
+
+	control = FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1H, timing->t1h_ns / cycle_ns) |
+		  FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1L, timing->t1l_ns / cycle_ns) |
+		  FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T0H, timing->t0h_ns / cycle_ns) |
+		  FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T0L, timing->t0l_ns / cycle_ns);
+	writel(control, priv->base + LEDC_T01_TIMING_CTRL_REG);
+
+	control = FIELD_PREP(LEDC_RESET_TIMING_CTRL_REG_TR, timing->treset_ns / cycle_ns) |
+		  FIELD_PREP(LEDC_RESET_TIMING_CTRL_REG_LED_NUM, priv->max_addr);
+	writel(control, priv->base + LEDC_RESET_TIMING_CTRL_REG);
+}
+
+static int sun50i_a100_ledc_resume(struct device *dev)
+{
+	struct sun50i_a100_ledc *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->bus_clk);
+	if (ret)
+		goto err_assert_reset;
+
+	ret = clk_prepare_enable(priv->mod_clk);
+	if (ret)
+		goto err_disable_bus_clk;
+
+	sun50i_a100_ledc_set_format(priv);
+	sun50i_a100_ledc_set_timing(priv);
+
+	writel(LEDC_INT_CTRL_REG_GLOBAL_INT_EN | LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN,
+	       priv->base + LEDC_INT_CTRL_REG);
+
+	return 0;
+
+err_disable_bus_clk:
+	clk_disable_unprepare(priv->bus_clk);
+err_assert_reset:
+	reset_control_assert(priv->reset);
+
+	return ret;
+}
+
+static int sun50i_a100_ledc_suspend(struct device *dev)
+{
+	struct sun50i_a100_ledc *priv = dev_get_drvdata(dev);
+
+	/* Wait for all transfers to complete. */
+	for (;;) {
+		unsigned long flags;
+		bool xfer_active;
+
+		spin_lock_irqsave(&priv->lock, flags);
+		xfer_active = priv->xfer_active;
+		spin_unlock_irqrestore(&priv->lock, flags);
+		if (!xfer_active)
+			break;
+
+		msleep(1);
+	}
+
+	clk_disable_unprepare(priv->mod_clk);
+	clk_disable_unprepare(priv->bus_clk);
+	reset_control_assert(priv->reset);
+
+	return 0;
+}
+
+static void sun50i_a100_ledc_dma_cleanup(void *data)
+{
+	struct sun50i_a100_ledc *priv = data;
+
+	dma_release_channel(priv->dma_chan);
+}
+
+static int sun50i_a100_ledc_probe(struct platform_device *pdev)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	struct dma_slave_config dma_cfg = {};
+	struct led_init_data init_data = {};
+	struct sun50i_a100_ledc_led *led;
+	struct device *dev = &pdev->dev;
+	struct sun50i_a100_ledc *priv;
+	struct device_node *child;
+	struct resource *mem;
+	u32 max_addr = 0;
+	u32 num_leds = 0;
+	int irq, ret;
+
+	/*
+	 * The maximum LED address must be known in sun50i_a100_ledc_resume() before
+	 * class device registration, so parse and validate the subnodes up front.
+	 */
+	for_each_available_child_of_node(np, child) {
+		u32 addr, color;
+
+		ret = of_property_read_u32(child, "reg", &addr);
+		if (ret || addr >= LEDC_MAX_LEDS) {
+			of_node_put(child);
+			return dev_err_probe(dev, -EINVAL, "'reg' must be between 0 and %d\n",
+					     LEDC_MAX_LEDS - 1);
+		}
+
+		ret = of_property_read_u32(child, "color", &color);
+		if (ret || color != LED_COLOR_ID_RGB) {
+			of_node_put(child);
+			return dev_err_probe(dev, -EINVAL, "'color' must be LED_COLOR_ID_RGB\n");
+		}
+
+		max_addr = max(max_addr, addr);
+		num_leds++;
+	}
+
+	if (!num_leds)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, struct_size(priv, leds, num_leds), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->max_addr = max_addr;
+	priv->num_leds = num_leds;
+	spin_lock_init(&priv->lock);
+	dev_set_drvdata(dev, priv);
+
+	ret = sun50i_a100_ledc_parse_format(np, priv);
+	if (ret)
+		return ret;
+
+	ret = sun50i_a100_ledc_parse_timing(np, priv);
+	if (ret)
+		return ret;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->bus_clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(priv->bus_clk))
+		return PTR_ERR(priv->bus_clk);
+
+	priv->mod_clk = devm_clk_get(dev, "mod");
+	if (IS_ERR(priv->mod_clk))
+		return PTR_ERR(priv->mod_clk);
+
+	priv->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	priv->dma_chan = dma_request_chan(dev, "tx");
+	if (IS_ERR(priv->dma_chan)) {
+		if (PTR_ERR(priv->dma_chan) != -ENODEV)
+			return PTR_ERR(priv->dma_chan);
+
+		priv->dma_chan = NULL;
+
+		priv->buffer = devm_kzalloc(dev, LEDS_TO_BYTES(LEDC_MAX_LEDS), GFP_KERNEL);
+		if (!priv->buffer)
+			return -ENOMEM;
+	} else {
+		ret = devm_add_action_or_reset(dev, sun50i_a100_ledc_dma_cleanup, priv);
+		if (ret)
+			return ret;
+
+		dma_cfg.dst_addr	= mem->start + LEDC_DATA_REG;
+		dma_cfg.dst_addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_cfg.dst_maxburst	= LEDC_FIFO_DEPTH / 2;
+
+		ret = dmaengine_slave_config(priv->dma_chan, &dma_cfg);
+		if (ret)
+			return ret;
+
+		priv->buffer = dmam_alloc_attrs(dmaengine_get_dma_device(priv->dma_chan),
+						LEDS_TO_BYTES(LEDC_MAX_LEDS), &priv->dma_handle,
+						GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
+		if (!priv->buffer)
+			return -ENOMEM;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, sun50i_a100_ledc_irq, 0, dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	ret = sun50i_a100_ledc_resume(dev);
+	if (ret)
+		return ret;
+
+	led = priv->leds;
+	for_each_available_child_of_node(np, child) {
+		struct led_classdev *cdev;
+
+		/* The node was already validated above. */
+		of_property_read_u32(child, "reg", &led->addr);
+
+		led->subled_info[0].color_index = LED_COLOR_ID_RED;
+		led->subled_info[0].channel = 0;
+		led->subled_info[1].color_index = LED_COLOR_ID_GREEN;
+		led->subled_info[1].channel = 1;
+		led->subled_info[2].color_index = LED_COLOR_ID_BLUE;
+		led->subled_info[2].channel = 2;
+
+		led->mc_cdev.num_colors = ARRAY_SIZE(led->subled_info);
+		led->mc_cdev.subled_info = led->subled_info;
+
+		cdev = &led->mc_cdev.led_cdev;
+		cdev->max_brightness = U8_MAX;
+		cdev->brightness_set = sun50i_a100_ledc_brightness_set;
+
+		init_data.fwnode = of_fwnode_handle(child);
+
+		ret = led_classdev_multicolor_register_ext(dev, &led->mc_cdev, &init_data);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to register multicolor LED %u", led->addr);
+			goto err_put_child;
+		}
+
+		led++;
+	}
+
+	dev_info(dev, "Registered %u LEDs\n", num_leds);
+
+	return 0;
+
+err_put_child:
+	of_node_put(child);
+	while (led-- > priv->leds)
+		led_classdev_multicolor_unregister(&led->mc_cdev);
+	sun50i_a100_ledc_suspend(&pdev->dev);
+
+	return ret;
+}
+
+static void sun50i_a100_ledc_remove(struct platform_device *pdev)
+{
+	struct sun50i_a100_ledc *priv = platform_get_drvdata(pdev);
+
+	for (u32 i = 0; i < priv->num_leds; i++)
+		led_classdev_multicolor_unregister(&priv->leds[i].mc_cdev);
+	sun50i_a100_ledc_suspend(&pdev->dev);
+}
+
+static const struct of_device_id sun50i_a100_ledc_of_match[] = {
+	{ .compatible = "allwinner,sun50i-a100-ledc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun50i_a100_ledc_of_match);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sun50i_a100_ledc_pm,
+				sun50i_a100_ledc_suspend,
+				sun50i_a100_ledc_resume);
+
+static struct platform_driver sun50i_a100_ledc_driver = {
+	.probe		= sun50i_a100_ledc_probe,
+	.remove_new	= sun50i_a100_ledc_remove,
+	.shutdown	= sun50i_a100_ledc_remove,
+	.driver		= {
+		.name		= "sun50i-a100-ledc",
+		.of_match_table	= sun50i_a100_ledc_of_match,
+		.pm		= pm_ptr(&sun50i_a100_ledc_pm),
+	},
+};
+module_platform_driver(sun50i_a100_ledc_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner A100 LED controller driver");
+MODULE_LICENSE("GPL");
-- 
2.41.0

