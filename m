Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E47B79D651
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjILQaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjILQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:30:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA9115;
        Tue, 12 Sep 2023 09:30:34 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-163.ewe-ip-backbone.de [91.248.213.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F162166071A0;
        Tue, 12 Sep 2023 17:30:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694536233;
        bh=LOwB/jUo2S+N0tqU/4S/Wwo7wAdZpqQ+tRHtLNao9sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHiRqb6PE7LxVVdoanx/b9TIYNNA/pZ5hLWw+afyF3y3oCRfoNmW57A9bgqANLmCE
         6doqW33cIfQ0JSnBjN2yuRMnvNEhCC7TnN3L0/coxXNqfcwuHQRvpw2e2dy06ET8WC
         b6H1PBcR9da0EDnJTvYzvM+fgmqbtM97AtEW6L/59XJeQmvXRyIUnv2cZzBXU6RAWT
         SboFCp7oMKWqrUyIaQCjlryzo9JzKXi4QlssoTnJGxEpKPczKzGway4o2SfmiNL1mX
         gWBJ0lmRa9Kk/Y+D6og+qX2pUkclK6D7J7M91FMUUqeZz3nj4t3t71/L0fczkmf1Dj
         /Plg3f5AVM3Cg==
Received: by mercury (Postfix, from userid 1000)
        id 09C13106098A; Tue, 12 Sep 2023 18:30:31 +0200 (CEST)
Date:   Tue, 12 Sep 2023 18:30:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v1 3/4] thermal: Use
 thermal_tripless_zone_device_register()
Message-ID: <20230912163030.yioz2b3tc4pz4q76@mercury.elektranox.org>
References: <1870450.tdWV9SEqCh@kreacher>
 <8272147.T7Z3S40VBb@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rw2p7c6kkzrdn6p2"
Content-Disposition: inline
In-Reply-To: <8272147.T7Z3S40VBb@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rw2p7c6kkzrdn6p2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 30, 2023 at 06:14:57PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> All of the remaining callers of thermal_zone_device_register()
> can use thermal_tripless_zone_device_register(), so make them
> do so in order to allow the former to be dropped.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/power/supply/power_supply_core.c                |    4 ++--


For power-supply:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/thermal/armada_thermal.c                        |    5 +++--
>  drivers/thermal/dove_thermal.c                          |    4 ++--
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c |    6 +++---
>  drivers/thermal/kirkwood_thermal.c                      |    4 ++--
>  drivers/thermal/spear_thermal.c                         |    4 ++--
>  6 files changed, 14 insertions(+), 13 deletions(-)
>=20
> Index: linux-pm/drivers/power/supply/power_supply_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/power/supply/power_supply_core.c
> +++ linux-pm/drivers/power/supply/power_supply_core.c
> @@ -1305,8 +1305,8 @@ static int psy_register_thermal(struct p
> =20
>  	/* Register battery zone device psy reports temperature */
>  	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> -		psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> -				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
> +		psy->tzd =3D thermal_tripless_zone_device_register(psy->desc->name,
> +				psy, &psy_tzd_ops, NULL);
>  		if (IS_ERR(psy->tzd))
>  			return PTR_ERR(psy->tzd);
>  		ret =3D thermal_zone_device_enable(psy->tzd);
> Index: linux-pm/drivers/thermal/armada_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/armada_thermal.c
> +++ linux-pm/drivers/thermal/armada_thermal.c
> @@ -876,8 +876,9 @@ static int armada_thermal_probe(struct p
>  		/* Wait the sensors to be valid */
>  		armada_wait_sensor_validity(priv);
> =20
> -		tz =3D thermal_zone_device_register(priv->zone_name, 0, 0, priv,
> -						  &legacy_ops, NULL, 0, 0);
> +		tz =3D thermal_tripless_zone_device_register(priv->zone_name,
> +							   priv, &legacy_ops,
> +							   NULL);
>  		if (IS_ERR(tz)) {
>  			dev_err(&pdev->dev,
>  				"Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/dove_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/dove_thermal.c
> +++ linux-pm/drivers/thermal/dove_thermal.c
> @@ -139,8 +139,8 @@ static int dove_thermal_probe(struct pla
>  		return ret;
>  	}
> =20
> -	thermal =3D thermal_zone_device_register("dove_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal =3D thermal_tripless_zone_device_register("dove_thermal", priv,
> +							&ops, NULL);
>  	if (IS_ERR(thermal)) {
>  		dev_err(&pdev->dev,
>  			"Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -609,9 +609,9 @@ static int int3400_thermal_probe(struct
> =20
>  	evaluate_odvp(priv);
> =20
> -	priv->thermal =3D thermal_zone_device_register("INT3400 Thermal", 0, 0,
> -						priv, &int3400_thermal_ops,
> -						&int3400_thermal_params, 0, 0);
> +	priv->thermal =3D thermal_tripless_zone_device_register("INT3400 Therma=
l", priv,
> +							      &int3400_thermal_ops,
> +							      &int3400_thermal_params);
>  	if (IS_ERR(priv->thermal)) {
>  		result =3D PTR_ERR(priv->thermal);
>  		goto free_art_trt;
> Index: linux-pm/drivers/thermal/kirkwood_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/kirkwood_thermal.c
> +++ linux-pm/drivers/thermal/kirkwood_thermal.c
> @@ -71,8 +71,8 @@ static int kirkwood_thermal_probe(struct
>  	if (IS_ERR(priv->sensor))
>  		return PTR_ERR(priv->sensor);
> =20
> -	thermal =3D thermal_zone_device_register("kirkwood_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> +	thermal =3D thermal_tripless_zone_device_register("kirkwood_thermal",
> +							priv, &ops, NULL);
>  	if (IS_ERR(thermal)) {
>  		dev_err(&pdev->dev,
>  			"Failed to register thermal zone device\n");
> Index: linux-pm/drivers/thermal/spear_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/spear_thermal.c
> +++ linux-pm/drivers/thermal/spear_thermal.c
> @@ -122,8 +122,8 @@ static int spear_thermal_probe(struct pl
>  	stdev->flags =3D val;
>  	writel_relaxed(stdev->flags, stdev->thermal_base);
> =20
> -	spear_thermal =3D thermal_zone_device_register("spear_thermal", 0, 0,
> -				stdev, &ops, NULL, 0, 0);
> +	spear_thermal =3D thermal_tripless_zone_device_register("spear_thermal",
> +							      stdev, &ops, NULL);
>  	if (IS_ERR(spear_thermal)) {
>  		dev_err(&pdev->dev, "thermal zone device is NULL\n");
>  		ret =3D PTR_ERR(spear_thermal);
>=20
>=20
>=20

--rw2p7c6kkzrdn6p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUAkiIACgkQ2O7X88g7
+pqT9A//YX7+7IZoT7Pq8QpjHmMgA4ai2ksBVyr+06D5oHye077fDd4nTF/ly8AG
IxHQ3g7GF3DsBh7Grlq4iPdaDEewaHYSM/Sv0RU24aj+9iNPLJNyUKTBeV9TiM+2
4M9MLw6kUU+G/iG5cQD7iYVYKCNYZe/0CCz0il664dOvpPsZsNb53kB+NMYUiiT3
BYcb/01xygVW5I550G1CP8pNY2zjsWAODzP1Py/ymMNlaUlBKMCY+CcLAj+yUeQ1
xY76gbi33aHCuyIqfQ+xWZOpCDoyfo/APqPgw3ecyST5xKvcY1cMePwaf6eR0yrx
QAFYSynwOf9JN7CxbXWMkzsiaHT1i3MVBgT5sDlHuYta/Xeunmff9+cG224FIP5W
VVVbg5qLw9StEzNplvMMRk+F3bTH5M8bbLKG+3muLajfWcsTyTqBGEdHjTiU1QQu
xUARxyh7DdmojaOnBgL6d001srIb+JN5ApvHKZuYPE77KgNwacwirne91W8xjOSM
CiHxAi5DIDLaPHBEzdp8KKUNuM/8u1eUNPlkMUp8NdBsEa+44U4ixqGf179nMygM
bMECQSjOcLJa0zs5KvCMm4t3wtHOZ1x010dFpkWvODzhdQCs2B5qRyo5VM6Nd0CP
6YwafPe0Ld4BEKidAu4oCEme2zeOrnH0Mn1siBXGmtvvW7wrjZc=
=9Htj
-----END PGP SIGNATURE-----

--rw2p7c6kkzrdn6p2--
