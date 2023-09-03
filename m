Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7195A790D87
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjICSqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345575AbjICSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC3A10D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77acb04309dso37719639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766780; x=1694371580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7euIhAUxsBgqAycWxnasjxETI8zYNC1RLZ3qD73WsM=;
        b=bIKzDZgjhLXoO2N8wuweL7NZXWqXE9GQb6QidYwcy3PpQ+cKEgSpLVRkMg8CSOvMu+
         8wnl0XsnEyWBs9jSO34FzJ6WawbG31/eaWOFmi87FmzMomMcxR/EP8TaMgVmVgp/1jUV
         3dcyR8uexC97/syfYMI2Dz4tt9CWGZzowjMwv2/R2m+xfWRexIdJOInMONRTnosoRu1F
         kJEGmDQDPKPTcOHcdtr8gY1hpgs3b1UpbKGGZBT/+8nq4zeqVVXTz6hzjXmZf17zgIQH
         k+5GWWwpmK+7pq7WymiSxaKuklloM9aM31Xj1Y39cTlq0IVS27tDQzn+oaaoS+CSmO2S
         RbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766780; x=1694371580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7euIhAUxsBgqAycWxnasjxETI8zYNC1RLZ3qD73WsM=;
        b=WZFZ6k1eClwEu1GGnI4QUT3HkClYLgCywcREXLKBXHmRGCUS7noELwRZYAhf0yX+Tk
         17yGnurpAoft63UZtCypyXrnD8CUTss07t/evvqnAAYxpsZ9BAXCXctHWV2VTCidSM3D
         ATFnHdhFJbamInVPgLL64aH99kfhDulZZCFc7hCf9d6RoSigWC7q08+l7lsLHJj4G0CM
         3Q4zQsnjcQe7Ttd1F83q0IYuNQktoRky/UH+etyz4faoIpnVHOciGWZQMU7ceR+bLTFu
         I6XotSBuu8i3jk+ZYMaPYwl8H7fZutYiWGQM6SgoauSVYhs/btFi2pCYjHTkeitPW88B
         Zt7Q==
X-Gm-Message-State: AOJu0YxtfrAp+Jy9p8jgKUUHs0PdFusT6HuWLBmgQUSTOma/JWTZgmRu
        VhW9qsOF74K9o5vDo5LDjBQEN2Znsg2/EQ==
X-Google-Smtp-Source: AGHT+IFezAhzBe8bHNafQV2ls3Rrm07SEuvb9e6ZJAhZmonaPCE5ktQ5RYLT+3Q1JAWulfB2inkf2w==
X-Received: by 2002:a6b:5103:0:b0:792:9333:2cbf with SMTP id f3-20020a6b5103000000b0079293332cbfmr9837914iob.6.1693766780607;
        Sun, 03 Sep 2023 11:46:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH v2 5/6] drm_dbg: add trailing newlines to msgs
Date:   Sun,  3 Sep 2023 12:46:02 -0600
Message-ID: <20230903184607.272198-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903184607.272198-1-jim.cromie@gmail.com>
References: <20230903184607.272198-1-jim.cromie@gmail.com>
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

