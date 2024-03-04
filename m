Return-Path: <linux-kernel+bounces-90382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51F86FE82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E2282017
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F732374D;
	Mon,  4 Mar 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaixYMHg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397C224DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547117; cv=none; b=dsh/E/URjOvmACLTOj3gleV9t+A96uUltO0SxErGBpArIDJLsmursqfzvcir9NHU3/5UebhsJZZokGlKD2MtaGlhjzvdEIuofelmhpEI5HghTxETcpLPYngSGDI7hvP4hDtdyk9G2DblP0dmiKoFBm6mibYb8f0dLr+COTk6/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547117; c=relaxed/simple;
	bh=L1gsWac4GlPBRR3BJYIkKHgN/RCN5L6+vXyGAdt7/+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPVyT0ZhYwRXyIJVDBDRqGh6WLDVqJIoxdcn12PZvmctWu73VrhGcoXdlwHPG40uZgb0XpdggP/nhDPE8N60ehqOiONpY8TMXHV1scPUcJSYq7jS3dJHgybz6ct+I/eO7UIwyYTIgoowPaX3jnTlOxlroSTO1OZwJMO8goLo16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FaixYMHg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so5532710a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547114; x=1710151914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l7UpgtGLmRWEg57s509hO79ijY7GD7vXKq1B5m81jQ=;
        b=FaixYMHgXS2yUzge5gKjfWneC0/ZlCBYgnmPsea8XRPIMJ5trYiJ/P/tC9hbbFsrxZ
         OBH2SxhPmDKbmaxy4ZlU30UmuUiMzRFnUtpn3NyOvWQvHzgpFXG3GG6Xr0lHhoovKfU2
         Lc2WPeDw1ZHPLlFgWugPHtgZ/jDUMcdEAOPZwzzyRrbi7crrS9iXDYyKjW5ieFlEWfmt
         HayzcHVnCeCIgrsBfXQN8eE1ZV+qDiPL3JC1c4QKdRxrx0cPQsfUap7ofPIdpvoBd57/
         mb038C3mlOG0nNxFVt+lg6jybNzdq+G4qVMwnoUxDebocUGe5+siXDlo+XX1JV0UZ+wj
         dtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547114; x=1710151914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7UpgtGLmRWEg57s509hO79ijY7GD7vXKq1B5m81jQ=;
        b=g7cB/L72BNMZQqjATm5sMKMU8BIFu9s6U/n3scnTd0+Ma6MvMp1hyF1lE2FbBcZOL0
         TXtAWulpyX41IIYtfkd5iqAIiNdvPjzu0KODAUbtNrtKnLXvsmjuTRAac8tc5Fx0Tjbu
         oofcqSXCTrJGhzm337WmgFk/zmWGcriUl83R3J5bIXKGcIkOSwKFDZL9xETIiwNX2qvY
         S2X0QtQaaE1IdooHyEfJlW/1nUDorh6p0YvFbFy7bQQxMXljthoWgjjtEHWPJ+cjF4gI
         IICgKRgCmHfcB0feMdUyGuZWjdRiytBvRvx4TVOYE7m4Lr0imlo3gJ+XhZp4wkm1c0cY
         DnrA==
X-Forwarded-Encrypted: i=1; AJvYcCW4rQOa/8ORAztP0yyilb3ZYKFcFFho3+KfBs0hy9uH4B1jZ+VixErssQfVUm8Iw7AW0uNoXR+kol5zd8F8UzPSFmjcdcPNPE7nuKdf
X-Gm-Message-State: AOJu0YzQqAL3jlxz/9YE933BF/jbjDmaCOpU9R8IPbuk2sBLBtA9jKwm
	12kX+TeuFtZj0oXbR+cxPeY2ykrkpqLlH1KBLhmyrTMFR1TiRth3dukvx7/m7NM=
X-Google-Smtp-Source: AGHT+IHrMdwkW1PUb9mRl/nOw9W89HypdtSeRHnOOx6YuKOHBeKBikpsljjl7tT07UnolQyMcxLIZA==
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c78c with SMTP id lh22-20020a170906f8d600b00a452e21c78cmr2053919ejb.13.1709547114198;
        Mon, 04 Mar 2024 02:11:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:38 +0100
Subject: [PATCH 1/7] backlight: gpio: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L1gsWac4GlPBRR3BJYIkKHgN/RCN5L6+vXyGAdt7/+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5hj0XQi7kaF+7e81MFcwlKfdVr65vaHpPDi
 MjsbG2Is3OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeYQAKCRDBN2bmhouD
 1ygRD/938KcTcARGYikW/nyTzAfcX6ZC3q6UvmWTsLjqnFXltYckmIM/zt+gzWek4+bhQ9S1KS7
 Qmd2iAiCs6EU8ne7ebg+KIqQO44shqs+JFKqcyukBmdZ5f3P9ijrQk45S6KhhX0Z6PPohIoi98W
 GvTvFNX35xb/bjClwx8vtCuk8hJo6PolwiWsStWd2eenHGpk3qbOIiLVSV/NeF4TOsyVWpkNpET
 9BaDnLv0gBXAePVN6cy9mRLzD5JmzucY8gGBktV+zPhsbpNrTBDOJ/TNiydgwTxSVnJ+q24kWkl
 saS6lwMG7z2+0bfaiYCq/Aw+MicguWKUDtkyBTa2qqvmhYpP1URYMiOmjk2+aq1t/fpHJuvqrP5
 BhpZUHSlr+ck2ZbOJ2ckKXJ5SN3E1gVNVBYieebwzJ8G5m3mXZBKqOOvfQNMeSNfclN94ICR2QL
 nQIXGnO9EV/OwjRtKLapX9M5FYXsGLYvjXSpP+Af3WU6JHlkhnjGTOSnFBEWujD5yINuJJEF5/a
 qqopAv0qk5pujRsYiT85L6ZtryQOrZjznB6t3TdaO4dWZPnx8TcRSDulZLen4+WD7vcwUlw3yQl
 L+GrxwPMuZbqP03xEch1aBS3qvs+KFKTbyngpjIdSk7pFs8yUL+CTQ8q4+egzW+n9eEhvoBjZiB
 UtT5J0qdAwvwdTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index d28c30b2a35d..9f960f853b6e 100644
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
+				     "Error: The gpios parameter is missing or invalid.\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1


