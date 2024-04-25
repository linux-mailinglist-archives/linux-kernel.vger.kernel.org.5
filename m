Return-Path: <linux-kernel+bounces-158514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D571A8B218E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BDE1C21D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623B12BF3F;
	Thu, 25 Apr 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jD9FAo4h"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515E12AAC5;
	Thu, 25 Apr 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047788; cv=none; b=OLtSgtuIyqzIf/9eVP+lrHfgqoX0aueT14fCQLAa8YcY/lNtb6lTkizR2Q7bUlD+tXRA1EU1b7X4HLROyoQUQTloFfNtrOEbA9111bDX+Tk4j3SIuYA0ZG59gL6Q4fPOjGwqmXA7G1RcGz3ue4wLKFqNn6hqHyN60Ek+X5VKtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047788; c=relaxed/simple;
	bh=ka9MBV9PeSymXBRhhYYBWCDmGPWgFkeaY09SK+d3rqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulQWB9nvTUzjhcqyP/8+/AGfY1Or0cQLASByMRQmJKgTZk2sA5HHnsRyX+nEIk632uGYR9K453SfQvYJQaNH7nziCEuFw+NgawZrRbAgSM/KMKBKNZ3DRd1Xfur4/ptUl1uW5AI4hA/7InhB8QiXBZjpSFwohgCh7JTABpdd+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jD9FAo4h; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714047788; x=1745583788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ka9MBV9PeSymXBRhhYYBWCDmGPWgFkeaY09SK+d3rqE=;
  b=jD9FAo4h3WPnuoerVaXpgmugjccqXcoARjvRgo8grPMOhHh6B90vMYsk
   Lq7f+oUpi/sbQQJ782mbJhFGvF8S0aH5zEhS8KfFHULwKtVOAbJkO2aFt
   Pq2idJL/rs0Es2YRKphkrZKoV/6hcfNZgcyRqK64JH5mtcDBcv4fmaUSC
   nXTP4FXIkeHnhWbTsTqgjKaO4Ckp2FSyqRCCkfxRouoB+O1wAmtI+ufrJ
   62WqC7YWM/sPmjFQtam34KKXiN3/ho0sDZbuNZPWJwkvNMvSNHY/WdVlp
   o0ud4zmbPJFKlq2QHLj7dzzYu0D2aVhtiBTI9xzZL6P6aOSE+uV4DZJpA
   g==;
X-CSE-ConnectionGUID: wwZCvykgROeJ0FlGisTKvw==
X-CSE-MsgGUID: uqF8t8JRR8qapq0V2oh2pA==
X-IronPort-AV: E=Sophos;i="6.07,229,1708412400"; 
   d="asc'?scan'208";a="22628058"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 05:23:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 05:23:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 05:23:01 -0700
Date: Thu, 25 Apr 2024 13:22:45 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: <marius.cristea@microchip.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v1] iio: adc: PAC1934: fix accessing out of bounds array
 index
Message-ID: <20240425-canteen-alias-5a907b1deecc@wendy>
References: <20240425114232.81390-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EW7HVGbh5br5EAU"
Content-Disposition: inline
In-Reply-To: <20240425114232.81390-1-marius.cristea@microchip.com>

--1EW7HVGbh5br5EAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 02:42:32PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> Fix accessing out of bounds array index for average
> current and voltage measurements. The device itself has
> only 4 channels, but in sysfs there are "fake"
> channels for the average voltages and currents too.
>=20
> Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  drivers/iio/adc/pac1934.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index f751260605e4..456f12faa348 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -787,6 +787,15 @@ static int pac1934_read_raw(struct iio_dev *indio_de=
v,
>  	s64 curr_energy;
>  	int ret, channel =3D chan->channel - 1;
> =20
> +	/*
> +	 * For AVG the index should be between 5 to 8.
> +	 * To calculate PAC1934_CH_VOLTAGE_AVERAGE,
> +	 * respectively PAC1934_CH_CURRENT real index, we need
> +	 * to remove the added offset (PAC1934_MAX_NUM_CHANNELS).
> +	 */
> +	if (channel >=3D PAC1934_MAX_NUM_CHANNELS)
> +		channel =3D channel - PAC1934_MAX_NUM_CHANNELS;
> +
>  	ret =3D pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
>  	if (ret < 0)
>  		return ret;
>=20
> base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> --=20
> 2.34.1
>=20

--1EW7HVGbh5br5EAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZipLFQAKCRB4tDGHoIJi
0qv8AP9sDEguR1KU2sc68ldF+YJPVrg4I1a3EynhdNA89mydgwD/Wb9FRgx20W02
QfTkKi1SgkK8AVqcjXUEUkbim7PBNQQ=
=6QRm
-----END PGP SIGNATURE-----

--1EW7HVGbh5br5EAU--

