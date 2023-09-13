Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7F79EC54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbjIMPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbjIMPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DFE7;
        Wed, 13 Sep 2023 08:16:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso75774025e9.0;
        Wed, 13 Sep 2023 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618182; x=1695222982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=072YJrk5Gsy2bq4yUlijuT8JKmshwKnpnmiZoFXozDk=;
        b=A0HjeEnJLFGRcVPHXRkheDcvqJXreG3IeqNqnSgqM94IrECRZ2eUdy/2XjhemNT8AS
         5/+vvwahHHZYTYsjNls9gSl9DF1yP8NRiY/xNIBswNE98WXXudnYQ2in/Dzdrond3xAt
         WK8XpjLLUujoyyQ8OV0DmcYBegUi3rbHeYEi2xKF0Syw2HfLDn6k0UoBAz++xRveCT0Q
         u5ZqwLdU55pw3Ronjp9Yhw2iqoB1eBcrr8eBsF3nxnK0X8ykMdftVCCxM6+LY+DV6uiD
         S1VFbYbg6DCkhf+5wQfzEu8CtZqOYUz4LwG+knsy4o2rp4cZ5GEf5+YS3qOoDK3Ni+Ix
         3dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618182; x=1695222982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=072YJrk5Gsy2bq4yUlijuT8JKmshwKnpnmiZoFXozDk=;
        b=IZkY3JYDMixi9Ml1JNgzfLlnupvx4afs4Sc8DN+0PdMG5ahZt7r3ZBPiMrS7yqti/8
         EhMsxvoS1CTSj4btBbbHV3yeG77fhXkc/9b0w8ibvZqJINxE3J6e6eUz7YvHfakwSWLq
         LqXskqJ6nzyzu88j5vKnZcKVRueeR8W+Vdb8i6b+aZHnrQzZDSzNHUQbpCgBgMS9A6cF
         7J1054GvTg45Z8txmk+VgopoM7J6fVjMtbXCHtC5IvzBaAJpmZwMgtLnoVP7GjCnr4ic
         Jrp/EvJ9QLufo4RNaJ25vOabb8OravUiv4tUPmJ2WyvtYQNv1iJPilR3KlpotGZe2h2s
         LadA==
X-Gm-Message-State: AOJu0YxaWDMQzG1nG7e9HCRuD4N2aZqz8RzZCtSzAGqG5z6ZRpzBJTOB
        JexVhLFHhNTIYFBQGx+hF5Q=
X-Google-Smtp-Source: AGHT+IEd/4icH+OCrB98jAeWL0me/9kKV05TD9d+6akO1+csfozUhRaahZUf8y+5fJwYaZHei9B4Xw==
X-Received: by 2002:a7b:c045:0:b0:402:e68f:8896 with SMTP id u5-20020a7bc045000000b00402e68f8896mr2430801wmc.0.1694618182223;
        Wed, 13 Sep 2023 08:16:22 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcd14000000b003fe2b6d64c8sm2299620wmj.21.2023.09.13.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:16:21 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] rtc: Add support for the SSD202D RTC
Date:   Wed, 13 Sep 2023 17:16:04 +0200
Message-Id: <20230913151606.69494-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913151606.69494-1-romain.perier@gmail.com>
References: <20230913151606.69494-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer SigmaStar SSD202D SoCs contain a Real Time Clock, capable of
running while the system is sleeping (battery powered), this is not the
case with the other RTC on older SoCs. This adds basic support for this
RTC block.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Co-developed-by: Daniel Palmer <daniel@0x0f.com>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/rtc/Kconfig       |  11 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-ssd202d.c | 249 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/rtc/rtc-ssd202d.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d7502433c78a..f6c49348d7aa 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1984,4 +1984,15 @@ config RTC_DRV_POLARFIRE_SOC
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-mpfs".
 
+config RTC_DRV_SSD202D
+	tristate "SigmaStar SSD202D RTC"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
+	help
+	  If you say yes here you get support for the SigmaStar SSD202D On-Chip
+	  Real Time Clock.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-ssd20xd".
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fd209883ee2e..7b03c3abfd78 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_RTC_DRV_MESON)	+= rtc-meson.o
 obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
 obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_MSC313)	+= rtc-msc313.o
+obj-$(CONFIG_RTC_DRV_SSD202D)	+= rtc-ssd202d.o
 obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
 obj-$(CONFIG_RTC_DRV_MT2712)	+= rtc-mt2712.o
 obj-$(CONFIG_RTC_DRV_MT6397)	+= rtc-mt6397.o
diff --git a/drivers/rtc/rtc-ssd202d.c b/drivers/rtc/rtc-ssd202d.c
new file mode 100644
index 000000000000..a69e062ad1b4
--- /dev/null
+++ b/drivers/rtc/rtc-ssd202d.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Real time clocks driver for MStar/SigmaStar SSD202D SoCs.
+ *
+ * (C) 2021 Daniel Palmer
+ * (C) 2023 Romain Perier
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/regmap.h>
+#include <linux/pm.h>
+
+#define REG_CTRL	0x0
+#define REG_CTRL1	0x4
+#define REG_ISO_CTRL	0xc
+#define REG_WRDATA_L	0x10
+#define REG_WRDATA_H	0x14
+#define REG_ISOACK	0x20
+#define REG_RDDATA_L	0x24
+#define REG_RDDATA_H	0x28
+#define REG_RDCNT_L	0x30
+#define REG_RDCNT_H	0x34
+#define REG_CNT_TRIG	0x38
+#define REG_PWRCTRL	0x3c
+#define REG_RTC_TEST	0x54
+
+#define CNT_RD_TRIG_BIT BIT(0)
+#define CNT_RD_BIT BIT(0)
+#define BASE_WR_BIT BIT(1)
+#define BASE_RD_BIT BIT(2)
+#define CNT_RST_BIT BIT(3)
+#define ISO_CTRL_ACK_MASK BIT(3)
+#define ISO_CTRL_ACK_SHIFT 3
+#define SW0_WR_BIT BIT(5)
+#define SW1_WR_BIT BIT(6)
+#define SW0_RD_BIT BIT(7)
+#define SW1_RD_BIT BIT(8)
+
+#define ISO_CTRL_MASK GENMASK(2, 0)
+
+struct ssd202d_rtc {
+	struct rtc_device *rtc_dev;
+	void __iomem *base;
+};
+
+static u8 read_iso_en(void __iomem *base)
+{
+	return readb(base + REG_RTC_TEST) & 0x1;
+}
+
+static u8 read_iso_ctrl_ack(void __iomem *base)
+{
+	return (readb(base + REG_ISOACK) & ISO_CTRL_ACK_MASK) >> ISO_CTRL_ACK_SHIFT;
+}
+
+static int ssd202d_rtc_isoctrl(struct ssd202d_rtc *priv)
+{
+	static const unsigned int sequence[] = { 0x0, 0x1, 0x3, 0x7, 0x5, 0x1, 0x0 };
+	unsigned int val;
+	struct device *dev = &priv->rtc_dev->dev;
+	int i, ret;
+
+	/*
+	 * This gates iso_en by writing a special sequence of bytes to iso_ctrl
+	 * and ensuring that it has been correctly applied by reading iso_ctrl_ack
+	 */
+	for (i = 0; i < ARRAY_SIZE(sequence); i++) {
+		writeb(sequence[i] & ISO_CTRL_MASK, priv->base +  REG_ISO_CTRL);
+
+		ret = read_poll_timeout(read_iso_ctrl_ack, val, val == (i % 2), 100,
+					20 * 100, true, priv->base);
+		if (ret) {
+			dev_dbg(dev, "Timeout waiting for ack byte %i (%x) of sequence\n", i,
+				sequence[i]);
+			return ret;
+		}
+	}
+
+	/*
+	 * At this point iso_en should be raised for 1ms
+	 */
+	ret = read_poll_timeout(read_iso_en, val, val, 100, 22 * 100, true, priv->base);
+	if (ret)
+		dev_dbg(dev, "Timeout waiting for iso_en\n");
+	mdelay(2);
+	return 0;
+}
+
+static void ssd202d_rtc_read_reg(struct ssd202d_rtc *priv, unsigned int reg,
+				 unsigned int field, unsigned int *base)
+{
+	unsigned int l, h;
+	u16 val;
+
+	/* Ask for the content of an RTC value into RDDATA by gating iso_en,
+	 * then iso_en is gated and the content of RDDATA can be read
+	 */
+	val = readw(priv->base + reg);
+	writew(val | field, priv->base + reg);
+	ssd202d_rtc_isoctrl(priv);
+	writew(val & ~field, priv->base + reg);
+
+	l = readw(priv->base + REG_RDDATA_L);
+	h = readw(priv->base + REG_RDDATA_H);
+
+	*base = (h << 16) | l;
+}
+
+static void ssd202d_rtc_write_reg(struct ssd202d_rtc *priv, unsigned int reg,
+				  unsigned int field, u32 base)
+{
+	u16 val;
+
+	/* Set the content of an RTC value from WRDATA by gating iso_en */
+	val = readw(priv->base + reg);
+	writew(val | field, priv->base + reg);
+	writew(base, priv->base + REG_WRDATA_L);
+	writew(base >> 16, priv->base + REG_WRDATA_H);
+	ssd202d_rtc_isoctrl(priv);
+	writew(val & ~field, priv->base + reg);
+}
+
+static int ssd202d_rtc_read_counter(struct ssd202d_rtc *priv, unsigned int *counter)
+{
+	unsigned int l, h;
+	u16 val;
+
+	val = readw(priv->base + REG_CTRL1);
+	writew(val | CNT_RD_BIT, priv->base + REG_CTRL1);
+	ssd202d_rtc_isoctrl(priv);
+	writew(val & ~CNT_RD_BIT, priv->base + REG_CTRL1);
+
+	val = readw(priv->base + REG_CTRL1);
+	writew(val | CNT_RD_TRIG_BIT, priv->base + REG_CNT_TRIG);
+	writew(val & ~CNT_RD_TRIG_BIT, priv->base + REG_CNT_TRIG);
+
+	l = readw(priv->base + REG_RDCNT_L);
+	h = readw(priv->base + REG_RDCNT_H);
+
+	*counter = (h << 16) | l;
+
+	return 0;
+}
+
+static int ssd202d_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ssd202d_rtc *priv = dev_get_drvdata(dev);
+	unsigned int sw0, base, counter;
+	u32 seconds;
+	int ret;
+
+	/* Check that RTC is enabled by SW */
+	ssd202d_rtc_read_reg(priv, REG_CTRL, SW0_RD_BIT, &sw0);
+	if (sw0 != 1)
+		return -EINVAL;
+
+	/* Get RTC base value from RDDATA */
+	ssd202d_rtc_read_reg(priv, REG_CTRL, BASE_RD_BIT, &base);
+	/* Get RTC counter value from RDDATA */
+	ret = ssd202d_rtc_read_counter(priv, &counter);
+	if (ret)
+		return ret;
+
+	seconds = base + counter;
+
+	rtc_time64_to_tm(seconds, tm);
+
+	return 0;
+}
+
+static int ssd202d_rtc_reset_counter(struct ssd202d_rtc *priv)
+{
+	u16 val;
+
+	val = readw(priv->base + REG_CTRL);
+	writew(val | CNT_RST_BIT, priv->base + REG_CTRL);
+	ssd202d_rtc_isoctrl(priv);
+	writew(val & ~CNT_RST_BIT, priv->base + REG_CTRL);
+	ssd202d_rtc_isoctrl(priv);
+
+	return 0;
+}
+
+static int ssd202d_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ssd202d_rtc *priv = dev_get_drvdata(dev);
+	unsigned long seconds = rtc_tm_to_time64(tm);
+
+	ssd202d_rtc_write_reg(priv, REG_CTRL, BASE_WR_BIT, seconds);
+	ssd202d_rtc_reset_counter(priv);
+	ssd202d_rtc_write_reg(priv, REG_CTRL, SW0_WR_BIT, 1);
+
+	return 0;
+}
+
+static const struct rtc_class_ops ssd202d_rtc_ops = {
+	.read_time = ssd202d_rtc_read_time,
+	.set_time = ssd202d_rtc_set_time,
+};
+
+static int ssd202d_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ssd202d_rtc *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct ssd202d_rtc), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(priv->rtc_dev))
+		return PTR_ERR(priv->rtc_dev);
+
+	priv->rtc_dev->ops = &ssd202d_rtc_ops;
+	priv->rtc_dev->range_max = U32_MAX;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_rtc_register_device(priv->rtc_dev);
+}
+
+static const struct of_device_id ssd202d_rtc_of_match_table[] = {
+	{ .compatible = "mstar,ssd202d-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssd202d_rtc_of_match_table);
+
+static struct platform_driver ssd202d_rtc_driver = {
+	.probe = ssd202d_rtc_probe,
+	.driver = {
+		.name = "ssd202d-rtc",
+		.of_match_table = ssd202d_rtc_of_match_table,
+	},
+};
+module_platform_driver(ssd202d_rtc_driver);
+
+MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
+MODULE_AUTHOR("Romain Perier <romain.perier@gmail.com>");
+MODULE_DESCRIPTION("MStar SSD202D RTC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.39.2

