Return-Path: <linux-kernel+bounces-135329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E089BF15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38D28255F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522F6E61B;
	Mon,  8 Apr 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPI3/ciX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586686D1BD;
	Mon,  8 Apr 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579890; cv=none; b=ldSQZ4EXMP+6CBfq10La0czkpcu4jna2lGzY9/1XHo+l29SPyxzfnrDE9VspPjsBBYtnWfrYpBPjfV7WUNe0VFBRyelUorVkKRvKhXhQ/C/yA49EIlORz8JT1usWqsYZ4ij4Skcn69i2ciHLh3rxq7NYP56EEq8jGCJANW5jJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579890; c=relaxed/simple;
	bh=Hkg40jhbINXLqFTpVXvjEOmxgN5XgulsrRPcaO0UQ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOeIA9D6DupM2RDivU9BeV/gvkuk2E5xoWfnG5kmb8au/H9/u+kYsvC3ipsyfA7q07FH4UgeqQBo5Kz5kLqPraF8ZhAmvAJU7oCm481NBkeG3/umaiaj0PPU4QcBpDpx6R8Ea/1+QFkrl0VqrxZeCOPMhDjnJ4ziaBJGRq59ueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPI3/ciX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A22C433C7;
	Mon,  8 Apr 2024 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579889;
	bh=Hkg40jhbINXLqFTpVXvjEOmxgN5XgulsrRPcaO0UQ5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPI3/ciXl1zHVeFZPzfNARRYcWv535Vc6CFg3mPa3lcZSZKMDCvi5KwIMLX8Rlmcq
	 VOVrqM4Gc02OJa/WAnO77eASgkVc33g6IL25nbOeseItXFHCeSYwwkT/4QzWW0X7UN
	 DFnacQ9VuDzOO5GMAIA0IsqjqUC+WYkJQdp6F6ySP9QDwUCi1GxFxfLA92tzxn4JIs
	 WdPq57e5AIzJYaPGxYDJfyuglgDEUq6yzoRgOB35VcglsgtD1usPfVcXZuLzUHJZO+
	 QuMlagTYjAAoJ0+PEJD9vOViEzX5w39R6fgu6VE/DaO0pyFDs1e4V6X7q7cYs8bBJo
	 0PyCNbXGJwg+A==
Date: Mon, 8 Apr 2024 13:38:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Dendi777 <end.to.start@mail.ru>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dendi777 <starrynightowl2@gmail.com>
Subject: Re: [PATCH] Add support microphone for Acer-315-24p
Message-ID: <b107a545-fac5-447f-87b3-f67d34ca775d@sirena.org.uk>
References: <20240407123708.11711-1-end.to.start@mail.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gyKAaL9Y2BcWkS6f"
Content-Disposition: inline
In-Reply-To: <20240407123708.11711-1-end.to.start@mail.ru>
X-Cookie: Drive defensively.  Buy a tank.


--gyKAaL9Y2BcWkS6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 07, 2024 at 03:37:08PM +0300, Dendi777 wrote:
> From: Dendi777 <starrynightowl2@gmail.com>
>=20
> Signed-off-by: Dendi777 <starrynightowl2@gmail.com>

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--gyKAaL9Y2BcWkS6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT5S0ACgkQJNaLcl1U
h9CHKQf/Q6JsvNSKIK2fHSgweIbzIpk64WVTQcltyBtHK/XJKT7UNxy3OchqkxCy
4gy6rY9qAiH/53ZpC1KXYlXspqniwpAu50pIS3UUyTGn4s+W85b666cR9o1rWVz3
zloHCeYQ7cKr2cO86cgk2Rqu/cBUpbCKWymfIVAIArw+NWrFsmu5UDy3aiPbuFu8
UvimfVUCpw8sEfZ9UvzQ8pP7fb6598Mxjv7x5UnsoXJd7X9S2o4X3rgbyTs2qzSC
Tcvn2AmG+vrk8BApnb8hrZkrhCDrIf6+VyRDpHjQVN+D1enJFm1BIjUDZcuXApNA
3Sd7HNUAlEA69ko0RGFRAcqkF8cwmQ==
=nwQy
-----END PGP SIGNATURE-----

--gyKAaL9Y2BcWkS6f--

