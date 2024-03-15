Return-Path: <linux-kernel+bounces-104535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216C87CF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A6B23703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D193D575;
	Fri, 15 Mar 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwAbuAOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40526376F3;
	Fri, 15 Mar 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513947; cv=none; b=G4wOpbtDbIz27X65g/kUryl40bWgBIfyCtjjHyMlzxH4DAkY4JOP14a+Io9wvjLqYJcbCC3I4qAYhWV9K7+Rof5PncecBcOHqe/o/JFRP6F8wity/lULfvvP6Phi4CH+B4uugswD7MSYyCexlKifRVcArKfnCWfrFtcnHWSgG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513947; c=relaxed/simple;
	bh=9KgzvuLdd3AxeujNNFtwWLhmYlvMjhxtwsKL5EtDbO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj0jFWONVZ8qiXwmfzopjxDmROEWcJPSmLdc/w9XaUOVRmvb9WTcXch0WFb0DUlSPGOwvc3NiWsevH2FAq5enmtpycxwfyy9QqJ9HqbtHksW1jmRufsxtpoTuIXtbCFqwAzgkqlVqqrOk40B3kAfra8PgKOgO5zzeTEVQGzt9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwAbuAOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B01FC433C7;
	Fri, 15 Mar 2024 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513947;
	bh=9KgzvuLdd3AxeujNNFtwWLhmYlvMjhxtwsKL5EtDbO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwAbuAOUF24KUYuVFfjHyByrH/MI0YWhdhtAls7EY2ent8cTFd6mmtDijkswIfRMO
	 Qukm4OE7NRQboayw/LC/wFRb0Yg2di9zf3pKXUufI8Z/H3DuOpZd3Kb4739V9nmbHt
	 dOV6Tt4UhS0U3JpipjBiBkVh2W1xkxr5Aorhh3pM75Zkz1VKGx+ZqVzQB42x+VXE8Q
	 LWkpjGGXsEsDT32fgg4DMJK6GU9oTdKjemKjmvR0q5dEc89PM886E1Sryujp+CTZIL
	 gRtxsDt3v+Qab1UlprormELzh3MCCbSXoF4bwiwaMndK+zqU5ZV/chZGztkLo3PKEk
	 8ccjds/8P48ng==
Date: Fri, 15 Mar 2024 14:45:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
Message-ID: <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
References: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OyRZntc5+wE1SuZv"
Content-Disposition: inline
In-Reply-To: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
X-Cookie: A well-known friend is a treasure.


--OyRZntc5+wE1SuZv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 03:57:07AM +0200, Justin Swartz wrote:

> Add the mt7621_spi_set_cs_gpio() function to control the
> logical state of a GPIO chip select line, agnostic of the
> electrical line state and activation polarity.

The core should handle GPIO chip selects for you?

--OyRZntc5+wE1SuZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0XxYACgkQJNaLcl1U
h9C4hgf+P0Z2s4lUknxJY2qju158/5Yhp5TQKmCuE5LrsDTuzpONlYkMibA2coZq
F1UsonXCPisW6sJGBr2WIDEu4gcNvm3CJTnr04+xft7wYfS3jR0Yf0W1L4dKCQX2
O6dP3AQ9cBv4+mgtiCJqGlb81gxBynV2VtDNMiLG3gaXfUh11GnagVfRhGUrk1oS
eP9kFc0S9oecHnWmBk4Eov+HoKkv5mNouc/fJBAS4rqZCZPN5tYWC4BY8s8BzJ9U
Qi/8fxX4QjWXbp1ohhcuMT6w6eSd42ELyRTkPiJeZy3Kqnjgvpb1JtU4HMbhkbZr
P64TRRrsqBE5MgWO9N2uWEjHQEwO7Q==
=/LPx
-----END PGP SIGNATURE-----

--OyRZntc5+wE1SuZv--

