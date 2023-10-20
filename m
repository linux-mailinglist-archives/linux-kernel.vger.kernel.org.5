Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CE7D0776
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjJTFBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:01:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B2D4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:01:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9be3b66f254so58176566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697778096; x=1698382896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWWQg2SqnfcJGluCbwJ/5a91X1rDHsY7zr/O6hdj2A8=;
        b=eVhq8jtBUFjn0KdtiGkMITcLOIHRqQMIya1W7ipDg4Iq/U/VZUOkv5Ku6YUH2edNrT
         kkLwrZGb9tCcG0xcUTtuw49qhDXy9YtjqEtC3gkTM/JD2vIZMlyPZgNzBSEAKmv2k8V1
         zvdtUrUzpJpp2mPOWfUu9EUktEo1DwfARGjtAMD4G+2HbNdUx0GHyDHLuLMQ3Y0IOPJH
         MMqvx7vK9p7Urm6y5pXl0jeBtKkHUV2ESdgKOrSJMP5/tOd+DJXesVq8GKoeTR4XKsdU
         J5BX7i0jylKswQk+sykdQxV7BdrQSqQRcydd95gDHyx5ze2fpr7ZAnETApxKuLMh7EHz
         V12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697778096; x=1698382896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWWQg2SqnfcJGluCbwJ/5a91X1rDHsY7zr/O6hdj2A8=;
        b=kd+vjYzXvsAn2M4bIz8J3kS8XR57OZE4t7ECXafGwS6JIR57j1WNEQiKFazJQTMwn3
         08XE1RB52tVEzcoVEL+qaUhB1AjuLftX+9yt8stEkusqmtGmhmN2AtM4sUtqmjnvmwOG
         RZ/F3Vhd9Wg1VZGjkOhisW1QGl0C2g4AE8Rkpd/YQrb5JdgM4Ua3ULEtuHIfaJNS9XV1
         TyAlwNVDhfVoFgF7+GsdKM6n0bcqSvMTRAEXG7TAu7JnggauXIsi2e/4fuT3yya25fbN
         GxEhYGN1UlON0xrCjMFNoJHpIXL5q4etQz3HGb5OoC6Tf68SNE7tyV2r2Uwu02/EL0hZ
         cJjA==
X-Gm-Message-State: AOJu0YxS7tEMDKfVEeqHj9gKejHGTcmBDUIJYtWz9Hpwo8juP2J+gkZK
        /nC4W3ofQeKV1iqbYaHSqzBR4l2WGwHvGNoAjS/rZ9BhdEY=
X-Google-Smtp-Source: AGHT+IF0Q4OhtJlzRIozVY+WrK9DtGCgqdBcwfPvIfJ4wxDEUSC4J3TVA+tHVmIDHf5aeDB5Sl0/3CP6zyTAQ/PQpxk=
X-Received: by 2002:a17:907:80e:b0:9bf:b8f7:1fd3 with SMTP id
 wv14-20020a170907080e00b009bfb8f71fd3mr452341ejb.45.1697778096207; Thu, 19
 Oct 2023 22:01:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Oct 2023 15:01:24 +1000
Message-ID: <CAPM=9twE+5tjNxbr1FkiXBqeEzv9k4LZMo4ETmchaNioNT6quQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Regular fixes for the week, amdgpu, i915, nouveau, with some other
scattered around, nothing major.

Dave.

drm-fixes-2023-10-20:
drm fixes for 6.6-rc7

amdgpu:
- Fix possible NULL pointer dereference
- Avoid possible BUG_ON in GPUVM updates
- Disable AMD_CTX_PRIORITY_UNSET

i915:
- Fix display issue that was blocking S0ix
- Retry gtt fault when out of fence registers

bridge:
- ti-sn65dsi86: Fix device lifetime

edid:
- Add quirk for BenQ GW2765

ivpu:
- Extend address range for MMU mmap

nouveau:
- DP-connector fixes
- Documentation fixes

panel:
- Move AUX B116XW03 into panel-simple

scheduler:
- Eliminate DRM_SCHED_PRIORITY_UNSET

ttm:
- Fix possible NULL-ptr deref in cleanup

mediatek:
- Correctly free sg_table in gem prime vmap
The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb=
:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-20

for you to fetch changes up to 8b35ce3f7a9699e7580527fe4510d77f2a35f02d:

  Merge tag 'mediatek-drm-fixes-20231017' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes (2023-10-20 14:24:35 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc7

amdgpu:
- Fix possible NULL pointer dereference
- Avoid possible BUG_ON in GPUVM updates
- Disable AMD_CTX_PRIORITY_UNSET

i915:
- Fix display issue that was blocking S0ix
- Retry gtt fault when out of fence registers

bridge:
- ti-sn65dsi86: Fix device lifetime

edid:
- Add quirk for BenQ GW2765

ivpu:
- Extend address range for MMU mmap

nouveau:
- DP-connector fixes
- Documentation fixes

panel:
- Move AUX B116XW03 into panel-simple

scheduler:
- Eliminate DRM_SCHED_PRIORITY_UNSET

ttm:
- Fix possible NULL-ptr deref in cleanup

mediatek:
- Correctly free sg_table in gem prime vmap

----------------------------------------------------------------
Chen-Yu Tsai (1):
      drm/mediatek: Correctly free sg_table in gem prime vmap

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.6-2023-10-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2023-10-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-10-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'mediatek-drm-fixes-20231017' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes

Douglas Anderson (1):
      drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple

Felix Kuehling (2):
      drm/amdgpu: Fix possible null pointer dereference
      drm/amdgpu: Reserve fences for VM update

Hamza Mahfooz (1):
      drm/edid: add 8 bpc quirk to the BenQ GW2765

Jacek Lawrynowicz (1):
      accel/ivpu: Don't enter d0i3 during FLR

Karol Herbst (1):
      drm/nouveau/disp: fix DP capable DSM connectors

Karolina Stolarek (1):
      drm/ttm: Reorder sys manager cleanup step

Khaled Almahallawy (1):
      drm/i915/cx0: Only clear/set the Pipe Reset bit of the PHY Lanes Owne=
d

Luben Tuikov (2):
      drm/amdgpu: Unset context priority is now invalid
      gpu/drm: Eliminate DRM_SCHED_PRIORITY_UNSET

Randy Dunlap (1):
      drm/nouveau: exec: fix ioctl kernel-doc warning

Stanislaw Gruszka (1):
      Revert "accel/ivpu: Use cached buffers for FW loading"

Stephen Boyd (1):
      drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with
auxiliary device

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Retry gtt fault when out of fence registers

Wludzik, Jozef (1):
      accel/ivpu: Extend address range for MMU mmap

 drivers/accel/ivpu/ivpu_drv.c                    | 11 ++++++--
 drivers/accel/ivpu/ivpu_drv.h                    |  1 +
 drivers/accel/ivpu/ivpu_fw.c                     |  9 +++---
 drivers/accel/ivpu/ivpu_gem.h                    |  5 ----
 drivers/accel/ivpu/ivpu_hw.h                     |  8 ++++++
 drivers/accel/ivpu/ivpu_hw_37xx.c                |  1 +
 drivers/accel/ivpu/ivpu_hw_40xx.c                |  1 +
 drivers/accel/ivpu/ivpu_mmu_context.c            |  9 ++----
 drivers/accel/ivpu/ivpu_pm.c                     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c          |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  3 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c            | 14 +++++-----
 drivers/gpu/drm/drm_edid.c                       |  3 ++
 drivers/gpu/drm/i915/display/intel_cx0_phy.c     |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c         |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c           |  6 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 14 +++++++++-
 drivers/gpu/drm/panel/panel-edp.c                | 29 --------------------
 drivers/gpu/drm/panel/panel-simple.c             | 35 ++++++++++++++++++++=
++++
 drivers/gpu/drm/ttm/ttm_device.c                 |  8 +++---
 include/drm/gpu_scheduler.h                      |  3 +-
 include/uapi/drm/nouveau_drm.h                   |  4 +--
 23 files changed, 109 insertions(+), 72 deletions(-)
