Return-Path: <linux-kernel+bounces-152096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8438AB8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395E1B21101
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A718C09;
	Sat, 20 Apr 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtggaeXh"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9A205E12
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580867; cv=none; b=tnU1KkLsd0cLSduMz4XwJL2+/lwL7Z34yyugGjGbYQ5GYNSaYN52RcRkujBnSziCPTEHTJgcYlNvquaNxduUTPhmJUL6tXjyOIY/nKTYnHR/6DEzNplMo3U7TMq0Ua4I13wgwEDc/mVtWuMtQql6eyWOctvZo1SNRQizZFL7J+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580867; c=relaxed/simple;
	bh=Q4hm4/DHNLlud3PcM0T1AblUu0zyxNmUfpUpzJ8X6JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoq3nVg6g9GQEyiRdicd3AsLd9FS9c4AeVGyoH4kcFIOyug8uoNhltYZMp1SrWZd6XvFxJbMseZK23YI3/Mx1lkuhq/ig2kFRNak65PYj1PHfYaeJR5iyi+dR+X+8aV+1qy1FkOLX9wge3nhbt3VfvPnD8+UxRt6NyCFvPYUm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtggaeXh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5171a529224so3264367e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713580864; x=1714185664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92e8LaIK4EBDXuZyzLXA86cqI9J/1l0M4wqFvKPdW00=;
        b=OtggaeXhKf9FcNEROUbpPsH52wj5ptlnO8QgLxqAh8VzUL3SwMAOchM7BrCJFe9K22
         phMxwvg+amg81TOepvIC+MrBz8NVNin1bbbFHK4NyhI+rKT5C+KqSEvYNPPGn83HkKwh
         v//j/dMypNxKLNBEsFdvxt3wbFQW3eC4KWRtRaXDSq1WVyOuP1Bpy8JcqBQO6xcN5piK
         G1sV0IUniK1TiWWMBG/XPGlve9M39JeaHOv2K1RpKZFEc3nMCcVIbnSSgmK6aCtpPLw+
         jE4ZhEox2xD8Lsxcvoh23RhO3fvEIvyKq01xzf+38XABCGIEBSLcAdiEL4Cny4i8xloO
         TEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713580864; x=1714185664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92e8LaIK4EBDXuZyzLXA86cqI9J/1l0M4wqFvKPdW00=;
        b=RKEz9CMnJweSura3KnGsiZiOH3jPCh8eCKKqGw5FZEv+lyxHC0cMo9C72zITv7ey+x
         GyovUBPSKgYgBT4N/atz5HbAnZXmv9URlz4IPw3/JN7i4e3ccAhNTbIKIB++6g1L4Uxf
         z6iD5NcF8fL6pJY453J2gC7zHECHhrRInR1CHEN8Obfnb9U7ic9imoxyXaxY/PTaIm2Y
         nCn+AVRZPQV2/R6OvxO2pKBDHYjLdie9R/mM2ZULrTMqexjHow9SWhTqYVFU91p3wcb4
         4uXKebvvokh14RUHbUT75FjTfALHLGx/8vsl8GTVmnsJQfzinoP8Ar75yn6cokswjUH0
         2J/g==
X-Forwarded-Encrypted: i=1; AJvYcCVBbI67xvraOMLk0VN0wNSkmMFdER0+4royhcwYnV7R2SUPaPPWZYEs0glmf6JVODFpzANkKQBVD1PaiTZ0P4HaLTepFYsfxTJW6Bj0
X-Gm-Message-State: AOJu0YwpIPiWs0lBbqYA1mbeUMaf/rViDVgB2Hdddc1xfcWCImSKy7w0
	z44JmZj3ZYeCVO3l5EtliSX+9I7kcYRmg9IhO+ZC7A+tkfKXzQ4y2vTVEUp9oXQ=
X-Google-Smtp-Source: AGHT+IGjO5k/naoev5sxgX4ZvZAR6tfwVgRaSDtPTeY0+NyMuKHQm96+pk1UDNu0IsOFdlNhEd5k+A==
X-Received: by 2002:ac2:4a66:0:b0:518:ab73:5a85 with SMTP id q6-20020ac24a66000000b00518ab735a85mr2354237lfp.69.1713580863985;
        Fri, 19 Apr 2024 19:41:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b00518c69b3903sm956951lfc.84.2024.04.19.19.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 19:41:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 05:41:01 +0300
Subject: [PATCH 1/2] drm/panel/lg-sw43408: depends on
 CONFIG_DRM_DISPLAY_DP_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-panel-sw43408-fix-v1-1-b282ff725242@linaro.org>
References: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
In-Reply-To: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Q4hm4/DHNLlud3PcM0T1AblUu0zyxNmUfpUpzJ8X6JU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5qytp1q9qWy/M1NfwpPfmc1WdR/8Hbx05KWeetjlrm3l
 y9XkAjpZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBE8oM5GHpN0nee4/H5bMoZ
 ntDqPUVbm/u+TNPpfwrShdVz/ju7Rzi8yLk9S/nVzMZfvALTfx8IXPlX44K6+tdXfmkz71cE/VP
 bG9F754vq/fCOL3+9LFuPWe9nXZnRLy9qmKGreNjSzlxWc6/Ae9GTrt92F77z52NnCDLbP7VAQG
 8Ry6JlsltuallyGRqlTbrAL/vU+Oo1vYlvjLWNOo+Yzb23vTikZ+Kyuckm0Xc07kV/Y7aJKDI4o
 Rz2J7xhGuPqnqs2R6VePN5hXxUip9Lcc3Ne3vlHUbObV1wR0GhsfRDSdkKK3+PQfR7ltVLndp1N
 PPRrU3qk5zq5FQ0OxS9fBrz2DFbzOMQx62zH34aXDtm/AQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This panel driver uses DSC PPS functions and as such depends on the
DRM_DISPLAY_DP_HELPER. Add missing dependency

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ab67789e59a2..5e6692207beb 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -340,6 +340,7 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on DRM_DISPLAY_DP_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
 	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per

-- 
2.39.2


