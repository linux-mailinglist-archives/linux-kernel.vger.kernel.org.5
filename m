Return-Path: <linux-kernel+bounces-95161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27923874A18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0821C22604
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAA82D7C;
	Thu,  7 Mar 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcet9SrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167F224CE;
	Thu,  7 Mar 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801293; cv=none; b=Jz+tT9PFYyODsUgvSi2Z2PzQ/upoBlnnzR25Z2yUGvr2VgkqHJSj3mxez6UEuWt9F9bThbBZE3B/9XVFbDsNASZgrpU40REQyKPFyukt24qn5QL+6yHbw+PsBoHuxJ01QppGiahreFCoYN82SjkKvPWpu5YxXokwvdJbmHjiPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801293; c=relaxed/simple;
	bh=VYQLq/Xh4cEXmRYUMYALH3Kg2KpEu/MRK9nSINY8EfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Pw+dN+oBMBiAge8cwxFj/Yq4ifqv9jffdxPmoLsZrrO8ddr6WCG9ZQQ1utU6PA84bE6gIyLbD/pkSQvgO6Faq1LoD+vCA/CpZZ3HQZsl+Qz3F0/2Zqd1S2OIzdmFBVDWz0EdPRyrPw8nY9tRCRE2+7RWOL7XzE4kIJZLXa+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcet9SrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43829C433F1;
	Thu,  7 Mar 2024 08:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709801292;
	bh=VYQLq/Xh4cEXmRYUMYALH3Kg2KpEu/MRK9nSINY8EfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gcet9SrA8Om36a1v2s79XhXp9nnyyclJtFXpJTBO+REiFfOJ0RoIT6VPnHx+Zsif9
	 LJQ9xFBKgr5WIFAo3AIM9csE3dALFTwdPnPNF4ns7zD8U8BcPIQJoYxciXcqwX0Lzx
	 TwJ8zH2YjFCf045APMpJdrHYL9GCUE500k6JKrOFZTjP5FjcQmW3WFFea9mzKcPctL
	 +TfRCe8SqFVmS+gpG2S1crQr46ZQCqlokGyBTU8ACAfIi9Ut8fuGZ683i8ljW0QOKe
	 hoFNyy3zUiPTQ+IdyAuxSBBQ05+zfcuhb5M/J3Nle2zJjGJ2dsz6u+BKQG2j1Gynct
	 VqWbn5JIaIbDA==
Date: Thu, 7 Mar 2024 09:48:09 +0100
From: Maxime Ripard <mripard@kernel.org>
To: forbidden405@outlook.com
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Message-ID: <20240307-hot-hummingbird-of-atheism-87503c@houat>
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pexrprnve3e2bgj4"
Content-Disposition: inline
In-Reply-To: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>


--pexrprnve3e2bgj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 07, 2024 at 10:03:50AM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Originally, the initial clock rate is hardcoded to 0, this can lead to
> some problem when setting a very small rate with CLK_MUX_ROUND_CLOSEST.
>=20
> For example, if the lowest possible rate provided by the mux is 1000Hz,
> setting a rate below 500Hz will fail, because no clock can provide a
> better rate than the non-existant 0Hz. But it should succeed with 1000Hz
> being set.
>=20
> Setting the initial best parent to current parent could solve this bug.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

I don't think it would be the way to go. The biggest issue to me is that
it's inconsistent, and only changing the behaviour for a given flag
doesn't solve that.

And again, either way, we should document it. And run it through kernelci.

Maxime

--pexrprnve3e2bgj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZel/SQAKCRDj7w1vZxhR
xQWgAQDk9L7KTLmixKOu3mNi4BDn3+1/TKlsTyfhf1yUB9cMXQD+N/nmhK3bQwSR
T5WItxX0WUk4jnWWQ5qSTWpgsEF0gQE=
=q0Ro
-----END PGP SIGNATURE-----

--pexrprnve3e2bgj4--

