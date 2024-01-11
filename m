Return-Path: <linux-kernel+bounces-23036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C782A68A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C515F1F23100
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A7ED2;
	Thu, 11 Jan 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GmqZkFBX"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980FEEBC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=v57R1jLSOBEmIwmR3M
	h9K+MSfk+/r8sp7qXL2m+Pfrw=; b=GmqZkFBXrsDiphv9FErux9NQGsAFzMZZhS
	99zqb6AX4hTnKIsqRQx2slI5zlIDZCJgO8Y5d3vIp/VkHRhqVLMo0lhFVvbNFUbb
	xQxZumR/BEsv9NBbVCUydg/HXckRVxRap3WUxdxsT0uqlyND3Iprq+BDuK2AwK9o
	Ud4LlvFIU=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDnL9ptYp9l5TovAA--.18315S2;
	Thu, 11 Jan 2024 11:37:18 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in v10_structs.h
Date: Thu, 11 Jan 2024 03:37:16 +0000
Message-Id: <20240111033716.7880-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnL9ptYp9l5TovAA--.18315S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF1DurW3ZF15CFg_yoW3CFc_C3
	WUJw13WFyUZFnYga12kF4fAFyvyF15ua1kZw43tF9IyFnrAr45ZryDGrn7try8uFsxJF1q
	va1vgF1fArnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQBixWVLYT9d-QABsv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/v10_structs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/v10_structs.h b/drivers/gpu/drm/amd/include/v10_structs.h
index c0e98a98a641..58002a83d1df 100644
--- a/drivers/gpu/drm/amd/include/v10_structs.h
+++ b/drivers/gpu/drm/amd/include/v10_structs.h
@@ -24,8 +24,7 @@
 #ifndef V10_STRUCTS_H_
 #define V10_STRUCTS_H_
 
-struct v10_gfx_mqd
-{
+struct v10_gfx_mqd {
 	uint32_t reserved_0; // offset: 0  (0x0)
 	uint32_t reserved_1; // offset: 1  (0x1)
 	uint32_t reserved_2; // offset: 2  (0x2)
-- 
2.17.1


