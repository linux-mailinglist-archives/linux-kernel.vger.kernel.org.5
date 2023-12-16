Return-Path: <linux-kernel+bounces-2345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B07C815B57
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE6A1C21CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C81321BC;
	Sat, 16 Dec 2023 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ayBnWqvm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF423C7;
	Sat, 16 Dec 2023 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 089ED1C006B; Sat, 16 Dec 2023 20:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702755411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBUZp3N8L4MJ5ZGOE6xga7KiiycmLyCj1RkGWg22FNs=;
	b=ayBnWqvm7++RG8BJ+Asd6Z2oO/sOD1LQlYSs+GQ1HeYLRfYWVYMtI86OZ20xs544Sbc2to
	7Dtj7MRRyaTTXdyZd4+woJrX9USowF2jBqLncrCVfkjfNbLz++KUCLRgE2ad/BJAqon7by
	Ps6V7mzJbLJVed5fpgJ44yoSvgSUgQA=
Date: Sat, 16 Dec 2023 20:36:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <ZX38UnAvBn45+y0W@duo.ucw.cz>
References: <20231122075154.789431-1-alain.volmat@foss.st.com>
 <20231122075154.789431-4-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/MO1rl1fQBm0I5V"
Content-Disposition: inline
In-Reply-To: <20231122075154.789431-4-alain.volmat@foss.st.com>


--J/MO1rl1fQBm0I5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Addition of support for the Galaxy Core GC2145 XVGA sensor.
> The sensor supports both DVP and CSI-2 interfaces however for
> the time being only CSI-2 is implemented.
>=20
> Configurations are currently based on initialization scripts
> coming from Galaxy Core and so for that purpose only 3 static
> resolutions are supported:
>  - 640x480
>  - 1280x720
>  - 1600x1200

Also only limited subset of pixel formats is implemented? Would be
worth mentioning in the changelog, but perhaps comment at the start of
the file would be even better.

> +++ b/drivers/media/i2c/Kconfig
> @@ -50,6 +50,16 @@ config VIDEO_AR0521
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ar0521.
> =20
> +config VIDEO_GC2145
> +	select V4L2_CCI_I2C
> +	tristate "GalaxyCore GC2145 sensor support"
> +	help
> +	  This is a V4L2 sensor-level driver for GalaxyCore GC2145
> +	  2 Mpixel camera.

Normally tristate would go before select.

Reviewed-by: Pavel Machek <pavel@ucw.cz>

(But you probably want to solve the problems reported by the build
bot).

Thanks and best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--J/MO1rl1fQBm0I5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZX38UgAKCRAw5/Bqldv6
8rhpAJ96f/a2MmnMxqL586aG7j0Su5XwFACfUliE825R4b4S2aYyg3SopYMo9XU=
=Ymzx
-----END PGP SIGNATURE-----

--J/MO1rl1fQBm0I5V--

