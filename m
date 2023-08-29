Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DF78BFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjH2IMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjH2ILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E250BDE;
        Tue, 29 Aug 2023 01:11:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso60387951fa.0;
        Tue, 29 Aug 2023 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296695; x=1693901495;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcuYJIkWkqttiEFUgjzpw9+w8oYYeUVuwo8y1FUeWpw=;
        b=J1PcgSd1BqMxBQvun64Fuuvhhr8YTHvbh6//P+i/Dh1RJ+9poUFPkzr4fCh2qWw3xR
         G1NBq0BZTz/VqftdPEviBeUxtnWLYjoPvwO6EGnRHn9y8MWqyUF+Ogb0k/1gz4NLKqqT
         WJMkv+qjPWwlm7estlENv5YXeFr4M2880+tMJmdUTme/djNa47wBAZzOzQ1bgdlZxyrJ
         ojOvMOkIZmi2LNiBEI8XK7bvqAp42WGICvKdADNRj03AAnxOdCSZ/FDhgy+P2ZWyAfDy
         kZT6XX+mGkKfY0iFVN2Zsnh1Y4JBalnbqtpplwDk1BatXz9V1WGPC0oouc+55Y5WjJ+U
         0Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296695; x=1693901495;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcuYJIkWkqttiEFUgjzpw9+w8oYYeUVuwo8y1FUeWpw=;
        b=Z1rK2byPSVlG3I9do0m0y9p0WhAtEfLA/Bb1Kkvbs9pI1WuP+malLR8lSIBr80cLDH
         HRgH0VE7MSMeWW/oZNarYAuR/1vH+ivxY5Q8eEeobx9p4tWn7Cm1KvISEMi6ujxio004
         oBQoKELnzqdbXir7uTIA2UrRM4C4etQ20SjCsp8ulmTsXUvvYvffkCJFbZlylM/VB6Av
         M0aCAYpUfIFnNh2q84e76hwGU/W9XK94wtqGzrqruE7MG0ccaegGR2lwP0qOLo7MfPom
         iFJnQ4dXtoxUftD61Rn0NtKwT3cp4FqXS1jGFxb5aheRX/kAcHSmPDfRCls97jOkgR7Q
         gFAA==
X-Gm-Message-State: AOJu0YwYddMOlthirMzonxHPGm/HvgqvlIXR6W0xseLGyTjtPOz3kFLV
        JWJXck++PnaPNTCgxDI+I/g=
X-Google-Smtp-Source: AGHT+IFMlAx6sqTJuzUZsB/QddKc9/jYUouieId2yrQNkMF4IjefFx/1fYXL6lteGDwOKzAf8OGf2w==
X-Received: by 2002:a2e:7e0d:0:b0:2bc:d33f:3e8f with SMTP id z13-20020a2e7e0d000000b002bcd33f3e8fmr15271739ljc.53.1693296694747;
        Tue, 29 Aug 2023 01:11:34 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9246000000b002bce3123639sm2054014ljg.98.2023.08.29.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:34 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:11:33 +0300
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
Subject: Re: [PATCH RFC v6 03/10] drm: Add solid fill pixel source
Message-ID: <20230829111133.201afd11@eldfell>
In-Reply-To: <20230828-solid-fill-v6-3-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
        <20230828-solid-fill-v6-3-a820efcce852@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9XiJ10hPEUcELqgCY+fqAZj";
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

--Sig_/9XiJ10hPEUcELqgCY+fqAZj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Aug 2023 17:05:09 -0700
Jessica Zhang <quic_jesszhan@quicinc.com> wrote:

> Add "SOLID_FILL" as a valid pixel source. If the pixel_source property is
> set to "SOLID_FILL", it will display data from the drm_plane "solid_fill"
> blob property.
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_blend.c | 10 +++++++++-
>  include/drm/drm_plane.h     |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 273021cc21c8..1016a206ca0c 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -200,6 +200,9 @@
>   *	"FB":
>   *		Framebuffer source set by the "FB_ID" property.
>   *
> + *	"SOLID_FILL":
> + *		Solid fill color source set by the "solid_fill" property.
> + *
>   * solid_fill:
>   *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
>   *	contains pixel data that drivers can use to fill a plane.
> @@ -638,6 +641,7 @@ EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
>  static const struct drm_prop_enum_list drm_pixel_source_enum_list[] =3D {
>  	{ DRM_PLANE_PIXEL_SOURCE_NONE, "NONE" },
>  	{ DRM_PLANE_PIXEL_SOURCE_FB, "FB" },
> +	{ DRM_PLANE_PIXEL_SOURCE_SOLID_FILL, "SOLID_FILL" },
>  };
> =20
>  /**
> @@ -662,6 +666,9 @@ static const struct drm_prop_enum_list drm_pixel_sour=
ce_enum_list[] =3D {
>   * "FB":
>   *	Framebuffer pixel source
>   *
> + * "SOLID_FILL":
> + * 	Solid fill color pixel source
> + *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
> @@ -671,7 +678,8 @@ int drm_plane_create_pixel_source_property(struct drm=
_plane *plane,
>  	struct drm_device *dev =3D plane->dev;
>  	struct drm_property *prop;
>  	static const unsigned int valid_source_mask =3D BIT(DRM_PLANE_PIXEL_SOU=
RCE_FB) |
> -						      BIT(DRM_PLANE_PIXEL_SOURCE_NONE);
> +						      BIT(DRM_PLANE_PIXEL_SOURCE_NONE) |
> +						      BIT(DRM_PLANE_PIXEL_SOURCE_SOLID_FILL);
>  	int i;
> =20
>  	/* FB is supported by default */
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index a38e18bfb43e..49995c4be2ab 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -43,6 +43,7 @@ enum drm_scaling_filter {
>  enum drm_plane_pixel_source {
>  	DRM_PLANE_PIXEL_SOURCE_NONE,
>  	DRM_PLANE_PIXEL_SOURCE_FB,
> +	DRM_PLANE_PIXEL_SOURCE_SOLID_FILL,
>  	DRM_PLANE_PIXEL_SOURCE_MAX
>  };
> =20
>=20

This UAPI:
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/9XiJ10hPEUcELqgCY+fqAZj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTtqDUACgkQI1/ltBGq
qqf4phAAhXuiIR8fQ4IXOlA0nxQVJB549LK2+4jwQZ0RDRwRf5OQ4O4pUAf5LnRL
V/4MhUHMHen2fzkvIVhKxT0VX+gc+3LrUama/GNUuKJz13as7zWuHrug9AgItlah
r0I1kEiG+mzI3N3LNebBIv5LJxBcdSsj0HbLIqBvoCmUFw3JNbSDUu+SWVJwNMUo
SUN4LRUhaTrltQPjXfsIKHwDhpfjogng14AQC+XpzUAXq5mK5Fd62K8bVtFsIFkS
z9Y3O8mtvhFCAad+f3tPXIsixt+/+V9jJkb/cDQFN+jWklSy3zjZsLPYrwwHzCBA
xiC3kbhssRIsQwifJN3MJQaYIA1aw/3n5nbL3ysmcgE7LZGl9jAnukmag4SJvgX1
02H/FOfqiXLiG24M4OOG3ll9rV8XDHBnug6JMquZvTh2JuNBYl90qce7o4M9RaLg
6u92Azu4VFU81eLMm/FGA+1a3lBRTyZJmVzVwW8IerEfVQHECpAsNHAp32zMZqiW
hSxAdAVRRA1SyaPi64Fp1C4bKruCZIboG0sg0zbkhCaFahCADmy2AoM4m7OOS/Y+
a6WQ5E94IIA64dviEqzKidVNk4clOxU3K9zu2NM0mLjPoqoNa8GAFJ6oOiY4g1WT
fzEyIiL6MVly7HTVZSqE67aBsBFKHe2CZmfI/lVLYaCoL17MUKc=
=GyQP
-----END PGP SIGNATURE-----

--Sig_/9XiJ10hPEUcELqgCY+fqAZj--
