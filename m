Return-Path: <linux-kernel+bounces-2818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589281625C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257881F21FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F749F90;
	Sun, 17 Dec 2023 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsxGX/S/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5F495E1;
	Sun, 17 Dec 2023 21:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317F9C433C8;
	Sun, 17 Dec 2023 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702847388;
	bh=pDlIZybXRI8LmSUJwxQ9swF4niWXVQabD7yDs33HQw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsxGX/S/ViVVCvVazbG/67dop8rBwKNAK0dNrdbW9ku1xUK7Uy3PWJ/3prB6KR7A3
	 jaGh7tY7oq7+/vcSnaDXXTMuXA2Qm1tnkWSGSHx5C6c4RYOUrIiREi7tXvCgTG3Lej
	 eSmpo0Y6z/UH6KL13F/6r8JOuERk45EhQAXHJjBn96lWKFrBXLgK4GafN+SukoCDkj
	 ZllSmcsT95dO8YHkqIUK3VFP0Al0dgbjW4iZoSw4DLVvwOMLHv4r69rdXPz7OHuISH
	 Bi2J87TZYPASi2rtj4daAGOhyXv7leeDj8PRokk4Ts0ne4ym7UJYLGGF45GYkYwY11
	 EMg0VORZNSAeg==
Date: Sun, 17 Dec 2023 21:09:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/9] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Message-ID: <20231217-spray-livestock-a59d630b751e@spud>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-3-cristian.ciocaltea@collabora.com>
 <A7C96942-07CB-40FD-AAAA-4A8947DEE7CA@jrtc27.com>
 <65fd52f1-6861-42b0-9148-266766d054b1@sifive.com>
 <6c62e3b2-acde-4580-9b67-56683289e45e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="npmbwANzcjocFUKY"
Content-Disposition: inline
In-Reply-To: <6c62e3b2-acde-4580-9b67-56683289e45e@collabora.com>


--npmbwANzcjocFUKY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:03:24PM +0200, Cristian Ciocaltea wrote:
> On 12/15/23 22:59, Samuel Holland wrote:
> > On 2023-12-15 2:47 PM, Jessica Clarke wrote:
> >> On 15 Dec 2023, at 20:40, Cristian Ciocaltea <cristian.ciocaltea@colla=
bora.com> wrote:
> >>>
> >>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
> >>> similar to the newer JH7110, but it requires only two interrupts and a
> >>> single reset line, which is 'ahb' instead of the commonly used
> >>> 'stmmaceth'.
> >>>
> >>> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
> >>> conjunction with 'stmmaceth', extend the logic to also permit exclusi=
ve
> >>> usage of the 'ahb' reset name.  This ensures the following use cases =
are
> >>> supported:
> >>>
> >>>  JH7110: reset-names =3D "stmmaceth", "ahb";
> >>>  JH7100: reset-names =3D "ahb";
> >>>  other:  reset-names =3D "stmmaceth";
> >>>
> >>> Also note the need to use a different dwmac fallback, as v5.20 applies
> >>> to JH7110 only, while JH7100 relies on v3.7x.
> >>>
> >>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >>> ---
> >>> .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +-
> >>> .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
> >>> 2 files changed, 55 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/=
Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >>> index 5c2769dc689a..c1380ff1c054 100644
> >>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >>> @@ -95,6 +95,7 @@ properties:
> >>>         - snps,dwmac-5.20
> >>>         - snps,dwxgmac
> >>>         - snps,dwxgmac-2.10
> >>> +        - starfive,jh7100-dwmac
> >>>         - starfive,jh7110-dwmac
> >>>
> >>>   reg:
> >>> @@ -146,7 +147,7 @@ properties:
> >>>   reset-names:
> >>>     minItems: 1
> >>>     items:
> >>> -      - const: stmmaceth
> >>> +      - enum: [stmmaceth, ahb]
> >>>       - const: ahb
> >>
> >> I=E2=80=99m not so well-versed in the YAML bindings, but would this no=
t allow
> >> reset-names =3D "ahb", "ahb"?
> >=20
> > Yes, it would. You need something like:
> >=20
> > reset-names:
> >   oneOf:
> >     - enum: [stmmaceth, ahb]
> >     - items:
> >         - const: stmmaceth
> >         - const: ahb
>=20
> Oh yes, I always forget about the "oneOf" thing. Thanks!

Won't this also relax the naming for all devices that allow a single
reset, but expect the stmmaceth one? I'm not sure that that actually
matters, I think the consumer bindings have constraints themselves.

--npmbwANzcjocFUKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9jlAAKCRB4tDGHoIJi
0u2kAQDwhBC97TRp152I+1W+AAVbbj170OQONz+W/j8kuDieIwD/cY+M0Ecr1wRq
sRFbcJiO+jHPZHDgTTISrvusYc5QxwU=
=mt/n
-----END PGP SIGNATURE-----

--npmbwANzcjocFUKY--

