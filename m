Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5B790E21
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbjICVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjICVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:18:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F975E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:18:10 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79536bc6697so24650739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693775889; x=1694380689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shuu74iNOrUzggTrIzmIdLUSQe5OqUirbEavz/33+0U=;
        b=NL7FRqVgXo6AdNrQ0nfxD27le9WMEmqVknRZ5TVZg6nxmpopp+R6Ah6YNZTvH0fu5/
         b/u4N1b7HTQkT0zrGk0NxCbhfhoDrMnHulriZ6WfMSf3iMYFRyOGJw1doVKYp4tKq3KS
         ba2/Cao8Y27MEqHNoZfbsWif/szX02FnSwyVXfLhuiphL29kZTfRcbj7nAuZPOerGm1M
         qK531eC2ZAGFVP0JU90mF5w3SioiCImHGFXXKLHqnvjHmQe2CqAQ+C5srG3WZ58VkrS3
         hCJlpau1KU0WaaCmgU6KaOndvm48zFZO9jg4DeIKoR9lv8c6UCjAtg/ZIq3D9lvif7Pn
         k+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775889; x=1694380689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shuu74iNOrUzggTrIzmIdLUSQe5OqUirbEavz/33+0U=;
        b=UjKB6TMZvoIr6wAJnyjXnTrqW3NBkllS0s1aU8QYSWfuCNswYYKrQ4mmuuoCH4CdI1
         JMUES0xFAWDbll2CjUvIw2daQa9cK+jZOnAbk42udeejq7mHXCJDdgpMjyx98H/DNcnC
         9JmJS8QaQwkIRCBa+3QOt4i32TSgDGPtGXwyWIudA04uLnLxwOk07vyBqY0raIoAr/PY
         +w4qzL13DNOaP4fCox04HnRnnt60kspqfYg5Kc/SqOMwT9wg/IxNKQyYgVqZo6b5EgLh
         RtSQTlmQw6QBwe2ZVpIezx54YSzp69W5oZoemjtjL0Z13NkEfrlTRNmlRREcB+n7CEQa
         N3tQ==
X-Gm-Message-State: AOJu0YxrJB9yyWbFbhsNkMNRw0Dm7kwGXxi8lnSY56zINEDo/8PTtoAZ
        4Elqi0ZcXwPTStoo2zUsd4vo/UXCNpn6KA==
X-Google-Smtp-Source: AGHT+IHbZ1DNN3aHF6w6TKIvUGJpirsrPKixGaSKPeJBfnxY6cqoU+Qt3L+vuZtgOs/ifOjDQTbVSg==
X-Received: by 2002:a6b:7a03:0:b0:790:a010:4c42 with SMTP id h3-20020a6b7a03000000b00790a0104c42mr8838795iom.13.1693775889127;
        Sun, 03 Sep 2023 14:18:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a5ec80b000000b00790a8cc4fb6sm2845017iol.10.2023.09.03.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:18:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 4/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 15:18:05 -0600
Message-ID: <20230903211805.274507-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-5-jim.cromie@gmail.com>
References: <20230903184607.272198-5-jim.cromie@gmail.com>
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

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index e3f61c39df69..88bb5fa23bb1 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,7 +89,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++) {
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
@@ -176,9 +176,9 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	const struct msm_format *format;
 	int ret, i, n;
 
-	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)",
-			mode_cmd, mode_cmd->width, mode_cmd->height,
-			(char *)&mode_cmd->pixel_format);
+	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)\n",
+		      mode_cmd, mode_cmd->width, mode_cmd->height,
+		      (char *)&mode_cmd->pixel_format);
 
 	n = info->num_planes;
 	format = kms->funcs->get_format(kms, mode_cmd->pixel_format,
@@ -232,7 +232,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 
 	refcount_set(&msm_fb->dirtyfb, 1);
 
-	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
+	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;
 
-- 
2.41.0

