Return-Path: <linux-kernel+bounces-105280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265E87DB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5933DB20F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD41BF3B;
	Sat, 16 Mar 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="D9DxHyYr"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C818039
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710618758; cv=none; b=Jlvns876fZLTM6ML4ib2Vf+Mve8aW9KqzLGJ9CQIGyWAqW6/wfHSLbbD5NEtVXeP8TzQ+DwgbmrPiTMamCy+6GRaLDftHiDXdXXQq5EFtphtUD6SRPtWukjs9xmr7oeTPpP8YEVpvsxDkpMoJ4Y+Df1RNxr/ge7HFXGNKP/lX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710618758; c=relaxed/simple;
	bh=Kz6AxoyXS0ite1d+zI9BgQ9XZyg/PeBhDTilw9ktBHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMKc3Tt0IbqIB694JvG4SQeI+MVUYain475dIoFvdRpZGEpyBMGk8xxd+Yr+1EGrDhYaILWK4M8KxP2kj60ImHE4F7eM8e5eNacADrC27oDD1p9Lnx1Pom0QuTBbNOxvS28jGPCllAnu/+0XtdmdhX0NUaastS5bQFggNUJT+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=D9DxHyYr; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id la3vrEPOXk8gIla3vrpUVD; Sat, 16 Mar 2024 20:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710618687;
	bh=SjbNtOBQ+cS5fJj7smJylRnTlii80ZoATXXlQUbJZNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=D9DxHyYrkaOm5kE1mLlkXYRjXycXxsTBWVhnZ8Z9aVjjq+D6t1RBVaxow3EeogIP5
	 IM8Xv/gAhp/8W0xITHPIPKeeeMDDP1e2QqRPDB90yamocgV2NaU+1sN+IooU3WZJv/
	 5OjbTL/v2Y9NagH5qxNgBXRLe0a5NPm+eb8SyBwWD+YvsW2IR9Dh2pz4BmvkBixD+/
	 G8a4e+q30hS8hVo+0UJJ4APTF0fifdeurMlzzvjpN87gJzeWJBFvwZASjlRzKyC1Wk
	 uOj5Aufzu3x9taZdnIWltPU9E9HRp5PihX25hIsMzVEWvPGp2L/4MSHZGgsplBKvci
	 t72o/8I9nifHw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Mar 2024 20:51:27 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: lt9611uxc: Fix an error handling path in lt9611uxc_probe()
Date: Sat, 16 Mar 2024 20:51:21 +0100
Message-ID: <e09122722190d052cee792a9246c274510f3b928.1710618660.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If lt9611uxc_audio_init() fails, some resources still need to be released
before returning the error code.

Use the existing error handling path.

Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index f4f593ad8f79..d0c77630a2f9 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -965,7 +965,11 @@ static int lt9611uxc_probe(struct i2c_client *client)
 		}
 	}
 
-	return lt9611uxc_audio_init(dev, lt9611uxc);
+	ret = lt9611uxc_audio_init(dev, lt9611uxc);
+	if (ret)
+		goto err_remove_bridge;
+
+	return 0;
 
 err_remove_bridge:
 	free_irq(client->irq, lt9611uxc);
-- 
2.44.0


