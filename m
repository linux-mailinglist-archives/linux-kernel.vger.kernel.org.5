Return-Path: <linux-kernel+bounces-22976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2682A5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B92B287A98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E383239;
	Thu, 11 Jan 2024 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="V487I366"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20C256D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=nbbVvUF/7Gsgkfq6Xu
	1euEZczf3yX7tnXLat+g/jEbg=; b=V487I3661EHGOrtHEJZmbZzrAKmx1eYtqw
	bjlRIlNd35Bwg8dtgjQt6rb9z+QAzxA3xoPQdMRNsGglKIjWrlOf3Nxs0/+sITr+
	9nwhILbhYRLul9cXM8NWSs8DGCTUedXsa93jyOR6aPlnhSOSlo0UtgWQgM+5Bi8Q
	C6BGBvTzc=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD331ppUZ9lMjQtAA--.21367S2;
	Thu, 11 Jan 2024 10:24:41 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in jpeg_v2_5.c
Date: Thu, 11 Jan 2024 02:24:37 +0000
Message-Id: <20240111022437.6239-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD331ppUZ9lMjQtAA--.21367S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWDWry7JF13Jry3Ary3twb_yoW8WFWUpa
	93AFy5urs5CFnFv3ZrX3WDZFnYkw13u3W5CrWUJw1fu3W5Jr98X3s7tFy5Z340qFWxCrWI
	vr48t3y7X3WIvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRijjPUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHAxixWV2zz6PUgAAsI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index e67a337457ed..99cd49ee8ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -551,7 +551,7 @@ static int jpeg_v2_5_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
-	if(state == adev->jpeg.cur_state)
+	if (state == adev->jpeg.cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -559,7 +559,7 @@ static int jpeg_v2_5_set_powergating_state(void *handle,
 	else
 		ret = jpeg_v2_5_start(adev);
 
-	if(!ret)
+	if (!ret)
 		adev->jpeg.cur_state = state;
 
 	return ret;
@@ -754,8 +754,7 @@ static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_ip_block_version jpeg_v2_5_ip_block =
-{
+const struct amdgpu_ip_block_version jpeg_v2_5_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_JPEG,
 		.major = 2,
 		.minor = 5,
@@ -763,8 +762,7 @@ const struct amdgpu_ip_block_version jpeg_v2_5_ip_block =
 		.funcs = &jpeg_v2_5_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version jpeg_v2_6_ip_block =
-{
+const struct amdgpu_ip_block_version jpeg_v2_6_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_JPEG,
 		.major = 2,
 		.minor = 6,
-- 
2.17.1


