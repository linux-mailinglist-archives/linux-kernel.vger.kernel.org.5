Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781E780A84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjHRKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376445AbjHRKvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:51:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCB30F5;
        Fri, 18 Aug 2023 03:51:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so1089228e87.2;
        Fri, 18 Aug 2023 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692355909; x=1692960709;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkeICbNdfxJsBWI7sD4bsVRnOby+SBnRlBrjmgj38YY=;
        b=bCoN9c9sk4XAZ1BQgK41E9SayBbdc+V7sZhlpuyhP1ewtQPB8+gW10JIg/kU/F6o+6
         M6x+meIRrn/CWZisxKubEDffISXUHZklOrIOoyXhYe+9I/Va4fQACGf8Ewf5gvMnQHoa
         fC/1SscxQIGFxwTTPS0PBq0igH8MZrHtJoIa3Uk+usEAs+U0b6Rq/ujItsPKhGP+NN0g
         3sqFjmfAFV3UXgtUCvYxwUnEvi64SmeqL1RrO8jTIsmLs6U8NFBJKUEzVwV4+wSIFajC
         L5WMqPV9byXjcHGL7APJhFHa9Lp9lM9BlKlBx7/CBeowWAUNVogomNkdDaNmfJjw5DgP
         DzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692355909; x=1692960709;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkeICbNdfxJsBWI7sD4bsVRnOby+SBnRlBrjmgj38YY=;
        b=jyDEFgvAXxgUPVj0yZjnbI9TL0uWig0hky3vnwctW/es2q4e6kzUII9g6R0VEEWMvJ
         PUXBkOUMihDh1oK3mHbcWm9BYaFxdxa5rmKkYeFRCEySm823iC8eeotXIZYw0qTd5+bb
         JM17UVUkS2XBOIOHQSLxa7WYF49XzeWO2e3KnV+hkCTLFXQKryuzPGCX3qBZcUR2MkNW
         l6iP+ZT86yHUgDKOhZ3pYF98AXqFOLieaqDlOr7aQdXhhTrv4hRdLnkuuKWWuvWLJBtf
         vWphFjWkvlyLhIHaAkW1orLCURNMidCm/zhYXlg8pxcMmhnX5iW3cxjoBpke0M6TDo1+
         r13A==
X-Gm-Message-State: AOJu0YwH2SskMdu8tdn8uxnrL1NSVKNN3GQbQDSvDCU342Zu3EbejUyZ
        bp0QKcueqkDaydWY5BBHEUc=
X-Google-Smtp-Source: AGHT+IHk/C/1Je9Ar+GDssePJWr5JIjySkW3mkRzF+sXJC6OPdOOEFDfukYJEgi7yOVcgrmtvWTRgw==
X-Received: by 2002:a05:6512:3ba5:b0:4f8:4512:c844 with SMTP id g37-20020a0565123ba500b004f84512c844mr2065735lfv.48.1692355909245;
        Fri, 18 Aug 2023 03:51:49 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id g1-20020ac25381000000b004ff8cf787cbsm290098lfh.125.2023.08.18.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:51:48 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:51:33 +0300
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
Message-ID: <20230818135133.3fdeddba@eldfell>
In-Reply-To: <CAA8EJpoFpUcQL_7pb0toDoLFsK=9GdBLQH+h_MMffrp9k7eCyw@mail.gmail.com>
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
        <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
        <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
        <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
        <CAA8EJpoFpUcQL_7pb0toDoLFsK=9GdBLQH+h_MMffrp9k7eCyw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2O=Q20cfS_1km8U=i7GOGD9";
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

--Sig_/2O=Q20cfS_1km8U=i7GOGD9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Aug 2023 16:59:00 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Fri, 4 Aug 2023 at 16:44, Sebastian Wick <sebastian.wick@redhat.com> w=
rote:
> >
> > On Fri, Aug 4, 2023 at 3:27=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote: =20
> > >
> > > On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quicinc.co=
m> wrote: =20
> > > >
> > > > Document and add support for solid_fill property to drm_plane. In
> > > > addition, add support for setting and getting the values for solid_=
fill.
> > > >
> > > > To enable solid fill planes, userspace must assign a property blob =
to
> > > > the "solid_fill" plane property containing the following informatio=
n:
> > > >
> > > > struct drm_mode_solid_fill {
> > > >         u32 version;
> > > >         u32 r, g, b;
> > > > };
> > > >
> > > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> > > >  drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++=
++++++++++++
> > > >  drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
> > > >  include/drm/drm_blend.h                   |  1 +
> > > >  include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
> > > >  include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> > > >  6 files changed, 154 insertions(+)
> > > > =20
> > >
> > > [skipped most of the patch]
> > > =20
> > > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mod=
e.h
> > > > index 43691058d28f..53c8efa5ad7f 100644
> > > > --- a/include/uapi/drm/drm_mode.h
> > > > +++ b/include/uapi/drm/drm_mode.h
> > > > @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
> > > >         char name[DRM_DISPLAY_MODE_LEN];
> > > >  };
> > > >
> > > > +/**
> > > > + * struct drm_mode_solid_fill - User info for solid fill planes
> > > > + *
> > > > + * This is the userspace API solid fill information structure.
> > > > + *
> > > > + * Userspace can enable solid fill planes by assigning the plane "=
solid_fill"
> > > > + * property to a blob containing a single drm_mode_solid_fill stru=
ct populated with an RGB323232
> > > > + * color and setting the pixel source to "SOLID_FILL".
> > > > + *
> > > > + * For information on the plane property, see drm_plane_create_sol=
id_fill_property()
> > > > + *
> > > > + * @version: Version of the blob. Currently, there is only support=
 for version =3D=3D 1
> > > > + * @r: Red color value of single pixel
> > > > + * @g: Green color value of single pixel
> > > > + * @b: Blue color value of single pixel
> > > > + */
> > > > +struct drm_mode_solid_fill {
> > > > +       __u32 version;
> > > > +       __u32 r;
> > > > +       __u32 g;
> > > > +       __u32 b; =20
> > >
> > > Another thought about the drm_mode_solid_fill uABI. I still think we
> > > should add alpha here. The reason is the following:
> > >
> > > It is true that we have  drm_plane_state::alpha and the plane's
> > > "alpha" property. However it is documented as "the plane-wide opacity
> > > [...] It can be combined with pixel alpha. The pixel values in the
> > > framebuffers are expected to not be pre-multiplied by the global alpha
> > > associated to the plane.".
> > >
> > > I can imagine a use case, when a user might want to enable plane-wide
> > > opacity, set "pixel blend mode" to "Coverage" and then switch between
> > > partially opaque framebuffer and partially opaque solid-fill without
> > > touching the plane's alpha value. =20
> >
> > The only reason I see against this is that there might be some
> > hardware which supports only RGB but not alpha on planes and they
> > could then not use this property. =20
>=20
> Fair enough.
>=20
> > Maybe another COLOR_FILL enum value
> > with alpha might be better? Maybe just doing the alpha via the alpha
> > property is good enough. =20
>=20
> One of our customers has a use case for setting the opaque solid fill,
> while keeping the plane's alpha intact.

Could you explain more about why they must keep plane alpha intact
instead of reprogramming everything with atomic? Is there some
combination that just cannot reach the same end result via userspace
manipulation of the solid fill values with plane alpha?

Or is it a matter of userspace architecture where you have independent
components responsible for different KMS property values?


Thanks,
pq

--Sig_/2O=Q20cfS_1km8U=i7GOGD9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTfTTUACgkQI1/ltBGq
qqcVahAAk81/dxiCTJQmQ/4ep7SBcUer1Fg/PYKUcGTuPcR9ieYQBIsKKCPThjTU
Vpt99KGwvaPx/zvnEwIKdrA7f/5Y5JTYxSEhcjdt82yqEjE4zWbnSgF1pXbM6tln
IFwCyjeaANKqimKPyYoMGnf4bB5A9GoXS4dv6Uj2mfm0SLzuRPcwwu2LZ+LTPpzj
30mgEq0nLN77FwMOHwEKXJaDHkNTuqmbgCwcplD3kCFJMM1ghvoJ3fUkCW5sNzJq
ReBYkbW091cRYNmfWwv8OUQ8Gim3BQLXq1qMzqowzuqPqQXJBeUbRYoh5CYkdjZG
hN7HiUkSGzdeKhkvFjVgnfGK+LRhgGBjiS2gOYZCtEmEG485jcBGEkjSEt8dB8z0
sHDMhqqT5V7m3M17DM6ARiZbcyzgTJpwpIJoExRle1L6XyBCEgUDWcB0S8tM5sFo
3SKhsDVhJvkYHKirpIc/SjrjsDBH7CsJL74hjfd2rAANBSEQZtzpyW7xCfz7tQTa
Qyjcm7zkD6E3RHCAfR077MFn/OMNHGXYI1eTRm/W6hZJ0yXyjLwMEPKSZV9WbcHd
O3dLutN1XojGBJe1ULMwG76zHO3iU0L4uOJZJUaTicNbn939vfko3kgBZzfImafb
d6HsAcLpwtYcK88IShe3Y+p1WYNY2GdV6PcFAOO8rd3AhwQ/ZcM=
=U13j
-----END PGP SIGNATURE-----

--Sig_/2O=Q20cfS_1km8U=i7GOGD9--
