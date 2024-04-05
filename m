Return-Path: <linux-kernel+bounces-132388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9188993EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E5C28B9C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66512E5B;
	Fri,  5 Apr 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N50Bssy3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4B125C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712288481; cv=none; b=rEaR6F6CgHqJYcGe73RH+nVBd3UMhoanMyOxwxY42aICm2XXoGKwdt9Q0eADcz8AEGO+8qcn6gRTieqpDZVVyF0xzgi1JtgdFk8dVvV83AfCgifL7YjoSOTz33SCTPi7YK5MXx6epvDYeWYDtqNQMh0rmen6nCBtcIinyncgBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712288481; c=relaxed/simple;
	bh=nAZaIG0+IFycaBVQKVzCMagviBg5ac+cRa6NS0+Vex0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C00XVL1GVPZIlIfn1vL8xMnrsg5VJPoWsB5Yok54DiOpmSu1R9/UmvEUxrkkesnX3NTXkkzz1PszQvrkAl1uCAzTy1Sb6MgA9j5uE9p/UwEgyqapuv/7ag/WabeLL2+OcdcgvmIim/5ZgTfiQrGlQPVlo4Del1Ql9KpkaMvh/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N50Bssy3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4162ec14805so2394415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 20:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712288478; x=1712893278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0x+wIM6WDg13r1MwUaNUerQB3emuGuUK8yHL3j0RpYc=;
        b=N50Bssy351UV36OG3F0eSY6QsD0OP0caqyT9vfB+u3ez8XcDfFWnt+QT1ZfG+cJFcy
         JRMtEp4+J7LcQfP2dPQZMU60127eHg+xS3Zt5xUTwCOez61dl85ek3iRw4hBO4ZtUbNH
         iX0JbKnkJ04UOO+iVALOEbcW1LivCqotLX2BMj1PIGFlEozhHfSQILyiApc0ohSl7V4M
         1PcWh65Qk8E/wYQnjueoTcllmdJUzmUbx773Ny8uUszL4/yE2WDx2VbJFmL3b2olgrGu
         e5772yFsRQk0A/C3dyX5BKWOeyyaROp1HpGgtXbhsyaoTr1gmrPS90/M/bvCytMYnKEg
         wvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712288478; x=1712893278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x+wIM6WDg13r1MwUaNUerQB3emuGuUK8yHL3j0RpYc=;
        b=Ea0i3DihZAtShFH4E4tyth+pLyvCuVG61xhdtrWYxgh06WuEknBv/fm+tbD8mRyPLn
         xaDsOg66lmpXZJGg9qe3s0UgDTPdoUKF/DnsBuTOfuFl1ZWYimfYBPjQTqvvNRe8gHvD
         U3v7TBcBge9MHbFDP3GIpMndvRfXbf1EGdHR9+dCB7rVqlsGpHThKg+z0iwQsXLw5cwc
         TnLlOUB5CaJ42A3VmaK9ZQfL++sr1wuExXDUvcndo2wRDOt+7xkJ5BnDkCLzarhS+Su7
         3lex+AuhVIHcCbpMWbIHUxPQhr1dYjRZu9MijPJ+3t8wwRzzGcONHom9K9EhswUD+9cy
         BaOw==
X-Forwarded-Encrypted: i=1; AJvYcCUprj26cSaCO2ihgCi4xNm8BbFAXSh0L7NGcOngZfXyWy7JuV9J0wqzKvRhUfFyD23dypX1iyFA1u1rT58FDPwcihbLB1FWj7Q+v2/l
X-Gm-Message-State: AOJu0YwBgNAsr5phwo/q3TbW3iiWj3ddIAo0j1+cf7hdCYLvuuSOt9a4
	wDZ+2gUQezxjt+dRmkO281Tk3G7ST/SzoVpIoMCEiJDzp7Nd7ulEgfTb2i/ik+9YNP/AWDnEazG
	FCmsEu9f7Csgn6mmj4HOqA1iLbjXSWKopTYA=
X-Google-Smtp-Source: AGHT+IGDZkF+6rdqyHx69tLMPPRTw7ItFLr+QlYf2fWNXPJz9sv3gOnsqghIZ38JcYav3r5jtVD7BUqJjBRSvz99KEw=
X-Received: by 2002:adf:f7c2:0:b0:33d:3566:b5c8 with SMTP id
 a2-20020adff7c2000000b0033d3566b5c8mr235163wrq.13.1712288477938; Thu, 04 Apr
 2024 20:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 5 Apr 2024 13:41:06 +1000
Message-ID: <CAPM=9tzjcdJovUtZWWGG8=Qbv_T6csXfehWrrLr=Lxd0OCsCVA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly fixes, mostly xe and i915, amdgpu on a week off, otherwise a
nouveau fix for a crash with new vulkan cts tests, and a couple of
cleanups and misc fixes.

Dave.

drm-fixes-2024-04-05:
drm fixes for v6.9-rc3

display:
- fix typos in kerneldoc

prime:
- unbreak dma-buf export for virt-gpu

nouveau:
- uvmm: fix remap address calculation
- minor cleanups

panfrost:
- fix power-transition timeouts

xe:
- Stop using system_unbound_wq for preempt fences,
- Fix saving unordered rebinding fences by attaching
  them as kernel feces to the vm's resv
- Fix TLB invalidation fences completing out of order
- Move rebind TLB invalidation to the ring ops to reduce
  the latency

i915:
- A few DisplayPort related fixes
- eDP PSR fixes
- Remove some VM space restrictions on older platforms
- Disable automatic load CCS load balancing
The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f=
:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-05

for you to fetch changes up to 4c8595741b5dd3268d6710545461ee9a7bbde891:

  Merge tag 'drm-intel-fixes-2024-04-04' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes
(2024-04-05 12:32:14 +1000)

----------------------------------------------------------------
drm fixes for v6.9-rc3

display:
- fix typos in kerneldoc

prime:
- unbreak dma-buf export for virt-gpu

nouveau:
- uvmm: fix remap address calculation
- minor cleanups

panfrost:
- fix power-transition timeouts

xe:
- Stop using system_unbound_wq for preempt fences,
- Fix saving unordered rebinding fences by attaching
  them as kernel feces to the vm's resv
- Fix TLB invalidation fences completing out of order
- Move rebind TLB invalidation to the ring ops to reduce
  the latency

i915:
- A few DisplayPort related fixes
- eDP PSR fixes
- Remove some VM space restrictions on older platforms
- Disable automatic load CCS load balancing

----------------------------------------------------------------
Andi Shyti (4):
      drm/i915/gt: Limit the reserved VM space to only the platforms
that need it
      drm/i915/gt: Disable HW load balancing for CCS
      drm/i915/gt: Do not generate the command streamer for all the CCS
      drm/i915/gt: Enable only one CCS for compute workload

Ankit Nautiyal (1):
      drm/i915/dp: Fix the computation for compressed_bpp for DISPLAY < 13

Arun R Murthy (1):
      drm/i915/dp: Remove support for UHBR13.5

Christian Hewitt (1):
      drm/panfrost: fix power transition timeout warnings

Colin Ian King (1):
      drm/nouveau/gr/gf100: Remove second semicolon

Dave Airlie (4):
      nouveau/uvmm: fix addr/range calcs for remap operations
      Merge tag 'drm-misc-fixes-2024-04-04' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-04-04' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2024-04-04' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes

Imre Deak (1):
      drm/i915/dp: Fix DSC state HW readout for SST connectors

Jouni H=C3=B6gander (3):
      drm/i915/psr: Calculate PIPE_SRCSZ_ERLY_TPT value
      drm/i915/psr: Move writing early transport pipe src
      drm/i915/psr: Fix intel_psr2_sel_fetch_et_alignment usage

Matthew Brost (1):
      drm/xe: Use ordered wq for preempt fence waiting

Oleksandr Natalenko (1):
      drm/display: fix typo

Rob Clark (1):
      drm/prime: Unbreak virtgpu dma-buf export

Thomas Hellstr=C3=B6m (4):
      drm/xe: Use ring ops TLB invalidation for rebinds
      drm/xe: Rework rebinding
      drm/xe: Make TLB invalidation fences unordered
      drm/xe: Move vma rebinding to the drm_exec locking loop

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/mst: Limit MST+DSC to TGL+
      drm/i915/mst: Reject FEC+MST on ICL

 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c  |   4 +-
 drivers/gpu/drm/drm_prime.c                        |   7 +-
 drivers/gpu/drm/i915/Makefile                      |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |   9 --
 .../gpu/drm/i915/display/intel_display_device.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  11 ++-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  78 ++++++++++-----
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |   3 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  17 ++++
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   6 ++
 drivers/gpu/drm/i915/gt/intel_gt.h                 |   9 +-
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |  39 ++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h        |  13 +++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |   6 ++
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  30 +++++-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |   2 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   6 +-
 drivers/gpu/drm/xe/xe_device.c                     |  11 ++-
 drivers/gpu/drm/xe/xe_device_types.h               |   3 +
 drivers/gpu/drm/xe/xe_exec.c                       |  79 ++-------------
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   5 +
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |   3 +-
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |   1 -
 drivers/gpu/drm/xe/xe_gt_types.h                   |   7 --
 drivers/gpu/drm/xe/xe_preempt_fence.c              |   2 +-
 drivers/gpu/drm/xe/xe_pt.c                         |  25 ++++-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  11 +--
 drivers/gpu/drm/xe/xe_sched_job.c                  |  10 ++
 drivers/gpu/drm/xe/xe_sched_job_types.h            |   2 +
 drivers/gpu/drm/xe/xe_vm.c                         | 110 +++++++++++++----=
----
 drivers/gpu/drm/xe/xe_vm.h                         |   8 +-
 drivers/gpu/drm/xe/xe_vm_types.h                   |   8 +-
 35 files changed, 340 insertions(+), 197 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

