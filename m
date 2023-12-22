Return-Path: <linux-kernel+bounces-9953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5181CDD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EFC1F234D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BC2E831;
	Fri, 22 Dec 2023 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwPVE8U3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111642C18E;
	Fri, 22 Dec 2023 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3368b1e056eso1517282f8f.3;
        Fri, 22 Dec 2023 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266945; x=1703871745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AvJnFMeaIBZd6lDR2+1UVvuB0inJkI3zLE1woR+vGw=;
        b=BwPVE8U3KMgTNbTn15J746FQfGQCUhcix4w7AomMwWE0KlJhEEcqOj+u215SjVlJZO
         S55R44pBIIQqRDdaBSguL0C4tov3pR5to3zSspjl3NP4kt0ac7vEJjhQdz7SlBV/BT1+
         YI6i11wqaX62plZdNVpbWwM/cvVglhOOTdtUFFF6viQDNd6fIPY8eyiA2ymN/eqK5hNR
         lM3PzSbg3zTKHACQJ6MnS5RaYTOXhOq/+VnFeWt/6Yf23YpYnsd7k5ZiNP2FTVo/JUnF
         hGtAtHu0mvNLzkDbW4gXNAaB1WDfZbH71ywLQvfr4owrRAV7lkE9iJ0CDhVEgQrkDcsZ
         8Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266945; x=1703871745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AvJnFMeaIBZd6lDR2+1UVvuB0inJkI3zLE1woR+vGw=;
        b=bRuKwtDXrC0HQs0H5NvCWfiFlH3rTo8WqnFDGXTssMqQxVgP4+90pMN6WzMggOZeEh
         DDDehYWpRzJyCTOXaHDLy48kFdHllzwP+vqpzy5T9aS2Umc8TbxaEjhHXZwr+QPr7jEn
         OKtV0XfMDIZgt2TFZS2OzNCQ8T24VKOOkwID8u3aUqdce1LzWhneabCjDm+uM+tvRqrJ
         7UA4h0j0RtfvikStqA2Zvz/IVNfuMZxgWXZ7V/2icbVqS0NTRAh54XgluD6LG5qI9ok5
         XJWYaiqRqx+FhocZC6Bb7j7cNfvutBKXMC2tr9J6ps6UoZKfxGytO4It3eqXP5Jut7H0
         ZQOw==
X-Gm-Message-State: AOJu0YyMjiuhAbF4M4s5CWPjj36PRcOLb/bNbrU2KRKN3HMNvxdmALdE
	/w9NuSPfEuDv4DnIx0raSw==
X-Google-Smtp-Source: AGHT+IHILFPGV8bXVLgso5JM9ZKyQoow6IG9KXyZ1hSIhSMLEgPOaAW0iXyaQSbizVOd8/5R10rStQ==
X-Received: by 2002:adf:f749:0:b0:336:8af1:5127 with SMTP id z9-20020adff749000000b003368af15127mr1196473wrp.97.1703266945283;
        Fri, 22 Dec 2023 09:42:25 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:25 -0800 (PST)
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
Subject: [PATCH v4 04/29] drm/rockchip: inno_hdmi: Remove useless mode_fixup
Date: Fri, 22 Dec 2023 18:41:55 +0100
Message-ID: <20231222174220.55249-5-knaerzche@gmail.com>
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

The mode_fixup implementation doesn't do anything, so we can simply
remove it.

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

 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 345253e033c5..0b1740b38c7b 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -517,13 +517,6 @@ static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
 	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }
 
-static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
-					 const struct drm_display_mode *mode,
-					 struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static int
 inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -540,7 +533,6 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.enable     = inno_hdmi_encoder_enable,
 	.disable    = inno_hdmi_encoder_disable,
-	.mode_fixup = inno_hdmi_encoder_mode_fixup,
 	.mode_set   = inno_hdmi_encoder_mode_set,
 	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
-- 
2.43.0


