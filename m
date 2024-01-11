Return-Path: <linux-kernel+bounces-23231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4C82A936
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA751F22269
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B89101E6;
	Thu, 11 Jan 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DEhWlRLc"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A0101C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=hFyLYRGrdMsKKrb572
	UmJNs+TslUNdb4TSStKU71wo4=; b=DEhWlRLc5nBvJc7T1kmQf5FQf0jlfjkFW3
	Hhnec7P3YSfo8sSEuXaPZh6Zo8tqBw508Gb6QmnpMCTo6GRaIL2FQuUqxPux05ko
	5WKs0iMfCHdvTVJNb08oxXKhZZHscYNnJJ616H9rt3dTmPpAdBd51Jf4NWTk9SSo
	84hhgL+lI=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnb5SnqJ9l0suUAA--.19779S2;
	Thu, 11 Jan 2024 16:36:55 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in r600.c
Date: Thu, 11 Jan 2024 08:36:54 +0000
Message-Id: <20240111083654.12411-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnb5SnqJ9l0suUAA--.19779S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFy5Kry8JFWfuFg_yoW3WFX_Ca
	48Xws5JFW0vasY9F1IvF4DZr92ya18u397Gw1xKFn3Kry2q3yfua95Gr1fX3y8JF42qF1D
	Aan3XFy3CFsIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEAti1mVOBk-1wgACs4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/r600.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index a17b95eec65f..b5e97d95a19f 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -99,8 +99,7 @@ MODULE_FIRMWARE("radeon/SUMO_me.bin");
 MODULE_FIRMWARE("radeon/SUMO2_pfp.bin");
 MODULE_FIRMWARE("radeon/SUMO2_me.bin");
 
-static const u32 crtc_offsets[2] =
-{
+static const u32 crtc_offsets[2] = {
 	0,
 	AVIVO_D2CRTC_H_TOTAL - AVIVO_D1CRTC_H_TOTAL
 };
-- 
2.17.1


