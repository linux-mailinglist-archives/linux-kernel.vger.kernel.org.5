Return-Path: <linux-kernel+bounces-16795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362C8243F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DC51F25400
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693723749;
	Thu,  4 Jan 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5lEi+tqY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A722F0E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704379193;
	bh=qc3xakyHE+a32IwuTxDwyhQGwwi7DGoompf3iqlbs2o=;
	h=From:To:Cc:Subject:Date:From;
	b=5lEi+tqYFx+1gRJ81VBYBLnkv9SEtSW55qQj4yA2WZbh1Bw1+Uj+naADvOlQZXKdk
	 64LF9zTsmOgSAGYrSH4zm3/Ci1iLi7Lyih36xo07kjDPs0m/kmPpaDHWZnGatIGjKY
	 mkTZFSpQ1toDi3nD3+MvYPltafvsMd6HYR5QBlFREo8bNOjgBlpIZScfwLjLLX3Vkh
	 PfDzq8OUdtktwHM81P4CGh+TGbJ8VCFG5w/Q/hIgv7fWszGCEUNYzrzDEcJOhxXxEe
	 0UOB463luBT4cEm6iUTdBuJ8tkvG32mVHbthecbI4Colj5LQJ3U2JmCmuw+2Wwb//f
	 S5C2+DyznA+Kw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 825D8378200E;
	Thu,  4 Jan 2024 14:39:53 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] drm/rockchip: vop2: Drop superfluous include
Date: Thu,  4 Jan 2024 16:39:49 +0200
Message-ID: <20240104143951.85219-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rockchip_drm_fb.h header contains just a single function which is
not directly used by the VOP2 driver.  Drop the unnecessary include.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 923985d4161b..74c533292bbb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -35,7 +35,6 @@
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
-#include "rockchip_drm_fb.h"
 #include "rockchip_drm_vop2.h"
 #include "rockchip_rgb.h"
 
-- 
2.43.0


