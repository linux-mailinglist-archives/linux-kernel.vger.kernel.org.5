Return-Path: <linux-kernel+bounces-55358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DA84BBB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C5D286030
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8956FD9;
	Tue,  6 Feb 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcjBjMVP"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA98F61;
	Tue,  6 Feb 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239740; cv=none; b=MtjabP77vO8n6qcG7L9fxLIHqIoSPyABr8MgOtmqzm2qZcfxLUUALPl01bKY1xx3ViRbKMwxUPAYCIF2w2ql7NYeTp8/6Aoz+kGjo0E0vhjLTnZb1OReOJP2+mc2h28Sl2+s/4DwbSTc1rYDKuuWStj9TYHCJyJ75t0vEnYIXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239740; c=relaxed/simple;
	bh=4COZZH6G6FQq+/0+Kgrlad6dIW22WDXbcZYFPu1fyDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZUQ+GtIjUwKUyvoXC+rFcVGDGxG/9q/QryxeeRLM8dCsMWqopLzQFT9bTl6a3Ddojk9tF2KbR2RHpNKk4UTGT9MO/xE4/V3VLzh0e8+i1YgIvt+N/tZtVyjbmSCHdoEqBOnshMPSlCHo2V4T1Q2FhOJpZmpMNpLf8SuQp0Du30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcjBjMVP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b18099411so1748100f8f.0;
        Tue, 06 Feb 2024 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707239737; x=1707844537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+ehnWB1iuhsMXHLtvIAjkfWYjL8PQoZ4ssRw0UvkKI=;
        b=TcjBjMVPFgYwToOMHHfBmbqK8Aqqf59kP9S6h6GbuhKHsBt/NPk1eHxYrSEAVMTlNd
         VFR/ja84pbwtq+lh9594Xw8tF6N115ULPMrV87MdaouTaXxmpgWI93kwKfVoRGq9kmPh
         X8VoM9cOhNiZP5hnJ8pwQQbR9M+nAZM1h2s8hmwxFRYLal3P0UsjZKyo+/9SwiUCj0aX
         fwUK8DMbFwbGbWWvZMysd8FYfIVdtsQbb+4ap6roV8PC3sWUAl1rAZH8xKCVIdEKGFUM
         sfCMLt3AGgoo4SVsO2BYnlxeVPVNIAtXEeLOVjvjEYVMouvbz9HPida3H+DKE6uupuL1
         K2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239737; x=1707844537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+ehnWB1iuhsMXHLtvIAjkfWYjL8PQoZ4ssRw0UvkKI=;
        b=vkHKFhHmi+x/yExAXafUoiv9PSxlPX/QJq64Scp0ETYLgvVgvP1EwzyvCXPHB8rbnp
         Cs5bGYamI3NaH1qe0wX2oW7csF+KUaDaMIT2iqacQ/6hIpUgbNmMWHHKmjrpSRtKkmFv
         UW/GrCZDVCsU0ejfrAPtx+WdS1RCJmuBUszjJrRZ3fDoMaX/Ndo1zqbTKoS8AJo8mMeJ
         JaoKL6kr2cwK8lCdEDaOKdY3S9gEYjfMYSC6Dsn5EFsZooHT9E1/T3hUuPYUu3lZT0tW
         mxpApIJxvRs1twJTYggFmLvIM9qdOpLmSeLWoj/uTz8SOdQQ+lOEgOkdKWWFJP81N7rE
         1rFQ==
X-Gm-Message-State: AOJu0YwXmfWp+Itn6XOV8wCOkgbmHviB0wCoZXLDoVhPsP+W0ODUc6AF
	ls5QIAx8w2mU3n8D2IwVVcgeIJQ97PCaWLs/jKRlooDy/4lcqekH
X-Google-Smtp-Source: AGHT+IEXaJBJzQ/XZSko2SnYnQnfL3fQIPvkWGEIhGfQjFjNkDke13mR9mgVIIKPjafAQWtDUYazSQ==
X-Received: by 2002:a05:6000:1847:b0:33b:4aeb:82f0 with SMTP id c7-20020a056000184700b0033b4aeb82f0mr867427wri.49.1707239736665;
        Tue, 06 Feb 2024 09:15:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkOUkb7cc5uAFLxGlcP4ZB/qqb8xUp8xEdu578z77fHAZ0FCiD/6cZ03WpRdSUIuE4Wm4kvwtrTA33lhxIrC0Xtd5+zXo4g8E5yUevIhfklQa9kI2bscD0JvWyzlHbWrXHYVdgBvRtgrV+Sea5s43dk0ch48cDhXGlx2Y2ZOebWXK8yw==
Received: from localhost.localdomain (i577B692F.versanet.de. [87.123.105.47])
        by smtp.gmail.com with ESMTPSA id q12-20020adff78c000000b0033ae4df3cf4sm2546808wrp.40.2024.02.06.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:15:36 -0800 (PST)
From: Jesus Gonzalez <jesusmgh@gmail.com>
To: andriy.shevchenko@linux.intel.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesus Gonzalez <jesusmgh@gmail.com>
Subject: [PATCH v3 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
Date: Tue,  6 Feb 2024 18:11:33 +0100
Message-ID: <20240206171132.35000-2-jesusmgh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZcIniuk0TMAIrHIB@smile.fi.intel.com>
References: <ZcIniuk0TMAIrHIB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
probably others) in their ACPI table as the ID for the bmi160 IMU. This
means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
to the user. Manufacturers have been approached on several occasions to
try getting a BIOS with a fixed ID, mostly without actual positive
results, and since affected devices are already a few years old, this is
not expected to change. This patch enables using the bmi160_i2c driver for
the bmi160 IMU on these devices.

Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
with the argument of the device working with the Windows drivers.

	Device (BMA2)
	{
	    Name (_ADR, Zero)  // _ADR: Address
	    Name (_HID, "10EC5280")  // _HID: Hardware ID
	    Name (_CID, "10EC5280")  // _CID: Compatible ID
	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
	    Name (_UID, One)  // _UID: Unique ID
	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
	    {
		Name (RBUF, ResourceTemplate ()
		{
		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
		        AddressingMode7Bit, "\\_SB.I2CC",
		        0x00, ResourceConsumer, , Exclusive,
		        )
		})
		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
	    }
	    
	    ...
	    
	}

Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
---
v3: - Add ID to the actual i2c driver instead of the spi driver
(Mistake while manually transferring change to clean master, lesson learned)
    - Move comment to outside of the function as per coding style
    - Adapt comment style to standard multi-line comment style
    - Reduce unnecessary noise from DSDT in the explanation body


 drivers/iio/imu/bmi160/bmi160_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 81652c08e644..fc72445204e6 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -42,7 +42,16 @@ static const struct i2c_device_id bmi160_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
 
+/*
+ * FIRMWARE BUG WORKAROUND: ID "10EC5280"
+ * Some manufacturers like GPD, Lenovo or Aya used the incorrect
+ * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
+ * available as of Feb 2024 after trying to work with OEMs, and
+ * this is not expected to change anymore since at least some of
+ * the affected devices are from 2021/2022.
+ */
 static const struct acpi_device_id bmi160_acpi_match[] = {
+	{"10EC5280", 0},
 	{"BMI0160", 0},
 	{ },
 };
-- 
2.43.0


