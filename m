Return-Path: <linux-kernel+bounces-40636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014A83E376
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B191C231EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597F241F4;
	Fri, 26 Jan 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP+c/NY8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877123745;
	Fri, 26 Jan 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301937; cv=none; b=EQmkyDACl6RZE9cPthYBW4e4hcIZ5OkgySKYfzSzl9U5HNI9vaQgYNNOSkZeZzmzH6H4cJnlZra0PQmLfXriPk2Hb0N+/+HfYrmlR+BbRXWcEotL12AIZ8DoNJVFTyWxX0sF/2CwvyM99rxvj+ZynTbSHKuQkrbQb0Q72y5yK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301937; c=relaxed/simple;
	bh=N9k5UYEYVAF2qA6E0s7m+kIECxQo6FwY1dpU7AHZ4rA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=alqxF3q95wTNE+Lld6zVt/cTyGApCzyrptgQ9Vj/cnNT447PTArLZ4kKT3cGVunKqXqvPSEaxRX4NXFyxZfVZVctGa8TV6eXvD1CbUaQ0z0FgpD4LcfXlWZGgh8xUoZtnKlCEfPEKsg6Dsuh4+Pa5/OwFN+RTzxOpkHvDvYWnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP+c/NY8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510133ed214so1381355e87.1;
        Fri, 26 Jan 2024 12:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706301934; x=1706906734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DALTEEob3NFEf1MHZ96hGZRJHPJY2iufaNCe8cnrSKI=;
        b=IP+c/NY8wOIWo+CdeQETaSrVSC2g1m1gbeSiNW6rv/5wVTMenbqmLhJqlwOA9gg9oU
         euaWb3ZeO2jECh/bIDJlgLUAXLQn3XxaayWNInkRo7hZvfeNYLEpzaMkFcQkE/N88/55
         pKsPlHbrosIpWY7J2up1DQHCCWaZU5/117RQfwrcXmVM6aVGMcg29yyFHqurn6JngoYp
         9CzlWCZGWTnO4f3xaoZiXq3Iy/615nF11+EluALUZ+tR+iN0cpDj9qLWi/ctmKkOEEyJ
         A5ms0xDc/RkWgWviav+CY8BBwHeCVBDN8DmnDpHwNwb/lwhZfHOUG5Ende766k07aVy4
         DkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301934; x=1706906734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DALTEEob3NFEf1MHZ96hGZRJHPJY2iufaNCe8cnrSKI=;
        b=tcS9oBePeXO3uBis///9+RmlCvZu3FXoB3nDHImRQZCu9h8tqRuGjPOven9DdZCAdo
         O/duaV5Q1emZ8UwStu2GAJLQ7x2dq/yK1bCyhauJpB1GWEXcB+BdZeLmOWPTYWcb3pC5
         44GyMQOisoC38xePdPhXQDxzMv5busK4U+rE2td8dH1Sx5e3eKXaX4Z4oGyXuT9/CTD/
         rOqi+Yth8gVEDRvEWHkveI4YFhacTUJ+Ijkdk/JwbG0cnltyCON+nLdUQsW0QWdIdDQ1
         F/LE3X8XVskwzhOSpYVGKjnbBDTnK9V7Kf+stb+LIB/YrQaWE+Jzi0AAHGQHMZ8MGb2c
         emQQ==
X-Gm-Message-State: AOJu0Yz3WrT8DU59DDLUJSov12CcDbIL/1v0p01yvCuMyWjZo4xDIrqm
	CxNESjPP9zmgFluC37yzERFh64GXR+ZTnqoT8bu8OLNuOFm53ygS4nkeF7LlxtS1RQ==
X-Google-Smtp-Source: AGHT+IEwSmCZ+VQmNNzz8EADju9iF85eTjukB4lNLNudL4Tp7pZ0qwkpgEwfX09Fqq60DF+BQ6QDKg==
X-Received: by 2002:a19:ee03:0:b0:510:bba:5d1c with SMTP id g3-20020a19ee03000000b005100bba5d1cmr158724lfb.58.1706301933508;
        Fri, 26 Jan 2024 12:45:33 -0800 (PST)
Received: from localhost.localdomain (broadband-46-242-13-133.ip.moscow.rt.ru. [46.242.13.133])
        by smtp.googlemail.com with ESMTPSA id d15-20020ac25ecf000000b005100e087c3asm275320lfq.300.2024.01.26.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:45:33 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: Konstantin Aladyshev <aladyshev22@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
Date: Fri, 26 Jan 2024 23:45:22 +0300
Message-Id: <20240126204523.2211-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
has introduced a bug that makes it impossible to initialize MP2975
device:
"""
mp2975 5-0020: Failed to identify chip capabilities
i2c i2c-5: new_device: Instantiated device mp2975 at 0x20
i2c i2c-5: delete_device: Deleting device mp2975 at 0x20
"""
Since the 'read_byte_data' function was removed from the
'pmbus_driver_info ' structure the driver no longer reports correctly
that VOUT mode is direct. Therefore 'pmbus_identify_common' fails
with error, making it impossible to initialize the device.

Restore 'read_byte_data' function to fix the issue.

Tested:
- before: it is not possible to initialize MP2975 device with the
'mp2975' driver,
- after: 'mp2975' correctly initializes MP2975 device and all sensor
data is correct.

Fixes: 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
Changes in v2:
 - Fix indentation issues

 drivers/hwmon/pmbus/mp2975.c     | 17 +++++++++++++++++
 drivers/hwmon/pmbus/mp2975.c.rej | 10 ++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/mp2975.c.rej

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index b9bb469e2d8f..5bbfdacb61a7 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -126,6 +126,22 @@ static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
+static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * Enforce VOUT direct format, since device allows to set the
+		 * different formats for the different rails. Conversion from
+		 * VID to direct provided by driver internally, in case it is
+		 * necessary.
+		 */
+		return PB_VOUT_MODE_DIRECT;
+	default:
+		return -ENODATA;
+	}
+}
+
 static int
 mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
 			u16 mask)
@@ -869,6 +885,7 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
+	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
 	.num_regulators = 1,
diff --git a/drivers/hwmon/pmbus/mp2975.c.rej b/drivers/hwmon/pmbus/mp2975.c.rej
new file mode 100644
index 000000000000..8e6a54e4dbf4
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2975.c.rej
@@ -0,0 +1,10 @@
+--- drivers/hwmon/pmbus/mp2975.c
++++ drivers/hwmon/pmbus/mp2975.c
+@@ -885,6 +901,7 @@ static struct pmbus_driver_info mp2975_info = {
+                PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+                PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
+                PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
++       .read_byte_data = mp2975_read_byte_data,
+        .read_word_data = mp2975_read_word_data,
+ #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
+        .num_regulators = 1,
-- 
2.34.1


