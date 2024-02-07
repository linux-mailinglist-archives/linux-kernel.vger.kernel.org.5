Return-Path: <linux-kernel+bounces-56737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D666884CE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E11F21BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0018002B;
	Wed,  7 Feb 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV6L2pRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238207FBCA;
	Wed,  7 Feb 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320803; cv=none; b=fuhkxVDdyQXXgY+M3ag9Z9tpAQAzw9nIjf6fiz8ZZ1CiByEmi3lO2hN8xGHiH8dpGNEn3naNVXxR1rrbvx2EZTNSBiXlFSFnG8I9D03YGZtXKTqlX9Pkr/VzR0QZBBR2Ko2OvioRuzeFp0z/vM8kP6FXxmG6ci4B8bEcoJ2aPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320803; c=relaxed/simple;
	bh=sKNf3hN+lRaeZIXgt5dSXJk65CzsXamnoNyoxUWdcpI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMCPqf4yWE+NVNlYRadJWXhSxB4/nbcYNIA9dIXHFfeRahTzDRRGT3/hvj5br6wnoDrT8hXOlCG7v4OSHRf0Kfs0OttwDtBk7D49w2fp388RsRjefhT0RuGHa+U0id+gEStkopDgq3ohFh2KCqLFS+tazglmgr7fyhs6UJJL+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV6L2pRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B57C433C7;
	Wed,  7 Feb 2024 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320802;
	bh=sKNf3hN+lRaeZIXgt5dSXJk65CzsXamnoNyoxUWdcpI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=RV6L2pRyg7VesI/UegZzDUWQDdc1sCpUj+UYVWo9BKRAvrGEY/Ef8OtmLr0jqx+9/
	 6u1j58gpuTjaA1X4a8IVci7Q6l9ln64FDpYRvRkxTAVUJQ3LtHfoE4orQKusBx1Vvh
	 KaBVYJA7lCdGJE9of7vTkpaUrUinoq1A5cF2HTHDq6XMhcy975ByJXnF1ZPMLQ+yMu
	 yP1+2yB5qcs+CiexWRZMHGh6VmqwVB8UuDlgAI2JORJpnWHYkGd6ghENea3UfI5HIH
	 rl5FUzSX/WVMRF2V1dSD3wOg4uTUMugeefsGLQDFVwvJz+NO9VxQsLJvz8ldPVjqGq
	 vKFd10LgxcdBQ==
Date: Wed, 7 Feb 2024 15:46:39 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <ZcOl39IRjYpKBaY/@finisterre.sirena.org.uk>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
 <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
 <ZcIQVKibMmGegw+j@finisterre.sirena.org.uk>
 <ZcOg3JR9YW9JNxPp@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GiOcMxJhFbMI+zb+"
Content-Disposition: inline
In-Reply-To: <ZcOg3JR9YW9JNxPp@localhost.localdomain>
X-Cookie: You might have mail.


--GiOcMxJhFbMI+zb+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 04:25:16PM +0100, Louis Chauvet wrote:
> Le 06/02/24 - 10:56, Mark Brown a =E9crit :

> this addition following the above paragraph, would it be clearer?
>=20
>   [...] this delay).
>=20
>   The OMAP2 MCSPI device can use two different mode to send messages:
>   SINGLE and MULTI:
>   In SINGLE mode, the controller only leverages one single FIFO, and the=
=20
>   host system has to manually select the CS it wants to enable.
>   In MULTI mode, each CS is bound to a FIFO, the host system then writes=
=20
>   the data to the relevant FIFO, as the hardware will take care of the CS
>=20
>   The drawback [...]

Yes.

> > Note that you may not have to tell the hardware the same word length as
> > the transfer specifies, so long as the wire result is the same it
> > doesn't matter.

> If I understand correclty what you want is: given a message, containing 2
> transfers of 4 bits, with cs_change disabled, use the multi mode and send=
=20
> only one 8 bits transfer instead of two 4 bits transfer?

> This seems very complex to implement, and will only benefit in very=20
> niche cases.

I was hoping that the hardware supports more than 8 bit words, in that
case then it gets useful for common operations like 8 bit register 8 bit
data register writes (and more for larger word sizes) which are
relatively simple.  If it's just 8 bit words then yes, totally not worth
the effort.

> If I have to add this, I have to:
> - detect the very particular pattern "message of multiple transfer and=20
> those transfer can be packed in bigger transfer"

Or just a single transfer with two words, it's trivial cases that don't
involve rewriting anything beyond lying about the word lengths that I
was thinking of.  Anything more involved should go in the core.

--GiOcMxJhFbMI+zb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDpd8ACgkQJNaLcl1U
h9Awrwf/WSYL6hHrh/2g0K1QaxQHkaAT7BJB5ucVs/dXYdcO+hJjrYDUBuH6311T
MzzGtEFiHDtQ8SPa67gGZZXW96cbvYq2cyuJektuNUBhravfAo6pOMWH4Q2yUfDd
SZGldheoY5K4XUesqDfPJAdPgmDHFTfiSP9+LhD+RkTSSqihspOZsPruljGgIKNL
nHYKx2D5D8SnfHanImpy+OfImPLF4WuwkowgPbjprPuC8xV118/VN6sRBn6qfxGU
Pmu3b0srLXnKnJvHPOBPFDowOfWnQQ7UEAl1I/7Vngnl1erVBWmVfr+L99qCyjSr
s4wK91UIpdR7yWP8XZjOc/lZIupA5A==
=VH6Q
-----END PGP SIGNATURE-----

--GiOcMxJhFbMI+zb+--

