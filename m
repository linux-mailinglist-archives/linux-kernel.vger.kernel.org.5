Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EC768893
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjG3V6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3V6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:58:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D2A1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:08 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-348ccbf27eeso19335025ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754288; x=1691359088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbjSrC6Xf1t1eELbOkTAbrw9X9H2Qkj1asQL3Gv+d0E=;
        b=e78us4E31/EL62UZ/d9+AODTGy4BAUAFfV/mOVAI1f7OuzhGI7L9s9Cffk6GEAGUzj
         flQmFys6JKiOTGkIbq4G2tiE7U2AFeDQHqkKr8m1Vvsde4OFKFam4d0VqxMmMVVmVj9i
         ldXocJQ5x5L+N9Xbdrh620sFNpoZhT3sv8uEvZv726Q7w5zbio6nNdBVufDhiRKPoLEp
         C+lwP2uLHzLPz2itzwwW8nrLbFA52rmYM5HpUGVIgLS/KvK4oJigCTyCv3Qsa5zPJwHN
         RwtmKzqOy9wAxsw/yD4F/AGTF2IPnVvXyOQfnUZXoCdyoFrsreXjLCeTIv3SiP+14HEO
         T0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754288; x=1691359088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbjSrC6Xf1t1eELbOkTAbrw9X9H2Qkj1asQL3Gv+d0E=;
        b=l2h9c0QqBi/KtOda5azByQrnYqy/RtHMIaeE83oKh2N/Z+2KP2Pv6LBSxz1dXkBT7F
         ExDWnmYu1jsOwD/NhYqN8dF0Q0v4MGYDsdvuOaGAqG24thDwUyit+1D66xmDTwOVnWHu
         g4jHyc1UX09ahBPS+/lujDINJ0DVoehdCOpQ1IuE9Ox/ReaHrPvtTCwWlvIuNxmzrAfP
         jHBSmlk1oso6W4RDnRLdQECiYd1ndXS1Iz55fkYpba/kV6JTE66Op7Lk9XrgHyAAEwIt
         JrP4CIyNMCaus7S1YOSu9nsTLWfX5yuIKD6YxT9q+n9CdJKz9U9HBZr7UgbGh//C2KZP
         2Zgg==
X-Gm-Message-State: ABy/qLbrT/vYIB55nkzUd0DCXflQ1XjxghaT4V7NVc09PMKYfCm/+KKe
        9TYsu2M7uzelASw7hP+czcs7PsA29FI=
X-Google-Smtp-Source: APBJJlFchddN9xbU7X/x2AFLj9rBNk/j1Rd+vYRHyhhp+pMib63heddhIZTf6UnPFwMoD8dQfYHUPA==
X-Received: by 2002:a92:cd86:0:b0:348:8da1:891c with SMTP id r6-20020a92cd86000000b003488da1891cmr7544893ilb.24.1690754288186;
        Sun, 30 Jul 2023 14:58:08 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e18-20020a92de52000000b003424b3d6d37sm2747520ilr.24.2023.07.30.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:58:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH 0/5] drm_dbg: add trailing newlines where missing
Date:   Sun, 30 Jul 2023 15:57:49 -0600
Message-ID: <20230730215758.54010-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Most of the (~1500) DRM.debug callsites provide a trailing newline in
their format-strings.  Fix the remainder to do the same.

no functional changes

Jim Cromie (5):
  drm_dbg: add trailing newlines to remaining callsites
  drm_dbg: add trailing newlines
  drm_dbg: add trailing newlines
  drm_dbg: add trailing newlines
  drm_dbg: add trailing newlines

 drivers/gpu/drm/drm_connector.c                |  4 +++-
 drivers/gpu/drm/i915/display/intel_ddi.c       |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  4 ++--
 drivers/gpu/drm/kmb/kmb_crtc.c                 | 10 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c                |  6 +++---
 drivers/gpu/drm/msm/msm_fb.c                   |  6 +++---
 drivers/gpu/drm/vc4/vc4_crtc.c                 |  4 ++--
 7 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.41.0

