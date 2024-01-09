Return-Path: <linux-kernel+bounces-20877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4E8286CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D82282938
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CB38DFB;
	Tue,  9 Jan 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HBc4tMSu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7C374C5;
	Tue,  9 Jan 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704805562; x=1736341562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpBv9CLJKeH2ktyG75BQLyQVSsvCPHK4QXybdij5Pio=;
  b=HBc4tMSuWs+KnUApm6tWhVDNwbCTmXvmvbrrGwW4zDnJ8WtpID2hFhdy
   iZ0kBe4eJvO0ZK5ruYWj31LZjybFljxUzW54YYbMEpH1zc2xChX8CCA4K
   83qV+T96KPD7Bhexubpv230enFwS8BFyVGanUQjK82lrH0G3Drb9Ss9ly
   KQDmQTBlcnZUvG54TZOTOVzjtbpn97Wf09GCKhvgGcVUbXKLXb4HlTmIt
   szK42eetPNE3JhIasQ1zIC/MQ/bjjQXjyv7yd44PEsovv23QMYBLsAxb0
   dA2JlbSUEmK4whZ7GQLULHj3elLA9+snB6qJNad5q4olEG7r/01qE/pbW
   A==;
X-CSE-ConnectionGUID: z9oYC0TYRhSMRpXWHeg5bw==
X-CSE-MsgGUID: iYtnSFXNRk2uY32sOXE+VQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="asc'?scan'208";a="14904599"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 06:06:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 06:05:29 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Jan 2024 06:05:27 -0700
Date: Tue, 9 Jan 2024 13:04:52 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2 3/8] riscv: dts: thead: Add TH1520 pin control nodes
Message-ID: <20240109-tiptoeing-twirl-ebb943e17a29@wendy>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
 <20240103132852.298964-4-emil.renner.berthing@canonical.com>
 <20240108-majorette-overtly-4ec65d0a15e9@spud>
 <CAJM55Z_2zhELW3E7p94J05We17xTC2Rejs5AigNJOHCGHVr_zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XthaSr7XjsnpG3pO"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_2zhELW3E7p94J05We17xTC2Rejs5AigNJOHCGHVr_zg@mail.gmail.com>

--XthaSr7XjsnpG3pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 04:02:01AM -0800, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > On Wed, Jan 03, 2024 at 02:28:40PM +0100, Emil Renner Berthing wrote:
> > > Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.
> > >
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > > ---
> > >  .../boot/dts/thead/th1520-beaglev-ahead.dts   |  4 ++++
> > >  .../dts/thead/th1520-lichee-module-4a.dtsi    |  4 ++++
> > >  arch/riscv/boot/dts/thead/th1520.dtsi         | 24 +++++++++++++++++=
++
> > >  3 files changed, 32 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arc=
h/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > index 70e8042c8304..6c56318a8705 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > @@ -44,6 +44,10 @@ &osc_32k {
> > >  	clock-frequency =3D <32768>;
> > >  };
> > >
> > > +&aonsys_clk {
> > > +	clock-frequency =3D <73728000>;
> > > +};
> > > +
> > >  &apb_clk {
> > >  	clock-frequency =3D <62500000>;
> > >  };
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b=
/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > index a802ab110429..9865925be372 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > @@ -25,6 +25,10 @@ &osc_32k {
> > >  	clock-frequency =3D <32768>;
> > >  };
> > >
> > > +&aonsys_clk {
> > > +	clock-frequency =3D <73728000>;
> > > +};
> > > +
> > >  &apb_clk {
> > >  	clock-frequency =3D <62500000>;
> > >  };
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/=
dts/thead/th1520.dtsi
> > > index ba4d2c673ac8..e65a306ff575 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -134,6 +134,12 @@ osc_32k: 32k-oscillator {
> > >  		#clock-cells =3D <0>;
> > >  	};
> > >
> > > +	aonsys_clk: aonsys-clk {
> > > +		compatible =3D "fixed-clock";
> > > +		clock-output-names =3D "aonsys_clk";
> > > +		#clock-cells =3D <0>;
> > > +	};
> >
> > Did this stuff sneak into this commit accidentally?
>=20
> Not really by accident no. It turns out the clock tree has gates for the =
bus
> clock of each pinctrl block and I think it's better to add this clock
> dependency to the bindings and driver up front.

Maybe if I had looked a wee bit more deeply I would've noticed that it
was used there, but it's always good to mention the rationale in the
commit message so that it's more obvious why you're doin it.

> Since there is not yet any clock driver the initial device tree for the T=
H1520
> included the dummy apb_clk that two of the pinctrl blocks derive their cl=
ock
> from, but not the "aonsys" clock needed by the "always-on" pinctrl. I tho=
ught
> it was better to add this dummy clock with the only (so far) user of it, =
but if
> you have a better idea, let me know.

No, that's fine. I was just wondering why there was an unmentioned set
of clocks being added. If they're stubbed fixed clocks I dunno if it
makes sense to add them to the board.dts/module.dtsi files though. Where
do the initial values come from for the rates? Out of reset values or
set by firmware that may vary from board to board?

Cheers,
Conor.

--XthaSr7XjsnpG3pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1EdAAKCRB4tDGHoIJi
0ttJAPsEUXEE+T2o1HyH4EYifCCIDWdJZg4jidJGk2a0Yy+zNQD/UmU1FXzzcPlx
B6tqiO1KUss7XC5DTIAZ9oVaxy5K9gU=
=cRuY
-----END PGP SIGNATURE-----

--XthaSr7XjsnpG3pO--

