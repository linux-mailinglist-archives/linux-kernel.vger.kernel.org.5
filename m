Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAC794377
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbjIFTC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbjIFTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EDCC7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:02:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7927f241772so5134239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026950; x=1694631750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaQGDXjeyl1wK3pu1t3QMemL2yV1V0c+fGGW9EXmwB8=;
        b=F5w435s1AkreuIXzQNj0D+S4rmf4mgFByG9e7Ynget0vFiCfr5kfEq/ytMa+fWs6Tn
         lQJYdsttoZ/ltR7zixoL7hj4IitE1lN6UKa4hQAPASY3n5jhmXWVUORResjr0k/Ag0go
         dEXbYDPyTm2R7DbOstd7xGQLQn0PbqAuAG164hKUz3z3fnhyCAgv67kjqRZuchPjHc6Z
         /gE5RGlRef5RtzBlEkdGcB9D4sq+3DI7UJGQNZg1hp5Jp75ynPy6boTI4bzKqF2SFI+g
         9AL6RVcdfF81lTooT1qlrxgf1AjdpEAp6F3nN5fqTToqygdkX1uD6ERuORTu9Yc2vHLn
         gQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026950; x=1694631750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaQGDXjeyl1wK3pu1t3QMemL2yV1V0c+fGGW9EXmwB8=;
        b=WHTLu3KGR/pp0g8zzxaW0h9Vov4zaHVEMU490ASjou81c0h44y3ojwSutFpSQNDNMI
         PafaIL/R+lzZ2pC7umtqUpoXF322Eizmw6grbmycB59Wv0snIiZji8bkGUrC6dKxTiq8
         96SoTCDj4eE3zhtinz6713DG1GsPWmvvguYeHnjHUeJ18Bv8gZbZK5BKwcd1uP3qqriz
         3k68waQmwJwr3jx2mou8GyLC8F/fI4EdlUBGZJ9TmHJxkXE27VjCuXmIJf3mDyGibOnC
         TbIPsL0HrcuVkG8f8vuYI3irm8MU77nRiJA8HcEJ+leUMgXY3mgS7bXhnZLRVpUF3csA
         6esA==
X-Gm-Message-State: AOJu0YzhL2bYxIMgi+wZJN/GGgKD60/y9B0PqPQ7s/QMNKdqkZ1jN6/E
        x0tzwi/GT/NbGz7wrT9qYT/te/fhlHMI2Q==
X-Google-Smtp-Source: AGHT+IGWUYcmi6S5h+fh/k9YyYz3mKPy+hp3qyzTn50rIoOvT2ULFXG+3gdAvN5pM0oGcV6yYoVbXQ==
X-Received: by 2002:a5d:9952:0:b0:792:4994:d1bf with SMTP id v18-20020a5d9952000000b007924994d1bfmr18995189ios.9.1694026949849;
        Wed, 06 Sep 2023 12:02:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 0/5] drm/drm_dbg: add trailing newlines where missing
Date:   Wed,  6 Sep 2023 13:02:18 -0600
Message-ID: <20230906190224.583577-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this rule/convention:
207 DRM_DEV_DEBUG, 1288 drm_dbg.  Clean up the remainders, in
maintainer sized chunks.

V3: adds proper "drm/<component>:" to subject, as suggested by Rodrigo.
    drops drm/i915: already applied by Rodrigo.

Jim Cromie (5):
  drm/connector: add trailing newlines to drm_dbg msgs
  drm/kmb: add trailing newlines to drm_dbg msgs
  drm/msm: add trailing newlines to drm_dbg msgs
  drm/vc4: add trailing newlines to drm_dbg msgs
  drm/Makefile: use correct ccflags-y syntax

 drivers/gpu/drm/Makefile        |  3 ++-
 drivers/gpu/drm/drm_connector.c |  4 +++-
 drivers/gpu/drm/kmb/kmb_crtc.c  | 10 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c |  6 +++---
 drivers/gpu/drm/msm/msm_fb.c    | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_crtc.c  |  4 ++--
 6 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.41.0

