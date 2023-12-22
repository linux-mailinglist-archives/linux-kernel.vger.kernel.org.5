Return-Path: <linux-kernel+bounces-9356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D936B81C47D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90152285580
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CA8F5A;
	Fri, 22 Dec 2023 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVY55bb4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0F8F40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55462583ae0so5243a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703221190; x=1703825990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQqKvWO5zpgbO53H46vu3olCtWjTZGqQDRCPR+HkntE=;
        b=gVY55bb4J+bCczsV+BG0HI+MTFe/CigoU6jJJLV0I8SSnqMMMe3X1TPTwCx0ZUzXu1
         JU5sy601xZNeBQQLobbSfEDO5d/jjsDvM7fWg73wrJcJR5Yyfu9fRnLvlgnoJsdaZQFi
         7jOUgC4eB0PVuqBmlao1MtyMKmOhbOr+oF3aZqJ9ZaG9kSOMQ4F8sCsaifc+bgck+yD+
         TMT/8YEAbMsQLdKb7zYSfawP62o0/OEbecuAv0G2+Z3WMJILR6urEyTVSLGmuCp3LvrV
         WRiFzoNJd3yovNQpK6ip1OBv9llMWGjD4l0VgFj0h4GY8m4xvoKFxRyeKlv2iO+uDhYc
         y/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703221190; x=1703825990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQqKvWO5zpgbO53H46vu3olCtWjTZGqQDRCPR+HkntE=;
        b=CURx8ZbRVAahaQDc5wZwsTu0yafwpSQUtck4jnW+qp2yEqczvaRzeaKGY4B6d2JXm0
         mSWqrNSwpMxZQV/bbfmG0xaJJLe8RW9cSsfnwy+hJ8fEuQrM8myqm6V5uHGsjiO7gC6X
         rxFmQi60qSzL7aj6Xt3zEBWpSJqyoKYIYGxXsT/LVWOR7xJZHMmVfbOyP9C0iOtFCHAc
         z9jH44DN1huoQcBm4Y2Zpy7IzfwZyk0/ssoZEuvjgVhQaEkTJ5bqssEhvdegQVKPzIzR
         2a2xQAVdAW8EiK0eRQisGTH8JVRwzlmsYYzWO/JeZiEon8xwPdUbDnAV0Vh6QQ+Tn1Ji
         hgqQ==
X-Gm-Message-State: AOJu0Yyh97Ov+0sZ/Ts0Z6PSx/VSTMeQuECuMiVSkwgm8LAdpFhfUQZE
	5OfNlzgpTTLoipVbgM2dA4g3Fv5tNwwepIqUrYg=
X-Google-Smtp-Source: AGHT+IFMWu2U+0t62tk/hUPkfMn/vYVc3TBcmU9QphvzOw1lz2NfnvCPqyNrUeSKigubhzVVI5kLPVf5h60Gn49c4QM=
X-Received: by 2002:a17:906:906:b0:a26:87e2:53 with SMTP id
 i6-20020a170906090600b00a2687e20053mr233515ejd.222.1703221190138; Thu, 21 Dec
 2023 20:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 22 Dec 2023 14:59:38 +1000
Message-ID: <CAPM=9txmoVE1CPtarnL=Y4M8XxHs0VYkfdWw-X2MErNHt+DEig@mail.gmail.com>
Subject: [git pull] drm fixes for 6.7-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Pretty quiet for this week, just i915 and amdgpu fixes, I think the
misc tree got lost this week, but didn't seem to have too much in it,
so it can wait. I've also got a bunch of nouveau GSP fixes sailing
around that'll probably land next time as well.

Dave.

drm-fixes-2023-12-22:
drm fixes for 6.7-rc7

amdgpu:
- DCN 3.5 fixes
- DCN 3.2 SubVP fix
- GPUVM fix

amdkfd:
- SVM fix for APUs

i915:
- Fix state readout and check for DSC and bigjoiner combo
- Fix a potential integer overflow
- Reject async flips with bigjoiner
- Fix MTL HDMI/DP PLL clock selection
- Fix various issues by disabling pipe DMC events
The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb=
:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-22

for you to fetch changes up to d4b6e7f582e29acac17bcaf7f7771138d72f89d2:

  Merge tag 'drm-intel-fixes-2023-12-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-12-22
13:11:09 +1000)

----------------------------------------------------------------
drm fixes for 6.7-rc7

amdgpu:
- DCN 3.5 fixes
- DCN 3.2 SubVP fix
- GPUVM fix

amdkfd:
- SVM fix for APUs

i915:
- Fix state readout and check for DSC and bigjoiner combo
- Fix a potential integer overflow
- Reject async flips with bigjoiner
- Fix MTL HDMI/DP PLL clock selection
- Fix various issues by disabling pipe DMC events

----------------------------------------------------------------
Alvin Lee (1):
      drm/amd/display: Revert " drm/amd/display: Use channel_width =3D 2
for vram table 3.0"

Ankit Nautiyal (1):
      drm/i915/display: Get bigjoiner config before dsc config during reado=
ut

Charlene Liu (1):
      drm/amd/display: get dprefclk ss info from integration info table

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-6.7-2023-12-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2023-12-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Hamza Mahfooz (1):
      drm/amd/display: disable FPO and SubVP for older DMUB versions on DCN=
32x

Imre Deak (1):
      drm/i915/mtl: Fix HDMI/DP PLL clock selection

Josip Pavic (1):
      drm/amd/display: dereference variable before checking for zero

Karthik Poosa (1):
      drm/i915/hwmon: Fix static analysis tool reported issues

Philip Yang (1):
      drm/amdkfd: svm range always mapped flag not working on APU

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Reject async flips with bigjoiner
      drm/i915/dmc: Don't enable any pipe DMC events

Wayne Lin (1):
      drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

ZhenGuo Yin (1):
      drm/amdgpu: re-create idle bo's PTE during VM state machine reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               | 18 ++++++---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 27 ++++++++------
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 26 +++++++++----
 .../drm/amd/display/dc/dml2/display_mode_core.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  6 +++
 .../amd/display/include/grph_object_ctrl_defs.h    |  2 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |  3 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 13 ++++++-
 drivers/gpu/drm/i915/display/intel_dmc.c           | 43 ++++++++++++++++++=
+++-
 drivers/gpu/drm/i915/i915_hwmon.c                  |  4 +-
 11 files changed, 112 insertions(+), 33 deletions(-)

