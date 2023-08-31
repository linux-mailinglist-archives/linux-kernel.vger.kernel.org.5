Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84A78E77E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbjHaIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbjHaIBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:01:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E23ACE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:01:47 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c134602a55so111730fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1693468906; x=1694073706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JfdZ+mSKoJZqw9WUXkE+SypSneLm2vVqhyV4pT/wH8=;
        b=NRYbWaApu2MfLAzfnQ5W8I4Ip6gPKxL3ZdCvNJ+KiMbYwqHz4Yl6R8MQQwECp0MJv9
         uIwoCM0JMuwDfXKLer1r4VCfyRfcj9rMkD1J8jsUUz1AbAl4OOXpVn7LqVbQn8n7fnly
         16GCGZj9R/tRmPyDvxvXuP4mT3ZYqU9Y+pjr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468906; x=1694073706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JfdZ+mSKoJZqw9WUXkE+SypSneLm2vVqhyV4pT/wH8=;
        b=Ab2gtIbN9AOJENHJZq9H54qhNfYGR0Jrn7qvtBGLpe9jOB8gaoNvLnwwTaBxB2UDnc
         eEMMPvKHVyrGs3gXCrcEr9FQ/TiM4Gn8cPZhb9c83NXu+xRYnvjljPvAvOO9PmwTdgaZ
         Y/8OxAOItR2ebOmPzafxmPm3ZaciZ1ClX0wwUtYwzkKM0vgS+RmBeapCOxvCy/dlAdVd
         RrRIuzUclClw2ZCHbz8TlzObcm2/vPURxHs0ZQVITwops5A7EoouYeqNM7kQGbHX9RWt
         X7S51j3/QtB8p2Nm+wp32UF/FW3EqELE5ysdziVAe+iigq01ypy9TZBFQx/EfbM0VEND
         EuoA==
X-Gm-Message-State: AOJu0YwQWSUaYPPx4pv7CwzWCioT8BZhTr2YQJFQIegjrWE5s9g20H8u
        +vYklkyCAut/JWPWtYrzPQlLOsf0HxQgYBsHzSz2cvQ9SXoiTtJ5
X-Google-Smtp-Source: AGHT+IFuRv0C/PixWf4cNZcQZ1FZV5y/wkAnQSWqCD86Ju0zsBIAPHTRcE1M5SpLPibvlexHqrqyGcFBW/k299Y7uE0=
X-Received: by 2002:a05:6808:2128:b0:3a7:2eb4:ce04 with SMTP id
 r40-20020a056808212800b003a72eb4ce04mr5221232oiw.5.1693468906336; Thu, 31 Aug
 2023 01:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
In-Reply-To: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 31 Aug 2023 10:01:34 +0200
Message-ID: <CAKMK7uGK_N1ReMDY_Os0dyRpE9XixuDkT=+WfL8c_=shSoQnzA@mail.gmail.com>
Subject: Re: [git pull] drm CI integration
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 03:00, Dave Airlie <airlied@gmail.com> wrote:
>
> Hey Linus,
>
> This is a PR to add drm-ci support files to the upstream tree.
> This is a bunch of ci integration for the freedesktop gitlab instance
> where we currently do upstream userspace testing on diverse sets of GPU
> hardware. From my perspective I think it's an experiment worth going with
> and seeing how the benefits/noise playout keeping these files useful.
>
> Ideally I'd like to get this so we can do pre-merge testing on PRs eventually.
>
> Below is some info from danvet on why we've ended up making the
> decision and how we can roll it back if we decide it was a bad plan.
>
> Why in upstream?
>
> - like documentation, testcases, tools CI integration is one of these things
>   where you can waste endless amounts of time if you accidentally have a version
>   that doesn't match your source code
>
> - but also like the above, there's a balance, this is the initial cut of what we
>   think makes sense to keep in sync vs out-of-tree, probably needs adjustment
>
> - gitlab supports out-of-repo gitlab integration and that's what's been used for
>   the kernel in drm, but it results in per-driver fragmentation and lots of
>   duplicated effort. the simple act of smashing an arbitrary winner into a topic
>   branch already started surfacing patches on dri-devel and sparking good
>   cross driver team discussions
>
> Why gitlab?
>
> - it's not any more shit than any of the other CI
>
> - drm userspace uses it extensively for everything in userspace, we have a lot
>   of people and experience with this, including integration of hw testing labs
>
> - media userspace like gstreamer is also on gitlab.fd.o, and there's discussion
>   to extend this to the media subsystem in some fashion
>
> Can this be shared?
>
> - there's definitely a pile of code that could move to scripts/ if other
>   subsystem adopt ci integration in upstream kernel git. other bits are more
>   drm/gpu specific like the igt-gpu-tests/tools integration
>
> - docker images can be run locally or in other CI runners
>
> Will we regret this?
>
> - it's all in one directory, intentionally, for easy deletion
>
> - probably 1-2 years in upstream to see whether this is worth it or a Big
>   Mistake. that's roughly what it took to _really_ roll out solid CI in the
>   bigger userspace projects we have on gitlab.fd.o like mesa3d

Maybe a bit more on what scenarios I see over the next 1-2 year for this.

0. Utter Failure:

Currently we have the bad combo of shit drivers/shit igt tests/shit
ci, and the eye-gauging PR here is really just surfacing this mess and
bringing it into the spotlight. if things don't improve at all, and
we're still at the same point in 2 year as we are now, this was a
failure and drm/ci needs to be unceremonuously deleted.

I might head out and pick up goat farming in the alps in this case :-/

1. Better build testing:

- we manage to solidly integrate this into our PR and committer flows,
currently that's not really the case because of a bit a chicken/egg
situation. this is a ton of work, but 1-2 years should be enough for
results

- better build time testing hopefully encourages people to build more
kunit and other build time tests, especially for the more complex
libraries we have that are really hard to exhaustively test with real
hw, like the dp mst library

- in that case we'd keep drm/ci, but probably throw out the hw driver
testing integration and push that down into the per-driver separate
git repos. gitlab can cope with this and even in the driver repos with
the out-of-tree hw testing ci integration still include the build-time
testing targets from upstream and run them, so we'd still get much
better collaboration across drivers on the build testing

- this is kinda the "no more shit ci" achievement

2. Better igts for virtual drivers:

- better build testing, plus:

- media I think is really great here with having fully virtual
driverrs to validate any new interfaces and testcases against. we're
trying to build the same up with vgem/vkms since a few years, but it's
slow going. vgem/vkms integration isn't in this PR, but it's already
in the works, and I'm hoping that we can at least fix the igt test
quality mess a bit by getting to the point where igt tests for new kms
uapi must pass on vkms.

- in this case we might keep some of the hw driver testing integration
simply as a canary in the coal mine, but until we have some solid
drivers beyond vkms we'd have to limit that severely to not cause too
much eye gauging in that directory

- this would get us to the "no more shit igt tests" achievement

3. "We can dream":

- we also manage to fix up the shit driver sitatution for at least
some drivers, and can have a fairly broad selection of hw driver
testing in ci. Given how much intel gfx ci is struggling with this,
and for years, this might only be realistic for fairly small drivers
and in really well controlled settings

- realistically there's no way to get here in 2 years

- this would be the "at least some non-shit drivers" achievement

4. "It's time to retire, we achieved it all":

- igt test passing becomes a merge requirement for any new driver, and
the existing ones still in use are mostly fixed

- I'm planning to retire this decade, or the next :-)

Cheers, Daniel

>
> Dave + Daniel.
>
> topic/drm-ci-2023-08-31-1:
> drm ci for 6.6-rc1
>
> Add CI integration support files for drm subsystem to
> gitlab.freedesktop.org instance.
> The following changes since commit 3698a75f5a98d0a6599e2878ab25d30a82dd836a:
>
>   Merge tag 'drm-intel-next-fixes-2023-08-24' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-08-25
> 12:55:55 +1000)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/topic/drm-ci-2023-08-31-1
>
> for you to fetch changes up to ad6bfe1b66a5c146ec236847eca7af4c8806d666:
>
>   drm: ci: docs: fix build warning - add missing escape (2023-08-29
> 19:56:11 +0200)
>
> ----------------------------------------------------------------
> drm ci for 6.6-rc1
>
> Add CI integration support files for drm subsystem to
> gitlab.freedesktop.org instance.
>
> ----------------------------------------------------------------
> Helen Koike (1):
>       drm: ci: docs: fix build warning - add missing escape
>
> Tomeu Vizoso (1):
>       drm: Add initial ci/ subdirectory
>
>  Documentation/gpu/automated_testing.rst            |  144 +
>  Documentation/gpu/index.rst                        |    1 +
>  MAINTAINERS                                        |    8 +
>  drivers/gpu/drm/ci/arm.config                      |   69 +
>  drivers/gpu/drm/ci/arm64.config                    |  199 ++
>  drivers/gpu/drm/ci/build-igt.sh                    |   35 +
>  drivers/gpu/drm/ci/build.sh                        |  157 ++
>  drivers/gpu/drm/ci/build.yml                       |  110 +
>  drivers/gpu/drm/ci/check-patch.py                  |   57 +
>  drivers/gpu/drm/ci/container.yml                   |   65 +
>  drivers/gpu/drm/ci/gitlab-ci.yml                   |  251 ++
>  drivers/gpu/drm/ci/igt_runner.sh                   |   77 +
>  drivers/gpu/drm/ci/image-tags.yml                  |   15 +
>  drivers/gpu/drm/ci/lava-submit.sh                  |   57 +
>  drivers/gpu/drm/ci/static-checks.yml               |   12 +
>  drivers/gpu/drm/ci/test.yml                        |  335 +++
>  drivers/gpu/drm/ci/testlist.txt                    | 2912 ++++++++++++++++++++
>  drivers/gpu/drm/ci/x86_64.config                   |  111 +
>  drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt  |   19 +
>  drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt |   21 +
>  drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips.txt  |    2 +
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt      |   17 +
>  drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt     |   32 +
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt      |    4 +
>  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt       |   58 +
>  drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt      |    1 +
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt       |    6 +
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt       |   18 +
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt      |   38 +
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt       |    2 +
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt       |   19 +
>  drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt      |   41 +
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt       |    5 +
>  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt       |   25 +
>  drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt      |   26 +
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt       |    5 +
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt       |   37 +
>  drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt      |    5 +
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt       |   11 +
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt       |   48 +
>  drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt      |    1 +
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt       |    2 +
>  .../gpu/drm/ci/xfails/mediatek-mt8173-fails.txt    |   29 +
>  .../gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt   |    0
>  .../gpu/drm/ci/xfails/mediatek-mt8183-fails.txt    |   10 +
>  .../gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt   |   14 +
>  drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt     |   12 +
>  drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt    |    4 +
>  drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |   15 +
>  drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt   |    4 +
>  drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt    |    2 +
>  drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt   |    4 +
>  drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt    |    2 +
>  drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt     |   25 +
>  drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt    |    7 +
>  drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt     |   23 +
>  drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt     |   68 +
>  drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt    |   11 +
>  drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt     |    2 +
>  .../gpu/drm/ci/xfails/rockchip-rk3288-fails.txt    |   48 +
>  .../gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt   |    9 +
>  .../gpu/drm/ci/xfails/rockchip-rk3288-skips.txt    |   52 +
>  .../gpu/drm/ci/xfails/rockchip-rk3399-fails.txt    |   37 +
>  .../gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt   |   23 +
>  .../gpu/drm/ci/xfails/rockchip-rk3399-skips.txt    |    5 +
>  .../gpu/drm/ci/xfails/virtio_gpu-none-fails.txt    |   38 +
>  .../gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt   |    0
>  .../gpu/drm/ci/xfails/virtio_gpu-none-skips.txt    |    6 +
>  68 files changed, 5508 insertions(+)
>  create mode 100644 Documentation/gpu/automated_testing.rst
>  create mode 100644 drivers/gpu/drm/ci/arm.config
>  create mode 100644 drivers/gpu/drm/ci/arm64.config
>  create mode 100644 drivers/gpu/drm/ci/build-igt.sh
>  create mode 100644 drivers/gpu/drm/ci/build.sh
>  create mode 100644 drivers/gpu/drm/ci/build.yml
>  create mode 100755 drivers/gpu/drm/ci/check-patch.py
>  create mode 100644 drivers/gpu/drm/ci/container.yml
>  create mode 100644 drivers/gpu/drm/ci/gitlab-ci.yml
>  create mode 100755 drivers/gpu/drm/ci/igt_runner.sh
>  create mode 100644 drivers/gpu/drm/ci/image-tags.yml
>  create mode 100755 drivers/gpu/drm/ci/lava-submit.sh
>  create mode 100644 drivers/gpu/drm/ci/static-checks.yml
>  create mode 100644 drivers/gpu/drm/ci/test.yml
>  create mode 100644 drivers/gpu/drm/ci/testlist.txt
>  create mode 100644 drivers/gpu/drm/ci/x86_64.config
>  create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-skips.txt



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
