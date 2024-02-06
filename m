Return-Path: <linux-kernel+bounces-54734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F784B307
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D481C213B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070512F597;
	Tue,  6 Feb 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmTHFtQx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401F12F389;
	Tue,  6 Feb 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217460; cv=none; b=GBHkJqVzRzWNOMKay5iovdv8UlK/G98AcVWPSl8r5Wr5v9534J1QmPoOVIKM/NbtYZ+KugWycDvdbCtGZOYqig427W2Bad6f/F+BtK472csBXjDV0y82/sHE9v/UoboZSGRP6z7knqi+vS65KNGoJznFIjZfbgKN22RMXjCVmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217460; c=relaxed/simple;
	bh=gzcsX8huH2OoOEsbTfps6ISpQ9vAvtg/B7cY90zS6jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4/MBCtneF0ZxBx/BaeeTLKc+Ff8/EG5KJEJoxCNJmCRgKS+JTYGcX70bWushTTQe7rd8Fi6edWUSq+awBC3E5Ot6KxqHw9gKvXrN1XMlZZQBjkixUef1fND5GZPZBZGN1sICAvaE2xivSC37ByrFSKKiQa6l9IwGQPTR4ZGVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmTHFtQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79B5C433C7;
	Tue,  6 Feb 2024 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217459;
	bh=gzcsX8huH2OoOEsbTfps6ISpQ9vAvtg/B7cY90zS6jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmTHFtQxchSjz/4p1ZEMZdHpfwnXvjKA+aeU5wfsZKfg/f8P2ewoSaS0h62P4XNc/
	 LfJYVn8cVZMuFVcMObKccGEmIP+njYZgGnqZTqPdp2JRUvXDFNPGfuDV1QI/L2/ZMq
	 w+P7jOjIDeuo9ckgTzNJqWbHPOWNUH3cIT2ql21udwoM6BfJPzc1PTLUFaoocNGIDj
	 vgqGs9lwFOUWK7DYtdr+ryyTFuQa7PyMD8EGbicn7O1IFCWfxaZ0upUI8JrxcXXs2+
	 Ngckxn6cdJf+SmWHI1ctKdF9k9SOol/aEpIjMQfAGNy7Ht9Et3dgfQkbNCIZTp/L2O
	 WZhEwrGdiTPlA==
Date: Tue, 6 Feb 2024 11:04:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org,
	semen.protsenko@linaro.org, krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, kernel-team@android.com,
	willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: s3c64xx: add support for google,gs101-spi
Message-ID: <ZcISMLoB2ytoQs/0@finisterre.sirena.org.uk>
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-5-tudor.ambarus@linaro.org>
 <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ja9mJkc9uGCH+QBV"
Content-Disposition: inline
In-Reply-To: <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
X-Cookie: You might have mail.


--Ja9mJkc9uGCH+QBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 10:12:30AM +0000, Peter Griffin wrote:

> The patch ordering seems a bit off with this series..I believe it should be
> 1) dt-bindings patch (docs first)
> 2) Add the use_32bit_io flag / functionality
> 3) gs101 support (this patch) that uses the use_32bit_io functionality

That's the ordering the series has?  There's a random cleanup patch
tacked on the front but that really ought to be separate anyway.

--Ja9mJkc9uGCH+QBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCEi8ACgkQJNaLcl1U
h9AySAf/ec5kYuEMxG3Ia3pIo8q3/8//Cq9AZUCVOlfy2/I6nt15cefsUTU7bcHp
ntBBaa6IhMUu7zvuTtZWuCY8B5xSMbiIW2DHxHWEdg8SDpNJQtGAhG33ES7MLnbp
QkYBKyT+xzU8ygb+IKDJbqZuzXtehF5IY5t763XgI+tiGGq+dCrblWqHv4W1382f
Gb7XdOQ4NOnlbV18cTMkDOdETQsOfGzfs8HwExld9WRYPIz1GsCzTC3BujCYmtcZ
8sCDAIn6ZaEglCmyjQ8SCdG6DlRDfp0haumo7kA+bn/ExN1JLAW08WSs2j2A/VqJ
71Z1O9KcPm5BYuS4rVDHBp3h/x2iMg==
=uBtc
-----END PGP SIGNATURE-----

--Ja9mJkc9uGCH+QBV--

