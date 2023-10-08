Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95FB7BCF68
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjJHR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbjJHR2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:28:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B97B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:27:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-694f3444f94so3115921b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696786078; x=1697390878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzfXCsQu/Q0hXc6cMTaBxtMOorrmDS4rTq/PmtsDLkg=;
        b=f/47t6v3GRBAPIVXt3rVlV3d+JiasRX+i8he5OIVJBC03CM8/MMTCSqu9kwLTV3O71
         etqoSiUAejz3yBB2csMMbUfWyHOqIY7m11FhFHRXEGy2IBriRtWUtF/4d7XQZs6bQrdW
         WM2JfSlyEw3qgGeE9aLFd0ztTgaGGtvC6qZwNCuWEH3VnKNelemdhC4xQy1KGB6OoJoU
         kAycKv/t6HLPkU2kJovU7iX0Siyfphsj9Sf5QgV605CBCz/FnlNMTwK0uYTO0r5SoJVc
         qUSF3Sqf4Chj4kHxIpcPrPREH/gCHvvuZl5eL3vckEDqWJn14uPQeniaJK4VDe77DRjX
         IkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696786078; x=1697390878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzfXCsQu/Q0hXc6cMTaBxtMOorrmDS4rTq/PmtsDLkg=;
        b=bsmyvk7D4FcSeJioaLIV1vT/IIjEw+DLFE1NqXc+muexX1n1uj8i/fkX9B/tiLeLVs
         wRGqmBBLJgyYcf9ExIuvNMIkNjwZZcCmmyMQG6aYcPqfOAFHbacNm7IiD80YlkzxQ1Wa
         TYVBt1Q0i09CvlhDIhY4Hnng0RpateKQX/+CprW0QTfAdhFOZMqfs2ayyI5iczdbnSE8
         m5SyMujaML6dh95kzKjHr1douTVHhWY8F3vmFc6y2d896PV/H9YYPrIQmv9V2gzbd8n1
         5N1bmC5dJhPCX6XJN5H0Xaz+rt90ZndUNECYUGoImaqTe6zzABiGFdj6oggM2mw2/Oz5
         AgsQ==
X-Gm-Message-State: AOJu0Yz2syP3ydiSGxgSMVNjnLYSm5EdkrGURy47iNnarQ8r0i2ShwZX
        mF7fVaZMkTVesrWvszgrbc8=
X-Google-Smtp-Source: AGHT+IGVV1a8Zl3qzOuqXTOr9NjpPrkVpV2NcWSVfv6hw4u0w8K/y495AYJteCxRj6PggadLQjlKQA==
X-Received: by 2002:a05:6a00:2d8c:b0:68f:c078:b0b6 with SMTP id fb12-20020a056a002d8c00b0068fc078b0b6mr16178897pfb.10.1696786078493;
        Sun, 08 Oct 2023 10:27:58 -0700 (PDT)
Received: from localhost.localdomain ([27.5.160.191])
        by smtp.gmail.com with ESMTPSA id m9-20020aa79009000000b00690d4c16296sm4789435pfo.154.2023.10.08.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:27:58 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fixing indentation and adding License Identifier tag
Date:   Sun,  8 Oct 2023 22:57:51 +0530
Message-Id: <20231008172751.21953-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On running checkpatch.pl to nouveau_drm.h identified
few warnings. Fixing them in this patch

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+/*

WARNING: space prohibited between function name and open parenthesis '('
+#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE +
DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 include/uapi/drm/nouveau_drm.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 8d7402c13e56..900ca4f1ebe5 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2005 Stephane Marchesin.
  * All Rights Reserved.
@@ -448,15 +449,15 @@ struct drm_nouveau_svm_bind {
 
 #define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
 #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
-#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
+#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
 
 #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
 #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
 
 #define DRM_IOCTL_NOUVEAU_GEM_NEW            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_NEW, struct drm_nouveau_gem_new)
 #define DRM_IOCTL_NOUVEAU_GEM_PUSHBUF        DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_PUSHBUF, struct drm_nouveau_gem_pushbuf)
-#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
-#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
+#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
+#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
 #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
 
 #define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)
-- 
2.34.1

