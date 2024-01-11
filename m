Return-Path: <linux-kernel+bounces-23327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367E82AB19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2261C23753
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E32111AF;
	Thu, 11 Jan 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qTnRWg+G"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6199FC01
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=4RnQa9j8lJke799FaJ
	Yqbse5UEFE3lI4nXdUQ6qOVAY=; b=qTnRWg+GKk2jAeGytCptI2ieD19igLkIbJ
	q8/5xVdHETzpS+PcAocI1L0GbhZdbaDBjlA61bx8V7BKvGSPdeCnaAcX7wMsPpgO
	s9zDXrzRie8oOgF/2SuzY2EzxsfvEHPu99APSKeVZbTFshjX+Pmk8Ywxp99hpnQi
	bwoGhkbn4=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3f9M7tp9le8c2AA--.42261S2;
	Thu, 11 Jan 2024 17:34:51 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm/radeon: Clean up errors in radeon.h
Date: Thu, 11 Jan 2024 09:34:50 +0000
Message-Id: <20240111093450.14174-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f9M7tp9le8c2AA--.42261S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kKrWDGw1kWFy3Kry7trb_yoW3ZFb_Cw
	10q3y7XayvgFnaqFnxuF1UuFZ0kw409r48Cw1xtryftry7Xr1fZF9xGF1UXw45JayfXFn8
	Aw4kXFy3GrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBJixWVLZWlesAABsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/radeon.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 3d3d2109dfeb..3e5ff17e3caf 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1355,14 +1355,12 @@ struct radeon_dpm_thermal {
 	bool               high_to_low;
 };
 
-enum radeon_clk_action
-{
+enum radeon_clk_action {
 	RADEON_SCLK_UP = 1,
 	RADEON_SCLK_DOWN
 };
 
-struct radeon_blacklist_clocks
-{
+struct radeon_blacklist_clocks {
 	u32 sclk;
 	u32 mclk;
 	enum radeon_clk_action action;
-- 
2.17.1


