Return-Path: <linux-kernel+bounces-91650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E78714AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B772F284D87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516E3EA9B;
	Tue,  5 Mar 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/lwv9fH"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F43EA97;
	Tue,  5 Mar 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612514; cv=none; b=V00pQ729nVOXLaB1SyLgtBeWC7YmJHnKJypNwCySttCKXrBLR/bCtqV6Wd3hhAgflv4lwzdESwrHb3zXuPbBmlMh0dz2j1Gf1KrH9RFd1H4ruDmz/u0YX/Tfaee1nfWLLeNagtVrc4HyJGPsove+tIVgrOaLBvWQpo+X7ixQiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612514; c=relaxed/simple;
	bh=VrFvBwu+5djTZZLND1/oU7zR1xwqzdQA86ryoXYNbCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkV/SjHkIvHb+34ExSpjH+X3sO0Mocy5GBlNs0nNT8FV1jv+A1gF25Kvu4WL/hNVq+WSz8lXwjnLFJnN2rSkknoIOP3CXqBnzd/u+HF7qty5lwD+uR7C9VSbE4AV00sPxPCMf3o0Rz3M1dLpZhztPyN49yE4pheCpzTe6Zd4JKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/lwv9fH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-787edfea5adso292994585a.2;
        Mon, 04 Mar 2024 20:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709612512; x=1710217312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkhhOr0jhiPqNL9CDfmLZNCV0k7XRJt648UCT9HAdYg=;
        b=P/lwv9fHFHiBZXVrnUWVP+YjCvSj+5L28MTuW4sHyCDqRpn+77oTqjDA2U3+SOngaA
         w5uOaOQaupyzXgSIncTE01OORMELgm0dw4BWTwjc8muUjC1v0FurWSTea4v6OZxydqoS
         GRKwk7vk9p+sPe1yDtInBxTYMhHZ05BUcopOgAYjRbTtXDO0iduo00uMllgNhrfdx5vB
         3FgW/YQkc5TqlJZHs1PNMU8fdqqRj7EInwIvXnaLJZp4WPuYlHW3HFO9/uV4K3BEk5oh
         0vdCfraP7wHGWnIAs1dl1RfXwOyyPclemCTp8moO9YQ0XjuOj06khnfXXak4iPi0BQti
         8c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612512; x=1710217312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkhhOr0jhiPqNL9CDfmLZNCV0k7XRJt648UCT9HAdYg=;
        b=aaGFYGsdIStu3glh1IzKPrUYCIKU+Qf1ckfCXWjsikk2UjzUHXR3WhGDV4ysDQ3Aos
         2LlMWq84BEBaa3kQFKOniWhHERlKKsYUF1MfAXfaFIpFhzyoSKbwfjwh1DKqoATtrEzX
         f3ysZM+g9q513ZMEhnnzGa6pmN4DddSnayTnMd4K7r0jhFfYz1CjFb/A88QhcTtZUoho
         8PgcidTqtBuiSgSXq9HnrY3N8qSudiB7J4baRqho9gvIUAKq+4+R4ducKOEOhEmA9B8u
         C1tX/NhrXNLo1mk6SlMiaFFqKR/TVFs/2XeA3q4VSqNeHtVPaGz7dHA0V2ptv5EufUJV
         VSSw==
X-Forwarded-Encrypted: i=1; AJvYcCU4NAvQthmOwzx3RFYVhqiibLt0CgYsG6jJ8Sl39nw6t/mCRnRm90rXerveOJaVKmG4GX65xPZAn0JoEDBVsbru103QDsKh+6rbb5il/lqF1QctKGAiBvuYEPcOGVHr/rAxZ2lhTiehHQ==
X-Gm-Message-State: AOJu0YxqeYTfqQ5Obz9qm17m+Ap53b5uj7BW7SbCNOG2Iy5Ha09l2kuT
	NQvIJF81mnSD92sdsZKTlcTq2ArEALTRbKhlqp6iDrWj2d50P7D5
X-Google-Smtp-Source: AGHT+IGhO22JvWuoDe0r6n8miIUizZ7mK73dWrZ8B5AIFLBNspZ1UaGqokezG9iRzMWvkAu3ugRVzA==
X-Received: by 2002:a0c:f90d:0:b0:690:5447:753a with SMTP id v13-20020a0cf90d000000b006905447753amr869646qvn.31.1709612511729;
        Mon, 04 Mar 2024 20:21:51 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id mw10-20020a05621433ca00b0068f2b1d9415sm5796018qvb.23.2024.03.04.20.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:21:51 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Abdel Alkuor <alkuor@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] leds: Add NCP5623 multi-led driver
Date: Mon,  4 Mar 2024 23:20:29 -0500
Message-Id: <20240305042049.1533279-2-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305042049.1533279-1-alkuor@gmail.com>
References: <20240305042049.1533279-1-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCP5623 is DC-DC multi-LEDs driver which has three PWMs that can be
programmed up to 32 steps giving 32768 colors hue.

NCP5623 driver supports gradual dimming upward/downward with programmable
delays. Also, the driver supports driving a single LED or multi-LED
like RGB.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v3:
 - Add defines for magic numbers
 - Fix code style
 - Add a comment how ncp->delay is calculated
 - Don't free mc_node when probe is successful
 - Link to v2: https://lore.kernel.org/all/20240217230956.630522-2-alkuor@gmail.com/

Changes in v2:
 - Remove all custom attributes and use hw pattern instead
 - Remove filename from the driver description
 - Fix coding style
 - Destroy the muttex in shutdown callback
 - Register mcled device using none devm version as unregistering mcled device
   calls ncp5632_set_led which uses mutex hence we need to make sure the
   mutex is still available during the unregistering process.
 - Link to v1: https://lore.kernel.org/linux-kernel/20240208130115.GM689448@google.com/T/
 drivers/leds/rgb/Kconfig        |  11 ++
 drivers/leds/rgb/Makefile       |   1 +
 drivers/leds/rgb/leds-ncp5623.c | 271 ++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-ncp5623.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index a6a21f564673..81ab6a526a78 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -27,6 +27,17 @@ config LEDS_KTD202X
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-ktd202x.
 
+config LEDS_NCP5623
+	tristate "LED support for NCP5623"
+	depends on I2C
+	depends on OF
+	help
+	  This option enables support for ON semiconductor NCP5623
+	  Triple Output I2C Controlled RGB LED Driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-ncp5623.
+
 config LEDS_PWM_MULTICOLOR
 	tristate "PWM driven multi-color LED Support"
 	depends on PWM
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 243f31e4d70d..a501fd27f179 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_LEDS_GROUP_MULTICOLOR)	+= leds-group-multicolor.o
 obj-$(CONFIG_LEDS_KTD202X)		+= leds-ktd202x.o
+obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
new file mode 100644
index 000000000000..b669c55c5483
--- /dev/null
+++ b/drivers/leds/rgb/leds-ncp5623.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NCP5623 Multi-LED Driver
+ *
+ * Author: Abdel Alkuor <alkuor@gmail.com>
+ * Datasheet: https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/led-class-multicolor.h>
+
+#define NCP5623_FUNCTION_OFFSET		0x5
+#define NCP5623_REG(x)			((x) << NCP5623_FUNCTION_OFFSET)
+
+#define NCP5623_SHUTDOWN_REG		NCP5623_REG(0x0)
+#define NCP5623_ILED_REG		NCP5623_REG(0x1)
+#define NCP5623_PWM_REG(index)		NCP5623_REG(0x2 + (index))
+#define NCP5623_UPWARD_STEP_REG		NCP5623_REG(0x5)
+#define NCP5623_DOWNWARD_STEP_REG	NCP5623_REG(0x6)
+#define NCP5623_DIMMING_TIME_REG	NCP5623_REG(0x7)
+
+#define NCP5623_MAX_BRIGHTNESS		0x1f
+#define NCP5623_MAX_DIM_TIME		240 /* ms */
+#define NCP5623_DIM_STEP		8   /* ms */
+
+struct ncp5623 {
+	struct i2c_client *client;
+	struct led_classdev_mc mc_dev;
+	struct mutex lock;
+
+	int current_brightness;
+	unsigned long delay;
+};
+
+static int ncp5623_write(struct i2c_client *client, u8 reg, u8 data)
+{
+	return i2c_smbus_write_byte_data(client, reg | data, 0);
+}
+
+static int ncp5623_brightness_set(struct led_classdev *cdev,
+				  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
+	int ret;
+
+	guard(mutex)(&ncp->lock);
+
+	if (ncp->delay && time_is_after_jiffies(ncp->delay))
+		return -EBUSY;
+
+	ncp->delay = 0;
+
+	for (int i = 0; i < mc_cdev->num_colors; i++) {
+		ret = ncp5623_write(ncp->client,
+				    NCP5623_PWM_REG(mc_cdev->subled_info[i].channel),
+				    min(mc_cdev->subled_info[i].intensity,
+					NCP5623_MAX_BRIGHTNESS));
+		if (ret)
+			return ret;
+	}
+
+	ret = ncp5623_write(ncp->client, NCP5623_DIMMING_TIME_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = ncp5623_write(ncp->client, NCP5623_ILED_REG, brightness);
+	if (ret)
+		return ret;
+
+	ncp->current_brightness = brightness;
+
+	return 0;
+}
+
+static int ncp5623_pattern_set(struct led_classdev *cdev,
+			       struct led_pattern *pattern,
+			       u32 len, int repeat)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
+	int brightness_diff;
+	u8 reg;
+	int ret;
+
+	guard(mutex)(&ncp->lock);
+
+	if (ncp->delay && time_is_after_jiffies(ncp->delay))
+		return -EBUSY;
+
+	ncp->delay = 0;
+
+	if (pattern[0].delta_t > NCP5623_MAX_DIM_TIME ||
+	   (pattern[0].delta_t % NCP5623_DIM_STEP) != 0)
+		return -EINVAL;
+
+	brightness_diff = pattern[0].brightness - ncp->current_brightness;
+
+	if (brightness_diff == 0)
+		return 0;
+
+	if (pattern[0].delta_t) {
+		if (brightness_diff > 0)
+			reg = NCP5623_UPWARD_STEP_REG;
+		else
+			reg = NCP5623_DOWNWARD_STEP_REG;
+	} else {
+		reg = NCP5623_ILED_REG;
+	}
+
+	ret = ncp5623_write(ncp->client, reg,
+			    min(pattern[0].brightness, NCP5623_MAX_BRIGHTNESS));
+	if (ret)
+		return ret;
+
+	ret = ncp5623_write(ncp->client,
+			    NCP5623_DIMMING_TIME_REG,
+			    pattern[0].delta_t / NCP5623_DIM_STEP);
+	if (ret)
+		return ret;
+
+	/*
+	 * During testing, when the brightness difference is 1, for some
+	 * unknown reason, the time factor it takes to change to the new
+	 * value is the longest time possible. Otherwise, the time factor
+	 * is simply the brightness difference.
+	 *
+	 * For example:
+	 * current_brightness = 20 and new_brightness = 21 then the time it
+	 * takes to set the new brightness increments to the maximum possible
+	 * brightness from 20 then from 0 to 21.
+	 * time_factor = max_brightness - 20 + 21
+	 */
+	if (abs(brightness_diff) == 1)
+		ncp->delay = NCP5623_MAX_BRIGHTNESS + brightness_diff;
+	else
+		ncp->delay = abs(brightness_diff);
+
+	ncp->delay = msecs_to_jiffies(ncp->delay * pattern[0].delta_t) + jiffies;
+
+	ncp->current_brightness = pattern[0].brightness;
+
+	return 0;
+}
+
+static int ncp5623_pattern_clear(struct led_classdev *led_cdev)
+{
+	return 0;
+}
+
+static int ncp5623_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct fwnode_handle *mc_node, *led_node;
+	struct led_init_data init_data = { };
+	int num_subleds = 0;
+	struct ncp5623 *ncp;
+	struct mc_subled *subled_info;
+	u32 color_index;
+	u32 reg;
+	int ret;
+
+	ncp = devm_kzalloc(dev, sizeof(*ncp), GFP_KERNEL);
+	if (!ncp)
+		return -ENOMEM;
+
+	ncp->client = client;
+
+	mc_node = device_get_named_child_node(dev, "multi-led");
+	if (!mc_node)
+		return -EINVAL;
+
+	fwnode_for_each_child_node(mc_node, led_node)
+		num_subleds++;
+
+	subled_info = devm_kcalloc(dev, num_subleds, sizeof(*subled_info), GFP_KERNEL);
+	if (!subled_info) {
+		ret = -ENOMEM;
+		goto release_mc_node;
+	}
+
+	fwnode_for_each_available_child_node(mc_node, led_node) {
+		ret = fwnode_property_read_u32(led_node, "color", &color_index);
+		if (ret) {
+			fwnode_handle_put(led_node);
+			goto release_mc_node;
+		}
+
+		ret = fwnode_property_read_u32(led_node, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(led_node);
+			goto release_mc_node;
+		}
+
+		subled_info[ncp->mc_dev.num_colors].channel = reg;
+		subled_info[ncp->mc_dev.num_colors++].color_index = color_index;
+	}
+
+	init_data.fwnode = mc_node;
+
+	ncp->mc_dev.led_cdev.max_brightness = NCP5623_MAX_BRIGHTNESS;
+	ncp->mc_dev.subled_info = subled_info;
+	ncp->mc_dev.led_cdev.brightness_set_blocking = ncp5623_brightness_set;
+	ncp->mc_dev.led_cdev.pattern_set = ncp5623_pattern_set;
+	ncp->mc_dev.led_cdev.pattern_clear = ncp5623_pattern_clear;
+	ncp->mc_dev.led_cdev.default_trigger = "pattern";
+
+	mutex_init(&ncp->lock);
+	i2c_set_clientdata(client, ncp);
+
+	ret = led_classdev_multicolor_register_ext(dev, &ncp->mc_dev, &init_data);
+	if (ret)
+		goto destroy_lock;
+
+	return 0;
+
+destroy_lock:
+	mutex_destroy(&ncp->lock);
+
+release_mc_node:
+	fwnode_handle_put(mc_node);
+
+	return ret;
+}
+
+static void ncp5623_remove(struct i2c_client *client)
+{
+	struct ncp5623 *ncp = i2c_get_clientdata(client);
+
+	mutex_lock(&ncp->lock);
+	ncp->delay = 0;
+	mutex_unlock(&ncp->lock);
+
+	ncp5623_write(client, NCP5623_DIMMING_TIME_REG, 0);
+	led_classdev_multicolor_unregister(&ncp->mc_dev);
+	mutex_destroy(&ncp->lock);
+}
+
+static void ncp5623_shutdown(struct i2c_client *client)
+{
+	struct ncp5623 *ncp = i2c_get_clientdata(client);
+
+	if (!(ncp->mc_dev.led_cdev.flags & LED_RETAIN_AT_SHUTDOWN))
+		ncp5623_write(client, NCP5623_SHUTDOWN_REG, 0);
+
+	mutex_destroy(&ncp->lock);
+}
+
+static const struct of_device_id ncp5623_id[] = {
+	{ .compatible = "onnn,ncp5623" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ncp5623_id);
+
+static struct i2c_driver ncp5623_i2c_driver = {
+	.driver	= {
+		.name = "ncp5623",
+		.of_match_table = ncp5623_id,
+	},
+	.probe = ncp5623_probe,
+	.remove = ncp5623_remove,
+	.shutdown = ncp5623_shutdown,
+};
+
+module_i2c_driver(ncp5623_i2c_driver);
+
+MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com>");
+MODULE_DESCRIPTION("NCP5623 Multi-LED driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


