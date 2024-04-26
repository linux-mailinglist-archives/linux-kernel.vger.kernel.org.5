Return-Path: <linux-kernel+bounces-159457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374C8B2EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFECF1F2294D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885607580D;
	Fri, 26 Apr 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8UIKpbj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02334EBE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714101138; cv=none; b=B4VmV7E12M+kE4NUX07qlnED+kIPGhbArqoCw2+93DFOxEl7C0CNfhDoBnYOo9BrTQjINXfdOhlwZrom2PrbUCvJ6taE3MOLRho2cmnffIkZkklMldUZurpkKcdDfkCX3lqHqag+IF0vjMV99eNNGWfCXXST2UsentC4q2smNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714101138; c=relaxed/simple;
	bh=cP0kCvI96rwsPcehcUWq7JTzqJql2pkoDE2HMCeaWeU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KJ0Bd4H7rdGFSecXdHbqdK5awrCK6S7vfJIuztLI+BTW3SNloT7ycpjR7Lx5/eeKX1vCZ3c0oXNrDZIv8no9vxXjDpaoThVIaSwH6Gt5qpOouV16fujE+hbaKaVg4du2yvgu08iWmYyp+0WdlNlPXIbh5O1Kj5s1rPTbJCX1o3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8UIKpbj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so2446045a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714101135; x=1714705935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lzJxgcz5m8G1EM1ywnq84RC3ba8Z9yxAODKAr5+fyo4=;
        b=R8UIKpbjIcZtDbWd4EhJNGJFYjRHfch3TvP81P7AzIhb+IHUlAcITkso2sqgYLiePD
         V1K7uOpGHR5fAuwsHeWC8M+VDKzwJdl60n/u2gCTL8wkGRa0tOKWSFjsJTE2N5xF2SBE
         j6GCbAvhttlSeWW/ym/vJftDpeuCAv69+IidJpSILbAVKL2xPfPGo4RNOJfJXZ+KP1CQ
         nivQDWg1u+w5HCXXY7H+hmy1LRCb4MvYI3gzI/H3isc9RJjJpi8keouPqBHdkslD+//+
         LwPbojr8JG23JmRULnQ6oubdInVf2oDs52k9Q/Fbs6dowwB9lcYa1pARDs6XWH6OA3a4
         AZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714101135; x=1714705935;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzJxgcz5m8G1EM1ywnq84RC3ba8Z9yxAODKAr5+fyo4=;
        b=fVJSehrb4RFybYkx5RrBnKaBxPg2IwIisM+BzXT4804P2mvEUBeERQQJLQRwI0Xbwi
         6r6uu+ADqf5+oN2lAdj6jdULQUljro4ORTbZWULtjfQzXWhtB8DX8YzwqHZwF/ys6SoW
         QwWyzO0dzrSh2gYb6ie3EVBwjGn4zY4srHFMByp+RZJHHQ7SmXGStgRRIrVio+8+8mGm
         eeOrC3le3h81AWtSGT4iUpYO0dYgIEllWjGSaKrG9WPI72bZKcq5mJ0ooXahYccySpIQ
         Wu3F6OEA3ymZgeGsEEBD8mFyPZpzHLXVUeBcgbww8dHa1pKliisQ/ZsdnFSl+OakbdzU
         CFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFEM4W5Vi+KlDcjjkcWvjE6oW6n0Jn1YKMVvJXONKAAPA4gdS4OTi5lu4LR91KL9Z7vtf6QkIVQbI58Kwaqa5frjl0IN6uZ1/HFU5
X-Gm-Message-State: AOJu0YzGXabLRbC3g/USDJ8sMMAZxhttd+foA1EuFNXgUxnYmWGmbe/z
	NMByCUDxL6XkxzIv/DL6ImDo0fIRie8Btzr+nGQHyRhor9/0a4hfgYwgQFyGS1sqN1akaQxm+Ix
	FN33M3+UZYNm3FyB/XoptbMjtBhv6daoJ
X-Google-Smtp-Source: AGHT+IETZzj7+KbUL8RVv/0sv9PH6DI1lOTUGAYPSnXI4E0GBHIUrWfWmHBNHqMLo2MbNCBKiE8BB2UQSeMVrN8YiOQ=
X-Received: by 2002:a17:906:e17:b0:a52:6c23:fa90 with SMTP id
 l23-20020a1709060e1700b00a526c23fa90mr1039563eji.1.1714101135116; Thu, 25 Apr
 2024 20:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 26 Apr 2024 13:12:03 +1000
Message-ID: <CAPM=9tzOc8ybNWouvj+Zz2kZy1iXVDgJ9v3yi_Owfz+jp2tqkw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Regular weekly merge request, mostly amdgpu and misc bits in
xe/etnaviv/gma500 and some core changes. Nothing too outlandish, seems
to be about normal for this time of release.

Regards,
Dave.

drm-fixes-2024-04-26:
drm fixes for 6.9-rc6

atomic-helpers:
- Fix memory leak in drm_format_conv_state_copy()

fbdev:
- fbdefio: Fix address calculation

amdgpu:
- Suspend/resume fix
- Don't expose gpu_od directory if it's empty
- SDMA 4.4.2 fix
- VPE fix
- BO eviction fix
- UMSCH fix
- SMU 13.0.6 reset fixes
- GPUVM flush accounting fix
- SDMA 5.2 fix
- Fix possible UAF in mes code

amdkfd:
- Eviction fence handling fix
- Fix memory leak when GPU memory allocation fails
- Fix dma-buf validation
- Fix rescheduling of restore worker
- SVM fix

gma500:
- Fix crash during boot

etnaviv:
- fix GC7000 TX clock gating
- revert NPU UAPI changes

xe:
- Fix error paths on managed allocations
- Fix PF/VF relay messages
The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-26

for you to fetch changes up to 3a8534035c0747610312f9552898a0ece10ef8a7:

  Merge tag 'drm-xe-fixes-2024-04-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-04-26 12:56:58 +1000)

----------------------------------------------------------------
drm fixes for 6.9-rc6

atomic-helpers:
- Fix memory leak in drm_format_conv_state_copy()

fbdev:
- fbdefio: Fix address calculation

amdgpu:
- Suspend/resume fix
- Don't expose gpu_od directory if it's empty
- SDMA 4.4.2 fix
- VPE fix
- BO eviction fix
- UMSCH fix
- SMU 13.0.6 reset fixes
- GPUVM flush accounting fix
- SDMA 5.2 fix
- Fix possible UAF in mes code

amdkfd:
- Eviction fence handling fix
- Fix memory leak when GPU memory allocation fails
- Fix dma-buf validation
- Fix rescheduling of restore worker
- SVM fix

gma500:
- Fix crash during boot

etnaviv:
- fix GC7000 TX clock gating
- revert NPU UAPI changes

xe:
- Fix error paths on managed allocations
- Fix PF/VF relay messages

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Christian Gmeiner (1):
      Revert "drm/etnaviv: Expose a few more chipspecs to userspace"

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.9-2024-04-24' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-04-25' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-etnaviv-fixes-2024-04-25' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-04-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Derek Foreman (1):
      drm/etnaviv: fix tx clock gating on some GC7000 variants

Felix Kuehling (3):
      drm/amdkfd: Fix eviction fence handling
      drm/amdgpu: Update BO eviction priorities
      drm/amdkfd: Fix rescheduling of restore worker

Himal Prasad Ghimiray (2):
      drm/xe: Remove sysfs only once on action add failure
      drm/xe: call free_gsc_pkt only once on action add failure

Jack Xiao (1):
      drm/amdgpu/mes: fix use-after-free issue

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Lang Yu (2):
      drm/amdkfd: make sure VM is ready for updating operations
      drm/amdgpu/umsch: don't execute umsch test when GPU is in reset/suspend

Lijo Lazar (2):
      drm/amdgpu: Assign correct bits for SDMA HDP flush
      drm/amd/pm: Restore config space after reset

Lucas Stach (1):
      drm/atomic-helper: fix parameter order in
drm_format_conv_state_copy() call

Ma Jun (1):
      drm/amdgpu/pm: Remove gpu_od if it's an empty directory

Michal Wajdeczko (1):
      drm/xe/guc: Fix arguments passed to relay G2H handlers

Mukul Joshi (2):
      drm/amdgpu: Fix leak when GPU memory allocation fails
      drm/amdkfd: Add VRAM accounting for SVM migration

Nam Cao (1):
      fbdev: fix incorrect address computation in deferred IO

Patrik Jakobsson (1):
      drm/gma500: Remove lid code

Peyton Lee (1):
      drm/amdgpu/vpe: fix vpe dpm setup failed

Prike Liang (1):
      drm/amdgpu: Fix the ring buffer size for queue VM flush

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 35 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             | 26 ++++---
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c              | 14 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           | 16 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 15 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  7 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 25 +++++++
 drivers/gpu/drm/drm_gem_atomic_helper.c            |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              | 24 +------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              | 12 ----
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             | 34 ---------
 drivers/gpu/drm/gma500/Makefile                    |  1 -
 drivers/gpu/drm/gma500/psb_device.c                |  5 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |  9 ---
 drivers/gpu/drm/gma500/psb_lid.c                   | 80 ----------------------
 drivers/gpu/drm/xe/xe_gt.c                         |  4 +-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                | 19 ++---
 drivers/gpu/drm/xe/xe_gt_ccs_mode.h                |  2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  4 +-
 drivers/gpu/drm/xe/xe_huc.c                        |  9 +--
 drivers/video/fbdev/core/fb_defio.c                |  2 +-
 include/uapi/drm/etnaviv_drm.h                     |  5 --
 32 files changed, 131 insertions(+), 243 deletions(-)
 delete mode 100644 drivers/gpu/drm/gma500/psb_lid.c

