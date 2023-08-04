Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C176F96C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHDFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjHDFIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229724237
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:08:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1f6f3884so229205966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691125688; x=1691730488;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nqqRfBNPBQ+VMaK2HsDYoXmhmlAtvK4SXNfFFGzlpo=;
        b=lACS6lI/ekoOHa/nyz59RAxxBRYorYg619oLE4WoJ+0tHRIgbsotkGfTrETXBdJ90K
         YLnSGJgpcAwEc9JknkHlswmASGDd1UEwpJeGg9Fvl49cbVJuiTX16G5Isdg4fVPg4oPl
         veMGoNBjt6umC24dlFxaL/I/2vljGKTAUH5hxF71qLZ5N7oal9OKMFBa+avD2IpFFS3p
         5M/xEYCP99dE/MiOLV5yDNC2gDsytIsIrTx3I0owIRf5NxEFW1W0UMmm4Tn1wWnPB/2A
         V2EuGzRFrcc6mAAjv4HsB296hjBHh9kbyCc5fH7s3xHuzU9eljjl780gbVpI6KPYgsVu
         4xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125688; x=1691730488;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nqqRfBNPBQ+VMaK2HsDYoXmhmlAtvK4SXNfFFGzlpo=;
        b=b+NzwS8+cFDiep0p/TiMZK1XUrenyeopb0xmNzk8gfeN860JTOTYrna7HDCaO6DXWr
         Q2GsRKFB5ytEGSbB1OZfns4t24AmGMJvarT1jCCeXMm96BpWa41dxbb5TLo/bLrKPTk1
         T9NJ8cOFRGVxkQOIkbdwrsF0xXUWu3ncI+5oFmI9Z8nS5jB69c86aaapF/PPeb/+9oT1
         eZpi72pMDqVfQyeGHg2weRa6XPLco+Ob093p+N6YBW9HAy3+IIGa5hKvDoWwMWBAfQxn
         q/90HadPdLuUU4bJywSrE04JJO1JV3X4qWxWwlYe50qnzdRL0BHY1Dxysq9/CKQXuPAj
         CYmw==
X-Gm-Message-State: AOJu0Yx0PkM8SMMfVgO8Q06Iugxvt6Gh6Gjsn3YhTkJvBjGEL6SB2TL5
        KSKCH8aXrhdz2Sp1MIp+uqNSzHaWvfPcaqogwgs=
X-Google-Smtp-Source: AGHT+IEEFONMLQ+vBml2My8FR537suOeUVDgX4piJXXblwaS9SHtCdQfAVRo6JcqNmAlLjUPfTOHkrPlZKOGl2+aFPU=
X-Received: by 2002:a17:907:78c5:b0:99b:ef8a:d64a with SMTP id
 kv5-20020a17090778c500b0099bef8ad64amr612269ejc.0.1691125688392; Thu, 03 Aug
 2023 22:08:08 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 4 Aug 2023 15:07:56 +1000
Message-ID: <CAPM=9ty0b5R=rfu21PD=V1dh91XMit2wzAuAcrJA0E8h2EuUng@mail.gmail.com>
Subject: [git pull] drm fixes for 6.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Small set of fixes this week, i915 and a few misc ones. I didn't see
an amd pull so maybe next week it'll have a few more on that driver.

Dave.

drm-fixes-2023-08-04:
drm fixes for 6.5-rc5

ttm:
- NULL ptr deref fix

panel:
- add missing MODULE_DEVICE_TABLE

imx/ipuv3:
- timing fix

i915:
- Fix bug in getting msg length in AUX CH registers handler
- Gen12 AUX invalidation fixes
- Fix premature release of request's reusable memory
The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-04

for you to fetch changes up to 1958b0f95a35e4443573c4c3ec2efd89d2d00d82:

  Merge tag 'drm-intel-fixes-2023-08-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-08-04
09:38:38 +1000)

----------------------------------------------------------------
drm fixes for 6.5-rc5

ttm:
- NULL ptr deref fix

panel:
- add missing MODULE_DEVICE_TABLE

imx/ipuv3:
- timing fix

i915:
- Fix bug in getting msg length in AUX CH registers handler
- Gen12 AUX invalidation fixes
- Fix premature release of request's reusable memory

----------------------------------------------------------------
Alexander Stein (1):
      drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning

Andi Shyti (5):
      drm/i915/gt: Cleanup aux invalidation registers
      drm/i915: Add the gen12_needs_ccs_aux_inv helper
      drm/i915/gt: Rename flags with bit_group_X according to the datasheet
      drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the CS
      drm/i915/gt: Support aux invalidation on all engines

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2023-08-03' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-08-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Guchun Chen (1):
      drm/ttm: check null pointer before accessing when swapping

Janusz Krzysztofik (1):
      drm/i915: Fix premature release of request's reusable memory

Jonathan Cavitt (2):
      drm/i915/gt: Ensure memory quiesced before invalidation
      drm/i915/gt: Poll aux invalidation register bit on invalidation

Nikita Travkin (1):
      drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE

Tvrtko Ursulin (1):
      Merge tag 'gvt-fixes-2023-08-02' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Yan Zhao (1):
      drm/i915/gvt: Fix bug in getting msg length in AUX CH registers handler

 drivers/gpu/drm/i915/gt/gen8_engine_cs.c      | 140 +++++++++++++++++---------
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h      |  21 ++--
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h  |   2 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h       |  16 +--
 drivers/gpu/drm/i915/gt/intel_lrc.c           |  17 +---
 drivers/gpu/drm/i915/gvt/edid.c               |   2 +-
 drivers/gpu/drm/i915/i915_active.c            |  99 ++++++++++++------
 drivers/gpu/drm/i915/i915_request.c           |  11 ++
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c        |   2 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c |   1 +
 drivers/gpu/drm/ttm/ttm_bo.c                  |   3 +-
 11 files changed, 203 insertions(+), 111 deletions(-)
