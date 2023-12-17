Return-Path: <linux-kernel+bounces-2809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A639816246
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258991C20D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5BF487B9;
	Sun, 17 Dec 2023 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvrsPbSD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162948CC0;
	Sun, 17 Dec 2023 21:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A47C433C7;
	Sun, 17 Dec 2023 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702847023;
	bh=mCEcMXWBRCUl8ycxVYQtMfuRfaojP7UvcGTxOXhKDaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvrsPbSDBmXRz7fBWAVgf3e4EySM97yOUjYsBwbpgyiOdI9DY8G/gQoVfOAG5b9io
	 ELWQSRpweiRp25KmFZScZE1R7gu3L4njHUmSeYafmHTHI1hXgkZaaWm+wXueeGyORN
	 sZLgKSVG117kpnXWB//nwjQTcU5HLd07b5ozYEhy3wzX0cuqZ6M2yicJ+k0XCxRjaU
	 bYfavnhJ/435XHwjKKNE8uKp5+tbIyQKUqBUcbUdsw3Poed/utfsxAEUQnqJbL1W+U
	 yBb5EgZjWizSeRZC1XgwZNH1Nz5Hg1OZg9pXcBUMplPIgDrLmtpz+n3p6shg2jcd1L
	 P3At3ee5NOOhQ==
Date: Sun, 17 Dec 2023 21:03:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 5/9] riscv: dts: starfive: jh7100-common: Setup pinmux
 and enable gmac
Message-ID: <20231217-rippling-galleria-904152e41f95@spud>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-6-cristian.ciocaltea@collabora.com>
 <CAJM55Z-bg0EGPaLHtxcu2AzqN59zfuiT0eE7oCShrx7dG_QK1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kG7DkOG8HSp8FfWf"
Content-Disposition: inline
In-Reply-To: <CAJM55Z-bg0EGPaLHtxcu2AzqN59zfuiT0eE7oCShrx7dG_QK1g@mail.gmail.com>


--kG7DkOG8HSp8FfWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:38:53AM -0800, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
> > Add pinmux configuration for DWMAC found on the JH7100 based boards and
> > enable the related DT node, providing a basic PHY configuration.
> >
> > Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  .../boot/dts/starfive/jh7100-common.dtsi      | 85 +++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/ris=
cv/boot/dts/starfive/jh7100-common.dtsi
> > index 42fb61c36068..5cafe8f5c2e7 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> > @@ -72,7 +72,92 @@ wifi_pwrseq: wifi-pwrseq {
> >  	};
> >  };
> >
> > +&gmac {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&gmac_pins>;
> > +	phy-mode =3D "rgmii-id";
> > +	phy-handle =3D <&phy>;
>=20
> I'm not sure if it's a generic policy or not, but I don't really like add=
ing a
> reference to a non-existant node here. I'd move this property to the board
> files where the phy node is actually defined.

FWIW, I don't like the reference-in-the-wrong-place thing either.

--kG7DkOG8HSp8FfWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9iKAAKCRB4tDGHoIJi
0ljjAQDdeQS9ySXycX3Kr1uE7USW6FuoSN3axiU/roL2LS3UxAD/QmhKPwhsop/g
JHAPtH4K9zTWBI5z0reix7grWZuUDgQ=
=ljQG
-----END PGP SIGNATURE-----

--kG7DkOG8HSp8FfWf--

