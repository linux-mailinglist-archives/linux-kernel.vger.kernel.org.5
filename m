Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878CC799C78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjIJDzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIJDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:55:03 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31C19E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:54:59 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5733710eecaso1966451eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 20:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694318098; x=1694922898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8I/ytZjYAzCt9rW5QpCR2v7N9TIb41rg0eM/Ys3Nlw=;
        b=luyYlYLGzKJaWu1Av4hHTAImJBNlCgq8EnIGNJteTpvtlprX8vvSuIsfMjSAosLh7K
         M/2QlfqvTyx7OWEb4P+lvVEwFhv3We4ma9iEGQNWlJiVWmrFEyD2xRkdy5b75GuLnamD
         ew3eTiNnz2iJmEA2v83avUgZDvbYs2aNhhvdzQtKu15HXhb1n/Uuzg8Zi6COqDqcICdq
         nQ3cl4o+NbU9CXv9t3K+xdunlCF41WgODNMjNwI5OkEzXrVpgRs6ovAWqOBdwMiUWAKU
         SrEpKdyQI7O8TcKOZsL0g+P2DhBhhdcb9X/cnO/kj4eilsodQqNxg5AZXaJQDdGAURFk
         5/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694318098; x=1694922898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8I/ytZjYAzCt9rW5QpCR2v7N9TIb41rg0eM/Ys3Nlw=;
        b=VSaQwzij0zloPd2VWXrNo1L7bYfoc9ttZgk6osqmxFvdQi+SDtjLunYfLK+qG3FC54
         Hx3T4l4IJPMj0tVVgXXErja+5mRdEay8mpTO/227qvgDK525W3k0DHQeTUjPOFirzLnT
         Osa9S4N3CVioR7KmRy8Ls11rvV3RCfgNMSmAUOSRC/dp3ZZOUynvHcZlEWDtlQ4MuFFm
         twnefZ85AMQ9FR/y/+1DAJhyeD3MBoQBV7uwbqEYiyt7rL1gXCT054jPHlEncwf8/WsH
         w3CyQ2DlQLXsf7z6KczbPPmiBwNQvdM6wNWQHYS45JZmmDHQf3WGX+bXYSeJkvepbYVG
         sPlQ==
X-Gm-Message-State: AOJu0YzRoEo/w9xh9IwYxcK10kqxGQ/QTn0BigGkirfGwiG9ped2p03w
        FN5RWeatC675Efg2ns4/F1s=
X-Google-Smtp-Source: AGHT+IFmdTBXwP0BmCOvDapnnklEogCQpFivgh7MV+psCiblPD/X9FoNE9kxhyOeikZ+QKi3oWkkrg==
X-Received: by 2002:a05:6358:7209:b0:134:c37f:4b63 with SMTP id h9-20020a056358720900b00134c37f4b63mr7481569rwa.2.1694318098413;
        Sat, 09 Sep 2023 20:54:58 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001b9d8688956sm3913678pll.144.2023.09.09.20.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 20:54:57 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 31A2B8152373; Sun, 10 Sep 2023 10:54:53 +0700 (WIB)
Date:   Sun, 10 Sep 2023 10:54:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fix doc warnings related to drm connector
Message-ID: <ZP0-DaW3lIeaZ8xY@debian.me>
References: <20230909110343.8103-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m24psGSsoqT7l832"
Content-Disposition: inline
In-Reply-To: <20230909110343.8103-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m24psGSsoqT7l832
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 04:33:43PM +0530, Bragatheswaran Manickavel wrote:
> Addressing drm dp/hdmi connector related kernel documentation
> warning and add more information about these values.

What are these?

>=20
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 2 ++
>  include/drm/drm_connector.h     | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index bf8371dc2a61..084c95785dda 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2203,6 +2203,7 @@ static int drm_mode_create_colorspace_property(stru=
ct drm_connector *connector,
>  /**
>   * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace pro=
perty
>   * @connector: connector to create the Colorspace property on.
> + * @supported_colorspaces: to get hdmi supported colorspaces.
>   *
>   * Called by a driver the first time it's needed, must be attached to de=
sired
>   * HDMI connectors.
> @@ -2227,6 +2228,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_prope=
rty);
>  /**
>   * drm_mode_create_dp_colorspace_property - create dp colorspace property
>   * @connector: connector to create the Colorspace property on.
> + * @supported_colorspaces: to get dp supported colorspaces.
>   *
>   * Called by a driver the first time it's needed, must be attached to de=
sired
>   * DP connectors.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index d300fde6c1a4..556d66dd122c 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -498,6 +498,8 @@ enum drm_privacy_screen_status {
>   *   ITU-R BT.601 colorimetry format
>   *   The DP spec does not say whether this is the 525 or the 625
>   *   line version.
> + * @DRM_MODE_COLORIMETRY_COUNT:
> + *   Represents the count of colorspaces.
>   */
>  enum drm_colorspace {
>  	/* For Default case, driver will set the colorspace */

Oh, you mean to add description for colorspace-related fields.

Thanks.


--=20
An old man doll... just what I always wanted! - Clara

--m24psGSsoqT7l832
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZP0+DQAKCRD2uYlJVVFO
o72FAQC1/upVU9ceWJaSBr2/nUK7jvc12JhGtDiGaWd0X4kdNQEAjlcMtPpgNEwk
knUERgY4BXnbaet+xqtbFqc65Zr6+wQ=
=sgRJ
-----END PGP SIGNATURE-----

--m24psGSsoqT7l832--
