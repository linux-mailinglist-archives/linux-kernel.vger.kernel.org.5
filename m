Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F248A7B0B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjI0R5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjI0R5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472FFB;
        Wed, 27 Sep 2023 10:57:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so14061987a12.1;
        Wed, 27 Sep 2023 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837456; x=1696442256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJcYqNpImLuQRg8Dy6zmjayVHVCVmOST2NVEJA6ZGhI=;
        b=Di1ciBy+Ux/1tMzAYo9Hmh1Rb6pkL32toO/czYcukbOv6PCWYPFCvXytxviOLNb2Oo
         k1HLv43UOmRr398JpGoncrSRgBB1PvVyXC1vVlLinSSYJcYfUo2Q7BezY371q2lMnl+3
         EUy2ce/SmEGB5aYJm1skI6GAPQHpd7cl31SjsKmLvFZdRQmUxxnDlkuXZXiDBPhUBrZp
         mk0fXdkroCpRWXKhcuRB9/pTHLJjFgi87KCNWTFanCJJm8G0ENNbsoeSBlPlhMrLoAid
         vOxBIT+6UI0oqpvu9fHxSj8WuusHNblEijHo5ecAffJd17+ucPGuOe7FEBSqCYFXkwBp
         xQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837456; x=1696442256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJcYqNpImLuQRg8Dy6zmjayVHVCVmOST2NVEJA6ZGhI=;
        b=RGibUmhIEuRyxnI6XPl9vp4vhEfEKIQYfXWzFb2ZkwQZ8/WLRdMLx+zY4ndMfEXGYH
         x2+aurrF27h7w5mP/XYviPxPU37Ez70PVqiEz/DdSHtID8x0mJ8p9jrpG3X/NjhPsrnu
         HeePj0+ikMaKXPMXBPUk+hU0JeKIchEuYYkAdS3hPt7+/UB22cIGXsIEX0cledLqI90K
         476p1JlgUOph+ynNcq5bjVwj4eZ07Klqxs8cPz3ZBbWUa1UdHCTMCnI7I7owOiw6GX+s
         yEbi4dIJ++waNt0z3P7tSTvW7xy5ImRYZGLA+Y6YY9PqzJ0XVcCzAGakxP0LkD75dq+X
         96lw==
X-Gm-Message-State: AOJu0YzblUUkhxah48UFPKdxbgAGxASAMYC+5oQgbQuTP5epfgmTcwEF
        QZ0M26bh7qq+/E5lx1cJKdI=
X-Google-Smtp-Source: AGHT+IEyKhSRCxYe0/UR9gyrdP14n1qz84JsnJXZLv2oOBI/Oi0pfxoe/1WJkCqdLiZtd5n7i/v4GQ==
X-Received: by 2002:a17:906:3143:b0:9ae:7088:6e5d with SMTP id e3-20020a170906314300b009ae70886e5dmr2573182eje.3.1695837455980;
        Wed, 27 Sep 2023 10:57:35 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:35 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 04/14] USB: typec: tps6598x: Load TPS25750 patch bundle
Date:   Wed, 27 Sep 2023 13:53:38 -0400
Message-Id: <20230927175348.18041-5-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 controller requires a binary to be loaded with a configuration
binary by an EEPROM or a host.

Appling a patch bundling using a host is implemented based on the flow
diagram pg.62 in TPS25750 host interface manual.
https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf

The flow diagram can be summarized as following:
- Start the patch loading sequence with patch bundle information by
  executing PBMs
- Write the whole patch at once
- When writing the patch fails, execute PBMe which instructs the PD controller
  to end the patching process
- After writing the patch successfully, execute PBMc which verifies the patch
  integrity and applies the patch internally
- Wait for the device to switch into APP mode (normal operation)

The execuation flow diagram polls the events register and then polls the
corresponding register related to the event as well before advancing to the next
state. Polling the events register is a redundant step, in this implementation
only the corresponding register related to the event is polled.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Don't check VID for tps25750 as the VID register doesn't exist
  - Remove is_tps25750 flag from tps6598x struct
  - Get patch address from reg property
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 254 +++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 58679b1c0cfe..f96a9ff07fba 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
 #include <linux/workqueue.h>
+#include <linux/firmware.h>
 
 #include "tps6598x.h"
 #include "trace.h"
@@ -43,6 +44,23 @@
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
+/*
+ * BPMs task timeout, recommended 5 seconds
+ * pg.48 TPS2575 Host Interface Technical Reference
+ * Manual (Rev. A)
+ * https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
+ */
+#define TPS_BUNDLE_TIMEOUT	0x32
+
+/* BPMs return code */
+#define TPS_TASK_BPMS_INVALID_BUNDLE_SIZE	0x4
+#define TPS_TASK_BPMS_INVALID_SLAVE_ADDR	0x5
+#define TPS_TASK_BPMS_INVALID_TIMEOUT		0x6
+
+/* PBMc data out */
+#define TPS_PBMC_RC	0 /* Return code */
+#define TPS_PBMC_DPCS	2 /* device patch complete status */
+
 enum {
 	TPS_PORTINFO_SINK,
 	TPS_PORTINFO_SINK_ACCESSORY,
@@ -713,6 +731,213 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
 	return PTR_ERR_OR_ZERO(tps->psy);
 }
 
+static int
+tps25750_write_firmware(struct tps6598x *tps,
+			u8 bpms_addr, const u8 *data, size_t len)
+{
+	struct i2c_client *client = to_i2c_client(tps->dev);
+	int ret;
+	u8 slave_addr;
+	int timeout;
+
+	slave_addr = client->addr;
+	timeout = client->adapter->timeout;
+
+	/*
+	 * binary configuration size is around ~16Kbytes
+	 * which might take some time to finish writing it
+	 */
+	client->adapter->timeout = msecs_to_jiffies(5000);
+	client->addr = bpms_addr;
+
+	ret = regmap_raw_write(tps->regmap, data[0], &data[1], len - 1);
+
+	client->addr = slave_addr;
+	client->adapter->timeout = timeout;
+
+	return ret;
+}
+
+static int
+tps25750_exec_pbms(struct tps6598x *tps, u8 *in_data, size_t in_len)
+{
+	int ret;
+	u8 rc;
+
+	ret = tps6598x_exec_cmd_tmo(tps, "PBMs", in_len, in_data,
+				    sizeof(rc), &rc, 4000, 0);
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
+static int tps25750_abort_patch_process(struct tps6598x *tps)
+{
+	int ret;
+
+	ret = tps6598x_exec_cmd(tps, "PBMe", 0, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret != TPS_MODE_PTCH)
+		dev_err(tps->dev, "failed to switch to \"PTCH\" mode\n");
+
+	return ret;
+}
+
+static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
+{
+	int ret;
+	const struct firmware *fw;
+	const char *firmware_name;
+	struct {
+		u32 fw_size;
+		u8 addr;
+		u8 timeout;
+	} __packed bpms_data;
+	u32 addr;
+	struct device_node *np = tps->dev->of_node;
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
+	ret = of_property_match_string(np, "reg-names", "patch-address");
+	if (ret < 0) {
+		dev_err(tps->dev, "failed to get patch-address %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32_index(np, "reg", ret, &addr);
+	if (ret)
+		return ret;
+
+	if (addr == 0 || (addr >= 0x20 && addr <= 0x23)) {
+		dev_err(tps->dev, "wrong patch address %u\n", addr);
+		return -EINVAL;
+	}
+
+	bpms_data.addr = (u8)addr;
+	bpms_data.fw_size = fw->size;
+	bpms_data.timeout = TPS_BUNDLE_TIMEOUT;
+
+	ret = tps25750_exec_pbms(tps, (u8 *)&bpms_data, sizeof(bpms_data));
+	if (ret)
+		goto release_fw;
+
+	ret = tps25750_write_firmware(tps, bpms_data.addr, fw->data, fw->size);
+	if (ret) {
+		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
+			firmware_name, fw->size);
+		goto release_fw;
+	}
+
+	/*
+	 * A delay of 500us is required after the firmware is written
+	 * based on pg.62 in tps6598x Host Interface Technical
+	 * Reference Manual
+	 * https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
+	 */
+	udelay(500);
+
+release_fw:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int tps25750_complete_patch_process(struct tps6598x *tps)
+{
+	int ret;
+	u8 out_data[40];
+	u8 dummy[2] = { };
+
+	/*
+	 * Without writing something to DATA_IN, this command would
+	 * return an error
+	 */
+	ret = tps6598x_exec_cmd_tmo(tps, "PBMc", sizeof(dummy), dummy,
+				    sizeof(out_data), out_data, 2000, 20);
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
+
+	return 0;
+}
+
+static int tps25750_apply_patch(struct tps6598x *tps)
+{
+	int ret;
+	unsigned long timeout;
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
+	timeout = jiffies + msecs_to_jiffies(1000);
+
+	do {
+		ret = tps6598x_check_mode(tps);
+		if (ret < 0)
+			return ret;
+
+		if (time_is_before_jiffies(timeout))
+			return -ETIMEDOUT;
+
+	} while (ret != TPS_MODE_APP);
+
+	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
+
+	return 0;
+};
+
 static int tps6598x_probe(struct i2c_client *client)
 {
 	irq_handler_t irq_handler = tps6598x_interrupt;
@@ -725,6 +950,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 vid;
 	int ret;
 	u64 mask1;
+	bool is_tps25750;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -737,9 +963,12 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
 
-	ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
-	if (ret < 0 || !vid)
-		return -ENODEV;
+	is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
+	if (!is_tps25750) {
+		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
+		if (ret < 0 || !vid)
+			return -ENODEV;
+	}
 
 	/*
 	 * Checking can the adapter handle SMBus protocol. If it can not, the
@@ -773,9 +1002,15 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (is_tps25750 && ret == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
+
 	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
 	if (ret)
-		return ret;
+		goto err_reset_controller;
 
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret < 0)
@@ -895,19 +1130,29 @@ static int tps6598x_probe(struct i2c_client *client)
 	fwnode_handle_put(fwnode);
 err_clear_mask:
 	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
+err_reset_controller:
+	/* Reset PD controller to remove any applied patch */
+	if (is_tps25750)
+		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 	return ret;
 }
 
 static void tps6598x_remove(struct i2c_client *client)
 {
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	struct device_node *np = client->dev.of_node;
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
 
+	devm_free_irq(tps->dev, client->irq, tps);
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
+
+	/* Reset PD controller to remove any applied patch */
+	if (of_device_is_compatible(np, "ti,tps25750"))
+		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 }
 
 static int __maybe_unused tps6598x_suspend(struct device *dev)
@@ -950,6 +1195,7 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
 static const struct of_device_id tps6598x_of_match[] = {
 	{ .compatible = "ti,tps6598x", },
 	{ .compatible = "apple,cd321x", },
+	{ .compatible = "ti,tps25750", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
-- 
2.34.1

