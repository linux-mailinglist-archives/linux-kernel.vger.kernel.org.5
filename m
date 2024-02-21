Return-Path: <linux-kernel+bounces-75364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F185E744
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81BDB288EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D186130;
	Wed, 21 Feb 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcO5KgwD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423585927;
	Wed, 21 Feb 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543671; cv=none; b=C0ly/bvZ7JggvmPdDTqxeRyfhIo/kir9r5Mr28t8L82vGuDpTe/EdsumeT6dvBxo4xU9rckuKazYaLay93tjyvle6DPeZQJJG2lT9aELdYp3sAZik7DTGdQBqNJmVDhDbuw0hSRwvTO/1ZnKXr9Mhsh8rJW7Qk0ZITtV4c/9Q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543671; c=relaxed/simple;
	bh=BTdDx5vaaX86wA8OnfV1D5yuydXlrU3KbL90R01bacw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd9MC+VUgUQ+x8/B8/z4vzZT8xeRIpLG4VSKjUR2n8QxFWaVYGMHw5IlTIevgsV0zj+p0gZPqDizl39YhB1fr4VoXh8WbkjDvw/opCzYp43xbCu6iFhTRqNs/wHk9WAEkGi5LJLQYYITn0rAmAdBq6RSDmUfRrqE4j40MAem+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcO5KgwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01079C433F1;
	Wed, 21 Feb 2024 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543670;
	bh=BTdDx5vaaX86wA8OnfV1D5yuydXlrU3KbL90R01bacw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcO5KgwDyPU4I+kQ72WAHgsDx0sqct+ZKI3+LafZxgHXF93+z0OleWVB7encrLF3S
	 4o79uqGWTb2/GuMitsHXYQwAMY4/WEEtyMy2zjfpERK8ulaP+KNTqTAEnsHJbDV7/R
	 zXFiHLLcvIe72IjmLL7oE3hpy3GThmqGB5KqGr9krHrSNkQQy4Y+qq1QHaSNqb3FPl
	 uNIYZLQVrjoySKHyrGXs5PbiWk28rEALT5b4uZ+SWSSHalkbNuBReNSBKRmOaJIR8h
	 o9/xMMsEJYUoP5CyKJUcO2Cp0Ak9Dq6QgoABtEkRM459cMS4RBy4l4jFACA0TI1RLB
	 OTCBAXsyo/CaA==
Date: Wed, 21 Feb 2024 19:27:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	denis.ciocca@st.com, linus.walleij@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Message-ID: <20240221-imitate-molar-81d93285ac77@spud>
References: <20240221175810.3581399-1-m.felsch@pengutronix.de>
 <20240221-undecided-union-4078db711693@spud>
 <20240221191644.5r3ylr5w3cnfnrzj@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nUPua0KAJjDmCWQL"
Content-Disposition: inline
In-Reply-To: <20240221191644.5r3ylr5w3cnfnrzj@pengutronix.de>


--nUPua0KAJjDmCWQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:16:44PM +0100, Marco Felsch wrote:
> On 24-02-21, Conor Dooley wrote:
> > On Wed, Feb 21, 2024 at 06:58:10PM +0100, Marco Felsch wrote:
> > > Add the iis2mdc magnetometer support which is equivalent to the lis2m=
dl.
> > >=20
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml=
 b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > index fff7e3d83a02..ee593c8bbb65 100644
> > > --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > > @@ -64,6 +64,7 @@ properties:
> > >            - st,lsm9ds0-gyro
> > >        - description: STMicroelectronics Magnetometers
> > >          enum:
> > > +          - st,iis2mdc
> >=20
> > Without a fallback compatible to the equivilent device, how does a
> > driver bind to this device?
>=20
> I skimed the datasheets and the driver already handles this binding
> exactly the same as the st,lis2mdl, so my assumption is they do match.
>=20
> Why do I you think we need a fallback compatible here?

I didn't look at the driver, there was no mention of the driver already
having (undocumented) support for it. Since there was no driver change
alongside this patch, I thought you'd need a fallback compatible to
allow the driver to match against a compatible it recognises.
Besides, having fallback compatibles is the norm when one device has the
same programming model as another.


Cheers,
Conor.


--nUPua0KAJjDmCWQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZOsQAKCRB4tDGHoIJi
0oUFAP9dcoAmt9xrKwnbtL1gzjHaQs/HRkMgmbtho7RYa8T5hAD+La0IOSMbLau8
273ryvy0VtZAZHnh6YcGOY9BW3pDjAs=
=DCXd
-----END PGP SIGNATURE-----

--nUPua0KAJjDmCWQL--

