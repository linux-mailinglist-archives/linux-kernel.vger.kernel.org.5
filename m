Return-Path: <linux-kernel+bounces-87938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2D86DB37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962BD1F23315
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BC5102B;
	Fri,  1 Mar 2024 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZrt2tHw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88612F53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271678; cv=none; b=PobJZQ4iKeexiFWzytg2Z7g3EPZA9ZoDtdl6TfnOxq9xZDnxSzbYHYbZW0+0QsJW9xfKgYjBLX9Nq3jbH2CqpFvtG4kjl2DCjdkkm0yhudA79+nRso4p8K+c31CmAew+3aG+79Bjc8N86h06gJqV6nPyDPzMggnptgYV0tmXukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271678; c=relaxed/simple;
	bh=3SQ9dusVHdgotbJWFTACsaoMUKU9ECh+i2hCfqv66ws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lerfSt4FmddENtQkGXHJtPk1/OCGZS8Rn0blx174ATdKXr6ZVUt0Nu8236opPzWPHhmtAs0Im2a72glNX4ZcmOSIGPpXq/9Qwwwjjqhbrqkdk3Qo6Owpn9LnCCm6srzOMYoMhh72wm5zl8BjD/20CMN/SO+4l1QZFG0pqBzftxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZrt2tHw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so5257663a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709271675; x=1709876475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOjC4nxpEij9WxAX1kxnNARpFgG4U26yhskqesqGE6Q=;
        b=TZrt2tHwcen9RfAyQyud8T5I+kEiuyVGzfikUdAzL0W478G7KmNfPp/CqBUy63z3aL
         po2gmUZVeoXkifMsAfJpPX/NNSYyI+YMVYe9CXf/Q9+6aGj1Ai+YGWbpcar0O5i9s3Bx
         On/dozyb82VmsAFu7ccqzKuvDiRoG8kJYtHWMIBHPzh7G5JdjFjOP2TuR5kY2ScrnXSd
         KPDLWw1oB5QRHVgF+g5YA34we0WhiafdKC69HXy9mLywhebNen83+vo25H4IAUD5Zccx
         9MgipoMsPdECvaNWrRqiobjwRmAYISa/LCLwEjtliQOEmuPUKGyXyCxvztrd/rN6dfBw
         CDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271675; x=1709876475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOjC4nxpEij9WxAX1kxnNARpFgG4U26yhskqesqGE6Q=;
        b=fMu7T1IffwigziPs3kyjKVc9/ckfmVBv0ZkJKX6L1bgZs0cVDLKoWMBnWnbjSiOC3a
         SVjgx+1hffHTmyg0hJ2Q9t0fiJTy7W4dABirSGUbxNVihA7EtJkz9oPUneqYCpRUBOHc
         NKUfnVX55cNwjT9uD8negJ1RPngdPeyZIKieGGJTbLFKbpjW8k9Lz3gBM2Nx3fncoOuZ
         oltycr4BGyMwQtUg7vmIDlD9YTIOWFTBIMqLaRargmgsuVNbX/pxOmhKvHGdW73FIP0p
         vhcXWSvqr58YEaMKbFlD7WsqmhlPK000Rkrxt7u3Z/Lhme1p4OBbFSbbmiNHm5kp+a+f
         u+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX7OZGKKtLdAaM8cBJBagyO8gGhRNH2qmOjMWIyB0EjQKWIxZ5LnBGwxhrxIM7AmClo8wBeWRCaPqzQiKW/8/MhviIa34hzOQnskskF
X-Gm-Message-State: AOJu0YxHQen6tjM2bvCno3dGZo0gdOKiv6Fb4G4cUrc2meNA9tkSwygU
	MeJ7vybU3Dv+d3bFx0AseLNnx099DoqaggCc2GMzmVk5OjRnUhNf5IDj5nYr4wBz5WQGHmAEFyh
	Nlw9rgriqQWkFZP7SDRk5+D1CJdQ=
X-Google-Smtp-Source: AGHT+IG9v4HM3fFKna7+0z/CzZAAQDHmA47gTT+yDJADeC0NIo6pUe6imnkssYpQqp9TtA4uy3JLF/vZ5VgJZWOYwKE=
X-Received: by 2002:a17:906:cb90:b0:a44:cd4:95e0 with SMTP id
 mf16-20020a170906cb9000b00a440cd495e0mr795658ejb.1.1709271674998; Thu, 29 Feb
 2024 21:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 1 Mar 2024 15:41:03 +1000
Message-ID: <CAPM=9tyc=L_69XMch05z=R+Kw2BC-jRCgnYMXMRtUN+RkCW=2w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular weekly fixes pull, I'll be travelling for a few days but I
don't think it should interfere with anything apart from my
responsiveness if things go wrong :-P.

Bunch of fixes, xe, amdgpu, nouveau and tegra all have a few. Then
drm/bridge including some drivers/soc fallout fixes. The biggest thing
in here is a new unit test for some buddy allocator fixes, otherwise a
misc fbcon, ttm unit test and one msm revert.

Seems to pretty normal for this stage.

Regards,
Dave.

drm-fixes-2024-03-01:
drm fixes for 6.8-rc7

buddy:
- two allocation fixes + unit test

fbcon:
- font restore syzkaller fix

ttm:
- kunit test fix

bridge:
- fix aux-hpd leaks
- fix aux-hpd registration
- fix use after free in soc/qcom
- fix boot on soc/qcom

xe:
- A couple of tracepoint updates from Priyanka and Lucas.
- Make sure BINDs are completed before accepting UNBINDs on LR vms.
- Don't arbitrarily restrict max number of batched binds.
- Add uapi for dumpable bos (agreed on IRC).
- Remove unused uapi flags and a leftover comment.
- A couple of fixes related to the execlist backend.

msm:
- DP: Revert a change which was causing a HDP regression

amdgpu:
- Fix potential buffer overflow
- Fix power min cap
- Suspend/resume fix
- SI PM fix
- eDP fix

nouveau:
- fix a misreported VRAM sizing
- fix a regression in suspend/resume due to freeing

tegra:
- host1x reset fix
- only remove existing driver if display is possible
The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b=
:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-01

for you to fetch changes up to f6ecfdad359a01c7fd8a3bcfde3ef0acdf107e6e:

  drm/nouveau: keep DMA buffers required for suspend/resume
(2024-03-01 15:27:04 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc7

buddy:
- two allocation fixes + unit test

fbcon:
- font restore syzkaller fix

ttm:
- kunit test fix

bridge:
- fix aux-hpd leaks
- fix aux-hpd registration
- fix use after free in soc/qcom
- fix boot on soc/qcom

xe:
- A couple of tracepoint updates from Priyanka and Lucas.
- Make sure BINDs are completed before accepting UNBINDs on LR vms.
- Don't arbitrarily restrict max number of batched binds.
- Add uapi for dumpable bos (agreed on IRC).
- Remove unused uapi flags and a leftover comment.
- A couple of fixes related to the execlist backend.

msm:
- DP: Revert a change which was causing a HDP regression

amdgpu:
- Fix potential buffer overflow
- Fix power min cap
- Suspend/resume fix
- SI PM fix
- eDP fix

nouveau:
- fix a misreported VRAM sizing
- fix a regression in suspend/resume due to freeing

tegra:
- host1x reset fix
- only remove existing driver if display is possible

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amd/pm: resolve reboot exception for si oland"

Arnd Bergmann (1):
      drm/xe/mmio: fix build warning for BAR resize on 32-bit

Christian K=C3=B6nig (1):
      drm/ttm/tests: depend on UML || COMPILE_TEST

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2024-02-29' of
https://anongit.freedesktop.org/git/drm/drm-misc into drm-fixes
      Merge tag 'drm-xe-fixes-2024-02-29' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-msm-fixes-2024-02-28' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-6.8-2024-02-29' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      nouveau: report byte usage in VRAM usage.

Dmitry Baryshkov (1):
      Revert "drm/msm/dp: use drm_bridge_hpd_notify() to report HPD
status changes"

Francois Dugast (1):
      drm/xe/uapi: Remove unused flags

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Johan Hovold (3):
      drm/bridge: aux-hpd: fix OF node leaks
      drm/bridge: aux-hpd: separate allocation and registration
      soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free

Jos=C3=A9 Roberto de Souza (1):
      drm/xe/uapi: Remove DRM_XE_VM_BIND_FLAG_ASYNC comment left over

Lucas De Marchi (1):
      drm/xe: Use pointers in trace events

Ma Jun (1):
      drm/amdgpu/pm: Fix the power1_min_cap value

Maarten Lankhorst (1):
      drm/xe: Add uapi for dumpable bos

Matthew Auld (3):
      drm/buddy: fix range bias
      drm/buddy: check range allocation matches alignment
      drm/tests/drm_buddy: add alloc_range_bias test

Matthew Brost (3):
      drm/xe: Fix execlist splat
      drm/xe: Don't support execlists in xe_gt_tlb_invalidation layer
      drm/xe: Use vmalloc for array of bind allocation in bind IOCTL

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Mika Kuoppala (2):
      drm/xe: Expose user fence from xe_sync_entry
      drm/xe: Deny unbinds if uapi ufence pending

Mikko Perttunen (1):
      gpu: host1x: Skip reset assert on Tegra186

Paulo Zanoni (1):
      drm/xe: get rid of MAX_BINDS

Prike Liang (1):
      drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series

Priyanka Dandamudi (2):
      drm/xe/xe_bo_move: Enhance xe_bo_move trace
      drm/xe/xe_trace: Add move_lacks_source detail to xe_bo_move trace

Rob Clark (1):
      soc: qcom: pmic_glink: Fix boot when QRTR=3Dm

Ryan Lin (1):
      drm/amd/display: Add monitor patch for specific eDP

Sid Pranjale (1):
      drm/nouveau: keep DMA buffers required for suspend/resume

Srinivasan Shanmugam (1):
      drm/amd/display: Prevent potential buffer overflow in map_hw_resource=
s

Thierry Reding (1):
      drm/tegra: Remove existing framebuffer only if we support display

 drivers/gpu/drm/Kconfig                            |   5 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  45 +++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c |   5 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   9 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   9 +-
 drivers/gpu/drm/bridge/aux-hpd-bridge.c            |  70 +++++--
 drivers/gpu/drm/drm_buddy.c                        |  16 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |  20 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |   4 +-
 drivers/gpu/drm/tegra/drm.c                        |  23 ++-
 drivers/gpu/drm/tests/drm_buddy_test.c             | 218 +++++++++++++++++=
++++
 drivers/gpu/drm/xe/xe_bo.c                         |  11 +-
 drivers/gpu/drm/xe/xe_bo.h                         |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c                 |  12 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  88 +--------
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |  10 -
 drivers/gpu/drm/xe/xe_execlist.c                   |   2 +-
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |  12 ++
 drivers/gpu/drm/xe/xe_lrc.c                        |  10 +-
 drivers/gpu/drm/xe/xe_mmio.c                       |   2 +-
 drivers/gpu/drm/xe/xe_sync.c                       |  58 +++++-
 drivers/gpu/drm/xe/xe_sync.h                       |   4 +
 drivers/gpu/drm/xe/xe_sync_types.h                 |   2 +-
 drivers/gpu/drm/xe/xe_trace.h                      |  59 ++++--
 drivers/gpu/drm/xe/xe_vm.c                         |  80 +++++---
 drivers/gpu/drm/xe/xe_vm_types.h                   |  11 +-
 drivers/gpu/host1x/dev.c                           |  15 +-
 drivers/gpu/host1x/dev.h                           |   6 +
 drivers/soc/qcom/pmic_glink.c                      |  21 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |  16 +-
 drivers/video/fbdev/core/fbcon.c                   |   8 +-
 include/drm/bridge/aux-bridge.h                    |  15 ++
 include/uapi/drm/xe_drm.h                          |  21 +-
 39 files changed, 659 insertions(+), 293 deletions(-)

