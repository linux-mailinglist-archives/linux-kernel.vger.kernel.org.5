Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A478925B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHYXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHYXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:31:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31769210D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:31:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a1af910e0so1158142b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693006280; x=1693611080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0DooFBD1A8V10MBqW1RginVqDYC6KQwP0qswiVYI6g=;
        b=WVNH5UzkHhUt8AlEXn0wpzIIigCdumsWXPrsEG9O1FoqdJ0I0WBT59w8oTPTTaw0Zx
         7C18046fBSkNWPvkDUSv2a4OoqV1nf/nL1PbLMzzJ3udjSxmHb5KdEpiiNWeMiqSVY4Z
         j+Mk6aYQcNWFp01T5LvipK/5CECUEUYyWumpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006280; x=1693611080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0DooFBD1A8V10MBqW1RginVqDYC6KQwP0qswiVYI6g=;
        b=lj4qZ4g6RZ5mmAfy5rPUzj4XbYbiapb/f22jpIVaT3IjvAkanJrl5vdzHPMFE9Ex4O
         1XHh2fKxDw3g5NCAHmroll3x6pxQa1PhIjHaqJrZKXaslckAS7+tIz7PpBl+fZmAq9eZ
         po7XK4N5hVWNOpWv/9Y6BZgyKFdyucMx5AEt5ou9U8G7DEurMCUWvCZVQny49kvWYklk
         Lh5X2VBy3b9oO6K+2i03iNQPyQLcDwjiiLSzYdxEvrtwXOhZhPctWoY/rnZVbU6gONKP
         kBLRthLf9499Zq9h/wIu8rb5f5C432iHBJ5dL92Wfpu7y+706jaRcfUhDWnzEUyrfE0V
         VPSA==
X-Gm-Message-State: AOJu0Yy+H8ER05PKvk8+mwtP8g8SEs8nuSNOtyz0bYzOgAcbUy5rBin+
        f0Jn+MWDvYPTqfzOwFVAk1ZNQg==
X-Google-Smtp-Source: AGHT+IFc6FIYdzvhev/WzyfpurbheqorRd31Zx1H4S9htxQ8xUE9T/owg0Q9qpe5SIifQWpPxwDP1g==
X-Received: by 2002:a05:6a00:10c3:b0:68c:1a0:46ac with SMTP id d3-20020a056a0010c300b0068c01a046acmr5243310pfu.15.1693006280672;
        Fri, 25 Aug 2023 16:31:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d711:d7a0:fa61:8f24])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7838b000000b0066a2e8431a0sm2092016pfm.183.2023.08.25.16.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 16:31:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org, Simon Ser <contact@emersion.fr>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] drm/connector: Add newline to debug printk
Date:   Fri, 25 Aug 2023 16:31:17 -0700
Message-ID: <20230825233118.2689222-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This debug printk is missing a newline, causing drm debug logs to be
hard to read. Add a newline so that the message is on its own line.

Cc: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Fixes: 8f86c82aba8b ("drm/connector: demote connector force-probes for non-master clients")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3ed4cfcb350c..ab1467a15f9a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2923,7 +2923,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 

base-commit: 706a741595047797872e669b3101429ab8d378ef
-- 
https://chromeos.dev

