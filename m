Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6777418E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjHHRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjHHRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D577D786
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691510922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVuCFjdJcVT8JMbGrbvzk+njXdiWTuw1wj4t/nxixDc=;
        b=FvkAPhiRI1hBZmIynKhGZUcIvaTfJ6ag7cWytZ5WXPwoHyXFpnB2e8IStNt5t9kjreeeYi
        JmG6zzChJo18qvhTUJkO8oxffr3N51zbCiVSwuaEN/0R3yPcseDdMA5cvt6Tkl++I4LVIX
        bQC1tjYsWr5SDz4JUClQEVphjhytQA0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-cLMNZ69JN1-c1tSadmFgEQ-1; Tue, 08 Aug 2023 08:06:02 -0400
X-MC-Unique: cLMNZ69JN1-c1tSadmFgEQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe0e1dfdbaso5469374e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 05:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691496360; x=1692101160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVuCFjdJcVT8JMbGrbvzk+njXdiWTuw1wj4t/nxixDc=;
        b=Q9oX1v6OH/xtoRkZqhEXrOd3BTf/o/JzxljgWYwHbTuQZDY+iu5NBC2jUAiuFpmWrP
         eSBYH0X49LTOWLUPnX1qG1W0X0gnNRxbqc2d1d+B04jwvk/PY+F+FeBqqQn1B2oidPTJ
         aIv6n9vOsEB78xX+MrIkNaBXptd2qsqLpw+dxNX1PzJajJq4LN+uZr84rZVNwlEwJqQl
         RCAh2nYY9e7Ly0bs/9rbPUVcJ8zZg4OEWlm0QD2Dp9gcdpP04ajzZ0aG/m6aL03clVyu
         UqwsuX7cSXpIlLMT1mwXGnHEMZMoA+sxgqFSLahxaVjimGRkO8XtjfpfM+vGW87TwUGF
         bUAg==
X-Gm-Message-State: AOJu0Yz3KfVmVxwvX3nP+nNi7QcVb6wUIQYv/3vOmK8OxBYebzGauRh1
        zlj4Zwg4ZX3R/06SLcPXm4aHl2o3XD7rOL5YnBlOTt3wx/seLlxvu6QDgW8Dl71DSWcrNzQMtDJ
        P0KSjyFe38nnP2xXstu6h/t5EumpZk8Adkhs8J8YL
X-Received: by 2002:a05:6512:31c7:b0:4fd:fc36:68a2 with SMTP id j7-20020a05651231c700b004fdfc3668a2mr7965616lfe.1.1691496360154;
        Tue, 08 Aug 2023 05:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhnLeTE8WqeViIx7SXQVaYVyeppCRK13xcg7l4wcYFiSlrkv0ka6P5Z6WrJPz7QaVdDhqAj2JKI7NLgZNtbmc=
X-Received: by 2002:a05:6512:31c7:b0:4fd:fc36:68a2 with SMTP id
 j7-20020a05651231c700b004fdfc3668a2mr7965593lfe.1.1691496359781; Tue, 08 Aug
 2023 05:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-1-053dbefa909c@quicinc.com> <CA+hFU4ywNbK77Nj+AVkRbgnomyP-YHhP6pKvNhFG-6HXwAY=Yw@mail.gmail.com>
 <71e9cc67-3aed-f1b7-33b7-1bf9faa0d6ae@quicinc.com>
In-Reply-To: <71e9cc67-3aed-f1b7-33b7-1bf9faa0d6ae@quicinc.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Tue, 8 Aug 2023 14:05:48 +0200
Message-ID: <CA+hFU4wJ5xtVT_Yunc7r7c9eKaGus0Ew1_XnoDg1vMQRF0OQ0w@mail.gmail.com>
Subject: Re: [PATCH RFC v5 01/10] drm: Introduce pixel_source DRM plane property
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 7:52=E2=80=AFPM Jessica Zhang <quic_jesszhan@quicinc=
.com> wrote:
>
>
>
> On 8/4/2023 6:15 AM, Sebastian Wick wrote:
> > On Fri, Jul 28, 2023 at 7:03=E2=80=AFPM Jessica Zhang <quic_jesszhan@qu=
icinc.com> wrote:
> >>
> >> Add support for pixel_source property to drm_plane and related
> >> documentation. In addition, force pixel_source to
> >> DRM_PLANE_PIXEL_SOURCE_FB in DRM_IOCTL_MODE_SETPLANE as to not break
> >> legacy userspace.
> >>
> >> This enum property will allow user to specify a pixel source for the
> >> plane. Possible pixel sources will be defined in the
> >> drm_plane_pixel_source enum.
> >>
> >> The current possible pixel sources are DRM_PLANE_PIXEL_SOURCE_NONE and
> >> DRM_PLANE_PIXEL_SOURCE_FB with *_PIXEL_SOURCE_FB being the default val=
ue.
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
> >>   drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
> >>   drivers/gpu/drm/drm_blend.c               | 85 +++++++++++++++++++++=
++++++++++
> >>   drivers/gpu/drm/drm_plane.c               |  3 ++
> >>   include/drm/drm_blend.h                   |  2 +
> >>   include/drm/drm_plane.h                   | 21 ++++++++
> >>   6 files changed, 116 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/d=
rm/drm_atomic_state_helper.c
> >> index 784e63d70a42..01638c51ce0a 100644
> >> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> >> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> >> @@ -252,6 +252,7 @@ void __drm_atomic_helper_plane_state_reset(struct =
drm_plane_state *plane_state,
> >>
> >>          plane_state->alpha =3D DRM_BLEND_ALPHA_OPAQUE;
> >>          plane_state->pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
> >> +       plane_state->pixel_source =3D DRM_PLANE_PIXEL_SOURCE_FB;
> >>
> >>          if (plane->color_encoding_property) {
> >>                  if (!drm_object_property_get_default_value(&plane->ba=
se,
> >> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_a=
tomic_uapi.c
> >> index d867e7f9f2cd..454f980e16c9 100644
> >> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> >> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> >> @@ -544,6 +544,8 @@ static int drm_atomic_plane_set_property(struct dr=
m_plane *plane,
> >>                  state->src_w =3D val;
> >>          } else if (property =3D=3D config->prop_src_h) {
> >>                  state->src_h =3D val;
> >> +       } else if (property =3D=3D plane->pixel_source_property) {
> >> +               state->pixel_source =3D val;
> >>          } else if (property =3D=3D plane->alpha_property) {
> >>                  state->alpha =3D val;
> >>          } else if (property =3D=3D plane->blend_mode_property) {
> >> @@ -616,6 +618,8 @@ drm_atomic_plane_get_property(struct drm_plane *pl=
ane,
> >>                  *val =3D state->src_w;
> >>          } else if (property =3D=3D config->prop_src_h) {
> >>                  *val =3D state->src_h;
> >> +       } else if (property =3D=3D plane->pixel_source_property) {
> >> +               *val =3D state->pixel_source;
> >>          } else if (property =3D=3D plane->alpha_property) {
> >>                  *val =3D state->alpha;
> >>          } else if (property =3D=3D plane->blend_mode_property) {
> >> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> >> index 6e74de833466..c500310a3d09 100644
> >> --- a/drivers/gpu/drm/drm_blend.c
> >> +++ b/drivers/gpu/drm/drm_blend.c
> >> @@ -185,6 +185,21 @@
> >>    *              plane does not expose the "alpha" property, then thi=
s is
> >>    *              assumed to be 1.0
> >>    *
> >> + * pixel_source:
> >> + *     pixel_source is set up with drm_plane_create_pixel_source_prop=
erty().
> >> + *     It is used to toggle the active source of pixel data for the p=
lane.
> >> + *     The plane will only display data from the set pixel_source -- =
any
> >> + *     data from other sources will be ignored.
> >> + *
> >> + *     Possible values:
> >> + *
> >> + *     "NONE":
> >> + *             No active pixel source.
> >> + *             Committing with a NONE pixel source will disable the p=
lane.
> >> + *
> >> + *     "FB":
> >> + *             Framebuffer source set by the "FB_ID" property.
> >> + *
> >>    * Note that all the property extensions described here apply either=
 to the
> >>    * plane or the CRTC (e.g. for the background color, which currently=
 is not
> >>    * exposed and assumed to be black).
> >> @@ -615,3 +630,73 @@ int drm_plane_create_blend_mode_property(struct d=
rm_plane *plane,
> >>          return 0;
> >>   }
> >>   EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
> >> +
> >> +/**
> >> + * drm_plane_create_pixel_source_property - create a new pixel source=
 property
> >> + * @plane: DRM plane
> >> + * @extra_sources: Bitmask of additional supported pixel_sources for =
the driver.
> >> + *                DRM_PLANE_PIXEL_SOURCE_FB always be enabled as a su=
pported
> >> + *                source.
> >> + *
> >> + * This creates a new property describing the current source of pixel=
 data for the
> >> + * plane. The pixel_source will be initialized as DRM_PLANE_PIXEL_SOU=
RCE_FB by default.
> >> + *
> >> + * Drivers can set a custom default source by overriding the pixel_so=
urce value in
> >> + * drm_plane_funcs.reset()
> >> + *
> >> + * The property is exposed to userspace as an enumeration property ca=
lled
> >> + * "pixel_source" and has the following enumeration values:
> >> + *
> >> + * "NONE":
> >> + *      No active pixel source
> >> + *
> >> + * "FB":
> >> + *     Framebuffer pixel source
> >> + *
> >> + * Returns:
> >> + * Zero on success, negative errno on failure.
> >> + */
> >> +int drm_plane_create_pixel_source_property(struct drm_plane *plane,
> >> +                                          unsigned long extra_sources=
)
> >> +{
> >> +       struct drm_device *dev =3D plane->dev;
> >> +       struct drm_property *prop;
> >> +       static const struct drm_prop_enum_list enum_list[] =3D {
> >> +               { DRM_PLANE_PIXEL_SOURCE_NONE, "NONE" },
> >> +               { DRM_PLANE_PIXEL_SOURCE_FB, "FB" },
> >> +       };
> >> +       static const unsigned int valid_source_mask =3D BIT(DRM_PLANE_=
PIXEL_SOURCE_FB);
> >> +       int i;
> >> +
> >> +       /* FB is supported by default */
> >> +       unsigned long supported_sources =3D extra_sources | BIT(DRM_PL=
ANE_PIXEL_SOURCE_FB);
> >
> > The DRM_PLANE_PIXEL_SOURCE_NONE property should also be enabled by
> > default and in the valid_source_mask.
>
> Hi Sebastian,
>
> Acked.
>
>
> > In a later patch you implement
> > the DRM_PLANE_PIXEL_SOURCE_NONE logic in drm core so everyone gets the
> > enum value for free. Might want to pull that logic into its own patch
> > and move it before this one.
>
> Can you elaborate on this? Are you referring to the "Loosen FB atomic
> checks" patch?
>
> Not sure why it would make sense to loosen the checks before non-FB
> pixel sources are introduced.

Mh, yeah, but just adding the enum value which is not hooked up is not
good either. Both should probably happen in the same patch.

> Thanks,
>
> Jessica Zhang
>
> >
> >> +
> >> +       if (WARN_ON(supported_sources & ~valid_source_mask))
> >> +               return -EINVAL;
> >> +
> >> +       prop =3D drm_property_create(dev, DRM_MODE_PROP_ENUM | DRM_MOD=
E_PROP_ATOMIC, "pixel_source",
> >> +                       hweight32(supported_sources));
> >> +
> >> +       if (!prop)
> >> +               return -ENOMEM;
> >> +
> >> +       for (i =3D 0; i < ARRAY_SIZE(enum_list); i++) {
> >> +               int ret;
> >> +
> >> +               if (!test_bit(enum_list[i].type, &supported_sources))
> >> +                       continue;
> >> +
> >> +               ret =3D drm_property_add_enum(prop, enum_list[i].type,=
 enum_list[i].name);
> >> +               if (ret) {
> >> +                       drm_property_destroy(dev, prop);
> >> +
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >> +       drm_object_attach_property(&plane->base, prop, DRM_PLANE_PIXEL=
_SOURCE_FB);
> >> +       plane->pixel_source_property =3D prop;
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
> >> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> >> index 24e7998d1731..f342cf15412b 100644
> >> --- a/drivers/gpu/drm/drm_plane.c
> >> +++ b/drivers/gpu/drm/drm_plane.c
> >> @@ -987,6 +987,9 @@ int drm_mode_setplane(struct drm_device *dev, void=
 *data,
> >>                  return -ENOENT;
> >>          }
> >>
> >> +       if (plane->state && plane->state->pixel_source !=3D DRM_PLANE_=
PIXEL_SOURCE_FB)
> >> +               plane->state->pixel_source =3D DRM_PLANE_PIXEL_SOURCE_=
FB;
> >> +
> >>          if (plane_req->fb_id) {
> >>                  fb =3D drm_framebuffer_lookup(dev, file_priv, plane_r=
eq->fb_id);
> >>                  if (!fb) {
> >> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> >> index 88bdfec3bd88..122bbfbaae33 100644
> >> --- a/include/drm/drm_blend.h
> >> +++ b/include/drm/drm_blend.h
> >> @@ -58,4 +58,6 @@ int drm_atomic_normalize_zpos(struct drm_device *dev=
,
> >>                                struct drm_atomic_state *state);
> >>   int drm_plane_create_blend_mode_property(struct drm_plane *plane,
> >>                                           unsigned int supported_modes=
);
> >> +int drm_plane_create_pixel_source_property(struct drm_plane *plane,
> >> +                                          unsigned long extra_sources=
);
> >>   #endif
> >> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> >> index 51291983ea44..89508b4dea4a 100644
> >> --- a/include/drm/drm_plane.h
> >> +++ b/include/drm/drm_plane.h
> >> @@ -40,6 +40,12 @@ enum drm_scaling_filter {
> >>          DRM_SCALING_FILTER_NEAREST_NEIGHBOR,
> >>   };
> >>
> >> +enum drm_plane_pixel_source {
> >> +       DRM_PLANE_PIXEL_SOURCE_NONE,
> >> +       DRM_PLANE_PIXEL_SOURCE_FB,
> >> +       DRM_PLANE_PIXEL_SOURCE_MAX
> >> +};
> >> +
> >>   /**
> >>    * struct drm_plane_state - mutable plane state
> >>    *
> >> @@ -116,6 +122,14 @@ struct drm_plane_state {
> >>          /** @src_h: height of visible portion of plane (in 16.16) */
> >>          uint32_t src_h, src_w;
> >>
> >> +       /**
> >> +        * @pixel_source:
> >> +        *
> >> +        * Source of pixel information for the plane. See
> >> +        * drm_plane_create_pixel_source_property() for more details.
> >> +        */
> >> +       enum drm_plane_pixel_source pixel_source;
> >> +
> >>          /**
> >>           * @alpha:
> >>           * Opacity of the plane with 0 as completely transparent and =
0xffff as
> >> @@ -699,6 +713,13 @@ struct drm_plane {
> >>           */
> >>          struct drm_plane_state *state;
> >>
> >> +       /*
> >> +        * @pixel_source_property:
> >> +        * Optional pixel_source property for this plane. See
> >> +        * drm_plane_create_pixel_source_property().
> >> +        */
> >> +       struct drm_property *pixel_source_property;
> >> +
> >>          /**
> >>           * @alpha_property:
> >>           * Optional alpha property for this plane. See
> >>
> >> --
> >> 2.41.0
> >>
> >
>

