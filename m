Return-Path: <linux-kernel+bounces-22980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475B882A603
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA21C22EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F2A3C;
	Thu, 11 Jan 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IqhOuiAf"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DB7FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=SALJLRmBOXzxBM8mcf
	sgEpWIGewiMx1rbO76aYGKWys=; b=IqhOuiAf9hGx6agbB6/LPBHc2iIGlyGfD9
	edcTWvkWsZI2jtKzWjJbu5asdpmnqV4Xw5hz/vjTwD0jCig6j0YIxl15oT0uteXT
	q7rGeqUW9EuQ0ZtAWD4FgYE9NlqgRYEU4H3iKDbO5O71Ls9g7MNsneqOB4WBRb/f
	0S9ArffuY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3f1IHUp9lQUUtAA--.20942S2;
	Thu, 11 Jan 2024 10:27:20 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu.h
Date: Thu, 11 Jan 2024 02:27:18 +0000
Message-Id: <20240111022718.6415-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f1IHUp9lQUUtAA--.20942S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF1fuF4rZr15CFg_yoWkXFb_CF
	WUAF98Wr43GFnYqr13uw4fZ3yqvr1YvF1kWw1agF9ayr9rZrW5ArWDCryxXw4fua1xWF1D
	u39Ygr15C3ZakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHA5ixWV2zz6dAAAAsK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..189bf62076f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,14 +114,12 @@
 
 #define MAX_GPU_INSTANCE		64
 
-struct amdgpu_gpu_instance
-{
+struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
 	int				mgpu_fan_enabled;
 };
 
-struct amdgpu_mgpu_info
-{
+struct amdgpu_mgpu_info {
 	struct amdgpu_gpu_instance	gpu_ins[MAX_GPU_INSTANCE];
 	struct mutex			mutex;
 	uint32_t			num_gpu;
@@ -140,8 +138,7 @@ enum amdgpu_ss {
 	AMDGPU_SS_DRV_UNLOAD
 };
 
-struct amdgpu_watchdog_timer
-{
+struct amdgpu_watchdog_timer {
 	bool timeout_fatal_disable;
 	uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
 };
-- 
2.17.1


