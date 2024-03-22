Return-Path: <linux-kernel+bounces-110859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F58864D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870912823FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07580138C;
	Fri, 22 Mar 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0fgOl9X"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF265C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071268; cv=none; b=SEA1YODTGqKk5vvIeQpCMLZJvTiUWSpzC2yfo3Dynw1JKwhXwY9RBChOfYo1FDNHIY4pQOMC4XW9pGdfrSxDUO5KlH02vUir1gkHFAcSnJOd0tRpDg2D3h0GyvvPyEHWJOQ6U2TYT6NoITShVZjUT7uw9l9FwQV39uNu+12DENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071268; c=relaxed/simple;
	bh=5GuSyXz6Sc8wS8+okXeaFP7Gg0lBqn9rpH5B/8XZr7c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PMwGQD4bDpTsuZPQyTLgq7t7gvZhPZriazW1Wg7fgBwea37MwYL3XtinhOyERpsXvqq429FI7LDZ2XKUhvP7C4v8yqoP5H8ETCTog8AaCC/GVGxrJP1c6InEDH7FyvuxCGmfBTc1TXI3F98WsIKkVn2+w9G6lMRy4OtzQqc5z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0fgOl9X; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51381021af1so2555473e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711071265; x=1711676065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n55eOdfaCctQj8ZbMkmTkN42bnoSG25KfRK5Ud9Mh1A=;
        b=k0fgOl9XkpCqHwSC59H9XB9VGCxHRNyGk8NbgmNCL47M0owL8/tPcSmTIxkh9f3d/Y
         KFWiJzsbiwVjGa0DJVaI1pNBzigMIAe3qfK4nBAWqzXBC0uUAzhoHppiMFiSrSDjx5mX
         VDrRZNoyo3i5j3lA7D46hZXdS4X+pv+0a+JRcy612Vbd30dSXIxOobknuQK11nAX/84b
         nn7cI+xmGaHiboHP2239Pn//j9TDwnf9p8RMmfB21Bb7ov1gTQi0xYfp9jINzLGiIOnp
         w4opl5uIulLHe/X0R7klhe+Owl+Fztxp293BWZML85QV4/VCVhdYHsHUpnFhBppWiQcs
         kr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711071265; x=1711676065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n55eOdfaCctQj8ZbMkmTkN42bnoSG25KfRK5Ud9Mh1A=;
        b=hjwrGkRLd6BiOtcqITJLusyK0EC9TlMlsgOsHGRC9cyJx+JUbdQQtQhhvulWWBUDh+
         my6ve+mAxkVhuXcNssgdhf7HfYczO6otrytnCN+jT6X3t9QThbkVMDYMQ3rGilyfTgKd
         /hxr7LByd7plg2wnPwm5UKn6Fe76Gdw0EMzd+UNX8m86xpluMzUDQ5TreCI3PGRkmLvx
         LpxR1fnDjlrivRlvxERbhjWgi03N2D0ONBgbSwWnBvwHwlzCc/K+tLtL/4LMEl771VnC
         7IMvf9orpaY95U3Os8NC9czqHE3DYwjLV3lkMIfdwt+wTf4Ffy6AwgpVN/S9hJLmU4FO
         r0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXWgHvrq2eflXKBODVQmqjJft8bIIHPQtptO+3sjNAVGOnUCWNF1aE1QPtGZlGuQAHjxUP0LvYDBDFDSJ3MY40jGo5azG6UOYoFRwfL
X-Gm-Message-State: AOJu0YxoDCm3erRxWOd9gMeJHr8qUclbUKP0sCMZl4r0HzIvd6smrSVu
	TjDexvy7Yikr25A/Oz8nuM4kymhE1l8PkiylbnqeovHTpyiSHpTvOXmHjFP3c8zlBUvLOS3urbn
	akh8pntbkUzWWXRdilKqkub+emWg=
X-Google-Smtp-Source: AGHT+IHHpTz0D2jCSMYDZtSXIlBXhtAQZ/nMOYbBCr6xPtxBGXU0yRJeq04bvMC1GDl9DJFr+UY6hK2XMIApf0P/dNQ=
X-Received: by 2002:a05:6512:538:b0:513:a766:4672 with SMTP id
 o24-20020a056512053800b00513a7664672mr826614lfc.4.1711071264660; Thu, 21 Mar
 2024 18:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 22 Mar 2024 11:34:13 +1000
Message-ID: <CAPM=9tzRFvT=3VK85c4Bgwd15Wcj3PaCLMXvPr3ynzHAFsvqJw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Fixes from the last week (or 3 weeks in amdgpu case), after amdgpu,
it's xe and nouveau then a few scattered core fixes.

Regards,
Dave.

drm-next-2024-03-22:
drm fixes for 6.9-rc1

core:
- fix rounding in drm_fixp2int_round()

bridge:
- fix documentation for DRM_BRIDGE_OP_EDID

sun4i:
- fix 64-bit division on 32-bit architectures

tests:
- fix dependency on DRM_KMS_HELPER

probe-helper:
- never return negative values from .get_modes() plus driver fixes

xe:
- invalidate userptr vma on page pin fault
- fail early on sysfs file creation error
- skip VMA pinning on xe_exec if no batches

nouveau:
- clear bo resource bus after eviction
- documentation fixes
- don't check devinit disable on GSP

amdgpu:
- Freesync fixes
- UAF IOCTL fixes
- Fix mmhub client ID mapping
- IH 7.0 fix
- DML2 fixes
- VCN 4.0.6 fix
- GART bind fix
- GPU reset fix
- SR-IOV fix
- OD table handling fixes
- Fix TA handling on boards without display hardware
- DML1 fix
- ABM fix
- eDP panel fix
- DPPCLK fix
- HDCP fix
- Revert incorrect error case handling in ioremap
- VPE fix
- HDMI fixes
- SDMA 4.4.2 fix
- Other misc fixes

amdkfd:
- Fix duplicate BO handling in process restore
The following changes since commit 119b225f01e4d3ce974cd3b4d982c76a380c796d=
:

  Merge tag 'amd-drm-next-6.9-2024-03-08-1' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2024-03-11
13:32:12 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-03-22

for you to fetch changes up to cafd86cbdc607eadc28a008cddacd78f0894c628:

  Merge tag 'amd-drm-fixes-6.9-2024-03-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2024-03-22
10:34:12 +1000)

----------------------------------------------------------------
drm fixes for 6.9-rc1

core:
- fix rounding in drm_fixp2int_round()

bridge:
- fix documentation for DRM_BRIDGE_OP_EDID

sun4i:
- fix 64-bit division on 32-bit architectures

tests:
- fix dependency on DRM_KMS_HELPER

probe-helper:
- never return negative values from .get_modes() plus driver fixes

xe:
- invalidate userptr vma on page pin fault
- fail early on sysfs file creation error
- skip VMA pinning on xe_exec if no batches

nouveau:
- clear bo resource bus after eviction
- documentation fixes
- don't check devinit disable on GSP

amdgpu:
- Freesync fixes
- UAF IOCTL fixes
- Fix mmhub client ID mapping
- IH 7.0 fix
- DML2 fixes
- VCN 4.0.6 fix
- GART bind fix
- GPU reset fix
- SR-IOV fix
- OD table handling fixes
- Fix TA handling on boards without display hardware
- DML1 fix
- ABM fix
- eDP panel fix
- DPPCLK fix
- HDCP fix
- Revert incorrect error case handling in ioremap
- VPE fix
- HDMI fixes
- SDMA 4.4.2 fix
- Other misc fixes

amdkfd:
- Fix duplicate BO handling in process restore

----------------------------------------------------------------
Ahmad Rehman (1):
      drm/amdgpu: Init zone device and drm client after mode-1 reset on rel=
oad

Allen Pan (1):
      drm/amd/display: Add a dc_state NULL check in dc_state_release

Arthur Grillo (1):
      drm: Fix drm_fixp2int_round() making it add 0.5

Aurabindo Pillai (1):
      drm/amd/display: Enable DML2 debug flags

ChunTao Tso (1):
      drm/amd/display: Amend coasting vtotal for replay low hz

Dave Airlie (6):
      nouveau: reset the bo resource bus info after an eviction
      Merge tag 'drm-xe-next-fixes-2024-03-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2024-03-14' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      nouveau/gsp: don't check devinit disable on GSP.
      Merge tag 'drm-misc-next-fixes-2024-03-21' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-fixes-6.9-2024-03-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

Dillon Varone (1):
      drm/amd/display: Init DPPCLK from SMU on dcn32

Dmitry Baryshkov (1):
      drm/bridge: correct DRM_BRIDGE_OP_EDID documentation

Friedrich Vock (1):
      drm/amdgpu: Reset IH OVERFLOW_EN bit for IH 7.0

Hawking Zhang (1):
      drm/amdgpu: Bypass display ta if display hw is not available

Himal Prasad Ghimiray (1):
      drm/xe: Return if kobj creation is failed

Jani Nikula (8):
      drm/probe-helper: warn about negative .get_modes()
      drm/panel: do not return negative error codes from drm_panel_get_mode=
s()
      drm/exynos: do not return negative values from .get_modes()
      drm/bridge: lt8912b: do not return negative values from .get_modes()
      drm/imx/ipuv3: do not return negative values from .get_modes()
      drm/vc4: hdmi: do not return negative values from .get_modes()
      drm/bridge: lt9611uxc: use int for holding number of modes
      drm/exynos: simplify the return value handling in exynos_dp_get_modes=
()

Josip Pavic (1):
      drm/amd/display: Allow dirty rects to be sent to dmub when abm is act=
ive

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Skip VMAs pin when requesting signal to the last XE_EXEC

Karolina Stolarek (1):
      drm/tests: Build KMS helpers when DRM_KUNIT_TEST_HELPERS is enabled

Lang Yu (2):
      drm/amdgpu: fix mmhub client id out-of-bounds access
      Revert "drm/amdgpu/vpe: don't emit cond exec command under
collaborate mode"

Le Ma (1):
      drm/amdgpu: drop setting buffer funcs in sdma442

Leo Ma (1):
      drm/amd/display: Fix noise issue on HDMI AV mute

Ma Jun (4):
      drm/amdgpu/pm: Fix NULL pointer dereference when get power limit
      drm/amdgpu/pm: Check the validity of overdiver power limit
      Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
amdgpu_device_init()"
      drm/amdgpu/pm: Don't use OD table on Arcturus

Mario Limonciello (1):
      drm/amd/display: Use freesync when
`DRM_EDID_FEATURE_CONTINUOUS_FREQ` found

Matthew Brost (1):
      drm/xe: Invalidate userptr VMA on page pin fault

Maxime Ripard (1):
      drm/sun4i: hdmi: Fix u64 div on 32bit arch

Mukul Joshi (1):
      drm/amdgpu: Handle duplicate BOs during process restore

Nicholas Kazlauskas (1):
      drm/amd/display: Fix idle check for shared firmware state

Philip Yang (1):
      drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Prike Liang (1):
      drm/amdgpu: correct the KGQ fallback message

Rodrigo Siqueira (1):
      drm/amd/display: Return the correct HDCP error code

Ryan Lin (1):
      drm/amd/display: Add monitor patch for specific eDP

Saleemkhan Jamadar (1):
      drm/amdgpu/vcn: enable vcn1 fw load for VCN 4_0_6

Sohaib Nadeem (1):
      drm/amd/display: Override min required DCFCLK in dml1_validate

Swapnil Patel (1):
      drm/amd/display: Change default size for dummy plane in DML2

Timur Tabi (1):
      drm/nouveau: fix kerneldoc warnings

Vitaly Prosyak (1):
      drm/amdgpu: fix use-after-free bug

Wenjing Liu (4):
      drm/amd/display: Update odm when ODM combine is changed on an
otg master pipe with no plane
      drm/amd/display: Lock all enabled otg pipes even with no planes
      drm/amd/display: Implement wait_for_odm_update_pending_complete
      drm/amd/display: Revert Remove pixle rate limit for subvp

ZhenGuo Yin (1):
      drm/amdgpu: Skip access PF-only registers on gfx10/gfxhub2_1 under SR=
IOV

 drivers/gpu/drm/Kconfig                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 16 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            | 20 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 18 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 38 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  8 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |  3 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |  6 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            |  7 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           | 23 +------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  8 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            | 10 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 25 +++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 14 +++++
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 71 ++++++++++++++++++=
+---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  4 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   | 14 +++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h   |  2 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c |  1 +
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |  6 ++
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  1 +
 .../amd/display/dc/dml2/dml2_translation_helper.c  | 18 +++++-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 28 ++++++---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h |  3 +
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    | 45 +++++++-------
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 12 +++-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 30 +++++++++
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |  3 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h          |  4 +-
 .../dc/link/protocols/link_edp_panel_control.c     |  4 +-
 .../dc/link/protocols/link_edp_panel_control.h     |  4 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |  3 +-
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |  8 +++
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h |  1 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |  3 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |  3 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |  2 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  8 +++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  3 +
 .../drm/amd/display/modules/power/power_helpers.c  |  2 +-
 .../drm/amd/display/modules/power/power_helpers.h  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 28 ++-------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 19 +++---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 31 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 18 +++---
 drivers/gpu/drm/bridge/lontium-lt8912b.c           | 16 +++--
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |  2 +-
 drivers/gpu/drm/drm_panel.c                        | 17 ++++--
 drivers/gpu/drm/drm_probe_helper.c                 |  7 +++
 drivers/gpu/drm/exynos/exynos_dp.c                 |  7 +--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  4 +-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |  4 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c |  1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |  9 +++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  2 +-
 drivers/gpu/drm/xe/xe_exec.c                       | 41 +++++++------
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |  4 +-
 drivers/gpu/drm/xe/xe_trace.h                      |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                         | 32 +++++++---
 drivers/gpu/drm/xe/xe_vm_types.h                   |  7 +--
 drivers/gpu/drm/xe/xe_vram_freq.c                  |  4 +-
 include/drm/drm_bridge.h                           |  4 +-
 include/drm/drm_fixed.h                            |  3 +-
 include/drm/drm_modeset_helper_vtables.h           |  3 +-
 87 files changed, 565 insertions(+), 285 deletions(-)

