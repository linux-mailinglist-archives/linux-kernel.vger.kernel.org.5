Return-Path: <linux-kernel+bounces-153191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D908ACAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1C41F22261
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8048145B10;
	Mon, 22 Apr 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXWoiqjl"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68B14431F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782045; cv=none; b=VPm/kTA4y3+t9OinwtDhkjKzHFVlRYSLKyXOE0QYtB1vIdwosKkIE0yi1blTYAV5bpTV0vNmtrHkk0yTcq59ge72dKBC01gG3LDCgh35PmxBPrs1ntNpic31z7NlJHayUcChvPGXHhxIUu8CDWAdpki4Wc0t1/hT0TgU74hfmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782045; c=relaxed/simple;
	bh=WvN+syKKSt2vFL7wcl7mnQ7c3aROHF7WyjkN1r8GiVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBpSwuDvN7T5Kwa3SjA2qG79qzLbBQSFU4aPB6PZhqEaSuzVeMyZ7jinWp9NIYIdcfL15w28wEz1+harciT5CHELuPTNkWl+NUUM3b2lFw9p3rynIl5+WINHo5IIz9t5FHPN/jhy03eMuH2Nq80d8jdsMD6FxhfMj51Qr8iMS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXWoiqjl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78efd1a0022so330766385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782042; x=1714386842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9RmIVhJTPtd/M32KO0T9Rps1ocUTTvulsyIxVAq4hw=;
        b=dXWoiqjlsY/OU1tPBvtn2wkAaV+phKybH2OieogwGr97wwtVTKsZJjTomjpgSB8GRd
         gKX3m/X9oLZqJWEkIReqf+xyGjolIrWELYiaD8eQtdAWpceVTqDUXpbDP9H0si58UcDk
         quwcx3C1+KVcg4dB75MqCLN144Xxjhv/kUNHZa5nPBvE8A5eklgIhlZqWBppsYpvmxlN
         Irv5BC1WTCTwwLdts+nzEBNyt+ckMVL6CLidHR2JB5bL1Ix+116z//R0vwIJbYWb3xkI
         /V1PARShaEr5Yts8REiRpIFVwrQ3iIPwt+Z/ZYBEN5Gz925rdaq5db/WpXJIbnE2Z9s+
         /kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782042; x=1714386842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9RmIVhJTPtd/M32KO0T9Rps1ocUTTvulsyIxVAq4hw=;
        b=oerwNV6RRAM4OX44LCCsbQXQ6o/5JHG6hXzXUHAbZf82y/Sk7NIZU4jbBOGNtQuMLS
         bwTPISgtVoeAh6d8ngJAK3+/1B8DgFkR5kbSCTD/5P/fGVNibDlER6/kIc95fOPw/clX
         KOqLaf8T8IJ+YXJcvaol4SsYT764th3oKyoFclK3y+KaqB20mgsVlgmmZpjU4zBNNopp
         3rxw8MFVLf+sx6Pq8Wn1J2jSmxJE0GGRw6qxx4BjNo+TJPqvncjsHY47sDI7UDns9DhN
         2c0b8HSbJZChwCloFjBT7r1O8fJ340xP9oOoZWBoKtggUNSLs2bGR0og06x+bXcfbN2Z
         NAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe5G/gnn9t91kp5Fv9qYuOacGACG0MSYZGnzPdJ9e9e6rEO/c4azU7yCCLTN3Y6sP0Ax2rIGhO53CUn6DThJeYzQwTdbKn2DL18O6V
X-Gm-Message-State: AOJu0YzpuhlKMnHva98MGZ3oVwTQ4HjkQxFLCjblg3tbknbXvJ95pgXV
	48WiIoi3iz2TJtFZncyf0xgDj9KvosgUdN5JyN/qCWtHcecWizQV
X-Google-Smtp-Source: AGHT+IF7xU0CrgrENRN5M6s9mj5930yB33guQy8rgide/y00R328+7Mcpm1moYpBa6a7xF4eToPrig==
X-Received: by 2002:ad4:41c1:0:b0:6a0:7f0f:5856 with SMTP id a1-20020ad441c1000000b006a07f0f5856mr3428302qvq.0.1713782042309;
        Mon, 22 Apr 2024 03:34:02 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:21d2:385e:2c2e:5178])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0069b21f13c52sm4170919qvd.113.2024.04.22.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:34:01 -0700 (PDT)
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
Subject: [PATCH V2] drm/bridge: imx: Fix unmet depenency for PHY_FSL_SAMSUNG_HDMI_PHY
Date: Mon, 22 Apr 2024 05:33:52 -0500
Message-ID: <20240422103352.8886-1-aford173@gmail.com>
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

To prevent this from happening with the DRM_IMX8MP_HDMI_PVI, also
imply it instead of selecting it.

Fixes: 1f36d634670d ("drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404190103.lLm8LtuP-lkp@intel.com/
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Change DRM_IMX8MP_HDMI_PVI at the same time since it was affected
     from the same commit.

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 7687ed652df5..13142a6b8590 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -8,8 +8,8 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
 	depends on COMMON_CLK
 	depends on DRM_DW_HDMI
 	depends on OF
-	select DRM_IMX8MP_HDMI_PVI
-	select PHY_FSL_SAMSUNG_HDMI_PHY
+	imply DRM_IMX8MP_HDMI_PVI
+	imply PHY_FSL_SAMSUNG_HDMI_PHY
 	help
 	  Choose this to enable support for the internal HDMI encoder found
 	  on the i.MX8MP SoC.
-- 
2.43.0


