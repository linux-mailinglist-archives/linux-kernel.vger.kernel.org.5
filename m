Return-Path: <linux-kernel+bounces-23143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B159382A838
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270BD1F231DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FBD2E4;
	Thu, 11 Jan 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHN0N1YM"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B987CA7B;
	Thu, 11 Jan 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so2597774b3a.2;
        Wed, 10 Jan 2024 23:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704957652; x=1705562452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tj6LfWUix87AyqZdq0UESWLh9bc9GqjuqVP7gpqtcg=;
        b=YHN0N1YMwI+JlJ5/oO2bAcnZZ8WfeI40hbAdrOZB/vhJmjNue1JkRMD8KR/GUnxYmj
         qx8x8O26XpolHrbEVgt+Vfeqd9D8x+aTQUT/6UU+/AmXTsyUqV0A3SIY0bUvY2Nv5lnn
         WomzB5FQm2+YtA4PazAYpahGSe67gMdv/ehFKFUzU9lM9109xve2PwTOPmDg/3Hajac/
         r6t9jHFYXcMksMzHoimh1pWyN8ufuBl/uAGMpUqeDObJASLiliV2LhIXuHBsgUVfN11j
         OP7+yiGDnunt4avB5hWdllCEc9rD0M8zN4ABJAoANQ+nae6X7b2RX8ddUO+WPa2iVG4d
         5XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957652; x=1705562452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tj6LfWUix87AyqZdq0UESWLh9bc9GqjuqVP7gpqtcg=;
        b=Bq086oyV/yHpumbRba7cUCEMo06NPY2+r3jqMK04qxszhwn6t/aKVmCyKRprP3r9+1
         pMP2tPyssDGYefWTERXpFaGXTlw/ActeTdy4N4LVuo/slnOfNkFUTZ0lN6r2rlK4ZQbY
         HOjUTm33SaB14gZXV791lmTv9iRcXTHpyhyU3kmdPpdpvrTwrc5YJuYUgaWBu+8er5C/
         PQwLUwqpF/gV7Lj7XeC8I3sICvOiW6UFkIvZh1/8wlInsCrenj9zD2O+rDWP0eMVc/qx
         VY1nl14uUFBrdZmJX7EzXybr3Pi+7z/UQP99SUmvFRHgsfQhcrLrl8P8aHyosH9LzR6i
         S4rg==
X-Gm-Message-State: AOJu0YyR6Cl6PBgeMrQ+dVjF/t67d8fs5C13GDECqYmTHSVmURP//0TW
	RxKdqV3usYH7PtXRC+elEFu6ZgOohx4=
X-Google-Smtp-Source: AGHT+IFqpN9SjdGuZaRHePzbbaO8523BBlbWXs88GJC7tlNIKxc/AYhOE4ZYifPZuVfE7y/dNZ/+vA==
X-Received: by 2002:a05:6a00:130a:b0:6da:bceb:3990 with SMTP id j10-20020a056a00130a00b006dabceb3990mr802859pfu.53.1704957652511;
        Wed, 10 Jan 2024 23:20:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id bj18-20020a056a02019200b005c2420fb198sm450400pgb.37.2024.01.10.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:20:52 -0800 (PST)
Date: Wed, 10 Jan 2024 23:20:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Message-ID: <ZZ-W0UPHOdpU-8el@google.com>
References: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
 <20231221-topic-goodix-berlin-upstream-initial-v14-2-04459853b640@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221-topic-goodix-berlin-upstream-initial-v14-2-04459853b640@linaro.org>

Hi Neil,

On Thu, Dec 21, 2023 at 04:21:20PM +0100, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs.

Thank you very much for explaining how reading of additional contacts
and checksum works, it makes sense now.

I was a bit unhappy about number of times we copy/move the data over;
could you please try the patch below to see if the device still works
with it?

I also shortened some #defines and defines some additional structures.
Also as far as I can see not everything needs to be packed as the data
is naturally aligned on the word boundaries.

Thanks!

-- 
Dmitry


diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index 6aca57e6b5d6..d1f1c0474116 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -39,19 +39,6 @@
 
 #define GOODIX_BERLIN_NORMAL_RESET_DELAY_MS	100
 
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
 #define GOODIX_BERLIN_TOUCH_EVENT		BIT(7)
 #define GOODIX_BERLIN_REQUEST_EVENT		BIT(6)
 #define GOODIX_BERLIN_TOUCH_COUNT_MASK		GENMASK(3, 0)
@@ -71,6 +58,8 @@
 #define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
 #define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
 
+#define GOODIX_BERLIN_CHECKSUM_SIZE		sizeof(u16)
+
 struct goodix_berlin_fw_version {
 	u8 rom_pid[6];
 	u8 rom_vid[3];
@@ -81,7 +70,7 @@ struct goodix_berlin_fw_version {
 	u8 sensor_id;
 	u8 reserved[2];
 	__le16 checksum;
-} __packed;
+};
 
 struct goodix_berlin_ic_info_version {
 	u8 info_customer_id;
@@ -147,13 +136,30 @@ struct goodix_berlin_ic_info_misc {
 	__le32 esd_addr;
 } __packed;
 
-struct goodix_berlin_touch_data {
-	u8 id;
-	u8 unused;
+struct goodix_berlin_touch {
+	u8 status;
+	u8 reserved;
 	__le16 x;
 	__le16 y;
 	__le16 w;
-} __packed;
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
 
 struct goodix_berlin_core {
 	struct device *dev;
@@ -168,25 +174,25 @@ struct goodix_berlin_core {
 
 	/* Runtime parameters extracted from IC_INFO buffer  */
 	u32 touch_data_addr;
+
+	struct goodix_berlin_event event;
 };
 
 static bool goodix_berlin_checksum_valid(const u8 *data, int size)
 {
 	u32 cal_checksum = 0;
 	u16 r_checksum;
-	u32 i;
+	int i;
 
-	if (size < GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
+	if (size < GOODIX_BERLIN_CHECKSUM_SIZE)
 		return false;
 
-	for (i = 0; i < size - GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE; i++)
+	for (i = 0; i < size - GOODIX_BERLIN_CHECKSUM_SIZE; i++)
 		cal_checksum += data[i];
 
-	cal_checksum = FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK,
-				 cal_checksum);
 	r_checksum = get_unaligned_le16(&data[i]);
 
-	return cal_checksum == r_checksum;
+	return (u16)cal_checksum == r_checksum;
 }
 
 static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
@@ -291,33 +297,30 @@ static void goodix_berlin_power_off(struct goodix_berlin_core *cd)
 
 static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
 {
-	u8 buf[sizeof(struct goodix_berlin_fw_version)];
 	int error;
 
 	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR,
-				buf, sizeof(buf));
+				&cd->fw_version, sizeof(cd->fw_version));
 	if (error) {
 		dev_err(cd->dev, "error reading fw version, %d\n", error);
 		return error;
 	}
 
-	if (!goodix_berlin_checksum_valid(buf, sizeof(buf))) {
+	if (!goodix_berlin_checksum_valid((u8 *)&cd->fw_version,
+					  sizeof(cd->fw_version))) {
 		dev_err(cd->dev, "invalid fw version: checksum error\n");
 		return -EINVAL;
 	}
 
-	memcpy(&cd->fw_version, buf, sizeof(cd->fw_version));
-
 	return 0;
 }
 
 /* Only extract necessary data for runtime */
-static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
-					 const u8 *data, u16 length)
+static int goodix_berlin_parse_ic_info(struct goodix_berlin_core *cd,
+				       const u8 *data, u16 length)
 {
-	struct goodix_berlin_ic_info_misc misc;
+	struct goodix_berlin_ic_info_misc *misc;
 	unsigned int offset = 0;
-	u8 param_num;
 
 	offset += sizeof(__le16); /* length */
 	offset += sizeof(struct goodix_berlin_ic_info_version);
@@ -325,49 +328,25 @@ static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
 
 	/* IC_INFO Parameters, variable width structure */
 	offset += 4 * sizeof(u8); /* drv_num, sen_num, button_num, force_num */
-
-	if (offset >= length)
-		goto invalid_offset;
-
-	param_num = data[offset++]; /* active_scan_rate_num */
-
-	offset += param_num * sizeof(__le16);
-
-	if (offset >= length)
-		goto invalid_offset;
-
-	param_num = data[offset++]; /* mutual_freq_num*/
-
-	offset += param_num * sizeof(__le16);
-
-	if (offset >= length)
-		goto invalid_offset;
-
-	param_num = data[offset++]; /* self_tx_freq_num */
-
-	offset += param_num * sizeof(__le16);
-
-	if (offset >= length)
-		goto invalid_offset;
-
-	param_num = data[offset++]; /* self_rx_freq_num */
-
-	offset += param_num * sizeof(__le16);
-
 	if (offset >= length)
 		goto invalid_offset;
 
-	param_num = data[offset++]; /* stylus_freq_num */
-
-	offset += param_num * sizeof(__le16);
-
-	if (offset + sizeof(misc) > length)
-		goto invalid_offset;
-
-	/* goodix_berlin_ic_info_misc */
-	memcpy(&misc, &data[offset], sizeof(misc));
-
-	cd->touch_data_addr = le32_to_cpu(misc.touch_data_addr);
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
 
 	return 0;
 
@@ -419,7 +398,7 @@ static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
 		return -EINVAL;
 	}
 
-	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
+	error = goodix_berlin_parse_ic_info(cd, afe_data, length);
 	if (error)
 		return error;
 
@@ -432,20 +411,47 @@ static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
 	return 0;
 }
 
-static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
-				       const void *buf, int touch_num)
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
 {
-	const struct goodix_berlin_touch_data *touch_data = buf;
+	struct goodix_berlin_touch *touch_data =
+			(struct goodix_berlin_touch *)cd->event.data;
+	struct goodix_berlin_touch *t;
 	int i;
+	u8 type, id;
+
+	for (i = 0; i < n; i++) {
+		t = &touch_data[i];
 
-	/* Report finger touches */
-	for (i = 0; i < touch_num; i++) {
-		unsigned int id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
-					    touch_data[i].id);
+		type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK, t->status);
+		if (type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
+		    type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
+			dev_warn_once(cd->dev, "Stylus event type not handled\n");
+			continue;
+		}
 
+		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, t->status);
 		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
-			dev_warn_ratelimited(cd->dev,
-					     "invalid finger id %d\n", id);
+			dev_warn_ratelimited(cd->dev, "invalid finger id %d\n", id);
 			continue;
 		}
 
@@ -453,69 +459,46 @@ static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
 		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
 
 		touchscreen_report_pos(cd->input_dev, &cd->props,
-				       __le16_to_cpu(touch_data[i].x),
-				       __le16_to_cpu(touch_data[i].y),
+				       __le16_to_cpu(t->x), __le16_to_cpu(t->y),
 				       true);
 		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
-				 __le16_to_cpu(touch_data[i].w));
+				 __le16_to_cpu(t->w));
 	}
 
 	input_mt_sync_frame(cd->input_dev);
 	input_sync(cd->input_dev);
 }
 
-static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
-					const void *pre_buf, u32 pre_buf_len)
+static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd)
 {
-	u8 buffer[GOODIX_BERLIN_IRQ_READ_LEN(GOODIX_BERLIN_MAX_TOUCH)];
-	u8 point_type, touch_num;
+	u8 touch_num;
 	int error;
 
-	/* copy pre-data to buffer */
-	memcpy(buffer, pre_buf, pre_buf_len);
-
 	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
-			      buffer[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
-
+			      cd->event.hdr.request_type);
 	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
 		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
 		return;
 	}
 
-	if (touch_num) {
-		/* read more data if more than 2 touch events */
-		if (unlikely(touch_num > 2)) {
-			error = regmap_raw_read(cd->regmap,
-						cd->touch_data_addr + pre_buf_len,
-						&buffer[pre_buf_len],
-						(touch_num - 2) * GOODIX_BERLIN_BYTES_PER_POINT);
-			if (error) {
-				dev_err_ratelimited(cd->dev, "failed to get touch data, %d\n",
-						    error);
-				return;
-			}
-		}
-
-		point_type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK,
-				       buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
-
-		if (point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
-		    point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
-			dev_warn_once(cd->dev, "Stylus event type not handled\n");
+	if (touch_num > 2) {
+		/* read additional contact data if more than 2 touch events */
+		error = goodix_berlin_get_remaining_contacts(cd, touch_num);
+		if (error)
 			return;
-		}
+	}
 
-		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
-						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
+	if (touch_num) {
+		int len = touch_num * GOODIX_BERLIN_TOUCH_SIZE +
+			  GOODIX_BERLIN_CHECKSUM_SIZE;
+		if (!goodix_berlin_checksum_valid(cd->event.data, len)) {
 			dev_err(cd->dev, "touch data checksum error: %*ph\n",
-				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
-				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
+				len, cd->event.data);
 			return;
 		}
 	}
 
-	goodix_berlin_parse_finger(cd, &buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
-				   touch_num);
+	goodix_berlin_report_state(cd, touch_num);
 }
 
 static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
@@ -532,68 +515,72 @@ static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
 static irqreturn_t goodix_berlin_irq(int irq, void *data)
 {
 	struct goodix_berlin_core *cd = data;
-	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
-	u8 event_status;
 	int error;
 
 	/*
 	 * First, read buffer with space for 2 touch events:
-	 * - GOODIX_BERLIN_IRQ_EVENT_HEAD = 8 bytes
-	 * - GOODIX_BERLIN_BYTES_PER_POINT * 2 +
-	 *   GOODIX_BERLIN_COOR_DATA_CHECKSUM = 18 bytes
+	 * - GOODIX_BERLIN_HEADER_SIZE = 8 bytes
+	 * - GOODIX_BERLIN_TOUCH_SIZE * 2 = 16 bytes
+	 * - GOODIX_BERLIN_CHECKLSUM_SIZE = 2 bytes
 	 * For a total of 26 bytes.
 	 *
-	 * If only a single finger is reported, we will read 8 bytes more than needed:
-	 * - bytes 0-7:   GOODIX_BERLIN_IRQ_EVENT_HEAD
+	 * If only a single finger is reported, we will read 8 bytes more than
+	 * needed:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
 	 * - bytes 8-15:  Finger 0 Data
-	 * - bytes 16-17: GOODIX_BERLIN_COOR_DATA_CHECKSUM
+	 * - bytes 24-25: Checksum
 	 * - bytes 18-25: Unused 8 bytes
 	 *
-	 * If 2 fingers are reported, we would have read the exact needed amount of
-	 * data and checkout would be at the end of the buffer:
-	 * - bytes 0-7:	  GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN
+	 * If 2 fingers are reported, we would have read the exact needed
+	 * amount of data and checksum would be at the end of the buffer:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
 	 * - bytes 8-15:  Finger 0 Bytes 0-7
 	 * - bytes 16-23: Finger 1 Bytes 0-7
-	 * - bytes 24-25: GOODIX_BERLIN_COOR_DATA_CHECKSUM
+	 * - bytes 24-25: Checksum
 	 *
-	 * If more than 2 fingers were reported, the "Checksum" bytes would in fact
-	 * contain part of the next finger data, and then we would complete the buffer
-	 * with the missing bytes, but by keeping the GOODIX_BERLIN_IRQ_READ_LEN(2)
-	 * size as base, it will still contain space for the final 2 bytes checksum:
-	 * - bytes 0-7:	  GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]
+	 * If more than 2 fingers were reported, the "Checksum" bytes would
+	 * in fact contain part of the next finger data, and then
+	 * goodix_berlin_get_remaining_contacts() would complete the buffer
+	 * with the missing bytes, including the trailing checksum.
+	 * For example, if 3 fingers are reported, then we would do:
+	 * Read 1:
+	 * - bytes 0-7:   Header (GOODIX_BERLIN_HEADER_SIZE)
 	 * - bytes 8-15:  Finger 0 Bytes 0-7
 	 * - bytes 16-23: Finger 1 Bytes 0-7
 	 * - bytes 24-25: Finger 2 Bytes 0-1
-	 * for example if 3 fingers are reported, (3 - 2) * 8 = 8 bytes would be read:
+	 * Read 2 (with length of (3 - 2) * 8 = 8 bytes):
 	 * - bytes 26-31: Finger 2 Bytes 2-7
-	 * - bytes 32-33: GOODIX_BERLIN_COOR_DATA_CHECKSUM
+	 * - bytes 32-33: Checksum
 	 */
-	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
-				GOODIX_BERLIN_IRQ_READ_LEN(2));
+	error = regmap_raw_read(cd->regmap, cd->touch_data_addr,
+				&cd->event,
+				GOODIX_BERLIN_HEADER_SIZE +
+					2 * GOODIX_BERLIN_TOUCH_SIZE +
+					GOODIX_BERLIN_CHECKSUM_SIZE);
 	if (error) {
 		dev_warn_ratelimited(cd->dev,
 				     "failed get event head data: %d\n", error);
-		return IRQ_HANDLED;
+		goto out;
 	}
 
-	if (buf[GOODIX_BERLIN_STATUS_OFFSET] == 0)
-		return IRQ_HANDLED;
+	if (cd->event.hdr.status == 0)
+		goto out;
 
-	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
+	if (!goodix_berlin_checksum_valid((u8 *)&cd->event.hdr,
+					  GOODIX_BERLIN_HEADER_SIZE)) {
 		dev_warn_ratelimited(cd->dev,
 				     "touch head checksum error: %*ph\n",
-				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
-		return IRQ_HANDLED;
+				     (int)GOODIX_BERLIN_HEADER_SIZE,
+				     &cd->event.hdr);
+		// FIXME: should we clear the status?
+		goto out;
 	}
 
-	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
-
-	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
-		goodix_berlin_touch_handler(cd, buf,
-					    GOODIX_BERLIN_IRQ_READ_LEN(2));
+	if (cd->event.hdr.status & GOODIX_BERLIN_TOUCH_EVENT)
+		goodix_berlin_touch_handler(cd);
 
-	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
-		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
+	if (cd->event.hdr.status & GOODIX_BERLIN_REQUEST_EVENT) {
+		switch (cd->event.hdr.request_type) {
 		case GOODIX_BERLIN_REQUEST_CODE_RESET:
 			if (cd->reset_gpio)
 				goodix_berlin_request_handle_reset(cd);
@@ -601,13 +588,14 @@ static irqreturn_t goodix_berlin_irq(int irq, void *data)
 
 		default:
 			dev_warn(cd->dev, "unsupported request code 0x%x\n",
-				 buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
+				 cd->event.hdr.request_type);
 		}
 	}
 
 	/* Clear up status field */
 	regmap_write(cd->regmap, cd->touch_data_addr, 0);
 
+out:
 	return IRQ_HANDLED;
 }
 

