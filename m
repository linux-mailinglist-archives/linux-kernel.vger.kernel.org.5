Return-Path: <linux-kernel+bounces-138296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5589EF68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EC8B21B71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BF156F29;
	Wed, 10 Apr 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArqSI63k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EA158210;
	Wed, 10 Apr 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743443; cv=none; b=J+OceEJ+RKxrm23JNuW8V4gaR4dX+lwYs2SkKVrnsRc7mYyLviHmSArNgjNgWS/SeaegrunvPEEOHS9lzXiCnkFpbEA97FKD7NPOkWmLv0BeJrWpzUmt3iEvl2b0LkwhxH6Ozspr4ktRGYMrAjGLh8ucub5AGgqbM89RaDzuGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743443; c=relaxed/simple;
	bh=O0VlrLYkNg9eeGffg8c3eww3VthKzB16sPQVJP9pPzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpRDjjLLdICLwnIFvxgCFy4NQ5CiJ/Voj4/xb/QO7jMi4JjJMmW1MHGEzJ9X5X7d8hcae7e7UO1KE/SYzgkNtPWh8BU23ZCx95tHKcmmhkT5mvf2uCMfVt7CK+oSvXGIhcF4JATIJQq24VDl3405vixY3F/uqRZQJN08Bl5ixCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArqSI63k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCA9C433F1;
	Wed, 10 Apr 2024 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712743443;
	bh=O0VlrLYkNg9eeGffg8c3eww3VthKzB16sPQVJP9pPzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArqSI63kngbacDK0bh817px/g8VItoLwBabfoLZMUPNq+Biw+scFGx3I1sgPDbLnM
	 wS9iWRN9bVfqYyzAc8SucNF2wPD5L5cQT5+kftT74n/k9MFk2VmgYwhIPXN7/e4EsE
	 T/hRY8UIKwSXj4M96LLuEcU1k7FSc0LB6jz4CWUZFJ4DLY2KUG1kvrKH7ZGEw2/ym0
	 4KJT1vBrCbfH9DVvo5VT0QAsAJ3hJ8sa2/Q0XBg8DsLuO9wNmkXewbMaesTNdytdYZ
	 DRKSFxt9JgHxHH/0/i+0UEyAaPbRuoVviIfxMaPvW/a0s/HtuW9+NM9t6+dE0QQcp9
	 AP6G4+rINUvVw==
Date: Wed, 10 Apr 2024 11:03:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71879
Message-ID: <20240410-possum-lecturer-716185901aa5@spud>
References: <20240404195423.666446-1-andreas@kemnade.info>
 <20240404195423.666446-2-andreas@kemnade.info>
 <3d5df067-ec94-42c6-bbd0-43ce8cd53e40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d0bdlkh8SwUX6pNK"
Content-Disposition: inline
In-Reply-To: <3d5df067-ec94-42c6-bbd0-43ce8cd53e40@gmail.com>


--d0bdlkh8SwUX6pNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:57:08AM +0300, Matti Vaittinen wrote:
> On 4/4/24 22:54, Andreas Kemnade wrote:
> > As this chip was seen in several devices in the wild, add it.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > ---
> >   .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.ya=
ml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > index 0b62f854bf6b..07f99738fcf6 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > @@ -17,7 +17,12 @@ description: |
> >   properties:
> >     compatible:
> > -    const: rohm,bd71828
> > +    oneOf:
> > +      - const: rohm,bd71828
> > +
> > +      - items:
> > +          - const: rohm,bd71879
> > +          - const: rohm,bd71828
> >     reg:
> >       description:
>=20
> Am I correct, this reads as:
>=20
> Either
> 	compatible =3D rohm,bd71828
> or
> 	compatible =3D rohm,bd71879, rohm,bd71828
>=20
> but not compatible =3D rohm,bd71879?

Correct.

--d0bdlkh8SwUX6pNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhZkDwAKCRB4tDGHoIJi
0k8LAQCCIueExTdOVFOVm0LA9g+yGDV3QCm9Xr4ma7lWVWh1YAEAnMhqdijGAVjr
aAO9Zk1iF7Qz1qrfzcqUXIHGxnwdPwg=
=gAgy
-----END PGP SIGNATURE-----

--d0bdlkh8SwUX6pNK--

