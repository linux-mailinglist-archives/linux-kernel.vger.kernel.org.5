Return-Path: <linux-kernel+bounces-42421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0684012E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095BD284A21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95855E7F;
	Mon, 29 Jan 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwUVLQa4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DB54FA6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519805; cv=none; b=fvdi+GLmyuPOanNZUZGqsjbyXwI3+K99ZhIFbGk6rWrmZKcmBDpk+BNZ/KNjJ05pxmlJ7p1Xvpfo08Ayh8UnIb/Ui2D4VjQH/qXDirCuIUGieptcTr25IETSVVKVV1uJFWzCzgfdvjE3LamwfhKq6WL94UqH+eHe65W+wJC3UJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519805; c=relaxed/simple;
	bh=M06QpW/4nqNe19u123v8P0kDLlnePCeK4hvPnSZWTNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3mCXZM1uV9kOCSEYpysqRHSeQOjwY4fsPUqv3UM2kU3cHKk94gpqNNI/vltCQMg1InVcs8c38zbFspN6xvm7HRXX5ii56G+Y/t6UkMLX6zv36RvYvlWVoSokt5J/l+J3clAOAheicEFsigeDQf2Z7I/u5D/Lwiuq/Pv6yvxFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwUVLQa4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so2181848f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706519801; x=1707124601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1XUw0J1nPslc3sOz0i4qL6kBUjCizMaDn9ERB+vRCQ=;
        b=jwUVLQa4WCJXR+9rcrqI8r1dHioJTedF1Uc8QJ8ThzabVWJ5gtU9JNKSYzik5rVPhU
         Mhbjqt61ZMBu/wPtY0j/AkSmYkcUtOsLRqrpoHI5yVCYoYMal+z75xpIKyMHJ+XKPnDd
         NbL3QIPutnO3F8rF/N/lO9QhCACNu4m6IGOOZW+FKwaYgBc7wwFRGghMdPAkp3amP2dB
         nbCyjniU2CuogTAPHCHno4XOl5T0KFdhdzvxX9N8NdO+DUHO6+oSEYweMLd1JE1nUkW0
         7cRrioYuhZJC2AoTNYc0n6aJnBM84mkc+dbc17JYMdcB/JpPRcEtK8lVURB65O07JCRz
         YR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519801; x=1707124601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1XUw0J1nPslc3sOz0i4qL6kBUjCizMaDn9ERB+vRCQ=;
        b=MD9G4jJ9qpJfoBzi14w/+nVCD9oRLmXKvtvkA+0cey8ks+q4YE4ZFknmnjycp1YtOB
         rhmqqP/G5pUGwFTPynTPkH35B1WsRwVV4EQdHZrLl/KtycJhX35Iw9s4hLlVQ8FPnyjy
         DLwApBYwWs1azGuumIuU1sdtYacAq1MruhD2JJDjmXbJ7y5klmHQvk86/s0c7SQ07dNC
         aAAE8ffJmmH2o6gy1Y6TdnIS4SXRAyuAvc9olXRJX1lz53WBfNkeB7rVGckTCUqTORiH
         pM99XSfsT+KvZ0Xxyc9giXCnK918ozSbc2LmCtTbjTH8DcK8OoZUnnPAw4GDPrmSDRgt
         x21A==
X-Gm-Message-State: AOJu0YypsJVoZGOclmt3ROy/IhA5hKTG/JkCFpjTr5IQx23r0FRgSwcF
	R4M1d24p935bC60Vth4+rdySuPADJirBHi4NZR9fTN1tRIV0iAPHYUPZT8POoVw=
X-Google-Smtp-Source: AGHT+IHwwzylLbCPMSQykBL7DVnQLEqJ/PTvNQGCUz4EvuhknBOtPpZbEsu3Rd/lfXxXe/IGo4bBBQ==
X-Received: by 2002:a05:6000:70a:b0:33a:eb4e:8be7 with SMTP id bs10-20020a056000070a00b0033aeb4e8be7mr2546547wrb.15.1706519801312;
        Mon, 29 Jan 2024 01:16:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b7-20020adfee87000000b0033aebf727b2sm2818198wro.60.2024.01.29.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:16:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 29 Jan 2024 10:16:36 +0100
Subject: [PATCH v15 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-topic-goodix-berlin-upstream-initial-v15-2-6f7d096c0a0a@linaro.org>
References: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
In-Reply-To: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=24005;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M06QpW/4nqNe19u123v8P0kDLlnePCeK4hvPnSZWTNE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlt2z1EYdJlZ7JUsyKFnlGyvYkKIxlcLxqrwRQcwHo
 K5bNndOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbds9QAKCRB33NvayMhJ0TzhD/
 9GoKtkS1yx6u+in0925EGbONxZoTRm0mIKshRjrb++8B2agynZ32/gobUmsdxC4K989WKCl6HL9gL6
 4RBOr6MTJSXcSjfW2Q8vcFhlx5NmnTfT7xdxIZxUAHIQgqLncHE31gsvOb9H329wlI52Nn3sGHWR0k
 BD655il0VLnIGyEaZ/vroOWLutIz8Co5T8yWVg+arHmhz2eNmX746lUQIkUVIWUs1uBTCI2/5od1e0
 Y1+sJv+H4fHXL+wmJl2FCK4Fs4YFEeXiupJkUAxfden4RXnofnKmVUqw9L2W/i8HinS+eiXafXGu3E
 qn20BriIwSFtMsLX/aLoKPPXfUlgtzr4giRu0NWKbzgfV2ingCr8XiAnIEAinFzPeJDxUFDe9YrrG8
 JGthDUtox4S57G9HORWnlPCLWuKKf9QWp9DN3lyF1NQBuiEZReCJ/WAWUCUs+XVKgI414YmgqMeVqW
 pHSlJeH9R4Im8rV0pnZQGcQeWWIMou52ByfNTxU99s2qazVxkfHbeClnMeX/iAFD7ef+U6wDlWRoi7
 9ZZZRGVsp/vs1qaJHGFlofKxsZodYjczO75oEG7DeIemoF+ZQqS7vwreUm3Vazry8DcEdGwibE6NQg
 JxyTRcgQKS+Xq77miqB7ySG4PS0dfta0x3NQX77dujLXXQwW42SVf0QFoQNA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add initial support for the new Goodix "Berlin" touchscreen ICs.

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig              |   3 +
 drivers/input/touchscreen/Makefile             |   1 +
 drivers/input/touchscreen/goodix_berlin.h      |  24 +
 drivers/input/touchscreen/goodix_berlin_core.c | 755 +++++++++++++++++++++++++
 4 files changed, 783 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e3e2324547b9..950da599ae1a 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -416,6 +416,9 @@ config TOUCHSCREEN_GOODIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix.
 
+config TOUCHSCREEN_GOODIX_BERLIN_CORE
+	tristate
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 62bd24f3ac8e..2e2f3e70cd2c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
new file mode 100644
index 000000000000..1fd77eb69c9a
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Goodix Touchscreen Driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_berlin_berlin driver.
+ */
+
+#ifndef __GOODIX_BERLIN_H_
+#define __GOODIX_BERLIN_H_
+
+#include <linux/pm.h>
+
+struct device;
+struct input_id;
+struct regmap;
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap);
+
+extern const struct dev_pm_ops goodix_berlin_pm_ops;
+
+#endif
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
new file mode 100644
index 000000000000..e7b41a926ef8
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix "Berlin" Touchscreen IC driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ *
+ * This driver is distinct from goodix.c since hardware interface
+ * is different enough to require a new driver.
+ * None of the register address or data structure are close enough
+ * to the previous generations.
+ *
+ * Currently the driver only handles Multitouch events with already
+ * programmed firmware and "config" for "Revision D" Berlin IC.
+ *
+ * Support is missing for:
+ * - ESD Management
+ * - Firmware update/flashing
+ * - "Config" update/flashing
+ * - Stylus Events
+ * - Gesture Events
+ * - Support for older revisions (A & B)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+#include <asm/unaligned.h>
+
+#include "goodix_berlin.h"
+
+#define GOODIX_BERLIN_MAX_TOUCH			10
+
+#define GOODIX_BERLIN_NORMAL_RESET_DELAY_MS	100
+
+#define GOODIX_BERLIN_TOUCH_EVENT		BIT(7)
+#define GOODIX_BERLIN_REQUEST_EVENT		BIT(6)
+#define GOODIX_BERLIN_TOUCH_COUNT_MASK		GENMASK(3, 0)
+
+#define GOODIX_BERLIN_REQUEST_CODE_RESET	3
+
+#define GOODIX_BERLIN_POINT_TYPE_MASK		GENMASK(3, 0)
+#define GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER	1
+#define GOODIX_BERLIN_POINT_TYPE_STYLUS		3
+
+#define GOODIX_BERLIN_TOUCH_ID_MASK		GENMASK(7, 4)
+
+#define GOODIX_BERLIN_DEV_CONFIRM_VAL		0xAA
+#define GOODIX_BERLIN_BOOTOPTION_ADDR		0x10000
+#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR	0x10014
+
+#define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
+#define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
+
+#define GOODIX_BERLIN_CHECKSUM_SIZE		sizeof(u16)
+
+struct goodix_berlin_fw_version {
+	u8 rom_pid[6];
+	u8 rom_vid[3];
+	u8 rom_vid_reserved;
+	u8 patch_pid[8];
+	u8 patch_vid[4];
+	u8 patch_vid_reserved;
+	u8 sensor_id;
+	u8 reserved[2];
+	__le16 checksum;
+};
+
+struct goodix_berlin_ic_info_version {
+	u8 info_customer_id;
+	u8 info_version_id;
+	u8 ic_die_id;
+	u8 ic_version_id;
+	__le32 config_id;
+	u8 config_version;
+	u8 frame_data_customer_id;
+	u8 frame_data_version_id;
+	u8 touch_data_customer_id;
+	u8 touch_data_version_id;
+	u8 reserved[3];
+} __packed;
+
+struct goodix_berlin_ic_info_feature {
+	__le16 freqhop_feature;
+	__le16 calibration_feature;
+	__le16 gesture_feature;
+	__le16 side_touch_feature;
+	__le16 stylus_feature;
+} __packed;
+
+struct goodix_berlin_ic_info_misc {
+	__le32 cmd_addr;
+	__le16 cmd_max_len;
+	__le32 cmd_reply_addr;
+	__le16 cmd_reply_len;
+	__le32 fw_state_addr;
+	__le16 fw_state_len;
+	__le32 fw_buffer_addr;
+	__le16 fw_buffer_max_len;
+	__le32 frame_data_addr;
+	__le16 frame_data_head_len;
+	__le16 fw_attr_len;
+	__le16 fw_log_len;
+	u8 pack_max_num;
+	u8 pack_compress_version;
+	__le16 stylus_struct_len;
+	__le16 mutual_struct_len;
+	__le16 self_struct_len;
+	__le16 noise_struct_len;
+	__le32 touch_data_addr;
+	__le16 touch_data_head_len;
+	__le16 point_struct_len;
+	__le16 reserved1;
+	__le16 reserved2;
+	__le32 mutual_rawdata_addr;
+	__le32 mutual_diffdata_addr;
+	__le32 mutual_refdata_addr;
+	__le32 self_rawdata_addr;
+	__le32 self_diffdata_addr;
+	__le32 self_refdata_addr;
+	__le32 iq_rawdata_addr;
+	__le32 iq_refdata_addr;
+	__le32 im_rawdata_addr;
+	__le16 im_readata_len;
+	__le32 noise_rawdata_addr;
+	__le16 noise_rawdata_len;
+	__le32 stylus_rawdata_addr;
+	__le16 stylus_rawdata_len;
+	__le32 noise_data_addr;
+	__le32 esd_addr;
+} __packed;
+
+struct goodix_berlin_touch {
+	u8 status;
+	u8 reserved;
+	__le16 x;
+	__le16 y;
+	__le16 w;
+};
+#define GOODIX_BERLIN_TOUCH_SIZE	sizeof(struct goodix_berlin_touch)
+
+struct goodix_berlin_header {
+	u8 status;
+	u8 reserved1;
+	u8 request_type;
+	u8 reserved2[3];
+	__le16 checksum;
+};
+#define GOODIX_BERLIN_HEADER_SIZE	sizeof(struct goodix_berlin_header)
+
+struct goodix_berlin_event {
+	struct goodix_berlin_header hdr;
+	/* The data below is u16/__le16 aligned */
+	u8 data[GOODIX_BERLIN_TOUCH_SIZE * GOODIX_BERLIN_MAX_TOUCH +
+		GOODIX_BERLIN_CHECKSUM_SIZE];
+};
+
+struct goodix_berlin_core {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *avdd;
+	struct regulator *iovdd;
+	struct gpio_desc *reset_gpio;
+	struct touchscreen_properties props;
+	struct goodix_berlin_fw_version fw_version;
+	struct input_dev *input_dev;
+	int irq;
+
+	/* Runtime parameters extracted from IC_INFO buffer  */
+	u32 touch_data_addr;
+
+	struct goodix_berlin_event event;
+};
+
+static bool goodix_berlin_checksum_valid(const u8 *data, int size)
+{
+	u32 cal_checksum = 0;
+	u16 r_checksum;
+	int i;
+
+	if (size < GOODIX_BERLIN_CHECKSUM_SIZE)
+		return false;
+
+	for (i = 0; i < size - GOODIX_BERLIN_CHECKSUM_SIZE; i++)
+		cal_checksum += data[i];
+
+	r_checksum = get_unaligned_le16(&data[i]);
+
+	return (u16)cal_checksum == r_checksum;
+}
+
+static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
+					const u8 *data, int size)
+{
+	int i;
+
+	/*
+	 * If the device is missing or doesn't respond the buffer
+	 * could be filled with bus default line state, 0x00 or 0xff,
+	 * so declare success the first time we encounter neither.
+	 */
+	for (i = 0; i < size; i++)
+		if (data[i] > 0 && data[i] < 0xff)
+			return false;
+
+	return true;
+}
+
+static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
+{
+	u8 tx_buf[8], rx_buf[8];
+	int retry = 3;
+	int error;
+
+	memset(tx_buf, GOODIX_BERLIN_DEV_CONFIRM_VAL, sizeof(tx_buf));
+	while (retry--) {
+		error = regmap_raw_write(cd->regmap,
+					 GOODIX_BERLIN_BOOTOPTION_ADDR,
+					 tx_buf, sizeof(tx_buf));
+		if (error)
+			return error;
+
+		error = regmap_raw_read(cd->regmap,
+					GOODIX_BERLIN_BOOTOPTION_ADDR,
+					rx_buf, sizeof(rx_buf));
+		if (error)
+			return error;
+
+		if (!memcmp(tx_buf, rx_buf, sizeof(tx_buf)))
+			return 0;
+
+		usleep_range(5000, 5100);
+	}
+
+	dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n",
+		(int)sizeof(rx_buf), rx_buf);
+
+	return -EINVAL;
+}
+
+static int goodix_berlin_power_on(struct goodix_berlin_core *cd)
+{
+	int error;
+
+	error = regulator_enable(cd->iovdd);
+	if (error) {
+		dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
+		return error;
+	}
+
+	/* Vendor waits 3ms for IOVDD to settle */
+	usleep_range(3000, 3100);
+
+	error = regulator_enable(cd->avdd);
+	if (error) {
+		dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
+		goto err_iovdd_disable;
+	}
+
+	/* Vendor waits 15ms for IOVDD to settle */
+	usleep_range(15000, 15100);
+
+	gpiod_set_value_cansleep(cd->reset_gpio, 0);
+
+	/* Vendor waits 4ms for Firmware to initialize */
+	usleep_range(4000, 4100);
+
+	error = goodix_berlin_dev_confirm(cd);
+	if (error)
+		goto err_dev_reset;
+
+	/* Vendor waits 100ms for Firmware to fully boot */
+	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
+
+	return 0;
+
+err_dev_reset:
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
+	regulator_disable(cd->avdd);
+err_iovdd_disable:
+	regulator_disable(cd->iovdd);
+	return error;
+}
+
+static void goodix_berlin_power_off(struct goodix_berlin_core *cd)
+{
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
+	regulator_disable(cd->avdd);
+	regulator_disable(cd->iovdd);
+}
+
+static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
+{
+	int error;
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR,
+				&cd->fw_version, sizeof(cd->fw_version));
+	if (error) {
+		dev_err(cd->dev, "error reading fw version, %d\n", error);
+		return error;
+	}
+
+	if (!goodix_berlin_checksum_valid((u8 *)&cd->fw_version,
+					  sizeof(cd->fw_version))) {
+		dev_err(cd->dev, "invalid fw version: checksum error\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Only extract necessary data for runtime */
+static int goodix_berlin_parse_ic_info(struct goodix_berlin_core *cd,
+				       const u8 *data, u16 length)
+{
+	struct goodix_berlin_ic_info_misc *misc;
+	unsigned int offset = 0;
+
+	offset += sizeof(__le16); /* length */
+	offset += sizeof(struct goodix_berlin_ic_info_version);
+	offset += sizeof(struct goodix_berlin_ic_info_feature);
+
+	/* IC_INFO Parameters, variable width structure */
+	offset += 4 * sizeof(u8); /* drv_num, sen_num, button_num, force_num */
+	if (offset >= length)
+		goto invalid_offset;
+
+#define ADVANCE_LE16_PARAMS()				\
+	do {						\
+		u8 param_num = data[offset++];		\
+		offset += param_num * sizeof(__le16);	\
+		if (offset >= length)			\
+			goto invalid_offset;		\
+	} while (0)
+	ADVANCE_LE16_PARAMS(); /* active_scan_rate_num */
+	ADVANCE_LE16_PARAMS(); /* mutual_freq_num*/
+	ADVANCE_LE16_PARAMS(); /* self_tx_freq_num */
+	ADVANCE_LE16_PARAMS(); /* self_rx_freq_num */
+	ADVANCE_LE16_PARAMS(); /* stylus_freq_num */
+#undef ADVANCE_LE16_PARAMS
+
+	misc = (struct goodix_berlin_ic_info_misc *)&data[offset];
+	cd->touch_data_addr = le32_to_cpu(misc->touch_data_addr);
+
+	return 0;
+
+invalid_offset:
+	dev_err(cd->dev, "ic_info length is invalid (offset %d length %d)\n",
+		offset, length);
+	return -EINVAL;
+}
+
+static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
+{
+	u8 *afe_data __free(kfree) = NULL;
+	__le16 length_raw;
+	u16 length;
+	int error;
+
+	afe_data = kzalloc(GOODIX_BERLIN_IC_INFO_MAX_LEN, GFP_KERNEL);
+	if (!afe_data)
+		return -ENOMEM;
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
+				&length_raw, sizeof(length_raw));
+	if (error) {
+		dev_err(cd->dev, "failed get ic info length, %d\n", error);
+		return error;
+	}
+
+	length = le16_to_cpu(length_raw);
+	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
+		dev_err(cd->dev, "invalid ic info length %d\n", length);
+		return -EINVAL;
+	}
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
+				afe_data, length);
+	if (error) {
+		dev_err(cd->dev, "failed get ic info data, %d\n", error);
+		return error;
+	}
+
+	/* check whether the data is valid (ex. bus default values) */
+	if (goodix_berlin_is_dummy_data(cd, afe_data, length)) {
+		dev_err(cd->dev, "fw info data invalid\n");
+		return -EINVAL;
+	}
+
+	if (!goodix_berlin_checksum_valid(afe_data, length)) {
+		dev_err(cd->dev, "fw info checksum error\n");
+		return -EINVAL;
+	}
+
+	error = goodix_berlin_parse_ic_info(cd, afe_data, length);
+	if (error)
+		return error;
+
+	/* check some key info */
+	if (!cd->touch_data_addr) {
+		dev_err(cd->dev, "touch_data_addr is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int goodix_berlin_get_remaining_contacts(struct goodix_berlin_core *cd,
+						int n)
+{
+	size_t offset = 2 * GOODIX_BERLIN_TOUCH_SIZE +
+				GOODIX_BERLIN_CHECKSUM_SIZE;
+	u32 addr = cd->touch_data_addr + GOODIX_BERLIN_HEADER_SIZE + offset;
+	int error;
+
+	error = regmap_raw_read(cd->regmap, addr,
+				&cd->event.data[offset],
+				(n - 2) * GOODIX_BERLIN_TOUCH_SIZE);
+	if (error) {
+		dev_err_ratelimited(cd->dev, "failed to get touch data, %d\n",
+				    error);
+		return error;
+	}
+
+	return 0;
+}
+
+static void goodix_berlin_report_state(struct goodix_berlin_core *cd, int n)
+{
+	struct goodix_berlin_touch *touch_data =
+			(struct goodix_berlin_touch *)cd->event.data;
+	struct goodix_berlin_touch *t;
+	int i;
+	u8 type, id;
+
+	for (i = 0; i < n; i++) {
+		t = &touch_data[i];
+
+		type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK, t->status);
+		if (type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
+		    type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
+			dev_warn_once(cd->dev, "Stylus event type not handled\n");
+			continue;
+		}
+
+		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, t->status);
+		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
+			dev_warn_ratelimited(cd->dev, "invalid finger id %d\n", id);
+			continue;
+		}
+
+		input_mt_slot(cd->input_dev, id);
+		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
+
+		touchscreen_report_pos(cd->input_dev, &cd->props,
+				       __le16_to_cpu(t->x), __le16_to_cpu(t->y),
+				       true);
+		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
+				 __le16_to_cpu(t->w));
+	}
+
+	input_mt_sync_frame(cd->input_dev);
+	input_sync(cd->input_dev);
+}
+
+static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd)
+{
+	u8 touch_num;
+	int error;
+
+	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
+			      cd->event.hdr.request_type);
+	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
+		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
+		return;
+	}
+
+	if (touch_num > 2) {
+		/* read additional contact data if more than 2 touch events */
+		error = goodix_berlin_get_remaining_contacts(cd, touch_num);
+		if (error)
+			return;
+	}
+
+	if (touch_num) {
+		int len = touch_num * GOODIX_BERLIN_TOUCH_SIZE +
+			  GOODIX_BERLIN_CHECKSUM_SIZE;
+		if (!goodix_berlin_checksum_valid(cd->event.data, len)) {
+			dev_err(cd->dev, "touch data checksum error: %*ph\n",
+				len, cd->event.data);
+			return;
+		}
+	}
+
+	goodix_berlin_report_state(cd, touch_num);
+}
+
+static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
+{
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
+	usleep_range(2000, 2100);
+	gpiod_set_value_cansleep(cd->reset_gpio, 0);
+
+	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
+
+	return 0;
+}
+
+static irqreturn_t goodix_berlin_irq(int irq, void *data)
+{
+	struct goodix_berlin_core *cd = data;
+	int error;
+
+	/*
+	 * First, read buffer with space for 2 touch events:
+	 * - GOODIX_BERLIN_HEADER_SIZE = 8 bytes
+	 * - GOODIX_BERLIN_TOUCH_SIZE * 2 = 16 bytes
+	 * - GOODIX_BERLIN_CHECKLSUM_SIZE = 2 bytes
+	 * For a total of 26 bytes.
+	 *
+	 * If only a single finger is reported, we will read 8 bytes more than
+	 * needed:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
+	 * - bytes 8-15:  Finger 0 Data
+	 * - bytes 24-25: Checksum
+	 * - bytes 18-25: Unused 8 bytes
+	 *
+	 * If 2 fingers are reported, we would have read the exact needed
+	 * amount of data and checksum would be at the end of the buffer:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
+	 * - bytes 8-15:  Finger 0 Bytes 0-7
+	 * - bytes 16-23: Finger 1 Bytes 0-7
+	 * - bytes 24-25: Checksum
+	 *
+	 * If more than 2 fingers were reported, the "Checksum" bytes would
+	 * in fact contain part of the next finger data, and then
+	 * goodix_berlin_get_remaining_contacts() would complete the buffer
+	 * with the missing bytes, including the trailing checksum.
+	 * For example, if 3 fingers are reported, then we would do:
+	 * Read 1:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
+	 * - bytes 8-15:  Finger 0 Bytes 0-7
+	 * - bytes 16-23: Finger 1 Bytes 0-7
+	 * - bytes 24-25: Finger 2 Bytes 0-1
+	 * Read 2 (with length of (3 - 2) * 8 = 8 bytes):
+	 * - bytes 26-31: Finger 2 Bytes 2-7
+	 * - bytes 32-33: Checksum
+	 */
+	error = regmap_raw_read(cd->regmap, cd->touch_data_addr,
+				&cd->event,
+				GOODIX_BERLIN_HEADER_SIZE +
+					2 * GOODIX_BERLIN_TOUCH_SIZE +
+					GOODIX_BERLIN_CHECKSUM_SIZE);
+	if (error) {
+		dev_warn_ratelimited(cd->dev,
+				     "failed get event head data: %d\n", error);
+		goto out;
+	}
+
+	if (cd->event.hdr.status == 0)
+		goto out;
+
+	if (!goodix_berlin_checksum_valid((u8 *)&cd->event.hdr,
+					  GOODIX_BERLIN_HEADER_SIZE)) {
+		dev_warn_ratelimited(cd->dev,
+				     "touch head checksum error: %*ph\n",
+				     (int)GOODIX_BERLIN_HEADER_SIZE,
+				     &cd->event.hdr);
+		goto out_clear;
+	}
+
+	if (cd->event.hdr.status & GOODIX_BERLIN_TOUCH_EVENT)
+		goodix_berlin_touch_handler(cd);
+
+	if (cd->event.hdr.status & GOODIX_BERLIN_REQUEST_EVENT) {
+		switch (cd->event.hdr.request_type) {
+		case GOODIX_BERLIN_REQUEST_CODE_RESET:
+			if (cd->reset_gpio)
+				goodix_berlin_request_handle_reset(cd);
+			break;
+
+		default:
+			dev_warn(cd->dev, "unsupported request code 0x%x\n",
+				 cd->event.hdr.request_type);
+		}
+	}
+
+
+out_clear:
+	/* Clear up status field */
+	regmap_write(cd->regmap, cd->touch_data_addr, 0);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
+					  const struct input_id *id)
+{
+	struct input_dev *input_dev;
+	int error;
+
+	input_dev = devm_input_allocate_device(cd->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	cd->input_dev = input_dev;
+	input_set_drvdata(input_dev, cd);
+
+	input_dev->name = "Goodix Berlin Capacitive TouchScreen";
+	input_dev->phys = "input/ts";
+
+	input_dev->id = *id;
+
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X,
+			     0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y,
+			     0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
+
+	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	error = input_register_device(cd->input_dev);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int goodix_berlin_suspend(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+
+	disable_irq(cd->irq);
+	goodix_berlin_power_off(cd);
+
+	return 0;
+}
+
+static int goodix_berlin_resume(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+	int error;
+
+	error = goodix_berlin_power_on(cd);
+	if (error)
+		return error;
+
+	enable_irq(cd->irq);
+
+	return 0;
+}
+
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_berlin_pm_ops,
+			     goodix_berlin_suspend, goodix_berlin_resume);
+
+static void goodix_berlin_power_off_act(void *data)
+{
+	struct goodix_berlin_core *cd = data;
+
+	goodix_berlin_power_off(cd);
+}
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap)
+{
+	struct goodix_berlin_core *cd;
+	int error;
+
+	if (irq <= 0) {
+		dev_err(dev, "Missing interrupt number\n");
+		return -EINVAL;
+	}
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->dev = dev;
+	cd->regmap = regmap;
+	cd->irq = irq;
+
+	cd->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(cd->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(cd->reset_gpio),
+				     "Failed to request reset gpio\n");
+
+	cd->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(cd->avdd))
+		return dev_err_probe(dev, PTR_ERR(cd->avdd),
+				     "Failed to request avdd regulator\n");
+
+	cd->iovdd = devm_regulator_get(dev, "iovdd");
+	if (IS_ERR(cd->iovdd))
+		return dev_err_probe(dev, PTR_ERR(cd->iovdd),
+				     "Failed to request iovdd regulator\n");
+
+	error = goodix_berlin_power_on(cd);
+	if (error) {
+		dev_err(dev, "failed power on");
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, goodix_berlin_power_off_act, cd);
+	if (error)
+		return error;
+
+	error = goodix_berlin_read_version(cd);
+	if (error) {
+		dev_err(dev, "failed to get version info");
+		return error;
+	}
+
+	error = goodix_berlin_get_ic_info(cd);
+	if (error) {
+		dev_err(dev, "invalid ic info, abort");
+		return error;
+	}
+
+	error = goodix_berlin_input_dev_config(cd, id);
+	if (error) {
+		dev_err(dev, "failed set input device");
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, cd->irq, NULL, goodix_berlin_irq,
+					  IRQF_ONESHOT, "goodix-berlin", cd);
+	if (error) {
+		dev_err(dev, "request threaded irq failed: %d\n", error);
+		return error;
+	}
+
+	dev_set_drvdata(dev, cd);
+
+	dev_dbg(dev, "Goodix Berlin %s Touchscreen Controller",
+		cd->fw_version.patch_pid);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(goodix_berlin_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin Core Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1


