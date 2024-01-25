Return-Path: <linux-kernel+bounces-38978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DC83C947
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C88C1C26489
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD414460C;
	Thu, 25 Jan 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5fLREEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209A131721;
	Thu, 25 Jan 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201859; cv=none; b=RSULYOJOo1G6jiTIjDjEw4v/5VEeoQa3Aw44gDizAC0KkVLOQOtCiGDs18NWmG3pfMiozXapYvqdiVT+wwF7DbruqV2268p1YyNNpcMJSUKOewxLLSQPwUTl8QP2JUqTZQpI27l3lKM/HxJYTyX46P2jXx6CCq65WdgfQLX9IT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201859; c=relaxed/simple;
	bh=ntB+bbUKnhOxh8y7HNEjbmxNyzwcc8uYo8PAcwggoqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAsJ6yfVA35nrAlqub/sa2oFhjp/xInt51OoE40l0s++nh21It0mVy5fxlBRLsfUca4xYL1WgTZgmyxBjRGQK6iA32Hv4upqYGxDHECWqY/ytq3nQlFTcZuD6aXpmZpS0icyfT1qFxQLywv0/qDyA9H6Qu6YEi8zxSLjS3HF8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5fLREEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8289AC433C7;
	Thu, 25 Jan 2024 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201858;
	bh=ntB+bbUKnhOxh8y7HNEjbmxNyzwcc8uYo8PAcwggoqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5fLREENADd4qPzz1kyfRN7stOoYD5ZBiDhBgSIT8UZiF18VX+PCcg40Sx9dcyzvI
	 cjyt3shnMe4mQ7IdFfy+10BijEZ0Jm6dzIp/+PKpUmOYnqIUS6rbk2MLA56r8C0AUH
	 3/GS8vzvcVC3pQm5mUbVAp/FHc35ICvqAfnt4AHJpaqX+GmpxacDflQODNYD1k8MsE
	 P6sVLrWbcY9nhTfcKagRtB7KcSAcR3xMB3bq9Dx4iEO6kCieQhYMLDlBCriLjOHIJm
	 05IxAyRGv/JIzbNWmU2/j4xYl50naB+kLhGt8jqSCnFgM1DmfCjSNIbzGhEyZz/MCQ
	 lXJfkXFY6/HzQ==
Date: Thu, 25 Jan 2024 16:57:33 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240125-disdain-delivery-ff3bf246bbe1@spud>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
 <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
 <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="clhVPuZeufoXCJeF"
Content-Disposition: inline
In-Reply-To: <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>


--clhVPuZeufoXCJeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:41:57PM +0100, AngeloGioacchino Del Regno wrote:
> Il 25/01/24 11:32, Krzysztof Kozlowski ha scritto:
> > On 24/01/2024 09:48, AngeloGioacchino Del Regno wrote:
> > > Il 23/01/24 18:14, Conor Dooley ha scritto:
> > > > On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regn=
o wrote:
> > > > > Il 19/01/24 17:32, Conor Dooley ha scritto:
> > > > > > On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del =
Regno wrote:
> > > > > > > This IP has only one interrupt, hence interrupt-names is not =
necessary
> > > > > > > to have.
> > > > > > > Since there is no user yet, simply remove interrupt-names.
> > > > > >=20
> > > > > > I'm a bit confused chief. Patch 2 in this series removes a user=
 of this
> > > > > > property from a driver, so can you explain how this statement i=
s true?
> > > > > >=20
> > > > > > Maybe I need to drink a few cans of Monster and revisit this pa=
tchset?
> > > > > >=20
> > > > >=20
> > > > > What I mean with "there is no user" is that there's no device tre=
e with any
> > > > > mt6360-tcpc node upstream yet, so there is no meaningful ABI brea=
kage.
> > > > > Different story would be if there was a device tree using this al=
ready, in
> > > > > which case, you can make a required property optional but not rem=
ove it.
> > > >=20
> > > > Not every devicetree lives within the kernel.. If the driver is usi=
ng
> > > > it, I'm not inclined to agree that it should be removed.
> > >=20
> > > I get the point, but as far as I remember, it's not the first time th=
at this
> > > kind of change is upstreamed.
> > >=20
> > > I'm fine with keeping things as they are but, since my intention is t=
o actually
> > > introduce an actual user of this binding upstream, and that actually =
depends on
> > > if this change is accepted or not (as I have to know whether I can om=
it adding
> > > the interrupt-names property or not)....
> > >=20
> > > ....may I ask for more feedback/opinions from Rob and/or Krzk?
> >=20
> > Driver is the user and this is an old binding (released!), thus there
> > can be out-of-kernel users already.
> >=20
> > Minor cleanup is not really a reason to affect ABI. You could deprecate
> > it, though. Driver change is fine.
> >=20
>=20
> Thanks for the clarification. If USB maintainers want to take the driver =
part only
> without me resending this, I'd appreciate that.
>=20

> The interrupt-names is not a required property in this binding anyway... =
:-)

Having -names properties that are not required when the base property is
always seem so pointless to me, except in cases where they're not
required for the case where there's one item but required when there are
more than one. Ultimately they're pointless if not required since they
can't be relied on. I think dropping it from the driver is required for
correctness.

--clhVPuZeufoXCJeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKS/QAKCRB4tDGHoIJi
0v86AP9l1CfLfFT8z5XQyQXQOWkzpec/y9WalTIbnXpbEFgfBAEA5Q7RAW2pLt1Q
MwNSHR9bNbwJHwNJfnR8eKxAltE8fgg=
=z3OQ
-----END PGP SIGNATURE-----

--clhVPuZeufoXCJeF--

