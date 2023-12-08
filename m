Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD92809B37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjLHEyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:54:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C71F10F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:54:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1c7b20f895so198685266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011273; x=1702616073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/NPSVNV86/gWAz2b/XLZN3N1S3hmdyNSP82JFLWw5pI=;
        b=ew+jLz9KAqEwAVAIC0dy1SlrcyEqX00Qf2FDIpb2SKIx45dAJJn1Pp0V/5F9m2ZIkC
         rYllPiTrj8uPyLC6saX2TI2PSRMt+J2Dwp+t/fF7xrs6FZDOBodubkEAWljeGuc77fMr
         fnUjvQdVA8rNDn4OdyxiaJ4K1/7TeddwCb4eN8o9Vgv4qiGbzfP/yu3Ap24/rg3yJAzy
         2uKXT6WyFpGyGY4wA7V5HN3OB6Ql2fcLoFHd7rUkb6JXRiaWkp9C3XHCHcgT1CMFYleo
         keQy15G6IUgPspGce7IQc2c0qkkTxDDWy05LU4S3P0u4KxcBUO8cWj7DCq+tXb2eGkwD
         ec/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011273; x=1702616073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NPSVNV86/gWAz2b/XLZN3N1S3hmdyNSP82JFLWw5pI=;
        b=TEYj1MAxI33gnfV+5uRtXpvMLoCOIOiAoQEMG4g99X/szH14LPz0oLhB5A73Xtzq0X
         hfa0Z6MZvheSjWNUf+1D8Z+2syTof5/5SgCbnO5fjBytbxMD3UjpCeBeh+dwQqQT+QLv
         SrF7ky5XEIJOa9xGd+h7iLTd0njO1HEkN70lp6ERLOtID0t4giCfWKCaeSty1HgCwjdO
         Ys95TCjr/dkKInC2g8KO5oIO9zpTphFwVJDHPto6Ur/3IZ/XxK8VT3d5ZGJGkIp6rZui
         NjUAieLxltSNAr5hbIuXUeXXtbQnF1vDIlTlliW40vU4gqPGeTXoiSiRG1Yvo/uc3oPx
         KyFg==
X-Gm-Message-State: AOJu0YxCM5+rhHog4YaR8Rnyz67MysfgCE83deIvJY6r0ofG5NXRByzy
        6Pyku3V9lwDSNuBGmvMutgKQLb3d+6DK7Vguilo=
X-Google-Smtp-Source: AGHT+IFLB57OGDBP8fo1a89v+gmIGr/S4E0K1KWoKUVGdn1jiPJKq+fR/olscdWIuA9wyvOkHThrqyxe6UOTFzGvTh4=
X-Received: by 2002:a17:906:e0d6:b0:a1c:aa9e:17e4 with SMTP id
 gl22-20020a170906e0d600b00a1caa9e17e4mr1931099ejb.49.1702011272323; Thu, 07
 Dec 2023 20:54:32 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 Dec 2023 14:54:20 +1000
Message-ID: <CAPM=9tw7vc_BOsPH0xAwFvx_ZCQyZ24ofp3pUt1MQe9QA_U5Mg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular weekly fixes, mostly amdgpu and i915 as usual. A couple of
nouveau, panfrost, one core and one bridge Kconfig.

Seems about normal for rc5,

Regards,
Dave.

drm-fixes-2023-12-08:
drm fixes for v6.7-rc5

atomic-helpers:
- invoke end_fb_access while owning plane state

i915:
- fix a missing dep for a previous fix
- Relax BXT/GLK DSI transcoder hblank limits
- Fix DP MST .mode_valid_ctx() return values
- Reject DP MST modes that require bigjoiner (as it's not yet
supported on DP MST)
- Fix _intel_dsb_commit() variable type to allow negative values

nouveau:
- document some bits of gsp rm
- flush vmm more on tu102 to avoid hangs

panfrost:
- fix imported dma-buf objects residency
- fix device freq update

bridge:
- tc358768 - fix Kconfig

amdgpu:
- Disable MCBP on gfx9
- DC vbios fix
- eDP fix
- dml2 UBSAN fix
- SMU 14 fix
- RAS fixes
- dml KASAN/KCSAN fix
- PSP 13 fix
- Clockgating fixes
- Suspend fix

exynos:
- fix pointer dereference
- fix wrong error check
The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a=
:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-12-08

for you to fetch changes up to b7b5a56acec819bb8dcd03c687e97a091b29d28f:

  Merge tag 'exynos-drm-next-for-v6.7-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes (2023-12-08 13:55:32 +1000)

----------------------------------------------------------------
drm fixes for v6.7-rc5

atomic-helpers:
- invoke end_fb_access while owning plane state

i915:
- fix a missing dep for a previous fix
- Relax BXT/GLK DSI transcoder hblank limits
- Fix DP MST .mode_valid_ctx() return values
- Reject DP MST modes that require bigjoiner (as it's not yet
supported on DP MST)
- Fix _intel_dsb_commit() variable type to allow negative values

nouveau:
- document some bits of gsp rm
- flush vmm more on tu102 to avoid hangs

panfrost:
- fix imported dma-buf objects residency
- fix device freq update

bridge:
- tc358768 - fix Kconfig

amdgpu:
- Disable MCBP on gfx9
- DC vbios fix
- eDP fix
- dml2 UBSAN fix
- SMU 14 fix
- RAS fixes
- dml KASAN/KCSAN fix
- PSP 13 fix
- Clockgating fixes
- Suspend fix

exynos:
- fix pointer dereference
- fix wrong error check

----------------------------------------------------------------
Adri=C3=A1n Larumbe (2):
      drm/panfrost: Consider dma-buf imported objects as resident
      drm/panfrost: Fix incorrect updating of current device frequency

Alex Deucher (2):
      drm/amd/display: Increase frame warning limit with KASAN or KCSAN in =
dml
      drm/amdgpu: fix buffer funcs setting order on suspend

Alvin Lee (1):
      drm/amd/display: Use channel_width =3D 2 for vram table 3.0

Arnd Bergmann (1):
      drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS

Dave Airlie (6):
      nouveau/tu102: flush all pdbs on vmm flush
      Merge tag 'drm-intel-fixes-2023-12-01-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-intel-fixes-2023-12-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2023-12-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-6.7-2023-12-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'exynos-drm-next-for-v6.7-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes

Hawking Zhang (1):
      drm/amdgpu: Update fw version for boot time error query

Inki Dae (1):
      drm/exynos: fix a wrong error checking

Ivan Lipski (1):
      drm/amd/display: Add monitor patch for specific eDP

Jiadong Zhu (1):
      drm/amdgpu: disable MCBP by default

Li Ma (1):
      drm/amd/swsmu: update smu v14_0_0 driver if version and metrics table

Lijo Lazar (4):
      drm/amdgpu: Restrict extended wait to PSP v13.0.6
      drm/amdgpu: Add NULL checks for function pointers
      drm/amdgpu: Update HDP 4.4.2 clock gating flags
      drm/amdgpu: Avoid querying DRM MGCG status

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dml2

Thomas Zimmermann (1):
      drm/atomic-helpers: Invoke end_fb_access while owning plane state

Timur Tabi (1):
      nouveau/gsp: document some aspects of GSP-RM

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915: Check pipe active state in {planes,vrr}_{enabling,disabling=
}()
      drm/i915: Skip some timing checks on BXT/GLK DSI transcoders
      drm/i915/mst: Fix .mode_valid_ctx() return values
      drm/i915/mst: Reject modes that require the bigjoiner

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Yang Wang (2):
      drm/amd/pm: support new mca smu error code decoding
      drm/amdgpu: optimize the printing order of error data

heminhong (1):
      drm/i915: correct the input parameter on _intel_dsb_commit()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 17 +++++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c              |  5 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             | 12 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c                 | 15 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 ++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  8 ++-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  4 ++
 .../drm/amd/display/dc/dml2/display_mode_core.c    |  6 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     | 17 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      | 10 +++
 .../pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h | 77 +++++++++++-------=
--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  9 ++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   | 46 +++++++++++-
 drivers/gpu/drm/bridge/Kconfig                     |  1 +
 drivers/gpu/drm/drm_atomic_helper.c                | 78 +++++++++++++-----=
--
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |  8 +--
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  2 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |  7 ++
 drivers/gpu/drm/i915/display/intel_crt.c           |  5 ++
 drivers/gpu/drm/i915/display/intel_display.c       | 24 ++++++-
 drivers/gpu/drm/i915/display/intel_display.h       |  3 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  4 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 20 ++++--
 drivers/gpu/drm/i915/display/intel_dsb.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |  6 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  4 ++
 drivers/gpu/drm/i915/display/intel_lvds.c          |  5 ++
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  8 ++-
 drivers/gpu/drm/i915/display/intel_tv.c            |  8 ++-
 drivers/gpu/drm/i915/display/vlv_dsi.c             | 18 ++++-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  2 +-
 .../common/shared/msgq/inc/msgq/msgq_priv.h        | 51 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     | 82 ++++++++++++++++++=
++++
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |  2 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        | 17 ++++-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |  2 +-
 include/drm/drm_atomic_helper.h                    |  2 +
 39 files changed, 503 insertions(+), 98 deletions(-)
