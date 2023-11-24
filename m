Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0667F6A35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjKXBjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:39:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D36D69
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:39:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548a2c20f50so1906475a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700789945; x=1701394745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MCjIjD8tavb0cbgjvIEQTL7WpfbPqahU1xHEzB2I5uM=;
        b=F0IsYUDEKq4ZAkR8od3oIMqnQdqSYe7mCjWfH/SpI/2eHwnK8TgXJlSywgZYI0bWI3
         Y6JXdYOjZqY9eXveqhOqw4kboaPkXqhgWAr6I5yaSH9eMMk+b12us0ffwd5nUQgqIqot
         ik4gz40N7U/V1KKtX06oDcUIDy0u26UTfVSOqNL/MbOCwR+U2RKsf4SPpelrW/8j6GVr
         NwZ7vga0EUxOuqQtIa00eqP+MrRyy9Cul/ITGdWaym/6vBrmOHD8NokZHl6VwuTqjFlL
         WXPuffy3y+ecZ953CpH6/d+NvB3P7AGmlb+Kf+V78bmLbWcYiG/FiKtwYq5lVlG3Sa10
         uCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700789945; x=1701394745;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCjIjD8tavb0cbgjvIEQTL7WpfbPqahU1xHEzB2I5uM=;
        b=h0CB5+JtVyiBgX+0IE1FfivjGJh7s2Uvxqvx4k/JZ3fPq9Mm82jdTfzYlLZD0SVR1b
         +uhV/tUD4p/68bgJHno9rQG11Ni8787UdAviz6lfJ5xtgWmO1Lf4RcY2Jw+zZHb+6FZZ
         Fclfbd9SQqtUAOmJugC0e62pUojvLUvY1s7lgNDVergcWA6SjrJ3FpxV7dvOUzWXpK2t
         0ijmZaMpfxLofBPjTXo2uARaAc+sKPBbCqAlPSvKOMsXbxX6Ef1S4GCUK/kIRB8aJGrA
         DdLyskK94rG7waliuN3uX5VKY38XNnOakA4Rpb3YIjVBftEi9eBTvW4Vkn+0snVN+TzO
         swyQ==
X-Gm-Message-State: AOJu0YzOa7pD8Onl4BN5w6fCLu4K4RnJ+QyoVBhMpA9ZpubTpWHAB+AE
        sXjZc+rDQxague4xB0R1Ra9fXaQaqLRabNogiIE=
X-Google-Smtp-Source: AGHT+IFMWsDCoDTnUOis1NEZFxzHDDlNlqWsjIu1KiRS8KmbJxKLEmmKnV3HPDf4zStiqHzmYEqYOYCsUEvKAdWFLas=
X-Received: by 2002:a17:906:b21a:b0:9ff:5b5c:12a6 with SMTP id
 p26-20020a170906b21a00b009ff5b5c12a6mr753905ejz.40.1700789944473; Thu, 23 Nov
 2023 17:39:04 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Nov 2023 11:38:52 +1000
Message-ID: <CAPM=9txezDxgPxV4UJ-RPVxuAqO4k2kdDj-oUAyFdP+CztJPzg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Back to regular scheduled fixes pull request, mainly a bunch of msm,
some i915 and otherwise a few scattered, one memory crasher in the
nouveau GSP paths is helping stabilise that work.

Regards,
Dave.

drm-fixes-2023-11-24:
drm fixes for 6.7-rc3

msm:
- Fix the VREG_CTRL_1 for 4nm CPHY to match downstream
- Remove duplicate call to drm_kms_helper_poll_init() in msm_drm_init()
- Fix the safe_lut_tbl[] for sc8280xp to match downstream
- Don't attach the drm_dp_set_subconnector_property() for eDP
- Fix to attach drm_dp_set_subconnector_property() for DP. Otherwise
  there is a bootup crash on multiple targets
- Remove unnecessary NULL check left behind during cleanup

i915:
- Fix race between DP MST connectore registration and setup
- Fix GT memory leak on probe error path

panel:
- Fixes for innolux and auo,b101uan08.3 panel.
- Fix Himax83102-j02 timings.

ivpu:
- Fix ivpu MMIO reset.

ast:
- AST fix on connetor disconnection.

nouveau:
- gsp memory corruption fix.

rockchip:
- color fix.
The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-11-24

for you to fetch changes up to b3ca8a08d8ed0dc8a9e236d9294efd58554a7b05:

  Merge tag 'drm-intel-fixes-2023-11-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-11-24
11:18:29 +1000)

----------------------------------------------------------------
drm fixes for 6.7-rc3

msm:
- Fix the VREG_CTRL_1 for 4nm CPHY to match downstream
- Remove duplicate call to drm_kms_helper_poll_init() in msm_drm_init()
- Fix the safe_lut_tbl[] for sc8280xp to match downstream
- Don't attach the drm_dp_set_subconnector_property() for eDP
- Fix to attach drm_dp_set_subconnector_property() for DP. Otherwise
  there is a bootup crash on multiple targets
- Remove unnecessary NULL check left behind during cleanup

i915:
- Fix race between DP MST connectore registration and setup
- Fix GT memory leak on probe error path

panel:
- Fixes for innolux and auo,b101uan08.3 panel.
- Fix Himax83102-j02 timings.

ivpu:
- Fix ivpu MMIO reset.

ast:
- AST fix on connetor disconnection.

nouveau:
- gsp memory corruption fix.

rockchip:
- color fix.

----------------------------------------------------------------
Abel Vesa (1):
      drm/msm/dp: don't touch DP subconnector property in eDP case

Andrzej Hajda (1):
      drm/i915: do not clean GT table on error path

Bjorn Andersson (1):
      drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP

Dan Carpenter (1):
      drm/msm: remove unnecessary NULL check

Dave Airlie (4):
      nouveau/gsp: allocate enough space for all channel ids.
      Merge tag 'drm-msm-fixes-2023-11-21' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2023-11-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-11-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dmitry Baryshkov (2):
      drm/msm: remove exra drm_kms_helper_poll_init() call
      drm/msm/dp: attach the DP subconnector property

Imre Deak (1):
      drm/i915/dp_mst: Fix race between connector registration and setup

Jacek Lawrynowicz (1):
      accel/ivpu/37xx: Fix hangs related to MMIO reset

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jonathan Marek (1):
      drm/msm/dsi: use the correct VREG_CTRL_1 value for 4nm cphy

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Thomas Zimmermann (1):
      drm/ast: Disconnect BMC if physical connector is connected

Xuxin Xiong (1):
      drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

 drivers/accel/ivpu/ivpu_hw_37xx.c                  | 46 ++++++++--------
 drivers/gpu/drm/ast/ast_drv.h                      | 13 ++++-
 drivers/gpu/drm/ast/ast_mode.c                     | 62 +++++++++++++++++++---
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 16 +++---
 drivers/gpu/drm/i915/gt/intel_gt.c                 | 11 ----
 drivers/gpu/drm/i915/i915_driver.c                 |  4 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |  3 +-
 drivers/gpu/drm/msm/dp/dp_display.c                | 15 ++++--
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  3 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  2 -
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c    |  2 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |  9 ++--
 drivers/gpu/drm/panel/panel-simple.c               | 13 ++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 14 +++--
 16 files changed, 138 insertions(+), 78 deletions(-)
