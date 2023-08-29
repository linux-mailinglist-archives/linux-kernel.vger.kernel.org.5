Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8778C013
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjH2IPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjH2IPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:15:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8371B6;
        Tue, 29 Aug 2023 01:14:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009969be25so6456303e87.3;
        Tue, 29 Aug 2023 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296867; x=1693901667;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpCt/3rI6BwltGm6OrrHxjmtGTGMQx5mSNvkMRK1Jws=;
        b=YRQlOcCRcFxAqYZAwQxhMqpBs0MSqAHQdVO4iPz2daPciNJKDVkPuS62HK15kZCZ+h
         ytMMNW0a+CGr2GIUFWW3KWVXWhdo5dHe99iVnoohjqTGHKnJcUTn/QE80iKX0CDAw00X
         aZGT0zVpbxgzRSArWz0MHWpTFXBiu4e74gsoVkgXcn9BVh4q38RrmBXvUH/BtkTcgtYw
         dqOm3iwtmjjVnj2UASckxpKxkneNrxH4mpIvfeM2/gtLPH8rkGkYTELxsRyk+Ta9VmNd
         SfZ4ag4yv0vpEIKvV53/rCKge6WCsXfEbXLPHb15pgv9QPDb/3+yrV7HpEmofNcFyboH
         EMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296867; x=1693901667;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpCt/3rI6BwltGm6OrrHxjmtGTGMQx5mSNvkMRK1Jws=;
        b=e02csuOX0SfkYWMAamC+qPsmLFNtdsmalY7fWrrrJlypbOGXzinKDCQRDe04dvVe8v
         Gme4eHIQh53N7++PxqhBkpoiXUYQV5TuV+7R/rXqxMN6GgDhl5HPvVODKzCTtLPB9sEj
         ZhKgAN9tq5vCvDWuSaIgTRu17QS5CyW53w0szEHtrBjlnKp/WqGA9laEeTlVh5Y4dcMW
         QYZ8jhNfzGrUiYITKriVyQdgl2epk7sC0y/+OMSa6tUox0H5+sJWQy0IARr/IbF5fCKd
         iAYEKj8uare0uuTZrx+5lsfG7+srcOIgTTdywvVAUk2jcYz74rNXn1389rr+TPMwZcWs
         Trrg==
X-Gm-Message-State: AOJu0YzBhDyhkKbQuNjKjX0H5RyLXob2jt+wVJnEmoFbEV6cgcI5OkP5
        sa5qp6/M3OCZzUd+I0Ext4s=
X-Google-Smtp-Source: AGHT+IF6eneRxFLz00elzVlsaViyXlp9Lf/PuaIKg7elUxgACLx6idoz53N5/PfqryD/gK9F++hr7w==
X-Received: by 2002:a05:6512:1594:b0:500:9b26:9760 with SMTP id bp20-20020a056512159400b005009b269760mr13354264lfb.13.1693296866888;
        Tue, 29 Aug 2023 01:14:26 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25151000000b004fcdf8b8ab4sm1878629lfd.23.2023.08.29.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:14:26 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:14:24 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <quic_abhinavk@quicinc.com>, <contact@emersion.fr>,
        <laurent.pinchart@ideasonboard.com>, <sebastian.wick@redhat.com>,
        <ville.syrjala@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>
Subject: Re: [PATCH RFC v6 05/10] drm/atomic: Add solid fill data to plane
 state dump
Message-ID: <20230829111424.3f187b88@eldfell>
In-Reply-To: <20230828-solid-fill-v6-5-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
        <20230828-solid-fill-v6-5-a820efcce852@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p3ZFNBA7.FbYl_glCOK8o6h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p3ZFNBA7.FbYl_glCOK8o6h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Aug 2023 17:05:11 -0700
Jessica Zhang <quic_jesszhan@quicinc.com> wrote:

> Add solid_fill property data to the atomic plane state dump.
>=20
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 4 ++++
>  drivers/gpu/drm/drm_plane.c  | 8 ++++++++
>  include/drm/drm_plane.h      | 3 +++
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index bcecb64ccfad..3cb599b3304a 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -717,6 +717,10 @@ static void drm_atomic_plane_print_state(struct drm_=
printer *p,
>  	drm_printf(p, "\tfb=3D%u\n", state->fb ? state->fb->base.id : 0);
>  	if (state->fb)
>  		drm_framebuffer_print_info(p, 2, state->fb);
> +	drm_printf(p, "\tsolid_fill=3D%u\n",
> +			state->solid_fill_blob ? state->solid_fill_blob->base.id : 0);
> +	if (state->solid_fill_blob)
> +		drm_plane_solid_fill_print_info(p, 2, state);
>  	drm_printf(p, "\tcrtc-pos=3D" DRM_RECT_FMT "\n", DRM_RECT_ARG(&dest));
>  	drm_printf(p, "\tsrc-pos=3D" DRM_RECT_FP_FMT "\n", DRM_RECT_FP_ARG(&src=
));
>  	drm_printf(p, "\trotation=3D%x\n", state->rotation);
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 559d101162ba..6244b622a21a 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1495,6 +1495,14 @@ __drm_plane_get_damage_clips(const struct drm_plan=
e_state *state)
>  					state->fb_damage_clips->data : NULL);
>  }
> =20
> +void drm_plane_solid_fill_print_info(struct drm_printer *p, unsigned int=
 indent,
> +				     const struct drm_plane_state *state)
> +{
> +	drm_printf_indent(p, indent, "r=3D0x%x\n", state->solid_fill.r);
> +	drm_printf_indent(p, indent, "g=3D0x%x\n", state->solid_fill.g);
> +	drm_printf_indent(p, indent, "b=3D0x%x\n", state->solid_fill.b);

I'd recommend %08x format, so that leading zeroes are explicit. That
makes it easier to see the difference between e.g. 0xffffffff and
0x0fffffff.


Thanks,
pq

> +}
> +
>  /**
>   * drm_plane_get_damage_clips - Returns damage clips.
>   * @state: Plane state.
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 49995c4be2ab..a58f84b6bd5e 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -1001,6 +1001,9 @@ drm_plane_get_damage_clips_count(const struct drm_p=
lane_state *state);
>  struct drm_mode_rect *
>  drm_plane_get_damage_clips(const struct drm_plane_state *state);
> =20
> +void drm_plane_solid_fill_print_info(struct drm_printer *p, unsigned int=
 indent,
> +				     const struct drm_plane_state *state);
> +
>  int drm_plane_create_scaling_filter_property(struct drm_plane *plane,
>  					     unsigned int supported_filters);
> =20
>=20


--Sig_/p3ZFNBA7.FbYl_glCOK8o6h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTtqOAACgkQI1/ltBGq
qqfEIw//VTbz8t1OwEo0CcfNcMpnOHydv9qTAEla3tDyevZTdRJVT/sMDlyAoEJM
Xl8y+9mZOiIl2GNHr1eg+FIKyAC/dnjFHK7wVNb2Qg4iw2pKuwFhEmbPgSf+Oyo4
ira8tQYseDoXoAERgbDSTZ13a5QXFk0kplnWtzDILTrLRRu5n78gamzlQb2LWjij
FW8LcFzxH8SrRUKZHZuVq0FUBRMq7XQyANJepM4wQ1YlmbEvRJRZUFIN5l/lE4kU
Rja6otQUZg+zRrWVvOeAFxPp+nkdN9JxBf52SFz44taFrVu/FmWl1FzhnYCju7wj
ZdhiB3OnsuQ3LifJd1tJCG/AndoYnkQoz0jXBvGlmXDpLraoCboHs6/k/QPgiX6Q
XQ0rcunlTrdtyKDPGzOt41TEVyRxV1WHUZCCWIWmRcJI6WvCUL0r/lR09Y4WwhSU
0S1+hxc1wdJj4l/Ay8HzFAu159/EipGnOQe6OdsKeaEkOTc5s1XLhkDC3W4bMN6O
zVXSEAhzGCjEdQdg24yabhVXwqyNzqqWuxcrLAe2P0QbBTnzHLH/H7LIFgi6y9yY
rXenXRL18kxyYLmBw8Vrx1w5EZhp05/fE4OklK2czh3I0PK/A8nV4j7GzcgwlPeQ
MT6a2xZ1/m7vAWvBitN7D5pcw4D/i3hqLZscm8I+39lbahyIwIg=
=9B8a
-----END PGP SIGNATURE-----

--Sig_/p3ZFNBA7.FbYl_glCOK8o6h--
