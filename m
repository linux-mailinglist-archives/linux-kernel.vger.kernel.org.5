Return-Path: <linux-kernel+bounces-22959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9582A5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D122A28643B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738D6814;
	Thu, 11 Jan 2024 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cn7doCYF"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CCA624
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=KdUUDYvSzX2aLBBWbi
	3BCMON0RRUsN174eNH7Lp4JK0=; b=cn7doCYFRxr534/ey/5uDuSuNBHqLewubb
	bid7TNG+MZW0pQxURW6BG20IiJAO3QgHHWqqsp1j3OVM1egv+3Rx3fuSxAoBULm4
	rvZOyT4oSmL4s3OpHw8mXlc3JCgJl228SeVHOiKICQyEm3dWBzL/fXFPLObOMniU
	7YsX8oXaE=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3_+lmTp9lDlacAA--.16717S2;
	Thu, 11 Jan 2024 10:11:51 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd: Clean up errors in amdgpu_vkms.c
Date: Thu, 11 Jan 2024 02:11:48 +0000
Message-Id: <20240111021148.5883-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_+lmTp9lDlacAA--.16717S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFW8uFW5Jw4DCFg_yoWfWFX_C3
	yUXr4kWr43JF1qvr1UZr4rZ3yvy3W5CF4kWrySqanavry7ZayYqayDuryUXa1ruF4xW3Zx
	Xr1vgF13AasxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUnXo7UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGAdixWVLZWKsDgAAsz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 453a4b786cfc..8baa2e0935cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -660,8 +660,7 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
 	.set_powergating_state = amdgpu_vkms_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version amdgpu_vkms_ip_block =
-{
+const struct amdgpu_ip_block_version amdgpu_vkms_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 1,
 	.minor = 0,
-- 
2.17.1


