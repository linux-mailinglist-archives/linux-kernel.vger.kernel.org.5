Return-Path: <linux-kernel+bounces-152290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE18ABBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B081C208F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A5262BE;
	Sat, 20 Apr 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqrNfyoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE781CAA9;
	Sat, 20 Apr 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713622661; cv=none; b=G853/7csDzQdgOrqXvcVucOXetEIcUHnlhqn5KohyA/P2KmUrkznx4H4tQ7SC+D0VZVcOqfQzghZE98j451BOpXJdrlifIcOrkIaSnbMcAYSkRr4Y87B4bdk+9opf2J5kZY8l7dVS/+59PIwK7P2Z4bvmF1pXbB30oihzJHiczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713622661; c=relaxed/simple;
	bh=Mxf4y0BRq/mUXjfjugfPwbXVy4IObRMWA6nlfpEgOk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF1wNf8n57YK0BGTk2e1Sa1fFdHAIPXmvne7aPeNGz7VXRByHl0UUTFtujWblsfkmlrRwvspYurT35htHoOeH9tf4OdPkYlD35u8dW4/WPth7p8l5t/xOu2jIhBbRUx7BLi47lxW5lVfJfJ2iEQEGQg9DIKzXnfzgwJrnyGbWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqrNfyoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250EBC072AA;
	Sat, 20 Apr 2024 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713622660;
	bh=Mxf4y0BRq/mUXjfjugfPwbXVy4IObRMWA6nlfpEgOk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqrNfyoRqbnCkeagvZZn/miOJyo1V86pdOt+6MHQd92MCs/ltD4+12sRNhq/smUeM
	 qEEwe1u+EA8dLZlM9o2oWXOE8M03lk/TZZuZZ0urQs7i3M8hou8pYSaXYu2kMqcvz2
	 bR10GpF6jVU+gOa2xXf9iCKERBuEsK7ViGNnaZhRubGxdVoJB9lBDvZdVp07prWgr0
	 PmZ91HD8NOppgMjTkglcgHjXvmtnUMAZwYw/m1oc9yxwGp/GeYWE9/+l/81fmdCzPZ
	 nIYx82re3LgQslgrwF3yVJm390KK5B6Oih2hM8grYaKWHbh6+oP6XRBqi5tasiTbBd
	 87YWjkt88m62A==
Date: Sat, 20 Apr 2024 15:17:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240420151727.767b2861@jic23-huawei>
In-Reply-To: <Zh7xo8__v-ghLcHP@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<7c877c865f0b7da28d9f1f177b3b2692b0ae20b9.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBGKNZhGbD7pQ0Z7SMCWqxqGux0LcO_wW0XGP4hLTOwNBg@mail.gmail.com>
	<ZhVfARtMfOLOPRid@debian-BULLSEYE-live-builder-AMD64>
	<20240413171409.4575fe6f@jic23-huawei>
	<87058695-a1a6-4e68-87c5-accdb8451bf4@baylibre.com>
	<20240414190907.000011e5@Huawei.com>
	<Zh7xo8__v-ghLcHP@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Apr 2024 18:46:11 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> So, I have been trying to make this work, though I haven't been successfu=
l so
> far, and I don't really think using pinctrl is a good solution for this e=
ither.
>=20
> Comments inline.
>=20
> On 04/14, Jonathan Cameron wrote:
> > On Sat, 13 Apr 2024 12:33:54 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > On 4/13/24 11:14 AM, Jonathan Cameron wrote: =20
> > > > On Tue, 9 Apr 2024 12:30:09 -0300
> > > > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> > > >    =20
> > > >> On 04/08, David Lechner wrote:   =20
> > > >>> On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
> > > >>> <marcelo.schmitt@analog.com> wrote:     =20
> > > >>>>   =20
> > >=20
> > > ...
> > >  =20
>=20
> ...
>=20
> > > >>>
> > > >>> We identified A) an additional wiring configuration where SDI of =
the
> > > >>> ADC chip is wired to SDO of the SPI controller and B) a potential=
 need
> > > >>> to pin mux between wiring modes to work around SPI controller
> > > >>> limitations perhaps we could omit the adi,spi-mode property and j=
ust
> > > >>> use the standard pinctrl properties.
> > > >>>
> > > >>>   pinctrl-names:   =20
> > > >=20
> > > > I'm lost on how pinctrl makes sense here.
> > > > Yes you are changing the modes of the pins, but not in a convention=
al sense
> > > > of some register that is being updated to say now use them like thi=
s.
> > > > The mode is dependent on the timing sequence of how the pins are us=
ed.
> > > > Otherwise looking at it a different way it's an external wiring thi=
ng we
> > > > aren't controlling it at all.  Is pinctrl suitable for that?
> > > > I always thought of it as a way to change configurations of SoC pin=
s.   =20
> > >=20
> > > Yes, this is exactly what I think we need here.
> > >=20
> > > To write to the register, the chip has to be wired like this ("defaul=
t"):
> > >=20
> > >                                          +-------------+
> > >      +-----------------------------------| SDO         |
> > >      |                                   |             |
> > >      |              +--------------------| CS          |
> > >      |              v                    |             |
> > >      |    +--------------------+         |     HOST    |
> > >      |    |        CNV         |         |             |
> > >      +--->| SDI   AD7944   SDO |-------->| SDI         |
> > >           |        SCK         |         |             |
> > >           +--------------------+         |             |
> > >                     ^                    |             |
> > >                     +--------------------| SCLK        |
> > >                                          +-------------+
> > >=20
> > > But to read sample data, the chip has to be wired in one of these
> > > 3 configurations:
> > >=20
> > >=20
> > > 3-wire mode ("single"):
> > >=20
> > >                                          +-------------+
> > >                     +--------------------| CS          |
> > >                     v                    |             |
> > >     VIO   +--------------------+         |     HOST    |
> > >      |    |        CNV         |         |             |
> > >      +--->| SDI   AD7944   SDO |-------->| SDI         |
> > >           |        SCK         |         |             |
> > >           +--------------------+         |             |
> > >                     ^                    |             |
> > >                     +--------------------| SCLK        |
> > >                                          +-------------+
> > >  =20
>=20
> 3-wire mode like setup can be achieved if the SPI controller is capable of
> keeping the ADC SDI line high (at VIO level) during ADC sampling, but kee=
ping
> controller SDO high throughout the entire transfer is not a thing all SPI
> controllers can do (RPi's can't).
> If the ADC is hard wired connected as in the 3-wire diagram then the user
> can't write/read the configuration register. Same applies to "4-wire" mode
> where controller CS is connected to ADC SDI.
> The whole point of having pinctrl configurations was to make it possible
> to both read/write config register and do ADC sampling if the SPI control=
ler
> can't keep ADC SDI at VIO. I don't think pinctrl can solve this problem t=
hough.
>=20
> ...
>=20
> > >=20
> > > If we want to be able to both write the register and read data,
> > > some reconfiguration is needed. It might be possible to read data
> > > using the register-write wiring configuration, but that only
> > > works if SDO can be set to the correct state *before* the
> > > CS line changes. This is not something that I think most SPI
> > > controllers can do (e.g. Marcelo mentioned in the cover letter
> > > that RPi always returns SDO to low after every xfer while
> > > the AXI SPI Engine leaves SDO wherever it was last).
> > >  =20
> > > >=20
> > > > A pointer to some precendence in another driver for using it like t=
his
> > > > would go some way towards convincing me.
> > > >=20
> > > > Jonathan
> > > >    =20
> > >=20
> > >=20
> > > I didn't find much precedence for something like this, but I
> > > found devicetree/bindings/net/mediatek-bluetooth.txt that uses
> > > pinctrl to pull a UART Rx pin low for a bootstrap mode which
> > > sounds very similar to what we need to do here (pull the SPI
> > > controller SDO pin high or low for 3-wire or chain mode).
> > >  =20
>=20
> The pinctrl configuration for this ADC would not be meant to change once =
after
> boot as it looks to be the usual use case for pinctrl (including mediatek=
-bluetooth.txt).
>=20
> Also, no suitable mux for the "3-wire" mode in
> Documentation/devicetree/bindings/pinctrl/xlnx,pinctrl-zynq.yaml
> to do it like Documentation/devicetree/bindings/net/mediatek-bluetooth.tx=
t.
> The zynq pinctrl driver (drivers/pinctrl/pinctrl-zynq.c) would have to be
> updated to add the new mux function in=20
> static const struct zynq_pinmux_function zynq_pmux_functions[] =3D {
> 	DEFINE_ZYNQ_PINMUX_FUNCTION(ethernet0, 1),
> ...
> 	DEFINE_ZYNQ_PINMUX_FUNCTION(axi_spi_single, 1),
> 	DEFINE_ZYNQ_PINMUX_FUNCTION(axi_spi_multi, 2),
> though this is not really a thing that's on zynq, but one that is related=
 to
> these ADCs so I'm not sure it should go there.


I'd argue we are after a specific SPI controller setup for this.
A controller driver would need modifying to make it work.

>=20
> > > For example, if we wanted to use 3-wire mode for reading
> > > data, we would set the pinctrl to "default" to write the
> > > register to configure the chip during driver probe. Then
> > > to read data, we would change the pinctrl to "single" before
> > > doing the SPI xfer to ensure that the ADC SDI pin is pulled
> > > high independent of what the SDO line of the SPI controller
> > > is currently doing. =20
>=20
> No, the pin configuration for this ADCs would be expected to change unres=
tricted
> amount of times. The pin configuration would have to change every time a =
sample
> read is made after a register access transfers and vice-versa. If we deci=
de
> to support span compression, every change to _scale would lead to pinctrl
> configuration change.
>=20
> At pin level, we would want to rise SPI controller SDO line to VIO but th=
en
> the new SDO pin config would conflict with SPI pin group config.
>=20
> I included pinctrl properties in my test dts to make use of pinctrl frame=
work.
> Yet, that doesn't really alternate SPI line configuration we are using be=
cause
> the SPI function that is in the PS (FPGA's Processing System) is not what=
 we are
> interfacing when using spi-engine. Copy of my test dts at end of email.
>=20
> Currently, the SPI controller we are using to test with these exotic ADCs
> is the spi-engine which is implemented in the FPGA as an IP block which
> owns control of the bus lines (SPI, SDO, CS, ...). To alternate the
> configuration of SPI lines (pull SDO (ADC SDI) up to VIO, connect control=
ler CS
> to ADC SDI, etc.) I think it should be done in the HDL project. I don't t=
hink
> it's a good idea to hijack spi-engine lines through pinctrl.

Such functionality would need to be pushed to the spi controller driver
which could know if there was any need to do anything like this, or if there
was simply a register to set.

>=20
> >=20
> > Ah ok.  This is implying that we are switching to a controllable
> > mode to pull that pin high (or I guess one where it is always
> > high).  I'm not sure if that's more common than an SPI controller
> > where you can set the 'don't' care state to high or low.
> > I assume we can't get away with just setting the output buffer
> > to all 1s because it won't hold that state between transfers? =20
>=20
> I tried sending the tx buffer filled with 1s when testing this with a RPi=
4 but
> it brought the controller SDO (ADC SDI) line low between each 8 bits of t=
ransfer
> (attaching an image (yellow line is SCLK, green lines is controller SDO)).

Pity - thought that was overly optimistic.

> Anyway, can we have any guaranties with respect to controller SDO line be=
haviour
> when its not clocking out data?


>=20
> >=20
> > Feels like that could be rolled into the SPI subsystem with
> > any necessary transitions handled there (maybe) =20
>=20
> To me, this sounds more reasonable than pinctrl.
> Yeah, if we can set a don't' care state for the SDO line then that should=
 be
> enough for these ADCs.
> Otherwise, can we really do anything if the controller can't keep SDO hig=
h?

There is one similar (ish) entry already.
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/spi/spi.h=
#L29
#define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
in that it is controlling state in what I think would normally be a don't c=
are state.

I think we could have an
SPI_SDO_DONT_CARE_HIGH (naming to be improved upon ;)=20
that a driver could advertise support for and the spi device could request.

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/panel/panel-=
tpo-tpg110.c#L429

Implement that in the spi-gpio driver as a PoC probably and in your SPI cop=
ntoller
driver.

Ultimately if the controller really isn't capable (including dances through=
 pin
mode changes if necessary) then the ADC won't work in this wiring with that=
 host
controller.

I'd propose something along these lines and see whether Mark + any other ac=
tive
SPI folk think it is reasonable or not?

>=20
> >=20
> > Just to check, this isn't just a case of a missing pull up
> > resistor to drag that line correctly when it isn't actively
> > driven (combined with all 1s in the write buffer) etc? =20
>=20
> When using spi-engine, the controller SDO is connected to ADC SDI, contro=
ller
> CS to ADC CNV and, for reg access, it works as conventional SPI.
> spi-engine leaves the SDO line the state it was after last transfer so it=
 we
> can make it idle high during sample read. No hardware pull-up needed.

Fair enough. No multi master support I guess (that is a bit obscure for
SPI).  A little ugly that it's dependent on the last access - so you would =
need
to do a dummy access if the normal last bit was wrong level?

Jonathan

>=20
> Marcelo
>=20
> >=20
> > Jonathan
> >=20
> >  =20
>=20
> The device tree source file I was using for testing with the ADC with the
> changes for using pinctrl. Didn't really work.
>=20
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Analog Devices ADAQ4003
>  * https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc=
/ad400x
>  * https://wiki.analog.com/resources/eval/user-guides/ad400x
>  *
>  * hdl_project: <pulsar_adc_pmdz/zed>
>  * board_revision: <>
>  *
>  * Copyright (C) 2016-2023 Analog Devices Inc.
>  */
> /dts-v1/;
>=20
> #include "zynq-zed.dtsi"
> #include "zynq-zed-adv7511.dtsi"
> #include <dt-bindings/pinctrl/pinctrl-zynq.h>
>=20
> / {
> 	adc_vref: regulator-vref {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "EVAL 5V Vref";
> 		regulator-min-microvolt =3D <5000000>;
> 		regulator-max-microvolt =3D <5000000>;
> 		regulator-always-on;
> 	};
>=20
> 	adc_vdd: regulator-vdd {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "Eval VDD supply";
> 		regulator-min-microvolt =3D <1800000>;
> 		regulator-max-microvolt =3D <1800000>;
> 		regulator-always-on;
> 	};
>=20
> 	adc_vio: regulator-vio {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "Eval VIO supply";
> 		regulator-min-microvolt =3D <3300000>;
> 		regulator-max-microvolt =3D <3300000>;
> 		regulator-always-on;
> 	};
> };
>=20
> &pinctrl0 {
> 	/* Restore conventional SPI pin configuration */
> 	pinctrl_spi_default: default_config {
> 		mux {
> 			/* Are these the ones used by spi-engine? */
> 			groups =3D "spi0_0_grp";
> 			function =3D "spi0";
> 		};
> 		conf {
> 			groups =3D "spi0_0_grp";
> 			power-source =3D <IO_STANDARD_LVCMOS33>;
> 		};
> 		conf-spi-sdo {
> 			pins =3D "MIO17"; /* SPI0 SDO? */
> 			bias-disable;
> 		};
> 	};
>=20
> 	/* Pull-up SPI SDO (ADC SDI) to VIO */
> 	pinctrl_spi_single: single_config {
> 		conf-spi-sdo {
> 			pins =3D "MIO17"; /* Conflicts with SPI0 pin group */
> 			bias-pull-up;
> 		};
> 	};
> };
>=20
> &fpga_axi {
> 	rx_dma: rx-dmac@44a30000 {
> 		compatible =3D "adi,axi-dmac-1.00.a";
> 		reg =3D <0x44a30000 0x1000>;
> 		#dma-cells =3D <1>;
> 		interrupts =3D <0 57 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&clkc 17>;
>=20
> 		adi,channels {
> 			#size-cells =3D <0>;
> 			#address-cells =3D <1>;
>=20
> 			dma-channel@0 {
> 				reg =3D <0>;
> 				adi,source-bus-width =3D <32>;
> 				adi,source-bus-type =3D <1>;
> 				adi,destination-bus-width =3D <64>;
> 				adi,destination-bus-type =3D <0>;
> 			};
> 		};
> 	};
>=20
> 	axi_pwm_gen: axi-pwm-gen@ {
> 		compatible =3D "adi,axi-pwmgen";
> 		reg =3D <0x44b00000 0x1000>;
> 		label =3D "cnv";
> 		#pwm-cells =3D <2>;
> 		clocks =3D <&spi_clk>;
> 	};
>=20
> 	spi_clk: axi-clkgen@44a70000 {
> 		compatible =3D "adi,axi-clkgen-2.00.a";
> 		reg =3D <0x44a70000 0x10000>;
> 		#clock-cells =3D <0>;
> 		clocks =3D <&clkc 15>, <&clkc 15>;
> 		clock-names =3D "s_axi_aclk", "clkin1";
> 		clock-output-names =3D "spi_clk";
> 	};
>=20
> 	axi_spi_engine_0: spi@44a00000 {
> 		compatible =3D "adi,axi-spi-engine-1.00.a";
> 		reg =3D <0x44a00000 0x1000>;
> 		interrupt-parent =3D <&intc>;
> 		interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&clkc 15 &spi_clk>;
> 		clock-names =3D "s_axi_aclk", "spi_clk";
> 		num-cs =3D <1>;
>=20
> 		#address-cells =3D <0x1>;
> 		#size-cells =3D <0x0>;
>=20
> 		adaq4003: adc@0 {
> 			compatible =3D "adi,adaq4003";
> 			reg =3D <0>;
> 			spi-max-frequency =3D <102000000>;
> 			spi-cpha;
> 			pinctrl-names =3D "default", "single";
> 			pinctrl-0 =3D <&pinctrl_spi_default>;
> 			pinctrl-1 =3D <&pinctrl_spi_single>;
> 			vdd-supply =3D <&adc_vdd>;
> 			vio-supply =3D <&adc_vio>;
> 			ref-supply =3D <&adc_vref>;
> 			adi,high-z-input;
> 			adi,gain-milli =3D <454>;
> 		};
> 	};
> };


