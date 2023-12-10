Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65580B96B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjLJGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:53:22 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9CF3;
        Sat,  9 Dec 2023 22:53:26 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58e256505f7so1789109eaf.3;
        Sat, 09 Dec 2023 22:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702191206; x=1702796006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPALWp2Em0RjUnBkgaGplwsJxdOxgiFbhGopmk+fK10=;
        b=II86w6Ux7wbuv/UEb7PmGC2LaajgIpFzl+JqjquUgmGxmBihHoJK4zyX1mB1fRFnDQ
         syIimgxc5VWS7pvxTw6o7nfJK+APZ0QHlbbD1OBAUowWhoJyInJqe+bCptcAZ0vA7h5J
         oGx05Ruq2SFil4nXepQqKLKMh/V0I6/bT9iGCMRIxxBQFq5ioWun7GS4qLUisbR/zGP3
         3O0C2qSKwrBh0z+bqaeJNLEhXSoVYB+b8YiPlA+C75nf4UWsGcBqsNCuQsjYUfEVaLyW
         Fa+tBLAQLJbxv0b2c30Oy3jv6cP+WfLwIDPhmHGovVCQ0wcOWOJBA/U2UhUERPyfTqNe
         wbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702191206; x=1702796006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPALWp2Em0RjUnBkgaGplwsJxdOxgiFbhGopmk+fK10=;
        b=PGLrU0+VRhfn5zTSU4V98VR8BX0IAN/NPR75AXF/lHFKIRp270Q2nTDbHn+t3VhuoA
         nGZA0kmML1kk1tA2iLAYZTJk1BEMDoBoAgDVKk0AS7d8j2Cikzl5Go4CC8bsHS39pAdR
         LJzpdZRTvW26UmmvYq1EFnaBP5xWX26AVry8FspBEr/V2X1aA2rn65w1syAVF5yNW4xg
         HdO2LA7ozAZPFGlRqR1+7nxe7ozw36GGiy+teT45itIZTFNOqATSWdGfBlVwfEXpcYnz
         5mk/MbQMUQUzqHmeHQX32P4qb87IXH2wLDuRWY1D1+dKo2REWQ90RWxolAafIjB7MfRR
         MdvQ==
X-Gm-Message-State: AOJu0Yw3O+THW50dsXHF2RrUc1GzFu0Y0f1WuMffPKA8k6eP8y5fYLwd
        KAWuqmC9ZKAwu8NwCyX6Z5E=
X-Google-Smtp-Source: AGHT+IERaPEjCHkG7VBHcYfF6Jv7XhJBTGSMttoyHAJj/SPEAtUzZ5ZCBL7hpJsvIYi6N0Lfz++KgQ==
X-Received: by 2002:a05:6870:b486:b0:1ff:832:5156 with SMTP id y6-20020a056870b48600b001ff08325156mr3655142oap.49.1702191206000;
        Sat, 09 Dec 2023 22:53:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9082:8aa4:377c:de99])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001cfc1764fa7sm4330083plg.1.2023.12.09.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 22:53:25 -0800 (PST)
Date:   Sat, 9 Dec 2023 22:53:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Message-ID: <ZXVgYuzE6jPPSfnZ@google.com>
References: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
 <20231209-topic-goodix-berlin-upstream-initial-v12-2-eaffaeb53fb5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kqe8sCv0aVCUmKKU"
Content-Disposition: inline
In-Reply-To: <20231209-topic-goodix-berlin-upstream-initial-v12-2-eaffaeb53fb5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kqe8sCv0aVCUmKKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Neil,

On Sat, Dec 09, 2023 at 08:33:40AM +0100, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs.
> 
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> Support for advanced features like:
> - Firmware & config update
> - Stylus events
> - Gestures events
> - Previous revisions support (BerlinA or BerlinB)
> is not included in current version.
> 
> The current support will work with currently flashed firmware
> and config, and bail out if firmware or config aren't flashed yet.
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you for resending the patch. I think there is an issue in how you
read and parse the data in case of more than 2 fingers. It looks like in
that case you are overwriting the checksum form the first 2 and then not
reading the new checksum but use some garbage past the touch data. I
might be mistaken though...

I also believe you are leaking afe_data in case of success. We have the
newfangled __free(kfree) from cleanup.h that should help there.

Another request - we should not have anything in goodix_berlin.h that is
not used by the I2C and SPI sub-drivers, so the only thing it should
contain is goodix_berlin_probe() declaration and dev_pm_ops. All other
defines and definitions should go to goodix_berlin_core.h.

I made a few more cosmetic changes in the attached patch, please
consider applying it.

Thanks.

-- 
Dmitry

--Kqe8sCv0aVCUmKKU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="tmp.patch"

diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
index 235f44947a28..1fd77eb69c9a 100644
--- a/drivers/input/touchscreen/goodix_berlin.h
+++ b/drivers/input/touchscreen/goodix_berlin.h
@@ -10,146 +10,11 @@
 #ifndef __GOODIX_BERLIN_H_
 #define __GOODIX_BERLIN_H_
 
-#include <linux/gpio/consumer.h>
-#include <linux/input.h>
-#include <linux/input/touchscreen.h>
-#include <linux/regulator/consumer.h>
-#include <linux/sizes.h>
+#include <linux/pm.h>
 
-#define GOODIX_BERLIN_MAX_TOUCH			10
-
-#define GOODIX_BERLIN_NORMAL_RESET_DELAY_MS	100
-
-#define GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN	8
-#define GOODIX_BERLIN_STATUS_OFFSET		0
-#define GOODIX_BERLIN_REQUEST_TYPE_OFFSET	2
-
-#define GOODIX_BERLIN_BYTES_PER_POINT		8
-#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE	2
-#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK	GENMASK(15, 0)
-
-/* Read n finger events */
-#define GOODIX_BERLIN_IRQ_READ_LEN(n)		(GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN + \
-						 (GOODIX_BERLIN_BYTES_PER_POINT * (n)) + \
-						 GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
-
-#define GOODIX_BERLIN_TOUCH_EVENT		BIT(7)
-#define GOODIX_BERLIN_REQUEST_EVENT		BIT(6)
-#define GOODIX_BERLIN_TOUCH_COUNT_MASK		GENMASK(3, 0)
-
-#define GOODIX_BERLIN_REQUEST_CODE_RESET	3
-
-#define GOODIX_BERLIN_POINT_TYPE_MASK		GENMASK(3, 0)
-#define GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER	1
-#define GOODIX_BERLIN_POINT_TYPE_STYLUS		3
-
-#define GOODIX_BERLIN_TOUCH_ID_MASK		GENMASK(7, 4)
-
-#define GOODIX_BERLIN_DEV_CONFIRM_VAL		0xAA
-#define GOODIX_BERLIN_BOOTOPTION_ADDR		0x10000
-#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR	0x10014
-
-#define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
-#define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
-
-struct goodix_berlin_fw_version {
-	u8 rom_pid[6];
-	u8 rom_vid[3];
-	u8 rom_vid_reserved;
-	u8 patch_pid[8];
-	u8 patch_vid[4];
-	u8 patch_vid_reserved;
-	u8 sensor_id;
-	u8 reserved[2];
-	__le16 checksum;
-} __packed;
-
-struct goodix_berlin_ic_info_version {
-	u8 info_customer_id;
-	u8 info_version_id;
-	u8 ic_die_id;
-	u8 ic_version_id;
-	__le32 config_id;
-	u8 config_version;
-	u8 frame_data_customer_id;
-	u8 frame_data_version_id;
-	u8 touch_data_customer_id;
-	u8 touch_data_version_id;
-	u8 reserved[3];
-} __packed;
-
-struct goodix_berlin_ic_info_feature {
-	__le16 freqhop_feature;
-	__le16 calibration_feature;
-	__le16 gesture_feature;
-	__le16 side_touch_feature;
-	__le16 stylus_feature;
-} __packed;
-
-struct goodix_berlin_ic_info_misc {
-	__le32 cmd_addr;
-	__le16 cmd_max_len;
-	__le32 cmd_reply_addr;
-	__le16 cmd_reply_len;
-	__le32 fw_state_addr;
-	__le16 fw_state_len;
-	__le32 fw_buffer_addr;
-	__le16 fw_buffer_max_len;
-	__le32 frame_data_addr;
-	__le16 frame_data_head_len;
-	__le16 fw_attr_len;
-	__le16 fw_log_len;
-	u8 pack_max_num;
-	u8 pack_compress_version;
-	__le16 stylus_struct_len;
-	__le16 mutual_struct_len;
-	__le16 self_struct_len;
-	__le16 noise_struct_len;
-	__le32 touch_data_addr;
-	__le16 touch_data_head_len;
-	__le16 point_struct_len;
-	__le16 reserved1;
-	__le16 reserved2;
-	__le32 mutual_rawdata_addr;
-	__le32 mutual_diffdata_addr;
-	__le32 mutual_refdata_addr;
-	__le32 self_rawdata_addr;
-	__le32 self_diffdata_addr;
-	__le32 self_refdata_addr;
-	__le32 iq_rawdata_addr;
-	__le32 iq_refdata_addr;
-	__le32 im_rawdata_addr;
-	__le16 im_readata_len;
-	__le32 noise_rawdata_addr;
-	__le16 noise_rawdata_len;
-	__le32 stylus_rawdata_addr;
-	__le16 stylus_rawdata_len;
-	__le32 noise_data_addr;
-	__le32 esd_addr;
-} __packed;
-
-struct goodix_berlin_touch_data {
-	u8 id;
-	u8 unused;
-	__le16 x;
-	__le16 y;
-	__le16 w;
-} __packed;
-
-struct goodix_berlin_core {
-	struct device *dev;
-	struct regmap *regmap;
-	struct regulator *avdd;
-	struct regulator *iovdd;
-	struct gpio_desc *reset_gpio;
-	struct touchscreen_properties props;
-	struct goodix_berlin_fw_version fw_version;
-	struct input_dev *input_dev;
-	int irq;
-
-	/* Runtime parameters extracted from IC_INFO buffer  */
-	u32 touch_data_addr;
-};
+struct device;
+struct input_id;
+struct regmap;
 
 int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
 			struct regmap *regmap);
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index c66e2f0c6529..88a88e77d940 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -1,28 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Goodix Touchscreen Driver
+ * Goodix "Berlin" Touchscreen IC driver
  * Copyright (C) 2020 - 2021 Goodix, Inc.
  * Copyright (C) 2023 Linaro Ltd.
  *
  * Based on goodix_ts_berlin driver.
- */
-#include <asm/unaligned.h>
-#include <linux/bitfield.h>
-#include <linux/input/mt.h>
-#include <linux/input/touchscreen.h>
-#include <linux/regmap.h>
-
-#include "goodix_berlin.h"
-
-/*
- * Goodix "Berlin" Touchscreen IC driver
  *
  * This driver is distinct from goodix.c since hardware interface
  * is different enough to require a new driver.
  * None of the register address or data structure are close enough
  * to the previous generations.
  *
- * Currently only handles Multitouch events with already
+ * Currently the driver only handles Multitouch events with already
  * programmed firmware and "config" for "Revision D" Berlin IC.
  *
  * Support is missing for:
@@ -34,6 +23,153 @@
  * - Support for older revisions (A & B)
  */
 
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
+#define GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN	8
+#define GOODIX_BERLIN_STATUS_OFFSET		0
+#define GOODIX_BERLIN_REQUEST_TYPE_OFFSET	2
+
+#define GOODIX_BERLIN_BYTES_PER_POINT		8
+#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE	2
+#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK	GENMASK(15, 0)
+
+/* Read n finger events */
+#define GOODIX_BERLIN_IRQ_READ_LEN(n)		(GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN + \
+						 (GOODIX_BERLIN_BYTES_PER_POINT * (n)) + \
+						 GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
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
+} __packed;
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
+struct goodix_berlin_touch_data {
+	u8 id;
+	u8 unused;
+	__le16 x;
+	__le16 y;
+	__le16 w;
+} __packed;
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
+};
+
 static bool goodix_berlin_checksum_valid(const u8 *data, int size)
 {
 	u32 cal_checksum = 0;
@@ -46,9 +182,11 @@ static bool goodix_berlin_checksum_valid(const u8 *data, int size)
 	for (i = 0; i < size - GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE; i++)
 		cal_checksum += data[i];
 
+	cal_checksum = FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK,
+				 cal_checksum);
 	r_checksum = get_unaligned_le16(&data[i]);
 
-	return FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK, cal_checksum) == r_checksum;
+	return cal_checksum == r_checksum;
 }
 
 static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
@@ -76,13 +214,15 @@ static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
 
 	memset(tx_buf, GOODIX_BERLIN_DEV_CONFIRM_VAL, sizeof(tx_buf));
 	while (retry--) {
-		error = regmap_raw_write(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, tx_buf,
-					 sizeof(tx_buf));
+		error = regmap_raw_write(cd->regmap,
+					 GOODIX_BERLIN_BOOTOPTION_ADDR,
+					 tx_buf, sizeof(tx_buf));
 		if (error)
 			return error;
 
-		error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, rx_buf,
-					sizeof(rx_buf));
+		error = regmap_raw_read(cd->regmap,
+					GOODIX_BERLIN_BOOTOPTION_ADDR,
+					rx_buf, sizeof(rx_buf));
 		if (error)
 			return error;
 
@@ -92,66 +232,70 @@ static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
 		usleep_range(5000, 5100);
 	}
 
-	dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n", 8, rx_buf);
+	dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n",
+		(int)sizeof(rx_buf), rx_buf);
 
 	return -EINVAL;
 }
 
-static int goodix_berlin_power_on(struct goodix_berlin_core *cd, bool on)
+static int goodix_berlin_power_on(struct goodix_berlin_core *cd)
 {
-	int error = 0;
+	int error;
 
-	if (on) {
-		error = regulator_enable(cd->iovdd);
-		if (error) {
-			dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
-			return error;
-		}
+	error = regulator_enable(cd->iovdd);
+	if (error) {
+		dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
+		return error;
+	}
 
-		/* Vendor waits 3ms for IOVDD to settle */
-		usleep_range(3000, 3100);
+	/* Vendor waits 3ms for IOVDD to settle */
+	usleep_range(3000, 3100);
 
-		error = regulator_enable(cd->avdd);
-		if (error) {
-			dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
-			goto err_iovdd_disable;
-		}
+	error = regulator_enable(cd->avdd);
+	if (error) {
+		dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
+		goto err_iovdd_disable;
+	}
 
-		/* Vendor waits 15ms for IOVDD to settle */
-		usleep_range(15000, 15100);
+	/* Vendor waits 15ms for IOVDD to settle */
+	usleep_range(15000, 15100);
 
-		gpiod_set_value(cd->reset_gpio, 0);
+	gpiod_set_value_cansleep(cd->reset_gpio, 0);
 
-		/* Vendor waits 4ms for Firmware to initialize */
-		usleep_range(4000, 4100);
+	/* Vendor waits 4ms for Firmware to initialize */
+	usleep_range(4000, 4100);
 
-		error = goodix_berlin_dev_confirm(cd);
-		if (error)
-			goto err_dev_reset;
+	error = goodix_berlin_dev_confirm(cd);
+	if (error)
+		goto err_dev_reset;
 
-		/* Vendor waits 100ms for Firmware to fully boot */
-		msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
+	/* Vendor waits 100ms for Firmware to fully boot */
+	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
 
-		return 0;
-	}
+	return 0;
 
 err_dev_reset:
-	gpiod_set_value(cd->reset_gpio, 1);
-
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
 	regulator_disable(cd->avdd);
-
 err_iovdd_disable:
 	regulator_disable(cd->iovdd);
-
 	return error;
 }
 
+static void goodix_berlin_power_off(struct goodix_berlin_core *cd)
+{
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
+	regulator_disable(cd->avdd);
+	regulator_disable(cd->iovdd);
+}
+
 static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
 {
 	u8 buf[sizeof(struct goodix_berlin_fw_version)];
 	int error;
 
-	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR, buf, sizeof(buf));
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR,
+				buf, sizeof(buf));
 	if (error) {
 		dev_err(cd->dev, "error reading fw version, %d\n", error);
 		return error;
@@ -235,8 +379,8 @@ static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
 
 static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
 {
+	u8 *afe_data __free(kfree) = NULL;
 	__le16 length_raw;
-	u8 *afe_data;
 	u16 length;
 	int error;
 
@@ -248,53 +392,44 @@ static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
 				&length_raw, sizeof(length_raw));
 	if (error) {
 		dev_err(cd->dev, "failed get ic info length, %d\n", error);
-		goto free_afe_data;
+		return error;
 	}
 
 	length = le16_to_cpu(length_raw);
 	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
 		dev_err(cd->dev, "invalid ic info length %d\n", length);
-		error = -EINVAL;
-		goto free_afe_data;
+		return -EINVAL;
 	}
 
 	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
 				afe_data, length);
 	if (error) {
 		dev_err(cd->dev, "failed get ic info data, %d\n", error);
-		goto free_afe_data;
+		return error;
 	}
 
 	/* check whether the data is valid (ex. bus default values) */
 	if (goodix_berlin_is_dummy_data(cd, afe_data, length)) {
 		dev_err(cd->dev, "fw info data invalid\n");
-		error = -EINVAL;
-		goto free_afe_data;
+		return -EINVAL;
 	}
 
 	if (!goodix_berlin_checksum_valid(afe_data, length)) {
 		dev_err(cd->dev, "fw info checksum error\n");
-		error = -EINVAL;
-		goto free_afe_data;
+		return -EINVAL;
 	}
 
 	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
 	if (error)
-		goto free_afe_data;
+		return error;
 
 	/* check some key info */
 	if (!cd->touch_data_addr) {
 		dev_err(cd->dev, "touch_data_addr is null\n");
-		error = -EINVAL;
-		goto free_afe_data;
+		return -EINVAL;
 	}
 
 	return 0;
-
-free_afe_data:
-	kfree(afe_data);
-
-	return error;
 }
 
 static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
@@ -305,12 +440,12 @@ static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
 
 	/* Report finger touches */
 	for (i = 0; i < touch_num; i++) {
-		unsigned int id;
-
-		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, touch_data[i].id);
+		unsigned int id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
+					    touch_data[i].id);
 
 		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
-			dev_warn_ratelimited(cd->dev, "invalid finger id %d\n", id);
+			dev_warn_ratelimited(cd->dev,
+					     "invalid finger id %d\n", id);
 			continue;
 		}
 
@@ -372,7 +507,7 @@ static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
 
 		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
 						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
-			dev_err(cd->dev, "touch data checksum error, data: %*ph\n",
+			dev_err(cd->dev, "touch data checksum error: %*ph\n",
 				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
 				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
 			return;
@@ -385,16 +520,16 @@ static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
 
 static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
 {
-	gpiod_set_value(cd->reset_gpio, 1);
+	gpiod_set_value_cansleep(cd->reset_gpio, 1);
 	usleep_range(2000, 2100);
-	gpiod_set_value(cd->reset_gpio, 0);
+	gpiod_set_value_cansleep(cd->reset_gpio, 0);
 
 	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
 
 	return 0;
 }
 
-static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
+static irqreturn_t goodix_berlin_irq(int irq, void *data)
 {
 	struct goodix_berlin_core *cd = data;
 	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
@@ -405,7 +540,8 @@ static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
 	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
 				GOODIX_BERLIN_IRQ_READ_LEN(2));
 	if (error) {
-		dev_err_ratelimited(cd->dev, "failed get event head data, %d\n", error);
+		dev_warn_ratelimited(cd->dev,
+				     "failed get event head data: %d\n", error);
 		return IRQ_HANDLED;
 	}
 
@@ -413,7 +549,8 @@ static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
 		return IRQ_HANDLED;
 
 	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
-		dev_warn_ratelimited(cd->dev, "touch head checksum err : %*ph\n",
+		dev_warn_ratelimited(cd->dev,
+				     "touch head checksum error: %*ph\n",
 				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
 		return IRQ_HANDLED;
 	}
@@ -421,7 +558,8 @@ static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
 	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
 
 	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
-		goodix_berlin_touch_handler(cd, buf, GOODIX_BERLIN_IRQ_READ_LEN(2));
+		goodix_berlin_touch_handler(cd, buf,
+					    GOODIX_BERLIN_IRQ_READ_LEN(2));
 
 	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
 		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
@@ -460,8 +598,10 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
 
 	input_dev->id = *id;
 
-	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
-	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X,
+			     0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y,
+			     0, SZ_64K - 1, 0, 0);
 	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
 	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
@@ -478,21 +618,22 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
 	return 0;
 }
 
-static int goodix_berlin_pm_suspend(struct device *dev)
+static int goodix_berlin_suspend(struct device *dev)
 {
 	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
 
 	disable_irq(cd->irq);
+	goodix_berlin_power_off(cd);
 
-	return goodix_berlin_power_on(cd, false);
+	return 0;
 }
 
-static int goodix_berlin_pm_resume(struct device *dev)
+static int goodix_berlin_resume(struct device *dev)
 {
 	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
 	int error;
 
-	error = goodix_berlin_power_on(cd, true);
+	error = goodix_berlin_power_on(cd);
 	if (error)
 		return error;
 
@@ -502,14 +643,13 @@ static int goodix_berlin_pm_resume(struct device *dev)
 }
 
 EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_berlin_pm_ops,
-			     goodix_berlin_pm_suspend,
-			     goodix_berlin_pm_resume);
+			     goodix_berlin_suspend, goodix_berlin_resume);
 
-static void goodix_berlin_power_off(void *data)
+static void goodix_berlin_power_off_act(void *data)
 {
 	struct goodix_berlin_core *cd = data;
 
-	goodix_berlin_power_on(cd, false);
+	goodix_berlin_power_off(cd);
 }
 
 int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
@@ -546,13 +686,13 @@ int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
 		return dev_err_probe(dev, PTR_ERR(cd->iovdd),
 				     "Failed to request iovdd regulator\n");
 
-	error = goodix_berlin_power_on(cd, true);
+	error = goodix_berlin_power_on(cd);
 	if (error) {
 		dev_err(dev, "failed power on");
 		return error;
 	}
 
-	error = devm_add_action_or_reset(dev, goodix_berlin_power_off, cd);
+	error = devm_add_action_or_reset(dev, goodix_berlin_power_off_act, cd);
 	if (error)
 		return error;
 
@@ -574,8 +714,7 @@ int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
 		return error;
 	}
 
-	error = devm_request_threaded_irq(dev, irq, NULL,
-					  goodix_berlin_threadirq_func,
+	error = devm_request_threaded_irq(dev, cd->irq, NULL, goodix_berlin_irq,
 					  IRQF_ONESHOT, "goodix-berlin", cd);
 	if (error) {
 		dev_err(dev, "request threaded irq failed: %d\n", error);
@@ -584,7 +723,8 @@ int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
 
 	dev_set_drvdata(dev, cd);
 
-	dev_dbg(dev, "Goodix Berlin %s Touchscreen Controller", cd->fw_version.patch_pid);
+	dev_dbg(dev, "Goodix Berlin %s Touchscreen Controller",
+		cd->fw_version.patch_pid);
 
 	return 0;
 }

--Kqe8sCv0aVCUmKKU--
