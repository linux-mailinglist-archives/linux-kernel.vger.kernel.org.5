Return-Path: <linux-kernel+bounces-61584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02C8513EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920451C21C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BF3A1AC;
	Mon, 12 Feb 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu3inE04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32F39FE0;
	Mon, 12 Feb 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742772; cv=none; b=tNcIXqHaR0UQcwX4t+yb/NAPWlg5CxXjF2AO0Mo9tY1zQ3BtxMZdJslOidtJEAnNeHXxhPZ8xK4D322Q3Kmo2ccd7gal7YXYdE8K7MjIWyZNRJXcZrZ5e73eTQ1fEfjPE/BGcBGDEOhTmfha6iFTYxUfGxEcLszjx+W9wFiEIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742772; c=relaxed/simple;
	bh=1nogtJEW3Eo18xq8k5h1t+4sQf2sugnAKYjT201GQjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFuTOpJel7MmHEZf0AMor2LybA9hcfWuy1sKloQL41KcLCaeVP9oW2DIAyn/iYGDjTkFGNVcYq0la7scVbfCP/LvJsLshiuNklEhhkSCaWmO/g6GyfpjzvYIID+dKVSKMzC7a5sJ48cJ2o+Sn/PevCPvZgFHcDKza8cpuDSSOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu3inE04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80710C433C7;
	Mon, 12 Feb 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707742771;
	bh=1nogtJEW3Eo18xq8k5h1t+4sQf2sugnAKYjT201GQjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu3inE04rMM/ko4QeKnUlHSlqZlX38l0KeAf1NZOfttlaHJRoZwUxMC4gPJp14mBO
	 iiQ8ksgThxL31uhUGTQcqdTQOBiE+c7yxxZ1d76PwLuCLJVUMo//uCFqYp98nzDUHP
	 NTFW7lOEGsZq5W7wRH2lMjABp0uD1g8QjxbOVqwLNgIop5Ee+t82OZzebO17GCZmox
	 MhZALzxgMPKBLhxCPq7YxTygpj4wxpqFK0xk56nnv4gLzH8CZOGAQkk1y0Ko3Siqkq
	 zwFVO1gxoMwcnv3vliRNKSGKYlu1w2d6GOZ66Xtbxg4oSe3Ew5iaZQui0G9bvpHF8s
	 SadXzubpzcO5g==
Date: Mon, 12 Feb 2024 12:59:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	vigneshr@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH] spi: omap2-mcspi: Revert FIFO support without DMA
Message-ID: <c398a28b-8fca-483c-ae1d-588c2c081190@sirena.org.uk>
References: <20240212120049.438495-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FvA/jGDwxrfhM6U5"
Content-Disposition: inline
In-Reply-To: <20240212120049.438495-1-vaishnav.a@ti.com>
X-Cookie: Will stain.


--FvA/jGDwxrfhM6U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:30:49PM +0530, Vaishnav Achath wrote:
> MCSPI controller have few limitations regarding the transaction
> size when the FIFO buffer is enabled and the WCNT feature is used
> to find the end of word, in this case if WCNT is not a multiple of
> the FIFO Almost Empty Level (AEL), then the FIFO empty event is not
> generated correctly. In addition to this limitation, few other unknown
> sequence of events that causes the FIFO empty status to not reflect the
> exact status were found when FIFO is being used without DMA enabled
> during extended testing in AM65x platform. Till the exact root cause
> is found and fixed, revert the FIFO support without DMA.
>=20
> See J721E Technical Reference Manual (SPRUI1C), section 12.1.5
> for further details: http://www.ti.com/lit/pdf/spruil1
>=20
> This reverts commit 75223bbea840e125359fc63942b5f93462b474c6.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--FvA/jGDwxrfhM6U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKFi4ACgkQJNaLcl1U
h9DIHQf+Izqcz9/QEFJXOj6QzMkcnVA4UzcMXMui8KjZagPwkHid1G6Fsa+9O2uy
05jyM2XVrmwbulN+XHfXgWBBRNfe04V0WDoYw4/6LOBt1QtrX93eB7fQj4tfrQZl
vwtCBjEB4j4h69zu8DBOq5qVOOMMHgkUGj4t/91eXLchhxEvUbKj+4qjHQmoVJch
EBI3qyVRNaCJ4JTF9uhHqmVCBtD3pwAgZnLs/TDr933TTwB5DW404RqZp30e90pU
gLBDOsu+G8TtHJYdgWlc6sHdNZcSeO243+EFWCd0BT0YO9yjwfOt9S7zUBRKEeNV
052KBiCOb9kH5EKJx/GDnHsZucCYeA==
=d5+n
-----END PGP SIGNATURE-----

--FvA/jGDwxrfhM6U5--

