Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53B804CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjLEIjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:38:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED99C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:39:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A11AC433C7;
        Tue,  5 Dec 2023 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701765545;
        bh=dSJniFJvuhlzGffz0+9vfpug0bjv1vvAyeb5/+VYCOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DR8HiwhCT4uVoisMTrY7TjEF6d+wbbY3TM32TLF9nkS7i1zvGTTLo+J19B8IZQWwM
         nXhXOGJitnsCBae8OIW5q736VWtgHM+hzt4hinl9YWcJdss0khNR3dD1Jq9JT7zZdv
         OUkhVUMuSHejw+4e63+8JyWkrbUXYrBMywJhMfSCY+xUiSxCiWh6XOGaJB+2wrfjfD
         lErQQ5qbDNIB+ULAJ5QSbeOJUjzjaSLC0XyjgdV5qaE5jH8enXpr5L9Cn2a6t5hrcY
         3hVk2Xm25/cJuk5eeTH15Fqy57e7qBZPE6fCCPKNG8hEu1kW4+8yNDdlyCKDLrFUWy
         Uj/hvBOSVOK/g==
Date:   Tue, 5 Dec 2023 09:39:02 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v7 07/10] drm/atomic: Loosen FB atomic checks
Message-ID: <nxxuloh65mlajjwvu5tazxraolrhvpz3kcsjji4alda76xgctv@ua6zwrrgucml>
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
 <20231027-solid-fill-v7-7-780188bfa7b2@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vg2ogmm6wxqd5eta"
Content-Disposition: inline
In-Reply-To: <20231027-solid-fill-v7-7-780188bfa7b2@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vg2ogmm6wxqd5eta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 27, 2023 at 03:32:57PM -0700, Jessica Zhang wrote:
> Loosen the requirements for atomic and legacy commit so that, in cases
> where pixel_source !=3D FB, the commit can still go through.
>=20
> This includes adding framebuffer NULL checks in other areas to account for
> FB being NULL when non-FB pixel sources are enabled.
>=20
> To disable a plane, the pixel_source must be NONE or the FB must be NULL
> if pixel_source =3D=3D FB.
>=20
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

This breaks some plane kunit tests we have:

See https://lore.kernel.org/dri-devel/20231204173536.51003-1-naresh.kamboju=
@linaro.org/

Maxime

--vg2ogmm6wxqd5eta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW7hpgAKCRDj7w1vZxhR
xRaSAP4ozFoBHnSVpdZs8a5pPi+lP4+/seXLresmMqgkjyFRNQD/ZVWVZ6F9ldOa
j7LNrKY0oxu+rklJhK3G1KPgR+rzyg4=
=3ESI
-----END PGP SIGNATURE-----

--vg2ogmm6wxqd5eta--
