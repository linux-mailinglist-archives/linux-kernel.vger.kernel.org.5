Return-Path: <linux-kernel+bounces-39028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4783C9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF76E1C256A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E421130E4D;
	Thu, 25 Jan 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC1g8MAZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870512FF82;
	Thu, 25 Jan 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203170; cv=none; b=ui9lOuGvQukCz2bWNM/kMGN+pLRlYyU6k7fm3ZQT9AcLoLm6j9xNFnjkEaXDdhqEoDoFtwMADmVgeQpYtMB1fgElxeIZAeQjxwXWwsLIGAcu9e0i61GGpZ4gSUFPZo2i4EDWbkvDjVoqkegEUqYXkOXN0qC4ILiwP9hR/Y/i2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203170; c=relaxed/simple;
	bh=qXoE8YjBexxpmzCM8froty3N1HUq7TECuGLsJ/GlY30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7o5mE1UOgyhNY5f/Wd+lvVatEL5B91Qg05yptulmRu3AXVgbDWgNoqOVS/iuryVOPaD94jLHY9mGc/qTsj79I/8mnbe2yW/OUW6g39M6nlr8xp1+H0Z6qFqFw9USf9Gf9F4kNlaTjowOClbKl5SNIWLf8KlUviowCHZ9KrDDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC1g8MAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B3FC433F1;
	Thu, 25 Jan 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203170;
	bh=qXoE8YjBexxpmzCM8froty3N1HUq7TECuGLsJ/GlY30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RC1g8MAZFyopP3gtRUpEs1llcfF4NGB4X77McFIU6Vrrzz3/g0g47bSvd+S8en08E
	 GyTatf8JScn4m9v4SQATAIpDdzh4asVZ+cNMZqOvBMeeI1jXtcxitEj3RElzXY1Nlz
	 Ia1yz9ZUNaWHYnNrFBzG7D5UR1PHVF6T/5O5yeNl/Idd0eXGIS4gLZdc/CGjFQ1ZdT
	 hYTc7Uy16ZO5mFoEEF4sTbfg2qC7n1ZUxyw9DZIr3zqdhGf+eljjbjk92WpXpL7Gam
	 fu19mDsAv++7NhxPwtgEc3CBROpkqsC57BTP6USAbObFFrRr/mlEcLUt4P9LzUVg+L
	 KHo5CHoLg3Uig==
Date: Thu, 25 Jan 2024 17:19:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctr: pinctrl-zynq: Fix compatible string
Message-ID: <20240125-kindness-remnant-1a43ff5c2ba7@spud>
References: <c1307a4dd5e30290acacc786cb2170deb9eaa539.1706087258.git.michal.simek@amd.com>
 <20240124-frolic-onyx-56bd63791aca@spud>
 <5f2e3917-4767-48ca-9217-fc51fb181daa@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q2byNkOV5uJxiLYd"
Content-Disposition: inline
In-Reply-To: <5f2e3917-4767-48ca-9217-fc51fb181daa@amd.com>


--q2byNkOV5uJxiLYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 08:06:35AM +0100, Michal Simek wrote:
>=20
>=20
> On 1/24/24 17:16, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 10:07:46AM +0100, Michal Simek wrote:
> > > Compatible string doesn't really match with compatible string listed =
in the
> > > driver itself. While binding was converted from txt to yaml
> > > xlnx,zynq-pinctrl was listed as compatible string but example was usi=
ng
> > > xlnx,pinctrl-zynq and also this string is used in all DTSes.
> > > xlnx,zynq-pinctrl is used only in dt binding and not present in any DT
> > > which is stable for quite a long time that's why use old compatible s=
tring
> > > and update binding document instead of starting to use unused compati=
ble
> > > string.
> > >=20
> > > Fixes: 153df45acda0 ("dt-bindings: pinctrl: pinctrl-zynq: Convert to =
yaml")
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> >=20
> > I assume that U-Boot etc all use the "incorrect" compatible as was in
> > the example? If they do, then the patch seems good to me.
>=20
> Yes. U-Boot is using "incorrect" compatible string from 2015.

Okay. Assuming U-Boot is the only other user, it eems reasonable to
document the defacto compatible then.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--q2byNkOV5uJxiLYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKYHAAKCRB4tDGHoIJi
0j0MAP0XsUr8CoWVUhz+pTTC7zam+Hl9dZJ2qcjeo393jzdwCwEAuFCgBJsVelr6
pw7syCZ9WraRq5bzVsbr7KBgDtkR1QE=
=J64w
-----END PGP SIGNATURE-----

--q2byNkOV5uJxiLYd--

