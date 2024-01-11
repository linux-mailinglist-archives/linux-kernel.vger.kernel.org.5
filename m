Return-Path: <linux-kernel+bounces-23113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCB82A7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE5B25C61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743CC8F5;
	Thu, 11 Jan 2024 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="csxWlf9j"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB779E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=1gXnhZ66Ygt/sxM3Iu
	3BuDo8HgYk1gMQ33s6Qoaqb2c=; b=csxWlf9jmSrpm+h/fCPsCUXhUTSDqtgnzw
	rLZ9VejvOJf8n33gMZfXLiWizcdTGCLzzavnQy8SIFIB4gjm8UN0B1ImDHiheeHY
	JbR/1lRBtpg15HLWZ1dlgUT1fjc3PnwSk8YID8JuBh3QBhW2Hn0zu42A6WE2SkVP
	eFWihGNrY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3P9syjp9l+RqiAA--.12958S2;
	Thu, 11 Jan 2024 14:44:02 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: airlied@gmail.com,
	tzimmermann@suse.de,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm: Clean up errors in drm_dp_helper.h
Date: Thu, 11 Jan 2024 06:44:00 +0000
Message-Id: <20240111064400.8878-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P9syjp9l+RqiAA--.12958S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw18JFy7Gr1rZw4rCryfJFb_yoWfAwbE9F
	18X34DurnrCF1qqr1DAF4Sgr10kFnxZ3y8uF13Ka43AFy2vr1rt39Fvw4DX3W5Ar47XF1q
	q3Z7tFnavws7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZNVJUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGAtixWVLZWcFwAABsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before open square bracket '['

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index b1ca3a1100da..2704bf703040 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2133,7 +2133,7 @@ void drm_dp_aux_unregister(struct drm_dp_aux *aux)
 }
 EXPORT_SYMBOL(drm_dp_aux_unregister);
 
-#define PSR_SETUP_TIME(x) [DP_PSR_SETUP_TIME_ ## x >> DP_PSR_SETUP_TIME_SHIFT] = (x)
+#define PSR_SETUP_TIME(x)[DP_PSR_SETUP_TIME_ ## x >> DP_PSR_SETUP_TIME_SHIFT] = (x)
 
 /**
  * drm_dp_psr_setup_time() - PSR setup in time usec
-- 
2.17.1


