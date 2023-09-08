Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC87980A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjIHCpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjIHCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:45:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B81BD9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:45:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a6190af24aso195362866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694141125; x=1694745925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AE7MLlyKzKnW8KbkXy/hN56gB9THGhL3oPrJXS0wp+Y=;
        b=BCXqroboLalAP1gn8IgbaNtlVfzVhhiG5Wbyrx+LVdQ35VYxRsD+xkjdwomvfaGdPI
         rLVT9KmVKFDgyASuRcuSoLCONYJfuQTf7+Z6YaGkX277znoDifycquo0TR/DheDshcGN
         7EWbMNxF7YqV05IBjvgI2P3H7Evg5b+iLEcMVs+uNH3Q8GWwSOqCf+tkAAkWOWFmZU5k
         TBmXRq023IbREBqhP4K+tHAbAJOEkiG7UJirgR95umXAtYT5UoKOh49Bs0tPrxaSkYOd
         F4esEtqyxUjwY/LRl7Xr9koS/INAxifGX7Xr7Ss/eY8OzfgppJi3wk8u5jvb0PWgCp2P
         miTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141125; x=1694745925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AE7MLlyKzKnW8KbkXy/hN56gB9THGhL3oPrJXS0wp+Y=;
        b=xRF+O7yuhpWFT9qM/+o0Lq7PZJRAkBs1YcUKYvlb9nQC9bA0PRCOhouq5PJTsiMmL8
         9HobfNFrqbOYVshr7keh/LgxQML1vttc8ucFDqP20EWDa5mZT7hrVJxp+A/yZX5+K3BP
         a5WOcL1yU5HuHrsf68r6tikKWbfTBIqVrn3t4CyrwRdO0Ocm2e5dge6TeVS48iSkZymp
         R4Bmzwz/3cZHJ8dfenEQ4tU4tiNcAVsb+y5mbRUa3+KfY3wYG1HAMdIUJ6sZtvlhOrw0
         ayw4+8A/yE3TQvfou4oUpa21TrETH/08K1TZHO/VSSgX3DzkB6BfZt3kh7Ta1fqbjFIP
         Velg==
X-Gm-Message-State: AOJu0YzADRcbCF+ZlA0TtBmoDOzW++U5akl6RQRb3PcT61jsIwHoHp4V
        iVk2LklrxExpLQvV1WuAs7APKSoBndHvQrWEX8g=
X-Google-Smtp-Source: AGHT+IHkaoqO2XBgmjUmmjkYRbPvStLOoioqR244T3VEXGe+YNSPrE+RQjnNrDNkHGFiCn9N+bgLv236T3DN3mtgIl8=
X-Received: by 2002:a17:906:d84:b0:9a9:e659:a8aa with SMTP id
 m4-20020a1709060d8400b009a9e659a8aamr680981eji.57.1694141125036; Thu, 07 Sep
 2023 19:45:25 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 Sep 2023 12:45:13 +1000
Message-ID: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc1
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

Regular rounds of rc1 fixes, a large bunch for amdgpu since it's 3
weeks in one go, one i915, one nouveau and one ivpu. I think there
might be a few more fixes in misc that I haven't pulled in yet, but we
should get them all for rc2.

Just a poke about the outstanding drm CI support pull request since I
haven't see any movement on that in the week, hopefully it's not as
difficult a problem as bcachefs :-)

Thanks,
Dave.

drm-next-2023-09-08:
drm fixes for 6.6-rc1

amdgpu:
- Display replay fixes
- Fixes for headless boards
- Fix documentation breakage
- RAS fixes
- Handle newer IP discovery tables
- SMU 13.0.6 fixes
- SR-IOV fixes
- Display vstartup fixes
- NBIO 7.9 fixes
- Display scaling mode fixes
- Debugfs power reporting fix
- GC 9.4.3 fixes
- Dirty framebuffer fixes for fbcon
- eDP fixes
- DCN 3.1.5 fix
- Display ODM fixes
- GPU core dump fix
- Re-enable zops property now that IGT test is fixed
- Fix possible UAF in CS code
- Cursor degamma fix

amdkfd:
- HMM fixes
- Interrupt masking fix
- GFX11 MQD fixes

i915:
- Mark requests for GuC virtual engines to avoid use-after-free

nouveau:
- Fix fence state in nouveau_fence_emit()

ivpu:
- replace strncpy
The following changes since commit 3698a75f5a98d0a6599e2878ab25d30a82dd836a=
:

  Merge tag 'drm-intel-next-fixes-2023-08-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-08-25
12:55:55 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-09-08

for you to fetch changes up to 43ffcd6fa1635f479ad73145dfbba59edc2b3b28:

  Merge tag 'amd-drm-fixes-6.6-2023-09-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2023-09-08
10:44:07 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc1

amdgpu:
- Display replay fixes
- Fixes for headless boards
- Fix documentation breakage
- RAS fixes
- Handle newer IP discovery tables
- SMU 13.0.6 fixes
- SR-IOV fixes
- Display vstartup fixes
- NBIO 7.9 fixes
- Display scaling mode fixes
- Debugfs power reporting fix
- GC 9.4.3 fixes
- Dirty framebuffer fixes for fbcon
- eDP fixes
- DCN 3.1.5 fix
- Display ODM fixes
- GPU core dump fix
- Re-enable zops property now that IGT test is fixed
- Fix possible UAF in CS code
- Cursor degamma fix

amdkfd:
- HMM fixes
- Interrupt masking fix
- GFX11 MQD fixes

i915:
- Mark requests for GuC virtual engines to avoid use-after-free

nouveau:
- Fix fence state in nouveau_fence_emit()

ivpu:
- replace strncpy

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/pm: fix debugfs pm_info output

Alex Sierra (2):
      drm/amdkfd: retry after EBUSY is returned from hmm_ranges_get_pages
      drm/amdkfd: use mask to get v9 interrupt sq data bits correctly

Andrzej Hajda (1):
      drm/i915: mark requests for GuC virtual engines to avoid use-after-fr=
ee

Andr=C3=A9 Almeida (1):
      drm/amdgpu: Allocate coredump memory in a nonblocking way

Asad Kamal (3):
      drm/amd/pm: Update SMUv13.0.6 PMFW headers
      drm/amd/pm: Add critical temp for GC v9.4.3
      drm/amd/pm: Fix critical temp unit of SMU v13.0.6

Bhawanpreet Lakha (1):
      drm/amd/display: Enable Replay for static screen use cases

Bokun Zhang (1):
      drm/amdgpu/pm: Add notification for no DC support

Candice Li (1):
      drm/amdgpu: Only support RAS EEPROM on dGPU platform

Christian K=C3=B6nig (1):
      drm/amdgpu: fix amdgpu_cs_p1_user_fence

ChunTao Tso (1):
      drm/amd/display: set minimum of VBlank_nom

Danilo Krummrich (1):
      drm/nouveau: fence: fix undefined fence state after emit

Dave Airlie (3):
      Merge tag 'drm-misc-next-fixes-2023-09-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2023-08-31' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-fixes-6.6-2023-09-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

Fudong Wang (1):
      drm/amd/display: Add smu write msg id fail retry process

Gabe Teeger (1):
      drm/amd/display: Remove wait while locked

Hamza Mahfooz (7):
      drm/amd/display: fix mode scaling (RMX_.*)
      drm/amdgpu: register a dirty framebuffer callback for fbcon
      drm/amd/display: register edp_backlight_control() for DCN301
      Revert "Revert "drm/amd/display: Implement zpos property""
      Revert "drm/amd/display: Remove v_startup workaround for dcn3+"
      drm/amd/display: limit the v_startup workaround to ASICs older than D=
CN3.1
      drm/amd/display: prevent potential division by zero errors

Hawking Zhang (4):
      drm/amdgpu: Fix the return for gpu mode1_reset
      drm/amdgpu: Add umc_info v4_0 structure
      drm/amdgpu: Support query ecc cap for aqua_vanjaram
      drm/amdgpu: Free ras cmd input buffer properly

Horace Chen (1):
      drm/amdkfd: use correct method to get clock under SRIOV

Jay Cornwall (1):
      drm/amdkfd: Add missing gfx11 MQD manager callbacks

Justin Stitt (1):
      accel/ivpu: refactor deprecated strncpy

Le Ma (2):
      drm/amdgpu: update mall info v2 from discovery
      drm/amdgpu: update gc_info v2_1 from discovery

Lijo Lazar (6):
      Documentation/gpu: Update amdgpu documentation
      drm/amdgpu: Unset baco dummy mode on nbio v7.9
      drm/amdgpu: Add bootloader status check
      drm/amdgpu: Add bootloader wait for PSP v13
      drm/amdgpu: Add SMU v13.0.6 default reset methods
      drm/amdgpu: Restrict bootloader wait to SMUv13.0.6

Mangesh Gadre (2):
      drm/amdgpu: Remove SRAM clock gater override by driver
      drm/amdgpu: Updated TCP/UTCL1 programming

Melissa Wen (1):
      drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

Ovidiu Bunea (1):
      drm/amd/display: Roll back unit correction

Rajneesh Bhardwaj (1):
      drm/amdgpu: Hide xcp partition sysfs under SRIOV

Reza Amini (1):
      drm/amd/display: Correct unit conversion for vstartup

Samir Dhume (1):
      drm/amdgpu/jpeg - skip change of power-gating state for sriov

SungHuai Wang (1):
      drm/amd/display: fix static screen detection setting

Tao Zhou (1):
      drm/amdgpu: use read-modify-write mode for gfx v9_4_3 SQ setting

Wenjing Liu (3):
      Partially revert "drm/amd/display: update add plane to context
logic with a new algorithm"
      drm/amd/display: update blank state on ODM changes
      drm/amd/display: always switch off ODM before committing more streams

YiPeng Chai (1):
      drm/amdgpu: Enable ras for mp0 v13_0_6 sriov

 Documentation/gpu/amdgpu/driver-misc.rst           |   8 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c                  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  18 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  18 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  30 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  15 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  26 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  15 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  26 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |  18 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |  40 ++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  16 +++
 drivers/gpu/drm/amd/display/dc/Makefile            |   1 +
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c |  20 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  68 ++++++++----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  47 ++------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  17 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h |   2 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  | 118 +++++++++++++++++=
+++-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  25 +----
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  21 +++-
 .../drm/amd/display/modules/freesync/freesync.c    |   9 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   2 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |  18 ++++
 drivers/gpu/drm/amd/include/discovery.h            |  38 ++++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  11 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   5 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   |   5 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    |   4 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  16 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  54 +++++++++-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   3 +
 drivers/gpu/drm/i915/i915_request.c                |   7 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |   9 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   8 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   6 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |   9 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c             |  11 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |  32 ++++--
 drivers/gpu/drm/nouveau/nouveau_fence.h            |   5 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   5 +-
 62 files changed, 684 insertions(+), 227 deletions(-)
