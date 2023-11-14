Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362E47EB0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKNN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:28:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF401A1;
        Tue, 14 Nov 2023 05:28:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28037d046b0so4612947a91.3;
        Tue, 14 Nov 2023 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699968480; x=1700573280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJTc18Dq8cauhdDP2mnhlAYqSmKqYG3BV6eLgfA16hg=;
        b=fWsKGeLFQLm/woc+cXYsoJLi5ffK/Q6s2V7eOvzaP8k8xouglYgBBtu2CZPpaS4XP6
         G83yxL93fxdR7i0Gvbacd51RC8vr54H9TEDk+HaoQTB64e7eOIahyAhUgGq894KNID/1
         77HeVyUCESAnwrNxGNibQWcPBYsBb/r1Sc+8bIINZEvxUMzzrDck4c1qvCsYRc2aBfi0
         j3FrSqf8Q0JqxPP/Grr8VpxuW4KTX1SmHhBimra4N/vPt19t5BkZEfn8G14ANvT1xqCB
         DIXrDDxmRv5ot8eqfzg2oEumSREGYDI++GrIFWvrmdUBaBA373QdoQcPizTFN3EAtaE8
         Zifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968480; x=1700573280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJTc18Dq8cauhdDP2mnhlAYqSmKqYG3BV6eLgfA16hg=;
        b=wucSu1/lqTciPTap5ei8EeuVGbOQcbmsdSfewCsBifOF63tqw9F5hdlmQLPXqJimQG
         raXgA/eXnFsO6EMl3mvxEEyDv0uGixvV8EKTU1rSEEmUiEvVy4+l0AAJgHQU6V6TKp4M
         qKMxuniyXA5LwS8+JxZjRXSsYl3vm9WI9A/k6hZWzIp/1UMTMpFq9mTxyCa4Mo3AgANH
         9rMBblcvg9rpNyxPIHnhExEEj+1HbpKIK4FqmSyYm0IpXiX2UJg68QjDYfccidZFbt8Y
         DY/MXO0+V7380ikekaUx0hEj3kIyQa0NriacSGF5EhuYl5+8sr3Ugq6umA9qFlsu6GHw
         TAZQ==
X-Gm-Message-State: AOJu0YySZRFckDSOTZggolTHGsOxCj0cXDaiPAKRl3UCMxGgb84ZErOQ
        rr4dDd3tKj9CxXv4mJJPv2k=
X-Google-Smtp-Source: AGHT+IEFXKIj+sDkAvDnBoLBTuw0fzrerZqXQZe0oLFbbujfd/4KdXIpoOLoh0oHAIbyA28Mh549uw==
X-Received: by 2002:a17:90b:1c82:b0:27c:f80a:2c8a with SMTP id oo2-20020a17090b1c8200b0027cf80a2c8amr6619797pjb.0.1699968480499;
        Tue, 14 Nov 2023 05:28:00 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.gateway.iitmandi.ac.in ([14.139.34.151])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a001600b0027ceac90684sm5896451pja.18.2023.11.14.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:28:00 -0800 (PST)
From:   Dipam Turkar <dipamt1729@gmail.com>
To:     robdclark@gmail.com
Cc:     quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH] Remove custom dumb_map_offset implementation in msm driver
Date:   Tue, 14 Nov 2023 18:57:13 +0530
Message-Id: <20231114132713.403443-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make msm use drm_gem_create_map_offset() instead of its custom
implementation for associating GEM object with a fake offset. Since,
we already have this generic implementation, we don't need the custom
implementation and it is better to standardize the code for GEM based drivers.

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c |  2 +-
 drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
 drivers/gpu/drm/msm/msm_gem.h |  2 --
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index a428951ee539..86a15992c717 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1085,7 +1085,7 @@ static const struct drm_driver msm_driver = {
 	.open               = msm_open,
 	.postclose          = msm_postclose,
 	.dumb_create        = msm_gem_dumb_create,
-	.dumb_map_offset    = msm_gem_dumb_map_offset,
+	.dumb_map_offset    = drm_gem_dumb_map_offset,
 	.gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = msm_debugfs_init,
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index db1e748daa75..489694ef79cb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -671,27 +671,6 @@ int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			MSM_BO_SCANOUT | MSM_BO_WC, &args->handle, "dumb");
 }
 
-int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
-		uint32_t handle, uint64_t *offset)
-{
-	struct drm_gem_object *obj;
-	int ret = 0;
-
-	/* GEM does all our handle to object mapping */
-	obj = drm_gem_object_lookup(file, handle);
-	if (obj == NULL) {
-		ret = -ENOENT;
-		goto fail;
-	}
-
-	*offset = msm_gem_mmap_offset(obj);
-
-	drm_gem_object_put(obj);
-
-fail:
-	return ret;
-}
-
 static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 8ddef5443140..dc74a0ef865d 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -139,8 +139,6 @@ struct page **msm_gem_pin_pages(struct drm_gem_object *obj);
 void msm_gem_unpin_pages(struct drm_gem_object *obj);
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
-int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
-		uint32_t handle, uint64_t *offset);
 void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj);
 void *msm_gem_get_vaddr(struct drm_gem_object *obj);
 void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
-- 
2.34.1

