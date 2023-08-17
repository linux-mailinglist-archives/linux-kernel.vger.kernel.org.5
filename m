Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8177FFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355215AbjHQVgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjHQVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:36:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F078E4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:36:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99d937b83efso22944666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692308188; x=1692912988;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZqLiBJFAZXvCnssFXrBqXIi9XKkgEx0FSumuzhI7sRM=;
        b=IZZFD3ut8GPPTBSLpgK6tRMJ8JyzqN/RWH32e8erHeapgesRA7PnXoAFLVBAO9lxLl
         ztBi72RIaeBrRr12GiFsSWDXBwfkoL6O3ccs7HYtO1+nKl23txnn85gPMTwK7J2THXyG
         kPfkLsHqspK42+SSoOgn7YUJPDAR+H4a2qOM4Kf3I6HLwBwcnIgnyGch/0XUuzaTlu5x
         rbl3fXs8A2Cpid0TqQ/0c4r7RZdnz7eiazhsKzJTnbGfwIEfn8Jl3vKMG7Vj035d2BH0
         Yucl3OIbtR7fo8wsTfPxKX4EaN5BdyqkniUv3Snwj7x+RoOTv9Egrt/ohQj57oBmdHWU
         yR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308188; x=1692912988;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqLiBJFAZXvCnssFXrBqXIi9XKkgEx0FSumuzhI7sRM=;
        b=IFsoTbBnSzUmYT37REW8DTDmJZaPwdoxdw3CjUv5CU+QmABbcX0PDN+EC4fRdIiZgl
         XE01eSgzWvoR8RCFkbYaaWbBTqg1eeCrKAjFkWTVxrjbSHb8MmtYK4bvVTMpUWn/OUm4
         UzMY5w3SssRYoS7mJixtXK4WSri4UPjoeQtvOAH1GG/kar6oGwtu6kR3sMRtCimqj8P9
         U0bMmpyHN+07C9nmvlMN2CrvBx2Gi91gjXoLViSrPUA0h/zvFuZp7pzY1eV6hePvxiYY
         V8f6msPMhR2evhmH6zSmtXmp1+mW88R7VLxjzXKUKQi443mB1FdAvEXTvH3yWNOJnGsM
         bbNA==
X-Gm-Message-State: AOJu0Yx/uD3k9EhkfZNYKflJ2cUBxIHV1dxyU0fwKL9my7AB7PnbmvJv
        at+mplskxhs3chDxSD/N81qRaasl91i+lGFKsf4=
X-Google-Smtp-Source: AGHT+IFUpu3VGE6POt+emX5v8mfYaZGNc7oamfuYOcbGfZl6u6aa9puOc31oMicn0jIQAQVcAhN6KfXF/l3NZMin3XQ=
X-Received: by 2002:a17:906:5a6e:b0:99c:2535:372d with SMTP id
 my46-20020a1709065a6e00b0099c2535372dmr475132ejc.33.1692308187710; Thu, 17
 Aug 2023 14:36:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Aug 2023 07:36:16 +1000
Message-ID: <CAPM=9txN=kOYfE1a4VDrLWz+fvGuhXDuzDo7AK3-DuOEJoO41Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.5-rc7
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

Regular enough week, mostly the usual amdgpu and i915 fixes. Then
qaic, nouveau, qxl and a revert for an EDID patch that had some side
effects, along with a couple of panel fixes.

Dave.

drm-fixes-2023-08-18-1:
drm fixes for 6.5-rc7

edid:
- revert mode parsing fix that had side effects.

i915:
- Fix the flow for ignoring GuC SLPC efficient frequency selection
- Fix SDVO panel_type initialization
- Fix display probe for IVB Q and IVB D GT2 server

nouveau:
- fix use-after-free in connector code

qaic:
- integer overflow check fix
- fix slicing memory leak

panel:
- fix JDI LT070ME05000 probing
- fix AUO G121EAN01 timings

amdgpu:
- SMU 13.x fixes
- Fix mcbp parameter for gfx9
- SMU 11.x fixes
- Temporary fix for large numbers of XCP partitions
- S0ix fixes
- DCN 2.0 fix

qxl:
- fix use after free race in dumb object allocation
The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-18-1

for you to fetch changes up to c611589b4259ed63b9b77be6872b1ce07ec0ac16:

  drm/qxl: fix UAF on handle creation (2023-08-18 06:57:38 +1000)

----------------------------------------------------------------
drm fixes for 6.5-rc7

edid:
- revert mode parsing fix that had side effects.

i915:
- Fix the flow for ignoring GuC SLPC efficient frequency selection
- Fix SDVO panel_type initialization
- Fix display probe for IVB Q and IVB D GT2 server

nouveau:
- fix use-after-free in connector code

qaic:
- integer overflow check fix
- fix slicing memory leak

panel:
- fix JDI LT070ME05000 probing
- fix AUO G121EAN01 timings

amdgpu:
- SMU 13.x fixes
- Fix mcbp parameter for gfx9
- SMU 11.x fixes
- Temporary fix for large numbers of XCP partitions
- S0ix fixes
- DCN 2.0 fix

qxl:
- fix use after free race in dumb object allocation

----------------------------------------------------------------
Alex Deucher (1):
      Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""

Asad Kamal (1):
      drm/amd/pm: Update pci link width for smu v13.0.6

Dan Carpenter (1):
      accel/qaic: Clean up integer overflow checking in map_user_pages()

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2023-08-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2023-08-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-6.5-2023-08-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Heidelberg (1):
      drm/panel: JDI LT070ME05000 simplify with dev_err_probe()

James Zhu (1):
      drm/amdgpu: skip xcp drm device allocation when out of drm resource

Jani Nikula (3):
      drm/i915/sdvo: fix panel_type initialization
      drm/i915: fix display probe for IVB Q and IVB D GT2 server
      Revert "drm/edid: Fix csync detailed mode parsing"

Jiadong Zhu (1):
      drm/amdgpu: disable mcbp if parameter zero is set

Karol Herbst (1):
      drm/nouveau/disp: fix use-after-free in error handling of
nouveau_connector_create

Kenneth Feng (1):
      drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0

Lijo Lazar (1):
      drm/amd/pm: Fix temperature unit of SMU v13.0.6

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs

Mario Limonciello (1):
      drm/amd: flush any delayed gfxoff on suspend entry

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix slicing memory leak

Tim Huang (1):
      drm/amdgpu: skip fence GFX interrupts disable/enable for S0ix

Umio Yasuno (1):
      drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7

Vinay Belgaumkar (1):
      drm/i915/guc/slpc: Restore efficient freq earlier

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

 drivers/accel/qaic/qaic_control.c                  | 26 +++++++++-----
 drivers/accel/qaic/qaic_data.c                     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          | 41 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  9 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            | 13 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  9 ++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 14 ++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  4 +++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 19 +++++++---
 drivers/gpu/drm/drm_edid.c                         | 29 +++++----------
 .../gpu/drm/i915/display/intel_display_device.c    | 24 +++++++++++--
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        | 22 +++++++-----
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 11 +++---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     | 36 ++++++++-----------
 drivers/gpu/drm/panel/panel-simple.c               | 24 ++++++-------
 drivers/gpu/drm/qxl/qxl_drv.h                      |  2 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |  5 ++-
 drivers/gpu/drm/qxl/qxl_gem.c                      | 25 ++++++++-----
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |  6 ++--
 include/drm/drm_edid.h                             | 12 ++-----
 24 files changed, 216 insertions(+), 132 deletions(-)
