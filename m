Return-Path: <linux-kernel+bounces-23103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E482A7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DA31F27362
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DF612B;
	Thu, 11 Jan 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DFrWyuxl"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA5610C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=bukJ7OHTol8WS/g72V
	ADTf1WGd5LwIRine63hdltWCU=; b=DFrWyuxld5F/tGn1JWAdmsmUPvIilKJ3Lo
	BbbaOfcBi5J0jDeayZ/d2utSDU3/xfSVK8XCWs+RmH/ZKSnRoeNVuCzbF/eUbQ8i
	H6LF79yLip7EIfEZ5dMwi15Lup56yBWq7mDatdyRGAJE8MfEsN9d05EIz613CXib
	ifDNpvFpo=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnz8cajZ9l8M6hAA--.27451S2;
	Thu, 11 Jan 2024 14:39:23 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/edid: Clean up errors in drm_edid.h
Date: Thu, 11 Jan 2024 06:39:21 +0000
Message-Id: <20240111063921.8701-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnz8cajZ9l8M6hAA--.27451S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryUWFWDAw1rtrWkKFW3KFg_yoW3XFg_CF
	y8Z3srXrWI9FWIkrnrAw43ZrWIyF1ruF48Xw18tayFyry7X3W5Zryjvry3X348XF17Za4D
	A3WkGr4rJrnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZNVJUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWR1ixWVLYUIH4QAAsI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: do not use assignment in if condition

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 69c68804023f..9bcaf76f10fc 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3611,7 +3611,8 @@ static bool mode_in_range(const struct drm_display_mode *mode,
 	if (!mode_in_vsync_range(mode, edid, t))
 		return false;
 
-	if ((max_clock = range_pixel_clock(edid, t)))
+	max_clock = range_pixel_clock(edid, t);
+	if (max_clock)
 		if (mode->clock > max_clock)
 			return false;
 
-- 
2.17.1


