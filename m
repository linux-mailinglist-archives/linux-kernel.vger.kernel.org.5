Return-Path: <linux-kernel+bounces-58590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6B84E898
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899541F2FB56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6F2E85E;
	Thu,  8 Feb 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeVDzwv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C731A7E;
	Thu,  8 Feb 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418349; cv=none; b=A9AeLfimFD3ND4gvrXm7qZUoOWnLmlRotFJpjCi1wNGTzsZw+UhGymiD1stE5D4LMNTEs1/JRFbxrSHjvxB83Oy6LdEwqC9uvlhrcaTxBxpJw/2BWqlUeYKecjXEcJ2SJn40JrQybPu0mBohUOvjLh86YQ5Z7vKc6Xy0jn8D8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418349; c=relaxed/simple;
	bh=Eg9z1FUcFH19toKXZnOKOyuQw5ciqSE32Ydq6NT2mOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGxuMI9KYgG+nTD/ztlnmHG2V9r8kgaahCJCubPFRNJpCObjVSLmFyEkGuLW7zSlWlg13ixazrKUES6+NkqeYxuo5xZjaQS7mhVd8PGUl2giQLfjHZtFD3qAM4R+Opz2j4gU4GgXB9/J+rQk+LtBjmo0KEhz/AEAavLH8H3gzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeVDzwv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D4FC43394;
	Thu,  8 Feb 2024 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707418349;
	bh=Eg9z1FUcFH19toKXZnOKOyuQw5ciqSE32Ydq6NT2mOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeVDzwv0RfFpuTGG5IgzUvM+UIRgTGPUN8DiMCam/1+0/+TVj2ol/IrxCSxzWLpwg
	 NOrsHdldxU7LZP+ix06o7XOQkd9RZ4Lxg1euwvPpwRVrgQhiP47T2sfv786+EKKAC6
	 USSamSS4ZYo3X+dqpqiio4wRcN0vrMYm4ewZvhOW6hHC5usLIYDKj/N80uDIRGajhZ
	 e9v1ZE7KyWcPdv+q3pe3iFBMojnU3ZqZVi6uhkmuQJvXVnYDqU0+BWF0yyoyanj4Wm
	 YXfTQnO8hUwn8QHZyOY9BppnHbPx4V3kXoLx2O+MJa+hiqoFN+UEEWLSW73ZR2WJwP
	 LnG33u4LHbdcA==
Date: Thu, 8 Feb 2024 18:52:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20240208-chaplain-empathy-3955eabb7152@spud>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
 <80e58f2f-b98b-46de-bcd4-fccbab11422a@linaro.org>
 <f7c18fca-2a85-46b2-a671-2409e662520f@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="af9Ebe8YYb4QbsX4"
Content-Disposition: inline
In-Reply-To: <f7c18fca-2a85-46b2-a671-2409e662520f@tweaklogic.com>


--af9Ebe8YYb4QbsX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 09:21:17PM +1030, Subhajit Ghosh wrote:
> Hi Krzysztof,
>=20
> On 8/2/24 18:48, Krzysztof Kozlowski wrote:
> > On 06/02/2024 14:00, Subhajit Ghosh wrote:
> > > Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> > > Extend avago,apds9300.yaml schema file to support apds9306 device.
> > >=20
> > > this patch depends on patch:
> > > "dt-bindings: iio: light: adps9300: Update interrupt definitions"
> >=20
> > Drop the paragraph, not helping. There is no dependency here.
> In the submitting patches guide, I read that if one patch depends
> on another, it should be mentioned.
> If I try to apply this patch with "git am", it fails without
> first applying the patch dependency mentioned above. Is that fine?
> Again, sorry about the silly questions, just don't want to assume stuff!

It's another patch in the same series, I don't think you should bother
mentioning this at all. If there's a dependency on another series, then
you should mention it under the --- line.

Cheers,
Conor.

--af9Ebe8YYb4QbsX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUi5wAKCRB4tDGHoIJi
0lnHAQC9wivPF4YxddHYID9CtPgWPTeEgG17Con/IIEpnWiH6gEAqvN2d3BXWdhd
vcYFhuj+VV82l9lpQe5TkcehuXwkdwA=
=jV4e
-----END PGP SIGNATURE-----

--af9Ebe8YYb4QbsX4--

