Return-Path: <linux-kernel+bounces-73250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A685C00E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7914FB22DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19E763E3;
	Tue, 20 Feb 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A49fnGSF"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EE76048
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443347; cv=none; b=PRAYDGK3xrqdw4GwqbmtirFTBEl+lnUzDxuU1fEmUan5shJoeI8GFfBUTrc+72fxzllW4jPtkc/Wx15I/raKoS8mCBmxWYaUKjfwhOTZy6ASAm4QspG7aGuWZoE1ePMIw6A1zev3MA7PgjktS6u7o8zX5SFxIOngFKpxa01Z4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443347; c=relaxed/simple;
	bh=O1s6f0aVlfXsIZe84Tbyl+6qx99iwWHj2GqrxpYofNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqGrnZjHS6Z0OsyqSDYyExn5fZOjz3BnxbMWXaeBSaTg4sElLxTSY06uFR7FMUwtSf98dCWbxzyVZYRwY2lTVo287FWB8lhFnzDzDNZiBtj7/5jSgjHVwsJBn+2RjNGT0SFEWqwdowuubHxzI5mrpK9Oon9LA8eSK+Tiaxe2YQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A49fnGSF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4127109686fso3122765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443343; x=1709048143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=A49fnGSFiIMUaweEaPKUd6QHs1z8WahFQvp8dNyIcW9wpWfWFd2pKWwpCxYEyVejeN
         ejOSqBBZKU8ynUhhYl076di+o4ntEEdz1UI7m689xVlDjaMPRWrPnKDGyE7D80yrZIn2
         fi5fkQFN9QI/zI90ZulWgsKtp2T+W9OnKjK3lto9WHpRf8MXD2hTMxXDM3KBth7eYhrK
         uiViPRzm1rhe67dBpceWcm7iRkXbctJFzzXIe6LqJAzlwDX/DYzdPaPqyLDsSMI6JnMV
         /dFpgDoBkGGeXpKYCUWZvH+Eneu0XtgoU1RjOS4oKyE9RCgUgfybCcdjbit9k8pyIdp4
         czUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443343; x=1709048143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=hUt26uvAfh7EpFFT0Y2k0+p0R9KOtfSVqWva6CiDl+tuX90o8UcTImLAHkQG9o4cEw
         OZiyzuDLw6hmr2Y7B2XIn8arn/UdkuiXg9DbbtprQNokID+OgEHxDhSmYMOYuWVVjZWd
         ZCl6AFifmC6wVWrpNYQOpxxT54BOhILu/wFqdqEfIO+mtDUGbyVqyCMoQUHdHRTVDSv3
         p7WbVroZD6+qKxDNbbG8Yll+SnyUsXMIfMzhFvdYlkKrz4qRGMO/Y+OfF1JqFu9rRRxY
         3jZaJnePmNQx1sbHCZk399PinW0BklE0htT4hTt+vxayiXlUt0RrcJcL+IQMUGlBtmY+
         htHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgIgnMYo2DDZrXgxAm2xX/smMGYG55+Pf2dKRodRjLHUp7qXkVB9q0iS6Fx6G9yJHHH35wrlQJ81YoN3124tE0kXMPLzSDGF69VxBm
X-Gm-Message-State: AOJu0Yxff7qGceC1NluLvYxtHdsoIODRxS8NG0w+3RnoR03kWU/l7DqA
	J7TFj/EGeLjNgQ89L+xtGezwytpeoTjQE+ABqh+3fuie1YDetFmUYh6XbPQdrEA=
X-Google-Smtp-Source: AGHT+IG8vq/wsIWwmwQlvm7aXyY0pdUfrR1TIk4qOIdiIiJ3ne1J8Iih0b1AG9jJ3O8+DPyJtcyN8A==
X-Received: by 2002:a05:600c:1d24:b0:412:6574:c9a6 with SMTP id l36-20020a05600c1d2400b004126574c9a6mr5189419wms.2.1708443343754;
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/4] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:25 +0000
Message-ID: <20240220153532.76613-3-daniel.thompson@linaro.org>
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

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


