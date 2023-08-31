Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9478E419
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjHaBAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHaBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:00:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA7CDA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:00:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso23732966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693443635; x=1694048435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nrq3meEQ0mpSOpe+syQsbsJI8LA/ycypfj5UNVt9xjU=;
        b=so/Fh4kq1EKiLVG5zmT3EJ72yP+BIBPvcp3HaPa2uJxOwl3YquwxBceUrQDAskmg8D
         XNcXXNvYx5buXtrKG9y7feKH8qEcrqpWsS7XLtxnxbp3p2wMdbG3TmrBeslVP9fouE2W
         meJv4DdSikKUeGRKbksszpjf2H2Nwd4MVrnVpgEDGhSIRCf9T4/qKa1wn7W4tFU7apZY
         5asxaAYtfvMC9YeLSqy7WxXdNxAcBlzqNq3fMhONWYHKUEL0pR8nyDrhxbzxCiI0PNo4
         3taWMCFXtzTQ6ZTbNYE6o9Qc2yGiL0P6ipTNmjrnFOKP5UCaoDLV6iHLujophTMe29+Q
         x7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693443635; x=1694048435;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nrq3meEQ0mpSOpe+syQsbsJI8LA/ycypfj5UNVt9xjU=;
        b=FEYzq3SxKpGYLertxM4SO2KY65cw04C3rkL+5jDF/AJNWcz6hblwPWIMuM9sAwPpEm
         7begse1Yp3FnS+/T7qxwkxE7aKdAzTLk4jfU5xcYX9Cv4xgSBUsJ5idSdqDr3JXXj8rt
         xhi5GWpEyUI6nVOo16rfJPSznd3Pdv2NNsunynaIYalOyw3GBYp49HXHS86c1VwZ0a3c
         pp2kGhtPtNEyK+ZMLBs5etR0tQS4qtXiNMaxJi6p0Ws8f0KXRTDHSmQ5r5zqc6ywIS74
         8Zp6dWL3VYlPmJLCKpZenhjbYcgi6SoskmTKMBfZFGuevB1ei/Gyb3lx7IXjeM4gFM9n
         4a8w==
X-Gm-Message-State: AOJu0Ywk2ic9f+IpE1vSEPXCvhnT+IY7d6gJvRX99GirJVT35ljNeF3s
        B1jSnwBTfiei//08tE9O9r2sT7SfPzWDMDlZQP4=
X-Google-Smtp-Source: AGHT+IHAQPT5XY1L4JhOgHQLd+Nx606Zp5iPeqsqFVL/myqyCBrl1/pRO9rku3fsay/mQakfZp4yMfrzayxjmkl26fA=
X-Received: by 2002:a17:906:ef8c:b0:99e:39d:4fa7 with SMTP id
 ze12-20020a170906ef8c00b0099e039d4fa7mr2896764ejb.22.1693443634763; Wed, 30
 Aug 2023 18:00:34 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 31 Aug 2023 11:00:20 +1000
Message-ID: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
Subject: [git pull] drm CI integration
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

This is a PR to add drm-ci support files to the upstream tree.
This is a bunch of ci integration for the freedesktop gitlab instance
where we currently do upstream userspace testing on diverse sets of GPU
hardware. From my perspective I think it's an experiment worth going with
and seeing how the benefits/noise playout keeping these files useful.

Ideally I'd like to get this so we can do pre-merge testing on PRs eventually.

Below is some info from danvet on why we've ended up making the
decision and how we can roll it back if we decide it was a bad plan.

Why in upstream?

- like documentation, testcases, tools CI integration is one of these things
  where you can waste endless amounts of time if you accidentally have a version
  that doesn't match your source code

- but also like the above, there's a balance, this is the initial cut of what we
  think makes sense to keep in sync vs out-of-tree, probably needs adjustment

- gitlab supports out-of-repo gitlab integration and that's what's been used for
  the kernel in drm, but it results in per-driver fragmentation and lots of
  duplicated effort. the simple act of smashing an arbitrary winner into a topic
  branch already started surfacing patches on dri-devel and sparking good
  cross driver team discussions

Why gitlab?

- it's not any more shit than any of the other CI

- drm userspace uses it extensively for everything in userspace, we have a lot
  of people and experience with this, including integration of hw testing labs

- media userspace like gstreamer is also on gitlab.fd.o, and there's discussion
  to extend this to the media subsystem in some fashion

Can this be shared?

- there's definitely a pile of code that could move to scripts/ if other
  subsystem adopt ci integration in upstream kernel git. other bits are more
  drm/gpu specific like the igt-gpu-tests/tools integration

- docker images can be run locally or in other CI runners

Will we regret this?

- it's all in one directory, intentionally, for easy deletion

- probably 1-2 years in upstream to see whether this is worth it or a Big
  Mistake. that's roughly what it took to _really_ roll out solid CI in the
  bigger userspace projects we have on gitlab.fd.o like mesa3d

Dave + Daniel.

topic/drm-ci-2023-08-31-1:
drm ci for 6.6-rc1

Add CI integration support files for drm subsystem to
gitlab.freedesktop.org instance.
The following changes since commit 3698a75f5a98d0a6599e2878ab25d30a82dd836a:

  Merge tag 'drm-intel-next-fixes-2023-08-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-08-25
12:55:55 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/topic/drm-ci-2023-08-31-1

for you to fetch changes up to ad6bfe1b66a5c146ec236847eca7af4c8806d666:

  drm: ci: docs: fix build warning - add missing escape (2023-08-29
19:56:11 +0200)

----------------------------------------------------------------
drm ci for 6.6-rc1

Add CI integration support files for drm subsystem to
gitlab.freedesktop.org instance.

----------------------------------------------------------------
Helen Koike (1):
      drm: ci: docs: fix build warning - add missing escape

Tomeu Vizoso (1):
      drm: Add initial ci/ subdirectory

 Documentation/gpu/automated_testing.rst            |  144 +
 Documentation/gpu/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 drivers/gpu/drm/ci/arm.config                      |   69 +
 drivers/gpu/drm/ci/arm64.config                    |  199 ++
 drivers/gpu/drm/ci/build-igt.sh                    |   35 +
 drivers/gpu/drm/ci/build.sh                        |  157 ++
 drivers/gpu/drm/ci/build.yml                       |  110 +
 drivers/gpu/drm/ci/check-patch.py                  |   57 +
 drivers/gpu/drm/ci/container.yml                   |   65 +
 drivers/gpu/drm/ci/gitlab-ci.yml                   |  251 ++
 drivers/gpu/drm/ci/igt_runner.sh                   |   77 +
 drivers/gpu/drm/ci/image-tags.yml                  |   15 +
 drivers/gpu/drm/ci/lava-submit.sh                  |   57 +
 drivers/gpu/drm/ci/static-checks.yml               |   12 +
 drivers/gpu/drm/ci/test.yml                        |  335 +++
 drivers/gpu/drm/ci/testlist.txt                    | 2912 ++++++++++++++++++++
 drivers/gpu/drm/ci/x86_64.config                   |  111 +
 drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt  |   19 +
 drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt |   21 +
 drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips.txt  |    2 +
 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt      |   17 +
 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt     |   32 +
 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt      |    4 +
 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt       |   58 +
 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt      |    1 +
 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt       |    6 +
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt       |   18 +
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt      |   38 +
 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt       |    2 +
 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt       |   19 +
 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt      |   41 +
 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt       |    5 +
 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt       |   25 +
 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt      |   26 +
 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt       |    5 +
 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt       |   37 +
 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt      |    5 +
 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt       |   11 +
 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt       |   48 +
 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt      |    1 +
 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt       |    2 +
 .../gpu/drm/ci/xfails/mediatek-mt8173-fails.txt    |   29 +
 .../gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt   |    0
 .../gpu/drm/ci/xfails/mediatek-mt8183-fails.txt    |   10 +
 .../gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt   |   14 +
 drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt     |   12 +
 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt    |    4 +
 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |   15 +
 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt   |    4 +
 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt    |    2 +
 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt   |    4 +
 drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt    |    2 +
 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt     |   25 +
 drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt    |    7 +
 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt     |   23 +
 drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt     |   68 +
 drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt    |   11 +
 drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt     |    2 +
 .../gpu/drm/ci/xfails/rockchip-rk3288-fails.txt    |   48 +
 .../gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt   |    9 +
 .../gpu/drm/ci/xfails/rockchip-rk3288-skips.txt    |   52 +
 .../gpu/drm/ci/xfails/rockchip-rk3399-fails.txt    |   37 +
 .../gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt   |   23 +
 .../gpu/drm/ci/xfails/rockchip-rk3399-skips.txt    |    5 +
 .../gpu/drm/ci/xfails/virtio_gpu-none-fails.txt    |   38 +
 .../gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt   |    0
 .../gpu/drm/ci/xfails/virtio_gpu-none-skips.txt    |    6 +
 68 files changed, 5508 insertions(+)
 create mode 100644 Documentation/gpu/automated_testing.rst
 create mode 100644 drivers/gpu/drm/ci/arm.config
 create mode 100644 drivers/gpu/drm/ci/arm64.config
 create mode 100644 drivers/gpu/drm/ci/build-igt.sh
 create mode 100644 drivers/gpu/drm/ci/build.sh
 create mode 100644 drivers/gpu/drm/ci/build.yml
 create mode 100755 drivers/gpu/drm/ci/check-patch.py
 create mode 100644 drivers/gpu/drm/ci/container.yml
 create mode 100644 drivers/gpu/drm/ci/gitlab-ci.yml
 create mode 100755 drivers/gpu/drm/ci/igt_runner.sh
 create mode 100644 drivers/gpu/drm/ci/image-tags.yml
 create mode 100755 drivers/gpu/drm/ci/lava-submit.sh
 create mode 100644 drivers/gpu/drm/ci/static-checks.yml
 create mode 100644 drivers/gpu/drm/ci/test.yml
 create mode 100644 drivers/gpu/drm/ci/testlist.txt
 create mode 100644 drivers/gpu/drm/ci/x86_64.config
 create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-skips.txt
