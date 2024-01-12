Return-Path: <linux-kernel+bounces-24730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2879D82C178
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AC5286BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190E6DD13;
	Fri, 12 Jan 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kTKxJY5X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F836DCE7;
	Fri, 12 Jan 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705069220;
	bh=Y00IcYmAGqjkXxmqCRg4Ou9eblS4gIaU95j+2+yuqxc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kTKxJY5XYGvh8G9hAuYRUCaqNGR+p+4yQSbTjGZeLbh6al1oAeHQCBDs+cTXiKweV
	 nFPDmwy6W0paicJoJsyIkRMveAKrwg846hNcl4t5x0h5/pfma7TJ0K0Vd6IQN6CQNE
	 Y3/lV8fe4oxhRZE7e5u2GiVTKizuaRYy6OhItqLplVRY2g0OSjkcTA29PF9+bEv+zz
	 gsIoEVeRwBG5bsHlRindxu4m70hsQk0X5+mDZramgRH2ICJ5yeFdHMCXqcfV2jGZv8
	 GjEO6oAosZpZHUXsDu6SrX1sVaY67O/h1vNY3+fawpTtf15OygrZ5QG5PSNKpcOKoq
	 3cJBHTQPyAtAQ==
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E692E3780624;
	Fri, 12 Jan 2024 14:20:19 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 866F29F0AEA0; Fri, 12 Jan 2024 15:20:19 +0100 (CET)
Message-ID: <2ce27ed917b9bd569ee4a7f87b3d9b78d07cecbd.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin
 mdio bus
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@kernel.org>,
  kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2024 15:20:19 +0100
In-Reply-To: <20240112135000.b54xz3boeua7y2jf@music>
References: <20240112124505.2054212-1-sjoerd@collabora.com>
	 <20240112135000.b54xz3boeua7y2jf@music>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 07:50 -0600, Nishanth Menon wrote:
> On 13:44-20240112, Sjoerd Simons wrote:
> > The beagleplay dts was using a bit-bang gpio mdio bus as a work-
> > around
> > for errata i2329. However since commit d04807b80691 ("net:
> > ethernet: ti:
> > davinci_mdio: Add workaround for errata i2329") the mdio driver
> > itself
> > already takes care of this errata for effected silicon, which
> > landed
> > well before the beagleplay dts. So i suspect the reason for the
> > workaround in upstream was simply due to copying the vendor dts.
> >=20
> > Switch the dts to the ti,cpsw-mdio instead so it described the
> > actual
> > hardware and is consistent with other AM625 based boards
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> >=20
> > ---
>=20
> We have had issues with the ethernet integration previously (also why
> ethernet in u-boot is not yet functional on beagleplay[1]).
>=20
> https://openbeagle.org/beagleplay/beagleplay/-/issues/101
>=20
> we should probably do a 1000 boot nfs test or something to ensure
> this
> doesn't introduce regressions (I recollect mdio wasn't stable on
> beagleplay) and switching to bitbang driver stopped all complains.

I can do a longer test with that over the weekend sure; For reference
I'm seeing issues in u-boot as well on initial probe with these
changes, but i've not seen the same on the linux side.

Do you remember with what kernel versions users saw the mdio
instabilities? I wonder if that was a version with the commit mentioned
that includes the errata fix for the mdio driver.



>=20
> [1]
> https://lore.kernel.org/u-boot/20230822121350.51324-1-rogerq@kernel.org/
> >=20
> > =C2=A0.../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 42 +++++++-------=
-
> > ----
> > =C2=A01 file changed, 16 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > index eadbdd9ffe37..49fb21ba62b0 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> > @@ -29,7 +29,6 @@ aliases {
> > =C2=A0		i2c3 =3D &main_i2c3;
> > =C2=A0		i2c4 =3D &wkup_i2c0;
> > =C2=A0		i2c5 =3D &mcu_i2c0;
> > -		mdio-gpio0 =3D &mdio0;
> > =C2=A0		mmc0 =3D &sdhci0;
> > =C2=A0		mmc1 =3D &sdhci1;
> > =C2=A0		mmc2 =3D &sdhci2;
> > @@ -231,27 +230,6 @@ simple-audio-card,codec {
> > =C2=A0		};
> > =C2=A0	};
> > =C2=A0
> > -	/* Workaround for errata i2329 - just use mdio bitbang */
> > -	mdio0: mdio {
> > -		compatible =3D "virtual,mdio-gpio";
> > -		pinctrl-names =3D "default";
> > -		pinctrl-0 =3D <&mdio0_pins_default>;
> > -		gpios =3D <&main_gpio0 86 GPIO_ACTIVE_HIGH>, /* MDC
> > */
> > -			<&main_gpio0 85 GPIO_ACTIVE_HIGH>; /* MDIO
> > */
> > -		#address-cells =3D <1>;
> > -		#size-cells =3D <0>;
> > -
> > -		cpsw3g_phy0: ethernet-phy@0 {
> > -			reg =3D <0>;
> > -		};
> > -
> > -		cpsw3g_phy1: ethernet-phy@1 {
> > -			reg =3D <1>;
> > -			reset-gpios =3D <&main_gpio1 5
> > GPIO_ACTIVE_LOW>;
> > -			reset-assert-us =3D <25>;
> > -			reset-deassert-us =3D <60000>; /* T2 */
> > -		};
> > -	};
> > =C2=A0};
> > =C2=A0
> > =C2=A0&main_pmx0 {
> > @@ -312,8 +290,8 @@ AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /*
> > (K24) GPMC0_CSn3.I2C2_SDA */
> > =C2=A0
> > =C2=A0	mdio0_pins_default: mdio0-default-pins {
> > =C2=A0		pinctrl-single,pins =3D <
> > -			AM62X_IOPAD(0x0160, PIN_OUTPUT, 7) /*
> > (AD24) MDIO0_MDC.GPIO0_86 */
> > -			AM62X_IOPAD(0x015c, PIN_INPUT, 7) /*
> > (AB22) MDIO0_MDIO.GPIO0_85 */
> > +			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /*
> > (AD24) MDIO0_MDC */
> > +			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /*
> > (AB22) MDIO0_MDIO */
> > =C2=A0		>;
> > =C2=A0	};
> > =C2=A0
> > @@ -611,8 +589,20 @@ &cpsw_port2 {
> > =C2=A0};
> > =C2=A0
> > =C2=A0&cpsw3g_mdio {
> > -	/* Workaround for errata i2329 - Use mdio bitbang */
> > -	status =3D "disabled";
> > +	status =3D "okay";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mdio0_pins_default>;
> > +
> > +	cpsw3g_phy0: ethernet-phy@0 {
> > +		reg =3D <0>;
> > +	};
> > +
> > +	cpsw3g_phy1: ethernet-phy@1 {
> > +		reg =3D <1>;
> > +		reset-gpios =3D <&main_gpio1 5 GPIO_ACTIVE_LOW>;
> > +		reset-assert-us =3D <25>;
> > +		reset-deassert-us =3D <60000>; /* T2 */
> > +	};
> > =C2=A0};
> > =C2=A0
> > =C2=A0&main_gpio0 {
> > --=20
> > 2.43.0
> >=20
>=20

--=20
Sjoerd Simons
Collabora Ltd.

