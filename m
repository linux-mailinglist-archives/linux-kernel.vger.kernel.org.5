Return-Path: <linux-kernel+bounces-5627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6533818D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8200C283F30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4CC381A5;
	Tue, 19 Dec 2023 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2wiOP4l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC7374D6;
	Tue, 19 Dec 2023 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so2740315e9.1;
        Tue, 19 Dec 2023 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005275; x=1703610075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMIbD+dY7Kjgg6ECXdMxWD6N2Rzqy4kZE/eQIX1m8rA=;
        b=N2wiOP4l4aUAfqAZSwo1LPcCMf/dqsKI0fl+SYWpkz1g2kKsWeebO9pL/F51Jjqg1t
         y41X7SZ57umzATIaH0/DbUjRBXtIrzDVjAeS2qsPmaA532HVE28m/Ix1ue/gOo9S/5Gz
         UlH/yNtPMxLQRGC2Vp2LtCKvo2sS3ZN+HlzaUv3FNkb3bSRA9jtyr1geRyNPyPZviD6L
         WIrUdxBbBvXeKRYAgQCOUPemBgSlqPuALFeruMxQ95CRtI4k/P4ZFewiCztReV5tXLmE
         +djTloKC7PrCypugqLbbAt2fGBu4RbEb9IIsPgX2laGn2a6eodk0N2VQsi73GaDRs9rg
         rugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005275; x=1703610075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMIbD+dY7Kjgg6ECXdMxWD6N2Rzqy4kZE/eQIX1m8rA=;
        b=VnU3bkYRxOu+XCTEWn24Blz71ghYyL38KlyMlFe9IFYGO9NLBhKC7Ee6YWlP83gNcM
         5tOyckJdG4YtHCQLyQJ6epdxJ0dMZX1XSmOV4m2QumyIrErDHuFDZ++5F1VlXy+57o9L
         ajDuE0rYI0gWxpHfslJbpFYWMc/KqmZlevUE/MPPoq3Gc6JblnvoUhCoEdUfTH7mnm9k
         WaHUYLrBLPGi91GXsQWqSm/fp4LNjHaF3PhOToEmGjLiFSNbo8ieksmkivCnevulLAwx
         YguZnBaCQVyWQbvq2benbirqafcFf+hxZoTY90pR6YGdpPbAlsuVrTM7VFdtUzLvwYvG
         DyMg==
X-Gm-Message-State: AOJu0Yx2C2cU94CMzycf0gIHvi6RixRiTmwycOYu21CM84bbcR+7t8rF
	Bp89WllE6d05LjI1ksFp9V/jcE51yA==
X-Google-Smtp-Source: AGHT+IFd/r09bOpDmnqqwNJVgTHnXa/6FuakfAQjMYF9yiMWHDt7k1Pyk+VRkFPu8kUv7M2V8n7jSg==
X-Received: by 2002:a05:600c:6988:b0:40b:5e4a:233e with SMTP id fp8-20020a05600c698800b0040b5e4a233emr768909wmb.64.1703005275517;
        Tue, 19 Dec 2023 09:01:15 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:15 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 09/29] drm/rockchip: inno_hdmi: Remove unneeded has audio flag
Date: Tue, 19 Dec 2023 18:00:39 +0100
Message-ID: <20231219170100.188800-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
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
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

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


