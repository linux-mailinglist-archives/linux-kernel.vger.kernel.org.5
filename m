Return-Path: <linux-kernel+bounces-2257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC1815A40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44EB2855A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE834557;
	Sat, 16 Dec 2023 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYeTj5EW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF99321BB;
	Sat, 16 Dec 2023 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so1814246a12.2;
        Sat, 16 Dec 2023 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744032; x=1703348832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O+Q+uG5M/KTzI1PKwCAfiw017Nj6I11OqkfEb5dgI8=;
        b=JYeTj5EWxkrhr2sfmegs/9eU2KoXflDfvUqzy1lPV7/Ml9expVTbESaWbEjYkeGZLf
         UBnrnJhMGEJADigqZB/fOKtwg6d4gDzXK4lsp4gNk21UzuZpzIz2Ehq7FWtJvNYt9psw
         8+5wPoPiwdcc7wTlT7r5GL1+mG0P9jtq+4DrvsEdS487DnCBJGFUMOVp74LJTNLQR/aK
         NsWD4QPqVc2BojU9z66FqfftdVYueU8FKd14t1bXiIHYABw2WIkLNEtBeGwzHGtwG21r
         Zas4eRFRQNZGLYF6jqS4/v9H0vpkiiHTD0qvmYBIk6I4jwRQdUN5q3wHtV0ErsvPHUn4
         gVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744032; x=1703348832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O+Q+uG5M/KTzI1PKwCAfiw017Nj6I11OqkfEb5dgI8=;
        b=IKcSO4cdl3WyZgLnqWqCc7IYKuGS6jwHNMu6saONIxKdEyze3hwByDMHFTGfml5/LV
         ft/rB1YtR5fnMAAiQfreOyQ+zAyg6ybCN+2o9Ifn/hIEhDuAd5utPEdJ4bmvMU53zEeP
         fwommXxiDlpRUSazsinLp9fh7ZkLU/RqdSPHtqx4TBKPgYDE50BtrrgGs/qh7XyGjw6F
         r0340Rt7n7pOnvSB3Nqm12KJazw8LDyg/Fet3PSMlgrzTV9lOnVqcU4r4dFWZ9f3Bhmq
         Uhd/EBZ9kAkVVO3xIq3LJh5AvAVctPIb3WB1naghtOTS2bqMYglIFdaw8+Wk7RWmLURT
         At4Q==
X-Gm-Message-State: AOJu0YxulT+WANsmC5u3p693cUm3+G1e4SEfa7vL6ruJnP/Kg5Iatbzs
	4jgBthav5lk8CJxQXQhZSQ==
X-Google-Smtp-Source: AGHT+IFyQOJtDkKfP/aGpoVbX9uCAPLdCE/IT1cjuph553xK4Po40z2xou+CG3MWlJoPZyeCd1bl/w==
X-Received: by 2002:a17:906:d4:b0:a0a:f739:ad6e with SMTP id 20-20020a17090600d400b00a0af739ad6emr5182343eji.31.1702744032054;
        Sat, 16 Dec 2023 08:27:12 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:11 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 09/27] drm/rockchip: inno_hdmi: Remove unneeded has audio flag
Date: Sat, 16 Dec 2023 17:26:20 +0100
Message-ID: <20231216162639.125215-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The sink_has_audio flag is not used anywhere in the driver so let's get
rid of it. It's redundant with drm_display_info.has_audio anyway.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index d99896f1a73a..58aff7a9c09a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
 	unsigned int colorimetry;
@@ -554,7 +553,6 @@ static int inno_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	edid = drm_get_edid(connector, hdmi->ddc);
 	if (edid) {
-		hdmi->hdmi_data.sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
 		kfree(edid);
-- 
2.43.0


