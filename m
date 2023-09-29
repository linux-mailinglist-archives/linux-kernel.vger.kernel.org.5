Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475D7B2A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 03:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjI2Bqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 21:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Bq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 21:46:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F019C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 18:46:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so1705738466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 18:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695951984; x=1696556784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjUlQwEjtZqxZu1kpUu5uRZmclkQBq6AV4M8yVChIbs=;
        b=H60aSXOwFDh0RNmPURJCzNp8DpflR/PvkQpE9sz+mnf2OzeBFA5G9KbgOZQsXFnarr
         LpTLObtCjbrP5mYz/4TYiXp95dEHzkJZnj+WZOhWWdZmsV/lRFF0eKquveJM7q849Phf
         +rcmPzKW8V6dunu4s4xt+M081XvecJyC6c12WCv2so65slYjAfpn/b82zXTL2D+mYVAx
         jvA8l90iI9dhLb12cfVNaM+z5de6QvU2j6ErnweVG80fvtWO5jH6j2eCcpHRbDGVqxut
         /kCiMUHWyChUBwBpgxeH0aVY749a7QAwOn3okXW1gwADcJ3Mw3fU9npj/pPdf+QUJmXi
         nvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695951984; x=1696556784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjUlQwEjtZqxZu1kpUu5uRZmclkQBq6AV4M8yVChIbs=;
        b=oo0H1DwQ8GngyajkY9Ii2VTkwMIy7jn1ngWV6soTY/fkKTCoHrhBMlO5eUjDiVoNPK
         wkHtwM460eVPHPBJ7UmWU8SIB0Y1V20sqgTRAjyZJUbSgQTYXqkA8mnCgkAh8fi0cVEA
         f7vSzcJpA9otBCX2XhCp+F8jlfH0cmWHjVyiIZSfVeDKUqQli9tBjNJhOELIrKgAqXOH
         haBQv7TphllTFb7D/noXK6Mxas5s94WcX7E2pk7UmrR92+oi3cfM8PNixKbAdGCWxAef
         q8bhXGbUR757XD2BBZoQgSLjbSivZ3iPhZw9pWmYwcGJUmKcEIsxr9Ac/qzrwIKQmuss
         MaWg==
X-Gm-Message-State: AOJu0YyxjFSEVX+htg9GXYJcme7jiSDnFEgQe3iVtNe6G0qsZS1ttOAd
        GkQs+uyQkcClbWtg1f3b0eO5nTqrVfb6N8sN45Y=
X-Google-Smtp-Source: AGHT+IG2KqTMcUpCdlErMwRz6hm4et4Spza854iJ+jKDKEAqLuSC7NzdrY9evQ7GP66ES+T5kBGHyeSkgIljsWjx/hk=
X-Received: by 2002:a17:906:3cb1:b0:9a5:852f:10bd with SMTP id
 b17-20020a1709063cb100b009a5852f10bdmr2468967ejh.62.1695951983947; Thu, 28
 Sep 2023 18:46:23 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Sep 2023 11:46:12 +1000
Message-ID: <CAPM=9twU2jO7zfje1XSmW55VnyKxWenszkLRFi-yLX7hQNG2+A@mail.gmail.com>
Subject: [git pull] drm fixes for 6.6-rc4
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

Hey Linus,

Regular pull, this feel suspiciously light so I expect next week might
be a bit heavier? lets see how we go. This is from a code point of
view ivpu and i915 fixes.

The only other patch is adding Danilo Krummrich to the nouveau
maintainers, he's agreed to take on more of the roll after Ben
retired.

Regards,
Dave.

drm-fixes-2023-09-29:
drm fixes for 6.6-rc4

MAINTAINERS:
- add Danilo for nouveau

ivpu:
- Add PCI ids for Arrow Lake
- Fix memory corruption during IPC
- Avoid dmesg flooding
- 40xx: Wait for clock resource
- 40xx: Fix interrupt usage
- 40xx: Support caching when loading firmware

i915:
- Fix a panic regression on gen8_ggtt_insert_entries
- Fix load issue due to reservation address in ggtt_reserve_guc_top
- Fix a possible deadlock with guc busyness worker
The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-09-29

for you to fetch changes up to 06365a04fd32af25f90d8ccb4fecdda1f0e1ab78:

  Merge tag 'drm-intel-fixes-2023-09-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-09-29
10:28:21 +1000)

----------------------------------------------------------------
drm fixes for 6.6-rc4

MAINTAINERS:
- add Danilo for nouveau

ivpu:
- Add PCI ids for Arrow Lake
- Fix memory corruption during IPC
- Avoid dmesg flooding
- 40xx: Wait for clock resource
- 40xx: Fix interrupt usage
- 40xx: Support caching when loading firmware

i915:
- Fix a panic regression on gen8_ggtt_insert_entries
- Fix load issue due to reservation address in ggtt_reserve_guc_top
- Fix a possible deadlock with guc busyness worker

----------------------------------------------------------------
Danilo Krummrich (1):
      MAINTAINERS: update nouveau maintainers

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2023-09-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-09-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jacek Lawrynowicz (1):
      accel/ivpu: Don't flood dmesg with VPU ready message

Javier Pello (1):
      drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top

Karol Wachowski (4):
      accel/ivpu/40xx: Ensure clock resource ownership Ack before Power-Up
      accel/ivpu/40xx: Disable frequency change interrupt
      accel/ivpu/40xx: Fix missing VPUIP interrupts
      accel/ivpu: Use cached buffers for FW loading

Matthew Wilcox (Oracle) (1):
      i915: Limit the length of an sg list to the requested length

Stanislaw Gruszka (2):
      accel/ivpu: Add Arrow Lake pci id
      accel/ivpu: Do not use wait event interruptible

Umesh Nerlige Ramappa (1):
      i915/guc: Get runtime pm in busyness worker only if already active

 MAINTAINERS                                       |  1 +
 drivers/accel/ivpu/ivpu_drv.c                     |  3 +-
 drivers/accel/ivpu/ivpu_drv.h                     |  2 ++
 drivers/accel/ivpu/ivpu_fw.c                      |  8 +++--
 drivers/accel/ivpu/ivpu_gem.h                     |  5 +++
 drivers/accel/ivpu/ivpu_hw_40xx.c                 | 28 ++++++++++++-----
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h             |  2 ++
 drivers/accel/ivpu/ivpu_ipc.c                     | 11 +++----
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c         | 11 ++++---
 drivers/gpu/drm/i915/gt/intel_ggtt.c              | 23 ++++++++++----
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 38 +++++++++++++++++++++--
 11 files changed, 100 insertions(+), 32 deletions(-)
