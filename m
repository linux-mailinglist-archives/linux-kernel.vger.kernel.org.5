Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6377FC59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353748AbjHQQtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353759AbjHQQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:49:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA3273F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:49:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6887b3613e4so2113297b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692290944; x=1692895744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gP/+HX8tff5J7C1dVpOFmStGY34cS59+ah5Jqhr0qQ4=;
        b=HanMEXUDwyG1Ey2rPH3QP5JdIubd+ihoyATb0QBayRB/ONa5VMdVHpRhU9WoTypSy7
         Ta3y8sF8WJrowBXiNZH6rT1fQgcZuF/h0VpHyQ3uYzlCJlvakO84AZ2z1c7iN7albAcP
         2IAVJpLqJyUY6/V3KsXzvdsYzFfZGp0FzRD3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290944; x=1692895744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gP/+HX8tff5J7C1dVpOFmStGY34cS59+ah5Jqhr0qQ4=;
        b=lsZnUReiT6NwIXvaDNXR/kRp6KaMw59l3EnxAc8yJsNFiI/dQoLvM6sY/6FdOBFsl6
         yfjpEnqF3XrcFYELgb5mRonWidYdFPCMbpgo8KckF51EqbpJT9zsLU+JI7/DamJAqEsa
         Vdd7Ea7rPHb39o3F39iEqc8nIbRKeyFcb09c4vYQdif0L9A018syW/MpAszlLZJH2vrA
         pmbtfo6vswP1oX126LGChWhz4EI57VcPVnVLB9GHp+t0a5uCRTC64EoxwOYjdZDzeruE
         x4Bel5FS2E/l7jcspABUEfIcla2WRWop9RAsvJ7lvmROewqo/bl/vVsmwFc/WVaI2cAi
         G0og==
X-Gm-Message-State: AOJu0YxiPeWvt2MknzOUwDFmWxrcsUVn98r62t+ofwBS8A3+xlgz1Nqe
        v20v3X9aljg7XEz2fH5nwJ0Yig==
X-Google-Smtp-Source: AGHT+IG5HtCnsJr+Qd3MkrklMr6FAcaFlWe6RUsfkPHTrmoEIk0vkUIXUn7KSIq/2M4+8rT3kKHLGQ==
X-Received: by 2002:aa7:8890:0:b0:67a:8fc7:1b61 with SMTP id z16-20020aa78890000000b0067a8fc71b61mr86709pfe.11.1692290943715;
        Thu, 17 Aug 2023 09:49:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2d64:9188:a5b0:3e0a])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7825a000000b00686dd062207sm13096073pfn.150.2023.08.17.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:49:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: Fix kernel-doc typo in desc of output_bus_cfg in drm_bridge_state
Date:   Thu, 17 Aug 2023 09:48:09 -0700
Message-ID: <20230817094808.1.I41b04c3a8305c9f1c17af886c327941c5136ca3b@changeid>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
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

There's an obvious copy-paste error in the description of
output_bus_cfg. Fix it.

Fixes: f32df58acc68 ("drm/bridge: Add the necessary bits to support bus format negotiation")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/drm/drm_atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 9a022caacf93..cf8e1220a4ac 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1126,7 +1126,7 @@ struct drm_bridge_state {
 	struct drm_bus_cfg input_bus_cfg;
 
 	/**
-	 * @output_bus_cfg: input bus configuration
+	 * @output_bus_cfg: output bus configuration
 	 */
 	struct drm_bus_cfg output_bus_cfg;
 };
-- 
2.41.0.694.ge786442a9b-goog

