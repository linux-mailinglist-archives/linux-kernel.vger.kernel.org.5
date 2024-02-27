Return-Path: <linux-kernel+bounces-82494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C09868556
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFCF286203
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850CEAD7;
	Tue, 27 Feb 2024 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEH1Z/W5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1FE56E;
	Tue, 27 Feb 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995432; cv=none; b=raO3Ur6rpPEmDnH0uhfsPWlpwg6rItYIgJ81I+aUMDkGAGeqSyZGk9QA3eeI/z9YYJxXvEK2kKE8OwFG0UWuJPfmJR1/8QgE2enrjkKhtLVaW4piCHaAve9B+gggpBBDngeY+mgaX8M2rPw13IviP96MhDNK9hRSB+iE9jPk/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995432; c=relaxed/simple;
	bh=q42sbE6Dgv0fa/KUnOLjHsR9dWLx8Zv2Vgm6ZMUdMow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHtj7Spk8m0C4q+sJJVR5cNCaZmIU31NHsIvo/b1cXFTiMIvEkPRbChwbD+K1FmSGK+BFUy1UArPFUZRGwCGqCTBy7YbvTYoM5APTHG8FJF8OMfb3pUYAFwUVPD3SlV9qy45nrrHn2z+cgCBHVVgcIt8pK/wejE7AGqRTn1VHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEH1Z/W5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dca3951ad9so14238285ad.3;
        Mon, 26 Feb 2024 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995429; x=1709600229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viN62ftpMyo6GvVXoLPS/9Wzyg9rdjzqSvpHHxSrBzg=;
        b=kEH1Z/W5cX44Aem96DW+prwv0jDrdg7YVo9QXi0rPufB2aZt0fsaYucuPuWrG/yj47
         +BlTX+Urwt3JZJmKXzJNl/JotsQGCUuPQaFJPDm3Sg4gD8GlUF9leUtz0WXO9OgiIvt4
         QpNaar+SnFdeROiVb5c5e0/VaaiaTTHLixLLe8fR8xMaU/txTSrGdBIpEV5nQxOZnzps
         vrPxya6SQFnHa3TnpsVROwpjftlwAAACG7Zez9VH9+tQr7KOG7acG/8m9+7jdjW2w3+G
         jUUpm9UV594wlccGsiPEvme/zQv2DJTKQRpvy3vUHQNcwx59sTI+bJRq+Jhekit7UclM
         oiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995429; x=1709600229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viN62ftpMyo6GvVXoLPS/9Wzyg9rdjzqSvpHHxSrBzg=;
        b=wEpbf/PBwHVgT/MtFZBqbWDd3kFPyfRt48EMevUPpDXENA8BDyhjioaGdZnzHGkYiX
         Y+zyEfFfK+blhzPSfAX+K8uHBysFeAJc1cPGkoAUQSaJ9333qcu2I9tpQaHVWYnM6EyO
         YpwSUvqmIBY7rWjqvFUjS2ZBUX2XVCWsvP3pwydE8uOuNcp/lhAS7SNd+52XR/JlMnus
         yD8TgQvgDQKieXJpsmsp5Mk4wtY1nxsTvOGX02ZD8igSJ/pBUtm/9e15wp1q5rapQQZ1
         9r6CmMobBDmNOixjAkps3MjSluf1sXWwkwvEzLlt1iaHtdTfON/oeyJk0fg6Dka5HMpu
         v8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX1pDfFv9t1QA43f8CNzfzGUkOzyHbYJxAeu7Lwsp7O4GlwMfS3aHXbFRQhWJQb/ZyGhjiQGNePZ6qwn64T5YoaJ9u4WJV3gtjkSGaF0t33mjeiU/rF/zD9pCMMy6XqxhV9sjK870H573GMiAkaFwJ35Nl7D2H3EIpujC9+NaCEE0DEtQ==
X-Gm-Message-State: AOJu0Yw3+jW2s7cdy1iOtGpJOv9OqsOeV1728Rk5OkebtGxN116TQkg1
	tdbuL6u8FREA9F75699DfuSBGD2Ep5YCO773uiLIYuBEUGC2K+oY
X-Google-Smtp-Source: AGHT+IFlmb8RjkUTYYSXkJ+0JvzRxilISCRNh9utrlTTOL1Dij69Rr3pjgruiKeoQMr9LW0OXHrwwA==
X-Received: by 2002:a17:902:8303:b0:1db:e243:6d64 with SMTP id bd3-20020a170902830300b001dbe2436d64mr8652636plb.69.1708995428675;
        Mon, 26 Feb 2024 16:57:08 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001db3361bc1dsm289253plg.102.2024.02.26.16.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:57:08 -0800 (PST)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com
Subject: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Date: Tue, 27 Feb 2024 08:56:06 +0800
Message-Id: <20240227005606.1107203-4-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/nct7363.rst |  33 +++
 MAINTAINERS                     |   2 +
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/nct7363.c         | 412 ++++++++++++++++++++++++++++++++
 6 files changed, 460 insertions(+)
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c7ed1f73ac06..302f954b45be 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -165,6 +165,7 @@ Hardware Monitoring Kernel Drivers
    mp5990
    nct6683
    nct6775
+   nct7363
    nct7802
    nct7904
    npcm750-pwm-fan
diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct7363.rst
new file mode 100644
index 000000000000..89699c95aa4b
--- /dev/null
+++ b/Documentation/hwmon/nct7363.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver nct7363
+=====================
+
+Supported chip:
+
+  * Nuvoton NCT7363Y
+
+    Prefix: nct7363
+
+    Addresses: I2C 0x20, 0x21, 0x22, 0x23
+
+Author: Ban Feng <kcfeng0@nuvoton.com>
+
+
+Description
+-----------
+
+The NCT7363Y is a Fan controller which provides up to 16 independent
+FAN input monitors, and up to 16 independent PWM output with SMBus interface.
+
+
+Sysfs entries
+-------------
+
+Currently, the driver supports the following features:
+
+======================= =======================================================
+fanX_input		provide current fan rotation value in RPM
+
+pwmX			get or set PWM fan control value.
+======================= =======================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b1efefed7c4..7ca66b713e30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15089,6 +15089,8 @@ M:	Ban Feng <kcfeng0@nuvoton.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+F:	Documentation/hwmon/nct7363.rst
+F:	drivers/hwmon/nct7363.c
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a608264da87d..a297b5409b04 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1616,6 +1616,17 @@ config SENSORS_NCT6775_I2C
 	  This driver can also be built as a module. If so, the module
 	  will be called nct6775-i2c.
 
+config SENSORS_NCT7363
+	tristate "Nuvoton NCT7363Y"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7363Y,
+	  hardware monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct7363.
+
 config SENSORS_NCT7802
 	tristate "Nuvoton NCT7802Y"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 47be39af5c03..d5e7531204df 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) += nct6775-core.o
 nct6775-objs			:= nct6775-platform.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
 obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
+obj-$(CONFIG_SENSORS_NCT7363)	+= nct7363.o
 obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
new file mode 100644
index 000000000000..c79d3ca4f111
--- /dev/null
+++ b/drivers/hwmon/nct7363.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Nuvoton Technology corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define NCT7363_REG_GPIO_0_3		0x20
+#define NCT7363_REG_GPIO_4_7		0x21
+#define NCT7363_REG_GPIO_10_13		0x22
+#define NCT7363_REG_GPIO_14_17		0x23
+#define NCT7363_REG_PWMEN_0_7		0x38
+#define NCT7363_REG_PWMEN_8_15		0x39
+#define NCT7363_REG_FANINEN_0_7		0x41
+#define NCT7363_REG_FANINEN_8_15	0x42
+#define NCT7363_REG_FANINX_HVAL(x)	(0x48 + ((x) * 2))
+#define NCT7363_REG_FANINX_LVAL(x)	(0x49 + ((x) * 2))
+#define NCT7363_REG_FSCPXDUTY(x)	(0x90 + ((x) * 2))
+
+#define PWM_SEL(x)			(BIT(0) << (((x) % 4) * 2))
+#define FANIN_SEL(x)			(BIT(1) << (((x) % 4) * 2))
+
+#define NCT7363_FANINX_LVAL_MASK	GENMASK(4, 0)
+#define NCT7363_FANIN_MASK		GENMASK(12, 0)
+
+#define NCT7363_PWM_COUNT		16
+
+static inline unsigned long FAN_FROM_REG(u16 val)
+{
+	/* In case fan is stopped or divide by 0 */
+	if (val == NCT7363_FANIN_MASK || val == 0)
+		return	0;
+
+	return (1350000UL / val);
+}
+
+static const struct of_device_id nct7363_of_match[] = {
+	{ .compatible = "nuvoton,nct7363" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nct7363_of_match);
+
+struct nct7363_data {
+	struct regmap		*regmap;
+	struct mutex		lock; /* protect register access */
+
+	u16			fanin_mask;
+	u16			pwm_mask;
+};
+
+static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	unsigned int hi, lo;
+	u16 cnt, rpm;
+	int ret = 0;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		/*
+		 * High-byte register should be read first to latch
+		 * synchronous low-byte value
+		 */
+		ret = regmap_read(data->regmap,
+				  NCT7363_REG_FANINX_HVAL(channel), &hi);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(data->regmap,
+			NCT7363_REG_FANINX_LVAL(channel), &lo);
+		if (ret)
+			return ret;
+
+		cnt = (hi << 5) | (lo & NCT7363_FANINX_LVAL_MASK);
+		rpm = FAN_FROM_REG(cnt);
+		*val = (long)rpm;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int channel)
+{
+	const struct nct7363_data *data = _data;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		if (data->fanin_mask & BIT(channel))
+			return 0444;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	u16 ret;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		ret = regmap_read(data->regmap,
+				  NCT7363_REG_FSCPXDUTY(channel), &regval);
+		if (ret)
+			return ret;
+
+		*val = (long)regval;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7363_write_pwm(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		ret = regmap_write(data->regmap,
+				   NCT7363_REG_FSCPXDUTY(channel), val);
+		mutex_unlock(&data->lock);
+
+		return ret;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int channel)
+{
+	const struct nct7363_data *data = _data;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (data->pwm_mask & BIT(channel))
+			return 0644;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nct7363_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return nct7363_read_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return nct7363_read_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7363_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return nct7363_write_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return nct7363_fan_is_visible(data, attr, channel);
+	case hwmon_pwm:
+		return nct7363_pwm_is_visible(data, attr, channel);
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *nct7363_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops nct7363_hwmon_ops = {
+	.is_visible = nct7363_is_visible,
+	.read = nct7363_read,
+	.write = nct7363_write,
+};
+
+static const struct hwmon_chip_info nct7363_chip_info = {
+	.ops = &nct7363_hwmon_ops,
+	.info = nct7363_info,
+};
+
+static int nct7363_init_chip(struct nct7363_data *data)
+{
+	u8 i, gpio0_3 = 0, gpio4_7 = 0, gpio10_13 = 0, gpio14_17 = 0;
+	int ret;
+
+	for (i = 0; i < NCT7363_PWM_COUNT; i++) {
+		if (i < 4) {
+			if (data->pwm_mask & BIT(i))
+				gpio0_3 |= PWM_SEL(i);
+			if (data->fanin_mask & BIT(i))
+				gpio10_13 |= FANIN_SEL(i);
+		} else if (i < 8) {
+			if (data->pwm_mask & BIT(i))
+				gpio4_7 |= PWM_SEL(i);
+			if (data->fanin_mask & BIT(i))
+				gpio14_17 |= FANIN_SEL(i);
+		} else if (i < 12) {
+			if (data->pwm_mask & BIT(i))
+				gpio10_13 |= PWM_SEL(i);
+			if (data->fanin_mask & BIT(i))
+				gpio0_3 |= FANIN_SEL(i);
+		} else {
+			if (data->pwm_mask & BIT(i))
+				gpio14_17 |= PWM_SEL(i);
+			if (data->fanin_mask & BIT(i))
+				gpio4_7 |= FANIN_SEL(i);
+		}
+	}
+
+	/* Pin Function Configuration */
+	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_0_3, gpio0_3);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_4_7, gpio4_7);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_10_13, gpio10_13);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_14_17, gpio14_17);
+	if (ret < 0)
+		return ret;
+
+	/* PWM and FANIN Monitoring Enable */
+	ret = regmap_write(data->regmap, NCT7363_REG_PWMEN_0_7,
+			   data->pwm_mask & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_PWMEN_8_15,
+			   (data->pwm_mask >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_FANINEN_0_7,
+			   data->fanin_mask & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(data->regmap, NCT7363_REG_FANINEN_8_15,
+			   (data->fanin_mask >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int nct7363_present_pwm_fanin(struct device *dev,
+				     struct device_node *child,
+				     struct nct7363_data *data)
+{
+	struct of_phandle_args args;
+	int ret, fanin_cnt;
+	u8 *fanin_ch;
+	u8 ch, index;
+
+	ret = of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
+					 0, &args);
+	if (ret)
+		return ret;
+
+	data->pwm_mask |= BIT(args.args[0]);
+
+	fanin_cnt = of_property_count_u8_elems(child, "tach-ch");
+	if (fanin_cnt < 1)
+		return -EINVAL;
+
+	fanin_ch = devm_kcalloc(dev, fanin_cnt, sizeof(*fanin_ch), GFP_KERNEL);
+	if (!fanin_ch)
+		return -ENOMEM;
+
+	ret = of_property_read_u8_array(child, "tach-ch", fanin_ch, fanin_cnt);
+	if (ret)
+		return ret;
+
+	for (ch = 0; ch < fanin_cnt; ch++) {
+		index = fanin_ch[ch];
+		data->fanin_mask |= BIT(index);
+	}
+
+	return 0;
+}
+
+static const struct regmap_config nct7363_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int nct7363_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *child;
+	struct nct7363_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = devm_regmap_init_i2c(client, &nct7363_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	mutex_init(&data->lock);
+
+	for_each_child_of_node(dev->of_node, child) {
+		ret = nct7363_present_pwm_fanin(dev, child, data);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	/* Initialize the chip */
+	ret = nct7363_init_chip(data);
+	if (ret)
+		return ret;
+
+	hwmon_dev =
+		devm_hwmon_device_register_with_info(dev, client->name, data,
+						     &nct7363_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct i2c_driver nct7363_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "nct7363",
+		.of_match_table = nct7363_of_match,
+	},
+	.probe = nct7363_probe,
+};
+
+module_i2c_driver(nct7363_driver);
+
+MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
+MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
+MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


