Return-Path: <linux-kernel+bounces-18591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C1B825FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F9283D14
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2779E1;
	Sat,  6 Jan 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOtG4yaR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AB79C3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbd6e37a9bso591504b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704550499; x=1705155299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70BmQ1AAqBQF/HMHseYDQ1nTDNOHkvcVEOwfs5CBfAw=;
        b=XOtG4yaRuQko11eLz9TgCAdWPCyv61OKM/sqlt+ObOmFY06bXEKndh5uC9B1b8R2Bv
         x5T+PutvcEJ+Bn57SQsgGwSv8a6co2wmK/uKYTuF0I4zII8XrQ4WV5WXxdxpVol1RnDe
         sEL7GyXi+CL6oxOKHwXQvvVjFb3TKC5T9VnL70EGitgynCAMU3r/32m04zxlKsbkKrqt
         twJ6CrzEX1Y2oHJ8CNXcvUaSyHOElNmbqoDiB/r56rYSD7j7LxNvBiPXa+lu+V32DWr+
         vhJIcf2fhtq7iMzMUw4ERXMyTaWY5uZunmgg71V1euv1RKdoTXdWU2Qc7rUL71YWcMB9
         sPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704550499; x=1705155299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70BmQ1AAqBQF/HMHseYDQ1nTDNOHkvcVEOwfs5CBfAw=;
        b=VNrnIn/8GfyY3FlRFYEVQDNq4GxCpDgViKakD6mLouFhCbNmruSkjwrYzuNZT8i+o2
         DM4f/S4giCUD5yZ4OM7uUWH6OyXOk8A12pZvpH2g1aYu9izumgPxVAhCI4+sibXr8v7a
         fT+78sPeHuXvLn42DztvUGjkSyL6i+rSyoVdfnJne/SBTMQcyV4rm9/yGUnIejOJ6668
         ERnQ8MQrLCB69hic4kM5usCVs3ZbwvT3G4ohJMD6heLnZPgALqULbDnfST2sXX2MN/8m
         ahGn5l2trJjRHrIad4zX99D/KDu1KW1jhtdI1nlvWA3f4iDpCvSLSfxI/JBWDuiAM0Ak
         7h0w==
X-Gm-Message-State: AOJu0Yzn52q7tWIkE/5uuzO7PiHRToIA9zgrgHdBXAkNhV5uReRXAFbx
	1JoHIHgJHtUcwAh0XRSl7Tk=
X-Google-Smtp-Source: AGHT+IGSdb9c7+Nu8KHp/gytkNLMwMgd3BPpCK1bPyMhFIqjH0pYoq/PPNkGN5lmBKH/185POMYmVA==
X-Received: by 2002:a05:6358:70c:b0:170:ee27:bfa1 with SMTP id e12-20020a056358070c00b00170ee27bfa1mr986956rwj.5.1704550498730;
        Sat, 06 Jan 2024 06:14:58 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.. ([202.43.120.140])
        by smtp.gmail.com with ESMTPSA id qj14-20020a17090b28ce00b0028afdb88d08sm3050268pjb.23.2024.01.06.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 06:14:58 -0800 (PST)
From: Dipam Turkar <dipamt1729@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH 1/1] Refactor radeon driver to use drm_gem_create_map_offset() instead of its custom implementation for associating GEM object with a fake offset. Since, we already have a generic implementation, we don't need the custom function and it is better to standardize the code.
Date: Sat,  6 Jan 2024 19:44:23 +0530
Message-Id: <20240106141422.10734-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c | 24 ++----------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index fa531493b111..f590ed65ffba 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -578,7 +578,7 @@ static const struct drm_driver kms_driver = {
 	.ioctls = radeon_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(radeon_ioctls_kms),
 	.dumb_create = radeon_mode_dumb_create,
-	.dumb_map_offset = radeon_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_dumb_map_offset,
 	.fops = &radeon_driver_kms_fops,
 
 	.gem_prime_import_sg_table = radeon_gem_prime_import_sg_table,
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 358d19242f4b..99794c550d2c 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -31,6 +31,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
+#include <drm/dem_gem.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/radeon_drm.h>
 
@@ -480,33 +481,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-int radeon_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p)
-{
-	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
-
-	gobj = drm_gem_object_lookup(filp, handle);
-	if (gobj == NULL) {
-		return -ENOENT;
-	}
-	robj = gem_to_radeon_bo(gobj);
-	if (radeon_ttm_tt_has_userptr(robj->rdev, robj->tbo.ttm)) {
-		drm_gem_object_put(gobj);
-		return -EPERM;
-	}
-	*offset_p = radeon_bo_mmap_offset(robj);
-	drm_gem_object_put(gobj);
-	return 0;
-}
-
 int radeon_gem_mmap_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp)
 {
 	struct drm_radeon_gem_mmap *args = data;
 
-	return radeon_mode_dumb_mmap(filp, dev, args->handle, &args->addr_ptr);
+	return drm_gem_dumb_map_offset(filp, dev, args->handle, &args->addr_ptr);
 }
 
 int radeon_gem_busy_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1


