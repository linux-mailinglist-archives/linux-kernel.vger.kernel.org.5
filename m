Return-Path: <linux-kernel+bounces-3985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911C817655
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19803B23F90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C35A84A;
	Mon, 18 Dec 2023 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0ZipNc7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7904FF89
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso886696a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914548; x=1703519348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DCQzgc7HZIXkjhrSZNLJQoxchuiI/YLWggopgdNCG/w=;
        b=V0ZipNc7cYu/D0tASq6sGcfXmUAg1wuUB8WeTm1QuibrxV6JZt0dB6pVGzf2pBiAje
         CtIqoaXerxLBIFjyv62RAmqLs3sJMGMfhc3Q2d0xnP9Z5UUH+HxxbBr4bROimIhBGV4u
         y3x7GUWTa9pK3Omsle12Pkyeb9CD+fDNTu0e13Wc1OFMNV/f1S0oBL7r3867waV/1wZz
         wGHtQkUSwyOe7UYrywlBOyXsD/HflOeSlnDecNTzzS0lbZvRKxFAm3sVc/qLjVTHvwAU
         bGMZkuqi2SUcrZlUh9tpSY2NqllX2zLqnthhkEFAOXjmSBbxmyVNzBNus52NTvDccDKD
         jn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914548; x=1703519348;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCQzgc7HZIXkjhrSZNLJQoxchuiI/YLWggopgdNCG/w=;
        b=s8llZ/G9shUV9VhpQK4W4l96iKLpdy9gJ6A+vnErN9xyL6ixHIYPhwXWdPzcdz/tHo
         aOKD0RTG52zQVoXPXywKbipybFlpgKN3CyDWBHZpffV5ovSKRIdseFawleK0lzPniUTT
         hy6oaJwaE4hn6uCyDj8cr1oMvj3JTgawod7XkauDlxKOBcBkKWBN35X5D7t5/MVwGSdt
         U9lyvEnOjTvRAQRnQRGd09UQpuJATYeckwpu2vxfWxM+u7m9drK+n6KGx9/6KBcOLicI
         9hxKAEAj99oYRIm/EDfIUii0V8BEuFohgv2FImg9/WphZz0pWrETe7xoThL/B1p6uzVW
         O00Q==
X-Gm-Message-State: AOJu0Yw0/JN/SMzUlWYaHhUNZVWzgCx0W9gVMzriI4imDp9NYGE5LH2m
	MsiHTpoCf7DD5wiX9ngo0WI=
X-Google-Smtp-Source: AGHT+IE0dLdHYhpXc1l9yUsJLLTeyu7fPpLWHCXq007NrPDn70yB+TVn+T7YKt5u3Yd3coevCH6ExA==
X-Received: by 2002:a17:906:da08:b0:a19:a19a:eadf with SMTP id fi8-20020a170906da0800b00a19a19aeadfmr7048806ejb.152.1702914547563;
        Mon, 18 Dec 2023 07:49:07 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm654118ejq.62.2023.12.18.07.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:49:07 -0800 (PST)
Message-ID: <410b116b-cb63-7ba7-3689-4f0832ab5796@gmail.com>
Date: Mon, 18 Dec 2023 16:49:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/2] drm/rockchip: rk3066_hdmi: drop custom fill_modes hook
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
Content-Language: en-US
In-Reply-To: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CRTC size validation for the display controller has been added with
Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
hardware capabilities"), so we can drop the custom fill_modes hook.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 0dac6d133767..6dadd753985c 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -501,18 +501,6 @@ rk3066_hdmi_connector_best_encoder(struct drm_connector *connector)
 	return &hdmi->encoder.encoder;
 }

-static int
-rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
-					 uint32_t maxX, uint32_t maxY)
-{
-	if (maxX > 1920)
-		maxX = 1920;
-	if (maxY > 1080)
-		maxY = 1080;
-
-	return drm_helper_probe_single_connector_modes(connector, maxX, maxY);
-}
-
 static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
@@ -520,7 +508,7 @@ static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
 }

 static const struct drm_connector_funcs rk3066_hdmi_connector_funcs = {
-	.fill_modes = rk3066_hdmi_probe_single_connector_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = rk3066_hdmi_connector_detect,
 	.destroy = rk3066_hdmi_connector_destroy,
 	.reset = drm_atomic_helper_connector_reset,
--
2.39.2


