Return-Path: <linux-kernel+bounces-9975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A181CE09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422411F2156B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651674C604;
	Fri, 22 Dec 2023 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ87EL41"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717928E18;
	Fri, 22 Dec 2023 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336746c7b6dso1673345f8f.0;
        Fri, 22 Dec 2023 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266960; x=1703871760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34BUg2B4LjsKRfrLMHkMQRe61oTuxBkBwcQpvuibjEM=;
        b=SJ87EL41OA5aeB5Cl2TcRdpScY2Jw00p35WdvucvXNM8p0PaVhHaUyPK1JylutDivR
         g7paADpEd0BYGaMvFkZyWi1LE/hVd8piPl3EvfkwsZzO2aAnB30CBPlwqpY5acSnOhIz
         I2w4U33YeNKUZMV6ZJvIDi1bSBEC1tdga5OZZQW2rvHzdNayKZB/zG1S2UX/kYVYFX3G
         nz6PSBVe/EBkje8hz4vj/PB0fftr3EvkYlVXRJlNionyx2z9eGnjWhlwo7E8O7luHJ0m
         ft3KJZ7VrQDjlOkFXvnqtuYY9gTlYFcNUkMhj5txFlFabJr8AogliQ0Qcl3Fo7InkK7j
         Cz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266960; x=1703871760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34BUg2B4LjsKRfrLMHkMQRe61oTuxBkBwcQpvuibjEM=;
        b=syyRLyhMeRluHZao7LKg9RqwN+3Fy/5b3cqZ/UdvVMVLyk+wNw0Bvb16t3t/stcoj8
         DIjYGzHY8i2c+qop+9LAAzskxHhxZ8I7ddPYfYukABT/tnFEdX3gPYOfcb9cAB8KLSeX
         gQdPhHOc7s1DmmRicAaTprx0xMhr4U2vfsgNyGBA21+Eaa60jD+D7OjyJk+7KdsoLlAv
         qLjk12NvKPPjtmCaxAi86tm3CdsBDSGuDh8fR+Dtp0KlU4iuMYHZa4anyW46lH4RdYKi
         l7cHaKvJvYE/ousOLnxzW0XkNDugGcdhjj2tFYo5vAJU85eAnmEBDSXXU+oFWMQ+QUVm
         sC8Q==
X-Gm-Message-State: AOJu0YzIENrS9LTYp6LsWQB+RjuZyGmeIbDzCdfDC1txabuG2SbxVFwP
	8H9RAGCvfUZ5r6mG0Pn2bDdYWoXW0g==
X-Google-Smtp-Source: AGHT+IEHhKrxlJJC6hecqKp88hOj5Ill1eBn0UyrmY0K3DyD2qK8+a7I0eGYkTkRAt5FV0hLxk4sUA==
X-Received: by 2002:adf:e7c7:0:b0:336:619f:4647 with SMTP id e7-20020adfe7c7000000b00336619f4647mr905229wrn.108.1703266960737;
        Fri, 22 Dec 2023 09:42:40 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:40 -0800 (PST)
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
Subject: [PATCH v4 26/29] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
Date: Fri, 22 Dec 2023 18:42:17 +0100
Message-ID: <20231222174220.55249-27-knaerzche@gmail.com>
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

Now that we have proper pixelclock-based mode validation we can drop the
custom fill_modes hook.
CRTC size validation for the display controller has been added with
Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
hardware capabilities")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - no changes

changes in v3:
 - collect RB

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index a074451a0c49..d7453c36d37a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -630,13 +630,6 @@ inno_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return  inno_hdmi_display_mode_valid(hdmi, mode);
 }
 
-static int
-inno_hdmi_probe_single_connector_modes(struct drm_connector *connector,
-				       uint32_t maxX, uint32_t maxY)
-{
-	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
-}
-
 static void inno_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
@@ -695,7 +688,7 @@ inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
-	.fill_modes = inno_hdmi_probe_single_connector_modes,
+	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = inno_hdmi_connector_detect,
 	.destroy = inno_hdmi_connector_destroy,
 	.reset = inno_hdmi_connector_reset,
-- 
2.43.0


