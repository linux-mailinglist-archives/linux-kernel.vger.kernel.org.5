Return-Path: <linux-kernel+bounces-144688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00F8A4939
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A6B25879
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8F2CCB4;
	Mon, 15 Apr 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRCJGlko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAF2C848
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166850; cv=none; b=AlGcuzu/gifMVCujtfYO73pOL8DwIo73K5JIqBSjbR9NgVym0RzdYzo7BjU5+eviGdx9f93qG7Z4BTHG++N2iqxOmRfQ4WpOCXz8dVj4EzRVLQF9LlDi2SftsEmQZHMiBhJ+rXhpNYiPFkg4OaeCi4Ti0tE7TJlnO3ai2abB3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166850; c=relaxed/simple;
	bh=mU5ztxbRn9xd/nrlhCRKZk2Z+vt7yYgz8ynF5gGmUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ2C3ixVOo/TPwuj7+dpbusYT5gaDdDA9lne9bgNIBEtc5ggMNFjRcJnCtyB2KlwZrQBrS2frlk0lkFWRyjtg60LS2evxZG72SCR1gpAhPCCVU1i4H/0Dzx/LgInuCgfuaWYiLuVZXOerjgeoVwhuAx4wZxBRyUkQi5GTfd2mV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRCJGlko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E0BC113CC;
	Mon, 15 Apr 2024 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713166850;
	bh=mU5ztxbRn9xd/nrlhCRKZk2Z+vt7yYgz8ynF5gGmUNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRCJGlkoCFHTA+sY1wtiRIMqfP72his3/NguZSwaXq+SB9hZitRl/Pfzpi0gCNjfF
	 k7iZZznr/bU5yJX8Kom5LOWAxxASbmos29twQxM0f6AnDvNQ8at+mUhaXPTxZGeyot
	 SwteJi54uhw7tsi5LA3ZP7elKT4sN+cgc38yqHHV8iB066t5kfkZHh7OF0t0S8gk7T
	 uNEInAFYABiEXy7nXdc5q1+W/ViJnEytOGN/BmE5T9P44Y8WDFKxJGgjqu1WmrYZjU
	 IDVuiUUlUs+t1GI6NJtZbk5TWXXKukKk02XI64ATazsIdRjXgK4KWV2OddAUnIZEiF
	 UxX66CZ48eI4w==
Date: Mon, 15 Apr 2024 09:40:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sii902x: Fix mode_valid hook
Message-ID: <20240415-venomous-enthusiastic-wildebeest-a7a446@houat>
References: <20240408081435.216927-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yll3teyvqekwzxye"
Content-Disposition: inline
In-Reply-To: <20240408081435.216927-1-j-choudhary@ti.com>


--yll3teyvqekwzxye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 08, 2024 at 01:44:35PM +0530, Jayesh Choudhary wrote:
> Currently, mode_valid hook returns all mode as valid. Add the check
> for the maximum and minimum pixel clock that the bridge can support
> while validating a mode.
>=20
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index 8f84e98249c7..658819199c84 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -163,6 +163,16 @@
> =20
>  #define SII902X_AUDIO_PORT_INDEX		3
> =20
> +/*
> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
> + *
> + * (drm_display_mode clock is in kHz)
> + */
> +#define SII902X_MIN_PIXEL_CLOCK			25000
> +#define SII902X_MAX_PIXEL_CLOCK			165000
> +

You should probably add a KHZ suffix or something to make it obvious.
The natural unit for a frequency is Hertz.

>  struct sii902x {
>  	struct i2c_client *i2c;
>  	struct regmap *regmap;
> @@ -313,7 +323,11 @@ static int sii902x_get_modes(struct drm_connector *c=
onnector)
>  static enum drm_mode_status sii902x_mode_valid(struct drm_connector *con=
nector,
>  					       struct drm_display_mode *mode)
>  {
> -	/* TODO: check mode */
> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK)
> +		return MODE_CLOCK_LOW;
> +
> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK)
> +		return MODE_CLOCK_HIGH;
> =20
>  	return MODE_OK;
>  }

It's something you should do in atomic_check too

Maxime

--yll3teyvqekwzxye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZhzZ/wAKCRAnX84Zoj2+
dvLmAX92oWeHZLr5hIKDGhemdrwUZRCEUzbQueD4PKBREYfIyJO/eJTudbScwDNA
vK/3U9EBgLvM/IuxlOU3CjE7cy0J+aLjzjXCPtdZi8mR1O3D/rXUwzHq8uCReJ94
lQRjoduC1w==
=+Fmk
-----END PGP SIGNATURE-----

--yll3teyvqekwzxye--

