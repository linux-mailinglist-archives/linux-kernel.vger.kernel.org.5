Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB2788E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHYSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHYSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:16:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD642D44;
        Fri, 25 Aug 2023 11:15:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so1856895e87.1;
        Fri, 25 Aug 2023 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692987339; x=1693592139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/FGw8WTQcGNaVQqRBSGTtSHwW9E63Wb1NNcuS9eK8s=;
        b=OxzC34VYQ/lOuAIJBv07wp6fPeLehLOAi1mU0uJLZSHMKrmj+EwYKRbIIaTKzGM0OD
         FELyHBv8icVGpooaDMH3pX56dJa2Wwqw0V1UOotJHLaAiAGC1WhZgkjwzjb+PigyH2OO
         qFu/a5ucbI3kLN3Rx4zRSLPky+hrc1dteGIHl/xz3OLfM3wEhzCkuhFy8oZFBdcQUsIl
         CetyjZ4N7p2FqAbZhzJxrFNfPtCayDJZ+fEtxSGfa3e621rdXxWjQR+5/+GD5oFVXLKu
         NBQYlM4Z037DJO07cmUfuVuyUIkjCbxMv2CfK1LjPyWxZWSdiHITq0jJPn22qbsZ/miw
         X1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987339; x=1693592139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/FGw8WTQcGNaVQqRBSGTtSHwW9E63Wb1NNcuS9eK8s=;
        b=Sgb+OFHl7TLWecoHO8HA4esRes9UZDQHcqthbz3nbyrU5a/lpw3n5ywNYqaziWH+d0
         yw0U6BavCI0FiQGU/2KZGB9GFRGUVk+vwpK92rd+fvnrMtVtclo0cN8430+383hfMvai
         PhLAcIVEuJZEBzKPizH1BWmaK49Stt4ejEiojCjBh9h4bdNzaSRvDqGsCZrI6S7LCEu1
         NaCkvRKFCJ811B0A5BpUyKv3IxrOlLvJ/m6JhuOX3EHaHMztl97Ikea+JdzTicoiDvFD
         tAMkoY9bxIJ4ZEaDAfz3mRMPA+JV/uJZ3RN2sFb2eMqx+CE68XnPonLJtsP7IKT1UTsc
         smhw==
X-Gm-Message-State: AOJu0YyNnZApcUbunY2yN7M/wVmUJPAOIRwoHxlRVnfa929k67Q2NTAI
        VxhE4WaPS6vkvfZgsZggPSSwBXPG1F5KfQe4ieU=
X-Google-Smtp-Source: AGHT+IHpRCVvS7diQdycBT5DGX0/HZUcX9oDLtQP3DT3UbV1oJ30vCnXpa+uG6GgEKk5nHZkYu+C35njfaJ8/ELaD5A=
X-Received: by 2002:ac2:5f85:0:b0:500:9860:f8a with SMTP id
 r5-20020ac25f85000000b0050098600f8amr5130105lfe.4.1692987338930; Fri, 25 Aug
 2023 11:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAF6AEGsdR4XMQ73mwNEE-fntPFLbQrxmzdoWchjReoVXKexdVw@mail.gmail.com>
 <3f08-64e8c380-3-f083520@11689262>
In-Reply-To: <3f08-64e8c380-3-f083520@11689262>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 25 Aug 2023 11:15:26 -0700
Message-ID: <CAF6AEGtzfEFpr610c8TdLAH_zEYEtXzt61ywQTcFbvCOj-G9-A@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 8:06=E2=80=AFAM Helen Mae Koike Fornazier
<helen.koike@collabora.com> wrote:
>
> On Friday, August 25, 2023 11:41 -03, Rob Clark <robdclark@gmail.com> wro=
te:
>
> > On Fri, Aug 25, 2023 at 7:34=E2=80=AFAM Helen Mae Koike Fornazier
> > <helen.koike@collabora.com> wrote:
> > >
> > > On Friday, August 25, 2023 11:30 -03, Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > > On Fri, Aug 25, 2023 at 6:56=E2=80=AFAM Jani Nikula <jani.nikula@li=
nux.intel.com> wrote:
> > > > >
> > > > > On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> =
wrote:
> > > > > > Force db410c to host mode to fix network issue which results in=
 failure
> > > > > > to mount root fs via NFS.
> > > > > > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a6=
29b8c15c80a54dda510743cefd1c4b65b8
> > > > > >
> > > > > > Since this fix is not sent upstream, add it to build.sh script
> > > > > > before building the kernel and dts. Better approach would be
> > > > > > to use devicetree overlays.
> > > > > >
> > > > > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/ci/build.sh | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/b=
uild.sh
> > > > > > index 7b014287a041..c39834bd6bd7 100644
> > > > > > --- a/drivers/gpu/drm/ci/build.sh
> > > > > > +++ b/drivers/gpu/drm/ci/build.sh
> > > > > > @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; =
then
> > > > > >      fi
> > > > > >  fi
> > > > > >
> > > > > > +# Force db410c to host mode to fix network issue which results=
 in failure to mount root fs via NFS.
> > > > > > +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb7=
2a629b8c15c80a54dda510743cefd1c4b65b8
> > > > > > +sed -i '/&usb {/,/status =3D "okay";/s/status =3D "okay";/&\n\=
tdr_mode =3D "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> > > > > > +
> > > > >
> > > > > It seems like a really bad idea to me to have the CI build modify=
 the
> > > > > source tree before building.
> > > > >
> > > > > The kernel being built will have a dirty git repo, and the localv=
ersion
> > > > > will have -dirty in it.
> > > > >
> > > > > I think it would be better to do out-of-tree builds and assume th=
e
> > > > > source is read-only.
> > > >
> > > > We have the ${target_branch}-external-fixes mechanism to merge
> > > > necessary changes before building the kernel for CI.  Which is
> > > > necessary for a couple of reasons:
> > >
> > > Should we create an official topic/drm-ci-external-fixes branch ?
> >
> > Hmm, maybe.. I guess as we expand this to more driver trees, and want
> > to be able to re-run CI in the drm tree after merges to
> > drm-next/drm-fixes, we maybe want to have central
> > drm-next-external-fixes and drm-fixes-external-fixes.  I guess we can
> > keep those based on drm-next and drm-fixes?  And if there would be
> > conflicts because, say, ${driver}-next is behind drm-next, then
> > ${driver}-next could be rebased on drm-next?
> >
>
> tbh this is one of the reasons I would prefer in-code fixes instead of
> commits on a -external-fixes branch, since it seems things start to becom=
e
> complex to manage all different trees for people executing ci tests
> on different history points, but I don't oppose going for -external-fixes
> either.

If by in-code you mean in the same branch that we are running CI on, I
think that will be difficult to do without having force-pushes later
to remove the unrelated patch.

It doesn't happen every release, but sometimes there is an issue
requiring a fix outside of drm, which really shouldn't land via
drm-next.  In some cases even, we might need a temporary hack fix when
a proper solution is still being worked out.  Since the kernel
development is unlike mesa, where we have a single main branch and CI
runs on every change entering that main branch, we are going to have
to deal occasionally with breakage that comes in via another tree that
isn't running CI.  But IME so far with msm-next-external-fixes, it
hasn't been so bad.. I haven't even had to rebase it every kernel
cycle.  (If the fix cherry-picked into -external-fixes from a previous
release cycle already exists in msm-next then the merge of that commit
is a no-op.)

BR,
-R

> Regards,
> Helen
>
> > BR,
> > -R
> >
> > > Regards,
> > > Helen
> > >
> > > >
> > > > 1) patches like this which aren't appropriate upstream but necessar=
y
> > > > due to the CI lab setup
> > > > 2) target branch if often based on an early -rc, and it isn't unhea=
rd
> > > > of to need some fix for some board or another which isn't appropria=
te
> > > > to land via drm-next
> > > >
> > > > We should use the -external-fixes branch mechanism for patches like=
 this one.
> > > >
> > > > BR,
> > > > -R
> > > >
> > > > > >  for opt in $ENABLE_KCONFIGS; do
> > > > > >    echo CONFIG_$opt=3Dy >> drivers/gpu/drm/ci/${KERNEL_ARCH}.co=
nfig
> > > > > >  done
> > > > >
> > > > > Ditto for the config changes in the context here. Those are files=
 in
> > > > > git, don't change them.
> > > > >
> > > > > Shouldn't this use something like 'scripts/config --enable' or
> > > > > 'scripts/config --disable' on the .config file to be used for bui=
lding
> > > > > instead?
> > > > >
> > > > >
> > > > > BR,
> > > > > Jani.
> > > > >
> > > > >
> > > > > --
> > > > > Jani Nikula, Intel Open Source Graphics Center
> > >
>
