Return-Path: <linux-kernel+bounces-107890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE6880312
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0655F1F25E79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597D225CF;
	Tue, 19 Mar 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NObJJsxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD26210E6;
	Tue, 19 Mar 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868254; cv=none; b=IAs4A6uVKu+bMwecvNMvsYL40SkDp0379ZqFghorafhJpETE5jfx6X//kCVHt6UQSjMallW5rmtrI48AKLkkPNDmp3XSBdpzumyPOTIniyF9Z7GbKyTrIu3+GWlZlZt3fPMEtVrr1oZpwK1lKt8+Zc05aoAsb/c9sUxBODKquPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868254; c=relaxed/simple;
	bh=iE7hgBUgh9pLwag2DUIbFk0wKbpQx/A8AbEUFmM4glc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxMrnh3wNTSf/ariHHMZERbbuAY+RVF2h3WUqILwTFUF9tkdgwu38tBa343ChI6Mf/D10eSM5b19es6qzF4phTQ/Y9oBmDTG14HXS2uCVvLY1NR7KJPrHLfZVHd8X5fNrGY+yfvb1ni2wYfIdvoJ7HS7E+J0soQcx/Wxf1dYgAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NObJJsxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8521AC433B2;
	Tue, 19 Mar 2024 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868254;
	bh=iE7hgBUgh9pLwag2DUIbFk0wKbpQx/A8AbEUFmM4glc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NObJJsxosq3j1km2UrMN6rdRzfL829XRC58cKfSuiqCNrbknyROut7IPyYYQlY9SD
	 YLyMw8EdLuid+yu/Ho1JWmzWl56XFbYHWF6xljmzWXgwK0hZnN0Eig/OyEL/pZqVte
	 h9cikC6PWtM/3TFVz1CMRXpwBdBF3kzQyChCon2Dbgq4I7ju6HD8ZNPQytBstIy2PT
	 t+sngo7ZhbpQae+iir6byQuIIXddOXIaH452rOrYhxD++L9eQJqOy9SWfuO2gD2/Yz
	 JlnsfY+mFnJnefozuBKAP+BOw0sC5yiqZ9KnO4RTy70tDnhEZo2FuZC1+JRw+psimN
	 9JcPdpb89kv7g==
Date: Tue, 19 Mar 2024 17:10:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: iio: adc: ad7380: add
 pseudo-differential parts
Message-ID: <20240319-clothes-resisting-1238980300e1@spud>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-3-ce7df004ceb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AAHZqaSZHdYHsTHM"
Content-Disposition: inline
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-3-ce7df004ceb3@baylibre.com>


--AAHZqaSZHdYHsTHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:11:24AM +0100, Julien Stephan wrote:
> From: David Lechner <dlechner@baylibre.com>
>=20
> Adding AD7383 and AD7384 compatible parts that are pseudo-differential.
>=20
> Pseudo-differential require common mode voltage supplies, so add them
> conditionally
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--AAHZqaSZHdYHsTHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnHGQAKCRB4tDGHoIJi
0vACAP9iDMvhw9YrBRGMQEe5Lde7Eerkrn7w61VRAmvFtLtY4AEA2zYUtehEv4EC
rIsHRfp4TuYdHPxxvm/2imbwxMb8ogE=
=yaS1
-----END PGP SIGNATURE-----

--AAHZqaSZHdYHsTHM--

