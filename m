Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A331D790437
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjIAXnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbjIAXnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F01739
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so1896071b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611745; x=1694216545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9XoCDC9hhqnTfSWxv39xNaYsVGjr9sqIdwDF3cygwY=;
        b=EJFbu+Co2SmIXC4xt4ddhfP62SSmhPMlIudfU5pVn/dB3BTGMpkCF86aKayMRh45n+
         RnfwXDmW/DkUBkT7smLfMB2BeYK1cR49YCybRwO4cKdgIN5ub3K0qeF5ZCuuY6ELz9zR
         +E9rLa1Wl5evrqncQBmsnzm9qxhgQoJRDkIpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611745; x=1694216545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9XoCDC9hhqnTfSWxv39xNaYsVGjr9sqIdwDF3cygwY=;
        b=SAu/T45jYvD6r0dieiRKekLeE14zKIjzpFdvCu800gxuFmbPU1J47sQQWUunEOHgYc
         dZ2kjN1Y5DHkCHB4Vc89pcNZ0vAte9g1sq0wh7goSGatsOkT8PbCF/m2ljrhaV8yly2F
         FzLYUZ+jsRhYR11LFZVSEZQbd5tTzA5VTfCq4M3m/qYIDv0Cm8W8U+OwdCAntMgBLk9s
         xsc42z1qAVTL+0scy35jVrPed5W+QsPOe1/cstHfMbYwToaujILExUPCkEIzDAQNUxuu
         EjoU7Un+Lir+8f+ZYbTJOBrQief0jQrSq1daHLfznjEnq28Mzc3R/7IvUNzWHL7OMtoY
         1D6w==
X-Gm-Message-State: AOJu0YynidHwXlKMST8IsX/25NaxLy+5rACXZv9YrgzLvjMpdG7UBiKH
        iwraNEgzySaRS+aHoA9DFYUfGA==
X-Google-Smtp-Source: AGHT+IF3gOcPwfPrD/s0fytOUG/vRSOI4D+jnCuIcvxglrqeHeLMaTT6rOOv/A4qBfa/r+8zKOWj4g==
X-Received: by 2002:a05:6a00:1916:b0:68b:fb93:5b4e with SMTP id y22-20020a056a00191600b0068bfb935b4emr4542619pfi.26.1693611745505;
        Fri, 01 Sep 2023 16:42:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Bokun.Zhang@amd.com, Hawking.Zhang@amd.com, James.Zhu@amd.com,
        Sascha Hauer <s.hauer@pengutronix.de>, Victor.Zhao@amd.com,
        Xinhui.Pan@amd.com, YiPeng.Chai@amd.com, abrodkin@synopsys.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        alim.akhtar@samsung.com, amd-gfx@lists.freedesktop.org,
        angelogioacchino.delregno@collabora.com,
        anitha.chrisanthus@intel.com, biju.das.jz@bp.renesas.com,
        bskeggs@redhat.com, christian.koenig@amd.com,
        chunkuang.hu@kernel.org, daniel@ffwll.ch, edmund.j.dea@intel.com,
        festevam@gmail.com, geert+renesas@glider.be, inki.dae@samsung.com,
        jonathanh@nvidia.com, kernel@pengutronix.de, kherbst@redhat.com,
        kieran.bingham+renesas@ideasonboard.com,
        krzysztof.kozlowski@linaro.org, kyungmin.park@samsung.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        laurentiu.palcu@oss.nxp.com, le.ma@amd.com, lijo.lazar@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux@armlinux.org.uk, liviu.dudau@arm.com, lyude@redhat.com,
        maarten.lankhorst@linux.intel.com, mario.limonciello@amd.com,
        matthias.bgg@gmail.com, mdaenzer@redhat.com, mperttunen@nvidia.com,
        nouveau@lists.freedesktop.org, orsonzhai@gmail.com,
        p.zabel@pengutronix.de, patrik.r.jakobsson@gmail.com,
        paul@crapouillou.net, rfoss@kernel.org, robh@kernel.org,
        sam@ravnborg.org, shawnguo@kernel.org, shiwu.zhang@amd.com,
        srinivasan.shanmugam@amd.com, steven.price@arm.com,
        sw0312.kim@samsung.com, thierry.reding@gmail.com,
        tzimmermann@suse.de, zhang.lyra@gmail.com
Subject: [RFT PATCH 00/15] drm: non-drm-misc drivers call drm_atomic_helper_shutdown() at the right times
Date:   Fri,  1 Sep 2023 16:41:11 -0700
Message-ID: <20230901234202.566951-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


NOTE: in order to avoid email sending limits on the cover letter, I've
split this patch series in two. Patches that target drm-misc and ones
that don't. The cover letter of the two is identical other than this note.

This patch series came about after a _long_ discussion between me and
Maxime Ripard in response to a different patch I sent out [1]. As part
of that discussion, we realized that it would be good if DRM drivers
consistently called drm_atomic_helper_shutdown() properly at shutdown
and driver remove time as it's documented that they should do. The
eventual goal of this would be to enable removing some hacky code from
panel drivers where they had to hook into shutdown themselves because
the DRM driver wasn't calling them.

It turns out that quite a lot of drivers seemed to be missing
drm_atomic_helper_shutdown() in one or both places that it was
supposed to be. This patch series attempts to fix all the drivers that
I was able to identify.

NOTE: fixing this wasn't exactly cookie cutter. Each driver has its
own unique way of setting itself up and tearing itself down. Some
drivers also use the component model, which adds extra fun. I've made
my best guess at solving this and I've run a bunch of compile tests
(specifically, allmodconfig for amd64, arm64, and powerpc). That being
said, these code changes are not totally trivial and I've done zero
real testing on them. Making these patches was also a little mind
numbing and I'm certain my eyes glazed over at several points when
writing them. What I'm trying to say is to please double-check that I
didn't do anything too silly, like cast your driver's drvdata to the
wrong type. Even better, test these patches!

I've organized this series like this:
1. One patch for all simple cases of just needing a call at shutdown
   time for drivers that go through drm-misc.
2. A separate patch for "drm/vc4", even though it goes through
   drm-misc, since I wanted to leave an extra note for that one.
3. Patches for drivers that just needed a call at shutdown time for
   drivers that _don't_ go through drm-misc.
4. Patches for the few drivers that had the call at shutdown time but
   lacked it at remove time.
5. One patch for all simple cases of needing a call at shutdown and
   remove (or unbind) time for drivers that go through drm-misc.
6. A separate patch for "drm/hisilicon/kirin", even though it goes
   through drm-misc, since I wanted to leave an extra note for that
   one.
7. Patches for drivers that needed a call at shutdown and remove (or
   unbind) time for drivers that _don't_ go through drm-misc.

I've labeled this patch series as RFT (request for testing) to help
call attention to the fact that I didn't personally test any of these
patches.

If you're a maintainer of one of these drivers and you think that the
patch for your driver looks fabulous, you've tested it, and you'd like
to land it right away then please do. For non-drm-misc drivers there
are no dependencies here. Some of the drm-misc drivers depend on the
first patch, AKA ("drm/atomic-helper: drm_atomic_helper_shutdown(NULL)
should be a noop"). I've tried to call this out but it also should be
obvious once you know to look for it.

I'd like to call out a few drivers that I _didn't_ fix in this series
and why. If any of these drivers should be fixed then please yell.
- DRM driers backed by usb_driver (like gud, gm12u320, udl): I didn't
  add the call to drm_atomic_helper_shutdown() at shutdown time
  because there's no ".shutdown" callback for them USB drivers. Given
  that USB is hotpluggable, I'm assuming that they are robust against
  this and the special shutdown callback isn't needed.
- ofdrm and simpledrm: These didn't have drm_atomic_helper_shutdown()
  in either shutdown or remove, but I didn't add it. I think that's OK
  since they're sorta special and not really directly controlling
  hardware power sequencing.
- virtio, vkms, vmwgfx, xen: I believe these are all virtual (thus
  they wouldn't directly drive a panel) and adding the shutdown
  didn't look straightforward, so I skipped them.

I've let each patch in the series get CCed straight from
get_maintainer. That means not everyone will have received every patch
but everyone should be on the cover letter. I know some people dislike
this but when touching this many drivers there's not much
choice. dri-devel and lkml have been CCed and lore/lei exist, so
hopefully that's enough for folks. I'm happy to add people to the
whole series for future posts.

[1] https://lore.kernel.org/lkml/20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid


Douglas Anderson (15):
  drm/armada: Call drm_atomic_helper_shutdown() at shutdown time
  drm/imx/dcss: Call drm_atomic_helper_shutdown() at shutdown time
  drm/ingenic: Call drm_atomic_helper_shutdown() at shutdown time
  drm/kmb: Call drm_atomic_helper_shutdown() at shutdown time
  drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
  drm/nouveau: Call drm_atomic_helper_shutdown() or equiv at shutdown
    time
  drm/tegra: Call drm_atomic_helper_shutdown() at shutdown time
  drm/arcpgu: Call drm_atomic_helper_shutdown() at shutdown time
  drm/amdgpu: Call drm_atomic_helper_shutdown() at shutdown time
  drm/sprd: Call drm_atomic_helper_shutdown() at remove time
  drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time
  drm/gma500: Call drm_helper_force_disable_all() at shutdown/remove
    time
  drm/imx/ipuv3: Call drm_atomic_helper_shutdown() at shutdown/unbind
    time
  drm/radeon: Call drm_helper_force_disable_all() at shutdown/remove
    time
  drm/renesas/shmobile: Call drm_helper_force_disable_all() at
    shutdown/remove time

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +
 drivers/gpu/drm/armada/armada_drv.c           |  8 +++
 drivers/gpu/drm/exynos/exynos_drm_drv.c       | 11 ++++
 drivers/gpu/drm/gma500/psb_drv.c              |  8 +++
 drivers/gpu/drm/imx/dcss/dcss-drv.c           |  8 +++
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  7 ++
 drivers/gpu/drm/imx/dcss/dcss-kms.h           |  1 +
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      | 11 ++++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 66 ++++++++++++-------
 drivers/gpu/drm/kmb/kmb_drv.c                 |  6 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  9 +++
 drivers/gpu/drm/nouveau/nouveau_display.c     |  9 +++
 drivers/gpu/drm/nouveau/nouveau_display.h     |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         | 13 ++++
 drivers/gpu/drm/nouveau/nouveau_drv.h         |  1 +
 drivers/gpu/drm/nouveau/nouveau_platform.c    |  6 ++
 drivers/gpu/drm/radeon/radeon_drv.c           |  7 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  | 10 +++
 drivers/gpu/drm/sprd/sprd_drm.c               |  4 +-
 drivers/gpu/drm/tegra/drm.c                   |  6 ++
 drivers/gpu/drm/tiny/arcpgu.c                 |  6 ++
 23 files changed, 187 insertions(+), 24 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

