Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C680F7528E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjGMQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjGMQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:24 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08D1980
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3463de183b0so3825225ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266225; x=1691858225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IStriKg7+abk+7lgygahtLax/MwdpqbLaexMOCKkH2Q=;
        b=D3OrfVfT5djECOuNNhoW288vHOAOyGnXUub51WwYdFcw3nbtupeuhZ6fzQmEMWimPV
         NZM5ojw9lw/w+DWWcA6BCx2TLqtQkEOVKwVoeWuzJ7PrWEZ7Zd3qND+RdgMyLD+jTBfu
         6b9OzR0O4FosOr7kW07apfDp4Ku2oXyxUZHRFq6pEAehnPzbLzwNhWl2BA0pV9n7nXMp
         xQohhpjcdaXMpFqYkkdKTfZl45rDrjdaAEuaqayYIsDfWjui6pgRcrxpa4eFYZxmBdA2
         a9P479BNyvJf165iAqKSqxTpjN1a096i+BPtqVTPW1gIXr0PTxVJx70LhY+6nD70cKMP
         Kskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266225; x=1691858225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IStriKg7+abk+7lgygahtLax/MwdpqbLaexMOCKkH2Q=;
        b=HBj9sMAUw8sGPBXSy1s+VDxyzlTVPHYhetRIBosPc8Eb6DlpxlIcUm5LK/MQrXg9GU
         G1e0d3XX6nx3Yevw7H2LzRf04zw5FQK0m/f3oK0TDd+cghBJVp1WgKkCAzFZSuWL7m2P
         9AGJQ5jferMFpus344Gc2ABzfb6Envij8sl/J2M2Creh3ON4xNH3p6FuvNLY+o3xwS6M
         NV2A+YdjHsbynxJ7Y51Va4XZYTS84KSjcPu1976Xy1veMguLzPPD6/Jk46zvGKrUctP9
         1Yftkt0wVmU6lm7KS0vTHytTWdLl81zfVXaMJAWBk11cJM6sFQzyl+6jTbgeYR3SyjGa
         GKJQ==
X-Gm-Message-State: ABy/qLZ/PYPnXdERahNc+2+4ucJCCnwmVbrLIItqYrN8x41wBVo0AV/7
        an9f33h+ml/GCNbYvv2j0Ro=
X-Google-Smtp-Source: APBJJlEuif0tuN39jD8WuXAnO77ZaqXQx2i/IfurX0KojQt1kxariJnosyyM3VSmwNG7keKBSzJCzA==
X-Received: by 2002:a92:d3c2:0:b0:345:df7f:efc4 with SMTP id c2-20020a92d3c2000000b00345df7fefc4mr2050638ilh.27.1689266225406;
        Thu, 13 Jul 2023 09:37:05 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 19/21] drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
Date:   Thu, 13 Jul 2023 10:36:24 -0600
Message-ID: <20230713163626.31338-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DRM_CLASSMAP_USE declaration to 2nd batch of helpers and *_drv.c
files.  For drivers, add the decl just above the module's PARAMs,
since it identifies the "inherited" drm.debug param.

Note: with CONFIG_DRM_USE_DYNAMIC_DEBUG=y, a module not also declaring
DRM_CLASSMAP_USE will have its class'd prdbgs stuck in the initial
(disabled, but for DEBUG) state.

The stuck sites are evident in /proc/dynamic_debug/control as:

   class unknown, _id:N		# control's last column

rather than a proper "enumeration":

   class:DRM_UT_CORE

This set of updates was found by choosing M for all DRM-config items I
found (not allmodconfig), building & modprobing them, and grepping
"class unknown," control.  There may yet be others.

NOTE:

As HEAD~1 describes then hacks out, __UNIQUE_ID macro in compiler.h is
still stuck using __LINE__ fallback instead of actual unique
__COUNTER__.

Without HEAD~1, the placement of the DRM_CLASSMAP_USE decls was prone
to this collision, as reported by @lkp-robot in several allyes configs
(s390,arm-mumble) for both gcc & clang.

Moving decls around fixed each, and more popped up, it felt like
whack-a-mole.  Time to just test the toolchain everywhere.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 drivers/gpu/drm/gud/gud_drv.c          | 2 ++
 drivers/gpu/drm/mgag200/mgag200_drv.c  | 2 ++
 drivers/gpu/drm/qxl/qxl_drv.c          | 2 ++
 drivers/gpu/drm/radeon/radeon_drv.c    | 2 ++
 drivers/gpu/drm/udl/udl_main.c         | 2 ++
 drivers/gpu/drm/vkms/vkms_drv.c        | 2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c    | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 4ea6507a77e5..5e02df98327b 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -23,6 +23,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /**
diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 9d7bf8ee45f1..5b555045fce4 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -31,6 +31,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 976f0ab2006b..a1b2be1c27f6 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -24,6 +24,8 @@ int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index a3b83f89e061..12600f557c23 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -65,6 +65,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e4374814f0ef..4219276ade6a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -274,6 +274,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 061cb88c08a2..8f9dfe89f64a 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -19,6 +19,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6d3a2d57d992..086a9933fcdf 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,6 +39,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 8b24ecf60e3e..9cb6be422621 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -275,6 +275,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.41.0

