Return-Path: <linux-kernel+bounces-13945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D182155E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8029C281E13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4913F9DB;
	Mon,  1 Jan 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f15NnXGY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E9E57E;
	Mon,  1 Jan 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e72e3d435so6359302e87.2;
        Mon, 01 Jan 2024 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704142824; x=1704747624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKO7t2hG9wQZbOuOZ2OBdmSsh90rgqQlCZCF6Y6YFcg=;
        b=f15NnXGY2amTPPRVFmkx73O2jPiSy5A0/x6aY9zqj5tsmdb/sC6s+o3MBCTtjkaSN9
         y3e/Pwm9/mGeipR5sGBBZp7xIyekzoW5IrLJ9cCMKkNeVOiIdtN959DoDkXapiOt2p8w
         2s2ndjJe0wHBbvvS857oLsxS6ElJfDqfckY68aK460nBMYvcIUCBbBWt4FSz10fJFF7T
         myl7sgBWQb/qui+2GiESmwwWJGZH5cFWct4ollcRfm/y+XlJz0sIs6chpiHjZ843vDgv
         wNv8ee40/8CB0CmzkQV2UJn5rSoMvEYcXgdR7SP2ON7n34HkG/XkaibJl+dUSo5P99Do
         C1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142824; x=1704747624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKO7t2hG9wQZbOuOZ2OBdmSsh90rgqQlCZCF6Y6YFcg=;
        b=HFrsanv+B5rgk0j2t6FMOaI6Yqx6Gg2dBclEY6ZyDKUxpt79xGbhOHCArRwjAzM7fG
         GwSWl97yhdXkYwdl+vX5ea854ySCPducuuZzkoirD+/rquuiq0Mtu3nfQ5tTrS8fFLD+
         5kniih7d8RpRWWOjyMLDJBvHMQ7+F/vcss4W0ARddgl06iSj/ks6gbAJoHMp8zyy1Um7
         BTlaAHlGJY+38eHVdoPWa5J3zE3vDyXf/V+spH9wuCDQohIu0UOOBpXVTSDZ4bhi4X9i
         G2I+FTKOBPi4x8lCHU2k0gBPvo23KEKPZx0OGptK3qxCA4w7aQBg/I1y13w9OAsQXlQn
         V9og==
X-Gm-Message-State: AOJu0YwgbFaWHTnlSZQUM+Y4lFt4YekrlXh/hH2ukLELjJLs64qfTmaf
	n5iWFeRcIjTkJbdMq51LmFI=
X-Google-Smtp-Source: AGHT+IE86fSR+lttAonljpboKktMB8Ji41vcG9rV4MNjyxOno5Zp8U6svFT8fnkFNZxZ561m0wvtBA==
X-Received: by 2002:a05:6512:33d5:b0:50e:7e1c:9049 with SMTP id d21-20020a05651233d500b0050e7e1c9049mr4083434lfg.70.1704142824646;
        Mon, 01 Jan 2024 13:00:24 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id i15-20020a05640200cf00b0055404e08589sm15122045edu.85.2024.01.01.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 13:00:23 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Jan 2024 22:00:16 +0100
Subject: [PATCH 2/2] drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH
 for lsl080al02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-tab3-display-fixes-v1-2-887ba4dbd16b@gmail.com>
References: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
In-Reply-To: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704142819; l=1047;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=pg28sLvX5GdC5bOF/yyzGASGCCoIgKs1qHIpKvHG7pQ=;
 b=V1bj5lEkTVkRcuqmS/0vog/IRKcLOnQ/VyKrfKyWkMBtEXBwTIYRhz1D8Isd2VzvjtsLbDXb0
 DvkWU1R5FlRBed5qaJ/SpcpwyEMKCETBnjzMpeIDR9/2JAqKyROVfsf
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

It turns out that I had misconfigured the device I was using the panel
with; the bus data polarity is not high for this panel, I had to change
the config on the display controller's side.

Fix the panel config to properly reflect its accurate settings.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index ea5a85779382..f23d8832a1ad 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
 	.off_func = s6d7aa0_lsl080al02_off,
 	.drm_mode = &s6d7aa0_lsl080al02_mode,
 	.mode_flags = MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_NO_HFP,
-	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_flags = 0,
 
 	.has_backlight = false,
 	.use_passwd3 = false,

-- 
2.43.0


