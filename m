Return-Path: <linux-kernel+bounces-167875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBB8BB09A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8528309C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0686A155395;
	Fri,  3 May 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5BPH4lm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D93155340;
	Fri,  3 May 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752675; cv=none; b=fGvtPjLgSH0KzHzze9Y9HsrUuLW6ZBSrk/vLkNkVNK0CgLGwUac6DWKlg+OFWFnacgfjolCOsvg9dtoGxsuHvq+wqNMHehsRGVXdNhYVkC+Sl8NIqhFNEEGjnfQTvFmIzR1kQH1uwbgonqxfvU994IzmspW2VMlFVDKE79JnzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752675; c=relaxed/simple;
	bh=oTisFi01Zd4Pmszwj1C79oYyoxXOL2cP5wDm4FBUB0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K37yTbI6+VfLfXA6cRS1Yh9j9DYvJmJHHBbnpqXYHC7XQ7JBqa1uwTjBA262Brc2peRQHVkXoA3NbGTTZWR0dgQNtBucCT/M6ML5Wfxcl68tr8z/NhLL9H/2K6qiHyP1sofn30zM8hs0w4x+/99YR1DmQyQcE28ChoC5xnsPujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5BPH4lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648FFC116B1;
	Fri,  3 May 2024 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714752674;
	bh=oTisFi01Zd4Pmszwj1C79oYyoxXOL2cP5wDm4FBUB0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5BPH4lm8wFiIzo7U4RpWrvjfuEHIfOlXunrBHzTAkRo/ybsXdsJilnRzLV2d5T/t
	 Wg+TZvPL6PyBeUPkpyAxUFQ2aMXFzvLuLWU+hlhS/4ElfquhuUEhip/PQNILgmCpty
	 j79V1KJOp7PpIXBqZPkR1F+gNQJxFupobZJVGN3EhzoAWFyWYS/L39dvMU7u3hQkl/
	 yTkmkuzMrvhSiVsM997jm7zWvJseNZkUpR9yVUL7Lf9u7Tj/qxQ56dOJbIWYC4rrDd
	 BGqMUkb5GYHAEMEBKQKpeItgB3A+Te8gUPQANaBy8Ml6xrSncOJ6xM69Q6cK3c3FE5
	 38CwvYmqKGm5w==
Date: Fri, 3 May 2024 17:11:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Prajna.Rajendrakumar@microchip.com, broonie@kernel.org,
	linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
	Conor.Dooley@microchip.com, devicetree@vger.kernel.org,
	robh@kernel.org, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	Daire.McNamara@microchip.com
Subject: Re: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Message-ID: <20240503-unfair-charger-8d47fd7b4a91@spud>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
 <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>
 <10671947-f418-4520-a29f-4ce129770e65@kernel.org>
 <1edb6c4c1a66c1a2009278b99f897e3a71b592c6.camel@microchip.com>
 <7b6489b7-ec9f-4fc7-af72-4d5cc87acd7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QPyTx+r9rQ2f1FX5"
Content-Disposition: inline
In-Reply-To: <7b6489b7-ec9f-4fc7-af72-4d5cc87acd7f@kernel.org>


--QPyTx+r9rQ2f1FX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 04:46:13PM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2024 14:54, Prajna.Rajendrakumar@microchip.com wrote:
> >>
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: microchip,mpfs-spi
> >>> +      not:
> >>> +        required:
> >>> +          - cs-gpios
> >>
> >> I don't understand what you are expressing here. Did you actually
> >> validate it that it achieves exactly what you want?
> >=20
> > Since the controller supports only one chip select, the num-cs should
> > default to 1 and cannot exceed 1 unless GPIOs are used as chip selects.
>=20
> That's not really the answer... or you want to say you did not test it?

She told me she did, and even if she hadn't, I did, despite what my
email earlier today might suggest!

Cheers,
Conor.

--QPyTx+r9rQ2f1FX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUMngAKCRB4tDGHoIJi
0ioOAP4qrZKQTHIXUkqkdaR7KEF4zHhg4D/1C9rn1t8djg/KQwEAhKRMyrlN9M8l
95XsbmHI+ErsPIxOkVKUzCTi8NTnRgs=
=mXlZ
-----END PGP SIGNATURE-----

--QPyTx+r9rQ2f1FX5--

