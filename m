Return-Path: <linux-kernel+bounces-63962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044288536CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A782874B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DBE5FDD4;
	Tue, 13 Feb 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qslBWslz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B95FBB5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844054; cv=none; b=EpPhrWCtPo1D8Zkbvn9Yq8LhUp1XHmbSDY6tPbhHPZnnxseh82fnu75HCeyM4ymxptoj+CzelwdvY/ZpaLEORujnhaCNkaepqqHxLydiw4Lhijox+nCQaKD8aQy6BWHD1OmqcfMYK9EkPQXrg1QOFPe13GgE+j9d9EdvV6coxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844054; c=relaxed/simple;
	bh=8xJ6K3YxeTLXM/pbjDu4CB5rW5SThx69MqqZcbcYC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq2LFO4Z7aYTbM90ZNEy5BG7IhCGWYgcCQOBgJ8Oet7yOLgj0KTCp0+Vd7IuIRBNsbJ5pTud+uyt/+EorfV/uKYaHCdyW2neyXnwJHomBCG2GVG19dlMyaiREeTc2beW2ZOaw+Pwv/NCCrHDBligBeso/h6MFlJnC1S86hdcNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qslBWslz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C257C43399;
	Tue, 13 Feb 2024 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707844053;
	bh=8xJ6K3YxeTLXM/pbjDu4CB5rW5SThx69MqqZcbcYC0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qslBWslzQ5gumYuJoCGE2B3dgzVw7zZdW+CiWRsYhGSx6QwqVv8wx5D9IGYFufFrh
	 Z+HI6bkKVaoLUrvAKP1CxP6pOMsVlAx40TrJW5OM9zoJjPihzvpAnO7JW80AyMkD+l
	 5fGUv5d8JetNS1TXqMeQEZlt4BLRQxCpTAzuy91ZSwgoeN8jI6qFuRaozkX2xtwaEp
	 OpLuWDfFTLYCRfM9gbeX9FxhS7V2rp6o3gllPgfyVhDUjlpQLYKsW3sVTKRZt6hwqm
	 4pDoFktD5756W/lQjajtriFNnEZFZXNiO72OfKqu0faTLI+7IWYAhncJoADla8QixL
	 SBx18ySlG45Uw==
Date: Tue, 13 Feb 2024 17:07:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified
 privileged ISA versions
Message-ID: <20240213-cilantro-operator-acbf40493bbd@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
 <20240213-limping-ether-adbdc205ebc6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u2GAsATBmAnP+sFu"
Content-Disposition: inline
In-Reply-To: <20240213-limping-ether-adbdc205ebc6@spud>


--u2GAsATBmAnP+sFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 05:03:46PM +0000, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:
> > The baseline for the RISC-V privileged ISA is version 1.10. Using
> > features from newer versions of the privileged ISA requires the
> > supported version to be reported by platform firmware, either in the ISA
> > string (where the binding already accepts version numbers) or in the
> > riscv,isa-extensions property. So far two newer versions are ratified.
> >=20
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >=20
> > Changes in v2:
> >  - New patch for v2
> >=20
> >  .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 63d81dc895e5..7faf22df01af 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -121,6 +121,16 @@ properties:
> >              version of the privileged ISA specification.
> > =20
> >          # multi-letter extensions, sorted alphanumerically
>=20
> > +        - const: sm1p11
>=20
> Why are we beholden to this "1p11" format of RVI's? We have free choice
> of characters here, what's stopping us using "machine-v1.11", for
> example?

We could also choose to communicate this using a specific property, but
I have not really thought that one through yet.

--u2GAsATBmAnP+sFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcuh0QAKCRB4tDGHoIJi
0kU0AP9uxqhi6Z2+S2utazinjy8ljsSHNNck/QoB6/noAi95sgEAwXNwzyDHMqVL
OfP6NZnX2lys3JrbYHWSXQjvFwxgCgU=
=Eqbk
-----END PGP SIGNATURE-----

--u2GAsATBmAnP+sFu--

