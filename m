Return-Path: <linux-kernel+bounces-91871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5C8717B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376F8B2183F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292B7EEE1;
	Tue,  5 Mar 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JszRfOl8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA767F47B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626340; cv=none; b=kRj455jtqIODVblfUtjrsNTfILmm4bI5OOCsrJDRrVyjw8ti+ZICmBSR+FHDYnial4BqWHycJ4GARb2cABrQvh3rnI/YK+W7RVXuvgSWS3Y/sCXaCyt2yTkhWFZKfNXc43ziimKLbgtTdKThoguJJafOauQKLegBZuKzPGzyRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626340; c=relaxed/simple;
	bh=V74J1dzwFo5ezSQUueHMb1/NFOrfZ3e7TgmXv0EuHDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4qywKavoTVRFbpaDMZ4fUj7/MB/jVlVXHVD6WRqFi/ofk6FNOLhYoEu9YEwYHFaGxx0+uyHPHQAKnj5F3IJ03HcZe6Z8TclytgalGyFglrwf9BDL6QoeBRyQ+PWvYoTaIF6p8AM2G6YaQ9v+um/Iyq9icNSeLvWdH72JkxDV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JszRfOl8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso7694619a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626337; x=1710231137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=licg3hUE5I9iVSUhaQvUY/ICMniTjfaDb2iJSuUjn84=;
        b=JszRfOl8muCp7VQKPgIzMJOLmQjd1jZqB0KcgJVUBUI1gaQpxCIzDBf1XEuH6R0jc/
         ngbu9MEQGph3g6BBGKhvbP9jXXIU0SasqrW/D5j3/dVuVjlCtcFDrtJnVq/oetLFGKeM
         qbHIcy5FTABOfnJfdhWc+wtTCIhSvY5fQArQRGpd5tfDpdqRSeRftw7/bws2qyimttzr
         Uw/71zfjBka5wbM0Jfpxz6+qawJAjx0HmLqT5OxIr0GOWZtl6fqFPTgw8V/220qVxS35
         plSqUjTyyk4Vmpqlfzp/OOeJVMDW6nww9xcJtl2L2JM1nwqga5lk4S7D+0NvkzDe3yJo
         F5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626337; x=1710231137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=licg3hUE5I9iVSUhaQvUY/ICMniTjfaDb2iJSuUjn84=;
        b=id43smsp4vzaTEn2uAFVLfa66Yqh/skXKA9qntpdrD29L0uziEiTQJfDO4ulxq5awO
         dPQoFDlIsTHZLZhCoI9qRm+sCPmjCirOnvl51EjL7dUxGdZ93sPvSMnQ6EQeXzugwVZM
         FQ4dzXouK9+EUiC2AaD/7KBIKW38imq0tM+cF67esngrJo8kNUM1NmAzEo+tUmREvgPW
         TqilOLyyIleeIe3yiY2caWyi9Ws0sTkjibR+KScyAfW/cB/i3ORg4y1YQ2KRIttKrIja
         kgTYjMBqxMzi8O+AinSvh63h6bvLJYT149BNC0yOI93t4CGHwUe3J0q91OMsRC/GnWfP
         yCfw==
X-Forwarded-Encrypted: i=1; AJvYcCW/fbHOgqJSdIVOLSZlNNMEhv9vekTJK0IIlpODzWCnVYszIK26ivtFdI2o7Kq+hDeJl6IcYDSGQ52QiB74+6tFJ8D4ohYGWHzo/k45
X-Gm-Message-State: AOJu0YwwOuvSzeRDc8njq2BzaNlK0KXuVtmgXBri28V70d4fYp+V3TsD
	g99mjJ0KXojh5OpDEPRA5+GXUCS7FmI8wpMXNCr1e3UB8X2L+5fre5MTqBoM4RwoovdeMPVZGwd
	c
X-Google-Smtp-Source: AGHT+IGfm7sGGkR9kUh8su5+o2QBu2BkEz27QYtpHoYuWXB8OY86QmE12Had2uOqdDw7VGaIixtjVw==
X-Received: by 2002:a50:fa83:0:b0:566:51fa:3647 with SMTP id w3-20020a50fa83000000b0056651fa3647mr6968122edr.10.1709626336755;
        Tue, 05 Mar 2024 00:12:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:11:57 +0100
Subject: [PATCH v2 2/7] backlight: l4f00242t03: Simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-2-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=V74J1dzwFo5ezSQUueHMb1/NFOrfZ3e7TgmXv0EuHDM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPXy6RPQ//PsVb4IYTUFFLKfQGgTqhNZjAe5
 k8y1iiltayJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT1wAKCRDBN2bmhouD
 1wKfEACbULmem8OvAeK+RHjlMayIwaUJM+uAeRNpZGPV6L4vyj8fGOfNFabiu5jtYwEOD8P1n5k
 sjmhuOectJ71wUf1KLkpU9jYUFDRIpF3IWplDn352HLVqkZevuejVUTS0D7zb2MHcs4HWf8ecI+
 PRDIH87OTbGXXS6/CswU1Bnr83esrM05RJ94hfM5vkoom10EeTaCuD/GbCm0Qddi6VxMKnQF05U
 5aUspkmJRq3JTIbZqpLsqcGJ4gZOBk10m+KXHEw66rRsimBz9hpnzyf3DC7dzmAxMZF9VUKY1xS
 fG25pvaOChS3UhIT3RjRcLUBElvel8TWrUIDXFIesd4bvewciUkRXPxlZm7iwzJv7rApgw93sNi
 fJPm2n0H5nbA+SXXlDfMgP3/QcVtfqkY6mtVyY/yU/j97vmq1tzodZVZZu0zDt9DWSfRXug6DZI
 OGULgir2GA6xgNGtufI4T115U3XlFPYpuzrLL9UawHvNJXlDcogHTMpjOZjvJHxHRa/9DdiVie2
 goA++dpv0wqlnpInjDBFjh8MPlEqceV/nA/SkU4QAFi73i0HOQrDVdlUCrM+5cqHu/L+aeqCzX5
 5ibcScLzNg7LET3QCv/K78ESsxWMz5U8T9vxWV8VAOaA8ILZkwLdjspJP344Bi4UQcBxiO//n1j
 GY2+W8LLtWpqZxw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
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


