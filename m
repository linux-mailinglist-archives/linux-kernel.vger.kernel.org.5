Return-Path: <linux-kernel+bounces-23594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE882AED9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC00283DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810B15AD9;
	Thu, 11 Jan 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yiZujOEu"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75A15ADF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd7e348311so19457521fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704976687; x=1705581487; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ete2pqNcnu2TXhEIiwhI0CAEIAFmjp8VA7JbkeZ2gsc=;
        b=yiZujOEut6wA3R8QWdiNELede4hEQzJH919zsR7idBVdHPjfBZPTUjGuL/9eeTRSu4
         AgGn6eKRBEGbSfFEtcqr5NGsh6a2wkcs5qa8zb9AyDCqy19EMU/yJj2P6muJFJyC6dcz
         EjousrMHje02ancQLkpLqd09Yq4+LD8uzmzJTj9nItowYYLbCf1OOecj0Ni5GAE+d8lR
         WyWNJNps9euiYwNzy7rpTd8dJ1V41CpwVH71GfXiKtmNHBr6tyqKdBhKrWRPhretpS1m
         EzYk4Maso5T9yfCM0BpHG3UtOVioMzBsK1ia6Wp8Bo2CXa5ZqylOIPWl2qT4zD+5q7fE
         XXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976687; x=1705581487;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ete2pqNcnu2TXhEIiwhI0CAEIAFmjp8VA7JbkeZ2gsc=;
        b=nXeQ86RPJVjxJYKKTYq3qEtapeBS+470mi/DFoFvu9vZMunrpv4T2DqP27wiJvZXcm
         s6eduGnZWK/9spWG25Prjy6mrk7PaEDDXkzSihEEynJ2GTxltSSMMVqp6qZp8B+gXQBe
         pdhIcqTUBqf7Ut4f4eRL5mpRhO0Mh/i0pIbunkG+n9+kbI39GO7yNbydA14IM67sO1AV
         UtjLcOO1B2zEn44g8Wxmg5OYZk44YLF9APv4eKWO45XGog2v4BXr+56xgf0zsAXS9qq2
         0lGQ2UUoDAc/NDMQS1q8WwmD2hd1G8bx65dWcy7Y4iy47K7y14LQpY3lwnyymeTtbAl9
         n0SA==
X-Gm-Message-State: AOJu0Yyx4oCb6YVVkfI4Y01usccW0Ft5GLJyTMfd55bujSRf0i3EmvHA
	zdivBc5XYqds2QUZrvZ6POxw+ds4w3Enaw==
X-Google-Smtp-Source: AGHT+IFTsRjfKAYEB1WoIzCnUMVluvPztCiMvi0dNrHcRqljUomoEzLhD3e7B7ZU/QBhuo7P3pyMMA==
X-Received: by 2002:a2e:2a83:0:b0:2cd:8276:933b with SMTP id q125-20020a2e2a83000000b002cd8276933bmr354940ljq.97.1704976686890;
        Thu, 11 Jan 2024 04:38:06 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402185700b005578654b081sm567335edy.23.2024.01.11.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:38:06 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 11 Jan 2024 13:38:04 +0100
Subject: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
X-B4-Tracking: v=1; b=H4sIACvhn2UC/x2MSwqFMAwAryJZG7DFD31XERdqUw34aklRBPHuB
 pfDMHNDJmHK8CtuEDo58x4VTFnAvI5xIWSvDLaydWWMQS9/TGOkDSdhrz7wdSRsZuu6LkyudQE
 0TkIqvnE/PM8LcW1MbGgAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
bridge/panel.o to drm_kms_helper object, we need to select
DRM_KMS_HELPER to make sure the file is actually getting built.

Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
be properly available:

  aarch64-linux-gnu-ld: drivers/phy/qualcomm/phy-qcom-qmp-combo.o: in function `qmp_combo_bridge_attach':
  drivers/phy/qualcomm/phy-qcom-qmp-combo.c:3204:(.text+0x8f4): undefined reference to `devm_drm_of_get_bridge'

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
I can see "depends on DRM_KMS_HELPER" was removed with commit
3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS")

I'm not too familiar with Kconfig but it feels more correct if
PHY_QCOM_QMP_COMBO selects DRM_PANEL_BRIDGE that that's enough; and it
doesn't also has to explicitly select DRM_KMS_HELPER because of how the
objects are built in the Makefile.

Alternatively solution to this patch could be adjusting this line in
include/drm/drm_bridge.h:

  -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
  +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE) && defined(CONFIG_DRM_KMS_HELPER)
   struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
                                            u32 port, u32 endpoint);

. and then selecting DRM_KMS_HELPER for PHY_QCOM_QMP_COMBO.

But I think the solution in this patch is better. Let me know what you
think.
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index ac9ec5073619..ae782b427829 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -8,6 +8,7 @@ config DRM_BRIDGE
 config DRM_PANEL_BRIDGE
 	def_bool y
 	depends on DRM_BRIDGE
+	select DRM_KMS_HELPER
 	select DRM_PANEL
 	help
 	  DRM bridge wrapper of DRM panels

---
base-commit: b9c3a1fa6fb324e691a03cf124b79f4842e65d76
change-id: 20240111-drm-panel-bridge-fixup-5c2977fb969f

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


