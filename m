Return-Path: <linux-kernel+bounces-23197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205682A8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D051F22909
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7FDDB6;
	Thu, 11 Jan 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AaxgRjc7"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B7DDA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Ec0SMURkHcRLbm9pR8
	p3/Y4NEdzpA/NYtXmEiNFKUR8=; b=AaxgRjc7rY6+RThdQlV5O8IjXjitP6pBmR
	S3LtCfx7XAboWi+WKhAOrjmY2UUoisqSERwpqsQiIiIivSYJDR67b8A6qg/JbrwP
	NFCIvH9AicjJRglkpNzDRQdc6qzotreEnYqEnZRRi+uYZZ5bjS+8BqzU+DvR2X8F
	eGYZHC5cA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnb5FbpJ9lFPKUAA--.20884S2;
	Thu, 11 Jan 2024 16:18:35 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in radeon_asic.c
Date: Thu, 11 Jan 2024 08:18:34 +0000
Message-Id: <20240111081834.11664-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnb5FbpJ9lFPKUAA--.20884S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4kWr13GFW5Zr47KFyDWrg_yoWDuFcEgr
	WDZryxJas2yF93WF17Cr1jkFySkr409rWrWF12q3WFqry8WryxXFW5JFyUZw4UX3Wakr1D
	Jr18KFnxJrs3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEB5i1mVOBk+DQQACsY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '||' (ctx:VxE)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_asic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_asic.c b/drivers/gpu/drm/radeon/radeon_asic.c
index 802b5af19261..b5a0109b2e2c 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.c
+++ b/drivers/gpu/drm/radeon/radeon_asic.c
@@ -2400,10 +2400,10 @@ int radeon_asic_init(struct radeon_device *rdev)
 	case CHIP_RS880:
 		rdev->asic = &rs780_asic;
 		/* 760G/780V/880V don't have UVD */
-		if ((rdev->pdev->device == 0x9616)||
-		    (rdev->pdev->device == 0x9611)||
-		    (rdev->pdev->device == 0x9613)||
-		    (rdev->pdev->device == 0x9711)||
+		if ((rdev->pdev->device == 0x9616) ||
+		    (rdev->pdev->device == 0x9611) ||
+		    (rdev->pdev->device == 0x9613) ||
+		    (rdev->pdev->device == 0x9711) ||
 		    (rdev->pdev->device == 0x9713))
 			rdev->has_uvd = false;
 		else
-- 
2.17.1


