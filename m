Return-Path: <linux-kernel+bounces-135483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924A89C66E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C09D1C229D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3183A14;
	Mon,  8 Apr 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE7EPjCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF82D62;
	Mon,  8 Apr 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585435; cv=none; b=KauFk3My9C7NbaarVEyKTUsorsLs8S23V5pn/0+5y4DXHfMxmjbYnvvqrEl/zAHfZiZgPuAp33yY5CZgRdsHtIvOrEFohtI4zqLk/vWkFken5drB6vWWH4sBd+80PvV/J2kU4kaXVpYu/WIe7+ql5E7N/s7LwhD75XZ+Xo3Blc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585435; c=relaxed/simple;
	bh=i/IeI3uOGzEG5noySiGDDBuECVA5WT3ZW1ulNIYuqyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUg5kmc8Oq6fS9EQiarGFIxgFKEYBINACv+i4mD3eSoOA7Y5IWzzu561DVoakWLRYDnnTJa+ynKeACfF8xdW1kNE6SVNbrCTJ2vg+iRPxeWgwbMxMhhqwpsWhzrMxRDxgZTJ16w82To6a63es7/mKFcESwIh7MxNCtODDEe0Dk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE7EPjCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F1C433C7;
	Mon,  8 Apr 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585434;
	bh=i/IeI3uOGzEG5noySiGDDBuECVA5WT3ZW1ulNIYuqyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE7EPjClC2bkA0lXIlpi8pb8hs0uR5e4DiMzoppFcNv3/+dd+Vj1dPFKKuAuQ8IlM
	 hWzrlBJ5TWVobqIHaX+NUgDSCDYy5rv6BBrbHNu/pswbLWnR+daM5eKukG6KRQOWoe
	 oTmrD3tj9Tb6vstX+XxLoCB1qFYARjNwUnBDlnJ9yOzW/Fu7355E6wNck+Rv4E+VZg
	 73TNZoVg7cFwSBzkVD38q2FC5cuG48A8maa7ap1MbKgGKQneG+eyE8t6/9/1AzjTI6
	 eCKLNIwJTF48B5R7944m5lbK0vYSH4Y7CaejhZZDOlfEQXUTRpbP5Rc8fAcnfjjYiR
	 UU2BqWdruPVWw==
Date: Mon, 8 Apr 2024 15:10:28 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection
 quirk
Message-ID: <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="97Qcf0iyghKpwfU3"
Content-Disposition: inline
In-Reply-To: <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--97Qcf0iyghKpwfU3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:02:15PM +0200, Th=E9o Lebrun wrote:

> Use hardware ability to read the FIFO depth thanks to
> CQSPI_REG_SRAMPARTITION that is partially read-only. Keep current
> behavior identical for existing compatibles.

The behaviour is not identical here - we now unconditionally probe the
FIFO depth on all hardware, the difference with the quirk is that we
will ignore any DT property specifying the depth.

> -	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
> +	if (!(ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) &&
> +	    of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
>  		dev_err(dev, "couldn't determine fifo-depth\n");

It's not obvious from just the code that we do handle having a FIFO
depth property and detection in the detection code, at least a comment
would be good.

> +static void cqspi_controller_detect_fifo_depth(struct cqspi_st *cqspi)
> +{
> +	const struct cqspi_driver_platdata *ddata =3D cqspi->ddata;
> +	struct device *dev =3D &cqspi->pdev->dev;
> +	u32 reg, fifo_depth;
> +
> +	/*
> +	 * Bits N-1:0 are writable while bits 31:N are read as zero, with 2^N
> +	 * the FIFO depth.
> +	 */
> +	writel(U32_MAX, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
> +	reg =3D readl(cqspi->iobase + CQSPI_REG_SRAMPARTITION);
> +	fifo_depth =3D reg + 1;
> +
> +	if (ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) {
> +		cqspi->fifo_depth =3D fifo_depth;
> +		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
> +	} else if (fifo_depth !=3D cqspi->fifo_depth) {
> +		dev_warn(dev, "detected FIFO depth (%u) different from config (%u)\n",
> +			 fifo_depth, cqspi->fifo_depth);
> +	}

It's not obvious to me that we should ignore an explicitly specified
property if the quirk is present - if anything I'd more expect to see
the new warning in that case, possibly with a higher severity if we're
saying that the quirk means we're more confident that the data reported
by the hardware is reliable.  I think what I'd expect is that we always
use an explicitly specified depth (hopefully the user was specifying it
for a reason?).

Pulling all the above together can we just drop the quirk and always do
the detection, or leave the quirk as just controlling the severity with
which we log any difference between detected and explicitly configured
depths?

--97Qcf0iyghKpwfU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT+tMACgkQJNaLcl1U
h9BRWwf+Nn0TIUbAm2J8N2ADxHV5QvboVoCubMNpoS/qRWdNjo5kgnkbDgAqrTZU
Ms8Fp3rg41VV9aJw+eP1lypgpPLunatteZi6o4FzmEn5XL1s0K6+fkZ5MKkgBfhW
H03cNHSc9lhh4CJsYZy9naA+M/yaJC1c6Cjr7pW+h3EQfN2voDa2JG1cbEA1JB7q
PBKJTq7l7s5gpG/y49WdI4A7c+O4U0Zab36uOffPEypTE1drcZNPWZhJn8Yngv5b
lzcQzrF6vTaAqFwYG05pCLM8Fmh59SWLoNPseI7RmN+y0VGyHUdrfxVGVreApgYn
mZo0Eifdsts/a/IPS7iZHNlxo49wtg==
=xaan
-----END PGP SIGNATURE-----

--97Qcf0iyghKpwfU3--

