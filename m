Return-Path: <linux-kernel+bounces-51181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38D84876D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FCB24A62
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0495F873;
	Sat,  3 Feb 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gekoZkpy"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADF5F848;
	Sat,  3 Feb 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977538; cv=none; b=NAEPahyGyza/VpQIH8btmOV5qNPMXMxZQ8yQcZRnaOHMnoiiUErxOFXlRwj71+NPTs4Mx4k/HVGkY4LDgEVrFupApOtzosf8unzWS7OX/pbpRjmzVUsNe42f6s6m+ksyfvlDjKKpBILl0vGO1wpBbkkI9EAq42YyCtjLTZ18VZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977538; c=relaxed/simple;
	bh=ss8RClTJALLtRnsGtN1dO1Gt0LzZwyG8LN2tBScIzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3TWev9KeBdHeyGQd73B1XHodIYli2uGTb90HoZ1PDoCDxnm+UhFi8FsdeWeFCmJ8Jx0RpnHrNdaPTBIX281iANNE3mWKJA+HRyAUgSfvNuFzrWJqeVHYKHbPtr2MoxhWwA/klJAZBF1S/vfUoP4XgP9iUSzQi+ydVUgJ0bPAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gekoZkpy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29661facbd0so447839a91.1;
        Sat, 03 Feb 2024 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706977536; x=1707582336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToPL14RSULT7QbGvlmdx27Bs8DTvWoRTeHF6hY0RNjY=;
        b=gekoZkpyc67VCdNKSwj9756QITA2R6H/JFJVrVxhz1Q6Dfkp3EPtJErAVvZHK2cPMM
         GJvxYaHOyKLiq11E2ENKTRwdwckqHhm+G6i7tvc7LZ6DKbJbONanIEk7GyaEr6M7Y0F+
         mxGHRoBTWsjJaFw6UAU8e556fEa7ExlLPG2i75AfkuYfh85r5sUIZFJyRISMCeVJENpp
         Rrgsb+uKd84QHJVR3UWLpxN0RfAIcX/XydgIlevuZoCiKzbEq5QiMwyP3yy8RoFe5CAO
         j3aHp+dhdX2U3WcWzR1cPZRYZX2yuS+D7QBvjnyqfsyESYaOI3+HN32mY7p1lee0UD9b
         cYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706977536; x=1707582336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToPL14RSULT7QbGvlmdx27Bs8DTvWoRTeHF6hY0RNjY=;
        b=hMYXtFD1BNixRVuyrGFvykgaHuweDfr8zHt4wv0hL3YHDE0nkT+PIfvfKIcx5zapDz
         rwsS0oLYP6VR8jtg+SAdTOA6487BIcN9dRf6mPGbZYuKtYktaTSK0UgzSy4ID3JcKw6f
         1TtWR2K29iwlCMg5STy+pvsIzv32aVpISR67MayL8QEKF4cPQqG2zMuiAQ8QUDf1EEbb
         uN/NRCZvoKyOgHEpsFR/SSUakpO6zeWbaCWK8rn7vpFJ3jIq4vJEwnWUvI/6/4cDDUE0
         hL32YC4vF0DjHsJYIwQ8m9SD+HkcZAk5GpvMWVDpLW6YS2jHEhLeK0Vi9EO2kT3ovoO1
         4I5Q==
X-Gm-Message-State: AOJu0Yxjmogv7lXJOY1V/olQNG6+5+d4QZIJ8bjIL+wgGpSUQ+PNWhtE
	+NbU7jRGljE75z6+N9OcNbqhYB0OUd6jV2QRbdrfR06QJsSvfYnn2W/DFH28Vs0=
X-Google-Smtp-Source: AGHT+IGQI/jLoh5D0SkoDKcHUA/L4/D90rVchWtJIj+D4pR8UKJA4slq9ES6NsdE9kXzLZgjYoArMA==
X-Received: by 2002:a17:90b:2384:b0:296:33fd:a020 with SMTP id mr4-20020a17090b238400b0029633fda020mr2390909pjb.1.1706977535926;
        Sat, 03 Feb 2024 08:25:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvPS/FWM/sb1ofubz1Es6PY4bEottEYGG5ZtQtkNBdJIUA2f++wegfsYG32/QMar0o9LWiutCIFV5mCImGL/qprvA+MdQGusGacmWAFs7JVg+3BgdCvVrASiK6tgwf4Sq7O5jq8S8mtKAJCc/WgSN/u+ZLFMVz4EM=
Received: from amiden.localdomain ([2402:e280:2243:161:4f40:49bc:8675:1a83])
        by smtp.gmail.com with ESMTPSA id oh14-20020a17090b3a4e00b00295c8bc35e1sm2022708pjb.38.2024.02.03.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:25:35 -0800 (PST)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH v3] leds: pca963x: Add power management support
Date: Sat,  3 Feb 2024 21:55:24 +0530
Message-ID: <20240203162524.343936-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements power management for pca9633 which enables
device sleep and resume on system-wide sleep/hibernation

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 drivers/leds/leds-pca963x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 47223c850e4b..b53905da3592 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -39,6 +39,7 @@
 #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
 #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
 
+#define PCA963X_MODE1_SLEEP	0x04    /* Normal mode or Low Power mode, oscillator off */
 #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
 #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
 #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
@@ -380,6 +381,32 @@ static int pca963x_register_leds(struct i2c_client *client,
 	return ret;
 }
 
+static int pca963x_suspend(struct device *dev)
+{
+	struct pca963x *chip = dev_get_drvdata(dev);
+	u8 reg;
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg | BIT(PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static int pca963x_resume(struct device *dev)
+{
+	struct pca963x *chip = dev_get_drvdata(dev);
+	u8 reg;
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg & ~BIT(PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);
+
 static const struct of_device_id of_pca963x_match[] = {
 	{ .compatible = "nxp,pca9632", },
 	{ .compatible = "nxp,pca9633", },
@@ -430,6 +457,7 @@ static struct i2c_driver pca963x_driver = {
 	.driver = {
 		.name	= "leds-pca963x",
 		.of_match_table = of_pca963x_match,
+		.pm = pm_sleep_ptr(&pca963x_pm)
 	},
 	.probe = pca963x_probe,
 	.id_table = pca963x_id,
-- 
2.43.0


