Return-Path: <linux-kernel+bounces-22957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60082A5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0057B228CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C163809;
	Thu, 11 Jan 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cUB6xS97"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A47EA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/edpYkM+PNIoAN1Kxh
	JjCCs+q3EKzpx73YhOFtEdW1M=; b=cUB6xS97xPoHQsQ0MRGgpfstci0Y6vPR2Q
	fYKKHcEhcJVaulNcumcDVIb4gwTgHBXTeGP1dIkbXL83W7tfPB2WDxyUA0uzxTNa
	OzFNES+NIp8dvNXs2kMQ3bBDLAMJCBJ3gEAICGX5DLWWIJ5W4EdcMvMjVufuTrou
	q6H4D3coA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3X4H8TZ9lvImbAA--.9890S2;
	Thu, 11 Jan 2024 10:10:04 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: Xinhui.Pan@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_rlc.c
Date: Thu, 11 Jan 2024 02:10:02 +0000
Message-Id: <20240111021002.5795-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X4H8TZ9lvImbAA--.9890S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15Zr1UKryDCryDKFWfKrg_yoW3trc_CF
	W7XryDXrW3ZFnFqr15Zw4rZ34jyr15uF4kWr1fJas3try7Z3yUAryDuF1jqw1ruF1xGF97
	Xw1vgFZ8AanrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUeyIUUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWR5ixWVLYT2tOwAAsE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that '++' (ctx:WxB)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 35e0ae9acadc..a6b66e393a5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -241,7 +241,7 @@ void amdgpu_gfx_rlc_setup_cp_table(struct amdgpu_device *adev)
 			table_size = le32_to_cpu(hdr->jt_size);
 		}
 
-		for (i = 0; i < table_size; i ++) {
+		for (i = 0; i < table_size; i++) {
 			dst_ptr[bo_offset + i] =
 				cpu_to_le32(le32_to_cpu(fw_data[table_offset + i]));
 		}
-- 
2.17.1


