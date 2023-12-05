Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB7804364
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjLEA27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLEA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:28:58 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B16101;
        Mon,  4 Dec 2023 16:29:03 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso3825438a12.1;
        Mon, 04 Dec 2023 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701736142; x=1702340942; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYFStRIWRlj/QILybfgb1W+iLOYRyfcARjHaKVjDLvA=;
        b=nO5c+UScJj1/rlpxKQE2qV5f1stWave0s1/vvIT70fbWnrEJ56Ew9mhA2VNHl6dwow
         2Wrr7gFj1hpAmEYYiqt9bSftVFjPNmGSQqUzANSnCHPZ18KhdWQXG7h9lVOwDLq2TvZH
         ZdVKxjUUCTykbfGmq5sijiBuziY1zJ8V3eyL1lRDxZR9MOH7uNOixOAmn4DyWouIN0LE
         IvB1Jb7HZ8+5IyBhzvtntc6Nj2XgvLTzEwj0wAJ23RjWYxmJXKY54cxS1UZy1WhMbmu/
         CNwWjap02QF7Pa/40pxDxWrwCWJKDmtT51aicbzQ+2qSqLzwNGI+1+K2ZZIRB3yEXsgx
         rQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701736142; x=1702340942;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYFStRIWRlj/QILybfgb1W+iLOYRyfcARjHaKVjDLvA=;
        b=ufyjMrOaXL2pCqNvCbKA/7pSKriUpFuCi1wRqmMNVGpPa+eZKrPlGjqRianm6cukgm
         kDmITfsGeJ4M73SU//uOJywBVa7u1Ky0iodsAFgyPJxGGnxpzWp79YeMGzYQ6R8RVhI2
         1TgSRENU7ffjKUAfi+xP54bqfM8M5XR72JrTHpMTtBg+VYFVF1BXFzj6Qa23k0EvERog
         rg3TZNhxOSrkfeRP2PHaep/hyg5gE+T9eRCl54rsUXlTLaH1uBlBRVBoIidgUpV+1SIF
         QE8Vzzrn5Jz6wXm9DXL3QNgBkTqE5aFPTrx0j6SgjkQ8uWggXmqQGhHgeH9GFEowPMRy
         j36w==
X-Gm-Message-State: AOJu0YxcALjpJwtPFgT2p99N4W73VdUltC1OvAEf/UMhJxp2SHDN/gL6
        88IrdOGSlVn0I+Z+nbOslMGUTUX0tqGbew==
X-Google-Smtp-Source: AGHT+IEj9Umsd3PUbdGXxl3OuqPY7wsCwAoo3OQ2Pe3rIve1EVGj/QiUONp6cNdc8gwDWpotvjoplg==
X-Received: by 2002:a50:8acf:0:b0:54c:5d34:980c with SMTP id k15-20020a508acf000000b0054c5d34980cmr210099edk.82.1701736141742;
        Mon, 04 Dec 2023 16:29:01 -0800 (PST)
Received: from localhost (86-83-145-178.fixed.kpn.net. [86.83.145.178])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402150400b0054c9df4317dsm370226edw.7.2023.12.04.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:29:01 -0800 (PST)
Date:   Tue, 5 Dec 2023 01:28:54 +0100
From:   laburnumT <laburnumtec@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: fix coding style camelCase issue
Message-ID: <20231205002854.76niknoiakdraruc@flo-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed camelCase issues in ddk750_sii164.c and impacted files.

Signed-off-by: laburnumT <laburnumtec@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    |  16 +--
 drivers/staging/sm750fb/ddk750_sii164.c | 130 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_sii164.h |  16 +--
 3 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..40d92e4bd1f9 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,15 +16,15 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 	{
 		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164GetDeviceID,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
-		.get_chip_string = sii164GetChipString,
-		.set_power = sii164SetPower,
-		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
-		.is_connected = sii164IsConnected,
-		.check_interrupt = sii164CheckInterrupt,
-		.clear_interrupt = sii164ClearInterrupt,
+		.reset_chip = sii164_reset_chip,
+		.get_chip_string = sii164_get_chip_string,
+		.set_power = sii164_set_power,
+		.enable_hot_plug_detection = sii164_enable_hotplug_detection,
+		.is_connected = sii164_is_connected,
+		.check_interrupt = sii164_check_interrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..596a00101352 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -25,7 +25,7 @@
 
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
+static char *g_dvi_ctrl_chip_name = "Silicon Image SiI 164";
 #endif
 
 /*
@@ -37,33 +37,33 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
  */
 unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor_id;
 
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_VENDOR_ID_LOW);
+	vendor_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_VENDOR_ID_HIGH) << 8) |
+		    (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+					       SII164_VENDOR_ID_LOW);
 
-	return vendorID;
+	return vendor_id;
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
-	unsigned short deviceID;
+	unsigned short device_id;
 
-	deviceID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_DEVICE_ID_LOW);
+	device_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_DEVICE_ID_HIGH) << 8) |
+		    (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+					       SII164_DEVICE_ID_LOW);
 
-	return deviceID;
+	return device_id;
 }
 
 /*
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -250,41 +250,41 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
-	sii164SetPower(0);
-	sii164SetPower(1);
+	sii164_set_power(0);
+	sii164_set_power(1);
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
-	return gDviCtrlChipName;
+	return g_dvi_ctrl_chip_name;
 }
 
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
- *      powerUp - Flag to set the power down or up
+ *      power_up - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char power_up)
 {
 	unsigned char config;
 
 	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
+	if (power_up == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
@@ -298,109 +298,109 @@ void sii164SetPower(unsigned char powerUp)
 }
 
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hotplug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
+void sii164_select_hotplug_detection_mode(enum sii164_hot_plug_mode hotplug_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	detect_reg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
+	switch (hotplug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hotplug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
+ *  enable_hotplug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hotplug_detection(unsigned char enable_hotplug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+	if (enable_hotplug != 0)
+		sii164_select_hotplug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hotplug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
-	unsigned char hotPlugValue;
+	unsigned char hotplug_value;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
+	hotplug_value = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+			SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	if (hotplug_value == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
+	detect_reg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     SII164_DETECT_MONITOR_STATE_MASK;
+	if (detect_reg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+		    detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..52c087a15095 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,16 +28,16 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
-char *sii164GetChipString(void);
-void sii164SetPower(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-unsigned char sii164IsConnected(void);
-unsigned char sii164CheckInterrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_reset_chip(void);
+char *sii164_get_chip_string(void);
+void sii164_set_power(unsigned char power_up);
+void sii164_enable_hotplug_detection(unsigned char enable_hotplug);
+unsigned char sii164_is_connected(void);
+unsigned char sii164_check_interrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
-- 
2.34.1

