Return-Path: <linux-kernel+bounces-91870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3568717B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF71C20BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5497F7C1;
	Tue,  5 Mar 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMSoDi4B"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212457EF0B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626338; cv=none; b=WcnQ4Cv07DAy5hS+jN+RAMTZNUB2aMel9O+aREsQkEy3kvVk5nwZlPVyXPG+vl2UL5DEZHbVzWLDeBotl7SFxQ4hGyet5LahLuGYJp2ZI00ie0BHOhDuVekYX/IvFhmGPokweCFPje6GASi4lBKg0NJmIPgpjxUwndy0B1otlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626338; c=relaxed/simple;
	bh=opt8++1g0VChwtIB/Fz1GiYx24pMTFMe80pujvPzm0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asb0zWPmaSqseakPSyoNW5JQgP1+cPxh96LID0Ph98mmQvVfvcK6zZjCwv/0l6V7wTD2QGwwvL88RoxP3eEK3WSB7Aa5373A/OkhdPCIQvf1XzG1xiupwwy71pbqFnAKZr4m5nU15uRuAaMkgLjXnK0XzZQYAmdoC6ezQKcRDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMSoDi4B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so32298066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626335; x=1710231135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZhcPKgdyjL8bhk28jJde1fP1o5dZ8nODM9Ogpw/oLw=;
        b=mMSoDi4B0ScoqRdIq65JbZqWxhBN2tGRGDPmnZFCLZcMnk1dGHvUpdXTKK23eQS1rz
         14hBX01gsecwrSo9qQY34bm5BEPuGzI+7yAF6/ZzsCpkJcQn4FuFXGIxGX/crNeULE9D
         wOpplKJ6hPI3swtCqMVb7Upxwyo340RSIoVKQHaEj01izNvgQ4vv6hQU+JsQjQR7yw4a
         Ep6Nr9IV6oxcZc0uYWIPJjmbtnnhtsi/CosKkJp5xzAOpLW2MlEmnCddwFzeEry0YvdI
         Gel5BHDTg/VyIY2rkqgfpdUm/QI5IIesm3X7NphtJN3wKSukxbsQ7ril6MDuRBpoxKys
         b4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626335; x=1710231135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZhcPKgdyjL8bhk28jJde1fP1o5dZ8nODM9Ogpw/oLw=;
        b=aTq9RHZbxWUF4Vg906kWEVgnyOO8pWKeYEQAlQd6f1voFoPOy/wxgN0q/5l9BOGfBw
         PC6c5PoIVV35fio6Fy2VAgNJ6qYxwMZDYsYMTYJsQdbSamFr96L2TvdG/z0iCGSDx5SX
         0vAxYcZgG20rv0gxGBzxwruxIsf3k5I3EBps+U8Y/yo2cU97NUJpQ4B7VMGxnzQto+y+
         6/OEgEbEtjH6KH44HCtzke2nPTtfp4rpDmmQQkCTlSQ0M00OkdosXihCrYpD4eeSGsic
         zbfUQPlKP8Rg9h4lHyP+Tb2sgjy3i1ugXdtylQGAgccMVyClHmQKNRIthNdr8cqQAg8a
         YgXw==
X-Forwarded-Encrypted: i=1; AJvYcCVy5VfrP7k9DYqh8L7CIyc8C5kDVlK3cE3aWnd69f5e91CVFuSQKGHmwabXcc3lLt2krJMKTwx1QLCNCeWJOqTzI90GmqplTMiTyO2f
X-Gm-Message-State: AOJu0YxtaV47Ce43tEgp56aqthEh8OvmZ9z8rOEtsBVgZccR26PbKsU+
	tNf0YzqIqR9XXTZKCUPoF94hfc2Dzf1pL1Q7mVyfwCRcZhDE4Dx4C3fy8/lWTOs=
X-Google-Smtp-Source: AGHT+IEuX6cKf625yCSFdJGJles12Fo1Zc/Eyc8YTMuYE42QgS4ym9vrzIj3xWMG/qe66D6f3pwLmg==
X-Received: by 2002:a17:906:cc93:b0:a43:e46b:7a80 with SMTP id oq19-20020a170906cc9300b00a43e46b7a80mr7105432ejb.43.1709626335333;
        Tue, 05 Mar 2024 00:12:15 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:11:56 +0100
Subject: [PATCH v2 1/7] backlight: gpio: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=opt8++1g0VChwtIB/Fz1GiYx24pMTFMe80pujvPzm0s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPWa6sw7b/TOSWZwZZYFLYG0BNvTG0TlbZoC
 8bMfcQFWxqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT1gAKCRDBN2bmhouD
 14vBD/9cqYKdrTAFMz6KcpOJxJ61CvuYnUPyihjwAG5ODNJ/TVWyi23DB4xZuL9d5a1Ff1xPt0K
 xenDTpvWcGV4PuNDjXe+sLUd0VWaBr/u/qSnQgDEhzYBbP095TSe7svObyzpsA6qK3c6YpxWv4J
 jRHXI5HShKxxPH2EqrqgzFx+xQOhmJAcBuWDyOCQDkJwGjvNShtjm/Bucp04ehxnXM2pmmdSTKV
 uH20IKKiZvxuOfnllFf117Iet3e0cK7KCMmcAy4CNi8N4Fyyo8+KcX1o2jwaYEJBzGqjSZJfHEc
 vRjVzwLQg2mBtty/lc4PwvvKabGqaIqiW9nDsqg7s8StjZZ2C1Xj6tWBgvGJiPJrOPscB0anvRo
 //2hXe/fq7N4168QtWlzL4qnPMBVMP7xjIFwwXCFasHOgBBuaYcWRYSmydbuT+8E+Ca5g7LWTSx
 Yt+0Nk5JLCTQ2cRZVdB7GYf93YoNlJ3mm2LS/bSDlBWQWuR5RMeuGTY680tY+ZGlCfbWp+mZxyX
 brBg1fFJMyxwb2hPg8YaH8BWgaqQHz2M/jMeap2g8W3xYqSJcrwk82QrnNzfw95/w0o5ejrpADE
 KKV05pkeESvkDdw0gNi+Jl++3PUHsLFtdS/Zt0LRqULopfstN3o6duCsIifq2E558izCkBczLjg
 m6Eh1t0XIs2hpyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index d28c30b2a35d..e0c8c2a3f5dc 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	def_value = device_property_read_bool(dev, "default-on");
 
 	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
-	if (IS_ERR(gbl->gpiod)) {
-		ret = PTR_ERR(gbl->gpiod);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Error: The gpios parameter is missing or invalid.\n");
-		return ret;
-	}
+	if (IS_ERR(gbl->gpiod))
+		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
+				     "The gpios parameter is missing or invalid\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1


