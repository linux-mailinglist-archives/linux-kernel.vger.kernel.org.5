Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2275678BFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjH2IKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjH2IKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:10:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA299E;
        Tue, 29 Aug 2023 01:10:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso60492631fa.1;
        Tue, 29 Aug 2023 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296610; x=1693901410;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4mC9KYKkQXQDiZEbLbQSAIp6lc85QhEw4RvIjClzpU=;
        b=Pj6FASlTlX3l4PisP5ZpRbEya65eqoRinHgFnl1vkHR/WPdyaY0mfgk6eSDxKzyUyx
         FsJzHTzikQ3139OVGG+vTlBTFQztNE7Vxdg4JyvTB39sgWWSiRcQlQhEcmp+Utqey4lu
         oOQ14vRjGwav3iNFIrTHx6mg80tTopG6HJbJJU9McXW1bQkK/gy2nAPD3XAPESRzQocb
         DYVa5CqqjgDm9K841Nb21/BawJ73gghj49vNq05Ve/l3pwoS+6E47JNsXm+Vyy/SukkZ
         9rjApIAL6fLnf5b2X29Y6BEH4FJEAetGI+zu4YMY6MNYpZKSOdbDxujLa64r+9Xznrc0
         cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296610; x=1693901410;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4mC9KYKkQXQDiZEbLbQSAIp6lc85QhEw4RvIjClzpU=;
        b=DfDQ40rFxYFX0IHBCaB2Gpq6JoClV2ViwMx2lnJnQtaHWKyQWMBvTFb5OxQapsF3Al
         /u0ZcWdePtgZtnHfZ37TVUObDwREej45KRMGDoaCdjIVaq3w7b4fAgtUhQMhw8v3njae
         zhAYmr+OE8KCJFiFx+NdXRd/Nu5OuEVCE9YeKzxdrcYEoDTghLOr5Z1BbGGIUuCHaV7P
         7p0nIOHaqIlwE0PSMAotROgdkiF8pUwGM2CB2iJlHTeP/t19xSile1E40E6p+GTuYYpN
         e8X1K3umk/Nok5/AnQiM4OV816mD7ON7SjjVDn9oD0V9RO8KIPVmqAscVJvZ+6ZRXS8o
         79Vw==
X-Gm-Message-State: AOJu0YzROQ+3x+2r8lora43JoNuw/kP57wjXhx1hn9m42MS+EIP/beCR
        K/CgTNQMr3B1mU0zWe6OYTo=
X-Google-Smtp-Source: AGHT+IGXPuRW3MQGAlACbyOnXXAhlU3tssV5YGnrQVQgtb/RMpBl2U7Y+awGMUWAhS5caRIY2CWjZQ==
X-Received: by 2002:a2e:380a:0:b0:2b6:d13a:8e34 with SMTP id f10-20020a2e380a000000b002b6d13a8e34mr19594076lja.46.1693296609195;
        Tue, 29 Aug 2023 01:10:09 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id h17-20020a2e3a11000000b002b9b90474c7sm2074300lja.129.2023.08.29.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:10:08 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:10:06 +0300
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
Subject: Re: [PATCH RFC v6 02/10] drm: Introduce solid fill DRM plane
 property
Message-ID: <20230829111006.69cab33e@eldfell>
In-Reply-To: <20230828-solid-fill-v6-2-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
        <20230828-solid-fill-v6-2-a820efcce852@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tx9fmnSVUoZ_ajb1c3JK4ZY";
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

--Sig_/Tx9fmnSVUoZ_ajb1c3JK4ZY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Aug 2023 17:05:08 -0700
Jessica Zhang <quic_jesszhan@quicinc.com> wrote:

> Document and add support for solid_fill property to drm_plane. In
> addition, add support for setting and getting the values for solid_fill.
>=20
> To enable solid fill planes, userspace must assign a property blob to
> the "solid_fill" plane property containing the following information:
>=20
> struct drm_mode_solid_fill {
> 	u32 r, g, b;
> };
>=20
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  9 ++++++++
>  drivers/gpu/drm/drm_atomic_uapi.c         | 26 ++++++++++++++++++++++
>  drivers/gpu/drm/drm_blend.c               | 30 ++++++++++++++++++++++++++
>  include/drm/drm_blend.h                   |  1 +
>  include/drm/drm_plane.h                   | 36 +++++++++++++++++++++++++=
++++++
>  include/uapi/drm/drm_mode.h               | 24 +++++++++++++++++++++
>  6 files changed, 126 insertions(+)

...

> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index c3c57bae06b7..273021cc21c8 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -200,6 +200,10 @@
>   *	"FB":
>   *		Framebuffer source set by the "FB_ID" property.
>   *
> + * solid_fill:
> + *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
> + *	contains pixel data that drivers can use to fill a plane.
> + *
>   * Note that all the property extensions described here apply either to =
the
>   * plane or the CRTC (e.g. for the background color, which currently is =
not
>   * exposed and assumed to be black).

...

> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 43691058d28f..1fd92886d66c 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>  	char name[DRM_DISPLAY_MODE_LEN];
>  };
> =20
> +/**
> + * struct drm_mode_solid_fill - User info for solid fill planes
> + *
> + * This is the userspace API solid fill information structure.
> + *
> + * Userspace can enable solid fill planes by assigning the plane "solid_=
fill"
> + * property to a blob containing a single drm_mode_solid_fill struct pop=
ulated with an RGB323232
> + * color and setting the pixel source to "SOLID_FILL".
> + *
> + * For information on the plane property, see drm_plane_create_solid_fil=
l_property()
> + *
> + * @r: Red color value of single pixel
> + * @g: Green color value of single pixel
> + * @b: Blue color value of single pixel
> + * @pad: padding

Document that padding must be zero, and ensure userspace obeys that. If
there is ever need to re-purpose the pad field, requiring it to be zero
today makes re-purposing possible.

Alternatively, if it is likely that it might be used as alpha if
alpha-ful format is added, then it would make more sense to require it
to be 0xffffffff instead of zero. Then the kernel could internally
interpret it as alpha always without special-casing zero. Or, it could
be straight out called "alpha" to begin with, but document and verify
that it must be set to 0xffffffff which means opaque.

> + */
> +struct drm_mode_solid_fill {
> +	__u32 r;
> +	__u32 g;
> +	__u32 b;
> +	__u32 pad;
> +};
> +
> +
>  struct drm_mode_card_res {
>  	__u64 fb_id_ptr;
>  	__u64 crtc_id_ptr;
>=20

Looking good.


Thanks,
pq

--Sig_/Tx9fmnSVUoZ_ajb1c3JK4ZY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTtp94ACgkQI1/ltBGq
qqc5JxAAplJnS6jraS8LqXWheo+3tbrSW2HwSRw7IqbQOJMfYTRdwDYMJ8oymOcX
KFiKavBCkh87z9wGHImDqmNbdL3+ROB8YiSRm0wtRbhmx5gQC+1f1a2dG7izzTvK
0gOOKmQxVPNLB1iZ1DqxaJtq7yluDWAdAsg6Pg15+Cfet+I50O+Ot4TuteRcuM5T
oac1pOHX7VMRMHs1gX0+/shWA7nLDiVXwIyBEdt1jH1xIKVoAE7c+KQ5ouDrB9zY
vn0CbdOoH8/ANkZ1LGMI6+DMW80o1Zw+JlkT95g42+Mshu2x/QHh3mPu11shTHm0
fZcfUNAXGqY9HmKQeQgwY/houpQAB+Vc8xpVws3m3CPFhkwIV8XtW7G9fmLPWqh3
EVNg5x7eWpKov0XVEz+Vi/2rTAtQkB06817VEVoEi+zfsB2mifiSznpI7xdl4dxx
rf9PjT/Q6fA/tsqux3Bw8YgStR7UGFhdUytntU4ZsoD/A4nsfNJ+UpzQUWp9OmT2
kcus0eeab8PPE5nLqAc0uv66TY5SujcCs5sLyhIuQUTsjn2SxBD2K4U7c9MSWQIv
lCrGuAFb6OTEOCTPKfRjD9tgLMHfZJmlNv1X2FF7eCBq2tFMBsC7tWvw2OTKU+3n
sQpa8SjOXaQxz8n7YekBz+sbtvzwGAuIVZO9oLbL/Ba19VTa3Dg=
=GM1/
-----END PGP SIGNATURE-----

--Sig_/Tx9fmnSVUoZ_ajb1c3JK4ZY--
