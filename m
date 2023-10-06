Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376DB7BB10E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjJFE6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:58:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7120B6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 21:58:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so2985838a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696568330; x=1697173130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QjM0/Xrho/1FsrlLPD/qSWsu6B38wg4wh+AhjT9LTBY=;
        b=N/mFDL4RTHJuINhrljpoUk9kHz/tA9KG/oA/1J9lxJgbluUnH4pzYMoubvOpb45boL
         YHvNH01DJ/HP9HT2fdiJSaYA9VFQsVa7RAlqy9Ce0/T3j8JAy2s3RJ+ZHMETEhV1ER5q
         5UrT8IdSkVL97IIE6tMgu6IWZ6lWQ1cQdo44r3cmXyKunK6/8UO/CzvcOsio7CnM80i2
         ss6qzkisJtfXxWTr4riBAwKBI5K1TT/pB4DKXkzCu2lLudb04Mv71XK+xRZ3EMk5I3gq
         0JRDYLgLwBOLQJ03Typ+KbsART9oxP1u3/FvRYqTPYIp6H5K8tg/btQNh5N9mR7mrdtL
         R/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696568330; x=1697173130;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjM0/Xrho/1FsrlLPD/qSWsu6B38wg4wh+AhjT9LTBY=;
        b=cCEvTeHt/HShdorLH+KED12JYrLK022cxDFydKmczKwsSm6D5mTQqeENzqMz522BDP
         e9S4BJeS6iBojmH7ycChKh/biDA8W69N+lISFv7Z5dT8zSfFP5aw0OdAdcqrhcZPOgNn
         Ghoe8EvDjo0glLp8u30U9nYh0wDYEvVyhmKHJRjU1tlpqqDc8EhEm7jj8L3Tj0U+2++2
         z8CLdgYP/F+WCn0ii008/sbRO4jt/o2UFq13qq2F/dj3qXRts4WOFfdD0uPLcIk0GyeI
         gkt3TGaaPKYeXX78qNQ6jj0/ohCZaVCWfCb2jxyhAjEH94cWOx4N/UEhEImpTVmYso3p
         WZUQ==
X-Gm-Message-State: AOJu0YzX3pPFQd7uiJao+jXcI8G1WRiHDuZsC4+9sIKddaawm088ixb9
        sJHOfFE7a6V0T08ljOf0RMA2r3T4GzvGd9yPUWU=
X-Google-Smtp-Source: AGHT+IEUaO5nhV0VxSuIsCXm8e8ey4jBrnKDPa3Z535adOENEt98qF3prSVDgVn1VMatECG+TbFP7rPdTNg2N50B2jc=
X-Received: by 2002:a17:906:310b:b0:9b5:f25d:9261 with SMTP id
 11-20020a170906310b00b009b5f25d9261mr6501872ejx.22.1696568329877; Thu, 05 Oct
 2023 21:58:49 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Oct 2023 14:58:38 +1000
Message-ID: <CAPM=9txQG3XyUMBvFf5pj8ng0sKekGMw5A7nhU_eMN5ubkVGcA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular weekly pull, all seems pretty normal, i915 and amdgpu mostly.

There is one small new uAPI addition for nouveau but getting it in now
avoids a bunch of userspace dances, and it's for a userspace that
hasn't yet released, so should have no side effects.

Dave.

drm-fixes-2023-10-06:
drm fixes for 6.6-rc5

i915:
- Fix for OpenGL CTS regression on Compute Shaders
- Fix for default engines initialization
- Fix TLB invalidation for Multi-GT devices

amdgpu:
- Add missing unique_id for GC 11.0.3
- Fix memory leak in FRU error path
- Fix PCIe link reporting on some SMU 11 parts
- Fix ACPI _PR3 detection
- Fix DISPCLK WDIVIDER handling in OTG code

tests:
- Fix kunit release

panel:
- panel-orientation: Add quirk for One Mix 25

nouveau:
- Report IB limit via getparams
- Replace some magic numbers with constants
- small clean up
The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-06

for you to fetch changes up to 67f35a41d3748b7bab8787d20b50cf33fafa2ae0:

  Merge tag 'drm-misc-fixes-2023-10-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-10-06
12:48:06 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc5

i915:
- Fix for OpenGL CTS regression on Compute Shaders
- Fix for default engines initialization
- Fix TLB invalidation for Multi-GT devices

amdgpu:
- Add missing unique_id for GC 11.0.3
- Fix memory leak in FRU error path
- Fix PCIe link reporting on some SMU 11 parts
- Fix ACPI _PR3 detection
- Fix DISPCLK WDIVIDER handling in OTG code

tests:
- Fix kunit release

panel:
- panel-orientation: Add quirk for One Mix 25

nouveau:
- Report IB limit via getparams
- Replace some magic numbers with constants
- small clean up

----------------------------------------------------------------
Arthur Grillo (1):
      drm/tests: Fix kunit_release_action ctx argument

Chris Wilson (1):
      drm/i915: Invalidate the TLBs on each GT

Danilo Krummrich (3):
      drm/nouveau: chan: use struct nvif_mclass
      drm/nouveau: chan: use channel class definitions
      drm/nouveau: exec: report max pushs through getparam

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2023-10-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.6-2023-10-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2023-10-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Kai Uwe Broulik (1):
      drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kenneth Feng (1):
      drm/amd/pm: add unique_id for gc 11.0.3

Luben Tuikov (1):
      drm/amdgpu: Fix a memory leak

Mario Limonciello (2):
      drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()
      drm/amd: Fix detection of _PR3 on the PCIe root port

Mathias Krause (1):
      drm/i915: Register engines early to avoid type confusion

Nirmoy Das (1):
      drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Samson Tam (1):
      drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to
master OTG pipes only

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |  1 +
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |  4 +--
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |  4 +--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 41 ++++++++++++----------
 drivers/gpu/drm/drm_panel_orientation_quirks.c     | 16 +++++++++
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |  2 +-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           | 11 +++++-
 drivers/gpu/drm/i915/i915_gem.c                    |  9 +++--
 drivers/gpu/drm/nouveau/nouveau_abi16.c            | 21 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_chan.c             | 15 ++++----
 drivers/gpu/drm/nouveau/nouveau_dma.h              |  3 ++
 drivers/gpu/drm/nouveau/nouveau_exec.c             |  7 ++--
 drivers/gpu/drm/nouveau/nouveau_exec.h             | 10 ++++++
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |  2 +-
 include/uapi/drm/nouveau_drm.h                     | 10 ++++++
 17 files changed, 120 insertions(+), 39 deletions(-)
