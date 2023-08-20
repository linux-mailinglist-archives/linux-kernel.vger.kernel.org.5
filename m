Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC92781F96
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjHTTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHTTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:38:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A226B6;
        Sun, 20 Aug 2023 12:33:05 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a78a2c0f81so1895569b6e.0;
        Sun, 20 Aug 2023 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692559985; x=1693164785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR3oG/sHkVrUDoOjQXLD20MDkEaC4ggWmaFv9w5J/Lw=;
        b=KWRQbXu72ojx6y9dth9rKQ7JJfbGqtZFTqRvpRohfwdaeuLkJ8xaun8C+31qRmTVc0
         qnTsmepQNygA/WJbJWXXNpuDC2CJs0zGf5xe/4JJX3Fi1+Nkd42KBrr1jGqKwYCSxzAa
         wxF4JEn4siX0ieVZwYAeymzm3m8N8MszYmnERfv0c/bFtEj14EYch3kRB5pvjcpPORbh
         msS69UQyT8WmG/zpJVzFPywPNkJWbQSZxRZnEux5C010cyivq9erReZhiuBf+Eww9qSM
         NLv+nD8YLXKi2NppstzFkkc6ogynhVl2IdouTEzqw1HItLCTm6WMWia64xNsSK7zXX7P
         V4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559985; x=1693164785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR3oG/sHkVrUDoOjQXLD20MDkEaC4ggWmaFv9w5J/Lw=;
        b=dmxya6My1YyF/AuP8e7Qa3nJviaGx8zsVqjhSxjIB8D5EpiiOCaZf+8fOHkAItf8NP
         DZQK9wdZS09Yi0vEgq+q9ueXm8j2gFoZ8prL0xAjSeaYbtOoDIONhOu+e6zQCc5iNMSW
         o55Znba9EOsnl2Ljli2FNQM1bF3hcZEqlbpNKu/IKyNxvB6T1BE7rYPN2zR3STPjhkJr
         OXIpuPaJg9sAJmnFiIUf2OKfjRBOTZZHqwL7lT/EbkAZOBrRBoGqehI2EdaSZvOwIY7d
         /Bn9o2ak84vlMfceKFsPt7HsyxgIr3YaAvZVgT5SHBm7gb3EPR+QPjORLkAXBND1kJf1
         eoqA==
X-Gm-Message-State: AOJu0Yy6nb3+N0QQOuq42M2b+E+8naiVYuPgMu2S2v5vP60tXhHOq4Yo
        jZ1ktkgkUUv2gzufKSK5gaQ=
X-Google-Smtp-Source: AGHT+IHcAc8P+wSM/noy+c9WwPAmYs1eJJRHBPGJcK7HvyqVhWieNUPwlBdH5VPmF6cTidnnRxXhWQ==
X-Received: by 2002:a54:4e84:0:b0:3a2:f91a:cb08 with SMTP id c4-20020a544e84000000b003a2f91acb08mr5302662oiy.42.1692559984676;
        Sun, 20 Aug 2023 12:33:04 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm2308042qvm.109.2023.08.20.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:33:04 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] USB: typec: Add TI TPS25750 USB Type-C controller
Date:   Sun, 20 Aug 2023 15:32:27 -0400
Message-Id: <b7525b3501782c04172809cbe8b21bbb97fed863.1692559293.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692559293.git.alkuor@gmail.com>
References: <cover.1692559293.git.alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 is USB Type-C controller and Power Delivery controller.

TPS25750 needs to be configured after a cold reset. The configuration
can be applied either from an external EEPROM connected to the
controller or by a host using I2C. TI provides an online GUI that
can be used to generate the configuration binary.
Tool link: https://tinyurl.com/2s3watcm
P.S. It requires a TI account to be able to use the tool.

Make sure to generate low region binary as using full flash binary fails
when trying to apply the configuration.

In case the configuration is applied using the host, the user needs
to provide the name of the binary using firmware-name property in the
device tree. The process of applying a configuration can be found on
pg.53 in TPS25750 Host Interface Technical Reference Manual(Rev. A).

Also, data-role property must be set as tps25750 doesn't provide a status
information about the data role of the applied configuration.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
v4:
 - Fix all multi-line comments style
 - Remove of_match_ptr
v3:
 - Upload tps25750 driver patch
v2:
 - No change
---
 drivers/usb/typec/Kconfig    |   13 +
 drivers/usb/typec/Makefile   |    1 +
 drivers/usb/typec/tps25750.c | 1077 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/tps25750.h |  162 +++++
 4 files changed, 1253 insertions(+)
 create mode 100644 drivers/usb/typec/tps25750.c
 create mode 100644 drivers/usb/typec/tps25750.h

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 2f80c2792dbd..fa4f73472376 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -110,6 +110,19 @@ config TYPEC_WUSB3801
 	  If you choose to build this driver as a dynamically linked module, the
 	  module will be called wusb3801.ko.
 
+config TYPEC_TPS25750
+	tristate "TI TPS25750 USB Power Delivery controller driver"
+	depends on I2C
+	select REGMAP_I2C
+	select USB_ROLE_SWITCH
+	select POWER_SUPPLY
+	help
+	  Say Y or M here if your system has TI TPS25750 USB Power
+	  Delivery controller.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called tps25750.ko.
+
 source "drivers/usb/typec/mux/Kconfig"
 
 source "drivers/usb/typec/altmodes/Kconfig"
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 7a368fea61bc..1132a557667b 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
 obj-$(CONFIG_TYPEC_RT1719)	+= rt1719.o
 obj-$(CONFIG_TYPEC_WUSB3801)	+= wusb3801.o
 obj-$(CONFIG_TYPEC)		+= mux/
+obj-$(CONFIG_TYPEC_TPS25750)	+= tps25750.o
diff --git a/drivers/usb/typec/tps25750.c b/drivers/usb/typec/tps25750.c
new file mode 100644
index 000000000000..3294a238fca2
--- /dev/null
+++ b/drivers/usb/typec/tps25750.c
@@ -0,0 +1,1077 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for TI TPS25750 USB Power Delivery controller family
+ *
+ * Copyright (C) 2023, Geotab Inc.
+ * Author: Abdel Alkuor <abdelalkuor@geotab.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/role.h>
+#include <linux/firmware.h>
+#include <linux/delay.h>
+#include <linux/power_supply.h>
+#include <linux/minmax.h>
+
+#include "tps25750.h"
+
+/* Register offsets */
+#define TPS_REG_MODE			0x03
+#define TPS_REG_TYPE			0x04
+#define TPS_REG_CUSTUSE			0x06
+#define TPS_REG_CMD1			0x08
+#define TPS_REG_DATA1			0x09
+#define TPS_REG_DEVICE_CAPABILITIES	0x0D
+#define TPS_REG_VERSION			0x0F
+#define TPS_REG_INT_EVENT1		0x14
+#define TPS_REG_INT_MASK1		0x16
+#define TPS_REG_INT_CLEAR1		0x18
+#define TPS_REG_STATUS			0x1A
+#define TPS_REG_POWER_PATH_STATUS	0x26
+#define TPS_REG_PORT_CONTROL		0x29
+#define TPS_REG_BOOT_STATUS		0x2D
+#define TPS_REG_BUILD_DESCRIPTION	0x2E
+#define TPS_REG_DEVICE_INFO		0x2F
+#define TPS_REG_RX_SOURCE_CAPS		0x30
+#define TPS_REG_RX_SINK_CAPS		0x31
+#define TPS_REG_TX_SOURCE_CAPS		0x32
+#define TPS_REG_TX_SINK_CAPS		0x33
+#define TPS_REG_ACTIVE_CONTRACT_PDO	0x34
+#define TPS_REG_ACTIVE_CONTRACT_RDO	0x35
+#define TPS_REG_POWER_STATUS		0x3F
+#define TPS_REG_PD_STATUS		0x40
+#define TPS_REG_TYPEC_STATE		0x69
+#define TPS_REG_GPIO_STATUS		0x72
+#define TPS_REG_MAX			TPS_REG_GPIO_STATUS
+
+#define TPS_MAX_LEN			64
+
+/* 4CC (4 Char Command) Task return code */
+#define TPS_TASK_COMPLETED_SUCCESSFULLY		0x0
+#define TPS_TASK_TIMEOUT_OR_ABRT		0x1
+#define TPS_TASK_REJECTED			0x3
+#define TPS_TASK_REJECTED_RX_BUF_LOCKED		0x4
+
+#define TPS_TASK_BPMS_INVALID_BUNDLE_SIZE	0x4
+#define TPS_TASK_BPMS_INVALID_SLAVE_ADDR	0x5
+#define TPS_TASK_BPMS_INVALID_TIMEOUT		0x6
+
+/* PBMc data out */
+#define TPS_PBMC_RC	0 /* Return code */
+#define TPS_PBMC_DPCS	2 /* device patch complete status */
+
+/* invalid cmd == !CMD */
+#define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
+
+/* 4 Characters Commands (4CC)*/
+#define TPS_4CC_PBMS	"PBMs" /* Start Patch Burst Mode Download Sequence */
+#define TPS_4CC_PBMC	"PBMc" /* Patch Burst Mode Download Complete */
+#define TPS_4CC_PBME	"PBMe" /* End Patch Burst Mode Download Sequence */
+#define TPS_4CC_SWSK	"SWSk" /* Swap to sink power role */
+#define TPS_4CC_SWSR	"SWSr" /* Swap to source power role */
+#define TPS_4CC_SWUF	"SWUF" /* Swap to up facing stream (device) */
+#define TPS_4CC_SWDF	"SWDF" /* Swap to down facing stream (host) */
+#define TPS_4CC_DBFG	"DBfg" /* Clear dead battery flag */
+#define TPS_4CC_GAID	"GAID" /* Cold reset */
+
+/*
+ * Address used in PBMs command where address would be invalid when
+ * 0x00 or I2C client slave address based on ADCINx.
+ * pg.48 TPS2575 Host Interface Technical Reference
+ * Manual (Rev. A)
+ */
+#define TPS_BUNDLE_SLAVE_ADDR	0x0F
+
+/*
+ * BPMs task timeout, recommended 5 seconds
+ * pg.48 TPS2575 Host Interface Technical Reference
+ * Manual (Rev. A)
+ */
+#define TPS_BUNDLE_TIMEOUT	0x32
+
+enum {
+	TPS_MODE_APP,
+	TPS_MODE_BOOT,
+	TPS_MODE_PTCH,
+};
+
+static const char *const modes[] = {
+	[TPS_MODE_APP]	= "APP ",
+	[TPS_MODE_BOOT]	= "BOOT",
+	[TPS_MODE_PTCH]	= "PTCH",
+};
+
+struct tps25750 {
+	struct device *dev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex lock;
+
+	struct typec_port *port;
+	struct typec_partner *partner;
+	struct usb_role_switch *role_sw;
+
+	struct power_supply *psy;
+
+	u32 status_reg;
+	u32 max_source_current;
+};
+
+static const struct regmap_config tps25750_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TPS_REG_MAX,
+};
+
+static enum power_supply_property tps25750_psy_props[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+};
+
+static enum power_supply_usb_type tps25750_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+};
+
+static int
+tps25750_block_write_raw(struct tps25750 *tps, const u8 *data, size_t len)
+{
+	if (len < 2)
+		return -EINVAL;
+
+	return regmap_raw_write(tps->regmap, data[0], &data[1], len - 1);
+}
+
+static int
+tps25750_block_read(struct tps25750 *tps, u8 reg, void *val, size_t len)
+{
+	int ret;
+	u8 data[TPS_MAX_LEN + 1];
+
+	if (len + 1 > TPS_MAX_LEN)
+		return -EINVAL;
+
+	ret = regmap_raw_read(tps->regmap, reg, data, len + 1);
+	if (ret)
+		return ret;
+
+	if (data[0] < len)
+		return -EIO;
+
+	memcpy(val, &data[1], len);
+	return 0;
+}
+
+static int
+tps25750_block_write(struct tps25750 *tps, u8 reg, const void *val, size_t len)
+{
+	u8 data[TPS_MAX_LEN + 1];
+
+	if (len + 1 > TPS_MAX_LEN)
+		return -EINVAL;
+
+	data[0] = len;
+	memcpy(&data[1], val, len);
+
+	return regmap_raw_write(tps->regmap, reg, data, len + 1);
+}
+
+static int tps25750_read(struct tps25750 *tps, u8 reg, u8 *val)
+{
+	return tps25750_block_read(tps, reg, val, sizeof(u8));
+}
+
+static int tps25750_read16(struct tps25750 *tps, u8 reg, u16 *val)
+{
+	return tps25750_block_read(tps, reg, val, sizeof(u16));
+}
+
+static int tps25750_read32(struct tps25750 *tps, u8 reg, u32 *val)
+{
+	return tps25750_block_read(tps, reg, val, sizeof(u32));
+}
+
+static int
+tps25750_wait_cmd_complete(struct tps25750 *tps, unsigned long timeout)
+{
+	int ret;
+	u32 val;
+
+	timeout = jiffies + msecs_to_jiffies(timeout);
+
+	do {
+		ret = tps25750_read32(tps, TPS_REG_CMD1, &val);
+		if (ret)
+			return ret;
+
+		if (INVALID_CMD(val))
+			return -EINVAL;
+
+		if (time_is_before_jiffies(timeout))
+			return -ETIMEDOUT;
+
+		mdelay(10);
+	} while (val);
+
+	return 0;
+}
+
+static int tps25750_exec_cmd(struct tps25750 *tps, const char *cmd,
+			     size_t in_len, u8 *in_data,
+			     size_t out_len, u8 *out_data,
+			     u8 response_delay_ms,
+			     u32 cmd_timeout_ms)
+{
+	int ret;
+	u8 dummy[3] = { };
+
+	if (!out_len || !out_data)
+		return -EINVAL;
+
+	if (in_len) {
+		ret = tps25750_block_write(tps, TPS_REG_DATA1,
+				     in_data, in_len);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * For some reason, if no data is written to
+		 * TPS_REG_DATA1 before sending 4CC, then 4CC would fail
+		 */
+		dummy[0] = TPS_REG_DATA1;
+		ret = tps25750_block_write_raw(tps, dummy, sizeof(dummy));
+		if (ret)
+			return ret;
+	}
+
+	ret = tps25750_block_write(tps, TPS_REG_CMD1, cmd, 4);
+	if (ret)
+		return ret;
+
+	ret = tps25750_wait_cmd_complete(tps, cmd_timeout_ms);
+
+	if (ret)
+		return ret;
+
+	mdelay(response_delay_ms);
+
+	ret = tps25750_block_read(tps, TPS_REG_DATA1, out_data, out_len);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tps25750_exec_normal_cmd(struct tps25750 *tps, const char *cmd)
+{
+	int ret;
+	u8 rc;
+
+	ret = tps25750_exec_cmd(tps, cmd, 0, NULL, 1, &rc, 0, 1000);
+	if (ret)
+		return ret;
+
+	switch (rc) {
+	case TPS_TASK_COMPLETED_SUCCESSFULLY:
+		return 0;
+	case TPS_TASK_TIMEOUT_OR_ABRT:
+		return -ETIMEDOUT;
+	case TPS_TASK_REJECTED:
+		return -EPERM;
+	case TPS_TASK_REJECTED_RX_BUF_LOCKED:
+		return -EBUSY;
+	default:
+		break;
+	}
+
+	return -EIO;
+}
+
+static int
+tps25750_exec_patch_cmd_pbms(struct tps25750 *tps, u8 *in_data, size_t in_len)
+{
+	int ret;
+	u8 rc;
+
+	ret = tps25750_exec_cmd(tps, TPS_4CC_PBMS, in_len, in_data,
+				1, &rc, 0, TPS_BUNDLE_TIMEOUT * 100);
+	if (ret)
+		return ret;
+
+	switch (rc) {
+	case TPS_TASK_BPMS_INVALID_BUNDLE_SIZE:
+		dev_err(tps->dev, "%s: invalid fw size\n", __func__);
+		return -EINVAL;
+	case TPS_TASK_BPMS_INVALID_SLAVE_ADDR:
+		dev_err(tps->dev, "%s: invalid slave address\n", __func__);
+		return -EINVAL;
+	case TPS_TASK_BPMS_INVALID_TIMEOUT:
+		dev_err(tps->dev, "%s: timed out\n", __func__);
+		return -ETIMEDOUT;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int tps25750_complete_patch_process(struct tps25750 *tps)
+{
+	int ret;
+	u8 out_data[40];
+
+	ret = tps25750_exec_cmd(tps, TPS_4CC_PBMC, 0, NULL,
+				sizeof(out_data), out_data, 20, 2000);
+	if (ret)
+		return ret;
+
+	if (out_data[TPS_PBMC_RC]) {
+		dev_err(tps->dev,
+			"%s: pbmc failed: %u\n", __func__,
+			out_data[TPS_PBMC_RC]);
+		return -EIO;
+	}
+
+	if (out_data[TPS_PBMC_DPCS]) {
+		dev_err(tps->dev,
+			"%s: failed device patch complete status: %u\n",
+			__func__, out_data[TPS_PBMC_DPCS]);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int tps25750_get_reg_boot_status(struct tps25750 *tps, u64 *status)
+{
+	int ret;
+
+	ret = tps25750_block_read(tps, TPS_REG_BOOT_STATUS, status, 5);
+	if (ret) {
+		dev_err(tps->dev,
+			"failed to get boot status %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps25750_get_mode(struct tps25750 *tps)
+{
+	char mode[5] = { };
+	int ret;
+
+	ret = tps25750_read32(tps, TPS_REG_MODE, (void *)mode);
+	if (ret)
+		return ret;
+
+	ret = match_string(modes, ARRAY_SIZE(modes), mode);
+
+	if (ret < 0) {
+		dev_err(tps->dev, "unsupported mode \"%s\"\n",
+			mode);
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static int tps2750_is_mode(struct tps25750 *tps, u8 mode)
+{
+	int ret;
+
+	ret = tps25750_get_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	return ret == mode;
+}
+
+static int tps25750_abort_patch_process(struct tps25750 *tps)
+{
+	int ret;
+
+	ret = tps25750_exec_normal_cmd(tps, TPS_4CC_PBME);
+	if (ret)
+		return ret;
+
+	ret = tps2750_is_mode(tps, TPS_MODE_PTCH);
+	if (ret != 1) {
+		dev_err(tps->dev, "%s: failed to switch to \"PTCH\" mode\n",
+			__func__);
+		if (ret < 0)
+			return ret;
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static void tps25750_set_data_role(struct tps25750 *tps,
+		       enum typec_data_role role, bool connected)
+{
+	enum usb_role role_val;
+
+	if (role == TYPEC_HOST)
+		role_val = USB_ROLE_HOST;
+	else
+		role_val = USB_ROLE_DEVICE;
+
+	if (!connected)
+		role_val = USB_ROLE_NONE;
+
+	usb_role_switch_set_role(tps->role_sw, role_val);
+	typec_set_data_role(tps->port, role);
+}
+
+static int tps25750_connect(struct tps25750 *tps, u32 status)
+{
+	struct typec_partner_desc desc;
+	enum typec_pwr_opmode mode;
+	u16 pwr_status;
+	int ret;
+
+	if (!IS_ERR(tps->partner))
+		typec_unregister_partner(tps->partner);
+
+	ret = tps25750_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
+	if (ret < 0)
+		return ret;
+
+	mode = TPS_REG_POWER_STATUS_TYPEC_CURRENT(pwr_status);
+
+	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
+	desc.accessory = TYPEC_ACCESSORY_NONE;
+	desc.identity = NULL;
+
+	typec_set_pwr_opmode(tps->port, mode);
+	typec_set_pwr_role(tps->port, TPS_REG_STATUS_PORT_ROLE(status));
+	tps25750_set_data_role(tps, TPS_REG_STATUS_DATA_ROLE(status), true);
+
+	tps->partner = typec_register_partner(tps->port, &desc);
+	if (IS_ERR(tps->partner))
+		return PTR_ERR(tps->partner);
+
+	power_supply_changed(tps->psy);
+
+	return 0;
+}
+
+static void tps25750_disconnect(struct tps25750 *tps, u32 status)
+{
+	if (!IS_ERR(tps->partner))
+		typec_unregister_partner(tps->partner);
+	tps->partner = NULL;
+	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
+	typec_set_pwr_role(tps->port, TPS_REG_STATUS_PORT_ROLE(status));
+	tps25750_set_data_role(tps, TPS_REG_STATUS_DATA_ROLE(status), false);
+	power_supply_changed(tps->psy);
+}
+
+static void tps25750_handle_plug_event(struct tps25750 *tps, u32 status)
+{
+	int ret;
+
+	if (TPS_REG_STATUS_PLUG_PRESENT(status)) {
+		ret = tps25750_connect(tps, status);
+		if (ret)
+			dev_err(tps->dev,
+				"%s: failed to register partner\n",
+				__func__);
+	} else {
+		tps25750_disconnect(tps, status);
+	}
+}
+
+static bool tps25750_has_role_changed(struct tps25750 *tps, u32 status)
+{
+	status ^= tps->status_reg;
+
+	return TPS_REG_STATUS_PORT_ROLE(status) ||
+		TPS_REG_STATUS_DATA_ROLE(status);
+}
+
+static irqreturn_t tps25750_interrupt(int irq, void *data)
+{
+	struct tps25750 *tps = data;
+	u32 status;
+	int ret;
+	u32 event[3] = { };
+	u8 no_events = 0;
+
+	mutex_lock(&tps->lock);
+
+	/* events reg size is 11 bytes */
+	ret = tps25750_block_read(tps, TPS_REG_INT_EVENT1, event,
+				  sizeof(event) - 1);
+
+	if (ret) {
+		dev_err(tps->dev,
+			"%s: failed to read events ret: %d\n", __func__, ret);
+		goto err_unlock;
+	}
+
+	if (!event[0] && !event[1] && !event[2]) {
+		no_events = 1;
+		goto err_unlock;
+	}
+
+	if (!(TPS_REG_EVENT1_STATUS_UPDATE & event[0]))
+		goto clear_events;
+
+	ret = tps25750_read32(tps, TPS_REG_STATUS, &status);
+	if (ret) {
+		dev_err(tps->dev,
+			"%s: failed to read status\n", __func__);
+		goto clear_events;
+	}
+
+	/*
+	 * data/port roles could be updated independently after
+	 * a plug event. Therefore, we need to check
+	 * for pr/dr status change to set TypeC dr/pr accordingly.
+	 */
+	if (TPS_REG_EVENT1_PLUG_INSERT_OR_REMOVAL & event[0] ||
+		tps25750_has_role_changed(tps, status))
+		tps25750_handle_plug_event(tps, status);
+
+	tps->status_reg = status;
+clear_events:
+	/* clear reg size is 11 bytes */
+	tps25750_block_write(tps, TPS_REG_INT_CLEAR1, event,
+			     sizeof(event) - 1);
+
+err_unlock:
+	mutex_unlock(&tps->lock);
+
+	if (no_events)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int tps25750_dr_set(struct typec_port *port, enum typec_data_role role)
+{
+	struct tps25750 *tps = typec_get_drvdata(port);
+	const char *cmd = (role == TYPEC_DEVICE) ? TPS_4CC_SWUF : TPS_4CC_SWDF;
+	int ret;
+	u32 status;
+
+	mutex_lock(&tps->lock);
+
+	ret = tps25750_exec_normal_cmd(tps, cmd);
+	if (ret)
+		goto release_lock;
+
+	ret = tps25750_read32(tps, TPS_REG_STATUS, &status);
+	if (ret)
+		goto release_lock;
+
+	if (role != TPS_REG_STATUS_DATA_ROLE(status)) {
+		ret = -EPROTO;
+		goto release_lock;
+	}
+
+	tps25750_set_data_role(tps, role, true);
+
+release_lock:
+	mutex_unlock(&tps->lock);
+
+	return ret;
+}
+
+static int
+tps25750_write_firmware(struct tps25750 *tps, const u8 *data, size_t len)
+{
+	int ret;
+	u8 addr;
+	int timeout;
+
+	addr = tps->client->addr;
+	timeout = tps->client->adapter->timeout;
+
+	/*
+	 * Writing the patch might take some time as we are
+	 * writing the whole patch at once.
+	 * Tested using 5 seconds at 100kHz seems to work
+	 */
+	tps->client->adapter->timeout = msecs_to_jiffies(5000);
+	tps->client->addr = TPS_BUNDLE_SLAVE_ADDR;
+
+	ret = tps25750_block_write_raw(tps, data, len);
+
+	tps->client->addr = addr;
+	tps->client->adapter->timeout = timeout;
+
+	return ret;
+}
+
+static int tps25750_start_patch_burst_mode(struct tps25750 *tps)
+{
+	int ret;
+	const struct firmware *fw;
+	const char *firmware_name;
+	struct {
+		u32 fw_size;
+		u8 i2c_slave_addr;
+		u8 timeout;
+	} __packed pbms_in_data;
+
+	ret = device_property_read_string(tps->dev, "firmware-name",
+					  &firmware_name);
+	if (ret)
+		return ret;
+
+	ret = request_firmware(&fw, firmware_name, tps->dev);
+	if (ret) {
+		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
+		return ret;
+	}
+
+	if (fw->size == 0) {
+		ret = -EINVAL;
+		goto release_fw;
+	}
+
+	pbms_in_data.fw_size = fw->size;
+	pbms_in_data.i2c_slave_addr = TPS_BUNDLE_SLAVE_ADDR;
+	pbms_in_data.timeout = TPS_BUNDLE_TIMEOUT;
+
+	ret = tps25750_exec_patch_cmd_pbms(tps, (u8 *)&pbms_in_data,
+					   sizeof(pbms_in_data));
+	if (ret)
+		goto release_fw;
+
+	ret = tps25750_write_firmware(tps, fw->data, fw->size);
+	if (ret) {
+		dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
+			firmware_name, fw->size);
+	} else {
+		/*
+		 * A delay of 500us is required after the firmware is written
+		 * based on pg.62 in TPS25750 Host Interface Technical
+		 * Reference Manual
+		 */
+		udelay(500);
+		ret = 0;
+	}
+
+release_fw:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int tps25750_apply_patch(struct tps25750 *tps)
+{
+	int ret;
+	unsigned long timeout;
+	u64 boot_status;
+
+	ret = tps2750_is_mode(tps, TPS_MODE_PTCH);
+	if (ret != 1)
+		return ret;
+
+	ret = tps25750_get_reg_boot_status(tps, &boot_status);
+	if (ret)
+		return ret;
+
+	/*
+	 * Nothing to be done if the configuration
+	 * is being loaded from EERPOM
+	 */
+	if (TPS_REG_BOOT_STATUS_I2C_EEPROM_PRESENT(boot_status))
+		goto wait_for_app;
+
+	ret = tps25750_start_patch_burst_mode(tps);
+	if (ret) {
+		tps25750_abort_patch_process(tps);
+		return ret;
+	}
+
+	ret = tps25750_complete_patch_process(tps);
+	if (ret)
+		return ret;
+
+wait_for_app:
+	timeout = jiffies + msecs_to_jiffies(1000);
+
+	do {
+		ret = tps2750_is_mode(tps, TPS_MODE_APP);
+		if (ret < 0)
+			return ret;
+
+		if (time_is_before_jiffies(timeout))
+			return -ETIMEDOUT;
+
+		mdelay(10);
+
+	} while (ret != 1);
+
+	if (ret == 0)
+		return -EPROTO;
+
+	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
+
+	return 0;
+};
+
+static int tps25750_pr_set(struct typec_port *port, enum typec_role role)
+{
+	struct tps25750 *tps = typec_get_drvdata(port);
+	const char *cmd = (role == TYPEC_SINK) ? TPS_4CC_SWSK : TPS_4CC_SWSR;
+	int ret;
+	u32 status;
+
+	mutex_lock(&tps->lock);
+
+	ret = tps25750_exec_normal_cmd(tps, cmd);
+	if (ret)
+		goto release_lock;
+
+	ret = tps25750_read32(tps, TPS_REG_STATUS, &status);
+	if (ret)
+		goto release_lock;
+
+	if (role != TPS_REG_STATUS_PORT_ROLE(status)) {
+		ret = -EPROTO;
+		goto release_lock;
+	}
+
+	typec_set_pwr_role(tps->port, role);
+
+release_lock:
+	mutex_unlock(&tps->lock);
+
+	return ret;
+}
+
+static int tps25750_find_max_source_curr(struct tps25750 *tps)
+{
+	int ret;
+	int i;
+	u8 buf[31];
+	u8 npdo;
+	u32 pdo;
+
+	ret = tps25750_block_read(tps, TPS_REG_TX_SOURCE_CAPS,
+				  buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	/*
+	 * The first byte is header which contains number of
+	 * valid PDOs. Up to 7.
+	 */
+	npdo = TPS_PDO_NUM_VALID_PDOS(buf[0]);
+
+	/*
+	 * Each PDO is 4 byte in length where each PDO starts
+	 * as following:
+	 * PDO1: byte 3
+	 * PDO2: byte 7
+	 *    ...
+	 * PDO7: byte 27
+	 * See pg.28 in TPS25750 Host Interface Technical Reference
+	 * Manual (Rev. A)
+	 */
+	for (i = 1; i <= npdo; i++) {
+		memcpy(&pdo, &buf[i*4 - 1], sizeof(pdo));
+		tps->max_source_current	= max_t(u32,
+						tps->max_source_current,
+						TPS_PDO_MAX_CURRENT(pdo));
+	}
+
+	return 0;
+}
+
+static int tps25750_clear_dead_battery(struct tps25750 *tps)
+{
+	int ret;
+
+	ret = tps25750_exec_normal_cmd(tps, TPS_4CC_DBFG);
+	if (ret) {
+		dev_err(tps->dev,
+			"failed to clear dead battery %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps25750_init(struct tps25750 *tps)
+{
+	int ret;
+	u64 boot_status;
+
+	tps->status_reg = 0;
+
+	ret = tps2750_is_mode(tps, TPS_MODE_BOOT);
+	if (ret == 1) {
+		dev_warn(tps->dev, "Device booting in dead battery");
+		return 0;
+	}
+
+	ret = tps25750_apply_patch(tps);
+	if (ret)
+		return ret;
+
+	/*
+	 * The dead battery flag may be triggered when the controller
+	 * port is connected to a device that can source power and
+	 * attempts to power up both the controller and the board it is on.
+	 * To restore controller functionality, it is necessary to clear
+	 * this flag
+	 */
+	ret = tps25750_get_reg_boot_status(tps, &boot_status);
+	if (ret)
+		return ret;
+
+	if (TPS_REG_BOOT_STATUS_DEAD_BATTERY_FLAG(boot_status))
+		return tps25750_clear_dead_battery(tps);
+
+	return 0;
+}
+
+static int tps25750_psy_get_prop(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct tps25750 *tps = power_supply_get_drvdata(psy);
+	u16 pwr_status;
+	int ret;
+
+	ret = tps25750_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		if (TPS_REG_POWER_STATUS_TYPEC_CURRENT(pwr_status) ==
+		    TPS_TYPEC_CURRENT_PD)
+			val->intval = POWER_SUPPLY_USB_TYPE_PD;
+		else
+			val->intval = POWER_SUPPLY_USB_TYPE_C;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = TPS_REG_POWER_STATUS_POWER_CONNECTION(pwr_status);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		/*
+		 * maximum possible pdo source current is
+		 * 1023 (10.23) A.
+		 */
+		val->intval = tps->max_source_current * 10000;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct power_supply_desc tps25750_psy_desc = {
+	.name = "tps25750-psy",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = tps25750_psy_usb_types,
+	.num_usb_types = ARRAY_SIZE(tps25750_psy_usb_types),
+	.properties = tps25750_psy_props,
+	.num_properties = ARRAY_SIZE(tps25750_psy_props),
+	.get_property = tps25750_psy_get_prop,
+};
+
+static const struct typec_operations tps25750_ops = {
+	.dr_set = tps25750_dr_set,
+	.pr_set = tps25750_pr_set,
+};
+
+static int tps25750_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = { };
+	struct typec_capability typec_cap = { };
+	struct tps25750 *tps;
+	struct fwnode_handle *fwnode;
+	int ret;
+	u8 pd_status;
+	const char *data_role;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EPROTO;
+
+	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
+	if (!tps)
+		return -ENOMEM;
+
+	mutex_init(&tps->lock);
+
+	tps->client = client;
+	tps->dev = &client->dev;
+
+	tps->regmap = devm_regmap_init_i2c(client, &tps25750_regmap_config);
+	if (IS_ERR(tps->regmap))
+		return PTR_ERR(tps->regmap);
+
+	ret = tps25750_init(tps);
+	if (ret)
+		return ret;
+
+	ret = tps25750_read(tps, TPS_REG_PD_STATUS, &pd_status);
+	if (ret)
+		goto err_remove_patch;
+
+	fwnode = device_get_named_child_node(&client->dev, "connector");
+	if (!fwnode) {
+		ret = -ENODEV;
+		goto err_remove_patch;
+	}
+
+	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
+	if (IS_ERR(tps->role_sw)) {
+		ret = PTR_ERR(tps->role_sw);
+		goto err_fwnode_put;
+	}
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
+	if (ret) {
+		dev_err(tps->dev, "data-role not found: %d\n", ret);
+		goto err_role_put;
+	}
+
+	ret = typec_find_port_data_role(data_role);
+	if (ret < 0) {
+		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
+		goto err_role_put;
+	}
+
+	typec_cap.data = ret;
+	typec_cap.revision = USB_TYPEC_REV_1_3;
+	typec_cap.pd_revision = 0x300;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps25750_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+	switch (TPS_REG_PD_STATUS_PORT_TYPE(pd_status)) {
+	case TPS_PORT_TYPE_SINK_SOURCE:
+	case TPS_PORT_TYPE_SOURCE_SINK:
+		typec_cap.type = TYPEC_PORT_DRP;
+		break;
+	case TPS_PORT_TYPE_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		break;
+	case TPS_PORT_TYPE_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		break;
+	default:
+		ret = -ENODEV;
+		goto err_role_put;
+	}
+
+	psy_cfg.fwnode = dev_fwnode(tps->dev);
+	psy_cfg.drv_data = tps;
+
+	tps->psy = devm_power_supply_register(tps->dev,
+					      &tps25750_psy_desc,
+					      &psy_cfg);
+	if (IS_ERR(tps->psy)) {
+		ret = PTR_ERR(tps->psy);
+		goto err_role_put;
+	}
+
+	tps->port = typec_register_port(&client->dev, &typec_cap);
+	if (IS_ERR(tps->port)) {
+		ret = PTR_ERR(tps->port);
+		goto err_role_put;
+	}
+
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					tps25750_interrupt,
+					IRQF_SHARED | IRQF_ONESHOT,
+					dev_name(&client->dev), tps);
+	if (ret)
+		goto err_port_unregister;
+
+	tps25750_find_max_source_curr(tps);
+	i2c_set_clientdata(client, tps);
+	fwnode_handle_put(fwnode);
+
+	return 0;
+
+err_port_unregister:
+	typec_unregister_port(tps->port);
+err_role_put:
+	usb_role_switch_put(tps->role_sw);
+err_fwnode_put:
+	fwnode_handle_put(fwnode);
+err_remove_patch:
+	tps25750_exec_normal_cmd(tps, TPS_4CC_GAID);
+
+	return ret;
+}
+
+static void tps25750_remove(struct i2c_client *client)
+{
+	struct tps25750 *tps = i2c_get_clientdata(client);
+
+	tps25750_disconnect(tps, 0);
+	typec_unregister_port(tps->port);
+	usb_role_switch_put(tps->role_sw);
+
+	/* clear the patch by a hard reset */
+	tps25750_exec_normal_cmd(tps, TPS_4CC_GAID);
+}
+
+static int __maybe_unused tps25750_suspend(struct device *dev)
+{
+	/* TODO: should we remove the patch? */
+	return 0;
+}
+
+static int __maybe_unused tps25750_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tps25750 *tps = i2c_get_clientdata(client);
+
+	/*
+	 * The controller needs to be reinitialized again
+	 * if it is powered off as config is not persisted
+	 */
+	return tps25750_init(tps);
+}
+
+static const struct dev_pm_ops tps25750_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tps25750_suspend, tps25750_resume)
+};
+
+static const struct of_device_id tps25750_of_match[] = {
+	{ .compatible = "ti,tps25750", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps25750_of_match);
+
+static const struct i2c_device_id tps25750_id[] = {
+	{ "tps25750" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tps25750_id);
+
+static struct i2c_driver tps25750_i2c_driver = {
+	.driver = {
+		.name = "tps25750",
+		.pm = pm_ptr(&tps25750_pm_ops),
+		.of_match_table = tps25750_of_match,
+	},
+	.probe_new = tps25750_probe,
+	.remove = tps25750_remove,
+	.id_table = tps25750_id,
+};
+module_i2c_driver(tps25750_i2c_driver);
+
+MODULE_AUTHOR("Abdel Alkuor <abdelalkuor@geotab.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI TPS25750 USB Power Delivery Controller Driver");
diff --git a/drivers/usb/typec/tps25750.h b/drivers/usb/typec/tps25750.h
new file mode 100644
index 000000000000..cb558a255e2c
--- /dev/null
+++ b/drivers/usb/typec/tps25750.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for TI TPS25750 USB Power Delivery controller family
+ *
+ * Copyright (C) 2023, Geotab Inc.
+ * Author: Abdel Alkuor <abdelalkuor@geotab.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+
+#ifndef __TPS25750_H__
+#define __TPS25750_H__
+
+/* events 1-4 */
+#define TPS_REG_EVENT1_PD_HARD_RESET			BIT(1)
+#define TPS_REG_EVENT1_PLUG_INSERT_OR_REMOVAL		BIT(3)
+#define TPS_REG_EVENT1_PR_SWAP_COMPLETE			BIT(4)
+#define TPS_REG_EVENT1_DR_SWAP_COMPLETE			BIT(5)
+#define TPS_REG_EVENT1_NEW_CONTRACT_AS_CONS		BIT(12)
+#define TPS_REG_EVENT1_NEW_CONTRACT_AS_PROV		BIT(13)
+#define TPS_REG_EVENT1_SOURCE_CAP_MSG_RCVD		BIT(14)
+#define TPS_REG_EVENT1_PR_SWAP_REQUESTED		BIT(17)
+#define TPS_REG_EVENT1_DR_SWAP_REQUESTED		BIT(18)
+#define TPS_REG_EVENT1_USB_HOST_PRESENT			BIT(20)
+#define TPS_REG_EVENT1_USB_HOST_PRESENT_NO_LONGER	BIT(21)
+#define TPS_REG_EVENT1_PP_SWITCH_CHANGED		BIT(23)
+#define TPS_REG_EVENT1_POWER_STATUS_UPDATE		BIT(24)
+#define TPS_REG_EVENT1_STATUS_UPDATE			BIT(26)
+#define TPS_REG_EVENT1_PD_STATUS_UPDATE			BIT(27)
+#define TPS_REG_EVENT1_CMD_COMPLETE			BIT(30)
+
+/* events 5-8 */
+#define TPS_REG_EVENT1_ERROR_DEVICE_INCOMPLETE				BIT(0)
+#define TPS_REG_EVENT1_ERROR_CANNOT_PROVIDE_VOLATAGE_OR_CURRENT		BIT(1)
+#define TPS_REG_EVENT1_ERROR_CAN_PROVIDE_VOLATAGE_OR_CURRENT_LATER	BIT(2)
+#define TPS_REG_EVENT1_ERROR_POWER_EVENT_OCCURRED			BIT(3)
+#define TPS_REG_EVENT1_ERROR_MISSING_GET_CAP_MESSAGE			BIT(4)
+#define TPS_REG_EVENT1_ERROR_PROTOCOL_ERROR				BIT(6)
+#define TPS_REG_EVENT1_ERROR_MESSAGAE_DATA				BIT(7)
+#define TPS_REG_EVENT1_SINK_TRANSITION_COMPLETE				BIT(9)
+#define TPS_REG_EVENT1_PLUG_EARLY_NOTIFICATION				BIT(10)
+#define TPS_REG_EVENT1_ERROR_PLUG_EARLY_NOTIFICATION			BIT(11)
+#define TPS_REG_EVENT1_ERROR_UNABLE_TO_SOURCE				BIT(14)
+
+/* events 9-11 */
+#define TPS_REG_EVENT1_TX_MEM_BUFFER_EMPTY	BIT(1)
+#define TPS_REG_EVENT1_PATCH_LOADED		BIT(16)
+#define TPS_REG_EVENT1_READY_FOR_PATCH		BIT(17)
+#define TPS_REG_EVENT1_I2C_MASTER_NACKED	BIT(18)
+
+/* STATUS Register */
+#define TPS_REG_STATUS_PLUG_MASK		BIT(0)
+#define TPS_REG_STATUS_PLUG_PRESENT(_s) \
+	FIELD_GET(TPS_REG_STATUS_PLUG_MASK, _s)
+#define TPS_REG_STATUS_CONN_STATE_MASK		GENMASK(3, 1)
+#define TPS_REG_STATUS_CONN_STATE(_s) \
+	FIELD_GET(TPS_REG_STATUS_CONN_STATE_MASK, _s)
+#define TPS_REG_STATUS_PLUG_ORIENTATION_MASK	BIT(4)
+#define TPS_REG_STATUS_PLUG_ORIENTATION(_s) \
+	FIELD_GET(TPS_REG_STATUS_PLUG_ORIENTATION_MASK, _s)
+#define TPS_REG_STATUS_PORT_ROLE_MASK		BIT(5)
+#define TPS_REG_STATUS_PORT_ROLE(_s) \
+	FIELD_GET(TPS_REG_STATUS_PORT_ROLE_MASK, _s)
+#define TPS_REG_STATUS_DATA_ROLE_MASK		BIT(6)
+#define TPS_REG_STATUS_DATA_ROLE(_s) \
+	FIELD_GET(TPS_REG_STATUS_DATA_ROLE_MASK, _s)
+#define TPS_REG_STATUS_VBUS_STATUS_MASK		GENMASK(21, 20)
+#define TPS_REG_STATUS_VBUS_STATUS(_s) \
+	FIELD_GET(TPS_REG_STATUS_VBUS_STATUS_MASK, _s)
+#define TPS_REG_STATUS_USB_HOST_PRESENT_MASK	GENMASK(23, 22)
+#define TPS_REG_STATUS_USB_HOST_PRESENT(_s) \
+	FIELD_GET(TPS_REG_STATUS_USB_HOST_PRESENT_MASK, _s)
+#define TPS_REG_STATUS_ACTING_AS_LEGACY_MASK	GENMASK(25, 24)
+#define TPS_REG_STATUS_ACTING_AS_LEGACY(_s) \
+	FIELD_GET(TPS_REG_STATUS_ACTING_AS_LEGACY_MASK, _s)
+#define TPS_REG_STATUS_BIST_MASK		BIT(27)
+#define TPS_REG_STATUS_BIST(_s) \
+	FIELD_GET(TPS_REG_STATUS_BIST_MASK, _s)
+
+/* BOOT STATUS REG */
+#define TPS_REG_BOOT_STATUS_PATCH_HEADER_ERR_MASK	BIT(0)
+#define TPS_REG_BOOT_STATUS_PATCH_HEADER_ERR(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_PATCH_HEADER_ERR_MASK, _s)
+#define TPS_REG_BOOT_STATUS_DEAD_BATTERY_FLAG_MASK	BIT(2)
+#define TPS_REG_BOOT_STATUS_DEAD_BATTERY_FLAG(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_DEAD_BATTERY_FLAG_MASK, _s)
+#define TPS_REG_BOOT_STATUS_I2C_EEPROM_PRESENT_MASK	BIT(3)
+#define TPS_REG_BOOT_STATUS_I2C_EEPROM_PRESENT(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_I2C_EEPROM_PRESENT_MASK, _s)
+#define TPS_REG_BOOT_STATUS_PATCH_DOWNLOAD_ERR_MASK	BIT(10)
+#define TPS_REG_BOOT_STATUS_PATCH_DOWNLOAD_ERR(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_PATCH_DOWNLOAD_ERR_MASK, _s)
+#define TPS_REG_BOOT_STATUS_MASTER_TSD_MASK		BIT(19)
+#define TPS_REG_BOOT_STATUS_MASTER_TSD(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_MASTER_TSD_MASK, _s)
+#define TPS_REG_BOOT_STATUS_PATCH_CONFIG_SOURCE_MASK	GENMASK(31, 29)
+#define TPS_REG_BOOT_STATUS_PATCH_CONFIG_SOURCE(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_PATCH_CONFIG_SOURCE_MASK, _s)
+#define TPS_REG_BOOT_STATUS_REV_ID_MASK			GENMASK_ULL(39, 32)
+#define TPS_REG_BOOT_STATUS_REV_ID(_s) \
+	FIELD_GET(TPS_REG_BOOT_STATUS_REV_ID_MASK, _s)
+
+/* POWER STATUS REG */
+#define TPS_REG_POWER_STATUS_POWER_CONNECTION_MASK	BIT(0)
+#define TPS_REG_POWER_STATUS_POWER_CONNECTION(_s) \
+	FIELD_GET(TPS_REG_POWER_STATUS_POWER_CONNECTION_MASK, _s)
+#define TPS_REG_POWER_STATUS_SOURCE_SINK_MASK		BIT(1)
+#define TPS_REG_POWER_STATUS_SOURCE_SINK(_s) \
+	FIELD_GET(TPS_REG_POWER_STATUS_SOURCE_SINK_MASK, _s)
+#define TPS_REG_POWER_STATUS_TYPEC_CURRENT_MASK	GENMASK(3, 2)
+#define TPS_REG_POWER_STATUS_TYPEC_CURRENT(_s) \
+	FIELD_GET(TPS_REG_POWER_STATUS_TYPEC_CURRENT_MASK, _s)
+#define TPS_REG_POWER_STATUS_CHARGER_DETECT_MASK	GENMASK(7, 4)
+#define TPS_REG_POWER_STATUS_CHARGER_DETECT(_s) \
+	FIELD_GET(TPS_REG_POWER_STATUS_CHARGER_DETECT_MASK, _s)
+#define TPS_REG_POWER_STATUS_CHARGER_ADVERTISE_MASK	GENMASK(9, 8)
+#define TPS_REG_POWER_STATUS_CHARGER_ADVERTISE(_s) \
+	FIELD_GET(TPS_REG_POWER_STATUS_CHARGER_ADVERTISE_MASK, _s)
+
+/* PD STATUS REG */
+#define TPS_REG_PD_STATUS_CC_PULL_UP_MASK		GENMASK(3, 2)
+#define TPS_REG_PD_STATUS_CC_PULL_UP(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_CC_PULL_UP_MASK, _s)
+#define TPS_REG_PD_STATUS_PORT_TYPE_MASK		GENMASK(5, 4)
+#define TPS_REG_PD_STATUS_PORT_TYPE(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, _s)
+#define TPS_REG_PD_STATUS_PERESENT_PD_ROLE_MASK		BIT(6)
+#define TPS_REG_PD_STATUS_PD_CONN(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_PERESENT_PD_ROLE_MASK, _s)
+#define TPS_REG_PD_STATUS_SOFT_RESET_DETAILS_MASK	GENMASK(12, 8)
+#define TPS_REG_PD_STATUS_SOFT_RESET_DETAILS(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_SOFT_RESET_DETAILS_MASK, _s)
+#define TPS_REG_PD_STATUS_HARD_RESET_DETAILS_MASK	GENMASK(21, 16)
+#define TPS_REG_PD_STATUS_HARD_RESET_DETAILS(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_HARD_RESET_DETAILS_MASK, _s)
+#define TPS_REG_PD_STATUS_ERR_RECOVERY_DETAILS_MASK	GENMASK(27, 22)
+#define TPS_REG_PD_STATUS_ERR_RECOVERY_DETAILS(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_ERR_RECOVERY_DETAILS_MASK, _s)
+#define TPS_REG_PD_STATUS_DATA_RESET_DETAILS_MASK	GENMASK(30, 28)
+#define TPS_REG_PD_STATUS_DATA_RESET_DETAILS(_s) \
+	FIELD_GET(TPS_REG_PD_STATUS_DATA_RESET_DETAILS_MASK, _s)
+
+/* TX_SOURCE_CAPS REG */
+#define TPS_PDO_NUM_VALID_PDOS_MASK	GENMASK(2, 0)
+#define TPS_PDO_NUM_VALID_PDOS(_header) \
+	FIELD_GET(TPS_PDO_NUM_VALID_PDOS_MASK, _header)
+#define TPS_PDO_MAX_CURRENT_MASK	GENMASK(9, 0)
+#define TPS_PDO_MAX_CURRENT(_pdo) \
+	FIELD_GET(TPS_PDO_MAX_CURRENT_MASK, _pdo)
+
+#define TPS_PORT_TYPE_SINK_SOURCE	0
+#define TPS_PORT_TYPE_SINK		1
+#define TPS_PORT_TYPE_SOURCE		2
+#define TPS_PORT_TYPE_SOURCE_SINK	3
+
+#define TPS_TYPEC_CURRENT_USB_DEFAULT	0
+#define TPS_TYPEC_CURRENT_1_5_A		1
+#define TPS_TYPEC_CURRENT_3_0_A		2
+#define TPS_TYPEC_CURRENT_PD		3
+
+#endif /* __TPS25750_H__ */
-- 
2.34.1

