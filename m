Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5CB7688AB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjG3V6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjG3V6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:58:30 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18381710
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:24 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-348f5193c12so11084415ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754303; x=1691359103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu0ECoPsGxDrhExN3brXHjUi2LDDzR+FiP6BVL6w+Kw=;
        b=h2LpsYBPFywLz1hFWTqus0/HFnW3Z94Zi07PcYMQkZiem7z0ylk17/7KsTQPPlC49J
         WwWEMAsnKjGxik3r9XXI45OgJR2XTvUZ+dJRbDKGMNvD2iQdJkySUFNB3SnqG1jmV4Av
         ZNfDadE3pOeeTc3WclrdH2Fjw9mazeO0r+rBnVebI5Rvp0r7HhgpL9n0Kg5vzpnWu7mv
         wtwzKAbSxAHbXfPEEFYMrnL3Ky0XmLv2ukbzDgZkUBX1MPu3CX46st9FWTMU1vn0jJRA
         h/YUn7AsWV81jr8SmGici+CfPXznEghYrzftC3PmSbagKM+5dbAHRH2EHLFZhWm8HcZh
         D2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754303; x=1691359103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu0ECoPsGxDrhExN3brXHjUi2LDDzR+FiP6BVL6w+Kw=;
        b=c+nPfNOfXy3Kxl+lZNiAatzksic7Q7rd7/0OPgNtQuDD54uzow5UQAHEO9x1z9vq3r
         6zQjxQl2CgE7cbKoyUVfSI8qCtvoOovobloBXPsKuhcfFcU+i8q/IjvyMIqlREKHkSle
         DL7AVJVCgKbutFbkAAN1QYN5w25zxNq/oJ2YI50RZZJcJhylCwew4h3uiTMKrGSplrDa
         s4LSkYf0S9cbY+sgHsNm0wfr8c1QUXUChOAXZbI6P/vAx0T5qXL9ZpCQ52tDgZAsHXNO
         56xPgtqN5ChKpJMCigIwaWsgS/85/zuLwONAPMzfRd7x+qBvnvhDZOIK0nSTMrjswDwS
         N8iw==
X-Gm-Message-State: ABy/qLbGPcElSafvXdLRXKzAxNaWtjrHiaaPfbdB1tOqNpIGI5RvOQUk
        SX8YetkOkvUZn9JeED9cL2Q=
X-Google-Smtp-Source: APBJJlGFctHBx6g16uBxY6S5P569mXmHB6D7A2XcVTPreJQ0slf/YQc2sQUGDPhGIc2DYrEGBMMm2g==
X-Received: by 2002:a05:6e02:ed3:b0:348:1a1f:5542 with SMTP id i19-20020a056e020ed300b003481a1f5542mr6325346ilk.17.1690754303337;
        Sun, 30 Jul 2023 14:58:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e18-20020a92de52000000b003424b3d6d37sm2747520ilr.24.2023.07.30.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:58:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Emma Anholt <emma@anholt.net>
Subject: [PATCH 4/5] drm_dbg: add trailing newlines
Date:   Sun, 30 Jul 2023 15:57:53 -0600
Message-ID: <20230730215758.54010-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730215758.54010-1-jim.cromie@gmail.com>
References: <20230730215758.54010-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index bef9d45ef1df..959123759711 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -592,7 +592,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
 	struct drm_device *dev = crtc->dev;
 
-	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Disabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	require_hvs_enabled(dev);
@@ -620,7 +620,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int idx;
 
-	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)",
+	drm_dbg(dev, "Enabling CRTC %s (%u) connected to Encoder %s (%u)\n",
 		crtc->name, crtc->base.id, encoder->name, encoder->base.id);
 
 	if (!drm_dev_enter(dev, &idx))
-- 
2.41.0

