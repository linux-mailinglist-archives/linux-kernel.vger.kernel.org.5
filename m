Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F276EFDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjHCQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHCQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:45:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D41B2;
        Thu,  3 Aug 2023 09:45:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so4824195e9.3;
        Thu, 03 Aug 2023 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691081103; x=1691685903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vup9DJrWLgBJafDZpsoQMxAqDTv2WU7MM0p3FU+Sa1Q=;
        b=pYE5D2l+bHb+9wOmPEqig1/8em3p8wncjszZYAo5HKaYVFkw/Xe1TYnoa8CvXG9OdZ
         ZB+j7I942Fv/JG2phJnfDR+wlthAYh3Z7crAZi3c+XyQsq02705G3GXHNLB1RzBXlwUw
         EyaDZwm9ks7OCUReg5QnIGy3h0DH7Kxd7f7dFvX+txo0CFoXUWBTe6s7497jVmBhTM/Y
         FvZq8x3v51CZx6IoiNQTLZ2ykQAL/XfErD6357CgEvxgr7ellJOBqs6afAuRdJnVl7ct
         4wD3W7lFxbaqn5C99Fc4szkabq2bQ/mqLocA9rgePwVG2tst+4MnajSfGGHLzbeSrkpe
         wi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081103; x=1691685903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vup9DJrWLgBJafDZpsoQMxAqDTv2WU7MM0p3FU+Sa1Q=;
        b=dL2UH7vWa1hZium0P0uro+M+3NN3kC6nkcTZqqtboVSOJeSEWuA9zuZGp9t+eNiesz
         v9vwS63Ff3zbiIM5/NWN3UDV46TB+pR20J7X1KYrTvCPn0GBrXp8ow++0nuZ2yXdGPmv
         Gaa0YGd5X8byAt1eoceL1PuFtIrW5ruE4QkoX8+OPxTEDCu6/BI5+rkg66cRh4AJX1tM
         /yQmA9K66/LOxhGfJLvnqhfkkw8gzFbHGN62hOSByCd1Yf47f1TT2epLfnPOntBx7xNV
         uG6IQhWgXrjSFrQ+aFin2dUiobj7j9HVPFUxlascm6RTHFxNBgr9t8wlkRQKojz2rsfw
         PBYA==
X-Gm-Message-State: ABy/qLaf5e3WisKCkIuUWLFUEMe+qtIZgabdcXKJSWZ3/k18hZe2TTji
        H++sgHZsdM+dW+8PW84pcOs=
X-Google-Smtp-Source: APBJJlGYubz2EzY9+HvkJH5sOgw8FRnplC0rTpKNtFMT6hzi5LJPusm0JJSEDzSl3JtmQpQPQsho/Q==
X-Received: by 2002:a05:600c:2210:b0:3fc:2d2:caa8 with SMTP id z16-20020a05600c221000b003fc02d2caa8mr8072001wml.29.1691081102916;
        Thu, 03 Aug 2023 09:45:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm298617wro.3.2023.08.03.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:45:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM &
 boards support
Date:   Thu, 03 Aug 2023 18:44:59 +0200
Message-ID: <4820138.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <4272045580294B4A+21851d6a-9a8f-8141-bc31-8398a03663c9@biqu3d.com>
References: <20230802220309.163804-1-martin@biqu3d.com>
 <20230803133746.20cd7b04@donnerap.manchester.arm.com>
 <4272045580294B4A+21851d6a-9a8f-8141-bc31-8398a03663c9@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 03. avgust 2023 ob 17:35:55 CEST je Martin Botka napisal(=
a):
> On 8/3/23 2:37=E2=80=AFPM, Andre Przywara wrote:
> > On Thu,  3 Aug 2023 00:02:38 +0200
> > Martin Botka <martin@biqu3d.com> wrote:
> >=20
> > Hi Martin,
> >=20
> > thanks for sending this!
> > There are some whitespace errors in here, some leading tabs in the first
> > section. "git show" should print them in red.
> >=20
> >> From: Martin Botka <martin.botka@somainline.org>
> >>=20
> >> CB1 is Compute Module style board that plugs into Rpi board style adap=
ter
> >> or Manta 3D printer boards (M4P/M8P).
> >>=20
> >> The SoM features:
> >>    - H616 SoC
> >>    - 1GiB of RAM
> >>    - AXP313A PMIC
> >>    - RTL8189FTV WiFi
> >>=20
> >> Boards feature:
> >>    - 4x USB via USB2 hub (usb1 on SoM).
> >>    - SDcard slot for loading images.
> >>    - Ethernet port wired to the internal PHY. (100M)
> >>    - 2x HDMI 2.0. (Only 1 usable on CB1)
> >>    - Power and Status LEDs. (Only Status LED usable on CB1)
> >>    - 40 pin GPIO header
> >>=20
> >> Currently working:
> >>    - Booting
> >>    - USB
> >>    - UART
> >>    - MMC
> >>    - Status LED
> >>    - WiFi (RTL8189FS via out of tree driver)
> >>=20
> >> I didnt want to duplicate things so the manta DTS can also be used on =
BTT
> >> pi4b adapter. CB1 SoM has its own DTSI file in case other boards shows
> >> up that accept this SoM.
> >>=20
> >> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >> ---
> >>=20
> >>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>   .../sun50i-h616-bigtreetech-cb1-manta.dts     |  20 +++
> >>   .../sun50i-h616-bigtreetech-cb1.dtsi          | 164 ++++++++++++++++=
++
> >>   3 files changed, 185 insertions(+)
> >>   create mode 100644
> >>   arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >>   create mode 100644
> >>   arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi>>=20
> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >> b/arch/arm64/boot/dts/allwinner/Makefile index
> >> 6a96494a2e0a..7b386428510b 100644
> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> >>=20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-b.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >>=20
> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >>=20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >>=20
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >> new file mode 100644
> >> index 000000000000..dff5b592a97a
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.=
dts
> >> @@ -0,0 +1,20 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >> +/*
> >> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> >> +
> >> +/ {
> >> +	compatible =3D "bigtreetech,cb1-manta", "bigtreetech,cb1",
> >> "allwinner,sun50i-h616"; +};
> >> +
> >> +&ehci1 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ohci1 {
> >> +	status =3D "okay";
> >> +};
> >=20
> > So how is the STM32 connected? Via SPI? If yes, you should activate the
> > SPI
> > node and specify the pinctrl.
> > Even if this requires a patch cable to connect the SPI header coming fr=
om
> > the CB1 to the SPI pins on the STM (does it?), it might be worth stating
> > the pins used. I don't know for sure if we enable interfaces that are
> > routed to fixed function header pins, but it might be worth doing so he=
re,
> > since this is some very obvious use case (I guess you wouldn't buy the =
M8P
> > if you don't plan to use all of its goodies).
>=20
> So the STM32 chip is connected directly via USB. There is USB hub on
> Manta boards and Pi adapter (Not on BTT Pi. That one doesnt use USB hub)
> that uses this USB port and STM32 connects via that. Then on manta
> boards there are 2 USB ports and 1 USB port with just pins exposed on
> XH2.54 4 pin connector. Bit weird but it is what it is :)
>=20
> > And what's the USB-C connector doing? Is that an alternative power supp=
ly?
> > Ann does it connect the port0 D-/D+ pins, so can be used for OTG? If ye=
s,
> > please enable the usb_otg node here.
>=20
> It is indeed an alternative power supply. Or well primary supply in the
> case of Pi adapter board.
>=20
> It should be connected yes. Tho i never really had much luck getting it
> to work. Tho i will check again and if i get it to work i will enable it
> in V2 :)
>=20
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi new
> >> file mode 100644
> >> index 000000000000..e630114f0ce4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >> @@ -0,0 +1,164 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >> +/*
> >> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sun50i-h616.dtsi"
> >> +
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/leds/common.h>
> >> +
> >> +/ {
> >> +	model =3D "BigTreeTech CB1";
> >> +	compatible =3D "bigtreetech,cb1", "allwinner,sun50i-h616";
> >> +
> >> +	aliases {
> >> +		serial0 =3D &uart0;
> >> +		ethernet0 =3D &rtl8189ftv;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path =3D "serial0:115200n8";
> >> +	};
> >=20
> > I think stdout-path belongs into the board .dts.
>=20
> Got it
>=20
> >> +
> >> +	leds {
> >> +		compatible =3D "gpio-leds";
> >> +
> >> +		led-0 {
> >> +			function =3D LED_FUNCTION_STATUS;
> >> +			color =3D <LED_COLOR_ID_GREEN>;
> >> +			gpios =3D <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5=20
*/
> >> +		};
> >> +	};
> >> +
> >> +	reg_vcc5v: regulator-vcc5v {
> >> +		/* board wide 5V supply directly from the USB-C socket=20
*/
> >=20
> > I guess this "regulator" is still valid, but please adjust the comment,
> > since there is certainly no USB-C socket on the SoM. I guess it's multi=
ple
> > pins on the SoM connector that supply the incoming base voltage?
>=20
> Correct. Its just pins that get the 5V power. My fault for saying
> directly from USB-C since it can be from somewhere else :)
>=20
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-5v";
> >> +		regulator-min-microvolt =3D <5000000>;
> >> +		regulator-max-microvolt =3D <5000000>;
> >> +		regulator-always-on;
> >> +	};
> >> +
> >> +	reg_usb1_vbus: regulator-usb1-vbus {
> >=20
> > So is this regulator really on the SoM? Or is it just PC16 on the SoM
> > connector, and the actual regulator chip is on the respective carrier
> > boards?
>=20
> This is my bad. This is completely wrong. The actual regulator is the 5V
> one thats turned on when 5V comes in. Its bit weird but i suppose its
> done that way for USB-OTG. This will be removed in next revision of this
> DTS :)
>=20
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "usb1-vbus";
> >> +		regulator-min-microvolt =3D <5000000>;
> >> +		regulator-max-microvolt =3D <5000000>;
> >> +		vin-supply =3D <&reg_vcc5v>;
> >> +		enable-active-high;
> >> +		gpio =3D <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> >> +	};
> >> +
> >> +	reg_vcc33_wifi: vcc33-wifi {
> >> +		/* Always on 3.3V regulator for WiFi and BT */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc33-wifi";
> >> +		regulator-min-microvolt =3D <3300000>;
> >> +		regulator-max-microvolt =3D <3300000>;
> >> +		regulator-always-on;
> >> +		vin-supply =3D <&reg_vcc5v>;
> >> +	};
> >> +
> >> +	reg_vcc_wifi_io: vcc-wifi-io {
> >> +		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-wifi-io";
> >> +		regulator-min-microvolt =3D <1800000>;
> >> +		regulator-max-microvolt =3D <1800000>;
> >> +		regulator-always-on;
> >> +		vin-supply =3D <&reg_vcc33_wifi>;
> >> +	};
> >> +
> >> +	wifi_pwrseq: wifi-pwrseq {
> >> +		compatible =3D "mmc-pwrseq-simple";
> >> +		clocks =3D <&rtc 1>;
> >> +		clock-names =3D "ext_clock";
> >> +		reset-gpios =3D <&pio 6 18 GPIO_ACTIVE_LOW>;  /* PG18 */
> >> +		post-power-on-delay-ms =3D <200>;
> >> +	};
> >> +};
> >> +
> >> +&mmc0 {
> >> +	vmmc-supply =3D <&reg_dldo1>;
> >> +	broken-cd;
> >=20
> > Is there no card detect switch or is it not wired up, or is it really
> > "broken"? Might be good to have a comment explaining that.
> > And yeah, I also forgot to do this in my Orange Pi Zero3 .dts ;-)
>=20
> Its just straight up not connected. And since documentation specifies
> that this should be set when no card detection is available i set it.
>=20
> Will add a comment specifying that this is due to the pin not being
> connected.
>=20
> >> +	bus-width =3D <4>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&mmc1 {
> >> +	vmmc-supply =3D <&reg_vcc33_wifi>;
> >> +	vqmmc-supply =3D <&reg_vcc_wifi_io>;
> >> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> >> +	bus-width =3D <4>;
> >> +	non-removable;
> >> +	mmc-ddr-1_8v;
> >> +	status =3D "okay";
> >> +
> >> +	rtl8189ftv: sdio_wifi@1 {
> >> +		reg =3D <1>;
> >> +	};
> >> +};
> >> +
> >> +&r_i2c {
> >> +	status =3D "okay";
> >> +
> >> +	axp313a: pmic@36 {
> >> +		compatible =3D "x-powers,axp313a";
> >> +		reg =3D <0x36>;
> >> +		interrupt-controller;
> >> +		#interrupt-cells =3D <1>;
> >> +
> >> +		regulators{
> >> +			reg_dcdc1: dcdc1 {
> >> +				regulator-name =3D "vdd-gpu";
> >> +				regulator-min-microvolt =3D=20
<500000>;
> >> +				regulator-max-microvolt =3D=20
<3400000>;
> >=20
> > So those are the ranges of the PMIC rail, but if this is really connect=
ed
> > to VDD_GPU on the H616, you should limit it to between 0.81V and 0.99V,=
 as
> > described in the H616 datasheet. Otherwise this risks frying the SoC, I
> > guess.
>=20
> The range here should be correct. It is also the sys rail. Since AXP313a
> lacks many rails this was chosen as the sys rail as well.

You should then expand name to "vdd-gpu-sys" or something like that, so it'=
s=20
obvious it's not only gpu, but sys power too. Same with other regulators.

SYS voltage has pretty narow range, right? You should always select stricte=
st=20
min and max limits according to all datasheets or manuals, so stability iss=
ues=20
and frying electronics is avoided.

Best regards,
Jernej

>=20
> >> +				regulator-always-on;
> >=20
> > So is this connected to something else as well, like VDD_SYS? Please
> > either mention this as a comment, to justify the always-on, or name the
> > regulator accordingly, like "vdd-gpu-sys".
>=20
> Will rename to vdd-gpu-sys.
>=20
> >> +			};
> >> +
> >> +			reg_dcdc2: dcdc2 {
> >> +				regulator-name =3D "vdd-cpu";
> >> +				regulator-min-microvolt =3D=20
<500000>;
> >> +				regulator-max-microvolt =3D=20
<1540000>;
> >=20
> > Same limit problem here, VDD_CPU must be between 0.81V and 1.1V.
>=20
> That is indeed right. I will test it on the range you provided with OPP
> (WIP) and stress test it :)
>=20
> >> +				regulator-ramp-delay =3D <200>;
> >> +				regulator-always-on;
> >> +			};
> >> +
> >> +			reg_dcdc3: dcdc3 {
> >> +				regulator-name =3D "vcc-dram";
> >> +				regulator-min-microvolt =3D=20
<500000>;
> >> +				regulator-max-microvolt =3D=20
<1840000>;
> >=20
> > Is that DDR3 or DDR3L DRAM here? I don't think there is any runtime
> > adjustments here, so just specify the respective voltage required, with
> > the
> > same value for both min and max.
>=20
> it uses Kingston D2516ECMDXGJD so DDR3. I will specify the direct voltage.
>=20
> >> +				regulator-always-on;
> >> +			};
> >> +
> >> +			reg_aldo1: aldo1 {
> >> +				regulator-name =3D "vcc-1v8";
> >> +				regulator-min-microvolt =3D=20
<1800000>;
> >> +				regulator-max-microvolt =3D=20
<1800000>;
> >> +				regulator-always-on;
> >=20
> > Please mention what this supplies that justifies always-on.
>=20
> ALDO1 1.8V gets also converted to 1.8V for DRAM. Thus needs to be on alwa=
ys.
> >> +			};
> >> +
> >> +			reg_dldo1: dldo1 {
> >> +				regulator-name =3D "vcc-3v3";
> >> +				regulator-min-microvolt =3D=20
<3300000>;
> >> +				regulator-max-microvolt =3D=20
<3300000>;
> >> +				regulator-always-on;
> >=20
> > Please mention what this supplies that justifies always-on.
>=20
> SDcard that serves as storage for system. Will add comments for both :)
>=20
> >> +			};
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&uart0 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&uart0_ph_pins>;
> >> +	status =3D "okay";
> >> +};
> >=20
> > This belongs into the board .dts, since the connector/UART bridge is
> > there.
>=20
> Actually the SoM has exposed pads to connect UART (Which is what i have
> done to get UART) but also the boards get the exact pins wired to GPIO.
>=20
> But since most users would use the GPIO UART i will specify it in
> carrier boards and in BTT Pi boards separately.
>=20
> Cheers,
> Martin
>=20
> > Cheers,
> > Andre
> >=20
> >> +
> >> +&usbphy {
> >> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> >> +	status =3D "okay";
> >> +};




