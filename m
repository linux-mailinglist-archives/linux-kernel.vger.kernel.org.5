Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF57AA92F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIVGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:39:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542283
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:39:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso129200466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695364739; x=1695969539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcGNrh1hGrAu3yUiYqnXVMIsYc7TK7oPPTuzkFDt/F8=;
        b=frgvqHE/lwehimXsjkLlyNjshXPyZg7YlhiPXYHDrzME6fTiR7437siFOyXiUfJVio
         vgdDnCgoKM92g8G8A1ZMYmWxVyZLc7jWaWQ+Zw4FdugMqMs5iLQPwDbZDYfqK8zHBLym
         Uy7icRgNYEkRUn4xaLDUxbJ6sS2hhxUFV6hcFFM6jVwIy3GQh9wfKwe58G6kEFXvfMI5
         XE/pLFvzcfSDAXB+6qX8fSzr+VQoaxbqP4rdj3Q0Q55/qg+hvRcXeDaFu6uMBryYFXL0
         OBx18tAI4O9tqgukvuJQJoXwn6FSnroOh5UuG/iQ3zueew6FOuXjikJYxelRftNLdLuP
         907Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695364739; x=1695969539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcGNrh1hGrAu3yUiYqnXVMIsYc7TK7oPPTuzkFDt/F8=;
        b=klfQ79046B0E/qPUIm5FdFkHibvsncgI3B4NzzohCtTxulUC5LV0cTHCEMgCOnX6Ea
         mEEXkV/LT+t4jYbpLMvE3pRLjE6Eiv+Pj7BibrmCMPDXwkniozT/csyAR2n66ylaWJ/b
         4+N5t6Ih2LAn7o5LXj5KakDahl+ytxL3CKlawAatpip/BJ5Srtcfiir2W60sjaGrrvTK
         W2m4zCnyx8NK8Ajyesek9K0TWofz/EJjvVIqTc6r0DEwNgUIXZymSj3hvKwtj22ALNTd
         mrnMMKMETlFZHortJ/b4HEhqLlrJAxh278yGOF4cBYN2rfUxxJ5esTUxDM0EFs/3fWTz
         lUOg==
X-Gm-Message-State: AOJu0YwdDGS48mMpy9vb8EBxNrnQDehyOBVTst57ITio6oYmtJN0XbjD
        6Qm4FPBJVsESQ21YidLTSgFlRXRhCVQXDyGQ4hMnh+ksM2YTHA==
X-Google-Smtp-Source: AGHT+IELx/hJOe6g7KFqpSBEQ+6g3SvIkbFog+nWHTKaiQ+eXyQxhIyBAIX7RWZ+2GMecSJ9nu725OiKJ/mTYuOJF5Y=
X-Received: by 2002:a17:906:cc4f:b0:9ad:f60c:7287 with SMTP id
 mm15-20020a170906cc4f00b009adf60c7287mr2198275ejb.28.1695364738878; Thu, 21
 Sep 2023 23:38:58 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Sep 2023 16:38:47 +1000
Message-ID: <CAPM=9txUkMJPzCJLbyWTwsdfWFPmbQ1f6mH1qKJ5GXgPUOiX0w@mail.gmail.com>
Subject: drm fixes for 6.6-rc3 (resend with one more patch)
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

Hi Linus (again),

It's been one of those weeks, and I somehow managed to forget the
actual newsworthy item in this fixes pull. Ben Skeggs is stepping away
from nouveau and Red Hat for personal reasons, he'll be missed and we
intend to fill the gaps in the upcoming time with Danilo and Lyude
stepping in for now.

Otherwise what I said already, i915, nouveau, amdgpu with a few each
and some misc spread around.

Dave.

drm-fixes-2023-09-22-2:
MAINTAINERS:
- drop Ben as he retired from nouveau

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

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-22-2

for you to fetch changes up to b41b28366d3b176c8297961de4f095f2e392402d:

  MAINTAINERS: remove myself as nouveau maintainer (2023-09-22 16:32:00 +10=
00)

----------------------------------------------------------------
MAINTAINERS:
- drop Ben as he retired from nouveau

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

Ben Skeggs (1):
      MAINTAINERS: remove myself as nouveau maintainer

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

 MAINTAINERS                                        |  1 -
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |  9 ++++++-
 drivers/gpu/drm/Kconfig                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
 drivers/gpu/drdrm-fixes-2023-09-22-2:
MAINTAINERS:
- drop Ben as he retired from nouveau

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

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-22-2

for you to fetch changes up to b41b28366d3b176c8297961de4f095f2e392402d:

  MAINTAINERS: remove myself as nouveau maintainer (2023-09-22 16:32:00 +10=
00)

----------------------------------------------------------------
MAINTAINERS:
- drop Ben as he retired from nouveau

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

Ben Skeggs (1):
      MAINTAINERS: remove myself as nouveau maintainer

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

 MAINTAINERS                                        |  1 -
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
 23 files changed, 61 insertions(+), 53
deletions(-)m/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +--
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
 23 files changed, 61 insertions(+), 53 deletions(-)
