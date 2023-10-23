Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8987D2D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjJWIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjJWIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:52:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B087D5D;
        Mon, 23 Oct 2023 01:52:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a67b9cd230so127311739f.1;
        Mon, 23 Oct 2023 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051162; x=1698655962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6PnKFBLw6mp7zcpYLblvHmBSIxT+176ytBlVD6d+NI=;
        b=KhcU+ftR6VSRV3aKP1Jc6LWDojJwrSJQ0S+vADPL/4na6bAX8u8QCYjbzUEePQKOva
         TMcBPQSoB3jpLrcMSVtWTSeKGfV3RiHx1Y31wqmRtR4Wh5XaEEeoOm5UfPl/MpfCg2Wd
         v8Y/W3IturaXFWz9NMg7lmaOaFHzPsLJTosI56IGBUYLfDLfOQ5FlkXlT46uK6DUtnKA
         iFGQjIZyX/3zYtrwGZ93rFx+Fkkf26QN2PjxTho66IEnHEdLffaBioCxYyfaYvjHWVbY
         qZGhQaWLONAckD45T9nn/WXXw02GgtiwR1618kXcvR2iKrhsiNhWzMWtePUecM3l6Jhj
         wHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051162; x=1698655962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6PnKFBLw6mp7zcpYLblvHmBSIxT+176ytBlVD6d+NI=;
        b=XzlCI4Aje8QGNxl1vix0B2a4pMSVhXhwG7++LpCgve7IDdl3yR/+Fup5Ww/6oWJOOU
         L6zcG/HMUZwFi4GNWC30/yzMskmbSClcVjxIUkh5BeiLDBHcAX13irB/2SrxaTl29V0+
         uQ7pzuj+Nqz01UVxC3WzU1ACCJfkPDvNQoiy2f12ILAiqEGG6lk0CnhzS2hmlYtLeoCo
         lA5DEX6GJ1JdRF4s2LLElwvlRTlA6e1ugjU617PxeAK/WaLRR53GoAnw8jgfHx3ZdFzG
         5UIL8pbmmRVt796yDRpgVfpN2V7SSsjtVb88d1SNQrB6LCfNvaMhwSwqibf+jrxc3vEO
         uA/A==
X-Gm-Message-State: AOJu0YyM8ccd4aSO1Z4Q87PuafdX5HYA8+DSmAWATD8dlzRk+KGRgd4R
        HsWIu17N//GWhkYSnw2eqxDDanvXvzY=
X-Google-Smtp-Source: AGHT+IGaYtDS6uWA51zMs352BhyfnOqjGD7g8iwWptmhhLk0hm9QkGaAnup6rJLqEi4YTcoJxCuOkA==
X-Received: by 2002:a05:6602:26d4:b0:7a6:7e93:6f86 with SMTP id g20-20020a05660226d400b007a67e936f86mr12160003ioo.10.1698051162442;
        Mon, 23 Oct 2023 01:52:42 -0700 (PDT)
Received: from james-x399.localdomain (71-218-233-104.hlrn.qwest.net. [71.218.233.104])
        by smtp.gmail.com with ESMTPSA id y13-20020a056638014d00b00430245071ddsm2137485jao.176.2023.10.23.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:52:41 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cyttsp5 - improve error handling and remove regmap
Date:   Mon, 23 Oct 2023 02:52:33 -0600
Message-Id: <20231023085234.105572-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor cyttsp5 driver does not use regmap for i2c support, it
would appear this is due to regmap not providing sufficient levels
of control to handle various error conditions that may be present
under some configuration/firmware variants.

To improve reliability lets refactor the cyttsp5 i2c interface to
function more like the vendor driver and implement some of the error
handling retry/recovery techniques present there.

As part of this rather than assuming the device is in bootloader mode
we should first check that the device is in bootloader and only
attempt to launch the app if it actually is in the bootloader.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/input/touchscreen/cyttsp5.c | 260 ++++++++++++++++++----------
 1 file changed, 170 insertions(+), 90 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index db5a885ecd72..334f535dc131 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -18,17 +18,18 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/regmap.h>
+#include <linux/of_device.h>
 #include <asm/unaligned.h>
 
 #define CYTTSP5_NAME				"cyttsp5"
 #define CY_I2C_DATA_SIZE			(2 * 256)
 #define HID_VERSION				0x0100
 #define CY_MAX_INPUT				512
+#define CY_PIP_1P7_EMPTY_BUF			0xFF00
 #define CYTTSP5_PREALLOCATED_CMD_BUFFER		32
 #define CY_BITS_PER_BTN				1
+#define CY_CORE_STARTUP_RETRY_COUNT		10
 #define CY_NUM_BTN_EVENT_ID			GENMASK(CY_BITS_PER_BTN - 1, 0)
 
 #define MAX_AREA				255
@@ -67,6 +68,7 @@
 #define HID_BTN_REPORT_ID			0x3
 #define HID_APP_RESPONSE_REPORT_ID		0x1F
 #define HID_APP_OUTPUT_REPORT_ID		0x2F
+#define HID_BL_REPORT_ID			0xFF
 #define HID_BL_RESPONSE_REPORT_ID		0x30
 #define HID_BL_OUTPUT_REPORT_ID			0x40
 #define HID_RESPONSE_REPORT_ID			0xF0
@@ -205,7 +207,6 @@ struct cyttsp5 {
 	struct input_dev *input;
 	char phys[NAME_MAX];
 	int num_prv_rec;
-	struct regmap *regmap;
 	struct touchscreen_properties prop;
 	struct regulator *vdd;
 };
@@ -218,49 +219,65 @@ struct cyttsp5 {
  */
 static int cyttsp5_read(struct cyttsp5 *ts, u8 *buf, u32 max)
 {
-	int error;
+	struct i2c_client *client = to_i2c_client(ts->dev);
+	struct i2c_msg msgs[2];
+	u8 msg_count = 1;
+	int rc;
 	u32 size;
-	u8 temp[2];
 
-	/* Read the frame to retrieve the size */
-	error = regmap_bulk_read(ts->regmap, HID_INPUT_REG, temp, sizeof(temp));
-	if (error)
-		return error;
+	if (!buf)
+		return -EINVAL;
 
-	size = get_unaligned_le16(temp);
-	if (!size || size == 2)
+	msgs[0].addr = client->addr;
+	msgs[0].flags = (client->flags & I2C_M_TEN) | I2C_M_RD;
+	msgs[0].len = 2;
+	msgs[0].buf = buf;
+	rc = i2c_transfer(client->adapter, msgs, msg_count);
+	if (rc < 0 || rc != msg_count)
+		return (rc < 0) ? rc : -EIO;
+
+	size = get_unaligned_le16(&buf[0]);
+	/*
+	 * Before PIP 1.7, empty buffer is 0x0002
+	 * From PIP 1.7, empty buffer is 0xFFXX
+	 */
+	if (!size || size == 2 || size >= CY_PIP_1P7_EMPTY_BUF)
 		return 0;
 
 	if (size > max)
 		return -EINVAL;
 
-	/* Get the real value */
-	return regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, size);
+	rc = i2c_master_recv(client, buf, size);
+
+	return (rc < 0) ? rc : rc != (int)size ? -EIO : 0;
 }
 
 static int cyttsp5_write(struct cyttsp5 *ts, unsigned int reg, u8 *data,
 			 size_t size)
 {
-	u8 cmd[HID_OUTPUT_MAX_CMD_SIZE];
+	u8 cmd[HID_OUTPUT_MAX_CMD_SIZE + 2];
+	struct i2c_client *client = to_i2c_client(ts->dev);
+	struct i2c_msg msgs[2];
+	u8 msg_count = 1;
+	int rc;
 
-	if (size + 1 > HID_OUTPUT_MAX_CMD_SIZE)
+	if (size > HID_OUTPUT_MAX_CMD_SIZE + 2)
 		return -E2BIG;
 
-	/* High bytes of register address needed as first byte of cmd */
-	cmd[0] = (reg >> 8) & 0xFF;
-
 	/* Copy the rest of the data */
 	if (data)
-		memcpy(&cmd[1], data, size);
+		memcpy(&cmd[0], data, size);
 
-	/*
-	 * The hardware wants to receive a frame with the address register
-	 * contained in the first two bytes. As the regmap_write function
-	 * add the register adresse in the frame, we use the low byte as
-	 * first frame byte for the address register and the first
-	 * data byte is the high register + left of the cmd to send
-	 */
-	return regmap_bulk_write(ts->regmap, reg & 0xFF, cmd, size + 1);
+	msgs[0].addr = client->addr;
+	msgs[0].flags = client->flags & I2C_M_TEN;
+	msgs[0].len = size;
+	msgs[0].buf = cmd;
+	rc = i2c_transfer(client->adapter, msgs, msg_count);
+
+	if (rc < 0 || rc != msg_count)
+		return (rc < 0) ? rc : -EIO;
+
+	return 0;
 }
 
 static void cyttsp5_get_touch_axis(int *axis, int size, int max, u8 *xy_data,
@@ -535,22 +552,29 @@ static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
 	scd->len_x = get_unaligned_le16(&scd_dev->len_x);
 	scd->len_y = get_unaligned_le16(&scd_dev->len_y);
 
+	if (scd_dev->max_num_of_tch_per_refresh_cycle == 0)
+		return -EINVAL;
+
 	return 0;
 }
 
 static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 {
 	int rc;
-	u8 cmd[HID_OUTPUT_GET_SYSINFO_SIZE];
+	u8 cmd[HID_OUTPUT_GET_SYSINFO_SIZE + 2];
+
+	/* Set Output register */
+	memcpy(&cmd[0], &ts->hid_desc.output_register,
+			sizeof(ts->hid_desc.output_register));
 
 	/* HI bytes of Output register address */
-	put_unaligned_le16(HID_OUTPUT_GET_SYSINFO_SIZE, cmd);
-	cmd[2] = HID_APP_OUTPUT_REPORT_ID;
-	cmd[3] = 0x0; /* Reserved */
-	cmd[4] = HID_OUTPUT_GET_SYSINFO;
+	put_unaligned_le16(HID_OUTPUT_GET_SYSINFO_SIZE, &cmd[2]);
+	cmd[4] = HID_APP_OUTPUT_REPORT_ID;
+	cmd[5] = 0x0; /* Reserved */
+	cmd[6] = HID_OUTPUT_GET_SYSINFO;
 
 	rc = cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
-			   HID_OUTPUT_GET_SYSINFO_SIZE);
+			   HID_OUTPUT_GET_SYSINFO_SIZE + 2);
 	if (rc) {
 		dev_err(ts->dev, "Failed to write command %d", rc);
 		return rc;
@@ -559,7 +583,7 @@ static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
 						msecs_to_jiffies(CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT_MS));
 	if (rc <= 0) {
-		dev_err(ts->dev, "HID output cmd execution timed out\n");
+		dev_err(ts->dev, "HID output get sysinfo cmd execution timed out\n");
 		rc = -ETIMEDOUT;
 		return rc;
 	}
@@ -610,21 +634,25 @@ static int cyttsp5_power_control(struct cyttsp5 *ts, bool on)
 static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
 {
 	int rc;
-	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP_SIZE];
+	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP_SIZE + 2];
 	u16 crc;
 
-	put_unaligned_le16(HID_OUTPUT_BL_LAUNCH_APP_SIZE, cmd);
-	cmd[2] = HID_BL_OUTPUT_REPORT_ID;
-	cmd[3] = 0x0; /* Reserved */
-	cmd[4] = HID_OUTPUT_BL_SOP;
-	cmd[5] = HID_OUTPUT_BL_LAUNCH_APP;
-	put_unaligned_le16(0x00, &cmd[6]);
-	crc = crc_itu_t(0xFFFF, &cmd[4], 4);
-	put_unaligned_le16(crc, &cmd[8]);
-	cmd[10] = HID_OUTPUT_BL_EOP;
+	/* Set Output register */
+	memcpy(&cmd[0], &ts->hid_desc.output_register,
+			sizeof(ts->hid_desc.output_register));
+
+	put_unaligned_le16(HID_OUTPUT_BL_LAUNCH_APP_SIZE, &cmd[2]);
+	cmd[4] = HID_BL_OUTPUT_REPORT_ID;
+	cmd[5] = 0x0; /* Reserved */
+	cmd[6] = HID_OUTPUT_BL_SOP;
+	cmd[7] = HID_OUTPUT_BL_LAUNCH_APP;
+	put_unaligned_le16(0x00, &cmd[8]);
+	crc = crc_itu_t(0xFFFF, &cmd[6], 4);
+	put_unaligned_le16(crc, &cmd[10]);
+	cmd[12] = HID_OUTPUT_BL_EOP;
 
 	rc = cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
-			   HID_OUTPUT_BL_LAUNCH_APP_SIZE);
+			   HID_OUTPUT_BL_LAUNCH_APP_SIZE + 2);
 	if (rc) {
 		dev_err(ts->dev, "Failed to write command %d", rc);
 		return rc;
@@ -633,7 +661,7 @@ static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
 	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
 				msecs_to_jiffies(CY_HID_OUTPUT_TIMEOUT_MS));
 	if (rc <= 0) {
-		dev_err(ts->dev, "HID output cmd execution timed out\n");
+		dev_err(ts->dev, "HID output bl launch app cmd execution timed out\n");
 		rc = -ETIMEDOUT;
 		return rc;
 	}
@@ -651,9 +679,13 @@ static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
 				      struct cyttsp5_hid_desc *desc)
 {
 	struct device *dev = ts->dev;
+	u8 cmd[2] = { 0 };
 	int rc;
+	unsigned int reg = HID_DESC_REG;
+
+	put_unaligned_le16(HID_DESC_REG, cmd);
 
-	rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
+	rc = cyttsp5_write(ts, HID_DESC_REG, cmd, 2);
 	if (rc) {
 		dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
 		return rc;
@@ -708,7 +740,8 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
 	if (size == 0) {
 		/* reset */
 		report_id = 0;
-		size = 2;
+	} else if (size == 2 || size >= CY_PIP_1P7_EMPTY_BUF) {
+		return IRQ_HANDLED;
 	} else {
 		report_id = ts->input_buf[2];
 	}
@@ -733,19 +766,38 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static int cyttsp5_deassert_read(struct cyttsp5 *ts, u8 *buf, int size)
+{
+	struct i2c_client *client = to_i2c_client(ts->dev);
+	int rc;
+
+	if (!buf || !size || size > CY_I2C_DATA_SIZE)
+		return -EINVAL;
+
+	rc = i2c_master_recv(client, buf, size);
+
+	return (rc < 0) ? rc : rc != size ? -EIO : 0;
+}
+
 static int cyttsp5_deassert_int(struct cyttsp5 *ts)
 {
 	u16 size;
-	u8 buf[2];
+	u8 retry = 3;
 	int error;
 
-	error = regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, sizeof(buf));
-	if (error < 0)
-		return error;
+	do {
+		error = cyttsp5_deassert_read(ts, ts->input_buf, 2);
+		if (error < 0)
+			return error;
 
-	size = get_unaligned_le16(&buf[0]);
-	if (size == 2 || size == 0)
-		return 0;
+		size = get_unaligned_le16(&ts->input_buf[0]);
+		if (size == 2 || size == 0 || size >= CY_PIP_1P7_EMPTY_BUF)
+			return 0;
+
+		error = cyttsp5_deassert_read(ts, ts->input_buf, size);
+		if (error < 0)
+			return error;
+	} while (retry--);
 
 	return -EINVAL;
 }
@@ -774,39 +826,65 @@ static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
 
 static int cyttsp5_startup(struct cyttsp5 *ts)
 {
+	int retry = CY_CORE_STARTUP_RETRY_COUNT;
 	int error;
 
+reset:
 	error = cyttsp5_deassert_int(ts);
 	if (error) {
 		dev_err(ts->dev, "Error on deassert int r=%d\n", error);
-		return -ENODEV;
+	}
+
+	error = cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
+	if (error < 0) {
+		dev_err(ts->dev, "Error on getting HID descriptor r=%d\n", error);
+		if (retry--)
+			goto reset;
+		return error;
 	}
 
 	/*
 	 * Launch the application as the device starts in bootloader mode
 	 * because of a power-on-reset
 	 */
-	error = cyttsp5_hid_output_bl_launch_app(ts);
-	if (error < 0) {
-		dev_err(ts->dev, "Error on launch app r=%d\n", error);
-		return error;
-	}
+	if (ts->hid_desc.packet_id == HID_BL_REPORT_ID) {
+		error = cyttsp5_hid_output_bl_launch_app(ts);
+		if (error < 0) {
+			dev_err(ts->dev, "Error on launch app r=%d\n", error);
+			if (retry--)
+				goto reset;
+			return error;
+		}
 
-	error = cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
-	if (error < 0) {
-		dev_err(ts->dev, "Error on getting HID descriptor r=%d\n", error);
-		return error;
+		error = cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
+		if (error < 0) {
+			dev_err(ts->dev, "Error on getting HID descriptor r=%d\n", error);
+			if (retry--)
+				goto reset;
+			return error;
+		}
+
+		if (ts->hid_desc.packet_id == HID_BL_REPORT_ID) {
+			dev_err(ts->dev, "Error on launch app still in bootloader\n");
+			if (retry--)
+				goto reset;
+			return -EPROTO;
+		}
 	}
 
 	error = cyttsp5_fill_all_touch(ts);
 	if (error < 0) {
 		dev_err(ts->dev, "Error on report descriptor r=%d\n", error);
+		if (retry--)
+			goto reset;
 		return error;
 	}
 
 	error = cyttsp5_hid_output_get_sysinfo(ts);
 	if (error) {
 		dev_err(ts->dev, "Error on getting sysinfo r=%d\n", error);
+		if (retry--)
+			goto reset;
 		return error;
 	}
 
@@ -820,8 +898,7 @@ static void cyttsp5_cleanup(void *data)
 	regulator_disable(ts->vdd);
 }
 
-static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
-			 const char *name)
+static struct cyttsp5 *cyttsp5_probe(struct device *dev, int irq, const char *name)
 {
 	struct cyttsp5 *ts;
 	struct cyttsp5_sysinfo *si;
@@ -829,10 +906,9 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/* Initialize device info */
-	ts->regmap = regmap;
 	ts->dev = dev;
 	si = &ts->sysinfo;
 	dev_set_drvdata(dev, ts);
@@ -843,21 +919,21 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	ts->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(ts->vdd)) {
 		error = PTR_ERR(ts->vdd);
-		return error;
+		return ERR_PTR(error);
 	}
 
 	error = devm_add_action_or_reset(dev, cyttsp5_cleanup, ts);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 
 	error = regulator_enable(ts->vdd);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 
 	ts->input = devm_input_allocate_device(dev);
 	if (!ts->input) {
 		dev_err(dev, "Error, failed to allocate input device\n");
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ts->input->name = "cyttsp5";
@@ -870,7 +946,7 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
 		dev_err(dev, "Failed to request reset gpio, error %d\n", error);
-		return error;
+		return ERR_PTR(error);
 	}
 	gpiod_set_value_cansleep(ts->reset_gpio, 0);
 
@@ -878,22 +954,22 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	msleep(20);
 
 	error = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
-					  IRQF_ONESHOT, name, ts);
+					  IRQF_TRIGGER_LOW | IRQF_ONESHOT, name, ts);
 	if (error) {
 		dev_err(dev, "unable to request IRQ\n");
-		return error;
+		return ERR_PTR(error);
 	}
 
 	error = cyttsp5_startup(ts);
 	if (error) {
 		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
-		return error;
+		return ERR_PTR(error);
 	}
 
 	error = cyttsp5_parse_dt_key_code(dev);
 	if (error < 0) {
 		dev_err(ts->dev, "Error while parsing dts %d\n", error);
-		return error;
+		return ERR_PTR(error);
 	}
 
 	touchscreen_parse_properties(ts->input, true, &ts->prop);
@@ -902,25 +978,29 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	for (i = 0; i < si->num_btns; i++)
 		__set_bit(si->key_code[i], ts->input->keybit);
 
-	return cyttsp5_setup_input_device(dev);
+	error = cyttsp5_setup_input_device(dev);
+	if (error < 0)
+		return ERR_PTR(error);
+
+	return ts;
 }
 
 static int cyttsp5_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
-	static const struct regmap_config config = {
-		.reg_bits = 8,
-		.val_bits = 8,
-	};
+	struct cyttsp5 *ts;
 
-	regmap = devm_regmap_init_i2c(client, &config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "regmap allocation failed: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C functionality not Supported\n");
+		return -EIO;
 	}
 
-	return cyttsp5_probe(&client->dev, regmap, client->irq, client->name);
+	ts = cyttsp5_probe(&client->dev, client->irq, client->name);
+
+	if (IS_ERR(ts))
+		return PTR_ERR(ts);
+
+	i2c_set_clientdata(client, ts);
+	return 0;
 }
 
 static const struct of_device_id cyttsp5_of_match[] = {
-- 
2.34.1

