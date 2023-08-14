Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6077B68E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjHNKWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjHNKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:22:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A0AF;
        Mon, 14 Aug 2023 03:22:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c3c8adb27so565685966b.1;
        Mon, 14 Aug 2023 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008530; x=1692613330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIm/soAm2sqvo7n3TF3xNos6LhFpQ9euYNbZFzKmPkU=;
        b=k6hfI/wfPtIHB+EYp6RhshoVIrmf5ges7Bl63a1cAdXZvG5iuZRl77T3uf6JhUJOgh
         vZgggOoJKGufco48uihM50+gkApgnMFirUnMJJUdygM4oRPtyDWCSJtlecrjyWbGoAwM
         lKIJewMs33Tk10Lzu+1Gi3cBOa7GicG0kTr/QnxLr0V8yR9xFS6QlutLIL+gYCE7U/vG
         /UwBuC5zr/C/VMBv4U0nlMrDb33Ylt92yjmMAIHTJlsZqyZj53J/ufXVWokiQsNz1KO2
         FVEmqV5Gtp6gAdnI9gwluwmdZNeoP1S4FKTVT/H457kIM4dBV1Y7df2YzJcoFtsQcuF8
         qljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008530; x=1692613330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIm/soAm2sqvo7n3TF3xNos6LhFpQ9euYNbZFzKmPkU=;
        b=GC0Cy/9m3vBqpuGzaYh6GO8vqL3TDDLQzLdEV9j9BYtiWNoj7YFMImmWo2jXpOMkt0
         fJ9gPSNLZPVPvBmY0o5/qsTOLxmr1BF5BHpQPpnGEln0o6m4TD7wGkyG8Ki6q1NAsUnz
         /g4xUUctyUQZXKHaAjm+azdwc3piHNpLjxNbYK4r78W9+uQCfH73CNnd+m8zIOFBsbuT
         4jR9c86B33bCxJoI821Ow/HoG88MPozTk5hYDtuMwb71ieqxaAF2KXZjIQM5JFtqGvde
         b9jZ6SEnmXiM3wC1CIjN1igKrOq4c2T2banNjduddmfzMV5pyW98VlAp0IfITjiA8Pj6
         rAkQ==
X-Gm-Message-State: AOJu0YxeCrnrdfQv6fD138iVPzltwPj+EoZmdWONiawbCo4AFYEbFLRB
        6Dy+rF39mcb9t2m0RTbp4ic=
X-Google-Smtp-Source: AGHT+IHoCjkqf8+sexzP/XhE7NtIvoztCMsYC3dpIhKtsD7s5Hp08+sQY+Ve09sWKURjX5sDhAD+PQ==
X-Received: by 2002:a17:906:116:b0:99c:55c0:ad11 with SMTP id 22-20020a170906011600b0099c55c0ad11mr8225480eje.23.1692008529818;
        Mon, 14 Aug 2023 03:22:09 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm5517911ejq.190.2023.08.14.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:22:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Martin Botka <martin.botka1@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Icenowy Zheng <uwu@icenowy.me>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM &
 boards support
Date:   Mon, 14 Aug 2023 12:22:06 +0200
Message-ID: <7555655.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <C18CZR.UPG8WJSWEO3L2@somainline.org>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <3249535.44csPzL39Z@jernej-laptop> <C18CZR.UPG8WJSWEO3L2@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 13. avgust 2023 ob 18:20:00 CEST je Martin Botka napisal(a):
> On Sun, Aug 13 2023 at 05:52:10 PM +02:00:00, Jernej =C5=A0krabec
>=20
> <jernej.skrabec@gmail.com> wrote:
> > Hi Martin,
> >=20
> > since this will be obviously delayed to 6.7 cycle due to mfd patch
> > not being
> > merged in time, I have few nits below.
> >=20
> > Dne ponedeljek, 07. avgust 2023 ob 16:53:23 CEST je Martin Botka
> >=20
> > napisal(a):
> >>  From: Martin Botka <martin.botka@somainline.org>
> >> =20
> >>  CB1 is Compute Module style board that plugs into Rpi board style
> >>=20
> >> adapter or
> >>=20
> >>  Manta 3D printer boards (M4P/M8P).
> >> =20
> >>  The SoM features:
> >>    - H616 SoC
> >>    - 1GiB of RAM
> >>    - AXP313A PMIC
> >>    - RTL8189FTV WiFi
> >> =20
> >>  Boards feature:
> >>    - 4x USB via USB2 hub (usb1 on SoM).
> >>    - SDcard slot for loading images.
> >>    - Ethernet port wired to the internal PHY. (100M)
> >>    - 2x HDMI 2.0. (Only 1 usable on CB1)
> >>    - Power and Status LEDs. (Only Status LED usable on CB1)
> >>    - 40 pin GPIO header
> >> =20
> >>  Currently working:
> >>    - Booting
> >>    - USB
> >>    - UART
> >>    - MMC
> >>    - Status LED
> >>    - WiFi (RTL8189FS via out of tree driver)
> >> =20
> >>  I didnt want to duplicate things so the manta DTS can also be used
> >>=20
> >> on BTT
> >>=20
> >>  pi4b adapter. CB1 SoM has its own DTSI file in case other boards
> >>=20
> >> shows up
> >>=20
> >>  that accept this SoM.
> >> =20
> >>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>  Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >>  ---
> >> =20
> >>  Changes in V2:
> >>      - Fixed whitespace errors
> >>      - Move UART into carrier boards and BTT Pi
> >>      - Remove usb1-vbus regulator
> >>      - Fix ranges and naming of AXP313A rails
> >>      - Add comment specifying why broken-cd in mmc0 is needed
> >>      - Rename sdio_wifi to wifi
> >>      - Specify in commit description that USB-OTG doesnt work
> >> =20
> >>  Changes in V3:
> >>      - Add missed semicolons
> >>      - Move model string from dtsi to board dts
> >>      - Add cb1 compatible
> >>      - Remove extra empty line
> >> =20
> >>  Changed in V4:
> >>      - Extend the range of vcc-dram to 1.5V (1.35V max caused issues
> >>=20
> >> with
> >>=20
> >>  booting up
> >> =20
> >>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>   .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
> >>   .../sun50i-h616-bigtreetech-cb1.dtsi          | 140
> >>=20
> >> ++++++++++++++++++
> >>=20
> >>   3 files changed, 176 insertions(+)
> >>   create mode 100644
> >> =20
> >>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >>=20
> >> create
> >>=20
> >>  mode 100644
> >>=20
> >> arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >>=20
> >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >>  b/arch/arm64/boot/dts/allwinner/Makefile index
> >>=20
> >> 6a96494a2e0a..7b386428510b
> >>=20
> >>  100644
> >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>  @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-b.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >> =20
> >>  +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >> =20
> >>  diff --git
> >>=20
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >>=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >> new
> >>=20
> >>  file mode 100644
> >>  index 000000000000..dbce61b355d6
> >>  --- /dev/null
> >>  +++
> >>=20
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> >>=20
> >>  @@ -0,0 +1,35 @@
> >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>  +/*
> >>  + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> >>  + */
> >>  +
> >>  +/dts-v1/;
> >>  +
> >>  +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> >>  +
> >>  +/ {
> >>  +	model =3D "BigTreeTech CB1";
> >>  +	compatible =3D "bigtreetech,cb1-manta", "bigtreetech,cb1",
> >>  "allwinner,sun50i-h616"; +
> >>  +	aliases {
> >>  +		serial0 =3D &uart0;
> >>  +	};
> >>  +
> >>  +	chosen {
> >>  +		stdout-path =3D "serial0:115200n8";
> >>  +	};
> >>  +};
> >>  +
> >>  +&ehci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&uart0 {
> >>  +	pinctrl-names =3D "default";
> >>  +	pinctrl-0 =3D <&uart0_ph_pins>;
> >>  +	status =3D "okay";
> >>  +};
> >>  diff --git
> >>=20
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >>=20
> >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >>=20
> >> new file
> >>=20
> >>  mode 100644
> >>  index 000000000000..5e756f217813
> >>  --- /dev/null
> >>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> >>  @@ -0,0 +1,140 @@
> >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>  +/*
> >>  + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
> >>  + */
> >>  +
> >>  +/dts-v1/;
> >>  +
> >>  +#include "sun50i-h616.dtsi"
> >>  +
> >>  +#include <dt-bindings/gpio/gpio.h>
> >>  +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  +#include <dt-bindings/leds/common.h>
> >>  +
> >>  +/ {
> >>  +	aliases {
> >>  +		ethernet0 =3D &rtl8189ftv;
> >>  +	};
> >>  +
> >>  +	leds {
> >>  +		compatible =3D "gpio-leds";
> >>  +
> >>  +		led-0 {
> >>  +			function =3D LED_FUNCTION_STATUS;
> >>  +			color =3D <LED_COLOR_ID_GREEN>;
> >>  +			gpios =3D <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5
> >=20
> > */
> >=20
> >>  +		};
> >>  +	};
> >>  +
> >>  +	reg_vcc5v: regulator-vcc5v {
> >>  +		/* board wide 5V supply from carrier boards */
> >>  +		compatible =3D "regulator-fixed";
> >>  +		regulator-name =3D "vcc-5v";
> >>  +		regulator-min-microvolt =3D <5000000>;
> >>  +		regulator-max-microvolt =3D <5000000>;
> >>  +		regulator-always-on;
> >>  +	};
> >>  +
> >>  +	reg_vcc33_wifi: vcc33-wifi {
> >>  +		/* Always on 3.3V regulator for WiFi */
> >=20
> > Please drop the comment. It's pretty obvious from properties.
> >=20
> >>  +		compatible =3D "regulator-fixed";
> >>  +		regulator-name =3D "vcc33-wifi";
> >>  +		regulator-min-microvolt =3D <3300000>;
> >>  +		regulator-max-microvolt =3D <3300000>;
> >>  +		regulator-always-on;
> >>  +		vin-supply =3D <&reg_vcc5v>;
> >>  +	};
> >>  +
> >>  +	reg_vcc_wifi_io: vcc-wifi-io {
> >>  +		/* Always on 1.8V/300mA regulator for WiFi */
> >=20
> > Ditto.
> >=20
> > Once fixed, you can add:
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Best regards,
> > Jernej
>=20
> Got it for both comments. Will send V5 tomorrow.

You should not send new versions before all discussions are finished, in th=
is=20
case for adxl345. If in doubt, ask, but certainly wait on response.

Best regards,
Jernej

>=20
> Cheers,
> Martin
>=20
> >>  +		compatible =3D "regulator-fixed";
> >>  +		regulator-name =3D "vcc-wifi-io";
> >>  +		regulator-min-microvolt =3D <1800000>;
> >>  +		regulator-max-microvolt =3D <1800000>;
> >>  +		regulator-always-on;
> >>  +		vin-supply =3D <&reg_vcc33_wifi>;
> >>  +	};
> >>  +
> >>  +	wifi_pwrseq: wifi-pwrseq {
> >>  +		compatible =3D "mmc-pwrseq-simple";
> >>  +		clocks =3D <&rtc 1>;
> >>  +		clock-names =3D "ext_clock";
> >>  +		reset-gpios =3D <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> >>  +		post-power-on-delay-ms =3D <200>;
> >>  +	};
> >>  +};
> >>  +
> >>  +&mmc0 {
> >>  +	vmmc-supply =3D <&reg_dldo1>;
> >>  +	/* Card detection pin is not connected */
> >>  +	broken-cd;
> >>  +	bus-width =3D <4>;
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&mmc1 {
> >>  +	vmmc-supply =3D <&reg_vcc33_wifi>;
> >>  +	vqmmc-supply =3D <&reg_vcc_wifi_io>;
> >>  +	mmc-pwrseq =3D <&wifi_pwrseq>;
> >>  +	bus-width =3D <4>;
> >>  +	non-removable;
> >>  +	mmc-ddr-1_8v;
> >>  +	status =3D "okay";
> >>  +
> >>  +	rtl8189ftv: wifi@1 {
> >>  +		reg =3D <1>;
> >>  +	};
> >>  +};
> >>  +
> >>  +&r_i2c {
> >>  +	status =3D "okay";
> >>  +
> >>  +	axp313a: pmic@36 {
> >>  +		compatible =3D "x-powers,axp313a";
> >>  +		reg =3D <0x36>;
> >>  +		interrupt-controller;
> >>  +		#interrupt-cells =3D <1>;
> >>  +
> >>  +		regulators{
> >>  +			reg_dcdc1: dcdc1 {
> >>  +				regulator-name =3D "vdd-gpu-sys";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <810000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <990000>;
> >=20
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dcdc2: dcdc2 {
> >>  +				regulator-name =3D "vdd-cpu";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <810000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1100000>;
> >=20
> >>  +				regulator-ramp-delay =3D <200>;
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dcdc3: dcdc3 {
> >>  +				regulator-name =3D "vcc-dram";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <1350000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1500000>;
> >=20
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_aldo1: aldo1 {
> >>  +				regulator-name =3D "vcc-1v8-pll";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <1800000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <1800000>;
> >=20
> >>  +				regulator-always-on;
> >>  +			};
> >>  +
> >>  +			reg_dldo1: dldo1 {
> >>  +				regulator-name =3D "vcc-3v3-io";
> >>  +				regulator-min-microvolt =3D
> >=20
> > <3300000>;
> >=20
> >>  +				regulator-max-microvolt =3D
> >=20
> > <3300000>;
> >=20
> >>  +				regulator-always-on;
> >>  +			};
> >>  +		};
> >>  +	};
> >>  +};
> >>  +
> >>  +&usbphy {
> >>  +	status =3D "okay";
> >>  +};




