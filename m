Return-Path: <linux-kernel+bounces-19486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E530826DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99AF2838B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CB405D4;
	Mon,  8 Jan 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AApAgBBn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385F405C6;
	Mon,  8 Jan 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so4648350a12.1;
        Mon, 08 Jan 2024 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704716280; x=1705321080; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ataiuoEiZAKbJMfDTmDPqOcB+hhvmSxMEb08xxsTGtE=;
        b=AApAgBBnwJG2FrZrk/PUT2YwNETLSLueuDsB7K5+3O6cInP/XbbkP5fROxXQk8s7sf
         tkcufgk84WpemDTCIMjgkjALIADduZWrPtggx29cwkSaJMEpozpPbZuHx4vRnWxvTJfA
         wAFtKQoTL6ocIjTW34M+tn2HTG1BoZkbS4RTOAkkNYB/ep3TFNCrdeKC4ZknHmFXR0I6
         moOjlAdYoZP3PecoMXRUUl5ujFMUt3tr5Sl25ZdwGWhSf4y7imVMdn3GM6gMIQdRxNi+
         Vv05YMRked6ICbUuDjDVVcQuQDtipbxvOCCe0ufy2mEDraTPoR7qhdkzTB8oJvpbGxvu
         looA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704716280; x=1705321080;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ataiuoEiZAKbJMfDTmDPqOcB+hhvmSxMEb08xxsTGtE=;
        b=bKK7D+jLpTgUKCSQcyKs38y+RZleJZt+/ULwlfHVwEHz2nhyjt9q7SQP86TWEJRdTt
         Ldvfz+6fhrr6KfBpz+1qrOfAzjmGPn8D9M72paNohVF7BkjbIds0jURdmZSxr/j92GS9
         Q1JbdgYk21zVzq95j3hNG+iuWnjqN2L5ezrzb3dVAIRNU2+HVwpC+wAvPws70Fj3tWih
         I9eDGCX/8T0QmKlN6WnVETSvn+/8PWVQiOteb/6FL16AFevdhk0dVa8XdLLaAg4N5Pcd
         ZYKy6FtDIPkpNIGYrE6sIlVZSxPmFdA6FSn9jEvj0tkzxFXpQYD0KwmBC5tT4cS9WLpA
         jhoQ==
X-Gm-Message-State: AOJu0YzpBDBJB02d8NEE24MT2VRJ9isFy3od5ysDiKwcITSAdyATshqI
	uaUd3EdxYCDHYxNiYPmqijA=
X-Google-Smtp-Source: AGHT+IGk837jJFvS+TcY7fBXJR80jcXc31znrg/A2V9l7q0ncwOgKoPeJG795sFAlbjTJcin9QtHhQ==
X-Received: by 2002:a17:906:7743:b0:a29:d642:46ba with SMTP id o3-20020a170906774300b00a29d64246bamr3042338ejn.29.1704716279986;
        Mon, 08 Jan 2024 04:17:59 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:a060:7056:782e:5e26])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906551100b00a2356a7eafasm3641365ejp.199.2024.01.08.04.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:17:59 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm: Clean-up superfluously selecting VT_HW_CONSOLE_BINDING
Date: Mon,  8 Jan 2024 13:17:57 +0100
Message-Id: <20240108121757.14069-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

As config FRAMEBUFFER_CONSOLE already selects VT_HW_CONSOLE_BINDING, there
is no need for any drm driver to repeat that rule for selecting.

Remove those duplications of selecting VT_HW_CONSOLE_BINDING.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/ingenic/Kconfig | 1 -
 drivers/gpu/drm/mcde/Kconfig    | 1 -
 drivers/gpu/drm/pl111/Kconfig   | 1 -
 drivers/gpu/drm/tve200/Kconfig  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
index b440e0cdc057..3db117c5edd9 100644
--- a/drivers/gpu/drm/ingenic/Kconfig
+++ b/drivers/gpu/drm/ingenic/Kconfig
@@ -11,7 +11,6 @@ config DRM_INGENIC
 	select DRM_GEM_DMA_HELPER
 	select REGMAP
 	select REGMAP_MMIO
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	help
 	  Choose this option for DRM support for the Ingenic SoCs.
 
diff --git a/drivers/gpu/drm/mcde/Kconfig b/drivers/gpu/drm/mcde/Kconfig
index 4f3d68e11bc1..907460b69d4f 100644
--- a/drivers/gpu/drm/mcde/Kconfig
+++ b/drivers/gpu/drm/mcde/Kconfig
@@ -11,7 +11,6 @@ config DRM_MCDE
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	help
 	  Choose this option for DRM support for the ST-Ericsson MCDE
 	  Multi-Channel Display Engine.
diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index ad24cdf1d992..20fe1d2c0aaf 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -9,7 +9,6 @@ config DRM_PL111
 	select DRM_GEM_DMA_HELPER
 	select DRM_BRIDGE
 	select DRM_PANEL_BRIDGE
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	help
 	  Choose this option for DRM support for the PL111 CLCD controller.
 	  If M is selected the module will be called pl111_drm.
diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
index 11e865be81c6..5121fed571a5 100644
--- a/drivers/gpu/drm/tve200/Kconfig
+++ b/drivers/gpu/drm/tve200/Kconfig
@@ -9,7 +9,6 @@ config DRM_TVE200
 	select DRM_PANEL_BRIDGE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	help
 	  Choose this option for DRM support for the Faraday TV Encoder
 	  TVE200 Controller.
-- 
2.17.1


