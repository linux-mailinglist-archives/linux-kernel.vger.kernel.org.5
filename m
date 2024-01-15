Return-Path: <linux-kernel+bounces-25653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E497582D423
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159551C21047
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4F2572;
	Mon, 15 Jan 2024 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM246mO+"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33323C5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso89657281fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705299494; x=1705904294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu24RwbVV6OfhGrTeYHWgy4heI3tkvvA8kiJdl0p1xo=;
        b=dM246mO+lJLON2pSUY4FGKrvbdc3elhZ96CqSjEVMgbBcsPUSf9WzB9malLZRMGOEX
         jWfHF8NQ/bw8cWQiJoOzxTm6CbI47P1PZIgFqq53mKAw/Px9LTcUyNmPr6feJARPSCu8
         hv6y23f6LV79qy8Aq1wHZsWPQV5HKMOBh29aMrLVeDgs8VajyOeMjFX6X+Qrk9QEBs4l
         2DspDwX9xQA4YtFAgeC41D3GcAVGE2veXXlx5IgbwRmhIM+dp0a5bqvTC88li5Nv8qLq
         LOIQkqDVCZ0ByYhpXFpwfYfJ8KvxLQ7RVp7w3HB2XlO9XfO1lEsqEpx4atJOeFvz0lSu
         Ffzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705299494; x=1705904294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu24RwbVV6OfhGrTeYHWgy4heI3tkvvA8kiJdl0p1xo=;
        b=rTwAChY037gZTb83Lax1dcnOXzCYani+2TcoUlxmTYaAFzo8jLMJfDnIvxHV21SI2T
         tGSfLY8HKs0vKg1OKL47EQWn6/zn6U2LDOiY8oeucpIYCFTRPlKXV3BEIKpriEFTto8i
         jWhJijzeOM21Gw5/N1fLarV7+HHnHOWdTly/snZQ0cysHI8PhB5jd3LQBFvGVvI0wFQu
         GXdKhFgMO8tNpfR3eazBZQ//H8AByOoX/3HAYg+HUveLamIQ2OaTYVVjC3ErenudAgaW
         cCDtngJ3NjK/jp7CxevKvN4JgDTRW/j7cXFPEhQVMs8XIvB+QAHtCp3U8hokZa1D5dkl
         mJQQ==
X-Gm-Message-State: AOJu0Yype5oI8SLGerTHqUSMIZm6Pg/RnBn1vFHgsxp9aw7MmNyFQpzA
	ASMfEG6CW73GGxWTljopeqRPJz9ZabfIr8FEciM=
X-Google-Smtp-Source: AGHT+IFjWhCI9Bx+HVfPmJecMRJxI9Q1x6wTHSCjSk5BMN4k06nYZsCUfMk95/OG6gPUVp1f2lnGfdVLjtfepb+6CWs=
X-Received: by 2002:a05:6512:3d29:b0:50e:771a:9ff9 with SMTP id
 d41-20020a0565123d2900b0050e771a9ff9mr2738736lfv.78.1705299493488; Sun, 14
 Jan 2024 22:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 15 Jan 2024 16:18:01 +1000
Message-ID: <CAPM=9tx+5WuM8CjN5ACN1e4Wrr+qNhMSWQe1_g-QDiPbEpPbbg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Hopefully you get your power back at some point, this is just a wrap
up of fixes from the last few days. It has the proper fix to the
i915/xe collision, we can clean up what you did later once rc1 lands.

Otherwise it's a few other i915, a v3d, rockchip and a nouveau fix to
make GSP load on some original Turing GPUs.

I have some amdgpu fixes lined up, but they broke clang build here, so
I'll wait to send those until AMD can fix it.

Dave.

drm-next-2024-01-15-1:
drm fixes for 6.8-rc1

i915:
- Fixes for kernel-doc warnings enforced in linux-next
- Another build warning fix for string formatting of intel_wakeref_t
- Display fixes for DP DSC BPC and C20 PLL state verification

v3d:
- register readout fix

rockchip:
- two build warning fixes

nouveau:
- fix GSP loading on Turing with different nvdec configuration
The following changes since commit b76c01f1d950425924ee1c1377760de3c024ef78=
:

  Merge tag 'drm-intel-gt-next-2023-12-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2024-01-10
11:36:47 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-15-1

for you to fetch changes up to 205e18c13545ab43cc4fe4930732b4feef551198:

  nouveau/gsp: handle engines in runl without nonstall interrupts.
(2024-01-15 16:04:48 +1000)

----------------------------------------------------------------
drm fixes for 6.8-rc1

i915:
- Fixes for kernel-doc warnings enforced in linux-next
- Another build warning fix for string formatting of intel_wakeref_t
- Display fixes for DP DSC BPC and C20 PLL state verification

v3d:
- register readout fix

rockchip:
- two build warning fixes

nouveau:
- fix GSP loading on Turing with different nvdec configuration

----------------------------------------------------------------
Ankit Nautiyal (1):
      drm/i915/dp: Fix the max DSC bpc supported by source

Cristian Ciocaltea (2):
      drm/rockchip: vop2: Drop superfluous include
      drm/rockchip: vop2: Drop unused if_dclk_rate variable

Dave Airlie (3):
      Merge tag 'drm-intel-next-fixes-2024-01-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2024-01-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      nouveau/gsp: handle engines in runl without nonstall interrupts.

Imre Deak (1):
      drm/i915/dp: Fix the PSR debugfs entries wrt. MST connectors

Jani Nikula (1):
      drm/i915: don't make assumptions about intel_wakeref_t type

Ma=C3=ADra Canal (1):
      drm/v3d: Fix support for register debugging on the RPi 4

Mika Kahola (1):
      drm/i915/display: Fix C20 pll selection for state verification

Randy Dunlap (4):
      drm/i915/gem: reconcile Excess struct member kernel-doc warnings
      drm/i915/gt: reconcile Excess struct member kernel-doc warnings
      drm/i915/guc: reconcile Excess struct member kernel-doc warnings
      drm/i915/perf: reconcile Excess struct member kernel-doc warnings

 drivers/gpu/drm/i915/display/intel_cx0_phy.c       | 25 +++++---
 drivers/gpu/drm/i915/display/intel_display_power.c |  4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           | 10 +--
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |  4 +-
 drivers/gpu/drm/i915/gt/intel_gsc.h                |  7 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             | 75 ++++++++++++------=
----
 drivers/gpu/drm/i915/i915_perf_types.h             |  9 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c   |  4 ++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c    |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c     |  8 +--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  4 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c                  | 20 +++---
 13 files changed, 96 insertions(+), 78 deletions(-)

