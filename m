Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D47547B2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGOJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGOJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:18:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FC3A86;
        Sat, 15 Jul 2023 02:18:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so1214301e87.0;
        Sat, 15 Jul 2023 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412716; x=1692004716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jpNcy5dzVr82WuwEI1g6e6LWpPQ71PlmEmq2Gp7ysQ=;
        b=FkrTMK4ZjasfdQgtBLBDHgGJNMKGHsRES5JqlR0IMfxoe92LVbbOjattnX863XUh9c
         bjLWjl7HT9donsk+Eu9tqk+NLkemP9/A59eN+CIX0JYJgyje0kqxC0VMOT4W5M4DP1bj
         E+ktIUlFw+IZ5wzo0lpulklsy/6RmpHi+FqMUBFMEQFwuqUhkAmLq7Rm4jh9DIrL+46F
         2rr/UU/uszsuqS/91McgHXJsw4u8XwMy80CeCmV1ktU8Yyz/3smG7R6pkuYRq3epGrlh
         ur7nJ4wHkobftHMP8Wak987jBvsYNZH2RRO62htKh8mUW9IWzEYCCHhNXtjtf5rYmbWz
         OqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412716; x=1692004716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jpNcy5dzVr82WuwEI1g6e6LWpPQ71PlmEmq2Gp7ysQ=;
        b=GgRMpSrDPSBLQ4L1aKwOmokXhsEsHXwIZWxdpL//3XQpPX/hFxwt65WJUV94XOr8zp
         cXfctxkuMGIZC3ivq97JHeyAgCOadUouQRd9IJ4KYKKZKAVTTrUId2fAJrbRfMyqsDYO
         SYro/PJlXfaC1MENODCT1m9Z36lJFZSKvFbtxT0sl6F2vvv4wSsKmn5bPVIrtK32D4iW
         hBi0yMgjt8XBVvadEyb+6h3MxRd05u0utENFsZIqPSF3QCoe4rTaTlG5HUObEH5So4Ow
         kqqU6GDTIc1tI8mL9/PBLe3FEqDeZWvA8aTM5ocUNhvSr0bM6SpmFDrU2pvWR2VIvfuw
         Zbxw==
X-Gm-Message-State: ABy/qLbWb/ZK5Bb4awkKyaEyNvafYc2r4/fbsorJjYryNPZSIYFuywKJ
        Pvo/PLLBNqeo5Y/KldMs6VR1TgCejVG2ng==
X-Google-Smtp-Source: APBJJlFjlUwnRMcZk9RS4RINzx0js72EB9SAFazIwlHCMfh4PJY95mokGJzrnPxqR6PAglTw7wj1Dw==
X-Received: by 2002:a05:6512:3a96:b0:4f8:6e50:d6d0 with SMTP id q22-20020a0565123a9600b004f86e50d6d0mr1787894lfu.31.1689412716242;
        Sat, 15 Jul 2023 02:18:36 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b002b840f283a7sm561784ljj.36.2023.07.15.02.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:18:35 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v9 2/4] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
Date:   Sat, 15 Jul 2023 12:18:14 +0300
Message-Id: <20230715091816.3074375-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The General Purpose ADC (GPADC) can convert the external signal into
a certain proportion of digital value, to realize the measurement of
analog signal, which can be applied to power detection and key detection.

Theoretically, this ADC can support up to 16 channels. All SoCs below
contain this GPADC IP. The only difference between them is the number
of available channels:

 T113 - 1 channel
 D1   - 2 channels
 R329 - 4 channels
 T507 - 4 channels

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/iio/adc/Kconfig            |  10 ++
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/sun20i-gpadc-iio.c | 276 +++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5f1e9bb59623..517b3db114b8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1134,6 +1134,16 @@ config SUN4I_GPADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called sun4i-gpadc-iio.
 
+config SUN20I_GPADC
+	tristate "Allwinner D1/T113s/T507/R329 and similar GPADCs driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  Say yes here to build support for Allwinner (D1, T113, T507 and R329)
+	  SoCs GPADC. This ADC provides up to 16 channels.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sun20i-gpadc-iio.
+
 config TI_ADC081C
 	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index eb6e891790fb..2facf979327d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
+obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
new file mode 100644
index 000000000000..6a893d484cf7
--- /dev/null
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPADC driver for sunxi platforms (D1, T113-S3 and R329)
+ * Copyright (c) 2023 Maksim Kiselev <bigunclemax@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/reset.h>
+
+#include <linux/iio/iio.h>
+
+#define SUN20I_GPADC_DRIVER_NAME	"sun20i-gpadc"
+
+/* Register map definition */
+#define SUN20I_GPADC_SR			0x00
+#define SUN20I_GPADC_CTRL		0x04
+#define SUN20I_GPADC_CS_EN		0x08
+#define SUN20I_GPADC_FIFO_INTC		0x0c
+#define SUN20I_GPADC_FIFO_INTS		0x10
+#define SUN20I_GPADC_FIFO_DATA		0X14
+#define SUN20I_GPADC_CB_DATA		0X18
+#define SUN20I_GPADC_DATAL_INTC		0x20
+#define SUN20I_GPADC_DATAH_INTC		0x24
+#define SUN20I_GPADC_DATA_INTC		0x28
+#define SUN20I_GPADC_DATAL_INTS		0x30
+#define SUN20I_GPADC_DATAH_INTS		0x34
+#define SUN20I_GPADC_DATA_INTS		0x38
+#define SUN20I_GPADC_CH_CMP_DATA(x)	(0x40 + (x) * 4)
+#define SUN20I_GPADC_CH_DATA(x)		(0x80 + (x) * 4)
+
+#define SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN_MASK		BIT(23)
+#define SUN20I_GPADC_CTRL_WORK_MODE_MASK		GENMASK(19, 18)
+#define SUN20I_GPADC_CTRL_ADC_EN_MASK			BIT(16)
+#define SUN20I_GPADC_CS_EN_ADC_CH(x)			BIT(x)
+#define SUN20I_GPADC_DATA_INTC_CH_DATA_IRQ_EN(x)	BIT(x)
+
+#define SUN20I_GPADC_WORK_MODE_SINGLE			0
+
+struct sun20i_gpadc_iio {
+	void __iomem		*regs;
+	struct completion	completion;
+	int			last_channel;
+	/*
+	 * Lock to protect the device state during a potential concurrent
+	 * read access from userspace. Reading a raw value requires a sequence
+	 * of register writes, then a wait for a completion callback,
+	 * and finally a register read, during which userspace could issue
+	 * another read request. This lock protects a read access from
+	 * ocurring before another one has finished.
+	 */
+	struct mutex		lock;
+};
+
+static int sun20i_gpadc_adc_read(struct sun20i_gpadc_iio *info,
+				 struct iio_chan_spec const *chan, int *val)
+{
+	u32 ctrl;
+	int ret = IIO_VAL_INT;
+
+	mutex_lock(&info->lock);
+
+	reinit_completion(&info->completion);
+
+	if (info->last_channel != chan->channel) {
+		info->last_channel = chan->channel;
+
+		/* enable the analog input channel */
+		writel(SUN20I_GPADC_CS_EN_ADC_CH(chan->channel),
+		       info->regs + SUN20I_GPADC_CS_EN);
+
+		/* enable the data irq for input channel */
+		writel(SUN20I_GPADC_DATA_INTC_CH_DATA_IRQ_EN(chan->channel),
+		       info->regs + SUN20I_GPADC_DATA_INTC);
+	}
+
+	/* enable the ADC function */
+	ctrl = readl(info->regs + SUN20I_GPADC_CTRL);
+	ctrl |= FIELD_PREP(SUN20I_GPADC_CTRL_ADC_EN_MASK, 1);
+	writel(ctrl, info->regs + SUN20I_GPADC_CTRL);
+
+	/*
+	 * According to the datasheet maximum acquire time(TACQ) can be
+	 * (65535+1)/24Mhz and conversion time(CONV_TIME) is always constant
+	 * and equal to 14/24Mhz, so (TACQ+CONV_TIME) <= 2.73125ms.
+	 * A 10ms delay should be enough to make sure an interrupt occurs in
+	 * normal conditions. If it doesn't occur, then there is a timeout.
+	 */
+	if (!wait_for_completion_timeout(&info->completion, msecs_to_jiffies(10))) {
+		ret = -ETIMEDOUT;
+		goto err_unlock;
+	}
+
+	/* read the ADC data */
+	*val = readl(info->regs + SUN20I_GPADC_CH_DATA(chan->channel));
+
+err_unlock:
+	mutex_unlock(&info->lock);
+
+	return ret;
+}
+
+static int sun20i_gpadc_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int *val,
+				 int *val2, long mask)
+{
+	struct sun20i_gpadc_iio *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return sun20i_gpadc_adc_read(info, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		/* value in mv = 1800mV / 4096 raw */
+		*val = 1800;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
+{
+	struct sun20i_gpadc_iio *info = data;
+
+	/* clear data interrupt status register */
+	writel(GENMASK(31, 0), info->regs + SUN20I_GPADC_DATA_INTS);
+
+	complete(&info->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info sun20i_gpadc_iio_info = {
+	.read_raw = sun20i_gpadc_read_raw,
+};
+
+static void sun20i_gpadc_reset_assert(void *data)
+{
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static int sun20i_gpadc_alloc_channels(struct iio_dev *indio_dev,
+				       struct device *dev)
+{
+	unsigned int channel;
+	int num_channels, i, ret;
+	struct iio_chan_spec *channels;
+	struct fwnode_handle *node;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels == 0)
+		return dev_err_probe(dev, -ENODEV, "no channel children\n");
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels),
+				GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	i = 0;
+	device_for_each_child_node(dev, node) {
+		ret = fwnode_property_read_u32(node, "reg", &channel);
+		if (ret) {
+			fwnode_handle_put(node);
+			return dev_err_probe(dev, ret, "invalid channel number\n");
+		}
+
+		channels[i].type = IIO_VOLTAGE;
+		channels[i].indexed = 1;
+		channels[i].channel = channel;
+		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		channels[i].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+
+	return 0;
+}
+
+static int sun20i_gpadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct sun20i_gpadc_iio *info;
+	struct reset_control *rst;
+	struct clk *clk;
+	int irq;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->last_channel = -1;
+
+	mutex_init(&info->lock);
+	init_completion(&info->completion);
+
+	ret = sun20i_gpadc_alloc_channels(indio_dev, dev);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &sun20i_gpadc_iio_info;
+	indio_dev->name = SUN20I_GPADC_DRIVER_NAME;
+
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n");
+
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert reset\n");
+
+	ret = devm_add_action_or_reset(dev, sun20i_gpadc_reset_assert, rst);
+	if (ret)
+		return ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, sun20i_gpadc_irq_handler, 0,
+			       dev_name(dev), info);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed requesting irq %d\n", irq);
+
+	writel(FIELD_PREP(SUN20I_GPADC_CTRL_ADC_AUTOCALI_EN_MASK, 1) |
+	       FIELD_PREP(SUN20I_GPADC_CTRL_WORK_MODE_MASK, SUN20I_GPADC_WORK_MODE_SINGLE),
+	       info->regs + SUN20I_GPADC_CTRL);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not register the device\n");
+
+	return 0;
+}
+
+static const struct of_device_id sun20i_gpadc_of_id[] = {
+	{ .compatible = "allwinner,sun20i-d1-gpadc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
+
+static struct platform_driver sun20i_gpadc_driver = {
+	.driver = {
+		.name = SUN20I_GPADC_DRIVER_NAME,
+		.of_match_table = sun20i_gpadc_of_id,
+	},
+	.probe = sun20i_gpadc_probe,
+};
+module_platform_driver(sun20i_gpadc_driver);
+
+MODULE_DESCRIPTION("ADC driver for sunxi platforms");
+MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2

