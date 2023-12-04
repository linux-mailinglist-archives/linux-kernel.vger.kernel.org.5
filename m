Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED766804295
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjLDXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjLDXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:34:04 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635DC3;
        Mon,  4 Dec 2023 15:34:09 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so31628721fa.3;
        Mon, 04 Dec 2023 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701732847; x=1702337647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaLwUM/X6BTpPGziK4zF0Fhh5e9dkHy8RdQ/gNBLN5s=;
        b=mDEHGgrYRW9BnEqBKyCt4vn5SLUPYQ8UXdbK20/UYx+CQTyb8/NLTnYAjIDUchLsAx
         Ibc4rUvd6OBW5Yyj5VuQJJwrUUQ7PGJd2Lyh7XSOigr2nMGpQXFPdmfLhhEXRYtuaG2S
         GOGp2K0afUdWSgYTV4RnhMS0U0XCGO1/iimbLVLhSvDyRP+XvKh76pBATzLWNLZlWCyN
         99jScIAOsr77anaV9Ynss+M6dqlUlKfl4rQH7UU/gI1WSg4AiBZuHup0n70l6tpUKzsH
         SAqR0Iw0/Ppl3/gZqSdYdomkuNsVU4H7r7H8KobpQzru09wxPwBp0dF7e66SBfXYoF++
         KnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701732847; x=1702337647;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaLwUM/X6BTpPGziK4zF0Fhh5e9dkHy8RdQ/gNBLN5s=;
        b=XKQ0QKbHcXbQlZhdJq1ma3zhC99FWowLHUNpVpKweBYIwGTgp4CROSdE15Axg1R0W0
         5sJlsm027RRHWvwosrWQfPvRV3htmhtlXfCCxM3EghFNg3rvJ58Xof42buG/5kyV/Fo2
         qZd+IhjWHRbdq82Y1APDn7WabmwLUlmj//GXgtnHU2DJVjhFr9wnoFEpbe5VJAhjeW/N
         EtOeNebPy4xp/mMrKVqwBfcgVwzXy967VmcMkOio+TZNu/nz6jUDPIC0EpdkDAprQISX
         dqvTWG4xj9CWX377XsUPq2+hl1ucNpnynFveZ8euWHNL4iKzwPZ+PP3fy2W6056lnHvK
         VFRg==
X-Gm-Message-State: AOJu0YzGB9NTaYotuTyrXj2xr2rHSXfQCZFEMY6sLhkKWkhK8BC19h0j
        WRkp8xLepFVpClk44uEN3xCyyDNBhvL69g==
X-Google-Smtp-Source: AGHT+IG1kI3tcjDICa5UlVodr+K6x5G4TeGugcFIxrGcLidlC2Bh+3pWukfuyz54nhAU360PrzdAhQ==
X-Received: by 2002:a2e:9184:0:b0:2c9:f7d3:7d61 with SMTP id f4-20020a2e9184000000b002c9f7d37d61mr1683049ljg.82.1701732847164;
        Mon, 04 Dec 2023 15:34:07 -0800 (PST)
Received: from localhost (86-83-145-178.fixed.kpn.net. [86.83.145.178])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b009b2cc87b8c3sm5774701ejh.52.2023.12.04.15.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 15:34:06 -0800 (PST)
From:   laburnumT <laburnumtec@gmail.com>
X-Google-Original-From: laburnumT <laburnumTec@gmail.com>
Date:   Tue, 5 Dec 2023 00:34:04 +0100
To:     gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: fix coding style camelCase issue
Message-ID: <20231204233404.goxljpo2jpwlotig@flo-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="votmzjuwq6leiwsp"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--votmzjuwq6leiwsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixed camelCase issues in ddk750_sii164.c and impacted files.

Signed-off-by: laburnumT <laburnumTec@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    |  16 +--
 drivers/staging/sm750fb/ddk750_sii164.c | 130 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_sii164.h |  16 +--
 3 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb=
/ddk750_dvi.c
index 8b81e8642f9e..40d92e4bd1f9 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,15 +16,15 @@ static struct dvi_ctrl_device dcft_supported_dvi_contro=
ller[] =3D {
 	{
 		.init =3D sii164_init_chip,
 		.get_vendor_id =3D sii164_get_vendor_id,
-		.get_device_id =3D sii164GetDeviceID,
+		.get_device_id =3D sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip =3D sii164ResetChip,
-		.get_chip_string =3D sii164GetChipString,
-		.set_power =3D sii164SetPower,
-		.enable_hot_plug_detection =3D sii164EnableHotPlugDetection,
-		.is_connected =3D sii164IsConnected,
-		.check_interrupt =3D sii164CheckInterrupt,
-		.clear_interrupt =3D sii164ClearInterrupt,
+		.reset_chip =3D sii164_reset_chip,
+		.get_chip_string =3D sii164_get_chip_string,
+		.set_power =3D sii164_set_power,
+		.enable_hot_plug_detection =3D sii164_enable_hotplug_detection,
+		.is_connected =3D sii164_is_connected,
+		.check_interrupt =3D sii164_check_interrupt,
+		.clear_interrupt =3D sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm75=
0fb/ddk750_sii164.c
index 2532b60245ac..596a00101352 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -25,7 +25,7 @@
=20
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName =3D "Silicon Image SiI 164";
+static char *g_dvi_ctrl_chip_name =3D "Silicon Image SiI 164";
 #endif
=20
 /*
@@ -37,33 +37,33 @@ static char *gDviCtrlChipName =3D "Silicon Image SiI 16=
4";
  */
 unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor_id;
=20
-	vendorID =3D ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_VENDOR_ID_LOW);
+	vendor_id =3D ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_VENDOR_ID_HIGH) << 8) |
+		    (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+					       SII164_VENDOR_ID_LOW);
=20
-	return vendorID;
+	return vendor_id;
 }
=20
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
=20
-	deviceID =3D ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_DEVICE_ID_LOW);
+	device_id =3D ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_DEVICE_ID_HIGH) << 8) |
+		    (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+					       SII164_DEVICE_ID_LOW);
=20
-	return deviceID;
+	return device_id;
 }
=20
 /*
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
=20
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() =3D=3D SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() =3D=3D SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() =3D=3D SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -250,41 +250,41 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
=20
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
=20
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Contro=
ller
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
=20
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller C=
hip.
  *
  *  Input:
- *      powerUp - Flag to set the power down or up
+ *      power_up - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char power_up)
 {
 	unsigned char config;
=20
 	config =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp =3D=3D 1) {
+	if (power_up =3D=3D 1) {
 		/* Power up the chip */
 		config &=3D ~SII164_CONFIGURATION_POWER_MASK;
 		config |=3D SII164_CONFIGURATION_POWER_NORMAL;
@@ -298,109 +298,109 @@ void sii164SetPower(unsigned char powerUp)
 }
=20
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hotplug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMod=
e)
+void sii164_select_hotplug_detection_mode(enum sii164_hot_plug_mode hotplu=
g_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
=20
-	detectReg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	detect_reg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
+	switch (hotplug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &=3D ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |=3D SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &=3D ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |=3D SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |=3D SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
=20
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
=20
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hotplug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=3D1) / disable (=3D0) Hot Plug detection
+ *  enable_hotplug   - Enable (=3D1) / disable (=3D0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hotplug_detection(unsigned char enable_hotplug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
=20
-	detectReg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
=20
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug !=3D 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+	if (enable_hotplug !=3D 0)
+		sii164_select_hotplug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hotplug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
=20
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
=20
-	hotPlugValue =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue =3D=3D SII164_DETECT_HOT_PLUG_STATUS_ON)
+	hotplug_value =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+			SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	if (hotplug_value =3D=3D SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
 }
=20
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
=20
-	detectReg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg =3D=3D SII164_DETECT_MONITOR_STATE_CHANGE)
+	detect_reg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     SII164_DETECT_MONITOR_STATE_MASK;
+	if (detect_reg =3D=3D SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
 }
=20
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
=20
 	/* Clear the MDI interrupt */
-	detectReg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg =3D i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+		    detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
=20
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm75=
0fb/ddk750_sii164.h
index 71a7c1cb42c4..52c087a15095 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,16 +28,16 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
=20
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
=20
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
--=20
2.34.1


--votmzjuwq6leiwsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZG3C7x3FyKMfkYRK/mAkXmbbWfsFAmVuYesACgkQ/mAkXmbb
Wftq4w//diGE37qR6yPqybaxRK+dT3BPFKnKLJP414ptv8vERlEZcoXmRGAyN0br
9aI786ddeXQ/79KGZAd1U/gkKmY+wG0WFXDFWL3itbJL1z4juoJ2ZyPP6x+3orec
KqwNKnpzySC44e/HHw4hrQFnfYsazlenRUjpBysqQrTBH7RmbnHL6DAds89Z18Pi
uPM8ynd6OX+FLGNV2XFuI/YgTfAE3t5u8a75dn8F1q8jfGCea/krpTtnNdhbV3BS
UZjZWeYkz+Hg5cLVOx8bKjo/QvJjdr97dBcaIXTMV9TzLFEIU/LG0WooTqwigFvp
yH1BgTm1jCmHkxg73ywh9x2oaOCYwbDdFfxAUgzqKy3daKY9RTyP72xwqcP2u1bI
FAZWAAPAoXkjxCUNPW3i7DwR77QtPQ/Yz/BOZ/HlJZRBEbmf6rc9JYgmEzne+rdi
LEvuAPoI420gTGcodOGwEsBX7ztirh+6QzLs8GcUrDzilUy6iF4XRIy3dkBf/pyz
AxsvXNlzd0EYzeSotp9Qh1vS6k36lNFle8DLOXiDlqRLeK8P0ElOsdQtRISfi3O1
Y03bnb59tD4XrQOyVaJ+YU1r/wBBwUcSiUCmmbu/VkB6wuZz3LIvwEp6GFD1Etjo
Rqm4AChrjrftTGh9kkPaFkrEqI0fhuVRrOzUsbS9KHnegB7TQMU=
=x71A
-----END PGP SIGNATURE-----

--votmzjuwq6leiwsp--
