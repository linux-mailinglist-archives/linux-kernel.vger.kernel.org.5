Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193937E8320
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjKJTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbjKJTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:49:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F549760
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:42:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc5b705769so21089495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699641738; x=1700246538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DowCvdW0pDIOEX7tuv7ZCgDtza6+DGAzWVpe/6IiP+A=;
        b=NJvYE+Y+3hmhs9cgT3eBf17m0vk+Rz9eAp0d+MWATX+WCr5UamVSy6n8OgPpuZB3yh
         xKVEItv0A9JocTQ1rRwaoJwqwfkg22S1xoa5hOeRop3ZAM7MgrSt47cCd8q7+6jZ2ER5
         E0TJUbl56gGJV139fQquPwjTooDfRO88Alg1cT5aeHmShvyGotom10ZJOl+f0xwnW/Kx
         R9uoj8Y9ueTDnTWti9ebrbtryjPCzSCtAtTYZvtWkk2UKKY291cV3kM9faGP/xAYkCJN
         2c7E1wzmJNDARaMqkn2q2vmeC537vxyrE6414ShOhIJxRKy3qv+wUKSfj6JoQ6Wwaiaa
         CxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699641738; x=1700246538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DowCvdW0pDIOEX7tuv7ZCgDtza6+DGAzWVpe/6IiP+A=;
        b=MVIjTa5b2xGJU909ZfVyjnH1q5Ob3ppO2EF1VCyc2lKxXNxezVP94jGslykH+MFor0
         FGh7GBKphhvCa7+GfNUWXrd7OaK9IcGhiKHizNep6dyuIsUUNBwmL/NGMACA1jqAKMaW
         i4g+u6k2hkCBl2apmiiLWtHQXvM1sEYai7f1wia5wnksDbmObUFJSfwy5PQ0mgFCh2Vc
         GmnQZl0fLi+nhsEuSgkQ0WDM3pbd7Ib2VaKyDy6ZMGynZZKl80PH1enrDikRohp93ieO
         O1Cg+BET4r7mymoepqxUz/WsSMwAcM/c0AOAEm5hiPEmVttWmHEGYc0CavMzYcMd9H8E
         /KPQ==
X-Gm-Message-State: AOJu0Yw6VL5D9+GdA+CGPy+vzGQXmw5cRVzAOt0j+BjR3hR5a4Uki7kv
        YjcoWGWQlgkBlvnhG4dHoGg=
X-Google-Smtp-Source: AGHT+IEaHe6OpOyydZLuU/Eb6sIh2hJuHc+75WIRpZyaHbDGrKlsVr40ZUBVLX6h23BIrXqUvDQHQg==
X-Received: by 2002:a17:902:d484:b0:1c9:bca2:d653 with SMTP id c4-20020a170902d48400b001c9bca2d653mr110956plg.11.1699641737756;
        Fri, 10 Nov 2023 10:42:17 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.gateway.iitmandi.ac.in ([14.139.34.151])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001b86dd825e7sm5705495plb.108.2023.11.10.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:42:17 -0800 (PST)
From:   Dipam Turkar <dipamt1729@gmail.com>
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH v2] Remove custom dumb_map_offset implementations in i915 driver
Date:   Sat, 11 Nov 2023 00:11:27 +0530
Message-Id: <20231110184126.712310-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making i915 use drm_gem_create_mmap_offset() instead of its custom
implementations for associating GEM object with a fake offset.

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 21 ---------------------
 drivers/gpu/drm/i915/gem/i915_gem_mman.h |  4 ----
 drivers/gpu/drm/i915/i915_driver.c       |  3 ++-
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index aa4d842d4c5a..71d621a1f249 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -771,27 +771,6 @@ __assign_mmap_offset_handle(struct drm_file *file,
 	return err;
 }
 
-int
-i915_gem_dumb_mmap_offset(struct drm_file *file,
-			  struct drm_device *dev,
-			  u32 handle,
-			  u64 *offset)
-{
-	struct drm_i915_private *i915 = to_i915(dev);
-	enum i915_mmap_type mmap_type;
-
-	if (HAS_LMEM(to_i915(dev)))
-		mmap_type = I915_MMAP_TYPE_FIXED;
-	else if (pat_enabled())
-		mmap_type = I915_MMAP_TYPE_WC;
-	else if (!i915_ggtt_has_aperture(to_gt(i915)->ggtt))
-		return -ENODEV;
-	else
-		mmap_type = I915_MMAP_TYPE_GTT;
-
-	return __assign_mmap_offset_handle(file, handle, mmap_type, offset);
-}
-
 /**
  * i915_gem_mmap_offset_ioctl - prepare an object for GTT mmap'ing
  * @dev: DRM device
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.h b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
index 196417fd0f5c..253435795caf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
@@ -20,10 +20,6 @@ struct mutex;
 int i915_gem_mmap_gtt_version(void);
 int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma);
 
-int i915_gem_dumb_mmap_offset(struct drm_file *file_priv,
-			      struct drm_device *dev,
-			      u32 handle, u64 *offset);
-
 void __i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
 void i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index d50347e5773a..48d7e53c49d6 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -42,6 +42,7 @@
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1826,7 +1827,7 @@ static const struct drm_driver i915_drm_driver = {
 	.gem_prime_import = i915_gem_prime_import,
 
 	.dumb_create = i915_gem_dumb_create,
-	.dumb_map_offset = i915_gem_dumb_mmap_offset,
+	.dumb_map_offset = drm_gem_dumb_map_offset,
 
 	.ioctls = i915_ioctls,
 	.num_ioctls = ARRAY_SIZE(i915_ioctls),
-- 
2.34.1

