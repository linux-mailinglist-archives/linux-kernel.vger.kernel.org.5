Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA57D2C90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJWIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjJWIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:23:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB5DA;
        Mon, 23 Oct 2023 01:23:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-507962561adso4229318e87.0;
        Mon, 23 Oct 2023 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698049384; x=1698654184; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yILl0/y7g1lM4NMlXc0rK5OqjDqsDZrg7ur6TMfehp0=;
        b=YC4ClkL3cV+mamVoYk1UzUAjG4c6pTBfAHh3uWMLRgbvvjACwY24sNUFxA7c2E5Qyy
         vAKLuvAmjvMBFHjs2HYZzvx9fOoBCD2laXJxaE8x6k+7wU4980g0rxaoINO4CDouQkPu
         QIvMe/W8qjxaFjsKzpfosoUcm542IMUaY4z3bhhnN8AR3W4KmzBqymDsqvZaBZwrO+Hg
         fIEiMIT07kvzwCB9Qm3o23QxHPD7sNBW+GhPIfisGxnm7zgckBLPW30oG+mBj9Sr8OBY
         5xTGIdrXOOAoII7NvySrPhBquqP2C6X+5jMlyUoOGk7THhvsK50wxhInrP3DDjs/nomp
         M/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049384; x=1698654184;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yILl0/y7g1lM4NMlXc0rK5OqjDqsDZrg7ur6TMfehp0=;
        b=X+i7YnFaf7GdimwNsBJgQP7Aqa3j5uelU/+ImAK0SBrvYC4yRoiMEjC7ZiQBhfm4IM
         mmyXWUDz71KE4KKgy/nEdOfesqhpIm65h0XG3HmNKjBzPhRAdQvqR1eWci6MBIedh4Ce
         5iBbLkg7vuxGBporKFjTAuhF/9s0+kMYCVMM4az5GnvVHi3JtbeqaPk+ujUJ+aErT/PF
         CC5xaVNZ/9z6IhpZbwPulyU6NRhQZauFz7BgKu/fUTXI2eeFFSENr/QFR+uPIJJyRxZw
         u/txQKwVbOOb3+RYYtwG1f282VluopudMxnUD7SjGmR/sXBTe9RCO5e+uqohwM4C/5I5
         5wng==
X-Gm-Message-State: AOJu0Yw/fbo4h7B3SX0imKMDc9xdUbXHhjPKLwzou4qIHBUhSs++EOMo
        MnWljBLp1y4zoPu1gDu8QqM=
X-Google-Smtp-Source: AGHT+IHfLv2FTvbtP+XDfCQMq0/4gQd56gQXMbgJziOzy1KkvTPqQfj0aDzIIvyqse8I9pxQmKfFcw==
X-Received: by 2002:a05:6512:5c3:b0:500:cb2b:8678 with SMTP id o3-20020a05651205c300b00500cb2b8678mr5314280lfo.40.1698049383921;
        Mon, 23 Oct 2023 01:23:03 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id u25-20020ac258d9000000b004f85d80ca64sm1608145lfo.221.2023.10.23.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:23:03 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:23:00 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Albert Esteve <aesteve@redhat.com>
Cc:     qemu-devel@nongnu.org, zackr@vmware.com, contact@emersion.fr,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot
 properties
Message-ID: <20231023112300.732e18fa@eldfell>
In-Reply-To: <20231023074613.41327-10-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
        <20231023074613.41327-10-aesteve@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BqH+LEjYZrs8=tT7kXjXoDd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BqH+LEjYZrs8=tT7kXjXoDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Oct 2023 09:46:13 +0200
Albert Esteve <aesteve@redhat.com> wrote:

> From: Michael Banack <banackm@vmware.com>
>=20
> To clarify the intent and reasoning behind the hotspot properties
> introduce userspace documentation that goes over cursor handling
> in para-virtualized environments.
>=20
> The documentation is generic enough to not special case for any
> specific hypervisor and should apply equally to all.
>=20
> Signed-off-by: Zack Rusin <zackr@vmware.com>


Hi,

the below doc text:

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq


> ---
>  Documentation/gpu/drm-kms.rst |  6 ++++
>  drivers/gpu/drm/drm_plane.c   | 58 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index a0c83fc481264..158cdcc9351f9 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -577,6 +577,12 @@ Variable Refresh Properties
>  .. kernel-doc:: drivers/gpu/drm/drm_connector.c
>     :doc: Variable refresh properties
> =20
> +Cursor Hotspot Properties
> +---------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_plane.c
> +   :doc: hotspot properties
> +
>  Existing KMS Properties
>  -----------------------
> =20
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 1dc00ad4c33c3..f3f2eae83cca8 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -230,6 +230,61 @@ static int create_in_format_blob(struct drm_device *=
dev, struct drm_plane *plane
>  	return 0;
>  }
> =20
> +/**
> + * DOC: hotspot properties
> + *
> + * HOTSPOT_X: property to set mouse hotspot x offset.
> + * HOTSPOT_Y: property to set mouse hotspot y offset.
> + *
> + * When the plane is being used as a cursor image to display a mouse poi=
nter,
> + * the "hotspot" is the offset within the cursor image where mouse events
> + * are expected to go.
> + *
> + * Positive values move the hotspot from the top-left corner of the curs=
or
> + * plane towards the right and bottom.
> + *
> + * Most display drivers do not need this information because the
> + * hotspot is not actually connected to anything visible on screen.
> + * However, this is necessary for display drivers like the para-virtuali=
zed
> + * drivers (eg qxl, vbox, virtio, vmwgfx), that are attached to a user c=
onsole
> + * with a mouse pointer.  Since these consoles are often being remoted o=
ver a
> + * network, they would otherwise have to wait to display the pointer mov=
ement to
> + * the user until a full network round-trip has occurred.  New mouse eve=
nts have
> + * to be sent from the user's console, over the network to the virtual i=
nput
> + * devices, forwarded to the desktop for processing, and then the cursor=
 plane's
> + * position can be updated and sent back to the user's console over the =
network.
> + * Instead, with the hotspot information, the console can anticipate the=
 new
> + * location, and draw the mouse cursor there before the confirmation com=
es in.
> + * To do that correctly, the user's console must be able predict how the
> + * desktop will process mouse events, which normally requires the deskto=
p's
> + * mouse topology information, ie where each CRTC sits in the mouse coor=
dinate
> + * space.  This is typically sent to the para-virtualized drivers using =
some
> + * driver-specific method, and the driver then forwards it to the consol=
e by
> + * way of the virtual display device or hypervisor.
> + *
> + * The assumption is generally made that there is only one cursor plane =
being
> + * used this way at a time, and that the desktop is feeding all mouse de=
vices
> + * into the same global pointer.  Para-virtualized drivers that require =
this
> + * should only be exposing a single cursor plane, or find some other way
> + * to coordinate with a userspace desktop that supports multiple pointer=
s.
> + * If the hotspot properties are set, the cursor plane is therefore assu=
med to be
> + * used only for displaying a mouse cursor image, and the position of th=
e combined
> + * cursor plane + offset can therefore be used for coordinating with inp=
ut from a
> + * mouse device.
> + *
> + * The cursor will then be drawn either at the location of the plane in =
the CRTC
> + * console, or as a free-floating cursor plane on the user's console
> + * corresponding to their desktop mouse position.
> + *
> + * DRM clients which would like to work correctly on drivers which expose
> + * hotspot properties should advertise DRM_CLIENT_CAP_CURSOR_PLANE_HOTSP=
OT.
> + * Setting this property on drivers which do not special case
> + * cursor planes will return EOPNOTSUPP, which can be used by userspace =
to
> + * gauge requirements of the hardware/drivers they're running on. Advert=
ising
> + * DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT implies that the userspace client=
 will be
> + * correctly setting the hotspot properties.
> + */
> +
>  /**
>   * drm_plane_create_hotspot_properties - creates the mouse hotspot
>   * properties and attaches them to the given cursor plane
> @@ -237,7 +292,8 @@ static int create_in_format_blob(struct drm_device *d=
ev, struct drm_plane *plane
>   * @plane: drm cursor plane
>   *
>   * This function enables the mouse hotspot property on a given
> - * cursor plane.
> + * cursor plane. Look at the documentation for hotspot properties
> + * to get a better understanding for what they're used for.
>   *
>   * RETURNS:
>   * Zero for success or -errno


--Sig_/BqH+LEjYZrs8=tT7kXjXoDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmU2LWQACgkQI1/ltBGq
qqc9jg/+O49j7A2awfs+aCc+PJsIXZzo6/vpt0Axrl++SGV6BNXjwSGNNGddCUQE
rZNaWJK3+JBbIqpk9fGz+kNUM1G3UJ5HCveIbl1lCetewGdeJGumMV7gB6/VnK32
zPDon8yBLibA0vHIZHeVp/7ELBNWzPy4XSt3FyOE0dLCen7xukneyZy8bCPpXfR3
bXr7kJV/N2XgZl7MgLRNOMnj/okbJ4dWzD4qUR7Pe8EC0zZ/pBlk7gMfQWeNk1Yl
UmFUix99PDTf3x8BaI22sD9hUg7qkSp1Tf4GtndKyrG5atgYJ61t+1HUAEg8oCJ4
eMH5umZhmm956T7/q7YTv+s3KkyOADQ1tK1ePOSB6I3uM1FF/LqnpzxFQgu11z3O
cl5q1crqZORm+3Sa6X9J7EAFNZzW8+9WD+qgQeuc1o2/mFplmL/fzs/OzkzhTCik
cZVkAFnIykWSoZSka9eG/Xt205wTTBgc0wgryr5OpRr50DCdLr+FfklNM4YLmcqU
ReoL1MWdDPcDtj7t6eaYXTa67kSQaSO/JSbz60cQ9Tt+Rhod6K6MtLFRyTIvFTYj
rISYdRD8Q4Pr8I96vlFXMUsy5hs8amyx5yrWHPWMp+7arZxUbSwupaaRFmTtAiSr
pJCgOmQFFHP+nAbRemAx1+TfNde21rdHuu4ud5Nq3p4ZnzY/taQ=
=75Es
-----END PGP SIGNATURE-----

--Sig_/BqH+LEjYZrs8=tT7kXjXoDd--
