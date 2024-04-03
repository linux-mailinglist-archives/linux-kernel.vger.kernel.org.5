Return-Path: <linux-kernel+bounces-130463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882B89787E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF6828E242
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E45154BF0;
	Wed,  3 Apr 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="sG6i0EQr"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB9152505;
	Wed,  3 Apr 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169921; cv=none; b=O+piwpbvCjVzYjv6sV6Ojg5mwC25AxR+Khzn8NNBHmlw3aselwUiRW+K4SysGA0sQivY/CTpRLA4HTK7dOMtf8qx1WlGOKyacQxrmJ17dK5F811Sqxdwqy/iUPSZsggHHi41SgGkWEeL4gA1EsqIUxNXEfbuvWm6LCtJAGcAy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169921; c=relaxed/simple;
	bh=p5ZHa99yQ0G28AeyzB5bMzEqTYXYrNAspxtCTaf1F2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et5VaxUnu7rNHWLQQYoJsyPf2va+FAr54Xnp4GbVa6W+F+wjRZT2FZCp58pwW4rXYwpnPo0Gs4v6ZRUI9cNus8sgsjmDEpqVb+4xCcndDvnuK/8D9BDtgldrUfQ4SJNdTJioye/cph31QbuZ9dbFXtNlg8C6Q/ZPl425G3MyjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=sG6i0EQr; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D01E21C0080; Wed,  3 Apr 2024 20:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712169917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W59SsqXTothDxWvqkGGyw7y/1mbHedzKr6xeQQT5n1E=;
	b=sG6i0EQrg1J0VOVkrfl1cDnm42qsCugFcLF6zQtpmv7rPNOEUoZ8isiriMmGY5y+APm5Up
	JoXbkHT1gTCaxs0wDqgYCpAxDx/VXNL+Knh8MJprk+X3S30tzPKJR/attD9C5kaoQFIUwN
	fODCMbcxndkgImxTqvdlEvtW1/uV8Eo=
Date: Wed, 3 Apr 2024 20:45:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 09/25] media: i2c: imx258: Add support for running on
 2 CSI data lanes
Message-ID: <Zg2jvUDFnY83drlg@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-10-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBWdaAInKX1z4AVe"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-10-git@luigi311.com>


--JBWdaAInKX1z4AVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +/*
> + * 4208x3120 @ 30 fps needs 1267Mbps/lane, 4 lanes.
> + * To avoid further computation of clock settings, adopt the same per
> + * lane data rate when using 2 lanes, thus allowing a maximum of 15fps.
> + */
> +static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] =3D {
> +	{ 0x0136, 0x13 },
> +	{ 0x0137, 0x33 },
> +	{ 0x0301, 0x0A },
> +	{ 0x0303, 0x02 },
> +	{ 0x0305, 0x03 },
> +	{ 0x0306, 0x00 },
> +	{ 0x0307, 0xC6 },
> +	{ 0x0309, 0x0A },
> +	{ 0x030B, 0x01 },
> +	{ 0x030D, 0x02 },
> +	{ 0x030E, 0x00 },
> +	{ 0x030F, 0xD8 },
> +	{ 0x0310, 0x00 },
> +
> +	{ 0x0114, 0x01 },
> +	{ 0x0820, 0x09 },
> +	{ 0x0821, 0xa6 },
> +	{ 0x0822, 0x66 },
> +	{ 0x0823, 0x66 },
> +};
> +
> +static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] =3D {
>  	{ 0x0136, 0x13 },
>  	{ 0x0137, 0x33 },
>  	{ 0x0301, 0x05 },

I wish we did not have to copy all the magic values like this.

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--JBWdaAInKX1z4AVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2jvQAKCRAw5/Bqldv6
8gpPAJ990EpaTFc6wNvvG5Byd8dCwMypTQCfRaBfE4S897ZzvdHop0ZS2va/6o8=
=wVBI
-----END PGP SIGNATURE-----

--JBWdaAInKX1z4AVe--

