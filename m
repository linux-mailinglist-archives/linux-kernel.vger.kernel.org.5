Return-Path: <linux-kernel+bounces-9836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9681CC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F801F226F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690152376A;
	Fri, 22 Dec 2023 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC+QmaXW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F441CFAE;
	Fri, 22 Dec 2023 15:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A53C433C7;
	Fri, 22 Dec 2023 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703258462;
	bh=iX0Xb3DzNg0RLtiR7Ftv64MGPrNCueNmT2jA8JMDSTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XC+QmaXWjch3Ig5LrrCP59Zkx3mObA7fWJ1Q1lRqOFjmW3GvsADNUmFT6mb8MV2+1
	 c0/zOy2wHoicBpnjsnSC9xXvseeLYIaxRB3qwsNjDfMPV7HXTJfx0w0niRMy7HJYAv
	 SSNE7RQOKF1iB9nON+PL32PHWIMG4ZixM1qK9LHfx6zDvrPXO+vu21VLj2MmmhYusm
	 c5tWUEoHvSflJ4dvepzVI3+pf9JbrsIVnFB1vISbAWR/zvq0fgmrpT/2V1Wg1hnlLM
	 /jzu8DEgcbLY4aOG246g+wpbPcQ8W3FoLAMUq4LhOH9UBufCZG0ZP+/n1vdl0McLxZ
	 HTrTDY4Rg1Vxg==
Date: Fri, 22 Dec 2023 15:20:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [net-next PATCH v4 1/4] dt-bindings: net: phy: Document new LEDs
 polarity property
Message-ID: <20231222-pennant-staging-00e984b69fd3@spud>
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
 <20231215212244.1658-2-ansuelsmth@gmail.com>
 <20231220152209.GA229412-robh@kernel.org>
 <6583705d.050a0220.6e903.083d@mx.google.com>
 <ce55a08f-ebe0-4e1b-a235-695e71611203@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ACY50QdLIAKkfKEE"
Content-Disposition: inline
In-Reply-To: <ce55a08f-ebe0-4e1b-a235-695e71611203@lunn.ch>


--ACY50QdLIAKkfKEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:43:17AM +0100, Andrew Lunn wrote:
> > On the marvell10g series we are discussing of using tristate or not. We
> > notice tristate might be confusing, would it be better to use
> > inactive-high-impedance ?
>=20
> The pincfg-node.yaml binding has:
>=20
>   drive-open-drain:
>     oneOf:
>       - type: boolean
>       - $ref: /schemas/types.yaml#/definitions/uint32
>         const: 1    # No known cases of 0
>         deprecated: true
>     description: drive with open drain
>=20
>   drive-open-source:
>     type: boolean
>     description: drive with open source
>=20
> I'm not sure what the deprecated means. Is it that a value is
> deprecated, not the property as a whole?

Yeah, it means that only the boolean form of this property should be
used going forward.

The comment suggests that the value had no meaning in the first place,
and that testing for presence alone has been sufficient all along.

--ACY50QdLIAKkfKEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYWpWAAKCRB4tDGHoIJi
0nnAAP9Pp+WgES0a44Nu33QCKEOpR+c3dWUvVwkgw87y9/9RvQEAx1yZPbwpfc2j
IS7xvOVrdb8Oi3EV3e5CNZjVM0WKGg8=
=uxDU
-----END PGP SIGNATURE-----

--ACY50QdLIAKkfKEE--

