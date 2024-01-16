Return-Path: <linux-kernel+bounces-27263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C082ECE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DBC285497
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3117598;
	Tue, 16 Jan 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m1CJZ8GS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1013FEC;
	Tue, 16 Jan 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705401907; x=1736937907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jHGGpGh4/MgHAVgMxsA0r7UyDWvPUjd2U3iqvzqI5I4=;
  b=m1CJZ8GSAXQo7fG2xzwArFMUXbL5StM7m4ry7iEW9gL/uJAMt5e1n+5F
   HFxNqhCfFUg/9WgpxTlflPjSqxHaTqW9m8GBFla/lxh3ax0l/VW+/4lSo
   teueSZAPKgpswuoZrtackdjzeosdZfvGE91/65gkYAn1jhJBJK/K+o78l
   yl4SiSC+5SPTvvtOoOc+inIyyxD4SXEnLWr9+6IM6hDev7KRvaiKVg80U
   UwSoS/l/nfupEk/bYgqm3AOKhZM4pgUFYLbSpvADdGJ1Lx/8mnvdoRMpf
   M3efYNRYC/3loEMkeuEJp8SRjCOOw5SyEnVR9M0UPMuohLTqJgP9qw1tZ
   Q==;
X-CSE-ConnectionGUID: OYl/i3GiRI22Pg4Ra+XJtQ==
X-CSE-MsgGUID: zKuPVUJwS3+E6LjSAt2uZA==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="14823470"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 03:45:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 03:44:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 03:44:46 -0700
Date: Tue, 16 Jan 2024 10:44:10 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: Nylon Chen <nylon.chen@sifive.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <conor+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
	<aou@eecs.berkeley.edu>, <zong.li@sifve.com>, <vincent.chen@sifive.com>,
	<linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<nylon7717@gmail.com>
Subject: Re: [v6 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
Message-ID: <20240116-custard-drew-9a02e83d538a@wendy>
References: <20240116041054.11641-1-nylon.chen@sifive.com>
 <20240116041054.11641-2-nylon.chen@sifive.com>
 <CAJM55Z9ZbmbPKaJ8LJ5KyoCW9fAEJaT3Q4PbcadwLNCq1NXbxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IllJYSRTwnK6qQf5"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9ZbmbPKaJ8LJ5KyoCW9fAEJaT3Q4PbcadwLNCq1NXbxA@mail.gmail.com>

--IllJYSRTwnK6qQf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:20:57AM -0800, Emil Renner Berthing wrote:
> Nylon Chen wrote:
> > This removes the active-low properties of the PWM-controlled LEDs in
> > the HiFive Unmatched device tree.
> >
> > The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schem=
atics-v3.pdf[1].
> >
> > Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8=
453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> > Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68c=
e76f4192_hifive-unmatched-schematics-v3.pdf [1]
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Co-developed-by: Zong Li <zong.li@sifve.com>
> > Signed-off-by: Zong Li <zong.li@sifve.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > ---
> >  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
> >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
> >  2 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch=
/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > index 900a50526d77..11e7ac1c54bb 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > @@ -49,7 +49,7 @@ led-controller {
> >  		compatible =3D "pwm-leds";
> >
> >  		led-d1 {
> > -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > +			pwms =3D <&pwm0 0 7812500 0>;
> >  			active-low;
> >  			color =3D <LED_COLOR_ID_GREEN>;
> >  			max-brightness =3D <255>;
> > @@ -57,7 +57,7 @@ led-d1 {
> >  		};
> >
> >  		led-d2 {
> > -			pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> > +			pwms =3D <&pwm0 1 7812500 0>;
> >  			active-low;
> >  			color =3D <LED_COLOR_ID_GREEN>;
> >  			max-brightness =3D <255>;
> > @@ -65,7 +65,7 @@ led-d2 {
> >  		};
> >
> >  		led-d3 {
> > -			pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> > +			pwms =3D <&pwm0 2 7812500 0>;
> >  			active-low;
> >  			color =3D <LED_COLOR_ID_GREEN>;
> >  			max-brightness =3D <255>;
> > @@ -73,7 +73,7 @@ led-d3 {
> >  		};
> >
> >  		led-d4 {
> > -			pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> > +			pwms =3D <&pwm0 3 7812500 0>;
> >  			active-low;
> >  			color =3D <LED_COLOR_ID_GREEN>;
> >  			max-brightness =3D <255>;
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch=
/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 07387f9c135c..b328ee80693f 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -51,8 +51,7 @@ led-controller-1 {
> >  		compatible =3D "pwm-leds";
> >
> >  		led-d12 {
> > -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > -			active-low;
> > +			pwms =3D <&pwm0 0 7812500 0>;
>=20
> Here you remove the active-low property, but you don't above. I'm not sure
> what's the right thing to do, but I would have expected the same change i=
n both
> places.

Just to note, the original version of this that I acked/reviewed removed
the property from all led nodes. I then apparently didn't look closely
enough at v5 and left acked/reviewed tags on it too. It did not remove
the active-low properties but this change was not mentioned in the
changelog for the series.

D4 on the unleashed and D12 on the unmatched have the same circuitry
(modulo the placement of the series resistor) so I don't get why the
property is being removed from only D12.

I rescind my ack/review until that is clarified and/or fixed.

Thanks,
Conor.


> >  			color =3D <LED_COLOR_ID_GREEN>;
> >  			max-brightness =3D <255>;
> >  			label =3D "d12";
> > @@ -68,20 +67,17 @@ multi-led {
> >  			label =3D "d2";
> >
> >  			led-red {
> > -				pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> > -				active-low;
> > +				pwms =3D <&pwm0 2 7812500 0>;
> >  				color =3D <LED_COLOR_ID_RED>;
> >  			};
> >
> >  			led-green {
> > -				pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> > -				active-low;
> > +				pwms =3D <&pwm0 1 7812500 0>;
> >  				color =3D <LED_COLOR_ID_GREEN>;
> >  			};
> >
> >  			led-blue {
> > -				pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> > -				active-low;
> > +				pwms =3D <&pwm0 3 7812500 0>;
> >  				color =3D <LED_COLOR_ID_BLUE>;
> >  			};
> >  		};
> > --
> > 2.42.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

--IllJYSRTwnK6qQf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaZd+QAKCRB4tDGHoIJi
0ojCAP9YNgYC4jBsQgF0fIM37HjeKwwrAxp5ishwLKUKa9BKYAD9HCzhM/N+Tc7h
NaSisFJ74M5IGYP0aZCDYgCf1EHv5gE=
=Qjx9
-----END PGP SIGNATURE-----

--IllJYSRTwnK6qQf5--

