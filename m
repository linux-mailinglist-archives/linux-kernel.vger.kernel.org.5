Return-Path: <linux-kernel+bounces-92950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4126A87287B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729191C250AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD912A152;
	Tue,  5 Mar 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eae9cINa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAE127B7D;
	Tue,  5 Mar 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670068; cv=none; b=HgQKRMbAj9rt3SSHnbgSJuKbhMha8ex/EIKxYHbwLF8OG+bEuBVOHAw63J3SkTWQ7rXdtVNwPmj5ffxnyQ9bNH5dDDNDPqvmc8xoD1/ei4r0BBTRSWYj2JFHKZBbdGyhGYF0uv9ch8EOzlZdEUakB65AHMY+iyT0ODdbQR5E+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670068; c=relaxed/simple;
	bh=AXyShP/NTJJSrB72bu/9CciENtNrPzhZ1jR+kfnI4Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0O5y5iFi52LAiRXgCoet6LliUiMPc6pKucchnkXSsDlUsL2YapwBAMTF826H7uKmHIgNlrolP7cBqo6OFI4hoQkgcGow+7mgyo2q+AFYkQGuV2THzpvA+wR594br2T0m+Ni4P8qvD5d4YHt5Re/MSBB+9mE2O+ojRfYvpJZCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eae9cINa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEBFC433F1;
	Tue,  5 Mar 2024 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709670068;
	bh=AXyShP/NTJJSrB72bu/9CciENtNrPzhZ1jR+kfnI4Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eae9cINa7YeSHc90dybZTtnvbc8RCKKccaLxsj2iP1Bfrbcqf9EnwYHoPi2pxci9C
	 BdiVs25FlWaqDE3lOPcsjMXp1GkTC1v+boM79AUvdtIOdA5TqeuYg02QtNVBvt3DMh
	 UjhiwDXN3t63IT5rPb8H6JLi6MythNFsC4aQYbGRKsMZmJXGJ3jyl59XwEXXz1dXHu
	 XAjCz4PGTDIvycS2FquRqRXQwkQzg35WIa+ZjLIjiqbOU/2G5uiEeJUfnn8dnPt4t8
	 SKlquNqYbeYVSItpq8kfn1rME+Hpbrpifq+jdU24P9YuZOFrBC84+7ETAyRLARGDmV
	 0mEiH5E4ioSbg==
Date: Tue, 5 Mar 2024 20:21:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear
 CMT430B19N00
Message-ID: <20240305-carport-fading-77429ca205c0@spud>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304-drivable-property-feaeba782880@spud>
 <20240304212451.GA1056406-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n5QTRknG5hYaMZ5k"
Content-Disposition: inline
In-Reply-To: <20240304212451.GA1056406-robh@kernel.org>


--n5QTRknG5hYaMZ5k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 03:24:51PM -0600, Rob Herring wrote:
> On Mon, Mar 04, 2024 at 07:29:04PM +0000, Conor Dooley wrote:
> > On Mon, Mar 04, 2024 at 05:04:51PM +0100, J=E9r=E9mie Dautheribes wrote:
> > > Hello everyone,
> > >=20
> > > This patch series add support for the Crystal Clear Technology
> > > CMT430B19N00 4.3" 480x272 TFT-LCD panel.
> > > It also adds Crystal Clear Technology to vendor-prefixes.yaml.
> > >=20
> > > Please note that unfortunately there is no public datasheet available
> > > for this panel.
> > >=20
> > > Changes in v2:
> > >   - add link to the Crystal Clear Technology website in commit messag=
e, as
> > >   suggested by Conor Dooley and Neil Armstrong.
> >=20
> > You forgot however to add the acks that I gave you for the two
> > dt-binding patches.
>=20
> I was wondering why my scripts said this was already reviewed with that=
=20
> missing. Turns out b4 will now check prior versions and add the tags as=
=20
> long as the patch-id matches. Neat, but the submitter really has to=20
> grasp how that all works (knowing if the patch-id changed) as well as=20
> the maintainer has to use b4, so we can't really rely on it.
>=20
> Here's b4 debug log:
>=20
>   new message: 20240223-subtotal-aground-268d135adeff@spud               =
                                                     =20
> Running git --no-pager patch-id --stable                                 =
                                                     =20
>   found matching patch-id for Re: [PATCH 2/3] dt-bindings: display: simpl=
e: add support for Crystal Clear CMT430B19N00        =20
>   new message: 20240229-woven-lively-1d90687b2d03@spud                   =
                                                     =20
>   skipping reply without trailers: 20240229-woven-lively-1d90687b2d03@spud
>   new message: 20240223134517.728568-2-jeremie.dautheribes@bootlin.com   =
                                                     =20
>   skipping non-reply: 20240223134517.728568-2-jeremie.dautheribes@bootlin=
=2Ecom                                                 =20
> Analyzing follow-up: Re: [PATCH v2 0/3] panel-simple: add support for Cry=
stal Clear CMT430B19N00 (conor@kernel.org)           =20
>   no trailers found, skipping                                            =
                                                     =20
> Analyzing follow-up: Re: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N=
00 LCD panel support (mripard@kernel.org)            =20
>   no trailers found, skipping                                            =
                                                     =20
>     adding "Acked-by: Conor Dooley <conor.dooley@microchip.com>" from tra=
iler_map to: [PATCH v2 1/3] dt-bindings: Add Crystal C
> lear Technology vendor prefix                                            =
                                                     =20

>     adding "Link: http://www.cct.com.my/" from trailer_map to: [PATCH v2 =
1/3] dt-bindings: Add Crystal Clear Technology vendor=20
> prefix                                                                   =
                                                     =20

This is the other nice thing that b4 does, pick up "non review"
trailers too.

>     adding "Acked-by: Conor Dooley <conor.dooley@microchip.com>" from tra=
iler_map to: [PATCH v2 2/3] dt-bindings: display: simp
> le: add support for Crystal Clear CMT430B19N00                           =
                                                     =20
>     adding "Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>" from=
 trailer_map to: [PATCH v2 3/3] drm/panel: simple: add
>  CMT430B19N00 LCD panel support                                          =
                                                     =20
>     adding "Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>" from =
trailer_map to: [PATCH v2 3/3] drm/panel: simple: add=20
> CMT430B19N00 LCD panel support                                           =
                                                     =20

--n5QTRknG5hYaMZ5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZed+rgAKCRB4tDGHoIJi
0uUxAP9C/NeKWKiGpmRvjlC+xsYuQywbIx6OSRgaqNwsu5T1TwD/V6AU8yXJAsUR
qJI2ABxmjqFpp1fw/6PAxjAVfm7XVQ8=
=m7ML
-----END PGP SIGNATURE-----

--n5QTRknG5hYaMZ5k--

