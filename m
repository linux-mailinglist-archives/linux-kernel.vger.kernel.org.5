Return-Path: <linux-kernel+bounces-22978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276E82A5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F41C1C22F38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570B20E0;
	Thu, 11 Jan 2024 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AcDNtnxK"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A31866
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=zK0YN430fRG/wJDkOy
	RLzq+lusy5pMsnDcFSbdS1ltM=; b=AcDNtnxK4AP42mE+SXzZ2l0GbvwP18wR6/
	XVmquiHVemvyVfdD8n0uqW8iOq0kVpxy6Nrz6ZjN80zLSPsHRnoJhUoLcbn67xRa
	YUEGL7Jy5w+6Xve7AuSO1hltSBVyfMcnPqkueti9Sb4tPs0SELsKrf/p2x3Fg1om
	m5UJ5n5ec=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3P7u1UZ9lyIUtAA--.14199S2;
	Thu, 11 Jan 2024 10:25:57 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_gmc.c
Date: Thu, 11 Jan 2024 02:25:56 +0000
Message-Id: <20240111022556.6327-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P7u1UZ9lyIUtAA--.14199S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW8Zw17Wry7Kr1ruw4UJwb_yoWDurX_Cr
	W7Xwn5Kr13AF92qF13Z3yYqw1DtFy5ur4kWr12yFn3t343Z348AryjgryfXay8u3WxGFyD
	uw1YgrWYya9xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhpixWVEuXoZjAAAsw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: need consistent spacing around '-' (ctx:WxV)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d2f273d77e59..a5d2cda33266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -52,7 +52,7 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
 	struct amdgpu_bo_param bp;
 	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size + 21;
-	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) -1) >> pde0_page_shift;
+	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) - 1) >> pde0_page_shift;
 
 	memset(&bp, 0, sizeof(bp));
 	bp.size = PAGE_ALIGN((npdes + 1) * 8);
-- 
2.17.1


