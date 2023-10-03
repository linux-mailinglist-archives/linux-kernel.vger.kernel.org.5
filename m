Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B957B6DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjJCQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjJCQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4F10F;
        Tue,  3 Oct 2023 09:01:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so1900301a12.3;
        Tue, 03 Oct 2023 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348861; x=1696953661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvhdgIkTe1R2Vj4olIpmq5KtZVzJoyexD8QAbz2uFU8=;
        b=EdM/w+hp7u8MLlIga+ZUXqrlWtxLst4PyzTSwRWZQ7ucVUz18AyyI8XFYMMvGZNuzE
         bCSCWW50EGgUrUT3so2+dcs5lc+wnPklDN7IDC0P4K4RDWqnyuIiDbJE4gNPnUqQt2HB
         I6b8hVkXnoIuWae9S8bg7YaTjsPeFaz4b9dAWYnwsABSEtZWhPrlW6t1+TW1Ry+pfPpg
         j736Xd3bWYZWBLATufBcLyIxG9QY5a8/wdaGEZT64xzvxNeLXUjg5vrOh4+GOr6qyLfP
         Rf63eb8tIgBw8cbch6RhZlocJLdlv2tbTjdP0ybbmQ8aJhgeK8PHyaaRAaKSbOMC21ni
         95PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348861; x=1696953661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvhdgIkTe1R2Vj4olIpmq5KtZVzJoyexD8QAbz2uFU8=;
        b=hT7HTS3b+WiFzWbwiwFsJGTYYMcefoFQMhD4VwnyvBWJHVLnlzOPej6oz+RTNMnMJH
         mtJWuCVYd4hwcWaH9bJ5Q/lPdQW1qIe5CXI9T3d05qBcVxZ91O39yjsk1iSQLsUj7ZDd
         Lf22I03L8okDBJFLu2gcfZhmIGZ8gttWEgHIItzGghhoxCiD3Xihbx6MJAKY0OoD/8/z
         n5c3cRMLxRTpylpU0bTsIdZZUgkJuICujQvaJpwxnbHv95QeUIL7KXdyQgyWsaQS4Bc2
         gOfLVw9x/1hxDkexqgDS4Ho+K4UlttooivIfxDFVNX8PUiVCDwt/JoxOy+acFqADGIaJ
         FJ5w==
X-Gm-Message-State: AOJu0Yy8LsosnvYX7QfUl2i1k+6mq7gdlUWC3eBgfDAU+DcTTQxIm/6p
        YTRXZbaAgGYBeYXOxMiYdQk=
X-Google-Smtp-Source: AGHT+IEuDDewha9A6L8i/nXJHfRUO5LluPChRoWkuWG5t/JqIOAZOMbRKVcfRcvYMk5I0Gc0V65ajA==
X-Received: by 2002:a17:906:530b:b0:9ae:6632:a8cc with SMTP id h11-20020a170906530b00b009ae6632a8ccmr14056152ejo.54.1696348859545;
        Tue, 03 Oct 2023 09:00:59 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:00:59 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 6/9] USB: typec: tps6598x: Add TPS25750 support
Date:   Tue,  3 Oct 2023 11:58:39 -0400
Message-Id: <20231003155842.57313-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155842.57313-1-alkuor@gmail.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
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

Adding tps25750 support, the followings are being taken care of:
- Implement applying patch flow.
- When an EEPROM is present, tps25750 loads the binary configuration from
  EEPROM. Hence, all we need to do is wait for the device to switch to APP
  mode.
- Dead battery flag is cleared after switching tps25750 to APP mode so the
  PD controller becomes fully functional.
- Add port registration as tps25750 doesn't have system configuration register
  to get dr/pr of the current applied binary configuration. Get data role from
  the device node and power role from PD status register.
- tps25750 event registers structure is different than tps6598x's,
  tps25750 has 11 bytes of events which are read at once where
  tps6598x has two event registers of 8 bytes each which are read
  separately. Likewise MASK event registers. Also, not all events
  are supported in both devices. Create a new handler to accommodate
  tps25750 interrupt.
- Enable sleep mode so the device enters sleep state when idling.
- When the current mode is PTCH, enable tps25750 by loading a
  configuration patch that switches the device into APP mode.
- Add resume and suspend pm for tps25750.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v10:
  - Add tps25750 support and enable it by aggregating the following patches from v9:
     0004-USB-typec-tps6598x-Load-TPS25750-patch-bundle.patch
     0005-USB-typec-tps6598x-Check-for-EEPROM-present.patch
     0006-USB-typec-tps6598x-Clear-dead-battery-flag.patch
     0007-USB-typec-tps6598x-Apply-patch-again-after-power-res.patch
     0008-USB-typec-tps6598x-Add-interrupt-support-for-TPS2575.patch
     0010-USB-typec-tps6598x-Add-port-registration-for-tps2575.patch
     0011-USB-typec-tps6598x-Enable-sleep-mode-for-tps25750.patch
Changes in v9:
  - No changes
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 447 +++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h |  17 ++
 2 files changed, 456 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 9c973ffb4c49..892432ad80a3 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
 #include <linux/workqueue.h>
+#include <linux/firmware.h>
 
 #include "tps6598x.h"
 #include "trace.h"
@@ -36,13 +37,33 @@
 #define TPS_REG_STATUS			0x1a
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
+#define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
+#define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
+#define TPS_REG_SLEEP_CONF		0x70
 
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
@@ -89,6 +110,7 @@ struct tipd_data {
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_power_status)(u16 status);
 	void (*trace_status)(u32 status);
+	int (*apply_patch)(struct tps6598x *tps);
 };
 
 struct tps6598x {
@@ -108,6 +130,7 @@ struct tps6598x {
 	enum power_supply_usb_type usb_type;
 
 	int wakeup;
+	u32 status; /* status reg */
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
 
@@ -192,6 +215,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
+static inline int tps6598x_write8(struct tps6598x *tps, u8 reg, u8 val)
+{
+	return tps6598x_block_write(tps, reg, &val, sizeof(u8));
+}
+
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
 	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
@@ -540,6 +568,64 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
+static bool tps6598x_has_role_changed(struct tps6598x *tps, u32 status)
+{
+	status ^= tps->status;
+
+	return status & (TPS_STATUS_PORTROLE | TPS_STATUS_DATAROLE);
+}
+
+static irqreturn_t tps25750_interrupt(int irq, void *data)
+{
+	struct tps6598x *tps = data;
+	u64 event[2] = { };
+	u32 status;
+	int ret;
+
+	mutex_lock(&tps->lock);
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		goto err_unlock;
+	}
+
+	if (!(event[0] | event[1]))
+		goto err_unlock;
+
+	if (!tps6598x_read_status(tps, &status))
+		goto err_clear_ints;
+
+	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+		if (!tps6598x_read_power_status(tps))
+			goto err_clear_ints;
+
+	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+		if (!tps6598x_read_data_status(tps))
+			goto err_clear_ints;
+
+	/*
+	 * data/port roles could be updated independently after
+	 * a plug event. Therefore, we need to check
+	 * for pr/dr status change to set TypeC dr/pr accordingly.
+	 */
+	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	    tps6598x_has_role_changed(tps, status))
+		tps6598x_handle_plug_event(tps, status);
+
+	tps->status = status;
+
+err_clear_ints:
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
+
+err_unlock:
+	mutex_unlock(&tps->lock);
+
+	if (event[0] | event[1])
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -609,13 +695,15 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
-	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
+	ret = match_string(modes, ARRAY_SIZE(modes), mode);
+
+	switch (ret) {
 	case TPS_MODE_APP:
 	case TPS_MODE_PTCH:
-		return 0;
+		return ret;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
-		return 0;
+		return ret;
 	case TPS_MODE_BIST:
 	case TPS_MODE_DISC:
 	default:
@@ -777,6 +865,312 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
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
+	u64 status = 0;
+
+	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
+	if (ret)
+		return ret;
+	/*
+	 * Nothing to be done if the configuration
+	 * is being loaded from EERPOM
+	 */
+	if (status & TPS_BOOT_STATUS_I2C_EEPROM_PRESENT)
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
+		ret = tps6598x_check_mode(tps);
+		if (ret < 0)
+			return ret;
+
+		if (time_is_before_jiffies(timeout))
+			return -ETIMEDOUT;
+
+	} while (ret != TPS_MODE_APP);
+
+	/*
+	 * The dead battery flag may be triggered when the controller
+	 * port is connected to a device that can source power and
+	 * attempts to power up both the controller and the board it is on.
+	 * To restore controller functionality, it is necessary to clear
+	 * this flag
+	 */
+	if (status & TPS_BOOT_STATUS_DEAD_BATTERY_FLAG) {
+		ret = tps6598x_exec_cmd(tps, "DBfg", 0, NULL, 0, NULL);
+		if (ret) {
+			dev_err(tps->dev, "failed to clear dead battery %d\n", ret);
+			return ret;
+		}
+	}
+
+	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
+
+	return 0;
+};
+
+static int tps25750_init(struct tps6598x *tps)
+{
+	int ret;
+
+	ret = tps->data->apply_patch(tps);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_write8(tps, TPS_REG_SLEEP_CONF,
+			      TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED);
+	if (ret)
+		dev_warn(tps->dev,
+			 "%s: failed to enable sleep mode: %d\n",
+			 __func__, ret);
+
+	return 0;
+}
+
+static int
+tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	struct typec_capability typec_cap = { };
+	const char *data_role;
+	u8 pd_status;
+	int ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
+	if (ret) {
+		dev_err(tps->dev, "data-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_data_role(data_role);
+	if (ret < 0) {
+		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
+		return ret;
+	}
+
+	typec_cap.data = ret;
+	typec_cap.revision = USB_TYPEC_REV_1_3;
+	typec_cap.pd_revision = 0x300;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
+	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
+		typec_cap.type = TYPEC_PORT_DRP;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	tps->port = typec_register_port(tps->dev, &typec_cap);
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
+
+	return 0;
+}
+
 static int tps6598x_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
@@ -786,6 +1180,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 vid;
 	int ret;
 	u64 mask1;
+	bool is_tps25750;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -798,9 +1193,12 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
 
-	ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
-	if (ret < 0 || !vid)
-		return -ENODEV;
+	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
+	if (!is_tps25750) {
+		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
+		if (ret < 0 || !vid)
+			return -ENODEV;
+	}
 
 	/*
 	 * Checking can the adapter handle SMBus protocol. If it can not, the
@@ -833,12 +1231,18 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
+	if (is_tps25750 && ret == TPS_MODE_PTCH) {
+		ret = tps25750_init(tps);
+		if (ret)
+			return ret;
+	}
+
 	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
 	if (ret)
-		return ret;
+		goto err_reset_controller;
 
 	if (!tps6598x_read_status(tps, &status)) {
 		ret = -ENODEV;
@@ -917,6 +1321,10 @@ static int tps6598x_probe(struct i2c_client *client)
 	fwnode_handle_put(fwnode);
 err_clear_mask:
 	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
+err_reset_controller:
+	/* Reset PD controller to remove any applied patch */
+	if (is_tps25750)
+		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 	return ret;
 }
 
@@ -927,9 +1335,14 @@ static void tps6598x_remove(struct i2c_client *client)
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
 
+	devm_free_irq(tps->dev, client->irq, tps);
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
+
+	/* Reset PD controller to remove any applied patch */
+	if (device_is_compatible(tps->dev, "ti,tps25750"))
+		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 }
 
 static int __maybe_unused tps6598x_suspend(struct device *dev)
@@ -952,6 +1365,17 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	int ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+		ret = tps25750_init(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
@@ -983,9 +1407,16 @@ static const struct tipd_data tps6598x_data = {
 	.trace_status = trace_tps6598x_status,
 };
 
+static const struct tipd_data tps25750_data = {
+	.irq_handler = tps25750_interrupt,
+	.register_port = tps25750_register_port,
+	.apply_patch = tps25750_apply_patch,
+};
+
 static const struct of_device_id tps6598x_of_match[] = {
 	{ .compatible = "ti,tps6598x", &tps6598x_data},
 	{ .compatible = "apple,cd321x", &cd321x_data},
+	{ .compatible = "ti,tps25750", &tps25750_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 527857549d69..f86b5e96efba 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -199,4 +199,21 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
+/* BOOT STATUS REG*/
+#define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
+#define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
+
+/* PD STATUS REG */
+#define TPS_REG_PD_STATUS_PORT_TYPE_MASK	GENMASK(5, 4)
+#define TPS_PD_STATUS_PORT_TYPE(x) \
+	TPS_FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, x)
+
+#define TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE	0
+#define TPS_PD_STATUS_PORT_TYPE_SINK		1
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
+
+/* SLEEP CONF REG */
+#define TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED	BIT(0)
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

