Return-Path: <linux-kernel+bounces-40010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DD83D8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149E01C24FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9D13AEE;
	Fri, 26 Jan 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Qqb/A1Sp"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89952EAE6;
	Fri, 26 Jan 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266729; cv=none; b=U06S47q4xAhizQhzf+Ry1JJUueZLGL7mvPMRafC2v4qKQaT6TdyIrVj84YTvmlytl4aClHmtzRw3dTO3o1YoKINAZfx87k8OgSyXZbktzn1x72GVDV4tuTte0wORtqFV2994eP8n/xlU5N6v6NG7PXPyc8wwkB0pnFPUJGEesFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266729; c=relaxed/simple;
	bh=3aiLAmH0RdcOP4o9+Z28MUU6iwYGmfnBmv49RlTdb8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA3e3C8gDO2kJ8cFoGp2ceKhN+NUP6EsNnS1yKgwbFOE2MqT41u/c4pUlCm29YiFmt3nNWEKcjPcz7pQLkKYtUrSkMEvKnodzrqPmYjNNRW8vEay8PQKGPwb6N/WzejvT1Oti1xeUNvf9BCm1meGEq6u8uaCFJV+WhONil1X9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Qqb/A1Sp; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0761C28B531;
	Fri, 26 Jan 2024 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706266725;
	bh=3aiLAmH0RdcOP4o9+Z28MUU6iwYGmfnBmv49RlTdb8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qqb/A1Sp80ZO8Bj8vxbUHbeuypI8nzGATy11DJ5pmorbutNHtwlDj7cCzLEemsF+6
	 8x50Z9Z25MR6BCCoa8xxWue1yTEnmXGhC+Jlzxc/GY0ZUj+ZQ4R9rnphobBGjXBCnp
	 +wxwbHbTZujc3WoWmG0df3SDcIR01BQfbZctXWng=
Date: Fri, 26 Jan 2024 12:58:43 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: marius.cristea@microchip.com
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for PAC193x
Message-ID: <ZbOQY3cs5emASvzs@sunspire>
References: <20240122084712.11507-1-marius.cristea@microchip.com>
 <20240122084712.11507-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j6hFgdCDz3A6ajHc"
Content-Disposition: inline
In-Reply-To: <20240122084712.11507-3-marius.cristea@microchip.com>


--j6hFgdCDz3A6ajHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Marius,

a quick static scan reported the following

On Mon, Jan 22, 2024 at 10:47:12AM +0200, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.

[..]
> +	mutex_init(&info->lock);
> +	ret =3D devm_add_action_or_reset(&client->dev, pac1934_mutex_destroy,
> +				       &info->lock);
> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
> +	 */
> +	ret =3D pac1934_chip_configure(info);
> +	if (ret < 0)
> +		return ret;

the previous assignation of ret is never used, so either dead code or you m=
ight
have wanted to return early based on it's value.

cheers,
peter

--=20
petre rodan

--j6hFgdCDz3A6ajHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWzkGMACgkQzyaZmYRO
fzA8lQ/7BqVyUd2MTfT1Q7WdU8tEr0IO04T/8q8O4rLv4qn/euVY8f8zodmd916M
aszgIBKbFQSRQgDeKDgV/k1mdozZjY650e70htkS+xyPfw4IK6GCEBkjSDDH4TDS
f0csnQFL/CIUmriUxAA5BsEvtK1MFfOmOb3A326/rtFfM+B0dmcRTlTYFvrCp3EO
NhO1C7UMfMclLbb6nHWs8Q+xPnjzH70JejXqL6QwOGHWvHiI/iJkT55mYuvBUdiE
12zjuD9L8uqUWPCPAd7mpyFuKI3ilb6fwVx1nABwn+wi/m+snu4425wUDpACqofb
Vk+MTtro82m9LjuElDYcDhRITVgj5CiRWI2X78n4h1ZfIbICVMXkNxSynce+56+X
d6UpAKlpjoZWyBflcoudN9gEDYzc20rcZnQ/qQ5GbfoVyeM9+cOB1ymlAGR5zhWc
wSiTnlzNEiFd4TzwXOO2aDXzwI6VJGnsXPFyyNWujn2zwFJrCK2ihZsb73jVjON6
KYjJEtq2ZQ2qzkzESdY2AQrsnXGJBokPIJc50wMo7vzPRbEe+kancgNG1xgCeLdo
rceiUmqOYGFVprkXw10Kh7IWZhFpSyQcAxj0gHikeYrIZkRgQf62hXjmBNieWCz5
ZqqB4jLxNSV2FEMOKp7Bc1ONhqV8HNhjqaXewY3xya1ngPOZvYU=
=lZiH
-----END PGP SIGNATURE-----

--j6hFgdCDz3A6ajHc--

