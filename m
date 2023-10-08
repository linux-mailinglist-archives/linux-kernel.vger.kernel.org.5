Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDB7BCCE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJHHG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:06:56 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA9B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:06:52 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57bca5b9b0aso1985606eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696748811; x=1697353611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaaQmfAOdlMr/G3DN8Nw6V4MkQHgrZFbaXHumsVfrFA=;
        b=mJOB/RyTn/cEDGC9hwDEN1qrpGfmoOfj70tY1W8ARpIcbDcRCa84OR2o2oSJbW3itd
         0G5v+ui26dkZngQyauvjp+1OjTuqj9yk6TU5q7XpnbhmfD0C0BEv7GjVVnI1jbS/z9DT
         PbTX0xwAr7H9kipnTmmpQ7nX3YHEwOdw3phFuZkJVjfkCKd6zEmccS627I9PssbO7k+L
         3oT/+WS+JRDW/RTWccXJZ3vf/xuP7VQFuQw+nWHaJ5YVC2Qmw9cv6w8gfQNdoFwOk6kP
         fM6BTOe/JcN9DMWQL3nOKKyGXt3OVByHEuWAcd0DWFkXi9LdcknH7y7oee8vupPPE9zF
         9UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696748811; x=1697353611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaaQmfAOdlMr/G3DN8Nw6V4MkQHgrZFbaXHumsVfrFA=;
        b=PqHW0XlppDE+ugX4bbQjDzT2wUVvr8X/4+Q63/mEx4m+IZtgaiTuNHtQvG1wr16siV
         DXUc0q9SmfTqomVUCh1G9kyixbMocrnrKmDHcUubdQU+a8gPHde+uvCdpUoMIeZB9f9T
         eNnJcQ7RBCI4ww+Jg+f3gize6hNfY76x/RdeAt8aYBBxOMBdSAadnNpiZxUaZFJqToQG
         NDWSggYR38aU+1jWRC39XEfdDF5owtQ5YMSzSs+DBR4HNuf2N1pLfFlc4D+oLqFOEZF/
         lYbWAXCia0yGuJ9mugjxcQce40EBp4S5RNClHeJEhd0c47IFLPZbUnARIT8IHjREZt4k
         2csg==
X-Gm-Message-State: AOJu0Yz1qHb32ogtRqBwSL6xaqdVqBt3Sq03iOzUqQdY2jswwCVnGkKJ
        oQF7NcO7Olm2w6RFo2eNuBg=
X-Google-Smtp-Source: AGHT+IHjlQJlc1v/QJINcsLjzBlw3z4Y2om9X4TNhRdSRpyR3bjky2WaVc7uXpVm3uLtbUZ8+CZ6UQ==
X-Received: by 2002:a05:6358:63a7:b0:14b:d9de:3008 with SMTP id k39-20020a05635863a700b0014bd9de3008mr14338878rwh.5.1696748811195;
        Sun, 08 Oct 2023 00:06:51 -0700 (PDT)
Received: from localhost.localdomain ([27.5.160.191])
        by smtp.gmail.com with ESMTPSA id c24-20020a637258000000b0055c178a8df1sm2290356pgn.94.2023.10.08.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 00:06:50 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix kernel-doc warning
Date:   Sun,  8 Oct 2023 12:36:18 +0530
Message-Id: <20231008070618.20640-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identified below document warning in latest linux-next.
./include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand
* @NOUVEAU_GETPARAM_EXEC_PUSH_MAX: on line 49 - I thought it was a doc line

Also, on running checkpatch.pl to nouveau_drm.h identified
few more warnings/errors and fixing them in this patch

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 include/uapi/drm/nouveau_drm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index eaf9f248619f..a523ca5aa865 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -46,7 +46,7 @@ extern "C" {
 #define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
 
 /**
- * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
+ * NOUVEAU_GETPARAM_EXEC_PUSH_MAX:
  *
  * Query the maximum amount of IBs that can be pushed through a single
  * &drm_nouveau_exec structure and hence a single &DRM_IOCTL_NOUVEAU_EXEC
@@ -458,15 +458,15 @@ struct drm_nouveau_svm_bind {
 
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

