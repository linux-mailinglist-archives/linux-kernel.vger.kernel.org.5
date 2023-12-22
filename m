Return-Path: <linux-kernel+bounces-9958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFC81CDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF76B1C22645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7E31594;
	Fri, 22 Dec 2023 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWzeEN7Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B628DD2;
	Fri, 22 Dec 2023 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso1459798f8f.0;
        Fri, 22 Dec 2023 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266949; x=1703871749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soAjE8acoLO25uetbn7sq4B8XVGjHmzUhDkeJCVuw6s=;
        b=jWzeEN7ZlvoA6aOKh+rBf6cbnCFAEiXZRNVR+eL9pvM/WT2JdtbhaaeGxRme9KdWhL
         tgotUVR2tDxXhacTpmVTKdR9p/14VT6ACvuvdzOFTbSyw9y0NSy08XJjTdsbS9bA/m6U
         WGmbj+Su4ZBz/ysyt2cgepNB3bzGo8kB7aYezYFf/mteBNzThcTe6XR5yfG0WlHodvL1
         kwb+oQ6SExt/5G2gDKgf0Bcxm4BHuQvvLY3zy1TARo4OTBvodOpd58Kw4C5cs6J9sS8l
         Wl6VJ+jVt77uMuM+uxSyX5IlmqToOl8DAeaGGZ/DvOY2zRfCD07cBubTTwf4VZ54tnNl
         HI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266949; x=1703871749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soAjE8acoLO25uetbn7sq4B8XVGjHmzUhDkeJCVuw6s=;
        b=LZGGmtxNwW8/JYY5ixigH4V54DJHW3B+MlhGVb2EnQbd3RepkEepvIJJubsQnQKWCk
         bU/CedXhxxpu54s6HHVq9XUipe5ZCbZz9DUJhLxae2dbkGoExe06gufMxBCYW2x6bz6Z
         hqM1G15SB0HpamB4gp/T2ZmCpMKl6Zqf4/Gr74Mw8kH4F8cVEST1iBtAeHJXkPmKgWbZ
         3C2EZNRq3oha4WjLLfgK2ri1I9zX9ZNUdWdb29U6/qCLD68ZfoJNfNmpklReOE4ZencQ
         02C8JemLF80Lwzqv9qbEAealst42nOFoT0Nu50rzcPoCY7Trb1lJ4qPMjT9fiD05VtOS
         lf2Q==
X-Gm-Message-State: AOJu0Yz+tRsyFQCs7ZQ5L0dgzPsnuoE8qY7bD8HD9aJsb5zJRO3kZZjm
	t+p3xmi4TFeBo9WsjaLhcg==
X-Google-Smtp-Source: AGHT+IHah4jnfoc/iQDiaH04TqQnyPss1cyXKoR1c4+dSrS+PxFbwT+bgS5fPTlfRhKEEGTVhCzfJw==
X-Received: by 2002:adf:8b1d:0:b0:336:6e32:3fe3 with SMTP id n29-20020adf8b1d000000b003366e323fe3mr1295901wra.54.1703266948656;
        Fri, 22 Dec 2023 09:42:28 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:28 -0800 (PST)
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
Subject: [PATCH v4 09/29] drm/rockchip: inno_hdmi: Remove unneeded has audio flag
Date: Fri, 22 Dec 2023 18:42:00 +0100
Message-ID: <20231222174220.55249-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
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

changes in v4:
 - none

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


