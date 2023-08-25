Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24954788BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjHYOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbjHYOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:41:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5AEC;
        Fri, 25 Aug 2023 07:41:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bed101b70so122043066b.3;
        Fri, 25 Aug 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692974492; x=1693579292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/Nyi2UtJHS2L8Ejnis0sIFHEs44gVXKzFV9je3/KrQ=;
        b=m5YpFddniJdsweLpDiBMuTrwp/DFZA7ALBdWjy/ou8KTRnc7m1IFRI+d6jSHq0CEAM
         QhFVj47cdxI+vCV4+9qbuh3aoDvvBm2JOgyx8jY9qcLLmmtrJkkqfq+aSlE7T8wv+4iP
         uhe7HLkAu15rpIFabmISxrkvwM5L47q3+A/GaN/Zxe1GeBVJesIitTuCJOHfqnTe+pnm
         nP2UxSHrwwfBZ0P6xfMo5V+2hntqsaNAGeYTsIgWO5h8S9W/2ESYbh+GDXW9yUOO5yFM
         LLOejgrH7OPsyUOcMRfUViC3pludGiVGC9VygBQV532P5MSingkpNeSPgkrDQZ3GAMq9
         vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692974492; x=1693579292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/Nyi2UtJHS2L8Ejnis0sIFHEs44gVXKzFV9je3/KrQ=;
        b=COae/jGL/3V+v1cpNpFmNDqji1wV32k75oMfzFufhXwhNFGpbstzaGxkMXHVZ7ynJE
         2fs0IEMbsCCUdof1hMNtenpzgzj6nRZ8b5TGNaCvILeFQlAaeas8O5aNXpAUL0rD7T28
         OaGsAYu1Sb1nj9z68GyKraMkeZ+hocEGswUpFYmQS2eHK6S5gLURZUc9KDUb6tHeU669
         hRJx/1M8HtABj156JzwvvTUElCzzgklRsDQEnXMm4FnZfZuttM8HQFNg2veyklMB+wRQ
         rpYrqlDUtNKDu66Sm1XiVziEsz2ZT4y0KGBrtfpDIL4pzllCPXvHMfO05nM14ysPHf0R
         K6Tw==
X-Gm-Message-State: AOJu0YyPmomdhxDpnPz4PaGUrP9VdsCW1C22yAILJ2BG2Q8OD0alw0DU
        adbm0mkyhyT2dQCNYCVNeA8b5pXq0bC1A8oHnIPaWZ3O
X-Google-Smtp-Source: AGHT+IFTa6AUo8YGThRRtKjSHjpALqvs56DSmtO34KA77It9bSY9eo+tp2QfZnFxYx9KevR2d+AoL9gNtc1jHFksSmA=
X-Received: by 2002:a17:906:cc16:b0:9a1:870e:cc9d with SMTP id
 ml22-20020a170906cc1600b009a1870ecc9dmr14271003ejb.18.1692974492214; Fri, 25
 Aug 2023 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAF6AEGs4p0xXJjsNug45CFiP0n-5h7wpdy22YBryjrnWFROESg@mail.gmail.com>
 <29c7-64e8bc00-3-6afffd8@162524261>
In-Reply-To: <29c7-64e8bc00-3-6afffd8@162524261>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 25 Aug 2023 07:41:19 -0700
Message-ID: <CAF6AEGsdR4XMQ73mwNEE-fntPFLbQrxmzdoWchjReoVXKexdVw@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm: ci: Force db410c to host mode
To:     Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        robdclark@google.com, corbet@lwn.net, khilman@baylibre.com,
        sergi.blanch.torne@collabora.com, gustavo.padovan@collabora.com,
        linux-rockchip@lists.infradead.org, daniels@collabora.com,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        mripard@kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 7:34=E2=80=AFAM Helen Mae Koike Fornazier
<helen.koike@collabora.com> wrote:
>
> On Friday, August 25, 2023 11:30 -03, Rob Clark <robdclark@gmail.com> wro=
te:
>
> > On Fri, Aug 25, 2023 at 6:56=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> > >
> > > On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> wrot=
e:
> > > > Force db410c to host mode to fix network issue which results in fai=
lure
> > > > to mount root fs via NFS.
> > > > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8=
c15c80a54dda510743cefd1c4b65b8
> > > >
> > > > Since this fix is not sent upstream, add it to build.sh script
> > > > before building the kernel and dts. Better approach would be
> > > > to use devicetree overlays.
> > > >
> > > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > > ---
> > > >  drivers/gpu/drm/ci/build.sh | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build=
.sh
> > > > index 7b014287a041..c39834bd6bd7 100644
> > > > --- a/drivers/gpu/drm/ci/build.sh
> > > > +++ b/drivers/gpu/drm/ci/build.sh
> > > > @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
> > > >      fi
> > > >  fi
> > > >
> > > > +# Force db410c to host mode to fix network issue which results in =
failure to mount root fs via NFS.
> > > > +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a62=
9b8c15c80a54dda510743cefd1c4b65b8
> > > > +sed -i '/&usb {/,/status =3D "okay";/s/status =3D "okay";/&\n\tdr_=
mode =3D "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> > > > +
> > >
> > > It seems like a really bad idea to me to have the CI build modify the
> > > source tree before building.
> > >
> > > The kernel being built will have a dirty git repo, and the localversi=
on
> > > will have -dirty in it.
> > >
> > > I think it would be better to do out-of-tree builds and assume the
> > > source is read-only.
> >
> > We have the ${target_branch}-external-fixes mechanism to merge
> > necessary changes before building the kernel for CI.  Which is
> > necessary for a couple of reasons:
>
> Should we create an official topic/drm-ci-external-fixes branch ?

Hmm, maybe.. I guess as we expand this to more driver trees, and want
to be able to re-run CI in the drm tree after merges to
drm-next/drm-fixes, we maybe want to have central
drm-next-external-fixes and drm-fixes-external-fixes.  I guess we can
keep those based on drm-next and drm-fixes?  And if there would be
conflicts because, say, ${driver}-next is behind drm-next, then
${driver}-next could be rebased on drm-next?

BR,
-R

> Regards,
> Helen
>
> >
> > 1) patches like this which aren't appropriate upstream but necessary
> > due to the CI lab setup
> > 2) target branch if often based on an early -rc, and it isn't unheard
> > of to need some fix for some board or another which isn't appropriate
> > to land via drm-next
> >
> > We should use the -external-fixes branch mechanism for patches like thi=
s one.
> >
> > BR,
> > -R
> >
> > > >  for opt in $ENABLE_KCONFIGS; do
> > > >    echo CONFIG_$opt=3Dy >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
> > > >  done
> > >
> > > Ditto for the config changes in the context here. Those are files in
> > > git, don't change them.
> > >
> > > Shouldn't this use something like 'scripts/config --enable' or
> > > 'scripts/config --disable' on the .config file to be used for buildin=
g
> > > instead?
> > >
> > >
> > > BR,
> > > Jani.
> > >
> > >
> > > --
> > > Jani Nikula, Intel Open Source Graphics Center
>
