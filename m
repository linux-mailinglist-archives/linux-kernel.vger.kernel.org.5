Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398467CE408
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjJRRH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJRRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:07:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03643D5A;
        Wed, 18 Oct 2023 10:06:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a6830df017so2353839f.3;
        Wed, 18 Oct 2023 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648797; x=1698253597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcqTwHq7sHXYNJa8WmhhNW6roNCK+d1UfmWS8347nH4=;
        b=QvceXNIRMhMhdAJhLOlB1nKXdPfFZbOVV75O+dTaf2jV2saRbc1IHyRFw9NtIkamwD
         Dn16ClrGEaTUK/WgcniUwESy5fnA+i3Sw79qZgomWB/1EJgi8eajFj/N1vqUBvouJy8Z
         ys+jeyJRDEn3xfHQ49HqGD55B6RGfNxieAlwcgRqXbUPKGhw37jiNj2wjFpdHjx0xLHb
         mqx8VdGZwk+6yZrmz/JvXgVpn7drtRRov+z/zn0agEAUG5MaH0+yKToMk1OSJF1XszwD
         3Kud+zj5IRGUZQwTSFwYtINs+DambG+7jYf37BVzX/cvAU8G8DLx+mKAYjQTrMYEfHsU
         CCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648797; x=1698253597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcqTwHq7sHXYNJa8WmhhNW6roNCK+d1UfmWS8347nH4=;
        b=i5NlIfK/1aHK59OQuBLfbpAtziiAs+YGw/+c9nV8id1boprn7Of5M69e+KOVH/hwn2
         KPSxnh/rUODb1kKyNgagCFLrKwTZk6MhQyNCCb0wjhqyrHNBhAuOGYVvVEe/YX+eCkDP
         MaLIEe1tatju/5IRmxU3Z/RzKLaX3sicLZwH9kgOpiN9Z+B+XdlvAFy7z7rJ3bruRTke
         wrqW3BJ4d2BU9jXEsijibH/ZdLXubg8DuHELf/Z9rI1h3NU7FUqPzBnb57Y7Em9nAVea
         Jim7zElCLMRifcV4hRC5EG8gD9FPoNfWBlkxlXe2pLErmTj6Rq1KC1Rm0ow+1TqkakSU
         6Rcg==
X-Gm-Message-State: AOJu0YxEShRtLmtWTitr6gOWekSSc0OwY4fyTXeum5pfboHtlkScNOIA
        ZBB8pdOIgGFMQefGG5zEPDNEcjEG+fZxqA==
X-Google-Smtp-Source: AGHT+IGEoGW0dhG7fjOKBkU+mUiWJ+Phy8IGnV+99em8GKf+aT51e3VHKzqKbrMN+P1EiWIEky4Vig==
X-Received: by 2002:a05:6602:14d0:b0:790:c259:4ee5 with SMTP id b16-20020a05660214d000b00790c2594ee5mr7271761iow.8.1697648796972;
        Wed, 18 Oct 2023 10:06:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 23/24] drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
Date:   Wed, 18 Oct 2023 11:06:03 -0600
Message-ID: <20231018170604.569042-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

   class:_UNKNOWN_ _id:N		# control's last column

rather than a proper "enumeration":

   class:DRM_UT_CORE

This set of updates was found by choosing M for all DRM-config items I
found (not allmodconfig), building & modprobing them, and grepping
"class unknown," control.  There may yet be others.

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
index e435f986cd13..066d906e3199 100644
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
index abddf37f0ea1..d678eb8e028d 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -24,6 +24,8 @@ static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index b30ede1cf62d..91942ffcc2b4 100644
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
index fa531493b111..ab29945af657 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -247,6 +247,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 3ebe2ce55dfd..ba57c14454e5 100644
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
index dd0af086e7fa..086797c4b82b 100644
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

