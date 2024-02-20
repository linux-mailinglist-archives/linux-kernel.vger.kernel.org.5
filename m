Return-Path: <linux-kernel+bounces-73249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FCE85C00C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0831C21AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB13762D7;
	Tue, 20 Feb 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUY0i7lc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112076037
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443346; cv=none; b=QrTeRCm7et3izKSiLfUqqvj1KH0BZ/g0UpPT3bthB80YEKfnYBdaH5EBUi+kH/KOpo9i5Hny34WQpeYWckqsCx40k2aapucEf1kQoBrHjHDkQxIn/pa3y/ldtnFXfYi8a6Ftgcfa7x1ACwKDjhYeA2Vq8hNw3ShxjpX7hn4korc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443346; c=relaxed/simple;
	bh=LdGB2B5rFcC5/PxIMzBPHrC3fcULAF8gRB14YAlPNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOoK4nMm0RXIM9PS0oSoz9LWld3gHr619pvN4JZOrv/M9xDH6B6ZW3kf/ew2patgnebvhvjhJYLd0xK2x1XNS9DOkOL1njSnVwU1I0g8DZ+8SuQDskW8PNwLKwpd0HuFGShMerljxaQq2T0NIui1QTNcQ3NMQfMaylFaVybuMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUY0i7lc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412698cdd77so11141295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443343; x=1709048143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=kUY0i7lcs8xyQhIGX2nEAHG+cGiDpXoOnGMtCs6PDATpuOYWewp8T9uGie7EUa2Jd6
         BiayhkagUFk0ANspLxlfiW23DJdlif8RH/FpS2jZ7XMlZKQAETitfYvEDUlabOPRYvfs
         v3uEhHIzyx/WUiltYlYugYmUJmOI5kkRoaNSOipLUJzrsj0Oq+c1jWmq9xyfdnQCMR69
         6J+ofmKZyYOL5XZJs0WwU5LoZVmu/LNpmx5vI67agWGfdrA5J9BJd7Guf+pMe+eCM+I8
         yS5qGuUxZsc26jPCBotqYJ2vGQJjdZ7AN65qPzSf5NlDydRLii4/eg+iKdyvW+NKLTnd
         uCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443343; x=1709048143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=OSrkw5F7bc6Nrc4oXzJzwUMW2gMVE5CRf2Sv6z2CV95jMxZdbRjiRwXnA7zIcLXJt8
         AcoTTaljAWyvJpM9mB3Se9kuUH/rUT2M94Y8rsh4AMINHu6/Rzr+N9InC94r4WEeCKDx
         AGqffR/UdL5izf0v0RBNFA4B6cO/tBweLDlUZq3kt+wplOj6qnfgplrV/PJPxFinxQzm
         g0l4T6tMiXcyUo5JWlFRaLQkYHB+UlkEg2L0sRm97RSXICMS5oR40djAxpqrl/9wg33n
         on97mRJGpRgKT4ZygS31vnOndUe1VOp8J6QyzCYK6iOmQU0pYlOPUAtj/GMmkfJgiLfK
         j/2w==
X-Forwarded-Encrypted: i=1; AJvYcCXpupxYnFU17SGxjxhfMqsJEG5jHFm2tzDMTVT5FmA6pYiaSshORbERX74r4pnSDj2rH4IXkNWIziKJWmeF4om0MRC+CA1CohSFt0nj
X-Gm-Message-State: AOJu0Yx1P+4hLdAf0aItRECNqUlzpceQwPsdCGuR00afZB/dMX+aFle9
	UJEQxHkft6cW1l2ZOp9rgv4v9pr8KzsxDa+psfuGlEu21FRGEQKH7bf+sm+1eE4=
X-Google-Smtp-Source: AGHT+IFDWLykrLrTZHAk/OiKu/p48Obi7ksW8/C3NaF3BGJJllJTfI+C8R5qCg4lbmEjSwL/2SNd8Q==
X-Received: by 2002:a05:600c:3ac8:b0:412:6ebe:9ecd with SMTP id d8-20020a05600c3ac800b004126ebe9ecdmr2032288wms.3.1708443343086;
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:41 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] backlight: da9052: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:24 +0000
Message-ID: <20240220153532.76613-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 6ede3d832aaa ("backlight: add driver for DA9052/53 PMIC v1")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 1cdc8543310b4..b8ff7046510eb 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -117,6 +117,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
-- 
2.43.0


