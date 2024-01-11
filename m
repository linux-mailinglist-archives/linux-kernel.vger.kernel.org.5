Return-Path: <linux-kernel+bounces-23160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA7182A87C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B083E1F24A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4BE558;
	Thu, 11 Jan 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BJbCfXv6"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE7E545
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ni/Dp2TvD0TRWHDQMg
	VzzpzRHqxOJtCixJqVl2DQb8Y=; b=BJbCfXv6cFr6FRO1BQaZmZeIvYivDsglbn
	MmC/v7A27XKkwdTkt4TOakGCMooYSzfN1udA1Gfo7cLDrD5JFeBopF+G+OAgu6G5
	Jgdqy6/UDE8/3Wd+p/ArmkSL0QWJKojX7Iu2dzzBcG2SQ49sdz8KmBlyeQSY3aUx
	SBEaQ7VK0=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3H+8wm59lXcWSAA--.18886S2;
	Thu, 11 Jan 2024 15:39:28 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in r600_dpm.h
Date: Thu, 11 Jan 2024 07:39:25 +0000
Message-Id: <20240111073925.10663-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H+8wm59lXcWSAA--.18886S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1ktF1UWr1kZF1xJw13urg_yoW3WrX_u3
	WxXw47X34I9Fn8Wr1SvF4xJ34SvF1UZF4xCa4rtFyrKry7tr4rXayktFy8X3WUJ3W3XFs5
	A3y8ta9IyrZFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtrcDUUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBVi1mVOBk9-FwAAsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following enum go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/r600_dpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_dpm.h b/drivers/gpu/drm/radeon/r600_dpm.h
index 6e4d22ed2a00..5c2513c84c48 100644
--- a/drivers/gpu/drm/radeon/r600_dpm.h
+++ b/drivers/gpu/drm/radeon/r600_dpm.h
@@ -119,8 +119,7 @@ enum r600_display_watermark {
 	R600_DISPLAY_WATERMARK_HIGH = 1,
 };
 
-enum r600_display_gap
-{
+enum r600_display_gap {
     R600_PM_DISPLAY_GAP_VBLANK_OR_WM = 0,
     R600_PM_DISPLAY_GAP_VBLANK       = 1,
     R600_PM_DISPLAY_GAP_WATERMARK    = 2,
-- 
2.17.1


