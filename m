Return-Path: <linux-kernel+bounces-5625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A13818D59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA41A283E40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6DF374F2;
	Tue, 19 Dec 2023 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRUDjZDE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FF2EB12;
	Tue, 19 Dec 2023 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so45243185e9.3;
        Tue, 19 Dec 2023 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005273; x=1703610073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15Kg5P/kPo3OprJxF+EVJ+2okgIdyNf3FbH+CrQD8yI=;
        b=FRUDjZDEjovrt1xIwCkp1lRhmHoMSPGZU//xVVN1+F6q6/7pAAeI7hrSnm02XyBrK0
         Z36CquvYkTyWVkss8GI4rGm0s0eppPZlxGfj0PBGBG8cp9MmFgL2UlS+WpJHeML2i75E
         cNQHEMAqQ/DoJ1t6LOFzGej1tG9Hyml2+YsYpb10vupiSbauB+P57Ryn6H5QpFS9tw+1
         uMa6oAsZVPVq23YceEg5wBCVH+asJp9xDFCutCUTTEfE4VRzg9ciIE9GZzS/Qm9m2g5v
         RAHJd9jN5MGCXU8ua4LuKkwet2IGuFrsbp43zCLGSS99RkwauaMbMIbV9VyB9zhqxQl5
         PpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005273; x=1703610073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15Kg5P/kPo3OprJxF+EVJ+2okgIdyNf3FbH+CrQD8yI=;
        b=h9hT6dJso3UJ22WEtvdVcqYvVcAdDfPD44zgcZ5RBZBwsGXnAhcFGM8nEGApF56S9V
         PLyxD4W0RtZJBvBV33fA3UXI6GQcnjyhEAGh25yUEE6CY9NKS8ZU3ez6DsWaw6GL+znJ
         nEynQ+JKrQvFHJnJ2faddLtOeCZ8QB9BQh2/g6sUaV9oYfS/bS4MRsj8tB9yrmCWzApn
         Iky68eYuy3IAXDv+0RIyhY2WifVs+x6VwyyblqCjB0Z1zlGKyn+R/+Q4expTgy0x/vVw
         BLZyCnZjneBQmZFk7DxcahMYwtJtdnylgcIl0HInb696u3QGCVoQkwthpvqeEVVfrCcF
         hcYw==
X-Gm-Message-State: AOJu0YzaifUs/iBr9K8wzpX/1rOU5sN+yGxqPBvN3wzDDPFNfkpFI3u4
	ZfGO6t+6ymuiTiS1pLKr/g==
X-Google-Smtp-Source: AGHT+IGqScOQaAnjGHqWFCShb5yiDE0Yh5BBJo/U5oIdxgSiH15NWOTLCcGXNGOGRQDcRHbogYVnVg==
X-Received: by 2002:a05:600c:4595:b0:40d:129f:d59c with SMTP id r21-20020a05600c459500b0040d129fd59cmr3033478wmo.79.1703005273480;
        Tue, 19 Dec 2023 09:01:13 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:13 -0800 (PST)
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
Subject: [PATCH v3 07/29] drm/rockchip: inno_hdmi: Get rid of mode_set
Date: Tue, 19 Dec 2023 18:00:37 +0100
Message-ID: <20231219170100.188800-8-knaerzche@gmail.com>
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

We're not doing anything special in atomic_mode_set so we can simply
merge it into atomic_enable.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 48c4f010b260..299770e481b7 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -490,21 +490,22 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }
 
-static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_crtc_state *crtc_state,
-				       struct drm_connector_state *conn_state)
-{
-	struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
-	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
-
-	inno_hdmi_setup(hdmi, adj_mode);
-}
-
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
 				     struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+
+	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;
 
+	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
@@ -533,7 +534,6 @@ static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check	= inno_hdmi_encoder_atomic_check,
 	.atomic_enable	= inno_hdmi_encoder_enable,
 	.atomic_disable	= inno_hdmi_encoder_disable,
-	.atomic_mode_set	= inno_hdmi_encoder_mode_set,
 };
 
 static enum drm_connector_status
-- 
2.43.0


