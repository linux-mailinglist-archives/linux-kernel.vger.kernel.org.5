Return-Path: <linux-kernel+bounces-55241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01F84B998
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9AB1C244A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D213474D;
	Tue,  6 Feb 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw+/SwMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6813340B;
	Tue,  6 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233336; cv=none; b=XnTInsFK4oCMYVzatM706hMla0fX9357qNMDEAa1ZX5BNXufakGEH+eVI5zJ8tRIRudiEUeYpbLPnh/1KRqqlMb4OTNztz1wwWnB5NBiLfwNFoJYnd0FM96VtyLB7FZzdZ4rroVhZZjcwxfg/F6in+5/oFoXgFjKDdyCldJfiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233336; c=relaxed/simple;
	bh=0B6z9WUm+wm4+eEFAQ4LZJYPYRNQYUG56FGmUItdu3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4s9WgoGOM8LoObUr48TET1Wc4AZzVXGC2oECQsem2y85WWFJbQhM9TG0x8yzsDENa+JPUimhi3ENWMauQ6q0YrAMjV3XDIP0NDmZ3gzUh9m5DXoiYu6zxrzk2Jz1cwc3zoxxld2yXRF0NF/Fwhk41DGIv8hmC5wPQuwWtF/RbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw+/SwMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D933C43390;
	Tue,  6 Feb 2024 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233336;
	bh=0B6z9WUm+wm4+eEFAQ4LZJYPYRNQYUG56FGmUItdu3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bw+/SwMGBd/gymwF1Q8uvowF/PY5q9amueMBrr6AWgzxw8gNUezBILKoW9hjAb6b7
	 Q1uVelvxOpIFr3lGB2h0hPZFJkVaEkdihjUy8C/LhVnfe+5RYlk1d3Dq+c5+usuoJd
	 OX44ZtAlpxBOjOWDQq29DasuG/GgsXMrf75DiMjhOUPwY7rugtP7sF4sGmRmtvOB/J
	 saqrqVpX3O71B+XZfzAgSAAlkBzyLSCYM3JTyKIxKgvNe6e0891NmV0Cgubd5IHeRc
	 12BAF2zXcn8FfzXtLTUt6+b/lOUWlcGn75mTi8sBjO0AS3Ex7yVjq6ZQF/7mhWweRo
	 e1F7jxU+5pV4Q==
Date: Tue, 6 Feb 2024 15:28:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Message-ID: <20240206-exciting-fructose-4d5878d1422a@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ad72f8ca-a017-42d2-9c07-f17f282264d0@emailsignatures365.codetwo.com>
 <20240206065818.2016910-1-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ZfiD3AFWwPF5+oU"
Content-Disposition: inline
In-Reply-To: <20240206065818.2016910-1-mike.looijmans@topic.nl>


--1ZfiD3AFWwPF5+oU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 07:58:17AM +0100, Mike Looijmans wrote:
> Bindings for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
>=20
> The device has so many options for connecting stuff, at this
> point the bindings aren't nearly complete but partial bindings
> are better than no bindings at all.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
> (no changes since v2)

I think you forgot a tag:
https://lore.kernel.org/all/20240202-lilly-dart-0968dbcc6b17@spud/
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1ZfiD3AFWwPF5+oU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJQMwAKCRB4tDGHoIJi
0mmCAP9qs/PmHbrjJ1OIpANRpeDNqUKl7RtjOKLMwNtFyMC+UAD/bGmZy9trKBUx
0dh+GzXR4DoOp+2DhNkRKx15eYDi/wA=
=UQO+
-----END PGP SIGNATURE-----

--1ZfiD3AFWwPF5+oU--

