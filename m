Return-Path: <linux-kernel+bounces-156819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610A8B08A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540DCB22F00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B515AAC6;
	Wed, 24 Apr 2024 11:52:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062315A4AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959522; cv=none; b=kF9jewgRVlmvsYLVz3wt56isSuU05JPli4xmtRe1Qec/YGRcEJkBh8pZKBguNhiezb6hCs9lb2kVahMo23nX1YNJCXHUfLMHkJjl5joQOLrn/Jadt3HGMXffpZdOciwxbiNJlJ2+BfhY1auXVdcvYxT8RYUjYuUaZfN98QVX9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959522; c=relaxed/simple;
	bh=4LHwUL/GiaGN8UBv9G2UKP4Pgmi5yTLpk/Z5kdqHPnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaO6nIsNHEhASw+WG0Gs34EezPY3mqsm2adls4X8J52qDSlWlg1g+Gi6ftByxCQVCnulMAiugam8uecw/S4GndZ8nXazay3zDWRSVyShow1mTOQJGPVNweNdJ8KqxD+ucKuMKeR3RWshKURgKVD0eABUw6JvULTBzk/+FjegvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzbA4-0000pN-S2; Wed, 24 Apr 2024 13:51:40 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzbA2-00E4RF-Q0; Wed, 24 Apr 2024 13:51:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D2892BEDF1;
	Wed, 24 Apr 2024 11:51:38 +0000 (UTC)
Date: Wed, 24 Apr 2024 13:51:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 2/4] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
Message-ID: <20240424-worm-of-massive-triumph-2eaf27-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xye5fqb7pzx6nlyi"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-2-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xye5fqb7pzx6nlyi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:55, Gregor Herburger wrote:
> According to Errata DS80000789E 5 writing IOCON register using one SPI
> write command clears LAT0/LAT1.
>=20
> Errata Fix/Work Around suggests to write registers with single byte write
> instructions. However, it seems that every write to the second byte
> causes the overrite of LAT0/LAT1.

This change doesn't use single byte write instructions.

> Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.

I discovered that erratum, it's described in
mcp251xfd_chip_rx_int_enable():

	/* Configure GPIOs:
	 * - PIN0: GPIO Input
	 * - PIN1: GPIO Input/RX Interrupt
	 *
	 * PIN1 must be Input, otherwise there is a glitch on the
	 * rx-INT line. It happens between setting the PIN as output
	 * (in the first byte of the SPI transfer) and configuring the
	 * PIN as interrupt (in the last byte of the SPI transfer).
	 */

The problem is that the SPI writes 1 byte at a time, starting at the
lower address. The chip updates the GPIO pin's status after each written
byte.

This may leads to a glitch if you have an external pull up. The power on
default auf the chip is GPIO/input, the GPIO line is not driven by the
chip and with the external pull up this will result in a high level.

If you configure the GPIO as an output/high, the driver first writes
bits 0...7, which results in the GPIO line being configured as an
output; the subsequent bits 8...15 configure the level of the GPIO
line.

This change doesn't take care of this.

I'm not sure, if it's better to have 2 dedicated writes to IOCON in the
driver or try to hide it here in the regmap.

> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 35 ++++++++++++++++++=
+++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/n=
et/can/spi/mcp251xfd/mcp251xfd-regmap.c
> index 92b7bc7f14b9..ab4e372baffb 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> @@ -229,14 +229,47 @@ mcp251xfd_regmap_crc_gather_write(void *context,
>  	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
>  }
> =20
> +static int
> +mcp251xfd_regmap_crc_write_iocon(void *context, const void *data, size_t=
 count)
> +{
> +	const size_t data_offset =3D sizeof(__be16) +
> +		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> +	u16 reg =3D *(u16 *)data;
> +
> +	/* Never write to bits 16..23 of IOCON register to avoid clearing of LA=
T0/LAT1
> +	 *
> +	 * According to Errata DS80000789E 5 writing IOCON register using one
> +	 * SPI write command clears LAT0/LAT1.
> +	 *
> +	 * Errata Fix/Work Around suggests to write registers with single byte
> +	 * write instructions. However, it seems that the byte at 0xe06(IOCON[2=
3:16])
> +	 * is for read-only access and writing to it causes the cleraing of LAT=
0/LAT1.
> +	 */
> +
> +	/* Write IOCON[15:0] */
> +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> +					  data + data_offset, 2);

You write 15:0 in 1 go here.

> +	reg +=3D 3;
> +	/* Write IOCON[31:24] */
> +	mcp251xfd_regmap_crc_gather_write(context, &reg, 1,
> +					  data + data_offset + 3, 1);
> +
> +	return 0;
> +}
> +
>  static int
>  mcp251xfd_regmap_crc_write(void *context,
>  			   const void *data, size_t count)
>  {
>  	const size_t data_offset =3D sizeof(__be16) +
>  		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
> +	u16 reg =3D *(u16 *)data;
> =20
> -	return mcp251xfd_regmap_crc_gather_write(context,
> +	if (reg =3D=3D MCP251XFD_REG_IOCON)
> +		return mcp251xfd_regmap_crc_write_iocon(context,
> +						 data, count);
> +	else
> +		return mcp251xfd_regmap_crc_gather_write(context,
>  						 data, data_offset,
>  						 data + data_offset,
>  						 count - data_offset);

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xye5fqb7pzx6nlyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYo8kYACgkQKDiiPnot
vG9t/gf9H+/WdOg2eiOSM5KODtdgigCiOuzFEj5izdhPZ3+561zJqSlT/jAnq6uk
1hsJrhI72Un3frNW977QH36dWk2xkUb06ByGaTMcGrN5NrKLjhCRQSCVWxcSLECe
lAFQiiCrJC+zqIxST0daQaOxqtXlM5bNynWO21OwLgtkt1sFd3TWvLjp6hdFjn7R
uSAzYi7CkDyKU0YoCTUgpJSV+di0tbxKO99Q/jl6OKY6X7ceullmFVKa2QhCZ7Hc
gQpWwoYBEJ0zuCbkA9sA2+eTOtS6lbcfssloNpfxTnOwV6zkVVC/GVIlN9J0HGuj
sWTg+tmk5kUwdVFwNTBfKNFBTYr+BA==
=X001
-----END PGP SIGNATURE-----

--xye5fqb7pzx6nlyi--

