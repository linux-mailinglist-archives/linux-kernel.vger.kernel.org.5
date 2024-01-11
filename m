Return-Path: <linux-kernel+bounces-23128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703B82A80A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53983B263F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B6D287;
	Thu, 11 Jan 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="alv8AIjE"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF51D26A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=WlG3u4VI90oQ5dQx7O
	3zDbT6BFxAUYMaGnbgXPVYfkc=; b=alv8AIjEI43QFMds5jF3YyTT8y3DIYGr+S
	CGXx/to9Lo0plMkEIdflmsBQLtAtmL4rbnQquKrJgVm5YJuZVVzBmCNJ2Zj1iTfh
	NK4yMvZBR+g8cJoKaa+PjHwyT5OYcGCypkMu3GxRmLppZAA05E25WKHQE/LShN6R
	KlhNbKgPI=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3v0cylJ9l+gSRAA--.56957S2;
	Thu, 11 Jan 2024 15:09:38 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	spice-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] dma-buf: Clean up errors in qxl_release.h
Date: Thu, 11 Jan 2024 07:09:36 +0000
Message-Id: <20240111070936.9693-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3v0cylJ9l+gSRAA--.56957S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur13Ww1fXFyUZr48AF4Utwb_yoW3Gwb_WF
	4UXrnrWrsrCF1DC3W7A3y5ZrZIvF98uFWku3Z8tFy3Jry7Ar4UX34qkrZxZ348ZFZrCFsx
	Aa1kXrsxArn3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjjQ6tUUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBNi1mVOBk7AagAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: else should follow close brace '}'

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..7f7aa7a62629 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -299,8 +299,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 	} else if (type == QXL_RELEASE_CURSOR_CMD) {
 		cur_idx = 2;
 		priority = 1;
-	}
-	else {
+	} else {
 		DRM_ERROR("got illegal type: %d\n", type);
 		return -EINVAL;
 	}
-- 
2.17.1


