Return-Path: <linux-kernel+bounces-25792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B275682D5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617FE281F89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC2F4F8;
	Mon, 15 Jan 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5NXP4d/"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E7F4E3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so7770786f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705310700; x=1705915500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVtFgKZwIFS1vEBdEVjotaw6JZpTlhG6vAn3dQd7JeU=;
        b=C5NXP4d/BvHRsHhH2sMWzrYyZgtQ90qB3jhfY4/fNgOdVYdSC2Tvt2vvpxX9UjHdAI
         xYOFAwuJomX14wsHPwqEOLHcPXuen0C/acAvOCpZNmueBoKGqAcDWXUW8ch4BTmFXH4i
         uEIxfxxKqhv0M2MZoCfVTNL6fRD50CaWV1e5SNRyjDFEzwu2jC+TbiuHiz1b2iY7Idzw
         qdZrSbYgyZz9HuP3jfKYRJ2Id6jMlSdPeP6VYJewA2uZHXxP5PItFOUbYNXadew5oXPB
         Cw2en4IYdNu2snEo6iS+R5BPWcYMbL6oUrxQkDfvNG7c340pRdusbGaokn0ZPgitmSns
         e6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310700; x=1705915500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVtFgKZwIFS1vEBdEVjotaw6JZpTlhG6vAn3dQd7JeU=;
        b=BBaijaVolFfFnbaP2CbfqZuMeRQ0fspuTSUDcrOwTnZ08oXksgjFM/hKC2SH/enkTb
         8U7Oq/nCFUNDpb9fYEoMtSY6AezHvev9KwnV2X5ygdsGnNJAcSYaCZby/4uzuB+3vnbl
         /OcIB5AHgNrIgDJbyzCvkJt5kZJKPVcKijrVdA5MkobJSIkBl7kjh2RPDAvNO7tN2tMZ
         i+POj9csYzzKy2U3FPxlIgVHAdaak5WvA8gogi7HwyJxj+4HymRa+gnbzru9k04KhIzY
         wzJyKKH0FkhrolNKSj8HUMX3WIOM//PRebOTtMeev03zTtGJe444b0cEpWI3xnCAD7ZS
         MGAw==
X-Gm-Message-State: AOJu0Yzz7g65IBoArO29TWk+f+EClif85kiGI7/AI+LTGY+zQIA3P17v
	UxUV4HkLa7LpGb9aLc/5bg==
X-Google-Smtp-Source: AGHT+IFWA+Z+Q6sM5+EDxdV7QvTKq8nlsTgkfw59qSIaFAN6KRsmaa7Z2RYvssV+Zwrl5Nnwh2tI+g==
X-Received: by 2002:a5d:50d0:0:b0:337:99fb:ce2e with SMTP id f16-20020a5d50d0000000b0033799fbce2emr1306430wrt.209.1705310699743;
        Mon, 15 Jan 2024 01:24:59 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:702c:8d99:9a73:8e9d])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4cd2000000b0033740e109adsm11325864wrt.75.2024.01.15.01.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:24:59 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Bee <knaerzche@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/rockchip: inno_hdmi: Explicitly include drm_atomic.h
Date: Mon, 15 Jan 2024 10:24:35 +0100
Message-ID: <20240115092434.41695-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
started using drm_atomic_get_new_connector_state and
drm_atomic_get_new_crtc_state which are defined in drm_atomic.h
Building does currently only work if CONFIG_OF and CONFIG_DRM_PANEL_BRIDGE
are enabled since this will include drm_atomic.h via drm_bridge.h (see
drm_of.h).

Explicitly include drm_atomic.h in inno_hdmi.c to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401100949.ZVRr0pIa-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202401081720.UtgAZgba-lkp@intel.com/
Fixes: d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 925320fef0a8..3bb8f1382612 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
-- 
2.43.0


