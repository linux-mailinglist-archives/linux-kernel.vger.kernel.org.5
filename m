Return-Path: <linux-kernel+bounces-121651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B821288EBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B4E1C2C534
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FE14D442;
	Wed, 27 Mar 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq8/0Qhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DA12F583;
	Wed, 27 Mar 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558321; cv=none; b=B6Z2a0CMl4wXZR1fi+o07BwuLB12rQ4aDFXpOILOdSbcSE6Ovg/pni7Nk8YLyMpD/mIPv3YsUkJzTdTX7uFEDIP+zfrlOm4SFDVptTOd8QAQeI0ysChnVQwIutnCT/4rsAdy36kZgXRaA9VjLzJry6zcSKenUR028Xfz0kxMdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558321; c=relaxed/simple;
	bh=vGa/5LSrYaiaYug30MkM2Z+JpwPdbnbDxQ9SSbua3zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUaz53pth7mH8hv0lvRxt5hjaqCFyDrLN8MHpZDZBRaqCtn0k0R+OwLfddh0OWJX8myZzoYvISIGIp/RHBSwbDg221rG+x69dbSxNmZ6M8DSbK4yjKtgOQSk+tiSZWzNhjsj4OLjaamIHfRht0Vt6Q0cXfku1ZV5JYHbfT9LpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq8/0Qhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB2C433C7;
	Wed, 27 Mar 2024 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558320;
	bh=vGa/5LSrYaiaYug30MkM2Z+JpwPdbnbDxQ9SSbua3zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nq8/0QhfKm/6T4WRiUCnXBNL7EgDSMnFYco8UGa+WjzoUFfWD/2BIlFtKddAUpiCw
	 SHUpjwQlLdJsl8lVyhkdqvMm65mY16gE/J7HBNWOVxENY5UAysJRDfl5sqF5c0JNyr
	 h0hvmjn7lFLPQJvS3Z7KtDKEEzjHYaRLCJiBKel4yrAaxLuvtg6k0t8oCJ3AqlMLs4
	 4ZWaVZtFPqFXEJrlHNEN/iGQm0YnFf3SV5Lmg8RzwGQBv/+UrmGxhwLybnCcf3Lo4f
	 cDDWbdFi6cMCb6MPFZ3jWqpBnh0XodcAja3hZ00pI2JoqLhOksXB9nh9apRvAjHQl6
	 AcCl4ZZpEXPXA==
Date: Wed, 27 Mar 2024 16:51:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Message-ID: <20240327-attribute-stubbly-d09613567e0d@spud>
References: <20240327054911.43093-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q4yJu5Wdv/6XRByF"
Content-Disposition: inline
In-Reply-To: <20240327054911.43093-1-animeshagarwal28@gmail.com>


--q4yJu5Wdv/6XRByF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:19:06AM +0530, Animesh Agarwal wrote:
> Convert the OMAP SoC SHA crypto Module bindings to DT Schema.
>=20
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--q4yJu5Wdv/6XRByF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgROrAAKCRB4tDGHoIJi
0pFMAP9n3jW8OryZ4mHv3zyHwxK6eIojAxWtHLnmuWRimqzyJwEA5giBNZXRrjP3
cfIqiw7p3Fg+YEuMn9lNMZriRrJAewM=
=ffKn
-----END PGP SIGNATURE-----

--q4yJu5Wdv/6XRByF--

