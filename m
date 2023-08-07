Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA18772CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjHGRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHGRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:23:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53C1A4;
        Mon,  7 Aug 2023 10:23:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0c566788so7404742e87.0;
        Mon, 07 Aug 2023 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429029; x=1692033829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SfjDebAj1o0CQb+7Qag/JvPg20rDm+7MFCObVpSym8=;
        b=JWHTNpG8lWftkL0YgXovsihGiRdW1OkejtUiFahHps6yTVkf2NekkGZIpmp12BHOmc
         jwpie7/PFTKJNklFuBJnaVDwsXpzjwD9hXKOfrgqUMpucbObIIg90CzFS2e3fU9Co8lW
         sFy/STnq6WeeJdR26T1En8/mg0eJWlJqepID5mXpgFcH9ngdM3oTe1OuYW5GmqUA3uvw
         IiXU/gnqT2bfJ1YzvP8tHBKP7R+2gvP8/3HOO1NO/ihpR6+63sLa74fD9kkT20LKlN2x
         Si7GFT6oXGfsIodu+ixj3UzdMOXg/3g6b6FIYM/zQOrzD1y9hrlZcmAvjZJBzfchUr+I
         q4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429029; x=1692033829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SfjDebAj1o0CQb+7Qag/JvPg20rDm+7MFCObVpSym8=;
        b=c9X77QukmPlxEm7a6x9vdPJdAmetZCUlAzrFSoZ0OGrkAWUMki77ZjG+T7uaYOtkEz
         3tFF2kzX6YRXRsPjsM94xjuempxqRYHLYEN7MYI3w5f90g7LX/KhrARHscn87rYitliF
         PuNBbdLybqz52gp3gCsku9Dn2OmSmO4V/Cw2jS1CVtcIypvsCeqVKC6BKs2uI3YQPGvu
         tN5tIld7L/QqksyUwImSIWUvbjEuAtPkPXeSgak9Hn27tky843+d972XwdGsA4L2qJ38
         VGoo2yuQ0BxZkEsTiEaZdzb9F93fNUSJzFSmUPS7lYwqyZyIs/6l1Ui9el9tnmKbxwx8
         nIhg==
X-Gm-Message-State: AOJu0YzmCpVk0W+tQc/MlMIToAnevSO5mptK4H9LTTlvIwBhTIXodp9m
        2N6+t2JcfMeKa2cJERsISwDqhPoaDcBiDQ==
X-Google-Smtp-Source: AGHT+IFhVr55/oPjwIc5uw4c05ngZet8sX/zl9yVM3STZ7uwBv0qu6MHpI0t6+JTF2/cnk1FzW7eoQ==
X-Received: by 2002:ac2:57cb:0:b0:4f8:6c1f:b1ab with SMTP id k11-20020ac257cb000000b004f86c1fb1abmr5551627lfo.27.1691429029092;
        Mon, 07 Aug 2023 10:23:49 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id h23-20020a1709067cd700b00992f309cfe8sm5532752ejp.178.2023.08.07.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:23:48 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
Date:   Mon,  7 Aug 2023 19:20:03 +0200
Message-ID: <20230807172004.456968-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 200ms delay after sending a ctrl report to Quadro,
Octo, D5 Next and Aquaero to give them enough time to
process the request and save the data to memory. Otherwise,
under heavier userspace loads where multiple sysfs entries
are usually set in quick succession, a new ctrl report could
be requested from the device while it's still processing the
previous one and fail with -EPIPE. The delay is only applied
if two ctrl report operations are near each other in time.

Reported by a user on Github [1] and tested by both of us.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82

Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v3:
- Reworked code to track the last time of a ctrl report
  operation and only delay if necessary, as per suggestion

Changes in v2:
- Added missing <linux/delay.h> include
---
 drivers/hwmon/aquacomputer_d5next.c | 37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a997dbcb563f..023807859be7 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -13,9 +13,11 @@
 
 #include <linux/crc16.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
@@ -63,6 +65,8 @@ static const char *const aqc_device_names[] = {
 #define CTRL_REPORT_ID			0x03
 #define AQUAERO_CTRL_REPORT_ID		0x0b
 
+#define CTRL_REPORT_DELAY		200	/* ms */
+
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
  */
@@ -527,6 +531,9 @@ struct aqc_data {
 	int secondary_ctrl_report_size;
 	u8 *secondary_ctrl_report;
 
+	ktime_t last_ctrl_report_op;
+	int ctrl_report_delay;	/* Delay between two ctrl report operations, in ms */
+
 	int buffer_size;
 	u8 *buffer;
 	int checksum_start;
@@ -611,17 +618,35 @@ static int aqc_aquastreamxt_convert_fan_rpm(u16 val)
 	return 0;
 }
 
+static void aqc_delay_ctrl_report(struct aqc_data *priv)
+{
+	/*
+	 * If previous read or write is too close to this one, delay the current operation
+	 * to give the device enough time to process the previous one.
+	 */
+	if (priv->ctrl_report_delay) {
+		s64 delta = ktime_ms_delta(ktime_get(), priv->last_ctrl_report_op);
+
+		if (delta < priv->ctrl_report_delay)
+			msleep(priv->ctrl_report_delay - delta);
+	}
+}
+
 /* Expects the mutex to be locked */
 static int aqc_get_ctrl_data(struct aqc_data *priv)
 {
 	int ret;
 
+	aqc_delay_ctrl_report(priv);
+
 	memset(priv->buffer, 0x00, priv->buffer_size);
 	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		ret = -ENODATA;
 
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -631,6 +656,8 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	int ret;
 	u16 checksum;
 
+	aqc_delay_ctrl_report(priv);
+
 	/* Checksum is not needed for Aquaero */
 	if (priv->kind != aquaero) {
 		/* Init and xorout value for CRC-16/USB is 0xffff */
@@ -646,12 +673,16 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	if (ret < 0)
-		return ret;
+		goto record_access_and_ret;
 
 	/* The official software sends this report after every change, so do it here as well */
 	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
 				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+record_access_and_ret:
+	priv->last_ctrl_report_op = ktime_get();
+
 	return ret;
 }
 
@@ -1524,6 +1555,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
 		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -1547,6 +1579,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 
@@ -1597,6 +1630,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 
@@ -1624,6 +1658,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
+		priv->ctrl_report_delay = CTRL_REPORT_DELAY;
 
 		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
-- 
2.41.0

