Return-Path: <linux-kernel+bounces-45046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D242842AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381942870FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301512BF07;
	Tue, 30 Jan 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdJcxLPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B01292D0;
	Tue, 30 Jan 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635838; cv=none; b=b4c8fX4eJUQsSV2+LIH4Z5v4MougtnfaWZ6FvhNpTgin1F8FDBozIJOf/cAqTDU/P4Q91P9onR8hWR/w+VoKXaaGYE7lmiuiWRA6CAinf7rOAstwb1QP9Ryr879l/MjP+e282UiT8dONSIc4+ntuwjBI7/H1JHqJoyYVx0CdcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635838; c=relaxed/simple;
	bh=K5H8lNqf0NXGTNqIiI7ApohUf+7hqkgP4snlcKiOH60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUbCEoKwC+8FS/h6VTXqXy8iUgg+A45a83xArmIRwo8ryd+GL/LhYpu2YN7EwR5a8cpHidUKbtBHaSD4eUzg2EWXI0lEeOZhLydY+AuWXawMYC14/UqY30pSpSTgG84TZmHxuzs93lPMNpXeCW3wYb5bvWpaObRDW8omKvjd3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdJcxLPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D756C433C7;
	Tue, 30 Jan 2024 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635837;
	bh=K5H8lNqf0NXGTNqIiI7ApohUf+7hqkgP4snlcKiOH60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdJcxLPqq73ugEiNpNePLGiZ7CyNDUCTKUpZplS17Q6QmEFfRsX5GwKm83LblhCiP
	 MpHDAidJL7L5yQHwiBU5S7m/9xuexadiRgPPxaKYA0c2mD5QKB2uGIFK+97jH5EZzY
	 W56bZPHSGAb/+tSQyjI6kYdN4YEDRE5wdRl6qNiuQ0TLu26mEAbxsp+Wj6InUnbnxr
	 bDz7a9E5slyllDjibOaqKsBnjx6Qus6n4VljMfNqXPo7emE2G3/EZfapEhK6kpIdwR
	 SG2L3uCsNPt3HWBXhVH7uRVdOUQiA/EvVnU3Ol9pYZEcDofYtp6dkcwGe0l5w9CESm
	 utJLxAXMmkdDw==
Date: Tue, 30 Jan 2024 17:30:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Message-ID: <20240130-smartness-relish-d7f13adcb18d@spud>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EQFIjccQL367rY1c"
Content-Disposition: inline
In-Reply-To: <20240130104845.3995341-3-vineeth.karumanchi@amd.com>


--EQFIjccQL367rY1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
> "wol-arp-packet" property enables WOL with ARP packet.
> It is an extension to "magic-packet for WOL.

If it is an extension to "magic-packet" why does it not depend on
"magic-packet"? Are there systems that would only support the magic arp
packet but a regular magic packet?

>=20
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
> 7c4a1d0cfdc1 net: macb: make magic-packet property generic
> which added magic-property support and wol-arp-packet addition
> is similar extension.
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index bf8894a0257e..4bea177e85bc 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -144,6 +144,11 @@ patternProperties:
>          description:
>            Indicates that the hardware supports waking up via magic packe=
t.
> =20
> +      wol-arp-packet:

Bikeshedding perhaps, but why not call it "magic-arp-packet" if it has
the same function as the other property here?

Thanks,
Conor.

> +        type: boolean
> +        description:
> +          Indicates that the hardware supports waking up via ARP packet.
> +
>      unevaluatedProperties: false
> =20
>  required:
> --=20
> 2.34.1
>=20

--EQFIjccQL367rY1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbkyOAAKCRB4tDGHoIJi
0oo5AP9+8f3eTTzNNIIo3eaheucJyON7brBcr27iDEngORZqpwEAvUO2xK7EO7Ig
NRYYPZUGISKVyN/0Pf/kMbZSS0/ltwk=
=dpDt
-----END PGP SIGNATURE-----

--EQFIjccQL367rY1c--

