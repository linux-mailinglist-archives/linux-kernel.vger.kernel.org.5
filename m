Return-Path: <linux-kernel+bounces-23005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1921282A647
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F51CB25AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3AEBC;
	Thu, 11 Jan 2024 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Z2PZsadU"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C047A4A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=X7/hcIuRpwjcQd9lz0
	bnRT1q5+i9Qj9IDqkJ2j/QrPY=; b=Z2PZsadU1dI6DoCqXI2h/DRaptgIrAPtm9
	Q4txrSrI/PcIGLF/Dd0A8nrUG5cauJqcFrbFVuRmEHs9DGMBG/phCqmO6o+wNkXy
	GyAhNYAku9ah0QpMuLcqv1A1UOPcF3DJBnXeD1PRl7D5InITK3E5CpXERelxuyy+
	lt0F8Deis=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD33wLmWZ9lnk+dAA--.4894S2;
	Thu, 11 Jan 2024 11:00:54 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in navi12_ip_offset.h
Date: Thu, 11 Jan 2024 03:00:53 +0000
Message-Id: <20240111030053.6868-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD33wLmWZ9lnk+dAA--.4894S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48Kr4kWryDJw47urg_yoW3KFX_Ca
	4xJ3s3WrWxWFn2qFsFkFWxZ34jka18uFn3Xw4rtFy5trsrAr18W3y5Gr47XrWruFnIgFZr
	Za1kWFy5XrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_OzPUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQ5ixWVLYT6tKAABsF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/navi12_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
index d8fc00478b6a..e94d80ec8d92 100644
--- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1


