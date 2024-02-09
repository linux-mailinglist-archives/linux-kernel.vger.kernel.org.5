Return-Path: <linux-kernel+bounces-59595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E384F981
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5551528A9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FBC79DC0;
	Fri,  9 Feb 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF2EIiWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1E762DC;
	Fri,  9 Feb 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495682; cv=none; b=PKfHJxRK46u30m67pdZAseZOkePpwQG4aljmUj6OznIXaIapjgz9H1hn3RZ60vsuHB7F41LUk+YicSHNqkECBfEH0l6Q3eJcaVeGzMtHy5sejSXdU5ArDkDBZ3+rc83H2DD8azCmYcy9qZ5/inRB/ZUvL94aVmci68K9vOhW4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495682; c=relaxed/simple;
	bh=6P50JpMWtNawcrLYmSC8txcAEjCecYqddP8IbfkgA3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU4jvsMYkelaMw2YbOFP6EW6QDMJw9yAkvXJqW2gquirDgAtXM2Dut1AhVoXyT6eWDPLu3sLH9BJ1tXO6acxkpF2PG/f9JzoSMi1wWeyfclXrkq8sTTUD98dy6mir7g6aQh1T3IVNiBhBmPyNgnpbcxN5zBSd7GxlpIg+QgeWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF2EIiWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEDAC433C7;
	Fri,  9 Feb 2024 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707495682;
	bh=6P50JpMWtNawcrLYmSC8txcAEjCecYqddP8IbfkgA3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hF2EIiWrjPw+Pd13noyfJM2a0X3wBpj11gmQh5LXNvhwZuwyiaUALxiZPyJA3noAe
	 SAyXo43AQs97YOuyh7+2k+q3sEej2tDUHKexse0N7KFS9AfyI23QEEO9tqqsbFYIKh
	 rq7OdTgGF5FNILD6DMgYbltC0kmMHKxHuOdvgdZmMZo8s1fWBvg62sORYZW0bp8Msz
	 io6TzO/hyZN/4jMNEy0vnTjt6Pjx62ZzL4dXSZl+aYkY8a15YwAUTvPAPdp45gaIxh
	 fUPr+MaFUWlwdvSkXeiScC569n27Us+ziXK24iDYRBYUw9t9w42xY1Ne4c9q0BD/PH
	 YiTiBj/THVklw==
Date: Fri, 9 Feb 2024 16:21:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, broonie@kernel.org,
	robh@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Message-ID: <20240209-chest-sleet-a119fc3d4243@spud>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <20240208-grating-legwarmer-0a04cfb04d61@spud>
 <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AYm2FyfJMLjy9NNH"
Content-Disposition: inline
In-Reply-To: <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org>


--AYm2FyfJMLjy9NNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 01:56:56PM +0000, Tudor Ambarus wrote:
>=20
> + Geert
>=20
> On 2/8/24 18:24, Conor Dooley wrote:
> > On Thu, Feb 08, 2024 at 01:50:34PM +0000, Tudor Ambarus wrote:
> >> There are instances of the same IP that are configured by the integrat=
or
> >> with different FIFO depths. Introduce the fifo-depth property to allow
> >> such nodes to specify their FIFO depth.
> >>
> >> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
> >> introduce a single property.
> >=20
> > Some citation attached to this would be nice. "We haven't seen" offers
> > no detail as to what IPs that allow this sort of configuration of FIFO
> > size that you have actually checked.
> >=20
> > I went and checked our IP that we use in FPGA fabric, which has a
> > configurable fifo depth. It only has a single knob for both RX and TX
> > FIFOs. The Xilinx xps spi core also has configurable FIFOs, but again RX
> > and TX sizes are tied there. At least that's a sample size of three.
> >=20
> > One of our guys is working on support for the IP I just mentioned and
> > would be defining a vendor property for this, so
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
>=20
> Thanks, Conor. I had in mind that SPI has a shift register and it's
> improbable to have different FIFO depths for RX and TX.

IDK, but I've learned to expect the unexpectable, especially when it
comes to the IPs intended for use in FPGAs.

> At least I don't
> see how it would work, I guess it will use the minimum depth between the
> two?

I'm not really sure how it would work other than that in the general
case, but some use case specific configuration could work, but I do
agree that it is

> I grepped by "fifo" in the spi bindings and I now see that renesas is
> using dedicated properties for RX and TX, but I think that there too the
> FIFOs have the same depths. Looking into drivers/spi/spi-sh-msiof.c I
> see that the of_device_id.data contains 64 bytes FIFOs for RX and TX,
> regardless of the compatible.
>=20
> Geert, any idea if the FIFO depths can differ for RX and TX in
> spi-sh-msiof.c?
>=20
> Anyway, even if there are such imbalanced architectures, I guess we can
> consider them when/if they appear? (add rx/tx-fifo-depth dt properties)

I think so.

> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> Override the default TX fifo size.  Unit is words.  Ignored if 0.
> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> renesas,rx-fifo-size:
> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
> Override the default RX fifo size.  Unit is words.  Ignored if 0.

These renesas ones seemed interesting at first glance due to these
comments, but what's missed by grep the is "deprecated" marking on
these. They seem to have been replaced by soc-specific compatibles.

--AYm2FyfJMLjy9NNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZQ+wAKCRB4tDGHoIJi
0tCHAQC+UahOjFrFh4KmlxoZGj3mhl0GhMgYnpK4Y008NNbSKwD7BWwhfjMZ1Zk1
UZE3Fa1Tubov+aQxuH2m9T+rmex3fQg=
=PHwh
-----END PGP SIGNATURE-----

--AYm2FyfJMLjy9NNH--

