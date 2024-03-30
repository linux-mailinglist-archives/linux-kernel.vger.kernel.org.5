Return-Path: <linux-kernel+bounces-125862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B1892D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B26F1F21E10
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A2524B8;
	Sat, 30 Mar 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOe2xGtP"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5664D112
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831123; cv=none; b=NZ2QnEz3EkfAibndLqvgXxFpiuEJf98UkXOLVfsJia664Y/C8mcSOqjoEp60YSjvDMxqU9rWy1H+AcEHiBA1oa7B42Ughh/nRr9yatd3sshDJhB0Y+c7IolOCT0qhFI/xluxGCmBbNuJrdGbPksIIGKYjMCGYFW6xPNkx6T3R0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831123; c=relaxed/simple;
	bh=kTohzOWfZPW7e6Wx0FPtwfBg4M8IKANnPDJ1RfW6a2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGU5GwAkN2ZyHwatbrRc06XkXg1xtfjJ8zbzdcAZ8jdFzgQNxSR2UIZcHrPNqzAhh/9sM2zCBNgnQJN/7Wclv4+vLgZmz7k9wOiAtk30D49IGeBvdStbO6cStbMJSrT1irLDptHfNb3cjeIJ7bDXTJ6I0OCbAGCiYjwdC/kFUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOe2xGtP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415482308f8so15915115e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831120; x=1712435920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un1QbmvT45lYJwe0aH3oZN8c8VesXAq+GuCUOlRaJG0=;
        b=xOe2xGtPw+lB5iyv7SwhvDmKaRFdFLdfWhIlDR4NcOvPgceGQsh1xvxfKYM0QWciRR
         ZUCvA9MX4w4x5ubSW3nLDfW48tvAcPSn0dferXJx7AR4ZbZVhf/1Mu1e0+VkhclCcgzE
         dgGeZEdCv88s2siQevvx/Z7txSJj5FHjDReQMQqofyug7jN0fN0EI6Z5FkalRkQocarU
         Y0m9HFbdIovnACnov9AeTtCEl+hE3t9BU0/WsF6kjD6uCHreshUoZTgDpgnQFy3ZfpRv
         6S9OiwdgrCxwt6uJ/enfMMPmKLdaUkGa/6lGfGtEvUO4OqiaNcf6e0egCJ8s9mWYbcEH
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831120; x=1712435920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un1QbmvT45lYJwe0aH3oZN8c8VesXAq+GuCUOlRaJG0=;
        b=BLFrcid5G2oj/Aqo8ZE/M6H/gTT7Y+D1Zg2LwKr7jBOJHcClj92PRnHUIMnVIOy1hD
         B+WRx1QDn+t89LyhyhN7e4ViQqpmaUXJcdxP+rZ3nYJMl6NSYY4iAVRGjM4H6FTJHdwl
         W2373QK60FZbotkDV/cPT9BK1FRZjL3znVI6DPWb6a1JFTFouV0ajUnwjHF4tUzA1a8V
         M1YBinF0oMujpr9qkfQqK9JqLoMlJ+2i7KM3tYSkoxL8mV3Rscf609Y5l8jDYNvoy69g
         /o8HclDwBwRWWUxcyT3C5/6tXwedjVrv8Xq2mnxIXB57iM5cDDMhZe0tD7/TOqBjCmxq
         Da/w==
X-Forwarded-Encrypted: i=1; AJvYcCX/iuLo2tCMsCrO3VWxLzQ+cimjIgKKCqsOFBIgGC3sTOB0i4c+0A15YuQFYNNTv7BlBOI1dP/TmMywIXDdwXwUKfJRN0UM9+vCqBoG
X-Gm-Message-State: AOJu0YwglTtD7n0RPfxLac9/sfIshchHeGxxwoGuV5QWpqfo+7eWLajV
	U0Rge+lXVDm8vR/5CBB+zjzaFz6MW48E4mO0l1h0k65/0D7h+De6zg/L0rxS0I8=
X-Google-Smtp-Source: AGHT+IHMmXGFp1Yul8sOgeCFpqScFZ3w8slz8zMmapCjOq3ViqdjJda4cjOX6fibuuQQ86AHXntaRw==
X-Received: by 2002:a05:600c:4f0d:b0:414:392:3abc with SMTP id l13-20020a05600c4f0d00b0041403923abcmr3395249wmq.11.1711831119771;
        Sat, 30 Mar 2024 13:38:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b0041493e21844sm12663154wmq.27.2024.03.30.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:38:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] drm/sti: vtg: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:38:31 +0100
Message-Id: <20240330203831.87003-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/sti/sti_vtg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index 5e5f82b6a5d9..5ba469b711b5 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -431,7 +431,6 @@ MODULE_DEVICE_TABLE(of, vtg_of_match);
 struct platform_driver sti_vtg_driver = {
 	.driver = {
 		.name = "sti-vtg",
-		.owner = THIS_MODULE,
 		.of_match_table = vtg_of_match,
 	},
 	.probe	= vtg_probe,
-- 
2.34.1


