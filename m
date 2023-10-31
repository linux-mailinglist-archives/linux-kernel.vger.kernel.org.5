Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D957DCCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjJaMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbjJaMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:10:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84E1A7;
        Tue, 31 Oct 2023 05:09:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7d9d357faso54935087b3.0;
        Tue, 31 Oct 2023 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698754196; x=1699358996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i16ze8qfWztv7zzhvp20b0+Cbubm21cnau1mhZhq2JU=;
        b=WC20B98pZL6Di+iROgBT0i0d/om8rUr/80tnQYTCkvM/EObMO2HmmXgq0WY6Y657km
         SV8CYI3PrmC0O2/TFDlVqFJ1nvJa0GL2fdAGKo89aGZc+SMHH8d78GMnjgMWf6fvwOnH
         ufEM87dm5YxjmBa863C70CdP3i0/pobrKFJLPAzC1EpRxHA6m9+1R08S5zJ2HQw2wwZe
         6r+bNJpxkym5Jks/s2QnR6Wm/CytM5XmKkZqFz9+Qzl+SiX4MiPF6XgxgEeeUsd1JI0s
         Vtq3W2qo7+rb/lZv513lAb6JkcqxBLrU4etZuCOGKb1En1TZQdCnslV4CqE7H8FQrRva
         z8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698754196; x=1699358996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i16ze8qfWztv7zzhvp20b0+Cbubm21cnau1mhZhq2JU=;
        b=QQg+Q/6DQQmzCXxq6fHDViDL+sCQOBgN2nVjfwYMlQlpBGNCJmUaPZI0oJBq4KAU8/
         skF3JlgGx82CfQ5mndrj+XnaMk/ciyFjX9nT833BHHQbV7jqUUqdtxzt//T/rnmzhj5H
         LUhXKrMKUprfo3rcZTiTUysIUDfe29ZqqxkYT4AX/7WZknW2BMASEk0UXqAvr6tbKxDe
         dCKnUqBxmkRz2af/RL4R5WwXUA5zq+Mj+maqRElrQHLWQsjqkY2G91MXu4xzveo+g5oA
         yBz/lxDCebPuMVB9MU1aQYQrgvrU13KAb3SypGdW0/9G5Njq9iCNAB0Hjd9SJ//UmzUm
         vyHQ==
X-Gm-Message-State: AOJu0YxyMfRTvQ5EOsP+9rx4OZLN6cgIzDH0K2tXefqxUWV/GP7L0pSI
        GCkjQ3VZ0j2x8Nkkf/Y75HEEAYExvrnJwg==
X-Google-Smtp-Source: AGHT+IFQjjPzleVSBcLEIqFiBfVuqFBxVQFIZCHQbIDOseEQh41ru+rWXDnLXRL2xxy2ejngL+EDMg==
X-Received: by 2002:a81:c608:0:b0:5ac:fe2d:5edf with SMTP id l8-20020a81c608000000b005acfe2d5edfmr10903984ywi.44.1698754196322;
        Tue, 31 Oct 2023 05:09:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:59c8:6244:7600::e27])
        by smtp.gmail.com with ESMTPSA id f186-20020a0dc3c3000000b00559f1cb8444sm703833ywd.70.2023.10.31.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:09:55 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        dober@lenovo.com, mpearson@lenovo.com,
        David Ober <dober6023@gmail.com>
Subject: [PATCH v2] hwmon:Add MEC172x Micro Chip driver for Lenovo motherboards
Date:   Tue, 31 Oct 2023 08:09:42 -0400
Message-Id: <20231031120942.4404-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addition adds in the ability for the system to scan the
MEC172x EC chip in Lenovo ThinkStation systems to get the
current fan RPM speeds and the Maximum speed value for each
fan also provides the current CPU and DIMM thermal status

Signed-off-by: David Ober <dober6023@gmail.com>

v2 fixed mixcased naming
v2 add mutex protection
v2 removed references to ACPI as it is not used
v2 added comment to explain why returning a -1 is needed
---
 drivers/hwmon/lenovo-ec-sensors.c | 81 ++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
index acf26ed4c96b..e2b14b3aea08 100644
--- a/drivers/hwmon/lenovo-ec-sensors.c
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -32,8 +32,8 @@
 #define MCHP_EMI0_EC_DATA_BYTE2		0x0906
 #define MCHP_EMI0_EC_DATA_BYTE3		0x0907
 
-#define IoWrite8(a, b)	outb_p(b, a)
-#define IoRead8(a)	inb_p(a)
+#define io_write8(a, b)	outb_p(b, a)
+#define io_read8(a)	inb_p(a)
 
 static inline uint8_t
 get_ec_reg(unsigned char page, unsigned char index)
@@ -42,31 +42,31 @@ get_ec_reg(unsigned char page, unsigned char index)
 	unsigned short m_index;
 	unsigned short phy_index = page * 256 + index;
 
-	if (IoRead8(MCHP_EMI0_APPLICATION_ID) != 0) /* EMI access locked */
-		return false;
+	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) /* EMI access locked */
+		return -1;
 
-	IoWrite8(MCHP_EMI0_APPLICATION_ID, 0x01);
+	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
 
 	m_index = phy_index & 0x7FFC;
-	IoWrite8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
-	IoWrite8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
+	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
+	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
 
 	switch (phy_index & 0x0003) {
 	case 0:
-		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE0);
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0);
 		break;
 	case 1:
-		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE1);
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE1);
 		break;
 	case 2:
-		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE2);
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE2);
 		break;
 	case 3:
-		onebyte = IoRead8(MCHP_EMI0_EC_DATA_BYTE3);
+		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE3);
 		break;
 	}
 
-	IoWrite8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */
+	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */
 	return onebyte;
 }
 
@@ -190,19 +190,22 @@ static const char * const p7_amd_ec_fan_label[] = {
 };
 
 struct ec_sensors_data {
+	struct mutex mec_mutex; /* lock for sensors write */
 	u8 platform_id;
 	const char *const *fan_labels;
 	const char *const *temp_labels;
 };
 
 static int
-lenovo_ec_do_read_temp(u32 attr, int channel, long *val)
+lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
 {
 	u8   LSB;
 
 	switch (attr) {
 	case hwmon_temp_input:
+		mutex_lock(&data->mec_mutex);
 		LSB = get_ec_reg(2, 0x81 + channel);
+		mutex_unlock(&data->mec_mutex);
 		if (LSB > 0x40) {
 			*val = (LSB - 0x40) * 1000;
 		} else {
@@ -217,28 +220,36 @@ lenovo_ec_do_read_temp(u32 attr, int channel, long *val)
 }
 
 static int
-lenovo_ec_do_read_fan(u32 attr, int channel, long *val)
+lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
 {
 	u8    LSB, MSB;
 
 	channel *= 2;
 	switch (attr) {
 	case hwmon_fan_input:
+		mutex_lock(&data->mec_mutex);
 		LSB = get_ec_reg(4, 0x60 + channel);
 		MSB = get_ec_reg(4, 0x61 + channel);
+		mutex_unlock(&data->mec_mutex);
 		if ((MSB << 8) + LSB != 0) {
+			mutex_lock(&data->mec_mutex);
 			LSB = get_ec_reg(4, 0x20 + channel);
 			MSB = get_ec_reg(4, 0x21 + channel);
+			mutex_unlock(&data->mec_mutex);
 			*val = (MSB << 8) + LSB;
 			return 0;
 		}
-		return -1;
+		return -1; /* Returning -1 here has the sensors tool mark the FAN speed as N/A */
 	case hwmon_fan_max:
+		mutex_lock(&data->mec_mutex);
 		LSB = get_ec_reg(4, 0x60 + channel);
 		MSB = get_ec_reg(4, 0x61 + channel);
+		mutex_unlock(&data->mec_mutex);
 		if ((MSB << 8) + LSB != 0) {
+			mutex_lock(&data->mec_mutex);
 			LSB = get_ec_reg(4, 0x40 + channel);
 			MSB = get_ec_reg(4, 0x41 + channel);
+			mutex_unlock(&data->mec_mutex);
 			*val = (MSB << 8) + LSB;
 		} else {
 			*val = 0;
@@ -254,14 +265,16 @@ lenovo_ec_do_read_fan(u32 attr, int channel, long *val)
 	return -EOPNOTSUPP;
 }
 
-static int get_platform(void)
+static int get_platform(struct ec_sensors_data *data)
 {
 	char system_type[6];
 	int ret = -1;
 	int idx;
 
 	for (idx = 0 ; idx < 6 ; idx++)
+		mutex_lock(&data->mec_mutex);
 		system_type[idx] = get_ec_reg(0xC, (0x10 + idx));
+		mutex_unlock(&data->mec_mutex);
 
 	for (idx = 0 ; idx < 4 ; idx++) {
 		if (strcmp(systems[idx], system_type) == 0) {
@@ -296,11 +309,13 @@ static int
 lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
+	struct ec_sensors_data *data = dev_get_drvdata(dev);
+
 	switch (type) {
 	case hwmon_temp:
-		return lenovo_ec_do_read_temp(attr, channel, val);
+		return lenovo_ec_do_read_temp(data, attr, channel, val);
 	case hwmon_fan:
-		return lenovo_ec_do_read_fan(attr, channel, val);
+		return lenovo_ec_do_read_fan(data, attr, channel, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -312,9 +327,6 @@ static umode_t
 lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 			   u32 attr, int channel)
 {
-	//if (type != hwmon_fan)
-//		return 0;
-
 	switch (type) {
 	case hwmon_temp:
 		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
@@ -393,17 +405,19 @@ static int lenovo_ec_probe(struct platform_device *pdev)
 
 	chip_info = &lenovo_ec_chip_info;
 
-	if (IoRead8(0x90C) != 0) {               /* check EMI Application BIT */
-		IoWrite8(0x90C, IoRead8(0x90C)); /* set EMI Application BIT to 0 */
+	mutex_lock(&ec_data->mec_mutex);
+	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) { /* check EMI Application BIT */
+		io_write8(0x90C, io_read8(0x90C)); /* set EMI Application BIT to 0 */
 	}
-	IoWrite8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
-	IoWrite8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
-
-	if ((IoRead8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
-	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
-	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
-	    (IoRead8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {
-		ec_data->platform_id = get_platform();
+	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
+	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
+	mutex_unlock(&ec_data->mec_mutex);
+
+	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
+	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {
+		ec_data->platform_id = get_platform(ec_data);
 		switch (ec_data->platform_id) {
 		case 0:
 			ec_data->fan_labels = px_ec_fan_label;
@@ -431,9 +445,8 @@ static int lenovo_ec_probe(struct platform_device *pdev)
 							     chip_info, NULL);
 
 		return PTR_ERR_OR_ZERO(hwdev);
-	} else {
-		return -ENODEV;
 	}
+	return -ENODEV;
 }
 
 static struct platform_driver lenovo_ec_sensors_platform_driver = {
@@ -467,5 +480,5 @@ module_init(lenovo_ec_init);
 module_exit(lenovo_ec_exit);
 
 MODULE_AUTHOR("David Ober <dober@lenovo.com>");
-MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors accessible via ACPI on LENOVO motherboards");
+MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors on LENOVO motherboards");
 MODULE_LICENSE("GPL");
-- 
2.34.1

