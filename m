Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687697F2B02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjKUKxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:53:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E3CA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:53:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2865C433C7;
        Tue, 21 Nov 2023 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700564022;
        bh=dren9rtZs9LoxdyXhjp4Yyp5NRZDlU/F6eRzv4F54hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k63wyvGgRqnzOXqid2+ftKU7DiGmT8uiPkGtucMbve/LxjKauljxQaRJm4wvJsvnn
         tutRm8pjX4++vubxjXub9NwK0JD7TPdrAhJtvwNRhkORceablc64xTOzoJTQVPZwHo
         VKDcQ4AHXU9WuYYQomdVBI/3M3UIHWzz42pEnCgAXgcxS1ZVuW6CG8T3rO6U/DFzd4
         P1Sf7Hcejk9dMU1lI7P56PzuceLazAhZvhRvT37PH+wXRFSHux8vc0TGAtY6hZrhq0
         na+Jl0+pEGi075Dtkbg27trOZDOWHHTwBesO9goMqdfuEGJHaLK/zjreZNY7JNIb/z
         LyCVGWAtyYhNg==
Date:   Tue, 21 Nov 2023 11:53:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/bridge: imx93-mipi-dsi: Fix a couple of building
 warnings
Message-ID: <impubwywuxcqvgs45klgycxahkzryxg7l5efyqhuvmhlf3t4ah@7hn7ganoy5tb>
References: <20231121085644.499520-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vg7wmxfcfxtenah6"
Content-Disposition: inline
In-Reply-To: <20231121085644.499520-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vg7wmxfcfxtenah6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 04:56:44PM +0800, Liu Ying wrote:
> Fix a couple of building warnings on used uninitialized 'best_m' and
> 'best_n' local variables by initializing them to zero.  This makes compil=
er
> happy only.  No functional change.
>=20
> Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311151746.f7u7dzbZ-lkp@i=
ntel.com/
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/imx/imx93-mipi-dsi.c
> index 3ff30ce80c5b..7b3b4f985098 100644
> --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> @@ -226,8 +226,8 @@ dphy_pll_get_configure_from_opts(struct imx93_dsi *ds=
i,
>  	unsigned long fout;
>  	unsigned long best_fout =3D 0;
>  	unsigned int fvco_div;
> -	unsigned int min_n, max_n, n, best_n;
> -	unsigned long m, best_m;
> +	unsigned int min_n, max_n, n, best_n =3D 0;
> +	unsigned long m, best_m =3D 0;
>  	unsigned long min_delta =3D ULONG_MAX;
>  	unsigned long delta;
>  	u64 tmp;

N is a divider, so it would probably be better to initialize it to
UINT_MAX to avoid any divide-by-0 error.

Maxime

--vg7wmxfcfxtenah6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVyMMwAKCRDj7w1vZxhR
xTzNAP0aunK++Ez852vyYy+z6DvU89U7tbf+ixw9snVecp4TkwEA7zsiF1h1VoK7
CqzPhnqzP9snBdZ1jC/P01nwLUG19Qg=
=Yh6I
-----END PGP SIGNATURE-----

--vg7wmxfcfxtenah6--
