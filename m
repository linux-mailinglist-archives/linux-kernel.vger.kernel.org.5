Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7587770267
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHDN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHDN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:59:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01ECC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:59:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d16639e16e6so2152257276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691157551; x=1691762351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJuBvH0EIpSoFqEkm/B6EmdRFQqZeZkFyC39as5wyuQ=;
        b=a0AwIpYge7ZpXGBnZ7hAx8NoI0dMDa3j0+DheJnLZ0iPHHyFlKduNUbqX7+aWm/eeY
         fiQuYxr0nXAE5V2ca9rFbuKun6lrGufYUc4dJFV6ADTlzfUir1n0usHCGm0aAVA3djB7
         ylZ5ds/mY7EDUo0t/eC3zKRTWZdouh3076HyeGW9vTrtmssz9HbkApCXcLPoxGDF/I/D
         EtCqZdEsx1S0eyvKAq1b8ARYpgmnrFZGRHYSeLm5yDJnrXxHD/PDvyjpHHlOZ+WUWhdu
         HvFFQblh8Ve0+O4rbTuQU2xXymoekvVk2kjgm4i2VKoycci/Q/Tb9J4XHEIbwcp8j80A
         KJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157551; x=1691762351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJuBvH0EIpSoFqEkm/B6EmdRFQqZeZkFyC39as5wyuQ=;
        b=WvXbaJ51+Y1gFQvGyvHRuBFcxWJmHS4kXuwp9bA2czauLE/UP/xP1TrEVG98ojk/0w
         4wPpcMbXtrdRwCcqbqzZ4p+79TTzCycwVYLZCtuWz3QyvOpPuLsC5I6RInZNqBdaiU4z
         tLOL2Hzm6zpAP2r8lcGnG64Hqq8toOHOJuMcyGs2RErNzV2iXbfDDfKYDpkxEEDPszOd
         tM2KO241qwXEQ5WzY/DbcT0nkdN+sBBdGocsR21TGr78rfJVeKKhL4hWlttkAIp5qP54
         Yprol7uu4iLz5X6/+vZFghkAa3fHx0B/ng6vkFBFPlMOsag4rpDpLZKcJX4W4KT/dJqa
         jcsQ==
X-Gm-Message-State: AOJu0YxzSkWgzTE9OkEE05M2RsWUzI6uvJJXXyUtOidKjBtAMBEzlf/y
        uLoG4bJSTvLQt2LTfBHW5MZXqqAqnAWqe9flfSnlFw==
X-Google-Smtp-Source: AGHT+IEg3icS2up1U2YECkZK61975lB4ZzvrVvkVcezIC6iFuvUc9eDNMeDwecxHjPBtUHO+XEBrIPPy7XH+Aw6sj1U=
X-Received: by 2002:a25:6a82:0:b0:d00:cc5b:8a9f with SMTP id
 f124-20020a256a82000000b00d00cc5b8a9fmr1438160ybc.16.1691157551130; Fri, 04
 Aug 2023 06:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com> <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
 <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
In-Reply-To: <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Aug 2023 16:59:00 +0300
Message-ID: <CAA8EJpoFpUcQL_7pb0toDoLFsK=9GdBLQH+h_MMffrp9k7eCyw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
To:     Sebastian Wick <sebastian.wick@redhat.com>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 at 16:44, Sebastian Wick <sebastian.wick@redhat.com> wro=
te:
>
> On Fri, Aug 4, 2023 at 3:27=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quicinc.com>=
 wrote:
> > >
> > > Document and add support for solid_fill property to drm_plane. In
> > > addition, add support for setting and getting the values for solid_fi=
ll.
> > >
> > > To enable solid fill planes, userspace must assign a property blob to
> > > the "solid_fill" plane property containing the following information:
> > >
> > > struct drm_mode_solid_fill {
> > >         u32 version;
> > >         u32 r, g, b;
> > > };
> > >
> > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> > >  drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++=
++++++++++
> > >  drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
> > >  include/drm/drm_blend.h                   |  1 +
> > >  include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
> > >  include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> > >  6 files changed, 154 insertions(+)
> > >
> >
> > [skipped most of the patch]
> >
> > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.=
h
> > > index 43691058d28f..53c8efa5ad7f 100644
> > > --- a/include/uapi/drm/drm_mode.h
> > > +++ b/include/uapi/drm/drm_mode.h
> > > @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
> > >         char name[DRM_DISPLAY_MODE_LEN];
> > >  };
> > >
> > > +/**
> > > + * struct drm_mode_solid_fill - User info for solid fill planes
> > > + *
> > > + * This is the userspace API solid fill information structure.
> > > + *
> > > + * Userspace can enable solid fill planes by assigning the plane "so=
lid_fill"
> > > + * property to a blob containing a single drm_mode_solid_fill struct=
 populated with an RGB323232
> > > + * color and setting the pixel source to "SOLID_FILL".
> > > + *
> > > + * For information on the plane property, see drm_plane_create_solid=
_fill_property()
> > > + *
> > > + * @version: Version of the blob. Currently, there is only support f=
or version =3D=3D 1
> > > + * @r: Red color value of single pixel
> > > + * @g: Green color value of single pixel
> > > + * @b: Blue color value of single pixel
> > > + */
> > > +struct drm_mode_solid_fill {
> > > +       __u32 version;
> > > +       __u32 r;
> > > +       __u32 g;
> > > +       __u32 b;
> >
> > Another thought about the drm_mode_solid_fill uABI. I still think we
> > should add alpha here. The reason is the following:
> >
> > It is true that we have  drm_plane_state::alpha and the plane's
> > "alpha" property. However it is documented as "the plane-wide opacity
> > [...] It can be combined with pixel alpha. The pixel values in the
> > framebuffers are expected to not be pre-multiplied by the global alpha
> > associated to the plane.".
> >
> > I can imagine a use case, when a user might want to enable plane-wide
> > opacity, set "pixel blend mode" to "Coverage" and then switch between
> > partially opaque framebuffer and partially opaque solid-fill without
> > touching the plane's alpha value.
>
> The only reason I see against this is that there might be some
> hardware which supports only RGB but not alpha on planes and they
> could then not use this property.

Fair enough.

> Maybe another COLOR_FILL enum value
> with alpha might be better? Maybe just doing the alpha via the alpha
> property is good enough.

One of our customers has a use case for setting the opaque solid fill,
while keeping the plane's alpha intact.

--=20
With best wishes
Dmitry
