Return-Path: <linux-kernel+bounces-125391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDA7892548
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09B7B2326B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610148CCD;
	Fri, 29 Mar 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glwg6VLw"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB732125CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744160; cv=none; b=aJSUe1da62t2ibK8OCXIjk5YfczWmOrGJaHQwTPoQttCGZWp+ucqcqiAwX0IpLQpNnPJp3E7XMdtX3Zt+9BRN+ShEwPYJnP/vSueEw4++SmjgEugVedAuDq0tbDISveydoXnpBoc+RoRYVruUZTwVb7wXeCP3wnXdsRR1ZcY0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744160; c=relaxed/simple;
	bh=YHgLRwhYLEF+yFf7f+VJVNE7+aleXgVGd0+b0j1Z/2M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YS5ScixssT7OLEoerBBM4lKCTw7OzMlVv5DbZyFj1JL0YTasn0tjDPHPEIneYwbp41gOpILe47T/lYnJ6AXGhychX4/vrSBBDc6fQII2JLzwarvaEHU+A9GzehwT4f4xSXQOe6ox10lOBDR1Md9wjdy8Uc+A7zTgaLm/9QYY1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glwg6VLw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a470d7f77eeso300058966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711744156; x=1712348956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCWlSotjvCGlRdJzAtkZV2YGveK7qqoLd01P5YRtAdk=;
        b=glwg6VLw6lelDwlCdk2tiN3PpMTfhrlCrNWVY1CzJxljWEhZ9wIW5W8dtDJLU8LORx
         +9zVavXhqAkODjtjZ6U0cOy0HJq1lBFgkzkgeiyLu7xnTxFhL6rwwAApEg1puX4l7tLl
         PsfxQlMKyOGnr5tnNofF0CW6jlFMBfluZKDAH1VLu3Gz6hqWZB/hbZ5t3f1HmKLQIPl5
         16qwS4z5+P9NVi1pLYKf61xf7EbQvb+Kv7UBxmgqHyqDDQ+eZw6+bSJXxlk6G3fcflyW
         vNEBmeyMz0OWV6Rl8hHcBIWmF9cHF+D0DlsX/owlISOQWWa8SNcDbt9UjJgR1JLQMQm+
         zgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744156; x=1712348956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCWlSotjvCGlRdJzAtkZV2YGveK7qqoLd01P5YRtAdk=;
        b=pLrlJ0UXNUG4KS11uaJk+gHiGMVhjVgtsc4g0pCdymzjfUb1XyMEKpJj4RB5Wbaa7w
         wRFd7fYgSrgWWPcqDLur+qAO04FTx/JXWWGu5LPDy7nNIYX2a/A+KbpXpc8PofNQ1N6l
         y2hRlrfUYOqpntVE3QySflXVVPrQyrLMxRXpeg6X0UL/GnfpITkWkhtzccxd/IP8ESpz
         56QJL/ijQmO7cbK1XbYhbxwksvdUSXeEdTJxr22pbU0lFCCSqorUMc0x0ZFZAfBs1vBX
         aOLJSMwn3G8JOr/KA+Vh5BOENFsEb7bmKvYs0PGbeY7m3LITyak/8RfenIzqmmAFjhUm
         u2nA==
X-Forwarded-Encrypted: i=1; AJvYcCXtfxrFIbicst1YUrXeTP6Q4Y81x1pWLk2smmbRRHcbNHlz+7IgUTjrhr1MTFg/EAWQ7HcLwnOQt0Z+mV0OFuzQvC09qvPohOiwK4ne
X-Gm-Message-State: AOJu0YzRQ0QgoYH5tygMiFOagLF1THKMnS+jyJqKHFm9Vctmq3Y/pJAc
	9olFx/UnUwuVKg95J8pg957ullW8RNiDLifrzuGU85WX0GnNpNFBO8Soqt8RbJsIFXuPtAJhwHI
	x2ctD+xE2xi3gXmACaD+FppABwaE=
X-Google-Smtp-Source: AGHT+IG9knaQtIRqfn4ZHCwMfQvYe8puPmTuerbrkxt1+4O7bN51WTFbnfOqGAYAD0O+trK2dNbyNLhrGBCMETeQvao=
X-Received: by 2002:a17:906:b104:b0:a4e:1154:fa46 with SMTP id
 u4-20020a170906b10400b00a4e1154fa46mr2313605ejy.70.1711744156041; Fri, 29 Mar
 2024 13:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 30 Mar 2024 06:29:04 +1000
Message-ID: <CAPM=9tyTKh_qXRW8MaTrRnjN=Da_hLLm66dj2_WcwFQ3e3O+kg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular fixes for rc2, quite a few i915/amdgpu as usual, some xe, and
then mostly scattered around. rc3 might be quieter with the holidays
but we shall see.

Regards.
Dave.

drm-fixes-2024-03-30:
drm fixes for 6.9-rc2

bridge:
- select DRM_KMS_HELPER

dma-buf:
- fix NULL-pointer deref

dp:
- fix div-by-zero in DP MST unplug code

fbdev:
- select FB_IOMEM_FOPS for SBus

sched:
- fix NULL-pointer deref

xe:
- Fix build on mips
- Fix wrong bound checks
- Fix use of msec rather than jiffies
- Remove dead code

amdgpu:
- SMU 14.0.1 updates
- DCN 3.5.x updates
- VPE fix
- eDP panel flickering fix
- Suspend fix
- PSR fix
- DCN 3.0+ fix
- VCN 4.0.6 updates
- debugfs fix

amdkfd:
- DMA-Buf fix
- GFX 9.4.2 TLB flush fix
- CP interrupt fix

i915:
- Fix for BUG_ON/BUILD_BUG_ON IN I915_memcpy.c
- Update a MTL workaround
- Fix locking inversion in hwmon's sysfs
- Remove a bogus error message around PXP
- Fix UAF on VMA
- Reset queue_priority_hint on parking
- Display Fixes:
- Remove duplicated audio enable/disable on SDVO and DP
- Disable AuxCCS for Xe driver
- Revert init order of MIPI DSI
- DRRS debugfs fix with an extra refactor patch
- VRR related fixes
- Fix a JSL eDP corruption
 - Fix the cursor physical dma address
- BIOS VBT related fix

nouveau:
- dmem: handle kcalloc() allocation failures

qxl:
- remove unused variables

rockchip:
- vop2: remove support for AR30 and AB30 formats

vmwgfx:
- debugfs: create ttm_resource_manager entry only if needed
The following changes since commit 4cece764965020c22cff7665b18a012006359095=
:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-30

for you to fetch changes up to b01f596ab1dd027ce937358007dc1fa3e5a25917:

  Merge tag 'drm-intel-fixes-2024-03-28' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes
(2024-03-30 05:34:06 +1000)

----------------------------------------------------------------
drm fixes for 6.9-rc2

bridge:
- select DRM_KMS_HELPER

dma-buf:
- fix NULL-pointer deref

dp:
- fix div-by-zero in DP MST unplug code

fbdev:
- select FB_IOMEM_FOPS for SBus

sched:
- fix NULL-pointer deref

xe:
- Fix build on mips
- Fix wrong bound checks
- Fix use of msec rather than jiffies
- Remove dead code

amdgpu:
- SMU 14.0.1 updates
- DCN 3.5.x updates
- VPE fix
- eDP panel flickering fix
- Suspend fix
- PSR fix
- DCN 3.0+ fix
- VCN 4.0.6 updates
- debugfs fix

amdkfd:
- DMA-Buf fix
- GFX 9.4.2 TLB flush fix
- CP interrupt fix

i915:
- Fix for BUG_ON/BUILD_BUG_ON IN I915_memcpy.c
- Update a MTL workaround
- Fix locking inversion in hwmon's sysfs
- Remove a bogus error message around PXP
- Fix UAF on VMA
- Reset queue_priority_hint on parking
- Display Fixes:
- Remove duplicated audio enable/disable on SDVO and DP
- Disable AuxCCS for Xe driver
- Revert init order of MIPI DSI
- DRRS debugfs fix with an extra refactor patch
- VRR related fixes
- Fix a JSL eDP corruption
 - Fix the cursor physical dma address
- BIOS VBT related fix

nouveau:
- dmem: handle kcalloc() allocation failures

qxl:
- remove unused variables

rockchip:
- vop2: remove support for AR30 and AB30 formats

vmwgfx:
- debugfs: create ttm_resource_manager entry only if needed

----------------------------------------------------------------
Andy Yan (1):
      drm/rockchip: vop2: Remove AR30 and AB30 format support

Bhanuprakash Modem (2):
      drm/i915/drrs: Refactor CPU transcoder DRRS check
      drm/i915/display/debugfs: Fix duplicate checks in i915_drrs_status

Chris Bainbridge (1):
      drm/dp: Fix divide-by-zero regression on DP MST unplug with nouveau

Chris Park (1):
      drm/amd/display: Prevent crash when disable stream

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Dave Airlie (5):
      Merge tag 'drm-xe-fixes-2024-03-26' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.9-2024-03-27' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      drm/i915: add bug.h include to i915_memcpy.c
      Merge tag 'drm-misc-fixes-2024-03-28' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2024-03-28' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes

Duoming Zhou (1):
      nouveau/dmem: handle kcalloc() allocation failure

Eric Huang (1):
      drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

George Shen (1):
      drm/amd/display: Remove MPC rate control logic from DCN30 and above

Hamza Mahfooz (1):
      drm/amd/display: fix IPX enablement

Harry Wentland (1):
      Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets
for DP/eDP displays without PSR"

Janusz Krzysztofik (2):
      drm/i915/hwmon: Fix locking inversion in sysfs getter
      drm/i915/vma: Fix UAF on destroy against retire race

Jocelyn Falempe (1):
      drm/vmwgfx: Create debugfs ttm_resource_manager entry only if needed

Johannes Weiner (1):
      drm/amdgpu: fix deadlock while reading mqd from debugfs

Jonathan Kim (1):
      drm/amdkfd: range check cp bad op exception interrupts

Jonathon Hall (1):
      drm/i915: Do not match JSL in ehl_combo_pll_div_frac_wa_needed()

Joonas Lahtinen (1):
      drm/i915: Add includes for BUG_ON/BUILD_BUG_ON in i915_memcpy.c

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Do not print 'pxp init failed with 0' when it succeed

Juha-Pekka Heikkila (1):
      drm/i915/display: Disable AuxCCS framebuffers if built for Xe

Lang Yu (2):
      drm/amdgpu/umsch: update UMSCH 4.0 FW interface
      drm/amdgpu: enable UMSCH 4.0.6

Luca Weiss (1):
      drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE

Lucas De Marchi (1):
      drm/xe: Fix END redefinition

Mario Limonciello (1):
      drm/amd: Flush GFXOFF requests in prepare stage

Matthew Auld (5):
      drm/xe/guc_submit: use jiffies for job timeout
      drm/xe/queue: fix engine_class bounds check
      drm/xe/device: fix XE_MAX_GT_PER_TILE check
      drm/xe/device: fix XE_MAX_TILES_PER_DEVICE check
      drm/xe/query: fix gt_id bounds check

Miguel Ojeda (2):
      drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
      drm/qxl: remove unused variable from `qxl_process_single_command()`

Mukul Joshi (1):
      drm/amdkfd: Check cgroup when returning DMABuf info

Natanel Roizenman (1):
      drm/amd/display: Increase Z8 watermark times.

Neil Armstrong (1):
      Revert "drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE"

Nirmoy Das (1):
      drm/xe: Remove unused xe_bo->props struct

Pavel Sakharov (1):
      dma-buf: Fix NULL pointer dereference in sanitycheck()

Peyton Lee (1):
      drm/amdgpu/vpe: power on vpe when hw_init

Roman Li (1):
      drm/amd/display: Fix bounds check for dcn35 DcfClocks

Sung Joon Kim (1):
      drm/amd/display: Update dcn351 to latest dcn35 config

Taimur Hassan (1):
      drm/amd/display: Send DTBCLK disable message on first commit

Tejas Upadhyay (1):
      drm/i915/mtl: Update workaround 14018575942

Thomas Zimmermann (3):
      Merge drm/drm-fixes into drm-misc-fixes
      Merge drm/drm-fixes into drm-misc-fixes
      fbdev: Select I/O-memory framebuffer ops for SBus

Ville Syrj=C3=A4l=C3=A4 (6):
      drm/i915: Stop doing double audio enable/disable on SDVO and g4x+ DP
      drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, most=
ly
      drm/i915/vrr: Generate VRR "safe window" for DSB
      drm/i915/dsb: Fix DSB vblank waits when using VRR
      drm/i915: Pre-populate the cursor physical dma address
      drm/i915/bios: Tolerate devdata=3D=3DNULL in
intel_bios_encoder_supports_dp_dual_mode()

Vitaly Prosyak (1):
      drm/sched: fix null-ptr-deref in init entity

Wenjing Liu (1):
      drm/amd/display: fix a dereference of a NULL pointer

Xi Liu (2):
      drm/amd/display: increase bb clock for DCN351
      drm/amd/display: Set DCN351 BB and IP the same as DCN35

lima1002 (1):
      drm/amd/swsmu: add smu 14.0.1 vcn and jpeg msg

 drivers/dma-buf/st-dma-fence-chain.c               |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  46 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c       |  12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h       |  20 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   6 ++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c         |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c   |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   |  54 ++++++-----
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h   |  14 +--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c   |   5 +-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   4 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 103 +++++++++++++++++=
----
 .../amd/display/dc/dml2/dml2_translation_helper.c  |   6 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   3 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |  41 --------
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  41 --------
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  41 --------
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |   2 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |  11 ++-
 .../amd/display/modules/info_packet/info_packet.c  |  13 +--
 drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h |  13 ++-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h   |  28 +++---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  10 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  50 ++++++++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  21 +++--
 drivers/gpu/drm/display/drm_dp_helper.c            |   7 ++
 drivers/gpu/drm/i915/display/g4x_dp.c              |   2 -
 drivers/gpu/drm/i915/display/icl_dsi.c             |   3 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  46 +++++++--
 drivers/gpu/drm/i915/display/intel_cursor.c        |   4 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  12 +--
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   2 +-
 drivers/gpu/drm/i915/display/intel_drrs.c          |  14 ++-
 drivers/gpu/drm/i915/display/intel_drrs.h          |   3 +
 drivers/gpu/drm/i915/display/intel_dsb.c           |  14 +++
 drivers/gpu/drm/i915/display/intel_fb_pin.c        |  10 ++
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   4 -
 drivers/gpu/drm/i915/display/intel_vrr.c           |   7 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   3 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   3 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   3 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   1 +
 drivers/gpu/drm/i915/i915_driver.c                 |   2 +-
 drivers/gpu/drm/i915/i915_hwmon.c                  |  37 ++++----
 drivers/gpu/drm/i915/i915_memcpy.c                 |   2 +
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  50 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  12 +--
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   2 -
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |   4 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |   2 -
 drivers/gpu/drm/scheduler/sched_entity.c           |  12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  15 +--
 drivers/gpu/drm/xe/xe_bo.c                         |  59 ++----------
 drivers/gpu/drm/xe/xe_bo_types.h                   |  19 ----
 drivers/gpu/drm/xe/xe_device.h                     |   4 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |   2 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   2 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |  20 ++--
 drivers/gpu/drm/xe/xe_query.c                      |   2 +-
 drivers/video/fbdev/Kconfig                        |   3 +
 include/uapi/linux/kfd_ioctl.h                     |  17 +++-
 74 files changed, 565 insertions(+), 448 deletions(-)

