Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9E7C7CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjJMEZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJMEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:25:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6893B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:25:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so250464466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697171100; x=1697775900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqcRUVg4aLS1BE3DEBpap7GO2NgwvdLuBVQCmm+LCMs=;
        b=Z+fSDvDIUh6YetAyT7sPDI6I3oJ392K+VT4h5B5YY/3RpZqv/VzDdC30X1LFSvgEd3
         x9/zZRmzbegZfSRalz+52qFKbnUyWBXOJyHcisVb55DXitnRzefirgUbqtmYrCNqejtU
         +YVXoResb4DrGXuINP2ovlP0HlofVVyZnKO21BDZoIyUK/Vee28yKpCIqoIhlt2aDoUC
         /IOR/kwCZTK/WgDKV1/vKFKiDhUaU0Se9s/dz506QF506x0p5LuwdMpisd7pYi07Z/do
         Ryn4iD5SDwunoQrBAXfZwHpU2VUqoZRk/4oC0thGecFrP5i8+STHWh5r9Og2bspS7lpZ
         vRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697171100; x=1697775900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqcRUVg4aLS1BE3DEBpap7GO2NgwvdLuBVQCmm+LCMs=;
        b=mR2Mv9/oTMMY6epvAi5clpx3o+bc/Fl+jUUvbabgIRQRGwV326eWVmrrVDJEzWhs1X
         e5QXmPI19ZVujVYby9qqbG2iuNRW5Mc/cTwulEgQC3vJQgPOCl0LFDk3VI1LJg0B6WZI
         wZvngKDYqDn+S3a0XpU0RJPraodD6w4qXmnwa1GLjG1ltrFmsxuyz2L/i0Sywj4Rf1LR
         miEsiz6bIt5jkR2AzsOwTtl6VMnVVHMYb0a0gocpDFWRsqDLjD6WhI4EseqbnPAfb6yC
         Z+5EpvYMK25+Y8DAhvMWv7FwWDgMFB3uVuatgSlXxrYF5JbGbCi8aOU06cub9He8RRPR
         W3/g==
X-Gm-Message-State: AOJu0YzGclHGvsd/UXkEq3fWpLajXzLusT+QirRC7er7EwX+eNNws7T+
        ucs5tZritXb+0PjkG06rmaiE2YyNTyQnzgoOURMlGePBK+A=
X-Google-Smtp-Source: AGHT+IG/Mj9Iclte7etD9FRnPBPE/DVRQNmsqDiMsUEtERQgrAoIixllnlNyPUtBLIoHuq2E7aMl54u47Gy9ptks0kM=
X-Received: by 2002:a17:906:220b:b0:9ae:704b:6f3e with SMTP id
 s11-20020a170906220b00b009ae704b6f3emr17522220ejs.41.1697171099870; Thu, 12
 Oct 2023 21:24:59 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 Oct 2023 14:24:48 +1000
Message-ID: <CAPM=9tyejWiiT5gzqGxCTkp5P6Xk1c9=Gbart2LS1K_YgCis+w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Weekly fixes, the core is msm and amdgpu with some scattered fixes
across vmwgfx, panel and the core stuff.

Regards,
Dave.

drm-fixes-2023-10-13:
drm fixes for 6.6-rc6

atomic-helper:
- Relax checks for unregistered connectors

dma-buf:
- Work around race condition when retrieving fence timestamp

gem:
- Avoid OOB access in BO memory range

panel:
- boe-tv101wun-ml6: Fix flickering

simpledrm:
- Fix error output

vwmgfx:
- Fix size calculation in texture-state code
- Ref GEM BOs in surfaces

msm:
- PHY/link training reset fix
- msm8998 - correct highest bank bit
- skip video mode if timing engine disabled
- check irq_of_parse_and_map return code
- add new lines to some prints
- fail atomic check for max mdp clk test

amdgpu:
- Seemless boot fix
- Fix TTM BO resource check
- SI fix for doorbell handling
The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3=
:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-13

for you to fetch changes up to 30873697b83743eda54d66ea9a3ea83554f8a535:

  Merge tag 'amd-drm-fixes-6.6-2023-10-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-10-13
13:20:24 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc6

atomic-helper:
- Relax checks for unregistered connectors

dma-buf:
- Work around race condition when retrieving fence timestamp

gem:
- Avoid OOB access in BO memory range

panel:
- boe-tv101wun-ml6: Fix flickering

simpledrm:
- Fix error output

vwmgfx:
- Fix size calculation in texture-state code
- Ref GEM BOs in surfaces

msm:
- PHY/link training reset fix
- msm8998 - correct highest bank bit
- skip video mode if timing engine disabled
- check irq_of_parse_and_map return code
- add new lines to some prints
- fail atomic check for max mdp clk test

amdgpu:
- Seemless boot fix
- Fix TTM BO resource check
- SI fix for doorbell handling

----------------------------------------------------------------
Abhinav Kumar (3):
      drm/msm/dsi: skip the wait for video mode done if not applicable
      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
      drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits

Christian K=C3=B6nig (2):
      dma-buf: add dma_fence_timestamp helper
      drm/amdgpu: add missing NULL check

Dan Carpenter (1):
      drm/msm/dsi: fix irq_of_parse_and_map() error checking

Daniel Miess (1):
      drm/amd/display: Don't set dpms_off for seamless boot

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2023-10-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-msm-fixes-2023-10-07' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-6.6-2023-10-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dmitry Baryshkov (1):
      drm/msm/mdss: fix highest-bank-bit for msm8998

Icenowy Zheng (1):
      drm/amdgpu: fix SI failure due to doorbells allocation

Joey Gouly (1):
      drm/tiny: correctly print `struct resource *` on error

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Kuogee Hsieh (1):
      drm/msm/dp: do not reinitialize phy unless retry during link training

Matthew Wilcox (Oracle) (1):
      drm: Do not overrun array in drm_gem_get_pages()

Ruihai Zhou (1):
      drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP ter=
m

Simon Ser (1):
      drm/atomic-helper: relax unregistered connector check

Stephen Boyd (1):
      drm/msm/dp: Add newlines to debug printks

Zack Rusin (1):
      drm/vmwgfx: Keep a gem reference to user bos in surfaces

 drivers/dma-buf/dma-fence-unwrap.c               | 13 +++-------
 drivers/dma-buf/sync_file.c                      |  9 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c         |  3 +++
 drivers/gpu/drm/drm_atomic_helper.c              | 17 ++++++++++---
 drivers/gpu/drm/drm_gem.c                        |  6 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c        | 27 ++++++++++++++------=
-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                 | 13 +++++-----
 drivers/gpu/drm/msm/dp/dp_link.c                 |  4 +--
 drivers/gpu/drm/msm/dsi/dsi_host.c               | 19 ++++++++++++---
 drivers/gpu/drm/msm/msm_mdss.c                   |  2 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c   |  4 +--
 drivers/gpu/drm/scheduler/sched_main.c           |  2 +-
 drivers/gpu/drm/tiny/simpledrm.c                 |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c               |  7 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h               | 17 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c          |  6 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h              |  4 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c          | 12 +++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c              | 18 +++++++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c              |  6 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c          |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c         | 12 ++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c           |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c          | 31 +++++++++-----------=
----
 include/linux/dma-fence.h                        | 19 +++++++++++++++
 27 files changed, 165 insertions(+), 100 deletions(-)
