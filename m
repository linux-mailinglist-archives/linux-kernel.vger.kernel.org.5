Return-Path: <linux-kernel+bounces-487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45D8141E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB511F22D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25CCA7C;
	Fri, 15 Dec 2023 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccmU+9wB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2450CA68
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so41773166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702622533; x=1703227333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhCI+8rU2ZTrrNKubhh6GdAh79QcJDbf1NF2d1tBvLc=;
        b=ccmU+9wBf+mFR1BgibVlO3bYczWVbhlL0KL0pAOVoCz06KDVv4eIFfkz0lerggLntG
         9IgiFlSqpFrfVQdlqZ2Y9P8yHFqyB4jB7omCgIVHuZ7s3kUMpYkyVwZJQGQVQKT2SMUc
         495j7r0uhpnlhBlwg1j9Amdfn8u5Y6aYXQCEnjN5YdcklaSZ841QuTnsqbV+XN3UfELz
         /ilnmn3KpOoIheb4B6ndT57quaFi5W2UvDk/nb9Nf60J3MVJuKCNfKTu9Bo8gY805ydM
         EMTcIppFi2A2by/zIZ/eVSspYPek+grLcZe4nRf9AS0ad7sY8NDcZBT86oXf4mPatTju
         Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702622533; x=1703227333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhCI+8rU2ZTrrNKubhh6GdAh79QcJDbf1NF2d1tBvLc=;
        b=CRkUYth64ROYLgYib9xJdoaYVwdv57If1NMMeau6o5APJDlrSP4NCP3XaKPdmQqGGv
         mtoM2lBm+t74TncLFR2aj/yZhe0Pon6cxAToytrqOn0hetbwhWbYxVBJJUSNutU8kHeK
         rvfMdc91pFwuq14CFDfzpK9Dk5sYQSIl6OcnKXAXrgzLXEcqlirCsTVFl4nsNbVa9YPy
         fB3UCvjjH05xe1sCir0sNPbELI1Jj19qkAFAoFZMphngc1TtHHfyjatmuIJQWplLmnvA
         okLlzbTP2VOc/aKWvlAUIO3pOYQzxkLJ4ypw+ha+oLVG7P9erc9b5ksqzKemj8FzQURb
         ajww==
X-Gm-Message-State: AOJu0YxhiO0pFdPsYe7kvsKib7yJLT8zUSaPIXB4o2GhqD2Ne3pXbOkJ
	ak3UVXtgJ5rAROtHI+Cuyb/z54Ja8+jw8iTRDU8=
X-Google-Smtp-Source: AGHT+IHqXHo+PgVfPkopjEwAFFxRUoDVvHlsX0wAxuQvaVz0Tax80RaYQjx3V0KAhtqKofM7xB/mR7LJ3TnALs7oh14=
X-Received: by 2002:a17:906:2dd:b0:a18:7e19:5347 with SMTP id
 29-20020a17090602dd00b00a187e195347mr2893251ejk.47.1702622533055; Thu, 14 Dec
 2023 22:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 15 Dec 2023 16:42:01 +1000
Message-ID: <CAPM=9txCv2m6AKVoBPbAL4jpJL2aJy_T_vvH4Tj0rdtY004Hgw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.7-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

More regular fixes, amdgpu, i915, mediatek and nouveau are most of
them this week. Nothing too major, then a few misc bits and pieces in
core, panel and ivpu.

Dave.

drm-fixes-2023-12-15:
drm fixes for 6.7-rc6

drm:
- fix uninit problems in crtc
- fix fd ownership check
- edid: add modes in fallback paths

panel:
- move LG panel into DSI yaml
- ltk050h3146w: set burst mode

mediatek:
- mtk_disp_gamma: Fix breakage due to merge issue
- fix kernel oops if no crtc is found
- Add spinlock for setting vblank event in atomic_begin
- Fix access violation in mtk_drm_crtc_dma_dev_get

i915:
- Fix selftest engine reset count storage for multi-tile
- Fix out-of-bounds reads for engine reset counts
- Fix ADL+ remapped stride with CCS
- Fix intel_atomic_setup_scalers() plane_state handling
- Fix ADL+ tiled plane stride when the POT stride is smaller than the origi=
nal
- Fix eDP 1.4 rate select method link configuration

amdgpu:
- Fix suspend fix that got accidently mangled last week
- Fix OD regression
- PSR fixes
- OLED Backlight regression fix
- JPEG 4.0.5 fix
- Misc display fixes
- SDMA 5.2 fix
- SDMA 2.4 regression fix
- GPUVM race fix

nouveau:
- fix gk20a instobj hierarchy
- fix headless iors inheritance regression

ivpu:
- fix WA initialisation
The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9=
:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-15

for you to fetch changes up to 7ba84cbf18c7a53107c64880d9c90f18fa68b481:

  drm/nouveau/kms/nv50-: Don't allow inheritance of headless iors
(2023-12-15 14:11:47 +1000)

----------------------------------------------------------------
drm fixes for 6.7-rc6

drm:
- fix uninit problems in crtc
- fix fd ownership check
- edid: add modes in fallback paths

panel:
- move LG panel into DSI yaml
- ltk050h3146w: set burst mode

mediatek:
- mtk_disp_gamma: Fix breakage due to merge issue
- fix kernel oops if no crtc is found
- Add spinlock for setting vblank event in atomic_begin
- Fix access violation in mtk_drm_crtc_dma_dev_get

i915:
- Fix selftest engine reset count storage for multi-tile
- Fix out-of-bounds reads for engine reset counts
- Fix ADL+ remapped stride with CCS
- Fix intel_atomic_setup_scalers() plane_state handling
- Fix ADL+ tiled plane stride when the POT stride is smaller than the origi=
nal
- Fix eDP 1.4 rate select method link configuration

amdgpu:
- Fix suspend fix that got accidently mangled last week
- Fix OD regression
- PSR fixes
- OLED Backlight regression fix
- JPEG 4.0.5 fix
- Misc display fixes
- SDMA 5.2 fix
- SDMA 2.4 regression fix
- GPUVM race fix

nouveau:
- fix gk20a instobj hierarchy
- fix headless iors inheritance regression

ivpu:
- fix WA initialisation

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: fix buffer funcs setting order on suspend harder
      drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Andrzej Kacprowski (1):
      accel/ivpu/37xx: Fix interrupt_clear_with_0 WA initialization

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_disp_gamma: Fix breakage due to merge issue

Christian K=C3=B6nig (2):
      drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
      drm/amdgpu: warn when there are still mappings when a BO is destroyed=
 v2

Dave Airlie (4):
      Merge tag 'mediatek-drm-fixes-20231211' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-intel-fixes-2023-12-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.7-2023-12-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2023-12-14' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

David Heidelberg (1):
      dt-bindings: panel-simple-dsi: move LG 5" HD TFT LCD panel into DSI y=
aml

Dmitrii Galantsev (1):
      drm/amd/pm: fix pp_*clk_od typo

Fangzhi Zuo (1):
      drm/amd/display: Populate dtbclk from bounding box

Farouk Bouabid (1):
      drm/panel: ltk050h3146w: Set burst mode for ltk050h3148w

Hamza Mahfooz (1):
      drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Jani Nikula (3):
      drm/crtc: fix uninitialized variable use
      drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select
      drm/edid: also call add modes in EDID connector update fallback

Jason-JH.Lin (1):
      drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Lingkai Dong (1):
      drm: Fix FD ownership check in drm_master_check_perm()

Lyude Paul (1):
      drm/nouveau/kms/nv50-: Don't allow inheritance of headless iors

Mario Limonciello (3):
      drm/amd/display: Restore guard against default backlight value < 1 ni=
t
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
      drm/amd: Fix a probing order problem on SDMA 2.4

Michael Walle (1):
      drm/mediatek: fix kernel oops if no crtc is found

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: configure doorbell for each playback

Stuart Lee (1):
      drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get

Taimur Hassan (1):
      drm/amd/display: Revert "Fix conversions between bytes and KB"

Thierry Reding (1):
      drm/nouveau: Fixup gk20a instobj hierarchy

Tvrtko Ursulin (2):
      drm/i915/selftests: Fix engine reset count storage for multi-tile
      drm/i915: Use internal class when counting engine resets

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix remapped stride with CCS on ADL+
      drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
      drm/i915: Fix ADL+ tiled plane stride when the POT stride is
smaller than the original

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

 .../bindings/display/panel/panel-simple-dsi.yaml   |  2 ++
 .../bindings/display/panel/panel-simple.yaml       |  2 --
 drivers/accel/ivpu/ivpu_hw_37xx.c                  | 12 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 15 ++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             | 28 ++++++++++++++++++=
+
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  | 12 +++++++--
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   | 14 ++++++----
 .../drm/amd/display/dc/dml2/display_mode_core.c    | 16 +++++------
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  5 ++--
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  3 ++-
 .../dc/link/protocols/link_edp_panel_control.c     |  4 +--
 .../drm/amd/display/modules/power/power_helpers.c  |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 +--
 drivers/gpu/drm/drm_auth.c                         |  2 +-
 drivers/gpu/drm/drm_crtc.c                         |  8 +++---
 drivers/gpu/drm/drm_edid.c                         |  3 ++-
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 31 +++++++++++++++---=
----
 drivers/gpu/drm/i915/display/intel_fb.c            | 19 ++++++++++---
 drivers/gpu/drm/i915/display/skl_scaler.c          |  2 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  5 ++--
 drivers/gpu/drm/i915/i915_gpu_error.h              | 12 +++++++--
 drivers/gpu/drm/i915/selftests/igt_live_test.c     |  9 ++++---
 drivers/gpu/drm/i915/selftests/igt_live_test.h     |  3 ++-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c          |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 14 +++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  5 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    | 18 ++++++-------
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c |  2 +-
 36 files changed, 190 insertions(+), 83 deletions(-)

