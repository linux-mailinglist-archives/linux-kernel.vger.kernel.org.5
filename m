Return-Path: <linux-kernel+bounces-33900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7083700F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E821C2854A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EC5F544;
	Mon, 22 Jan 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+44kknI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4825F55F;
	Mon, 22 Jan 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946782; cv=none; b=rZTynsweiSFzK6R05MsrQZIQPK4TLtUBFg8qSWMS3ExMC84eRDkg8ucGNLYU5XAO8VqD03lMLZbnkhuaEvm9ZLTmf4HV+xqCcSh99ucejJpZg2hwgG/bqeAH/AkDaUgdkIVhWlXlc6KNRC7f/OGbQ0O/ti7uc4E87Y4WMx3Isdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946782; c=relaxed/simple;
	bh=qrDyQthPZZTKjHUK3BaRkyooNaTHr0ABooQXcmIORQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6yi8ZnfdrBMCoHz5f9GstOrzKMXXGhnSYcVze57s2uRthl9YFBYjCg7vM/jiYm8Y6XOyE52FYq6P6B+fHQ3cpclokdzCr+tffnh46qCvl3kkZs4M1Y/f7xmImC6Tdk9UU/wHYguYHemK1lpIk+66s8/8x4a/o+PD7rIGo5AP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+44kknI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8585BC43394;
	Mon, 22 Jan 2024 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946781;
	bh=qrDyQthPZZTKjHUK3BaRkyooNaTHr0ABooQXcmIORQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+44kknIgGDYv8m/O3mTLyLItJU55Rtb5gFxpjypN10+/ZEXGmmUxwRQjHAlIv/c8
	 pCx0E/U3QajTejHTcF2O5VxBnLVdEJk2prnWp/3xXGkmB7utitaBIFr5iO5jAsE/o3
	 OYyTteZjco9WgFPR7gamNwaqutu65BfUGewtFzsysjuGvFz5rfu8Oy7rGRn2Y8iY5s
	 AQomliXDiCxgKi/N0Q6nJgCeGbSdkfy8phy9qTsdPfsX+mzHX8EWdGhp2EB8PGQEYx
	 oMwD7KsIVosusXZljtvb6a+JtUyEJzDwUmhfaTbIMPnlDOqZxmTcVLEm/mXIypHtJx
	 miGEozKLymj3w==
Date: Mon, 22 Jan 2024 18:06:15 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
	tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
Message-ID: <20240122-delouse-popsicle-a6f94cce9fb4@spud>
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
 <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
 <20240119-remedial-unripe-2a3a46b4f117@spud>
 <9605c20a-12ad-49ad-8114-d59f2f772514@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nmjJ86xFFhBOL+Dl"
Content-Disposition: inline
In-Reply-To: <9605c20a-12ad-49ad-8114-d59f2f772514@collabora.com>


--nmjJ86xFFhBOL+Dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:27:11AM +0100, AngeloGioacchino Del Regno wrote:
> Il 19/01/24 17:18, Conor Dooley ha scritto:
> > On Fri, Jan 19, 2024 at 01:58:11PM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
> > > used for connecting, disconnecting and switching orientation and
> > > control the SBU signals for alternate modes on USB Type-C ports.
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > >   .../devicetree/bindings/usb/ite,it5205.yaml   | 72 ++++++++++++++++=
+++
> > >   1 file changed, 72 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205=
=2Eyaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/ite,it5205.yaml b/=
Documentation/devicetree/bindings/usb/ite,it5205.yaml
> > > new file mode 100644
> > > index 000000000000..36ec4251b5f2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ITE IT5202 Type-C USB Alternate Mode Passive MUX
> > > +
> > > +maintainers:
> > > +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.=
com>
> > > +  - Tianping Fang <tianping.fang@mediatek.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ite,it5205
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vcc-supply:
> > > +    description: Power supply for VCC pin (3.3V)
> > > +
> > > +  mode-switch:
> > > +    description: Flag the port as possible handle of altmode switchi=
ng
> > > +    type: boolean
> > > +
> > > +  orientation-switch:
> > > +    description: Flag the port as possible handler of orientation sw=
itching
> > > +    type: boolean
> > > +
> > > +  ite,ovp-enable:
> > > +    description: Enable Over Voltage Protection functionality
> > > +    type: boolean
> >=20
> > Bitta devil's advocacy perhaps, but why is this DT property? Is it not
> > known whether or not this is supported based on the compatible, and
> > whether or not to enable it is a decision for the operating system to
> > make?
> >=20
> >=20
>=20
> AFAIK, not all board designs can use the OVP. On some, this may be unstab=
le - the
> use case where this can be safely enabled is when there's nothing in betw=
een the
> mux and the controller, and between the mux and the port.

Okay, if it varies based on the configuration that makes sense. Perhaps
in the future consider mentioning stuff like that in the commit message.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nmjJ86xFFhBOL+Dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6ulwAKCRB4tDGHoIJi
0teFAQDYntozsnG0qrbeJtl0OkXFU7kXZH/5/2m68HTIZLIOKQEA0vZa72Ejv9TG
DZbeNEl/1O99qdsZnvfvk/zLcQdjyQ4=
=xdmh
-----END PGP SIGNATURE-----

--nmjJ86xFFhBOL+Dl--

