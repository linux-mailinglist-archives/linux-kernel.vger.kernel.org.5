Return-Path: <linux-kernel+bounces-27081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E8B82EA16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429731C2304D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4711184;
	Tue, 16 Jan 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2UQs8Ku"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163010A3B;
	Tue, 16 Jan 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd6581bc66so2241604b6e.1;
        Mon, 15 Jan 2024 23:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705390474; x=1705995274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDF06Zzvqqqna3Wwn8GfbWo7pzcxs94u77eb9fZ1A8o=;
        b=X2UQs8KuPyl7EJ4JiaCjGp7JVwDPEaL+9vCScai3EzuBe3TgkIw/jTNsgSwIfI3oEJ
         gz7ydvxg7NCyU37cs7shcOvi33GTn9jLdtfd9eyQ/4iKptZtnlJRBQURrFP5nEPXroG6
         xhgtbD93ioq/txPlMlG6gqFBIWTic1/ffDrh6rtplOFqhtBbJtyaXgHsH5pi4fBqd6FN
         ZhOEAzCD1mhbKWKj+XqpKWQD0m9nKaB1n/wNBPd3/IcGaVame7kBX6yQbIj56GJ/lcmu
         5D/UdTNL3lMlFCVR/VAtMPMGdeAFmuhp3q01zBTXVjbaXaWtilV1HxRLJx5WhaBHbLA1
         wmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390474; x=1705995274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDF06Zzvqqqna3Wwn8GfbWo7pzcxs94u77eb9fZ1A8o=;
        b=YI8Y5GJWpXYp6axQJK01Ks4xbl0tsuBHNAaxayxYoHLy72TaZiHJdyTu3I/v7upEsd
         z+dF/5AxPYLhTsdiaQjrqI0upns1Uu9yG21EbwN3VR89PEBLdAwwqdCxr0TnpCl28hxR
         UNh23PCx7I/azq8GABWmgcKplllhQAPmfDBLMFmBgMy6qy1C9AV97eBOkyvvqR82FZ1L
         oMITgFhxkDwGtyaFVNERPMK4m6Hpkat8aXQUG7tPLK0/cRogiyvEAUIfgB6dv5f0K8vx
         FizgT4ve7iBRxad1GbQ2lOizs/LPSOdT9vh9KfGNRgguvWZnUrblpB0X3W3Cys6wi7lz
         UWWQ==
X-Gm-Message-State: AOJu0YycJz9yBY1yHInjxMT3X2Z8SyKGn2Fa+yMEDmFCX8wTe03fCloT
	YZgPdkRzObdVF/5kVqUR7swGzeawQuI=
X-Google-Smtp-Source: AGHT+IE4a+szMrr9YrG276Q+kgmVzCPxfIm3ZQaGJrfA4lKonmVAAHO1UVjrnBulAwpG9tiWvXUmkQ==
X-Received: by 2002:a05:6808:14c5:b0:3bd:38c1:fdec with SMTP id f5-20020a05680814c500b003bd38c1fdecmr8930182oiw.67.1705390473870;
        Mon, 15 Jan 2024 23:34:33 -0800 (PST)
Received: from amiden.localdomain ([2402:e280:2243:161:fb91:1080:2d1d:9736])
        by smtp.gmail.com with ESMTPSA id m11-20020a62f20b000000b006daa809584csm8526886pfh.182.2024.01.15.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:34:33 -0800 (PST)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: pavel@ucw.cz
Cc: lee@kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH] leds/pca963x: implement power management
Date: Tue, 16 Jan 2024 13:04:21 +0530
Message-ID: <20240116073421.395547-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements power management in upstream driver
for pca9633 which enables device sleep and resume
on system-wide sleep/hibernation

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 drivers/leds/leds-pca963x.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 47223c850e4b..a5804989d756 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -39,6 +39,7 @@
 #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
 #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
 
+#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode, oscillator off */
 #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
 #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
 #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
@@ -380,6 +381,38 @@ static int pca963x_register_leds(struct i2c_client *client,
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pca963x_suspend(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg | (1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static int pca963x_resume(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg & ~(1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);
+
 static const struct of_device_id of_pca963x_match[] = {
 	{ .compatible = "nxp,pca9632", },
 	{ .compatible = "nxp,pca9633", },
@@ -430,6 +463,7 @@ static struct i2c_driver pca963x_driver = {
 	.driver = {
 		.name	= "leds-pca963x",
 		.of_match_table = of_pca963x_match,
+		.pm = &pca963x_pm
 	},
 	.probe = pca963x_probe,
 	.id_table = pca963x_id,
-- 
2.43.0


