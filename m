Return-Path: <linux-kernel+bounces-23039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEB82A68F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A81DB22046
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E37ED4;
	Thu, 11 Jan 2024 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IzoZqaRi"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C9EC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=JwXJ7fsA7cmpEsjrHf
	poNIoh9mNuYfp1hWQOmX7j+rI=; b=IzoZqaRilSg/3KjdcmmV4DW+TUw3wiBcXH
	tAqOrsPjVitnUOVRQyuBwBbXc/uPn0FKCrq7eI85Flvb1Sx1tmGGJYhygijxuB8U
	RydRgK8Ni6K/lNyVIaQ9gVQyyNx12ndHPy60O4JZGP2AAPWjzk7vBqM2EtHEm/zh
	GgeQR1RGU=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnj8b0Yp9ljy6eAA--.25586S2;
	Thu, 11 Jan 2024 11:39:32 +0800 (CST)
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
Subject: [PATCH] drm/amd/display: Clean up errors in renoir_ip_offset.h
Date: Thu, 11 Jan 2024 03:39:30 +0000
Message-Id: <20240111033930.8056-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnj8b0Yp9ljy6eAA--.25586S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF1kKF4Dtw1DKFg_yoW3KFX_Ca
	4xGws5WrWI9FnIqF1IyFn3Za4q93W09FykWw4rtFy5trnrCr1UW3y5Jr9rXr4ruFZxGFsr
	Zan5WFy5XrnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhdixWVEuXuEDQAAsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/renoir_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/renoir_ip_offset.h b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
index 7dff85c81e5a..fa023cfdf72d 100644
--- a/drivers/gpu/drm/amd/include/renoir_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
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


