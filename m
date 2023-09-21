Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1467A9FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjIUU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjIUU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:29:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBAAD34
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692779f583fso446794b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324495; x=1695929295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaaYKX/WzN2yAJiXuwCzXo10Y+Z2eYCI0rB7JbtaKbk=;
        b=jtVmpnRIDN8TiFRUC7vxoAkApDBnuY+DFs1EZtRPnVdSQbWt0X1XuHm9VtOmjLG8zK
         /E/Qr3pUtZLN6BJO0FVKBBCD5wmT1ceRfFbMQfDS98RknkOQWo7LmuO93spe61s0SKHs
         K5IlxdqepbOYRS+AnEFxfEPdwVym6Kr4qrzHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324495; x=1695929295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaaYKX/WzN2yAJiXuwCzXo10Y+Z2eYCI0rB7JbtaKbk=;
        b=ZEYF34bGE1HrPgavQza5fBUxCahUwfnOG4d7wZzvtGoV25JEgtXetqkC2N1Gjn1d/A
         gyVwAPnXwC81DTwo424e6uvij7ITyY6nH7/4AZxx1R5HU60O3bsrwFbquktqvFkGGmtq
         uWlP2NVAFVWHr9n2DSnUpE6zEWJLFznM489EdEoAFf3hfY9eYZ81/CZcQig8sytar1iG
         OHnsPANUK6Shx26rLE5kU8w/Z8QVfYzCENI3FOqbv3QFm80aibxprXCztNv///Pu3Hh7
         V9MtHuEhRYNS7oJuJ+dASKmPt7iVA9DCUF9uc6tQn56Vk25giJ1kwkl6e48+zwMuphNJ
         +iRQ==
X-Gm-Message-State: AOJu0YzPqm1VMTqIZoPHHNM/ZSbPMuL09PQN7HKo5re9mnAh8ibsSIBd
        UzwiMUPIGybPNtVdTIOYAHZEIQ==
X-Google-Smtp-Source: AGHT+IEMW+st7pK1ERCOwxwoalcSvIpW84hrr+4hW9zDszK+PkTuQiJ5+HlDQX/MBJ7tT52BBQ4d4g==
X-Received: by 2002:a05:6a21:4985:b0:151:991c:84b6 with SMTP id ax5-20020a056a21498500b00151991c84b6mr6676548pzc.59.1695324494675;
        Thu, 21 Sep 2023 12:28:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Bokun.Zhang@amd.com, Hawking.Zhang@amd.com, James.Zhu@amd.com,
        Sascha Hauer <s.hauer@pengutronix.de>, Victor.Zhao@amd.com,
        Xinhui.Pan@amd.com, abrodkin@synopsys.com, airlied@gmail.com,
        alexander.deucher@amd.com, alim.akhtar@samsung.com,
        amd-gfx@lists.freedesktop.org,
        angelogioacchino.delregno@collabora.com,
        anitha.chrisanthus@intel.com, biju.das.jz@bp.renesas.com,
        bskeggs@redhat.com, christian.koenig@amd.com,
        chunkuang.hu@kernel.org, daniel@ffwll.ch, edmund.j.dea@intel.com,
        felix.kuehling@amd.com, festevam@gmail.com,
        geert+renesas@glider.be, inki.dae@samsung.com,
        jim.cromie@gmail.com, jonathanh@nvidia.com, kernel@pengutronix.de,
        kherbst@redhat.com, kieran.bingham+renesas@ideasonboard.com,
        krzysztof.kozlowski@linaro.org, kyungmin.park@samsung.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        laurentiu.palcu@oss.nxp.com, le.ma@amd.com, lijo.lazar@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        lyude@redhat.com, maarten.lankhorst@linux.intel.com,
        mario.limonciello@amd.com, matthias.bgg@gmail.com,
        mdaenzer@redhat.com, mperttunen@nvidia.com,
        nouveau@lists.freedesktop.org, orsonzhai@gmail.com,
        p.zabel@pengutronix.de, patrik.r.jakobsson@gmail.com,
        paul@crapouillou.net, robh@kernel.org, sam@ravnborg.org,
        shawnguo@kernel.org, shiwu.zhang@amd.com,
        srinivasan.shanmugam@amd.com, steven.price@arm.com,
        sw0312.kim@samsung.com, thierry.reding@gmail.com,
        tzimmermann@suse.de, zhang.lyra@gmail.com
Subject: [RFT PATCH v2 00/12] drm: call drm_atomic_helper_shutdown() at the right times
Date:   Thu, 21 Sep 2023 12:26:43 -0700
Message-ID: <20230921192749.1542462-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

I've labeled this patch series as RFT (request for testing) to help
call attention to the fact that I didn't personally test any of these
patches.

I'd like to call out a few drivers that I _didn't_ fix in this series
and why. If any of these drivers should be fixed then please yell.
- DRM drivers backed by usb_driver (like gud, gm12u320, udl): I didn't
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

NOTE: I landed everything I could from v1 of the patch series [2] [3]
to drm-misc. This v2 is everyone that is still left. If you'd like me
to land one of the patches here to drm-misc for you, please say
so. Otherwise I will assume maintainers will pick patches for their
particular driver and land them. There are no dependencies.

[1] https://lore.kernel.org/lkml/20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid
[2] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org

Changes in v2:
- Rebased and resolved conflicts.

Douglas Anderson (12):
  drm/imx/dcss: Call drm_atomic_helper_shutdown() at shutdown time
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
  drm/radeon: Call drm_helper_force_disable_all() at shutdown/remove
    time
  drm/renesas/shmobile: Call drm_helper_force_disable_all() at
    shutdown/remove time

 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  2 ++
 drivers/gpu/drm/exynos/exynos_drm_drv.c          | 11 +++++++++++
 drivers/gpu/drm/gma500/psb_drv.c                 |  8 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-drv.c              |  8 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c              |  7 +++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.h              |  1 +
 drivers/gpu/drm/kmb/kmb_drv.c                    |  6 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c           |  9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_display.c        |  9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_display.h        |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c            | 13 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h            |  1 +
 drivers/gpu/drm/nouveau/nouveau_platform.c       |  6 ++++++
 drivers/gpu/drm/radeon/radeon_drv.c              |  7 ++++++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 10 ++++++++++
 drivers/gpu/drm/sprd/sprd_drm.c                  |  4 +++-
 drivers/gpu/drm/tegra/drm.c                      |  6 ++++++
 drivers/gpu/drm/tiny/arcpgu.c                    |  6 ++++++
 20 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

