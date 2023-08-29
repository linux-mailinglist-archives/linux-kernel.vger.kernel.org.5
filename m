Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5778BF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjH2Hte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjH2HtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:49:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43550184;
        Tue, 29 Aug 2023 00:49:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5007616b756so6518108e87.3;
        Tue, 29 Aug 2023 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693295341; x=1693900141;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI1R5ue1l4PwCG2oi/y01LYQvO74RnqK27QxURC5nsg=;
        b=eP601AowgqNwM3BD8z2/bvld0CsvKwhr9cjQO77ANQJMtKiQWJJ4DwrM7bbQsPJYFK
         /8FELTL+8pvo8H8DuzDqstKrOPeFonP7oZZ+RmMDNYi1rVXb8v+rMo49cJeRGlN3gsQi
         2F3/2nA4G3YpWbnY15TSF+U9dGben0keGIUQMXP84bMYsNp3SiEvCh7UMwPGSX9rU5YC
         zkfUYelPFLHrNYG6QRqt/FKoEmOpQN9KOdb07A9uEYB7tAafvjHwAWHX1DVN2qmf8EKE
         a1ir6xqNv7bcX/P/pbzQdGvVBhdQmRuXQ19EJEIpw+5Ob+B9aHDV9QC8SAgOoZcpaW2P
         6UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295341; x=1693900141;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI1R5ue1l4PwCG2oi/y01LYQvO74RnqK27QxURC5nsg=;
        b=IeXGiN3A6KsfzV3QmimuEQhhoJcyEbSGOy0MMNpDx181sLTt5wylYGikwMpN0zfRd9
         giHpgBYpfkU7S9O8qYD9pAtnOJOpRxPZVSKt63bvBF7FsopRikeTTWbUXCcUZwdUjL6O
         yS4fKTbMuoC8DSc9mCtC3iKloxeYt6h17O5y1ArsQiIQY2qW6rnbuBpqRsjDZvZN/hmS
         3K4WizZ5IUYRxJ9Y+cf2+0HH3zqCYJ7o7EyL7NgK+w1++cNMizZ5S8sn6grrfKYQ7pyt
         8LdD4aMD/m2IkOPhXkMnJ/7RPnANZVbH04+L3P3vvg3xooAG9mznuVGHHF+mAfa/h/aS
         1sPw==
X-Gm-Message-State: AOJu0Yxe3bfjUrWR0tANmWRdOH0esah8chp/lVO9lodoLgANRite7YUZ
        N6Ffg4WJnLj/B/IlagGlSdY=
X-Google-Smtp-Source: AGHT+IGIlCEkJil4AnAwfWLiAfpjl2igqxZQluROeJEGmtOcAHN0LTRShvTWhmTqQEjer/Yqx7Vqxw==
X-Received: by 2002:a19:385e:0:b0:4fd:d517:fbcd with SMTP id d30-20020a19385e000000b004fdd517fbcdmr16742007lfj.6.1693295341041;
        Tue, 29 Aug 2023 00:49:01 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id o21-20020a056512051500b004ff8f090057sm1871769lfb.59.2023.08.29.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:49:00 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:48:16 +0300
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
Subject: Re: [PATCH RFC v6 01/10] drm: Introduce pixel_source DRM plane
 property
Message-ID: <20230829104816.19122c6d@eldfell>
In-Reply-To: <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
        <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kN5KPVrZpDI_roK/yihBVMo";
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

--Sig_/kN5KPVrZpDI_roK/yihBVMo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Aug 2023 17:05:07 -0700
Jessica Zhang <quic_jesszhan@quicinc.com> wrote:

> Add support for pixel_source property to drm_plane and related
> documentation. In addition, force pixel_source to
> DRM_PLANE_PIXEL_SOURCE_FB in DRM_IOCTL_MODE_SETPLANE as to not break
> legacy userspace.
>=20
> This enum property will allow user to specify a pixel source for the
> plane. Possible pixel sources will be defined in the
> drm_plane_pixel_source enum.
>=20
> Currently, the only pixel sources are DRM_PLANE_PIXEL_SOURCE_FB (the
> default value) and DRM_PLANE_PIXEL_SOURCE_NONE.
>=20
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
>  drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
>  drivers/gpu/drm/drm_blend.c               | 90 +++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/drm_plane.c               | 19 +++++--
>  include/drm/drm_blend.h                   |  2 +
>  include/drm/drm_plane.h                   | 21 ++++++++
>  6 files changed, 133 insertions(+), 4 deletions(-)

...

> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 6e74de833466..c3c57bae06b7 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -185,6 +185,21 @@
>   *		 plane does not expose the "alpha" property, then this is
>   *		 assumed to be 1.0
>   *
> + * pixel_source:
> + *	pixel_source is set up with drm_plane_create_pixel_source_property().
> + *	It is used to toggle the active source of pixel data for the plane.
> + *	The plane will only display data from the set pixel_source -- any
> + *	data from other sources will be ignored.
> + *
> + *	Possible values:
> + *
> + *	"NONE":
> + *		No active pixel source.
> + *		Committing with a NONE pixel source will disable the plane.
> + *
> + *	"FB":
> + *		Framebuffer source set by the "FB_ID" property.
> + *
>   * Note that all the property extensions described here apply either to =
the
>   * plane or the CRTC (e.g. for the background color, which currently is =
not
>   * exposed and assumed to be black).

This UAPI:
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/kN5KPVrZpDI_roK/yihBVMo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTtosAACgkQI1/ltBGq
qqebyRAAi5m4OshgltcLENupHhZJbAyOF4Vgz6aKR+OJ9smMDKbW6FmmNZmJqtj7
qq4Vb00Id6DDEnZidpPvMFRIoS10VChTqEF/kptq47/xoAtXmjeansqskKT6m6h5
rLuURGUKNRDy+r54irp86Gz5PPAwCUQEW+1WQebI2ph7I1wAkFp065LCf0zoJiQv
9z/hmqjnt6aiiGlDvc0IuRitiJp25VZa0p/FPW3eI/ob6zxT10r9lFAkvRz0UikE
ICw7tqEAVWJPQaqCOuJbRMR7fEmPhVYWj/sQ0wZqB75FQTzyay4zEHGwANyyXfFd
eMgKNv+Vn350Vari1CxY1nEvFC0/BIJT6s7G4h/bFZuaJebqQn7i1g05LRxY5WbK
g4c6kMIN26dJei4yHkPE22yFf9hPyx8mNK/EfC3LZ4LN2oIfimiUqH/mSSKkahLc
3RHN1zQ7TwlcLkHT9lVggZFFjhsv2YuACf9O34KzrAbh9ta0Nh1HOfazh3XxLrs5
WcFecPziUw/jT5HwdpsdENePJ9iMhds4/7aKx951HSXUdparXEaO7gjyy++7JqcE
5X80m73A321nxOSa6JLICiFMWHTobI3Qc+0nbanQElxcmDNFDyQrYP+du+dPCTXa
m+KUEU5syHRTxg7t51Acpjv7lVCec+Zgj+t+sfG8rxZKa5ziX88=
=eLDG
-----END PGP SIGNATURE-----

--Sig_/kN5KPVrZpDI_roK/yihBVMo--
