Return-Path: <linux-kernel+bounces-23006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCC82A648
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7DEB20DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943B10FD;
	Thu, 11 Jan 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ElB+FNBR"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0B10E1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=B6dg5XI085eV8ar8x1
	7LtMcKlb86pt7nPrHs8KNxFgY=; b=ElB+FNBRtpWItIqntaJc7jA4kVs/jsGUyz
	hO0Ec1dg89ejF4rANJDabVD4WmheS2MAS1m2ISB8MZq7lu0SlHA4u7eGNnv3djcx
	dyN8ynObSqmfSDb4uD1g7Fo6PNWtglSiMe3t/5i5sAzOPh+tvqpTFKemSKxn0Nje
	N78NCc/R0=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDX_6BkWp9lAXydAA--.35605S2;
	Thu, 11 Jan 2024 11:03:01 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in kgd_pp_interface.h
Date: Thu, 11 Jan 2024 03:02:59 +0000
Message-Id: <20240111030259.6956-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDX_6BkWp9lAXydAA--.35605S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1kGF1xAF1xGr18KF13twb_yoWkJFX_Ca
	18Xw17XrWUXF9rA3ZxZF4xKry7K3W8CF1xXa43K3WSyF1rZw4Sqay7WF1UZ3WfuF4DGFWq
	kF4rXryFy3Z7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRK9atUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBdixWV2zz9UwQAAsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following enum go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 36a5ad8c00c5..82de10502e1b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -244,8 +244,7 @@ enum pp_df_cstate {
  * @PP_PWR_LIMIT_DEFAULT: Default Power Limit
  * @PP_PWR_LIMIT_MAX: Maximum Power Limit
  */
-enum pp_power_limit_level
-{
+enum pp_power_limit_level {
 	PP_PWR_LIMIT_MIN = -1,
 	PP_PWR_LIMIT_CURRENT,
 	PP_PWR_LIMIT_DEFAULT,
@@ -260,8 +259,7 @@ enum pp_power_limit_level
  * @PP_PWR_TYPE_FAST: manages the ~10 ms moving average of APU power,
  * where supported.
  */
-enum pp_power_type
-{
+enum pp_power_type {
 	PP_PWR_TYPE_SUSTAINED,
 	PP_PWR_TYPE_FAST,
 };
-- 
2.17.1


