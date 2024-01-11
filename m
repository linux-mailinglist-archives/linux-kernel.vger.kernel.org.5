Return-Path: <linux-kernel+bounces-23226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C268D82A92D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DCB1F250BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715CD11718;
	Thu, 11 Jan 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pR+FxTnY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575C10A14
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=yIzZtNZgUk+hSg+LRm
	vyXhs5mkbZ/NoO0/JblU6W9xQ=; b=pR+FxTnYzQfJ26kf7/SYkr44nWiV0torxa
	S24RKhmDyBfnUeC9FVTisuJqbJOyFvcoYE2H/H1nSHATAZ7knm3gQUnERlCQ3Ry7
	YiTrQe/LYBXmWAXjuExiRdNE0H7jaLl29tI5gyvAODd7Z+mRGYANZkcAPXdodJxF
	WJHnO2hJg=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnjxEVpJ9lJ0sRAA--.4258S2;
	Thu, 11 Jan 2024 16:17:25 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in rv6xx_dpm.h
Date: Thu, 11 Jan 2024 08:17:24 +0000
Message-Id: <20240111081724.11578-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnjxEVpJ9lJ0sRAA--.4258S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFy5Kry8JFWfuFg_yoWfWFb_Gr
	n7Xa93CrW7uryv9F1xArsIyrWIv398uFs3G3W8KF43J347X3WxZ3srZF9rX345JF4xAFn7
	Ka1vgFyfCrs3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj2YLDUUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBZi1mVOBlBo9wAAso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index ade13173921b..ecebebe2e7a6 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -213,8 +213,7 @@ static void atombios_enable_crtc_memreq(struct drm_crtc *crtc, int state)
 	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
 }
 
-static const u32 vga_control_regs[6] =
-{
+static const u32 vga_control_regs[6] = {
 	AVIVO_D1VGA_CONTROL,
 	AVIVO_D2VGA_CONTROL,
 	EVERGREEN_D3VGA_CONTROL,
-- 
2.17.1


