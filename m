Return-Path: <linux-kernel+bounces-59247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A884F3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1191F246E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D331A82;
	Fri,  9 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMl8ZlzC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DA2D60C;
	Fri,  9 Feb 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475822; cv=none; b=NycEjlezHs2ZtBzzXv9ax3vhwcbQ69PEXuIXMY9ww5HZ3WUimW+eGTuf6lk0lEi5k2AqKir6g1tUwiSSdLbVhnutiuSvI/dP9yt0LqpwpYCttFvuqvrTU3rcmwmLoESl4LElwTqoxHMFIG9XBbzpI2z3pkiK51GM35W4MUUBxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475822; c=relaxed/simple;
	bh=FACvZGCzZd/Mj3qjKO44p5hHKQ4QqwarXOST8mlvQ/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsJoM94rBikjK0Cif9HR84qriPTfDlOPmIA/HhX/UwcTlQWdcQUMuRTS+AxoNLVqY0e8JpIPNy3mGVdrKuZdmy7/lkMaR2hEUaZhYj6bFF23KotNZqfWAo9PiOavp1/9ydK7Fshbtbf2IpPtxzQjR/DUrkr2slxcjbe8qgzQsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMl8ZlzC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4105a6be071so4393545e9.1;
        Fri, 09 Feb 2024 02:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707475818; x=1708080618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVc4M1YbGvNb8ipoFp9BUg+QNpL61/sf2CwDTAOM2wc=;
        b=NMl8ZlzCFSsRVdlsNj/tMMUds+TJ6QAsDB4rbs3uXbNHH5OiWHG2yokjAW2stcCarg
         bIPMIjkLbaTK9k715BStxz/9j1Vf0rQWWmQ5d7jQ0v8UhcMEjJriaNoDu9JoIsJ75+sB
         PCoq9Hn6/NxZhYNY63lICK7ylRQ9btYErVLDM35W+FEtNH8+uESfItIv3p8kl51fkz2f
         IYVUkUjyR4Jw/hZz7h2iHOqG48Oxrldmda0Y4HdhqXyScZJQ04zI5Rq/AOTaD3IiHjBh
         EJkLzY9GFATI4jEhZiaslJH3gtZFHHC4O0qszp2KDoyrZWWzgJqeF/xuFutNEjeDilDX
         Fvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475818; x=1708080618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVc4M1YbGvNb8ipoFp9BUg+QNpL61/sf2CwDTAOM2wc=;
        b=uetu9fU6RPhZ8T2fv02rOI45gxO+92LSuPyvflSsVK4c/2j/oLlbvBnS5QLxtF7NFD
         vEluHlR3OlgomeTfxH2kUq5vWKkg/yshGP3LR+NbDW3hog8+dfULUvsdSeMesUVbpd+z
         tS10TXXQR62s+OleHNWVnH4HVcdA60oXzY0mSbbUxSkocgLalGT+sYzobdyLeQtsoeN2
         /9ReELI6aEsznuSas3eX8v8dnSbRr1gUmaEYTWVTlCZso1+cD5pHAT/vja6ZO+HLuimm
         iGOu3ZnvB2vZnbbSDNr5yWUf92IYcavlQVdinl284Y8xeUfvKM+mPCmM7vugFrSQxlHV
         Q9pg==
X-Gm-Message-State: AOJu0Yxe06jbvgNTNYylUymoJz5AJDLIY6ZH8GVaQEAlKd8YLk02gFS5
	vGazK4Nfom9rCY3FpgpcPnZaZB4039gMT26wWYrg2va2W1MpQmt0
X-Google-Smtp-Source: AGHT+IGnXDekBiujHQv+XLsrfkX6e5Wxmu2GVzrddWdHW02pTuApjf//3c2Wh7SIkpQ3tD9pirwNqQ==
X-Received: by 2002:a05:600c:46cf:b0:410:4b4:dc7f with SMTP id q15-20020a05600c46cf00b0041004b4dc7fmr655530wmo.4.1707475818274;
        Fri, 09 Feb 2024 02:50:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4eE7ROrtmTolbB2S5sYVQJ9RixDkW0mR4Btlqzf15LrqUXDitF7gsevS5eTiwsbNuxPR71Y1KDWbB3QNk5IqGsbkC0HTatgMlq/J3EqoobkPpk6emEaggcm0BhrA1njJEBLBPEvvDi0Uo62kUPwy/c8LQIDME/BemJ/Ls4s0B8/LG0if0oQAYfbXTT+s4dxTQhvrcDPy3mtFz+7hDvHppzmvLJAjj4xZF+rSCTJ+vZGDwSUKwfpcWqoAstwU+pmtcwOMNjoFpr3vfnYPUExNYbKRTUg+ZfUnJyrEtZFtroX8c8hWxcq9wB4URcHIk+WoWWC6HxDKDFTc/LXy11APlURRec/O8h7DPe3/i6hm7nqIse9FjOgVjHir4B8ltDe8BcBJgmK/bwVqCjs7qKXE4TmbnJ+iKvGeSNZYjgkgkiadgj9qdwno7FjMA4BNf/FKSrrCXQfaX9GcvX2hFwjNcADTuwpKVkXOKV/Urug3uRR0cUEDxWoEwWpgwfoI6zGvfTMsjNXCMNMTvo3N9Xuff7gzulNWxLR6S1HVxUVAR/hLoBx/2
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040fc26183e8sm253627wmq.8.2024.02.09.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:50:17 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
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
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH RESEND v3 2/2] Input: atmel_mxt_ts - support poweroff in suspend
Date: Fri,  9 Feb 2024 11:50:12 +0100
Message-Id: <20240209105012.22470-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209105012.22470-1-eichest@gmail.com>
References: <20240209105012.22470-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new device tree property to indicate that the device should be
powered off in suspend mode. We have a shared regulator that powers the
display, a USB hub and some other peripherals. The maXTouch controller
doesn't normally disable the regulator in suspend mode, so our extra
peripherals stay powered on. This is not desirable as it consumes more
power. With this patch we add the option to disable the regulator in
suspend mode for the maXTouch and accept the longer initialisation time.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 72 ++++++++++++++++++------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 542a31448c8f..2d5655385702 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -317,6 +317,7 @@ struct mxt_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
 	bool use_retrigen_workaround;
+	bool poweroff_sleep;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -2799,15 +2800,18 @@ static int mxt_configure_objects(struct mxt_data *data,
 			dev_warn(dev, "Error %d updating config\n", error);
 	}
 
-	if (data->multitouch) {
-		error = mxt_initialize_input_device(data);
-		if (error)
-			return error;
-	} else {
-		dev_warn(dev, "No touch object detected\n");
-	}
+	/* If input device is not already registered */
+	if (!data->input_dev) {
+		if (data->multitouch) {
+			error = mxt_initialize_input_device(data);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev, "No touch object detected\n");
+		}
 
-	mxt_debug_init(data);
+		mxt_debug_init(data);
+	}
 
 	return 0;
 }
@@ -3325,6 +3329,8 @@ static int mxt_probe(struct i2c_client *client)
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
+	data->poweroff_sleep = device_property_read_bool(&client->dev,
+							 "atmel,poweroff-sleep");
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
 	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
@@ -3387,12 +3393,21 @@ static int mxt_suspend(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	mutex_lock(&input_dev->mutex);
+	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
+		if (data->reset_gpio)
+			gpiod_set_value(data->reset_gpio, 1);
 
-	if (input_device_enabled(input_dev))
-		mxt_stop(data);
+		regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		data->T44_address = 0;
+	} else {
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_stop(data);
 
-	mutex_unlock(&input_dev->mutex);
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	disable_irq(data->irq);
 
@@ -3408,14 +3423,37 @@ static int mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	enable_irq(data->irq);
+	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
+		int ret;
 
-	mutex_lock(&input_dev->mutex);
+		ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		if (ret) {
+			dev_err(dev, "failed to enable regulators: %d\n",
+					ret);
+			return ret;
+		}
+		msleep(MXT_BACKUP_TIME);
 
-	if (input_device_enabled(input_dev))
-		mxt_start(data);
+		if (data->reset_gpio) {
+			/* Wait a while and then de-assert the RESET GPIO line */
+			msleep(MXT_RESET_GPIO_TIME);
+			gpiod_set_value(data->reset_gpio, 0);
+			msleep(MXT_RESET_INVALID_CHG);
+		}
 
-	mutex_unlock(&input_dev->mutex);
+		/* This also enables the irq again */
+		mxt_initialize(data);
+	} else {
+		enable_irq(data->irq);
+
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_start(data);
+
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	return 0;
 }
-- 
2.40.1


