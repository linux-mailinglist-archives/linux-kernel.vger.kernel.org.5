Return-Path: <linux-kernel+bounces-162951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F48B62A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783121C21DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310E713F014;
	Mon, 29 Apr 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcelNvCm"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E313D267;
	Mon, 29 Apr 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419582; cv=none; b=XnyplDRv4XCpboGRO4wG81fA586zPqcAgqcDozq7LlNYC7dKBS/8qG38A8//bho+P0MCThn/kGaHtif7eFAWsZJzkRzb32ywicVZwjJsw0ze2xJ3Y+puxYSEW1gWlGz6l3U7CJ9txPfA+zIM5tcKyvRuLqXyGuSOkBSg20kvfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419582; c=relaxed/simple;
	bh=yy+cEM8e/rdBfX564thDF5ITGSohMnbYYqys5EU7+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw/kKfDw/YgzWxEFCvqaISSC7W3PIqWKHdpKIc8xhUa8HXvn22yW9UXbQ9UB0O/EOEqgs4IbEiBOQ/kOkDTN2VKEHK2CU0YlYrDW5Hj9LtVvUZVwAHFHfxCXIjUWJc26FJj3rDAK5SPLT87Wq6VjC0anv8dIRyzhIUJjrACnsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcelNvCm; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da939572b5so197143439f.2;
        Mon, 29 Apr 2024 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419580; x=1715024380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0MeHEZcsgFBBOIcW96muUaq6331rE39MA9kEHJFHdU=;
        b=OcelNvCmlRlN9Vi4Y64rikKlThM2Qly/EWdJO2IolpAsJoJBjX6WtZzMXWW9t/87r+
         v67LrERXJZ3LEkFX9P1Grdw2/3wVUO0y/WURFnRKfz7CJBkN2Z1OskXlPSxLcgR6uEy/
         5QUHLbeYFpuH23H48jbu8L+A/WMOfwjMubm/k2OdpGUTnDXiZgCiONZGAzacPdLSQcT8
         FDZpxXaQqGYvAtXGNKoOCnonI3P7OsS77pDI8cNJP58RjYOQ7kTlo+K1dYCzIdgXevdg
         FAO8CuPod89JJjpF3K3HvZvoGGoG4Jt1plud3R48v6jW2QNeXmc49XQ4q+7qg8ZiNZwm
         EnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419580; x=1715024380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0MeHEZcsgFBBOIcW96muUaq6331rE39MA9kEHJFHdU=;
        b=kzZE4ysNofIkAs6NzP323JR5mcphesfSMF1QF/3cA/Cfx2DP8u5++vg/AcgnXi3J48
         XDaqrB6XurI7yMvkP5bYo8TObXtU5LxGt+yrHopnw66/eBp4Jce/yUo6A53eN3+yrSmW
         ADBhLWJ4SOmzjboNN7Util5TByonybXzA9036f+9MXqVaWb6zwpnr/v+tzGUQ8pQoUP1
         tyxAFC28uELOs7HEL8tUEDFwOyjofHXCkeMRpx8IJSEzaMv4e2sQhxL+/44D/RYatOHP
         CPttYqVWAD5sEj4W+zTygnZm9KopB4XWYI55XUxKRQBbsikdC1FxuGsXjBwYvvYaYG7j
         0+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUlS0tLl6IQjQ+PDKr7jdqwtn3Ld4b/YRr9oLdsFk3tMzSOKNI0zuHI/IhYPPr2rOkcDxnE5mztTyCKs8GOomDpW1OqK8BNNv2PHheh+Ma+lZHHyx3J8IsG3tucX7y1GuMqyYpiajr4
X-Gm-Message-State: AOJu0YwGdpgs4sFCO0WfSFnewatf/ipwIdpFqFKIuyg7EKEe0IKaFvqE
	lR5JWfNE3ozrY+Px1RHAkVk16ORvBsNt/0Lg+fGnUe4iZP/YD3fL
X-Google-Smtp-Source: AGHT+IHlUVq3kyXnqc/U6UIcx1yMtr80xS3S0rVakdXkFmPbZcga6S+Hk2XVAzZ4ytI76/jmWP6Ckg==
X-Received: by 2002:a05:6602:275a:b0:7de:d935:de0a with SMTP id b26-20020a056602275a00b007ded935de0amr1639049ioe.0.1714419579920;
        Mon, 29 Apr 2024 12:39:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 30/35] drm+drivers: adapt to use DYNDBG_CLASSMAP_{DEFINE,USE}
Date: Mon, 29 Apr 2024 13:39:16 -0600
Message-ID: <20240429193921.66648-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow dynamic_debug API change from DECLARE_DYNDBG_CLASSMAP to
DYNDBG_CLASSMAP_{DEFINE,USE}.

Prior to this, we used DECLARE_DYNDBG_CLASSMAP, which was preserved to
decouple DRM conversion.  I'm unsure of the full functionality
in-between, a round of lkp-testing will help.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +-----------
 drivers/gpu/drm/drm_crtc_helper.c       | 12 +-----------
 drivers/gpu/drm/drm_print.c             | 25 +++++++++++++------------
 drivers/gpu/drm/i915/i915_params.c      | 12 +-----------
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 12 +-----------
 include/drm/drm_print.h                 |  8 ++++++++
 7 files changed, 26 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e4277298cf1a..b287f0cfd8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -217,17 +217,7 @@ int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index f5d4be897866..d3a7df09846f 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -41,17 +41,7 @@
 
 #include "drm_dp_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 struct dp_aux_backlight {
 	struct backlight_device *base;
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 2dafc39a27cb..e9d229a393f4 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,17 +50,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 699b7dbffd7b..4a5f2317229b 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 module_param_named(debug, __drm_debug, ulong, 0600);
 #else
-/* classnames must match vals of enum drm_debug_category */
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+/* classnames must match value-symbols of enum drm_debug_category */
+DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		    DRM_UT_CORE,
+		    "DRM_UT_CORE",
+		    "DRM_UT_DRIVER",
+		    "DRM_UT_KMS",
+		    "DRM_UT_PRIME",
+		    "DRM_UT_ATOMIC",
+		    "DRM_UT_VBL",
+		    "DRM_UT_STATE",
+		    "DRM_UT_LEASE",
+		    "DRM_UT_DP",
+		    "DRM_UT_DRMRES");
 
 static struct ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index de43048543e8..dccf12d05105 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,17 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a947e1d5f309..27995c0c9b31 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -72,17 +72,7 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9cc473e5d353..905fc25bf65a 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -140,6 +140,14 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+#define DRM_CLASSMAP_DEFINE(...) DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)   DYNDBG_CLASSMAP_USE(name)
+#else
+#define DRM_CLASSMAP_DEFINE(...)
+#define DRM_CLASSMAP_USE(name)
+#endif
+
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
-- 
2.44.0


