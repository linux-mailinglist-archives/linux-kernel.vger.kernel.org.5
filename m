Return-Path: <linux-kernel+bounces-56277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4AD84C83D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7916B286067
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69941F606;
	Wed,  7 Feb 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkF2HPDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C02375A;
	Wed,  7 Feb 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300338; cv=none; b=Pqc+RAgMp56Cmt38rXr/++K4Hn41Y3T1RSi6IPLXLHA2EXJzbR7z0tSzexRC9+sh0sUXj071hU+yzQPUR3oqZnIr2abYKt+bjSy8ge65GAL/CKxbF7Pw+6+2+PrjQyWED+UXmUTB/m8rmJ4H7zoEfqZB4Xb/AYe4fNbcD3tLoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300338; c=relaxed/simple;
	bh=q2EuCXnqYUlYfinGz3m4npjNnpfPuFbCD21Dba7LXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBcvc7g9KG7eH0iETxlarNxnOLJC+6BRUNF7aPPUxguQAa4xpMOnDoaAfb6p/C2NNnx2maCDgZZloWUqLGY4damQZ1qCT7nm/9ugbzp+3zYjsRHzwknfkwAPIG4pFgGPlbFMRPA2cu2rRkH50xJUiWbYOMBA4FIg78E2t0noiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkF2HPDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D24CC433F1;
	Wed,  7 Feb 2024 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707300337;
	bh=q2EuCXnqYUlYfinGz3m4npjNnpfPuFbCD21Dba7LXr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkF2HPDCaI0fWX5jU57zPVTjBcNHF7KpasSvdapBWZ2eVas/Gyqxb0868v6ZTMX9C
	 5DWkF6IS/9TDRGK5Irnw0AwIqMHIaucyK3HwNoTqi4RtGC+zOcMqOq9155HjBmf4UN
	 8ym7jkirTv1bxlnhEVmgs+6cKY4/Bq2XIUqD9bEu84JKKKfcZKlNPe+C2o5lFimzrg
	 Ky3MgRP10bQyw07P3yJSAXMV+jo+AN2zgC96pdljScaCaTX3YB7mth+7ZysQMmAiIP
	 sCWZkc2WECeMcWrASamreuxS12TjXAprQP4du1MHocFm4blsUhOC35g6dey3drOyiI
	 YRgyQOTTz8rJw==
Date: Wed, 7 Feb 2024 10:05:34 +0000
From: Mark Brown <broonie@kernel.org>
To: frut3k7 <frut3k7@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Message-ID: <ZcNV7npRS1kCWln0@finisterre.sirena.org.uk>
References: <20240205191808.998754-1-frut3k7@gmail.com>
 <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com>
 <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk>
 <CAKEyCaCQk+iL_zOr_0LFOA4Fw+SwyuzSWOvVgmO0Tn8Ygv-4hw@mail.gmail.com>
 <ZcI9tWsthu8XMiZ1@finisterre.sirena.org.uk>
 <CAKEyCaC79kMoNSOOs1SREsvEGMGWPftqzDDMebvTVKDvTHeCMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QkRgC0sTdLuJfNZu"
Content-Disposition: inline
In-Reply-To: <CAKEyCaC79kMoNSOOs1SREsvEGMGWPftqzDDMebvTVKDvTHeCMw@mail.gmail.com>
X-Cookie: You might have mail.


--QkRgC0sTdLuJfNZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 05:48:04PM +0100, frut3k7 wrote:

> Should both patches (spi and devicetree) be sent to two projects
> (Linux SPI and Devicetree Bindings)?

Yes.

--QkRgC0sTdLuJfNZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDVe4ACgkQJNaLcl1U
h9BEgQf/WwASU0EVadR9EaYWsLEfHC32o3Tr98ZAS4dF/ktZay2YCLcnp2g6g+G5
BAMLePjxJpwOM/+7S6RMjA34X+r2ZKlGxKGOHIjo8SDEOmGDSoMeODwXRY4dGTTT
Lu5fpa6z0AjB1hTfouZU+DsOKGgzqlEZKFht9sl7vNQ8iGNXFj6R4OQsd3chKo12
xHBrALcYNCR+uhGXaarSxMgPeZw4I07UDdt5TFlLnR4j7bUqs87OI+x32ZfRuS5N
QkespbvbgneLddqdCN456vN30Y9JD2wc4iy/2GKdUSOzeFb+2QughVE41EqCHt6/
GUkolEQZnZaZPHFNlyrXoWy9z8ljHw==
=FEH9
-----END PGP SIGNATURE-----

--QkRgC0sTdLuJfNZu--

