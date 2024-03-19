Return-Path: <linux-kernel+bounces-106844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280187F45F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E05B21647
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82B7A5F;
	Tue, 19 Mar 2024 00:08:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E514816;
	Tue, 19 Mar 2024 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806913; cv=none; b=qDJDNhkNQS0F9seKoFjWaLx3Mc0RAWLKew5RI3XEFbl2EyMaUzSUNIZrHXdyJyX0WeqzK0wjLY/HWdEICOSsUwGFiDjr+5eYy+ZpfOymLkg+jBVav52D2VJc8X6e+Jjxjjxs6fwPRyz+LsM+ZJ0c2fZK/EEVtwWl+yOFVKDZgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806913; c=relaxed/simple;
	bh=KLFHOn1KlB+TAYnSKf9cdfvSb/WrtPnPmiF4gb+ZKqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcrrM40GI0DvoPKJKWwlAr3ixFhxRw4jVk2bpaT2bec8M2uxXZLf/pu0u5vq63dCkvEdOwEW5sg0OamWInHWK8TGSFnVkskSEDdkUXuVN7llnJziB7OoTL0UiIp1qcBe9hPkgkHYLIXPil7noSJFM7xf7fKwtKyTlw9j0AZ5qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432FCDA7;
	Mon, 18 Mar 2024 17:09:03 -0700 (PDT)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089573F762;
	Mon, 18 Mar 2024 17:08:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:08:05 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Kamil Kasperski <ressetkk@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
Message-ID: <20240319000805.42ae84ac@minigeek.lan>
In-Reply-To: <6ed87122-22ff-4d71-a6e6-06b578212f00@gmail.com>
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
	<20240317-add-t95-axp313-support-v3-3-0d63f7c23d37@gmail.com>
	<20240318114257.46667aef@donnerap.manchester.arm.com>
	<6ed87122-22ff-4d71-a6e6-06b578212f00@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024 00:28:43 +0100
Kamil Kasperski <ressetkk@gmail.com> wrote:

Hi Kamil,

> W dniu 18.03.2024 o=C2=A012:42, Andre Przywara pisze:
> > On Sun, 17 Mar 2024 20:44:51 +0100
> > Kamil Kasperski <ressetkk@gmail.com> wrote:
> >
> > Hi Kamil,
> >
> > thanks a lot for putting together those patches and sending them
> > for upstream inclusion!
> > =20
> >> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP3=
13A
> >> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is=
 not
> >> accessible due to lack of support for H616 NAND controller. =20
> > Them using raw NAND is really unfortunate. I think the original T95 box
> > used eMMC? =20
>=20
> I'm not sure. I don't have access to the other revision of this box.

That's alright, I was just curious. I think Jernej has such an early
box, and IIRC he used mostly the X96 Mate DT with it, so I was assuming
it has eMMC.
=20
> > =20
> >> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
> >>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 ++++++++++++=
+++++++++
> >>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++=
++++
> >>  3 files changed, 195 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/=
dts/allwinner/Makefile
> >> index 21149b346a60..294921f12b73 100644
> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mi=
ni.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-t95max-axp313.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-longanpi-3h.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-orangepi-zero2w.dtb
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> >> new file mode 100644
> >> index 000000000000..815cf2dac24b
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> >> @@ -0,0 +1,109 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> >> + *
> >> + * Common DT nodes for H616-based T95 TV boxes
> >> + * There are two versions reported with different PMIC variants.
> >> + */
> >> +
> >> +#include "sun50i-h616.dtsi"
> >> +
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +
> >> +/ {
> >> +	aliases {
> >> +		ethernet1 =3D &sdio_wifi;
> >> +		serial0 =3D &uart0;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path =3D "serial0:115200n8";
> >> +	};
> >> +
> >> +	reg_vcc5v: vcc5v {
> >> +		/* board wide 5V supply directly from the DC input */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-5v";
> >> +		regulator-min-microvolt =3D <5000000>;
> >> +		regulator-max-microvolt =3D <5000000>;
> >> +		regulator-always-on;
> >> +	};
> >> +
> >> +	reg_vcc3v3: vcc3v3 {
> >> +		/* discrete 3.3V regulator */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-3v3";
> >> +		regulator-min-microvolt =3D <3300000>;
> >> +		regulator-max-microvolt =3D <3300000>;
> >> +		regulator-always-on;
> >> +	};
> >> +
> >> +	wifi_pwrseq: wifi-pwrseq { =20
> > Krzysztof recently sent a patch to just use "pwrseq" as the node name,
> > so can you do the same here?
> >
> > https://lore.kernel.org/linux-sunxi/20240317184130.157695-2-krzysztof.k=
ozlowski@linaro.org/T/#u =20
>=20
> Sure. I'll send v4.
>=20
> > =20
> >> +		compatible =3D "mmc-pwrseq-simple";
> >> +		clocks =3D <&rtc CLK_OSC32K_FANOUT>;
> >> +		clock-names =3D "ext_clock";
> >> +		pinctrl-0 =3D <&x32clk_fanout_pin>;
> >> +		pinctrl-names =3D "default";
> >> +		reset-gpios =3D <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> >> +	};
> >> +};
> >> +
> >> +&ehci0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ehci2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ir {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&mmc0 {
> >> +	cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> >> +	bus-width =3D <4>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&mmc1 {
> >> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> >> +	bus-width =3D <4>;
> >> +	non-removable;
> >> +	status =3D "okay";
> >> +
> >> +	sdio_wifi: wifi@1 {
> >> +		reg =3D <1>;
> >> +	}; =20
> > So does the WiFi work with mainline drivers? IIUC the BCM43342 is not
> > supported by the existing Broadcom drivers? =20
>=20
> It's actually BCM43342/1 It System doesn't detect this chip by default.
> The most relevant message from dmesg is:
> [=C2=A0=C2=A0 14.042035] kernel: brcmfmac: brcmf_fw_alloc_request: Unknow=
n chip BCM43342/1
> I believe that it's only a matter of missing module. I don't think it is
> supported in mainline ATM. I left it to have a wi-fi node accessible
> and detectable by kernel. If you think that it's better to remove the
> node if it's not supported I can do it.

No, that's fine, I was just curious. But another thing to consider are
any GPIOs connected to the module, for reset and wakeup. Do you have a
dump of the vendor firmware DT somewhere? At least this information in
there seems reliable.
You should be able to access the loaded DTB via /sys/firmware/fdt, then
can decompile that with dtc. Look for properties ending in -gpios,
related to WiFi/WLAN.

> Somebody actually extracted modified precompiled module from custom
> 5.15.16 rockchip kernel, which implements support for this card. There's =
no
> patch for it that could be submitted to mainline unfortunately ATM.
>=20
> I've found a patch that adds chip id strings to brcmfmac, but I would lik=
e to
> test it beforehand.

Sure, using the SDIO ID it should autodetect it, and mainline Linux not
(yet) supporting it is strictly speaking not a reason to not describe
it in the DT - only that we would like to test it somehow, of course.
So if in doubt leave it as it is, that should not hurt in any case.

> >> +};
> >> +
> >> +&ohci0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ohci2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&uart0 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&uart0_ph_pins>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&uart1 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> >> +	uart-has-rtscts;
> >> +	status =3D "okay"; =20
> > Similar question here, what is the Bluetooth situation in mainline? I
> > guess it's not supported, since you didn't put a BT node in here? =20
>=20
> I haven't tested that yet. It's partially due to lack of experience with
> DTS. I would like to figure out mainline support eventually, but for now
> I would like to just have a working foundation for these TVB.
>=20
> If that's also not really a wanted option to leave those nodes, I can
> remove them for now.

No, again that's fine from a pure DT perspective. The information above
seems accurate. But again there might be GPIOs at play here, something
to look out for in the vendor DT.
In my experience the BT seem to be easier to support. Even for combined
modules you might have luck and see BT working, even when WiFi does not.
But again, just leave it as it is now, we can always add that later,
that should not block the submission.

> >> +};
> >> +
> >> +&usbotg {
> >> +	dr_mode =3D "host";	/* USB A type receptable */
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&usbphy {
> >> +	status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.d=
ts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> >> new file mode 100644
> >> index 000000000000..c8650aca2407
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> >> @@ -0,0 +1,85 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> >> + *
> >> + * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-=
v3.0
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sun50i-h616-t95.dtsi"
> >> +
> >> +/ {
> >> +	model =3D "T95 5G (AXP313)";
> >> +	compatible =3D "t95,t95max-axp313", "allwinner,sun50i-h616";
> >> +};
> >> +
> >> +&mmc0 {
> >> +	vmmc-supply =3D <&reg_dldo1>;
> >> +};
> >> +
> >> +&mmc1 {
> >> +	vmmc-supply =3D <&reg_dldo1>;
> >> +	vqmmc-supply =3D <&reg_aldo1>;
> >> +};
> >> +
> >> +&r_i2c {
> >> +	status =3D "okay";
> >> +
> >> +	axp313: pmic@36 {
> >> +		compatible =3D "x-powers,axp313a";
> >> +		reg =3D <0x36>;
> >> +		#interrupt-cells =3D <1>;
> >> +		interrupt-controller;
> >> +		interrupt-parent =3D <&pio>; =20
> > I don't think you need interrupt-parent unless you also actually specify
> > an interrupt line.
> > (But please keep #interrupt-cells and interrupt-controller.) =20
>=20
> I think you may be right. I based this part off of OPiZ3 dts, rather than
> transpeed. Will update in the v4.

Thanks!

Cheers,
Andre
 =20
> >> +
> >> +		vin1-supply =3D <&reg_vcc5v>;
> >> +		vin2-supply =3D <&reg_vcc5v>;
> >> +		vin3-supply =3D <&reg_vcc5v>;
> >> +
> >> +		regulators {
> >> +			reg_aldo1: aldo1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <1800000>;
> >> +				regulator-max-microvolt =3D <1800000>;
> >> +				regulator-name =3D "vcc1v8";
> >> +			};
> >> +
> >> +			reg_dldo1: dldo1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <3300000>;
> >> +				regulator-max-microvolt =3D <3300000>;
> >> +				regulator-name =3D "vcc3v3";
> >> +			};
> >> +
> >> +			reg_dcdc1: dcdc1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <810000>;
> >> +				regulator-max-microvolt =3D <990000>;
> >> +				regulator-name =3D "vdd-gpu-sys";
> >> +			};
> >> +
> >> +			reg_dcdc2: dcdc2 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <810000>;
> >> +				regulator-max-microvolt =3D <1100000>;
> >> +				regulator-name =3D "vdd-cpu";
> >> +			};
> >> +
> >> +			reg_dcdc3: dcdc3 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <1500000>;
> >> +				regulator-max-microvolt =3D <1500000>;
> >> +				regulator-name =3D "vdd-dram";
> >> +			};
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&pio {
> >> +	vcc-pc-supply =3D <&reg_aldo1>;
> >> +	vcc-pf-supply =3D <&reg_dldo1>;
> >> +	vcc-pg-supply =3D <&reg_dldo1>; =20
> > So if vqmmc-supply for MMC1 is at the 1.8V from ALDO1, that must mean t=
hat
> > the whole of PortG is at 1.8V, right? So I think this would need to be
> > reg_aldo1 here.
> >
> > Apart from those minor things it looks good to me.
> >
> > Cheers,
> > Andre =20
>=20
> Good catch. Will update in v4.
>=20
> Cheers,
> Kamil
>=20
> >> +	vcc-ph-supply =3D <&reg_dldo1>;
> >> +	vcc-pi-supply =3D <&reg_dldo1>;
> >> +};
> >> =20
>=20
>=20


