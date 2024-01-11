Return-Path: <linux-kernel+bounces-23130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2482A80E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C5FAB235E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DCCA7B;
	Thu, 11 Jan 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UDc3Zxz7"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6733ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2m6d3Tey7P5JZiYMjw
	JuGuygHTrtdi5Q/T031eQd4Sc=; b=UDc3Zxz7W0UtNFDfXMCPMeAGO3cvDlqW2T
	yyrxmGlfe/VR3He8Dm2rV0PQmAeCuR/FGDtuQuaq1YD1O1nd7RZt0EjWtFW8u3h8
	gCy3Ogjc5RTGiX9SbIFbG9K96GSb9G9IC/rSUYZgEmyJyjE2AXUBLT+8Y2RQg0WZ
	F7dZCTM9o=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3H5_jlJ9l3f6QAA--.20765S2;
	Thu, 11 Jan 2024 15:12:35 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: zackr@vmware.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/vmwgfx: Clean up errors in vmwgfx_so.c
Date: Thu, 11 Jan 2024 07:12:33 +0000
Message-Id: <20240111071233.9867-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H5_jlJ9l3f6QAA--.20765S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy8tFWUGFy7XFyUXr1UKFg_yoW3AFc_GF
	y8GrWxXrWUXF1Y93WI93yqvr12vw1rZrs7Zw1UKa47GF1xAr4vk3s7CFyDJw1xGF1DWF4D
	tw48WFn3ArW7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqBFi1mVOBk7KXgABs7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '=' (ctx:VxW)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index d199e718cb2d..124e583edf11 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -527,7 +527,7 @@ const SVGACOTableType vmw_so_cotables[] = {
 	[vmw_so_rs] = SVGA_COTABLE_RASTERIZERSTATE,
 	[vmw_so_ss] = SVGA_COTABLE_SAMPLER,
 	[vmw_so_so] = SVGA_COTABLE_STREAMOUTPUT,
-	[vmw_so_max]= SVGA_COTABLE_MAX
+	[vmw_so_max] = SVGA_COTABLE_MAX
 };
 
 
-- 
2.17.1


