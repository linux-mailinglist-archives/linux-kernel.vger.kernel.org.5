Return-Path: <linux-kernel+bounces-23230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400882A935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D28F284F19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242BF9F3;
	Thu, 11 Jan 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HJkso97m"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C56F9C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=pqAv59DnHmAlYYjDto
	1NDLdVrv6L33IDTawGCAaJOeU=; b=HJkso97mQtk9PZ9uFr5mcW836PxwccLtOb
	84z+xkNYHH9DBmzfBGPCHu/78SKbIGkrdFGr2xjqRCO+YnIX++tmeqKjyMIRYxQG
	uEGjKxpm4ONC68Lws3CEzroIwIyPZ0B4WyXljuyXoOCTHbrrHGRC6xImJehLNQih
	0XnXO98zw=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDH76ZuqJ9lXb2UAA--.19493S2;
	Thu, 11 Jan 2024 16:35:58 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in rs600.c
Date: Thu, 11 Jan 2024 08:35:56 +0000
Message-Id: <20240111083556.12325-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDH76ZuqJ9lXb2UAA--.19493S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFy5Kry8JFWfuFg_yoW3Xwb_C3
	WUXrs7uay0yr9Y9F12vr4DZr92vw409FZ3G3WIy3WxKry2qr1fua4DKr1Yqw48WFsrXF1D
	Ja1vqF13CrsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBNi1mVOBlDa0AAAs4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/rs600.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 8cf87a0a2b2a..5c162778899b 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -54,8 +54,7 @@
 static void rs600_gpu_init(struct radeon_device *rdev);
 int rs600_mc_wait_for_idle(struct radeon_device *rdev);
 
-static const u32 crtc_offsets[2] =
-{
+static const u32 crtc_offsets[2] = {
 	0,
 	AVIVO_D2CRTC_H_TOTAL - AVIVO_D1CRTC_H_TOTAL
 };
-- 
2.17.1


