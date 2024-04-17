Return-Path: <linux-kernel+bounces-148203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9168A7F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2EB21E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735218C19;
	Wed, 17 Apr 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Xz1SM2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E312B145;
	Wed, 17 Apr 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344754; cv=none; b=OYB6gbRmRvmWCLwBJA2V0lkjzJcePwB3l0yVvotM65qRHT7wpeO3BTa63VlAeV+gPHiq2CGxl/HAHM3w8MCxQ4VSXXfiWD0CHD4OrDqohYiMslpYygfmjZaUHfF2flyzghlTwcqte/5N6F5B9lu+DI6DI5x24pL+jv+uPgmqEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344754; c=relaxed/simple;
	bh=I2uzRv1fio39fOCk7iD3y3r9+exYUtMKFcdwVctH4vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIdjWmSHZbzmPVI47c/frkFnGDtSeEt/eVA+XSXI0cdd5DJLyhn1UdtvwhlvN6mfIfV3TBYoC1kXk1D/S83JxBuwJiqEJ8RcAASdnOrQN4ZLcy3f6g91eFMngcfmxHuaXrgeWLtmQpkVPsLUCVccL0y054NGiT2zT6heXpgVe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Xz1SM2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5224dfa9adso104398266b.0;
        Wed, 17 Apr 2024 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344749; x=1713949549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4Vk3Q7FWCEz42m30ao7B+UDk+tJ78nsGVh0gV/OBQY=;
        b=m+Xz1SM2oTTFMb+vo8EA3ktxlxkNqXE4hlxDezVl5Unqev4EzOr5lyW/TEMhM3Lvhf
         HICAT0mMewXA6GHnGqIziFGbpryq0dfVEBDNJA6foba9Vj2YZUvGtK7rutBHtR82w9T3
         upeSzwnnncnCvSvGpEeYVFeO33L1bQHE8k9/pV1QlhZpLQo+5ZOB2JLAf8WCia5WLqB/
         U5wCs+Ux/+uOFiS2XOMgrzXxXtlkhQZOXWtV9lGxzJePDrZXFWcglmSnxA5sLPSAc7+9
         rvbwXvw8Nj9SAmZkLeM61UOM044J4u2URIlXiC4sJ2L0UhJw7qI90bcFIOLDzlGTlMhc
         qwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344749; x=1713949549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4Vk3Q7FWCEz42m30ao7B+UDk+tJ78nsGVh0gV/OBQY=;
        b=MFu7VyKbJt5jPKrDPbl9HvWZrv41URsiI+OVHyxxpmIm/4zcASOQ41bTwPgHv8jXEW
         D3+um/egf7feo3KbeMJ6ZQsSFFjHuN/QBkkwwBioIaVv4mpbFia+gWk5oIBT3aJ/LQSP
         01Pv0pzrlF6Xzr9FBwEBai2UBS+qNAhnCusMBXAxaAtEUuuWqomURLRVX0tfl4TheZlj
         S6ggmffOzBXCLAbiitfPGf17ztETnEjr7yaVSCONOZqIhI0lesiwPokVbTsulSjvXx0T
         GXqksD3xSRqb9G2Fq5eyQZgQRNwKoG+rDE04zWBsya4oMpcBKdwvRdYuEOJdcYUQ2bwf
         Suiw==
X-Forwarded-Encrypted: i=1; AJvYcCVkAa77L3fOZlkkJnzpWAYmnOi04Oxdo12cxkbLQIcqqX9m1fZC1M0TI7lLVXZwNKWWQUzz0V8+sotDt87YKAe2UER5GRUM7ngbEi9dDaAq+OLNdohLxJkfEkqwuqkmEyMqtZVNXgCRRQ==
X-Gm-Message-State: AOJu0Ywp/nz0MOhg3AyurdpPCFnqqZhooB0P+74nm4WmY4KlSBuPkcPK
	EizDwpnr0dukfj2Tdnt2Dfx6EYkfdxtQWAcQu4XPCtCNNFgfrxe4
X-Google-Smtp-Source: AGHT+IHszUefnI9sBtUBi7rkPViwITCu7QxSkQRsMDdVIQ+r+3QMTYvwC4NJZBnUvZqMC+iDCdPbjA==
X-Received: by 2002:a17:906:554:b0:a52:30d4:20e6 with SMTP id k20-20020a170906055400b00a5230d420e6mr3592032eja.10.1713344748920;
        Wed, 17 Apr 2024 02:05:48 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a51a7832a7asm7897814ejb.199.2024.04.17.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:05:48 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v4 1/4] Input: atmel_mxt_ts - add power off and power on functions
Date: Wed, 17 Apr 2024 11:05:24 +0200
Message-Id: <20240417090527.15357-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417090527.15357-1-eichest@gmail.com>
References: <20240417090527.15357-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a separate function for power off and power on instead of calling
regulator_bulk_enable and regulator_bulk_disable directly.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 59 +++++++++++++++---------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 542a31448c8f..52867ce3b9b6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1307,6 +1307,38 @@ static int mxt_soft_reset(struct mxt_data *data)
 	return 0;
 }
 
+static int mxt_power_on(struct mxt_data *data)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (error) {
+		dev_err(&data->client->dev, "failed to enable regulators: %d\n",
+			error);
+		return error;
+	}
+
+	msleep(MXT_BACKUP_TIME);
+
+	if (data->reset_gpio) {
+		/* Wait a while and then de-assert the RESET GPIO line */
+		msleep(MXT_RESET_GPIO_TIME);
+		gpiod_set_value(data->reset_gpio, 0);
+		msleep(MXT_RESET_INVALID_CHG);
+	}
+
+	return 0;
+}
+
+static void mxt_power_off(struct mxt_data *data)
+{
+	if (data->reset_gpio)
+		gpiod_set_value(data->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 static void mxt_update_crc(struct mxt_data *data, u8 cmd, u8 value)
 {
 	/*
@@ -3305,25 +3337,9 @@ static int mxt_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
-				      data->regulators);
-	if (error) {
-		dev_err(&client->dev, "failed to enable regulators: %d\n",
-			error);
+	error = mxt_power_on(data);
+	if (error)
 		return error;
-	}
-	/*
-	 * The device takes 40ms to come up after power-on according
-	 * to the mXT224 datasheet, page 13.
-	 */
-	msleep(MXT_BACKUP_TIME);
-
-	if (data->reset_gpio) {
-		/* Wait a while and then de-assert the RESET GPIO line */
-		msleep(MXT_RESET_GPIO_TIME);
-		gpiod_set_value(data->reset_gpio, 0);
-		msleep(MXT_RESET_INVALID_CHG);
-	}
 
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
@@ -3361,8 +3377,8 @@ static int mxt_probe(struct i2c_client *client)
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
 err_disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
-			       data->regulators);
+	mxt_power_off(data);
+
 	return error;
 }
 
@@ -3374,8 +3390,7 @@ static void mxt_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
-			       data->regulators);
+	mxt_power_off(data);
 }
 
 static int mxt_suspend(struct device *dev)
-- 
2.40.1


