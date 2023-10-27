Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6A7D8E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjJ0GQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjJ0GQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:16:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A51A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:15:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso268134966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698387357; x=1698992157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGl8/RMBFfp5VYwmvr/754qt1ZaVMlj7AsP+0mYfPo4=;
        b=GhwYZFy7MmrbySai/WjaAe4hzT/xipaJHBV31I+OLgUaB3es1RhZRx47bB2DWLrIDI
         zWlkxbtnBc3VB3blL1hyP9/9J+YUOuZ+VfURtzBu4eofnVE7MZW4VOIkQkRxmEbbV6UM
         U6XzRGWE83tnWZ8m+IoPY1+0Hpw4eNkeKHlC9gpj0Qu+d/b+dzbQpRifWgEYKYE0/YfG
         jg5kiBcU3U5i9BwnnRuc2MmG5Ra1DOpIj201kXAa/pEmQsogdAfNhHBRspbJTc5QCPg6
         yQJD6nc0zIMxDFZuf2j6nhk7aHhQFtV3Hjb3yr+EucDqRTm//nuBtOFxhXXXoUpX+pRW
         BBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698387357; x=1698992157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGl8/RMBFfp5VYwmvr/754qt1ZaVMlj7AsP+0mYfPo4=;
        b=n5o4z6GPJDAmPzyr7fGv+DQvN3AuWvyVJgejFIS/Vf2446M1gC0Hyy9tZ9OsQkGh0u
         t/77C6+srI8Pzc0rTfwo6r1IpcPp9JD7UfxOx+oLWwCZzZFjFT3EsjYU4XW5HnDPlFYU
         YiCTZVDvQ60TQbRiy0N/D6l9SbkZbtsPQ+C/KU1kSVwEHY3KqMs5RVwZYuqQldz2wge+
         TSuLCw/OVS4MH9SmUq86xtyYVli5AtyQ5hJqUWbjyYjEoG+THz0AzsR2kmFiqgYFhiwA
         A7n0DTmctMqjKYykz/leCTUXc6cYCPXRU4VMZW0afCut8e29xBKckLpbkPNDBdFVTAhz
         qfWg==
X-Gm-Message-State: AOJu0YybZGsLmtNHEOxplj814rTSGv167twM0eNzW7RoLcKZI5fFq1t7
        Z2f0FicAvwOuueBSr4ysM7JfPBlqbYXI8ShaiZVeLvqpRZA=
X-Google-Smtp-Source: AGHT+IHW9VCdnEU/ZeQn6si2eRTfWELmb2oa/e4nb4MLFREVdolj4XT4+q93sWN7uAKHyr1cOU1HDtVKHLiUKiVX6Us=
X-Received: by 2002:a17:907:6eaa:b0:9be:d55a:81c5 with SMTP id
 sh42-20020a1709076eaa00b009bed55a81c5mr1864765ejc.60.1698387357405; Thu, 26
 Oct 2023 23:15:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Oct 2023 16:15:45 +1000
Message-ID: <CAPM=9tyx-mqoKY77QsHSD1kEnn1dbg9yERCNn76wVY1Jw0+z_w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the final set of fixes for 6.6, just misc bits mainly in
amdgpu and i915, nothing too noteworthy.

Dave.

drm-fixes-2023-10-27:
drm fixes for 6.6 final

amdgpu:
- ignore duplicated BOs in CS parser
- remove redundant call to amdgpu_ctx_priority_is_valid()
- Extend VI APSM quirks to more platforms

amdkfd:
- reserve fence slot while locking BO

dp_mst:
- Fix NULL deref in get_mst_branch_device_by_guid_helper()

logicvc:
- Kconfig: Select REGMAP and REGMAP_MMIO

ivpu:
- Fix missing VPUIP interrupts

i915:
- Determine context valid in OA reports
- Hold GT forcewake during steering operations
- Check if PMU is closed before stopping event
The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1=
:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-27

for you to fetch changes up to 44117828ed5c129a8146585e81262c0025daa50f:

  Merge tag 'amd-drm-fixes-6.6-2023-10-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-10-27
12:17:26 +1000)

----------------------------------------------------------------
drm fixes for 6.6 final

amdgpu:
- ignore duplicated BOs in CS parser
- remove redundant call to amdgpu_ctx_priority_is_valid()
- Extend VI APSM quirks to more platforms

amdkfd:
- reserve fence slot while locking BO

dp_mst:
- Fix NULL deref in get_mst_branch_device_by_guid_helper()

logicvc:
- Kconfig: Select REGMAP and REGMAP_MMIO

ivpu:
- Fix missing VPUIP interrupts

i915:
- Determine context valid in OA reports
- Hold GT forcewake during steering operations
- Check if PMU is closed before stopping event

----------------------------------------------------------------
Christian K=C3=B6nig (2):
      drm/amdgpu: ignore duplicate BOs again
      drm/amdkfd: reserve a fence slot while locking the BO

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2023-10-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-10-26' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.6-2023-10-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Karol Wachowski (1):
      accel/ivpu/37xx: Fix missing VPUIP interrupts

Luben Tuikov (1):
      drm/amdgpu: Remove redundant call to priority_is_valid()

Lukasz Majczak (1):
      drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Mario Limonciello (1):
      drm/amd: Disable ASPM for VI w/ all Intel systems

Matt Roper (1):
      drm/i915/mcr: Hold GT forcewake during steering operations

Sui Jingfeng (1):
      drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Determine context valid in OA reports
      drm/i915/pmu: Check if pmu is closed before stopping event

 drivers/accel/ivpu/ivpu_hw_37xx.c                | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c          | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/vi.c                  |  2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c    |  6 +++---
 drivers/gpu/drm/i915/gt/intel_gt_mcr.c           | 24 ++++++++++++++++++++=
++--
 drivers/gpu/drm/i915/i915_perf.c                 |  4 ++--
 drivers/gpu/drm/i915/i915_pmu.c                  |  9 +++++++++
 drivers/gpu/drm/logicvc/Kconfig                  |  2 ++
 10 files changed, 55 insertions(+), 23 deletions(-)
