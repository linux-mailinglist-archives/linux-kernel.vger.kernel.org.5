Return-Path: <linux-kernel+bounces-152252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB28ABB64
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1C71C2087B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460A29CF3;
	Sat, 20 Apr 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5rbujHQ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B793A1C2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612526; cv=none; b=Sq9nXPXF0Tpac7/C5fcyQsa58X7KwExcq82n0EQEGq7rymQZPPCHAdPI5UaAfUQKcSPAHWKKP5HD21EfWU8mi+QzdqIctp0JK5LJpUSAigyMuJ3qh2aFdavKDu4JmUmuJKoZOeWtbWCb5uWRrZ7S7bVMO6skVA5gN3clbgAHklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612526; c=relaxed/simple;
	bh=7iB/bJ0bKrmQie3dCvMHhIn659Q3FHBBBPaml/y6ZH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPOEPtka+4GdxCbYMk5DPZ5SwJoG5M6cJZrCfV3s8SCWDz/u03DDjOiqEpxihVQd9J7DWzGm2Nfw3ikDHs5HH1/wIwm9eazR3PdtlYnbC+xei0snUOOesJ/Ps1dUJ/4EzU7EantPW/uSCNCSjFQhjT2rxAI6/E3K3Abk+adroSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5rbujHQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f031a4442so191494285a.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713612523; x=1714217323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKoATs+ZIoHNDyy8oxy4Gs6SKIXsj2sSrJmnOyn8fCY=;
        b=P5rbujHQBJn/tAV3JvevEDVHOO82irsrT3VC1iL9NcnR97pdcT8JDQF8t1e8Aq0Aqp
         I1lfK2JJjCESlFnFJRNw7m4uonK1wQLmdgQzorQYrzy9hEI7LdKYLoGY81tHXw/v1ja5
         d3nvqNlNFkow47YA7DjdpKvNaip6CSYcKzYgEIcEbyPK/hxDo84ptEoddZrKhGqidFmH
         J4u06piYKcaTm5ZHVR7qd96NfDDfYGPc0Y87o6y4XMGadNlKdtzGgFGkr8Pv/uLWnZqc
         si7dFd0Nq8Q51+ECPt/tXaI/kY6jCFT3cgLClJhKFkY4X3sz3GXSmR8CWUWeeAYBtiZK
         FRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713612523; x=1714217323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKoATs+ZIoHNDyy8oxy4Gs6SKIXsj2sSrJmnOyn8fCY=;
        b=BYCrkQeeIgaaJAV6kBvf1mmShGNBOlJgUS7aKW/CoRAjEED259XV39kEvwmiF2AXSa
         7vvX2inRCjw7+26mRZL6qVoK2iLG6rUWuxhOtkNUjOz3KBJyKEByhCbAx6GVbGT6jihO
         uZTjpg4hkiXhIHLrKil+/I3+imZSAeb3/Ke9rP0vzenZxES27JxPI2R0I+p+07YV3FmR
         0v+X2LtZcgZZH4Lfwb2kZLARWc4z7dh7DXox2P5JeZ0GrGOQtH3JWerFOolXiFz02Vii
         ofyBEAlma6sdW/eVJ3bdsTevuCDOEzkjBiUlBBKCUU5lnFS/gBli291wDuh4T+XLWLLG
         Fq2w==
X-Forwarded-Encrypted: i=1; AJvYcCVUWRZKEIt2vG37rXnSibV8Y4maKuo9EGN5dOSTromsHytTI/c/Q7f8Ntm93qYjd2Aamji4TRRZwmQ1MhRCHmgPl6GeBUICjEy6mp9M
X-Gm-Message-State: AOJu0YyRCEXnAUpK0/JNmVYcDoSQc/DLW/I+caAgCi/irwOtDpmPLba3
	K6FFJJ96xkAnyEL07uI+HJZ+3kcZ11Um9zH0iZml7ggzcUUCuBkq
X-Google-Smtp-Source: AGHT+IHUv7Gq5Bx5h+ndQV7V3ptdOzZY46MxtRUHLR0evtc/5NlIjWXFLv7Vys6xP0NpfUZZlbibsw==
X-Received: by 2002:a05:620a:2987:b0:790:676d:b7c6 with SMTP id r7-20020a05620a298700b00790676db7c6mr532426qkp.67.1713612522545;
        Sat, 20 Apr 2024 04:28:42 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:8379:f9d5:1d94:be66])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a0d4f00b0078ee090baa3sm2422559qkl.10.2024.04.20.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 04:28:41 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: imx: Fix unmet depenency for PHY_FSL_SAMSUNG_HDMI_PHY
Date: Sat, 20 Apr 2024 06:28:31 -0500
Message-ID: <20240420112831.5942-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling i.MX8MP DWC HDMI driver, it automatically selects
PHY_FSL_SAMSUNG_HDMI_PHY, since it wont' work without the phy.
This may cause some Kconfig warnings during various build tests.
Fix this by implying the phy instead of selecting the phy.

Fixes: 1f36d634670d ("drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404190103.lLm8LtuP-lkp@intel.com/
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 7687ed652df5..8f125c75050d 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -9,7 +9,7 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
 	depends on DRM_DW_HDMI
 	depends on OF
 	select DRM_IMX8MP_HDMI_PVI
-	select PHY_FSL_SAMSUNG_HDMI_PHY
+	imply PHY_FSL_SAMSUNG_HDMI_PHY
 	help
 	  Choose this to enable support for the internal HDMI encoder found
 	  on the i.MX8MP SoC.
-- 
2.43.0


