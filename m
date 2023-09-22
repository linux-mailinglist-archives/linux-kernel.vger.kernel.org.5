Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F577AA8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjIVGPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:15:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BACE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:15:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bffa8578feso29233801fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363298; x=1695968098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QEtm4m/HDUwFzO9pZTdCwrLXK5b58amRC64kf5nHW88=;
        b=haHFuRswhtJObT3qslzr9cU8L/OlVcDqctjzFFi/9MBEFcHCSSdHFBNDX7ei6YSvyq
         xkqRIsDfrTu5CZJIxoh3K/B3oLn/I15S1QMc++LlYJ4rHZVEJZ2oPlDNpdSg7UpXU1C0
         yETFhOHwegSRDMhKM7hCv+IGkPM/uHHwWmveJICG1sKDqseXC+dfqfIXP6TCReQBlnSj
         KHLEhFqTWHuyOypkvBDW5YwRky1kCr2iyx/NIeyF9VS4iuQ/1nBN/z2ihogUMXFOk4nP
         90Sny8EVgPeCCfUdF7N2XqXehbz5kUnJNO1DPlHK9guY52pUZsbeUN5aW3mwX1pGfdkD
         yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363298; x=1695968098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEtm4m/HDUwFzO9pZTdCwrLXK5b58amRC64kf5nHW88=;
        b=bZNXnaXOEwPwfm95UJZVTqhBYwwnBIDMIMUX7iGy1CqJ0zm+RmmBN71nC9aEjjn4Gs
         DN5vteUiWVkzSvLVB6yscVzxAIt2o5xcSE1cjeP78iiO6S9vsW1rcWaX3LE0Vwt2MitA
         lG5pkaSCns+jwe2m62fykDiI9nXJqabzkl0UtCge/1CkZGtYPs+Ca/F647vNVrXTjwEj
         tlBwoIhUNhw39mSKtk9oElBwaH0Oha99dnyePr6g0my+okC1k9K7DI6F709I/y3hH47B
         rUzKGM7XufZZEoiahHTEOTa2oBJnU3umB1gQDXWISOhsinfQZo8yJERhxeU/4Z1zT7ep
         FjKQ==
X-Gm-Message-State: AOJu0Yx5xEwviARaGBzMP6xaqvhDl5WYR/Xy/3wU38mLBXsN+GOTxKJx
        dfOwxNue2lGsI6PFICYv+Zuqzy+5fFTrpOPume4=
X-Google-Smtp-Source: AGHT+IHB+RwHSqnzUO4GjQw4umD8/scz/o9r4RC5DbJyzNfaWlXLkiIm7cwVgWW3czoiwfTPDifk9tUtxtwlp/uTmAU=
X-Received: by 2002:a2e:888c:0:b0:2bb:78ad:56cb with SMTP id
 k12-20020a2e888c000000b002bb78ad56cbmr6444668lji.37.1695363297837; Thu, 21
 Sep 2023 23:14:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Sep 2023 16:14:46 +1000
Message-ID: <CAPM=9txiBx_jsniqp-F5jGaLafEd1i=ike6kZ7G=ti7e2y-saw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regularly scheduled drm fixes, amdgpu, nouveau and i915 with a bunch
and some misc bits otherwise, nothing to strange or exciting.

Dave.

drm-fixes-2023-09-22:
drm fixes for 6.6-rc3

core:
- drm_mm test fixes

fbdev:
- Kconfig fixes

ivpu:
- IRQ-handling fixes

meson:
- Fix memory leak in HDMI EDID code

nouveau:
- Correct type casting
- Fix memory leak in scheduler
- u_memcpya() fixes

i915:
- Prevent error pointer dereference
- Fix PMU busyness values when using GuC mode

amdgpu:
- MST fix
- Vbios part number reporting fix
- Fix a possible memory leak in an error case in the RAS code
- Fix low resolution modes on eDP

amdkfd:
- Fix GPU address for user queue wptr when GART is not at 0
The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70=
:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-22

for you to fetch changes up to 54928f2f8458160e6c7217de78b48064b301e255:

  Merge tag 'amd-drm-fixes-6.6-2023-09-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-09-22
15:43:44 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc3

core:
- drm_mm test fixes

fbdev:
- Kconfig fixes

ivpu:
- IRQ-handling fixes

meson:
- Fix memory leak in HDMI EDID code

nouveau:
- Correct type casting
- Fix memory leak in scheduler
- u_memcpya() fixes

i915:
- Prevent error pointer dereference
- Fix PMU busyness values when using GuC mode

amdgpu:
- MST fix
- Vbios part number reporting fix
- Fix a possible memory leak in an error case in the RAS code
- Fix low resolution modes on eDP

amdkfd:
- Fix GPU address for user queue wptr when GART is not at 0

----------------------------------------------------------------
Arnd Bergmann (1):
      drm: fix up fbdev Kconfig defaults

Cong Liu (1):
      drm/amdgpu: fix a memory leak in amdgpu_ras_feature_enable

Dan Carpenter (2):
      nouveau/u_memcpya: fix NULL vs error pointer bug
      drm/i915/gt: Prevent error pointer dereference

Danilo Krummrich (2):
      drm/nouveau: fence: fix type cast warning in nouveau_fence_emit()
      drm/nouveau: sched: fix leaking memory of timedout job

Dave Airlie (4):
      nouveau/u_memcpya: use vmemdup_user
      Merge tag 'drm-misc-fixes-2023-09-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-09-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.6-2023-09-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Hamza Mahfooz (1):
      drm/amd/display: fix the ability to use lower resolution modes on eDP

Jani Nikula (1):
      drm/meson: fix memory leak on ->hpd_notify callback

Janusz Krzysztofik (1):
      drm/tests: Fix incorrect argument in drm_test_mm_insert_range

Jos=C3=A9 Pekkarinen (1):
      drm/virtio: clean out_fence on complete_submit

Karol Wachowski (1):
      accel/ivpu/40xx: Fix buttress interrupt handling

Lijo Lazar (1):
      Revert "drm/amdgpu: Report vbios version instead of PN"

Muhammad Ahmed (1):
      drm/amd/display: Fix MST recognizes connected displays as one

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=3Dy

Umesh Nerlige Ramappa (1):
      i915/pmu: Move execlist stats initialization to execlist specific set=
up

YuBiao Wang (1):
      drm/amdkfd: Use gpu_offset for user queue's wptr

 drivers/accel/ivpu/ivpu_hw_40xx.c                  |  9 ++++++-
 drivers/gpu/drm/Kconfig                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +--
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    | 30 ++++++++++++------=
----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  8 ++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c   |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  1 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |  2 ++
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  5 ++--
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |  2 ++
 drivers/gpu/drm/nouveau/nouveau_drv.h              | 19 ++++----------
 drivers/gpu/drm/nouveau/nouveau_exec.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            | 12 ++++++---
 drivers/gpu/drm/tests/drm_mm_test.c                |  2 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c            |  1 -
 drivers/video/console/Kconfig                      |  1 +
 drivers/video/fbdev/Kconfig                        |  2 +-
 drivers/video/fbdev/core/Kconfig                   |  2 +-
 22 files changed, 61 insertions(+), 52 deletions(-)
