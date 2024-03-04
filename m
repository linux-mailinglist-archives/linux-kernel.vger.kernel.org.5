Return-Path: <linux-kernel+bounces-90383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D386FE85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C34B215FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BF2511E;
	Mon,  4 Mar 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBvOxM9w"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D1225D2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547119; cv=none; b=B1K58HNHJ4G/gIfkYKpu+q8yoc6VnNg1UY71Qe1+aM4TCl9HzdISu35DLuoo7arCNBkiJ7P1abCLgiDX5yZgbZm484bWSp9F49Dq4lfP39VJZTC5ZtUko0ebqTDdMslJb13kV7CN7/H9XW81fQiQzk1D4GKBuG8/u1RQizaqwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547119; c=relaxed/simple;
	bh=NY6ffh05b3e06y7LUri3yhspGUFjPVtoTn9TDh5HN+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvvG+k28fpJHK5vcegcilJqpYF6rHiaDqwqm1IcOrrh3skrs3mA9JDqiYE6YfzMXEubN9Tvxc/0Zcr9OVMsOhF0j7w4laKVqbDGKrt81fDg8zvSqVCgHWLioUp8xlyCcizTmUW6+n+wfKVwIaJyUWGy2mwCSydE3j4VO+eYMQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oBvOxM9w; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so5532742a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547115; x=1710151915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1FwEFy+Dl2uRsNArjy2my0aFqui23Xcgx08mwBp3cc=;
        b=oBvOxM9wdb31Ou0VnNu6RL+nOzpvA9DbpCeSc0Gmwd7biSohKwNCmBEw6q42tSZ/i4
         SBK0mEM7+vxwlcfGfGppDNdbrlR0VEQ0vQ948sr9Nhnuop05GwEg0naORcXuw3Jphn4B
         jWnL0+YToffKwQiEkZ6o1T3jtylmaWNFAoVfvLlEScObcUUPv6tcjAjmkMwf/Z9O8c/v
         7lCkjdaFNmIv8p0kWWj8iEYkpgVqFXETiFFFNB8Mj7qDV1L59RjAMNxUBErG88n5iINQ
         hVlMYLOFVynYOeaOSLq0iqi8GyU+6CmE3COMa7rNhxIzmi67mmLjHk8nP7JJRIseuWxf
         7QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547115; x=1710151915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1FwEFy+Dl2uRsNArjy2my0aFqui23Xcgx08mwBp3cc=;
        b=M5cFjDnm+7rxIEqxH/x7Pbx2+1RMfx9rK6dAD5ZOS7/rKXoJuA2c237EMPYfmGX9Y3
         8XydBfrlU0fkps+WJJieLb7kSRDM1tpc3NvzvgnDlRBfeWPwDI1HcRNKoZJtF/r6o1fn
         syCnZTZbjdtJqkpeRCCOQdyclaL1Acm+xgT1PUXovxeXdz0b8EJV//WMWpfAc3BfFx3a
         nl3q12dAAag7l9Vgpl76QYOFi8xDRKSEhug6BizIJsf8M6yO9pK5pX8xls2Owd2Vuin2
         UcroJaJtmrBqX1XqMi01+HdqveJ4dyTBxn6gH8OEL0Q2Hfq9AeQvUwoh6wrKDwPERcRR
         De7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIrVw4u7TPdZQVzSeSKzR4bP33Ki7MS51gkhFMyuKbHIhaNQ3bPLwHhHPU4BLbaVUX1Wz0e+F06e+M6rHAvY33pGsiSbhRuU2PAJLa
X-Gm-Message-State: AOJu0YxxohpbqxjM8fzE20L6TnMJaiqVPLsF5vtFm1G5w9Ab6jT1mmPM
	BG1ZiSSMXsrNKCU6O6shBlNj+s+kvsDy8dhxh5WNF54qcWXfhO5fCMN3j82x634fS4pFWSb9rWP
	a
X-Google-Smtp-Source: AGHT+IH5cQu1xy1LVdK9PUSdHoyXXpoj3l3x8HX5st0puZSlq08NTx/d1VXHsfxHoA9L7M5NJzXQBg==
X-Received: by 2002:a17:906:f0d0:b0:a44:6b6b:bae3 with SMTP id dk16-20020a170906f0d000b00a446b6bbae3mr6905807ejb.59.1709547115593;
        Mon, 04 Mar 2024 02:11:55 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:39 +0100
Subject: [PATCH 2/7] backlight: l4f00242t03: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-2-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NY6ffh05b3e06y7LUri3yhspGUFjPVtoTn9TDh5HN+Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5iGhsKCRV6SnmJLcxk3l63l/2wXkWX0mqPw
 FqUYp3+MCCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeYgAKCRDBN2bmhouD
 1384D/94qBZqd0L96f/YTCIfX+UGorHT6vsSGWZKBQDglVcQtd+W2q9z5FyqxQRpgTRGNrrJaJr
 4XwBT0yhzuONJj8YysOc6z01URhYjs+1rTh0qxQ+1RO8iepYCX2CIcmi5mDsnwLLmcarlNY+Bzs
 P4DnCKWECInNTkU8k5gOHSfMEwr1ZI1pF8F927yg/9LQ6cpdwhkQhj89oCzr4riJg6w32dyIMZw
 IdJzS9rHxaGQNPW22klHxPxlE5L3gz3/xpkA3wlGUrD9EtRIoyzdbKUJDuSmIlcED8A0C/ZRXpF
 gjKj29XREHEOEdWkN4TQER0kkfBpvx+FjPWrfSm+bOs48jgR4JQiB2UMZprxaUUhk8zikuRByC5
 u4lL0xzLBoqLmRqQIlybVuN8VESMlgeaw4ipEn0M7QVbvZi09KPsmeXi1RtyfgUF5nmPYDePky+
 L3vXzDlQduxOf5bn9F9oRxVOsmGCiHppov0WVudC857+DAkprPcZmFOeoSnnfmkVWJNF3VMWLAX
 cAeWwpIIonnOJyiRXcOQlAIcsbfa1qZ/0SRkdg+abAPfGLwQ/crRlY2TKxXUBLCuUAkTNyB8mvX
 0AdT2K9K8Rzu13mZQdmZ9w+xQ1EFIvkyxf/kgNnILFMpr+BC9TYRP4OF3XpkdfAr5K2b9Bkvkfp
 LP0YnjvPJA4aPdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/l4f00242t03.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index cc763cf15f53..bd5137ee203b 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -179,34 +179,28 @@ static int l4f00242t03_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	priv->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->reset)) {
-		dev_err(&spi->dev,
-			"Unable to get the lcd l4f00242t03 reset gpio.\n");
-		return PTR_ERR(priv->reset);
-	}
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->reset),
+				     "Unable to get the lcd l4f00242t03 reset gpio.\n");
 	gpiod_set_consumer_name(priv->reset, "lcd l4f00242t03 reset");
 
 	priv->enable = devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->enable)) {
-		dev_err(&spi->dev,
-			"Unable to get the lcd l4f00242t03 data en gpio.\n");
-		return PTR_ERR(priv->enable);
-	}
+	if (IS_ERR(priv->enable))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->enable),
+				     "Unable to get the lcd l4f00242t03 data en gpio.\n");
 	gpiod_set_consumer_name(priv->enable, "lcd l4f00242t03 data enable");
 
 	priv->io_reg = devm_regulator_get(&spi->dev, "vdd");
-	if (IS_ERR(priv->io_reg)) {
-		dev_err(&spi->dev, "%s: Unable to get the IO regulator\n",
-		       __func__);
-		return PTR_ERR(priv->io_reg);
-	}
+	if (IS_ERR(priv->io_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->io_reg),
+				     "%s: Unable to get the IO regulator\n",
+				     __func__);
 
 	priv->core_reg = devm_regulator_get(&spi->dev, "vcore");
-	if (IS_ERR(priv->core_reg)) {
-		dev_err(&spi->dev, "%s: Unable to get the core regulator\n",
-		       __func__);
-		return PTR_ERR(priv->core_reg);
-	}
+	if (IS_ERR(priv->core_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->core_reg),
+				     "%s: Unable to get the core regulator\n",
+				     __func__);
 
 	priv->ld = devm_lcd_device_register(&spi->dev, "l4f00242t03", &spi->dev,
 					priv, &l4f_ops);

-- 
2.34.1


