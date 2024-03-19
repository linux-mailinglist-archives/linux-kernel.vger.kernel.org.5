Return-Path: <linux-kernel+bounces-107904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF650880354
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D8C1F22FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E21CAB2;
	Tue, 19 Mar 2024 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+T7Pfh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFE224B2F;
	Tue, 19 Mar 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869076; cv=none; b=IqBykF9YzYDoaNt4XBHCAOWezjgP/wGe0MXnOj09tVh1N5OkErf9ys1NK9g3GJJi9m+YYQV8nOfZdKVa+G07H6NW2wZK3kI70FKTZ4uqFdjyZCOTrST2LzYlcMrUwquxocZNU5GxX3JdkirJJDBJzkeCBtmvJ6Nd3KiIaLdKo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869076; c=relaxed/simple;
	bh=U7CbCyFjLydvSjfnUfIRPciwoVaztbmBFmc+BRFRz10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT7NHtMHgYTbQkIzuXrQyTPoYSANAdA8anDUIZLm7cBLMQdEhID/IFVtAt1955fgiW3BwHG7g+nklKXHCweQVpwKakGI8KUll+BXWHm4ZUdFohP+nVmlQZS4z1BQ+8kxn8TMGYyiQUEdWJPbA9nAn7WCCl8sa+l/N+paPrEhPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+T7Pfh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B5DC433C7;
	Tue, 19 Mar 2024 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710869075;
	bh=U7CbCyFjLydvSjfnUfIRPciwoVaztbmBFmc+BRFRz10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+T7Pfh+x4kg/wi9odomn/H6dSSgiXZthIJ+MyrTOmH5/PWeWsx09bI0P70Ws5iOV
	 0ByOguj8ewD0dF6xZ8jOzyrZbWOtVv399zMQxghygGWsZZXG80bwW/jZ6CebrltMBn
	 SomCJMEOBkTr79WTsCXvz+mKy1J+vz6Rrldn/SlS760vZeW6TyIrdJ+vKsgZTjEb6M
	 EKek/mTrJIoaZKIiz1NIvzP5GQdMov/lYEb/O8fPRxV3zfi023rs6jleJVeD1f91mV
	 0od2ukYUYCVHv4l7zOBiSZjenDu+3Y7xRF7MqcHYww+A201XfsxZpS7eNCeq1+YXLk
	 nihTozkAI7IZA==
Date: Tue, 19 Mar 2024 17:24:30 +0000
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
Subject: Re: [PATCH v5 6/7] dt-bindings: iio: adc: ad7380: add support for
 ad738x-4 4 channels variants
Message-ID: <20240319-dice-overpower-b551ccf08aaa@spud>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-6-ce7df004ceb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1YE01LAM9wdFxmi7"
Content-Disposition: inline
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-6-ce7df004ceb3@baylibre.com>


--1YE01LAM9wdFxmi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:11:27AM +0100, Julien Stephan wrote:
> Add compatible support for ad7380/1/3/4-4 parts which are 4 channels
> variants from ad7380/1/3/4
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>



--1YE01LAM9wdFxmi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnKTgAKCRB4tDGHoIJi
0sqVAQDlnpYjSM6Fvba7o1vgq4n5c7KGSi4udvQpm384U2RN0AEAmwemHzNjHj2p
r/WBQmKlt23T/dldXwF4ejBtffZQ0g4=
=QpFs
-----END PGP SIGNATURE-----

--1YE01LAM9wdFxmi7--

