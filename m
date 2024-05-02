Return-Path: <linux-kernel+bounces-166170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A028B971A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C3284130
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14B54777;
	Thu,  2 May 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elXXJ7Qy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA054278
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640628; cv=none; b=XEWQsYBY5F/g4rgkt5s1kHZL7FgunD0VMYch8+e1F8rojvKtmjcVFqDq7uV2wHCe+KUP9ENej5EJtD9r0mFYWyUSZnKqGQufD+vQvxIHkH0D7W1e7/wsBR8bsZ5+LC5tgSBULAVk4K+Bg3oS4xskOoL9LqO94VKUlG2fMN3l/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640628; c=relaxed/simple;
	bh=4PGjFnYS1Tn3QA5kerObdvNBnqGr5E86ZSozMvjg5qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pp5vVEcNUqloK0vVuK6VY1M5ObpqwQPp3xwPVqxez2DIn4C6k7YLbI/1+VfSLyJlu2Z4Ro1+Iw9Gcv1lhHKwEQVZvMcRiuBNkPtXLmq4GCzwfFBCLbqyIPVlnaNilM1Cot/ao5ibmAMmZVUZ00J3lmrv5rB1gGLwYUMIJmCvitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=elXXJ7Qy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3f17c6491so63372045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714640626; x=1715245426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSBBp0xVAK2Nv+uiyQY9w2gt3jv+iQ6l4RIpa967w98=;
        b=elXXJ7Qyu6YM/wKVfPSJZcF3fSUj3tureIyd4bh4TX+s9rX/xL5LtN5h2AX66bgwJ0
         413QCuTowaQ4+yfY2MQiSIXM9KhcFJUYm8zSSVsfs9BXLn5BqgerSqSrXZenVOQ88nwU
         7zCewU3W6kIvqx2BBU0Amhw6x1bVs81w443qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640626; x=1715245426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSBBp0xVAK2Nv+uiyQY9w2gt3jv+iQ6l4RIpa967w98=;
        b=O6h2n0F2rRaFkLMV7bXUIGMid+SmSeAcMDkli0XO0HZoxH2+YuoOoLjWeeHn/vhN4e
         FCL3HeEpUJED9Q7USK/3zIV26N/8dna5y3StqwO5eCNRGmKfCRgCBDuT3vy+evjRPdPV
         F/+llSCouqYcPTY8OCpQipwaqmNVD7HQ9w5WKLHx/u62KtlIF7VTvildgtSn5jxrA+9B
         PZ/5XkreJPj5+5D5mQqtvTZQWeeJcIGL26RbPvUKi3Tg108WYIF73f8lcE2iP+FCA3pR
         yecqHLQeiFJYCWK86le9Q3NybO7slm/A37umUh2oq8D784I6c/RsgfTEEvccZDUspx3L
         sbnA==
X-Forwarded-Encrypted: i=1; AJvYcCWDPmS/K2j+epGDfzynO1aiEF8gvciWUjP8JZ167Juax4irsFTrrs3KsbyLg3OzaZf9E7Mn/KJf9uwUqXJhsilgHuJmolw2O2cFhecU
X-Gm-Message-State: AOJu0Yzqe/4lKneNDd424hRMJF7DtlpfXnmyQ92amyaTG9LKVXO/KPwo
	b9TKNM3H2bQLIDN5OXvyyinuYFiPDOxjgPZMTKQ0CnaOXe3dqsCY2uq54a8o/A==
X-Google-Smtp-Source: AGHT+IEBuAfvynb9BlBVviwdLBMz5FWVRR1coQ299RAg2o7gZQK05GKLeQOsAHksMZJ/R+wmVm710A==
X-Received: by 2002:a17:902:db01:b0:1e2:1df:449b with SMTP id m1-20020a170902db0100b001e201df449bmr1720490plx.69.1714640626252;
        Thu, 02 May 2024 02:03:46 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (150.221.124.34.bc.googleusercontent.com. [34.124.221.150])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001ebd73f61fcsm764983plg.121.2024.05.02.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:03:45 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 02 May 2024 09:03:32 +0000
Subject: [PATCH 2/2] drm/bridge: anx7625: Change TDM setting accroding to
 dt property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-anx-tdm-v1-2-894a9f634f44@chromium.org>
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
In-Reply-To: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

For some SoCs, the TDM setting is not to shift the first audio data bit,
which is not the default setting of anx7625. In such cases, the TDM
setting should be changed according to the device tree property.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 29d91493b101a..538edddf313c9 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1709,6 +1709,9 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
+	if(!of_property_read_bool(np, "no-shift-audio-data"))
+		pdata->shift_audio_data = 1;
+
 	return 0;
 }
 
@@ -1866,6 +1869,11 @@ static int anx7625_audio_hw_params(struct device *dev, void *data,
 					   ~TDM_SLAVE_MODE,
 					   I2S_SLAVE_MODE);
 
+	if (!ctx->pdata.shift_audio_data)
+		ret |= anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
+				       AUDIO_CONTROL_REGISTER,
+				       TDM_TIMING_MODE);
+
 	/* Word length */
 	switch (params->sample_width) {
 	case 16:
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 39ed35d338363..41b395725913a 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -441,6 +441,7 @@ struct anx7625_platform_data {
 	u8 lane1_reg_data[DP_TX_SWING_REG_CNT];
 	u32 low_power_mode;
 	struct device_node *mipi_host_node;
+	int shift_audio_data;
 };
 
 struct anx7625_i2c_client {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


