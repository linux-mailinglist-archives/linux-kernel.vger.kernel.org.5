Return-Path: <linux-kernel+bounces-90933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3228706F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAD41F21F25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E6C4CB23;
	Mon,  4 Mar 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ6acpC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004A481DE;
	Mon,  4 Mar 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569553; cv=none; b=DQKBAIiOmtUHchNHJHE30XM/DfN6Qf5D3FKG1zrae9m0y8s/R3pTsY7rsHvSLNd8EGeIwBPpPbKH7bKzuQ3XyFDzOSq7+Q6aebxTn8KWmj2zuEgjIVEe58adeDBwLtvGIIdcnTHTpzLBJbzQbxiX9Zu74w4eZFxbZbhiX9okHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569553; c=relaxed/simple;
	bh=2UZ7Ps4m/EJvpDzbZaPfX5VjodQWkCgg4RS6EPjKsCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2++6kKii34sXucLz4YjjuzxngYauBOAsDKj1+Z8QI4ApYEpW7MPEF65scWyWU1+2nx738JRy3YXja6Sq97D4IStJOe0cD/vOYYn0b+2460Xq73aisZJ+KrUBW6EIUrSdcVHs46xXmmDKyEPFYgjplw8WX9L8YcLWvGdGu3iW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ6acpC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BAFC433C7;
	Mon,  4 Mar 2024 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569553;
	bh=2UZ7Ps4m/EJvpDzbZaPfX5VjodQWkCgg4RS6EPjKsCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQ6acpC/cFa9wdBLb7Sws2VuYfCl+hY90Qsl+KTeVLG1ffOFpQKNDx0fFGYbFZOcr
	 nR29qYIooowgh1Sp6FJsKpuMAWsXW5yYy3ze1RH7GdUK53xeMuSp5NP85GmbwxiSk8
	 CUnNb+SYbDWqv7CrMlEufk1xc5AKLHuEtqNZi7KzdNtjNQ86fECtyyiQVUFqH7Ej6F
	 5MTFFGi+yp5VI3QyGpxCq6yq1CGljfnu8gCDNbPwiMDKtoe+MTTavDBP/xd/XeU9SU
	 IiDvMPKidoV5Sp9xjQMVrzjlWpl1TXNmtxF4+sD747PBYYvG1MRh0vKDpFUJB1UlWk
	 uKH4RhpeQPzHg==
Date: Mon, 4 Mar 2024 17:25:50 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N00 LCD panel
 support
Message-ID: <20240304-inquisitive-kickass-pronghorn-c641ff@houat>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304160454.96977-4-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mv2k3vttsq537qh6"
Content-Disposition: inline
In-Reply-To: <20240304160454.96977-4-jeremie.dautheribes@bootlin.com>


--mv2k3vttsq537qh6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 04, 2024 at 05:04:54PM +0100, J=E9r=E9mie Dautheribes wrote:
> Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
> TFT-LCD panel.
>=20
> Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index 20e3df1c59d4..b940220f56e2 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa =3D {
>  	.connector_type =3D DRM_MODE_CONNECTOR_LVDS,
>  };
> =20
> +static const struct drm_display_mode cct_cmt430b19n00_mode =3D {
> +	.clock =3D 9000,
> +	.hdisplay =3D 480,
> +	.hsync_start =3D 480 + 43,
> +	.hsync_end =3D 480 + 43 + 8,
> +	.htotal =3D 480 + 43 + 8 + 4,
> +	.vdisplay =3D 272,
> +	.vsync_start =3D 272 + 12,
> +	.vsync_end =3D 272 + 12 + 8,
> +	.vtotal =3D 272 + 12 + 8 + 4,
> +	.flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};

Your pixel clock doesn't really match the rest of the timings:

(480 + 43 + 8 + 4) * (272 + 12 + 8 + 4) * 60 =3D 9501600

So a ~6% deviation.

What does the datasheet say?

Maxime

--mv2k3vttsq537qh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeX2DQAKCRDj7w1vZxhR
xS9xAQCDGCVsUNv+1hMk/N0uYSfwBKeI3lP8qwJyPKdVGR6VrQEA7qRTva593Qgh
GgGlSkFFwUHITKwZL7fG0K4ESfAOrAY=
=MRSp
-----END PGP SIGNATURE-----

--mv2k3vttsq537qh6--

