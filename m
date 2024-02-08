Return-Path: <linux-kernel+bounces-57975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95F84DFD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3761C22E53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6F6F087;
	Thu,  8 Feb 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHjFfK91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C66E2DC;
	Thu,  8 Feb 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392278; cv=none; b=mzK62N0bOHWzT70+ozuYdfdL7Xz4eAGm2wKQI/tGUZRAa6XR9iZU8UWwoovBxWCaihKn7yAFbXhDnbNfVSww+2ErMaEdq3LgT8GR65mq3docbIcYnduHteA9SxuXzIRfpvNwXD5tU8jGFjRE/hkFRB7TylyXlsnR6wymQsm+RWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392278; c=relaxed/simple;
	bh=r71RoIKN+p7IBDsZxy3keLwQy6qjvh5Oo6IsPvi4Tis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5/elzhyzcYkdhPWxgdr+iJSRpOIZpvT5+NcKHECoinsR7n1d2GPEF3b5WOK0gTd1+cATfN28qL7EmZ56truW5GAu2QszTiBHYLu1zrNTPS0v3uzhAj07BkpL+l9ppKGw90/mF7fIzQAg/ujT5WrROu6vX8P5SxXaBBQOIQLcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHjFfK91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A63DC433C7;
	Thu,  8 Feb 2024 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707392278;
	bh=r71RoIKN+p7IBDsZxy3keLwQy6qjvh5Oo6IsPvi4Tis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHjFfK91dIuW9AMFWub1Z+oEXlaXk57o4+Ixv+EAwjqiBeWl2rwu8ARxmArj0N6se
	 4nnZObUba5Nx2jPwxEjAwURTJL9Dr3Md/XIpb+MPZ4H5ZznpUJWR4sw/7153MAxwEX
	 qUXcO/2Vb2Edka+umtf+LQggsUB+ozia6PPiRsg/EifbG0s9R+AjsfW7dA9GugsABK
	 rbyU0iEie4+5KekGPjdbMW0wxnfGZCTK2TV8p2xtpC7CBBzE4+I7hghJBbQGbL5PYj
	 ykwfNmqWNdZWX0UuDnAlLEg81aUFt00AfVlTSeOzEQiSxF3Sv2TYKygio+1hGuU2+U
	 cL0IWzUE64oAg==
Date: Thu, 8 Feb 2024 11:37:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 07/44] ASoC: codecs: wcd934x: drop unneeded
 regulator include
Message-ID: <ZcS9EmcM1rtsNYy0@finisterre.sirena.org.uk>
References: <20240207212142.1399-1-sashal@kernel.org>
 <20240207212142.1399-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y3Ic8DwDm+OAu+TF"
Content-Disposition: inline
In-Reply-To: <20240207212142.1399-7-sashal@kernel.org>
X-Cookie: You might have mail.


--Y3Ic8DwDm+OAu+TF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 04:20:34PM -0500, Sasha Levin wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> [ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]
>=20
> Driver does not use any regulator code, so drop redundant include of
> regulator/consumer.h header.

This doesn't seem like an obvious stable candidate...

--Y3Ic8DwDm+OAu+TF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXEvREACgkQJNaLcl1U
h9BN2Af/USv2MQK7rWzBfIWGhMZ4Xk4a2piJqomP7DM4NMIIDgUMNwjDHJjGLnt6
n4IThpQeGFxDWva3CapyOTthWZcu6KvzR6AzoiT0+aEEvmJ7USKck6KGqgkDZdBG
vgY79RdHhNsVSvHMqHhl+66BkUzhA1Pz/Trn3HrxNYZbiVAIuqZWY73sgbSVXYp/
g/yzWtGih1JY+CdXGOsdPObR5pI9S40ptWERUhppeB672t+yY/TM86HXpXRqpVKA
YJ7lXThB3kZaCc2t1LhGEmBtgxdBzAfopPldgpfJrb/eAVauMV7N/M94FalJvwgQ
zPb0RfE3fKuJW/VnM1ljgNxFwL04zw==
=wjDO
-----END PGP SIGNATURE-----

--Y3Ic8DwDm+OAu+TF--

