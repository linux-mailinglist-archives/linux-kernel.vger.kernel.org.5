Return-Path: <linux-kernel+bounces-23134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8182A81C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404C92879BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E122D267;
	Thu, 11 Jan 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EFzLr2LX"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1ECA64
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=NVv+cF4ZY8iq/CxQeH
	wl4R+lCg49TLG4aEk69o7hTFU=; b=EFzLr2LXADX7hN17Xu5LR2p88UxVgrAwuG
	lCJ3oSxEqqXQefttVaSM9EnPqSyN1mV4FATKLfkKNZX0HMS42hblMeQSlq3s4PWb
	M5mSOteuafFGOHJa1HP9vnX0E+JMLYtxlMFYWYcrDblBYrVRXdgX6OlGf5IPYacM
	iA0UMBM8g=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnT_molZ9lUXaQAA--.18825S2;
	Thu, 11 Jan 2024 15:15:53 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: zackr@vmware.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/vmwgfx: Clean up errors in vmwgfx_msg.c
Date: Thu, 11 Jan 2024 07:15:52 +0000
Message-Id: <20240111071552.9970-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnT_molZ9lUXaQAA--.18825S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryfAr4UXr4xXF4xKF18Grg_yoWDCrXEk3
	WUGr43XFWDuF98uw12v39rJ34ay3W5uFZ3u3Wxt3W3G3Z2qw47Wry3Wr9xJa4fWF45GFZr
	Crs5GFnayrsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEARi1mVOBk30WAABst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* const bar" should be "foo * const bar"
ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 2651fe0ef518..b56936f95d31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -87,8 +87,7 @@ struct rpc_channel {
 
 #if IS_ENABLED(CONFIG_DRM_VMWGFX_MKSSTATS)
 /* Kernel mksGuestStats counter names and desciptions; same order as enum mksstat_kern_stats_t */
-static const char* const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] =
-{
+static const char * const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] = {
 	{ "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
 	{ "vmw_cotable_resize", "vmw_cotable_resize" },
 };
-- 
2.17.1


