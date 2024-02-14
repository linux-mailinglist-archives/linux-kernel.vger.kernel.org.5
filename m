Return-Path: <linux-kernel+bounces-65709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CC8550AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB1B1F22AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA631272A4;
	Wed, 14 Feb 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuvqwQxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AC7E0EA;
	Wed, 14 Feb 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932746; cv=none; b=JfFLV25QOp9oZmjq3GZFDaw6v+k9Ogm/wAT4zEvFT8Dgnoa4EmWlq8hbfy1xHYsjTpNUmgBBjnVd3O+A//uRK//e9+hi03owgievEs7WYxplB6rJl2k+YowNaCQ84sFf1n26ykTQJ7y75vkCZ4fuXcaaq7ys5dzULURntyU6nnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932746; c=relaxed/simple;
	bh=CdALU6kimwQEEEZPNowgMiQLVRcl3vVQkRejqTYl/M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8S5NfQCL9X5XliFxftwXIEe38aisRsGI9boj5KBiplqbX1VUqKtq1RQ9UCsuHbxQNxsmMBVly5RRPE7xovXTKNnrKTinLmN+5MZFv0RV7pzlfMRu1cnGXV8RTfVNDfukkv9wZtPaDoJf2ppozh/gQ7ULpAICg47m5hriEPefxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuvqwQxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97808C433C7;
	Wed, 14 Feb 2024 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707932745;
	bh=CdALU6kimwQEEEZPNowgMiQLVRcl3vVQkRejqTYl/M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuvqwQxT0yFuLg3JYi6SkC7s+zUcf33bKQRfnYeCAZ10S6ltzefsp0+Hzl6BuKFjW
	 OJ8jfP8gsi2kx3IxnVlK37hYwBNgylkWcXrRMGiwaLUgGWZOGHbwsyybxrmHlkapjb
	 jYmUV5JiBVLa7ySZf0yfdcpqwQC3NXcNNz6UYhKr3aIVAghsxjdRTtLyu5uKQDIJCL
	 StTr3DUVC/B0CoczHNHep0vIRY7tb0UI/f07FbTqHAwFldcUszfPmKzqZ3pqPLsqsa
	 s+eEHwXsr9opdqw8dsbArVTr5Fj94VRaKXZsHO/y/SDJwcOFyjHoV/sQUx7tJfNgwk
	 XtKZTEMvo8MDQ==
Date: Wed, 14 Feb 2024 17:45:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Kevin Hilman <khilman@kernel.org>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>, arnd@arndb.de,
	broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
	lgirdwood@gmail.com, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, nm@ti.com,
	robh+dt@kernel.org, vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240214-depraved-unfunded-3f0b3d6bf3e2@spud>
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
 <20240214093106.86483-1-bhargav.r@ltts.com>
 <20240214-galley-dweller-1e9872229d80@spud>
 <7hil2r5556.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v1AS/JdF6e6MzIix"
Content-Disposition: inline
In-Reply-To: <7hil2r5556.fsf@baylibre.com>


--v1AS/JdF6e6MzIix
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 09:26:13AM -0800, Kevin Hilman wrote:
> Conor Dooley <conor@kernel.org> writes:
> > On Wed, Feb 14, 2024 at 03:01:06PM +0530, Bhargav Raviprakash wrote:
> >> On Fri 2/9/2024 10:41 PM, Conor Dooley wrote:
> >> > On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
> >> > > TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> >> > > regulators, it includes additional features like GPIOs, watchdog, =
ESMs
> >> > > (Error Signal Monitor), and PFSM (Pre-configurable Finite State Ma=
chine)
> >> > > managing the state of the device.
> >> >=20
> >> > > TPS6594 and TPS65224 have significant functional overlap.
> >> >=20
> >> > What does "significant functional overlap" mean? Does one implement a
> >> > compatible subset of the other? I assume the answer is no, given the=
re
> >> > seems to be some core looking registers at different addresses.
> >>=20
> >> The intention behind =E2=80=9Csignificant functional overlap=E2=80=9D =
was meant to
> >> indicate a lot of the features between TPS6594 and TPS65224 overlap,
> >> while there are some features specific to TPS65224.
> >> There is compatibility between the PMIC register maps, I2C, PFSM,
> >> and other drivers even though there are some core registers at
> >> different addresses.
> >>=20
> >> Would it be more appropriate to say the 2 devices are compatible and h=
ave
> >> sufficient feature overlap rather than significant functional overlap?
> >
> > If core registers are at different addresses, then it is unlikely that
> > these devices are compatible.
>=20
> That's not necessarily true.  Hardware designers can sometimes be
> creative. :)

Hence "unlikely" in my mail :)

> > In this context, compatible means that existing software intended for
> > the 6594 would run without modification on the 65224, although maybe
> > only supporting a subset of features.  If that's not the case, then
> > the devices are not compatible.
>=20
> Compatible is a fuzzy term... so we need to get into the gray area.
>=20
> What's going on here is that this new part is derivative in many
> signifcant (but not all) ways from an existing similar part.  When
> writing drivers for new, derivative parts, there's always a choice
> between 1) extending the existing driver (using a new compatible string
> & match table for the diffs) or 2) creating a new driver which will have
> a bunch of duplicated code.
>=20
> The first verion of this series[1] took the 2nd approach, but due to the
> significant functional (and feature) overlap, the recommendation was
> instead to take the "reuse" path to avoid signficant amounts of
> duplicated code.
>=20
> Of course, it's possible that while going down the "reuse" path, there
> may be a point where creating a separate driver for some aspects might
> make sense, but that needs to be justified.  Based on a quick glance of
> what I see in this series so far (I have not done a detailed review),
> the differences with the new device look to me like they can be handled
> with chip-specific data in a match table.

This is all nice information, but not really relevant here - this is a
binding patch, not a driver one & the conversation stemmed from me
making sure that a fallback compatible was not suitable. Whether or not
there are multiple drivers or not is someone else's problem!

Thanks,
Conor.

--v1AS/JdF6e6MzIix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcz8QwAKCRB4tDGHoIJi
0opXAP9Dzoxnv9sksP1u0YCoiAGJJzhIzB+7PIP4EvpF9S2//AEAhmgjJMls9n0T
M1W2/BJjVKqm2mghYoQMHLkZ7ElrNAI=
=6W+V
-----END PGP SIGNATURE-----

--v1AS/JdF6e6MzIix--

