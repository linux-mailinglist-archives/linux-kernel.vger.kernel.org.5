Return-Path: <linux-kernel+bounces-17522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B5824ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7821C2295D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21522031B;
	Fri,  5 Jan 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwgEeP2j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5544199AF;
	Fri,  5 Jan 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2821884a09so101177466b.2;
        Thu, 04 Jan 2024 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704437597; x=1705042397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN9G9Kb0Ei3BRgzRKo9RDwtoeSks6/gH2+/hiv2p4q0=;
        b=gwgEeP2jg6OBS4rczZYF/iNSJD6JjqVIzh421UolFl3ylPDJv9h3uCrHAsYMkcoHgW
         V10VgnQ7H1NFASmONwjQMl5I3c2G/h/0YlkYb59XNMs6OacJXE1mplU/jGkquKbbh1fh
         230WQLyvuGbbRig6KmuLWq3tSs1Am4wFVPo3NST40dlq+7ueOeR38J1S52bTVmXDQNdB
         R5vXN72ThqEwdnJl7Qd9f8oRhQprtf1wzFHmrbXxa0XODw2rCvqalGNqiztoDFmczSTT
         EvyEhZJ4hYQHwmjUr3SEcKeAg1S+F9bhm/LH8MvtcexAwAUb/UCkWlzSTBZnBsJuRi78
         Ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704437597; x=1705042397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN9G9Kb0Ei3BRgzRKo9RDwtoeSks6/gH2+/hiv2p4q0=;
        b=N7my8stlDpM1O9XzuaRONtTUFe2+rFHhIZoTOcKT5R0xuTeN0qkmyp/oacHsjnyXC8
         a4wq8+xsC0nvvwpVU6/2KZit+C+LA5cYsPiiYxxRV8cF46U8HHmuzLnfwed9Qs+bDH5D
         nLyU0qsFgg8wJFmkjckyFBejO+WTPkJDJAaIP+kckytP26WEafQkvIXlLJct68P7Xu9n
         Q0atcZi9cJobn4WH97zFaxGnP75sArdo44n2+GFexbj/imXgON47iQkTGAr6aVM9TrXe
         pEzKB2tl4OoE+/7iMUP7E6GGZ761ApMOYtwMYdeyokro2g2KhYPSj88D9ae1iO3+qSLu
         k+fA==
X-Gm-Message-State: AOJu0Yx4e6xwQN8KZ36yZkyHoglQITKc+OPhskwrwipnuRaeexFQrvqx
	DyWUiYMQz6VAEZKReqQ+1wM=
X-Google-Smtp-Source: AGHT+IESYsMQvwgG8Vjc2evgLPbZfxJkSk1hOrSDFtYcr8hG6M1PSfHIVVY+DSWVNgmznTt1z7F9yg==
X-Received: by 2002:a17:906:fa0d:b0:a18:4b1b:9522 with SMTP id lo13-20020a170906fa0d00b00a184b1b9522mr921754ejb.41.1704437596911;
        Thu, 04 Jan 2024 22:53:16 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090669d700b00a28e2b72db2sm518809ejs.56.2024.01.04.22.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:53:16 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 05 Jan 2024 07:53:02 +0100
Subject: [PATCH v2 2/2] drm/panel: samsung-s6d7aa0: drop
 DRM_BUS_FLAG_DE_HIGH for lsl080al02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-tab3-display-fixes-v2-2-904d1207bf6f@gmail.com>
References: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
In-Reply-To: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704437592; l=1183;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=zbV+r29VU46Ob/u8YrKcYcH1MdK6Qsp4rJGmvF1IAUs=;
 b=VrgBYBiZXrQxVeRGeUJTG5/9Lpc//qRFKYcfsvWONuxI8I4GIlZmC0QPmRikzgvYRGQ5U8gLD
 rcnhxSXRzcoD/ck0/wclvhBbGoIp3yABok93VCTPc8c70RJYq0/NkNd
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

It turns out that I had misconfigured the device I was using the panel
with; the bus data polarity is not high for this panel, I had to change
the config on the display controller's side.

Fix the panel config to properly reflect its accurate settings.

Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
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


