Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B8783B09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjHVHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHVHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:36:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D02116;
        Tue, 22 Aug 2023 00:36:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so64359401fa.3;
        Tue, 22 Aug 2023 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692689783; x=1693294583;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9JeEI9pOPqa5N1VgvwdS9ACilzFYTp6dHc4PCAx9Qc=;
        b=UMiILeRWTNCJkBAHo8GseVLLu5rTf5L9fCSimEejkf12w0W6VxE6HE+wdx8YcAiJOk
         vWB7BMzwA4tB3/RDiIi482h+hDHN67Ja6YECjSb2GO88dKy6Ip7HvmKI2xKYMYozDTrT
         BhQpU7sGNg0dn5re3b/uT2qSSvE/ezigFO1zGKTDjCDQWaqmrUropLh1BM8579LxOEB5
         lFuAjbGtt2tX9ui4ct3gkXBHEhSV4AunBQB77JbfrYl7LJYYPe/MmFHeY0TjSnVB+vOm
         wB8FK2EinGMUiCXy8VA/EHeaUBXAsa5JID/HuwlzlhE01fSAJZRg9OQ1JbNLOBLpLxSJ
         1kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692689783; x=1693294583;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9JeEI9pOPqa5N1VgvwdS9ACilzFYTp6dHc4PCAx9Qc=;
        b=IMP7wth7JwqpoQX9vlhvf3RbVuM+ZGf7loicNmdUICpqLAn50aDT/zzqV6uBk8Rvcx
         ZRwRFnaf38FsOncC2tc8Xfssoqx2RF4bZ1GLAcbA+yA9M8IvKEed33XQqGtl5ouoYDbr
         coWllRlypszWaPt5wGbRTuu/0nMuh86T3ahEvj39gcXdd1O0VaV3Is1dQZq29hwSC0Up
         vu1gOqn8t/A7TTdpYTCkKG3AJdlMpA0b+jvGErdat1TK9SzSgZNt1615aQ7vfxeBRczR
         1l4Do0ok0RI5DekvTPfciNCRDi3DOO12+Acj6n2o629rsVPF46oVyglZTsJ2cyn+KMhH
         1hZQ==
X-Gm-Message-State: AOJu0YyVgoi08sfx9sij778ehabQCuBRvBVOeqTXAI7YET4rYRbVhZ3H
        hFY/vliKqje2hw6ghJxnAzE=
X-Google-Smtp-Source: AGHT+IEpQ081i3Xmv5BSGFbBOCsDUkDBF6QAJ9kaLTyxTXqF8yU44YUSsUgdGZUhv57gdHuQVXG1ow==
X-Received: by 2002:a2e:991a:0:b0:2bb:75d1:b77e with SMTP id v26-20020a2e991a000000b002bb75d1b77emr7251155lji.42.1692689782330;
        Tue, 22 Aug 2023 00:36:22 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id w5-20020a2e3005000000b002b736576a10sm2612239ljw.137.2023.08.22.00.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:36:22 -0700 (PDT)
Date:   Tue, 22 Aug 2023 10:36:11 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sebastian Wick <sebastian.wick@redhat.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, contact@emersion.fr,
        laurent.pinchart@ideasonboard.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane
 property
Message-ID: <20230822103611.4ec51594@eldfell>
In-Reply-To: <CAA8EJpqigb8OJ-u7W9VeZtXp5rhXyU30_5wALeUDsf+rhe-kEA@mail.gmail.com>
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
        <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
        <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
        <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
        <CAA8EJpoFpUcQL_7pb0toDoLFsK=9GdBLQH+h_MMffrp9k7eCyw@mail.gmail.com>
        <20230818135133.3fdeddba@eldfell>
        <c4b7e9eb-fb5d-4b2f-8358-f41598d7d983@linaro.org>
        <20230818165500.50360195@eldfell>
        <CAA8EJpqigb8OJ-u7W9VeZtXp5rhXyU30_5wALeUDsf+rhe-kEA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VCSstBMwRfc91OS4YUbYmwc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VCSstBMwRfc91OS4YUbYmwc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Aug 2023 17:30:21 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Fri, 18 Aug 2023 at 16:55, Pekka Paalanen <ppaalanen@gmail.com> wrote:
> >
> > On Fri, 18 Aug 2023 14:03:14 +0300
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > =20
> > > On 18/08/2023 13:51, Pekka Paalanen wrote: =20
> > > > On Fri, 4 Aug 2023 16:59:00 +0300
> > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > > =20
> > > >> On Fri, 4 Aug 2023 at 16:44, Sebastian Wick <sebastian.wick@redhat=
.com> wrote: =20
> > > >>>
> > > >>> On Fri, Aug 4, 2023 at 3:27=E2=80=AFPM Dmitry Baryshkov
> > > >>> <dmitry.baryshkov@linaro.org> wrote: =20
> > > >>>>
> > > >>>> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quici=
nc.com> wrote: =20
> > > >>>>>
> > > >>>>> Document and add support for solid_fill property to drm_plane. =
In
> > > >>>>> addition, add support for setting and getting the values for so=
lid_fill.
> > > >>>>>
> > > >>>>> To enable solid fill planes, userspace must assign a property b=
lob to
> > > >>>>> the "solid_fill" plane property containing the following inform=
ation:
> > > >>>>>
> > > >>>>> struct drm_mode_solid_fill {
> > > >>>>>          u32 version;
> > > >>>>>          u32 r, g, b;
> > > >>>>> };
> > > >>>>>
> > > >>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > >>>>> ---
> > > >>>>>   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> > > >>>>>   drivers/gpu/drm/drm_atomic_uapi.c         | 55 ++++++++++++++=
+++++++++++++++++
> > > >>>>>   drivers/gpu/drm/drm_blend.c               | 30 ++++++++++++++=
+++
> > > >>>>>   include/drm/drm_blend.h                   |  1 +
> > > >>>>>   include/drm/drm_plane.h                   | 35 ++++++++++++++=
++++++
> > > >>>>>   include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> > > >>>>>   6 files changed, 154 insertions(+)
> > > >>>>> =20
> > > >>>>
> > > >>>> [skipped most of the patch] =20
> >
> > ...
> > =20
> > > >>> Maybe another COLOR_FILL enum value
> > > >>> with alpha might be better? Maybe just doing the alpha via the al=
pha
> > > >>> property is good enough. =20
> > > >>
> > > >> One of our customers has a use case for setting the opaque solid f=
ill,
> > > >> while keeping the plane's alpha intact. =20
> > > >
> > > > Could you explain more about why they must keep plane alpha intact
> > > > instead of reprogramming everything with atomic? Is there some
> > > > combination that just cannot reach the same end result via userspace
> > > > manipulation of the solid fill values with plane alpha?
> > > >
> > > > Or is it a matter of userspace architecture where you have independ=
ent
> > > > components responsible for different KMS property values? =20
> > =20
> > > The latter one. The goal is to be able to switch between pixel sources
> > > without touching any additional properties (including plane's alpha v=
alue). =20
> >
> > Sorry, but that does not seem like a good justification for KMS UAPI
> > design.
> >
> > It is even in conflict with how atomic KMS UAPI was designed to work:
> > collect all your changes into a single commit, and push it at once.
> > Here we are talking about separate components changing the different
> > properties of the same KMS plane even. If you want to change both plane
> > opacity and contents, does it mean you need two refresh cycles, one at
> > a time? Could the two components be even racing with each other,
> > stalling each other randomly? =20
>=20
> Most likely I was not verbose enough.
>=20
> We want to setup the blending scene, including the FB and the solid
> fill properties for the plane. FB is set up in the RGBA format, each
> pixel having its own alpha value in addition to the plane's alpha
> value. Then under certain circumstances, the plane gets hidden by the
> solid fill (think of a curtain). We do not want to touch the global
> scene setup (including plane alpha value), just switch the curtain on
> and off.
> I think this plays good enough with the defined plane blending rules,
> where one can use pre-multiplied blending mode or use coverage
> blending mode.

Right, that's what I understood. But this does complicate the KMS UAPI
for something that is well possible and feasible without the added
complication as well.

Is there a hardware or driver reason to avoid touching the global scene
setup? Does something in the hardware or driver work more optimally
that way?

Personally I'd favour simpler UAPI with more complex userspace for
maintainability and testing reasons. I'd also favour UAPI that exposes
common hardware features instead of design driven by userspace
process-internal architecture. There does not seem to be any
functionality or performance reasons to justify adding alpha channel to
the solid fill color.

OTOH, do we know of hardware that does not have separate alpha for the
fill color?

Do we know of hardware that can only do opaque solid fills, meaning no
alpha in the fill color nor for the plane?

What about hardware that has no plane alpha, but does have fill color
alpha?

If the plane has an alpha property, then drivers could implement fill
color alpha by combining the two alpha values before programming the
hardware. If there is no plane alpha, but there is fill color alpha, it
would be really awkward to expose a fake plane alpha because it would
only work with fill color.

Assuming that all those combinations exist in hardware, then separate
fill colors without and with alpha make sense, advertised independently.


Thanks,
pq

--Sig_/VCSstBMwRfc91OS4YUbYmwc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTkZWwACgkQI1/ltBGq
qqfCVhAAsAwplE2EE2aUfSuv5n8N5nGIQZvyhd6oXh/oUZFhSRlns456VGSkOFBR
aFxeJiLOuojYJVL8rQFIYBjk2qzCb4Oonyul23slNkT+c5MtUk2REuey2NJZ401p
tfHvDGviiGtbKW/ieEuLT9AJkQRCA7DRgaQLdWfvKNgQlyd1xugRKgn1vzHlEx9T
rYsRhduImIyxRlhJjdOfYuGA3OGteP+WIySKZzI1dNe3clDQYCq+C2WFh2Oul71Y
hFNaWRKRuNVUf0xzEuvAsXWmhQ1eT3KizaAXkzkz0S6myYEpSJ4CY4oqvRRKNJit
oSCb0JN05h1icNkbXimq90Fn1PtRtcScbJNH7fa1WWoKEfkD0jcfU7mQVfidACwC
8esNNTUSUwuTUSUVyaXYpc4Cg9jCGgCOn1ICSJdiHuxwx6zhJj3BLjI2SofubIj6
u3F5S7G7AA63STn7dkXvFjH4yTmZYzKl2loJVYYgB04uTjDtcsB5FSQx+HbPSIMg
D5Nil/AEakxvrS5P0BMe3EVvAeYjWZtgiHY3/nAr+BSrzGJ6l2b6+9DmXeXILcBj
nHss51EAdA0LzSiTRk3qCKnCHXANvKVgeU+Pjv8G5HD94E+4bS7cOj/LquybuXxJ
DI6RKCetZ0HixpSpRg4Nr9zZCeZ9tm7PURDGfh/271ZzMRKe1Vw=
=Lf23
-----END PGP SIGNATURE-----

--Sig_/VCSstBMwRfc91OS4YUbYmwc--
