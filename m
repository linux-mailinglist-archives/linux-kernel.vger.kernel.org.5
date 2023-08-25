Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3937788BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbjHYObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbjHYOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:30:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024A1995;
        Fri, 25 Aug 2023 07:30:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso129101566b.0;
        Fri, 25 Aug 2023 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692973829; x=1693578629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TKRKdJyVPQnXrud/UFhZyJn/bFLsStYMULRC9lmJOg=;
        b=OQXrYSh/ZTaRcrWWA0vglXPp3TlsL1Ma7vpCxlFdwF1lEPdbMdGQ/tKMaMonLuwtO5
         JABJFdxaAHTAHmpQ686SHGkxHl979MSfAFLV+3B5HIinjzcPUGnuPBGRlMn6pbEscsw4
         b0PqksMuIqStaAEvnyVczSfPUB69oWqBDHLqH0RNamea7U8iC2tZ6nNFXK2HuYAt/32n
         2kynjPi6lEJRwFgree9ATo/CaHaPlGM78Qu24dsK7wKNCKVFgt5H/HBeLRbk++6K2c1l
         0MoGgedsO6+4cm5hC27BUve7gq5G1M1pu2ApSyFKqsJXzh2yWo+9u/FQYYSPKg4EXygz
         Vhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973829; x=1693578629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TKRKdJyVPQnXrud/UFhZyJn/bFLsStYMULRC9lmJOg=;
        b=jdgxEyOeYFc5O8iOobdWGKzhm0NIxVxjUgr6PoaFGAguNz/AF+zrsJWhnd1i/Waon/
         /4NEVeZ6y4m7Z1IE/NyMMMpWKp+sGiV+3CZQAbbXgNIz/0DMuGVcb1Ia/GBwJiJ1vHvq
         lCQ3bParVf1H21OqvLYoH36CebkaiuCHTH3rf4O+GJ8y6CgO+VXNHASX0f2dm7hrPuJC
         O6nHHJJCdBiz+Yva23m2ntRKoqyMy53b6uhRMiHiFGa8IONDhtuZNsj2+tIQXQiMONAg
         +Bguw48aHhYNYEBW4AVr7uWKx1hkrsl2d0Jo8MG4S99DUqQIzL6nlsNP2TmShELQ2f21
         lr4A==
X-Gm-Message-State: AOJu0Ywjb7oM5F/F38DZ4eetIjcyMhKSk4aZ3Y0G2Dsqff8AqJAtnYxU
        GBqCrNQPuclxYaEUBi4FG5o22cOYi1SuayIDjIo=
X-Google-Smtp-Source: AGHT+IEES/Rzsyvr1JvufABrAQWEAlPgt7MuBwIREScZLrLGFwNRoIXbaWrIdhd46oBepXht/zkQv0lQ0dAVqCGxlr0=
X-Received: by 2002:a17:906:150:b0:9a1:d79a:418e with SMTP id
 16-20020a170906015000b009a1d79a418emr6028363ejh.40.1692973829204; Fri, 25 Aug
 2023 07:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230825122435.316272-1-vignesh.raman@collabora.com>
 <20230825122435.316272-3-vignesh.raman@collabora.com> <87pm3b2pkz.fsf@intel.com>
In-Reply-To: <87pm3b2pkz.fsf@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 25 Aug 2023 07:30:17 -0700
Message-ID: <CAF6AEGs4p0xXJjsNug45CFiP0n-5h7wpdy22YBryjrnWFROESg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm: ci: Force db410c to host mode
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        robdclark@google.com, corbet@lwn.net, khilman@baylibre.com,
        sergi.blanch.torne@collabora.com, gustavo.padovan@collabora.com,
        linux-rockchip@lists.infradead.org, daniels@collabora.com,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        helen.koike@collabora.com, anholt@google.com,
        linux-mediatek@lists.infradead.org, mripard@kernel.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 6:56=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > Force db410c to host mode to fix network issue which results in failure
> > to mount root fs via NFS.
> > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c=
80a54dda510743cefd1c4b65b8
> >
> > Since this fix is not sent upstream, add it to build.sh script
> > before building the kernel and dts. Better approach would be
> > to use devicetree overlays.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >  drivers/gpu/drm/ci/build.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > index 7b014287a041..c39834bd6bd7 100644
> > --- a/drivers/gpu/drm/ci/build.sh
> > +++ b/drivers/gpu/drm/ci/build.sh
> > @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
> >      fi
> >  fi
> >
> > +# Force db410c to host mode to fix network issue which results in fail=
ure to mount root fs via NFS.
> > +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c=
15c80a54dda510743cefd1c4b65b8
> > +sed -i '/&usb {/,/status =3D "okay";/s/status =3D "okay";/&\n\tdr_mode=
 =3D "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> > +
>
> It seems like a really bad idea to me to have the CI build modify the
> source tree before building.
>
> The kernel being built will have a dirty git repo, and the localversion
> will have -dirty in it.
>
> I think it would be better to do out-of-tree builds and assume the
> source is read-only.

We have the ${target_branch}-external-fixes mechanism to merge
necessary changes before building the kernel for CI.  Which is
necessary for a couple of reasons:

1) patches like this which aren't appropriate upstream but necessary
due to the CI lab setup
2) target branch if often based on an early -rc, and it isn't unheard
of to need some fix for some board or another which isn't appropriate
to land via drm-next

We should use the -external-fixes branch mechanism for patches like this on=
e.

BR,
-R

> >  for opt in $ENABLE_KCONFIGS; do
> >    echo CONFIG_$opt=3Dy >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
> >  done
>
> Ditto for the config changes in the context here. Those are files in
> git, don't change them.
>
> Shouldn't this use something like 'scripts/config --enable' or
> 'scripts/config --disable' on the .config file to be used for building
> instead?
>
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
