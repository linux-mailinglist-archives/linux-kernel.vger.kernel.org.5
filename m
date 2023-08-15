Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8877CE27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjHOOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjHOOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:33:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F110C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:33:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5254f9eda36so3784806a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109979; x=1692714779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4VYqjFlAWwT6jNZJukufvlnhaGlcfw6dxnIlBpM+LU=;
        b=Nz+m7o08jTFGrJ/rAfjJ7W3hlriHLmyC/vCdb+FBYDvh8ZPhYjT1NITw7HF/f7YluL
         I8HjWYaI1CPvIi9eCflGUKDPbMZXw3EnTeTrwl6r1sFt7I1q7OTtvK3EodygGShvUE1J
         oOVmSgqBrOKT7SZF7kdjIF4siQQl29a/yYAO/ors1mHuYt0P67QqmDoWh5wFDjCOHgzk
         GK8zjwUT+InVsA/lI2WEgP2cC9KWaM6WluvJF8T5LmOdaqci9Sj1srmmeWpR1SrzRgG4
         2Cicq2dtCVFBrB/YvzK/WD/uUR1S6AewXTQbSXi9yrgcwtQbUBuqBgbOOmfEFj+1Ychs
         REJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109979; x=1692714779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4VYqjFlAWwT6jNZJukufvlnhaGlcfw6dxnIlBpM+LU=;
        b=MGThEaPgfDaLQznlOEDSUZlePNm7GC27D8VbffR5p1Y7rzzWrBr0n09Ud90o5GdiS/
         ulADdQrqq1fjNquwxSHsgqmj6yKirTef4RS18mAa2PSE63e6RqvZgFgyW9v1AZbJWs8M
         1WAGAgFihV1KhqDdcaWiw0yr1qEQWuatHNlmcdrOmOYPVBoHoSh5HQ5+6Hx3sqQ0I2QY
         GfdOtCSVW60uTMwhDmQjNTjq8Z2CQq8vskJNAC588BokR/rEOrpYy9Lf0yfzJp1XMrGo
         v7seX2WMjx2gGFRatB1399/5MEkQeCebwOW5P2cLTQ1OfILWzTmy2McL+LlphDCevLHm
         kobA==
X-Gm-Message-State: AOJu0YzTShgrY41+t4xyTfDUwyT+Vel8l1j4BtwDqBxnXU0tyFcZgqna
        Z/mXheDoeYl5Qum6aq7nGfdGbprfqEWLbbU26pI=
X-Google-Smtp-Source: AGHT+IGtiB7cZ9LjhutijPGGPq6XRQz17uT/pSbx/vwrEPlFxHoK23tiP273Dh2R+zr4Xfu+u+e1MAWXcpkGNJAvQtE=
X-Received: by 2002:aa7:cc0e:0:b0:523:48d7:70b1 with SMTP id
 q14-20020aa7cc0e000000b0052348d770b1mr9393509edt.19.1692109978881; Tue, 15
 Aug 2023 07:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <389b-64db6700-1-3dc04b80@31442286> <b278375f-4644-2db6-9a14-9088470d528c@suse.de>
 <CAKMK7uF1hv3S--=jsmFWG_tkOKavgMBOkWQt6VOSV0d1U7C0VA@mail.gmail.com> <1b9ea227-b068-9d91-1036-28a4161b1744@suse.de>
In-Reply-To: <1b9ea227-b068-9d91-1036-28a4161b1744@suse.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 15 Aug 2023 07:32:46 -0700
Message-ID: <CAF6AEGsr+2xaCeExm9wPmK=nU+jxevLcd8RDWTSFrwKR-yCvZg@mail.gmail.com>
Subject: Re: [PULL for v6.6] drm-misc-next
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>, daniels@collabora.com,
        robdclark@google.com, gustavo.padovan@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        linux-kernel@vger.kernel.org, robclark@freedesktop.org,
        david.heidelberg@collabora.com,
        Helen Mae Koike Fornazier <helen.koike@collabora.com>,
        anholt@google.com, dri-devel@lists.freedesktop.org,
        emma@anholt.net, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 5:51=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi Daniel
>
> Am 15.08.23 um 14:35 schrieb Daniel Vetter:
> > On Tue, 15 Aug 2023 at 14:31, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
> >>
> >> Hi,
> >>
> >> thanks for your patchset.
> >>
> >> Am 15.08.23 um 13:53 schrieb Helen Mae Koike Fornazier:
> >>> On Tuesday, August 15, 2023 06:12 -03, Jani Nikula <jani.nikula@linux=
.intel.com> wrote:
> >>>
> >>>> On Mon, 14 Aug 2023, Helen Koike <helen.koike@collabora.com> wrote:
> >>>>> The following changes since commit f5d8f9c0d8b4bc8ad7e7b23a9f4d116e=
99202dd3:
> >>>>>
> >>>>>     drm/panel: JDI LT070ME05000 simplify with dev_err_probe() (2023=
-08-14 14:44:30 +0200)
> >>>>>
> >>>>> are available in the Git repository at:
> >>>>>
> >>>>>     git@gitlab.freedesktop.org:helen.fornazier/linux.git tags/drm-c=
i-v13-drm-misc
> >>>>>
> >>>>> for you to fetch changes up to 60242246bc906a37a7eae2094633a38bda7d=
45e6:
> >>>>>
> >>>>>     drm: Add initial ci/ subdirectory (2023-08-14 20:47:37 -0300)
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> drm-ci for drm-misc-next
> >>>>
> >>>> FYI, usually the subject indicates the source or what to pull, not t=
he
> >>>> destination. Was confused here for a bit. ;)
> >>>
> >>> Thanks for the info! Should I re-send this one?
> >>
> >> Yes, please.
> >>
> >> As a developer, you are not supposed to send pull requests or any othe=
r
> >> emails with [PULL] in their subject line. We don't merge pull requests
> >> into drm-misc.
> >>
> >> To get your patches merged, please make a patchset on top of the a
> >> recent checkout of drm-misc-next. Then send the patchset via
> >>
> >>     git send-email
> >>
> >> to dri-devel@lists.freedesktop.org and all the developers and
> >> maintainers that are affected by the changes. This will start the revi=
ew
> >> process. After your patchset has entered the drm-misc-next branch, we
> >> (the maintainers of the drm-misc tree) will create the appropriate pul=
l
> >> requests when the time has come.
> >
> > I think we have a coordination problem, at least the rough plan I
> > discussed with Dave was that we'd do an entirely separate pull request
> > to Linus for the gitlab stuff, so that there's no surprises or "you
> > snuck this in without making it obvious" talk after the fact.
> >
> > I'll check with Dave whether he wants to do the branch directly in
> > drm.git or whether we'll take the pull from Helen.
>
> The PR sounds like a simple newbie mistake to me. It is supposed to be
> pulled into drm-misc-next, which we never do. If the cover letter is
> correct, it should just be a regular patchset.
>
> Otherwise, there should be something like a drm-ci tree, from which you
> can fetch the changes directly.

I asked for a pull request so that I could also merge it to msm-next
so that I can do CI this cycle.  (Unlike the earlier out-of-tree
version of the drm/ci yml, this version needs to be in the branch that
CI runs on, so I can't use the workaround that I had in previous
cycles.)

Perhaps it should be a pull request targeting drm-next instead of drm-misc-=
next.

We were going to do this one-off for this cycle and then evaluate
going forward whether a drm-ci-next tree is needed.  But perhaps it is
a good idea.

BR,
-R

> Best regards
> Thomas
>
> >
> > Cheers, Sima
> >
> >>
> >> Best regards
> >> Thomas
> >>
> >>>
> >>> Regards,
> >>> Helen
> >>>
> >>>>
> >>>> BR,
> >>>> Jani.
> >>>>
> >>>>>
> >>>>> Here is the patch that adds a ci/ subdirectory to drm and allows
> >>>>> developers to easily execute tests.
> >>>>>
> >>>>> Developers can easily execute several tests on different devices
> >>>>> by just pushing their branch to their fork in a repository hosted
> >>>>> on gitlab.freedesktop.org which has an infrastructure to run jobs
> >>>>> in several runners and farms with different devices.
> >>>>>
> >>>>> The patch was acked and tested by others.
> >>>>>
> >>>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> Tomeu Vizoso (1):
> >>>>>         drm: Add initial ci/ subdirectory
> >>>>>
> >>>>>    Documentation/gpu/automated_testing.rst            |  144 +
> >>>>>    Documentation/gpu/index.rst                        |    1 +
> >>>>>    MAINTAINERS                                        |    8 +
> >>>>>    drivers/gpu/drm/ci/arm.config                      |   69 +
> >>>>>    drivers/gpu/drm/ci/arm64.config                    |  199 ++
> >>>>>    drivers/gpu/drm/ci/build-igt.sh                    |   35 +
> >>>>>    drivers/gpu/drm/ci/build.sh                        |  157 ++
> >>>>>    drivers/gpu/drm/ci/build.yml                       |  110 +
> >>>>>    drivers/gpu/drm/ci/check-patch.py                  |   57 +
> >>>>>    drivers/gpu/drm/ci/container.yml                   |   65 +
> >>>>>    drivers/gpu/drm/ci/gitlab-ci.yml                   |  251 ++
> >>>>>    drivers/gpu/drm/ci/igt_runner.sh                   |   77 +
> >>>>>    drivers/gpu/drm/ci/image-tags.yml                  |   15 +
> >>>>>    drivers/gpu/drm/ci/lava-submit.sh                  |   57 +
> >>>>>    drivers/gpu/drm/ci/static-checks.yml               |   12 +
> >>>>>    drivers/gpu/drm/ci/test.yml                        |  335 +++
> >>>>>    drivers/gpu/drm/ci/testlist.txt                    | 2912 ++++++=
++++++++++++++
> >>>>>    drivers/gpu/drm/ci/x86_64.config                   |  111 +
> >>>>>    drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt  |   19 +
> >>>>>    drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt |   21 +
> >>>>>    drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips.txt  |    2 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-amly-fails.txt      |   17 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt     |   32 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-amly-skips.txt      |    4 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-apl-fails.txt       |   58 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt      |    1 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-apl-skips.txt       |    6 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-cml-fails.txt       |   18 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt      |   38 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-cml-skips.txt       |    2 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-glk-fails.txt       |   19 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt      |   41 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-glk-skips.txt       |    5 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt       |   25 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt      |   26 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt       |    5 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt       |   37 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt      |    5 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt       |   11 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-whl-fails.txt       |   48 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt      |    1 +
> >>>>>    drivers/gpu/drm/ci/xfails/i915-whl-skips.txt       |    2 +
> >>>>>    .../gpu/drm/ci/xfails/mediatek-mt8173-fails.txt    |   29 +
> >>>>>    .../gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt   |    0
> >>>>>    .../gpu/drm/ci/xfails/mediatek-mt8183-fails.txt    |   10 +
> >>>>>    .../gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt   |   14 +
> >>>>>    drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt     |   12 +
> >>>>>    drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt    |    4 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |   15 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt   |    4 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt    |    2 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt   |    4 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt    |    2 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt     |   25 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt    |    7 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt     |   23 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt     |   68 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt    |   11 +
> >>>>>    drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt     |    2 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3288-fails.txt    |   48 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt   |    9 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3288-skips.txt    |   52 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3399-fails.txt    |   36 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt   |   24 +
> >>>>>    .../gpu/drm/ci/xfails/rockchip-rk3399-skips.txt    |    5 +
> >>>>>    .../gpu/drm/ci/xfails/virtio_gpu-none-fails.txt    |   38 +
> >>>>>    .../gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt   |    0
> >>>>>    .../gpu/drm/ci/xfails/virtio_gpu-none-skips.txt    |    6 +
> >>>>>    68 files changed, 5508 insertions(+)
> >>>>>    create mode 100644 Documentation/gpu/automated_testing.rst
> >>>>>    create mode 100644 drivers/gpu/drm/ci/arm.config
> >>>>>    create mode 100644 drivers/gpu/drm/ci/arm64.config
> >>>>>    create mode 100644 drivers/gpu/drm/ci/build-igt.sh
> >>>>>    create mode 100644 drivers/gpu/drm/ci/build.sh
> >>>>>    create mode 100644 drivers/gpu/drm/ci/build.yml
> >>>>>    create mode 100755 drivers/gpu/drm/ci/check-patch.py
> >>>>>    create mode 100644 drivers/gpu/drm/ci/container.yml
> >>>>>    create mode 100644 drivers/gpu/drm/ci/gitlab-ci.yml
> >>>>>    create mode 100755 drivers/gpu/drm/ci/igt_runner.sh
> >>>>>    create mode 100644 drivers/gpu/drm/ci/image-tags.yml
> >>>>>    create mode 100755 drivers/gpu/drm/ci/lava-submit.sh
> >>>>>    create mode 100644 drivers/gpu/drm/ci/static-checks.yml
> >>>>>    create mode 100644 drivers/gpu/drm/ci/test.yml
> >>>>>    create mode 100644 drivers/gpu/drm/ci/testlist.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/x86_64.config
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails=
.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-flake=
s.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/amdgpu-stoney-skips=
.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-fai=
ls.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-fla=
kes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-fai=
ls.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-fla=
kes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-fails.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.=
txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.=
txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-skips.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-fails.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.t=
xt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/msm-sdm845-skips.tx=
t
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fai=
ls.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fla=
kes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-ski=
ps.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-fai=
ls.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-fla=
kes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-ski=
ps.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-fai=
ls.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-fla=
kes.txt
> >>>>>    create mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-ski=
ps.txt
> >>>>
> >>>> --
> >>>> Jani Nikula, Intel Open Source Graphics Center
> >>>
> >>
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Frankenstrasse 146, 90461 Nuernberg, Germany
> >> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> >> HRB 36809 (AG Nuernberg)
> >
> >
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
