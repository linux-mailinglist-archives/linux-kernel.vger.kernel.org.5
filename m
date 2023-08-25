Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AB787E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjHYDII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbjHYDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:07:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A120199A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:07:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso6739441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692932849; x=1693537649;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxjULLs8tszYGy1gyvHkYEquD54rMJ6s2Os5kZTBKfE=;
        b=MSSI/lfbS/f/wZLZrOeP8cJ1qievmIL7UK0Kj1b/1fRfyJGDd3WGG81Z924bMA7nyn
         ngLhjfthzdZhoTDXDOn2fsyGFx2FrWXMPk4aodxJZW01MIhs3zTELIaQgsml1jWqQumf
         R58fq9IVVhDm16GeluJ5mqTQ1ZJ0ENYxN41DrNtakG6LH4A2oebR+Dukz9DIIxFNypwF
         ssHaTno1foMH4EvqvydB3b8/Jqfv6wuXd/64MXerBzsIAaVET5R/9jYjLE8+n0c1UmPG
         Jv6Qx3ngvs+KeUqac+EHnMjSssQN/rcIQAg3mur+idl96z6JDMwY0ySfsuk0Xa64paZ/
         AvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692932849; x=1693537649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxjULLs8tszYGy1gyvHkYEquD54rMJ6s2Os5kZTBKfE=;
        b=YR6gUhldlE1nkEg0DKV4pO+cIoTgv1q72Hv9HprABDMHqG8NVYfXSXxxy3mUVscvhI
         nbB7HSx5yGbTCVF4616CBlMt/aL/z8KGCzUL2OYIw5jW1pWk7biyRaVLgf7GpldXThFm
         /t/Hr4470xEpZ4WRjAPk6s16jAY4DAO0MVCrXQaZOgSO3e4zq903E5fTo8X5LFHEPwvv
         Qcb+DuFmi0WTffviDKNV+bAGtJSDeK9KFzYMNlu3PSCcWyqWNZlnWAJwD1VHMSq7lM/6
         6gYKnG29RbAyqq14/eySZpTV7K7qUKlT9NicFZBjvKSCxcTQQ5qBAV/Ep+juQa9di8a4
         2iIw==
X-Gm-Message-State: AOJu0Yw/fNovfsTf3SOIbIatnD1q++tnj+eCbnvT91PTVL4MadZu77BT
        Xxy3Yxw+sWe87lHS7uzDSNoV02JPtQI0cX1VOsrVSrKnqLJ+LA==
X-Google-Smtp-Source: AGHT+IEegpBDfaPBqqNmsZ9rrNZmdHsjADO/AD3Nqg0lhvvWgR//RsJD5iIbwuvUq1NB0QeIErmC86zdOQ/zDl4aOaI=
X-Received: by 2002:a2e:7010:0:b0:2bb:bf30:16f1 with SMTP id
 l16-20020a2e7010000000b002bbbf3016f1mr12416033ljc.18.1692932848419; Thu, 24
 Aug 2023 20:07:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Aug 2023 13:07:17 +1000
Message-ID: <CAPM=9tyKm+X8XMk75_vWoFk90vjA33Jyo-ic==PQM84_WK2_Wg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.5 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A bit bigger than I'd care for, but it's mostly a single vmwgfx fix
and a fix for an i915 hotplug probing. Otherwise misc i915, bridge,
panfrost and dma-buf fixes.

Dave.

drm-fixes-2023-08-25:
drm fixes for 6.5-rc8

core:
- add a HPD poll helper

i915:
- fix regression in i915 polling
- fix docs build warning
- fix DG2 idle power consumption

bridge:
- samsung-dsim: init fix

panfrost:
- fix speed binning issue

dma-buf:
- fix recursive lock in fence signal

vmwgfx:
- fix shader stage validation
- fix NULL ptr derefs in gem put
The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-25

for you to fetch changes up to 59fe2029b9e05cd490eaf972053dd86f96f77869:

  Merge tag 'drm-intel-fixes-2023-08-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-08-25
09:12:02 +1000)

----------------------------------------------------------------
drm fixes for 6.5-rc8

core:
- add a HPD poll helper

i915:
- fix regression in i915 polling
- fix docs build warning
- fix DG2 idle power consumption

bridge:
- samsung-dsim: init fix

panfrost:
- fix speed binning issue

dma-buf:
- fix recursive lock in fence signal

vmwgfx:
- fix shader stage validation
- fix NULL ptr derefs in gem put

----------------------------------------------------------------
Ankit Nautiyal (1):
      drm/display/dp: Fix the DP DSC Receiver cap size

Anshuman Gupta (1):
      drm/i915/dgfx: Enable d3cold at s2idle

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2023-08-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-08-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

David Michael (1):
      drm/panfrost: Skip speed binning on EOPNOTSUPP

Frieder Schrempf (1):
      drm: bridge: samsung-dsim: Fix init during host transfer

Imre Deak (2):
      drm: Add an HPD poll helper to reschedule the poll work
      drm/i915: Fix HPD polling, reenabling the output poll work as needed

Jani Nikula (1):
      drm/i915: fix Sphinx indentation warning

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Zack Rusin (2):
      drm/vmwgfx: Fix shader stage validation
      drm/vmwgfx: Fix possible invalid drm gem put calls

 drivers/dma-buf/sw_sync.c                    | 18 ++++----
 drivers/gpu/drm/bridge/samsung-dsim.c        | 27 +++++++----
 drivers/gpu/drm/drm_probe_helper.c           | 68 +++++++++++++++++++---------
 drivers/gpu/drm/i915/display/intel_hotplug.c |  4 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c       |  2 +
 drivers/gpu/drm/i915/i915_driver.c           | 33 ++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  6 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h           |  8 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          | 12 +++++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 35 ++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  6 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c      |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       |  3 +-
 include/drm/display/drm_dp.h                 |  2 +-
 include/drm/drm_probe_helper.h               |  1 +
 16 files changed, 136 insertions(+), 94 deletions(-)
