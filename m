Return-Path: <linux-kernel+bounces-89104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B5B86EA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE4A28D1F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9898A3D568;
	Fri,  1 Mar 2024 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JanC+Tna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4C16FF2A;
	Fri,  1 Mar 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325766; cv=none; b=cLHrMAsmZUGdUDqB229oeZ1W9g33xsV3k+D5eCd0toc2PP/7hknmLlQcR1qdWoNWo1ZrPCQtHG9s9zbbK6ONnWds1xWYMfJVxqaiSaHEKDbQI7RpGIRsiNUnvRj8IzyThpKf164x5iKNIBcQdJVeC9f/ep/8L+ydqkBnV4/zbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325766; c=relaxed/simple;
	bh=73uTaA7d9xcbo8r4tapptpkNEAf8G2KEmjwaiwApfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvBPER14lpadq2IOKGnKiYO32kBMkq90NY+D50+E6RLSQzhiElbyQEFjC37ZM+0Uf3FwYfdU1ZKWHI8o2sDMz+B/3ZIkoHp8+EfN1c6LhoFkYELU3zQcmYOA+CHoSpYGPm704rknRdnjtFADe00icKBlelPadlOqOMfHCjR+e3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JanC+Tna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C19C433F1;
	Fri,  1 Mar 2024 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325765;
	bh=73uTaA7d9xcbo8r4tapptpkNEAf8G2KEmjwaiwApfsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JanC+TnaakLG12kECCD3MmA8tdR4b9z77LSK1XXJKokE5aR4fG5xvf3pvpZTZ2TbW
	 dG9zZ61DShqUUMwRcvb8vdvWCjkOjgyqOhCPBGZJJaAMcewtTEiDYGs/GheEmHQy5u
	 QLDvjiqkxCPFRa/D3vsdqL9UAfEXDnwzLvRmOuspK26WLrQW/kYFNIOL4sJAd0v688
	 cTBCE0prLNZXXPKHY/GlnjqrYIifbQegMlSptNZfAiHT663h5dzCNkDc6eWaJhdeZl
	 4E4yREyPc9WhOO1eeCVt9IND4QpDZyWnCd+YQN1F8JXYKO7liSw189d9M5WHcAqNkV
	 86a2b4XH+xPPw==
Date: Fri, 1 Mar 2024 20:42:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, willmcvicker@google.com,
	kernel-team@android.com
Subject: Re: [PATCH] spi: dt-bindings: samsung: make dma properties not
 required
Message-ID: <cb426fb0-2f27-4c9b-89f5-7139354ea425@sirena.org.uk>
References: <20240301115546.2266676-1-tudor.ambarus@linaro.org>
 <CAPLW+4=6oYcs0NPXo4ffLiCvtNQ-tY1s_isaxTX8dcPkV56xMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MemfwNmSGq/zcA3d"
Content-Disposition: inline
In-Reply-To: <CAPLW+4=6oYcs0NPXo4ffLiCvtNQ-tY1s_isaxTX8dcPkV56xMw@mail.gmail.com>
X-Cookie: Schizophrenia beats being alone.


--MemfwNmSGq/zcA3d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:28:35PM -0600, Sam Protsenko wrote:
> On Fri, Mar 1, 2024 at 5:55=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:

> > Since the addition of the driver in 2009, the driver selects between DMA
> > and polling mode depending on the transfer length - DMA mode for
> > transfers bigger than the FIFO depth, polling mode otherwise. All
> > versions of the IP support polling mode, make the dma properties not
> > required.

> AFAIU, the device tree has nothing to do with drivers, it's about
> hardware description. Does making DMA properties not required here
> mean that there are some HW out there which doesn't integrate DMA in
> SPI blocks? Even if this change is ok (I'm not sure), the
> argumentation doesn't look sound to me.

I do remember there being some SoC which shipped a SPI controller in
that configuration for some reason.  Possibly one of the OEM ones rather
than one in a Samsung SoC?

--MemfwNmSGq/zcA3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXiPb4ACgkQJNaLcl1U
h9Ap3gf/eN7JFZQiBhvsOUiRAENty3XADwJD6Dy7jlfgRduqmhzKOdfa7IlHM/wl
FNIUAWf+T27AgQJjSXEXbkmON0RkeJVpWCbZoXJV9Rr2z3Xhns2wasphCMBDmtdE
oMVIohHuCe61P/svZ4zJ7//pdXxFGVvMe44Dwz1uJvbtu1SiUv2GQQ5CV5U4fUhy
Tav2FbYNzSZoy/zqsve97SBxVm6Fme8BCiTMnPvyrSbuA+UJ7/s2A243HgCM1VHA
bFpNa5zVoSbiHkI4d+s6Fo/RlOV2fpwgXTW/s4BhHYjhkgTb+Qvd/jGN1ZmPC++F
NLsnijQPfxAvIWgh4QAwhvhm2NkQTA==
=aEUe
-----END PGP SIGNATURE-----

--MemfwNmSGq/zcA3d--

