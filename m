Return-Path: <linux-kernel+bounces-73242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2DD85BFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4890C283FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E73762C0;
	Tue, 20 Feb 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tpvqg7iM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6776036
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443020; cv=none; b=W33N3c3e6ulsPRE056BGSEnRV4GK1zNDSryqjPmbA/135x2fDttZVfLMmVrME3felIH9QcGgsZcvjDtbXLwEwDyyUzJYOjTDOLtc4IHK8zf1TfjiquTOvuNy3vXdXjqyJTKGNkN9mtG7VigDG+VQnN/akm9ebaM5j2+upFX9lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443020; c=relaxed/simple;
	bh=LdGB2B5rFcC5/PxIMzBPHrC3fcULAF8gRB14YAlPNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekvQ3BAvCBIav130Vpy7/Hltikgb+o9/n0vjnVU3Xo0GcTNtR3RzmFzPG35i8ZtSBXEXBhVkK0AEhgd2EBn7sIo4DSgxlCIY8YP3k9MqvFKvvppYbdqOOIGyVCByTTzrAguhWy6Z1mYDlJZkl8AXWzjbgDsi02fLi71H+wGWLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tpvqg7iM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso31715495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443017; x=1709047817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=Tpvqg7iMV5q63sBjULxsRtuJNDWaVbWVaL5CRBP3rK5EfzIeacUE0X4u6Ylpfj65cQ
         ah11inTbgBoCa5Lk4RhKEBiwtAcdJncti+HNMZYvwav9tTdLzcCrWGMcUpg03PyfVbVQ
         kJGXvvd5o5PBNV6s7JPKbTjcxGzDtdcOaibFmsy8/df7+PW08kZ2I47Q/zrFcaYAb1rS
         jNQIxlIK6OR6RB2/EKcFBNPGn/zyuYYkudEELljX/YoATJiiukcimDPd5mW/GplMxD5L
         RIxvO5Z0g0AyI9Z+RIgdkN+HOCN1zxsBz0wowQfunZUU/42Rje9uRsV6zNy8EzjdMgZ+
         P3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443017; x=1709047817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=lXgjDFEf3NyRXVjTn4L1Gr0AoCBF8sNvyxoCk2G3GEWJji7vdQSZGf5k2R+kXm5N1e
         vXUUH4LstvRoBFraXD6IyZ5fMTcz9hSWLrNLgcKvXU0AiOGWMXR89B2/VhyZWb4vj9Us
         syX8p/8C3KpziDgh+2nn4j6d6ZsTJF3Dhzz+kL5D+DYfTbtit6qrfntDoFpEUGc81w6k
         bK5NvwoV3vlJLZAFRi45oYhgYuOjQR9x+UXWur3celzM6Ms3DIMQw5eeUtJku/wZD1uO
         p34AMMvmIJMQ6gjUng3U8Je5SFHNdxo0C1tS/yrZjrSXmeyl5QzgV+D7KW/fj5ZxHnM0
         Mdpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpNdciiR3hcKkX5ejH6pImeiXvuXD6WwHslekYqZjjcVDpcmVkZHK6ni/vxVYZ9lDvRh1UH/kQARMT5djp/fmBtdHN/AUIDRPRiDI7
X-Gm-Message-State: AOJu0Yw5TYxrGnVeiEgZ20eBTxp2jdy8cL4Jyxvvt+gz7nGdnNT89AXs
	Q51VJ+VRS3ASFMUOhATVh5k8gZep84Aj/ts1QMmC1FlIjyppvu6+iHndmEsKig0=
X-Google-Smtp-Source: AGHT+IFm14DobYCPmbNLGol/rwT+mRhKjIrwciaLuFCcheE5WveQ1xwJForozYxveJbElFbLbjVPiA==
X-Received: by 2002:a05:600c:45c7:b0:412:63fc:1c4b with SMTP id s7-20020a05600c45c700b0041263fc1c4bmr4848698wmo.10.1708443017431;
        Tue, 20 Feb 2024 07:30:17 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:16 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] backlight: da9052: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:05 +0000
Message-ID: <20240220153010.76238-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
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


