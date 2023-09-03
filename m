Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A0790D6E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjICSqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjICSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:46:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB8106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:46:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79277cfc73bso35342039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693766772; x=1694371572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEXJ5N1twmgreqGXVpqoU0bzKcH7UckG6V7g/a9C+IE=;
        b=do4NCFEQU3lCWuJWcPX0gxK1cZeSar2aTKCdeXtI3Vog2O9q0hTM8VqedAjGLr4Gdh
         NQpzx6WlU78CEmo01Ad1zqqz+ZK0Viz1RGxBiskAY2tfHQdft0nOFFf8ij/5Sa5KwnUh
         8Nm6xnqc937WZ2kmqX3W0zxUrB03Sq1K273P7KcZZd4KEq6l4DZkwbCr2uzvNb0Nv4G5
         RnIGY12LsVCb2YNWIOQcliEDzeJW/jznzfWnVjP0LA9x/zhBXuhRY+li8JWqdLqjIcTc
         gWM0Alz2JEGXNj/+Xs0QMMi+HRP/3EglSNE58jTQhbeg7QoG6co4WY0EZc1LbfzHFYqz
         O7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693766772; x=1694371572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEXJ5N1twmgreqGXVpqoU0bzKcH7UckG6V7g/a9C+IE=;
        b=H9cZNty3215BPJ+L+7RdY36PaQG/u7Hav77j5IVRuF9cYsgU9lWMV4ohnHKRlQ6+fy
         UeRPOZ2tYodtkgSoP5sKdW3R0qF5OSW3XVw/+l7boHRYS94Ts3XbIkIHmG93wgfr0hJR
         c8cbrj5LvzkNden7m3tHF+ZV0PLY4W08U3+uvXG5jwsCnzwbYVOPEHiVM4AC79OWxqxs
         vbForf+sTXzFlA63wtbwWZ42oMACrDwLJiWmMzDinudn+IEXKBrCUPgKED6BBH1Eu4CP
         1YCdDkLnv5C317qB64Xy7xFcrc2ikdkCgE8kpqH8L4+6g7TxX5Y1MRRPpt9XTj7W6zED
         O01g==
X-Gm-Message-State: AOJu0YxUccI9x+FtZrkR7D67ljx6pSY0164n5xT4fjjD6okNaYrM2Xx6
        DnTMLEjPmT+R6utuzLwTWR8dq250FhI=
X-Google-Smtp-Source: AGHT+IFiChi/4PzbAqpMAN3czSGm3lxzSyeCkbTKkttXeYEpPz3KZqOEBt/2qm3z8FebuiPCmvuINg==
X-Received: by 2002:a05:6602:2252:b0:791:1e87:b47e with SMTP id o18-20020a056602225200b007911e87b47emr8505184ioo.15.1693766771898;
        Sun, 03 Sep 2023 11:46:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a02cb89000000b0042b37dda71asm2519968jap.136.2023.09.03.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:46:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 0/6] drm_dbg: add trailing newlines where missing
Date:   Sun,  3 Sep 2023 12:45:57 -0600
Message-ID: <20230903184607.272198-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Most DRM.debug calls already comport with this rule/convention:
207 DRM_DEV_DEBUG, 1288 drm_dbg.  Clean up the remainders, in
maintainer sized chunks.

V1 got Fi.CI.IGT failure, on 2 Possible regressions:

 igt@api_intel_bb@render@render-y-1024:
  shard-snb: NOTRUN -> ABORT +1 similar issue

 igt@sysfs_timeslice_duration@timeout@ccs0:
  shard-dg2: PASS -> TIMEOUT

Neither have any logs bearing anything connected with drm.debug output.

V2 tries again.

  and fixes checkpatch warnings, by reusing 1st commit-msg.

  also fix a ccflags-y spelling error in drm Makefile.

  commits upon
  e2884fe84a83 (drm-misc/for-linux-next-fixes, drm-misc/drm-misc-fixes) drm/amd: \
  	       Make fence wait in suballocator uninterruptible

Jim Cromie (6):
  drm_dbg: add trailing newlines to msgs
  drm_dbg: add trailing newlines to msgs
  drm_dbg: add trailing newlines to msgs
  drm_dbg: add trailing newlines to msgs
  drm_dbg: add trailing newlines to msgs
  drm: use correct ccflags-y syntax

 drivers/gpu/drm/Makefile                       |  3 ++-
 drivers/gpu/drm/drm_connector.c                |  4 +++-
 drivers/gpu/drm/i915/display/intel_ddi.c       |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  4 ++--
 drivers/gpu/drm/kmb/kmb_crtc.c                 | 10 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c                |  6 +++---
 drivers/gpu/drm/msm/msm_fb.c                   |  6 +++---
 drivers/gpu/drm/vc4/vc4_crtc.c                 |  4 ++--
 8 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.41.0

